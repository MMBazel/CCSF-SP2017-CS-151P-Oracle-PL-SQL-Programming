set echo on
set feedback 1
set pagesize 999
set trimspool on
set linesize 200
set tab off
clear columns
set serveroutput on

/*  Mikiko Bazeley */

/*  TASK 00 */
select user, sysdate 
from dual;

/*  TASK 01 */

ACCEPT weather PROMPT 'What is the weather today? 1: Sunny, 2: Rainy, 3: Snowy. Please enter your selection:  '
DECLARE
  weatherAdvice VARCHAR2(50);
  weather NUMBER(1) := &weather;
BEGIN
weatherAdvice := 
  CASE weather
  WHEN 1 THEN 'Remember your sunglasses!' 
  WHEN 2 THEN 'Remember your umbrella'
  WHEN 3 THEN 'Remember your hat'
  ELSE 'Invalid weather' 
  END;

DBMS_OUTPUT.PUT_LINE(weatherAdvice);
END;

/


/*  TASK 02 */

ACCEPT employeeID PROMPT 'Please enter the employee ID to update salary:  '
DECLARE
  employeeID emp_employees.emp_id%TYPE := &employeeID;
  empSalary emp_employees.salary%TYPE := 0;
  jobTitle emp_jobs.job_title%TYPE :='';
BEGIN
  SELECT ej.job_title, ee.salary
    INTO jobTitle, empSalary
    FROM emp_employees ee 
    JOIN emp_jobs ej USING(job_id)
    WHERE ee.emp_id=employeeID;
  DBMS_OUTPUT.PUT_LINE('The original salary is: $'|| TO_CHAR(empSalary));   
  IF jobTitle = 'President'
    THEN empSalary := empSalary*1.10;
    ELSIF jobTitle='Sales Manager'
      THEN empSalary := empSalary*1.15;
    ELSIF jobTitle='Sales Rep'
      THEN empSalary := empSalary*1.20;
    ELSE empSalary := empSalary;
      END IF;
  UPDATE emp_employees
    SET salary = empSalary
    WHERE emp_id = employeeID;
  DBMS_OUTPUT.PUT_LINE('The new salary is: $'|| TO_CHAR(empSalary));
END;

/

/*  TASK 03 */

ACCEPT square PROMPT 'Enter a positive integer less than or equal 20:  '
DECLARE
  top NUMBER(2) := &square;
  counter NUMBER(2) := 1;
BEGIN
  IF top>20 THEN
    DBMS_OUTPUT.PUT_LINE('Invalid Number');
  ELSE 
    LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(counter) || ' squared = '|| counter * counter);
        counter := counter+1;
        EXIT WHEN counter = top+1;
    END LOOP;     
END IF;
END;
/



/*  TASK 04 */


ACCEPT future PROMPT 'Please enter the year you would like to travel to:  '
DECLARE
  future NUMBER(6) := &future;
  diff NUMBER(6) := 0;
BEGIN
  diff := future - (EXTRACT(YEAR FROM SYSDATE));
  DBMS_OUTPUT.PUT_LINE('This will be '||TO_CHAR(diff)||' years in the future.');
  FOR i IN REVERSE 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE (TO_CHAR(i));
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('The year is now '|| TO_CHAR(future));  
END;

/

