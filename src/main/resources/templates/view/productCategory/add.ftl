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
                    <h4 class="panel-title">添加商品分类名</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" id="subFrom" action="${basePath}/productCategory/save" method="post">
                        <div class="form-group">
                            <label class="col-md-1 control-label">分类名: </label>
                            <div class="col-md-6">
                                <input type="text" name="name" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-1 control-label">分类图:</label>
                            <div class="col-md-4">
                                <img style="width: 200px;height: auto;" isHave="0" src="${base}/assets/img/uploadImg.png" id="coverImg">
                                <input type="text" name="icon" style="display: none"   value="${(productCategory.icon)!''}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-1 control-label">上级分类: </label>
                            <div class="col-md-6">
                                <select class="form-control" name="parentId">
                                    <option value="">请选择上级商品分类</option>
                                    [#list productCategoryList as productCategory]
                                        <option value="${productCategory.id}">${productCategory.name}</option>
                                    [/#list]
                                </select>
                            [#--<input type="text" name="parentId" class="form-control"/>--]
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

    var icon = "${(productCategory.icon)!''}";
    if (null != icon && "" != icon.trim()) {
        $("#coverImg").attr("src",Global.imageService+"/"+icon);
        $("#coverImg").attr("isHave","1");
    }

    $("#coverImg").uploadFile({
        path:"image",
        imageService: Global.imageService,
        uploadUrl: "/upload/images",
        callback:function(data) {
            $("#coverImg").attr("src",Global.imageService+"/"+data[0].sourcePath);
            $("input[name='icon']").val(data[0].sourcePath);
            $("#coverImg").attr("isHave","1");
            console.log(data)
        }
    });


    $(function () {
        $("#subFrom").bootstrapValidator({
            message:'This value is not valid',
//            定义未通过验证的状态图标
            feedbackIcons: {/*输入框不同状态，显示图片的样式*/
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
//            字段验证
            fields:{
//                分类名
                name:{
                    message:'分类名非法',
                    validators:{
//                        非空
                        notEmpty:{
                            message:'分类名不能为空'
                        }
                    }
                }
            }
        })
    })
</script>

