<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-module" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb): ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php endforeach; ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if (!empty($error['permission'])): ?>
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_permission; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php elseif (!empty($message_error_api)): ?>
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $message_error_api; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php elseif (count($error) > 0): ?>
    <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php endif; ?>
    <?php if (!empty($success)): ?>
    <div class="alert alert-success alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php endif; ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Editeaza</h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-email-url"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
              <input type="text" name="module_oblio_email" value="<?php echo $module_oblio_email; ?>" id="input-email-url" class="form-control" />
              <?php if (!empty($error['email'])): ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php endif; ?>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-api-secret"><?php echo $entry_api_secret; ?> <span data-toggle="tooltip" title="<?php echo $help_api_secret; ?>"></span></label>
            <div class="col-sm-10">
              <input type="text" name="module_oblio_api_secret" value="<?php echo $module_oblio_api_secret; ?>" id="input-api-secret" class="form-control" />
              <?php if (!empty($error['api_secret'])): ?>
              <div class="text-danger"><?php echo $error_api_secret; ?></div>
              <?php endif; ?>
            </div>
          </div>
          
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="module_oblio_status" id="input-status" class="form-control">
                <?php if (!empty($module_oblio_status)): ?>
                <option value="1" selected="selected">Activ</option>
                <option value="0">Inactiv</option>
                <?php else: ?>
                <option value="1">Activ</option>
                <option value="0" selected="selected">Inactiv</option>
                <?php endif; ?>
              </select>
            </div>
          </div>
          
        <?php foreach ($fieldSets as $fieldSet): ?>
          <div class="form-group">
            <div class="col-sm-12"><h4><?php echo $fieldSet['name']; ?></h4></div>
          </div>
        <?php foreach ($fieldSet['fields'] as $field): ?>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="select-<?php echo $field['name']; ?>"><?php echo $field['label']; ?></label>
            <div class="col-sm-10">
            <?php if ($field['type'] == 'select'): ?>
              <select name="<?php echo $field['name']; ?>" id="select-<?php echo $field['name']; ?>" class="form-control">
              <?php foreach ($field['options']['query'] as $option): ?>
                <option
                    value="<?php echo $option[$field['options']['id']]; ?>"
                    <?php if ($option[$field['options']['id']] == $field['selected']): ?> selected<?php endif; ?>
                    <?php if (!empty($field['options']['data'])): ?>
                    <?php foreach ($field['options']['data'] as $key=>$value): ?>
                        data-<?php echo $key; ?>="<?php echo isset($option[$value]) ? $option[$value] : ''; ?>"
                    <?php endforeach; ?>
                    <?php endif; ?>><?php echo $option[$field['options']['name']]; ?></option>
              <?php endforeach; ?>
              </select>
            <?php elseif ($field['type'] == 'text'): ?>
              <input name="<?php echo $field['name']; ?>" id="select-<?php echo $field['name']; ?>" class="form-control" value="<?php echo $field['value']; ?>" />
            <?php elseif ($field['type'] == 'textarea'): ?>
              <textarea name="<?php echo $field['name']; ?>" id="select-<?php echo $field['name']; ?>" class="form-control"><?php echo $field['value']; ?></textarea>
            <?php endif; ?>
            </div>
          </div>
          <?php endforeach; ?>
        <?php endforeach; ?>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
var ajax_link = '<?php echo $ajax_link; ?>';
"use strict";
(function($) {
    $(document).ready(function() {
        var oblio_cui = $('#select-module_oblio_company_cui'),
            oblio_series_name = $('#select-module_oblio_company_series_name'),
            oblio_series_name_proforma = $('#select-module_oblio_company_series_name_proforma'),
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
            populateOptions({
                action:'oblio',
                type:'series_name_proforma',
                cui:oblio_cui.val()
            }, oblio_series_name_proforma);
            
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
</script>

<?php echo $footer; ?>