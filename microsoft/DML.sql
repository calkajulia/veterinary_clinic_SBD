USE [2019SBD];

SET IDENTITY_INSERT owner ON;
INSERT INTO owner (owner_ID, first_name, last_name, address, phone_number, email) VALUES
(1, N'Anna', N'Kowalska', N'Warszawa, ul. Główna 10', '123456789', 'anna.kowalska@gmail.com'),
(2, N'Jan', N'Nowak', N'Kraków, ul. Zielona 5', '987654321', 'jan.nowak@gmail.com'),
(3, N'Maria', N'Wiśniewska', N'Gdańsk, ul. Morze 15', '456789123', 'maria.wisniewska@gmail.com'),
(4, N'Tomasz', N'Kaczmarek', N'Poznań, ul. Polna 25', '111222333', 'tomasz.kaczmarek@gmail.com'),
(5, N'Ewa', N'Szymczak', N'Warszawa, ul. Słoneczna 3', '999888777', 'ewa.szymczak@gmail.com'),
(6, N'Agnieszka', N'Lis', N'Katowice, ul. Ogrodowa 7', '222333444', 'agnieszka.lis@gmail.com'),
(7, N'Marek', N'Czarnecki', N'Lublin, ul. Lubelska 8', '555666777', 'marek.czarnecki@gmail.com');
SET IDENTITY_INSERT owner OFF;

