create table member (
	idx int not null auto_increment,
    mid varchar(20) not null,
    pwd varchar(255) not null,
    name varchar(20) not null,
    gender varchar(1) default 'm',
    tel varchar(20) not null,
    email varchar(50) not null,
    file_name varchar(255) not null,
    save_file_name varchar(255) not null,
    postcode varchar(10),
    roadAddress varchar(255),
    detailAddress varchar(255),
    extraAddress varchar(255),
    create_date datetime default now(),
    lastDate dateime default now(),
    level int default 1,
    point int default 1000,
    agreement int default 2,
    del_yn varchar(1) default 'n',
    delete_date datetime,
    primary key(idx)
);

desc member;

drop table member;

select * from member;

insert into member values(default, 'admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '관리자', 'f', '010-9039-1877', 'ljs1877@gmail.com', 'noimage', 'noimage', '27844', '충북 진천군 이월면 진광로 121', '101동 403호', '(부영아파트)',  default, default, default, default, default, null);

update member set point = point + 2000, point = point - 500 where idx = 2;


create table mem_log (
	idx int not null auto_increment,
    mem_idx int not null,
	login_time datetime default now(),
    hostIp varchar(255) not null,
    primary key(idx),
	foreign key(mem_idx) references member(idx) on update cascade
);

select * from mem_log;


select *,(select timestampdiff(DAY, delete_date, NOW()) as applyDiff from member where del_yn = 'y') from member order by idx desc;


select count(*) as cnt from reservation group by create_date;

select count(*) as cnt from (select count(*) as cnt from reservation group by create_date);

SELECT l.`*`, lo.`*`, COUNT(*) as cnt
FROM (SELECT lod_idx, count(lod_idx) as cnt FROM reservation group by create_date) a
JOIN lodging l
ON a.lod_idx = l.idx
JOIN lod_option lo
ON a.lod_idx = lo.lod_idx
GROUP BY lod_idx;








