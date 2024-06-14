drop table if exists followings CASCADE;
CREATE TABLE followings (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    foreign key (user_id) references users(user_id),
    foreign key (creator_id) references creators(creator_id),
    CONSTRAINT unique_following UNIQUE (user_id, creator_id)
) PARTITION BY RANGE (creator_id);

CREATE TABLE followings_0 PARTITION OF followings FOR VALUES FROM (0) TO (100000);
CREATE TABLE followings_100000 PARTITION OF followings FOR VALUES FROM (100000) TO (200000);
CREATE TABLE followings_200000 PARTITION OF followings FOR VALUES FROM (200000) TO (300000);
CREATE TABLE followings_300000 PARTITION OF followings FOR VALUES FROM (300000) TO (400000);
CREATE TABLE followings_400000 PARTITION OF followings FOR VALUES FROM (400000) TO (500000);
CREATE TABLE followings_500000 PARTITION OF followings FOR VALUES FROM (500000) TO (600000);
CREATE TABLE followings_600000 PARTITION OF followings FOR VALUES FROM (600000) TO (700000);
CREATE TABLE followings_700000 PARTITION OF followings FOR VALUES FROM (700000) TO (800000);
CREATE TABLE followings_800000 PARTITION OF followings FOR VALUES FROM (800000) TO (900000);
CREATE TABLE followings_900000 PARTITION OF followings FOR VALUES FROM (900000) TO   (1000001);


ALTER TABLE followings_0 ADD CONSTRAINT check_creator_id_0 CHECK (creator_id >= 0 AND creator_id < 100000);
ALTER TABLE followings_100000 ADD CONSTRAINT check_creator_id_100000 CHECK (creator_id >= 100000 AND creator_id < 200000);
ALTER TABLE followings_200000 ADD CONSTRAINT check_creator_id_200000 CHECK (creator_id >= 200000 AND creator_id < 300000);
ALTER TABLE followings_300000 ADD CONSTRAINT check_creator_id_300000 CHECK (creator_id >= 300000 AND creator_id < 400000);
ALTER TABLE followings_400000 ADD CONSTRAINT check_creator_id_400000 CHECK (creator_id >= 400000 AND creator_id < 500000);
ALTER TABLE followings_500000 ADD CONSTRAINT check_creator_id_500000 CHECK (creator_id >= 500000 AND creator_id < 600000);
ALTER TABLE followings_600000 ADD CONSTRAINT check_creator_id_600000 CHECK (creator_id >= 600000 AND creator_id < 700000);
ALTER TABLE followings_700000 ADD CONSTRAINT check_creator_id_700000 CHECK (creator_id >= 700000 AND creator_id < 800000);
ALTER TABLE followings_800000 ADD CONSTRAINT check_creator_id_800000 CHECK (creator_id >= 800000 AND creator_id < 900000);
ALTER TABLE followings_900000 ADD CONSTRAINT check_creator_id_900000 CHECK (creator_id >= 900000 AND creator_id < 1000001);
