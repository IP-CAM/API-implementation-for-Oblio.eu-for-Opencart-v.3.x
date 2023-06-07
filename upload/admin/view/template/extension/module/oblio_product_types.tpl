{$header}{$column_left}

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1>{$heading_title}</h1>
      <ul class="breadcrumb">
        {foreach item=breadcrumb from=$breadcrumbs}
        <li><a href="{$breadcrumb.href}">{$breadcrumb.text}</a></li>
        {/foreach}
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div id="oblio_message"></div>
    {if $error.permission}
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> {$error_permission}
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    {elseif $message_error_api}
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> {$message_error_api}
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    {elseif count($error) > 0}
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> {$error_warning}
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    {/if}
    {if $success}
    <div class="alert alert-success alert-dismissible"><i class="fa fa-exclamation-circle"></i> {$success}
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    {/if}
    <div class="panel panel-default">
      <div class="panel-heading">Adauga tip</div>
      <div class="panel-body">
        <form action="{$action}" method="post" enctype="multipart/form-data" id="form-module" class="form-inline">
          <table class="table table-striped">
            <thead>
              <tr><th><input type="checkbox" class="ckall" /></th><th>Nume</th><th>Tip</th></tr>
            </thead>
            {foreach item=product from=$products_list_custom_type}
            <tr><td><input type="checkbox" name="prod[{$product.product_id}]" class="ckbox" /></td><td>{$product.name}</td><td>{$product.product_type}</td></tr>
            {/foreach}
          </table>
          
          <div class="row">
            <div class="col-lg-3">
              <div class="form-group">
                <label class="sr-only" for="product_type">Tip produs</label>
                <button type="submit" class="btn btn-danger" name="submit" value="delete">Sterge</button>
              </div>
            </div>
            <div class="col-lg-9">
              <div class="form-group">
                <label class="sr-only" for="product_id">Alege produs</label>
                <select name="product_id" class="form-control">
                  <option value="">Alege produs</option>
                  {foreach item=product from=$products_list}
                  <option value="{$product.product_id}">{$product.name}</option>
                  {/foreach}
                </select>
              </div>
              <div class="form-group">
                <label class="sr-only" for="product_type">Tip produs</label>
                <select name="product_type" class="form-control">
                  {foreach item=type from=$products_types}
                  <option value="{$type.name}">{$type.name}</option>
                  {/foreach}
                </select>
              </div>
              <button type="submit" class="btn btn-primary" name="submit" value="add">Adauga in lista</button>
            </div>
          </div>
          
        </form>
      </div>
    </div>
    
  </div>
</div>

{literal}
<script type="text/javascript">
"use strict";
$(document).ready(function() {
    var form = $('#form-module');
    $('.ckall').click(function() {
        $('.ckbox').prop('checked', $(this).prop('checked'));
    });
});
</script>
<style>
.form-group + .form-group {border-top:0;}
</style>
{/literal}

{$footer}