package com.magicbeans.happygo.controller.admin;

import com.alibaba.druid.util.StringUtils;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.SystemConfig;
import com.magicbeans.happygo.service.ISystemConfigService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

/**
 * 系统配置
 * @author lzh
 * @create 2018/2/2 15:47
 */
@Controller
@RequestMapping("systemConfig/")
public class SystemConfigController extends BaseController {

    @Resource
    private ISystemConfigService systemConfigService;


    /**
     * 编辑系统配置
     *
     * @param model
     * @return
     */
    @GetMapping("edit")
    public String edit(Model model) {
        model.addAttribute("systemConfig", systemConfigService.getSystemConfig());
        return "view/systemConfig/edit";
    }

    /**
     * 保存系统配置
     *
     * @param systemconfig
     * @param model
     * @return
     */
    @PostMapping(value = "save")
    public String save(@Valid SystemConfig systemconfig, Model model, RedirectAttributes redirectAttributes) {
        systemConfigService.updateSystemConfig(systemconfig);
        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect ("edit");
    }


}
