USE [2019SBD];

CREATE TABLE owner (
    owner_ID int NOT NULL IDENTITY(1,1),
    first_name nvarchar(50) NOT NULL,
    last_name nvarchar(50) NOT NULL,
    address nvarchar(200) NOT NULL,
    phone_number nvarchar(20) NOT NULL,
    email nvarchar(100) NOT NULL,
    CONSTRAINT owner_pk PRIMARY KEY (owner_ID)
);

CREATE TABLE animal (
    animal_ID int NOT NULL IDENTITY(1,1),
    owner_ID int NOT NULL,
    name nvarchar(50) NOT NULL,
    species nvarchar(50) NOT NULL,
    breed nvarchar(50) NULL,
    birth_date date NOT NULL,
    gender char(1) NOT NULL,
    is_sterilized tinyint NOT NULL,
    CONSTRAINT animal_pk PRIMARY KEY (animal_ID),
    CONSTRAINT animal_gender_check CHECK (gender IN ('M', 'F')),
    CONSTRAINT animal_sterilized_check CHECK (is_sterilized IN (0, 1))
);

CREATE TABLE doctor (
    doctor_ID int NOT NULL IDENTITY(1,1),
    first_name nvarchar(50) NOT NULL,
    last_name nvarchar(50) NOT NULL,
    specialization nvarchar(100) NOT NULL,
    CONSTRAINT doctor_pk PRIMARY KEY (doctor_ID)
);

CREATE TABLE medicine (
    medicine_ID int NOT NULL IDENTITY(1,1),
    name nvarchar(100) NOT NULL,
    description nvarchar(300) NOT NULL,
    dosage nvarchar(50) NOT NULL,
    CONSTRAINT medicine_pk PRIMARY KEY (medicine_ID)
);

CREATE TABLE medicine_batch (
    medicine_batch_ID int NOT NULL IDENTITY(1,1),
    medicine_ID int NOT NULL,
    stock_quantity int NOT NULL,
    expiry_date date NOT NULL,
    CONSTRAINT medicine_batch_pk PRIMARY KEY (medicine_batch_ID),
    CONSTRAINT medicine_batch_stock_check CHECK (stock_quantity >= 0)
);

CREATE TABLE [procedure] (
    procedure_ID int NOT NULL IDENTITY(1,1),
    code char(2) NOT NULL,
    name nvarchar(100) NOT NULL,
    description nvarchar(300) NOT NULL,
    cost decimal(10,2) NOT NULL,
    CONSTRAINT procedure_pk PRIMARY KEY (procedure_ID),
    CONSTRAINT procedure_cost_check CHECK (cost >= 0)
);

CREATE TABLE visit (
    visit_ID int NOT NULL IDENTITY(1,1),
    animal_ID int NOT NULL,
    doctor_ID int NOT NULL,
    visit_date date NOT NULL,
    visit_time datetime2 NOT NULL,
    CONSTRAINT visit_pk PRIMARY KEY (visit_ID)
);

CREATE TABLE visit_procedure (
    visit_procedure_ID int NOT NULL IDENTITY(1,1),
    visit_ID int NOT NULL,
    procedure_ID int NOT NULL,
    CONSTRAINT visit_procedure_pk PRIMARY KEY (visit_procedure_ID)
);

CREATE TABLE visit_procedure_medicine (
    visit_procedure_medicine_ID int NOT NULL IDENTITY(1,1),
    visit_procedure_ID int NOT NULL,
    medicine_batch_ID int NOT NULL,
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
    FOREIGN KEY (procedure_ID) REFERENCES [procedure] (procedure_ID);

ALTER TABLE visit_procedure_medicine ADD CONSTRAINT vpm_visit_procedure_fk
    FOREIGN KEY (visit_procedure_ID) REFERENCES visit_procedure (visit_procedure_ID);

ALTER TABLE visit_procedure_medicine ADD CONSTRAINT vpm_medicine_batch_fk
    FOREIGN KEY (medicine_batch_ID) REFERENCES medicine_batch (medicine_batch_ID);