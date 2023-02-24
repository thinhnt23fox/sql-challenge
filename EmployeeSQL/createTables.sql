------------------- 1. Create Database: han -------------------
DROP DATABASE IF EXISTS han;
CREATE DATABASE han
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

------------------- 2. Create schema: company -------------------
CREATE SCHEMA IF NOT EXISTS company
    AUTHORIZATION postgres;

------------------- 3. Create table: departments -------------------

DROP TABLE IF EXISTS company.departments;
CREATE TABLE IF NOT EXISTS company.departments
(
    dept_no character varying(6) COLLATE pg_catalog."default" NOT NULL,
    dept_name character varying(45) COLLATE pg_catalog."default",
    CONSTRAINT departments_pkey PRIMARY KEY (dept_no)
);

------------------- 4. Create table: dept_emp -------------------
DROP TABLE IF EXISTS company.dept_emp;
CREATE TABLE IF NOT EXISTS company.dept_emp
(
    emp_no integer NOT NULL,
    dept_no character varying(6) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT dept_emp_pkey PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT dept_no FOREIGN KEY (dept_no)
        REFERENCES company.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT emp_no FOREIGN KEY (emp_no)
        REFERENCES company.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- TABLESPACE pg_default;
-- ALTER TABLE IF EXISTS company.dept_emp OWNER to postgres;

------------------- 5. Create table: dept_manager --------------------- 
DROP TABLE IF EXISTS company.dept_manager;
CREATE TABLE IF NOT EXISTS company.dept_manager
(
    dept_no character varying(45) COLLATE pg_catalog."default" NOT NULL,
    emp_no integer NOT NULL,
    CONSTRAINT dept_manager_pkey PRIMARY KEY (dept_no, emp_no),
    CONSTRAINT dept_no FOREIGN KEY (dept_no)
        REFERENCES company.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT emp_no FOREIGN KEY (emp_no)
        REFERENCES company.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- TABLESPACE pg_default;
-- ALTER TABLE IF EXISTS company.dept_manager OWNER to postgres;

------------------- 6. Create table: employees --------------------- 
DROP TABLE IF EXISTS company.employees;
CREATE TABLE IF NOT EXISTS company.employees
(
    emp_no integer NOT NULL,
    emp_title_id character varying(20) COLLATE pg_catalog."default",
    birth_date date,
    first_name character varying(20) COLLATE pg_catalog."default",
    last_name character varying(20) COLLATE pg_catalog."default",
    sex character(1) COLLATE pg_catalog."default",
    hire_date date,
    CONSTRAINT employees_pkey PRIMARY KEY (emp_no),
    CONSTRAINT emp_title_id FOREIGN KEY (emp_title_id)
        REFERENCES company.titles (title_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- TABLESPACE pg_default;
-- ALTER TABLE IF EXISTS company.employees OWNER to postgres;

------------------- 7. Create table: salaries --------------------- 
DROP TABLE IF EXISTS company.salaries;
CREATE TABLE IF NOT EXISTS company.salaries
(
    emp_no integer NOT NULL,
    salarych numeric(15,2),
    CONSTRAINT salaries_pkey PRIMARY KEY (emp_no),
    CONSTRAINT emp_no FOREIGN KEY (emp_no)
        REFERENCES company.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- TABLESPACE pg_default;
-- ALTER TABLE IF EXISTS company.salaries OWNER to postgres;

------------------- 8. Create table: titles --------------------- 
DROP TABLE IF EXISTS company.titles;
CREATE TABLE IF NOT EXISTS company.titles
(
    title_id character varying(6) COLLATE pg_catalog."default" NOT NULL,
    title character varying(45) COLLATE pg_catalog."default",
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
);

-- TABLESPACE pg_default;
-- ALTER TABLE IF EXISTS company.titles OWNER to postgres;
