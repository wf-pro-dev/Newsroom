--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.9 (Ubuntu 16.9-0ubuntu0.24.04.1)

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: entity_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.entity_type AS ENUM (
    'article',
    'video'
);


ALTER TYPE public.entity_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articles (
    id integer NOT NULL,
    score double precision,
    question_id integer,
    api_source character varying(50),
    title character varying(255) NOT NULL,
    description text,
    content text,
    url text,
    "urlToImage" text,
    "publishedAt" timestamp without time zone
);


ALTER TABLE public.articles OWNER TO postgres;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.articles_id_seq OWNER TO postgres;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: fav_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fav_articles (
    id integer NOT NULL,
    score double precision,
    question_id integer,
    api_source character varying(50),
    title character varying(255) NOT NULL,
    description text,
    content text,
    url text,
    "urlToImage" text,
    "publishedAt" timestamp without time zone,
    article_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.fav_articles OWNER TO postgres;

--
-- Name: fav_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fav_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fav_articles_id_seq OWNER TO postgres;

--
-- Name: fav_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fav_articles_id_seq OWNED BY public.fav_articles.id;


--
-- Name: fav_videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fav_videos (
    id integer NOT NULL,
    question_id integer,
    youtube_id character varying(255) NOT NULL,
    description character varying(255),
    thumbnail character varying(255),
    video_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.fav_videos OWNER TO postgres;

--
-- Name: fav_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fav_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fav_videos_id_seq OWNER TO postgres;

--
-- Name: fav_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fav_videos_id_seq OWNED BY public.fav_videos.id;


--
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    entity_type public.entity_type NOT NULL
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- Name: favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favourites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favourites_id_seq OWNER TO postgres;

--
-- Name: favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favourites_id_seq OWNED BY public.favourites.id;


--
-- Name: hidden_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hidden_articles (
    article_id integer NOT NULL,
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.hidden_articles OWNER TO postgres;

--
-- Name: hidden_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hidden_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hidden_articles_id_seq OWNER TO postgres;

--
-- Name: hidden_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hidden_articles_id_seq OWNED BY public.hidden_articles.id;


--
-- Name: hidden_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hidden_questions (
    question_id integer NOT NULL,
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.hidden_questions OWNER TO postgres;

--
-- Name: hidden_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hidden_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hidden_questions_id_seq OWNER TO postgres;

--
-- Name: hidden_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hidden_questions_id_seq OWNED BY public.hidden_questions.id;


--
-- Name: hidden_videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hidden_videos (
    video_id integer NOT NULL,
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.hidden_videos OWNER TO postgres;

--
-- Name: hidden_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hidden_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hidden_videos_id_seq OWNER TO postgres;

--
-- Name: hidden_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hidden_videos_id_seq OWNED BY public.hidden_videos.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    topic_id integer,
    text character varying(255) NOT NULL,
    keywords character varying(255) NOT NULL,
    "order" integer NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: refresh; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh (
    question_id integer NOT NULL,
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.refresh OWNER TO postgres;

--
-- Name: refresh_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refresh_id_seq OWNER TO postgres;

--
-- Name: refresh_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_id_seq OWNED BY public.refresh.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    images character varying[]
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(120) NOT NULL,
    email character varying(120) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp without time zone,
    is_active boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videos (
    id integer NOT NULL,
    question_id integer,
    youtube_id character varying(255) NOT NULL,
    description character varying(255),
    thumbnail character varying(255)
);


ALTER TABLE public.videos OWNER TO postgres;

--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.videos_id_seq OWNER TO postgres;

--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: fav_articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_articles ALTER COLUMN id SET DEFAULT nextval('public.fav_articles_id_seq'::regclass);


--
-- Name: fav_videos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_videos ALTER COLUMN id SET DEFAULT nextval('public.fav_videos_id_seq'::regclass);


--
-- Name: favourites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites ALTER COLUMN id SET DEFAULT nextval('public.favourites_id_seq'::regclass);


--
-- Name: hidden_articles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_articles ALTER COLUMN id SET DEFAULT nextval('public.hidden_articles_id_seq'::regclass);


--
-- Name: hidden_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_questions ALTER COLUMN id SET DEFAULT nextval('public.hidden_questions_id_seq'::regclass);


--
-- Name: hidden_videos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_videos ALTER COLUMN id SET DEFAULT nextval('public.hidden_videos_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: refresh id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh ALTER COLUMN id SET DEFAULT nextval('public.refresh_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.articles (id, score, question_id, api_source, title, description, content, url, "urlToImage", "publishedAt") FROM stdin;
1	0	1	NewsAPI	Trump’s Order to Expand Logging Threatens to Increase Climate-Fueled Wildfires	The president’s push to expand timber and fossil fuel production “is a double whammy on the climate.”…	On March 1, President Donald Trump signed an executive order titled Immediate Expansion of American Timber Production. The order claimed onerous Federal policies have hindered domestic timber product… [+16173 chars]	https://truthout.org/articles/trumps-order-to-expand-logging-threatens-to-increase-climate-fueled-wildfires/	https://truthout.org/app/uploads/2025/05/GettyImages-1355168071-scaled.jpg	2025-05-17 15:17:23
2	0	2	NewsAPI	A vicious cycle: How methane emissions from warming wetlands could exacerbate climate change	The latest study finds that emissions of the potent greenhouse gas might be higher than previously estimated.	Warming in the Arctic is intensifying methane emissions, contributing to a vicious feedback loop that could accelerate climate change even more, according to a new study published May 7 in Nature."Me… [+5013 chars]	https://www.sciencedaily.com/releases/2025/05/250515191232.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-15 23:12:32
3	0	2	NewsAPI	Long Science in the Nevada Bristlecone Preserve	Ancient bristlecone pines have been collecting data for us for millennia.	It was at the invitation of The Long Now Foundation that I visited Mount Washington for the first time as a graduate student. Camping out the first night on the mountain with my kind and curious Long… [+10813 chars]	https://longnow.org/ideas/long-science-bristlecone-preserve-heggli/	https://static.longnow.org/2025/04/20240828_172054.jpg	2025-05-07 19:42:20
4	0	2	NewsDATA	Nepal urgently needs National Climate Change Assessments	Nepal is living with the climate crisis. Climate change is not a threat looming on the horizon; it is happening here, now and disproportionately affecting those least responsible f...	ONLY AVAILABLE IN PAID PLANS	https://thehimalayantimes.com/nepal/nepal-urgently-needs-national-climate-change-assessments	https://thehimalayantimes.com/thehimalayantimes/uploads/images/2025/05/24/39970.png	2025-05-24 10:12:16
5	0.2	3	NewsDATA	Deep discoveries, landmark lawsuits and rising renewables : Positive environmental stories from 2025	Eco anxiety is very real, so we share this year's most uplifting stories to prove there’s hope for our climate.	ONLY AVAILABLE IN PAID PLANS	https://www.euronews.com/green/2025/05/24/solar-grazing-tile-whipping-and-whisky-positive-environmental-stories-from-2025	https://static.euronews.com/articles/stories/09/01/94/72/1200x675_cmsv2_66c137b9-ab2e-5bef-9a2e-746ee715198f-9019472.jpg	2025-05-24 09:39:27
6	0	3	NewsAPI	EGU2025 - How the week in Vienna unfolded	Note: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia mentioned below, be released sometime after the conference ends, I'll include links to the ones I …	Posted on 2 May 2025 by BaerbelW\r\nNote: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia ment… [+32724 chars]	https://skepticalscience.com/egu25-personal-diary.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-02 06:23:14
7	0	3	NewsDATA	How Riviera Maya is battling 2025’s worst sargassum wave	In 2025, record sargassum levels are overwhelming the Riviera Maya. Tulum faces mounting environmental and economic challenges as communities and authorities fight to protect their shores.	ONLY AVAILABLE IN PAID PLANS	https://tulumtimes.com/how-riviera-maya-is-battling-2025s-worst-sargassum-wave/	https://tulumtimes.com/wp-content/uploads/2025/05/maxresdefault.jpg	2025-05-24 13:43:50
8	0	3	NewsDATA	Rules, Rates and Red Flags – What Every Small Carrier Needs to Watch Right Now	English Proficiency Enforcement Is Back — Here’s Why It Matters More Than You Think The Federal Motor Carrier Safety Administration is officially turning up the heat again on something that’s been quietly enforced for years: English language proficiency behind the wheel. This week, Sean Duffy, confirmed that the agency will be fully restoring enforcement of [...]The post Rules, Rates and Red Flags – What Every Small Carrier Needs to Watch Right Now appeared first on FreightWaves.	ONLY AVAILABLE IN PAID PLANS	https://www.freightwaves.com/news/rules-rates-and-red-flags-what-every-small-carrier-needs-to-watch-right-now	https://freightwaves.b-cdn.net/wp-content/uploads/2025/04/07/The-Playbook-Header-Image.png?height=748&width=1200	2025-05-23 21:41:09
9	0.167	4	NewsDATA	The Women Behind the Machines: Unsung Heroes of the AI Revolution	Women have shaped the foundations and ethics of AI as we know it today. While AI might seem like a modern marvel, its roots can be traced back to the 1800s. These women are rewriting the rules of what machines can learn.	ONLY AVAILABLE IN PAID PLANS	https://hackernoon.com/the-women-behind-the-machines-unsung-heroes-of-the-ai-revolution	https://hackernoon.com/https://cdn.hackernoon.com/images/2jqChkrv03exBUgkLrDzIbfM99q2-ew02vgl.jpeg	2025-05-24 01:00:02
10	0.08	4	NewsAPI	On The Up: The AI disruptors – Kiwis using new tech to boost their businesses and leading the way	We sound out some New Zealanders who have taken AI by the scruff of the neck.	The builder essentially becomes a robot, Zyte executive director Philip White told the Herald.\r\nA remote building inspector, using the Zyte AI, texts a link to the builder who can then open it withou… [+11266 chars]	https://www.nzherald.co.nz/business/on-the-up-the-ai-disruptors-kiwis-using-new-tech-to-boost-their-businesses-and-leading-the-way/GH2EAYLTBFGG7INQYTCQ2SR7KI/	https://www.nzherald.co.nz/resizer/v2/HKGGNEZPMVDBNB3PYHUXNYHPZM.jpg?auth=431068040989b60faf9e5a11978a7480aebf16818c4f47da9dbce66b3e2002ee&width=1200&height=675&quality=70&smart=true	2025-05-19 21:00:00
11	0.08	4	NewsAPI	SoundCloud changes policies to allow AI training on user content | TechCrunch	SoundCloud appears to have quietly changed its terms of use to allow the company to train AI on audio that users upload to its platform.	SoundCloud appears to have quietly changed its terms of use to allow the company to train AI on audio that users upload to its platform. \r\nAs spotted by tech ethicist Ed-Newton Rex, the latest versio… [+2375 chars]	https://techcrunch.com/2025/05/09/soundcloud-changes-policies-to-allow-ai-training-on-user-content/	https://techcrunch.com/wp-content/uploads/2024/05/Black-SoundCloud-Logo-Horizontal-1-1.jpg?w=1080	2025-05-09 17:20:49
12	0.08	4	NewsDATA	Are We Curating Artificial Psychopaths? Who Is Claude 4o	As AI models become more powerful their emergent behaviors can strike an unsettling chord. Optimization and ethics do not always match, and AI prioritizes the former.	ONLY AVAILABLE IN PAID PLANS	https://www.forbes.com/sites/corneliawalther/2025/05/24/are-we-curating-artificial-psychopaths-who-is-claude-4o/	https://imageio.forbes.com/specials-images/imageserve/6831e1f4d6ca137f595137e8/0x0.jpg?width=960	2025-05-24 15:18:24
13	0.08	4	NewsDATA	How the UK could monetise ‘citizen data’ and turn it into a national asset	A sovereign fund could ensure that public data is monetised ethically – with profits reinvested for the public good.	ONLY AVAILABLE IN PAID PLANS	https://theconversation.com/how-the-uk-could-monetise-citizen-data-and-turn-it-into-a-national-asset-256176	https://images.theconversation.com/files/669976/original/file-20250523-56-lyaheb.jpg?auto=format&fit=clip&ixlib=rb-4.1.0&q=45&rect=897%2C0%2C5694%2C3200&w=496	2025-05-23 16:00:36
14	0.08	4	NewsDATA	How The UK Could Monetise 'Citizen Data' And Turn It Into A National Asset #Monetise #'Citizen #Data' #Turn #Into #National #Asset #Apple #Samsung #Google #AI #Chat #GPT #Cyber #Security	(MENAFN - The Conversation)Data is the lifeblood of artificial intelligence (AI) and as such is a hugely valuable resource. Entrepreneur Matt Clifford's report on the AI Opportunities Action Plan , ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109588722/How-The-UK-Could-Monetise-Citizen-Data-And-Turn-It-Into-A-National-Asset?Social=on	https://menafn.com/updates/pr/2025-05/23/TC_fa45aimage_story_social.jpg	2025-05-23 15:09:02
15	0.08	4	NewsDATA	How The UK Could Monetise 'Citizen Data' And Turn It Into A National Asset	(MENAFN - The Conversation)Data is the lifeblood of artificial intelligence (AI) and as such is a hugely valuable resource. Entrepreneur Matt Clifford's report on the AI Opportunities Action Plan , ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109588722/How-The-UK-Could-Monetise-Citizen-Data-And-Turn-It-Into-A-National-Asset	https://menafn.com/updates/pr/2025-05/23/TC_fa45aimage_story.jpg	2025-05-23 15:09:02
16	0	4	NewsAPI	Trump Signs Bill Outlawing 'Revenge Porn'	US President Donald Trump signed a bill on Monday making it a federal crime to post "revenge porn" -- whether it is real or generated by artificial intelligence.	US President Donald Trump signed a bill on Monday making it a federal crime to post "revenge porn" -- whether it is real or generated by artificial intelligence.\r\nThe "Take It Down Act," passed with … [+3155 chars]	https://www.ibtimes.com/trump-signs-bill-outlawing-revenge-porn-3774031	https://d.ibtimes.com/en/full/4601860/us-president-donald-trump-looks-first-lady-melania-trump-speaks-signing-ceremony-take-it.jpg	2025-05-19 20:15:17
17	0	4	NewsAPI	Trump signs bill outlawing ‘revenge porn’	US President Donald Trump signed a bill on Monday making it a federal crime to post "revenge porn" -- whether it is real or generated by AI.\nThe post Trump signs bill outlawing ‘revenge porn’ appeared first on Digital Journal.	US President Donald Trump looks on as First Lady Melania Trump speaks at a signing ceremony of the "Take It Down Act" outlawing 'revenge porn' - Copyright GETTY IMAGES NORTH AMERICA/AFP/File Kent Nis… [+3398 chars]	https://www.digitaljournal.com/social-media/trump-signs-bill-outlawing-revenge-porn/article	https://www.digitaljournal.com/wp-content/uploads/2025/05/e0580de066c03f8e90b4b9f763c238e2c6b889e7.jpg	2025-05-19 20:47:49
18	0	4	NewsAPI	Trump signs bill outlawing ‘revenge porn’	US President Donald Trump signed a bill on Monday making it a federal crime to post “revenge porn” — whether it is real or generated by artificial intelligence. The “Take It Down Act,” passed with overwhelming bipartisan congressional support, criminalizes no…	US President Donald Trump looks on as First Lady Melania Trump speaks at a signing ceremony of the "Take It Down Act" outlawing 'revenge porn' - Copyright GETTY IMAGES NORTH AMERICA/AFP/File Kent Nis… [+3400 chars]	https://www.digitaljournal.com/world/trump-signs-bill-outlawing-revenge-porn/article	https://www.digitaljournal.com/wp-content/uploads/2025/05/e0580de066c03f8e90b4b9f763c238e2c6b889e7.jpg	2025-05-19 20:47:49
19	0	4	NewsAPI	Trump signs bill outlawing 'revenge porn'	US President Donald Trump signed a bill on Monday making it a federal crime to post "revenge porn" – whether it is real or generated by artificial intelligence. Read full story	WASHINGTON: US President Donald Trump signed a bill on Monday making it a federal crime to post "revenge porn" whether it is real or generated by artificial intelligence.\r\nThe "Take It Down Act," pas… [+3690 chars]	https://www.thestar.com.my/tech/tech-news/2025/05/20/trump-signs-bill-outlawing-039revenge-porn039	https://apicms.thestar.com.my/uploads/images/2025/05/20/3324369.jpg	2025-05-20 05:00:00
20	0.1	5	NewsDATA	Are We Curating Artificial Psychopaths? Who Is Claude 4o	As AI models become more powerful their emergent behaviors can strike an unsettling chord. Optimization and ethics do not always match, and AI prioritizes the former.	ONLY AVAILABLE IN PAID PLANS	https://www.forbes.com/sites/corneliawalther/2025/05/24/are-we-curating-artificial-psychopaths-who-is-claude-4o/	https://imageio.forbes.com/specials-images/imageserve/6831e1f4d6ca137f595137e8/0x0.jpg?width=960	2025-05-24 15:18:24
21	0.1	5	NewsDATA	How The UK Could Monetise 'Citizen Data' And Turn It Into A National Asset #Monetise #'Citizen #Data' #Turn #Into #National #Asset #Apple #Samsung #Google #AI #Chat #GPT #Cyber #Security	(MENAFN - The Conversation)Data is the lifeblood of artificial intelligence (AI) and as such is a hugely valuable resource. Entrepreneur Matt Clifford's report on the AI Opportunities Action Plan , ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109588722/How-The-UK-Could-Monetise-Citizen-Data-And-Turn-It-Into-A-National-Asset?Social=on	https://menafn.com/updates/pr/2025-05/23/TC_fa45aimage_story_social.jpg	2025-05-23 15:09:02
22	0.1	5	NewsDATA	How The UK Could Monetise 'Citizen Data' And Turn It Into A National Asset	(MENAFN - The Conversation)Data is the lifeblood of artificial intelligence (AI) and as such is a hugely valuable resource. Entrepreneur Matt Clifford's report on the AI Opportunities Action Plan , ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109588722/How-The-UK-Could-Monetise-Citizen-Data-And-Turn-It-Into-A-National-Asset	https://menafn.com/updates/pr/2025-05/23/TC_fa45aimage_story.jpg	2025-05-23 15:09:02
23	0	5	NewsAPI	Grok's 'white genocide' auto responses show AI chatbots can be tampered with 'at will'	Elon Musk's Grok chatbot is showing yet again why generative AI has a trust problem with users.	In the two-plus years since generative artificial intelligence took the the world by storm following the public release of ChatGPT, trust has been a perpetual problem.\r\nHallucinations, bad math and c… [+5838 chars]	https://www.cnbc.com/2025/05/17/groks-white-genocide-responses-show-gen-ai-tampered-with-at-will.html	https://image.cnbcfm.com/api/v1/image/108016215-1722867437958-gettyimages-1768220555-AA_07112023_1410544.jpeg?v=1747420824&w=1920&h=1080	2025-05-17 12:00:01
24	0	5	NewsDATA	How the UK could monetise ‘citizen data’ and turn it into a national asset	A sovereign fund could ensure that public data is monetised ethically – with profits reinvested for the public good.	ONLY AVAILABLE IN PAID PLANS	https://theconversation.com/how-the-uk-could-monetise-citizen-data-and-turn-it-into-a-national-asset-256176	https://images.theconversation.com/files/669976/original/file-20250523-56-lyaheb.jpg?auto=format&fit=clip&ixlib=rb-4.1.0&q=45&rect=897%2C0%2C5694%2C3200&w=496	2025-05-23 16:00:36
25	0.089	6	NewsAPI	On The Up: The AI disruptors – Kiwis using new tech to boost their businesses and leading the way	We sound out some New Zealanders who have taken AI by the scruff of the neck.	The builder essentially becomes a robot, Zyte executive director Philip White told the Herald.\r\nA remote building inspector, using the Zyte AI, texts a link to the builder who can then open it withou… [+11266 chars]	https://www.nzherald.co.nz/business/on-the-up-the-ai-disruptors-kiwis-using-new-tech-to-boost-their-businesses-and-leading-the-way/GH2EAYLTBFGG7INQYTCQ2SR7KI/	https://www.nzherald.co.nz/resizer/v2/HKGGNEZPMVDBNB3PYHUXNYHPZM.jpg?auth=431068040989b60faf9e5a11978a7480aebf16818c4f47da9dbce66b3e2002ee&width=1200&height=675&quality=70&smart=true	2025-05-19 21:00:00
26	0.089	6	NewsDATA	Are We Curating Artificial Psychopaths? Who Is Claude 4o	As AI models become more powerful their emergent behaviors can strike an unsettling chord. Optimization and ethics do not always match, and AI prioritizes the former.	ONLY AVAILABLE IN PAID PLANS	https://www.forbes.com/sites/corneliawalther/2025/05/24/are-we-curating-artificial-psychopaths-who-is-claude-4o/	https://imageio.forbes.com/specials-images/imageserve/6831e1f4d6ca137f595137e8/0x0.jpg?width=960	2025-05-24 15:18:24
27	0.089	6	NewsDATA	How The UK Could Monetise 'Citizen Data' And Turn It Into A National Asset #Monetise #'Citizen #Data' #Turn #Into #National #Asset #Apple #Samsung #Google #AI #Chat #GPT #Cyber #Security	(MENAFN - The Conversation)Data is the lifeblood of artificial intelligence (AI) and as such is a hugely valuable resource. Entrepreneur Matt Clifford's report on the AI Opportunities Action Plan , ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109588722/How-The-UK-Could-Monetise-Citizen-Data-And-Turn-It-Into-A-National-Asset?Social=on	https://menafn.com/updates/pr/2025-05/23/TC_fa45aimage_story_social.jpg	2025-05-23 15:09:02
28	0.089	6	NewsDATA	How The UK Could Monetise 'Citizen Data' And Turn It Into A National Asset	(MENAFN - The Conversation)Data is the lifeblood of artificial intelligence (AI) and as such is a hugely valuable resource. Entrepreneur Matt Clifford's report on the AI Opportunities Action Plan , ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109588722/How-The-UK-Could-Monetise-Citizen-Data-And-Turn-It-Into-A-National-Asset	https://menafn.com/updates/pr/2025-05/23/TC_fa45aimage_story.jpg	2025-05-23 15:09:02
29	0	6	NewsAPI	Everyone Is Cheating Their Way Through College	In only two years, ChatGPT and the surge of AI-generated cheating from college students it has created have unraveled the entire academic project.	Chungin Roy Lee stepped onto Columbia Universitys campus this past fall and, by his own admission, proceeded to use generative artificial intelligence to cheat on nearly every assignment. As a comput… [+31718 chars]	http://nymag.com/intelligencer/article/openai-chatgpt-ai-cheating-education-college-students-school.html	https://pyxis.nymag.com/v1/imgs/bed/906/0c7c764b8c807add6e1a8f638b43ce2029-chat-gpt-college-lede.1x.rsocial.w1200.gif	2025-05-07 09:00:23
30	0	6	NewsDATA	How the UK could monetise ‘citizen data’ and turn it into a national asset	A sovereign fund could ensure that public data is monetised ethically – with profits reinvested for the public good.	ONLY AVAILABLE IN PAID PLANS	https://theconversation.com/how-the-uk-could-monetise-citizen-data-and-turn-it-into-a-national-asset-256176	https://images.theconversation.com/files/669976/original/file-20250523-56-lyaheb.jpg?auto=format&fit=clip&ixlib=rb-4.1.0&q=45&rect=897%2C0%2C5694%2C3200&w=496	2025-05-23 16:00:36
31	0.089	8	NewsDATA	Trump’s team cited safety in limiting COVID shots. Patients, health advocates see more risk	Larry Saltzman has blood cancer. He’s also a retired doctor, so he knows getting COVID-19 could be dangerous for him — his underlying illness puts him at high risk of serious complications and death. To avoid getting sick, he stays away from large gatherings, and he’s comforted knowing healthy people who get boosters protect him by reducing his exposure to the virus. Until now, that is. ...	ONLY AVAILABLE IN PAID PLANS	https://www.courant.com/2025/05/24/trumps-team-cited-safety-in-limiting-covid-shots-patients-health-advocates-see-more-risk/	https://www.courant.com/wp-content/uploads/2025/05/202505231151MCT_____PHOTO____US-NEWS-HEALTH-COVID-VACCINES-CONCERNS-GET.jpg?strip=all&w=1400px	2025-05-24 10:00:19
32	0	8	NewsAPI	FLU SHOT BOMBSHELL: This yearâs jab actually INCREASES your risk of getting sick	Like nowhere else on Earth, in America, the medicine makes you sick and increases your risk of getting sick later from the infection the medicine is supposed to protect you against. Who believes in this “medicine” you might ask? Well, of course, that’s the pe…	Like nowhere else on Earth, in America, the medicine makes you sick and increases your risk of getting sick later from the infection the medicine is supposed to protect you against. Who believes in t… [+3599 chars]	https://www.naturalnews.com/2025-04-24-this-years-flu-shot-actually-increases-your-risk-of-getting-sick.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/04/Pregnant-Woman-Vaccine-Arm.jpg	2025-04-24 06:00:00
33	0	8	NewsAPI	Trump’s Team Cited Safety in Limiting Covid Shots. Patients, Health Advocates See More Risk.	The FDA will encourage new clinical trials on the widely used vaccines before approving them for children and healthy adults. The requirements could cost drugmakers tens of millions of dollars and are likely to leave boosters largely out of reach for hundreds…	Stephanie ArmourLarry Saltzman has blood cancer. He’s also a retired doctor, so he knows getting covid-19 could be dangerous for him his underlying illness puts him at high risk of serious complicati… [+10714 chars]	https://kffhealthnews.org/news/article/covid-vaccine-booster-shots-limits-trump-fda-rfk-prasad/	https://kffhealthnews.org/wp-content/uploads/sites/2/2025/05/GettyImages-1325050809-resized.jpg	2025-05-23 09:00:00
34	0	8	NewsAPI	BREAKING: HHS to End COVID-19 Vaccine Recommendations for Kids and Pregnant Women	According to the Wall Street Journal, the Trump administration—under the leadership of HHS Secretary Robert F. Kennedy Jr.—is preparing to end routine CDC recommendations that pregnant women, teenagers, and children receive COVID-19 vaccines. This decision, e…	According to the Wall Street Journal, the Trump administrationunder the leadership of HHS Secretary Robert F. Kennedy Jr.is preparing to end routine CDC recommendations that pregnant women, teenagers… [+5549 chars]	https://www.globalresearch.ca/hhs-end-covid-19-vaccine-recommendations-kids-pregnant/5887250	https://www.globalresearch.ca/wp-content/uploads/2023/06/rfkjr.jpg	2025-05-16 12:26:44
35	0	8	NewsAPI	A Devastating New Exposé of Johnson & Johnson Indicts an Entire System	If health care industry corruption and criminality were a city skyline, it would be booming, with tower cranes and half-built skyscrapers in every direction. Among the downtown giants at the center would stand Johnson & Johnson, an iconic U.S. company whose v…	Throughout this history, the question presents itself: Where the hell was the FDA?\r\nThroughout this history, the question presents itself: Where the hell was the FDA? Harris, to his great credit, nev… [+2887 chars]	https://newrepublic.com/article/194726/johnson-and-johnson-investigation-crimes-health-care-system	https://images.newrepublic.com/53a11cbfa4f53956960f52db71f824a3272d1d96.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-12 10:00:00
36	0	8	NewsDATA	Rajanarasimha Reviews Preparedness For Covid, Seasonal Diseases In Telangana	Telangana has adequate testing kits, medicines and testing facilities: Officials	ONLY AVAILABLE IN PAID PLANS	https://www.deccanchronicle.com/southern-states/telangana/rajanarasimha-reviews-preparedness-of-covid-seasonal-diseases-in-telangana-1881017	https://www.deccanchronicle.com/h-upload/2025/03/17/1899700-healthministerdamodarrajanarasimha.webp	2025-05-24 11:39:15
37	0	8	NewsDATA	COVID Vaccines Face Potential New Limits from Trump Administration	Despite the fact that vaccines against COVID have already undergone strict safety reviews and that people continue to die from the disease, Trump’s FDA is moving to reduce access to annual COVID boosters for healthy Americans	ONLY AVAILABLE IN PAID PLANS	https://www.scientificamerican.com/article/covid-vaccines-face-potential-new-limits-from-trump-administration/	https://static.scientificamerican.com/dam/m/54d5985fbfb691f6/original/Covid_Booster.jpg?m=1748006393.524&w=600	2025-05-23 13:30:00
38	0	8	NewsDATA	Trump’s team cited safety in limiting covid shots. patients, health advocates see more risk.	Larry Saltzman has blood cancer. He's also a retired doctor, so he knows getting covid-19 could be dangerous for him — his underlying illness puts him at high risk of serious complications and death.	ONLY AVAILABLE IN PAID PLANS	https://www.news-medical.net/news/20250523/Trumpe28099s-team-cited-safety-in-limiting-covid-shots-patients-health-advocates-see-more-risk.aspx	https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2016/3/Cancer_blood_5431357749be4138a37404d0991ed04a-620x480.jpg	2025-05-23 10:41:45
39	0	8	NewsDATA	Trump’s Team Cited Safety in Limiting Covid Shots. Patients, Health Advocates See More Risk.	The FDA will encourage new clinical trials on the widely used vaccines before approving them for children and healthy adults. The requirements could cost drugmakers tens of millions of dollars and are likely to leave boosters largely out of reach for hundreds of millions of Americans this fall.	ONLY AVAILABLE IN PAID PLANS	https://kffhealthnews.org/news/article/covid-vaccine-booster-shots-limits-trump-fda-rfk-prasad/	https://kffhealthnews.org/wp-content/uploads/sites/2/2025/05/GettyImages-1325050809-resized.jpg?w=1024	2025-05-23 09:00:00
40	0.333	9	NewsDATA	Elon Musk's X down for tens of thousands of users	Stephanie Venn-Watson studied longevity long before she realized it, she says. The veterinary epidemiologist was recruited by the U.S. Navy to take care of aging dolphins in 2001.Venn-Watson planned to research the dolphins to get a better understanding of infectious diseases, but “instead, very quickly pivoted to studying chronic diseases and diseases of aging,” which she’s done for more than 20 years, she told CNBC Make It in February.While dolphins in the wild typically live to around 20 years old, Navy dolphins were living much longer beyond the ages of 40 and 50, Venn-Watson says. Though some dolphins were developing conditions like chronic inflammation, high cholesterol and even changes in their brains similar to that of Alzheimer’s, others were completely healthy in old age.After analyzing thousands of samples collected over the span of about 50 years, Venn-Watson and her team were able to determine what the healthiest aging dolphins had in common. “We thought it was going to be omega-3′s, because all they eat are fish. And instead, it was C15:0, a saturated fatty acid I had never heard of,” she says.Venn-Watson and her team discovered a new essential fatty acid, C15:0, which like omega-3′s, can improve health outcomes in mammals. And additional research by experts outside of her team have supported this claim. Their discovery marks the “first essential fatty acid to be found in more than ninety years,” a finding which earned Venn-Watson a spot on CNBC’s 2025 Changemakers List earlier this year.With her husband, a Navy physician, Venn-Watson started Seraphina Therapeutics, and developed a C15:0 supplement for humans. She also published a book about her findings called “The Longevity Nutrient,” in March.To up her intake of the longevity nutrient in her own diet, Venn-Watson eats certain foods that are high in C15:0.Here’s the No. 1 food she eats to get more of the fatty acid.‘I’ll have a cheese snack almost every day’When Venn-Watson plans her meals, she always aims to maximize her intake of C15:0. “Key ways I do that are through grass-fed cheeses that come from grass-fed animals; those have some of the highest C15:0 levels,” she says.Often, it’s her daily snack that helps her increase how much of the longevity nutrient she’s getting: “I’ll have a cheese snack almost every day.”Pairing the grass-fed cheeses she eats with crackers helps her get yet another vital nutrient for her body: fiber.“We’ve also learned fiber has a lot of importance. So, classic cheese and crackers (high-fiber crackers, so not the ones that are chock full of processed carbs),” Venn-Watson says.“And pecorino, for example, has some of the highest nutritious content, including C15:0.”And though she discovered a new essential fatty acid, she still prioritizes the tried-and-true fatty acids like omega-3s. “My diet is high in fish. I probably have fish every day and dairy fat,” she says.In addition to the food she eats, Venn-Watson goes the extra mile to improve her health by taking certain vitamins: “I supplement with what the Navy invested 10 years in making, which is the pure C15:0 supplement.”Want to boost your confidence, income and career success? Take one (or more!) of Smarter by CNBC Make It’s expert-led online courses, which aim to teach you the critical skills you need to succeed that you didn’t learn in school. Topics include earning passive income online, mastering communication and public speaking skills, acing your job interview, and practical strategies to grow your wealth. Use coupon code MEMORIAL to purchase any course at a discount of 30% off the regular course price (plus tax). Offer valid from 12:00 am Eastern Time (“ET”) on May 19, 2025, through 11:59 pm ET on June 2, 2025. Terms and restrictions apply.Plus, sign up for CNBC Make It’s newsletter to get tips and tricks for success at work, with money and in life, and request to join our exclusive community on LinkedIn to connect with experts and peers.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcsandiego.com/news/business/money-report/elon-musks-x-down-for-tens-of-thousands-of-users/3833200/	https://media.nbcsandiego.com/2025/05/108148823-17478473902025-05-21t170638z_878539062_rc2gmea1h6up_rtrmadp_0_usa-safrica.jpeg?fit=1700%2C1000&quality=85&strip=all	2025-05-24 06:44:36
41	0.16	9	NewsAPI	RFK Jr. Misleads on Autism Prevalence, Causes	In announcing new autism prevalence data from the Centers for Disease Control and Prevention, Health and Human Services Secretary Robert F. Kennedy Jr. distorted scientific research to argue that there is an “epidemic” of autism that must be due to an "enviro…	Este artículo estará disponible en español en El Tiempo Latino.\r\nIn announcing new autism prevalence data from the Centers for Disease Control and Prevention, Health and Human Services Secretary Robe… [+22856 chars]	https://www.factcheck.org/2025/04/rfk-jr-misleads-on-autism-prevalence-causes/	https://cdn.factcheck.org/UploadedFiles/Kennedy-MMWR-720x307-1.jpg	2025-04-28 19:45:25
42	0.08	9	NewsAPI	HHS is weaponizing evidence-based medicine to falsely portray vaccines as unsafe	Last week, HHS announced that all "new vaccines will undergo safety testing in placebo-controlled trials." Sounds good? Not so fast. This is really a deceptive weaponization of evidence-based medicine to undermine confidence in vaccines and eliminate at least…	Having a man who has for the last two decades arguably been America’s most famous and intellectual antivax activist in charge of the Department of Health and Human Services (HHS) has been exhausting.… [+46033 chars]	https://sciencebasedmedicine.org/hhs-is-weaponizing-evidence-based-medicine-to-falsely-portray-vaccines-as-unsafe/	https://sciencebasedmedicine.org/wp-content/uploads/2017/04/EBMupdated.jpg	2025-05-05 07:00:00
43	0.08	9	NewsAPI	How Bad Could Measles Get This Year?	Experts explain the worst-cast scenario.	Sign up for the Slatest to get the most insightful analysis, criticism, and advice out there, delivered to your inbox daily.\r\nAs of this week, there are at least 800 cases of measles in the U.S. acro… [+10662 chars]	https://slate.com/technology/2025/04/measles-cases-epidemic-worst-case-vaccine.html	https://compote.slate.com/images/d22bea21-35e5-452e-b9e8-c85f3c691c45.gif?crop=780%2C520%2Cx0%2Cy0&width=1560	2025-04-24 14:00:00
44	0.08	9	NewsAPI	Pandemic preparedness: First Pandemic Treaty adopted	It’s only the second time the World Health Assembly has adopted a health treaty, but key details of this Pandemic Agreement remain unclear. An analysis. World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annua…	World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annual Assembly on Tuesday, May 20, after three years of protracted negotiations.\r\nIt's only the s… [+5484 chars]	https://www.dw.com/en/pandemic-preparedness-first-pandemic-treaty-adopted/a-72609575	https://static.dw.com/image/72607764_6.jpg	2025-05-20 12:43:00
45	0.08	9	NewsAPI	Shingles vaccine reduces risk of heart disease by 23%, study of one million people finds | CNN	A study of more than one million people found the shingles vaccine may lower the risk of heart disease and stroke for up to eight years after the shots.	Get inspired by a weekly roundup on living well, made simple. Sign up for CNNs Life, But Better newsletter for information and tools designed to improve your well-being.\r\nGetting the shingles vaccine… [+5372 chars]	https://www.cnn.com/2025/05/09/health/shingles-heart-disease-vaccine-shots-wellness	https://media.cnn.com/api/v1/images/stellar/prod/c-gettyimages-1294264405.jpg?c=16x9&q=w_800,c_fill	2025-05-09 12:14:18
56	0	9	NewsAPI	100 Days, 100 Small Victories	The political wins, works of art, and acts of defiance bringing us relief, joy, and even hope under Trump 2.0.	The first 100 days of Donald Trumps second term feel like theyve dragged on for an eternity, with each days news cycle bringing fresh hell to reckon with. But there is evidence of real political prog… [+43896 chars]	http://www.thecut.com/article/100-small-wins-worth-celebrating-from-trumps-first-100-days.html	https://pyxis.nymag.com/v1/imgs/7ed/97f/36fb7c053c757eda5ef6e72651d2854552-100-days-03.1x.rsocial.w1200.jpg	2025-04-30 17:15:46
57	0	9	NewsAPI	Lyme Disease Testing Practices, Wisconsin, USA, 2016–2019	Lyme Disease Testing Patterns, USA	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Lyme disease, a tickborne … [+8524 chars]	https://wwwnc.cdc.gov/eid/article/31/7/25-0009_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-05-22 04:00:00
46	0.08	9	NewsDATA	This doctor discovered ‘the longevity nutrient': The 1 food she always eats to be sure she gets enough of it	Roughly 25,000 users were reporting issues with Elon Musk’s X around 8:45 a.m. ET, according to analytics platform Downdetector. By around 9:55 a.m. the issue appeared to be mostly resolving, with around 2,000 users experiencing issues. Additional information on the cause or full extent of the outage was not immediately clear.The Elon Musk-owned social media platform X experienced a brief outage on Saturday morning, with tens of thousands of users reportedly unable to use the site.About 25,000 users reported issues with the platform, according to the analytics platform Downdetector, which gathers data from users to monitor issues with various platforms.Roughly 21,000 users reported issues just after 8:30 a.m. ET, per the analytics platform.The issues appeared to be largely resolved by around 9:55 a.m., when about 2,000 users were reporting issues with the platform. Harvard sues Trump administration over ban on international student enrollmentMusk’s DOGE expanding his Grok AI in U.S. government, raising conflict concernsTrump’s 5% NATO defense spending target ‘very difficult,’ Greece’s PM saysHarvard blocked by Trump administration from enrolling international studentsTrump recommends 50% tariff on European Union starting June 1Firm tapped to modify gift jet into AF1 settles false claims case for $62MSupreme Court insulates Fed board while backing Trump firing of agency leadersX did not immediately respond to CNBC’s request for comment. Additional information on the outage was not available.Musk, the billionaire owner of SpaceX and Tesla, acquired X, formerly known as Twitter in 2022.The site has had a number of widespread outages since the acquisition.The site experienced another outage in March, which Musk attributed at the time to a “massive cyberattack.”“We get attacked every day, but this was done with a lot of resources,” Musk wrote in a post at the time.This is breaking news. Check back for updates	ONLY AVAILABLE IN PAID PLANS	https://www.nbcphiladelphia.com/news/business/money-report/this-doctor-discovered-the-longevity-nutrient-the-1-food-she-always-eats-to-be-sure-she-gets-enough-of-it/4193423/	https://media.nbcphiladelphia.com/2025/05/108150032-1748013217519-gettyimages-640045312-smc050117-17.jpeg?fit=1700%2C1000&quality=85&strip=all	2025-05-24 10:00:01
47	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://www.citizentribune.com/news/business/fastest-growing-jobs-that-pay-over-100k/article_9cc8285f-20c1-5d90-bcf9-b54754752987.html	https://bloximages.newyork1.vip.townnews.com/citizentribune.com/content/tncms/assets/v3/editorial/b/b6/bb670b6c-56e2-5709-969e-32eb8281a1ac/683083846686f.image.png?resize=300%2C214	2025-05-23 17:30:00
48	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://winonadailynews.com/news/nation-world/business/personal-finance/article_c71d1e21-1dcc-58ac-9a1f-5e60a41462b6.html	https://bloximages.chicago2.vip.townnews.com/winonadailynews.com/content/tncms/assets/v3/editorial/f/4e/f4ed9cf4-8c34-5d56-8093-79cff43a9d4e/68308a50eaa19.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
49	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://scnow.com/news/nation-world/business/personal-finance/article_7837dd07-cf74-5e72-9dd6-6aa952004d00.html	https://bloximages.newyork1.vip.townnews.com/scnow.com/content/tncms/assets/v3/editorial/7/e8/7e82ef3c-a825-5911-ad08-00021f5f5b55/68308a29ce075.image.png?resize=300%2C214	2025-05-23 17:30:00
50	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://morganton.com/news/nation-world/business/personal-finance/article_ab42852b-ec39-54ca-8cb8-7a25cdd3da50.html	https://bloximages.newyork1.vip.townnews.com/morganton.com/content/tncms/assets/v3/editorial/6/c7/6c747c84-c50b-595c-9250-7a2eac129b9d/683089f6ec8cf.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
51	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://missoulian.com/news/nation-world/business/personal-finance/article_5fc145fb-b689-5fb6-af42-150bef2a95f9.html	https://bloximages.chicago2.vip.townnews.com/missoulian.com/content/tncms/assets/v3/editorial/c/29/c291394f-4073-5c45-8f1c-8babf752232b/683087d1003a7.image.png?resize=300%2C214	2025-05-23 17:30:00
52	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://herald-review.com/news/nation-world/business/personal-finance/article_ee29be2c-0e73-589e-8081-f856a5f98505.html	https://bloximages.chicago2.vip.townnews.com/herald-review.com/content/tncms/assets/v3/editorial/2/eb/2ebb5501-0b56-5942-ad0f-8bf49d1494f5/6830877c89d08.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
53	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://starexponent.com/news/nation-world/business/personal-finance/article_b7d81b64-3bc4-5fa2-bd9c-42106b2757c4.html	https://bloximages.newyork1.vip.townnews.com/starexponent.com/content/tncms/assets/v3/editorial/0/8c/08ca5a77-8a3c-5d08-8444-307179a8c8ff/683087abf2023.image.png?resize=300%2C214	2025-05-23 17:30:00
54	0.08	9	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://www.nwitimes.com/news/nation-world/business/personal-finance/article_5250bd7c-b7b4-5cb1-8877-a6c863b38235.html	https://bloximages.chicago2.vip.townnews.com/nwitimes.com/content/tncms/assets/v3/editorial/b/26/b26c1849-7a18-5672-9541-10338f0d11f3/683087a93a975.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
55	0	9	NewsAPI	Jonathan V. Last: MAHA Is a Fraud	Jonathan V. Last writes for and edits one of the liveliest and most informative sites on the Internet: The Bulwark. That is home base for a significant number of Republican Never Trumpers. In this post, he explains that Robert F. Kennedy Jr. is not only unqua…	Jonathan V. Last writes for and edits one of the liveliest and most informative sites on the Internet: The Bulwark. That is home base for a significant number of Republican Never Trumpers. In this po… [+7836 chars]	https://dianeravitch.net/2025/05/03/jonathan-v-last-maha-is-a-fraud/	https://ci3.googleusercontent.com/meips/ADKq_NYO49Ei6iFUozdT-G4miNt9joy4yM6FrK59I-OH0TV-238df1PSSK4xAlEjXporD63BgQVxRFlzD9TYeDvb5DdtVvcTLz8rGYsfX2RLVI7pZEtrGbCkiPZh2AMFsnOUiuytX5gYgYWJycuAvr00GZslYV9gVxFrVRnDJl8hE0NyC64jCkJBREHf1w4EItHLCy7uxFyj_W5Aj8HYmx3Wtxn9ew4IxqybjdKJTkH6cc4-3oVBeolBgGQvodxKx2mrbieK2hZ-pwdA6XMCWgVPA-S0HqOezbp_WNHC974_BlIapaGG5vwePYjcJXA4=s0-d-e1-ft#https://substackcdn.com/image/fetch/w_1100,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F72be2cde-3e51-4a32-9c2b-46b63a7cbb53_2100x1500.jpeg	2025-05-03 15:00:00
58	0	9	NewsAPI	Effects of Decentralized Sequencing on National Listeria monocytogenes Genomic Surveillance, Australia, 2016–2023	<em>Listeria monocytogenes</em> Surveillance, Australia	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Listeria monocytogenes is … [+21365 chars]	https://wwwnc.cdc.gov/eid/article/31/13/24-1357_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-05-06 04:00:00
59	0	9	NewsAPI	Estimation of Incubation Period for Oropouche Virus Disease among Travel-Associated Cases, 2024–2025	Incubation Period for Oropouche Virus Disease	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Oropouche virus disease (O… [+18511 chars]	https://wwwnc.cdc.gov/eid/article/31/7/25-0468_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-05-01 04:00:00
60	0.1	10	NewsAPI	Bitcoin Eyes $105K as Coinbase Surges 24%; Rally Has More Room, Says Analyst	The crypto rally has more room to run, but a short-term pullback is likely before new all-time highs, analysts said.	Bitcoin BTC\r\n$104,580.56 climbed back above $104,000 on Tuesday with welcome fresh inflation data, President Trump's bullish outlook on financial markets, and Coinbase's inclusion into the S&amp;P 50… [+3638 chars]	https://www.coindesk.com/markets/2025/05/13/bitcoin-eyes-105k-as-coinbase-surges-24-rally-has-more-room-says-analyst	https://cdn.sanity.io/images/s3y3vcno/production/6ebc4014f22e328c16d3bcaded87b327824160e0-2404x1352.jpg?auto=format	2025-05-13 20:22:47
61	0.1	10	NewsAPI	Refi Rates Ride High: Mortgage Refinance Rates on May 9, 2025	Multiple important refinance rates increased this week, but rates could trend down in the coming months.	Average mortgage refinance rates have been volleying between 6.5% and 7% as fears of both higher inflation and an economic slowdown play tug-of-war with financial markets. Overall, rates are too high… [+6697 chars]	https://www.cnet.com/personal-finance/mortgages/refi-rates-ride-high-mortgage-refinance-rates-on-may-9-2025/	https://www.cnet.com/a/img/resize/0856cfa69dcde6ae622f50cc7cefe60fb8b6358c/hub/2025/04/08/1e77bd7c-217d-4dc0-b49f-56074f0b9e25/top-story-57-scaled.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-09 08:00:00
62	0.1	10	NewsAPI	Bitcoin To $2.4 Million? ARK Invest Predicts Massive Surge By 2030	Ark Invest, a fund management company, has sharply raised its price forecasts for Bitcoin, predicting the cryptocurrency may reach $2.4 million at the end of 2030 in its most bullish scenario. The new target, set in an April 24 report by research analyst Davi…	Ark Invest, a fund management company, has sharply raised its price forecasts for Bitcoin, predicting the cryptocurrency may reach $2.4 million at the end of 2030 in its most bullish scenario.\r\nThe n… [+3202 chars]	https://bitcoinist.com/bitcoin-to-2-4-million-ark-invest-predicts-massive-surge-by-2030/	https://bitcoinist.com/wp-content/uploads/2025/04/a_926d1b.jpg	2025-04-26 03:00:41
63	0.1	10	NewsAPI	Microvast Reports First Quarter 2025 Financial Results	STAFFORD, Texas, May 12, 2025 (GLOBE NEWSWIRE) -- Microvast Holdings, Inc. (NASDAQ:MVST) (“Microvast” or the “Company”), a global leader in advanced battery technologies, announced today its unaudited condensed consolidated financial results for the first qua…	<ul><li>Record company Q1 revenue, increased 43.2% year over year to $116.5 million</li><li>Gross margin increased from 21.2% to 36.9%, a 15.7 percentage point improvement year over year</li></ul>STA… [+38029 chars]	https://www.globenewswire.com/news-release/2025/05/12/3079628/0/en/Microvast-Reports-First-Quarter-2025-Financial-Results.html	https://ml.globenewswire.com/Resource/Download/df776795-0f3f-47ee-8207-63d8c61b98bb	2025-05-12 21:00:00
64	0	10	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	Listen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, charm brac… [+12550 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o	https://ichef.bbci.co.uk/news/1024/branded_news/aae4/live/82babf60-2be4-11f0-8f57-b7237f6a66e6.png	2025-05-13 01:02:20
65	0	10	NewsAPI	Bitcoin and Gold in Sweet Spot as Bond Market 'Smackdown' Exposes the U.S. Fiscal Kayfabe: Godbole	Bond markets are challenging the illusion of U.S. fiscal stability and safe have status. BTC and gold stand to gain.	There is a popular saying, that goes, "If you want to understand America, watch a pro wrestling match." Though it may be glib and a little over simplified, it appears to 'ring' true, as the U.S. fina… [+6948 chars]	https://www.coindesk.com/markets/2025/05/20/bitcoin-and-gold-in-sweet-spot-as-bond-markets-expose-the-u-s-fiscal-kayfabe-omkar-godbole	https://cdn.sanity.io/images/s3y3vcno/production/ff3c70499ae43b758b532267871ef2682d7949ba-3936x2632.jpg	2025-05-20 07:52:52
66	0	10	NewsAPI	Trump’s Mineral Paradox	Without demand from clean energy, the U.S. market for rare earth, graphite, and lithium will falter.	Resources have always determined power. The British empire’s command over coal helped expand the realm to the ends of the earth. The United States entered World War II as a dominant oil power and for… [+8734 chars]	https://www.theatlantic.com/science/archive/2025/05/trumps-mineral-paradox/682675/	https://cdn.theatlantic.com/thumbor/iND4Ns5e9pxymlgrJB0kawaFNPc=/0x102:4792x2598/1200x625/media/img/mt/2025/05/2025_05_02_Trump_Minerals_1/original.jpg	2025-05-02 18:34:10
67	0	10	NewsAPI	Has The Stock Market Hit A Bottom In 2025?	Has the stock market bottomed in 2025? See what metrics to monitor in order to determine if the stock market has bottomed out this year.	The market has shown promising signs of bottoming, with sentiment reaching extreme pessimism and ... More valuations moderating to more reasonable levels.\r\ngetty\r\nAfter a turbulent start to 2025, inv… [+16095 chars]	https://www.forbes.com/sites/investor-hub/article/has-the-stock-market-hit-bottom-2025/	https://imageio.forbes.com/specials-images/imageserve/68224cebac1649661e2b3b01/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 16:21:03
68	0	10	NewsAPI	Nu Holdings Ltd. (NU): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Nu Holdings Ltd. (NYSE:NU) stands agai… [+7330 chars]	https://finance.yahoo.com/news/nu-holdings-ltd-nu-among-135947550.html	https://s.yimg.com/ny/api/res/1.2/ZYefRkClLLXcl7c848BAMg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD0xNjQz/https://media.zenfs.com/en/insidermonkey.com/7e0be664333815759bd72dc62b913ad8	2025-04-26 13:59:47
69	0	10	NewsAPI	Apple Stock Earnings Preview: Things To Consider Before The Next Report	Examine the key factors to watch before the next Apple earnings report to help you make informed decisions on AAPL.	Apple's upcoming earnings report arrives at a critical juncture, with solid company fundamentals ... More potentially overshadowed by escalating macroeconomic and geopolitical challenges.\r\nGetty Imag… [+13710 chars]	https://www.forbes.com/sites/investor-hub/article/apple-aapl-stock-earnings-things-to-consider/	https://imageio.forbes.com/specials-images/imageserve/6807ef026a2cb38c08b48c67/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 11:00:00
70	0	10	NewsAPI	3 Top Undervalued European Small Caps With Recent Insider Activity	As European markets experience a resurgence, with the STOXX Europe 600 Index climbing 3.44% and economic growth in the eurozone doubling its pace, investor...	As European markets experience a resurgence, with the STOXX Europe 600 Index climbing 3.44% and economic growth in the eurozone doubling its pace, investor confidence is on the rise despite lingering… [+6227 chars]	https://finance.yahoo.com/news/3-top-undervalued-european-small-053932134.html	https://media.zenfs.com/en/simply_wall_st__316/cb577674b7e557d971f138507100a6d5	2025-05-06 05:39:32
71	0	10	NewsAPI	Ryanair Annual Profit Drops 16% As Fares Fall	Irish no-frills carrier Ryanair on Monday said net profit fell 16 percent in its financial year as it cut ticket prices to boost passenger numbers.	Irish no-frills carrier Ryanair on Monday said net profit fell 16 percent in its financial year as it cut ticket prices to boost passenger numbers.\r\nProfit after tax slid to 1.61 billion euros ($1.8 … [+2615 chars]	https://www.ibtimes.com/ryanair-annual-profit-drops-16-fares-fall-3773950	https://d.ibtimes.com/en/full/4601710/ryanair-attributed-lower-fares-range-factors-including-tighter-consumer-budgets.jpg	2025-05-19 09:30:29
72	0	10	NewsAPI	Sony Q4 Earnings: Financial Unit Spin-Off, Stock Buyback, Cautious Outlook Amid Tariffs	PlayStation parent Sony Group Corp. (NYSE: SONY) reported its fiscal fourth-quarter 2024 results on Wednesday. The company reported a quarterly consolidated ...	PlayStation parent Sony Group Corp. (NYSE: SONY) reported its fiscal fourth-quarter 2024 results on Wednesday.\r\nThe company reported a quarterly consolidated sales decline of 24% year-on-year to $17.… [+3149 chars]	https://finance.yahoo.com/news/sony-q4-earnings-financial-unit-132114584.html	https://media.zenfs.com/en/Benzinga/582639cd2b3a192155ea75e9faa30c0f	2025-05-14 13:21:14
73	0	10	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	[BBC]\r\nListen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, cha… [+12593 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o?xtor=AL-72-%5Bpartner%5D-%5Byahoo.north.america%5D-%5Bheadline%5D-%5Bnews%5D-%5Bbizdev%5D-%5Bisapi%5D	https://s.yimg.com/ny/api/res/1.2/KCRZCNNpBtNpxCt2n0B3xw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/bbc_us_articles_995/4841ce513e08f2796e14f20ad698611f	2025-05-13 09:07:02
74	0	10	NewsAPI	GE Vernova To Navigate Tariffs, Analyst Sees Forex Gains Offsetting Headwinds	B Of A Securities analyst Andrew Obin revised the estimates upward for GE Vernova Inc. (NYSE:GEV) following the company’s first-quarter results reported on...	B Of A Securities analyst Andrew Obin revised the estimates upward for GE Vernova Inc. (NYSE:GEV) following the companys first-quarter results reported on Wednesday.\r\nThe company reported revenue gro… [+2157 chars]	https://finance.yahoo.com/news/ge-vernova-navigate-tariffs-analyst-205525104.html	https://media.zenfs.com/en/Benzinga/56631903749536cb131097ff888e2a56	2025-04-24 20:55:25
75	0	10	NewsAPI	Why Small Cap Stocks Are Ready For A Rebound	The market is priced at 21 times earnings. Small value stocks are priced at 13 times.	Miles Lewis, manager of the Royce Small Cap Total Return Fund, makes the case that at a time of turbulence in the economy, his quirky collection of small companies is equipped to beat the big names.\r… [+6580 chars]	https://www.forbes.com/sites/baldwin/2025/05/17/why-small-caps-are-ready-for-a-rebound/	https://imageio.forbes.com/specials-images/imageserve/6827695d8a826e0a79d03dcd/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-17 10:30:00
76	0	10	NewsAPI	SouthState Corporation (SSB): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where SouthState Corporation (NYSE:SSB) stan… [+7509 chars]	https://finance.yahoo.com/news/southstate-corporation-ssb-among-billionaire-132550791.html	https://s.yimg.com/ny/api/res/1.2/QQPNRdYCRNLGobJNbf0Dqw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/98a121cf46a23e51110a2810a51b79d1	2025-04-26 13:25:50
77	0	10	NewsAPI	Aon plc (AON): Among the Stocks Analysts Are Upgrading Today	We recently compiled a list of the 10 Stocks Analysts Are Upgrading Today. In this article, we are going to take a look at where Aon plc (NYSE:AON) stands...	We recently compiled a list of the 10 Stocks Analysts Are Upgrading Today. In this article, we are going to take a look at where Aon plc (NYSE:AON) stands against the other stocks analysts are upgrad… [+5559 chars]	https://finance.yahoo.com/news/aon-plc-aon-among-stocks-165404905.html	https://s.yimg.com/ny/api/res/1.2/esM0GiX.IlQyiELftPf6lA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/48687becb22102c151b18b57fabd44ea	2025-05-14 16:54:04
78	0	10	NewsAPI	Health Ranger Report: David Morgan elaborates on the U.S. dollar’s DECLINE and the rise of precious metals	David Morgan warns of the U.S. dollar’s decline, noting gold and silver have hit multi-year highs due to geopolitical instability (e.g., Iran’s leadership assassination). He cites silver surpassing $32.50/oz and potentially climbing further. Morgan advises do…	<ul><li>David Morgan warns of the U.S. dollar's decline, noting gold and silver have hit multi-year highs due to geopolitical instability (e.g., Iran's leadership assassination). He cites silver surp… [+7084 chars]	https://www.naturalnews.com/2025-05-07-david-morgan-dollar-decline-rise-precious-metals.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Inflation-dollar-hyperinflation-3.jpeg	2025-05-07 06:00:00
98	0	11	NewsAPI	Aussie broadband eyes growth with ‘Look to 28’	A key aspect of Aussie Broadband’s strategic ambition is to change its revenue mix, reducing its reliance on the residential segment and to grow other areas ...	Australias Aussie Broadband has unveiled its new Look to 28 strategy as part of its investor day, with the company outlining its bold vision for growth and diversification over the next three years.\r… [+4365 chars]	https://www.verdict.co.uk/aussie-broadband-growth-forecast/	https://media.zenfs.com/en/verdict_626/9e5c8126d7264da4a2a88d06bcc1f1b2	2025-05-08 09:06:21
79	0	10	NewsAPI	Forbes Daily: Trump Plays The Blame Game As U.S. GDP Slips	Today's Forbes Daily newsletter covers Etsy's tariff push, wealthiest in each US state, Tesla denies CEO search, Microsoft's profits, Ukraine minerals deal and more.	Despite reporting a negative first quarter, Etsy is crafting a message that it can stand out\r\n amid President Donald Trumps trade war.\r\nThe $4.4 billion marketplace for handmade and vintage goods fel… [+8963 chars]	https://www.forbes.com/sites/daniellechemtob/2025/05/01/forbes-daily-trump-plays-the-blame-game-as-us-gdp-slips/	https://imageio.forbes.com/specials-images/imageserve/68135fed64c0e32b01919f35/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 11:52:24
80	0.247	11	NewsDATA	Bitcoin Price Soars Past $108,000: What’s Driving This Powerful Rally?	BitcoinWorldBitcoin Price Soars Past $108,000: What’s Driving This Powerful Rally?Exciting times in the digital asset space! The Bitcoin price has just achieved a significant milestone, pushing past the $108,000 mark. This latest move is capturing the attention of investors and analysts worldwide, signaling strong momentum in the market. According to real-time monitoring data, the BTC price is currently trading around $108,009.99 on major exchanges [...]This post Bitcoin Price Soars Past $108,000: What’s Driving This Powerful Rally? first appeared on BitcoinWorld and is written by Editorial Team	ONLY AVAILABLE IN PAID PLANS	https://bitcoinworld.co.in/bitcoin-price-surges-rally/	https://bitcoinworld.co.in/wp-content/uploads/bitcoin-price-soars-past-108000-whats-driving-this-powerful-rally.png	2025-05-24 07:30:34
81	0.16	11	NewsAPI	Bitcoin Bulls Dominate Futures Market – $100K Level Now In Focus	Bitcoin is trading above $99,000 for the first time since February, signaling a surge in bullish momentum as price action pushes toward the long-awaited $100K milestone. After weeks of steady uptrend and tight consolidation beneath key resistance, BTC has fin…	Bitcoin is trading above $99,000 for the first time since February, signaling a surge in bullish momentum as price action pushes toward the long-awaited $100K milestone. After weeks of steady uptrend… [+4414 chars]	https://bitcoinist.com/bitcoin-bulls-dominate-futures-market-100k-level-now-in-focus/	https://bitcoinist.com/wp-content/uploads/2025/05/DALL·E-2025-05-08-05.21.33-A-financial-themed-image-showing-Bitcoin-BTC-futures-market-dominated-by-bullish-sentiment-with-the-100000-level-now-in-focus.-The-chart-displays.webp	2025-05-09 00:00:28
82	0.16	11	NewsAPI	Small business fundraising, US Education Secretary McMahon: Wealth	Wealth host Brad Smith is paying close attention to Wednesday morning's market moves (^DJI, ^IXIC, ^GSPC) while speaking to a variety of investing and...	It's time for Finance's market. Stocks are flipping around this morning. Some moving to the downside in the Nasdaq. S&amp;P is up. Investors looking for potential deceleration in the US-China trade w… [+47145 chars]	https://finance.yahoo.com/video/small-business-fundraising-us-education-163313387.html	https://s.yimg.com/ny/api/res/1.2/yZ8GIn3qteFlop4OtMtBQA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzY-/https://s.yimg.com/os/creatr-uploaded-images/2025-05/eb9ff970-2b60-11f0-aff0-e426a03df865	2025-05-07 16:33:13
83	0.08	11	NewsAPI	Grigory Burenkov: "The European Economy: A Soft Landing Amid Change"	The European Central Bank has cut interest rates for the seventh time, signaling continued monetary easing amid U.S. tariffs and global economic shifts. Explore the ECB's strategy, inflation trends, and what it means for Europe's economic outlook.	The European Central Bank (ECB) recently announced its seventh consecutive cut of key interest rates by 25 basis points. The deposit rate, which serves as the main benchmark of monetary policy, has r… [+7054 chars]	https://www.ibtimes.com/grigory-burenkov-european-economy-soft-landing-amid-change-3773818	https://d.ibtimes.com/en/full/4601352/grigory-burenkov.jpg	2025-05-16 22:31:18
84	0.08	11	NewsAPI	Ahead of Market: 10 things that will decide stock market action on Wednesday	Indian indices closed lower on Tuesday, with Sensex down 156 points and Nifty slipping 82 points, as losses in financial and pharma stocks offset select heavyweight gains.	The Indian stock market ended lower on Tuesday, as widespread losses in financial and pharma stocks eclipsed gains in Mahindra &amp; Mahindra, which surged on optimism over its earnings outlook, as w… [+4427 chars]	https://economictimes.indiatimes.com/markets/stocks/news/ahead-of-market-10-things-that-will-decide-stock-market-action-on-wednesday/articleshow/120937573.cms	https://img.etimg.com/thumb/msid-120937584,width-1200,height-630,imgsize-110642,overlay-etmarkets/articleshow.jpg	2025-05-06 15:34:10
85	0.08	11	NewsAPI	“The Money Trust”: “Creation of the Federal Reserve”. Richard C. cook	Serialization of selections from my book Our Country, Then and Now continues with the cooperation of my publisher, Clarity Press. Today we have the third installment of Chapter 9, “The Money Trust”: “The Creation of the Federal Reserve” — Part …\nThe post “The…	Serialization of selections from my book Our Country, Then and Nowcontinues with the cooperation of my publisher, Clarity Press. Today we have the third installment of Chapter 9, The Money Trust: The… [+16018 chars]	https://www.globalresearch.ca/money-trust-part-3-creation-federal-reserve/5887693	https://www.globalresearch.ca/wp-content/uploads/2017/03/US-Federal-Reserve.jpg	2025-05-20 10:52:28
86	0.08	11	NewsAPI	A World of Unintended Consequences	One of the great, underappreciated facts about our technology-driven age is that unintended consequences tend to outnumber intended ones. As much as we would like to believe that we are in control, scholars who have studied catastrophic failures have shown th…	One of the great, underappreciated facts about our technology-driven age is that unintended consequences tend to outnumber intended ones. As much as we would like to believe that we are in control, s… [+16355 chars]	https://www.project-syndicate.org/onpoint/technology-brings-more-unintended-consequences-than-intended-ones-by-edward-tenner-2025-04	https://webapi.project-syndicate.org/library/eb5bfaea9ea6cde7ef59f791f368b80a.2-1-super.1.jpg	2025-04-28 13:35:19
87	0.08	11	NewsAPI	What Wall Street is saying about Alphabet ahead of earnings	Alphabet (GOOGL), the parent company of Google, is scheduled to report first quarter 2025 results after the market close on Thursday, April 24, with a...	Alphabet (GOOGL), the parent company of Google, is scheduled to report first quarter 2025 results after the market close on Thursday, April 24, with a conference call scheduled for 4:30 pm Eastern Ti… [+12336 chars]	https://finance.yahoo.com/news/wall-street-saying-alphabet-ahead-152537404.html	https://media.zenfs.com/en/tipranks_452/d524a3ac9891a5b3f09a1e06f897f8d9	2025-04-25 15:25:37
99	0	11	NewsAPI	Trump radically remade the US food system in just 100 days	The people who grow and sell America's food no longer trust the USDA. We made a timeline to show you what happened.	This story is part of a Grist package examining how President Trump's first 100 days in office have reshaped climate and environmental policy in the U.S.\r\nDespite its widespread perception, the U.S. … [+23456 chars]	http://grist.org/food-and-agriculture/trump-usda-food-system-agriculture-first-100-days/	https://grist.org/wp-content/uploads/2025/05/GettyImages-2207588050.jpg?quality=75&strip=all	2025-05-02 08:45:00
88	0.08	11	NewsAPI	Share Market Highlights: Operation Sindoor jitters keep markets choppy; indices end slightly higher	Sensex, Nifty updates on May 7, 2025: Benchmark indices Sensex and Nifty ended slightly higher on Wednesday after a volatile trading session, as markets reacted to India’s missile strikes on terror hideouts in Pakistan and Pakistan-Occupied Kashmir under ‘Ope…	Stock Market on 7 May 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:25 | May 7, 2025The live blog is … [+59837 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-7-may-2025/article69545260.ece	https://bl-i.thgim.com/public/incoming/ewaeid/article69545290.ece/alternates/LANDSCAPE_1200/Stock%20market%20live%20today.jpg%20	2025-05-07 02:14:12
89	0.08	11	NewsAPI	Stock Market highlights 15 May 2025: Sensex settles 1,200 points higher, Nifty up 395 points at close	Stock Market Today | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets for 15 May 2025	<li></li>\r\n17:05 | May 15, 2025Stock market live updates today: Stock markets rally: Sensex jumps 1,200 points, Nifty reclaims 25000 peak after 7 months\r\nBenchmark BSE Sensex soared by 1,200 points, … [+82355 chars]	https://www.thehindubusinessline.com/markets/share-market-nifty-sensex-highlights-15-may-2025/article69575132.ece	https://bl-i.thgim.com/public/incoming/tmdf62/article69577694.ece/alternates/LANDSCAPE_1200/stock%20market%20graph.jpg	2025-05-15 01:05:39
90	0.08	11	NewsAPI	Share Market Highlights 21 May 2025: Sensex, Nifty break 3-day losing streak as banking stocks shine, Asian markets hold steady	Stock Market Highlights 21 May 2025: Benchmark stock indices Sensex and Nifty rebounded sharply on Wednesday, snapping their three-day falling streak on the back of buying in blue-chips HDFC Bank and ICICI Bank and a firm trend in Asian peers. The 30-share BS…	Stock Market today | Share Market Highlights - Find here all the highlights related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets for 21 May 2025 <li></li>\r\n16:11 | May 21, 2025St… [+68025 chars]	https://www.thehindubusinessline.com/markets/share-market-nifty-sensex-highlights-21-may-2025/article69598216.ece	https://bl-i.thgim.com/public/incoming/l3hjli/article69598256.ece/alternates/LANDSCAPE_1200/IMG_STOCK_MARKETS_DOWN_2_1_IODFL7QQ.jpg	2025-05-21 01:15:16
91	0.08	11	NewsAPI	Share Market Highlights: Sensex, Nifty decline sharply on Axis Bank slump and growing geopolitical tensions	Sensex, Nifty updates on 25 April 2025: Equity benchmark indices Sensex and Nifty saw significant losses on Friday, driven by a sharp decline in Axis Bank’s stock and rising geopolitical tensions following a terror attack in Jammu & Kashmir. The 30-share BSE …	Stock Market on 24 March 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:18 | April 25, 2025Share marke… [+51716 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-25-april-2025/article69486746.ece	https://bl-i.thgim.com/public/incoming/evr3cx/article69399116.ece/alternates/LANDSCAPE_1200/PO05_Stock_data.jpg	2025-04-25 01:07:08
92	0.08	11	NewsDATA	Trump threatens tariffs on Apple, European Union in trade war escalation	President Donald Trump threatened Friday to impose steep new tariffs on the Apple iPhone and all goods from the European Union, in a move that could put additional pressure on consumer prices and trigger new financial market upheaval if he...	ONLY AVAILABLE IN PAID PLANS	https://www.postguam.com/news/world/trump-threatens-tariffs-on-apple-european-union-in-trade-war-escalation/article_679b494a-d043-4579-8cff-82699c724fe1.html	https://bloximages.newyork1.vip.townnews.com/postguam.com/content/tncms/assets/v3/editorial/e/95/e95954c3-cfe1-4fd7-9216-56a122184e74/68312daacd91d.image.jpg?resize=400%2C267	2025-05-24 05:10:00
93	0	11	NewsAPI	New Nasdaq Rules Reshape The IPO Path For Microcap Companies	The U.S. Securities and Exchange Commission (SEC) has approved sweeping changes to the Nasdaq Capital Market listing standards.	Joseph Lucosky is the Managing Partner of Lucosky Brookman, a leading law firm in the world of microcap IPOs and Nasdaq/NYSE listings.\r\ngetty\r\nThe U.S. Securities and Exchange Commission (SEC) recent… [+6716 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/04/25/new-nasdaq-rules-reshape-the-ipo-path-for-microcap-companies/	https://imageio.forbes.com/specials-images/imageserve/674f57481dd3f3a70bc91311/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-25 20:24:05
94	0	11	NewsAPI	Robinhood Markets (HOOD) Thrives on Trump’s Trade War Turmoil in Q1	If Wednesday’s after-hours reaction is any indicator, Robinhood Markets (HOOD) bulls are a little disappointed. Heading into the first-quarter earnings...	If Wednesdays after-hours reaction is any indicator, Robinhood Markets (HOOD) bulls are a little disappointed. Heading into the first-quarter earnings report, options markets implied a move of much m… [+5615 chars]	https://finance.yahoo.com/news/robinhood-markets-hood-thrives-trump-083708018.html	https://media.zenfs.com/en/tipranks_452/15cc5f02a3f4ca75d7df8f899a7b3420	2025-05-02 08:37:08
95	0	11	NewsAPI	The Curious Case of the Hostile Takeover Bid by a Bank Facing Criminal Charges	Spain's BBVA, as a legal entity, and some of its former senior executives are facing prosecution on a number of charges, but it still wants to take over its third biggest rival. The ECB has already given its blessing.	Spain’s BBVA, as a legal entity, and some of its former senior executives are facing prosecution on a number of charges, but it still wants to take over its third biggest rival. The ECB has already g… [+16760 chars]	https://www.nakedcapitalism.com/2025/05/the-curious-case-of-a-hostile-takeover-by-a-spanish-bank-facing-criminal-prosecution-for-alleged-systemic-bribery-and-blackmail.html	https://www.reuters.com/graphics/BRV-BRV/dwpkkwznjpm/chart.png	2025-05-13 10:45:10
96	0	11	NewsAPI	Why the skies are grey at Hain Celestial	After the abrupt exit of its CEO, another set of disappointing results and a portfolio review, uncertainty hangs over the US food and drinks group.	When a companys share price tumbles more than 50% in the wake of a stock-exchange filing, its fair to say investor sentiment is less than positive. And there are a lot of questions hanging over US fo… [+9298 chars]	https://www.just-drinks.com/features/why-the-skies-are-grey-at-hain-celestial/	https://s.yimg.com/ny/api/res/1.2/6uku29suE.OIqiFf8kY6aA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzY-/https://media.zenfs.com/en/just_drinks_442/120a0b07f605ec090089fffce2952535	2025-05-08 13:12:25
97	0	11	NewsAPI	Why the skies are grey at Hain Celestial	After the abrupt exit of its CEO, another set of disappointing results and a portfolio review, uncertainty hangs over the US food and drinks group.	When a companys share price tumbles more than 50% in the wake of a stock-exchange filing, its fair to say investor sentiment is less than positive. And there are a lot of questions hanging over US fo… [+9296 chars]	https://www.just-food.com/features/why-the-skies-are-grey-at-hain-celestial/	https://s.yimg.com/ny/api/res/1.2/fpxT6.Lb9VLJhY7VSiDFpA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/just_food_692/95890f2db3581cbbcdc61f5015d5a752	2025-05-08 13:12:25
100	0.1	12	NewsAPI	RSAC highlights security markets in transition	As the RSAC 2025 Conference approaches, key themes are emerging that are set to dominate the world’s largest cybersecurity gathering. Industry dynamics are shifting rapidly – from AI enabling higher velocity threats, an intensified platform consolidation deba…	As the RSAC 2025 Conference approaches, key themes are emerging that are set to dominate the worlds largest cybersecurity gathering. Industry dynamics are shifting rapidly from AI enabling higher vel… [+34944 chars]	https://siliconangle.com/2025/04/26/rsac-highlights-security-markets-transition/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2025/04/rsac-dalle.png	2025-04-26 15:37:47
101	0.1	12	NewsAPI	Info Edge clocks 36% return on startup investments	‘Value creation through investing in tech-led and tech-enabled startups is scalable, sustainable and repeatable, gave the firm an edge as a tech operating company that very few others have’	Naukri.com parent Info Edge's long-term bets on Indian startups ranging from Zomato to Policybazaar, are yielding blockbuster returns of nearly 10 times and an estimated gross internal rate of return… [+5254 chars]	https://www.thehindubusinessline.com/companies/info-edge-clocks-36-return-on-startup-investments/article69563634.ece	https://bl-i.thgim.com/public/incoming/lhdxlj/article69556990.ece/alternates/LANDSCAPE_1200/PO04_Rupee.jpg	2025-05-11 09:00:18
102	0.1	12	NewsAPI	The clear business case for environmental sustainability	Environmental sustainability isn't just an exercise in 'doing good' -- it has a clear ROI. Here's how to get it.	The most successful companies recognize that sustainability initiatives can -- and must -- strengthen profitability, resilience and growth.\r\nIn an environment where regulatory support for sustainabil… [+7883 chars]	https://www.techtarget.com/sustainability/feature/The-clear-business-case-for-environmental-sustainability	https://www.techtarget.com/rms/onlineimages/money_g1144191163.jpg	2025-05-01 12:03:00
103	0.1	12	NewsAPI	Info Edge clocks 36% return on startup investments	Info Edge was one of the early backers in homegrown listed companies, including Zomato and Policybazaar. It invested a total of Rs 483.78 crore and Rs 591.40 crore in the two companies, respectively. The value of its shareholding in both the companies is coll…	Naukri.com parent Info Edge's long-term bets on Indian startups ranging from Zomato to Policybazaar, are yielding blockbuster returns of nearly 10 times and an estimated gross internal rate of return… [+5224 chars]	https://economictimes.indiatimes.com/tech/startups/info-edge-clocks-36-return-on-startup-investments/articleshow/121079020.cms	https://img.etimg.com/thumb/msid-121079033,width-1200,height-630,imgsize-595374,overlay-ettech/articleshow.jpg	2025-05-11 11:27:43
104	0.1	12	NewsDATA	Bitcoin (BTC) Reaches 112K New ATH This Week, But Ruvi AI (RUVI) Steals The Spotlight By Selling More Than 120+ Tokens Thanks To WEEX Exchange Collaboration	Bitcoin (BTC) reached an impressive record high close to $112,000, currently trading at $109,063. The rise reflects Bitcoin’s status as the leading cryptocurrency, driven by growing institutional adoption and optimism surrounding regulatory advances in crypto. While Bitcoin demonstrates its irreplaceable role in the financial ecosystem, a new opportunity emerges for investors seeking innovation and returns [...]The post Bitcoin (BTC) Reaches 112K New ATH This Week, But Ruvi AI (RUVI) Steals The Spotlight By Selling More Than 120+ Tokens Thanks To WEEX Exchange Collaboration appeared first on TechBullion.	ONLY AVAILABLE IN PAID PLANS	https://techbullion.com/bitcoin-btc-reaches-112k-new-ath-this-week-but-ruvi-ai-ruvi-steals-the-spotlight-by-selling-more-than-120-tokens-thanks-to-weex-exchange-collaboration/	https://techbullion.com/wp-content/uploads/2025/05/fi-112.jpg	2025-05-24 16:00:51
105	0.1	12	NewsDATA	6 Breakthrough Cryptocurrencies Changing the Game — Discover the Best Crypto to Buy Now	The recent surge in institutional adoption and clearer regulatory frameworks have sparked intense market movements. Headlines reveal new government partnerships, innovative blockchain integrations, and shifting market sentiments, prompting traders and analysts to identify the best crypto to buy now. Navigating this growing space requires focusing on projects that combine utility, innovation, and strong growth potential—precisely [...]The post 6 Breakthrough Cryptocurrencies Changing the Game — Discover the Best Crypto to Buy Now appeared first on Disrupt Africa.	ONLY AVAILABLE IN PAID PLANS	https://disruptafrica.com/2025/05/23/6-breakthrough-cryptocurrencies-changing-the-game-discover-the-best-crypto-to-buy-now/	https://i0.wp.com/disruptafrica.com/wp-content/uploads/2025/05/IMG-20250523-WA0019.jpg?fit=719%2C404&ssl=1	2025-05-23 21:44:44
106	0.1	12	NewsDATA	Analytica Revolutionizes Industry Decisions with Advanced Decision-Making Software	Image: https://lh7-rt.googleusercontent.com/docsz/AD_4nXcLzjEe-2KQ50b0aKwdumv3dloGJ3FGao7fm21Ok6v3VggEqL5ph7XLmorT4bh2KZSnpu2_3_ySq5RzkBk1xv_NXGbmEMsOkaM5S7nPzjGq7fNNBFsQ_VO7HeNY2J29H6A?key=KAEaFuqzfutnDfuQ0s2BFgOrganizations across all sectors leverage decision-making software to enhance efficiency, reduce risks, and gain a strategic advantage. From optimizing logistics to guiding medical diagnoses, decision-making software revolutionizes how individuals and businesses tackle complex choices. This article explores the various	ONLY AVAILABLE IN PAID PLANS	https://www.openpr.com/news/4034139/analytica-revolutionizes-industry-decisions-with-advanced	https://cdn.open-pr.com/5/2/523812276_g.jpg	2025-05-23 21:02:03
107	0.1	12	NewsDATA	Breaking Down Camping World Holdings: 8 Analysts Share Their Views	Analysts' ratings for Camping World Holdings (NYSE:CWH) over the last quarter vary from bullish to bearish, as provided by 8 analysts.The following table provides a quick overview of their recent ratings, highlighting the changing sentiments over the past 30 days and comparing them to the preceding months.BullishSomewhat BullishIndifferentSomewhat BearishBearishTotal Ratings24200Last 30D010001M Ago111002M Ago111003M Ago01000Insights from analysts' 12-month price targets are revealed, presenting an average target of $18.38, a high estimate of $22.00, and a low estimate of $15.00. Observing a downward trend, the current average is 17.39% lower than the prior average price target of $22.25. Investigating Analyst Ratings: An Elaborate StudyA clear picture of Camping World Holdings's perception among financial experts is painted with a thorough analysis of recent analyst actions. The summary below outlines key analysts, their recent evaluations, and adjustments to ratings and price targets.AnalystAnalyst FirmAction TakenRatingCurrent Price TargetPrior Price TargetNoah ZatzkinKeybancRaisesOverweight$18.00$16.00James HardimanCitigroupRaisesBuy$21.00$16.00Craig KennisonBairdLowersNeutral$15.00$18.00Ryan BrinkmanJP MorganLowersOverweight$21.00$23.00Jackson AderKeybancLowersOverweight$16.00$22.00Michael SwartzTruist SecuritiesLowersBuy$16.00$28.00Craig KennisonBairdLowersNeutral$18.00$28.00Noah ZatzkinKeybancLowersOverweight$22.00$27.00Key Insights:Action Taken: Analysts frequently update their recommendations based on evolving market conditions and company performance. Whether they 'Maintain', 'Raise' or 'Lower' their stance, it reflects their reaction to recent developments related to Camping World Holdings. This information provides a snapshot of how analysts perceive the current state of the company.Rating: Delving into assessments, analysts assign qualitative values, from 'Outperform' to 'Underperform'. These ratings communicate expectations for the relative performance of Camping World Holdings compared to the broader market.Price Targets: Analysts provide ...Full story available on Benzinga.com	ONLY AVAILABLE IN PAID PLANS	https://www.benzinga.com/insights/analyst-ratings/25/05/45593381/breaking-down-camping-world-holdings-8-analysts-share-their-views	https://cdn.benzinga.com/files/images/story/2023/analyst_ratings_image_4.png?auto=jpg&dpr=1&fit=crop&height=480&optimize=medium&width=720	2025-05-23 18:00:54
108	0	12	NewsAPI	KKR & Co. Inc. (KKR): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where KKR &amp; Co. Inc. (NYSE:KKR) stands a… [+7656 chars]	https://finance.yahoo.com/news/kkr-co-inc-kkr-among-140028374.html	https://s.yimg.com/ny/api/res/1.2/8taE7UVa..JXX21T_2uUvA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/8591b721983e13534e161de9a53ccbf6	2025-04-26 14:00:28
109	0	12	NewsAPI	Nu Holdings Ltd. (NU): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Nu Holdings Ltd. (NYSE:NU) stands agai… [+7330 chars]	https://finance.yahoo.com/news/nu-holdings-ltd-nu-among-135947550.html	https://s.yimg.com/ny/api/res/1.2/ZYefRkClLLXcl7c848BAMg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD0xNjQz/https://media.zenfs.com/en/insidermonkey.com/7e0be664333815759bd72dc62b913ad8	2025-04-26 13:59:47
110	0	12	NewsAPI	Plug Power Inc. (PLUG): Among Takeover Rumors Hedge Funds Are Buying	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Plug Power Inc. (NASDAQ:PLUG...	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Plug Power Inc. (NASDAQ:PLUG) stands against other takeover rumor stoc… [+6338 chars]	https://finance.yahoo.com/news/plug-power-inc-plug-among-132014431.html	https://s.yimg.com/ny/api/res/1.2/_QrgZGxugYSlQScGlOFVqw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/e7c1669c84b3f2c09c694d4c2541ad40	2025-04-24 13:20:14
111	0	12	NewsAPI	SouthState Corporation (SSB): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where SouthState Corporation (NYSE:SSB) stan… [+7509 chars]	https://finance.yahoo.com/news/southstate-corporation-ssb-among-billionaire-132550791.html	https://s.yimg.com/ny/api/res/1.2/QQPNRdYCRNLGobJNbf0Dqw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/98a121cf46a23e51110a2810a51b79d1	2025-04-26 13:25:50
112	0	12	NewsAPI	Powell Industries, Inc. (POWL): Among Louis Navellier’s Stock Picks with Huge Upside Potential	We recently published a list of Louis Navellier’s 10 Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Powell...	We recently published a list of Louis Navelliers 10 Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Powell Industries, Inc. (NASDAQ:POWL) stands against … [+7749 chars]	https://finance.yahoo.com/news/powell-industries-inc-powl-among-140038815.html	https://s.yimg.com/ny/api/res/1.2/j0VSfrl8TJJOXuV25saUxQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/e3c49db56ef5b158e645246e8bb41283	2025-04-24 14:00:38
113	0	12	NewsAPI	Old Second Bancorp, Inc. (OSBC): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Old Second Bancorp, Inc. (NASDAQ:OSBC)… [+7581 chars]	https://finance.yahoo.com/news/old-second-bancorp-inc-osbc-132300347.html	https://s.yimg.com/ny/api/res/1.2/B_UOJObRWK8QhdTeTnoPtA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/993ac3d1b5801c22f2e8dab2e1c0bf9d	2025-04-26 13:23:00
114	0	12	NewsAPI	Origin Bancorp, Inc. (OBK): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Origin Bancorp, Inc. (NYSE:OBK) stands… [+7307 chars]	https://finance.yahoo.com/news/origin-bancorp-inc-obk-among-133053907.html	https://media.zenfs.com/en/insidermonkey.com/1ccc3f97973fd105548bca9ede345512	2025-04-26 13:30:53
115	0	12	NewsAPI	ETMarkets Smart Talk: Ambit prefers bonds over equities in 2025; suggests 75:25 asset allocation	As a result, we believe that markets can remain volatile due to external factors (tariff war & India-Pakistan conflict) in the near-term, but expect fundamentals i.e., earnings & GDP growth to drive returns over the long-term.	In this edition of ETMarkets Smart Talk, we speak with Nitin Bhasin, Head of Institutional Equities at Ambit, and Bharat Arora, Analyst Strategy at Ambit Capital, to decode the evolving market landsc… [+7163 chars]	https://economictimes.indiatimes.com/markets/expert-view/etmarkets-smart-talk-ambit-prefers-bonds-over-equities-in-2025-suggests-7525-asset-allocation/articleshow/121180068.cms	https://img.etimg.com/thumb/msid-121180124,width-1200,height-630,imgsize-75656,overlay-etmarkets/articleshow.jpg	2025-05-16 03:31:00
116	0	12	NewsAPI	ETMarkets Smart Talk: Ambit prefers bonds over equities in 2025; suggests 75:25 asset allocation	As a result, we believe that markets can remain volatile due to external factors (tariff war & India-Pakistan conflict) in the near-term, but expect fundamentals i.e., earnings & GDP growth to drive returns over the long-term.	In this edition of ETMarkets Smart Talk, we speak with Nitin Bhasin, Head of Institutional Equities at Ambit, and Bharat Arora, Analyst Strategy at Ambit Capital, to decode the evolving market landsc… [+7163 chars]	https://economictimes.indiatimes.com/markets/expert-view/etmarkets-smart-talk-ambit-prefers-bonds-over-equities-in-2025-suggests-7525-asset-allocation/articleshow/121203675.cms	https://img.etimg.com/thumb/msid-121180124,width-1200,height-630,imgsize-75656,overlay-etmarkets/articleshow.jpg	2025-05-16 03:31:00
136	0.185	14	NewsAPI	How Donald Trump Upended US Foreign Policy in 100 Days	"It's been one of the most exciting starts to a new presidential term since Gorbachev," academic Barry Scott Zellen told Newsweek.	President Donald Trump is "redrawing the world map" with his foreign policy, driven by his "America first" stance, his anti-globalist position, his "like" for provoking America's allies and his desir… [+10883 chars]	https://www.newsweek.com/donald-trump-foreign-policy-100-days-2064942	https://d.newsweek.com/en/full/2626627/trump-upended-foreign-policy-100-days.png	2025-04-29 11:38:26
117	0	12	NewsAPI	Share Market Highlights: Operation Sindoor jitters keep markets choppy; indices end slightly higher	Sensex, Nifty updates on May 7, 2025: Benchmark indices Sensex and Nifty ended slightly higher on Wednesday after a volatile trading session, as markets reacted to India’s missile strikes on terror hideouts in Pakistan and Pakistan-Occupied Kashmir under ‘Ope…	Stock Market on 7 May 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:25 | May 7, 2025The live blog is … [+59837 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-7-may-2025/article69545260.ece	https://bl-i.thgim.com/public/incoming/ewaeid/article69545290.ece/alternates/LANDSCAPE_1200/Stock%20market%20live%20today.jpg%20	2025-05-07 02:14:12
118	0	12	NewsAPI	U.S. Global Investors Reports Results for the Third Quarter of 2025 Fiscal Year, Initiates Strategy to Increase Its Investment in the Bitcoin Ecosystem	SAN ANTONIO, May 08, 2025 (GLOBE NEWSWIRE) -- U.S. Global Investors, Inc. (NASDAQ: GROW) (the "Company"), a registered investment advisory firm1 with longstanding experience in global markets and specialized sectors, today reported operating revenues of $2.1 …	SAN ANTONIO, May 08, 2025 (GLOBE NEWSWIRE) -- U.S. Global Investors, Inc. (NASDAQ: GROW) (the "Company"), a registered investment advisory firm1 with longstanding experience in global markets and spe… [+18499 chars]	https://www.globenewswire.com/news-release/2025/05/08/3077865/0/en/U-S-Global-Investors-Reports-Results-for-the-Third-Quarter-of-2025-Fiscal-Year-Initiates-Strategy-to-Increase-Its-Investment-in-the-Bitcoin-Ecosystem.html	https://ml.globenewswire.com/Resource/Download/35fd06bc-7d2b-457d-8c85-67241c98565c	2025-05-08 21:39:00
119	0	12	NewsAPI	Stock Market highlights 15 May 2025: Sensex settles 1,200 points higher, Nifty up 395 points at close	Stock Market Today | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets for 15 May 2025	<li></li>\r\n17:05 | May 15, 2025Stock market live updates today: Stock markets rally: Sensex jumps 1,200 points, Nifty reclaims 25000 peak after 7 months\r\nBenchmark BSE Sensex soared by 1,200 points, … [+82355 chars]	https://www.thehindubusinessline.com/markets/share-market-nifty-sensex-highlights-15-may-2025/article69575132.ece	https://bl-i.thgim.com/public/incoming/tmdf62/article69577694.ece/alternates/LANDSCAPE_1200/stock%20market%20graph.jpg	2025-05-15 01:05:39
120	0.229	13	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
121	0.114	13	NewsDATA	UBS Asian Investment Conference in Hong Kong to feature Simone Biles and Maria Konnikova	Speakers at the Hong Kong conference next week are expected to discuss economics, trade and political uncertainties Read full story	ONLY AVAILABLE IN PAID PLANS	https://www.thestar.com.my/aseanplus/aseanplus-news/2025/05/24/ubs-asian-investment-conference-in-hong-kong-to-feature-simone-biles-and-maria-konnikova	https://apicms.thestar.com.my/uploads/images/2025/05/24/3330121.jpg	2025-05-24 10:52:00
122	0.114	13	NewsDATA	G7 takes aim at China: World’s richest nations unite to crush unfair trade tactics	BANFF, Alberta: Financial policymakers from the seven well-heeled economies of the world clinched a two-day high-level meeting in the Canadian Rockies with a skillfully crafted treaty to deal with the world’s “economic imbalances”—an initiative broadly understood as an understated condemnation of China’s trade policies. According to the latest Yahoo Finance report, while U.S. tariffs and [...]The post G7 takes aim at China: World’s richest nations unite to crush unfair trade tactics appeared first on The Independent Singapore News - Latest Breaking News	ONLY AVAILABLE IN PAID PLANS	https://theindependent.sg/g7-takes-aim-at-china-worlds-richest-nations-unite-to-crush-unfair-trade-tactics/	https://media.theindependent.sg/wp-content/uploads/2025/02/8384.jpg	2025-05-23 09:39:37
123	0	13	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
124	0	13	NewsAPI	China’s Mega Dam Project Poses Big Risks for Asia’s Grand Canyon	China’s plans to build a massive hydro project in Tibet have sparked fears about the environmental impacts on the world’s longest and deepest canyon. It has also alarmed neighboring India, which fears that China could hold back or even weaponize river water i…	China has announced plans to build the worlds largest hydroelectric project at a remote river gorge in eastern Tibet, an ecological treasure trove close to a disputed border with India. Indian politi… [+12440 chars]	https://e360.yale.edu/features/china-tibet-yarlung-tsangpo-dam-india-water	https://yale-threesixty.transforms.svdcdn.com/production/Doxong-Pass_Alamy-HEADER.jpg?w=1200&q=60&auto=format&fit=max&dm=1747304219&s=d8af4146a9bdb36bac3a02200c2dc4c0	2025-05-14 14:35:00
125	0	13	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
147	0.1	15	NewsAPI	Joseph Nye Was the Champion of a World That No Longer Exists	The distinguished scholar, who coined “soft power,” shaped five decades of U.S. foreign policy.	It is poignant yet perhaps fitting to mourn Joseph Nye, the distinguished international relations scholar, just as his lifes work championing U.S. leadership and liberal internationalism has run agro… [+11154 chars]	http://foreignpolicy.com/2025/05/09/joseph-nye-death-us-foreign-policy-soft-power/	https://foreignpolicy.com/wp-content/uploads/2025/05/1-joseph-nye-soft-power-2RP3X9X.jpg?w=1000	2025-05-09 17:08:46
126	0	13	NewsAPI	Trump’s Election, Gaza-Ukraine Wars, Nord Stream Pipeline Sabotage: Death Knells All to Truth and Democracy in the 21st Century	Preface\nWhat follows is one human being’s unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st century’s violent, contentious political and military struggles between them all.\nPlane…	Preface\r\nWhat follows is one human beings unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st centurys violent, contentio… [+74645 chars]	https://www.globalresearch.ca/trump-election-gaza-ukraine-wars-nord-stream-pipeline-sabotage/5886503	https://www.globalresearch.ca/wp-content/uploads/2019/07/Post-Truth.jpg	2025-05-14 01:24:45
127	0	13	NewsAPI	Does the Covid “Jab” Cause Amyloidosis? Richard C. Cook	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by Dr. Gregory House and …\nThe post Does the Covid “Jab” Cause …	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by … [+9925 chars]	https://www.globalresearch.ca/jab-cause-amyloidosis-richard-cook/5886442	https://www.globalresearch.ca/wp-content/uploads/2021/06/Covid-vaccine-VAERS-061821-feature-800x417.jpg	2025-05-10 12:19:57
128	0	13	NewsAPI	Civilians Face Humanitarian Disaster in Great Lakes, Horn of Africa Conflicts	Political instability and conflicts in the Great Lakes, the Horn of Africa, Sudan, and South Sudan have led to massive displacements and civilian suffering, and because the whole region is in crisis, the civilian population has few places to find refuge. In t…	Africa, Armed Conflicts, Crime &amp; Justice, Democracy, Featured, Gender, Gender Identity, Headlines, Human Rights, Humanitarian Emergencies, International Justice, Sustainable Development Goals, Te… [+12022 chars]	https://www.ipsnews.net/2025/05/civilians-face-humanitarian-disaster-in-great-lakes-and-horn-of-africa-conflicts/	https://www.ipsnews.net/Library/2025/05/M23-rebels-in-Eastern-Democratic-Republic-of-Congo.-The-group-has-been-accused-of-gross-abuse-of-rights-of-civilians.-Credit-Wambi-Michael-.jpg	2025-05-21 08:35:50
129	0	13	NewsDATA	Growing up with 'money anxiety' drove GE2025 independent candidate Jeremy Tan to excel in business, retire young	His parents found it hard to make ends meet after a number of failed businesses and there were times his home would be without power, water or internet services.	ONLY AVAILABLE IN PAID PLANS	https://www.channelnewsasia.com/today/up-close/jeremy-tan-ge2025-modest-beginning-building-movement-5141136	https://dam.mediacorp.sg/image/upload/s--2Yrvpm2n--/fl_relative,g_south_east,l_mediacorp:cna:watermark:2021-08:cna,w_0.1/f_auto,q_auto/c_fill,g_auto,h_468,w_830/v1/mediacorp/cna/image/2025/05/20/20250515_raj_jeremy_tan1.jpg?itok=yb5S64YJ	2025-05-24 13:30:00
130	0	13	NewsDATA	China’s India Headache: The growing pharmaceutical industry	Indian CDMOs are strategically expanding through acquisitions in the US and Europe, driven by global pharma's nearshoring trend and a desire to diversify from China. These companies are investing in advanced technologies and specialized capabilities, particularly in biologics and complex chemistry, to capture a larger share of the global market.	ONLY AVAILABLE IN PAID PLANS	https://economictimes.indiatimes.com/industry/healthcare/biotech/pharmaceuticals/chinas-india-headache-the-growing-pharmaceutical-industry/articleshow/121384015.cms	https://img.etimg.com/thumb/msid-121384261,width-1200,height-630,imgsize-14706,overlay-economictimes/articleshow.jpg	2025-05-24 12:09:21
131	0	13	NewsDATA	Ezra Klein, journalist and writer: ‘The Democrats were more loyal to Biden than to their own chances of winning’	In his book ‘Abundance,’ the ‘New York Times’ columnist calls on the US left to create a more prosperous society by supporting new technologies and reducing bureaucracy	ONLY AVAILABLE IN PAID PLANS	https://english.elpais.com/usa/2025-05-24/ezra-klein-journalist-and-writer-the-democrats-were-more-loyal-to-biden-than-to-their-own-chances-of-winning.html	https://imagenes.elpais.com/resizer/v2/ZBKRSVX6IJBRXPFAV6EVHL6LEQ.jpg?auth=983867f0b6362a2b9ec5882d90e8c5d32f4a5877c57871d330a8486a8713dc37&width=1200	2025-05-24 04:00:00
132	0	13	NewsDATA	What or where is the Indo-Pacific? How a foreign policy pivot redefined the global map	Open a book of maps and look for the “Indo-Pacific” region – it likely won’t be there.Yet the Indo-Pacific is now central to how many countries think...	ONLY AVAILABLE IN PAID PLANS	https://japantoday.com/category/features/opinions/what-or-where-is-the-indo-pacific-how-a-foreign-policy-pivot-redefined-the-global-map	https://media.japantoday.com/img/store/f8/a9/481beafff3f74fcea90a1e58612594599ea3/istock-1225478430/_w850.jpeg	2025-05-23 20:40:12
133	0	13	NewsDATA	Mineral desire: Moscow has enough to satisfy India	With global power dynamics shifting and Arctic resources surfacing, New Delhi has a timely chance to deepen ties with Russia Read Full Article at RT.com	ONLY AVAILABLE IN PAID PLANS	https://www.rt.com/india/618032-why-india-should-seize-strategic/	https://mf.b37mrtl.ru/files/2025.05/thumbnail/68308d2f85f540444376bb2e.jpg	2025-05-23 17:31:14
134	0	13	NewsDATA	Emily Darlington: ‘Strategic leadership means investing in the life-saving power of vaccines’	Last Thursday, in Westminster Hall, members from every corner of the House spoke with one voice: renewing Britain’s partnership with Gavi, the Vaccine Alliance, and the Global Fund to Fight AIDS, Tuberculosis and Malaria is not optional — it is imperative. At a moment when new variants circulate, deadly diseases still claim millions of lives,... Read more »The post Emily Darlington: ‘Strategic leadership means investing in the life-saving power of vaccines’ appeared first on Politics.co.uk.	ONLY AVAILABLE IN PAID PLANS	https://www.politics.co.uk/mp-comment/2025/05/23/emily-darlington-strategic-leadership-means-investing-in-the-life-saving-power-of-vaccines/	https://www.politics.co.uk/wp-content/uploads/2025/05/iStock-1421256265-1024x575.jpg	2025-05-23 07:00:53
135	0	13	NewsDATA	Parwinder Kaur becomes first politician in Australia to be sworn in with Sikh scriptures	Parwinder Kaur was sworn in to Western Australian Parliament with her hand on the Gutka Sahib, a small version of the holy scripture of Sikhism.	ONLY AVAILABLE IN PAID PLANS	https://www.sbs.com.au/language/punjabi/en/article/parwinder-kaur-becomes-first-politician-in-australia-to-be-sworn-in-with-sikh-scriptures/l493bx5no	https://images.sbs.com.au/dims4/default/d006bb3/2147483647/strip/false/crop/1920x882+0+99/resize/1234x567!/format/jpeg/quality/90/?url=http%3A%2F%2Fsbs-au-brightspot.s3.amazonaws.com%2F02%2F8c%2F3a1b4d8144c38203347664b82794%2Fcopy-of-mareeba.png	2025-05-23 05:01:35
137	0.089	14	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
138	0	14	NewsAPI	Joseph Nye Was the Champion of a World That No Longer Exists	The distinguished scholar, who coined “soft power,” shaped five decades of U.S. foreign policy.	It is poignant yet perhaps fitting to mourn Joseph Nye, the distinguished international relations scholar, just as his lifes work championing U.S. leadership and liberal internationalism has run agro… [+11154 chars]	http://foreignpolicy.com/2025/05/09/joseph-nye-death-us-foreign-policy-soft-power/	https://foreignpolicy.com/wp-content/uploads/2025/05/1-joseph-nye-soft-power-2RP3X9X.jpg?w=1000	2025-05-09 17:08:46
139	0	14	NewsAPI	5 years since Brexit, are Britain and the EU getting back together?	With a war in Ukraine and the U.S. rethinking alliances, Britain and the European Union may need each other more than they thought. They're holding their first summit since Brexit Monday.	LONDON As Britain and the European Union hold their first summit Monday since Brexit, analysts say it's less like a couple getting back together, and more like exes realizing they've still got to wor… [+6436 chars]	https://www.npr.org/2025/05/19/nx-s1-5397854/britain-eu-brexit-summit	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/5213x2932+0+272/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F04%2F51%2Fc5fe50aa4c1e978d6edf2e22468e%2Fap25136579070279.jpg	2025-05-19 08:17:13
140	0	14	NewsAPI	Leaders of Israel's Druze say the state owes it to them to defend Syrian kin	Israeli Druze renew their push for the IDF to defend their relatives in Syria as Jerusalem worries over new US-Syrian relations.	Pained and angered by deadly clashes between Islamist and Druze gunmen in Syria in recent weeks, leaders of Israel's own Druze minority say the Israeli military was right to intervene to defend the D… [+5254 chars]	https://www.jpost.com/israel-news/article-853945	https://images.jpost.com/image/upload/f_auto,fl_lossy/c_fill,g_faces:center,h_407,w_690/663254	2025-05-14 13:31:58
141	0	14	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
142	0	14	NewsDATA	Growing up with 'money anxiety' drove GE2025 independent candidate Jeremy Tan to excel in business, retire young	His parents found it hard to make ends meet after a number of failed businesses and there were times his home would be without power, water or internet services.	ONLY AVAILABLE IN PAID PLANS	https://www.channelnewsasia.com/today/up-close/jeremy-tan-ge2025-modest-beginning-building-movement-5141136	https://dam.mediacorp.sg/image/upload/s--2Yrvpm2n--/fl_relative,g_south_east,l_mediacorp:cna:watermark:2021-08:cna,w_0.1/f_auto,q_auto/c_fill,g_auto,h_468,w_830/v1/mediacorp/cna/image/2025/05/20/20250515_raj_jeremy_tan1.jpg?itok=yb5S64YJ	2025-05-24 13:30:00
143	0	14	NewsDATA	What or where is the Indo-Pacific? How a foreign policy pivot redefined the global map	Open a book of maps and look for the “Indo-Pacific” region – it likely won’t be there.Yet the Indo-Pacific is now central to how many countries think...	ONLY AVAILABLE IN PAID PLANS	https://japantoday.com/category/features/opinions/what-or-where-is-the-indo-pacific-how-a-foreign-policy-pivot-redefined-the-global-map	https://media.japantoday.com/img/store/f8/a9/481beafff3f74fcea90a1e58612594599ea3/istock-1225478430/_w850.jpeg	2025-05-23 20:40:12
144	0	14	NewsDATA	Emily Darlington: ‘Strategic leadership means investing in the life-saving power of vaccines’	Last Thursday, in Westminster Hall, members from every corner of the House spoke with one voice: renewing Britain’s partnership with Gavi, the Vaccine Alliance, and the Global Fund to Fight AIDS, Tuberculosis and Malaria is not optional — it is imperative. At a moment when new variants circulate, deadly diseases still claim millions of lives,... Read more »The post Emily Darlington: ‘Strategic leadership means investing in the life-saving power of vaccines’ appeared first on Politics.co.uk.	ONLY AVAILABLE IN PAID PLANS	https://www.politics.co.uk/mp-comment/2025/05/23/emily-darlington-strategic-leadership-means-investing-in-the-life-saving-power-of-vaccines/	https://www.politics.co.uk/wp-content/uploads/2025/05/iStock-1421256265-1024x575.jpg	2025-05-23 07:00:53
145	0.2	15	NewsDATA	Emily Darlington: ‘Strategic leadership means investing in the life-saving power of vaccines’	Last Thursday, in Westminster Hall, members from every corner of the House spoke with one voice: renewing Britain’s partnership with Gavi, the Vaccine Alliance, and the Global Fund to Fight AIDS, Tuberculosis and Malaria is not optional — it is imperative. At a moment when new variants circulate, deadly diseases still claim millions of lives,... Read more »The post Emily Darlington: ‘Strategic leadership means investing in the life-saving power of vaccines’ appeared first on Politics.co.uk.	ONLY AVAILABLE IN PAID PLANS	https://www.politics.co.uk/mp-comment/2025/05/23/emily-darlington-strategic-leadership-means-investing-in-the-life-saving-power-of-vaccines/	https://www.politics.co.uk/wp-content/uploads/2025/05/iStock-1421256265-1024x575.jpg	2025-05-23 07:00:53
146	0.1	15	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
148	0.1	15	NewsAPI	Protests In Turkey, 'Global Statesman' Abroad: Erdogan's 'Parallel Universes'	Turkey&#039;s President Tayyip Erdogan has probably never held more global sway: he will host the first direct RussiaUkraine peace talks in three years on Thursday,	Istanbul: Turkey's President Tayyip Erdogan has probably never held more global sway: he will host the first direct Russia-Ukraine peace talks in three years on Thursday, days after his country's mil… [+6396 chars]	https://www.ndtv.com/world-news/recep-tayyip-erdogan-russia-ukraine-talks-protests-in-turkey-global-statesman-abroad-erdogans-parallel-universes-8413032	https://c.ndtvimg.com/2024-09/ubvvhg3o_tayyip-erdogan_625x300_08_September_24.jpeg?im=FeatureCrop,algorithm=dnn,width=1200,height=738	2025-05-14 13:05:12
149	0.1	15	NewsAPI	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival, which kicks off Tuesday in the wake of U.S. President Donald Trumps vow to enact tariffs on international f… [+6520 chars]	https://abcnews.go.com/Business/wireStory/cannes-global-colosseum-film-readies-78th-edition-new-121681980	https://i.abcnewsfe.com/a/c3d2a11e-785d-44eb-82f9-78bb43d4467e/wirestory_d289e6798571dd31943dc3d6d3a2d556_16x9.jpg?w=1600	2025-05-11 05:42:14
150	0.1	15	NewsAPI	Spain and Portugal Blackout: Separating Fact from Fiction	Note: This blog was published May 6, 2025. Last Monday, a widespread power outage hit Spain and Portugal, plunging the region into darkness for about 18 hours before power was restored. Within minutes of the blackout, people with political agendas flooded the…	Note: This blog was published May 6, 2025.\r\nPhoto Credit: Pexels\r\nLast Monday, a widespread power outage hit Spain and Portugal, plunging the region into darkness for about 18 hours before power was … [+6845 chars]	https://blogs.edf.org/climate411/2025/05/06/spain-and-portugal-blackout-separating-fact-from-fiction/	https://blogs.edf.org/climate411/wp-content/blogs.dir/7/files//power-7101420_1280.jpg	2025-05-06 20:14:20
151	0.1	15	NewsAPI	Civilians Face Humanitarian Disaster in Great Lakes, Horn of Africa Conflicts	Political instability and conflicts in the Great Lakes, the Horn of Africa, Sudan, and South Sudan have led to massive displacements and civilian suffering, and because the whole region is in crisis, the civilian population has few places to find refuge. In t…	Africa, Armed Conflicts, Crime &amp; Justice, Democracy, Featured, Gender, Gender Identity, Headlines, Human Rights, Humanitarian Emergencies, International Justice, Sustainable Development Goals, Te… [+12022 chars]	https://www.ipsnews.net/2025/05/civilians-face-humanitarian-disaster-in-great-lakes-and-horn-of-africa-conflicts/	https://www.ipsnews.net/Library/2025/05/M23-rebels-in-Eastern-Democratic-Republic-of-Congo.-The-group-has-been-accused-of-gross-abuse-of-rights-of-civilians.-Credit-Wambi-Michael-.jpg	2025-05-21 08:35:50
152	0.1	15	NewsDATA	China’s India Headache: The growing pharmaceutical industry	Indian CDMOs are strategically expanding through acquisitions in the US and Europe, driven by global pharma's nearshoring trend and a desire to diversify from China. These companies are investing in advanced technologies and specialized capabilities, particularly in biologics and complex chemistry, to capture a larger share of the global market.	ONLY AVAILABLE IN PAID PLANS	https://economictimes.indiatimes.com/industry/healthcare/biotech/pharmaceuticals/chinas-india-headache-the-growing-pharmaceutical-industry/articleshow/121384015.cms	https://img.etimg.com/thumb/msid-121384261,width-1200,height-630,imgsize-14706,overlay-economictimes/articleshow.jpg	2025-05-24 12:09:21
153	0	15	NewsAPI	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Geopolitics course through Cannes unlike any other festival.	By JAKE COYLE, Associated Press\r\nNowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival, which kicks off Tuesday in the wake of U.S. President Donald Trumps vow to… [+7069 chars]	https://www.bostonherald.com/2025/05/12/cannes-preview/	https://www.bostonherald.com/wp-content/uploads/2025/05/France_Cannes_2025_46756.jpg?w=1024&h=682	2025-05-12 18:24:50
154	0	15	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
155	0	15	NewsAPI	The Muslim Vote may have lost, but election bump is 'just the beginning'	Labor maintained their key seats in Western Sydney, but is was not without a fight.	Labor may have retained the Western Sydney seats of Blaxland and Watson with comfortable margins, but a closer look at the results reveals the party has lost some support.\r\nWhile the federal election… [+4906 chars]	https://www.abc.net.au/news/2025-05-09/federal-election-results-western-sydney-muslim-vote-independents/105273452	https://live-production.wcms.abc-cdn.net.au/c2f9f73c81744af786ace07fb17f9b2e?impolicy=wcms_watermark_news&cropH=3942&cropW=7008&xPos=0&yPos=265&width=862&height=485&imformat=generic	2025-05-09 06:19:13
156	0	15	NewsAPI	How Donald Trump Upended US Foreign Policy in 100 Days	"It's been one of the most exciting starts to a new presidential term since Gorbachev," academic Barry Scott Zellen told Newsweek.	President Donald Trump is "redrawing the world map" with his foreign policy, driven by his "America first" stance, his anti-globalist position, his "like" for provoking America's allies and his desir… [+10883 chars]	https://www.newsweek.com/donald-trump-foreign-policy-100-days-2064942	https://d.newsweek.com/en/full/2626627/trump-upended-foreign-policy-100-days.png	2025-04-29 11:38:26
157	0	15	NewsAPI	China’s Mega Dam Project Poses Big Risks for Asia’s Grand Canyon	China’s plans to build a massive hydro project in Tibet have sparked fears about the environmental impacts on the world’s longest and deepest canyon. It has also alarmed neighboring India, which fears that China could hold back or even weaponize river water i…	China has announced plans to build the worlds largest hydroelectric project at a remote river gorge in eastern Tibet, an ecological treasure trove close to a disputed border with India. Indian politi… [+12440 chars]	https://e360.yale.edu/features/china-tibet-yarlung-tsangpo-dam-india-water	https://yale-threesixty.transforms.svdcdn.com/production/Doxong-Pass_Alamy-HEADER.jpg?w=1200&q=60&auto=format&fit=max&dm=1747304219&s=d8af4146a9bdb36bac3a02200c2dc4c0	2025-05-14 14:35:00
158	0	15	NewsAPI	Albanese has been a ‘proficient and lucky general’. But if he wins a second term, we are right to demand more	Albanese’s prime ministership has been slow but steady. If he’s re-elected, he will need to give Australians a more ambitious plan for the country.	Barring a rogue result, this Saturday Anthony Albanese will achieve what no major party leader has done since John Howards prime-ministerial era win consecutive elections. Admittedly, in those two de… [+17885 chars]	https://theconversation.com/albanese-has-been-a-proficient-and-lucky-general-but-if-he-wins-a-second-term-we-are-right-to-demand-more-235197	https://images.theconversation.com/files/664155/original/file-20250427-56-uark4g.jpg?ixlib=rb-4.1.0&rect=0%2C434%2C5381%2C2690&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-27 20:04:56
159	0	15	NewsAPI	Trump’s Election, Gaza-Ukraine Wars, Nord Stream Pipeline Sabotage: Death Knells All to Truth and Democracy in the 21st Century	Preface\nWhat follows is one human being’s unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st century’s violent, contentious political and military struggles between them all.\nPlane…	Preface\r\nWhat follows is one human beings unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st centurys violent, contentio… [+74645 chars]	https://www.globalresearch.ca/trump-election-gaza-ukraine-wars-nord-stream-pipeline-sabotage/5886503	https://www.globalresearch.ca/wp-content/uploads/2019/07/Post-Truth.jpg	2025-05-14 01:24:45
160	0	15	NewsDATA	UBS Asian Investment Conference in Hong Kong to feature Simone Biles and Maria Konnikova	Speakers at the Hong Kong conference next week are expected to discuss economics, trade and political uncertainties Read full story	ONLY AVAILABLE IN PAID PLANS	https://www.thestar.com.my/aseanplus/aseanplus-news/2025/05/24/ubs-asian-investment-conference-in-hong-kong-to-feature-simone-biles-and-maria-konnikova	https://apicms.thestar.com.my/uploads/images/2025/05/24/3330121.jpg	2025-05-24 10:52:00
161	0	15	NewsDATA	Ezra Klein, journalist and writer: ‘The Democrats were more loyal to Biden than to their own chances of winning’	In his book ‘Abundance,’ the ‘New York Times’ columnist calls on the US left to create a more prosperous society by supporting new technologies and reducing bureaucracy	ONLY AVAILABLE IN PAID PLANS	https://english.elpais.com/usa/2025-05-24/ezra-klein-journalist-and-writer-the-democrats-were-more-loyal-to-biden-than-to-their-own-chances-of-winning.html	https://imagenes.elpais.com/resizer/v2/ZBKRSVX6IJBRXPFAV6EVHL6LEQ.jpg?auth=983867f0b6362a2b9ec5882d90e8c5d32f4a5877c57871d330a8486a8713dc37&width=1200	2025-05-24 04:00:00
162	0	15	NewsDATA	What or where is the Indo-Pacific? How a foreign policy pivot redefined the global map	Open a book of maps and look for the “Indo-Pacific” region – it likely won’t be there.Yet the Indo-Pacific is now central to how many countries think...	ONLY AVAILABLE IN PAID PLANS	https://japantoday.com/category/features/opinions/what-or-where-is-the-indo-pacific-how-a-foreign-policy-pivot-redefined-the-global-map	https://media.japantoday.com/img/store/f8/a9/481beafff3f74fcea90a1e58612594599ea3/istock-1225478430/_w850.jpeg	2025-05-23 20:40:12
163	0	15	NewsDATA	G7 takes aim at China: World’s richest nations unite to crush unfair trade tactics	BANFF, Alberta: Financial policymakers from the seven well-heeled economies of the world clinched a two-day high-level meeting in the Canadian Rockies with a skillfully crafted treaty to deal with the world’s “economic imbalances”—an initiative broadly understood as an understated condemnation of China’s trade policies. According to the latest Yahoo Finance report, while U.S. tariffs and [...]The post G7 takes aim at China: World’s richest nations unite to crush unfair trade tactics appeared first on The Independent Singapore News - Latest Breaking News	ONLY AVAILABLE IN PAID PLANS	https://theindependent.sg/g7-takes-aim-at-china-worlds-richest-nations-unite-to-crush-unfair-trade-tactics/	https://media.theindependent.sg/wp-content/uploads/2025/02/8384.jpg	2025-05-23 09:39:37
164	0	15	NewsDATA	Parwinder Kaur becomes first politician in Australia to be sworn in with Sikh scriptures	Parwinder Kaur was sworn in to Western Australian Parliament with her hand on the Gutka Sahib, a small version of the holy scripture of Sikhism.	ONLY AVAILABLE IN PAID PLANS	https://www.sbs.com.au/language/punjabi/en/article/parwinder-kaur-becomes-first-politician-in-australia-to-be-sworn-in-with-sikh-scriptures/l493bx5no	https://images.sbs.com.au/dims4/default/d006bb3/2147483647/strip/false/crop/1920x882+0+99/resize/1234x567!/format/jpeg/quality/90/?url=http%3A%2F%2Fsbs-au-brightspot.s3.amazonaws.com%2F02%2F8c%2F3a1b4d8144c38203347664b82794%2Fcopy-of-mareeba.png	2025-05-23 05:01:35
165	0.185	16	NewsDATA	Chance meeting between two epidemiologists on the number 18 bus in London helped save an estimated one million lives during Covid and paved the way for the end of the pandemic	What Britain has to offer to the world was never clearer than in the leading role we took in the Covid crisis - and all because of a chance meeting on a number 18 bus in London .	ONLY AVAILABLE IN PAID PLANS	https://www.dailymail.co.uk/news/article-14746763/Chance-meeting-two-epidemiologists-number-18-bus-London-helped-save-estimated-one-million-lives-Covid-paved-way-end-pandemic.html	https://i.dailymail.co.uk/1s/2025/05/25/00/98725581-0-image-a-16_1748128582541.jpg	2025-05-24 23:18:11
166	0.089	16	NewsAPI	A Public Health Researcher and Her Engineer Husband Found How Diseases Can Spread through Air Decades before the COVID Pandemic	Mildred Weeks Wells and her husband figured out that disease-causing pathogens can spread through the air like smoke	Air-Borne: The Hidden History of the Life We Breathe, by Carl Zimmer, charts the history of the field of aerobiology: the science of airborne microorganisms. In this episode, we discover the story of… [+33528 chars]	https://www.scientificamerican.com/article/a-public-health-researcher-and-her-engineer-husband-found-how-diseases-can/	https://static.scientificamerican.com/dam/m/924bb2302462b89/original/Lost-Women-of-Science-Partner-Podcast-Span-Art-Airborne.png?m=1747878912.787&w=1200	2025-05-22 16:00:00
167	0.089	16	NewsAPI	HHS is weaponizing evidence-based medicine to falsely portray vaccines as unsafe	Last week, HHS announced that all "new vaccines will undergo safety testing in placebo-controlled trials." Sounds good? Not so fast. This is really a deceptive weaponization of evidence-based medicine to undermine confidence in vaccines and eliminate at least…	Having a man who has for the last two decades arguably been America’s most famous and intellectual antivax activist in charge of the Department of Health and Human Services (HHS) has been exhausting.… [+46033 chars]	https://sciencebasedmedicine.org/hhs-is-weaponizing-evidence-based-medicine-to-falsely-portray-vaccines-as-unsafe/	https://sciencebasedmedicine.org/wp-content/uploads/2017/04/EBMupdated.jpg	2025-05-05 07:00:00
168	0.089	16	NewsAPI	Pandemic preparedness: First Pandemic Treaty adopted	It’s only the second time the World Health Assembly has adopted a health treaty, but key details of this Pandemic Agreement remain unclear. An analysis. World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annua…	World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annual Assembly on Tuesday, May 20, after three years of protracted negotiations.\r\nIt's only the s… [+5484 chars]	https://www.dw.com/en/pandemic-preparedness-first-pandemic-treaty-adopted/a-72609575	https://static.dw.com/image/72607764_6.jpg	2025-05-20 12:43:00
169	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://www.citizentribune.com/news/business/fastest-growing-jobs-that-pay-over-100k/article_9cc8285f-20c1-5d90-bcf9-b54754752987.html	https://bloximages.newyork1.vip.townnews.com/citizentribune.com/content/tncms/assets/v3/editorial/b/b6/bb670b6c-56e2-5709-969e-32eb8281a1ac/683083846686f.image.png?resize=300%2C214	2025-05-23 17:30:00
170	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://winonadailynews.com/news/nation-world/business/personal-finance/article_c71d1e21-1dcc-58ac-9a1f-5e60a41462b6.html	https://bloximages.chicago2.vip.townnews.com/winonadailynews.com/content/tncms/assets/v3/editorial/f/4e/f4ed9cf4-8c34-5d56-8093-79cff43a9d4e/68308a50eaa19.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
171	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://scnow.com/news/nation-world/business/personal-finance/article_7837dd07-cf74-5e72-9dd6-6aa952004d00.html	https://bloximages.newyork1.vip.townnews.com/scnow.com/content/tncms/assets/v3/editorial/7/e8/7e82ef3c-a825-5911-ad08-00021f5f5b55/68308a29ce075.image.png?resize=300%2C214	2025-05-23 17:30:00
172	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://morganton.com/news/nation-world/business/personal-finance/article_ab42852b-ec39-54ca-8cb8-7a25cdd3da50.html	https://bloximages.newyork1.vip.townnews.com/morganton.com/content/tncms/assets/v3/editorial/6/c7/6c747c84-c50b-595c-9250-7a2eac129b9d/683089f6ec8cf.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
173	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://missoulian.com/news/nation-world/business/personal-finance/article_5fc145fb-b689-5fb6-af42-150bef2a95f9.html	https://bloximages.chicago2.vip.townnews.com/missoulian.com/content/tncms/assets/v3/editorial/c/29/c291394f-4073-5c45-8f1c-8babf752232b/683087d1003a7.image.png?resize=300%2C214	2025-05-23 17:30:00
174	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://herald-review.com/news/nation-world/business/personal-finance/article_ee29be2c-0e73-589e-8081-f856a5f98505.html	https://bloximages.chicago2.vip.townnews.com/herald-review.com/content/tncms/assets/v3/editorial/2/eb/2ebb5501-0b56-5942-ad0f-8bf49d1494f5/6830877c89d08.image.png?crop=1010%2C530%2C0%2C94	2025-05-23 17:30:00
175	0.089	16	NewsDATA	Fastest-growing jobs that pay over $100K	Stacker ranked the top 50 fastest-growing jobs earning over $100,000 annually using 2023 data from the Bureau of Labor Statistics Employment Projections.	ONLY AVAILABLE IN PAID PLANS	https://starexponent.com/news/nation-world/business/personal-finance/article_b7d81b64-3bc4-5fa2-bd9c-42106b2757c4.html	https://bloximages.newyork1.vip.townnews.com/starexponent.com/content/tncms/assets/v3/editorial/0/8c/08ca5a77-8a3c-5d08-8444-307179a8c8ff/683087abf2023.image.png?resize=300%2C214	2025-05-23 17:30:00
176	0	16	NewsAPI	A Shelter or a Prison?	There’s a severe shortage of public treatment options in Mexico for people who use drugs and wish to stop. Small, clandestine private clinics fill the gap.	When Angela Garcia, an anthropologist and professor at Stanford University, arrived in Mexico City in 2011 to begin research for her second book, the war on drugs in Mexico had been in full swing for… [+19870 chars]	https://www.nybooks.com/articles/2025/06/12/a-shelter-or-a-prison-anexos-drug-treatment-mexico/	https://www.nybooks.com/wp-content/uploads/2025/05/paley_1-061225-900.jpg	2025-05-22 12:00:00
177	0	16	NewsAPI	Hello measles, my old friend: The return of previously vanquished vaccine-preventable diseases	A study published last week suggests that, if vaccine uptake continues to decline, measles will soon be endemic again in the US. It's just part of how RFK Jr. is making America sicker again.\nThe post Hello measles, my old friend: The return of previously vanq…	When a country puts an antivaxxer and supporter of quackery whose worldview with respect to medicine and biomedical science is as utterly divorced from science and reality as that of longtime antivax… [+30269 chars]	https://sciencebasedmedicine.org/hello-measles-my-old-friend-the-return-of-previously-vanquished-vaccine-preventable-diseases/	https://sciencebasedmedicine.org/wp-content/uploads/2025/04/Measles.jpg	2025-04-28 07:00:00
178	0	16	NewsAPI	HHS, NIH waste $500 million on failed universal vaccine scheme as respiratory viruses continue to mutate beyond vaccine efficacy	The U.S. government is doubling down on failed vaccine science, pouring half a billion taxpayer dollars into a futile quest for “universal” vaccines against influenza and coronaviruses. The Department of Health and Human Services (HHS) and National Institutes…	The U.S. government is doubling down on failed vaccine science, pouring half a billion taxpayer dollars into a futile quest for "universal" vaccines against influenza and coronaviruses. The Departmen… [+6427 chars]	https://www.naturalnews.com/2025-05-02-hhs-nih-waste-500-million-on-failed-universal-vaccine-scheme.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Hand-in-blue-medical-gloves-holds-an-ampoule.jpeg	2025-05-02 06:00:00
179	0	16	NewsAPI	Florida study sparks new controversy over mRNA vaccine safety, links Pfizer vaccine to higher mortality rates than Moderna	A Florida study co-authored by Dr. Joseph Ladapo found that Pfizer mRNA vaccine recipients had a 38% higher all-cause mortality rate within 12 months compared to Moderna recipients, with higher cardiovascular and non-COVID deaths (847 vs. 618 deaths per 100,0…	<ul><li>A Florida study co-authored by Dr. Joseph Ladapo found that Pfizer mRNA vaccine recipients had a 38% higher all-cause mortality rate within 12 months compared to Moderna recipients, with high… [+6456 chars]	https://www.naturalnews.com/2025-05-06-pfizer-vaccine-higher-mortality-rates-than-moderna.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Vaccine-Vial-Bottles-Covid-19.jpg	2025-05-06 06:00:00
180	0	16	NewsAPI	Study Sparks New Controversy Over mRNA Vaccine Safety	A Florida study co-authored by Dr. Joseph Ladapo found that Pfizer mRNA vaccine recipients had a 38% higher all-cause mortality rate within 12 months compared to Moderna recipients, with higher cardiovascular and non-COVID deaths (847 vs. 618 deaths per 100,0…	This article was originally published by Willow Tohi at Natural News under the title Florida study sparks new controversy over mRNA vaccine safety, links Pfizer vaccine to higher mortality rates than… [+6712 chars]	https://www.shtfplan.com/health/study-sparks-new-controversy-over-mrna-vaccine-safety	https://www.shtfplan.com/wp-content/uploads/2023/06/vaccinedeath.jpg	2025-05-06 22:30:33
181	0	16	NewsAPI	100 Days, 100 Small Victories	The political wins, works of art, and acts of defiance bringing us relief, joy, and even hope under Trump 2.0.	The first 100 days of Donald Trumps second term feel like theyve dragged on for an eternity, with each days news cycle bringing fresh hell to reckon with. But there is evidence of real political prog… [+43896 chars]	http://www.thecut.com/article/100-small-wins-worth-celebrating-from-trumps-first-100-days.html	https://pyxis.nymag.com/v1/imgs/7ed/97f/36fb7c053c757eda5ef6e72651d2854552-100-days-03.1x.rsocial.w1200.jpg	2025-04-30 17:15:46
182	0	16	NewsAPI	Noted Vaccine Researcher and Leader Kate O’Brien Awarded Sabin’s Gold Medal; Physician Livancliff Mbianke of Cameroon Receives Rising Star Award	WASHINGTON, May 13, 2025 (GLOBE NEWSWIRE) -- The Sabin Vaccine Institute today awarded the Albert B. Sabin Gold Medal to pediatrician Katherine O’Brien, MD, MPH, for her research on the pneumococcal vaccine and leadership in global vaccine research and access…	WASHINGTON, May 13, 2025 (GLOBE NEWSWIRE) -- The Sabin Vaccine Institute today awarded the Albert B. Sabin Gold Medal to pediatrician Katherine OBrien, MD, MPH, for her research on the pneumococcal v… [+7884 chars]	https://www.globenewswire.com/news-release/2025/05/14/3080793/0/en/Noted-Vaccine-Researcher-and-Leader-Kate-O-Brien-Awarded-Sabin-s-Gold-Medal-Physician-Livancliff-Mbianke-of-Cameroon-Receives-Rising-Star-Award.html	https://ml.globenewswire.com/Resource/Download/7c57b728-3431-4b2f-8bd6-feacc4f06979	2025-05-14 03:26:00
183	0	16	NewsAPI	Are synthetic food dyes unsafe? Experts reveal what the research really shows	Food dyes have long been used in candy, breakfast cereal and even medication. As the federal government moves to phase these dyes out, experts explain whether it's worth cutting any foods out now.	The appeal of a brightly colored candy, the vibrant hue of your mouthwash, the pigment of your sports drinks theyre all thanks to food dyes. These colorful additives dont add any nutritional value to… [+12096 chars]	https://www.today.com/health/diet-fitness/are-food-dyes-bad-for-you-rcna205164	https://media-cldnry.s-nbcnews.com/image/upload/t_social_share_1200x630_center,f_auto,q_auto:best/rockcms/2025-05/food-dyes-safety-zz-250515-291a61.jpg	2025-05-22 20:36:49
184	0	16	NewsAPI	A Devastating New Exposé of Johnson & Johnson Indicts an Entire System	If health care industry corruption and criminality were a city skyline, it would be booming, with tower cranes and half-built skyscrapers in every direction. Among the downtown giants at the center would stand Johnson & Johnson, an iconic U.S. company whose v…	Throughout this history, the question presents itself: Where the hell was the FDA?\r\nThroughout this history, the question presents itself: Where the hell was the FDA? Harris, to his great credit, nev… [+2887 chars]	https://newrepublic.com/article/194726/johnson-and-johnson-investigation-crimes-health-care-system	https://images.newrepublic.com/53a11cbfa4f53956960f52db71f824a3272d1d96.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-12 10:00:00
185	0.274	17	NewsAPI	An Insider's View of the Texas Measles Outbreak	Katherine Wells, the public health director in Lubbock, Texas, describes her fight to stop the largest measles outbreak since 2000, despite a chaotic reorganization of federal health agencies.	Katherine Wells has been an epidemiologist working to protect the public from disease outbreaks for 25 years. Until January, she had never encountered measles.\r\n"I mean, we considered measles eradica… [+7199 chars]	https://www.npr.org/sections/shots-health-news/2025/05/09/nx-s1-5392323/an-insiders-view-of-the-texas-measles-outbreak	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/1024x576+0+53/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F42%2Ff8%2F4f1fe7404ca88ad7c3c4f8e4b1b4%2Fgettyimages-2209410399.jpg	2025-05-09 12:44:34
186	0.178	17	NewsAPI	‘Sobering’ city data shows Bronx residents at high risk for diabetes complications	‘Sobering’ city data shows Bronx residents at high risk for diabetes complicationsgothamist.com	About 60,000 New York City adults are diagnosed with diabetes each year, and the disease is most prevalent in the Bronx, according to new city data.\r\nThe Bronx is also home to the four neighborhoods … [+4334 chars]	https://gothamist.com/news/sobering-city-data-shows-bronx-residents-at-high-risk-for-diabetes-complications	https://api-prod.gothamist.com/images/351019/fill-1200x650|format-webp|webpquality-85/	2025-05-03 13:35:12
187	0.089	17	NewsAPI	With Over Half of USVI Children Unvaccinated, Health Officials Urge Action as U.S. Measles Outbreaks Grow	With Over Half of USVI Children Unvaccinated, Health Officials Urge Action as U.S. Measles Outbreaks Growviconsortium.com	With measles cases in the United States now exceeding 1,000 and 14 active outbreaks  (defined as three or more related cases) confirmed, the V.I. Department of Health said it is ramping up efforts to… [+3740 chars]	https://viconsortium.com/vi-health/virgin-islands-with-over-half-of-usvi-children-unvaccinated--health-officials-urge-action-as-u-s--measles-outbreaks-grow	https://viconsortium.nyc3.cdn.digitaloceanspaces.com/uploads/measles-mmr-vaccine-VIC.jpg	2025-05-11 11:50:10
188	0	17	NewsAPI	How Bad Could Measles Get This Year?	Experts explain the worst-cast scenario.	Sign up for the Slatest to get the most insightful analysis, criticism, and advice out there, delivered to your inbox daily.\r\nAs of this week, there are at least 800 cases of measles in the U.S. acro… [+10662 chars]	https://slate.com/technology/2025/04/measles-cases-epidemic-worst-case-vaccine.html	https://compote.slate.com/images/d22bea21-35e5-452e-b9e8-c85f3c691c45.gif?crop=780%2C520%2Cx0%2Cy0&width=1560	2025-04-24 14:00:00
189	0	17	NewsAPI	Karbi Anglong observes National Dengue Day with awareness activities	HT BureauDIPHU, May 16: The District Malaria Officer (NCVBDC), Karbi Anglong announced the observance of National Dengue Day (NDD) on May 16, aligning with the annual initiative by the Ministry of Health and Family Welfare to raise awareness about Dengue feve…	HT BureauDIPHU, May 16: The District Malaria Officer (NCVBDC), Karbi Anglong announced the observance of National Dengue Day (NDD) on May 16, aligning with the annual initiative by the Ministry of He… [+1738 chars]	https://thehillstimes.in/assam/karbi-anglong-observes-national-dengue-day-with-awareness-activities	https://thehillstimes.in/wp-content/uploads/2025/05/Karbi-Anglong-observes.jpg	2025-05-16 21:10:00
190	0	17	NewsAPI	Expert reveals the symptoms of Covid in 2025 - and how long infection now lasts	Experts warn that the virus that sparked the pandemic, SARS-CoV-2, is still circulating	Your support helps us to tell the story\r\nFrom reproductive rights to climate change to Big Tech, The Independent is on the ground when the story is developing. Whether it's investigating the financia… [+6605 chars]	https://www.the-independent.com/life-style/health-and-families/covid-symptoms-2025-australia-uk-vaccine-b2750204.html	https://static.the-independent.com/2024/01/11/17/newFile.jpg?width=1200&height=800&crop=1200:800	2025-05-13 19:35:18
191	0	17	NewsAPI	Trump health cuts create ‘real danger’ around disease outbreaks, workers warn - NewsBreak	Key programs from child-support services to HIV treatment also gutted, leaving global populations vulnerable	Donald Trumps administration is cutting the HHS workforce from 82,000 to 62,000 through firings and buyouts. Composite: Guardian Design \r\nMass terminations and billions of dollars worth of cuts at th… [+8531 chars]	https://www.newsbreak.com/share/4002624614235-trump-health-cuts-create-real-danger-around-disease-outbreaks-workers-warn?s=a2&amp;share_destination_id=MjE0MDc5NjUwLTE3NDY5OTg2NTQzMDE%3D&amp;pd=0EUFtaFN&amp;hl=en_US&amp;send_time=1746998654&amp;actBtn=bottomBar&amp;_f=app_share&amp;trans_data=%7B%22platform%22%3A1%2C%22cv%22%3A%2225.17.0%22%2C%22languages%22%3A%22en%22%7D&amp;sep=ns_foryou_rank_exp_25q2-v2%2Cns_local_strategy_25q1_exp-v3%2Cns_foryou_recall_exp_25q2-v4%2Cns_foryou_model_exp_25q2_v2-v3%2Cns_foryou_blend_exp_25q2-v2	https://img.particlenews.com/img/id/0YB1RQ_1118835U00	2025-05-11 21:24:43
192	0	17	NewsAPI	NC hospitals in state of standby, preparing as measles threat grows	As measles cases surge across the nation, North Carolina hospitals are on high alert, preparing for potential outbreaks in areas with low vaccination rates.	As measles cases rise nationwide, local hospitals are on\r\nhigh alert for possible cases. Health officials statewide and at local levels\r\nwarn communities with low vaccination rates are most at-risk f… [+7867 chars]	https://www.wral.com/lifestyle/health/nc-hospitals-standby-measles-threat-may-2025/	https://images.wral.com/88a23600-f814-4c0d-bb9c-a81b522fef25?w=1200&h=630	2025-05-02 21:54:24
193	0	17	NewsAPI	AHPRA: Public Health Watchdog, Big Pharma Lapdog, or Drug Enabler ⋆ Brownstone Institute	The question as to whether public health watchdog has been corrupted into a Big Pharma lapdog, is relevant for most countries.	Mei-Khing Loo is a former practice manager whose 43-year-old obstetrician-gynaecologist husband of 21 years, Dr Yen-Yung Yap, died by suicide in 2020 while under investigation by the Australian Healt… [+22451 chars]	https://brownstone.org/articles/ahpra-public-health-watchdog-big-pharma-lapdog-or-drug-enabler/	https://brownstone.org/wp-content/uploads/2025/05/Shutterstock_2473828587.jpg	2025-05-17 11:02:53
194	0	17	NewsAPI	Traveler infected with measles may have exposed people at DIA, hotel: CDPHE	A traveler infected with measles may have exposed thousands of people to the highly contagious virus last week at DIA and a nearby hotel, state health officials said Thursday.	DENVER An unvaccinated individual infected with measles who arrived at DIA from an international flight before staying for the night at a nearby hotel and boarding a domestic flight the next morning … [+5573 chars]	https://www.denver7.com/lifestyle/health/unvaccinated-traveler-infected-with-measles-may-have-exposed-people-at-dia-nearby-hotel-last-week-cdphe-says	https://ewscripps.brightspotcdn.com/dims4/default/4c509d9/2147483647/strip/true/crop/5616x2948+0+0/resize/1200x630!/quality/90/?url=http%3A%2F%2Fewscripps-brightspot.s3.amazonaws.com%2F22%2Fbb%2F663e1e6c4cbfa1fbccb5862eeeb0%2Fap23146717390600.jpg	2025-05-23 01:15:38
195	0	17	NewsAPI	Beyond Ivy League, RFK Jr.’s NIH slashed science funding across states that backed Trump | CNN	The National Institutes of Health’s sweeping cuts of grants that fund scientific research are inflicting pain almost universally across the U.S., including in most states that backed President Donald Trump in the 2024 election.	The National Institutes of Healths sweeping cuts of grants that fund scientific research are inflicting pain almost universally across the U.S., including in most states that backed President Donald … [+14065 chars]	https://www.cnn.com/2025/04/25/health/nih-science-funding-states-kff-health-news/index.html	https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2150630912.jpg?c=16x9&q=w_800,c_fill	2025-04-25 11:41:26
196	0	17	NewsDATA	‘I Question It Myself’: South Dakota Vaccination Rates Fall Amid Mistrust And Misinformation	Grant Vander Vorst is at the epicenter of vaccine hesitancy in South Dakota: Just 56% of incoming kindergartners in Faulk County, where he lives, were up to date on their measles, mumps and rubella vaccination during the 2023-24 school year,...	ONLY AVAILABLE IN PAID PLANS	https://www.yankton.net/community/article_0b1b305e-7d95-438a-aa92-efe5bd220edd.html	https://bloximages.chicago2.vip.townnews.com/yankton.net/content/tncms/assets/v3/editorial/9/4a/94accd1d-125c-466b-b368-ac123bbf89c8/68312e328a69f.image.jpg?resize=300%2C211	2025-05-24 22:00:00
\.


--
-- Data for Name: fav_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fav_articles (id, score, question_id, api_source, title, description, content, url, "urlToImage", "publishedAt", article_id, user_id) FROM stdin;
1	0	7	NewsAPI	Pandemic preparedness: First Pandemic Treaty adopted	It’s only the second time the World Health Assembly has adopted a health treaty, but key details of this Pandemic Agreement remain unclear. An analysis. World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annua…	World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annual Assembly on Tuesday, May 20, after three years of protracted negotiations.\r\nIt's only the s… [+5484 chars]	https://www.dw.com/en/pandemic-preparedness-first-pandemic-treaty-adopted/a-72609575	https://static.dw.com/image/72607764_6.jpg	2025-05-20 12:43:00	58	1
\.


--
-- Data for Name: fav_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fav_videos (id, question_id, youtube_id, description, thumbnail, video_id, user_id) FROM stdin;
\.


--
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favourites (id, entity_id, entity_type) FROM stdin;
\.


--
-- Data for Name: hidden_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_articles (article_id, id, user_id) FROM stdin;
18	1	1
16	2	1
14	3	1
21	4	1
34	5	1
116	6	3
107	7	3
85	8	3
98	9	3
144	10	3
\.


--
-- Data for Name: hidden_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_questions (question_id, id, user_id) FROM stdin;
9	1	1
9	2	3
\.


--
-- Data for Name: hidden_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_videos (video_id, id, user_id) FROM stdin;
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, topic_id, text, keywords, "order") FROM stdin;
1	1	How can we effectively integrate natural climate solutions into existing mitigation strategies?	existing mitigation strategies	0
2	1	What are the long-term impacts of changing precipitation patterns on ecosystem biodiversity?	changing precipitation patterns, term impacts, ecosystem biodiversity, long	1
3	1	How do we improve public communication to drive sustainable climate action?	improve public communication	2
4	2	How can we ensure AI systems are developed and used in a way that promotes fairness and equity?	ensure ai systems, promotes fairness, way, used, equity	0
5	2	What safeguards can prevent AI from perpetuating and amplifying existing societal biases?	prevent ai, safeguards, perpetuating	1
6	2	How do we balance innovation in AI with the ethical considerations of its potential impact on humanity?	potential impact, ethical considerations, balance innovation, humanity, ai	2
7	3	How can we better identify emerging infectious disease threats before they become widespread epidemics?	become widespread epidemics	0
8	3	What are the most effective strategies for reducing health disparities among vulnerable populations?	effective strategies	1
9	3	How can we improve data collection and analysis to inform evidence-based public health interventions?	improve data collection, inform evidence, analysis	2
10	4	How should our portfolio strategy shift given forecasts of increased inflation?	increased inflation	0
11	4	What are the key indicators signaling potential market corrections, and what's our action plan?	action plan	1
12	4	Which emerging sectors offer the best risk-adjusted returns in the current environment?	emerging sectors offer, current environment, best risk, adjusted returns	2
13	5	How do domestic political institutions shape a nation's geopolitical strategy?	geopolitical strategy, nation	0
14	5	To what extent do geopolitical narratives influence public opinion and foreign policy decisions?	foreign policy decisions, extent	1
15	5	How do shifts in global power dynamics impact the effectiveness of international institutions?	international institutions, shifts, effectiveness	2
16	3	How can we better use data to predict and prevent the next health crisis?	next health crisis, better use data, prevent, predict	2
17	3	How can we better predict and prevent disease outbreaks by analyzing community-level data?	prevent disease outbreaks, level data, better predict, analyzing community	2
\.


--
-- Data for Name: refresh; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh (question_id, id, user_id) FROM stdin;
16	1	1
17	2	3
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, title, role, images) FROM stdin;
1	Climate Change	Environmental Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044514Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c7c1fb6175ac7f5398bc2a19145afb9409c74214c805bacf84084b87f21f39b1,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044515Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d409aa3a2b3adf04653e16a34300dc505851a6f7d7f906bbc9fbd30a7a5df5cb,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044516Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f4d490b26ac3195e701bc1991a8c8d3c38cc26a442087ca3edd2ffede436be4a}
2	Artificial Intelligence	AI Ethicist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044525Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4b02ff8cdaa2fffdb66a37a2ce550a736427743070aab161f748c5c0a3b87e8b,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044526Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ca97b404b51e57c7b61e9f34ddaa7c3e7719ba65c8bd139ee1ecb46491b4cd34,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044527Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5af35783238068e3d64c1c2938f3850c7a99d0f6a5e58ad837944ea6441d82ad}
3	Public Health	Epidemiologist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044535Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c2315df35e1fabdc7ea55c940806ac6e807eee1e134ddb8e84ab08f1b2810995,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044536Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=06760db50babc7e6fc16128097dd0191528f7383413cd01c014d21f6333045bd,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044537Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=a83df5c79735fb4f250b53c70d6d4568cc0d9aa438a8bfe912f4eedb5379ae8c}
4	Financial Markets	Financial Analyst	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044546Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ad42dee7ca2ac98b720107c08f83ab2a0226649ef7034739556a76132658ced4,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044547Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=eedb6ea589b5578e43762efcda6afa910c7aa6029b1df3afbbb97de55f84943b,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044548Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=819fb3f517f09f3c1dbd586f4e465cb4791baf8ebcfd74feb6ef1b1a2dbd8f8b}
5	Geopolitics	Political Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044557Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6677fbd05933c907fc1cb039c112104d09874d12395a98ddb48bc259d0a97683,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044558Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=7a15fd6032ebcd4d28450d6b0f6703e5bc59e6a416326477927b682b0e26b4ff,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250525%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250525T044559Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=0c27a01346b3762dec79c1bd8e89522a6fda49f2e69210e11f71bf94a6f2afea}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, created_at, is_active) FROM stdin;
1	will	wfotso21@gmail.com	scrypt:32768:8:1$OnLBHdN4LXQTeQfc$ead440361432e96be939f1cb82590cc0570434d13b2ef653645bbf9ad3b51208ad60132018be9addc0f4468b411337eb3d160317215545fc6a862c5aa3e680b4	2025-05-24 19:49:45.911432	t
2	freecs	williamarnaud.fotso@g.austincc.edu	scrypt:32768:8:1$VvvYmCYmAV6cUHXG$305665d7a95e5dc29324e68be15d546523547e8cdde98faa0c6238426e452c87f0333fdec2427922c23d30bc4196682699a14bd4f4c6b2f399443e607a2ba404	2025-05-25 03:06:26.416899	t
3	freecs	will.fotso.pro@gmail.com	scrypt:32768:8:1$8gdUvJ0ifwIGQIZc$177a9d850547f0d54620d62616123bcaf2518d65f10967c1841a358d7f71c36d9d9a072416f05bf3af5c62de5d7f286e6427e8e03fe6a0e738c125328e2a8459	2025-05-25 15:09:56.76388	t
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videos (id, question_id, youtube_id, description, thumbnail) FROM stdin;
1	1	Y1yBO6DL1dI	Resilient Cities Webinar Series 14/15, Second Webinar: "Integrated climate action: Linking adaptation and mitigation"	https://i.ytimg.com/vi/Y1yBO6DL1dI/hqdefault.jpg
2	1	-mg_coJLNWc	English.	https://i.ytimg.com/vi/-mg_coJLNWc/hqdefault.jpg
3	1	uzFHWUa-8R4	The only way to stop climate change is to shift our mindsets. In this speech, the “Climate Mindset” is introduced, showing you how ...	https://i.ytimg.com/vi/uzFHWUa-8R4/hqdefault.jpg
4	1	IHMeRBEAHB0	Work Towards Understanding & Solving Climate Change By Applying Now.	https://i.ytimg.com/vi/IHMeRBEAHB0/hqdefault.jpg
5	1	N4QyfgYUMpA	Want to come work with Jason, one of our environmental scientists? ⬇️ E&A is currently hiring for: - Junior Environmental ...	https://i.ytimg.com/vi/N4QyfgYUMpA/hqdefault.jpg
6	2	G4H1N_yXBiA	What causes climate change (also known as global warming)? And what are the effects of climate change? Learn the human ...	https://i.ytimg.com/vi/G4H1N_yXBiA/hqdefault.jpg
7	2	N6t6QHQtdVw	Climate | How To Keep The Environment Safe? | Global Warming | Climate Change | What Causes Global Warming?	https://i.ytimg.com/vi/N6t6QHQtdVw/hqdefault.jpg
8	2	RoIpCJwX7-M	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/RoIpCJwX7-M/hqdefault.jpg
9	2	vPFmsE-mUEM	Decades long datasets let researchers at the Long-Term Ecological Research Network parse real impacts from fires, floods, and ...	https://i.ytimg.com/vi/vPFmsE-mUEM/hqdefault.jpg
10	3	2G9OjuVmvZo	Social scientist and communication expert Mathew Nisbet talks about the state of public climate literacy today. Video produced by ...	https://i.ytimg.com/vi/2G9OjuVmvZo/hqdefault.jpg
11	3	aMOton2SMk8	CivicSciTV Newsroom host Jake Krauss delves into the latest research on how social media has helped caracal conservation, ...	https://i.ytimg.com/vi/aMOton2SMk8/hqdefault.jpg
12	3	uzFHWUa-8R4	The only way to stop climate change is to shift our mindsets. In this speech, the “Climate Mindset” is introduced, showing you how ...	https://i.ytimg.com/vi/uzFHWUa-8R4/hqdefault.jpg
13	3	MHZMQLDr-OA	When playwright David Finnigan launched a new play in 2014, controversially titled "Kill Climate Deniers," he was not prepared ...	https://i.ytimg.com/vi/MHZMQLDr-OA/hqdefault.jpg
14	4	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
15	4	gV0_raKR2UQ	Check out Jabril's collab with "Above the Noise" about Deepfakes: https://www.youtube.com/watch?v=Ro8b69VeL9U Today, ...	https://i.ytimg.com/vi/gV0_raKR2UQ/hqdefault.jpg
16	4	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
17	4	2f3lt5yojHM	AI Ethics: The Future of Responsible Technology In this thought-provoking video, we delve into the critical and often ...	https://i.ytimg.com/vi/2f3lt5yojHM/hqdefault.jpg
18	4	zTEdmTeZ7Zo	Artificial Intelligence (AI) is rapidly transforming our lives, from how we work to how we interact. But with this power comes great ...	https://i.ytimg.com/vi/zTEdmTeZ7Zo/hqdefault.jpg
19	5	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
20	5	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
21	5	lsaoMcrSW6g	Artificial intelligence (AI) is transforming the world in unprecedented ways, but it also poses ethical challenges and dilemmas.	https://i.ytimg.com/vi/lsaoMcrSW6g/hqdefault.jpg
22	5	1LyacmzB1Og	Artificial intelligence provides a range of new opportunities in day-to-day life, but what are the downfalls? Frank Rudzicz is an ...	https://i.ytimg.com/vi/1LyacmzB1Og/hqdefault.jpg
23	5	UGHzKaAOOcA	Visit http://TED.com to get our entire library of TED Talks, transcripts, translations, personalized talk recommendations and more.	https://i.ytimg.com/vi/UGHzKaAOOcA/hqdefault.jpg
24	6	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
25	6	D4nOn5cp5CI	The Social Implications of AI: Ethical Concerns and Considerations Artificial Intelligence (AI) is transforming the way we live, work, ...	https://i.ytimg.com/vi/D4nOn5cp5CI/hqdefault.jpg
26	6	1LyacmzB1Og	Artificial intelligence provides a range of new opportunities in day-to-day life, but what are the downfalls? Frank Rudzicz is an ...	https://i.ytimg.com/vi/1LyacmzB1Og/hqdefault.jpg
27	6	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
28	6	UGHzKaAOOcA	Visit http://TED.com to get our entire library of TED Talks, transcripts, translations, personalized talk recommendations and more.	https://i.ytimg.com/vi/UGHzKaAOOcA/hqdefault.jpg
29	7	_luU3I03JwE	Epidemiology is the study of patterns of diseases. And most people might think that means epidemiologists are only studying ...	https://i.ytimg.com/vi/_luU3I03JwE/hqdefault.jpg
30	7	tYx-fO5hMA4	In this career spotlight video, an epidemiologist from CDC describes his work studying how diseases affect populations and why ...	https://i.ytimg.com/vi/tYx-fO5hMA4/hqdefault.jpg
31	7	Jd3gFT0-C4s	This video gives a simple overview of the most common types of epidemiological studies, their advantages and disadvantages.	https://i.ytimg.com/vi/Jd3gFT0-C4s/hqdefault.jpg
32	7	3IpE8dE4cVc	In this video we take a brief look at surveillance – the eyes and ears of public health. We'll have a look at passive, active, sentinel, ...	https://i.ytimg.com/vi/3IpE8dE4cVc/hqdefault.jpg
33	7	S5XRh47T420	Epidemiology underpins everything we do in public health and global health. Epidemiology is more than just research methods ...	https://i.ytimg.com/vi/S5XRh47T420/hqdefault.jpg
34	8	tYx-fO5hMA4	In this career spotlight video, an epidemiologist from CDC describes his work studying how diseases affect populations and why ...	https://i.ytimg.com/vi/tYx-fO5hMA4/hqdefault.jpg
35	8	t_eWESXTnic	Check out the updated video: https://youtu.be/Y6DPDC_Mf90 In this video we take a look at Public Health – the science and art of ...	https://i.ytimg.com/vi/t_eWESXTnic/hqdefault.jpg
36	8	UZUowxurkAI	I f you are about to start or thinking of doing a Master of Public Health degree, then this video will tell you what you should expect ...	https://i.ytimg.com/vi/UZUowxurkAI/hqdefault.jpg
37	8	S5XRh47T420	Epidemiology underpins everything we do in public health and global health. Epidemiology is more than just research methods ...	https://i.ytimg.com/vi/S5XRh47T420/hqdefault.jpg
38	8	_luU3I03JwE	Epidemiology is the study of patterns of diseases. And most people might think that means epidemiologists are only studying ...	https://i.ytimg.com/vi/_luU3I03JwE/hqdefault.jpg
39	9	Jd3gFT0-C4s	This video gives a simple overview of the most common types of epidemiological studies, their advantages and disadvantages.	https://i.ytimg.com/vi/Jd3gFT0-C4s/hqdefault.jpg
40	9	R1FIeiRiBYI	Public health surveillance is about more than just infectious disease epidemiology. It can include health surveillance on ...	https://i.ytimg.com/vi/R1FIeiRiBYI/hqdefault.jpg
41	9	7jHcXPRlN1w	Explore the significance and impact of surveillance and epidemiology on public health. Learn how these practices help identify, ...	https://i.ytimg.com/vi/7jHcXPRlN1w/hqdefault.jpg
42	9	3IpE8dE4cVc	In this video we take a brief look at surveillance – the eyes and ears of public health. We'll have a look at passive, active, sentinel, ...	https://i.ytimg.com/vi/3IpE8dE4cVc/hqdefault.jpg
43	9	e9p60RdK2Nc	Have you taken a statistics course? Are you preparing to take a statistics class? Refresh your memory on why data matters in ...	https://i.ytimg.com/vi/e9p60RdK2Nc/hqdefault.jpg
44	10	fgqgAPWbQ3o	The US is now spending more on debt interest than on defence—a staggering shift that could reshape financial markets.	https://i.ytimg.com/vi/fgqgAPWbQ3o/hqdefault.jpg
45	10	C-D2dfLA4og	High Inflation and Its Impact on Financial Markets.	https://i.ytimg.com/vi/C-D2dfLA4og/hqdefault.jpg
46	10	3colVhd6uHU	The current situation in the financial markets are getting worse, and the price of Bitcoin now risks hitting new lows. Join CryptoBirb ...	https://i.ytimg.com/vi/3colVhd6uHU/hqdefault.jpg
47	10	R8VBRCs2jTU	When central banks raise interest rates, the impact is felt far and wide. Mortgages become more expensive, house prices might fall ...	https://i.ytimg.com/vi/R8VBRCs2jTU/hqdefault.jpg
48	10	W74LjdrdKV0	Ever wondered why 2% inflation is the target? It's all about the numbers! Check out this explanation. #economics #inflation ...	https://i.ytimg.com/vi/W74LjdrdKV0/hqdefault.jpg
49	11	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
50	11	o0lTtJJnxAM	WHAT DOES A FINANCIAL ANALYST DO?// Ever wondered what's included in a financial analyst's day to day activities? Find out ...	https://i.ytimg.com/vi/o0lTtJJnxAM/hqdefault.jpg
51	11	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
52	11	LLPwRNgqkDg	Day In The Life - Financial Analyst Are you interested in becoming a financial analyst? The financial services industry is extremely ...	https://i.ytimg.com/vi/LLPwRNgqkDg/hqdefault.jpg
53	11	4d_wy6KFe6g	Sign up for Our Complete Finance Training with 57% OFF ...	https://i.ytimg.com/vi/4d_wy6KFe6g/hqdefault.jpg
54	12	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
55	12	JfdbQtz4zPs	Debt risks keep on piling with larger deficits and higher interest rates. It is important to see how will that impact investors going ...	https://i.ytimg.com/vi/JfdbQtz4zPs/hqdefault.jpg
56	12	GKtFFWPmOVs	Bridgeway Small-Cap Value Fund's John Montgomery has delivered positive, benchmark-beating returns over the fund's ...	https://i.ytimg.com/vi/GKtFFWPmOVs/hqdefault.jpg
57	12	GWVl7kZKNgc	Sign up for our complete finance training at 57% OFF ➡️https://bit.ly/4aoqxje ...	https://i.ytimg.com/vi/GWVl7kZKNgc/hqdefault.jpg
58	12	FvcCbgEPbO4	Best 9 stocks to buy and hold forever. Buy great company stock to build your wealth toward financial freedom in 2023. Take the ...	https://i.ytimg.com/vi/FvcCbgEPbO4/hqdefault.jpg
59	13	M2ouLcfvJ_M	Ahead of Trump's presidency, InterAction President and CEO Tom Hart provides insights into China's geopolitical strategy.	https://i.ytimg.com/vi/M2ouLcfvJ_M/hqdefault.jpg
60	13	wOoEFIXQEtY	In this video, we explore the intriguing insights from "The Foundations of Geopolitics" and discuss its implications for Russia's ...	https://i.ytimg.com/vi/wOoEFIXQEtY/hqdefault.jpg
61	13	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
62	13	BDqvzFY72mg	Professor Ian Shapiro introduces the class “Power and Politics in Today's World.” This course provides an examination of political ...	https://i.ytimg.com/vi/BDqvzFY72mg/hqdefault.jpg
63	14	igrB2GNK5lI	What's shaping the US foreign policy? A more inward-looking approach, with a focus on domestic priorities, might be the way ...	https://i.ytimg.com/vi/igrB2GNK5lI/hqdefault.jpg
64	14	689wnA1ZuVo	It's been an eventful first 100 days for the second Trump administration, which has featured tariff turmoil, shifting foreign policy and ...	https://i.ytimg.com/vi/689wnA1ZuVo/hqdefault.jpg
65	14	GrVsEZ8FyGM	Today I'm talking to Dr. Hasan Ünal, a full professor at the Department of Political Science and International Relations at Bashkent ...	https://i.ytimg.com/vi/GrVsEZ8FyGM/hqdefault.jpg
66	14	2WcgDhBzr30	IanExplains #KamalaHarris #DNC #ForeignPolicy #GZEROWorld #KamalaHarris #Obama #BarackObama #barackobamaquotes ...	https://i.ytimg.com/vi/2WcgDhBzr30/hqdefault.jpg
67	15	aZlPzPzLIAo	https://www.youtube.com/watch?v=FOM42ZJ9BrM&ab_channel=Markus%27Academy Short from Markus' Academy webinar with ...	https://i.ytimg.com/vi/aZlPzPzLIAo/hqdefault.jpg
68	15	BDqvzFY72mg	Professor Ian Shapiro introduces the class “Power and Politics in Today's World.” This course provides an examination of political ...	https://i.ytimg.com/vi/BDqvzFY72mg/hqdefault.jpg
69	15	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
70	15	vFb2dzw8BpU	Explore our offerings at http://www.primaryvision.co for a deeper understanding of our services. 🛢️   Discover location-based ...	https://i.ytimg.com/vi/vFb2dzw8BpU/hqdefault.jpg
71	16	R1FIeiRiBYI	Public health surveillance is about more than just infectious disease epidemiology. It can include health surveillance on ...	https://i.ytimg.com/vi/R1FIeiRiBYI/hqdefault.jpg
72	16	3IpE8dE4cVc	In this video we take a brief look at surveillance – the eyes and ears of public health. We'll have a look at passive, active, sentinel, ...	https://i.ytimg.com/vi/3IpE8dE4cVc/hqdefault.jpg
73	16	v7LfmcDSo0o	Several US Centers for Disease Control and Prevention websites and datasets related to HIV, LGBTQ people, youth health ...	https://i.ytimg.com/vi/v7LfmcDSo0o/hqdefault.jpg
74	16	kATQimRXcs4	Ever wonder what public health surveillance is or why it's important? Learn how we use public health surveillance to follow ...	https://i.ytimg.com/vi/kATQimRXcs4/hqdefault.jpg
75	16	_luU3I03JwE	Epidemiology is the study of patterns of diseases. And most people might think that means epidemiologists are only studying ...	https://i.ytimg.com/vi/_luU3I03JwE/hqdefault.jpg
76	17	kUlKRIMxpZQ	Outbreaks of infectious diseases can cause illness and can lead to deaths. Finding out what caused an outbreak can be ...	https://i.ytimg.com/vi/kUlKRIMxpZQ/hqdefault.jpg
77	17	3IpE8dE4cVc	In this video we take a brief look at surveillance – the eyes and ears of public health. We'll have a look at passive, active, sentinel, ...	https://i.ytimg.com/vi/3IpE8dE4cVc/hqdefault.jpg
78	17	zKZdnd8brqU	In this tutorial, we dive into the fundamentals of surveillance in public health and epidemiology. You'll learn how passive and ...	https://i.ytimg.com/vi/zKZdnd8brqU/hqdefault.jpg
79	17	_luU3I03JwE	Epidemiology is the study of patterns of diseases. And most people might think that means epidemiologists are only studying ...	https://i.ytimg.com/vi/_luU3I03JwE/hqdefault.jpg
80	17	vk6e0pCbh1k	At the heart of outbreaks are people! People are the ones who get sick, transmit diseases, and change the way they live in ...	https://i.ytimg.com/vi/vk6e0pCbh1k/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 196, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 1, true);


--
-- Name: fav_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_videos_id_seq', 3, true);


--
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_id_seq', 1, false);


--
-- Name: hidden_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_articles_id_seq', 10, true);


--
-- Name: hidden_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_questions_id_seq', 2, true);


--
-- Name: hidden_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_videos_id_seq', 1, false);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 17, true);


--
-- Name: refresh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_id_seq', 2, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videos_id_seq', 80, true);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: fav_articles fav_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_articles
    ADD CONSTRAINT fav_articles_pkey PRIMARY KEY (id);


--
-- Name: fav_videos fav_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_videos
    ADD CONSTRAINT fav_videos_pkey PRIMARY KEY (id);


--
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- Name: hidden_articles hidden_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_articles
    ADD CONSTRAINT hidden_articles_pkey PRIMARY KEY (id);


--
-- Name: hidden_questions hidden_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_questions
    ADD CONSTRAINT hidden_questions_pkey PRIMARY KEY (id);


--
-- Name: hidden_videos hidden_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_videos
    ADD CONSTRAINT hidden_videos_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: refresh refresh_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh
    ADD CONSTRAINT refresh_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: hidden_articles uq_user_article_hidden; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_articles
    ADD CONSTRAINT uq_user_article_hidden UNIQUE (user_id, article_id);


--
-- Name: hidden_questions uq_user_question_hidden; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_questions
    ADD CONSTRAINT uq_user_question_hidden UNIQUE (user_id, question_id);


--
-- Name: refresh uq_user_refresh; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh
    ADD CONSTRAINT uq_user_refresh UNIQUE (user_id, question_id);


--
-- Name: hidden_videos uq_user_video_hidden; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_videos
    ADD CONSTRAINT uq_user_video_hidden UNIQUE (user_id, video_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: articles articles_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE SET NULL;


--
-- Name: fav_articles fav_articles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_articles
    ADD CONSTRAINT fav_articles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fav_videos fav_videos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_videos
    ADD CONSTRAINT fav_videos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: hidden_articles hidden_articles_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_articles
    ADD CONSTRAINT hidden_articles_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE CASCADE;


--
-- Name: hidden_articles hidden_articles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_articles
    ADD CONSTRAINT hidden_articles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: hidden_questions hidden_questions_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_questions
    ADD CONSTRAINT hidden_questions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: hidden_questions hidden_questions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_questions
    ADD CONSTRAINT hidden_questions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: hidden_videos hidden_videos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_videos
    ADD CONSTRAINT hidden_videos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: hidden_videos hidden_videos_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hidden_videos
    ADD CONSTRAINT hidden_videos_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.videos(id) ON DELETE CASCADE;


--
-- Name: questions questions_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: refresh refresh_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh
    ADD CONSTRAINT refresh_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: refresh refresh_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh
    ADD CONSTRAINT refresh_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: videos videos_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE SET NULL;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

