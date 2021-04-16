Use helpdesk;
/*Просмотр какая техника на руках у пользвателей*/
select users.firstname, users.lastname, configuration_items.name from users 
join configuration_items on configuration_items.user_id = users.id; 

/* Просмотр заасайненных заявок */
select tickets.ticket_type,
tickets.id,
users.firstname as 'worker name',
users.lastname as 'worker lastname',
(select users.firstname from users where users.id = tickets.caller_id) 
as 'caller name',
(select users.lastname from users where users.id = tickets.caller_id) 
as 'caller lastname'
from tickets join users 
where tickets.worker_id = users.id;


/* Просмотр заявок в очереди локальной поддержки, которые еще никто не забрал на себя */
select tickets.ticket_type, tickets.id from tickets where isnull(worker_id)  and assigned_group_id = 1;

/* Создание представления для  заасайненных заявок */
drop view if exists show_assigned_tickets;
CREATE VIEW show_assigned_tickets AS
select tickets.ticket_type,
tickets.id,
users.firstname as 'worker name',
users.lastname as 'worker lastname',
(select users.firstname from users where users.id = tickets.caller_id) 
as 'caller name',
(select users.lastname from users where users.id = tickets.caller_id) 
as 'caller lastname'
from tickets join users 
where tickets.worker_id = users.id order by tickets.ticket_type;

/* Сроздание представления для закрытых заявок */
drop view if exists show_closed_tickets;
CREATE VIEW show_closed_tickets AS
select tickets.ticket_type,
tickets.id,
users.firstname as 'worker name',
users.lastname as 'worker lastname',
(select users.firstname from users where users.id = tickets.caller_id) 
as 'caller name',
(select users.lastname from users where users.id = tickets.caller_id) 
as 'caller lastname'
from tickets join users 
where tickets.worker_id = users.id and (status_id = 5 or status_id = 6) order by tickets.ticket_type;


/* Сроздание триггера на установку дедлайна в зависимости от приоритета */
drop trigger if exists insert_duedate;
delimiter &&
create trigger insert_duedate before insert on tickets
for each row
begin
	set new.due_date = date_add(now(),interval 40/new.priority_id DAY);
end &&
delimiter ;


