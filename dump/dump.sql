-- Adminer 4.7.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `cms3_apiship_orders`;
CREATE TABLE `cms3_apiship_orders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(11) unsigned NOT NULL,
  `umi_order_ref_number` int(11) unsigned NOT NULL,
  `provider_order_ref_number` varchar(255) DEFAULT NULL,
  `status` enum('pending','delivered','delivering','deliveryCanceled','lost','notApplicable','onPointIn','onPointOut','onWay','partialReturn','problem','readyForRecipient','returned','returnedFromDelivery','returning','returnReady','unknown','uploaded','uploading','uploadingError') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `umi_order_ref_number` (`umi_order_ref_number`),
  KEY `provider_order_ref_number` (`provider_order_ref_number`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_appointment_employees`;
CREATE TABLE `cms3_appointment_employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `photo` varchar(500) NOT NULL,
  `description` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_appointment_employees_services`;
CREATE TABLE `cms3_appointment_employees_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id and service_id` (`employee_id`,`service_id`),
  KEY `employees services to services` (`service_id`),
  CONSTRAINT `employees services to employees` FOREIGN KEY (`employee_id`) REFERENCES `cms3_appointment_employees` (`id`) ON DELETE CASCADE,
  CONSTRAINT `employees services to services` FOREIGN KEY (`service_id`) REFERENCES `cms3_appointment_services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_appointment_employee_schedule`;
