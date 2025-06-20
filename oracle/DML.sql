INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(1, 'Anna', 'Kowalska', 'Warszawa, ul. Glowna 10', '123456789', 'anna.kowalska@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(2, 'Jan', 'Nowak', 'Krakow, ul. Zielona 5', '987654321', 'jan.nowak@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(3, 'Maria', 'Wisniewska', 'Gdansk, ul. Morze 15', '456789123', 'maria.wisniewska@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(4, 'Tomasz', 'Kaczmarek', 'Poznan, ul. Polna 25', '111222333', 'tomasz.kaczmarek@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(5, 'Ewa', 'Szymczak', 'Warszawa, ul. Sloneczna 3', '999888777', 'ewa.szymczak@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(6, 'Agnieszka', 'Lis', 'Katowice, ul. Ogrodowa 7', '222333444', 'agnieszka.lis@gmail.com');
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(7, 'Marek', 'Czarnecki', 'Lublin, ul. Lubelska 8', '555666777', 'marek.czarnecki@gmail.com');

INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(1, 1, 'Burek', 'Dog', 'Golden Retriever', TO_DATE('2018-03-12', 'YYYY-MM-DD'), 'M', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(2, 2, 'Puszek', 'Cat', 'Persian', TO_DATE('2020-07-25', 'YYYY-MM-DD'), 'F', 0);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(3, 3, 'Max', 'Dog', 'Beagle', TO_DATE('2019-06-14', 'YYYY-MM-DD'), 'M', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(4, 1, 'Luna', 'Cat', 'Siamese', TO_DATE('2021-01-20', 'YYYY-MM-DD'), 'F', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(5, 4, 'Reks', 'Dog', 'Labrador', TO_DATE('2017-09-30', 'YYYY-MM-DD'), 'M', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(6, 1, 'Bella', 'Rabbit', 'Holland Lop', TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'F', 0);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(7, 5, 'Czarek', 'Dog', 'Poodle', TO_DATE('2016-05-15', 'YYYY-MM-DD'), 'M', 0);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(8, 6, 'Kicia', 'Cat', 'Maine Coon', TO_DATE('2019-12-18', 'YYYY-MM-DD'), 'F', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(9, 7, 'Fela', 'Parrot', 'Macaw', TO_DATE('2020-02-22', 'YYYY-MM-DD'), 'F', 1);
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(10, 7, 'Leo', 'Dog', 'Doberman', TO_DATE('2021-09-10', 'YYYY-MM-DD'), 'M', 0);

INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(1, 'Agnieszka', 'Kwiatkowska', 'Surgery');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(2, 'Tomasz', 'Zielinski', 'Surgery');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(3, 'Joanna', 'Majewska', 'Dentistry');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(4, 'Piotr', 'Lewandowski', 'Radiology');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(5, 'Magdalena', 'Sobczak', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(6, 'Marek', 'Wisniewski', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(7, 'Ewa', 'Kaminska', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(8, 'Jan', 'Szymczak', 'General Medicine');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(9, 'Maria', 'Kowal', 'Cardiology');
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(10, 'Adam', 'Zajac', 'Cardiology');

INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(1, 'Antibiotic A', 'Antibiotic for bacterial infections', '500mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(2, 'Painkiller B', 'Pain relief medication', '50mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(3, 'Vaccine C', 'Preventive vaccine for dogs', '1 dose');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(4, 'Antifungal D', 'Antifungal treatment for skin infections', '250mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(5, 'Sedative E', 'Mild sedative for stress relief', '10mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(6, 'Vitamin F', 'Multivitamin supplement', '1 tablet');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(7, 'Dewormer G', 'Deworming medicine for pets', '2 doses');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(8, 'Anti-inflammatory H', 'Anti-inflammatory for joint pain', '100mg');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(9, 'Antiseptic I', 'Topical antiseptic solution', '50ml');
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(10, 'Energy Booster J', 'Energy supplement for active pets', '1 dose');

INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(1, 1, 100, TO_DATE('2026-12-31', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(2, 2, 200, TO_DATE('2025-06-30', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(3, 3, 50, TO_DATE('2025-01-01', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(4, 4, 75, TO_DATE('2025-08-15', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(5, 5, 30, TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(6, 6, 120, TO_DATE('2025-03-31', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(7, 7, 80, TO_DATE('2025-09-30', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(8, 8, 60, TO_DATE('2024-07-15', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(9, 9, 90, TO_DATE('2026-02-01', 'YYYY-MM-DD'));
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(10, 10, 40, TO_DATE('2024-05-20', 'YYYY-MM-DD'));

INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(1, 'S', 'Surgery', 'General surgical procedure', 500.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(2, 'V', 'Vaccination', 'Routine vaccination', 100.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(3, 'D', 'Deworming', 'Treatment to remove internal parasites', 80.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(4, 'X', 'X-ray', 'Diagnostic imaging procedure', 300.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(5, 'DC', 'Dental Check-Up', 'Routine dental examination for pets', 150.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(6, 'BT', 'Blood Test', 'Comprehensive blood analysis', 120.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(7, 'EC', 'Ear Cleaning', 'Routine ear hygiene procedure', 60.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(8, 'S', 'Sterilization', 'Surgical sterilization procedure', 250.00);
INSERT INTO procedure (procedure_ID, code, name, description, cost) VALUES
(9, 'T', 'Tomography', 'Diagnostic imaging procedure', 700.00);

INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(1, 3, 2, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-01 10:30', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(2, 5, 4, TO_DATE('2023-12-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-05 12:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(3, 1, 6, TO_DATE('2023-12-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-10 09:45', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(4, 4, 8, TO_DATE('2023-12-15', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-15 14:15', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(5, 2, 3, TO_DATE('2023-12-20', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-20 13:30', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(6, 7, 5, TO_DATE('2023-12-22', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-22 11:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(7, 8, 9, TO_DATE('2023-12-25', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-25 12:15', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(8, 9, 7, TO_DATE('2023-12-28', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-28 10:30', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(9, 10, 1, TO_DATE('2023-12-30', 'YYYY-MM-DD'), TO_TIMESTAMP('2023-12-30 14:45', 'YYYY-MM-DD HH24:MI'));
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(10, 6, 10, TO_DATE('2024-01-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2024-01-02 09:15', 'YYYY-MM-DD HH24:MI'));

INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(1, 1, 6);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(2, 2, 7);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(3, 3, 4);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(4, 4, 3);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(5, 5, 8);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(6, 6, 1);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(7, 7, 2);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(8, 8, 9);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(9, 9, 5);
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(10, 10, 9);

INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(1, 1, 4);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(2, 2, 6);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(3, 3, 2);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(4, 4, 1);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(5, 5, 5);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(6, 6, 3);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(7, 7, 7);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(8, 8, 9);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(9, 9, 8);
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(10, 10, 10);