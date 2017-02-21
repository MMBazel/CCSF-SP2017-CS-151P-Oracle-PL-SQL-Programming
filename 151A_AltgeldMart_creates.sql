-- AltgeldMart Oracle 151A

-- clean up previous tables


drop table oe_orderDetails;
drop table oe_orderHeaders;
drop table oe_shippingModes;
drop table cust_customers;

drop table prd_products;
drop table prd_categories;

drop table emp_employees;
drop table emp_jobs;
drop table emp_departments;
drop table emp_locations;


create table  emp_locations(
    loc_id              integer       not null  
  , loc_postal_code     varchar2(12)  not null
  , loc_street_address  varchar2(25)  not null
  , loc_city            varchar2(25)  not null
  , loc_state_province  varchar2(25)  not null
  , loc_country_id      char(2)       not null
  , loc_type            varchar2(25)  null
  , constraint loc_pk                 primary key(loc_id)
  , constraint loc_id_range           check(loc_id >= 1000)
);


create table emp_departments(
    dept_id            integer        not null  
  , dept_name          varchar2(50)   not null
  , loc_id             integer        null
  , constraint dept_pk                primary key(dept_id)
  , constraint dept_loc_fk            foreign key (loc_id) references emp_locations
  , constraint dept_id_range          check(dept_id >= 0)
);

create table emp_jobs(
    job_id          integer           not null  
  , job_title       varchar2(50)      not null
  , min_salary      number (8,2)      null
  , max_salary      number (8,2)      null
  , constraint jobs_pk                primary key(job_id)
  , constraint job_id_range           check(job_id > 0)
  , constraint min_salary_range       check (min_salary >= 0)
  , constraint max_salary_range       check (max_salary >= 0) 
);



create table emp_employees(
    emp_id          integer           not null  
  , name_last       varchar2(25)      not null
  , name_first      varchar2(25)      null
  , ssn             char(9)           not null  
  , emp_mng         integer           null
  , dept_id         integer           not null
  , hire_date       date              not null
  , salary          number (8, 2)     null
  , job_id          integer           not null
  , constraint emp_pk                 primary key(emp_id)
  , constraint dept_emp_fk            foreign key (dept_id)       references emp_departments
  , constraint mng_emp_fk             foreign key (emp_mng)       references emp_employees(emp_id)
  , constraint job_emp_fk             foreign key (job_id)        references emp_jobs
  , constraint emp_id_range           check (emp_id >= 100) 
  , constraint emp_ssn_un             unique(ssn)
  , constraint hire_date_range        check(hire_date >= date '1950-01-01')
  , constraint hire_date_ck           check(trunc(hire_date) = hire_date)
  , constraint salary_range           check (salary >= 0)
 );


-- Products

create table prd_categories(
    catg_id         varchar2(6)       not null  
  , catg_desc       varchar2(25)      not null  
  , constraint catg_pk                primary key(catg_id)
  , constraint catg_dec_un            unique(catg_desc)
);

create table prd_products(
    prod_id         integer           not null  
  , prod_name       varchar2(25)      not null
  , prod_desc       varchar2(50)      null
  , prod_list_price number(6,2)       not null
  , catg_id         varchar2(6)       not null
  , constraint prod_pk                primary key (prod_id)
  , constraint prod_catg_fk           foreign key (catg_id)       references prd_categories
  , constraint prod_id_range          check (prod_id >= 100) 
  , constraint list_price_range       check (prod_list_price >= 0) 
);


create table cust_customers(
    customer_id         integer           not null  
  , customer_name_last  varchar2(25)      not null
  , customer_name_first varchar2(25)      null
  , customer_credit_limit    integer           null
  , constraint credit_limit_range     check(customer_credit_limit > 0)
  , constraint cust_pk                primary key(customer_id)
  , constraint cust_id_range          check (customer_id >= 100000)
);


create table oe_shippingModes (
    shipping_mode_id   char(6)        not null 
  , shipping_mode_desc varchar2(25)   not null 
  , constraint shp_mode_pk            primary key (shipping_mode_id)
  , constraint shp_desc_un            unique (shipping_mode_desc)
  );

create table oe_orderHeaders(
    order_id           integer          not null 
  , order_date         date             not null
  , customer_id          integer          not null 
  , order_mode         varchar2(25)     not null
  , shipping_mode_id    char(6)          null
  , order_status       integer          not null
  , sales_rep_id     integer          null
  , constraint ord_pk                 primary key (order_id)
  , constraint shp_mode_fk            foreign key (shipping_mode_id) references oe_shippingModes
  , constraint ord_cust_fk            foreign key (customer_id)       references cust_customers
  , constraint ord_sales_rep_fk       foreign key (sales_rep_id)  references emp_employees
  , constraint ord_status_range       check (order_status between 1 and 9)
  , constraint ord_mode_values        check (order_mode in ('PHONE','ONLINE','DIRECT'))
  , constraint ord_date_range         check(order_date >=  date '1950-01-01')
  , constraint ord_date_only          check(order_date = trunc(order_date))
  , constraint ord_id_range           check(order_id > 0)
);

create table oe_orderDetails(
    order_id           integer          not null
  , line_item_id     integer          not null
  , prod_id          integer          not null
  , quantity_ordered integer          not null
  , quoted_price     number (6,2)     not null 
  , constraint ord_details_pk         primary key(order_id, line_item_id)
  , constraint ord_ord_fk             foreign key (order_id)  references oe_orderHeaders
  , constraint ord_prod_fk            foreign key (prod_id)   references prd_products
  , constraint ord_price_range        check (quoted_price  >= 0)
  , constraint line_item_id_range     check (line_item_id > 0)
  , constraint ord_quant_range        check (quantity_ordered  >= 0)
);

 
commit;
