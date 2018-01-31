package com.magicbeans.happygo.controller.admin;

import com.magicbeans.base.Pages;
import com.magicbeans.base.db.Filter;
import com.magicbeans.base.db.Order;
import com.magicbeans.happygo.Message;
import com.magicbeans.happygo.controller.BaseController;
import com.magicbeans.happygo.entity.Product;
import com.magicbeans.happygo.entity.ProductCategory;
import com.magicbeans.happygo.service.IProductCategoryService;
import com.magicbeans.happygo.service.IProductService;
import com.magicbeans.happygo.util.CommonUtil;
import com.magicbeans.happygo.util.Timestamp;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 商品
 * @author lzh
 * @create 2018/1/30 15:50
 */
@Controller
@RequestMapping("/product/")
public class ProductController extends BaseController {

    @Resource
    private IProductService productService;

    @Resource
    private IProductCategoryService productCategoryService;

    /**
     * 商品列表
     * @param page
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String list(Pages<Product> page, Model model ,String name ,String number ,String productCategoryId,
                       Integer isPromotion ,Integer isIntegral ,Integer isHot ,
                       Long createTimeStart ,Long createTimeEnd){
        List<Filter> filters = new ArrayList<>();
        if (CommonUtil.isEmpty2(name)){
            filters.add(Filter.like("name",name));
            model.addAttribute("name",name);
        }
        if (CommonUtil.isEmpty2(number)){
            filters.add(Filter.like("number",number));
            model.addAttribute("number",number);
        }
        if (CommonUtil.isEmpty2(productCategoryId)){
            filters.add(Filter.like("productCategoryId",productCategoryId));
            model.addAttribute("productCategoryId",productCategoryId);
        }
        if (CommonUtil.isEmpty2(isPromotion)){
            filters.add(Filter.eq("isPromotion",isPromotion));
            model.addAttribute("isPromotion",isPromotion);
        }
        if (CommonUtil.isEmpty2(isIntegral)){
            filters.add(Filter.eq("isIntegral",isIntegral));
            model.addAttribute("isIntegral",isIntegral);
        }
        if (CommonUtil.isEmpty2(isHot)){
            filters.add(Filter.eq("isHot",isHot));
            model.addAttribute("isHot",isHot);
        }
        if (null != createTimeStart) {
            filters.add(Filter.ge("create_time",new Date(createTimeStart)));
            model.addAttribute("createTimeStart", Timestamp.DateTimeStamp(new Date(createTimeStart),"yyyy-MM-dd HH:mm:ss"));
        }
        if (null != createTimeEnd) {
            filters.add(Filter.le("create_time",new Date(createTimeEnd)));
            model.addAttribute("createTimeEnd",Timestamp.DateTimeStamp(new Date(createTimeEnd),"yyyy-MM-dd HH:mm:ss"));
        }
        List<Order> orders = new ArrayList<>();
        orders.add(Order.desc("id"));
        page = productService.findPage(page,filters,orders);

        //获取全部商品分类
        List<ProductCategory> productCategoryList = productCategoryService.findAll();
        for (Product product : page.getRecords()) {
            //设置商品分类名
            product.setProductCategoryName(getProductCategoryName(product.getProductCategoryId(),productCategoryList));
        }
        List<ProductCategory> parentList = getProductCategories();
        model.addAttribute("productCategoryList",parentList);
        model.addAttribute("page",page);
        return "view/product/list";
    }

    /**
     * 跳转到添加页面
     * @return
     */
    @GetMapping("add")
    public String add(Model model){
        //获取全部商品分类
        List<ProductCategory> parentList = getProductCategories();
        model.addAttribute("productCategoryList",parentList);
        return "view/product/add";
    }

    /**
     * 编辑商品信息
     *
     * @param id
     * @param model
     * @return
     */
    @GetMapping("edit")
    public String edit(String id, Model model) {
        List<ProductCategory> parentList = getProductCategories();

        model.addAttribute("productCategoryList",parentList);
        model.addAttribute("product", productService.find(id));
        return "view/product/add";
    }


    /**
     * 保存信息
     * @param product
     * @param model
     * @return
     */
    @PostMapping("save")
    public String save(Product product, Model model, RedirectAttributes redirectAttributes){
        if(StringUtils.isEmpty(product.getId())){
            productService.save(product);
        }else{
            productService.update(product);
        }
        addFlashMessage(redirectAttributes,new Message(Message.Type.success,"保存成功"));
        return redirect("list");
    }

    /**
     * 封装商品分类
     * @return
     */
    private List<ProductCategory> getProductCategories() {
        //获取全部商品分类
        List<ProductCategory> productCategoryList = productCategoryService.findAll();
        //进行封装
        List<ProductCategory> parentList = new ArrayList<>();
        for (int i = 0; i < productCategoryList.size(); i++) {
            if (null == productCategoryList.get(i).getParentId()) {
                parentList.add(productCategoryList.get(i));
                productCategoryList.remove(i);
                i --;
            }
        }
        for (ProductCategory category : parentList) {
            for (int i = 0; i < productCategoryList.size(); i++) {
                if (category.getId().equals(productCategoryList.get(i).getParentId())) {
                    category.getChildList().add(productCategoryList.get(i));
                    productCategoryList.remove(i);
                    i -- ;
                }
            }
        }
        return parentList;
    }

    /**
     * 获取商品分类名
     * @param productCategoryId
     * @param productCategoryList
     * @return
     */
    private String getProductCategoryName(String productCategoryId,List<ProductCategory> productCategoryList) {
        String productCategoryName = "";
        for (ProductCategory category : productCategoryList) {
            if (category.getId().equals(productCategoryId)) {
                productCategoryName = category.getName();
                if (null != category.getParentId() ) {
                    productCategoryName = getProductCategoryName(category.getParentId(),productCategoryList) + "," + productCategoryName;
                }
                break;
            }
        }
        return productCategoryName;
    }


}
