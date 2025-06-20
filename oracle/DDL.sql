CREATE TABLE animal (
    animal_ID integer  NOT NULL,
    owner_ID integer  NOT NULL,
    name varchar2(50)  NOT NULL,
    species varchar2(50)  NOT NULL,
    breed varchar2(50)  NULL,
    birth_date date  NOT NULL,
    gender char(1)  NOT NULL,
    is_sterilized smallint  NOT NULL,
    CONSTRAINT animal_pk PRIMARY KEY (animal_ID)
) ;

CREATE TABLE doctor (
    doctor_ID integer  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    specialization varchar2(100)  NOT NULL,
    CONSTRAINT doctor_pk PRIMARY KEY (doctor_ID)
) ;

CREATE TABLE medicine (
    medicine_ID integer  NOT NULL,
    name varchar2(100)  NOT NULL,
    description varchar2(300)  NOT NULL,
    dosage varchar2(50)  NOT NULL,
    CONSTRAINT medicine_pk PRIMARY KEY (medicine_ID)
) ;

CREATE TABLE medicine_batch (
    medicine_batch_ID integer  NOT NULL,
    medicine_ID integer  NOT NULL,
    stock_quantity integer  NOT NULL,
    expiry_date date  NOT NULL,
    CONSTRAINT medicine_batch_pk PRIMARY KEY (medicine_batch_ID)
) ;

CREATE TABLE owner (
    owner_ID integer  NOT NULL,
    first_name varchar2(50)  NOT NULL,
    last_name varchar2(50)  NOT NULL,
    address varchar2(200)  NOT NULL,
    phone_number varchar2(20)  NOT NULL,
    email varchar2(100)  NOT NULL,
    CONSTRAINT owner_pk PRIMARY KEY (owner_ID)
) ;

CREATE TABLE procedure (
    procedure_ID integer  NOT NULL,
    code char(2)  NOT NULL,
    name varchar2(100)  NOT NULL,
    description varchar2(300)  NOT NULL,
    cost number(10,2)  NOT NULL,
    CONSTRAINT procedure_pk PRIMARY KEY (procedure_ID)
) ;

CREATE TABLE visit (
    visit_ID integer  NOT NULL,
    animal_ID integer  NOT NULL,
    doctor_ID integer  NOT NULL,
    visit_date date  NOT NULL,
    visit_time timestamp  NOT NULL,
    CONSTRAINT visit_pk PRIMARY KEY (visit_ID)
) ;

CREATE TABLE visit_procedure (
    visit_procedure_ID integer  NOT NULL,
    visit_ID integer  NOT NULL,
    procedure_ID integer  NOT NULL,
    CONSTRAINT visit_procedure_pk PRIMARY KEY (visit_procedure_ID)
) ;

CREATE TABLE visit_procedure_medicine (
    visit_procedure_medicine_ID integer  NOT NULL,
    visit_procedure_ID integer  NOT NULL,
    medicine_batch_ID integer  NOT NULL,
    CONSTRAINT visit_procedure_medicine_pk PRIMARY KEY (visit_procedure_medicine_ID)
) ;

ALTER TABLE animal ADD CONSTRAINT animal_owner
    FOREIGN KEY (owner_ID)
    REFERENCES owner (owner_ID);

ALTER TABLE medicine_batch ADD CONSTRAINT medicine_batch_medicine
    FOREIGN KEY (medicine_ID)
    REFERENCES medicine (medicine_ID);

ALTER TABLE visit_procedure_medicine ADD CONSTRAINT v_p_m_m_b
    FOREIGN KEY (medicine_batch_ID)
    REFERENCES medicine_batch (medicine_batch_ID);

ALTER TABLE visit_procedure_medicine ADD CONSTRAINT v_p_m_v_p
    FOREIGN KEY (visit_procedure_ID)
    REFERENCES visit_procedure (visit_procedure_ID);

ALTER TABLE visit ADD CONSTRAINT visit_animal
    FOREIGN KEY (animal_ID)
    REFERENCES animal (animal_ID);

ALTER TABLE visit ADD CONSTRAINT visit_doctor
    FOREIGN KEY (doctor_ID)
    REFERENCES doctor (doctor_ID);

ALTER TABLE visit_procedure ADD CONSTRAINT visit_procedure_procedure
    FOREIGN KEY (procedure_ID)
    REFERENCES procedure (procedure_ID);

ALTER TABLE visit_procedure ADD CONSTRAINT visit_procedure_visit
    FOREIGN KEY (visit_ID)
    REFERENCES visit (visit_ID);