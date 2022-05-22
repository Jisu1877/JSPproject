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