USE [2019SBD];

CREATE TABLE owner (
    owner_ID INT NOT NULL IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    address NVARCHAR(200) NOT NULL,
    phone_number NVARCHAR(20) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    CONSTRAINT owner_pk PRIMARY KEY (owner_ID)
);

CREATE TABLE animal (
    animal_ID INT NOT NULL IDENTITY(1,1),
    owner_ID INT NOT NULL,
    name NVARCHAR(50) NOT NULL,
    species NVARCHAR(50) NOT NULL,
    breed NVARCHAR(50) NULL,
    birth_date DATE NOT NULL,
    gender CHAR(1) NOT NULL,
    is_sterilized TINYINT NOT NULL,
    CONSTRAINT animal_pk PRIMARY KEY (animal_ID),
    CONSTRAINT animal_gender_check CHECK (gender IN ('M', 'F')),
    CONSTRAINT animal_sterilized_check CHECK (is_sterilized IN (0, 1))
);

CREATE TABLE doctor (
    doctor_ID INT NOT NULL IDENTITY(1,1),
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    specialization NVARCHAR(100) NOT NULL,
    CONSTRAINT doctor_pk PRIMARY KEY (doctor_ID)
);

CREATE TABLE medicine (
    medicine_ID INT NOT NULL IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(300) NOT NULL,
    dosage NVARCHAR(50) NOT NULL,
    CONSTRAINT medicine_pk PRIMARY KEY (medicine_ID)
);

CREATE TABLE medicine_batch (
    medicine_batch_ID INT NOT NULL IDENTITY(1,1),
    medicine_ID INT NOT NULL,
    stock_quantity INT NOT NULL,
    expiry_date DATE NOT NULL,
    CONSTRAINT medicine_batch_pk PRIMARY KEY (medicine_batch_ID),
    CONSTRAINT medicine_batch_stock_check CHECK (stock_quantity >= 0)
);

CREATE TABLE [procedure] (
    procedure_ID INT NOT NULL IDENTITY(1,1),
    code CHAR(2) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(300) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    CONSTRAINT procedure_pk PRIMARY KEY (procedure_ID),
    CONSTRAINT procedure_cost_check CHECK (cost >= 0)
    );

CREATE TABLE visit (
    visit_ID INT NOT NULL IDENTITY(1,1),
    animal_ID INT NOT NULL,
    doctor_ID INT NOT NULL,
    visit_date DATE NOT NULL,
    visit_time DATETIME2 NOT NULL,
    CONSTRAINT visit_pk PRIMARY KEY (visit_ID)
);

CREATE TABLE visit_procedure (
     visit_procedure_ID INT NOT NULL IDENTITY(1,1),
     visit_ID INT NOT NULL,
     procedure_ID INT NOT NULL,
     CONSTRAINT visit_procedure_pk PRIMARY KEY (visit_procedure_ID)
);

CREATE TABLE visit_procedure_medicine (
      visit_procedure_medicine_ID INT NOT NULL IDENTITY(1,1),
      visit_procedure_ID INT NOT NULL,
      medicine_batch_ID INT NOT NULL,
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