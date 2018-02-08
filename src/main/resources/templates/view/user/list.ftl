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
    <form id="listForm" action="${basePath}/user/list" class="form-inline">
        <div class="row">
            <!-- begin col-12 -->
            <div class="col-md-12">
                <!-- begin panel -->
                <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                    <div class="panel-heading">
                        <h4 class="panel-title">用户列表</h4>
                    </div>
                    <div class="panel-body">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">高级查询</h3>
                            </div>
                            <div class="panel-body form-horizontal">
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">手机号:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="phone" class="form-control" placeholder="手机号"  value="${(phone)!''}"/>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">昵称:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="nickName" class="form-control" placeholder="昵称"  value="${(nickName)!''}"/>
                                    </div>
                                </div>
                                [#--<div class="form-group col-md-4">--]
                                    [#--<label class="col-md-4 control-label">上级用户:</label>--]
                                    [#--<div class="col-md-4">--]
                                        [#--<input type="text" name="parentName" class="form-control" placeholder="上级用户"  value="${(parentName)!''}"/>--]
                                    [#--</div>--]
                                [#--</div>--]
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">身份证号码:</label>
                                    <div class="col-md-4">
                                        <input type="text" name="idNumber" class="form-control" placeholder="身份证号码"  value="${(idNumber)!''}"/>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">用户状态:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="status">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (status)?? && 0 == status ]selected="selected"[/#if]>无效/冻结</option>
                                            <option value="1" [#if (status)?? && 1 == status ]selected="selected"[/#if]>有效</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">性别:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="gender">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (gender)?? && 0 == gender ]selected="selected"[/#if]>男</option>
                                            <option value="1" [#if (gender)?? && 1 == gender ]selected="selected"[/#if]>女</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">申请代理商的状态:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="businessStatus">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (businessStatus)?? && 0 == businessStatus ]selected="selected"[/#if]>申请中</option>
                                            <option value="1" [#if (businessStatus)?? && 1 == businessStatus ]selected="selected"[/#if]>通过</option>
                                            <option value="2" [#if (businessStatus)?? && 2 == businessStatus ]selected="selected"[/#if]>拒绝通过</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group col-md-4">
                                    <label class="col-md-4 control-label">角色:</label>
                                    <div class="col-md-4">
                                        <select class="form-control" style="width: 100%" name="roleId">
                                            <option value="" >请选择</option>
                                            <option value="0" [#if (roleId)?? && 0 == roleId ]selected="selected"[/#if]>普通会员</option>
                                            <option value="1" [#if (roleId)?? && 1 == roleId ]selected="selected"[/#if]>代理商普通会员</option>
                                            <option value="2" [#if (roleId)?? && 2 == roleId ]selected="selected"[/#if]>代理商高级会员</option>
                                            <option value="2" [#if (roleId)?? && 3 == roleId ]selected="selected"[/#if]>代理商VIP会员</option>
                                            <option value="2" [#if (roleId)?? && 4 == roleId ]selected="selected"[/#if]>代理商超级会员</option>
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
                        [#--<a href="${basePath}/users/add" class="btn btn-sm btn-success" >添加</a>--]
                        [#--</div>--]
                        </div>
                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th width="70">序号</th>
                                <th>手机号</th>
                                <th>昵称</th>
                                <th>email</th>
                                <th>性别</th>
                                <th>角色</th>
                                <th>上级用户</th>
                                <th>用户状态</th>
                                <th>申请代理商备注电话</th>
                                <th>申请代理商状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>

        [#list  page.records as item]
        <tr>
            <td width="70" align="center">${item_index+1}</td>
            <td> ${item.phone!''}</td>
            <td> ${item.nickName!''}</td>
            <td> ${item.email!''}</td>
            <td> ${item.genderStr!''}</td>
            <td> ${item.roleName!''}</td>
            <td> ${item.parentName!''}</td>
            <td> ${item.statusStr!''}</td>
            <td> ${item.businessPhone!''}</td>
            <td> ${item.businessStatusStr!''}</td>
            <td>
                [#if (item.businessStatus) ?? && (item.businessStatus) == 0]
                    <a href="javascript:void (0)" class="updateBusinessStatus" data-businessStatus="1" data-id="${item.id}" ><li class="fa fa-trash">通过</li></a>
                    <a href="javascript:void (0)" class="updateBusinessStatus" data-businessStatus="2" data-id="${item.id}" ><li class="fa fa-trash">拒绝</li></a>
                [/#if]
                [#--<a href="${basePath}/users/edit?id=${item.id}">--]
                    [#--<li class="fa  fa-edit">编辑</li>--]
                [#--</a>--]
            [#--<a href="javascript:void (0)" class="delete" data-id="${item.id}" ><li class="fa fa-trash">删除</li></a>--]
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
                    Ajax.Get("${basePath}/users/del/" + id).done(function (res) {
                        Notify.success("删除成功");
                        window.location.reload()
                    }).fail(function (err) {
                        swal("错误", '操作失败', "error")
                    })
                });
         });

        $(".updateBusinessStatus").click(function () {
            var id = $(this).attr("data-id");
            var businessStatus = $(this).attr("data-businessStatus");
            alertServer.cofirm("确认操作", "确认",null, function (flag) {
                if (flag) {
                    var ary = {
                        userId:id,
                        businessStatus:businessStatus
                    }
                    Ajax.Post2("${basePath}/user/updateBusinessStatus",ary).done(function (res) {
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

                }

            })
        });
    })
</script>
