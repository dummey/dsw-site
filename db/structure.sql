SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: ambassadors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ambassadors (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    company character varying NOT NULL,
    title character varying NOT NULL,
    location character varying NOT NULL,
    year integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    avatar character varying
);


--
-- Name: ambassadors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ambassadors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ambassadors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ambassadors_id_seq OWNED BY public.ambassadors.id;


--
-- Name: annual_schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.annual_schedules (
    id bigint NOT NULL,
    year integer,
    dates jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: annual_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.annual_schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annual_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.annual_schedules_id_seq OWNED BY public.annual_schedules.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attendee_goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendee_goals (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attendee_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attendee_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attendee_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attendee_goals_id_seq OWNED BY public.attendee_goals.id;


--
-- Name: attendee_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendee_messages (
    id bigint NOT NULL,
    subject character varying NOT NULL,
    body text NOT NULL,
    submission_id bigint NOT NULL,
    sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attendee_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attendee_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attendee_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attendee_messages_id_seq OWNED BY public.attendee_messages.id;


--
-- Name: clusters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clusters (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: clusters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clusters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clusters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clusters_id_seq OWNED BY public.clusters.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    user_id integer,
    submission_id integer,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: companies_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies_users (
    id bigint NOT NULL,
    company_id bigint,
    user_id bigint
);


--
-- Name: companies_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_users_id_seq OWNED BY public.companies_users.id;


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedback (
    id bigint NOT NULL,
    rating integer,
    comments text,
    submission_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint
);


--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- Name: general_inquiries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.general_inquiries (
    id integer NOT NULL,
    contact_name character varying(255),
    contact_email character varying(255),
    interest text,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    company character varying
);


--
-- Name: general_inquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.general_inquiries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: general_inquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.general_inquiries_id_seq OWNED BY public.general_inquiries.id;


--
-- Name: homepage_ctas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.homepage_ctas (
    id integer NOT NULL,
    title character varying NOT NULL,
    subtitle character varying NOT NULL,
    body character varying NOT NULL,
    link_text character varying NOT NULL,
    link_href character varying NOT NULL,
    relevant_to_cycle character varying,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    track_id bigint
);


--
-- Name: homepage_ctas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.homepage_ctas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: homepage_ctas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.homepage_ctas_id_seq OWNED BY public.homepage_ctas.id;


--
-- Name: newsletter_signups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newsletter_signups (
    id integer NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: newsletter_signups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newsletter_signups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsletter_signups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newsletter_signups_id_seq OWNED BY public.newsletter_signups.id;


--
-- Name: newsroom_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newsroom_items (
    id bigint NOT NULL,
    title character varying NOT NULL,
    attachment character varying,
    external_link character varying,
    is_active boolean DEFAULT true NOT NULL,
    release_date date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: newsroom_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newsroom_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsroom_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newsroom_items_id_seq OWNED BY public.newsroom_items.id;


--
-- Name: pitch_contest_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pitch_contest_entries (
    id bigint NOT NULL,
    video_url character varying,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    year integer,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: pitch_contest_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pitch_contest_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pitch_contest_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pitch_contest_entries_id_seq OWNED BY public.pitch_contest_entries.id;


--
-- Name: pitch_contest_votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pitch_contest_votes (
    id bigint NOT NULL,
    user_id bigint,
    pitch_contest_entry_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pitch_contest_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pitch_contest_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pitch_contest_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pitch_contest_votes_id_seq OWNED BY public.pitch_contest_votes.id;


--
-- Name: registration_attendee_goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registration_attendee_goals (
    id bigint NOT NULL,
    registration_id bigint NOT NULL,
    attendee_goal_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: registration_attendee_goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registration_attendee_goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registration_attendee_goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registration_attendee_goals_id_seq OWNED BY public.registration_attendee_goals.id;


--
-- Name: registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.registrations (
    id integer NOT NULL,
    user_id integer,
    year integer,
    contact_email character varying(255),
    zip character varying(255),
    original_company_name character varying(255),
    gender character varying(255),
    primary_role character varying(255),
    track_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    calendar_token character varying(255),
    age_range character varying,
    learn_more_pledge_1p boolean DEFAULT false NOT NULL,
    company_id bigint,
    coc_acknowledgement boolean DEFAULT false NOT NULL
);


--
-- Name: registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.registrations_id_seq OWNED BY public.registrations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sent_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sent_notifications (
    id integer NOT NULL,
    submission_id integer,
    kind character varying NOT NULL,
    recipient_email character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sent_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sent_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sent_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sent_notifications_id_seq OWNED BY public.sent_notifications.id;


--
-- Name: session_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.session_registrations (
    id integer NOT NULL,
    registration_id integer,
    submission_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: session_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.session_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: session_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.session_registrations_id_seq OWNED BY public.session_registrations.id;


--
-- Name: sponsor_signups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sponsor_signups (
    id integer NOT NULL,
    contact_name character varying(255),
    contact_email character varying(255),
    company character varying(255),
    interest text,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sponsor_signups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sponsor_signups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sponsor_signups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sponsor_signups_id_seq OWNED BY public.sponsor_signups.id;


--
-- Name: sponsorships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sponsorships (
    id bigint NOT NULL,
    name character varying NOT NULL,
    logo character varying,
    link_href character varying NOT NULL,
    description text,
    year integer NOT NULL,
    level character varying NOT NULL,
    track_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submission_id bigint
);


--
-- Name: sponsorships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sponsorships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sponsorships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sponsorships_id_seq OWNED BY public.sponsorships.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submissions (
    id integer NOT NULL,
    submitter_id integer,
    track_id integer,
    format character varying(255),
    location character varying(255),
    time_range character varying(255),
    title text,
    description text,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    contact_email character varying(255),
    estimated_size character varying(255),
    is_confirmed boolean DEFAULT false NOT NULL,
    is_public boolean DEFAULT true NOT NULL,
    venue_id integer,
    volunteers_needed integer,
    budget_needed integer,
    start_hour double precision DEFAULT 0 NOT NULL,
    end_hour double precision DEFAULT 0 NOT NULL,
    year integer,
    state character varying(255),
    start_day integer,
    end_day integer,
    internal_notes text,
    slides_url character varying,
    video_url character varying,
    cluster_id integer,
    original_company_name character varying,
    proposed_updates json,
    open_to_collaborators boolean,
    from_underrepresented_group boolean,
    target_audience_description text,
    cached_similar_item_ids integer[] DEFAULT '{}'::integer[],
    live_stream_url character varying,
    company_id bigint,
    coc_acknowledgement boolean DEFAULT false NOT NULL,
    pitch_qualifying boolean DEFAULT false NOT NULL,
    registrant_count integer DEFAULT 0 NOT NULL
);


--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: tracks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracks (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    icon character varying(255),
    email_alias character varying(255),
    display_order integer DEFAULT 0 NOT NULL,
    is_submittable boolean DEFAULT false NOT NULL,
    description text,
    color character varying,
    is_voteable boolean DEFAULT true NOT NULL,
    video_url character varying
);


--
-- Name: tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tracks_id_seq OWNED BY public.tracks.id;


--
-- Name: tracks_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tracks_users (
    track_id integer,
    user_id integer
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    uid character varying(255),
    name character varying(255),
    email character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    provider character varying(255),
    team_position character varying,
    avatar character varying,
    team_priority integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: venue_availabilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venue_availabilities (
    id bigint NOT NULL,
    venue_id bigint,
    submission_id bigint,
    year integer,
    day integer,
    time_block integer
);


--
-- Name: venue_availabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.venue_availabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venue_availabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.venue_availabilities_id_seq OWNED BY public.venue_availabilities.id;


--
-- Name: venues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venues (
    id integer NOT NULL,
    name character varying(255),
    description text,
    contact_name character varying(255),
    contact_email character varying(255),
    contact_phone character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address character varying(255),
    city character varying(255),
    state character varying(255),
    suite_or_unit character varying,
    seated_capacity integer DEFAULT 0,
    extra_directions text,
    company_id integer,
    standing_capacity integer DEFAULT 0,
    av_capabilities character varying
);


--
-- Name: venues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.venues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: venues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.venues_id_seq OWNED BY public.venues.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: volunteer_shifts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.volunteer_shifts (
    id integer NOT NULL,
    name character varying,
    day integer,
    start_hour double precision,
    end_hour double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    year integer,
    venue_id bigint
);


--
-- Name: volunteer_shifts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.volunteer_shifts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteer_shifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.volunteer_shifts_id_seq OWNED BY public.volunteer_shifts.id;


--
-- Name: volunteership_shifts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.volunteership_shifts (
    id bigint NOT NULL,
    volunteership_id bigint,
    volunteer_shift_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: volunteership_shifts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.volunteership_shifts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteership_shifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.volunteership_shifts_id_seq OWNED BY public.volunteership_shifts.id;


--
-- Name: volunteerships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.volunteerships (
    id integer NOT NULL,
    mobile_phone_number character varying,
    affiliated_organization character varying,
    user_id integer,
    year integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: volunteerships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.volunteerships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteerships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.volunteerships_id_seq OWNED BY public.volunteerships.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    user_id integer,
    submission_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: zip_decoding; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zip_decoding (
    zip character varying,
    city character varying,
    state character varying,
    lat numeric,
    long numeric
);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: ambassadors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ambassadors ALTER COLUMN id SET DEFAULT nextval('public.ambassadors_id_seq'::regclass);


--
-- Name: annual_schedules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annual_schedules ALTER COLUMN id SET DEFAULT nextval('public.annual_schedules_id_seq'::regclass);


--
-- Name: attendee_goals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendee_goals ALTER COLUMN id SET DEFAULT nextval('public.attendee_goals_id_seq'::regclass);


--
-- Name: attendee_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendee_messages ALTER COLUMN id SET DEFAULT nextval('public.attendee_messages_id_seq'::regclass);


--
-- Name: clusters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clusters ALTER COLUMN id SET DEFAULT nextval('public.clusters_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: companies_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_users ALTER COLUMN id SET DEFAULT nextval('public.companies_users_id_seq'::regclass);


--
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- Name: general_inquiries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_inquiries ALTER COLUMN id SET DEFAULT nextval('public.general_inquiries_id_seq'::regclass);


--
-- Name: homepage_ctas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.homepage_ctas ALTER COLUMN id SET DEFAULT nextval('public.homepage_ctas_id_seq'::regclass);


--
-- Name: newsletter_signups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_signups ALTER COLUMN id SET DEFAULT nextval('public.newsletter_signups_id_seq'::regclass);


--
-- Name: newsroom_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsroom_items ALTER COLUMN id SET DEFAULT nextval('public.newsroom_items_id_seq'::regclass);


--
-- Name: pitch_contest_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch_contest_entries ALTER COLUMN id SET DEFAULT nextval('public.pitch_contest_entries_id_seq'::regclass);


--
-- Name: pitch_contest_votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch_contest_votes ALTER COLUMN id SET DEFAULT nextval('public.pitch_contest_votes_id_seq'::regclass);


--
-- Name: registration_attendee_goals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_attendee_goals ALTER COLUMN id SET DEFAULT nextval('public.registration_attendee_goals_id_seq'::regclass);


--
-- Name: registrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations ALTER COLUMN id SET DEFAULT nextval('public.registrations_id_seq'::regclass);


--
-- Name: sent_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sent_notifications ALTER COLUMN id SET DEFAULT nextval('public.sent_notifications_id_seq'::regclass);


--
-- Name: session_registrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_registrations ALTER COLUMN id SET DEFAULT nextval('public.session_registrations_id_seq'::regclass);


--
-- Name: sponsor_signups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsor_signups ALTER COLUMN id SET DEFAULT nextval('public.sponsor_signups_id_seq'::regclass);


--
-- Name: sponsorships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsorships ALTER COLUMN id SET DEFAULT nextval('public.sponsorships_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: tracks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks ALTER COLUMN id SET DEFAULT nextval('public.tracks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: venue_availabilities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venue_availabilities ALTER COLUMN id SET DEFAULT nextval('public.venue_availabilities_id_seq'::regclass);


--
-- Name: venues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venues ALTER COLUMN id SET DEFAULT nextval('public.venues_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: volunteer_shifts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteer_shifts ALTER COLUMN id SET DEFAULT nextval('public.volunteer_shifts_id_seq'::regclass);


--
-- Name: volunteership_shifts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteership_shifts ALTER COLUMN id SET DEFAULT nextval('public.volunteership_shifts_id_seq'::regclass);


--
-- Name: volunteerships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteerships ALTER COLUMN id SET DEFAULT nextval('public.volunteerships_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Name: active_admin_comments admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: ambassadors ambassadors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ambassadors
    ADD CONSTRAINT ambassadors_pkey PRIMARY KEY (id);


--
-- Name: annual_schedules annual_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annual_schedules
    ADD CONSTRAINT annual_schedules_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attendee_goals attendee_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendee_goals
    ADD CONSTRAINT attendee_goals_pkey PRIMARY KEY (id);


--
-- Name: attendee_messages attendee_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendee_messages
    ADD CONSTRAINT attendee_messages_pkey PRIMARY KEY (id);


--
-- Name: clusters clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: companies_users companies_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies_users
    ADD CONSTRAINT companies_users_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: general_inquiries general_inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_inquiries
    ADD CONSTRAINT general_inquiries_pkey PRIMARY KEY (id);


--
-- Name: homepage_ctas homepage_ctas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.homepage_ctas
    ADD CONSTRAINT homepage_ctas_pkey PRIMARY KEY (id);


--
-- Name: newsletter_signups newsletter_signups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_signups
    ADD CONSTRAINT newsletter_signups_pkey PRIMARY KEY (id);


--
-- Name: newsroom_items newsroom_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsroom_items
    ADD CONSTRAINT newsroom_items_pkey PRIMARY KEY (id);


--
-- Name: pitch_contest_entries pitch_contest_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch_contest_entries
    ADD CONSTRAINT pitch_contest_entries_pkey PRIMARY KEY (id);


--
-- Name: pitch_contest_votes pitch_contest_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch_contest_votes
    ADD CONSTRAINT pitch_contest_votes_pkey PRIMARY KEY (id);


--
-- Name: registration_attendee_goals registration_attendee_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_attendee_goals
    ADD CONSTRAINT registration_attendee_goals_pkey PRIMARY KEY (id);


--
-- Name: registrations registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: sent_notifications sent_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT sent_notifications_pkey PRIMARY KEY (id);


--
-- Name: session_registrations session_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session_registrations
    ADD CONSTRAINT session_registrations_pkey PRIMARY KEY (id);


--
-- Name: sponsor_signups sponsor_signups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsor_signups
    ADD CONSTRAINT sponsor_signups_pkey PRIMARY KEY (id);


--
-- Name: sponsorships sponsorships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsorships
    ADD CONSTRAINT sponsorships_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: tracks tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: venue_availabilities venue_availabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venue_availabilities
    ADD CONSTRAINT venue_availabilities_pkey PRIMARY KEY (id);


--
-- Name: venues venues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: volunteer_shifts volunteer_shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteer_shifts
    ADD CONSTRAINT volunteer_shifts_pkey PRIMARY KEY (id);


--
-- Name: volunteership_shifts volunteership_shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteership_shifts
    ADD CONSTRAINT volunteership_shifts_pkey PRIMARY KEY (id);


--
-- Name: volunteerships volunteerships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteerships
    ADD CONSTRAINT volunteerships_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: fulltext_companies_name_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_companies_name_english ON public.companies USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: fulltext_submissions_description_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_submissions_description_english ON public.submissions USING gin (to_tsvector('english'::regconfig, description));


--
-- Name: fulltext_submissions_title_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_submissions_title_english ON public.submissions USING gin (to_tsvector('english'::regconfig, title));


--
-- Name: fulltext_users_name_english; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fulltext_users_name_english ON public.users USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: idx_companies_name_contains; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_companies_name_contains ON public.companies USING gin (name public.gin_trgm_ops);


--
-- Name: idx_submissions_description_contains; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submissions_description_contains ON public.submissions USING gin (description public.gin_trgm_ops);


--
-- Name: idx_submissions_title_contains; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_submissions_title_contains ON public.submissions USING gin (title public.gin_trgm_ops);


--
-- Name: idx_users_email_contains; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email_contains ON public.users USING gin (email public.gin_trgm_ops);


--
-- Name: idx_users_name_contains; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_name_contains ON public.users USING gin (name public.gin_trgm_ops);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON public.active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_admin_comments_on_namespace ON public.active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON public.active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_annual_schedules_on_year; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_annual_schedules_on_year ON public.annual_schedules USING btree (year);


--
-- Name: index_attendee_messages_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attendee_messages_on_submission_id ON public.attendee_messages USING btree (submission_id);


--
-- Name: index_comments_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_submission_id ON public.comments USING btree (submission_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_companies_on_lower_name_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_companies_on_lower_name_unique ON public.companies USING btree (lower((name)::text) varchar_pattern_ops);


--
-- Name: index_companies_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_companies_on_name ON public.companies USING btree (name);


--
-- Name: index_companies_users_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_users_on_company_id ON public.companies_users USING btree (company_id);


--
-- Name: index_companies_users_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_users_on_user_id ON public.companies_users USING btree (user_id);


--
-- Name: index_feedback_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feedback_on_submission_id ON public.feedback USING btree (submission_id);


--
-- Name: index_feedback_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_feedback_on_user_id ON public.feedback USING btree (user_id);


--
-- Name: index_homepage_ctas_on_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_homepage_ctas_on_track_id ON public.homepage_ctas USING btree (track_id);


--
-- Name: index_pitch_contest_votes_on_pitch_contest_entry_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pitch_contest_votes_on_pitch_contest_entry_id ON public.pitch_contest_votes USING btree (pitch_contest_entry_id);


--
-- Name: index_pitch_contest_votes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pitch_contest_votes_on_user_id ON public.pitch_contest_votes USING btree (user_id);


--
-- Name: index_registration_attendee_goals_on_attendee_goal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registration_attendee_goals_on_attendee_goal_id ON public.registration_attendee_goals USING btree (attendee_goal_id);


--
-- Name: index_registration_attendee_goals_on_registration_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registration_attendee_goals_on_registration_id ON public.registration_attendee_goals USING btree (registration_id);


--
-- Name: index_registrations_on_calendar_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_registrations_on_calendar_token ON public.registrations USING btree (calendar_token);


--
-- Name: index_registrations_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registrations_on_company_id ON public.registrations USING btree (company_id);


--
-- Name: index_registrations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_registrations_on_user_id ON public.registrations USING btree (user_id);


--
-- Name: index_sent_notifications_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sent_notifications_on_submission_id ON public.sent_notifications USING btree (submission_id);


--
-- Name: index_session_registrations_on_registration_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_session_registrations_on_registration_id ON public.session_registrations USING btree (registration_id);


--
-- Name: index_session_registrations_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_session_registrations_on_submission_id ON public.session_registrations USING btree (submission_id);


--
-- Name: index_sponsorships_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sponsorships_on_submission_id ON public.sponsorships USING btree (submission_id);


--
-- Name: index_sponsorships_on_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sponsorships_on_track_id ON public.sponsorships USING btree (track_id);


--
-- Name: index_submissions_on_cluster_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_cluster_id ON public.submissions USING btree (cluster_id);


--
-- Name: index_submissions_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_company_id ON public.submissions USING btree (company_id);


--
-- Name: index_submissions_on_submitter_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_submitter_id ON public.submissions USING btree (submitter_id);


--
-- Name: index_submissions_on_track_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_submissions_on_track_id ON public.submissions USING btree (track_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_venue_availabilities_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_venue_availabilities_on_submission_id ON public.venue_availabilities USING btree (submission_id);


--
-- Name: index_venue_availabilities_on_venue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_venue_availabilities_on_venue_id ON public.venue_availabilities USING btree (venue_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_type_and_item_id ON public.versions USING btree (item_type, item_id);


--
-- Name: index_volunteer_shifts_on_venue_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_volunteer_shifts_on_venue_id ON public.volunteer_shifts USING btree (venue_id);


--
-- Name: index_volunteership_shifts_on_volunteer_shift_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_volunteership_shifts_on_volunteer_shift_id ON public.volunteership_shifts USING btree (volunteer_shift_id);


--
-- Name: index_volunteership_shifts_on_volunteership_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_volunteership_shifts_on_volunteership_id ON public.volunteership_shifts USING btree (volunteership_id);


--
-- Name: index_volunteerships_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_volunteerships_on_user_id ON public.volunteerships USING btree (user_id);


--
-- Name: index_votes_on_submission_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_submission_id ON public.votes USING btree (submission_id);


--
-- Name: index_votes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_user_id ON public.votes USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON public.schema_migrations USING btree (version);


--
-- Name: registration_attendee_goals fk_rails_00326415bc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_attendee_goals
    ADD CONSTRAINT fk_rails_00326415bc FOREIGN KEY (registration_id) REFERENCES public.registrations(id);


--
-- Name: pitch_contest_votes fk_rails_051f1858c3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch_contest_votes
    ADD CONSTRAINT fk_rails_051f1858c3 FOREIGN KEY (pitch_contest_entry_id) REFERENCES public.pitch_contest_entries(id);


--
-- Name: venues fk_rails_077040617e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venues
    ADD CONSTRAINT fk_rails_077040617e FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: sponsorships fk_rails_10fd4596a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sponsorships
    ADD CONSTRAINT fk_rails_10fd4596a4 FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: volunteerships fk_rails_26e12c935b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteerships
    ADD CONSTRAINT fk_rails_26e12c935b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: registrations fk_rails_2e0658f554; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT fk_rails_2e0658f554 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feedback fk_rails_3ffcea2ae3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_rails_3ffcea2ae3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pitch_contest_votes fk_rails_4daa05456f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pitch_contest_votes
    ADD CONSTRAINT fk_rails_4daa05456f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: registrations fk_rails_4dafc7e520; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registrations
    ADD CONSTRAINT fk_rails_4dafc7e520 FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- Name: volunteership_shifts fk_rails_4deb72ee78; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteership_shifts
    ADD CONSTRAINT fk_rails_4deb72ee78 FOREIGN KEY (volunteership_id) REFERENCES public.volunteerships(id);


--
-- Name: attendee_messages fk_rails_555266c0e1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendee_messages
    ADD CONSTRAINT fk_rails_555266c0e1 FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: registration_attendee_goals fk_rails_7145612043; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.registration_attendee_goals
    ADD CONSTRAINT fk_rails_7145612043 FOREIGN KEY (attendee_goal_id) REFERENCES public.attendee_goals(id);


--
-- Name: feedback fk_rails_7c9bf47fa8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_rails_7c9bf47fa8 FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: volunteership_shifts fk_rails_8ff1f98788; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteership_shifts
    ADD CONSTRAINT fk_rails_8ff1f98788 FOREIGN KEY (volunteer_shift_id) REFERENCES public.volunteer_shifts(id);


--
-- Name: volunteer_shifts fk_rails_9c4ffa0245; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteer_shifts
    ADD CONSTRAINT fk_rails_9c4ffa0245 FOREIGN KEY (venue_id) REFERENCES public.venues(id);


--
-- Name: homepage_ctas fk_rails_d6aa0aad97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.homepage_ctas
    ADD CONSTRAINT fk_rails_d6aa0aad97 FOREIGN KEY (track_id) REFERENCES public.tracks(id);


--
-- Name: sent_notifications fk_rails_da20014dea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sent_notifications
    ADD CONSTRAINT fk_rails_da20014dea FOREIGN KEY (submission_id) REFERENCES public.submissions(id);


--
-- Name: submissions fk_rails_fdef407c4c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_fdef407c4c FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20130116164738'),
('20130116164739'),
('20130116164740'),
('20130116164741'),
('20130116164742'),
('20130116164743'),
('20130116164744'),
('20130116164745'),
('20130116164746'),
('20130116164747'),
('20130116164748'),
('20130117040102'),
('20130508051211'),
('20130511175418'),
('20130511175511'),
('20130512230944'),
('20130514013000'),
('20130528190244'),
('20130601210506'),
('20130621041352'),
('20130624052955'),
('20130624062458'),
('20130624062459'),
('20130624065911'),
('20130624155048'),
('20130624155135'),
('20130717031259'),
('20130717164913'),
('20130717170045'),
('20130718145826'),
('20130723182248'),
('20130730175935'),
('20130806165927'),
('20130813182826'),
('20130814182029'),
('20130814183554'),
('20130815173006'),
('20130815173041'),
('20130820015528'),
('20130901170747'),
('20130905145009'),
('20130905145241'),
('20131203145334'),
('20140415172844'),
('20140415173508'),
('20140429002904'),
('20140513155451'),
('20140526225628'),
('20140624165038'),
('20140718155905'),
('20140803222351'),
('20140803224445'),
('20140816164036'),
('20140908044535'),
('20140908045403'),
('20140908045735'),
('20140909151338'),
('20140912060222'),
('20140912062536'),
('20150811052343'),
('20160617045028'),
('20160619043445'),
('20160627234846'),
('20160628040744'),
('20160710013925'),
('20160719182417'),
('20160719182706'),
('20160720160503'),
('20160726164453'),
('20160802021908'),
('20160802040055'),
('20160802042349'),
('20160802043811'),
('20160802050802'),
('20160804150055'),
('20160823024038'),
('20160823024807'),
('20160823044119'),
('20160909225854'),
('20160912034451'),
('20170320052451'),
('20170713164355'),
('20170718164505'),
('20170720060259'),
('20170811224733'),
('20170814173357'),
('20170818174841'),
('20170822225752'),
('20170828185347'),
('20170828224353'),
('20170828225347'),
('20170828225639'),
('20170830195828'),
('20170906024523'),
('20170908145727'),
('20170911231704'),
('20170912152330'),
('20170912153018'),
('20170912155744'),
('20170915145833'),
('20170918194840'),
('20170918201311'),
('20170920024945'),
('20170925061912'),
('20171010165924'),
('20171018232858'),
('20171023230412'),
('20171023230539'),
('20171024210033'),
('20171029211526'),
('20171130230321'),
('20171212024445'),
('20180218043834'),
('20180218194540'),
('20180220163023'),
('20180316161624'),
('20180316194849'),
('20180321221958'),
('20180323161809'),
('20180330161739'),
('20180420151548'),
('20180503152209'),
('20180518145838'),
('20180527202206'),
('20180604045548'),
('20180718044128'),
('20180718045251'),
('20180718142543'),
('20180813001629'),
('20180910142243'),
('20180910175949'),
('20180916230057'),
('20180918152617'),
('20180919041913'),
('20180919042513'),
('20180919050424'),
('20180923214023'),
('20180924163222'),
('20180925205310'),
('20190221040025'),
('20190221064154');


