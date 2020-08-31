insert into usr (id, username, password, active)
    values (1, 'admin', '123', true);
insert into usr (id, username, password, active)
    values (2, 'user1', '123', true);
insert into usr (id, username, password, active)
    values (3, 'user2', '123', true);
insert into usr (id, username, password, active)
    values (4, 'user3', '123', true);
insert into usr (id, username, password, active)
    values (5, 'user4', '123', true);

insert into user_role (user_id, roles)
    values (1, 'USER'), (1, 'ADMIN');
insert into user_role (user_id, roles)
    values (2, 'USER');
insert into user_role (user_id, roles)
    values (3, 'USER');
insert into user_role (user_id, roles)
    values (4, 'USER');
insert into user_role (user_id, roles)
    values (5, 'USER');