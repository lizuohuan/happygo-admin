package com.magicbeans.happygo.controller.admin;

import com.magicbeans.base.Pages;
import com.magicbeans.base.db.Filter;
import com.magicbeans.base.db.Order;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.ProductCategory;
import com.magicbeans.happygo.service.IProductCategoryService;
import com.magicbeans.happygo.util.CommonUtil;
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
    public String list(Pages<ProductCategory> page, Model model , String name , String parentId){
        List<Filter> filters = new ArrayList<>();
        if (CommonUtil.isEmpty2(name)) {
            filters.add(Filter.like( "name",name));
            model.addAttribute("name",name);
        }
        if (CommonUtil.isEmpty2(parentId)) {
            filters.add(Filter.eq("parentId",parentId));
            model.addAttribute("parentId",parentId);
        }
        List<Order> orders = new ArrayList<>();
        orders.add(Order.desc("id"));
        page = productCategoryService.findPage(page,filters,orders);
        List<Filter> filters2 = new ArrayList<>();
        filters2.add(Filter.isNull("parentId"));
        List<ProductCategory> productCategoryList = productCategoryService.findList(filters2,Order.desc("id"));
        for (ProductCategory category : page.getRecords()) {
            if (CommonUtil.isEmpty2(category.getParentId())) {
                category.setParentName(getProductCategoryName(category.getParentId(),productCategoryList));
            }
        }

        model.addAttribute("productCategoryList",productCategoryList);
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
        model.addAttribute("productCategory", productCategoryService.find(id));
        return "view/productCategory/edit";
    }



    /**
     * 保存信息
     * @param productCategory
     * @return
     */
    @PostMapping("save")
    public String save(ProductCategory productCategory, RedirectAttributes redirectAttributes){
        if (CommonUtil.isEmpty(productCategory.getParentId())) {
            productCategory.setParentId(null);
        }
        if(StringUtils.isEmpty(productCategory.getId())){
            productCategoryService.save(productCategory);
        }else{
            productCategoryService.update(productCategory);
        }
        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }
    /**
     * 获取商品分类上级分类名
     * @param parentId
     * @param productCategoryList
     * @return
     */
    private String getProductCategoryName(String parentId,List<ProductCategory> productCategoryList) {
        String productCategoryName = "";
        for (ProductCategory category : productCategoryList) {
            if (category.getId().equals(parentId)) {
                productCategoryName = category.getName();
                break;
            }
        }
        return productCategoryName;
    }


}
