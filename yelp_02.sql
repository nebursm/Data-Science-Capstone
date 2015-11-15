USE yelp;
SELECT * FROM yelp.business;
SELECT * FROM yelp.category;
SELECT * FROM yelp.attribute;
SELECT * FROM yelp.checkin;
SELECT * FROM yelp.review;
SELECT * FROM yelp.tip;
SELECT * FROM yelp.user;
SELECT * FROM yelp.user_friends;
SELECT * FROM yelp.compliments;

SELECT wi_fi, count(*) 
FROM attribute
group by wi_fi 
;
select * from tip
where tip_text like 'Consistently terrible%'
;
select * from compliments c, user u
where c.user_id = u.user_id
and c.funny > 10000
;
select count(*)
from user
where fans > 1
and funny > 1
;
select category, count(*) 
from category
group by category
order by 2 desc;

select Ages_Allowed, count(*)
from attribute
group by Ages_Allowed;

SELECT b.row_id,
    b.business_id,
    b.full_address,
    b.open,
    b.city,
    b.state,
    b.review_count,
    b.bname,
    b.longitude,
    b.latitude,
    b.stars,
    b.btype,
    c.category,
    ch.checkin_tot,
    ch.checkin_mon,
    ch.checkin_tue,
    ch.checkin_wed,
    ch.checkin_thr,
    ch.checkin_fri,
    ch.checkin_sat,
    ch.checkin_sun,
    ch.checkin_0,
    ch.checkin_1,
    ch.checkin_2,
    ch.checkin_3,
    ch.checkin_4,
    ch.checkin_5,
    ch.checkin_6,
    ch.checkin_7,
    ch.checkin_8,
    ch.checkin_9,
    ch.checkin_10,
    ch.checkin_11,
    ch.checkin_12,
    ch.checkin_13,
    ch.checkin_14,
    ch.checkin_15,
    ch.checkin_16,
    ch.checkin_17,
    ch.checkin_18,
    ch.checkin_19,
    ch.checkin_20,
    ch.checkin_21,
    ch.checkin_22,
    ch.checkin_23,
    a.By_Appointment_Only,
    a.Happy_Hour,
    a.Accepts_Credit_Cards,
    a.Good_For_Groups,
    a.Outdoor_Seating,
    a.Price_Range,
    a.Good_for_Kids,
    a.Alcohol,
    a.Noise_Level,
    a.Has_TV,
    a.Attire,
    a.Good_For_Dancing,
    a.Delivery,
    a.Coat_Check,
    a.Smoking,
    a.Take_out,
    a.Takes_Reservations,
    a.Waiter_Service,
    a.Wi_Fi,
    a.Caters,
    a.Drive__hru,
    a.Wheelchair_Accessible,
    a.BYOB,
    a.Corkage,
    a.BYOB_Corkage,
    a.Order_at_Counter,
    a.Good_For_Kids2,
    a.Dogs_Allowed,
    a.Open_24_Hours,
    a.Accepts_Insurance,
    a.Ages_Allowed,
    a.ambience_romantic,
    a.ambience_intimate,
    a.ambience_classy,
    a.ambience_hipster,
    a.ambience_divey,
    a.ambience_touristy,
    a.ambience_trendy,
    a.ambience_upscale,
    a.ambience_casual,
    a.good_for_dessert,
    a.good_for_latenight,
    a.good_for_lunch,
    a.good_for_dinner,
    a.good_for_breakfast,
    a.good_for_brunch,
    a.parking_garage,
    a.parking_street,
    a.parking_validated,
    a.parking_lot,
    a.parking_valet,
    a.music_dj,
    a.music_background_music,
    a.music_karaoke,
    a.music_live,
    a.music_video,
    a.music_jukebox,
    a.music_playlist,
    a.hair_coloring,
    a.hair_africanamerican,
    a.hair_curly,
    a.hair_perms,
    a.hair_kids,
    a.hair_extensions,
    a.hair_asian,
    a.hair_straightperms,
    a.payment_amex,
    a.payment_cash_only,
    a.payment_mastercard,
    a.payment_visa,
    a.payment_discover,
    a.dietary_dairy_free,
    a.dietary_gluten_free,
    a.dietary_vegan,
    a.dietary_kosher,
    a.dietary_halal,
    a.dietary_soy_free,
    a.dietary_vegetarian,
    t.tip_count
FROM yelp.business b, yelp.category c, yelp.vcheckin ch, yelp.attribute a,
(select business_id, count(*) as tip_count
from yelp.tip
group by business_id) as t
where b.business_id = c.business_id
and c.category in ('Restaurants', 'Shopping')
and b.business_id = ch.business_id
and b.business_id = a.business_id
and b.business_id = t.business_id
;
	
SELECT u.row_id,
    u.user_id,
    u.uname,
    u.yelping_since,
    u.review_count,
    u.fans,
    u.average_stars,
    u.funny,
    u.useful,
    u.cool,
    com.tot_compliments,
    uf.user_friends,
    t.tip_count
FROM yelp.user u,
(
SELECT com.user_id,
    com.profile +
    com.cute +
    com.funny +
    com.plain +
    com.writer +
    com.note +
    com.photos +
    com.hot +
    com.cool +
    com.more +
    com.list as tot_compliments
FROM yelp.compliments com
) as com,
(select user_id, count(*) as user_friends
from user_friends
group by user_id) as uf,
(select user_id, count(*) as tip_count
from yelp.tip
group by user_id) as t
where u.user_id = com.user_id 
and u.user_id = uf.user_id
and u.user_id = t.user_id
;

select business_id, year(rdate) as anio, month(rdate) as mes
	, count(*) as review_count, avg(stars) as avg_stars
from review
where year(rdate) = 2014
group by business_id
order by anio, mes, business_id
;

select user_id, year(rdate) as anio, month(rdate) as mes
	, count(*) as review_count, avg(stars) as avg_stars
from review
where year(rdate) = 2014
group by user_id
order by anio, mes, user_id
;

select count(*)
from checkin
;
