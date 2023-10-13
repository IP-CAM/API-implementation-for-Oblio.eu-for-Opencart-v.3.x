<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1>Sincronizare stocuri</h1>
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
      <div class="panel-heading">Sincronizare manuala</div>
      <div class="panel-body">
        <p>Sincronizarea manuala iti permite sa sincronizezi stocul imediat.</p>
        <p>Daca folosesti sincronizarea automata folosind Cron Jobs, stocul se actualizeaza automat la fiecare ora.</p>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
          <a class="btn btn-danger" id="oblio_update_stock"><i class="fa fa-arrow-down"></i> <?php echo $page_name; ?></a>
        </form>
      </div>
    </div>
    
    <div class="panel panel-default">
      <div class="panel-heading">Sincronizare folosind Cron Jobs</div>
        <div class="panel-body">
            <p>Pentru a sincroniza stocul in fiecare ora adaugati comanda urmatoare in Crontab:</p>
            <pre><?php echo $cron_minute; ?> 	* 	* 	* 	*	php <?php echo $dir_system; ?>library/oblio/cron.php <?php echo $secret; ?></pre>
        </div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
"use strict";
var ajaxLink = "<?php echo $ajax_link; ?>";
$(document).ready(function() {
    $('#oblio_update_stock').click(function(e) {
        var self = $(this);
        if (self.hasClass('disabled')) {
            return;
        }
        self.addClass('disabled');
        self.find('i').attr('class', 'fa fa-circle-o-notch fa-spin');
        e.preventDefault();
        $.ajax({
            url: ajaxLink,
            dataType: 'json',
            success: function(data) {
                if (data[1]) {
                    addMessage(data[1], 'danger');
                } else {
                    addMessage(`Au fost sincronizate ${data[0]} produse`, 'success');
                }
                self.find('i').attr('class', 'fa fa-arrow-down');
                self.removeClass('disabled');
            }
        });
    });
    
    function addMessage(message, type) {
        var response = $('#oblio_message'), html = '';
        html = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">\
          <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>\
          ' + message + '\
        </div>';
        response.html(html);
    }
});
</script>

<?php echo $footer; ?>