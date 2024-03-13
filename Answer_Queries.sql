-- JOIN Section
-- QUESTION 1
-- Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.
SELECT NAME_OF_SCHOOL,
    S.COMMUNITY_AREA_NAME,
    AVERAGE_STUDENT_ATTENDANCE
FROM chicago_public_schools S
    JOIN chicago_socioeconomic_data E ON S.COMMUNITY_AREA_NUMBER = E.COMMUNITY_AREA_NUMBER
WHERE E.HARDSHIP_INDEX = 98;
-- QUESTION 2
-- Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.
SELECT CASE_NUMBER,
    PRIMARY_TYPE,
    COMMUNITY_AREA_NAME
FROM chicago_crime C
    JOIN chicago_socioeconomic_data E ON C.COMMUNITY_AREA_NUMBER = E.COMMUNITY_AREA_NUMBER
WHERE LOCATION_DESCRIPTION LIKE "%school%";
-- VIEW Section
-- QUESTION 1
-- Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.
CREATE VIEW CHICAGO_SCHOOL_SAFETY (
    School_Name,
    Safety_Rating,
    Family_Rating,
    Environment_Rating,
    Instruction_Rating,
    Leaders_Rating,
    Teachers_Rating
) AS
SELECT NAME_OF_SCHOOL,
    Safety_Icon,
    Family_Involvement_Icon,
    Environment_Icon,
    Instruction_Icon,
    Leaders_Icon,
    Teachers_Icon
FROM chicago_public_schools;
SELECT *
FROM chicago_school_safety;
SELECT School_Name,
    Leaders_Rating
FROM chicago_school_safety;
ALTER TABLE chicago_public_schools
MODIFY COLUMN Leaders_Icon varchar(11);
-- STORED PROCEDURE Section
-- QUESTION 1 
-- Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer.
DROP PROCEDURE IF EXISTS UPDATE_LEADERS_SCORE;
DELIMITER // CREATE PROCEDURE UPDATE_LEADERS_SCORE (
    IN in_School_ID int,
    IN in_Leader_Score int,
    OUT out_Leaders_Icon varchar(11)
) BEGIN IF in_Leader_Score >= 80 THEN
SET out_Leaders_Icon = "Very strong";
ELSEIF in_Leader_Score >= 60 THEN
SET out_Leaders_Icon = "Strong";
ELSEIF in_Leader_Score >= 40 THEN
SET out_Leaders_Icon = "Average";
ELSEIF in_Leader_Score >= 20 THEN
SET out_Leaders_Icon = "Weak";
ELSE
SET out_Leaders_Icon = "Very weak";
END IF;
UPDATE chicago_public_schools
SET Leaders_Score = in_Leader_Score,
    Leaders_Icon = out_Leaders_Icon
WHERE School_ID = in_School_ID;
END // DELIMITER;
CALL UPDATE_LEADERS_SCORE(610038, 50, @icon);
DELIMITER // CREATE PROCEDURE UPDATE_LEADERS_SCORE_ALT (
    IN in_School_ID int,
    IN in_Leader_Score int,
) BEGIN IF in_Leader_Score >= 80 THEN
UPDATE chicago_public_schools
SET Leaders_Icon = "Very strong"
WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score >= 60 THEN
UPDATE chicago_public_schools
SET Leaders_Icon = "Strong"
WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score >= 40 THEN
UPDATE chicago_public_schools
SET Leaders_Icon = "Average"
WHERE School_ID = in_School_ID;
ELSEIF in_Leader_Score >= 20 THEN
UPDATE chicago_public_schools
SET Leaders_Icon = "Weak"
WHERE School_ID = in_School_ID;
ELSE
UPDATE chicago_public_schools
SET Leaders_Icon = "Very weak"
WHERE School_ID = in_School_ID;
END IF;
UPDATE chicago_public_schools
SET Leaders_Score = in_Leader_Score
WHERE School_ID = in_School_ID;
END // DELIMITER;
CALL `SQL_FINAL`.`UPDATE_LEADSCORE_NEW`(610038, 82);