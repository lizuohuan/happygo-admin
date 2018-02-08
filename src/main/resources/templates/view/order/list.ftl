<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<style>
    .form-group {
        margin-bottom: 15px !important;
    }

    @media (min-width: 768px) {
        .form-inline .form-control {
            width: 100%;
        }
    }
</style>
<div ng-app="orderAppList" ng-controller="controller" id="content" class="content">
    <form id="listForm" action="${basePath}/order/list" class="form-inline">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                    <div class="panel-heading">
                        <h4 class="panel-title">订单列表</h4>
                    </div>
                    <div class="panel-body">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">高级查询</h3>
                            </div>
                            <div class="panel-body form-horizontal">
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">订单编号:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="orderNumber" class="form-control" placeholder="订单编号"  value="${(orderNumber)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">运单号:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="expressNumber" class="form-control" placeholder="运单号"  value="${(expressNumber)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">购买用户:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="nickName" class="form-control" placeholder="购买用户"  value="${(nickName)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">后台操作用户:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="username" class="form-control" placeholder="后台操作用户"  value="${(username)!''}"/>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">订单状态:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="status">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (status)?? && 0 == status ]selected="selected"[/#if]>待支付</option>
                                            <option value="1" [#if (status)?? && 1 == status ]selected="selected"[/#if]>已支付-待确认</option>
                                            <option value="2" [#if (status)?? && 2 == status ]selected="selected"[/#if]>待发货</option>
                                            <option value="3" [#if (status)?? && 3 == status ]selected="selected"[/#if]>已发货</option>
                                            <option value="4" [#if (status)?? && 4 == status ]selected="selected"[/#if]>已完成</option>
                                            <option value="5" [#if (status)?? && 5 == status ]selected="selected"[/#if]>已取消</option>
                                            <option value="6" [#if (status)?? && 6 == status ]selected="selected"[/#if]>退款中</option>
                                            <option value="7" [#if (status)?? && 7 == status ]selected="selected"[/#if]>拒绝退款</option>
                                            <option value="8" [#if (status)?? && 8 == status ]selected="selected"[/#if]>已退款</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">支付类型:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="payMethod">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (payMethod)?? && 0 == payMethod ]selected="selected"[/#if]>支付宝</option>
                                            <option value="1" [#if (payMethod)?? && 1 == payMethod ]selected="selected"[/#if]>微信</option>
                                            <option value="2" [#if (payMethod)?? && 2 == payMethod ]selected="selected"[/#if]>欢喜券</option>
                                            <option value="3" [#if (payMethod)?? && 3 == payMethod ]selected="selected"[/#if]>线下支付</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">是否有效:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="payMethod">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (userIsValid)?? && 0 == userIsValid ]selected="selected"[/#if]>无效</option>
                                            <option value="1" [#if (userIsValid)?? && 1 == userIsValid ]selected="selected"[/#if]>有效</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">后台是否确认支付:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="adminOk">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (adminOk)?? && 0 == adminOk ]selected="selected"[/#if]>待确认支付</option>
                                            <option value="1" [#if (adminOk)?? && 1 == adminOk ]selected="selected"[/#if]>已确认支付</option>
                                            <option value="2" [#if (adminOk)?? && 2 == adminOk ]selected="selected"[/#if]>未支付</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <button type="submit" class="btn btn-default">查询</button>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default actionPanel">
                        [#--添加操作按钮--]
                            [#--<div class="row m-l-1 ">--]
                                [#--<a href="${basePath}/order/add" class="btn btn-sm btn-success">添加</a>--]
                            [#--</div>--]
                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th width="70">序号</th>
                                <th>订单编号</th>
                                <th>用户</th>
                                <th style="width: 110px;">订单状态</th>
                                <th style="width: 110px;">收货地址</th>
                                <th>订单总价</th>
                                <th>付款方式</th>
                                <th>运费</th>
                                <th>是否有效</th>
                                <th>流水图</th>
                                <th>后台是否确认</th>
                                <th>后台操作人员</th>
                                <th>快递单号</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>

        [#list  page.records as item]
        <tr>
            <td width="70" align="center">${item_index+1}</td>
            <td> ${item.orderNumber!''}</td>
            <td> ${item.nickName!''}</td>
            <td style="width: 110px;"> ${item.statusStr!''}</td>
            <td style="width: 110px;"> ${item.address!''}</td>
            <td> ${item.price!''}</td>
            <td> ${item.payMethodStr!''}</td>
            <td> ${item.freight!''}</td>
            <td> ${(item.userIsValid==1)?string("有效","无效")}</td>
            <td> [#--${item.bankImg!''}--][#if (item.bankImg)?? ]<a target="_blank" href="{{ipImg}}/${item.bankImg}"><img style="height: 100px;width: auto" src="{{ipImg}}/${item.bankImg}"></a>[/#if]</td>
            <td> ${item.adminOkStr!''}</td>
            <td> ${item.username!''}</td>
            <td> ${item.expressNumber!''}</td>
            <td>
                [#--<a href="${basePath}/order/edit?id=${item.id}">--]
                    [#--<li class="fa  fa-edit">编辑</li>--]
                [#--</a>--]
                [#if (item.payMethod)?? && (item.payMethod) == 3]
                    [#if (item.adminOk)?? && (item.adminOk) == 0]
                        <a href="javascript:void (0)" class="updateAdminOk" data-id="${item.id}" data-adminOk="1">
                            <li class="fa fa-trash">确认支付</li>
                        </a>
                        <a href="javascript:void (0)" class="updateAdminOk" data-id="${item.id}" data-adminOk="2">
                            <li class="fa fa-trash">未支付</li>
                        </a>
                    [/#if]
                [/#if]
                [#if (item.status)?? && (item.status) == 2]
                        <a href="javascript:void (0)" class="updateStatus" data-id="${item.id}" data-Status="3">
                            <li class="fa fa-trash">发货</li>
                        </a>
                [/#if]
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
    var webApp = angular.module('orderAppList', []);
    webApp.controller("controller", function($scope, $timeout) {
        $scope.ipImg = Global.imageService;
    });
    [@flash_message /]

    $(function () {
        $(".delete").click(function () {
            var id = $(this).attr("data-id");
            alertServer.cofirm("确认删除", "删除", function (flag) {
                if (flag)
                    Ajax.Get("${basePath}/order/del/" + id).done(function (res) {
                        Notify.success("删除成功");
                        window.location.reload()
                    }).fail(function (err) {
                        swal("错误", '操作失败', "error")
                    })
            })
        });
        $(".updateAdminOk").click(function () {
            var id = $(this).attr("data-id");
            var adminOk = $(this).attr("data-adminOk");
            alertServer.cofirm("确认操作", "确认", function (flag) {
                if (flag) {
                    var ary = {
                        orderId:id,
                        adminOk:adminOk
                    }
                    Ajax.Post("${basePath}/order/updateAdminOk",ary).done(function (res) {
                        if (res.code == 200) {
                            Notify.success("操作成功");
                            window.location.reload()
                        } else {
                            setTimeout(function () {
                                swal("错误", res.msg, "error")
                            },100)
                        }

                    }).fail(function (err) {
                        setTimeout(function () {
                            swal("错误", err, "error")
                        },100)
                    })
                    [#--$.ajax({--]
                        [#--url: "${basePath}/order/updateAdminOk",--]
                        [#--data: {--]
                            [#--orderId:id,--]
                            [#--adminOk:adminOk--]
                        [#--},--]
                        [#--type: "post",--]
                        [#--dataType: "json",--]
                        [#--success:function (res) {--]
                            [#--if (res.status == 200) {--]
                                [#--Notify.success("操作成功");--]
                                [#--window.location.reload()--]
                            [#--} else {--]
                                [#--swal("错误", '操作失败', "error")--]
                            [#--}--]
                        [#--}--]
                    [#--});--]

                }

            })
        });
        $(".updateStatus").click(function () {
            var id = $(this).attr("data-id");
            var status = $(this).attr("data-status");
            // var html = "<div class=\"form-group col-md-4\">\n" +
            //         "                                    <label class=\"col-md-4 control-label\">运单号:</label>\n" +
            //         "                                    <div class=\"col-md-4\">\n" +
            //         "                                        <input type=\"text\" name=\"expressNumber\" class=\"form-control\" placeholder=\"运单号\" />\n" +
            //         "                                    </div>\n" +
            //         "                                </div>";

            alertServer.cofirm("请输入运单号", "确认","input" ,function (expressNumber) {
                console.log(expressNumber)
                if (null != expressNumber && $.trim(expressNumber).length > 0) {
                    var ary = {
                        orderId:id,
                        status:status,
                        expressNumber:expressNumber
                    }
                    Ajax.Post("${basePath}/order/updateStatus",ary).done(function (res) {
                        if (res.code == 200) {
                            Notify.success("发货成功");
                            window.location.reload()
                        } else {
                            setTimeout(function () {
                                swal("错误", res.msg, "error")
                            },100)

                        }
                    }).fail(function (err) {
                        setTimeout(function () {
                            swal("错误", err, "error")
                        },100)
                    })
                } else {
                    setTimeout(function () {
                        swal("错误", "请输入运单号", "error")
                    },200)

                }

            })
        });
    });
</script>
