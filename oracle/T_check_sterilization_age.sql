CREATE OR REPLACE TRIGGER check_sterilization_age
BEFORE UPDATE ON animal
FOR EACH ROW
WHEN (NEW.is_sterilized = 1 AND OLD.is_sterilized = 0)
DECLARE
    v_age_in_months NUMBER;
BEGIN
    v_age_in_months := MONTHS_BETWEEN(SYSDATE, :NEW.birth_date);
    
    IF v_age_in_months < 6 THEN
        RAISE_APPLICATION_ERROR(-20010, 'zwierze ' || :NEW.name || ' jest za mlode na sterylizacje (wiek: ' || FLOOR(v_age_in_months) || ' miesiecy)');
    END IF;
END check_sterilization_age;