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
<div id="content" class="content">
<form id="listForm" action="${basePath}/" class="form-inline" >
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
<div class="panel-body">
<div class="form-group">
<select class="form-control" name="searchProperties">
    <option value="" >请选择查询条件</option>
    <option value="type" [#if 'type' ==( page.searchProperties)!'' ]selected="selected"[/#if]>分类</option>
</select>
<div class="input-group input-daterange">
<select class="form-control" name="searchValue">
    <option value="" >请选择查询条件</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >orderNumber</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >userId</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >status</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >addressId</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >price</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >payMethod</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >freight</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >userIsValid</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >bankImg</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >adminOk</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >adminId</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >expressNumber</option>
    </select>
</div>
</div>
    <button type="submit" class="btn btn-default">查询</button>
</div>
</div>
    <div class="panel panel-default actionPanel">
        [#--添加操作按钮--]
        <div class="row m-l-1 ">
            <a href="${basePath}/order/add" class="btn btn-sm btn-success" >添加</a>
        </div>
    </div>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th width="70">序号</th>
                            <th>订单编号</th>
                            <th>用户</th>
                            <th>订单状态</th>
                            <th>收货地址</th>
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
                                    <td> ${item.userId!''}</td>
                                    <td> ${item.status!''}</td>
                                    <td> ${item.addressId!''}</td>
                                    <td> ${item.price!''}</td>
                                    <td> ${item.payMethod!''}</td>
                                    <td> ${item.freight!''}</td>
                                    <td> ${item.userIsValid!''}</td>
                                    <td> ${item.bankImg!''}</td>
                                    <td> ${item.adminOk!''}</td>
                                    <td> ${item.adminId!''}</td>
                                    <td> ${item.expressNumber!''}</td>
                            <td>
                <a href="${basePath}/order/edit?id=${item.id}"><li class="fa  fa-edit">编辑</li></a>
                <a href="javascript:void (0)" class="delete" data-id="${item.id}" ><li class="fa fa-trash">删除</li></a>
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
                var  id =  $(this).attr("data-id");
                alertServer.cofirm("确认删除","删除",function (flag) {
                    if(flag)
                        Ajax.Get("${basePath}/order/del/"+id).done(function (res) {
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
