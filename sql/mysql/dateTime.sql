-- check date is valid or not in mysql
SELECT CASE
    WHEN STR_TO_DATE ('2025-05-20', '%Y-%m-%d') IS NOT NULL THEN 1
    ELSE 0
  END AS is_valid_date;

-- From our tabel
SELECT your_column,
  CASE
    WHEN STR_TO_DATE (your_column, '%Y-%m-%d') IS NOT NULL THEN 1
    ELSE 0
  END AS is_valid_date
FROM
  your_table;

-- get DAY from Dates
select DAY (NOW ()); -- returns 20
select DAY ('2025-05-20'); -- returns 20
select DAY ('01/31/2025'); -- returns NULL

select MONTH (NOW ()); -- returns 05
select MONTH ('2025-05-20'); -- returns 05
select MONTH ('01/31/2025'); -- returns NULL

select YEAR (NOW ()); -- returns 2025 
select YEAR ('2025-05-20'); -- returns 2025
select YEAR ('01/31/2025'); -- returns NULL

SELECT DAY('2025-05-20 16:35:02.803'); --return 20
SELECT DAYNAME('2025-05-20 16:35:02.803'); -- return Tuesday
SELECT MONTHNAME('2025-05-20 16:35:02.803');-- return MAY
SELECT QUARTER('2025-05-20 16:35:02.803');-- return 2
SELECT WEEK('2025-05-20 16:35:02.803');-- return 21