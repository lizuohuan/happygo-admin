package com.magicbeans.happygo.controller.admin;


import com.alibaba.druid.util.StringUtils;
import com.magicbeans.base.Pages;
import com.magicbeans.base.ajax.ResponseData;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.Admin;
import com.magicbeans.happygo.entity.Order;
import com.magicbeans.happygo.entity.User;
import com.magicbeans.happygo.service.IOrderService;
import com.magicbeans.happygo.service.IRoleService;
import com.magicbeans.happygo.service.ISystemConfigService;
import com.magicbeans.happygo.service.IUserService;
import com.magicbeans.happygo.util.CommonUtil;
import com.magicbeans.happygo.util.StatusConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 用户 前端控制器
 * </p>
 *
 * @author null123
 * @since 2018-02-05
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    
    @Autowired
    private IUserService userService;


    /**
     * 订单列表
     * @param pages 分页工具
     * @param model 返回
     * @param parentName 上级名
     * @param phone 手机号
     * @param nickName 昵称
     * @param idNumber 身份证号码
     * @param status 0：无效/冻结 1：有效
     * @param gender 性别 0：男、1：女
     * @param roleId 角色id
     * @param businessStatus 申请代理商的状态 0 申请中  1 通过  2 拒绝通过
     * @return
     */
    @GetMapping("list")
    public String list(Pages pages, Model model, String parentName ,String phone,
                       String nickName,String idNumber ,Integer status ,Integer gender,
                       Integer roleId,Integer businessStatus ){
        Map<String ,Object> map = new HashMap<>();
        map.put("parentName",parentName);
        map.put("phone",phone);
        map.put("nickName",nickName);
        map.put("idNumber",idNumber);
        map.put("status",status);
        map.put("gender",gender);
        map.put("roleId",roleId);
        map.put("businessStatus",businessStatus);
        model.addAttribute("page", userService.list(pages,map));
        model.addAttribute("parentName", parentName);
        model.addAttribute("phone", phone);
        model.addAttribute("nickName", nickName);
        model.addAttribute("idNumber", idNumber);
        model.addAttribute("status", status);
        model.addAttribute("gender", gender);
        model.addAttribute("roleId", roleId);
        model.addAttribute("businessStatus", businessStatus);
        return "view/user/list";
    }

    /**
    * 跳转添加页面
    * @return
    */
    @GetMapping("add")
    public String toAdd(Model model){
        return "user/add";
    }


    /**
    * 编辑
    * @param id
    * @param model
    * @return
    */
    @GetMapping("edit")
    public String edit(@RequestParam String id, Model model){
        model.addAttribute("user",userService.find(id));
        return "view/user/edit";
    }

    /**
     * 根据ID刪除
     *
     * @param id
     * @return
     */
    @GetMapping(value = "del/{id}")
    @ResponseBody
    public ResponseData del(@PathVariable String id) {
        ResponseData result = new ResponseData();
        userService.delete(id);
        return result;
    }

/**
    * 保存
    *
    * @param user
    * @param model
    * @return
    */
    @PostMapping(value = "save")
    public String save(@Valid User user, Model model, RedirectAttributes redirectAttributes) {
        if (StringUtils.isEmpty(user.getId())) {
            userService.save(user);
        } else {
            userService.update(user);
        }

        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }


    /**
     * 更新用户申请代理商状态
     * @param userId
     * @param businessStatus
     * @return
     */
    @PostMapping("updateBusinessStatus")
    @ResponseBody
    public ResponseData updateBusinessStatus(String userId , Integer businessStatus) throws Exception {
        if (CommonUtil.isEmpty(userId,businessStatus)) {
            return new ResponseData(false,"字段不能为空",null,StatusConstant.FIELD_NOT_NULL);
        }
        User user = userService.find(userId);
        if (CommonUtil.isEmpty(user)) {
            return new ResponseData(false,"未知用户",null,StatusConstant.NO_DATA);
        }
        if (CommonUtil.isEmpty(user.getBusinessStatus())) {
            return new ResponseData(false,"申请状态异常",null,StatusConstant.ORDER_STATUS_ABNORMITY);
        }
        if (!user.getBusinessStatus().equals(0)) {
            return new ResponseData(false,"申请状态异常",null,StatusConstant.ORDER_STATUS_ABNORMITY);
        }
        userService.setAgent(userId,businessStatus);
        return new ResponseData(true,"操作成功",null,StatusConstant.SUCCESS_CODE);
    }
}

