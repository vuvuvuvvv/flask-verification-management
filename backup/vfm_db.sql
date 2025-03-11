--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: dongho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dongho (
    id integer NOT NULL,
    group_id character varying(255),
    ten_dong_ho character varying(255) NOT NULL,
    phuong_tien_do character varying(255),
    seri_chi_thi character varying(255),
    seri_sensor character varying(255),
    kieu_chi_thi character varying(255),
    kieu_sensor character varying(255),
    kieu_thiet_bi character varying(255),
    co_so_san_xuat character varying(255),
    so_tem character varying(255),
    nam_san_xuat date,
    dn character varying(255),
    d character varying(255),
    ccx character varying(255),
    q3 character varying(255),
    r character varying(255),
    qn character varying(255),
    k_factor character varying(255),
    so_qd_pdm character varying(255),
    ten_khach_hang character varying(255),
    co_so_su_dung character varying(255),
    noi_su_dung character varying(255),
    vi_tri character varying(255),
    noi_thuc_hien character varying(255),
    phuong_phap_thuc_hien character varying(255),
    chuan_thiet_bi_su_dung character varying(255),
    nguoi_thuc_hien character varying(255),
    nguoi_soat_lai character varying(255),
    ngay_thuc_hien date,
    hieu_luc_bien_ban date,
    nhiet_do character varying(255),
    do_am character varying(255),
    du_lieu_kiem_dinh text,
    so_giay_chung_nhan character varying(255),
    last_updated text,
    owner_id integer,
    ket_qua_check_vo_ngoai boolean,
    ghi_chu_vo_ngoai character varying(255),
    index integer,
    is_hieu_chuan boolean,
    ma_quan_ly character varying(255)
);


ALTER TABLE public.dongho OWNER TO postgres;

--
-- Name: dongho_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dongho_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dongho_id_seq OWNER TO postgres;

--
-- Name: dongho_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dongho_id_seq OWNED BY public.dongho.id;


--
-- Name: dongho_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dongho_permissions (
    id integer NOT NULL,
    role_id integer,
    dongho_id integer,
    username character varying(64),
    manager character varying(64)
);


ALTER TABLE public.dongho_permissions OWNER TO postgres;

--
-- Name: dongho_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dongho_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dongho_permissions_id_seq OWNER TO postgres;

--
-- Name: dongho_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dongho_permissions_id_seq OWNED BY public.dongho_permissions.id;


--
-- Name: nhomdongho_payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nhomdongho_payment (
    id integer NOT NULL,
    group_id character varying(50) NOT NULL,
    is_paid boolean NOT NULL,
    paid_date timestamp without time zone,
    payment_collector character varying(50),
    last_updated text
);


ALTER TABLE public.nhomdongho_payment OWNER TO postgres;

--
-- Name: nhomdongho_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nhomdongho_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nhomdongho_payment_id_seq OWNER TO postgres;

--
-- Name: nhomdongho_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nhomdongho_payment_id_seq OWNED BY public.nhomdongho_payment.id;


--
-- Name: pdm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pdm (
    id integer NOT NULL,
    ma_tim_dong_ho_pdm character varying(255),
    ten_dong_ho character varying(255) NOT NULL,
    noi_san_xuat character varying(255) NOT NULL,
    dn character varying(255),
    ccx character varying(255),
    kieu_sensor character varying(255) NOT NULL,
    transmitter character varying(255),
    qn character varying(255),
    q3 character varying(255),
    r character varying(255),
    don_vi_pdm character varying(255) NOT NULL,
    dia_chi character varying(255),
    so_qd_pdm character varying(255),
    ngay_qd_pdm timestamp without time zone,
    ngay_het_han timestamp without time zone,
    anh_pdm character varying(255)
);


ALTER TABLE public.pdm OWNER TO postgres;

--
-- Name: pdm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pdm_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pdm_id_seq OWNER TO postgres;

--
-- Name: pdm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pdm_id_seq OWNED BY public.pdm.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(64),
    "default" boolean,
    permissions integer
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: token_blacklist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist (
    id integer NOT NULL,
    jti character varying(36) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL
);


ALTER TABLE public.token_blacklist OWNER TO postgres;

--
-- Name: token_blacklist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_blacklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.token_blacklist_id_seq OWNER TO postgres;

--
-- Name: token_blacklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_blacklist_id_seq OWNED BY public.token_blacklist.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(64) NOT NULL,
    fullname character varying(100) NOT NULL,
    email character varying(120) NOT NULL,
    password_hash character varying(256) NOT NULL,
    role_id integer,
    confirmed boolean
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: dongho id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho ALTER COLUMN id SET DEFAULT nextval('public.dongho_id_seq'::regclass);


--
-- Name: dongho_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho_permissions ALTER COLUMN id SET DEFAULT nextval('public.dongho_permissions_id_seq'::regclass);


--
-- Name: nhomdongho_payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nhomdongho_payment ALTER COLUMN id SET DEFAULT nextval('public.nhomdongho_payment_id_seq'::regclass);


