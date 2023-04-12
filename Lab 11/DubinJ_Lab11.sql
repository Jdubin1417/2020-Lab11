/* 
Programmer's Name: Justin Dubin
Course: CSCI 2020 Section Number: 940 
Creation Date: 04/14/2022 Date of Last Modification: 04/21/2022
E-mail Address: dubinj@etsu.edu 
Purpose - To pratice functions
Lab 11
Identifier dictionary - 
Not Applicable 
 
Notes and Assumptions ? 
*/
------------------------------------------------------------------
--1A.
CREATE OR REPLACE FUNCTION get_month (date1 DATE)
    RETURN VARCHAR2
    IS
    retChar VARCHAR2(15);
BEGIN
    retChar := TO_CHAR(date1, 'month'); 
    RETURN retChar;
END;

--1B.
SELECT COUNT(get_month(END_DATE)) as Graduation_Count, 
get_month(END_DATE) AS Graduation_Month
FROM ACADEMY_PREP.student
WHERE END_REASON = 'Graduated' 
AND END_DATE >= '01-JAN-07' 
AND END_DATE <= '31-DEC-07' 
group by get_month(END_DATE)
ORDER BY Graduation_Month;

--1C.
SELECT get_month(TEST_DATE) as Month,
a.gender as Gender,
AVG(s.Score) as "Average SAT Score"
FROM ACADEMY_PREP.student_exam s
INNER JOIN ACADEMY_PREP.exam e
ON s.exam_id = e.exam_id
INNER JOIN ACADEMY_PREP.student a
ON s.student_id = a.student_id
WHERE s.exam_id = 1 
AND TEST_DATE >= '01-JAN-10' 
AND TEST_DATE <= '31-DEC-10' 
GROUP BY get_month(TEST_DATE), a.gender 
ORDER BY a.gender;

--2.............................................
DROP TABLE Student_Example;
CREATE TABLE Student_Example (
   Student_ID INTEGER,
   Student_First_Name VARCHAR2(30),
   Student_Last_Name VARCHAR2(30),
   Student_Classification VARCHAR2(2)
);

DROP TABLE Student_Example_Log;
CREATE TABLE Student_Example_Log (
   Student_ID INTEGER,
   Student_First_Name VARCHAR2(30),
   Student_Last_Name VARCHAR2(30),
   Student_Classification VARCHAR2(2),
   Activity_Date DATE,
   Username VARCHAR2(20)
);

--1.


SELECT ten_pct(10) FROM DUAL;

SELECT last_name, salary, ten_pct(salary) AS bonus
FROM hr.employees
WHERE salary<=5000;

--TRIGGERS
--1.
CREATE TRIGGER Trigger_Tester
AFTER INSERT
ON employee
FOR EACH ROW
BEGIN
    INSERT INTO Student_Example (Student_First_Name) VALUES (:NEW.Student_First_Name);
END;

CREATE TRIGGER Trigger_Tester
AFTER INSERT
ON employee
FOR EACH ROW
BEGIN
    INSERT INTO Student_Example (Student_Last_Name) VALUES (:NEW.Student_Last_Name);
END;

CREATE TRIGGER Trigger_Tester
AFTER INSERT
ON employee
FOR EACH ROW
BEGIN
    INSERT INTO Student_Example (Student_Classification_Name) VALUES (:NEW.Student_Classification_Name);
END;