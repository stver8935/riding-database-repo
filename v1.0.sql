-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.2.0-alpha
-- PostgreSQL version: 16.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- -- object: riding | type: DATABASE --
-- -- DROP DATABASE IF EXISTS riding;
-- CREATE DATABASE riding;
-- -- ddl-end --
-- 

-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users (
	id serial NOT NULL,
	password varchar(255) NOT NULL,
	email varchar(255),
	user_name varchar(100) NOT NULL,
	created_at timestamp NOT NULL,
	login_fail_count smallint NOT NULL DEFAULT 0,
	last_location point,
	refresh_token varchar(255),
	role varchar(10) NOT NULL,
	fcm_token varchar(255),
	id_user_type integer,
	CONSTRAINT users_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN public.users.id IS E'primary key';
-- ddl-end --
COMMENT ON COLUMN public.users.password IS E'user password';
-- ddl-end --
COMMENT ON COLUMN public.users.login_fail_count IS E'user login fail count';
-- ddl-end --
COMMENT ON COLUMN public.users.last_location IS E'user last location coordinates';
-- ddl-end --
COMMENT ON COLUMN public.users.role IS E'유저 권한';
-- ddl-end --
COMMENT ON COLUMN public.users.fcm_token IS E'Firebase Cloud Messaging 토큰';
-- ddl-end --
ALTER TABLE public.users OWNER TO postgres;
-- ddl-end --

-- object: public.bedge | type: TABLE --
-- DROP TABLE IF EXISTS public.bedge CASCADE;
CREATE TABLE public.bedge (
	id serial NOT NULL,
	name varchar(100) NOT NULL,
	decription text,
	CONSTRAINT bedge_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON COLUMN public.bedge.id IS E'user bedget list';
-- ddl-end --
COMMENT ON COLUMN public.bedge.decription IS E'user bedge description';
-- ddl-end --
ALTER TABLE public.bedge OWNER TO postgres;
-- ddl-end --

-- object: public.user_bedge | type: TABLE --
-- DROP TABLE IF EXISTS public.user_bedge CASCADE;
CREATE TABLE public.user_bedge (
	fk_user_id bigint NOT NULL,
	fk_bedge_id bigint NOT NULL,
	id_users integer NOT NULL,
	id_bedge integer,
	CONSTRAINT user_bedge_pk PRIMARY KEY (fk_user_id,fk_bedge_id,id_users)
);
-- ddl-end --
ALTER TABLE public.user_bedge OWNER TO postgres;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.user_bedge DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.user_bedge ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: bedge_fk | type: CONSTRAINT --
-- ALTER TABLE public.user_bedge DROP CONSTRAINT IF EXISTS bedge_fk CASCADE;
ALTER TABLE public.user_bedge ADD CONSTRAINT bedge_fk FOREIGN KEY (id_bedge)
REFERENCES public.bedge (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.pharmacy_info | type: TABLE --
-- DROP TABLE IF EXISTS public.pharmacy_info CASCADE;
CREATE TABLE public.pharmacy_info (
	id serial NOT NULL,
	CONSTRAINT pharmacy_info_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.pharmacy_info OWNER TO postgres;
-- ddl-end --

-- object: public.restaurant_info | type: TABLE --
-- DROP TABLE IF EXISTS public.restaurant_info CASCADE;
CREATE TABLE public.restaurant_info (
	id serial NOT NULL,
	CONSTRAINT restaurant_info_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.restaurant_info OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_route | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_route CASCADE;
CREATE TABLE public.bicycle_route (
	id serial NOT NULL,
	CONSTRAINT bicycle_route_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.bicycle_route OWNER TO postgres;
-- ddl-end --

-- object: public.standard_veh_link | type: TABLE --
-- DROP TABLE IF EXISTS public.standard_veh_link CASCADE;
CREATE TABLE public.standard_veh_link (
	id serial NOT NULL,
	geom geometry(MULTILINESTRING),
	link_id varchar(10),
	f_node varchar(10),
	t_node varchar(10),
	lanes int4,
	road_rank varchar(3),
	route_type varchar(3),
	road_no varchar(5),
	road_name varchar(30),
	road_use varchar(1),
	multi_link varchar(1),
	connect varchar(3),
	max_spd int4,
	rest_veh varchar(3),
	rest_w int4,
	rest_h int4,
	"c-its" varchar(1),
	length float8,
	updatedate varchar(8),
	remark varchar(30),
	hist_type varchar(8),
	histremark varchar(30),
	CONSTRAINT constraint_primary_key PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.standard_veh_link IS E'국토부 표준 차도 링크 테이블';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.geom IS E'geometry 정보';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.link_id IS E'링크 아이디';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.f_node IS E'시작 노드';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.t_node IS E'종료 노드';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.lanes IS E'차로 수';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.road_rank IS E'*도로 등급 코드\n\n- 101 : 고속 국도\n- 102 : 도시 고속 국도\n- 103 : 일반 국도\n- 104 : 특별.광역시도\n- 105 : 국가 지원 지방도\n- 106 : 지방도\n- 107 : 시.군도\n- 108 : 기타';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.route_type IS E'*도로 유형 코드\n\n- 000 : 일반 국도\n- 001 : 고가 차도\n- 002 : 지하차도\n- 003 : 교량\n- 004 : 터널';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.road_use IS E'*사용 여부\n\n- 0 : 사용\n- 1 : 미사용';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.multi_link IS E'*중용구간 여부\n\n- 0 : 독립구간\n- 1 : 중용구간';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.connect IS E'*연결로 코드\n\n- 000 : 연결로 아님\n- 101 : 고속국도 연결로\n- 102 : 도시고속국도 연결로\n- 103 : 일반국도 연결로\n- 104 : 특별.광역시도 연결로\n- 105 : 국가지원지방도 연결로\n- 106 : 지방도 연결로\n- 107 : 시.군도 연결로\n- 108 : 기타도로 연결로';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.max_spd IS E'속도 제한';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.rest_veh IS E'*통과 제한 차량\n\n- 0 : 모든 차량 통행 가능\n- 1 : 승용차\n- 2 : 승합차\n- 3 : 버스 \n- 4 : 트럭\n- 5 : 이륜차\n- 6 : 기타차량';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.rest_w IS E'통과 제한 하중';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.rest_h IS E'통과 제한 높이';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link."c-its" IS E'*c-its 적용 여부\n\n- 0 : 미적용\n- 1 : 적용';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.length IS E'링크 길이 (m)';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.updatedate IS E'업데이트 날짜 yyyyMMdd';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_link.remark IS E'비고';
-- ddl-end --
ALTER TABLE public.standard_veh_link OWNER TO postgres;
-- ddl-end --

-- object: public.standard_veh_node | type: TABLE --
-- DROP TABLE IF EXISTS public.standard_veh_node CASCADE;
CREATE TABLE public.standard_veh_node (
	id serial NOT NULL,
	geom geometry(POINT),
	node_id varchar(10),
	node_type varchar(3),
	node_name varchar(30),
	turn_p varchar(1),
	updatedate varchar(8),
	remark varchar(30),
	hist_type varchar(8),
	histremark varchar(30),
	CONSTRAINT standard_veh_node_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.standard_veh_node IS E'국토부 표준 차량 노드 테이블';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.geom IS E'geometry 정보';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.node_id IS E'노드 아이디';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.node_type IS E'* 노드 종류\n\n- 101 : 교차로\n- 102 : 도로 시.종점\n- 103 : 속성 변화점\n- 104 : 도로시설물\n- 105 : 행정 경계 \n- 106 : 연결로 접속부\n- 107 : IC 및 JC';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.node_name IS E'노드 명칭';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.turn_p IS E'* 회전 제한 유무\n\n- 0 : 무\n- 1 : 유';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.updatedate IS E'업데이트 날짜 (yyyyMMdd)';
-- ddl-end --
COMMENT ON COLUMN public.standard_veh_node.remark IS E'비고';
-- ddl-end --
ALTER TABLE public.standard_veh_node OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_route_link | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_route_link CASCADE;
CREATE TABLE public.bicycle_route_link (
	id serial NOT NULL,
	CONSTRAINT bicycle_route_link_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.bicycle_route_link OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_route_node | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_route_node CASCADE;
CREATE TABLE public.bicycle_route_node (
	id serial NOT NULL,
	CONSTRAINT bicycle_route_node_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.bicycle_route_node OWNER TO postgres;
-- ddl-end --

-- object: public.bookmark_track | type: TABLE --
-- DROP TABLE IF EXISTS public.bookmark_track CASCADE;
CREATE TABLE public.bookmark_track (
	id serial NOT NULL,
	id_bicycle_track bigint,
	id_users integer,
	created_at timestamp NOT NULL,
	CONSTRAINT route_bookmark_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.bookmark_track IS E'자전거 길 북마크 테이블';
-- ddl-end --
COMMENT ON COLUMN public.bookmark_track.created_at IS E'생성 날짜';
-- ddl-end --
ALTER TABLE public.bookmark_track OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_track_points | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_track_points CASCADE;
CREATE TABLE public.bicycle_track_points (
	id serial NOT NULL,
	geometry geometry(POINT) NOT NULL,
	ele float4,
	created_at timestamp NOT NULL,
	id_bicycle_track bigint NOT NULL,
	CONSTRAINT bicycle_track_points_pk PRIMARY KEY (id,id_bicycle_track)
);
-- ddl-end --
COMMENT ON TABLE public.bicycle_track_points IS E'자전거 종주길 경로를 생성하기 위한 좌표 테이블';
-- ddl-end --
COMMENT ON COLUMN public.bicycle_track_points.geometry IS E'종주길 경로 좌표';
-- ddl-end --
COMMENT ON COLUMN public.bicycle_track_points.ele IS E'해당 좌표점 고도';
-- ddl-end --
ALTER TABLE public.bicycle_track_points OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_track | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_track CASCADE;
CREATE TABLE public.bicycle_track (
	id bigserial NOT NULL,
	name varchar(100),
	length float4,
	riding_time interval,
	geom geometry(LINESTRING) NOT NULL,
	id_users integer,
	CONSTRAINT bicycle_track_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.bicycle_track IS E'자전거 종주길 테이블';
-- ddl-end --
COMMENT ON COLUMN public.bicycle_track.name IS E'종주길 명칭';
-- ddl-end --
COMMENT ON COLUMN public.bicycle_track.length IS E'자전거 종주길 거리 (m)';
-- ddl-end --
COMMENT ON COLUMN public.bicycle_track.riding_time IS E'예상 이동 시간';
-- ddl-end --
ALTER TABLE public.bicycle_track OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_track_waypoint | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_track_waypoint CASCADE;
CREATE TABLE public.bicycle_track_waypoint (
	id serial NOT NULL,
	CONSTRAINT bicycle_track_waypoint_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.bicycle_track_waypoint IS E'자전거 종주길에 포함 웨이 포인트 매핑 테이블';
-- ddl-end --
ALTER TABLE public.bicycle_track_waypoint OWNER TO postgres;
-- ddl-end --

-- object: public.bicycle_waypoint | type: TABLE --
-- DROP TABLE IF EXISTS public.bicycle_waypoint CASCADE;
CREATE TABLE public.bicycle_waypoint (
	id serial NOT NULL,
	name varchar(100),
	geometry geometry(POINT),
	id_bicycle_track bigint NOT NULL,
	CONSTRAINT bicycle_certification_center_pk PRIMARY KEY (id,id_bicycle_track)
);
-- ddl-end --
COMMENT ON TABLE public.bicycle_waypoint IS E'자전거길 웨이 포인트 ( 인증 센터 등 )';
-- ddl-end --
ALTER TABLE public.bicycle_waypoint OWNER TO postgres;
-- ddl-end --

-- object: public.friends | type: TABLE --
-- DROP TABLE IF EXISTS public.friends CASCADE;
CREATE TABLE public.friends (
	id serial NOT NULL,
	created_at timestamp,
	from_user_id integer,
	to_user_id integer,
	id_users integer NOT NULL,
	CONSTRAINT friends_pk PRIMARY KEY (id,id_users)
);
-- ddl-end --
COMMENT ON TABLE public.friends IS E'친구 테이블';
-- ddl-end --
COMMENT ON COLUMN public.friends.created_at IS E'생성일';
-- ddl-end --
ALTER TABLE public.friends OWNER TO postgres;
-- ddl-end --

-- object: public.riding_group | type: TABLE --
-- DROP TABLE IF EXISTS public.riding_group CASCADE;
CREATE TABLE public.riding_group (
	id serial NOT NULL,
	description text,
	created_at timestamp,
	CONSTRAINT riding_group_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.riding_group IS E'라이딩 그룹 ( 동호회 등 ) 테이블';
-- ddl-end --
COMMENT ON COLUMN public.riding_group.description IS E'라이딩 그룹 소개글';
-- ddl-end --
COMMENT ON COLUMN public.riding_group.created_at IS E'생성일';
-- ddl-end --
ALTER TABLE public.riding_group OWNER TO postgres;
-- ddl-end --

-- object: public.riding | type: TABLE --
-- DROP TABLE IF EXISTS public.riding CASCADE;
CREATE TABLE public.riding (
	id serial NOT NULL,
	title varchar(100),
	created_at timestamp NOT NULL,
	start_dt date NOT NULL,
	end_dt date NOT NULL,
	max_people_num smallint,
	description text,
	visibility smallint NOT NULL,
	CONSTRAINT riding_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.riding IS E'라이딩 일정 테이블 -- track 테이블을 참조 해야 한다.';
-- ddl-end --
COMMENT ON COLUMN public.riding.title IS E'제목';
-- ddl-end --
COMMENT ON COLUMN public.riding.created_at IS E'생성일';
-- ddl-end --
COMMENT ON COLUMN public.riding.start_dt IS E'시작일';
-- ddl-end --
COMMENT ON COLUMN public.riding.end_dt IS E'종료일';
-- ddl-end --
COMMENT ON COLUMN public.riding.max_people_num IS E'최대 참여 인원';
-- ddl-end --
COMMENT ON COLUMN public.riding.description IS E'해당 라이딩 일정 설명';
-- ddl-end --
COMMENT ON COLUMN public.riding.visibility IS E'게시물 공개 범위';
-- ddl-end --
ALTER TABLE public.riding OWNER TO postgres;
-- ddl-end --

-- object: public.riding_participants | type: TABLE --
-- DROP TABLE IF EXISTS public.riding_participants CASCADE;
CREATE TABLE public.riding_participants (
	id serial NOT NULL,
	id_users integer,
	id_riding integer,
	CONSTRAINT riding_participant_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.riding_participants IS E'라이딩 일정 참여자 테이블';
-- ddl-end --
ALTER TABLE public.riding_participants OWNER TO postgres;
-- ddl-end --

-- object: public.notification | type: TABLE --
-- DROP TABLE IF EXISTS public.notification CASCADE;
CREATE TABLE public.notification (
	id_users integer NOT NULL,
	created_at timestamp,
	from_user_id integer,
	to_user_id integer,
	type smallint NOT NULL,
	CONSTRAINT notification_pk PRIMARY KEY (id_users)
);
-- ddl-end --
COMMENT ON TABLE public.notification IS E'알람테이블';
-- ddl-end --
COMMENT ON COLUMN public.notification.created_at IS E'생성일';
-- ddl-end --
COMMENT ON COLUMN public.notification.from_user_id IS E'친구 요청 유저 아이디';
-- ddl-end --
COMMENT ON COLUMN public.notification.to_user_id IS E'친구 요청 대상 아이디';
-- ddl-end --
COMMENT ON COLUMN public.notification.type IS E'알람 타입\n- 0 : 공지\n- 1 : 프로모션 ( 광고 )\n- 2 : 라이딩 알람\n- 3 : 친구 신청';
-- ddl-end --
ALTER TABLE public.notification OWNER TO postgres;
-- ddl-end --

-- object: bicycle_track_fk | type: CONSTRAINT --
-- ALTER TABLE public.bicycle_track_points DROP CONSTRAINT IF EXISTS bicycle_track_fk CASCADE;
ALTER TABLE public.bicycle_track_points ADD CONSTRAINT bicycle_track_fk FOREIGN KEY (id_bicycle_track)
REFERENCES public.bicycle_track (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: bicycle_track_fk | type: CONSTRAINT --
-- ALTER TABLE public.bicycle_waypoint DROP CONSTRAINT IF EXISTS bicycle_track_fk CASCADE;
ALTER TABLE public.bicycle_waypoint ADD CONSTRAINT bicycle_track_fk FOREIGN KEY (id_bicycle_track)
REFERENCES public.bicycle_track (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.bicycle_track DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.bicycle_track ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE CASCADE;
-- ddl-end --

-- object: bicycle_track_fk | type: CONSTRAINT --
-- ALTER TABLE public.bookmark_track DROP CONSTRAINT IF EXISTS bicycle_track_fk CASCADE;
ALTER TABLE public.bookmark_track ADD CONSTRAINT bicycle_track_fk FOREIGN KEY (id_bicycle_track)
REFERENCES public.bicycle_track (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.riding_participants DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.riding_participants ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: riding_fk | type: CONSTRAINT --
-- ALTER TABLE public.riding_participants DROP CONSTRAINT IF EXISTS riding_fk CASCADE;
ALTER TABLE public.riding_participants ADD CONSTRAINT riding_fk FOREIGN KEY (id_riding)
REFERENCES public.riding (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.notification DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.notification ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.notice | type: TABLE --
-- DROP TABLE IF EXISTS public.notice CASCADE;
CREATE TABLE public.notice (
	id serial NOT NULL,
	title varchar(100),
	contents text,
	created_at timestamp NOT NULL,
	id_users integer,
	CONSTRAINT notice_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.notice IS E'공지사항 테이블';
-- ddl-end --
COMMENT ON COLUMN public.notice.title IS E'공지 제목';
-- ddl-end --
COMMENT ON COLUMN public.notice.contents IS E'내용';
-- ddl-end --
COMMENT ON COLUMN public.notice.created_at IS E'작성 날짜';
-- ddl-end --
ALTER TABLE public.notice OWNER TO postgres;
-- ddl-end --

-- object: public.faq | type: TABLE --
-- DROP TABLE IF EXISTS public.faq CASCADE;
CREATE TABLE public.faq (
	id serial NOT NULL,
	created_at timestamp,
	question text,
	answer text,
	id_users integer,
	CONSTRAINT faq_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.faq IS E'faq 테이블';
-- ddl-end --
COMMENT ON COLUMN public.faq.created_at IS E'작성 날짜';
-- ddl-end --
COMMENT ON COLUMN public.faq.question IS E'질문';
-- ddl-end --
COMMENT ON COLUMN public.faq.answer IS E'답변';
-- ddl-end --
ALTER TABLE public.faq OWNER TO postgres;
-- ddl-end --

-- object: public.qna | type: TABLE --
-- DROP TABLE IF EXISTS public.qna CASCADE;
CREATE TABLE public.qna (
	id serial NOT NULL,
	title varchar(100),
	contents text,
	created_at timestamp NOT NULL,
	id_users integer,
	CONSTRAINT qna_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.qna IS E'qna';
-- ddl-end --
COMMENT ON COLUMN public.qna.title IS E'제목';
-- ddl-end --
COMMENT ON COLUMN public.qna.contents IS E'내용';
-- ddl-end --
COMMENT ON COLUMN public.qna.created_at IS E'작성일';
-- ddl-end --
ALTER TABLE public.qna OWNER TO postgres;
-- ddl-end --

-- object: public.qna_answer | type: TABLE --
-- DROP TABLE IF EXISTS public.qna_answer CASCADE;
CREATE TABLE public.qna_answer (
	id bigserial NOT NULL,
	title varchar(100),
	contents text,
	id_qna integer NOT NULL,
	id_users integer,
	CONSTRAINT qna_answer_pk PRIMARY KEY (id,id_qna)
);
-- ddl-end --
COMMENT ON TABLE public.qna_answer IS E'qna 답변 테이블';
-- ddl-end --
COMMENT ON COLUMN public.qna_answer.contents IS E'내용';
-- ddl-end --
ALTER TABLE public.qna_answer OWNER TO postgres;
-- ddl-end --

-- object: public.purchase_info | type: TABLE --
-- DROP TABLE IF EXISTS public.purchase_info CASCADE;
CREATE TABLE public.purchase_info (
	id bigserial NOT NULL,
	CONSTRAINT purchase_info_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.purchase_info IS E'상품 구매 정보';
-- ddl-end --
ALTER TABLE public.purchase_info OWNER TO postgres;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.qna DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.qna ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.qna_answer DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.qna_answer ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.faq DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.faq ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.notice DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.notice ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.payment_history | type: TABLE --
-- DROP TABLE IF EXISTS public.payment_history CASCADE;
CREATE TABLE public.payment_history (
	id bigserial NOT NULL,
	CONSTRAINT payment_history_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.payment_history OWNER TO postgres;
-- ddl-end --

-- object: public.promotion | type: TABLE --
-- DROP TABLE IF EXISTS public.promotion CASCADE;
CREATE TABLE public.promotion (
	id bigserial NOT NULL,
	CONSTRAINT promotion_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.promotion OWNER TO postgres;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.friends DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.friends ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.riding_history | type: TABLE --
-- DROP TABLE IF EXISTS public.riding_history CASCADE;
CREATE TABLE public.riding_history (
	id bigserial NOT NULL,
	created_at timestamp NOT NULL,
	id_users integer NOT NULL,
	CONSTRAINT riding_history_pk PRIMARY KEY (id,id_users)
);
-- ddl-end --
COMMENT ON TABLE public.riding_history IS E'자전거 라이딩 기록';
-- ddl-end --
ALTER TABLE public.riding_history OWNER TO postgres;
-- ddl-end --

-- object: public.riding_points_history | type: TABLE --
-- DROP TABLE IF EXISTS public.riding_points_history CASCADE;
CREATE TABLE public.riding_points_history (
	id bigserial NOT NULL,
	created_at timestamp NOT NULL,
	geom geometry(POINT) NOT NULL,
	id_riding_history bigint NOT NULL,
	id_users_riding_history integer NOT NULL,
	CONSTRAINT riding_points_history_pk PRIMARY KEY (id,id_riding_history,id_users_riding_history)
);
-- ddl-end --
COMMENT ON TABLE public.riding_points_history IS E'자전거 라이딩 기록';
-- ddl-end --
ALTER TABLE public.riding_points_history OWNER TO postgres;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.riding_history DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.riding_history ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: users_fk | type: CONSTRAINT --
-- ALTER TABLE public.bookmark_track DROP CONSTRAINT IF EXISTS users_fk CASCADE;
ALTER TABLE public.bookmark_track ADD CONSTRAINT users_fk FOREIGN KEY (id_users)
REFERENCES public.users (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.user_type | type: TABLE --
-- DROP TABLE IF EXISTS public.user_type CASCADE;
CREATE TABLE public.user_type (
	id serial NOT NULL,
	type smallint NOT NULL,
	created_at timestamp NOT NULL,
	CONSTRAINT user_type_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.user_type IS E'유저 종류 테이블';
-- ddl-end --
COMMENT ON COLUMN public.user_type.type IS E'유저 타입\n\n- 0 : Admin\n- 1  : Manager\n- 2 :  User\n- 3 : Guest';
-- ddl-end --
COMMENT ON COLUMN public.user_type.created_at IS E'생성일';
-- ddl-end --
ALTER TABLE public.user_type OWNER TO postgres;
-- ddl-end --

-- object: public.access_page | type: TABLE --
-- DROP TABLE IF EXISTS public.access_page CASCADE;
CREATE TABLE public.access_page (
	id serial NOT NULL,
	path text,
	created_at timestamp,
	CONSTRAINT access_page_pk PRIMARY KEY (id)
);
-- ddl-end --
COMMENT ON TABLE public.access_page IS E'접근 가능 프론트엔드 페이지 테이블';
-- ddl-end --
COMMENT ON COLUMN public.access_page.path IS E'페이지 경로';
-- ddl-end --
ALTER TABLE public.access_page OWNER TO postgres;
-- ddl-end --

-- object: user_type_fk | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS user_type_fk CASCADE;
ALTER TABLE public.users ADD CONSTRAINT user_type_fk FOREIGN KEY (id_user_type)
REFERENCES public.user_type (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.user_type_access_page | type: TABLE --
-- DROP TABLE IF EXISTS public.user_type_access_page CASCADE;
CREATE TABLE public.user_type_access_page (
	id serial NOT NULL,
	created_at timestamp NOT NULL,
	id_access_page integer,
	id_user_type integer NOT NULL,
	CONSTRAINT user_type_access_page_pk PRIMARY KEY (id,id_user_type)
);
-- ddl-end --
COMMENT ON COLUMN public.user_type_access_page.created_at IS E'생성일';
-- ddl-end --
ALTER TABLE public.user_type_access_page OWNER TO postgres;
-- ddl-end --

-- object: access_page_fk | type: CONSTRAINT --
-- ALTER TABLE public.user_type_access_page DROP CONSTRAINT IF EXISTS access_page_fk CASCADE;
ALTER TABLE public.user_type_access_page ADD CONSTRAINT access_page_fk FOREIGN KEY (id_access_page)
REFERENCES public.access_page (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: user_type_fk | type: CONSTRAINT --
-- ALTER TABLE public.user_type_access_page DROP CONSTRAINT IF EXISTS user_type_fk CASCADE;
ALTER TABLE public.user_type_access_page ADD CONSTRAINT user_type_fk FOREIGN KEY (id_user_type)
REFERENCES public.user_type (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: qna_fk | type: CONSTRAINT --
-- ALTER TABLE public.qna_answer DROP CONSTRAINT IF EXISTS qna_fk CASCADE;
ALTER TABLE public.qna_answer ADD CONSTRAINT qna_fk FOREIGN KEY (id_qna)
REFERENCES public.qna (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: riding_history_fk | type: CONSTRAINT --
-- ALTER TABLE public.riding_points_history DROP CONSTRAINT IF EXISTS riding_history_fk CASCADE;
ALTER TABLE public.riding_points_history ADD CONSTRAINT riding_history_fk FOREIGN KEY (id_riding_history,id_users_riding_history)
REFERENCES public.riding_history (id,id_users) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
WITH SCHEMA public;
-- ddl-end --
COMMENT ON EXTENSION postgis IS E'PostGIS geometry, geography, and raster spatial types and functions';
-- ddl-end --


