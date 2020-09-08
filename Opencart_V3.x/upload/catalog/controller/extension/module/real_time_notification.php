<?php
class ControllerExtensionModuleRealTimeNotification extends Controller {

	public function notification() {
		
		if ($this->config->get('module_real_time_notification_status')) {
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