SET IDENTITY_INSERT animal ON;
INSERT INTO animal (animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(1, 1, N'Burek', N'Dog', N'Golden Retriever', '2018-03-12', 'M', 1),
(2, 2, N'Puszek', N'Cat', N'Persian', '2020-07-25', 'F', 0),
(3, 3, N'Max', N'Dog', N'Beagle', '2019-06-14', 'M', 1),
(4, 1, N'Luna', N'Cat', N'Siamese', '2021-01-20', 'F', 1),
(5, 4, N'Reks', N'Dog', N'Labrador', '2017-09-30', 'M', 1),
(6, 1, N'Bella', N'Rabbit', N'Holland Lop', '2022-04-10', 'F', 0),
(7, 5, N'Czarek', N'Dog', N'Poodle', '2016-05-15', 'M', 0),
(8, 6, N'Kicia', N'Cat', N'Maine Coon', '2019-12-18', 'F', 1),
(9, 7, N'Fela', N'Parrot', N'Macaw', '2020-02-22', 'F', 1),
(10, 7, N'Leo', N'Dog', N'Doberman', '2021-09-10', 'M', 0);
SET IDENTITY_INSERT animal OFF;

SET IDENTITY_INSERT doctor ON;
INSERT INTO doctor (doctor_ID, first_name, last_name, specialization) VALUES
(1, N'Agnieszka', N'Kwiatkowska', N'Surgery'),
(2, N'Tomasz', N'Zieliński', N'Surgery'),
(3, N'Joanna', N'Majewska', N'Dentistry'),
(4, N'Piotr', N'Lewandowski', N'Radiology'),
(5, N'Magdalena', N'Sobczak', N'General Medicine'),
(6, N'Marek', N'Wiśniewski', N'General Medicine'),
(7, N'Ewa', N'Kamińska', N'General Medicine'),
(8, N'Jan', N'Szymczak', N'General Medicine'),
(9, N'Maria', N'Kowal', N'Cardiology'),
(10, N'Adam', N'Zając', N'Cardiology');
SET IDENTITY_INSERT doctor OFF;

SET IDENTITY_INSERT medicine ON;
INSERT INTO medicine (medicine_ID, name, description, dosage) VALUES
(1, N'Antibiotic A', N'Antibiotic for bacterial infections', N'500mg'),
(2, N'Painkiller B', N'Pain relief medication', N'50mg'),
(3, N'Vaccine C', N'Preventive vaccine for dogs', N'1 dose'),
(4, N'Antifungal D', N'Antifungal treatment for skin infections', N'250mg'),
(5, N'Sedative E', N'Mild sedative for stress relief', N'10mg'),
(6, N'Vitamin F', N'Multivitamin supplement', N'1 tablet'),
(7, N'Dewormer G', N'Deworming medicine for pets', N'2 doses'),
(8, N'Anti-inflammatory H', N'Anti-inflammatory for joint pain', N'100mg'),
(9, N'Antiseptic I', N'Topical antiseptic solution', N'50ml'),
(10, N'Energy Booster J', N'Energy supplement for active pets', N'1 dose');
SET IDENTITY_INSERT medicine OFF;

SET IDENTITY_INSERT medicine_batch ON;
INSERT INTO medicine_batch (medicine_batch_ID, medicine_ID, stock_quantity, expiry_date) VALUES
(1, 1, 100, '2026-12-31'),
(2, 2, 200, '2025-06-30'),
(3, 3, 50, '2025-01-01'),
(4, 4, 75, '2025-08-15'),
(5, 5, 30, '2024-11-01'),
(6, 6, 120, '2025-03-31'),
(7, 7, 80, '2025-09-30'),
(8, 8, 60, '2024-07-15'),
(9, 9, 90, '2026-02-01'),
(10, 10, 40, '2024-05-20');
SET IDENTITY_INSERT medicine_batch OFF;

SET IDENTITY_INSERT [procedure] ON;
INSERT INTO [procedure] (procedure_ID, code, name, description, cost) VALUES
(1, 'S', N'Surgery', N'General surgical procedure', 500.00),
(2, 'V', N'Vaccination', N'Routine vaccination', 100.00),
(3, 'D', N'Deworming', N'Treatment to remove internal parasites', 80.00),
(4, 'X', N'X-ray', N'Diagnostic imaging procedure', 300.00),
(5, 'DC', N'Dental Check-Up', N'Routine dental examination for pets', 150.00),
(6, 'BT', N'Blood Test', N'Comprehensive blood analysis', 120.00),
(7, 'EC', N'Ear Cleaning', N'Routine ear hygiene procedure', 60.00),
(8, 'ST', N'Sterilization', N'Surgical sterilization procedure', 250.00),
(9, 'T', N'Tomography', N'Diagnostic imaging procedure', 700.00);
SET IDENTITY_INSERT [procedure] OFF;

SET IDENTITY_INSERT visit ON;
INSERT INTO visit (visit_ID, animal_ID, doctor_ID, visit_date, visit_time) VALUES
(1, 3, 2, '2023-12-01', '2023-12-01 10:30:00'),
(2, 5, 4, '2023-12-05', '2023-12-05 12:00:00'),
(3, 1, 6, '2023-12-10', '2023-12-10 09:45:00'),
(4, 4, 8, '2023-12-15', '2023-12-15 14:15:00'),
(5, 2, 3, '2023-12-20', '2023-12-20 13:30:00'),
(6, 7, 5, '2023-12-22', '2023-12-22 11:00:00'),
(7, 8, 9, '2023-12-25', '2023-12-25 12:15:00'),
(8, 9, 7, '2023-12-28', '2023-12-28 10:30:00'),
(9, 10, 1, '2023-12-30', '2023-12-30 14:45:00'),
(10, 6, 10, '2024-01-02', '2024-01-02 09:15:00');
SET IDENTITY_INSERT visit OFF;

SET IDENTITY_INSERT visit_procedure ON;
INSERT INTO visit_procedure (visit_procedure_ID, visit_ID, procedure_ID) VALUES
(1, 1, 6),
(2, 2, 7),
(3, 3, 4),
(4, 4, 3),
(5, 5, 8),
(6, 6, 1),
(7, 7, 2),
(8, 8, 9),
(9, 9, 5),
(10, 10, 9);
SET IDENTITY_INSERT visit_procedure OFF;

SET IDENTITY_INSERT visit_procedure_medicine ON;
INSERT INTO visit_procedure_medicine (visit_procedure_medicine_ID, visit_procedure_ID, medicine_batch_ID) VALUES
(1, 1, 4),
(2, 2, 6),
(3, 3, 2),
(4, 4, 1),
(5, 5, 5),
(6, 6, 3),
(7, 7, 7),
(8, 8, 9),
(9, 9, 8),
(10, 10, 10);
SET IDENTITY_INSERT visit_procedure_medicine OFF;