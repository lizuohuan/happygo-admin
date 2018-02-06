<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<div id="content" class="content">
    <form id="listForm" action="list" class="form-inline">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                    <div class="panel-heading">
                        <h4 class="panel-title">商品分类列表</h4>
                    </div>
                    <div class="panel-body">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">高级查询</h3>
                            </div>
                            <div class="panel-body form-horizontal">
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">分类名:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="name" class="form-control" placeholder="名称"  value="${(name)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">所属分类:</label>
                                    <select class="form-control" name="parentId">
                                        <option value="" >请选择商品分类</option>
                                        [#list productCategoryList as productCategory2]
                                                <option value="${productCategory2.id}"[#if productCategory2.id == (parentId)!'' ]selected="selected"[/#if]>${productCategory2.name}</option>
                                        [/#list]
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-default">查询</button>
                            </div>
                        </div>
                        <div class="panel panel-default actionPanel">
                        [#--添加操作按钮--]
                        [@shiro.hasPermission name = "system:productCategory:add"]
                            <div class="row m-l-1 ">
                                <a href="${basePath}/productCategory/add" class="btn btn-sm btn-success">添加</a>
                            </div>
                        [/@shiro.hasPermission]

                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th width="70">序号</th>
                                <th>分类名</th>
                                <th>上级分类名</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>

                        [#list  page.records as item]
                        <tr>
                            <td width="70" align="center">${item_index+1}</td>
                            <td> ${item.name!''}</td>
                            <td> ${item.parentName!''}</td>
                            <td>
                                <a href="${basePath}/productCategory/edit?id=${item.id}">
                                    <li class="fa  fa-edit">编辑</li>
                                </a>
                                <a href="javascript:void (0)" class="delete" data-id="${item.id}">
                                    <li class="fa fa-trash">删除</li>
                                </a>
                            </td>
                        </tr>
                        [/#list]
                                            </tbody>
                                        </table>

                    [@pagination pageNumber = page.current totalPages = page.pages]
                        [#include "../../pagination.ftl"]
                    [/@pagination]
                    </div>
                </div>
                <!-- end panel -->
            </div>
            <!-- end col-12 -->
        </div>
    </form>
    <!-- end row -->
</div>

<script type="application/javascript">
    [@flash_message /]

    $(function () {
        $(".delete").click(function () {
            var id = $(this).attr("data-id");
            alertServer.cofirm("确认删除", "删除", function (flag) {
                if (flag)
                    Ajax.Get("${basePath}/productCategory/del/" + id).done(function (res) {
                        Notify.success("删除成功");
                        window.location.reload()
                    }).fail(function (err) {
                        swal("错误", '操作失败', "error")
                    })
            }
        });
    });
    })
</script>
