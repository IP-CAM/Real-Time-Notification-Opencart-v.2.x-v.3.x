<?php
class ControllerExtensionModuleRealTimeNotification extends Controller {

	private static $interval = 5000; // in miliseconds

	public function index() {
		if ($this->config->get('real_time_notification_status')) {

			$this->document->addScript('catalog/view/javascript/bootstrap-notify/bootstrap-notify.min.js');
			$this->document->addStyle('catalog/view/theme/default/stylesheet/real_time_notification.css');

			// ajax refresh rate
			$data['real_time_notification_interval'] = self::$interval;

			// position
			$data['real_time_notification_position'] = $this->config->get('real_time_notification_position')? $this->config->get('real_time_notification_position') : 'bottom-right';

			// allow user to dismiss notification before auto hiding
			$data['real_time_notification_allow_dismiss'] = $this->config->get('real_time_notification_allow_dismiss')? $this->config->get('real_time_notification_allow_dismiss') : false;

			// pause on hover
			$data['real_time_notification_pause_on_hover'] = $this->config->get('real_time_notification_pause_on_hover')? true : false;

			// notification delay for hiding
			$data['real_time_notification_delay'] = $this->config->get('real_time_notification_delay')? $this->config->get('real_time_notification_delay') : self::$interval;

			// keep newest on top
			$data['real_time_notification_newest_on_top'] = $this->config->get('real_time_notification_newest_on_top')? $this->config->get('real_time_notification_newest_on_top') : true;

			// progress bar
			$data['real_time_notification_progress_bar'] = $this->config->get('real_time_notification_progress_bar')? $this->config->get('real_time_notification_progress_bar') : true;

			return $this->load->view('extension/module/real_time_notification', $data);
		}
	}

	public function notification() {
		
		if ($this->config->get('real_time_notification_status')) {
			$this->load->model('extension/module/real_time_notification');
			$this->load->language('extension/module/real_time_notification');

			if(empty($this->session->data['real_time_notification']['latest_order_id'])){
				$this->session->data['real_time_notification']['latest_order_id'] = 0;
			}

			$latest_order_id = $this->session->data['real_time_notification']['latest_order_id'];

			$json = array('sales' => array());

			$recent_sales = $this->model_extension_module_real_time_notification->getRecentSales($latest_order_id);
			if(!empty($recent_sales)){

				$message = $this->language->get('text_sale_notification');

				$this->load->model('tool/image');
				foreach($recent_sales as $sale){

					foreach($sale as $k=>$v){
						if(!is_array($v)) {
							$message = str_replace("{{".$k."}}", $v, $message);
						}
					}

					foreach($sale['order_products'] as $product){
						$product_href = $this->url->link('product/product', '&product_id=' . $product['product_id']);
						$product_name = sprintf($this->language->get('text_product_name'), $product_href, $product['name']);
						$thumb = $this->model_tool_image->resize($product['image'], 60, 60);

						$json['sales'][] = array(
										'oid' => $sale['order_id'],
										'thumb' => $thumb,
										'href' => $product_href,
										'message' => str_replace("{{product}}", $product_name, $message)
									);
						}

						$latest_order_id = $sale['order_id'] > $latest_order_id? $sale['order_id'] : $latest_order_id;
				}
			}

			$json['lid'] = $this->session->data['real_time_notification']['latest_order_id'] = $latest_order_id;

			$this->response->addHeader('Content-Type: application/json');
			$this->response->setOutput(json_encode($json));
			return;
		}
	}
}
