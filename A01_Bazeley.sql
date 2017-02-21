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
BEGIN

    DBMS_OUTPUT.PUT_LINE('Hello World!');

END;

/


/*  TASK 02  */

DECLARE
  magicNumber NUMBER :=1;
  todaysDate DATE := SYSDATE;
  letter CHAR(1) :='A';
BEGIN
  DBMS_OUTPUT.put_line(magicNumber);
   DBMS_OUTPUT.put_line(todaysDate);
    DBMS_OUTPUT.put_line(letter);
 magicNumber:=magicNumber+1;
todaysDate:=todaysDate+1;
    letter:='B';
 DBMS_OUTPUT.put_line(magicNumber);
DBMS_OUTPUT.put_line(todaysDate);
    DBMS_OUTPUT.put_line(letter);
END;

/

/*  TASK 03 */

ACCEPT ticketGuess PROMPT 'Please Enter Number of Tickets to Purchase:'

DECLARE 
  maxCapacity INT :=41159;
  ticketNo int :=&ticketGuess;
  remainderTickets int;
BEGIN 
  remainderTickets := maxCapacity - ticketNo;
  DBMS_OUTPUT.put_line('No. of tickets left:  ' || TO_CHAR(remainderTickets));
END;

/


@ \myScripts\151A_AltgeldMart_creates.sql;
@ \myScripts\151A_AltgeldMart_inserts.sql;

/*  TASK 04 */
VARIABLE result NUMBER
BEGIN
  SELECT salary into :result
  FROM emp_employees
  WHERE emp_id=145;
  DBMS_OUTPUT.put_line(:result);
END;

/


/*  TASK 05 */

ACCEPT custNo PROMPT 'Please Enter Customer ID:'

DECLARE 
  customerNo INT :=&custNo;
  creditLimit NUMBER;
BEGIN 
  SELECT customer_credit_limit into creditLimit
  FROM cust_customers
  WHERE customer_id=customerNo;
  DBMS_OUTPUT.put_line('The credit limit is: ' || creditLimit);
  
END;

/

