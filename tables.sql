CREATE TABLE payment 
(
  payment_id integer, 
  host_id    integer not null,
  order_id   integer not null,
  payment_type VARCHAR(100),
  amount NUMERIC,
  primary key (payment_id)
);

CREATE TABLE host 
(
  user_id    integer,
  firstname   varchar(100),
  lastname varchar(100),
  email varchar(100),
  phone varchar(12),
  primary key (user_id)
  
);

CREATE TABLE customer 
(
  user_id    integer,
  firstname   varchar(100),
  lastname varchar(100),
  email varchar(100),
  phone varchar(12),
  payment_details varchar(20),
  primary key (user_id)
  
);

CREATE TABLE credential 
(
  user_id    integer,
  passwd     varchar(40),
  primary key (user_id)
  
);


CREATE TABLE booking 
(
  order_id    integer,
  customer_id   integer,
  property_id integer,
  host_id integer,
  guestcount integer,
  check_in_date date,
  check_out_date DATE,
  primary key (order_id)
  
);

CREATE TABLE property 
(
  property_id    integer,
  property_type   varchar(20),
  host_id integer,
  capacity integer,
  price integer,
  phone varchar(12),
  addressline1 varchar(100),
  addressline2 varchar(100),
  city varchar(100),
  state varchar(100),
  country varchar(100),
  zip varchar(12),
  primary key (property_id)
  
);

create table offers (
property_id integer,
host_id integer,
offer integer,
 primary key (property_id,host_id)
);

create table availability (
property_id integer,
from_date date,
to_date date,
 primary key (property_id,from_date) );



create table reviews (
review_id integer,
customer_id integer,
property_id integer,
rating numeric,
comments varchar(500),
 primary key (review_id)
);

create table housing (
property_id integer,
wifi CHAR(1),
pool CHAR(1),
gym CHAR(1),
washer CHAR(1),
dryer CHAR(1),
kitchen CHAR(1),
aircondition CHAR(1),
parking CHAR(1),
number_of_beds integer,
bathroom_count integer,
 primary key (property_id)
);

create table Restaurant (
property_id integer,
restaurant_name VARCHAR(255),
wifi CHAR(1),
tv CHAR(1),
smoking_zone CHAR(1),
parking CHAR(1),
alcohol CHAR(1),
cab_facility CHAR(1),
cuisines varchar(500),
outdoor_seating CHAR(1),
wheelchair_access char(1),
 primary key (property_id)
);

ALTER TABLE Restaurant ADD CONSTRAINT fk1 FOREIGN KEY(property_id) REFERENCES property(property_id);	

ALTER TABLE housing ADD CONSTRAINT fk2 FOREIGN KEY(property_id) REFERENCES property(property_id);

ALTER TABLE reviews ADD CONSTRAINT fk3 FOREIGN KEY(property_id) REFERENCES property(property_id);	

ALTER TABLE reviews ADD CONSTRAINT fk4 FOREIGN KEY(customer_id) REFERENCES customer(user_id);

ALTER TABLE availability ADD CONSTRAINT fk5 FOREIGN KEY(property_id) REFERENCES property(property_id);	

ALTER TABLE booking ADD CONSTRAINT fk6 FOREIGN KEY(customer_id) REFERENCES customer(user_id);	

ALTER TABLE booking ADD CONSTRAINT fk7 FOREIGN KEY(property_id) REFERENCES property(property_id);	

ALTER TABLE customer ADD CONSTRAINT fk8 FOREIGN KEY(user_id) REFERENCES credential(user_id);

ALTER TABLE host ADD CONSTRAINT fk9 FOREIGN KEY(user_id) REFERENCES credential(user_id);

ALTER TABLE property ADD CONSTRAINT fk10 FOREIGN KEY(host_id) REFERENCES host(user_id);

ALTER TABLE payment ADD CONSTRAINT fk11 FOREIGN KEY(host_id) REFERENCES host(user_id);

ALTER TABLE payment ADD CONSTRAINT fk12 FOREIGN KEY(order_id) REFERENCES booking(order_id);

ALTER TABLE offers ADD CONSTRAINT fk13 FOREIGN KEY(property_id) REFERENCES property(property_id);
