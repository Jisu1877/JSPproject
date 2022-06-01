show tables;

create table review (
	idx int not null auto_increment primary key,
	lod_idx int not null,
	mem_idx int not null,
	rating int not null,
	review_subject varchar(255) not null,
	review_contents text not null,
	exposure_yn varchar(1) default 'y',
	create_date datetime default now(),
	foreign key(lod_idx) references lodging(idx) on update cascade,
	foreign key(mem_idx) references member(idx) on update cascade
);

desc review;


select * from review re JOIN lodging l ON re.lod_idx = l.idx  where mem_idx = 6 and exposure_yn = 'y';