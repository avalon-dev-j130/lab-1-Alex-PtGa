/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */
/* Solution___*/

 create table roles  (
 id INTEGER unique GENERATED always as identity,
  name varchar(255) primary key
 );

insert into roles(name) values('Florida');
insert into roles(name) values('Alex');
insert into roles(name) values('Mom'); 


 create table supplier (
 id INTEGER unique GENERATED always as identity,
   
   name varchar(255) primary key,
   address varchar(255) not null,
   phone varchar(255),
   representative varchar(255) not null
);

insert into supplier(name, address, phone, representative) values('BaltFlot_Lider', 'СПб, Красных Курсантов. д.35', 'Tel:8(812)3864579', 'Oleg');
insert into supplier(name, address, phone, representative) values('Sochi_Holod', 'Сочи, ул.Синие Берега. д.84', 'Tel:8(056)3853579', 'Sonya');
insert into supplier(name, address, phone, representative) values('PoloClub', 'London, ул.Smitt_Red. д.84', 'Tel:15(056)3853579', 'Mr.Grad');


create table userinfo
(
   id INTEGER GENERATED always as identity primary key,
   
   nam varchar(255) not null,
   surname varchar(255) not null
    
 );

insert into userinfo(nam, surname) values('Djose', 'Paptis');
insert into userinfo(nam, surname) values('Djose', 'Paptis');
insert into userinfo(nam, surname) values('Alex', 'Kvastos');

--//**//**
-- REFERENCES - внешний ключ задаётся для столбца подчиненной таблицы.
--             Автоматически выполняется проверка на существование равного значения первичного ключа главной таблицы.
--             При определении могут быть дополнительно определены правила обеспечения ссылочной целостности
--            (ON DELETE RESTRICT, ON DELETE CASADE, ON DELETE SET NULL, ON DELETE SET DEFAULT).
--             По умолчанию принят запрет на удаления строк при наличии ссылок на них (ON DELETE RESTRICT).
--//**//**
 create table "user"
 (
 id INTEGER UNIQUE GENERATED always as identity,

 email varchar(255) primary key,
 pasword varchar(255) not null,
 info integer unique,
 "role" integer,

 constraint fk_userinfo foreign key (info)     -- задача внешнего ключа fk_userinfo - для удобства обращения
 references userinfo(id),                      -- 
 constraint fk_roles foreign key ("role")
 references roles(id)
 );

insert into "user"(email, pasword, info) values('flows_tf@mail.com', 'FDS4539@');
insert into "user"(email, pasword, info, "role") values('flows_gl@mail.com', 'maklain', 1, 1);
insert into "user"(email, pasword, info, "role") values('flows_bk@mail.com', 'ojdi', 2, 2);

--//**//**
-- заказ, слово зарезервировано, в "___"
--//**//**

 create table "order"            
 (
 id INTEGER GENERATED always as identity unique,
    
 "user" integer,
 created timestamp default current_timestamp,
    
 constraint fk_user foreign key ("user")    
 references "user"(id)                     
 );

insert into "order"("user") values(4);
insert into "order"("user") values(5);
insert into "order"("user") values(6);

-- //**//**//**//**//**//**//**//**//**//**//**//**//**//**//**//**
-- PRIMARY KEY - ограничение первичного ключа, при этом накладывается автоматически NOT NULL. 
--    При задании первичного ключа любое значение проверяется на уникальность и при обнаруживании дубликата операция прерывается
--    В таблице может быть только один столбецс ограничением PRIMARY KEY 
-- UNIQUE - ограничение уникальности, NOT NULL накладывается автоматически, фактически ни чем не отличается от PRIMARY KEY 
--         количество столбцов не ограничено
-- //**//**//**//**//**//**//**//**//**//**//**//**//**//**//**//**

create table product  (
id INTEGER UNIQUE GENERATED always as identity,  
code varchar(255) primary key,                   
title varchar(255),
supplier integer,

initial_price double,
retail_price double,

constraint fk_supplier foreign key (supplier)     -- задача внешнего ключа fk_userinfo - для удобства обращения
references supplier(id)                      
);


insert into product(title, code, initial_price, retail_price, supplier) values('бананасs', 'BaltFlot_Liderыs', 35.40, 55.3, 1);
insert into product(title, code, initial_price, retail_price, supplier) values('бананасsuk', 'BaltFlot_Liderыsuk', 35.90, 59.3, 4);
insert into product(title, code, initial_price, retail_price, supplier) values('Мандарины', 'Кавказ_Мин_Воды', 35.90, 59.3, 3);

create table order2product  (   
"order" integer,
product integer,
quantity integer,         

constraint pk_order2product primary key("order", product),     -- ограничение первичным кодом ( -, -)

constraint fk_product foreign key(product)
references product(id),

constraint fk_order foreign key("order")     
references "order"(id)                    -- 
);

insert into order2product("order", product, quantity) values(8, 43, 5);
insert into order2product("order", product, quantity) values(2, 40, 559);
insert into order2product("order", product, quantity) values(5, 31, 7595);