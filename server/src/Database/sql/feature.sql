-- get list num register phase 1
SELECT
    s.subject_code,
    s.subject_name,
    COUNT(DISTINCT rp.student_id) AS whole_num
FROM
    subjects s
    LEFT JOIN registerphase1 rp ON s.subject_code = rp.subject_code AND rp.semester_id = 231
GROUP BY
    s.subject_code, s.subject_name
HAVING
    SUM(CASE WHEN rp.action = 'REGISTER' THEN 1 ELSE 0 END) >= SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);
-- 
