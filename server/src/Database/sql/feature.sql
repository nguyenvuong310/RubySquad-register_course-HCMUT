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


SELECT SUM(credits) AS studentTotalCredits
        FROM (
            SELECT a.student_id, c.subject_code as subject
            FROM Attends a
            JOIN Classes c ON a.class_id = c.class_id
            WHERE a.student_id = 2115367 ON c.semester_id = 231
            GROUP BY a.student_id, c.subject_code
            HAVING SUM(CASE WHEN a.action = 'REGISTER' THEN 1 ELSE 0 END) > SUM(CASE WHEN a.action = 'DELETE' THEN 1 ELSE 0 END)
        ) AS max_scores
        JOIN Subjects s ON max_scores.subject = s.subject_code;