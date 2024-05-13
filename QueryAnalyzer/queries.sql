SELECT c.creator_id, u.name, COUNT(DISTINCT s.sub_id) AS subscribers_amount, COUNT(DISTINCT f.user_id) AS subscribers_amount
FROM creators AS c
LEFT JOIN users AS u ON c.creator_id = u.user_id
LEFT JOIN subscription_levels AS sl ON sl.creator_id = c.creator_id
INNER JOIN subscriptions AS s ON s.sub_level_id = sl.sub_level_id
LEFT JOIN followings_partitioned AS f ON f.creator_id = c.creator_id
GROUP BY c.creator_id, u.name;

SELECT *
FROM posts AS p
LEFT JOIN public.tags AS t ON p.post_id = t.post_id
WHERE t.tag = '#music';

SELECT c.creator_id, u.name, SUM(w.amount) AS total_output
FROM creators AS c
LEFT JOIN users AS u ON c.creator_id = u.user_id
LEFT JOIN withdrawals AS w ON c.creator_id = w.creator_id
WHERE w.datetime >= CURRENT_TIMESTAMP - INTERVAL '5 years'
GROUP BY c.creator_id, u.name;

SELECT *
FROM subscription_levels AS sl
INNER JOIN subscriptions AS s ON s.sub_level_id = sl.sub_level_id
WHERE sl.creator_id = 10;

SELECT *
FROM comments AS c
WHERE c.recipient_post_id = 2070477;