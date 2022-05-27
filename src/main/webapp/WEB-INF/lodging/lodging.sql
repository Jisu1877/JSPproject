show tables;

create table lodging (
	idx int not null auto_increment,
    file_name varchar(255) not null,
    save_file_name varchar(255) not null,
    category_code int not null,
    sub_category_code int not null,
    detail_category_code int not null,
    lod_name varchar(255) not null,
    price int not null,
    country varchar(255) not null,
    address varchar(100) not null,
    explanation mediumtext,
    number_guests int not null,
    create_date datetime default now(),
    primary key(idx)
);

select * from lodging;
drop table lodging;
drop table lod_category;
drop table lod_sub_category;
drop table lod_detail_category;

create table lod_option (
	idx int not null auto_increment,
    lod_idx int not null,
    air_conditioner varchar(1) default 'n',
	tv varchar(1) default 'n',
    wifi varchar(1) default 'n',
    washer varchar(1) default 'n',
    kitchen varchar(1) default 'n',
    heating varchar(1) default 'n',
    toiletries varchar(1) default 'n',
    bedroom int default 1,
    bed int default 1,
    bathroom int default 1,
    primary key(idx),
	foreign key(lod_idx) references lodging(idx) on update cascade
);


create table lod_category (
	code int not null,
    name varchar(10) not null,
    primary key(code)
);

select * from lod_category;
insert into lod_category values(103, '프랑스');
insert into lod_category values(104, '이탈리아');
insert into lod_category values(105, '기타');


create table lod_sub_category (
	code int not null,
    category_code int not null,
    name varchar(20) not null,
    primary key(code),
    foreign key(category_code) references lod_category(code)
    on update cascade
);

select * from lod_sub_category;
-- 카테고리 임시 중단!
insert into lod_sub_category values(200, 100, '대형(침실 5개이상)'); 
insert into lod_sub_category values(201, 104, '이탈리아');
insert into lod_sub_category values(202, 105, '기타');

desc lod_sub_category;

create table lod_detail_category (
	code int not null,
    category_code int not null,
    sub_category_code int not null,
    name varchar(30) not null,
    primary key(code),
    foreign key(category_code) references lod_category(code) 
    on update cascade /*원본 테이블에서 수정되면 같이 수정됨*/
);

select * from lodging l LEFT JOIN lod_option lo ON l.idx = lo.lod_idx;