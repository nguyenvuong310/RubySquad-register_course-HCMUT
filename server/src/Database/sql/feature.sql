SELECT
    rp.subject_code,
    s.subject_name,
    s.credits,
    COUNT(DISTINCT rp.subject_code) AS Whole_num
FROM
    registerpharse1 rp
    JOIN subjects s ON rp.subject_code = s.subject_code
WHERE
    rp.semester_id = 231
GROUP BY rp.student_id, rp.subject_code, s.subject_name, s.credits
HAVING SUM(CASE WHEN rp.action = 'INSERT' THEN 1 ELSE 0 END) > SUM(CASE WHEN rp.action = 'DELETE' THEN 1 ELSE 0 END);