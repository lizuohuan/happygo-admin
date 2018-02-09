<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<style>
    .form-group{
        margin-bottom: 15px!important;
    }
    @media (min-width: 768px){
        .form-inline .form-control{
            width: 100%;
        }
    }
</style>
<div ng-app="bannerAppList" ng-controller="controller" ng-cloak id="content" class="content">
    <form id="listForm" action="${basePath}/banner/list" class="form-inline">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                    <div class="panel-heading">
                        <h4 class="panel-title">Banner列表</h4>
                    </div>
                    <div class="panel-body">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">高级查询</h3>
                            </div>
                            <div class="panel-body form-horizontal">
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">banner名:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="name" class="form-control" placeholder="名称"  value="${(name)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">标题:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="title" class="form-control" placeholder="标题"  value="${(name)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">商品名称:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="productName" class="form-control" placeholder="商品名称"  value="${(productName)!''}"/>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">类型:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="type">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (type)?? && 0 == type ]selected="selected"[/#if]>商品</option>
                                            <option value="1" [#if (type)?? && 1 == type ]selected="selected"[/#if]>外链</option>
                                        </select>
                                    </div>
                                </div><br>

                                <div class="form-group col-md-4">
                                    <button type="submit" class="btn btn-default">查询</button>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default actionPanel">
                        [#--添加操作按钮--]
                            <div class="row m-l-1 ">
                                <a href="${basePath}/banner/add" class="btn btn-sm btn-success">添加</a>
                            </div>
                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th width="70">序号</th>
                                <th>banner名</th>
                                <th>标题</th>
                                <th>关联商品</th>
                                <th>图片</th>
                                <th>外链url</th>
                                <th>类型</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>

        [#list  page.records as item]
        <tr>
            <td width="70" align="center">${item_index+1}</td>
            <td> ${item.name!''}</td>
            <td> ${item.title!''}</td>
            <td> [#if (item.product)?? ]${(item.product.name)!''}[/#if]</td>
            <td> [#--${(item.img)!''}--][#if (item.img)?? ]<a target="_blank" href="{{ipImg}}/${item.img}"><img style="height: 100px;width: auto" src="{{ipImg}}/${item.img}"></a>[/#if]</td>
            <td> ${item.link!''}</td>
            <td> ${(item.type==0)?string("商品","外链")}</td>
            <td>
                <a href="${basePath}/banner/edit?id=${item.id}">
                    <li class="fa  fa-edit">编辑</li>
                </a>
                [#--<a href="javascript:void (0)" class="delete" data-id="${item.id}">--]
                    [#--<li class="fa fa-trash">删除</li>--]
                [#--</a>--]
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
    var webApp = angular.module('bannerAppList', []);
    webApp.controller("controller", function($scope, $timeout) {
        $scope.ipImg = Global.imageService;
    });
    [@flash_message /]



    $(function () {
        $(".delete").click(function () {
            var id = $(this).attr("data-id");
            alertServer.cofirm("确认删除", "删除", function (flag) {
                if (flag) {
                    Ajax.Get("${basePath}/banner/del/" + id).done(function (res) {
                        Notify.success("删除成功");
                        window.location.reload()
                    }).fail(function (err) {
                        swal("错误", '操作失败', "error")
                    })
                }
            })
        });
    });
</script>
