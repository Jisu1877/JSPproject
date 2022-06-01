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
	cancel_yn varchar(1) default 'n',
	create_date datetime default now(),
	point int not null,
	foreign key(lod_idx) references lodging(idx) on update cascade,
	foreign key(mem_idx) references member(idx) on update cascade
);

desc reservation;


select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.stay_date != '2022-06-04' and re.stay_date != '2022-06-06' and l.number_guests >= 2 and l.detail_category_code = 300;

select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.check_out 

select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx LEFT JOIN lod_option lo ON l.idx = lo.lod_idx where re.stay_date = '2022-06-08' or re.stay_date = '2022-06-10';

select lod_idx from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.stay_date = '2022-06-08' or re.stay_date = '2022-06-10' group by lod_idx;

select * from lodging l LEFT JOIN lod_option lo ON l.idx = lo.lod_idx 
where l.idx NOT IN 
(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = '2022-06-08' or re.stay_date = '2022-06-10' group by re.lod_idx) 
and l.number_guests >= 5 and l.category_code = 100 
order by l.idx desc;

select * from lodging l LEFT JOIN lod_option lo ON l.idx = lo.lod_idx 
where l.idx NOT IN 
(select re.lod_idx from reservation re LEFT JOIN lodging ll ON re.lod_idx = ll.idx where re.stay_date = '2022-06-08' or re.stay_date = '2022-06-10' group by re.lod_idx) 
and l.number_guests >= 1
order by l.idx desc;

select * from reservation where lod_idx = 18 and state = '예약';

select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.mem_idx = 6 group by re.check_in order by re.idx desc;
select * from reservation re LEFT JOIN lodging l ON re.lod_idx = l.idx where re.mem_idx = 6 group by re.create_date order by re.idx desc;


update reservation set state = '사용완료' where check_out <= '2022-05-31';