CREATE TABLE `cms3_appointment_employee_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `day` enum('0','1','2','3','4','5','6') NOT NULL,
  `time_start` time NOT NULL,
  `time_end` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `employee schedule to employees` FOREIGN KEY (`employee_id`) REFERENCES `cms3_appointment_employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_appointment_orders`;
CREATE TABLE `cms3_appointment_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) unsigned NOT NULL,
  `employee_id` int(11) unsigned DEFAULT NULL,
  `create_date` int(11) unsigned NOT NULL,
  `date` int(11) unsigned NOT NULL,
  `time` time NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `comment` mediumtext DEFAULT NULL,
  `status_id` enum('1','2','3') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `create_date` (`create_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_appointment_services`;
CREATE TABLE `cms3_appointment_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `time` time NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `services to service_groups` (`group_id`),
  CONSTRAINT `services to service_groups` FOREIGN KEY (`group_id`) REFERENCES `cms3_appointment_service_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_appointment_service_groups`;
CREATE TABLE `cms3_appointment_service_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_cluster_nodes`;
CREATE TABLE `cms3_cluster_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_ip` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `node_id` (`id`),
  KEY `node_ip` (`node_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_cluster_nodes_cache_keys`;
CREATE TABLE `cms3_cluster_nodes_cache_keys` (
  `node_id` int(11) DEFAULT NULL,
  `key` varchar(255) NOT NULL DEFAULT '',
  KEY `node_id` (`node_id`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_data_cache`;
CREATE TABLE `cms3_data_cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `create_time` int(11) NOT NULL,
  `expire_time` int(11) NOT NULL,
  `entry_time` int(11) NOT NULL,
  `entries_number` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `Life time` (`expire_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_domains`;
CREATE TABLE `cms3_domains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(64) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `default_lang_id` int(10) unsigned DEFAULT NULL,
  `use_ssl` tinyint(1) DEFAULT NULL,
  `favicon` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host` (`host`),
  KEY `Domain to default language relation_FK` (`default_lang_id`),
  CONSTRAINT `FK_Domain to default language relation` FOREIGN KEY (`default_lang_id`) REFERENCES `cms3_langs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_domain_mirrows`;
CREATE TABLE `cms3_domain_mirrows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(64) DEFAULT NULL,
  `rel` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host` (`host`),
  KEY `Domain to mirrows relation_FK` (`rel`),
  CONSTRAINT `FK_Domain to mirrows relation` FOREIGN KEY (`rel`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_emarket_top`;
CREATE TABLE `cms3_emarket_top` (
  `id` int(11) NOT NULL,
  `date` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `total_price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_fields_controller`;
CREATE TABLE `cms3_fields_controller` (
  `ord` int(11) DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `group_id` int(10) unsigned DEFAULT NULL,
  KEY `rel to field_FK` (`field_id`),
  KEY `rel to field group_FK` (`group_id`),
  KEY `ord` (`ord`),
  CONSTRAINT `FK_rel to field` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rel to field group` FOREIGN KEY (`group_id`) REFERENCES `cms3_object_field_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_hierarchy`;
CREATE TABLE `cms3_hierarchy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rel` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `lang_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  `obj_id` int(10) unsigned NOT NULL,
  `ord` int(11) DEFAULT 0,
  `tpl_id` int(10) unsigned DEFAULT NULL,
  `alt_name` varchar(128) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT NULL,
  `updatetime` int(11) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `types rels_FK` (`type_id`),
  KEY `Prefix from lang_id_FK` (`lang_id`),
  KEY `Domain from domain_id relation_FK` (`domain_id`),
  KEY `hierarchy to plain object image_FK` (`obj_id`),
  KEY `Getting template data_FK` (`tpl_id`),
  KEY `is_default` (`is_default`),
  KEY `alt_name` (`alt_name`),
  KEY `is_deleted` (`is_deleted`),
  KEY `is_active` (`is_active`),
  KEY `ord` (`ord`),
  KEY `rel` (`rel`),
  KEY `updatetime` (`updatetime`),
  KEY `is_visible` (`is_visible`),
  CONSTRAINT `FK_Domain from domain_id relation` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Getting template data` FOREIGN KEY (`tpl_id`) REFERENCES `cms3_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Prefix from lang_id` FOREIGN KEY (`lang_id`) REFERENCES `cms3_langs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_hierarchy to plain object image` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_types rels` FOREIGN KEY (`type_id`) REFERENCES `cms3_hierarchy_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_hierarchy_relations`;
CREATE TABLE `cms3_hierarchy_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rel_id` int(10) unsigned DEFAULT NULL,
  `child_id` int(10) unsigned DEFAULT NULL,
  `level` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rel_id` (`rel_id`),
  KEY `child_id` (`child_id`),
  KEY `level` (`level`),
  CONSTRAINT `Hierarchy relation by child_id` FOREIGN KEY (`child_id`) REFERENCES `cms3_hierarchy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Hierarchy relation by rel_id` FOREIGN KEY (`rel_id`) REFERENCES `cms3_hierarchy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_hierarchy_types`;
CREATE TABLE `cms3_hierarchy_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(48) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `ext` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`,`ext`),
  KEY `title` (`title`),
  KEY `ext` (`ext`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_apiship_orders`;
CREATE TABLE `cms3_import_apiship_orders` (
  `external_id` int(10) unsigned NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_apiship_orders_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_apiship_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_apiship_orders_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_appointment_employees`;
CREATE TABLE `cms3_import_appointment_employees` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_appointment_employees_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_appointment_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_appointment_employees_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_appointment_employees_services`;
CREATE TABLE `cms3_import_appointment_employees_services` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_appointment_employees_services_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_appointment_employees_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_appointment_employees_services_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_appointment_employee_schedule`;
CREATE TABLE `cms3_import_appointment_employee_schedule` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_appointment_employee_schedule_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_appointment_employee_schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_appointment_employee_schedule_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_appointment_orders`;
CREATE TABLE `cms3_import_appointment_orders` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_appointment_orders_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_appointment_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_appointment_orders_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_appointment_services`;
CREATE TABLE `cms3_import_appointment_services` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_appointment_services_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_appointment_services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_appointment_services_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_appointment_service_groups`;
CREATE TABLE `cms3_import_appointment_service_groups` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_appointment_service_groups_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_appointment_service_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_appointment_service_groups_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_domains`;
CREATE TABLE `cms3_import_domains` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_DomainSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewId_To_DomainId` FOREIGN KEY (`new_id`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_domain_mirrors`;
CREATE TABLE `cms3_import_domain_mirrors` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_DomainMirrorSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewId_To_DomainMirrorId` FOREIGN KEY (`new_id`) REFERENCES `cms3_domain_mirrows` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_fields`;
CREATE TABLE `cms3_import_fields` (
  `source_id` int(10) unsigned NOT NULL,
  `field_name` varchar(64) NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`),
  KEY `type_id` (`type_id`),
  KEY `field_name` (`field_name`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_FieldSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewFieldId_To_ObjectTypeId` FOREIGN KEY (`type_id`) REFERENCES `cms3_import_types` (`new_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewId_To_ObjectTypeFieldId` FOREIGN KEY (`new_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_groups`;
CREATE TABLE `cms3_import_groups` (
  `source_id` int(10) unsigned NOT NULL,
  `group_name` varchar(48) NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`),
  KEY `type_id` (`type_id`),
  KEY `group_name` (`group_name`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_GroupSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewGroupId_To_ObjectTypeId` FOREIGN KEY (`type_id`) REFERENCES `cms3_import_types` (`new_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewId_To_ObjectTypeGroupId` FOREIGN KEY (`new_id`) REFERENCES `cms3_object_field_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_langs`;
CREATE TABLE `cms3_import_langs` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_LangSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_NewId_To_LangId` FOREIGN KEY (`new_id`) REFERENCES `cms3_langs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_links`;
CREATE TABLE `cms3_import_links` (
  `external_id` int(10) unsigned NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_links_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_links` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_links_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_links_sources`;
CREATE TABLE `cms3_import_links_sources` (
  `external_id` int(11) unsigned NOT NULL,
  `internal_id` int(11) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_links_sources_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_links_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_links_sources_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_mail_notifications`;
CREATE TABLE `cms3_import_mail_notifications` (
  `external_id` int(11) unsigned NOT NULL,
  `internal_id` int(11) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_mail_notifications_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_mail_notifications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_mail_notifications_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_mail_templates`;
CREATE TABLE `cms3_import_mail_templates` (
  `external_id` int(10) unsigned NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_mail_templates_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_mail_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_mail_templates_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_mail_variables`;
CREATE TABLE `cms3_import_mail_variables` (
  `external_id` int(10) unsigned NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_mail_variables_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_mail_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_mail_variables_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_objects`;
CREATE TABLE `cms3_import_objects` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_NewId_To_ObjectsId` FOREIGN KEY (`new_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ObjectSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_offer_list`;
CREATE TABLE `cms3_import_offer_list` (
  `external_id` varchar(255) NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `internal id to offer` FOREIGN KEY (`internal_id`) REFERENCES `cms3_offer_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offer source id to import source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_offer_price_list`;
CREATE TABLE `cms3_import_offer_price_list` (
  `external_id` varchar(255) NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `internal id to price` FOREIGN KEY (`internal_id`) REFERENCES `cms3_offer_price_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `price source id to import source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_offer_price_type_list`;
CREATE TABLE `cms3_import_offer_price_type_list` (
  `external_id` varchar(255) NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `internal id to price type` FOREIGN KEY (`internal_id`) REFERENCES `cms3_offer_price_type_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `price type source id to import source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_redirects`;
CREATE TABLE `cms3_import_redirects` (
  `external_id` int(11) NOT NULL,
  `internal_id` int(11) NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_redirects_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_redirects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_redirects_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_relations`;
CREATE TABLE `cms3_import_relations` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_NewId_To_HierarchyId` FOREIGN KEY (`new_id`) REFERENCES `cms3_hierarchy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_restrictions`;
CREATE TABLE `cms3_import_restrictions` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_NewId_To_RestrictionId` FOREIGN KEY (`new_id`) REFERENCES `cms3_object_fields_restrictions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RestrictionSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_sliders`;
CREATE TABLE `cms3_import_sliders` (
  `external_id` int(10) unsigned NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_sliders_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_sliders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_sliders_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_slides`;
CREATE TABLE `cms3_import_slides` (
  `external_id` int(10) unsigned NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `cms3_import_slides_ibfk_1` FOREIGN KEY (`internal_id`) REFERENCES `cms3_slides` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms3_import_slides_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_sources`;
CREATE TABLE `cms3_import_sources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source_name` (`source_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_stock_balance_list`;
CREATE TABLE `cms3_import_stock_balance_list` (
  `external_id` varchar(255) NOT NULL,
  `internal_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  KEY `external_id` (`external_id`,`source_id`),
  KEY `internal_id` (`internal_id`,`source_id`),
  KEY `source_id` (`source_id`),
  CONSTRAINT `internal id to stock balance` FOREIGN KEY (`internal_id`) REFERENCES `cms3_stock_balance_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stock balance source id to import source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_templates`;
CREATE TABLE `cms3_import_templates` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_NewId_To_TemplateId` FOREIGN KEY (`new_id`) REFERENCES `cms3_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TemplateSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_import_types`;
CREATE TABLE `cms3_import_types` (
  `source_id` int(10) unsigned NOT NULL,
  `old_id` varchar(255) NOT NULL,
  `new_id` int(10) unsigned NOT NULL,
  KEY `source_id` (`source_id`,`old_id`,`new_id`),
  KEY `old_id` (`old_id`,`new_id`),
  KEY `new_id` (`new_id`),
  CONSTRAINT `FK_NewId_To_ObjectTypeId` FOREIGN KEY (`new_id`) REFERENCES `cms3_object_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TypeSourceId_To_Source` FOREIGN KEY (`source_id`) REFERENCES `cms3_import_sources` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_langs`;
CREATE TABLE `cms3_langs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prefix` varchar(16) NOT NULL,
  `title` varchar(255) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prefix` (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_links`;
CREATE TABLE `cms3_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(1024) NOT NULL,
  `address_hash` varchar(32) NOT NULL,
  `place` varchar(255) NOT NULL,
  `broken` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address_hash` (`address_hash`),
  KEY `broken` (`broken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_links_sources`;
CREATE TABLE `cms3_links_sources` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `link_id` int(11) unsigned NOT NULL,
  `place` varchar(255) NOT NULL,
  `type` enum('object','template') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_source` (`link_id`,`place`),
  CONSTRAINT `source link_id` FOREIGN KEY (`link_id`) REFERENCES `cms3_links` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_mail_notifications`;
CREATE TABLE `cms3_mail_notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `module` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name-domain-lang` (`name`,`domain_id`,`lang_id`),
  KEY `lang_id` (`lang_id`),
  KEY `domain_id` (`domain_id`),
  KEY `name` (`name`),
  CONSTRAINT `notification to domain` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `notification to lang` FOREIGN KEY (`lang_id`) REFERENCES `cms3_langs` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_mail_templates`;
CREATE TABLE `cms3_mail_templates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name-notification` (`name`,`notification_id`),
  KEY `name` (`name`),
  KEY `notification_id` (`notification_id`),
  CONSTRAINT `mail template to notification` FOREIGN KEY (`notification_id`) REFERENCES `cms3_mail_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_mail_variables`;
CREATE TABLE `cms3_mail_variables` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(11) unsigned NOT NULL,
  `variable` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_name` (`variable`),
  KEY `template_name` (`template_id`),
  CONSTRAINT `mail variable to template` FOREIGN KEY (`template_id`) REFERENCES `cms3_mail_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_messages`;
CREATE TABLE `cms3_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `sender_id` int(10) unsigned DEFAULT NULL,
  `create_time` int(11) NOT NULL,
  `type` enum('private','sys-event','sys-log') NOT NULL,
  `priority` int(11) DEFAULT 0,
  `is_sended` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `create_time` (`create_time`),
  KEY `priority` (`priority`),
  KEY `type` (`type`),
  KEY `is_sended` (`is_sended`),
  KEY `FK_Messages to user relation` (`sender_id`),
  CONSTRAINT `FK_Messages to user relation` FOREIGN KEY (`sender_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_messages_inbox`;
CREATE TABLE `cms3_messages_inbox` (
  `message_id` int(10) unsigned DEFAULT NULL,
  `recipient_id` int(10) unsigned DEFAULT NULL,
  `is_opened` int(11) DEFAULT 0,
  KEY `message_id` (`message_id`),
  KEY `recipient_id` (`recipient_id`),
  KEY `is_opened` (`is_opened`),
  KEY `FK_MessagesInbox to Messages` (`message_id`),
  KEY `FK_MessagesInbox to User` (`recipient_id`),
  CONSTRAINT `FK_MessagesInbox to Messages` FOREIGN KEY (`message_id`) REFERENCES `cms3_messages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MessagesInbox to User` FOREIGN KEY (`recipient_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_objects`;
CREATE TABLE `cms3_objects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `ord` int(10) unsigned DEFAULT 0,
  `updatetime` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Object to type relation_FK` (`type_id`),
  KEY `name` (`name`),
  KEY `owner_id` (`owner_id`),
  KEY `is_locked` (`is_locked`),
  KEY `ord` (`ord`),
  KEY `guid` (`guid`),
  KEY `updatetime` (`updatetime`),
  CONSTRAINT `FK_Object to type relation` FOREIGN KEY (`type_id`) REFERENCES `cms3_object_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_objects_expiration`;
CREATE TABLE `cms3_objects_expiration` (
  `obj_id` int(10) unsigned NOT NULL,
  `entrytime` int(10) unsigned NOT NULL,
  `expire` int(10) unsigned NOT NULL,
  PRIMARY KEY (`obj_id`),
  KEY `FK_ObjectsExpire to objects` (`obj_id`),
  KEY `entrytime` (`entrytime`,`expire`),
  CONSTRAINT `FK_ObjectsExpire to objects` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_content`;
CREATE TABLE `cms3_object_content` (
  `obj_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `int_val` bigint(20) DEFAULT NULL,
  `varchar_val` varchar(255) DEFAULT NULL,
  `text_val` mediumtext DEFAULT NULL,
  `rel_val` int(10) unsigned DEFAULT NULL,
  `tree_val` int(10) unsigned DEFAULT NULL,
  `float_val` double DEFAULT NULL,
  KEY `Content to object relation_FK` (`obj_id`),
  KEY `Contents field id relation_FK` (`field_id`),
  KEY `Relation value reference_FK` (`rel_val`),
  KEY `content2tree_FK` (`tree_val`),
  KEY `int_val` (`int_val`),
  KEY `varchar_val` (`varchar_val`),
  KEY `float_val` (`float_val`),
  KEY `text_val` (`text_val`(8)),
  KEY `K_Complex_FieldIdAndRelVal` (`field_id`,`rel_val`),
  KEY `K_Complex_FieldIdAndTreeVal` (`field_id`,`tree_val`),
  KEY `K_Complex_ObjIdAndFieldId` (`obj_id`,`field_id`),
  CONSTRAINT `FK_Content to object relation` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Contents field id relation` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Relation value reference` FOREIGN KEY (`rel_val`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_content2tree` FOREIGN KEY (`tree_val`) REFERENCES `cms3_hierarchy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_content_cnt`;
CREATE TABLE `cms3_object_content_cnt` (
  `obj_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `cnt` int(10) DEFAULT 0,
  KEY `FK_Contents_Counters to object relation` (`obj_id`),
  KEY `FK_Contents_Counters field id relation` (`field_id`),
  CONSTRAINT `FK_Contents_Counters field id relation` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Contents_Counters to object relation` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_domain_id_list`;
CREATE TABLE `cms3_object_domain_id_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms3_object_domain_id_list load field value` (`obj_id`,`field_id`),
  KEY `cms3_object_domain_id_list field_id` (`field_id`),
  KEY `cms3_object_domain_id_list obj_id` (`obj_id`),
  KEY `cms3_object_domain_id_list domain_id` (`domain_id`),
  CONSTRAINT `cms3_object_domain_id_list domain id` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms3_object_domain_id_list field id` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms3_object_domain_id_list object id` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_fields`;
CREATE TABLE `cms3_object_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0,
  `field_type_id` int(10) unsigned DEFAULT NULL,
  `is_inheritable` tinyint(1) DEFAULT 0,
  `is_visible` tinyint(1) DEFAULT 1,
  `guide_id` int(10) unsigned DEFAULT NULL,
  `in_search` tinyint(1) DEFAULT 1,
  `in_filter` tinyint(1) DEFAULT 1,
  `tip` varchar(255) DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT NULL,
  `restriction_id` int(10) unsigned DEFAULT NULL,
  `sortable` tinyint(4) DEFAULT 0,
  `is_system` tinyint(1) DEFAULT 0,
  `is_important` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Field to field type relation_FK` (`field_type_id`),
  KEY `FK_Reference_25` (`guide_id`),
  KEY `name` (`name`),
  KEY `title` (`title`),
  KEY `is_locked` (`is_locked`),
  KEY `is_inheritable` (`is_inheritable`),
  KEY `is_visible` (`is_visible`),
  KEY `in_search` (`in_search`),
  KEY `in_filter` (`in_filter`),
  KEY `tip` (`tip`),
  KEY `is_required` (`is_required`),
  KEY `restriction_id` (`restriction_id`),
  KEY `sortable` (`sortable`),
  KEY `is_system` (`is_system`),
  KEY `is_important` (`is_important`),
  CONSTRAINT `FK_Field to field guide relation` FOREIGN KEY (`guide_id`) REFERENCES `cms3_object_types` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_Field to field type relation` FOREIGN KEY (`field_type_id`) REFERENCES `cms3_object_field_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Field to restriction relation` FOREIGN KEY (`restriction_id`) REFERENCES `cms3_object_fields_restrictions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_fields_restrictions`;
CREATE TABLE `cms3_object_fields_restrictions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_prefix` varchar(64) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `field_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Field restriction to field type relation_FK` (`field_type_id`),
  CONSTRAINT `FK_Field restriction to field type relation` FOREIGN KEY (`field_type_id`) REFERENCES `cms3_object_field_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_field_groups`;
CREATE TABLE `cms3_object_field_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_visible` tinyint(1) DEFAULT NULL,
  `ord` int(11) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0,
  `tip` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Group to type relation_FK` (`type_id`),
  KEY `ord` (`ord`),
  KEY `name` (`name`),
  KEY `title` (`title`),
  KEY `is_active` (`is_active`),
  KEY `is_visible` (`is_visible`),
  KEY `is_locked` (`is_locked`),
  CONSTRAINT `FK_Group to type relation` FOREIGN KEY (`type_id`) REFERENCES `cms3_object_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `cms3_object_field_groups` (`id`, `name`, `title`, `type_id`, `is_active`, `is_visible`, `ord`, `is_locked`, `tip`) VALUES
(1,	'svojstva_statusa_stranicy',	'i18n::fields-group-svojstva_statusa_stranicy',	2,	1,	1,	5,	0,	''),
(2,	'common',	'i18n::fields-group-common',	3,	1,	0,	5,	1,	'Основные настройки страницы'),
(4,	'more_params',	'i18n::fields-group-more_params',	3,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(5,	'rate_props',	'i18n::fields-group-rate_props',	3,	1,	0,	20,	1,	''),
(6,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	3,	0,	1,	25,	1,	'Управление статусом публикации'),
(7,	'locks',	'i18n::fields-group-locks',	3,	1,	1,	30,	1,	''),
(8,	'common',	'i18n::fields-group-news-rss-source-charset-common',	6,	1,	1,	5,	0,	''),
(9,	'common',	'i18n::fields-group-common',	7,	1,	0,	5,	0,	'Основные настройки ленты новостей'),
(11,	'more_params',	'i18n::fields-group-more_params',	7,	1,	0,	15,	0,	'Настройки отображения страницы и её поисковой индексации'),
(12,	'rate_voters',	'i18n::fields-group-rate_voters',	7,	1,	0,	20,	0,	''),
(13,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	7,	0,	1,	25,	1,	'Управление статусом публикации'),
(14,	'locks',	'i18n::fields-group-locks',	7,	1,	1,	30,	1,	''),
(15,	'common',	'i18n::fields-group-common',	8,	1,	1,	5,	0,	''),
(16,	'props',	'i18n::fields-group-props',	9,	1,	1,	5,	0,	''),
(17,	'params_more',	'i18n::fields-group-dopolnitelno',	10,	1,	1,	5,	0,	'Страна в формате ISO 3166-1 alpha-2'),
(18,	'common',	'i18n::fields-group-common',	14,	1,	1,	5,	0,	''),
(19,	'common',	'i18n::fields-group-common',	15,	1,	1,	5,	0,	''),
(20,	'additional',	'i18n::fields-group-grp_disp_msg_extended',	16,	1,	1,	5,	0,	'Порядковый номер дня недели (1 (Понедельник) - 7 (Воскресение))'),
(21,	'additional',	'i18n::fields-group-grp_disp_msg_extended',	17,	1,	1,	5,	0,	'Порядковый номер дня недели (1 (Понедельник) - 7 (Воскресение))'),
(23,	'common',	'i18n::fields-group-common',	20,	1,	1,	5,	1,	''),
(24,	'props_currency',	'i18n::fields-group-currency_props',	21,	1,	1,	5,	0,	'Общие настройки валюты'),
(25,	'credit_status_props',	'i18n::fields-group-credit-status-props',	22,	1,	1,	5,	0,	''),
(26,	'common',	'i18n::fields-group-emarket-mobile-platform-common',	23,	1,	1,	5,	1,	''),
(27,	'common',	'i18n::fields-group-emarket-mobile-devices-common',	24,	1,	1,	5,	0,	''),
(28,	'personal',	'i18n::fields-group-personal_info',	25,	1,	1,	5,	1,	''),
(29,	'common',	'i18n::fields-group-common_group',	27,	1,	1,	5,	1,	''),
(30,	'common',	'i18n::common',	28,	1,	1,	5,	0,	''),
(31,	'common',	'i18n::common',	29,	1,	1,	5,	0,	''),
(32,	'discount_type_props',	'i18n::fields-group-discount_type_props',	30,	1,	1,	5,	0,	''),
(33,	'discount_modificator_type_props',	'i18n::fields-group-discount_modificator_type_props',	31,	1,	1,	5,	0,	''),
(34,	'discount_modificator_props',	'i18n::fields-group-discount_modificator_props',	32,	1,	1,	5,	0,	''),
(35,	'discount_rule_type_props',	'i18n::fields-group-discount_rule_type_props',	33,	1,	1,	5,	0,	''),
(36,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	34,	1,	1,	5,	0,	''),
(37,	'common',	'i18n::fields-group-props',	35,	1,	1,	5,	0,	'Служит для связи с обработчиками, заполняется разработчиком импотрера'),
(38,	'common',	'i18n::fields-group-props',	36,	1,	1,	5,	0,	'Служит для связи с обработчиками, заполняется разработчиком импотрера'),
(39,	'network_system_props',	'i18n::fields-group-service_props',	37,	1,	1,	5,	0,	''),
(40,	'props',	'i18n::fields-group-props',	38,	1,	1,	5,	1,	'Здесь в дополнение к разделам каталога, можно выбрать, какие страницы нужно показывать в социальной сети'),
(41,	'pages',	'i18n::fields-group-site_parts',	38,	1,	1,	10,	1,	''),
(42,	'network_system_props',	'i18n::fields-group-service_props',	38,	1,	1,	15,	0,	'Настройки интеграции интернет-магазина с социальными сетями'),
(43,	'svojstva_gruppy_polzovatelej',	'i18n::fields-group-svojstva_gruppy_polzovatelej',	39,	1,	0,	5,	1,	'Общие настройки группы пользователей'),
(44,	'common',	'i18n::fields-group-osnovnoe',	40,	1,	1,	5,	0,	''),
(45,	'item_type_props',	'i18n::fields-group-item_type_props',	41,	1,	1,	5,	0,	''),
(46,	'discount_props',	'i18n::fields-group-discount_props',	42,	1,	1,	5,	0,	'Определяет область применения скидки'),
(47,	'item_props',	'i18n::fields-group-order_item_props',	44,	1,	1,	5,	0,	'i18n::field-order-item-discount-value'),
(48,	'item_optioned_props',	'i18n::fields-group-item_optioned_props',	44,	1,	1,	10,	0,	''),
(49,	'trade_offers',	'i18n::fields-group-trade-offers',	44,	1,	1,	15,	0,	'Торговое предложение товарного наименования'),
(50,	'order_status_props',	'i18n::fields-group-order_status_props',	45,	1,	1,	5,	0,	''),
(51,	'payment_type_props',	'i18n::fields-group-payment_type_props',	46,	1,	1,	5,	0,	''),
(52,	'payment_props',	'i18n::fields-group-payment_props',	47,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(53,	'order_status_props',	'i18n::fields-group-payment_status_props',	48,	1,	1,	5,	0,	''),
(54,	'general',	'i18n::fields-group-osnovnoe',	49,	1,	1,	5,	0,	''),
(55,	'addresses',	'i18n::fields-group-addresses',	49,	1,	1,	10,	0,	''),
(56,	'payment',	'i18n::fields-group-payment_info',	49,	1,	1,	15,	0,	''),
(57,	'delivery_type_props',	'i18n::fields-group-delivery_type_props',	50,	1,	1,	5,	0,	''),
(58,	'delivery_description_props',	'i18n::fields-group-delivery_description',	51,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(59,	'order_status_props',	'i18n::fields-group-delivery_status_props',	52,	1,	1,	5,	0,	''),
(60,	'order_props',	'i18n::fields-group-order_props',	53,	1,	1,	5,	0,	'Выставляется автоматически, когда происходит изменение статуса заказа'),
(61,	'order_credit_props',	'i18n::fields-group-credit',	53,	1,	1,	10,	0,	''),
(62,	'statistic_info',	'i18n::fields-group-statistic_data',	53,	1,	1,	15,	0,	'Поведенческие данные о покупателе. Используются для анализа эффективности различных каналов продвижения. Получить общую статистику по всем заказам или сделать выборку можно в модуле «Интернет-магазин» —> вкладка «Статистика»'),
(63,	'order_payment_props',	'i18n::fields-group-order_payment_props',	53,	1,	1,	20,	0,	'Дата успешной оплаты заказа'),
(64,	'order_delivery_props',	'i18n::fields-group-order_delivery_props',	53,	1,	1,	25,	0,	'Дата, когда товар будет доставлен клиенту или на пункт выдачи'),
(65,	'order_discount_props',	'i18n::fields-group-order_discount_props',	53,	1,	1,	30,	0,	''),
(66,	'integration_date',	'i18n::fields-group-intergation_props',	53,	1,	1,	35,	0,	'Выставляется системой автоматически, когда заказ необходимо выгрузить в 1С'),
(67,	'purchase_one_click',	'i18n::fields-group-purchase_one_click',	53,	1,	1,	40,	0,	''),
(68,	'idetntify_data',	'i18n::fields-group-idetntify_data',	54,	1,	0,	5,	1,	'Адрес сервиса'),
(69,	'more_info',	'i18n::fields-group-more_info',	54,	1,	1,	10,	0,	'Список доступных пользователю директорий. В качестве разделителя используется запятая - например: /image/cms, /files.'),
(70,	'short_info',	'i18n::fields-group-short_info',	54,	1,	1,	15,	0,	'Это поле содержит Имя пользователя. Оно отображается в характеристиках пользователя и может быть изменено самим пользователем.'),
(71,	'delivery',	'i18n::fields-group-trans_deliver',	54,	1,	1,	20,	0,	''),
(72,	'statistic_info',	'i18n::fields-group-statistic_data',	54,	1,	1,	25,	0,	'Статистические данные о поведении пользователя на сайте'),
(73,	'store_props',	'i18n::fields-group-store_props',	55,	1,	1,	5,	0,	'Основной склад, с которого будут списываться товары при покупке, и с которым будет синхронизироваться 1C'),
(74,	'discount_modificator_props',	'i18n::fields-group-discount_modificator_props',	56,	1,	1,	5,	0,	'Настройка размера скидки'),
(75,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	57,	1,	1,	5,	0,	'Пользователи, которым будет доступна скидка'),
(76,	'common',	'i18n::fields-group-menu_common',	58,	1,	1,	5,	0,	'Основные настройки меню'),
(77,	'common',	'i18n::fields-group-common',	60,	1,	0,	5,	1,	'Основные настройки новости'),
(78,	'item_props',	'i18n::fields-group-item_props',	60,	1,	0,	10,	1,	'Основные свойства публикации новости'),
(80,	'more_params',	'i18n::fields-group-more_params',	60,	1,	0,	20,	1,	'Настройки отображения страницы и её поисковой индексации'),
(81,	'news_images',	'i18n::fields-group-news_images',	60,	1,	1,	25,	0,	'Управление изображениями новости'),
(82,	'subjects_block',	'i18n::fields-group-subjects_block',	60,	1,	1,	30,	1,	'Сюжеты служат для группировки новостей по тематикам. Список последних новостей, связанных с данной по сюжету, можно вывести при помощи макроса <a target=\"_blank\" href=\"http://dev.docs.umi-cms.ru/spravochnik_makrosov_umicms/novosti/news_related_links/\">news related_links()</a>'),
(83,	'rate_voters',	'i18n::fields-group-rate_voters',	60,	1,	0,	35,	1,	''),
(84,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	60,	0,	1,	40,	1,	'Управление статусом публикации'),
(85,	'locks',	'i18n::fields-group-locks',	60,	1,	1,	45,	1,	''),
(86,	'common',	'i18n::fields-group-common',	61,	1,	0,	5,	1,	'Основные настройки страницы'),
(88,	'more_params',	'i18n::fields-group-more_params',	61,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(89,	'rate_voters',	'i18n::fields-group-rate_voters',	61,	1,	0,	20,	1,	''),
(90,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	61,	0,	1,	25,	1,	'Управление статусом публикации'),
(91,	'locks',	'i18n::fields-group-locks',	61,	1,	1,	30,	1,	''),
(92,	'props',	'i18n::fields-group-props',	62,	1,	1,	5,	0,	''),
(93,	'common',	'i18n::fields-group-common',	63,	1,	0,	5,	1,	'Основные настройки блога'),
(95,	'more_params',	'i18n::fields-group-more_params',	63,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(96,	'rate_props',	'i18n::fields-group-rate_props',	63,	1,	0,	20,	1,	''),
(97,	'props',	'i18n::fields-group-props',	64,	1,	1,	5,	1,	'Основная информация об авторе'),
(98,	'common',	'i18n::fields-group-common',	65,	1,	0,	5,	1,	'Идентификатор автора комментария'),
(99,	'rate_props',	'i18n::fields-group-rate_props',	65,	1,	0,	10,	1,	''),
(100,	'antispam',	'i18n::fields-group-antispam',	65,	1,	1,	15,	0,	'Пометка «Спам» скрывает нежелательные комментарии из блога'),
(101,	'common',	'i18n::fields-group-common',	66,	1,	0,	5,	1,	'Основные настройки поста блога'),
(103,	'more_params',	'i18n::fields-group-more_params',	66,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(104,	'rate_props',	'i18n::fields-group-rate_props',	66,	1,	0,	20,	1,	''),
(105,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	66,	0,	1,	25,	1,	'Управление статусом публикации'),
(106,	'locks',	'i18n::fields-group-locks',	66,	1,	1,	30,	1,	''),
(107,	'privacy',	'i18n::fields-group-privacy',	66,	1,	1,	35,	0,	'Настройки видимости поста для авторов и пользователей'),
(108,	'antispam',	'i18n::fields-group-antispam',	66,	1,	1,	40,	0,	'Пометка «Спам» скрывает нежелательные посты из блога'),
(109,	'common',	'i18n::fields-group-common',	67,	1,	0,	5,	1,	'Основные настройки конференции'),
(111,	'more_params',	'i18n::fields-group-more_params',	67,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(112,	'rate_voters',	'i18n::fields-group-rate_voters',	67,	1,	0,	20,	1,	''),
(113,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	67,	0,	1,	25,	1,	'Управление статусом публикации'),
(114,	'locks',	'i18n::fields-group-locks',	67,	1,	1,	30,	1,	''),
(115,	'common',	'i18n::fields-group-common',	68,	1,	0,	5,	1,	'Основные настройки топика'),
(117,	'more_params',	'i18n::fields-group-more_params',	68,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(118,	'topic_props',	'i18n::fields-group-topic_props',	68,	1,	0,	20,	1,	'Свойства публикации топика'),
(119,	'rate_voters',	'i18n::fields-group-rate_voters',	68,	1,	0,	25,	1,	''),
(120,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	68,	0,	1,	30,	1,	'Управление статусом публикации'),
(121,	'locks',	'i18n::fields-group-locks',	68,	1,	1,	35,	1,	''),
(122,	'common',	'i18n::fields-group-common',	69,	1,	0,	5,	1,	'Основные настройки сообщения форума'),
(124,	'more_params',	'i18n::fields-group-more_params',	69,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(125,	'message_props',	'i18n::fields-group-message_props',	69,	1,	0,	20,	1,	'Свойства публикации сообщения'),
(126,	'rate_voters',	'i18n::fields-group-rate_voters',	69,	1,	0,	25,	1,	''),
(127,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	69,	0,	1,	30,	1,	'Управление статусом публикации'),
(128,	'locks',	'i18n::fields-group-locks',	69,	1,	1,	35,	1,	''),
(129,	'common',	'i18n::fields-group-common',	70,	1,	0,	5,	1,	'Основные настройки комментария'),
(131,	'more_params',	'i18n::fields-group-more_params',	70,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(132,	'comment_props',	'i18n::fields-group-comment_props',	70,	1,	0,	20,	1,	'Свойства публикации комментария'),
(133,	'rate_voters',	'i18n::fields-group-rate_voters',	70,	1,	0,	25,	1,	''),
(134,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	70,	0,	1,	30,	1,	'Управление статусом публикации'),
(135,	'locks',	'i18n::fields-group-locks',	70,	1,	1,	35,	1,	''),
(136,	'antispam',	'i18n::fields-group-antispam',	70,	1,	1,	40,	0,	'Пометив нежелательные комментарии как спам, вы сможете их отфильтровать для выполнения групповых операций — например, удалить комментарии или/и блокировать автора'),
(137,	'common_props',	'i18n::fields-group-common_props',	71,	1,	1,	5,	1,	''),
(138,	'common',	'i18n::fields-group-common',	72,	1,	0,	5,	1,	'Основные настройки опроса'),
(140,	'more_params',	'i18n::fields-group-more_params',	72,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(141,	'poll_props',	'i18n::fields-group-poll_props',	72,	1,	0,	20,	1,	'Настройки опроса'),
(142,	'rate_voters',	'i18n::fields-group-rate_voters',	72,	1,	0,	25,	1,	''),
(143,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	72,	0,	1,	30,	1,	'Управление статусом публикации'),
(144,	'locks',	'i18n::fields-group-locks',	72,	1,	1,	35,	1,	''),
(145,	'common',	'i18n::fields-group-common',	73,	1,	0,	5,	1,	'Основные настройки страницы'),
(147,	'more_params',	'i18n::fields-group-more_params',	73,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(148,	'rate_props',	'i18n::fields-group-rate_props',	73,	1,	0,	20,	1,	''),
(149,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	73,	0,	1,	25,	1,	'Управление статусом публикации'),
(150,	'locks',	'i18n::fields-group-locks',	73,	1,	1,	30,	1,	''),
(151,	'binding',	'i18n::fields-group-Binding',	73,	1,	0,	35,	0,	'Привязать к этой странице форму обратной связи'),
(152,	'sendingdata',	'i18n::fields-group-SendingData',	74,	1,	0,	5,	1,	''),
(153,	'templates',	'i18n::fields-group-Templates',	75,	1,	1,	5,	1,	'Настройки шаблона письма, которое получит администратор сайта при отправке пользователем сообщения через форму обратной связи'),
(154,	'auto_reply',	'i18n::fields-group-auto_reply',	75,	1,	1,	10,	1,	'Настройки шаблона автоответа, который получит пользователь при отправке сообщения через форму обратной связи'),
(155,	'messages',	'i18n::fields-group-messages',	75,	1,	1,	15,	1,	'Сообщение, которое будет отображаться на странице успешной отправки формы обратной связи'),
(156,	'binding',	'i18n::fields-group-Binding',	75,	1,	0,	20,	1,	'Привязка шаблона автоответа к форме обратной связи'),
(157,	'list',	'i18n::fields-group-list',	76,	1,	1,	5,	0,	'Списки адресов получателей формы'),
(158,	'common',	'i18n::fields-group-common',	77,	1,	0,	5,	1,	'Основные настройки фотоальбома'),
(160,	'more_params',	'i18n::fields-group-more_params',	77,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(161,	'album_props',	'i18n::fields-group-album_props',	77,	1,	0,	20,	1,	'Основные настройки фотоальбома'),
(162,	'rate_voters',	'i18n::fields-group-rate_voters',	77,	1,	0,	25,	1,	''),
(163,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	77,	0,	1,	30,	1,	'Управление статусом публикации'),
(164,	'locks',	'i18n::fields-group-locks',	77,	1,	1,	35,	1,	''),
(165,	'common',	'i18n::fields-group-common',	78,	1,	0,	5,	1,	'Основные настройки фотографии'),
(167,	'more_params',	'i18n::fields-group-more_params',	78,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(168,	'photo_props',	'i18n::fields-group-photo_props',	78,	1,	0,	20,	1,	'Основные настройки фотографии'),
(169,	'rate_voters',	'i18n::fields-group-rate_voters',	78,	1,	0,	25,	1,	''),
(170,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	78,	0,	1,	30,	1,	'Управление статусом публикации'),
(171,	'locks',	'i18n::fields-group-locks',	78,	1,	1,	35,	1,	''),
(172,	'common',	'i18n::fields-group-common',	79,	1,	0,	5,	1,	'Основные настройки проектов FAQ'),
(174,	'more_params',	'i18n::fields-group-more_params',	79,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(175,	'rate_voters',	'i18n::fields-group-rate_voters',	79,	1,	0,	20,	1,	''),
(176,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	79,	0,	1,	25,	1,	'Управление статусом публикации'),
(177,	'locks',	'i18n::fields-group-locks',	79,	1,	1,	30,	1,	''),
(178,	'common',	'i18n::fields-group-common',	80,	1,	0,	5,	1,	'Основные настройки категории вопросов'),
(180,	'more_params',	'i18n::fields-group-more_params',	80,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(181,	'rate_voters',	'i18n::fields-group-rate_voters',	80,	1,	0,	20,	1,	''),
(182,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	80,	0,	1,	25,	1,	'Управление статусом публикации'),
(183,	'locks',	'i18n::fields-group-locks',	80,	1,	1,	30,	1,	''),
(184,	'common',	'i18n::fields-group-common',	81,	1,	0,	5,	1,	'Вопрос пользователя'),
(186,	'more_params',	'i18n::fields-group-more_params',	81,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(187,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	81,	0,	1,	20,	1,	'Управление статусом публикации'),
(188,	'locks',	'i18n::fields-group-locks',	81,	1,	1,	25,	1,	''),
(189,	'antispam',	'i18n::fields-group-antispam',	81,	1,	1,	30,	0,	'Пометка «Спам» скрывает нежелательные вопросы из категории FAQ'),
(190,	'grp_disp_props',	'i18n::fields-group-grp_disp_props',	82,	1,	1,	5,	0,	'Может быть установлено только для одной рассылки одновременно'),
(191,	'auto_settings',	'i18n::fields-group-auto_mailout_settings',	82,	1,	1,	10,	0,	'Дни недели, в которые будет происходить автоматическая рассылка'),
(192,	'grp_disp_release_props',	'i18n::fields-group-grp_disp_release_props',	83,	1,	1,	5,	0,	'Основные настройки выпуска рассылки'),
(193,	'grp_disp_msg_props',	'i18n::fields-group-grp_disp_msg_props',	84,	1,	0,	5,	0,	'Основные настройки сообщения рассылки'),
(194,	'grp_disp_msg_extended',	'i18n::fields-group-grp_disp_msg_extended',	84,	1,	1,	10,	0,	'Дополнительные настройки сообщения рассылки'),
(195,	'grp_sbs_props',	'i18n::fields-group-grp_sbs_props',	85,	1,	0,	5,	0,	'Основные данные подписчика'),
(196,	'grp_sbs_extended',	'i18n::fields-group-grp_sbs_extended',	85,	1,	1,	10,	0,	'Информация о подписках пользователя'),
(197,	'common',	'i18n::fields-group-common',	86,	1,	0,	5,	1,	'Основные настройки страницы и её расположения в структуре каталога'),
(199,	'more_params',	'i18n::fields-group-more_params',	86,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(200,	'dopolnitelno',	'i18n::fields-group-dopolnitelno',	86,	1,	1,	20,	0,	'Управление описаниями раздела каталога'),
(201,	'rate_voters',	'i18n::fields-group-rate_voters',	86,	1,	0,	25,	1,	''),
(202,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	86,	0,	1,	30,	1,	'Управление статусом публикации'),
(203,	'locks',	'i18n::fields-group-locks',	86,	1,	1,	35,	1,	''),
(204,	'filter_index',	'i18n::fields-group-filter_index',	86,	1,	0,	40,	1,	''),
(205,	'common',	'i18n::fields-group-common',	87,	1,	0,	5,	1,	'Основные настройки товара'),
(207,	'more_params',	'i18n::fields-group-more_params',	87,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(208,	'cenovye_svojstva',	'i18n::fields-group-cenovye_svojstva',	87,	1,	1,	20,	0,	'Ценовые свойства товара'),
(209,	'catalog_option_props',	'i18n::fields-group-option_props',	87,	1,	1,	25,	0,	''),
(210,	'catalog_stores_props',	'i18n::fields-group-stores',	87,	1,	1,	30,	0,	'Количество зарезервированных товаров'),
(211,	'trade_offers',	'i18n::fields-group-trade-offers',	87,	1,	1,	35,	0,	'Торговые предложения и их характеристики'),
(212,	'rate_voters',	'i18n::fields-group-rate_voters',	87,	1,	0,	40,	1,	''),
(213,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	87,	0,	1,	45,	1,	'Управление статусом публикации'),
(214,	'locks',	'i18n::fields-group-locks',	87,	1,	1,	50,	1,	''),
(215,	'personal_info',	'i18n::fields-group-personal_info',	88,	1,	1,	5,	0,	''),
(216,	'contact_props',	'i18n::fields-group-contacts',	88,	1,	1,	10,	0,	''),
(217,	'delivery',	'i18n::fields-group-trans_deliver',	88,	1,	0,	15,	0,	''),
(218,	'yuridicheskie_dannye',	'i18n::fields-group-yuridicheskie_dannye',	88,	1,	0,	20,	0,	''),
(219,	'discount_modificator_props',	'i18n::fields-group-discount_modificator_props',	89,	1,	1,	5,	0,	'Размер скидки, который будет вычтен из стоимости заказа'),
(220,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	90,	1,	1,	5,	0,	'К каким товарам/разделам каталога применять скидку?'),
(221,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	91,	1,	1,	5,	0,	'Определяет, с какого момента скидка будет действительна'),
(222,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	92,	1,	1,	5,	0,	'Минимальная стоимость заказа, когда действует скидка'),
(223,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	93,	1,	1,	5,	0,	'Минимальная сумма стоимости заказов действия скидки'),
(224,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	94,	1,	1,	5,	0,	'Список групп пользователей, которым будет доступна эта скидка'),
(225,	'discount_rule_props',	'i18n::fields-group-discount_rule_props',	95,	1,	1,	5,	0,	'Список товаров, которые должен положить в корзину пользователь, чтобы пойдействовала скидка'),
(226,	'delivery_description_props',	'i18n::fields-group-delivery_description',	96,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(227,	'delivery_description_props',	'i18n::fields-group-delivery_description',	97,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(228,	'delivery_courier_props',	'i18n::fields-group-delivery_courier_props',	97,	1,	1,	10,	0,	'Стоимость заказа, после которой доставка производится бесплатно'),
(229,	'delivery_description_props',	'i18n::fields-group-delivery_description',	98,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(230,	'settings',	'i18n::fields-group-settings',	98,	1,	1,	10,	0,	'Настройки этого способа доставки Почтой России'),
(231,	'delivery_description_props',	'i18n::fields-group-delivery_description',	99,	1,	1,	5,	0,	'Общие настройки способа доставки'),
(232,	'settings',	'i18n::fields-group-settings',	99,	1,	1,	10,	1,	'Если установлено - не будет отображаться на сайте'),
(233,	'payment_props',	'i18n::fields-group-payment_props',	100,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(234,	'settings',	'i18n::fields-group-parameters',	100,	1,	1,	10,	0,	''),
(235,	'payment_props',	'i18n::fields-group-payment_props',	101,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(236,	'settings',	'i18n::fields-group-parameters',	101,	1,	1,	10,	0,	'Выдается при регистрации в PayOnline System'),
(237,	'payment_props',	'i18n::fields-group-payment_props',	102,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(238,	'payment_props',	'i18n::fields-group-payment_props',	103,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(239,	'settings',	'i18n::fields-group-parameters',	103,	1,	1,	10,	0,	'используется интерфейсом инициализации оплаты'),
(240,	'payment_props',	'i18n::fields-group-payment_props',	104,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(241,	'settings',	'i18n::fields-group-parameters',	104,	1,	1,	10,	0,	'Номер сайта продавца, на который покупатель должен совершить платеж'),
(242,	'payment_props',	'i18n::fields-group-payment_props',	105,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(243,	'organization',	'i18n::fields-group-organization_data',	105,	1,	1,	10,	0,	''),
(244,	'payment_props',	'i18n::fields-group-payment_props',	106,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(245,	'settings',	'i18n::fields-group-parameters',	106,	1,	1,	10,	0,	'Введите demo.moneta.ru, если у вас включен тестовый режим, либо www.payanyway.ru, если включен боевой режим.'),
(246,	'payment_props',	'i18n::fields-group-payment_props',	107,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(247,	'settings',	'i18n::fields-group-parameters',	107,	1,	1,	10,	0,	'Настройки способа оплаты данного типа'),
(248,	'payment_props',	'i18n::fields-group-payment_props',	108,	1,	1,	5,	0,	'Включить демо-режим'),
(249,	'payment_props',	'i18n::fields-group-payment_props',	109,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(250,	'settings',	'i18n::fields-group-parameters',	109,	1,	1,	10,	0,	'ID магазина'),
(251,	'payment_props',	'i18n::fields-group-payment_props',	110,	1,	1,	5,	0,	'Если установлено - не будет отображаться на сайте'),
(252,	'settings',	'i18n::fields-group-parameters',	110,	1,	1,	10,	0,	'Номер магазина в ЦПП. Выдается ЦПП'),
(253,	'payment_props',	'i18n::fields-group-payment_props',	111,	1,	1,	5,	1,	'Если установлено - не будет отображаться на сайте'),
(254,	'settings',	'i18n::fields-group-parameters',	111,	1,	1,	10,	1,	'Настройки способа оплаты данного типа'),
(255,	'payment_props',	'i18n::fields-group-payment_props',	112,	1,	1,	5,	1,	'Если установлено - не будет отображаться на сайте'),
(256,	'settings',	'i18n::fields-group-parameters',	112,	1,	1,	10,	1,	'Идентификатор вашего магазина в Яндекс.Кассе'),
(257,	'common_props',	'i18n::fields-group-common_props',	113,	1,	1,	5,	1,	''),
(258,	'common',	'i18n::fields-group-common',	114,	1,	0,	5,	1,	'Основные настройки баннера'),
(259,	'redirect_props',	'i18n::fields-group-redirect_props',	114,	1,	0,	10,	1,	'Настройки перехода с баннера'),
(260,	'view_params',	'i18n::fields-group-view_params',	114,	1,	0,	15,	1,	'Статистика и ограничения баннера'),
(261,	'view_pages',	'i18n::fields-group-view_pages',	114,	1,	1,	20,	1,	'Где будет отображаться баннер'),
(262,	'time_targeting',	'i18n::fields-group-time_targeting',	114,	1,	1,	25,	1,	'Таргетинг показов баннера по временным параметрам'),
(263,	'city_targeting',	'i18n::fields-group-city_targeting',	114,	0,	1,	30,	1,	''),
(264,	'view_settings',	'i18n::fields-group-privacy',	114,	1,	1,	35,	0,	'Настройки отображения баннера'),
(265,	'common',	'i18n::fields-group-common',	115,	1,	0,	5,	1,	'Основные настройки баннера'),
(266,	'banner_custom_props',	'i18n::fields-group-banner_custom_props',	115,	1,	1,	10,	1,	'Графические настройки баннера'),
(267,	'redirect_props',	'i18n::fields-group-redirect_props',	115,	1,	0,	15,	1,	'Настройки перехода с баннера'),
(268,	'view_params',	'i18n::fields-group-view_params',	115,	1,	0,	20,	1,	'Статистика и ограничения баннера'),
(269,	'view_pages',	'i18n::fields-group-view_pages',	115,	1,	1,	25,	1,	'Где будет отображаться баннер'),
(270,	'time_targeting',	'i18n::fields-group-time_targeting',	115,	1,	1,	30,	1,	'Таргетинг показов баннера по временным параметрам'),
(271,	'city_targeting',	'i18n::fields-group-city_targeting',	115,	0,	1,	35,	1,	''),
(272,	'view_settings',	'i18n::fields-group-privacy',	115,	1,	1,	40,	0,	'Настройки отображения баннера'),
(273,	'common',	'i18n::fields-group-common',	116,	1,	0,	5,	1,	''),
(274,	'banner_custom_props',	'i18n::fields-group-banner_custom_props',	116,	1,	1,	10,	1,	'Графические настройки баннера'),
(275,	'redirect_props',	'i18n::fields-group-redirect_props',	116,	1,	0,	15,	1,	'Настройки перехода с баннера'),
(276,	'view_params',	'i18n::fields-group-view_params',	116,	1,	0,	20,	1,	'Статистика и ограничения баннера'),
(277,	'view_pages',	'i18n::fields-group-view_pages',	116,	1,	1,	25,	1,	'Где будет отображаться баннер'),
(278,	'time_targeting',	'i18n::fields-group-time_targeting',	116,	1,	1,	30,	1,	'Таргетинг показов баннера по временным параметрам'),
(279,	'city_targeting',	'i18n::fields-group-city_targeting',	116,	0,	1,	35,	1,	''),
(280,	'view_settings',	'i18n::fields-group-privacy',	116,	1,	1,	40,	0,	'Настройки отображения баннера'),
(281,	'common',	'i18n::fields-group-common',	117,	1,	0,	5,	1,	'Основные настройки баннера'),
(282,	'banner_custom_props',	'i18n::fields-group-banner_custom_props',	117,	1,	1,	10,	1,	'Содержимое баннера'),
(283,	'redirect_props',	'i18n::fields-group-redirect_props',	117,	1,	0,	15,	1,	'Настройки перехода с баннера'),
(284,	'view_params',	'i18n::fields-group-view_params',	117,	1,	0,	20,	1,	'Статистика и ограничения баннера'),
(285,	'view_pages',	'i18n::fields-group-view_pages',	117,	1,	1,	25,	1,	'Где будет отображаться баннер'),
(286,	'time_targeting',	'i18n::fields-group-time_targeting',	117,	1,	1,	30,	1,	'Таргетинг показов баннера по временным параметрам'),
(287,	'city_targeting',	'i18n::fields-group-city_targeting',	117,	0,	1,	35,	1,	''),
(288,	'view_settings',	'i18n::fields-group-privacy',	117,	1,	1,	40,	0,	'Настройки отображения баннера'),
(289,	'svojstva',	'i18n::fields-group-svojstva',	118,	1,	1,	5,	0,	''),
(290,	'common',	'i18n::fields-group-props',	119,	1,	1,	5,	0,	'Формат, в который будут преобразованы данные из UMI.CMS'),
(291,	'common',	'i18n::fields-group-common',	120,	1,	1,	5,	1,	'Формат, в который будут перобразованы данные из UMI.CMS'),
(292,	'channel_meta',	'i18n::fields-group-channel-meta',	120,	1,	1,	10,	0,	'<p><a href=\"https://tech.yandex.ru/turbo/doc/rss/markup-docpage/\">https://tech.yandex.ru/turbo/doc/rss/markup-docpage/</a></p>'),
(293,	'channel_web_analytics',	'i18n::fields-group-channel-web-analytics',	120,	1,	1,	15,	0,	'<p><a href=\"https://tech.yandex.ru/turbo/doc/settings/analytics-docpage/\">https://tech.yandex.ru/turbo/doc/settings/analytics-docpage/</a></p>'),
(294,	'channel_advertising',	'i18n::fields-group-channel-advertising',	120,	1,	1,	20,	0,	'<p><a href=\"https://tech.yandex.ru/turbo/doc/settings/ads-docpage/\">https://tech.yandex.ru/turbo/doc/settings/ads-docpage/</a></p>'),
(295,	'common',	'i18n::fields-group-props',	121,	1,	1,	5,	0,	'Формат импотрируемых данных'),
(296,	'common',	'i18n::fields-group-common',	122,	1,	0,	5,	1,	'Основные настройки страницы скачиваемого файла'),
(298,	'more_params',	'i18n::fields-group-more_params',	122,	1,	0,	15,	1,	'Настройки отображения страницы и её поисковой индексации'),
(299,	'fs_file_props',	'i18n::fields-group-fs_file_props',	122,	1,	0,	20,	1,	'Свойства скачиваемого файла'),
(300,	'rate_voters',	'i18n::fields-group-rate_voters',	122,	1,	0,	25,	1,	''),
(301,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	122,	0,	1,	30,	1,	'Управление статусом публикации'),
(302,	'locks',	'i18n::fields-group-locks',	122,	1,	1,	35,	1,	''),
(303,	'common',	'i18n::fields-group-common_group',	123,	1,	0,	5,	1,	''),
(304,	'common',	'i18n::fields-group-common',	124,	1,	1,	5,	1,	''),
(305,	'common',	'i18n::fields-group-common',	125,	1,	1,	5,	1,	''),
(306,	'common',	'i18n::fields-group-common',	126,	1,	0,	5,	1,	''),
(308,	'more_params',	'i18n::fields-group-more_params',	126,	1,	0,	15,	1,	''),
(309,	'rate_props',	'i18n::fields-group-rate_props',	126,	1,	0,	20,	1,	''),
(310,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	126,	0,	1,	25,	1,	''),
(311,	'locks',	'i18n::fields-group-locks',	126,	1,	1,	30,	1,	''),
(312,	'appointment',	'i18n::fields-group-appointment',	126,	1,	1,	35,	1,	''),
(313,	'sendingdata',	'i18n::fields-group-SendingData',	127,	1,	0,	5,	1,	NULL),
(314,	'form_fields',	'Поля формы',	127,	1,	1,	10,	0,	''),
(315,	'common',	'i18n::fields-group-common_group',	128,	1,	0,	5,	1,	NULL),
(316,	'header',	'Шапка',	128,	1,	1,	10,	0,	''),
(317,	'custom_styles',	'Настройки стиля',	128,	1,	1,	15,	0,	''),
(318,	'footer',	'Подвал',	128,	1,	1,	20,	0,	''),
(319,	'params',	'i18n::fields-group-parameters',	129,	1,	1,	5,	0,	''),
(320,	'additional_content',	'Дополнительный контент',	3,	1,	1,	35,	0,	''),
(321,	'additional_content',	'Дополнительный контент',	7,	1,	1,	35,	0,	''),
(322,	'additional_content',	'Дополнительный контент',	37,	1,	1,	10,	0,	''),
(323,	'additional_content',	'Дополнительный контент',	38,	1,	1,	20,	0,	''),
(324,	'additional_content',	'Дополнительный контент',	60,	1,	1,	50,	0,	''),
(325,	'additional_content',	'Дополнительный контент',	61,	1,	1,	35,	0,	''),
(326,	'additional_content',	'Дополнительный контент',	63,	1,	1,	25,	0,	''),
(327,	'additional_content',	'Дополнительный контент',	65,	1,	1,	20,	0,	''),
(328,	'additional_content',	'Дополнительный контент',	66,	1,	1,	45,	0,	''),
(329,	'additional_content',	'Дополнительный контент',	67,	1,	1,	35,	0,	''),
(330,	'additional_content',	'Дополнительный контент',	68,	1,	1,	40,	0,	''),
(331,	'additional_content',	'Дополнительный контент',	69,	1,	1,	40,	0,	''),
(332,	'additional_content',	'Дополнительный контент',	70,	1,	1,	45,	0,	''),
(333,	'additional_content',	'Дополнительный контент',	72,	1,	1,	40,	0,	''),
(334,	'additional_content',	'Дополнительный контент',	73,	1,	1,	40,	0,	''),
(335,	'additional_content',	'Дополнительный контент',	77,	1,	1,	40,	0,	''),
(336,	'additional_content',	'Дополнительный контент',	78,	1,	1,	40,	0,	''),
(337,	'additional_content',	'Дополнительный контент',	79,	1,	1,	35,	0,	''),
(338,	'additional_content',	'Дополнительный контент',	80,	1,	1,	35,	0,	''),
(339,	'additional_content',	'Дополнительный контент',	81,	1,	1,	35,	0,	''),
(340,	'additional_content',	'Дополнительный контент',	86,	1,	1,	45,	0,	''),
(341,	'additional_content',	'Дополнительный контент',	87,	1,	1,	55,	0,	''),
(342,	'additional_content',	'Дополнительный контент',	122,	1,	1,	40,	0,	''),
(343,	'additional_content',	'Дополнительный контент',	126,	1,	1,	40,	0,	''),
(344,	'404_page_settings',	'Настройки 404 страницы',	128,	1,	1,	25,	0,	''),
(345,	'search_page_settings',	'Настройки страницы поиска',	128,	1,	1,	30,	0,	''),
(346,	'post_by_tag_page_settings',	'Настройки страницы постов с заданным тегом',	128,	1,	1,	35,	0,	''),
(347,	'personal_data_policy',	'Политика обработки персональных данных',	128,	1,	1,	40,	0,	''),
(348,	'common',	'i18n::fields-group-common',	130,	1,	0,	5,	1,	NULL),
(350,	'more_params',	'i18n::fields-group-more_params',	130,	1,	0,	15,	1,	NULL),
(351,	'rate_voters',	'i18n::fields-group-rate_voters',	130,	1,	0,	20,	1,	NULL),
(352,	'svojstva_publikacii',	'i18n::fields-group-svojstva_publikacii',	130,	0,	1,	25,	1,	NULL),
(353,	'locks',	'i18n::fields-group-locks',	130,	1,	1,	30,	1,	NULL),
(354,	'additional_content',	'Дополнительный контент',	130,	1,	1,	36,	0,	NULL),
(355,	'main_page_content',	'Контент главной страницы',	130,	1,	1,	35,	0,	'');

DROP TABLE IF EXISTS `cms3_object_field_types`;
CREATE TABLE `cms3_object_field_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `data_type` enum('int','string','text','relation','file','img_file','swf_file','bool','date','boolean','wysiwyg','password','tags','symlink','price','formula','float','counter','optioned','video_file','color','link_to_object_type','multiple_image','domain_id','domain_id_list','offer_id_list','offer_id') DEFAULT NULL,
  `is_multiple` tinyint(1) DEFAULT 0,
  `is_unsigned` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `data_type` (`data_type`),
  KEY `is_multiple` (`is_multiple`),
  KEY `is_unsigned` (`is_unsigned`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_files`;
CREATE TABLE `cms3_object_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `src` varchar(500) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `ord` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `load field value` (`obj_id`,`field_id`),
  KEY `field_id` (`field_id`),
  KEY `obj_id` (`obj_id`),
  KEY `src` (`src`(255)),
  KEY `ord` (`ord`),
  CONSTRAINT `File object field content to field` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `File object field content to object` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_images`;
CREATE TABLE `cms3_object_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_id` int(10) unsigned DEFAULT NULL,
  `field_id` int(10) unsigned DEFAULT NULL,
  `src` varchar(500) DEFAULT NULL,
  `alt` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `ord` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `load field value` (`obj_id`,`field_id`),
  KEY `field_id` (`field_id`),
  KEY `obj_id` (`obj_id`),
  KEY `src` (`src`(255)),
  KEY `alt` (`alt`),
  KEY `ord` (`ord`),
  CONSTRAINT `object field content to field` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `object field content to object` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_offer_id_list`;
CREATE TABLE `cms3_object_offer_id_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obj_id` int(10) unsigned NOT NULL,
  `field_id` int(10) unsigned NOT NULL,
  `offer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cms3_object_offer_id_list load field value` (`obj_id`,`field_id`),
  KEY `cms3_object_offer_id_list field_id` (`field_id`),
  KEY `cms3_object_offer_id_list obj_id` (`obj_id`),
  KEY `cms3_object_offer_id_list offer_id` (`offer_id`),
  CONSTRAINT `cms3_object_offer_id_list field id` FOREIGN KEY (`field_id`) REFERENCES `cms3_object_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms3_object_offer_id_list object id` FOREIGN KEY (`obj_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms3_object_offer_id_list offer id` FOREIGN KEY (`offer_id`) REFERENCES `cms3_offer_list` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_types`;
CREATE TABLE `cms3_object_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `guid` varchar(64) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `is_guidable` tinyint(1) DEFAULT 0,
  `is_public` tinyint(1) DEFAULT 0,
  `hierarchy_type_id` int(10) unsigned DEFAULT NULL,
  `sortable` tinyint(4) DEFAULT 0,
  `domain_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hierarchy_type_id` (`hierarchy_type_id`),
  KEY `parent_id` (`parent_id`),
  KEY `is_public` (`is_public`),
  KEY `name` (`name`),
  KEY `is_locked` (`is_locked`),
  KEY `is_guidable` (`is_guidable`),
  KEY `guid` (`guid`),
  KEY `cms3_object_types domain id` (`domain_id`),
  CONSTRAINT `cms3_object_types domain id` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_object_type_tree`;
CREATE TABLE `cms3_object_type_tree` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `child_id` int(10) unsigned DEFAULT NULL,
  `level` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique parent-child object type relation` (`parent_id`,`child_id`),
  KEY `Object type id from child_id` (`child_id`),
  CONSTRAINT `Object type id from child_id` FOREIGN KEY (`child_id`) REFERENCES `cms3_object_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Object type id from parent_id` FOREIGN KEY (`parent_id`) REFERENCES `cms3_object_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_offer_list`;
CREATE TABLE `cms3_offer_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned NOT NULL,
  `data_object_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `vendor_code` varchar(255) DEFAULT NULL,
  `bar_code` varchar(255) DEFAULT NULL,
  `total_count` bigint(20) unsigned DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `order` bigint(20) unsigned DEFAULT 0,
  `weight` bigint(20) unsigned DEFAULT 0,
  `width` bigint(20) unsigned DEFAULT 0,
  `length` bigint(20) unsigned DEFAULT 0,
  `height` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vendor_code` (`vendor_code`),
  KEY `offer to type id` (`type_id`),
  KEY `offer to data object id` (`data_object_id`),
  CONSTRAINT `offer to data object id` FOREIGN KEY (`data_object_id`) REFERENCES `cms3_objects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `offer to type id` FOREIGN KEY (`type_id`) REFERENCES `cms3_object_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_offer_price_list`;
CREATE TABLE `cms3_offer_price_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` double unsigned NOT NULL,
  `offer_id` int(10) unsigned NOT NULL,
  `currency_id` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `is_main` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `offer price to offer` (`offer_id`),
  KEY `offer price to currency` (`currency_id`),
  KEY `offer price to type` (`type_id`),
  CONSTRAINT `offer price to currency` FOREIGN KEY (`currency_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offer price to offer` FOREIGN KEY (`offer_id`) REFERENCES `cms3_offer_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `offer price to type` FOREIGN KEY (`type_id`) REFERENCES `cms3_offer_price_type_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_offer_price_type_list`;
CREATE TABLE `cms3_offer_price_type_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_permissions`;
CREATE TABLE `cms3_permissions` (
  `level` tinyint(4) DEFAULT NULL,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `rel_id` int(10) unsigned DEFAULT NULL,
  KEY `owner reference_FK` (`owner_id`),
  KEY `rel reference_FK` (`rel_id`),
  KEY `level` (`level`),
  CONSTRAINT `FK_owner reference` FOREIGN KEY (`owner_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rel reference` FOREIGN KEY (`rel_id`) REFERENCES `cms3_hierarchy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_redirects`;
CREATE TABLE `cms3_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` text NOT NULL,
  `target` text NOT NULL,
  `status` int(10) unsigned DEFAULT 301,
  `made_by_user` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `source` (`source`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_response_error_entry_list`;
CREATE TABLE `cms3_response_error_entry_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL,
  `code` int(10) unsigned NOT NULL,
  `hits_count` int(10) unsigned DEFAULT 0,
  `domain_id` int(10) unsigned NOT NULL,
  `update_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cms3_response_error_entry_list order by hits count` (`hits_count`),
  KEY `cms3_response_error_entry_list order by update time` (`update_time`),
  KEY `cms3_response_error_entry_list domain_id` (`domain_id`),
  CONSTRAINT `cms3_response_error_entry_list domain_id` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_search`;
CREATE TABLE `cms3_search` (
  `rel_id` int(10) unsigned NOT NULL,
  `indextime` int(11) DEFAULT NULL,
  `lang_id` int(11) DEFAULT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`rel_id`),
  KEY `lang_id + domain_id + type_id_FK` (`lang_id`,`domain_id`,`type_id`),
  KEY `domain_id` (`domain_id`,`type_id`),
  KEY `indextime` (`indextime`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_search_index`;
CREATE TABLE `cms3_search_index` (
  `rel_id` int(10) unsigned DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `word_id` int(10) unsigned DEFAULT NULL,
  `tf` float DEFAULT NULL,
  KEY `pages to index_FK` (`rel_id`),
  KEY `word index_FK` (`word_id`),
  KEY `weight` (`weight`),
  KEY `tf` (`tf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_search_index_words`;
CREATE TABLE `cms3_search_index_words` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `word` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `word` (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_sliders`;
CREATE TABLE `cms3_sliders` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `domain_id` int(11) unsigned NOT NULL,
  `language_id` int(11) unsigned NOT NULL,
  `sliding_speed` int(11) unsigned DEFAULT NULL,
  `sliding_delay` int(11) unsigned DEFAULT NULL,
  `sliding_loop_enable` tinyint(1) DEFAULT 0,
  `sliding_auto_play_enable` tinyint(1) DEFAULT 0,
  `sliders_random_order_enable` tinyint(1) DEFAULT 0,
  `slides_count` int(11) unsigned DEFAULT 0,
  `custom_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id from domains` (`domain_id`),
  KEY `id from languages` (`language_id`),
  CONSTRAINT `id from domains` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id from languages` FOREIGN KEY (`language_id`) REFERENCES `cms3_langs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_slides`;
CREATE TABLE `cms3_slides` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slider_id` int(11) unsigned NOT NULL,
  `is_active` tinyint(1) DEFAULT 0,
  `title` varchar(1024) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `text` mediumtext DEFAULT NULL,
  `link` varchar(1024) DEFAULT NULL,
  `open_in_new_tab` tinyint(1) DEFAULT 1,
  `order` int(11) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `slider_id and is_active with order` (`slider_id`,`is_active`,`order`),
  CONSTRAINT `id from sliders` FOREIGN KEY (`slider_id`) REFERENCES `cms3_sliders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_stock_balance_list`;
CREATE TABLE `cms3_stock_balance_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offer_id` int(10) unsigned NOT NULL,
  `stock_id` int(10) unsigned NOT NULL,
  `value` bigint(20) unsigned DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `stock balance to offer` (`offer_id`),
  KEY `stock balance to stock` (`stock_id`),
  CONSTRAINT `stock balance to offer` FOREIGN KEY (`offer_id`) REFERENCES `cms3_offer_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stock balance to stock` FOREIGN KEY (`stock_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms3_templates`;
CREATE TABLE `cms3_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `filename` varchar(64) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `domain_id` int(10) unsigned DEFAULT NULL,
  `lang_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Template - Lang_FK` (`lang_id`),
  KEY `Templates - domains_FK` (`domain_id`),
  KEY `is_default` (`is_default`),
  KEY `filename` (`filename`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_backup`;
CREATE TABLE `cms_backup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ctime` int(11) DEFAULT NULL,
  `changed_module` varchar(128) DEFAULT NULL,
  `changed_method` varchar(128) DEFAULT NULL,
  `param` text DEFAULT NULL,
  `param0` mediumtext DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_permissions`;
CREATE TABLE `cms_permissions` (
  `module` varchar(64) DEFAULT NULL,
  `method` varchar(64) DEFAULT NULL,
  `owner_id` int(10) unsigned DEFAULT NULL,
  `allow` tinyint(4) DEFAULT 1,
  KEY `module` (`module`),
  KEY `method` (`method`),
  KEY `owner_id` (`owner_id`),
  KEY `allow` (`allow`),
  CONSTRAINT `FK_PermissionOwnerId_To_ObjectId` FOREIGN KEY (`owner_id`) REFERENCES `cms3_objects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_reg`;
CREATE TABLE `cms_reg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `var` varchar(48) NOT NULL,
  `val` varchar(255) DEFAULT NULL,
  `rel` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `var` (`var`),
  KEY `rel` (`rel`,`var`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_sitemap`;
CREATE TABLE `cms_sitemap` (
  `id` int(11) NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  `link` varchar(1024) NOT NULL,
  `sort` tinyint(4) NOT NULL,
  `priority` double NOT NULL DEFAULT 0,
  `dt` datetime NOT NULL,
  `level` int(4) unsigned NOT NULL,
  `lang_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `__sort` (`sort`),
  KEY `__domain_id` (`domain_id`),
  KEY `__domain_id__sort` (`domain_id`,`sort`),
  KEY `__domain_id__level` (`domain_id`,`level`),
  KEY `lang_id from cms3_langs` (`lang_id`),
  CONSTRAINT `domain_id from cms3_domains` FOREIGN KEY (`domain_id`) REFERENCES `cms3_domains` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lang_id from cms3_langs` FOREIGN KEY (`lang_id`) REFERENCES `cms3_langs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_domains`;
CREATE TABLE `cms_stat_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entrytime` int(11) DEFAULT NULL,
  `refer_domain` text DEFAULT NULL,
  `sess_id` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sess_id` (`sess_id`(4))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_entry_points`;
CREATE TABLE `cms_stat_entry_points` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  `host_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `url` (`url`(1)),
  KEY `host_id` (`host_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_entry_points_events`;
CREATE TABLE `cms_stat_entry_points_events` (
  `entry_point_id` int(11) unsigned DEFAULT NULL,
  `event_id` int(11) unsigned DEFAULT NULL,
  KEY `entry_point_id` (`entry_point_id`),
  KEY `event_id` (`event_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_events`;
CREATE TABLE `cms_stat_events` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` text DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL,
  `profit` float(9,2) DEFAULT 0.00,
  `host_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`,`type`),
  KEY `host_id` (`host_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_events_collected`;
CREATE TABLE `cms_stat_events_collected` (
  `event_id` int(11) unsigned DEFAULT NULL,
  `hit_id` int(11) unsigned DEFAULT NULL,
  KEY `event_id` (`event_id`,`hit_id`),
  KEY `hit_id` (`hit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_events_rel`;
CREATE TABLE `cms_stat_events_rel` (
  `metaevent_id` int(11) unsigned DEFAULT NULL,
  `event_id` int(11) unsigned DEFAULT NULL,
  UNIQUE KEY `metaevent_id` (`metaevent_id`,`event_id`),
  KEY `event_id` (`event_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_events_urls`;
CREATE TABLE `cms_stat_events_urls` (
  `event_id` int(11) unsigned DEFAULT NULL,
  `page_id` int(11) unsigned DEFAULT NULL,
  UNIQUE KEY `event_id` (`event_id`,`page_id`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_finders`;
CREATE TABLE `cms_stat_finders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bot_name` text DEFAULT NULL,
  `pattern` text DEFAULT NULL,
  `alias` text DEFAULT NULL,
  `domain` text DEFAULT NULL,
  `utf` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_hits`;
CREATE TABLE `cms_stat_hits` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `hour` tinyint(8) DEFAULT NULL,
  `day_of_week` tinyint(1) DEFAULT NULL,
  `day` tinyint(4) DEFAULT NULL,
  `month` tinyint(4) DEFAULT NULL,
  `year` int(11) unsigned DEFAULT NULL,
  `path_id` int(11) unsigned DEFAULT NULL,
  `number_in_path` int(11) unsigned DEFAULT NULL,
  `week` tinyint(4) unsigned DEFAULT NULL,
  `prev_page_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `day_of_week` (`day_of_week`),
  KEY `date` (`date`,`day_of_week`,`day`,`month`),
  KEY `day` (`day`,`month`,`date`,`day_of_week`),
  KEY `page_id` (`page_id`,`date`),
  KEY `date_level` (`date`,`number_in_path`),
  KEY `date_prev_page_level` (`date`,`prev_page_id`,`number_in_path`),
  KEY `path_id_level` (`path_id`,`number_in_path`,`prev_page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_holidays`;
CREATE TABLE `cms_stat_holidays` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  `day` tinyint(2) DEFAULT NULL,
  `month` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `day_month` (`day`,`month`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_pages`;
CREATE TABLE `cms_stat_pages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` text DEFAULT NULL,
  `host_id` int(11) unsigned DEFAULT NULL,
  `section` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `section` (`section`),
  KEY `uri` (`uri`(4)),
  KEY `host_id` (`host_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_paths`;
CREATE TABLE `cms_stat_paths` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `source_id` int(11) unsigned DEFAULT NULL,
  `host_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`),
  KEY `user_id` (`user_id`),
  KEY `id_host` (`id`,`host_id`),
  KEY `date_host_id` (`date`,`host_id`,`user_id`),
  KEY `host_id` (`host_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_phrases`;
CREATE TABLE `cms_stat_phrases` (
  `phrase` text DEFAULT NULL,
  `domain` text DEFAULT NULL,
  `finder_id` int(11) DEFAULT NULL,
  `entrytime` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sites`;
CREATE TABLE `cms_stat_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  `group_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sites_groups`;
CREATE TABLE `cms_stat_sites_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources`;
CREATE TABLE `cms_stat_sources` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `src_type` tinyint(4) unsigned DEFAULT NULL,
  `concrete_src_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `src_type` (`src_type`,`concrete_src_id`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_coupon`;
CREATE TABLE `cms_stat_sources_coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `profit` float(9,2) DEFAULT NULL,
  `descript` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_coupon_events`;
CREATE TABLE `cms_stat_sources_coupon_events` (
  `coupon_id` int(11) unsigned DEFAULT NULL,
  `event_id` int(11) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_openstat`;
CREATE TABLE `cms_stat_sources_openstat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `service_id` int(11) unsigned DEFAULT 0,
  `campaign_id` int(11) unsigned DEFAULT 0,
  `ad_id` int(11) unsigned DEFAULT NULL,
  `source_id` int(11) unsigned DEFAULT NULL,
  `path_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source_id` (`source_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;


DROP TABLE IF EXISTS `cms_stat_sources_openstat_ad`;
CREATE TABLE `cms_stat_sources_openstat_ad` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;


DROP TABLE IF EXISTS `cms_stat_sources_openstat_campaign`;
CREATE TABLE `cms_stat_sources_openstat_campaign` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;


DROP TABLE IF EXISTS `cms_stat_sources_openstat_service`;
CREATE TABLE `cms_stat_sources_openstat_service` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;


DROP TABLE IF EXISTS `cms_stat_sources_openstat_source`;
CREATE TABLE `cms_stat_sources_openstat_source` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;


DROP TABLE IF EXISTS `cms_stat_sources_pr`;
CREATE TABLE `cms_stat_sources_pr` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_pr_events`;
CREATE TABLE `cms_stat_sources_pr_events` (
  `pr_id` int(11) unsigned DEFAULT NULL,
  `event_id` int(11) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_pr_sites`;
CREATE TABLE `cms_stat_sources_pr_sites` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pr_id` int(11) unsigned DEFAULT NULL,
  `url` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_search`;
CREATE TABLE `cms_stat_sources_search` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `engine_id` int(11) unsigned DEFAULT NULL,
  `text_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `engine_id` (`engine_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_search_engines`;
CREATE TABLE `cms_stat_sources_search_engines` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  `url_mask` char(255) DEFAULT NULL,
  `varname` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_search_queries`;
CREATE TABLE `cms_stat_sources_search_queries` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `text` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_sites`;
CREATE TABLE `cms_stat_sources_sites` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uri` text DEFAULT NULL,
  `domain` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`),
  KEY `uri` (`uri`(255)),
  KEY `id_domain` (`id`,`domain`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_sites_domains`;
CREATE TABLE `cms_stat_sources_sites_domains` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_sources_ticket`;
CREATE TABLE `cms_stat_sources_ticket` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  `url` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_users`;
CREATE TABLE `cms_stat_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(32) DEFAULT NULL,
  `first_visit` datetime DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  `os_id` int(11) unsigned DEFAULT NULL,
  `browser_id` int(11) unsigned DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `js_version` varchar(5) DEFAULT NULL,
  `host_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `first_visit` (`first_visit`),
  KEY `session_id` (`session_id`),
  KEY `host_id` (`host_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_users_browsers`;
CREATE TABLE `cms_stat_users_browsers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cms_stat_users_os`;
CREATE TABLE `cms_stat_users_os` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `umi_event_feeds`;
CREATE TABLE `umi_event_feeds` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` bigint(20) DEFAULT NULL,
  `params` mediumtext DEFAULT NULL,
  `type_id` varchar(255) NOT NULL,
  `element_id` int(11) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `umi_event_types`;
CREATE TABLE `umi_event_types` (
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `umi_event_users`;
CREATE TABLE `umi_event_users` (
  `id` int(11) unsigned NOT NULL,
  `last_check_in` bigint(20) DEFAULT NULL,
  `settings` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `umi_event_user_history`;
CREATE TABLE `umi_event_user_history` (
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- 2020-01-20 13:28:00
