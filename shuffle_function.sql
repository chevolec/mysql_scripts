DELIMITER //

DROP FUNCTION IF EXISTS shuffle;

CREATE FUNCTION shuffle(
    v_chars TEXT
)
RETURNS TEXT
NOT DETERMINISTIC -- multiple RAND()'s
NO SQL
SQL SECURITY INVOKER
COMMENT ''
BEGIN
    DECLARE v_retval TEXT DEFAULT '';
    DECLARE u_pos    INT UNSIGNED;
    DECLARE u        INT UNSIGNED;

    SET u = LENGTH(v_chars);
    WHILE u > 0
    DO
      SET u_pos = 1 + FLOOR(RAND() * u);
      SET v_retval = CONCAT(v_retval, MID(v_chars, u_pos, 1));
      SET v_chars = CONCAT(LEFT(v_chars, u_pos - 1), MID(v_chars, u_pos + 1, u));
      SET u = u - 1;
    END WHILE;

    RETURN v_retval;
END;
//

DELIMITER ;
