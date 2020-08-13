WITH final_table as (SELECT day, tutor_id, avg(score)::numeric(3, 2) as average_score FROM
	(SELECT lessons_id, tech_quality as score
		FROM quality
		WHERE NOT tech_quality ISNULL) as scores JOIN
	(SELECT id, event_id, date_trunc('day', scheduled_time)::date as day FROM
		lessons WHERE TRIM(subject) = 'phys') as phys_lessons on id = lessons_id JOIN
	(SELECT DISTINCT p1.event_id as event_id, p1.user_id as tutor_id FROM participants as p1, participants as p2
		WHERE p1.event_id = p2.event_id and TRIM(p1.user_id) in (SELECT DISTINCT TRIM(id) FROM users WHERE TRIM(role) = 'tutor')
			and not p1.user_id = p2.user_id) as tutors on tutors.event_id = phys_lessons.event_id
		GROUP BY day, tutor_id)

SELECT final_table.day, MIN(tutor_id) as tutor_id, average_score 
	FROM final_table JOIN 
	(SELECT day, min(average_score) FROM final_table
	 	GROUP BY day) as min_score on min_score.day = final_table.day
	WHERE average_score = min
	GROUP BY final_table.day, average_score
	ORDER BY final_table.day