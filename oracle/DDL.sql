CREATE TABLE owner (
    owner_ID NUMBER NOT NULL,
    first_name NVARCHAR2(50) NOT NULL,
    last_name NVARCHAR2(50) NOT NULL,
    address NVARCHAR2(200) NOT NULL,
    phone_number NVARCHAR2(20) NOT NULL,
    email NVARCHAR2(100) NOT NULL,
    CONSTRAINT owner_pk PRIMARY KEY (owner_ID)
);

CREATE TABLE animal (
    animal_ID NUMBER NOT NULL,
    owner_ID NUMBER NOT NULL,
    name NVARCHAR2(50) NOT NULL,
    species NVARCHAR2(50) NOT NULL,
    breed NVARCHAR2(50) NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) NOT NULL,
    is_sterilized NUMBER(1) NOT NULL,
    CONSTRAINT animal_pk PRIMARY KEY (animal_ID),
    CONSTRAINT animal_gender_check CHECK (gender IN ('M', 'F')),
    CONSTRAINT animal_sterilized_check CHECK (is_sterilized IN (0, 1))
);

CREATE TABLE doctor (
    doctor_ID NUMBER NOT NULL,
    first_name NVARCHAR2(50) NOT NULL,
    last_name NVARCHAR2(50) NOT NULL,
    specialization NVARCHAR2(100) NOT NULL,
    CONSTRAINT doctor_pk PRIMARY KEY (doctor_ID)
);

CREATE TABLE medicine (
    medicine_ID NUMBER NOT NULL,
    name NVARCHAR2(100) NOT NULL,
    description NVARCHAR2(300) NOT NULL,
    dosage NVARCHAR2(50) NOT NULL,
    CONSTRAINT medicine_pk PRIMARY KEY (medicine_ID)
);

CREATE TABLE medicine_batch (
    medicine_batch_ID NUMBER NOT NULL,
    medicine_ID NUMBER NOT NULL,
    stock_quantity NUMBER NOT NULL,
    expiry_date DATE NOT NULL,
    CONSTRAINT medicine_batch_pk PRIMARY KEY (medicine_batch_ID),
    CONSTRAINT medicine_batch_stock_check CHECK (stock_quantity >= 0)
);

CREATE TABLE procedure_table (
    procedure_ID NUMBER NOT NULL,
    code CHAR(2) NOT NULL,
    name NVARCHAR2(100) NOT NULL,
    description NVARCHAR2(300) NOT NULL,
    cost NUMBER(10,2) NOT NULL,
    CONSTRAINT procedure_pk PRIMARY KEY (procedure_ID),
    CONSTRAINT procedure_cost_check CHECK (cost >= 0)
);

CREATE TABLE visit (
    visit_ID NUMBER NOT NULL,
    animal_ID NUMBER NOT NULL,
    doctor_ID NUMBER NOT NULL,
    visit_date DATE NOT NULL,
    visit_time TIMESTAMP NOT NULL,
    CONSTRAINT visit_pk PRIMARY KEY (visit_ID)
);

CREATE TABLE visit_procedure (
     visit_procedure_ID NUMBER NOT NULL,
     visit_ID NUMBER NOT NULL,
     procedure_ID NUMBER NOT NULL,
     CONSTRAINT visit_procedure_pk PRIMARY KEY (visit_procedure_ID)
);

CREATE TABLE visit_procedure_medicine (
      visit_procedure_medicine_ID NUMBER NOT NULL,
      visit_procedure_ID NUMBER NOT NULL,
      medicine_batch_ID NUMBER NOT NULL,
      CONSTRAINT visit_procedure_medicine_pk PRIMARY KEY (visit_procedure_medicine_ID)
);


ALTER TABLE animal ADD CONSTRAINT animal_owner_fk
    FOREIGN KEY (owner_ID) REFERENCES owner (owner_ID);

ALTER TABLE medicine_batch ADD CONSTRAINT medicine_batch_medicine_fk
    FOREIGN KEY (medicine_ID) REFERENCES medicine (medicine_ID);

ALTER TABLE visit ADD CONSTRAINT visit_animal_fk
    FOREIGN KEY (animal_ID) REFERENCES animal (animal_ID);

ALTER TABLE visit ADD CONSTRAINT visit_doctor_fk
    FOREIGN KEY (doctor_ID) REFERENCES doctor (doctor_ID);

ALTER TABLE visit_procedure ADD CONSTRAINT visit_procedure_visit_fk
    FOREIGN KEY (visit_ID) REFERENCES visit (visit_ID);

ALTER TABLE visit_procedure ADD CONSTRAINT visit_procedure_procedure_fk
    FOREIGN KEY (procedure_ID) REFERENCES procedure_table (procedure_ID);

ALTER TABLE visit_procedure_medicine ADD CONSTRAINT vpm_visit_procedure_fk
    FOREIGN KEY (visit_procedure_ID) REFERENCES visit_procedure (visit_procedure_ID);

ALTER TABLE visit_procedure_medicine ADD CONSTRAINT vpm_medicine_batch_fk
    FOREIGN KEY (medicine_batch_ID) REFERENCES medicine_batch (medicine_batch_ID);


CREATE SEQUENCE seq_owner START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_animal START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_doctor START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medicine START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medicine_batch START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_procedure START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_visit START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_visit_procedure START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_visit_procedure_medicine START WITH 1 INCREMENT BY 1;