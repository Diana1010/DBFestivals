select t.name as type, e.name, e.date, e.description, p.city, p.street, p.house from  event as e
	inner join place as p on p.Id = e.place_ID
    inner join type as t on t.ID = e.type_id;
    
select c.firstname,c.surname, p.profession  from performer as p
	inner join contact_info as c on c.Id = p.contact_info_id;
    

select o.firstname, o.surname from contact_info as o  where o.id  in (
select c.contact_info_id from  user as c
union 
select k.contact_info_id from performer as k

);

select r.name as role, c.firstname, c.surname, c.age, c.mail, c.phone from role_has_user as f
	inner join role as r on r.id = f.role_id 
    inner join user  as u on u.id = f.user_id
    inner join contact_info as c on c.id = u.contact_info_id;
    
    
    
select e.name, e. date, c.firstname, c.surname from request as r
inner join user as u on u.ID = r.user_id
inner join contact_info as c on c.Id= u.contact_info_id
inner join event as e on e.id = r.event_id order by e.name;

select c.firstname, c.surname, c.age, c.mail from user as u 
inner join contact_info as c on c.Id = u.contact_info_id
inner join regInfo as r on r.id = u.regInfo_id


