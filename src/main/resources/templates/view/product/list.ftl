<!-- begin #content -->
<!-- ================== BEGIN BASE CSS STYLE ================== -->
[#include "../../include.ftl"]
<div id="content" class="content">
    <form id="listForm" action="list" class="form-inline" >
        <div class="row">
        <!-- begin col-12 -->
        <div class="col-md-12">
            <!-- begin panel -->
            <div class="panel panel-inverse" data-sortable-id="table-basic-7">
                <div class="panel-heading">
                    <h4 class="panel-title">商品列表</h4>
                </div>
                <div class="panel-body">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">高级查询</h3>
                        </div>
                        <div class="panel-body form-horizontal">
                            <div class="form-group col-md-4">
                                <label class="col-md-4 control-label">商品名称:</label>
                                <div class="col-md-4">
                                    <input type="text" name="name" class="form-control" placeholder="名称"  value="${(name)!''}"/>
                                </div>
                            </div>
                            <div class="form-group col-md-4">
                                <label class="col-md-4 control-label">请选择商品分类:</label>
                                <select class="form-control" id="productCategoryId">
                                    <option value="" >请选择商品分类</option>
                                [#list productCategoryList as productCategory]
                                    [#if productCategory.childList?? && (productCategory.childList?size > 0)]
                                        <optgroup label="${productCategory.name}">
                                            [#list productCategory.childList as child]
                                                <option value="${child.id}" [#if child.id ==(productCategoryId)!'' ]selected="selected"[/#if]>${child.name}</option>
                                            [/#list]
                                        </optgroup>
                                    [#else ]
                                    <option value="${productCategory.id}" [#if productCategory.id ==(productCategoryId)!'' ]selected="selected"[/#if]>${productCategory.name}</option>
                                    [/#if]
                                [/#list]
                                </select>
                            </div>
                            <div class="form-group col-md-4">
                                <label class="col-md-4 control-label">isPromotion:</label>
                                <div class="col-md-4">
                                    <input type="text" name="name" class="form-control" placeholder="名称"  value="${(name)!''}"/>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-default">查询</button>
                        </div>
                    </div>
                    <div class="panel panel-default actionPanel">

                    [@shiro.hasPermission name = "system:product:add"]
                        <div class="row m-l-1 ">
                            <a href="add" class="btn btn-sm btn-success" >添加商品</a>
                        </div>
                    [/@shiro.hasPermission]

                    </div>
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th width="70">序号</th>
                            <th>商品名</th>
                            <th>商品编号</th>
                            <th>描述</th>
                            <th>所属分类</th>
                            <th>价格</th>
                            <th>是否促销</th>
                            <th>促销价</th>
                            <th>是否为积分商品</th>
                            <th>返还积分</th>
                            <th>是否为推荐商品</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        [#list  page.records as item]
                            <tr>
                                <td width="70" align="center">${item_index+1}</td>
                                <td>${item.name!''}</td>
                                <td>${item.number!''}</td>
                                <td>${item.describe!''}</td>
                                <td>${item.productCategoryName!''}</td>
                                <td>${item.price!''}</td>
                                <td>${(item.isPromotion==1)?string("是","否")}</td>
                                <td>${item.promotionPrice!'--'}</td>
                                <td>${(item.isIntegral==1)?string("是","否")}</td>
                                <td>${item.integral!'--'}</td>
                                <td>${(item.isHot==1)?string("是","否")}</td>
                                [#--<td>${(item.createTime?string("yyyy-MM-dd hh:MM:ss"))!''}--]
                                [#--<td>${(item.updateTime?string("yyyy-MM-dd hh:MM:ss"))!''}--]
                                <td>

                                [#if item.system?? && item.system]
                                    [@shiro.hasPermission name = "system:product:edit"]
                                      <a href="edit?id=${item.id}"><li class="fa  fa-edit">编辑</li></a>
                                    [/@shiro.hasPermission]
                                [/#if]
                                [@shiro.hasPermission name = "system:product:del"]
                                   <a href="javascript:void (0)" class="delete" data-id="${item.id}" ><li class="fa fa-trash">删除</li></a>
                                [/@shiro.hasPermission]
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
                if(flag){
                    Ajax.Get("del/"+id).done(function (res) {
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
