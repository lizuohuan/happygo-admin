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
                    <h4 class="panel-title">系统配置</h4>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" action="${basePath}/systemConfig/save" method="post">
                        <input type="hidden" name="id" value="${(systemConfig.id)!''}">
                        <div class="form-group">
                            <label class="col-md-1 control-label">今日汇率: </label>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" name="parities" class="form-control" value="${(systemConfig.parities)!''}"/>
                                    <div class="input-group-addon">%</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-1 control-label">提现百分比: </label>
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" name="withdrawalProportion" class="form-control"
                                           value="${(systemConfig.withdrawalProportion)!''}"/>
                                    <div class="input-group-addon">%</div>
                                </div>
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

<script type="application/javascript">
    [@flash_message /]
</script>