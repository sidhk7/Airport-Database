-- Find out count of flight bookings with an amount greater than 5000

SELECT COUNT(booking_id) AS 'Bookings Greater Than Price of 5000'
FROM   BOOKING
WHERE (amount > 5000)

------------------------------------------------------------------------------>

-- Find out the number of bookings from each airport

SELECT a.airport_name, COUNT(*) AS num_bookings
FROM   AIRPORT AS a INNER JOIN
             BOOKING AS b ON a.airport_id = b.from_airport
GROUP BY a.airport_name

------------------------------------------------------------------------------>

-- Find out the tickets with an amount greater than 10000 and display its class

SELECT t.ticket_id, s.price, s.class
FROM   TICKET AS t INNER JOIN
             SEAT_CLASS AS s ON t.class_id = s.class_id
ORDER BY s.price

------------------------------------------------------------------------------>

-- Analysis of Ticket prices with Booking Status

SELECT confirm_status AS 'STATUS', COUNT(*) AS 'COUNT', AVG(amount) AS 'AVG_TICKET_PRICE', 
             CASE WHEN confirm_status = 'cancelled' THEN 'Higher priced tickets are getting cancelled' 
				  WHEN confirm_status = 'confirmed' THEN 'Ticket Price around 5000 have the lowest chance of getting cancelled' 
				  WHEN confirm_status = 're-booked' THEN 'Trips with lower ticket prices are prone to postponement'
              END AS 'INFERENCE'
FROM   BOOKING
GROUP BY confirm_status

------------------------------------------------------------------------------>

-- Get the list of Confirmed Passengers and their travel plan


SELECT CONCAT(pd.first_name, ' ', pd.last_name)  AS 'CONFIRMED_PASSENGERS', ct1.city_name AS 'SOURCE', ct2.city_name AS 'DESTINATION'
FROM   BOOKING AS bo INNER JOIN
             PASSENGER_DETAILS AS pd ON bo.passenger_id = pd.passenger_id INNER JOIN
             CITY AS ct1 ON bo.from_airport = ct1.city_id INNER JOIN
             CITY AS ct2 ON bo.to_airport = ct2.city_id
WHERE (bo.confirm_status = 'confirmed')

------------------------------------------------------------------------------>

-- Get the list of employees with their managers and designation as a derived attribute

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'EMPLOYEE_NAME', CONCAT(m.first_name, ' ', m.last_name)  AS 'MANAGER_NAME', CASE WHEN concat(e.first_name, ' ', e.last_name) =
                 (SELECT concat(temp1.first_name, ' ', temp1.last_name)
                 FROM    employee AS temp1
                 WHERE temp1.manager_id IS NULL) THEN 'President' WHEN concat(m.first_name, ' ', m.last_name) =
                 (SELECT concat(temp2.first_name, ' ', temp2.last_name)
                 FROM    employee AS temp2
                 WHERE temp2.manager_id IS NULL) THEN 'Vice President' ELSE 'Assosciate' END AS 'DESIGNATION'
FROM   EMPLOYEE AS e LEFT OUTER JOIN
             EMPLOYEE AS m ON e.manager_id = m.employee_id
			 

------------------------------------------------------------------------------>

-- Rank the airlines in terms of their age in descending order.

SELECT RANK() OVER(ORDER BY (YEAR(GETDATE()) - commenced) DESC) AS 'Rank', airline_name, 
YEAR(GETDATE()) - commenced AS 'Age' 
FROM AIRLINE

------------------------------------------------------------------------------>

-- Display the name, age and experience of all employees and rank them based on their experience in the company.

SELECT   CONCAT(first_name, last_name)  AS NAME, DATEDIFF(YY, date_of_birth, GETDATE()) AS AGE, 
		DATEDIFF(YY, date_of_joining, GETDATE()) AS EXPERIENCE,
		DENSE_RANK () OVER ( 
			ORDER BY datediff(YY, date_of_joining, getdate()),DATEDIFF(YY, date_of_birth, GETDATE()) DESC
			) as 'DENSE_RANK',
		RANK () OVER ( 
			ORDER BY datediff(YY, date_of_joining, getdate()),DATEDIFF(YY, date_of_birth, GETDATE()) DESC
			) as 'RANK'
FROM   EMPLOYEE
			 
------------------------------------------------------------------------------>

-- Get the details of passengers with respect to the countries they are from, details should include city and state for each of them as well

SELECT CONCAT(pd.first_name,' ',pd.last_name) AS PASSENGER_NAME, ct.city_name AS 'CITY', st.state_name AS 'STATE',co.country_name AS 'COUNTRY',
COUNT(*) OVER(PARTITION BY country_name) AS 'NUM_OF_PASSENGERS_BY_COUNTRY' 
FROM PASSENGER_DETAILS as pd JOIN CITY AS ct ON (pd.city_id = ct.city_id) 
							 JOIN STATE AS st ON (ct.state_id = st.state_id) 
							 JOIN COUNTRY AS co ON (st.country_id = co.country_id)
							 
------------------------------------------------------------------------------>

-- Sum of Salary per Department, including details of salary for each employee and their department names.

SELECT CONCAT(emp.first_name, ' ', emp.last_name)  AS 'EMPLOYEE_NAME', DEPT_NAME, 
es.SALARY,
SUM(es.SALARY) OVER(PARTITION BY DEPT_NAME) AS 'SUM_OF_SALARY_PER_DEPARTMENT'
FROM
employee AS emp INNER JOIN employee_salary AS es ON emp.employee_id = es.employee_id 
				INNER JOIN DEPARTMENT AS dept ON emp.dept_id = dept.dept_id
				

------------------------------------------------------------------------------>