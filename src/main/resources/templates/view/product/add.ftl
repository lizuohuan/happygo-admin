<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<!-- begin #content -->
<div ng-app="productApp" ng-controller="controller" ng-cloak id="content" class="content">
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
                    <form class="form-horizontal" action="${base}/product/save"  id="formProduct" method="post">
                        <input type="text" style="display: none" name="id" value="${(product.id)!''}"/>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品分类:</label>
                            <div class="col-md-4">
                                <select class="form-control" name="productCategoryId" id="productCategoryId">
                                    <option value="" >请选择商品分类</option>
                                    [#list productCategoryList as productCategory]
                                        [#if productCategory.childList?? && (productCategory.childList?size > 0)]
                                            <optgroup label="${productCategory.name}">
                                                [#list productCategory.childList as child]
                                                    <option value="${child.id}" [#if child.id ==(product.productCategoryId)!'' ]selected="selected"[/#if]>${child.name}</option>
                                                [/#list]
                                            </optgroup>
                                        [#else ]
                                        [#--<option value="${productCategory.id}" [#if productCategory.id ==(product.productCategoryId)!'' ]selected="selected"[/#if]>${productCategory.name}</option>--]
                                        [/#if]
                                    [/#list]
                                </select>
                                [#--<input type="text" style="display: none" name="productCategoryId" class="form-control" placeholder="分类"  value="${(product.productCategoryId)!''}"/>--]
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品名称:</label>
                            <div class="col-md-4">
                                <input type="text" name="name" class="form-control" placeholder="名称"  value="${(product.name)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品封面图:</label>
                            <div class="col-md-4">
                                <img style="width: 200px;height: auto;" isHave="0" src="${base}/assets/img/uploadImg.png" id="coverImg">
                                <input type="text" name="coverImg" style="display: none" placeholder="名称"  value="${(product.coverImg)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">商品轮播图:</label>
                            <div class="col-md-9">
                                <span id="imgJsonAryStr" style="[#if (product.imgList)?? && (product.imgList)?size > 0]display:block;[#else ]display:none;[/#if]float: left;">
                                    [#if (product.imgList)?? && (product.imgList)?size > 0]
                                        [#list product.imgList as imgUrl]
                                        <div style="text-align: center;float: left;margin-right: 10px">
                                            <img style="width: 200px;height: auto;" src2="${imgUrl}" src="{{ipImg}}/${imgUrl}" name="imgJsonAryStrImg"><br>
                                            <button type="button" class="btn btn-danger delImg" style="margin-top: 10px">删除</button>
                                        </div>
                                        [/#list]
                                    [/#if]

                                </span>
                                <img style="width: 200px;height: auto;" isHave="0" src="${base}/assets/img/uploadImg.png" id="imgJsonAryStrImg">
                                <input type="text" name="imgJsonAryStr" style="display: none"  value="${(product.imgJsonAryStr)!''}"/>
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
                                <script id="editor" type="text/plain" style="width:1024px;height:300px;"></script>
                            </div>
                            <input type="text" name="describe" style="display: none" [#--value="${(product.describe)!''}"--] />
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label"></label>
                            <div class="col-md-6">
                                <button type="button" id="submitBtn" class="btn btn-success m-r-5 m-b-5">保存</button>
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
    var webApp = angular.module('productApp', []);
    webApp.controller("controller", function($scope, $timeout) {
        $scope.ipImg = Global.imageService;
    });
    $(function () {
        var ue = UE.getEditor('editor');
        ue.addListener("ready", function () {
            // editor准备好之后才可以使用
            ue.setContent('${(product.describe)!''}');
        });
        [#--setTimeout(function () {--]
            [#--// ue.setContent($("input[name='describe']").val());--]
            [#--ue.setContent('${(product.describe)!''}');--]
        [#--},500);--]
        var coverImg = "${(product.coverImg)!''}";
        if (null != coverImg && "" != coverImg.trim()) {
            $("#coverImg").attr("src",Global.imageService+"/"+coverImg);
            $("#coverImg").attr("isHave","1");
        }
        $("#coverImg").uploadFile({
            path:"image",
            imageService: Global.imageService,
            uploadUrl: "/upload/images",
            callback:function(data) {
                $("#coverImg").attr("src",Global.imageService+"/"+data[0].sourcePath);
                $("input[name='coverImg']").val(data[0].sourcePath);
                $('#formProduct').data('bootstrapValidator')
                        .updateStatus('coverImg', 'NOT_VALIDATED', null)
                        .validateField('coverImg');
                $("#coverImg").attr("isHave","1");
                console.log(data)
            }
        });

        $("#imgJsonAryStrImg").uploadFile({
            path:"image",
            imageService: Global.imageService,
            uploadUrl: "/upload/images",
            callback:function(data) {
                var html = "<div style=\"text-align: center;float: left;margin-right: 10px\">\n" +
                        "   <img style=\"width: 200px;height: auto;\" src2=\""+data[0].sourcePath+"\" src=\""+Global.imageService+"/"+data[0].sourcePath+"\" name=\"imgJsonAryStrImg\"><br>\n" +
                        "   <button type=\"button\" class=\"btn btn-danger delImg\" id=\"delImg\" style=\"margin-top: 10px\">删除</button>\n" +
                        "</div>";
                $("#imgJsonAryStr").append(html);
                // document.getElementById("imgJsonAryStrImg").style.display = block;
                $("#imgJsonAryStr").css("display","block");
                $("input[name=imgJsonAryStr]").val(data[0].sourcePath);
                $('#formProduct').data('bootstrapValidator')
                        .updateStatus('imgJsonAryStr', 'NOT_VALIDATED', null)
                        .validateField('imgJsonAryStr');

                $(".delImg").click(function () {
                    $(this).parent("div").remove();
                    var imgJsonAryStr = $("#imgJsonAryStr");
                    if (imgJsonAryStr.children("div").length == 0) {
                        // document.getElementById("imgJsonAryStrImg").style.display = "none";
                        $("#imgJsonAryStr").css("display","none");
                        $("input[name=imgJsonAryStr]").val("");
                        $('#formProduct').data('bootstrapValidator')
                                .updateStatus('imgJsonAryStr', 'NOT_VALIDATED', null)
                                .validateField('imgJsonAryStr');
                    }
                });
                console.log(data)
            }
        });

        $(".delImg").click(function () {
            $(this).parent("div").remove();
            var imgJsonAryStr = $("#imgJsonAryStr");
            if (imgJsonAryStr.children("div").length == 0) {
                $("#imgJsonAryStr").css("display","none");
                $("input[name=imgJsonAryStr]").val("");
                $('#formProduct').data('bootstrapValidator')
                        .updateStatus('imgJsonAryStr', 'NOT_VALIDATED', null)
                        .validateField('imgJsonAryStr');
            }
        });


        $("#submitBtn").click(function () {
            $("input[name='describe']").val(ue.getContent());
            var imgJsonAry = [];
            $("img[name='imgJsonAryStrImg']").each(function () {
                imgJsonAry.push($(this).attr("src2"));
            });
            $("input[name='imgJsonAryStr']").val(imgJsonAry.toString());
            $("#formProduct").submit();
        });
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
            $('#formProduct').data('bootstrapValidator')
                    .updateStatus('isPromotion', 'NOT_VALIDATED',null)
                    .validateField('isPromotion');
        });
        $("#isIntegral").change(function () {
            if($(this).is(':checked')) {
                $("input[name='isIntegral']").val(1);
            } else {
                $("input[name='isIntegral']").val(0);
            }
            $('#formProduct').data('bootstrapValidator')
                    .updateStatus('isIntegral', 'NOT_VALIDATED',null)
                    .validateField('isIntegral');
        });
        $("#isHot").change(function () {
            if($(this).is(':checked')) {
                $("input[name='isHot']").val(1);
            } else {
                $("input[name='isHot']").val(0);
            }

        });


        $("#formProduct").bootstrapValidator({
            message:'This value is not valid',
//            定义未通过验证的状态图标
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            excluded:[":disabled"],
//            字段验证
            fields:{
                name:{
                    message:'商品名称非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'商品名称不能为空'
                        }
                    }
                },
                title:{
                    message:'标题非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'标题名不能为空'
                        }
                    }
                },
                coverImg:{
                    message:'商品封面图非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'商品封面图不能为空'
                        }
                    }
                },
                imgJsonAryStr:{
                    message:'商品轮播图非法',
                    validators:{
                        callback: {
                            callback: function(value, validator) {
                                var imgJsonAryStr = $("#imgJsonAryStr");
                                if (imgJsonAryStr.children("div").length == 0) {
                                    return {
                                        valid: false,       // or true
                                        message: '商品轮播图不能为空'
                                    }
                                }
                                return true;
                            }
                        }
                    }
                },
                number:{
                    message:'商品编号非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'商品编号不能为空'
                        }
                    }
                },
                price:{
                    message:'商品价格非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'商品价格不能为空'
                        },
                        regexp:{
                            regexp:/^\d+(\.\d{2})?$/,
                            message:'价格由数字和.组成'
                        }
                    }
                },
                isPromotion:{
                    message:'是否促销非法',
                    validators:{
                        callback: {
                            callback: function(value, validator) {
                                validator.updateStatus("promotionPrice","NOT_VALIDATED").validateField('promotionPrice');
                                return true;
                            }
                        }
                    }
                },
                promotionPrice:{
                    message:'促销价非法',
                    validators:{
                        callback: {
                            callback: function(value, validator) {
                                var isPromotion =  $("input[name='isPromotion']").val();;
                                if (value == "" && isPromotion != null && isPromotion != "" && isPromotion == 1) {
                                    return {
                                        valid: false,       // or true
                                        message: '请填写促销价'
                                    }
                                } else {
                                    return true;
                                }
                            }
                        },
                        regexp:{
                            regexp:/^\d+(\.\d{2})?$/,
                            message:'价格由数字和.组成'
                        }

                    }
                },
                isIntegral:{
                    message:'是否为积分商品非法',
                    validators:{
                        callback: {
                            callback: function(value, validator) {
                                if (value == 1) {
                                    validator.updateStatus("integral","NOT_VALIDATED").validateField('integral');
                                } else {
                                    validator.updateStatus("integral","VALID").validateField('integral');
                                }
                                return true;
                            }
                        }
                    }
                },
                integral:{
                    message:'返还积分非法',
                    validators:{
                        callback: {
                            callback: function(value, validator) {
                                var isIntegral =  $("input[name='isIntegral']").val();;
                                if (value == "" && isIntegral != null && isIntegral != "" && isIntegral == 1) {
                                    return {
                                        valid: false,       // or true
                                        message: '请填写返还积分'
                                    }
                                } else {
                                    return true;
                                }
                            }
                        },
                        regexp:{
                            regexp: /^\+?[1-9][0-9]*$/,
                            message:'返还积分只能为整数'
                        }
                    }
                },
//                 describe:{
//                     message:'商品描述非法',
//                     validators:{
// //                        非空
//                         notEmpty:{
//                             message:'商品描述不能为空'
//                         }
//                     }
//                 },
                // type:{
                //     message:'类型非法',
                //     validators:{
                //         callback: {
                //             message: '请选择类型',
                //             callback: function(value, validator,$field) {
                //                 if (value == "") {
                //                     validator.updateStatus("productId","VALID").validateField('productId');
                //                     validator.updateStatus("link","VALID").validateField('link');
                //                     return {
                //                         valid: false,       // or true
                //                         message: '请选择类型'
                //                     }
                //                 } else {
                //                     if (value == 0) {
                //                         validator.updateStatus("productId","NOT_VALIDATED").validateField('productId');
                //                         validator.updateStatus("link","VALID").validateField('link');
                //                     } else {
                //                         validator.updateStatus("productId","VALID").validateField('productId');
                //                         validator.updateStatus("link","NOT_VALIDATED").validateField('link');
                //                     }
                //                     return true;
                //                 }
                //             }
                //         }
                //     }
                // },
                productCategoryId:{
                    message:'商品分类非法',
                    validators:{
                        callback: {
                            message: '请选择商品分类',
                            callback: function(value, validator) {
                                if (value == "") {
                                    return false;
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        })

    });
</script>
