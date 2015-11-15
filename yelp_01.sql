USE yelp;

CREATE TABLE business (
  row_id integer,
  business_id varchar(50),
  full_address varchar(200),
  open varchar(20),
  city varchar(50),
  state varchar(50),
  review_count integer,
  bname varchar(200),
  longitude decimal(11,7),
  latitude decimal(11,7),
  stars decimal(5,2),
  btype varchar(50),
  PRIMARY KEY (business_id)
) ;

TRUNCATE business;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/business_tab.csv'
INTO TABLE business
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE category (
  row_id integer,
  business_id varchar(50),
  category varchar(100),
  PRIMARY KEY (business_id, category)
) ;

TRUNCATE category;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/cat_tab.csv'
INTO TABLE category
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE attribute (
  row_id integer,
  business_id varchar(50),
  By_Appointment_Only varchar(50),
	Happy_Hour varchar(50),
	Accepts_Credit_Cards varchar(50),
	Good_For_Groups varchar(50),
	Outdoor_Seating varchar(50),
	Price_Range varchar(50),
	Good_for_Kids varchar(50),
	Alcohol varchar(50),
	Noise_Level varchar(50),
	Has_TV varchar(50),
	Attire varchar(50),
	Good_For_Dancing varchar(50),
	Delivery varchar(50),
	Coat_Check varchar(50),
	Smoking varchar(50),
	Take_out varchar(50),
	Takes_Reservations varchar(50),
	Waiter_Service varchar(50),
	Wi_Fi varchar(50),
	Caters varchar(50),
	Drive__hru varchar(50),
	Wheelchair_Accessible varchar(50),
	BYOB varchar(50),
	Corkage varchar(50),
	BYOB_Corkage varchar(50),
	Order_at_Counter varchar(50),
	Good_For_Kids2 varchar(50),
	Dogs_Allowed varchar(50),
	Open_24_Hours varchar(50),
	Accepts_Insurance varchar(50),
	Ages_Allowed varchar(50),
	ambience_romantic varchar(50),
	ambience_intimate varchar(50),
	ambience_classy varchar(50),
	ambience_hipster varchar(50),
	ambience_divey varchar(50),
	ambience_touristy varchar(50),
	ambience_trendy varchar(50),
	ambience_upscale varchar(50),
	ambience_casual varchar(50),
	good_for_dessert varchar(50),
	good_for_latenight varchar(50),
	good_for_lunch varchar(50),
	good_for_dinner varchar(50),
	good_for_breakfast varchar(50),
	good_for_brunch varchar(50),
	parking_garage varchar(50),
	parking_street varchar(50),
	parking_validated varchar(50),
	parking_lot varchar(50),
	parking_valet varchar(50),
	music_dj varchar(50),
	music_background_music varchar(50),
	music_karaoke varchar(50),
	music_live varchar(50),
	music_video varchar(50),
	music_jukebox varchar(50),
	music_playlist varchar(50),
	hair_coloring varchar(50),
	hair_africanamerican varchar(50),
	hair_curly varchar(50),
	hair_perms varchar(50),
	hair_kids varchar(50),
	hair_extensions varchar(50),
	hair_asian varchar(50),
	hair_straightperms varchar(50),
	payment_amex varchar(50),
	payment_cash_only varchar(50),
	payment_mastercard varchar(50),
	payment_visa varchar(50),
	payment_discover varchar(50),
	dietary_dairy_free varchar(50),
	dietary_gluten_free varchar(50),
	dietary_vegan varchar(50),
	dietary_kosher varchar(50),
	dietary_halal varchar(50),
	dietary_soy_free varchar(50),
	dietary_vegetarian varchar(50),
  PRIMARY KEY (business_id)
) ;

