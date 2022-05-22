create table file (
	file_idx int not null auto_increment,
    lod_idx int not null,
    file_name varchar(255) not null,
    save_file_name varchar(255) not null,
    create_date datetime default now(),
    primary key(idx),
	foreign key(lod_idx) references lodging(idx) on update cascade
);