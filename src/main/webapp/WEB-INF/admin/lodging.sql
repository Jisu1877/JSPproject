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
    introduce varchar(100) not null,
    explanation mediumtext,
    number_guests int not null,
    create_date datetime default now(),
    primary key(idx),
	foreign key(category_code) references lod_category(code) on update cascade,
    foreign key(sub_category_code) references lod_sub_category(code) on update cascade,
    foreign key(detail_category_code) references lod_detail_category(code) on update cascade
);


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