TRUNCATE attribute;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/att_tab.csv'
INTO TABLE attribute
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE checkin (
  row_id integer,
  business_id varchar(50),
	fri_9 integer,
	fri_7 integer,
	wed_13 integer,
	sat_17 integer,
	sun_13 integer,
	wed_17 integer,
	sun_10 integer,
	thr_18 integer,
	sat_14 integer,
	fri_22 integer,
	mon_15 integer,
	thr_15 integer,
	tue_16 integer,
	thr_21 integer,
	mon_13 integer,
	thr_14 integer,
	fri_12 integer,
	mon_12 integer,
	mon_9 integer,
	wed_18 integer,
	tue_15 integer,
	thr_8 integer,
	fri_17 integer,
	thr_17 integer,
	tue_11 integer,
	thr_12 integer,
	thr_10 integer,
	mon_8 integer,
	thr_9 integer,
	sun_9 integer,
	mon_18 integer,
	sat_19 integer,
	sat_7 integer,
	fri_11 integer,
	thr_11 integer,
	tue_17 integer,
	fri_6 integer,
	tue_12 integer,
	thr_7 integer,
	tue_18 integer,
	mon_16 integer,
	tue_19 integer,
	wed_12 integer,
	sat_10 integer,
	tue_13 integer,
	thr_16 integer,
	fri_10 integer,
	tue_20 integer,
	thr_4 integer,
	tue_9 integer,
	tue_10 integer,
	sun_4 integer,
	mon_4 integer,
	sat_11 integer,
	mon_11 integer,
	mon_10 integer,
	sat_6 integer,
	mon_5 integer,
	wed_6 integer,
	sun_6 integer,
	mon_6 integer,
	fri_5 integer,
	wed_9 integer,
	sat_5 integer,
	sat_4 integer,
	sat_9 integer,
	wed_7 integer,
	tue_7 integer,
	mon_7 integer,
	thr_3 integer,
	wed_3 integer,
	fri_8 integer,
	sat_8 integer,
	wed_10 integer,
	tue_8 integer,
	wed_8 integer,
	thr_5 integer,
	tue_6 integer,
	sun_8 integer,
	thr_19 integer,
	thr_13 integer,
	thr_20 integer,
	fri_13 integer,
	fri_15 integer,
	sun_17 integer,
	fri_19 integer,
	sun_15 integer,
	wed_15 integer,
	fri_1 integer,
	sun_19 integer,
	mon_19 integer,
	fri_16 integer,
	sun_12 integer,
	fri_4 integer,
	fri_18 integer,
	sat_18 integer,
	sat_16 integer,
	tue_14 integer,
	sat_13 integer,
	fri_14 integer,
	mon_14 integer,
	sun_16 integer,
	mon_17 integer,
	wed_5 integer,
	sat_20 integer,
	sun_11 integer,
	sat_15 integer,
	tue_3 integer,
	wed_19 integer,
	sat_12 integer,
	tue_4 integer,
	sun_7 integer,
	sun_14 integer,
	thr_6 integer,
	wed_16 integer,
	thr_22 integer,
	mon_22 integer,
	fri_23 integer,
	fri_0 integer,
	sat_0 integer,
	mon_0 integer,
	wed_11 integer,
	fri_20 integer,
	fri_21 integer,
	mon_21 integer,
	tue_21 integer,
	wed_21 integer,
	sun_22 integer,
	sun_18 integer,
	wed_14 integer,
	mon_20 integer,
	wed_20 integer,
	tue_23 integer,
	sat_21 integer,
	thr_0 integer,
	fri_3 integer,
	sun_20 integer,
	wed_22 integer,
	sun_5 integer,
	mon_3 integer,
	sun_3 integer,
	tue_5 integer,
	wed_4 integer,
	sat_22 integer,
	sat_3 integer,
	sat_2 integer,
	tue_22 integer,
	sun_1 integer,
	sun_21 integer,
	wed_2 integer,
	wed_1 integer,
	sun_2 integer,
	tue_0 integer,
	thr_23 integer,
	sun_23 integer,
	tue_2 integer,
	thr_2 integer,
	mon_23 integer,
	mon_2 integer,
	sat_1 integer,
	fri_2 integer,
	sat_23 integer,
	wed_0 integer,
	tue_1 integer,
	thr_1 integer,
	wed_23 integer,
	mon_1 integer,
	sun_0 integer,
  PRIMARY KEY (business_id)
) ;

TRUNCATE checkin;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/checkin_tab.csv'
INTO TABLE checkin
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE review (
  row_id integer,
  business_id varchar(50),
  user_id varchar(50),
  review_id varchar(50),
  rdate date,
  stars decimal(5,2),
  review_text varchar(50000),
  funny integer,
  useful integer,
  cool integer,
  PRIMARY KEY (business_id, user_id, review_id)
) ;

TRUNCATE review;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/review_tab.csv'
INTO TABLE review
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

ALTER TABLE review ADD INDEX index1 (rdate, stars ASC);

