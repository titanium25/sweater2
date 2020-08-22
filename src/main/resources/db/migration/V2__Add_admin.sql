insert into usr (id, username, password, active)
    values (100, 'admin', '123', true);

insert into user_role (user_id, roles)
    values (100, 'USER'), (100, 'ADMIN');