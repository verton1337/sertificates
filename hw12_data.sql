use helpdesk;
INSERT INTO software (name) VALUES
('windows 7'),
('windows 10'),
('office 365'),
('office 2013'),
('photoshop'),
('zscaller'),
('pulse secure');

INSERT INTO hardware (name) values
('Intel i5-1020'),
('Intel i7-520m'),
('Intel i5-9025'),
('Intel i7-7770'),
('Kingston m2sata 256gb'),
('Kingston m2sata 480gb'),
('Kingston m2sata 120gb'),
('Samsung DDR4 sodimm 8gb'),
('Samsung DDR4 sodimm 16gb'),
('Samsung DDR3 sodimm 8gb');


insert into category_ticket (name) values
('Hardware'),
('Software'),
('Network');

insert into subcategory_ticket (name) values
('Performance degradation'),
('Other issues'),
('License'),
('Access'),
('Request');

insert into statuses (name) values
('New'),
('Active'),
('Work in progress'),
('Waiting customer'),
('Closed completed'),
('Closed incompleted'),
('Waiting for aproval');

insert into urgency_impact (urgency_type, impact_type)
values
('Low','Low'),
('Low','Medium'),
('Low','High'),
('Medium','Low'),
('Medium','Medium'),
('Medium','High'),
('High','Low'),
('High','Medium'),
('High','High');

insert into user_groups (name, description) values
('Local IT support','Group for locall support users'),
('Networking','Group for network supporting'),
('Desktop','Group for support operation system'),
('EUS','Group for end users'),
('Users', 'Group for normaly users');


insert into users (firstname, lastname,  location, email, password_hash, phone, group_id) values
('Alex','Davidov','Moscow','qtrw@ey.ru','hjkwuyt5w22233hjk','79898998989',5),
('Ivan','Vatov','Saint Petersburg','qtrytyw@ey.ru','hjk456djkw22233hjk','79898878989',1),
('David','Bootin','Novgorod','qtrtytw@ey.ru','hjkwe456w22233hjk','79898956789',3),
('Alan','Brestun','Moscow','qtryutyuw@ey.ru','hjkwe6722233hjk','79898988989',5),
('Dmitry','Defenov','Moscow','qfghfhgtrw@ey.ru','hjkweh687jg22233hjk','7888998989',5);



insert into configuration_items (service_tag, name, user_id)
values
('FGDEMC5','Dell latitude 7280',1),
('FGDFMC5','Dell latitude 7280',1),
('FGD1MC5','Dell latitude 7280',1),
('FWDEMC5','Dell latitude 7280',1);

insert into mm_hardware (hardware_id, configuration_item_id) values
(1,1),(5,1),(8,1),(2,2),(6,2),(9,2),(1,3),(5,3),(8,3),(3,3),(7,3),(9,3);

insert into mm_software (software_id, configuration_item_id) values
(1,1), (3,1), (5,1), (7,1),(2,2), (3,2), (5,2), (7,2), 
(1,3), (3,3), (5,3), (7,3), (1,4), (3,4), (5,4), (7,4);


insert into tickets (ticket_type, category_id, subcategory_id, status_id, priority_id, assigned_group_id,
caller_id, worker_id, description) values
('Request', 1, 5, 3, 4, 1, 1,  2, 'Request headset'),
('Request', 1, 5, 6, 2, 1, 1,  2, 'Request headset'),
('Incident', 1, 1, 1, 1, 1, 4,  2, 'Replace my laptop');



insert into tickets (ticket_type, category_id, subcategory_id, status_id, priority_id, assigned_group_id,
caller_id,  description) values
('Request', 2, 5, 3, 1, 1, 2, 'Request memory'),
('Incident', 2, 2, 3, 1, 1, 2, 'My workstation turned off and can`t start');
































