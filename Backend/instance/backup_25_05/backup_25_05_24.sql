--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)

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
1	0.152	1	NewsAPI	A vicious cycle: How methane emissions from warming wetlands could exacerbate climate change	The latest study finds that emissions of the potent greenhouse gas might be higher than previously estimated.	Warming in the Arctic is intensifying methane emissions, contributing to a vicious feedback loop that could accelerate climate change even more, according to a new study published May 7 in Nature."Me… [+5013 chars]	https://www.sciencedaily.com/releases/2025/05/250515191232.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-15 23:12:32
2	0.152	1	NewsAPI	Big Oil Knew, Big Oil Lied: Fossil Fuel’s Long Strategy Of Deceit	A new UCS report reveals how fossil fuel giants spent decades disseminating climate disinformation, delaying action and fueling rising emissions and climate costs.	COTTBUS, GERMANY - APRIL 12: (Photo by Sean Gallup/Getty Images)\r\nGetty Images\r\nIn recent decades, increases in extreme weather have laid bare the mounting risk created by climate change, prompting b… [+7445 chars]	https://www.forbes.com/sites/feliciajackson/2025/05/14/big-oil-knew-big-oil-lied-fossil-fuels-long-strategy-of-deceit/	https://imageio.forbes.com/specials-images/imageserve/6824a1220179fafd5a554e3c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 14:01:35
3	0.152	1	NewsAPI	Trump administration dismisses scientists writing quadrennial climate report	The National Climate Assessment, a major publication produced every four years that summarizes the impacts of climate change in the U.S., is scheduled for publication in 2027.	Nearly 400 scientists across the United States were informed Monday afternoon that their services were no longer needed to help write a major report on climate change for the federal government.\r\nThe… [+4531 chars]	https://www.cbsnews.com/news/national-climate-assessment-report-scientists-fired/	https://assets3.cbsnewsstatic.com/hub/i/r/2025/04/30/75a4cdd4-74d0-425f-8ef6-f75a91332dd7/thumbnail/1200x630/637eaaf69205c5e0f5f48c059e8c5415/gettyimages-1197857412.jpg?v=fbebbf93950d87ce40fccd82890f0617	2025-04-30 01:34:33
4	0.152	1	NewsAPI	Climate Myths, Continued	“Climate change will make earth a living hell!” claims popular astrophysicist Neil DeGrasse Tyson. I don’t believe him. The media say, “All Arctic ice will... Read More\nThe post Climate Myths, Continued appeared first on The Daily Signal.	Climate change will make earth a living hell! claims popular astrophysicist Neil DeGrasse Tyson.\r\nI don’t believe him.\r\nThe media say, All Arctic ice will soon melt away! Polar bears are dying off! G… [+4000 chars]	https://www.dailysignal.com/2025/04/27/climate-myths-continued/	https://www.dailysignal.com/wp-content/uploads/2024/05/shareCardDailySignal.png	2025-04-27 14:00:00
5	0.152	1	NewsAPI	Climate wars are approaching — and they will redefine global conflict	Climate change's profound reshaping of conflict dynamics is already underway. The question facing humanity now is not whether we will confront these pressures, but how we will choose to do so.	Climate change is increasingly recognized\r\n not merely as an environmental crisis but as a threat multiplier, worsening political and economic tensions worldwide. Two factors\r\n — water scarcity and m… [+8828 chars]	https://www.livescience.com/planet-earth/climate-change/the-coming-climate-wars-how-water-scarcity-and-mass-migration-will-redefine-global-conflict-opinion	https://cdn.mos.cms.futurecdn.net/fzKh6aTAcUQHx8n8uSW7UK.jpg	2025-04-30 15:44:08
6	0.152	1	NewsDATA	Climate change intensifies heat-related risks for pregnant women globally, study warns	The analysis reveals that climate change has doubled the number of pregnancy heat-risk days in 90% of the 247 countries studied and 63% of cities worldwide over the past five years	ONLY AVAILABLE IN PAID PLANS	https://www.dtnext.in/news/tamilnadu/climate-change-intensifies-heat-related-risks-for-pregnant-women-globally-study-warns-834664	https://media.dtnext.in/h-upload/2024/04/27/750x450_818874-pregnant.webp	2025-05-24 01:30:05
7	0.073	1	NewsAPI	Scientists say NOAA cuts by Trump undermine improvements in hurricane forecasts	The Trump administration is targeting top climate and weather labs for cuts. Insiders worry about the impact on research and NOAA's ability to forecast severe weather like hurricanes and tornadoes.	MIAMI Weather and climate research are among the programs seeing big cuts by the Trump administration. \r\nHundreds of employees at NOAA the National Oceanic and Atmospheric Administration who work at … [+4401 chars]	https://www.npr.org/2025/04/25/nx-s1-5361474/noaa-cuts-hurricane-forecast-improvements-trump	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3900x2194+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F9e%2F96%2Fa366b9ba4a2a958fd8f8c1a55c33%2Fgettyimages-2177097712.jpg	2025-04-25 09:00:00
8	0.073	1	NewsAPI	Scientist sounds alarm after disturbing photo from Arctic expedition resurfaces: 'Feels like they could just sink at any moment'	"Science has a communication problem."	A famous photo from 2019 provides a snapshot of the changing climate and offers a glimpse of the future, scientists say.\r\nWhat's happening?\r\nThe image, featuring a first-person view of eight sled dog… [+2752 chars]	https://www.yahoo.com/news/scientist-sounds-alarm-disturbing-photo-121558211.html	https://s.yimg.com/ny/api/res/1.2/9SxazeP0bYNERRWxTm0fUQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_cool_down_737/4f5dfa89434f47d48c408c3b64f10f5c	2025-04-29 12:15:58
9	0.073	1	NewsAPI	Trump Dismisses Scientists Writing the National Climate Assessment	President Trump has dismissed hundreds of scientists working on the congressionally mandated National Climate Assessment, raising concerns about whether the void will be filled with pseudoscience	CLIMATEWIRE | The Trump administration on Monday dismissed all of the scientists working on the newest version of the National Climate Assessment, a sweeping report that outlines the growing dangers … [+4128 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/29/trump-dismisses-scientists-writing-the-national-climate-assessment-00314494	https://static.scientificamerican.com/dam/m/768e21512db2705d/original/Firefighters_watch_fire.jpg?m=1745935059.9&w=1200	2025-04-29 14:20:00
10	0.073	1	NewsAPI	Global temperatures stuck at near-record highs in April: EU monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3870 chars]	https://phys.org/news/2025-05-global-temperatures-stuck-highs-april.html	https://scx2.b-cdn.net/gfx/news/2025/scientists-are-unanimo.jpg	2025-05-08 17:09:48
42	0.152	3	NewsAPI	A siege on science: How Trump is undoing an American legacy	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	This story is part of a Grist package examining how President Trump's first 100 days in office have reshaped climate and environmental policy in the U.S.\r\nAcross seven decades and a dozen presidencie… [+16842 chars]	http://grist.org/science/american-climate-research-agencies-universities-trump-100-days/	https://grist.org/wp-content/uploads/2025/04/gutted-research.jpg?quality=75&strip=all	2025-04-28 08:45:40
11	0.073	1	NewsAPI	Late Pleistocene horse DNA uncovers two-way migrations and climate-linked population declines	The horse originated in North America around four million years ago. As changing sea levels created land bridges between continents, the horse traveled into Eurasia. A team of 57 international researchers—including 18 Indigenous scientists from the Lakota, sq…	The horse originated in North America around four million years ago. As changing sea levels created land bridges between continents, the horse traveled into Eurasia. A team of 57 international resear… [+9870 chars]	https://phys.org/news/2025-05-late-pleistocene-horse-dna-uncovers.html	https://scx2.b-cdn.net/gfx/news/2025/following-late-pleisto.jpg	2025-05-15 19:49:30
12	0.073	1	NewsAPI	Current Climate: Major Assault On California’s Environmental Rules	In this week's Current Climate, California's ability to set tough environmental rules is under attack; Elon Musk is out of ideas to revive Tesla; domestically sourced lithium-sulfur batteries	Plus: Elon Musk runs out of ideas to save Tesla; cheaper, domestically sourced lithium-sulfur batteries\r\nCurrent Climate brings you the latest news about the business of sustainability every Monday. … [+10833 chars]	https://www.forbes.com/sites/alanohnsman/2025/05/05/current-climate-a-major-assault-on-californias-environmental-rules/	https://imageio.forbes.com/specials-images/imageserve/681541b451ae5311ac7d37e4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 12:45:00
13	0.073	1	NewsAPI	The government just killed an essential way to assess climate risk	Cities, insurers, and the public used the Billion-Dollar Weather and Climate Disasters database to plan for the future. Now what will they do?	Nearly 30 billion-dollar storms rocked the United States last year. Thanks to the National Oceanic and Atmospheric Administrations disaster tracking database, we know that catastrophes are getting mo… [+7887 chars]	http://grist.org/climate/trump-noaa-billion-dollar-weather-and-climate-disasters-database/	https://grist.org/wp-content/uploads/2025/05/GettyImages-217471470d6.jpg?quality=75&strip=all	2025-05-14 08:45:00
14	0.073	1	NewsAPI	An EPA Without Science	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed, they constituted “the greatest and most consequential day o…	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed,… [+26919 chars]	https://www.nybooks.com/online/2025/05/16/an-epa-without-science/	https://www.nybooks.com/wp-content/uploads/2025/05/Mingle202505_4.jpeg	2025-05-16 14:36:44
15	0.073	1	NewsAPI	These protesters want you to reduce, repair and rewear	In this issue of our environmental newsletter, we hang out with protesters mending clothes in public, see what extreme weather our children can expect to experience and find out what science says about not mowing your lawn in May.	Hello, Earthlings! This is our weekly newsletter on all things environmental, where we highlight trends and solutions that are moving us to a more sustainable world. Keep up with the latest news on o… [+12239 chars]	https://www.cbc.ca/news/science/what-on-earth-mending-1.7535510	https://i.cbc.ca/1.7531216.1746809815!/fileImage/httpImage/image.jpeg_gen/derivatives/16x9_1180/participant-at-mend-in-public-day.jpeg?im=Resize%3D620	2025-05-15 18:25:45
16	0	1	NewsAPI	Why Snow in New Zealand’s Alps Turned an Alarming Shade of Red	Several years ago, snow in New Zealand's Southern Alps turned red, and while many blamed wildfires at the time, new research uncovers the true culprit.	During the Southern Hemisphere’s summer of 20192020, mountains in New Zealand turned red. New research finally explains why.\r\nResearchers have revealed that New Zealand’s Southern Alps turned red aft… [+2657 chars]	https://gizmodo.com/why-snow-in-new-zealands-alps-turned-an-alarming-shade-of-red-2000593615	https://gizmodo.com/app/uploads/2025/04/red-new-zealand-alps.jpg	2025-04-24 13:35:15
17	0	1	NewsAPI	Trump Torched Decades of Science in Just 100 Days—and the Fallout Is Global	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	Across seven decades and a dozen presidencies, Americas scientific prowess was arguably unmatched. At universities and federal agencies alike, researchers in the United States revolutionized weather … [+16614 chars]	https://gizmodo.com/trump-torched-decades-of-science-in-just-100-days-and-the-fallout-is-global-2000595721	https://gizmodo.com/app/uploads/2024/10/wildfire-fire-fighter.jpg	2025-05-04 14:00:29
18	0	1	NewsAPI	With Mark Carney’s Win, Trump Is Now Sandwiched Between Two Climate Leaders	The success of Canada's Mark Carney and Mexico's Claudia Sheinbaum is a chance to reflect on the best strategy to tackle climate change.	Mark Carney was elected to a full term as Canadas prime minister Monday with a campaign agenda focused squarely on pushing back on attacks from his counterpart to the South, President Donald Trump. I… [+5835 chars]	https://time.com/7281714/mark-carney-canada-mexico-climate-leadership-strategy/	https://api.time.com/wp-content/uploads/2025/04/mark-carney-climate-change.jpg?quality=85&w=1024&h=628&crop=1	2025-04-30 19:32:15
19	0	1	NewsAPI	El Paso Is Having Its Dustiest Year Since the Actual Dust Bowl	Drought, wind, and climate change are turning the Borderplex into a morass of airborne grit.	If you live in El Paso, Las Cruces, or Ciudad Juárez and feel like youve been inhaling the Chihuahuan Desert lately, youre not imagining things. The Borderplex region is experiencing its dustiest sea… [+2589 chars]	https://gizmodo.com/el-paso-is-having-its-dustiest-year-since-the-actual-dust-bowl-2000596987	https://gizmodo.com/app/uploads/2025/05/dust-el-paso.jpg	2025-05-04 10:00:17
20	0	1	NewsAPI	These trees exist in only one place on Earth. Now climate change and goats threaten their survival	The young plant, protected by a makeshift fence of wood and wire, is a kind of dragon’s blood tree — a species found only on the Yemeni island of Socotra...	SOCOTRA, Yemen (AP) On a windswept plateau high above the Arabian Sea, Sena Keybani cradles a sapling that barely reaches her ankle. The young plant, protected by a makeshift fence of wood and wire, … [+6680 chars]	https://www.yahoo.com/news/trees-exist-only-one-place-033450454.html	https://s.yimg.com/ny/api/res/1.2/76jHHoo4aAjkwEgKBbpcZA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/ap.org/a40d526c52f6feca4731304c079b9ac5	2025-05-19 03:34:50
21	0.1	2	NewsAPI	Researchers are studying how to minimize human impact on public lands	Recreation researchers are studying how to minimize human impact on public lands while maximizing accessibility.	Most people used to think the Crestone Needle, a jagged peak in Colorados Sangre de Cristo range, was unclimbable. Until, that is, Albert Ellingwood and Eleanor Davis reached its summit in 1916. Look… [+18121 chars]	https://undark.org/2025/04/28/keep-wild-places-wild/	https://undark.org/wp-content/uploads/2025/04/GettyImages-95606574_crop.jpg	2025-04-29 19:45:48
22	0.1	2	NewsAPI	With evolutionary AI, scientists find hidden keys for better land use	A new AI decision making tool effectively balances various complex trade-offs to recommend ways of maximizing carbon storage, minimizing economic disruptions and helping improve the environment and people's everyday lives. It uses evolutionary AI, a kind of d…	Using global land use and carbon storage data from the past 175 years, researchers at The University of Texas at Austin and Cognizant AI Labs have trained an artificial intelligence system to develop… [+4532 chars]	https://www.sciencedaily.com/releases/2025/05/250519131038.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-19 17:10:38
23	0.1	2	NewsAPI	How lichens are bringing stone to life and reconnecting us with the natural world	Lichens bridge the living and non-living – understanding them allows us to better see how to conserve our heritage, and also ourselves.	Lichens at Blenheim Palace. Ian Wallman , CC BY-SA\r\nLichens on stone, those “still explosions” as the great American poet Elizabeth Bishop named them, remain unseen to most, which is remarkable when … [+12169 chars]	https://theconversation.com/how-lichens-are-bringing-stone-to-life-and-reconnecting-us-with-the-natural-world-250944	https://images.theconversation.com/files/667882/original/file-20250514-62-imenzl.jpg?ixlib=rb-4.1.0&rect=0%2C160%2C1919%2C959&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-16 16:52:13
24	0	2	NewsAPI	NASA celebrated this employee's story of resilience, then tried to scrub it from the internet. Then fired her.	NASA's deletion of websites related to women in STEM and other DEIA programs erased this woman's story from the internet. NASA put it back online, but then they fired her.	"People see me now, and they just assume, 'oh, she had it easy,'" she says, but Rose Ferreira has had it anything but easy. The trajectory of her life has been so turbulent, in fact, that NASA, her p… [+19364 chars]	https://www.space.com/space-exploration/nasa-celebrated-this-employees-story-of-resilience-then-tried-to-scrub-it-from-the-internet-then-fired-her	https://cdn.mos.cms.futurecdn.net/yumnaqUeahy2igBxJrV2NX.jpg	2025-05-12 10:00:30
25	0	2	NewsAPI	Natural Resources Defense Council’s Climate Storytelling Fellows For 2025 Unveiled	EXCLUSIVE: Natural Resources Defense Council, the Black List, CAA Foundation, NBCUniversal and The Redford Center have named L.C. Killingsworth, Annika Marks and Yasir Masood as the recipients of their 2025 NRDC Climate Storytelling Fellowship. The trio was s…	EXCLUSIVE:Natural Resources Defense Council, the Black List, CAA Foundation, NBCUniversal and The Redford Center have named L.C. Killingsworth, Annika Marks and Yasir Masood as the recipients of thei… [+4883 chars]	http://deadline.com/2025/04/nrdc-climate-storytelling-fellows-2025-1236381464/	https://deadline.com/wp-content/uploads/2025/04/L.C.-Killingsworth-Annika-Marks-and-Yasir-Masood.jpg?w=1024	2025-04-30 19:01:43
26	0	2	NewsAPI	Brian Eno's Theory of Democracy	Organizing and generating variety in politics	[image by Brian Eno, from 77 Million Paintings. Eno says in this dialogue that he doesnt mind people using these images for non-commercial purposes]\r\nThis posts title is a little cheeky. Brian Eno do… [+22374 chars]	https://www.programmablemutter.com/p/brian-enos-theory-of-democracy	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fd3fe93b6-fd36-4c63-88f9-55a434046baf_1200x796.jpeg	2025-05-04 05:12:47
27	0	2	NewsAPI	An EPA Without Science	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed, they constituted “the greatest and most consequential day o…	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed,… [+26919 chars]	https://www.nybooks.com/online/2025/05/16/an-epa-without-science/	https://www.nybooks.com/wp-content/uploads/2025/05/Mingle202505_4.jpeg	2025-05-16 14:36:44
28	0	2	NewsAPI	Climate Change Weekly # 542 — More Ways Coal Improves the Economy and the Environment	Since misanthropic environmentalists and their Western-world-hating fellow travelers in academia and in the political realm discovered climate alarm as a fashionable and effective way to hamper economic growth and constrain consumerism, coal—long the foundati…	From THE HEARTLAND INSTITUTE\r\nBy H. Sterling Burnett\r\nSUBSCRIBE to Climate Change Weekly\r\n<ul><li>More Ways Coal Improves the Economy and the Environment</li><li>United Nations IPCC Hid the Medieval … [+15572 chars]	https://wattsupwiththat.com/2025/05/03/climate-change-weekly-542-more-ways-coal-improves-the-economy-and-the-environment/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/CCW-big-image-2.webp?fit=1024%2C512&ssl=1	2025-05-03 17:00:00
29	0	2	NewsAPI	What have Labor and the Coalition committed for the environment?	With Australia in the grip of what many consider a biodiversity crisis, here's what the major parties have promised when it comes to nature laws and the environment.	One face you may not have seen this election belongs to the Irwin's turtle (Elseya irwini).\r\nThe freshwater snapping turtle, named after zookeeper and wildlife documentarian Steve Irwin and his dad B… [+10408 chars]	https://www.abc.net.au/news/science/2025-05-01/federal-election-2025-nature-laws-environmental-policies/105203334	https://live-production.wcms.abc-cdn.net.au/5293b0741b6c1fd42f3417ff9040a0a1?impolicy=wcms_watermark_news&cropH=810&cropW=1440&xPos=0&yPos=135&width=862&height=485&imformat=generic	2025-04-30 19:30:00
30	0	2	NewsAPI	Weekly Climate and Energy News Roundup #642	“As in Mathematicks, so in Natural Philosophy [now called science], the Investigation of difficult Things by the Method of Analysis, ought ever to precede the Method of Composition. This Analysis consists in making Experiments and Observations, and in drawing…	Quote of the Week: As in Mathematicks, so in Natural Philosophy [now called science], the Investigation of difficult Things by the Method of Analysis, ought ever to precede the Method of Composition.… [+64353 chars]	https://wattsupwiththat.com/2025/05/19/weekly-climate-and-energy-news-roundup-642-2/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_scenic_glacier_bay_1e88fbmidjourney.webp?fit=1024%2C512&ssl=1	2025-05-19 09:00:00
31	0	2	NewsAPI	Trump’s Order to Expand Logging Threatens to Increase Climate-Fueled Wildfires	The president’s push to expand timber and fossil fuel production “is a double whammy on the climate.”…	On March 1, President Donald Trump signed an executive order titled Immediate Expansion of American Timber Production. The order claimed onerous Federal policies have hindered domestic timber product… [+16173 chars]	https://truthout.org/articles/trumps-order-to-expand-logging-threatens-to-increase-climate-fueled-wildfires/	https://truthout.org/app/uploads/2025/05/GettyImages-1355168071-scaled.jpg	2025-05-17 15:17:23
32	0	2	NewsAPI	Weekly Climate and Energy News Roundup #641	Quote of the Week: “We can always prove a definite theory wrong. Notice however that we never prove it right.” — Richard Feynman (1964)	Quote of the Week:We can always prove a definite theory wrong. Notice however that we never prove it right. \r\n Richard Feynman (1964)\r\nNumber of the Week: R squared of 0.018.\r\nTHIS WEEK:By Ken Haapal… [+59402 chars]	https://wattsupwiththat.com/2025/05/05/weekly-climate-and-energy-news-roundup-641/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_Scenic_landscape_of_the_badlands_at_petrified_forest-midjourney2.webp?fit=1024%2C512&ssl=1	2025-05-05 09:00:00
33	0	2	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #19	A listing of 27 news and opinion articles we found interesting and shared on social media during the past week: Sun, May 4, 2025 thru Sat, May 10, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. The …	Posted on 11 May 2025 by BaerbelW, Doug Bostrom\r\nA listing of 27 news and opinion articles we found interesting and shared on social media during the past week: Sun, May 4, 2025 thru Sat, May 10, 202… [+6412 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_19.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-11 06:50:03
34	0	2	NewsAPI	A Decade of Discovery: Felix Kunze’s Iconic Explorers Club Portraits	For over a century, The Explorers Club Annual Dinner has stood as a prestigious gathering, celebrating those who relentlessly push the boundaries of human endeavor. For the past ten years, photographer Felix Kunze has been its visual chronicler, capturing por…	For over a century, The Explorers Club Annual Dinner has stood as a prestigious gathering, celebrating those who relentlessly push the boundaries of human endeavor. For the past ten years, photograph… [+25897 chars]	https://petapixel.com/2025/05/20/a-decade-of-discovery-felix-kunzes-iconic-explorers-club-portraits/	https://petapixel.com/assets/uploads/2025/05/Explorers-Club-Felix-Kunze-Cover-2.jpg	2025-05-20 15:37:15
35	0	2	NewsAPI	Scientists want to track the world's biodiversity using DNA in the air	Scientists have found a way to sample DNA out of the air on a large scale — making it possible to one day track the health and well being of all kinds of species around the world.	Outside her cabin in northern Belize, Elizabeth Clare, a biodiversity scientist at York University, walks along a path. Everywhere she looks, it's teeming with life.\r\n"There's hibiscus flowers over t… [+7579 chars]	https://www.npr.org/2025/05/22/g-s1-67081/environmental-dna-edna-air-track-biodiversity	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3750x2109+0+195/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F20%2Fff%2Fd024870f48cfa455987e449aba74%2Fzbat-a-thon-2024-078.jpg	2025-05-22 10:00:00
36	0	2	NewsAPI	How Trump 2.0 Overturned Years of Climate Progress in 100 Days	From regulatory rollbacks to coal resurgence, here are some of Trump’s most consequential actions since January 20.	Part of the Series\r\nThis article by Earth.Org is published here as part of the global journalism collaboration Covering Climate Now.\r\nTrumps current approval rating is the lowest for any newly electe… [+18499 chars]	https://earth.org/100-days-of-trump-how-the-us-overturned-years-of-climate-progress/	https://truthout.org/app/uploads/2025/04/2025_0430-trump-1.jpg	2025-04-30 18:46:54
37	0	2	NewsAPI	The Trump administration says it will cut EPA staffing to Reagan-era levels	EPA announced plans to reorganize the agency, moving science-focused staff into different roles and reducing the overall number of employees.	The Trump administration announced plans\r\n for a significant reorganization of the Environmental Protection Agency on Friday, and signaled major cuts in staffing to come especially for the agency's s… [+4160 chars]	https://www.npr.org/2025/05/02/nx-s1-5385272/epa-environmental-protection-agency-cuts-trump-zeldin	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/8640x4860+0+450/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F54%2F08%2F849378c747c1b67d4199e38b5498%2Fap25071530079616.jpg	2025-05-03 01:15:09
38	0	2	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
39	0	2	NewsAPI	EGU2025 - How the week in Vienna unfolded	Note: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia mentioned below, be released sometime after the conference ends, I'll include links to the ones I …	Posted on 2 May 2025 by BaerbelW\r\nNote: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia ment… [+32724 chars]	https://skepticalscience.com/egu25-personal-diary.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-02 06:23:14
40	0	2	NewsAPI	A cheat sheet for why using ChatGPT is not bad for the environment	Arm yourself with knowledge	My post on why ChatGPT is not bad for the environment got a lot of readers. It ended up around 9000 words, which is a lot to drop on someone who wants to learn more about the topic. This post will be… [+28189 chars]	https://andymasley.substack.com/p/a-cheat-sheet-for-conversations-about	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3b68aed4-58d2-4e52-aaa0-074a113240c6_1842x1216.png	2025-04-30 05:47:01
41	0.152	3	NewsAPI	A vicious cycle: How methane emissions from warming wetlands could exacerbate climate change	The latest study finds that emissions of the potent greenhouse gas might be higher than previously estimated.	Warming in the Arctic is intensifying methane emissions, contributing to a vicious feedback loop that could accelerate climate change even more, according to a new study published May 7 in Nature."Me… [+5013 chars]	https://www.sciencedaily.com/releases/2025/05/250515191232.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-15 23:12:32
43	0.152	3	NewsDATA	Climate change intensifies heat-related risks for pregnant women globally, study warns	The analysis reveals that climate change has doubled the number of pregnancy heat-risk days in 90% of the 247 countries studied and 63% of cities worldwide over the past five years	ONLY AVAILABLE IN PAID PLANS	https://www.dtnext.in/news/tamilnadu/climate-change-intensifies-heat-related-risks-for-pregnant-women-globally-study-warns-834664	https://media.dtnext.in/h-upload/2024/04/27/750x450_818874-pregnant.webp	2025-05-24 01:30:05
44	0.073	3	NewsAPI	How Trump 2.0 Overturned Years of Climate Progress in 100 Days	From regulatory rollbacks to coal resurgence, here are some of Trump’s most consequential actions since January 20.	Part of the Series\r\nThis article by Earth.Org is published here as part of the global journalism collaboration Covering Climate Now.\r\nTrumps current approval rating is the lowest for any newly electe… [+18499 chars]	https://earth.org/100-days-of-trump-how-the-us-overturned-years-of-climate-progress/	https://truthout.org/app/uploads/2025/04/2025_0430-trump-1.jpg	2025-04-30 18:46:54
45	0.073	3	NewsAPI	Weekly Climate and Energy News Roundup #640	Quote of the Week: “In framing a government which is to be administered by men over men, the great difficulty lies in this: you must first enable the government to control the governed; and in the next place, oblige it to control itself.” — James Madison (178…	The Week That Was: 2025 04-26 (April 26, 2025)Brought to You by SEPP (www.SEPP.org)The Science and Environmental Policy Project\r\nQuote of the Week:In framing a government which is to be administered … [+70568 chars]	https://wattsupwiththat.com/2025/04/28/weekly-climate-and-energy-news-roundup-640/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/04/charlesrotter_Scenic_landscape_of_the_badlands_at_petrified_forest-midjourney.webp?fit=1024%2C512&ssl=1	2025-04-28 09:00:00
46	0.073	3	NewsAPI	Gambling our future over the climate crisis	We need to realize that the chance of winning anything in the climate denial game with far-right-wing governments is vanishingly small.	Politicians today are gambling with the future of the global population. Science clearly describes the seriousness of our current climate crisis, but much of it is ignored in favour of advice from th… [+4380 chars]	https://www.nationalobserver.com/2025/04/25/opinion/climate-crisis-gambling-election-2025	https://www.nationalobserver.com/sites/default/files/img/2025/04/24/poilievre_1_natasha.JPG	2025-04-25 09:09:06
47	0	3	NewsAPI	Trump Torched Decades of Science in Just 100 Days—and the Fallout Is Global	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	Across seven decades and a dozen presidencies, Americas scientific prowess was arguably unmatched. At universities and federal agencies alike, researchers in the United States revolutionized weather … [+16614 chars]	https://gizmodo.com/trump-torched-decades-of-science-in-just-100-days-and-the-fallout-is-global-2000595721	https://gizmodo.com/app/uploads/2024/10/wildfire-fire-fighter.jpg	2025-05-04 14:00:29
48	0	3	NewsAPI	$5 Million To Save The Doomsday Glacier, Can We Prevent Catastrophe?	Explore how a $5 million project aims to save the Doomsday Glacier, what’s at risk for sea level rise, and whether this bold plan could work.	TOPSHOT - Night view of glaciers , Antarctica on November 08, 2019. (Photo by Johan ORDONEZ / AFP) ... More (Photo by JOHAN ORDONEZ/AFP via Getty Images)\r\nAFP via Getty Images\r\nThe Thwaites Glacier i… [+7659 chars]	https://www.forbes.com/sites/monicasanders/2025/04/24/5-million-to-save-the-doomsday-glacier-can-we-prevent-catastrophe/	https://imageio.forbes.com/specials-images/imageserve/67ffd49e50101f02f4dfd0c9/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-24 13:30:00
49	0	3	NewsAPI	Trump’s Order to Expand Logging Threatens to Increase Climate-Fueled Wildfires	The president’s push to expand timber and fossil fuel production “is a double whammy on the climate.”…	On March 1, President Donald Trump signed an executive order titled Immediate Expansion of American Timber Production. The order claimed onerous Federal policies have hindered domestic timber product… [+16173 chars]	https://truthout.org/articles/trumps-order-to-expand-logging-threatens-to-increase-climate-fueled-wildfires/	https://truthout.org/app/uploads/2025/05/GettyImages-1355168071-scaled.jpg	2025-05-17 15:17:23
50	0	3	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #18	A listing of 23 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 27, 2025 thru Sat, May 3, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. Th…	Posted on 4 May 2025 by BaerbelW, Doug Bostrom, John Hartz\r\nA listing of 23 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 27, 2025 thru Sa… [+5111 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_18.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-04 06:10:27
51	0	3	NewsAPI	Forests to farms to floods: Land use shifts threaten water quality and communities	Converting forests to agricultural or urban land near streams increases nitrogen and sediment runoff, harming aquatic ecosystems and raising water treatment costs. The study predicts significant declines in drinking water quality by 2070 without intervention.…	<ul><li>Converting forests to agricultural or urban land near streams increases nitrogen and sediment runoff, harming aquatic ecosystems and raising water treatment costs. The study predicts signific… [+6774 chars]	https://www.naturalnews.com/2025-05-08-land-use-shifts-threaten-water-quality-and-communities.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Home-Kitchen-Countertop-Water-Filter.jpg	2025-05-08 06:00:00
52	0	3	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #20	A listing of 29 news and opinion articles we found interesting and shared on social media during the past week: Sun, May 11, 2025 thru Sat, May 17, 2025.\nPlugging the Weather & Climate Livestream planned to start on May 28\nDuring the past week and thanks to A…	Posted on 18 May 2025 by BaerbelW, Doug Bostrom\r\nA listing of 29 news and opinion articles we found interesting and shared on social media during the past week: Sun, May 11, 2025 thru Sat, May 17, 20… [+9062 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_20.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-18 07:39:18
53	0	3	NewsAPI	New Antarctic study reveals Medieval Warm Period had far less sea ice than today	A genetic analysis of ancient elephant seal remains, led by Dr. Andrew Wood, reveals that during the Roman Warm Period (250 BCE-400 CE) and the Medieval Warm Period (950-1250 CE), Antarctic sea ice was significantly less extensive than today. This challenges …	<ul><li>A genetic analysis of ancient elephant seal remains, led by Dr. Andrew Wood, reveals that during the Roman Warm Period (250 BCE-400 CE) and the Medieval Warm Period (950-1250 CE), Antarctic s… [+7501 chars]	https://www.naturalnews.com/2025-05-22-medieval-warm-period-had-far-less-sea-ice.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Winter-Antarctica-Ice-Iceberg-Sun-Sky.jpg	2025-05-22 06:00:00
127	0	9	NewsDATA	Custom Lasik Market Size Trends and Forecast by Application, Type, and Geography	According to Market Research Intellect, the global Custom Lasik market under the Internet, Communication and Technology category is expected to register notable growth from 2025 to 2032. Key drivers such as advancing technologies, changing consumer behavior, and evolving market dynamics	ONLY AVAILABLE IN PAID PLANS	https://www.openpr.com/news/4033131/custom-lasik-market-size-trends-and-forecast-by-application	https://cdn.open-pr.com/L/5/L523930539_g.jpg	2025-05-23 09:35:42
54	0	3	NewsAPI	Weekly Climate and Energy News Roundup #641	Quote of the Week: “We can always prove a definite theory wrong. Notice however that we never prove it right.” — Richard Feynman (1964)	Quote of the Week:We can always prove a definite theory wrong. Notice however that we never prove it right. \r\n Richard Feynman (1964)\r\nNumber of the Week: R squared of 0.018.\r\nTHIS WEEK:By Ken Haapal… [+59402 chars]	https://wattsupwiththat.com/2025/05/05/weekly-climate-and-energy-news-roundup-641/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_Scenic_landscape_of_the_badlands_at_petrified_forest-midjourney2.webp?fit=1024%2C512&ssl=1	2025-05-05 09:00:00
55	0	3	NewsAPI	EOS-09 mission unsuccessful, ISRO begins technical analysis	India launched its 101st satellite, EOS-09, aboard PSLV-C61 at 5:59am from Sriharikotas Satish Dhawan Space Centre. The Earth observation satellite, based on RISAT-1 heritage, features synthetic aperture radar for high-resolution imaging in all weather and li…	At the break of dawn, a plume of fire lit up the skies above Sriharikota. At precisely 5:59am, the Indian Space Research Organisation (ISRO) launched its 101st space mission, placing the Earth Observ… [+4467 chars]	https://economictimes.indiatimes.com/news/science/isro-launches-eos-09-aboard-pslv-c61-boosting-indias-surveillance-and-remote-sensing-powers/articleshow/121243650.cms	https://img.etimg.com/thumb/msid-121243708,width-1200,height-630,imgsize-9216,overlay-economictimes/articleshow.jpg	2025-05-18 00:44:23
56	0	3	NewsAPI	Students and researchers team up to customize smoke sensors	When traditional devices couldn’t provide the air quality data needed to monitor prescribed burns’ effects on local communities, Stanford Radio Club students stepped in to help.	When Stanford wildfire researchers ran into challenges deploying sensors to monitor smoke from prescribed burns, they turned to a reliable resource of innovation: students. \r\nStudents in the Stanford… [+7442 chars]	https://news.stanford.edu/stories/2025/04/students-researchers-customized-smoke-sensors-prescribed-burns	https://news.stanford.edu/__data/assets/image/0026/169280/00-SMesh.JPG	2025-04-24 00:00:00
57	0	3	NewsAPI	EGU2025 - How the week in Vienna unfolded	Note: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia mentioned below, be released sometime after the conference ends, I'll include links to the ones I …	Posted on 2 May 2025 by BaerbelW\r\nNote: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia ment… [+32724 chars]	https://skepticalscience.com/egu25-personal-diary.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-02 06:23:14
58	0	3	NewsAPI	Poilievre's plans for "woke" research spook Canadian academics	The Conservative leader's vow to eliminate poorly-defined "ideology" from public university research funding is an echo of the rhetoric used by US President Donald Trump to justify massive funding cuts to climate research south of the border and alarming rese…	Pierre Poilievre is vowing to eliminate "woke ideology" from public university research funding, echoing rhetoric used by US President Donald Trump to make massive funding cuts to that country's clim… [+6377 chars]	https://www.nationalobserver.com/2025/04/24/news/poilievre-woke-research-platform-election-2025	https://www.nationalobserver.com/sites/default/files/img/2025/04/23/img_9872-2.jpg	2025-04-24 09:09:04
59	0	3	NewsAPI	Climate Change and Livestock Production	Dr. Banarsi LalLivestock production is an essential component of world agriculture, contributing to food security, nutrition, poverty eradication and economic growth. About 30 per cent of the Earth’s terrestrial areas are occupied with livestock systems, sust…	Dr. Banarsi LalLivestock production is an essential component of world agriculture, contributing to food security, nutrition, poverty eradication and economic growth. About 30 per cent of the Earth’s… [+8365 chars]	https://statetimes.in/climate-change-and-livestock-production-2/	https://statetimes.in/wp-content/uploads/2024/06/Climate-Change-Threat-or-Opportunity-@aura-emagazine.jpg	2025-05-04 17:29:56
60	0	3	NewsDATA	Sun, sand and saving the planet?	Gross value added generated by marine and coastal tourism reached a high of $1.37 trillion in 2019.	ONLY AVAILABLE IN PAID PLANS	https://www.straitstimes.com/singapore/environment/in-seeing-the-world-can-you-help-save-the-planet	https://cassette.sphdigital.com.sg/image/straitstimes/8563584b2c805300462f8ea190eef9bb097d8636e3c8b35ce9c5ee6678f7e5a4	2025-05-23 21:00:00
61	0.16	4	NewsAPI	Foundation Principles of Generative AI, Part 7	In this episode, you will learn foundational principle number seven for using generative AI effectively. You will discover why always summarizing your inputs prevents subtle errors that AI models often make. You will find out how this simple step gives key po…	In this episode, you will learn foundational principle number seven for using generative AI effectively. You will discover why always summarizing your inputs prevents subtle errors that AI models oft… [+5394 chars]	https://www.christopherspenn.com/2025/05/foundation-principles-of-generative-ai-part-7/	https://www.christopherspenn.com/wp-content/uploads/2025/05/Foundation-Principles-of-Generative-AI-Part-7.png	2025-05-20 09:41:56
62	0.16	4	NewsAPI	Customize Amazon Nova models to improve tool usage	In this post, we demonstrate model customization (fine-tuning) for tool use with Amazon Nova. We first introduce a tool usage use case, and gave details about the dataset. We walk through the details of Amazon Nova specific data formatting and showed how to d…	Modern large language models (LLMs) excel in language processing but are limited by their static training data. However, as industries require more adaptive, decision-making AI, integrating tools and… [+23692 chars]	https://aws.amazon.com/blogs/machine-learning/customize-amazon-nova-models-to-improve-tool-usage/	https://d2908q01vomqb2.cloudfront.net/f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59/2025/04/23/iML-18065-SolutionOverviewjpg-911x630.jpg	2025-04-28 17:47:59
63	0.08	4	NewsAPI	The top quantum computing jobs in 2025	Quantum research is a growing field with several available career paths for tech professionals, including quantum software engineer and quantum application specialist.	Amid all the conversations about AI and machine learning, quantum computing has quietly asserted itself as a new sector to watch. The processing power of quantum computing enables the calculation of … [+13236 chars]	https://www.techtarget.com/searchcio/feature/The-top-quantum-computing-jobs	https://www.techtarget.com/rms/onlineimages/code_g684641103.jpg	2025-04-24 09:33:00
64	0.08	4	NewsDATA	ChatGPT: Everything you need to know about the AI chatbot	ChatGPT, OpenAI’s text-generating AI chatbot, has taken the world by storm since its launch in November 2022. What started asThe post ChatGPT: Everything you need to know about the AI chatbot appeared first on Daily News World News Turkish Turkey.	ONLY AVAILABLE IN PAID PLANS	https://turks.us/chatgpt-everything-you-need-to-know-about-the-ai-chatbot-38/	https://techcrunch.com/wp-content/uploads/2023/03/GettyImages-1462188043-e1686340799615.jpg	2025-05-23 15:15:01
65	0.08	4	NewsDATA	ChatGPT: Everything you need to know about the AI-powered chatbot	ChatGPT, OpenAI’s text-generating AI chatbot, has taken the world by storm since its launch in November 2022. What started as a tool to supercharge productivity through writing essays and code with short text prompts has evolved into a behemoth with 300 million weekly active users. 2024 was a big year for OpenAI, from its partnership [...]	ONLY AVAILABLE IN PAID PLANS	https://techcrunch.com/2025/05/23/chatgpt-everything-to-know-about-the-ai-chatbot/	https://techcrunch.com/wp-content/uploads/2023/03/GettyImages-1462188043-e1686340799615.jpg?w=1200	2025-05-23 14:53:59
66	0	4	NewsAPI	Making AI models more trustworthy for high-stakes settings	Researchers made a technique that improves the trustworthiness of machine-learning models, which could help improve the accuracy and reliability of AI predictions for high-stakes settings such health care.	The ambiguity in medical imaging can present major challenges for clinicians who are trying to identify disease. For instance, in a chest X-ray, pleural effusion, an abnormal buildup of fluid in the … [+5713 chars]	https://www.sciencedaily.com/releases/2025/05/250501164119.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-01 20:41:19
67	0	4	NewsAPI	Prompt Like a Pro: AI Prompt Writing for Salesforce Admins	Let’s face it: As a Salesforce Admin, you’re already juggling workflows, security settings, automations, and the ever-growing stack of requests from across your org. Now, toss in generative artificial intelligence (AI) and suddenly, everyone expects you to be…	Lets face it: As a Salesforce Admin, you’re already juggling workflows, security settings, automations, and the ever-growing stack of requests from across your org. Now, toss in generative artificial… [+8588 chars]	https://admin.salesforce.com/blog/2025/prompt-like-a-pro-ai-prompt-writing-for-salesforce-admins	https://d3nqfz2gm66yqg.cloudfront.net/images/20250428153519/Text-w-Two-Photos-1.png	2025-05-13 15:30:08
68	0	4	NewsAPI	Making AI models more trustworthy for high-stakes settings	MIT researchers made a technique that improves the trustworthiness of machine-learning models, which could help improve the accuracy and reliability of AI predictions for high-stakes settings such health care.	The ambiguity in medical imaging can present major challenges for clinicians who are trying to identify disease. For instance, in a chest X-ray, pleural effusion, an abnormal buildup of fluid in the … [+5693 chars]	https://news.mit.edu/2025/making-ai-models-more-trustworthy-high-stakes-settings-0501	https://news.mit.edu/sites/default/files/images/202504/MIT_Conformal-Prediction-01.jpg	2025-05-01 04:00:00
69	0	4	NewsAPI	At the Venice Biennale, design through flexible thinking	The 2025 Venice Biennale Architecture Exhibition opens May 10, with MIT professor of the practice Carlo Ratti as its curator.	When the Venice Biennales 19th International Architecture Exhibition launches on May 10, its guiding theme will be applying nimble, flexible intelligence to a demanding world an ongoing focus of its … [+7391 chars]	https://news.mit.edu/2025/venice-biennale-design-through-flexible-thinking-0429	https://news.mit.edu/sites/default/files/images/202504/mit-carlo-ratti-venice-biennale-00.jpg	2025-04-29 04:00:00
70	0	4	NewsAPI	How generative AI is playing out in the media industry	GenAI is proving a double-edged sword in society at large, but especially in the creative industries. SA Mathieson delves below the headlines	Many writers, illustrators and musicians see generative artificial intelligence (GenAI) as a threat, something that exploits their creative work to produce algorithmic knock-offs, undermining their a… [+10575 chars]	https://www.computerweekly.com/feature/How-Generative-AI-is-playing-out-in-media-industry	https://www.computerweekly.com/visuals/ComputerWeekly/HeroImages/AI-robot-creative-human-brain-WhoisDanny-adobe.jpg	2025-05-06 07:15:00
71	0	4	NewsAPI	Why agency and cognition are fundamentally not computational	Article URL: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full\nComments URL: https://news.ycombinator.com/item?id=43990107\nPoints: 4\n# Comments: 0	“To live is to know.”\r\n(Maturana, 1988)\r\n“Between the stimulus and the response, there is a space. And in that space lies our freedom and power to choose our responses.”\r\n(Frankl, 1946, 2020)\r\n“Volun… [+166123 chars]	https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full	https://images-provider.frontiersin.org/api/ipx/w=1200&f=png/https://www.frontiersin.org/files/Articles/1362658/fpsyg-15-1362658-HTML/image_m/fpsyg-15-1362658-g001.jpg	2025-05-14 23:04:23
72	0	6	NewsAPI	Why agency and cognition are fundamentally not computational	Article URL: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full\nComments URL: https://news.ycombinator.com/item?id=43990107\nPoints: 4\n# Comments: 0	“To live is to know.”\r\n(Maturana, 1988)\r\n“Between the stimulus and the response, there is a space. And in that space lies our freedom and power to choose our responses.”\r\n(Frankl, 1946, 2020)\r\n“Volun… [+166123 chars]	https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full	https://images-provider.frontiersin.org/api/ipx/w=1200&f=png/https://www.frontiersin.org/files/Articles/1362658/fpsyg-15-1362658-HTML/image_m/fpsyg-15-1362658-g001.jpg	2025-05-14 23:04:23
73	0.378	7	NewsDATA	MediPharm Labs Cautions Shareholders about Dissident Nominees' Governance Failures at Check-Cap Ltd.	TORONTO, May 23, 2025 (GLOBE NEWSWIRE) -- MediPharm Labs Corp. (TSX: LABS) ("MediPharm”, the "Company”, or "we”), a pharmaceutical company specialized in precision-based cannabinoids, today provided its shareholders with information related to three of the six directors (the "Dissident Nominees”) nominated by Apollo Technology Capital Corporation ("Apollo”) to stand for election at MediPharm's Annual and Special Meeting of Shareholders on June 16, 2025. All dollar figures in this news release are in U.S. dollars.The Company believes events that have transpired over the past two years at Check-Cap Ltd. ("Check-Cap”), a Nasdaq-listed company, provide valuable insight into the dubious tactics, motives and character of the individuals now seeking to take control of the board of directors of MediPharm (the "MediPharm Board”).The extraordinary sequence of events at Check-Cap has been notable for its evidence of poor governance practices, lack of transparency and disclosure to shareholders, questionable allocation of cash resources, high turnover, public shareholder disputes, failure to execute on promises and destruction of shareholder value.Most alarmingly, Check-Cap has been transferring millions of dollars of cash to Apollo and its subsidiaries - companies led by Dissident Nominee and shareholder, Regan McGee. The cash transfers were characterized as being tied to a merger agreement with an Apollo subsidiary that was announced 14 months ago but has yet to be completed.Chris Taves, Chair of MediPharm, commented:"The troubling fact pattern involving three of the Dissident Nominees raises several red flags. The MediPharm Board urges its shareholders to exercise a high level of caution before considering voting for any of McGee's nominees to run your Company.”Summary of Recent Events at Check-Cap1Symetryx Corporation ("Symetryx”), a Toronto-based investment firm and owner of 5.8% of Check-Cap's shares according to public filings, led a successful campaign in 2023 to stop a business combination with Keystone Dental Holdings (the "Keystone Transaction”) proposed by the Check-Cap board (the "Check-Cap Board”). According to its website and other public sources, Symetryx also owns shares of Nobul, a company founded and led by Dissident Nominee, Regan McGee.A vote by Check-Cap shareholders on December 18, 2023 resulted in the termination of the 2023 Keystone Transaction, and the replacement of the entire Check-Cap Board with five nominees proposed by Symetryx. Within five weeks following this vote, four of the five directors duly elected by shareholders had resigned, and were replaced with four new Check-Cap Board members. One of the directors who had been appointed, resigned the following day.On March 25, 2024, Check-Cap announced the terms of a proposed business combination (the "Check-Cap Nobul Merger”) with Nobul AI Corp. ("Nobul”). According to the announcement, the Check-Cap Nobul Merger was subject to the approval of Check-Cap shareholders at a special meeting "expected to occur in the coming months.”Approximately 14 months after the initial announcement of the Check-Cap Nobul Merger, there is currently still no indication that a shareholder vote on the Check-Cap-Nobul Merger has ever occurred or been scheduled, no recent announcement on the expected timing to complete or terminate the Check-Cap Nobul Merger, and no indication that Check-Cap has been seeking an alternative transaction to the Check-Cap Nobul Merger.Despite no formal business combination having been completed, on July 28, 2024 and September 8, 2024, the Check-Cap Board ratified and approved a loan agreement for a $6 million loan to Nobul, and the transfer of $11 million to a segregated bank account "to fund the pursuit of accretive acquisition targets or other growth initiatives of Nobul and for no other purposes.” At least $2.8 million of the funds had already been spent by the end of 2024.As set out in Check-Cap's business combination agreement with Nobul ("BCA”) amended on September 8, 2024, funds in the segregated account can be disbursed with the authorization of just two individuals: Check-Cap chairman David Lontini and Nobul chairman Mr. McGee, both of whom are among Apollo's six Dissident Nominees for the MediPharm Board.1 All events described in this news release are based on Check-Cap's filings with the U.S. Securities and Exchange Commission beginning in June 2023 and public news releases. We urge shareholders to review those source materials. Our summary may be limited by any deficiencies in that disclosure.Check-Cap's Connections to the Dissident NomineesThree of the six Dissident Nominees now seeking election to the MediPharm Board, namely David Lontini, Alan D. Lewis II and Regan McGee, have been directly involved in the events at Check-Cap:Mr. Lontini is "Active Chairman” of the Check-Cap Board, having been initially appointed to the board in January 2024 to replace one of the directors who had resigned shortly after being elected. He was subsequently elected as a director in April 2024, became Chairman in July 2024 and "Active Chairman” in November 2024.Mr. Lewis is a director of Check-Cap, and became the latest individual appointed as CFO of Check-Cap on April 6, 2025. Mr. Lewis is a colleague of a fourth Dissident Nominee, Demetrios Mallios, with both being co-founders and officers of The Aeon Group, Inc.Mr. McGee, in his capacity as Nobul's founder, CEO and Chairman, has been Check-Cap's intended merger counterparty and is designated to become the merged entity's CEO and Chairman upon completion of the Check-Cap Nobul Merger, if such transaction actually closes. Mr. McGee is also Chairman and CEO of Apollo. Important Questions Raised for MediPharm ShareholdersMediPharm believes that activist shareholders often follow the same "playbook” in their pursuit to take control of target companies, especially when they have been successful utilizing such tactics in the past. We are concerned that the events at Check-Cap, and the direct involvement of three of the Dissident Nominees now seeking election to the MediPharm Board, represent significant risks for the Company's shareholders.MediPharm urges its shareholders to consider the following questions:1) How did it benefit Check-Cap shareholders to transfer millions of dollars to Nobul? Was this in the best interests of Check-Cap, or only Regan McGee and the company he controls?2) Does Apollo plan to replace some or all of its Dissident Nominees with new appointees, similar to what happened at Check-Cap? Which ones would remain to serve on the MediPharm Board?3) Has Apollo already identified specific merger or acquisition targets it intends for MediPharm to pursue? Are such merger candidates connected with any of the Dissident Nominees or their affiliates or associates?4) Do the Dissident Nominees, and particularly those who have been directly involved with Check-Cap, have a track record that qualifies them to take control of another public company, in particular one in a highly specialized sector?5) Do Apollo and its Dissident Nominees have a better plan in place for MediPharm, as compared to the overlapping group that took control of Check-Cap?Additional Background Information on the Events at Check-CapTo supplement the information provided above, a selected summary of developments at Check-Cap over the past two years follows.Check-Cap is an Israel-based company whose trials of its colorectal cancer screening test did not meet expectations, causing the Check-Cap Board to announce its intention to pursue strategic options in June 2023.In July 2023, Symetryx announced a non-binding proposal to acquire Check-Cap, identifying Check-Cap's $37.4 million cash balance as the basis for the company's valuation. Symetryx requested immediate engagement with the Check-Cap Board, but did not respond to an email sent by Check-Cap's chairman on August 10, 2023 to propose a conversation.Check-Cap entered into the Keystone Transaction on August 16, 2023, subject to the approval of Check-Cap shareholders.Symetryx outlined its opposition to the Keystone Transaction in a news release dated October 17, 2023. Issues identified by Symetryx included, among other things, a lack of synergies, an inflated valuation, and Check-Cap's cash burn rate. Symetryx put forward a list of five directors it planned to nominate to replace the existing Check-Cap board.On October 19, 2023, Check-Cap responded with a letter to shareholders which described an extensive bidding process lasting several months and involving outreach by an independent advisor to 150 companies, 42 non-binding proposals and detailed discussions with six prospective merger partners. The letter said that the selected partner, Keystone Dental Holdings, had generated revenue of $61 million in 2022 and $33.4 million in the first half of 2023.On December 18, 2023, Check-Cap shareholders voted in favour of all five directors nominated by Symetryx, voted against the Keystone Transaction, and voted against a reverse share split.In a December 22, 2023 news release thanking Check-Cap shareholders for supporting its bid, Symetryx president Barry Shiff commented: "We believe, as many of our fellow shareholders do, that there is tremendous upside potential at [Check-Cap]. We encourage the newly constituted [Check-Cap] Board to identify a more appropriate merger candidate.”During the month of January 2024, Check-Cap, now under the control of the new Check-Cap Board, announced the resignation of four of the five directors elected at the shareholder meeting the previous month. The fifth was removed in April 2024.Check-Cap's auditors resigned in February 2024 due to "certain control concerns that arose during the first quarter of 2024 within the company.”On March 25, 2024, Check-Cap announced the Check-Cap Nobul Merger. In the news release, Check-Cap's Chairman Paul Medeiros, who had been appointed to the Check-Cap Board on January 21, 2024 (four days earlier than the other three newly appointed directors), said the transaction followed a "comprehensive and thorough review of strategic alternatives.” There was no reference in the announcement to Symetryx owning shares of Nobul.On April 1, 2024, Check-Cap's largest shareholder and its director filed a Schedule 13D with the SEC describing a number of concerns about the state of affairs at Check-Cap. These included "chaotic turnover in leadership,” the resignation of the auditor, and Check-Cap's "alarming cash-burn rate.” The shareholder's issues with the Check-Cap Nobul Merger also included, "the large potential payout to Nobul if [Check-Cap's] shareholders do not approve the [BCA] and related transactions, and the process for [Check-Cap's] negotiation and entry into the [BCA], considering, among other things, that Nobul appears to be a portfolio company of Symetryx Corporation.” Several days later, that shareholder entered into a support agreement and committed to voting in favour of the Check-Cap Nobul Merger.On July 28, 2024 and September 8, 2024, Check-Cap's Board approved a loan agreement for a $6 million loan to Nobul. The Check-Cap Board also approved the amendment to the BCA with Nobul, with the specific purpose of enabling the loan and obligating Check-Cap to deposit $11 million into a segregated account in order to fund Nobul's growth initiatives. The funds appear to have been transferred to an account held by RBC in Toronto under the name "Nobul AI Corp.” in August 2024. Check-Cap did not disclose any consideration received from Nobul in return for this generous and unconventional gesture.The funds loaned or approved for eventual transfer to Nobul represented the vast majority of the approximately $18 million of cash Check-Cap had on hand at June 30, 2024. This issue was compounded by the fact that Check-Cap had incurred an approximately $6.8 million operating loss in the first half of 2024. We are unable to determine how much cash was remaining at the end of 2024, as Check-Cap, with Dissident Nominee Alan D. Lewis II as CFO, recently announced it was unable to meet its deadline for filing year-end financial results.Nobul amalgamated with Apollo on August 26, 2024. We can find no record of this amalgamation having been disclosed to Check-Cap shareholders, who may continue to be under the impression that their company is planning to merge with an entity that no longer exists in the form described to them.On October 7, 2024, Check-Cap received a derivative claim against its directors and Nobul. The claim relates to "corporate governance issues and entity level control, including issues relating to the appointment of certain board members, the validity of certain board decisions, and questions related to the legality of the [BCA governing the Check-Cap-Nobul Merger] and certain cash transactions and whether such transactions are in [Check-Cap's] best interest.” Check-Cap said the derivative action is frivolous and it will vigorously defend itself.Since January 2024, seven different directors have resigned from Check-Cap's five-person board (including three who purportedly resigned for "personal reasons” on the same day, and another who resigned one day after being appointed), and an eighth was removed by shareholder vote following a request by Symetryx for his removal, notwithstanding that he was included as a proposed director put forth by Symetryx at the December 18, 2023 meeting of shareholders.Check-Cap has also experienced unusually high turnover at the CEO and CFO positions during the same period. In less than 1.5 years, at least three individuals have held the CEO or equivalent title and four individuals have held the CFO title (not including one CEO and one CFO who were each appointed but apparently never held the respective positions).Check-Cap's share price history is illustrative of the effect on shareholder value of the events described above. Its closing share price on May 22, 2025 was $0.85. This compares to a share price of $2.47 on March 26, 2024 after the Check-Cap-Nobul Merger was announced, and $2.36 on December 19, 2023 after the previous board was unseated. Check-Cap's share price was $2.35 on August 17, 2023 following the announcement of the Keystone Transaction which Symetryx fought to prevent.Nasdaq has twice notified Check-Cap that its shares are subject to potential delisting because they have traded below the minimum $1.00 bid price for more than 30 days. The reverse share split proposed by the previous Check-Cap board at the December 2023 shareholder meeting and successfully opposed by Symetryx may have prevented or delayed the shares falling below the $1.00 threshold required to maintain its Nasdaq listing.To the Company's knowledge, Check-Cap has not updated its shareholders on the status of the Check-Cap Nobul Merger since the initial announcement, other than to disclose the derivative action, the amendment to the BCA to allow for the transfer of cash to Nobul described above, as well as further updates with regards to the transfer of cash. In fact, there is no indication that Check-Cap has issued a single news release since March 25, 2024. The MediPharm Board urges its shareholders to exercise a high level of caution before considering voting for the same group of individuals responsible for the failures at Check-Cap to run the Company, and to treat any statements or promises made by the Dissident Nominees with a high level of skepticism.Vote for the Highly Qualified MediPharm NomineesIn light of the concerns raised by multiple parties in litigation with Mr. McGee, as well as the issues the Company has raised in previous news releases about the qualifications and suitability of the Dissident Nominees collectively, MediPharm urges shareholders to vote only using the GREEN proxy or GREEN voting instruction form in support of all of the Company's nominees and resolutions.To ensure your vote is counted, shareholders are encouraged to proactively contact their broker to obtain their 16-digit control number associated with the GREEN management proxy. Once received, you can cast your vote by visiting www.medipharmlabsagm.com.You may receive materials or outreach from the dissident - please disregard any such communications and vote only using the GREEN proxy in support of the Company's nominees.About MediPharm LabsFounded in 2015, MediPharm Labs specializes in the development and manufacture of purified, pharmaceutical-quality cannabis concentrates, active pharmaceutical ingredients (API) and advanced derivative products utilizing a Good Manufacturing Practices certified facility with ISO standard-built clean rooms. MediPharm Labs has invested in an expert, research driven team, state-of-the-art technology, downstream purification methodologies and purpose-built facilities for delivery of pure, trusted and precision-dosed cannabis products for its customers. MediPharm Labs develops, formulates, processes, packages and distributes cannabis and advanced cannabinoid-based products to domestic and international medical markets.In 2021, MediPharm Labs received a Pharmaceutical Drug Establishment License from Health Canada, becoming the only company in North America to hold a commercial-scale domestic Good Manufacturing Practices License for the extraction of multiple natural cannabinoids. This GMP license was the first step in the Company's current foreign drug manufacturing site registration with the US FDA.In 2023, MediPharm acquired VIVO Cannabis Inc., which expanded MediPharm's reach to medical patients in Canada via Canna Farms medical ecommerce platform, and in Australia and Germany through Beacon Medical Australia PTY Ltd. and Beacon Medical Germany GMBH. This acquisition also included Harvest Medical Clinics in Canada which provides medical cannabis patients with Physician consultations for medical cannabis education and prescriptions.The Company carries out its operations in compliance with all applicable laws in the countries in which it operates.Shareholder Voting Assistance:If you have any questions or require any assistance in executing your GREEN proxy or voting instruction form, please call Sodali & Co at:North American Toll-Free Number: 1.888.777.2059Outside North America, Banks, Brokers and Collect Calls: 1.289.695.3075Email: assistance@investor.sodali.comNorth American Toll-Free Facsimile: 1.877.218.5372For up-to-date information and assistance in voting please visit: www.medipharmlabsagm.comInvestor Contact:MediPharm Labs Investor RelationsTelephone: +1 416.913.7425Email: investors@medipharmlabs.comMedia Contact:John VincicOakstrom Advisors+1 (647) 402-6375john@oakstrom.comCautionary Note Regarding Forward-Looking Information:This news release contains "forward-looking information” and "forward-looking statements” (collectively, "forward-looking statements”) within the meaning of the applicable Canadian securities legislation. All statements, other than statements of historical fact, are forward-looking statements and are based on expectations, estimates and projections as at the date of this news release. Any statement that involves discussions with respect to predictions, expectations, beliefs, plans, projections, objectives, assumptions, future events or performance (often but not always using phrases such as "expects”, or "does not expect”, "is expected”, "anticipates” or "does not anticipate”, "plans”, "budget”, "scheduled”, "forecasts”, "estimates”, "believes” or "intends” or variations of such words and phrases or stating that certain actions, events or results "may” or "could”, "would”, "might” or "will” be taken to occur or be achieved) are not statements of historical fact and may be forward-looking statements. In this news release, forward-looking statements relate to, among other things: timing of the Annual and Special Meeting, any impacts to MediPharm shareholders of the actions relating to the Dissident Nominees described herein, and any outcomes resulting from the circumstances and information cited herein. Forward-looking statements are necessarily based upon a number of estimates and assumptions that, while considered reasonable, are subject to known and unknown risks, uncertainties, and other factors which may cause the actual results and future events to differ materially from those expressed or implied by such forward-looking statements. Such factors include, but are not limited to: general business, economic, competitive, political and social uncertainties; the inability of MediPharm Labs to obtain adequate financing; the delay or failure to receive regulatory approvals; and other factors discussed in MediPharm Labs' continuous disclosure filings, available on the SEDAR+ website at www.sedarplus.ca. There can be no assurance that such statements will prove to be accurate, as actual results and future events could differ materially from those anticipated in such statements. Accordingly, readers should not place undue reliance on the forward-looking statements and information contained in this news release. Except as required by law, MediPharm Labs assumes no obligation to update the forward-looking statements of beliefs, opinions, projections, or other factors, should they change.	ONLY AVAILABLE IN PAID PLANS	https://www.manilatimes.net/2025/05/24/tmt-newswire/globenewswire/medipharm-labs-cautions-shareholders-about-dissident-nominees-governance-failures-at-check-cap-ltd/2120241	https://www.manilatimes.net/manilatimes/uploads/images/2025/05/24/635612.jpg	2025-05-23 17:07:33
74	0.328	7	NewsDATA	Elon Musk's X down for tens of thousands of users	Stephanie Venn-Watson studied longevity long before she realized it, she says. The veterinary epidemiologist was recruited by the U.S. Navy to take care of aging dolphins in 2001.Venn-Watson planned to research the dolphins to get a better understanding of infectious diseases, but “instead, very quickly pivoted to studying chronic diseases and diseases of aging,” which she’s done for more than 20 years, she told CNBC Make It in February.While dolphins in the wild typically live to around 20 years old, Navy dolphins were living much longer beyond the ages of 40 and 50, Venn-Watson says. Though some dolphins were developing conditions like chronic inflammation, high cholesterol and even changes in their brains similar to that of Alzheimer’s, others were completely healthy in old age.After analyzing thousands of samples collected over the span of about 50 years, Venn-Watson and her team were able to determine what the healthiest aging dolphins had in common. “We thought it was going to be omega-3′s, because all they eat are fish. And instead, it was C15:0, a saturated fatty acid I had never heard of,” she says.Venn-Watson and her team discovered a new essential fatty acid, C15:0, which like omega-3′s, can improve health outcomes in mammals. And additional research by experts outside of her team have supported this claim. Their discovery marks the “first essential fatty acid to be found in more than ninety years,” a finding which earned Venn-Watson a spot on CNBC’s 2025 Changemakers List earlier this year.With her husband, a Navy physician, Venn-Watson started Seraphina Therapeutics, and developed a C15:0 supplement for humans. She also published a book about her findings called “The Longevity Nutrient,” in March.To up her intake of the longevity nutrient in her own diet, Venn-Watson eats certain foods that are high in C15:0.Here’s the No. 1 food she eats to get more of the fatty acid.‘I’ll have a cheese snack almost every day’When Venn-Watson plans her meals, she always aims to maximize her intake of C15:0. “Key ways I do that are through grass-fed cheeses that come from grass-fed animals; those have some of the highest C15:0 levels,” she says.Often, it’s her daily snack that helps her increase how much of the longevity nutrient she’s getting: “I’ll have a cheese snack almost every day.”Pairing the grass-fed cheeses she eats with crackers helps her get yet another vital nutrient for her body: fiber.“We’ve also learned fiber has a lot of importance. So, classic cheese and crackers (high-fiber crackers, so not the ones that are chock full of processed carbs),” Venn-Watson says.“And pecorino, for example, has some of the highest nutritious content, including C15:0.”And though she discovered a new essential fatty acid, she still prioritizes the tried-and-true fatty acids like omega-3s. “My diet is high in fish. I probably have fish every day and dairy fat,” she says.In addition to the food she eats, Venn-Watson goes the extra mile to improve her health by taking certain vitamins: “I supplement with what the Navy invested 10 years in making, which is the pure C15:0 supplement.”Want to boost your confidence, income and career success? Take one (or more!) of Smarter by CNBC Make It’s expert-led online courses, which aim to teach you the critical skills you need to succeed that you didn’t learn in school. Topics include earning passive income online, mastering communication and public speaking skills, acing your job interview, and practical strategies to grow your wealth. Use coupon code MEMORIAL to purchase any course at a discount of 30% off the regular course price (plus tax). Offer valid from 12:00 am Eastern Time (“ET”) on May 19, 2025, through 11:59 pm ET on June 2, 2025. Terms and restrictions apply.Plus, sign up for CNBC Make It’s newsletter to get tips and tricks for success at work, with money and in life, and request to join our exclusive community on LinkedIn to connect with experts and peers.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcsandiego.com/news/business/money-report/elon-musks-x-down-for-tens-of-thousands-of-users/3833200/	https://media.nbcsandiego.com/2025/05/108148823-17478473902025-05-21t170638z_878539062_rc2gmea1h6up_rtrmadp_0_usa-safrica.jpeg?fit=1700%2C1000&quality=85&strip=all	2025-05-24 06:44:36
75	0.233	7	NewsAPI	How social media and telemedicine are transforming patient care	In today’s digital world, health care is no longer confined to hospital walls. Social media platforms are influencing health behaviors, while telemedicine technologies are redefining patient-doctor interactions. But are these innovations improving health care…	In today’s digital world, health care is no longer confined to hospital walls. Social media platforms are influencing health behaviors, while telemedicine technologies are redefining patient-doctor i… [+5545 chars]	https://kevinmd.com/2025/05/how-social-media-and-telemedicine-are-transforming-patient-care.html	https://kevinmd.com/wp-content/uploads/6742ff30-3696-4dba-b481-9dd7bb401b24-1024x683.png	2025-05-07 15:00:52
76	0.196	7	NewsAPI	(In)coherence between Chagas disease policy and the experiences of those affected in Mexico: The need for a transdisciplinary approach	Chagas disease, caused by the parasite Trypanosoma cruzi, remains a significant public health challenge in México, symbolizing systemic neglect in healthcare. Despite longstanding efforts to control its transmission, there are critical gaps in the alignment o…	Abstract\r\nChagas disease, caused by the parasite Trypanosoma cruzi, remains a significant public health challenge in México, symbolizing systemic neglect in healthcare. Despite longstanding efforts t… [+51115 chars]	https://journals.plos.org/plosntds/article?id=10.1371/journal.pntd.0013052	https://journals.plos.org/plosntds/article/figure/image?id=10.1371/journal.pntd.0013052.g002&size=inline	2025-05-07 14:00:00
77	0.196	7	NewsAPI	Strengthening the role of community pharmacy in HPV vaccination roll-out in Serbia at national and local levels: A pharmacy-based education approach	Cervical cancer is a significant public health concern in Serbia, with high morbidity and mortality rates (27 and 14.2 per 100,000 women, respectively in 2020). The primary cause of cervical cancer is human papillomavirus (HPV) infection, and HPV vaccination …	Abstract\r\nCervical cancer is a significant public health concern in Serbia, with high morbidity and mortality rates (27 and 14.2 per 100,000 women, respectively in 2020). The primary cause of cervica… [+39474 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322584	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322584.g001&size=inline	2025-04-29 14:00:00
78	0.094	7	NewsAPI	The Case for Single-Payer: Reduce Healthcare Cost with Administrative Simplification and Restore Professional Autonomy	Privatization of publicly funded Medicare and Medicaid, managed care, and “value-based payment”1 have failed to reduce cost or improve population health despite over 30 years of trying, and a new paradigm for health policy is needed. This article summarizes k…	Privatization of publicly funded Medicare and Medicaid, managed care, and value-based payment1 have failed to reduce cost or improve population health despite over 30 years of trying, and a new parad… [+15437 chars]	https://www.counterpunch.org/2025/05/22/365176/	https://www.counterpunch.org/wp-content/uploads/2025/05/Screenshot-2025-05-21-at-5.42.50-PM-880x630.png	2025-05-22 05:58:32
79	0.094	7	NewsAPI	In Defense of “Doing Your Own Research”	The corporate media recently freaked out over the idea that the public is more interested in doing their own research than blindly trusting the experts. On April 29, HHS Secretary Robert F. Kennedy appeared on the Dr. Phil show to discuss his first 100 days i…	The corporate media recently freaked out over the idea that the public is more interested in doing their own research than blindly trusting the experts.\r\nOn April 29, HHS Secretary Robert F. Kennedy … [+14407 chars]	https://www.activistpost.com/in-defense-of-doing-your-own-research/	https://www.activistpost.com/wp-content/uploads/2025/05/Study-creative-commons-1210x642.jpg.webp	2025-05-14 16:00:00
80	0.094	7	NewsAPI	Carleton North health-care clinic gets $2.1M to take 800 patients off waitlist	Doctor's bid to launch health-care team to serve an area of 10,000 people gets provincial funding to hire support staff and other healthcare professionals.	Another collaborative care clinic has officially launched in New Brunswick, advancing one of the key commitments made by the Holt government to increase access to primary health care.\r\nThe Carleton N… [+2942 chars]	https://www.cbc.ca/news/canada/new-brunswick/family-medicine-team-collaborative-care-clinic-1.7537492	https://i.cbc.ca/1.7537607.1747427275!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/n-b-health-minister-dr-john-dornan-dr-stuart-lockhart-and-premier-susan-holt.jpg?im=Resize%3D620	2025-05-16 21:14:04
81	0.094	7	NewsAPI	Despite viral videos, methylene blue won't improve your mood or cognition, experts say	A chemical first synthesized as a textiles dye in the 1800s is making the rounds on social media as an easy way to boost mood and enhance cognition. However, experts say it's only really useful in treating very specific medical conditions.	A chemical first synthesized in the 1800s as a textiles dye is making the rounds on social media as an easy way to boost mood and enhance cognition. However, experts say it's only really useful in tr… [+7837 chars]	https://www.cbc.ca/radio/whitecoat/methylene-blue-explainer-1.7531116	https://i.cbc.ca/1.7529807.1746718018!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/methylene-blue.jpg?im=Resize%3D620	2025-05-11 08:00:00
82	0.094	7	NewsAPI	Mobile health clinics bring care to California's unhoused	Using a nuanced approach to care management, Healthcare in Action uses mobile health clinics to move California's unhouse population into stable housing.	For Ben Kaska, a physician assistant and the vice president of development and partnerships at Healthcare in Action, running a mobile health unit is all about finding the best tool for the problem at… [+6525 chars]	https://www.techtarget.com/patientengagement/feature/Mobile-health-clinics-bring-care-to-Californias-unhoused	https://www.techtarget.com/rms/onlineimages/location_g1319143350.jpg	2025-05-12 09:57:00
83	0.094	7	NewsAPI	Factors affecting online health information-seeking behavior in young and middle-aged patients with stroke	This study aimed to explore the characteristics of online health information-seeking behavior and the influencing factors among young and middle-aged Chinese patients with stroke. The participants of this study were 230 young and middle-aged patients with str…	Abstract\r\nThis study aimed to explore the characteristics of online health information-seeking behavior and the influencing factors among young and middle-aged Chinese patients with stroke. The parti… [+53202 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0321791	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0321791.t003&size=inline	2025-04-28 14:00:00
84	0.094	7	NewsAPI	Predictors of high tobacco use prevalence among adults in Autonomous Province of Vojvodina, Serbia	Introduction Introducing a sub-national surveillance system could significantly improve the monitoring of factors related to current tobacco use prevalence and the impacts of tobacco control measures. This study utilizes initial data from the newly establishe…	Introduction\r\nGlobal monitoring of tobacco use prevalence is an essential part of the MPOWER policy set of measures for control of the global tobacco epidemic. According to the World Health Organizat… [+40980 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0320647	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0320647.g003&size=inline	2025-04-25 14:00:00
85	0.094	7	NewsDATA	This doctor discovered ‘the longevity nutrient': The 1 food she always eats to be sure she gets enough of it	Swiss brand On is quickly emerging as a global challenger in the sportswear market.The company, which sells premium-priced athletic shoes and apparel, reported net sales for the three-month period ended March 31 rose over 40% to 726.6 million Swiss francs (US$869 million) compared with the year prior.Analysts say the brand has been able to capture market share from legacy competitors like Nike and Adidas through innovative products and timing. “The main thing they really understood was they went for the aesthetic of the shoe,” said Aneesha Sherman, managing director at Bernstein. “It’s really like no other silhouette that the consumer had seen. That is what drove the initial success.” Around the time of On’s 2021 initial public offering, Nike saw declining sales during a pullback from wholesale retailers and stalling innovation. Adidas also experienced rocky quarters as it ended its controversial partnership with Kanye West. Nike and Adidas still own a combined 58% of global market share, according to FactSet, while On makes up a little less than 3%. But its earnings growth rate has outpaced both companies in recent quarters. “It was luck as well as design that got them that huge scale in the years 2021, onwards, with that mass consumer,” Sherman said. “For the first time, retailers were actually going out there and looking for emerging, high-growth brands to take that [shelf] space and On was right there for them.” Now, Nike is mounting a turnaround plan under its new CEO, Elliott Hill, which analysts say could pose a potential headwind to On.The company also faces tariffs uncertainty along with the rest of the sportswear industry. Around 90% of On’s sneakers are manufactured in Vietnam, according the company, which President Donald Trump has said could face a 46% import duty. Watch the video above to learn more about how On is taking on sportswear competitors and how it plans to navigate tariffs.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcsandiego.com/news/business/money-report/this-doctor-discovered-the-longevity-nutrient-the-1-food-she-always-eats-to-be-sure-she-gets-enough-of-it/3833204/	https://media.nbcsandiego.com/2025/05/108150032-1748013217519-gettyimages-640045312-smc050117-17.jpeg?fit=1700%2C1000&quality=85&strip=all	2025-05-24 07:00:01
86	0	7	NewsAPI	Drew Pinsky Is America’s Doctor. Whatever That Means Now.	Dr. Drew shaped how we think about sex, addiction, and public health. His recent evolution to free-speech warrior says worlds about physicians, the media, and “truth” in the MAHA era.	AT FIRST THE interview looks like any youd find on network TV: two men, both in sport coats, set off in boxes beside each other, speaking directly to the camera. The chyron beneath them has Ask Dr. D… [+20367 chars]	https://www.menshealth.com/health/a64353693/who-is-dr-drew-pinsky/	https://hips.hearstapps.com/hmg-prod/images/hlh050125feadrdrew-001-67eee80296de1.jpg?crop=0.907xw:0.303xh;0.0753xw,0.341xh&resize=1200:*	2025-04-24 13:00:00
87	0	7	NewsAPI	SafeHavenMD: One Physician's Mission To Create A Safe Space For Doctors	According to surveys, 20.9% to 43.2% of physicians meet the criteria for depression. Burnout affects nearly half, driven largely by administrative overload and long hours. And substance use, estimated between 10% and 15%, is widely believed to be underreporte…	Every day in the United States, a doctor dies by suicide. It's a sad statistic, one that hits especially close to home for Dr. Nishant Patel, a urologist by training and the founder of SafeHavenMD, a… [+4655 chars]	https://www.ibtimes.com/safehavenmd-one-physicians-mission-create-safe-space-doctors-3773804	https://d.ibtimes.com/en/full/4601298/dr-nishant-patel.jpg	2025-05-16 19:43:10
88	0	7	NewsAPI	Science requires ethical oversight – without federal dollars, society’s health and safety are at risk	There are several steps between research on seemingly esoteric subjects and breakthrough medical treatments. Ethical oversight at every stage ensures science and society ultimately benefit.	Brain organoids, pictured here, raise both many medical possibilities and ethical questions. NIAID/Flickr, CC BY-SA\r\nAs the Trump administration continues to make significant cuts to NIH budgets and … [+9984 chars]	https://theconversation.com/science-requires-ethical-oversight-without-federal-dollars-societys-health-and-safety-are-at-risk-252794	https://images.theconversation.com/files/666577/original/file-20250507-56-hp6347.jpg?ixlib=rb-4.1.0&rect=106%2C0%2C3819%2C1908&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-09 12:51:16
89	0	7	NewsAPI	Is Hyperbaric Oxygen Therapy a Scam?	Once known only as a claustrophobic treatment for infected wounds and carbon monoxide poisoning, hyperbaric oxygen therapy is now being used, off-label and without insurance coverage, to treat everything from attention issues to infertility.	In late 2022, Jean Hannah Edelstein was diagnosed with early-stage breast cancer and had a double mastectomy seven weeks later. It was an expedient and straightforward process, as far as major cancer… [+16473 chars]	http://www.thecut.com/article/is-hyperbaric-oxygen-therapy-a-scam.html	https://pyxis.nymag.com/v1/imgs/682/0b2/b0109e59568c4ded6d2cd868bdf7437481-hyperbaric-chambers-03.1x.rsocial.w1200.jpg	2025-04-29 12:00:45
90	0	7	NewsAPI	Behavioural analysis of factors influencing prescribing for neurodegenerative diseases: A rapid review	Background The incidence and prevalence of neurodegenerative diseases (NDs) are growing worldwide. In an environment where healthcare resources are already stretched, it is important to optimise treatment choice to help alleviate healthcare burden. This rapid…	Abstract\r\nBackground\r\nThe incidence and prevalence of neurodegenerative diseases (NDs) are growing worldwide. In an environment where healthcare resources are already stretched, it is important to op… [+59769 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322324	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322324.g002&size=inline	2025-05-06 14:00:00
91	0	7	NewsAPI	Knowledge, attitudes, and practices of cardiac rehabilitation and barriers to referral among cardiologists in Saudi Arabia: A cross-sectional survey	Background Cardiac rehabilitation (CR) is an effective secondary prevention intervention, yet it is globally underutilized. Physicians play a key role in CR uptake by eligible patients through encouragement and referral to the program. This study assessed the…	Citation: Almoghairi AM, OBrien J, Doubrovsky A, Duff J (2025) Knowledge, attitudes, and practices of cardiac rehabilitation and barriers to referral among cardiologists in Saudi Arabia: A cross-sect… [+34896 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0323694	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0323694.g002&size=inline	2025-05-16 14:00:00
92	0	7	NewsAPI	Effectiveness of care coordination interventions delivered to stroke survivors in low and middle-income countries: Systematic review and meta-analysis protocol	Background Stroke survivors have complex and long-term care needs requiring navigation of multiple care services and providers. Care coordination interventions provide wholistic care that meets the needs of the patient and improves their clinical outcomes and…	Citation: Osei SKJ, Danso-Appiah A (2025) Effectiveness of care coordination interventions delivered to stroke survivors in low and middle-income countries: Systematic review and meta-analysis protoc… [+33288 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0324040	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0324040.g001&size=inline	2025-05-16 14:00:00
93	0.373	8	NewsDATA	Elon Musk's X down for tens of thousands of users	Stephanie Venn-Watson studied longevity long before she realized it, she says. The veterinary epidemiologist was recruited by the U.S. Navy to take care of aging dolphins in 2001.Venn-Watson planned to research the dolphins to get a better understanding of infectious diseases, but “instead, very quickly pivoted to studying chronic diseases and diseases of aging,” which she’s done for more than 20 years, she told CNBC Make It in February.While dolphins in the wild typically live to around 20 years old, Navy dolphins were living much longer beyond the ages of 40 and 50, Venn-Watson says. Though some dolphins were developing conditions like chronic inflammation, high cholesterol and even changes in their brains similar to that of Alzheimer’s, others were completely healthy in old age.After analyzing thousands of samples collected over the span of about 50 years, Venn-Watson and her team were able to determine what the healthiest aging dolphins had in common. “We thought it was going to be omega-3′s, because all they eat are fish. And instead, it was C15:0, a saturated fatty acid I had never heard of,” she says.Venn-Watson and her team discovered a new essential fatty acid, C15:0, which like omega-3′s, can improve health outcomes in mammals. And additional research by experts outside of her team have supported this claim. Their discovery marks the “first essential fatty acid to be found in more than ninety years,” a finding which earned Venn-Watson a spot on CNBC’s 2025 Changemakers List earlier this year.With her husband, a Navy physician, Venn-Watson started Seraphina Therapeutics, and developed a C15:0 supplement for humans. She also published a book about her findings called “The Longevity Nutrient,” in March.To up her intake of the longevity nutrient in her own diet, Venn-Watson eats certain foods that are high in C15:0.Here’s the No. 1 food she eats to get more of the fatty acid.‘I’ll have a cheese snack almost every day’When Venn-Watson plans her meals, she always aims to maximize her intake of C15:0. “Key ways I do that are through grass-fed cheeses that come from grass-fed animals; those have some of the highest C15:0 levels,” she says.Often, it’s her daily snack that helps her increase how much of the longevity nutrient she’s getting: “I’ll have a cheese snack almost every day.”Pairing the grass-fed cheeses she eats with crackers helps her get yet another vital nutrient for her body: fiber.“We’ve also learned fiber has a lot of importance. So, classic cheese and crackers (high-fiber crackers, so not the ones that are chock full of processed carbs),” Venn-Watson says.“And pecorino, for example, has some of the highest nutritious content, including C15:0.”And though she discovered a new essential fatty acid, she still prioritizes the tried-and-true fatty acids like omega-3s. “My diet is high in fish. I probably have fish every day and dairy fat,” she says.In addition to the food she eats, Venn-Watson goes the extra mile to improve her health by taking certain vitamins: “I supplement with what the Navy invested 10 years in making, which is the pure C15:0 supplement.”Want to boost your confidence, income and career success? Take one (or more!) of Smarter by CNBC Make It’s expert-led online courses, which aim to teach you the critical skills you need to succeed that you didn’t learn in school. Topics include earning passive income online, mastering communication and public speaking skills, acing your job interview, and practical strategies to grow your wealth. Use coupon code MEMORIAL to purchase any course at a discount of 30% off the regular course price (plus tax). Offer valid from 12:00 am Eastern Time (“ET”) on May 19, 2025, through 11:59 pm ET on June 2, 2025. Terms and restrictions apply.Plus, sign up for CNBC Make It’s newsletter to get tips and tricks for success at work, with money and in life, and request to join our exclusive community on LinkedIn to connect with experts and peers.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcsandiego.com/news/business/money-report/elon-musks-x-down-for-tens-of-thousands-of-users/3833200/	https://media.nbcsandiego.com/2025/05/108148823-17478473902025-05-21t170638z_878539062_rc2gmea1h6up_rtrmadp_0_usa-safrica.jpeg?fit=1700%2C1000&quality=85&strip=all	2025-05-24 06:44:36
94	0.152	8	NewsAPI	Researchers share new insights from Apple Women’s Health Study	Back in 2019, Apple announced a trio of new research studies, including the Apple Women’s Health Study in partnership with Harvard T.H. Chan School of Public Health and the NIH’s National Institute of Environmental Health Sciences. \n\n\n\nResearchers have shared…	Back in 2019, Apple announced a trio of new research studies, including the Apple Womens Health Study in partnership with Harvard T.H. Chan School of Public Health and the NIHs National Institute of … [+1605 chars]	https://9to5mac.com/2025/05/05/researchers-share-new-insights-from-apple-womens-health-study/	https://i0.wp.com/9to5mac.com/wp-content/uploads/sites/6/2023/10/apple-research-app.webp?resize=1200%2C628&quality=82&strip=all&ssl=1	2025-05-05 20:41:56
95	0.145	8	NewsDATA	This doctor discovered ‘the longevity nutrient': The 1 food she always eats to be sure she gets enough of it	Swiss brand On is quickly emerging as a global challenger in the sportswear market.The company, which sells premium-priced athletic shoes and apparel, reported net sales for the three-month period ended March 31 rose over 40% to 726.6 million Swiss francs (US$869 million) compared with the year prior.Analysts say the brand has been able to capture market share from legacy competitors like Nike and Adidas through innovative products and timing. “The main thing they really understood was they went for the aesthetic of the shoe,” said Aneesha Sherman, managing director at Bernstein. “It’s really like no other silhouette that the consumer had seen. That is what drove the initial success.” Around the time of On’s 2021 initial public offering, Nike saw declining sales during a pullback from wholesale retailers and stalling innovation. Adidas also experienced rocky quarters as it ended its controversial partnership with Kanye West. Nike and Adidas still own a combined 58% of global market share, according to FactSet, while On makes up a little less than 3%. But its earnings growth rate has outpaced both companies in recent quarters. “It was luck as well as design that got them that huge scale in the years 2021, onwards, with that mass consumer,” Sherman said. “For the first time, retailers were actually going out there and looking for emerging, high-growth brands to take that [shelf] space and On was right there for them.” Now, Nike is mounting a turnaround plan under its new CEO, Elliott Hill, which analysts say could pose a potential headwind to On.The company also faces tariffs uncertainty along with the rest of the sportswear industry. Around 90% of On’s sneakers are manufactured in Vietnam, according the company, which President Donald Trump has said could face a 46% import duty. Watch the video above to learn more about how On is taking on sportswear competitors and how it plans to navigate tariffs.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcsandiego.com/news/business/money-report/this-doctor-discovered-the-longevity-nutrient-the-1-food-she-always-eats-to-be-sure-she-gets-enough-of-it/3833204/	https://media.nbcsandiego.com/2025/05/108150032-1748013217519-gettyimages-640045312-smc050117-17.jpeg?fit=1700%2C1000&quality=85&strip=all	2025-05-24 07:00:01
96	0.073	8	NewsAPI	Health care for transgender children questioned in 400-page Trump administration report	President Trump called for the report, which is a 400-page document, in an executive order, titled "Protecting Children From Chemical and Surgical Mutilation."	On Thursday, the Department of Health and Human Services published a 400-page document entitled "Treatment for Pediatric Gender Dysphoria: Review of Evidence and Best Practices."\r\nThe review's author… [+4909 chars]	https://www.npr.org/sections/shots-health-news/2025/05/01/nx-s1-5383599/transgender-gender-affirming-care-trump-hhs	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/6000x3375+0+0/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F3b%2Fdd%2F753f81d84751b3195f681988fa7b%2Fap25121500052450.jpg	2025-05-01 22:56:17
97	0.073	8	NewsAPI	Biden's cancer diagnosis raises fresh questions about his health in White House	The news that he has "aggressive" prostate cancer has some medics asking why it was not detected sooner.	Joe Biden's announcement that he has been diagnosed with prostate cancer has revived questions about what health issues the former US president was dealing with while he was in the White House.\r\nIn a… [+4498 chars]	https://www.bbc.com/news/articles/cwyn0zm8d20o	https://ichef.bbci.co.uk/news/1024/branded_news/743e/live/594cc2b0-351a-11f0-9a97-e5279a0b9b03.jpg	2025-05-20 13:07:53
98	0.073	8	NewsAPI	RFK Jr. to testify before House, Senate committees amid layoffs, overhaul at HHS	HHS Secretary Robert F. Kennedy Jr. is set to testify before two congressional committees on Wednesday.	Health and Human Services Secretary Robert F. Kennedy Jr. is set to testify before two congressional committees on Wednesday to discuss, among many topics, the Trump administration's proposed budget … [+4061 chars]	https://abcnews.go.com/Health/rfk-jr-testify-house-senate-committees-amid-layoffs/story?id=121771047	https://i.abcnewsfe.com/a/6677ad00-bd51-406f-a8f9-9b4fcca41de9/rfk-rt-er-250513_1747169044684_hpMain_16x9.jpg?w=1600	2025-05-14 09:14:26
99	0.073	8	NewsAPI	The MAHA Crowd Is Already Questioning Biden’s Cancer Diagnosis	“Turbo cancer” claims are back.	It took just a few hours for devotees of the “Make America healthy again” movement to question former President Joe Biden’s prostate-cancer diagnosis. Tumors of the prostate are the most common serio… [+4350 chars]	https://www.theatlantic.com/health/archive/2025/05/biden-cancer-vaccine-maha/682846/	https://cdn.theatlantic.com/thumbor/m6WwPGCERrlt5QsJwwhofWc9QYs=/0x88:2696x1492/1200x625/media/img/mt/2025/05/2025_05_19_biden/original.jpg	2025-05-19 16:21:59
100	0.073	8	NewsAPI	Liver cancer survival rates reflect income disparities	The risk of dying from the most common form of primary liver cancer is about 30 percent higher for patients with low household income compared to those with middle or high household income, according to a new study.	The risk of dying from the most common form of primary liver cancer is about 30 percent higher for patients with low household income compared to those with middle or high household income, according… [+2760 chars]	https://www.sciencedaily.com/releases/2025/05/250505121909.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-05 16:19:09
101	0.073	8	NewsAPI	Trump names doctor-turned-wellness influencer Casey Means as new surgeon general pick	U.S. President Donald Trump is tapping Dr. Casey Means, a physician-turned-wellness influencer with close ties to Health and Human Services Secretary Robert F. Kennedy Jr., as his nominee for surgeon general after withdrawing his initial pick for the influent…	U.S. President Donald Trump is tapping Dr. Casey Means, a physician-turned-wellness influencer with close ties to Health and Human Services Secretary Robert F. Kennedy Jr., as his nominee for surgeon… [+6374 chars]	https://www.cbc.ca/news/world/casey-means-surgeon-general-nominee-1.7529470	https://i.cbc.ca/1.7529471.1746664215!/cpImage/httpImage/image.jpg_gen/derivatives/16x9_1180/casey-means-standing-alongside-journalist-megan-kelly.jpg?im=Resize%3D620	2025-05-08 01:25:00
102	0.073	8	NewsAPI	Behind The Cost Curtain: Better Health Outcomes Through Transparency	The basic lack of transparency around health care costs has long contributed to wasteful spending and inefficient care delivery.  Here's what we can do to help.	The basic lack of transparency around health care costs has long contributed to wasteful spending and inefficient care delivery. Wide price variations in medical services with no rationale or true me… [+4584 chars]	https://www.forbes.com/sites/danielmendelson/2025/05/13/behind-the-cost-curtain-better-health-outcomes-through-transparency/	https://imageio.forbes.com/specials-images/imageserve/6823bd65f5b2806c4b62d646/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-13 21:47:42
103	0.073	8	NewsAPI	Google’s Chief Health Officer Is Retiring	Google's healthcare work and portfolio has rapidly expanded in recent years.	Dr. Karen DeSalvo was appointed as Chief Health Officer for the company in 2019.\r\nGoogle\r\nGoogles chief health officer, Dr. Karen DeSalvo, announced today that she will be retiring. Dr. DeSalvos care… [+6378 chars]	https://www.forbes.com/sites/saibala/2025/05/02/googles-chief-health-officer-is-retiring/	https://imageio.forbes.com/specials-images/imageserve/6814130f39e83577c0845e8a/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-02 14:00:05
104	0.073	8	NewsAPI	Trump Says He’s ‘Surprised’ Public Didn’t Know Of Biden’s Cancer Diagnosis Sooner—As Others Fuel Speculation Of A Cover-Up	Biden announced Sunday he was diagnosed with an “aggressive” form of prostate cancer.	President Donald Trump said Monday he was surprised the public didnt know about former President Joe Bidens cancer diagnosis soonera comment that came after other Republicans, including Vice Presiden… [+5021 chars]	https://www.forbes.com/sites/saradorn/2025/05/19/trump-says-hes-surprised-public-didnt-know-of-bidens-cancer-diagnosis-sooner-as-others-fuel-speculation-of-a-cover-up/	https://imageio.forbes.com/specials-images/imageserve/682b5463cf2f673718ae9540/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-19 21:51:42
105	0.073	8	NewsAPI	AMA Picks WebMD Doctor With U.S. Health Policy Background As New CEO	The American Medical Association named as its new CEO Dr. John Whyte, an executive at WebMD who has also held roles at the U.S. Department of Health and Human Services.	The American Medical Association Friday named as its new CEO Dr. John J. Whyte a former chief ... More medical officer at WebMD who also worked at the U.S. Department of Health and Humana Services an… [+2221 chars]	https://www.forbes.com/sites/brucejapsen/2025/05/09/ama-picks-webmd-doctor-with-us-health-policy-background-as-new-ceo/	https://imageio.forbes.com/specials-images/imageserve/681e2da5ad57406a6363da8c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-09 16:42:05
106	0.073	8	NewsAPI	Former President Biden Faces ‘Aggressive’ Prostate Cancer With Reported Bone Spread	Joe Biden has been diagnosed with prostate cancer.	Former United States president Joe Biden has been diagnosed with prostate cancer, his personal office announced today, May 18.\r\nThe statement read, “Last week, President Joe Biden was seen for a new … [+4781 chars]	https://www.boredpanda.com/biden-diagnosed-with-prostate-cancer/	https://www.boredpanda.com/blog/wp-content/uploads/2025/05/fb_image_682a587187d5b.png	2025-05-18 22:10:54
107	0.073	8	NewsAPI	One woman's fight to remove barriers for aspiring doctors with disabilities	After her dreams of becoming a doctor were denied, one California woman is working to make the profession more accessible to those with disabilities.	All through her 20s, Taylor Carty chased her dream of becoming a doctor.\r\nCarty, now 30, was diagnosed with cerebral palsy when she was a baby, and was inspired by the many doctors and health care pr… [+7692 chars]	https://www.npr.org/2025/05/15/nx-s1-5272736/doctor-disability-medical-field	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/6000x3375+0+313/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F72%2F68%2F6651706548b9ad34ecfadbfc840c%2F2025-04-23-carty-gwidyatmadja-02.jpg	2025-05-15 13:19:24
108	0.073	8	NewsAPI	House Republicans to zero in on autopen use as part of investigation into Biden's health	As House Republicans prepare to investigate former President Joe Biden’s health and mental fitness while in office, they are increasingly zeroing in on his use of a so-called autopen to sign certain pieces of legislation and executive orders.	As House Republicans prepare to investigate former President Joe Bidens health and mental fitness while in office, they are increasingly zeroing in on his use of a so-called autopen to sign certain p… [+5895 chars]	https://www.nbcnews.com/politics/congress/house-republicans-autopen-investigation-biden-health-rcna208138	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2024-11/241107-joe-biden-vl-1139p-288089.jpg	2025-05-21 20:46:42
109	0.073	8	NewsDATA	Top Medical Stocks To Follow Today – May 22nd	UnitedHealth Group, Hims & Hers Health, Eli Lilly and Company, Thermo Fisher Scientific, Walmart, Medtronic, and Tempus AI are the seven Medical stocks to watch today, according to MarketBeat’s stock screener tool. Medical stocks are shares of publicly traded companies operating in the healthcare sector, including pharmaceutical firms, biotechnology developers, medical device manufacturers and healthcare [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/24/top-medical-stocks-to-follow-today-may-22nd.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Funitedhealth-group-incorporated-logo-1200x675.png%3Fv%3D20221020135718&w=240&zc=2	2025-05-24 07:49:01
110	0.073	8	NewsDATA	A soft touch, a strong will	Dr. Henry Friesen stands among the most distinguished Canadian scientists — if not near the front. A trailblazer whose name echoes not only in the annals of medical science but [...]	ONLY AVAILABLE IN PAID PLANS	https://www.winnipegfreepress.com/arts-and-life/life/2025/05/24/a-soft-touch-a-strong-will	https://www.winnipegfreepress.com/wp-content/uploads/sites/2/2025/05/3251196_web1_Friesen-photo.jpg?w=1000	2025-05-24 07:02:22
111	0.073	8	NewsDATA	Cuba Marks 62 Years Of International Medical Solidarity	(MENAFN - Nam News Network)HAVANA, May 24 (NNN-ACN) - Cuba commemorates 63 years of a milestone in the history of international medical cooperation: the arrival of the first brigade of health ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109590129/Cuba-Marks-62-Years-Of-International-Medical-Solidarity	https://menafn.com/updates/pr/2025-05/24/NNN_cc41aimage_story.jpg	2025-05-24 05:06:02
112	0	8	NewsAPI	A Public Health Researcher and Her Engineer Husband Found How Diseases Can Spread through Air Decades before the COVID Pandemic	Mildred Weeks Wells and her husband figured out that disease-causing pathogens can spread through the air like smoke	Air-Borne: The Hidden History of the Life We Breathe, by Carl Zimmer, charts the history of the field of aerobiology: the science of airborne microorganisms. In this episode, we discover the story of… [+33528 chars]	https://www.scientificamerican.com/article/a-public-health-researcher-and-her-engineer-husband-found-how-diseases-can/	https://static.scientificamerican.com/dam/m/924bb2302462b89/original/Lost-Women-of-Science-Partner-Podcast-Span-Art-Airborne.png?m=1747878912.787&w=1200	2025-05-22 16:00:00
113	0.233	9	NewsAPI	The Perception of Waiting Times on Patient Satisfaction and Patient Care: A Cross-Sectional Study at a Tertiary Health Care Institution in Kenya	Introduction Patients often spend significant time waiting for care, which influences patient satisfaction, perceived quality, access to care, and utilization of various health care services. Waiting time and resulting implications remain understudied in low-…	Citation: Seif S, Shah J, Chandani A, Ali SK (2025) The Perception of Waiting Times on Patient Satisfaction and Patient Care: A Cross-Sectional Study at a Tertiary Health Care Institution in Kenya. P… [+24964 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322015	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322015.g001&size=inline	2025-05-02 14:00:00
114	0.218	9	NewsDATA	MediPharm Labs Cautions Shareholders about Dissident Nominees' Governance Failures at Check-Cap Ltd.	TORONTO, May 23, 2025 (GLOBE NEWSWIRE) -- MediPharm Labs Corp. (TSX: LABS) ("MediPharm”, the "Company”, or "we”), a pharmaceutical company specialized in precision-based cannabinoids, today provided its shareholders with information related to three of the six directors (the "Dissident Nominees”) nominated by Apollo Technology Capital Corporation ("Apollo”) to stand for election at MediPharm's Annual and Special Meeting of Shareholders on June 16, 2025. All dollar figures in this news release are in U.S. dollars.The Company believes events that have transpired over the past two years at Check-Cap Ltd. ("Check-Cap”), a Nasdaq-listed company, provide valuable insight into the dubious tactics, motives and character of the individuals now seeking to take control of the board of directors of MediPharm (the "MediPharm Board”).The extraordinary sequence of events at Check-Cap has been notable for its evidence of poor governance practices, lack of transparency and disclosure to shareholders, questionable allocation of cash resources, high turnover, public shareholder disputes, failure to execute on promises and destruction of shareholder value.Most alarmingly, Check-Cap has been transferring millions of dollars of cash to Apollo and its subsidiaries - companies led by Dissident Nominee and shareholder, Regan McGee. The cash transfers were characterized as being tied to a merger agreement with an Apollo subsidiary that was announced 14 months ago but has yet to be completed.Chris Taves, Chair of MediPharm, commented:"The troubling fact pattern involving three of the Dissident Nominees raises several red flags. The MediPharm Board urges its shareholders to exercise a high level of caution before considering voting for any of McGee's nominees to run your Company.”Summary of Recent Events at Check-Cap1Symetryx Corporation ("Symetryx”), a Toronto-based investment firm and owner of 5.8% of Check-Cap's shares according to public filings, led a successful campaign in 2023 to stop a business combination with Keystone Dental Holdings (the "Keystone Transaction”) proposed by the Check-Cap board (the "Check-Cap Board”). According to its website and other public sources, Symetryx also owns shares of Nobul, a company founded and led by Dissident Nominee, Regan McGee.A vote by Check-Cap shareholders on December 18, 2023 resulted in the termination of the 2023 Keystone Transaction, and the replacement of the entire Check-Cap Board with five nominees proposed by Symetryx. Within five weeks following this vote, four of the five directors duly elected by shareholders had resigned, and were replaced with four new Check-Cap Board members. One of the directors who had been appointed, resigned the following day.On March 25, 2024, Check-Cap announced the terms of a proposed business combination (the "Check-Cap Nobul Merger”) with Nobul AI Corp. ("Nobul”). According to the announcement, the Check-Cap Nobul Merger was subject to the approval of Check-Cap shareholders at a special meeting "expected to occur in the coming months.”Approximately 14 months after the initial announcement of the Check-Cap Nobul Merger, there is currently still no indication that a shareholder vote on the Check-Cap-Nobul Merger has ever occurred or been scheduled, no recent announcement on the expected timing to complete or terminate the Check-Cap Nobul Merger, and no indication that Check-Cap has been seeking an alternative transaction to the Check-Cap Nobul Merger.Despite no formal business combination having been completed, on July 28, 2024 and September 8, 2024, the Check-Cap Board ratified and approved a loan agreement for a $6 million loan to Nobul, and the transfer of $11 million to a segregated bank account "to fund the pursuit of accretive acquisition targets or other growth initiatives of Nobul and for no other purposes.” At least $2.8 million of the funds had already been spent by the end of 2024.As set out in Check-Cap's business combination agreement with Nobul ("BCA”) amended on September 8, 2024, funds in the segregated account can be disbursed with the authorization of just two individuals: Check-Cap chairman David Lontini and Nobul chairman Mr. McGee, both of whom are among Apollo's six Dissident Nominees for the MediPharm Board.1 All events described in this news release are based on Check-Cap's filings with the U.S. Securities and Exchange Commission beginning in June 2023 and public news releases. We urge shareholders to review those source materials. Our summary may be limited by any deficiencies in that disclosure.Check-Cap's Connections to the Dissident NomineesThree of the six Dissident Nominees now seeking election to the MediPharm Board, namely David Lontini, Alan D. Lewis II and Regan McGee, have been directly involved in the events at Check-Cap:Mr. Lontini is "Active Chairman” of the Check-Cap Board, having been initially appointed to the board in January 2024 to replace one of the directors who had resigned shortly after being elected. He was subsequently elected as a director in April 2024, became Chairman in July 2024 and "Active Chairman” in November 2024.Mr. Lewis is a director of Check-Cap, and became the latest individual appointed as CFO of Check-Cap on April 6, 2025. Mr. Lewis is a colleague of a fourth Dissident Nominee, Demetrios Mallios, with both being co-founders and officers of The Aeon Group, Inc.Mr. McGee, in his capacity as Nobul's founder, CEO and Chairman, has been Check-Cap's intended merger counterparty and is designated to become the merged entity's CEO and Chairman upon completion of the Check-Cap Nobul Merger, if such transaction actually closes. Mr. McGee is also Chairman and CEO of Apollo. Important Questions Raised for MediPharm ShareholdersMediPharm believes that activist shareholders often follow the same "playbook” in their pursuit to take control of target companies, especially when they have been successful utilizing such tactics in the past. We are concerned that the events at Check-Cap, and the direct involvement of three of the Dissident Nominees now seeking election to the MediPharm Board, represent significant risks for the Company's shareholders.MediPharm urges its shareholders to consider the following questions:1) How did it benefit Check-Cap shareholders to transfer millions of dollars to Nobul? Was this in the best interests of Check-Cap, or only Regan McGee and the company he controls?2) Does Apollo plan to replace some or all of its Dissident Nominees with new appointees, similar to what happened at Check-Cap? Which ones would remain to serve on the MediPharm Board?3) Has Apollo already identified specific merger or acquisition targets it intends for MediPharm to pursue? Are such merger candidates connected with any of the Dissident Nominees or their affiliates or associates?4) Do the Dissident Nominees, and particularly those who have been directly involved with Check-Cap, have a track record that qualifies them to take control of another public company, in particular one in a highly specialized sector?5) Do Apollo and its Dissident Nominees have a better plan in place for MediPharm, as compared to the overlapping group that took control of Check-Cap?Additional Background Information on the Events at Check-CapTo supplement the information provided above, a selected summary of developments at Check-Cap over the past two years follows.Check-Cap is an Israel-based company whose trials of its colorectal cancer screening test did not meet expectations, causing the Check-Cap Board to announce its intention to pursue strategic options in June 2023.In July 2023, Symetryx announced a non-binding proposal to acquire Check-Cap, identifying Check-Cap's $37.4 million cash balance as the basis for the company's valuation. Symetryx requested immediate engagement with the Check-Cap Board, but did not respond to an email sent by Check-Cap's chairman on August 10, 2023 to propose a conversation.Check-Cap entered into the Keystone Transaction on August 16, 2023, subject to the approval of Check-Cap shareholders.Symetryx outlined its opposition to the Keystone Transaction in a news release dated October 17, 2023. Issues identified by Symetryx included, among other things, a lack of synergies, an inflated valuation, and Check-Cap's cash burn rate. Symetryx put forward a list of five directors it planned to nominate to replace the existing Check-Cap board.On October 19, 2023, Check-Cap responded with a letter to shareholders which described an extensive bidding process lasting several months and involving outreach by an independent advisor to 150 companies, 42 non-binding proposals and detailed discussions with six prospective merger partners. The letter said that the selected partner, Keystone Dental Holdings, had generated revenue of $61 million in 2022 and $33.4 million in the first half of 2023.On December 18, 2023, Check-Cap shareholders voted in favour of all five directors nominated by Symetryx, voted against the Keystone Transaction, and voted against a reverse share split.In a December 22, 2023 news release thanking Check-Cap shareholders for supporting its bid, Symetryx president Barry Shiff commented: "We believe, as many of our fellow shareholders do, that there is tremendous upside potential at [Check-Cap]. We encourage the newly constituted [Check-Cap] Board to identify a more appropriate merger candidate.”During the month of January 2024, Check-Cap, now under the control of the new Check-Cap Board, announced the resignation of four of the five directors elected at the shareholder meeting the previous month. The fifth was removed in April 2024.Check-Cap's auditors resigned in February 2024 due to "certain control concerns that arose during the first quarter of 2024 within the company.”On March 25, 2024, Check-Cap announced the Check-Cap Nobul Merger. In the news release, Check-Cap's Chairman Paul Medeiros, who had been appointed to the Check-Cap Board on January 21, 2024 (four days earlier than the other three newly appointed directors), said the transaction followed a "comprehensive and thorough review of strategic alternatives.” There was no reference in the announcement to Symetryx owning shares of Nobul.On April 1, 2024, Check-Cap's largest shareholder and its director filed a Schedule 13D with the SEC describing a number of concerns about the state of affairs at Check-Cap. These included "chaotic turnover in leadership,” the resignation of the auditor, and Check-Cap's "alarming cash-burn rate.” The shareholder's issues with the Check-Cap Nobul Merger also included, "the large potential payout to Nobul if [Check-Cap's] shareholders do not approve the [BCA] and related transactions, and the process for [Check-Cap's] negotiation and entry into the [BCA], considering, among other things, that Nobul appears to be a portfolio company of Symetryx Corporation.” Several days later, that shareholder entered into a support agreement and committed to voting in favour of the Check-Cap Nobul Merger.On July 28, 2024 and September 8, 2024, Check-Cap's Board approved a loan agreement for a $6 million loan to Nobul. The Check-Cap Board also approved the amendment to the BCA with Nobul, with the specific purpose of enabling the loan and obligating Check-Cap to deposit $11 million into a segregated account in order to fund Nobul's growth initiatives. The funds appear to have been transferred to an account held by RBC in Toronto under the name "Nobul AI Corp.” in August 2024. Check-Cap did not disclose any consideration received from Nobul in return for this generous and unconventional gesture.The funds loaned or approved for eventual transfer to Nobul represented the vast majority of the approximately $18 million of cash Check-Cap had on hand at June 30, 2024. This issue was compounded by the fact that Check-Cap had incurred an approximately $6.8 million operating loss in the first half of 2024. We are unable to determine how much cash was remaining at the end of 2024, as Check-Cap, with Dissident Nominee Alan D. Lewis II as CFO, recently announced it was unable to meet its deadline for filing year-end financial results.Nobul amalgamated with Apollo on August 26, 2024. We can find no record of this amalgamation having been disclosed to Check-Cap shareholders, who may continue to be under the impression that their company is planning to merge with an entity that no longer exists in the form described to them.On October 7, 2024, Check-Cap received a derivative claim against its directors and Nobul. The claim relates to "corporate governance issues and entity level control, including issues relating to the appointment of certain board members, the validity of certain board decisions, and questions related to the legality of the [BCA governing the Check-Cap-Nobul Merger] and certain cash transactions and whether such transactions are in [Check-Cap's] best interest.” Check-Cap said the derivative action is frivolous and it will vigorously defend itself.Since January 2024, seven different directors have resigned from Check-Cap's five-person board (including three who purportedly resigned for "personal reasons” on the same day, and another who resigned one day after being appointed), and an eighth was removed by shareholder vote following a request by Symetryx for his removal, notwithstanding that he was included as a proposed director put forth by Symetryx at the December 18, 2023 meeting of shareholders.Check-Cap has also experienced unusually high turnover at the CEO and CFO positions during the same period. In less than 1.5 years, at least three individuals have held the CEO or equivalent title and four individuals have held the CFO title (not including one CEO and one CFO who were each appointed but apparently never held the respective positions).Check-Cap's share price history is illustrative of the effect on shareholder value of the events described above. Its closing share price on May 22, 2025 was $0.85. This compares to a share price of $2.47 on March 26, 2024 after the Check-Cap-Nobul Merger was announced, and $2.36 on December 19, 2023 after the previous board was unseated. Check-Cap's share price was $2.35 on August 17, 2023 following the announcement of the Keystone Transaction which Symetryx fought to prevent.Nasdaq has twice notified Check-Cap that its shares are subject to potential delisting because they have traded below the minimum $1.00 bid price for more than 30 days. The reverse share split proposed by the previous Check-Cap board at the December 2023 shareholder meeting and successfully opposed by Symetryx may have prevented or delayed the shares falling below the $1.00 threshold required to maintain its Nasdaq listing.To the Company's knowledge, Check-Cap has not updated its shareholders on the status of the Check-Cap Nobul Merger since the initial announcement, other than to disclose the derivative action, the amendment to the BCA to allow for the transfer of cash to Nobul described above, as well as further updates with regards to the transfer of cash. In fact, there is no indication that Check-Cap has issued a single news release since March 25, 2024. The MediPharm Board urges its shareholders to exercise a high level of caution before considering voting for the same group of individuals responsible for the failures at Check-Cap to run the Company, and to treat any statements or promises made by the Dissident Nominees with a high level of skepticism.Vote for the Highly Qualified MediPharm NomineesIn light of the concerns raised by multiple parties in litigation with Mr. McGee, as well as the issues the Company has raised in previous news releases about the qualifications and suitability of the Dissident Nominees collectively, MediPharm urges shareholders to vote only using the GREEN proxy or GREEN voting instruction form in support of all of the Company's nominees and resolutions.To ensure your vote is counted, shareholders are encouraged to proactively contact their broker to obtain their 16-digit control number associated with the GREEN management proxy. Once received, you can cast your vote by visiting www.medipharmlabsagm.com.You may receive materials or outreach from the dissident - please disregard any such communications and vote only using the GREEN proxy in support of the Company's nominees.About MediPharm LabsFounded in 2015, MediPharm Labs specializes in the development and manufacture of purified, pharmaceutical-quality cannabis concentrates, active pharmaceutical ingredients (API) and advanced derivative products utilizing a Good Manufacturing Practices certified facility with ISO standard-built clean rooms. MediPharm Labs has invested in an expert, research driven team, state-of-the-art technology, downstream purification methodologies and purpose-built facilities for delivery of pure, trusted and precision-dosed cannabis products for its customers. MediPharm Labs develops, formulates, processes, packages and distributes cannabis and advanced cannabinoid-based products to domestic and international medical markets.In 2021, MediPharm Labs received a Pharmaceutical Drug Establishment License from Health Canada, becoming the only company in North America to hold a commercial-scale domestic Good Manufacturing Practices License for the extraction of multiple natural cannabinoids. This GMP license was the first step in the Company's current foreign drug manufacturing site registration with the US FDA.In 2023, MediPharm acquired VIVO Cannabis Inc., which expanded MediPharm's reach to medical patients in Canada via Canna Farms medical ecommerce platform, and in Australia and Germany through Beacon Medical Australia PTY Ltd. and Beacon Medical Germany GMBH. This acquisition also included Harvest Medical Clinics in Canada which provides medical cannabis patients with Physician consultations for medical cannabis education and prescriptions.The Company carries out its operations in compliance with all applicable laws in the countries in which it operates.Shareholder Voting Assistance:If you have any questions or require any assistance in executing your GREEN proxy or voting instruction form, please call Sodali & Co at:North American Toll-Free Number: 1.888.777.2059Outside North America, Banks, Brokers and Collect Calls: 1.289.695.3075Email: assistance@investor.sodali.comNorth American Toll-Free Facsimile: 1.877.218.5372For up-to-date information and assistance in voting please visit: www.medipharmlabsagm.comInvestor Contact:MediPharm Labs Investor RelationsTelephone: +1 416.913.7425Email: investors@medipharmlabs.comMedia Contact:John VincicOakstrom Advisors+1 (647) 402-6375john@oakstrom.comCautionary Note Regarding Forward-Looking Information:This news release contains "forward-looking information” and "forward-looking statements” (collectively, "forward-looking statements”) within the meaning of the applicable Canadian securities legislation. All statements, other than statements of historical fact, are forward-looking statements and are based on expectations, estimates and projections as at the date of this news release. Any statement that involves discussions with respect to predictions, expectations, beliefs, plans, projections, objectives, assumptions, future events or performance (often but not always using phrases such as "expects”, or "does not expect”, "is expected”, "anticipates” or "does not anticipate”, "plans”, "budget”, "scheduled”, "forecasts”, "estimates”, "believes” or "intends” or variations of such words and phrases or stating that certain actions, events or results "may” or "could”, "would”, "might” or "will” be taken to occur or be achieved) are not statements of historical fact and may be forward-looking statements. In this news release, forward-looking statements relate to, among other things: timing of the Annual and Special Meeting, any impacts to MediPharm shareholders of the actions relating to the Dissident Nominees described herein, and any outcomes resulting from the circumstances and information cited herein. Forward-looking statements are necessarily based upon a number of estimates and assumptions that, while considered reasonable, are subject to known and unknown risks, uncertainties, and other factors which may cause the actual results and future events to differ materially from those expressed or implied by such forward-looking statements. Such factors include, but are not limited to: general business, economic, competitive, political and social uncertainties; the inability of MediPharm Labs to obtain adequate financing; the delay or failure to receive regulatory approvals; and other factors discussed in MediPharm Labs' continuous disclosure filings, available on the SEDAR+ website at www.sedarplus.ca. There can be no assurance that such statements will prove to be accurate, as actual results and future events could differ materially from those anticipated in such statements. Accordingly, readers should not place undue reliance on the forward-looking statements and information contained in this news release. Except as required by law, MediPharm Labs assumes no obligation to update the forward-looking statements of beliefs, opinions, projections, or other factors, should they change.	ONLY AVAILABLE IN PAID PLANS	https://www.manilatimes.net/2025/05/24/tmt-newswire/globenewswire/medipharm-labs-cautions-shareholders-about-dissident-nominees-governance-failures-at-check-cap-ltd/2120241	https://www.manilatimes.net/manilatimes/uploads/images/2025/05/24/635612.jpg	2025-05-23 17:07:33
115	0.073	9	NewsAPI	Effectiveness of care coordination interventions delivered to stroke survivors in low and middle-income countries: Systematic review and meta-analysis protocol	Background Stroke survivors have complex and long-term care needs requiring navigation of multiple care services and providers. Care coordination interventions provide wholistic care that meets the needs of the patient and improves their clinical outcomes and…	Citation: Osei SKJ, Danso-Appiah A (2025) Effectiveness of care coordination interventions delivered to stroke survivors in low and middle-income countries: Systematic review and meta-analysis protoc… [+33288 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0324040	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0324040.g001&size=inline	2025-05-16 14:00:00
116	0.073	9	NewsAPI	Chronic diseases and self-rated health disparity between urban and rural residents in China	This study investigates the significant disparities between urban and rural areas in China, particularly in terms of health status, which are driven by economic inequality and the uneven distribution of healthcare resources. Chronic diseases are a major threa…	Abstract\r\nThis study investigates the significant disparities between urban and rural areas in China, particularly in terms of health status, which are driven by economic inequality and the uneven di… [+38282 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0324287	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0324287.t003&size=inline	2025-05-21 14:00:00
189	0.208	13	NewsDATA	Introspecting counter-terrorism after Operation Sindoor	In the focus on India’s foreign policy and military force what is being missing out are the aspects that concern the internalisation of terrorism in Jammu and Kashmir	ONLY AVAILABLE IN PAID PLANS	https://www.thehindu.com/opinion/op-ed/introspecting-counter-terrorism-after-operation-sindoor/article69611262.ece	https://th-i.thgim.com/public/incoming/xj975g/article69611264.ece/alternates/LANDSCAPE_1200/12205_7_5_2025_6_6_50_3_03_OPERATION_SINDOOR_SGR_07_05_2025.JPG	2025-05-23 18:38:00
117	0.073	9	NewsAPI	Impact of surgery on rehabilitation care and quality of life perceived by patient with post-stroke upper limb spasticity: Study protocol for a randomized controlled trial	Background Stroke is the principal cause of permanent disability in adult age, and many patients require lifelong medical treatment and care from others for their daily activities. It has enormous repercussions on the work and social lives of patients and the…	Abstract\r\nBackground\r\nStroke is the principal cause of permanent disability in adult age, and many patients require lifelong medical treatment and care from others for their daily activities. It has … [+40312 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322588	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322588.g001&size=inline	2025-04-30 14:00:00
118	0.073	9	NewsAPI	Enhancing global health through shared values and inclusive co-op | Opinion	Referring to Daily Sabah’s news article on May 1 entitled “Türkiye&#039;s health tourism gets major upgrade for safety, quality,” which highlights...	Referring to Daily Sabahs news article on May 1 entitled Türkiye's health tourism gets major upgrade for safety, quality, which highlights Türkiye's plan to overhaul its health tourism regulations, i… [+6640 chars]	https://www.dailysabah.com/opinion/op-ed/enhancing-global-health-through-shared-values-and-inclusive-co-op	https://idsb.tmgrup.com.tr/ly/uploads/images/2025/05/11/thumbs/1200x675/381721.jpg	2025-05-11 21:21:34
119	0.073	9	NewsDATA	Diverse Interventions Found to Increase Pneumococcal Vaccine Uptake Among Older Adults in Primary Care Settings	Interventions such as educational brochures, provider-delivered educational programs, and computerized reminders were found to help improve pneumococcal vaccine uptake in older adults.	ONLY AVAILABLE IN PAID PLANS	https://www.pharmacytimes.com/view/diverse-interventions-found-to-increase-pneumococcal-vaccine-uptake-among-older-adults-in-primary-care-settings	https://cdn.sanity.io/images/0vv8moc6/pharmacytimes/af8de15ae6192ff3ca2779a3e1f161a95e9b7bef-1200x800.jpg?auto=format&fit=crop	2025-05-23 15:12:04
120	0	9	NewsAPI	An optimized transformer model for efficient detection of thoracic diseases in chest X-rays with multi-scale feature fusion	This study presents the development and application of an optimized Detection Transformer (DETR) model, known as CD-DETR, for the detection of thoracic diseases from chest X-ray (CXR) images. The CD-DETR model addresses the challenges of detecting minor patho…	Citation: Yu S, Zhou P (2025) An optimized transformer model for efficient detection of thoracic diseases in chest X-rays with multi-scale feature fusion. PLoS One 20(5):\r\n e0323239.\r\nhttps://doi.org… [+37583 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0323239	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0323239.g003&size=inline	2025-05-07 14:00:00
121	0	9	NewsAPI	Disparities in physician compensation for breast and prostate cancer operations	The objective of this study was to determine whether the Center for Medicare and Medicaid services (CMS) pays more relative value units (RVUs) for prostatectomies than mastectomies across different treatment modalities. The RVU model is public information, su…	Abstract\r\nThe objective of this study was to determine whether the Center for Medicare and Medicaid services (CMS) pays more relative value units (RVUs) for prostatectomies than mastectomies across d… [+23426 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0323892	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0323892.g005&size=inline	2025-05-15 14:00:00
122	0	9	NewsAPI	Utilizing Theory of Planned Behaviour to increase intention to participate in hepatitis C treatment therapy among Methadone maintenance therapy clients (MMT) in Malaysia: A cluster randomised control trial	Introduction The World Health Organization (WHO) has targeted eliminating viral hepatitis as a public health problem by 2030. Thus, high-risk groups such as Methadone Maintenance Therapy (MMT) clients should be targeted for hepatitis C health intervention to …	Citation: Baharudin MH, Mokhtar SA, Azman AZF, Mohd Nazan AIN (2025) Utilizing Theory of Planned Behaviour to increase intention to participate in hepatitis C treatment therapy among Methadone mainte… [+44516 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0324718	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0324718.t008&size=inline	2025-05-22 14:00:00
123	0	9	NewsAPI	Societal cost of day-care approach (DCA): A low-cost approach in urban and rural settings for management of childhood severe pneumonia in Bangladesh	Objective Childhood severe pneumonia is the leading cause of under-five deaths in Bangladesh. A new day-care management approach (DCA) was implemented in primary-level healthcare facilities in urban and rural areas of Bangladesh. Reliable cost estimates are i…	Abstract\r\nObjective\r\nChildhood severe pneumonia is the leading cause of under-five deaths in Bangladesh. A new day-care management approach (DCA) was implemented in primary-level healthcare facilitie… [+41706 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0323353	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0323353.g002&size=inline	2025-05-08 14:00:00
124	0	9	NewsAPI	Trends in Parkinson’s disease medication prescribing patterns in the UK: An interrupted time series analysis (2019–2024)	This study aimed to examine prescribing trends for Parkinson’s disease (PD) medications in the United Kingdom from 2019 to 2024, focusing on the impact of guidelines from the American Academy of Neurology (AAN) and the National Institute for Health and Care E…	Abstract\r\nThis study aimed to examine prescribing trends for Parkinsons disease (PD) medications in the United Kingdom from 2019 to 2024, focusing on the impact of guidelines from the American Academ… [+40065 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0324999	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0324999.g002&size=inline	2025-05-23 14:00:00
125	0	9	NewsDATA	Across the State	NORTH	ONLY AVAILABLE IN PAID PLANS	https://www.wvnews.com/across-the-state/article_5dbd84c8-fc86-47a2-b613-7f90f2b43366.html	https://bloximages.chicago2.vip.townnews.com/wvnews.com/content/tncms/assets/v3/editorial/0/81/08117d7b-6e92-579d-ab63-272863b36c54/5f122dae63961.image.jpg?resize=300%2C300	2025-05-24 04:00:00
126	0	9	NewsDATA	MediPharm Labs Cautions Shareholders about Dissident Nominees’ Governance Failures at Check-Cap Ltd.	TORONTO, May 23, 2025 (GLOBE NEWSWIRE) — MediPharm Labs Corp. (TSX: LABS) (“MediPharm”, the “Company”, or “we”), a pharmaceutical company specialized in precision-based cannabinoids, today provided its shareholders with information related to three of the six directors (the “Dissident Nominees”) nominated by Apollo Technology Capital Corporation (“Apollo”) to stand for election at MediPharm’s Annual and [...]	ONLY AVAILABLE IN PAID PLANS	https://www.cbj.ca/medipharm-labs-cautions-shareholders-about-dissident-nominees-governance-failures-at-check-cap-ltd/	https://www.cbj.ca/wp-content/uploads/medipharm-labs-cautions-shareholders-about-dissident-nominees-governance-failures-at-check-cap-ltd.gif	2025-05-23 17:00:00
128	0.089	10	NewsAPI	Transcript: Sander Gerber, CEO and CIO Hudson Bay Capital	﻿     The transcript from this week’s, MiB: Sander Gerber, CEO and CIO Hudson Bay Capital, is below. You can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spotify, YouTube, and Bloomberg. All of our earlier podcas…	The transcript from this weeks, MiB: Sander Gerber, CEO and CIO Hudson Bay Capital, is below.\r\nYou can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spot… [+53213 chars]	https://ritholtz.com/2025/05/transcript-sander-gerber/	https://ritholtz.com/wp-content/uploads/2023/02/Mib-tile.png	2025-05-06 16:30:50
129	0.089	10	NewsAPI	Trump’s Mineral Paradox	Without demand from clean energy, the U.S. market for rare earth, graphite, and lithium will falter.	Resources have always determined power. The British empire’s command over coal helped expand the realm to the ends of the earth. The United States entered World War II as a dominant oil power and for… [+8734 chars]	https://www.theatlantic.com/science/archive/2025/05/trumps-mineral-paradox/682675/	https://cdn.theatlantic.com/thumbor/iND4Ns5e9pxymlgrJB0kawaFNPc=/0x102:4792x2598/1200x625/media/img/mt/2025/05/2025_05_02_Trump_Minerals_1/original.jpg	2025-05-02 18:34:10
130	0.089	10	NewsAPI	10 Finance Jobs With Six-Figure Potential—No Degree Required	No degree? No problem. These 10 finance jobs can lead to six-figure salaries, proving that skills and experience can matter more than a diploma.	Many six-figure finance jobs now prioritize skills over degrees.\r\ngetty\r\nWhile Wall Street firms once exclusively hired Ivy League graduates, those attitudes are changing. Traditional hiring models a… [+15444 chars]	https://www.forbes.com/sites/carolinecastrillon/2025/05/12/finance-jobs-six-figure-potential-no-degree/	https://imageio.forbes.com/specials-images/imageserve/68221f973e9a018ba139ddec/0x0.jpg?format=jpg&crop=1009,569,x0,y0,safe&height=900&width=1600&fit=bounds	2025-05-13 11:00:00
131	0.089	10	NewsAPI	A World of Unintended Consequences	One of the great, underappreciated facts about our technology-driven age is that unintended consequences tend to outnumber intended ones. As much as we would like to believe that we are in control, scholars who have studied catastrophic failures have shown th…	One of the great, underappreciated facts about our technology-driven age is that unintended consequences tend to outnumber intended ones. As much as we would like to believe that we are in control, s… [+16355 chars]	https://www.project-syndicate.org/onpoint/technology-brings-more-unintended-consequences-than-intended-ones-by-edward-tenner-2025-04	https://webapi.project-syndicate.org/library/eb5bfaea9ea6cde7ef59f791f368b80a.2-1-super.1.jpg	2025-04-28 13:35:19
132	0.089	10	NewsAPI	LiqTech International (NASDAQ:LIQT) and ZOOZ Power (NASDAQ:ZOOZ) Financial Contrast	ZOOZ Power (NASDAQ:ZOOZ – Get Free Report) and LiqTech International (NASDAQ:LIQT – Get Free Report) are both small-cap computer and technology companies, but which is the better investment? We will contrast the two businesses based on the strength of their e…	ZOOZ Power (NASDAQ:ZOOZ – Get Free Report) and LiqTech International (NASDAQ:LIQT – Get Free Report) are both small-cap computer and technology companies, but which is the better investment? We will … [+5144 chars]	https://www.etfdailynews.com/2025/05/03/liqtech-international-nasdaqliqt-and-zooz-power-nasdaqzooz-financial-contrast/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/liqtech-international-inc-logo-1200x675.png&w=240&h=240&zc=2	2025-05-03 05:45:01
133	0.089	10	NewsAPI	Solar failures trigger historic blackout, natural gas saves Iberian grid amid net-zero backlash	A failure at two solar plants in southern Spain triggered the largest blackout in Spanish and Portuguese history, leaving 50 million people without power, disrupting transportation and crippling emergency services. The collapse revealed vulnerabilities in ove…	<ul><li>A failure at two solar plants in southern Spain triggered the largest blackout in Spanish and Portuguese history, leaving 50 million people without power, disrupting transportation and crippl… [+6061 chars]	https://www.naturalnews.com/2025-05-01-natural-gas-saves-iberian-grid-net-zero-backlash.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Breaker-Box-Power-Outage-Blackout-Candle.jpg	2025-05-01 06:00:00
134	0.089	10	NewsDATA	Cetera Investment Advisers Increases Stake in Innovator International Developed Power Buffer ETF – October (NYSEARCA:IOCT)	Cetera Investment Advisers grew its position in Innovator International Developed Power Buffer ETF – October (NYSEARCA:IOCT – Free Report) by 21.5% during the 4th quarter, according to the company in its most recent disclosure with the Securities and Exchange Commission. The firm owned 33,978 shares of the company’s stock after acquiring an additional 6,002 shares [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/24/cetera-investment-advisers-increases-stake-in-innovator-international-developed-power-buffer-etf-october-nysearcaioct.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fgeneric-stocks11.jpg&w=240&zc=2	2025-05-24 07:44:58
135	0.089	10	NewsDATA	Bitcoin Price Soars Past $108,000: What’s Driving This Powerful Rally?	BitcoinWorldBitcoin Price Soars Past $108,000: What’s Driving This Powerful Rally?Exciting times in the digital asset space! The Bitcoin price has just achieved a significant milestone, pushing past the $108,000 mark. This latest move is capturing the attention of investors and analysts worldwide, signaling strong momentum in the market. According to real-time monitoring data, the BTC price is currently trading around $108,009.99 on major exchanges [...]This post Bitcoin Price Soars Past $108,000: What’s Driving This Powerful Rally? first appeared on BitcoinWorld and is written by Editorial Team	ONLY AVAILABLE IN PAID PLANS	https://bitcoinworld.co.in/bitcoin-price-surges-rally/	https://bitcoinworld.co.in/wp-content/uploads/bitcoin-price-soars-past-108000-whats-driving-this-powerful-rally.png	2025-05-24 07:30:34
136	0.089	10	NewsDATA	Head-To-Head Contrast: WEX (NYSE:WEX) versus QuoteMedia (OTCMKTS:QMCI)	QuoteMedia (OTCMKTS:QMCI – Get Free Report) and WEX (NYSE:WEX – Get Free Report) are both computer and technology companies, but which is the superior investment? We will contrast the two companies based on the strength of their risk, analyst recommendations, valuation, earnings, institutional ownership, profitability and dividends. Profitability This table compares QuoteMedia and WEX’s net [...]	ONLY AVAILABLE IN PAID PLANS	https://www.americanbankingnews.com/2025/05/24/head-to-head-contrast-wex-nysewex-versus-quotemedia-otcmktsqmci.html	https://www.marketbeat.com/logos/quotemedia-inc-logo-1200x675.png?v=20230113075645	2025-05-24 05:21:10
148	0.1	11	NewsAPI	3D Systems Corporation (DDD): A Bear Case Theory	We came across a bearish thesis on 3D Systems Corporation (DDD) on Substack by Industrial Tech Stock Analyst. In this article, we will summarize the bears...	We came across a bearish thesis on 3D Systems Corporation (DDD) on Substack by Industrial Tech Stock Analyst. In this article, we will summarize the bears thesis on DDD. 3D Systems Corporation (DDD)'… [+2715 chars]	https://finance.yahoo.com/news/3d-systems-corporation-ddd-bear-151256846.html	https://media.zenfs.com/en/insidermonkey.com/adb2f3e417085d75ab5981e7a4ff6f68	2025-04-25 15:12:56
137	0.089	10	NewsDATA	Contrasting WEX (NYSE:WEX) and QuoteMedia (OTCMKTS:QMCI)	WEX (NYSE:WEX – Get Free Report) and QuoteMedia (OTCMKTS:QMCI – Get Free Report) are both business services companies, but which is the superior business? We will compare the two companies based on the strength of their valuation, analyst recommendations, risk, dividends, earnings, institutional ownership and profitability. Risk and Volatility WEX has a beta of 1.26, [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/24/contrasting-wex-nysewex-and-quotemedia-otcmktsqmci.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fquotemedia-inc-logo-1200x675.png%3Fv%3D20230113075645&w=240&zc=2	2025-05-24 05:20:55
138	0	10	NewsAPI	My career has taken me to Goldman Sachs, JPMorgan, and Google. Here's what brought me back to Wall Street.	Melissa Goldman returned to Wall Street after stints at Goldman Sachs, JPMorgan, and Google. She discusses the evolving role of engineers in finance.	Goldman Sachs' Melissa GoldmanGoldman Sachs; Alyssa Powell/BI\r\n<ul><li>Melissa Goldman is the global head of engineering for global banking and markets at Goldman Sachs.</li><li>She previously worked… [+5861 chars]	https://www.businessinsider.com/big-tech-wall-street-finance-goldman-sachs-google-jpmorgan-career-2025-4	https://i.insider.com/681239ecc6ad288d147f8e1e?width=1200&format=jpeg	2025-05-05 17:29:25
139	0	10	NewsAPI	The Quantum Future Of Investing: A Radical Transformation Of Global Markets	Two key areas where quantum technologies promise significant breakthroughs are portfolio optimization and market sentiment analysis.	Lester Pereira, founder and CEO of TraderPal.\r\ngetty\r\nQuantum computing is poised to revolutionize industries globally, with one of the most significant transformations expected in the financial sect… [+6034 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/04/24/the-quantum-future-of-investing-a-radical-transformation-of-global-markets/	https://imageio.forbes.com/specials-images/imageserve/67c87f845efb791945e4fb64/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-24 12:30:00
140	0	10	NewsAPI	Where AI Lives: The Cloud’s Favorite Cities And What Comes After	AI infrastructure is shifting from hyperscale hubs to emerging global markets and edge devices — driven by model efficiency, power and policy constraints.	AIs Global Footprint: As workloads decentralize, the future of intelligence stretches from ... More hyperscale hubs to emerging markets and edge nodes worldwide.\r\ngetty\r\nWhere does AI live? Ask most … [+10264 chars]	https://www.forbes.com/sites/emilsayegh/2025/05/12/where-ai-lives-the-clouds-favorite-cities-and-what-comes-after/	https://imageio.forbes.com/specials-images/imageserve/681ee0835cb40dfdbd92fddc/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-12 11:52:57
141	0	10	NewsAPI	Dave Iben: Finding Hidden Value In A Stock Market Obsessed With Noise	Dave Iben of Kopernik Global Investors shares why hidden value, patience, and global contrarian investing still offer outsized opportunities in today's distorted markets.	Dave Iben. Chief Investment Officer, Managing Member, Founder, and Chairman of the Board of Kopernik ... More Global Investors.\r\nKopernik Global Investors, LLC\r\nHidden value is difficult to find. Tod… [+13395 chars]	https://www.forbes.com/sites/jimosman/2025/04/28/dave-iben-finding-hidden-value-in-a-stock-market-obsessed-with-noise/	https://imageio.forbes.com/specials-images/imageserve/680fc61fc12c99e4588b4483/0x0.jpg?format=jpg&crop=1365,768,x0,y158,safe&height=900&width=1600&fit=bounds	2025-04-28 21:18:51
142	0	10	NewsAPI	Climate change is coming for Florida’s real estate. Why don’t prices reflect it?	So far, property values have remained remarkably resilient to flood risks – more resilient than many of the actual homes.	As a University of Miami doctoral student studying climate change, Mayra Cruz knew more than most about the risks of sea rise and wetter storms and hurricanes.\r\nSo when she and her husband bought the… [+17709 chars]	https://www.miamiherald.com/news/local/environment/climate-change/article303949086.html	https://media.zenfs.com/en/miami_herald_mcclatchy_975/cc723bbbf776fb1a9498d70f2202c233	2025-05-06 11:02:37
143	0	10	NewsAPI	Learning From Global Family Business Splits	Large businesses often aim to expand, seeking benefits of scale in sales, production, purchasing power or development, or the efficiencies that come with integration.	Radu Magdin is CEO of Smartlink Communications. Global analyst, consultant, passionate about leadership, communications and competition.\r\ngetty\r\nLarge businesses often aim to expand, seeking either t… [+6415 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/05/21/learning-from-global-family-business-splits/	https://imageio.forbes.com/specials-images/imageserve/682c7d4460d708151f945a76/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-21 11:30:00
144	0	10	NewsAPI	3D Systems Corporation (DDD): A Bear Case Theory	We came across a bearish thesis on 3D Systems Corporation (DDD) on Substack by Industrial Tech Stock Analyst. In this article, we will summarize the bears...	We came across a bearish thesis on 3D Systems Corporation (DDD) on Substack by Industrial Tech Stock Analyst. In this article, we will summarize the bears thesis on DDD. 3D Systems Corporation (DDD)'… [+2715 chars]	https://finance.yahoo.com/news/3d-systems-corporation-ddd-bear-151256846.html	https://media.zenfs.com/en/insidermonkey.com/adb2f3e417085d75ab5981e7a4ff6f68	2025-04-25 15:12:56
145	0	10	NewsAPI	In Chaos, We Must Create: Trade, Tech And Power In A New World Order	We are in a period of global recalibration. It is multipolar chaos—and in chaos, we must create.	Koray Köse is a supply chain expert, tech futurist, author, former Gartner analyst and CEO &amp; Founder of KSE ADVISORY.\r\ngetty\r\nTo understand todays whiplash, we need to look back 35 years. After t… [+7868 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/04/29/in-chaos-we-must-create-trade-tech-and-power-in-a-new-world-order/	https://imageio.forbes.com/specials-images/imageserve/680fe95e4c60b054da5ec12c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-29 13:00:00
146	0	10	NewsAPI	Reality Check	I'm sick and god-damn tired of this! I have written tens of thousands of words about this and still, to this day, people are babbling about the "AI revolution" as the sky rains blood and crevices open in the Earth, dragging houses and cars and domesticated an…	I'm sick and god-damn tired of this! I have written tens of thousands of words about this and still, to this day, people are babbling about the "AI revolution" as the sky rains blood and crevices ope… [+38903 chars]	https://www.wheresyoured.at/reality-check/	https://www.wheresyoured.at/content/images/2024/01/wyea--1.jpeg	2025-04-28 16:53:36
147	0	10	NewsAPI	Apple Stock Earnings Preview: Things To Consider Before The Next Report	Examine the key factors to watch before the next Apple earnings report to help you make informed decisions on AAPL.	Apple's upcoming earnings report arrives at a critical juncture, with solid company fundamentals ... More potentially overshadowed by escalating macroeconomic and geopolitical challenges.\r\nGetty Imag… [+13710 chars]	https://www.forbes.com/sites/investor-hub/article/apple-aapl-stock-earnings-things-to-consider/	https://imageio.forbes.com/specials-images/imageserve/6807ef026a2cb38c08b48c67/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 11:00:00
149	0.1	11	NewsAPI	GE HealthCare Technologies Inc. (GEHC): Among the Best Stocks to Buy According to D1 Capital’s Daniel Sundheim	We recently compiled a list of the 10 Best Stocks to Buy According to D1 Capital’s Daniel Sundheim. In this article, we are going to take a look at where GE ...	We recently compiled a list of the 10 Best Stocks to Buy According to D1 Capital's Daniel Sundheim. In this article, we are going to take a look at where GE HealthCare Technologies Inc. (NASDAQ:GEHC)… [+5946 chars]	https://finance.yahoo.com/news/ge-healthcare-technologies-inc-gehc-145457549.html	https://s.yimg.com/ny/api/res/1.2/9LY.GuRI.QNh46CzPBuJEw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/750a0e87dc2bd52a02e0bfe5b37db390	2025-04-29 14:54:57
150	0.1	11	NewsAPI	Is The Travelers Companies Inc. (TRV) the Best Dow Stock for the Next 12 Months?	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where The Travelers...	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where The Travelers Companies Inc. (NYSE:TRV) stands against othe… [+6726 chars]	https://finance.yahoo.com/news/travelers-companies-inc-trv-best-182914103.html	https://s.yimg.com/ny/api/res/1.2/4GYK.xQX1wzMRHLfW4Hfqg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/8fb48c2b7c10399cbde85ad4dd7ed615	2025-04-30 18:29:14
151	0.1	11	NewsAPI	Is Coherent Corp. (COHR) a Hidden AI Stock to Buy Right Now?	We recently published a list of the 11 Hidden AI Stocks to Buy Right Now. In this article, we are going to take a look at where Coherent Corp. (NYSE:COHR...	We recently published a list of the 11 Hidden AI Stocks to Buy Right Now. In this article, we are going to take a look at where Coherent Corp. (NYSE:COHR) stands against other hidden AI stocks.\r\nDavi… [+5282 chars]	https://finance.yahoo.com/news/coherent-corp-cohr-hidden-ai-160000076.html	https://s.yimg.com/ny/api/res/1.2/aHqYT3YvirS977A1tGOPuw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/086ee30d8d7f96be325fd9f9e4b88564	2025-05-05 16:00:00
152	0.1	11	NewsAPI	Stocks to buy today: Tata Steel, Maruti among top 6 trading ideas for 7 May 2025	Markets are expected to consolidate on Wednesday amid India-Pakistan tensions. Nifty futures closed lower at 24,415, with India VIX rising over 3%. Options data suggests a broad trading range of 23,800–24,800. Analysts recommend stocks like Tata Steel, Maruti…	The Indian market is expected to consolidate on Wednesday amid rising geopolitical tensions between India and Pakistan.On Tuesday, Nifty futures closed lower by 0.56% at 24,415. India VIX, a gauge of… [+1765 chars]	https://economictimes.indiatimes.com/markets/stocks/news/stocks-to-buy-today-tata-steel-maruti-among-top-6-trading-ideas-for-7-may-2025/articleshow/120951438.cms	https://img.etimg.com/thumb/msid-120951418,width-1200,height-630,imgsize-71944,overlay-etmarkets/articleshow.jpg	2025-05-07 04:07:27
153	0.1	11	NewsAPI	Dalal Street Week Ahead: Nifty faces crucial test at key support zone amid rising volatility	Despite global uncertainties and geopolitical tensions, Indian equity markets showed resilience, consolidating before a slight weekly loss. The Nifty oscillated within a range, defending key support levels while volatility surged. Technical analysis suggests …	Amid ever-increasing uncertainties on the global front and similarly rising geopolitical tensions between India and Pakistan, the Indian equity markets demonstrated strong resilience. They consolidat… [+4706 chars]	https://economictimes.indiatimes.com/markets/stocks/news/dalal-street-week-ahead-nifty-faces-crucial-test-at-key-support-zone-amid-rising-volatility/articleshow/121053634.cms	https://img.etimg.com/thumb/msid-121053804,width-1200,height-630,imgsize-23896,overlay-etmarkets/articleshow.jpg	2025-05-10 08:55:12
154	0.1	11	NewsDATA	International Paper (NYSE:IP) Given Consensus Rating of “Moderate Buy” by Brokerages	International Paper (NYSE:IP – Get Free Report) has been given a consensus recommendation of “Moderate Buy” by the ten brokerages that are covering the firm, Marketbeat.com reports. Two equities research analysts have rated the stock with a sell recommendation, two have given a hold recommendation, five have assigned a buy recommendation and one has issued [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/24/international-paper-nyseip-given-consensus-rating-of-moderate-buy-by-brokerages.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Finternational-paper-company-logo-1200x675.jpg&w=240&zc=2	2025-05-24 06:58:49
155	0.1	11	NewsDATA	e.l.f. Beauty, Inc. (NYSE:ELF) Given Average Rating of “Moderate Buy” by Analysts	e.l.f. Beauty, Inc. (NYSE:ELF – Get Free Report) has been given a consensus recommendation of “Moderate Buy” by the eighteen analysts that are currently covering the firm, Marketbeat.com reports. Five analysts have rated the stock with a hold recommendation, eleven have assigned a buy recommendation and two have assigned a strong buy recommendation to the [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/24/e-l-f-beauty-inc-nyseelf-given-average-rating-of-moderate-buy-by-analysts.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Felf-beauty-inc-logo-1200x675.png%3Fv%3D20240125142237&w=240&zc=2	2025-05-24 06:24:59
156	0	11	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	Listen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, charm brac… [+12550 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o	https://ichef.bbci.co.uk/news/1024/branded_news/aae4/live/82babf60-2be4-11f0-8f57-b7237f6a66e6.png	2025-05-13 01:02:20
157	0	11	NewsAPI	Global South and Multilateral Financial Institutions: Where Does BRICS Stand?	Why BRICS has gotten barely anywhere on launching its own finanicial institutions and why that is unlikely to change soon if ever.	Yves here. Even though this post stresses the opportunity for BRICS members to play a heftier role in international lending and development programs, it effectively admits BRICS is pretty much nowwhe… [+11574 chars]	https://www.nakedcapitalism.com/2025/05/global-south-and-multilateral-financial-institutions-where-does-brics-stand.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/05/Screenshot-2025-05-01-at-12.33.06 PM.png	2025-05-01 05:49:03
158	0	11	NewsAPI	Has The Stock Market Hit A Bottom In 2025?	Has the stock market bottomed in 2025? See what metrics to monitor in order to determine if the stock market has bottomed out this year.	The market has shown promising signs of bottoming, with sentiment reaching extreme pessimism and ... More valuations moderating to more reasonable levels.\r\ngetty\r\nAfter a turbulent start to 2025, inv… [+16095 chars]	https://www.forbes.com/sites/investor-hub/article/has-the-stock-market-hit-bottom-2025/	https://imageio.forbes.com/specials-images/imageserve/68224cebac1649661e2b3b01/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 16:21:03
159	0	11	NewsAPI	The Curious Case of the Hostile Takeover Bid by a Bank Facing Criminal Charges	Spain's BBVA, as a legal entity, and some of its former senior executives are facing prosecution on a number of charges, but it still wants to take over its third biggest rival. The ECB has already given its blessing.	Spain’s BBVA, as a legal entity, and some of its former senior executives are facing prosecution on a number of charges, but it still wants to take over its third biggest rival. The ECB has already g… [+16760 chars]	https://www.nakedcapitalism.com/2025/05/the-curious-case-of-a-hostile-takeover-by-a-spanish-bank-facing-criminal-prosecution-for-alleged-systemic-bribery-and-blackmail.html	https://www.reuters.com/graphics/BRV-BRV/dwpkkwznjpm/chart.png	2025-05-13 10:45:10
160	0	11	NewsAPI	Why Small Cap Stocks Are Ready For A Rebound	The market is priced at 21 times earnings. Small value stocks are priced at 13 times.	Miles Lewis, manager of the Royce Small Cap Total Return Fund, makes the case that at a time of turbulence in the economy, his quirky collection of small companies is equipped to beat the big names.\r… [+6580 chars]	https://www.forbes.com/sites/baldwin/2025/05/17/why-small-caps-are-ready-for-a-rebound/	https://imageio.forbes.com/specials-images/imageserve/6827695d8a826e0a79d03dcd/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-17 10:30:00
161	0	11	NewsAPI	Experts Warn Tariffs Could Negatively Impact 'Pretty Fragile Supply' Of Generic Drugs	With pharmaceutical tariffs expected to be announced in the next 30 to 60 days, experts are warning they could negatively impact the "pretty fragile supply" ...	<ul><li>With pharmaceutical tariffs expected to be announced in the next 30 to 60 days, experts are warning they could negatively impact the "pretty fragile supply" of generic drugs\r\n</li><li>The fin… [+4609 chars]	https://finance.yahoo.com/news/experts-warn-tariffs-could-negatively-194428166.html	https://media.zenfs.com/en/Benzinga/ca673395a2c176f98767fb7f81435b82	2025-04-27 19:44:28
162	0	11	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	[BBC]\r\nListen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, cha… [+12593 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o?xtor=AL-72-%5Bpartner%5D-%5Byahoo.north.america%5D-%5Bheadline%5D-%5Bnews%5D-%5Bbizdev%5D-%5Bisapi%5D	https://s.yimg.com/ny/api/res/1.2/KCRZCNNpBtNpxCt2n0B3xw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/bbc_us_articles_995/4841ce513e08f2796e14f20ad698611f	2025-05-13 09:07:02
163	0	11	NewsAPI	Cathie Wood's Firm Predicts Bitcoin Price Could Surge to $1.5Mn by 2030	The forecast highlights institutional adoption, Bitcoin's role as a "digital gold," and emerging market demand as the key drivers behind the potential surge.	Investor and CEO Cathie Wood's ARK Invest firm projects that Bitcoin could reach $1.5 million per coin by 2030, according to its newly released Big Ideas 2025 report.\r\nThe forecast, detailed this wee… [+5117 chars]	https://www.newsweek.com/cathie-woods-firm-predicts-bitcoin-price-could-surge-15mn-2030-2064348	https://d.newsweek.com/en/full/2633560/bitcoin.jpg	2025-04-25 21:04:28
164	0	11	NewsAPI	We Are Looking Down The Barrel Of A Worldwide Credit Market Crisis That Threatens To Be Absolutely Horrific	National governments around the world collectively have more than 100 trillion dollars in debt.  The United States accounts for about 35 percent of that total, China accounts for about 16 percent of that total, and Japan accounts for about 10 percent of that …	This article was originally published by Michael Snyder at The Economic Collapse Blog. \r\nNational governments around the world collectively have more than 100 trillion dollars in debt.  The United St… [+7260 chars]	https://www.shtfplan.com/headline-news/we-are-looking-down-the-barrel-of-a-worldwide-credit-market-crisis-that-threatens-to-be-absolutely-horrific	https://www.shtfplan.com/wp-content/uploads/2018/09/financial-crisis-e1537796744446.jpg	2025-05-23 12:30:01
165	0	11	NewsAPI	US credit rating downgrade is an intrusion of reality into Mad King Donald’s delusions	Donald Trump thought he could command international financial markets. But with Moody's removing the last triple-A credit rating on US debt, they're increasingly commanding him.\nThe post US credit rating downgrade is an intrusion of reality into Mad King Dona…	Economic and fiscal reality continue to mug Mad King Donald. He can issue executive orders trying to control the global tide of money all day, but like medieval king Cnut, the tide will follow its ow… [+5006 chars]	http://www.crikey.com.au/2025/05/19/us-credit-rating-downgrade-donald-trump-delusion/	https://www.crikey.com.au/wp-content/uploads/sites/3/2025/05/Mad-king-Donald_1680x945.jpg?quality=70&w=1024	2025-05-19 01:06:52
166	0	11	NewsAPI	Trump has opened the door to a new Saudi oil-price war	Markets should prepare for a sharp downturn in the oil price, analysts with a satellite oil-tracking firm write in a guest commentary.	For the second time in five years, Saudi Arabia, in an apparent act of self-harm, is flooding a weakening, oversupplied market with oil.\r\nBrent prices sank to a four-year low on Monday after Riyadh a… [+7225 chars]	https://www.livemint.com/opinion/trump-has-opened-the-door-to-a-new-saudi-oil-price-war-11746758936416.html	https://www.livemint.com/lm-img/img/2025/05/09/1600x900/g548e1e303a034582aabb0ad6d2ee62597c61715caa80ae9106d3ac65b705066474c0848f5af00eb4c61d85c71ac2f2cfbc35e0398606f956fc1b1b8623147919_1280_1746761650650_1746761663466.png	2025-05-09 03:52:20
167	0	11	NewsAPI	Apple Q2 2025 Financials Solid Despite Upcoming Tariff Uncertainty	Although tariff hikes did not materially affect Apple’s revenues and profits for Apple’s second fiscal quarter of 2025, that may change next quarter. Most product categories saw higher revenues than last year’s, with only Wearables posting a decline.	Reporting on its Q2 2025 financial results, Apple announced profits of $24.8 billion ($1.65 per diluted share, representing an 8% year-over-year increase) on revenues of $95.4 billion. The companys r… [+6844 chars]	https://tidbits.com/2025/05/02/apple-q2-2025-financials-solid-despite-upcoming-tariff-uncertainty/	https://tidbits.com/uploads/2025/05/2025-Q2-Segments.png	2025-05-02 21:06:51
168	0.3	12	NewsAPI	Freeport-McMoRan Inc. (FCX): Among the Best Materials Stocks to Buy According to Hedge Funds	We recently compiled a list of the 11 Best Materials Stocks to Buy According to Hedge Funds. In this article, we are going to take a look at where Freeport...	We recently compiled a list of the 11 Best Materials Stocks to Buy According to Hedge Funds. In this article, we are going to take a look at where Freeport-McMoRan Inc. (NYSE:FCX) stands against the … [+6731 chars]	https://finance.yahoo.com/news/freeport-mcmoran-inc-fcx-among-122413122.html	https://s.yimg.com/ny/api/res/1.2/liH4atOaF.Kbs2kiDu0U3g--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/675baed01c3842175ac68a7c7b0d599b	2025-04-25 12:24:13
169	0.208	12	NewsAPI	Is Alphabet Inc. (GOOGL) the Best Stock to Buy and Hold for 20 Years?	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where Alphabet Inc...	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where Alphabet Inc. (NASDAQ:GOOGL) stands against other best stocks to buy… [+5790 chars]	https://finance.yahoo.com/news/alphabet-inc-googl-best-stock-220815888.html	https://s.yimg.com/ny/api/res/1.2/DAytqpJ37WPkT1O3cj4krg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/ddded06c9301164bc21c334085fab02f	2025-04-23 22:08:15
170	0.208	12	NewsAPI	Is NextEra Energy, Inc. (NEE) the Best Stock to Buy and Hold for 20 Years?	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where NextEra Energy, Inc...	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where NextEra Energy, Inc. (NYSE:NEE) stands against other best stocks to … [+6086 chars]	https://finance.yahoo.com/news/nextera-energy-inc-nee-best-221629556.html	https://s.yimg.com/ny/api/res/1.2/HqRlnL9I0zBtY_Obdt47OQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/9d49cfd4a88d535a69021dd256f8c183	2025-04-23 22:16:29
171	0.208	12	NewsAPI	Is Walt Disney Company (DIS) the Best Stock to Buy and Hold for 20 Years?	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where Walt Disney Company...	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where Walt Disney Company (NYSE:DIS) stands against other best stocks to b… [+5962 chars]	https://finance.yahoo.com/news/walt-disney-company-dis-best-221540680.html	https://s.yimg.com/ny/api/res/1.2/qll68Pqi9ptiJCMsvfcIiw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/8f30bf48abee622382b4ac6f4f499336	2025-04-23 22:15:40
172	0.208	12	NewsAPI	Is Apple Inc. (AAPL) the Best Stock to Buy and Hold for 20 Years?	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where Apple Inc. (NASDAQ:AAPL...	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where Apple Inc. (NASDAQ:AAPL) stands against other best stocks to buy and… [+6873 chars]	https://finance.yahoo.com/news/apple-inc-aapl-best-stock-220758797.html	https://s.yimg.com/ny/api/res/1.2/e1QwhqQiBt5ecLL5Qx6Rkg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/bd47dc2e86b4a3086f845d200d9daf1f	2025-04-23 22:07:58
173	0.208	12	NewsAPI	Is AT&T Inc. (T) the Best Stock to Buy and Hold for 20 Years?	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where AT&T Inc. (NYSE:T) stands ...	We recently published a list of 10 Best Stocks to Buy and Hold for 20 Years. In this article, we are going to take a look at where AT&amp;T Inc. (NYSE:T) stands against other best stocks to buy and h… [+8727 chars]	https://finance.yahoo.com/news/t-inc-t-best-stock-221416821.html	https://s.yimg.com/ny/api/res/1.2/X6GFrxR7HaBIQMzsm.Yhjg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/4c59bddc5825c686a3fb5fedaf3d4e45	2025-04-23 22:14:16
174	0.208	12	NewsAPI	Is NVIDIA Corp. (NVDA) the Best Dow Stock for the Next 12 Months?	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where NVIDIA Corp...	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where NVIDIA Corp. (NASDAQ:NVDA) stands against other best and wo… [+7552 chars]	https://finance.yahoo.com/news/nvidia-corp-nvda-best-dow-182504151.html	https://s.yimg.com/ny/api/res/1.2/kZveoOmr3ngssVpudK1u4A--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/aa94e059977d3251b8b0630718e013fc	2025-04-30 18:25:04
175	0.2	12	NewsAPI	Is JPMorgan Chase & Co. (JPM) the Best Dow Stock for the Next 12 Months?	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where JPMorgan Chase & ...	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where JPMorgan Chase &amp; Co. (NYSE:JPM) stands against other be… [+6534 chars]	https://finance.yahoo.com/news/jpmorgan-chase-co-jpm-best-182750467.html	https://s.yimg.com/ny/api/res/1.2/0BwlrHHssSozZHQNtMcVwA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/f82652d0e7c350dea8b9d7c85e94e30e	2025-04-30 18:27:50
176	0.2	12	NewsAPI	Insmed Incorporated (INSM): Among Takeover Rumors Hedge Funds Are Buying	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Insmed Incorporated...	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Insmed Incorporated (NASDAQ:INSM) stands against other takeover rumor … [+6349 chars]	https://finance.yahoo.com/news/insmed-incorporated-insm-among-takeover-004658190.html	https://s.yimg.com/ny/api/res/1.2/q0jcATnP4WzyiN4L_eFecg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/f1136a00c40c7acf614094b77687851f	2025-04-24 00:46:58
177	0.2	12	NewsAPI	First Solar, Inc. (FSLR): Among Takeover Rumors Hedge Funds Are Buying	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where First Solar, Inc...	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where First Solar, Inc. (NASDAQ:FSLR) stands against other takeover rumor st… [+6361 chars]	https://finance.yahoo.com/news/first-solar-inc-fslr-among-004711979.html	https://s.yimg.com/ny/api/res/1.2/2UiPDi70DDtOggWNzNJezA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/1178c453a155b2a1b49a48a61681af45	2025-04-24 00:47:11
178	0.2	12	NewsAPI	GE Vernova Inc. (GEV): Among the Best Stocks to Buy During Recession	We recently compiled a list of the 15 Best Stocks to Buy During Recession. In this article, we are going to take a look at where GE Vernova Inc. (NYSE:GEV...	We recently compiled a list of the 15 Best Stocks to Buy During Recession. In this article, we are going to take a look at where GE Vernova Inc. (NYSE:GEV) stands against the other stocks.\r\nAs per Bl… [+6687 chars]	https://finance.yahoo.com/news/ge-vernova-inc-gev-among-145308639.html	https://s.yimg.com/ny/api/res/1.2/pklo8xGWk9ggSTR7ge2A8Q--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/b10e52ac8d59186991d447137deb09e9	2025-05-01 14:53:08
179	0.2	12	NewsAPI	Juniper Networks, Inc. (JNPR): Among Takeover Rumors Hedge Funds Are Buying	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Juniper Networks, Inc...	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Juniper Networks, Inc. (NYSE:JNPR) stands against other takeover rumor… [+6394 chars]	https://finance.yahoo.com/news/juniper-networks-inc-jnpr-among-004746332.html	https://s.yimg.com/ny/api/res/1.2/zzCUUHEyoeFvhyIuBOmx8Q--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/71701702003d2dfc1cb3f81663ada1cc	2025-04-24 00:47:46
180	0.2	12	NewsAPI	Plug Power Inc. (PLUG): Among Takeover Rumors Hedge Funds Are Buying	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Plug Power Inc. (NASDAQ:PLUG...	We recently published a list of 20 Takeover Rumors Hedge Funds Are Buying. In this article, we are going to take a look at where Plug Power Inc. (NASDAQ:PLUG) stands against other takeover rumor stoc… [+6338 chars]	https://finance.yahoo.com/news/plug-power-inc-plug-among-132014431.html	https://s.yimg.com/ny/api/res/1.2/_QrgZGxugYSlQScGlOFVqw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/e7c1669c84b3f2c09c694d4c2541ad40	2025-04-24 13:20:14
181	0.2	12	NewsAPI	Why VirTra, Inc. (VTSI) Is Among the Best Prison and Law Enforcement Stocks to Buy According to Analysts	We recently published a list of 11 Best Prison and Law Enforcement Stocks to Buy According to Analysts. In this article, we are going to take a look at where...	We recently published a list of 11 Best Prison and Law Enforcement Stocks to Buy According to Analysts. In this article, we are going to take a look at where VirTra, Inc. (NASDAQ:VTSI) stands against… [+5539 chars]	https://finance.yahoo.com/news/why-virtra-inc-vtsi-among-205955607.html	https://s.yimg.com/ny/api/res/1.2/rsjEfvtZb9iFPWn5UkhK4w--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/c8407317753a24cbfe281ef634d9b6a4	2025-04-27 20:59:55
182	0.2	12	NewsAPI	MercadoLibre, Inc. (MELI): Among the Best Fintech Stocks to Buy in 2025	We recently compiled a list of the 12 Best Fintech Stocks to Buy in 2025. In this article, we are going to take a look at where MercadoLibre, Inc...	We recently compiled a list of the 12 Best Fintech Stocks to Buy in 2025. In this article, we are going to take a look at where MercadoLibre, Inc. (NASDAQ:MELI) stands against the other fintech stock… [+7346 chars]	https://finance.yahoo.com/news/mercadolibre-inc-meli-among-best-023256197.html	https://s.yimg.com/ny/api/res/1.2/KaITDnFQJ9zFrwcdfWN1jg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/3c14b7d7e5a067562bc220daa8e6dc22	2025-04-29 02:32:56
183	0.1	12	NewsAPI	Has The Stock Market Hit A Bottom In 2025?	Has the stock market bottomed in 2025? See what metrics to monitor in order to determine if the stock market has bottomed out this year.	The market has shown promising signs of bottoming, with sentiment reaching extreme pessimism and ... More valuations moderating to more reasonable levels.\r\ngetty\r\nAfter a turbulent start to 2025, inv… [+16095 chars]	https://www.forbes.com/sites/investor-hub/article/has-the-stock-market-hit-bottom-2025/	https://imageio.forbes.com/specials-images/imageserve/68224cebac1649661e2b3b01/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 16:21:03
184	0.1	12	NewsAPI	Is Westlake Corp. (NYSE:WLK) a Small-Cap Construction and Materials Stock Hedge Funds Are Buying?	We recently published a list of the 15 Small-Cap Construction and Materials Stocks Hedge Funds Are Buying. In this article, we are going to take a look at...	We recently published a list of the 15 Small-Cap Construction and Materials Stocks Hedge Funds Are Buying. In this article, we are going to take a look at where Westlake Corp. (NYSE:WLK) stands again… [+4915 chars]	https://finance.yahoo.com/news/westlake-corp-nyse-wlk-small-001305152.html	https://s.yimg.com/ny/api/res/1.2/G_9nXM8k91dRVDVkxm.HNA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/3eebf56b5523df1342bd61f9fcc98a9a	2025-04-30 00:13:05
185	0.1	12	NewsAPI	Bitcoin now deflationary due to Strategy's BTC purchases — Analyst	Strategy, a Bitcoin (BTC) treasury company, is accumulating Bitcoin at a faster rate than total miner output, giving the supply-capped asset a -2.33% annual deflation rate, according to CryptoQuant CEO and market analyst Ki Young Ju."Their 555,000 BTC is illi…	Strategy, a Bitcoin (BTC) treasury company, is accumulating Bitcoin at a faster rate than total miner output, giving the supply-capped asset a -2.33% annual deflation rate, according to CryptoQuant C… [+2624 chars]	https://cointelegraph.com/news/bitcoin-deflationary-due-strategy-btc-purchases	https://images.cointelegraph.com/cdn-cgi/image/format=auto,onerror=redirect,quality=90,width=1200/https://s3.cointelegraph.com/uploads/2025-02/019537fb-be50-7275-9d25-5a3767b022cc	2025-05-10 18:01:28
186	0.1	12	NewsAPI	WealthTech, Retirement And Investing Predictions For 2025 And Beyond	I expect the industry to raise more awareness of the different ways to access alternatives in an investment portfolio.	Eric Satz is Founder and CEO of AltoIRA, which provides investment access with retirement savings to private market assets for all. \r\ngetty\r\nInvestors have faced highly volatile and stressful conditi… [+5889 chars]	https://www.forbes.com/councils/forbesfinancecouncil/2025/04/24/wealthtech-retirement-and-investing-predictions-for-2025-and-beyond/	https://imageio.forbes.com/specials-images/imageserve/66e2101478d00bd52386ce1d/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-24 11:00:00
187	0.1	12	NewsAPI	Why Byrna Technologies (BYRN) Is Among the Best Prison and Law Enforcement Stocks to Buy According to Analysts	We recently published a list of 11 Best Prison and Law Enforcement Stocks to Buy According to Analysts. In this article, we are going to take a look at where...	We recently published a list of 11 Best Prison and Law Enforcement Stocks to Buy According to Analysts. In this article, we are going to take a look at where Byrna Technologies Inc. (NASDAQ:BYRN) sta… [+6166 chars]	https://finance.yahoo.com/news/why-byrna-technologies-byrn-among-205440571.html	https://s.yimg.com/ny/api/res/1.2/uRlaRhBxKxe2gkQcm_vR3A--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/87f94afdefd0b70ca39cffc4a460dc9c	2025-04-27 20:54:40
188	0.208	13	NewsAPI	How Donald Trump Upended US Foreign Policy in 100 Days	"It's been one of the most exciting starts to a new presidential term since Gorbachev," academic Barry Scott Zellen told Newsweek.	President Donald Trump is "redrawing the world map" with his foreign policy, driven by his "America first" stance, his anti-globalist position, his "like" for provoking America's allies and his desir… [+10883 chars]	https://www.newsweek.com/donald-trump-foreign-policy-100-days-2064942	https://d.newsweek.com/en/full/2626627/trump-upended-foreign-policy-100-days.png	2025-04-29 11:38:26
190	0.1	13	NewsAPI	‘Father of neoliberalism’ dies aged 88	Joseph Nye introduced the term ‘soft power’ in international relations Read Full Article at RT.com	US political scientist Joseph Nye, who co-authored the international relations theory of neoliberalism together with Robert Keohane and coined the term “soft power,” has died at the age of 88, accord… [+1922 chars]	https://www.rt.com/news/617036-nye-us-neoliberalism-dies/	https://mf.b37mrtl.ru/files/2025.05/article/681cbcc920302733e26fe2c8.jpg	2025-05-08 16:27:58
191	0.1	13	NewsAPI	The Coming Jewish\nCivil War Over\nDonald Trump	Following the Hamas October 7, 2023, terrorist attack on Israel, in which that group murdered approximately 1,200 people and took 251 more hostage, Israel began a military campaign of “total victory” against the group—a terrorist organization it has previousl…	Lately, AIPAC has also directly entered the money fray, after decades of pretense otherwise, with its own political action committee: one that specializes in raising money from wealthy Republicans an… [+3506 chars]	https://newrepublic.com/article/194674/trump-antisemitism-universities-jewish-civil-war	https://images.newrepublic.com/e5bd4ce31cb8336c2b2cf0c9bbb17f4218ef5576.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-08 10:00:00
192	0.1	13	NewsAPI	Asean urged to weigh risks of siding with US over China in tariff war	HONG KONG &mdash; Southeast Asian countries risk isolation by China and stalled growth prospects if they align too closely with the United States in the trade war, a well-known Chinese political scientist has warned.	HONG KONG — Southeast Asian countries risk isolation by China and stalled growth prospects if they align too closely with the United States in the trade war, a well-known Chinese political scientist … [+4875 chars]	https://www.bangkokpost.com/business/general/3013840/asean-urged-to-weigh-risks-of-siding-with-us-over-china-in-tariff-war	https://static.bangkokpost.com/media/content/20250429/c1_3013840_700.jpg	2025-04-29 05:20:00
193	0.1	13	NewsAPI	Real Men Steal Countries: Inside Trump’s Absurd Greenland Obsession	Go West, young man, and grow up with the country. There is nothing for you in the East. The irascible New York newspaper editor Horace Greeley said that around 1833, of course, except that he probably didn’t. It is appropriate that this famous epigraph of Ame…	The American crisis is domestic in nature, a crisis of confidence. The way we provide housing, education, and medicine is broken, while tax cuts have ensured were funding meager services through debt… [+6916 chars]	https://newrepublic.com/article/194716/trump-greenland-nineteenth-century-steal-country	https://images.newrepublic.com/9e29dd0d455627399929b669699933744c21e604.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-15 10:00:00
194	0.1	13	NewsAPI	Asean urged to weigh risks of siding with US over China in tariff war	The US is only interested in the Asean market, while China is better placed to help bloc realise its goals, Zheng Yongnian tells the Post Read full story	South-East Asian countries risk isolation by China and stalled growth prospects if they align too closely with the US in the trade war, a well-known Chinese political scientist has warned.\r\nZheng Yon… [+5243 chars]	https://www.thestar.com.my/aseanplus/aseanplus-news/2025/04/28/asean-urged-to-weigh-risks-of-siding-with-us-over-china-in-tariff-war	https://apicms.thestar.com.my/uploads/images/2025/04/29/3289596.jpg	2025-04-29 09:55:00
195	0	13	NewsAPI	‘Burst balloon’: How Pahalgam attack shattered Modi’s Kashmir narrative	Since 2019, Modi government has argued Kashmir was returning to 'normalcy'. The attack exposed holes in its approach.	New Delhi, India Addressing a rally of supporters in September 2024, Indian Prime Minister Narendra Modi confidently asserted that his Hindu majoritarian Bharatiya Janata Party (BJP) would create a n… [+11096 chars]	https://www.aljazeera.com/news/2025/4/28/burst-balloon-how-pahalgam-attack-shattered-modis-kashmir-narrative	https://www.aljazeera.com/wp-content/uploads/2025/04/2025-04-27T065209Z_591593559_RC256EAMI4NX_RTRMADP_3_INDIA-KASHMIR-ATTACK-1745805610.jpg?resize=1920%2C1440	2025-04-28 03:58:31
196	0	13	NewsAPI	Can Ramaphosa charm offensive help fix South Africa’s ties with Trump’s US?	South African leader keeps calm in the face of an 'ambush' by Donald Trump about false 'white genocide' claims.	Johannesburg, South Africa When the millionaire mining magnate-turned-president of South Africa landed in Washington to meet the billionaire real estate tycoon-turned-president of the United States, … [+11829 chars]	https://www.aljazeera.com/features/2025/5/21/can-ramaphosa-charm-offensive-help-fix-south-africas-ties-with-trumps-us	https://www.aljazeera.com/wp-content/uploads/2025/05/2025-05-21T162153Z_1858847121_RC2GMEARU27F_RTRMADP_3_USA-SAFRICA-1747844657.jpg?resize=1920%2C1440	2025-05-21 20:45:53
197	0	13	NewsAPI	Will India And Pakistan Go To War?	There isa growing risk that India and Pakistan go to war and that there is no global policeman - like the US was - to pull them apart.	TOPSHOT - Indian Air Force recruits perform a drill during the presentation of the Indian ... More President's Standards and Colours, by Indian President Ram Nath Kovind at Borjhar Air Force Station … [+4940 chars]	https://www.forbes.com/sites/mikeosullivan/2025/05/09/will-india-and-pakistan-go-to-war/	https://imageio.forbes.com/specials-images/imageserve/681e708c340f3417d592ae09/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-09 21:17:52
198	0	13	NewsAPI	‘No guardrails’: How India-Pakistan combat obliterated old red lines	From missiles targeting broad swaths of territory to water as a weapon, the threshold for the next war has been lowered.	New Delhi, India  Guns have fallen silent for now along the tense India-Pakistan frontier, after a ceasefire that appears to have held for three nights.\r\nOn May 7, India launched predawn attacks on w… [+12664 chars]	https://www.aljazeera.com/news/2025/5/13/no-guardrails-how-india-pakistan-combat-obliterated-old-red-lines	https://www.aljazeera.com/wp-content/uploads/2025/04/AP25044777628131-11-1745390343.jpg?resize=1200%2C630	2025-05-13 07:08:49
199	0	13	NewsAPI	Joseph Nye Was the Champion of a World That No Longer Exists	The distinguished scholar, who coined “soft power,” shaped five decades of U.S. foreign policy.	It is poignant yet perhaps fitting to mourn Joseph Nye, the distinguished international relations scholar, just as his lifes work championing U.S. leadership and liberal internationalism has run agro… [+11154 chars]	http://foreignpolicy.com/2025/05/09/joseph-nye-death-us-foreign-policy-soft-power/	https://foreignpolicy.com/wp-content/uploads/2025/05/1-joseph-nye-soft-power-2RP3X9X.jpg?w=1000	2025-05-09 17:08:46
200	0	13	NewsAPI	What or where is the Indo-Pacific? How a foreign policy pivot redefined the global map	The term can be traced back to the 1920s, but it only began to gain currency in the late 20th and early 21st centuries.	Is the Indo-Pacific concept about international dialogue ... or just containing China? Tetra images/Getty Images\r\nOpen a book of maps and look for the “Indo-Pacific” region – it likely won’t be there… [+6220 chars]	https://theconversation.com/what-or-where-is-the-indo-pacific-how-a-foreign-policy-pivot-redefined-the-global-map-256406	https://images.theconversation.com/files/667428/original/file-20250512-56-yt8tin.jpg?ixlib=rb-4.1.0&rect=0%2C427%2C5119%2C2559&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-13 12:31:01
201	0	13	NewsAPI	The risks of recognizing Russia's annexation of Crimea	The United States has reportedly called on Ukraine to accept Russian control of Crimea as part of a peace agreement. However, Ukraine says doing so would violate the constitution.	The United States has reportedly sent its European allies a confidential paper with proposals for a ceasefire to end Russia's war against Ukraine. One of the key demands is apparently the recognition… [+5590 chars]	https://www.dw.com/en/the-risks-of-recognizing-russias-annexation-of-crimea/a-72355406	https://static.dw.com/image/72342099_6.jpg	2025-04-25 15:59:00
202	0	13	NewsAPI	Both Xi and Trump Want the Other to Call Them First	A conflict over face is tangling up the trade war’s resolution.	As if U.S.-China relations werent complicated enough, the two sides are also squaring off over which side will lose face in their trade battle. In the United States, the Chinese concern about saving … [+14475 chars]	http://foreignpolicy.com/2025/05/09/china-us-trade-war-tariffs-trump-xi/	https://foreignpolicy.com/wp-content/uploads/2025/05/0-trump-xi-china-trade-war-tariff-x.gif?w=1000	2025-05-09 14:32:43
203	0	13	NewsAPI	Turkey: wanting to have it both ways on Israel	Though longstanding allies, Turkey under Recep Tayyip Erdoğan has grown increasingly critical of Israel's actions towards the Palestinians, but without renouncing Ankara's broader strategic interests.\n\n-\n2025/05\n\n/ \narticle	Proud return: the Turkish ship Mavi Marmara arrives at Istanbuls Sarayburnu port on 26 December 2010 after the Israeli navy raid on the vessel, part of a flotilla of aid ships bound for Gaza, on 31 M… [+21079 chars]	https://mondediplo.com/2025/05/02turkey	https://mondediplo.com/IMG/logo/gettyimages-107782393.jpg	2025-04-30 07:26:01
204	0	13	NewsAPI	EGU2025 - How the week in Vienna unfolded	Note: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia mentioned below, be released sometime after the conference ends, I'll include links to the ones I …	Posted on 2 May 2025 by BaerbelW\r\nNote: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia ment… [+32724 chars]	https://skepticalscience.com/egu25-personal-diary.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-02 06:23:14
205	0	13	NewsAPI	Trump Faces New Nuclear Crisis as India-Pakistan Tensions Soar	One of India's most decorated officers told Newsweek "de-fusing this serious South Asian crisis would garner some brownie points" for Trump.	As President Donald Trump grapples with wars raging in Ukraine and the Gaza Strip, another major flashpoint is simmering in South Asia, where tensions are escalating after a deadly attack along one o… [+19052 chars]	https://www.newsweek.com/trump-faces-new-nuclear-crisis-india-pakistan-tensions-soar-2063401	https://d.newsweek.com/en/full/2632682/india-pakistan-tensions-soar.png	2025-04-25 08:00:02
206	0	13	NewsAPI	India-Pakistan strikes: 5 essential reads on decades of rivalry and tensions over Kashmir	India and Pakistan have engaged in 4 wars since 1947. Tensions over the disputed region of Kashmir have often been the source.	Indian paramilitary soldiers patrol a street in Srinagar, Jammu and Kashmir on May 4, 2025. Firdous Nazir/NurPhoto via Getty Images\r\nIndian airstrikes deep into Pakistan and retaliatory shelling acro… [+8472 chars]	https://theconversation.com/india-pakistan-strikes-5-essential-reads-on-decades-of-rivalry-and-tensions-over-kashmir-256157	https://images.theconversation.com/files/666474/original/file-20250507-56-wv8381.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C4897%2C2448&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-07 17:39:24
207	0	13	NewsAPI	New chancellor, new hopes: Friedrich Merz debuts in Brussels	Six hours, four meetings, one message: Berlin is back on the global stage. But can the newly elected German chancellor, Friedrich Merz, deliver where the traffic-light coalition fell short?	It was a lightning-fast inaugural visit. Within just six hours, newly appointed German Chancellor Friedrich Merz dashed through a series of high-level meetings in Brussels  with European Council Pres… [+8424 chars]	https://www.dw.com/en/new-chancellor-new-hopes-friedrich-merz-debuts-in-brussels/a-72491753	https://static.dw.com/image/72487815_6.jpg	2025-05-09 16:43:00
208	0.114	14	NewsDATA	Vatican Labels Armenia Anti-Christian State - Fuad Akhundov Details	(MENAFN - Trend News Agency) BAKU, Azerbaijan, May 24.? Media outlets inArmenia and Italy continue to react to the international conferencetitled "Christianity in Azerbaijan: History and ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109589753/Vatican-Labels-Armenia-Anti-Christian-State-Fuad-Akhundov-Details	https://menafn.com/updates/pr/2025-05/24/TNA_be1b3image_story.jpg	2025-05-24 03:05:18
209	0	14	NewsAPI	Real Men Steal Countries: Inside Trump’s Absurd Greenland Obsession	Go West, young man, and grow up with the country. There is nothing for you in the East. The irascible New York newspaper editor Horace Greeley said that around 1833, of course, except that he probably didn’t. It is appropriate that this famous epigraph of Ame…	The American crisis is domestic in nature, a crisis of confidence. The way we provide housing, education, and medicine is broken, while tax cuts have ensured were funding meager services through debt… [+6916 chars]	https://newrepublic.com/article/194716/trump-greenland-nineteenth-century-steal-country	https://images.newrepublic.com/9e29dd0d455627399929b669699933744c21e604.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-15 10:00:00
210	0	14	NewsAPI	Trump Faces New Nuclear Crisis as India-Pakistan Tensions Soar	One of India's most decorated officers told Newsweek "de-fusing this serious South Asian crisis would garner some brownie points" for Trump.	As President Donald Trump grapples with wars raging in Ukraine and the Gaza Strip, another major flashpoint is simmering in South Asia, where tensions are escalating after a deadly attack along one o… [+19052 chars]	https://www.newsweek.com/trump-faces-new-nuclear-crisis-india-pakistan-tensions-soar-2063401	https://d.newsweek.com/en/full/2632682/india-pakistan-tensions-soar.png	2025-04-25 08:00:02
211	0	14	NewsAPI	Scientology, The CIA, and MK-ULTRA	The first in a series investigating the intelligence connections to the Church of Scientology since its founding, including drug trafficking operations, founder L. Ron Hubbard’s work adjacent to the CIA’s MK-ULTRA, and their unprecedented infiltration of the …	The first in a series investigating the intelligence connections to the Church of Scientology since its founding, including drug trafficking operations, founder L. Ron Hubbards work adjacent to the C… [+69454 chars]	https://www.activistpost.com/scientology-the-cia-and-mk-ultra/	https://www.activistpost.com/wp-content/uploads/2025/05/scientologymkultra-1160x680-1.webp	2025-05-08 20:00:00
212	0	14	NewsAPI	Une fondation russe destinée à aider les « compatriotes » à l'étranger soutient des espions, des criminels et des propagandistes	Depuis plus de dix ans, le "Pravfond" fournit une aide juridique aux Russes du monde entier. Des courriels internes obtenus par des journalistes montrent comment il a collaboré avec des espions, financé des efforts de propagande et établi des points d'influen…	For over a decade, Pravfond has been providing legal aid to Russians across the world. Internal emails obtained by journalists show how it collaborated with spies, funded propaganda efforts, and buil… [+27491 chars]	https://vsquare.org/russian-foundation-aimed-at-helping-compatriots-abroad-supports-spies-criminals-and-propagandists/	https://vsquare.org/wp-content/uploads/2025/05/kompot-main-final.jpg	2025-05-23 08:32:12
213	0.1	15	NewsAPI	‘Father of neoliberalism’ dies aged 88	Joseph Nye introduced the term ‘soft power’ in international relations Read Full Article at RT.com	US political scientist Joseph Nye, who co-authored the international relations theory of neoliberalism together with Robert Keohane and coined the term “soft power,” has died at the age of 88, accord… [+1922 chars]	https://www.rt.com/news/617036-nye-us-neoliberalism-dies/	https://mf.b37mrtl.ru/files/2025.05/article/681cbcc920302733e26fe2c8.jpg	2025-05-08 16:27:58
214	0.1	15	NewsAPI	Donald Trump’s first 100 days have badly damaged trust in America both economically and as an ally	The first 100 days of Trump 2.0 have undermined confidence in the US and the international institutions it supports.	As in life, trust matters in international politics. Vital for cooperation and reciprocation, trusting someone nevertheless leaves one vulnerable should they break faith and pursue self-serving goals… [+6769 chars]	https://theconversation.com/donald-trumps-first-100-days-have-badly-damaged-trust-in-america-both-economically-and-as-an-ally-255150	https://images.theconversation.com/files/664694/original/file-20250429-56-ivgriu.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C4000%2C2000&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-29 20:11:03
215	0.1	15	NewsAPI	What or where is the Indo-Pacific? How a foreign policy pivot redefined the global map	The term can be traced back to the 1920s, but it only began to gain currency in the late 20th and early 21st centuries.	Is the Indo-Pacific concept about international dialogue ... or just containing China? Tetra images/Getty Images\r\nOpen a book of maps and look for the “Indo-Pacific” region – it likely won’t be there… [+6220 chars]	https://theconversation.com/what-or-where-is-the-indo-pacific-how-a-foreign-policy-pivot-redefined-the-global-map-256406	https://images.theconversation.com/files/667428/original/file-20250512-56-yt8tin.jpg?ixlib=rb-4.1.0&rect=0%2C427%2C5119%2C2559&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-13 12:31:01
216	0.1	15	NewsAPI	Joseph Nye Was the Champion of a World That No Longer Exists	The distinguished scholar, who coined “soft power,” shaped five decades of U.S. foreign policy.	It is poignant yet perhaps fitting to mourn Joseph Nye, the distinguished international relations scholar, just as his lifes work championing U.S. leadership and liberal internationalism has run agro… [+11154 chars]	http://foreignpolicy.com/2025/05/09/joseph-nye-death-us-foreign-policy-soft-power/	https://foreignpolicy.com/wp-content/uploads/2025/05/1-joseph-nye-soft-power-2RP3X9X.jpg?w=1000	2025-05-09 17:08:46
217	0.1	15	NewsAPI	The Coming Jewish\nCivil War Over\nDonald Trump	Following the Hamas October 7, 2023, terrorist attack on Israel, in which that group murdered approximately 1,200 people and took 251 more hostage, Israel began a military campaign of “total victory” against the group—a terrorist organization it has previousl…	Lately, AIPAC has also directly entered the money fray, after decades of pretense otherwise, with its own political action committee: one that specializes in raising money from wealthy Republicans an… [+3506 chars]	https://newrepublic.com/article/194674/trump-antisemitism-universities-jewish-civil-war	https://images.newrepublic.com/e5bd4ce31cb8336c2b2cf0c9bbb17f4218ef5576.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-08 10:00:00
218	0.1	15	NewsAPI	Protests In Turkey, 'Global Statesman' Abroad: Erdogan's 'Parallel Universes'	Turkey&#039;s President Tayyip Erdogan has probably never held more global sway: he will host the first direct RussiaUkraine peace talks in three years on Thursday,	Istanbul: Turkey's President Tayyip Erdogan has probably never held more global sway: he will host the first direct Russia-Ukraine peace talks in three years on Thursday, days after his country's mil… [+6396 chars]	https://www.ndtv.com/world-news/recep-tayyip-erdogan-russia-ukraine-talks-protests-in-turkey-global-statesman-abroad-erdogans-parallel-universes-8413032	https://c.ndtvimg.com/2024-09/ubvvhg3o_tayyip-erdogan_625x300_08_September_24.jpeg?im=FeatureCrop,algorithm=dnn,width=1200,height=738	2025-05-14 13:05:12
219	0.1	15	NewsDATA	Vatican Labels Armenia Anti-Christian State - Fuad Akhundov Details	(MENAFN - Trend News Agency) BAKU, Azerbaijan, May 24.? Media outlets inArmenia and Italy continue to react to the international conferencetitled "Christianity in Azerbaijan: History and ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109589753/Vatican-Labels-Armenia-Anti-Christian-State-Fuad-Akhundov-Details	https://menafn.com/updates/pr/2025-05/24/TNA_be1b3image_story.jpg	2025-05-24 03:05:18
220	0	15	NewsAPI	‘Burst balloon’: How Pahalgam attack shattered Modi’s Kashmir narrative	Since 2019, Modi government has argued Kashmir was returning to 'normalcy'. The attack exposed holes in its approach.	New Delhi, India Addressing a rally of supporters in September 2024, Indian Prime Minister Narendra Modi confidently asserted that his Hindu majoritarian Bharatiya Janata Party (BJP) would create a n… [+11096 chars]	https://www.aljazeera.com/news/2025/4/28/burst-balloon-how-pahalgam-attack-shattered-modis-kashmir-narrative	https://www.aljazeera.com/wp-content/uploads/2025/04/2025-04-27T065209Z_591593559_RC256EAMI4NX_RTRMADP_3_INDIA-KASHMIR-ATTACK-1745805610.jpg?resize=1920%2C1440	2025-04-28 03:58:31
221	0	15	NewsAPI	Can Ramaphosa charm offensive help fix South Africa’s ties with Trump’s US?	South African leader keeps calm in the face of an 'ambush' by Donald Trump about false 'white genocide' claims.	Johannesburg, South Africa When the millionaire mining magnate-turned-president of South Africa landed in Washington to meet the billionaire real estate tycoon-turned-president of the United States, … [+11829 chars]	https://www.aljazeera.com/features/2025/5/21/can-ramaphosa-charm-offensive-help-fix-south-africas-ties-with-trumps-us	https://www.aljazeera.com/wp-content/uploads/2025/05/2025-05-21T162153Z_1858847121_RC2GMEARU27F_RTRMADP_3_USA-SAFRICA-1747844657.jpg?resize=1920%2C1440	2025-05-21 20:45:53
222	0	15	NewsAPI	‘No guardrails’: How India-Pakistan combat obliterated old red lines	From missiles targeting broad swaths of territory to water as a weapon, the threshold for the next war has been lowered.	New Delhi, India  Guns have fallen silent for now along the tense India-Pakistan frontier, after a ceasefire that appears to have held for three nights.\r\nOn May 7, India launched predawn attacks on w… [+12664 chars]	https://www.aljazeera.com/news/2025/5/13/no-guardrails-how-india-pakistan-combat-obliterated-old-red-lines	https://www.aljazeera.com/wp-content/uploads/2025/04/AP25044777628131-11-1745390343.jpg?resize=1200%2C630	2025-05-13 07:08:49
223	0	15	NewsAPI	Asean urged to weigh risks of siding with US over China in tariff war	HONG KONG &mdash; Southeast Asian countries risk isolation by China and stalled growth prospects if they align too closely with the United States in the trade war, a well-known Chinese political scientist has warned.	HONG KONG — Southeast Asian countries risk isolation by China and stalled growth prospects if they align too closely with the United States in the trade war, a well-known Chinese political scientist … [+4875 chars]	https://www.bangkokpost.com/business/general/3013840/asean-urged-to-weigh-risks-of-siding-with-us-over-china-in-tariff-war	https://static.bangkokpost.com/media/content/20250429/c1_3013840_700.jpg	2025-04-29 05:20:00
224	0	15	NewsAPI	Will India And Pakistan Go To War?	There isa growing risk that India and Pakistan go to war and that there is no global policeman - like the US was - to pull them apart.	TOPSHOT - Indian Air Force recruits perform a drill during the presentation of the Indian ... More President's Standards and Colours, by Indian President Ram Nath Kovind at Borjhar Air Force Station … [+4940 chars]	https://www.forbes.com/sites/mikeosullivan/2025/05/09/will-india-and-pakistan-go-to-war/	https://imageio.forbes.com/specials-images/imageserve/681e708c340f3417d592ae09/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-09 21:17:52
225	0	15	NewsAPI	Kashmir Attack Unites Political Foes In India, Pakistan	India and Pakistan are exchanging fire over their de-facto border since the Kashmir attack, but in New Delhi and Islamabad political foes are coming together and looking to score points.	India and Pakistan are exchanging fire over their de-facto border since the Kashmir attack, but in New Delhi and Islamabad political foes are coming together and looking to score points.\r\nOn April 22… [+4278 chars]	https://www.ibtimes.com/kashmir-attack-unites-political-foes-india-pakistan-3771747	https://d.ibtimes.com/en/full/4597413/indian-citizen-returns-pakistan-through-wagah-border-post.jpg	2025-04-29 06:27:21
226	0	15	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
227	0	15	NewsAPI	Tax Canadian movies? Why culture has always been at the centre of trade wars	The recent U.S. announcement to tax and ban foreign films may seem out of place in trade talks. But culture has long been a key part of North American trade relations.	The United States government recently announced a plan to leverage a 100 per cent tariff on “foreign” films. President Donald Trump explained it was because he wanted to protect the U.S. film industr… [+7161 chars]	https://theconversation.com/tax-canadian-movies-why-culture-has-always-been-at-the-centre-of-trade-wars-256022	https://images.theconversation.com/files/667591/original/file-20250513-56-hzglgj.jpg?ixlib=rb-4.1.0&rect=0%2C137%2C2206%2C1103&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-13 14:43:36
228	0	15	NewsAPI	Asean urged to weigh risks of siding with US over China in tariff war	The US is only interested in the Asean market, while China is better placed to help bloc realise its goals, Zheng Yongnian tells the Post Read full story	South-East Asian countries risk isolation by China and stalled growth prospects if they align too closely with the US in the trade war, a well-known Chinese political scientist has warned.\r\nZheng Yon… [+5243 chars]	https://www.thestar.com.my/aseanplus/aseanplus-news/2025/04/28/asean-urged-to-weigh-risks-of-siding-with-us-over-china-in-tariff-war	https://apicms.thestar.com.my/uploads/images/2025/04/29/3289596.jpg	2025-04-29 09:55:00
229	0	15	NewsAPI	Tensions Over Kashmir and a Warming Planet Have Placed the Indus Waters Treaty on Life Support	More than 300 million people rely on the Indus River Basin for their survival. The treaty governing its use is falling apart.	Conor here: The following discusses how climate change is making the thorny Kashmir issue worse.\r\nBy Fazlul Haq, a research scientist at The Ohio State University with a focus on the human-environmen… [+9991 chars]	https://www.nakedcapitalism.com/2025/04/tensions-over-kashmir-and-a-warming-planet-have-placed-the-indus-waters-treaty-on-life-support.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/04/Screenshot-2025-04-27-at-6.26.34 PM-812x1024.png	2025-04-28 08:00:30
230	0	15	NewsAPI	The risks of recognizing Russia's annexation of Crimea	The United States has reportedly called on Ukraine to accept Russian control of Crimea as part of a peace agreement. However, Ukraine says doing so would violate the constitution.	The United States has reportedly sent its European allies a confidential paper with proposals for a ceasefire to end Russia's war against Ukraine. One of the key demands is apparently the recognition… [+5590 chars]	https://www.dw.com/en/the-risks-of-recognizing-russias-annexation-of-crimea/a-72355406	https://static.dw.com/image/72342099_6.jpg	2025-04-25 15:59:00
231	0	15	NewsAPI	Why Trump's first 100 days could never stack up to FDR's	President Donald Trump’s first 100 days back in office falls short of FDR and Lyndon Johnson's early days as he lacks a massive Republican majority in Congress.	By the standards of his predecessors, President Donald Trumps first 100 days back in office falls far short in terms of lasting achievements and his overall popularity, for that matter. The phenomeno… [+6181 chars]	https://www.msnbc.com/opinion/msnbc-opinion/trump-congress-republicans-mike-johnson-100-days-rcna203308	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2025-04/250428-donald-trump-Franklin-D-Roosevelt-ew-11154a-59e2ad.jpg	2025-04-29 16:57:28
232	0	15	NewsAPI	Caution surrounds planned DRC-Rwanda peace agreement	Kinshasa and Kigali say they want to present a plan to end the ongoing crisis by May 2. But past ceasefires have often been broken, and analysts say the US-brokered MoU is driven by self-interest from Washington.	On April 25, Foreign Ministers Thérèse Kayikwamba Wagner (DRC) and Olivier Nduhungirehe (Rwanda) signed a Memorandum of Understanding (MoU) in Washington in the presence of US Secretary of State Marc… [+6081 chars]	https://www.dw.com/en/caution-surrounds-planned-drc-rwanda-peace-agreement/a-72395252	https://static.dw.com/image/72372101_6.jpg	2025-04-30 14:19:00
233	0.073	16	NewsAPI	Designing a new way to optimize complex coordinated systems	MIT LIDS researchers have developed a new way of approaching complex problems such as coordinating complicated interactive systems, using simple diagrams as a tool to reveal better approaches to software optimization in deep learning models.	Coordinating complicated interactive systems, whether its the different modes of transportation in a city or the various components that must work together to make an effective and efficient robot, i… [+9042 chars]	https://news.mit.edu/2025/designing-new-way-optimize-complex-coordinated-systems-0424	https://news.mit.edu/sites/default/files/images/202504/deep-learning-diagram.jpg	2025-04-24 19:00:00
234	0	16	NewsAPI	What Happens When Teachers Are Replaced With AI? This School Is Finding Out	Alpha School in Brownsville, Texas, promises to deliver a full day's worth of instruction in just two hours with AI tutors. So far, the results are startling.	The 8:15 a.m. scene in front of the school that sits on a dusty, sun-soaked residential street in Brownsville, Texas, just across the border with Mexico, looks much like any other elementary or middl… [+20799 chars]	https://www.newsweek.com/alpha-school-brownsville-ai-expanding-2063669	https://d.newsweek.com/en/full/2636344/alpha-mainer.png	2025-05-01 10:00:02
235	0	16	NewsAPI	Why agency and cognition are fundamentally not computational	Article URL: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full\nComments URL: https://news.ycombinator.com/item?id=43990107\nPoints: 4\n# Comments: 0	“To live is to know.”\r\n(Maturana, 1988)\r\n“Between the stimulus and the response, there is a space. And in that space lies our freedom and power to choose our responses.”\r\n(Frankl, 1946, 2020)\r\n“Volun… [+166123 chars]	https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full	https://images-provider.frontiersin.org/api/ipx/w=1200&f=png/https://www.frontiersin.org/files/Articles/1362658/fpsyg-15-1362658-HTML/image_m/fpsyg-15-1362658-g001.jpg	2025-05-14 23:04:23
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
211	1	1
65	2	2
\.


--
-- Data for Name: hidden_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_questions (question_id, id, user_id) FROM stdin;
5	1	2
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
1	1	How can we better integrate local ecological knowledge into climate change adaptation strategies?		0
2	1	What are the most cost-effective nature-based solutions for carbon sequestration and ecosystem resilience?	effective nature, ecosystem resilience, carbon sequestration, based solutions, cost	1
3	1	How does climate change exacerbate existing environmental injustices, and what mitigation strategies can address these disparities?	mitigation strategies, disparities, address	2
4	2	How can we guarantee AI system robustness against adversarial inputs and data drift?	data drift, adversarial inputs	0
5	2	What formal methods can ensure AI code reliability and prevent unintended consequences?	prevent unintended consequences, formal methods	1
6	2	How can AI architecture optimize compute efficiency and minimize environmental impact?	minimize environmental impact	2
7	3	How can physicians better collaborate with public health to address social determinants of health?	physicians better collaborate, address social determinants, public health, health	0
8	3	What public health interventions are most effective in preventing chronic diseases seen daily in practice?	public health interventions, practice, effective	1
9	3	How can data analytics improve public health policies impacting patient care and resource allocation?	resource allocation	2
10	4	How can alternative data sources improve our risk models' predictive power?	risk models, predictive power	0
11	4	Given rising inflation, what adjustments should we make to portfolio allocations?	given rising inflation, portfolio allocations, make, adjustments	1
12	4	What's the best strategy to hedge against increasing market volatility?	increasing market volatility, best strategy, hedge	2
13	5	How do domestic political institutions shape a country's foreign policy decisions?	foreign policy decisions, country	0
14	5	To what extent does international law actually constrain state behavior, and why?	extent	1
15	5	How effective are international organizations in resolving global collective action problems?	international organizations, effective	2
16	2	How can we formally verify the robustness and safety of increasingly complex AI systems before deployment?	formally verify, safety, robustness, deployment	1
\.


--
-- Data for Name: refresh; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh (question_id, id, user_id) FROM stdin;
16	1	2
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, title, role, images) FROM stdin;
1	Climate Change	Environmental Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195512Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9a2d916d8e089b0f57ab9d8021e0e47a54552fd6b6fd9891e78b4a09a7ec9512,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195514Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=556060eb28852dd3e20975592484b24b628852e63b783a01220176b2ca0c5d8a,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195514Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=2ba9005508369f9329fb3fdc3f104c92668fe0f9d80b23e8cb3dc0e7c774db59}
2	Artificial Intelligence	Computer Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195524Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=06a4207cf40095bf57007892e50ea349d10d4885c1ba325e37a59efebbe04e0a,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195525Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=682f8684f278e6280dd4b91a2f55702d0e3f59846d2b1d933e5c612b47f447e0,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195526Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=88a9477ec6cf90fa35fb98c01c16c059e556e0edfcbf1bb407655586bf3d32d8}
3	Public Health	Physician	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195534Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f6c7ef4b94239aca675a5e2b4c7fd3e9bdb5bbd37590db05ff96c0d444bed7ce,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195535Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c66c0ca93205ab72dd9c546a10c93a45c432716f5a84b908327158e5e041d72e,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195536Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=8ed6b2665f7c993b6df12b01d3a1403310313e4d323e345eff66b44f3cf27689}
4	Financial Markets	Financial Analyst	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195546Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9ec5964f9955a29a4c38995432524a48dd547033f1d500fdc01e1d80587ccfce,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195547Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=213d31ac15197d66934bcd19078d0e44a4d1c18ed2279ea6b49a9db9621a20f9,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195548Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5925b5641ea8b76d90d9a5662e71c3052c561ddad72a5233aaff11dd21e15e9a}
5	International Relations	Political Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195556Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3b7ecd35eca97decb09b465e620071361cd5cd9788161a704fa1975af7592c4e,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195557Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5de64ed9830054e1a319603283d237374a8aafa272d98222699b2864179256fc,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250524%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250524T195558Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f714d9334c77dca972bcface6d68ea2d05f4a0e05b8b8a94ff69fbeb3b09b183}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, created_at, is_active) FROM stdin;
1	will	wfotso21@gmail.com	scrypt:32768:8:1$OnLBHdN4LXQTeQfc$ead440361432e96be939f1cb82590cc0570434d13b2ef653645bbf9ad3b51208ad60132018be9addc0f4468b411337eb3d160317215545fc6a862c5aa3e680b4	2025-05-24 19:49:45.911432	t
2	freecs	williamarnaud.fotso@g.austincc.edu	scrypt:32768:8:1$VvvYmCYmAV6cUHXG$305665d7a95e5dc29324e68be15d546523547e8cdde98faa0c6238426e452c87f0333fdec2427922c23d30bc4196682699a14bd4f4c6b2f399443e607a2ba404	2025-05-25 03:06:26.416899	t
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videos (id, question_id, youtube_id, description, thumbnail) FROM stdin;
1	1	yy3VK6OYBbU	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/yy3VK6OYBbU/hqdefault.jpg
2	1	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
3	1	RoIpCJwX7-M	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/RoIpCJwX7-M/hqdefault.jpg
4	1	N6t6QHQtdVw	Climate | How To Keep The Environment Safe? | Global Warming | Climate Change | What Causes Global Warming?	https://i.ytimg.com/vi/N6t6QHQtdVw/hqdefault.jpg
5	1	QLteLZNXmyI	034 - Global Climate Change In this video Paul Andersen explains how the climate on the earth is affected by the amount of solar ...	https://i.ytimg.com/vi/QLteLZNXmyI/hqdefault.jpg
6	2	GC54Y8zXXl4	Friday June 4, 2021 3:00 to 4:00 PM (eastern) This webinar will review the current science on forest carbon sequestration, ...	https://i.ytimg.com/vi/GC54Y8zXXl4/hqdefault.jpg
7	2	iGTmKOG8yQo	A Blueprint for Developing Nature-based Solutions for Climate Mitigation original graph from: Beyond Carbon Credits: A Blueprint ...	https://i.ytimg.com/vi/iGTmKOG8yQo/hqdefault.jpg
8	2	CSH63qgpGoY	Natural ecosystems are the best technology we have to help cool the planet, but doing so effectively requires an intricate ...	https://i.ytimg.com/vi/CSH63qgpGoY/hqdefault.jpg
9	2	CdeOQi1mhsc	How do we build coastal resilience so we can be more prepared in teh face of climate change? #shorts #shortsvideos ...	https://i.ytimg.com/vi/CdeOQi1mhsc/hqdefault.jpg
10	3	Y1yBO6DL1dI	Resilient Cities Webinar Series 14/15, Second Webinar: "Integrated climate action: Linking adaptation and mitigation"	https://i.ytimg.com/vi/Y1yBO6DL1dI/hqdefault.jpg
11	3	ZYBFm1XXFNQ	Celebrating the launch of Environmental Research: Energy with this session from Emily Grubert, Editor-in-Chief.	https://i.ytimg.com/vi/ZYBFm1XXFNQ/hqdefault.jpg
12	3	r-MnGwX55SM	This video explains what is the meaning of term mitigation and adaptation pdf of this video ...	https://i.ytimg.com/vi/r-MnGwX55SM/hqdefault.jpg
13	3	G4H1N_yXBiA	What causes climate change (also known as global warming)? And what are the effects of climate change? Learn the human ...	https://i.ytimg.com/vi/G4H1N_yXBiA/hqdefault.jpg
14	4	m5pAOlkm05I	In this video, UCL Professor David Barber answers the questions, "What is data drift?" David Barber is a Professor of Machine ...	https://i.ytimg.com/vi/m5pAOlkm05I/hqdefault.jpg
15	4	TpMIssRdhco	Learn more about watsonx: https://ibm.biz/BdvxDJ Generative Adversarial Networks (GANs) pit two different deep learning models ...	https://i.ytimg.com/vi/TpMIssRdhco/hqdefault.jpg
16	4	QJTRNxUxmuc	What is Model Drift in Machine Learning? What is Concept Drift? What is Data Drift? Why is Model Monitoring Required?	https://i.ytimg.com/vi/QJTRNxUxmuc/hqdefault.jpg
17	4	b9KonUbeosU	Find out more and enroll in the Deep Learning Fundamentals course: https://deeplizard.com/lesson/dla1zrlida ...	https://i.ytimg.com/vi/b9KonUbeosU/hqdefault.jpg
18	4	Mr6b1MdRqqM	Find out more and enroll in the Deep Learning Fundamentals course: https://deeplizard.com/lesson/dla1zrlida ...	https://i.ytimg.com/vi/Mr6b1MdRqqM/hqdefault.jpg
19	5	NpGFFewJl5E	Anthony discusses popular AI apocalypse scenarios and why they're wrong. Find the full video here!	https://i.ytimg.com/vi/NpGFFewJl5E/hqdefault.jpg
20	5	QrRPiG8xvmo	This video is based on a set of questions I asked an AI system and the answers are provided using a Text to Speech AI system.	https://i.ytimg.com/vi/QrRPiG8xvmo/hqdefault.jpg
21	5	V2b5ScHpmKo	And exploration of the The Unintended Consequences of Artificial Intelligence. My Patreon Page: ...	https://i.ytimg.com/vi/V2b5ScHpmKo/hqdefault.jpg
22	5	keGi1LTMEAo	The Unintended Consequences of AI" refers to the unexpected and potentially negative outcomes that can result from the use and ...	https://i.ytimg.com/vi/keGi1LTMEAo/hqdefault.jpg
23	5	qe9QSCF-d88	Yoshua Bengio — the world's most-cited computer scientist and a "godfather" of artificial intelligence — is deadly concerned about ...	https://i.ytimg.com/vi/qe9QSCF-d88/hqdefault.jpg
24	6	8efHyRAbC7Q	What's the environmental impact of AI? Editor's Note: Google, Microsoft, Amazon, and Meta are all financial supporters of NPR.	https://i.ytimg.com/vi/8efHyRAbC7Q/hqdefault.jpg
25	6	9aBNIekp4qY	Companies and the academic community are rushing to take advantage of big, recent advances in artificial intelligence. In many ...	https://i.ytimg.com/vi/9aBNIekp4qY/hqdefault.jpg
26	6	gr5CG-DZz3w	Isha Gollapudi explores energy usage in computing and sustainability of manufacturing Information and Communications ...	https://i.ytimg.com/vi/gr5CG-DZz3w/hqdefault.jpg
27	6	qe9QSCF-d88	Yoshua Bengio — the world's most-cited computer scientist and a "godfather" of artificial intelligence — is deadly concerned about ...	https://i.ytimg.com/vi/qe9QSCF-d88/hqdefault.jpg
28	6	lv4etQ3xZpY	Does Compute | Environmental Impact of AI Priya Donti Massachusetts Institute of Technology Stephanie Stricklen GeekWire ...	https://i.ytimg.com/vi/lv4etQ3xZpY/hqdefault.jpg
29	7	utBlfjihvAs	The conditions in which people live, work and play in are called "social determinants of health," and they can have a profound ...	https://i.ytimg.com/vi/utBlfjihvAs/hqdefault.jpg
30	7	8PH4JYfF4Ns	The Social Determinants of Health are the conditions in which people are born, grow, live and age. They have a large influence ...	https://i.ytimg.com/vi/8PH4JYfF4Ns/hqdefault.jpg
31	7	FVTn33ralPU	The social determinants of health represent aspects of people's social identity, their social environment and their social position ...	https://i.ytimg.com/vi/FVTn33ralPU/hqdefault.jpg
32	7	S-10QrpOMGo	Social determinants of health are conditions in the environment that affect a person's health outcomes and overall quality of life.	https://i.ytimg.com/vi/S-10QrpOMGo/hqdefault.jpg
33	7	NUr9KDSpe9I	Healthcare #SocialDeterminantsOfHealth #Health Many health experts agree that medical services have a limited impact on a ...	https://i.ytimg.com/vi/NUr9KDSpe9I/hqdefault.jpg
34	8	Hh-y2QuaLJ8	Why is public health so important to take into account when dealing with the field of medicine? While these schisms may seem ...	https://i.ytimg.com/vi/Hh-y2QuaLJ8/hqdefault.jpg
35	8	-dmJSLNgjxo	Public health problems are diverse and include infectious diseases, chronic diseases, emergencies, injuries, environmental ...	https://i.ytimg.com/vi/-dmJSLNgjxo/hqdefault.jpg
36	8	oC6QIwexNZQ	The February 2021 Preventive Medicine Grand Rounds features Dr. Michelle Kegler, the Director of Emory Prevention Research ...	https://i.ytimg.com/vi/oC6QIwexNZQ/hqdefault.jpg
37	8	n3uF54KJkkc	The Online Master of Public Health (MPH) with a concentration in Public Health Practice provides students with the skills and ...	https://i.ytimg.com/vi/n3uF54KJkkc/hqdefault.jpg
38	9	t_eWESXTnic	Check out the updated video: https://youtu.be/Y6DPDC_Mf90 In this video we take a look at Public Health – the science and art of ...	https://i.ytimg.com/vi/t_eWESXTnic/hqdefault.jpg
39	9	cUgkWYeRsJk	Health economic evaluation is a tool that allows us to make decisions on the allocation of scarce resources. In this video, we will ...	https://i.ytimg.com/vi/cUgkWYeRsJk/hqdefault.jpg
40	9	zfzDb4Bgfeg	In this video Dr Greg Martin talks about the importance of management and public health. If you are working in the area of public ...	https://i.ytimg.com/vi/zfzDb4Bgfeg/hqdefault.jpg
41	9	9_FN8WIRO7k	Become our PATREON and support this channel so we can support our students with further content and GIVEAWAYS!	https://i.ytimg.com/vi/9_FN8WIRO7k/hqdefault.jpg
42	9	G2quVLcJVBk	In this video we take a brief look at Health Promotion, the process of enabling people to increase control over, and to improve their ...	https://i.ytimg.com/vi/G2quVLcJVBk/hqdefault.jpg
43	10	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
44	10	yBk1oSe8Va4	What is Risk Modeling? | Financial & Investment Risk Analysis Explained Risk modeling is a critical tool in finance, trading, and ...	https://i.ytimg.com/vi/yBk1oSe8Va4/hqdefault.jpg
45	10	LLPwRNgqkDg	Day In The Life - Financial Analyst Are you interested in becoming a financial analyst? The financial services industry is extremely ...	https://i.ytimg.com/vi/LLPwRNgqkDg/hqdefault.jpg
46	11	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
47	11	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
48	11	AzwnoCP4HdE	JOIN THE FAMILY: http://www.patreon.com/investanswers IA MODELS: http://www.investanswers.io FREE INVESTOR ...	https://i.ytimg.com/vi/AzwnoCP4HdE/hqdefault.jpg
49	11	ZqMBx8EJVHg	SilverNews #FederalReserve #SilverPrice Silver prices are rising fast as investors rush to safe haven assets amid growing fears ...	https://i.ytimg.com/vi/ZqMBx8EJVHg/hqdefault.jpg
50	11	ickMKslCKaU	US President Donald Trump's signature tax bill narrowly passed the House and is now heading to the Senate, where groups of ...	https://i.ytimg.com/vi/ickMKslCKaU/hqdefault.jpg
51	12	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
52	12	cgyk2TskuRo	The road to green charts starts with lessons in red. #daytrade #daytraders #humbledtrader #tradingmotivation #daytraderlife ...	https://i.ytimg.com/vi/cgyk2TskuRo/hqdefault.jpg
53	12	c8lGaKPWJYo	Title: Mastering Price Action Trading: The Ultimate Buy or Sell Series with explanation of how to use Flag Trading Strategy ...	https://i.ytimg.com/vi/c8lGaKPWJYo/hqdefault.jpg
54	12	p7HKvqRI_Bo	Download a free audiobook version of "The Richest Man in Babylon" and support TED-Ed's nonprofit mission: ...	https://i.ytimg.com/vi/p7HKvqRI_Bo/hqdefault.jpg
55	12	tg3xsj9fpBQ	This week we have a big week of retail earnings, we will watch Palantir to see if the run continues, plus more updates into the tariff ...	https://i.ytimg.com/vi/tg3xsj9fpBQ/hqdefault.jpg
56	13	PMhIQNkO_Y0	Today Craig finishes up our series on U.S. Government and Politics by talking about both the least and most important aspect of ...	https://i.ytimg.com/vi/PMhIQNkO_Y0/hqdefault.jpg
57	13	aw30lthNz3E	A short video explaining the various sub-fields of political science and the difference between foreign policy and international ...	https://i.ytimg.com/vi/aw30lthNz3E/hqdefault.jpg
58	13	WSTpzOEk0VA	Realism in International Relations believes that states operate in an anarchic international system. This means that there is no ...	https://i.ytimg.com/vi/WSTpzOEk0VA/hqdefault.jpg
59	13	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
60	13	Qul4yexYAOE	Here You Can Find a Detailed Explanation of the Foreign policy in International Relations. Foreign Policy in International ...	https://i.ytimg.com/vi/Qul4yexYAOE/hqdefault.jpg
61	14	NVCDnUZqLzU	Featuring academics from the International Relations Department at the LSE, 'International Relations: an introduction' is a ...	https://i.ytimg.com/vi/NVCDnUZqLzU/hqdefault.jpg
62	14	WSTpzOEk0VA	Realism in International Relations believes that states operate in an anarchic international system. This means that there is no ...	https://i.ytimg.com/vi/WSTpzOEk0VA/hqdefault.jpg
63	14	uZrDuN-c_-o	In this latest episode of Compare Mode, we dive into the differences between International Relations and Political Science with ...	https://i.ytimg.com/vi/uZrDuN-c_-o/hqdefault.jpg
64	14	ilMsCrLwcnQ	Want to know more about this programme? Go to: https://go.uva.nl/3nCjr1a Our International Relations programme provides you ...	https://i.ytimg.com/vi/ilMsCrLwcnQ/hqdefault.jpg
65	15	vyOiY1KNpu4	In this comprehensive video, we delve into the three main theories in International Relations: Realism, Liberalism, and ...	https://i.ytimg.com/vi/vyOiY1KNpu4/hqdefault.jpg
66	15	uZrDuN-c_-o	In this latest episode of Compare Mode, we dive into the differences between International Relations and Political Science with ...	https://i.ytimg.com/vi/uZrDuN-c_-o/hqdefault.jpg
67	15	HQlyWnyVN7I	This video lecture discusses very briefly the meaning of international relations. It specifically addresses the question, "What is ...	https://i.ytimg.com/vi/HQlyWnyVN7I/hqdefault.jpg
68	15	NVCDnUZqLzU	Featuring academics from the International Relations Department at the LSE, 'International Relations: an introduction' is a ...	https://i.ytimg.com/vi/NVCDnUZqLzU/hqdefault.jpg
69	15	WSTpzOEk0VA	Realism in International Relations believes that states operate in an anarchic international system. This means that there is no ...	https://i.ytimg.com/vi/WSTpzOEk0VA/hqdefault.jpg
70	16	JGz0tjT5lfQ	Computer scientist Dr. Roman Yampolskiy says AI could be designed to mimic human ethics.	https://i.ytimg.com/vi/JGz0tjT5lfQ/hqdefault.jpg
71	16	ttIOdAdQaUE	What is Artificial Intelligence? | AI | ChatGPT | AI System | Artificial Intelligence | Robot | Chatbot | Computer | Computer-Controlled ...	https://i.ytimg.com/vi/ttIOdAdQaUE/hqdefault.jpg
72	16	ULKC4NISWE4	Recorded live on twitch, GET IN ### My Stream https://twitch.tv/ThePrimeagen ### Best Way To Support Me Become a backend ...	https://i.ytimg.com/vi/ULKC4NISWE4/hqdefault.jpg
73	16	WJoZK9sMwvw	In this episode of The Breakdown, Tom and Dave are joined by fellow YC General Partner Pete Koomen to lay out a new vision for ...	https://i.ytimg.com/vi/WJoZK9sMwvw/hqdefault.jpg
74	16	qe9QSCF-d88	Yoshua Bengio — the world's most-cited computer scientist and a "godfather" of artificial intelligence — is deadly concerned about ...	https://i.ytimg.com/vi/qe9QSCF-d88/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 235, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 1, true);


--
-- Name: fav_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_videos_id_seq', 1, true);


--
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_id_seq', 1, false);


--
-- Name: hidden_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_articles_id_seq', 2, true);


--
-- Name: hidden_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_questions_id_seq', 1, true);


--
-- Name: hidden_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_videos_id_seq', 1, false);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 16, true);


--
-- Name: refresh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_id_seq', 1, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videos_id_seq', 74, true);


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

