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
    question_id integer NOT NULL,
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
    question_id integer NOT NULL,
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
1	0.417	1	NewsAPI	Guide to Becoming an Environmental Leader and Inspiring the Next Generation of Eco-Defenders	Your community needs leaders who care about the environment. As climate change, pollution, and loss of biodiversity threaten our planet’s health, we can’t afford to wait for governments or corporations to solve these problems. We need individuals who are will…	Your community needs leaders who care about the environment. As climate change, pollution, and loss of biodiversity threaten our planets health, we can’t afford to wait for governments or corporation… [+8645 chars]	https://www.counterpunch.org/2025/04/16/guide-to-becoming-an-environmental-leader-and-inspiring-the-next-generation-of-eco-defenders/	https://www.counterpunch.org/wp-content/uploads/2025/04/Screenshot-2025-04-15-at-5.20.32-PM-943x630.png	2025-04-16 05:54:22
2	0.208	1	NewsAPI	Tensions Over Kashmir and a Warming Planet Have Placed the Indus Waters Treaty on Life Support	More than 300 million people rely on the Indus River Basin for their survival. The treaty governing its use is falling apart.	Conor here: The following discusses how climate change is making the thorny Kashmir issue worse.\r\nBy Fazlul Haq, a research scientist at The Ohio State University with a focus on the human-environmen… [+9991 chars]	https://www.nakedcapitalism.com/2025/04/tensions-over-kashmir-and-a-warming-planet-have-placed-the-indus-waters-treaty-on-life-support.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/04/Screenshot-2025-04-27-at-6.26.34 PM-812x1024.png	2025-04-28 08:00:30
3	0.208	1	NewsAPI	Climate change increases the risk of simultaneous wildfires	Climate change is increasing the risk of wildfires in many regions of the world. This is due partly to specific weather conditions -- known as fire weather -- that facilitate the spread of wildfires. Researchers have found that fire weather seasons are increa…	Climate change is increasing the risk of wildfires in many regions of the world. This is due partly to specific weather conditions -- known as fire weather -- that facilitate the spread of wildfires.… [+4721 chars]	https://www.sciencedaily.com/releases/2025/04/250428221659.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-04-29 02:16:59
4	0.208	1	NewsAPI	Scientific societies say they'll do national climate assessment after Trump dismisses report authors	Two major scientific societies say they will fill the void from the Trump administration’s dismissal of scientists writing a cornerstone federal report on what climate change is doing to the United States	WASHINGTON -- Two major scientific societies on Friday said they will fill the void from the Trump administration's dismissal of scientists writing a cornerstone federal report on what climate change… [+4280 chars]	https://abcnews.go.com/Technology/wireStory/scientific-societies-national-climate-assessment-after-trump-dismisses-121408700	https://i.abcnewsfe.com/a/898f42eb-b49f-43c4-8e22-a38f8ee6f144/wirestory_a76d2e2d3dfec7318b124b05a78d1ee1_16x9.jpg?w=1600	2025-05-02 18:38:31
5	0.208	1	NewsDATA	Climate change causes South Africa to mysteriously rise instead of sink. NASA helps find why	A study has finally revealed why South Africa keeps rising against the ocean instead of sinking and how climate change is also causing this. Read more...	ONLY AVAILABLE IN PAID PLANS	https://www.neowin.net/news/climate-change-causes-south-africa-to-mysteriously-rise-instead-of-sink-nasa-helps-find-why/	https://cdn.neowin.com/news/images/uploaded/2025/05/1746918250_ocean_land_curioso_photography_pexels_story.jpg	2025-05-10 23:14:01
6	0.1	1	NewsAPI	Trump Dismisses Scientists Writing the National Climate Assessment	President Trump has dismissed hundreds of scientists working on the congressionally mandated National Climate Assessment, raising concerns about whether the void will be filled with pseudoscience	CLIMATEWIRE | The Trump administration on Monday dismissed all of the scientists working on the newest version of the National Climate Assessment, a sweeping report that outlines the growing dangers … [+4128 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/29/trump-dismisses-scientists-writing-the-national-climate-assessment-00314494	https://static.scientificamerican.com/dam/m/768e21512db2705d/original/Firefighters_watch_fire.jpg?m=1745935059.9&w=1200	2025-04-29 14:20:00
7	0.1	1	NewsAPI	Katy Perry set for space with all-women crew on Blue Origin rocket	Six women—including pop star Katy Perry—are set to blast off into space as part of an all-women suborbital mission	Maddie MolloyBBC Climate &amp; Science reporter\r\nThe singer will be aboard Blue Origin's New Shepard rocket\r\nPop star Katy Perry and five other women are set to blast into space aboard Jeff Bezos' sp… [+4404 chars]	https://www.bbc.com/news/articles/cvg8e5gq8ljo	https://ichef.bbci.co.uk/news/1024/branded_news/744b/live/52c33bf0-1557-11f0-b1a2-c9cc9d197e2f.jpg	2025-04-14 07:54:39
8	0.1	1	NewsAPI	Global temperatures stuck at near-record highs in April: EU monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3870 chars]	https://phys.org/news/2025-05-global-temperatures-stuck-highs-april.html	https://scx2.b-cdn.net/gfx/news/2025/scientists-are-unanimo.jpg	2025-05-08 17:09:48
9	0.1	1	NewsAPI	Climate Change Weekly # 543 —Current Climate Conditions Aren’t Historically Extreme or Unusual, New Research Shows	Recently, a number of new studies and analyses have been published indicating what readers of CCW have long known: recent climate conditions are not historically unusual. An examination of long-term wildfire trends, plus research comparing past climate condit…	From THE HEARTLAND INSTITUTE\r\nBy H. Sterling Burnett\r\nRecently, a number of new studies and analyses have been published indicating what readers of CCW have long known: recent climate conditions are … [+13694 chars]	https://wattsupwiththat.com/2025/05/09/climate-change-weekly-543-current-climate-conditions-arent-historically-extreme-or-unusual-new-research-shows/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/CCW-543-big-image-3.webp?fit=1024%2C512&ssl=1	2025-05-10 01:00:00
10	0.1	1	NewsAPI	Naomi Klein: ‘What They Want Is Absolutely Everything’	The all-star academic and Shock Doctrine author breaks down the dark logic of Trump and Musk’s path of destruction — and what the world’s richest people really want	Wherever corporate power is running roughshod over culture, the climate, the economy, or our politics, progressives can count on Naomi Klein to provide a clear-eyed assessment of the damage and to of… [+24064 chars]	http://www.rollingstone.com/politics/politics-features/naomi-klein-trump-musk-thiel-oligarchs-climate-science-1235330780/	https://www.rollingstone.com/wp-content/uploads/2025/04/naomi-klein-qa.jpg?w=1600&h=900&crop=1	2025-05-04 13:30:00
11	0.1	1	NewsAPI	CLIMATE ANXIETY: the manufactured hysteria spreading across America’s urban centers and college campuses	A new term called “climate anxiety” has been invented, depicting the hysteria that now plagues a young generation, who have been subconsciously brainwashed to believe that the world is ending because of climate change. A Yale study surveyed individuals across…	A new term called "climate anxiety" has been invented, depicting the hysteria that now plagues a young generation, who have been subconsciously brainwashed to believe that the world is ending because… [+5473 chars]	https://www.naturalnews.com/2025-04-18-climate-anxiety-manufactured-hysteria-spreading-across-america.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/04/Woman-Scared-Fear.jpg	2025-04-18 06:00:00
12	0.1	1	NewsAPI	Climate Change Myths Part 1: Polar Bears, Arctic Ice, and Food Shortages	The era of global warming has ended. The era of global boiling has arrived. Global boiling! The world’s doomed, I’m told. We're in the sixth mass extinction right now. I only wish someone could have warned us about this apart from every scientist for the last…	.\r\nJohn Stossel\r\nClimate zealots tell us the end is near. Its the era of “global BOILING! says the UN Secretary General.\r\nClimate alarmists say the Arctic will soon be ice-free and cities will be und… [+7143 chars]	https://wattsupwiththat.com/2025/04/24/climate-change-myths-part-1-polar-bears-arctic-ice-and-food-shortages/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/04/john-stossel-linnea-luekin.webp?fit=1024%2C512&ssl=1	2025-04-24 13:00:00
13	0.1	1	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #15	A listing of 36 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 6, 2025 thru Sat, April 12, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. …	Posted on 13 April 2025 by BaerbelW, Doug Bostrom, John Hartz\r\nA listing of 36 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 6, 2025 thru … [+7717 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_15.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-04-13 08:05:44
14	0.1	1	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #18	A listing of 23 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 27, 2025 thru Sat, May 3, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. Th…	Posted on 4 May 2025 by BaerbelW, Doug Bostrom, John Hartz\r\nA listing of 23 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 27, 2025 thru Sa… [+5111 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_18.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-04 06:10:27
15	0.1	1	NewsAPI	Global Temperatures Stuck At Near-record Highs In April: EU Monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3432 chars]	https://www.ibtimes.com/global-temperatures-stuck-near-record-highs-april-eu-monitor-3772936	https://d.ibtimes.com/en/full/4599556/scientists-are-unanimous-that-earths-climate-changing-because-human-activity-that-global.jpg	2025-05-08 11:06:11
16	0.1	1	NewsAPI	How Trump 2.0 Overturned Years of Climate Progress in 100 Days	From regulatory rollbacks to coal resurgence, here are some of Trump’s most consequential actions since January 20.	Part of the Series\r\nThis article by Earth.Org is published here as part of the global journalism collaboration Covering Climate Now.\r\nTrumps current approval rating is the lowest for any newly electe… [+18499 chars]	https://earth.org/100-days-of-trump-how-the-us-overturned-years-of-climate-progress/	https://truthout.org/app/uploads/2025/04/2025_0430-trump-1.jpg	2025-04-30 18:46:54
17	0.1	1	NewsAPI	Weekly Climate and Energy News Roundup #641	Quote of the Week: “We can always prove a definite theory wrong. Notice however that we never prove it right.” — Richard Feynman (1964)	Quote of the Week:We can always prove a definite theory wrong. Notice however that we never prove it right. \r\n Richard Feynman (1964)\r\nNumber of the Week: R squared of 0.018.\r\nTHIS WEEK:By Ken Haapal… [+59402 chars]	https://wattsupwiththat.com/2025/05/05/weekly-climate-and-energy-news-roundup-641/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_Scenic_landscape_of_the_badlands_at_petrified_forest-midjourney2.webp?fit=1024%2C512&ssl=1	2025-05-05 09:00:00
18	0	1	NewsAPI	With Mark Carney’s Win, Trump Is Now Sandwiched Between Two Climate Leaders	The success of Canada's Mark Carney and Mexico's Claudia Sheinbaum is a chance to reflect on the best strategy to tackle climate change.	Mark Carney was elected to a full term as Canadas prime minister Monday with a campaign agenda focused squarely on pushing back on attacks from his counterpart to the South, President Donald Trump. I… [+5835 chars]	https://time.com/7281714/mark-carney-canada-mexico-climate-leadership-strategy/	https://api.time.com/wp-content/uploads/2025/04/mark-carney-climate-change.jpg?quality=85&w=1024&h=628&crop=1	2025-04-30 19:32:15
19	0	1	NewsAPI	Trump Cuts Threaten Key NOAA Work to Improve Weather Forecasts and Monitor Toxic Algal Blooms	The Trump administration has proposed gutting NOAA’s cooperative institutes, which study everything from improving lifesaving weather forecasts to monitoring fish stocks	CLIMATEWIRE | Researchers in Oklahoma are hard at work on a new lifesaving weather forecasting system. In Michigan, they’re keeping tabs on toxic algae blooms. In Florida, they’re studying tropical c… [+13561 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/21/trump-cuts-would-cripple-noaas-wide-ranging-science-partnerships-00299647	https://static.scientificamerican.com/dam/m/41ea97ae9a00785e/original/Commander-climbing-on-plane.jpg?m=1745254892.467&w=1200	2025-04-21 17:00:00
20	0	1	NewsAPI	Brian Eno's Theory of Democracy	Organizing and generating variety in politics	[image by Brian Eno, from 77 Million Paintings. Eno says in this dialogue that he doesnt mind people using these images for non-commercial purposes]\r\nThis posts title is a little cheeky. Brian Eno do… [+22374 chars]	https://www.programmablemutter.com/p/brian-enos-theory-of-democracy	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fd3fe93b6-fd36-4c63-88f9-55a434046baf_1200x796.jpeg	2025-05-04 05:12:47
99	0.1	10	NewsDATA	Satellite Data Services Market Size to worth USD 55.17 Bn by 2032, Growing at 21.1% CAGR, Coherent Market Insights Cites Strong Government Support	Burlingame, CA, May 11, 2025 (GLOBE NEWSWIRE) -- Coherent Market Insights published a report, titled, the global satellite data services market size is estimated to grow from USD 14.44 Billion in 2025 and is forecast to reach a value of USD 55.17 Billion by 2032 at a CAGR of 21.1% between 2025 and 2032. Satellite data services involve the collection and analysis of Earth observation data acquired by artificial satellites orbiting the planet. These services provide critical insights into surface conditions, environmental changes, and weather patterns.Request Sample Pages: https://www.coherentmarketinsights.com/insight/request-sample/7599Global Satellite Data Services Market Key TakeawaysAccording to Coherent Market Insights (CMI), the global satellite data services market size is poised to grow at a CAGR of 21.1%, totaling USD 14.44 Bn in 2025 and USD 55.17 Bn by 2032.Based on vertical, agriculture segment is anticipated to account for nearly two-fifths of the global revenue share in 2025.By end user industry, government and military segment is expected to generate market revenue of about USD 6.75 Bn in 2025.Based on service, image data segment will likely account for about half of the global satellite data services market share in 2025.North America is expected to retain its dominance in the global industry, generating revenues worth USD 6.44 Bn in 2025. This can be attributed to increasing investments in satellite technologies and strong presence of satellite data service providers.As per Coherent Market Insights' latest satellite data services market analysis, Asia Pacific, led by India and China, is poised to exhibit fastest growth during the assessment period.Rising Demand for Satellite Data Services Across Diverse Industries Fueling GrowthA new report by Coherent Market Insights outlines key satellite data services market growth factors. One major growth factor is the increasing demand for satellite data services across various industries.Industries like agriculture, defense, energy, and environmental monitoring heavily rely on satellite data for critical insights and operational optimization. For instance, satellite imagery helps the agriculture sector in precision farming by monitoring crop health as well as soil conditions.In environmental monitoring, satellite imagery helps track changes in earth's surface, such as land use changes and deforestation. Similarly, the defense sector utilizes satellite data for surveillance and strategic planning. Increasing adoption of satellite data services across these key industries is expected to boost the target industry.Read Also: Small Satellite Market Size, Share, Trends & Growth Analysis (2025-2032)High Cost of Satellite Technologies and Regulatory Challenges Limiting GrowthThe future satellite data services market outlook looks promising, considering the estimated CAGR of 21.1%. However, high cost of satellite technologies and regulatory challenges might limit the satellite data services market growth to some extent.Satellite manufacturing, launch, and maintenance demand huge investments. This high cost factor makes it difficult for new companies to enter the data satellite services industry. Similarly, licensing, frequency allocation, strict regulations, and data privacy issues are becoming hurdles for market expansion.Increasing Government Support Creating Growth Avenues for ...Full story available on Benzinga.com	ONLY AVAILABLE IN PAID PLANS	https://www.benzinga.com/pressreleases/25/05/g45336860/satellite-data-services-market-size-to-worth-usd-55-17-bn-by-2032-growing-at-21-1-cagr-coherent-ma	https://ml.globenewswire.com/Resource/Download/3a691dbe-0567-4e1c-9d4f-77517527bebf/image1.png	2025-05-11 06:00:00
21	0.1	2	NewsAPI	Tiny vines could hold the key to a future-proof wine industry	The CSIRO and Wine Australia are trialling fast-growing, mildew-resistant grapevines designed to maintain yield and wine quality in a changing climate.	Australia's wine industry is battling significant annual losses due to powdery and downy mildew and a collaborative effort to find sustainable solutions is underway.\r\nIndustry bodies and research org… [+5229 chars]	https://www.abc.net.au/news/2025-04-12/csiro-breeding-program-mildew-resistant-grape-vines/105167446	https://live-production.wcms.abc-cdn.net.au/318d682a416734962ae8397da5e3d1a7?impolicy=wcms_watermark_news&cropH=2385&cropW=4240&xPos=0&yPos=447&width=862&height=485&imformat=generic	2025-04-11 23:41:31
22	0.1	2	NewsAPI	World's 1st Rice Variety Using 21st Century "Genome Editing" Produced In India	Indian scientists have made history by producing two new climate-smart rice varieties using a 21st century breeding technology called &quot;genome editing&quot;	Summary is AI generated, newsroom reviewed.\r\nIndian scientists have created two climate-smart rice varieties via genome editing, boosting yield by 25% and conserving water. Released by Agriculture Mi… [+8011 chars]	https://www.ndtv.com/india-news/worlds-1st-rice-variety-using-21st-century-genome-editing-produced-in-india-8332848	https://c.ndtvimg.com/2025-05/aml7p504_genome-edited-rice_625x300_05_May_25.jpg?im=FitAndFill,algorithm=dnn,width=1200,height=738	2025-05-05 05:29:37
23	0.1	2	NewsAPI	From fava beans to future foods: Researchers turn to plant-based proteins for a healthier planet	Crops like chickpeas, fava beans, lentils and quinoa could help make Europe's food systems more environmentally friendly and sustainable.	Crops like chickpeas, fava beans, lentils and quinoa could help make Europe's food systems more environmentally friendly and sustainable.\r\nOn Marianne Mulhall's organic dairy farm in southeast Irelan… [+9670 chars]	https://phys.org/news/2025-04-fava-beans-future-foods-based.html	https://scx2.b-cdn.net/gfx/news/hires/2020/2-favabeans.jpg	2025-04-21 16:31:06
24	0.1	2	NewsDATA	ACS Nigeria Celebrates Decade Of Scientific Excellence – Inam	The American Chemical Society (ACS) Nigeria International Chemical Sciences Chapter has marked its 10th anniversary and Annual Symposium with the theme: “Advancing Sustainability through AI-Driven Chemistry.” The event brought together leading scientists, policymakers, and innovators to explore how artificial intelligence is transforming chemistry and driving sustainable development. Chair of ACS Nigeria, Edu J. Inam, reflected...The post ACS Nigeria Celebrates Decade Of Scientific Excellence – Inam appeared first on New Telegraph.	ONLY AVAILABLE IN PAID PLANS	https://newtelegraphng.com/acs-nigeria-celebrates-decade-of-scientific-excellence-inam/	https://i0.wp.com/newtelegraphng.com/wp-content/uploads/2025/05/IMG-20250510-WA0049.jpg?fit=1600%2C1066&ssl=1	2025-05-10 11:42:11
25	0	2	NewsAPI	How to take climate action with your code	There are 60,000+ climate-focused projects on GitHub, explore one this Earth Day!\nThe post How to take climate action with your code appeared first on The GitHub Blog.	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\nClimate change is one of the most pressing issues of this century. We are working with devel… [+2560 chars]	https://github.blog/open-source/social-impact/how-to-take-climate-action-with-your-code/	https://github.blog/wp-content/uploads/2025/03/github_logo_invertocat_dark_3.png?fit=1200%2C630	2025-04-17 21:05:17
26	0	2	NewsAPI	Current Climate: Major Assault On California’s Environmental Rules	In this week's Current Climate, California's ability to set tough environmental rules is under attack; Elon Musk is out of ideas to revive Tesla; domestically sourced lithium-sulfur batteries	Plus: Elon Musk runs out of ideas to save Tesla; cheaper, domestically sourced lithium-sulfur batteries\r\nCurrent Climate brings you the latest news about the business of sustainability every Monday. … [+10833 chars]	https://www.forbes.com/sites/alanohnsman/2025/05/05/current-climate-a-major-assault-on-californias-environmental-rules/	https://imageio.forbes.com/specials-images/imageserve/681541b451ae5311ac7d37e4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 12:45:00
27	0	2	NewsAPI	Researchers are studying how to minimize human impact on public lands	Recreation researchers are studying how to minimize human impact on public lands while maximizing accessibility.	Most people used to think the Crestone Needle, a jagged peak in Colorados Sangre de Cristo range, was unclimbable. Until, that is, Albert Ellingwood and Eleanor Davis reached its summit in 1916. Look… [+18121 chars]	https://undark.org/2025/04/28/keep-wild-places-wild/	https://undark.org/wp-content/uploads/2025/04/GettyImages-95606574_crop.jpg	2025-04-29 19:45:48
28	0	2	NewsAPI	Scientists worry about free speech rights under the Trump administration	Morning Edition's First Amendment series looks at the cost of speaking out or staying silent in the scientific community, amid pressure from colleagues or officials in Washington.	Tara McKay was home on the last night in February when she received an email that made her doubt if only for a moment the worthiness of her career.\r\nIt was a message from a branch of the National Ins… [+8901 chars]	https://www.npr.org/2025/04/14/nx-s1-5349473/trump-free-speech-science-research	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/900x506+0+0/resize/1400/quality/100/format/png/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fe2%2F71%2Fbcb979364e1d871245ac461b8f90%2Ffree-speech-science.png	2025-04-14 08:13:27
29	0	2	NewsAPI	Slither, by Stephen S. Hall, Explores Our Fear and Fascination around Snakes	In a new book called Slither, Stephen S. Hall takes a deep dive into the biology and history of one of the most reviled animals.	Rachel Feltman: For Scientific American’s Science Quickly, I’m Rachel Feltman. \r\nPeople are funny about snakes. I remember being taught the rhyme, “Red touches black, you’re okay, Jack; red touches y… [+14231 chars]	https://www.scientificamerican.com/podcast/episode/slither-by-stephen-s-hall-explores-our-fear-and-fascination-around-snakes/	https://static.scientificamerican.com/dam/m/691c20a9bed4b804/original/SQ-Slither-Episode-Art.png?m=1745351096.48&w=1200	2025-04-23 10:00:00
30	0	2	NewsAPI	What is it like on the climate job market right now?	Laid off workers are facing an uncertain and emotional job search. Here's what experts have to say about where to look — plus resources for those on the hunt.	The vision\r\nThe uncertainty of the situation is taking an emotional toll on our entire community. The job market is shifting so rapidly that it’s an uneasy time whether you’re employed at the moment … [+18255 chars]	https://grist.org/looking-forward/what-is-it-like-on-the-climate-job-market-right-now/	https://grist.org/wp-content/uploads/2025/05/0507_GreenJobs_Social.jpg?quality=75&strip=all	2025-05-07 15:05:48
203	0.073	19	NewsDATA	Pope Leo XIV speaks out against AI: ‘A challenge of human dignity, justice and labour’	New leader of the Catholic Church says AI poses challenge to humankind and dignity of workers	ONLY AVAILABLE IN PAID PLANS	https://www.independent.co.uk/news/world/europe/pope-leo-xiv-ai-challenge-humanity-b2748531.html	https://static.independent.co.uk/2025/05/10/12/28/SEI250669360.jpg?crop=1200%3A800&height=800&trim=0%2C0%2C0%2C0&width=1200	2025-05-10 18:42:04
31	0	2	NewsAPI	Tensions Over Kashmir and a Warming Planet Have Placed the Indus Waters Treaty on Life Support	More than 300 million people rely on the Indus River Basin for their survival. The treaty governing its use is falling apart.	Conor here: The following discusses how climate change is making the thorny Kashmir issue worse.\r\nBy Fazlul Haq, a research scientist at The Ohio State University with a focus on the human-environmen… [+9991 chars]	https://www.nakedcapitalism.com/2025/04/tensions-over-kashmir-and-a-warming-planet-have-placed-the-indus-waters-treaty-on-life-support.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/04/Screenshot-2025-04-27-at-6.26.34 PM-812x1024.png	2025-04-28 08:00:30
32	0	2	NewsAPI	Guide to Becoming an Environmental Leader and Inspiring the Next Generation of Eco-Defenders	Your community needs leaders who care about the environment. As climate change, pollution, and loss of biodiversity threaten our planet’s health, we can’t afford to wait for governments or corporations to solve these problems. We need individuals who are will…	Your community needs leaders who care about the environment. As climate change, pollution, and loss of biodiversity threaten our planets health, we can’t afford to wait for governments or corporation… [+8645 chars]	https://www.counterpunch.org/2025/04/16/guide-to-becoming-an-environmental-leader-and-inspiring-the-next-generation-of-eco-defenders/	https://www.counterpunch.org/wp-content/uploads/2025/04/Screenshot-2025-04-15-at-5.20.32-PM-943x630.png	2025-04-16 05:54:22
33	0	2	NewsAPI	Scientists Calculated How Much Meat You Can Sustainably Eat in a Week	When it comes to eating meat, it sometimes seems impossible to strike a balance between doing the right thing for your body, and for the planet.	When it comes to eating meat, it sometimes seems impossible to strike a balance between doing the right thing for your body, and for the planet. Now, a team of environmental scientists has calculated… [+4372 chars]	https://www.sciencealert.com/scientists-calculated-how-much-meat-you-can-sustainably-eat-in-a-week	https://www.sciencealert.com/images/2019-02/processed/eatingextinction_1024.jpg	2025-04-24 02:03:38
34	0	2	NewsAPI	Healy-Rae's peatland forestry plan 'about the dumbest thing we can do', says climate scientist	Michael Healy-Rae, the Forestry Minister, said farmers should be allowed to plant peatlands.	MICHAEL HEALY-RAE wants to allow forestry on peatlands, in a move described by climate scientists as very worrying, not a viable option and dumb.\r\nHealy-Rae, Minister of State for Forestry, told the … [+4127 chars]	https://www.thejournal.ie/michael-healy-rae-forestry-peatland-peat-soils-6697802-May2025/	https://img2.thejournal.ie/article/6697802/river/?height=400&version=6697936	2025-05-07 19:00:01
35	0	2	NewsAPI	How Trump 2.0 Overturned Years of Climate Progress in 100 Days	From regulatory rollbacks to coal resurgence, here are some of Trump’s most consequential actions since January 20.	Part of the Series\r\nThis article by Earth.Org is published here as part of the global journalism collaboration Covering Climate Now.\r\nTrumps current approval rating is the lowest for any newly electe… [+18499 chars]	https://earth.org/100-days-of-trump-how-the-us-overturned-years-of-climate-progress/	https://truthout.org/app/uploads/2025/04/2025_0430-trump-1.jpg	2025-04-30 18:46:54
36	0	2	NewsAPI	Florida Diary: Environmental Protection or Bust	March 23 – Bone Valley, Florida If there’s one thing about ecology everybody should know, it’s the story of shit. If you already do(o), or are squeamish, please skip the next paragraph. Back in pre-industrial and pre-capitalist days, farming was sustainable. …	Strip mining of phosphate, Bone Valley, Florida. Photo: Florida Department of Environmental Protection.\r\nMarch 23 Bone Valley, Florida \r\nIf theres one thing about ecology everybody should know, its t… [+18401 chars]	https://www.counterpunch.org/2025/04/11/florida-diary-environmental-protection-or-bust/	https://www.counterpunch.org/wp-content/uploads/2025/04/dragline-mining-for-phosphate-at-four-corners-lone.jpeg	2025-04-11 05:57:54
37	0	2	NewsAPI	Weekly Climate and Energy News Roundup #641	Quote of the Week: “We can always prove a definite theory wrong. Notice however that we never prove it right.” — Richard Feynman (1964)	Quote of the Week:We can always prove a definite theory wrong. Notice however that we never prove it right. \r\n Richard Feynman (1964)\r\nNumber of the Week: R squared of 0.018.\r\nTHIS WEEK:By Ken Haapal… [+59402 chars]	https://wattsupwiththat.com/2025/05/05/weekly-climate-and-energy-news-roundup-641/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_Scenic_landscape_of_the_badlands_at_petrified_forest-midjourney2.webp?fit=1024%2C512&ssl=1	2025-05-05 09:00:00
38	0	2	NewsAPI	Fossil fuels are still subsidised: G20 could push for the funds to be shifted to cleaner energy	South Africa subsidises fossil fuel companies to the tune of R118 billion (US$6.2 billion) a year. As G20 president, South Africa must push to end these subsidies.	As the G20 presiding nation, South Africa has an opportunity to champion issues relevant to emerging economies. One of these issues is government subsidisation of privately owned fossil fuel corporat… [+6473 chars]	https://theconversation.com/fossil-fuels-are-still-subsidised-g20-could-push-for-the-funds-to-be-shifted-to-cleaner-energy-253869	https://images.theconversation.com/files/663418/original/file-20250423-56-io4n5t.jpg?ixlib=rb-4.1.0&rect=0%2C349%2C4961%2C2480&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-27 07:32:35
39	0	2	NewsAPI	EGU2025 - Picking and chosing sessions to attend on site in Vienna	This year's General Assembly of the European Geosciences Union (EGU) will take place as a fully hybrid conference in both Vienna and online from April 27 to May 2. This year, I'll join the event on site in Vienna for the full week and I've already picked seve…	Posted on 14 April 2025 by BaerbelW\r\nThis year's General Assembly of the European Geosciences Union (EGU) will take place as a fully hybrid conference in both Vienna and online from April 27 to May 2… [+30956 chars]	https://skepticalscience.com/egu25-prolog.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-04-14 04:35:50
40	0	2	NewsAPI	Agricultural greenhouse gas emissions	Farmers apply nitrogen fertilizers to crops to boost yields, feeding more people and livestock. But when there's more fertilizer than the crop can take up, some of the excess can be converted into gaseous forms, including nitrous oxide, a greenhouse gas that …	Farmers apply nitrogen fertilizers to crops to boost yields, feeding more people and livestock. But when there's more fertilizer than the crop can take up, some of the excess can be converted into ga… [+4676 chars]	https://www.sciencedaily.com/releases/2025/04/250421162812.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-04-21 20:28:12
62	0.145	4	NewsAPI	Ask the ethicist: How to create guardrails for the AI age	Will AI devastate humanity or uplift it? Philosopher Christopher DiCarlo's new book examines how we can navigate when AI surpasses human capacity.	Will AI devastate humanity or uplift it? Philosopher Christopher DiCarlo's new book examines how we can navigate when AI surpasses human capacity.\r\nGuest\r\nChristopher DiCarlo, philosopher, educator a… [+171 chars]	https://www.wbur.org/onpoint/2025/04/25/ethics-ai-artificial-intelligence-human	https://wordpress.wbur.org/wp-content/uploads/2025/04/GettyImages-2210697115-1000x667.jpg	2025-04-25 16:41:11
41	0.308	3	NewsAPI	Why Trump Just Axed a Major Climate Program	The dismemberment of the U.S. Global Change Research Program was outlined in Project 2025 as a way to elevate the “benefits” of climate change when fighting regulations in court	CLIMATEWIRE | The Trump administration is dismantling a 35-year-old effort to track global climate change that was used to shape regulations and policies across the government.\r\nFederal employees at … [+5274 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/10/why-trump-axed-the-global-change-research-program-00282731	https://static.scientificamerican.com/dam/m/32cf19a87acdbd34/original/Donald-Trump-Visits-Areas-Affected-By-Hurricane-Helene.jpg?m=1744312287.368&w=1200	2025-04-10 19:30:00
42	0.308	3	NewsAPI	Climate wars are approaching — and they will redefine global conflict	Climate change's profound reshaping of conflict dynamics is already underway. The question facing humanity now is not whether we will confront these pressures, but how we will choose to do so.	Climate change is increasingly recognized\r\n not merely as an environmental crisis but as a threat multiplier, worsening political and economic tensions worldwide. Two factors\r\n — water scarcity and m… [+8828 chars]	https://www.livescience.com/planet-earth/climate-change/the-coming-climate-wars-how-water-scarcity-and-mass-migration-will-redefine-global-conflict-opinion	https://cdn.mos.cms.futurecdn.net/fzKh6aTAcUQHx8n8uSW7UK.jpg	2025-04-30 15:44:08
43	0.208	3	NewsAPI	The false climate solution that just won’t die	On Tuesday, a pair of documentaries landed on Amazon Prime that put forth a rather bold claim: By simply making a few tweaks to how we farm, humanity can reverse climate change and all but eliminate a host of other problems stemming from our modern food syste…	On Tuesday, a pair of documentaries landed on Amazon Prime that put forth a rather bold claim: By simply making a few tweaks to how we farm, humanity can reverse climate change and all but eliminate … [+9082 chars]	https://www.vox.com/future-perfect/409940/regenerative-agriculture-kiss-the-ground-common-ground	https://platform.vox.com/wp-content/uploads/sites/2/2025/04/GettyImages-1348953776.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200	2025-04-22 21:34:19
44	0.208	3	NewsAPI	How to take climate action with your code	There are 60,000+ climate-focused projects on GitHub, explore one this Earth Day!\nThe post How to take climate action with your code appeared first on The GitHub Blog.	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">\nClimate change is one of the most pressing issues of this century. We are working with devel… [+2560 chars]	https://github.blog/open-source/social-impact/how-to-take-climate-action-with-your-code/	https://github.blog/wp-content/uploads/2025/03/github_logo_invertocat_dark_3.png?fit=1200%2C630	2025-04-17 21:05:17
45	0.208	3	NewsAPI	Trump administration dismisses scientists writing quadrennial climate report	The National Climate Assessment, a major publication produced every four years that summarizes the impacts of climate change in the U.S., is scheduled for publication in 2027.	Nearly 400 scientists across the United States were informed Monday afternoon that their services were no longer needed to help write a major report on climate change for the federal government.\r\nThe… [+4531 chars]	https://www.cbsnews.com/news/national-climate-assessment-report-scientists-fired/	https://assets3.cbsnewsstatic.com/hub/i/r/2025/04/30/75a4cdd4-74d0-425f-8ef6-f75a91332dd7/thumbnail/1200x630/637eaaf69205c5e0f5f48c059e8c5415/gettyimages-1197857412.jpg?v=fbebbf93950d87ce40fccd82890f0617	2025-04-30 01:34:33
46	0.208	3	NewsAPI	Climate Myths, Continued	“Climate change will make earth a living hell!” claims popular astrophysicist Neil DeGrasse Tyson. I don’t believe him. The media say, “All Arctic ice will... Read More\nThe post Climate Myths, Continued appeared first on The Daily Signal.	Climate change will make earth a living hell! claims popular astrophysicist Neil DeGrasse Tyson.\r\nI don’t believe him.\r\nThe media say, All Arctic ice will soon melt away! Polar bears are dying off! G… [+4000 chars]	https://www.dailysignal.com/2025/04/27/climate-myths-continued/	https://www.dailysignal.com/wp-content/uploads/2024/05/shareCardDailySignal.png	2025-04-27 14:00:00
47	0.208	3	NewsDATA	Climate change causes South Africa to mysteriously rise instead of sink. NASA helps find why	A study has finally revealed why South Africa keeps rising against the ocean instead of sinking and how climate change is also causing this. Read more...	ONLY AVAILABLE IN PAID PLANS	https://www.neowin.net/news/climate-change-causes-south-africa-to-mysteriously-rise-instead-of-sink-nasa-helps-find-why/	https://cdn.neowin.com/news/images/uploaded/2025/05/1746918250_ocean_land_curioso_photography_pexels_story.jpg	2025-05-10 23:14:01
48	0.208	3	NewsDATA	What Trump’s cuts to federal climate research could mean for Illinois	The Global Change Research Act mandates that the National Climate Assessment be published every four years to inform the public of the ongoing impacts, risks and responses to climate change.	ONLY AVAILABLE IN PAID PLANS	https://qctimes.com/news/state-regional/government-politics/article_c6fa44b9-aaa2-5ca4-a7fd-2c3b5d4257fd.html	https://bloximages.chicago2.vip.townnews.com/qctimes.com/content/tncms/assets/v3/editorial/c/6f/c6fa44b9-aaa2-5ca4-a7fd-2c3b5d4257fd/681e93a8582d0.preview.jpg?crop=1140%2C599%2C0%2C78	2025-05-10 17:00:00
49	0.1	3	NewsAPI	Scientists say NOAA cuts by Trump undermine improvements in hurricane forecasts	The Trump administration is targeting top climate and weather labs for cuts. Insiders worry about the impact on research and NOAA's ability to forecast severe weather like hurricanes and tornadoes.	MIAMI Weather and climate research are among the programs seeing big cuts by the Trump administration. \r\nHundreds of employees at NOAA the National Oceanic and Atmospheric Administration who work at … [+4401 chars]	https://www.npr.org/2025/04/25/nx-s1-5361474/noaa-cuts-hurricane-forecast-improvements-trump	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3900x2194+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F9e%2F96%2Fa366b9ba4a2a958fd8f8c1a55c33%2Fgettyimages-2177097712.jpg	2025-04-25 09:00:00
50	0.1	3	NewsAPI	Scientist sounds alarm after disturbing photo from Arctic expedition resurfaces: 'Feels like they could just sink at any moment'	"Science has a communication problem."	A famous photo from 2019 provides a snapshot of the changing climate and offers a glimpse of the future, scientists say.\r\nWhat's happening?\r\nThe image, featuring a first-person view of eight sled dog… [+2752 chars]	https://www.yahoo.com/news/scientist-sounds-alarm-disturbing-photo-121558211.html	https://s.yimg.com/ny/api/res/1.2/9SxazeP0bYNERRWxTm0fUQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_cool_down_737/4f5dfa89434f47d48c408c3b64f10f5c	2025-04-29 12:15:58
98	0.1	10	NewsDATA	From £1,000 to £10,000: investing with a Stocks and Shares ISA	Zaven Boyrazian explores various investing strategies when aiming for a sustainable 1,000% return within a Stocks and Shares ISA.The post From £1,000 to £10,000: investing with a Stocks and Shares ISA appeared first on The Motley Fool UK.	ONLY AVAILABLE IN PAID PLANS	https://www.fool.co.uk/2025/05/11/from-1000-to-10000-investing-with-a-stocks-and-shares-isa/	https://www.fool.co.uk/wp-content/uploads/2022/05/Carefree.jpg	2025-05-11 06:01:00
51	0.1	3	NewsAPI	Trump Dismisses Scientists Writing the National Climate Assessment	President Trump has dismissed hundreds of scientists working on the congressionally mandated National Climate Assessment, raising concerns about whether the void will be filled with pseudoscience	CLIMATEWIRE | The Trump administration on Monday dismissed all of the scientists working on the newest version of the National Climate Assessment, a sweeping report that outlines the growing dangers … [+4128 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/29/trump-dismisses-scientists-writing-the-national-climate-assessment-00314494	https://static.scientificamerican.com/dam/m/768e21512db2705d/original/Firefighters_watch_fire.jpg?m=1745935059.9&w=1200	2025-04-29 14:20:00
52	0.1	3	NewsAPI	Katy Perry set for space with all-women crew on Blue Origin rocket	Six women—including pop star Katy Perry—are set to blast off into space as part of an all-women suborbital mission	Maddie MolloyBBC Climate &amp; Science reporter\r\nThe singer will be aboard Blue Origin's New Shepard rocket\r\nPop star Katy Perry and five other women are set to blast into space aboard Jeff Bezos' sp… [+4404 chars]	https://www.bbc.com/news/articles/cvg8e5gq8ljo	https://ichef.bbci.co.uk/news/1024/branded_news/744b/live/52c33bf0-1557-11f0-b1a2-c9cc9d197e2f.jpg	2025-04-14 07:54:39
53	0.1	3	NewsAPI	Current Climate: Major Assault On California’s Environmental Rules	In this week's Current Climate, California's ability to set tough environmental rules is under attack; Elon Musk is out of ideas to revive Tesla; domestically sourced lithium-sulfur batteries	Plus: Elon Musk runs out of ideas to save Tesla; cheaper, domestically sourced lithium-sulfur batteries\r\nCurrent Climate brings you the latest news about the business of sustainability every Monday. … [+10833 chars]	https://www.forbes.com/sites/alanohnsman/2025/05/05/current-climate-a-major-assault-on-californias-environmental-rules/	https://imageio.forbes.com/specials-images/imageserve/681541b451ae5311ac7d37e4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 12:45:00
54	0.1	3	NewsAPI	Global temperatures stuck at near-record highs in April: EU monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3870 chars]	https://phys.org/news/2025-05-global-temperatures-stuck-highs-april.html	https://scx2.b-cdn.net/gfx/news/2025/scientists-are-unanimo.jpg	2025-05-08 17:09:48
55	0.1	3	NewsAPI	How Pope Francis became a climate change influencer	The late pope ‘openly and unashamedly’ criticised dominant social and environmental policies.	The Earth, our home, is beginning to look more and more like an immense pile of filth. These arent the words of a radical sociologist or rogue climate scientist. They arent the words of a Conversatio… [+6428 chars]	https://theconversation.com/how-pope-francis-became-a-climate-change-influencer-255086	https://images.theconversation.com/files/663577/original/file-20250423-56-k9acj2.jpg?ixlib=rb-4.1.0&rect=0%2C442%2C5472%2C2736&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-24 21:01:32
56	0.1	3	NewsAPI	CLIMATE ANXIETY: the manufactured hysteria spreading across America’s urban centers and college campuses	A new term called “climate anxiety” has been invented, depicting the hysteria that now plagues a young generation, who have been subconsciously brainwashed to believe that the world is ending because of climate change. A Yale study surveyed individuals across…	A new term called "climate anxiety" has been invented, depicting the hysteria that now plagues a young generation, who have been subconsciously brainwashed to believe that the world is ending because… [+5473 chars]	https://www.naturalnews.com/2025-04-18-climate-anxiety-manufactured-hysteria-spreading-across-america.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/04/Woman-Scared-Fear.jpg	2025-04-18 06:00:00
57	0.1	3	NewsDATA	US will stop tracking the costs of extreme weather fueled by climate change (copy)	The National Oceanic and Atmospheric Administration will no longer track the cost of climate change-fueled weather disasters, including floods, heat waves and wildfires. It is the latest example of changes to the agency and the Trump administration limiting federal government...	ONLY AVAILABLE IN PAID PLANS	https://herald-review.com/article_6df9c11f-7ebd-4420-b249-e4d92371e33c.html	https://bloximages.chicago2.vip.townnews.com/herald-review.com/content/tncms/custom/image/afe84bdc-33fa-11e7-8231-771276f6981b.jpg?resize=600%2C315	2025-05-11 01:48:00
58	0.1	3	NewsDATA	Bay Area Voice: Community science offers a different kind of climate action	From tidepooling to insect surveying to cloud observations, local nature projects can help counter climate anxiety.	ONLY AVAILABLE IN PAID PLANS	https://www.marinij.com/2025/05/10/opinion-community-science-offers-a-different-kind-of-climate-action/	https://www.marinij.com/wp-content/uploads/2025/04/OCR-L-HG-BIRDS-0724-01.jpg?strip=all&w=1400px	2025-05-10 19:54:05
59	0	3	NewsAPI	Why Snow in New Zealand’s Alps Turned an Alarming Shade of Red	Several years ago, snow in New Zealand's Southern Alps turned red, and while many blamed wildfires at the time, new research uncovers the true culprit.	During the Southern Hemisphere’s summer of 20192020, mountains in New Zealand turned red. New research finally explains why.\r\nResearchers have revealed that New Zealand’s Southern Alps turned red aft… [+2657 chars]	https://gizmodo.com/why-snow-in-new-zealands-alps-turned-an-alarming-shade-of-red-2000593615	https://gizmodo.com/app/uploads/2025/04/red-new-zealand-alps.jpg	2025-04-24 13:35:15
60	0	3	NewsAPI	Trump Torched Decades of Science in Just 100 Days—and the Fallout Is Global	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	Across seven decades and a dozen presidencies, Americas scientific prowess was arguably unmatched. At universities and federal agencies alike, researchers in the United States revolutionized weather … [+16614 chars]	https://gizmodo.com/trump-torched-decades-of-science-in-just-100-days-and-the-fallout-is-global-2000595721	https://gizmodo.com/app/uploads/2024/10/wildfire-fire-fighter.jpg	2025-05-04 14:00:29
61	0.218	4	NewsDATA	UNESCO and STJ Lead Workshop on AI's Role in Judicial Ethics and Law	On 9 May 2025, UNESCO, in collaboration with the Superior Court of Justice (STJ) of Brazil, held a significant workshop titled “Artificial Intelligence and the Democratic Rule of Law”. This event, conducted on 8 May, brought together a diverse set of legal professionals, policymakers, and AI ethics experts to address the pressing topic of artificial intelligence within the justice system. The workshop forms part of UNESCO’s global Initiative for Judges, aimed at equipping judicial systems worldwide to navigate digital transformation responsibly and ethically.	ONLY AVAILABLE IN PAID PLANS	https://www.devdiscourse.com/article/technology/3377622-unesco-and-stj-lead-workshop-on-ais-role-in-judicial-ethics-and-law	https://devdiscourse.blob.core.windows.net/devnews/10_05_2025_10_26_13_8452454.jpg	2025-05-09 23:26:13
63	0.073	4	NewsAPI	SoundCloud changes policies to allow AI training on user content | TechCrunch	SoundCloud appears to have quietly changed its terms of use to allow the company to train AI on audio that users upload to its platform.	SoundCloud appears to have quietly changed its terms of use to allow the company to train AI on audio that users upload to its platform. \r\nAs spotted by tech ethicist Ed-Newton Rex, the latest versio… [+2375 chars]	https://techcrunch.com/2025/05/09/soundcloud-changes-policies-to-allow-ai-training-on-user-content/	https://techcrunch.com/wp-content/uploads/2024/05/Black-SoundCloud-Logo-Horizontal-1-1.jpg?w=1080	2025-05-09 17:20:49
64	0.073	4	NewsDATA	Pope Leo XIV speaks out against AI: ‘A challenge of human dignity, justice and labour’	New leader of the Catholic Church says AI poses challenge to humankind and dignity of workers	ONLY AVAILABLE IN PAID PLANS	https://ca.news.yahoo.com/pope-leo-xiv-speaks-against-184204153.html	https://media.zenfs.com/en/the_independent_577/7dea3b905f9fbf6de120a32852a2cfc1	2025-05-10 18:42:04
65	0.073	4	NewsDATA	Pope Leo XIV speaks out against AI: ‘A challenge of human dignity, justice and labour’	New leader of the Catholic Church says AI poses challenge to humankind and dignity of workers	ONLY AVAILABLE IN PAID PLANS	https://www.independent.co.uk/news/world/europe/pope-leo-xiv-ai-challenge-humanity-b2748531.html	https://static.independent.co.uk/2025/05/10/12/28/SEI250669360.jpg?crop=1200%3A800&height=800&trim=0%2C0%2C0%2C0&width=1200	2025-05-10 18:42:04
66	0	4	NewsAPI	‘Make her first time special’: New warning sounded for artificial intelligence	'Chatbot' found ignoring situation involving potential pedophilia, statutory rape	Artificial intelligence is the new web, the new cell phone, the new email, the new laptop, the new tech that is expected to impact lives in a major way, as all of those earlier advances did.\r\nBut it’… [+3756 chars]	https://www.wnd.com/2025/04/make-her-first-time-special-new-warning-sounded-for-artificial-intelligence/	https://www.wnd.com/wp-content/uploads/2024/12/teens-girls-young-wman-women-beautiful-sexy-food-fruit-peaches-eating-unsplash.jpg	2025-04-14 17:46:32
67	0	4	NewsAPI	Everyone Is Cheating Their Way Through College	In only two years, ChatGPT and the surge of AI-generated cheating from college students it has created have unraveled the entire academic project.	Chungin Roy Lee stepped onto Columbia Universitys campus this past fall and, by his own admission, proceeded to use generative artificial intelligence to cheat on nearly every assignment. As a comput… [+31718 chars]	http://nymag.com/intelligencer/article/openai-chatgpt-ai-cheating-education-college-students-school.html	https://pyxis.nymag.com/v1/imgs/bed/906/0c7c764b8c807add6e1a8f638b43ce2029-chat-gpt-college-lede.1x.rsocial.w1200.gif	2025-05-07 09:00:23
68	0	4	NewsDATA	Speech by Governor Barr on artificial intelligence and the labor market	Thank you for the opportunity to speak to you today.1 I [...]The post Speech by Governor Barr on artificial intelligence and the labor market appeared first on THAIFRX.com.	ONLY AVAILABLE IN PAID PLANS	https://www.thaifrx.com/speech-by-governor-barr-on-artificial-intelligence-and-the-labor-market/	https://www.thaifrx.com/wp-content/uploads/2023/04/social-default-image-opengraph-696x365.jpg	2025-05-10 16:15:05
69	0	4	NewsDATA	SoundCloud AI Training Policy Sparks Alarm Over User Data	In the evolving landscape of digital platforms and artificial intelligence, questions surrounding data ownership and user consent are becoming increasingly critical. For many in the crypto and tech space, understanding how centralized entities handle valuable user data is paramount. A recent development at SoundCloud, a popular audio distribution platform, has brought these concerns into sharp [...]	ONLY AVAILABLE IN PAID PLANS	https://zephyrnet.com/soundcloud-ai-training-policy-sparks-alarm-over-user-data/	https://zephyrnet.com/wp-content/uploads/2025/04/zephyrnet-default-img-3-1.jpg-1.jpg	2025-05-09 22:30:41
70	0	4	NewsDATA	SoundCloud AI Training Policy Sparks Alarm Over User Data	In the evolving landscape of digital platforms and artificial intelligence, questions surrounding data ownership and user consent are becoming increasingly critical. For many in the crypto and tech space, understanding how centralized entities handle valuable user data is paramount. A recent development at SoundCloud, a popular audio distribution platform, has brought these concerns into sharp [...]	ONLY AVAILABLE IN PAID PLANS	https://bitcoinworld.co.in/soundcloud-ai-training-policy/	https://bitcoinworld.co.in/wp-content/uploads/SoundCloud-AI-Training-Policy-Sparks-Alarm-Over-User-Data.webp	2025-05-09 22:30:41
71	0	6	NewsDATA	Speech by Governor Barr on artificial intelligence and the labor market	Thank you for the opportunity to speak to you today.1 I [...]The post Speech by Governor Barr on artificial intelligence and the labor market appeared first on THAIFRX.com.	ONLY AVAILABLE IN PAID PLANS	https://www.thaifrx.com/speech-by-governor-barr-on-artificial-intelligence-and-the-labor-market/	https://www.thaifrx.com/wp-content/uploads/2023/04/social-default-image-opengraph-696x365.jpg	2025-05-10 16:15:05
72	0	7	NewsAPI	FDA names scrutiny advocate Dr. Vinay Prasad to lead vaccine division amid calls for transparency	Dr. Vinay Prasad, a prominent critic of pandemic-era vaccine policies, is appointed director of the FDA’s Center for Biologics Evaluation and Research (CBER), replacing Dr. Peter Marks, who resigned amid tensions over vaccine transparency and safety. A vocal …	<ul><li>Dr. Vinay Prasad, a prominent critic of pandemic-era vaccine policies, is appointed director of the FDAs Center for Biologics Evaluation and Research (CBER), replacing Dr. Peter Marks, who re… [+7045 chars]	https://www.naturalnews.com/2025-05-08-fda-names-vinay-prasad-lead-vaccine-division.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Fda-Aged-Badge-Banner-Black-Caption-Corrosion.jpg	2025-05-08 06:00:00
73	0	7	NewsAPI	Trump’s Revenge on Public Health	The attacks on HIV research are just the beginning of unraveling decades of progress.	If the United States learned any lesson from HIV, it should have been that negligence can be a death sentence. In the early 1980s, the virus’s ravages were treated as “something that happens over the… [+14607 chars]	https://www.theatlantic.com/health/archive/2025/04/trump-hiv-public-health-revenge/682410/	https://cdn.theatlantic.com/thumbor/YZWtHny2vg6xPiKu4G64Zosymow=/0x55:2607x1413/1200x625/media/img/mt/2025/04/2025_04_10_AIDS_Trump/original.jpg	2025-04-11 18:46:36
74	0	7	NewsAPI	100 Days, 100 Small Victories	The political wins, works of art, and acts of defiance bringing us relief, joy, and even hope under Trump 2.0.	The first 100 days of Donald Trumps second term feel like theyve dragged on for an eternity, with each days news cycle bringing fresh hell to reckon with. But there is evidence of real political prog… [+43896 chars]	http://www.thecut.com/article/100-small-wins-worth-celebrating-from-trumps-first-100-days.html	https://pyxis.nymag.com/v1/imgs/7ed/97f/36fb7c053c757eda5ef6e72651d2854552-100-days-03.1x.rsocial.w1200.jpg	2025-04-30 17:15:46
75	0.185	8	NewsAPI	RFK Jr. Misleads on Autism Prevalence, Causes	In announcing new autism prevalence data from the Centers for Disease Control and Prevention, Health and Human Services Secretary Robert F. Kennedy Jr. distorted scientific research to argue that there is an “epidemic” of autism that must be due to an "enviro…	Este artículo estará disponible en español en El Tiempo Latino.\r\nIn announcing new autism prevalence data from the Centers for Disease Control and Prevention, Health and Human Services Secretary Robe… [+22856 chars]	https://www.factcheck.org/2025/04/rfk-jr-misleads-on-autism-prevalence-causes/	https://cdn.factcheck.org/UploadedFiles/Kennedy-MMWR-720x307-1.jpg	2025-04-28 19:45:25
76	0.089	8	NewsAPI	Estimation of Incubation Period for Oropouche Virus Disease among Travel-Associated Cases, 2024–2025	Incubation Period for Oropouche Virus Disease	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Oropouche virus disease (O… [+18511 chars]	https://wwwnc.cdc.gov/eid/article/31/7/25-0468_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-05-01 04:00:00
77	0	8	NewsAPI	What Science Says About Food Additives	RFK Jr. has said the U.S. should end the use of synthetic food additives. How would that affect public health?	Yves here. This post usefully goes a bit deeper into the regulatory system for food additives. It should come as no surprise that in the US, it remarkably permissive.\r\nThe article alludes to but does… [+23990 chars]	https://www.nakedcapitalism.com/2025/04/what-science-says-about-food-additives.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/04/00-food-additive.jpg	2025-04-23 13:55:54
78	0	8	NewsAPI	How bad is it? RFK Jr.’s extinction-level threat to science-based federal health policy and public health is here	Five months ago, I called RFK Jr. an "extinction-level" threat to US biomedical science and public health. That extinction is under way.\nThe post How bad is it? RFK Jr.’s extinction-level threat to science-based federal health policy and public health is here…	After learning that, in return for his having suspended his independent Presidential campaign to bend the knee to Donald Trump, Trump had said that he’d appoint longtime antivax activist Robert F. Ke… [+39065 chars]	https://sciencebasedmedicine.org/how-bad-is-it-rfk-jr-s-extinction-level-threat-to-science-based-federal-health-policy-and-public-health-is-here/	https://sciencebasedmedicine.org/wp-content/uploads/2024/11/Extinction.jpeg	2025-04-14 07:00:00
79	0	8	NewsAPI	HHS is weaponizing evidence-based medicine to falsely portray vaccines as unsafe	Last week, HHS announced that all "new vaccines will undergo safety testing in placebo-controlled trials." Sounds good? Not so fast. This is really a deceptive weaponization of evidence-based medicine to undermine confidence in vaccines and eliminate at least…	Having a man who has for the last two decades arguably been America’s most famous and intellectual antivax activist in charge of the Department of Health and Human Services (HHS) has been exhausting.… [+46033 chars]	https://sciencebasedmedicine.org/hhs-is-weaponizing-evidence-based-medicine-to-falsely-portray-vaccines-as-unsafe/	https://sciencebasedmedicine.org/wp-content/uploads/2017/04/EBMupdated.jpg	2025-05-05 07:00:00
80	0	8	NewsAPI	Integrating Genomic Data into Public Health Surveillance for Multidrug-Resistant Organisms, Washington, USA	Integration of genomic and epidemiologic data improved ability to identify additional cases, sensitively classify cases as outbreak or non-outbreak cases, and confirm hypothesized linkages.	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Multidrug resistance threa… [+24087 chars]	https://wwwnc.cdc.gov/eid/article/31/13/24-1227_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-04-24 04:00:00
81	0	8	NewsAPI	Effects of Decentralized Sequencing on National Listeria monocytogenes Genomic Surveillance, Australia, 2016–2023	<em>Listeria monocytogenes</em> Surveillance, Australia	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Listeria monocytogenes is … [+21365 chars]	https://wwwnc.cdc.gov/eid/article/31/13/24-1357_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-05-06 04:00:00
82	0	8	NewsAPI	Trump Just Escalated His War on Coal Miners. Their Unions Are Fighting Back.	The Trump administration’s feckless business-first, workers-last approach is leaving the nation’s coal miners to die—and now their unions are taking him to court.	President Donald Trump unveiled a new barrage of executive orders last week aimed at revitalizing the nations beautiful clean coal industry. But in reality, its already clear that his empty words wil… [+11165 chars]	https://inthesetimes.com/article/trump-silica-rule-coal-miners-union	https://s3.us-east-2.amazonaws.com/itt-images/_1200x630_crop_center-center_82_none/GettyImages-2208639456.jpg?mtime=1744653748	2025-04-14 19:30:00
83	0	8	NewsAPI	100 Days, 100 Small Victories	The political wins, works of art, and acts of defiance bringing us relief, joy, and even hope under Trump 2.0.	The first 100 days of Donald Trumps second term feel like theyve dragged on for an eternity, with each days news cycle bringing fresh hell to reckon with. But there is evidence of real political prog… [+43896 chars]	http://www.thecut.com/article/100-small-wins-worth-celebrating-from-trumps-first-100-days.html	https://pyxis.nymag.com/v1/imgs/7ed/97f/36fb7c053c757eda5ef6e72651d2854552-100-days-03.1x.rsocial.w1200.jpg	2025-04-30 17:15:46
84	0.089	9	NewsAPI	HHS is weaponizing evidence-based medicine to falsely portray vaccines as unsafe	Last week, HHS announced that all "new vaccines will undergo safety testing in placebo-controlled trials." Sounds good? Not so fast. This is really a deceptive weaponization of evidence-based medicine to undermine confidence in vaccines and eliminate at least…	Having a man who has for the last two decades arguably been America’s most famous and intellectual antivax activist in charge of the Department of Health and Human Services (HHS) has been exhausting.… [+46033 chars]	https://sciencebasedmedicine.org/hhs-is-weaponizing-evidence-based-medicine-to-falsely-portray-vaccines-as-unsafe/	https://sciencebasedmedicine.org/wp-content/uploads/2017/04/EBMupdated.jpg	2025-05-05 07:00:00
85	0.089	9	NewsAPI	RFK Jr. Misleads on Autism Prevalence, Causes	In announcing new autism prevalence data from the Centers for Disease Control and Prevention, Health and Human Services Secretary Robert F. Kennedy Jr. distorted scientific research to argue that there is an “epidemic” of autism that must be due to an "enviro…	Este artículo estará disponible en español en El Tiempo Latino.\r\nIn announcing new autism prevalence data from the Centers for Disease Control and Prevention, Health and Human Services Secretary Robe… [+22856 chars]	https://www.factcheck.org/2025/04/rfk-jr-misleads-on-autism-prevalence-causes/	https://cdn.factcheck.org/UploadedFiles/Kennedy-MMWR-720x307-1.jpg	2025-04-28 19:45:25
86	0.089	9	NewsAPI	Shingles vaccine reduces risk of heart disease by 23%, study of one million people finds | CNN	A study of more than one million people found the shingles vaccine may lower the risk of heart disease and stroke for up to eight years after the shots.	Get inspired by a weekly roundup on living well, made simple. Sign up for CNNs Life, But Better newsletter for information and tools designed to improve your well-being.\r\nGetting the shingles vaccine… [+5372 chars]	https://www.cnn.com/2025/05/09/health/shingles-heart-disease-vaccine-shots-wellness	https://media.cnn.com/api/v1/images/stellar/prod/c-gettyimages-1294264405.jpg?c=16x9&q=w_800,c_fill	2025-05-09 12:14:18
87	0.089	9	NewsDATA	Redlining continues to impact breast cancer survival in America	In neighborhoods across America, women face a daunting threat from a federal practice that, although it was outlawed decades ago, continues to negatively impact their health today.	ONLY AVAILABLE IN PAID PLANS	https://www.news-medical.net/news/20250510/Redlining-continues-to-impact-breast-cancer-survival-in-America.aspx	https://d2jx2rerrg6sh3.cloudfront.net/image-handler/picture/2014/7/91618146-620x480.jpg	2025-05-10 17:48:25
88	0	9	NewsAPI	What Science Says About Food Additives	RFK Jr. has said the U.S. should end the use of synthetic food additives. How would that affect public health?	Yves here. This post usefully goes a bit deeper into the regulatory system for food additives. It should come as no surprise that in the US, it remarkably permissive.\r\nThe article alludes to but does… [+23990 chars]	https://www.nakedcapitalism.com/2025/04/what-science-says-about-food-additives.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/04/00-food-additive.jpg	2025-04-23 13:55:54
89	0	9	NewsAPI	Integrating Genomic Data into Public Health Surveillance for Multidrug-Resistant Organisms, Washington, USA	Integration of genomic and epidemiologic data improved ability to identify additional cases, sensitively classify cases as outbreak or non-outbreak cases, and confirm hypothesized linkages.	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Multidrug resistance threa… [+24087 chars]	https://wwwnc.cdc.gov/eid/article/31/13/24-1227_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-04-24 04:00:00
90	0	9	NewsAPI	A deadly E. coli outbreak hit 15 states, but the FDA chose not to publicize it	A foodborne illness linked to lettuce ripped across 15 states last November, sickening dozens of people and killing one. But the federal government chose not to publicize it.	An E. coli outbreak linked to romaine lettuce ripped across 15 states in November, sickening dozens of people, including a 9-year-old boy in Indiana who nearly died of kidney failure and a 57-year-ol… [+13860 chars]	https://www.nbcnews.com/news/us-news/ecoli-bacteria-lettuce-outbreak-rcna200236	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2025-04/250426-e-coli-outbreak-lr-579595.jpg	2025-04-17 09:00:00
91	0	9	NewsAPI	Effects of Decentralized Sequencing on National Listeria monocytogenes Genomic Surveillance, Australia, 2016–2023	<em>Listeria monocytogenes</em> Surveillance, Australia	Disclaimer: Early release articles are not considered as final versions. Any changes will be reflected in the online version in the month the article is officially released.Listeria monocytogenes is … [+21365 chars]	https://wwwnc.cdc.gov/eid/article/31/13/24-1357_article	https://wwwnc.cdc.gov/eid/images/og-eid-logo-2.jpg	2025-05-06 04:00:00
92	0	9	NewsAPI	Middle-aged Americans report higher loneliness than older adults, global study finds	Middle-aged Americans have demonstrated some of the highest levels of loneliness in a new study assessing tens of thousands of 50-to-90-year-olds across 29 countries.	Middle-aged Americans have demonstrated some of the highest levels of loneliness in a new study assessing tens of thousands of 50-to-90-year-olds across 29 countries.\r\nThe research, published in Agin… [+5238 chars]	https://medicalxpress.com/news/2025-04-middle-aged-americans-higher-loneliness.html	https://scx2.b-cdn.net/gfx/news/hires/2022/old-person-lonely.jpg	2025-04-22 04:49:23
93	0.2	10	NewsAPI	Middle East Undiscovered Gems And 2 Other Promising Stocks With Strong Potential	As most Gulf markets have recently ended higher, buoyed by potential U.S. tariff exemptions, investors are closely watching the Middle East for emerging...	As most Gulf markets have recently ended higher, buoyed by potential U.S. tariff exemptions, investors are closely watching the Middle East for emerging opportunities amid ongoing trade tensions and … [+6302 chars]	https://finance.yahoo.com/news/middle-east-undiscovered-gems-2-083245246.html	https://media.zenfs.com/en/simply_wall_st__316/5bcfe52095f73041f79c669b593d7118	2025-04-16 08:32:45
94	0.1	10	NewsAPI	Why everyone is suddenly so interested in US bond markets	What is happening with US bonds, why Donald Trump cares and how ordinary Americans could be affected.	Michael RaceEconomics reporter, BBC News\r\nStock markets around the world have been relatively settled this week after a period of chaos, sparked by US trade tariffs.\r\nBut investors are still closely … [+6161 chars]	https://www.bbc.com/news/articles/cvg838qq7zqo	https://ichef.bbci.co.uk/news/1024/branded_news/8e35/live/0835d130-1a3c-11f0-a020-db6d78ff6ddb.jpg	2025-04-19 01:06:12
95	0.1	10	NewsAPI	Apple Stock Earnings Preview: Things To Consider Before The Next Report	Examine the key factors to watch before the next Apple earnings report to help you make informed decisions on AAPL.	Apple's upcoming earnings report arrives at a critical juncture, with solid company fundamentals ... More potentially overshadowed by escalating macroeconomic and geopolitical challenges.\r\nGetty Imag… [+13710 chars]	https://www.forbes.com/sites/investor-hub/article/apple-aapl-stock-earnings-things-to-consider/	https://imageio.forbes.com/specials-images/imageserve/6807ef026a2cb38c08b48c67/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 11:00:00
96	0.1	10	NewsAPI	Al Khaleej Investment P.J.S.C And 2 Other Promising Middle Eastern Penny Stocks	As the Middle Eastern markets navigate through the complexities of global trade policies, with Saudi Arabia's bourse showing gains and Qatar remaining steady...	As the Middle Eastern markets navigate through the complexities of global trade policies, with Saudi Arabia's bourse showing gains and Qatar remaining steady, investors are keenly observing the regio… [+5794 chars]	https://finance.yahoo.com/news/al-khaleej-investment-p-j-040445939.html	https://media.zenfs.com/en/simply_wall_st__316/149379d8a650c85760e756f72bf83078	2025-04-21 04:04:45
97	0.1	10	NewsAPI	High Growth Tech Stocks In Asia To Watch In May 2025	Amidst easing trade concerns and better-than-expected earnings reports, global markets have shown positive momentum, with technology stocks in particular...	Amidst easing trade concerns and better-than-expected earnings reports, global markets have shown positive momentum, with technology stocks in particular experiencing notable gains. As the Asian tech… [+5876 chars]	https://finance.yahoo.com/news/high-growth-tech-stocks-asia-044532022.html	https://media.zenfs.com/en/simply_wall_st__316/587bca1ec4acb3634ab3a458c085a4fc	2025-05-07 04:45:32
100	0	10	NewsAPI	Stock market today: Dow surges 600 points, S&P 500 has best week since 2023 to cap wild week of tariff-fueled chaos	Wall Street is set to wrap up another week of tariff-fueled turmoil.	US stocks turned higher on Friday to cap a chaotic week on Wall Street, as investors weighed the latest tariff-related developments in the trade war between the US and China.\r\nThe S&amp;P 500 (^GSPC)… [+14695 chars]	https://finance.yahoo.com/news/live/stock-market-today-dow-sp-500-post-best-week-since-2023-to-cap-wild-week-of-tariff-fueled-chaos-200222921.html	https://s.yimg.com/ny/api/res/1.2/Yz.DcLMcTMSbZO90snslyA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2025-04/2292f950-1644-11f0-baff-4b860b82613e	2025-04-11 20:02:22
101	0	10	NewsAPI	Global South and Multilateral Financial Institutions: Where Does BRICS Stand?	Why BRICS has gotten barely anywhere on launching its own finanicial institutions and why that is unlikely to change soon if ever.	Yves here. Even though this post stresses the opportunity for BRICS members to play a heftier role in international lending and development programs, it effectively admits BRICS is pretty much nowwhe… [+11574 chars]	https://www.nakedcapitalism.com/2025/05/global-south-and-multilateral-financial-institutions-where-does-brics-stand.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/05/Screenshot-2025-05-01-at-12.33.06 PM.png	2025-05-01 05:49:03
102	0	10	NewsAPI	Dave Iben: Finding Hidden Value In A Stock Market Obsessed With Noise	Dave Iben of Kopernik Global Investors shares why hidden value, patience, and global contrarian investing still offer outsized opportunities in today's distorted markets.	Dave Iben. Chief Investment Officer, Managing Member, Founder, and Chairman of the Board of Kopernik ... More Global Investors.\r\nKopernik Global Investors, LLC\r\nHidden value is difficult to find. Tod… [+13395 chars]	https://www.forbes.com/sites/jimosman/2025/04/28/dave-iben-finding-hidden-value-in-a-stock-market-obsessed-with-noise/	https://imageio.forbes.com/specials-images/imageserve/680fc61fc12c99e4588b4483/0x0.jpg?format=jpg&crop=1365,768,x0,y158,safe&height=900&width=1600&fit=bounds	2025-04-28 21:18:51
103	0	10	NewsAPI	Trump Issues Huge Fed Challenge—Sparking Stock Market Plunge As Gold And Bitcoin Price Soar	The White House has confirmed Trump is exploring whether he can fire Federal Reserve chair Jerome Powell—something that could trigger an “apocalyptic scenario" for markets...	04/21 update below. This post was originally published on April 20\r\nBitcoin and crypto prices are treading water after U.S. president Donald Trumps trade war sparked market chaos thats threatening to… [+5006 chars]	https://www.forbes.com/sites/digital-assets/2025/04/21/bitcoin-braced-for-apocalyptic-price-shock-after-white-house-confirms-fed-bombshell/	https://imageio.forbes.com/specials-images/imageserve/626e4deb9cb7a8fb2aab7720/0x0.jpg?format=jpg&crop=1181,664,x560,y255,safe&height=900&width=1600&fit=bounds	2025-04-21 14:56:04
104	0	10	NewsAPI	Agentic AI: The Rise Of Autonomous Decisions In The Financial Industry	Today, the AI frontier has shifted to whether banks can allow software "colleagues" to run unsupervised for minutes, hours or even days.	Agnetic AI is set to redefine the banking industry, but how big is the opportunity and what are the ... More challenges ahead?\r\ngetty\r\nA premarket shuffle no one noticed\r\nJust after dawn in London, a… [+10111 chars]	https://www.forbes.com/sites/zennonkapron/2025/04/23/agentic-ai-the-rise-of-autonomous-decisions-in-the-financial-industry/	https://imageio.forbes.com/specials-images/imageserve/6805c47375f81915a2fe59f1/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-23 04:43:00
105	0	10	NewsAPI	Nu Holdings Ltd. (NU): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where Nu Holdings Ltd. (NYSE:NU) stands agai… [+7330 chars]	https://finance.yahoo.com/news/nu-holdings-ltd-nu-among-135947550.html	https://s.yimg.com/ny/api/res/1.2/ZYefRkClLLXcl7c848BAMg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD0xNjQz/https://media.zenfs.com/en/insidermonkey.com/7e0be664333815759bd72dc62b913ad8	2025-04-26 13:59:47
106	0	10	NewsAPI	ARK Invest Raises 2030 Bitcoin Price Target to as High as $2.4M in Bullish Scenario	Falling bitcoin exchange balances signal strong holder sentiment as bitcoin hovers around $94,000.	ARK Invest raised its decade-end bitcoin (BTC) price target to as high as $2.4 million apiece after revising its assumptions on active supply, which excludes lost or long-held coins. The largest cryp… [+1376 chars]	https://www.coindesk.com/markets/2025/04/25/ark-invest-raises-2030-bitcoin-price-target-to-as-high-as-24m-in-bullish-scenario	https://cdn.sanity.io/images/s3y3vcno/production/8cc90c5f340b1679b3c5193f02af0b67a27baedb-599x355.png?auto=format	2025-04-25 08:50:34
107	0	10	NewsAPI	Fintech's Latest Trend: AI Agents For Investment Research	Companies of all sizes, ranging from trading app Robinhood to 10-person New York startups, are now using AI to speed up and improve investment research.	George Sivulka, founder and CEO of Hebbia, a startup that uses AI to improve research for investment bankers and investors.\r\nHebbia\r\nFor all the fast adoption of artificial intelligence tools in so m… [+7850 chars]	https://www.forbes.com/sites/jeffkauflin/2025/04/11/fintechs-latest-trend-ai-agents-for-investment-research/	https://imageio.forbes.com/specials-images/imageserve/67f85d2456e87488b0ca99fe/0x0.jpg?format=jpg&crop=1232,821,x0,y176,safe&height=900&width=1600&fit=bounds	2025-04-11 13:00:00
108	0	10	NewsAPI	New Nasdaq Rules Reshape The IPO Path For Microcap Companies	The U.S. Securities and Exchange Commission (SEC) has approved sweeping changes to the Nasdaq Capital Market listing standards.	Joseph Lucosky is the Managing Partner of Lucosky Brookman, a leading law firm in the world of microcap IPOs and Nasdaq/NYSE listings.\r\ngetty\r\nThe U.S. Securities and Exchange Commission (SEC) recent… [+6716 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/04/25/new-nasdaq-rules-reshape-the-ipo-path-for-microcap-companies/	https://imageio.forbes.com/specials-images/imageserve/674f57481dd3f3a70bc91311/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-25 20:24:05
109	0	10	NewsAPI	KKR & Co. Inc. (KKR): Among Billionaire Ken Fisher’s Finance Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Ken Fisher’s 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Ken Fishers 10 Finance Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where KKR &amp; Co. Inc. (NYSE:KKR) stands a… [+7656 chars]	https://finance.yahoo.com/news/kkr-co-inc-kkr-among-140028374.html	https://s.yimg.com/ny/api/res/1.2/8taE7UVa..JXX21T_2uUvA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/8591b721983e13534e161de9a53ccbf6	2025-04-26 14:00:28
110	0	10	NewsAPI	Dealing With Tariffs, Tumult, And Unpredictable Change	The emerging tariff-driven trade war is the latest in a series of “unprecedented” events businesses have had to weather over the last decade. Ready to build resilience?	If you find your business struggling in the face of unpredictability, particularly on the economic front, youre not alone.\r\ngetty\r\nBy Matthew Grant, Senior Writer, SAP LeanIX and SAP Signavio\r\nThe em… [+7071 chars]	https://www.forbes.com/sites/sap/2025/05/08/dealing-with-tariffs-tumult-and-unpredictable-change/	https://imageio.forbes.com/specials-images/imageserve/60393f2a31c5c722e166bca1/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 16:00:53
111	0	10	NewsAPI	How Julianna Hayes Embraces The “CFO+” Role At Philo	How Julianna Hayes Embraces the CFO+ Role at Philo Julianna Hayes serves as Chief Financial Officer of Philo, a streaming service that has steadily grown its footprint...	Julianna Hayes\r\n is the CFO of Philo\r\n, a leading streaming platform that reaches over 3.4 million monthly active users. Under her financial stewardship, Philo has successfully expanded beyond its or… [+9523 chars]	https://www.forbes.com/sites/jackmccullough/2025/05/06/how-julianna-hayes-embraces-the-cfo-role-at-philo/	https://imageio.forbes.com/specials-images/imageserve/68181b41e1e99e5feaf4d98d/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-06 07:34:00
112	0	10	NewsAPI	Why Coty Inc. (COTY) is the Best Cosmetics Stock to Buy for 2025	We recently published a list of 12 Best Cosmetics Stocks to Buy for 2025. In this article, we are going to take a look at where Coty Inc. (NYSE:COTY) stands ...	We recently published a list of 12 Best Cosmetics Stocks to Buy for 2025. In this article, we are going to take a look at where Coty Inc. (NYSE:COTY) stands against other best cosmetics stocks to buy… [+5414 chars]	https://finance.yahoo.com/news/why-coty-inc-coty-best-192350905.html	https://s.yimg.com/ny/api/res/1.2/0kCCZDm6eIX_rnb.Wt4Gzw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/e8b86f192c16d133b1d02e6809546347	2025-04-18 19:23:50
113	0.089	11	NewsAPI	Oaktree Specialty Lending: 13% Yield, Hidden Quality	Invest with Howard Marks	Additionally, OCSL imposes restrictions on the types of investments that can be placed within its corporate structure. While some of these restrictions may seem unnecessary and could potentially excl… [+31732 chars]	https://finance.yahoo.com/news/oaktree-specialty-lending-13-yield-112857240.html	https://media.zenfs.com/en/us.finance.gurufocus/e4bbf3b015cde6f4acd5aa82603e8210	2025-04-18 11:28:57
114	0	11	NewsAPI	Why everyone is suddenly so interested in US bond markets	What is happening with US bonds, why Donald Trump cares and how ordinary Americans could be affected.	Michael RaceEconomics reporter, BBC News\r\nStock markets around the world have been relatively settled this week after a period of chaos, sparked by US trade tariffs.\r\nBut investors are still closely … [+6161 chars]	https://www.bbc.com/news/articles/cvg838qq7zqo	https://ichef.bbci.co.uk/news/1024/branded_news/8e35/live/0835d130-1a3c-11f0-a020-db6d78ff6ddb.jpg	2025-04-19 01:06:12
115	0	11	NewsAPI	Accor Says April Bookings Have Rebounded: No ‘Cracks in Demand’	Accor reported earnings, and it's a fascinating window into the global economy. The hotel giant said demand wasn't weakening in its key markets.	Accor, the Paris-based hotel operator, reported solid first-quarter performance despite broader economic concerns related to recent U.S. trade policies.\r\n"We're not seeing cracks in demand," said Mar… [+5487 chars]	https://finance.yahoo.com/news/accor-says-april-bookings-rebounded-173058058.html	https://media.zenfs.com/en/skift_501/bef291ac2e7fc6c2d29115afc69b10e3	2025-04-24 17:30:58
116	0	11	NewsAPI	F&O Talk | Bank Nifty outperforms as valuations stay attractive, liquidity support continues: Shrikant Chouhan of Kotak Securities	Markets extended their winning streak for the fourth straight week, logging gains of over 3.8% in a truncated trading week, as investor sentiment remained buoyant amid favorable macroeconomic data and steady global cues.	Markets extended their winning streak for the fourth straight week, logging gains of over 3.8% in a truncated trading week, as investor sentiment remained buoyant amid favorable macroeconomic data an… [+7798 chars]	https://economictimes.indiatimes.com/markets/expert-view/fo-talk-bank-nifty-outperforms-as-valuations-stay-attractive-liquidity-support-continues-shrikant-chouhan-of-kotak-securities/articleshow/120448481.cms	https://img.etimg.com/thumb/msid-120448554,width-1200,height-630,imgsize-134026,overlay-etmarkets/articleshow.jpg	2025-04-20 04:50:52
117	0	11	NewsAPI	Trade war u-turn: Why did Trump blink first?	It’s been a hell of a week and 24 hours.	Trump famously staring at the solar eclipse in August 2017. Alamy Stock Photo\r\n Alamy Stock Photo\r\nWELL, IT HAPPENED.\r\nUS President Donald Trump has caved, for now, on his move to completely upend th… [+6290 chars]	https://www.thejournal.ie/trump-u-turn-markets-6674043-Apr2025/	https://img2.thejournal.ie/article/6674043/river/?height=400&version=6674354	2025-04-10 13:09:25
118	0	11	NewsAPI	Share Market Highlights: Sensex reclaims 80,000 mark after 4 months on IT, auto rally	Sensex, Nifty updates on 23 April 2025: Indian equities extended gains for the seventh straight session on Wednesday, with the BSE Sensex jumping 520.90 points (0.65%) to close at 80,116.49—its highest level since December 18. The broader Nifty 50 surged 161.…	Stock Market on 23 April 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:42 | April 23, 2025The live bl… [+37597 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-23-april-2025/article69479038.ece	https://bl-i.thgim.com/public/incoming/l2dnev/article69479063.ece/alternates/LANDSCAPE_1200/Stock%20market%20live%20today.jpg	2025-04-23 01:10:56
119	0	11	NewsAPI	Stock market today: Dow, S&P 500, Nasdaq rally for 2nd day, Apple jumps on tech tariff reprieve	Wall Street is bracing for another week of tariff-fueled whiplash.	US stocks edged higher on Monday as investors focused on tech's temporary reprieve from President Trump's tariffs. \r\nThe S&amp;P 500 (^GSPC) trimmed bigger gains to rise a healthy 0.8%. The tech-heav… [+13704 chars]	https://finance.yahoo.com/news/live/stock-market-today-dow-sp-500-nasdaq-rally-for-2nd-day-apple-jumps-on-tech-tariff-reprieve-200038586.html	https://s.yimg.com/ny/api/res/1.2/POV_TExuWQ4hjiZkzMpkIw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://s.yimg.com/os/creatr-uploaded-images/2025-04/1b97a550-18ac-11f0-befb-631f40bd824a	2025-04-14 20:00:38
120	0	11	NewsAPI	Stock Market Live Updates 21 April 2025: Stock to buy today: Can Fin Homes (₹711.70) – BUY	Sensex, Nifty Live updates on 21 April 2025: The short-term outlook is bullish for Can Fin Homes. The stock had surged over 9 per cent last week and has closed on a strong note. The 2 per cent rise on Thursday last week has taken the share price well above th…	Stock Market Today | Share Market Live Updates - Find here all the live updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets for 21 April 2025.<li></li>\r\n07:22 | April 21… [+12660 chars]	https://www.thehindubusinessline.com/markets/share-market-today-nifty-sensex-live-updates-21-april-2025/article69460608.ece	https://bl-i.thgim.com/public/incoming/vydb7g/article69448410.ece/alternates/LANDSCAPE_1200/PO13_BS_stock_market.jpg	2025-04-21 01:38:09
121	0	11	NewsAPI	Small business fundraising, US Education Secretary McMahon: Wealth	Wealth host Brad Smith is paying close attention to Wednesday morning's market moves (^DJI, ^IXIC, ^GSPC) while speaking to a variety of investing and...	It's time for Finance's market. Stocks are flipping around this morning. Some moving to the downside in the Nasdaq. S&amp;P is up. Investors looking for potential deceleration in the US-China trade w… [+47145 chars]	https://finance.yahoo.com/video/small-business-fundraising-us-education-163313387.html	https://s.yimg.com/ny/api/res/1.2/yZ8GIn3qteFlop4OtMtBQA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzY-/https://s.yimg.com/os/creatr-uploaded-images/2025-05/eb9ff970-2b60-11f0-aff0-e426a03df865	2025-05-07 16:33:13
122	0	11	NewsAPI	After crossing the $3,500 threshold, where are gold prices headed? Will they touch $4,000? Here's what analysts say	Gold prices in the US soared to a record $3,500 per ounce, fueled by economic uncertainty and President Trump's criticism of the Federal Reserve. Trump's attacks on Fed Chair Powell triggered investor flight from US assets to safe havens like gold. Experts su…	Prices of gold in the United States have reached a record high, with the rate at $3,500 per ounce, which has led many analysts to wonder if this is the start of an even better rally, according to a r… [+3579 chars]	https://economictimes.indiatimes.com/news/international/us/after-crossing-the-3500-threshold-where-are-gold-prices-headed-will-they-touch-4000-heres-what-analysts-say/articleshow/120525062.cms	https://img.etimg.com/thumb/msid-120525016,width-1200,height-630,imgsize-69260,overlay-economictimes/articleshow.jpg	2025-04-22 16:47:44
123	0	11	NewsAPI	Share Market Highlights: Sensex, Nifty decline sharply on Axis Bank slump and growing geopolitical tensions	Sensex, Nifty updates on 25 April 2025: Equity benchmark indices Sensex and Nifty saw significant losses on Friday, driven by a sharp decline in Axis Bank’s stock and rising geopolitical tensions following a terror attack in Jammu & Kashmir. The 30-share BSE …	Stock Market on 24 March 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:18 | April 25, 2025Share marke… [+51716 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-25-april-2025/article69486746.ece	https://bl-i.thgim.com/public/incoming/evr3cx/article69399116.ece/alternates/LANDSCAPE_1200/PO05_Stock_data.jpg	2025-04-25 01:07:08
124	0	11	NewsAPI	Share Market Highlights: Sensex, Nifty snap 7-day rally on profit-taking, weak HUL earnings	Sensex, Nifty updates on 24 April 2025: Equity benchmarks Sensex and Nifty ended lower on Thursday, snapping a seven-session winning streak amid profit-booking and weak earnings from Hindustan Unilever Ltd (HUL). The Sensex fell 315.06 points (0.39%) to 79,80…	Stock Market on 24 April 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:43 | April 24, 2025The live bl… [+43361 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-24-april-2025/article69482948.ece	https://bl-i.thgim.com/public/incoming/j9mdxa/article69459412.ece/alternates/LANDSCAPE_1200/IMG_BL0710_Brand_Digital_2_1_1TDDRJOB.jpg	2025-04-24 01:06:16
125	0	11	NewsAPI	Stock Market Live Updates 23 April 2025: Stock to buy today: KIMS (₹683.40) – BUY	Sensex, Nifty, Share Prices LIVE: The short-term outlook is bullish for Krishna Institute of Medical Sciences (KIMS). The stock made a bullish breakout on Tuesday by rising above the key resistance level of ₹660. This also confirms an inverted head and should…	Stock Market today | Share Market Live Updates - Find here all the live updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets for 23 April 2025.<li></li>\r\n06:52 | April 23… [+7526 chars]	https://www.thehindubusinessline.com/markets/share-market-nifty-sensex-live-updates-23-april-2025/article69479038.ece	https://bl-i.thgim.com/public/incoming/l2dnev/article69479063.ece/alternates/LANDSCAPE_1200/Stock%20market%20live%20today.jpg	2025-04-23 01:10:56
126	0	11	NewsAPI	Share Market Highlights: Financials fuel market rally; Nifty, Sensex log 6th straight gain	Sensex, Nifty updates on 22 April 2025: India’s benchmark indices surged to their highest closing levels in nearly four months on Tuesday, buoyed by strong gains in banking stocks following the Reserve Bank of India’s (RBI) move to ease liquidity rules. The N…	Stock Market on 22 April 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:31 | April 22, 2025The live bl… [+40391 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-22-april-2025/article69475042.ece	https://bl-i.thgim.com/public/incoming/qa8voa/article69475064.ece/alternates/LANDSCAPE_1200/market%20chart-open%20offer.jpg	2025-04-22 01:24:58
127	0	11	NewsAPI	Share Market Highlights: Sensex, Nifty rally for 5th day on IT, bank gains; HDFC Bank, Infosys fuel surge	Sensex, Nifty updates on 21 April 2025: Benchmark indices Sensex and Nifty extended their rally for the fifth consecutive session on Monday, driven by robust buying in banking and IT stocks following upbeat quarterly results and sustained foreign fund inflows…	Stock Market on 21 April 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets<li></li>\r\n16:40 | April 21, 2025The live blo… [+69648 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-21-april-2025/article69460608.ece	https://bl-i.thgim.com/public/incoming/vydb7g/article69448410.ece/alternates/LANDSCAPE_1200/PO13_BS_stock_market.jpg	2025-04-21 01:38:09
128	0	11	NewsAPI	Share Market Highlights: Sensex rises 295 points, Nifty hits 24,461 on foreign inflows; Oil & Gas stocks rally	Sensex, Nifty updates on 5 May 2025: Indian equity benchmarks ended higher on Monday, supported by strong foreign inflows, optimism over a potential India-U.S. trade deal, and falling crude oil prices. The Nifty 50 rose 0.47% to close at 24,461.15, while the …	Stock Market on 5 May 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n15:49 | May 5, 2025The live blog is … [+98664 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-5-may-2025/article69537324.ece	https://bl-i.thgim.com/public/incoming/68hsoo/article69537325.ece/alternates/LANDSCAPE_1200/Stock%20market%20live%20today.jpg	2025-05-05 01:10:23
129	0	11	NewsAPI	The Latest: S&P 500 soars 9.5% to one of its biggest gains since WWII after Trump limits tariffs	Stocks surged to one of their biggest gains since World War II after President Donald Trump paused his tariffs against most other nations, as investors had desperately hoped he would	Stocks surged to one of their biggest gains since World War II after President Donald Trump paused his tariffs against most other nations, as investors had desperately hoped he would.\r\nTrump, though,… [+22027 chars]	https://www.wsbtv.com/news/latest-sp-500-soars/7VJNI6IDHVDUPNVP7YAKFXXFLI/	https://cmg-cmg-tv-10010-prod.cdn.arcpublishing.com/resizer/v2/https%3A%2F%2Fcloudfront-us-east-1.images.arcpublishing.com%2Fcmg%2FFEOH4UHMCH4TP54XINKAU6JPCA.jpg?auth=3d2010c5e8d7964d2f7532fd02b2357228fc3b61dce1a65fec07cff885b56d71&width=1200&height=630&smart=true	2025-04-10 01:17:26
130	0	11	NewsDATA	Unstoppable: Bitcoin Price Explodes Past $104,000 Milestone	The world of digital finance is buzzing! According to recent market monitoring, the Bitcoin price has reportedly surged past a significant psychological and numerical barrier, climbing above the $104,000 mark. This move has sent ripples across the entire crypto market, igniting discussions about Bitcoin’s trajectory, underlying drivers, and what this means for investors worldwide. Data [...]	ONLY AVAILABLE IN PAID PLANS	https://bitcoinworld.co.in/bitcoin-price-explodes-past/	https://bitcoinworld.co.in/wp-content/uploads/Unstoppable-Bitcoin-Price-Explodes-Past-104000-Milestone.webp	2025-05-10 21:30:15
131	0	11	NewsDATA	How to Choose the Perfect Cryptocurrency Exchange for Your Trading Goals in 2025	Are you new to the crypto world or a seasoned trader? It doesn’t matter, because you’ll need the perfect cryptocurrency exchange that suits your trading goals. Every cryptocurrency exchange differs from other platforms in terms such as trading fees, tools, and features. As a trader or investor, you must know about these factors, since they [...]The post How to Choose the Perfect Cryptocurrency Exchange for Your Trading Goals in 2025 appeared first on TechBullion.	ONLY AVAILABLE IN PAID PLANS	https://techbullion.com/how-to-choose-the-perfect-cryptocurrency-exchange-for-your-trading-goals-in-2025/	https://techbullion.com/wp-content/uploads/2025/05/GettyImages-453930217-42848c04ff58410d952e1a5b65a00929.jpg	2025-05-10 10:55:15
132	0	11	NewsDATA	Dollar confusion reigns amid uncertainty	Currency markets that only a few months ago assumed a trade war would lift the US dollar now suspect that a full-scale devaluation may be underway, suggesting few market players have a clear handle yet on the US administration's dollar plans.	ONLY AVAILABLE IN PAID PLANS	https://www.bangkokpost.com/opinion/opinion/3022112/dollar-confusion-reigns-amid-uncertainty	https://www.bangkokpost.com/v3/assets/images/img-default.jpg	2025-05-09 20:30:00
133	0.089	12	NewsAPI	SPY From History to Forecast: Trading with Artificial Intelligence (Serhii Bondarenko)	The SPDR S&amp;P 500 ETF Trust (SPY), a cornerstone of modern investing, mirrors the performance of ...	The SPDR S&amp;P 500 ETF Trust (SPY), a cornerstone of modern investing, mirrors the performance of the S&amp;P 500 index, offering investors exposure to the largest\r\n U.S. companies. Since its incep… [+8241 chars]	https://www.finextra.com/blogposting/28378/spy-from-history-to-forecast-trading-with-artificial-intelligence	https://www.finextra.com/finextra-images/member_photos/thumb_160358_serhii_bondarenko_18.jpg	2025-04-30 17:08:38
134	0.089	12	NewsAPI	9,460 Shares in Onestream, Inc. (NASDAQ:OS) Acquired by ExodusPoint Capital Management LP	ExodusPoint Capital Management LP bought a new stake in Onestream, Inc. (NASDAQ:OS – Free Report) in the fourth quarter, according to its most recent 13F filing with the Securities & Exchange Commission. The fund bought 9,460 shares of the company’s stock, va…	ExodusPoint Capital Management LP bought a new stake in Onestream, Inc. (NASDAQ:OS – Free Report) in the fourth quarter, according to its most recent 13F filing with the Securities &amp; Exchange Com… [+4308 chars]	https://www.etfdailynews.com/2025/04/14/9460-shares-in-onestream-inc-nasdaqos-acquired-by-exoduspoint-capital-management-lp/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/onestream-inc-logo-1200x675.png?v=20240923132509&w=240&h=240&zc=2	2025-04-14 07:46:57
135	0.089	12	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/20/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-20 10:33:12
136	0.089	12	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/25/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-25 10:33:12
137	0.089	12	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/05/03/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-05-03 10:33:12
138	0.089	12	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/11/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-11 10:33:12
139	0	12	NewsAPI	ExlService Holdings (EXLS): Among Louis Navellier’s New Stock Picks	We recently published a list of Louis Navellier’s 10 New Stock Picks. In this article, we are going to take a look at where ExlService Holdings, Inc...	We recently published a list of Louis Navelliers 10 New Stock Picks. In this article, we are going to take a look at where ExlService Holdings, Inc. (NASDAQ:EXLS) stands against other Louis Navellier… [+9539 chars]	https://finance.yahoo.com/news/exlservice-holdings-exls-among-louis-130543758.html	https://s.yimg.com/ny/api/res/1.2/kpvKyJbr_CkJqy9dcfUuow--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/3d1efb550ce7ab62ca0e575728ebf4f2	2025-04-17 13:05:43
140	0	12	NewsAPI	Transcript: Sander Gerber, CEO and CIO Hudson Bay Capital	﻿     The transcript from this week’s, MiB: Sander Gerber, CEO and CIO Hudson Bay Capital, is below. You can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spotify, YouTube, and Bloomberg. All of our earlier podcas…	The transcript from this weeks, MiB: Sander Gerber, CEO and CIO Hudson Bay Capital, is below.\r\nYou can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spot… [+53213 chars]	https://ritholtz.com/2025/05/transcript-sander-gerber/	https://ritholtz.com/wp-content/uploads/2023/02/Mib-tile.png	2025-05-06 16:30:50
141	0	12	NewsAPI	2 ‘Strong Buy’ Stocks That Are Crashing the Market in April	Stocks are swinging wildly this month, as President Trump’s latest tariff moves continue to send shockwaves through the markets. His across-the-board policy ...	Stocks are swinging wildly this month, as President Trumps latest tariff moves continue to send shockwaves through the markets. His across-the-board policy shifts have rattled investors and put heavy… [+7684 chars]	https://finance.yahoo.com/news/2-strong-buy-stocks-crashing-100125183.html	https://media.zenfs.com/en/tipranks_452/ff6459a3057be2a025f5a5f0dc6b5d10	2025-04-23 10:01:25
142	0	12	NewsAPI	Flowco (FLOC) and Its Competitors Financial Review	Flowco (NYSE:FLOC – Get Free Report) is one of 28 publicly-traded companies in the “Oil & gas field machinery” industry, but how does it contrast to its peers? We will compare Flowco to similar businesses based on the strength of its dividends, institutional …	Flowco (NYSE:FLOC – Get Free Report) is one of 28 publicly-traded companies in the “Oil &amp; gas field machinery” industry, but how does it contrast to its peers? We will compare Flowco to similar b… [+21347 chars]	https://www.etfdailynews.com/2025/05/09/flowco-floc-and-its-competitors-financial-review/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/flowco-holdings-inc-logo-1200x675.jpg?v=20250210060006&w=240&h=240&zc=2	2025-05-09 06:10:45
143	0	12	NewsAPI	Oakridge Global Energy Solutions (OTCMKTS:OGES) and Eos Energy Enterprises (NASDAQ:EOSE) Financial Comparison	Eos Energy Enterprises (NASDAQ:EOSE – Get Free Report) and Oakridge Global Energy Solutions (OTCMKTS:OGES – Get Free Report) are both industrials companies, but which is the better business? We will contrast the two businesses based on the strength of their p…	Eos Energy Enterprises (NASDAQ:EOSE – Get Free Report) and Oakridge Global Energy Solutions (OTCMKTS:OGES – Get Free Report) are both industrials companies, but which is the better business? We will … [+4579 chars]	https://www.etfdailynews.com/2025/05/07/oakridge-global-energy-solutions-otcmktsoges-and-eos-energy-enterprises-nasdaqeose-financial-comparison/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/oakridge-global-energy-solutions-inc-logo-1200x675.jpg?v=20220628111424&w=240&h=240&zc=2	2025-05-07 05:20:52
144	0	12	NewsAPI	Is Salesforce Inc. (CRM) the Best Dow Stock for the Next 12 Months?	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where Salesforce Inc. (...	We recently published a list of The Best and Worst Dow Stocks for the Next 12 Months. In this article, we are going to take a look at where Salesforce Inc. (NYSE:CRM) stands against other best and wo… [+7280 chars]	https://finance.yahoo.com/news/salesforce-inc-crm-best-dow-182516932.html	https://s.yimg.com/ny/api/res/1.2/V4tGuBo0fm2vOSewxPjpmw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/057172d1bddd5e7eaee5fc08e2756794	2025-04-30 18:25:16
145	0	12	NewsAPI	Financial Comparison: Flowco (FLOC) versus The Competition	Flowco (NYSE:FLOC – Get Free Report) is one of 28 public companies in the “Oil & gas field machinery” industry, but how does it weigh in compared to its peers? We will compare Flowco to related companies based on the strength of its dividends, earnings, insti…	Flowco (NYSE:FLOC – Get Free Report) is one of 28 public companies in the “Oil &amp; gas field machinery” industry, but how does it weigh in compared to its peers? We will compare Flowco to related c… [+21325 chars]	https://www.etfdailynews.com/2025/05/09/financial-comparison-flowco-floc-versus-the-competition/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/flowco-holdings-inc-logo-1200x675.jpg?v=20250210060006&w=240&h=240&zc=2	2025-05-09 05:18:53
146	0	12	NewsAPI	BioCryst Appoints Steve Frank to Board of Directors	RESEARCH TRIANGLE PARK, N.C., May 01, 2025 (GLOBE NEWSWIRE) -- BioCryst Pharmaceuticals, Inc. (Nasdaq:BCRX) today announced that the company has appointed healthcare investment banking leader Steve Frank to its board of directors.	RESEARCH TRIANGLE PARK, N.C., May 01, 2025 (GLOBE NEWSWIRE) -- BioCryst Pharmaceuticals, Inc. (Nasdaq:BCRX) today announced that the company has appointed healthcare investment banking leader Steve F… [+6080 chars]	https://www.globenewswire.com/news-release/2025/05/01/3072241/29446/en/BioCryst-Appoints-Steve-Frank-to-Board-of-Directors.html	https://ml.globenewswire.com/Resource/Download/8b033909-1a3c-4811-b07b-fe03b12e00d2	2025-05-01 11:00:00
147	0	12	NewsAPI	Galapagos Reports First Quarter 2025 Financial Results, Recent Business Highlights and Near-Term Catalysts	First U.S. patient dosed in ATALANTA-1 study of GLPG5101  Mantle cell lymphoma (MCL), a high-unmet-need hematological malignancy, selected as lead......	First U.S. patient dosed in ATALANTA-1 study of GLPG5101\r\nMantle cell lymphoma (MCL), a high-unmet-need hematological malignancy, selected as lead indication for the GLPG5101 program; Pivotal develop… [+40859 chars]	https://www.globenewswire.com/news-release/2025/04/23/3066859/0/en/Galapagos-Reports-First-Quarter-2025-Financial-Results-Recent-Business-Highlights-and-Near-Term-Catalysts.html	https://ml-eu.globenewswire.com/Resource/Download/13b034e2-76d4-408b-bffb-c80d85420b03	2025-04-23 20:01:00
148	0	12	NewsAPI	From Gig Economy to Enterprise IT: Why Freelancers Should Care About Mainframe Testing	This article, From Gig Economy to Enterprise IT: Why Freelancers Should Care About Mainframe Testing, was published on the Millo.co blog. Thanks for reading!\nWith ever changing technology and rapid growth in innovation, the gig economy has opened its doors to…	With ever changing technology and rapid growth in innovation, the gig economy has opened its doors to freelancers all over the world to work on diverse projects across industries. Freelancers can now… [+14438 chars]	https://millo.co/from-gig-economy-to-enterprise-it-why-freelancers-should-care-about-mainframe-testing	https://millo.co/wp-content/uploads/2025/05/mainframe-freelancer.png	2025-05-02 17:51:48
204	0	19	NewsAPI	‘Make her first time special’: New warning sounded for artificial intelligence	'Chatbot' found ignoring situation involving potential pedophilia, statutory rape	Artificial intelligence is the new web, the new cell phone, the new email, the new laptop, the new tech that is expected to impact lives in a major way, as all of those earlier advances did.\r\nBut it’… [+3756 chars]	https://www.wnd.com/2025/04/make-her-first-time-special-new-warning-sounded-for-artificial-intelligence/	https://www.wnd.com/wp-content/uploads/2024/12/teens-girls-young-wman-women-beautiful-sexy-food-fruit-peaches-eating-unsplash.jpg	2025-04-14 17:46:32
149	0	12	NewsAPI	Legal & General Group Plc Makes New $934,000 Investment in Onestream, Inc. (NASDAQ:OS)	Legal & General Group Plc bought a new position in shares of Onestream, Inc. (NASDAQ:OS – Free Report) during the fourth quarter, HoldingsChannel.com reports. The firm bought 32,756 shares of the company’s stock, valued at approximately $934,000. A number of …	Legal &amp; General Group Plc bought a new position in shares of Onestream, Inc. (NASDAQ:OS – Free Report) during the fourth quarter, HoldingsChannel.com reports. The firm bought 32,756 shares of the… [+4769 chars]	https://www.etfdailynews.com/2025/04/28/legal-general-group-plc-makes-new-934000-investment-in-onestream-inc-nasdaqos/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/onestream-inc-logo-1200x675.png?v=20240923132509&w=240&h=240&zc=2	2025-04-28 07:56:54
150	0	12	NewsAPI	Europe Smart Farming Market Analysis and Forecast, 2024-2034: Increasing Investment in Agriculture Technology Start-Ups, Growing Adoption of Precision Agriculture	Europe smart farming market is expected to increase significantly due to the growing use of cutting-edge technologies and a focus on environmentally friendly farming methods. The growing demand for food, the requirement for effective resource management, and …	Dublin, April 16, 2025 (GLOBE NEWSWIRE) -- The "Europe Smart Farming Market: Focus on Application, Hardware, Software, and Country - Analysis and Forecast, 2024-2034" report has been added to Researc… [+5943 chars]	https://www.globenewswire.com/news-release/2025/04/16/3062444/28124/en/Europe-Smart-Farming-Market-Analysis-and-Forecast-2024-2034-Increasing-Investment-in-Agriculture-Technology-Start-Ups-Growing-Adoption-of-Precision-Agriculture.html	https://ml.globenewswire.com/Resource/Download/908fb457-7f8e-4a08-9081-5565e3dfb3d7	2025-04-16 11:25:00
151	0	12	NewsAPI	Regulatory Compliance: Looking through AI lenses in times of regulatory divergences (Indra Chourasia)	Uncertainty adding new regulatory drift Amid the increased unpredictability of economic policies aff...	Uncertainty adding new regulatory drift\r\nAmid the increased unpredictability of economic policies affecting the business landscape, the recent optimism about regulatory reforms and deregulation, expe… [+10817 chars]	https://www.finextra.com/blogposting/28356/regulatory-compliance-looking-through-ai-lenses-in-times-of-regulatory-divergences	https://www.finextra.com/finextra-images/member_photos/thumb_143340_indra_chourasia_192.jpg	2025-04-28 08:11:53
152	0	12	NewsAPI	AI as Normal Technology | Knight First Amendment Institute	AI as Normal Technology\nAn alternative to the vision of AI as a potential superintelligence\n\nBY ARVIND NARAYANAN &	We articulate a vision of artificial intelligence (AI) as normal technology. To view AI as normal is not to understate its impact—even transformative, general-purpose technologies such as electricity… [+160404 chars]	http://knightcolumbia.org/content/ai-as-normal-technology	https://kfai-documents.s3.amazonaws.com/images/9221083633/Susskind-Hero-Image-w-color-wash--3-_medium.png	2025-04-16 05:47:01
153	0	13	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
154	0	13	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
155	0	13	NewsAPI	Does the Covid “Jab” Cause Amyloidosis? Richard C. Cook	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by Dr. Gregory House and …\nThe post Does the Covid “Jab” Cause …	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by … [+9925 chars]	https://www.globalresearch.ca/jab-cause-amyloidosis-richard-cook/5886442	https://www.globalresearch.ca/wp-content/uploads/2021/06/Covid-vaccine-VAERS-061821-feature-800x417.jpg	2025-05-10 12:19:57
156	0	13	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France	ONLY AVAILABLE IN PAID PLANS	https://abcnews.go.com/Business/wireStory/cannes-global-colosseum-film-readies-78th-edition-new-121681980	https://s.abcnews.com/images/Entertainment/wirestory_d289e6798571dd31943dc3d6d3a2d556_4x3_384.jpg	2025-05-11 05:42:14
157	0	13	NewsDATA	Rebecca Solnit: ‘Fiction was always treated as the most important, literary, aspirational goal – f*** that’	The prolific non-fiction writer returns to her favourite themes of hope and uncertainty in her cheerful new book, ‘No Straight Road Takes You There’. In a conversation with Hannah Ewens, she discusses why fiction is overrated, why new age spirituality is a hoax and how a functional social welfare state would encourage women to have children	ONLY AVAILABLE IN PAID PLANS	https://www.independent.co.uk/arts-entertainment/books/rebecca-solnit-author-activist-hay-festival-b2747194.html	https://static.independent.co.uk/2025/05/08/11/46/Rebecca-Solnit.jpeg?crop=1200%3A800&height=800&trim=732%2C0%2C370%2C0&width=1200	2025-05-11 05:00:00
158	0	13	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.nsnews.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
159	0	13	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival, which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films. Cannes, where filmmakers, sales agents and journalists gather from around the world, is the Olympics of the big screen, with its own [...]	ONLY AVAILABLE IN PAID PLANS	https://halifax.citynews.ca/2025/05/11/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon/	https://halifax.citynews.ca/wp-content/blogs.dir/sites/5/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9-1024x699.jpg	2025-05-11 04:11:25
160	0	13	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.richmond-news.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
161	0	13	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.burnabynow.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
162	0	13	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France. That’s not just because of the long list of anticipated films...	ONLY AVAILABLE IN PAID PLANS	https://www.union-bulletin.com/news/national/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the/article_04e837ae-22dc-56ce-8ac0-25071cdc2d66.html	https://bloximages.newyork1.vip.townnews.com/union-bulletin.com/content/tncms/assets/v3/editorial/1/00/10054b5f-8848-583c-87ec-fcb79e9f0688/68202501702a9.image.jpg?resize=300%2C205	2025-05-11 04:06:57
163	0	15	NewsAPI	With Mark Carney’s Win, Trump Is Now Sandwiched Between Two Climate Leaders	The success of Canada's Mark Carney and Mexico's Claudia Sheinbaum is a chance to reflect on the best strategy to tackle climate change.	Mark Carney was elected to a full term as Canadas prime minister Monday with a campaign agenda focused squarely on pushing back on attacks from his counterpart to the South, President Donald Trump. I… [+5835 chars]	https://time.com/7281714/mark-carney-canada-mexico-climate-leadership-strategy/	https://api.time.com/wp-content/uploads/2025/04/mark-carney-climate-change.jpg?quality=85&w=1024&h=628&crop=1	2025-04-30 19:32:15
164	0	15	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
165	0	15	NewsAPI	The Muslim Vote may have lost, but election bump is 'just the beginning'	Labor maintained their key seats in Western Sydney, but is was not without a fight.	Labor may have retained the Western Sydney seats of Blaxland and Watson with comfortable margins, but a closer look at the results reveals the party has lost some support.\r\nWhile the federal election… [+4906 chars]	https://www.abc.net.au/news/2025-05-09/federal-election-results-western-sydney-muslim-vote-independents/105273452	https://live-production.wcms.abc-cdn.net.au/c2f9f73c81744af786ace07fb17f9b2e?impolicy=wcms_watermark_news&cropH=3942&cropW=7008&xPos=0&yPos=265&width=862&height=485&imformat=generic	2025-05-09 06:19:13
166	0	15	NewsAPI	The Thucydides Trap: Vital lessons from ancient Greece for China and the US … or a load of old claptrap?	Is a US-China war inevitable? Perhaps that isn’t the lesson leaders should be taking from the ‘History of the Peloponnesian War.’	Retreat of the Athenians from Syracuse during a battle of the Peloponnesian War, from Cassell's 'Universal History,' published in 1888. Ken Welsh/Design Pics/Universal Images Group via Getty Images)\r… [+5523 chars]	https://theconversation.com/the-thucydides-trap-vital-lessons-from-ancient-greece-for-china-and-the-us-or-a-load-of-old-claptrap-252954	https://images.theconversation.com/files/660272/original/file-20250407-56-uua5y5.jpg?ixlib=rb-4.1.0&rect=0%2C313%2C5981%2C2990&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-15 12:27:01
167	0	15	NewsAPI	How Donald Trump Upended US Foreign Policy in 100 Days	"It's been one of the most exciting starts to a new presidential term since Gorbachev," academic Barry Scott Zellen told Newsweek.	President Donald Trump is "redrawing the world map" with his foreign policy, driven by his "America first" stance, his anti-globalist position, his "like" for provoking America's allies and his desir… [+10883 chars]	https://www.newsweek.com/donald-trump-foreign-policy-100-days-2064942	https://d.newsweek.com/en/full/2626627/trump-upended-foreign-policy-100-days.png	2025-04-29 11:38:26
168	0	15	NewsAPI	The Great Spring 2025 Preview	It’s been a painfully long winter here in New York City, but the glinting promise of spring—and spring books—has bolstered me through these cold, hard months. Here you’ll find just over 100 titles that we’re looking forward to here at The Millions. Some we’ve…	It’s been a painfully long winter here in New York City, but the glinting promise of springand spring bookshas bolstered me through these cold, hard months. Here youll find just over 100 titles that … [+32937 chars]	https://themillions.com/2025/04/the-great-spring-2025-preview.html	https://themillions.com/wp-content/uploads/2025/04/Screen-Shot-2025-04-08-at-12.01.16-PM-1024x570.png	2025-04-11 16:40:19
169	0	15	NewsAPI	Joseph Nye Was the Champion of a World That No Longer Exists	The distinguished scholar, who coined “soft power,” shaped five decades of U.S. foreign policy.	It is poignant yet perhaps fitting to mourn Joseph Nye, the distinguished international relations scholar, just as his lifes work championing U.S. leadership and liberal internationalism has run agro… [+11154 chars]	http://foreignpolicy.com/2025/05/09/joseph-nye-death-us-foreign-policy-soft-power/	https://foreignpolicy.com/wp-content/uploads/2025/05/1-joseph-nye-soft-power-2RP3X9X.jpg?w=1000	2025-05-09 17:08:46
170	0	15	NewsAPI	Albanese has been a ‘proficient and lucky general’. But if he wins a second term, we are right to demand more	Albanese’s prime ministership has been slow but steady. If he’s re-elected, he will need to give Australians a more ambitious plan for the country.	Barring a rogue result, this Saturday Anthony Albanese will achieve what no major party leader has done since John Howards prime-ministerial era win consecutive elections. Admittedly, in those two de… [+17885 chars]	https://theconversation.com/albanese-has-been-a-proficient-and-lucky-general-but-if-he-wins-a-second-term-we-are-right-to-demand-more-235197	https://images.theconversation.com/files/664155/original/file-20250427-56-uark4g.jpg?ixlib=rb-4.1.0&rect=0%2C434%2C5381%2C2690&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-27 20:04:56
171	0	15	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
172	0	15	NewsAPI	Spain and Portugal Blackout: Separating Fact from Fiction	Note: This blog was published May 6, 2025. Last Monday, a widespread power outage hit Spain and Portugal, plunging the region into darkness for about 18 hours before power was restored. Within minutes of the blackout, people with political agendas flooded the…	Note: This blog was published May 6, 2025.\r\nPhoto Credit: Pexels\r\nLast Monday, a widespread power outage hit Spain and Portugal, plunging the region into darkness for about 18 hours before power was … [+6845 chars]	https://blogs.edf.org/climate411/2025/05/06/spain-and-portugal-blackout-separating-fact-from-fiction/	https://blogs.edf.org/climate411/wp-content/blogs.dir/7/files//power-7101420_1280.jpg	2025-05-06 20:14:20
173	0	15	NewsAPI	Does the Covid “Jab” Cause Amyloidosis? Richard C. Cook	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by Dr. Gregory House and …\nThe post Does the Covid “Jab” Cause …	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by … [+9925 chars]	https://www.globalresearch.ca/jab-cause-amyloidosis-richard-cook/5886442	https://www.globalresearch.ca/wp-content/uploads/2021/06/Covid-vaccine-VAERS-061821-feature-800x417.jpg	2025-05-10 12:19:57
174	0	15	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France	ONLY AVAILABLE IN PAID PLANS	https://abcnews.go.com/Business/wireStory/cannes-global-colosseum-film-readies-78th-edition-new-121681980	https://s.abcnews.com/images/Entertainment/wirestory_d289e6798571dd31943dc3d6d3a2d556_4x3_384.jpg	2025-05-11 05:42:14
175	0	15	NewsDATA	Rebecca Solnit: ‘Fiction was always treated as the most important, literary, aspirational goal – f*** that’	The prolific non-fiction writer returns to her favourite themes of hope and uncertainty in her cheerful new book, ‘No Straight Road Takes You There’. In a conversation with Hannah Ewens, she discusses why fiction is overrated, why new age spirituality is a hoax and how a functional social welfare state would encourage women to have children	ONLY AVAILABLE IN PAID PLANS	https://www.independent.co.uk/arts-entertainment/books/rebecca-solnit-author-activist-hay-festival-b2747194.html	https://static.independent.co.uk/2025/05/08/11/46/Rebecca-Solnit.jpeg?crop=1200%3A800&height=800&trim=732%2C0%2C370%2C0&width=1200	2025-05-11 05:00:00
176	0	15	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.nsnews.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
177	0	15	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival, which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films. Cannes, where filmmakers, sales agents and journalists gather from around the world, is the Olympics of the big screen, with its own [...]	ONLY AVAILABLE IN PAID PLANS	https://halifax.citynews.ca/2025/05/11/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon/	https://halifax.citynews.ca/wp-content/blogs.dir/sites/5/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9-1024x699.jpg	2025-05-11 04:11:25
178	0	15	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.richmond-news.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
179	0	15	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.burnabynow.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
180	0	15	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France. That’s not just because of the long list of anticipated films...	ONLY AVAILABLE IN PAID PLANS	https://www.union-bulletin.com/news/national/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the/article_04e837ae-22dc-56ce-8ac0-25071cdc2d66.html	https://bloximages.newyork1.vip.townnews.com/union-bulletin.com/content/tncms/assets/v3/editorial/1/00/10054b5f-8848-583c-87ec-fcb79e9f0688/68202501702a9.image.jpg?resize=300%2C205	2025-05-11 04:06:57
181	0	16	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
182	0	16	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
183	0	16	NewsAPI	Does the Covid “Jab” Cause Amyloidosis? Richard C. Cook	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by Dr. Gregory House and …\nThe post Does the Covid “Jab” Cause …	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by … [+9925 chars]	https://www.globalresearch.ca/jab-cause-amyloidosis-richard-cook/5886442	https://www.globalresearch.ca/wp-content/uploads/2021/06/Covid-vaccine-VAERS-061821-feature-800x417.jpg	2025-05-10 12:19:57
184	0	16	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France	ONLY AVAILABLE IN PAID PLANS	https://abcnews.go.com/Business/wireStory/cannes-global-colosseum-film-readies-78th-edition-new-121681980	https://s.abcnews.com/images/Entertainment/wirestory_d289e6798571dd31943dc3d6d3a2d556_4x3_384.jpg	2025-05-11 05:42:14
185	0	16	NewsDATA	Rebecca Solnit: ‘Fiction was always treated as the most important, literary, aspirational goal – f*** that’	The prolific non-fiction writer returns to her favourite themes of hope and uncertainty in her cheerful new book, ‘No Straight Road Takes You There’. In a conversation with Hannah Ewens, she discusses why fiction is overrated, why new age spirituality is a hoax and how a functional social welfare state would encourage women to have children	ONLY AVAILABLE IN PAID PLANS	https://www.independent.co.uk/arts-entertainment/books/rebecca-solnit-author-activist-hay-festival-b2747194.html	https://static.independent.co.uk/2025/05/08/11/46/Rebecca-Solnit.jpeg?crop=1200%3A800&height=800&trim=732%2C0%2C370%2C0&width=1200	2025-05-11 05:00:00
186	0	16	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.nsnews.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
187	0	16	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival, which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films. Cannes, where filmmakers, sales agents and journalists gather from around the world, is the Olympics of the big screen, with its own [...]	ONLY AVAILABLE IN PAID PLANS	https://halifax.citynews.ca/2025/05/11/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon/	https://halifax.citynews.ca/wp-content/blogs.dir/sites/5/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9-1024x699.jpg	2025-05-11 04:11:25
188	0	16	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.richmond-news.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
189	0	16	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Nowhere is the border-crossing nature of cinema more evident than the Cannes Film Festival , which kicks off Tuesday in the wake of U.S. President Donald Trump’s vow to enact tariffs on international films.	ONLY AVAILABLE IN PAID PLANS	https://www.burnabynow.com/entertainment-news/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the-horizon-10643957	https://www.vmcdn.ca/f/files/shared/feeds/cp/2025/05/d17dda07b2727221ffa2e8e19de904c8dea4aeec7113e233a32116a161854ac9.jpg;w=960	2025-05-11 04:11:25
190	0	16	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France. That’s not just because of the long list of anticipated films...	ONLY AVAILABLE IN PAID PLANS	https://www.union-bulletin.com/news/national/cannes-the-global-colosseum-of-film-readies-for-78th-edition-with-new-challenges-on-the/article_04e837ae-22dc-56ce-8ac0-25071cdc2d66.html	https://bloximages.newyork1.vip.townnews.com/union-bulletin.com/content/tncms/assets/v3/editorial/1/00/10054b5f-8848-583c-87ec-fcb79e9f0688/68202501702a9.image.jpg?resize=300%2C205	2025-05-11 04:06:57
191	0.089	17	NewsAPI	New center at Brown to study the intersection of climate, environment and human health	During a campus conversation to celebrate the launch of the Center for Climate, Environment and Health, panelists explored the impacts of climate change on human health and the research that will drive life-saving solutions.	PROVIDENCE, R.I. [Brown University]  From extreme heat and air pollution to the health effects of chemicals in plastic products, society is confronting historic challenges at the intersection of clim… [+3825 chars]	https://www.brown.edu/news/2025-04-28/climate-environment-health	https://www.brown.edu/sites/default/files/styles/wide_lrg/public/2025-04/20250428_SPH_Barnes-Lecture-and-CCEH-Center-Launch-2900-07.jpg?h=f11e55a2&itok=wPppQwEa	2025-04-29 16:07:34
192	0	17	NewsAPI	Middle-aged Americans report higher loneliness than older adults, global study finds	Middle-aged Americans have demonstrated some of the highest levels of loneliness in a new study assessing tens of thousands of 50-to-90-year-olds across 29 countries.	Middle-aged Americans have demonstrated some of the highest levels of loneliness in a new study assessing tens of thousands of 50-to-90-year-olds across 29 countries.\r\nThe research, published in Agin… [+5238 chars]	https://medicalxpress.com/news/2025-04-middle-aged-americans-higher-loneliness.html	https://scx2.b-cdn.net/gfx/news/hires/2022/old-person-lonely.jpg	2025-04-22 04:49:23
193	0.167	18	NewsAPI	How Donald Trump Upended US Foreign Policy in 100 Days	"It's been one of the most exciting starts to a new presidential term since Gorbachev," academic Barry Scott Zellen told Newsweek.	President Donald Trump is "redrawing the world map" with his foreign policy, driven by his "America first" stance, his anti-globalist position, his "like" for provoking America's allies and his desir… [+10883 chars]	https://www.newsweek.com/donald-trump-foreign-policy-100-days-2064942	https://d.newsweek.com/en/full/2626627/trump-upended-foreign-policy-100-days.png	2025-04-29 11:38:26
194	0	18	NewsAPI	Joseph Nye Was the Champion of a World That No Longer Exists	The distinguished scholar, who coined “soft power,” shaped five decades of U.S. foreign policy.	It is poignant yet perhaps fitting to mourn Joseph Nye, the distinguished international relations scholar, just as his lifes work championing U.S. leadership and liberal internationalism has run agro… [+11154 chars]	http://foreignpolicy.com/2025/05/09/joseph-nye-death-us-foreign-policy-soft-power/	https://foreignpolicy.com/wp-content/uploads/2025/05/1-joseph-nye-soft-power-2RP3X9X.jpg?w=1000	2025-05-09 17:08:46
195	0	18	NewsAPI	The Thucydides Trap: Vital lessons from ancient Greece for China and the US … or a load of old claptrap?	Is a US-China war inevitable? Perhaps that isn’t the lesson leaders should be taking from the ‘History of the Peloponnesian War.’	Retreat of the Athenians from Syracuse during a battle of the Peloponnesian War, from Cassell's 'Universal History,' published in 1888. Ken Welsh/Design Pics/Universal Images Group via Getty Images)\r… [+5523 chars]	https://theconversation.com/the-thucydides-trap-vital-lessons-from-ancient-greece-for-china-and-the-us-or-a-load-of-old-claptrap-252954	https://images.theconversation.com/files/660272/original/file-20250407-56-uua5y5.jpg?ixlib=rb-4.1.0&rect=0%2C313%2C5981%2C2990&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-15 12:27:01
196	0	18	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
197	0	18	NewsDATA	China Pressuring African Nations Over US Trade Deals	Beijing is wary that the Trump administration will use tariffs, to erode the communist regime's power in Africa.	ONLY AVAILABLE IN PAID PLANS	https://www.theepochtimes.com/world/china-pressuring-african-nations-over-us-trade-deals-5852225	https://img.theepochtimes.com/assets/uploads/2025/04/18/id5844119-Minerals-AFrica-botswana-1080x720.jpg	2025-05-11 10:00:55
198	0	18	NewsDATA	Cannes, the global Colosseum of film, readies for 78th edition with new challenges on the horizon	Perhaps as much as ever, all eyes in the movie world will be on the 78th Cannes Film Festival when it gets underway Tuesday in the South of France.	ONLY AVAILABLE IN PAID PLANS	https://www.newsday.com/entertainment/cannes-film-festival-2025-what-to-expect-r68181	https://www.newsday.com/_next/image?q=80&url=https%3A%2F%2Fcdn.newsday.com%2Fimage-service%2Fversion%2Fc%3AMDlmY2RhNjItNDgzMS00%3AOTFjYTNkMGUtNzQzMC00%2Fcannes-preview.jpeg%3Ff%3DLandscape%2B16%253A9%26w%3D768%26q%3D1&w=1920	2025-05-11 00:10:41
199	0.152	19	NewsDATA	SoundCloud says it's never trained AI using artists' work after getting called out for terms of use change	Following backlash about a quietly added clause to SoundCloud's Terms of Use that says users' content may be fed to AI, the company says it's "never used artist content to train AI models," and insists it "has always been and will remain artist-first." The outrage came after tech ethicist Ed Newton-Rex (via TechCrunch) spotted a change to SoundCloud's terms that was made in February 2024 seemingly without notifying users. The updated text states that by using the platform, "You explicitly agree that your Content may be used to inform, train, develop or serve as input to artificial intelligence or machine intelligence technologies or services as part of and for providing the services."In a statement to TechCrunch, a spokesperson said the update was only meant to "clarify how content may interact with AI technologies within SoundCloud's own platform" and that the company "has never used artist content to train AI models, nor do we develop AI tools or allow third parties to scrape or use SoundCloud content from our platform for AI training purposes." SoundCloud's official Reddit account posted similar statements on the social media platform in response to users' outrage, and both noted that SoundCloud added a "no AI" tag for artists "to explicitly prohibit unauthorized use."AI may be used for things like music recommendations, playlist creation and fraud detection, the company said. "Any future AI tools will be built for artists to enhance discovery, protect rights, and expand opportunities," SoundCloud posted on Reddit. "We hear your concerns and remain committed to transparency, artist control, and fair use."Just a few months ago, though, SoundCloud introduced a suite of AI tools geared toward music creation, on top of three others it had announced earlier that year. That includes AI tools for generating remixes, new tracks, beats and singing voices.This article originally appeared on Engadget at https://www.engadget.com/ai/soundcloud-says-its-never-trained-ai-using-artists-work-after-getting-called-out-for-terms-of-use-change-174433356.html?src=rss	ONLY AVAILABLE IN PAID PLANS	https://www.engadget.com/ai/soundcloud-says-its-never-trained-ai-using-artists-work-after-getting-called-out-for-terms-of-use-change-174433356.html	https://s.yimg.com/ny/api/res/1.2/p1WWnit_Pbg9yBT5vSLBLQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTY0MA--/https://s.yimg.com/os/creatr-uploaded-images/2025-05/42618880-2e8d-11f0-96f7-a69b0653f9ce	2025-05-11 17:44:33
200	0.145	19	NewsAPI	Ask the ethicist: How to create guardrails for the AI age	Will AI devastate humanity or uplift it? Philosopher Christopher DiCarlo's new book examines how we can navigate when AI surpasses human capacity.	Will AI devastate humanity or uplift it? Philosopher Christopher DiCarlo's new book examines how we can navigate when AI surpasses human capacity.\r\nGuest\r\nChristopher DiCarlo, philosopher, educator a… [+171 chars]	https://www.wbur.org/onpoint/2025/04/25/ethics-ai-artificial-intelligence-human	https://wordpress.wbur.org/wp-content/uploads/2025/04/GettyImages-2210697115-1000x667.jpg	2025-04-25 16:41:11
201	0.073	19	NewsAPI	SoundCloud changes policies to allow AI training on user content | TechCrunch	SoundCloud appears to have quietly changed its terms of use to allow the company to train AI on audio that users upload to its platform.	SoundCloud appears to have quietly changed its terms of use to allow the company to train AI on audio that users upload to its platform. \r\nAs spotted by tech ethicist Ed-Newton Rex, the latest versio… [+2375 chars]	https://techcrunch.com/2025/05/09/soundcloud-changes-policies-to-allow-ai-training-on-user-content/	https://techcrunch.com/wp-content/uploads/2024/05/Black-SoundCloud-Logo-Horizontal-1-1.jpg?w=1080	2025-05-09 17:20:49
202	0.073	19	NewsDATA	Pope Leo XIV speaks out against AI: ‘A challenge of human dignity, justice and labour’	New leader of the Catholic Church says AI poses challenge to humankind and dignity of workers	ONLY AVAILABLE IN PAID PLANS	https://ca.news.yahoo.com/pope-leo-xiv-speaks-against-184204153.html	https://media.zenfs.com/en/the_independent_577/7dea3b905f9fbf6de120a32852a2cfc1	2025-05-10 18:42:04
205	0	19	NewsAPI	Everyone Is Cheating Their Way Through College	In only two years, ChatGPT and the surge of AI-generated cheating from college students it has created have unraveled the entire academic project.	Chungin Roy Lee stepped onto Columbia Universitys campus this past fall and, by his own admission, proceeded to use generative artificial intelligence to cheat on nearly every assignment. As a comput… [+31718 chars]	http://nymag.com/intelligencer/article/openai-chatgpt-ai-cheating-education-college-students-school.html	https://pyxis.nymag.com/v1/imgs/bed/906/0c7c764b8c807add6e1a8f638b43ce2029-chat-gpt-college-lede.1x.rsocial.w1200.gif	2025-05-07 09:00:23
206	0	19	NewsDATA	Global Pressure Mounts On Nigerian OpenAI Board Member Over AI Profit Push	ABUJA: A global campaign is intensifying against the for-profit transition of OpenAI, with pressure squarely mounting on Nigerian billionaire and investment banker, Adebayo Ogunlesi, who joined OpenAI’s board in January 2025. Over 110,000 people worldwide have signed a petition urging Ogunlesi to leverage his influence on the board to block OpenAI’s controversial shift from a [...]	ONLY AVAILABLE IN PAID PLANS	https://independent.ng/global-pressure-mounts-on-nigerian-openai-board-member-over-ai-profit-push/	https://independent.ng/wp-content/uploads/IMG-20250511-WA0010.jpg	2025-05-11 12:12:05
207	0.206	20	NewsAPI	Trump White House Ends Federal Committee Tasked With Creating Health Guidelines	The termination of the committee will also reduce transparency within the Department of Health and Human Services.	The Trump administration has reportedly terminated members of a health committee that provides guidance on limiting the spread of diseases to government agencies and hospitals across the country.\r\nAc… [+5420 chars]	https://truthout.org/articles/trump-white-house-ends-federal-committee-tasked-with-creating-health-guidelines/	https://truthout.org/app/uploads/2025/05/2025_0507-cdc-scaled.jpg	2025-05-07 18:43:45
208	0.144	20	NewsDATA	RFK Jr. Insists He Hasn't Fired 'Any Working Scientists' ― After Firing Hundreds Of Them	!function(n){if(!window.cnx){window.cnx={},window.cnx.cmd=[];var t=n.createElement('iframe');t.display='none',t.onload=function(){var n=t.contentWindow.document,c=n.createElement('script');c.src='//cd.connatix.com/connatix.player.js',c.setAttribute('async','1'),c.setAttribute('type','text/javascript'),n.body.appendChild(c)},n.head.appendChild(t)}}(document);(new Image()).src = 'https://capi.connatix.com/tr/si?token=ff7fdddc-5441-4253-abc4-f12a33fad58b';cnx.cmd.push(function(){cnx({"playerId":"ff7fdddc-5441-4253-abc4-f12a33fad58b","mediaId":"a9a81e09-00a0-4e9f-8a6a-b8fd4bf6ef01"}).render("6826ced7e4b01633824e10ec");});During a Senate committee hearing, Senator Angela Alsobrooks had a strange clash with Health and Human Services Secretary Robert F. Kennedy Jr. over the massive cuts he’s overseen at his agency, including to personnel.“You made it very clear here today you have no knowledge whatsoever of the absolutely amazing scientists and researchers who you have callously fired,” said Alsobrooks.“I didn’t fire any working scientists,” Kennedy said.“That, sir, is not true either,” replied Alsobrooks.“It is true,” repeated Kennedy“It is not true,” Alsobrooks said, moving on.He made the same claim when the Maryland senator later brought up a 30-year programme he axed at his agency, the Safe to Sleep campaign, along with all of its staff. He said it again to Senator Bill Cassidy, the chairman of the committee, at the start of the hearing.“The cuts we have made to date are administrative cuts. As far as I know we have not fired any working scientists,” said Kennedy. “There are some people who were scientists that were doing IT or administration ... who did lose their jobs. But in terms of working scientists, our policy was to make sure none of them were lost and that that research continues.”That sounds nice. But also it is not true. Kennedy has been firing hundreds, if not thousands, of scientists and researchers doing critical work at various agencies under HHS. It’s not even as if he’s been doing this in secret; it’s been widelyreported for months.Under his direction, the National Institutes of Health, the world’s top biomedical research agency, axed 1,200 employees in February. A doctor behind award-winning research on Parkinson’s disease was among the leading NIH scientists pushed out in April. Top scientific leaders at the National Institute of Allergy and Infectious Diseases and at the Food and Drug Administration were reassignedto remote Indian Health Service regions. Key scientists working on the bird flu at the Center for Veterinary Medicine were fired, as were nearly a dozen in-house senior scientists at NIH who worked on neuroscience.The Centres for Disease Control and Prevention last month carried out mass firings that included a group of scientists who researched traumatic brain injury. Still more CDC scientists were fired after their entire lab tracking STIs and hepatitis outbreaks was axed.It’s not clear if Kennedy is intentionally lying about not firing scientists or doesn’t understand the scope of damage he’s causing to the work of HHS, or if this a matter of semantics. Maybe he’s bristling at the verb “fire” to describe how he has been aggressively dismissing scientists from their employment or ordering scientists to give up their jobs.An HHS spokesperson did not immediately respond to a request for comment.Alsobrooks said Kennedy is just lying, even as it’s so absurdly obvious.“I think that RFK Jr. clearly believes that the more he tells a lie, the more it becomes the truth,” she told HuffPost on Thursday.Kennedy’s claim that HHS scientists have all kept their jobs “flies in the face of the reality that there are hundreds of scientists from the NIH, CDC and FDA who have lost their jobs as a part of his plan to overhaul the department.”Health and Human Services Secretary Robert F. Kennedy Jr. bizarrely claimed he hasn't fired "any working scientists" at HHS, after firing hundreds, if not thousands of them.The Maryland senator should know. NIH is based in her state, and she’s been hearing from scientists ― constituents ― for months who have lost their jobs or grants at various HHS agencies. She heard from some of those fired scientists after Wednesday’s hearing, when Kennedy insisted he hadn’t fired them.“One is working specifically – or was working, before his untimely termination – on Parkinson’s, and the other was working on doing some critical research around hepatitis,” said Alsobrooks. “They heard the lie, you know, or the misrepresentation, should we call it, when he said working scientists had not been fired when they, in fact, have been.”HuffPost heard from some fired federal scientists after Kennedy’s hearing, too. One, who’d been an epidemiologist working on infectious diseases, said they were fired by Kennedy along with their entire team, which was dozens of epidemiologists and health scientists.“RFK seems unaware of what programs were actually affected by the [Reduction in Force],” said this scientist, who requested anonymity to speak freely.Asked what they made of Kennedy’s repeated claims that he hadn’t fired any “working scientists,” this fired scientist simply said, “It is not true.”“This has consequences for public health as the programs are suddenly eliminated or severely reduced,” they said. “It also severely affects the thousands of scientists who suddenly lost our careers and faced a challenging job market with so many public health cuts damaging our field.” RFK Jr. clearly believes that the more he tells a lie, the more it becomes the truth.Sen. Angela Alsobrooks (D-Md.)A local chapter of the American Federation of Government Employees, a union that represents more than 700,000 federal employees and D.C. government workers, caught Kennedy’s comments, and pushed back with data and charts.“We find that approximately 1,586 civil servants affected by the RIF were scientists, medical professionals, veterinary professionals, engineers, and other STEM leaders,” reads a Wednesday post on AFGE Local 2883’s website. “These cuts were scientific, not administrative and not ‘fraud, waste, and abuse.’”Their website offers lots of data related to HHS cuts, including on personnel cuts at CDC. One chart, for example, offers a rough estimate on the number of health scientists who have been fired as of mid-March: 605.Alsobrooks said she hopes that any fired federal scientists who heard Kennedy’s claims know that she and other senators see through his nonsense and plan to keep highlighting the damage he’s causing.“We know the truth,” she said. “That’s what these hearings are about, exposing these mistruths and letting the public understand the consequences of the disastrous decisions and dangerous decisions made by Secretary Kennedy. And we’re going to continue to do that.”	ONLY AVAILABLE IN PAID PLANS	https://www.huffingtonpost.co.uk/entry/rfk-jr-insists-he-hasnt-fired-any-working-scientists-after-firing-hundreds-of-them_uk_6826ced7e4b01633824e10eb	https://img.huffingtonpost.com/asset/68263d3b190000160097f6b7.jpeg?cache=UhjjD04kI5	2025-05-16 05:38:55
209	0.133	20	NewsAPI	STIs are increasing in Australia. Can anything lower these rates?	Sexual transmitted infections have continued to grow across Australia over the last three decades, with chlamydia, gonorrhoea and syphilis spiking in New South Wales alone. The reasons why are complex, experts say.	Over the last three decades, sexually transmitted infections (STIs) have quietly but steadily climbed in Australia, with bacterial diseases like chlamydia, gonorrhoea, and syphilis spreading across t… [+7481 chars]	https://www.abc.net.au/news/2025-04-19/sti-increasing-australia-lower-rates/105169548	https://live-production.wcms.abc-cdn.net.au/5d04312e0cd5d3f5ef8776f8921b7e0b?impolicy=wcms_watermark_news&cropH=3942&cropW=7008&xPos=0&yPos=292&width=862&height=485&imformat=generic	2025-04-18 20:53:09
210	0.067	20	NewsDATA	Health Minister launches anti-dengue drive, says ‘army’ deployed to combat mosquitoes	In an effort to curb the spread of dengue, Punjab Health Minister Dr Balbir Singh on Thursday led a statewide awareness campaign from Patiala, with health officials, civic staff and community members under the banner of ‘National Dengue Day’. The campaign focused on eliminating mosquito breeding grounds and sensitising the public to the dangers of [...]	ONLY AVAILABLE IN PAID PLANS	https://www.tribuneindia.com/news/aedesaegypti/health-minister-launches-anti-dengue-drive-says-army-deployed-to-combat-mosquitoes	https://www.tribuneindia.com/sortd-service/imaginary/v22-01/webp/medium/high?url=dGhldHJpYnVuZS1zb3J0ZC1wcm8tcHJvZC1zb3J0ZC9tZWRpYTQ5NzZkNjAwLTMyMmMtMTFmMC04NDBiLTBkMWUyZGMyZWRkYi5qcGc%3D	2025-05-16 08:02:55
211	0	20	NewsAPI	First meeting of CDC vaccine advisers under RFK Jr. is mostly 'business as usual'	An independent vaccine advisory committee to the Centers for Disease Control and Prevention met to discuss and vote on vaccine policy for the first time since the change in administrations.	Despite concerns that the administration might meddle with a committee of vaccine advisers to the Centers for Disease Control and Prevention, their first public meeting since President Trump's inaugu… [+6629 chars]	https://www.npr.org/sections/shots-health-news/2025/04/16/nx-s1-5366868/cdc-vaccine-meeting-rfk	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3935x2213+0+63/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F87%2F85%2F28a0924f418ba1e49204de0b30a7%2Fgettyimages-1210839842.jpg	2025-04-16 22:35:31
212	0	20	NewsAPI	Early-life exposure to air and light pollution linked to increased risk of pediatric thyroid cancer	A new study suggests that early-life exposure to two widespread environmental pollutants -- small particle air pollution and outdoor artificial light at night -- could increase the risk of pediatric thyroid cancer. The study found a 'significant association' …	A new study led by researchers at Yale University suggests that early-life exposure to two widespread environmental pollutants -- small particle air pollution and outdoor artificial light at night --… [+4676 chars]	https://www.sciencedaily.com/releases/2025/04/250418112904.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-04-18 15:29:04
213	0	20	NewsAPI	Measles case confirmed in traveler who visited multiple Washington locations, public health officials warn	Public health officials in Washington state are warning residents that a Canadian traveler who was contagious with measles visited several public locations, including the Seattle-Tacoma International Airport.	Public health officials in Washington state are warning residents that a Canadian traveler who was contagious with measles visited several public locations, including the Seattle-Tacoma International… [+2377 chars]	https://nypost.com/2025/05/15/health/measles-case-confirmed-in-washington-officials-warn/	https://nypost.com/wp-content/uploads/sites/2/2025/05/Untitled-1_200907.jpg?quality=75&strip=all&w=1024	2025-05-15 11:23:45
214	0	20	NewsAPI	What Science Says About Food Additives	RFK Jr. has said the U.S. should end the use of synthetic food additives. How would that affect public health?	Yves here. This post usefully goes a bit deeper into the regulatory system for food additives. It should come as no surprise that in the US, it remarkably permissive.\r\nThe article alludes to but does… [+23990 chars]	https://www.nakedcapitalism.com/2025/04/what-science-says-about-food-additives.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/04/00-food-additive.jpg	2025-04-23 13:55:54
215	0	20	NewsAPI	Louisiana, Missouri and Virginia report first measles cases of 2025	Louisiana, Missouri and Virginia have all reported their first measles cases in 2025, and they say all three patients’ cases are linked to international travel.	Louisiana, Missouri and Virginia have all reported their first measles cases in 2025, and they say all three patients cases are linked to international travel.\r\nThe most recently announced case in no… [+2927 chars]	https://www.nbcnews.com/news/us-news/louisiana-missouri-virginia-report-first-measles-cases-2025-rcna202038	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2025-03/250311-measles-ch-1302-700353.jpg	2025-04-20 19:37:38
216	0	20	NewsAPI	The Future Of Researchers In The U.S. Is In Jeopardy	Funding cuts are having a devastating toll on researchers' careers and personal lives. It will hurt the US' future innovation. We need to bring science-based decisions back.	UCLA students, researchers and demonstrators rally during a "Kill the Cuts" protest against the ... More Trump administration's funding cuts on research, health and higher education at the University… [+5582 chars]	https://www.forbes.com/sites/judystone/2025/05/01/the-future-of-researchers-in-the-us-is-in-jeopardy/	https://imageio.forbes.com/specials-images/imageserve/68114e6311f932e9e04eb19e/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 17:15:00
217	0	20	NewsAPI	Psilocybin use is on the rise as public perception changes, report shows	More Americans are using psilocybin, the hallucinogenic compound found in psychedelic mushrooms.	More Americans are using psilocybin, the hallucinogenic compound found in psychedelic mushrooms.\r\nA report published Monday in the journal Annals of Internal Medicine found psilocybin use has been ri… [+4181 chars]	https://www.nbcnews.com/health/health-news/psilocybin-use-rise-public-perception-changes-report-shows-rcna202201	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2023-10/231028-psilocybin-mushrooms-mjf-1653-29db3d.jpg	2025-04-21 21:01:41
218	0	20	NewsAPI	Florida bans fluoride in public water, prioritizing health freedom over forced medication	Florida has banned fluoride in public drinking water, becoming the second U.S. state to do so, citing concerns over health risks and personal choice. Gov. DeSantis and health officials framed the ban as a victory for informed consent, opposing “forced medicat…	<ul><li>Florida has banned fluoride in public drinking water, becoming the second U.S. state to do so, citing concerns over health risks and personal choice.</li><li>Gov. DeSantis and health official… [+4177 chars]	https://www.naturalnews.com/2025-05-07-florida-bans-fluoride-public-water.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Water-Running-Tap-Fluoride-1.jpg	2025-05-07 06:00:00
219	0	20	NewsAPI	Elon Musk Is an Evil Piece of Garbage—and an A-Level Fraud Too	When I was growing up in Morgantown, West Virginia, I remember very well when that new building went up at the end of Willowdale Road, near the West Virginia University Medical Center and not too far from my friend Doug’s house.\r\nThese days, Morgantown—driven…	As Musk steps back from DOGE, were getting a number of assessments of his accomplishments. Theyre generally harsh. He vowed to slash $2 trillion in wasteful federal spending (the federal government s… [+2389 chars]	https://newrepublic.com/article/194769/elon-musk-evil-garbage-fraud	https://images.newrepublic.com/5a2e2e488ea300bb18fc84de8e1e2decf68ee5a9.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-05-02 14:35:40
220	0	20	NewsAPI	The WHO Is Fighting A Multi-Country Outbreak Of Cholera	A new outbreak in Angola , West Africa started on January 7, 2025, and it is likely to get worse as it spreads to more rural regions.	Patient being transported to the Cholera Treatment Center in the Paraíso neighborhood, Luanda ... More Province, Angola, January 2025\r\nJoao Carlos Domingos\r\nCholera is making a comeback. A new outbre… [+8191 chars]	https://www.forbes.com/sites/markkortepeter/2025/04/23/the-who-is-fighting-a-multi-country-outbreak-of-cholera/	https://imageio.forbes.com/specials-images/imageserve/68084583b518f5da26b2207b/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-23 12:00:00
221	0	20	NewsAPI	Hello measles, my old friend: The return of previously vanquished vaccine-preventable diseases	A study published last week suggests that, if vaccine uptake continues to decline, measles will soon be endemic again in the US. It's just part of how RFK Jr. is making America sicker again.\nThe post Hello measles, my old friend: The return of previously vanq…	When a country puts an antivaxxer and supporter of quackery whose worldview with respect to medicine and biomedical science is as utterly divorced from science and reality as that of longtime antivax… [+30269 chars]	https://sciencebasedmedicine.org/hello-measles-my-old-friend-the-return-of-previously-vanquished-vaccine-preventable-diseases/	https://sciencebasedmedicine.org/wp-content/uploads/2025/04/Measles.jpg	2025-04-28 07:00:00
222	0	20	NewsAPI	Greek study shakes global health narratives: Nearly half of COVID deaths not linked to virus	A Greek study published in Scientific Reports found that nearly half (45.3%) of deaths classified as COVID-19-related in Athens hospitals in 2022 were actually due to other causes, with only 25.1% directly caused by SARS-CoV-2. Death certificates and hospital…	<ul><li>A Greek study published in Scientific Reports found that nearly half (45.3%) of deaths classified as COVID-19-related in Athens hospitals in 2022 were actually due to other causes, with only … [+5804 chars]	https://www.naturalnews.com/2025-04-24-nearly-half-covid-deaths-not-linked-virus.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/04/Fake-News-Fact-Truth-Myth-Rumor-Fiction.jpg	2025-04-24 06:00:00
223	0	20	NewsAPI	Pandemic Patterns Explored in The Fire This Time	New from Field of Vision, Mariam Ghani’s film The Fire This Time is a stunning visual and historic investigation into the intertwined histories of pandemics, riots, and colonial violence.	From award-winning artist, writer, and filmmaker Mariam Ghani, The Fire This Time chronicles centuries of data to contextualize a world recently struck by global pandemics.\r\nBuilt from three historic… [+2281 chars]	http://hyperallergic.com/1012608/pandemic-patterns-the-fire-this-time-mariam-ghani-field-of-vision/	https://i0.wp.com/hyperallergic-newspack.s3.amazonaws.com/uploads/2025/05/Untitled-2.jpg?fit=2400%2C1350&quality=90&ssl=1	2025-05-14 18:04:00
224	0	20	NewsAPI	HHS, NIH waste $500 million on failed universal vaccine scheme as respiratory viruses continue to mutate beyond vaccine efficacy	The U.S. government is doubling down on failed vaccine science, pouring half a billion taxpayer dollars into a futile quest for “universal” vaccines against influenza and coronaviruses. The Department of Health and Human Services (HHS) and National Institutes…	The U.S. government is doubling down on failed vaccine science, pouring half a billion taxpayer dollars into a futile quest for "universal" vaccines against influenza and coronaviruses. The Departmen… [+6427 chars]	https://www.naturalnews.com/2025-05-02-hhs-nih-waste-500-million-on-failed-universal-vaccine-scheme.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Hand-in-blue-medical-gloves-holds-an-ampoule.jpeg	2025-05-02 06:00:00
225	0	20	NewsAPI	Breakthrough study links mRNA vaccines to irreversible female fertility loss	A peer-reviewed Turkish study found mRNA vaccines caused a 60% reduction in primordial follicles (fertility-critical egg cells) in rats, with inactivated vaccines showing a 34% decline. These cells are non-renewable, suggesting potential permanent fertility l…	<ul><li>A peer-reviewed Turkish study found mRNA vaccines caused a 60% reduction in primordial follicles (fertility-critical egg cells) in rats, with inactivated vaccines showing a 34% decline. These… [+6630 chars]	https://www.naturalnews.com/2025-05-15-mrna-vaccines-linked-to-irreversible-female-fertility-loss.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/Thumbs-Down-Pregnant-Vaccine-Covid.jpg	2025-05-15 06:00:00
226	0	20	NewsAPI	The Pandemic Justice Phase Begins as Criminal Investigations Commence	In this explosive episode of Focal Points, I sit down with two fearless attorneys from Vires Law Group—Rachel Rodriguez and Mimi Miller—who are leading a historic legal effort to hold top public health officials accountable for their actions during …\nThe post…	In this explosive episode of Focal Points, I sit down with two fearless attorneys from Vires Law GroupRachel Rodriguez and Mimi Millerwho are leading a historic legal effort to hold top public health… [+7199 chars]	https://www.globalresearch.ca/pandemic-justice-phase-begins-criminal-investigations-commence/5884927	https://www.globalresearch.ca/wp-content/uploads/2024/06/public-truth-covid-vaccines.jpeg	2025-04-22 15:44:42
\.


--
-- Data for Name: fav_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fav_articles (id, score, question_id, api_source, title, description, content, url, "urlToImage", "publishedAt", article_id, user_id) FROM stdin;
\.


--
-- Data for Name: fav_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fav_videos (id, question_id, youtube_id, description, thumbnail, video_id, user_id) FROM stdin;
1	16	EUowNpYL120	An introduction to #geopolitics. What it is, and how it can be applied in #statecraft. If you want to learn more about geopolitical ...	https://i.ytimg.com/vi/EUowNpYL120/hqdefault.jpg	75	1
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
173	1	1
171	2	1
13	3	1
14	4	1
74	5	1
\.


--
-- Data for Name: hidden_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_questions (question_id, id, user_id) FROM stdin;
14	1	1
7	2	2
13	3	1
6	4	1
7	5	1
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
1	1	How can we accurately measure the long-term impacts of climate change on biodiversity?	term impacts, climate change, accurately measure, long, biodiversity	0
2	1	What sustainable technologies can effectively reduce greenhouse gas emissions from agriculture?	sustainable technologies, agriculture	1
3	1	How can environmental policies be designed to ensure equitable climate change adaptation?	environmental policies, designed	2
4	2	How can we ensure AI systems reflect diverse values and avoid reinforcing societal biases?		0
5	2	What accountability mechanisms are needed when AI systems cause harm or make unfair decisions?	make unfair decisions, accountability mechanisms, needed	1
6	2	How do we balance AI innovation with protecting individual privacy and autonomy?	protecting individual privacy, balance ai innovation, autonomy	2
7	3	How can epidemiological studies better address health disparities in marginalized communities?	marginalized communities	0
8	3	What novel data sources can enhance real-time disease surveillance and outbreak prediction?	time disease surveillance, novel data sources, outbreak prediction, enhance real	1
9	3	How can we improve communication of epidemiological findings to influence public health policy?	improve communication, epidemiological findings	2
10	4	How do geopolitical risks influence asset allocation strategies in emerging markets?	emerging markets	0
11	4	What's the predicted impact of rising interest rates on corporate bond valuations?	rising interest rates, corporate bond valuations, predicted impact	1
12	4	Which alternative data sources provide the most predictive signals for equity performance?	predictive signals, equity performance	2
13	5	How do domestic political institutions shape a state's geopolitical strategy?	geopolitical strategy, state	0
14	5	To what extent does great power competition impact democratic norms globally?	extent	1
15	5	How do transnational identities challenge traditional geopolitical assumptions?		2
16	5	How do domestic political institutions shape a state's geopolitical strategy and decision-making?	geopolitical strategy, state, making, decision	1
17	3	How can epidemiological methods better address complex social determinants of health inequalities?	health inequalities	0
18	5	How do domestic political institutions shape a state's geopolitical strategy and foreign policy choices?	foreign policy choices, geopolitical strategy, state	0
19	2	How can we ensure AI systems reduce bias instead of amplifying existing societal inequalities?		2
20	3	How can epidemiological models better predict and mitigate the spread of emerging infectious diseases across diverse populations?	spread, mitigate	0
\.


--
-- Data for Name: refresh; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh (question_id, id, user_id) FROM stdin;
16	1	1
17	2	2
18	3	1
19	4	1
20	5	1
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, title, role, images) FROM stdin;
1	Climate Change	Environmental Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T180941Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6492608c666de9e003c34dcca43b440fbdf8caaa51cb45d2f4a561829403c36a,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T180943Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=a568a9d620eb7ebef0961e62e4c2ffc91d935ae30daf2ba650b3aab563dc49d6,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T180944Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4b9f89ac5c1918dbb47db67b8256e202f348cd98a9cf1fa59724e63b4adcfd3d}
2	Artificial Intelligence	AI Ethicist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T180953Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5ac6fcb1158c21624e3b9328c94f83c477ef1e30a5f958ab3bea76324b90bcbb,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T180954Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=63a9b5f9e0e780f6cb0bfc671f6ec7dffb64e029f9d5dae73100e73b3f9c21ab,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T180955Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=da23878c34901d45d270b839cf3933cd61f4f9e7acc9291b84e50e8d8869d33b}
3	Public Health	Epidemiologist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181003Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=386f27aa350eb2275e1df90e165fdd8cff2cdcb6702899a6ad62bee7933c5ca3,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181004Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=db5254cdfa75fcb533e2effd4e6a034be552000fcee021354e587903f282651b,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181005Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=18bd2400ed66f474bc3629c60c6dd5cd6cf093859ad2c9ceb2515abc305ecd31}
4	Financial Markets	Financial Analyst	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181014Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ccb0e2239fe11421269f2637af04ceade7aa6ccd4f0b244ca088595ca28ff9bd,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181015Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=72b081e205e2313da8e8ee0c471d62c498935ec4354fcc1efd094fccab92245e,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181016Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d3f4baf0bbdb0310446cc40fdb3bd54cca50e1e39fb4d1243bfd832ab10f3d0e}
5	Geopolitics	Political Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181025Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f8fb21f39826e74e328c9c0f7cc294f5b1bf397f236c4359630f9b024f67fa9f,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181026Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d3540626dfb05ba882d6c7df7aa5b7dd8c8d81fd2d49d1785296a5e441ab25fb,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250511%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250511T181027Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=7c97b5cadf2834531a3913231e923d0a0851397fa3930527ea9cd299d2e95cb2}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, created_at, is_active) FROM stdin;
1	will	wfotso21@gmail.com	scrypt:32768:8:1$kpskdmWNxMN7cuIl$996d3e248ce2f6aff63e3a616bbbd2b533312d9a720f09bfcd151018706ce5ea4483d76af9048f91429c4bc5644e22d84dde95869dbcae138326efa061efebe8	2025-05-11 18:11:48.568194	t
2	creep	will.fotso.pro@gmail.com	scrypt:32768:8:1$3yCpwZE5CwuYSd0m$01b46056dd590d8764d927120c8bb6ce105fad15a9cfd783ede8a3cd58f64b5292e98776dddad4f2a88052504030ba28da35457cd1c124d2ce998cfe82281221	2025-05-11 22:56:44.882762	t
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videos (id, question_id, youtube_id, description, thumbnail) FROM stdin;
1	1	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
2	1	G4H1N_yXBiA	What causes climate change (also known as global warming)? And what are the effects of climate change? Learn the human ...	https://i.ytimg.com/vi/G4H1N_yXBiA/hqdefault.jpg
3	1	N6t6QHQtdVw	Climate | How To Keep The Environment Safe? | Global Warming | Climate Change | What Causes Global Warming?	https://i.ytimg.com/vi/N6t6QHQtdVw/hqdefault.jpg
4	1	8Ns9nEIPAho	Scientists in North America are measuring centuries of glacial runoff, by collecting data from plants underwater. It is part of an ...	https://i.ytimg.com/vi/8Ns9nEIPAho/hqdefault.jpg
5	1	yy3VK6OYBbU	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/yy3VK6OYBbU/hqdefault.jpg
6	2	iG7sskGIWl4	One of the sessions at our Farming and Climate Change conference looked closely at the science of agricultural emissions and ...	https://i.ytimg.com/vi/iG7sskGIWl4/hqdefault.jpg
7	2	agudRES2Jcc	Have a burning question about energy? Our past, present or energy future? This week, our question was submitted by a high ...	https://i.ytimg.com/vi/agudRES2Jcc/hqdefault.jpg
8	2	_0sh4h8NnFo	Visit https://www.nuigalway.ie/science-engineering/postgraduateprogrammes/ to learn more about our postgraduate programmes.	https://i.ytimg.com/vi/_0sh4h8NnFo/hqdefault.jpg
9	2	x7yrPbD3mBE	Dr. Christopher Gambino, former assistant professor of Animal Science at Delaware Valley University, presents his findings on the ...	https://i.ytimg.com/vi/x7yrPbD3mBE/hqdefault.jpg
10	2	B9x3arIwTwk	A new study finds a dangerous side effect of warming: higher arsenic levels in rice that could impact billions.	https://i.ytimg.com/vi/B9x3arIwTwk/hqdefault.jpg
11	3	YaDvCBnuUqg	Thomas Lyon, Director of Erb Institute for Global Sustainable Enterprise at the University of Michigan, describes climate change as ...	https://i.ytimg.com/vi/YaDvCBnuUqg/hqdefault.jpg
12	3	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
13	3	ph439t-kTIE	Since the industrial revolution, as human technology has advanced, the environment has suffered. Dan Hammer is looking to turn ...	https://i.ytimg.com/vi/ph439t-kTIE/hqdefault.jpg
14	3	nfRxGGl6wOU	Laprisha Berry Daniels' grandparents left the Southern United States and migrated north to Detroit in the 1950s — a move that ...	https://i.ytimg.com/vi/nfRxGGl6wOU/hqdefault.jpg
15	3	9dZgJt0R-DU	Shanlea is 16. In her talk, "The Psychology Behind Climate Change", she will be discussing the psychological barriers preventing ...	https://i.ytimg.com/vi/9dZgJt0R-DU/hqdefault.jpg
16	4	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
17	4	gyaG-tFF5FA	How to Become an AI Ethics Professional. Here's a career transition guide for technologists. What do you want to learn, or what ...	https://i.ytimg.com/vi/gyaG-tFF5FA/hqdefault.jpg
18	4	COgvUFGLPCs	"  Ethical Artificial Intelligence (AI) Certification Course: https://www.edureka.co/ethical-artificial-intelligence-ai-certification-course ...	https://i.ytimg.com/vi/COgvUFGLPCs/hqdefault.jpg
19	4	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
20	4	0YnoMJWZr7E	What if artificial intelligence could make decisions that impact our lives? That's where AI ethics comes in! In this 60-second video, ...	https://i.ytimg.com/vi/0YnoMJWZr7E/hqdefault.jpg
21	5	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
22	5	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
23	5	vm8D45CyOcE	Can a machine know right from wrong? As Artificial Intelligence becomes smarter and more powerful, we must ask a deeper ...	https://i.ytimg.com/vi/vm8D45CyOcE/hqdefault.jpg
24	5	COgvUFGLPCs	"  Ethical Artificial Intelligence (AI) Certification Course: https://www.edureka.co/ethical-artificial-intelligence-ai-certification-course ...	https://i.ytimg.com/vi/COgvUFGLPCs/hqdefault.jpg
25	5	6yDr7CWLJ8c	AI ethics focuses on ensuring that AI is developed and deployed responsibly, promoting fairness, transparency, accountability, ...	https://i.ytimg.com/vi/6yDr7CWLJ8c/hqdefault.jpg
26	6	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
27	6	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
28	6	xxubNCaM7DI	AI Ethics: The Balancing Act You Must Know! #AI #Ethics #Technology #Privacy #QuantumComputing #Innovation.	https://i.ytimg.com/vi/xxubNCaM7DI/hqdefault.jpg
29	6	PkB4sd4fUVs	The future is closer than you think — and artificial intelligence is leading the way. ✨ From self-driving cars and medical ...	https://i.ytimg.com/vi/PkB4sd4fUVs/hqdefault.jpg
30	6	SFscV5HFzRA	Discover the inspiring story of an AI ethicist, navigating a career path blending technology and morality, showcases the ...	https://i.ytimg.com/vi/SFscV5HFzRA/hqdefault.jpg
31	7	t_eWESXTnic	Check out the updated video: https://youtu.be/Y6DPDC_Mf90 In this video we take a look at Public Health – the science and art of ...	https://i.ytimg.com/vi/t_eWESXTnic/hqdefault.jpg
32	7	_luU3I03JwE	Epidemiology is the study of patterns of diseases. And most people might think that means epidemiologists are only studying ...	https://i.ytimg.com/vi/_luU3I03JwE/hqdefault.jpg
33	7	tYx-fO5hMA4	In this career spotlight video, an epidemiologist from CDC describes his work studying how diseases affect populations and why ...	https://i.ytimg.com/vi/tYx-fO5hMA4/hqdefault.jpg
34	7	UZUowxurkAI	I f you are about to start or thinking of doing a Master of Public Health degree, then this video will tell you what you should expect ...	https://i.ytimg.com/vi/UZUowxurkAI/hqdefault.jpg
35	7	paWAy3qhd6c	In this career spotlight video, an epidemiologist from CDC talks about the different paths to a public health career, his educational ...	https://i.ytimg.com/vi/paWAy3qhd6c/hqdefault.jpg
36	8	3IpE8dE4cVc	In this video we take a brief look at surveillance – the eyes and ears of public health. We'll have a look at passive, active, sentinel, ...	https://i.ytimg.com/vi/3IpE8dE4cVc/hqdefault.jpg
37	8	m5vPEKtZV_I	In this video we will explore sources of data for NCD surveillance.	https://i.ytimg.com/vi/m5vPEKtZV_I/hqdefault.jpg
38	8	kUlKRIMxpZQ	Outbreaks of infectious diseases can cause illness and can lead to deaths. Finding out what caused an outbreak can be ...	https://i.ytimg.com/vi/kUlKRIMxpZQ/hqdefault.jpg
39	8	R1FIeiRiBYI	Public health surveillance is about more than just infectious disease epidemiology. It can include health surveillance on ...	https://i.ytimg.com/vi/R1FIeiRiBYI/hqdefault.jpg
40	8	XzRR4E9j9j0	Traditional public health surveillance relies on reporting at the local level of suspected unusual clusters of events, with ...	https://i.ytimg.com/vi/XzRR4E9j9j0/hqdefault.jpg
41	9	Jd3gFT0-C4s	This video gives a simple overview of the most common types of epidemiological studies, their advantages and disadvantages.	https://i.ytimg.com/vi/Jd3gFT0-C4s/hqdefault.jpg
42	9	t_eWESXTnic	Check out the updated video: https://youtu.be/Y6DPDC_Mf90 In this video we take a look at Public Health – the science and art of ...	https://i.ytimg.com/vi/t_eWESXTnic/hqdefault.jpg
43	9	4oaQUAnA6nY	Public health epidemiologists track diseases to figure out what caused them, how they are spread, and who is affected and at risk.	https://i.ytimg.com/vi/4oaQUAnA6nY/hqdefault.jpg
44	9	tYx-fO5hMA4	In this career spotlight video, an epidemiologist from CDC describes his work studying how diseases affect populations and why ...	https://i.ytimg.com/vi/tYx-fO5hMA4/hqdefault.jpg
45	9	3IpE8dE4cVc	In this video we take a brief look at surveillance – the eyes and ears of public health. We'll have a look at passive, active, sentinel, ...	https://i.ytimg.com/vi/3IpE8dE4cVc/hqdefault.jpg
46	10	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
47	10	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
48	10	GWVl7kZKNgc	Sign up for our complete finance training at 57% OFF ➡️https://bit.ly/4aoqxje ...	https://i.ytimg.com/vi/GWVl7kZKNgc/hqdefault.jpg
49	10	GW1TxhlryMs	Sign up for Our Complete Finance Training with 57% OFF: https://bit.ly/3SPJ29y Capital markets are one of the most fascinating ...	https://i.ytimg.com/vi/GW1TxhlryMs/hqdefault.jpg
50	10	JoPu_T3vu9o	Know how being a part of the Finlatics Financial Markets Experience Program can accelerate your career. Apply now to ...	https://i.ytimg.com/vi/JoPu_T3vu9o/hqdefault.jpg
51	11	I7FDx4DPapw	Courses on Khan Academy are always 100% free. Start practicing—and saving your progress—now: ...	https://i.ytimg.com/vi/I7FDx4DPapw/hqdefault.jpg
52	11	Au_p_lSKV7A	Free Webinar: How to Grow Your Wealth: https://en.samt.ag/ How do the interest rates affect the stock market? When you listen to ...	https://i.ytimg.com/vi/Au_p_lSKV7A/hqdefault.jpg
53	11	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
54	11	d2_ye7cAo78	Just In: U.S. corporate bond interest rates skyrocket New U.S. tariffs, notably under Trump's policies, impose higher costs on ...	https://i.ytimg.com/vi/d2_ye7cAo78/hqdefault.jpg
55	11	vAdn7aLHpO0	Bonds are one of the most common investments, but to many investors, they're still a mystery. In this video, you'll learn the basics ...	https://i.ytimg.com/vi/vAdn7aLHpO0/hqdefault.jpg
56	12	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
57	12	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
58	12	LLPwRNgqkDg	Day In The Life - Financial Analyst Are you interested in becoming a financial analyst? The financial services industry is extremely ...	https://i.ytimg.com/vi/LLPwRNgqkDg/hqdefault.jpg
59	12	As1a2VgbdWg	WARREN BUFFETT'S FINANCIAL RULES OF THUMB PDF:▽ https://longtermmindset.co/buffett ▽ABOUT US:▽ ‍  Brian ...	https://i.ytimg.com/vi/As1a2VgbdWg/hqdefault.jpg
60	13	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
61	13	M2ouLcfvJ_M	Ahead of Trump's presidency, InterAction President and CEO Tom Hart provides insights into China's geopolitical strategy.	https://i.ytimg.com/vi/M2ouLcfvJ_M/hqdefault.jpg
62	13	wOoEFIXQEtY	In this video, we explore the intriguing insights from "The Foundations of Geopolitics" and discuss its implications for Russia's ...	https://i.ytimg.com/vi/wOoEFIXQEtY/hqdefault.jpg
63	13	Fqb7W68B-Ws	shorts #state #politicalgeography #geographyoptional #geopolitics #definition.	https://i.ytimg.com/vi/Fqb7W68B-Ws/hqdefault.jpg
64	14	689wnA1ZuVo	It's been an eventful first 100 days for the second Trump administration, which has featured tariff turmoil, shifting foreign policy and ...	https://i.ytimg.com/vi/689wnA1ZuVo/hqdefault.jpg
65	14	SrFLetsSvcA	Uday Chandra, a political science professor, explains that the India-Pakistan tensions are largely symbolic and driven by ...	https://i.ytimg.com/vi/SrFLetsSvcA/hqdefault.jpg
66	14	SJsdnGd8iE8	(Nederlands volgt Engels) EN: The war in Ukraine holds the world in its grip. Russian missiles are hitting West-Ukraine, close to ...	https://i.ytimg.com/vi/SJsdnGd8iE8/hqdefault.jpg
67	14	-opsnULNE4M	You can listen to this episode on Spotify, Apple Podcasts, or Google Podcasts! Spotify: https://optamlink.com/spotify Apple ...	https://i.ytimg.com/vi/-opsnULNE4M/hqdefault.jpg
68	15	689wnA1ZuVo	It's been an eventful first 100 days for the second Trump administration, which has featured tariff turmoil, shifting foreign policy and ...	https://i.ytimg.com/vi/689wnA1ZuVo/hqdefault.jpg
69	15	Rjf7Gq_dS2M	Historian Bernd Greiner discusses 9/11Alexander Kudascheff interview historian Bernd Greiner on 9/11. Greiner argues that the ...	https://i.ytimg.com/vi/Rjf7Gq_dS2M/hqdefault.jpg
70	15	SJsdnGd8iE8	(Nederlands volgt Engels) EN: The war in Ukraine holds the world in its grip. Russian missiles are hitting West-Ukraine, close to ...	https://i.ytimg.com/vi/SJsdnGd8iE8/hqdefault.jpg
71	15	hjytWGQv7lw	Explore regional independence movements, new forms of populism, and illiberal democracies to examine what comes next.	https://i.ytimg.com/vi/hjytWGQv7lw/hqdefault.jpg
72	15	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
73	16	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
74	16	1sWsKxEWXXE	Discover how AI empowers us to navigate today's political risks in global supply chains. Gain insights into supplier selection and ...	https://i.ytimg.com/vi/1sWsKxEWXXE/hqdefault.jpg
75	16	EUowNpYL120	An introduction to #geopolitics. What it is, and how it can be applied in #statecraft. If you want to learn more about geopolitical ...	https://i.ytimg.com/vi/EUowNpYL120/hqdefault.jpg
76	16	BDqvzFY72mg	Professor Ian Shapiro introduces the class “Power and Politics in Today's World.” This course provides an examination of political ...	https://i.ytimg.com/vi/BDqvzFY72mg/hqdefault.jpg
77	17	muGzV-60QO0	In this introduction to the BJGP Webinar on Health Inequalities, 24 March 2021, Prof. Sir Michael Marmot discusses: 1. Reflections ...	https://i.ytimg.com/vi/muGzV-60QO0/hqdefault.jpg
78	17	cDQs4c9irRU	Columbia Mailman School of Public Health Yusuf Hamied Distinguished Lecture delivered by Gita Sen PhD, Distinguished ...	https://i.ytimg.com/vi/cDQs4c9irRU/hqdefault.jpg
79	17	HdmEBZSf89k	Inequalities in Global Public Health.	https://i.ytimg.com/vi/HdmEBZSf89k/hqdefault.jpg
80	17	F8UAanK5WNA	This video explains health equity and the interconnected factors that contribute to health inequities and health disparities.	https://i.ytimg.com/vi/F8UAanK5WNA/hqdefault.jpg
81	17	roAQHn5rEoQ	Behavioral and Social Sciences Research Lecture Series: Social inequalities in health Ann Morning, Ph.D. New York University ...	https://i.ytimg.com/vi/roAQHn5rEoQ/hqdefault.jpg
82	18	igrB2GNK5lI	What's shaping the US foreign policy? A more inward-looking approach, with a focus on domestic priorities, might be the way ...	https://i.ytimg.com/vi/igrB2GNK5lI/hqdefault.jpg
83	18	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
84	18	689wnA1ZuVo	It's been an eventful first 100 days for the second Trump administration, which has featured tariff turmoil, shifting foreign policy and ...	https://i.ytimg.com/vi/689wnA1ZuVo/hqdefault.jpg
85	18	M2ouLcfvJ_M	Ahead of Trump's presidency, InterAction President and CEO Tom Hart provides insights into China's geopolitical strategy.	https://i.ytimg.com/vi/M2ouLcfvJ_M/hqdefault.jpg
86	19	aGwYtUzMQUk	Learn more about watsonx: https://ibm.biz/BdPuC9 With the emergence of big data, companies have increased their focus to drive ...	https://i.ytimg.com/vi/aGwYtUzMQUk/hqdefault.jpg
87	19	gyaG-tFF5FA	How to Become an AI Ethics Professional. Here's a career transition guide for technologists. What do you want to learn, or what ...	https://i.ytimg.com/vi/gyaG-tFF5FA/hqdefault.jpg
88	19	COgvUFGLPCs	"  Ethical Artificial Intelligence (AI) Certification Course: https://www.edureka.co/ethical-artificial-intelligence-ai-certification-course ...	https://i.ytimg.com/vi/COgvUFGLPCs/hqdefault.jpg
89	19	eXdVDhOGqoE	AI won't kill us all — but that doesn't make it trustworthy. Instead of getting distracted by future existential risks, AI ethics researcher ...	https://i.ytimg.com/vi/eXdVDhOGqoE/hqdefault.jpg
90	19	0YnoMJWZr7E	What if artificial intelligence could make decisions that impact our lives? That's where AI ethics comes in! In this 60-second video, ...	https://i.ytimg.com/vi/0YnoMJWZr7E/hqdefault.jpg
91	20	4oaQUAnA6nY	Public health epidemiologists track diseases to figure out what caused them, how they are spread, and who is affected and at risk.	https://i.ytimg.com/vi/4oaQUAnA6nY/hqdefault.jpg
92	20	_luU3I03JwE	Epidemiology is the study of patterns of diseases. And most people might think that means epidemiologists are only studying ...	https://i.ytimg.com/vi/_luU3I03JwE/hqdefault.jpg
93	20	tYx-fO5hMA4	In this career spotlight video, an epidemiologist from CDC describes his work studying how diseases affect populations and why ...	https://i.ytimg.com/vi/tYx-fO5hMA4/hqdefault.jpg
94	20	S5XRh47T420	Epidemiology underpins everything we do in public health and global health. Epidemiology is more than just research methods ...	https://i.ytimg.com/vi/S5XRh47T420/hqdefault.jpg
95	20	9iMK1431dJU	Sign up here and try our FREE content: http://lectur.io/freecontentyt ▻ If you're a medical educator or faculty member, visit: ...	https://i.ytimg.com/vi/9iMK1431dJU/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 226, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.hidden_articles_id_seq', 5, true);


--
-- Name: hidden_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_questions_id_seq', 5, true);


--
-- Name: hidden_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_videos_id_seq', 1, false);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 20, true);


--
-- Name: refresh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_id_seq', 5, true);


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

SELECT pg_catalog.setval('public.videos_id_seq', 95, true);


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
    ADD CONSTRAINT articles_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: fav_articles fav_articles_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_articles
    ADD CONSTRAINT fav_articles_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.articles(id) ON DELETE SET NULL;


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
-- Name: fav_videos fav_videos_video_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fav_videos
    ADD CONSTRAINT fav_videos_video_id_fkey FOREIGN KEY (video_id) REFERENCES public.videos(id) ON DELETE SET NULL;


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
    ADD CONSTRAINT videos_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- PostgreSQL database dump complete
--

