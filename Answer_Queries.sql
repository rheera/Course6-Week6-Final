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