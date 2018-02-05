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
                    <h4 class="panel-title">编辑Banner</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="${basePath}/banner/save" method="post">
                        <input type="hidden" name="id" value="${(banner.id)!''}">
                        <div class="form-group">
                            <label class="col-md-1 control-label">banner名: </label>
                            <div class="col-md-6">
                                <input type="text" name="name" class="form-control" value="${banner.name}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">标题: </label>
                            <div class="col-md-6">
                                <input type="text" name="title" class="form-control" value="${banner.title}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">关联商品: </label>
                            <div class="col-md-6">
                                <select class="form-control" value="${banner.productId}" name="productId">
                                    <option value="">请选择商品</option>
                                        [#list productList as product]
                                            <option value="${product.id}" [#if product.id == (banner.productId)!'' ] selected="selected" [/#if] >${product.name}</option>
                                        [/#list]
                                </select>
                                [#--<input type="text" name="productId" class="form-control" value="${banner.productId}"/>--]
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">banner图: </label>
                            <div class="col-md-6">
                                <img style="width: 200px;height: auto;" isHave="0"
                                     src="${base}/assets/img/uploadImg.png" id="bannerImg">
                                <input type="text" name="img" style="display: none" value="${(banner.img)!''}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">外链url: </label>
                            <div class="col-md-6">
                                <input type="text" name="link" class="form-control" value="${banner.link}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">banner类型: </label>
                            <div class="col-md-6">
                                <select class="form-control" name="type" id="type">
                                    <option value="">请选择类型</option>
                                    <option value="0" [#if 0 == (banner.type)  ] selected="selected" [/#if]>商品</option>
                                    <option value="1" [#if 1 == (banner.type)  ] selected="selected" [/#if]>外链</option>
                                </select>
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
        var bannerImg = "${(banner.img)!''}";
        if (null != bannerImg && "" != bannerImg.trim()) {
            $("#bannerImg").attr("src",Global.imageService+"/"+bannerImg);
            $("#bannerImg").attr("isHave","1");
        }
        $("#bannerImg").uploadFile({
            path: "image",
            imageService: Global.imageService,
            uploadUrl: "/upload/images",
            callback: function (data) {
                $("#bannerImg").attr("src", Global.imageService + "/" + data[0].sourcePath);
                $("input[name='img']").val(data[0].sourcePath);
                $("#bannerImg").attr("isHave", "1");
                console.log(data)
            }
        });
    });

</script>
