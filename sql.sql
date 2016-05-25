#编码格式
# 数据表名  数据库名_表名  （一般用）
# 数据表列名  数据表_列名
# 

create database if not exists yqcms;

use yqcms;

# 创建一级分类
create table if not exists yqcms_firtype(
  firtype_id int not null auto_increment primary key,
#   firtype_controller varchar(30) not null, #对应的控制器
  firtype_name varchar(30) not null,
  firtype_createTime timestamp default current_timestamp
  on update current_timestamp
);

# 创建二级分类
create table if not exists yqcms_sectype(
  sectype_id int not null auto_increment primary key,
  sectype_name varchar(50) not null,
#   sectype_method varchar(30) not null default 'index',  #对应的方法 就是要跳转到对应的页面的方法
  sectype_content text,
  product_createTime timestamp default current_timestamp
  on update current_timestamp,
  sectype_firtypeId int not null,
  foreign key (sectype_firtypeId)
  references yqcms_firtype(firtype_id)
    on delete cascade
);

#创建产品
create table if not exists yqcms_product(
	product_id int not null auto_increment primary key,
	product_name varchar(50) not null,
	product_content text,
	product_createTime timestamp default current_timestamp
	on update current_timestamp,
	product_sectypeId int not null,
	foreign key (product_sectypeId)
	references yqcms_sectype(sectype_id)
	on delete cascade
);

#产品图片 (与产品是多对一)
create table if not exists yqcms_image(
	image_id int not null auto_increment primary key,
	image_name varchar(64) not null,
	image_productId int not null,
	image_createTime timestamp default current_timestamp 
	on update current_timestamp,
	foreign key (image_productId) 
	references yqcms_product(product_id)
	on delete cascade
);

#其他属性 (与产品是多对一)
create table if not exists yqcms_attr(
	attr_id int not null primary key auto_increment,
	attr_name varchar(64) not null,
	attr_content text,
	attr_createTime timestamp default current_timestamp 
	on update current_timestamp,
	attr_productId int not null,
	foreign key(attr_productId) 
	references yqcms_product(product_id)
);

#
# #创建产品分类 product_category == protype
# create table if not exists yqcms_protype(
# 	protype_id int not null auto_increment primary key,
# 	protype_name varchar(30) not null,
# 	protype_createTime timestamp default current_timestamp
# 	on update current_timestamp
# );

# #新闻分类
# create table if not exists yqcms_newstype(
# 	newstype_id int not null auto_increment primary key,
# 	newstype_name varchar(30) not null,
# 	newstype_createTime timestamp default current_timestamp
# 	on update current_timestamp
# );
#
# #新闻
# create table if not exists yqcms_news(
# 	news_id int not null primary key auto_increment,
# 	news_name varchar(128) not null,
# 	news_content text,
# 	news_createTime timestamp default current_timestamp
# 	on update current_timestamp
# );
#
# # 关于分类
# create table if not exists yqcms_abouttype(
#   abouttype_id int not null auto_increment primary key,
#   abouttype_name varchar(30) not null,
#   abouttype_createTime timestamp default current_timestamp
#   on update current_timestamp
# );
#
# #关于模块
# create table if not exists yqcms_about(
#   about_id int not null primary key auto_increment,
#   about_name varchar(64) not null,
#   about_content text,
#   about_createTime timestamp default current_timestamp
# 	on update current_timestamp
# );
#还有用户模块用到再写

# 插入数据
use yqcms;
insert into yqcms_firtype (firtype_name) values ('关于我们');
insert into yqcms_firtype (firtype_name) values ('新闻资讯');
insert into yqcms_firtype (firtype_name) values ('产品管理');
insert into yqcms_firtype (firtype_name) values ('客户服务');
insert into yqcms_firtype (firtype_name) values ('最新公告');
# 插入一级分类
# insert into yqcms_firtype (firtype_name, firtype_controller) values ('关于我们', 'About');
# insert into yqcms_firtype (firtype_name, firtype_controller) values ('新闻资讯', 'News');
# insert into yqcms_firtype (firtype_name, firtype_controller) values ('案例展示', 'Product');
# insert into yqcms_firtype (firtype_name, firtype_controller) values ('客户服务', 'Customer');
# insert into yqcms_firtype (firtype_name, firtype_controller) values ('最新公告', 'Inform');
# 插入二级分类



insert into yqcms_sectype (sectype_name, sectype_firtypeId) VALUEs ('最新公告', 2);
insert into yqcms_sectype (sectype_name, sectype_firtypeId) VALUEs ('公司新闻', 2);
insert into yqcms_sectype (sectype_name, sectype_firtypeId) VALUEs ('业内资讯', 2);
#
#
insert into yqcms_sectype (sectype_name, sectype_firtypeId) values ('办公案例', 3);
insert into yqcms_sectype (sectype_name, sectype_firtypeId) values ('公共设施', 3);
insert into yqcms_sectype (sectype_name, sectype_firtypeId) values ('酒店会所', 3);
insert into yqcms_sectype (sectype_name, sectype_firtypeId) values ('精装修房', 3);
#

