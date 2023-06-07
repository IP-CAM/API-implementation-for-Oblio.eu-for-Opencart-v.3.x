{$header}{$column_left}

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-module" data-toggle="tooltip" title="{$button_save}" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="{$cancel}" data-toggle="tooltip" title="{$button_cancel}" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1>{$heading_title}</h1>
      <ul class="breadcrumb">
        {foreach breadcrumb in breadcrumbs}
        <li><a href="{$breadcrumb.href}">{$breadcrumb.text}</a></li>
        {/foreach}
      </ul>
    </div>
  </div>
  <div class="container-fluid">
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
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> {$text_edit}</h3>
      </div>
      <div class="panel-body">
        <form action="{$action}" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-email-url">{$entry_email}</label>
            <div class="col-sm-10">
              <input type="text" name="module_oblio_email" value="{$module_oblio_email}" placeholder="{$placeholder_email}" id="input-email-url" class="form-control" />
              {if $error.email}
              <div class="text-danger">{$error_email}</div>
              {/if}
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-api-secret">{$entry_api_secret} <span data-toggle="tooltip" title="{$help_api_secret}"></span></label>
            <div class="col-sm-10">
              <input type="text" name="module_oblio_api_secret" value="{$module_oblio_api_secret}" placeholder="{$placeholder_api_secret}" id="input-api-secret" class="form-control" />
              {if $error.api_secret}
              <div class="text-danger">{$error_api_secret}</div>
              {/if}
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status">{$entry_status}</label>
            <div class="col-sm-10">
              <select name="module_oblio_status" id="input-status" class="form-control">
                {if $module_oblio_status}
                <option value="1" selected="selected">{$text_enabled}</option>
                <option value="0">{$text_disabled}</option>
                {else}
                <option value="1">{$text_enabled}</option>
                <option value="0" selected="selected">{$text_disabled}</option>
                {/if}
              </select>
            </div>
          </div>
          
        {foreach from=$fieldSets item=fieldSet}
          <div class="form-group">
            <div class="col-sm-12"><h4>{$fieldSet.name}</h4></div>
          </div>
          {foreach from=$fieldSet.fields item=field}
          <div class="form-group">
            <label class="col-sm-2 control-label" for="select-{$field.name}">{$field.label}</label>
            <div class="col-sm-10">
            {if $field.type == 'select'}
              <select name="{$field.name}" id="select-{$field.name}" class="form-control">
              {foreach option in field.options.query}
                <option
                    value="{$option[field.options.id]}"
                    {if $option[field.options.id] == field.selected} selected{/if}
                    {if $field.options.data}
                    {foreach from=$data key=key item=value}
                        data-{$key}="{$option[value]}"
                    {/foreach}
                    {/if}>{$option[field.options.name]}</option>
              {/foreach}
              </select>
            {elseif $field.type == 'text'}
              <input name="{$field.name}" id="select-{$field.name}" class="form-control" value="{$field.value}" />
            {elseif $field.type == 'textarea'}
              <textarea name="{$field.name}" id="select-{$field.name}" class="form-control">{$field.value}</textarea>
            {/if}
            </div>
          </div>
          {/foreach}
        {/foreach}
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
var ajax_link = '{$ajax_link}';
{literal}
"use strict";
(function($) {
    $(document).ready(function() {
        var oblio_cui = $('#select-module_oblio_company_cui'),
            oblio_series_name = $('#select-module_oblio_company_series_name'),
            oblio_workstation = $('#select-module_oblio_company_workstation'),
            oblio_management = $('#select-module_oblio_company_management'),
            useStock = parseInt(oblio_cui.find('option:selected').data('use-stock')) === 1;
        showManagement(useStock);
        
        oblio_cui.change(function() {
            var self = $(this),
                data = {
                    action:'oblio',
                    type:'series_name',
                    cui:oblio_cui.val()
                },
                useStock = parseInt(oblio_cui.find('option:selected').data('use-stock')) === 1;

            populateOptions(data, oblio_series_name);
            
            if (useStock) {
                data.type = 'workstation';
                populateOptions(data, oblio_workstation);
                populateOptionsRender(oblio_management, [])
            }
            showManagement(useStock);
        });
        oblio_workstation.change(function() {
            var self = $(this),
                data = {
                    action:'oblio',
                    type:'management',
                    name:self.val(),
                    cui:oblio_cui.val()
                };
            populateOptions(data, oblio_management);
        });
        
        function showManagement(useStock) {
            oblio_workstation.parent().parent().toggleClass('hidden', !useStock);
            oblio_management.parent().parent().toggleClass('hidden', !useStock);
        }
        
        function populateOptions(data, element, fn) {
            jQuery.ajax({
                type: 'post',
                dataType: 'json',
                url: ajax_link,
                data: data,
                success: function(response) {
                    populateOptionsRender(element, response, fn);
                }
            });
        }
        
        function populateOptionsRender(element, data, fn) {
            var options = '<option value="">Selecteaza</option>';
            for (var index in data) {
                var value = data[index];
                options += '<option value="' + value.name + '">' + value.name + '</option>';
            }
            element.html(options);
            if (typeof fn === 'function') {
                fn(data);
            }
        }
    });
})(jQuery);
{/literal}
</script>

{$footer}