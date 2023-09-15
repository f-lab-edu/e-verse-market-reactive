-- -------회원 ------------
create table member (
	member_id varchar(50),                  -- 회원id
	member_name varchar(50) not null,       -- 이름
	password_hash varchar(100) not null,    -- 비밀번호
	nickname varchar(100) not null,         -- 닉네임(별명)
	email varchar(100) not null,            -- 이메일
	join_date timestamp default current_timestamp,  -- 가입일
	last_login_date timestamp,              -- 마지막 접속일
	role varchar(50) default 'consumer',    -- 회원 역할 (admin, seller, consumer)
	is_active boolean not null,             -- 회원 상태 (비활성여부)
    
    primary key(member_id)
);

-- ------- 판매자 ------------
create table seller (
	seller_id int auto_increment,           -- 판매자id
	member_id varchar(50),                  -- 회원 아이디
	seller_name varchar(50) not null,       -- 판매자명
	seller_intro text ,                     -- 판매자 소개글
	contact_info varchar(255) ,             -- 연락처 (이메일 or 번호)
	seller_rating decimal(2, 1) default 0.0,  -- 판매자 평점
	profile_img text ,                      -- 판매자 프로필이미지
	total_sales int default 0,              -- 총 판매액
	total_orders int default 0,             -- 총 주문 수
	registration_date timestamp default current_timestamp,  -- 판매자 등록일

	Primary key(seller_id),
    Foreign key (member_id) References member(member_id)
);


-- ------- 상품 ------------
create table product (
	product_id int auto_increment,          -- 상품id
	seller_id int,                          -- 상품 판매자
	product_name varchar(100) not null,     -- 상품명
	description text ,                      -- 상품내용
	price int not null,                     -- 상품가격
	discount_start_date date ,              -- 할인 시작일
	discount_end_date date ,                -- 할인 종료일
	discount_price int ,                    -- 할인가
	category varchar(50) not null,          -- 상품 카테고리
	is_sold boolean not null,               -- 판매여부
	product_file text not null,             -- 상품파일
	thumbnail_img text not null,            -- 제품 썸네일(미리보기) 이미지
	review_count int default 0,             -- 리뷰수
	registration_date timestamp default current_timestamp,  -- 등록일	

	Primary key(product_id),
    Foreign key (seller_id) References seller(seller_id)
);

-- ------- 주문 ------------
create table orders (
	report_id int auto_increment,           -- 신고 id
	reporter_id varchar(50),                -- 신고자id (member_id)
	target_id int not null,                 -- 신고대상 id
	report_type varchar(50) not null,       -- 신고 유형 (seller, review, product)
	report_date timestamp default current_timestamp,  -- 신고 날짜
	report_text text not null,              -- 신고 내용

	Primary key(orders_id),
    Foreign key (member_id) References member(member_id),
    Foreign key (seller_id) References seller(seller_id),
    Foreign key (product_id) References product(product_id)
);



-- ------- 신고 ------------
create table report (
	report_id int auto_increment,           -- 신고 id
	reporter_id varchar(50),                -- 신고자id (member_id)
	target_id int not null,                 -- 신고대상 id
	report_type varchar(50) not null,       -- 신고 유형 (seller, review, product)
	report_date timestamp default current_timestamp,  -- 신고 날짜
	report_text text not null,              -- 신고 내용

	Primary key(report_id),
    Foreign key (reporter_id) References member(member_id)
);


-- ------- 리뷰 ------------
create table review (
	review_id int auto_increment,   -- 리뷰id
	product_id  int,                -- 상품id
	member_id varchar(50),          -- 회원id
	rating decimal(2, 1) not null,  -- 평점				
	review_date timestamp default current_timestamp,  -- 작성일				
	review_text text not null,      -- 리뷰내용

	Primary key(review_id),
    Foreign key (product_id) References product(product_id),
    Foreign key (member_id) References member(member_id)
);


-- ------- 미디어(영상/이미지) ------------
create table media (
	media_id int auto_increment primary key,  -- 미디어 id
	media_type varchar(50) not null,     -- 이미지/영상 유형
	related_table varchar(50) not null,  -- 미디어가 사용될 테이블 위치 (review, product)
	related_id int not null,             -- 미디어가 사용될 글의 id
	file text not null,                  -- 파일 링크

	Primary key(media_id)
);