CREATE TABLE tip (
  row_id integer,
  business_id varchar(50),
  user_id varchar(50),
  tdate date,
  likes integer,
  tip_text varchar(50000),
  PRIMARY KEY (business_id, user_id)
) ;

TRUNCATE tip;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/tip_tab.csv'
INTO TABLE tip
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE user (
  row_id integer,
  user_id varchar(50),
  uname varchar(200),
  yelping_since char(7),
  review_count integer,
  fans integer,
  average_stars decimal(5,2),
  funny integer,
  useful integer,
  cool integer,
  PRIMARY KEY (user_id)
) ;

TRUNCATE user;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/user_tab.csv'
INTO TABLE user
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE user_friends (
  row_id integer,
  user_id varchar(50),
  friend_id varchar(50),
  PRIMARY KEY (user_id, friend_id)
) ;

TRUNCATE user_friends;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/friend_tab.csv'
INTO TABLE user_friends
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE compliments (
  row_id integer,
  user_id varchar(50),
  profile integer,
	cute integer,
	funny integer,
	plain integer,
	writer integer,
	note integer,
	photos integer,
	hot integer,
	cool integer,
	more integer,
	list integer,
  PRIMARY KEY (user_id)
) ;

TRUNCATE compliments;
LOAD DATA LOCAL
INFILE '/Users/rubenadad/Documents/CURSOS/Data Science Capstone/yelp_dataset_challenge_academic_dataset/compl_tab.csv'
INTO TABLE compliments
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES;

