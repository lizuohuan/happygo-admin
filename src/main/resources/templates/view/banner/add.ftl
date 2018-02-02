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
                    <form class="form-horizontal" action="${basePath}/banner/save" method="post">
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
                            <div class="col-md-6">
                                <div class="col-md-4">
                                    <img style="width: 200px;height: auto;" isHave="0" src="${base}/assets/img/uploadImg.png" id="bannerImg">
                                    <input type="text" name="img" style="display: none" value=""/>
                                </div>
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
                $("#bannerImg").attr("isHave", "1");
                console.log(data)
            }
        });
        // $("#submitBtn").click(function () {
        //     $("input[name='describe']").val(ue.getContent());
        //     var imgJsonAry = [];
        //     $("img[name='imgJsonAryStrImg']").each(function () {
        //         imgJsonAry.push($(this).attr("src2"));
        //     });
        //     $("input[name='imgJsonAryStr']").val(imgJsonAry.toString());
        //     $("#formProduct").submit();
        // });
    });

</script>
