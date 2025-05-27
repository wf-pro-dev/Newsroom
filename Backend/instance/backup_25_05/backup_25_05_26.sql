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
1	0.152	1	NewsDATA	Joshua reaching for the sky	Her first instinct was to pray.A young Filipina with us on our annual pilgrimage to Southern California, she was touring the famous Joshua Tree National Park when the sight of a Joshua Tree stopped her cold."May I pray under it?" she wondered."Of course," my wife replied, "but why do you want to?""Because it's in the Bible," the young woman said. And so we paused as she raised her arms to the blue heavens stretching out far above.Which, not surprisingly, is how the prayerful tree got its name. According to local legend, Mormon settlers passing this way in the mid-1800s thought the tree's outstretched limbs resembled the prophet Joshua beseeching God to help the ancient Israelites defeat the Kings of Gibeon. The Lord complied, the Bible says, helping the Hebrews win the battle and continue their march through the desert to The Promised Land.Similarly, more than 3,000 years later, the enraptured Mormons continued their journey to a promised land of their own. And more recently our Filipino friend, inspired by the same tree, embarked on a new life in America.Perhaps you see the pattern.Indigenous to the Mojave Desert of California, Nevada, Utah, and Arizona, the jagged tree is plentiful throughout the national park just eight kilometers from our house in the small desert community bearing its name. For me, in fact, a main selling point of the property we purchased there a decade ago was that it hosted three of those oh-so-sacred trees.One of them is gone now, annihilated, we are told, by climate change, drought, and the unpredictability of wildfires and desert storms. Which brings us to the point of this column; that the iconic Joshua Tree may be disappearing.It "really is a death-by-a-thousand-cuts kind of situation," one senior environmental scientist told the Los Angeles Times.To save the trees — which have lifespans of up to 500 years — the State of California has adopted some extremely tough measures. Damaging, removing, or in any way interfering with a Joshua Tree is now a major offense. And if you have one in your backyard, well, any construction or digging within 15 meters of it requires a $60,000 (3.35 million peso) permit.Which has sparked some backlash."I don't believe that's a good outcome," Curtis Yakimow, town manager of Yucca Valley, a rural municipality next to the national park, recently declared. Among other things, his town suffers from a significant housing shortage demanding major new construction. "It doesn't make any sense," Yakimow said of the massively expensive restrictions. "This is a tremendous issue for our residents and homeowners."So what's the solution?Pardon my literary pretensions, but — given the Joshua Tree's religious symbolism — I often think of its potential loss as a metaphor for one far more profound; the endangered connection between humanity and the larger spirit that informs us, however you choose to define it."The Joshua Tree stands as a testament to endurance," declared Copilot — an artificial intelligence application — when asked about the famous tree's spiritual significance. "Battered by the desert winds, it stretches towards the sky in defiance, much like the human spirit in search of meaning."An ostensibly human poet once put it somewhat similarly. "The Joshua Trees," he wrote, "dance with the wind, whispering ancient secrets."So how to move forward on behalf of these inspiring natural survivors of the desert's harsh conditions? Should we ruthlessly preserve those still standing regardless of the human cost, or simply plant new ones along the onward paths to which they inevitably lead us? Perhaps only time will tell.For now, though, here's how another anonymous commentator once expressed his love for those praying plants. "Amongst the Joshua Trees," he said, "I found my peace."And so may it be for us all. Hopefully, for a long time to come.* * *David Haldane is an award-winning American journalist, author, and radio broadcaster with homes in Surigao City, Philippines, and Joshua Tree, California. His latest book, Dark Skies: Tales of Turbulence in Paradise, is available for purchase on Amazon. You can visit David's website at https://davidshaldane.com/	ONLY AVAILABLE IN PAID PLANS	https://www.manilatimes.net/2025/05/26/expats-diplomats/joshua-reaching-for-the-sky/2120583	https://www.manilatimes.net/manilatimes/uploads/images/2025/05/25/636374.jpg	2025-05-25 16:05:00
2	0.073	1	NewsAPI	Scientists say NOAA cuts by Trump undermine improvements in hurricane forecasts	The Trump administration is targeting top climate and weather labs for cuts. Insiders worry about the impact on research and NOAA's ability to forecast severe weather like hurricanes and tornadoes.	MIAMI Weather and climate research are among the programs seeing big cuts by the Trump administration. \r\nHundreds of employees at NOAA the National Oceanic and Atmospheric Administration who work at … [+4401 chars]	https://www.npr.org/2025/04/25/nx-s1-5361474/noaa-cuts-hurricane-forecast-improvements-trump	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3900x2194+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F9e%2F96%2Fa366b9ba4a2a958fd8f8c1a55c33%2Fgettyimages-2177097712.jpg	2025-04-25 09:00:00
3	0.073	1	NewsAPI	Scientist sounds alarm after disturbing photo from Arctic expedition resurfaces: 'Feels like they could just sink at any moment'	"Science has a communication problem."	A famous photo from 2019 provides a snapshot of the changing climate and offers a glimpse of the future, scientists say.\r\nWhat's happening?\r\nThe image, featuring a first-person view of eight sled dog… [+2752 chars]	https://www.yahoo.com/news/scientist-sounds-alarm-disturbing-photo-121558211.html	https://s.yimg.com/ny/api/res/1.2/9SxazeP0bYNERRWxTm0fUQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_cool_down_737/4f5dfa89434f47d48c408c3b64f10f5c	2025-04-29 12:15:58
4	0.073	1	NewsAPI	Trump Dismisses Scientists Writing the National Climate Assessment	President Trump has dismissed hundreds of scientists working on the congressionally mandated National Climate Assessment, raising concerns about whether the void will be filled with pseudoscience	CLIMATEWIRE | The Trump administration on Monday dismissed all of the scientists working on the newest version of the National Climate Assessment, a sweeping report that outlines the growing dangers … [+4128 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/29/trump-dismisses-scientists-writing-the-national-climate-assessment-00314494	https://static.scientificamerican.com/dam/m/768e21512db2705d/original/Firefighters_watch_fire.jpg?m=1745935059.9&w=1200	2025-04-29 14:20:00
5	0.073	1	NewsAPI	Trump Tries to Make Sure States Don’t Fight Climate Change Either	Donald Trump’s administration isn't just ending climate action in the federal government. It's trying to end climate efforts in the states, too.	If you’re one of those gambling addicts placing bets on every imaginable future scenario that could befall this nation, and you’ve bet on it facing a maximum climate catastrophe, you’ve got a friend … [+5744 chars]	http://www.rollingstone.com/politics/politics-features/trump-climate-states-lawsuits-republicans-justice-1235347292/	https://www.rollingstone.com/wp-content/uploads/2025/05/trump-climate-action-in-states.jpg?w=1600&h=900&crop=1	2025-05-24 13:00:00
6	0.073	1	NewsAPI	A vicious cycle: How methane emissions from warming wetlands could exacerbate climate change	The latest study finds that emissions of the potent greenhouse gas might be higher than previously estimated.	Warming in the Arctic is intensifying methane emissions, contributing to a vicious feedback loop that could accelerate climate change even more, according to a new study published May 7 in Nature."Me… [+5013 chars]	https://www.sciencedaily.com/releases/2025/05/250515191232.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-15 23:12:32
7	0.073	1	NewsAPI	Global temperatures stuck at near-record highs in April: EU monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3870 chars]	https://phys.org/news/2025-05-global-temperatures-stuck-highs-april.html	https://scx2.b-cdn.net/gfx/news/2025/scientists-are-unanimo.jpg	2025-05-08 17:09:48
8	0.073	1	NewsAPI	Current Climate: Major Assault On California’s Environmental Rules	In this week's Current Climate, California's ability to set tough environmental rules is under attack; Elon Musk is out of ideas to revive Tesla; domestically sourced lithium-sulfur batteries	Plus: Elon Musk runs out of ideas to save Tesla; cheaper, domestically sourced lithium-sulfur batteries\r\nCurrent Climate brings you the latest news about the business of sustainability every Monday. … [+10833 chars]	https://www.forbes.com/sites/alanohnsman/2025/05/05/current-climate-a-major-assault-on-californias-environmental-rules/	https://imageio.forbes.com/specials-images/imageserve/681541b451ae5311ac7d37e4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 12:45:00
9	0.073	1	NewsAPI	Big Oil Knew, Big Oil Lied: Fossil Fuel’s Long Strategy Of Deceit	A new UCS report reveals how fossil fuel giants spent decades disseminating climate disinformation, delaying action and fueling rising emissions and climate costs.	COTTBUS, GERMANY - APRIL 12: (Photo by Sean Gallup/Getty Images)\r\nGetty Images\r\nIn recent decades, increases in extreme weather have laid bare the mounting risk created by climate change, prompting b… [+7445 chars]	https://www.forbes.com/sites/feliciajackson/2025/05/14/big-oil-knew-big-oil-lied-fossil-fuels-long-strategy-of-deceit/	https://imageio.forbes.com/specials-images/imageserve/6824a1220179fafd5a554e3c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 14:01:35
10	0.073	1	NewsAPI	Trump administration dismisses scientists writing quadrennial climate report	The National Climate Assessment, a major publication produced every four years that summarizes the impacts of climate change in the U.S., is scheduled for publication in 2027.	Nearly 400 scientists across the United States were informed Monday afternoon that their services were no longer needed to help write a major report on climate change for the federal government.\r\nThe… [+4531 chars]	https://www.cbsnews.com/news/national-climate-assessment-report-scientists-fired/	https://assets3.cbsnewsstatic.com/hub/i/r/2025/04/30/75a4cdd4-74d0-425f-8ef6-f75a91332dd7/thumbnail/1200x630/637eaaf69205c5e0f5f48c059e8c5415/gettyimages-1197857412.jpg?v=fbebbf93950d87ce40fccd82890f0617	2025-04-30 01:34:33
11	0.073	1	NewsAPI	The government just killed an essential way to assess climate risk	Cities, insurers, and the public used the Billion-Dollar Weather and Climate Disasters database to plan for the future. Now what will they do?	Nearly 30 billion-dollar storms rocked the United States last year. Thanks to the National Oceanic and Atmospheric Administrations disaster tracking database, we know that catastrophes are getting mo… [+7887 chars]	http://grist.org/climate/trump-noaa-billion-dollar-weather-and-climate-disasters-database/	https://grist.org/wp-content/uploads/2025/05/GettyImages-217471470d6.jpg?quality=75&strip=all	2025-05-14 08:45:00
12	0.073	1	NewsAPI	These protesters want you to reduce, repair and rewear	In this issue of our environmental newsletter, we hang out with protesters mending clothes in public, see what extreme weather our children can expect to experience and find out what science says about not mowing your lawn in May.	Hello, Earthlings! This is our weekly newsletter on all things environmental, where we highlight trends and solutions that are moving us to a more sustainable world. Keep up with the latest news on o… [+12239 chars]	https://www.cbc.ca/news/science/what-on-earth-mending-1.7535510	https://i.cbc.ca/1.7531216.1746809815!/fileImage/httpImage/image.jpeg_gen/derivatives/16x9_1180/participant-at-mend-in-public-day.jpeg?im=Resize%3D620	2025-05-15 18:25:45
13	0.073	1	NewsAPI	Climate Myths, Continued	“Climate change will make earth a living hell!” claims popular astrophysicist Neil DeGrasse Tyson. I don’t believe him. The media say, “All Arctic ice will... Read More\nThe post Climate Myths, Continued appeared first on The Daily Signal.	Climate change will make earth a living hell! claims popular astrophysicist Neil DeGrasse Tyson.\r\nI don’t believe him.\r\nThe media say, All Arctic ice will soon melt away! Polar bears are dying off! G… [+4000 chars]	https://www.dailysignal.com/2025/04/27/climate-myths-continued/	https://www.dailysignal.com/wp-content/uploads/2024/05/shareCardDailySignal.png	2025-04-27 14:00:00
14	0.073	1	NewsDATA	Extreme weather cycles change underwater light at Tahoe	Lake Tahoe is experiencing large-scale shifts in ultraviolet radiation (UV) as climate change intensifies wet and dry extremes in the region. That is according to a study led by the University of California, Davis’ Tahoe...	ONLY AVAILABLE IN PAID PLANS	https://www.tahoedailytribune.com/news/extreme-weather-cycles-change-underwater-light-at-tahoe/	https://swiftmedia.s3.amazonaws.com/pacific.swiftcom.com/images/sites/5/2025/05/25084015/TERC-research-diver-Brant-Allen-in-Lake-Tahoe-c-BrandonBerrry_UCDavisTERC-1024x683.jpg	2025-05-25 14:41:46
15	0	1	NewsAPI	Why Snow in New Zealand’s Alps Turned an Alarming Shade of Red	Several years ago, snow in New Zealand's Southern Alps turned red, and while many blamed wildfires at the time, new research uncovers the true culprit.	During the Southern Hemisphere’s summer of 20192020, mountains in New Zealand turned red. New research finally explains why.\r\nResearchers have revealed that New Zealand’s Southern Alps turned red aft… [+2657 chars]	https://gizmodo.com/why-snow-in-new-zealands-alps-turned-an-alarming-shade-of-red-2000593615	https://gizmodo.com/app/uploads/2025/04/red-new-zealand-alps.jpg	2025-04-24 13:35:15
16	0	1	NewsAPI	Trump Torched Decades of Science in Just 100 Days—and the Fallout Is Global	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	Across seven decades and a dozen presidencies, Americas scientific prowess was arguably unmatched. At universities and federal agencies alike, researchers in the United States revolutionized weather … [+16614 chars]	https://gizmodo.com/trump-torched-decades-of-science-in-just-100-days-and-the-fallout-is-global-2000595721	https://gizmodo.com/app/uploads/2024/10/wildfire-fire-fighter.jpg	2025-05-04 14:00:29
17	0	1	NewsAPI	With Mark Carney’s Win, Trump Is Now Sandwiched Between Two Climate Leaders	The success of Canada's Mark Carney and Mexico's Claudia Sheinbaum is a chance to reflect on the best strategy to tackle climate change.	Mark Carney was elected to a full term as Canadas prime minister Monday with a campaign agenda focused squarely on pushing back on attacks from his counterpart to the South, President Donald Trump. I… [+5835 chars]	https://time.com/7281714/mark-carney-canada-mexico-climate-leadership-strategy/	https://api.time.com/wp-content/uploads/2025/04/mark-carney-climate-change.jpg?quality=85&w=1024&h=628&crop=1	2025-04-30 19:32:15
18	0	1	NewsAPI	El Paso Is Having Its Dustiest Year Since the Actual Dust Bowl	Drought, wind, and climate change are turning the Borderplex into a morass of airborne grit.	If you live in El Paso, Las Cruces, or Ciudad Juárez and feel like youve been inhaling the Chihuahuan Desert lately, youre not imagining things. The Borderplex region is experiencing its dustiest sea… [+2589 chars]	https://gizmodo.com/el-paso-is-having-its-dustiest-year-since-the-actual-dust-bowl-2000596987	https://gizmodo.com/app/uploads/2025/05/dust-el-paso.jpg	2025-05-04 10:00:17
19	0	1	NewsAPI	These trees exist in only one place on Earth. Now climate change and goats threaten their survival	The young plant, protected by a makeshift fence of wood and wire, is a kind of dragon’s blood tree — a species found only on the Yemeni island of Socotra...	SOCOTRA, Yemen (AP) On a windswept plateau high above the Arabian Sea, Sena Keybani cradles a sapling that barely reaches her ankle. The young plant, protected by a makeshift fence of wood and wire, … [+6680 chars]	https://www.yahoo.com/news/trees-exist-only-one-place-033450454.html	https://s.yimg.com/ny/api/res/1.2/76jHHoo4aAjkwEgKBbpcZA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/ap.org/a40d526c52f6feca4731304c079b9ac5	2025-05-19 03:34:50
20	0	1	NewsAPI	Shorter and warmer winters may expand the hibernation area of bats in Europe	The ambient temperature has a profound impact on the physiology and behaviour of most species. In regions where individuals rely on low temperatures to hibernate effectively, global warming is likely to significantly affect their survival. A team of scientist…	The ambient temperature has a profound impact on the physiology and behaviour of most species. In regions where individuals rely on low temperatures to hibernate effectively, global warming is likely… [+5619 chars]	https://www.sciencedaily.com/releases/2025/05/250505121907.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-05 16:19:07
21	0.1	2	NewsAPI	With evolutionary AI, scientists find hidden keys for better land use	A new AI decision making tool effectively balances various complex trade-offs to recommend ways of maximizing carbon storage, minimizing economic disruptions and helping improve the environment and people's everyday lives. It uses evolutionary AI, a kind of d…	Using global land use and carbon storage data from the past 175 years, researchers at The University of Texas at Austin and Cognizant AI Labs have trained an artificial intelligence system to develop… [+4532 chars]	https://www.sciencedaily.com/releases/2025/05/250519131038.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-19 17:10:38
22	0.1	2	NewsAPI	How lichens are bringing stone to life and reconnecting us with the natural world	Lichens bridge the living and non-living – understanding them allows us to better see how to conserve our heritage, and also ourselves.	Lichens at Blenheim Palace. Ian Wallman , CC BY-SA\r\nLichens on stone, those “still explosions” as the great American poet Elizabeth Bishop named them, remain unseen to most, which is remarkable when … [+12169 chars]	https://theconversation.com/how-lichens-are-bringing-stone-to-life-and-reconnecting-us-with-the-natural-world-250944	https://images.theconversation.com/files/667882/original/file-20250514-62-imenzl.jpg?ixlib=rb-4.1.0&rect=0%2C160%2C1919%2C959&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-16 16:52:13
23	0	2	NewsAPI	Brian Eno's Theory of Democracy	Organizing and generating variety in politics	[image by Brian Eno, from 77 Million Paintings. Eno says in this dialogue that he doesnt mind people using these images for non-commercial purposes]\r\nThis posts title is a little cheeky. Brian Eno do… [+22374 chars]	https://www.programmablemutter.com/p/brian-enos-theory-of-democracy	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fd3fe93b6-fd36-4c63-88f9-55a434046baf_1200x796.jpeg	2025-05-04 05:12:47
24	0	2	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #19	A listing of 27 news and opinion articles we found interesting and shared on social media during the past week: Sun, May 4, 2025 thru Sat, May 10, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. The …	Posted on 11 May 2025 by BaerbelW, Doug Bostrom\r\nA listing of 27 news and opinion articles we found interesting and shared on social media during the past week: Sun, May 4, 2025 thru Sat, May 10, 202… [+6412 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_19.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-11 06:50:03
25	0	2	NewsAPI	How Trump 2.0 Overturned Years of Climate Progress in 100 Days	From regulatory rollbacks to coal resurgence, here are some of Trump’s most consequential actions since January 20.	Part of the Series\r\nThis article by Earth.Org is published here as part of the global journalism collaboration Covering Climate Now.\r\nTrumps current approval rating is the lowest for any newly electe… [+18499 chars]	https://earth.org/100-days-of-trump-how-the-us-overturned-years-of-climate-progress/	https://truthout.org/app/uploads/2025/04/2025_0430-trump-1.jpg	2025-04-30 18:46:54
26	0	2	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
27	0	2	NewsAPI	EGU2025 - How the week in Vienna unfolded	Note: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia mentioned below, be released sometime after the conference ends, I'll include links to the ones I …	Posted on 2 May 2025 by BaerbelW\r\nNote: This blog post will be updated during EGU25 happening in Vienna from April 28 to May 2. Should recordings of the Great Debates and possibly Union Symposia ment… [+32724 chars]	https://skepticalscience.com/egu25-personal-diary.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-05-02 06:23:14
28	0	2	NewsAPI	The Mercury's May 2025 Election Endorsements	Our top picks for the May 20 Special District Election, featuring school board seats, public school bonds, and more! \n \n by The Mercury Election Strike Force\n \n \n \n On May 20, Multnomah County residents will elect new leadership on local school boards and uti…	On May 20, Multnomah County residents will elect new leadership on local school boards and utility boards. Portland voters will also decide whether to renew a sizable school bond measure to fund Port… [+24418 chars]	https://www.portlandmercury.com/election/2025/05/02/47765305/the-mercurys-may-2025-election-endorsements	https://media1.fdncms.com/portmerc/imager/u/large/47768451/may2024primary_cv_01_1_.webp	2025-05-03 00:55:00
29	0	2	NewsDATA	UH researchers, faculty suffering from federal cuts	Mahina Robbins, a second-year Ph.D. student at the University of Hawaii at Manoa, moved to Hawaii in 2023 to reconnect with her Native Hawaiian heritage and family while fulfilling a dream of becoming a volcanologist.	ONLY AVAILABLE IN PAID PLANS	https://www.thegardenisland.com/2025/05/25/hawaii-news/uh-researchers-faculty-suffering-from-federal-cuts/	https://www.thegardenisland.com/wp-content/uploads/2025/05/web1_20250102-oped-syrmos.jpg	2025-05-25 10:05:00
30	0	2	NewsDATA	Research into nano-urea can transform our agricultural sector	Nano-urea offers a promising solution to tackle present and future challenges in fertiliser supply and sustainability.	ONLY AVAILABLE IN PAID PLANS	https://www.thedailystar.net/opinion/views/news/research-nano-urea-can-transform-our-agricultural-sector-3902906	https://tds-images.thedailystar.net/sites/default/files/styles/very_big_201/public/images/2025/05/25/494358532_1480849076631297_9169746770787300371_n.jpg	2025-05-25 07:30:00
31	0	2	NewsDATA	Renegotiating the Indus Water Treaty	Pakistan’s fertile plains, long nourished by the Indus, Jhelum, and Chenab rivers, face a silent threat: thirst.	ONLY AVAILABLE IN PAID PLANS	https://www.nation.com.pk/25-May-2025/renegotiating-the-indus-water-treaty	https://www.nation.com.pk/uploads/facebook_post_images/2025-05-25/facebook_post_image_1748133899.jpg	2025-05-25 00:44:59
32	0	2	NewsDATA	The scorching new normal in Pakistan	Record-breaking heat is no longer a once-in-a-decade anomaly. It’s what experts now call a shifting climate baseline	ONLY AVAILABLE IN PAID PLANS	https://tribune.com.pk/story/2547633/the-scorching-new-normal-in-pakistan	https://i.tribune.com.pk/media/images/heatwave-11748122597-5/heatwave-11748122597-5.jpg	2025-05-24 16:25:37
33	0.363	3	NewsDATA	Joshua reaching for the sky	Her first instinct was to pray.A young Filipina with us on our annual pilgrimage to Southern California, she was touring the famous Joshua Tree National Park when the sight of a Joshua Tree stopped her cold."May I pray under it?" she wondered."Of course," my wife replied, "but why do you want to?""Because it's in the Bible," the young woman said. And so we paused as she raised her arms to the blue heavens stretching out far above.Which, not surprisingly, is how the prayerful tree got its name. According to local legend, Mormon settlers passing this way in the mid-1800s thought the tree's outstretched limbs resembled the prophet Joshua beseeching God to help the ancient Israelites defeat the Kings of Gibeon. The Lord complied, the Bible says, helping the Hebrews win the battle and continue their march through the desert to The Promised Land.Similarly, more than 3,000 years later, the enraptured Mormons continued their journey to a promised land of their own. And more recently our Filipino friend, inspired by the same tree, embarked on a new life in America.Perhaps you see the pattern.Indigenous to the Mojave Desert of California, Nevada, Utah, and Arizona, the jagged tree is plentiful throughout the national park just eight kilometers from our house in the small desert community bearing its name. For me, in fact, a main selling point of the property we purchased there a decade ago was that it hosted three of those oh-so-sacred trees.One of them is gone now, annihilated, we are told, by climate change, drought, and the unpredictability of wildfires and desert storms. Which brings us to the point of this column; that the iconic Joshua Tree may be disappearing.It "really is a death-by-a-thousand-cuts kind of situation," one senior environmental scientist told the Los Angeles Times.To save the trees — which have lifespans of up to 500 years — the State of California has adopted some extremely tough measures. Damaging, removing, or in any way interfering with a Joshua Tree is now a major offense. And if you have one in your backyard, well, any construction or digging within 15 meters of it requires a $60,000 (3.35 million peso) permit.Which has sparked some backlash."I don't believe that's a good outcome," Curtis Yakimow, town manager of Yucca Valley, a rural municipality next to the national park, recently declared. Among other things, his town suffers from a significant housing shortage demanding major new construction. "It doesn't make any sense," Yakimow said of the massively expensive restrictions. "This is a tremendous issue for our residents and homeowners."So what's the solution?Pardon my literary pretensions, but — given the Joshua Tree's religious symbolism — I often think of its potential loss as a metaphor for one far more profound; the endangered connection between humanity and the larger spirit that informs us, however you choose to define it."The Joshua Tree stands as a testament to endurance," declared Copilot — an artificial intelligence application — when asked about the famous tree's spiritual significance. "Battered by the desert winds, it stretches towards the sky in defiance, much like the human spirit in search of meaning."An ostensibly human poet once put it somewhat similarly. "The Joshua Trees," he wrote, "dance with the wind, whispering ancient secrets."So how to move forward on behalf of these inspiring natural survivors of the desert's harsh conditions? Should we ruthlessly preserve those still standing regardless of the human cost, or simply plant new ones along the onward paths to which they inevitably lead us? Perhaps only time will tell.For now, though, here's how another anonymous commentator once expressed his love for those praying plants. "Amongst the Joshua Trees," he said, "I found my peace."And so may it be for us all. Hopefully, for a long time to come.* * *David Haldane is an award-winning American journalist, author, and radio broadcaster with homes in Surigao City, Philippines, and Joshua Tree, California. His latest book, Dark Skies: Tales of Turbulence in Paradise, is available for purchase on Amazon. You can visit David's website at https://davidshaldane.com/	ONLY AVAILABLE IN PAID PLANS	https://www.manilatimes.net/2025/05/26/expats-diplomats/joshua-reaching-for-the-sky/2120583	https://www.manilatimes.net/manilatimes/uploads/images/2025/05/25/636374.jpg	2025-05-25 16:05:00
34	0.274	3	NewsAPI	Climate wars are approaching — and they will redefine global conflict	Climate change's profound reshaping of conflict dynamics is already underway. The question facing humanity now is not whether we will confront these pressures, but how we will choose to do so.	Climate change is increasingly recognized\r\n not merely as an environmental crisis but as a threat multiplier, worsening political and economic tensions worldwide. Two factors\r\n — water scarcity and m… [+8828 chars]	https://www.livescience.com/planet-earth/climate-change/the-coming-climate-wars-how-water-scarcity-and-mass-migration-will-redefine-global-conflict-opinion	https://cdn.mos.cms.futurecdn.net/fzKh6aTAcUQHx8n8uSW7UK.jpg	2025-04-30 15:44:08
35	0.185	3	NewsAPI	A vicious cycle: How methane emissions from warming wetlands could exacerbate climate change	The latest study finds that emissions of the potent greenhouse gas might be higher than previously estimated.	Warming in the Arctic is intensifying methane emissions, contributing to a vicious feedback loop that could accelerate climate change even more, according to a new study published May 7 in Nature."Me… [+5013 chars]	https://www.sciencedaily.com/releases/2025/05/250515191232.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-15 23:12:32
36	0.185	3	NewsAPI	Big Oil Knew, Big Oil Lied: Fossil Fuel’s Long Strategy Of Deceit	A new UCS report reveals how fossil fuel giants spent decades disseminating climate disinformation, delaying action and fueling rising emissions and climate costs.	COTTBUS, GERMANY - APRIL 12: (Photo by Sean Gallup/Getty Images)\r\nGetty Images\r\nIn recent decades, increases in extreme weather have laid bare the mounting risk created by climate change, prompting b… [+7445 chars]	https://www.forbes.com/sites/feliciajackson/2025/05/14/big-oil-knew-big-oil-lied-fossil-fuels-long-strategy-of-deceit/	https://imageio.forbes.com/specials-images/imageserve/6824a1220179fafd5a554e3c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 14:01:35
37	0.185	3	NewsAPI	Trump administration dismisses scientists writing quadrennial climate report	The National Climate Assessment, a major publication produced every four years that summarizes the impacts of climate change in the U.S., is scheduled for publication in 2027.	Nearly 400 scientists across the United States were informed Monday afternoon that their services were no longer needed to help write a major report on climate change for the federal government.\r\nThe… [+4531 chars]	https://www.cbsnews.com/news/national-climate-assessment-report-scientists-fired/	https://assets3.cbsnewsstatic.com/hub/i/r/2025/04/30/75a4cdd4-74d0-425f-8ef6-f75a91332dd7/thumbnail/1200x630/637eaaf69205c5e0f5f48c059e8c5415/gettyimages-1197857412.jpg?v=fbebbf93950d87ce40fccd82890f0617	2025-04-30 01:34:33
38	0.185	3	NewsAPI	Naomi Klein: ‘What They Want Is Absolutely Everything’	The all-star academic and Shock Doctrine author breaks down the dark logic of Trump and Musk’s path of destruction — and what the world’s richest people really want	Wherever corporate power is running roughshod over culture, the climate, the economy, or our politics, progressives can count on Naomi Klein to provide a clear-eyed assessment of the damage and to of… [+24064 chars]	http://www.rollingstone.com/politics/politics-features/naomi-klein-trump-musk-thiel-oligarchs-climate-science-1235330780/	https://www.rollingstone.com/wp-content/uploads/2025/04/naomi-klein-qa.jpg?w=1600&h=900&crop=1	2025-05-04 13:30:00
39	0.185	3	NewsAPI	Climate Myths, Continued	“Climate change will make earth a living hell!” claims popular astrophysicist Neil DeGrasse Tyson. I don’t believe him. The media say, “All Arctic ice will... Read More\nThe post Climate Myths, Continued appeared first on The Daily Signal.	Climate change will make earth a living hell! claims popular astrophysicist Neil DeGrasse Tyson.\r\nI don’t believe him.\r\nThe media say, All Arctic ice will soon melt away! Polar bears are dying off! G… [+4000 chars]	https://www.dailysignal.com/2025/04/27/climate-myths-continued/	https://www.dailysignal.com/wp-content/uploads/2024/05/shareCardDailySignal.png	2025-04-27 14:00:00
40	0.185	3	NewsDATA	Extreme weather cycles change underwater light at Tahoe	Lake Tahoe is experiencing large-scale shifts in ultraviolet radiation (UV) as climate change intensifies wet and dry extremes in the region. That is according to a study led by the University of California, Davis’ Tahoe...	ONLY AVAILABLE IN PAID PLANS	https://www.tahoedailytribune.com/news/extreme-weather-cycles-change-underwater-light-at-tahoe/	https://swiftmedia.s3.amazonaws.com/pacific.swiftcom.com/images/sites/5/2025/05/25084015/TERC-research-diver-Brant-Allen-in-Lake-Tahoe-c-BrandonBerrry_UCDavisTERC-1024x683.jpg	2025-05-25 14:41:46
41	0.089	3	NewsAPI	Scientists say NOAA cuts by Trump undermine improvements in hurricane forecasts	The Trump administration is targeting top climate and weather labs for cuts. Insiders worry about the impact on research and NOAA's ability to forecast severe weather like hurricanes and tornadoes.	MIAMI Weather and climate research are among the programs seeing big cuts by the Trump administration. \r\nHundreds of employees at NOAA the National Oceanic and Atmospheric Administration who work at … [+4401 chars]	https://www.npr.org/2025/04/25/nx-s1-5361474/noaa-cuts-hurricane-forecast-improvements-trump	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3900x2194+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F9e%2F96%2Fa366b9ba4a2a958fd8f8c1a55c33%2Fgettyimages-2177097712.jpg	2025-04-25 09:00:00
42	0.089	3	NewsAPI	Scientist sounds alarm after disturbing photo from Arctic expedition resurfaces: 'Feels like they could just sink at any moment'	"Science has a communication problem."	A famous photo from 2019 provides a snapshot of the changing climate and offers a glimpse of the future, scientists say.\r\nWhat's happening?\r\nThe image, featuring a first-person view of eight sled dog… [+2752 chars]	https://www.yahoo.com/news/scientist-sounds-alarm-disturbing-photo-121558211.html	https://s.yimg.com/ny/api/res/1.2/9SxazeP0bYNERRWxTm0fUQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_cool_down_737/4f5dfa89434f47d48c408c3b64f10f5c	2025-04-29 12:15:58
43	0.089	3	NewsAPI	Trump Dismisses Scientists Writing the National Climate Assessment	President Trump has dismissed hundreds of scientists working on the congressionally mandated National Climate Assessment, raising concerns about whether the void will be filled with pseudoscience	CLIMATEWIRE | The Trump administration on Monday dismissed all of the scientists working on the newest version of the National Climate Assessment, a sweeping report that outlines the growing dangers … [+4128 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/29/trump-dismisses-scientists-writing-the-national-climate-assessment-00314494	https://static.scientificamerican.com/dam/m/768e21512db2705d/original/Firefighters_watch_fire.jpg?m=1745935059.9&w=1200	2025-04-29 14:20:00
44	0.089	3	NewsAPI	Trump Tries to Make Sure States Don’t Fight Climate Change Either	Donald Trump’s administration isn't just ending climate action in the federal government. It's trying to end climate efforts in the states, too.	If you’re one of those gambling addicts placing bets on every imaginable future scenario that could befall this nation, and you’ve bet on it facing a maximum climate catastrophe, you’ve got a friend … [+5744 chars]	http://www.rollingstone.com/politics/politics-features/trump-climate-states-lawsuits-republicans-justice-1235347292/	https://www.rollingstone.com/wp-content/uploads/2025/05/trump-climate-action-in-states.jpg?w=1600&h=900&crop=1	2025-05-24 13:00:00
45	0.089	3	NewsAPI	Global temperatures stuck at near-record highs in April: EU monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3870 chars]	https://phys.org/news/2025-05-global-temperatures-stuck-highs-april.html	https://scx2.b-cdn.net/gfx/news/2025/scientists-are-unanimo.jpg	2025-05-08 17:09:48
57	0.114	5	NewsDATA	A sneak peek into University of Rwanda’s AI projects	The University of Rwanda (UR) is working on several projects, including one aimed at empowering people with disabilities through artificial intelligence (AI), The New Times has l...	ONLY AVAILABLE IN PAID PLANS	https://www.newtimes.co.rw/article/26697/news/education/a-sneak-peek-into-university-of-rwandas-ai-projects	https://www.newtimes.co.rw/thenewtimes/uploads/images/2025/05/25/77869.jpg	2025-05-25 10:36:00
46	0.089	3	NewsAPI	Current Climate: Major Assault On California’s Environmental Rules	In this week's Current Climate, California's ability to set tough environmental rules is under attack; Elon Musk is out of ideas to revive Tesla; domestically sourced lithium-sulfur batteries	Plus: Elon Musk runs out of ideas to save Tesla; cheaper, domestically sourced lithium-sulfur batteries\r\nCurrent Climate brings you the latest news about the business of sustainability every Monday. … [+10833 chars]	https://www.forbes.com/sites/alanohnsman/2025/05/05/current-climate-a-major-assault-on-californias-environmental-rules/	https://imageio.forbes.com/specials-images/imageserve/681541b451ae5311ac7d37e4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 12:45:00
47	0.089	3	NewsAPI	An EPA Without Science	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed, they constituted “the greatest and most consequential day o…	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed,… [+26919 chars]	https://www.nybooks.com/online/2025/05/16/an-epa-without-science/	https://www.nybooks.com/wp-content/uploads/2025/05/Mingle202505_4.jpeg	2025-05-16 14:36:44
48	0	3	NewsAPI	Trump Torched Decades of Science in Just 100 Days—and the Fallout Is Global	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	Across seven decades and a dozen presidencies, Americas scientific prowess was arguably unmatched. At universities and federal agencies alike, researchers in the United States revolutionized weather … [+16614 chars]	https://gizmodo.com/trump-torched-decades-of-science-in-just-100-days-and-the-fallout-is-global-2000595721	https://gizmodo.com/app/uploads/2024/10/wildfire-fire-fighter.jpg	2025-05-04 14:00:29
49	0	3	NewsAPI	With Mark Carney’s Win, Trump Is Now Sandwiched Between Two Climate Leaders	The success of Canada's Mark Carney and Mexico's Claudia Sheinbaum is a chance to reflect on the best strategy to tackle climate change.	Mark Carney was elected to a full term as Canadas prime minister Monday with a campaign agenda focused squarely on pushing back on attacks from his counterpart to the South, President Donald Trump. I… [+5835 chars]	https://time.com/7281714/mark-carney-canada-mexico-climate-leadership-strategy/	https://api.time.com/wp-content/uploads/2025/04/mark-carney-climate-change.jpg?quality=85&w=1024&h=628&crop=1	2025-04-30 19:32:15
50	0	3	NewsAPI	El Paso Is Having Its Dustiest Year Since the Actual Dust Bowl	Drought, wind, and climate change are turning the Borderplex into a morass of airborne grit.	If you live in El Paso, Las Cruces, or Ciudad Juárez and feel like youve been inhaling the Chihuahuan Desert lately, youre not imagining things. The Borderplex region is experiencing its dustiest sea… [+2589 chars]	https://gizmodo.com/el-paso-is-having-its-dustiest-year-since-the-actual-dust-bowl-2000596987	https://gizmodo.com/app/uploads/2025/05/dust-el-paso.jpg	2025-05-04 10:00:17
51	0	3	NewsAPI	These trees exist in only one place on Earth. Now climate change and goats threaten their survival	The young plant, protected by a makeshift fence of wood and wire, is a kind of dragon’s blood tree — a species found only on the Yemeni island of Socotra...	SOCOTRA, Yemen (AP) On a windswept plateau high above the Arabian Sea, Sena Keybani cradles a sapling that barely reaches her ankle. The young plant, protected by a makeshift fence of wood and wire, … [+6680 chars]	https://www.yahoo.com/news/trees-exist-only-one-place-033450454.html	https://s.yimg.com/ny/api/res/1.2/76jHHoo4aAjkwEgKBbpcZA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/ap.org/a40d526c52f6feca4731304c079b9ac5	2025-05-19 03:34:50
52	0	3	NewsAPI	Shorter and warmer winters may expand the hibernation area of bats in Europe	The ambient temperature has a profound impact on the physiology and behaviour of most species. In regions where individuals rely on low temperatures to hibernate effectively, global warming is likely to significantly affect their survival. A team of scientist…	The ambient temperature has a profound impact on the physiology and behaviour of most species. In regions where individuals rely on low temperatures to hibernate effectively, global warming is likely… [+5619 chars]	https://www.sciencedaily.com/releases/2025/05/250505121907.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-05 16:19:07
53	0	4	NewsAPI	What Happens When Teachers Are Replaced With AI? This School Is Finding Out	Alpha School in Brownsville, Texas, promises to deliver a full day's worth of instruction in just two hours with AI tutors. So far, the results are startling.	The 8:15 a.m. scene in front of the school that sits on a dusty, sun-soaked residential street in Brownsville, Texas, just across the border with Mexico, looks much like any other elementary or middl… [+20799 chars]	https://www.newsweek.com/alpha-school-brownsville-ai-expanding-2063669	https://d.newsweek.com/en/full/2636344/alpha-mainer.png	2025-05-01 10:00:02
54	0	4	NewsAPI	Why agency and cognition are fundamentally not computational	Article URL: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full\nComments URL: https://news.ycombinator.com/item?id=43990107\nPoints: 4\n# Comments: 0	“To live is to know.”\r\n(Maturana, 1988)\r\n“Between the stimulus and the response, there is a space. And in that space lies our freedom and power to choose our responses.”\r\n(Frankl, 1946, 2020)\r\n“Volun… [+166123 chars]	https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full	https://images-provider.frontiersin.org/api/ipx/w=1200&f=png/https://www.frontiersin.org/files/Articles/1362658/fpsyg-15-1362658-HTML/image_m/fpsyg-15-1362658-g001.jpg	2025-05-14 23:04:23
55	0.114	5	NewsAPI	Google and Microsoft heat up the AI race as OpenAI opens new front with big acquisition	It was all about AI at all the big events this week — Microsoft Build, Google I/O, Dell Tech World, Red Hat Summit and even Computex. This time at I/O, Google appeared to get the upper hand, vibe-wise, with a flurry of new models and features, a vision of a u…	It was all about AI at all the big events this week — Microsoft Build, Google I/O, Dell Tech World, Red Hat Summit and even Computex.\r\nThis time at I/O, Google appeared to get the upper hand, vibe-wi… [+13056 chars]	https://siliconangle.com/2025/05/23/google-microsoft-heat-ai-race-openai-opens-new-front-big-acquisition/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2025/05/ai-msft-vs-google-1.jpeg	2025-05-23 14:58:34
56	0.114	5	NewsAPI	How generative AI is playing out in the media industry	GenAI is proving a double-edged sword in society at large, but especially in the creative industries. SA Mathieson delves below the headlines	Many writers, illustrators and musicians see generative artificial intelligence (GenAI) as a threat, something that exploits their creative work to produce algorithmic knock-offs, undermining their a… [+10575 chars]	https://www.computerweekly.com/feature/How-Generative-AI-is-playing-out-in-media-industry	https://www.computerweekly.com/visuals/ComputerWeekly/HeroImages/AI-robot-creative-human-brain-WhoisDanny-adobe.jpg	2025-05-06 07:15:00
58	0	5	NewsAPI	When algorithms take the field – inside MLB’s robo-umping experiment	Technological advances that lead to fairer, more accurate calls are often seen as triumphs. But new technology doesn’t mean perfect precision – nor does it necessarily create a better fan experience.	Baseball fans who tuned into spring training games may have noticed another new wrinkle in a sport thats experienced a host of changes in recent years.\r\nBatters, pitchers and catchers were able to ch… [+8999 chars]	https://sports.yahoo.com/article/algorithms-field-inside-mlb-robo-141857714.html	https://s.yimg.com/ny/api/res/1.2/U07_Dr5DmiisvU9Ju_oTFg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03OTc7Y2Y9d2VicA--/https://media.zenfs.com/en/the_conversation_us_articles_815/e2e13bd5985317946367da01324bbcc3	2025-04-28 14:18:57
59	0	5	NewsAPI	Why agency and cognition are fundamentally not computational	Article URL: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full\nComments URL: https://news.ycombinator.com/item?id=43990107\nPoints: 4\n# Comments: 0	“To live is to know.”\r\n(Maturana, 1988)\r\n“Between the stimulus and the response, there is a space. And in that space lies our freedom and power to choose our responses.”\r\n(Frankl, 1946, 2020)\r\n“Volun… [+166123 chars]	https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full	https://images-provider.frontiersin.org/api/ipx/w=1200&f=png/https://www.frontiersin.org/files/Articles/1362658/fpsyg-15-1362658-HTML/image_m/fpsyg-15-1362658-g001.jpg	2025-05-14 23:04:23
60	0	5	NewsAPI	Princeton faculty recognized for their impact as outstanding mentors of graduate students	Elizabeth Margulis, Arvind Narayanan, Kristina Olson and Serguei Oushakine are the recipients of this year's Graduate Mentoring Awards.	Four Princeton University faculty members have been selected as recipients of the 2025 Graduate Mentoring Awards. \r\nCo-sponsored by the Graduate School and the McGraw Center for Teaching and Learning… [+7811 chars]	https://www.princeton.edu/news/2025/05/15/princeton-faculty-recognized-their-impact-outstanding-mentors-graduate-students	https://www.princeton.edu/sites/default/files/styles/scale_1440/public/images/2025/05/Grad-Mentor-cover-2.jpg?itok=pZyTl9-f	2025-05-15 14:59:00
61	0.208	6	NewsAPI	Why Depth Is a Critical Advantage in the Age of AI	The future is unpredictable. We know that. So, when we try to design learning experiences that “prepare students for the future,” we have to recognize that we don’t always know what they’ll need. In this article, I explore the counterintuitive reality that th…	The future is unpredictable. We know that. So, when we try to design learning experiences that “prepare students for the future,” we have to recognize that we don’t always know what they’ll need. In … [+17083 chars]	https://spencereducation.com/depth-ai/	https://spencereducation.com/wp-content/uploads/2025/04/background2.png	2025-04-30 02:13:16
62	0.2	6	NewsDATA	Ex-Apple Engineers Behind $200M Xnor Deal Launch ElastixAI, Secure $16M To Revolutionize AI Inference Across Devices	Seattle-based ElastixAI, founded just months ago by veteran engineers behind Apple's (NASDAQ:AAPL) $200 million acquisition of Xnor, has raised $16 million from top-tier investors, including Bellevue-based capital venture company FUSE.The stealth-mode startup with elite Apple pedigree is quietly tackling one of the most expensive pain points in artificial intelligence deployment: inference, GeekWire reports.Don't Miss:Hasbro, MGM, and Skechers trust this AI marketing firm — Invest before it's too late.‘Scrolling To UBI' — Deloitte's #1 fastest-growing software company allows users to earn money on their phones. You can invest today for just $0.30/share with a $1000 minimum.Elite Founders With Track Records at Apple, Waymo, Meta, and AI2The founding team behind ElastixAI is no stranger to cutting-edge AI. According to GeekWire, CEO Mohammad Rastegari was co-founder and chief technology officer of Xnor, which was acquired by Apple in 2020 for its groundbreaking edge-based AI tools.He spent four years at Apple following the acquisition and most recently served as a distinguished scientist at Meta (NASDAQ:META). Rastegari is also an affiliate assistant professor at the University of Washington and spent five years at the Allen Institute for AI, co-founded by the late Microsoft (NASDAQ:MSFT) visionary Paul Allen, ...Full story available on Benzinga.com	ONLY AVAILABLE IN PAID PLANS	https://www.benzinga.com/news/25/05/45600990/ex-apple-engineers-behind-200m-xnor-deal-launch-elastixai-secure-16m-to-revolutionize-ai-inference-across-de	https://cdn.benzinga.com/files/images/story/2025/05/24/data-center-ai.png?auto=jpg&dpr=1&fit=crop&height=480&optimize=medium&width=720	2025-05-24 19:00:47
63	0.1	6	NewsAPI	The ‘era of experience’ will unleash self-learning AI agents across the web—here’s how to prepare	AI visionaries predict an 'Era of Experience' where AI learns autonomously, and it will have important implications for application design.	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nDavid Silver and Richard Sutton, two renowned AI scientists, argue in a… [+6913 chars]	https://venturebeat.com/ai/the-era-of-experience-will-unleash-self-learning-ai-agents-across-the-web-heres-how-to-prepare/	https://venturebeat.com/wp-content/uploads/2025/04/era-of-experience.webp?w=1024?w=1200&strip=all	2025-04-30 20:38:01
64	0.1	6	NewsAPI	US Air Force wants to develop smarter mini-drones powered by brain-inspired AI chips	Plans are underway to create new AI-powered drones that can fly for much longer than current designs.	Scientists are developing an artificial intelligence (AI) chip the size of a grain of rice that can mimic human brains — and they plan to use it in miniature drones.\r\nAlthough AI can automate monoton… [+2748 chars]	https://www.livescience.com/technology/artificial-intelligence/us-air-force-wants-to-develop-smarter-mini-drones-powered-by-brain-inspired-ai	https://cdn.mos.cms.futurecdn.net/itNaNmkkKnSUjPxXWcKiPk.jpg	2025-05-06 11:00:30
65	0.1	6	NewsAPI	‘In ‘93, it became clear to me AI should be decentralized’ — Ben Goertzel	It’s been 30 years since computer scientist Ben Goertzel wrote his first line of AI code, already convinced that artificial intelligence should be decentralized. Today, as the world approaches the dawn of Artificial General Intelligence (AGI), who leads this …	Its been 30 years since computer scientist Ben Goertzel wrote his first line of AI code, already convinced that artificial intelligence should be decentralized. Today, as the world approaches the daw… [+4437 chars]	https://cointelegraph.com/news/ben-goertzel-ai-decentralization-interview	https://images.cointelegraph.com/cdn-cgi/image/format=auto,onerror=redirect,quality=90,width=1200/https://s3.cointelegraph.com/uploads/2025-05/0196fdc0-fbda-71df-96b8-42b91195a33b	2025-05-23 17:58:20
87	0.076	7	NewsAPI	Biden's cancer diagnosis raises fresh questions about his health in White House	The news that he has "aggressive" prostate cancer has some medics asking why it was not detected sooner.	Joe Biden's announcement that he has been diagnosed with prostate cancer has revived questions about what health issues the former US president was dealing with while he was in the White House.\r\nIn a… [+4498 chars]	https://www.bbc.com/news/articles/cwyn0zm8d20o	https://ichef.bbci.co.uk/news/1024/branded_news/743e/live/594cc2b0-351a-11f0-9a97-e5279a0b9b03.jpg	2025-05-20 13:07:53
66	0.1	6	NewsAPI	Mind Readings: Saving Time With Generative AI, Part 2	In this episode, learn how to automate your AI workflows. You will discover the two main paths for automating AI effectively. You will learn about accessible no-code tools perfect for getting started quickly. You will understand the essential technical requir…	In this episode, learn how to automate your AI workflows.\r\nYou will discover the two main paths for automating AI effectively. You will learn about accessible no-code tools perfect for getting starte… [+10068 chars]	https://www.christopherspenn.com/2025/05/mind-readings-saving-time-with-generative-ai-part-2/	https://www.christopherspenn.com/wp-content/uploads/2025/05/Mind-Readings-Saving-Time-With-Generative-AI-Part-2.png	2025-05-06 09:55:34
67	0.1	6	NewsAPI	Will AI decide if you get your next job? New research says it could	Artificial intelligence hiring systems are being used by Australian employers in recruitment, but new research suggests it may “enable discrimination” against marginalised groups.	Artificial intelligence hiring systems are increasingly being used by Australian employers to screen and shortlist job candidates, but new research finds this technology creates serious risks of disc… [+11642 chars]	https://www.abc.net.au/news/2025-05-08/ai-job-recruitment-tools-could-enable-discrimination-research/105258820	https://live-production.wcms.abc-cdn.net.au/b59a8a51fc0bb2a01345528afdb3754a?impolicy=wcms_watermark_news&cropH=2160&cropW=3840&xPos=128&yPos=0&width=862&height=485&imformat=generic	2025-05-07 21:00:00
68	0.1	6	NewsAPI	This AI-designed drug for IBD was just given to human subjects for the first time	Absci entered its new drug into Phase I trials in half the time and for many millions of dollars less than it would have cost without AI.	"We're excited to become a clinical-stage biotech company; it's exciting from an AI drug discovery standpoint," says Absci founder and CEO Sean McClain.\r\nAbsci\r\nArtificial intelligence has been worki… [+8784 chars]	https://www.zdnet.com/article/this-ai-designed-drug-for-ibd-was-just-given-to-human-subjects-for-the-first-time/	https://www.zdnet.com/a/img/resize/f4bdc4720e42d9d419119c6d7162c871a8e837d2/2025/05/13/f14c8bb7-bf23-4f0e-ae91-34af5d2f0baa/gettyimages-1374389013.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-13 21:54:06
69	0.1	6	NewsAPI	Video Friday: Flying Robot SPIDAR	Video Friday is your weekly selection of awesome robotics videos, collected by your friends at IEEE Spectrum robotics. We also post a weekly calendar of upcoming robotics events for the next few months. Please send us your events for inclusion.London Humanoid…	Video Friday is your weekly selection of awesome robotics videos, collected by your friends at IEEE Spectrum robotics. We also post a weekly calendar of upcoming robotics events for the next few mont… [+4526 chars]	https://spectrum.ieee.org/video-friday-flying-robot-spidar	https://spectrum.ieee.org/media-library/image.png?id=60308417&width=1200&height=600&coordinates=0%2C60%2C0%2C60	2025-05-23 15:30:03
70	0.1	6	NewsAPI	AI Research Scientist – Multi-Modal Retrieval Systems and Vision Language Models	Build the future of the AI Data Cloud. Join the Snowflake team. Snowflake delivers a unified platform for secure development and deployment of LLMs and ML models. Snowflake AI and ML capabilities allow you to create generative AI applications with fully manag…	Build the future of the AI Data Cloud. Join the Snowflake team. \r\nSnowflake delivers a unified platform for secure development and deployment of LLMs and ML models. Snowflake AI and ML capabilities a… [+4202 chars]	https://nlppeople.com/job/ai-research-scientist-multi-modal-retrieval-systems-and-vision-language-models/	https://i0.wp.com/nlppeople.com/wp-content/uploads/2025/04/Snowflake.png?fit=200%2C200&ssl=1	2025-04-26 00:00:00
71	0.1	6	NewsAPI	Data Scientist – QuantumBlack, AI by McKinsey	Your Growth Only at McKinsey Work on real-world, high-impact projects across a variety of industries– Identify micro patterns in data that our clients can exploit to maintain their competitive advantage and watch your technical solutions transform their day-t…	Your Growth Only at McKinsey \r\nWork on real-world, high-impact projects across a variety of industries Identify micro patterns in data that our clients can exploit to maintain their competitive advan… [+4402 chars]	https://nlppeople.com/job/data-scientist-quantumblack-ai-by-mckinsey-41/	https://i0.wp.com/nlppeople.com/wp-content/uploads/2025/05/McKinsey-Company-1.png?fit=1200%2C1200&ssl=1	2025-05-23 00:00:00
72	0.1	6	NewsDATA	The Sequence Radar #549: Google, Microsoft and Anthropic Monster AI Week	Probably the biggest week of AI releases in recent years.	ONLY AVAILABLE IN PAID PLANS	https://thesequence.substack.com/p/the-sequence-radar-549-google-microsoft	https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https:%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ffa6b8e5b-6a22-47a6-9107-f2ff494d8504_1024x1024.png	2025-05-25 11:02:41
73	0.1	6	NewsDATA	AI and handwriting analysis: A framework for early screening for dyslexia and dysgraphia	A new University at Buffalo-led study outlines how artificial intelligence-powered handwriting analysis may serve as an early detection tool for dyslexia and dysgraphia among young children.The post AI and handwriting analysis: A framework for early screening for dyslexia and dysgraphia appeared first on Digital Journal.	ONLY AVAILABLE IN PAID PLANS	https://www.digitaljournal.com/?p=3790415	https://www.digitaljournal.com/wp-content/uploads/2025/05/20190617_102706-EDIT.jpg	2025-05-24 20:03:30
74	0.1	6	NewsDATA	Dell Technologies Fuels Enterprise AI Innovation with Infrastructure, Solutions and Services	Dubai, UAE – May 23, 2025 – Dell Technologies (NYSE: DELL), the world’s No. 1 provider of AI infrastructure,1 announces Dell AI Factory advancements, including powerful and energy-efficient AI infrastructure, integrated partner ecosystem solutions and professional services to drive simpler and faster AI deployments. Why it matters AI is now essential for businesses, with 75% of ... Continue reading Dell Technologies Fuels Enterprise AI Innovation with Infrastructure, Solutions and Services →	ONLY AVAILABLE IN PAID PLANS	https://uaenews247.com/2025/05/24/dell-technologies-fuels-enterprise-ai-innovation-with-infrastructure-solutions-and-services/	https://uaenews247.com/wp-content/uploads/2025/05/dell-ai-factory.jpg	2025-05-24 09:54:33
75	0	6	NewsAPI	Google DeepMind’s AI Agent Dreams Up Algorithms Beyond Human Expertise	A new system that combines Gemini’s coding abilities with an evolutionary approach  improves datacenter scheduling, chip design, and fine-tune large language models.	A key question in artificial intelligence is how often models go beyond just regurgitating and remixing what they have learned and produce truly novel ideas or insights.\r\nA new project from Google De… [+3012 chars]	https://www.wired.com/story/google-deepminds-ai-agent-dreams-up-algorithms-beyond-human-expertise/	https://media.wired.com/photos/6823a54e83546d0fe3307acb/191:100/w_1280,c_limit/AI-Lab-Google-DeepMind-Computin-Agent-Business.jpg	2025-05-14 15:00:38
76	0	6	NewsAPI	What Happens When AI Starts To Ask the Questions?	Technology has forever served as science’s toolbox. But now that AI is being used to develop questions and methods as well, some scientists wonder what their role is going to become. The post What Happens When AI Starts To Ask the Questions? first appeared on…	When Mario Krenn was studying quantum physics at the University of Vienna, he was trained in a particular way of designing new experiments: You go to a blackboard, and you think very hard, he said. I… [+7753 chars]	https://www.quantamagazine.org/what-happens-when-ai-starts-to-ask-the-questions-20250430/	https://www.quantamagazine.org/wp-content/uploads/2025/04/AI-Warps-Science_crSally-Caulwell-Social.jpg	2025-04-30 13:58:57
77	0	6	NewsAPI	Challenges to high-performance computing threaten US innovation	Today’s supercomputers are enormously powerful, but the work they do − running AI and tackling difficult science − is pushing them to their limits. Building bigger supercomputers won’t be easy.	Oak Ridge National Laboratory's Frontier supercomputer is one of the world's fastest. Oak Ridge Leadership Computing Facility, CC BY\r\nHigh-performance computing, or HPC for short, might sound like so… [+8396 chars]	https://theconversation.com/challenges-to-high-performance-computing-threaten-us-innovation-255188	https://images.theconversation.com/files/667052/original/file-20250509-56-i9suzg.jpg?ixlib=rb-4.1.0&rect=0%2C480%2C3000%2C1500&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-14 12:24:05
78	0	6	NewsAPI	A Potential Path to Safer AI Development	The world’s most cited computer scientist warns that the current approach to developing AI models carries potentially catastrophic risks.	Imagine youre in a car with your loved ones, following an unfamiliar road up a spectacular mountain range. The problem? The way ahead is shrouded in fog, newly built, and lacking both signposts and g… [+8382 chars]	https://time.com/7283507/safer-ai-development/	https://api.time.com/wp-content/uploads/2025/05/AI-Car-Road.jpg?quality=85&w=1200&h=628&crop=1	2025-05-09 10:15:00
79	0	6	NewsAPI	Hybrid AI model crafts smooth, high-quality videos in seconds	The CausVid tool uses a full-sequence diffusion model to teach an autoregressive system to swiftly create videos. Users can generate clips and modify them on the fly with new prompts, turn a photo into moving scenes, and extend videos.	What would a behind-the-scenes look at a video generated by an artificial intelligence model be like? You might think the process is similar to stop-motion animation, where many images are created an… [+5534 chars]	https://news.mit.edu/2025/causevid-hybrid-ai-model-crafts-smooth-high-quality-videos-in-seconds-0506	https://news.mit.edu/sites/default/files/images/202504/MIT-CausVid.jpg	2025-05-06 16:15:00
80	0	6	NewsAPI	Prompt Like a Pro: AI Prompt Writing for Salesforce Admins	Let’s face it: As a Salesforce Admin, you’re already juggling workflows, security settings, automations, and the ever-growing stack of requests from across your org. Now, toss in generative artificial intelligence (AI) and suddenly, everyone expects you to be…	Lets face it: As a Salesforce Admin, you’re already juggling workflows, security settings, automations, and the ever-growing stack of requests from across your org. Now, toss in generative artificial… [+8588 chars]	https://admin.salesforce.com/blog/2025/prompt-like-a-pro-ai-prompt-writing-for-salesforce-admins	https://d3nqfz2gm66yqg.cloudfront.net/images/20250428153519/Text-w-Two-Photos-1.png	2025-05-13 15:30:08
81	0.265	7	NewsDATA	Guiconsulta gains national attention	LINGAYEN, Pangasinan — Pangasinan's bold initiative to promote universal primary health care through a local incentive program is capturing the interest of other local government units, with Quezon City Mayor Joy Belmonte expressing her intent to adopt the same model to benefit her city's nearly three million residents.Belmonte recently announced plans to enroll all Quezon City residents in the Philippine Health Insurance Corp.'s (PhilHealth) Konsulta package, a move believed to have been inspired by Pangasinan's rapid strides in expanding health care access under the leadership of Gov. Ramon Guico III.Launched in late 2024, Pangasinan's Government Unified Incentives for Medical Consultations, or Guiconsulta, grants a P300 cash incentive to individuals who enroll in the Konsulta program.Since its inception, the program has enrolled over one million residents, an exponential rise from just 30,000 enrollees when Guico assumed office in July 2022."Although attempts were made to discredit the program during the last election, we remain firm in our belief that this is the right step toward becoming the healthiest province in the country," Guico told reporters on Thursday.Under Konsulta, beneficiaries receive free outpatient services, including medical consultations, laboratory tests, health screenings, and essential medicines at PhilHealth-accredited facilities.PhilHealth Regional Vice President Dennis Adre recognized Pangasinan's pioneering approach."This program was fully funded by the provincial government. PhilHealth provided no cash incentives to enrollees. The P300 per person covered meals and transportation during sign-up activities," Adre said.In response to Quezon City's interest in replicating the model, Guico expressed both pride and a sense of vindication."I'm happy that they're on board," Guico said. "I've said from the start that Pangasinan pioneered this program. I was promoting it even last year. Sadly, during the campaign period, a lot of people were misled by false claims," he added.Guico also addressed allegations that the program was misused or marred by corruption."They claimed I pocketed P1,400 per enrollee because the Konsulta package is supposedly worth P1,700. But PhilHealth doesn't give money directly to patients. The payments go to hospitals and rural health units," he clarified.He added that at the time the program was being criticized, PhilHealth had not released even a single peso to the provincial government facilities.The governor emphasized that PhilHealth reimbursements are based strictly on services rendered, such as consultations, diagnostics, and medication provided by health professionals."These funds go to doctors, nurses, pharmacists, and LGUs to keep operations running and purchase equipment," Guico said."Even those who tried to bring this program down will benefit from it. Their families will receive free medicine, free diagnostics, and even free hospitalization," he added.Guico called on critics to set politics aside, particularly when it comes to public health."You can play politics with any issue — but not health care," he said. "This is about saving lives. This is about ensuring every Pangasinense, no matter their background, has access to quality medical care."Guico said the program continues to evolve to meet the needs of the people — and that it is here to stay."What we began in Pangasinan is now being recognized across the country," Guico said. "This proves that governance rooted in compassion and focused on health can save lives and inspire change."	ONLY AVAILABLE IN PAID PLANS	https://www.manilatimes.net/2025/05/26/regions/guiconsulta-gains-national-attention/2120591	https://www.manilatimes.net/manilatimes/uploads/images/2025/05/25/636383.jpg	2025-05-25 16:09:00
82	0.159	7	NewsAPI	Under Siege: The Medical Sciences	A Personal Perspective: What you believe is what you perceive. The more a person is attached to a particular ideology, the more likely they will subscribe to false beliefs.	We are witnessing an unprecedented assault on scientific truth that has adversely impacted public health in the U.S. and to a lesser extent in Canada. \r\nWhat you believe is what you perceive. The str… [+6110 chars]	https://www.psychologytoday.com/us/blog/explorations-of-the-mind/202504/under-siege-the-medical-sciences	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_images/2025-04/download.jpg?itok=5iY8HRfQ	2025-04-27 15:51:46
83	0.113	7	NewsDATA	Subsuming CHI into HSE will be one of options considered, says Bernard Gloster	The potential for Children’s Health Ireland (CHI) to be fully subsumed into the HSE will be one option considered amid concerns around clinical care and governance, HSE chief Bernard Gloster has said. Mr Gloster was commenting on the steps open to Minister for Health Jennifer Carroll MacNeill as she	ONLY AVAILABLE IN PAID PLANS	https://www.kilkennypeople.ie/news/national-news/1810464/subsuming-chi-into-hse-will-be-one-of-options-considered-says-bernard-gloster.html	https://www.kilkennypeople.ie/resizer/300/200/true/pa/2025_05_25/1748189102643_0.jpg--.jpg?1748189102918=	2025-05-25 16:05:06
84	0.076	7	NewsAPI	Health care for transgender children questioned in 400-page Trump administration report	President Trump called for the report, which is a 400-page document, in an executive order, titled "Protecting Children From Chemical and Surgical Mutilation."	On Thursday, the Department of Health and Human Services published a 400-page document entitled "Treatment for Pediatric Gender Dysphoria: Review of Evidence and Best Practices."\r\nThe review's author… [+4909 chars]	https://www.npr.org/sections/shots-health-news/2025/05/01/nx-s1-5383599/transgender-gender-affirming-care-trump-hhs	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/6000x3375+0+0/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F3b%2Fdd%2F753f81d84751b3195f681988fa7b%2Fap25121500052450.jpg	2025-05-01 22:56:17
85	0.076	7	NewsAPI	Our post-SSRI era: A new network of clinics is opening up to help people wean off antidepressants	A new network of online clinics called Outro aims to get people off antidepressants — slowly.	iStock, Getty Images\r\n<ul><li>Many patients end up "parked" on antidepressant meds.</li><li>It can be tough to quit on your own. Withdrawal symptoms can range from mild to severe.</li><li>A first-of-… [+8611 chars]	https://www.businessinsider.com/how-to-quit-antidepressants-online-clinic-outro-tapering-microdosing-2025-5	https://i.insider.com/6823bcbec6ad288d1480d972?width=1200&format=jpeg	2025-05-14 09:01:01
86	0.076	7	NewsAPI	The MAHA Takeover Is Complete	Casey Means, Trump’s surgeon-general nominee, has a lot in common with RFK Jr.	The surgeon general, America’s doctor, is the public face of medicine in the United States. The job is more educational than it is technical. Vivek Murthy, who was appointed as surgeon general during… [+6303 chars]	https://www.theatlantic.com/health/archive/2025/05/casey-means-surgeon-general-maha/682747/	https://cdn.theatlantic.com/thumbor/kE3E4QFV4ZYk2ZLxSKf-u9SzLrs=/0x43:2000x1085/1200x625/media/img/mt/2025/05/confirmation_maha2/original.jpg	2025-05-08 19:30:00
88	0.076	7	NewsAPI	Trump picked a wellness influencer to be surgeon general and it’s breaking MAHA brains	The Make America Healthy Again movement’s infiltration of federal health policy took another step forward last week when President Donald Trump nominated Dr. Casey Means, a “metabolic health evangelist” and an ally of Health Secretary Robert F. Kennedy, Jr. t…	Dr. Casey Meansm (left), a wellness influencer, at confirmation hearing for Robert F. Kennedy Jr. for the Secretary of Health and Human Services. | Ben Curtis/AP Photo\r\n\n\nThe Make America Healthy Aga… [+9265 chars]	https://www.vox.com/public-health/412778/rfk-jr-casey-means-surgeon-general-trump	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/AP25127848613905.jpg?quality=90&strip=all&crop=0%2C10.73003698285%2C100%2C78.5399260343&w=1200	2025-05-12 23:00:31
89	0.076	7	NewsAPI	One woman's fight to remove barriers for aspiring doctors with disabilities	After her dreams of becoming a doctor were denied, one California woman is working to make the profession more accessible to those with disabilities.	All through her 20s, Taylor Carty chased her dream of becoming a doctor.\r\nCarty, now 30, was diagnosed with cerebral palsy when she was a baby, and was inspired by the many doctors and health care pr… [+7692 chars]	https://www.npr.org/2025/05/15/nx-s1-5272736/doctor-disability-medical-field	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/6000x3375+0+313/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F72%2F68%2F6651706548b9ad34ecfadbfc840c%2F2025-04-23-carty-gwidyatmadja-02.jpg	2025-05-15 13:19:24
90	0.076	7	NewsAPI	Trump names doctor-turned-wellness influencer Casey Means as new surgeon general pick	U.S. President Donald Trump is tapping Dr. Casey Means, a physician-turned-wellness influencer with close ties to Health and Human Services Secretary Robert F. Kennedy Jr., as his nominee for surgeon general after withdrawing his initial pick for the influent…	U.S. President Donald Trump is tapping Dr. Casey Means, a physician-turned-wellness influencer with close ties to Health and Human Services Secretary Robert F. Kennedy Jr., as his nominee for surgeon… [+6374 chars]	https://www.cbc.ca/news/world/casey-means-surgeon-general-nominee-1.7529470	https://i.cbc.ca/1.7529471.1746664215!/cpImage/httpImage/image.jpg_gen/derivatives/16x9_1180/casey-means-standing-alongside-journalist-megan-kelly.jpg?im=Resize%3D620	2025-05-08 01:25:00
91	0.076	7	NewsAPI	Trump administration taps wellness influencer for surgeon general	Trump picks Dr Casey Means, a close ally Health and Human Services Secretary Robert F Kennedy Jr for role.	United States President Donald Trump has selected Doctor Casey Means, a wellness influencer with close ties to Health Secretary Robert F Kennedy Jr, as his nominee for surgeon general after withdrawi… [+2763 chars]	https://www.aljazeera.com/news/2025/5/7/trump-administration-taps-wellness-influencer-for-surgeon-general	https://www.aljazeera.com/wp-content/uploads/2025/05/2025-04-16T175734Z_265418220_RC25ZDAV5UES_RTRMADP_3_HEALTH-USA-1746658119.jpg?resize=1920%2C1440	2025-05-07 23:09:37
92	0.076	7	NewsAPI	AMA Picks WebMD Doctor With U.S. Health Policy Background As New CEO	The American Medical Association named as its new CEO Dr. John Whyte, an executive at WebMD who has also held roles at the U.S. Department of Health and Human Services.	The American Medical Association Friday named as its new CEO Dr. John J. Whyte a former chief ... More medical officer at WebMD who also worked at the U.S. Department of Health and Humana Services an… [+2221 chars]	https://www.forbes.com/sites/brucejapsen/2025/05/09/ama-picks-webmd-doctor-with-us-health-policy-background-as-new-ceo/	https://imageio.forbes.com/specials-images/imageserve/681e2da5ad57406a6363da8c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-09 16:42:05
93	0.076	7	NewsAPI	Texas Lawmakers Approve Bill To Expand Medical Cannabis Program	A new bill approved by Texas lawmakers aims to broaden medical cannabis program, expanding patient access and allowing the use of additional cannabis products.	The Texas House has approved a bill that would expand the state's medical marijuana laws to cover ... More more patients. (Erin Hooley/Chicago Tribune/Tribune News Service via Getty Images)\r\nTribune … [+4437 chars]	https://www.forbes.com/sites/dariosabaghi/2025/05/13/texas-lawmakers-approve-bill-to-expand-medical-cannabis-program/	https://imageio.forbes.com/specials-images/imageserve/6822e971be71e5da87baf007/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-13 10:00:39
94	0.076	7	NewsAPI	Millions of Canadians' health data available for sale to pharmaceutical industry, study shows	Details about your health, medical history and prescriptions can all be found in your medical record. A new Canadian study found in some cases, private companies are accessing parts of that data and selling it.	Going to the doctor can involve sharing your most personal information, including details about your health, medical history and prescriptions. \r\nIt all ends up in your medical record  but a new stud… [+5083 chars]	https://www.cbc.ca/news/health/health-data-records-pharmaceutical-private-clinics-1.7529955	https://i.cbc.ca/1.7109826.1746724430!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/dr-sheryl-spithoff.jpg?im=Resize%3D620	2025-05-09 08:01:06
95	0.076	7	NewsAPI	Money and masculinity: How wellness became big business and changed American health culture	In the first months of Donald Trump’s second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F. Kennedy Jr.Read more...	In the first months of Donald Trumps second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F.… [+10134 chars]	https://qz.com/rfk-wellness-business-health-culture-1851779931	https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/862a2698550a07275b939efe0ca1808c.jpg	2025-05-15 09:00:00
96	0.076	7	NewsDATA	Subsuming CHI into HSE will be one of options considered, says Bernard Gloster	The HSE chief was commenting following a series of recent controversies involving Children’s Health Ireland.	ONLY AVAILABLE IN PAID PLANS	https://www.breakingnews.ie/ireland/subsuming-chi-into-hse-will-be-one-of-options-considered-says-bernard-gloster-1766433.html	https://img.resized.co/breaking-news/eyJkYXRhIjoie1widXJsXCI6XCJodHRwczpcXFwvXFxcL2ltYWdlcy5icmVha2luZ25ld3MuaWVcXFwvcHJvZFxcXC91cGxvYWRzXFxcLzIwMjVcXFwvMDVcXFwvMjUxNzQyMjFcXFwvMi43Mzc3NzM3NS0xLWUxNzQ4MTkxNDUwNTQwLmpwZ1wiLFwid2lkdGhcIjoxMDI0LFwiaGVpZ2h0XCI6bnVsbCxcImRlZmF1bHRcIjpcImh0dHBzOlxcXC9cXFwvd3d3LmJyZWFraW5nbmV3cy5pZVxcXC9pbWFnZXNcXFwvbm8taW1hZ2UucG5nXCIsXCJvcHRpb25zXCI6W119IiwiaGFzaCI6IjZlMDhiOWM2MGZmODMzMjBiYmIyOWVhNTY0NjJhMzI0MDVlODY4MTUifQ==/2-73777375-1-e1748191450540.jpg	2025-05-25 16:44:18
117	0	8	NewsAPI	iOS 19 brings these 3 game-changing upgrades to iPhones in 2025	Apple's upcoming iOS 19 update has generated significant buzz within the tech community. With the official announcement just weeks away, leaks suggest three	Apple's upcoming iOS 19 update has generated significant buzz within the tech community. With the official announcement just weeks away, leaks suggest three major innovations that will transform the … [+5729 chars]	https://www.talkandroid.com/507122-ios-19-brings-these-3-game-changing-upgrades-to-iphones-in-2025/	https://www.talkandroid.com/wp-content/uploads/2025/05/Canva-TalkAndroid-19-1.png	2025-05-19 06:30:00
97	0.076	7	NewsDATA	Subsuming CHI into HSE will be one of options considered, says Bernard Gloster	The potential for Children’s Health Ireland (CHI) to be fully subsumed into the HSE will be one option considered amid concerns around clinical care and governance, HSE chief Bernard Gloster has said.	ONLY AVAILABLE IN PAID PLANS	https://www.belfasttelegraph.co.uk/news/republic-of-ireland/subsuming-chi-into-hse-will-be-one-of-options-considered-says-bernard-gloster/a558551875.html	https://focus.belfasttelegraph.co.uk/thumbor/sSB_A1aPWn_UiXnBcavePjciYcw=/720x0/smart/prod-mh-ireland/99c1e966-d92e-49a9-8fb5-73de9384a247/9f527b89-22f4-4780-80ef-1f86f6a49a9f/2.73777375.jpg	2025-05-25 16:00:11
98	0.076	7	NewsDATA	Internet Medical Services Market to Grow at 16 % CAGR from 2025 to 2032 as Digital Healthcare Gains Global Momentum	The world of healthcare is changing rapidly. The way people access medical advice, track their health, and receive treatment has been transformed by technology. What was once done face-to-face is now happening through screens, apps, and virtual consultations. This shift	ONLY AVAILABLE IN PAID PLANS	https://www.openpr.com/news/4034647/internet-medical-services-market-to-grow-at-16-cagr-from-2025	https://cdn.open-pr.com/L/5/L525675587_g.jpg	2025-05-25 15:58:44
99	0.076	7	NewsDATA	Top medic's warning after Yorkshire woman fights for life after weightloss jab	Health bosses have issued a warning after police arrested three women in connection with the incident	ONLY AVAILABLE IN PAID PLANS	https://www.examinerlive.co.uk/news/local-news/top-medics-warning-after-yorkshire-31721135	https://i2-prod.examinerlive.co.uk/news/west-yorkshire-news/article31721134.ece/ALTERNATES/s615/0_Injections-for-weight-loss-with-Semaglutide-An-obese-woman-gives-a-hormonal-injection-into-the-abdomen-with-a-pen.jpg	2025-05-25 15:54:09
100	0	7	NewsAPI	Montana Becomes the Right to Try Anything State, Expanding Access to Experimental Drugs	SB 535 formally paves the way for health care clinics to become 'experimental treatment centers' that can provide drugs still in development to willing patients.	Montana is set to become a proving ground for experimental medical treatments, thanks to a newly passed bill.\r\nThe bill, signed into law by Governor Greg Gianforte this week, will permit clinics and … [+3365 chars]	https://gizmodo.com/montana-becomes-the-right-to-try-anything-state-expanding-access-to-experimental-drugs-2000602189	https://gizmodo.com/app/uploads/2025/05/vial.jpg	2025-05-14 20:45:13
101	0.167	8	NewsAPI	Sask. measles cases more than doubled in past week, daily cases likely, chief medical officer says	All confirmed cases were linked to travel outside the province, but health officials are bracing for community spread as numbers rise.	Measles cases in Saskatchewan have more than doubled in the past week and health officials are expecting to see new cases daily, the province's top doctor says.\r\nSince March 14, the Saskatchewan Heal… [+2331 chars]	https://www.cbc.ca/news/canada/saskatoon/chief-medical-officer-measles-case-doubled-week-1.7529945	https://i.cbc.ca/1.7530109.1746727985!/fileImage/httpImage/image.jpeg_gen/derivatives/16x9_1180/dr-saqib-shahab.jpeg?im=Resize%3D620	2025-05-08 18:25:17
102	0.16	8	NewsAPI	181: all about stem cells with Dr. Joy Kong	Hi friends! I have a new podcast episode live and I’m so thrilled to talk to Dr. Joy Kong about a HOT health topic: stem cells. Here’s what we discuss: What exactly are stem cells, and how do they work to support healing and regeneration? What kinds of condit…	Hi friends! I have a new podcast episode live and Im so thrilled to talk to Dr. Joy Kong about a HOT health topic: stem cells.\r\nHeres what we discuss:\r\nWhat exactly are stem cells, and how do they wo… [+3779 chars]	https://fitnessista.com/181-all-about-stem-cells-with-dr-joy-kong/	https://fitnessista.com/wp-content/uploads//2025/05/181-all-about-stem-cells-with-Dr.-Joy-Kong.jpg	2025-05-22 10:37:14
103	0.08	8	NewsAPI	Trump picked a wellness influencer to be surgeon general and it’s breaking MAHA brains	The Make America Healthy Again movement’s infiltration of federal health policy took another step forward last week when President Donald Trump nominated Dr. Casey Means, a “metabolic health evangelist” and an ally of Health Secretary Robert F. Kennedy, Jr. t…	Dr. Casey Meansm (left), a wellness influencer, at confirmation hearing for Robert F. Kennedy Jr. for the Secretary of Health and Human Services. | Ben Curtis/AP Photo\r\n\n\nThe Make America Healthy Aga… [+9265 chars]	https://www.vox.com/public-health/412778/rfk-jr-casey-means-surgeon-general-trump	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/AP25127848613905.jpg?quality=90&strip=all&crop=0%2C10.73003698285%2C100%2C78.5399260343&w=1200	2025-05-12 23:00:31
104	0.08	8	NewsAPI	Measles Vaccine Denial Is a Massive Brainwashing Campaign	A shameful mass propaganda campaign is unfolding in the U.S., one that will make millions of kids needlessly sick with measles	A long-running nationwide brainwashing campaign, conducted in plain sight, now comes to its deadly culmination. The predictable consequence—reviving a preventable childhood disease in the U.S.—is at … [+6473 chars]	https://www.scientificamerican.com/article/measles-vaccine-denial-is-a-massive-brainwashing-campaign/	https://static.scientificamerican.com/dam/m/3cdff5b9fa7fc43e/original/measles_victims_gravestones_protest_washington_dc.jpg?m=1746027561.151&w=1200	2025-04-30 15:30:00
105	0.08	8	NewsAPI	AMA Picks WebMD Doctor With U.S. Health Policy Background As New CEO	The American Medical Association named as its new CEO Dr. John Whyte, an executive at WebMD who has also held roles at the U.S. Department of Health and Human Services.	The American Medical Association Friday named as its new CEO Dr. John J. Whyte a former chief ... More medical officer at WebMD who also worked at the U.S. Department of Health and Humana Services an… [+2221 chars]	https://www.forbes.com/sites/brucejapsen/2025/05/09/ama-picks-webmd-doctor-with-us-health-policy-background-as-new-ceo/	https://imageio.forbes.com/specials-images/imageserve/681e2da5ad57406a6363da8c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-09 16:42:05
106	0.08	8	NewsAPI	Health P.E.I. spending thousands of dollars a month on private employment agencies, contracts reveal	Health P.E.I. has hired six senior managers through private employment agencies at costs ranging from $17,490 a month to $43,750 a month.	Health P.E.I. has hired six senior managers on an interim basis through private employment agencies at costs ranging from $17,490 a month to $43,750 a month. \r\nThat information is contained in a seri… [+8113 chars]	https://www.cbc.ca/news/canada/prince-edward-island/pei-health-pei-salaries-interim-executives-1.7540150	https://i.cbc.ca/1.7288685.1723130218!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/health-pei-ceo-melanie-fraser.jpg?im=Resize%3D620	2025-05-23 09:00:00
138	0	9	NewsAPI	‘Illness and Its Very Concept’	When I decided to move from Brooklyn to Berlin in 2017, I was attracted by the prospect of a medical system that would protect me from debt and premature death. Like eighty-six percent of people living in Germany, I have statutory health insurance, which mean…	When I decided to move from Brooklyn to Berlin in 2017, I was attracted by the prospect of a medical system that would protect me from debt and premature death. Like eighty-six percent of people livi… [+20687 chars]	https://www.nybooks.com/online/2025/05/02/illness-and-its-very-concept/	https://www.nybooks.com/wp-content/uploads/2025/05/Bonhomme202504_4.jpeg	2025-05-02 18:14:06
107	0.08	8	NewsAPI	How COVID antivaxxers fuelled a worrying backlash to a life-saving science	Vaccine Nation is a warning about the acceleration of the anti-vaccination movement during the pandemic and worrying declines in vaccination rates around the world. Can we correct course before it's too late?	Professor Raina MacIntyre was waiting quietly in the emergency department of a busy hospital last year when she overheard a conversation she'll never forget. \r\nThe patient in the cubicle next to hers… [+13875 chars]	https://www.abc.net.au/news/2025-04-27/vaccine-nation-public-health-gains-warning-covid-pandemic/105103190	https://live-production.wcms.abc-cdn.net.au/de2339797f959a3aa8eb8ebc48f40359?impolicy=wcms_watermark_news&cropH=1351&cropW=2400&xPos=0&yPos=157&width=862&height=485&imformat=generic	2025-04-26 19:00:00
108	0.08	8	NewsDATA	Internet Medical Services Market to Grow at 16 % CAGR from 2025 to 2032 as Digital Healthcare Gains Global Momentum	The world of healthcare is changing rapidly. The way people access medical advice, track their health, and receive treatment has been transformed by technology. What was once done face-to-face is now happening through screens, apps, and virtual consultations. This shift	ONLY AVAILABLE IN PAID PLANS	https://www.openpr.com/news/4034647/internet-medical-services-market-to-grow-at-16-cagr-from-2025	https://cdn.open-pr.com/L/5/L525675587_g.jpg	2025-05-25 15:58:44
109	0	8	NewsAPI	What Casey Means and MAHA Want You to Fear	Amid the destruction of America's public-health systems, Donald Trump’s Surgeon General nominee, Casey Means, believes that your wellness is yours alone to defend. Jessica Winter reports.	If you close your eyes and imagine an up-from-the-bootstraps embodiment of boomer triumphalismthe ambitious young technocrat of a systems novel by Don DeLillo or Thomas Pynchon, sprinting toward his … [+15264 chars]	https://www.newyorker.com/books/second-read/what-casey-means-and-maha-small-want-you-to-fear	https://media.newyorker.com/photos/682b4efc039488c8ef12debd/16:9/w_1280,c_limit/Winter-Casey-Means.jpg	2025-05-22 10:00:00
110	0	8	NewsAPI	What Casey Means and MAHA Want You to Fear	Amid the destruction of America's public-health systems, Donald Trump’s Surgeon General nominee, Casey Means, believes that your wellness is yours alone to defend. Jessica Winter reports.	If you close your eyes and imagine an up-from-the-bootstraps embodiment of boomer triumphalismthe ambitious young technocrat of a systems novel by Don DeLillo or Thomas Pynchon, sprinting toward his … [+15264 chars]	https://www.newyorker.com/news/the-lede/what-casey-means-and-maha-want-you-to-fear	https://media.newyorker.com/photos/682b4efc039488c8ef12debd/16:9/w_1280,c_limit/Winter-Casey-Means.jpg	2025-05-22 10:00:00
111	0	8	NewsAPI	A Public Health Researcher and Her Engineer Husband Found How Diseases Can Spread through Air Decades before the COVID Pandemic	Mildred Weeks Wells and her husband figured out that disease-causing pathogens can spread through the air like smoke	Air-Borne: The Hidden History of the Life We Breathe, by Carl Zimmer, charts the history of the field of aerobiology: the science of airborne microorganisms. In this episode, we discover the story of… [+33528 chars]	https://www.scientificamerican.com/article/a-public-health-researcher-and-her-engineer-husband-found-how-diseases-can/	https://static.scientificamerican.com/dam/m/924bb2302462b89/original/Lost-Women-of-Science-Partner-Podcast-Span-Art-Airborne.png?m=1747878912.787&w=1200	2025-05-22 16:00:00
112	0	8	NewsAPI	Australia's universal healthcare is crumbling. Can it be saved?	More and more Australians, regardless of where they live, are delaying or going without the care they need.	Tiffanie TurnbullReporting from\r\nStreaky Bay, South Australia\r\nFrom an office perched on the scalloped edge of the continent, Victoria Bradley jokes that she has the most beautiful doctor's practice … [+14610 chars]	https://www.bbc.com/news/articles/cnv56q82vnro	https://ichef.bbci.co.uk/news/1024/branded_news/a88f/live/ebd0d3f0-228d-11f0-8c2e-77498b1ce297.png	2025-04-26 22:41:37
113	0	8	NewsAPI	Blue Land of Enchantment Lures Unhappy Texans	The Land of Enchantment has quietly become a blue refuge in the MAGA red West for Americans who are fleeing extreme conservative strongholds.	SANTA FE, N.M. The sun is sinking behind the Jemez Mountains as a group of Texas expats gathers with their pint glasses inside a Santa Fe brewpub to consider the state they abandoned, and the state t… [+11442 chars]	https://www.npr.org/2025/05/20/nx-s1-5327452/blue-land-of-enchantment-lures-unhappy-texans	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+156/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F6e%2F3d%2F44842b2148e09e43f9bcc25c3a4f%2Fnpr-nmtx-20250409-02.jpg	2025-05-20 22:21:37
114	0	8	NewsAPI	Fired FTC commissioners on fighting for their jobs back	Today, we have something special for you: A few days ago, I hosted a panel with FTC commissioners Rebecca Slaughter and Alvaro Bedoya at the IAPP Global Privacy Summit in Washington, DC. We recorded the discussion, and we’re bringing it to you today. That’s a…	Fired FTC commissioners on fighting for their jobs back\r\nAlvaro Bedoya and Rebecca Slaughter want to take their fight to the Supreme Court, and they think they can win.\r\nFired FTC commissioners on fi… [+45090 chars]	https://www.theverge.com/decoder-podcast-with-nilay-patel/657115/ftc-bedoya-slaughter-trump-fired-supreme-court-interview	https://platform.theverge.com/wp-content/uploads/sites/2/2025/04/DCD-Bedoya-Slaughter-2.png?quality=90&strip=all&crop=0%2C10.711631919237%2C100%2C78.576736161526&w=1200	2025-04-28 14:00:17
115	0	8	NewsAPI	Seven Ways The FDA Cuts Could Impact You	The Trump administration's cuts to the FDA could pose major threats to people's health, by reducing critical oversight over the safety of food, medicine, and medical devices.	Quality control expert inspecting at food specimen in the laboratory\r\ngetty\r\nWhen you open your fridge, pantry, or medicine cabinet, you probably dont worry if whats inside could make you sick. For t… [+4697 chars]	https://www.forbes.com/sites/briancastrucci/2025/05/05/seven-ways-the-fda-cuts-could-impact-you/	https://imageio.forbes.com/specials-images/imageserve/6819037e4a901e94a1c243f8/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 18:37:57
116	0	8	NewsAPI	With BPD, Am I the Problem, or Is It the System?	Traditional medical models often neglect the role systemic inequities play in perpetuating borderline personality disorder symptoms. A different model offers a more helpful perspective.	For many, receiving a Borderline Personality Disorder (BPD) diagnosis feels overwhelming. It comes with negative labels such as unstable, clingy, impulsive, and immature. Many professionals still cli… [+7325 chars]	https://www.psychologytoday.com/us/blog/living-with-emotional-intensity/202504/with-bpd-am-i-the-problem-or-is-it-the-system	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-04/shutterstock_2332961145.jpg?itok=fpAQKXwy	2025-04-28 17:36:25
118	0	8	NewsAPI	The All New WHOOP: The World’s Most Powerful Health Wearable	WHOOP is redefining what a health wearable can be—bringing clinical-grade insights to your wrist with continuous vitals, edge and cloud-powered AI coaching.	Will Ahmed, Founder and CEO poses with Emily Capodilupo, SVP of Research Algorithms and Data on the ... More morning of their new product launch at WHOOP HQ in Boston, MA\r\nJohn Werner\r\nNew science on… [+11336 chars]	https://www.forbes.com/sites/johnwerner/2025/05/08/the-all-new-whoop-the-worlds-most-powerful-health-wearable/	https://imageio.forbes.com/specials-images/imageserve/681d2bc93949879059c77a4c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 23:00:06
119	0	8	NewsAPI	Doctors on the brink: Burnout, unsafe shifts, and a system in collapse	As a junior doctor in a busy emergency department Dr Fahad Khan expected long hours and high stress. What he didn't expect was a creeping concern that it might kill him.	As a junior doctor in a busy New South Wales emergency department, Dr Fahad Khan expected long hours, high stress and the pressure of life-or-death decisions. \r\nWhat he didn't expect was the creeping… [+7654 chars]	https://www.abc.net.au/news/2025-05-07/doctor-says-public-health-system-toxic-fears-it-could-kill-him/105245294	https://live-production.wcms.abc-cdn.net.au/2541376ae4d23b401a192913684d2baa?impolicy=wcms_watermark_news&cropH=2813&cropW=5000&xPos=0&yPos=0&width=862&height=485&imformat=generic	2025-05-07 06:29:25
120	0	8	NewsAPI	In 1975, thousands of babies were daringly airlifted from the Vietnam war	Some of those involved in 'Operation Babylift' recall the events - and what happened to the children after.	It is April 4, 1975, a beautiful, sunny day in Saigon soon to be renamed Ho Chi Minh City. But there is violence and turmoil in the air. The Vietnam War is in its final weeks, and North Vietnamese fo… [+21139 chars]	https://www.aljazeera.com/features/2025/4/26/in-1975-thousands-of-babies-were-daringly-airlifted-from-the-vietnam-war	https://www.aljazeera.com/wp-content/uploads/2025/04/Adoptees-onboard-one-of-the-flights.Courtesy-Frederick-Burkle-Jr.-1-1745573923.png?resize=1200%2C630	2025-04-26 05:57:31
121	0.196	9	NewsAPI	COVID worsened shortages of doctors and nurses. Five years on, rural hospitals still struggle	The effects of the pandemic accelerated shortages by pushing many doctors into early retirement.	By Natalie Krebs, Iowa Public Radio, KFF Health News\r\nEven by rural hospital standards, Keokuk County Hospital and Clinics in southeastern Iowa is small.\r\nThe 14-bed hospital, in Sigourney, doesnt do… [+8005 chars]	https://www.bostonherald.com/2025/04/27/rural-doctor-nurse-shortages/	https://www.bostonherald.com/wp-content/uploads/2025/04/202504230400MCT_____PHOTO____US-NEWS-HEALTH-RURAL-HOSPITALS-STAFFING-2-KHN.jpg?w=1024&h=682	2025-04-27 13:10:55
122	0.094	9	NewsAPI	Australia's universal healthcare is crumbling. Can it be saved?	More and more Australians, regardless of where they live, are delaying or going without the care they need.	Tiffanie TurnbullReporting from\r\nStreaky Bay, South Australia\r\nFrom an office perched on the scalloped edge of the continent, Victoria Bradley jokes that she has the most beautiful doctor's practice … [+14610 chars]	https://www.bbc.com/news/articles/cnv56q82vnro	https://ichef.bbci.co.uk/news/1024/branded_news/a88f/live/ebd0d3f0-228d-11f0-8c2e-77498b1ce297.png	2025-04-26 22:41:37
123	0.094	9	NewsAPI	Trump Says He’s ‘Surprised’ Public Didn’t Know Of Biden’s Cancer Diagnosis Sooner—As Others Fuel Speculation Of A Cover-Up	Biden announced Sunday he was diagnosed with an “aggressive” form of prostate cancer.	President Donald Trump said Monday he was surprised the public didnt know about former President Joe Bidens cancer diagnosis soonera comment that came after other Republicans, including Vice Presiden… [+5021 chars]	https://www.forbes.com/sites/saradorn/2025/05/19/trump-says-hes-surprised-public-didnt-know-of-bidens-cancer-diagnosis-sooner-as-others-fuel-speculation-of-a-cover-up/	https://imageio.forbes.com/specials-images/imageserve/682b5463cf2f673718ae9540/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-19 21:51:42
124	0.094	9	NewsAPI	Money and masculinity: How wellness became big business and changed American health culture	In the first months of Donald Trump’s second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F. Kennedy Jr.Read more...	In the first months of Donald Trumps second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F.… [+10134 chars]	https://qz.com/rfk-wellness-business-health-culture-1851779931	https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/862a2698550a07275b939efe0ca1808c.jpg	2025-05-15 09:00:00
125	0.094	9	NewsAPI	Millions of Canadians' health data available for sale to pharmaceutical industry, study shows	Details about your health, medical history and prescriptions can all be found in your medical record. A new Canadian study found in some cases, private companies are accessing parts of that data and selling it.	Going to the doctor can involve sharing your most personal information, including details about your health, medical history and prescriptions. \r\nIt all ends up in your medical record  but a new stud… [+5083 chars]	https://www.cbc.ca/news/health/health-data-records-pharmaceutical-private-clinics-1.7529955	https://i.cbc.ca/1.7109826.1746724430!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/dr-sheryl-spithoff.jpg?im=Resize%3D620	2025-05-09 08:01:06
126	0.094	9	NewsAPI	P.E.I. man, left debilitated after vaccine, misses out on deadline for compensation	A P.E.I. man wants others to be aware of a federal program that offers compensation for serious injuries from vaccines approved by Health Canada, since he missed the deadline for applying and has been left in dire straits.	A Prince Edward Island man wants others to be aware of a federal program that offers compensation for serious and permanent injuries from vaccines approved by Health Canada, since he missed the deadl… [+6772 chars]	https://www.cbc.ca/news/canada/prince-edward-island/pei-vaccine-injury-program-pei-man-too-late-1.7535573	https://i.cbc.ca/1.7535626.1747316773!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/kent-driscoll.jpg?im=Resize%3D620	2025-05-16 09:00:38
127	0.094	9	NewsAPI	Health Ranger Report: Dr. Suzanne Humphries reveals the hidden history of disease decline before vaccines were introduced	Dr. Suzanne Humphries argues that diseases like polio and measles were already in steep decline before vaccines were introduced due to sanitation, better nutrition and hygiene, not vaccines themselves. The narrative pushing vaccines as the sole savior of publ…	<ul><li>Dr. Suzanne Humphries argues that diseases like polio and measles were already in steep decline before vaccines were introduced due to sanitation, better nutrition and hygiene, not vaccines t… [+6062 chars]	https://www.naturalnews.com/2025-04-25-suzanne-humphries-reveals-pre-vaccine-disease-decline.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/04/Safe-and-Effective-Vaccines-1.jpg	2025-04-25 06:00:00
128	0.094	9	NewsAPI	The Covid-19 Crisis: How Political Meddling Threatens Your Health and Medical Freedom.	Doctors who successfully used early COVID-19 treatments like ivermectin faced severe backlash and censorship from medical and government authorities\nHospitals repeatedly blocked effective interventions, putting patients at unnecessary risk by ignoring treatme…	Doctors who successfully used early COVID-19 treatments like ivermectin faced severe backlash and censorship from medical and government authorities\r\nHospitals repeatedly blocked effective interventi… [+17255 chars]	https://www.globalresearch.ca/political-meddling-threatens-health-medical-freedom/5887504	https://www.globalresearch.ca/wp-content/uploads/2021/11/trucker-vaccine-covid.jpg	2025-05-19 14:39:21
129	0.094	9	NewsAPI	AI Tool Uses Selfies To Predict Biological Age And Cancer Survival	Doctors often start exams with the so-called "eyeball test" -- a snap judgment about whether the patient appears older or younger than their age, which can influence key medical decisions.	Doctors often start exams with the so-called "eyeball test" -- a snap judgment about whether the patient appears older or younger than their age, which can influence key medical decisions.\r\nThat intu… [+3713 chars]	https://www.ibtimes.com/ai-tool-uses-selfies-predict-biological-age-cancer-survival-3773000	https://d.ibtimes.com/en/full/4599659/three-pedestrians-take-selfie-picturesque-alleyway-end-rue-de-luniversite-paris.jpg	2025-05-08 22:36:07
130	0.094	9	NewsAPI	A Revolutionary New Algorithm Picks Your Biological Age From a Photo	Doctors often start exams with the so-called "eyeball test" – a snap judgment about whether the patient appears older or younger than their age, which can influence key medical decisions.	Doctors often start exams with the so-called "eyeball test" a snap judgment about whether the patient appears older or younger than their age, which can influence key medical decisions.\r\nThat intuiti… [+3824 chars]	https://www.sciencealert.com/a-revolutionary-new-algorithm-picks-your-biological-age-from-a-photo	https://www.sciencealert.com/images/2025/05/MansEyesBlackAndWhite.jpg	2025-05-09 05:09:14
131	0.094	9	NewsAPI	Slaying the healthcare zombie	When a photo of a dental unit at Tanao Sri Hospital -- a remote community hospital in Ratchaburi province -- using a frog-hunting head torch in place of a proper dental lamp went viral last month, it highlighted a grim reality: Thailand's public healthcare sy…	When a photo of a dental unit at Tanao Sri Hospital -- a remote community hospital in Ratchaburi province -- using a frog-hunting head torch in place of a proper dental lamp went viral last month, it… [+5007 chars]	https://www.bangkokpost.com/thailand/general/3016865/slaying-the-healthcare-zombie	https://static.bangkokpost.com/media/content/20250503/c1_3016865_250503055720_700.jpg	2025-05-02 22:58:00
132	0.094	9	NewsDATA	Internet Medical Services Market to Grow at 16 % CAGR from 2025 to 2032 as Digital Healthcare Gains Global Momentum	The world of healthcare is changing rapidly. The way people access medical advice, track their health, and receive treatment has been transformed by technology. What was once done face-to-face is now happening through screens, apps, and virtual consultations. This shift	ONLY AVAILABLE IN PAID PLANS	https://www.openpr.com/news/4034647/internet-medical-services-market-to-grow-at-16-cagr-from-2025	https://cdn.open-pr.com/L/5/L525675587_g.jpg	2025-05-25 15:58:44
133	0.094	9	NewsDATA	Biotechnology Advancements: Revolutionizing Healthcare Through Innovation and Precision	Biotechnology has emerged as a driving force in transforming healthcare. Over the past few decades, the integration of biology with advanced technology has led to significant breakthroughs. These innovations are not only redefining disease management but are also improving patient outcomes. As a result, the healthcare Space is fast transforming. Understanding Biotechnology and Its Role [...]The post Biotechnology Advancements: Revolutionizing Healthcare Through Innovation and Precision appeared first on TechBullion.	ONLY AVAILABLE IN PAID PLANS	https://techbullion.com/biotechnology-advancements-revolutionizing-healthcare-through-innovation-and-precision/	https://techbullion.com/wp-content/uploads/2025/05/Biotechnology-Advancements-Revolutionizing-Healthcare-Through-Innovation-and-Precision.jpg	2025-05-25 15:39:51
134	0.094	9	NewsDATA	From the Golden Age to the Gilded Age: The Era of Economic Discontent in Nigeria and What We Can Do About It	Recently, a former Nigerian president sparked a wave of national reactions with his statement: “I now feed by renting out my house in Kaduna.” Many Nigerians interpreted his remarks in different ways. Some saw it as evidence that he had not stolen public funds to support a luxurious lifestyle after his presidency. Others, however, argued [...]	ONLY AVAILABLE IN PAID PLANS	https://dailytrust.com/from-the-golden-age-to-the-gilded-age-the-era-of-economic-discontent-in-nigeria-and-what-we-can-do-about-it/	https://dailytrust.com/wp-content/uploads/2025/05/image001-1.png	2025-05-25 13:10:49
135	0	9	NewsAPI	Doctor details Gaza famine: 'We're not asking for miracles. We're asking for food'	A senior Palestinian pediatric doctor described the humanitarian crisis in Gaza as "unbelievable," witnessing children dying from hunger and preventable injuries.	After almost three months of a total aid blockade in Gaza and intensified attacks from Israel, children are suffering the most severe consequences, a local doctor says, from death and injuries to sta… [+6183 chars]	https://abcnews.go.com/US/doctor-details-gaza-famine-miracles-food/story?id=122007605	https://i.abcnewsfe.com/a/d0f90a96-815d-4dc4-b1e1-8070eff0d42e/gaza-1-gty-er-250520_1747778355477_hpMain_16x9.jpg?w=1600	2025-05-21 09:10:29
136	0	9	NewsAPI	A Public Health Researcher and Her Engineer Husband Found How Diseases Can Spread through Air Decades before the COVID Pandemic	Mildred Weeks Wells and her husband figured out that disease-causing pathogens can spread through the air like smoke	Air-Borne: The Hidden History of the Life We Breathe, by Carl Zimmer, charts the history of the field of aerobiology: the science of airborne microorganisms. In this episode, we discover the story of… [+33528 chars]	https://www.scientificamerican.com/article/a-public-health-researcher-and-her-engineer-husband-found-how-diseases-can/	https://static.scientificamerican.com/dam/m/924bb2302462b89/original/Lost-Women-of-Science-Partner-Podcast-Span-Art-Airborne.png?m=1747878912.787&w=1200	2025-05-22 16:00:00
137	0	9	NewsAPI	Fired FTC commissioners on fighting for their jobs back	Today, we have something special for you: A few days ago, I hosted a panel with FTC commissioners Rebecca Slaughter and Alvaro Bedoya at the IAPP Global Privacy Summit in Washington, DC. We recorded the discussion, and we’re bringing it to you today. That’s a…	Fired FTC commissioners on fighting for their jobs back\r\nAlvaro Bedoya and Rebecca Slaughter want to take their fight to the Supreme Court, and they think they can win.\r\nFired FTC commissioners on fi… [+45090 chars]	https://www.theverge.com/decoder-podcast-with-nilay-patel/657115/ftc-bedoya-slaughter-trump-fired-supreme-court-interview	https://platform.theverge.com/wp-content/uploads/sites/2/2025/04/DCD-Bedoya-Slaughter-2.png?quality=90&strip=all&crop=0%2C10.711631919237%2C100%2C78.576736161526&w=1200	2025-04-28 14:00:17
139	0	9	NewsAPI	The All New WHOOP: The World’s Most Powerful Health Wearable	WHOOP is redefining what a health wearable can be—bringing clinical-grade insights to your wrist with continuous vitals, edge and cloud-powered AI coaching.	Will Ahmed, Founder and CEO poses with Emily Capodilupo, SVP of Research Algorithms and Data on the ... More morning of their new product launch at WHOOP HQ in Boston, MA\r\nJohn Werner\r\nNew science on… [+11336 chars]	https://www.forbes.com/sites/johnwerner/2025/05/08/the-all-new-whoop-the-worlds-most-powerful-health-wearable/	https://imageio.forbes.com/specials-images/imageserve/681d2bc93949879059c77a4c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 23:00:06
140	0	9	NewsAPI	Doctors on the brink: Burnout, unsafe shifts, and a system in collapse	As a junior doctor in a busy emergency department Dr Fahad Khan expected long hours and high stress. What he didn't expect was a creeping concern that it might kill him.	As a junior doctor in a busy New South Wales emergency department, Dr Fahad Khan expected long hours, high stress and the pressure of life-or-death decisions. \r\nWhat he didn't expect was the creeping… [+7654 chars]	https://www.abc.net.au/news/2025-05-07/doctor-says-public-health-system-toxic-fears-it-could-kill-him/105245294	https://live-production.wcms.abc-cdn.net.au/2541376ae4d23b401a192913684d2baa?impolicy=wcms_watermark_news&cropH=2813&cropW=5000&xPos=0&yPos=0&width=862&height=485&imformat=generic	2025-05-07 06:29:25
141	0	10	NewsAPI	Has The Stock Market Hit A Bottom In 2025?	Has the stock market bottomed in 2025? See what metrics to monitor in order to determine if the stock market has bottomed out this year.	The market has shown promising signs of bottoming, with sentiment reaching extreme pessimism and ... More valuations moderating to more reasonable levels.\r\ngetty\r\nAfter a turbulent start to 2025, inv… [+16095 chars]	https://www.forbes.com/sites/investor-hub/article/has-the-stock-market-hit-bottom-2025/	https://imageio.forbes.com/specials-images/imageserve/68224cebac1649661e2b3b01/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 16:21:03
142	0	10	NewsAPI	Stock Market highlights 15 May 2025: Sensex settles 1,200 points higher, Nifty up 395 points at close	Stock Market Today | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets for 15 May 2025	<li></li>\r\n17:05 | May 15, 2025Stock market live updates today: Stock markets rally: Sensex jumps 1,200 points, Nifty reclaims 25000 peak after 7 months\r\nBenchmark BSE Sensex soared by 1,200 points, … [+82355 chars]	https://www.thehindubusinessline.com/markets/share-market-nifty-sensex-highlights-15-may-2025/article69575132.ece	https://bl-i.thgim.com/public/incoming/tmdf62/article69577694.ece/alternates/LANDSCAPE_1200/stock%20market%20graph.jpg	2025-05-15 01:05:39
143	0	10	NewsAPI	Share Market Highlights: Sensex, Nifty end lower on profit booking amid India-Pakistan tensions	Sensex, Nifty updates on 6 May 2025: Indian equity markets ended lower on Tuesday in a range-bound session as investors booked profits, particularly in banking and oil stocks, amid escalating geopolitical tensions with Pakistan and cautious global sentiment. …	Stock Market on 6 May 2025 | Share Market Updates - Find here all the updates related to Sensex, Nifty, BSE, NSE, share prices and Indian stock markets.<li></li>\r\n16:22 | May 6, 2025The live blog is … [+70740 chars]	https://www.thehindubusinessline.com/markets/stock-market-highlights-6-may-2025/article69541034.ece	https://bl-i.thgim.com/public/incoming/gnx3pb/article69540979.ece/alternates/LANDSCAPE_1200/Stock%20market%20live%20today.jpg	2025-05-06 01:30:59
144	0	10	NewsDATA	Is Now a Good Time to Buy Small-Cap Stocks?	A market plunge hit small stocks hard. Is it time to buy?	ONLY AVAILABLE IN PAID PLANS	https://www.kiplinger.com/investing/is-now-a-good-time-to-buy-small-cap-stocks	https://cdn.mos.cms.futurecdn.net/MKP42KV2C4x6sj6QyCK4kH.jpg	2025-05-25 13:32:00
145	0	10	NewsDATA	Texas Strategic Bitcoin Reserve and Investment Act Position Texas as a Pioneer in State-Level Crypto Adoption	The Texas Senate passed Senate Bill 21 (SB 21), known as the Texas Strategic Bitcoin Reserve and Investment Act, on March 6, 2025, with a 25-5 vote. The bill, authored by Senator Charles Schwertner (R-Georgetown) and sponsored in the House by Representative Giovanni Capriglione, establishes a state-managed Bitcoin reserve to invest in Bitcoin and other [...]The post Texas Strategic Bitcoin Reserve and Investment Act Position Texas as a Pioneer in State-Level Crypto Adoption appeared first on Tekedia.	ONLY AVAILABLE IN PAID PLANS	https://www.tekedia.com/texas-strategic-bitcoin-reserve-and-investment-act-position-texas-as-a-pioneer-in-state-level-crypto-adoption/	https://tkcdn.tekedia.com/wp-content/uploads/2025/04/18174443/bitcoin-reserve-BTC-768x429.jpg	2025-05-25 09:40:29
146	0	10	NewsDATA	Deutsche Bank AG Increases Holdings in CTO Realty Growth, Inc. (NYSE:CTO)	Deutsche Bank AG lifted its position in CTO Realty Growth, Inc. (NYSE:CTO – Free Report) by 2.9% in the fourth quarter, according to its most recent Form 13F filing with the SEC. The firm owned 75,075 shares of the company’s stock after purchasing an additional 2,142 shares during the period. Deutsche Bank AG owned 0.25% [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/deutsche-bank-ag-increases-holdings-in-cto-realty-growth-inc-nysecto.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fcto-realty-growth-inc-logo-1200x675.png%3Fv%3D20240523125838&w=240&zc=2	2025-05-25 09:04:53
147	0	10	NewsDATA	Oppenheimer Forecasts Strong Price Appreciation for Intuit (NASDAQ:INTU) Stock	Intuit (NASDAQ:INTU – Get Free Report) had its price objective boosted by Oppenheimer from $642.00 to $742.00 in a note issued to investors on Friday,Benzinga reports. The brokerage currently has an “outperform” rating on the software maker’s stock. Oppenheimer’s target price would indicate a potential upside of 3.04% from the stock’s current price. Several other [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/oppenheimer-forecasts-strong-price-appreciation-for-intuit-nasdaqintu-stock.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fintuit-inc-logo-1200x675.png%3Fv%3D20240524085201&w=240&zc=2	2025-05-25 09:02:48
148	0	10	NewsDATA	Captrust Financial Advisors Has $648 Million Position in NVIDIA Co. (NASDAQ:NVDA)	Captrust Financial Advisors lifted its position in shares of NVIDIA Co. (NASDAQ:NVDA – Free Report) by 9.4% in the 4th quarter, according to its most recent 13F filing with the SEC. The firm owned 4,825,403 shares of the computer hardware maker’s stock after acquiring an additional 415,331 shares during the quarter. NVIDIA makes up 1.8% [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/captrust-financial-advisors-has-648-million-position-in-nvidia-co-nasdaqnvda.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fnvidia-co-logo-1200x675.jpg%3Fv%3D20221020142916&w=240&zc=2	2025-05-25 08:04:59
149	0	10	NewsDATA	Janus Henderson Group PLC Invests $268,000 in The Taiwan Fund, Inc. (NYSE:TWN)	Janus Henderson Group PLC purchased a new position in shares of The Taiwan Fund, Inc. (NYSE:TWN – Free Report) during the fourth quarter, according to its most recent filing with the Securities and Exchange Commission (SEC). The fund purchased 6,950 shares of the company’s stock, valued at approximately $268,000. Janus Henderson Group PLC owned 0.08% [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/janus-henderson-group-plc-invests-268000-in-the-taiwan-fund-inc-nysetwn.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fthe-taiwan-fund-inc-logo-1200x675.png%3Fv%3D20241216123820&w=240&zc=2	2025-05-25 08:03:04
150	0	10	NewsDATA	Fox Co. (NASDAQ:FOXA) Holdings Boosted by Janus Henderson Group PLC	Janus Henderson Group PLC grew its stake in shares of Fox Co. (NASDAQ:FOXA – Free Report) by 4.7% during the 4th quarter, according to the company in its most recent filing with the Securities & Exchange Commission. The institutional investor owned 11,285 shares of the company’s stock after acquiring an additional 507 shares during the [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/fox-co-nasdaqfoxa-holdings-boosted-by-janus-henderson-group-plc.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Ffox-co-logo-1200x675.jpg%3Fv%3D20221104114442&w=240&zc=2	2025-05-25 08:01:02
151	0	10	NewsDATA	Citizens & Northern Co. (NASDAQ:CZNC) Shares Sold by Cetera Investment Advisers	Cetera Investment Advisers decreased its position in shares of Citizens & Northern Co. (NASDAQ:CZNC – Free Report) by 3.6% during the 4th quarter, according to the company in its most recent Form 13F filing with the Securities and Exchange Commission (SEC). The institutional investor owned 44,870 shares of the financial services provider’s stock after selling [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/citizens-northern-co-nasdaqcznc-shares-sold-by-cetera-investment-advisers.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fcitizens--northern-co-logo-1200x675.png%3Fv%3D20221213170349&w=240&zc=2	2025-05-25 08:01:01
152	0	10	NewsDATA	Curio Wealth LLC Purchases Shares of 2,282 Microsoft Co. (NASDAQ:MSFT)	Curio Wealth LLC purchased a new stake in Microsoft Co. (NASDAQ:MSFT – Free Report) during the fourth quarter, according to its most recent 13F filing with the Securities and Exchange Commission (SEC). The firm purchased 2,282 shares of the software giant’s stock, valued at approximately $962,000. Other hedge funds and other institutional investors also recently [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/25/curio-wealth-llc-purchases-shares-of-2282-microsoft-co-nasdaqmsft.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fmicrosoft-corporation-logo-1200x675.png&w=240&zc=2	2025-05-25 07:55:03
153	0.1	11	NewsAPI	Apple Stock Earnings Preview: Things To Consider Before The Next Report	Examine the key factors to watch before the next Apple earnings report to help you make informed decisions on AAPL.	Apple's upcoming earnings report arrives at a critical juncture, with solid company fundamentals ... More potentially overshadowed by escalating macroeconomic and geopolitical challenges.\r\nGetty Imag… [+13710 chars]	https://www.forbes.com/sites/investor-hub/article/apple-aapl-stock-earnings-things-to-consider/	https://imageio.forbes.com/specials-images/imageserve/6807ef026a2cb38c08b48c67/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 11:00:00
154	0.1	11	NewsAPI	Has The Stock Market Hit A Bottom In 2025?	Has the stock market bottomed in 2025? See what metrics to monitor in order to determine if the stock market has bottomed out this year.	The market has shown promising signs of bottoming, with sentiment reaching extreme pessimism and ... More valuations moderating to more reasonable levels.\r\ngetty\r\nAfter a turbulent start to 2025, inv… [+16095 chars]	https://www.forbes.com/sites/investor-hub/article/has-the-stock-market-hit-bottom-2025/	https://imageio.forbes.com/specials-images/imageserve/68224cebac1649661e2b3b01/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 16:21:03
155	0.1	11	NewsAPI	Bristol-Myers Squibb Company (BMY): One of the Best High-Yield Dividend Stocks for 2025 and Beyond	We recently published a list of the 15 Best High-Yield Dividend Stocks for 2025 and Beyond. In this article, we are going to take a look at where Bristol...	We recently published a list of the 15 Best High-Yield Dividend Stocks for 2025 and Beyond. In this article, we are going to take a look at where Bristol-Myers Squibb Company (NYSE:BMY) stands agains… [+6269 chars]	https://finance.yahoo.com/news/bristol-myers-squibb-company-bmy-075834806.html	https://s.yimg.com/ny/api/res/1.2/ZsrqNB_sdV78LPtS9DZ12A--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/4da437b7638100421dc4d0ddd5060036	2025-05-10 07:58:34
156	0.1	11	NewsAPI	Sarah Ketterer's Strategic Moves: Carnival Corp Takes Center Stage with 10.85% Portfolio Share	Insightful Analysis of Sarah Ketterer (Trades, Portfolio)'s First Quarter 2025 13F Filing	Sarah Ketterer (Trades, Portfolio) recently submitted her 13F filing for the first quarter of 2025, offering a glimpse into her strategic investment decisions. As the CEO and co-founder of Causeway C… [+4356 chars]	https://finance.yahoo.com/news/sarah-ketterers-strategic-moves-carnival-060145799.html	https://s.yimg.com/ny/api/res/1.2/Fs2LQ_S4N9gYV628PawMIQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04NzE-/https://media.zenfs.com/en/us.finance.gurufocus/c9ab2dbf39fb914eff8bc348586fbda3	2025-05-15 06:01:45
157	0.1	11	NewsAPI	Is Verizon Communications Inc. (VZ) the Best High-Yield Dividend Stock for 2025 and Beyond?	We recently published a list of the 15 Best High-Yield Dividend Stocks for 2025 and Beyond. In this article, we are going to take a look at where Verizon...	We recently published a list of the 15 Best High-Yield Dividend Stocks for 2025 and Beyond. In this article, we are going to take a look at where Verizon Communications Inc. (NYSE:VZ) stands against … [+6132 chars]	https://finance.yahoo.com/news/verizon-communications-inc-vz-best-081804104.html	https://s.yimg.com/ny/api/res/1.2/EvqKYx9AlNdJz1D7NIgTug--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/d40ed98291a09b39f0ce0eb637ac378d	2025-05-10 08:18:04
158	0.1	11	NewsAPI	Exploring 3 High Growth Tech Stocks In The US Market	The recent surge in the U.S. stock market, driven by a temporary easing of trade tensions between the U.S. and China, has seen key indices like the Dow Jones...	The recent surge in the U.S. stock market, driven by a temporary easing of trade tensions between the U.S. and China, has seen key indices like the Dow Jones Industrial Average and Nasdaq Composite e… [+6664 chars]	https://finance.yahoo.com/news/exploring-3-high-growth-tech-173819496.html	https://media.zenfs.com/en/simply_wall_st__316/0fe4d5d105492213ce106a92b49639d4	2025-05-12 17:38:19
159	0.1	11	NewsAPI	JM Financial maintains Buy on Hindustan Unilever, raises target price to Rs 2,555	JM Financial suggests buying Hindustan Unilever shares. The target price is now Rs 2,555. The previous target was Rs 2,485. The analyst expects the price to reach this level in a year. Hindustan Unilever reported a consolidated total income of Rs 15,979 crore…	(What's moving Sensex and Nifty Track latest market news, stock tips, Budget 2025, Share Market on Budget 2025 and expert advice, on ETMarkets. Also, ETMarkets.com is now on Telegram. For fastest new… [+330 chars]	https://economictimes.indiatimes.com/markets/stocks/recos/jm-financial-maintains-buy-on-hul-raises-target-price-to-rs-2-555nbsp/articleshow/120682865.cms	https://img.etimg.com/thumb/msid-120682925,width-1200,height-630,imgsize-18506,overlay-etmarkets/articleshow.jpg	2025-04-29 03:21:00
160	0.1	11	NewsDATA	AI Agents: Revolutionizing the Future of Work and Wall Street	InvestorPlace - Stock Market News, Stock Advice & Trading TipsLast year, many AI agents were just clunky prototypes. But today, they’re automating real work – and creating significant economic value.The post AI Agents: Revolutionizing the Future of Work and Wall Street appeared first on InvestorPlace.	ONLY AVAILABLE IN PAID PLANS	https://investorplace.com/hypergrowthinvesting/2025/05/ai-agents-revolutionizing-the-future-of-work-and-wall-street/	https://investorplace.com/wp-content/uploads/2025/05/ai-agent-headset-computer-768x432.png	2025-05-25 15:55:00
161	0.1	11	NewsDATA	Is Now a Good Time to Buy Small-Cap Stocks?	A market plunge hit small stocks hard. Is it time to buy?	ONLY AVAILABLE IN PAID PLANS	https://www.kiplinger.com/investing/is-now-a-good-time-to-buy-small-cap-stocks	https://cdn.mos.cms.futurecdn.net/MKP42KV2C4x6sj6QyCK4kH.jpg	2025-05-25 13:32:00
162	0	11	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	Listen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, charm brac… [+12550 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o	https://ichef.bbci.co.uk/news/1024/branded_news/aae4/live/82babf60-2be4-11f0-8f57-b7237f6a66e6.png	2025-05-13 01:02:20
163	0	11	NewsAPI	At This $5 Billion Ohio Advisory, Financial Planning Comes With A Wall Of Touch Screens And A Dose Of AI	Venture Visionary Partners thinks that a futuristic Lab—and a little help from AI—can redefine the client-advisor relationship. But will it improve returns?	CEO Craig Findley works in the Venture Lab.\r\nCourtesy of Venture Visionary Partners\r\nWalking into Venture Visionary Partners gleaming Sylvania, Ohio headquarters just outside of Toledo feels less lik… [+7259 chars]	https://www.forbes.com/sites/sergeiklebnikov/2025/05/14/at-this-5-billion-ohio-advisory-financial-planning-comes-with-a-wall-of-touch-screens-and-a-dose-of-ai/	https://imageio.forbes.com/specials-images/imageserve/682387de9111178a9556779b/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 11:30:00
164	0	11	NewsAPI	10 Finance Jobs With Six-Figure Potential—No Degree Required	No degree? No problem. These 10 finance jobs can lead to six-figure salaries, proving that skills and experience can matter more than a diploma.	Many six-figure finance jobs now prioritize skills over degrees.\r\ngetty\r\nWhile Wall Street firms once exclusively hired Ivy League graduates, those attitudes are changing. Traditional hiring models a… [+15444 chars]	https://www.forbes.com/sites/carolinecastrillon/2025/05/12/finance-jobs-six-figure-potential-no-degree/	https://imageio.forbes.com/specials-images/imageserve/68221f973e9a018ba139ddec/0x0.jpg?format=jpg&crop=1009,569,x0,y0,safe&height=900&width=1600&fit=bounds	2025-05-13 11:00:00
165	0	11	NewsAPI	New Nasdaq Rules Reshape The IPO Path For Microcap Companies	The U.S. Securities and Exchange Commission (SEC) has approved sweeping changes to the Nasdaq Capital Market listing standards.	Joseph Lucosky is the Managing Partner of Lucosky Brookman, a leading law firm in the world of microcap IPOs and Nasdaq/NYSE listings.\r\ngetty\r\nThe U.S. Securities and Exchange Commission (SEC) recent… [+6716 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/04/25/new-nasdaq-rules-reshape-the-ipo-path-for-microcap-companies/	https://imageio.forbes.com/specials-images/imageserve/674f57481dd3f3a70bc91311/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-25 20:24:05
166	0	11	NewsAPI	China Market Update: Tencent’s Terrific Q1 Earnings	Asian equities had a strong session, led by Hong Kong, Indonesia, Vietnam, Taiwan, and South Korea. There was considerable market chatter about the strength of the Chinese yuan (CNY) versus the US dollar, possibly driven by the People’s Bank of China (PBOC), …	CLN\r\nKraneShares\r\nTencent Earnings Review\r\nTencent (700 HK) reported Q1 financial results after the Hong Kong close today that beat analyst expectations on the big three: revenue, adjusted net income… [+6222 chars]	https://www.forbes.com/sites/brendanahern/2025/05/14/china-market-update-tencents-terrific-q1-earnings/	https://imageio.forbes.com/specials-images/imageserve/6824ae637cde9a9afd0f9f21/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 14:57:05
167	0	11	NewsAPI	UnitedHealth Group Incorporated (UNH): Among Billionaire Israel Englander’s Stock Picks with Huge Upside Potential	We recently published a list of Billionaire Israel Englander’s 10 Stock Picks with Huge Upside Potential. In this article, we are going to take a look at...	We recently published a list of Billionaire Israel Englanders 10 Stock Picks with Huge Upside Potential. In this article, we are going to take a look at where UnitedHealth Group Incorporated (NYSE:UN… [+7878 chars]	https://finance.yahoo.com/news/unitedhealth-group-incorporated-unh-among-122347449.html	https://s.yimg.com/ny/api/res/1.2/BZethiGfzmapselBAdA_0g--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/c34a56642082d17e3fa7c8675c6742b3	2025-04-29 12:23:47
168	0	11	NewsAPI	Tencent Music Q1 Paying User Growth More Than Offsets Monthly Active User Loss	Tencent Music Entertainment Group (NYSE:TME) reported its first-quarter results on Tuesday. The company reported quarterly revenues of $1.01 billion, which...	Tencent Music Entertainment Group (NYSE:TME) reported its first-quarter results on Tuesday.\r\nThe company reported quarterly revenues of $1.01 billion, which is in line with the street view. Revenues … [+2373 chars]	https://finance.yahoo.com/news/tencent-music-q1-paying-user-140556710.html	https://media.zenfs.com/en/Benzinga/5c2acba88a5645bec1b61c9fb3552fcc	2025-05-13 14:05:56
169	0	11	NewsAPI	High Growth Tech Stocks In Asia To Watch In May 2025	As global markets react positively to the recent U.S.-China tariff suspension, Asian tech stocks are drawing increased attention, buoyed by a broader rally...	As global markets react positively to the recent U.S.-China tariff suspension, Asian tech stocks are drawing increased attention, buoyed by a broader rally in equities and improved trade outlooks. In… [+6204 chars]	https://finance.yahoo.com/news/high-growth-tech-stocks-asia-044508110.html	https://media.zenfs.com/en/simply_wall_st__316/de3693c96ca28c16427680d76341d044	2025-05-19 04:45:08
170	0	11	NewsAPI	Stellantis Exposed In Europe As Tariff Turmoil Undermines Automakers	Stellantis, and some global automakers, declined the chance to forecast their profits after quarterly results, as President Trump’s tariff reforms spooked investors.	1968 Alfa Romeo 1750 Spyder. (Photo by National Motor Museum/Heritage Images via Getty Images). Alfa ... More Romeo is a Stellantis brand whose future is up for discussion.\r\nHeritage Images via Getty… [+5696 chars]	https://www.forbes.com/sites/neilwinton/2025/05/04/stellantis-exposed-in-europe-as-tariff-turmoil-undermines-automakers/	https://imageio.forbes.com/specials-images/imageserve/65d77ac5a81337fc14ac5657/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-04 14:00:02
171	0	11	NewsAPI	Short Washington DC And Go Long Seattle: Three Stocks To Buy Now	Moody's lowered the sovereign credit rating of the US, joining S&amp;P and Fitch in stripping America's AAA status.  Three stocks to buy now.	Moody's lowered the sovereign credit rating of the US, joining S&amp;P and Fitch in stripping America's AAA status. While this is historic and will attract media attention, it reveals what has long b… [+8406 chars]	https://www.forbes.com/sites/robertdaugherty/2025/05/17/short-washington-dc-and-go-long-seattle-three-stocks-to-buy-now/	https://imageio.forbes.com/specials-images/imageserve/6827db804090551ae827b6fb/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-17 13:30:21
172	0	11	NewsAPI	Is KKR & Co. Inc. (KKR) the Worst Blue Chip Stock to Buy?	We recently published a list of 10 Worst Blue Chip Stocks to Buy. In this article, we are going to take a look at where KKR & Co. Inc. (NYSE:KKR) stands...	We recently published a list of 10 Worst Blue Chip Stocks to Buy. In this article, we are going to take a look at where KKR &amp; Co. Inc. (NYSE:KKR) stands against other worst blue chip stocks to bu… [+6434 chars]	https://finance.yahoo.com/news/kkr-co-inc-kkr-worst-145949262.html	https://s.yimg.com/ny/api/res/1.2/8taE7UVa..JXX21T_2uUvA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/8591b721983e13534e161de9a53ccbf6	2025-05-10 14:59:49
173	0.1	12	NewsAPI	Where AI Lives: The Cloud’s Favorite Cities And What Comes After	AI infrastructure is shifting from hyperscale hubs to emerging global markets and edge devices — driven by model efficiency, power and policy constraints.	AIs Global Footprint: As workloads decentralize, the future of intelligence stretches from ... More hyperscale hubs to emerging markets and edge nodes worldwide.\r\ngetty\r\nWhere does AI live? Ask most … [+10264 chars]	https://www.forbes.com/sites/emilsayegh/2025/05/12/where-ai-lives-the-clouds-favorite-cities-and-what-comes-after/	https://imageio.forbes.com/specials-images/imageserve/681ee0835cb40dfdbd92fddc/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-12 11:52:57
174	0.1	12	NewsAPI	EFG International (VTX:EFGN) jumps 3.8% this week, though earnings growth is still tracking behind five-year shareholder returns	The most you can lose on any stock (assuming you don't use leverage) is 100% of your money. But on the bright side, if...	The most you can lose on any stock (assuming you don't use leverage) is 100% of your money. But on the bright side, if you buy shares in a high quality company at the right price, you can gain well o… [+3955 chars]	https://finance.yahoo.com/news/efg-international-vtx-efgn-jumps-053914202.html	https://media.zenfs.com/en/simply_wall_st__316/f88d3d8c5618aa88ce2627c2a1cda340	2025-05-05 05:39:14
175	0.1	12	NewsAPI	Our Q3 FY25 letter to shareholders	☁️ From the CEO In Q3 we delivered total revenue of $1.4 billion, powered by cloud revenue growth of 25%...\nThe post Our Q3 FY25 letter to shareholders appeared first on Work Life by Atlassian.	In Q3 we delivered total revenue of $1.4 billion, powered by cloud revenue growth of 25% year-over-year, and reached an important milestone in our long-term strategic vision for the Atlassian Platfor… [+31520 chars]	https://www.atlassian.com/blog/announcements/shareholder-letter-q3fy25	https://www.atlassian.com/blog/wp-content/uploads/2025/05/csd-17425-shareholder-letter-blog-illo-1120x545-px-@2x.png	2025-05-01 19:50:00
176	0.1	12	NewsAPI	Financial Analysis: Everest Group (NYSE:EG) versus Kingsway Financial Services (NYSE:KFS)	Kingsway Financial Services (NYSE:KFS – Get Free Report) and Everest Group (NYSE:EG – Get Free Report) are both finance companies, but which is the superior investment? We will compare the two businesses based on the strength of their analyst recommendations,…	Kingsway Financial Services (NYSE:KFS – Get Free Report) and Everest Group (NYSE:EG – Get Free Report) are both finance companies, but which is the superior investment? We will compare the two busine… [+6499 chars]	https://www.etfdailynews.com/2025/05/23/financial-analysis-everest-group-nyseeg-versus-kingsway-financial-services-nysekfs/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/everest-group-ltd-logo-1200x675.png?v=20250207055251&w=240&h=240&zc=2	2025-05-23 05:18:49
177	0.1	12	NewsAPI	CoreCard (NYSE:CCRD) vs. Alarm.com (NASDAQ:ALRM) Financial Review	CoreCard (NYSE:CCRD – Get Free Report) and Alarm.com (NASDAQ:ALRM – Get Free Report) are both business services companies, but which is the better investment? We will contrast the two companies based on the strength of their institutional ownership, valuation…	CoreCard (NYSE:CCRD – Get Free Report) and Alarm.com (NASDAQ:ALRM – Get Free Report) are both business services companies, but which is the better investment? We will contrast the two companies based… [+6335 chars]	https://www.etfdailynews.com/2025/04/26/corecard-nyseccrd-vs-alarm-com-nasdaqalrm-financial-review/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/alarmcom-hldg-inc-logo-1200x675.png&w=240&h=240&zc=2	2025-04-26 06:22:50
178	0.1	12	NewsAPI	indie Semiconductor (NASDAQ:INDI) & Semtech (NASDAQ:SMTC) Financial Contrast	indie Semiconductor (NASDAQ:INDI – Get Free Report) and Semtech (NASDAQ:SMTC – Get Free Report) are both computer and technology companies, but which is the superior investment? We will compare the two businesses based on the strength of their profitability, …	indie Semiconductor (NASDAQ:INDI – Get Free Report) and Semtech (NASDAQ:SMTC – Get Free Report) are both computer and technology companies, but which is the superior investment? We will compare the t… [+6156 chars]	https://www.etfdailynews.com/2025/05/04/indie-semiconductor-nasdaqindi-semtech-nasdaqsmtc-financial-contrast/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/semtech-logo-1200x675.gif&w=240&h=240&zc=2	2025-05-04 05:24:55
189	0	12	NewsAPI	Is KKR & Co. Inc. (KKR) the Worst Blue Chip Stock to Buy?	We recently published a list of 10 Worst Blue Chip Stocks to Buy. In this article, we are going to take a look at where KKR & Co. Inc. (NYSE:KKR) stands...	We recently published a list of 10 Worst Blue Chip Stocks to Buy. In this article, we are going to take a look at where KKR &amp; Co. Inc. (NYSE:KKR) stands against other worst blue chip stocks to bu… [+6434 chars]	https://finance.yahoo.com/news/kkr-co-inc-kkr-worst-145949262.html	https://s.yimg.com/ny/api/res/1.2/8taE7UVa..JXX21T_2uUvA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/8591b721983e13534e161de9a53ccbf6	2025-05-10 14:59:49
179	0.1	12	NewsAPI	OraSure Technologies (NASDAQ:OSUR) & DarioHealth (NASDAQ:DRIO) Financial Review	OraSure Technologies (NASDAQ:OSUR – Get Free Report) and DarioHealth (NASDAQ:DRIO – Get Free Report) are both small-cap medical companies, but which is the superior investment? We will contrast the two businesses based on the strength of their risk, instituti…	OraSure Technologies (NASDAQ:OSUR – Get Free Report) and DarioHealth (NASDAQ:DRIO – Get Free Report) are both small-cap medical companies, but which is the superior investment? We will contrast the t… [+6442 chars]	https://www.etfdailynews.com/2025/05/20/orasure-technologies-nasdaqosur-dariohealth-nasdaqdrio-financial-review/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/dariohealth-corp-logo-1200x675.PNG?v=20201016122451&w=240&h=240&zc=2	2025-05-20 06:16:44
180	0.1	12	NewsAPI	Financial Analysis: FrontView REIT (NYSE:FVR) versus Prologis (NYSE:PLD)	FrontView REIT (NYSE:FVR – Get Free Report) and Prologis (NYSE:PLD – Get Free Report) are both finance companies, but which is the superior investment? We will contrast the two companies based on the strength of their risk, earnings, valuation, analyst recomm…	FrontView REIT (NYSE:FVR – Get Free Report) and Prologis (NYSE:PLD – Get Free Report) are both finance companies, but which is the superior investment? We will contrast the two companies based on the… [+3660 chars]	https://www.etfdailynews.com/2025/04/29/financial-analysis-frontview-reit-nysefvr-versus-prologis-nysepld/	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?src=https://www.marketbeat.com/logos/800px-ProLogis_logo.svg-1200x675.png&w=240&h=240&zc=2	2025-04-29 05:50:54
181	0.1	12	NewsDATA	3 world-class dividend shares to consider for passive income!	Searching for the best dividend shares to buy for a large and growing long-term passive income? Here are three of my favourites.The post 3 world-class dividend shares to consider for passive income! appeared first on The Motley Fool UK.	ONLY AVAILABLE IN PAID PLANS	https://www.fool.co.uk/2025/05/25/3-world-class-dividend-shares-to-consider-for-passive-income/	https://www.fool.co.uk/wp-content/uploads/2022/10/Mature-investor.jpg	2025-05-25 13:23:52
182	0	12	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	Listen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, charm brac… [+12550 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o	https://ichef.bbci.co.uk/news/1024/branded_news/aae4/live/82babf60-2be4-11f0-8f57-b7237f6a66e6.png	2025-05-13 01:02:20
183	0	12	NewsAPI	Apple Stock Earnings Preview: Things To Consider Before The Next Report	Examine the key factors to watch before the next Apple earnings report to help you make informed decisions on AAPL.	Apple's upcoming earnings report arrives at a critical juncture, with solid company fundamentals ... More potentially overshadowed by escalating macroeconomic and geopolitical challenges.\r\nGetty Imag… [+13710 chars]	https://www.forbes.com/sites/investor-hub/article/apple-aapl-stock-earnings-things-to-consider/	https://imageio.forbes.com/specials-images/imageserve/6807ef026a2cb38c08b48c67/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 11:00:00
184	0	12	NewsAPI	Is NIO Inc. (NIO) the Best Low Priced Stock to Invest in For the Long Term?	We recently published a list of 10 Best Low Priced Stocks to Invest in For the Long Term. In this article, we are going to take a look at where NIO Inc...	We recently published a list of 10 Best Low Priced Stocks to Invest in For the Long Term. In this article, we are going to take a look at where NIO Inc. (NYSE:NIO) stands against other best low price… [+5797 chars]	https://finance.yahoo.com/news/nio-inc-nio-best-low-083822671.html	https://s.yimg.com/ny/api/res/1.2/fbe9iN5R78tj2Fp19dSd2w--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/d02deb0aeed9330fc652aa9fa43c9dea	2025-05-09 08:38:22
185	0	12	NewsAPI	Short Washington DC And Go Long Seattle: Three Stocks To Buy Now	Moody's lowered the sovereign credit rating of the US, joining S&amp;P and Fitch in stripping America's AAA status.  Three stocks to buy now.	Moody's lowered the sovereign credit rating of the US, joining S&amp;P and Fitch in stripping America's AAA status. While this is historic and will attract media attention, it reveals what has long b… [+8406 chars]	https://www.forbes.com/sites/robertdaugherty/2025/05/17/short-washington-dc-and-go-long-seattle-three-stocks-to-buy-now/	https://imageio.forbes.com/specials-images/imageserve/6827db804090551ae827b6fb/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-17 13:30:21
186	0	12	NewsAPI	Is Snap Inc. (SNAP) the Best Low Priced Stock to Invest in For the Long Term?	We recently published a list of 10 Best Low Priced Stocks to Invest in For the Long Term. In this article, we are going to take a look at where Snap Inc...	We recently published a list of 10 Best Low Priced Stocks to Invest in For the Long Term. In this article, we are going to take a look at where Snap Inc. (NYSE:SNAP) stands against other best low pri… [+6775 chars]	https://finance.yahoo.com/news/snap-inc-snap-best-low-152405661.html	https://s.yimg.com/ny/api/res/1.2/A_37Q3m2MO5x3Eyu7rWhTQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/ecdbb563196327580179ebdc267dd943	2025-05-09 15:24:05
187	0	12	NewsAPI	Transcript: Karin Risi, Vanguard’s Chief of Strategy & Product	The transcript from this week’s MiB: Karin Risi, Vanguard’s Chief of Strategy & Product, is below. You can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spotify, YouTube, and Bloomberg. All of our earlier podcasts…	The transcript from this weeks MiB: Karin Risi, Vanguards Chief of Strategy &amp; Product, is below.\r\nYou can stream and download our full conversation, including any podcast extras, on Apple Podcast… [+49516 chars]	https://ritholtz.com/2025/05/transcript-karin-risi/	https://ritholtz.com/wp-content/uploads/2023/02/Mib-tile.png	2025-05-13 12:30:29
188	0	12	NewsAPI	High Growth Tech Stocks In Asia To Watch In May 2025	As global markets react positively to the recent U.S.-China tariff suspension, Asian tech stocks are drawing increased attention, buoyed by a broader rally...	As global markets react positively to the recent U.S.-China tariff suspension, Asian tech stocks are drawing increased attention, buoyed by a broader rally in equities and improved trade outlooks. In… [+6204 chars]	https://finance.yahoo.com/news/high-growth-tech-stocks-asia-044508110.html	https://media.zenfs.com/en/simply_wall_st__316/de3693c96ca28c16427680d76341d044	2025-05-19 04:45:08
190	0	12	NewsAPI	Is Grab Holdings Limited (GRAB) the Best Low Priced Stock to Invest in For the Long Term?	We recently published a list of 10 Best Low Priced Stocks to Invest in For the Long Term. In this article, we are going to take a look at where Grab Holdings...	We recently published a list of 10 Best Low Priced Stocks to Invest in For the Long Term. In this article, we are going to take a look at where Grab Holdings Limited (NASDAQ:GRAB) stands against othe… [+5928 chars]	https://finance.yahoo.com/news/grab-holdings-limited-grab-best-090311826.html	https://s.yimg.com/ny/api/res/1.2/FOL1DgQUZunVccVzIITs1Q--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/eb62ab7daeeb4202fffa4df505d5bd7f	2025-05-09 09:03:11
191	0	12	NewsAPI	Has The Stock Market Hit A Bottom In 2025?	Has the stock market bottomed in 2025? See what metrics to monitor in order to determine if the stock market has bottomed out this year.	The market has shown promising signs of bottoming, with sentiment reaching extreme pessimism and ... More valuations moderating to more reasonable levels.\r\ngetty\r\nAfter a turbulent start to 2025, inv… [+16095 chars]	https://www.forbes.com/sites/investor-hub/article/has-the-stock-market-hit-bottom-2025/	https://imageio.forbes.com/specials-images/imageserve/68224cebac1649661e2b3b01/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 16:21:03
192	0	12	NewsAPI	Transcript: Sander Gerber, CEO and CIO Hudson Bay Capital	﻿     The transcript from this week’s, MiB: Sander Gerber, CEO and CIO Hudson Bay Capital, is below. You can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spotify, YouTube, and Bloomberg. All of our earlier podcas…	The transcript from this weeks, MiB: Sander Gerber, CEO and CIO Hudson Bay Capital, is below.\r\nYou can stream and download our full conversation, including any podcast extras, on Apple Podcasts, Spot… [+53213 chars]	https://ritholtz.com/2025/05/transcript-sander-gerber/	https://ritholtz.com/wp-content/uploads/2023/02/Mib-tile.png	2025-05-06 16:30:50
193	0.229	13	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
194	0.114	13	NewsDATA	Before the last drop	A representational image shows a person pouring water in a glass from a tap. — AFP/FileWater is often described as the lifeblood of nations, and for Pakistan this metaphor could not be more fitting. As a policy analyst deeply engaged in issues of sustainable development, I find it troubling,...	ONLY AVAILABLE IN PAID PLANS	https://www.thenews.com.pk/print/1315057-before-the-last-drop	https://www.thenews.com.pk/assets/uploads/akhbar/2025-05-25/1315057_1818133_water_akhbar.jpg	2025-05-24 19:00:00
195	0.114	13	NewsDATA	Iran’s right to enrich uranium: A legal reality made political by US	TEHRAN – Amid the ongoing tensions surrounding Iran’s nuclear program, one crucial fact often gets buried beneath heated political arguments: Iran, as a member of the Nuclear Non-Proliferation Treaty (NPT), holds an explicit legal right to enrich uranium for peaceful purposes.	ONLY AVAILABLE IN PAID PLANS	https://www.tehrantimes.com/news/513482/Iran-s-right-to-enrich-uranium-A-legal-reality-made-political	https://media.tehrantimes.com/d/t/2025/05/24/4/5520487.jpg?ts=1748107429515	2025-05-24 17:43:35
196	0.114	13	NewsDATA	UBS Asian Investment Conference in Hong Kong to feature Simone Biles and Maria Konnikova	Speakers at the Hong Kong conference next week are expected to discuss economics, trade and political uncertainties Read full story	ONLY AVAILABLE IN PAID PLANS	https://www.thestar.com.my/aseanplus/aseanplus-news/2025/05/24/ubs-asian-investment-conference-in-hong-kong-to-feature-simone-biles-and-maria-konnikova	https://apicms.thestar.com.my/uploads/images/2025/05/24/3330121.jpg	2025-05-24 10:52:00
197	0	13	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
198	0	13	NewsAPI	China’s Mega Dam Project Poses Big Risks for Asia’s Grand Canyon	China’s plans to build a massive hydro project in Tibet have sparked fears about the environmental impacts on the world’s longest and deepest canyon. It has also alarmed neighboring India, which fears that China could hold back or even weaponize river water i…	China has announced plans to build the worlds largest hydroelectric project at a remote river gorge in eastern Tibet, an ecological treasure trove close to a disputed border with India. Indian politi… [+12440 chars]	https://e360.yale.edu/features/china-tibet-yarlung-tsangpo-dam-india-water	https://yale-threesixty.transforms.svdcdn.com/production/Doxong-Pass_Alamy-HEADER.jpg?w=1200&q=60&auto=format&fit=max&dm=1747304219&s=d8af4146a9bdb36bac3a02200c2dc4c0	2025-05-14 14:35:00
199	0	13	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
200	0	13	NewsAPI	Trump’s Election, Gaza-Ukraine Wars, Nord Stream Pipeline Sabotage: Death Knells All to Truth and Democracy in the 21st Century	Preface\nWhat follows is one human being’s unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st century’s violent, contentious political and military struggles between them all.\nPlane…	Preface\r\nWhat follows is one human beings unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st centurys violent, contentio… [+74645 chars]	https://www.globalresearch.ca/trump-election-gaza-ukraine-wars-nord-stream-pipeline-sabotage/5886503	https://www.globalresearch.ca/wp-content/uploads/2019/07/Post-Truth.jpg	2025-05-14 01:24:45
201	0	13	NewsAPI	Does the Covid “Jab” Cause Amyloidosis? Richard C. Cook	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by Dr. Gregory House and …\nThe post Does the Covid “Jab” Cause …	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by … [+9925 chars]	https://www.globalresearch.ca/jab-cause-amyloidosis-richard-cook/5886442	https://www.globalresearch.ca/wp-content/uploads/2021/06/Covid-vaccine-VAERS-061821-feature-800x417.jpg	2025-05-10 12:19:57
202	0	13	NewsAPI	Civilians Face Humanitarian Disaster in Great Lakes, Horn of Africa Conflicts	Political instability and conflicts in the Great Lakes, the Horn of Africa, Sudan, and South Sudan have led to massive displacements and civilian suffering, and because the whole region is in crisis, the civilian population has few places to find refuge. In t…	Africa, Armed Conflicts, Crime &amp; Justice, Democracy, Featured, Gender, Gender Identity, Headlines, Human Rights, Humanitarian Emergencies, International Justice, Sustainable Development Goals, Te… [+12022 chars]	https://www.ipsnews.net/2025/05/civilians-face-humanitarian-disaster-in-great-lakes-and-horn-of-africa-conflicts/	https://www.ipsnews.net/Library/2025/05/M23-rebels-in-Eastern-Democratic-Republic-of-Congo.-The-group-has-been-accused-of-gross-abuse-of-rights-of-civilians.-Credit-Wambi-Michael-.jpg	2025-05-21 08:35:50
203	0	13	NewsDATA	Trump’s sledgehammer politics are wreaking havoc in every sphere both home and away	Trade, diplomacy, universities, science, nothing is off limits for the MAGA vision of how things should be done and the blowback could yet come writes Foreign Editor David Pratt	ONLY AVAILABLE IN PAID PLANS	https://www.heraldscotland.com/news/25189540.trumps-sledgehammer-politics-now-wreaking-havoc-every-sphere/	https://www.heraldscotland.com/resources/images/19496427/?htype=0&type=app	2025-05-25 05:10:00
204	0	13	NewsDATA	Renegotiating the Indus Water Treaty	Pakistan’s fertile plains, long nourished by the Indus, Jhelum, and Chenab rivers, face a silent threat: thirst.	ONLY AVAILABLE IN PAID PLANS	https://www.nation.com.pk/25-May-2025/renegotiating-the-indus-water-treaty	https://www.nation.com.pk/uploads/facebook_post_images/2025-05-25/facebook_post_image_1748133899.jpg	2025-05-25 00:44:59
205	0	13	NewsDATA	The Unexpected Peacemaker	Nobody expected him to avert a war. Twice. Donald J. Trump left a legacy of spectacle, mayhem, and division with his gold-plated towers and aggressive tweets. While comedians feasted and world leaders sneered, critics warned that his presidency would spell disaster for world peace. Contrary to all predictions, however, the man who was once derided [...]	ONLY AVAILABLE IN PAID PLANS	https://www.pakistantoday.com.pk/2025/05/25/the-unexpected-peacemaker/	https://www.pakistantoday.com.pk/wp-content/uploads/2025/05/Gamma-19-150x150.jpg	2025-05-24 21:34:42
206	0	13	NewsDATA	Growing up with 'money anxiety' drove GE2025 independent candidate Jeremy Tan to excel in business, retire young	His parents found it hard to make ends meet after a number of failed businesses and there were times his home would be without power, water or internet services.	ONLY AVAILABLE IN PAID PLANS	https://www.channelnewsasia.com/today/up-close/jeremy-tan-ge2025-modest-beginning-building-movement-5141136	https://dam.mediacorp.sg/image/upload/s--2Yrvpm2n--/fl_relative,g_south_east,l_mediacorp:cna:watermark:2021-08:cna,w_0.1/f_auto,q_auto/c_fill,g_auto,h_468,w_830/v1/mediacorp/cna/image/2025/05/20/20250515_raj_jeremy_tan1.jpg?itok=yb5S64YJ	2025-05-24 13:30:00
207	0	13	NewsDATA	China’s India Headache: The growing pharmaceutical industry	Indian CDMOs are strategically expanding through acquisitions in the US and Europe, driven by global pharma's nearshoring trend and a desire to diversify from China. These companies are investing in advanced technologies and specialized capabilities, particularly in biologics and complex chemistry, to capture a larger share of the global market.	ONLY AVAILABLE IN PAID PLANS	https://economictimes.indiatimes.com/industry/healthcare/biotech/pharmaceuticals/chinas-india-headache-the-growing-pharmaceutical-industry/articleshow/121384015.cms	https://img.etimg.com/thumb/msid-121384261,width-1200,height-630,imgsize-14706,overlay-economictimes/articleshow.jpg	2025-05-24 12:09:21
208	0.114	14	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
209	0.114	14	NewsDATA	China’s India Headache: The growing pharmaceutical industry	Indian CDMOs are strategically expanding through acquisitions in the US and Europe, driven by global pharma's nearshoring trend and a desire to diversify from China. These companies are investing in advanced technologies and specialized capabilities, particularly in biologics and complex chemistry, to capture a larger share of the global market.	ONLY AVAILABLE IN PAID PLANS	https://economictimes.indiatimes.com/industry/healthcare/biotech/pharmaceuticals/chinas-india-headache-the-growing-pharmaceutical-industry/articleshow/121384015.cms	https://img.etimg.com/thumb/msid-121384261,width-1200,height-630,imgsize-14706,overlay-economictimes/articleshow.jpg	2025-05-24 12:09:21
210	0	14	NewsAPI	Vladimir Putin: After 25 years in power, what next for Russia’s president?	From chasing rats as a child to the KGB, how 72-year-old Putin came to power - and what drives him now.	When Russian President Vladimir Putin was growing up in a dilapidated apartment block in Leningrad, now St Petersburg, he and his friends would chase rats through the corridors with sticks. One day, … [+23983 chars]	https://www.aljazeera.com/features/2025/5/9/vladimir-putin-after-25-years-in-power-what-next-for-russias-president	https://www.aljazeera.com/wp-content/uploads/2025/05/putin-03-02-1746624136.png?resize=1920%2C1440	2025-05-09 07:19:20
211	0	14	NewsAPI	China’s Mega Dam Project Poses Big Risks for Asia’s Grand Canyon	China’s plans to build a massive hydro project in Tibet have sparked fears about the environmental impacts on the world’s longest and deepest canyon. It has also alarmed neighboring India, which fears that China could hold back or even weaponize river water i…	China has announced plans to build the worlds largest hydroelectric project at a remote river gorge in eastern Tibet, an ecological treasure trove close to a disputed border with India. Indian politi… [+12440 chars]	https://e360.yale.edu/features/china-tibet-yarlung-tsangpo-dam-india-water	https://yale-threesixty.transforms.svdcdn.com/production/Doxong-Pass_Alamy-HEADER.jpg?w=1200&q=60&auto=format&fit=max&dm=1747304219&s=d8af4146a9bdb36bac3a02200c2dc4c0	2025-05-14 14:35:00
212	0	14	NewsAPI	Shadows on the Border: Russia’s Military Posturing and the Specter of Escalation	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing military build-up, a stark demonstration of force that casts a long…	A palpable tension is tightening along Russia’s extensive frontiers with Finland, Estonia, Latvia, and Lithuania. Satellite imagery and on-the-ground reports confirm a significant and ongoing militar… [+8835 chars]	https://www.globalresearch.ca/russia-military-posturing-specter-escalation/5885724	https://www.globalresearch.ca/wp-content/uploads/2024/12/oreshnik.jpeg	2025-04-30 22:09:49
213	0	14	NewsAPI	Trump’s Election, Gaza-Ukraine Wars, Nord Stream Pipeline Sabotage: Death Knells All to Truth and Democracy in the 21st Century	Preface\nWhat follows is one human being’s unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st century’s violent, contentious political and military struggles between them all.\nPlane…	Preface\r\nWhat follows is one human beings unique personal account of American-Russian-Ukrainian-Indigenous world history and philosophy from within the context of the 21st centurys violent, contentio… [+74645 chars]	https://www.globalresearch.ca/trump-election-gaza-ukraine-wars-nord-stream-pipeline-sabotage/5886503	https://www.globalresearch.ca/wp-content/uploads/2019/07/Post-Truth.jpg	2025-05-14 01:24:45
214	0	14	NewsAPI	Does the Covid “Jab” Cause Amyloidosis? Richard C. Cook	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by Dr. Gregory House and …\nThe post Does the Covid “Jab” Cause …	Amyloidosis is a condition that few laypeople have heard of but which is a terror when it strikes. Used to be that on the old House series amyloidosis was often mentioned during the weekly search by … [+9925 chars]	https://www.globalresearch.ca/jab-cause-amyloidosis-richard-cook/5886442	https://www.globalresearch.ca/wp-content/uploads/2021/06/Covid-vaccine-VAERS-061821-feature-800x417.jpg	2025-05-10 12:19:57
215	0	14	NewsAPI	Civilians Face Humanitarian Disaster in Great Lakes, Horn of Africa Conflicts	Political instability and conflicts in the Great Lakes, the Horn of Africa, Sudan, and South Sudan have led to massive displacements and civilian suffering, and because the whole region is in crisis, the civilian population has few places to find refuge. In t…	Africa, Armed Conflicts, Crime &amp; Justice, Democracy, Featured, Gender, Gender Identity, Headlines, Human Rights, Humanitarian Emergencies, International Justice, Sustainable Development Goals, Te… [+12022 chars]	https://www.ipsnews.net/2025/05/civilians-face-humanitarian-disaster-in-great-lakes-and-horn-of-africa-conflicts/	https://www.ipsnews.net/Library/2025/05/M23-rebels-in-Eastern-Democratic-Republic-of-Congo.-The-group-has-been-accused-of-gross-abuse-of-rights-of-civilians.-Credit-Wambi-Michael-.jpg	2025-05-21 08:35:50
216	0	14	NewsDATA	Trump’s sledgehammer politics are wreaking havoc in every sphere both home and away	Trade, diplomacy, universities, science, nothing is off limits for the MAGA vision of how things should be done and the blowback could yet come writes Foreign Editor David Pratt	ONLY AVAILABLE IN PAID PLANS	https://www.heraldscotland.com/news/25189540.trumps-sledgehammer-politics-now-wreaking-havoc-every-sphere/	https://www.heraldscotland.com/resources/images/19496427/?htype=0&type=app	2025-05-25 05:10:00
217	0	14	NewsDATA	Renegotiating the Indus Water Treaty	Pakistan’s fertile plains, long nourished by the Indus, Jhelum, and Chenab rivers, face a silent threat: thirst.	ONLY AVAILABLE IN PAID PLANS	https://www.nation.com.pk/25-May-2025/renegotiating-the-indus-water-treaty	https://www.nation.com.pk/uploads/facebook_post_images/2025-05-25/facebook_post_image_1748133899.jpg	2025-05-25 00:44:59
218	0	14	NewsDATA	The Unexpected Peacemaker	Nobody expected him to avert a war. Twice. Donald J. Trump left a legacy of spectacle, mayhem, and division with his gold-plated towers and aggressive tweets. While comedians feasted and world leaders sneered, critics warned that his presidency would spell disaster for world peace. Contrary to all predictions, however, the man who was once derided [...]	ONLY AVAILABLE IN PAID PLANS	https://www.pakistantoday.com.pk/2025/05/25/the-unexpected-peacemaker/	https://www.pakistantoday.com.pk/wp-content/uploads/2025/05/Gamma-19-150x150.jpg	2025-05-24 21:34:42
219	0	14	NewsDATA	Before the last drop	A representational image shows a person pouring water in a glass from a tap. — AFP/FileWater is often described as the lifeblood of nations, and for Pakistan this metaphor could not be more fitting. As a policy analyst deeply engaged in issues of sustainable development, I find it troubling,...	ONLY AVAILABLE IN PAID PLANS	https://www.thenews.com.pk/print/1315057-before-the-last-drop	https://www.thenews.com.pk/assets/uploads/akhbar/2025-05-25/1315057_1818133_water_akhbar.jpg	2025-05-24 19:00:00
220	0	14	NewsDATA	Iran’s right to enrich uranium: A legal reality made political by US	TEHRAN – Amid the ongoing tensions surrounding Iran’s nuclear program, one crucial fact often gets buried beneath heated political arguments: Iran, as a member of the Nuclear Non-Proliferation Treaty (NPT), holds an explicit legal right to enrich uranium for peaceful purposes.	ONLY AVAILABLE IN PAID PLANS	https://www.tehrantimes.com/news/513482/Iran-s-right-to-enrich-uranium-A-legal-reality-made-political	https://media.tehrantimes.com/d/t/2025/05/24/4/5520487.jpg?ts=1748107429515	2025-05-24 17:43:35
221	0	14	NewsDATA	Growing up with 'money anxiety' drove GE2025 independent candidate Jeremy Tan to excel in business, retire young	His parents found it hard to make ends meet after a number of failed businesses and there were times his home would be without power, water or internet services.	ONLY AVAILABLE IN PAID PLANS	https://www.channelnewsasia.com/today/up-close/jeremy-tan-ge2025-modest-beginning-building-movement-5141136	https://dam.mediacorp.sg/image/upload/s--2Yrvpm2n--/fl_relative,g_south_east,l_mediacorp:cna:watermark:2021-08:cna,w_0.1/f_auto,q_auto/c_fill,g_auto,h_468,w_830/v1/mediacorp/cna/image/2025/05/20/20250515_raj_jeremy_tan1.jpg?itok=yb5S64YJ	2025-05-24 13:30:00
222	0	14	NewsDATA	UBS Asian Investment Conference in Hong Kong to feature Simone Biles and Maria Konnikova	Speakers at the Hong Kong conference next week are expected to discuss economics, trade and political uncertainties Read full story	ONLY AVAILABLE IN PAID PLANS	https://www.thestar.com.my/aseanplus/aseanplus-news/2025/05/24/ubs-asian-investment-conference-in-hong-kong-to-feature-simone-biles-and-maria-konnikova	https://apicms.thestar.com.my/uploads/images/2025/05/24/3330121.jpg	2025-05-24 10:52:00
223	0.1	15	NewsAPI	Eclipse of the Forgotten: "The Resurgent Legacy of the Blackout Bestiary – Part II	Part 2 explores the mystery fueled by viral momentum and audience demand. We compare two case studies: the Nord Stream pipeline explosions and the Enigmatic Bestiary of the Blackout. Hypothesis 1: If the Nord Stream blasts in September 2022 are seen as a test…	"The Energy Transition: A Critical Analysis of Power"\r\n1. "Plays: The Political Engineering of Energy Sector Chaos"\r\n2. "Nord Stream: From Baltic Lifeline to Geopolitical Flashpoint"\r\n3. "President D… [+49769 chars]	https://energycentral.com/c/og/eclipse-forgotten-resurgent-legacy-blackout-bestiary-%E2%80%93-part-ii	https://energycentral.com/sites/default/files/styles/og_meta/public/ece/node_main/2025/5/2025-05-2220-20germa.jpg?itok=SJwFZf2q	2025-05-23 00:20:06
224	0	15	NewsAPI	Leaders of Israel's Druze say the state owes it to them to defend Syrian kin	Israeli Druze renew their push for the IDF to defend their relatives in Syria as Jerusalem worries over new US-Syrian relations.	Pained and angered by deadly clashes between Islamist and Druze gunmen in Syria in recent weeks, leaders of Israel's own Druze minority say the Israeli military was right to intervene to defend the D… [+5254 chars]	https://www.jpost.com/israel-news/article-853945	https://images.jpost.com/image/upload/f_auto,fl_lossy/c_fill,g_faces:center,h_407,w_690/663254	2025-05-14 13:31:58
225	0	15	NewsDATA	Growing up with 'money anxiety' drove GE2025 independent candidate Jeremy Tan to excel in business, retire young	His parents found it hard to make ends meet after a number of failed businesses and there were times his home would be without power, water or internet services.	ONLY AVAILABLE IN PAID PLANS	https://www.channelnewsasia.com/today/up-close/jeremy-tan-ge2025-modest-beginning-building-movement-5141136	https://dam.mediacorp.sg/image/upload/s--2Yrvpm2n--/fl_relative,g_south_east,l_mediacorp:cna:watermark:2021-08:cna,w_0.1/f_auto,q_auto/c_fill,g_auto,h_468,w_830/v1/mediacorp/cna/image/2025/05/20/20250515_raj_jeremy_tan1.jpg?itok=yb5S64YJ	2025-05-24 13:30:00
\.


--
-- Data for Name: fav_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fav_articles (id, score, question_id, api_source, title, description, content, url, "urlToImage", "publishedAt", article_id, user_id) FROM stdin;
1	0	7	NewsAPI	Pandemic preparedness: First Pandemic Treaty adopted	It’s only the second time the World Health Assembly has adopted a health treaty, but key details of this Pandemic Agreement remain unclear. An analysis. World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annua…	World Health Organization member states adopted a treaty on global pandemic preparedness at its 78th annual Assembly on Tuesday, May 20, after three years of protracted negotiations.\r\nIt's only the s… [+5484 chars]	https://www.dw.com/en/pandemic-preparedness-first-pandemic-treaty-adopted/a-72609575	https://static.dw.com/image/72607764_6.jpg	2025-05-20 12:43:00	58	1
2	0.114	5	NewsAPI	Google and Microsoft heat up the AI race as OpenAI opens new front with big acquisition	It was all about AI at all the big events this week — Microsoft Build, Google I/O, Dell Tech World, Red Hat Summit and even Computex. This time at I/O, Google appeared to get the upper hand, vibe-wise, with a flurry of new models and features, a vision of a u…	It was all about AI at all the big events this week — Microsoft Build, Google I/O, Dell Tech World, Red Hat Summit and even Computex.\r\nThis time at I/O, Google appeared to get the upper hand, vibe-wi… [+13056 chars]	https://siliconangle.com/2025/05/23/google-microsoft-heat-ai-race-openai-opens-new-front-big-acquisition/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2025/05/ai-msft-vs-google-1.jpeg	2025-05-23 14:58:34	55	3
4	0.073	1	NewsAPI	Scientists say NOAA cuts by Trump undermine improvements in hurricane forecasts	The Trump administration is targeting top climate and weather labs for cuts. Insiders worry about the impact on research and NOAA's ability to forecast severe weather like hurricanes and tornadoes.	MIAMI Weather and climate research are among the programs seeing big cuts by the Trump administration. \r\nHundreds of employees at NOAA the National Oceanic and Atmospheric Administration who work at … [+4401 chars]	https://www.npr.org/2025/04/25/nx-s1-5361474/noaa-cuts-hurricane-forecast-improvements-trump	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3900x2194+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F9e%2F96%2Fa366b9ba4a2a958fd8f8c1a55c33%2Fgettyimages-2177097712.jpg	2025-04-25 09:00:00	2	3
\.


--
-- Data for Name: fav_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fav_videos (id, question_id, youtube_id, description, thumbnail, video_id, user_id) FROM stdin;
4	4	qe9QSCF-d88	Yoshua Bengio — the world's most-cited computer scientist and a "godfather" of artificial intelligence — is deadly concerned about ...	https://i.ytimg.com/vi/qe9QSCF-d88/hqdefault.jpg	14	3
5	13	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg	57	3
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
57	1	3
\.


--
-- Data for Name: hidden_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_questions (question_id, id, user_id) FROM stdin;
\.


--
-- Data for Name: hidden_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hidden_videos (video_id, id, user_id) FROM stdin;
58	1	3
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, topic_id, text, keywords, "order") FROM stdin;
1	1	How can we accurately model localized climate impacts to better inform regional adaptation strategies?		0
2	1	What are the most effective nature-based solutions for carbon sequestration and ecosystem resilience?	effective nature, ecosystem resilience, carbon sequestration, based solutions	1
3	1	How can environmental monitoring technologies improve our understanding of climate change and its effects?	climate change, understanding, effects	2
4	2	How can we formally verify the safety of increasingly complex AI systems?	formally verify, safety	0
5	2	What algorithmic advancements are needed to achieve truly generalizable AI?	algorithmic advancements, needed	1
6	2	How can we design AI systems to be transparent and accountable in their decision-making?	design ai systems, transparent, making, decision, accountable	2
7	3	How can public health better address social determinants impacting my patients' health outcomes?	health outcomes, patients	0
8	3	What public health interventions can reduce preventable hospital readmissions I frequently see?	public health interventions, frequently see	1
9	3	How can doctors better collaborate with public health to improve community health outcomes?	doctors better collaborate, public health	2
10	4	How should regulatory changes impact risk models and asset allocations?	asset allocations	0
11	4	Which macroeconomic indicators best predict market volatility and investment strategies?	investment strategies	1
12	4	What ESG factors offer the most reliable long-term investment performance?	term investment performance, esg factors offer, reliable long	2
13	5	How do domestic political institutions shape a nation's geopolitical strategy?	geopolitical strategy, nation	0
14	5	To what extent does global interdependence limit states' geopolitical ambitions?	geopolitical ambitions, extent	1
15	5	How do geopolitical narratives influence public opinion and foreign policy choices?	foreign policy choices	2
\.


--
-- Data for Name: refresh; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh (question_id, id, user_id) FROM stdin;
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, title, role, images) FROM stdin;
1	Climate Change	Environmental Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_1_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044514Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b2426f7dcbfc3901aa7a8fbec9a22797a94525431bb697980f059aa572bbedd7,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_1_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044515Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=bd189bd348892214fd0194bada263a89a16d2ebaa70cfccb9731467ffb269519,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_1_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044516Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=d0b49f807d98ac875c7c9ba2499daf129a20c7e8aaa345ef71d0641352287274}
2	Artificial Intelligence	Computer Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_2_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044524Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=804a0676c67990f1e85dab357a3dd5d9d0afe766616b820dae8cffd07bc60e05,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_2_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044525Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=52a481f1a5d9e03516ca66404405451e03abe99ce5848e5cb51339d57020ec4d,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_2_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044526Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=782afe4808b6a70b51c42d87704db9a492d477cb6bbcbcf275a9c254bca95ebf}
3	Public Health	Medical Doctor	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_3_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044534Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=294f15db1b8908e82df29e0c12bdbb506471c3dd819ff4d528499b1141ac78fa,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_3_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044535Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=8ac0fc0a33c12855eabdf5128384095af447ec1faabfad8c7945543b41c18e16,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_3_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044537Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=8b7916ed25b6cb5b6161ccae1b5a0921d2dcb050ae116aef2e11e9a23c6b75c7}
4	Financial Markets	Financial Analyst	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_4_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044545Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=41d4f9d9e045f39ed41db75185d6c1561ad8af1782128faab16a3dc9bb9a0e61,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_4_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044546Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3a112c84c16b05650660ec5077608b77525cf47194a84341bfd6e2ae53e027c2,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_4_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044547Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=dfb45e0f1c10023ae25777681c80eecdbdf172cdd3b8b7acb21cf7c23f5eaf47}
5	Geopolitics	Political Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_5_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044556Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5357cedd8372189f1746983c2bcbc10363fd7f53bd19aabb50ca3b12c4c60113,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_5_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044557Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c23c54ae7223e5980b1ccd32e5c824756e68ef02c35f63302b61d83bf04d9be7,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-25/topic_5_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250526%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250526T044558Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b5993124967f4d41bd819d794e9c8d6910caf10a31fc9b4ac9766ef5fa587d1a}
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
1	1	yy3VK6OYBbU	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/yy3VK6OYBbU/hqdefault.jpg
2	1	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
3	1	RoIpCJwX7-M	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/RoIpCJwX7-M/hqdefault.jpg
4	1	EtW2rrLHs08	Climate Change is a real and serious issue. In this video Bill Nye, the Science Guy, explains what causes climate change, how it ...	https://i.ytimg.com/vi/EtW2rrLHs08/hqdefault.jpg
5	1	N6t6QHQtdVw	Climate | How To Keep The Environment Safe? | Global Warming | Climate Change | What Causes Global Warming?	https://i.ytimg.com/vi/N6t6QHQtdVw/hqdefault.jpg
6	2	GC54Y8zXXl4	Friday June 4, 2021 3:00 to 4:00 PM (eastern) This webinar will review the current science on forest carbon sequestration, ...	https://i.ytimg.com/vi/GC54Y8zXXl4/hqdefault.jpg
7	2	iGTmKOG8yQo	A Blueprint for Developing Nature-based Solutions for Climate Mitigation original graph from: Beyond Carbon Credits: A Blueprint ...	https://i.ytimg.com/vi/iGTmKOG8yQo/hqdefault.jpg
8	2	CSH63qgpGoY	Natural ecosystems are the best technology we have to help cool the planet, but doing so effectively requires an intricate ...	https://i.ytimg.com/vi/CSH63qgpGoY/hqdefault.jpg
9	3	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
10	3	EtW2rrLHs08	Climate Change is a real and serious issue. In this video Bill Nye, the Science Guy, explains what causes climate change, how it ...	https://i.ytimg.com/vi/EtW2rrLHs08/hqdefault.jpg
11	3	yy3VK6OYBbU	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/yy3VK6OYBbU/hqdefault.jpg
12	3	6EFHZfISGp4	Follow us on INSTAGRAM: https://www.instagram.com/jubileemedia/ Dan: https://www.instagram.com/thedchen/ Erin: ...	https://i.ytimg.com/vi/6EFHZfISGp4/hqdefault.jpg
13	3	GR46_ohNh9U	Climate scientist Dr. Peter Kalmus answers the internet's burning questions about our planet. Are there any other planets we can ...	https://i.ytimg.com/vi/GR46_ohNh9U/hqdefault.jpg
14	4	qe9QSCF-d88	Yoshua Bengio — the world's most-cited computer scientist and a "godfather" of artificial intelligence — is deadly concerned about ...	https://i.ytimg.com/vi/qe9QSCF-d88/hqdefault.jpg
15	4	ttIOdAdQaUE	What is Artificial Intelligence? | AI | ChatGPT | AI System | Artificial Intelligence | Robot | Chatbot | Computer | Computer-Controlled ...	https://i.ytimg.com/vi/ttIOdAdQaUE/hqdefault.jpg
16	4	ULKC4NISWE4	Recorded live on twitch, GET IN ### My Stream https://twitch.tv/ThePrimeagen ### Best Way To Support Me Become a backend ...	https://i.ytimg.com/vi/ULKC4NISWE4/hqdefault.jpg
17	4	Iv9uXjSk7-Q	Join us as we delve into the transformative power of artificial intelligence at Bosch. In this video, Zico Kolter shares his journey ...	https://i.ytimg.com/vi/Iv9uXjSk7-Q/hqdefault.jpg
18	5	qYNweeDHiyU	Want to learn about AI agents and assistants? Register for Virtual Agents Day here → https://ibm.biz/BdaAVa Want to play with the ...	https://i.ytimg.com/vi/qYNweeDHiyU/hqdefault.jpg
19	5	4RixMPF4xis	Learn more about watsonx: https://ibm.biz/BdvxDS What is really the difference between Artificial intelligence (AI) and machine ...	https://i.ytimg.com/vi/4RixMPF4xis/hqdefault.jpg
20	5	z-EtmaFJieY	So we've talked a lot in this series about how computers fetch and display data, but how do they make decisions on this data?	https://i.ytimg.com/vi/z-EtmaFJieY/hqdefault.jpg
21	5	ia-oYtacJHE	This video introduces the Artificial Intelligence chapter of the "Computer Science Field Guide", an online interactive "textbook" ...	https://i.ytimg.com/vi/ia-oYtacJHE/hqdefault.jpg
22	6	ttIOdAdQaUE	What is Artificial Intelligence? | AI | ChatGPT | AI System | Artificial Intelligence | Robot | Chatbot | Computer | Computer-Controlled ...	https://i.ytimg.com/vi/ttIOdAdQaUE/hqdefault.jpg
23	6	ad79nYk2keg	Artificial Intelligence Engineer (IBM) ...	https://i.ytimg.com/vi/ad79nYk2keg/hqdefault.jpg
24	6	qYNweeDHiyU	Want to learn about AI agents and assistants? Register for Virtual Agents Day here → https://ibm.biz/BdaAVa Want to play with the ...	https://i.ytimg.com/vi/qYNweeDHiyU/hqdefault.jpg
25	6	4RixMPF4xis	Learn more about watsonx: https://ibm.biz/BdvxDS What is really the difference between Artificial intelligence (AI) and machine ...	https://i.ytimg.com/vi/4RixMPF4xis/hqdefault.jpg
26	6	FbtYxPUrhq8	Comp Sci vs AI vs ML vs Gen AI ‼️ #ai #tech #ml #fyp.	https://i.ytimg.com/vi/FbtYxPUrhq8/hqdefault.jpg
27	7	5aww-Bpgkf4	We often think of health as a self-centric phenomenon that begins and ends with "me", but as we'll explore throughout this series ...	https://i.ytimg.com/vi/5aww-Bpgkf4/hqdefault.jpg
28	7	7FAEAt7UYUQ	Hi, I am a UK-based public health doctor and I make videos that help to demystify public health. In this video, I answer a question I ...	https://i.ytimg.com/vi/7FAEAt7UYUQ/hqdefault.jpg
29	7	Hh-y2QuaLJ8	Why is public health so important to take into account when dealing with the field of medicine? While these schisms may seem ...	https://i.ytimg.com/vi/Hh-y2QuaLJ8/hqdefault.jpg
30	7	t_eWESXTnic	Check out the updated video: https://youtu.be/Y6DPDC_Mf90 In this video we take a look at Public Health – the science and art of ...	https://i.ytimg.com/vi/t_eWESXTnic/hqdefault.jpg
31	7	O4udg3W8jT4	In this video, we're going to take a look at what public health is, how it's different to clinical medicine, who's responsible for doing it ...	https://i.ytimg.com/vi/O4udg3W8jT4/hqdefault.jpg
32	8	ZgISHc0H8MQ	A strong focus on evidence in public health and global health interventions is essential for us to truly evaluate their impact and ...	https://i.ytimg.com/vi/ZgISHc0H8MQ/hqdefault.jpg
33	8	7FAEAt7UYUQ	Hi, I am a UK-based public health doctor and I make videos that help to demystify public health. In this video, I answer a question I ...	https://i.ytimg.com/vi/7FAEAt7UYUQ/hqdefault.jpg
34	8	O4udg3W8jT4	In this video, we're going to take a look at what public health is, how it's different to clinical medicine, who's responsible for doing it ...	https://i.ytimg.com/vi/O4udg3W8jT4/hqdefault.jpg
35	8	Hh-y2QuaLJ8	Why is public health so important to take into account when dealing with the field of medicine? While these schisms may seem ...	https://i.ytimg.com/vi/Hh-y2QuaLJ8/hqdefault.jpg
36	8	Y6DPDC_Mf90	In this video, we take a look at Public Health – the science and art of preventing disease, prolonging life, and promoting health ...	https://i.ytimg.com/vi/Y6DPDC_Mf90/hqdefault.jpg
37	9	xV_ddFmSr_8	In this short video recorded for the John Snow Society to mark the bicentenary of John Snow's birth, Dr. Henderson describes the ...	https://i.ytimg.com/vi/xV_ddFmSr_8/hqdefault.jpg
38	9	0NNRGQuJzkI	The public health system in New South Wales is under intense strain, with severe staff shortages and ongoing strikes, as an ...	https://i.ytimg.com/vi/0NNRGQuJzkI/hqdefault.jpg
39	9	wfsJXo1h1G0	The U.S. health-care system is broken, but do other countries have it better? Seven leading health economists and public policy ...	https://i.ytimg.com/vi/wfsJXo1h1G0/hqdefault.jpg
40	9	7FAEAt7UYUQ	Hi, I am a UK-based public health doctor and I make videos that help to demystify public health. In this video, I answer a question I ...	https://i.ytimg.com/vi/7FAEAt7UYUQ/hqdefault.jpg
41	9	Hh-y2QuaLJ8	Why is public health so important to take into account when dealing with the field of medicine? While these schisms may seem ...	https://i.ytimg.com/vi/Hh-y2QuaLJ8/hqdefault.jpg
42	10	HxTJBRNYkvU	Looking to buy gold and silver? Check out https://pimbex.com ✓ Claim your EXCLUSIVE $1000 discount on my #1 favorite ...	https://i.ytimg.com/vi/HxTJBRNYkvU/hqdefault.jpg
43	10	_fuFPrOWel0	Financial advisors, regulators, and retail investors alike use Asset Allocations as a barometer of the risk level in a retiree's ...	https://i.ytimg.com/vi/_fuFPrOWel0/hqdefault.jpg
44	10	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
45	10	DFH8EvMXfCk	Prep Packages for the CFA® Program offered by AnalystPrep (study notes, video lessons, question bank, mock exams, and much ...	https://i.ytimg.com/vi/DFH8EvMXfCk/hqdefault.jpg
46	10	HrKF5RXc9kE	Asset allocation is one of the most important concepts in investing. In this video, we'll define asset allocation, discuss the benefits ...	https://i.ytimg.com/vi/HrKF5RXc9kE/hqdefault.jpg
47	11	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
48	11	-4P3MTbaBUM	Sign up for Our Complete Finance Training at 57% OFF ➡️https://bit.ly/3E8aEl2 ...	https://i.ytimg.com/vi/-4P3MTbaBUM/hqdefault.jpg
49	11	N4aJNprgI-g	More Videos like this Charline Munger: Why I HATE Tesla? https://youtu.be/SzAVnkwo8I0 Charlie Munger: Why China is Better ...	https://i.ytimg.com/vi/N4aJNprgI-g/hqdefault.jpg
50	11	Uw_QyeHo8f0	Warren Buffett shares 3 core principles for stock market investing. They're all very simple yet so important! Buffett generously ...	https://i.ytimg.com/vi/Uw_QyeHo8f0/hqdefault.jpg
51	11	8uysmVS66zg	WORRIED ABOUT THE MARKET? SCHEDULE YOUR FREE PORTFOLIO REVIEW with Thoughtful Money's endorsed financial ...	https://i.ytimg.com/vi/8uysmVS66zg/hqdefault.jpg
52	12	w9QoCKbx6d8	Financial analyst Gary Shilling reveals the lessons he has learned about the economy and markets, how to stay ahead, and why ...	https://i.ytimg.com/vi/w9QoCKbx6d8/hqdefault.jpg
53	12	HbiT3tjIYdw	Explore the rapid growth and impact of ESG funds on global financial markets. #ESG #SustainableInvesting #Finance ...	https://i.ytimg.com/vi/HbiT3tjIYdw/hqdefault.jpg
54	12	HaOuYWqBG6A	The role of ESG ratings in redefining investment strategies and their impact on corporate behavior is discussed. #ESG ...	https://i.ytimg.com/vi/HaOuYWqBG6A/hqdefault.jpg
55	12	_RwUwGI6swk	Explore the transformative impact of ESG and Sustainability in the investment management industry! Watch this short video to ...	https://i.ytimg.com/vi/_RwUwGI6swk/hqdefault.jpg
56	12	tmryHfunyQ4	Use the promo code TILBURY to get a free share worth up to £100 or visit https://www.trading212.com/join/TILBURY (terms ...	https://i.ytimg.com/vi/tmryHfunyQ4/hqdefault.jpg
57	13	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
58	13	9tx40k42RO0	Find out what geopolitics is all about and why it's so important. How geopolitics work and what factors influence it? Demographics ...	https://i.ytimg.com/vi/9tx40k42RO0/hqdefault.jpg
59	13	BDqvzFY72mg	Professor Ian Shapiro introduces the class “Power and Politics in Today's World.” This course provides an examination of political ...	https://i.ytimg.com/vi/BDqvzFY72mg/hqdefault.jpg
60	13	BS-4hdyIVpk	Explore the intricate web of geopolitical flashpoints across the globe! This eye-opening discussion delves into the significance of ...	https://i.ytimg.com/vi/BS-4hdyIVpk/hqdefault.jpg
61	14	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
62	14	ne5umTPNXqc	How is India managing a world of rising global powers and shifting alliances? #India #geopolitics #explained ...	https://i.ytimg.com/vi/ne5umTPNXqc/hqdefault.jpg
63	15	689wnA1ZuVo	It's been an eventful first 100 days for the second Trump administration, which has featured tariff turmoil, shifting foreign policy and ...	https://i.ytimg.com/vi/689wnA1ZuVo/hqdefault.jpg
64	15	igrB2GNK5lI	What's shaping the US foreign policy? A more inward-looking approach, with a focus on domestic priorities, might be the way ...	https://i.ytimg.com/vi/igrB2GNK5lI/hqdefault.jpg
65	15	GrVsEZ8FyGM	Today I'm talking to Dr. Hasan Ünal, a full professor at the Department of Political Science and International Relations at Bashkent ...	https://i.ytimg.com/vi/GrVsEZ8FyGM/hqdefault.jpg
66	15	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 225, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 4, true);


--
-- Name: fav_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_videos_id_seq', 5, true);


--
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_id_seq', 1, false);


--
-- Name: hidden_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_articles_id_seq', 1, true);


--
-- Name: hidden_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_questions_id_seq', 1, false);


--
-- Name: hidden_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_videos_id_seq', 1, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 15, true);


--
-- Name: refresh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.videos_id_seq', 66, true);


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

