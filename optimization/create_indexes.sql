CREATE INDEX idx_creators_creator_id ON creators (creator_id);
CREATE INDEX idx_users_user_id ON users (user_id);
CREATE INDEX idx_subscription_levels_creator_id ON subscription_levels (creator_id);
CREATE INDEX idx_subscription_levels_sub_level_id ON subscription_levels (sub_level_id);
CREATE INDEX idx_subscriptions_sub_level_id ON subscriptions (sub_level_id);
CREATE INDEX idx_subscriptions_sub_id ON subscriptions (sub_id);
CREATE INDEX idx_followings_creator_id ON followings (creator_id);
CREATE INDEX idx_followings_user_id ON followings (user_id);
CREATE INDEX idx_users_name ON users USING HASH(name);

CREATE INDEX idx_posts_post_id ON posts (post_id);
CREATE INDEX idx_tags_post_id ON tags (post_id);
CREATE INDEX idx_tags_tag ON tags USING HASH(tag);

CREATE INDEX idx_withdrawals_creator_id ON withdrawals (creator_id);
CREATE INDEX idx_withdrawals_datetime ON withdrawals (datetime);

CREATE INDEX idx_comments_recipient_post_id ON comments (recipient_post_id);

