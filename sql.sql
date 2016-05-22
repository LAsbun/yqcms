#编码格式
# 数据表名  数据库名_表名  （一般用）
# 数据表列名  数据表_列名
# 

create database if not exists project;

use project;

#创建产品分类 product_category == protype
create table if not exists project_protype(
	protype_id int not null auto_increment primary key,
	protype_name varchar(30) not null,
	protype_createTime timestamp default current_timestamp 
	on update current_timestamp
);

#创建产品
create table if not exists project_product(
	product_id int not null auto_increment primary key,
	product_name varchar(50) not null,
	product_content text,
	product_createTime timestamp default current_timestamp 
	on update current_timestamp,
	product_protypeId int not null,
	foreign key (product_id) 
	references project_protype(protype_id)
	on delete cascade
);

#产品图片 (与产品是多对一)
create table if not exists project_image(
	image_id int not null auto_increment primary key,
	image_name varchar(64) not null,
	image_productId int not null,
	image_createTime timestamp default current_timestamp 
	on update current_timestamp,
	foreign key (image_productId) 
	references project_product(product_id)
	on delete cascade
);

#其他属性 (与产品是多对一)
create table if not exists project_attr(
	attr_id int not null primary key auto_increment,
	attr_name varchar(64) not null,
	attr_content text,
	attr_createTime timestamp default current_timestamp 
	on update current_timestamp,
	attr_productId int not null,
	foreign key(attr_productId) 
	references project_product(product_id)
);

#新闻分类
create table if not exists project_newstype(
	newstype_id int not null auto_increment primary key,
	newstype_name varchar(30) not null,
	newstype_createTime timestamp default current_timestamp 
	on update current_timestamp
);

#新闻
create table if not exists project_news(
	news_id int not null primary key auto_increment,
	news_name varchar(128) not null,
	news_content text,
	news_createTime timestamp default current_timestamp
	on update current_timestamp
);

#其他模块
create table if not exists project_other(
	other_id int not null primary key auto_increment,
	other_name varchar(64) not null,
	other_content text,
	other_createTime timestamp default current_timestamp 
	on update current_timestamp,
)