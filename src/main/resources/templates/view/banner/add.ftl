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
                    <h4 class="panel-title">添加Banner</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" id="subFrom" action="${basePath}/banner/save" method="post">
                        <div class="form-group">
                            <label class="col-md-1 control-label">banner名: </label>
                            <div class="col-md-6">
                                <input type="text" name="name" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">标题: </label>
                            <div class="col-md-6">
                                <input type="text" name="title" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">关联商品: </label>
                            <div class="col-md-6">
                                <select class="form-control" name="productId">
                                    <option value="">请选择商品</option>
                                        [#list productList as product]
                                            <option value="${product.id}">${product.name}</option>
                                        [/#list]
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">banner图: </label>
                            <div class="col-md-4">
                                <img style="width: 200px;height: auto;" isHave="0" src="${base}/assets/img/uploadImg.png" id="bannerImg">
                                <input type="text" name="img" style="display: none" value=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">外链url: </label>
                            <div class="col-md-6">
                                <input type="text" name="link" class="form-control"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">banner类型: </label>
                            <div class="col-md-6">
                                <select class="form-control" name="type" id="type">
                                    <option value="">请选择类型</option>
                                    <option value="0">商品</option>
                                    <option value="1">外链</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label"></label>
                            <div class="col-md-6">
                                <button type="submit" id="submitBtn" class="btn btn-success m-r-5 m-b-5">保存</button>
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

        $("#bannerImg").uploadFile({
            path: "image",
            imageService: Global.imageService,
            uploadUrl: "/upload/images",
            callback: function (data) {
                $("#bannerImg").attr("src", Global.imageService + "/" + data[0].sourcePath);
                $("input[name='img']").val(data[0].sourcePath);
                $('#subFrom').data('bootstrapValidator')
                        .updateStatus('img', 'NOT_VALIDATED', null)
                        .validateField('img');
                $("#bannerImg").attr("isHave", "1");
                console.log(data)
            }
        });
        $("#subFrom").bootstrapValidator({
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
                    message:'banner名非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'banner名不能为空'
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
                img:{
                    message:'banner图非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'banner图不能为空'
                        }
                    }
                },
                type:{
                    message:'类型非法',
                    validators:{
                        callback: {
                            message: '请选择类型',
                            callback: function(value, validator,$field) {
                                if (value == "") {
                                    validator.updateStatus("productId","VALID").validateField('productId');
                                    validator.updateStatus("link","VALID").validateField('link');
                                    return {
                                        valid: false,       // or true
                                        message: '请选择类型'
                                    }
                                } else {
                                    if (value == 0) {
                                        validator.updateStatus("productId","NOT_VALIDATED").validateField('productId');
                                        validator.updateStatus("link","VALID").validateField('link');
                                    } else {
                                        validator.updateStatus("productId","VALID").validateField('productId');
                                        validator.updateStatus("link","NOT_VALIDATED").validateField('link');
                                    }
                                    return true;
                                }
                            }
                        }
                    }
                },
                productId:{
                    message:'商品非法',
                    validators:{
                        callback: {
                            message: '必须选择一个商品',
                            callback: function(value, validator) {
                                var type = $("#type").val();
                                if (value == "" && type != null && type != "" && type == 0) {
                                    return {
                                        valid: false,       // or true
                                        message: '请选择商品'
                                    }
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                link:{
                    message:'外链非法',
                    validators:{
                        callback: {
                            message: '请输入外链',
                            callback: function(value, validator) {
                                var type = $("#type").val();
                                if (value == "" && type != null && type != "" && type == 1) {
                                    return {
                                        valid: false,       // or true
                                        message: '请输入外链'
                                    }
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
            }
        })
    });

</script>
