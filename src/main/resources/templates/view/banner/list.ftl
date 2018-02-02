<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<div id="content" class="content">
<form id="listForm" action="${basePath}/log" class="form-inline" >
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
<div class="panel-body">
<div class="form-group">
<select class="form-control" name="searchProperties">
    <option value="" >请选择查询条件</option>
    <option value="type" [#if 'type' ==( page.searchProperties)!'' ]selected="selected"[/#if]>分类</option>
</select>
<div class="input-group input-daterange">
<select class="form-control" name="searchValue">
    <option value="" >请选择查询条件</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >name</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >title</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >productId</option>
            <option value="0" [#if '' ==( page.searchValue)!'' ]selected="selected"[/#if] >type</option>
    </select>
</div>
</div>
    <button type="submit" class="btn btn-default">查询</button>
</div>
</div>
    <div class="panel panel-default actionPanel">
        [#--添加操作按钮--]
        <div class="row m-l-1 ">
            <a href="${basePath}/banner/add" class="btn btn-sm btn-success" >添加</a>
        </div>
    </div>
    <table class="table table-bordered table-striped">
        <thead>
        <tr>
            <th width="70">序号</th>
                            <th>banner名</th>
                            <th>标题</th>
                            [#--<th>productId</th>--]
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
                                    [#--<td> ${item.productId!''}</td>--]
                                    <td> ${item.img!''}</td>
                                    <td> ${item.link!''}</td>
                                    <td> ${(item.type==0)!''}</td>
                            <td>
                <a href="${basePath}/banner/edit?id=${item.id}"><li class="fa  fa-edit">编辑</li></a>
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
                        Ajax.Get("${basePath}/banner/del/"+id).done(function (res) {
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
