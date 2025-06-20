USE [2019SBD];

INSERT INTO owner (first_name, last_name, address, phone_number, email) VALUES
('Anna', 'Kowalska', 'Warszawa, ul. Główna 10', '123456789', 'anna.kowalska@gmail.com'),
('Jan', 'Nowak', 'Kraków, ul. Zielona 5', '987654321', 'jan.nowak@gmail.com'),
('Maria', 'Wiśniewska', 'Gdańsk, ul. Morze 15', '456789123', 'maria.wisniewska@gmail.com'),
('Tomasz', 'Kaczmarek', 'Poznań, ul. Polna 25', '111222333', 'tomasz.kaczmarek@gmail.com'),
('Ewa', 'Szymczak', 'Warszawa, ul. Słoneczna 3', '999888777', 'ewa.szymczak@gmail.com'),
('Agnieszka', 'Lis', 'Katowice, ul. Ogrodowa 7', '222333444', 'agnieszka.lis@gmail.com'),
('Marek', 'Czarnecki', 'Lublin, ul. Lubelska 8', '555666777', 'marek.czarnecki@gmail.com');

INSERT INTO animal (owner_ID, name, species, breed, birth_date, gender, is_sterilized) VALUES
(1, 'Burek', 'Dog', 'Golden Retriever', '2018-03-12', 'M', 1),
(2, 'Puszek', 'Cat', 'Persian', '2020-07-25', 'F', 0),
(3, 'Max', 'Dog', 'Beagle', '2019-06-14', 'M', 1),
(1, 'Luna', 'Cat', 'Siamese', '2021-01-20', 'F', 1),
(4, 'Reks', 'Dog', 'Labrador', '2017-09-30', 'M', 1),
(1, 'Bella', 'Rabbit', 'Holland Lop', '2022-04-10', 'F', 0),
(5, 'Czarek', 'Dog', 'Poodle', '2016-05-15', 'M', 0),
(6, 'Kicia', 'Cat', 'Maine Coon', '2019-12-18', 'F', 1),
(7, 'Fela', 'Parrot', 'Macaw', '2020-02-22', 'F', 1),
(7, 'Leo', 'Dog', 'Doberman', '2021-09-10', 'M', 0);

INSERT INTO doctor (first_name, last_name, specialization) VALUES
('Agnieszka', 'Kwiatkowska', 'Surgery'),
('Tomasz', 'Zieliński', 'Surgery'),
('Joanna', 'Majewska', 'Dentistry'),
('Piotr', 'Lewandowski', 'Radiology'),
('Magdalena', 'Sobczak', 'General Medicine'),
('Marek', 'Wiśniewski', 'General Medicine'),
('Ewa', 'Kamińska', 'General Medicine'),
('Jan', 'Szymczak', 'General Medicine'),
('Maria', 'Kowal', 'Cardiology'),
('Adam', 'Zając', 'Cardiology');

INSERT INTO medicine (name, description, dosage) VALUES
('Antibiotic A', 'Antibiotic for bacterial infections', '500mg'),
('Painkiller B', 'Pain relief medication', '50mg'),
('Vaccine C', 'Preventive vaccine for dogs', '1 dose'),
('Antifungal D', 'Antifungal treatment for skin infections', '250mg'),
('Sedative E', 'Mild sedative for stress relief', '10mg'),
('Vitamin F', 'Multivitamin supplement', '1 tablet'),
('Dewormer G', 'Deworming medicine for pets', '2 doses'),
('Anti-inflammatory H', 'Anti-inflammatory for joint pain', '100mg'),
('Antiseptic I', 'Topical antiseptic solution', '50ml'),
('Energy Booster J', 'Energy supplement for active pets', '1 dose');

INSERT INTO medicine_batch (medicine_ID, stock_quantity, expiry_date) VALUES
(1, 100, '2026-12-31'),
(2, 200, '2025-06-30'),
(3, 50, '2025-01-01'),
(4, 75, '2025-08-15'),
(5, 30, '2024-11-01'),
(6, 120, '2025-03-31'),
(7, 80, '2025-09-30'),
(8, 60, '2024-07-15'),
(9, 90, '2026-02-01'),
(10, 40, '2024-05-20');

INSERT INTO [procedure] (code, name, description, cost) VALUES
('S', 'Surgery', 'General surgical procedure', 500.00),
('V', 'Vaccination', 'Routine vaccination', 100.00),
('D', 'Deworming', 'Treatment to remove internal parasites', 80.00),
('X', 'X-ray', 'Diagnostic imaging procedure', 300.00),
('DC', 'Dental Check-Up', 'Routine dental examination for pets', 150.00),
('BT', 'Blood Test', 'Comprehensive blood analysis', 120.00),
('EC', 'Ear Cleaning', 'Routine ear hygiene procedure', 60.00),
('ST', 'Sterilization', 'Surgical sterilization procedure', 250.00),
('T', 'Tomography', 'Diagnostic imaging procedure', 700.00);

INSERT INTO visit (animal_ID, doctor_ID, visit_date, visit_time) VALUES
(3, 2, '2023-12-01', '2023-12-01 10:30:00'),
(5, 4, '2023-12-05', '2023-12-05 12:00:00'),
(1, 6, '2023-12-10', '2023-12-10 09:45:00'),
(4, 8, '2023-12-15', '2023-12-15 14:15:00'),
(2, 3, '2023-12-20', '2023-12-20 13:30:00'),
(7, 5, '2023-12-22', '2023-12-22 11:00:00'),
(8, 9, '2023-12-25', '2023-12-25 12:15:00'),
(9, 7, '2023-12-28', '2023-12-28 10:30:00'),
(10, 1, '2023-12-30', '2023-12-30 14:45:00'),
(6, 10, '2024-01-02', '2024-01-02 09:15:00');

INSERT INTO visit_procedure (visit_ID, procedure_ID) VALUES
(1, 6),
(2, 7),
(3, 4),
(4, 3),
(5, 8),
(6, 1),
(7, 2),
(8, 9),
(9, 5),
(10, 9);

INSERT INTO visit_procedure_medicine (visit_procedure_ID, medicine_batch_ID) VALUES
(1, 4),
(2, 6),
(3, 2),
(4, 1),
(5, 5),
(6, 3),
(7, 7),
(8, 9),
(9, 8),
(10, 10);