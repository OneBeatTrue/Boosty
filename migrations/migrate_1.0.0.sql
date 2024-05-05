create table if not exists users (
    user_id bigserial primary key,
    name varchar(255) unique not null,
    phone_number bigint not null,
    email varchar(255),
    profile_picture bytea,
    password varchar(64) not null
);

create table if not exists withdrawal_systems (
    withdrawal_system_id bigserial primary key,
    name varchar(255) unique not null,
    percent float,
    mandatory_deduction float
);

create table if not exists creators (
    creator_id bigint primary key,
    cover bytea,
    description varchar(255),
    withdrawal_system_id bigint not null,
    withdrawal_required_inf varchar(255) not null,
    balance float not null,
    foreign key (creator_id) references users(user_id),
    foreign key (withdrawal_system_id) references withdrawal_systems(withdrawal_system_id)
);

create table if not exists withdrawals (
    withdrawal_id bigserial primary key,
    creator_id bigint not null,
    withdrawal_system_id bigint not null,
    datetime timestamp not null,
    amount float not null,
    foreign key (creator_id) references creators(creator_id),
    foreign key (withdrawal_system_id) references withdrawal_systems(withdrawal_system_id)
);

create table if not exists links (
    link_id bigserial primary key,
    creator_id bigint not null,
    link varchar(255) not null,
    foreign key (creator_id) references creators(creator_id)
);

create table if not exists currencies (
    currency_id bigserial primary key,
    currency_name varchar(255) not null
);

create table if not exists bank_types (
    bank_type_id bigserial primary key,
    bank_type_name varchar(255) not null
);

create table if not exists billings (
    billing_id bigserial primary key,
    user_id bigint not null,
    currency_id bigint not null,
    card_number bigint not null,
    valid_until date not null,
    cardholder_name varchar(255) not null,
    cvv smallint not null,
    bank_type_id bigint not null,
    foreign key (user_id) references users(user_id),
    foreign key (currency_id) references currencies(currency_id),
    foreign key (bank_type_id) references bank_types(bank_type_id)
);

create table if not exists followings (
    user_id bigint not null,
    creator_id bigint not null,
    foreign key (user_id) references users(user_id),
    foreign key (creator_id) references creators(creator_id),
    constraint unique_following unique (user_id, creator_id)
);

create table if not exists subscription_levels (
    sub_level_id bigserial primary key,
    creator_id bigint not null,
    price float not null,
    title varchar(255) not null,
    cover bytea,
    description varchar(255),
    welcome_message varchar(255),
    foreign key (creator_id) references creators(creator_id)
);

create table if not exists subscriptions (
    sub_id bigserial primary key,
    user_id bigint not null,
    sub_level_id bigint not null,
    start_date date not null,
    end_date date not null,
    foreign key (user_id) references users(user_id),
    foreign key (sub_level_id) references subscription_levels(sub_level_id)
);

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
    tags varchar(255),
    comments_availability boolean not null,
    foreign key (creator_id) references creators(creator_id),
    foreign key (minimal_required_sub_level_id) references subscription_levels(sub_level_id),
    foreign key (attachment_id) references attachments(attachment_id),
    foreign key (attachment_type_id) references attachment_types(attachment_type_id)
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