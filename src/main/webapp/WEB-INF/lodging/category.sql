create table category (
	code int primary key,
	name varchar(10) not null
);

insert into category values (100, '유럽');
insert into category values (101, '아시아');
insert into category values (102, '미국');
insert into category values (103, '프랑스');
insert into category values (104, '이탈리아');
insert into category values (105, '기타');

select * from category;