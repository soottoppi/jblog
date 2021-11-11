select * from user;

insert into user values ('duwjs1103', '김수형', '123', now());

select title, logo from blog where id = 'duwjs1103';
select * from blog where id = 'duwjs1103';
select * from blog;

insert into blog values('duwjs1103', '하이', '/blog/images/cat.png');
insert into blog values ('ppang', 'ppang'+ 's blog', '/blog/images/cat.png');

update blog set title = '하이2', logo = '/blog/images/cat.png' where id = 'ppang';

select * from user;
select * from blog;
select * from category, post;
select * from category;
select * from post;

select c.no, name, description, blog_id as blogId, count(p.category_no) as count
	from category c left outer join post p on c.no = p.category_no
where c.blog_id = 'duwjs1103'
group by c.no;

select * from blog;
select name from category where blog_id = 'duwjs1103';
insert into post values(null, '11', '22', now(), 10);

select *
	from category c, blog b
where c.blog_id = b.id;

insert into category values(null, '미분류', '미분류 카테고리입니다.', 'duwjs1103');

select *
	from category join post;

select * from user;
delete from blog where id = 'ppang';

select c.no,count(p.category_no) from category c left outer join post p on c.no = p.category_no where blog_id = 'duwjs1103'
group by c.no;

delete from category
where 0 = (select count
				from (select c.no as no, count(p.category_no) as count
						from category c left outer join post p on c.no = p.category_no
					  where c.blog_id = 'duwjs1103'
						group by c.no
					) as a

select * from category, post where category.no = 3;
select c.name, count(p.category_no) as count
	from category c left outer join post p on c.no = p.category_no
where c.blog_id = 'duwjs1103' and c.no = '1'
	and c.name != '미분류';
    
select count
	from (select c.no, count(p.category_no) as count
			from category c left outer join post p on c.no = p.category_no
		  where c.name != '미분류' 
			and c.blog_id = 'duwjs1103'
			group by c.no
	) as a
where a.no = 3;
    
select c.no, count(p.category_no) as count
			from category c left outer join post p on c.no = p.category_no
		  where c.name != '미분류' 
			and c.blog_id = 'duwjs1103'
			group by c.no;