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
                    <form class="form-horizontal" action="${basePath}/productCategory/save" method="post">
                        <div class="form-group">
                            <label class="col-md-1 control-label">分类名: </label>
                            <div class="col-md-6">
                                <input type="text" name="name" class="form-control"/>
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

