DROP database IF EXISTS helpdesk;
CREATE database helpdesk;
USE helpdesk;

DROP TABLE IF EXISTS user_groups;
CREATE TABLE user_groups
(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name varchar(50),
	description varchar(200)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
    location VARCHAR(30),
 	password_hash VARCHAR(100), 
	phone BIGINT UNSIGNED UNIQUE, 
	group_id BIGINT UNSIGNED, 
    INDEX users_firstname_lastname_idx(firstname, lastname),
    FOREIGN KEY (group_id) REFERENCES user_groups(id)
);

DROP TABLE IF EXISTS software;
CREATE TABLE software (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(100)
);

DROP TABLE IF EXISTS hardware;
CREATE TABLE hardware (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(100)
);

DROP TABLE IF EXISTS mm_software;
CREATE TABLE mm_software (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	software_id BIGINT unsigned,
	configuration_item_id BIGINT unsigned
);

DROP TABLE IF EXISTS mm_hardware;
CREATE TABLE mm_hardware (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	hardware_id BIGINT unsigned,
	configuration_item_id BIGINT unsigned
);

DROP TABLE IF EXISTS configuration_items;
CREATE TABLE configuration_items (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	service_tag VARCHAR(50) Unique,
	name VARCHAR(100),
	description VARCHAR(200) default null,
	mm_software_id BIGINT UNSIGNED default NULL,
	mm_hardware_id BIGINT UNSIGNED default NULL,
	user_id BIGINT unsigned default NULL,
	FOREIGN KEY (mm_software_id) REFERENCES mm_software(id),
	FOREIGN KEY (mm_hardware_id) REFERENCES mm_hardware(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);


alter table mm_software add constraint software_fk
FOREIGN KEY (software_id) REFERENCES software(id);

alter table mm_software add constraint configuration_items_fks
FOREIGN KEY (configuration_item_id) REFERENCES configuration_items(id);

alter table mm_hardware add constraint hardware_fk
FOREIGN KEY (hardware_id) REFERENCES hardware(id);
alter table mm_hardware add constraint configuration_items_fkh
FOREIGN KEY (configuration_item_id) REFERENCES configuration_items(id);




DROP TABLE IF EXISTS category_ticket;
CREATE TABLE category_ticket (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name varchar(50)
);

DROP TABLE IF EXISTS subcategory_ticket;
CREATE TABLE subcategory_ticket (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(100)
);

DROP TABLE IF EXISTS statuses;
CREATE TABLE statuses (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(100)
);

DROP TABLE IF EXISTS urgency_impact;
CREATE TABLE urgency_impact (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	urgency_type ENUM('Low', 'Medium', 'High'),
	impact_type ENUM('Low', 'Medium', 'High')
);





DROP TABLE IF EXISTS tickets;
CREATE TABLE tickets (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	ticket_type ENUM('Incident', 'Request', 'Change'),
	created_at datetime DEFAULT now(),
	due_date datetime DEFAULT NULL,
	category_id BIGINT UNSIGNED,
	subcategory_id BIGINT UNSIGNED,
	status_id BIGINT UNSIGNED,
	priority_id BIGINT UNSIGNED,
	assigned_group_id BIGINT UNSIGNED,
	caller_id BIGINT UNSIGNED,
	worker_id BIGINT UNSIGNED DEFAULT NULL,
	description varchar(250),
	FOREIGN KEY (caller_id) REFERENCES users(id),
	FOREIGN KEY (worker_id) REFERENCES users(id),
	FOREIGN KEY (category_id) REFERENCES category_ticket(id),
	FOREIGN KEY (subcategory_id) REFERENCES subcategory_ticket(id),
	FOREIGN KEY (status_id) REFERENCES statuses(id),
	FOREIGN KEY (assigned_group_id) REFERENCES user_groups(id),
	FOREIGN KEY (priority_id) REFERENCES urgency_impact(id)
	
);

DROP TABLE IF EXISTS notes_log;
CREATE TABLE notes_log (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	ticket_id BIGINT UNSIGNED NOT null,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT now(),
	text VARCHAR(200),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (ticket_id) REFERENCES tickets(id)
);




























