INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Anna', 'Kowalska', 'Warszawa, ul. Główna 10', '123456789', 'anna.kowalska@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Jan', 'Nowak', 'Kraków, ul. Zielona 5', '987654321', 'jan.nowak@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Maria', 'Wiśniewska', 'Gdańsk, ul. Morze 15', '456789123', 'maria.wisniewska@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Tomasz', 'Kaczmarek', 'Poznań, ul. Polna 25', '111222333', 'tomasz.kaczmarek@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Ewa', 'Szymczak', 'Warszawa, ul. Słoneczna 3', '999888777', 'ewa.szymczak@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Agnieszka', 'Lis', 'Katowice, ul. Ogrodowa 7', '222333444', 'agnieszka.lis@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(seq_owner.NEXTVAL, 'Marek', 'Czarnecki', 'Lublin, ul. Lubelska 8', '555666777', 'marek.czarnecki@gmail.com');

INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 1, 'Burek', 'Dog', 'Golden Retriever', DATE '2018-03-12', 'M', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 2, 'Puszek', 'Cat', 'Persian', DATE '2020-07-25', 'F', 0);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 3, 'Max', 'Dog', 'Beagle', DATE '2019-06-14', 'M', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 1, 'Luna', 'Cat', 'Siamese', DATE '2021-01-20', 'F', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 4, 'Reks', 'Dog', 'Labrador', DATE '2017-09-30', 'M', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 1, 'Bella', 'Rabbit', 'Holland Lop', DATE '2022-04-10', 'F', 0);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 5, 'Czarek', 'Dog', 'Poodle', DATE '2016-05-15', 'M', 0);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 6, 'Kicia', 'Cat', 'Maine Coon', DATE '2019-12-18', 'F', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 7, 'Fela', 'Parrot', 'Macaw', DATE '2020-02-22', 'F', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(seq_animal.NEXTVAL, 7, 'Leo', 'Dog', 'Doberman', DATE '2021-09-10', 'M', 0);

INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Agnieszka', 'Kwiatkowska', 'Surgery');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Tomasz', 'Zieliński', 'Surgery');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Joanna', 'Majewska', 'Dentistry');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Piotr', 'Lewandowski', 'Radiology');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Magdalena', 'Sobczak', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Marek', 'Wiśniewski', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Ewa', 'Kamińska', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Jan', 'Szymczak', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Maria', 'Kowal', 'Cardiology');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(seq_doctor.NEXTVAL, 'Adam', 'Zając', 'Cardiology');

INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Antibiotic A', 'Antibiotic for bacterial infections', '500mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Painkiller B', 'Pain relief medication', '50mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Vaccine C', 'Preventive vaccine for dogs', '1 dose');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Antifungal D', 'Antifungal treatment for skin infections', '250mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Sedative E', 'Mild sedative for stress relief', '10mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Vitamin F', 'Multivitamin supplement', '1 tablet');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Dewormer G', 'Deworming medicine for pets', '2 doses');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Anti-inflammatory H', 'Anti-inflammatory for joint pain', '100mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Antiseptic I', 'Topical antiseptic solution', '50ml');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(seq_medicine.NEXTVAL, 'Energy Booster J', 'Energy supplement for active pets', '1 dose');

INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 1, 100, DATE '2026-12-31');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 2, 200, DATE '2025-06-30');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 3, 50, DATE '2025-01-01');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 4, 75, DATE '2025-08-15');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 5, 30, DATE '2024-11-01');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 6, 120, DATE '2025-03-31');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 7, 80, DATE '2025-09-30');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 8, 60, DATE '2024-07-15');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 9, 90, DATE '2026-02-01');
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(seq_medicine_batch.NEXTVAL, 10, 40, DATE '2024-05-20');

INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'S', 'Surgery', 'General surgical procedure', 500.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'V', 'Vaccination', 'Routine vaccination', 100.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'D', 'Deworming', 'Treatment to remove internal parasites', 80.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'X', 'X-ray', 'Diagnostic imaging procedure', 300.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'DC', 'Dental Check-Up', 'Routine dental examination for pets', 150.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'BT', 'Blood Test', 'Comprehensive blood analysis', 120.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'EC', 'Ear Cleaning', 'Routine ear hygiene procedure', 60.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'ST', 'Sterilization', 'Surgical sterilization procedure', 250.00);
INSERT INTO procedure_table (procedure_ID, code, name, description, cost) VALUES
(seq_procedure.NEXTVAL, 'T', 'Tomography', 'Diagnostic imaging procedure', 700.00);

INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 3, 2, DATE '2023-12-01', TIMESTAMP '2023-12-01 10:30:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 5, 4, DATE '2023-12-05', TIMESTAMP '2023-12-05 12:00:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 1, 6, DATE '2023-12-10', TIMESTAMP '2023-12-10 09:45:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 4, 8, DATE '2023-12-15', TIMESTAMP '2023-12-15 14:15:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 2, 3, DATE '2023-12-20', TIMESTAMP '2023-12-20 13:30:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 7, 5, DATE '2023-12-22', TIMESTAMP '2023-12-22 11:00:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 8, 9, DATE '2023-12-25', TIMESTAMP '2023-12-25 12:15:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 9, 7, DATE '2023-12-28', TIMESTAMP '2023-12-28 10:30:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 10, 1, DATE '2023-12-30', TIMESTAMP '2023-12-30 14:45:00');
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(seq_visit.NEXTVAL, 6, 10, DATE '2024-01-02', TIMESTAMP '2024-01-02 09:15:00');

INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 1, 6);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 2, 7);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 3, 4);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 4, 3);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 5, 8);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 6, 1);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 7, 2);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 8, 9);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 9, 5);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(seq_visit_procedure.NEXTVAL, 10, 9);

INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 1, 4);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 2, 6);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 3, 2);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 4, 1);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 5, 5);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 6, 3);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 7, 7);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 8, 9);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 9, 8);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(seq_visit_procedure_medicine.NEXTVAL, 10, 10);

COMMIT;