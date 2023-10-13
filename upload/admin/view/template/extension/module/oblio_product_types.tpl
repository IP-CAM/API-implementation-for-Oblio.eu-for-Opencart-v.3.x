<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1><?php echo $page_name; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb): ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php endforeach; ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div id="oblio_message"></div>
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
      <div class="panel-heading">Adauga tip</div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-inline">
          <table class="table table-striped">
            <thead>
              <tr><th><input type="checkbox" class="ckall" /></th><th>Nume</th><th>Tip</th></tr>
            </thead>
          <?php foreach ($products_list_custom_type as $product): ?>
            <tr>
              <td><input type="checkbox" name="prod[<?php echo $product['product_id']; ?>]" class="ckbox" /></td>
              <td><?php echo $product['name']; ?></td>
              <td><?php echo $product['product_type']; ?></td>
            </tr>
          <?php endforeach; ?>
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
                  <?php foreach ($products_list as $product): ?>
                  <option value="<?php echo $product['product_id']; ?>"><?php echo $product['name']; ?></option>
                  <?php endforeach; ?>
                </select>
              </div>
              <div class="form-group">
                <label class="sr-only" for="product_type">Tip produs</label>
                <select name="product_type" class="form-control">
                  <?php foreach ($products_types as $type): ?>
                  <option value="<?php echo $type['name']; ?>"><?php echo $type['name']; ?></option>
                  <?php endforeach; ?>
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

<?php echo $footer; ?>