<?php
class ModelExtensionModuleRealTimeNotification extends Model {

	public function getRecentSales($latest_order_id = 0, $limit = 10){
		$recent_sales = array();

		if ($limit < 1) {
			$limit = 1;
		}

		$conditional_clause = "";
		if($latest_order_id <= 0) {
			// for first time fetch orders no older than 10minutes
			$conditional_clause .= " AND o.date_added >= DATE_SUB(NOW(), INTERVAL 10 MINUTE) ";
		} else {
			$conditional_clause .= " AND  o.order_id > '" . (int)$latest_order_id . "' ";
		}

		if($this->customer->getId()){
			// we should not show customer his own order notification
			$conditional_clause .= " AND o.customer_id <> '" . (int)$this->customer->getId() . "' ";
		}

		$success_order_ids = array_merge(
										$this->config->get('config_processing_status'),
										$this->config->get('config_complete_status')
									);

		$success_order_ids = implode("', '", $success_order_ids);

		$sql = "SELECT o.order_id, o.firstname, o.lastname, o.payment_city AS city, o.date_added, c.name AS country, z.name AS zone FROM `" . DB_PREFIX . "order` o JOIN `" . DB_PREFIX . "country` c ON c.country_id=o.payment_country_id JOIN `" . DB_PREFIX . "zone`z ON z.zone_id=o.payment_zone_id WHERE o.store_id = '" . (int)$this->config->get('config_store_id') . "' " . $conditional_clause . " ORDER BY o.date_added ASC LIMIT " . (int)$limit;
		
		// echo $sql;

		$orders = $this->db->query($sql)->rows;
		if(!empty($orders)) {
			foreach($orders as $k=>$v) {
				$order_products = $this->getOrderProducts($v['order_id']);
				$recent_sales[$v['order_id']] = $v;
				$recent_sales[$v['order_id']]['order_products'] = $order_products;
			}
		}
		return $recent_sales;
	}

	public function getOrderProducts($order_id){
		return $this->db->query("SELECT op.name, p.image, p.product_id FROM `" . DB_PREFIX . "order_product` op JOIN `" . DB_PREFIX . "product` p ON p.product_id=op.product_id WHERE order_id = '" . (int)$order_id . "'")->rows;
	}
}	