--
-- Name: pdm id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pdm ALTER COLUMN id SET DEFAULT nextval('public.pdm_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: token_blacklist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
4f4e929afc69
\.


--
-- Data for Name: dongho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dongho (id, group_id, ten_dong_ho, phuong_tien_do, seri_chi_thi, seri_sensor, kieu_chi_thi, kieu_sensor, kieu_thiet_bi, co_so_san_xuat, so_tem, nam_san_xuat, dn, d, ccx, q3, r, qn, k_factor, so_qd_pdm, ten_khach_hang, co_so_su_dung, noi_su_dung, vi_tri, noi_thuc_hien, phuong_phap_thuc_hien, chuan_thiet_bi_su_dung, nguoi_thuc_hien, nguoi_soat_lai, ngay_thuc_hien, hieu_luc_bien_ban, nhiet_do, do_am, du_lieu_kiem_dinh, so_giay_chung_nhan, last_updated, owner_id, ket_qua_check_vo_ngoai, ghi_chu_vo_ngoai, index, is_hieu_chuan, ma_quan_ly) FROM stdin;
38	AICHI1002100200171224111514	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử				SU100-KR-N	Điện tử	Actechna Global SDN.BHD. - Malaysia		\N	100	0.05	2	100	200			PDM 283-2015	PhuThai	Công ty Cổ phần Hệ thống đo Lưu lượng	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2024-12-17	\N	29	66	{"hieu_sai_so":[{"hss":11},{"hss":0},{"hss":1}],"du_lieu":{"Q3":{"value":100,"lan_chay":{"1":{"V1":"0.00","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.5,"Tc":22.5}}},"Q2":{"value":0.8,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.5,"Tc":22.5}}},"Q1":{"value":0,"lan_chay":{"1":{"V1":"0.11","V2":"1.12","Vc1":"1","Vc2":"2","Tdh":22.5,"Tc":22.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":false}		{"content": "T\\u1ea1o m\\u1edbi \\u0111\\u1ed3ng h\\u1ed3.", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-01-02T02:44:26.633702"}	\N	\N	\N	\N	f	\N
37	AICHI40225250261124102115	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	chithi_đạt	s_test_đạt		SU040-KR-n	Điện tử	Điện tử\tAichi Tokei Denki Co.,Ltd. - Nhật Bản	3a 123	\N	40	0.1	2	25	250			PDM 2272-2019	111	Công ty Cổ phần Công nghệ và Thương mại FMS	Công ty cổ phần nước sạch Vĩnh Phúc	234324	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	soát lại	2024-11-26	2027-11-30	25	50	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q1":{"value":0.1,"lan_chay":{"1":{"Tc":23.5,"Tdh":23.5,"V1":0,"V2":"100.0","Vc1":"0","Vc2":"100"}}},"Q2":{"value":0.16,"lan_chay":{"1":{"Tc":23.5,"Tdh":23.5,"V1":0,"V2":"10.0","Vc1":"0","Vc2":"10"}}},"Q3":{"value":25,"lan_chay":{"1":{"Tc":23.5,"Tdh":23.5,"V1":0,"V2":"100.0","Vc1":"0","Vc2":"100"}}},"Qmin":null,"Qn":null,"Qt":null},"ket_qua":true}	gcn	{"content": "Thay \\u0111\\u1ed5i gi\\u00e1 tr\\u1ecb: ", "updated_by": "Nguy\\u1ec5n Th\\u1ebf V\\u0169 - nguyenvu2605021@gmail.com - Viewer", "updated_at": "2024-12-25T04:26:20.997746"}	1	\N	\N	\N	f	\N
47	AICHI32210200070325121944	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	44	33	934857897	SU100-KR-N	Điện tử	ABB-Anh Quốc	555555	\N	32	1	2	10	200			\N	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2025-03-07	2026-03-31	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"mf":[{"mf":1},{"mf":1},{"mf":1}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"1","Tdh":22,"Tc":22}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"1","Tdh":22,"Tc":22}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"1","Tdh":22,"Tc":22}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	1232222	{"content": "Thay \\u0111\\u1ed5i gi\\u00e1 tr\\u1ecb: ", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-03-07T06:26:22.742958"}	\N	f		1	t	123123
39	AICHI32110200020125100000	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử		456	934857897	SU100-KR-N	Điện tử	ABB-Anh Quốc	4345	\N	32	0.05	1	10	200			PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	234324	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2025-01-02	2028-01-31	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23,"Tc":23}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23,"Tc":23}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23,"Tc":23}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	123	{"content": "T\\u1ea1o m\\u1edbi \\u0111\\u1ed3ng h\\u1ed3.", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-01-02T03:00:53.633020"}	\N	\N	\N	\N	f	\N
18	AICHI32210200291124120440	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	67843678	\N	1	\N	\N	\N	f	\N
19	AICHI32210200291124120440	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	4563456846	\N	1	\N	\N	\N	f	\N
46	AICHI32210200260225114644	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử			934857897	SU100-KR-N	Điện tử	ABB-Anh Quốc		\N	32	1	2	10	200		2222	\N	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2025-02-26	2026-02-28	29	66	{"hieu_sai_so":[{"hss":-50},{"hss":-50},{"hss":-50}],"mf":[{"mf":2},{"mf":2},{"mf":2}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Q2":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Q1":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":false}		{"content": "Thay \\u0111\\u1ed5i gi\\u00e1 tr\\u1ecb: Hi\\u1ec7u l\\u1ef1c bi\\u00ean b\\u1ea3n", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-03-07T06:20:37.982037"}	\N	f		1	t	123 234
48	AICHI32210200070325132908	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử		4545	934857897	SU100-KR-N	Điện tử	ABB-Anh Quốc	3433434	\N	32	1	2	10	200			\N	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2025-03-07	2026-03-31	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"mf":[{"mf":1},{"mf":1},{"mf":1}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"1","Tdh":22.8,"Tc":22.8}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"1","Tdh":22.8,"Tc":22.8}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"1","Tdh":22.8,"Tc":22.8}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	123232	{"content": "T\\u1ea1o m\\u1edbi \\u0111\\u1ed3ng h\\u1ed3.", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-03-07T06:29:50.833556"}	\N	f		1	t	2323423234
44	AICHI32210200260225104349	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	111	234234	934857897	SU100-KR-N	Điện tử	ABB-Anh Quốc	2345	\N	32	1	2	10	200		2345345	\N	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2025-02-26	2026-02-28	29	66	{"hieu_sai_so":[{"hss":-50},{"hss":-50},{"hss":-50}],"mf":[{"mf":2},{"mf":2},{"mf":2}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Q2":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Q1":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":false}	1232	{"content": "Thay \\u0111\\u1ed5i gi\\u00e1 tr\\u1ecb: D\\u1eef li\\u1ec7u ki\\u1ec3m \\u0111\\u1ecbnh", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-03-06T19:16:13.073303"}	\N	f	\N	1	t	123
2	AICHI1502400200171024170430	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V02323267	\N	\N	DS-TRP	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	3A	2024-10-17	10	0.1	2	400	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-17	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":400,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":1,"Vc2":2,"Tdh":0,"Tc":0}}},"Q2":{"value":3.2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":1,"Vc2":2,"Tdh":0,"Tc":0}}},"Q1":{"value":2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":1,"Vc2":2,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	011483	\N	1	\N	\N	\N	f	\N
45	AICHI32210200260225104349	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	00	788	934857897	SU100-KR-N	Điện tử	ABB-Anh Quốc		\N	32	1	2	10	200		7877	\N	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Super Administrator	nsl	2025-02-26	2026-02-28	29	66	{"hieu_sai_so":[{"hss":-50},{"hss":-50},{"hss":-50}],"mf":[{"mf":2},{"mf":2},{"mf":2}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Q2":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Q1":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"1","Vc1":"0","Vc2":"2","Tdh":23.4,"Tc":23.4}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":false}		{"content": "Thay \\u0111\\u1ed5i gi\\u00e1 tr\\u1ecb: D\\u1eef li\\u1ec7u ki\\u1ec3m \\u0111\\u1ecbnh", "updated_by": "Super Administrator - dht_superadmin@gmail.com - SuperAdministrator", "updated_at": "2025-03-06T19:16:13.336310"}	\N	f		2	t	\N
1	FUZHOUFUDA15B1.526112407000	FUZHOU FUDA	Đồng hồ đo nước lạnh cơ khí	\N	seri_fuzhou	\N	\N	Đa tia	Fuzhou Fuda Instrument & Meter Co., Ltd. (Trung Quốc)	t1	\N	15	0.05	B	\N	\N	1.5	\N	PDM 562-2016	Minh 	Công ty CP Đầu tư Minh Hòa	nsd	add	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	soát	2024-11-26	2029-11-30	24	58	{"hieu_sai_so":[{"hss":0.24},{"hss":-0.3},{"hss":0}],"du_lieu":{"Q1":null,"Q2":null,"Q3":null,"Qmin":{"value":0.03,"lan_chay":{"1":{"Tc":23.7,"Tdh":23.7,"V1":"20.00","V2":"30.00","Vc1":"0","Vc2":"10"}}},"Qn":{"value":1.5,"lan_chay":{"1":{"Tc":23.7,"Tdh":23.7,"V1":"0.00","V2":"100.12","Vc1":"0","Vc2":"100"},"2":{"Tc":23.7,"Tdh":23.7,"V1":"100.12","V2":"200.00","Vc1":"0","Vc2":"100"}}},"Qt":{"value":0.12,"lan_chay":{"1":{"Tc":23.7,"Tdh":23.7,"V1":0,"V2":"10.00","Vc1":"0","Vc2":"10.02"},"2":{"Tc":23.7,"Tdh":23.7,"V1":"10.00","V2":"20.01","Vc1":"0","Vc2":"10"}}}},"ket_qua":true}	gaiy1	\N	1	\N	\N	\N	f	\N
6	AICHI50240200181124093231	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V01412	\N	\N	SU050-KR	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	T1	\N	50	0.1	2	40	200	\N	\N	PDM 527-2017	Phú 	Công ty Cổ phần Công nghệ và Thương mại FMS	Cấp nước Hải Dương	add	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Tài	Đăng	2024-11-18	2027-11-29	27	74	{"hieu_sai_so":[{"hss":-0.079},{"hss":0},{"hss":-0.393}],"du_lieu":{"Q3":{"value":40,"lan_chay":{"1":{"V1":"6047.6","V2":"7090.9","Vc1":5813.7,"Vc2":6852.4,"Tdh":25,"Tc":25},"2":{"V1":"7090.9","V2":"8111.0","Vc1":6852.4,"Vc2":7867.2,"Tdh":25,"Tc":25}}},"Q2":{"value":0.32,"lan_chay":{"1":{"V1":"0.1","V2":"1.1","Vc1":0,"Vc2":1,"Tdh":25,"Tc":25}}},"Q1":{"value":0.2,"lan_chay":{"1":{"V1":"8111.0","V2":"8161.7","Vc1":7867.2,"Vc2":7918.1,"Tdh":25,"Tc":25}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	giấy 1	\N	1	\N	\N	\N	f	\N
7	AICHI32210200181124082940	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	\N	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	6788	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-18	2027-11-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":-1},{"hss":-1.802}],"du_lieu":{"Q1":{"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"2.34","V2":"3.43","Vc1":5.87,"Vc2":6.98}},"value":0.05},"Q2":{"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"1.23","V2":"2.22","Vc1":7.89,"Vc2":8.89}},"value":0.08},"Q3":{"value":10,"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"1.23","V2":"2.33","Vc1":6.78,"Vc2":7.88}}},"Qmin":null,"Qn":null,"Qt":null},"ket_qua":true}	789	\N	1	\N	\N	\N	f	\N
8	AICHI32210200291124112752	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	2323	\N	1	\N	\N	\N	f	\N
9	AICHI32210200291124112752	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	45454	\N	1	\N	\N	\N	f	\N
10	AICHI32210200291124112752	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	234545	\N	1	\N	\N	\N	f	\N
11	AICHI32210200291124112752	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.5,"Tc":23.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	12323623\t	\N	1	\N	\N	\N	f	\N
12	AICHI32210200291124114417	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	m,yuj7	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	2027-11-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.8,"Tc":23.8}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.8,"Tc":23.8}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.8,"Tc":23.8}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	2435645345	\N	1	\N	\N	\N	f	\N
13	AICHI32210200291124114417	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	hk56u456	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	2027-11-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.8,"Tc":23.8}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.8,"Tc":23.8}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":23.8,"Tc":23.8}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	768757gngh	\N	1	\N	\N	\N	f	\N
14	AICHI32210200291124115505	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	2344546234	\N	1	\N	\N	\N	f	\N
15	AICHI32210200291124115505	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	7455678452	\N	1	\N	\N	\N	f	\N
16	AICHI32210200291124115505	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.4,"Tc":22.4}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	23478567234	\N	1	\N	\N	\N	f	\N
17	AICHI32210200291124120440	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":22.2,"Tc":22.2}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	234465435	\N	1	\N	\N	\N	f	\N
20	AICHI32210200291124121141	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":24.7,"Tc":24.7}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":24.7,"Tc":24.7}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":24.7,"Tc":24.7}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	345dsf345	\N	1	\N	\N	\N	f	\N
21	AICHI32210200291124121141	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	934857897	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	\N	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty cổ phần nước sạch Vĩnh Phúc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	nsl	2024-11-29	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":24.7,"Tc":24.7}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":24.7,"Tc":24.7}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":"0.11","V2":"1.11","Vc1":"0","Vc2":"1","Tdh":24.7,"Tc":24.7}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	567dfgyui43	\N	1	\N	\N	\N	f	\N
22	AICHI1502400200171024170430	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V023232671	\N	\N	DS-TRP	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	3A 	2024-10-17	10	0.1	2	400	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-17	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":400,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":3.2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	011484	\N	1	\N	\N	\N	f	\N
23	AICHI1502400200171024170430	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V0232326712	\N	\N	DS-TRP	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	3A 	2024-10-17	10	0.1	2	400	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-17	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":400,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":3.2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	011485	\N	1	\N	\N	\N	f	\N
24	AICHI1502400200221024094243	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	\N	\N	\N	SU100-KR-N	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	3A 	2024-10-22	150	0.1	2	400	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-22	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":10},{"hss":10}],"du_lieu":{"Q3":{"value":400,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":3.2,"lan_chay":{"1":{"V1":0,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":2,"lan_chay":{"1":{"V1":0,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	011486	\N	1	\N	\N	\N	f	\N
25	APATOR100216020023112410575	Apator	Đồng hồ đo nước lạnh có cơ cấu điện tử	78954392	\N	\N	MWN100-08	Điện tử	Điện tử\tApator Powogaz S.A. - Ba Lan	3A 589305	\N	100	0.5	2	160	200	\N	\N	PDM 2435-2020	Sơn 	Công ty TNHH Công nghệ Sơn Nguyên	Công ty cổ phần nước sạch Vĩnh Phúc	\N	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-23	2027-11-29	13	56	{"hieu_sai_so":[{"hss":0.351},{"hss":1.272},{"hss":0.234}],"du_lieu":{"Q3":{"value":160,"lan_chay":{"1":{"V1":"12332.4","V2":"14954.5","Vc1":"111.5","Vc2":"2782.1","Tdh":22.5,"Tc":22.5},"2":{"V1":"14954.5","V2":"22384.1","Vc1":"2782.1","Vc2":"10376.3","Tdh":22.5,"Tc":22.5}}},"Q2":{"value":1.28,"lan_chay":{"1":{"V1":"14523.4","V2":"14626.9","Vc1":"0","Vc2":"102.2","Tdh":22.5,"Tc":22.5}}},"Q1":{"value":0.8,"lan_chay":{"1":{"V1":"645.3","V2":"1647.3","Vc1":"0","Vc2":"1012.6","Tdh":22.5,"Tc":22.5},"2":{"V1":"1647.3","V2":"3366.4","Vc1":"1012.6","Vc2":"2754","Tdh":22.5,"Tc":22.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	000784	\N	1	\N	\N	\N	f	\N
34	APATOR100216020023112410575	Apator	Đồng hồ đo nước lạnh có cơ cấu điện tử	78954388	\N	\N	MWN100-08	Điện tử	Điện tử\tApator Powogaz S.A. - Ba Lan	3A 589306	\N	100	0.5	2	160	200	\N	\N	PDM 2435-2020	Sơn 	Công ty TNHH Công nghệ Sơn Nguyên	Công ty cổ phần nước sạch Vĩnh Phúc	\N	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-23	2027-11-29	13	56	{"hieu_sai_so":[{"hss":1.445},{"hss":-1.174},{"hss":-0.365}],"du_lieu":{"Q3":{"value":160,"lan_chay":{"1":{"V1":"349.5","V2":"3058.7","Vc1":"111.5","Vc2":"2782.1","Tdh":22.5,"Tc":22.5}}},"Q2":{"value":1.28,"lan_chay":{"1":{"V1":"123.5","V2":"224.5","Vc1":"0","Vc2":"102.2","Tdh":22.5,"Tc":22.5}}},"Q1":{"value":0.8,"lan_chay":{"1":{"V1":"2347.5","V2":"3356.4","Vc1":"0","Vc2":"1012.6","Tdh":22.5,"Tc":22.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	000785\t	\N	1	\N	\N	\N	f	\N
26	AICHI1502400200151024120430	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V02323	\N	\N	SU150-KR	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	3A 598087	2024-10-15	150	0.1	2	400	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-08-08	2027-10-30	29	66	{"du_lieu": {"Q1": {"lan_chay": {"1": {"Tc": 0,"Tdh": 0,"V1": 45874.9,"V2": 45974.3,"Vc1": 0,"Vc2": 102.7},"2": {"Tc": 0,"Tdh": 0,"V1": 45974.3,"V2": 46075.3,"Vc1": 0,"Vc2": 104.3}},"value": 2},"Q2": {"lan_chay": {"1": {"Tc": 0,"Tdh": 0,"V1": 45639.7,"V2": 45739.5,"Vc1": 0,"Vc2": 101.5},"2": {"Tc": 0,"Tdh": 0,"V1": 45739.5,"V2": 45839.9,"Vc1": 0,"Vc2": 102.2}},"value": 3.2},"Q3": {"lan_chay": {"1": {"Tc": 0,"Tdh": 0,"V1": 228.7,"V2": 19351.6,"Vc1": 197.7,"Vc2": 19492.3},"2": {"Tc": 0,"Tdh": 0,"V1": 19351.6,"V2": 45517.9,"Vc1": 19492.3,"Vc2": 45904.2}},"value": 400},"Qmin": null,"Qn": null,"Qt": null},"hieu_sai_so": [{"hss": 0.04},{"hss": 0.086},{"hss": -0.049}],"ket_qua": true}	011482	\N	1	\N	\N	\N	f	\N
27	FUZHOUFUDA40B10031024102928	FUZHOU FUDA	Đồng hồ đo nước lạnh cơ khí	240440	\N	\N	LXS-40E	Đa tia	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	3a 605254	\N	40	0.5	B	\N	\N	10	\N	PDM 877-2016	Minh 	Công ty CP Đầu tư Minh Hòa	cty Minh Hòa	\N	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Tài	Đăng	2024-10-03	2029-10-31	27	42	{"hieu_sai_so":[{"hss":-0.174},{"hss":-1.911},{"hss":1.365}],"du_lieu":{"Q1":null,"Q2":null,"Q3":null,"Qmin":{"value":0.2,"lan_chay":{"1":{"Tc":23.6,"Tdh":23.6,"V1":"174.0","V2":"278.0","Vc1":"121.6","Vc2":"224.2"}}},"Qn":{"value":10,"lan_chay":{"1":{"Tc":23.6,"Tdh":23.6,"V1":"52.5","V2":"522.0","Vc1":8003.2,"Vc2":8470.8},"2":{"Tc":23.6,"Tdh":23.6,"V1":"522.0","V2":"1076.5","Vc1":8470.8,"Vc2":9022.1}}},"Qt":{"value":0.8,"lan_chay":{"1":{"Tc":23.6,"Tdh":23.6,"V1":"1076.5","V2":"1174.0","Vc1":"9022.1","Vc2":"9121.5"}}}},"ket_qua":false}	giấy 4	\N	1	\N	\N	\N	f	\N
28	FUZHOUFUDA15B1.526112407000	FUZHOU FUDA	Đồng hồ đo nước lạnh cơ khí	\N	\N	\N	\N	Đa tia	Fuzhou Fuda Instrument & Meter Co., Ltd. (Trung Quốc)	t2	\N	15	0.05	B	\N	\N	1.5	\N	PDM 562-2016	Minh 	Công ty CP Đầu tư Minh Hòa	nsd	add	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	soát	2024-11-26	2029-11-30	24	58	{"hieu_sai_so":[{"hss":-0.89},{"hss":-0.4},{"hss":-0.02}],"du_lieu":{"Q1":null,"Q2":null,"Q3":null,"Qmin":{"value":0.03,"lan_chay":{"1":{"Tc":23.7,"Tdh":23.7,"V1":"1.23","V2":"101.23","Vc1":"0","Vc2":"100.02"}}},"Qn":{"value":1.5,"lan_chay":{"1":{"Tc":23.7,"Tdh":23.7,"V1":"1.23","V2":"101.24","Vc1":"0","Vc2":"100"},"2":{"Tc":23.7,"Tdh":23.7,"V1":"101.24","V2":"202.14","Vc1":"0","Vc2":"100"}}},"Qt":{"value":0.12,"lan_chay":{"1":{"Tc":23.7,"Tdh":23.7,"V1":"0.00","V2":"10.00","Vc1":"0","Vc2":"10.02"},"2":{"Tc":23.7,"Tdh":23.7,"V1":"10.00","V2":"20.02","Vc1":"0","Vc2":"10"}}}},"ket_qua":true}	\N	\N	1	\N	\N	\N	f	\N
29	AICHI1502400200221024094243	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V02323245333333	\N	\N	SU100-KR-N	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	3A 	2024-10-22	150	0.1	2	400	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-22	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":10},{"hss":0}],"du_lieu":{"Q3":{"value":400,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":3.2,"lan_chay":{"1":{"V1":0,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":2,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":false}	011487	\N	1	\N	\N	\N	f	\N
31	AICHI10210200311024140406	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V02323245111	\N	\N	SU100-KR-N	Điện tử	Maddalena-PhuThai	3A 59808	2024-10-31	10	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-31	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0.11,"V2":1.11,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":0.11,"V2":1.11,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":0.11,"V2":1.11,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	01148222\t	\N	1	\N	\N	\N	f	\N
33	FUZHOUFUDA40B10031024102928	FUZHOU FUDA	Đồng hồ đo nước lạnh cơ khí	2308040	\N	\N	LXS-40E	Đa tia	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	3A 605253	\N	40	0.5	B	\N	\N	10	\N	PDM 877-2016	Minh 	Công ty CP Đầu tư Minh Hòa	cty Minh Hòa	\N	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Tài	Đăng	2024-10-03	2029-10-31	27	42	{"hieu_sai_so":[{"hss":0.372},{"hss":-1.042},{"hss":-1.563}],"du_lieu":{"Q1":null,"Q2":null,"Q3":null,"Qmin":{"lan_chay":{"1":{"Tc":23.6,"Tdh":23.6,"V1":"428.5","V2":"460.0","Vc1":"0","Vc2":"32"}},"value":0.4},"Qn":{"value":10,"lan_chay":{"1":{"Tc":23.6,"Tdh":23.6,"V1":"202.0","V2":"715.0","Vc1":4938.9,"Vc2":5450}}},"Qt":{"lan_chay":{"1":{"Tc":23.6,"Tdh":23.6,"V1":"315.5","V2":"363.0","Vc1":"49.5","Vc2":"97.5"}},"value":1}},"ket_qua":true}	giấy 3\t	\N	1	\N	\N	\N	f	\N
35	APATOR100216020023112410575	Apator	Đồng hồ đo nước lạnh có cơ cấu điện tử	78954394	\N	\N	MWN100-08	Điện tử	Điện tử\tApator Powogaz S.A. - Ba Lan	3A 589307	\N	100	0.5	2	160	200	\N	\N	PDM 2435-2020	Sơn 	Công ty TNHH Công nghệ Sơn Nguyên	Công ty cổ phần nước sạch Vĩnh Phúc	\N	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-23	2027-11-29	13	56	{"hieu_sai_so":[{"hss":-1.165},{"hss":0.587},{"hss":0.059}],"du_lieu":{"Q3":{"value":160,"lan_chay":{"1":{"V1":"734.8","V2":"3374.3","Vc1":"111.5","Vc2":"2782.1","Tdh":22.5,"Tc":22.5}}},"Q2":{"value":1.28,"lan_chay":{"1":{"V1":"1234.5","V2":"1337.3","Vc1":"0","Vc2":"102.2","Tdh":22.5,"Tc":22.5}}},"Q1":{"value":0.8,"lan_chay":{"1":{"V1":"1232.5","V2":"2345.7","Vc1":"0","Vc2":"1012.6","Tdh":22.5,"Tc":22.5}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	000786\t	\N	1	\N	\N	\N	f	\N
36	AICHI40225250261124102115	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	chithi_ko 	s_test_ko đạt	\N	SU040-KR-n	Điện tử	Điện tử\tAichi Tokei Denki Co.,Ltd. - Nhật Bản	\N	\N	40	0.1	2	25	250	\N	\N	PDM 2272-2019	111	Công ty Cổ phần Công nghệ và Thương mại FMS	\N	\N	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	soát lại	2024-11-26	\N	25	50	{"hieu_sai_so":[{"hss":0},{"hss":-2.439},{"hss":-5.66}],"du_lieu":{"Q3":{"value":25,"lan_chay":{"1":{"V1":0,"V2":"100.0","Vc1":"0","Vc2":"100","Tdh":23.5,"Tc":23.5}}},"Q2":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"4.0","Vc1":"0","Vc2":"4.1","Tdh":23.5,"Tc":23.5}}},"Q1":{"value":0,"lan_chay":{"1":{"V1":0,"V2":"10.0","Vc1":"0","Vc2":"10.6","Tdh":23.5,"Tc":23.5}}},"Qn":null,"Qt":null,"Qmin":null,"Q":{"value":16,"lan_chay":{"1":{"V1":"11.1","V2":0,"Vc1":"0","Vc2":"0","Tdh":22.4,"Tc":22.4}}}},"ket_qua":false}	\N	\N	1	\N	\N	\N	f	\N
32	AICHI32210200061124115853	Aichi	Đồng hồ đo nước lạnh cơ khí	\N	\N	\N	SU100-KR-N	Điện tử	Maddalena-PhuThai	\N	2024-11-06	32	0.1	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-06	\N	29	66	{"hieu_sai_so":[{"hss":0},{"hss":10},{"hss":10}],"du_lieu":{"Q3":{"value":400,"lan_chay":{"1":{"V1":0.1,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":3.2,"lan_chay":{"1":{"V1":0,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":2,"lan_chay":{"1":{"V1":0,"V2":1.1,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	\N	\N	4	\N	\N	\N	f	\N
3	AICHI32210200181124082940	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	\N	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	5677	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-18	2027-11-30	29	66	{"hieu_sai_so":[{"hss":-0.909},{"hss":-1},{"hss":-1.802}],"du_lieu":{"Q1":{"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"2.34","V2":"3.43","Vc1":5.87,"Vc2":6.98}},"value":0.05},"Q2":{"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"1.23","V2":"2.22","Vc1":7.89,"Vc2":8.89}},"value":0.08},"Q3":{"value":10,"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"1.23","V2":"2.32","Vc1":6.78,"Vc2":7.88}}},"Qmin":null,"Qn":null,"Qt":null},"ket_qua":true}	678	\N	1	\N	\N	\N	f	\N
4	AICHI32210200181124082940	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	\N	\N	\N	SU100-KR-N	Điện tử	ABB-Anh Quốc	4566	\N	32	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	abc	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	Công ty Cổ phần Công nghệ và Thương mại FMS	FMS - PP - 02	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-11-18	2027-11-30	29	66	{"hieu_sai_so":[{"hss":-1.818},{"hss":-1},{"hss":-1.802}],"du_lieu":{"Q1":{"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"2.34","V2":"3.43","Vc1":5.87,"Vc2":6.98}},"value":0.05},"Q2":{"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"1.23","V2":"2.22","Vc1":7.89,"Vc2":8.89}},"value":0.08},"Q3":{"value":10,"lan_chay":{"1":{"Tc":25,"Tdh":25,"V1":"1.23","V2":"2.31","Vc1":6.78,"Vc2":7.88}}},"Qmin":null,"Qn":null,"Qt":null},"ket_qua":true}	345	\N	1	\N	\N	\N	f	\N
5	AICHI50240200181124093231	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V01411	\N	\N	SU050-KR	Điện tử	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	Tem 2	\N	50	0.1	2	40	200	\N	\N	PDM 527-2017	Phú 	Công ty Cổ phần Công nghệ và Thương mại FMS	Cấp nước Hải Dương	add	Công ty Cổ phần Công nghệ và Thương mại FMS	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Tài	Đăng	2024-11-18	2027-11-29	27	74	{"hieu_sai_so":[{"hss":-0.087},{"hss":0},{"hss":-0.982}],"du_lieu":{"Q3":{"value":40,"lan_chay":{"1":{"V1":"1628.3","V2":"2670.7","Vc1":5813.7,"Vc2":6852.4,"Tdh":25,"Tc":25},"2":{"V1":"2670.7","V2":"3690.0","Vc1":6852.4,"Vc2":7867.2,"Tdh":25,"Tc":25}}},"Q2":{"value":0.32,"lan_chay":{"1":{"V1":"0.1","V2":"1.1","Vc1":0,"Vc2":1,"Tdh":25,"Tc":25}}},"Q1":{"value":0.2,"lan_chay":{"1":{"V1":"3690.0","V2":"3740.4","Vc1":7867.2,"Vc2":7918.1,"Tdh":25,"Tc":25}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	Giấy 2	\N	1	\N	\N	\N	f	\N
30	AICHI10210200311024140406	Aichi	Đồng hồ đo nước lạnh có cơ cấu điện tử	V023232451111222	\N	\N	SU100-KR-N	Điện tử	Maddalena-PhuThai	3A 598087a	2024-10-31	10	0.05	2	10	200	\N	\N	PDM 523-2017	PhuThai	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Công ty Cổ phần Công nghệ và Thương mại FMS	CÔNG TY CỔ PHẦN ĐẦU TƯ THƯƠNG MẠI XUẤT NHẬP KHẨU PHÚ THÁI	\N	ĐLVN 17 : 2017	Đồng hồ chuẩn đo nước và Bình chuẩn	Admin đây	NGUYỄN HẢI ĐĂNG	2024-10-31	2027-10-30	29	66	{"hieu_sai_so":[{"hss":0},{"hss":0},{"hss":0}],"du_lieu":{"Q3":{"value":10,"lan_chay":{"1":{"V1":0.11,"V2":1.11,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q2":{"value":0.08,"lan_chay":{"1":{"V1":0.11,"V2":1.11,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Q1":{"value":0.05,"lan_chay":{"1":{"V1":0.11,"V2":1.11,"Vc1":0,"Vc2":1,"Tdh":0,"Tc":0}}},"Qn":null,"Qt":null,"Qmin":null},"ket_qua":true}	2s	\N	1	\N	\N	\N	f	\N
\.


--
-- Data for Name: dongho_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dongho_permissions (id, role_id, dongho_id, username, manager) FROM stdin;
30	4	26	user	user
36	4	32	user	user
26	4	22	admin	admin
5	2	1	vuvuvuvvv	admin
32	4	28	admin	admin
33	4	29	admin	admin
3	6	1	user	admin
7	4	2	admin	admin
8	4	3	admin	admin
9	4	5	admin	admin
10	4	6	admin	admin
11	4	7	admin	admin
12	4	8	admin	admin
13	4	9	admin	admin
14	4	10	admin	admin
15	4	11	admin	admin
16	4	12	admin	admin
17	4	13	admin	admin
18	4	14	admin	admin
19	4	15	admin	admin
20	4	16	admin	admin
21	4	17	admin	admin
22	4	18	admin	admin
23	4	19	admin	admin
24	4	20	admin	admin
25	4	21	admin	admin
49	3	36	user	admin
50	2	37	user	admin
28	4	24	admin	admin
29	4	25	admin	admin
31	4	27	admin	admin
51	2	36	hoangtrithao	admin
52	2	27	hoangtrithao	admin
34	4	30	admin	admin
35	4	31	admin	admin
37	4	33	admin	admin
38	4	34	admin	admin
39	4	35	admin	admin
40	4	36	admin	admin
41	4	37	admin	admin
42	4	4	admin	admin
53	3	33	hoangtrithao	admin
6	4	1	admin	admin
54	6	37	hoangtrithao	vuvuvuvvv
55	5	38	dht_superadmin	dht_superadmin
56	5	39	dht_superadmin	dht_superadmin
57	5	44	dht_superadmin	dht_superadmin
58	5	45	dht_superadmin	dht_superadmin
59	5	46	dht_superadmin	dht_superadmin
60	5	47	dht_superadmin	dht_superadmin
61	5	48	dht_superadmin	dht_superadmin
27	4	23	user	admin
\.


--
-- Data for Name: nhomdongho_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nhomdongho_payment (id, group_id, is_paid, paid_date, payment_collector, last_updated) FROM stdin;
2	AICHI1502400200171024170430	t	\N	Unknown	\N
3	AICHI32210200061124115853	t	\N	Unknown	\N
4	AICHI1502400200221024094243	t	\N	Unknown	\N
1	AICHI10210200311024140406	t	\N	Unknown	\N
5	AICHI40225250261124102115	t	\N	Admin Nguyễn	{"content": "Chuy\\u1ec3n tr\\u1ea1ng th\\u00e1i \\u0111\\u00e3", "updated_by": "Admin Nguy\\u1ec5n - admin2@gmail.com - Administrator", "updated_at": "2024-12-26T04:14:30.682842"}
\.


--
-- Data for Name: pdm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pdm (id, ma_tim_dong_ho_pdm, ten_dong_ho, noi_san_xuat, dn, ccx, kieu_sensor, transmitter, qn, q3, r, don_vi_pdm, dia_chi, so_qd_pdm, ngay_qd_pdm, ngay_het_han, anh_pdm) FROM stdin;
1	AICHI1002SU100-KR-N100200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	100	2	SU100-KR-N			100	200	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 283	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
2	AICHI502SU050-KR-N40400	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	50	2	SU050-KR-N			40	400	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 285	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
3	AICHI1002SU100-KR-N100400	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	100	2	SU100-KR-N			100	400	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 286	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
4	AICHI1502SU150-KR-N400400	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	150	2	SU150-KR-N			400	400	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 287	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
5	AICHI1002SU100-KR100200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	100	2	SU100-KR			100	200	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 289	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
6	AICHI502SU050-KR40400	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	50	2	SU050-KR			40	400	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 291	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
7	AICHI1002SU100-KR100400	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	100	2	SU100-KR			100	400	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 292	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
8	AICHI1502SU150-KR400400	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	150	2	SU150-KR			400	400	Công ty Cổ phần Hệ thống đo Lưu lượng	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 293	2015-03-30 00:00:00	2025-03-30 00:00:00	\N
9	AICHI652SU065-KR-N63200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	65	2	SU065-KR-N			63	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2204	2016-10-28 00:00:00	2026-10-31 00:00:00	\N
10	AICHI802SU080-KR-N100200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	80	2	SU080-KR-N			100	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2205	2016-10-28 00:00:00	2026-10-31 00:00:00	\N
11	AICHI1002SU100-KR-N160200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	100	2	SU100-KR-N			160	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2206	2016-10-28 00:00:00	2026-10-31 00:00:00	\N
12	AICHI652SU065-KR63200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	65	2	SU065-KR			63	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2207	2016-10-28 00:00:00	2026-10-31 00:00:00	\N
13	AICHI802SU080-KR100200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	80	2	SU080-KR			100	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2208	2016-10-28 00:00:00	2026-10-31 00:00:00	\N
14	AICHI1002SU100-KR160200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	100	2	SU100-KR			160	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2209	2016-10-28 00:00:00	2026-10-31 00:00:00	\N
15	AICHI502SU050-KR-N40200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	50	2	SU050-KR-N			40	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 522	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
16	AICHI1502SU150-KR-N400200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	150	2	SU150-KR-N			400	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 523	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
17	AICHI2002SU200-KR-N630200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	200	2	SU200-KR-N			630	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 524	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
18	AICHI2502SU250-KR-N1000200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	250	2	SU250-KR-N			1000	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 525	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
19	AICHI3002SU300-KR-N1000200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	300	2	SU300-KR-N			1000	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 526	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
20	AICHI502SU050-KR40200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	50	2	SU050-KR			40	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 527	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
21	AICHI1502SU150-KR400200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	150	2	SU150-KR			400	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 528	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
22	AICHI2002SU200-KR630200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	200	2	SU200-KR			630	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 529	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
23	AICHI2502SU250-KR1000200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	250	2	SU250-KR			1000	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 530	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
24	AICHI3002SU300-KR1000200	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	300	2	SU300-KR			1000	200	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 531	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
25	AICHI15CSD15SN1.5	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	15	C	SD15SN		1.5			Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 532	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
26	AICHI15CSD15SD1.5	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	15	C	SD15SD		1.5			Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 533	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
284	NINGBO200BLXLC-200200	Ningbo 	Ningbo Yonggang Instrument Co., Ltd. - Trung Quốc	200	B	LXLC-200		200			Công ty TNHH Bảo Gia		PDM 1652	2015-11-06 00:00:00	2025-11-30 00:00:00	\N
27	AICHI402SU040-KR-N25250	Aichi	Aichi Tokei Denki Co.,Ltd. - Nhật Bản	40	2	SU040-KR-N			25	250	Công ty Cổ phần Công nghệ và Thương mại FMS	Lô 11, số 10 đường Kim Mã Thượng, p.Cống Vị, Q.Ba Đình, tp.Hà Nội	PDM 2272	2019-05-24 00:00:00	2029-05-30 00:00:00	\N
28	APATOR152JS2.5-022.5100	Apator	Apator Powogaz S.A. - Ba Lan	15	2	JS2.5-02			2.5	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2431	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
29	APATOR152JS2.5-022.550	Apator	Apator Powogaz S.A. - Ba Lan	15	2	JS2.5-02			2.5	50	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2431	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
30	APATOR152JS2.5-022.5160	Apator	Apator Powogaz S.A. - Ba Lan	15	2	JS2.5-02			2.5	160	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2432	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
31	APATOR152JS2.5-022.563	Apator	Apator Powogaz S.A. - Ba Lan	15	2	JS2.5-02			2.5	63	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2432	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
32	APATOR502MWN50-0840100	Apator	Apator Powogaz S.A. - Ba Lan	50	2	MWN50-08			40	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2433	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
33	APATOR802MWN80-08100160	Apator	Apator Powogaz S.A. - Ba Lan	80	2	MWN80-08			100	160	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2434	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
34	APATOR1002MWN100-08160200	Apator	Apator Powogaz S.A. - Ba Lan	100	2	MWN100-08			160	200	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2435	2020-11-17 00:00:00	2030-10-30 00:00:00	\N
35	APATOR652MWN65-0863125	Apator	Apator Powogaz S.A. - Ba Lan	65	2	MWN65-08			63	125	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 268	2021-01-27 00:00:00	2031-01-30 00:00:00	\N
36	APATOR1502MWN150-08400200	Apator	Apator Powogaz S.A. - Ba Lan	150	2	MWN150-08			400	200	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 269	2021-01-27 00:00:00	2031-01-30 00:00:00	\N
37	APATOR2002MWN200-08630125	Apator	Apator Powogaz S.A. - Ba Lan	200	2	MWN200-08			630	125	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 270	2021-01-27 00:00:00	2031-01-30 00:00:00	\N
38	APATOR202JS4-024100	Apator	Apator Powogaz S.A. - Ba Lan	20	2	JS4-02			4	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2920	2021-09-14 00:00:00	2031-09-30 00:00:00	\N
39	APATOR252JS6.3-086.3100	Apator	Apator Powogaz S.A. - Ba Lan	25	2	JS6.3-08			6.3	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2921	2021-09-14 00:00:00	2031-09-30 00:00:00	\N
40	APATOR322JS10-0810100	Apator	Apator Powogaz S.A. - Ba Lan	32	2	JS10-08			10	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2922	2021-09-14 00:00:00	2031-09-30 00:00:00	\N
41	APATOR402JS16-0816100	Apator	Apator Powogaz S.A. - Ba Lan	40	2	JS16-08			16	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 2923	2021-09-14 00:00:00	2031-09-30 00:00:00	\N
42	APATOR1252MWN125-08250160	Apator	Apator Powogaz S.A. - Ba Lan	125	2	MWN125-08			250	160	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 3950	2021-11-04 00:00:00	2031-11-30 00:00:00	\N
43	APATOR2502MWN250-081000100	Apator	Apator Powogaz S.A. - Ba Lan	250	2	MWN250-08			1000	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 355	2022-01-27 00:00:00	2032-01-30 00:00:00	\N
44	APATOR3002MWN300-081600125	Apator	Apator Powogaz S.A. - Ba Lan	300	2	MWN300-08			1600	125	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 356	2022-01-27 00:00:00	2032-01-30 00:00:00	\N
45	APATOR252JS6.3-076.3100	Apator	Apator Powogaz S.A. - Ba Lan	25	2	JS6.3-07			6.3	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 1079	2024-05-10 00:00:00	2034-05-30 00:00:00	\N
46	APATOR322JS10-0710100	Apator	Apator Powogaz S.A. - Ba Lan	32	2	JS10-07			10	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 1080	2024-05-10 00:00:00	2034-05-30 00:00:00	\N
47	APATOR402JS16-0716100	Apator	Apator Powogaz S.A. - Ba Lan	40	2	JS16-07			16	100	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 1081	2024-05-10 00:00:00	2034-05-30 00:00:00	\N
48	APATOR202JS4-054200	Apator	Apator Powogaz S.A. - Ba Lan	20	2	JS4-05			4	200	Công ty TNHH Công nghệ Sơn Nguyên	Phòng 603 số 70 ngõ 165 Xuân Thủy, p.Dịch Vọng Hậu, q.Cầu Giấy, tp.Hà Nội	PDM 604	2023-03-03 00:00:00	2032-03-30 00:00:00	\N
49	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	50	B	WPH/MWN		12			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
50	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	65	B	WPH/MWN		25			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
51	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	80	B	WPH/MWN		40			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
52	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	100	B	WPH/MWN		60			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
53	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	125	B	WPH/MWN		100			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
54	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	150	B	WPH/MWN		150			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
55	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	200	B	WPH/MWN		250			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
56	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	250	B	WPH/MWN		400			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
57	Hết hạn	Powogaz-Metcon	Apator Powogaz group S.A. - Ba Lan	300	B	WPH/MWN		600			Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	2467/QĐ-TĐC	2014-12-31 00:00:00	2023-10-30 00:00:00	\N
58	APATOR402WPH/MWN25100	Apator	Apator Powogaz S.A. - Ba Lan	40	2	WPH/MWN			25	100	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1777	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
59	APATOR502WPH/MWN40100	Apator	Apator Powogaz S.A. - Ba Lan	50	2	WPH/MWN			40	100	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1778	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
60	APATOR652WPH/MWN63125	Apator	Apator Powogaz S.A. - Ba Lan	65	2	WPH/MWN			63	125	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1779	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
61	APATOR802WPH/MWN100160	Apator	Apator Powogaz S.A. - Ba Lan	80	2	WPH/MWN			100	160	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1780	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
62	APATOR1002WPH/MWN160200	Apator	Apator Powogaz S.A. - Ba Lan	100	2	WPH/MWN			160	200	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1781	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
63	APATOR1252WPH/MWN250160	Apator	Apator Powogaz S.A. - Ba Lan	125	2	WPH/MWN			250	160	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1782	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
64	APATOR1502WPH/MWN400200	Apator	Apator Powogaz S.A. - Ba Lan	150	2	WPH/MWN			400	200	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1783	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
65	APATOR2002WPH/MWN630125	Apator	Apator Powogaz S.A. - Ba Lan	200	2	WPH/MWN			630	125	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1784	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
66	APATOR2502WPH/MWN1000100	Apator	Apator Powogaz S.A. - Ba Lan	250	2	WPH/MWN			1000	100	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1785	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
67	APATOR3002WPH/MWN1600125	Apator	Apator Powogaz S.A. - Ba Lan	300	2	WPH/MWN			1600	125	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1786	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
68	APATOR50/202MPV/MWN2563	Apator	Apator Powogaz S.A. - Ba Lan	50/20	2	MPV/MWN			25	63	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1787	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
69	APATOR65/202MPV/MWN4080	Apator	Apator Powogaz S.A. - Ba Lan	65/20	2	MPV/MWN			40	80	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1788	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
70	APATOR80/202MPV/MWN63100	Apator	Apator Powogaz S.A. - Ba Lan	80/20	2	MPV/MWN			63	100	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1789	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
71	APATOR100/202MPV/MWN100125	Apator	Apator Powogaz S.A. - Ba Lan	100/20	2	MPV/MWN			100	125	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1790	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
72	APATOR150/402MPV/MWN250125	Apator	Apator Powogaz S.A. - Ba Lan	150/40	2	MPV/MWN			250	125	Công ty TNHH Thiết bị Đo lường Điều khiển và Kiểm nghiệm	Số 9 Lai Xá, xã Kim Chung, huyện Hoài Đức, tp.Hà Nội	PDM 1791	2017-05-10 00:00:00	2027-05-30 00:00:00	\N
73	APATOR152MTK-AM2.580	Apator	Apator Powogaz S.A. - Ba Lan	15	2	MTK-AM			2.5	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 791	2019-03-04 00:00:00	2029-03-30 00:00:00	\N
74	APATOR202MTK-AM480	Apator	Apator Powogaz S.A. - Ba Lan	20	2	MTK-AM			4	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 792	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
75	APATOR252MTK-AM6.380	Apator	Apator Powogaz S.A. - Ba Lan	25	2	MTK-AM			6.3	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 793	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
76	APATOR322MTK-AM1080	Apator	Apator Powogaz S.A. - Ba Lan	32	2	MTK-AM			10	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 794	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
77	APATOR402MTK-AM1680	Apator	Apator Powogaz S.A. - Ba Lan	40	2	MTK-AM			16	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 795	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
78	APATOR502MTK-AM2580	Apator	Apator Powogaz S.A. - Ba Lan	50	2	MTK-AM			25	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 796	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
79	APATOR152MNK-KP2.580	Apator	Apator Powogaz S.A. - Ba Lan	15	2	MNK-KP			2.5	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 1115	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
80	APATOR202MNK-KP480	Apator	Apator Powogaz S.A. - Ba Lan	20	2	MNK-KP			4	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 1116	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
81	APATOR252MNK-KP6.380	Apator	Apator Powogaz S.A. - Ba Lan	25	2	MNK-KP			6.3	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 1117	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
82	APATOR322MNK-KP1080	Apator	Apator Powogaz S.A. - Ba Lan	32	2	MNK-KP			10	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 1118	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
83	APATOR402MNK-KP1680	Apator	Apator Powogaz S.A. - Ba Lan	40	2	MNK-KP			16	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 1119	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
84	APATOR502MNK-KP2580	Apator	Apator Powogaz S.A. - Ba Lan	50	2	MNK-KP			25	80	Công ty Cổ phần Kỹ thuật Đo lường VBS	26B phố Chợ Cầu Diễn, thị trấn Cầu Diễn, huyện Từ Liêm, tp.Hà Nội	PDM 1120	2019-03-26 00:00:00	2029-03-30 00:00:00	\N
85	MADDALENA-PHUTHAI15CCDONE-TRP1.5	Maddalena-PhuThai	Maddalena S.p.A - Ý	15	C	CD ONE-TRP		1.5			Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 1348	2016-07-14 00:00:00	2026-07-30 00:00:00	\N
86	MADDALENA-PHUTHAI15BCDONE-TRP1.5	Maddalena-PhuThai	Maddalena S.p.A - Ý	15	B	CD ONE-TRP		1.5			Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 051	2017-01-03 00:00:00	2027-01-30 00:00:00	\N
87	MADDALENA-PHUTHAI202CDONE-TRP4160	Maddalena-PhuThai	Maddalena S.p.A - Ý	20	2	CD ONE-TRP			4	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 752	2017-02-08 00:00:00	2027-02-28 00:00:00	\N
88	MADDALENA-PHUTHAI252CDONE-TRP6.3160	Maddalena-PhuThai	Maddalena S.p.A - Ý	25	2	CD ONE-TRP			6.3	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 753	2017-02-08 00:00:00	2027-02-28 00:00:00	\N
89	MADDALENA-PHUTHAI402DS-TRP16160	Maddalena-PhuThai	Maddalena S.p.A - Ý	40	2	DS-TRP			16	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 754	2017-02-08 00:00:00	2027-02-28 00:00:00	\N
90	MADDALENA-PHUTHAI502DS-TRP25160	Maddalena-PhuThai	Maddalena S.p.A - Ý	50	2	DS-TRP			25	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 755	2017-02-08 00:00:00	2027-02-28 00:00:00	\N
91	MADDALENA-PHUTHAI652WMAP4080	Maddalena-PhuThai	Maddalena S.p.A - Ý	65	2	WMAP			40	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 756	2017-02-08 00:00:00	2027-02-28 00:00:00	\N
92	MADDALENA-PHUTHAI1002WMAP10080	Maddalena-PhuThai	Maddalena S.p.A - Ý	100	2	WMAP			100	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 757	2017-02-08 00:00:00	2027-02-28 00:00:00	\N
93	MADDALENA-PHUTHAI202DS-TRP4160	Maddalena-PhuThai	Maddalena S.p.A - Ý	20	2	DS-TRP			4	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 1773	2017-05-09 00:00:00	2027-05-30 00:00:00	\N
94	MADDALENA-PHUTHAI252DS-TRP6.3160	Maddalena-PhuThai	Maddalena S.p.A - Ý	25	2	DS-TRP			6.3	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 1774	2017-05-09 00:00:00	2027-05-30 00:00:00	\N
95	MADDALENA-PHUTHAI802WMAP6380	Maddalena-PhuThai	Maddalena S.p.A - Ý	80	2	WMAP			63	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 1775	2017-05-09 00:00:00	2027-05-30 00:00:00	\N
96	MADDALENA-PHUTHAI322DS-TRP10160	Maddalena-PhuThai	Maddalena S.p.A - Ý	32	2	DS-TRP			10	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2485	2017-08-25 00:00:00	2027-08-30 00:00:00	\N
97	MADDALENA-PHUTHAI502WMAP2580	Maddalena-PhuThai	Maddalena S.p.A - Ý	50	2	WMAP			25	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2486	2017-08-25 00:00:00	2027-08-30 00:00:00	\N
98	MADDALENA-PHUTHAI1502WMAP25080	Maddalena-PhuThai	Maddalena S.p.A - Ý	150	2	WMAP			250	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2487	2017-08-25 00:00:00	2027-08-30 00:00:00	\N
99	MADDALENA-PHUTHAI2002WMAP40080	Maddalena-PhuThai	Maddalena S.p.A - Ý	200	2	WMAP			400	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2488	2017-08-25 00:00:00	2027-08-30 00:00:00	\N
100	MADDALENA-PHUTHAI1502WMAPEVO250100	Maddalena-PhuThai	Maddalena S.p.A - Ý	150	2	WMAP EVO			250	100	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 3221	2018-12-11 00:00:00	2028-12-30 00:00:00	\N
101	MADDALENA-PHUTHAI2002WMAPEVO400100	Maddalena-PhuThai	Maddalena S.p.A - Ý	200	2	WMAP EVO			400	100	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 3222	2018-12-11 00:00:00	2028-12-30 00:00:00	\N
102	MADDALENA-PHUTHAI1002WMAPEVO160100	Maddalena-PhuThai	Maddalena S.p.A - Ý	100	2	WMAP EVO			160	100	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 3223	2018-12-11 00:00:00	2028-12-30 00:00:00	\N
103	MADDALENA-PHUTHAI802WMAPEVO100100	Maddalena-PhuThai	Maddalena S.p.A - Ý	80	2	WMAP EVO			100	100	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 3224	2018-12-11 00:00:00	2028-12-30 00:00:00	\N
104	MADDALENA-PHUTHAI152CDONE-TRP2.5160	Maddalena-PhuThai	Maddalena S.p.A - Ý	15	2	CD ONE-TRP			2.5	160	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2429	2020-10-28 00:00:00	2030-10-30 00:00:00	\N
105	MADDALENA-PHUTHAI152CDONE-TRPCHƯAXÁCĐỊNH12.5100	Maddalena-PhuThai	Maddalena S.p.A - Ý	15	2	CD ONE-TRP	chưa xác định 1		2.5	100	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2429	2020-10-28 00:00:00	2030-10-30 00:00:00	\N
252	BADGER1002M500025080	BADGER	BADGER - Séc	100	2	M5000			250	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
106	MADDALENA-PHUTHAI152CDONE-TRPCHƯAXÁCĐỊNH22.5100	Maddalena-PhuThai	Maddalena S.p.A - Ý	15	2	CD ONE-TRP	chưa xác định 2		2.5	100	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2430	2020-10-28 00:00:00	2030-10-30 00:00:00	\N
107	MADDALENA-PHUTHAI152CDONE-TRP2.580	Maddalena-PhuThai	Maddalena S.p.A - Ý	15	2	CD ONE-TRP			2.5	80	Công ty Cổ phần Đầu tư Thương mại Xuất Nhập khẩu Phú Thái	Số 48, Khu C, khu đô thị mới Đại Kim - Định Công, q.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 2430	2020-10-28 00:00:00	2030-10-30 00:00:00	\N
108	MADDALENA-HCL652WMAPEVO63100	Maddalena-HCL	Maddalena S.p.A. - Ý	65	2	WMAP EVO			63	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1639	2022-06-24 00:00:00	2032-06-30 00:00:00	\N
109	MADDALENA-HCL1502WMAPEVO250100	Maddalena-HCL	Maddalena S.p.A. - Ý	150	2	WMAP EVO			250	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1640	2022-06-24 00:00:00	2032-06-30 00:00:00	\N
110	MADDALENA-HCL2002WMAPEVO400100	Maddalena-HCL	Maddalena S.p.A. - Ý	200	2	WMAP EVO			400	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1641	2022-06-24 00:00:00	2032-06-30 00:00:00	\N
111	MADDALENA-HCL502WMAPEVO40100	Maddalena-HCL	Maddalena S.p.A. - Ý	50	2	WMAP EVO			40	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1420	2022-05-31 00:00:00	2032-05-30 00:00:00	\N
112	MADDALENA-HCL802WMAPEVO100100	Maddalena-HCL	Maddalena S.p.A. - Ý	80	2	WMAP EVO			100	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1421	2022-05-31 00:00:00	2032-05-30 00:00:00	\N
113	MADDALENA-HCL1002WMAPEVO160100	Maddalena-HCL	Maddalena S.p.A. - Ý	100	2	WMAP EVO			160	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1422	2022-05-31 00:00:00	2032-05-30 00:00:00	\N
114	JANZ202JT200480	JANZ	JANZ-Contagem E Gestão De Fluídos, S.A. - Bồ Đào Nha	20	2	JT200			4	80	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1800	2020-07-31 00:00:00	2030-07-30 00:00:00	\N
115	JANZ252MST35256.3100	JANZ	JANZ-Contagem E Gestão De Fluídos, S.A. - Bồ Đào Nha	25	2	MST3525			6.3	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1801	2020-07-31 00:00:00	2030-07-30 00:00:00	\N
116	JANZ322MST603010100	JANZ	JANZ-Contagem E Gestão De Fluídos, S.A. - Bồ Đào Nha	32	2	MST6030			10	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1802	2020-07-31 00:00:00	2030-07-30 00:00:00	\N
117	JANZ402MST1004016100	JANZ	JANZ-Contagem E Gestão De Fluídos, S.A. - Bồ Đào Nha	40	2	MST10040			16	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1803	2020-07-31 00:00:00	2030-07-30 00:00:00	\N
118	JANZ502MST1505025100	JANZ	JANZ-Contagem E Gestão De Fluídos, S.A. - Bồ Đào Nha	50	2	MST15050			25	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 1804	2020-07-31 00:00:00	2030-07-30 00:00:00	\N
119	JANZ322JV40010315	JANZ	JANZ-Contagem E Gestão De Fluídos, S.A. - Bồ Đào Nha	32	2	JV400			10	315	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 4711	2019-01-01 00:00:00	2029-01-30 00:00:00	\N
120	SISMA152ETW2.560	SISMA	G. Gioanola S.r.l. -Ý	15	2	ETW			2.5	60	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2082	2018-09-10 00:00:00	2028-09-30 00:00:00	\N
121	SISMA502WARF/5063100	SISMA	G. Gioanola S.r.l. -Ý	50	2	WARF/50			63	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2381	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
122	SISMA652WARF/6563100	SISMA	G. Gioanola S.r.l. -Ý	65	2	WARF/65			63	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2382	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
123	SISMA802WARF/80100100	SISMA	G. Gioanola S.r.l. -Ý	80	2	WARF/80			100	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2383	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
124	SISMA1002WARF/100160100	SISMA	G. Gioanola S.r.l. -Ý	100	2	WARF/100			160	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2384	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
125	SISMA1502WARF/150250100	SISMA	G. Gioanola S.r.l. -Ý	150	2	WARF/150			250	100	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2385	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
126	SISMA2002WARF/20063050	SISMA	G. Gioanola S.r.l. -Ý	200	2	WARF/200			630	50	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2386	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
127	SISMA2502WARF/250100050	SISMA	G. Gioanola S.r.l. -Ý	250	2	WARF/250			1000	50	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2387	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
128	SISMA3002WARF/300100050	SISMA	G. Gioanola S.r.l. -Ý	300	2	WARF/300			1000	50	Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 2388	2017-07-31 00:00:00	2027-07-30 00:00:00	\N
129	SISMA50BWST50SB15	SISMA	G. Gioanola S.r.l. -Ý	50	B	WST50SB		15			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 717	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
130	SISMA65BWST65SB25	SISMA	G. Gioanola S.r.l. -Ý	65	B	WST65SB		25			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 718	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
131	SISMA80BWST80SB40	SISMA	G. Gioanola S.r.l. -Ý	80	B	WST80SB		40			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 719	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
132	SISMA100BWST100SB60	SISMA	G. Gioanola S.r.l. -Ý	100	B	WST100SB		60			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 720	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
133	SISMA150BWST150SB150	SISMA	G. Gioanola S.r.l. -Ý	150	B	WST150SB		150			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 722	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
134	SISMA250BWST250SB400	SISMA	G. Gioanola S.r.l. -Ý	250	B	WST250SB		400			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 724	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
135	SISMA300BWST300SB600	SISMA	G. Gioanola S.r.l. -Ý	300	B	WST300SB		600			Công ty CP Đầu tư và Sản xuất HCL	số 12, ngõ 104/3 Định Công, p.Phương Liệt, q.Thanh Xuân, tp.Hà Nội	PDM 725	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
136	BMETERS-COMERIC152GSD82.5100	B METERS - Comeric	B Meters S.r.l. - Italy	15	2	GSD8			2.5	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1973	2017-06-15 00:00:00	2027-06-30 00:00:00	\N
137	BMETERS-COMERIC202GSD84100	B METERS - Comeric	B Meters S.r.l. - Italy	20	2	GSD8			4	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1974	2017-06-15 00:00:00	2027-06-30 00:00:00	\N
138	BMETERS-COMERIC252GMDM6.3100	B METERS - Comeric	B Meters S.r.l. - Italy	25	2	GMDM			6.3	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1975	2017-06-15 00:00:00	2027-06-30 00:00:00	\N
139	BMETERS-COMERIC322GMDM10100	B METERS - Comeric	B Meters S.r.l. - Italy	32	2	GMDM			10	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1976	2017-06-15 00:00:00	2027-06-30 00:00:00	\N
140	BMETERS-COMERIC152GMDM2.5100	B METERS - Comeric	B Meters S.r.l. - Italy	15	2	GMDM			2.5	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2083	2018-09-05 00:00:00	2028-09-30 00:00:00	\N
141	BMETERS-COMERIC202GMDM4100	B METERS - Comeric	B Meters S.r.l. - Italy	20	2	GMDM			4	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2084	2018-09-05 00:00:00	2028-09-30 00:00:00	\N
142	BMETERS-COMERIC1252WDE-K50160100	B METERS - Comeric	B Meters S.r.l. - Italy	125	2	WDE-K50			160	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2085	2018-09-05 00:00:00	2028-09-30 00:00:00	\N
143	BMETERS-COMERIC1502WDE-K50250100	B METERS - Comeric	B Meters S.r.l. - Italy	150	2	WDE-K50			250	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2086	2018-09-05 00:00:00	2028-09-30 00:00:00	\N
144	BMETERS-COMERIC2002WDE-K50400100	B METERS - Comeric	B Meters S.r.l. - Italy	200	2	WDE-K50			400	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2087	2018-09-05 00:00:00	2028-09-30 00:00:00	\N
145	BMETERS-COMERIC502WDE-K5040100	B METERS - Comeric	B Meters S.r.l. - Italy	50	2	WDE-K50			40	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1944	2018-08-14 00:00:00	2028-08-30 00:00:00	\N
146	BMETERS-COMERIC652WDE-K5063100	B METERS - Comeric	B Meters S.r.l. - Italy	65	2	WDE-K50			63	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1945	2018-08-14 00:00:00	2028-08-30 00:00:00	\N
147	BMETERS-COMERIC802WDE-K50100100	B METERS - Comeric	B Meters S.r.l. - Italy	80	2	WDE-K50			100	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1946	2018-08-14 00:00:00	2028-08-30 00:00:00	\N
148	BMETERS-COMERIC1002WDE-K50160100	B METERS - Comeric	B Meters S.r.l. - Italy	100	2	WDE-K50			160	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 1947	2018-08-14 00:00:00	2028-08-30 00:00:00	\N
149	BMETERS-COMERIC402GMDM16100	B METERS - Comeric	B Meters S.r.l. - Italy	40	2	GMDM			16	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2684	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
150	BMETERS-COMERIC502WDE-K4040100	B METERS - Comeric	B Meters S.r.l. - Italy	50	2	WDE-K40			40	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2685	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
151	BMETERS-COMERIC652WDE-K4063100	B METERS - Comeric	B Meters S.r.l. - Italy	65	2	WDE-K40			63	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2686	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
152	BMETERS-COMERIC802WDE-K40100100	B METERS - Comeric	B Meters S.r.l. - Italy	80	2	WDE-K40			100	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2687	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
153	BMETERS-COMERIC1002WDE-K40160100	B METERS - Comeric	B Meters S.r.l. - Italy	100	2	WDE-K40			160	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2688	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
154	BMETERS-COMERIC1252WDE-K40160100	B METERS - Comeric	B Meters S.r.l. - Italy	125	2	WDE-K40			160	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2689	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
155	BMETERS-COMERIC1502WDE-K40250100	B METERS - Comeric	B Meters S.r.l. - Italy	150	2	WDE-K40			250	100	Công ty Cổ phần COMERIC	Phòng 203 nhà 17T6 khu Trung Hòa Nhân Chính, p.Nhân Chính, q.Thanh Xuân, tp.Hà Nội	PDM 2690	2017-09-05 00:00:00	2027-09-30 00:00:00	\N
156	BMETERS-DUCHUNG152GMDM2.5100	B METERS - DucHung	B Meters S.r.l. - Italy	15	2	GMDM			2.5	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 1881	2015-11-20 00:00:00	2025-11-30 00:00:00	\N
157	BMETERS-DUCHUNG152GMB-RP2.5100	B METERS - DucHung	B Meters S.r.l. - Italy	15	2	GMB-RP			2.5	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1862/QĐ-TĐC	2015-12-04 00:00:00	2025-12-30 00:00:00	\N
158	BMETERS-DUCHUNG502WDE-K5040100	B METERS - DucHung	B Meters S.r.l. - Italy	50	2	WDE-K50			40	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 1065	2018-05-16 00:00:00	2028-05-30 00:00:00	\N
159	BMETERS-DUCHUNG802WDE-K50100100	B METERS - DucHung	B Meters S.r.l. - Italy	80	2	WDE-K50			100	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 1066	2018-05-16 00:00:00	2028-05-30 00:00:00	\N
160	BMETERS-DUCHUNG1002WDE-K50160100	B METERS - DucHung	B Meters S.r.l. - Italy	100	2	WDE-K50			160	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 1067	2018-05-16 00:00:00	2028-05-30 00:00:00	\N
161	BMETERS-DUCHUNG1502WDE-K50250100	B METERS - DucHung	B Meters S.r.l. - Italy	150	2	WDE-K50			250	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 1068	2018-05-16 00:00:00	2028-05-30 00:00:00	\N
162	BMETERS-DUCHUNG2002WDE-K50400100	B METERS - DucHung	B Meters S.r.l. - Italy	200	2	WDE-K50			400	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 1069	2018-05-16 00:00:00	2028-05-30 00:00:00	\N
163	BMETERS-DUCHUNG252GMDM6.3100	B METERS - DucHung	B Meters S.r.l. - Italy	25	2	GMDM			6.3	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 416	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
164	BMETERS-DUCHUNG402GMDM16100	B METERS - DucHung	B Meters S.r.l. - Italy	40	2	GMDM			16	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 417	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
165	BMETERS-DUCHUNG502GMDM25100	B METERS - DucHung	B Meters S.r.l. - Italy	50	2	GMDM			25	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 418	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
166	BMETERS-DUCHUNG152GMDM2.5160	B METERS - DucHung	B Meters S.r.l. - Italy	15	2	GMDM			2.5	160	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 419	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
167	BMETERS-DUCHUNG252GMDM6.3160	B METERS - DucHung	B Meters S.r.l. - Italy	25	2	GMDM			6.3	160	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 420	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
168	BMETERS-DUCHUNG402GMDM16160	B METERS - DucHung	B Meters S.r.l. - Italy	40	2	GMDM			16	160	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 421	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
169	BMETERS-DUCHUNG502GMDM25160	B METERS - DucHung	B Meters S.r.l. - Italy	50	2	GMDM			25	160	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	PDM 422	2016-03-21 00:00:00	2026-03-30 00:00:00	\N
170	BMETERS-DUCHUNG152GSD82.5100	B METERS - DucHung	B Meters S.r.l. - Italy	15	2	GSD8			2.5	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 đường Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1914/QĐ-TĐC	2016-09-07 00:00:00	2026-09-30 00:00:00	\N
171	BMETERS-DUCHUNG152GMB-RP2.5160	B METERS - DucHung	B Meters S.r.l. - Italy	15	2	GMB-RP			2.5	160	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1681/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
172	BMETERS-DUCHUNG502WDE-K4040100	B METERS - DucHung	B Meters S.r.l. - Italy	50	2	WDE-K40			40	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1681/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
173	BMETERS-DUCHUNG802WDE-K40100100	B METERS - DucHung	B Meters S.r.l. - Italy	80	2	WDE-K40			100	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1681/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
174	BMETERS-DUCHUNG1002WDE-K40160100	B METERS - DucHung	B Meters S.r.l. - Italy	100	2	WDE-K40			160	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1681/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
175	BMETERS-DUCHUNG1502WDE-K40250100	B METERS - DucHung	B Meters S.r.l. - Italy	150	2	WDE-K40			250	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1681/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
176	BMETERS-DUCHUNG2002WDE-K40400100	B METERS - DucHung	B Meters S.r.l. - Italy	200	2	WDE-K40			400	100	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1681/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
177	BMETERS-DUCHUNG252GMDX6.350	B METERS - DucHung	B Meters S.r.l. - Italy	25	2	GMDX			6.3	50	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1858/QĐ-TĐC	2017-11-22 00:00:00	2027-11-30 00:00:00	\N
178	BMETERS-DUCHUNG322GMDX1050	B METERS - DucHung	B Meters S.r.l. - Italy	32	2	GMDX			10	50	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1858/QĐ-TĐC	2017-11-22 00:00:00	2027-11-30 00:00:00	\N
179	BMETERS-DUCHUNG402GMDX1650	B METERS - DucHung	B Meters S.r.l. - Italy	40	2	GMDX			16	50	Công ty TNHH Thương mại Dịch vụ Kỹ thuật Đức Hùng	Số 17/19 Gò Dầu, p.Tân Quý, q.Tân Phú, tp.HCM	1858/QĐ-TĐC	2017-11-22 00:00:00	2027-11-30 00:00:00	\N
180	DRAGON15CDM-15S-50S1.5	Dragon	Dragon Pumps & System PTE., Ltd. - Singapore	15	C	DM-15S-50S		1.5			Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2403	2016-09-30 00:00:00	2026-09-30 00:00:00	\N
181	DRAGON15BDM-15E-50E1.5	Dragon	Dragon Pumps & System PTE., Ltd. - Singapore	15	B	DM-15E-50E		1.5			Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 089	2017-01-09 00:00:00	2027-01-30 00:00:00	\N
182	DRAGON15CDM-15E-50E1.5	Dragon	Dragon Pumps & System PTE., Ltd. - Singapore	15	C	DM-15E-50E		1.5			Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 090	2017-01-09 00:00:00	2027-01-30 00:00:00	\N
183	DIEHL-SONGTHANH152ALTAIR2.5160	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	15	2	ALTAIR			2.5	160	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2027	2017-06-28 00:00:00	2027-06-30 00:00:00	\N
184	DIEHL-SONGTHANH152AURIGA2.5160	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	15	2	AURIGA			2.5	160	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2028	2017-06-28 00:00:00	2027-06-30 00:00:00	\N
185	DIEHL-SONGTHANH152AQUARIUS2.580	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	15	2	AQUARIUS			2.5	80	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 3112	2017-11-22 00:00:00	2027-11-30 00:00:00	\N
186	DIEHL-SONGTHANH202ALTAIR4315	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	20	2	ALTAIR			4	315	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2596	2019-06-04 00:00:00	2029-06-30 00:00:00	\N
187	DIEHL-SONGTHANH502AQUILA25315	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	50	2	AQUILA			25	315	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2246	2019-05-21 00:00:00	2029-05-30 00:00:00	\N
188	DIEHL-SONGTHANH802AQUILA63315	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	80	2	AQUILA			63	315	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2247	2019-05-21 00:00:00	2029-05-30 00:00:00	\N
189	DIEHL-SONGTHANH1002AQUILA100315	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	100	2	AQUILA			100	315	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2248	2019-05-21 00:00:00	2029-05-30 00:00:00	\N
190	DIEHL-SONGTHANH652AQUILA40315	DIEHL - SongThanh	Diehl Metering SAS - Pháp	65	2	AQUILA			40	315	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 4956	2019-11-20 00:00:00	2029-11-30 00:00:00	\N
191	DIEHL-SONGTHANH252171B6.3160	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	25	2	171B			6.3	160	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 4127	2019-08-16 00:00:00	2029-08-30 00:00:00	\N
192	DIEHL-SONGTHANH322ALTAIR6.3160	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	32	2	ALTAIR			6.3	160	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 4397	2021-12-17 00:00:00	2031-12-30 00:00:00	\N
193	DIEHL-SONGTHANH402ALTAIR16160	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	40	2	ALTAIR			16	160	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 4398	2021-12-17 00:00:00	2031-12-30 00:00:00	\N
194	DIEHL-SONGTHANH502WPG63100	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	50	2	WP G			63	100	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 1570	2022-06-16 00:00:00	2032-06-30 00:00:00	\N
195	DIEHL-SONGTHANH802WPG100100	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	80	2	WP G			100	100	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 1571	2022-06-16 00:00:00	2032-06-30 00:00:00	\N
196	DIEHL-SONGTHANH1002WPG160100	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	100	2	WP G			160	100	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 1572	2022-06-16 00:00:00	2032-06-30 00:00:00	\N
197	DIEHL-SONGTHANH1502WPG400100	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	150	2	WP G			400	100	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 1573	2022-06-16 00:00:00	2032-06-30 00:00:00	\N
198	DIEHL-SONGTHANH202ARIES4125	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	20	2	ARIES			4	125	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2406	2022-09-30 00:00:00	2032-09-30 00:00:00	\N
199	DIEHL-SONGTHANH322AURIGA10160	DIEHL - SongThanh	Diehl Metering S.A.S - Pháp	32	2	AURIGA			10	160	Công ty TNHH Quốc tế Song Thanh	Số 8, ngõ 96 Võ Thị Sáu, p.Thanh Nhàn, q.Hai Bà Trưng, tp.Hà Nội	PDM 2407	2022-09-30 00:00:00	2032-09-30 00:00:00	\N
200	DIEHL-KYTHUATST252ALTAIR6.3160	DIEHL - KyThuatST	Diehl Metering SAS - Pháp	25	2	ALTAIR			6.3	160	Công ty Cổ phần Giải pháp Kỹ thuật ST	Tầng 8, tòa nhà Callary, 123 Lý Chính Thắng, Phường 7, Quận 3, TP.HCM	PDM 1178	2020-06-16 00:00:00	2030-06-30 00:00:00	\N
201	DIEHL-KYTHUATST322ALTAIR6.3160	DIEHL - KyThuatST	Diehl Metering SAS - Pháp	32	2	ALTAIR			6.3	160	Công ty Cổ phần Giải pháp Kỹ thuật ST	Tầng 8, tòa nhà Callary, 123 Lý Chính Thắng, Phường 7, Quận 3, TP.HCM	PDM 1179	2020-06-16 00:00:00	2030-06-30 00:00:00	\N
202	DIEHL-KYTHUATST152AURIGA2.5125	DIEHL - KyThuatST	Diehl Metering GmbH - Pháp	15	2	AURIGA			2.5	125	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 khu phố 4, phường Tân Thuận Tây, Quận 7, Thành phố Hồ Chí Minh	PDM 1180	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
203	DIEHL-KYTHUATST252HYDRUS10160	DIEHL - KyThuatST	Diehl Metering GmbH - Đức	25	2	HYDRUS			10	160	Công ty Cổ phần Giải pháp Kỹ thuật ST	Tầng 8, tòa nhà Callary, số 123 Lý Chính Thắng, Phường 7, Quận 3, Thành phố Hồ Chí Minh	PDM 3608	2021-10-20 00:00:00	2031-10-31 00:00:00	\N
204	DIEHL-KYTHUATST402HYDRUS16160	DIEHL - KyThuatST	Diehl Metering GmbH - Đức	40	2	HYDRUS			16	160	Công ty Cổ phần Giải pháp Kỹ thuật ST	Tầng 8, tòa nhà Callary, số 123 Lý Chính Thắng, Phường 7, Quận 3, Thành phố Hồ Chí Minh	PDM 3609	2021-10-20 00:00:00	2031-10-31 00:00:00	\N
205	DIEHL-HOAHONG152AURIGA2.5160	DIEHL - HoaHong	Diehl Metering S.A.S - Pháp	15	2	AURIGA			2.5	160	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	I04, Đường số 10, khu dân cư Hồng Long, phường Hiệp Bình Phước, quận Thủ Đức, Thành Phố Hồ Chí Minh	PDM 3490	2017-12-29 00:00:00	2027-12-30 00:00:00	\N
206	DIEHL-HOAHONG202AURIGA4125	DIEHL - HoaHong	Diehl Metering S.A.S - Pháp	20	2	AURIGA			4	125	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	I04, Đường số 10, khu dân cư Hồng Long, phường Hiệp Bình Phước, quận Thủ Đức, Thành Phố Hồ Chí Minh	PDM 3491	2017-12-29 00:00:00	2027-12-30 00:00:00	\N
207	Hết hạn	DIEHL - DoThiViet	DIEHL Metering - Đức (Đồng hồ kép)	150/40	B/C	WP-MFD 222		150			Công ty Cổ Phần Tư Vấn Và Đầu Tư Đô Thị Việt	250 Nguyễn Thị Minh Khai ,p.6, q3, tp HCM	766/QĐ-TĐC	2013-04-01 00:00:00	2023-04-30 00:00:00	\N
208	AUT20BLXSG-20E2.5	AUT	AUT RESOURCES SDN BHD - Malaysia	20	B	LXSG-20E		2.5			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 171	2018-02-12 00:00:00	2028-02-28 00:00:00	\N
209	AUT40BLXSG-40E10	AUT	AUT RESOURCES SDN BHD - Malaysia	40	B	LXSG-40E		10			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 172	2018-02-12 00:00:00	2028-02-28 00:00:00	\N
210	AUT32BLXSG-32E6	AUT	AUT RESOURCES SDN BHD - Malaysia	32	B	LXSG-32E		6			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 2878	2017-10-12 00:00:00	2027-10-30 00:00:00	\N
211	AUT50BLXLC-5015	AUT	AUT RESOURCES SDN BHD - Malaysia	50	B	LXLC-50		15			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 2879	2017-10-12 00:00:00	2027-10-30 00:00:00	\N
212	AUT150BLXLC-150150	AUT	AUT RESOURCES SDN BHD - Malaysia	150	B	LXLC-150		150			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 2880	2017-10-12 00:00:00	2027-10-30 00:00:00	\N
213	AUT200BLXLC-200250	AUT	AUT RESOURCES SDN BHD - Malaysia	200	B	LXLC-200		250			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 2881	2017-10-12 00:00:00	2027-10-30 00:00:00	\N
214	AUT15BLXSG-15E1.5	AUT	AUT RESOURCES SDN BHD - Malaysia	15	B	LXSG-15E		1.5			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 2851	2017-10-12 00:00:00	2027-10-30 00:00:00	\N
215	AUT100BLXLC-10060	AUT	AUT RESOURCES SDN BHD - Malaysia	100	B	LXLC-100		60			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 3030	2016-11-17 00:00:00	2026-11-30 00:00:00	\N
216	AUT80BLXLC-8040	AUT	AUT RESOURCES SDN BHD - Malaysia	80	B	LXLC-80		40			Công ty CP Thương mại và Môi trường Việt Nam	Phòng 803 tòa nhà Tổng công ty Xây dựng Hà Nội, số 57 Quang Trung, p.Nguyễn Du, q.Hai Bà Trưng, tp.Hà Nội	PDM 1585	2017-03-27 00:00:00	2027-03-30 00:00:00	\N
217	Hết hạn	AQUAMASTER 3	ABB-Anh Quốc	80	2	FER2	FET2211A0Y5G5Y1		100	250	Công ty CP Công nghệ Bách Việt	số 42 Trường Sơn, p.2, q.Tân Bình, tp.HCM	1734/QĐ-TĐC	2012-09-14 00:00:00	2022-09-30 00:00:00	\N
218	Hết hạn	AQUAMASTER 3	ABB-Anh Quốc	350	2	FER2	FET2211A0Y5G5Y1		1600	160	Công ty CP Công nghệ Bách Việt	số 42 Trường Sơn, p.2, q.Tân Bình, tp.HCM	1734/QĐ-TĐC	2012-09-14 00:00:00	2022-09-30 00:00:00	\N
219	Hết hạn	AQUAMASTER 3	ABB-Anh Quốc	450	2	FER2	FET2211A0Y5G5Y1		2500	160	Công ty CP Công nghệ Bách Việt	số 42 Trường Sơn, p.2, q.Tân Bình, tp.HCM	1734/QĐ-TĐC	2012-09-14 00:00:00	2022-09-30 00:00:00	\N
220	AQUAMASTER4402FEW425400	AQUAMASTER 4	ABB-Anh Quốc	40	2	FEW4			25	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1815	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
221	AQUAMASTER4502FEW440400	AQUAMASTER 4	ABB-Anh Quốc	50	2	FEW4			40	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1816	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
222	AQUAMASTER4652FEW463400	AQUAMASTER 4	ABB-Anh Quốc	65	2	FEW4			63	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1817	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
223	AQUAMASTER4802FEW4100400	AQUAMASTER 4	ABB-Anh Quốc	80	2	FEW4			100	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1818	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
224	AQUAMASTER41002FEW4160400	AQUAMASTER 4	ABB-Anh Quốc	100	2	FEW4			160	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1819	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
225	AQUAMASTER41252FEW4160400	AQUAMASTER 4	ABB-Anh Quốc	125	2	FEW4			160	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1820	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
226	AQUAMASTER41502FEW4400400	AQUAMASTER 4	ABB-Anh Quốc	150	2	FEW4			400	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1821	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
227	AQUAMASTER42002FEW4630400	AQUAMASTER 4	ABB-Anh Quốc	200	2	FEW4			630	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1822	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
228	AQUAMASTER42502FEW41000400	AQUAMASTER 4	ABB-Anh Quốc	250	2	FEW4			1000	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1823	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
229	AQUAMASTER43002FEW41600400	AQUAMASTER 4	ABB-Anh Quốc	300	2	FEW4			1600	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1824	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
230	AQUAMASTER43502FEW41600400	AQUAMASTER 4	ABB-Anh Quốc	350	2	FEW4			1600	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1825	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
231	AQUAMASTER44002FEW42500400	AQUAMASTER 4	ABB-Anh Quốc	400	2	FEW4			2500	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1826	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
232	AQUAMASTER44502FEW42500400	AQUAMASTER 4	ABB-Anh Quốc	450	2	FEW4			2500	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1827	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
233	AQUAMASTER45002FEW44000400	AQUAMASTER 4	ABB-Anh Quốc	500	2	FEW4			4000	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1828	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
234	AQUAMASTER46002FEW46300400	AQUAMASTER 4	ABB-Anh Quốc	600	2	FEW4			6300	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1829	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
235	AQUAMASTER47002FEW416000400	AQUAMASTER 4	ABB-Anh Quốc	700	2	FEW4			16000	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1830	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
236	AQUAMASTER48002FEW416000400	AQUAMASTER 4	ABB-Anh Quốc	800	2	FEW4			16000	400	Công ty TNHH ABB	Km 9, quốc lộ 1A, p.Hoàng Liệt, q.Hoàng Mai, tp.HN	PDM 1831	2018-07-27 00:00:00	2028-07-30 00:00:00	\N
237	ARAD15BQ151.5	ARAD	Arad - Israel	15	B	Q15		1.5			Công ty TNHH N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	2282/QĐ-TĐC	2016-11-07 00:00:00	2026-11-30 00:00:00	\N
238	ARAD15BQ15-DJB1.5	ARAD	Arad - Israel	15	B	Q15-DJB		1.5			Công ty TNHH N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	49/QĐ-TĐC	2017-01-11 00:00:00	2027-01-30 00:00:00	\N
239	ARAD402OCTAVE40250	ARAD	Arad - Israel	40	2	Octave			40	250	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
240	ARAD502OCTAVE40500	ARAD	Arad - Israel	50	2	Octave			40	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
241	ARAD802OCTAVE63500	ARAD	Arad - Israel	80	2	Octave			63	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
242	ARAD1002OCTAVE100500	ARAD	Arad - Israel	100	2	Octave			100	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
243	ARAD1502OCTAVE250500	ARAD	Arad - Israel	150	2	Octave			250	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
244	ARAD2002OCTAVE400500	ARAD	Arad - Israel	200	2	Octave			400	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
245	ARAD2502OCTAVE1000500	ARAD	Arad - Israel	250	2	Octave			1000	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
246	ARAD3002OCTAVE1000500	ARAD	Arad - Israel	300	2	Octave			1000	500	Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	1811/QĐ-TĐC	2016-08-22 00:00:00	2026-08-30 00:00:00	\N
247	Hết hạn	ASAHI	ASAHI - Thai Alloy Co., Ltd - Thái Lan	20	B	GMK 20		2.5			Công ty Cổ phần Đại Việt Trí Tuệ	109 Nguyễn Tuân, p.Nhân Chính, q.Thanh Xuân, Hà Nội	PDM 801	2014-10-10 00:00:00	2024-10-30 00:00:00	\N
248	Hết hạn	ASAHI	ASAHI - Thai Alloy Co., Ltd - Thái Lan	25	B	GMK 25		3.5			Công ty Cổ phần Đại Việt Trí Tuệ	109 Nguyễn Tuân, p.Nhân Chính, q.Thanh Xuân, Hà Nội	PDM 802	2014-10-10 00:00:00	2024-10-30 00:00:00	\N
249	Hết hạn	ASAHI	ASAHI - Thai Alloy Co., Ltd - Thái Lan	40	B	GMK 40		5.5			Công ty Cổ phần Đại Việt Trí Tuệ	109 Nguyễn Tuân, p.Nhân Chính, q.Thanh Xuân, Hà Nội	PDM 803	2014-10-10 00:00:00	2024-10-30 00:00:00	\N
250	BADGER502M50006380	BADGER	BADGER - Séc	50	2	M5000			63	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
251	BADGER802M500016080	BADGER	BADGER - Séc	80	2	M5000			160	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
253	BADGER1502M500040080	BADGER	BADGER - Séc	150	2	M5000			400	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
254	BADGER2002M5000100080	BADGER	BADGER - Séc	200	2	M5000			1000	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
255	BADGER2502M5000160080	BADGER	BADGER - Séc	250	2	M5000			1600	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
256	BADGER3002M5000160080	BADGER	BADGER - Séc	300	2	M5000			1600	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
257	BADGER4002M5000250080	BADGER	BADGER - Séc	400	2	M5000			2500	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	2468/QĐ-TĐC	2016-12-08 00:00:00	2025-09-30 00:00:00	\N
258	BADGER3502M5000160080	BADGER	BADGER - Đức	350	2	M5000			1600	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	587/QĐ-TĐC	2016-04-26 00:00:00	2026-04-30 00:00:00	\N
259	BADGER4502M5000250080	BADGER	BADGER - Đức	450	2	M5000			2500	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	587/QĐ-TĐC	2016-04-26 00:00:00	2026-04-30 00:00:00	\N
260	BADGER5002M5000400080	BADGER	BADGER - Đức	500	2	M5000			4000	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	587/QĐ-TĐC	2016-04-26 00:00:00	2026-04-30 00:00:00	\N
261	BADGER6002M5000630080	BADGER	BADGER - Đức	600	2	M5000			6300	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	587/QĐ-TĐC	2016-04-26 00:00:00	2026-04-30 00:00:00	\N
262	Hết hạn	SEAL	SEAL - Thái Lan	15	B	SAB 15			1.5	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	998/QĐ-TĐC	2013-04-24 00:00:00	2023-04-30 00:00:00	\N
263	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		63	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1392	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
264	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		160	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1393	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
265	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		250	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1394	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
266	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		400	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1395	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
267	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		1000	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1396	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
268	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		1600	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1397	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
269	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		1600	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1398	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
270	BADGERM5000M5000	BADGER	Badger Europa Gmbh - Séc			M5000	M5000		2500	80	Công ty TNHH Kỹ thuật và Thiết bị Hoa Hồng	4/10 KP4, p.Tân Thuận, q.7, tp.HCM	PDM 1399	2015-09-28 00:00:00	2025-09-30 00:00:00	\N
271	BAYLAN152VK-42.5200	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	15	2	VK-4			2.5	200	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 2510	2015-12-31 00:00:00	2025-12-30 00:00:00	\N
272	BAYLAN152VK-4P2.5200	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	15	2	VK-4P			2.5	200	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 2511	2015-12-31 00:00:00	2025-12-30 00:00:00	\N
273	BAYLAN152VK-62.5200	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	15	2	VK-6			2.5	200	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 2512	2015-12-31 00:00:00	2025-12-30 00:00:00	\N
274	BAYLAN652W-04063	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	65	2	W-0			40	63	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 312	2017-01-11 00:00:00	2027-01-30 00:00:00	\N
275	BAYLAN802W-16363	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	80	2	W-1			63	63	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 313	2017-01-11 00:00:00	2027-01-30 00:00:00	\N
276	BAYLAN1002W-210063	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	100	2	W-2			100	63	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 314	2017-01-11 00:00:00	2027-01-30 00:00:00	\N
277	BAYLAN1502W-425063	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	150	2	W-4			250	63	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 315	2017-01-11 00:00:00	2027-01-30 00:00:00	\N
278	BAYLAN2002W-540063	Baylan	Baylan Olcu Aletleri San. Ve Tic. Ltd. Sti. - Thổ Nhĩ Kỳ	200	2	W-5			400	63	Công ty TNHH Thương mại và Kỹ thuật Trương Nguyệt	Số 319 A7 Lý Thường Kiệt, Phường 15, Quận 11, Thành phố Hồ Chí Minh	PDM 316	2017-01-11 00:00:00	2027-01-30 00:00:00	\N
279	Hết hạn	BERMAD	BERMAD - Israel	400	B	TurboBar		1000			Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	134/QĐ-TĐC	2014-09-29 00:00:00	2024-09-30 00:00:00	\N
280	Hết hạn	BERMAD	BERMAD - Israel	500	B	TurboBar		1500			Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	134/QĐ-TĐC	2014-09-29 00:00:00	2024-09-30 00:00:00	\N
281	Hết hạn	BERMAD	BERMAD - Israel	65	B	TurboBar		25			Công ty TNHH Thương mại N.T.P	278 Tô Hiến Thành, p.15, q.10, tp.HCM	2162/QĐ-TĐC	2014-11-19 00:00:00	2024-11-30 00:00:00	\N
282	CIXIYONGXI15BLXS-15E1.5	CIXI YONGXI 	Cixi Yongxi Instrument Factory - Trung Quốc	15	B	LXS-15E		1.5			Công ty TNHH Xuất nhập khẩu TM-DV Đỉnh Vạn Thành	40 đường 20, p.Bình Hưng Hòa, q.Bình Tân,tp.HCM	PDM 414	2016-03-16 00:00:00	2026-03-30 00:00:00	\N
283	CIXIYONGXI20BLXS-20E2.5	CIXI YONGXI 	Cixi Yongxi Instrument Factory - Trung Quốc	20	B	LXS-20E		2.5			Công ty TNHH Xuất nhập khẩu TM-DV Đỉnh Vạn Thành	40 đường 20, p.Bình Hưng Hòa, q.Bình Tân,tp.HCM	PDM 415	2016-03-16 00:00:00	2026-03-30 00:00:00	\N
285	NINGBO150BLXLC-150150	Ningbo 	Ningbo Yonggang Instrument Co., Ltd. - Trung Quốc	150	B	LXLC-150		150			Công ty TNHH Bảo Gia		PDM 1651	2015-11-06 00:00:00	2025-11-30 00:00:00	\N
286	Hết hạn	DOROT	DOROT - Israel	150	B	  DWM-A		150			Công ty Cổ Phần Tư Vấn Và Đầu Tư Đô Thị Việt	250 Nguyễn Thị Minh Khai ,p.6, q3, tp HCM	1821/QĐ-TĐC	2014-09-23 00:00:00	2024-09-30 00:00:00	\N
287	Hết hạn	DOROT	DOROT - Israel	200	B	  DWM-A		250			Công ty Cổ Phần Tư Vấn Và Đầu Tư Đô Thị Việt	250 Nguyễn Thị Minh Khai ,p.6, q3, tp HCM	1821/QĐ-TĐC	2014-09-23 00:00:00	2024-09-30 00:00:00	\N
288	Hết hạn	DOROT	DOROT - Israel	50	B	  DWM-A		30			Công ty Cổ Phần Tư Vấn Và Đầu Tư Đô Thị Việt	250 Nguyễn Thị Minh Khai ,p.6, q3, tp HCM	1821/QĐ-TĐC	2014-09-23 00:00:00	2024-09-30 00:00:00	\N
289	Hết hạn	DOROT	DOROT - Israel	80	B	  DWM-A		80			Công ty Cổ Phần Tư Vấn Và Đầu Tư Đô Thị Việt	250 Nguyễn Thị Minh Khai ,p.6, q3, tp HCM	1821/QĐ-TĐC	2014-09-23 00:00:00	2024-09-30 00:00:00	\N
290	Hết hạn	DOROT	DOROT - Israel	100	B	  DWM-A		120			Công ty Cổ Phần Tư Vấn Và Đầu Tư Đô Thị Việt	250 Nguyễn Thị Minh Khai ,p.6, q3, tp HCM	1821/QĐ-TĐC	2014-09-23 00:00:00	2024-09-30 00:00:00	\N
291	ENDRESS+HAUSER252PROMAGWPROMAG40016160	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	25	2	Promag W	Promag 400		16	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 807	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
292	ENDRESS+HAUSER322PROMAGWPROMAG40025160	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	32	2	Promag W	Promag 400		25	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 808	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
293	ENDRESS+HAUSER402PROMAGWPROMAG40040160	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	40	2	Promag W	Promag 400		40	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 809	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
294	ENDRESS+HAUSER502PROMAGWPROMAG40063160	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	50	2	Promag W	Promag 400		63	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 810	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
295	ENDRESS+HAUSER652PROMAGWPROMAG400100200	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	65	2	Promag W	Promag 400		100	200	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 811	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
296	ENDRESS+HAUSER802PROMAGWPROMAG400160200	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	80	2	Promag W	Promag 400		160	200	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 812	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
297	ENDRESS+HAUSER1002PROMAGWPROMAG400250200	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	100	2	Promag W	Promag 400		250	200	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 813	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
298	ENDRESS+HAUSER1252PROMAGWPROMAG400400250	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	125	2	Promag W	Promag 400		400	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 814	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
299	ENDRESS+HAUSER1502PROMAGWPROMAG400630250	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	150	2	Promag W	Promag 400		630	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 815	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
300	ENDRESS+HAUSER2002PROMAGWPROMAG4001000250	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	200	2	Promag W	Promag 400		1000	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 816	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
301	ENDRESS+HAUSER2502PROMAGWPROMAG4001600250	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	250	2	Promag W	Promag 400		1600	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 817	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
302	ENDRESS+HAUSER3002PROMAGWPROMAG4002500250	ENDRESS+HAUSER	ENDRESS+HAUSER - Pháp	300	2	Promag W	Promag 400		2500	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	32 Lam Sơn, Phường 2, Quận Tân Bình, TP. Hồ Chí Minh	PDM 818	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
303	FLOWTECH50ALXXG-5015	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	50	A	LXXG-50		15			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 4408	2021-12-27 00:00:00	2031-12-30 00:00:00	\N
304	FLOWTECH80ALXXG-8040	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	80	A	LXXG-80		40			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 4410	2021-12-27 00:00:00	2031-12-30 00:00:00	\N
305	FLOWTECH100ALXXG-10060	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	100	A	LXXG-100		60			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 4411	2022-12-27 00:00:00	2032-12-30 00:00:00	\N
306	FLOWTECH80BLXLC-8040	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	80	B	LXLC-80		40			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 4404	2021-12-27 00:00:00	2031-12-30 00:00:00	\N
307	FLOWTECH100BLXLC-10060	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	100	B	LXLC-100		60			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 4405	2021-12-27 00:00:00	2031-12-30 00:00:00	\N
308	FLOWTECH15BLXSG-151.5	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	15	B	LXSG-15		1.5			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 906	2022-03-29 00:00:00	2032-03-30 00:00:00	\N
309	FLOWTECH20BLXSG-202.5	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	20	B	LXSG-20		2.5			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 907	2022-03-29 00:00:00	2032-03-30 00:00:00	\N
310	FLOWTECH25BLXSG-253.5	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	25	B	LXSG-25		3.5			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 908	2022-03-29 00:00:00	2032-03-30 00:00:00	\N
311	FLOWTECH32BLXSG-326	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	32	B	LXSG-32		6			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 909	2022-03-29 00:00:00	2032-03-30 00:00:00	\N
312	FLOWTECH40BLXSG-4010	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	40	B	LXSG-40		10			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 910	2022-03-29 00:00:00	2032-03-30 00:00:00	\N
313	FLOWTECH50BLXSG-5015	FLOWTECH	FLOWTECH - Hebei Shanghong Meters Technology Co., Ltd. - Trung Quốc	50	B	LXSG-50		15			Công ty TNHH RIKA Việt Nam	285/29 Lê Văn Quới, Phường Bình Trị Đông, , Quận Tân Bình, TP. Hồ Chí Minh	PDM 75	2022-01-12 00:00:00	2032-01-30 00:00:00	\N
314	FUZHOUFUDA15BLXSG-15E1.5	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	15	B	LXSG-15E		1.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 871	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
315	FUZHOUFUDA20BLXS-20E2.5	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	20	B	LXS-20E		2.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 872	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
316	FUZHOUFUDA20BLXSG-20E2.5	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	20	B	LXSG-20E		2.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 873	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
317	FUZHOUFUDA25BLXS-25E3.5	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	25	B	LXS-25E		3.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 874	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
318	FUZHOUFUDA25BLXSG-25E3.5	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	25	B	LXSG-25E		3.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 875	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
319	FUZHOUFUDA32BLXS-32E6	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	32	B	LXS-32E		6			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 876	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
320	FUZHOUFUDA40BLXS-40E10	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	40	B	LXS-40E		10			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 877	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
321	FUZHOUFUDA40BLXSG-40E10	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	40	B	LXSG-40E		10			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 878	2016-06-03 00:00:00	2026-06-30 00:00:00	\N
322	FUZHOUFUDA50BLXS-50E15	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	50	B	LXS-50E		15			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 686	2016-05-10 00:00:00	2026-05-30 00:00:00	\N
323	FUZHOUFUDA50BLXSG-50E15	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	50	B	LXSG-50E		15			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 687	2016-05-10 00:00:00	2026-05-30 00:00:00	\N
324	FUZHOUFUDA80BLXL-80E40	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	80	B	LXL-80E		40			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 688	2016-05-10 00:00:00	2026-05-30 00:00:00	\N
325	FUZHOUFUDA80BLXLG-80E40	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	80	B	LXLG-80E		40			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 689	2016-05-10 00:00:00	2026-05-30 00:00:00	\N
326	FUZHOUFUDA100BLXL-100E60	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	100	B	LXL-100E		60			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 690	2016-05-10 00:00:00	2026-05-30 00:00:00	\N
327	FUZHOUFUDA100BLXLG-100E60	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	100	B	LXLG-100E		60			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 691	2016-05-10 00:00:00	2026-05-30 00:00:00	\N
328	FUZHOUFUDA32BLXSG-32E6	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	32	B	LXSG-32E		6			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 885	2016-06-07 00:00:00	2026-06-30 00:00:00	\N
329	FUZHOUFUDA15BLXS-15E1.5	FUZHOU FUDA	Fuzhou Fuda Meter Co.,Ltd. - Trung Quốc	15	B	LXS-15E		1.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 562	2016-04-07 00:00:00	2026-04-30 00:00:00	\N
330	FUZHOUFUDA150BLXLY-150E150	FUZHOU FUDA	Fuzhou Fuda Instrument & Meter Co., Ltd. (Trung Quốc)	150	B	LXLY-150E		150			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 4163	2019-08-30 00:00:00	2029-08-30 00:00:00	\N
331	FUZHOUFUDA200BLXLY-200E250	FUZHOU FUDA	Fuzhou Fuda Instrument & Meter Co., Ltd. (Trung Quốc)	200	B	LXLY-200E		250			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.Hà Nội	PDM 4164	2019-08-30 00:00:00	2029-08-30 00:00:00	\N
332	FUZHOUZENNER300BWPH-N600	Fuzhou Zenner	Zenner - Trung Quốc	300	B	WPH-N		600			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	475/QĐ-TĐC	2016-04-07 00:00:00	2026-04-30 00:00:00	\N
333	FUZHOUZENNER502WPD40100	Fuzhou Zenner	Fuzhou Zenner Water Meter Co.,Ltd. - Trung Quốc	50	2	WPD			40	100	Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 2456	2017-08-07 00:00:00	2027-08-30 00:00:00	\N
334	FUZHOUZENNER802WPD63100	Fuzhou Zenner	Fuzhou Zenner Water Meter Co.,Ltd. - Trung Quốc	80	2	WPD			63	100	Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 2457	2017-08-07 00:00:00	2027-08-30 00:00:00	\N
335	FUZHOUZENNER1002WPD100100	Fuzhou Zenner	Fuzhou Zenner Water Meter Co.,Ltd. - Trung Quốc	100	2	WPD			100	100	Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 2458	2017-08-07 00:00:00	2027-08-30 00:00:00	\N
336	FUZHOUZENNER1502WPD250100	Fuzhou Zenner	Fuzhou Zenner Water Meter Co.,Ltd. - Trung Quốc	150	2	WPD			250	100	Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 2459	2017-08-07 00:00:00	2027-08-30 00:00:00	\N
337	FUZHOUZENNER2002WPHD400100	Fuzhou Zenner	Fuzhou Zenner Water Meter Co.,Ltd. - Trung Quốc	200	2	WPHD			400	100	Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 833	2018-04-04 00:00:00	2028-04-30 00:00:00	\N
338	ZENNER80BWPH-N40	ZENNER	Zenner - Trung Quốc	80	B	WPH-N		40			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 876	2021-04-02 00:00:00	2031-03-30 00:00:00	\N
339	ZENNER100BWPH-N60	ZENNER	Zenner - Trung Quốc	100	B	WPH-N		60			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 877	2021-04-02 00:00:00	2031-03-30 00:00:00	\N
340	ZENNER50BWPH-N15	ZENNER	Zenner - Trung Quốc	50	B	WPH-N		15			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1268	2021-05-11 00:00:00	2031-05-31 00:00:00	\N
341	ZENNER65BWPH-N25	ZENNER	Zenner - Trung Quốc	65	B	WPH-N		25			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1269	2021-05-11 00:00:00	2031-05-31 00:00:00	\N
342	ZENNER150BWPH-N150	ZENNER	Zenner - Trung Quốc	150	B	WPH-N		150			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1270	2021-05-11 00:00:00	2031-05-31 00:00:00	\N
343	ZENNER200BWPH-N250	ZENNER	Zenner - Trung Quốc	200	B	WPH-N		250			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 737	2023-03-16 00:00:00	2033-03-30 00:00:00	\N
344	ZENNER25BMNK-RP3.5	ZENNER	Zenner - Trung Quốc	25	B	MNK-RP		3.5			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1254	2021-05-11 00:00:00	2031-05-30 00:00:00	\N
345	ZENNER32BMNK-RP6	ZENNER	Zenner - Trung Quốc	32	B	MNK-RP		6			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1255	2021-05-11 00:00:00	2031-05-30 00:00:00	\N
346	ZENNER40BMNK-RP10	ZENNER	Zenner - Trung Quốc	40	B	MNK-RP		10			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1256	2021-05-11 00:00:00	2031-05-30 00:00:00	\N
347	ZENNER50BMNK-RP15	ZENNER	Zenner - Trung Quốc	50	B	MNK-RP		15			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 1257	2021-05-11 00:00:00	2031-05-30 00:00:00	\N
348	JKLONG15BLXSY-15E1.5	JKLONG	Ningbo Jiekelong Water Meter Inc.-Trung Quốc	15	B	LXSY-15E		1.5			Công ty TNHH Điện lực Hiệp Phước	99 Phan Văn Bảy, Ấp 1, xã Hiệp Phước, huyện Nhà Bè, tp.HCM	PDM 387	2015-04-25 00:00:00	2025-04-30 00:00:00	\N
349	JKLONG20BLXSY-20E2.5	JKLONG	Ningbo Jiekelong Water Meter Inc.-Trung Quốc	20	B	LXSY-20E		2.5			Công ty TNHH Điện lực Hiệp Phước	99 Phan Văn Bảy, Ấp 1, xã Hiệp Phước, huyện Nhà Bè, tp.HCM	PDM 388	2015-04-25 00:00:00	2025-04-30 00:00:00	\N
350	JKLONG15BLXSL-15E1.5	JKLONG	Ningbo Jiekelong Water Meter Inc.-Trung Quốc	15	B	LXSL-15E		1.5			Công ty TNHH Điện lực Hiệp Phước	99 Phan Văn Bảy, Ấp 1, xã Hiệp Phước, huyện Nhà Bè, tp.HCM	PDM 572	2016-06-07 00:00:00	2026-06-30 00:00:00	\N
351	JKLONG20BLXSL-20E2.5	JKLONG	Ningbo Jiekelong Water Meter Inc.-Trung Quốc	20	B	LXSL-20E		2.5			Công ty TNHH Điện lực Hiệp Phước	99 Phan Văn Bảy, Ấp 1, xã Hiệp Phước, huyện Nhà Bè, tp.HCM	PDM 573	2016-06-07 00:00:00	2026-06-30 00:00:00	\N
352	KAMSTRUP152FLOWIQ21012.5250	Kamstrup 	Kamstrup A/S - Đan Mạch	15	2	flowIQ 2101			2.5	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	4E Đường số 6, Khu phố 4, Phường An Phú, tp. Thủ Đức, tp.HCM	PDM 1780	2021-06-18 00:00:00	2031-06-30 00:00:00	\N
353	KAMSTRUP202FLOWIQ21014250	Kamstrup 	Kamstrup A/S - Đan Mạch	20	2	flowIQ 2101			4	250	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	4E Đường số 6, Khu phố 4, Phường An Phú, tp. Thủ Đức, tp.HCM	PDM 1781	2021-06-18 00:00:00	2031-06-30 00:00:00	\N
354	KAMSTRUP252FLOWIQ31006.3160	Kamstrup 	Kamstrup A/S - Đan Mạch	25	2	flowIQ 3100			6.3	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	4E Đường số 6, Khu phố 4, Phường An Phú, tp. Thủ Đức, tp.HCM	PDM 1782	2021-06-18 00:00:00	2031-06-30 00:00:00	\N
355	KAMSTRUP322FLOWIQ310010160	Kamstrup 	Kamstrup A/S - Đan Mạch	32	2	flowIQ 3100			10	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	4E Đường số 6, Khu phố 4, Phường An Phú, tp. Thủ Đức, tp.HCM	PDM 1783	2021-06-18 00:00:00	2031-06-30 00:00:00	\N
356	KAMSTRUP402FLOWIQ310016160	Kamstrup 	Kamstrup A/S - Đan Mạch	40	2	flowIQ 3100			16	160	Công Ty Cổ Phần Kỹ Thuật Môi Trường Việt An	4E Đường số 6, Khu phố 4, Phường An Phú, tp. Thủ Đức, tp.HCM	PDM 1784	2021-06-18 00:00:00	2031-06-30 00:00:00	\N
357	KENT15CKSM1.5	KENT	GEORGE KENT (Malaysia) BERHAD-Malaysia	15	C	KSM		1.5			Công ty TNHH Đầu tư Xuất nhập khẩu Việt Mã	34 Trương Quyền, p6, q3, tp.HCM	1682/QĐ-TĐC	2016-08-03 00:00:00	2026-08-30 00:00:00	\N
358	KENT20CGKMPSM2.5	KENT	GEORGE KENT (Malaysia) BERHAD-Malaysia	20	C	GKM PSM		2.5			Công ty TNHH P.T.P	241 Điện Biên Phủ, p6, q3, tp.HCM	PDM 1360	2018-06-13 00:00:00	2028-06-30 00:00:00	\N
359	KENT25CGKMPSM3.5	KENT	GEORGE KENT (Malaysia) BERHAD-Malaysia	25	C	GKM PSM		3.5			Công ty TNHH P.T.P	241 Điện Biên Phủ, p6, q3, tp.HCM	PDM 1361	2018-06-13 00:00:00	2028-06-30 00:00:00	\N
360	KENT30CGKMPSM6	KENT	GEORGE KENT (Malaysia) BERHAD-Malaysia	30	C	GKM PSM		6			Công ty TNHH P.T.P	241 Điện Biên Phủ, p6, q3, tp.HCM	PDM 1362	2018-06-13 00:00:00	2028-06-30 00:00:00	\N
361	KENT40CGKMPSM10	KENT	GEORGE KENT (Malaysia) BERHAD-Malaysia	40	C	GKM PSM		10			Công ty TNHH P.T.P	241 Điện Biên Phủ, p6, q3, tp.HCM	PDM 1363	2018-06-13 00:00:00	2028-06-30 00:00:00	\N
362	KOMAX15BKM-15MM1.5	KOMAX	KOMAX - CS Engineering anh Trade Co.,Ltd. - Hàn Quốc	15	B	KM-15mm		1.5			Công ty TNHH TM DV XNK Minh Hòa Thành		PDM 1550	2017-08-04 00:00:00	2027-08-30 00:00:00	\N
363	KOMAX20BKM-20MM2.5	KOMAX	KOMAX - CS Engineering anh Trade Co.,Ltd. - Hàn Quốc	20	B	KM-20mm		2.5			Công ty TNHH TM DV XNK Minh Hòa Thành		PDM 1551	2017-08-04 00:00:00	2027-08-30 00:00:00	\N
364	KOMAX25BKM-25MM3.5	KOMAX	KOMAX - CS Engineering anh Trade Co.,Ltd. - Hàn Quốc	25	B	KM-25mm		3.5			Công ty TNHH TM DV XNK Minh Hòa Thành		PDM 1552	2017-08-04 00:00:00	2027-08-30 00:00:00	\N
365	KOMAX50BKM-50MM15	KOMAX	KOMAX - CS Engineering anh Trade Co.,Ltd. - Hàn Quốc	50	B	KM-50mm		15			Công ty TNHH TM DV XNK Minh Hòa Thành		PDM 1553	2017-08-04 00:00:00	2027-08-30 00:00:00	\N
366	KOMAX80BKM-80MM40	KOMAX	KOMAX - CS Engineering anh Trade Co.,Ltd. - Hàn Quốc	80	B	KM-80mm		40			Công ty TNHH TM DV XNK Minh Hòa Thành		1265/QĐ-TĐC	2017-08-04 00:00:00	2027-08-30 00:00:00	\N
367	KOMAX100BKM-100MM60	KOMAX	KOMAX - CS Engineering anh Trade Co.,Ltd. - Hàn Quốc	100	B	KM-100mm		60			Công ty TNHH TM DV XNK Minh Hòa Thành		1265/QĐ-TĐC	2017-08-04 00:00:00	2027-08-30 00:00:00	\N
368	KROHNE6002WATERFLUX3000IFC30063001000	Krohne	Krohne - Hà Lan	600	2	Waterflux 3000	IFC 300		6300	1000	Công ty TNHH Công nghệ Xanh Hoa Sen	12 Vũ Phương Đề, p.Thạnh Mỹ Lợi, q.2, tp.HCM	338/QĐ-TĐC	2016-03-11 00:00:00	2026-03-30 00:00:00	\N
369	Hết hạn	Linyi Gaoxiang	Linyi Gaoxiang Water Co.,Ltd. - Trung Quốc	15	B	LXS-15E		1.5			Công ty CP Thương mại Dịch vụ Môi trường Thuận Lâm Phát	52/29/7 Nguyễn Sỹ Sách, p.15, q.Tân Bình, tp.HCM	PDM 1171	2014-12-12 00:00:00	2024-12-31 00:00:00	\N
370	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	15	B	LXSG-15E		1.5			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	2246/QĐ-TĐC	2012-11-08 00:00:00	2022-11-30 00:00:00	\N
371	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	20	B	LXSG-20E		2.5			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	2246/QĐ-TĐC	2012-11-08 00:00:00	2022-11-30 00:00:00	\N
372	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	25	B	LXSG-25E		3.5			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	2246/QĐ-TĐC	2012-11-08 00:00:00	2022-11-30 00:00:00	\N
373	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	32	B	LXSG-32E		6			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
374	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	40	B	LXSG-40E		10			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
375	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	50	B	LXSG-50E		15			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
376	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	65	B	LXSG-65E		25			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
377	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	80	B	LXSG-80E		40			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
378	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	100	B	LXSG-100E		60			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
379	Hết hạn	MEIJI	MEIJI VALVE CO.,LTD. - Malaysia	150	B	LXSG-150E		150			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	1662/QĐ-TĐC	2013-06-10 00:00:00	2023-06-30 00:00:00	\N
380	MEIJI25BLXSGL-25E3.5	MEIJI	MEIJI - Malaysia	25	B	LXSGL-25E		3.5			Công ty CP Đầu tư Việt Phú Mỹ	68/30A đường Quang Trung, p.14, q.Gò Vấp, tp.HCM	PDM 325	2015-04-01 00:00:00	2025-04-30 00:00:00	\N
381	MERLION50BLXLC-5015	MERLION	MERLION - Trung Quốc	50	B	LXLC-50		15			Công ty TNHH Xuất nhập khẩu Trường Thanh	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	20/QĐ-TĐC	2015-01-12 00:00:00	2025-01-30 00:00:00	\N
382	MERLION80BLXLC-8040	MERLION	MERLION - Trung Quốc	80	B	LXLC-80		40			Công ty TNHH Xuất nhập khẩu Trường Thanh	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	20/QĐ-TĐC	2015-01-12 00:00:00	2025-01-30 00:00:00	\N
383	MERLION100BLXLC-10060	MERLION	MERLION - Trung Quốc	100	B	LXLC-100		60			Công ty TNHH Xuất nhập khẩu Trường Thanh	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	20/QĐ-TĐC	2015-01-12 00:00:00	2025-01-30 00:00:00	\N
384	Hết hạn	MERLION	MERLION - Trung Quốc	20	B	LXS-20		2.5			Công ty TNHH Xuất nhập khẩu Trường Thanh	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	998/QĐ-TĐC	2013-04-24 00:00:00	2023-04-30 00:00:00	\N
385	Hết hạn	MERLION	MERLION - Trung Quốc	25	B	LXS-25		3.5			Công ty TNHH Xuất nhập khẩu Trường Thanh	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	998/QĐ-TĐC	2013-04-24 00:00:00	2023-04-30 00:00:00	\N
386	MHC152MH-XK-152.580	MHC	MHC - Việt Nam	15	2	MH-XK-15			2.5	80	Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.HN	PDM 1305	2020-06-05 00:00:00	2030-06-30 00:00:00	\N
387	MHC152MHC-152.5160	MHC	MHC - Việt Nam	15	2	MHC-15			2.5	160	Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.HN	PDM 1306	2020-06-05 00:00:00	2030-06-30 00:00:00	\N
388	MIHA15BMH-15E1.5	MIHA	MIHA - Việt Nam	15	B	MH-15E		1.5			Công ty CP Đầu tư Minh Hòa	Lô B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm, HN	PDM 459	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
389	MIHA15BMD-151.5	MIHA	MIHA - Việt Nam	15	B	MD-15		1.5			Công ty CP Đầu tư Minh Hòa	Lô B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm, HN	PDM 460	2017-01-25 00:00:00	2027-01-30 00:00:00	\N
390	Hết hạn	NINGBO	NINGBO - Trung Quốc	15	B	LXSC-15E		1.5			Công ty TNHH MTV Kim Hồng Nguyên	P 606 khu B tòa nhà Indochina, số 4 đường Nguyễn Đình Chiểu,p.ĐaKao, q1, tp.HCM	2402/QĐ-TĐC	2012-11-22 00:00:00	2022-11-30 00:00:00	\N
391	Hết hạn	NINGBO	NINGBO - Trung Quốc	15	B	LXH-15E		1.5			Công ty TNHH MTV Kim Hồng Nguyên	P 606 khu B tòa nhà Indochina, số 4 đường Nguyễn Đình Chiểu,p.ĐaKao, q1, tp.HCM	2402/QĐ-TĐC	2012-11-22 00:00:00	2022-11-30 00:00:00	\N
392	Hết hạn	NINGBO	NINGBO - Trung Quốc	15	B	LXH-15B		1.5			Công ty TNHH MTV Kim Hồng Nguyên	P 606 khu B tòa nhà Indochina, số 4 đường Nguyễn Đình Chiểu,p.ĐaKao, q1, tp.HCM	2402/QĐ-TĐC	2012-11-22 00:00:00	2022-11-30 00:00:00	\N
393	Hết hạn	NINGBO	NINGBO - Trung Quốc	15	B	LXSC-15G	Mặt nhựa	1.5			Công ty TNHH MTV Kim Hồng Nguyên	P 606 khu B tòa nhà Indochina, số 4 đường Nguyễn Đình Chiểu,p.ĐaKao, q1, tp.HCM	2402/QĐ-TĐC	2012-11-22 00:00:00	2022-11-30 00:00:00	\N
394	Hết hạn	NINGBO	NINGBO - Trung Quốc	15	B	LXSC-15G	Mặt kính	1.5			Công ty TNHH MTV Kim Hồng Nguyên	P 606 khu B tòa nhà Indochina, số 4 đường Nguyễn Đình Chiểu,p.ĐaKao, q1, tp.HCM	2402/QĐ-TĐC	2012-11-22 00:00:00	2022-11-30 00:00:00	\N
395	NINGBOYINZHOU15BLXS-15E1.5	Ningbo Yinzhou	Ningbo Yinzhou Yongzhou Meters Co., Ltd. - Trung Quốc	15	B	LXS-15E		1.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.HN	PDM 886	2016-06-07 00:00:00	2026-06-30 00:00:00	\N
396	NINGBOYINZHOU15BLXSG-15E1.5	Ningbo Yinzhou	Ningbo Yinzhou Yongzhou Meters Co., Ltd. - Trung Quốc	15	B	LXSG-15E		1.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.HN	PDM 887	2016-06-07 00:00:00	2026-06-30 00:00:00	\N
397	NINGBOYINZHOU15BLXS-15EP1.5	Ningbo Yinzhou	Ningbo Yinzhou Yongzhou Meters Co., Ltd. - Trung Quốc	15	B	LXS-15EP		1.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.HN	PDM 805	2016-05-27 00:00:00	2026-05-30 00:00:00	\N
398	NINGBOYINZHOU15BLXSG-15EP1.5	Ningbo Yinzhou	Ningbo Yinzhou Yongzhou Meters Co., Ltd. - Trung Quốc	15	B	LXSG-15EP		1.5			Công ty CP Đầu tư Minh Hòa	B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm,tp.HN	PDM 806	2016-05-27 00:00:00	2026-05-30 00:00:00	\N
399	POWOGAZ152JS2,5-022.580	PowoGaz	Apator Powogaz S.A. - Ba Lan	15	2	JS2,5-02			2.5	80	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1213	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
400	POWOGAZ202JS4-024100	PowoGaz	Apator Powogaz S.A. - Ba Lan	20	2	JS4-02			4	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 589	2016-04-19 00:00:00	2026-04-30 00:00:00	\N
401	POWOGAZ502MWN5040100	PowoGaz	Apator Powogaz S.A. - Ba Lan	50	2	MWN 50			40	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 590	2016-04-19 00:00:00	2026-04-30 00:00:00	\N
402	POWOGAZ802MWN80100160	PowoGaz	Apator Powogaz S.A. - Ba Lan	80	2	MWN 80			100	160	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 591	2016-04-19 00:00:00	2026-04-30 00:00:00	\N
403	POWOGAZ1002MWN100160200	PowoGaz	Apator Powogaz S.A. - Ba Lan	100	2	MWN 100			160	200	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 592	2016-04-19 00:00:00	2026-04-30 00:00:00	\N
404	POWOGAZ152JS2,5-022.5100	PowoGaz	Apator Powogaz S.A. - Ba Lan	15	2	JS2,5-02			2.5	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 888	2016-06-24 00:00:00	2026-06-30 00:00:00	\N
405	POWOGAZ252WS6.36.3100	PowoGaz	Apator Powogaz S.A. - Ba Lan	25	2	WS6.3			6.3	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1719	2017-04-27 00:00:00	2027-04-30 00:00:00	\N
406	POWOGAZ322WS1010100	PowoGaz	Apator Powogaz S.A. - Ba Lan	32	2	WS10			10	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1720	2017-04-27 00:00:00	2027-04-30 00:00:00	\N
407	POWOGAZ402WS1616100	PowoGaz	Apator Powogaz S.A. - Ba Lan	40	2	WS16			16	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1721	2017-04-27 00:00:00	2027-04-30 00:00:00	\N
408	POWOGAZ652MWN6563125	PowoGaz	Apator Powogaz S.A. - Ba Lan	65	2	MWN65			63	125	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	577/QĐ-TĐC	2017-04-27 00:00:00	2027-04-30 00:00:00	\N
409	POWOGAZ252JS6,3-016.3100	PowoGaz	Apator Powogaz S.A. - Ba Lan	25	2	JS6,3-01			6.3	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 260	2018-02-06 00:00:00	2028-02-28 00:00:00	\N
410	POWOGAZ402JS16-0116100	PowoGaz	Apator Powogaz S.A. - Ba Lan	40	2	JS16-01			16	100	Công ty CP Quốc tế Thiền Sinh Thái	49 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 262	2018-08-21 00:00:00	2028-08-30 00:00:00	\N
411	POWOGAZ1252MWN125250160	PowoGaz	Apator Powogaz S.A. - Ba Lan	125	2	MWN125			250	160	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 263	2018-02-06 00:00:00	2028-02-28 00:00:00	\N
412	POWOGAZ322JS1010100	PowoGaz	Apator Powogaz S.A. - Ba Lan	32	2	JS10			10	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1166	2018-05-29 00:00:00	2028-05-30 00:00:00	\N
413	POWOGAZ402MWN4025100	PowoGaz	Apator Powogaz S.A. - Ba Lan	40	2	MWN40			25	100	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1167	2018-05-29 00:00:00	2028-05-30 00:00:00	\N
414	POWOGAZ1502MWN150400200	PowoGaz	Apator Powogaz S.A. - Ba Lan	150	2	MWN150			400	200	Công ty CP Quốc tế Thiền Sinh Thái	48 đường A4, p.12, q.Tân Bình, tp.HCM	PDM 1168	2018-05-29 00:00:00	2028-05-30 00:00:00	\N
415	POWOGAZ252JS6,3-086.3100	PowoGaz	Apator Powogaz S.A. - Ba Lan	25	2	JS6,3-08			6.3	100	Công ty CP Quốc tế Thiền Sinh Thái	41 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1193	2022-05-10 00:00:00	2032-05-30 00:00:00	\N
416	POWOGAZ322JS10-0810100	PowoGaz	Apator Powogaz S.A. - Ba Lan	32	2	JS10-08			10	100	Công ty CP Quốc tế Thiền Sinh Thái	41 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1194	2022-05-10 00:00:00	2032-05-30 00:00:00	\N
417	POWOGAZ402JS16-0816100	PowoGaz	Apator Powogaz S.A. - Ba Lan	40	2	JS16-08			16	100	Công ty CP Quốc tế Thiền Sinh Thái	41 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1195	2022-05-10 00:00:00	2032-05-30 00:00:00	\N
418	POWOGAZ502MWN50-0840100	PowoGaz	Apator Powogaz S.A. - Ba Lan	50	2	MWN50-08			40	100	Công ty CP Quốc tế Thiền Sinh Thái	42 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1423	2022-05-30 00:00:00	2032-05-30 00:00:00	\N
419	POWOGAZ652MWN65-0863125	PowoGaz	Apator Powogaz S.A. - Ba Lan	65	2	MWN65-08			63	125	Công ty CP Quốc tế Thiền Sinh Thái	43 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1424	2022-05-30 00:00:00	2032-05-30 00:00:00	\N
420	POWOGAZ802MWN80-08100160	PowoGaz	Apator Powogaz S.A. - Ba Lan	80	2	MWN80-08			100	160	Công ty CP Quốc tế Thiền Sinh Thái	44 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1425	2022-05-30 00:00:00	2032-05-30 00:00:00	\N
421	POWOGAZ1002MWN100-08160200	PowoGaz	Apator Powogaz S.A. - Ba Lan	100	2	MWN100-08			160	200	Công ty CP Quốc tế Thiền Sinh Thái	45 Thép Mới, p.12, q.Tân Bình, tp.HCM	PDM 1426	2022-05-30 00:00:00	2032-05-30 00:00:00	\N
422	RINCO15BLXSG-15E1.5	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	15	B	LXSG-15E		1.5			Công ty TNHH Vạn Bảo Phát	27-29 Ký Con, p.Nguyễn Thái Bình, Q1, tp.HCM	PDM 1200	2016-07-05 00:00:00	2026-07-30 00:00:00	\N
423	RINCO20BLXSG-20E2.5	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	20	B	LXSG-20E		2.5			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 2018	2020-08-27 00:00:00	2030-08-30 00:00:00	\N
424	RINCO25BLXSG-25E3.5	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	25	B	LXSG-25E		3.5			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 2019	2020-08-27 00:00:00	2030-08-30 00:00:00	\N
425	RINCO32BLXSG-32E6	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	32	B	LXSG-32E		6			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 4103	2020-12-25 00:00:00	2030-12-30 00:00:00	\N
426	RINCO40BLXSG-40E10	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	40	B	LXSG-40E		10			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 4104	2020-12-25 00:00:00	2030-12-30 00:00:00	\N
427	RINCO50BLXSG-50E15	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	50	B	LXSG-50E		15			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 4105	2020-12-25 00:00:00	2030-12-30 00:00:00	\N
428	RINCO15BLXSL-15E1.5	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	15	B	LXSL-15E		1.5			Công ty TNHH Vạn Bảo Phát	27-29 Ký Con, p.Nguyễn Thái Bình, Q1, tp.HCM	PDM 1264	2017-02-17 00:00:00	2027-02-28 00:00:00	\N
429	RINCO20BLXSL-20E2.5	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	20	B	LXSL-20E		2.5			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 2016	2020-08-27 00:00:00	2030-08-30 00:00:00	\N
430	RINCO25BLXSL-25E3.5	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	25	B	LXSL-25E		3.5			Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 2017	2020-08-27 00:00:00	2030-08-30 00:00:00	\N
431	RINCO652LXLC-65E4050	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	65	2	LXLC-65E			40	50	Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 4106	2020-12-25 00:00:00	2030-12-30 00:00:00	\N
432	RINCO802LXLC-80E6350	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	80	2	LXLC-80E			63	50	Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 2020	2020-08-27 00:00:00	2030-08-30 00:00:00	\N
433	RINCO1002LXLC-100E10050	RINCO	Rinco - Chuan Hong Precision Tool Mfg.Co.,Ltd. - Đài Loan	100	2	LXLC-100E			100	50	Công ty TNHH Vạn Bảo Phát	L17-11, Tầng 17, Tòa Nhà Vincom Center, Số 72 Lê Thánh Tôn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 2021	2020-08-27 00:00:00	2030-08-30 00:00:00	\N
434	T-FLOW50BT-FLOW15	T-FLOW	Actechna Global SDN.BHD. - Malaysia	50	B	T-FLOW		15			Công ty TNHH TM và XNK Bình Phát Việt Nam	Số 248 Nguyễn Văn Linh, Long Biên, Hà Nội	PDM 1300	2019-05-06 00:00:00	2029-05-30 00:00:00	\N
435	T-FLOW80BT-FLOW40	T-FLOW	Actechna Global SDN.BHD. - Malaysia	80	B	T-FLOW		40			Công ty TNHH TM và XNK Bình Phát Việt Nam	Số 248 Nguyễn Văn Linh, Long Biên, Hà Nội	PDM 1301	2019-05-06 00:00:00	2029-05-30 00:00:00	\N
436	T-FLOW100BT-FLOW60	T-FLOW	Actechna Global SDN.BHD. - Malaysia	100	B	T-FLOW		60			Công ty TNHH TM và XNK Bình Phát Việt Nam	Số 248 Nguyễn Văn Linh, Long Biên, Hà Nội	PDM 1302	2019-05-06 00:00:00	2029-05-30 00:00:00	\N
437	T-FLOW150BT-FLOW150	T-FLOW	Actechna Global SDN.BHD. - Malaysia	150	B	T-FLOW		150			Công ty TNHH TM và XNK Bình Phát Việt Nam	Số 248 Nguyễn Văn Linh, Long Biên, Hà Nội	PDM 1303	2019-05-06 00:00:00	2029-05-30 00:00:00	\N
438	T-FLOW50BT-FLOW15	T-FLOW	Actechna Global SDN.BHD. - Malaysia	50	B	T-FLOW		15			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội	PDM 1300	2019-05-06 00:00:00	2029-05-06 00:00:00	\N
439	T-FLOW80BT-FLOW40	T-FLOW	Actechna Global SDN.BHD. - Malaysia	80	B	T-FLOW		40			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội	PDM 1301	2019-05-06 00:00:00	2029-05-06 00:00:00	\N
440	T-FLOW100BT-FLOW60	T-FLOW	Actechna Global SDN.BHD. - Malaysia	100	B	T-FLOW		60			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội	PDM 1302	2019-05-06 00:00:00	2029-05-06 00:00:00	\N
441	T-FLOW150BT-FLOW150	T-FLOW	Actechna Global SDN.BHD. - Malaysia	150	B	T-FLOW		150			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội	PDM 1303	2019-05-06 00:00:00	2029-05-06 00:00:00	\N
442	T-FLOW65BT-FLOW25	T-FLOW	Actechna Global SDN.BHD. - Malaysia	65	B	T-FLOW		25			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội		2019-08-07 00:00:00	2029-08-30 00:00:00	\N
443	T-FLOW125BT-FLOW100	T-FLOW	Actechna Global SDN.BHD. - Malaysia	125	B	T-FLOW		100			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội		2019-08-07 00:00:00	2029-08-30 00:00:00	\N
444	T-FLOW200BT-FLOW250	T-FLOW	Actechna Global SDN.BHD. - Malaysia	200	B	T-FLOW		250			Công ty TNHH General Lê Nguyễn	số 80, ngõ 8, xóm Cầu Bươu, xã Tả Thanh Oai, huyện Thanh Trì, thành phố Hà Nội		2019-08-07 00:00:00	2029-08-30 00:00:00	\N
445	BẢOTÍN15BSANPO-15E1.5	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	15	B	SANPO-15E		1.5			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1158	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
446	BẢOTÍN20BSANPO-20E2.5	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	20	B	SANPO-20E		2.5			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1159	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
447	BẢOTÍN32BSANPO-32E6	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	32	B	SANPO-32E		6			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1160	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
448	BẢOTÍN40BSANPO-40E10	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	40	B	SANPO-40E		10			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1161	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
449	BẢOTÍN50BSANPO-50E15	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	50	B	SANPO-50E		15			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1162	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
450	BẢOTÍN65BSANPO-65E25	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	65	B	SANPO-65E		25			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1163	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
451	BẢOTÍN80BSANPO-80E40	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	80	B	SANPO-80E		40			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1164	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
452	BẢOTÍN100BSANPO-100E60	BẢO TÍN	BẢO TÍN - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	100	B	SANPO-100E		60			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1165	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
453	SANPO15CLXH-151.5	SANPO	SANPO - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	15	C	LXH-15		1.5			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1166	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
454	SANPO20CLXH-202.5	SANPO	SANPO - Ningbo Cixi Import and Export Holdings Co., Ltd. - China	20	C	LXH-20		2.5			Công ty TNHH TM DV XNK Minh Hòa Thành	C62 Khu Dân Cư Thới An, Đường Lê Thị Riêng, Phường Thới An, Quận 12, Thành Phố Hồ Chí Minh	PDM 1167	2021-04-26 00:00:00	2031-04-30 00:00:00	\N
455	SHINHAN15BBSJ1.5	SHINHAN	SHINHAN - Hàn Quốc	15	B	BSJ		1.5			Công ty TNHH Cơ khí chính xác Chang Se 	121/9 Hồng Hà, p.2, q.Tân Bình, tp.HCM	318/QĐ-TĐC	2015-04-22 00:00:00	2025-04-30 00:00:00	\N
456	SHINHAN15BBMJ1.5	SHINHAN	SHINHAN - Hàn Quốc	15	B	BMJ		1.5			Công ty TNHH Cơ khí chính xác Chang Se 	121/9 Hồng Hà, p.2, q.Tân Bình, tp.HCM	318/QĐ-TĐC	2015-04-22 00:00:00	2025-04-30 00:00:00	\N
457	SHINHAN20BBSJ2.5	SHINHAN	SHINHAN - Hàn Quốc	20	B	BSJ		2.5			Công ty TNHH Cơ khí chính xác Chang Se 	121/9 Hồng Hà, p.2, q.Tân Bình, tp.HCM	318/QĐ-TĐC	2015-04-22 00:00:00	2025-04-30 00:00:00	\N
458	SHINHAN25BBMJ3.5	SHINHAN	SHINHAN - Hàn Quốc	25	B	BMJ		3.5			Công ty TNHH Cơ khí chính xác Chang Se 	121/9 Hồng Hà, p.2, q.Tân Bình, tp.HCM	318/QĐ-TĐC	2015-04-22 00:00:00	2025-04-30 00:00:00	\N
459	SIEMENS6002MAG8000250080	SIEMENS	Siemens - Pháp	600	2	MAG 8000			2500	80	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	217/QĐ-TĐC	2015-02-13 00:00:00	2025-02-28 00:00:00	\N
460	Hết hạn	SIEMENS	Siemens - Pháp	25	2	SITRANS F M MAG 8000			4	25	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	PDM 194	2014-05-16 00:00:00	2024-05-30 00:00:00	\N
461	Hết hạn	SIEMENS	Siemens - Pháp	40	2	SITRANS F M MAG 8000			10	25	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	PDM 195	2014-05-16 00:00:00	2024-05-30 00:00:00	\N
462	SIEMENS502SITRANSFMMAG800063160	SIEMENS	Siemens - Pháp	50	2	SITRANS F M MAG 8000			63	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1600	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
463	SIEMENS802SITRANSFMMAG8000160160	SIEMENS	Siemens - Pháp	80	2	SITRANS F M MAG 8000			160	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1601	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
464	SIEMENS1002SITRANSFMMAG8000250160	SIEMENS	Siemens - Pháp	100	2	SITRANS F M MAG 8000			250	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1602	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
465	SIEMENS1502SITRANSFMMAG8000630160	SIEMENS	Siemens - Pháp	150	2	SITRANS F M MAG 8000			630	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1603	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
466	SIEMENS2002SITRANSFMMAG80001000160	SIEMENS	Siemens - Pháp	200	2	SITRANS F M MAG 8000			1000	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1604	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
467	SIEMENS2502SITRANSFMMAG80001600160	SIEMENS	Siemens - Pháp	250	2	SITRANS F M MAG 8000			1600	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1605	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
468	SIEMENS3002SITRANSFMMAG80002500160	SIEMENS	Siemens - Pháp	300	2	SITRANS F M MAG 8000			2500	160	Công ty TNHH SIEMENS	Số 33, Đường Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh	PDM 1606	2020-07-17 00:00:00	2030-07-30 00:00:00	\N
469	Hết hạn	SIEMENS	Siemens - Pháp	50	2	SITRANS F M MAG 8000 CT			16	25	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
470	Hết hạn	SIEMENS	Siemens - Pháp	65	2	SITRANS F M MAG 8000 CT			25	25	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
471	Hết hạn	SIEMENS	Siemens - Pháp	80	2	SITRANS F M MAG 8000 CT			100	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
472	Hết hạn	SIEMENS	Siemens - Pháp	100	2	SITRANS F M MAG 8000 CT			160	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
473	Hết hạn	SIEMENS	Siemens - Pháp	125	2	SITRANS F M MAG 8000 CT			250	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
474	Hết hạn	SIEMENS	Siemens - Pháp	150	2	SITRANS F M MAG 8000 CT			400	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
475	Hết hạn	SIEMENS	Siemens - Pháp	200	2	SITRANS F M MAG 8000 CT			630	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
476	Hết hạn	SIEMENS	Siemens - Pháp	250	2	SITRANS F M MAG 8000 CT			1000	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
477	Hết hạn	SIEMENS	Siemens - Pháp	300	2	SITRANS F M MAG 8000 CT			1600	160	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1784/QĐ-TĐC	2012-09-12 00:00:00	2022-09-30 00:00:00	\N
478	SIEMENSS.A.S10002MAG5100W630040	SIEMENS S.A.S	Siemens - Pháp	1000	2	MAG 5100W			6300	40	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1286/QĐ-TĐC	2015-08-18 00:00:00	2025-08-30 00:00:00	\N
479	SIEMENSS.A.S10002MAG5000630040	SIEMENS S.A.S	Siemens - Pháp	1000	2	MAG 5000			6300	40	Công ty TNHH Siemens Việt Nam	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	1286/QĐ-TĐC	2015-08-18 00:00:00	2025-08-30 00:00:00	\N
480	SIEMENS502SITRANSFMMAG5100WSITRANSFMMAG50001663	SIEMENS	Siemens S.A.S - Pháp	50	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		16	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4924	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
481	SIEMENS652SITRANSFMMAG5100WSITRANSFMMAG50002563	SIEMENS	Siemens S.A.S - Pháp	65	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		25	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4925	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
482	SIEMENS802SITRANSFMMAG5100WSITRANSFMMAG50004063	SIEMENS	Siemens S.A.S - Pháp	80	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		40	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4926	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
483	SIEMENS1002SITRANSFMMAG5100WSITRANSFMMAG5000160160	SIEMENS	Siemens S.A.S - Pháp	100	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		160	160	Công ty TNHH Siemens	5B Tôn Đức Thắng, p.Bến Nghé, q.1, tp.HCM	PDM 939	2015-07-16 00:00:00	2025-07-30 00:00:00	\N
484	SIEMENS1252SITRANSFMMAG5100WSITRANSFMMAG500010063	SIEMENS	Siemens S.A.S - Pháp	125	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		100	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4927	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
485	SIEMENS1502SITRANSFMMAG5100WSITRANSFMMAG500016063	SIEMENS	Siemens S.A.S - Pháp	150	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		160	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4928	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
486	SIEMENS2002SITRANSFMMAG5100WSITRANSFMMAG500025063	SIEMENS	Siemens S.A.S - Pháp	200	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		250	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4929	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
487	SIEMENS2502SITRANSFMMAG5100WSITRANSFMMAG500040063	SIEMENS	Siemens S.A.S - Pháp	250	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		400	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4930	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
488	SIEMENS3002SITRANSFMMAG5100WSITRANSFMMAG500063063	SIEMENS	Siemens S.A.S - Pháp	300	2	SITRANS F M MAG 5100 W	SITRANS F M MAG 5000		630	63	Công ty TNHH Siemens	33 Lê Duẩn, Phường Bến Nghé, Quận 1, TP. HCM	PDM 4931	2019-11-22 00:00:00	2029-11-30 00:00:00	\N
489	UNIK50BLXSG-50E15	UNIK	UNIK - Đài Loan	50	B	LXSG-50E		15			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 1796	2018-07-25 00:00:00	2028-06-30 00:00:00	\N
490	UNIK32BLXSG-32E6	UNIK	UNIK - Đài Loan	32	B	LXSG-32E		6			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 312	2018-02-08 00:00:00	2028-01-30 00:00:00	\N
491	UNIK40BLXSG-40E10	UNIK	UNIK - Đài Loan	40	B	LXSG-40E		10			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 313	2018-02-08 00:00:00	2028-01-30 00:00:00	\N
492	UNIK15BLXSG-15E1.5	UNIK	UNIK - Đài Loan	15	B	LXSG-15E		1.5			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 1601	2017-03-27 00:00:00	2027-03-30 00:00:00	\N
493	UNIK20BLXSG-20E2.5	UNIK	UNIK - Đài Loan	20	B	LXSG-20E		2.5			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 1797	2018-07-25 00:00:00	2028-07-30 00:00:00	\N
494	UNIK25BLXSG-25E3.5	UNIK	UNIK - Đài Loan	25	B	LXSG-25E		3.5			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 1904	2017-05-24 00:00:00	2027-05-30 00:00:00	\N
495	Hết hạn	UNIK	UNIK - Đài Loan	20	B	LXSLG-20E		2.5			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	3020/QĐ-TĐC	2013-09-30 00:00:00	2023-09-30 00:00:00	\N
496	Hết hạn	UNIK	SHENG AN HANG VALVE MACHINERY CO., LTD. - Đài Loan	15	B	LXSLG-15E		1.5			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 876	2014-10-31 00:00:00	2024-10-30 00:00:00	\N
497	Hết hạn	UNIK	SHENG AN HANG VALVE MACHINERY CO., LTD. - Đài Loan	65	B	LXLG-65		25			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 877	2014-10-31 00:00:00	2024-10-30 00:00:00	\N
498	UNIK25BLXSLG-25E3.5	UNIK	UNIK - Đài Loan	25	B	LXSLG-25E		3.5			Công ty TNHH Công nghiệp Liên Việt	188/28/10 Nguyễn Súy, p.Tân Quý, p.Tân Phú, tp.HCM	PDM 1905	2017-05-24 00:00:00	2027-05-30 00:00:00	\N
499	YUNNAN15BLXS-15E1.5	Yunnan	Yunnan - Trung Quốc	15	B	LXS-15E		1.5			Công ty TNHH XNK-TM-DV Phương Loan	G15 Thống Nhất, p.10, q.Gò Vấp, tp.HCM	754/QĐ-TĐC	2016-05-19 00:00:00	2026-05-30 00:00:00	\N
500	MIHA20BMH-20E2.5	MIHA	MINH HÒA - VIỆT NAM	20	B	MH-20E		2.5			Công ty CP Đầu tư Minh Hòa	Lô B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm, HN	PDM 2781	2017-09-15 00:00:00	2027-09-30 00:00:00	\N
501	MIHA20BMD-202.5	MIHA	MINH HÒA - VIỆT NAM	20	B	MD-20		2.5			Công ty CP Đầu tư Minh Hòa	Lô B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm, HN	PDM 2782	2017-09-15 00:00:00	2027-09-30 00:00:00	\N
502	MIHA25BMH-25E3.5	MIHA	MINH HÒA - VIỆT NAM	25	B	MH-25E		3.5			Công ty CP Đầu tư Minh Hòa	Lô B2-4-4 KCN Nam Thăng Long, p.Thụy Phương, q.Bắc Từ Liêm, HN	PDM 2783	2017-09-15 00:00:00	2027-09-30 00:00:00	\N
503	Hết hạn	MERLION	MERLION - Trung Quốc	15	B	LXSG-15		1.5			Công ty TNHH Xuất nhập khẩu Trường Thanh	85 ngõ 144 đường Quan Nhân, p.Nhân Chính, q.Thanh Xuân, tp.HN	PDM 271	2014-11-13 00:00:00	2024-06-30 00:00:00	\N
504	Hết hạn	Sensus	Sensus - Đức	40	B	WP-Dynamic 40		15			Công ty TNHH Công nghệ Xanh Hoa Sen	Số 16, Đường số 6, khu dân cư số 5-143ha, p.Thạnh Mỹ Lợi, Quận 2, TP. HCM	PDM 272 	2014-06-12 00:00:00	2024-06-30 00:00:00	\N
505	Hết hạn	Sensus	Sensus - Đức	50	B	WP-Dynamic 50		15			Công ty TNHH Công nghệ Xanh Hoa Sen	Số 16, Đường số 6, khu dân cư số 5-143ha, p.Thạnh Mỹ Lợi, Quận 2, TP. HCM	PDM 273	2014-06-12 00:00:00	2024-06-30 00:00:00	\N
506	SENSUS65BWP-DYNAMIC6525	Sensus	Sensus GmbH Hannover - CHLB Đức	65	B	WP-Dynamic 65		25			Công ty TNHH Công nghệ Xanh Hoa Sen	Số 16, Đường số 6, khu dân cư số 5-143ha, p.Thạnh Mỹ Lợi, Quận 2, TP. HCM	PDM 477	2018-03-02 00:00:00	2028-03-30 00:00:00	\N
507	Hết hạn	Sensus	Sensus - Đức	80	B	WP-Dynamic 80		40			Công ty TNHH Công nghệ Xanh Hoa Sen	Số 16, Đường số 6, khu dân cư số 5-143ha, p.Thạnh Mỹ Lợi, Quận 2, TP. HCM	PDM 274	2014-06-12 00:00:00	2024-06-30 00:00:00	\N
508	Hết hạn	Sensus	Sensus - Đức	100	B	WP-Dynamic 100		60			Công ty TNHH Công nghệ Xanh Hoa Sen	Số 16, Đường số 6, khu dân cư số 5-143ha, p.Thạnh Mỹ Lợi, Quận 2, TP. HCM	PDM 275	2014-06-12 00:00:00	2024-06-30 00:00:00	\N
509	VPM15BLXSG-151.5	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	15	B	LXSG-15		1.5			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1796	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
510	VPM20BLXSG-202.5	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	20	B	LXSG-20		2.5			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1797	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
511	VPM25BLXSG-253.5	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	25	B	LXSG-25		3.5			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1798	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
512	VPM32BLXSG-326	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	32	B	LXSG-32		6			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1799	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
513	VPM40BLXSG-4010	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	40	B	LXSG-40		10			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1800	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
514	VPM50BLXLC-5015	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	50	B	LXLC-50		15			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1801	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
515	VPM65BLXLC-6525	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	65	B	LXLC-65		25			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1802	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
516	VPM80BLXLC-8040	VPM	VPM - Cixi Cidong Instrument Co.,Ltd. - Trung Quốc	80	B	LXLC-80		40			Công ty TNHH Vật tư Việt Phú	205 Lý Thường Kiệt, phường 6, quận Tân Bình, tp. HCM	PDM 1803	2017-05-17 00:00:00	2027-05-30 00:00:00	\N
517	ITRON502WOLTEX40100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	50	2	WOLTEX			40	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 765	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
518	ITRON652WOLTEX63100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	65	2	WOLTEX			63	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 766	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
519	ITRON802WOLTEX100100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	80	2	WOLTEX			100	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 767	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
520	ITRON1002WOLTEX160100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	100	2	WOLTEX			160	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 768	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
521	ITRON1252WOLTEX160100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	125	2	WOLTEX			160	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 769	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
522	ITRON1502WOLTEX400100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	150	2	WOLTEX			400	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 770	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
523	ITRON2002WOLTEX630100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	200	2	WOLTEX			630	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 771	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
524	ITRON2502WOLTEX1000100	Itron	Itron - Ganz Meter Company Ltd. - Hungary	250	2	WOLTEX			1000	100	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 772	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
525	ITRON200BWOLTEXM400	Itron	Itron - Ganz Meter Company Ltd. - Hungary	200	B	WOLTEX M		400			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 773	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
526	ITRON250BWOLTEXM400	Itron	Itron - Ganz Meter Company Ltd. - Hungary	250	B	WOLTEX M		400			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 774	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
527	ITRON300BWOLTEXM600	Itron	Itron - Ganz Meter Company Ltd. - Hungary	300	B	WOLTEX M		600			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 775	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
528	ITRON252FLODIS6.3160	Itron	Itron - Pháp	25	2	Flodis			6.3	160	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 776	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
529	ITRON322FLODIS10160	Itron	Itron - Pháp	32	2	Flodis			10	160	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 777	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
530	ITRON402FLOSTARM16160	Itron	Itron - Pháp	40	2	Flostar M			16	160	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 778	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
531	ITRON502FLOSTARM25250	Itron	Itron - Pháp	50	2	Flostar M			25	250	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 779	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
532	ITRON652FLOSTARM40315	Itron	Itron - Pháp	65	2	Flostar M			40	315	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 780	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
533	ITRON802FLOSTARM63315	Itron	Itron - Pháp	80	2	Flostar M			63	315	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 781	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
534	ITRON1002FLOSTARM100315	Itron	Itron - Pháp	100	2	Flostar M			100	315	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 782	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
535	ITRON1502FLOSTARM160315	Itron	Itron - Pháp	150	2	Flostar M			160	315	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 783	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
536	ITRON-BRAZIL25BMULTIMAGCYBLE3.5	Itron - Brazil	Itron - Brazil	25	B	Multimag Cyble		3.5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 784	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
537	ITRON30BMULTIMAGCYBLE5	Itron	Itron - Brazil	30	B	Multimag Cyble		5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 785	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
538	ITRON-BRAZIL40BMULTIMAGCYBLE10	Itron - Brazil	Itron - Brazil	40	B	Multimag Cyble		10			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 786	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
539	ITRON50BMULTIMAGCYBLE15	Itron	Itron - Brazil	50	B	Multimag Cyble		15			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 787	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
540	ITRON-INDONESIA25BMULTIMAGCYBLE3.5	Itron - Indonesia	Itron - Indonesia	25	B	Multimag Cyble		3.5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 788	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
541	ITRON-INDONESIA40BMULTIMAGCYBLE10	Itron - Indonesia	Itron - Indonesia	40	B	Multimag Cyble		10			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 789	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
542	ITRON202FLODIS4160	Itron	Itron - Ý	20	2	Flodis			4	160	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 790	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
543	ITRON152NEVOS2.5160	Itron	Itron - Indonesia	15	2	Nevos			2.5	160	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 791	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
544	ITRON152TD882.5160	Itron	Itron - Indonesia	15	2	TD88			2.5	160	Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 792	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
545	ITRON20BMULTIMAGCYBLE2.5	Itron	Itron - Indonesia	20	B	Multimag Cyble		2.5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 793	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
546	ITRON15BMULTIMAG-TỐCĐỘĐATIA1.5	Itron	Itron - Indonesia	15	B	Multimag - Tốc độ đa tia		1.5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 794	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
547	ITRON15CTD881.5	Itron	Itron - Indonesia	15	C	TD88		1.5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 795	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
548	ITRON15CMULTIMAG-S1.5	Itron	Itron - Indonesia	15	C	Multimag - S		1.5			Công ty Cổ phần DNP Hawaco	Số 25 Phố Lý Thường kiệt, Phường Phan Chu Trinh, Quận Hoàn Kiếm, thành phố Hà Nội	PDM 796	2020-03-26 00:00:00	2030-03-30 00:00:00	\N
549	NINGBO20BLXSY-20E12.5	Ningbo	Ningbo Yonggang Instrument Co., Ltd. - Trung Quốc	20	B	LXSY-20E1		2.5			Công ty Cổ phần Thiết kế và Xây lắp MICO E&C	Số 8/55 Hoàng Hoa Thám, p.Ngọc Hà, q.Ba Đình, tp.Hà Nội	PDM 677	2018-03-26 00:00:00	2028-03-30 00:00:00	\N
550	YAVUZ152KDM22.5100	Yavuz	Yavuz Metal Sanayi Ve Ticaret Anonim Sirketi - Thổ Nhĩ Kỳ	15	2	KDM2			2.5	100	Công ty CP Đầu tư và Phát triển THN	Số 12TT21 KĐT mới Văn Phú, p.Phú La, q.Hà Đông, tp.Hà Nội	PDM 232	2018-02-08 00:00:00	2028-02-28 00:00:00	\N
551	Hết hạn	Phu Thinh	Phú Thịnh - Việt Nam	15	B	PT 316		1.5			Công ty TNHH Vật tư ngành nước Phú Thịnh	C5 + C6 KCN Đình Trám, xã Hoàng Ninh, huyện Việt Yên, tỉnh Bắc Giang	PDM 528	2014-07-29 00:00:00	2024-07-30 00:00:00	\N
552	Hết hạn	Phu Thinh	Phú Thịnh - Việt Nam	20	B	PT 511		2.5			Công ty TNHH Vật tư ngành nước Phú Thịnh	C5 + C6 KCN Đình Trám, xã Hoàng Ninh, huyện Việt Yên, tỉnh Bắc Giang	PDM 529	2014-07-29 00:00:00	2024-07-30 00:00:00	\N
553	MKC15BMKM151.5	MKC	MKC - Việt Nam	15	B	MKM 15		1.5			Công ty Cổ phần Đầu tư và Phát triển MKC Việt Nam	Số 32 Đại Từ, p.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 056	2022-01-11 00:00:00	2032-01-30 00:00:00	\N
554	MKC15BMKMP151.5	MKC	MKC - Việt Nam	15	B	MKM P15		1.5			Công ty Cổ phần Đầu tư và Phát triển MKC Việt Nam	Số 32 Đại Từ, p.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 057	2022-01-11 00:00:00	2032-01-30 00:00:00	\N
555	MKC152MKC152.5160	MKC	MKC - Việt Nam	15	2	MKC 15			2.5	160	Công ty Cổ phần Đầu tư và Phát triển MKC Việt Nam	Số 32 Đại Từ, p.Đại Kim, q.Hoàng Mai, tp.Hà Nội	PDM 058	2022-01-11 00:00:00	2032-01-30 00:00:00	\N
556	VASA15BLXSG-15E1.5	Vasa	AUT RESOURCES SDN BHD - Malaysia	15	B	LXSG-15E		1.5			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2811	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
557	VASA20BLXSG-20E2.5	Vasa	AUT RESOURCES SDN BHD - Malaysia	20	B	LXSG-20E		2.5			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2812	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
558	VASA25BLXSG-25E3.5	Vasa	AUT RESOURCES SDN BHD - Malaysia	25	B	LXSG-25E		3.5			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2813	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
559	VASA32BLXSG-32E6	Vasa	AUT RESOURCES SDN BHD - Malaysia	32	B	LXSG-32E		6			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2814	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
560	VASA40BLXSG-40E10	Vasa	AUT RESOURCES SDN BHD - Malaysia	40	B	LXSG-40E		10			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2815	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
561	VASA50BLXSG-50E15	Vasa	AUT RESOURCES SDN BHD - Malaysia	50	B	LXSG-50E		15			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2816	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
562	VASA50BLXLC-5015	Vasa	AUT RESOURCES SDN BHD - Malaysia	50	B	LXLC-50		15			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2817	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
563	VASA65BLXLC-6525	Vasa	AUT RESOURCES SDN BHD - Malaysia	65	B	LXLC-65		25			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2818	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
564	VASA80BLXLC-8040	Vasa	AUT RESOURCES SDN BHD - Malaysia	80	B	LXLC-80		40			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2819	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
565	VASA100BLXLC-10060	Vasa	AUT RESOURCES SDN BHD - Malaysia	100	B	LXLC-100		60			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2820	2022-10-26 00:00:00	2032-10-30 00:00:00	\N
566	AUT-CN&TBHT15BLXSG-15E1.5	AUT-CN&TB HT	AUT RESOURCES SDN BHD - Malaysia	15	B	LXSG-15E		1.5			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2252	2019-05-21 00:00:00	2029-05-30 00:00:00	\N
567	AUT-CN&TBHT15BLXSG-20E1.5	AUT-CN&TB HT	AUT RESOURCES SDN BHD - Malaysia	15	B	LXSG-20E		1.5			Công ty TNHH Đầu tư Công nghệ & Thiết bị HT	Số 53 Nguyễn Khả Trạc, p.Mai Dịch, q.Cầu Giấy, tp.Hà Nội	PDM 2253	2019-05-21 00:00:00	2029-05-30 00:00:00	\N
568	HANSUNG402HS1000-404040	Hansung	Hansung Innovation Co.,Ltd. - Hàn Quốc	40	2	HS1000-40			40	40	Công ty TNHH Thương mại Tuấn Hưng Phát	Số 184 phố Hoàng Văn Thái, p.Khương Mai, q.Thanh Xuân, tp.Hà Nội	PDM 4395	2021-12-17 00:00:00	2031-12-31 00:00:00	\N
569	HANSUNG502HS1000-50640	Hansung	Hansung Innovation Co.,Ltd. - Hàn Quốc	50	2	HS1000-50			6	40	Công ty TNHH Thương mại Tuấn Hưng Phát	Số 184 phố Hoàng Văn Thái, p.Khương Mai, q.Thanh Xuân, tp.Hà Nội	PDM 4396	2021-12-17 00:00:00	2031-12-31 00:00:00	\N
570	TAC15BMIC151.5	TAC	UHM Việt Nam	15	B	MIC15		1.5			Công ty TNHH UHM Việt Nam	Lô 2 đường TS 16, KCN Tiên Sơn, h.Tiên Du, t.Bắc Ninh	PDM 010	2021-01-22 00:00:00	2031-01-30 00:00:00	\N
571	TAC15BMIB151.5	TAC	UHM Việt Nam	15	B	MIB15		1.5			Công ty TNHH UHM Việt Nam	Lô 2 đường TS 16, KCN Tiên Sơn, h.Tiên Du, t.Bắc Ninh	PDM 011	2021-01-22 00:00:00	2031-01-30 00:00:00	\N
572	TAC20BMAM202.5	TAC	UHM Việt Nam	20	B	MAM20		2.5			Công ty TNHH UHM Việt Nam	Lô 2 đường TS 16, KCN Tiên Sơn, h.Tiên Du, t.Bắc Ninh	PDM 012	2021-01-22 00:00:00	2031-01-30 00:00:00	\N
573	TAC25BMAM253.5	TAC	UHM Việt Nam	25	B	MAM25		3.5			Công ty TNHH UHM Việt Nam	Lô 2 đường TS 16, KCN Tiên Sơn, h.Tiên Du, t.Bắc Ninh	PDM 013	2021-01-22 00:00:00	2031-01-30 00:00:00	\N
574	ZENNER125BWPH-N100	ZENNER	Zenner - Trung Quốc	125	B	WPH-N		100			Công ty Liên doanh TNHH đồng hồ nước Zenner-Coma	125D Minh Khai, p.Minh Khai, q.Hai Bà Trưng, tp.Hà Nội	PDM 3065	2016-05-11 00:00:00	2026-05-30 00:00:00	\N
575	LIANYUNGANGHYTTENMETER100BLXLC-100/FXDX60	Lianyungang Hytten Meter	Liangyungang Hytten Meter Co.,Ltd (Trung Quốc)	100	B	LXLC-100/FXD		60			Công ty Cổ phần Đầu tư và Phát triển MKC Việt Nam	Lô G5 cụm Công nghiệp Hà Bình Phương, xã Văn Bình, huyện Thường Tín, thành phố Hà Nội	PDM 3282-2024	2024-12-19 17:00:00	2034-12-29 17:00:00	\N
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, "default", permissions) FROM stdin;
2	Manager	f	2
3	Director	f	3
4	Administrator	f	4
5	SuperAdministrator	f	5
6	Viewer	t	1
\.


--
-- Data for Name: token_blacklist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist (id, jti, created_at, expires_at) FROM stdin;
30	e1d67120-5e03-4980-8638-6af08736338c	2025-02-13 09:41:37.147198	2025-02-13 09:44:49
31	89f02dfa-0450-424e-a368-a72d3b7c5e07	2025-02-13 09:44:29.916717	2025-02-13 09:49:18
32	40e2c85c-07cd-411d-96ba-1fb6f00ce94e	2025-02-13 14:08:16.76599	2025-02-13 14:13:01
33	5a7fde31-4342-4770-973e-c05f07fef935	2025-02-13 14:20:54.153477	2025-02-13 14:25:40
34	c348ad4c-92dd-417f-a5ce-04273876909d	2025-02-14 14:32:49.435026	2025-02-14 14:37:39
40	a4b986a5-85d1-466b-84eb-8a1f20a1cbbe	2025-02-14 15:08:24.362122	2025-02-14 15:11:53
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, username, fullname, email, password_hash, role_id, confirmed) FROM stdin;
4	user	User Nguyễn	user@gmail.com	scrypt:32768:8:1$AZUU0ewbjKBLLMEz$2affc41df7878cc0a4902779fd165bc5a13e2c4d7d1549eaab4e920697cf9ba2611405ef405e47ffc31c4f8c9b631c4b31756fd743828d04bcf2179968bdbb49	6	t
6	vuvuvuvvv	Nguyễn Thế Vũ	nguyenvu260502@gmail.com	scrypt:32768:8:1$28dSNknOpmSWMhFR$ec98fb8e5503a426cf64e888e560c29a48d15eb73b5cf6194501b2dc896dfda7a6be231f57f863a459668e4981c4401d0de38f9c7fe153bec04eb177c89b05a7	6	t
8	hoangtrithao	Hoàng Trí Thảo	hoangtrithao@gmail.com	scrypt:32768:8:1$Ar7ILhzAghsuk7fv$06fe915dc714938bf06b16ff5125e52efa1f32f4bf3b0295f3771040dbbaf381afc79de298d011c624e96b818c889d6cbf82a9126d2bbc8c658c69a267ec3668	6	t
7	dht_superadmin	Super Administrator	dht_superadmin@gmail.com	scrypt:32768:8:1$xC1JzqMRE6rVN8Kq$1c46c36934b609ef4158debafd9e21bd292f4f2bcb2fd02ca3d6d36303818777670609f5b1e27d34c187d566120c0cb8cafa125ff70660642a41c25f52e20025	5	t
1	admin	Admin Nguyễn	dht_admin@gmail.com	scrypt:32768:8:1$4R12Q5AvDtwBlgo9$b7e36d45fc107c0d85d05879c1d3dbbb536c202beef674f314831368e165fd6deae40194ad3c88719604b3e168ab8bb1e7582a2f67e48aeae2b8d7a6a77eafb8	4	t
\.


--
-- Name: dongho_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dongho_id_seq', 48, true);


--
-- Name: dongho_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dongho_permissions_id_seq', 61, true);


--
-- Name: nhomdongho_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nhomdongho_payment_id_seq', 5, true);


--
-- Name: pdm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pdm_id_seq', 575, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 5, true);


--
-- Name: token_blacklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_id_seq', 40, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 8, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: dongho_permissions dongho_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho_permissions
    ADD CONSTRAINT dongho_permissions_pkey PRIMARY KEY (id);


--
-- Name: dongho dongho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho
    ADD CONSTRAINT dongho_pkey PRIMARY KEY (id);


--
-- Name: nhomdongho_payment nhomdongho_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nhomdongho_payment
    ADD CONSTRAINT nhomdongho_payment_pkey PRIMARY KEY (id);


--
-- Name: pdm pdm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pdm
    ADD CONSTRAINT pdm_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist token_blacklist_jti_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist
    ADD CONSTRAINT token_blacklist_jti_key UNIQUE (jti);


--
-- Name: token_blacklist token_blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist
    ADD CONSTRAINT token_blacklist_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: ix_dongho_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_group_id ON public.dongho USING btree (group_id);


--
-- Name: ix_dongho_kieu_chi_thi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_kieu_chi_thi ON public.dongho USING btree (kieu_chi_thi);


--
-- Name: ix_dongho_kieu_sensor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_kieu_sensor ON public.dongho USING btree (kieu_sensor);


--
-- Name: ix_dongho_ma_quan_ly; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_ma_quan_ly ON public.dongho USING btree (ma_quan_ly);


--
-- Name: ix_dongho_owner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_owner_id ON public.dongho USING btree (owner_id);


--
-- Name: ix_dongho_permissions_dongho_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_permissions_dongho_id ON public.dongho_permissions USING btree (dongho_id);


--
-- Name: ix_dongho_permissions_manager; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_permissions_manager ON public.dongho_permissions USING btree (manager);


--
-- Name: ix_dongho_permissions_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_permissions_username ON public.dongho_permissions USING btree (username);


--
-- Name: ix_dongho_seri_chi_thi; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_seri_chi_thi ON public.dongho USING btree (seri_chi_thi);


--
-- Name: ix_dongho_seri_sensor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_seri_sensor ON public.dongho USING btree (seri_sensor);


--
-- Name: ix_dongho_so_giay_chung_nhan; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_so_giay_chung_nhan ON public.dongho USING btree (so_giay_chung_nhan);


--
-- Name: ix_dongho_ten_dong_ho; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dongho_ten_dong_ho ON public.dongho USING btree (ten_dong_ho);


--
-- Name: ix_pdm_ma_tim_dong_ho_pdm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pdm_ma_tim_dong_ho_pdm ON public.pdm USING btree (ma_tim_dong_ho_pdm);


--
-- Name: ix_pdm_so_qd_pdm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pdm_so_qd_pdm ON public.pdm USING btree (so_qd_pdm);


--
-- Name: ix_pdm_ten_dong_ho; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_pdm_ten_dong_ho ON public.pdm USING btree (ten_dong_ho);


--
-- Name: ix_roles_default; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_roles_default ON public.roles USING btree ("default");


--
-- Name: ix_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_user_email ON public."user" USING btree (email);


--
-- Name: ix_user_fullname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_fullname ON public."user" USING btree (fullname);


--
-- Name: ix_user_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_user_username ON public."user" USING btree (username);


--
-- Name: dongho dongho_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho
    ADD CONSTRAINT dongho_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public."user"(id);


--
-- Name: dongho_permissions dongho_permissions_dongho_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho_permissions
    ADD CONSTRAINT dongho_permissions_dongho_id_fkey FOREIGN KEY (dongho_id) REFERENCES public.dongho(id);


--
-- Name: dongho_permissions dongho_permissions_manager_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho_permissions
    ADD CONSTRAINT dongho_permissions_manager_fkey FOREIGN KEY (manager) REFERENCES public."user"(username);


--
-- Name: dongho_permissions dongho_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho_permissions
    ADD CONSTRAINT dongho_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: dongho_permissions dongho_permissions_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dongho_permissions
    ADD CONSTRAINT dongho_permissions_username_fkey FOREIGN KEY (username) REFERENCES public."user"(username);


--
-- Name: user user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- PostgreSQL database dump complete
--

