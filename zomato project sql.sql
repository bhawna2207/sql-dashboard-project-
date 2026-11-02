Create database zometo_project;
use zometo_project;

select * from Restaurant_data;
select * from date_table;
select * from country_table;

SELECT
r.*,
c.Country
FROM Restaurant_Data r
JOIN Country_table c
ON r.CountryCode=c.CountryCode;


# Total resturent
SELECT
COUNT(RestaurantID) AS Total_Restaurants
FROM Restaurant_data;

#average rating 

SELECT
ROUND(AVG(Rating),2) AS Average_Rating
FROM Restaurant_data;

# total booikngs
SELECT
COUNT(*) AS Total_Table_Bookings
FROM Restaurant_data
WHERE Has_Table_booking = 'Yes';

#city count 
SELECT
COUNT(DISTINCT City) AS Total_Cities
FROM Restaurant_data;

#country count
SELECT
COUNT(DISTINCT CountryCode) AS Total_Countries
FROM Restaurant_data;

# average cost for two 
SELECT
ROUND(AVG(Average_Cost_for_two),2) AS Average_Cost
FROM Restaurant_data;

# Number of restaurant by country & city 
SELECT
c.Country,
r.City,
COUNT(r.RestaurantID) AS Number_of_Restaurants
FROM Restaurant_Data r
JOIN Country_Table c
ON r.CountryCode = c.CountryCode
GROUP BY
c.Country,
r.City With rollup
ORDER BY
c.Country,
Number_of_Restaurants DESC;

#.Numbers of Resturants opening based on Year , Quarter , Month 
SELECT
d.Year,
d.Qtr_q1_q2_q3_q4 AS Quarter,
d.Monthfullname,
COUNT(r.RestaurantID) AS TotalRestaurants
FROM Restaurant_data r
JOIN Date_Table d
ON r.Datekey_Opening=d.Datekey_Opening
GROUP BY
d.Year,
d.Qtr_q1_q2_q3_q4,
d.Monthfullname with rollup
ORDER BY
d.Year,
MIN(d.Monthno) DESC;

#Count of Restaurants based on Average Rating
SELECT
Rating,
COUNT(*) AS RestaurantCount
FROM Restaurant_Data
GROUP BY Rating with rollup
ORDER BY Rating;  

# Rating Bucket 
SELECT
CASE
WHEN Rating<=2 THEN 'Poor'
WHEN Rating<=3 THEN 'Average'
WHEN Rating<=4 THEN 'Good'
ELSE 'Excellent'
END AS RatingCategory,
COUNT(*) AS Restaurants
FROM Restaurant_data
GROUP BY
CASE
WHEN Rating<=2 THEN 'Poor'
WHEN Rating<=3 THEN 'Average'
WHEN Rating<=4 THEN 'Good'
ELSE 'Excellent'
END With rollup
ORDER BY Restaurants DESC;

# Average Cost Bucket 
SELECT
CASE
WHEN Average_Cost_for_two<=500 THEN '0-500'
WHEN Average_Cost_for_two<=1000 THEN '501-1000'
WHEN Average_Cost_for_two<=2000 THEN '1001-2000'
WHEN Average_Cost_for_two<=3000 THEN '2001-3000'
ELSE '3000+'
END AS PriceBucket,
COUNT(*) AS Restaurants
FROM Restaurant_Data
GROUP BY
CASE
WHEN Average_Cost_for_two<=500 THEN '0-500'
WHEN Average_Cost_for_two<=1000 THEN '501-1000'
WHEN Average_Cost_for_two<=2000 THEN '1001-2000'
WHEN Average_Cost_for_two<=3000 THEN '2001-3000'
ELSE '3000+'
END with rollup
ORDER BY Restaurants DESC;

# Percentage of Has_Table_Booking 
SELECT
Has_Table_booking,
COUNT(*) AS Restaurants,
ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),2) AS Percentage
FROM Restaurant_Data
GROUP BY Has_Table_booking With rollup;

#Percentag Of Restaurant Has_Online_Delivery
SELECT
Has_Online_delivery,
COUNT(*) AS Restaurants,
ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),2) AS Percentage
FROM Restaurant_Data
GROUP BY Has_Online_delivery with rollup;

#Cuisine Wise Restaurants
SELECT
Cuisines,
COUNT(*) AS Restaurants
FROM Restaurant_Data
GROUP BY Cuisines With rollup
ORDER BY Restaurants DESC;

# City Wise Restaurants
SELECT
City,
COUNT(*) AS Restaurants
FROM Restaurant_Data
GROUP BY City with rollup
ORDER BY Restaurants DESC;

#Rating Distribution
SELECT
Rating,
COUNT(*) AS Restaurants
FROM Restaurant_Data
GROUP BY Rating with rollup
ORDER BY Rating;




