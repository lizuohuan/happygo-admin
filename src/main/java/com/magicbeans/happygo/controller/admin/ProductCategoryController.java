package com.magicbeans.happygo.controller.admin;

import com.magicbeans.base.Pages;
import com.magicbeans.base.db.Filter;
import com.magicbeans.base.db.Order;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.ProductCategory;
import com.magicbeans.happygo.service.IProductCategoryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 商品分类
 * @author lzh
 * @create 2018/1/30 16:37
 */
@Controller
@RequestMapping("/productCategory/")
public class ProductCategoryController extends BaseController {

    @Resource
    private IProductCategoryService productCategoryService;

    /**
     * 商品分类列表
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String list(Pages page, Model model , String name , Integer parentId){
        List<Filter> filters = new ArrayList<>();
        filters.add(Filter.like("name",name));
        filters.add(Filter.eq("parentId",parentId));
        List<Order> orders = new ArrayList<>();
        orders.add(Order.desc("id"));
        page = productCategoryService.findPage(page,filters,orders);
        model.addAttribute("page",page);
        return "view/productCategory/list";
    }

    /**
     * 跳转到添加页面
     * @return
     */
    @GetMapping("add")
    public String add(Model model){
        List<Filter> filters = new ArrayList<>();
        filters.add(Filter.isNull("parentId"));
        model.addAttribute("productCategoryList",productCategoryService.findList(filters,Order.desc("id")));
        return "view/productCategory/add";
    }

    /**
     * 编辑商品分类信息
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("edit")
    public String edit(String id, Model model) {
        List<Filter> filters = new ArrayList<>();
        filters.add(Filter.isNull("parentId"));
        model.addAttribute("productCategoryList",productCategoryService.findList(filters,Order.desc("id")));
        model.addAttribute("product", productCategoryService.find(id));
        return "view/productCategory/add";
    }



    /**
     * 保存信息
     * @param productCategory
     * @return
     */
    @PostMapping("save")
    public String save(ProductCategory productCategory, RedirectAttributes redirectAttributes){
        if(StringUtils.isEmpty(productCategory.getId())){
            productCategoryService.save(productCategory);
        }else{
            productCategoryService.update(productCategory);
        }
        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }


}