create view vcheckin as
SELECT checkin.row_id,
    checkin.business_id,
    checkin.fri_9 + 
    checkin.fri_7 +
    checkin.wed_13 +
    checkin.sat_17 +
    checkin.sun_13 +
    checkin.wed_17 +
    checkin.sun_10 +
    checkin.thr_18 +
    checkin.sat_14 +
    checkin.fri_22 +
    checkin.mon_15 +
    checkin.thr_15 +
    checkin.tue_16 +
    checkin.thr_21 +
    checkin.mon_13 +
    checkin.thr_14 +
    checkin.fri_12 +
    checkin.mon_12 +
    checkin.mon_9 +
    checkin.wed_18 +
    checkin.tue_15 +
    checkin.thr_8 +
    checkin.fri_17 +
    checkin.thr_17 +
    checkin.tue_11 +
    checkin.thr_12 +
    checkin.thr_10 +
    checkin.mon_8 +
    checkin.thr_9 +
    checkin.sun_9 +
    checkin.mon_18 +
    checkin.sat_19 +
    checkin.sat_7 +
    checkin.fri_11 +
    checkin.thr_11 +
    checkin.tue_17 +
    checkin.fri_6 +
    checkin.tue_12 +
    checkin.thr_7 +
    checkin.tue_18 +
    checkin.mon_16 +
    checkin.tue_19 +
    checkin.wed_12 +
    checkin.sat_10 +
    checkin.tue_13 +
    checkin.thr_16 +
    checkin.fri_10 +
    checkin.tue_20 +
    checkin.thr_4 +
    checkin.tue_9 +
    checkin.tue_10 +
    checkin.sun_4 +
    checkin.mon_4 +
    checkin.sat_11 +
    checkin.mon_11 +
    checkin.mon_10 +
    checkin.sat_6 +
    checkin.mon_5 +
    checkin.wed_6 +
    checkin.sun_6 +
    checkin.mon_6 +
    checkin.fri_5 +
    checkin.wed_9 +
    checkin.sat_5 +
    checkin.sat_4 +
    checkin.sat_9 +
    checkin.wed_7 +
    checkin.tue_7 +
    checkin.mon_7 +
    checkin.thr_3 +
    checkin.wed_3 +
    checkin.fri_8 +
    checkin.sat_8 +
    checkin.wed_10 +
    checkin.tue_8 +
    checkin.wed_8 +
    checkin.thr_5 +
    checkin.tue_6 +
    checkin.sun_8 +
    checkin.thr_19 +
    checkin.thr_13 +
    checkin.thr_20 +
    checkin.fri_13 +
    checkin.fri_15 +
    checkin.sun_17 +
    checkin.fri_19 +
    checkin.sun_15 +
    checkin.wed_15 +
    checkin.fri_1 +
    checkin.sun_19 +
    checkin.mon_19 +
    checkin.fri_16 +
    checkin.sun_12 +
    checkin.fri_4 +
    checkin.fri_18 +
    checkin.sat_18 +
    checkin.sat_16 +
    checkin.tue_14 +
    checkin.sat_13 +
    checkin.fri_14 +
    checkin.mon_14 +
    checkin.sun_16 +
    checkin.mon_17 +
    checkin.wed_5 +
    checkin.sat_20 +
    checkin.sun_11 +
    checkin.sat_15 +
    checkin.tue_3 +
    checkin.wed_19 +
    checkin.sat_12 +
    checkin.tue_4 +
    checkin.sun_7 +
    checkin.sun_14 +
    checkin.thr_6 +
    checkin.wed_16 +
    checkin.thr_22 +
    checkin.mon_22 +
    checkin.fri_23 +
    checkin.fri_0 +
    checkin.sat_0 +
    checkin.mon_0 +
    checkin.wed_11 +
    checkin.fri_20 +
    checkin.fri_21 +
    checkin.mon_21 +
    checkin.tue_21 +
    checkin.wed_21 +
    checkin.sun_22 +
    checkin.sun_18 +
    checkin.wed_14 +
    checkin.mon_20 +
    checkin.wed_20 +
    checkin.tue_23 +
    checkin.sat_21 +
    checkin.thr_0 +
    checkin.fri_3 +
    checkin.sun_20 +
    checkin.wed_22 +
    checkin.sun_5 +
    checkin.mon_3 +
    checkin.sun_3 +
    checkin.tue_5 +
    checkin.wed_4 +
    checkin.sat_22 +
    checkin.sat_3 +
    checkin.sat_2 +
    checkin.tue_22 +
    checkin.sun_1 +
    checkin.sun_21 +
    checkin.wed_2 +
    checkin.wed_1 +
    checkin.sun_2 +
    checkin.tue_0 +
    checkin.thr_23 +
    checkin.sun_23 +
    checkin.tue_2 +
    checkin.thr_2 +
    checkin.mon_23 +
    checkin.mon_2 +
    checkin.sat_1 +
    checkin.fri_2 +
    checkin.sat_23 +
    checkin.wed_0 +
    checkin.tue_1 +
    checkin.thr_1 +
    checkin.wed_23 +
    checkin.mon_1 +
    checkin.sun_0 as checkin_tot,
    checkin.mon_23 +
    checkin.mon_22 +
    checkin.mon_21 +
    checkin.mon_20 +
    checkin.mon_19 +
    checkin.mon_18 +
    checkin.mon_17 +
    checkin.mon_16 +
    checkin.mon_15 +
    checkin.mon_14 +
    checkin.mon_13 +
    checkin.mon_12 +
    checkin.mon_11 +
    checkin.mon_10 +
    checkin.mon_9 +
    checkin.mon_8 +
    checkin.mon_7 +
    checkin.mon_6 +
    checkin.mon_5 +
    checkin.mon_4 +
    checkin.mon_3 +
    checkin.mon_2 +
    checkin.mon_1 +
    checkin.mon_0 as checkin_mon,
    checkin.tue_23 +
    checkin.tue_22 +
    checkin.tue_21 +
    checkin.tue_20 +
    checkin.tue_19 +
    checkin.tue_18 +
    checkin.tue_17 +
    checkin.tue_16 +
    checkin.tue_15 +
    checkin.tue_14 +
    checkin.tue_13 +
    checkin.tue_12 +
    checkin.tue_11 +
    checkin.tue_10 +
    checkin.tue_9 +
    checkin.tue_8 +
    checkin.tue_7 +
    checkin.tue_6 +
    checkin.tue_5 +
    checkin.tue_4 +
    checkin.tue_3 +
    checkin.tue_2 +
    checkin.tue_1 +
    checkin.tue_0 as checkin_tue,
    checkin.wed_23 +
    checkin.wed_22 +
    checkin.wed_21 +
    checkin.wed_20 +
    checkin.wed_19 +
    checkin.wed_18 +
    checkin.wed_17 +
    checkin.wed_16 +
    checkin.wed_15 +
    checkin.wed_14 +
    checkin.wed_13 +
    checkin.wed_12 +
    checkin.wed_11 +
    checkin.wed_10 +
    checkin.wed_9 +
    checkin.wed_8 +
    checkin.wed_7 +
    checkin.wed_6 +
    checkin.wed_5 +
    checkin.wed_4 +
    checkin.wed_3 +
    checkin.wed_2 +
    checkin.wed_1 +
    checkin.wed_0 as checkin_wed,
    checkin.thr_23 +
    checkin.thr_22 +
    checkin.thr_21 +
    checkin.thr_20 +
    checkin.thr_19 +
    checkin.thr_18 +
    checkin.thr_17 +
    checkin.thr_16 +
    checkin.thr_15 +
    checkin.thr_14 +
    checkin.thr_13 +
    checkin.thr_12 +
    checkin.thr_11 +
    checkin.thr_10 +
    checkin.thr_9 +
    checkin.thr_8 +
    checkin.thr_7 +
    checkin.thr_6 +
    checkin.thr_5 +
    checkin.thr_4 +
    checkin.thr_3 +
    checkin.thr_2 +
    checkin.thr_1 +
    checkin.thr_0 as checkin_thr,
    checkin.fri_23 +
    checkin.fri_22 +
    checkin.fri_21 +
    checkin.fri_20 +
    checkin.fri_19 +
    checkin.fri_18 +
    checkin.fri_17 +
    checkin.fri_16 +
    checkin.fri_15 +
    checkin.fri_14 +
    checkin.fri_13 +
    checkin.fri_12 +
    checkin.fri_11 +
    checkin.fri_10 +
    checkin.fri_9 +
    checkin.fri_8 +
    checkin.fri_7 +
    checkin.fri_6 +
    checkin.fri_5 +
    checkin.fri_4 +
    checkin.fri_3 +
    checkin.fri_2 +
    checkin.fri_1 +
    checkin.fri_0 as checkin_fri,
    checkin.sat_23 +
    checkin.sat_22 +
    checkin.sat_21 +
    checkin.sat_20 +
    checkin.sat_19 +
    checkin.sat_18 +
    checkin.sat_17 +
    checkin.sat_16 +
    checkin.sat_15 +
    checkin.sat_14 +
    checkin.sat_13 +
    checkin.sat_12 +
    checkin.sat_11 +
    checkin.sat_10 +
    checkin.sat_9 +
    checkin.sat_8 +
    checkin.sat_7 +
    checkin.sat_6 +
    checkin.sat_5 +
    checkin.sat_4 +
    checkin.sat_3 +
    checkin.sat_2 +
    checkin.sat_1 +
    checkin.sat_0 as checkin_sat,
    checkin.sun_23 +
    checkin.sun_22 +
    checkin.sun_21 +
    checkin.sun_20 +
    checkin.sun_19 +
    checkin.sun_18 +
    checkin.sun_17 +
    checkin.sun_16 +
    checkin.sun_15 +
    checkin.sun_14 +
    checkin.sun_13 +
    checkin.sun_12 +
    checkin.sun_11 +
    checkin.sun_10 +
    checkin.sun_9 +
    checkin.sun_8 +
    checkin.sun_7 +
    checkin.sun_6 +
    checkin.sun_5 +
    checkin.sun_4 +
    checkin.sun_3 +
    checkin.sun_2 +
    checkin.sun_1 +
    checkin.sun_0 as checkin_sun,
    checkin.mon_0 +
    checkin.tue_0 +
    checkin.wed_0 +
    checkin.thr_0 +
    checkin.fri_0 +
    checkin.sat_0 +
    checkin.sun_0 as checkin_0,
    checkin.mon_1 +
    checkin.tue_1 +
    checkin.wed_1 +
    checkin.thr_1 +
    checkin.fri_1 +
    checkin.sat_1 +
    checkin.sun_1 as checkin_1,
    checkin.mon_2 +
    checkin.tue_2 +
    checkin.wed_2 +
    checkin.thr_2 +
    checkin.fri_2 +
    checkin.sat_2 +
    checkin.sun_2 as checkin_2,
    checkin.mon_3 +
    checkin.tue_3 +
    checkin.wed_3 +
    checkin.thr_3 +
    checkin.fri_3 +
    checkin.sat_3 +
    checkin.sun_3 as checkin_3,
    checkin.mon_4 +
    checkin.tue_4 +
    checkin.wed_4 +
    checkin.thr_4 +
    checkin.fri_4 +
    checkin.sat_4 +
    checkin.sun_4 as checkin_4,
    checkin.mon_5 +
    checkin.tue_5 +
    checkin.wed_5 +
    checkin.thr_5 +
    checkin.fri_5 +
    checkin.sat_5 +
    checkin.sun_5 as checkin_5,
    checkin.mon_6 +
    checkin.tue_6 +
    checkin.wed_6 +
    checkin.thr_6 +
    checkin.fri_6 +
    checkin.sat_6 +
    checkin.sun_6 as checkin_6,
    checkin.mon_7 +
    checkin.tue_7 +
    checkin.wed_7 +
    checkin.thr_7 +
    checkin.fri_7 +
    checkin.sat_7 +
    checkin.sun_7 as checkin_7,
    checkin.mon_8 +
    checkin.tue_8 +
    checkin.wed_8 +
    checkin.thr_8 +
    checkin.fri_8 +
    checkin.sat_8 +
    checkin.sun_8 as checkin_8,
    checkin.mon_9 +
    checkin.tue_9 +
    checkin.wed_9 +
    checkin.thr_9 +
    checkin.fri_9 +
    checkin.sat_9 +
    checkin.sun_9 as checkin_9,
    checkin.mon_10 +
    checkin.tue_10 +
    checkin.wed_10 +
    checkin.thr_10 +
    checkin.fri_10 +
    checkin.sat_10 +
    checkin.sun_10 as checkin_10,
    checkin.mon_11 +
    checkin.tue_11 +
    checkin.wed_11 +
    checkin.thr_11 +
    checkin.fri_11 +
    checkin.sat_11 +
    checkin.sun_11 as checkin_11,
    checkin.mon_12 +
    checkin.tue_12 +
    checkin.wed_12 +
    checkin.thr_12 +
    checkin.fri_12 +
    checkin.sat_12 +
    checkin.sun_12 as checkin_12,
    checkin.mon_13 +
    checkin.tue_13 +
    checkin.wed_13 +
    checkin.thr_13 +
    checkin.fri_13 +
    checkin.sat_13 +
    checkin.sun_13 as checkin_13,
    checkin.mon_14 +
    checkin.tue_14 +
    checkin.wed_14 +
    checkin.thr_14 +
    checkin.fri_14 +
    checkin.sat_14 +
    checkin.sun_14 as checkin_14,
    checkin.mon_15 +
    checkin.tue_15 +
    checkin.wed_15 +
    checkin.thr_15 +
    checkin.fri_15 +
    checkin.sat_15 +
    checkin.sun_15 as checkin_15,
    checkin.mon_16 +
    checkin.tue_16 +
    checkin.wed_16 +
    checkin.thr_16 +
    checkin.fri_16 +
    checkin.sat_16 +
    checkin.sun_16 as checkin_16,
    checkin.mon_17 +
    checkin.tue_17 +
    checkin.wed_17 +
    checkin.thr_17 +
    checkin.fri_17 +
    checkin.sat_17 +
    checkin.sun_17 as checkin_17,
    checkin.mon_18 +
    checkin.tue_18 +
    checkin.wed_18 +
    checkin.thr_18 +
    checkin.fri_18 +
    checkin.sat_18 +
    checkin.sun_18 as checkin_18,
    checkin.mon_19 +
    checkin.tue_19 +
    checkin.wed_19 +
    checkin.thr_19 +
    checkin.fri_19 +
    checkin.sat_19 +
    checkin.sun_19 as checkin_19,
    checkin.mon_20 +
    checkin.tue_20 +
    checkin.wed_20 +
    checkin.thr_20 +
    checkin.fri_20 +
    checkin.sat_20 +
    checkin.sun_20 as checkin_20,
    checkin.mon_21 +
    checkin.tue_21 +
    checkin.wed_21 +
    checkin.thr_21 +
    checkin.fri_21 +
    checkin.sat_21 +
    checkin.sun_21 as checkin_21,
    checkin.mon_22 +
    checkin.tue_22 +
    checkin.wed_22 +
    checkin.thr_22 +
    checkin.fri_22 +
    checkin.sat_22 +
    checkin.sun_22 as checkin_22,
    checkin.mon_23 +
    checkin.tue_23 +
    checkin.wed_23 +
    checkin.thr_23 +
    checkin.fri_23 +
    checkin.sat_23 +
    checkin.sun_23 as checkin_23
FROM yelp.checkin;