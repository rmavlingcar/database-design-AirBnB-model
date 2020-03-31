--Data for stored procedures
INSERT INTO CREDENTIAL VALUES (1, 'password');
INSERT INTO HOST VALUES (1, 'Ricky', 'Martin', 'rmartin@gmail.com', '6821231234');
INSERT INTO PROPERTY VALUES (1, 'restaurant', 1, 60, NULL, '6821231234', '2800 Waterview pkwy', 'Bldg 61', 'Dallas', 'TX', 'USA', '75080');
INSERT INTO RESTAURANT VALUES(1, 'Ricky Martins Bar', '1', '1', '1', '1', '1', '1', 'N/A', '0', '0');
INSERT INTO PROPERTY VALUES (2, 'restaurant', 1, 60, NULL, '6821231234', '2800 Waterview pkwy', 'Bldg 62', 'Dallas', 'TX', 'USA', '75080');
INSERT INTO RESTAURANT VALUES(2, 'Ricky Martins Fine Dining', '1', '1', '1', '1', '1', '1', 'N/A', '0', '1');

create or replace PROCEDURE is_accessible_restaurant AS 

thisRestaurant restaurant%ROWTYPE;

CURSOR all_accessible_restaurants IS
SELECT * FROM RESTAURANT WHERE wheelchair_access LIKE '1';

BEGIN
dbms_output.put_line('List of accessible restaurants: ');
OPEN all_accessible_restaurants;
LOOP
  FETCH all_accessible_restaurants INTO thisRestaurant;
  EXIT WHEN (all_accessible_restaurants%NOTFOUND);
  dbms_output.put_line(thisRestaurant.restaurant_name);
END LOOP;
CLOSE all_accessible_restaurants;
END;

SET SERVEROUT ON
EXECUTE is_accessible_restaurant;

create or replace PROCEDURE restaurant_has_wifi AS 

thisRestaurant restaurant%ROWTYPE;

CURSOR all_wifi_restaurants IS
SELECT * FROM RESTAURANT WHERE wifi LIKE '1';

BEGIN
dbms_output.put_line('List of restaurants with wifi: ');
OPEN all_wifi_restaurants;
LOOP
  FETCH all_wifi_restaurants INTO thisRestaurant;
  EXIT WHEN (all_wifi_restaurants%NOTFOUND);
  dbms_output.put_line(thisRestaurant.restaurant_name);
END LOOP;
CLOSE all_wifi_restaurants;
END;

SET SERVEROUT ON
EXECUTE restaurant_has_wifi;

--data for trigger pwd_change_notification
insert into credentials values (2, 'pwd');
insert into customer values (2, 'Victor', 'Wooten', 'vwoot@hotmail.com', NULL);

create or replace trigger pwd_change_notification
 AFTER UPDATE OF PASSWD ON CREDENTIAL
 BEGIN
    dbms_output.put_line('password has been changed.');
 END;

-- test the trigger by updating password value
SET SERVEROUT ON 
UPDATE CREDENTIAL SET PASSWD = 'pass-word' where user_id = 2;

--data for trigger check_customer_payment_details
insert into credential values(3, 'alliance');
insert into credential values(4, 'horde');
insert into host values(3, 'Anduin', 'Wrynn', 'anduin_wrynn@battle.net',NULL);
insert into property values(3,'housing',3,75,NULL,'18002937684','Trade District',NULL,'Stormwind city',NULL,'Azeroth',NULL);
insert into housing values(3,'0','0','0','1','1','1','0','0','5','5');
insert into customer values(4,'Garrosh','Hellscream','gscream@yahoo.com',NULL,NULL);

-- trigger to check payment details of customer before they can create a booking
CREATE OR REPLACE TRIGGER check_customer_payment_details
BEFORE INSERT ON BOOKING FOR EACH ROW
DECLARE
payment customer.payment_details%TYPE;
customer_id booking.customer_id%TYPE;
BEGIN
    SELECT payment_details INTO payment from customer c
    WHERE c.user_id = :new.customer_id;
    IF payment IS NULL THEN
        RAISE_APPLICATION_ERROR(-20000, 'Customer does not have payment details');
    END IF;
END;

--test trigger should raise error since the customer referenced has no payment details
insert into booking values(1,4,3,3,1,NULL,NULL);
