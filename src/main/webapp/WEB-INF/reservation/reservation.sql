show tables;

create table reservation (
	idx int not null auto_increment primary key,
	lod_idx int not null,
	mem_idx int not null,
	stay_date varchar(20) not null,
	check_in varchar(20) not null,
	check_out varchar(20) not null,
	number_guests int not null,
	payment_price int not null,
	term int not null,
	review varchar(10),
	state varchar(10) default '예약',
	cancel_yc varchar(1) default 'n',
	create_date datetime default now(),
	foreign key(lod_idx) references lodging(idx) on update cascade,
	foreign key(mem_idx) references member(idx) on update cascade
);

desc reservation;