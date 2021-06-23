--
-- PostgreSQL database dump
--

-- Started on 2010-05-06 00:47:16

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1206 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 1049 (class 1247 OID 16400)
-- Dependencies: 6 2754
-- Name: breakpoint; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE breakpoint AS (
	func oid,
	linenumber integer,
	targetname text
);


ALTER TYPE public.breakpoint OWNER TO postgres;

--
-- TOC entry 1055 (class 0 OID 0)
-- Name: chkpass; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chkpass;


--
-- TOC entry 8 (class 1255 OID 16408)
-- Dependencies: 6 1055
-- Name: chkpass_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chkpass_in(cstring) RETURNS chkpass
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_in';


ALTER FUNCTION public.chkpass_in(cstring) OWNER TO postgres;

--
-- TOC entry 20 (class 1255 OID 16409)
-- Dependencies: 6 1055
-- Name: chkpass_out(chkpass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION chkpass_out(chkpass) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_out';


ALTER FUNCTION public.chkpass_out(chkpass) OWNER TO postgres;

--
-- TOC entry 1054 (class 1247 OID 16407)
-- Dependencies: 6 8 20
-- Name: chkpass; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE chkpass (
    INTERNALLENGTH = 16,
    INPUT = chkpass_in,
    OUTPUT = chkpass_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.chkpass OWNER TO postgres;

--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 1054
-- Name: TYPE chkpass; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE chkpass IS 'password type with checks';


--
-- TOC entry 1061 (class 0 OID 0)
-- Name: cube; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE cube;


--
-- TOC entry 21 (class 1255 OID 16418)
-- Dependencies: 6 1061
-- Name: cube_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_in(cstring) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_in';


ALTER FUNCTION public.cube_in(cstring) OWNER TO postgres;

--
-- TOC entry 22 (class 1255 OID 16419)
-- Dependencies: 6 1061
-- Name: cube_out(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_out(cube) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_out';


ALTER FUNCTION public.cube_out(cube) OWNER TO postgres;

--
-- TOC entry 1060 (class 1247 OID 16417)
-- Dependencies: 6 22 21
-- Name: cube; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE cube (
    INTERNALLENGTH = variable,
    INPUT = cube_in,
    OUTPUT = cube_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.cube OWNER TO postgres;

--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 1060
-- Name: TYPE cube; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE cube IS 'multi-dimensional cube ''(FLOAT-1, FLOAT-2, ..., FLOAT-N), (FLOAT-1, FLOAT-2, ..., FLOAT-N)''';


--
-- TOC entry 1063 (class 1247 OID 16423)
-- Dependencies: 6 2757
-- Name: dblink_pkey_results; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE dblink_pkey_results AS (
	"position" integer,
	colname text
);


ALTER TYPE public.dblink_pkey_results OWNER TO postgres;

--
-- TOC entry 1066 (class 0 OID 0)
-- Name: ean13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ean13;


--
-- TOC entry 23 (class 1255 OID 16425)
-- Dependencies: 6 1066
-- Name: ean13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_in(cstring) RETURNS ean13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_in';


ALTER FUNCTION public.ean13_in(cstring) OWNER TO postgres;

--
-- TOC entry 24 (class 1255 OID 16426)
-- Dependencies: 6 1066
-- Name: ean13_out(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(ean13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(ean13) OWNER TO postgres;

--
-- TOC entry 1065 (class 1247 OID 16424)
-- Dependencies: 24 23 6
-- Name: ean13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ean13 (
    INTERNALLENGTH = 8,
    INPUT = ean13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ean13 OWNER TO postgres;

--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 1065
-- Name: TYPE ean13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE ean13 IS 'International European Article Number (EAN13)';


--
-- TOC entry 69 (class 1255 OID 16616)
-- Dependencies: 6 1060
-- Name: cube_dim(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_dim(cube) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_dim';


ALTER FUNCTION public.cube_dim(cube) OWNER TO postgres;

--
-- TOC entry 70 (class 1255 OID 16617)
-- Dependencies: 1060 6 1060
-- Name: cube_distance(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_distance(cube, cube) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_distance';


ALTER FUNCTION public.cube_distance(cube, cube) OWNER TO postgres;

--
-- TOC entry 71 (class 1255 OID 16618)
-- Dependencies: 6 1060
-- Name: cube_is_point(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_is_point(cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_is_point';


ALTER FUNCTION public.cube_is_point(cube) OWNER TO postgres;

--
-- TOC entry 72 (class 1255 OID 16619)
-- Dependencies: 6
-- Name: earth(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION earth() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT '6378168'::float8$$;


ALTER FUNCTION public.earth() OWNER TO postgres;

--
-- TOC entry 1187 (class 1247 OID 16620)
-- Dependencies: 1188 1189 1190 1060 6 22
-- Name: earth; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN earth AS cube
	CONSTRAINT not_3d CHECK ((cube_dim(VALUE) <= 3))
	CONSTRAINT not_point CHECK (cube_is_point(VALUE))
	CONSTRAINT on_surface CHECK ((abs(((cube_distance(VALUE, '(0)'::cube) / earth()) - (1)::double precision)) < (0.00000099999999999999995)::double precision));


ALTER DOMAIN public.earth OWNER TO postgres;

--
-- TOC entry 1068 (class 1247 OID 16430)
-- Dependencies: 6 2758
-- Name: frame; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE frame AS (
	level integer,
	targetname text,
	func oid,
	linenumber integer,
	args text
);


ALTER TYPE public.frame OWNER TO postgres;

--
-- TOC entry 1074 (class 0 OID 0)
-- Name: gbtreekey16; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey16;


--
-- TOC entry 25 (class 1255 OID 16438)
-- Dependencies: 6 1074
-- Name: gbtreekey16_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey16_in(cstring) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey16_in(cstring) OWNER TO postgres;

--
-- TOC entry 26 (class 1255 OID 16439)
-- Dependencies: 6 1074
-- Name: gbtreekey16_out(gbtreekey16); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey16_out(gbtreekey16) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey16_out(gbtreekey16) OWNER TO postgres;

--
-- TOC entry 1073 (class 1247 OID 16437)
-- Dependencies: 25 6 26
-- Name: gbtreekey16; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey16 (
    INTERNALLENGTH = 16,
    INPUT = gbtreekey16_in,
    OUTPUT = gbtreekey16_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey16 OWNER TO postgres;

--
-- TOC entry 1077 (class 0 OID 0)
-- Name: gbtreekey32; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey32;


--
-- TOC entry 27 (class 1255 OID 16442)
-- Dependencies: 6 1077
-- Name: gbtreekey32_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey32_in(cstring) RETURNS gbtreekey32
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey32_in(cstring) OWNER TO postgres;

--
-- TOC entry 28 (class 1255 OID 16443)
-- Dependencies: 6 1077
-- Name: gbtreekey32_out(gbtreekey32); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey32_out(gbtreekey32) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey32_out(gbtreekey32) OWNER TO postgres;

--
-- TOC entry 1076 (class 1247 OID 16441)
-- Dependencies: 6 28 27
-- Name: gbtreekey32; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey32 (
    INTERNALLENGTH = 32,
    INPUT = gbtreekey32_in,
    OUTPUT = gbtreekey32_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey32 OWNER TO postgres;

--
-- TOC entry 1080 (class 0 OID 0)
-- Name: gbtreekey4; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey4;


--
-- TOC entry 29 (class 1255 OID 16446)
-- Dependencies: 6 1080
-- Name: gbtreekey4_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey4_in(cstring) RETURNS gbtreekey4
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey4_in(cstring) OWNER TO postgres;

--
-- TOC entry 30 (class 1255 OID 16447)
-- Dependencies: 6 1080
-- Name: gbtreekey4_out(gbtreekey4); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey4_out(gbtreekey4) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey4_out(gbtreekey4) OWNER TO postgres;

--
-- TOC entry 1079 (class 1247 OID 16445)
-- Dependencies: 30 29 6
-- Name: gbtreekey4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey4 (
    INTERNALLENGTH = 4,
    INPUT = gbtreekey4_in,
    OUTPUT = gbtreekey4_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey4 OWNER TO postgres;

--
-- TOC entry 1083 (class 0 OID 0)
-- Name: gbtreekey8; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey8;


--
-- TOC entry 31 (class 1255 OID 16450)
-- Dependencies: 6 1083
-- Name: gbtreekey8_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey8_in(cstring) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey8_in(cstring) OWNER TO postgres;

--
-- TOC entry 32 (class 1255 OID 16451)
-- Dependencies: 6 1083
-- Name: gbtreekey8_out(gbtreekey8); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey8_out(gbtreekey8) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey8_out(gbtreekey8) OWNER TO postgres;

--
-- TOC entry 1082 (class 1247 OID 16449)
-- Dependencies: 6 31 32
-- Name: gbtreekey8; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey8 (
    INTERNALLENGTH = 8,
    INPUT = gbtreekey8_in,
    OUTPUT = gbtreekey8_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gbtreekey8 OWNER TO postgres;

--
-- TOC entry 1086 (class 0 OID 0)
-- Name: gbtreekey_var; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey_var;


--
-- TOC entry 33 (class 1255 OID 16454)
-- Dependencies: 6 1086
-- Name: gbtreekey_var_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey_var_in(cstring) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_in';


ALTER FUNCTION public.gbtreekey_var_in(cstring) OWNER TO postgres;

--
-- TOC entry 34 (class 1255 OID 16455)
-- Dependencies: 6 1086
-- Name: gbtreekey_var_out(gbtreekey_var); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbtreekey_var_out(gbtreekey_var) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbtreekey_out';


ALTER FUNCTION public.gbtreekey_var_out(gbtreekey_var) OWNER TO postgres;

--
-- TOC entry 1085 (class 1247 OID 16453)
-- Dependencies: 33 34 6
-- Name: gbtreekey_var; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gbtreekey_var (
    INTERNALLENGTH = variable,
    INPUT = gbtreekey_var_in,
    OUTPUT = gbtreekey_var_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.gbtreekey_var OWNER TO postgres;

--
-- TOC entry 1089 (class 0 OID 0)
-- Name: ghstore; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ghstore;


--
-- TOC entry 35 (class 1255 OID 16458)
-- Dependencies: 6 1089
-- Name: ghstore_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_in(cstring) RETURNS ghstore
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'ghstore_in';


ALTER FUNCTION public.ghstore_in(cstring) OWNER TO postgres;

--
-- TOC entry 36 (class 1255 OID 16459)
-- Dependencies: 6 1089
-- Name: ghstore_out(ghstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_out(ghstore) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'ghstore_out';


ALTER FUNCTION public.ghstore_out(ghstore) OWNER TO postgres;

--
-- TOC entry 1088 (class 1247 OID 16457)
-- Dependencies: 6 35 36
-- Name: ghstore; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ghstore (
    INTERNALLENGTH = variable,
    INPUT = ghstore_in,
    OUTPUT = ghstore_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ghstore OWNER TO postgres;

--
-- TOC entry 1092 (class 0 OID 0)
-- Name: gtrgm; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gtrgm;


--
-- TOC entry 37 (class 1255 OID 16462)
-- Dependencies: 6 1092
-- Name: gtrgm_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_in(cstring) RETURNS gtrgm
    LANGUAGE c STRICT
    AS '$libdir/pg_trgm', 'gtrgm_in';


ALTER FUNCTION public.gtrgm_in(cstring) OWNER TO postgres;

--
-- TOC entry 38 (class 1255 OID 16463)
-- Dependencies: 6 1092
-- Name: gtrgm_out(gtrgm); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_out(gtrgm) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/pg_trgm', 'gtrgm_out';


ALTER FUNCTION public.gtrgm_out(gtrgm) OWNER TO postgres;

--
-- TOC entry 1091 (class 1247 OID 16461)
-- Dependencies: 6 37 38
-- Name: gtrgm; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE gtrgm (
    INTERNALLENGTH = variable,
    INPUT = gtrgm_in,
    OUTPUT = gtrgm_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.gtrgm OWNER TO postgres;

--
-- TOC entry 1098 (class 0 OID 0)
-- Name: hstore; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE hstore;


--
-- TOC entry 39 (class 1255 OID 16472)
-- Dependencies: 6 1098
-- Name: hstore_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore_in(cstring) RETURNS hstore
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'hstore_in';


ALTER FUNCTION public.hstore_in(cstring) OWNER TO postgres;

--
-- TOC entry 40 (class 1255 OID 16473)
-- Dependencies: 6 1098
-- Name: hstore_out(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hstore_out(hstore) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/hstore', 'hstore_out';


ALTER FUNCTION public.hstore_out(hstore) OWNER TO postgres;

--
-- TOC entry 1097 (class 1247 OID 16471)
-- Dependencies: 6 39 40
-- Name: hstore; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE hstore (
    INTERNALLENGTH = variable,
    INPUT = hstore_in,
    OUTPUT = hstore_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.hstore OWNER TO postgres;

--
-- TOC entry 1101 (class 0 OID 0)
-- Name: intbig_gkey; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE intbig_gkey;


--
-- TOC entry 41 (class 1255 OID 16476)
-- Dependencies: 6 1101
-- Name: _intbig_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _intbig_in(cstring) RETURNS intbig_gkey
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_intbig_in';


ALTER FUNCTION public._intbig_in(cstring) OWNER TO postgres;

--
-- TOC entry 42 (class 1255 OID 16477)
-- Dependencies: 6 1101
-- Name: _intbig_out(intbig_gkey); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _intbig_out(intbig_gkey) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_intbig_out';


ALTER FUNCTION public._intbig_out(intbig_gkey) OWNER TO postgres;

--
-- TOC entry 1100 (class 1247 OID 16475)
-- Dependencies: 41 42 6
-- Name: intbig_gkey; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE intbig_gkey (
    INTERNALLENGTH = variable,
    INPUT = _intbig_in,
    OUTPUT = _intbig_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.intbig_gkey OWNER TO postgres;

--
-- TOC entry 1104 (class 0 OID 0)
-- Name: isbn; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn;


--
-- TOC entry 43 (class 1255 OID 16480)
-- Dependencies: 6 1104
-- Name: isbn_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn_in(cstring) RETURNS isbn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_in';


ALTER FUNCTION public.isbn_in(cstring) OWNER TO postgres;

--
-- TOC entry 44 (class 1255 OID 16481)
-- Dependencies: 6 1104
-- Name: isn_out(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(isbn) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(isbn) OWNER TO postgres;

--
-- TOC entry 1103 (class 1247 OID 16479)
-- Dependencies: 44 6 43
-- Name: isbn; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn (
    INTERNALLENGTH = 8,
    INPUT = isbn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.isbn OWNER TO postgres;

--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 1103
-- Name: TYPE isbn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE isbn IS 'International Standard Book Number (ISBN)';


--
-- TOC entry 1107 (class 0 OID 0)
-- Name: isbn13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn13;


--
-- TOC entry 45 (class 1255 OID 16484)
-- Dependencies: 6 1107
-- Name: ean13_out(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(isbn13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(isbn13) OWNER TO postgres;

--
-- TOC entry 46 (class 1255 OID 16485)
-- Dependencies: 6 1107
-- Name: isbn13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn13_in(cstring) RETURNS isbn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_in';


ALTER FUNCTION public.isbn13_in(cstring) OWNER TO postgres;

--
-- TOC entry 1106 (class 1247 OID 16483)
-- Dependencies: 45 6 46
-- Name: isbn13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE isbn13 (
    INTERNALLENGTH = 8,
    INPUT = isbn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.isbn13 OWNER TO postgres;

--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 1106
-- Name: TYPE isbn13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE isbn13 IS 'International Standard Book Number 13 (ISBN13)';


--
-- TOC entry 1110 (class 0 OID 0)
-- Name: ismn; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn;


--
-- TOC entry 47 (class 1255 OID 16488)
-- Dependencies: 6 1110
-- Name: ismn_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn_in(cstring) RETURNS ismn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_in';


ALTER FUNCTION public.ismn_in(cstring) OWNER TO postgres;

--
-- TOC entry 48 (class 1255 OID 16489)
-- Dependencies: 6 1110
-- Name: isn_out(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(ismn) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(ismn) OWNER TO postgres;

--
-- TOC entry 1109 (class 1247 OID 16487)
-- Dependencies: 6 48 47
-- Name: ismn; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn (
    INTERNALLENGTH = 8,
    INPUT = ismn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ismn OWNER TO postgres;

--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 1109
-- Name: TYPE ismn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE ismn IS 'International Standard Music Number (ISMN)';


--
-- TOC entry 1113 (class 0 OID 0)
-- Name: ismn13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn13;


--
-- TOC entry 49 (class 1255 OID 16492)
-- Dependencies: 6 1113
-- Name: ean13_out(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(ismn13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(ismn13) OWNER TO postgres;

--
-- TOC entry 50 (class 1255 OID 16493)
-- Dependencies: 6 1113
-- Name: ismn13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn13_in(cstring) RETURNS ismn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_in';


ALTER FUNCTION public.ismn13_in(cstring) OWNER TO postgres;

--
-- TOC entry 1112 (class 1247 OID 16491)
-- Dependencies: 49 50 6
-- Name: ismn13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ismn13 (
    INTERNALLENGTH = 8,
    INPUT = ismn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.ismn13 OWNER TO postgres;

--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 1112
-- Name: TYPE ismn13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE ismn13 IS 'International Standard Music Number 13 (ISMN13)';


--
-- TOC entry 1116 (class 0 OID 0)
-- Name: issn; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn;


--
-- TOC entry 51 (class 1255 OID 16496)
-- Dependencies: 6 1116
-- Name: isn_out(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(issn) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(issn) OWNER TO postgres;

--
-- TOC entry 52 (class 1255 OID 16497)
-- Dependencies: 6 1116
-- Name: issn_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn_in(cstring) RETURNS issn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_in';


ALTER FUNCTION public.issn_in(cstring) OWNER TO postgres;

--
-- TOC entry 1115 (class 1247 OID 16495)
-- Dependencies: 6 51 52
-- Name: issn; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn (
    INTERNALLENGTH = 8,
    INPUT = issn_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.issn OWNER TO postgres;

--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 1115
-- Name: TYPE issn; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE issn IS 'International Standard Serial Number (ISSN)';


--
-- TOC entry 1119 (class 0 OID 0)
-- Name: issn13; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn13;


--
-- TOC entry 53 (class 1255 OID 16500)
-- Dependencies: 6 1119
-- Name: ean13_out(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ean13_out(issn13) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ean13_out';


ALTER FUNCTION public.ean13_out(issn13) OWNER TO postgres;

--
-- TOC entry 54 (class 1255 OID 16501)
-- Dependencies: 6 1119
-- Name: issn13_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn13_in(cstring) RETURNS issn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_in';


ALTER FUNCTION public.issn13_in(cstring) OWNER TO postgres;

--
-- TOC entry 1118 (class 1247 OID 16499)
-- Dependencies: 53 54 6
-- Name: issn13; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE issn13 (
    INTERNALLENGTH = 8,
    INPUT = issn13_in,
    OUTPUT = public.ean13_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.issn13 OWNER TO postgres;

--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 1118
-- Name: TYPE issn13; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE issn13 IS 'International Standard Serial Number 13 (ISSN13)';


--
-- TOC entry 1191 (class 1247 OID 16624)
-- Dependencies: 6
-- Name: lo; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN lo AS oid;


ALTER DOMAIN public.lo OWNER TO postgres;

--
-- TOC entry 1125 (class 0 OID 0)
-- Name: lquery; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE lquery;


--
-- TOC entry 55 (class 1255 OID 16510)
-- Dependencies: 6 1125
-- Name: lquery_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lquery_in(cstring) RETURNS lquery
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'lquery_in';


ALTER FUNCTION public.lquery_in(cstring) OWNER TO postgres;

--
-- TOC entry 56 (class 1255 OID 16511)
-- Dependencies: 6 1125
-- Name: lquery_out(lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lquery_out(lquery) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'lquery_out';


ALTER FUNCTION public.lquery_out(lquery) OWNER TO postgres;

--
-- TOC entry 1124 (class 1247 OID 16509)
-- Dependencies: 55 6 56
-- Name: lquery; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE lquery (
    INTERNALLENGTH = variable,
    INPUT = lquery_in,
    OUTPUT = lquery_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.lquery OWNER TO postgres;

--
-- TOC entry 1128 (class 0 OID 0)
-- Name: ltree; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree;


--
-- TOC entry 57 (class 1255 OID 16514)
-- Dependencies: 6 1128
-- Name: ltree_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_in(cstring) RETURNS ltree
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_in';


ALTER FUNCTION public.ltree_in(cstring) OWNER TO postgres;

--
-- TOC entry 58 (class 1255 OID 16515)
-- Dependencies: 6 1128
-- Name: ltree_out(ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_out(ltree) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_out';


ALTER FUNCTION public.ltree_out(ltree) OWNER TO postgres;

--
-- TOC entry 1127 (class 1247 OID 16513)
-- Dependencies: 6 58 57
-- Name: ltree; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree (
    INTERNALLENGTH = variable,
    INPUT = ltree_in,
    OUTPUT = ltree_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.ltree OWNER TO postgres;

--
-- TOC entry 1131 (class 0 OID 0)
-- Name: ltree_gist; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree_gist;


--
-- TOC entry 59 (class 1255 OID 16518)
-- Dependencies: 6 1131
-- Name: ltree_gist_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_gist_in(cstring) RETURNS ltree_gist
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_gist_in';


ALTER FUNCTION public.ltree_gist_in(cstring) OWNER TO postgres;

--
-- TOC entry 60 (class 1255 OID 16519)
-- Dependencies: 6 1131
-- Name: ltree_gist_out(ltree_gist); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_gist_out(ltree_gist) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltree_gist_out';


ALTER FUNCTION public.ltree_gist_out(ltree_gist) OWNER TO postgres;

--
-- TOC entry 1130 (class 1247 OID 16517)
-- Dependencies: 6 60 59
-- Name: ltree_gist; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltree_gist (
    INTERNALLENGTH = variable,
    INPUT = ltree_gist_in,
    OUTPUT = ltree_gist_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.ltree_gist OWNER TO postgres;

--
-- TOC entry 1134 (class 0 OID 0)
-- Name: ltxtquery; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltxtquery;


--
-- TOC entry 61 (class 1255 OID 16522)
-- Dependencies: 6 1134
-- Name: ltxtq_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_in(cstring) RETURNS ltxtquery
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltxtq_in';


ALTER FUNCTION public.ltxtq_in(cstring) OWNER TO postgres;

--
-- TOC entry 62 (class 1255 OID 16523)
-- Dependencies: 6 1134
-- Name: ltxtq_out(ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_out(ltxtquery) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/ltree', 'ltxtq_out';


ALTER FUNCTION public.ltxtq_out(ltxtquery) OWNER TO postgres;

--
-- TOC entry 1133 (class 1247 OID 16521)
-- Dependencies: 62 61 6
-- Name: ltxtquery; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ltxtquery (
    INTERNALLENGTH = variable,
    INPUT = ltxtq_in,
    OUTPUT = ltxtq_out,
    ALIGNMENT = int4,
    STORAGE = extended
);


ALTER TYPE public.ltxtquery OWNER TO postgres;

--
-- TOC entry 1138 (class 1247 OID 16534)
-- Dependencies: 6 2763
-- Name: proxyinfo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE proxyinfo AS (
	serverversionstr text,
	serverversionnum integer,
	proxyapiver integer,
	serverprocessid integer
);


ALTER TYPE public.proxyinfo OWNER TO postgres;

--
-- TOC entry 1141 (class 0 OID 0)
-- Name: query_int; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE query_int;


--
-- TOC entry 63 (class 1255 OID 16536)
-- Dependencies: 6 1141
-- Name: bqarr_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bqarr_in(cstring) RETURNS query_int
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'bqarr_in';


ALTER FUNCTION public.bqarr_in(cstring) OWNER TO postgres;

--
-- TOC entry 64 (class 1255 OID 16537)
-- Dependencies: 6 1141
-- Name: bqarr_out(query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bqarr_out(query_int) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'bqarr_out';


ALTER FUNCTION public.bqarr_out(query_int) OWNER TO postgres;

--
-- TOC entry 1140 (class 1247 OID 16535)
-- Dependencies: 64 6 63
-- Name: query_int; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE query_int (
    INTERNALLENGTH = variable,
    INPUT = bqarr_in,
    OUTPUT = bqarr_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.query_int OWNER TO postgres;

--
-- TOC entry 1144 (class 0 OID 0)
-- Name: seg; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE seg;


--
-- TOC entry 65 (class 1255 OID 16540)
-- Dependencies: 6 1144
-- Name: seg_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_in(cstring) RETURNS seg
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_in';


ALTER FUNCTION public.seg_in(cstring) OWNER TO postgres;

--
-- TOC entry 66 (class 1255 OID 16541)
-- Dependencies: 6 1144
-- Name: seg_out(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_out(seg) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_out';


ALTER FUNCTION public.seg_out(seg) OWNER TO postgres;

--
-- TOC entry 1143 (class 1247 OID 16539)
-- Dependencies: 6 66 65
-- Name: seg; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE seg (
    INTERNALLENGTH = 12,
    INPUT = seg_in,
    OUTPUT = seg_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.seg OWNER TO postgres;

--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 1143
-- Name: TYPE seg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE seg IS 'floating point interval ''FLOAT .. FLOAT'', ''.. FLOAT'', ''FLOAT ..'' or ''FLOAT''';


--
-- TOC entry 1149 (class 1247 OID 16551)
-- Dependencies: 6 2765
-- Name: tablefunc_crosstab_2; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_2 AS (
	row_name text,
	category_1 text,
	category_2 text
);


ALTER TYPE public.tablefunc_crosstab_2 OWNER TO postgres;

--
-- TOC entry 1151 (class 1247 OID 16554)
-- Dependencies: 6 2766
-- Name: tablefunc_crosstab_3; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_3 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text
);


ALTER TYPE public.tablefunc_crosstab_3 OWNER TO postgres;

--
-- TOC entry 1153 (class 1247 OID 16557)
-- Dependencies: 6 2767
-- Name: tablefunc_crosstab_4; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tablefunc_crosstab_4 AS (
	row_name text,
	category_1 text,
	category_2 text,
	category_3 text,
	category_4 text
);


ALTER TYPE public.tablefunc_crosstab_4 OWNER TO postgres;

--
-- TOC entry 1155 (class 1247 OID 16560)
-- Dependencies: 6 2768
-- Name: targetinfo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE targetinfo AS (
	target oid,
	schema oid,
	nargs integer,
	argtypes oidvector,
	targetname name,
	argmodes "char"[],
	argnames text[],
	targetlang oid,
	fqname text,
	returnsset boolean,
	returntype oid
);


ALTER TYPE public.targetinfo OWNER TO postgres;

--
-- TOC entry 1183 (class 0 OID 0)
-- Name: upc; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE upc;


--
-- TOC entry 67 (class 1255 OID 16610)
-- Dependencies: 6 1183
-- Name: isn_out(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_out(upc) RETURNS cstring
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isn_out';


ALTER FUNCTION public.isn_out(upc) OWNER TO postgres;

--
-- TOC entry 68 (class 1255 OID 16611)
-- Dependencies: 6 1183
-- Name: upc_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION upc_in(cstring) RETURNS upc
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'upc_in';


ALTER FUNCTION public.upc_in(cstring) OWNER TO postgres;

--
-- TOC entry 1182 (class 1247 OID 16609)
-- Dependencies: 67 6 68
-- Name: upc; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE upc (
    INTERNALLENGTH = 8,
    INPUT = upc_in,
    OUTPUT = public.isn_out,
    ALIGNMENT = double,
    STORAGE = plain
);


ALTER TYPE public.upc OWNER TO postgres;

--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 1182
-- Name: TYPE upc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE upc IS 'Universal Product Code (UPC)';


--
-- TOC entry 1185 (class 1247 OID 16615)
-- Dependencies: 6 2778
-- Name: var; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE var AS (
	name text,
	varclass character(1),
	linenumber integer,
	isunique boolean,
	isconst boolean,
	isnotnull boolean,
	dtype oid,
	value text
);


ALTER TYPE public.var OWNER TO postgres;

--
-- TOC entry 73 (class 1255 OID 16625)
-- Dependencies: 6
-- Name: _int_contained(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_contained(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_contained';


ALTER FUNCTION public._int_contained(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 73
-- Name: FUNCTION _int_contained(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_contained(integer[], integer[]) IS 'contained in';


--
-- TOC entry 74 (class 1255 OID 16626)
-- Dependencies: 6
-- Name: _int_contains(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_contains(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_contains';


ALTER FUNCTION public._int_contains(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 74
-- Name: FUNCTION _int_contains(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_contains(integer[], integer[]) IS 'contains';


--
-- TOC entry 75 (class 1255 OID 16627)
-- Dependencies: 6
-- Name: _int_different(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_different(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_different';


ALTER FUNCTION public._int_different(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 75
-- Name: FUNCTION _int_different(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_different(integer[], integer[]) IS 'different';


--
-- TOC entry 76 (class 1255 OID 16628)
-- Dependencies: 6
-- Name: _int_inter(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_inter(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_inter';


ALTER FUNCTION public._int_inter(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 77 (class 1255 OID 16629)
-- Dependencies: 6
-- Name: _int_overlap(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_overlap(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_overlap';


ALTER FUNCTION public._int_overlap(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 77
-- Name: FUNCTION _int_overlap(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_overlap(integer[], integer[]) IS 'overlaps';


--
-- TOC entry 78 (class 1255 OID 16630)
-- Dependencies: 6
-- Name: _int_same(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_same(integer[], integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_same';


ALTER FUNCTION public._int_same(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 78
-- Name: FUNCTION _int_same(integer[], integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION _int_same(integer[], integer[]) IS 'same as';


--
-- TOC entry 79 (class 1255 OID 16631)
-- Dependencies: 6
-- Name: _int_union(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _int_union(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', '_int_union';


ALTER FUNCTION public._int_union(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 80 (class 1255 OID 16632)
-- Dependencies: 1129 6 1126
-- Name: _lt_q_regex(ltree[], lquery[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _lt_q_regex(ltree[], lquery[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_lt_q_regex';


ALTER FUNCTION public._lt_q_regex(ltree[], lquery[]) OWNER TO postgres;

--
-- TOC entry 81 (class 1255 OID 16633)
-- Dependencies: 1126 6 1129
-- Name: _lt_q_rregex(lquery[], ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _lt_q_rregex(lquery[], ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_lt_q_rregex';


ALTER FUNCTION public._lt_q_rregex(lquery[], ltree[]) OWNER TO postgres;

--
-- TOC entry 82 (class 1255 OID 16634)
-- Dependencies: 1124 6 1127 1129
-- Name: _ltq_extract_regex(ltree[], lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltq_extract_regex(ltree[], lquery) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltq_extract_regex';


ALTER FUNCTION public._ltq_extract_regex(ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 83 (class 1255 OID 16635)
-- Dependencies: 1129 1124 6
-- Name: _ltq_regex(ltree[], lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltq_regex(ltree[], lquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltq_regex';


ALTER FUNCTION public._ltq_regex(ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 84 (class 1255 OID 16636)
-- Dependencies: 1129 6 1124
-- Name: _ltq_rregex(lquery, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltq_rregex(lquery, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltq_rregex';


ALTER FUNCTION public._ltq_rregex(lquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 85 (class 1255 OID 16637)
-- Dependencies: 6
-- Name: _ltree_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_compress';


ALTER FUNCTION public._ltree_compress(internal) OWNER TO postgres;

--
-- TOC entry 86 (class 1255 OID 16638)
-- Dependencies: 6
-- Name: _ltree_consistent(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_consistent(internal, internal, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_consistent';


ALTER FUNCTION public._ltree_consistent(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 87 (class 1255 OID 16639)
-- Dependencies: 1129 1127 6 1127
-- Name: _ltree_extract_isparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_extract_isparent(ltree[], ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_extract_isparent';


ALTER FUNCTION public._ltree_extract_isparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 88 (class 1255 OID 16640)
-- Dependencies: 1127 6 1127 1129
-- Name: _ltree_extract_risparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_extract_risparent(ltree[], ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_extract_risparent';


ALTER FUNCTION public._ltree_extract_risparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 89 (class 1255 OID 16641)
-- Dependencies: 1129 6 1127
-- Name: _ltree_isparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_isparent(ltree[], ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_isparent';


ALTER FUNCTION public._ltree_isparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 90 (class 1255 OID 16642)
-- Dependencies: 6
-- Name: _ltree_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_penalty';


ALTER FUNCTION public._ltree_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 91 (class 1255 OID 16643)
-- Dependencies: 6
-- Name: _ltree_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_picksplit';


ALTER FUNCTION public._ltree_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 92 (class 1255 OID 16644)
-- Dependencies: 6 1129 1127
-- Name: _ltree_r_isparent(ltree, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_r_isparent(ltree, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_r_isparent';


ALTER FUNCTION public._ltree_r_isparent(ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 93 (class 1255 OID 16645)
-- Dependencies: 1129 1127 6
-- Name: _ltree_r_risparent(ltree, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_r_risparent(ltree, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_r_risparent';


ALTER FUNCTION public._ltree_r_risparent(ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 94 (class 1255 OID 16646)
-- Dependencies: 1127 1129 6
-- Name: _ltree_risparent(ltree[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_risparent(ltree[], ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltree_risparent';


ALTER FUNCTION public._ltree_risparent(ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 95 (class 1255 OID 16647)
-- Dependencies: 6
-- Name: _ltree_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_same';


ALTER FUNCTION public._ltree_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 96 (class 1255 OID 16648)
-- Dependencies: 6
-- Name: _ltree_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltree_union(internal, internal) RETURNS integer
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', '_ltree_union';


ALTER FUNCTION public._ltree_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 97 (class 1255 OID 16649)
-- Dependencies: 1129 6 1133
-- Name: _ltxtq_exec(ltree[], ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltxtq_exec(ltree[], ltxtquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltxtq_exec';


ALTER FUNCTION public._ltxtq_exec(ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 98 (class 1255 OID 16650)
-- Dependencies: 1133 1129 1127 6
-- Name: _ltxtq_extract_exec(ltree[], ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltxtq_extract_exec(ltree[], ltxtquery) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltxtq_extract_exec';


ALTER FUNCTION public._ltxtq_extract_exec(ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 99 (class 1255 OID 16651)
-- Dependencies: 1129 6 1133
-- Name: _ltxtq_rexec(ltxtquery, ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION _ltxtq_rexec(ltxtquery, ltree[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_ltxtq_rexec';


ALTER FUNCTION public._ltxtq_rexec(ltxtquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 100 (class 1255 OID 16652)
-- Dependencies: 6 1097
-- Name: akeys(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION akeys(hstore) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'akeys';


ALTER FUNCTION public.akeys(hstore) OWNER TO postgres;

--
-- TOC entry 101 (class 1255 OID 16653)
-- Dependencies: 6
-- Name: armor(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION armor(bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_armor';


ALTER FUNCTION public.armor(bytea) OWNER TO postgres;

--
-- TOC entry 102 (class 1255 OID 16654)
-- Dependencies: 6
-- Name: autoinc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION autoinc() RETURNS trigger
    LANGUAGE c
    AS '$libdir/autoinc', 'autoinc';


ALTER FUNCTION public.autoinc() OWNER TO postgres;

--
-- TOC entry 103 (class 1255 OID 16655)
-- Dependencies: 1097 6
-- Name: avals(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION avals(hstore) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'avals';


ALTER FUNCTION public.avals(hstore) OWNER TO postgres;

--
-- TOC entry 104 (class 1255 OID 16656)
-- Dependencies: 6 1140
-- Name: boolop(integer[], query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION boolop(integer[], query_int) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'boolop';


ALTER FUNCTION public.boolop(integer[], query_int) OWNER TO postgres;

--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 104
-- Name: FUNCTION boolop(integer[], query_int); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION boolop(integer[], query_int) IS 'boolean operation with array';


--
-- TOC entry 105 (class 1255 OID 16657)
-- Dependencies: 6
-- Name: bt_metap(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bt_metap(relname text, OUT magic integer, OUT version integer, OUT root integer, OUT level integer, OUT fastroot integer, OUT fastlevel integer) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'bt_metap';


ALTER FUNCTION public.bt_metap(relname text, OUT magic integer, OUT version integer, OUT root integer, OUT level integer, OUT fastroot integer, OUT fastlevel integer) OWNER TO postgres;

--
-- TOC entry 106 (class 1255 OID 16658)
-- Dependencies: 6
-- Name: bt_page_items(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bt_page_items(relname text, blkno integer, OUT itemoffset smallint, OUT ctid tid, OUT itemlen smallint, OUT nulls boolean, OUT vars boolean, OUT data text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'bt_page_items';


ALTER FUNCTION public.bt_page_items(relname text, blkno integer, OUT itemoffset smallint, OUT ctid tid, OUT itemlen smallint, OUT nulls boolean, OUT vars boolean, OUT data text) OWNER TO postgres;

--
-- TOC entry 107 (class 1255 OID 16659)
-- Dependencies: 6
-- Name: bt_page_stats(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bt_page_stats(relname text, blkno integer, OUT blkno integer, OUT type "char", OUT live_items integer, OUT dead_items integer, OUT avg_item_size integer, OUT page_size integer, OUT free_size integer, OUT btpo_prev integer, OUT btpo_next integer, OUT btpo integer, OUT btpo_flags integer) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'bt_page_stats';


ALTER FUNCTION public.bt_page_stats(relname text, blkno integer, OUT blkno integer, OUT type "char", OUT live_items integer, OUT dead_items integer, OUT avg_item_size integer, OUT page_size integer, OUT free_size integer, OUT btpo_prev integer, OUT btpo_next integer, OUT btpo integer, OUT btpo_flags integer) OWNER TO postgres;

--
-- TOC entry 108 (class 1255 OID 16660)
-- Dependencies: 1065 6 1065
-- Name: btean13cmp(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 109 (class 1255 OID 16661)
-- Dependencies: 6 1065 1106
-- Name: btean13cmp(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 110 (class 1255 OID 16662)
-- Dependencies: 1112 6 1065
-- Name: btean13cmp(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 111 (class 1255 OID 16663)
-- Dependencies: 6 1065 1118
-- Name: btean13cmp(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 112 (class 1255 OID 16664)
-- Dependencies: 1065 6 1103
-- Name: btean13cmp(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 113 (class 1255 OID 16665)
-- Dependencies: 1109 6 1065
-- Name: btean13cmp(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 114 (class 1255 OID 16666)
-- Dependencies: 1115 6 1065
-- Name: btean13cmp(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, issn) OWNER TO postgres;

--
-- TOC entry 115 (class 1255 OID 16667)
-- Dependencies: 1182 6 1065
-- Name: btean13cmp(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btean13cmp(ean13, upc) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btean13cmp(ean13, upc) OWNER TO postgres;

--
-- TOC entry 116 (class 1255 OID 16668)
-- Dependencies: 1106 6 1106
-- Name: btisbn13cmp(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbn13cmp(isbn13, isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbn13cmp(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 117 (class 1255 OID 16669)
-- Dependencies: 1106 6 1065
-- Name: btisbn13cmp(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbn13cmp(isbn13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbn13cmp(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 118 (class 1255 OID 16670)
-- Dependencies: 1103 6 1106
-- Name: btisbn13cmp(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbn13cmp(isbn13, isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbn13cmp(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 119 (class 1255 OID 16671)
-- Dependencies: 1103 1103 6
-- Name: btisbncmp(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbncmp(isbn, isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbncmp(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 120 (class 1255 OID 16672)
-- Dependencies: 6 1065 1103
-- Name: btisbncmp(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbncmp(isbn, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbncmp(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 121 (class 1255 OID 16673)
-- Dependencies: 1106 1103 6
-- Name: btisbncmp(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btisbncmp(isbn, isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btisbncmp(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 122 (class 1255 OID 16674)
-- Dependencies: 6 1112 1112
-- Name: btismn13cmp(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismn13cmp(ismn13, ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismn13cmp(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 123 (class 1255 OID 16675)
-- Dependencies: 1065 1112 6
-- Name: btismn13cmp(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismn13cmp(ismn13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismn13cmp(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 124 (class 1255 OID 16676)
-- Dependencies: 1112 1109 6
-- Name: btismn13cmp(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismn13cmp(ismn13, ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismn13cmp(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 125 (class 1255 OID 16677)
-- Dependencies: 1109 6 1109
-- Name: btismncmp(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismncmp(ismn, ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismncmp(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 126 (class 1255 OID 16678)
-- Dependencies: 6 1065 1109
-- Name: btismncmp(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismncmp(ismn, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismncmp(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 127 (class 1255 OID 16679)
-- Dependencies: 6 1109 1112
-- Name: btismncmp(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btismncmp(ismn, ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btismncmp(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 128 (class 1255 OID 16680)
-- Dependencies: 1118 6 1118
-- Name: btissn13cmp(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissn13cmp(issn13, issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissn13cmp(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 129 (class 1255 OID 16681)
-- Dependencies: 1065 1118 6
-- Name: btissn13cmp(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissn13cmp(issn13, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissn13cmp(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 130 (class 1255 OID 16682)
-- Dependencies: 6 1115 1118
-- Name: btissn13cmp(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissn13cmp(issn13, issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissn13cmp(issn13, issn) OWNER TO postgres;

--
-- TOC entry 131 (class 1255 OID 16683)
-- Dependencies: 1115 6 1115
-- Name: btissncmp(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissncmp(issn, issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissncmp(issn, issn) OWNER TO postgres;

--
-- TOC entry 132 (class 1255 OID 16684)
-- Dependencies: 6 1065 1115
-- Name: btissncmp(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissncmp(issn, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissncmp(issn, ean13) OWNER TO postgres;

--
-- TOC entry 133 (class 1255 OID 16685)
-- Dependencies: 6 1115 1118
-- Name: btissncmp(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btissncmp(issn, issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btissncmp(issn, issn13) OWNER TO postgres;

--
-- TOC entry 134 (class 1255 OID 16686)
-- Dependencies: 1182 6 1182
-- Name: btupccmp(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btupccmp(upc, upc) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btupccmp(upc, upc) OWNER TO postgres;

--
-- TOC entry 135 (class 1255 OID 16687)
-- Dependencies: 1065 6 1182
-- Name: btupccmp(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION btupccmp(upc, ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$btint8cmp$$;


ALTER FUNCTION public.btupccmp(upc, ean13) OWNER TO postgres;

--
-- TOC entry 136 (class 1255 OID 16688)
-- Dependencies: 6
-- Name: check_foreign_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION check_foreign_key() RETURNS trigger
    LANGUAGE c
    AS '$libdir/refint', 'check_foreign_key';


ALTER FUNCTION public.check_foreign_key() OWNER TO postgres;

--
-- TOC entry 137 (class 1255 OID 16689)
-- Dependencies: 6
-- Name: check_primary_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION check_primary_key() RETURNS trigger
    LANGUAGE c
    AS '$libdir/refint', 'check_primary_key';


ALTER FUNCTION public.check_primary_key() OWNER TO postgres;

--
-- TOC entry 138 (class 1255 OID 16690)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 139 (class 1255 OID 16691)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text';


ALTER FUNCTION public.connectby(text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 140 (class 1255 OID 16692)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, text, integer, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer, text) OWNER TO postgres;

--
-- TOC entry 141 (class 1255 OID 16693)
-- Dependencies: 6
-- Name: connectby(text, text, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION connectby(text, text, text, text, text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'connectby_text_serial';


ALTER FUNCTION public.connectby(text, text, text, text, text, integer) OWNER TO postgres;

--
-- TOC entry 142 (class 1255 OID 16694)
-- Dependencies: 6
-- Name: crosstab(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab(text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text) OWNER TO postgres;

--
-- TOC entry 143 (class 1255 OID 16695)
-- Dependencies: 6
-- Name: crosstab(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab(text, integer) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab(text, integer) OWNER TO postgres;

--
-- TOC entry 144 (class 1255 OID 16696)
-- Dependencies: 6
-- Name: crosstab(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab(text, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab_hash';


ALTER FUNCTION public.crosstab(text, text) OWNER TO postgres;

--
-- TOC entry 145 (class 1255 OID 16697)
-- Dependencies: 6 1149
-- Name: crosstab2(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab2(text) RETURNS SETOF tablefunc_crosstab_2
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab2(text) OWNER TO postgres;

--
-- TOC entry 146 (class 1255 OID 16698)
-- Dependencies: 6 1151
-- Name: crosstab3(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab3(text) RETURNS SETOF tablefunc_crosstab_3
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab3(text) OWNER TO postgres;

--
-- TOC entry 147 (class 1255 OID 16699)
-- Dependencies: 1153 6
-- Name: crosstab4(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crosstab4(text) RETURNS SETOF tablefunc_crosstab_4
    LANGUAGE c STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


ALTER FUNCTION public.crosstab4(text) OWNER TO postgres;

--
-- TOC entry 148 (class 1255 OID 16700)
-- Dependencies: 6
-- Name: crypt(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION crypt(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_crypt';


ALTER FUNCTION public.crypt(text, text) OWNER TO postgres;

--
-- TOC entry 149 (class 1255 OID 16701)
-- Dependencies: 6 1060
-- Name: cube(double precision[], double precision[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision[], double precision[]) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_a_f8_f8';


ALTER FUNCTION public.cube(double precision[], double precision[]) OWNER TO postgres;

--
-- TOC entry 150 (class 1255 OID 16702)
-- Dependencies: 6 1060
-- Name: cube(double precision[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision[]) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_a_f8';


ALTER FUNCTION public.cube(double precision[]) OWNER TO postgres;

--
-- TOC entry 151 (class 1255 OID 16703)
-- Dependencies: 1060 6
-- Name: cube(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_f8';


ALTER FUNCTION public.cube(double precision) OWNER TO postgres;

--
-- TOC entry 152 (class 1255 OID 16704)
-- Dependencies: 6 1060
-- Name: cube(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(double precision, double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_f8_f8';


ALTER FUNCTION public.cube(double precision, double precision) OWNER TO postgres;

--
-- TOC entry 153 (class 1255 OID 16705)
-- Dependencies: 1060 1060 6
-- Name: cube(cube, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(cube, double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_c_f8';


ALTER FUNCTION public.cube(cube, double precision) OWNER TO postgres;

--
-- TOC entry 154 (class 1255 OID 16706)
-- Dependencies: 1060 6 1060
-- Name: cube(cube, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube(cube, double precision, double precision) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_c_f8_f8';


ALTER FUNCTION public.cube(cube, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 155 (class 1255 OID 16707)
-- Dependencies: 1060 6 1060
-- Name: cube_cmp(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_cmp(cube, cube) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_cmp';


ALTER FUNCTION public.cube_cmp(cube, cube) OWNER TO postgres;

--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 155
-- Name: FUNCTION cube_cmp(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_cmp(cube, cube) IS 'btree comparison function';


--
-- TOC entry 156 (class 1255 OID 16708)
-- Dependencies: 1060 1060 6
-- Name: cube_contained(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_contained(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_contained';


ALTER FUNCTION public.cube_contained(cube, cube) OWNER TO postgres;

--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 156
-- Name: FUNCTION cube_contained(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_contained(cube, cube) IS 'contained in';


--
-- TOC entry 157 (class 1255 OID 16709)
-- Dependencies: 1060 6 1060
-- Name: cube_contains(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_contains(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_contains';


ALTER FUNCTION public.cube_contains(cube, cube) OWNER TO postgres;

--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 157
-- Name: FUNCTION cube_contains(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_contains(cube, cube) IS 'contains';


--
-- TOC entry 158 (class 1255 OID 16710)
-- Dependencies: 6 1060 1060
-- Name: cube_enlarge(cube, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_enlarge(cube, double precision, integer) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_enlarge';


ALTER FUNCTION public.cube_enlarge(cube, double precision, integer) OWNER TO postgres;

--
-- TOC entry 159 (class 1255 OID 16711)
-- Dependencies: 6 1060 1060
-- Name: cube_eq(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_eq(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_eq';


ALTER FUNCTION public.cube_eq(cube, cube) OWNER TO postgres;

--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 159
-- Name: FUNCTION cube_eq(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_eq(cube, cube) IS 'same as';


--
-- TOC entry 160 (class 1255 OID 16712)
-- Dependencies: 6 1060 1060
-- Name: cube_ge(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ge(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ge';


ALTER FUNCTION public.cube_ge(cube, cube) OWNER TO postgres;

--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 160
-- Name: FUNCTION cube_ge(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_ge(cube, cube) IS 'greater than or equal to';


--
-- TOC entry 161 (class 1255 OID 16713)
-- Dependencies: 1060 6 1060
-- Name: cube_gt(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_gt(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_gt';


ALTER FUNCTION public.cube_gt(cube, cube) OWNER TO postgres;

--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 161
-- Name: FUNCTION cube_gt(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_gt(cube, cube) IS 'greater than';


--
-- TOC entry 162 (class 1255 OID 16714)
-- Dependencies: 1060 6 1060 1060
-- Name: cube_inter(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_inter(cube, cube) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_inter';


ALTER FUNCTION public.cube_inter(cube, cube) OWNER TO postgres;

--
-- TOC entry 163 (class 1255 OID 16715)
-- Dependencies: 1060 6 1060
-- Name: cube_le(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_le(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_le';


ALTER FUNCTION public.cube_le(cube, cube) OWNER TO postgres;

--
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 163
-- Name: FUNCTION cube_le(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_le(cube, cube) IS 'lower than or equal to';


--
-- TOC entry 164 (class 1255 OID 16716)
-- Dependencies: 6 1060
-- Name: cube_ll_coord(cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ll_coord(cube, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ll_coord';


ALTER FUNCTION public.cube_ll_coord(cube, integer) OWNER TO postgres;

--
-- TOC entry 165 (class 1255 OID 16717)
-- Dependencies: 1060 1060 6
-- Name: cube_lt(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_lt(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_lt';


ALTER FUNCTION public.cube_lt(cube, cube) OWNER TO postgres;

--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 165
-- Name: FUNCTION cube_lt(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_lt(cube, cube) IS 'lower than';


--
-- TOC entry 166 (class 1255 OID 16718)
-- Dependencies: 1060 1060 6
-- Name: cube_ne(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ne(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ne';


ALTER FUNCTION public.cube_ne(cube, cube) OWNER TO postgres;

--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 166
-- Name: FUNCTION cube_ne(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_ne(cube, cube) IS 'different';


--
-- TOC entry 167 (class 1255 OID 16719)
-- Dependencies: 1060 1060 6
-- Name: cube_overlap(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_overlap(cube, cube) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_overlap';


ALTER FUNCTION public.cube_overlap(cube, cube) OWNER TO postgres;

--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 167
-- Name: FUNCTION cube_overlap(cube, cube); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION cube_overlap(cube, cube) IS 'overlaps';


--
-- TOC entry 168 (class 1255 OID 16720)
-- Dependencies: 1060 6
-- Name: cube_size(cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_size(cube) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_size';


ALTER FUNCTION public.cube_size(cube) OWNER TO postgres;

--
-- TOC entry 169 (class 1255 OID 16721)
-- Dependencies: 6 1060 1060
-- Name: cube_subset(cube, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_subset(cube, integer[]) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_subset';


ALTER FUNCTION public.cube_subset(cube, integer[]) OWNER TO postgres;

--
-- TOC entry 170 (class 1255 OID 16722)
-- Dependencies: 1060 1060 6 1060
-- Name: cube_union(cube, cube); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_union(cube, cube) RETURNS cube
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_union';


ALTER FUNCTION public.cube_union(cube, cube) OWNER TO postgres;

--
-- TOC entry 171 (class 1255 OID 16723)
-- Dependencies: 1060 6
-- Name: cube_ur_coord(cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cube_ur_coord(cube, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'cube_ur_coord';


ALTER FUNCTION public.cube_ur_coord(cube, integer) OWNER TO postgres;

--
-- TOC entry 172 (class 1255 OID 16724)
-- Dependencies: 6
-- Name: dblink(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text, text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, text) OWNER TO postgres;

--
-- TOC entry 173 (class 1255 OID 16725)
-- Dependencies: 6
-- Name: dblink(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text, text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 174 (class 1255 OID 16726)
-- Dependencies: 6
-- Name: dblink(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text) OWNER TO postgres;

--
-- TOC entry 175 (class 1255 OID 16727)
-- Dependencies: 6
-- Name: dblink(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink(text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_record';


ALTER FUNCTION public.dblink(text, boolean) OWNER TO postgres;

--
-- TOC entry 176 (class 1255 OID 16728)
-- Dependencies: 6
-- Name: dblink_build_sql_delete(text, int2vector, integer, text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_build_sql_delete(text, int2vector, integer, text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_delete';


ALTER FUNCTION public.dblink_build_sql_delete(text, int2vector, integer, text[]) OWNER TO postgres;

--
-- TOC entry 177 (class 1255 OID 16729)
-- Dependencies: 6
-- Name: dblink_build_sql_insert(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_build_sql_insert(text, int2vector, integer, text[], text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_insert';


ALTER FUNCTION public.dblink_build_sql_insert(text, int2vector, integer, text[], text[]) OWNER TO postgres;

--
-- TOC entry 178 (class 1255 OID 16730)
-- Dependencies: 6
-- Name: dblink_build_sql_update(text, int2vector, integer, text[], text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_build_sql_update(text, int2vector, integer, text[], text[]) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_build_sql_update';


ALTER FUNCTION public.dblink_build_sql_update(text, int2vector, integer, text[], text[]) OWNER TO postgres;

--
-- TOC entry 179 (class 1255 OID 16731)
-- Dependencies: 6
-- Name: dblink_cancel_query(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_cancel_query(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_cancel_query';


ALTER FUNCTION public.dblink_cancel_query(text) OWNER TO postgres;

--
-- TOC entry 180 (class 1255 OID 16732)
-- Dependencies: 6
-- Name: dblink_close(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text) OWNER TO postgres;

--
-- TOC entry 181 (class 1255 OID 16733)
-- Dependencies: 6
-- Name: dblink_close(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, boolean) OWNER TO postgres;

--
-- TOC entry 182 (class 1255 OID 16734)
-- Dependencies: 6
-- Name: dblink_close(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, text) OWNER TO postgres;

--
-- TOC entry 183 (class 1255 OID 16735)
-- Dependencies: 6
-- Name: dblink_close(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_close(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_close';


ALTER FUNCTION public.dblink_close(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 184 (class 1255 OID 16736)
-- Dependencies: 6
-- Name: dblink_connect(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect(text) OWNER TO postgres;

--
-- TOC entry 185 (class 1255 OID 16737)
-- Dependencies: 6
-- Name: dblink_connect(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect(text, text) OWNER TO postgres;

--
-- TOC entry 763 (class 1255 OID 16738)
-- Dependencies: 6
-- Name: dblink_connect_u(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect_u(text) RETURNS text
    LANGUAGE c STRICT SECURITY DEFINER
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect_u(text) OWNER TO postgres;

--
-- TOC entry 765 (class 1255 OID 16739)
-- Dependencies: 6
-- Name: dblink_connect_u(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_connect_u(text, text) RETURNS text
    LANGUAGE c STRICT SECURITY DEFINER
    AS '$libdir/dblink', 'dblink_connect';


ALTER FUNCTION public.dblink_connect_u(text, text) OWNER TO postgres;

--
-- TOC entry 186 (class 1255 OID 16740)
-- Dependencies: 6
-- Name: dblink_current_query(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_current_query() RETURNS text
    LANGUAGE c
    AS '$libdir/dblink', 'dblink_current_query';


ALTER FUNCTION public.dblink_current_query() OWNER TO postgres;

--
-- TOC entry 187 (class 1255 OID 16741)
-- Dependencies: 6
-- Name: dblink_disconnect(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_disconnect() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_disconnect';


ALTER FUNCTION public.dblink_disconnect() OWNER TO postgres;

--
-- TOC entry 188 (class 1255 OID 16742)
-- Dependencies: 6
-- Name: dblink_disconnect(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_disconnect(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_disconnect';


ALTER FUNCTION public.dblink_disconnect(text) OWNER TO postgres;

--
-- TOC entry 189 (class 1255 OID 16743)
-- Dependencies: 6
-- Name: dblink_error_message(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_error_message(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_error_message';


ALTER FUNCTION public.dblink_error_message(text) OWNER TO postgres;

--
-- TOC entry 190 (class 1255 OID 16744)
-- Dependencies: 6
-- Name: dblink_exec(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, text) OWNER TO postgres;

--
-- TOC entry 191 (class 1255 OID 16745)
-- Dependencies: 6
-- Name: dblink_exec(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 192 (class 1255 OID 16746)
-- Dependencies: 6
-- Name: dblink_exec(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text) OWNER TO postgres;

--
-- TOC entry 193 (class 1255 OID 16747)
-- Dependencies: 6
-- Name: dblink_exec(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_exec(text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_exec';


ALTER FUNCTION public.dblink_exec(text, boolean) OWNER TO postgres;

--
-- TOC entry 194 (class 1255 OID 16748)
-- Dependencies: 6
-- Name: dblink_fetch(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, integer) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, integer) OWNER TO postgres;

--
-- TOC entry 195 (class 1255 OID 16749)
-- Dependencies: 6
-- Name: dblink_fetch(text, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, integer, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, integer, boolean) OWNER TO postgres;

--
-- TOC entry 196 (class 1255 OID 16750)
-- Dependencies: 6
-- Name: dblink_fetch(text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, text, integer) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, text, integer) OWNER TO postgres;

--
-- TOC entry 197 (class 1255 OID 16751)
-- Dependencies: 6
-- Name: dblink_fetch(text, text, integer, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_fetch(text, text, integer, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_fetch';


ALTER FUNCTION public.dblink_fetch(text, text, integer, boolean) OWNER TO postgres;

--
-- TOC entry 198 (class 1255 OID 16752)
-- Dependencies: 6
-- Name: dblink_get_connections(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_connections() RETURNS text[]
    LANGUAGE c
    AS '$libdir/dblink', 'dblink_get_connections';


ALTER FUNCTION public.dblink_get_connections() OWNER TO postgres;

--
-- TOC entry 199 (class 1255 OID 16753)
-- Dependencies: 6 1063
-- Name: dblink_get_pkey(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_pkey(text) RETURNS SETOF dblink_pkey_results
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_pkey';


ALTER FUNCTION public.dblink_get_pkey(text) OWNER TO postgres;

--
-- TOC entry 200 (class 1255 OID 16754)
-- Dependencies: 6
-- Name: dblink_get_result(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_result(text) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_result';


ALTER FUNCTION public.dblink_get_result(text) OWNER TO postgres;

--
-- TOC entry 201 (class 1255 OID 16755)
-- Dependencies: 6
-- Name: dblink_get_result(text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_get_result(text, boolean) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_get_result';


ALTER FUNCTION public.dblink_get_result(text, boolean) OWNER TO postgres;

--
-- TOC entry 202 (class 1255 OID 16756)
-- Dependencies: 6
-- Name: dblink_is_busy(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_is_busy(text) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_is_busy';


ALTER FUNCTION public.dblink_is_busy(text) OWNER TO postgres;

--
-- TOC entry 203 (class 1255 OID 16757)
-- Dependencies: 6
-- Name: dblink_open(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text) OWNER TO postgres;

--
-- TOC entry 204 (class 1255 OID 16758)
-- Dependencies: 6
-- Name: dblink_open(text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, boolean) OWNER TO postgres;

--
-- TOC entry 205 (class 1255 OID 16759)
-- Dependencies: 6
-- Name: dblink_open(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, text) OWNER TO postgres;

--
-- TOC entry 206 (class 1255 OID 16760)
-- Dependencies: 6
-- Name: dblink_open(text, text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_open(text, text, text, boolean) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_open';


ALTER FUNCTION public.dblink_open(text, text, text, boolean) OWNER TO postgres;

--
-- TOC entry 207 (class 1255 OID 16761)
-- Dependencies: 6
-- Name: dblink_send_query(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dblink_send_query(text, text) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/dblink', 'dblink_send_query';


ALTER FUNCTION public.dblink_send_query(text, text) OWNER TO postgres;

--
-- TOC entry 208 (class 1255 OID 16762)
-- Dependencies: 6
-- Name: dearmor(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dearmor(text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_dearmor';


ALTER FUNCTION public.dearmor(text) OWNER TO postgres;

--
-- TOC entry 209 (class 1255 OID 16763)
-- Dependencies: 6
-- Name: decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION decrypt(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_decrypt';


ALTER FUNCTION public.decrypt(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 210 (class 1255 OID 16764)
-- Dependencies: 6
-- Name: decrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION decrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_decrypt_iv';


ALTER FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 16765)
-- Dependencies: 6 1097
-- Name: defined(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION defined(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'defined';


ALTER FUNCTION public.defined(hstore, text) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16766)
-- Dependencies: 1097 6 1097
-- Name: delete(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete(hstore, text) RETURNS hstore
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'delete';


ALTER FUNCTION public.delete(hstore, text) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16767)
-- Dependencies: 6
-- Name: difference(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION difference(text, text) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'difference';


ALTER FUNCTION public.difference(text, text) OWNER TO postgres;

--
-- TOC entry 214 (class 1255 OID 16768)
-- Dependencies: 6
-- Name: digest(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION digest(text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_digest';


ALTER FUNCTION public.digest(text, text) OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 16769)
-- Dependencies: 6
-- Name: digest(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION digest(bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_digest';


ALTER FUNCTION public.digest(bytea, text) OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 16770)
-- Dependencies: 6
-- Name: dmetaphone(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dmetaphone(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'dmetaphone';


ALTER FUNCTION public.dmetaphone(text) OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 16771)
-- Dependencies: 6
-- Name: dmetaphone_alt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dmetaphone_alt(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'dmetaphone_alt';


ALTER FUNCTION public.dmetaphone_alt(text) OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16772)
-- Dependencies: 1097 6
-- Name: each(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION each(hs hstore, OUT key text, OUT value text) RETURNS SETOF record
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'each';


ALTER FUNCTION public.each(hs hstore, OUT key text, OUT value text) OWNER TO postgres;

--
-- TOC entry 219 (class 1255 OID 16773)
-- Dependencies: 1187 6 1060
-- Name: earth_box(earth, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION earth_box(earth, double precision) RETURNS cube
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT cube_enlarge($1, gc_to_sec($2), 3)$_$;


ALTER FUNCTION public.earth_box(earth, double precision) OWNER TO postgres;

--
-- TOC entry 220 (class 1255 OID 16774)
-- Dependencies: 6 1187 1187
-- Name: earth_distance(earth, earth); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION earth_distance(earth, earth) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT sec_to_gc(cube_distance($1, $2))$_$;


ALTER FUNCTION public.earth_distance(earth, earth) OWNER TO postgres;

--
-- TOC entry 221 (class 1255 OID 16775)
-- Dependencies: 6
-- Name: encrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION encrypt(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_encrypt';


ALTER FUNCTION public.encrypt(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 16776)
-- Dependencies: 6
-- Name: encrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION encrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_encrypt_iv';


ALTER FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 223 (class 1255 OID 16777)
-- Dependencies: 1054 6
-- Name: eq(chkpass, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION eq(chkpass, text) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_eq';


ALTER FUNCTION public.eq(chkpass, text) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 16778)
-- Dependencies: 6 1097
-- Name: exist(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exist(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'exists';


ALTER FUNCTION public.exist(hstore, text) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 16779)
-- Dependencies: 6 1097
-- Name: fetchval(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION fetchval(hstore, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'fetchval';


ALTER FUNCTION public.fetchval(hstore, text) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 16780)
-- Dependencies: 6
-- Name: g_cube_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_compress';


ALTER FUNCTION public.g_cube_compress(internal) OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 16781)
-- Dependencies: 1060 6
-- Name: g_cube_consistent(internal, cube, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_consistent(internal, cube, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_consistent';


ALTER FUNCTION public.g_cube_consistent(internal, cube, integer) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 16782)
-- Dependencies: 6
-- Name: g_cube_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_decompress';


ALTER FUNCTION public.g_cube_decompress(internal) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 16783)
-- Dependencies: 6
-- Name: g_cube_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/cube', 'g_cube_penalty';


ALTER FUNCTION public.g_cube_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 16784)
-- Dependencies: 6
-- Name: g_cube_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_picksplit';


ALTER FUNCTION public.g_cube_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16785)
-- Dependencies: 1060 6 1060
-- Name: g_cube_same(cube, cube, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_same(cube, cube, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_same';


ALTER FUNCTION public.g_cube_same(cube, cube, internal) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 16786)
-- Dependencies: 1060 6
-- Name: g_cube_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_cube_union(internal, internal) RETURNS cube
    LANGUAGE c IMMUTABLE
    AS '$libdir/cube', 'g_cube_union';


ALTER FUNCTION public.g_cube_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16787)
-- Dependencies: 6
-- Name: g_int_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_compress';


ALTER FUNCTION public.g_int_compress(internal) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16788)
-- Dependencies: 6
-- Name: g_int_consistent(internal, integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_consistent(internal, integer[], integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_consistent';


ALTER FUNCTION public.g_int_consistent(internal, integer[], integer) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 16789)
-- Dependencies: 6
-- Name: g_int_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_decompress';


ALTER FUNCTION public.g_int_decompress(internal) OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 16790)
-- Dependencies: 6
-- Name: g_int_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'g_int_penalty';


ALTER FUNCTION public.g_int_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16791)
-- Dependencies: 6
-- Name: g_int_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_picksplit';


ALTER FUNCTION public.g_int_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16792)
-- Dependencies: 6
-- Name: g_int_same(integer[], integer[], internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_same(integer[], integer[], internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_same';


ALTER FUNCTION public.g_int_same(integer[], integer[], internal) OWNER TO postgres;

--
-- TOC entry 239 (class 1255 OID 16793)
-- Dependencies: 6
-- Name: g_int_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_int_union(internal, internal) RETURNS integer[]
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_int_union';


ALTER FUNCTION public.g_int_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 240 (class 1255 OID 16794)
-- Dependencies: 6
-- Name: g_intbig_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_compress';


ALTER FUNCTION public.g_intbig_compress(internal) OWNER TO postgres;

--
-- TOC entry 241 (class 1255 OID 16795)
-- Dependencies: 6
-- Name: g_intbig_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_consistent(internal, internal, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_consistent';


ALTER FUNCTION public.g_intbig_consistent(internal, internal, integer) OWNER TO postgres;

--
-- TOC entry 242 (class 1255 OID 16796)
-- Dependencies: 6
-- Name: g_intbig_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_decompress';


ALTER FUNCTION public.g_intbig_decompress(internal) OWNER TO postgres;

--
-- TOC entry 243 (class 1255 OID 16797)
-- Dependencies: 6
-- Name: g_intbig_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'g_intbig_penalty';


ALTER FUNCTION public.g_intbig_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 16798)
-- Dependencies: 6
-- Name: g_intbig_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_picksplit';


ALTER FUNCTION public.g_intbig_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 16799)
-- Dependencies: 6
-- Name: g_intbig_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_same';


ALTER FUNCTION public.g_intbig_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 16800)
-- Dependencies: 6
-- Name: g_intbig_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION g_intbig_union(internal, internal) RETURNS integer[]
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'g_intbig_union';


ALTER FUNCTION public.g_intbig_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 16801)
-- Dependencies: 6
-- Name: gbt_bit_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_compress';


ALTER FUNCTION public.gbt_bit_compress(internal) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 16802)
-- Dependencies: 6
-- Name: gbt_bit_consistent(internal, bit, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_consistent(internal, bit, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_consistent';


ALTER FUNCTION public.gbt_bit_consistent(internal, bit, smallint) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 16803)
-- Dependencies: 6
-- Name: gbt_bit_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_bit_penalty';


ALTER FUNCTION public.gbt_bit_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 16804)
-- Dependencies: 6
-- Name: gbt_bit_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_picksplit';


ALTER FUNCTION public.gbt_bit_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 16805)
-- Dependencies: 6
-- Name: gbt_bit_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_same';


ALTER FUNCTION public.gbt_bit_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 16806)
-- Dependencies: 1085 6
-- Name: gbt_bit_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bit_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bit_union';


ALTER FUNCTION public.gbt_bit_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 16807)
-- Dependencies: 6
-- Name: gbt_bpchar_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bpchar_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bpchar_compress';


ALTER FUNCTION public.gbt_bpchar_compress(internal) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 16808)
-- Dependencies: 6
-- Name: gbt_bpchar_consistent(internal, character, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bpchar_consistent(internal, character, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bpchar_consistent';


ALTER FUNCTION public.gbt_bpchar_consistent(internal, character, smallint) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 16809)
-- Dependencies: 6
-- Name: gbt_bytea_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_compress';


ALTER FUNCTION public.gbt_bytea_compress(internal) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 16810)
-- Dependencies: 6
-- Name: gbt_bytea_consistent(internal, bytea, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_consistent(internal, bytea, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_consistent';


ALTER FUNCTION public.gbt_bytea_consistent(internal, bytea, smallint) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 16811)
-- Dependencies: 6
-- Name: gbt_bytea_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_bytea_penalty';


ALTER FUNCTION public.gbt_bytea_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 16812)
-- Dependencies: 6
-- Name: gbt_bytea_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_picksplit';


ALTER FUNCTION public.gbt_bytea_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 16813)
-- Dependencies: 6
-- Name: gbt_bytea_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_same';


ALTER FUNCTION public.gbt_bytea_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 16814)
-- Dependencies: 6 1085
-- Name: gbt_bytea_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_bytea_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_bytea_union';


ALTER FUNCTION public.gbt_bytea_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 16815)
-- Dependencies: 6
-- Name: gbt_cash_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_compress';


ALTER FUNCTION public.gbt_cash_compress(internal) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 16816)
-- Dependencies: 6
-- Name: gbt_cash_consistent(internal, money, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_consistent(internal, money, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_consistent';


ALTER FUNCTION public.gbt_cash_consistent(internal, money, smallint) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 16817)
-- Dependencies: 6
-- Name: gbt_cash_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_cash_penalty';


ALTER FUNCTION public.gbt_cash_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 16818)
-- Dependencies: 6
-- Name: gbt_cash_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_picksplit';


ALTER FUNCTION public.gbt_cash_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 16819)
-- Dependencies: 6
-- Name: gbt_cash_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_same';


ALTER FUNCTION public.gbt_cash_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 16820)
-- Dependencies: 1082 6
-- Name: gbt_cash_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_cash_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_cash_union';


ALTER FUNCTION public.gbt_cash_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 16821)
-- Dependencies: 6
-- Name: gbt_date_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_compress';


ALTER FUNCTION public.gbt_date_compress(internal) OWNER TO postgres;

--
-- TOC entry 268 (class 1255 OID 16822)
-- Dependencies: 6
-- Name: gbt_date_consistent(internal, date, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_consistent(internal, date, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_consistent';


ALTER FUNCTION public.gbt_date_consistent(internal, date, smallint) OWNER TO postgres;

--
-- TOC entry 269 (class 1255 OID 16823)
-- Dependencies: 6
-- Name: gbt_date_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_date_penalty';


ALTER FUNCTION public.gbt_date_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 16824)
-- Dependencies: 6
-- Name: gbt_date_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_picksplit';


ALTER FUNCTION public.gbt_date_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 16825)
-- Dependencies: 6
-- Name: gbt_date_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_same';


ALTER FUNCTION public.gbt_date_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 16826)
-- Dependencies: 1082 6
-- Name: gbt_date_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_date_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_date_union';


ALTER FUNCTION public.gbt_date_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 16827)
-- Dependencies: 6
-- Name: gbt_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_decompress';


ALTER FUNCTION public.gbt_decompress(internal) OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 16828)
-- Dependencies: 6
-- Name: gbt_float4_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_compress';


ALTER FUNCTION public.gbt_float4_compress(internal) OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 16829)
-- Dependencies: 6
-- Name: gbt_float4_consistent(internal, real, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_consistent(internal, real, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_consistent';


ALTER FUNCTION public.gbt_float4_consistent(internal, real, smallint) OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 16830)
-- Dependencies: 6
-- Name: gbt_float4_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_float4_penalty';


ALTER FUNCTION public.gbt_float4_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 16831)
-- Dependencies: 6
-- Name: gbt_float4_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_picksplit';


ALTER FUNCTION public.gbt_float4_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 16832)
-- Dependencies: 6
-- Name: gbt_float4_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_same';


ALTER FUNCTION public.gbt_float4_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 16833)
-- Dependencies: 1082 6
-- Name: gbt_float4_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float4_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float4_union';


ALTER FUNCTION public.gbt_float4_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 16834)
-- Dependencies: 6
-- Name: gbt_float8_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_compress';


ALTER FUNCTION public.gbt_float8_compress(internal) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 16835)
-- Dependencies: 6
-- Name: gbt_float8_consistent(internal, double precision, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_consistent(internal, double precision, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_consistent';


ALTER FUNCTION public.gbt_float8_consistent(internal, double precision, smallint) OWNER TO postgres;

--
-- TOC entry 282 (class 1255 OID 16836)
-- Dependencies: 6
-- Name: gbt_float8_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_float8_penalty';


ALTER FUNCTION public.gbt_float8_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 16837)
-- Dependencies: 6
-- Name: gbt_float8_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_picksplit';


ALTER FUNCTION public.gbt_float8_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 16838)
-- Dependencies: 6
-- Name: gbt_float8_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_same';


ALTER FUNCTION public.gbt_float8_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 285 (class 1255 OID 16839)
-- Dependencies: 6 1073
-- Name: gbt_float8_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_float8_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_float8_union';


ALTER FUNCTION public.gbt_float8_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 286 (class 1255 OID 16840)
-- Dependencies: 6
-- Name: gbt_inet_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_compress';


ALTER FUNCTION public.gbt_inet_compress(internal) OWNER TO postgres;

--
-- TOC entry 287 (class 1255 OID 16841)
-- Dependencies: 6
-- Name: gbt_inet_consistent(internal, inet, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_consistent(internal, inet, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_consistent';


ALTER FUNCTION public.gbt_inet_consistent(internal, inet, smallint) OWNER TO postgres;

--
-- TOC entry 288 (class 1255 OID 16842)
-- Dependencies: 6
-- Name: gbt_inet_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_inet_penalty';


ALTER FUNCTION public.gbt_inet_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 289 (class 1255 OID 16843)
-- Dependencies: 6
-- Name: gbt_inet_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_picksplit';


ALTER FUNCTION public.gbt_inet_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 290 (class 1255 OID 16844)
-- Dependencies: 6
-- Name: gbt_inet_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_same';


ALTER FUNCTION public.gbt_inet_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 291 (class 1255 OID 16845)
-- Dependencies: 6 1073
-- Name: gbt_inet_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_inet_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_inet_union';


ALTER FUNCTION public.gbt_inet_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 292 (class 1255 OID 16846)
-- Dependencies: 6
-- Name: gbt_int2_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_compress';


ALTER FUNCTION public.gbt_int2_compress(internal) OWNER TO postgres;

--
-- TOC entry 293 (class 1255 OID 16847)
-- Dependencies: 6
-- Name: gbt_int2_consistent(internal, smallint, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_consistent(internal, smallint, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_consistent';


ALTER FUNCTION public.gbt_int2_consistent(internal, smallint, smallint) OWNER TO postgres;

--
-- TOC entry 294 (class 1255 OID 16848)
-- Dependencies: 6
-- Name: gbt_int2_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_int2_penalty';


ALTER FUNCTION public.gbt_int2_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 295 (class 1255 OID 16849)
-- Dependencies: 6
-- Name: gbt_int2_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_picksplit';


ALTER FUNCTION public.gbt_int2_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 296 (class 1255 OID 16850)
-- Dependencies: 6
-- Name: gbt_int2_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_same';


ALTER FUNCTION public.gbt_int2_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 16851)
-- Dependencies: 1079 6
-- Name: gbt_int2_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int2_union(bytea, internal) RETURNS gbtreekey4
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int2_union';


ALTER FUNCTION public.gbt_int2_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 298 (class 1255 OID 16852)
-- Dependencies: 6
-- Name: gbt_int4_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_compress';


ALTER FUNCTION public.gbt_int4_compress(internal) OWNER TO postgres;

--
-- TOC entry 299 (class 1255 OID 16853)
-- Dependencies: 6
-- Name: gbt_int4_consistent(internal, integer, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_consistent(internal, integer, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_consistent';


ALTER FUNCTION public.gbt_int4_consistent(internal, integer, smallint) OWNER TO postgres;

--
-- TOC entry 300 (class 1255 OID 16854)
-- Dependencies: 6
-- Name: gbt_int4_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_int4_penalty';


ALTER FUNCTION public.gbt_int4_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 16855)
-- Dependencies: 6
-- Name: gbt_int4_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_picksplit';


ALTER FUNCTION public.gbt_int4_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 302 (class 1255 OID 16856)
-- Dependencies: 6
-- Name: gbt_int4_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_same';


ALTER FUNCTION public.gbt_int4_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 303 (class 1255 OID 16857)
-- Dependencies: 1082 6
-- Name: gbt_int4_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int4_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int4_union';


ALTER FUNCTION public.gbt_int4_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 304 (class 1255 OID 16858)
-- Dependencies: 6
-- Name: gbt_int8_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_compress';


ALTER FUNCTION public.gbt_int8_compress(internal) OWNER TO postgres;

--
-- TOC entry 305 (class 1255 OID 16859)
-- Dependencies: 6
-- Name: gbt_int8_consistent(internal, bigint, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_consistent(internal, bigint, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_consistent';


ALTER FUNCTION public.gbt_int8_consistent(internal, bigint, smallint) OWNER TO postgres;

--
-- TOC entry 306 (class 1255 OID 16860)
-- Dependencies: 6
-- Name: gbt_int8_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_int8_penalty';


ALTER FUNCTION public.gbt_int8_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 307 (class 1255 OID 16861)
-- Dependencies: 6
-- Name: gbt_int8_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_picksplit';


ALTER FUNCTION public.gbt_int8_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 308 (class 1255 OID 16862)
-- Dependencies: 6
-- Name: gbt_int8_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_same';


ALTER FUNCTION public.gbt_int8_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 309 (class 1255 OID 16863)
-- Dependencies: 1073 6
-- Name: gbt_int8_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_int8_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_int8_union';


ALTER FUNCTION public.gbt_int8_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 310 (class 1255 OID 16864)
-- Dependencies: 6
-- Name: gbt_intv_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_compress';


ALTER FUNCTION public.gbt_intv_compress(internal) OWNER TO postgres;

--
-- TOC entry 311 (class 1255 OID 16865)
-- Dependencies: 6
-- Name: gbt_intv_consistent(internal, interval, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_consistent(internal, interval, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_consistent';


ALTER FUNCTION public.gbt_intv_consistent(internal, interval, smallint) OWNER TO postgres;

--
-- TOC entry 312 (class 1255 OID 16866)
-- Dependencies: 6
-- Name: gbt_intv_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_decompress';


ALTER FUNCTION public.gbt_intv_decompress(internal) OWNER TO postgres;

--
-- TOC entry 313 (class 1255 OID 16867)
-- Dependencies: 6
-- Name: gbt_intv_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_intv_penalty';


ALTER FUNCTION public.gbt_intv_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 314 (class 1255 OID 16868)
-- Dependencies: 6
-- Name: gbt_intv_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_picksplit';


ALTER FUNCTION public.gbt_intv_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 315 (class 1255 OID 16869)
-- Dependencies: 6
-- Name: gbt_intv_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_same';


ALTER FUNCTION public.gbt_intv_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 316 (class 1255 OID 16870)
-- Dependencies: 1076 6
-- Name: gbt_intv_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_intv_union(bytea, internal) RETURNS gbtreekey32
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_intv_union';


ALTER FUNCTION public.gbt_intv_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 317 (class 1255 OID 16871)
-- Dependencies: 6
-- Name: gbt_macad_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_compress';


ALTER FUNCTION public.gbt_macad_compress(internal) OWNER TO postgres;

--
-- TOC entry 318 (class 1255 OID 16872)
-- Dependencies: 6
-- Name: gbt_macad_consistent(internal, macaddr, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_consistent(internal, macaddr, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_consistent';


ALTER FUNCTION public.gbt_macad_consistent(internal, macaddr, smallint) OWNER TO postgres;

--
-- TOC entry 319 (class 1255 OID 16873)
-- Dependencies: 6
-- Name: gbt_macad_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_macad_penalty';


ALTER FUNCTION public.gbt_macad_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 320 (class 1255 OID 16874)
-- Dependencies: 6
-- Name: gbt_macad_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_picksplit';


ALTER FUNCTION public.gbt_macad_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 321 (class 1255 OID 16875)
-- Dependencies: 6
-- Name: gbt_macad_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_same';


ALTER FUNCTION public.gbt_macad_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 322 (class 1255 OID 16876)
-- Dependencies: 6 1073
-- Name: gbt_macad_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_macad_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_macad_union';


ALTER FUNCTION public.gbt_macad_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 323 (class 1255 OID 16877)
-- Dependencies: 6
-- Name: gbt_numeric_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_compress';


ALTER FUNCTION public.gbt_numeric_compress(internal) OWNER TO postgres;

--
-- TOC entry 324 (class 1255 OID 16878)
-- Dependencies: 6
-- Name: gbt_numeric_consistent(internal, numeric, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_consistent(internal, numeric, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_consistent';


ALTER FUNCTION public.gbt_numeric_consistent(internal, numeric, smallint) OWNER TO postgres;

--
-- TOC entry 325 (class 1255 OID 16879)
-- Dependencies: 6
-- Name: gbt_numeric_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_numeric_penalty';


ALTER FUNCTION public.gbt_numeric_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 326 (class 1255 OID 16880)
-- Dependencies: 6
-- Name: gbt_numeric_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_picksplit';


ALTER FUNCTION public.gbt_numeric_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 327 (class 1255 OID 16881)
-- Dependencies: 6
-- Name: gbt_numeric_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_same';


ALTER FUNCTION public.gbt_numeric_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 328 (class 1255 OID 16882)
-- Dependencies: 6 1085
-- Name: gbt_numeric_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_numeric_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_numeric_union';


ALTER FUNCTION public.gbt_numeric_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 329 (class 1255 OID 16883)
-- Dependencies: 6
-- Name: gbt_oid_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_compress';


ALTER FUNCTION public.gbt_oid_compress(internal) OWNER TO postgres;

--
-- TOC entry 330 (class 1255 OID 16884)
-- Dependencies: 6
-- Name: gbt_oid_consistent(internal, oid, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_consistent(internal, oid, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_consistent';


ALTER FUNCTION public.gbt_oid_consistent(internal, oid, smallint) OWNER TO postgres;

--
-- TOC entry 331 (class 1255 OID 16885)
-- Dependencies: 6
-- Name: gbt_oid_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_oid_penalty';


ALTER FUNCTION public.gbt_oid_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 332 (class 1255 OID 16886)
-- Dependencies: 6
-- Name: gbt_oid_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_picksplit';


ALTER FUNCTION public.gbt_oid_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 333 (class 1255 OID 16887)
-- Dependencies: 6
-- Name: gbt_oid_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_same';


ALTER FUNCTION public.gbt_oid_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 334 (class 1255 OID 16888)
-- Dependencies: 6 1082
-- Name: gbt_oid_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_oid_union(bytea, internal) RETURNS gbtreekey8
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_oid_union';


ALTER FUNCTION public.gbt_oid_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 335 (class 1255 OID 16889)
-- Dependencies: 6
-- Name: gbt_text_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_compress';


ALTER FUNCTION public.gbt_text_compress(internal) OWNER TO postgres;

--
-- TOC entry 336 (class 1255 OID 16890)
-- Dependencies: 6
-- Name: gbt_text_consistent(internal, text, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_consistent(internal, text, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_consistent';


ALTER FUNCTION public.gbt_text_consistent(internal, text, smallint) OWNER TO postgres;

--
-- TOC entry 337 (class 1255 OID 16891)
-- Dependencies: 6
-- Name: gbt_text_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_text_penalty';


ALTER FUNCTION public.gbt_text_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 338 (class 1255 OID 16892)
-- Dependencies: 6
-- Name: gbt_text_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_picksplit';


ALTER FUNCTION public.gbt_text_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 339 (class 1255 OID 16893)
-- Dependencies: 6
-- Name: gbt_text_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_same';


ALTER FUNCTION public.gbt_text_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 340 (class 1255 OID 16894)
-- Dependencies: 6 1085
-- Name: gbt_text_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_text_union(bytea, internal) RETURNS gbtreekey_var
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_text_union';


ALTER FUNCTION public.gbt_text_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 341 (class 1255 OID 16895)
-- Dependencies: 6
-- Name: gbt_time_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_compress';


ALTER FUNCTION public.gbt_time_compress(internal) OWNER TO postgres;

--
-- TOC entry 342 (class 1255 OID 16896)
-- Dependencies: 6
-- Name: gbt_time_consistent(internal, time without time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_consistent(internal, time without time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_consistent';


ALTER FUNCTION public.gbt_time_consistent(internal, time without time zone, smallint) OWNER TO postgres;

--
-- TOC entry 343 (class 1255 OID 16897)
-- Dependencies: 6
-- Name: gbt_time_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_time_penalty';


ALTER FUNCTION public.gbt_time_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 344 (class 1255 OID 16898)
-- Dependencies: 6
-- Name: gbt_time_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_picksplit';


ALTER FUNCTION public.gbt_time_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 345 (class 1255 OID 16899)
-- Dependencies: 6
-- Name: gbt_time_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_same';


ALTER FUNCTION public.gbt_time_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 346 (class 1255 OID 16900)
-- Dependencies: 6 1073
-- Name: gbt_time_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_time_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_time_union';


ALTER FUNCTION public.gbt_time_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 347 (class 1255 OID 16901)
-- Dependencies: 6
-- Name: gbt_timetz_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_timetz_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_timetz_compress';


ALTER FUNCTION public.gbt_timetz_compress(internal) OWNER TO postgres;

--
-- TOC entry 348 (class 1255 OID 16902)
-- Dependencies: 6
-- Name: gbt_timetz_consistent(internal, time with time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_timetz_consistent(internal, time with time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_timetz_consistent';


ALTER FUNCTION public.gbt_timetz_consistent(internal, time with time zone, smallint) OWNER TO postgres;

--
-- TOC entry 349 (class 1255 OID 16903)
-- Dependencies: 6
-- Name: gbt_ts_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_compress';


ALTER FUNCTION public.gbt_ts_compress(internal) OWNER TO postgres;

--
-- TOC entry 350 (class 1255 OID 16904)
-- Dependencies: 6
-- Name: gbt_ts_consistent(internal, timestamp without time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_consistent(internal, timestamp without time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_consistent';


ALTER FUNCTION public.gbt_ts_consistent(internal, timestamp without time zone, smallint) OWNER TO postgres;

--
-- TOC entry 351 (class 1255 OID 16905)
-- Dependencies: 6
-- Name: gbt_ts_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/btree_gist', 'gbt_ts_penalty';


ALTER FUNCTION public.gbt_ts_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 352 (class 1255 OID 16906)
-- Dependencies: 6
-- Name: gbt_ts_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_picksplit';


ALTER FUNCTION public.gbt_ts_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 353 (class 1255 OID 16907)
-- Dependencies: 6
-- Name: gbt_ts_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_same';


ALTER FUNCTION public.gbt_ts_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 354 (class 1255 OID 16908)
-- Dependencies: 6 1073
-- Name: gbt_ts_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_ts_union(bytea, internal) RETURNS gbtreekey16
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_ts_union';


ALTER FUNCTION public.gbt_ts_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 355 (class 1255 OID 16909)
-- Dependencies: 6
-- Name: gbt_tstz_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_tstz_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_tstz_compress';


ALTER FUNCTION public.gbt_tstz_compress(internal) OWNER TO postgres;

--
-- TOC entry 356 (class 1255 OID 16910)
-- Dependencies: 6
-- Name: gbt_tstz_consistent(internal, timestamp with time zone, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_tstz_consistent(internal, timestamp with time zone, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_tstz_consistent';


ALTER FUNCTION public.gbt_tstz_consistent(internal, timestamp with time zone, smallint) OWNER TO postgres;

--
-- TOC entry 357 (class 1255 OID 16911)
-- Dependencies: 6
-- Name: gbt_var_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gbt_var_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/btree_gist', 'gbt_var_decompress';


ALTER FUNCTION public.gbt_var_decompress(internal) OWNER TO postgres;

--
-- TOC entry 358 (class 1255 OID 16912)
-- Dependencies: 6
-- Name: gc_to_sec(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gc_to_sec(double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN $1 < 0 THEN 0::float8 WHEN $1/earth() > pi() THEN 2*earth() ELSE 2*earth()*sin($1/(2*earth())) END$_$;


ALTER FUNCTION public.gc_to_sec(double precision) OWNER TO postgres;

--
-- TOC entry 359 (class 1255 OID 16913)
-- Dependencies: 6
-- Name: gen_random_bytes(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gen_random_bytes(integer) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_random_bytes';


ALTER FUNCTION public.gen_random_bytes(integer) OWNER TO postgres;

--
-- TOC entry 360 (class 1255 OID 16914)
-- Dependencies: 6
-- Name: gen_salt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gen_salt(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_gen_salt';


ALTER FUNCTION public.gen_salt(text) OWNER TO postgres;

--
-- TOC entry 361 (class 1255 OID 16915)
-- Dependencies: 6
-- Name: gen_salt(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gen_salt(text, integer) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_gen_salt_rounds';


ALTER FUNCTION public.gen_salt(text, integer) OWNER TO postgres;

--
-- TOC entry 362 (class 1255 OID 16916)
-- Dependencies: 6
-- Name: geo_distance(point, point); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION geo_distance(point, point) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/earthdistance', 'geo_distance';


ALTER FUNCTION public.geo_distance(point, point) OWNER TO postgres;

--
-- TOC entry 363 (class 1255 OID 16917)
-- Dependencies: 6
-- Name: get_raw_page(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_raw_page(text, integer) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'get_raw_page';


ALTER FUNCTION public.get_raw_page(text, integer) OWNER TO postgres;

--
-- TOC entry 364 (class 1255 OID 16918)
-- Dependencies: 6
-- Name: get_timetravel(name); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION get_timetravel(name) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/timetravel', 'get_timetravel';


ALTER FUNCTION public.get_timetravel(name) OWNER TO postgres;

--
-- TOC entry 365 (class 1255 OID 16919)
-- Dependencies: 6
-- Name: ghstore_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_compress';


ALTER FUNCTION public.ghstore_compress(internal) OWNER TO postgres;

--
-- TOC entry 366 (class 1255 OID 16920)
-- Dependencies: 6
-- Name: ghstore_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_consistent(internal, internal, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_consistent';


ALTER FUNCTION public.ghstore_consistent(internal, internal, integer) OWNER TO postgres;

--
-- TOC entry 367 (class 1255 OID 16921)
-- Dependencies: 6
-- Name: ghstore_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_decompress';


ALTER FUNCTION public.ghstore_decompress(internal) OWNER TO postgres;

--
-- TOC entry 368 (class 1255 OID 16922)
-- Dependencies: 6
-- Name: ghstore_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'ghstore_penalty';


ALTER FUNCTION public.ghstore_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 369 (class 1255 OID 16923)
-- Dependencies: 6
-- Name: ghstore_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_picksplit';


ALTER FUNCTION public.ghstore_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 370 (class 1255 OID 16924)
-- Dependencies: 6
-- Name: ghstore_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_same';


ALTER FUNCTION public.ghstore_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 371 (class 1255 OID 16925)
-- Dependencies: 6
-- Name: ghstore_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ghstore_union(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'ghstore_union';


ALTER FUNCTION public.ghstore_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 372 (class 1255 OID 16926)
-- Dependencies: 6
-- Name: gin_consistent_hstore(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_consistent_hstore(internal, smallint, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'gin_consistent_hstore';


ALTER FUNCTION public.gin_consistent_hstore(internal, smallint, internal) OWNER TO postgres;

--
-- TOC entry 373 (class 1255 OID 16927)
-- Dependencies: 6
-- Name: gin_extract_hstore(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_hstore(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'gin_extract_hstore';


ALTER FUNCTION public.gin_extract_hstore(internal, internal) OWNER TO postgres;

--
-- TOC entry 374 (class 1255 OID 16928)
-- Dependencies: 6
-- Name: gin_extract_hstore_query(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_hstore_query(internal, internal, smallint) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'gin_extract_hstore_query';


ALTER FUNCTION public.gin_extract_hstore_query(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 375 (class 1255 OID 16929)
-- Dependencies: 6
-- Name: gin_extract_trgm(text, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_trgm(text, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gin_extract_trgm';


ALTER FUNCTION public.gin_extract_trgm(text, internal) OWNER TO postgres;

--
-- TOC entry 376 (class 1255 OID 16930)
-- Dependencies: 6
-- Name: gin_extract_trgm(text, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_extract_trgm(text, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gin_extract_trgm';


ALTER FUNCTION public.gin_extract_trgm(text, internal, internal) OWNER TO postgres;

--
-- TOC entry 377 (class 1255 OID 16931)
-- Dependencies: 6
-- Name: gin_trgm_consistent(internal, internal, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gin_trgm_consistent(internal, internal, text) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gin_trgm_consistent';


ALTER FUNCTION public.gin_trgm_consistent(internal, internal, text) OWNER TO postgres;

--
-- TOC entry 378 (class 1255 OID 16932)
-- Dependencies: 6
-- Name: ginint4_consistent(internal, smallint, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ginint4_consistent(internal, smallint, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'ginint4_consistent';


ALTER FUNCTION public.ginint4_consistent(internal, smallint, internal) OWNER TO postgres;

--
-- TOC entry 379 (class 1255 OID 16933)
-- Dependencies: 6
-- Name: ginint4_queryextract(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ginint4_queryextract(internal, internal, smallint) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/_int', 'ginint4_queryextract';


ALTER FUNCTION public.ginint4_queryextract(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 380 (class 1255 OID 16934)
-- Dependencies: 6
-- Name: gseg_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_compress';


ALTER FUNCTION public.gseg_compress(internal) OWNER TO postgres;

--
-- TOC entry 381 (class 1255 OID 16935)
-- Dependencies: 6 1143
-- Name: gseg_consistent(internal, seg, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_consistent(internal, seg, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_consistent';


ALTER FUNCTION public.gseg_consistent(internal, seg, integer) OWNER TO postgres;

--
-- TOC entry 382 (class 1255 OID 16936)
-- Dependencies: 6
-- Name: gseg_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_decompress';


ALTER FUNCTION public.gseg_decompress(internal) OWNER TO postgres;

--
-- TOC entry 383 (class 1255 OID 16937)
-- Dependencies: 6
-- Name: gseg_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'gseg_penalty';


ALTER FUNCTION public.gseg_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 384 (class 1255 OID 16938)
-- Dependencies: 6
-- Name: gseg_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_picksplit';


ALTER FUNCTION public.gseg_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 385 (class 1255 OID 16939)
-- Dependencies: 6 1143 1143
-- Name: gseg_same(seg, seg, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_same(seg, seg, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_same';


ALTER FUNCTION public.gseg_same(seg, seg, internal) OWNER TO postgres;

--
-- TOC entry 386 (class 1255 OID 16940)
-- Dependencies: 6 1143
-- Name: gseg_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gseg_union(internal, internal) RETURNS seg
    LANGUAGE c IMMUTABLE
    AS '$libdir/seg', 'gseg_union';


ALTER FUNCTION public.gseg_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 387 (class 1255 OID 16941)
-- Dependencies: 6
-- Name: gtrgm_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_compress';


ALTER FUNCTION public.gtrgm_compress(internal) OWNER TO postgres;

--
-- TOC entry 388 (class 1255 OID 16942)
-- Dependencies: 6 1091
-- Name: gtrgm_consistent(gtrgm, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_consistent(gtrgm, internal, integer) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_consistent';


ALTER FUNCTION public.gtrgm_consistent(gtrgm, internal, integer) OWNER TO postgres;

--
-- TOC entry 389 (class 1255 OID 16943)
-- Dependencies: 6
-- Name: gtrgm_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_decompress';


ALTER FUNCTION public.gtrgm_decompress(internal) OWNER TO postgres;

--
-- TOC entry 390 (class 1255 OID 16944)
-- Dependencies: 6
-- Name: gtrgm_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pg_trgm', 'gtrgm_penalty';


ALTER FUNCTION public.gtrgm_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 391 (class 1255 OID 16945)
-- Dependencies: 6
-- Name: gtrgm_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_picksplit';


ALTER FUNCTION public.gtrgm_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 392 (class 1255 OID 16946)
-- Dependencies: 6 1091 1091
-- Name: gtrgm_same(gtrgm, gtrgm, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_same(gtrgm, gtrgm, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_same';


ALTER FUNCTION public.gtrgm_same(gtrgm, gtrgm, internal) OWNER TO postgres;

--
-- TOC entry 393 (class 1255 OID 16947)
-- Dependencies: 6
-- Name: gtrgm_union(bytea, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION gtrgm_union(bytea, internal) RETURNS integer[]
    LANGUAGE c IMMUTABLE
    AS '$libdir/pg_trgm', 'gtrgm_union';


ALTER FUNCTION public.gtrgm_union(bytea, internal) OWNER TO postgres;

--
-- TOC entry 394 (class 1255 OID 16948)
-- Dependencies: 6 1065
-- Name: hashean13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashean13(ean13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashean13(ean13) OWNER TO postgres;

--
-- TOC entry 395 (class 1255 OID 16949)
-- Dependencies: 6 1103
-- Name: hashisbn(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashisbn(isbn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashisbn(isbn) OWNER TO postgres;

--
-- TOC entry 396 (class 1255 OID 16950)
-- Dependencies: 6 1106
-- Name: hashisbn13(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashisbn13(isbn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashisbn13(isbn13) OWNER TO postgres;

--
-- TOC entry 397 (class 1255 OID 16951)
-- Dependencies: 6 1109
-- Name: hashismn(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashismn(ismn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashismn(ismn) OWNER TO postgres;

--
-- TOC entry 398 (class 1255 OID 16952)
-- Dependencies: 6 1112
-- Name: hashismn13(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashismn13(ismn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashismn13(ismn13) OWNER TO postgres;

--
-- TOC entry 399 (class 1255 OID 16953)
-- Dependencies: 6 1115
-- Name: hashissn(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashissn(issn) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashissn(issn) OWNER TO postgres;

--
-- TOC entry 400 (class 1255 OID 16954)
-- Dependencies: 6 1118
-- Name: hashissn13(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashissn13(issn13) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashissn13(issn13) OWNER TO postgres;

--
-- TOC entry 401 (class 1255 OID 16955)
-- Dependencies: 6 1182
-- Name: hashupc(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hashupc(upc) RETURNS integer
    LANGUAGE internal IMMUTABLE STRICT
    AS $$hashint8$$;


ALTER FUNCTION public.hashupc(upc) OWNER TO postgres;

--
-- TOC entry 402 (class 1255 OID 16956)
-- Dependencies: 6
-- Name: heap_page_items(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION heap_page_items(page bytea, OUT lp smallint, OUT lp_off smallint, OUT lp_flags smallint, OUT lp_len smallint, OUT t_xmin xid, OUT t_xmax xid, OUT t_field3 integer, OUT t_ctid tid, OUT t_infomask2 smallint, OUT t_infomask smallint, OUT t_hoff smallint, OUT t_bits text, OUT t_oid oid) RETURNS SETOF record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'heap_page_items';


ALTER FUNCTION public.heap_page_items(page bytea, OUT lp smallint, OUT lp_off smallint, OUT lp_flags smallint, OUT lp_len smallint, OUT t_xmin xid, OUT t_xmax xid, OUT t_field3 integer, OUT t_ctid tid, OUT t_infomask2 smallint, OUT t_infomask smallint, OUT t_hoff smallint, OUT t_bits text, OUT t_oid oid) OWNER TO postgres;

--
-- TOC entry 403 (class 1255 OID 16957)
-- Dependencies: 6
-- Name: hmac(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hmac(text, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_hmac';


ALTER FUNCTION public.hmac(text, text, text) OWNER TO postgres;

--
-- TOC entry 404 (class 1255 OID 16958)
-- Dependencies: 6
-- Name: hmac(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hmac(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_hmac';


ALTER FUNCTION public.hmac(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 405 (class 1255 OID 16959)
-- Dependencies: 6 1097 1097 1097
-- Name: hs_concat(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_concat(hstore, hstore) RETURNS hstore
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_concat';


ALTER FUNCTION public.hs_concat(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 406 (class 1255 OID 16960)
-- Dependencies: 6 1097 1097
-- Name: hs_contained(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_contained(hstore, hstore) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_contained';


ALTER FUNCTION public.hs_contained(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 407 (class 1255 OID 16961)
-- Dependencies: 6 1097 1097
-- Name: hs_contains(hstore, hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION hs_contains(hstore, hstore) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'hs_contains';


ALTER FUNCTION public.hs_contains(hstore, hstore) OWNER TO postgres;

--
-- TOC entry 408 (class 1255 OID 16962)
-- Dependencies: 6
-- Name: icount(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION icount(integer[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'icount';


ALTER FUNCTION public.icount(integer[]) OWNER TO postgres;

--
-- TOC entry 409 (class 1255 OID 16963)
-- Dependencies: 6
-- Name: idx(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION idx(integer[], integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'idx';


ALTER FUNCTION public.idx(integer[], integer) OWNER TO postgres;

--
-- TOC entry 410 (class 1255 OID 16964)
-- Dependencies: 6 1127 1127
-- Name: index(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION index(ltree, ltree) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_index';


ALTER FUNCTION public.index(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 411 (class 1255 OID 16965)
-- Dependencies: 6 1127 1127
-- Name: index(ltree, ltree, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION index(ltree, ltree, integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_index';


ALTER FUNCTION public.index(ltree, ltree, integer) OWNER TO postgres;

--
-- TOC entry 412 (class 1255 OID 16966)
-- Dependencies: 6
-- Name: insert_username(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insert_username() RETURNS trigger
    LANGUAGE c
    AS '$libdir/insert_username', 'insert_username';


ALTER FUNCTION public.insert_username() OWNER TO postgres;

--
-- TOC entry 413 (class 1255 OID 16970)
-- Dependencies: 6
-- Name: intarray_del_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_del_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_del_elem';


ALTER FUNCTION public.intarray_del_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 414 (class 1255 OID 16971)
-- Dependencies: 6
-- Name: intarray_push_array(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_push_array(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_push_array';


ALTER FUNCTION public.intarray_push_array(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 415 (class 1255 OID 16972)
-- Dependencies: 6
-- Name: intarray_push_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intarray_push_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_push_elem';


ALTER FUNCTION public.intarray_push_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 416 (class 1255 OID 16973)
-- Dependencies: 6
-- Name: intset(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset(integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset';


ALTER FUNCTION public.intset(integer) OWNER TO postgres;

--
-- TOC entry 417 (class 1255 OID 16974)
-- Dependencies: 6
-- Name: intset_subtract(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset_subtract(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset_subtract';


ALTER FUNCTION public.intset_subtract(integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 418 (class 1255 OID 16975)
-- Dependencies: 6
-- Name: intset_union_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION intset_union_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset_union_elem';


ALTER FUNCTION public.intset_union_elem(integer[], integer) OWNER TO postgres;

--
-- TOC entry 419 (class 1255 OID 16976)
-- Dependencies: 6 1065
-- Name: is_valid(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(ean13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(ean13) OWNER TO postgres;

--
-- TOC entry 420 (class 1255 OID 16977)
-- Dependencies: 6 1106
-- Name: is_valid(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(isbn13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(isbn13) OWNER TO postgres;

--
-- TOC entry 421 (class 1255 OID 16978)
-- Dependencies: 6 1112
-- Name: is_valid(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(ismn13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(ismn13) OWNER TO postgres;

--
-- TOC entry 422 (class 1255 OID 16979)
-- Dependencies: 6 1118
-- Name: is_valid(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(issn13) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(issn13) OWNER TO postgres;

--
-- TOC entry 423 (class 1255 OID 16980)
-- Dependencies: 6 1103
-- Name: is_valid(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(isbn) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(isbn) OWNER TO postgres;

--
-- TOC entry 424 (class 1255 OID 16981)
-- Dependencies: 6 1109
-- Name: is_valid(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(ismn) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(ismn) OWNER TO postgres;

--
-- TOC entry 425 (class 1255 OID 16982)
-- Dependencies: 6 1115
-- Name: is_valid(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(issn) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(issn) OWNER TO postgres;

--
-- TOC entry 426 (class 1255 OID 16983)
-- Dependencies: 6 1182
-- Name: is_valid(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_valid(upc) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'is_valid';


ALTER FUNCTION public.is_valid(upc) OWNER TO postgres;

--
-- TOC entry 427 (class 1255 OID 16984)
-- Dependencies: 6 1103 1065
-- Name: isbn(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn(ean13) RETURNS isbn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_cast_from_ean13';


ALTER FUNCTION public.isbn(ean13) OWNER TO postgres;

--
-- TOC entry 428 (class 1255 OID 16985)
-- Dependencies: 6 1106 1065
-- Name: isbn13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isbn13(ean13) RETURNS isbn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'isbn_cast_from_ean13';


ALTER FUNCTION public.isbn13(ean13) OWNER TO postgres;

--
-- TOC entry 429 (class 1255 OID 16986)
-- Dependencies: 6 1097
-- Name: isdefined(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isdefined(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'defined';


ALTER FUNCTION public.isdefined(hstore, text) OWNER TO postgres;

--
-- TOC entry 430 (class 1255 OID 16987)
-- Dependencies: 6 1097
-- Name: isexists(hstore, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isexists(hstore, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'exists';


ALTER FUNCTION public.isexists(hstore, text) OWNER TO postgres;

--
-- TOC entry 431 (class 1255 OID 16988)
-- Dependencies: 6 1109 1065
-- Name: ismn(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn(ean13) RETURNS ismn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_cast_from_ean13';


ALTER FUNCTION public.ismn(ean13) OWNER TO postgres;

--
-- TOC entry 432 (class 1255 OID 16989)
-- Dependencies: 6 1112 1065
-- Name: ismn13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ismn13(ean13) RETURNS ismn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'ismn_cast_from_ean13';


ALTER FUNCTION public.ismn13(ean13) OWNER TO postgres;

--
-- TOC entry 433 (class 1255 OID 16990)
-- Dependencies: 6
-- Name: isn_weak(boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_weak(boolean) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'accept_weak_input';


ALTER FUNCTION public.isn_weak(boolean) OWNER TO postgres;

--
-- TOC entry 434 (class 1255 OID 16991)
-- Dependencies: 6
-- Name: isn_weak(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isn_weak() RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'weak_input_status';


ALTER FUNCTION public.isn_weak() OWNER TO postgres;

--
-- TOC entry 435 (class 1255 OID 16992)
-- Dependencies: 6 1065 1065
-- Name: isneq(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 436 (class 1255 OID 16993)
-- Dependencies: 6 1065 1106
-- Name: isneq(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 437 (class 1255 OID 16994)
-- Dependencies: 6 1065 1112
-- Name: isneq(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 438 (class 1255 OID 16995)
-- Dependencies: 6 1065 1118
-- Name: isneq(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 439 (class 1255 OID 16996)
-- Dependencies: 6 1065 1103
-- Name: isneq(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 440 (class 1255 OID 16997)
-- Dependencies: 6 1065 1109
-- Name: isneq(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 441 (class 1255 OID 16998)
-- Dependencies: 6 1065 1115
-- Name: isneq(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, issn) OWNER TO postgres;

--
-- TOC entry 442 (class 1255 OID 16999)
-- Dependencies: 6 1065 1182
-- Name: isneq(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ean13, upc) OWNER TO postgres;

--
-- TOC entry 443 (class 1255 OID 17000)
-- Dependencies: 6 1106 1106
-- Name: isneq(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 444 (class 1255 OID 17001)
-- Dependencies: 6 1106 1103
-- Name: isneq(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 445 (class 1255 OID 17002)
-- Dependencies: 6 1106 1065
-- Name: isneq(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 446 (class 1255 OID 17003)
-- Dependencies: 6 1103 1103
-- Name: isneq(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 447 (class 1255 OID 17004)
-- Dependencies: 6 1103 1106
-- Name: isneq(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 17005)
-- Dependencies: 6 1103 1065
-- Name: isneq(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 449 (class 1255 OID 17006)
-- Dependencies: 6 1112 1112
-- Name: isneq(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 450 (class 1255 OID 17007)
-- Dependencies: 6 1112 1109
-- Name: isneq(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 451 (class 1255 OID 17008)
-- Dependencies: 6 1112 1065
-- Name: isneq(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 452 (class 1255 OID 17009)
-- Dependencies: 6 1109 1109
-- Name: isneq(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 17010)
-- Dependencies: 6 1109 1112
-- Name: isneq(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 17011)
-- Dependencies: 6 1109 1065
-- Name: isneq(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 455 (class 1255 OID 17012)
-- Dependencies: 6 1118 1118
-- Name: isneq(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 17013)
-- Dependencies: 6 1118 1115
-- Name: isneq(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn13, issn) OWNER TO postgres;

--
-- TOC entry 457 (class 1255 OID 17014)
-- Dependencies: 6 1118 1065
-- Name: isneq(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 17015)
-- Dependencies: 6 1115 1115
-- Name: isneq(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn, issn) OWNER TO postgres;

--
-- TOC entry 459 (class 1255 OID 17016)
-- Dependencies: 6 1115 1118
-- Name: isneq(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn, issn13) OWNER TO postgres;

--
-- TOC entry 460 (class 1255 OID 17017)
-- Dependencies: 6 1115 1065
-- Name: isneq(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(issn, ean13) OWNER TO postgres;

--
-- TOC entry 461 (class 1255 OID 17018)
-- Dependencies: 6 1182 1182
-- Name: isneq(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(upc, upc) OWNER TO postgres;

--
-- TOC entry 462 (class 1255 OID 17019)
-- Dependencies: 6 1182 1065
-- Name: isneq(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isneq(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8eq$$;


ALTER FUNCTION public.isneq(upc, ean13) OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 17020)
-- Dependencies: 6 1065 1065
-- Name: isnge(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 17021)
-- Dependencies: 6 1065 1106
-- Name: isnge(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 17022)
-- Dependencies: 6 1065 1112
-- Name: isnge(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 466 (class 1255 OID 17023)
-- Dependencies: 6 1065 1118
-- Name: isnge(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 467 (class 1255 OID 17024)
-- Dependencies: 6 1065 1103
-- Name: isnge(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 468 (class 1255 OID 17025)
-- Dependencies: 6 1065 1109
-- Name: isnge(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 469 (class 1255 OID 17026)
-- Dependencies: 6 1065 1115
-- Name: isnge(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, issn) OWNER TO postgres;

--
-- TOC entry 470 (class 1255 OID 17027)
-- Dependencies: 6 1065 1182
-- Name: isnge(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ean13, upc) OWNER TO postgres;

--
-- TOC entry 471 (class 1255 OID 17028)
-- Dependencies: 6 1106 1106
-- Name: isnge(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 472 (class 1255 OID 17029)
-- Dependencies: 6 1106 1103
-- Name: isnge(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 473 (class 1255 OID 17030)
-- Dependencies: 6 1106 1065
-- Name: isnge(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 474 (class 1255 OID 17031)
-- Dependencies: 6 1103 1103
-- Name: isnge(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 17032)
-- Dependencies: 6 1103 1106
-- Name: isnge(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 476 (class 1255 OID 17033)
-- Dependencies: 6 1103 1065
-- Name: isnge(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 17034)
-- Dependencies: 6 1112 1112
-- Name: isnge(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 17035)
-- Dependencies: 6 1112 1109
-- Name: isnge(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 17036)
-- Dependencies: 6 1112 1065
-- Name: isnge(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 17037)
-- Dependencies: 6 1109 1109
-- Name: isnge(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 17038)
-- Dependencies: 6 1109 1112
-- Name: isnge(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 17039)
-- Dependencies: 6 1109 1065
-- Name: isnge(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 17040)
-- Dependencies: 6 1118 1118
-- Name: isnge(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 17041)
-- Dependencies: 6 1118 1115
-- Name: isnge(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn13, issn) OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 17042)
-- Dependencies: 6 1118 1065
-- Name: isnge(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 17043)
-- Dependencies: 6 1115 1115
-- Name: isnge(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn, issn) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 17044)
-- Dependencies: 6 1115 1118
-- Name: isnge(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn, issn13) OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 17045)
-- Dependencies: 6 1115 1065
-- Name: isnge(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(issn, ean13) OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 17046)
-- Dependencies: 6 1182 1182
-- Name: isnge(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(upc, upc) OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 17047)
-- Dependencies: 6 1182 1065
-- Name: isnge(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnge(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ge$$;


ALTER FUNCTION public.isnge(upc, ean13) OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 17048)
-- Dependencies: 6 1065 1065
-- Name: isngt(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 17049)
-- Dependencies: 6 1065 1106
-- Name: isngt(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 17050)
-- Dependencies: 6 1065 1112
-- Name: isngt(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 494 (class 1255 OID 17051)
-- Dependencies: 6 1065 1118
-- Name: isngt(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 495 (class 1255 OID 17052)
-- Dependencies: 6 1065 1103
-- Name: isngt(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 17053)
-- Dependencies: 6 1065 1109
-- Name: isngt(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 497 (class 1255 OID 17054)
-- Dependencies: 6 1065 1115
-- Name: isngt(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, issn) OWNER TO postgres;

--
-- TOC entry 498 (class 1255 OID 17055)
-- Dependencies: 6 1065 1182
-- Name: isngt(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ean13, upc) OWNER TO postgres;

--
-- TOC entry 499 (class 1255 OID 17056)
-- Dependencies: 6 1106 1106
-- Name: isngt(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 17057)
-- Dependencies: 6 1106 1103
-- Name: isngt(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 501 (class 1255 OID 17058)
-- Dependencies: 6 1106 1065
-- Name: isngt(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 502 (class 1255 OID 17059)
-- Dependencies: 6 1103 1103
-- Name: isngt(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 503 (class 1255 OID 17060)
-- Dependencies: 6 1103 1106
-- Name: isngt(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 504 (class 1255 OID 17061)
-- Dependencies: 6 1103 1065
-- Name: isngt(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 505 (class 1255 OID 17062)
-- Dependencies: 6 1112 1112
-- Name: isngt(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 506 (class 1255 OID 17063)
-- Dependencies: 6 1112 1109
-- Name: isngt(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 507 (class 1255 OID 17064)
-- Dependencies: 6 1112 1065
-- Name: isngt(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 508 (class 1255 OID 17065)
-- Dependencies: 6 1109 1109
-- Name: isngt(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 509 (class 1255 OID 17066)
-- Dependencies: 6 1109 1112
-- Name: isngt(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 510 (class 1255 OID 17067)
-- Dependencies: 6 1109 1065
-- Name: isngt(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 511 (class 1255 OID 17068)
-- Dependencies: 6 1118 1118
-- Name: isngt(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 512 (class 1255 OID 17069)
-- Dependencies: 6 1118 1115
-- Name: isngt(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn13, issn) OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 17070)
-- Dependencies: 6 1118 1065
-- Name: isngt(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 514 (class 1255 OID 17071)
-- Dependencies: 6 1115 1115
-- Name: isngt(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn, issn) OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 17072)
-- Dependencies: 6 1115 1118
-- Name: isngt(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn, issn13) OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 17073)
-- Dependencies: 6 1115 1065
-- Name: isngt(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(issn, ean13) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 17074)
-- Dependencies: 6 1182 1182
-- Name: isngt(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(upc, upc) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 17075)
-- Dependencies: 6 1182 1065
-- Name: isngt(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isngt(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8gt$$;


ALTER FUNCTION public.isngt(upc, ean13) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 17076)
-- Dependencies: 6 1065 1065
-- Name: isnle(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 17077)
-- Dependencies: 6 1065 1106
-- Name: isnle(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 17078)
-- Dependencies: 6 1065 1112
-- Name: isnle(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 522 (class 1255 OID 17079)
-- Dependencies: 6 1065 1118
-- Name: isnle(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 17080)
-- Dependencies: 6 1065 1103
-- Name: isnle(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 524 (class 1255 OID 17081)
-- Dependencies: 6 1065 1109
-- Name: isnle(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 525 (class 1255 OID 17082)
-- Dependencies: 6 1065 1115
-- Name: isnle(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, issn) OWNER TO postgres;

--
-- TOC entry 526 (class 1255 OID 17083)
-- Dependencies: 6 1065 1182
-- Name: isnle(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ean13, upc) OWNER TO postgres;

--
-- TOC entry 527 (class 1255 OID 17084)
-- Dependencies: 6 1106 1106
-- Name: isnle(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 528 (class 1255 OID 17085)
-- Dependencies: 6 1106 1103
-- Name: isnle(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 529 (class 1255 OID 17086)
-- Dependencies: 6 1106 1065
-- Name: isnle(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 530 (class 1255 OID 17087)
-- Dependencies: 6 1103 1103
-- Name: isnle(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 531 (class 1255 OID 17088)
-- Dependencies: 6 1103 1106
-- Name: isnle(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 532 (class 1255 OID 17089)
-- Dependencies: 6 1103 1065
-- Name: isnle(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 533 (class 1255 OID 17090)
-- Dependencies: 6 1112 1112
-- Name: isnle(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 534 (class 1255 OID 17091)
-- Dependencies: 6 1112 1109
-- Name: isnle(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 535 (class 1255 OID 17092)
-- Dependencies: 6 1112 1065
-- Name: isnle(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 17093)
-- Dependencies: 6 1109 1109
-- Name: isnle(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 537 (class 1255 OID 17094)
-- Dependencies: 6 1109 1112
-- Name: isnle(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 538 (class 1255 OID 17095)
-- Dependencies: 6 1109 1065
-- Name: isnle(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 539 (class 1255 OID 17096)
-- Dependencies: 6 1118 1118
-- Name: isnle(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 540 (class 1255 OID 17097)
-- Dependencies: 6 1118 1115
-- Name: isnle(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn13, issn) OWNER TO postgres;

--
-- TOC entry 541 (class 1255 OID 17098)
-- Dependencies: 6 1118 1065
-- Name: isnle(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 542 (class 1255 OID 17099)
-- Dependencies: 6 1115 1115
-- Name: isnle(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn, issn) OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 17100)
-- Dependencies: 6 1115 1118
-- Name: isnle(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn, issn13) OWNER TO postgres;

--
-- TOC entry 544 (class 1255 OID 17101)
-- Dependencies: 6 1115 1065
-- Name: isnle(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(issn, ean13) OWNER TO postgres;

--
-- TOC entry 545 (class 1255 OID 17102)
-- Dependencies: 6 1182 1182
-- Name: isnle(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(upc, upc) OWNER TO postgres;

--
-- TOC entry 546 (class 1255 OID 17103)
-- Dependencies: 6 1182 1065
-- Name: isnle(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnle(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8le$$;


ALTER FUNCTION public.isnle(upc, ean13) OWNER TO postgres;

--
-- TOC entry 547 (class 1255 OID 17104)
-- Dependencies: 6 1065 1065
-- Name: isnlt(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 548 (class 1255 OID 17105)
-- Dependencies: 6 1065 1106
-- Name: isnlt(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 549 (class 1255 OID 17106)
-- Dependencies: 6 1065 1112
-- Name: isnlt(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 550 (class 1255 OID 17107)
-- Dependencies: 6 1065 1118
-- Name: isnlt(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 551 (class 1255 OID 17108)
-- Dependencies: 6 1065 1103
-- Name: isnlt(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 552 (class 1255 OID 17109)
-- Dependencies: 6 1065 1109
-- Name: isnlt(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 553 (class 1255 OID 17110)
-- Dependencies: 6 1065 1115
-- Name: isnlt(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, issn) OWNER TO postgres;

--
-- TOC entry 554 (class 1255 OID 17111)
-- Dependencies: 6 1065 1182
-- Name: isnlt(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ean13, upc) OWNER TO postgres;

--
-- TOC entry 555 (class 1255 OID 17112)
-- Dependencies: 6 1106 1106
-- Name: isnlt(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 556 (class 1255 OID 17113)
-- Dependencies: 6 1106 1103
-- Name: isnlt(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 557 (class 1255 OID 17114)
-- Dependencies: 6 1106 1065
-- Name: isnlt(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 558 (class 1255 OID 17115)
-- Dependencies: 6 1103 1103
-- Name: isnlt(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 559 (class 1255 OID 17116)
-- Dependencies: 6 1103 1106
-- Name: isnlt(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 560 (class 1255 OID 17117)
-- Dependencies: 6 1103 1065
-- Name: isnlt(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 561 (class 1255 OID 17118)
-- Dependencies: 6 1112 1112
-- Name: isnlt(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 562 (class 1255 OID 17119)
-- Dependencies: 6 1112 1109
-- Name: isnlt(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 563 (class 1255 OID 17120)
-- Dependencies: 6 1112 1065
-- Name: isnlt(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 564 (class 1255 OID 17121)
-- Dependencies: 6 1109 1109
-- Name: isnlt(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 565 (class 1255 OID 17122)
-- Dependencies: 6 1109 1112
-- Name: isnlt(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 566 (class 1255 OID 17123)
-- Dependencies: 6 1109 1065
-- Name: isnlt(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 567 (class 1255 OID 17124)
-- Dependencies: 6 1118 1118
-- Name: isnlt(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 568 (class 1255 OID 17125)
-- Dependencies: 6 1118 1115
-- Name: isnlt(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn13, issn) OWNER TO postgres;

--
-- TOC entry 569 (class 1255 OID 17126)
-- Dependencies: 6 1118 1065
-- Name: isnlt(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 570 (class 1255 OID 17127)
-- Dependencies: 6 1115 1115
-- Name: isnlt(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn, issn) OWNER TO postgres;

--
-- TOC entry 571 (class 1255 OID 17128)
-- Dependencies: 6 1115 1118
-- Name: isnlt(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn, issn13) OWNER TO postgres;

--
-- TOC entry 572 (class 1255 OID 17129)
-- Dependencies: 6 1115 1065
-- Name: isnlt(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(issn, ean13) OWNER TO postgres;

--
-- TOC entry 573 (class 1255 OID 17130)
-- Dependencies: 6 1182 1182
-- Name: isnlt(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(upc, upc) OWNER TO postgres;

--
-- TOC entry 574 (class 1255 OID 17131)
-- Dependencies: 6 1182 1065
-- Name: isnlt(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnlt(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8lt$$;


ALTER FUNCTION public.isnlt(upc, ean13) OWNER TO postgres;

--
-- TOC entry 575 (class 1255 OID 17132)
-- Dependencies: 6 1065 1065
-- Name: isnne(ean13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, ean13) OWNER TO postgres;

--
-- TOC entry 576 (class 1255 OID 17133)
-- Dependencies: 6 1065 1106
-- Name: isnne(ean13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 577 (class 1255 OID 17134)
-- Dependencies: 6 1065 1112
-- Name: isnne(ean13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 578 (class 1255 OID 17135)
-- Dependencies: 6 1065 1118
-- Name: isnne(ean13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, issn13) OWNER TO postgres;

--
-- TOC entry 579 (class 1255 OID 17136)
-- Dependencies: 6 1065 1103
-- Name: isnne(ean13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, isbn) OWNER TO postgres;

--
-- TOC entry 580 (class 1255 OID 17137)
-- Dependencies: 6 1065 1109
-- Name: isnne(ean13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, ismn) OWNER TO postgres;

--
-- TOC entry 581 (class 1255 OID 17138)
-- Dependencies: 6 1065 1115
-- Name: isnne(ean13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, issn) OWNER TO postgres;

--
-- TOC entry 582 (class 1255 OID 17139)
-- Dependencies: 6 1065 1182
-- Name: isnne(ean13, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ean13, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ean13, upc) OWNER TO postgres;

--
-- TOC entry 583 (class 1255 OID 17140)
-- Dependencies: 6 1106 1106
-- Name: isnne(isbn13, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn13, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 584 (class 1255 OID 17141)
-- Dependencies: 6 1106 1103
-- Name: isnne(isbn13, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn13, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 585 (class 1255 OID 17142)
-- Dependencies: 6 1106 1065
-- Name: isnne(isbn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 586 (class 1255 OID 17143)
-- Dependencies: 6 1103 1103
-- Name: isnne(isbn, isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn, isbn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn, isbn) OWNER TO postgres;

--
-- TOC entry 587 (class 1255 OID 17144)
-- Dependencies: 6 1103 1106
-- Name: isnne(isbn, isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn, isbn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 588 (class 1255 OID 17145)
-- Dependencies: 6 1103 1065
-- Name: isnne(isbn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(isbn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(isbn, ean13) OWNER TO postgres;

--
-- TOC entry 589 (class 1255 OID 17146)
-- Dependencies: 6 1112 1112
-- Name: isnne(ismn13, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn13, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 590 (class 1255 OID 17147)
-- Dependencies: 6 1112 1109
-- Name: isnne(ismn13, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn13, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 591 (class 1255 OID 17148)
-- Dependencies: 6 1112 1065
-- Name: isnne(ismn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 592 (class 1255 OID 17149)
-- Dependencies: 6 1109 1109
-- Name: isnne(ismn, ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn, ismn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn, ismn) OWNER TO postgres;

--
-- TOC entry 593 (class 1255 OID 17150)
-- Dependencies: 6 1109 1112
-- Name: isnne(ismn, ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn, ismn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 594 (class 1255 OID 17151)
-- Dependencies: 6 1109 1065
-- Name: isnne(ismn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(ismn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(ismn, ean13) OWNER TO postgres;

--
-- TOC entry 595 (class 1255 OID 17152)
-- Dependencies: 6 1118 1118
-- Name: isnne(issn13, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn13, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn13, issn13) OWNER TO postgres;

--
-- TOC entry 596 (class 1255 OID 17153)
-- Dependencies: 6 1118 1115
-- Name: isnne(issn13, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn13, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn13, issn) OWNER TO postgres;

--
-- TOC entry 597 (class 1255 OID 17154)
-- Dependencies: 6 1118 1065
-- Name: isnne(issn13, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn13, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn13, ean13) OWNER TO postgres;

--
-- TOC entry 598 (class 1255 OID 17155)
-- Dependencies: 6 1115 1115
-- Name: isnne(issn, issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn, issn) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn, issn) OWNER TO postgres;

--
-- TOC entry 599 (class 1255 OID 17156)
-- Dependencies: 6 1115 1118
-- Name: isnne(issn, issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn, issn13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn, issn13) OWNER TO postgres;

--
-- TOC entry 600 (class 1255 OID 17157)
-- Dependencies: 6 1115 1065
-- Name: isnne(issn, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(issn, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(issn, ean13) OWNER TO postgres;

--
-- TOC entry 601 (class 1255 OID 17158)
-- Dependencies: 6 1182 1182
-- Name: isnne(upc, upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(upc, upc) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(upc, upc) OWNER TO postgres;

--
-- TOC entry 602 (class 1255 OID 17159)
-- Dependencies: 6 1182 1065
-- Name: isnne(upc, ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION isnne(upc, ean13) RETURNS boolean
    LANGUAGE internal IMMUTABLE STRICT
    AS $$int8ne$$;


ALTER FUNCTION public.isnne(upc, ean13) OWNER TO postgres;

--
-- TOC entry 603 (class 1255 OID 17160)
-- Dependencies: 6 1115 1065
-- Name: issn(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn(ean13) RETURNS issn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_cast_from_ean13';


ALTER FUNCTION public.issn(ean13) OWNER TO postgres;

--
-- TOC entry 604 (class 1255 OID 17161)
-- Dependencies: 6 1118 1065
-- Name: issn13(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION issn13(ean13) RETURNS issn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'issn_cast_from_ean13';


ALTER FUNCTION public.issn13(ean13) OWNER TO postgres;

--
-- TOC entry 605 (class 1255 OID 17162)
-- Dependencies: 6 1187
-- Name: latitude(earth); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION latitude(earth) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN cube_ll_coord($1, 3)/earth() < -1 THEN -90::float8 WHEN cube_ll_coord($1, 3)/earth() > 1 THEN 90::float8 ELSE degrees(asin(cube_ll_coord($1, 3)/earth())) END$_$;


ALTER FUNCTION public.latitude(earth) OWNER TO postgres;

--
-- TOC entry 606 (class 1255 OID 17163)
-- Dependencies: 6 1127 1129
-- Name: lca(ltree[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree[]) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', '_lca';


ALTER FUNCTION public.lca(ltree[]) OWNER TO postgres;

--
-- TOC entry 607 (class 1255 OID 17164)
-- Dependencies: 6 1127 1127 1127
-- Name: lca(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 608 (class 1255 OID 17165)
-- Dependencies: 6 1127 1127 1127 1127
-- Name: lca(ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 609 (class 1255 OID 17166)
-- Dependencies: 1127 6 1127 1127 1127 1127
-- Name: lca(ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 610 (class 1255 OID 17167)
-- Dependencies: 1127 6 1127 1127 1127 1127 1127
-- Name: lca(ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 611 (class 1255 OID 17168)
-- Dependencies: 1127 1127 1127 1127 1127 6 1127 1127
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 612 (class 1255 OID 17169)
-- Dependencies: 1127 1127 1127 1127 1127 1127 1127 6 1127
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 613 (class 1255 OID 17170)
-- Dependencies: 1127 1127 1127 1127 1127 6 1127 1127 1127 1127
-- Name: lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lca';


ALTER FUNCTION public.lca(ltree, ltree, ltree, ltree, ltree, ltree, ltree, ltree) OWNER TO postgres;

--
-- TOC entry 614 (class 1255 OID 17171)
-- Dependencies: 6
-- Name: levenshtein(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION levenshtein(text, text) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'levenshtein';


ALTER FUNCTION public.levenshtein(text, text) OWNER TO postgres;

--
-- TOC entry 615 (class 1255 OID 17172)
-- Dependencies: 1187 6
-- Name: ll_to_earth(double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ll_to_earth(double precision, double precision) RETURNS earth
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT cube(cube(cube(earth()*cos(radians($1))*cos(radians($2))),earth()*cos(radians($1))*sin(radians($2))),earth()*sin(radians($1)))::earth$_$;


ALTER FUNCTION public.ll_to_earth(double precision, double precision) OWNER TO postgres;

--
-- TOC entry 616 (class 1255 OID 17173)
-- Dependencies: 6
-- Name: lo_manage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lo_manage() RETURNS trigger
    LANGUAGE c
    AS '$libdir/lo', 'lo_manage';


ALTER FUNCTION public.lo_manage() OWNER TO postgres;

--
-- TOC entry 617 (class 1255 OID 17174)
-- Dependencies: 6 1191
-- Name: lo_oid(lo); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lo_oid(lo) RETURNS oid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT $1::pg_catalog.oid$_$;


ALTER FUNCTION public.lo_oid(lo) OWNER TO postgres;

--
-- TOC entry 618 (class 1255 OID 17175)
-- Dependencies: 1187 6
-- Name: longitude(earth); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION longitude(earth) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT degrees(atan2(cube_ll_coord($1, 2), cube_ll_coord($1, 1)))$_$;


ALTER FUNCTION public.longitude(earth) OWNER TO postgres;

--
-- TOC entry 619 (class 1255 OID 17176)
-- Dependencies: 6 1126 1127
-- Name: lt_q_regex(ltree, lquery[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lt_q_regex(ltree, lquery[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lt_q_regex';


ALTER FUNCTION public.lt_q_regex(ltree, lquery[]) OWNER TO postgres;

--
-- TOC entry 620 (class 1255 OID 17177)
-- Dependencies: 1126 6 1127
-- Name: lt_q_rregex(lquery[], ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lt_q_rregex(lquery[], ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'lt_q_rregex';


ALTER FUNCTION public.lt_q_rregex(lquery[], ltree) OWNER TO postgres;

--
-- TOC entry 621 (class 1255 OID 17178)
-- Dependencies: 6 1127 1124
-- Name: ltq_regex(ltree, lquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltq_regex(ltree, lquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltq_regex';


ALTER FUNCTION public.ltq_regex(ltree, lquery) OWNER TO postgres;

--
-- TOC entry 622 (class 1255 OID 17179)
-- Dependencies: 1127 6 1124
-- Name: ltq_rregex(lquery, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltq_rregex(lquery, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltq_rregex';


ALTER FUNCTION public.ltq_rregex(lquery, ltree) OWNER TO postgres;

--
-- TOC entry 623 (class 1255 OID 17180)
-- Dependencies: 1127 6
-- Name: ltree2text(ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree2text(ltree) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree2text';


ALTER FUNCTION public.ltree2text(ltree) OWNER TO postgres;

--
-- TOC entry 624 (class 1255 OID 17181)
-- Dependencies: 6 1127 1127 1127
-- Name: ltree_addltree(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_addltree(ltree, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_addltree';


ALTER FUNCTION public.ltree_addltree(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 625 (class 1255 OID 17182)
-- Dependencies: 1127 1127 6
-- Name: ltree_addtext(ltree, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_addtext(ltree, text) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_addtext';


ALTER FUNCTION public.ltree_addtext(ltree, text) OWNER TO postgres;

--
-- TOC entry 626 (class 1255 OID 17183)
-- Dependencies: 1127 6 1127
-- Name: ltree_cmp(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_cmp(ltree, ltree) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_cmp';


ALTER FUNCTION public.ltree_cmp(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 627 (class 1255 OID 17184)
-- Dependencies: 6
-- Name: ltree_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_compress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_compress';


ALTER FUNCTION public.ltree_compress(internal) OWNER TO postgres;

--
-- TOC entry 628 (class 1255 OID 17185)
-- Dependencies: 6
-- Name: ltree_consistent(internal, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_consistent(internal, internal, smallint) RETURNS boolean
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_consistent';


ALTER FUNCTION public.ltree_consistent(internal, internal, smallint) OWNER TO postgres;

--
-- TOC entry 629 (class 1255 OID 17186)
-- Dependencies: 6
-- Name: ltree_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_decompress(internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_decompress';


ALTER FUNCTION public.ltree_decompress(internal) OWNER TO postgres;

--
-- TOC entry 630 (class 1255 OID 17187)
-- Dependencies: 1127 1127 6
-- Name: ltree_eq(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_eq(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_eq';


ALTER FUNCTION public.ltree_eq(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 631 (class 1255 OID 17188)
-- Dependencies: 1127 6 1127
-- Name: ltree_ge(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_ge(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_ge';


ALTER FUNCTION public.ltree_ge(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 632 (class 1255 OID 17189)
-- Dependencies: 1127 6 1127
-- Name: ltree_gt(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_gt(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_gt';


ALTER FUNCTION public.ltree_gt(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 633 (class 1255 OID 17190)
-- Dependencies: 6 1127 1127
-- Name: ltree_isparent(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_isparent(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_isparent';


ALTER FUNCTION public.ltree_isparent(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 634 (class 1255 OID 17191)
-- Dependencies: 1127 1127 6
-- Name: ltree_le(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_le(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_le';


ALTER FUNCTION public.ltree_le(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 635 (class 1255 OID 17192)
-- Dependencies: 1127 6 1127
-- Name: ltree_lt(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_lt(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_lt';


ALTER FUNCTION public.ltree_lt(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 636 (class 1255 OID 17193)
-- Dependencies: 1127 6 1127
-- Name: ltree_ne(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_ne(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_ne';


ALTER FUNCTION public.ltree_ne(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 637 (class 1255 OID 17194)
-- Dependencies: 6
-- Name: ltree_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_penalty';


ALTER FUNCTION public.ltree_penalty(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 638 (class 1255 OID 17195)
-- Dependencies: 6
-- Name: ltree_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_picksplit(internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_picksplit';


ALTER FUNCTION public.ltree_picksplit(internal, internal) OWNER TO postgres;

--
-- TOC entry 639 (class 1255 OID 17196)
-- Dependencies: 6 1127 1127
-- Name: ltree_risparent(ltree, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_risparent(ltree, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_risparent';


ALTER FUNCTION public.ltree_risparent(ltree, ltree) OWNER TO postgres;

--
-- TOC entry 640 (class 1255 OID 17197)
-- Dependencies: 6
-- Name: ltree_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_same(internal, internal, internal) RETURNS internal
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_same';


ALTER FUNCTION public.ltree_same(internal, internal, internal) OWNER TO postgres;

--
-- TOC entry 641 (class 1255 OID 17198)
-- Dependencies: 6 1127 1127
-- Name: ltree_textadd(text, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_textadd(text, ltree) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltree_textadd';


ALTER FUNCTION public.ltree_textadd(text, ltree) OWNER TO postgres;

--
-- TOC entry 642 (class 1255 OID 17199)
-- Dependencies: 6
-- Name: ltree_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltree_union(internal, internal) RETURNS integer
    LANGUAGE c IMMUTABLE
    AS '$libdir/ltree', 'ltree_union';


ALTER FUNCTION public.ltree_union(internal, internal) OWNER TO postgres;

--
-- TOC entry 643 (class 1255 OID 17200)
-- Dependencies: 6
-- Name: ltreeparentsel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltreeparentsel(internal, oid, internal, integer) RETURNS double precision
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltreeparentsel';


ALTER FUNCTION public.ltreeparentsel(internal, oid, internal, integer) OWNER TO postgres;

--
-- TOC entry 644 (class 1255 OID 17201)
-- Dependencies: 6 1127 1133
-- Name: ltxtq_exec(ltree, ltxtquery); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_exec(ltree, ltxtquery) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltxtq_exec';


ALTER FUNCTION public.ltxtq_exec(ltree, ltxtquery) OWNER TO postgres;

--
-- TOC entry 645 (class 1255 OID 17202)
-- Dependencies: 6 1133 1127
-- Name: ltxtq_rexec(ltxtquery, ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ltxtq_rexec(ltxtquery, ltree) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'ltxtq_rexec';


ALTER FUNCTION public.ltxtq_rexec(ltxtquery, ltree) OWNER TO postgres;

--
-- TOC entry 646 (class 1255 OID 17203)
-- Dependencies: 1065 6 1065
-- Name: make_valid(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(ean13) RETURNS ean13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(ean13) OWNER TO postgres;

--
-- TOC entry 647 (class 1255 OID 17204)
-- Dependencies: 6 1106 1106
-- Name: make_valid(isbn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(isbn13) RETURNS isbn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(isbn13) OWNER TO postgres;

--
-- TOC entry 648 (class 1255 OID 17205)
-- Dependencies: 6 1112 1112
-- Name: make_valid(ismn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(ismn13) RETURNS ismn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(ismn13) OWNER TO postgres;

--
-- TOC entry 649 (class 1255 OID 17206)
-- Dependencies: 6 1118 1118
-- Name: make_valid(issn13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(issn13) RETURNS issn13
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(issn13) OWNER TO postgres;

--
-- TOC entry 650 (class 1255 OID 17207)
-- Dependencies: 6 1103 1103
-- Name: make_valid(isbn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(isbn) RETURNS isbn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(isbn) OWNER TO postgres;

--
-- TOC entry 651 (class 1255 OID 17208)
-- Dependencies: 6 1109 1109
-- Name: make_valid(ismn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(ismn) RETURNS ismn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(ismn) OWNER TO postgres;

--
-- TOC entry 652 (class 1255 OID 17209)
-- Dependencies: 6 1115 1115
-- Name: make_valid(issn); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(issn) RETURNS issn
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(issn) OWNER TO postgres;

--
-- TOC entry 653 (class 1255 OID 17210)
-- Dependencies: 6 1182 1182
-- Name: make_valid(upc); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION make_valid(upc) RETURNS upc
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'make_valid';


ALTER FUNCTION public.make_valid(upc) OWNER TO postgres;

--
-- TOC entry 654 (class 1255 OID 17211)
-- Dependencies: 6
-- Name: metaphone(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION metaphone(text, integer) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'metaphone';


ALTER FUNCTION public.metaphone(text, integer) OWNER TO postgres;

--
-- TOC entry 655 (class 1255 OID 17212)
-- Dependencies: 6
-- Name: moddatetime(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION moddatetime() RETURNS trigger
    LANGUAGE c
    AS '$libdir/moddatetime', 'moddatetime';


ALTER FUNCTION public.moddatetime() OWNER TO postgres;

--
-- TOC entry 656 (class 1255 OID 17213)
-- Dependencies: 6 1054
-- Name: ne(chkpass, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ne(chkpass, text) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_ne';


ALTER FUNCTION public.ne(chkpass, text) OWNER TO postgres;

--
-- TOC entry 657 (class 1255 OID 17214)
-- Dependencies: 6 1127
-- Name: nlevel(ltree); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nlevel(ltree) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'nlevel';


ALTER FUNCTION public.nlevel(ltree) OWNER TO postgres;

--
-- TOC entry 658 (class 1255 OID 17215)
-- Dependencies: 6
-- Name: normal_rand(integer, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION normal_rand(integer, double precision, double precision) RETURNS SETOF double precision
    LANGUAGE c STRICT
    AS '$libdir/tablefunc', 'normal_rand';


ALTER FUNCTION public.normal_rand(integer, double precision, double precision) OWNER TO postgres;

--
-- TOC entry 659 (class 1255 OID 17216)
-- Dependencies: 6
-- Name: page_header(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION page_header(page bytea, OUT lsn text, OUT tli smallint, OUT flags smallint, OUT lower smallint, OUT upper smallint, OUT special smallint, OUT pagesize smallint, OUT version smallint, OUT prune_xid xid) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pageinspect', 'page_header';


ALTER FUNCTION public.page_header(page bytea, OUT lsn text, OUT tli smallint, OUT flags smallint, OUT lower smallint, OUT upper smallint, OUT special smallint, OUT pagesize smallint, OUT version smallint, OUT prune_xid xid) OWNER TO postgres;

--
-- TOC entry 764 (class 1255 OID 16525)
-- Dependencies: 6
-- Name: pg_buffercache_pages(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pg_buffercache_pages() RETURNS SETOF record
    LANGUAGE c
    AS '$libdir/pg_buffercache', 'pg_buffercache_pages';


ALTER FUNCTION public.pg_buffercache_pages() OWNER TO postgres;

--
-- TOC entry 660 (class 1255 OID 17217)
-- Dependencies: 6
-- Name: pg_relpages(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pg_relpages(text) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pg_relpages';


ALTER FUNCTION public.pg_relpages(text) OWNER TO postgres;

--
-- TOC entry 661 (class 1255 OID 17218)
-- Dependencies: 6
-- Name: pgp_key_id(bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_key_id(bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_key_id_w';


ALTER FUNCTION public.pgp_key_id(bytea) OWNER TO postgres;

--
-- TOC entry 662 (class 1255 OID 17219)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea) OWNER TO postgres;

--
-- TOC entry 663 (class 1255 OID 17220)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 664 (class 1255 OID 17221)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) OWNER TO postgres;

--
-- TOC entry 665 (class 1255 OID 17222)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) OWNER TO postgres;

--
-- TOC entry 666 (class 1255 OID 17223)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 667 (class 1255 OID 17224)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) OWNER TO postgres;

--
-- TOC entry 668 (class 1255 OID 17225)
-- Dependencies: 6
-- Name: pgp_pub_encrypt(text, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text';


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea) OWNER TO postgres;

--
-- TOC entry 669 (class 1255 OID 17226)
-- Dependencies: 6
-- Name: pgp_pub_encrypt(text, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text';


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea, text) OWNER TO postgres;

--
-- TOC entry 670 (class 1255 OID 17227)
-- Dependencies: 6
-- Name: pgp_pub_encrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea';


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) OWNER TO postgres;

--
-- TOC entry 671 (class 1255 OID 17228)
-- Dependencies: 6
-- Name: pgp_pub_encrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea';


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) OWNER TO postgres;

--
-- TOC entry 672 (class 1255 OID 17229)
-- Dependencies: 6
-- Name: pgp_sym_decrypt(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text';


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text) OWNER TO postgres;

--
-- TOC entry 673 (class 1255 OID 17230)
-- Dependencies: 6
-- Name: pgp_sym_decrypt(bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text';


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text, text) OWNER TO postgres;

--
-- TOC entry 674 (class 1255 OID 17231)
-- Dependencies: 6
-- Name: pgp_sym_decrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea';


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) OWNER TO postgres;

--
-- TOC entry 675 (class 1255 OID 17232)
-- Dependencies: 6
-- Name: pgp_sym_decrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea';


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) OWNER TO postgres;

--
-- TOC entry 676 (class 1255 OID 17233)
-- Dependencies: 6
-- Name: pgp_sym_encrypt(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt(text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text';


ALTER FUNCTION public.pgp_sym_encrypt(text, text) OWNER TO postgres;

--
-- TOC entry 677 (class 1255 OID 17234)
-- Dependencies: 6
-- Name: pgp_sym_encrypt(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt(text, text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text';


ALTER FUNCTION public.pgp_sym_encrypt(text, text, text) OWNER TO postgres;

--
-- TOC entry 678 (class 1255 OID 17235)
-- Dependencies: 6
-- Name: pgp_sym_encrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea';


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) OWNER TO postgres;

--
-- TOC entry 679 (class 1255 OID 17236)
-- Dependencies: 6
-- Name: pgp_sym_encrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea';


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) OWNER TO postgres;

--
-- TOC entry 680 (class 1255 OID 17237)
-- Dependencies: 6
-- Name: pgstatindex(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgstatindex(relname text, OUT version integer, OUT tree_level integer, OUT index_size integer, OUT root_block_no integer, OUT internal_pages integer, OUT leaf_pages integer, OUT empty_pages integer, OUT deleted_pages integer, OUT avg_leaf_density double precision, OUT leaf_fragmentation double precision) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pgstatindex';


ALTER FUNCTION public.pgstatindex(relname text, OUT version integer, OUT tree_level integer, OUT index_size integer, OUT root_block_no integer, OUT internal_pages integer, OUT leaf_pages integer, OUT empty_pages integer, OUT deleted_pages integer, OUT avg_leaf_density double precision, OUT leaf_fragmentation double precision) OWNER TO postgres;

--
-- TOC entry 681 (class 1255 OID 17238)
-- Dependencies: 6
-- Name: pgstattuple(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgstattuple(relname text, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pgstattuple';


ALTER FUNCTION public.pgstattuple(relname text, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) OWNER TO postgres;

--
-- TOC entry 682 (class 1255 OID 17239)
-- Dependencies: 6
-- Name: pgstattuple(oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pgstattuple(reloid oid, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) RETURNS record
    LANGUAGE c STRICT
    AS '$libdir/pgstattuple', 'pgstattuplebyid';


ALTER FUNCTION public.pgstattuple(reloid oid, OUT table_len bigint, OUT tuple_count bigint, OUT tuple_len bigint, OUT tuple_percent double precision, OUT dead_tuple_count bigint, OUT dead_tuple_len bigint, OUT dead_tuple_percent double precision, OUT free_space bigint, OUT free_percent double precision) OWNER TO postgres;

--
-- TOC entry 683 (class 1255 OID 17250)
-- Dependencies: 6 1155
-- Name: pldbg_get_target_info(text, "char"); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION pldbg_get_target_info(signature text, targettype "char") RETURNS targetinfo
    LANGUAGE c STRICT
    AS '$libdir/targetinfo', 'pldbg_get_target_info';


ALTER FUNCTION public.pldbg_get_target_info(signature text, targettype "char") OWNER TO postgres;

--
-- TOC entry 684 (class 1255 OID 17259)
-- Dependencies: 6
-- Name: plpgsql_oid_debug(oid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plpgsql_oid_debug(functionoid oid) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/plugins/plugin_debugger', 'plpgsql_oid_debug';


ALTER FUNCTION public.plpgsql_oid_debug(functionoid oid) OWNER TO postgres;

--
-- TOC entry 685 (class 1255 OID 17260)
-- Dependencies: 6 1140
-- Name: querytree(query_int); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION querytree(query_int) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'querytree';


ALTER FUNCTION public.querytree(query_int) OWNER TO postgres;

--
-- TOC entry 686 (class 1255 OID 17261)
-- Dependencies: 6 1054
-- Name: raw(chkpass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION raw(chkpass) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/chkpass', 'chkpass_rout';


ALTER FUNCTION public.raw(chkpass) OWNER TO postgres;

--
-- TOC entry 687 (class 1255 OID 17262)
-- Dependencies: 6 1140
-- Name: rboolop(query_int, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rboolop(query_int, integer[]) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'rboolop';


ALTER FUNCTION public.rboolop(query_int, integer[]) OWNER TO postgres;

--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 687
-- Name: FUNCTION rboolop(query_int, integer[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION rboolop(query_int, integer[]) IS 'boolean operation with array';


--
-- TOC entry 688 (class 1255 OID 17263)
-- Dependencies: 6
-- Name: sec_to_gc(double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sec_to_gc(double precision) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT CASE WHEN $1 < 0 THEN 0::float8 WHEN $1/(2*earth()) > 1 THEN pi()*earth() ELSE 2*earth()*asin($1/(2*earth())) END$_$;


ALTER FUNCTION public.sec_to_gc(double precision) OWNER TO postgres;

--
-- TOC entry 689 (class 1255 OID 17264)
-- Dependencies: 6 1143 1143
-- Name: seg_cmp(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_cmp(seg, seg) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_cmp';


ALTER FUNCTION public.seg_cmp(seg, seg) OWNER TO postgres;

--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 689
-- Name: FUNCTION seg_cmp(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_cmp(seg, seg) IS 'btree comparison function';


--
-- TOC entry 690 (class 1255 OID 17265)
-- Dependencies: 6 1143 1143
-- Name: seg_contained(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_contained(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_contained';


ALTER FUNCTION public.seg_contained(seg, seg) OWNER TO postgres;

--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 690
-- Name: FUNCTION seg_contained(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_contained(seg, seg) IS 'contained in';


--
-- TOC entry 691 (class 1255 OID 17266)
-- Dependencies: 6 1143 1143
-- Name: seg_contains(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_contains(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_contains';


ALTER FUNCTION public.seg_contains(seg, seg) OWNER TO postgres;

--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 691
-- Name: FUNCTION seg_contains(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_contains(seg, seg) IS 'contains';


--
-- TOC entry 692 (class 1255 OID 17267)
-- Dependencies: 6 1143 1143
-- Name: seg_different(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_different(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_different';


ALTER FUNCTION public.seg_different(seg, seg) OWNER TO postgres;

--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 692
-- Name: FUNCTION seg_different(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_different(seg, seg) IS 'different';


--
-- TOC entry 693 (class 1255 OID 17268)
-- Dependencies: 6 1143 1143
-- Name: seg_ge(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_ge(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_ge';


ALTER FUNCTION public.seg_ge(seg, seg) OWNER TO postgres;

--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 693
-- Name: FUNCTION seg_ge(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_ge(seg, seg) IS 'greater than or equal';


--
-- TOC entry 694 (class 1255 OID 17269)
-- Dependencies: 6 1143 1143
-- Name: seg_gt(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_gt(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_gt';


ALTER FUNCTION public.seg_gt(seg, seg) OWNER TO postgres;

--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 694
-- Name: FUNCTION seg_gt(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_gt(seg, seg) IS 'greater than';


--
-- TOC entry 695 (class 1255 OID 17270)
-- Dependencies: 6 1143 1143 1143
-- Name: seg_inter(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_inter(seg, seg) RETURNS seg
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_inter';


ALTER FUNCTION public.seg_inter(seg, seg) OWNER TO postgres;

--
-- TOC entry 696 (class 1255 OID 17271)
-- Dependencies: 6 1143 1143
-- Name: seg_le(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_le(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_le';


ALTER FUNCTION public.seg_le(seg, seg) OWNER TO postgres;

--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 696
-- Name: FUNCTION seg_le(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_le(seg, seg) IS 'less than or equal';


--
-- TOC entry 697 (class 1255 OID 17272)
-- Dependencies: 6 1143 1143
-- Name: seg_left(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_left(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_left';


ALTER FUNCTION public.seg_left(seg, seg) OWNER TO postgres;

--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 697
-- Name: FUNCTION seg_left(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_left(seg, seg) IS 'is left of';


--
-- TOC entry 698 (class 1255 OID 17273)
-- Dependencies: 6 1143
-- Name: seg_lower(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_lower(seg) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_lower';


ALTER FUNCTION public.seg_lower(seg) OWNER TO postgres;

--
-- TOC entry 699 (class 1255 OID 17274)
-- Dependencies: 6 1143 1143
-- Name: seg_lt(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_lt(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_lt';


ALTER FUNCTION public.seg_lt(seg, seg) OWNER TO postgres;

--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 699
-- Name: FUNCTION seg_lt(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_lt(seg, seg) IS 'less than';


--
-- TOC entry 700 (class 1255 OID 17275)
-- Dependencies: 6 1143 1143
-- Name: seg_over_left(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_over_left(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_over_left';


ALTER FUNCTION public.seg_over_left(seg, seg) OWNER TO postgres;

--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 700
-- Name: FUNCTION seg_over_left(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_over_left(seg, seg) IS 'overlaps or is left of';


--
-- TOC entry 701 (class 1255 OID 17276)
-- Dependencies: 6 1143 1143
-- Name: seg_over_right(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_over_right(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_over_right';


ALTER FUNCTION public.seg_over_right(seg, seg) OWNER TO postgres;

--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 701
-- Name: FUNCTION seg_over_right(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_over_right(seg, seg) IS 'overlaps or is right of';


--
-- TOC entry 702 (class 1255 OID 17277)
-- Dependencies: 6 1143 1143
-- Name: seg_overlap(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_overlap(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_overlap';


ALTER FUNCTION public.seg_overlap(seg, seg) OWNER TO postgres;

--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 702
-- Name: FUNCTION seg_overlap(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_overlap(seg, seg) IS 'overlaps';


--
-- TOC entry 703 (class 1255 OID 17278)
-- Dependencies: 6 1143 1143
-- Name: seg_right(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_right(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_right';


ALTER FUNCTION public.seg_right(seg, seg) OWNER TO postgres;

--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 703
-- Name: FUNCTION seg_right(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_right(seg, seg) IS 'is right of';


--
-- TOC entry 704 (class 1255 OID 17279)
-- Dependencies: 6 1143 1143
-- Name: seg_same(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_same(seg, seg) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_same';


ALTER FUNCTION public.seg_same(seg, seg) OWNER TO postgres;

--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 704
-- Name: FUNCTION seg_same(seg, seg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION seg_same(seg, seg) IS 'same as';


--
-- TOC entry 705 (class 1255 OID 17280)
-- Dependencies: 6 1143
-- Name: seg_size(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_size(seg) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_size';


ALTER FUNCTION public.seg_size(seg) OWNER TO postgres;

--
-- TOC entry 706 (class 1255 OID 17281)
-- Dependencies: 6 1143 1143 1143
-- Name: seg_union(seg, seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_union(seg, seg) RETURNS seg
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_union';


ALTER FUNCTION public.seg_union(seg, seg) OWNER TO postgres;

--
-- TOC entry 707 (class 1255 OID 17282)
-- Dependencies: 6 1143
-- Name: seg_upper(seg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION seg_upper(seg) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/seg', 'seg_upper';


ALTER FUNCTION public.seg_upper(seg) OWNER TO postgres;

--
-- TOC entry 708 (class 1255 OID 17283)
-- Dependencies: 6
-- Name: set_limit(real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_limit(real) RETURNS real
    LANGUAGE c STRICT
    AS '$libdir/pg_trgm', 'set_limit';


ALTER FUNCTION public.set_limit(real) OWNER TO postgres;

--
-- TOC entry 709 (class 1255 OID 17284)
-- Dependencies: 6
-- Name: set_timetravel(name, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_timetravel(name, integer) RETURNS integer
    LANGUAGE c STRICT
    AS '$libdir/timetravel', 'set_timetravel';


ALTER FUNCTION public.set_timetravel(name, integer) OWNER TO postgres;

--
-- TOC entry 710 (class 1255 OID 17285)
-- Dependencies: 6
-- Name: show_limit(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_limit() RETURNS real
    LANGUAGE c STABLE STRICT
    AS '$libdir/pg_trgm', 'show_limit';


ALTER FUNCTION public.show_limit() OWNER TO postgres;

--
-- TOC entry 711 (class 1255 OID 17286)
-- Dependencies: 6
-- Name: show_trgm(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION show_trgm(text) RETURNS text[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pg_trgm', 'show_trgm';


ALTER FUNCTION public.show_trgm(text) OWNER TO postgres;

--
-- TOC entry 712 (class 1255 OID 17287)
-- Dependencies: 6
-- Name: similarity(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION similarity(text, text) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pg_trgm', 'similarity';


ALTER FUNCTION public.similarity(text, text) OWNER TO postgres;

--
-- TOC entry 713 (class 1255 OID 17288)
-- Dependencies: 6
-- Name: similarity_op(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION similarity_op(text, text) RETURNS boolean
    LANGUAGE c STABLE STRICT
    AS '$libdir/pg_trgm', 'similarity_op';


ALTER FUNCTION public.similarity_op(text, text) OWNER TO postgres;

--
-- TOC entry 714 (class 1255 OID 17289)
-- Dependencies: 6 1097
-- Name: skeys(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION skeys(hstore) RETURNS SETOF text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'skeys';


ALTER FUNCTION public.skeys(hstore) OWNER TO postgres;

--
-- TOC entry 715 (class 1255 OID 17290)
-- Dependencies: 6
-- Name: sort(integer[], text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort(integer[], text) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort';


ALTER FUNCTION public.sort(integer[], text) OWNER TO postgres;

--
-- TOC entry 716 (class 1255 OID 17291)
-- Dependencies: 6
-- Name: sort(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort';


ALTER FUNCTION public.sort(integer[]) OWNER TO postgres;

--
-- TOC entry 717 (class 1255 OID 17292)
-- Dependencies: 6
-- Name: sort_asc(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort_asc(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort_asc';


ALTER FUNCTION public.sort_asc(integer[]) OWNER TO postgres;

--
-- TOC entry 718 (class 1255 OID 17293)
-- Dependencies: 6
-- Name: sort_desc(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION sort_desc(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort_desc';


ALTER FUNCTION public.sort_desc(integer[]) OWNER TO postgres;

--
-- TOC entry 719 (class 1255 OID 17294)
-- Dependencies: 6
-- Name: soundex(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION soundex(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'soundex';


ALTER FUNCTION public.soundex(text) OWNER TO postgres;

--
-- TOC entry 720 (class 1255 OID 17295)
-- Dependencies: 6
-- Name: ssl_client_cert_present(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_cert_present() RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_cert_present';


ALTER FUNCTION public.ssl_client_cert_present() OWNER TO postgres;

--
-- TOC entry 721 (class 1255 OID 17296)
-- Dependencies: 6
-- Name: ssl_client_dn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_dn() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_dn';


ALTER FUNCTION public.ssl_client_dn() OWNER TO postgres;

--
-- TOC entry 722 (class 1255 OID 17297)
-- Dependencies: 6
-- Name: ssl_client_dn_field(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_dn_field(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_dn_field';


ALTER FUNCTION public.ssl_client_dn_field(text) OWNER TO postgres;

--
-- TOC entry 723 (class 1255 OID 17298)
-- Dependencies: 6
-- Name: ssl_client_serial(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_client_serial() RETURNS numeric
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_client_serial';


ALTER FUNCTION public.ssl_client_serial() OWNER TO postgres;

--
-- TOC entry 724 (class 1255 OID 17299)
-- Dependencies: 6
-- Name: ssl_is_used(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_is_used() RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_is_used';


ALTER FUNCTION public.ssl_is_used() OWNER TO postgres;

--
-- TOC entry 725 (class 1255 OID 17300)
-- Dependencies: 6
-- Name: ssl_issuer_dn(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_issuer_dn() RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_issuer_dn';


ALTER FUNCTION public.ssl_issuer_dn() OWNER TO postgres;

--
-- TOC entry 726 (class 1255 OID 17301)
-- Dependencies: 6
-- Name: ssl_issuer_field(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ssl_issuer_field(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/sslinfo', 'ssl_issuer_field';


ALTER FUNCTION public.ssl_issuer_field(text) OWNER TO postgres;

--
-- TOC entry 727 (class 1255 OID 17302)
-- Dependencies: 6
-- Name: subarray(integer[], integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subarray(integer[], integer, integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'subarray';


ALTER FUNCTION public.subarray(integer[], integer, integer) OWNER TO postgres;

--
-- TOC entry 728 (class 1255 OID 17303)
-- Dependencies: 6
-- Name: subarray(integer[], integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subarray(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'subarray';


ALTER FUNCTION public.subarray(integer[], integer) OWNER TO postgres;

--
-- TOC entry 729 (class 1255 OID 17304)
-- Dependencies: 6 1127 1127
-- Name: subltree(ltree, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subltree(ltree, integer, integer) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'subltree';


ALTER FUNCTION public.subltree(ltree, integer, integer) OWNER TO postgres;

--
-- TOC entry 730 (class 1255 OID 17305)
-- Dependencies: 6 1127 1127
-- Name: subpath(ltree, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subpath(ltree, integer, integer) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'subpath';


ALTER FUNCTION public.subpath(ltree, integer, integer) OWNER TO postgres;

--
-- TOC entry 731 (class 1255 OID 17306)
-- Dependencies: 6 1127 1127
-- Name: subpath(ltree, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subpath(ltree, integer) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'subpath';


ALTER FUNCTION public.subpath(ltree, integer) OWNER TO postgres;

--
-- TOC entry 732 (class 1255 OID 17307)
-- Dependencies: 6 1097
-- Name: svals(hstore); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION svals(hstore) RETURNS SETOF text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/hstore', 'svals';


ALTER FUNCTION public.svals(hstore) OWNER TO postgres;

--
-- TOC entry 733 (class 1255 OID 17308)
-- Dependencies: 6 1097
-- Name: tconvert(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tconvert(text, text) RETURNS hstore
    LANGUAGE c IMMUTABLE
    AS '$libdir/hstore', 'tconvert';


ALTER FUNCTION public.tconvert(text, text) OWNER TO postgres;

--
-- TOC entry 734 (class 1255 OID 17309)
-- Dependencies: 6 1127
-- Name: text2ltree(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION text2ltree(text) RETURNS ltree
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/ltree', 'text2ltree';


ALTER FUNCTION public.text2ltree(text) OWNER TO postgres;

--
-- TOC entry 735 (class 1255 OID 17310)
-- Dependencies: 6
-- Name: text_soundex(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION text_soundex(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/fuzzystrmatch', 'soundex';


ALTER FUNCTION public.text_soundex(text) OWNER TO postgres;

--
-- TOC entry 736 (class 1255 OID 17311)
-- Dependencies: 6
-- Name: timetravel(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION timetravel() RETURNS trigger
    LANGUAGE c
    AS '$libdir/timetravel', 'timetravel';


ALTER FUNCTION public.timetravel() OWNER TO postgres;

--
-- TOC entry 737 (class 1255 OID 17312)
-- Dependencies: 6
-- Name: uniq(integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uniq(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'uniq';


ALTER FUNCTION public.uniq(integer[]) OWNER TO postgres;

--
-- TOC entry 738 (class 1255 OID 17313)
-- Dependencies: 6 1182 1065
-- Name: upc(ean13); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION upc(ean13) RETURNS upc
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/isn', 'upc_cast_from_ean13';


ALTER FUNCTION public.upc(ean13) OWNER TO postgres;

--
-- TOC entry 739 (class 1255 OID 17314)
-- Dependencies: 6
-- Name: uuid_generate_v1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v1() RETURNS uuid
    LANGUAGE c STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v1';


ALTER FUNCTION public.uuid_generate_v1() OWNER TO postgres;

--
-- TOC entry 740 (class 1255 OID 17315)
-- Dependencies: 6
-- Name: uuid_generate_v1mc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v1mc() RETURNS uuid
    LANGUAGE c STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v1mc';


ALTER FUNCTION public.uuid_generate_v1mc() OWNER TO postgres;

--
-- TOC entry 741 (class 1255 OID 17316)
-- Dependencies: 6
-- Name: uuid_generate_v3(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v3(namespace uuid, name text) RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v3';


ALTER FUNCTION public.uuid_generate_v3(namespace uuid, name text) OWNER TO postgres;

--
-- TOC entry 742 (class 1255 OID 17317)
-- Dependencies: 6
-- Name: uuid_generate_v4(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v4() RETURNS uuid
    LANGUAGE c STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v4';


ALTER FUNCTION public.uuid_generate_v4() OWNER TO postgres;

--
-- TOC entry 743 (class 1255 OID 17318)
-- Dependencies: 6
-- Name: uuid_generate_v5(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_generate_v5(namespace uuid, name text) RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_generate_v5';


ALTER FUNCTION public.uuid_generate_v5(namespace uuid, name text) OWNER TO postgres;

--
-- TOC entry 744 (class 1255 OID 17319)
-- Dependencies: 6
-- Name: uuid_nil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_nil() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_nil';


ALTER FUNCTION public.uuid_nil() OWNER TO postgres;

--
-- TOC entry 745 (class 1255 OID 17320)
-- Dependencies: 6
-- Name: uuid_ns_dns(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_dns() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_dns';


ALTER FUNCTION public.uuid_ns_dns() OWNER TO postgres;

--
-- TOC entry 746 (class 1255 OID 17321)
-- Dependencies: 6
-- Name: uuid_ns_oid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_oid() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_oid';


ALTER FUNCTION public.uuid_ns_oid() OWNER TO postgres;

--
-- TOC entry 747 (class 1255 OID 17322)
-- Dependencies: 6
-- Name: uuid_ns_url(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_url() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_url';


ALTER FUNCTION public.uuid_ns_url() OWNER TO postgres;

--
-- TOC entry 748 (class 1255 OID 17323)
-- Dependencies: 6
-- Name: uuid_ns_x500(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uuid_ns_x500() RETURNS uuid
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/uuid-ossp', 'uuid_ns_x500';


ALTER FUNCTION public.uuid_ns_x500() OWNER TO postgres;

--
-- TOC entry 749 (class 1255 OID 17324)
-- Dependencies: 6
-- Name: xml_encode_special_chars(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xml_encode_special_chars(text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xml_encode_special_chars';


ALTER FUNCTION public.xml_encode_special_chars(text) OWNER TO postgres;

--
-- TOC entry 750 (class 1255 OID 17325)
-- Dependencies: 6
-- Name: xml_is_well_formed(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xml_is_well_formed(text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xml_is_well_formed';


ALTER FUNCTION public.xml_is_well_formed(text) OWNER TO postgres;

--
-- TOC entry 751 (class 1255 OID 17326)
-- Dependencies: 6
-- Name: xml_valid(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xml_valid(text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xml_is_well_formed';


ALTER FUNCTION public.xml_valid(text) OWNER TO postgres;

--
-- TOC entry 752 (class 1255 OID 17327)
-- Dependencies: 6
-- Name: xpath_bool(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_bool(text, text) RETURNS boolean
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_bool';


ALTER FUNCTION public.xpath_bool(text, text) OWNER TO postgres;

--
-- TOC entry 753 (class 1255 OID 17328)
-- Dependencies: 6
-- Name: xpath_list(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_list(text, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_list';


ALTER FUNCTION public.xpath_list(text, text, text) OWNER TO postgres;

--
-- TOC entry 754 (class 1255 OID 17329)
-- Dependencies: 6
-- Name: xpath_list(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_list(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_list($1,$2,',')$_$;


ALTER FUNCTION public.xpath_list(text, text) OWNER TO postgres;

--
-- TOC entry 755 (class 1255 OID 17330)
-- Dependencies: 6
-- Name: xpath_nodeset(text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_nodeset(text, text, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_nodeset';


ALTER FUNCTION public.xpath_nodeset(text, text, text, text) OWNER TO postgres;

--
-- TOC entry 756 (class 1255 OID 17331)
-- Dependencies: 6
-- Name: xpath_nodeset(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_nodeset(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_nodeset($1,$2,'','')$_$;


ALTER FUNCTION public.xpath_nodeset(text, text) OWNER TO postgres;

--
-- TOC entry 757 (class 1255 OID 17332)
-- Dependencies: 6
-- Name: xpath_nodeset(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_nodeset(text, text, text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT xpath_nodeset($1,$2,'',$3)$_$;


ALTER FUNCTION public.xpath_nodeset(text, text, text) OWNER TO postgres;

--
-- TOC entry 758 (class 1255 OID 17333)
-- Dependencies: 6
-- Name: xpath_number(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_number(text, text) RETURNS real
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_number';


ALTER FUNCTION public.xpath_number(text, text) OWNER TO postgres;

--
-- TOC entry 759 (class 1255 OID 17334)
-- Dependencies: 6
-- Name: xpath_string(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_string(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xpath_string';


ALTER FUNCTION public.xpath_string(text, text) OWNER TO postgres;

--
-- TOC entry 760 (class 1255 OID 17335)
-- Dependencies: 6
-- Name: xpath_table(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xpath_table(text, text, text, text, text) RETURNS SETOF record
    LANGUAGE c STABLE STRICT
    AS '$libdir/pgxml', 'xpath_table';


ALTER FUNCTION public.xpath_table(text, text, text, text, text) OWNER TO postgres;

--
-- TOC entry 761 (class 1255 OID 17336)
-- Dependencies: 6
-- Name: xslt_process(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xslt_process(text, text, text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgxml', 'xslt_process';


ALTER FUNCTION public.xslt_process(text, text, text) OWNER TO postgres;

--
-- TOC entry 762 (class 1255 OID 17337)
-- Dependencies: 6
-- Name: xslt_process(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION xslt_process(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgxml', 'xslt_process';


ALTER FUNCTION public.xslt_process(text, text) OWNER TO postgres;

--
-- TOC entry 1911 (class 2617 OID 17338)
-- Dependencies: 6 408
-- Name: #; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR # (
    PROCEDURE = icount,
    RIGHTARG = integer[]
);


ALTER OPERATOR public.# (NONE, integer[]) OWNER TO postgres;

--
-- TOC entry 1912 (class 2617 OID 17339)
-- Dependencies: 409 6
-- Name: #; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR # (
    PROCEDURE = idx,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.# (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1913 (class 2617 OID 17340)
-- Dependencies: 6 713
-- Name: %; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR % (
    PROCEDURE = similarity_op,
    LEFTARG = text,
    RIGHTARG = text,
    COMMUTATOR = %,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.% (text, text) OWNER TO postgres;

--
-- TOC entry 1914 (class 2617 OID 17341)
-- Dependencies: 6 76
-- Name: &; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR & (
    PROCEDURE = _int_inter,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &
);


ALTER OPERATOR public.& (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1915 (class 2617 OID 17342)
-- Dependencies: 167 6 1060 1060
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = cube_overlap,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = &&,
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (cube, cube) OWNER TO postgres;

--
-- TOC entry 1916 (class 2617 OID 17343)
-- Dependencies: 6 77
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = _int_overlap,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.&& (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1917 (class 2617 OID 17344)
-- Dependencies: 702 6 1143 1143
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = seg_overlap,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = &&,
    RESTRICT = areasel,
    JOIN = areajoinsel
);


ALTER OPERATOR public.&& (seg, seg) OWNER TO postgres;

--
-- TOC entry 1918 (class 2617 OID 17345)
-- Dependencies: 700 1143 1143 6
-- Name: &<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &< (
    PROCEDURE = seg_over_left,
    LEFTARG = seg,
    RIGHTARG = seg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&< (seg, seg) OWNER TO postgres;

--
-- TOC entry 1919 (class 2617 OID 17346)
-- Dependencies: 6 701 1143 1143
-- Name: &>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &> (
    PROCEDURE = seg_over_right,
    LEFTARG = seg,
    RIGHTARG = seg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&> (seg, seg) OWNER TO postgres;

--
-- TOC entry 1920 (class 2617 OID 17347)
-- Dependencies: 415 6
-- Name: +; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.+ (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1921 (class 2617 OID 17348)
-- Dependencies: 6 414
-- Name: +; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_array,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = +
);


ALTER OPERATOR public.+ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1922 (class 2617 OID 17349)
-- Dependencies: 413 6
-- Name: -; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR - (
    PROCEDURE = intarray_del_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.- (integer[], integer) OWNER TO postgres;

--
-- TOC entry 1923 (class 2617 OID 17350)
-- Dependencies: 417 6
-- Name: -; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR - (
    PROCEDURE = intset_subtract,
    LEFTARG = integer[],
    RIGHTARG = integer[]
);


ALTER OPERATOR public.- (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 1924 (class 2617 OID 17351)
-- Dependencies: 225 1097 6
-- Name: ->; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR -> (
    PROCEDURE = fetchval,
    LEFTARG = hstore,
    RIGHTARG = text
);


ALTER OPERATOR public.-> (hstore, text) OWNER TO postgres;

--
-- TOC entry 1925 (class 2617 OID 17354)
-- Dependencies: 165 6 1060 1060
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = cube_lt,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (cube, cube) OWNER TO postgres;

--
-- TOC entry 1928 (class 2617 OID 17357)
-- Dependencies: 6 547 1065 1065
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 1931 (class 2617 OID 17360)
-- Dependencies: 1106 548 1065 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 1934 (class 2617 OID 17363)
-- Dependencies: 6 1065 557 1106
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 1937 (class 2617 OID 17366)
-- Dependencies: 6 1065 1112 549
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 1940 (class 2617 OID 17369)
-- Dependencies: 1112 6 1065 563
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 1943 (class 2617 OID 17372)
-- Dependencies: 550 1118 6 1065
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 1946 (class 2617 OID 17375)
-- Dependencies: 1118 1065 569 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 1949 (class 2617 OID 17378)
-- Dependencies: 1103 551 6 1065
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 1952 (class 2617 OID 17381)
-- Dependencies: 560 1065 1103 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 1955 (class 2617 OID 17384)
-- Dependencies: 552 1109 1065 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 1958 (class 2617 OID 17387)
-- Dependencies: 566 6 1109 1065
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 1961 (class 2617 OID 17390)
-- Dependencies: 1065 6 553 1115
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, issn) OWNER TO postgres;

--
-- TOC entry 1963 (class 2617 OID 17393)
-- Dependencies: 6 1115 1065 572
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, ean13) OWNER TO postgres;

--
-- TOC entry 1966 (class 2617 OID 17396)
-- Dependencies: 1065 6 1182 554
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ean13, upc) OWNER TO postgres;

--
-- TOC entry 1969 (class 2617 OID 17399)
-- Dependencies: 6 574 1065 1182
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (upc, ean13) OWNER TO postgres;

--
-- TOC entry 1973 (class 2617 OID 17402)
-- Dependencies: 1106 6 555 1106
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 1974 (class 2617 OID 17405)
-- Dependencies: 1106 6 556 1103
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 1977 (class 2617 OID 17408)
-- Dependencies: 559 6 1103 1106
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 1980 (class 2617 OID 17411)
-- Dependencies: 1103 558 1103 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 1983 (class 2617 OID 17414)
-- Dependencies: 6 561 1112 1112
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 1986 (class 2617 OID 17417)
-- Dependencies: 1112 562 1109 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 1989 (class 2617 OID 17420)
-- Dependencies: 1112 565 1109 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 1992 (class 2617 OID 17423)
-- Dependencies: 6 564 1109 1109
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 1995 (class 2617 OID 17426)
-- Dependencies: 567 6 1118 1118
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 1998 (class 2617 OID 17429)
-- Dependencies: 568 6 1118 1115
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2001 (class 2617 OID 17432)
-- Dependencies: 6 571 1118 1115
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2004 (class 2617 OID 17435)
-- Dependencies: 1115 6 1115 570
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (issn, issn) OWNER TO postgres;

--
-- TOC entry 2007 (class 2617 OID 17438)
-- Dependencies: 573 1182 1182 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = isnlt,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (upc, upc) OWNER TO postgres;

--
-- TOC entry 2010 (class 2617 OID 17441)
-- Dependencies: 6 1127 635 1127
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = ltree_lt,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2013 (class 2617 OID 17444)
-- Dependencies: 1143 699 6 1143
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = seg_lt,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (seg, seg) OWNER TO postgres;

--
-- TOC entry 2016 (class 2617 OID 17446)
-- Dependencies: 6 697 1143 1143
-- Name: <<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR << (
    PROCEDURE = seg_left,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<< (seg, seg) OWNER TO postgres;

--
-- TOC entry 2017 (class 2617 OID 17447)
-- Dependencies: 6 163 1060 1060
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = cube_le,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (cube, cube) OWNER TO postgres;

--
-- TOC entry 2018 (class 2617 OID 17448)
-- Dependencies: 6 1065 1065 519
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 2019 (class 2617 OID 17449)
-- Dependencies: 520 1106 1065 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 2020 (class 2617 OID 17450)
-- Dependencies: 529 6 1106 1065
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 2021 (class 2617 OID 17451)
-- Dependencies: 1065 6 1112 521
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 2022 (class 2617 OID 17452)
-- Dependencies: 6 1065 535 1112
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 2023 (class 2617 OID 17453)
-- Dependencies: 6 522 1118 1065
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 2025 (class 2617 OID 17454)
-- Dependencies: 541 1065 1118 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 2026 (class 2617 OID 17455)
-- Dependencies: 6 523 1103 1065
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 2027 (class 2617 OID 17456)
-- Dependencies: 532 1065 1103 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 2028 (class 2617 OID 17457)
-- Dependencies: 524 1109 1065 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 2029 (class 2617 OID 17458)
-- Dependencies: 538 1065 1109 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 2030 (class 2617 OID 17459)
-- Dependencies: 6 1065 1115 525
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, issn) OWNER TO postgres;

--
-- TOC entry 2031 (class 2617 OID 17460)
-- Dependencies: 6 1115 1065 544
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, ean13) OWNER TO postgres;

--
-- TOC entry 2032 (class 2617 OID 17461)
-- Dependencies: 6 1065 1182 526
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2033 (class 2617 OID 17462)
-- Dependencies: 6 1182 1065 546
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2034 (class 2617 OID 17463)
-- Dependencies: 6 1106 1106 527
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2035 (class 2617 OID 17464)
-- Dependencies: 1106 528 1103 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2036 (class 2617 OID 17465)
-- Dependencies: 6 531 1106 1103
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2037 (class 2617 OID 17466)
-- Dependencies: 6 530 1103 1103
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2038 (class 2617 OID 17467)
-- Dependencies: 6 533 1112 1112
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2039 (class 2617 OID 17468)
-- Dependencies: 6 534 1109 1112
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2040 (class 2617 OID 17469)
-- Dependencies: 1109 537 1112 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2041 (class 2617 OID 17470)
-- Dependencies: 1109 536 1109 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2042 (class 2617 OID 17471)
-- Dependencies: 6 1118 1118 539
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2043 (class 2617 OID 17472)
-- Dependencies: 540 1118 1115 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2044 (class 2617 OID 17473)
-- Dependencies: 6 1115 1118 543
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2045 (class 2617 OID 17474)
-- Dependencies: 6 1115 1115 542
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (issn, issn) OWNER TO postgres;

--
-- TOC entry 2046 (class 2617 OID 17475)
-- Dependencies: 6 1182 1182 545
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = isnle,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (upc, upc) OWNER TO postgres;

--
-- TOC entry 2047 (class 2617 OID 17476)
-- Dependencies: 6 1127 1127 634
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = ltree_le,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2048 (class 2617 OID 17477)
-- Dependencies: 6 1143 1143 696
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = seg_le,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (seg, seg) OWNER TO postgres;

--
-- TOC entry 2049 (class 2617 OID 17479)
-- Dependencies: 656 1054 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = ne,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = =
);


ALTER OPERATOR public.<> (chkpass, text) OWNER TO postgres;

--
-- TOC entry 2051 (class 2617 OID 17481)
-- Dependencies: 1060 1060 166 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = cube_ne,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (cube, cube) OWNER TO postgres;

--
-- TOC entry 2053 (class 2617 OID 17483)
-- Dependencies: 1065 1065 575 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 2057 (class 2617 OID 17484)
-- Dependencies: 6 1065 585 1106
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 2055 (class 2617 OID 17486)
-- Dependencies: 6 1065 1106 576
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 2061 (class 2617 OID 17488)
-- Dependencies: 1112 1065 591 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 2059 (class 2617 OID 17490)
-- Dependencies: 577 1112 1065 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 2065 (class 2617 OID 17492)
-- Dependencies: 6 1065 1118 597
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 2063 (class 2617 OID 17494)
-- Dependencies: 6 1065 1118 578
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 2069 (class 2617 OID 17496)
-- Dependencies: 1103 6 588 1065
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 2067 (class 2617 OID 17498)
-- Dependencies: 579 1103 1065 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 2073 (class 2617 OID 17500)
-- Dependencies: 1065 6 594 1109
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 2071 (class 2617 OID 17502)
-- Dependencies: 1065 6 1109 580
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 2078 (class 2617 OID 17504)
-- Dependencies: 6 1065 600 1115
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, ean13) OWNER TO postgres;

--
-- TOC entry 2077 (class 2617 OID 17506)
-- Dependencies: 6 1065 1115 581
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, issn) OWNER TO postgres;

--
-- TOC entry 2082 (class 2617 OID 17508)
-- Dependencies: 1182 6 602 1065
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2080 (class 2617 OID 17510)
-- Dependencies: 582 1182 6 1065
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2084 (class 2617 OID 17513)
-- Dependencies: 1106 583 6 1106
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2088 (class 2617 OID 17514)
-- Dependencies: 1103 6 587 1106
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2086 (class 2617 OID 17516)
-- Dependencies: 1103 584 6 1106
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2090 (class 2617 OID 17519)
-- Dependencies: 586 6 1103 1103
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2092 (class 2617 OID 17521)
-- Dependencies: 1112 589 1112 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2097 (class 2617 OID 17522)
-- Dependencies: 6 593 1112 1109
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2094 (class 2617 OID 17524)
-- Dependencies: 6 590 1109 1112
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2099 (class 2617 OID 17527)
-- Dependencies: 592 1109 1109 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2101 (class 2617 OID 17529)
-- Dependencies: 595 6 1118 1118
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2104 (class 2617 OID 17530)
-- Dependencies: 1115 599 6 1118
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2095 (class 2617 OID 17532)
-- Dependencies: 1115 6 596 1118
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2106 (class 2617 OID 17535)
-- Dependencies: 598 1115 1115 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (issn, issn) OWNER TO postgres;

--
-- TOC entry 2108 (class 2617 OID 17537)
-- Dependencies: 601 6 1182 1182
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = isnne,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (upc, upc) OWNER TO postgres;

--
-- TOC entry 2110 (class 2617 OID 17539)
-- Dependencies: 1127 1127 6 636
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = ltree_ne,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2112 (class 2617 OID 17541)
-- Dependencies: 1143 6 1143 692
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = seg_different,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (seg, seg) OWNER TO postgres;

--
-- TOC entry 2114 (class 2617 OID 17543)
-- Dependencies: 1060 6 1060 156
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = cube_contained,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (cube, cube) OWNER TO postgres;

--
-- TOC entry 2116 (class 2617 OID 17545)
-- Dependencies: 406 6 1097 1097
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2118 (class 2617 OID 17547)
-- Dependencies: 6 73
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2120 (class 2617 OID 17549)
-- Dependencies: 6 1127 639 643 1127
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = ltree_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = @>,
    RESTRICT = ltreeparentsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2122 (class 2617 OID 17551)
-- Dependencies: 92 6 1129 1127
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _ltree_r_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2124 (class 2617 OID 17553)
-- Dependencies: 6 94 1127 1129
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = _ltree_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2126 (class 2617 OID 17555)
-- Dependencies: 1143 1143 6 690
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = seg_contained,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = @>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<@ (seg, seg) OWNER TO postgres;

--
-- TOC entry 2127 (class 2617 OID 17556)
-- Dependencies: 362 6
-- Name: <@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@> (
    PROCEDURE = geo_distance,
    LEFTARG = point,
    RIGHTARG = point,
    COMMUTATOR = <@>
);


ALTER OPERATOR public.<@> (point, point) OWNER TO postgres;

--
-- TOC entry 2075 (class 2617 OID 17478)
-- Dependencies: 6 1054 223
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = eq,
    LEFTARG = chkpass,
    RIGHTARG = text,
    NEGATOR = <>
);


ALTER OPERATOR public.= (chkpass, text) OWNER TO postgres;

--
-- TOC entry 2050 (class 2617 OID 17480)
-- Dependencies: 159 1060 6 1060
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = cube_eq,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (cube, cube) OWNER TO postgres;

--
-- TOC entry 2052 (class 2617 OID 17482)
-- Dependencies: 1065 6 435 1065
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 2056 (class 2617 OID 17485)
-- Dependencies: 436 1065 6 1106
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 2054 (class 2617 OID 17487)
-- Dependencies: 445 6 1106 1065
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 2060 (class 2617 OID 17489)
-- Dependencies: 1112 437 6 1065
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 2058 (class 2617 OID 17491)
-- Dependencies: 1112 451 1065 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 2064 (class 2617 OID 17493)
-- Dependencies: 6 1065 1118 438
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 2062 (class 2617 OID 17495)
-- Dependencies: 6 457 1065 1118
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 2068 (class 2617 OID 17497)
-- Dependencies: 439 1103 1065 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 2066 (class 2617 OID 17499)
-- Dependencies: 448 1065 1103 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 2072 (class 2617 OID 17501)
-- Dependencies: 440 1065 6 1109
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 2070 (class 2617 OID 17503)
-- Dependencies: 6 1109 1065 454
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 2129 (class 2617 OID 17505)
-- Dependencies: 6 1065 1115 441
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, issn) OWNER TO postgres;

--
-- TOC entry 2128 (class 2617 OID 17507)
-- Dependencies: 6 460 1065 1115
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, ean13) OWNER TO postgres;

--
-- TOC entry 2081 (class 2617 OID 17509)
-- Dependencies: 6 442 1182 1065
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2079 (class 2617 OID 17511)
-- Dependencies: 6 462 1065 1182
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2083 (class 2617 OID 17512)
-- Dependencies: 443 1106 1106 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2087 (class 2617 OID 17515)
-- Dependencies: 6 444 1106 1103
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2085 (class 2617 OID 17517)
-- Dependencies: 1103 6 447 1106
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2089 (class 2617 OID 17518)
-- Dependencies: 1103 446 1103 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 2091 (class 2617 OID 17520)
-- Dependencies: 449 1112 1112 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 2096 (class 2617 OID 17523)
-- Dependencies: 6 1109 450 1112
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 2093 (class 2617 OID 17525)
-- Dependencies: 1109 453 6 1112
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 2098 (class 2617 OID 17526)
-- Dependencies: 1109 452 6 1109
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 2100 (class 2617 OID 17528)
-- Dependencies: 1118 455 6 1118
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 2103 (class 2617 OID 17531)
-- Dependencies: 1115 1118 456 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2102 (class 2617 OID 17533)
-- Dependencies: 459 6 1115 1118
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2105 (class 2617 OID 17534)
-- Dependencies: 6 1115 458 1115
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (issn, issn) OWNER TO postgres;

--
-- TOC entry 2107 (class 2617 OID 17536)
-- Dependencies: 1182 1182 6 461
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = isneq,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (upc, upc) OWNER TO postgres;

--
-- TOC entry 2109 (class 2617 OID 17538)
-- Dependencies: 630 6 1127 1127
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = ltree_eq,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2111 (class 2617 OID 17540)
-- Dependencies: 1143 1143 6 704
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = seg_same,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (seg, seg) OWNER TO postgres;

--
-- TOC entry 2130 (class 2617 OID 17557)
-- Dependencies: 6 733 1097
-- Name: =>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR => (
    PROCEDURE = tconvert,
    LEFTARG = text,
    RIGHTARG = text
);


ALTER OPERATOR public.=> (text, text) OWNER TO postgres;

--
-- TOC entry 1967 (class 2617 OID 17352)
-- Dependencies: 1060 6 1060 161
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = cube_gt,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (cube, cube) OWNER TO postgres;

--
-- TOC entry 1968 (class 2617 OID 17355)
-- Dependencies: 491 1065 6 1065
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 1927 (class 2617 OID 17358)
-- Dependencies: 6 501 1065 1106
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 1936 (class 2617 OID 17361)
-- Dependencies: 6 1065 492 1106
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 1930 (class 2617 OID 17364)
-- Dependencies: 1112 507 1065 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 1942 (class 2617 OID 17367)
-- Dependencies: 1112 6 1065 493
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 1933 (class 2617 OID 17370)
-- Dependencies: 1065 513 6 1118
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 1948 (class 2617 OID 17373)
-- Dependencies: 1118 494 6 1065
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 1939 (class 2617 OID 17376)
-- Dependencies: 1065 6 1103 504
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 1954 (class 2617 OID 17379)
-- Dependencies: 1065 6 1103 495
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 1945 (class 2617 OID 17382)
-- Dependencies: 1109 6 1065 510
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 1960 (class 2617 OID 17385)
-- Dependencies: 496 1065 1109 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 1951 (class 2617 OID 17388)
-- Dependencies: 6 1115 1065 516
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, ean13) OWNER TO postgres;

--
-- TOC entry 1965 (class 2617 OID 17391)
-- Dependencies: 497 1065 6 1115
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, issn) OWNER TO postgres;

--
-- TOC entry 1957 (class 2617 OID 17394)
-- Dependencies: 1182 1065 518 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (upc, ean13) OWNER TO postgres;

--
-- TOC entry 1971 (class 2617 OID 17397)
-- Dependencies: 1065 6 1182 498
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ean13, upc) OWNER TO postgres;

--
-- TOC entry 2074 (class 2617 OID 17400)
-- Dependencies: 1106 6 1106 499
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2014 (class 2617 OID 17403)
-- Dependencies: 6 1103 1106 503
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 1979 (class 2617 OID 17406)
-- Dependencies: 500 6 1103 1106
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 2015 (class 2617 OID 17409)
-- Dependencies: 502 6 1103 1103
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 1976 (class 2617 OID 17412)
-- Dependencies: 1112 1112 505 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 1982 (class 2617 OID 17415)
-- Dependencies: 509 1112 6 1109
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 1991 (class 2617 OID 17418)
-- Dependencies: 6 506 1109 1112
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 1985 (class 2617 OID 17421)
-- Dependencies: 6 1109 1109 508
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 1988 (class 2617 OID 17424)
-- Dependencies: 511 1118 1118 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 1994 (class 2617 OID 17427)
-- Dependencies: 6 515 1118 1115
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, issn13) OWNER TO postgres;

--
-- TOC entry 2003 (class 2617 OID 17430)
-- Dependencies: 6 512 1115 1118
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn13, issn) OWNER TO postgres;

--
-- TOC entry 1997 (class 2617 OID 17433)
-- Dependencies: 1115 514 1115 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (issn, issn) OWNER TO postgres;

--
-- TOC entry 2000 (class 2617 OID 17436)
-- Dependencies: 517 6 1182 1182
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = isngt,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (upc, upc) OWNER TO postgres;

--
-- TOC entry 2006 (class 2617 OID 17439)
-- Dependencies: 1127 6 632 1127
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = ltree_gt,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2009 (class 2617 OID 17442)
-- Dependencies: 694 6 1143 1143
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = seg_gt,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (seg, seg) OWNER TO postgres;

--
-- TOC entry 1962 (class 2617 OID 17353)
-- Dependencies: 6 1060 160 1060
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = cube_ge,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (cube, cube) OWNER TO postgres;

--
-- TOC entry 1972 (class 2617 OID 17356)
-- Dependencies: 463 6 1065 1065
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ean13) OWNER TO postgres;

--
-- TOC entry 1926 (class 2617 OID 17359)
-- Dependencies: 464 6 1065 1106
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, isbn13) OWNER TO postgres;

--
-- TOC entry 1935 (class 2617 OID 17362)
-- Dependencies: 1065 1106 6 473
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, ean13) OWNER TO postgres;

--
-- TOC entry 1929 (class 2617 OID 17365)
-- Dependencies: 465 1112 1065 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ismn13) OWNER TO postgres;

--
-- TOC entry 1941 (class 2617 OID 17368)
-- Dependencies: 6 1065 479 1112
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ean13) OWNER TO postgres;

--
-- TOC entry 1932 (class 2617 OID 17371)
-- Dependencies: 1118 6 466 1065
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, issn13) OWNER TO postgres;

--
-- TOC entry 1947 (class 2617 OID 17374)
-- Dependencies: 1118 6 485 1065
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, ean13) OWNER TO postgres;

--
-- TOC entry 1938 (class 2617 OID 17377)
-- Dependencies: 1065 467 1103 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, isbn) OWNER TO postgres;

--
-- TOC entry 1953 (class 2617 OID 17380)
-- Dependencies: 1065 476 1103 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, ean13) OWNER TO postgres;

--
-- TOC entry 1944 (class 2617 OID 17383)
-- Dependencies: 1109 468 6 1065
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, ismn) OWNER TO postgres;

--
-- TOC entry 1959 (class 2617 OID 17386)
-- Dependencies: 1065 6 1109 482
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ean13) OWNER TO postgres;

--
-- TOC entry 1950 (class 2617 OID 17389)
-- Dependencies: 469 1115 1065 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, issn) OWNER TO postgres;

--
-- TOC entry 1964 (class 2617 OID 17392)
-- Dependencies: 1115 6 1065 488
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, ean13) OWNER TO postgres;

--
-- TOC entry 1956 (class 2617 OID 17395)
-- Dependencies: 6 470 1065 1182
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ean13,
    RIGHTARG = upc,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ean13, upc) OWNER TO postgres;

--
-- TOC entry 1970 (class 2617 OID 17398)
-- Dependencies: 1065 6 1182 490
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = upc,
    RIGHTARG = ean13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (upc, ean13) OWNER TO postgres;

--
-- TOC entry 2076 (class 2617 OID 17401)
-- Dependencies: 6 471 1106 1106
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, isbn13) OWNER TO postgres;

--
-- TOC entry 2012 (class 2617 OID 17404)
-- Dependencies: 1106 472 1103 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn13,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn13, isbn) OWNER TO postgres;

--
-- TOC entry 1978 (class 2617 OID 17407)
-- Dependencies: 475 1106 1103 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = isbn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, isbn13) OWNER TO postgres;

--
-- TOC entry 2024 (class 2617 OID 17410)
-- Dependencies: 1103 6 474 1103
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = isbn,
    RIGHTARG = isbn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (isbn, isbn) OWNER TO postgres;

--
-- TOC entry 1975 (class 2617 OID 17413)
-- Dependencies: 1112 6 1112 477
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ismn13) OWNER TO postgres;

--
-- TOC entry 1981 (class 2617 OID 17416)
-- Dependencies: 1109 6 1112 478
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn13,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn13, ismn) OWNER TO postgres;

--
-- TOC entry 1990 (class 2617 OID 17419)
-- Dependencies: 1112 6 1109 481
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ismn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ismn13) OWNER TO postgres;

--
-- TOC entry 1984 (class 2617 OID 17422)
-- Dependencies: 480 6 1109 1109
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = ismn,
    RIGHTARG = ismn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (ismn, ismn) OWNER TO postgres;

--
-- TOC entry 1987 (class 2617 OID 17425)
-- Dependencies: 483 6 1118 1118
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, issn13) OWNER TO postgres;

--
-- TOC entry 1993 (class 2617 OID 17428)
-- Dependencies: 1115 484 6 1118
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn13,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn13, issn) OWNER TO postgres;

--
-- TOC entry 2002 (class 2617 OID 17431)
-- Dependencies: 487 6 1115 1118
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = issn13,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, issn13) OWNER TO postgres;

--
-- TOC entry 1996 (class 2617 OID 17434)
-- Dependencies: 1115 6 1115 486
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = issn,
    RIGHTARG = issn,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (issn, issn) OWNER TO postgres;

--
-- TOC entry 1999 (class 2617 OID 17437)
-- Dependencies: 489 6 1182 1182
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = isnge,
    LEFTARG = upc,
    RIGHTARG = upc,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (upc, upc) OWNER TO postgres;

--
-- TOC entry 2005 (class 2617 OID 17440)
-- Dependencies: 1127 6 631 1127
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = ltree_ge,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2008 (class 2617 OID 17443)
-- Dependencies: 1143 6 1143 693
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = seg_ge,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (seg, seg) OWNER TO postgres;

--
-- TOC entry 2011 (class 2617 OID 17445)
-- Dependencies: 1143 6 1143 703
-- Name: >>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >> (
    PROCEDURE = seg_right,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.>> (seg, seg) OWNER TO postgres;

--
-- TOC entry 2131 (class 2617 OID 17558)
-- Dependencies: 6 224 1097
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = exist,
    LEFTARG = hstore,
    RIGHTARG = text,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (hstore, text) OWNER TO postgres;

--
-- TOC entry 2133 (class 2617 OID 17559)
-- Dependencies: 1126 6 1127 619
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = lt_q_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (ltree, lquery[]) OWNER TO postgres;

--
-- TOC entry 2132 (class 2617 OID 17560)
-- Dependencies: 1127 620 6 1126
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree,
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (lquery[], ltree) OWNER TO postgres;

--
-- TOC entry 2136 (class 2617 OID 17561)
-- Dependencies: 1126 1129 6 80
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = _lt_q_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (ltree[], lquery[]) OWNER TO postgres;

--
-- TOC entry 2134 (class 2617 OID 17562)
-- Dependencies: 81 1126 6 1129
-- Name: ?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ? (
    PROCEDURE = _lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree[],
    COMMUTATOR = ?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.? (lquery[], ltree[]) OWNER TO postgres;

--
-- TOC entry 2137 (class 2617 OID 17563)
-- Dependencies: 1127 1129 6 1127 88
-- Name: ?<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?<@ (
    PROCEDURE = _ltree_extract_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree
);


ALTER OPERATOR public.?<@ (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2138 (class 2617 OID 17564)
-- Dependencies: 1129 6 1133 1127 98
-- Name: ?@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?@ (
    PROCEDURE = _ltxtq_extract_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery
);


ALTER OPERATOR public.?@ (ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 2139 (class 2617 OID 17565)
-- Dependencies: 1127 1129 6 87 1127
-- Name: ?@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?@> (
    PROCEDURE = _ltree_extract_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree
);


ALTER OPERATOR public.?@> (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2140 (class 2617 OID 17566)
-- Dependencies: 1124 1127 82 6 1129
-- Name: ?~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ?~ (
    PROCEDURE = _ltq_extract_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery
);


ALTER OPERATOR public.?~ (ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 2141 (class 2617 OID 17568)
-- Dependencies: 157 6 1060 1060
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = cube_contains,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (cube, cube) OWNER TO postgres;

--
-- TOC entry 2143 (class 2617 OID 17570)
-- Dependencies: 407 6 1097 1097
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2145 (class 2617 OID 17572)
-- Dependencies: 6 74
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2147 (class 2617 OID 17573)
-- Dependencies: 644 1133 1127 6
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = ltxtq_exec,
    LEFTARG = ltree,
    RIGHTARG = ltxtquery,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltree, ltxtquery) OWNER TO postgres;

--
-- TOC entry 2146 (class 2617 OID 17574)
-- Dependencies: 645 6 1133 1127
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltxtquery, ltree) OWNER TO postgres;

--
-- TOC entry 2150 (class 2617 OID 17575)
-- Dependencies: 6 97 1133 1129
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _ltxtq_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 2148 (class 2617 OID 17576)
-- Dependencies: 1129 99 6 1133
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = _ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (ltxtquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2151 (class 2617 OID 17578)
-- Dependencies: 691 1143 6 1143
-- Name: @; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @ (
    PROCEDURE = seg_contains,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (seg, seg) OWNER TO postgres;

--
-- TOC entry 2113 (class 2617 OID 17542)
-- Dependencies: 6 157 1060 1060
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = cube_contains,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (cube, cube) OWNER TO postgres;

--
-- TOC entry 2115 (class 2617 OID 17544)
-- Dependencies: 407 1097 1097 6
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = hs_contains,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2117 (class 2617 OID 17546)
-- Dependencies: 6 74
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2119 (class 2617 OID 17548)
-- Dependencies: 1127 6 1127 633 643
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = ltree_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = <@,
    RESTRICT = ltreeparentsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2121 (class 2617 OID 17550)
-- Dependencies: 1129 1127 89 6
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _ltree_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2123 (class 2617 OID 17552)
-- Dependencies: 6 1127 1129 93
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = _ltree_r_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2125 (class 2617 OID 17554)
-- Dependencies: 1143 1143 691 6
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = seg_contains,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = <@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@> (seg, seg) OWNER TO postgres;

--
-- TOC entry 2153 (class 2617 OID 17580)
-- Dependencies: 6 104 1140
-- Name: @@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @@ (
    PROCEDURE = boolop,
    LEFTARG = integer[],
    RIGHTARG = query_int,
    COMMUTATOR = ~~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (integer[], query_int) OWNER TO postgres;

--
-- TOC entry 2154 (class 2617 OID 17582)
-- Dependencies: 1127 6 639 1127
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^<@ (
    PROCEDURE = ltree_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2156 (class 2617 OID 17584)
-- Dependencies: 6 1127 92 1129
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^<@ (
    PROCEDURE = _ltree_r_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2158 (class 2617 OID 17586)
-- Dependencies: 6 1129 94 1127
-- Name: ^<@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^<@ (
    PROCEDURE = _ltree_risparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = ^@>,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^<@ (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2135 (class 2617 OID 17587)
-- Dependencies: 619 1126 1127 6
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = lt_q_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (ltree, lquery[]) OWNER TO postgres;

--
-- TOC entry 2160 (class 2617 OID 17588)
-- Dependencies: 6 1126 1127 620
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree,
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (lquery[], ltree) OWNER TO postgres;

--
-- TOC entry 2161 (class 2617 OID 17589)
-- Dependencies: 80 6 1129 1126
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = _lt_q_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (ltree[], lquery[]) OWNER TO postgres;

--
-- TOC entry 2149 (class 2617 OID 17590)
-- Dependencies: 6 81 1129 1126
-- Name: ^?; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^? (
    PROCEDURE = _lt_q_rregex,
    LEFTARG = lquery[],
    RIGHTARG = ltree[],
    COMMUTATOR = ^?,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^? (lquery[], ltree[]) OWNER TO postgres;

--
-- TOC entry 2164 (class 2617 OID 17591)
-- Dependencies: 6 644 1127 1133
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = ltxtq_exec,
    LEFTARG = ltree,
    RIGHTARG = ltxtquery,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltree, ltxtquery) OWNER TO postgres;

--
-- TOC entry 2162 (class 2617 OID 17592)
-- Dependencies: 6 645 1127 1133
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltxtquery, ltree) OWNER TO postgres;

--
-- TOC entry 2167 (class 2617 OID 17593)
-- Dependencies: 6 1129 1133 97
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = _ltxtq_exec,
    LEFTARG = ltree[],
    RIGHTARG = ltxtquery,
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltree[], ltxtquery) OWNER TO postgres;

--
-- TOC entry 2165 (class 2617 OID 17594)
-- Dependencies: 6 99 1129 1133
-- Name: ^@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@ (
    PROCEDURE = _ltxtq_rexec,
    LEFTARG = ltxtquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ^@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@ (ltxtquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2168 (class 2617 OID 17581)
-- Dependencies: 1127 1127 6 633
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@> (
    PROCEDURE = ltree_isparent,
    LEFTARG = ltree,
    RIGHTARG = ltree,
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2169 (class 2617 OID 17583)
-- Dependencies: 1129 6 89 1127
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@> (
    PROCEDURE = _ltree_isparent,
    LEFTARG = ltree[],
    RIGHTARG = ltree,
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree[], ltree) OWNER TO postgres;

--
-- TOC entry 2170 (class 2617 OID 17585)
-- Dependencies: 93 1127 1129 6
-- Name: ^@>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^@> (
    PROCEDURE = _ltree_r_risparent,
    LEFTARG = ltree,
    RIGHTARG = ltree[],
    COMMUTATOR = ^<@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^@> (ltree, ltree[]) OWNER TO postgres;

--
-- TOC entry 2159 (class 2617 OID 17595)
-- Dependencies: 6 621 1124 1127
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = ltq_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (ltree, lquery) OWNER TO postgres;

--
-- TOC entry 2155 (class 2617 OID 17596)
-- Dependencies: 1124 1127 622 6
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (lquery, ltree) OWNER TO postgres;

--
-- TOC entry 2171 (class 2617 OID 17597)
-- Dependencies: 83 6 1129 1124
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = _ltq_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery,
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 2163 (class 2617 OID 17598)
-- Dependencies: 1124 1129 84 6
-- Name: ^~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ^~ (
    PROCEDURE = _ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ^~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.^~ (lquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2172 (class 2617 OID 17599)
-- Dependencies: 6 418
-- Name: |; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR | (
    PROCEDURE = intset_union_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.| (integer[], integer) OWNER TO postgres;

--
-- TOC entry 2173 (class 2617 OID 17600)
-- Dependencies: 6 79
-- Name: |; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR | (
    PROCEDURE = _int_union,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = |
);


ALTER OPERATOR public.| (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2157 (class 2617 OID 17601)
-- Dependencies: 405 6 1097 1097 1097
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = hs_concat,
    LEFTARG = hstore,
    RIGHTARG = hstore
);


ALTER OPERATOR public.|| (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2166 (class 2617 OID 17602)
-- Dependencies: 624 6 1127 1127 1127
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = ltree_addltree,
    LEFTARG = ltree,
    RIGHTARG = ltree
);


ALTER OPERATOR public.|| (ltree, ltree) OWNER TO postgres;

--
-- TOC entry 2174 (class 2617 OID 17603)
-- Dependencies: 625 1127 1127 6
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = ltree_addtext,
    LEFTARG = ltree,
    RIGHTARG = text
);


ALTER OPERATOR public.|| (ltree, text) OWNER TO postgres;

--
-- TOC entry 2175 (class 2617 OID 17604)
-- Dependencies: 1127 6 1127 641
-- Name: ||; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR || (
    PROCEDURE = ltree_textadd,
    LEFTARG = text,
    RIGHTARG = ltree
);


ALTER OPERATOR public.|| (text, ltree) OWNER TO postgres;

--
-- TOC entry 2176 (class 2617 OID 17567)
-- Dependencies: 1060 1060 6 156
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = cube_contained,
    LEFTARG = cube,
    RIGHTARG = cube,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (cube, cube) OWNER TO postgres;

--
-- TOC entry 2142 (class 2617 OID 17569)
-- Dependencies: 406 1097 6 1097
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = hs_contained,
    LEFTARG = hstore,
    RIGHTARG = hstore,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (hstore, hstore) OWNER TO postgres;

--
-- TOC entry 2144 (class 2617 OID 17571)
-- Dependencies: 6 73
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (integer[], integer[]) OWNER TO postgres;

--
-- TOC entry 2180 (class 2617 OID 17577)
-- Dependencies: 6 1143 1143 690
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = seg_contained,
    LEFTARG = seg,
    RIGHTARG = seg,
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (seg, seg) OWNER TO postgres;

--
-- TOC entry 2178 (class 2617 OID 17605)
-- Dependencies: 1124 621 1127 6
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = ltq_regex,
    LEFTARG = ltree,
    RIGHTARG = lquery,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (ltree, lquery) OWNER TO postgres;

--
-- TOC entry 2177 (class 2617 OID 17606)
-- Dependencies: 1127 6 1124 622
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (lquery, ltree) OWNER TO postgres;

--
-- TOC entry 2181 (class 2617 OID 17607)
-- Dependencies: 6 1124 83 1129
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _ltq_regex,
    LEFTARG = ltree[],
    RIGHTARG = lquery,
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (ltree[], lquery) OWNER TO postgres;

--
-- TOC entry 2179 (class 2617 OID 17608)
-- Dependencies: 6 1124 1129 84
-- Name: ~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~ (
    PROCEDURE = _ltq_rregex,
    LEFTARG = lquery,
    RIGHTARG = ltree[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (lquery, ltree[]) OWNER TO postgres;

--
-- TOC entry 2152 (class 2617 OID 17579)
-- Dependencies: 687 1140 6
-- Name: ~~; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR ~~ (
    PROCEDURE = rboolop,
    LEFTARG = query_int,
    RIGHTARG = integer[],
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~~ (query_int, integer[]) OWNER TO postgres;

--
-- TOC entry 2293 (class 2616 OID 17610)
-- Dependencies: 6 2451 1060
-- Name: cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS cube_ops
    DEFAULT FOR TYPE cube USING btree AS
    OPERATOR 1 <(cube,cube) ,
    OPERATOR 2 <=(cube,cube) ,
    OPERATOR 3 =(cube,cube) ,
    OPERATOR 4 >=(cube,cube) ,
    OPERATOR 5 >(cube,cube) ,
    FUNCTION 1 cube_cmp(cube,cube);


ALTER OPERATOR CLASS public.cube_ops USING btree OWNER TO postgres;

--
-- TOC entry 2452 (class 2753 OID 17617)
-- Dependencies: 6
-- Name: isn_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY isn_ops USING btree;
ALTER OPERATOR FAMILY isn_ops USING btree ADD
    OPERATOR 1 <(ismn,ean13) ,
    OPERATOR 1 <(ismn13,ismn) ,
    OPERATOR 1 <(ismn13,ean13) ,
    OPERATOR 1 <(isbn,isbn13) ,
    OPERATOR 1 <(isbn,ean13) ,
    OPERATOR 1 <(isbn13,isbn) ,
    OPERATOR 1 <(isbn13,ean13) ,
    OPERATOR 1 <(ean13,ismn13) ,
    OPERATOR 1 <(ean13,issn13) ,
    OPERATOR 1 <(ean13,isbn) ,
    OPERATOR 1 <(ean13,ismn) ,
    OPERATOR 1 <(ean13,issn) ,
    OPERATOR 1 <(ean13,isbn13) ,
    OPERATOR 1 <(ean13,upc) ,
    OPERATOR 1 <(upc,ean13) ,
    OPERATOR 1 <(issn,issn13) ,
    OPERATOR 1 <(issn,ean13) ,
    OPERATOR 1 <(issn13,issn) ,
    OPERATOR 1 <(issn13,ean13) ,
    OPERATOR 1 <(ismn,ismn13) ,
    OPERATOR 2 <=(ean13,issn) ,
    OPERATOR 2 <=(ean13,isbn13) ,
    OPERATOR 2 <=(ean13,ismn13) ,
    OPERATOR 2 <=(ean13,issn13) ,
    OPERATOR 2 <=(ean13,isbn) ,
    OPERATOR 2 <=(ean13,ismn) ,
    OPERATOR 2 <=(ean13,upc) ,
    OPERATOR 2 <=(isbn13,ean13) ,
    OPERATOR 2 <=(isbn13,isbn) ,
    OPERATOR 2 <=(isbn,ean13) ,
    OPERATOR 2 <=(isbn,isbn13) ,
    OPERATOR 2 <=(ismn13,ean13) ,
    OPERATOR 2 <=(ismn13,ismn) ,
    OPERATOR 2 <=(ismn,ean13) ,
    OPERATOR 2 <=(ismn,ismn13) ,
    OPERATOR 2 <=(issn13,ean13) ,
    OPERATOR 2 <=(issn13,issn) ,
    OPERATOR 2 <=(issn,ean13) ,
    OPERATOR 2 <=(issn,issn13) ,
    OPERATOR 2 <=(upc,ean13) ,
    OPERATOR 3 =(ean13,issn13) ,
    OPERATOR 3 =(issn,ean13) ,
    OPERATOR 3 =(issn,issn13) ,
    OPERATOR 3 =(isbn,ean13) ,
    OPERATOR 3 =(isbn,isbn13) ,
    OPERATOR 3 =(ismn13,ean13) ,
    OPERATOR 3 =(ismn13,ismn) ,
    OPERATOR 3 =(ean13,upc) ,
    OPERATOR 3 =(ean13,issn) ,
    OPERATOR 3 =(ismn,ean13) ,
    OPERATOR 3 =(ismn,ismn13) ,
    OPERATOR 3 =(ean13,ismn) ,
    OPERATOR 3 =(ean13,isbn) ,
    OPERATOR 3 =(ean13,isbn13) ,
    OPERATOR 3 =(issn13,ean13) ,
    OPERATOR 3 =(issn13,issn) ,
    OPERATOR 3 =(isbn13,isbn) ,
    OPERATOR 3 =(ean13,ismn13) ,
    OPERATOR 3 =(upc,ean13) ,
    OPERATOR 3 =(isbn13,ean13) ,
    OPERATOR 4 >=(ean13,ismn) ,
    OPERATOR 4 >=(ismn13,ean13) ,
    OPERATOR 4 >=(ismn13,ismn) ,
    OPERATOR 4 >=(ean13,upc) ,
    OPERATOR 4 >=(ismn,ean13) ,
    OPERATOR 4 >=(ismn,ismn13) ,
    OPERATOR 4 >=(ean13,issn) ,
    OPERATOR 4 >=(isbn13,ean13) ,
    OPERATOR 4 >=(isbn13,isbn) ,
    OPERATOR 4 >=(ean13,isbn) ,
    OPERATOR 4 >=(ean13,issn13) ,
    OPERATOR 4 >=(issn13,ean13) ,
    OPERATOR 4 >=(issn13,issn) ,
    OPERATOR 4 >=(isbn,ean13) ,
    OPERATOR 4 >=(isbn,isbn13) ,
    OPERATOR 4 >=(ean13,ismn13) ,
    OPERATOR 4 >=(ean13,isbn13) ,
    OPERATOR 4 >=(issn,ean13) ,
    OPERATOR 4 >=(issn,issn13) ,
    OPERATOR 4 >=(upc,ean13) ,
    OPERATOR 5 >(issn13,issn) ,
    OPERATOR 5 >(isbn,ean13) ,
    OPERATOR 5 >(isbn,isbn13) ,
    OPERATOR 5 >(ismn13,ean13) ,
    OPERATOR 5 >(ismn13,ismn) ,
    OPERATOR 5 >(isbn13,ean13) ,
    OPERATOR 5 >(ean13,isbn13) ,
    OPERATOR 5 >(issn,ean13) ,
    OPERATOR 5 >(issn,issn13) ,
    OPERATOR 5 >(ean13,ismn13) ,
    OPERATOR 5 >(ean13,issn13) ,
    OPERATOR 5 >(isbn13,isbn) ,
    OPERATOR 5 >(issn13,ean13) ,
    OPERATOR 5 >(ismn,ean13) ,
    OPERATOR 5 >(ismn,ismn13) ,
    OPERATOR 5 >(ean13,isbn) ,
    OPERATOR 5 >(ean13,ismn) ,
    OPERATOR 5 >(ean13,issn) ,
    OPERATOR 5 >(upc,ean13) ,
    OPERATOR 5 >(ean13,upc) ,
    FUNCTION 1 (ean13, isbn13) btean13cmp(ean13,isbn13) ,
    FUNCTION 1 (ean13, ismn13) btean13cmp(ean13,ismn13) ,
    FUNCTION 1 (ean13, issn13) btean13cmp(ean13,issn13) ,
    FUNCTION 1 (ean13, isbn) btean13cmp(ean13,isbn) ,
    FUNCTION 1 (ean13, ismn) btean13cmp(ean13,ismn) ,
    FUNCTION 1 (ean13, issn) btean13cmp(ean13,issn) ,
    FUNCTION 1 (ean13, upc) btean13cmp(ean13,upc) ,
    FUNCTION 1 (isbn13, ean13) btisbn13cmp(isbn13,ean13) ,
    FUNCTION 1 (isbn13, isbn) btisbn13cmp(isbn13,isbn) ,
    FUNCTION 1 (isbn, ean13) btisbncmp(isbn,ean13) ,
    FUNCTION 1 (isbn, isbn13) btisbncmp(isbn,isbn13) ,
    FUNCTION 1 (ismn13, ean13) btismn13cmp(ismn13,ean13) ,
    FUNCTION 1 (ismn13, ismn) btismn13cmp(ismn13,ismn) ,
    FUNCTION 1 (ismn, ean13) btismncmp(ismn,ean13) ,
    FUNCTION 1 (ismn, ismn13) btismncmp(ismn,ismn13) ,
    FUNCTION 1 (issn13, ean13) btissn13cmp(issn13,ean13) ,
    FUNCTION 1 (issn13, issn) btissn13cmp(issn13,issn) ,
    FUNCTION 1 (issn, ean13) btissncmp(issn,ean13) ,
    FUNCTION 1 (issn, issn13) btissncmp(issn,issn13) ,
    FUNCTION 1 (upc, ean13) btupccmp(upc,ean13);


ALTER OPERATOR FAMILY public.isn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2294 (class 2616 OID 17738)
-- Dependencies: 6 1065 2452
-- Name: ean13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ean13_ops
    DEFAULT FOR TYPE ean13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ean13,ean13) ,
    OPERATOR 2 <=(ean13,ean13) ,
    OPERATOR 3 =(ean13,ean13) ,
    OPERATOR 4 >=(ean13,ean13) ,
    OPERATOR 5 >(ean13,ean13) ,
    FUNCTION 1 btean13cmp(ean13,ean13);


ALTER OPERATOR CLASS public.ean13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2453 (class 2753 OID 17745)
-- Dependencies: 6
-- Name: isn_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY isn_ops USING hash;
ALTER OPERATOR FAMILY isn_ops USING hash ADD
    OPERATOR 1 =(ean13,isbn13) ,
    OPERATOR 1 =(ean13,ismn13) ,
    OPERATOR 1 =(ean13,issn13) ,
    OPERATOR 1 =(ean13,isbn) ,
    OPERATOR 1 =(ean13,ismn) ,
    OPERATOR 1 =(ean13,issn) ,
    OPERATOR 1 =(ean13,upc) ,
    OPERATOR 1 =(isbn13,ean13) ,
    OPERATOR 1 =(isbn13,isbn) ,
    OPERATOR 1 =(isbn,ean13) ,
    OPERATOR 1 =(isbn,isbn13) ,
    OPERATOR 1 =(ismn13,ean13) ,
    OPERATOR 1 =(ismn13,ismn) ,
    OPERATOR 1 =(ismn,ean13) ,
    OPERATOR 1 =(ismn,ismn13) ,
    OPERATOR 1 =(issn13,ean13) ,
    OPERATOR 1 =(issn13,issn) ,
    OPERATOR 1 =(issn,ean13) ,
    OPERATOR 1 =(issn,issn13) ,
    OPERATOR 1 =(upc,ean13);


ALTER OPERATOR FAMILY public.isn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2295 (class 2616 OID 17766)
-- Dependencies: 1065 6 2453
-- Name: ean13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ean13_ops
    DEFAULT FOR TYPE ean13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ean13,ean13) ,
    FUNCTION 1 hashean13(ean13);


ALTER OPERATOR CLASS public.ean13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2296 (class 2616 OID 17770)
-- Dependencies: 2454 6
-- Name: gin__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin__int_ops
    FOR TYPE integer[] USING gin AS
    STORAGE integer ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 ginarrayextract(anyarray,internal) ,
    FUNCTION 3 ginint4_queryextract(internal,internal,smallint) ,
    FUNCTION 4 ginint4_consistent(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin__int_ops USING gin OWNER TO postgres;

--
-- TOC entry 2297 (class 2616 OID 17783)
-- Dependencies: 1097 6 2455
-- Name: gin_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin_hstore_ops
    DEFAULT FOR TYPE hstore USING gin AS
    STORAGE text ,
    OPERATOR 7 @>(hstore,hstore) ,
    OPERATOR 9 ?(hstore,text) ,
    FUNCTION 1 bttextcmp(text,text) ,
    FUNCTION 2 gin_extract_hstore(internal,internal) ,
    FUNCTION 3 gin_extract_hstore_query(internal,internal,smallint) ,
    FUNCTION 4 gin_consistent_hstore(internal,smallint,internal);


ALTER OPERATOR CLASS public.gin_hstore_ops USING gin OWNER TO postgres;

--
-- TOC entry 2298 (class 2616 OID 17791)
-- Dependencies: 2456 6
-- Name: gin_trgm_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gin_trgm_ops
    FOR TYPE text USING gin AS
    STORAGE integer ,
    OPERATOR 1 %(text,text) ,
    FUNCTION 1 btint4cmp(integer,integer) ,
    FUNCTION 2 gin_extract_trgm(text,internal) ,
    FUNCTION 3 gin_extract_trgm(text,internal,internal) ,
    FUNCTION 4 gin_trgm_consistent(internal,internal,text);


ALTER OPERATOR CLASS public.gin_trgm_ops USING gin OWNER TO postgres;

--
-- TOC entry 2299 (class 2616 OID 17798)
-- Dependencies: 2457 6
-- Name: gist__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__int_ops
    DEFAULT FOR TYPE integer[] USING gist AS
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_int_consistent(internal,integer[],integer) ,
    FUNCTION 2 g_int_union(internal,internal) ,
    FUNCTION 3 g_int_compress(internal) ,
    FUNCTION 4 g_int_decompress(internal) ,
    FUNCTION 5 g_int_penalty(internal,internal,internal) ,
    FUNCTION 6 g_int_picksplit(internal,internal) ,
    FUNCTION 7 g_int_same(integer[],integer[],internal);


ALTER OPERATOR CLASS public.gist__int_ops USING gist OWNER TO postgres;

--
-- TOC entry 2300 (class 2616 OID 17814)
-- Dependencies: 1100 2458 6
-- Name: gist__intbig_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__intbig_ops
    FOR TYPE integer[] USING gist AS
    STORAGE intbig_gkey ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @>(integer[],integer[]) ,
    OPERATOR 8 <@(integer[],integer[]) ,
    OPERATOR 13 @(integer[],integer[]) ,
    OPERATOR 14 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_intbig_consistent(internal,internal,integer) ,
    FUNCTION 2 g_intbig_union(internal,internal) ,
    FUNCTION 3 g_intbig_compress(internal) ,
    FUNCTION 4 g_intbig_decompress(internal) ,
    FUNCTION 5 g_intbig_penalty(internal,internal,internal) ,
    FUNCTION 6 g_intbig_picksplit(internal,internal) ,
    FUNCTION 7 g_intbig_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__intbig_ops USING gist OWNER TO postgres;

--
-- TOC entry 2301 (class 2616 OID 17830)
-- Dependencies: 2459 6 1129 1130
-- Name: gist__ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist__ltree_ops
    DEFAULT FOR TYPE ltree[] USING gist AS
    STORAGE ltree_gist ,
    OPERATOR 10 <@(ltree[],ltree) ,
    OPERATOR 11 @>(ltree,ltree[]) ,
    OPERATOR 12 ~(ltree[],lquery) ,
    OPERATOR 13 ~(lquery,ltree[]) ,
    OPERATOR 14 @(ltree[],ltxtquery) ,
    OPERATOR 15 @(ltxtquery,ltree[]) ,
    OPERATOR 16 ?(ltree[],lquery[]) ,
    OPERATOR 17 ?(lquery[],ltree[]) ,
    FUNCTION 1 _ltree_consistent(internal,internal,smallint) ,
    FUNCTION 2 _ltree_union(internal,internal) ,
    FUNCTION 3 _ltree_compress(internal) ,
    FUNCTION 4 ltree_decompress(internal) ,
    FUNCTION 5 _ltree_penalty(internal,internal,internal) ,
    FUNCTION 6 _ltree_picksplit(internal,internal) ,
    FUNCTION 7 _ltree_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__ltree_ops USING gist OWNER TO postgres;

--
-- TOC entry 2302 (class 2616 OID 17847)
-- Dependencies: 6 1085 2460
-- Name: gist_bit_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bit_ops
    DEFAULT FOR TYPE bit USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bit,bit) ,
    OPERATOR 2 <=(bit,bit) ,
    OPERATOR 3 =(bit,bit) ,
    OPERATOR 4 >=(bit,bit) ,
    OPERATOR 5 >(bit,bit) ,
    FUNCTION 1 gbt_bit_consistent(internal,bit,smallint) ,
    FUNCTION 2 gbt_bit_union(bytea,internal) ,
    FUNCTION 3 gbt_bit_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bit_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bit_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bit_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bit_ops USING gist OWNER TO postgres;

--
-- TOC entry 2303 (class 2616 OID 17861)
-- Dependencies: 2461 1085 6
-- Name: gist_bpchar_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bpchar_ops
    DEFAULT FOR TYPE character USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(character,character) ,
    OPERATOR 2 <=(character,character) ,
    OPERATOR 3 =(character,character) ,
    OPERATOR 4 >=(character,character) ,
    OPERATOR 5 >(character,character) ,
    FUNCTION 1 gbt_bpchar_consistent(internal,character,smallint) ,
    FUNCTION 2 gbt_text_union(bytea,internal) ,
    FUNCTION 3 gbt_bpchar_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_text_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_text_picksplit(internal,internal) ,
    FUNCTION 7 gbt_text_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bpchar_ops USING gist OWNER TO postgres;

--
-- TOC entry 2304 (class 2616 OID 17875)
-- Dependencies: 2462 6 1085
-- Name: gist_bytea_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bytea_ops
    DEFAULT FOR TYPE bytea USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bytea,bytea) ,
    OPERATOR 2 <=(bytea,bytea) ,
    OPERATOR 3 =(bytea,bytea) ,
    OPERATOR 4 >=(bytea,bytea) ,
    OPERATOR 5 >(bytea,bytea) ,
    FUNCTION 1 gbt_bytea_consistent(internal,bytea,smallint) ,
    FUNCTION 2 gbt_bytea_union(bytea,internal) ,
    FUNCTION 3 gbt_bytea_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bytea_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bytea_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bytea_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_bytea_ops USING gist OWNER TO postgres;

--
-- TOC entry 2305 (class 2616 OID 17889)
-- Dependencies: 1073 2463 6
-- Name: gist_cash_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_cash_ops
    DEFAULT FOR TYPE money USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(money,money) ,
    OPERATOR 2 <=(money,money) ,
    OPERATOR 3 =(money,money) ,
    OPERATOR 4 >=(money,money) ,
    OPERATOR 5 >(money,money) ,
    FUNCTION 1 gbt_cash_consistent(internal,money,smallint) ,
    FUNCTION 2 gbt_cash_union(bytea,internal) ,
    FUNCTION 3 gbt_cash_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_cash_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_cash_picksplit(internal,internal) ,
    FUNCTION 7 gbt_cash_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_cash_ops USING gist OWNER TO postgres;

--
-- TOC entry 2306 (class 2616 OID 17903)
-- Dependencies: 2464 1073 6
-- Name: gist_cidr_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_cidr_ops
    DEFAULT FOR TYPE cidr USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(inet,inet) ,
    OPERATOR 2 <=(inet,inet) ,
    OPERATOR 3 =(inet,inet) ,
    OPERATOR 4 >=(inet,inet) ,
    OPERATOR 5 >(inet,inet) ,
    FUNCTION 1 gbt_inet_consistent(internal,inet,smallint) ,
    FUNCTION 2 gbt_inet_union(bytea,internal) ,
    FUNCTION 3 gbt_inet_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_inet_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_inet_picksplit(internal,internal) ,
    FUNCTION 7 gbt_inet_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_cidr_ops USING gist OWNER TO postgres;

--
-- TOC entry 2307 (class 2616 OID 17917)
-- Dependencies: 2465 1060 6
-- Name: gist_cube_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_cube_ops
    DEFAULT FOR TYPE cube USING gist AS
    OPERATOR 3 &&(cube,cube) ,
    OPERATOR 6 =(cube,cube) ,
    OPERATOR 7 @>(cube,cube) ,
    OPERATOR 8 <@(cube,cube) ,
    OPERATOR 13 @(cube,cube) ,
    OPERATOR 14 ~(cube,cube) ,
    FUNCTION 1 g_cube_consistent(internal,cube,integer) ,
    FUNCTION 2 g_cube_union(internal,internal) ,
    FUNCTION 3 g_cube_compress(internal) ,
    FUNCTION 4 g_cube_decompress(internal) ,
    FUNCTION 5 g_cube_penalty(internal,internal,internal) ,
    FUNCTION 6 g_cube_picksplit(internal,internal) ,
    FUNCTION 7 g_cube_same(cube,cube,internal);


ALTER OPERATOR CLASS public.gist_cube_ops USING gist OWNER TO postgres;

--
-- TOC entry 2308 (class 2616 OID 17932)
-- Dependencies: 2466 6 1082
-- Name: gist_date_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_date_ops
    DEFAULT FOR TYPE date USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(date,date) ,
    OPERATOR 2 <=(date,date) ,
    OPERATOR 3 =(date,date) ,
    OPERATOR 4 >=(date,date) ,
    OPERATOR 5 >(date,date) ,
    FUNCTION 1 gbt_date_consistent(internal,date,smallint) ,
    FUNCTION 2 gbt_date_union(bytea,internal) ,
    FUNCTION 3 gbt_date_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_date_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_date_picksplit(internal,internal) ,
    FUNCTION 7 gbt_date_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_date_ops USING gist OWNER TO postgres;

--
-- TOC entry 2309 (class 2616 OID 17946)
-- Dependencies: 1082 2467 6
-- Name: gist_float4_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_float4_ops
    DEFAULT FOR TYPE real USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(real,real) ,
    OPERATOR 2 <=(real,real) ,
    OPERATOR 3 =(real,real) ,
    OPERATOR 4 >=(real,real) ,
    OPERATOR 5 >(real,real) ,
    FUNCTION 1 gbt_float4_consistent(internal,real,smallint) ,
    FUNCTION 2 gbt_float4_union(bytea,internal) ,
    FUNCTION 3 gbt_float4_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_float4_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_float4_picksplit(internal,internal) ,
    FUNCTION 7 gbt_float4_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_float4_ops USING gist OWNER TO postgres;

--
-- TOC entry 2310 (class 2616 OID 17960)
-- Dependencies: 2468 6 1073
-- Name: gist_float8_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_float8_ops
    DEFAULT FOR TYPE double precision USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(double precision,double precision) ,
    OPERATOR 2 <=(double precision,double precision) ,
    OPERATOR 3 =(double precision,double precision) ,
    OPERATOR 4 >=(double precision,double precision) ,
    OPERATOR 5 >(double precision,double precision) ,
    FUNCTION 1 gbt_float8_consistent(internal,double precision,smallint) ,
    FUNCTION 2 gbt_float8_union(bytea,internal) ,
    FUNCTION 3 gbt_float8_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_float8_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_float8_picksplit(internal,internal) ,
    FUNCTION 7 gbt_float8_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_float8_ops USING gist OWNER TO postgres;

--
-- TOC entry 2311 (class 2616 OID 17974)
-- Dependencies: 1088 6 2469 1097
-- Name: gist_hstore_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_hstore_ops
    DEFAULT FOR TYPE hstore USING gist AS
    STORAGE ghstore ,
    OPERATOR 7 @>(hstore,hstore) ,
    OPERATOR 9 ?(hstore,text) ,
    OPERATOR 13 @(hstore,hstore) ,
    FUNCTION 1 ghstore_consistent(internal,internal,integer) ,
    FUNCTION 2 ghstore_union(internal,internal) ,
    FUNCTION 3 ghstore_compress(internal) ,
    FUNCTION 4 ghstore_decompress(internal) ,
    FUNCTION 5 ghstore_penalty(internal,internal,internal) ,
    FUNCTION 6 ghstore_picksplit(internal,internal) ,
    FUNCTION 7 ghstore_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_hstore_ops USING gist OWNER TO postgres;

--
-- TOC entry 2312 (class 2616 OID 17986)
-- Dependencies: 2470 1073 6
-- Name: gist_inet_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_inet_ops
    DEFAULT FOR TYPE inet USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(inet,inet) ,
    OPERATOR 2 <=(inet,inet) ,
    OPERATOR 3 =(inet,inet) ,
    OPERATOR 4 >=(inet,inet) ,
    OPERATOR 5 >(inet,inet) ,
    FUNCTION 1 gbt_inet_consistent(internal,inet,smallint) ,
    FUNCTION 2 gbt_inet_union(bytea,internal) ,
    FUNCTION 3 gbt_inet_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_inet_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_inet_picksplit(internal,internal) ,
    FUNCTION 7 gbt_inet_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_inet_ops USING gist OWNER TO postgres;

--
-- TOC entry 2313 (class 2616 OID 18000)
-- Dependencies: 6 1079 2471
-- Name: gist_int2_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_int2_ops
    DEFAULT FOR TYPE smallint USING gist AS
    STORAGE gbtreekey4 ,
    OPERATOR 1 <(smallint,smallint) ,
    OPERATOR 2 <=(smallint,smallint) ,
    OPERATOR 3 =(smallint,smallint) ,
    OPERATOR 4 >=(smallint,smallint) ,
    OPERATOR 5 >(smallint,smallint) ,
    FUNCTION 1 gbt_int2_consistent(internal,smallint,smallint) ,
    FUNCTION 2 gbt_int2_union(bytea,internal) ,
    FUNCTION 3 gbt_int2_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int2_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int2_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int2_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int2_ops USING gist OWNER TO postgres;

--
-- TOC entry 2314 (class 2616 OID 18014)
-- Dependencies: 6 1082 2472
-- Name: gist_int4_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_int4_ops
    DEFAULT FOR TYPE integer USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(integer,integer) ,
    OPERATOR 2 <=(integer,integer) ,
    OPERATOR 3 =(integer,integer) ,
    OPERATOR 4 >=(integer,integer) ,
    OPERATOR 5 >(integer,integer) ,
    FUNCTION 1 gbt_int4_consistent(internal,integer,smallint) ,
    FUNCTION 2 gbt_int4_union(bytea,internal) ,
    FUNCTION 3 gbt_int4_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int4_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int4_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int4_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int4_ops USING gist OWNER TO postgres;

--
-- TOC entry 2315 (class 2616 OID 18028)
-- Dependencies: 2473 1073 6
-- Name: gist_int8_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_int8_ops
    DEFAULT FOR TYPE bigint USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(bigint,bigint) ,
    OPERATOR 2 <=(bigint,bigint) ,
    OPERATOR 3 =(bigint,bigint) ,
    OPERATOR 4 >=(bigint,bigint) ,
    OPERATOR 5 >(bigint,bigint) ,
    FUNCTION 1 gbt_int8_consistent(internal,bigint,smallint) ,
    FUNCTION 2 gbt_int8_union(bytea,internal) ,
    FUNCTION 3 gbt_int8_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_int8_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_int8_picksplit(internal,internal) ,
    FUNCTION 7 gbt_int8_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_int8_ops USING gist OWNER TO postgres;

--
-- TOC entry 2316 (class 2616 OID 18042)
-- Dependencies: 1076 6 2474
-- Name: gist_interval_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_interval_ops
    DEFAULT FOR TYPE interval USING gist AS
    STORAGE gbtreekey32 ,
    OPERATOR 1 <(interval,interval) ,
    OPERATOR 2 <=(interval,interval) ,
    OPERATOR 3 =(interval,interval) ,
    OPERATOR 4 >=(interval,interval) ,
    OPERATOR 5 >(interval,interval) ,
    FUNCTION 1 gbt_intv_consistent(internal,interval,smallint) ,
    FUNCTION 2 gbt_intv_union(bytea,internal) ,
    FUNCTION 3 gbt_intv_compress(internal) ,
    FUNCTION 4 gbt_intv_decompress(internal) ,
    FUNCTION 5 gbt_intv_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_intv_picksplit(internal,internal) ,
    FUNCTION 7 gbt_intv_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_interval_ops USING gist OWNER TO postgres;

--
-- TOC entry 2317 (class 2616 OID 18056)
-- Dependencies: 6 1130 1127 2475
-- Name: gist_ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_ltree_ops
    DEFAULT FOR TYPE ltree USING gist AS
    STORAGE ltree_gist ,
    OPERATOR 1 <(ltree,ltree) ,
    OPERATOR 2 <=(ltree,ltree) ,
    OPERATOR 3 =(ltree,ltree) ,
    OPERATOR 4 >=(ltree,ltree) ,
    OPERATOR 5 >(ltree,ltree) ,
    OPERATOR 10 @>(ltree,ltree) ,
    OPERATOR 11 <@(ltree,ltree) ,
    OPERATOR 12 ~(ltree,lquery) ,
    OPERATOR 13 ~(lquery,ltree) ,
    OPERATOR 14 @(ltree,ltxtquery) ,
    OPERATOR 15 @(ltxtquery,ltree) ,
    OPERATOR 16 ?(ltree,lquery[]) ,
    OPERATOR 17 ?(lquery[],ltree) ,
    FUNCTION 1 ltree_consistent(internal,internal,smallint) ,
    FUNCTION 2 ltree_union(internal,internal) ,
    FUNCTION 3 ltree_compress(internal) ,
    FUNCTION 4 ltree_decompress(internal) ,
    FUNCTION 5 ltree_penalty(internal,internal,internal) ,
    FUNCTION 6 ltree_picksplit(internal,internal) ,
    FUNCTION 7 ltree_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_ltree_ops USING gist OWNER TO postgres;

--
-- TOC entry 2318 (class 2616 OID 18078)
-- Dependencies: 2476 1073 6
-- Name: gist_macaddr_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_macaddr_ops
    DEFAULT FOR TYPE macaddr USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(macaddr,macaddr) ,
    OPERATOR 2 <=(macaddr,macaddr) ,
    OPERATOR 3 =(macaddr,macaddr) ,
    OPERATOR 4 >=(macaddr,macaddr) ,
    OPERATOR 5 >(macaddr,macaddr) ,
    FUNCTION 1 gbt_macad_consistent(internal,macaddr,smallint) ,
    FUNCTION 2 gbt_macad_union(bytea,internal) ,
    FUNCTION 3 gbt_macad_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_macad_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_macad_picksplit(internal,internal) ,
    FUNCTION 7 gbt_macad_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_macaddr_ops USING gist OWNER TO postgres;

--
-- TOC entry 2319 (class 2616 OID 18092)
-- Dependencies: 6 2477 1085
-- Name: gist_numeric_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_numeric_ops
    DEFAULT FOR TYPE numeric USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(numeric,numeric) ,
    OPERATOR 2 <=(numeric,numeric) ,
    OPERATOR 3 =(numeric,numeric) ,
    OPERATOR 4 >=(numeric,numeric) ,
    OPERATOR 5 >(numeric,numeric) ,
    FUNCTION 1 gbt_numeric_consistent(internal,numeric,smallint) ,
    FUNCTION 2 gbt_numeric_union(bytea,internal) ,
    FUNCTION 3 gbt_numeric_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_numeric_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_numeric_picksplit(internal,internal) ,
    FUNCTION 7 gbt_numeric_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_numeric_ops USING gist OWNER TO postgres;

--
-- TOC entry 2320 (class 2616 OID 18106)
-- Dependencies: 2478 6 1082
-- Name: gist_oid_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_oid_ops
    DEFAULT FOR TYPE oid USING gist AS
    STORAGE gbtreekey8 ,
    OPERATOR 1 <(oid,oid) ,
    OPERATOR 2 <=(oid,oid) ,
    OPERATOR 3 =(oid,oid) ,
    OPERATOR 4 >=(oid,oid) ,
    OPERATOR 5 >(oid,oid) ,
    FUNCTION 1 gbt_oid_consistent(internal,oid,smallint) ,
    FUNCTION 2 gbt_oid_union(bytea,internal) ,
    FUNCTION 3 gbt_oid_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_oid_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_oid_picksplit(internal,internal) ,
    FUNCTION 7 gbt_oid_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_oid_ops USING gist OWNER TO postgres;

--
-- TOC entry 2321 (class 2616 OID 18120)
-- Dependencies: 1143 2479 6
-- Name: gist_seg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_seg_ops
    DEFAULT FOR TYPE seg USING gist AS
    OPERATOR 1 <<(seg,seg) ,
    OPERATOR 2 &<(seg,seg) ,
    OPERATOR 3 &&(seg,seg) ,
    OPERATOR 4 &>(seg,seg) ,
    OPERATOR 5 >>(seg,seg) ,
    OPERATOR 6 =(seg,seg) ,
    OPERATOR 7 @>(seg,seg) ,
    OPERATOR 8 <@(seg,seg) ,
    OPERATOR 13 @(seg,seg) ,
    OPERATOR 14 ~(seg,seg) ,
    FUNCTION 1 gseg_consistent(internal,seg,integer) ,
    FUNCTION 2 gseg_union(internal,internal) ,
    FUNCTION 3 gseg_compress(internal) ,
    FUNCTION 4 gseg_decompress(internal) ,
    FUNCTION 5 gseg_penalty(internal,internal,internal) ,
    FUNCTION 6 gseg_picksplit(internal,internal) ,
    FUNCTION 7 gseg_same(seg,seg,internal);


ALTER OPERATOR CLASS public.gist_seg_ops USING gist OWNER TO postgres;

--
-- TOC entry 2322 (class 2616 OID 18139)
-- Dependencies: 6 1085 2480
-- Name: gist_text_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_text_ops
    DEFAULT FOR TYPE text USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(text,text) ,
    OPERATOR 2 <=(text,text) ,
    OPERATOR 3 =(text,text) ,
    OPERATOR 4 >=(text,text) ,
    OPERATOR 5 >(text,text) ,
    FUNCTION 1 gbt_text_consistent(internal,text,smallint) ,
    FUNCTION 2 gbt_text_union(bytea,internal) ,
    FUNCTION 3 gbt_text_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_text_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_text_picksplit(internal,internal) ,
    FUNCTION 7 gbt_text_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_text_ops USING gist OWNER TO postgres;

--
-- TOC entry 2323 (class 2616 OID 18153)
-- Dependencies: 1073 2481 6
-- Name: gist_time_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_time_ops
    DEFAULT FOR TYPE time without time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(time without time zone,time without time zone) ,
    OPERATOR 2 <=(time without time zone,time without time zone) ,
    OPERATOR 3 =(time without time zone,time without time zone) ,
    OPERATOR 4 >=(time without time zone,time without time zone) ,
    OPERATOR 5 >(time without time zone,time without time zone) ,
    FUNCTION 1 gbt_time_consistent(internal,time without time zone,smallint) ,
    FUNCTION 2 gbt_time_union(bytea,internal) ,
    FUNCTION 3 gbt_time_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_time_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_time_picksplit(internal,internal) ,
    FUNCTION 7 gbt_time_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_time_ops USING gist OWNER TO postgres;

--
-- TOC entry 2324 (class 2616 OID 18167)
-- Dependencies: 1073 2482 6
-- Name: gist_timestamp_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_timestamp_ops
    DEFAULT FOR TYPE timestamp without time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 2 <=(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 3 =(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 4 >=(timestamp without time zone,timestamp without time zone) ,
    OPERATOR 5 >(timestamp without time zone,timestamp without time zone) ,
    FUNCTION 1 gbt_ts_consistent(internal,timestamp without time zone,smallint) ,
    FUNCTION 2 gbt_ts_union(bytea,internal) ,
    FUNCTION 3 gbt_ts_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_ts_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_ts_picksplit(internal,internal) ,
    FUNCTION 7 gbt_ts_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timestamp_ops USING gist OWNER TO postgres;

--
-- TOC entry 2325 (class 2616 OID 18181)
-- Dependencies: 1073 6 2483
-- Name: gist_timestamptz_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_timestamptz_ops
    DEFAULT FOR TYPE timestamp with time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 2 <=(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 3 =(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 4 >=(timestamp with time zone,timestamp with time zone) ,
    OPERATOR 5 >(timestamp with time zone,timestamp with time zone) ,
    FUNCTION 1 gbt_tstz_consistent(internal,timestamp with time zone,smallint) ,
    FUNCTION 2 gbt_ts_union(bytea,internal) ,
    FUNCTION 3 gbt_tstz_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_ts_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_ts_picksplit(internal,internal) ,
    FUNCTION 7 gbt_ts_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timestamptz_ops USING gist OWNER TO postgres;

--
-- TOC entry 2326 (class 2616 OID 18195)
-- Dependencies: 2484 6 1073
-- Name: gist_timetz_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_timetz_ops
    DEFAULT FOR TYPE time with time zone USING gist AS
    STORAGE gbtreekey16 ,
    OPERATOR 1 <(time with time zone,time with time zone) ,
    OPERATOR 2 <=(time with time zone,time with time zone) ,
    OPERATOR 3 =(time with time zone,time with time zone) ,
    OPERATOR 4 >=(time with time zone,time with time zone) ,
    OPERATOR 5 >(time with time zone,time with time zone) ,
    FUNCTION 1 gbt_timetz_consistent(internal,time with time zone,smallint) ,
    FUNCTION 2 gbt_time_union(bytea,internal) ,
    FUNCTION 3 gbt_timetz_compress(internal) ,
    FUNCTION 4 gbt_decompress(internal) ,
    FUNCTION 5 gbt_time_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_time_picksplit(internal,internal) ,
    FUNCTION 7 gbt_time_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_timetz_ops USING gist OWNER TO postgres;

--
-- TOC entry 2327 (class 2616 OID 18209)
-- Dependencies: 1091 2485 6
-- Name: gist_trgm_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_trgm_ops
    FOR TYPE text USING gist AS
    STORAGE gtrgm ,
    OPERATOR 1 %(text,text) ,
    FUNCTION 1 gtrgm_consistent(gtrgm,internal,integer) ,
    FUNCTION 2 gtrgm_union(bytea,internal) ,
    FUNCTION 3 gtrgm_compress(internal) ,
    FUNCTION 4 gtrgm_decompress(internal) ,
    FUNCTION 5 gtrgm_penalty(internal,internal,internal) ,
    FUNCTION 6 gtrgm_picksplit(internal,internal) ,
    FUNCTION 7 gtrgm_same(gtrgm,gtrgm,internal);


ALTER OPERATOR CLASS public.gist_trgm_ops USING gist OWNER TO postgres;

--
-- TOC entry 2328 (class 2616 OID 18219)
-- Dependencies: 2486 1085 6
-- Name: gist_vbit_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_vbit_ops
    DEFAULT FOR TYPE bit varying USING gist AS
    STORAGE gbtreekey_var ,
    OPERATOR 1 <(bit varying,bit varying) ,
    OPERATOR 2 <=(bit varying,bit varying) ,
    OPERATOR 3 =(bit varying,bit varying) ,
    OPERATOR 4 >=(bit varying,bit varying) ,
    OPERATOR 5 >(bit varying,bit varying) ,
    FUNCTION 1 gbt_bit_consistent(internal,bit,smallint) ,
    FUNCTION 2 gbt_bit_union(bytea,internal) ,
    FUNCTION 3 gbt_bit_compress(internal) ,
    FUNCTION 4 gbt_var_decompress(internal) ,
    FUNCTION 5 gbt_bit_penalty(internal,internal,internal) ,
    FUNCTION 6 gbt_bit_picksplit(internal,internal) ,
    FUNCTION 7 gbt_bit_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist_vbit_ops USING gist OWNER TO postgres;

--
-- TOC entry 2329 (class 2616 OID 18232)
-- Dependencies: 1106 6 2452
-- Name: isbn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn13_ops
    DEFAULT FOR TYPE isbn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(isbn13,isbn13) ,
    OPERATOR 2 <=(isbn13,isbn13) ,
    OPERATOR 3 =(isbn13,isbn13) ,
    OPERATOR 4 >=(isbn13,isbn13) ,
    OPERATOR 5 >(isbn13,isbn13) ,
    FUNCTION 1 btisbn13cmp(isbn13,isbn13);


ALTER OPERATOR CLASS public.isbn13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2330 (class 2616 OID 18239)
-- Dependencies: 2453 6 1106
-- Name: isbn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn13_ops
    DEFAULT FOR TYPE isbn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(isbn13,isbn13) ,
    FUNCTION 1 hashisbn13(isbn13);


ALTER OPERATOR CLASS public.isbn13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2331 (class 2616 OID 18242)
-- Dependencies: 2452 1103 6
-- Name: isbn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn_ops
    DEFAULT FOR TYPE isbn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(isbn,isbn) ,
    OPERATOR 2 <=(isbn,isbn) ,
    OPERATOR 3 =(isbn,isbn) ,
    OPERATOR 4 >=(isbn,isbn) ,
    OPERATOR 5 >(isbn,isbn) ,
    FUNCTION 1 btisbncmp(isbn,isbn);


ALTER OPERATOR CLASS public.isbn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2332 (class 2616 OID 18249)
-- Dependencies: 2453 6 1103
-- Name: isbn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS isbn_ops
    DEFAULT FOR TYPE isbn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(isbn,isbn) ,
    FUNCTION 1 hashisbn(isbn);


ALTER OPERATOR CLASS public.isbn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2333 (class 2616 OID 18252)
-- Dependencies: 2452 6 1112
-- Name: ismn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn13_ops
    DEFAULT FOR TYPE ismn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ismn13,ismn13) ,
    OPERATOR 2 <=(ismn13,ismn13) ,
    OPERATOR 3 =(ismn13,ismn13) ,
    OPERATOR 4 >=(ismn13,ismn13) ,
    OPERATOR 5 >(ismn13,ismn13) ,
    FUNCTION 1 btismn13cmp(ismn13,ismn13);


ALTER OPERATOR CLASS public.ismn13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2334 (class 2616 OID 18259)
-- Dependencies: 2453 6 1112
-- Name: ismn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn13_ops
    DEFAULT FOR TYPE ismn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ismn13,ismn13) ,
    FUNCTION 1 hashismn13(ismn13);


ALTER OPERATOR CLASS public.ismn13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2335 (class 2616 OID 18262)
-- Dependencies: 6 1109 2452
-- Name: ismn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn_ops
    DEFAULT FOR TYPE ismn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(ismn,ismn) ,
    OPERATOR 2 <=(ismn,ismn) ,
    OPERATOR 3 =(ismn,ismn) ,
    OPERATOR 4 >=(ismn,ismn) ,
    OPERATOR 5 >(ismn,ismn) ,
    FUNCTION 1 btismncmp(ismn,ismn);


ALTER OPERATOR CLASS public.ismn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2336 (class 2616 OID 18269)
-- Dependencies: 1109 6 2453
-- Name: ismn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ismn_ops
    DEFAULT FOR TYPE ismn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(ismn,ismn) ,
    FUNCTION 1 hashismn(ismn);


ALTER OPERATOR CLASS public.ismn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2337 (class 2616 OID 18272)
-- Dependencies: 6 2452 1118
-- Name: issn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn13_ops
    DEFAULT FOR TYPE issn13 USING btree FAMILY isn_ops AS
    OPERATOR 1 <(issn13,issn13) ,
    OPERATOR 2 <=(issn13,issn13) ,
    OPERATOR 3 =(issn13,issn13) ,
    OPERATOR 4 >=(issn13,issn13) ,
    OPERATOR 5 >(issn13,issn13) ,
    FUNCTION 1 btissn13cmp(issn13,issn13);


ALTER OPERATOR CLASS public.issn13_ops USING btree OWNER TO postgres;

--
-- TOC entry 2338 (class 2616 OID 18279)
-- Dependencies: 2453 1118 6
-- Name: issn13_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn13_ops
    DEFAULT FOR TYPE issn13 USING hash FAMILY isn_ops AS
    OPERATOR 1 =(issn13,issn13) ,
    FUNCTION 1 hashissn13(issn13);


ALTER OPERATOR CLASS public.issn13_ops USING hash OWNER TO postgres;

--
-- TOC entry 2339 (class 2616 OID 18282)
-- Dependencies: 2452 1115 6
-- Name: issn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn_ops
    DEFAULT FOR TYPE issn USING btree FAMILY isn_ops AS
    OPERATOR 1 <(issn,issn) ,
    OPERATOR 2 <=(issn,issn) ,
    OPERATOR 3 =(issn,issn) ,
    OPERATOR 4 >=(issn,issn) ,
    OPERATOR 5 >(issn,issn) ,
    FUNCTION 1 btissncmp(issn,issn);


ALTER OPERATOR CLASS public.issn_ops USING btree OWNER TO postgres;

--
-- TOC entry 2340 (class 2616 OID 18289)
-- Dependencies: 1115 2453 6
-- Name: issn_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS issn_ops
    DEFAULT FOR TYPE issn USING hash FAMILY isn_ops AS
    OPERATOR 1 =(issn,issn) ,
    FUNCTION 1 hashissn(issn);


ALTER OPERATOR CLASS public.issn_ops USING hash OWNER TO postgres;

--
-- TOC entry 2341 (class 2616 OID 18293)
-- Dependencies: 2487 6 1127
-- Name: ltree_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS ltree_ops
    DEFAULT FOR TYPE ltree USING btree AS
    OPERATOR 1 <(ltree,ltree) ,
    OPERATOR 2 <=(ltree,ltree) ,
    OPERATOR 3 =(ltree,ltree) ,
    OPERATOR 4 >=(ltree,ltree) ,
    OPERATOR 5 >(ltree,ltree) ,
    FUNCTION 1 ltree_cmp(ltree,ltree);


ALTER OPERATOR CLASS public.ltree_ops USING btree OWNER TO postgres;

--
-- TOC entry 2342 (class 2616 OID 18301)
-- Dependencies: 1143 6 2488
-- Name: seg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS seg_ops
    DEFAULT FOR TYPE seg USING btree AS
    OPERATOR 1 <(seg,seg) ,
    OPERATOR 2 <=(seg,seg) ,
    OPERATOR 3 =(seg,seg) ,
    OPERATOR 4 >=(seg,seg) ,
    OPERATOR 5 >(seg,seg) ,
    FUNCTION 1 seg_cmp(seg,seg);


ALTER OPERATOR CLASS public.seg_ops USING btree OWNER TO postgres;

--
-- TOC entry 2343 (class 2616 OID 18308)
-- Dependencies: 2452 6 1182
-- Name: upc_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS upc_ops
    DEFAULT FOR TYPE upc USING btree FAMILY isn_ops AS
    OPERATOR 1 <(upc,upc) ,
    OPERATOR 2 <=(upc,upc) ,
    OPERATOR 3 =(upc,upc) ,
    OPERATOR 4 >=(upc,upc) ,
    OPERATOR 5 >(upc,upc) ,
    FUNCTION 1 btupccmp(upc,upc);


ALTER OPERATOR CLASS public.upc_ops USING btree OWNER TO postgres;

--
-- TOC entry 2344 (class 2616 OID 18315)
-- Dependencies: 1182 2453 6
-- Name: upc_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS upc_ops
    DEFAULT FOR TYPE upc USING hash FAMILY isn_ops AS
    OPERATOR 1 =(upc,upc) ,
    FUNCTION 1 hashupc(upc);


ALTER OPERATOR CLASS public.upc_ops USING hash OWNER TO postgres;

SET search_path = pg_catalog;

--
-- TOC entry 3071 (class 2605 OID 18318)
-- Dependencies: 427 1103 1065 427
-- Name: CAST (public.ean13 AS public.isbn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.isbn) WITH FUNCTION public.isbn(public.ean13);


--
-- TOC entry 3072 (class 2605 OID 18319)
-- Dependencies: 428 1065 1106 428
-- Name: CAST (public.ean13 AS public.isbn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.isbn13) WITH FUNCTION public.isbn13(public.ean13);


--
-- TOC entry 3073 (class 2605 OID 18320)
-- Dependencies: 431 1065 1109 431
-- Name: CAST (public.ean13 AS public.ismn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.ismn) WITH FUNCTION public.ismn(public.ean13);


--
-- TOC entry 3074 (class 2605 OID 18321)
-- Dependencies: 432 1065 1112 432
-- Name: CAST (public.ean13 AS public.ismn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.ismn13) WITH FUNCTION public.ismn13(public.ean13);


--
-- TOC entry 3075 (class 2605 OID 18322)
-- Dependencies: 603 603 1065 1115
-- Name: CAST (public.ean13 AS public.issn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.issn) WITH FUNCTION public.issn(public.ean13);


--
-- TOC entry 3076 (class 2605 OID 18323)
-- Dependencies: 604 1118 1065 604
-- Name: CAST (public.ean13 AS public.issn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.issn13) WITH FUNCTION public.issn13(public.ean13);


--
-- TOC entry 3077 (class 2605 OID 18324)
-- Dependencies: 738 1182 1065 738
-- Name: CAST (public.ean13 AS public.upc); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ean13 AS public.upc) WITH FUNCTION public.upc(public.ean13);


--
-- TOC entry 3078 (class 2605 OID 18325)
-- Dependencies: 1103 1065
-- Name: CAST (public.isbn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3079 (class 2605 OID 18326)
-- Dependencies: 1106 1103
-- Name: CAST (public.isbn AS public.isbn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn AS public.isbn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3080 (class 2605 OID 18327)
-- Dependencies: 1106 1065
-- Name: CAST (public.isbn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3081 (class 2605 OID 18328)
-- Dependencies: 1106 1103
-- Name: CAST (public.isbn13 AS public.isbn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.isbn13 AS public.isbn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3082 (class 2605 OID 18329)
-- Dependencies: 1065 1109
-- Name: CAST (public.ismn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3083 (class 2605 OID 18330)
-- Dependencies: 1112 1109
-- Name: CAST (public.ismn AS public.ismn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn AS public.ismn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3084 (class 2605 OID 18331)
-- Dependencies: 1112 1065
-- Name: CAST (public.ismn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3085 (class 2605 OID 18332)
-- Dependencies: 1109 1112
-- Name: CAST (public.ismn13 AS public.ismn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.ismn13 AS public.ismn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3086 (class 2605 OID 18333)
-- Dependencies: 1065 1115
-- Name: CAST (public.issn AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3087 (class 2605 OID 18334)
-- Dependencies: 1118 1115
-- Name: CAST (public.issn AS public.issn13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn AS public.issn13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3088 (class 2605 OID 18335)
-- Dependencies: 1065 1118
-- Name: CAST (public.issn13 AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn13 AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3089 (class 2605 OID 18336)
-- Dependencies: 1115 1118
-- Name: CAST (public.issn13 AS public.issn); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.issn13 AS public.issn) WITHOUT FUNCTION AS ASSIGNMENT;


--
-- TOC entry 3090 (class 2605 OID 18337)
-- Dependencies: 1065 1182
-- Name: CAST (public.upc AS public.ean13); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.upc AS public.ean13) WITHOUT FUNCTION AS ASSIGNMENT;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 2755 (class 1259 OID 16401)
-- Dependencies: 6
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cargos (
    id integer NOT NULL,
    descricao text
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 2779 (class 1259 OID 18338)
-- Dependencies: 2755 6
-- Name: cargos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cargos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cargos_id_seq OWNER TO postgres;

--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 2779
-- Name: cargos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cargos_id_seq OWNED BY cargos.id;


--
-- TOC entry 2756 (class 1259 OID 16411)
-- Dependencies: 6
-- Name: classe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE classe (
    id integer NOT NULL,
    descricao text
);


ALTER TABLE public.classe OWNER TO postgres;

--
-- TOC entry 2780 (class 1259 OID 18340)
-- Dependencies: 6 2756
-- Name: classe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE classe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.classe_id_seq OWNER TO postgres;

--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 2780
-- Name: classe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE classe_id_seq OWNED BY classe.id;


--
-- TOC entry 2759 (class 1259 OID 16431)
-- Dependencies: 6
-- Name: funcao; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE funcao (
    id integer NOT NULL,
    descricao text
);


ALTER TABLE public.funcao OWNER TO postgres;

--
-- TOC entry 2781 (class 1259 OID 18342)
-- Dependencies: 6 2759
-- Name: funcao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE funcao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.funcao_id_seq OWNER TO postgres;

--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 2781
-- Name: funcao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE funcao_id_seq OWNED BY funcao.id;


--
-- TOC entry 2760 (class 1259 OID 16465)
-- Dependencies: 6
-- Name: horapadrao; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE horapadrao (
    he1 text,
    hs1 text,
    he2 text,
    hs2 text,
    id bigint NOT NULL
);


ALTER TABLE public.horapadrao OWNER TO postgres;

--
-- TOC entry 2761 (class 1259 OID 16503)
-- Dependencies: 6
-- Name: lotacoes; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lotacoes (
    id integer NOT NULL,
    descricao text
);


ALTER TABLE public.lotacoes OWNER TO postgres;

--
-- TOC entry 2782 (class 1259 OID 18344)
-- Dependencies: 6 2761
-- Name: lotacoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lotacoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.lotacoes_id_seq OWNER TO postgres;

--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 2782
-- Name: lotacoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lotacoes_id_seq OWNED BY lotacoes.id;


--
-- TOC entry 2762 (class 1259 OID 16526)
-- Dependencies: 2879 6
-- Name: pg_buffercache; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW pg_buffercache AS
    SELECT p.bufferid, p.relfilenode, p.reltablespace, p.reldatabase, p.relblocknumber, p.isdirty, p.usagecount FROM pg_buffercache_pages() p(bufferid integer, relfilenode oid, reltablespace oid, reldatabase oid, relblocknumber bigint, isdirty boolean, usagecount smallint);


ALTER TABLE public.pg_buffercache OWNER TO postgres;

--
-- TOC entry 2764 (class 1259 OID 16543)
-- Dependencies: 6
-- Name: statusordem; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE statusordem (
    id integer NOT NULL,
    descricao text
);


ALTER TABLE public.statusordem OWNER TO postgres;

--
-- TOC entry 2783 (class 1259 OID 18346)
-- Dependencies: 2764 6
-- Name: statusordem_codigo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE statusordem_codigo_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.statusordem_codigo_seq OWNER TO postgres;

--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 2783
-- Name: statusordem_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE statusordem_codigo_seq OWNED BY statusordem.id;


--
-- TOC entry 2769 (class 1259 OID 16561)
-- Dependencies: 6
-- Name: tbdataespecial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbdataespecial (
    id integer NOT NULL,
    descricao character(300)
);


ALTER TABLE public.tbdataespecial OWNER TO postgres;

--
-- TOC entry 2784 (class 1259 OID 18348)
-- Dependencies: 2769 6
-- Name: tbdataespecial_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbdataespecial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbdataespecial_id_seq OWNER TO postgres;

--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 2784
-- Name: tbdataespecial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbdataespecial_id_seq OWNED BY tbdataespecial.id;


--
-- TOC entry 2770 (class 1259 OID 16564)
-- Dependencies: 6
-- Name: tbescala; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbescala (
    id bigint NOT NULL,
    data text,
    dataespecial integer,
    plantonista1 integer,
    plantonista2 integer,
    agente1 integer,
    agente2 integer,
    escrivao integer,
    delegado integer,
    papiloscopista integer,
    perito integer
);


ALTER TABLE public.tbescala OWNER TO postgres;

--
-- TOC entry 2785 (class 1259 OID 18350)
-- Dependencies: 2770 6
-- Name: tbescala_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbescala_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbescala_id_seq OWNER TO postgres;

--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 2785
-- Name: tbescala_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbescala_id_seq OWNED BY tbescala.id;


--
-- TOC entry 2771 (class 1259 OID 16570)
-- Dependencies: 6
-- Name: tbfolhaponto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbfolhaponto (
    he1 text,
    hs1 text,
    he2 text,
    hs2 text,
    ocorrencia text,
    abono text,
    hstra integer,
    hsextras integer,
    frequenciaint boolean,
    id bigint NOT NULL,
    usuario integer,
    data text
);


ALTER TABLE public.tbfolhaponto OWNER TO postgres;

--
-- TOC entry 2786 (class 1259 OID 18352)
-- Dependencies: 2771 6
-- Name: tbfolhaponto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbfolhaponto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbfolhaponto_id_seq OWNER TO postgres;

--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 2786
-- Name: tbfolhaponto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbfolhaponto_id_seq OWNED BY tbfolhaponto.id;


--
-- TOC entry 2772 (class 1259 OID 16576)
-- Dependencies: 6
-- Name: tbnoticias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbnoticias (
    id integer NOT NULL,
    titulo character varying(1000),
    descricao character varying(5000),
    usuario integer,
    data text,
    expira text
);


ALTER TABLE public.tbnoticias OWNER TO postgres;

--
-- TOC entry 2787 (class 1259 OID 18354)
-- Dependencies: 2772 6
-- Name: tbnoticias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbnoticias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbnoticias_id_seq OWNER TO postgres;

--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 2787
-- Name: tbnoticias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbnoticias_id_seq OWNED BY tbnoticias.id;


--
-- TOC entry 2773 (class 1259 OID 16582)
-- Dependencies: 6
-- Name: tbos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbos (
    id integer NOT NULL,
    dtabertura text,
    dtatribuicao text,
    dtfinalizacao text,
    dtaprovacao text,
    codigousuarioabriu integer,
    codigotipos integer,
    codigousuarioatendente integer,
    codigostatus integer,
    descricao text,
    conclusao text
);


ALTER TABLE public.tbos OWNER TO postgres;

--
-- TOC entry 2788 (class 1259 OID 18356)
-- Dependencies: 6 2773
-- Name: tbos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbos_id_seq OWNER TO postgres;

--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 2788
-- Name: tbos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbos_id_seq OWNED BY tbos.id;


--
-- TOC entry 2774 (class 1259 OID 16588)
-- Dependencies: 6
-- Name: tbpostos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbpostos (
    nome text,
    endereco text,
    bairro text,
    cidade text,
    estado character(2),
    tel text,
    esp text,
    id bigint NOT NULL
);


ALTER TABLE public.tbpostos OWNER TO postgres;

--
-- TOC entry 2789 (class 1259 OID 18358)
-- Dependencies: 6 2774
-- Name: tbpostos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbpostos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbpostos_id_seq OWNER TO postgres;

--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 2789
-- Name: tbpostos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbpostos_id_seq OWNED BY tbpostos.id;


--
-- TOC entry 2775 (class 1259 OID 16594)
-- Dependencies: 6
-- Name: tbusuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tbusuarios (
    id integer NOT NULL,
    nome text,
    senha text,
    codigo_tbusuarios integer,
    nomecp text,
    codigo_funcao integer,
    numero_sala text,
    lotacao integer,
    ramal integer,
    email text,
    matricula double precision,
    cargahoraria integer,
    foto bytea,
    admissao date,
    situacao boolean,
    classe integer,
    sexo boolean,
    banco text,
    agencia integer,
    conta bigint,
    telcasa text,
    cel1 text,
    cel2 text,
    cpf text
);


ALTER TABLE public.tbusuarios OWNER TO postgres;

--
-- TOC entry 2790 (class 1259 OID 18360)
-- Dependencies: 2775 6
-- Name: tbusuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tbusuarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tbusuarios_id_seq OWNER TO postgres;

--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 2790
-- Name: tbusuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tbusuarios_id_seq OWNED BY tbusuarios.id;


--
-- TOC entry 2776 (class 1259 OID 16600)
-- Dependencies: 6
-- Name: teste; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE teste (
    id bigint NOT NULL,
    dataespecial integer
);


ALTER TABLE public.teste OWNER TO postgres;

--
-- TOC entry 2791 (class 1259 OID 18362)
-- Dependencies: 2776 6
-- Name: teste_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE teste_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.teste_id_seq OWNER TO postgres;

--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 2791
-- Name: teste_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE teste_id_seq OWNED BY teste.id;


--
-- TOC entry 2777 (class 1259 OID 16603)
-- Dependencies: 6
-- Name: tipoordem; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipoordem (
    id integer NOT NULL,
    descricao text
);


ALTER TABLE public.tipoordem OWNER TO postgres;

--
-- TOC entry 2792 (class 1259 OID 18364)
-- Dependencies: 2777 6
-- Name: tipoordem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipoordem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tipoordem_id_seq OWNER TO postgres;

--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 2792
-- Name: tipoordem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipoordem_id_seq OWNED BY tipoordem.id;


--
-- TOC entry 3091 (class 2604 OID 18366)
-- Dependencies: 2779 2755
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE cargos ALTER COLUMN id SET DEFAULT nextval('cargos_id_seq'::regclass);


--
-- TOC entry 3092 (class 2604 OID 18367)
-- Dependencies: 2780 2756
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE classe ALTER COLUMN id SET DEFAULT nextval('classe_id_seq'::regclass);


--
-- TOC entry 3093 (class 2604 OID 18368)
-- Dependencies: 2781 2759
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE funcao ALTER COLUMN id SET DEFAULT nextval('funcao_id_seq'::regclass);


--
-- TOC entry 3094 (class 2604 OID 18369)
-- Dependencies: 2782 2761
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE lotacoes ALTER COLUMN id SET DEFAULT nextval('lotacoes_id_seq'::regclass);


--
-- TOC entry 3095 (class 2604 OID 18370)
-- Dependencies: 2783 2764
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE statusordem ALTER COLUMN id SET DEFAULT nextval('statusordem_codigo_seq'::regclass);


--
-- TOC entry 3096 (class 2604 OID 18371)
-- Dependencies: 2784 2769
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbdataespecial ALTER COLUMN id SET DEFAULT nextval('tbdataespecial_id_seq'::regclass);


--
-- TOC entry 3097 (class 2604 OID 18372)
-- Dependencies: 2785 2770
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbescala ALTER COLUMN id SET DEFAULT nextval('tbescala_id_seq'::regclass);


--
-- TOC entry 3098 (class 2604 OID 18373)
-- Dependencies: 2786 2771
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbfolhaponto ALTER COLUMN id SET DEFAULT nextval('tbfolhaponto_id_seq'::regclass);


--
-- TOC entry 3099 (class 2604 OID 18374)
-- Dependencies: 2787 2772
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbnoticias ALTER COLUMN id SET DEFAULT nextval('tbnoticias_id_seq'::regclass);


--
-- TOC entry 3100 (class 2604 OID 18375)
-- Dependencies: 2788 2773
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbos ALTER COLUMN id SET DEFAULT nextval('tbos_id_seq'::regclass);


--
-- TOC entry 3101 (class 2604 OID 18376)
-- Dependencies: 2789 2774
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbpostos ALTER COLUMN id SET DEFAULT nextval('tbpostos_id_seq'::regclass);


--
-- TOC entry 3102 (class 2604 OID 18377)
-- Dependencies: 2790 2775
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tbusuarios ALTER COLUMN id SET DEFAULT nextval('tbusuarios_id_seq'::regclass);


--
-- TOC entry 3103 (class 2604 OID 18378)
-- Dependencies: 2791 2776
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE teste ALTER COLUMN id SET DEFAULT nextval('teste_id_seq'::regclass);


--
-- TOC entry 3104 (class 2604 OID 18379)
-- Dependencies: 2792 2777
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE tipoordem ALTER COLUMN id SET DEFAULT nextval('tipoordem_id_seq'::regclass);


--
-- TOC entry 3106 (class 2606 OID 18383)
-- Dependencies: 2755 2755
-- Name: cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id);


--
-- TOC entry 3108 (class 2606 OID 18385)
-- Dependencies: 2756 2756
-- Name: classe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classe
    ADD CONSTRAINT classe_pkey PRIMARY KEY (id);


--
-- TOC entry 3110 (class 2606 OID 18387)
-- Dependencies: 2759 2759
-- Name: funcao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY funcao
    ADD CONSTRAINT funcao_pkey PRIMARY KEY (id);


--
-- TOC entry 3112 (class 2606 OID 18389)
-- Dependencies: 2760 2760
-- Name: horapadrao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY horapadrao
    ADD CONSTRAINT horapadrao_pkey PRIMARY KEY (id);


--
-- TOC entry 3114 (class 2606 OID 18391)
-- Dependencies: 2761 2761
-- Name: lotacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lotacoes
    ADD CONSTRAINT lotacoes_pkey PRIMARY KEY (id);


--
-- TOC entry 3116 (class 2606 OID 18393)
-- Dependencies: 2764 2764
-- Name: statusordem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY statusordem
    ADD CONSTRAINT statusordem_pkey PRIMARY KEY (id);


--
-- TOC entry 3118 (class 2606 OID 18395)
-- Dependencies: 2769 2769
-- Name: tbdataespecial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbdataespecial
    ADD CONSTRAINT tbdataespecial_pkey PRIMARY KEY (id);


--
-- TOC entry 3120 (class 2606 OID 18397)
-- Dependencies: 2770 2770
-- Name: tbescala_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbescala
    ADD CONSTRAINT tbescala_pkey PRIMARY KEY (id);


--
-- TOC entry 3122 (class 2606 OID 18399)
-- Dependencies: 2771 2771
-- Name: tbfolhaponto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbfolhaponto
    ADD CONSTRAINT tbfolhaponto_pkey PRIMARY KEY (id);


--
-- TOC entry 3124 (class 2606 OID 18401)
-- Dependencies: 2772 2772
-- Name: tbnoticias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbnoticias
    ADD CONSTRAINT tbnoticias_pkey PRIMARY KEY (id);


--
-- TOC entry 3126 (class 2606 OID 18403)
-- Dependencies: 2773 2773
-- Name: tbos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbos
    ADD CONSTRAINT tbos_pkey PRIMARY KEY (id);


--
-- TOC entry 3128 (class 2606 OID 18405)
-- Dependencies: 2774 2774
-- Name: tbpostos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbpostos
    ADD CONSTRAINT tbpostos_pkey PRIMARY KEY (id);


--
-- TOC entry 3130 (class 2606 OID 18407)
-- Dependencies: 2775 2775
-- Name: tbusuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tbusuarios
    ADD CONSTRAINT tbusuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 3133 (class 2606 OID 18409)
-- Dependencies: 2776 2776
-- Name: teste_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY teste
    ADD CONSTRAINT teste_pkey PRIMARY KEY (id);


--
-- TOC entry 3135 (class 2606 OID 18411)
-- Dependencies: 2777 2777
-- Name: tipoordem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipoordem
    ADD CONSTRAINT tipoordem_pkey PRIMARY KEY (id);


--
-- TOC entry 3131 (class 1259 OID 18412)
-- Dependencies: 2776
-- Name: fki_; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_ ON teste USING btree (dataespecial);


--
-- TOC entry 3136 (class 2606 OID 18413)
-- Dependencies: 2775 2760 3129
-- Name: horapadrao_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY horapadrao
    ADD CONSTRAINT horapadrao_id_fkey FOREIGN KEY (id) REFERENCES tbusuarios(id);


--
-- TOC entry 3137 (class 2606 OID 18418)
-- Dependencies: 3117 2776 2769
-- Name: teste_dataespecial_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teste
    ADD CONSTRAINT teste_dataespecial_fkey FOREIGN KEY (dataespecial) REFERENCES tbdataespecial(id);


--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 763
-- Name: dblink_connect_u(text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text) FROM postgres;
GRANT ALL ON FUNCTION dblink_connect_u(text) TO postgres;


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 765
-- Name: dblink_connect_u(text, text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM PUBLIC;
REVOKE ALL ON FUNCTION dblink_connect_u(text, text) FROM postgres;
GRANT ALL ON FUNCTION dblink_connect_u(text, text) TO postgres;


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 764
-- Name: pg_buffercache_pages(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION pg_buffercache_pages() FROM PUBLIC;
REVOKE ALL ON FUNCTION pg_buffercache_pages() FROM postgres;
GRANT ALL ON FUNCTION pg_buffercache_pages() TO postgres;


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 2762
-- Name: pg_buffercache; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pg_buffercache FROM PUBLIC;
REVOKE ALL ON TABLE pg_buffercache FROM postgres;
GRANT ALL ON TABLE pg_buffercache TO postgres;


-- Completed on 2010-05-06 00:47:18

--
-- PostgreSQL database dump complete
--

