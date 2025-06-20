CREATE OR REPLACE PROCEDURE register_new_animal (
    p_owner_ID IN NUMBER,
    p_name IN NVARCHAR2,
    p_species IN NVARCHAR2,
    p_breed IN NVARCHAR2 DEFAULT NULL,
    p_birth_date IN DATE,
    p_gender IN CHAR,
    p_is_sterilized IN NUMBER DEFAULT 0
)
IS
    v_owner_name NVARCHAR2(101);
    v_animal_id NUMBER;
    v_age_in_months NUMBER;
    v_existing_count NUMBER;
    
    CURSOR existing_animals_cursor IS
        SELECT animal_ID, name, species, birth_date
        FROM animal
        WHERE owner_ID = p_owner_ID
        AND name = p_name
        AND species = p_species
        AND birth_date = p_birth_date;
        
    v_existing_animal existing_animals_cursor%ROWTYPE;
BEGIN
    IF p_owner_ID IS NULL OR p_name IS NULL OR p_species IS NULL OR p_birth_date IS NULL OR p_gender IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'nieprawidlowe parametry procedury.');
    END IF;
    
    IF p_gender NOT IN ('M', 'F') THEN
        RAISE_APPLICATION_ERROR(-20002, 'bledna plec zwierzecia. dopuszczalne: M/F.');
    END IF;
    
    BEGIN
        SELECT first_name || ' ' || last_name
        INTO v_owner_name
        FROM owner
        WHERE owner_ID = p_owner_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'brak wlasciciela o id: ' || p_owner_ID);
    END;
    
    v_age_in_months := MONTHS_BETWEEN(SYSDATE, p_birth_date);
    
    IF v_age_in_months < 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'data urodzenia nie moze byc przyszla');
    END IF;
    
    IF p_is_sterilized = 1 AND v_age_in_months < 6 THEN
        RAISE_APPLICATION_ERROR(-20005, 'zwierze mlodsze niz 6 miesiecy nie moze byc wysterylizowane');
    END IF;
    
    OPEN existing_animals_cursor;
    FETCH existing_animals_cursor INTO v_existing_animal;
    
    IF existing_animals_cursor%FOUND THEN
        CLOSE existing_animals_cursor;
        RAISE_APPLICATION_ERROR(-20006, 'zwierze juz jest zarejestrowane');
    END IF;
    
    CLOSE existing_animals_cursor;
    
    INSERT INTO animal(animal_ID, owner_ID, name, species, breed, birth_date, gender, is_sterilized)
    VALUES (seq_animal.NEXTVAL, p_owner_ID, p_name, p_species, p_breed, p_birth_date, p_gender, p_is_sterilized)
    RETURNING animal_ID INTO v_animal_id;
    
    DBMS_OUTPUT.PUT_LINE('pomyslnie zarejestrowano zwierze:');
    DBMS_OUTPUT.PUT_LINE('		id: ' || v_animal_id);
    DBMS_OUTPUT.PUT_LINE('		imie: ' || p_name);
    DBMS_OUTPUT.PUT_LINE('		gatunek: ' || p_species);
    IF p_breed IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('		rasa: ' || p_breed);
    END IF;
    DBMS_OUTPUT.PUT_LINE('		wiek: ' || FLOOR(v_age_in_months) || ' miesiecy');
    DBMS_OUTPUT.PUT_LINE('		plec: ' || p_gender);
    DBMS_OUTPUT.PUT_LINE('		sterylizacja: ' || CASE p_is_sterilized WHEN 1 THEN 'Tak' ELSE 'Nie' END);
    DBMS_OUTPUT.PUT_LINE('		wlasciciel: ' || v_owner_name || ' (ID: ' || p_owner_ID || ')');
    
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END register_new_animal;