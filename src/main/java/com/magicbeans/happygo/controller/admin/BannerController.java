package com.magicbeans.happygo.controller.admin;


import com.alibaba.druid.util.StringUtils;
import com.magicbeans.base.db.Filter;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.Banner;
import com.magicbeans.happygo.service.IProductService;
import com.magicbeans.happygo.util.CommonUtil;
import com.magicbeans.happygo.util.Timestamp;
import org.springframework.web.bind.annotation.*;
import com.magicbeans.base.ajax.ResponseData;
import com.magicbeans.base.Pages;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.magicbeans.happygo.service.IBannerService;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.*;

/**
 * <p>
 *  banner
 * </p>
 *
 * @author null123
 * @since 2018-02-02
 */
@Controller
@RequestMapping("/banner")
public class BannerController extends BaseController {

    
    @Autowired
    private  IBannerService bannerService;
    @Resource
    private IProductService productService;


    /**
     * banner列表
     * @param pages 分页参数
     * @param model 返回
     * @param name banner名
     * @param title 标题
     * @param productName 商品名
     * @param type 类型
     * @param createTimeStart 创建的开始时间
     * @param createTimeEnd 创建的结束时间
     * @return
     */
    @GetMapping("list")
    public String list(Pages pages, Model model ,String name,String title,String productName,Integer type,
                       Long createTimeStart ,Long createTimeEnd){
        Map<String ,Object> map = new HashMap<>();
        if (pages.getCurrent() == 1) {
            pages.setCurrent(pages.getCurrent() - 1);
        }
        map.put("name",name);
        map.put("title",title);
        map.put("type",type);
        map.put("productName",productName);
        if (null != createTimeStart) {
            map.put("createTimeStart",new Date(createTimeStart));
            model.addAttribute("createTimeStart", Timestamp.DateTimeStamp(new Date(createTimeStart),"yyyy-MM-dd HH:mm:ss"));
        }
        if (null != createTimeEnd) {
            map.put("createTimeEnd",new Date(createTimeEnd));
            model.addAttribute("createTimeEnd",Timestamp.DateTimeStamp(new Date(createTimeEnd),"yyyy-MM-dd HH:mm:ss"));
        }

        model.addAttribute("name", name);
        model.addAttribute("title", title);
        model.addAttribute("type", type);
        model.addAttribute("productName", productName);
        model.addAttribute("page", bannerService.list(map,pages));
        return "view/banner/list";
    }

    /**
    * 跳转添加页面
    * @return
    */
    @GetMapping("add")
    public String toAdd(Model model){
        model.addAttribute("productList",productService.findAll());
        return "view/banner/add";
    }


    /**
    * 编辑Banner
    * @param id
    * @param model
    * @return
    */
    @GetMapping("edit")
    public String edit(@RequestParam String id, Model model){
        model.addAttribute("productList",productService.findAll());
        model.addAttribute("banner",bannerService.find(id));
        return "view/banner/edit";
    }

    /**
     * 根据ID刪除Banner
     *
     * @param id
     * @return
     */
    @GetMapping(value = "del/{id}")
    @ResponseBody
    public ResponseData del(@PathVariable String id) {
        ResponseData result = new ResponseData();
        bannerService.delete(id);
        return result;
    }

/**
    * 保存Banner
    *
    * @param banner
    * @param model
    * @return
    */
    @PostMapping(value = "save")
    public String save(@Valid Banner banner, Model model, RedirectAttributes redirectAttributes) {
        if (StringUtils.isEmpty(banner.getId())) {
            bannerService.save(banner);
        } else {
            bannerService.update(banner);
        }

        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }


}

