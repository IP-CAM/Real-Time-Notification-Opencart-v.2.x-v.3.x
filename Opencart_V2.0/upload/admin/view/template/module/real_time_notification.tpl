<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<a href="<?php echo $support_email; ?>" data-toggle="tooltip" title="<?php echo $text_need_support; ?>" class="btn btn-info"><i class="fa fa-support"></i> <?php echo $text_need_support; ?></a>
				<button type="submit" form="form-real-time-notification" data-toggle="tooltip" title="<?php echo $button_save_and_stay; ?>" class="btn btn-primary" onClick="$('#save_and_stay').val(1);"><i class="fa fa-save"></i> <?php echo $button_save_and_stay; ?></button>
				<button type="submit" form="form-real-time-notification" data-toggle="tooltip" title="<?php echo $button_save_and_exit; ?>" class="btn btn-primary" onClick="$('#save_and_stay').val(0);"><i class="fa fa-save"></i> <?php echo $button_save_and_exit; ?></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if($error_warning) { ?>
		<div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if($success) { ?>
		<div class="alert alert-success alert-dismissible"><i class="fa fa-check-circle"></i> <?php echo $success; ?> <button type="button" class="close" data-dismiss="alert">&times;</button></div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-real-time-notification" class="form-horizontal">
					<input type="hidden" name="save_and_stay" id="save_and_stay" />
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-position">
							<span data-toggle="tooltip" title="<?php echo $help_position; ?>"><?php echo $entry_position; ?></span>
						</label>
						<div class="col-sm-8">
							<div class="col-sm-10 notification-position" data-toggle="buttons">
								<button class="btn btn-orange col-sm-4 <?php if ($real_time_notification_position == 'top-left') { ?>active<?php } ?>" title="<?php echo $text_top_left; ?>">
									<input type="radio" name="real_time_notification_position" autocomplete="off" value="top-left" <?php if($real_time_notification_position == 'top-left') { ?>checked<?php } ?>/>
									<span class="icon-arrow-up-left">
										<i class="fa fa-arrow-up"></i>
									</span>
								</button>
								<button class="btn btn-orange col-sm-4 <?php if ($real_time_notification_position == 'top-center') { ?>active<?php } ?>" title="<?php echo $text_top_center; ?>">
									<input type="radio" name="real_time_notification_position" autocomplete="off" value="top-center"  <?php if($real_time_notification_position == 'top-center') { ?>checked<?php } ?>/>
									<span class="icon-arrow-up">
										<i class="fa fa-arrow-up"></i>
									</span>
								</button>
								<button class="btn btn-orange col-sm-4 <?php if($real_time_notification_position == 'top-right') { ?>active<?php } ?>" title="<?php echo $text_top_right; ?>">
									<input type="radio" name="real_time_notification_position" autocomplete="off" value="top-right"  <?php if($real_time_notification_position == 'top-right') { ?>checked<?php } ?> />
									<span class="icon-arrow-up-right">
										<i class="fa fa-arrow-up"></i>
									</span>
								</button>
								<button class="btn btn-orange col-sm-4 <?php if($real_time_notification_position == 'bottom-left') { ?>active<?php } ?>" title="<?php echo $text_bottom_left; ?>">
									<input type="radio" name="real_time_notification_position" autocomplete="off" value="bottom-left"  <?php if($real_time_notification_position == 'bottom-left') { ?>checked<?php } ?>/>
									<span class="icon-arrow-down-left">
										<i class="fa fa-arrow-down"></i>
									</span>
								</button>
								<button class="btn btn-orange col-sm-4 <?php if($real_time_notification_position == 'bottom-center') { ?>active<?php } ?>" title="<?php echo $text_bottom_center; ?>">
									<input type="radio" name="real_time_notification_position" autocomplete="off" value="bottom-center"  <?php if($real_time_notification_position == 'bottom-center') { ?>checked<?php } ?>/>
									<span class="icon-arrow-down">
										<i class="fa fa-arrow-down"></i>
									</span>
								</button>
								<button class="btn btn-orange col-sm-4 <?php if($real_time_notification_position == 'bottom-right') { ?>active<?php } ?>" title="<?php echo $text_bottom_right; ?>">
									<input type="radio" name="real_time_notification_position" autocomplete="off" value="bottom-right"  <?php if($real_time_notification_position == 'bottom-right') { ?>checked<?php } ?>/>
									<span class="icon-arrow-down-right">
										<i class="fa fa-arrow-down"></i>
									</span>
								</button>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-allow-dismiss">
							<span data-toggle="tooltip" title="<?php echo $help_allow_dismiss; ?>"><?php echo $entry_allow_dismiss; ?></span>
						</label>
						<div class="col-sm-10">
							<input type="checkbox" value="1" name="real_time_notification_allow_dismiss" data-toggle="toggle" data-on="<?php echo $text_enabled; ?>" data-off="<?php echo $text_disabled; ?>" <?php if($real_time_notification_allow_dismiss) { ?>checked<?php } ?>>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-pause-on-hover">
							<span data-toggle="tooltip" title="<?php echo $help_pause_on_hover; ?>"><?php echo $entry_pause_on_hover; ?></span>
						</label>
						<div class="col-sm-10">
							<input type="checkbox" value="1" name="real_time_notification_pause_on_hover" data-toggle="toggle" data-on="<?php echo $text_enabled; ?>" data-off="<?php echo $text_disabled; ?>" <?php if($real_time_notification_pause_on_hover) { ?>checked<?php } ?>>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-pause-on-hover">
							<span data-toggle="tooltip" title="<?php echo $help_delay; ?>"><?php echo $entry_delay; ?></span>
						</label>
						<div class="col-sm-2">
							<input type="number" class="form-control" name="real_time_notification_delay" value="<?php echo $real_time_notification_delay; ?>">
							<?php if($error_delay) { ?>
							<div class="text-danger"><?php echo $error_delay; ?></div>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-newest-on-top">
							<span data-toggle="tooltip" title="<?php echo $help_newest_on_top; ?>"><?php echo $entry_newest_on_top; ?></span>
						</label>
						<div class="col-sm-10">
							<input type="checkbox" value="1" name="real_time_notification_newest_on_top" data-toggle="toggle" data-on="<?php echo $text_enabled; ?>" data-off="<?php echo $text_disabled; ?>" <?php if($real_time_notification_newest_on_top) { ?>checked<?php } ?>>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-progress-bar">
							<span data-toggle="tooltip" title="<?php echo $help_progress_bar; ?>"><?php echo $entry_progress_bar; ?></span>
						</label>
						<div class="col-sm-10">
							<input type="checkbox" value="1" name="real_time_notification_progress_bar" data-toggle="toggle" data-on="<?php echo $text_enabled; ?>" data-off="<?php echo $text_disabled; ?>" <?php if($real_time_notification_progress_bar) { ?>checked<?php } ?>>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-order-status"><span data-toggle="tooltip" title="<?php echo $help_order_status; ?>"><?php echo $entry_order_status; ?></span></label>
						<div class="col-sm-10">
							<div class="well well-sm" style="height: 150px; overflow: auto;">
								<?php foreach($order_statuses as $order_status) { ?>
								<div class="checkbox">
								<label>
									<?php if(!empty($real_time_notification_order_status) && in_array($order_status['order_status_id'], $real_time_notification_order_status)) { ?>
										<input type="checkbox" name="real_time_notification_order_status[]" value="<?php echo $order_status['order_status_id']; ?>" checked="checked" />
										<?php echo $order_status['name']; ?>
									<?php } else { ?>
										<input type="checkbox" name="real_time_notification_order_status[]" value="<?php echo $order_status['order_status_id']; ?>" />
										<?php echo $order_status['name']; ?>
									<?php } ?>
								</label>
						  		</div>
								<?php } ?>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="input-status">
							<span data-toggle="tooltip" title="<?php echo $help_status; ?>"><?php echo $entry_status; ?></span>
						</label>
						<div class="col-sm-10">
							<input type="checkbox" value="1" name="real_time_notification_status" data-toggle="toggle" data-on="<?php echo $text_enabled; ?>" data-off="<?php echo $text_disabled; ?>" <?php if($real_time_notification_status) { ?>checked<?php } ?>>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>