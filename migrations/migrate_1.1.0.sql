drop table if exists attachment_types CASCADE;
drop table if exists attachments CASCADE;
drop table if exists tags CASCADE;
drop table if exists comments CASCADE;
drop table if exists posts CASCADE;


create table if not exists attachment_types (
    attachment_type_id bigserial primary key,
    attachment_type varchar(255) not null
);

create table if not exists attachments (
    attachment_id bigserial primary key,
    attachment bytea not null
);

create table if not exists posts (
    post_id bigserial primary key,
    creator_id bigint not null,
    minimal_required_sub_level_id bigint,
    title varchar(255),
    content text,
    attachment_id bigint,
    attachment_type_id bigint,
    teaser_text text,
    teaser_img bytea,
    comments_availability boolean not null,
    foreign key (creator_id) references creators(creator_id),
    foreign key (minimal_required_sub_level_id) references subscription_levels(sub_level_id),
    foreign key (attachment_type_id) references attachment_types(attachment_type_id),
    foreign key (attachment_id) references attachments(attachment_id)
);

create table if not exists tags (
    tag varchar(255) not null,
    post_id bigint not null,
    foreign key (post_id) references posts(post_id),
    constraint unique_tag_pair unique (tag, post_id)
);


create table if not exists comments (
    comment_id bigserial primary key,
    recipient_comment_id bigint,
    recipient_post_id bigint not null,
    sender_id bigint not null,
    message text not null,
    foreign key (recipient_comment_id) references comments(comment_id),
    foreign key (recipient_post_id) references posts(post_id),
    foreign key (sender_id) references users(user_id)
);