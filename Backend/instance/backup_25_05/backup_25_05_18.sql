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
1	0	1	NewsAPI	Prof. Schlevogt’s Compass No. 15: Kakistocratic defense splurgers destroy Europe	Eighty years after WW II, EU leaders are approving huge budgets to solve a self-made security problem. Yet the silver bullets are defective Read Full Article at RT.com	It has been said that quantity has quality all of its own.\r\nThe origins of this dictum, which is often attributed to Soviet leader Joseph Stalin, can be traced back to ancient dialecticians. They arg… [+34476 chars]	https://www.rt.com/news/617535-defence-splurgers-destroy-europe/	https://mf.b37mrtl.ru/files/2025.05/article/6824bc4a2030274d231eb22c.jpg	2025-05-14 16:00:23
2	0	1	NewsAPI	Parity Agriculture Is The Answer To The Farming Crisis	The United States is in the midst of an existential farm crisis. From the wholesale disappearance of the family farm, overproduction, and industrial scale farming to depleted farm land, corporate control of farms, and the unsustainability of the subsidy cultu…	The United States is in the midst of an existential farm crisis. From the wholesale disappearance of the family farm, overproduction, and industrial scale farming to depleted farm land, corporate con… [+46017 chars]	https://www.activistpost.com/parity-agriculture-is-the-answer-to-the-farming-crisis/	https://www.activistpost.com/wp-content/uploads/2025/04/usa-flag.jpg	2025-04-19 22:00:00
3	0	2	NewsAPI	Barr, Artificial Intelligence and the Labor Market: A Scenario-Based Approach	Thank you for the opportunity to speak to you today.  1     In my remarks, I would like to address a key question facing economists, policymakers, and people a	Thank you for the opportunity to speak to you today.1 In my remarks, I would like to address a key question facing economists, policymakers, and people all over the world: How will artificial intelli… [+31838 chars]	https://www.federalreserve.gov/newsevents/speech/barr20250509a.htm	https://www.federalreserve.gov/images/social-media/social-default-image-opengraph.jpg	2025-05-09 09:55:00
4	0	2	NewsDATA	Why Nigeria’s strategic grain reserves fail to curb food insecurity	Recently, the Minister of Information and National Orientation, Alhaji Mohammed Idris, said Nigeria was witnessing a reduction in prices of foodstuffs, which was already bringing relief to the people.The post Why Nigeria’s strategic grain reserves fail to curb food insecurity appeared first on The Guardian Nigeria News - Nigeria and World News.	ONLY AVAILABLE IN PAID PLANS	https://guardian.ng/features/focus/why-nigerias-strategic-grain-reserves-fail-to-curb-food-insecurity/	https://cdn.guardian.ng/wp-content/uploads/2025/05/Katsina-Grain-Reserves.jpg	2025-05-17 05:11:43
5	0.178	3	NewsAPI	Key Inflation Measure Slowed To Multiyear Low In March—But Tariff Bump On The Horizon	The Federal Reserve’s favored inflation yardstick has been above its 2% target for 49 consecutive months.	Inflation moderated as expected in March, according to data released Wednesday morning, with President Donald Trumps tariffs looming large as many economists expect the trade policy to complicate the… [+2238 chars]	https://www.forbes.com/sites/dereksaul/2025/04/30/inflation-slowed-to-multiyear-low-in-march-but-tariff-bump-on-the-horizon/	https://imageio.forbes.com/specials-images/imageserve/68121f8bf592aabd6836d545/0x0.jpg?format=jpg&crop=2604,1465,x0,y129,safe&height=900&width=1600&fit=bounds	2025-04-30 14:04:37
6	0.089	3	NewsAPI	Trump Is Paving the Way for Another ‘China Shock’	The MIT economist David Autor helped fracture the old free-trade consensus. But he thinks that what’s replacing it is even worse.	To the extent that Donald Trumps trade war with China is based on a coherent story about the world, it is this: Free trade with China has been a disaster for the American worker, and we need tariffs … [+12977 chars]	https://www.theatlantic.com/economy/archive/2025/04/trump-china-shock-manufacturing/682631/?utm_source=yahoo	https://s.yimg.com/ny/api/res/1.2/cOWpANfllxtwLEgyk57T2Q--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_atlantic_news_articles_892/f30c78bbefaef4cc3158333e8e64ebfc	2025-04-29 11:00:00
7	0.089	3	NewsAPI	How these 80-somethings are stitching together work, savings, and Social Security to get through the month	Some older Americans are working past 80 to supplement Social Security and cover their expenses, sometimes in risky or laborious jobs.	Richard Stephen/Getty, Ricky John Molloy/Getty, BI\r\n<ul><li>Some older Americans are working past 80 to supplement Social Security and cover their expenses.</li><li>Rising inflation and health issues… [+6650 chars]	https://www.businessinsider.com/cant-retire-still-working-retirement-age-social-security-inflation-health-2025-4	https://i.insider.com/67f7e0e5c6ad288d147dca3c?width=1200&format=jpeg	2025-04-19 08:01:01
8	0.089	3	NewsAPI	Mortgage Forecast: Tariffs Paused, Fed on Hold, What's Next for Rates in May?	The direction of mortgage rates hinges on Trump's tariff agenda, the Fed and the financial markets.	Mortgage rates can change daily and even hourly. \r\nTharon Green/CNET\r\nMortgage rates are being influenced by headlines about ongoing trade negotiations, the path of inflation and shifting expectation… [+5153 chars]	https://www.cnet.com/personal-finance/mortgages/mortgage-forecast-tariffs-paused-fed-on-hold-whats-next-for-rates-in-may/	https://www.cnet.com/a/img/resize/27c21aabdaf21bc6fd1e86e53460fd518c98f558/hub/2024/07/29/5090ba2f-9272-47a1-8cdf-a914b00cd178/weekly-mortgage-predictions-4.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-16 13:07:00
9	0.089	3	NewsAPI	A big Federal Reserve meeting kicks off today. Here's what to expect	The Federal Reserve’s two-day policy meeting kicks off Tuesday morning, and its outcome could have a huge effect on the U.S. economy for the foreseeable future.Read more...	In This Story\r\nThe Federal Reserves two-day policy meeting kicks off Tuesday morning, and its outcome could have a huge effect on the U.S. economy for the foreseeable future.\r\nA lot has happened sinc… [+2195 chars]	https://qz.com/federal-reserve-policy-meeting-fomc-trump-tariffs-1851779310	https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/27466638c940194ca2c92c68afc2f996.jpg	2025-05-06 14:18:00
10	0.089	3	NewsAPI	Mortgage Rates at a Tipping Point. Why Trump's Tariffs Have the Housing Market on Edge	The trade war is making homebuyers brace for a spike in mortgage interest rates.	Mortgage rates are bouncing around, though not because of inflation data or job numbers. Financial markets (stocks and bonds) are being shaken by President Donald Trump's on-again, off-again tariffs.… [+5119 chars]	https://www.cnet.com/personal-finance/mortgages/mortgage-rates-at-a-tipping-point-why-trumps-tariffs-have-the-housing-market-on-edge/	https://www.cnet.com/a/img/resize/accd46fcaa4bc34ec41ef57d18835c3da1074aa5/hub/2025/04/16/9a5add51-fff6-4d5c-ad8d-128db5422327/final.jpg?auto=webp&fit=crop&height=675&width=1200	2025-04-18 18:00:18
11	0.089	3	NewsAPI	US Federal Reserve holds rates steady, warns of higher unemployment	The central bank will hold steady amid economic uncertainty driven by tariffs.	The US Federal Reserve has kept interest rates unchanged, brushing off President Donald Trumps demands to lower borrowing costs, and said that the risks of higher unemployment and higher inflation ha… [+2963 chars]	https://www.aljazeera.com/economy/2025/5/7/us-federal-reserve-holds-rates-steady-warns-of-higher-unemployment	https://www.aljazeera.com/wp-content/uploads/2025/04/AP25111553336803-1745280884.jpg?resize=1920%2C1440	2025-05-07 18:42:56
12	0.089	3	NewsAPI	Fed Doesn't Cut Interest Rates Again—Despite Trump's Demands	"The risks of higher unemployment and higher inflation have risen," the Fed said Wednesday.	The Federal Reserve said Wednesday afternoon it wont move interest rates, matching expectations from economists and investors for the central bank, despite repeated, loud requests from the Oval Offic… [+4546 chars]	https://www.forbes.com/sites/dereksaul/2025/05/07/fed-doesnt-cut-interest-rates-again-despite-trumps-demands/	https://imageio.forbes.com/specials-images/imageserve/681b9fbafc0f88ef0d4e922d/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-07 18:01:13
13	0.089	3	NewsDATA	Economists expect end of consumer carbon price pulled down April inflation to 1.6%	OTTAWA — Canadian motorists were paying less at the pump in April after the Liberals nixed the consumer carbon price — a move economists expect will help keep inflation around the Bank of Canada’s two per cent target as tariff woes percolate. Statistics Canada is set to release its consumer price index figures for April [...]The post Economists expect end of consumer carbon price pulled down April inflation to 1.6% appeared first on CityNews Montreal.	ONLY AVAILABLE IN PAID PLANS	https://montreal.citynews.ca/2025/05/18/economists-expect-end-of-consumer-carbon-price-pulled-down-april-inflation-to-1-6/	https://montreal.citynews.ca/wp-content/blogs.dir/sites/19/2025/04/047d098491ea53a946d2aa79f569af4d37d41df0722ca009757e922ac1593d08-1024x716.jpg	2025-05-18 10:00:13
14	0.089	3	NewsDATA	Economists expect end of consumer carbon price pulled down April inflation to 1.6%	OTTAWA - Canadian motorists were paying less at the pump in April after the Liberals nixed the consumer carbon price — a move economists expect will help keep inflation around the Bank of Canada's two per cent target as tariff...	ONLY AVAILABLE IN PAID PLANS	https://www.thestar.com/business/economists-expect-end-of-consumer-carbon-price-pulled-down-april-inflation-to-1-6/article_c4cec513-53e6-57dd-8be2-6490541002ac.html	https://bloximages.chicago2.vip.townnews.com/thestar.com/content/tncms/assets/v3/editorial/3/3f/33f9feb5-4fc6-52b5-b50c-0423c25317cc/6829b0d11af21.image.jpg?resize=300%2C210	2025-05-18 10:00:13
15	0	3	NewsAPI	Mortgage Rate Forecast for May: Can Rates Fall Without Fed Cuts?	The Fed is weighing inflation, recession indicators and uncertain trade policies. Here's how that impacts mortgage rates.	Mortgage rates can change daily and even hourly. \r\nTharon Green/CNET\r\nLong-term housing market predictions have been clouded by economic uncertainty under the Trump administration's trade and austeri… [+4765 chars]	https://www.cnet.com/personal-finance/mortgages/mortgage-rate-forecast-for-may-can-rates-fall-without-fed-cuts/	https://www.cnet.com/a/img/resize/78ddbce576110573dc7cd74ab42f4e379e822467/hub/2024/09/18/11edb036-100c-4588-bd0d-aadf10564429/weekly-mortgage-predictions-2.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-05 18:40:00
16	0	3	NewsAPI	Fed Plans to Pause Interest Rate Cuts, Again. Here's Why You Should Care	Tariffs are threatening higher inflation, and that's putting pressure on the Fed to keep borrowing costs high.	The central bank is widely expected to keep its benchmark interest rate at a range of 4.25% to 4.5%. \r\nWong Yu Liang/Getty Images\r\nInterest rates aren't likely to budge today. You can blame tariffs. … [+7075 chars]	https://www.cnet.com/personal-finance/banking/fed-plans-to-pause-interest-rate-cuts-again-heres-why-you-should-care/	https://www.cnet.com/a/img/resize/b51fc97107eacaa37e07e1f0aebdfbfe2ac07a6b/hub/2025/05/06/dd331980-aa87-4113-b35d-79a33b62424f/gettyimages-1412799407.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-07 12:00:00
17	0	3	NewsAPI	Trump's second-term economy is defined by one word: uncertainty. These charts show how.	Tuesday marks Donald Trump's 100th day as president. BI examined how Americans feel about the economy, stocks, inflation, and tariffs.	Getty Images; Jenny Chang-Rodriguez/BI\r\n<ul><li>President Donald Trump's first 100 days have been full of economic activity, from tariffs to federal firings.</li><li>While much of this hasn't yet sho… [+11627 chars]	https://www.businessinsider.com/donald-trump-100th-day-inflation-economy-tariffs-markets-stocks-businesses-2025-4	https://i.insider.com/6802a2b5c6ad288d147e9a63?width=1200&format=jpeg	2025-04-29 08:00:02
18	0	3	NewsAPI	Fed Meeting Keeps Interest Rates High. Here's Why That's a Big Deal for Your Finances	Uncertainty about the economic outlook has increased further, according to the central bank.	The central bank kept its benchmark interest rate at a range of 4.25% to 4.5%. \r\nWong Yu Liang/Getty Images\r\nAs expected, interest rates didn't budge today. You can blame tariffs. \r\nAt the conclusion… [+7118 chars]	https://www.cnet.com/personal-finance/banking/fed-meeting-keeps-interest-rates-high-heres-why-thats-a-big-deal-for-your-finances/	https://www.cnet.com/a/img/resize/b51fc97107eacaa37e07e1f0aebdfbfe2ac07a6b/hub/2025/05/06/dd331980-aa87-4113-b35d-79a33b62424f/gettyimages-1412799407.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-07 18:30:00
19	0	3	NewsAPI	The smartest things economists are saying about a possible recession	Is the US entering a recession, or can it be avoided? Here is what economists think could happen.	Getty Images; Chelsea Jia Feng/BI\r\n<ul><li>In the first quarter of 2025, the US economy shrank for the first time in three years.</li><li>This doesn't mean a recession is here.</li><li>Here's what ec… [+7529 chars]	https://www.businessinsider.com/recession-outlook-reactions-commentators-economy-2025-5	https://i.insider.com/681256f9a466d2b74ab4996f?width=1200&format=jpeg	2025-05-01 08:00:03
20	0	3	NewsAPI	Stagflation or Recession: With Tariffs on Pause, Is the Economy Really OK?	With Trump's trade war, economic forecasts are changing every day.	Stagflation can be worse than a recession. Investors are already bracing for it. \r\nGetty Images/ DNY59/ Jeffrey Hazelwood\r\nEven if you haven't lived through a major recession, it's scary to think abo… [+11059 chars]	https://www.cnet.com/personal-finance/banking/stagflation-or-recession-with-tariffs-on-pause-is-the-economy-really-ok/	https://www.cnet.com/a/img/resize/a3ae64dacada0cdc4142d3982c1df8686a84c089/hub/2025/05/14/77b99e90-d1a2-430a-b134-05d6845b5bcc/image-9.png?auto=webp&fit=crop&height=675&width=1200	2025-05-15 11:00:00
21	0	3	NewsAPI	100 days into Trump's economy, one thing's clear: Americans are worried	BI examined sentiment data, markets chaos, and interviews with small business owners, consumers, and economists. They point toward one thing.	SAUL LOEB/AFP via Getty Images\r\n<ul><li>This post originally appeared in the Business Insider Today newsletter.</li><li>You can sign up for Business Insider's daily newsletter here.</li></ul>Good mor… [+6422 chars]	https://www.businessinsider.com/100-days-trump-economy-drama-uncertainty-stagflation-consumers-tariffs-2025-4	https://i.insider.com/6810d318c6ad288d147f69dd?width=1200&format=jpeg	2025-04-29 13:58:35
64	0	7	NewsAPI	Meet the 10 AI startup unicorns with tiny teams	These AI startups are hitting billion-dollar valuations with 50 employees or fewer as founders use new tech to maintain lean teams.	Ilya Sutskever, cofounder and chief scientist at Safe Superintelligence and cofounder and former chief scientist at OpenAI.JACK GUEZ/AFP via Getty Images\r\n<ul><li>Artificial intelligence is helping s… [+8162 chars]	https://www.businessinsider.com/ai-startup-unicorns-with-tiny-teams-2025-5	https://i.insider.com/6819319ac6ad288d1480140c?width=1200&format=jpeg	2025-05-07 09:00:02
22	0	3	NewsAPI	Wall Street's big voices are weighing in on Trump's feud with Powell — and most aren't happy	President Donald Trump might be planning to make Jerome Powell his scapegoat, but blaming the Fed chair could backfire badly, analysts and economists said.	Federal Reserve Chair Jerome Powell and President Donald Trump outside the White House.Drew Angerer/Getty Images\r\n<ul><li>President Donald Trump has hit out at Fed chair Jerome Powell for not cutting… [+5739 chars]	https://www.businessinsider.com/trump-powell-feud-fed-rates-wall-street-siegel-roubini-krugman-2025-4	https://i.insider.com/680788eca466d2b74ab3c434?width=687&format=jpeg	2025-04-22 13:39:06
23	0	3	NewsAPI	Trump claims grocery and gas prices are falling. Experts say that's misleading	"Prices are still going up," one expert said.	President Donald Trump on Friday claimed grocery and gas prices are falling, an assertion he's made repeatedly since taking office.\r\nIn a post on social media, Trump touted the price levels alongside… [+4648 chars]	https://abcnews.go.com/Business/trump-claims-grocery-gas-prices-falling-experts-misleading/story?id=121410734	https://i.abcnewsfe.com/a/bd55a8b0-dcda-45ea-8841-ee3540f97222/grocery-rt-er-250502_1746214585130_hpMain_16x9.jpg?w=1600	2025-05-03 13:24:00
24	0	3	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	Listen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, charm brac… [+12550 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o	https://ichef.bbci.co.uk/news/1024/branded_news/aae4/live/82babf60-2be4-11f0-8f57-b7237f6a66e6.png	2025-05-13 01:02:20
25	0.185	4	NewsAPI	These protesters want you to reduce, repair and rewear	In this issue of our environmental newsletter, we hang out with protesters mending clothes in public, see what extreme weather our children can expect to experience and find out what science says about not mowing your lawn in May.	Hello, Earthlings! This is our weekly newsletter on all things environmental, where we highlight trends and solutions that are moving us to a more sustainable world. Keep up with the latest news on o… [+12239 chars]	https://www.cbc.ca/news/science/what-on-earth-mending-1.7535510	https://i.cbc.ca/1.7531216.1746809815!/fileImage/httpImage/image.jpeg_gen/derivatives/16x9_1180/participant-at-mend-in-public-day.jpeg?im=Resize%3D620	2025-05-15 18:25:45
26	0.178	4	NewsAPI	The false climate solution that just won’t die	On Tuesday, a pair of documentaries landed on Amazon Prime that put forth a rather bold claim: By simply making a few tweaks to how we farm, humanity can reverse climate change and all but eliminate a host of other problems stemming from our modern food syste…	On Tuesday, a pair of documentaries landed on Amazon Prime that put forth a rather bold claim: By simply making a few tweaks to how we farm, humanity can reverse climate change and all but eliminate … [+9082 chars]	https://www.vox.com/future-perfect/409940/regenerative-agriculture-kiss-the-ground-common-ground	https://platform.vox.com/wp-content/uploads/sites/2/2025/04/GettyImages-1348953776.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200	2025-04-22 21:34:19
27	0.089	4	NewsAPI	Scientists say NOAA cuts by Trump undermine improvements in hurricane forecasts	The Trump administration is targeting top climate and weather labs for cuts. Insiders worry about the impact on research and NOAA's ability to forecast severe weather like hurricanes and tornadoes.	MIAMI Weather and climate research are among the programs seeing big cuts by the Trump administration. \r\nHundreds of employees at NOAA the National Oceanic and Atmospheric Administration who work at … [+4401 chars]	https://www.npr.org/2025/04/25/nx-s1-5361474/noaa-cuts-hurricane-forecast-improvements-trump	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3900x2194+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F9e%2F96%2Fa366b9ba4a2a958fd8f8c1a55c33%2Fgettyimages-2177097712.jpg	2025-04-25 09:00:00
28	0.089	4	NewsAPI	Scientist sounds alarm after disturbing photo from Arctic expedition resurfaces: 'Feels like they could just sink at any moment'	"Science has a communication problem."	A famous photo from 2019 provides a snapshot of the changing climate and offers a glimpse of the future, scientists say.\r\nWhat's happening?\r\nThe image, featuring a first-person view of eight sled dog… [+2752 chars]	https://www.yahoo.com/news/scientist-sounds-alarm-disturbing-photo-121558211.html	https://s.yimg.com/ny/api/res/1.2/9SxazeP0bYNERRWxTm0fUQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_cool_down_737/4f5dfa89434f47d48c408c3b64f10f5c	2025-04-29 12:15:58
29	0.089	4	NewsAPI	Trump Dismisses Scientists Writing the National Climate Assessment	President Trump has dismissed hundreds of scientists working on the congressionally mandated National Climate Assessment, raising concerns about whether the void will be filled with pseudoscience	CLIMATEWIRE | The Trump administration on Monday dismissed all of the scientists working on the newest version of the National Climate Assessment, a sweeping report that outlines the growing dangers … [+4128 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/29/trump-dismisses-scientists-writing-the-national-climate-assessment-00314494	https://static.scientificamerican.com/dam/m/768e21512db2705d/original/Firefighters_watch_fire.jpg?m=1745935059.9&w=1200	2025-04-29 14:20:00
30	0.089	4	NewsAPI	A vicious cycle: How methane emissions from warming wetlands could exacerbate climate change	The latest study finds that emissions of the potent greenhouse gas might be higher than previously estimated.	Warming in the Arctic is intensifying methane emissions, contributing to a vicious feedback loop that could accelerate climate change even more, according to a new study published May 7 in Nature."Me… [+5013 chars]	https://www.sciencedaily.com/releases/2025/05/250515191232.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-15 23:12:32
31	0.089	4	NewsAPI	Shorter and warmer winters may expand the hibernation area of bats in Europe	The ambient temperature has a profound impact on the physiology and behaviour of most species. In regions where individuals rely on low temperatures to hibernate effectively, global warming is likely to significantly affect their survival. A team of scientist…	The ambient temperature has a profound impact on the physiology and behaviour of most species. In regions where individuals rely on low temperatures to hibernate effectively, global warming is likely… [+5619 chars]	https://www.sciencedaily.com/releases/2025/05/250505121907.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-05 16:19:07
65	0	7	NewsAPI	What is the Turing test? How the rise of generative AI may have broken the famous imitation game.	Is the Turing test still relevant in today's AI landscape? The advent of large language models has challenged its importance.	"Can machines think?" That's the core question legendary mathematician and computer scientist Alan Turing posed\r\n in October, 1950. Turing wanted to assess whether machines could imitate or exhibit h… [+7125 chars]	https://www.livescience.com/technology/artificial-intelligence/what-is-the-turing-test	https://cdn.mos.cms.futurecdn.net/xW8ZfeUgHWKcgpGqEUSoEM.png	2025-05-14 09:00:10
32	0.089	4	NewsAPI	Global temperatures stuck at near-record highs in April: EU monitor	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might be warming.	Global temperatures were stuck at near-record highs in April, the EU's climate monitor said on Thursday, extending an unprecedented heat streak and raising questions about how quickly the world might… [+3870 chars]	https://phys.org/news/2025-05-global-temperatures-stuck-highs-april.html	https://scx2.b-cdn.net/gfx/news/2025/scientists-are-unanimo.jpg	2025-05-08 17:09:48
33	0.089	4	NewsAPI	Current Climate: Major Assault On California’s Environmental Rules	In this week's Current Climate, California's ability to set tough environmental rules is under attack; Elon Musk is out of ideas to revive Tesla; domestically sourced lithium-sulfur batteries	Plus: Elon Musk runs out of ideas to save Tesla; cheaper, domestically sourced lithium-sulfur batteries\r\nCurrent Climate brings you the latest news about the business of sustainability every Monday. … [+10833 chars]	https://www.forbes.com/sites/alanohnsman/2025/05/05/current-climate-a-major-assault-on-californias-environmental-rules/	https://imageio.forbes.com/specials-images/imageserve/681541b451ae5311ac7d37e4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 12:45:00
34	0.089	4	NewsAPI	Big Oil Knew, Big Oil Lied: Fossil Fuel’s Long Strategy Of Deceit	A new UCS report reveals how fossil fuel giants spent decades disseminating climate disinformation, delaying action and fueling rising emissions and climate costs.	COTTBUS, GERMANY - APRIL 12: (Photo by Sean Gallup/Getty Images)\r\nGetty Images\r\nIn recent decades, increases in extreme weather have laid bare the mounting risk created by climate change, prompting b… [+7445 chars]	https://www.forbes.com/sites/feliciajackson/2025/05/14/big-oil-knew-big-oil-lied-fossil-fuels-long-strategy-of-deceit/	https://imageio.forbes.com/specials-images/imageserve/6824a1220179fafd5a554e3c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 14:01:35
35	0.089	4	NewsAPI	Trump administration dismisses scientists writing quadrennial climate report	The National Climate Assessment, a major publication produced every four years that summarizes the impacts of climate change in the U.S., is scheduled for publication in 2027.	Nearly 400 scientists across the United States were informed Monday afternoon that their services were no longer needed to help write a major report on climate change for the federal government.\r\nThe… [+4531 chars]	https://www.cbsnews.com/news/national-climate-assessment-report-scientists-fired/	https://assets3.cbsnewsstatic.com/hub/i/r/2025/04/30/75a4cdd4-74d0-425f-8ef6-f75a91332dd7/thumbnail/1200x630/637eaaf69205c5e0f5f48c059e8c5415/gettyimages-1197857412.jpg?v=fbebbf93950d87ce40fccd82890f0617	2025-04-30 01:34:33
36	0.089	4	NewsAPI	The government just killed an essential way to assess climate risk	Cities, insurers, and the public used the Billion-Dollar Weather and Climate Disasters database to plan for the future. Now what will they do?	Nearly 30 billion-dollar storms rocked the United States last year. Thanks to the National Oceanic and Atmospheric Administrations disaster tracking database, we know that catastrophes are getting mo… [+7887 chars]	http://grist.org/climate/trump-noaa-billion-dollar-weather-and-climate-disasters-database/	https://grist.org/wp-content/uploads/2025/05/GettyImages-217471470d6.jpg?quality=75&strip=all	2025-05-14 08:45:00
37	0.089	4	NewsAPI	An EPA Without Science	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed, they constituted “the greatest and most consequential day o…	On March 12, six weeks into his tenure leading the Environmental Protection Agency, Lee Zeldin announced a suite of thirty-one “historic actions.” Together, the accompanying press release proclaimed,… [+26919 chars]	https://www.nybooks.com/online/2025/05/16/an-epa-without-science/	https://www.nybooks.com/wp-content/uploads/2025/05/Mingle202505_4.jpeg	2025-05-16 14:36:44
38	0.089	4	NewsAPI	Climate Myths, Continued	“Climate change will make earth a living hell!” claims popular astrophysicist Neil DeGrasse Tyson. I don’t believe him. The media say, “All Arctic ice will... Read More\nThe post Climate Myths, Continued appeared first on The Daily Signal.	Climate change will make earth a living hell! claims popular astrophysicist Neil DeGrasse Tyson.\r\nI don’t believe him.\r\nThe media say, All Arctic ice will soon melt away! Polar bears are dying off! G… [+4000 chars]	https://www.dailysignal.com/2025/04/27/climate-myths-continued/	https://www.dailysignal.com/wp-content/uploads/2024/05/shareCardDailySignal.png	2025-04-27 14:00:00
39	0.089	4	NewsDATA	Letters: Silencing NOAA’s climate change tracking only hurts us and our planet	U.S. citizens and scientists have a need and a right to know the size of the problem with regards to climate change.	ONLY AVAILABLE IN PAID PLANS	https://www.chicagotribune.com/2025/05/18/letters-051825-climate-change/	https://www.chicagotribune.com/wp-content/uploads/2025/05/CTC-US-NEWS-FEDERAL-FIRINGS-DP_222553767.jpg?strip=all&w=1400px	2025-05-18 10:00:28
40	0.089	4	NewsDATA	Redlining Shaped the Power Grid. Communities of Color Are Still Paying the Price.	This story was reported by Floodlight, a nonprofit newsroom that investigates the powerful interests stalling climate action. As an ice storm slicked roads across eastern Michigan on February 6, representatives from four houses of worship arrived at the offices of Democratic US Sen. Gary Peters. They wanted Peters to pressure the Trump administration to lift the [...]	ONLY AVAILABLE IN PAID PLANS	https://www.motherjones.com/environment/2025/05/redlining-minority-neighborhoods-power-grid-energy-infrastructure-communities-color/	https://www.motherjones.com/wp-content/uploads/2025/05/Los_Angeles_redlining.jpg?crop=1&h=1350&w=2400	2025-05-18 10:00:00
41	0	4	NewsAPI	Why Snow in New Zealand’s Alps Turned an Alarming Shade of Red	Several years ago, snow in New Zealand's Southern Alps turned red, and while many blamed wildfires at the time, new research uncovers the true culprit.	During the Southern Hemisphere’s summer of 20192020, mountains in New Zealand turned red. New research finally explains why.\r\nResearchers have revealed that New Zealand’s Southern Alps turned red aft… [+2657 chars]	https://gizmodo.com/why-snow-in-new-zealands-alps-turned-an-alarming-shade-of-red-2000593615	https://gizmodo.com/app/uploads/2025/04/red-new-zealand-alps.jpg	2025-04-24 13:35:15
42	0	4	NewsAPI	Trump Torched Decades of Science in Just 100 Days—and the Fallout Is Global	In its first 100 days, the Trump administration has slashed federal agencies, canceled national reports, and yanked funding from universities. The shockwaves will be felt worldwide.	Across seven decades and a dozen presidencies, Americas scientific prowess was arguably unmatched. At universities and federal agencies alike, researchers in the United States revolutionized weather … [+16614 chars]	https://gizmodo.com/trump-torched-decades-of-science-in-just-100-days-and-the-fallout-is-global-2000595721	https://gizmodo.com/app/uploads/2024/10/wildfire-fire-fighter.jpg	2025-05-04 14:00:29
43	0	4	NewsAPI	With Mark Carney’s Win, Trump Is Now Sandwiched Between Two Climate Leaders	The success of Canada's Mark Carney and Mexico's Claudia Sheinbaum is a chance to reflect on the best strategy to tackle climate change.	Mark Carney was elected to a full term as Canadas prime minister Monday with a campaign agenda focused squarely on pushing back on attacks from his counterpart to the South, President Donald Trump. I… [+5835 chars]	https://time.com/7281714/mark-carney-canada-mexico-climate-leadership-strategy/	https://api.time.com/wp-content/uploads/2025/04/mark-carney-climate-change.jpg?quality=85&w=1024&h=628&crop=1	2025-04-30 19:32:15
44	0	4	NewsAPI	El Paso Is Having Its Dustiest Year Since the Actual Dust Bowl	Drought, wind, and climate change are turning the Borderplex into a morass of airborne grit.	If you live in El Paso, Las Cruces, or Ciudad Juárez and feel like youve been inhaling the Chihuahuan Desert lately, youre not imagining things. The Borderplex region is experiencing its dustiest sea… [+2589 chars]	https://gizmodo.com/el-paso-is-having-its-dustiest-year-since-the-actual-dust-bowl-2000596987	https://gizmodo.com/app/uploads/2025/05/dust-el-paso.jpg	2025-05-04 10:00:17
45	0.089	6	NewsDATA	Fishing industry may get reprieve from carp invasion	A stalemate between President Donald Trump and Illinois Gov. JB Pritzker that threatened a $1.2 billion plan to keep invasive carp from reaching the Great Lakes appears to have been settled after the Trump administration offered assurances it will cover...	ONLY AVAILABLE IN PAID PLANS	https://www.nwitimes.com/article_b616c39a-cfc1-52dd-a341-714ddf7ad22a.html	https://bloximages.chicago2.vip.townnews.com/nwitimes.com/content/tncms/assets/v3/editorial/3/c5/3c5de392-c3aa-57ae-9851-c2d7dea4be50/68285ad08c40a.image.jpg?crop=748%2C393%2C0%2C30	2025-05-17 09:45:56
46	0	6	NewsAPI	These protesters want you to reduce, repair and rewear	In this issue of our environmental newsletter, we hang out with protesters mending clothes in public, see what extreme weather our children can expect to experience and find out what science says about not mowing your lawn in May.	Hello, Earthlings! This is our weekly newsletter on all things environmental, where we highlight trends and solutions that are moving us to a more sustainable world. Keep up with the latest news on o… [+12239 chars]	https://www.cbc.ca/news/science/what-on-earth-mending-1.7535510	https://i.cbc.ca/1.7531216.1746809815!/fileImage/httpImage/image.jpeg_gen/derivatives/16x9_1180/participant-at-mend-in-public-day.jpeg?im=Resize%3D620	2025-05-15 18:25:45
47	0	6	NewsAPI	How Denmark’s oysters are transforming foodies into citizen scientists	People counted and collected invasive Pacific oysters found on the seabed and then went on to cook them.	Lea Meilandt Mathisen, CC BY-NC-ND\r\nThis year 80 people put on their waders, grabbed buckets and quadrats (square metal frames), and splashed through the clear shallow waters. Once they reached one o… [+6391 chars]	https://theconversation.com/how-denmarks-oysters-are-transforming-foodies-into-citizen-scientists-255828	https://images.theconversation.com/files/667217/original/file-20250512-56-xcjsf1.jpg?ixlib=rb-4.1.0&rect=0%2C156%2C1772%2C886&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-15 17:13:40
48	0	6	NewsAPI	Millions of People Depend on the Great Lakes’ Water Supply. Trump Decimated the Lab Protecting It.	by Anna Clark \n \n\n \n \n ProPublica is a nonprofit newsroom that investigates abuses of power. Sign up for Dispatches, a newsletter that spotlights wrongdoing around the country, to receive our stories in your inbox every week.\n\n \n\n \n\n \n \n\n\n\n \nJust one year ago…	ProPublica is a nonprofit newsroom that investigates abuses of power. Sign up for Dispatches, a newsletter that spotlights wrongdoing around the country, to receive our stories in your inbox every we… [+13597 chars]	https://www.propublica.org/article/noaa-michigan-lab-toxic-algae-blooms-great-lakes-drinking-water	https://img.assets-c3.propublica.org/images/articles/GettyImages-1183345935_maxWidth_3000_maxHeight_3000_ppi_72_quality_95_embedColorProfile_true.jpg?crop=focalpoint&fit=crop&fp-x=0.5&fp-y=0.5&h=630&imgixProfile=propublicaAssets&q=90&w=1200&s=40367647e9f120c2d6e80cdb85369cd0	2025-05-06 10:00:00
49	0	6	NewsAPI	Millions of people depend on the Great Lakes’ water supply. Trump decimated the lab protecting it. | CNN	Just one year ago, JD Vance was a leading advocate of the Great Lakes and the efforts to restore the largest system of freshwater on the face of the planet.	This story was originally published by ProPublica, a nonprofit newsroom that investigates abuses of power. Sign up for Dispatches, a newsletter that spotlights wrongdoing around the country, to recei… [+12370 chars]	https://www.cnn.com/2025/05/08/health/great-lakes-lab-trump-cuts-propublica	https://media.cnn.com/api/v1/images/stellar/prod/001glwater-20250501-hagen-noaaalgaebloom-2286-1-jpg.jpg?c=16x9&q=w_800,c_fill	2025-05-08 12:35:07
50	0	6	NewsDATA	Local groups unite over concern for forests’ future	Recent forum focuses on stewardship, data collection and advocacy	ONLY AVAILABLE IN PAID PLANS	https://www.aspendailynews.com/news/local-groups-unite-over-concern-for-forests-future/article_27e6cf66-8987-4aad-b26f-3fb8ced4b469.html	https://bloximages.newyork1.vip.townnews.com/aspendailynews.com/content/tncms/assets/v3/editorial/5/f2/5f217250-9281-4711-90b5-92a9590b512a/68299132b8c8e.image.jpg?resize=300%2C169	2025-05-18 08:00:00
51	0.308	7	NewsAPI	Detect hallucinations for RAG-based systems	This post walks you through how to create a basic hallucination detection system for RAG-based applications. We also weigh the pros and cons of different methods in terms of accuracy, precision, recall, and cost.	With the rise of generative AI and knowledge extraction in AI systems, Retrieval Augmented Generation (RAG) has become a prominent tool for enhancing the accuracy and reliability of AI-generated resp… [+22543 chars]	https://aws.amazon.com/blogs/machine-learning/detect-hallucinations-for-rag-based-systems/	https://d2908q01vomqb2.cloudfront.net/f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59/2025/05/06/hallucination_image-1260x375.jpg	2025-05-16 16:44:40
52	0.208	7	NewsDATA	AI models can't tell time or read a calendar, study reveals	Challenges in visual and spatial processing and a deficit in training data have revealed a surprising lack of timekeeping ability in AI systems	ONLY AVAILABLE IN PAID PLANS	https://www.livescience.com/technology/artificial-intelligence/ai-models-cant-tell-time-or-read-a-calendar-study-reveals	https://cdn.mos.cms.futurecdn.net/YUQbp8CZjtLoFCT2feiPYR.jpg	2025-05-17 13:00:00
53	0.2	7	NewsAPI	Podcast: How to Build Effective LLMs When Both Basic Infrastructure and Model Training Data Are Lacking	Olimpiu Pop discusses with Jade Abbott, CTO and co-founder of Lelapa AI, how basic infrastructure scarcities found on the African continent can ignite innovation and help push forward the AI space. Particularly when dealing with never-written languages, you n…	<ul><li>Communication is human society's most essential tool, but we often fail to communicate effectively even when speaking the same language. AI can help make communication universal, transcending… [+32049 chars]	https://www.infoq.com/podcasts/build-effective-llms-infrastructure-data/	https://res.infoq.com/podcasts/build-effective-llms-infrastructure-data/en/card_header_image/jade-abbott-twitter-card-1746516511184.jpg	2025-05-12 11:00:00
54	0.2	7	NewsDATA	Why we're unlikely to get artificial general intelligence anytime soon	Tech leaders like Sam Altman, Dario Amodei, and Elon Musk predict artificial general intelligence (AGI) is imminent, but many experts remain sceptical. Despite rapid AI advances, researchers argue today's systems lack true human-like understanding. Achieving AGI likely requires breakthroughs yet to be discovered, making current forecasts speculative at best.	ONLY AVAILABLE IN PAID PLANS	https://economictimes.indiatimes.com/tech/artificial-intelligence/why-were-unlikely-to-get-artificial-general-intelligence-anytime-soon/articleshow/121227388.cms	https://img.etimg.com/photo/118783427.cms	2025-05-17 04:17:14
55	0.1	7	NewsAPI	The ‘era of experience’ will unleash self-learning AI agents across the web—here’s how to prepare	AI visionaries predict an 'Era of Experience' where AI learns autonomously, and it will have important implications for application design.	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nDavid Silver and Richard Sutton, two renowned AI scientists, argue in a… [+6913 chars]	https://venturebeat.com/ai/the-era-of-experience-will-unleash-self-learning-ai-agents-across-the-web-heres-how-to-prepare/	https://venturebeat.com/wp-content/uploads/2025/04/era-of-experience.webp?w=1024?w=1200&strip=all	2025-04-30 20:38:01
56	0.1	7	NewsAPI	AI Predicts Active Brain Cell Types With High Accuracy	A neuroscience breakthrough has been achieved using AI to identify neuron cell types from the brain activity recordings of mice and monkeys with high accuracy.	A major neuroscience breakthrough has been achieved with the help of an artificial intelligence (AI) deep learning algorithm. In a study published this month in Cell, a multinational team of twenty-t… [+3452 chars]	https://www.psychologytoday.com/us/blog/the-future-brain/202505/ai-predicts-active-brain-cell-types-with-high-accuracy	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-05/pic1095715.jpg?itok=icQyuxp_	2025-05-13 12:05:39
57	0.1	7	NewsAPI	On the Very Real Dangers of the Artificial Intelligence Hype Machine	As long as there’s been research on AI, there’s been AI hype. In the most commonly told narrative about the research field’s development, mathematician John McCarthy and computer scientist Marvin Minsky organized a summer-long workshop in 1956 at Dartmouth Co…	As long as theres been research on AI, theres been AI hype. In the most commonly told narrative about the research fields development, mathematician John McCarthy and computer scientist Marvin Minsky… [+12578 chars]	https://lithub.com/on-the-very-real-dangers-of-the-artificial-intelligence-hype-machine/	https://s26162.pcdn.co/wp-content/uploads/2025/05/AI.jpg	2025-05-13 08:58:02
58	0.1	7	NewsAPI	New study shows AI can predict child malnutrition, support prevention efforts	A multidisciplinary team of researchers has developed an artificial intelligence (AI) model that can predict acute child malnutrition in Kenya up to six months in advance. The tool offers governments and humanitarian organizations critical lead time to delive…	A multidisciplinary team of researchers from the USC School of Advanced Computing and the Keck School of Medicine, working alongside experts from the Microsoft AI for Good Lab, Amref Health Africa, a… [+5010 chars]	https://www.sciencedaily.com/releases/2025/05/250514141640.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-05-14 18:16:40
59	0.1	7	NewsAPI	Insights in implementing production-ready solutions with generative AI	As generative AI revolutionizes industries, organizations are eager to harness its potential. However, the journey from production-ready solutions to full-scale implementation can present distinct operational and technical considerations. This post explores k…	As generative AI revolutionizes industries, organizations are eager to harness its potential. However, the journey from production-ready solutions to full-scale implementation can present distinct op… [+17696 chars]	https://aws.amazon.com/blogs/machine-learning/insights-in-implementing-production-ready-solutions-with-generative-ai/	https://d2908q01vomqb2.cloudfront.net/f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59/2025/04/30/insights-in-implementing-1120x630.jpg	2025-04-30 18:34:40
60	0.1	7	NewsAPI	Almost Timely News: ️ How To Get Started with Local AI Models (2025-04-20)	Almost Timely News: ️ How To Get Started with Local AI Models (2025-04-20) :: View in Browser The Big Plug  My new course, Generative AI Use Cases for Marketers is now available! Content Authenticity Statement 100% of this week’s newsletter was generated …	Almost Timely News: How To Get Started with Local AI Models (2025-04-20) :: View in Browser\r\nThe Big Plug\r\nMy new course, Generative AI Use Cases for Marketers is now available!\r\nContent Authenticity… [+27962 chars]	https://www.christopherspenn.com/2025/04/almost-timely-news-%f0%9f%97%9e%ef%b8%8f-how-to-get-started-with-local-ai-models-2025-04-20/	https://www.christopherspenn.com/wp-content/uploads/2016/07/csp-stylized-logo-blog-header.jpg	2025-04-20 10:30:13
61	0.1	7	NewsAPI	How AI Negotiation Bots Can Deepen Classroom Learning	In the classroom, AI negotiation bots can give students valuable opportunities to role-play negotiations and develop their personal negotiating style, a team of instructors at MIT has found. Here’s how to follow their lead.\nThe post How AI Negotiation Bots Ca…	Increasingly, workers, job seekers, and students are turning to artificial intelligence (AI) tools such as ChatGPT for negotiation advice. AI negotiation tools can offer guidance on how to navigate s… [+6059 chars]	https://www.pon.harvard.edu/daily/negotiation-skills-daily/how-ai-negotiation-bots-can-deepen-classroom-learning/	https://www.pon.harvard.edu/wp-content/uploads/images/posts/Classroom.jpg	2025-04-21 09:00:41
62	0.1	7	NewsAPI	Customize Amazon Nova models to improve tool usage	In this post, we demonstrate model customization (fine-tuning) for tool use with Amazon Nova. We first introduce a tool usage use case, and gave details about the dataset. We walk through the details of Amazon Nova specific data formatting and showed how to d…	Modern large language models (LLMs) excel in language processing but are limited by their static training data. However, as industries require more adaptive, decision-making AI, integrating tools and… [+23692 chars]	https://aws.amazon.com/blogs/machine-learning/customize-amazon-nova-models-to-improve-tool-usage/	https://d2908q01vomqb2.cloudfront.net/f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59/2025/04/23/iML-18065-SolutionOverviewjpg-911x630.jpg	2025-04-28 17:47:59
63	0.1	7	NewsDATA	Qualcomm Unveils Abu Dhabi Hub for AI and IoT Innovation	Arabian Post -Qualcomm Technologies has revealed plans to establish a global engineering centre in Abu Dhabi, marking a significant expansion of its research and development footprint. The new facility will concentrate on cutting-edge technologies such as artificial intelligence, the industrial internet of things, and advanced data centre solutions, positioning Abu Dhabi as a pivotal node within Qualcomm’s worldwide network of engineering operations. This engineering centre is set to bolster [...]via Qualcomm Unveils Abu Dhabi Hub for AI and IoT Innovation	ONLY AVAILABLE IN PAID PLANS	https://thearabianpost.com/qualcomm-unveils-abu-dhabi-hub-for-ai-and-iot-innovation/	https://techafricanews.com/wp-content/uploads/2025/05/Qualcomm-PR.jpg	2025-05-17 06:22:46
66	0	7	NewsAPI	Nvidia Builds An AI Superhighway To Practical Quantum Computing	Nvidia invests in accelerating the transition from experimental to practical quantum computing via AI-driven quantum error correction.	TOPSHOT - Nvidia CEO Jensen Huang delivers a keynote address at the Consumer Electronics Show (CES) ... More in Las Vegas, Nevada on January 6, 2025. (Photo by Patrick T. Fallon / AFP) (Photo by PATR… [+6213 chars]	https://www.forbes.com/sites/gilpress/2025/05/05/nvidia-builds-an-ai-superhighway-to-practical-quantum-computing/	https://imageio.forbes.com/specials-images/imageserve/681722b77a49e2f75e5472a3/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 13:00:00
67	0	7	NewsAPI	Photonic Computing Takes a Step Toward Fruition	Author(s): Ananya PalivelaTwo newly developed computer chips, powered in part by light, have tackled complex computing tasks once considered out of reach for photonic systems.[Physics 18, 84] Published Mon Apr 21, 2025	A quadcore photonic processor developed by Lightmatter.\r\nPhotonic computing uses light instead of electrons to store information and to perform computations, offering the promise of faster analog com… [+6450 chars]	https://physics.aps.org/articles/v18/84	https://physics.aps.org/assets/b4260df3-f273-48c9-a903-4bf7cf59e812/e84_1_thumb.png	2025-04-21 10:00:00
68	0	7	NewsAPI	Film review Oppenheimer (2023), runaway fusion, and runaway AI	In the 2023 film Oppenheimer, during the Manhattan project to develop the nuclear bomb, one of the concerns was whether the nuclear explosion created during a test might create such high temperatures that it leads to the nuclei of nitrogen atoms in the atmosp…	In the 2023 film Oppenheimer, during the Manhattan project to develop the nuclear bomb, one of the concerns was whether the nuclear explosion created during a test might create such high temperatures… [+5577 chars]	https://freethoughtblogs.com/singham/2025/05/14/film-review-oppenheimer-2023-runaway-fusion-and-runaway-ai/	https://freethoughtblogs.com/singham/wp-content/themes/ftb2-theme/images/logo.gif	2025-05-14 23:53:11
69	0	7	NewsAPI	Making AI-generated code more accurate in any language	Researchers developed a more efficient way to control the outputs of a large language model, guiding it to generate text that adheres to a certain structure, like a programming language, and remains error free.	Programmers can now use large language models (LLMs) to generate computer code more quickly. However, this only makes programmers' lives easier if that code follows the rules of the programming langu… [+6821 chars]	https://www.sciencedaily.com/releases/2025/04/250424121658.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-04-24 16:16:58
70	0	7	NewsAPI	What Happens When Teachers Are Replaced With AI? This School Is Finding Out	Alpha School in Brownsville, Texas, promises to deliver a full day's worth of instruction in just two hours with AI tutors. So far, the results are startling.	The 8:15 a.m. scene in front of the school that sits on a dusty, sun-soaked residential street in Brownsville, Texas, just across the border with Mexico, looks much like any other elementary or middl… [+20799 chars]	https://www.newsweek.com/alpha-school-brownsville-ai-expanding-2063669	https://d.newsweek.com/en/full/2636344/alpha-mainer.png	2025-05-01 10:00:02
71	0.3	8	NewsAPI	Foundation Principles of Generative AI, Part 1	In this episode, discover the fundamental principle for mastering generative AI adoption. You will uncover the simple strategy to test AI capabilities across many tasks to find its limits. You will understand the critical safety boundaries for using AI tools …	In this episode, discover the fundamental principle for mastering generative AI adoption. You will uncover the simple strategy to test AI capabilities across many tasks to find its limits. You will u… [+4794 chars]	https://www.christopherspenn.com/2025/05/foundation-principles-of-generative-ai-part-1/	https://www.christopherspenn.com/wp-content/uploads/2025/05/Foundation-Principles-of-Generative-AI-Part-1.png	2025-05-12 09:41:25
72	0.1	8	NewsAPI	Mind Readings: Saving Time With Generative AI, Part 2	In this episode, learn how to automate your AI workflows. You will discover the two main paths for automating AI effectively. You will learn about accessible no-code tools perfect for getting started quickly. You will understand the essential technical requir…	In this episode, learn how to automate your AI workflows.\r\nYou will discover the two main paths for automating AI effectively. You will learn about accessible no-code tools perfect for getting starte… [+10068 chars]	https://www.christopherspenn.com/2025/05/mind-readings-saving-time-with-generative-ai-part-2/	https://www.christopherspenn.com/wp-content/uploads/2025/05/Mind-Readings-Saving-Time-With-Generative-AI-Part-2.png	2025-05-06 09:55:34
73	0.1	8	NewsDATA	AI models can't tell time or read a calendar, study reveals	Challenges in visual and spatial processing and a deficit in training data have revealed a surprising lack of timekeeping ability in AI systems	ONLY AVAILABLE IN PAID PLANS	https://www.livescience.com/technology/artificial-intelligence/ai-models-cant-tell-time-or-read-a-calendar-study-reveals	https://cdn.mos.cms.futurecdn.net/YUQbp8CZjtLoFCT2feiPYR.jpg	2025-05-17 13:00:00
74	0	8	NewsAPI	Improving human beings to make them perform better: Why is transhumanism so harmful?	The technoscientific ambition to improve human beings, as promoted by transhumanists, is the ultimate expression of the political refusal to change our world.	According to transhumanism, there is no alternative to biotechnological optimization, which is the only thing that can save us from extinction. Elon Musk's Neuralink is developing implantable brain-c… [+8298 chars]	https://theconversation.com/improving-human-beings-to-make-them-perform-better-why-is-transhumanism-so-harmful-255696	https://images.theconversation.com/files/665097/original/file-20250116-15-6mpbax.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C4197%2C2098&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-14 12:46:28
75	0	8	NewsAPI	Why agency and cognition are fundamentally not computational	Article URL: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full\nComments URL: https://news.ycombinator.com/item?id=43990107\nPoints: 4\n# Comments: 0	“To live is to know.”\r\n(Maturana, 1988)\r\n“Between the stimulus and the response, there is a space. And in that space lies our freedom and power to choose our responses.”\r\n(Frankl, 1946, 2020)\r\n“Volun… [+166123 chars]	https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2024.1362658/full	https://images-provider.frontiersin.org/api/ipx/w=1200&f=png/https://www.frontiersin.org/files/Articles/1362658/fpsyg-15-1362658-HTML/image_m/fpsyg-15-1362658-g001.jpg	2025-05-14 23:04:23
87	0.1	9	NewsAPI	Faculty to offer two interdisciplinary courses on AI, computing, and society	The fall 2025 semester will feature two courses that bring faculty together from the Faculty of Arts and Sciences, Yale Engineering, and the Yale School of&nbsp;Medicine.	As the influence of artificial intelligence, sophisticated algorithms, and enormous datasets on science and culture grows, Yale students and scholars at Yale are eager to participate in and shape deb… [+7144 chars]	https://fas.yale.edu/news-announcements/news/faculty-offer-two-interdisciplinary-courses-ai-computing-and-society	https://fas.yale.edu/sites/default/files/2025-04/Cross-Divisional-Courses-2025.png	2025-04-21 18:23:39
76	0.2	9	NewsDATA	DigitalOcean (NYSE:DOCN) versus Clikia (OTCMKTS:CLKA) Critical Survey	DigitalOcean (NYSE:DOCN – Get Free Report) and Clikia (OTCMKTS:CLKA – Get Free Report) are both computer and technology companies, but which is the better investment? We will compare the two companies based on the strength of their institutional ownership, analyst recommendations, valuation, profitability, risk, dividends and earnings. Valuation and Earnings This table compares DigitalOcean and [...]	ONLY AVAILABLE IN PAID PLANS	https://www.defenseworld.net/2025/05/18/digitalocean-nysedocn-versus-clikia-otcmktsclka-critical-survey.html	https://www.americanbankingnews.com/wp-content/timthumb/timthumb.php?h=240&src=https%3A%2F%2Fwww.marketbeat.com%2Flogos%2Fclikia-corp-logo-1200x675.jpg%3Fv%3D20230130114948&w=240&zc=2	2025-05-18 05:13:15
77	0.2	9	NewsDATA	When a disaster hits, AI can show where help is needed using social media	When disasters happen—such as hurricanes, wildfires, and earthquakes—every second counts. Emergency teams need to find people fast, send help and stay organized. In today’s world, one of the fastest ways to get information is through social media.In recent years, researchers have explored how artificial intelligence can use social media to help during emergencies. These programs can scan millions of posts on sites such as X, Facebook, and Instagram. However, most existing systems look for simple patterns like keywords or images of damage.In my research as an AI scientist, I’ve developed new models that go further. They can understand the meaning and context of posts—what researchers call semantics. This helps improve how accurately the system identifies people in need and classifies situational awareness information during emergencies. The results show that these tools can give rescue teams a clearer view of what’s happening on the ground and where help is needed most.From posts to lifesaving insightsPeople share billions of posts on social media every day. During disasters, they often share photos, videos, short messages and even their location. This creates a huge network of real-time information. But with so many posts, it’s hard for people to find what’s important quickly. That’s where artificial intelligence helps. These systems, which use machine learning, can scan thousands of posts every second, find urgent messages, spot damage shown in pictures, and tell real information from rumors.During Hurricane Sandy in 2012, people sent over 20 million tweets over six days. If AI tools had been used then, they could have helped find people in danger even faster.Training AIsResearchers begin by teaching AI programs to understand emergencies. In one study I conducted, I looked at thousands of social media posts from disasters. I sorted them into groups like people asking for help, damaged buildings and general comments. Then, I used these examples to train the program to sort new posts by itself.One big step forward was teaching the program to look at pictures and words together. For example, a photo of flooded streets and a message like “we’re trapped” are stronger signals than either one alone. Using both, the system became much better at showing where people needed help and how serious the damage was.Finding information is just the first step. The main goal is to help emergency teams act quickly and save lives.I’m working with emergency response teams in the United States to add this technology to their systems. When a disaster hits, my program can show where help is needed by using social media posts. It can also classify this information by urgency, helping rescue teams use their resources where they are needed most.For example, during a flood, my system can quickly spot where people are asking for help and rank these areas by urgency. This helps rescue teams act faster and send aid where it’s needed most, even before official reports come in.Addressing the challengesUsing social media to help during disasters sounds great, but it’s not always easy. Sometimes, people post things that aren’t true. Other times, the same message gets posted many times or doesn’t clearly state where the problem is. This mix can make it hard for the system to know what’s real.To fix this, I’m working on ways to check a post’s credibility. I look at who posted it, what words they used and whether other posts say the same thing.I also take privacy seriously. I only use posts that anyone can see and never show names or personal details. Instead, I look at the big picture to find patterns.The future of disaster intelligenceAs AI systems improve, they are likely to be even more helpful during disasters. New tools can understand messages more clearly and might even help us see where trouble is coming before it starts.As extreme weather worsens, authorities need fast ways to get good information. When used correctly, social media can show people where help is needed most. It can help save lives and get supplies to the right places faster.In the future, I believe this will become a regular part of emergency work around the world. My research is still growing, but one thing is clear: Disaster response is no longer just about people on the ground—it’s also about AI systems in the cloud.Ademola Adesokan is a postdoctoral researcher in computer science at Missouri University of Science and Technology.This article is republished from The Conversation under a Creative Commons license. Read the original article.	ONLY AVAILABLE IN PAID PLANS	https://www.fastcompany.com/91333764/disaster-first-responders-use-ai-social-media	https://images.fastcompany.com/image/upload/w_1280,q_auto,f_auto,fl_lossy/f_webp,q_auto,c_fit/wp-cms-2/2025/05/p-1-91333764-disaster-first-responders-use-ai-social-media.jpg	2025-05-17 08:30:00
78	0.2	9	NewsDATA	Financial Review: DigitalOcean (NYSE:DOCN) and Alphabet (NASDAQ:GOOGL)	DigitalOcean (NYSE:DOCN – Get Free Report) and Alphabet (NASDAQ:GOOGL – Get Free Report) are both computer and technology companies, but which is the superior business? We will compare the two companies based on the strength of their profitability, dividends, risk, analyst recommendations, institutional ownership, valuation and earnings. Insider and Institutional Ownership 49.8% of DigitalOcean shares [...]	ONLY AVAILABLE IN PAID PLANS	https://www.americanbankingnews.com/2025/05/17/financial-review-digitalocean-nysedocn-and-alphabet-nasdaqgoogl.html	https://www.marketbeat.com/logos/digitalocean-holdings-inc-logo-1200x675.jpg?v=20240424104528	2025-05-17 06:27:12
79	0.1	9	NewsAPI	The ‘era of experience’ will unleash self-learning AI agents across the web—here’s how to prepare	AI visionaries predict an 'Era of Experience' where AI learns autonomously, and it will have important implications for application design.	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nDavid Silver and Richard Sutton, two renowned AI scientists, argue in a… [+6913 chars]	https://venturebeat.com/ai/the-era-of-experience-will-unleash-self-learning-ai-agents-across-the-web-heres-how-to-prepare/	https://venturebeat.com/wp-content/uploads/2025/04/era-of-experience.webp?w=1024?w=1200&strip=all	2025-04-30 20:38:01
80	0.1	9	NewsAPI	US Air Force wants to develop smarter mini-drones powered by brain-inspired AI chips	Plans are underway to create new AI-powered drones that can fly for much longer than current designs.	Scientists are developing an artificial intelligence (AI) chip the size of a grain of rice that can mimic human brains — and they plan to use it in miniature drones.\r\nAlthough AI can automate monoton… [+2748 chars]	https://www.livescience.com/technology/artificial-intelligence/us-air-force-wants-to-develop-smarter-mini-drones-powered-by-brain-inspired-ai	https://cdn.mos.cms.futurecdn.net/itNaNmkkKnSUjPxXWcKiPk.jpg	2025-05-06 11:00:30
81	0.1	9	NewsAPI	AI Predicts Active Brain Cell Types With High Accuracy	A neuroscience breakthrough has been achieved using AI to identify neuron cell types from the brain activity recordings of mice and monkeys with high accuracy.	A major neuroscience breakthrough has been achieved with the help of an artificial intelligence (AI) deep learning algorithm. In a study published this month in Cell, a multinational team of twenty-t… [+3452 chars]	https://www.psychologytoday.com/us/blog/the-future-brain/202505/ai-predicts-active-brain-cell-types-with-high-accuracy	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-05/pic1095715.jpg?itok=icQyuxp_	2025-05-13 12:05:39
82	0.1	9	NewsAPI	Film review Oppenheimer (2023), runaway fusion, and runaway AI	In the 2023 film Oppenheimer, during the Manhattan project to develop the nuclear bomb, one of the concerns was whether the nuclear explosion created during a test might create such high temperatures that it leads to the nuclei of nitrogen atoms in the atmosp…	In the 2023 film Oppenheimer, during the Manhattan project to develop the nuclear bomb, one of the concerns was whether the nuclear explosion created during a test might create such high temperatures… [+5577 chars]	https://freethoughtblogs.com/singham/2025/05/14/film-review-oppenheimer-2023-runaway-fusion-and-runaway-ai/	https://freethoughtblogs.com/singham/wp-content/themes/ftb2-theme/images/logo.gif	2025-05-14 23:53:11
83	0.1	9	NewsAPI	A Potential Path to Safer AI Development	The world’s most cited computer scientist warns that the current approach to developing AI models carries potentially catastrophic risks.	Imagine youre in a car with your loved ones, following an unfamiliar road up a spectacular mountain range. The problem? The way ahead is shrouded in fog, newly built, and lacking both signposts and g… [+8382 chars]	https://time.com/7283507/safer-ai-development/	https://api.time.com/wp-content/uploads/2025/05/AI-Car-Road.jpg?quality=85&w=1200&h=628&crop=1	2025-05-09 10:15:00
84	0.1	9	NewsAPI	How AI Negotiation Bots Can Deepen Classroom Learning	In the classroom, AI negotiation bots can give students valuable opportunities to role-play negotiations and develop their personal negotiating style, a team of instructors at MIT has found. Here’s how to follow their lead.\nThe post How AI Negotiation Bots Ca…	Increasingly, workers, job seekers, and students are turning to artificial intelligence (AI) tools such as ChatGPT for negotiation advice. AI negotiation tools can offer guidance on how to navigate s… [+6059 chars]	https://www.pon.harvard.edu/daily/negotiation-skills-daily/how-ai-negotiation-bots-can-deepen-classroom-learning/	https://www.pon.harvard.edu/wp-content/uploads/images/posts/Classroom.jpg	2025-04-21 09:00:41
85	0.1	9	NewsAPI	Insights in implementing production-ready solutions with generative AI	As generative AI revolutionizes industries, organizations are eager to harness its potential. However, the journey from production-ready solutions to full-scale implementation can present distinct operational and technical considerations. This post explores k…	As generative AI revolutionizes industries, organizations are eager to harness its potential. However, the journey from production-ready solutions to full-scale implementation can present distinct op… [+17696 chars]	https://aws.amazon.com/blogs/machine-learning/insights-in-implementing-production-ready-solutions-with-generative-ai/	https://d2908q01vomqb2.cloudfront.net/f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59/2025/04/30/insights-in-implementing-1120x630.jpg	2025-04-30 18:34:40
86	0.1	9	NewsAPI	The top quantum computing jobs in 2025	Quantum research is a growing field with several available career paths for tech professionals, including quantum software engineer and quantum application specialist.	Amid all the conversations about AI and machine learning, quantum computing has quietly asserted itself as a new sector to watch. The processing power of quantum computing enables the calculation of … [+13236 chars]	https://www.techtarget.com/searchcio/feature/The-top-quantum-computing-jobs	https://www.techtarget.com/rms/onlineimages/code_g684641103.jpg	2025-04-24 09:33:00
88	0.1	9	NewsAPI	This AI-designed drug for IBD was just given to human subjects for the first time	Absci entered its new drug into Phase I trials in half the time and for many millions of dollars less than it would have cost without AI.	"We're excited to become a clinical-stage biotech company; it's exciting from an AI drug discovery standpoint," says Absci founder and CEO Sean McClain.\r\nAbsci\r\nArtificial intelligence has been worki… [+8784 chars]	https://www.zdnet.com/article/this-ai-designed-drug-for-ibd-was-just-given-to-human-subjects-for-the-first-time/	https://www.zdnet.com/a/img/resize/f4bdc4720e42d9d419119c6d7162c871a8e837d2/2025/05/13/f14c8bb7-bf23-4f0e-ae91-34af5d2f0baa/gettyimages-1374389013.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-13 21:54:06
89	0.1	9	NewsAPI	Detect hallucinations for RAG-based systems	This post walks you through how to create a basic hallucination detection system for RAG-based applications. We also weigh the pros and cons of different methods in terms of accuracy, precision, recall, and cost.	With the rise of generative AI and knowledge extraction in AI systems, Retrieval Augmented Generation (RAG) has become a prominent tool for enhancing the accuracy and reliability of AI-generated resp… [+22543 chars]	https://aws.amazon.com/blogs/machine-learning/detect-hallucinations-for-rag-based-systems/	https://d2908q01vomqb2.cloudfront.net/f1f836cb4ea6efb2a0b1b99f41ad8b103eff4b59/2025/05/06/hallucination_image-1260x375.jpg	2025-05-16 16:44:40
90	0.1	9	NewsDATA	Revolutionizing Industries: Jack Hidary’s SandboxAQ Pioneers AI-Quantum Breakthroughs with Large Quantitative Models	Jack Hidary, CEO of SandboxAQ, is driving innovation at the convergence of AI and quantum computing. His company is developing "Large Quantitative Models" to replace traditional LLMs for scientific applications in pharmaceuticals, materials science, and cybersecurity. These models process mathematical and scientific data, addressing real-world challenges that impact 80% of global GDP.	ONLY AVAILABLE IN PAID PLANS	https://www.webpronews.com/revolutionizing-industries-jack-hidarys-sandboxaq-pioneers-ai-quantum-breakthroughs-with-large-quantitative-models/	https://i0.wp.com/www.webpronews.com/wp-content/uploads/2025/05/Jack-Hidary-CEO-of-SandboxAQ-at-RSAC.png?fit=2084%2C1490&ssl=1	2025-05-17 18:53:43
91	0.1	9	NewsDATA	AI THROUGH MY FATHER’S EYES	“When I behold the heavens, the work of Your fingers, the moon and the stars that You have set in ... The post AI THROUGH MY FATHER’S EYES appeared first on The Voice St. Lucia News.	ONLY AVAILABLE IN PAID PLANS	https://thevoiceslu.com/2025/05/ai-through-my-fathers-eyes/	https://thevoiceslu.com/wp-content/uploads/2024/01/Cletus-I-Springer.jpg	2025-05-17 13:29:21
92	0.1	9	NewsDATA	Has AI exceeded human levels of intelligence? The answer is more complicated than you might think	The fear of AI becoming more powerful is on everyone's minds, so let's jump into it	ONLY AVAILABLE IN PAID PLANS	https://www.tomsguide.com/ai/has-ai-exceeded-human-levels-of-intelligence-the-answer-is-more-complicated-than-you-might-think	https://cdn.mos.cms.futurecdn.net/GpSixbtQMWiY599T8JmzWf.jpg	2025-05-17 13:15:00
93	0.1	9	NewsDATA	Qualcomm Unveils Abu Dhabi Hub for AI and IoT Innovation	Arabian Post -Qualcomm Technologies has revealed plans to establish a global engineering centre in Abu Dhabi, marking a significant expansion of its research and development footprint. The new facility will concentrate on cutting-edge technologies such as artificial intelligence, the industrial internet of things, and advanced data centre solutions, positioning Abu Dhabi as a pivotal node within Qualcomm’s worldwide network of engineering operations. This engineering centre is set to bolster [...]via Qualcomm Unveils Abu Dhabi Hub for AI and IoT Innovation	ONLY AVAILABLE IN PAID PLANS	https://thearabianpost.com/qualcomm-unveils-abu-dhabi-hub-for-ai-and-iot-innovation/	https://techafricanews.com/wp-content/uploads/2025/05/Qualcomm-PR.jpg	2025-05-17 06:22:46
94	0	9	NewsAPI	Meet the 10 AI startup unicorns with tiny teams	These AI startups are hitting billion-dollar valuations with 50 employees or fewer as founders use new tech to maintain lean teams.	Ilya Sutskever, cofounder and chief scientist at Safe Superintelligence and cofounder and former chief scientist at OpenAI.JACK GUEZ/AFP via Getty Images\r\n<ul><li>Artificial intelligence is helping s… [+8162 chars]	https://www.businessinsider.com/ai-startup-unicorns-with-tiny-teams-2025-5	https://i.insider.com/6819319ac6ad288d1480140c?width=1200&format=jpeg	2025-05-07 09:00:02
95	0	9	NewsAPI	Google DeepMind CEO Demis Hassabis on AI in the Military and What AGI Could Mean for Humanity	TIME spoke with Google DeepMind CEO Demis Hassabis, who was on the 2025 TIME100 list.	The last time I interviewed Demis Hassabis was back in November 2022, just a few weeks before the release of ChatGPT. Even thenbefore the rest of the world went AI-crazythe CEO of Google DeepMind had… [+22089 chars]	https://time.com/7280740/demis-hassabis-interview/	https://api.time.com/wp-content/uploads/2025/04/time100-2025-demis-hassabis.jpg?quality=85&crop=0px%2C26px%2C2400px%2C1256px&resize=1200%2C628&strip	2025-04-27 11:00:00
96	0.089	10	NewsAPI	Our Healthcare Infrastructure Deserves Better Cybersecurity	Adopting PQC now isn’t just about responding to future threats—it's an opportunity to make a strategic, long-term investment in the security of your patient’s data.	Ali El Kaafarani is founder and CEO of PQShield, a British cybersecurity startup specializing in quantum-secure solutions.\r\ngetty\r\nWe trust the healthcare system with vast amounts of sensitive data a… [+6495 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/05/01/our-healthcare-infrastructure-deserves-better-cybersecurity/	https://imageio.forbes.com/specials-images/imageserve/643983780a9290602c6b19d2/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 10:15:00
97	0.089	10	NewsAPI	9 Ways to Tick Off Your Patients	Personal Perspective: Healthcare is a service industry. If we forget this, and focus only on the medical problem at hand, we risk patient disaffection and dissatisfaction.	We live in miraculous times. We have treatmentsoften very effective treatmentsfor so many of the ailments that have plagued humankind for millennia. In fact, our interventions are so effective, that … [+6363 chars]	https://www.psychologytoday.com/us/blog/rich-encounters/202505/9-ways-to-tick-off-your-patients	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-05/Screenshot%202025-05-02%20at%202.53.29%E2%80%AFPM.png.jpg?itok=3KDMrk2-	2025-05-02 20:07:29
98	0.089	10	NewsAPI	Natera, Inc. (NTRA): A Bull Case Theory	We came across a bullish thesis on Natera, Inc. (NTRA) on Substack by FJ Research. In this article, we will summarize the bulls’ thesis on NTRA. Natera, Inc....	We came across a bullish thesis on Natera, Inc. (NTRA) on Substack by FJ Research. In this article, we will summarize the bulls thesis on NTRA. Natera, Inc. (NTRA)'s share was trading at $162.57 as o… [+3695 chars]	https://finance.yahoo.com/news/natera-inc-ntra-bull-case-140848434.html	https://media.zenfs.com/en/insidermonkey.com/f3bba2008ed3ad223f6d8413f886c8f0	2025-05-13 14:08:48
99	0.089	10	NewsAPI	The Cost of Ignoring the Root Cause of Chronic Disease. J. Mercola	The U.S. channels 90% of its $4.5 trillion annual healthcare costs toward chronic diseases, yet most of it funds profitable drugs and procedures that do not address the root cause of illness\nPrescription drugs trap patients in an endless cycle …\nThe post The …	The U.S. channels 90% of its $4.5 trillion annual healthcare costs toward chronic diseases, yet most of it funds profitable drugs and procedures that do not address the root cause of illnessPrescript… [+22129 chars]	https://www.globalresearch.ca/cost-ignoring-root-cause-chronic-disease/5885090	https://www.globalresearch.ca/wp-content/uploads/2022/06/big-pharma-medical-journal.jpg	2025-04-24 11:47:54
100	0.089	10	NewsAPI	Akido lands $60M to grow AI platform for underserved healthcare settings	Artificial intelligence and care delivery company Akido Labs Inc. announced today that it has raised $60 million in new funding to expand the reach of ScopeAI, a system aimed at increasing clinical capacity and improving healthcare access. Founded in 2015, Ak…	Artificial intelligence and care delivery company Akido Labs Inc. announced today that it has raised $60 million in new funding to expand the reach of ScopeAI, a system aimed at increasing clinical c… [+3074 chars]	https://siliconangle.com/2025/05/15/akido-lands-60m-grow-ai-platform-underserved-healthcare-settings/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2025/05/akido.png	2025-05-15 23:12:01
101	0.089	10	NewsDATA	Delays, cancellations, long queues: Doctor scarcity hits Nigeria’s private hospitals	Patients seeking medical care at private hospitals in Nigeria are now facing the kind of long delays once associated only with public health facilities. The post Delays, cancellations, long queues: Doctor scarcity hits Nigeria’s private hospitals appeared first on Nairametrics.	ONLY AVAILABLE IN PAID PLANS	https://nairametrics.com/2025/05/18/delays-cancellations-long-queues-doctor-scarcity-hits-nigerias-private-hospitals/	https://nairametrics.com/wp-content/uploads/2023/11/Doctors-750x375.png	2025-05-18 06:36:38
102	0.089	10	NewsDATA	Budget boost for South Island healthcare	Health Minister Simeon Brown (left) and Prime Minister Christopher Luxon made the announcement in Auckland. Image: RNZ South Island communities will have better access to urgent and after-hours healthcare as part of a nationwide investment, the Health Minister says.	ONLY AVAILABLE IN PAID PLANS	https://www.odt.co.nz/star-news/star-national/budget-boost-south-island-healthcare	https://www.odt.co.nz/sites/default/files/story/2025/05/brown_and_luxon_health_announcement_rnz.png	2025-05-18 02:00:11
103	0.089	10	NewsDATA	Boost for urgent, after-hours health services in South	Health Minister Simeon Brown (left) and Prime Minister Christopher Luxon made the announcement in Auckland. Image: RNZ Communities in Dunedin and Invercargill will have better access to urgent and after-hours healthcare as part of a nationwide investment, the Health Minister says.	ONLY AVAILABLE IN PAID PLANS	https://www.odt.co.nz/news/dunedin/health/boost-urgent-after-hours-health-services-south	https://www.odt.co.nz/sites/default/files/story/2025/05/brown_and_luxon_health_announcement_rnz.png	2025-05-18 01:32:45
104	0.089	10	NewsDATA	Government boosting urgent and after-hours healthcare	Kiwis needing urgent health care will benefit from a big funding boost for urgent and after-hours healthcare services across New Zealand, Health Minister and Pakuranga MP Simeon Brown says. Brown and Prime Minister and Botany MP Christopher Luxon made the announcement at East Care Accident and Medical in Botany this afternoon, May 18. “Strengthening urgent [...]The post Government boosting urgent and after-hours healthcare appeared first on Times.	ONLY AVAILABLE IN PAID PLANS	https://www.times.co.nz/news/government-boosting-urgent-and-after-hours-healthcare/	https://www.times.co.nz/wp-content/uploads/2025/05/Chris-Luxon-Simeon-Browm-@-Eastcare-scaled-e1747528618420.jpg	2025-05-18 01:30:03
105	0	10	NewsAPI	Top Three Ways Clinicians Are Using AI To Maximize ROI	If you were to ask a doctor, nurse practitioner, or therapist why they first entered medicine, the most common answer would be to heal and care for others.	Red arrow over stack of money coins arranged as a graph on wood table with blurry the doctor ... More stethoscope around neck a scene in the back, concept of financial health and medical expenses\r\nge… [+5764 chars]	https://www.forbes.com/sites/jaimecatmull/2025/05/05/top-three-ways-clinicians-are-using-ai-to-maximize-roi/	https://imageio.forbes.com/specials-images/imageserve/6818e08aeefb0aaab6f1e001/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 16:20:49
106	0	10	NewsAPI	Hospitalized patients who receive alcohol use disorder treatment can substantially reduce heavy drinking	A new study found that the oral and extended-release injectable forms of naltrexone are equally effective in helping patients consume less alcohol, suggesting that clinicians should integrate this medication into routine hospital care.	Nearly 30 million adults in the United States experience alcohol use disorder (AUD), but the vast majority of people with this condition do not receive treatment. A new study led by Boston University… [+5294 chars]	https://www.sciencedaily.com/releases/2025/04/250421162945.htm	https://www.sciencedaily.com/images/scidaily-icon.png	2025-04-21 20:29:45
107	0	10	NewsAPI	This Doctor Developed Software To Cut Clinical Trial Times	On average, it takes more than three months just to set up and complete the data process for a trial. This doctor developed software that cuts that time down to 3 days.	Dr. Nikola Cihoric, Founder, Wemedoo, oomnia, oopus\r\nWemedoo/oomnia\r\nEvery year, thousands of life-saving clinical trials are delayed or derailednot because of a lack of innovation, but because of ou… [+6017 chars]	https://www.forbes.com/sites/amyguttman/2025/04/18/this-doctor-developed-software-to-cut-clinical-trial-times/	https://imageio.forbes.com/specials-images/imageserve/6802b82753f227f03db495a0/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-18 20:50:42
108	0	10	NewsAPI	7 In 10 Americans Say Financial Stress At All-Time High...	7 In 10 Americans Say Financial Stress At All-Time High...\r\n\n \n \n \n (First column, 3rd story, link)\r\n\n \r\n\n \r\n\n \n Related stories:Empty shelves, for-lease signs and layoffs point to recession by summer...\r\nPresident pressures Speaker to raise taxes...\r\n\n \r\n\n \n…	(Photo by Damir Khabirov on Shutterstock)\r\n<ul><li>7 in 10 Americans report all-time high financial anxiety, with 40% taking mental health days off work or school to cope</li><li>Only 14% currently r… [+5975 chars]	https://studyfinds.org/money-worries-crushing-mental-health-americans-report-peak-financial-stress/	https://studyfinds.org/wp-content/uploads/2025/05/Woman-paying-bills-scaled.jpg	2025-05-09 12:07:37
149	0	12	NewsAPI	A do-it-yourself wand could help replace your next Pap smear (yes, really!)	The at-home Pap smear is just as accurate as a doctor's office test for cervical cancer.	Teal Health CEO Kara Egan with the company's DIY cervical cancer screening wand.Hilary Brueck, Business Insider\r\n<ul><li>Nobody likes Pap smears.</li><li>A new DIY home swab kit for cervical cancer a… [+5009 chars]	https://www.businessinsider.com/at-home-pap-smear-wand-approved-fda-teal-health-2025-5	https://i.insider.com/681dfd083fe8d39283656558?width=1200&format=jpeg	2025-05-09 14:50:00
109	0	10	NewsAPI	Ultimate PPC Campaign Optimization: 6 New Ways To Easily Run Dozens Of PPC Campaigns For Different Sectors via @sejournal, @CallRail	Discover 6 new ways to scale and optimize PPC campaigns across multiple sectors using AI tools, automation, and client-specific strategies, without sacrificing performance.\nThe post Ultimate PPC Campaign Optimization: 6 New Ways To Easily Run Dozens Of PPC Ca…	Tip #1. Boost Relevance: Use Industry-Specific Conversion Signals To Customize Google Ads Messaging\r\nIncreasing clicks is as easy as increasing how relevant your ads are to your potential customers.\r… [+13255 chars]	https://www.searchenginejournal.com/new-ppc-campaign-optimization-callrail-spcs/545769/	https://www.searchenginejournal.com/wp-content/uploads/2025/05/featured-819.png	2025-05-08 13:40:46
110	0	10	NewsAPI	Smartinhaler ensures effective asthma treatment when it’s needed	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017; now its makers want it to be available to Aussie asthmatics…	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017;… [+4094 chars]	https://newatlas.com/medical-devices/adherium-hailie-smartinhaler-asthma-control/	https://assets.newatlas.com/dims4/default/bdaa95b/2147483647/strip/true/crop/2000x1050+0+38/resize/1200x630!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fee%2F9a%2Faa2690dc4db0a8472e60ef499a0f%2Fbanner-our-technology-2023.jpg&na.image_optimisation=0	2025-05-15 04:22:40
111	0	10	NewsAPI	Americans’ Trust In The Healthcare System Is Plummeting. How Can It Be Repaired?	Trust in the U.S. healthcare system is eroding, but experts say rebuilding it is possible. They say this will require both payers and providers to prioritize empathy, transparency, and personalized communication.\nThe post Americans’ Trust In The Healthcare Sy…	Americans’ trust in the overall healthcare system is dwindling — but experts believe it can be rebuilt.\r\nPublic trust in the U.S. healthcare system fell from 71.5% in 2020 to 40.1% in 2024, according… [+9665 chars]	https://medcitynews.com/2025/05/healthcare-trust/	https://medcitynews.com/wp-content/uploads/sites/7/2024/12/GettyImages-2096576682.jpg	2025-05-09 21:47:00
112	0	10	NewsAPI	Poor mental health a 'common phenomenon' in healthcare staff	Doctors In Distress was set up in 2019 by the brother of a consultant cardiologist who took his own life.	Mr Sidhu said healthcare staff have been overworked for years\r\nA charity set up to help doctors and healthcare professionals with their mental health in Great Britain has extended its services to Nor… [+2073 chars]	https://www.bbc.com/news/articles/cp31ren747no	https://ichef.bbci.co.uk/news/1024/branded_news/aa82/live/c06120e0-258e-11f0-8c93-17b95c5aba9f.jpg	2025-04-30 07:14:29
113	0	10	NewsAPI	Beyond The Sale: How Insurance Leaders Can Win With Value-Based Care	A client should feel like their agent is a trusted guide, not just a salesperson.	Drew Gurley, Founder of Redbird Advisors and EVP of Growth for Senior Market Advisors, a Medicare FMO.\r\ngetty\r\nIf you're leading an insurance agency, you already know healthcare is shifting, and that… [+5999 chars]	https://www.forbes.com/councils/forbesfinancecouncil/2025/05/07/beyond-the-sale-how-insurance-leaders-can-win-with-value-based-care/	https://imageio.forbes.com/specials-images/imageserve/681a8703a4d6a9786a0431ba/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-07 11:45:00
114	0	10	NewsAPI	Dramatic surge in pharmaceutical drug use reveals a nation SUFFERING in a HEALTH CRISIS, mental and physical	Imagine walking into a doctor’s office today feeling healthy only to leave with a prescription in hand. This is the paradox of American healthcare—a system that spends more per capita yet fails to deliver better outcomes. According to a recent KFF survey, 61%…	Imagine walking into a doctors office today feeling healthy only to leave with a prescription in hand. This is the paradox of American healthcarea system that spends more per capita yet fails to deli… [+6094 chars]	https://www.naturalnews.com/2025-04-22-big-pharma-drug-use-consumes-61-percent-of-americans.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/04/Pharmacy-Background-Drugstore-Drug-Counter-Over-Medicine.jpg	2025-04-22 06:00:00
115	0	10	NewsAPI	The Silent Mental Health Crisis: How Technology Can Bridge The Gap	Technology can revolutionize how we approach mental health care for children and young people.	Founder-CEO, Koa Health. Neuroscientist, psychiatrist, and former McKinsey. 20 years' experience delivering scalable health tech solutions.\r\ngetty\r\nMental disorders are the chronic diseases of the yo… [+6632 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/05/08/the-silent-mental-health-crisis-how-technology-can-bridge-the-gap/	https://imageio.forbes.com/specials-images/imageserve/681b78ffc64205a45c8b02b6/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 11:30:00
116	0.274	11	NewsAPI	AI doctors’ assistant to speed up appointments a ‘gamechanger’	Interim trial data shows that the revolutionary tech has dramatically reduced admin	<ul><li>Government drives forward use of innovative artificial intelligence in hospitals to improve patient care</li><li>New government guidance set out today will encourage its use across health ser… [+6019 chars]	https://www.gov.uk/government/news/ai-doctors-assistant-to-speed-up-appointments-a-gamechanger	https://assets.publishing.service.gov.uk/media/627508178fa8f520738d5474/s960_DHSC_plaque.jpg	2025-04-26 23:01:00
117	0.274	11	NewsAPI	Gamechanging AI doctors’ assistant to speed up appointments	Government drives forward use of innovative artificial intelligence in hospitals as trials show dramatic reduction in admin with more time for patient care.	<ul><li>Government drives forward use of innovative artificial intelligence in hospitals to improve patient care</li><li>New government guidance set out today will encourage its use across health ser… [+6493 chars]	https://www.gov.uk/government/news/gamechanging-ai-doctors-assistant-to-speed-up-appointments	https://assets.publishing.service.gov.uk/media/627508178fa8f520738d5474/s960_DHSC_plaque.jpg	2025-04-27 09:00:06
118	0.185	11	NewsAPI	Newsweek's Next Virtual Event Aims to Build Health Care's AI Playbook	Health Care's AI Playbook: Building Safe, Smart and Scalable Systems virtual event begins Tuesday, May 20 at 2:15 pm EST.	Artificial intelligence (AI) has been integrated into almost every industry. In health care, AI has been used for detection and analysis and to help with physician burnout, but it is also susceptible… [+5802 chars]	https://www.newsweek.com/newsweek-virtual-event-build-health-care-ai-playbook-access-health-2073297	https://d.newsweek.com/en/full/2644660/updated-ai-webinar-promo-landscape.png	2025-05-16 17:45:59
201	0	15	NewsAPI	Educators Resist Trump’s Fascist Agenda	Trump’s attacks on public education are prompting people from all walks of life to fight back.	More than 49 million young people attend public schools in the United States, and they have all been thrust into the center of President Donald Trumps regressive agenda as he moves to use education f… [+8824 chars]	https://www.yesmagazine.org/political-power/2025/05/05/educators-resist-fascist-agenda	https://www.yesmagazine.org/wp-content/uploads/2025/04/Educators_1400x840.jpg	2025-05-05 21:03:23
119	0.089	11	NewsAPI	Treatment.com AI and Rocket Doctor Applaud US Health Secretary RFK Jr.’s Call for Greater Investment in Telehealth and AI-Driven Diagnostic Tools	‏VANCOUVER, BC, May 15, 2025 (GLOBE NEWSWIRE) -- Treatment.com AI Inc. (CSE: TRUE, OTC: TREIF, Frankfurt: 939) (“Treatment”) and Rocket Doctor, its wholly owned online care platform, applaud United States Secretary of Health and Human Services, Robert F. Kenn…	<ul><li>RFK Jr. calls for a revolution in telehealth and AI to reduce ER visits and improve at-home care.</li><li>Treatment.com AI and Rocket Doctor applaud the remarks, citing strong alignment with … [+7367 chars]	https://www.globenewswire.com/news-release/2025/05/15/3082244/0/en/Treatment-com-AI-and-Rocket-Doctor-Applaud-US-Health-Secretary-RFK-Jr-s-Call-for-Greater-Investment-in-Telehealth-and-AI-Driven-Diagnostic-Tools.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-15 13:02:00
120	0	11	NewsAPI	Blue Shield exposed 4.7M patients’ health data to Google	Health insurance giant Blue Shield of California confirmed it had been sharing private health data of 4.7 million users with Google for three years without even realizing it.	Healthcare institutions and insurers arguably collect the most sensitive information about you, including IDs, contact details, addresses and medical records. But they often dont put in the same leve… [+8943 chars]	https://www.foxnews.com/tech/blue-shield-exposed-4-7m-patients-health-data-google-2	https://static.foxnews.com/foxnews.com/content/uploads/2025/04/3-blue-shield-of-california-leaks-4.7-million-members-protected-health-data-outro.jpg	2025-04-27 14:00:20
121	0	11	NewsAPI	Suki AI Is Healthcare’s New Infrastructure	Exclusive: Ambient Notes Rollout And Zoom’s Partnership, Suki Is Proving Ambient AI Isn't Optional – It’s Essential Infrastructure For Healthcare.	Doctor in a comfortable office using AI on laptop with infographics displayed\r\ngetty\r\nA Turning Point for Ambient AI\r\nVenture capital is making an aggressive bet on ambient AI. Its not just validatio… [+11503 chars]	https://www.forbes.com/sites/sindhyavalloppillil/2025/05/01/suki-ai-is-healthcares-new-infrastructure/	https://imageio.forbes.com/specials-images/imageserve/68122a7c724ef31932830cb5/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 13:00:00
122	0	11	NewsAPI	From Sick Care To Self-Care: Rebuilding A System That Keeps Us Well	We all have the responsibility in creating and being part of a healthier nation and healthier world, and that starts with a system grounded in cooperation, where all parties win by helping people stay healthy, supported, and informed.	Susan Dorfman is Susan Dorfman the President and CEO of CMI Media Group.\r\ngetty\r\nOur healthcare system is fundamentally designed to treat illness, not promote wellness. We visit doctors when were sic… [+5906 chars]	https://www.forbes.com/councils/forbesagencycouncil/2025/04/30/from-sick-care-to-self-care-rebuilding-a-system-that-keeps-us-well/	https://imageio.forbes.com/specials-images/imageserve/5f77257d59c6540aa1a01cc8/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-30 13:00:00
123	0	11	NewsAPI	Smartinhaler ensures effective asthma treatment when it’s needed	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017; now its makers want it to be available to Aussie asthmatics…	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017;… [+4094 chars]	https://newatlas.com/medical-devices/adherium-hailie-smartinhaler-asthma-control/	https://assets.newatlas.com/dims4/default/bdaa95b/2147483647/strip/true/crop/2000x1050+0+38/resize/1200x630!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fee%2F9a%2Faa2690dc4db0a8472e60ef499a0f%2Fbanner-our-technology-2023.jpg&na.image_optimisation=0	2025-05-15 04:22:40
124	0	11	NewsAPI	‘Smoldering’ cardiovascular crisis	Downward trend in deaths appears stalled due to lack of urgency among doctors, patients, along with healthcare barriers.	Starting in the late 1960s, cardiovascular disease deaths fell and fell. Mortality decreased by 70 percent from 206 deaths per 100,000 in 1968 to 62 deaths in 2017. The share of all premature deaths … [+10790 chars]	https://news.harvard.edu/gazette/story/2025/05/smoldering-cardiovascular-crisis/	https://news.harvard.edu/wp-content/uploads/2025/05/findings-heart-disease-header-1920.jpg	2025-05-15 16:24:58
125	0	11	NewsAPI	Regeneron Prevails over Amgen in Antitrust PCSK9 Lawsuit Protecting Biotech Innovation and Patient Access to Life-Saving Treatments	Federal court jury found Amgen liable for violating antitrust and tort laws by using cross-therapeutic bundled rebates to prevent Praluent® (alirocumab) from competing in the market	Federal court jury found Amgen liable for violating antitrust and tort laws by using cross-therapeutic bundled rebates to prevent Praluent® (alirocumab) from competing in the market\r\nJury awarded Reg… [+15014 chars]	https://www.globenewswire.com/news-release/2025/05/15/3082564/0/en/Regeneron-Prevails-over-Amgen-in-Antitrust-PCSK9-Lawsuit-Protecting-Biotech-Innovation-and-Patient-Access-to-Life-Saving-Treatments.html	https://ml.globenewswire.com/Resource/Download/add5ebc7-88c9-49dc-8834-abbb07c622d1	2025-05-15 18:02:00
126	0	11	NewsAPI	Hydreight Achieves Record Revenue and Profitability Milestone in Q4 2024 Audited Results	VANCOUVER, British Columbia and LAS VEGAS, May 01, 2025 (GLOBE NEWSWIRE) -- Hydreight Technologies Inc.\r\n (“Hydreight” or the “Company”) (TSXV: NURS\r\n)(OTCQB: HYDTF\r\n)(FSE: SO6\r\n),a fast-growing mobile clinical network and medical platform offering flexible, …	<ul><li>Record 2024 Topline¹ revenue of $22.32 million, up 31% from 2023</li><li>Record 2024 GAAP revenue of $16.04 million, up 39% from 2023</li><li>2024 Adjusted EBITDA¹ of +490K compared to ($1.38… [+25537 chars]	https://www.globenewswire.com/news-release/2025/05/01/3072045/0/en/Hydreight-Achieves-Record-Revenue-and-Profitability-Milestone-in-Q4-2024-Audited-Results.html	https://ml.globenewswire.com/Resource/Download/ffe3c28c-c55b-4eee-b505-0893b310c573	2025-05-01 04:16:00
127	0	11	NewsAPI	The Professional Service Robots Market: Focused Insights 2025-2030 Featuring Strategic Analysis of Key Players - ABB, Exail, SoftBank Robotics Group, Honda Motor, FANUC and More	Dublin, May 06, 2025 (GLOBE NEWSWIRE) -- The "Professional Service Robots Market - Focused Insights 2025-2030" report has been added to ResearchAndMarkets.com's offering.The Professional Service Robots Market was valued at USD 34.58 billion in 2024, and is pr…	Dublin, May 06, 2025 (GLOBE NEWSWIRE) -- The "Professional Service Robots Market - Focused Insights 2025-2030" report has been added to ResearchAndMarkets.com's offering.\r\nThe Professional Service Ro… [+12969 chars]	https://www.globenewswire.com/news-release/2025/05/06/3074749/28124/en/The-Professional-Service-Robots-Market-Focused-Insights-2025-2030-Featuring-Strategic-Analysis-of-Key-Players-ABB-Exail-SoftBank-Robotics-Group-Honda-Motor-FANUC-and-More.html	https://ml.globenewswire.com/Resource/Download/908fb457-7f8e-4a08-9081-5565e3dfb3d7	2025-05-06 08:10:00
128	0	11	NewsAPI	Dupixent® (dupilumab) Approved in the U.S. as the First New Targeted Therapy in Over a Decade for Chronic Spontaneous Urticaria (CSU)	Approval based on Phase 3 trials demonstrating Dupixent significantly reduced itch and hives compared to placebo    In the U.S., there are more than......	Approval based on Phase 3 trials demonstrating Dupixent significantly reduced itch and hives compared to placebo\r\nIn the U.S., there are more than 300,000 adults and adolescents aged 12 years and old… [+29558 chars]	https://www.globenewswire.com/news-release/2025/04/18/3064133/0/en/Dupixent-dupilumab-Approved-in-the-U-S-as-the-First-New-Targeted-Therapy-in-Over-a-Decade-for-Chronic-Spontaneous-Urticaria-CSU.html	https://ml.globenewswire.com/Resource/Download/add5ebc7-88c9-49dc-8834-abbb07c622d1	2025-04-18 15:15:00
129	0	11	NewsAPI	What is emergent medical data?	Emergent medical data (EMD) is health information gathered about an individual from seemingly unrelated online user behavior data.	Emergent medical data (EMD) is health information gathered about an individual from seemingly unrelated online user behavior data. The term was coined in 2017 by Mason Marks, a professor at Florida S… [+11124 chars]	https://www.techtarget.com/whatis/definition/emergent-medical-data-EMD	https://www.techtarget.com/ITKE/images/logos/TTlogo-379x201.png	2025-05-05 10:51:00
130	0	11	NewsAPI	7 subtle cancer warning signs your doctor might miss	Learn how to recognize these easily overlooked indicators that could save your life Why subtle cancer symptoms go undetected Despite advances in medical technology and screening protocols, certain cancer warning signs continue to be overlooked during standard…	Learn how to recognize these easily overlooked indicators that could save your life\r\nWhy subtle cancer symptoms go undetected\r\nDespite advances in medical technology and screening protocols, certain … [+18800 chars]	https://rollingout.com/2025/04/21/cancer-warning-signs-doctor-might-miss/	https://rollingout.com/wp-content/uploads/2024/12/shutterstock_1450907009.jpg	2025-04-21 19:12:32
131	0	11	NewsAPI	Patient satisfaction with general practice in Scotland 2011/12 to 2021/22	Background The Scottish Government introduced the first phase of a new General Practice (GP) contract in 2018, aiming to transform primary care and address health inequalities. However, the impact of these changes on patient satisfaction is unclear.   Aim To …	Abstract\r\nBackground\r\nThe Scottish Government introduced the first phase of a new General Practice (GP) contract in 2018, aiming to transform primary care and address health inequalities. However, th… [+38651 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322095	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322095.g004&size=inline	2025-04-30 14:00:00
132	0	11	NewsAPI	(In)coherence between Chagas disease policy and the experiences of those affected in Mexico: The need for a transdisciplinary approach	Chagas disease, caused by the parasite Trypanosoma cruzi, remains a significant public health challenge in México, symbolizing systemic neglect in healthcare. Despite longstanding efforts to control its transmission, there are critical gaps in the alignment o…	Abstract\r\nChagas disease, caused by the parasite Trypanosoma cruzi, remains a significant public health challenge in México, symbolizing systemic neglect in healthcare. Despite longstanding efforts t… [+51115 chars]	https://journals.plos.org/plosntds/article?id=10.1371/journal.pntd.0013052	https://journals.plos.org/plosntds/article/figure/image?id=10.1371/journal.pntd.0013052.g002&size=inline	2025-05-07 14:00:00
133	0	11	NewsAPI	The Phoenix for Men Under Review: Best ED Device Using Shockwave Therapy for At-Home Results	A Comprehensive 2025 Review of The Phoenix: FDA-Registered At-Home Acoustic Wave Therapy Device to Support Natural Erectile Function and Enhance Male Performance A Comprehensive 2025 Review of The Phoenix: FDA-Registered At-Home Acoustic Wave Therapy Device t…	Phoenix, May 03, 2025 (GLOBE NEWSWIRE) -- \r\nIn This Article, Youll Discover:\r\n<ul><li>Why more men are turning to at-home ED treatment solutions over traditional medications and surgeries</li><li>The… [+48194 chars]	https://www.globenewswire.com/news-release/2025/05/03/3073691/0/en/The-Phoenix-for-Men-Under-Review-Best-ED-Device-Using-Shockwave-Therapy-for-At-Home-Results.html	https://ml.globenewswire.com/Resource/Download/09c5a596-8984-4005-8b27-a2d8a86b722a	2025-05-03 18:53:00
134	0	11	NewsAPI	The Importance of Regular Skin Checks for Cancer Prevention	Do you want to stop skin cancer before it turns harmful? People often ignore regular skin examinations even though they are essential components of healthy living habits. Regular skin checks establish the essential basis for maintaining healthy skin while det…	Do you want to stop skin cancer before it turns harmful?\r\nPeople often ignore regular skin examinations even though they are essential components of healthy living habits. Regular skin checks establi… [+8872 chars]	https://curiousmindmagazine.com/the-importance-of-regular-skin-checks-for-cancer-prevention/	https://curiousmindmagazine.com/wp-content/uploads/2025/04/skin.jpg	2025-04-21 22:17:54
135	0	11	NewsAPI	Quick Extender Pro Under Review: Best Stretching Extender for Men on the Market	A Comprehensive Review of Quick Extender Pro’s Patented Traction System: Clinically-Inspired Male Enhancement, Curvature Correction, and Confidence Restoration Backed by Real Results A Comprehensive Review of Quick Extender Pro’s Patented Traction System: Cli…	New York, April 28, 2025 (GLOBE NEWSWIRE) -- \r\nIn This Article, Youll Discover:\r\n<ul><li>Why male enhancement concerns go beyond physical appearance and deeply impact emotional well-being</li><li>How… [+62895 chars]	https://www.globenewswire.com/news-release/2025/04/28/3069775/0/en/Quick-Extender-Pro-Under-Review-Best-Stretching-Extender-for-Men-on-the-Market.html	https://ml.globenewswire.com/Resource/Download/9887a80d-7dce-4534-ab76-820f79b448c5	2025-04-28 23:38:00
136	0.1	12	NewsAPI	Check out the exclusive 11-slide pitch deck startup Doctronic used to raise $5 million for its AI agents to replace 'Dr. Google'	Startup Doctronic wants patients to ask health-related questions to its AI agents instead of WebMD.	Doctronic cofounders Adam Oskowitz and Matt Pavelle.Doctronic\r\n<ul><li>Doctronic just raised $5 million from Union Square Ventures for its healthcare AI agents.</li><li>The startup's AI gives persona… [+3877 chars]	https://www.businessinsider.com/pitch-deck-doctronic-raise-5-million-seed-funding-ai-agents-2025-4	https://i.insider.com/68013aa93fe8d39283636081?width=1200&format=jpeg	2025-04-18 09:01:01
137	0.1	12	NewsAPI	'It's really hard to have any hope': Gaza doctor describes daily struggle	The BBC joins a GP in Gaza as she sees dozens of patients, struggling to treat them with a dwindling supply of drugs.	Yolande KnellBBC Middle East Correspondent\r\nDr Sukkar says life in Gaza feels "like a nightmare that doesn't end"\r\nHealthcare in the Gaza Strip is itself a casualty of 18 months of war between Israel… [+5539 chars]	https://www.bbc.com/news/articles/ckgekpvj3rko	https://ichef.bbci.co.uk/news/1024/branded_news/be6e/live/74b08840-1c90-11f0-8548-37d1b95cef8a.jpg	2025-04-18 23:45:04
138	0.1	12	NewsAPI	Healthcare professional faints on the job and gets sent home by boss, only to be scolded for calling out sick the next day: ‘[This] is not an acceptable practice’	Being an essential worker is not for the weak, especially in healthcare settings. If you're not careful, you're always at risk of contracting the next virus, stomach bug, or infection that can put you out of commission for weeks. Even with all the proper prec…	Being an essential worker is not for the weak, especially in healthcare settings. If you're not careful, you're always at risk of contracting the next virus, stomach bug, or infection that can put yo… [+902 chars]	https://cheezburger.com/40272645/healthcare-professional-faints-on-the-job-and-gets-sent-home-by-boss-only-to-be-scolded-for-calling	https://i.chzbgr.com/thumb1200/40272645/hC7922789/workplace-workplace-stories-work-stories-job-doctor-patient-reddit-reddit-thread-reddit-story-aita	2025-04-26 02:00:00
139	0.1	12	NewsAPI	Blue Shield exposed 4.7M patients’ health data to Google	Health insurance giant Blue Shield of California confirmed it had been sharing private health data of 4.7 million users with Google for three years without even realizing it.	Healthcare institutions and insurers arguably collect the most sensitive information about you, including IDs, contact details, addresses and medical records. But they often dont put in the same leve… [+8943 chars]	https://www.foxnews.com/tech/blue-shield-exposed-4-7m-patients-health-data-google-2	https://static.foxnews.com/foxnews.com/content/uploads/2025/04/3-blue-shield-of-california-leaks-4.7-million-members-protected-health-data-outro.jpg	2025-04-27 14:00:20
140	0.1	12	NewsAPI	Money and masculinity: How wellness became big business and changed American health culture	In the first months of Donald Trump’s second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F. Kennedy Jr.Read more...	In the first months of Donald Trumps second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F.… [+10134 chars]	https://qz.com/rfk-wellness-business-health-culture-1851779931	https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/862a2698550a07275b939efe0ca1808c.jpg	2025-05-15 09:00:00
141	0.1	12	NewsAPI	Our Healthcare Infrastructure Deserves Better Cybersecurity	Adopting PQC now isn’t just about responding to future threats—it's an opportunity to make a strategic, long-term investment in the security of your patient’s data.	Ali El Kaafarani is founder and CEO of PQShield, a British cybersecurity startup specializing in quantum-secure solutions.\r\ngetty\r\nWe trust the healthcare system with vast amounts of sensitive data a… [+6495 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/05/01/our-healthcare-infrastructure-deserves-better-cybersecurity/	https://imageio.forbes.com/specials-images/imageserve/643983780a9290602c6b19d2/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 10:15:00
142	0.1	12	NewsDATA	Beth Frates: Transforming Health with Lifestyle Medicine	Discover how Dr. Beth Frates embodies lifestyle medicine and inspires global health transformation through education and practice.	ONLY AVAILABLE IN PAID PLANS	https://internetprotocol.co/life/2025/05/18/beth-frates-transforming-health-with-lifestyle-medicine/	https://internetprotocol.co/content/images/2025/05/2158906133.png	2025-05-18 10:27:42
143	0	12	NewsAPI	New surgeon general nominee cofounded “biowearables” startup with DOGE operative	Before she was chosen as Donald Trump's latest nominee for Surgeon General, Dr. Casey Means came from the world of healthcare startups - and cofounded one with a tech entrepreneur who's now a key DOGE operative in charge of dismantling the IRS. In 2019, Means…	Casey Means is a MAHA celebrity; her cofounder is now in charge of dismantling the IRS.\r\nCasey Means is a MAHA celebrity; her cofounder is now in charge of dismantling the IRS.\r\nBefore she was chosen… [+3235 chars]	https://www.theverge.com/politics/663114/surgeon-general-doge-casey-means-sam-corcos-startup-levels-doge	https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/23032246/20211026_132108.jpg?quality=90&strip=all&crop=10.8%2C15.63335292153%2C87%2C60.733294156939&w=1200	2025-05-08 13:35:05
144	0	12	NewsAPI	New Toxic Avenger Trailer Takes Gory Aim at Health Care	Peter Dinklage's Toxie sure has some bloody and violent thoughts to share about the insurance industry in the August release.	The upcoming Toxic Avenger reboot is months away, and each new glimpse of it has been either pretty goofy, gross, or both. Its newest promo falls into the third categorysilly and bloody as all hell, … [+1456 chars]	https://gizmodo.com/new-toxic-avenger-trailer-hits-at-health-care-in-latest-gory-trailer-2000591540	https://gizmodo.com/app/uploads/2025/03/Toxic-Avenger-2025-mop.jpg	2025-04-18 19:30:44
145	0	12	NewsAPI	How tech's biggest powerhouses from Amazon to Nvidia are betting on healthcare AI	Artificial intelligence is gaining ground in healthcare, and tech's biggest players are racing to stake their claims.	Tech giants like Jensen Huang's Nvidia are launching projects to bring AI to every part of healthcare.Justin Sullivan/Getty Images\r\n<ul><li>Tech's heaviest hitters are racing to build new AI tech for… [+12901 chars]	https://www.businessinsider.com/tech-powerhouses-betting-on-healthcare-ai-amazon-nvidia-2025-5	https://i.insider.com/681cb891c6ad288d14805d61?width=1200&format=jpeg	2025-05-15 09:00:01
146	0	12	NewsAPI	Australia's universal healthcare is crumbling. Can it be saved?	More and more Australians, regardless of where they live, are delaying or going without the care they need.	Tiffanie TurnbullReporting from\r\nStreaky Bay, South Australia\r\nFrom an office perched on the scalloped edge of the continent, Victoria Bradley jokes that she has the most beautiful doctor's practice … [+14610 chars]	https://www.bbc.com/news/articles/cnv56q82vnro	https://ichef.bbci.co.uk/news/1024/branded_news/a88f/live/ebd0d3f0-228d-11f0-8c2e-77498b1ce297.png	2025-04-26 22:41:37
147	0	12	NewsAPI	HealthBench	HealthBench is a new evaluation benchmark for AI in healthcare which evaluates models in realistic scenarios. Built with input from 250+ physicians, it aims to provide a shared standard for model performance and safety in health.	This work would not have been possible without the insight and generosity of the physicians who contributed their time and expertise to HealthBench. A full list of physicians who consented to be name… [+9931 chars]	https://openai.com/index/healthbench/	https://images.ctfassets.net/kftzwdyauwt9/4nJmJ6d66IOXQ4XnDAfY9z/af6492d5a61f3798228ae25208790d28/oai_ambrosia_health_eval_seo.png?w=1600&h=900&fit=fill	2025-05-12 17:42:37
148	0	12	NewsAPI	A millennial couple shares how they navigated the IVF process — and the $18,000 medical bill	Barrett and Shiraine McLeod told BI about their experience with IVF, how they covered the cost, and tips on navigating insurance.	Barrett and Shiraine McLeod hold their young son, Lejend, who was conceived via IVF.Photo Courtesy Shiraine McLeod\r\n<ul><li>Barrett and Shiraine McLeod spent $18,000 on IVF, which they paid for with … [+5951 chars]	https://www.businessinsider.com/insurance-fertility-ivf-costs-hsa-millennial-couple-infertility-2025-3	https://i.insider.com/67e40244b8b41a9673fbb847?width=1200&format=jpeg	2025-05-06 08:01:01
150	0	12	NewsAPI	A boomer couldn't retire on $1,428 a month in Social Security, so she moved to France for cheaper rent and a vibrant social life: 'Everything about living here is just better'	Celestine Cooley, 74, couldn't afford to retire in Los Angeles, so she moved to Bordeaux, France, where life is cheaper and more exciting.	Celestine Cooley, 74, moved to Bordeaux, France, to retire after living and working in Los Angeles for almost 50 years.Courtesy of Celestine Cooley\r\n<ul><li>Celestine Cooley moved to Bordeaux, France… [+5067 chars]	https://www.businessinsider.com/boomer-moved-france-retirement-travel-social-security-bordeaux-housing-costs-2025-5	https://i.insider.com/680fd1a03fe8d392836445d0?width=710&format=jpeg	2025-05-04 08:06:01
151	0	12	NewsAPI	276 Million Patient Records Compromised — What You Need To Know	New fake doctor threat targets healthcare as Check Point researchers warn of 276 million patient records compromised last year.	MedStealer malware has stolen 276 million patient records.\r\ngetty\r\nIt is a sad fact of life that cybercriminals are primarily motivated by one thing: illicit financial gain. Who gets hurt in the proc… [+2894 chars]	https://www.forbes.com/sites/daveywinder/2025/05/15/276-million-patient-records-compromised---what-you-need-to-know/	https://imageio.forbes.com/specials-images/imageserve/6825ad0f36f4ceeaa5d878d5/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-15 09:57:55
152	0	12	NewsAPI	This IG Account Shares Bizarre Medical Pics, Here Are 70 Of The Eeriest	If you’ve ever wanted to be a doctor or know someone who works in healthcare, you probably know how bizarre and even scary the medical field and the human body can be. The world’s medical history is full of eerie events, powerful breakthroughs, and moments th…	One of the most frightening and deeply creepy things we’ve encountered in recent science news is the advancement in biological computing using lab-grown neurons. It’s something straight out of a sci-… [+531 chars]	https://www.boredpanda.com/creepy-unsettling-medical-pics/	https://www.boredpanda.com/blog/wp-content/uploads/2025/05/creepy-unsettling-medical-pics-fb.png	2025-05-02 04:24:01
153	0	12	NewsAPI	Our post-SSRI era: A new network of clinics is opening up to help people wean off antidepressants	A new network of online clinics called Outro aims to get people off antidepressants — slowly.	iStock, Getty Images\r\n<ul><li>Many patients end up "parked" on antidepressant meds.</li><li>It can be tough to quit on your own. Withdrawal symptoms can range from mild to severe.</li><li>A first-of-… [+8611 chars]	https://www.businessinsider.com/how-to-quit-antidepressants-online-clinic-outro-tapering-microdosing-2025-5	https://i.insider.com/6823bcbec6ad288d1480d972?width=1200&format=jpeg	2025-05-14 09:01:01
154	0	12	NewsAPI	SEO For Healthcare: How Multi-Specialty Clinics Can Boost Visibility	For multi-specialty practices, ranking for search queries takes more than a single Google Business Profile, yet many still rely on outdated setups.	Oleg Levitas, a visionary SEO Expert, founded Pravda SEO to revolutionize how local businesses dominate search rankings.\r\ngetty\r\nWhen prospective patients search for a clinic online, they typically a… [+6745 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/04/30/seo-for-healthcare-how-multi-speciality-clinics-can-boost-visibility/	https://imageio.forbes.com/specials-images/imageserve/6810efe73ca233d3c7cdb060/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-30 13:45:00
155	0	12	NewsAPI	Top Three Ways Clinicians Are Using AI To Maximize ROI	If you were to ask a doctor, nurse practitioner, or therapist why they first entered medicine, the most common answer would be to heal and care for others.	Red arrow over stack of money coins arranged as a graph on wood table with blurry the doctor ... More stethoscope around neck a scene in the back, concept of financial health and medical expenses\r\nge… [+5764 chars]	https://www.forbes.com/sites/jaimecatmull/2025/05/05/top-three-ways-clinicians-are-using-ai-to-maximize-roi/	https://imageio.forbes.com/specials-images/imageserve/6818e08aeefb0aaab6f1e001/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 16:20:49
156	0.08	13	NewsAPI	Google Brain founder Andrew Ng's startup wants to use AI agents to redefine teaching. Here's how.	Kira Learning unveiled a new set of AI agents that will help teachers personalize their approach.	Steve Jennings / Stringer/Getty Images\r\n<ul><li>Kira Learning, chaired by Andrew Ng, launches AI agents to assist teachers in the classroom.</li><li>The platform aims to transform learning by making … [+6364 chars]	https://www.businessinsider.com/andrew-ng-startup-wants-to-use-ai-agents-redefine-teaching-2025-4	https://i.insider.com/68095c74c6ad288d147efb50?width=1200&format=jpeg	2025-04-23 22:50:54
157	0.08	13	NewsAPI	I didn't expect to become such good friends with a coworker who is 17 years younger than I am. We're different in many ways.	I didn't expect to become such good friends with a coworker 17 years younger than I am. There are generational differences but we get along so well.	The author (not pictured) made friends with a younger coworker.Hinterhaus Productions/Getty Images\r\n<ul><li>My friend Emma and I met at work, and we instantly connected despite our differences. </li>… [+4290 chars]	https://www.businessinsider.com/coworker-friend-age-gap-generational-differences-2025-4	https://i.insider.com/6801020bc6ad288d147e6844?width=1200&format=jpeg	2025-04-24 08:18:01
158	0.08	13	NewsAPI	Uncertified Teachers in Texas? 56% of new teachers. The Impact & Solution	From the Cool Cat Teacher Blog by Vicki Davis Subscribe to the 10 Minute Teacher Podcast anywhere you listen to podcasts.\nWhat happens when over 50% of new teachers in a state are uncertified? In this episode of The 10 Minute Teacher Podcast, Dr. Jacob Kirkse…	Imagine sending your child to school only to find out their teacher has never been trained. No coursework. No classroom experience. Just passionand a paycheck.\r\nThats the reality for more than half o… [+4400 chars]	https://www.coolcatteacher.com/e890/	https://www.coolcatteacher.com/wp-content/uploads/2025/04/56-percent-new-teachers-in-texas-are-uncertified-1.png	2025-04-21 09:00:00
159	0	13	NewsAPI	Draft Executive Order Outlines Plan To Integrate AI Into K-12 Schools	A draft executive order from the Trump administration proposes integrating AI into K-12 education by directing federal agencies to promote AI literacy, train teachers, and establish public-private partnerships. "The draft is marked 'predecisional' and could b…	Titled "Advancing artificial intelligence education for American youth," the draft order would establish a White House task force on AI education that would be chaired by Michael Kratsios, director o… [+1352 chars]	https://news.slashdot.org/story/25/04/23/2112226/draft-executive-order-outlines-plan-to-integrate-ai-into-k-12-schools	https://a.fsdn.com/sd/topics/education_64.png	2025-04-24 00:20:00
160	0	13	NewsAPI	'Teachers are having scissors thrown at them - we've had enough'	Staff say they are often unable to teach as large groups of students roam the school.	Charlie Jones\r\nScience teacher Sophie Walker says she and her colleagues have reached breaking point\r\nWhen Sophie Walker graduated and became a teacher 10 years ago, she felt excited for the future.\r… [+7826 chars]	https://www.bbc.com/news/articles/cvgq98edegxo	https://ichef.bbci.co.uk/news/1024/branded_news/de10/live/1718cc20-3193-11f0-8947-7d6241f9fce9.jpg	2025-05-17 00:12:51
161	0	13	NewsAPI	Former teacher of the year gets 30 years in California prison for sexually assaulting students	A onetime county teacher of the year at a Southern California elementary school has been sentenced to 30 years to life in prison for grooming and sexually...	SAN DIEGO (AP) A onetime county teacher of the year at a Southern California elementary school has been sentenced to 30 years to life in prison for grooming and sexually assaulting two young boys on … [+1327 chars]	https://www.yahoo.com/news/former-teacher-gets-30-years-165204484.html	https://s.yimg.com/cv/apiv2/social/images/yahoo_default_logo-1200x1200.png	2025-05-13 16:52:04
162	0	13	NewsAPI	Oklahoma education standards say students must identify 2020 election 'discrepancies'	New academic standards in Oklahoma call for the teaching of "discrepancies" in the 2020 election, continuing the spread of a false narrative years after it was first pushed by Trump and his allies.	TULSA, Okla. New academic standards in Oklahoma call for the teaching of "discrepancies" in the 2020 election results, continuing the spread of a false narrative years after it was first pushed by Pr… [+6097 chars]	https://www.npr.org/2025/05/14/nx-s1-5384282/oklahoma-education-standards-2020-election	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/4639x2609+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fc3%2F8e%2Ff868d977431fac66f7adec1c1297%2Fap25027772468178.jpg	2025-05-14 09:00:00
163	0	13	NewsAPI	Influencers fuelling misogyny in schools, teachers say	Almost three in five teachers believe social media use has had a negative effect on behaviour in schools, according to a union poll.	Social media influencers are fuelling an increase in misogyny and sexism in schools, according to a new poll by a teaching union.\r\nAlmost three in five teachers said they believe social media use has… [+2909 chars]	https://www.bbc.com/news/articles/crm3x92mpdxo	https://ichef.bbci.co.uk/news/1024/branded_news/9027/live/b4598050-1cb8-11f0-a3a8-a5e49d306c01.jpg	2025-04-19 03:02:10
164	0	13	NewsAPI	Angie Murimirwa: From hiding in the bathroom to Time's most influential people list	A kid whose parents couldn't afford school fees is now an "icon" on Time magazine's 2025 list — recognizing her work as CEO of Camfed, a charity that gives millions of girls a chance for an education.	I don't mean to humble brag, but I am on a first name basis with one of the most influential people in the world (according to the new list from Time magazine).\r\nIt's not Serena Williams. It's not Me… [+6508 chars]	https://www.npr.org/sections/goats-and-soda/2025/04/25/g-s1-62501/time-magazine-most-influential-angeline-murimirwa	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+160/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fe3%2F29%2F215ccf9545b0bcc608167091ea34%2Fgettyimages-847378358.jpg	2025-04-25 17:41:08
165	0	13	NewsAPI	Congress celebrates impactful teachers: 'We certainly do appreciate them'	Lawmakers are celebrating Teacher Appreciation Week 2025 by paying tribute to the educators who helped them ascend to Congress.	Lawmakers are celebrating Teacher Appreciation Week 2025 by paying tribute to the educators who helped them ascend to Congress.\r\nHouse Speaker Mike Johnson, R-La., said his wife and mother-in-law, wh… [+4677 chars]	https://abcnews.go.com/Politics/congress-celebrates-impactful-teachers/story?id=121612463	https://i.abcnewsfe.com/a/fbc5b046-6d9e-47f6-afbe-3c61711b2a8f/mike-johnson-gty-jt-250508_1746736389060_hpMain_16x9.jpg?w=1600	2025-05-09 17:40:41
166	0	13	NewsAPI	I’m A Teacher. Here’s The Shocking Truth About The "Woke" Indoctrination Of Students That Terrifies Conservatives.	"There are scores of MAGA folks screeching in chorus about evil liberal teachers indoctrinating kids with vegan transgender socialism."	Im a bit of a masochist. I cant help but read the comments whenever the local news posts anything political on social media especially when its related to public education.\r\nIve spent most of my life… [+8019 chars]	https://www.buzzfeed.com/marcovanserra/teacher-student-liberal-woke-indoctrination	https://s.yimg.com/ny/api/res/1.2/4gJlbzJqsxvIQZInECcx8A--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03OTc-/https://media.zenfs.com/en/buzzfeed_articles_778/76187a52e5c0424a2204f78343a372f0	2025-04-18 01:31:04
167	0	13	NewsAPI	I Thought ChatGPT Was Killing My Students’ Skills. It’s Killing Something More Important Than That.	Trust between teacher and student was tricky way before A.I. hit us.	This essay was adapted from Phil Christmans newsletter, the Tourist. Subscribe here.\r\nBefore 2023, my teaching year used to follow a predictable emotional arc. In September, I was always excited, not… [+8447 chars]	https://slate.com/life/2025/05/college-student-cheating-ai-detector-chatgpt-school-education.html	https://compote.slate.com/images/3d0398d8-cc18-4673-824f-9579b3f09728.jpeg?crop=1560%2C1040%2Cx0%2Cy0&width=1560	2025-05-14 19:38:52
168	0	13	NewsAPI	What President Trump's Department of Education Closure Could Mean for Student Broadband Access	Trump signed an executive order to eliminate the Department of Education. Will that increase internet access for students or create more barriers?	There's a stark disconnect between our era of internet connectivity and a looming sense of detachment, separation and seclusion for some students in K-12 schools.\r\nOn March 20, President Donald Trump… [+15912 chars]	https://www.cnet.com/home/internet/what-president-trumps-department-of-education-closure-could-mean-for-student-broadband-access/	https://www.cnet.com/a/img/resize/40fa14e88e63a8cb46e3464aad1d17c453d41769/hub/2025/04/09/8cbe5006-39a8-46d5-b17b-4b81ac0be3a7/bd-us-department-of-education-alt.png?auto=webp&fit=crop&height=675&width=1200	2025-04-19 11:00:00
169	0	13	NewsAPI	Special education teachers gets thrown under the bus by her supervisor, so she gathers the receipts and gets him fired: ‘He sent me a formal letter of apology…'	Being a teacher is not easy. You have to take car of children, many children, every single day! Ask any parent, that is a difficult job. There is a reason you have to get a teacher's degree in order to do it. Some kids can be really mean, especially teenagers…	Being a teacher is not easy. You have to take car of children, many children, every single day! Ask any parent, that is a difficult job. There is a reason you have to get a teacher's degree in order … [+651 chars]	https://cheezburger.com/40441861/special-education-teachers-gets-thrown-under-the-bus-by-her-supervisor-so-she-gathers-the-receipts	https://i.chzbgr.com/thumb1200/40441861/hD92474F5/her-supervisor-so-she-gathers-the-receipts-and-gets-him-fired-he-sent-me-a-formal-letter-of-apology	2025-05-08 17:00:00
170	0	13	NewsAPI	First on ABC: Warren probing impact on students, teachers from Education Dept. cuts	She says she wants to hear from those directly "hurt by Trump's dangerous agenda."	Democratic Sen. Elizabeth Warren's Save Our Schools campaign\r\n is launching a comprehensive investigation into the Trump administration's effort to close the Department of Education.\r\n"I'm opening th… [+3785 chars]	https://abcnews.go.com/Politics/abc-warren-investigates-impact-students-teachers-education-dept/story?id=121099089	https://i.abcnewsfe.com/a/0a401dc6-d1da-49a1-a93f-f0fd9c9fb401/warren-gty-er-250423_1745447670456_hpMain_16x9.jpg?w=1600	2025-04-24 09:19:44
171	0	13	NewsAPI	What to know about a federal proposal to help families pay for private school	Republicans want to use the federal tax code to create a national school voucher even in states where voters have fought such efforts.	A first-of-its-kind effort to leverage federal tax dollars to help families pay for private school tuition anywhere in the U.S. is one step closer to becoming a reality.\r\nRepublicans on the House Way… [+6314 chars]	https://www.npr.org/2025/05/14/nx-s1-5397945/private-school-vouchers-choice-reconciliation	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+198/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F66%2Fb0%2F0411f356468caf668e0eee30cd28%2Fgettyimages-2199281234.jpg	2025-05-14 20:46:27
172	0	13	NewsAPI	Trump’s Latest Draft Executive Order Seeks to Integrate AI Into K-12 Education	The draft order states that in order for the United States to remain ahead technologically, America's youth must cultivate skills using AI.	Schools across the United States often cannot afford basics like pencils or stationary paper, and the new education secretary has sought to fulfill President Trump’s promise of getting the federal go… [+4202 chars]	https://gizmodo.com/trumps-latest-draft-executive-order-seeks-to-integrate-ai-into-k-12-education-2000592707	https://gizmodo.com/app/uploads/2020/03/kd29nokpgbwhcrahd3zi.jpg	2025-04-22 17:55:59
173	0	13	NewsAPI	Fox News AI Newsletter: Teacher's tech tell-all goes viral	Stay up to date on the latest AI technology advancements and learn about the challenges and opportunities AI presents now and for the future.	Welcome to Fox News Artificial Intelligence newsletter with the latest AI technology advancements.\r\nIN TODAY'S NEWSLETTER:- Teacher quits profession after viral rant on how AI is 'ruining' education-… [+3126 chars]	https://www.foxnews.com/tech/ai-newsletter-teachers-tech-tell-all-goes-viral	https://static.foxnews.com/foxnews.com/content/uploads/2025/05/teacher.png	2025-05-17 12:30:24
174	0	13	NewsAPI	Parents refuse to let 17-year-old go on school Marine Biology trip after telling her to refuse $45 "handout" for the fee from her teacher: 'They have been calling me ungrateful and spoiled'	Sometimes you literally can't afford to turn down a favor. It might be hard to swallow your pride, but you have to accept that those wanting to help don't look down on you; they just want to help, and that's where it begins and ends. When your education, futu…	Sometimes you literally can't afford to turn down a favor. It might be hard to swallow your pride, but you have to accept that those wanting to help don't look down on you; they just want to help, an… [+1155 chars]	https://cheezburger.com/40348933/parents-refuse-to-let-17-year-old-go-on-school-marine-biology-trip-after-telling-her-to-refuse-45	https://i.chzbgr.com/original/40348933/hE2F0DE04/family-pregnant-reddit-thread-parent-raising-kids-parenting-fail-parents-children-family-40348933	2025-04-29 16:00:00
175	0	13	NewsAPI	Palm Beach County schools bypassed screening in hiring educator facing molestation charges	Norman Riemer, a former Palm Beach County School District educator facing molestation charges, needed a waiver to be hired in 1999.	Palm Beach County School District records show that the district bypassed its normal process in the 1999 hiring of Norman Riemer, the former science teacher who was arrested last month and faces five… [+8390 chars]	https://www.palmbeachpost.com/story/news/education/2025/05/16/florida-teacher-facing-molestation-charges-failed-screening-in-1999/83608953007/	https://s.yimg.com/ny/api/res/1.2/vqDnFyfuhl_48IAFOKAomw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/palm-beach-daily-news/5342ccc2ada7b20ab5de415d54e13d5c	2025-05-16 09:01:48
176	0.178	14	NewsAPI	AI as an Educational Ally: Innovative Strategies for Classroom Integration	Since the public release of ChatGPT in December 2022, educators have faced the challenge of effectively integrating artificial intelligence (AI) into their teaching. Rather than simply acknowledging that students are using AI, we should create opportunities f…	Since the public release of ChatGPT in December 2022, educators have faced the challenge of effectively integrating artificial intelligence (AI) into their teaching. Rather than simply acknowledging … [+8829 chars]	https://www.facultyfocus.com/articles/teaching-with-technology-articles/ai-as-an-educational-ally-innovative-strategies-for-classroom-integration/	https://s39613.pcdn.co/wp-content/uploads/2025/04/iStock-2080335707-scaled.jpg	2025-04-23 04:00:00
177	0.089	14	NewsAPI	DC/DOX To Showcase A Dozen World Premieres, Oscar Contenders, Films On Barbara Walters, Robert Reich, Deepfaked Sam Altman	EXCLUSIVE: DC/DOX, the prestigious documentary film festival in the nation’s capital, today announced the full slate for its third edition. The cinematic event will include a dozen world premieres including The Last Class, a documentary about former Secretary…	EXCLUSIVE:DC/DOX, the prestigious documentary film festival in the nation’s capital, today announced the full slate for its third edition.\r\nThe cinematic event will include a dozen world premieres in… [+36940 chars]	http://deadline.com/2025/05/dc-dox-2025-lineup-announcement-1236388039/	https://deadline.com/wp-content/uploads/2025/05/GettyImages-1258793062.jpg?w=1024	2025-05-07 15:30:00
178	0.089	14	NewsAPI	Teachers face 5% pay loss if Leaving Cert reforms blocked	Teacher unions to ballot members on whether to accept package or take industrial action in September	Teachers could lose up to 5 per cent of pay due under public service deals if they fail to co-operate with controversial Leaving Cert reforms, second-level teaching unions have been warned.\r\nThe chan… [+3613 chars]	https://www.irishtimes.com/ireland/education/2025/05/13/teachers-face-5-pay-loss-if-leaving-cert-reforms-blocked/	https://www.irishtimes.com/resizer/v2/OFUCC5WDNREKVCHLWEA63BFEPQ.JPG?smart=true&auth=305a064aeee1389be77468967c7e76c1ef16b90a7c951a206e12b19c5612cabf&width=1200&height=630	2025-05-13 05:00:00
179	0.089	14	NewsAPI	First national convention on education to be established in 30 years	Education minister Helen McEntee is to establish a national convention on education, touching on all aspects of teaching and pupil well-being.	Education minister Helen McEntee is to establish a national convention on education, touching on all aspects of teaching and pupil well-being.It is understood that the convention will be established … [+3050 chars]	https://www.independent.ie/irish-news/first-national-convention-on-education-to-be-established-in-30-years/a1612484165.html	https://focus.independent.ie/thumbor/Xe--csvWyX8Hvp6X_YXRyp55DQs=/0x0:5881x3920/629x0/prod-mh-ireland/26e88a06-2dda-40cc-aa5c-f1c2f74ca022/a5a3530b-3700-431a-b49a-6d686819531c/26e88a06-2dda-40cc-aa5c-f1c2f74ca022.jpg	2025-04-23 08:35:31
180	0.089	14	NewsAPI	AI's Hidden Power: Former Google CEO Says We're All Missing the Point	Eric Schmidt argues AI's broad capabilities—not just chat functions—make it more revolutionary than most realize.	In brief\r\n<ul><li>Former Google CEO Eric Schmidt argues that while people fixate on AI's language skills, they're missing its rapidly advancing planning and strategy abilities that could reshape soci… [+6052 chars]	https://decrypt.co/320263/ai-hidden-power-former-google-ceo-missing-point	https://cdn.decrypt.co/resize/1024/height/512/wp-content/uploads/2025/05/Screenshot-2025-05-15-140941-gID_7.png	2025-05-15 21:31:28
181	0.089	14	NewsAPI	Why Depth Is a Critical Advantage in the Age of AI	The future is unpredictable. We know that. So, when we try to design learning experiences that “prepare students for the future,” we have to recognize that we don’t always know what they’ll need. In this article, I explore the counterintuitive reality that th…	The future is unpredictable. We know that. So, when we try to design learning experiences that “prepare students for the future,” we have to recognize that we don’t always know what they’ll need. In … [+17083 chars]	https://spencereducation.com/depth-ai/	https://spencereducation.com/wp-content/uploads/2025/04/background2.png	2025-04-30 02:13:16
182	0	14	NewsAPI	Google Brain founder Andrew Ng's startup wants to use AI agents to redefine teaching. Here's how.	Kira Learning unveiled a new set of AI agents that will help teachers personalize their approach.	Steve Jennings / Stringer/Getty Images\r\n<ul><li>Kira Learning, chaired by Andrew Ng, launches AI agents to assist teachers in the classroom.</li><li>The platform aims to transform learning by making … [+6364 chars]	https://www.businessinsider.com/andrew-ng-startup-wants-to-use-ai-agents-redefine-teaching-2025-4	https://i.insider.com/68095c74c6ad288d147efb50?width=1200&format=jpeg	2025-04-23 22:50:54
183	0	14	NewsAPI	We Are All AI's Teachers—And It's Our Job to Teach Wisely	As AI learns from us, every digital action shapes its future. We can guide AI to reflect our best, not our worst.	AI systems function as mirrors to humanity. They reflect us back to ourselves, showing our weaknesses as well as our strengths, our shadows just as much as our light.\r\nThe reason AI functions as a mi… [+7856 chars]	https://www.psychologytoday.com/us/blog/code-conscience/202504/we-are-all-ais-teachers-and-its-our-job-to-teach-wisely	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-04/Teach%20Wisely%20%E2%80%94%20The%20Future%20Is%20Listening_0.jpg?itok=k038ZhKX	2025-04-18 14:52:02
184	0	14	NewsAPI	How A 22-Year-Old Landed The ‘World’s Creamiest Hummus,’ Habiza, On Target Shelves	Jonathan Srour takes his great-grandmother's hummus recipe and adds Gen Z-branded appeal.	Habiza Hummus\r\nHabiza\r\nNot many people take pride in getting straight Ds in high school. But Jonathan Srour, founder of Habiza Hummus\r\n, has his own distinct way of seeing things.\r\nHe was eager to be… [+9728 chars]	https://www.forbes.com/sites/andrewwatman/2025/05/12/how-a-22-year-old-landed-the-worlds-creamiest-hummus-habiza-on-target-shelves/	https://imageio.forbes.com/specials-images/imageserve/6822103038bf3a1f108cda66/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-12 15:40:06
185	0	14	NewsAPI	Helen McEntee announces ‘largest national conversation on education in the State’s history’	National Convention planned to explore how nation can secure ‘best outcomes in world’ for students	A new national convention, to begin in the coming school year, will be the largest national conversation on education in the history of the State, Minister for Education Helen McEntee has said.\r\nIt i… [+3233 chars]	https://www.irishtimes.com/ireland/education/2025/04/23/helen-mcentee-announces-largest-national-conversation-on-education-in-the-states-history/	https://www.irishtimes.com/resizer/v2/BJGJC752CBDC5JV5KWZWHR74Y4.JPG?smart=true&auth=200b5e66de8e62ab95f662fc9df551b5eac62a830152a763cd31ecc26d815a39&width=1200&height=630	2025-04-22 23:01:00
186	0	14	NewsAPI	Photography Educator: Dornith Doherty	Photography Educator is a monthly series on Lenscratch. Once a month, we celebrate a dedicated photography teacher by sharing their insights, strategies and excellence in inspiring students of all ages. These educators play a transformative role in student de…	©Dornith Doherty, Walnut Clones, 2024 from the project, Archiving Eden\r\nPhotography Educator is a monthly series on Lenscratch. Once a month, we celebrate a dedicated photography teacher by sharing t… [+13844 chars]	http://lenscratch.com/2025/05/photography-educator-dornith-doherty/	http://lenscratch.com/wp-content/uploads/2025/04/11-Dornith-Doherty-Walnut-Clones-2024_1000pxW.jpg	2025-05-09 09:39:07
187	0	14	NewsAPI	Universe-Expanding Children’s Books Coming Out in May	As children’s books have faced recent bans in schools and libraries, and even come up for comment in a case before the Supreme Court, I’ve been thinking about how powerful the books we give to our children can be. They can teach readers about historical event…	As childrens books have faced recent bans in schools and libraries, and even come up for comment in a case before the Supreme Court, Ive been thinking about how powerful the books we give to our chil… [+10414 chars]	https://lithub.com/universe-expanding-childrens-books-coming-out-in-may/	https://s26162.pcdn.co/wp-content/uploads/2025/04/childrens-books-may.jpg	2025-05-02 08:59:04
188	0	14	NewsAPI	New Leaving Cert senior cycle to start this September	The new Leaving Cert senior cycle is due to start this September, Minister for Education Helen McEntee has confirmed.	The new Leaving Cert senior cycle is due to start this September, Minister for Education Helen McEntee has confirmed. The minister said that introducing the programme this autumn is in the "best inte… [+4842 chars]	https://www.independent.ie/irish-news/new-leaving-cert-senior-cycle-to-start-this-september/a1746848291.html	https://focus.independent.ie/thumbor/B_i_3SJlPKlwrlugWV6m1v3bKWg=/0x0:3238x2158/629x0/prod-mh-ireland/d34189b7-8f10-432f-85a8-8f7ee521801b/ba3e35a7-87f9-4767-a4fb-c9858758a359/d34189b7-8f10-432f-85a8-8f7ee521801b.jpg	2025-05-09 09:01:04
189	0	14	NewsAPI	New Leaving Cert senior cycle to start this September	The new Leaving Cert senior cycle is due to start this September, Minister for Education Helen McEntee has confirmed.	The new Leaving Cert senior cycle is due to start this September, Minister for Education Helen McEntee has confirmed. The minister said that introducing the programme this autumn is in the "best inte… [+4842 chars]	https://www.independent.ie/irish-news/education/new-leaving-cert-senior-cycle-to-start-this-september/a1746848291.html	https://focus.independent.ie/thumbor/WopOu9rmD4enmF3jXF3yIQyQtmM=/0x0:3238x2158/629x0/prod-mh-ireland/d34189b7-8f10-432f-85a8-8f7ee521801b/5404c534-6ca4-4870-b1f1-03541ab4a49b/d34189b7-8f10-432f-85a8-8f7ee521801b.jpg	2025-05-09 09:01:05
190	0	14	NewsAPI	How “The Great Gatsby” Took Over High School	Alexander Manshel chronicles the history of how “The Great Gatsby” became a staple of high-school English classrooms across the United States.	In the spring of 1940, F. Scott Fitzgerald was worried about The Great Gatsby. It had been fifteen years since the novel was published, and the author had little to show for it. My God I am a forgott… [+11743 chars]	https://www.newyorker.com/books/page-turner/how-the-great-gatsby-took-over-high-school	https://media.newyorker.com/photos/680f922f2453bb40d8c2b6aa/16:9/w_1280,c_limit/NYER_GATSBY_HS_Takeover.jpg	2025-04-29 10:00:00
212	0	15	NewsDATA	Concern for University Lab School as officials discuss possible ‘UH CampusTown’	The prospect of a mixed-use development to create a more vibrant atmosphere for students at the University of Hawaii at Manoa is drawing fire from supporters of University Laboratory School who fear the K-12 campus would be displaced in the process.	ONLY AVAILABLE IN PAID PLANS	https://www.staradvertiser.com/2025/05/18/hawaii-news/officials-discuss-possible-campustown-at-uh-manoa/	https://www.staradvertiser.com/wp-content/uploads/2025/05/web1_CTY-ULS-petition-1512.jpg	2025-05-18 10:05:00
191	0	14	NewsAPI	Why IDOL courses is quietly creating one of the strongest instructional design talent pipelines	In the fall of 2017, Robin Sargent found herself conducting an exit interview with a promising instructional designer who was leaving after just eight months. The young hire — bright, eager, freshly graduated with a master's degree — had struggled with the ba…	Photo courtesy of IDOL courses\r\nOpinions expressed by Digital Journal contributors are their own.\r\nIn the fall of 2017, Robin Sargent found herself conducting an exit interview with a promising instr… [+5207 chars]	https://www.digitaljournal.com/business/why-idol-courses-is-quietly-creating-one-of-the-strongest-instructional-design-talent-pipelines/article	https://www.digitaljournal.com/wp-content/uploads/2025/05/Spon-Con-resizing-Template-17-1200x675.png	2025-05-16 20:54:43
192	0	14	NewsAPI	Anwar calls for bold education reforms ahead of 13th Malaysia Plan	KUALA LUMPUR: Datuk Seri Anwar Ibrahim has emphasised the need for bold and comprehensive reforms in developing Malaysia's new education strategy ahead of the 13th Malaysia Plan (13MP). Read full story	KUALA LUMPUR: Datuk Seri Anwar Ibrahim has emphasised the need for bold and comprehensive reforms in developing Malaysia's new education strategy ahead of the 13th Malaysia Plan (13MP).\r\nThe Prime Mi… [+1406 chars]	https://www.thestar.com.my/news/nation/2025/05/07/anwar-calls-for-bold-education-reforms-ahead-of-13th-malaysia-plan	https://apicms.thestar.com.my/uploads/images/2025/05/07/3304070.jpg	2025-05-07 14:21:00
193	0	14	NewsAPI	Letters: Easter trading laws called inconsistent and illogical; Defence Capability Plan risks $12b for outdated strategy	OPINION: The Defence Capability Plan overlooks key modern threats.	It fails to properly understand our threats or consider the most effective way of addressing them. The $12 billion committed risks undermining our security rather than increasing it.\r\nThe principal t… [+3718 chars]	https://www.nzherald.co.nz/nz/letters-easter-trading-laws-called-inconsistent-and-illogical-defence-capability-plan-risks-12b-for-outdated-strategy/L67PD4O4ZZESHOZI3BS2ZOZMUE/	https://www.nzherald.co.nz/resizer/v2/KRTLFFUBWVHCVHGK3FH6BK2FNI.jpg?auth=ab3af2b3c28ae37255c35a3f633fe6d5e4469f9fdb68a064531cefeab0f029c9&width=1200&height=675&quality=70&smart=true	2025-04-21 17:00:00
194	0	14	NewsAPI	Why men are the minority: The perceptions of young men in UK post-primary education about studying psychology at university	Psychology is categorised as a science by most higher education authorities internationally. As with many science, mathematics and engineering fields, women are underrepresented in psychology at senior levels (the ‘leaky pipeline’). However, it is men who are…	Abstract\r\nPsychology is categorised as a science by most higher education authorities internationally. As with many science, mathematics and engineering fields, women are underrepresented in psycholo… [+66400 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322541	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322541.g001&size=inline	2025-05-08 14:00:00
195	0	14	NewsAPI	Cardio-metabolic traits and its socioeconomic differentials among school children including metabolically obese normal weight phenotypes in India: A post-COVID baseline characteristics of LEAP-C cohort	Background Cardio-metabolic risks emerge in early life and progress further in adult life. In recent times, COVID-19 pandemic aggravated risks owing to poor food security and diet quality. We aimed to assess the prevalence of cardiometabolic traits including …	Citation: Kalaivani M, Hemraj C, Varhlunchhungi V, Ramakrishnan L, Malhotra S, Gupta SK, et al. (2025) Cardio-metabolic traits and its socioeconomic differentials among school children including meta… [+43435 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0321898	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0321898.g007&size=inline	2025-05-06 14:00:00
196	0.1	15	NewsAPI	What teachers really need during appreciation week	That teacher who stays late grading papers and arrives early to help struggling students is quietly reaching a breaking point. While they smile and enthusiastically explain decimals for the fifth time today, they’re also wondering how they’ll find time to cre…	That teacher who stays late grading papers and arrives early to help struggling students is quietly reaching a breaking point. While they smile and enthusiastically explain decimals for the fifth tim… [+7596 chars]	https://rollingout.com/2025/05/05/what-teachers-really-need/	https://rollingout.com/wp-content/uploads/2024/08/shutterstock_1200194515.jpg	2025-05-05 14:44:41
197	0.1	15	NewsAPI	Union leadership instructed to renegotiate adult educator deal	TUI assistant general secretary Colm Kelly said the union’s executive would consider the motion	Delegates at the annual Teachers Union of Ireland (TUI) conference have instructed union leadership to renegotiate a recent deal with Government that was designed to improve working conditions for mo… [+3014 chars]	https://www.irishtimes.com/ireland/education/2025/04/24/union-leadership-instructed-to-renegotiate-adult-educator-deal/	https://www.irishtimes.com/resizer/v2/6H6W77KTEFC3NMATEE5VG5VQXE.jpg?smart=true&auth=5e4de780e5c383837914534a268eef1ad829d460bd749830cac4fae55716a464&width=1200&height=630	2025-04-24 19:10:55
198	0	15	NewsAPI	10 High-Paying Jobs In Education That Don't Require A Degree	Find high-paying teaching jobs that don’t require a degree. Use your skills and experience to break into the education field—no diploma needed.	As the education sector evolves, it will move toward greater personalization, online learning and a ... More focus on skills over traditional credentials.\r\ngetty\r\nWhile many assume education careers … [+11511 chars]	https://www.forbes.com/sites/carolinecastrillon/2025/05/07/high-paying-teaching-jobs-no-degree/	https://imageio.forbes.com/specials-images/imageserve/681a7de2eb802b247b791028/0x0.jpg?format=jpg&crop=2469,1389,x0,y222,safe&height=900&width=1600&fit=bounds	2025-05-07 17:00:00
199	0	15	NewsAPI	Trump unveils sweeping order to bring AI into US education	The executive order forms a new task force and leverages existing grant programs focused on improving AI education in the U.S.	The White House released a new executive action on Wednesday that aims to bring education in artificial intelligence technologies and tools to schools at the K-12 level through the creation of a new … [+5057 chars]	https://www.nextgov.com/artificial-intelligence/2025/04/trump-unveils-sweeping-order-bring-ai-us-education/404800/	https://cdn.nextgov.com/media/img/cd/2025/04/24/042425TrumpNG/open-graph.jpg	2025-04-24 17:15:00
200	0	15	NewsAPI	Parents Deserve Choices, but Not at Public Schools' Expense | Opinion	Former Secretary of Education Cardona speaks out for public education and against vouchers	Public education is the great equalizer. Like millions of American students across the country today, growing up, I had only what my neighborhood school provided. And, in my case, it was a good start… [+5921 chars]	https://www.newsweek.com/2025/05/16/parents-deserve-choices-not-public-schools-expense-opinion-2067267.html	https://d.newsweek.com/en/full/2637502/per02-cardona-01.jpg	2025-05-07 09:00:01
202	0	15	NewsAPI	Leveraging Technology For Active Learning In The Modern Classroom	Active learning encourages student engagement through exploration, collaboration, and critical thinking. Using technology can enhance that; let's explore how.\nThis post was first published on eLearning Industry.	Modern classrooms look a lot different from those of even a decade ago. Learning isn't focused on a chalkboard and memorizing facts anymore. In the modern classroom, things are more interactive, enga… [+7927 chars]	https://elearningindustry.com/leveraging-technology-for-active-learning-in-the-modern-classroom	https://cdn.elearningindustry.com/wp-content/uploads/2025/05/Leveraging-Technology-For-Active-Learning.jpg	2025-05-10 19:00:37
203	0	15	NewsAPI	Taking Grades (Stress) Out of Learning	I found myself sitting in a classroom, staring at a test I couldn’t answer. No matter how hard I tried, I couldn’t recall learning any of the material. The harder I struggled to remember, the more my anxiety grew—until I jolted awake, covered in sweat. It was…	I found myself sitting in a classroom, staring at a test I couldnt answer. No matter how hard I tried, I couldnt recall learning any of the material. The harder I struggled to remember, the more my a… [+8852 chars]	https://www.facultyfocus.com/articles/educational-assessment/taking-grades-stress-out-of-learning/	https://s39613.pcdn.co/wp-content/uploads/2025/04/iStock-2163421516-scaled.jpg	2025-04-18 04:00:00
204	0	15	NewsAPI	Create Stunning Animated Cartoons & Videos with Invideo AI in Minutes	Creating animated cartoon videos has traditionally been a complex and time-intensive process, requiring specialized skills and advanced tools. However, advancements in AI technology have transformed this landscape, making it more accessible to a wider audienc…	Creating animated cartoon videos has traditionally been a complex and time-intensive process, requiring specialized skills and advanced tools. However, advancements in AI technology have transformed … [+6996 chars]	https://www.geeky-gadgets.com/ai-animated-video-creation-guide/	https://www.geeky-gadgets.com/wp-content/uploads/2025/04/ai-animated-video-creation-guide_optimized.jpg	2025-04-29 09:09:33
205	0	15	NewsAPI	TIME100 Health Honorees Toast to Progress, Affirmation Over Fear, and Changing a ‘Heartbreaking Reality’	Bill Nye, Tahmeed Ahmed, Ronita Nath, and Damar Hamlin spoke at the 2025 TIME100 Health Impact Dinner.	Health is multifaceted, a fact that was reflected in the industry-spanning community gathered Tuesday night at the TIME100 Health Impact Dinner honoring some of the most influential people leading th… [+6396 chars]	https://time.com/7284464/health-impact-dinner-toasts-bill-nye-tahmeed-ahmed-ronita-nath-damar-hamlin/	https://api.time.com/wp-content/uploads/2025/05/time100-health-event-001.jpg?quality=85&w=1200&h=628&crop=1	2025-05-14 03:00:00
206	0	15	NewsAPI	Empowering visually impaired students through innovative tools and accessible waste sorting education at the national level	Waste separation is a critical strategy to address the intensifying global waste crisis. However, inclusive teaching strategies for visually impaired students remain limited. This study addresses this pressing gap by implementing an innovative intervention ro…	Abstract\r\nWaste separation is a critical strategy to address the intensifying global waste crisis. However, inclusive teaching strategies for visually impaired students remain limited. This study add… [+67115 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0323171	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0323171.t008&size=inline	2025-05-07 14:00:00
207	0	15	NewsAPI	The Mercury's May 2025 Election Endorsements	Our top picks for the May 20 Special District Election, featuring school board seats, public school bonds, and more! \n \n by The Mercury Election Strike Force\n \n \n \n On May 20, Multnomah County residents will elect new leadership on local school boards and uti…	On May 20, Multnomah County residents will elect new leadership on local school boards and utility boards. Portland voters will also decide whether to renew a sizable school bond measure to fund Port… [+24418 chars]	https://www.portlandmercury.com/election/2025/05/02/47765305/the-mercurys-may-2025-election-endorsements	https://media1.fdncms.com/portmerc/imager/u/large/47768451/may2024primary_cv_01_1_.webp	2025-05-03 00:55:00
208	0	15	NewsAPI	Yale juniors honored for leadership, scholarship, community contributions	Forty-eight Yale College juniors were recognized by the Council of the Heads of Colleges for their scholarship, character, and contributions to college&nbsp;life.	Forty-eight Yale College juniors received honors from the Council of the Heads of Colleges in recognition of their scholarship, contributions to college life, and their character.\r\nThe winning studen… [+67161 chars]	https://news.yale.edu/2025/05/02/yale-juniors-honored-leadership-scholarship-community-contributions	https://news.yale.edu/sites/default/files/styles/opengraph_image/public/2025-05/2025_04_24_09-19-18_R5A_5063-Enhanced-NR-YN.jpg?h=03155992&itok=4b2Lo3XE	2025-05-02 19:27:21
209	0	15	NewsAPI	22 of the best lifestyle and entertainment stories of the year so far	While you enjoy a long weekend break, catch up on some of the best stories of 2025 so far.	One key quote: To Claires eyes and mind Meadowlark exists with the purpose of adding beauty to world. It sounds cheesy but that is the truth. Giving people things that take the pain away for a minute… [+14759 chars]	https://www.nzherald.co.nz/lifestyle/22-of-the-best-lifestyle-and-entertainment-stories-of-the-year-so-far/HFDXS75BSBFNRJ4CDPXJL5T6HI/	https://www.nzherald.co.nz/resizer/v2/DNGBUBUWXREBJGFY4AWGWJOYHA.jpg?auth=1a6d80866462b6e237c9b80cedb1d84fdc3399dce815aa8106c781212c43bf61&width=1200&height=675&quality=70&focal=687%2C305&smart=false	2025-04-18 00:00:00
210	0	15	NewsAPI	A Lifetime In Red And White: The Lindisfarne Liturgies (part two)	Lars Knutsen and John Wilson have been Sunderland fans for decades, so when they met up at Holy Island to talk all things red and white, the conversation was filled with memorable moments, superb players and iconic moments!	Lars Knutsen and John Wilson have been Sunderland fans for decades, so when they met up at Holy Island to talk all things red and white, the conversation was filled with memorable moments, superb pla… [+12679 chars]	https://rokerreport.sbnation.com/2025/5/8/24425329/a-lifetime-in-red-and-white-the-lindisfarne-liturgies-part-two	https://cdn.vox-cdn.com/thumbor/IeHhdY74CsTGLnVyEz6ibYIKrJM=/0x0:1080x565/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/25985298/Lindisfarne.jpg	2025-05-08 04:48:10
211	0	15	NewsDATA	Calls for study into exodus of sixth form students from Powys	There are calls for research into why so many Powys school pupils are leaving the county to continue their sixth form education.	ONLY AVAILABLE IN PAID PLANS	https://www.countytimes.co.uk/news/25164136.study-needed-sixth-form-student-exodus-powys/	https://www.countytimes.co.uk/resources/images/19227629/?htype=0&type=app	2025-05-18 11:00:00
213	0	15	NewsDATA	Women make for 35 pc STEM graduates globally maths gender stereotypes major reasons UNESCO	New Delhi, May 18 (PTI) Women make for only 35 per cent of Science, Technology, Engineering and Mathematics (STEM) graduates	ONLY AVAILABLE IN PAID PLANS	https://www.theweek.in/wire-updates/national/2025/05/18/del20-edu-unesco-stem-stereotypes.html	https://www.theweek.in/content/dam/week/wire-updates/pti-preview-theweek.jpg	2025-05-18 09:15:13
214	0	15	NewsDATA	Women make for 35 pc STEM graduates globally; maths, gender stereotypes major reasons:UNESCO	Women make for 35 pc STEM graduates globally; maths, gender stereotypes major reasons:UNESCO	ONLY AVAILABLE IN PAID PLANS	https://www.hindustantimes.com/education/news/women-make-for-35-pc-stem-graduates-globally-maths-gender-stereotypes-major-reasonsunesco-101747559036203.html	https://www.hindustantimes.com/ht-img/img/2024/04/16/1600x900/Education_News_1713261190070_1713261190358.jpg	2025-05-18 09:03:55
215	0	15	NewsDATA	Derry Area principal tapped to fill administrative vacancy at Greensburg Salem	Derry Area High School Principal Kara Gardner will serve as Greensburg Salem’s first assistant superintendent, filling a gap left by the resignation of the district’s human resources director earlier this year.	ONLY AVAILABLE IN PAID PLANS	https://triblive.com/local/westmoreland/derry-area-principal-tapped-to-fill-administrative-vacancy-at-greensburg-salem/	https://assets-varnish.triblive.com/2025/05/8509078_web1_gtr-GSAdmin01_WEB.jpg	2025-05-18 09:01:00
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
72	1	1
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
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, topic_id, text, keywords, "order") FROM stdin;
1	1	How do supply-side bottlenecks interact with monetary policy to influence current inflationary pressures?	side bottlenecks interact, monetary policy, supply	0
2	1	What are the distributional effects of current inflation rates across different income percentiles?	distributional effects	1
3	1	To what extent are current inflation expectations de-anchored, and what policy tools can re-anchor them?	policy tools, extent, anchored, anchor	2
4	2	How can we effectively integrate climate models with regional environmental management strategies?		0
5	2	What are the most ecologically sound methods for large-scale carbon sequestration?	scale carbon sequestration, ecologically sound methods, large	1
6	2	How will changing climate patterns affect the spread of invasive species and ecosystem resilience?	invasive species, ecosystem resilience, spread	2
7	3	How can we formally verify the safety and reliability of complex AI systems?	complex ai systems, formally verify, safety, reliability	0
8	3	What are the fundamental limits of current AI architectures regarding general intelligence?	fundamental limits	1
9	3	How can we develop AI algorithms that are both efficient and environmentally sustainable?	develop ai algorithms, environmentally sustainable, efficient	2
10	4	How can we better address systemic biases impacting patient care and outcomes?	outcomes	0
11	4	What innovative technologies can truly alleviate physician burnout and improve patient interactions?	improve patient interactions, innovative technologies	1
12	4	How can healthcare prioritize preventative medicine to reduce chronic disease burden?		2
13	5	How can we better address diverse learning needs within limited classroom resources?		0
14	5	What innovative teaching methods effectively engage students in a rapidly changing world?	rapidly changing world	1
15	5	How can teacher well-being be prioritized to improve educator retention and student outcomes?	improve educator retention, teacher well, student outcomes, prioritized	2
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
1	Inflation	Economist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T230856Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=8ec8f21641a91d55ee9133619da4f0e169649e7513a970a41f7bc273e3b827f5,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T230857Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4ace72c463e30716a13788076e998ae8fec57b80857d5313e38f68ba0a0f9c9d,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_1_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T230858Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fd06ad31e046ea276b7c3cc29540e428776b3b8bac8af098cf30e7f182278cc1}
2	Climate Change	Environmental Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T230922Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=4fe85515ba788995e12908d2ca1e2e15f6000a36c3dc23341facc67c4d98cde2,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T230924Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f8d59394b7c5ff659458271087aa4eabd693d47ed1eed6facf299f78b8d5dd5b,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_2_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T230925Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=bb58c59f57472230b96d7c26b56a856636df358ad314e09c2038888a8a576ef6}
3	Artificial Intelligence	Computer Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231001Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=7688b48d70998d44952e1b7bf467b0b1695cabd7b61f4c1836db9ff7ae1a78f5,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231003Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=5686f3b981732cdf3756e463f6dfd2a56b962646b509a270fbb618f690027dd3,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_3_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231004Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9dde87121a90f619ebbe7d67d4187765b79a62b386bae5f8698aa91f3976dd18}
4	Healthcare	Doctor	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231046Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=54d6cbd1abaedcf2e7179c612a29b58087bc08d1cade897c9fd16867f4bd0a3a,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231047Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b91d151014ab14973c4555ac0dea031c4bfc5b0fc10062db64f6ee48281a4dab,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_4_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231048Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ec0fcd9875123690df09d06a9994e4a8bab7bbce5b35b3b56399ad727a91f375}
5	Education	Teacher	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231234Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=09f684989283c28656e8b445d4d7a76426cff0a0e93f13992db3ff50c557621e,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231240Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9c4f45854648496bb56f72ffc841c24f0bcbf514bcaf65c31e87943dc0316564,https://s3.us-east-2.amazonaws.com/newsroom.bucket/topic_5_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250518%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250518T231244Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=c4d832b385c309f0f3da3f745a32e69d6d99f7457a5a821f8af30303655331f7}
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password_hash, created_at, is_active) FROM stdin;
1	will	wfotso21@gmail.com	scrypt:32768:8:1$UbIimXbCm0GXWVPc$8c3c84c0893d1188a0b289a927ae74eca47531d1644804c5c59619ab6953a94a4b0d90f91d1625e28a8ba8aadafc30b8e1f6dc4cf2ca1d383c36052b741928a1	2025-05-18 21:55:07.147476	t
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videos (id, question_id, youtube_id, description, thumbnail) FROM stdin;
1	1	a2azB2eag5I	In this video I explain the most important graph in your macroeconomics class. The aggregate demand and supply model.	https://i.ytimg.com/vi/a2azB2eag5I/hqdefault.jpg
2	1	R8VBRCs2jTU	When central banks raise interest rates, the impact is felt far and wide. Mortgages become more expensive, house prices might fall ...	https://i.ytimg.com/vi/R8VBRCs2jTU/hqdefault.jpg
3	1	Ivf6MlAJfq0	Inflation, or the general increase in prices and fall in the purchasing power of money, can be caused by a mix of factors, including ...	https://i.ytimg.com/vi/Ivf6MlAJfq0/hqdefault.jpg
4	1	BHw4NStQsT8	If you're ever put in charge of a national economy, there are a few things you should try to avoid. Before you laugh, just remember, ...	https://i.ytimg.com/vi/BHw4NStQsT8/hqdefault.jpg
5	1	UvRlKWfTR4o	Policies to Reduce Inflation (Demand Pull, Cost Push) - With Evaluation For Products, Services and Bookings visit ...	https://i.ytimg.com/vi/UvRlKWfTR4o/hqdefault.jpg
6	2	HQ-Kg_xgdhE	Inflation is one of the most important concepts in economics. It's also one of the simplest. It's just the average rate that prices are ...	https://i.ytimg.com/vi/HQ-Kg_xgdhE/hqdefault.jpg
7	2	R8VBRCs2jTU	When central banks raise interest rates, the impact is felt far and wide. Mortgages become more expensive, house prices might fall ...	https://i.ytimg.com/vi/R8VBRCs2jTU/hqdefault.jpg
8	2	rfp_5g7yrTs	Subscribe for More ❤️ #inflation #explained #explainer #explainervideo #economics #unitedstatesofamerica #unitedstates ...	https://i.ytimg.com/vi/rfp_5g7yrTs/hqdefault.jpg
9	3	R8VBRCs2jTU	When central banks raise interest rates, the impact is felt far and wide. Mortgages become more expensive, house prices might fall ...	https://i.ytimg.com/vi/R8VBRCs2jTU/hqdefault.jpg
10	3	bv-uNNkE39I	In this video I overview fiscal and monetary policy and how the economy adjust in the long run. Keep in mind that fiscal and ...	https://i.ytimg.com/vi/bv-uNNkE39I/hqdefault.jpg
11	3	rfp_5g7yrTs	Subscribe for More ❤️ #inflation #explained #explainer #explainervideo #economics #unitedstatesofamerica #unitedstates ...	https://i.ytimg.com/vi/rfp_5g7yrTs/hqdefault.jpg
12	3	AkMsMDk_brU	The Federal Reserve's main tool for managing the economy is to change the federal funds rate, which can affect not only ...	https://i.ytimg.com/vi/AkMsMDk_brU/hqdefault.jpg
13	4	yy3VK6OYBbU	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/yy3VK6OYBbU/hqdefault.jpg
14	4	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
15	4	G4H1N_yXBiA	What causes climate change (also known as global warming)? And what are the effects of climate change? Learn the human ...	https://i.ytimg.com/vi/G4H1N_yXBiA/hqdefault.jpg
16	4	RoIpCJwX7-M	PBS Member Stations rely on viewers like you. To support your local station, go to: http://to.pbs.org/DonateMESS ↓ More info and ...	https://i.ytimg.com/vi/RoIpCJwX7-M/hqdefault.jpg
17	4	N6t6QHQtdVw	Climate | How To Keep The Environment Safe? | Global Warming | Climate Change | What Causes Global Warming?	https://i.ytimg.com/vi/N6t6QHQtdVw/hqdefault.jpg
18	5	uuayrvIFi0E	This could be the biggest climate savior. ‍♀️ But how does it work and what are the downsides?#dwplaneta #carboncapture ...	https://i.ytimg.com/vi/uuayrvIFi0E/hqdefault.jpg
19	5	i4OhynhiZfg	In this video, we'll explore the topic of carbon sequestration, a process that can help mitigate climate change by capturing and ...	https://i.ytimg.com/vi/i4OhynhiZfg/hqdefault.jpg
20	5	4UQy8z7B_Wg	and can we remove CO2 from cement production?	https://i.ytimg.com/vi/4UQy8z7B_Wg/hqdefault.jpg
21	5	8NqJIueEBSY	Why do we need carbon capture and storage? Because CCS will be a key technology in managing the risks of climate change.	https://i.ytimg.com/vi/8NqJIueEBSY/hqdefault.jpg
22	5	GC54Y8zXXl4	Friday June 4, 2021 3:00 to 4:00 PM (eastern) This webinar will review the current science on forest carbon sequestration, ...	https://i.ytimg.com/vi/GC54Y8zXXl4/hqdefault.jpg
23	6	K6VccsFmr7w	Invasive species have cost the world more than €612 billion over the last 50 years. A research published in the Science for ...	https://i.ytimg.com/vi/K6VccsFmr7w/hqdefault.jpg
24	6	4Gybahk9YYA	Title: Biodiversity as a metric of ecosystem resilience to climate change Presenter: Helen Poulos, PhD Date: March 13th, 2014 at ...	https://i.ytimg.com/vi/4Gybahk9YYA/hqdefault.jpg
25	6	tRNknyggvUY	Invasive species are silently destroying the Pacific. Rats, weeds, and invasive trees like Albizia falcataria are threatening native ...	https://i.ytimg.com/vi/tRNknyggvUY/hqdefault.jpg
26	6	msbVR16-D6M	Dr. Nicola Smith March 3, 2023.	https://i.ytimg.com/vi/msbVR16-D6M/hqdefault.jpg
27	7	vQ0fiBR9VbA	An overview of formal verification methods: mathematical techniques used to rigorously prove the correctness, safety, and ...	https://i.ytimg.com/vi/vQ0fiBR9VbA/hqdefault.jpg
28	7	4RixMPF4xis	Learn more about watsonx: https://ibm.biz/BdvxDS What is really the difference between Artificial intelligence (AI) and machine ...	https://i.ytimg.com/vi/4RixMPF4xis/hqdefault.jpg
29	7	ULKC4NISWE4	Recorded live on twitch, GET IN ### My Stream https://twitch.tv/ThePrimeagen ### Best Way To Support Me Become a backend ...	https://i.ytimg.com/vi/ULKC4NISWE4/hqdefault.jpg
30	7	ad79nYk2keg	Artificial Intelligence Engineer (IBM) ...	https://i.ytimg.com/vi/ad79nYk2keg/hqdefault.jpg
31	7	T0eWBlFhFzc	Check out Lambda here and sign up for their GPU Cloud: https://lambda.ai/papers Guide for using DeepSeek on Lambda: ...	https://i.ytimg.com/vi/T0eWBlFhFzc/hqdefault.jpg
32	8	qYNweeDHiyU	Want to learn about AI agents and assistants? Register for Virtual Agents Day here → https://ibm.biz/BdaAVa Want to play with the ...	https://i.ytimg.com/vi/qYNweeDHiyU/hqdefault.jpg
33	8	ad79nYk2keg	Artificial Intelligence Engineer (IBM) ...	https://i.ytimg.com/vi/ad79nYk2keg/hqdefault.jpg
34	8	4RixMPF4xis	Learn more about watsonx: https://ibm.biz/BdvxDS What is really the difference between Artificial intelligence (AI) and machine ...	https://i.ytimg.com/vi/4RixMPF4xis/hqdefault.jpg
35	8	z-EtmaFJieY	So we've talked a lot in this series about how computers fetch and display data, but how do they make decisions on this data?	https://i.ytimg.com/vi/z-EtmaFJieY/hqdefault.jpg
36	9	8hRujrzEfJk	Unlock the secrets of **Neural Network Optimization**! Join us as we explore the fascinating parallels between neural networks ...	https://i.ytimg.com/vi/8hRujrzEfJk/hqdefault.jpg
37	9	hW0nJLU5FN0	A look into how AI-driven innovations are revolutionizing sustainable business practices in 2024. #AI #Sustainability ...	https://i.ytimg.com/vi/hW0nJLU5FN0/hqdefault.jpg
38	9	J4kwRYDrDdI	Explore how AI is revolutionizing the design of renewable materials with advanced computational models, expert insights, and ...	https://i.ytimg.com/vi/J4kwRYDrDdI/hqdefault.jpg
39	9	4RixMPF4xis	Learn more about watsonx: https://ibm.biz/BdvxDS What is really the difference between Artificial intelligence (AI) and machine ...	https://i.ytimg.com/vi/4RixMPF4xis/hqdefault.jpg
40	9	-KpS2pRV6dY	Don't forget to subscribe it will be stupendous of you.	https://i.ytimg.com/vi/-KpS2pRV6dY/hqdefault.jpg
41	10	ghci7IW3W4Y	Watch the full interview here: https://www.youtube.com/watch?v=j7RqO4DfV5A&t=2170s I'll teach you how to become to media's ...	https://i.ytimg.com/vi/ghci7IW3W4Y/hqdefault.jpg
42	11	qetKUFDDF4A	Doctors at the University of Florida Health Center are using artificial intelligence to help monitor their patients. The findings will ...	https://i.ytimg.com/vi/qetKUFDDF4A/hqdefault.jpg
43	11	ctcjLYhNDEk	See how NextGen Ambient Assist is transforming the way patients and doctors connect! In this testimonial, real healthcare ...	https://i.ytimg.com/vi/ctcjLYhNDEk/hqdefault.jpg
44	11	uvqDTbusdUU	Artificial intelligence has the ability to revolutionise and personalise targeted healthcare for individual patients. The regulatory ...	https://i.ytimg.com/vi/uvqDTbusdUU/hqdefault.jpg
45	11	lQkfD8vVoeU	Join us in cheering for Doğa Özdengülsün from Turkey, representing Europe in the 2024 GSEA Global Semi-Finals! Doğa is ...	https://i.ytimg.com/vi/lQkfD8vVoeU/hqdefault.jpg
46	11	7zk_AJBO60Y	How do we find verification in complex fields, such as medicine? Does our affirmative knowledge derive from vast statistics and ...	https://i.ytimg.com/vi/7zk_AJBO60Y/hqdefault.jpg
47	12	ghci7IW3W4Y	Watch the full interview here: https://www.youtube.com/watch?v=j7RqO4DfV5A&t=2170s I'll teach you how to become to media's ...	https://i.ytimg.com/vi/ghci7IW3W4Y/hqdefault.jpg
48	13	diFrz4RENEY	In this talk, Gregory Chahrozian delves into the profound impact of teachers and explores how their character and qualities have ...	https://i.ytimg.com/vi/diFrz4RENEY/hqdefault.jpg
49	13	0IcrxnfuhuU	Looking for a smart interactive board for your classroom? The Studynlearn Interactive Flat Panel is an excellent choice! It's like ...	https://i.ytimg.com/vi/0IcrxnfuhuU/hqdefault.jpg
50	14	v2zl4eSM0GA	Education is going digital. This inevitable transition has been further propelled by the current pandemic. While it solves many ...	https://i.ytimg.com/vi/v2zl4eSM0GA/hqdefault.jpg
51	14	ZQKRRUupIxk	On October 4, Brookings co-hosted a panel discussion on Education and Learning for a changing world. The event opened with a ...	https://i.ytimg.com/vi/ZQKRRUupIxk/hqdefault.jpg
52	14	f14g0OG4mz0	Linda Darling-Hammond, one of the most influential people affecting educational policy in the United States, and professor ...	https://i.ytimg.com/vi/f14g0OG4mz0/hqdefault.jpg
53	14	haXhlEZwm5M	(Via kaylynlemaire/tt ) #teachers #teaching #school #sports #funny #highschool #studentlife #highschoolstudent #nike #crease ...	https://i.ytimg.com/vi/haXhlEZwm5M/hqdefault.jpg
54	15	k5MOA94rWkc	Shorts "Grades are just a number" is a product of unrealistic assessments more focused on numbers rather than real learning ...	https://i.ytimg.com/vi/k5MOA94rWkc/hqdefault.jpg
55	15	YM4nFnbSwDg	What is your district doing to improve the overall work environment for your educator workforce? With staff shortages continuing to ...	https://i.ytimg.com/vi/YM4nFnbSwDg/hqdefault.jpg
56	15	UCFg9bcW7Bk	Collaboration. Communication. Critical thinking. Creativity. - Should be present in all classrooms. Joe Ruhl received his bachelors ...	https://i.ytimg.com/vi/UCFg9bcW7Bk/hqdefault.jpg
57	15	HX_Q5c0i51I	In this video Faisal Nadeem shared 10 teacher duties and responsibilities or teacher roles and responsibilities or class teacher ...	https://i.ytimg.com/vi/HX_Q5c0i51I/hqdefault.jpg
58	15	KVLTxKyxioA	Scientific evidence suggests that the secret to thriving students and a good education are amazing teachers. To teach with us, gift ...	https://i.ytimg.com/vi/KVLTxKyxioA/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 215, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 1, true);


--
-- Name: fav_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_videos_id_seq', 2, true);


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

SELECT pg_catalog.setval('public.hidden_videos_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videos_id_seq', 58, true);


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
-- PostgreSQL database dump complete
--

