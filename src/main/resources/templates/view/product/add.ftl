<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<!-- begin #content -->
<div id="content" class="content">
    <!-- begin row -->
    <div class="row">
        <!-- begin col-6 -->
        <div class="col-md-12">
            <!-- begin panel -->
            <div class="panel panel-inverse" data-sortable-id="form-stuff-1">
                <div class="panel-heading">
                    [#if model??]
                        <h4 class="panel-title">编辑商品</h4>
                    [#else ]
                        <h4 class="panel-title">添加商品</h4>
                    [/#if ]
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="${base}/product/save"   method="post">
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品分类:</label>
                            <div class="col-md-4">
                                <select class="form-control" id="productCategoryId">
                                    <option value="" >请选择商品分类</option>
                                    [#list productCategoryList as productCategory]
                                        [#if productCategory.childList?? && (productCategory.childList?size > 0)]
                                            <optgroup label="${productCategory.name}">
                                                [#list productCategory.childList as child]
                                                    <option value="${child.id}" [#if child.id ==(product.productCategoryId)!'' ]selected="selected"[/#if]>${child.name}</option>
                                                [/#list]
                                            </optgroup>
                                        [#else ]
                                        <option value="${productCategory.id}" [#if productCategory.id ==(product.productCategoryId)!'' ]selected="selected"[/#if]>${productCategory.name}</option>
                                        [/#if]
                                    [/#list]
                                </select>
                                <input type="text" style="display: none" name="productCategoryId" class="form-control" placeholder="分类"  value="${(product.productCategoryId)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品名称:</label>
                            <div class="col-md-4">
                                <input type="text" name="name" class="form-control" placeholder="名称"  value="${(product.name)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品编号:</label>
                            <div class="col-md-4">
                                <input type="text" name="number" class="form-control" placeholder="编号"  value="${(product.number)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品价格:</label>
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-addon">￥</span>
                                    <input type="text" name="price" class="form-control" placeholder="商品价格"  value="${(product.price)!''}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">是否促销:</label>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <input type="checkbox" id="isPromotion" [#if (product.isPromotion)?? && product.isPromotion == 1] checked [/#if] aria-label="...">￥
                                        </span>
                                        <input type="text" class="form-control" name="promotionPrice" placeholder="请填写促销价" value="${(product.promotionPrice)!''}" aria-label="...">
                                        <input type="text" style="display: none" name="isPromotion" value="${(product.isPromotion)!''}"/>
                                    </div>
                                </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">是否为积分商品:</label>
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <input type="checkbox" id="isIntegral" [#if (product.isIntegral)?? && product.isIntegral == 1] checked [/#if] aria-label="...">
                                    </span>
                                    <input type="text" class="form-control" name="integral" placeholder="请填写返还积分" value="${(product.integral)!''}" aria-label="...">
                                    <input type="text" style="display: none" name="isIntegral" value="${(product.isIntegral)!''}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">是否为推荐商品:</label>
                            <div class="col-md-4">
                                <input type="checkbox" id="isHot" [#if (product.isHot)?? && product.isHot == 1] checked [/#if]>
                                <input type="text" style="display: none" name="isHot" value="${(product.isHot)!''}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-1 control-label">商品描述:</label>
                            <div class="col-md-4">
                                <input type="text" name="describe" class="form-control" placeholder="描述"  value="${(product.describe)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label"></label>
                            <div class="col-md-6">
                                <button type="submit" class="btn btn-success m-r-5 m-b-5">保存</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <!-- end panel -->
        </div>
        <!-- end col-6 -->

    </div>

</div>

<script>
    $(function () {
        //装配选中的商品分类
        $("#productCategoryId").change(function () {
            $("input[name='productCategoryId']").val($(this).val());
        });
        $("#isPromotion").change(function () {
            if($(this).is(':checked')) {
                $("input[name='isPromotion']").val(1);
            } else {
                $("input[name='isPromotion']").val(0);
            }

        });
        $("#isIntegral").change(function () {
            if($(this).is(':checked')) {
                $("input[name='isIntegral']").val(1);
            } else {
                $("input[name='isIntegral']").val(0);
            }

        });
        $("#isHot").change(function () {
            if($(this).is(':checked')) {
                $("input[name='isHot']").val(1);
            } else {
                $("input[name='isHot']").val(0);
            }

        });
    });
</script>
