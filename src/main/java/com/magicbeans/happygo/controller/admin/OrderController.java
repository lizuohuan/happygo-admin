package com.magicbeans.happygo.controller.admin;


import com.alibaba.druid.util.StringUtils;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.Admin;
import com.magicbeans.happygo.entity.Order;
import com.magicbeans.happygo.service.ISystemConfigService;
import com.magicbeans.happygo.util.CommonUtil;
import com.magicbeans.happygo.util.StatusConstant;
import org.springframework.web.bind.annotation.*;
import com.magicbeans.base.ajax.ResponseData;
import com.magicbeans.base.Pages;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.magicbeans.happygo.service.IOrderService;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 订单 前端控制器
 * </p>
 *
 * @author null123
 * @since 2018-02-05
 */
@Controller
@RequestMapping("/order")
public class OrderController extends BaseController {

    
    @Autowired
    private  IOrderService orderService;
    @Resource
    private ISystemConfigService systemConfigService;


    /**
     * 订单列表
     * @param pages 分页工具
     * @param model 返回
     * @param orderNumber 订单号
     * @param expressNumber 运单号
     * @param nickName 购买用户
     * @param username 后台操作用户
     * @param status 0：待支付 1：已支付 2：待发货 3：已发货 4：已完成 5：已取消 6：退款中
     * @param payMethod 支付状态 0：支付宝 1：微信 2：欢喜券 3：线下支付
     * @param userIsValid 是否有效  0 无效 1 有效
     * @param adminOk 是否已线下支付
     * @return
     */
    @GetMapping("list")
    public String list(Pages pages, Model model, String orderNumber ,String expressNumber,
                       String nickName,String username ,Integer status ,Integer payMethod,
                       Integer userIsValid,Integer adminOk ){
        Map<String ,Object> map = new HashMap<>();
        map.put("orderNumber",orderNumber);
        map.put("expressNumber",expressNumber);
        map.put("nickName",nickName);
        map.put("username",username);
        map.put("status",status);
        map.put("payMethod",payMethod);
        map.put("userIsValid",userIsValid);
        map.put("adminOk",adminOk);
        model.addAttribute("page", orderService.list(pages,map));
        model.addAttribute("orderNumber", orderNumber);
        model.addAttribute("expressNumber", expressNumber);
        model.addAttribute("nickName", nickName);
        model.addAttribute("username", username);
        model.addAttribute("status", status);
        model.addAttribute("payMethod", payMethod);
        model.addAttribute("userIsValid", userIsValid);
        model.addAttribute("adminOk", adminOk);
        return "view/order/list";
    }

    /**
    * 跳转添加页面
    * @return
    */
    @GetMapping("add")
    public String toAdd(Model model){
        return "order/add";
    }


    /**
    * 编辑Order
    * @param id
    * @param model
    * @return
    */
    @GetMapping("edit")
    public String edit(@RequestParam String id, Model model){
        model.addAttribute("order",orderService.find(id));
        return "view/order/edit";
    }

    /**
     * 根据ID刪除Order
     *
     * @param id
     * @return
     */
    @GetMapping(value = "del/{id}")
    @ResponseBody
    public ResponseData del(@PathVariable String id) {
        ResponseData result = new ResponseData();
        orderService.delete(id);
        return result;
    }

/**
    * 保存Order
    *
    * @param order
    * @param model
    * @return
    */
    @PostMapping(value = "save")
    public String save(@Valid Order order, Model model, RedirectAttributes redirectAttributes) {
        if (StringUtils.isEmpty(order.getId())) {
            orderService.save(order);
        } else {
            orderService.update(order);
        }

        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }

    /**
     * 线下订单更新是否支付状态
     * @param orderId
     * @param adminOk
     * @return
     */
    @RequestMapping("updateAdminOk")
    @ResponseBody
    public ResponseData updateAdminOk(String orderId , Integer adminOk) {
        if (CommonUtil.isEmpty(orderId,adminOk)) {
            return new ResponseData(false,"字段不能为空",null,StatusConstant.FIELD_NOT_NULL);
//            return result.setError(StatusConstant.FIELD_NOT_NULL,"字段不能为空");
        }
        Admin admin = getLoginUser();
        Order order = orderService.find(orderId);
        if (CommonUtil.isEmpty(order)) {
            return new ResponseData(false,"未知订单",null,StatusConstant.NO_DATA);
        }
        if (CommonUtil.isEmpty(order.getPayMethod())) {
            return new ResponseData(false,"支付类型异常或还未支付",null,StatusConstant.ORDER_STATUS_ABNORMITY);
        }
        if (!order.getPayMethod().equals(StatusConstant.PAY_METHOD_UNDER_LINE)) {
            return new ResponseData(false,"此订单不为线下订单",null,StatusConstant.ORDER_STATUS_ABNORMITY);
        }
        orderService.confirmUnderOrder(orderId,admin.getId(),adminOk,systemConfigService.getSystemConfig());
        return new ResponseData(true,"操作成功",null,StatusConstant.SUCCESS_CODE);
    }

    /**
     * 更新订单状态
     * @param orderId
     * @param status
     * @return
     */
    @PostMapping("updateStatus")
    @ResponseBody
    public ResponseData updateStatus(String orderId , Integer status,String expressNumber) {
        if (CommonUtil.isEmpty(orderId,status)) {
            return new ResponseData(false,"字段不能为空",null,StatusConstant.FIELD_NOT_NULL);
        }
        Order order = orderService.find(orderId);
        if (CommonUtil.isEmpty(order)) {
            return new ResponseData(false,"未知订单",null,StatusConstant.NO_DATA);
        }
        if (CommonUtil.isEmpty(order.getStatus())) {
            return new ResponseData(false,"订单状态异常",null,StatusConstant.ORDER_STATUS_ABNORMITY);
        }
        if (status.equals(StatusConstant.ORDER_SENT) &&
                !order.getStatus().equals(StatusConstant.ORDER_WAITING_SEND)) {
            return new ResponseData(false,"订单状态异常",null,StatusConstant.ORDER_STATUS_ABNORMITY);
        } else {
            if (CommonUtil.isEmpty(expressNumber)) {
                return new ResponseData(false,"请录入运单号",null,StatusConstant.FIELD_NOT_NULL);
            }
            //录入快递单号
            order.setExpressNumber(expressNumber);
        }
        order.setStatus(status);
        orderService.update(order);
        return new ResponseData(true,"操作成功",null,StatusConstant.SUCCESS_CODE);
    }
}

