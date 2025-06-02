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
1	0	1	NewsAPI	Prof. Schlevogt’s Compass No. 15: Kakistocratic defense splurgers destroy Europe	Eighty years after WW II, EU leaders are approving huge budgets to solve a self-made security problem. Yet the silver bullets are defective Read Full Article at RT.com	It has been said that quantity has quality all of its own.\r\nThe origins of this dictum, which is often attributed to Soviet leader Joseph Stalin, can be traced back to ancient dialecticians. They arg… [+34476 chars]	https://www.rt.com/news/617535-defence-splurgers-destroy-europe/	https://mf.b37mrtl.ru/files/2025.05/article/6824bc4a2030274d231eb22c.jpg	2025-05-14 16:00:23
2	0	1	NewsDATA	Tinubu @ 2: Awaiting gains of disruptive economic reforms	By Chinwendu Obienyi When President Bola Tinubu mounted the saddle on May 29, 2023, he launched sweeping reforms touted as necessary reset initiatives that will usher in economic renewal. Two years on, families have tightened their belts, many businesses are on ventilators and anxiety thickens as Nigerians await the dividends of the economic reset loosely [...]The post Tinubu @ 2: Awaiting gains of disruptive economic reforms appeared first on The Sun Nigeria.	ONLY AVAILABLE IN PAID PLANS	https://thesun.ng/tinubu-2-awaiting-gains-of-disruptive-economic-reforms/	https://d1jcea4y7xhp7l.cloudfront.net/wp-content/uploads/2025/02/Tinubus-2.jpg	2025-05-27 04:11:56
3	0	1	NewsDATA	Global unease, local momentum: Nigeria holds steady amid Q1 global headwinds	As 2025 opened, it became quickly apparent that the global economy was entering yet another period of uncertainty. The familiarread more Global unease, local momentum: Nigeria holds steady amid Q1 global headwinds	ONLY AVAILABLE IN PAID PLANS	https://businessday.ng/backpage/article/global-unease-local-momentum-nigeria-holds-steady-amid-q1-global-headwinds/	https://cdn.businessday.ng/wp-content/uploads/2025/04/Oluyemi-Adeosun.png	2025-05-26 05:10:33
4	0.089	2	NewsAPI	Prices are falling on some purchases. 'Enjoy,' economist says: 'They're not here to stay'	Even though inflation hasn’t yet declined to policymakers’ target level, some pockets of the U.S. economy have seen prices fall recently.	Even though inflation hasnt yet declined to policymakers target level, some pockets of the U.S. economy have seen prices fall recently.\r\nConsumers have seen prices deflate for airfare, produce, house… [+5904 chars]	https://www.nbcnews.com/business/business-news/prices-are-falling-purchases-enjoy-economist-says-not-stay-rcna205169	https://media-cldnry.s-nbcnews.com/image/upload/t_nbcnews-fp-1200-630,f_auto,q_auto:best/rockcms/2025-04/250408-gas-pump-vl-928a-0a9eac.jpg	2025-05-06 18:30:56
5	0.089	2	NewsAPI	Walmart helped keep America's prices low for decades. Now it's leading them higher	Walmart (WMT) has acted as a deflationary force in the U.S. economy for decades, using its massive scale and supply chain dominance — especially with low-cost Chinese manufacturing — to push prices down across retail. By demanding rock-bottom prices from supp…	Walmart (WMT) has acted as a deflationary force in the U.S. economy for decades, using its massive scale and supply chain dominance especially with low-cost Chinese manufacturing to push prices down … [+2811 chars]	https://qz.com/walmart-prices-inflation-tariffs-retail-1851780979	https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/1dd2b1a4580fe76dc3536b17bdeeff34.jpg	2025-05-16 12:48:27
6	0	2	NewsAPI	Fed Plans to Pause Interest Rate Cuts, Again. Here's Why You Should Care	Tariffs are threatening higher inflation, and that's putting pressure on the Fed to keep borrowing costs high.	The central bank is widely expected to keep its benchmark interest rate at a range of 4.25% to 4.5%. \r\nWong Yu Liang/Getty Images\r\nInterest rates aren't likely to budge today. You can blame tariffs. … [+7075 chars]	https://www.cnet.com/personal-finance/banking/fed-plans-to-pause-interest-rate-cuts-again-heres-why-you-should-care/	https://www.cnet.com/a/img/resize/b51fc97107eacaa37e07e1f0aebdfbfe2ac07a6b/hub/2025/05/06/dd331980-aa87-4113-b35d-79a33b62424f/gettyimages-1412799407.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-07 12:00:00
7	0	2	NewsAPI	Stagflation Is the Economy's Sleeping Bear. Trump's Tariffs Could Wake It, Experts Warn	Trump’s sweeping tariffs risk a brutal combination of an economic slowdown and high inflation.	Stagflation can be worse than a recession. Investors are already bracing for it. \r\nGetty Images/ DNY59/ Jeffrey Hazelwood\r\nRecessions are scary. Stagflation, a combination of stagnating growth and hi… [+11297 chars]	https://www.cnet.com/personal-finance/banking/stagflation-is-the-economys-sleeping-bear-trumps-tariffs-could-wake-it-experts-warn/	https://www.cnet.com/a/img/resize/a3ae64dacada0cdc4142d3982c1df8686a84c089/hub/2025/05/14/77b99e90-d1a2-430a-b134-05d6845b5bcc/image-9.png?auto=webp&fit=crop&height=675&width=1200	2025-05-20 18:00:00
8	0	2	NewsAPI	Mortgage Rate Forecast for May: Can Rates Fall Without Fed Cuts?	The Fed is weighing inflation, recession indicators and uncertain trade policies. Here's how that impacts mortgage rates.	Mortgage rates can change daily and even hourly. \r\nTharon Green/CNET\r\nLong-term housing market predictions have been clouded by economic uncertainty under the Trump administration's trade and austeri… [+4765 chars]	https://www.cnet.com/personal-finance/mortgages/mortgage-rate-forecast-for-may-can-rates-fall-without-fed-cuts/	https://www.cnet.com/a/img/resize/78ddbce576110573dc7cd74ab42f4e379e822467/hub/2024/09/18/11edb036-100c-4588-bd0d-aadf10564429/weekly-mortgage-predictions-2.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-05 18:40:00
9	0	2	NewsAPI	Fed Meeting Keeps Interest Rates High. Here's Why That's a Big Deal for Your Finances	Uncertainty about the economic outlook has increased further, according to the central bank.	The central bank kept its benchmark interest rate at a range of 4.25% to 4.5%. \r\nWong Yu Liang/Getty Images\r\nAs expected, interest rates didn't budge today. You can blame tariffs. \r\nAt the conclusion… [+7118 chars]	https://www.cnet.com/personal-finance/banking/fed-meeting-keeps-interest-rates-high-heres-why-thats-a-big-deal-for-your-finances/	https://www.cnet.com/a/img/resize/b51fc97107eacaa37e07e1f0aebdfbfe2ac07a6b/hub/2025/05/06/dd331980-aa87-4113-b35d-79a33b62424f/gettyimages-1412799407.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-07 18:30:00
10	0	2	NewsAPI	Trump's second-term economy is defined by one word: uncertainty. These charts show how.	Tuesday marks Donald Trump's 100th day as president. BI examined how Americans feel about the economy, stocks, inflation, and tariffs.	Getty Images; Jenny Chang-Rodriguez/BI\r\n<ul><li>President Donald Trump's first 100 days have been full of economic activity, from tariffs to federal firings.</li><li>While much of this hasn't yet sho… [+11627 chars]	https://www.businessinsider.com/donald-trump-100th-day-inflation-economy-tariffs-markets-stocks-businesses-2025-4	https://i.insider.com/6802a2b5c6ad288d147e9a63?width=1200&format=jpeg	2025-04-29 08:00:02
11	0	2	NewsAPI	Stagflation or Recession: With Tariffs on Pause, Is the Economy Really OK?	With Trump's trade war, economic forecasts are changing every day.	Stagflation can be worse than a recession. Investors are already bracing for it. \r\nGetty Images/ DNY59/ Jeffrey Hazelwood\r\nEven if you haven't lived through a major recession, it's scary to think abo… [+11059 chars]	https://www.cnet.com/personal-finance/banking/stagflation-or-recession-with-tariffs-on-pause-is-the-economy-really-ok/	https://www.cnet.com/a/img/resize/a3ae64dacada0cdc4142d3982c1df8686a84c089/hub/2025/05/14/77b99e90-d1a2-430a-b134-05d6845b5bcc/image-9.png?auto=webp&fit=crop&height=675&width=1200	2025-05-15 11:00:00
12	0	2	NewsAPI	Gold is booming – but how safe is it for investors, really?	Trade wars and volatile markets have contributed to a gold rush, but investors shouldn't put all their eggs in this one basket, warn experts	Listen to Theo read this article\r\n"What you have there is about £250,000 worth of gold," Emma Siebenborn says as she shows me a faded plastic tub filled with old, shabby jewellery - rings, charm brac… [+12550 chars]	https://www.bbc.com/news/articles/c5ygyjy7kz5o	https://ichef.bbci.co.uk/news/1024/branded_news/aae4/live/82babf60-2be4-11f0-8f57-b7237f6a66e6.png	2025-05-13 01:02:20
13	0	2	NewsAPI	Eggs are finally getting cheaper as prices sink the most since 1984	Egg prices tumbled about 13% in April over the month, the steepest fall since 1984.	The eggs index dropped about 13% in April from March, the fifth-largest decline on record.Justin Sullivan/Getty Images\r\n<ul><li>Egg prices fell over the month in April by about 13%, the biggest decli… [+2589 chars]	https://www.businessinsider.com/eggs-getting-cheaper-consumer-grocery-prices-inflation-2025-5	https://i.insider.com/68234bbd68a2929008012353?width=1200&format=jpeg	2025-05-13 16:16:26
14	0	2	NewsAPI	100 days into Trump's economy, one thing's clear: Americans are worried	BI examined sentiment data, markets chaos, and interviews with small business owners, consumers, and economists. They point toward one thing.	SAUL LOEB/AFP via Getty Images\r\n<ul><li>This post originally appeared in the Business Insider Today newsletter.</li><li>You can sign up for Business Insider's daily newsletter here.</li></ul>Good mor… [+6422 chars]	https://www.businessinsider.com/100-days-trump-economy-drama-uncertainty-stagflation-consumers-tariffs-2025-4	https://i.insider.com/6810d318c6ad288d147f69dd?width=1200&format=jpeg	2025-04-29 13:58:35
15	0	2	NewsAPI	Inflation is dropping but these prices are still soaring	Prices are rising rapidly for some everyday items like coffee and beef.	Inflation cooled in the aftermath of President Donald Trump's "Liberation Day" levies last month, dropping to a four-year low and defying fears of tariff-driven price hikes, government data this week… [+3970 chars]	https://abcnews.go.com/Business/inflation-dropping-prices-soaring/story?id=121788934	https://i.abcnewsfe.com/a/c2bd2c1c-210f-43cd-909a-20bc9a21ba83/grocery-gty-er-250514_1747253888714_hpMain_16x9.jpg?w=1600	2025-05-15 09:26:43
16	0	2	NewsAPI	JPMorgan cuts the chance of a US recession after Trump and China's tariff truce — but risks remain	JPMorgan is walking back its 60% recession prediction for 2025 following the 90-day pause on trade tariffs agreed by China and the US.	JPMorgan says recession risks remain "elevated."Dado Ruvic/REUTERS\r\n<ul><li>JPMorgan revised its recession forecast after President Donald Trump's tariff truce with China.</li><li>Trump and China agr… [+2732 chars]	https://www.businessinsider.com/jpmorgan-us-recession-prediction-trump-china-tariff-truce-2025-5	https://i.insider.com/6823e0f168a2929008013c4d?width=1200&format=jpeg	2025-05-14 08:17:44
17	0	2	NewsAPI	Trump claims grocery and gas prices are falling. Experts say that's misleading	"Prices are still going up," one expert said.	President Donald Trump on Friday claimed grocery and gas prices are falling, an assertion he's made repeatedly since taking office.\r\nIn a post on social media, Trump touted the price levels alongside… [+4648 chars]	https://abcnews.go.com/Business/trump-claims-grocery-gas-prices-falling-experts-misleading/story?id=121410734	https://i.abcnewsfe.com/a/bd55a8b0-dcda-45ea-8841-ee3540f97222/grocery-rt-er-250502_1746214585130_hpMain_16x9.jpg?w=1600	2025-05-03 13:24:00
18	0	2	NewsAPI	Walmart says higher prices from tariffs coming as soon as this month	The world's largest retailer says it won't be able to absorb all the costs from higher tariffs on imported goods, particularly from China. Already in April, shoppers began tightening their budgets as retail spending did not grow much compared to March.	Walmart says U.S. tariffs on imports from China and other countries will force the retail giant to begin raising some prices as soon as this month.\r\nThe company's CEO Doug McMillon said Thursday many… [+2743 chars]	https://www.npr.org/2025/05/15/nx-s1-5399154/walmart-higher-prices-tariffs	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+281/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F36%2F6e%2F9825658842ab9a1bc7d2c3d1dbdd%2Fap24296792872922.jpg	2025-05-15 13:52:05
19	0	2	NewsAPI	Worried about a recession? Start rooting for the rich.	Spending by rich Americans is fueling the economy. And if they pull back, it could help push the US into recession.	Getty images; Tyler Le/BI\r\nMoney may not buy happiness, but it does buy stuff. And buying stuff is at the heart of our consumer-driven economic engine. Lately, it's wealthier people, in particular, w… [+8436 chars]	https://www.businessinsider.com/wealthy-economic-growth-gdp-income-spending-recession-stock-market-crash-2025-5	https://i.insider.com/68190ebc3fe8d3928364f5f0?width=1200&format=jpeg	2025-05-06 08:07:01
20	0	2	NewsAPI	Fed Plans to Hold Rates Steady as Tariffs Threaten Higher Inflation. Yes, That Matters	Here are all the ways your finances will be affected by the Fed's interest rate meeting tomorrow.	The central bank is widely expected to keep its benchmark interest rate at a range of 4.25% to 4.5%. \r\nWong Yu Liang/Getty Images\r\nInterest rates aren't likely to budge anytime soon. You can blame ta… [+7282 chars]	https://www.cnet.com/personal-finance/banking/fed-plans-to-hold-rates-steady-as-tariffs-threaten-higher-inflation-yes-that-matters/	https://www.cnet.com/a/img/resize/b51fc97107eacaa37e07e1f0aebdfbfe2ac07a6b/hub/2025/05/06/dd331980-aa87-4113-b35d-79a33b62424f/gettyimages-1412799407.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-06 17:20:58
21	0	2	NewsAPI	Mortgage Forecast: Tariffs Paused, Fed on Hold, What's Next for Rates in May?	The direction of mortgage rates hinges on Trump's tariff agenda, the Fed and the financial markets.	Mortgage rates can change daily and even hourly. \r\nTharon Green/CNET\r\nMortgage rates are being influenced by headlines about ongoing trade negotiations, the path of inflation and shifting expectation… [+5153 chars]	https://www.cnet.com/personal-finance/mortgages/mortgage-forecast-tariffs-paused-fed-on-hold-whats-next-for-rates-in-may/	https://www.cnet.com/a/img/resize/27c21aabdaf21bc6fd1e86e53460fd518c98f558/hub/2024/07/29/5090ba2f-9272-47a1-8cdf-a914b00cd178/weekly-mortgage-predictions-4.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-16 13:07:00
22	0	2	NewsAPI	The Fed Isn't About to Cut Interest Rates. Here's What That Means for Your Finances	Despite broad concerns of an economic slowdown, the central bank isn't in a rush to reduce borrowing rates.	Financing a car, taking out a home loan and paying down credit card debt? Borrowing costs are still expensive in 2025. After the Federal Reserve cut interest rates three times last year, many of us h… [+6886 chars]	https://www.cnet.com/personal-finance/banking/the-fed-isnt-about-to-cut-interest-rates-heres-what-that-means-for-your-finances/	https://www.cnet.com/a/img/resize/7d27324fd7b1f48f088fddccaa3b204dfc35493c/hub/2024/08/05/bc53700b-a2c3-4a54-900f-e5ead2ce2d0a/fed-interest-rate.jpg?auto=webp&fit=crop&height=675&width=1200	2025-05-05 16:30:12
23	0	2	NewsAPI	Japan faces a ‘rice crisis’ as price nearly doubles for food staple	The price of Japanese-grown rice is soaring due to high inflation, low farm yields and a growing tourism sector.	Japan is facing a rice crisis as the price of its favourite staple food has nearly doubled over the past year amid rising inflation and supply shortages.\r\nGovernment data released on Friday shows the… [+3438 chars]	https://www.aljazeera.com/news/2025/5/23/japan-faces-a-rice-crisis-as-price-nearly-doubles-for-food-staple	https://www.aljazeera.com/wp-content/uploads/2025/05/2025-04-16T230210Z_2081171420_RC2EXDA28YZB_RTRMADP_3_JAPAN-USA-RICE-1747976563_4b4856-1747978844.jpg?resize=1200%2C630&quality=80	2025-05-23 08:00:07
24	0.247	4	NewsAPI	Increasing Weather Risks Demand A Longer View Of The Forecast	Businesses are increasingly depending on long-range weather forecasts to manage risks and supply chain disruptions.	Long-range forecasting is growing in importance and accuracy. Using seasonal forecasts like this ... More 2025 summer forecast helps businesses and communities better plan and respond.\r\nDTN\r\nWith the… [+6497 chars]	https://www.forbes.com/sites/jimfoerster/2025/04/28/increasing-weather-risks-demand-a-longer-view-of-the-forecast/	https://imageio.forbes.com/specials-images/imageserve/680f747b2f35b4b453a921b5/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 12:37:25
25	0.16	4	NewsAPI	Faked data? Met Office’s data gaps raise questions over climate crisis claims	The Met Office cannot identify the sources of temperature data for 103 non-existent or defunct weather stations, undermining the reliability of its climate records. Independent investigations revealed cases like Scole (operational 1971-1980) reporting data fr…	<ul><li>The Met Office cannot identify the sources of temperature data for 103 non-existent or defunct weather stations, undermining the reliability of its climate records. Independent investigations… [+5620 chars]	https://www.naturalnews.com/2025-05-19-met-office-data-gaps-climate-crisis-claims.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/NOAA-global-warming-fake-science-data.jpg	2025-05-19 06:00:00
26	0.16	4	NewsAPI	The Met Office is Unable to Name the Sites Providing ‘Estimated’ Temperature Data For its 103 Non-Existent Stations	The data identified individual stations and single location coordinates, but when 103 were found not to exist the Met Office hastily rewrote the title of the database to suggest that the figures arose from a wider local area.	From THE DAILY SCEPTIC\r\nby Chris Morrison\r\nLast year the UK Met Office was shown to be inventing long-term temperature data at 103 non-existent weather stations. It was claimed in a later risible fac… [+5990 chars]	https://wattsupwiththat.com/2025/05/13/the-met-office-is-unable-to-name-the-sites-providing-estimated-temperature-data-for-its-103-non-existent-stations/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2024/04/uk-met-office-topaz.webp?fit=1024%2C512&ssl=1	2025-05-13 09:00:00
27	0.08	4	NewsAPI	Your weather forecast is about to get a lot worse	Did you check the weather forecast today?  Whether it was on your phone, the five-day outlook in your newspaper, or your friendly TV meteorologist, that forecast was built on a massive government-run network of sensors and computers that get the weather right…	An aerial view of severe flooding in Frankfort, Kentucky, caused by days of heavy rainfall across the Midwest on April 7, 2025.﻿\r\n\n\nDid you check the weather forecast today? \n\nWhether it was on your … [+8434 chars]	https://www.vox.com/climate/412458/weather-service-forecast-noaa-climate-flood-cuts	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/GettyImages-2208466891.jpg?quality=90&strip=all&crop=0%2C3.4613147178592%2C100%2C93.077370564282&w=1200	2025-05-09 20:11:53
28	0.08	4	NewsAPI	Trump cuts leave National Weather Service scrambling to issue weather warnings...	Trump cuts leave National Weather Service scrambling to issue weather warnings...\r\n\n \n \n \n (First column, 1st story, link)\r\n\n \r\n\n \r\n\n \n Related stories:Kentucky office had no overnight staff before deadly tornadoes hit...	Whether theyve scrambled to get approval to buy office supplies or fix plumbing, cover shifts during severe weather that lasted for days or get tornado damage surveys completed, its been a rough few … [+6784 chars]	https://www.usatoday.com/story/news/nation/2025/05/15/noaa-national-weather-service-will-move-people-to-fill-vacancies/83640852007/	https://www.gannett-cdn.com/authoring/authoring-images/2025/04/17/USAT/83134332007-usatsi-25947781.jpg?auto=webp&crop=5999,3375,x0,y312&format=pjpg&width=1200	2025-05-19 17:04:37
29	0.08	4	NewsAPI	Climate Change Weekly # 543 —Current Climate Conditions Aren’t Historically Extreme or Unusual, New Research Shows	Recently, a number of new studies and analyses have been published indicating what readers of CCW have long known: recent climate conditions are not historically unusual. An examination of long-term wildfire trends, plus research comparing past climate condit…	From THE HEARTLAND INSTITUTE\r\nBy H. Sterling Burnett\r\nRecently, a number of new studies and analyses have been published indicating what readers of CCW have long known: recent climate conditions are … [+13694 chars]	https://wattsupwiththat.com/2025/05/09/climate-change-weekly-543-current-climate-conditions-arent-historically-extreme-or-unusual-new-research-shows/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/CCW-543-big-image-3.webp?fit=1024%2C512&ssl=1	2025-05-10 01:00:00
30	0.08	4	NewsAPI	CNN’s Climate Con Exposed: Real Estate, Not Storms, Fuels Skyrocketing Insurance Costs	Wrongly scapegoating non-existent “climate risk” allows adjusters, insurers, and lenders justify higher premiums, interest rates, and stricter credit standards while diverting attention from the actual causes of rising mortgage costs and insurance rates and c…	In a recent article, titled Why climate risk could affect your credit score for buying a home, CNNs Andrew Freedman describes a new report by FirstStreet that claims to show how climate risk could im… [+7767 chars]	https://wattsupwiththat.com/2025/05/21/cnns-climate-con-how-real-estate-not-storms-drives-insurance-costs/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_aerial_miami_luxury_high_rises_midjourney.webp?fit=1024%2C512&ssl=1	2025-05-21 17:00:00
31	0.08	4	NewsAPI	Wrong, Phys.org, Climate Change Isn’t Causing a Rise in Lost School Days	This article is a textbook example of shoddy research dressed up as urgent policy insight. By stretching an already weak climate claim—about worsening cyclones—into an even more tenuous social consequence—missed school days—it commits the cardinal sin of scie…	In a recent editorial published by Phys.org, researchers claim that climate change is driving more powerful and frequent hurricanes, which in turn are causing widespread school closures labeling it a… [+4791 chars]	https://wattsupwiththat.com/2025/05/08/wrong-phys-org-climate-change-isnt-causing-a-rise-in-lost-school-days/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/midjourney_sora_Corrected-Spelling-Note_missed-school-.webp?fit=1024%2C511&ssl=1	2025-05-08 17:00:00
32	0.08	4	NewsAPI	Las Vegas Shatters Rainfall Record: 'Wettest May' Ever	Only seven days into the month, Las Vegas has already broken its monthly rainfall record by more than half an inch.	Las Vegas has already had its wettest May on record, only seven days into the month.\r\nWhy It Matters\r\nLas Vegas is known for its dry, desert climate. Heavy rain is not typical for May, as the Nevada … [+3120 chars]	https://www.newsweek.com/las-vegas-shatters-rainfall-record-wettest-may-2069171	https://d.newsweek.com/en/full/2640361/las-vegas-wettest-may-ever.jpg	2025-05-07 17:42:31
33	0.08	4	NewsAPI	More tornadoes and fewer meteorologists make for a dangerous mix that’s worrying US officials	The U.S. is on track to have its second-busiest tornado year ever.	By SETH BORENSTEIN, Associated Press Science Writer\r\nWASHINGTON (AP) As nasty tornadoes popped up from Kansas to Kentucky, a depleted National Weather Service was in scramble mode.\r\nThe agencys offic… [+6305 chars]	https://www.bostonherald.com/2025/05/20/severe-weather-noaa-cuts/	https://www.bostonherald.com/wp-content/uploads/2025/05/APTOPIX_Severe_Weather_Kentucky_59646_538d6c-1.jpg?w=1024&h=768	2025-05-20 15:50:18
34	0.08	4	NewsAPI	What Deep Cuts to NOAA Mean for U.S. Fisheries	Schumann and Pesante harvest bluefish, dogfish, scup, and bonito using gillnets that they set daily at the mouth of the Narragansett Bay in Rhode Island Sound. “Our income and catch have dropped about 30 percent over the last four years,” Pesante told Civil E…	Meanwhile, theres greater need for research than ever, as warming ocean temperatures, driven by climate change, are shifting fish migration patterns and spawning behaviors. Warmer waters are also cau… [+7477 chars]	https://civileats.com/2025/05/15/what-the-downsizing-of-noaa-means-for-u-s-fisheries/	https://civileats.com/wp-content/uploads/2025/05/Point-Judith-RI.jpg	2025-05-15 08:00:59
35	0.08	4	NewsDATA	Weather forecasting improves with AI, but we still need humans	Advanced systems from Microsoft and Google are already outperforming traditional forecasting models. The post Weather forecasting improves with AI, but we still need humans appeared first on Popular Science.	ONLY AVAILABLE IN PAID PLANS	https://www.popsci.com/environment/weather-forecasting-ai/	https://www.popsci.com/wp-content/uploads/2025/05/ai_weather_forecasting.jpg?quality=85	2025-05-26 13:00:00
36	0.08	4	NewsDATA	Dr Jagadish Shukla, India's top meteorologist, on climate, forecasting, and India’s failures	In the 1980s, Dr. Jagadish Shukla played a key role in bringing India its first Cray supercomputer for weather forecasting.	ONLY AVAILABLE IN PAID PLANS	https://www.hindustantimes.com/india-news/dr-jagadish-shukla-indias-top-meteorologist-on-climate-forecasting-and-india-s-failures-101748239436863.html	https://www.hindustantimes.com/ht-img/img/2025/05/26/1600x900/jagadish_shukla_1748239842073_1748239842416.jpg	2025-05-26 06:20:41
37	0	4	NewsAPI	Hurricane Season Is Soon—NOAA Says It’s Ready, but Weather Experts Are Worried	As hurricane season approaches, thousands of weather and disaster experts have raised concerns about NOAA and NWS budget cuts and staffing shortages	CLIMATEWIRE | The National Oceanic and Atmospheric Administration insists it’s ready for the above-average hurricane season that meteorologists expect this summer.\r\nBut scientists across the country … [+7366 chars]	https://subscriber.politicopro.com/article/eenews/2025/05/23/noaa-says-its-ready-for-hurricane-season-scientists-are-worried-00366223	https://static.scientificamerican.com/dam/m/566dd7c688d81039/original/NOAA-satellite-image-of-Hurricane-Helene-as-a-category-4-monster-storm-before-making-landfall-in-Florida-on-September-27-2024.jpg?m=1748011985.23&w=1200	2025-05-23 15:15:00
38	0	4	NewsAPI	Busy hurricane season expected as forecasters fear Trump cuts	The warning comes as cuts to American research raise fears over the ability to track and prepare for them.	Mark PoyntingClimate reporter, BBC News\r\nHurricane Milton, in October 2024, was one of the Atlantic's strongest recorded storms\r\nThe coming Atlantic hurricane season is expected to be busier than usu… [+6367 chars]	https://www.bbc.com/news/articles/cp855prygj1o	https://ichef.bbci.co.uk/news/1024/branded_news/e3de/live/aa770ae0-362a-11f0-b2c9-2d36257649ec.jpg	2025-05-22 15:43:54
39	0	4	NewsAPI	La Niña is dead — what that means for this year's hurricanes and weather	Scientists thought La Niña was coming. It didn't — at least for now. What could that mean for this year's hurricane season, and how might long-term climate change affect El Niño and La Niña patterns?	El Niño\r\n is a seasonal shift in Pacific Ocean temperatures that can suppress hurricanes, change rainfall patterns and bend the jet stream. Its cold-water counterpart, La Niña, tends to do the opposi… [+1816 chars]	https://www.livescience.com/planet-earth/hurricanes/la-nina-is-dead-what-that-means-for-this-years-hurricanes-and-weather	https://cdn.mos.cms.futurecdn.net/7MuHvK2HtyjgxFY59FMo4o.jpg	2025-05-02 17:12:12
40	0	4	NewsAPI	UK records hottest ever May Day	The UK recorded its hottest ever May Day on Thursday, having just experienced its sunniest April since records began, according to the Met Office.According...	The UK recorded its hottest ever May Day on Thursday, having just experienced its sunniest April since records began, according to the Met Office.\r\nThe unprecedented temperature of 29.3 degrees Celsi… [+1385 chars]	https://www.yahoo.com/news/uk-records-hottest-ever-may-162050905.html	https://media.zenfs.com/en/afp.com/ac84eebf9f74b9c73b137ea51e3e245f	2025-05-01 19:03:36
41	0	4	NewsAPI	Why spring 2025 is so dry	Despite the familiar saying, April 2025 was significantly short on showers.	April showers bring May flowers according to an old English saying.\r\nThis phrase, which might have originated in a verse written by poet Thomas Tusser in 1557, harks back to a time when most people d… [+6268 chars]	https://theconversation.com/why-spring-2025-is-so-dry-256709	https://images.theconversation.com/files/667979/original/file-20250514-56-lufjjg.jpg?ixlib=rb-4.1.0&rect=0%2C618%2C8064%2C4032&q=45&auto=format&w=1356&h=668&fit=crop	2025-05-14 17:03:07
42	0	4	NewsAPI	CNN’s AMOC Alarm Debunked: Ocean Current Collapse Claims Crumble Under Scrutiny	CNN’s article on the AMOC is yet another example of how mainstream media misleads the public by dressing up uncertain science as inevitability. By leaning on AMOC modeling that lacks a solid observational foundation and is directly contradicted by other scien…	A recent CNN article by Laura Paddison, titled A crucial system of ocean currents is slowing. Its already supercharging sea level rise in the US, references new research on the Atlantic Meridional Ov… [+7706 chars]	https://wattsupwiththat.com/2025/05/24/cnns-amoc-alarm-debunked-ocean-current-collapse-claims-crumble-under-scrutiny/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/Global_Ocean_Circulation_GIF1-copy.webp?fit=1024%2C512&ssl=1	2025-05-24 21:00:00
43	0	4	NewsAPI	Las Vegas Sees Record Rainfall	More than half an inch of rain fell in Las Vegas on Monday, shattering the previous rainfall record for that day.	Las Vegas broke a 56-year-old daily rainfall record at Harry Reid International Airport on Monday after receiving 0.57 inches of rain. The previous record of .04 inches of rain was set in 1969.\r\nWhy … [+2641 chars]	https://www.newsweek.com/las-vegas-record-rainfall-storm-2068687	https://d.newsweek.com/en/full/2639551/las-vegas-sees-rainfall-record.jpg	2025-05-06 17:36:59
44	0.297	5	NewsDATA	Chile tornado injures 19 people, damages hundreds of buildings	STORY: :: Makarena AvendanoA tornado ripped across the city of Puerto Varas in southern Chile on Sunday.The severe weather injured 19 people, with 250 houses being checked for damage and over 4,500 buildings without electrical service, according to authorities on Monday.An official meteorologist said that while tornadoes like this have always occurred in Chile, particularly between May and June, they are being seen more often. They say that's because of a larger population and with videos spreading on social media.The service also warned that with climate change, the phenomenon could become more frequent.Residents told local television crews that Sunday's tornado was swift with powerful gust of wind.“There was terrible wind, everything was destroyed. Doors flew off, glass shattered, the frames of my windows came off, and my roof. I don’t have a roof.”Debris, including tree branches and tin sheets that had been used as roofing, littered the streets and hung from utility posts.Chilean President Gabriel Boric visited Puerto Varas on Monday to assess the, quote, "catastrophe":“Our Chile has a surprise for us, an unprecedented tornado that has been classified as degree 1 that affected Puerto Varas. The moment it happened, around 3:30 in the afternoon, all of the state’s resources were immediately deployed to support those affected.”Chile's meteorological service warned that other tornadoes could occur again in the south of the country.	ONLY AVAILABLE IN PAID PLANS	https://ca.news.yahoo.com/chile-tornado-injures-19-people-082219557.html	https://media.zenfs.com/en/video.reutersnews.com/f0a6aaf28a111d485f25d72571802b97	2025-05-27 08:22:19
45	0.073	5	NewsAPI	Where does your weather forecast come from?	Whether you get your forecast from an app on your phone, a website or a meteorologist on TV, most of the underlying information comes from the federal government.	You're about to walk your dog, but the sky looks ominous. You pull out your phone, open your favorite weather app, and see that it's about to pour. You wait for the rain to pass.\r\nOr maybe you planne… [+9878 chars]	https://www.npr.org/2025/05/19/nx-s1-5389593/weather-forecast-radar-satellites-storms-noaa	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/5637x3171+0+91/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F62%2F81%2F5d55aa13425582243d8d0f023f4d%2Fap24036601159583.jpg	2025-05-19 09:30:00
46	0.073	5	NewsAPI	Your weather forecast is about to get a lot worse	Did you check the weather forecast today?  Whether it was on your phone, the five-day outlook in your newspaper, or your friendly TV meteorologist, that forecast was built on a massive government-run network of sensors and computers that get the weather right…	An aerial view of severe flooding in Frankfort, Kentucky, caused by days of heavy rainfall across the Midwest on April 7, 2025.﻿\r\n\n\nDid you check the weather forecast today? \n\nWhether it was on your … [+8434 chars]	https://www.vox.com/climate/412458/weather-service-forecast-noaa-climate-flood-cuts	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/GettyImages-2208466891.jpg?quality=90&strip=all&crop=0%2C3.4613147178592%2C100%2C93.077370564282&w=1200	2025-05-09 20:11:53
47	0.073	5	NewsAPI	Tornadoes Expected to Strike Multiple States This Weekend in One of the Worst Seasons This Decade	Tornadoes are predicted across swaths of the U.S. in the coming days, likely adding to this year’s already high tally of such storms	Tornadoes threaten huge swaths of the U.S. this weekend amid a season already marked by unusually high storm activity, even as the National Weather Service faces budget cuts likely to impede its abil… [+4332 chars]	https://www.scientificamerican.com/article/tornadoes-expected-to-strike-multiple-states-this-weekend-in-one-of-the/	https://static.scientificamerican.com/dam/m/61fb14bdf421d893/original/tornado-supercell.jpg?m=1747417502.866&w=1200	2025-05-16 18:00:00
48	0.073	5	NewsAPI	Trump cuts leave National Weather Service scrambling to issue weather warnings...	Trump cuts leave National Weather Service scrambling to issue weather warnings...\r\n\n \n \n \n (First column, 1st story, link)\r\n\n \r\n\n \r\n\n \n Related stories:Kentucky office had no overnight staff before deadly tornadoes hit...	Whether theyve scrambled to get approval to buy office supplies or fix plumbing, cover shifts during severe weather that lasted for days or get tornado damage surveys completed, its been a rough few … [+6784 chars]	https://www.usatoday.com/story/news/nation/2025/05/15/noaa-national-weather-service-will-move-people-to-fill-vacancies/83640852007/	https://www.gannett-cdn.com/authoring/authoring-images/2025/04/17/USAT/83134332007-usatsi-25947781.jpg?auto=webp&crop=5999,3375,x0,y312&format=pjpg&width=1200	2025-05-19 17:04:37
49	0.073	5	NewsAPI	Coming this summer: Record-breaking heat and plenty of hurricanes	Forecasters are predicting higher temperatures across the U.S. and up to 10 hurricanes. Cutting federal programs could leave people even more vulnerable.	With less than a month to go until summer, weather forecasters have been dropping some troubling news about what might be in store. AccuWeather had already predicted an especially active season which… [+5416 chars]	http://grist.org/extreme-heat/summer-record-breaking-heat-hurricanes-liheap/	https://grist.org/wp-content/uploads/2025/05/GettyImages-1242895722h.jpg?quality=75&strip=all	2025-05-07 08:30:00
60	0	5	NewsAPI	More Than Two Dozen People Die In Severe Weather, Authorities Say	No fewer than 23 people have died as storm systems swept through parts of the Midwest and South, the Associated Press (AP) reported	No fewer than 23 people have died as storm systems swept through parts of the Midwest and South, the Associated Press reported.\r\nAt least 14 of the casualties died in Kentucky, Democratic Gov. Andy B… [+3910 chars]	https://dailycaller.com/2025/05/17/dozens-die-kentucky-missouri-virginia-severe-storm-systems/	https://cdn01.dailycaller.com/wp-content/uploads/2025/05/GettyImages-2215038739-scaled-e1747522783671.jpg	2025-05-17 23:34:33
50	0.073	5	NewsAPI	The Met Office is Unable to Name the Sites Providing ‘Estimated’ Temperature Data For its 103 Non-Existent Stations	The data identified individual stations and single location coordinates, but when 103 were found not to exist the Met Office hastily rewrote the title of the database to suggest that the figures arose from a wider local area.	From THE DAILY SCEPTIC\r\nby Chris Morrison\r\nLast year the UK Met Office was shown to be inventing long-term temperature data at 103 non-existent weather stations. It was claimed in a later risible fac… [+5990 chars]	https://wattsupwiththat.com/2025/05/13/the-met-office-is-unable-to-name-the-sites-providing-estimated-temperature-data-for-its-103-non-existent-stations/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2024/04/uk-met-office-topaz.webp?fit=1024%2C512&ssl=1	2025-05-13 09:00:00
51	0.073	5	NewsAPI	More tornadoes and fewer meteorologists make for a dangerous mix that’s worrying US officials	The U.S. is on track to have its second-busiest tornado year ever.	By SETH BORENSTEIN, Associated Press Science Writer\r\nWASHINGTON (AP) As nasty tornadoes popped up from Kansas to Kentucky, a depleted National Weather Service was in scramble mode.\r\nThe agencys offic… [+6305 chars]	https://www.bostonherald.com/2025/05/20/severe-weather-noaa-cuts/	https://www.bostonherald.com/wp-content/uploads/2025/05/APTOPIX_Severe_Weather_Kentucky_59646_538d6c-1.jpg?w=1024&h=768	2025-05-20 15:50:18
52	0.073	5	NewsAPI	Florida Sees Worst Drought In 24 Years	More than a quarter of the state is facing extreme drought, the second-most severe drought classification.	Parts of Florida are facing the most severe drought in nearly a quarter-century, with virtually the entire state under dry conditions ranging from abnormally dry to extreme drought.\r\nThe latest asses… [+3111 chars]	https://www.newsweek.com/florida-sees-worst-drought-24-years-2069796	https://d.newsweek.com/en/full/2641245/florida-drought-worst-24-years.jpg	2025-05-08 19:24:59
53	0.073	5	NewsAPI	Helene’s Unheard Warnings	by Jennifer Berry Hawes, with additional reporting by Cassandra Garibay \n \n \n\n\n\n \n \n “This Shits Crazy”\n \n \n \n \nIn their last phone call before bed, Janicke Glynn tries to reassure her husband. He is away visiting a sick relative, and a Weather Channel foreca…	Cattail Creek\r\nThursday Night\r\nThis Shits Crazy \r\nIn their last phone call before bed, Janicke Glynn tries to reassure her husband. He is away visiting a sick relative, and a Weather Channel forecast… [+43800 chars]	https://www.propublica.org/article/hurricane-helene-evacuation-warnings-yancey-county-north-carolina	https://img.assets-c3.propublica.org/images/articles/20240514-Hurricane-Helene-lead-OG-72dpi_2025-05-15-150240_wznd.jpg?crop=focalpoint&fit=crop&fp-x=0.5&fp-y=0.5&h=630&imgixProfile=propublicaAssets&q=90&w=1200&s=1e0eafba2ce11dee1f9f886cb9a2b9cb	2025-05-19 09:00:00
54	0.073	5	NewsAPI	Pet Warning Issued in California	Temperatures are surging into the triple digits this week in Southern California, prompting warnings for pet owners.	National Weather Service (NWS) meteorologists are urging people in Southern California to not leave their pets unattended in vehicles as temperatures surge into triple digits on Tuesday.\r\nWhy It Matt… [+3760 chars]	https://www.newsweek.com/pet-warning-issued-california-heat-wave-2074763	https://d.newsweek.com/en/full/2648121/pet-warning-issued-california.jpg	2025-05-20 17:08:40
55	0.073	5	NewsAPI	The Graph That Lied	The graph they built on a lie. The iconic 'climate' graph that's undermining industrial capitalism and taking our freedom...and it's 100 percent garbage.	.Gorilla Science\r\nThe graph they built on a lie. The iconic ‘climate’ graph that’s undermining industrial capitalism and taking our freedom…and it’s 100 percent garbage. Watch this film, and learn th… [+18027 chars]	https://wattsupwiththat.com/2025/05/09/the-graph-that-lied/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/tom-nelson-graph-video.webp?fit=1024%2C512&ssl=1	2025-05-09 13:00:00
56	0.073	5	NewsAPI	Severe weather top of mind as Calgary faces growing list of high-risk hazards and threats	Extreme temperatures and natural disasters topped the city's disaster management priority list, while water distribution infrastructure failure has become a higher-risk threat in light of last year's water main break.	Extreme temperatures, natural disasters and other severe weather conditions top the City of Calgary's disaster management priority list, while water distribution infrastructure failure has become a h… [+4886 chars]	https://www.cbc.ca/news/canada/calgary/calgary-emergency-risk-management-1.7529429	https://i.cbc.ca/1.6877107.1686793027!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/tornado-in-alberta-on-june-14-2023.jpg?im=Resize%3D620	2025-05-08 13:00:00
57	0	5	NewsAPI	Deadly Kentucky Tornadoes Ignite Fears Over U.S. Weather Warning Systems	Trump weakened understaffed National Weather Service offices. Some people in the storms' path wonder if budget cuts contributed to the death and destruction.	Sandra Anderson didnt think the storm would be too bad. When her grandchildren asked if the dogs should be brought in, Anderson demurred, saying theyd be fine. But later that night, an alert on her p… [+8836 chars]	https://gizmodo.com/deadly-kentucky-tornadoes-ignite-fears-over-u-s-weather-warning-systems-2000606539	https://gizmodo.com/app/uploads/2025/05/family-residence-damage-tornado-StLois.jpg	2025-05-26 10:00:38
58	0	5	NewsAPI	Hurricane Season Is Soon—NOAA Says It’s Ready, but Weather Experts Are Worried	As hurricane season approaches, thousands of weather and disaster experts have raised concerns about NOAA and NWS budget cuts and staffing shortages	CLIMATEWIRE | The National Oceanic and Atmospheric Administration insists it’s ready for the above-average hurricane season that meteorologists expect this summer.\r\nBut scientists across the country … [+7366 chars]	https://subscriber.politicopro.com/article/eenews/2025/05/23/noaa-says-its-ready-for-hurricane-season-scientists-are-worried-00366223	https://static.scientificamerican.com/dam/m/566dd7c688d81039/original/NOAA-satellite-image-of-Hurricane-Helene-as-a-category-4-monster-storm-before-making-landfall-in-Florida-on-September-27-2024.jpg?m=1748011985.23&w=1200	2025-05-23 15:15:00
59	0	5	NewsAPI	How The 2025 St. Louis Tornado Compares To A Historic One In 1896	An EF3 tornado was on the ground in St. Louis for at least 8 miles with a path up to a mile wide. How does it compare to the Great Tornado of 1896?	A person walks past a large tree blocking a road after a severe storm moved through Friday, May 16, ... More 2025, in St. Louis. (AP Photo/Jeff Roberson)\r\nCopyright 2025 The Associated Press. All rig… [+3462 chars]	https://www.forbes.com/sites/marshallshepherd/2025/05/18/how-the-2025-st-louis-tornado-compares-to-a-historic-one-in-1896/	https://imageio.forbes.com/specials-images/imageserve/6829e78025c448e7756050c4/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-18 15:13:47
81	0.067	6	NewsDATA	Where would we be without modern weather forecasting?	For all the flack meteorologists get for being “wrong,” Canada and the rest of the world would be a very different place if it weren’t for today’s weather forecasting.	ONLY AVAILABLE IN PAID PLANS	https://ca.news.yahoo.com/where-without-modern-weather-forecasting-175045721.html	https://s.yimg.com/ny/api/res/1.2/pTvPXwe5ZHk_RdQhk2wIBA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzU-/https://media.zenfs.com/en/the_weather_network_616/9fd1747178148d36ea1e8b5302b624b7	2025-05-26 17:50:45
61	0	5	NewsAPI	At least 12 homes destroyed amid wildfire state of emergency in Newfoundland	A wildfire that forced residents of  Small Point-Adam's Cove-Blackhead-Broad Cove in Conception Bay North to flee their community has now been deemed as put out, but a state of emergency continues to be in place.	A wildfire that forced residents of Small Point-Adam's Cove-Blackhead-Broad Cove in Conception Bay North to flee their community has now been deemed as put out, says the community's fire chief.\r\nRoge… [+7006 chars]	https://www.cbc.ca/news/canada/newfoundland-labrador/adam-s-cove-fire-deemed-out-as-as-state-of-emergency-continues-in-c-b-n-fire-chief-says-1.7529567	https://i.cbc.ca/1.7529448.1746662010!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/adam-s-cove-fire.jpg?im=Resize%3D620	2025-05-08 10:44:14
62	0	5	NewsAPI	Kentucky-Missouri Storms Came as Trump Made Cuts to National Weather Service	Some people in the storms' path wonder if budget cuts contributed to the death and destruction.	This story was originally published by Grist. Sign up for Grist’s weekly newsletter here.\r\nSandra Anderson didnt think the storm would be too bad. When her grandchildren asked if the dogs should be b… [+10007 chars]	https://grist.org/extreme-weather/the-kentucky-tornadoes-spur-mounting-anxiety-over-weather-service-warning-systems/	https://truthout.org/app/uploads/2025/05/GettyImages-2215038739-scaled.jpg	2025-05-25 13:12:21
63	0	5	NewsAPI	At least 12 homes destroyed amid wildfire state of emergency in Newfoundland	A wildfire that forced residents of Small Point-Adam's Cove-Blackhead-Broad Cove in Conception Bay North to flee their community has now been deemed as put out, but a state of emergency continues.	A wildfire that forced residents of Small Point-Adam's Cove-Blackhead-Broad Cove in Conception Bay North to flee their community has now been deemed as put out, says the community's fire chief.\r\nRoge… [+7816 chars]	https://www.cbc.ca/news/canada/newfoundland-labrador/adam-s-cove-fire-deemed-out-state-of-emergency-continues-in-c-b-n-1.7529567	https://i.cbc.ca/1.7529448.1746662010!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/adam-s-cove-fire.jpg?im=Resize%3D620	2025-05-08 10:44:14
64	0.206	6	NewsAPI	Severe weather top of mind as Calgary faces growing list of high-risk hazards and threats	Extreme temperatures and natural disasters topped the city's disaster management priority list, while water distribution infrastructure failure has become a higher-risk threat in light of last year's water main break.	Extreme temperatures, natural disasters and other severe weather conditions top the City of Calgary's disaster management priority list, while water distribution infrastructure failure has become a h… [+4886 chars]	https://www.cbc.ca/news/canada/calgary/calgary-emergency-risk-management-1.7529429	https://i.cbc.ca/1.6877107.1686793027!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/tornado-in-alberta-on-june-14-2023.jpg?im=Resize%3D620	2025-05-08 13:00:00
65	0.139	6	NewsAPI	Four Die as Floods Hammer Area North of Sydney, With More Rain Coming	At least four people died and thousands are without power as severe storms lashed Australia’s most populous state. Large swaths of New South Wales state remain on high alert for floods and extreme weather. Heavy rainfall is expected to continue …	Large swaths of New South Wales state remain on high alert for floods and extreme weather. Heavy rainfall is expected to continue into the weekend in central and southern regions, and coastal areas a… [+1800 chars]	https://www.insurancejournal.com/news/international/2025/05/23/824927.htm	https://www.insurancejournal.com/app/uploads/2025/05/milsons-point-in-sydney-getty-scaled.jpg	2025-05-23 05:59:50
66	0.139	6	NewsAPI	Climate Change Weekly # 543 —Current Climate Conditions Aren’t Historically Extreme or Unusual, New Research Shows	Recently, a number of new studies and analyses have been published indicating what readers of CCW have long known: recent climate conditions are not historically unusual. An examination of long-term wildfire trends, plus research comparing past climate condit…	From THE HEARTLAND INSTITUTE\r\nBy H. Sterling Burnett\r\nRecently, a number of new studies and analyses have been published indicating what readers of CCW have long known: recent climate conditions are … [+13694 chars]	https://wattsupwiththat.com/2025/05/09/climate-change-weekly-543-current-climate-conditions-arent-historically-extreme-or-unusual-new-research-shows/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/CCW-543-big-image-3.webp?fit=1024%2C512&ssl=1	2025-05-10 01:00:00
67	0.139	6	NewsAPI	US will stop tracking the costs of extreme weather fueled by climate change	The National Oceanic and Atmospheric Administration said it will no longer track the cost of weather disasters, including floods, heat waves, wildfires and more	The National Oceanic and Atmospheric Administration will no longer track the cost of climate change-fueled weather disasters, including floods, heat waves, wildfires and more. It is the latest exampl… [+4938 chars]	https://abcnews.go.com/US/wireStory/us-stop-tracking-costs-extreme-weather-fueled-climate-121612257	https://i.abcnewsfe.com/a/02343463-9d71-4f1a-911b-366fe428a34c/wirestory_53b9d8f5dc8563e2e70804d9c67b9404_16x9.jpg?w=1600	2025-05-08 19:42:28
68	0.133	6	NewsAPI	Faked data? Met Office’s data gaps raise questions over climate crisis claims	The Met Office cannot identify the sources of temperature data for 103 non-existent or defunct weather stations, undermining the reliability of its climate records. Independent investigations revealed cases like Scole (operational 1971-1980) reporting data fr…	<ul><li>The Met Office cannot identify the sources of temperature data for 103 non-existent or defunct weather stations, undermining the reliability of its climate records. Independent investigations… [+5620 chars]	https://www.naturalnews.com/2025-05-19-met-office-data-gaps-climate-crisis-claims.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/05/NOAA-global-warming-fake-science-data.jpg	2025-05-19 06:00:00
69	0.133	6	NewsAPI	Florida Sees Worst Drought In 24 Years	More than a quarter of the state is facing extreme drought, the second-most severe drought classification.	Parts of Florida are facing the most severe drought in nearly a quarter-century, with virtually the entire state under dry conditions ranging from abnormally dry to extreme drought.\r\nThe latest asses… [+3111 chars]	https://www.newsweek.com/florida-sees-worst-drought-24-years-2069796	https://d.newsweek.com/en/full/2641245/florida-drought-worst-24-years.jpg	2025-05-08 19:24:59
70	0.133	6	NewsDATA	Weather forecasting improves with AI, but we still need humans	Advanced systems from Microsoft and Google are already outperforming traditional forecasting models. The post Weather forecasting improves with AI, but we still need humans appeared first on Popular Science.	ONLY AVAILABLE IN PAID PLANS	https://www.popsci.com/environment/weather-forecasting-ai/	https://www.popsci.com/wp-content/uploads/2025/05/ai_weather_forecasting.jpg?quality=85	2025-05-26 13:00:00
71	0.067	6	NewsAPI	Your weather forecast is about to get a lot worse	Did you check the weather forecast today?  Whether it was on your phone, the five-day outlook in your newspaper, or your friendly TV meteorologist, that forecast was built on a massive government-run network of sensors and computers that get the weather right…	An aerial view of severe flooding in Frankfort, Kentucky, caused by days of heavy rainfall across the Midwest on April 7, 2025.﻿\r\n\n\nDid you check the weather forecast today? \n\nWhether it was on your … [+8434 chars]	https://www.vox.com/climate/412458/weather-service-forecast-noaa-climate-flood-cuts	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/GettyImages-2208466891.jpg?quality=90&strip=all&crop=0%2C3.4613147178592%2C100%2C93.077370564282&w=1200	2025-05-09 20:11:53
72	0.067	6	NewsAPI	Increasing Weather Risks Demand A Longer View Of The Forecast	Businesses are increasingly depending on long-range weather forecasts to manage risks and supply chain disruptions.	Long-range forecasting is growing in importance and accuracy. Using seasonal forecasts like this ... More 2025 summer forecast helps businesses and communities better plan and respond.\r\nDTN\r\nWith the… [+6497 chars]	https://www.forbes.com/sites/jimfoerster/2025/04/28/increasing-weather-risks-demand-a-longer-view-of-the-forecast/	https://imageio.forbes.com/specials-images/imageserve/680f747b2f35b4b453a921b5/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-28 12:37:25
73	0.067	6	NewsAPI	Trump cuts leave National Weather Service scrambling to issue weather warnings...	Trump cuts leave National Weather Service scrambling to issue weather warnings...\r\n\n \n \n \n (First column, 1st story, link)\r\n\n \r\n\n \r\n\n \n Related stories:Kentucky office had no overnight staff before deadly tornadoes hit...	Whether theyve scrambled to get approval to buy office supplies or fix plumbing, cover shifts during severe weather that lasted for days or get tornado damage surveys completed, its been a rough few … [+6784 chars]	https://www.usatoday.com/story/news/nation/2025/05/15/noaa-national-weather-service-will-move-people-to-fill-vacancies/83640852007/	https://www.gannett-cdn.com/authoring/authoring-images/2025/04/17/USAT/83134332007-usatsi-25947781.jpg?auto=webp&crop=5999,3375,x0,y312&format=pjpg&width=1200	2025-05-19 17:04:37
74	0.067	6	NewsAPI	Climate change made recent flooding in Midwest, South more intense, report finds	Analysis from World Weather Attribution, a climate science group, found that human-caused global warming made the record-breaking downpours in early April...	The deadly storms that tore through eight U.S. states in early April, killing at least 24 people, were made significantly worse by climate change, according to a study released this week.\r\nAnalysis f… [+2969 chars]	https://www.cbsnews.com/news/climate-change-flooding-midwest-south-more-intense-report/?ftag=YHF4eb9d17	https://media.zenfs.com/en/cbs_news_897/da986b6d41f7ed30026a1fc09c51e46b	2025-05-08 12:26:32
75	0.067	6	NewsAPI	Climate change made recent flooding in Midwest, South more intense, report finds	Analysis from World Weather Attribution, a climate science group, found that human-caused global warming made the record-breaking downpours in early April about 9% heavier.	The deadly storms that tore through eight U.S. states in early April, killing at least 24 people, were made significantly worse by climate change, according to a study released this week. \r\nAnalysis … [+3186 chars]	https://www.cbsnews.com/news/climate-change-flooding-midwest-south-more-intense-report/	https://assets1.cbsnewsstatic.com/hub/i/r/2025/05/07/c88443c5-f674-4df1-af08-3b9717a8891d/thumbnail/1200x630/33279b2d8fb29074bac01c862b3043ba/gettyimages-2209104054.jpg?v=e61856d8e666e7ed5709adc37bb2d465	2025-05-08 07:00:05
76	0.067	6	NewsAPI	CNN’s Climate Con Exposed: Real Estate, Not Storms, Fuels Skyrocketing Insurance Costs	Wrongly scapegoating non-existent “climate risk” allows adjusters, insurers, and lenders justify higher premiums, interest rates, and stricter credit standards while diverting attention from the actual causes of rising mortgage costs and insurance rates and c…	In a recent article, titled Why climate risk could affect your credit score for buying a home, CNNs Andrew Freedman describes a new report by FirstStreet that claims to show how climate risk could im… [+7767 chars]	https://wattsupwiththat.com/2025/05/21/cnns-climate-con-how-real-estate-not-storms-drives-insurance-costs/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/05/charlesrotter_aerial_miami_luxury_high_rises_midjourney.webp?fit=1024%2C512&ssl=1	2025-05-21 17:00:00
77	0.067	6	NewsAPI	Wrong, The Hill, Climate Driven Corn Insurance Cost Projections Mislead the Public	It’s astonishing that The Hill would publish such an article based on shaky, unverified models without at least checking real-world data trends on agricultural productivity and extreme weather. For over four decades, U.S. farmers have thrived even as temperat…	In a recent editorial from The Hill titled Climate change could deliver considerable blows to US corn growers, insurers: Study, the author claims that climate change will cause a dramatic increase in… [+4953 chars]	https://wattsupwiththat.com/2025/05/04/wrong-the-hill-climate-driven-corn-insurance-cost-projections-mislead-the-public/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2024/09/corn-1690387_1920.webp?fit=1024%2C512&ssl=1	2025-05-04 13:00:00
78	0.067	6	NewsAPI	Everglades 'Drying Up' as Drought Plagues Florida	Much of Florida is facing severe and extreme drought conditions after a "highly abnormal" dry season.	A Florida meteorologist has told Newsweek that some marshes and swamps in the Everglades appear to be "drying up" as extreme drought hits the Sunshine state.\r\nWINK News chief meteorologist Matt Devit… [+3323 chars]	https://www.newsweek.com/florida-everglades-drying-drought-2070396	https://d.newsweek.com/en/full/2642228/everglades-drying.jpg	2025-05-09 22:19:04
79	0.067	6	NewsAPI	The Met Office is Unable to Name the Sites Providing ‘Estimated’ Temperature Data For its 103 Non-Existent Stations	The data identified individual stations and single location coordinates, but when 103 were found not to exist the Met Office hastily rewrote the title of the database to suggest that the figures arose from a wider local area.	From THE DAILY SCEPTIC\r\nby Chris Morrison\r\nLast year the UK Met Office was shown to be inventing long-term temperature data at 103 non-existent weather stations. It was claimed in a later risible fac… [+5990 chars]	https://wattsupwiththat.com/2025/05/13/the-met-office-is-unable-to-name-the-sites-providing-estimated-temperature-data-for-its-103-non-existent-stations/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2024/04/uk-met-office-topaz.webp?fit=1024%2C512&ssl=1	2025-05-13 09:00:00
80	0.067	6	NewsAPI	Millions Told To Stay Out of Sun in Texas	Large swathes of Texas are expected to be hit by temperatures over 100 degrees Fahrenheit this week.	An early-season heat wave is gripping Texas, with temperatures forecast to surpass 100 degrees Fahrenheit across much of the state.\r\nThe National Weather Service (NWS) has issued heat advisories cove… [+2977 chars]	https://www.newsweek.com/millions-told-stay-out-sun-texas-heat-advisory-2071498	https://d.newsweek.com/en/full/2643500/texas-heat.jpg	2025-05-13 14:32:45
82	0	6	NewsAPI	Deadly Kentucky Tornadoes Ignite Fears Over U.S. Weather Warning Systems	Trump weakened understaffed National Weather Service offices. Some people in the storms' path wonder if budget cuts contributed to the death and destruction.	Sandra Anderson didnt think the storm would be too bad. When her grandchildren asked if the dogs should be brought in, Anderson demurred, saying theyd be fine. But later that night, an alert on her p… [+8836 chars]	https://gizmodo.com/deadly-kentucky-tornadoes-ignite-fears-over-u-s-weather-warning-systems-2000606539	https://gizmodo.com/app/uploads/2025/05/family-residence-damage-tornado-StLois.jpg	2025-05-26 10:00:38
83	0	6	NewsAPI	Busy hurricane season expected as forecasters fear Trump cuts	The warning comes as cuts to American research raise fears over the ability to track and prepare for them.	Mark PoyntingClimate reporter, BBC News\r\nHurricane Milton, in October 2024, was one of the Atlantic's strongest recorded storms\r\nThe coming Atlantic hurricane season is expected to be busier than usu… [+6367 chars]	https://www.bbc.com/news/articles/cp855prygj1o	https://ichef.bbci.co.uk/news/1024/branded_news/e3de/live/aa770ae0-362a-11f0-b2c9-2d36257649ec.jpg	2025-05-22 15:43:54
84	0.152	7	NewsAPI	Microsoft's latest AI model can accurately forecast the weather: “It doesn’t know the laws of physics, so it could make up something completely crazy”	Microsoft's latest AI model, Aurora, is designed to help provide detailed and accurate weather forecasts. It can generate accurate 10-day forecasts in seconds.	The emergence of generative AI is revolutionizing how we do things. As the technology gains broad adoption across the world, we're seeing more people integrate it into their workflows to make work ea… [+3011 chars]	https://www.windowscentral.com/microsoft/microsoft-ai-model-can-accurately-forecast-the-weather	https://cdn.mos.cms.futurecdn.net/WKYkDNzDARBAYeS6UHpa4Y.jpg	2025-05-23 09:31:32
85	0.152	7	NewsAPI	AI can't replace freelance coders yet, but that day is coming	Claude passed 80% of tasks assigned in a recent study\nFreelance coders take solace: while AI models can perform a lot of the real-world coding tasks that companies contract out, they do so less effectively than a human.…<!--#include virtual='/data_centre/_whi…	Freelance coders take solace: while AI models can perform a lot of the real-world coding tasks that companies contract out, they do so less effectively than a human.\r\nAt least that was the case two m… [+4065 chars]	https://www.theregister.com/2025/05/22/freelance_coders_ai_work/	https://regmedia.co.uk/2023/02/08/shutterstock_208487719.jpg	2025-05-22 12:37:33
86	0.145	7	NewsAPI	Anthropic's Claude faked a legal citation. A lawyer had to clean it up.	The AI chatbot was used to help draft a citation in an expert report for Anthropic's copyright lawsuit.	In a copyright lawsuit over Anthropic's use of music lyrics, the company's legal team used its AI assistant, Claude, to help draft a citation in an expert report.illustration by Cheng Xin/Getty Image… [+3185 chars]	https://www.businessinsider.com/claude-anthropic-legal-citation-lawyer-hallucination-copyright-case-lawsuit-2025-5	https://i.insider.com/6826b44bc6ad288d14811c2c?width=1200&format=jpeg	2025-05-16 04:37:16
87	0.145	7	NewsAPI	Fine-tuning vs. in-context learning: New research guides better LLM customization for real-world tasks	By combining fine-tuning and in-context learning, you get LLMs that can learn tasks that would be too difficult or expensive for either method	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nTwo popular approaches for customizing large language models (LLMs) for… [+6568 chars]	https://venturebeat.com/ai/fine-tuning-vs-in-context-learning-new-research-guides-better-llm-customization-for-real-world-tasks/	https://venturebeat.com/wp-content/uploads/2024/09/cfr0z3n_a_robot_in_a_collared_polo_sits_at_a_desk_dutifully_sta_1a510b62-1550-4ca9-839a-dfd64d6c304c-1.png?w=1024?w=1200&strip=all	2025-05-10 00:23:09
88	0.145	7	NewsAPI	"Are we all doomed?" — Fiverr CEO Micha Kaufman warns that AI is coming for all of our jobs, just as Bill Gates predicted	Fiverr CEO Micha Kaufman claims AI is coming for all jobs, including his own, recommending upskilling to remain relevant in an AI-driven job market.	"It doesn't matter if you are a programmer, designer, product manager, data scientist, lawyer, customer support, salesperson or a finance person - AI is coming for you."\r\nFiverr CEO Micha Kaufman sha… [+1892 chars]	https://www.windowscentral.com/software-apps/fiverr-ceo-micha-kaufman-ai-is-coming-for-our-jobs	https://cdn.mos.cms.futurecdn.net/bN6RStwcTDXKViPXuSUF2n.jpg	2025-05-07 09:46:11
89	0.145	7	NewsAPI	How tech companies could shrink AI's climate footprint	Google, Microsoft and Meta have all pledged to reach at least net-zero carbon emissions by 2030. Amazon set their net-zero deadline for 2040. To understand how these four tech companies could possibly meet their climate goals amid an artificial intelligence r…	AI is rapidly transforming how we live, work, and communicate. But can we undergo that transformation without destroying the environment?\r\nHiroshi Watanabe/Getty Images\r\nIn 2018, computer scientist S… [+2657 chars]	https://www.npr.org/2025/05/09/1250191980/-ai-google-amazon-meta-microsoft-environment	https://media.npr.org/assets/img/2025/05/08/5.9.25-ep_wide-dc624b6123a2bbe157ba52317a3b98f13f0eb04f.jpg?s=1400&c=100&f=jpeg	2025-05-09 07:00:59
90	0.073	7	NewsAPI	Google DeepMind’s AI Agent Dreams Up Algorithms Beyond Human Expertise	A new system that combines Gemini’s coding abilities with an evolutionary approach  improves datacenter scheduling, chip design, and fine-tune large language models.	A key question in artificial intelligence is how often models go beyond just regurgitating and remixing what they have learned and produce truly novel ideas or insights.\r\nA new project from Google De… [+3012 chars]	https://www.wired.com/story/google-deepminds-ai-agent-dreams-up-algorithms-beyond-human-expertise/	https://media.wired.com/photos/6823a54e83546d0fe3307acb/191:100/w_1280,c_limit/AI-Lab-Google-DeepMind-Computin-Agent-Business.jpg	2025-05-14 15:00:38
91	0.073	7	NewsAPI	Meta's chief AI scientist says scaling AI won't make it smarter	Bigger is not better, according to Yann LeCun, Meta's chief AI scientist. Smarter AI requires different training methods, he says.	Meta chief AI scientist Yann LeCun doesn't think scaling AI is enough to make it smarter.Meta Platforms\r\n<ul><li>Yann LeCun, chief AI scientist at Meta, pushed back against "scaling laws."</li><li>Th… [+3205 chars]	https://www.businessinsider.com/meta-yann-lecun-scaling-ai-wont-make-it-smarter-2025-4	https://i.insider.com/680eb7323fe8d3928364313a?width=1200&format=jpeg	2025-04-27 23:55:21
92	0.073	7	NewsAPI	AI Identifies Author of Charred Scroll Buried by Vesuvius for 2,000 Years	A sealed Herculaneum scroll yields its secrets—revealing a lost philosophical treatise by Philodemus through virtual unwrapping.	For the first time, researchers have identified the author and title of a document thats been locked inside a charred scroll for nearly 2,000 yearswithout peeling back a single layer.\r\nThe scroll, PH… [+3730 chars]	https://gizmodo.com/ai-identifies-author-of-charred-scroll-buried-by-vesuvius-for-2000-years-2000598553	https://gizmodo.com/app/uploads/2024/08/papyrus-fragments-herculaneum-AI.jpg	2025-05-06 15:40:17
93	0.073	7	NewsAPI	The ‘era of experience’ will unleash self-learning AI agents across the web—here’s how to prepare	AI visionaries predict an 'Era of Experience' where AI learns autonomously, and it will have important implications for application design.	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nDavid Silver and Richard Sutton, two renowned AI scientists, argue in a… [+6913 chars]	https://venturebeat.com/ai/the-era-of-experience-will-unleash-self-learning-ai-agents-across-the-web-heres-how-to-prepare/	https://venturebeat.com/wp-content/uploads/2025/04/era-of-experience.webp?w=1024?w=1200&strip=all	2025-04-30 20:38:01
94	0.073	7	NewsAPI	AT&T's switch from ChatGPT to open-source AI helped it hang on to thousands of customers	AT&T's switch to open-source AI from ChatGPT enabled cost savings and efficiency, helping the company retain thousands of customers.	AT&T changed AI tools and reaped the benefits.Getty Images; Alyssa Powell/ BI\r\n<ul><li>AT&T uses AI to categorize 40 million customer service calls annually.</li><li>ChatGPT initially helped but was … [+5040 chars]	https://www.businessinsider.com/att-open-source-ai-better-than-chatgpt-customer-service-calls-2025-5	https://i.insider.com/6818fbf7c6ad288d148007b3?width=1200&format=jpeg	2025-05-07 14:30:34
95	0.073	7	NewsAPI	Exclusive: What If AI could design a jet engine—or even a starship? Google DeepMind and Airbus veterans just raised $23M with an eye on that future	P-1 AI just raised $23 million to build a new kind of AI engineer that could someday design starships.	When dreaming of the day artificial intelligence achieves human-like ability, former Airbus CTO Paul Eremenko says he's always done so in the context of building real-world machines. I want an AI sup… [+3864 chars]	https://tech.yahoo.com/ai/articles/exclusive-ai-could-design-jet-130000308.html	https://s.yimg.com/ny/api/res/1.2/4cR_uDdqKECkTgNTxtPcVQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03NzE-/https://media.zenfs.com/en/fortune_175/4a7595fd943da4618d3c8db9cf0c16d5	2025-04-28 13:00:00
96	0.073	7	NewsAPI	Anthropic Economic Index: AI's Impact on Software Development	Data on how software developers are using Claude	Jobs that involve computer programming are a small sector of the modern economy, but an influential one. The past couple of years have seen them changed dramatically by the introduction of AI systems… [+12977 chars]	https://www.anthropic.com/research/impact-software-development	https://cdn.sanity.io/images/4zrzovbb/website/bea097e855cde347f1bccf36faccea3d8c0e0848-2401x1261.png	2025-04-28 15:05:13
97	0.073	7	NewsAPI	Relational Graph Transformers	Relational Graph Transformers represent the next evolution in Relational Deep Learning, allowing AI systems to seamlessly navigate and learn from data spread across multiple tables. By treating relational databases as the rich, interconnected graphs they inhe…	In the world of enterprise data, the most valuable insights often lie not in individual tables, but in the complex relationships between them. Customer interactions, product hierarchies, transaction … [+21957 chars]	https://kumo.ai/research/relational-graph-transformers/	https://cdn.sanity.io/images/s3lh42f5/production/af39e214cf17d1563c167346a70d4badb31451fa-960x576.png	2025-04-28 18:13:17
98	0.073	7	NewsAPI	This data set helps researchers spot harmful stereotypes in LLMs	AI models are riddled with culturally specific biases. A new data set, called SHADES, is designed to help developers combat the problem by spotting harmful stereotypes and other kinds of discrimination that emerge in AI chatbot responses across a wide range o…	I hope that people use [SHADES] as a diagnostic tool to identify where and how there might be issues in a model, says Talat. Its a way of knowing whats missing from a model, where we cant be confiden… [+1571 chars]	https://www.technologyreview.com/2025/04/30/1115946/this-data-set-helps-researchers-spot-harmful-stereotypes-in-llms/	https://wp.technologyreview.com/wp-content/uploads/2025/04/shades.jpg?resize=1200,600	2025-04-30 09:41:25
99	0.073	7	NewsAPI	Nuclear engineers want the industry to get 'unstuck' after years of bad PR. The AI boom could be the key.	Nuclear engineers told BI that Big Tech's investments could propel nuclear out of a slump. Others are skeptical about buzzy "small modular reactors."	Interest from Big Tech could help propel the nuclear industry out of a slump.Anton Petrus/Getty Images\r\n<ul><li>Big Tech is turning to nuclear power as a potential AI energy solution, including small… [+8765 chars]	https://www.businessinsider.com/big-tech-investments-nuclear-energy-could-help-industry-2025-5	https://i.insider.com/6830f5396ffb6822ec616d37?width=1200&format=jpeg	2025-05-26 11:21:01
100	0.073	7	NewsAPI	Google DeepMind CEO Demis Hassabis on AI in the Military and What AGI Could Mean for Humanity	TIME spoke with Google DeepMind CEO Demis Hassabis, who was on the 2025 TIME100 list.	The last time I interviewed Demis Hassabis was back in November 2022, just a few weeks before the release of ChatGPT. Even thenbefore the rest of the world went AI-crazythe CEO of Google DeepMind had… [+22089 chars]	https://time.com/7280740/demis-hassabis-interview/	https://api.time.com/wp-content/uploads/2025/04/time100-2025-demis-hassabis.jpg?quality=85&crop=0px%2C26px%2C2400px%2C1256px&resize=1200%2C628&strip	2025-04-27 11:00:00
101	0.073	7	NewsAPI	MIT Backs Away From Paper Claiming Scientists Make More Discoveries with AI	The retracted paper had impressed a Nobel Prize winner in economics.	Last year, the Massachusetts Institute of Technology was touting the research of a PhD student on the impact of AI on the workforce that “floored” professors in the field. Now the university is backi… [+2314 chars]	https://gizmodo.com/mit-backs-away-from-paper-claiming-scientists-make-more-discoveries-with-ai-2000603790	https://gizmodo.com/app/uploads/2025/05/GettyImages-2579928.jpg	2025-05-17 19:30:08
102	0.073	7	NewsAPI	Conspiracy Theorists Can Be Deprogrammed	AI-delivered evidence might be better at changing minds than you are	Humans love their conspiracy theories. The Apollo moon landings were faked by covert agents in NASA to broadcast Americas technological prowess over Soviet Russia. (It was too expensive and risky to … [+6973 chars]	https://nautil.us/conspiracy-theorists-can-be-deprogrammed-1210134/	https://assets.nautil.us/sites/3/nautilus/GHu1iDML-Kazamia_HERO.png?auto=compress&fm=png&ixlib=php-3.3.1	2025-05-13 11:42:04
103	0.073	7	NewsAPI	Bad Data Exists. What Can AI Do About It?	It’s no surprise to anyone who works with data—it’s messy. In every industry and every business, there are data anomalies and issues that can impact the story data tells.	Dr. Bob Lindner is the Chief Science and Technology Officer at Veda, a company addressing provider directory data challenges.\r\ngetty\r\nIts no surprise to anyone who works with dataits messy. In every … [+6059 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/04/30/bad-data-exists-what-can-ai-do-about-it/	https://imageio.forbes.com/specials-images/imageserve/6810ec47ec4933f4c6140406/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-30 11:15:00
104	0.247	8	NewsAPI	This data set helps researchers spot harmful stereotypes in LLMs	AI models are riddled with culturally specific biases. A new data set, called SHADES, is designed to help developers combat the problem by spotting harmful stereotypes and other kinds of discrimination that emerge in AI chatbot responses across a wide range o…	I hope that people use [SHADES] as a diagnostic tool to identify where and how there might be issues in a model, says Talat. Its a way of knowing whats missing from a model, where we cant be confiden… [+1571 chars]	https://www.technologyreview.com/2025/04/30/1115946/this-data-set-helps-researchers-spot-harmful-stereotypes-in-llms/	https://wp.technologyreview.com/wp-content/uploads/2025/04/shades.jpg?resize=1200,600	2025-04-30 09:41:25
105	0.16	8	NewsAPI	Anthropic's Claude faked a legal citation. A lawyer had to clean it up.	The AI chatbot was used to help draft a citation in an expert report for Anthropic's copyright lawsuit.	In a copyright lawsuit over Anthropic's use of music lyrics, the company's legal team used its AI assistant, Claude, to help draft a citation in an expert report.illustration by Cheng Xin/Getty Image… [+3185 chars]	https://www.businessinsider.com/claude-anthropic-legal-citation-lawyer-hallucination-copyright-case-lawsuit-2025-5	https://i.insider.com/6826b44bc6ad288d14811c2c?width=1200&format=jpeg	2025-05-16 04:37:16
106	0.16	8	NewsAPI	How tech companies could shrink AI's climate footprint	Google, Microsoft and Meta have all pledged to reach at least net-zero carbon emissions by 2030. Amazon set their net-zero deadline for 2040. To understand how these four tech companies could possibly meet their climate goals amid an artificial intelligence r…	AI is rapidly transforming how we live, work, and communicate. But can we undergo that transformation without destroying the environment?\r\nHiroshi Watanabe/Getty Images\r\nIn 2018, computer scientist S… [+2657 chars]	https://www.npr.org/2025/05/09/1250191980/-ai-google-amazon-meta-microsoft-environment	https://media.npr.org/assets/img/2025/05/08/5.9.25-ep_wide-dc624b6123a2bbe157ba52317a3b98f13f0eb04f.jpg?s=1400&c=100&f=jpeg	2025-05-09 07:00:59
107	0.08	8	NewsAPI	Meta's chief AI scientist says scaling AI won't make it smarter	Bigger is not better, according to Yann LeCun, Meta's chief AI scientist. Smarter AI requires different training methods, he says.	Meta chief AI scientist Yann LeCun doesn't think scaling AI is enough to make it smarter.Meta Platforms\r\n<ul><li>Yann LeCun, chief AI scientist at Meta, pushed back against "scaling laws."</li><li>Th… [+3205 chars]	https://www.businessinsider.com/meta-yann-lecun-scaling-ai-wont-make-it-smarter-2025-4	https://i.insider.com/680eb7323fe8d3928364313a?width=1200&format=jpeg	2025-04-27 23:55:21
108	0.08	8	NewsAPI	The ‘era of experience’ will unleash self-learning AI agents across the web—here’s how to prepare	AI visionaries predict an 'Era of Experience' where AI learns autonomously, and it will have important implications for application design.	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nDavid Silver and Richard Sutton, two renowned AI scientists, argue in a… [+6913 chars]	https://venturebeat.com/ai/the-era-of-experience-will-unleash-self-learning-ai-agents-across-the-web-heres-how-to-prepare/	https://venturebeat.com/wp-content/uploads/2025/04/era-of-experience.webp?w=1024?w=1200&strip=all	2025-04-30 20:38:01
109	0.08	8	NewsAPI	AT&T's switch from ChatGPT to open-source AI helped it hang on to thousands of customers	AT&T's switch to open-source AI from ChatGPT enabled cost savings and efficiency, helping the company retain thousands of customers.	AT&T changed AI tools and reaped the benefits.Getty Images; Alyssa Powell/ BI\r\n<ul><li>AT&T uses AI to categorize 40 million customer service calls annually.</li><li>ChatGPT initially helped but was … [+5040 chars]	https://www.businessinsider.com/att-open-source-ai-better-than-chatgpt-customer-service-calls-2025-5	https://i.insider.com/6818fbf7c6ad288d148007b3?width=1200&format=jpeg	2025-05-07 14:30:34
110	0.08	8	NewsAPI	Fine-tuning vs. in-context learning: New research guides better LLM customization for real-world tasks	By combining fine-tuning and in-context learning, you get LLMs that can learn tasks that would be too difficult or expensive for either method	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nTwo popular approaches for customizing large language models (LLMs) for… [+6568 chars]	https://venturebeat.com/ai/fine-tuning-vs-in-context-learning-new-research-guides-better-llm-customization-for-real-world-tasks/	https://venturebeat.com/wp-content/uploads/2024/09/cfr0z3n_a_robot_in_a_collared_polo_sits_at_a_desk_dutifully_sta_1a510b62-1550-4ca9-839a-dfd64d6c304c-1.png?w=1024?w=1200&strip=all	2025-05-10 00:23:09
111	0.08	8	NewsAPI	Exclusive: What If AI could design a jet engine—or even a starship? Google DeepMind and Airbus veterans just raised $23M with an eye on that future	P-1 AI just raised $23 million to build a new kind of AI engineer that could someday design starships.	When dreaming of the day artificial intelligence achieves human-like ability, former Airbus CTO Paul Eremenko says he's always done so in the context of building real-world machines. I want an AI sup… [+3864 chars]	https://tech.yahoo.com/ai/articles/exclusive-ai-could-design-jet-130000308.html	https://s.yimg.com/ny/api/res/1.2/4cR_uDdqKECkTgNTxtPcVQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03NzE-/https://media.zenfs.com/en/fortune_175/4a7595fd943da4618d3c8db9cf0c16d5	2025-04-28 13:00:00
112	0.08	8	NewsAPI	Anthropic Economic Index: AI's Impact on Software Development	Data on how software developers are using Claude	Jobs that involve computer programming are a small sector of the modern economy, but an influential one. The past couple of years have seen them changed dramatically by the introduction of AI systems… [+12977 chars]	https://www.anthropic.com/research/impact-software-development	https://cdn.sanity.io/images/4zrzovbb/website/bea097e855cde347f1bccf36faccea3d8c0e0848-2401x1261.png	2025-04-28 15:05:13
113	0.08	8	NewsAPI	Relational Graph Transformers	Relational Graph Transformers represent the next evolution in Relational Deep Learning, allowing AI systems to seamlessly navigate and learn from data spread across multiple tables. By treating relational databases as the rich, interconnected graphs they inhe…	In the world of enterprise data, the most valuable insights often lie not in individual tables, but in the complex relationships between them. Customer interactions, product hierarchies, transaction … [+21957 chars]	https://kumo.ai/research/relational-graph-transformers/	https://cdn.sanity.io/images/s3lh42f5/production/af39e214cf17d1563c167346a70d4badb31451fa-960x576.png	2025-04-28 18:13:17
114	0.08	8	NewsAPI	Nuclear engineers want the industry to get 'unstuck' after years of bad PR. The AI boom could be the key.	Nuclear engineers told BI that Big Tech's investments could propel nuclear out of a slump. Others are skeptical about buzzy "small modular reactors."	Interest from Big Tech could help propel the nuclear industry out of a slump.Anton Petrus/Getty Images\r\n<ul><li>Big Tech is turning to nuclear power as a potential AI energy solution, including small… [+8765 chars]	https://www.businessinsider.com/big-tech-investments-nuclear-energy-could-help-industry-2025-5	https://i.insider.com/6830f5396ffb6822ec616d37?width=1200&format=jpeg	2025-05-26 11:21:01
115	0.08	8	NewsAPI	"Are we all doomed?" — Fiverr CEO Micha Kaufman warns that AI is coming for all of our jobs, just as Bill Gates predicted	Fiverr CEO Micha Kaufman claims AI is coming for all jobs, including his own, recommending upskilling to remain relevant in an AI-driven job market.	"It doesn't matter if you are a programmer, designer, product manager, data scientist, lawyer, customer support, salesperson or a finance person - AI is coming for you."\r\nFiverr CEO Micha Kaufman sha… [+1892 chars]	https://www.windowscentral.com/software-apps/fiverr-ceo-micha-kaufman-ai-is-coming-for-our-jobs	https://cdn.mos.cms.futurecdn.net/bN6RStwcTDXKViPXuSUF2n.jpg	2025-05-07 09:46:11
116	0.08	8	NewsAPI	MIT Backs Away From Paper Claiming Scientists Make More Discoveries with AI	The retracted paper had impressed a Nobel Prize winner in economics.	Last year, the Massachusetts Institute of Technology was touting the research of a PhD student on the impact of AI on the workforce that “floored” professors in the field. Now the university is backi… [+2314 chars]	https://gizmodo.com/mit-backs-away-from-paper-claiming-scientists-make-more-discoveries-with-ai-2000603790	https://gizmodo.com/app/uploads/2025/05/GettyImages-2579928.jpg	2025-05-17 19:30:08
117	0.08	8	NewsAPI	Meta's First LlamaCon Shows the Tech Giant's Still Playing Catch-Up	The company's first AI developers conference on Tuesday fell flat, with very few new announcements and products, including a standalone AI app that technically already existed.	If you were like me and went into Meta's LlamaCon keynote expecting the company to drop the reasoning model it teased earlier this month or its teacher model Behemoth, prepare to be disappointed. The… [+6021 chars]	https://www.cnet.com/tech/services-and-software/metas-first-llamacon-shows-the-tech-giants-still-playing-catch-up/	https://www.cnet.com/a/img/resize/b546aa731561fbce9f47a53dcc2cde62a8a8c885/hub/2024/04/18/0c2c154c-8bc0-42b4-aaee-c5f4a13937d0/meta-ai-2.jpg?auto=webp&fit=crop&height=675&width=1200	2025-04-29 20:38:22
118	0.08	8	NewsAPI	Anthropic’s law firm throws Claude under the bus over citation errors in court filing	AI footnote fail triggers legal palmface in music copyright spat\nAn attorney defending AI firm Anthropic in a copyright case brought by music publishers apologized to the court on Thursday for citation errors that slipped into a filing after using the biz's o…	An attorney defending AI firm Anthropic in a copyright case brought by music publishers apologized to the court on Thursday for citation errors that slipped into a filing after using the biz's own AI… [+5806 chars]	https://www.theregister.com/2025/05/15/anthopics_law_firm_blames_claude_hallucinations/	https://regmedia.co.uk/2024/03/04/claude_shutterstock.jpg	2025-05-15 20:58:00
119	0.08	8	NewsAPI	5 Ways To Hybridize Predictive AI And Generative AI	AI is in trouble. Both generative AI and predictive AI face crippling limitations that compromise their value. The solution? GenAI helps predictive AI and vice versa.	AI is in trouble. Both generative AI and predictive AI face crippling limitations that compromise ... More their value. The solution? GenAI helps predictive AI and vice versa.\r\nEric Siegel\r\nAI is in … [+7904 chars]	https://www.forbes.com/sites/ericsiegel/2025/05/15/5-ways-to-hybridize-predictive-ai-and-generative-ai/	https://imageio.forbes.com/specials-images/imageserve/68262c875b50fa837502939a/0x0.jpg?format=jpg&crop=1280,720,x0,y79,safe&height=900&width=1600&fit=bounds	2025-05-15 18:25:46
120	0.08	8	NewsDATA	Rapid bedside test predicts sepsis with more than 90% accuracy	Canadian scientists have developed a blood test and portable device that can determine the onset of sepsis faster and more accurately than existing methods.	ONLY AVAILABLE IN PAID PLANS	https://medicalxpress.com/news/2025-05-rapid-bedside-sepsis-accuracy.html	https://scx1.b-cdn.net/csz/news/tmb/2025/rapid-bedside-test-pre.jpg	2025-05-27 16:42:04
121	0.08	8	NewsDATA	Is this mysterious world home to Alien life? Astronomers spot signs of a ‘Second Earth’	We all love a good story about distant planets, especially when there’s the faintest glimmer of a chance that something, [...]	ONLY AVAILABLE IN PAID PLANS	https://euroweeklynews.com/2025/05/27/is-this-mysterious-world-home-to-alien-life-astronomers-spot-signs-of-a-second-earth/	https://cdn.euroweeklynews.com/wp-content/uploads/2025/05/exoplaneta-lhs-1140-b.jpg	2025-05-27 15:16:58
122	0.08	8	NewsDATA	Canada Has A Chance To Lead On AI Policy And Data Governance At The 2025 G7 Leaders' Summit #Canada #Chance #Lead #Policy #Data #Governance #2025 #Leaders' #Summit #Vaccines #Pills #Doctor #Hospital #Pandemic	(MENAFN - The Conversation)Artificial intelligence (AI) is rapidly transforming sectors from health care to climate science. But amid the global scramble to lead this technological revolution, one ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109601870/Canada-Has-A-Chance-To-Lead-On-AI-Policy-And-Data-Governance-At-The-2025-G7-Leaders-Summit?Social=on	https://menafn.com/updates/pr/2025-05/27/TC_ac78dimage_story_social.jpg	2025-05-27 15:08:48
123	0.08	8	NewsDATA	Canada Has A Chance To Lead On AI Policy And Data Governance At The 2025 G7 Leaders' Summit	(MENAFN - The Conversation)Artificial intelligence (AI) is rapidly transforming sectors from health care to climate science. But amid the global scramble to lead this technological revolution, one ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109601870/Canada-Has-A-Chance-To-Lead-On-AI-Policy-And-Data-Governance-At-The-2025-G7-Leaders-Summit	https://menafn.com/updates/pr/2025-05/27/TC_ac78dimage_story.jpg	2025-05-27 15:08:48
124	0.167	9	NewsAPI	The ‘era of experience’ will unleash self-learning AI agents across the web—here’s how to prepare	AI visionaries predict an 'Era of Experience' where AI learns autonomously, and it will have important implications for application design.	Join our daily and weekly newsletters for the latest updates and exclusive content on industry-leading AI coverage. Learn More\r\nDavid Silver and Richard Sutton, two renowned AI scientists, argue in a… [+6913 chars]	https://venturebeat.com/ai/the-era-of-experience-will-unleash-self-learning-ai-agents-across-the-web-heres-how-to-prepare/	https://venturebeat.com/wp-content/uploads/2025/04/era-of-experience.webp?w=1024?w=1200&strip=all	2025-04-30 20:38:01
125	0.167	9	NewsAPI	How Dell’s AI Infrastructure Updates Deliver Choice, Control And Scale	Dell's AI Factory evolution delivers hybrid enterprise AI with choice across AMD, Intel, NVIDIA, and key model providers like Cohere and Mistral for production workloads.	Dell Technologies World focuses its keynote on Inventing the Future with AI\r\nDell Technologies\r\nDell Technologies unveiled a significant expansion of its Dell AI Factory platform at its annual Dell T… [+12317 chars]	https://www.forbes.com/sites/maribellopez/2025/05/19/how-dells-ai-infrastructure-updates-deliver-choice-control-and-scale/	https://imageio.forbes.com/specials-images/imageserve/682bad0c1abe7b3a725f7f36/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-19 23:06:46
126	0.16	9	NewsAPI	7 Jobs Vanishing Fast—And The $100K Roles Replacing Them	Discover 7 jobs disappearing fast—and the six-figure careers replacing them. Learn how to pivot with practical tips for a high-paying future.	By 2030, 70% of skills used in most jobs will change, according to LinkedIn.\r\ngetty\r\nAccording to LinkedIn's Work Change report, 70% of skills used in most jobs will change by 2030, with AI as the pr… [+9050 chars]	https://www.forbes.com/sites/carolinecastrillon/2025/05/17/7-jobs-vanishing-fast-and-the-100k-roles-replacing-them/	https://imageio.forbes.com/specials-images/imageserve/677eb3671bc131eb81942547/0x0.jpg?format=jpg&crop=1306,735,x0,y25,safe&height=900&width=1600&fit=bounds	2025-05-18 02:44:56
127	0.16	9	NewsAPI	5 Ways To Hybridize Predictive AI And Generative AI	AI is in trouble. Both generative AI and predictive AI face crippling limitations that compromise their value. The solution? GenAI helps predictive AI and vice versa.	AI is in trouble. Both generative AI and predictive AI face crippling limitations that compromise ... More their value. The solution? GenAI helps predictive AI and vice versa.\r\nEric Siegel\r\nAI is in … [+7904 chars]	https://www.forbes.com/sites/ericsiegel/2025/05/15/5-ways-to-hybridize-predictive-ai-and-generative-ai/	https://imageio.forbes.com/specials-images/imageserve/68262c875b50fa837502939a/0x0.jpg?format=jpg&crop=1280,720,x0,y79,safe&height=900&width=1600&fit=bounds	2025-05-15 18:25:46
128	0.08	9	NewsAPI	MIT Backs Away From Paper Claiming Scientists Make More Discoveries with AI	The retracted paper had impressed a Nobel Prize winner in economics.	Last year, the Massachusetts Institute of Technology was touting the research of a PhD student on the impact of AI on the workforce that “floored” professors in the field. Now the university is backi… [+2314 chars]	https://gizmodo.com/mit-backs-away-from-paper-claiming-scientists-make-more-discoveries-with-ai-2000603790	https://gizmodo.com/app/uploads/2025/05/GettyImages-2579928.jpg	2025-05-17 19:30:08
129	0.08	9	NewsAPI	How Scientists Can Be Good Citizens	We have a responsibility to ensure that our discoveries are used in the public interest. That isn’t always easy.	On July 3, 1945, ten German scientists who had worked on Germany’s nuclear program were interned by the Allies at a country mansion called Farm Hall, in Godmanchester England, about 20 miles northwes… [+18996 chars]	https://www.theatlantic.com/science/archive/2025/05/how-scientists-can-be-good-citizens/682663/	https://cdn.theatlantic.com/thumbor/VoRrt1JKpm-UBtQR-lMN8I-DiVQ=/0x83:2000x1125/1200x625/media/img/mt/2025/05/Dcheuk_Atlantic_Final_horizontal/original.jpg	2025-05-04 12:15:00
130	0.08	9	NewsAPI	How tech companies could shrink AI's climate footprint	Google, Microsoft and Meta have all pledged to reach at least net-zero carbon emissions by 2030. Amazon set their net-zero deadline for 2040. To understand how these four tech companies could possibly meet their climate goals amid an artificial intelligence r…	AI is rapidly transforming how we live, work, and communicate. But can we undergo that transformation without destroying the environment?\r\nHiroshi Watanabe/Getty Images\r\nIn 2018, computer scientist S… [+2657 chars]	https://www.npr.org/2025/05/09/1250191980/-ai-google-amazon-meta-microsoft-environment	https://media.npr.org/assets/img/2025/05/08/5.9.25-ep_wide-dc624b6123a2bbe157ba52317a3b98f13f0eb04f.jpg?s=1400&c=100&f=jpeg	2025-05-09 07:00:59
131	0.08	9	NewsAPI	Conspiracy Theorists Can Be Deprogrammed	AI-delivered evidence might be better at changing minds than you are	Humans love their conspiracy theories. The Apollo moon landings were faked by covert agents in NASA to broadcast Americas technological prowess over Soviet Russia. (It was too expensive and risky to … [+6973 chars]	https://nautil.us/conspiracy-theorists-can-be-deprogrammed-1210134/	https://assets.nautil.us/sites/3/nautilus/GHu1iDML-Kazamia_HERO.png?auto=compress&fm=png&ixlib=php-3.3.1	2025-05-13 11:42:04
132	0.08	9	NewsAPI	Reddit users were subjected to AI-powered experiment without consent	Users of the r/ChangeMyView subreddit have expressed outrage at the revelation that researchers at the University of Zurich were secretly using the site for an AI-powered experiment in persuasion	The logo of the social media platform Reddit\r\nArtur Widak/NurPhoto via Getty Image\r\nReddit users who were unwittingly subjected to an AI-powered experiment have hit back at scientists for conducting … [+4183 chars]	https://www.newscientist.com/article/2478336-reddit-users-were-subjected-to-ai-powered-experiment-without-consent/	https://images.newscientist.com/wp-content/uploads/2025/04/29124741/SEI_249299022.jpg	2025-04-29 16:00:58
133	0.08	9	NewsAPI	Thinkers and Doers	Why we might need something like tenure for many more people, to cultivate more thinkers in a doer's world	Science is organized knowledge. Wisdom is organized life. \r\nImmanuel Kant\r\nScientists investigate that which already exists; Engineers create that which has never existed.\r\nTheodore von Karman\r\nThe t… [+23406 chars]	https://www.strangeloopcanon.com/p/on-thinkers-and-doers	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2Fe155133b-da9a-4959-8a29-a1e04958937e_1792x1024.png	2025-05-11 05:58:01
134	0.08	9	NewsAPI	Building The AI Polygraph	The emotional intelligence of AI, including modern polygraph-style capabilities, is something to watch as these systems evolve.	Fidelity verification. Girl passes lie detector in the office. Asking questions. Polygraph test.\r\ngetty\r\nWith all of the things that AI can now do, it stands to reason that we would ask ourselves, wh… [+5201 chars]	https://www.forbes.com/sites/johnwerner/2025/04/27/building-the-ai-polygraph/	https://imageio.forbes.com/specials-images/imageserve/680df091c88ad0839e761eb1/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-27 08:53:54
135	0.08	9	NewsAPI	AI Predicts Active Brain Cell Types With High Accuracy	A neuroscience breakthrough has been achieved using AI to identify neuron cell types from the brain activity recordings of mice and monkeys with high accuracy.	A major neuroscience breakthrough has been achieved with the help of an artificial intelligence (AI) deep learning algorithm. In a study published this month in Cell, a multinational team of twenty-t… [+3452 chars]	https://www.psychologytoday.com/us/blog/the-future-brain/202505/ai-predicts-active-brain-cell-types-with-high-accuracy	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-05/pic1095715.jpg?itok=icQyuxp_	2025-05-13 12:05:39
136	0.08	9	NewsAPI	Break Into High-Paying Data Careers Without a University Education	What if you could land a six-figure job in the booming data industry without ever setting foot in a university classroom? It’s not just a pipe dream—it’s a reality for thousands of professionals who’ve bypassed traditional education paths and carved out lucra…	What if you could land a six-figure job in the booming data industry without ever setting foot in a university classroom? Its not just a pipe dreamits a reality for thousands of professionals whove b… [+6820 chars]	https://www.geeky-gadgets.com/top-skills-for-data-careers-without-degree/	https://www.geeky-gadgets.com/wp-content/uploads/2025/05/how-to-land-six-figure-data-jobs_optimized.jpg	2025-05-10 14:03:38
137	0.08	9	NewsAPI	Scientists bamboozled by "ice piracy" where non-living glaciers are "stealing" ice	There is a phenomenon called "ice piracy," and scientists and researchers are completely bamboozled by it. Read more...	Image by Tobias Bjørkli via Pexels\r\nScientists have spotted a surprising change in Antarcticaone glacier is pulling ice away from another in a process researchers call "ice piracy." This shift, once … [+4313 chars]	https://www.neowin.net/news/scientists-bamboozled-by-ice-piracy-where-non-living-glaciers-are-stealing-ice/	https://cdn.neowin.com/news/images/uploaded/2025/05/1747341084_glacier_mountain_source_tobias_bjørkli_pexels_story.jpg	2025-05-15 20:52:02
138	0.08	9	NewsAPI	NASA explains why watching trees near volcanoes is literally the best thing to do	If you live near a volcano then you may want to start watching trees more closely from now on. NASA has explained why that is. Read more...	Image by Ashar M via Pexels\r\nScientists have discovered that trees near volcanoes change color when a volcano is becoming more active. Now, NASA and the Smithsonian Institution are teaming up to trac… [+3086 chars]	https://www.neowin.net/news/nasa-explains-why-watching-trees-near-volcanoes-is-literally-the-best-thing-to-do/	https://cdn.neowin.com/news/images/uploaded/2025/05/1748123553_volcano_tree_ashar_m_pexels_story.webp	2025-05-24 22:02:01
139	0.08	9	NewsAPI	AI Animation Tech Startup Cheehoo, Backed By Netflix Head Of Film Dan Lin, Raises $10 Million	The company wants to make the process of creating animation less expensive and complex.	L.A.-based AI animation tech start-up Cheehoo has raised $10 million in a funding round led by Greycroft and Point72 Ventures, with additional participation from Basis Set, Headline Asia, Powerhouse … [+2642 chars]	https://www.cartoonbrew.com/business/ai-animation-tech-startup-cheehoo-backed-by-netflix-head-of-film-dan-lin-raises-10-million-247058.html	https://www.cartoonbrew.com/wp-content/uploads/2025/04/cheehoo_founders.jpg	2025-05-01 03:12:46
140	0.08	9	NewsDATA	Rapid bedside test predicts sepsis with more than 90% accuracy	Canadian scientists have developed a blood test and portable device that can determine the onset of sepsis faster and more accurately than existing methods.	ONLY AVAILABLE IN PAID PLANS	https://medicalxpress.com/news/2025-05-rapid-bedside-sepsis-accuracy.html	https://scx1.b-cdn.net/csz/news/tmb/2025/rapid-bedside-test-pre.jpg	2025-05-27 16:42:04
141	0.08	9	NewsDATA	The historical figures who inspired Nvidia's product names, from Grace Hopper to David Blackwell	Nvidia chips take their names from pioneering figures in STEM fields like mathematics and computer science.	ONLY AVAILABLE IN PAID PLANS	https://www.businessinsider.com/nvidia-chips-gpu-names	https://i.insider.com/67ddbf0163d72727e197f5a7?format=jpeg	2025-05-27 16:03:46
142	0.08	9	NewsDATA	Canada Has A Chance To Lead On AI Policy And Data Governance At The 2025 G7 Leaders' Summit #Canada #Chance #Lead #Policy #Data #Governance #2025 #Leaders' #Summit #Vaccines #Pills #Doctor #Hospital #Pandemic	(MENAFN - The Conversation)Artificial intelligence (AI) is rapidly transforming sectors from health care to climate science. But amid the global scramble to lead this technological revolution, one ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109601870/Canada-Has-A-Chance-To-Lead-On-AI-Policy-And-Data-Governance-At-The-2025-G7-Leaders-Summit?Social=on	https://menafn.com/updates/pr/2025-05/27/TC_ac78dimage_story_social.jpg	2025-05-27 15:08:48
143	0.08	9	NewsDATA	Canada Has A Chance To Lead On AI Policy And Data Governance At The 2025 G7 Leaders' Summit	(MENAFN - The Conversation)Artificial intelligence (AI) is rapidly transforming sectors from health care to climate science. But amid the global scramble to lead this technological revolution, one ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109601870/Canada-Has-A-Chance-To-Lead-On-AI-Policy-And-Data-Governance-At-The-2025-G7-Leaders-Summit	https://menafn.com/updates/pr/2025-05/27/TC_ac78dimage_story.jpg	2025-05-27 15:08:48
144	0.467	10	NewsDATA	CompuGroup Medical’s CGM AMBI named 'Best AI-Assisted Software Solution' in 9th annual MedTech Breakthrough Awards	AUSTIN, TX, UNITED STATES, May 27, 2025 /EINPresswire.com/ -- CompuGroup Medical US (CGM), a leading provider of innovative healthcare IT solutions and ARIA revenue cycle management services, today announced that CGM AMBI has been selected as “Best AI-Assisted Software Solution” in the 9th annual MedTech Breakthrough Awards program conducted by MedTech Breakthrough, an independent market intelligence organization that recognizes the top companies, technologies and products in the global digital health and medical technology market. CompuGroup Medical’s CGM AMBI Ambient AI Solution enhances clinical documentation and improves patient care through AI-driven insights. CGM AMBI transcribes clinical encounters, saving time for providers and allowing for a more patient-focused, doctor-patient connection. The solution “listens to” and interprets the entire patient visit, extracting and transcribing relevant details from the doctor, patient, staff, and accompanying family members. “We are incredibly honored to receive the award for Best Integrated Ambient AI Technology, a testament to our team's relentless innovation and commitment to excellence. This recognition not only highlights our pioneering advancements in AI but also underscores our leadership in strategically investing in solutions and services that enhance both clinical and administrative domains” stated Benedikt Brueckle, Chief Executive Officer of CompuGroup Medical US. “At CGM, we believe that the future of healthcare lies in seamlessly integrating AI to improve patient outcomes and operational efficiency. This award reaffirms our mission to empower healthcare professionals with intelligent tools that drive better decisions and foster a more connected healthcare ecosystem.” CGM AMBI organizes pertinent information into the appropriate sections of the EHR note: chief complaint, history of present illness (HPI), review of systems, examination, medication, services performed, plan, and more. It also proposes diagnoses, orders, and billing codes with confidence ratings to support reporting and assist with speedier review. Its order creation works with a provider's saved templates, and providers can quickly review, edit, and send the order. The MedTech Breakthrough Awards program celebrates excellence and innovation in the health and medical technology industry. This year’s program saw a record-breaking number of nominations from leading companies and startups across more than 18 countries, showcasing the global impact and momentum of the digital healthcare industry today. “CGM AMBI improves operational efficiencies and fundamentally enhances the standard of care that patients receive,” said Steve Johansson, managing director, MedTech Breakthrough. “CGM AMBI bridges the gap between traditional healthcare practices and modern technological advancements. This innovative use of AI maximizes the efficiency of practices and reduces the risk of human error in clinical records, while also enhancing the patient experience. Congratulations on winning ‘Best AI-Assisted Software Solution!’” CompuGroup Medical’s CGM APRIMA also won the MedTech Breakthrough Award for Best Electronic Health Record solution in 2024. About CompuGroup Medical SE & Co. KGaA CompuGroup Medical is one of the leading e-health companies in the world. With a revenue base of EUR 1.19 billion in 2023, its software products are designed to support all medical and organizational activities in doctors’ offices, pharmacies, laboratories, hospitals and social welfare institutions. Its information services for all parties involved in the healthcare system and its web-based personal health records contribute towards safer and more efficient healthcare. The basis of CompuGroup Medical's services is its unique customer base, including doctors, dentists, pharmacists and other healthcare professionals in inpatient and outpatient facilities, as well as insurance and pharmaceutical companies. CompuGroup Medical has offices in 19 countries and offers its solutions in 60 countries worldwide. More than 8,700 highly qualified employees support customers with innovative solutions for the steadily growing demands of the healthcare system. About MedTech Breakthrough Part of Tech Breakthrough, a leading market intelligence and recognition platform for global technology innovation and leadership, the MedTech Breakthrough Awards program is devoted to honoring excellence and innovation in medical & health technology companies, products, services and people. The MedTech Breakthrough Awards provide a platform for public recognition around the achievements of breakthrough healthcare and medical companies and products in categories that include Patient Experience & Engagement, Health & Fitness, Medical Devices, Clinical Administration, Connected Healthcare, Medical Data, Healthcare Cybersecurity and more. For more information visit MedTechBreakthrough.com. Tech Breakthrough LLC does not endorse any vendor, product or service depicted in our recognition programs, and does not advise technology users to select only those vendors with award designations. Tech Breakthrough LLC recognition consists of the opinions of the Tech Breakthrough LLC organization and should not be construed as statements of fact. Tech Breakthrough LLC disclaims all warranties, expressed or implied, with respect to this recognition program, including any warranties of merchantability or fitness for a particular purpose.Patrick Hall CompuGroup Medical US +1 512-638-6966 patrick.hall@cgm.com Visit us on social media: LinkedIn Facebook X Other Legal Disclaimer: EIN Presswire provides this news content "as is" without warranty of any kind. We do not accept any responsibility or liability for the accuracy, content, images, videos, licenses, completeness, legality, or reliability of the information contained in this article. If you have any complaints or copyright issues related to this article, kindly contact the author above.	ONLY AVAILABLE IN PAID PLANS	https://kalkinemedia.com/news/world-news/compugroup-medicals-cgm-ambi-named-best-ai-assisted-software-solution-in-9th-annual-medtech-breakthrough-awards	https://kalkinemedia.com/storage/uploads/thumbnail/1748368123_6835fafbe3156_22251919_cgm_logo_1280x1263.jpeg	2025-05-27 11:30:00
145	0.457	10	NewsDATA	Ambience announces OpenAI-powered medical coding model that outperforms physicians	Ambience Healthcare on Tuesday announced a new medical coding AI model that outperforms doctors by 27%. The company trained the new model using OpenAI’s reinforcement fine-tuning technology. Ambience is part of the red-hot market that uses AI to draft clinical notes in real time as doctors consensually record their visits with patients.Artificial intelligence startup Ambience Healthcare on Tuesday announced a new medical coding model that outperforms doctors by 27%.Ambience uses AI to draft clinical notes in real-time as doctors consensually record their visits with patients. The company used tools from OpenAI to build the new model.The startup is part of a fiercely competitive market that has taken off as health-care executives search for solutions to help reduce staff burnout and daunting administrative workloads. The company’s new model can listen to patient encounters and identify ICD-10 codes, which are internationally standardized classifications for different diseases and conditions. There are about 70,000 ICD-10 codes that are regularly updated and used to facilitate billing and other reporting processes in health care. Ambience said its new ICD-10 model can reduce billing mistakes and help clinicians and professional coders work more efficiently. The model notched a “27% relative improvement over physician benchmarks,” according to a release on Tuesday. “We’re not replacing doctors or coders,” Brendan Fortuner, Ambience’s head of engineering, told CNBC in an interview. “What we’re doing is we’re liberating them from administration, and we’re fixing mistakes that help make health care better, safer, more cost-effective.” From ‘Cockroach Award’ to the Big Board: Hinge Health’s unlikely path to IPOHow UnitedHealthcare became the face of America’s health insurance frustrationsWhen 20,000 devices were paralyzed by a bad update, a Georgia health system turned to AppleDocumenting ICD-10 codes has traditionally been a labor-intensive task in health care, but it’s a crucial way to track outcomes, mortalities and morbidities in a standardized way, said Dr. Will Morris, the chief medical officer of Ambience.“If you think about it from a data perspective, it’s how you can compare and contrast clinician A to B, or health system A to B,” Morris said in an interview. “It’s the cornerstone for quality.”Ambience’s technology is used at more than 40 health-care organizations, like Cleveland Clinic and UCSF Health. It has raised more than $100 million, according to PitchBook, from investors including Kleiner Perkins, Andreessen Horowitz and the OpenAI Startup Fund. The company is reportedly seeking fresh capital at a valuation of over $1 billion, according to a report from The Information. Ambience declined to comment on the report. Ambience trained its new AI model using OpenAI’s reinforcement fine-tuning technology. This technology allows companies to tune OpenAI’s best reasoning models for very specific domains, like health care. To validate the model, Ambience tested it against a “gold panel” set of labels, the company said. The labels were established by a group of expert clinicians who evaluated complex clinical cases and came to an agreement on what the right codes were. Courtesy of Ambience HealthcareAmbience’s AI platform for compliant documentation, CDI, and coding.The company then recruited 18 different board-certified doctors and compared their performance on ICD-10 coding accuracy to the model’s performance. That comparison showed the Ambience technology performed 27% better than the physician baseline. “It shows for the first time that an AI system can actually surpass clinician experts at a very, very important administrative task, especially in coding,” Fortuner said. Ambience already has similar capabilities available for other medical codes like Current Procedural Terminology (CPT) codes, and Fortuner said it’s exploring how to tackle other areas like prior authorizations, utilization management and clinical trial matching. The company’s new ICD-10 model will roll out to customers over the summer.“Getting it right at the point of care is a fundamental change,” Morris said.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcphiladelphia.com/news/business/money-report/ambience-announces-openai-powered-medical-coding-model-that-outperforms-physicians/4194561/	https://media.nbcphiladelphia.com/2025/05/108150592-1748346884055-Clinician_entering_an_exam_room.jpg?fit=1700%2C1000&quality=85&strip=all	2025-05-27 09:05:25
146	0.243	10	NewsAPI	What is clinical AI?	Clinical AI deploys artificial intelligence in clinical settings, specifically to support medical decision-making and patient care.	Clinical AI deploys artificial intelligence in clinical settings, specifically to support medical decision-making and patient care. Its purpose is to improve patient outcomes within the medical care … [+6666 chars]	https://www.techtarget.com/healthtechanalytics/definition/clinical-AI	https://www.techtarget.com/ITKE/images/logos/TTlogo-379x201.png	2025-05-19 13:18:00
147	0.114	10	NewsAPI	Cutting Medicaid And SNAP Is A Risky Strategy. Here’s Why	Cutting Medicaid and SNAP will hurt millions of low income Americans. By pushing them at a time of economic uncertainty for our nation, Republicans are taking a big risk.	A patient has his blood pressure checked at a Remote Area Medical (RAM) mobile dental and medical ... More clinic in Grundy, Virginia on October 7, 2023 (Photo by Spencer Platt/Getty Images)\r\nGetty I… [+7871 chars]	https://www.forbes.com/sites/arthurkellermann/2025/05/15/cutting-medicaid-and-snap-is-a-risky-strategy-heres-why/	https://imageio.forbes.com/specials-images/imageserve/6825e2ba01cd3ed42a58ae22/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-15 17:03:31
148	0.114	10	NewsAPI	Akido lands $60M to grow AI platform for underserved healthcare settings	Artificial intelligence and care delivery company Akido Labs Inc. announced today that it has raised $60 million in new funding to expand the reach of ScopeAI, a system aimed at increasing clinical capacity and improving healthcare access. Founded in 2015, Ak…	Artificial intelligence and care delivery company Akido Labs Inc. announced today that it has raised $60 million in new funding to expand the reach of ScopeAI, a system aimed at increasing clinical c… [+3074 chars]	https://siliconangle.com/2025/05/15/akido-lands-60m-grow-ai-platform-underserved-healthcare-settings/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2025/05/akido.png	2025-05-15 23:12:01
149	0.114	10	NewsAPI	Rocket Doctor Named Clinical Innovator of the Year at NEXUS 2025	Recognition highlights Rocket Doctor’s leadership in advancing physician-led virtual care models across North America Recognition highlights Rocket Doctor’s leadership in advancing physician-led virtual care models across North America	<ul><li>Rocket Doctor named Clinical Innovator of the Year at the Innovators Challenge during NEXUS 2025 in New Orleans.</li><li>Award recognizes Rocket Doctors physician-led virtual care model, desi… [+6775 chars]	https://www.globenewswire.com/news-release/2025/05/06/3075195/0/en/Rocket-Doctor-Named-Clinical-Innovator-of-the-Year-at-NEXUS-2025.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-06 13:41:00
150	0.114	10	NewsAPI	Treatment.com AI and Rocket Doctor Applaud US Health Secretary RFK Jr.’s Call for Greater Investment in Telehealth and AI-Driven Diagnostic Tools	‏VANCOUVER, BC, May 15, 2025 (GLOBE NEWSWIRE) -- Treatment.com AI Inc. (CSE: TRUE, OTC: TREIF, Frankfurt: 939) (“Treatment”) and Rocket Doctor, its wholly owned online care platform, applaud United States Secretary of Health and Human Services, Robert F. Kenn…	<ul><li>RFK Jr. calls for a revolution in telehealth and AI to reduce ER visits and improve at-home care.</li><li>Treatment.com AI and Rocket Doctor applaud the remarks, citing strong alignment with … [+7367 chars]	https://www.globenewswire.com/news-release/2025/05/15/3082244/0/en/Treatment-com-AI-and-Rocket-Doctor-Applaud-US-Health-Secretary-RFK-Jr-s-Call-for-Greater-Investment-in-Telehealth-and-AI-Driven-Diagnostic-Tools.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-15 13:02:00
151	0.114	10	NewsAPI	Empowering refugee voices: Using Nominal Group Technique (NGT) with a diverse refugee Patient Advisory Committee (PAC) to identify health and research priorities in Calgary, Canada	Background Despite rising forced displacement globally, refugees’ health and research priorities are largely unknown. We investigated whether a diverse refugee committee could utilize participatory methods to identify health priorities and a research agenda t…	Citation: Altahsh D, Holdbrook L, Norrie E, Sahilie A, Essar MY, Grewal R, et al. (2025) Empowering refugee voices: Using Nominal Group Technique (NGT) with a diverse refugee Patient Advisory Committ… [+29784 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0323746	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0323746.g005&size=inline	2025-05-09 14:00:00
152	0.114	10	NewsAPI	Patient satisfaction with general practice in Scotland 2011/12 to 2021/22	Background The Scottish Government introduced the first phase of a new General Practice (GP) contract in 2018, aiming to transform primary care and address health inequalities. However, the impact of these changes on patient satisfaction is unclear.   Aim To …	Abstract\r\nBackground\r\nThe Scottish Government introduced the first phase of a new General Practice (GP) contract in 2018, aiming to transform primary care and address health inequalities. However, th… [+38651 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322095	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322095.g004&size=inline	2025-04-30 14:00:00
153	0.114	10	NewsAPI	California’s Primary Care Shortage Persists Despite Ambitious Moves To Close Gap	The state has in recent years embraced several initiatives recommended in an influential health care workforce report, including alternative payment arrangements for primary care doctors to earn more. Despite increasing residency programs, student debt forgiv…	Bernard J. Wolfson and Vanessa G. SánchezSumana Reddy, a primary care physician, struggles on thin financial margins to run Acacia Family Medical Group, the small independent practice she founded 27 … [+12012 chars]	https://kffhealthnews.org/news/article/california-primary-care-shortage-persists-workforce-report-years-later/	https://kffhealthnews.org/wp-content/uploads/sites/2/2025/05/Acacia_01-resized.jpg	2025-05-01 09:00:00
154	0.114	10	NewsDATA	Reducing Medical Communication Barriers with AI Avatars	Effective communication is the cornerstone of high-quality healthcare. Whether it’s between doctor and patient, among medical staff, or across public health initiatives, accurate and clear communication directly influences patient outcomes, safety, and satisfaction. However, despite advances in medicine and technology, communication barriers persist. Language differences, hearing impairments, health literacy challenges, and even time constraints often [...]	ONLY AVAILABLE IN PAID PLANS	https://startupnews.fyi/2025/05/27/reducing-medical-communication-barriers-with-ai-avatars/	https://startupnews.fyi/wp-content/uploads/2025/05/WhatsApp-Image-2025-05-27-at-12.39.49_1b955763.jpg	2025-05-27 07:18:09
155	0	10	NewsAPI	Apple highlights how its ecosystem is ‘transforming patient care’ at Emory Hillandale Hospital	In a new feature story on its Newsroom today, Apple showcases how iPhones, iPads, and Apple Watches are being used by doctors and nurses at one of Georgia’s largest health systems. And while the piece suffers from a chronic case of PR-speak, the project is pr…	In a new feature story on its Newsroom today, Apple showcases how iPhones, iPads, and Apple Watches are being used by doctors and nurses at one of Georgias largest health systems. And while the piece… [+2181 chars]	https://9to5mac.com/2025/05/22/apple-highlights-at-emory-hillandale-hospital/	https://i0.wp.com/9to5mac.com/wp-content/uploads/sites/6/2025/05/iphone-hospital.jpg?resize=1200%2C628&quality=82&strip=all&ssl=1	2025-05-22 19:52:23
156	0	10	NewsAPI	Top Three Ways Clinicians Are Using AI To Maximize ROI	If you were to ask a doctor, nurse practitioner, or therapist why they first entered medicine, the most common answer would be to heal and care for others.	Red arrow over stack of money coins arranged as a graph on wood table with blurry the doctor ... More stethoscope around neck a scene in the back, concept of financial health and medical expenses\r\nge… [+5764 chars]	https://www.forbes.com/sites/jaimecatmull/2025/05/05/top-three-ways-clinicians-are-using-ai-to-maximize-roi/	https://imageio.forbes.com/specials-images/imageserve/6818e08aeefb0aaab6f1e001/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 16:20:49
157	0	10	NewsAPI	3 Ways The $41 Billion Agentic AI Market Is Reshaping The Future Of Work	With AI agents, workflows are delegated, not just automated; healthcare moves from fragmented to intelligent; and enterprise operations shift from reactive to proactive.	Agentic AI: the future of work beyond automation\r\ngetty\r\nThe future of work is arriving not with a whisper, but with a powerful shift led by agentic AI, projected to fuel a $41.32 billion market by 2… [+5060 chars]	https://www.forbes.com/sites/saharhashmi/2025/05/26/3-ways-the-41-billion-agentic-ai-market-is-reshaping-the-future-of-work/	https://imageio.forbes.com/specials-images/imageserve/68300746147af377265cf185/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-27 03:19:04
158	0	10	NewsAPI	Scarlett McNally: Fixing postgraduate training requires rebalancing funding and workload	NHS England is making its last call for evidence for a review on postgraduate medical education.1 There have been dozens of similar reviews in my 35 years as a doctor, but this one has a chance to make a difference. It must galvanise action to deliver the med…	<ol><li>Scarlett McNally, professor</li></ol><ol><li>Eastbourne\r\n</li></ol><ol><li>scarlettmcnally{at}cantab.netFollow Scarlett on X @scarlettmcnally</li></ol>\r\nNHS England is making its last call fo… [+5431 chars]	https://www.bmj.com/content/389/bmj.r945	https://www.bmj.com/sites/default/files/highwire/bmj/389/8463.cover-source.jpg	2025-05-15 15:16:10
159	0	10	NewsAPI	What Serving as an Expert Witness Taught Me About the Practice of Medicine	I recently served as a defendant's expert witness in a medical-legal case, and it profoundly changed my perspective on medical practice.\nThe post What Serving as an Expert Witness Taught Me About the Practice of Medicine appeared first on The White Coat Inves…	During the pandemic, like many healthcare professionals, I sought additional income through chart review work. This led to an unexpected role as a defendant's expert witness in a medical-legal case i… [+8557 chars]	https://www.whitecoatinvestor.com/lessons-about-medicine-from-an-expert-witness/	https://www.whitecoatinvestor.com/wp-content/uploads/2025/05/What-Serving-as-an-Expert-Witness-Taught-Me-About-the-Practice-of-Medicine.png	2025-05-03 06:30:43
160	0	10	NewsAPI	Access Health: NCQA President: Quality Systems Manage This "Like Crazy"	CFOs' new job descriptions and physicians' "pajama time" problems.	Each week, I jot down a few quotes that stick with me. Sometimes they're from interviews, other times they're from news articles or LinkedIn posts and—occasionally—I dig around in an industry report … [+15308 chars]	https://www.newsweek.com/access-health-ncqa-president-quality-healthcare-systems-management-2075824	https://d.newsweek.com/en/full/2649766/ai-impact-summit-banner.jpg	2025-05-22 15:48:41
161	0	10	NewsAPI	Rocket Doctor Partners with Melanoma Canada to Expand Access to Follow-Up Care for At-Risk Patients	‎‎ New collaboration will connect patients flagged during mobile skin cancer screenings with Rocket Doctor physicians across Ontario, Alberta, and British Columbia	New collaboration will connect patients flagged during mobile skin cancer screenings with Rocket Doctor physicians across Ontario, Alberta, and British Columbia\r\nRocket Doctor has partnered with Mela… [+7458 chars]	https://www.globenewswire.com/news-release/2025/05/20/3084555/0/en/Rocket-Doctor-Partners-with-Melanoma-Canada-to-Expand-Access-to-Follow-Up-Care-for-At-Risk-Patients.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-20 07:00:00
162	0	10	NewsAPI	Empowering IBD patients: tools for managing symptoms between doctor visits [PODCAST]	Gastroenterologist Shamita B. Shah discusses her article, "How doctors can help IBD patients manage symptoms between visits." Addressing the rising prevalence of inflammatory bowel disease (IBD) in the U.S., Shamita highlights the challenges patients face man…	Subscribe to The Podcast by KevinMD. Watch on YouTube. Catch up on old episodes!\r\nGastroenterologist Shamita B. Shah discusses her article, “How doctors can help IBD patients manage symptoms between … [+19177 chars]	https://kevinmd.com/2025/05/empowering-ibd-patients-tools-for-managing-symptoms-between-doctor-visits.html	https://kevinmd.com/wp-content/uploads/Design-2-scaled.jpg	2025-05-19 23:00:42
163	0	10	NewsAPI	Registered dietitians on your care team [PODCAST]	Registered dietitian Ava Safir and physician advocate Kim Downey discuss their article, "Why patients need a registered dietitian on their health care team." They highlight the often-overlooked yet crucial role registered dietitians play in improving patient …	Subscribe to The Podcast by KevinMD. Watch on YouTube. Catch up on old episodes!\r\nRegistered dietitian Ava Safir and physician advocate Kim Downey discuss their article, “Why patients need a register… [+20842 chars]	https://kevinmd.com/2025/05/registered-dietitians-on-your-care-team-podcast.html	https://kevinmd.com/wp-content/uploads/Design-4-scaled.jpg	2025-05-24 23:00:08
164	0.229	11	NewsAPI	Stop Being The Smartest Person In The Room	Avoid “Smartest Person in the Room Syndrome.” A physician who wants to make the best decisions possible must recognize that other people have valuable perspectives.	A physician who wants to make the best decisions possible must recognize that other people have valuable lenses through which they view the situation.\r\ngetty\r\nIn a field as complex and fast-changing … [+3724 chars]	https://www.forbes.com/sites/forbesbooksauthors/2025/04/30/stop-being-the-smartest-person-in-the-room/	https://imageio.forbes.com/specials-images/imageserve/6810f95c66de6fa2d369c82c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-30 15:00:00
165	0.114	11	NewsAPI	Is Alignment Healthcare (ALHC) the Best Performing Healthcare Stock to Buy Now?	We recently published a list of 11 Best Performing Healthcare Stocks to Buy Now. In this article, we are going to take a look at where Alignment Healthcare, ...	We recently published a list of 11 Best Performing Healthcare Stocks to Buy Now. In this article, we are going to take a look at where Alignment Healthcare, Inc. (NASDAQ:ALHC) stands against other be… [+5220 chars]	https://finance.yahoo.com/news/alignment-healthcare-alhc-best-performing-211432067.html	https://s.yimg.com/ny/api/res/1.2/GcBf7n29YhsPa0Q28dHsAQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD02NzM-/https://media.zenfs.com/en/insidermonkey.com/32ddfbd5bc680cb2485e975dac4619dd	2025-05-11 21:14:32
166	0.114	11	NewsAPI	I asked ChatGPT, Gemini, and other AIs how to combat aging, and only one did the right thing	On the question of how to combat aging, these AIs have almost all the answers.	Age is just a number, or so people entering late middle age like to say. It's also inevitable. No matter where you are on life's journey, you are growing up, getting older, slouching toward expiratio… [+7082 chars]	https://www.techradar.com/computing/artificial-intelligence/i-asked-chatgpt-gemini-and-other-ais-how-to-combat-aging-and-only-one-did-the-right-thing	https://cdn.mos.cms.futurecdn.net/PMBNEMzg4nDCgM7jKzSaGN.jpg	2025-05-05 15:06:00
167	0.114	11	NewsAPI	Our Gear Editor And Vascular Experts Pick The Best Compression Socks	Compression socks reduce swelling, manage pain and aid in recovery by promoting blood flow. Some of the best compression socks are from Duluth Trading, Bombas, and Figs.	Compression socks are a simple yet effective way to boost circulation, reduce swelling and fight fatigue, whether youre recovering from a tough workout or managing poor circulation. The best compress… [+14774 chars]	https://www.forbes.com/sites/forbes-personal-shopper/article/the-best-compression-socks/	https://imageio.forbes.com/specials-images/imageserve/6824c273f13d9bf7fbee208b/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-14 16:20:27
168	0	11	NewsAPI	I quit my healthcare job to take care of my grandmother. It's a mix of happy and sad moments, but ultimately has been life-changing for us.	Kristina McDonald quit her full-time job last year. While she plans to work again, she's been helping her family care for her grandmother full time.	Kristina McDonald talked to Business Insider about the happy and sad moments of caring for her grandmother.Kristina McDonald\r\n<ul><li>Kristina McDonald quit her job to take care of her grandmother fu… [+6605 chars]	https://www.businessinsider.com/caregiving-quit-job-to-take-care-of-grandmother-2025-5	https://i.insider.com/682f375468a2929008020628?width=1200&format=jpeg	2025-05-26 08:07:01
169	0	11	NewsAPI	Blue Shield exposed 4.7M patients’ health data to Google	Health insurance giant Blue Shield of California confirmed it had been sharing private health data of 4.7 million users with Google for three years without even realizing it.	Healthcare institutions and insurers arguably collect the most sensitive information about you, including IDs, contact details, addresses and medical records. But they often dont put in the same leve… [+8943 chars]	https://www.foxnews.com/tech/blue-shield-exposed-4-7m-patients-health-data-google-2	https://static.foxnews.com/foxnews.com/content/uploads/2025/04/3-blue-shield-of-california-leaks-4.7-million-members-protected-health-data-outro.jpg	2025-04-27 14:00:20
170	0	11	NewsAPI	A boomer couldn't retire on $1,428 a month in Social Security, so she moved to France for cheaper rent and a vibrant social life: 'Everything about living here is just better'	Celestine Cooley, 74, couldn't afford to retire in Los Angeles, so she moved to Bordeaux, France, where life is cheaper and more exciting.	Celestine Cooley, 74, moved to Bordeaux, France, to retire after living and working in Los Angeles for almost 50 years.Courtesy of Celestine Cooley\r\n<ul><li>Celestine Cooley moved to Bordeaux, France… [+5067 chars]	https://www.businessinsider.com/boomer-moved-france-retirement-travel-social-security-bordeaux-housing-costs-2025-5	https://i.insider.com/680fd1a03fe8d392836445d0?width=710&format=jpeg	2025-05-04 08:06:01
171	0	11	NewsAPI	Our post-SSRI era: A new network of clinics is opening up to help people wean off antidepressants	A new network of online clinics called Outro aims to get people off antidepressants — slowly.	iStock, Getty Images\r\n<ul><li>Many patients end up "parked" on antidepressant meds.</li><li>It can be tough to quit on your own. Withdrawal symptoms can range from mild to severe.</li><li>A first-of-… [+8611 chars]	https://www.businessinsider.com/how-to-quit-antidepressants-online-clinic-outro-tapering-microdosing-2025-5	https://i.insider.com/6823bcbec6ad288d1480d972?width=1200&format=jpeg	2025-05-14 09:01:01
172	0	11	NewsAPI	Smartinhaler ensures effective asthma treatment when it’s needed	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017; now its makers want it to be available to Aussie asthmatics…	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017;… [+4094 chars]	https://newatlas.com/medical-devices/adherium-hailie-smartinhaler-asthma-control/	https://assets.newatlas.com/dims4/default/bdaa95b/2147483647/strip/true/crop/2000x1050+0+38/resize/1200x630!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fee%2F9a%2Faa2690dc4db0a8472e60ef499a0f%2Fbanner-our-technology-2023.jpg&na.image_optimisation=0	2025-05-15 04:22:40
173	0	11	NewsAPI	You're misunderstanding DDD in Angular (and Front end)	Motivation\n\nIn the recent year or two I've seen lots of discussions around building Domain-Driven Design in Angular applications. My observation is that people discuss things that are orthogonal to DDD at best - or even totally derailed from what DDD is about…	Motivation\r\nIn the recent year or two I've seen lots of discussions around building Domain-Driven Design in Angular applications. My observation is that people discuss things that are orthogonal to D… [+30345 chars]	https://www.angularspace.com/youre-misunderstanding-ddd-in-angular-and-frontend/	https://www.angularspace.com/content/images/size/w1200/2025/05/angularspacethumb-erick--24-.jpg	2025-05-16 08:13:16
174	0	11	NewsAPI	SEO For Healthcare: How Multi-Specialty Clinics Can Boost Visibility	For multi-specialty practices, ranking for search queries takes more than a single Google Business Profile, yet many still rely on outdated setups.	Oleg Levitas, a visionary SEO Expert, founded Pravda SEO to revolutionize how local businesses dominate search rankings.\r\ngetty\r\nWhen prospective patients search for a clinic online, they typically a… [+6745 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/04/30/seo-for-healthcare-how-multi-speciality-clinics-can-boost-visibility/	https://imageio.forbes.com/specials-images/imageserve/6810efe73ca233d3c7cdb060/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-30 13:45:00
175	0	11	NewsAPI	Money and masculinity: How wellness became big business and changed American health culture	In the first months of Donald Trump’s second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F. Kennedy Jr.Read more...	In the first months of Donald Trumps second presidency, the world of American healthcare has seen rapid transformations, largely at the behest of his Secretary of Health and Human Services, Robert F.… [+10134 chars]	https://qz.com/rfk-wellness-business-health-culture-1851779931	https://i.kinja-img.com/image/upload/c_fill,h_675,pg_1,q_80,w_1200/862a2698550a07275b939efe0ca1808c.jpg	2025-05-15 09:00:00
176	0	11	NewsAPI	Providing Choice With Employee Healthcare	As healthcare continues to top the list of employee priorities, ICHRA gives employers a modern advantage.	Jack Hooper is the CEO of Take Command, an ICHRA administrator that helps employers reimburse for health insurance. \r\ngetty\r\nIn the United States, were used to employers choosing their employees' hea… [+4857 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/05/20/providing-choice-with-employee-healthcare/	https://imageio.forbes.com/specials-images/imageserve/682b381d1cfb04463a0fb3c9/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 11:15:00
177	0	11	NewsAPI	Fired FTC commissioners on fighting for their jobs back	Today, we have something special for you: A few days ago, I hosted a panel with FTC commissioners Rebecca Slaughter and Alvaro Bedoya at the IAPP Global Privacy Summit in Washington, DC. We recorded the discussion, and we’re bringing it to you today. That’s a…	Fired FTC commissioners on fighting for their jobs back\r\nAlvaro Bedoya and Rebecca Slaughter want to take their fight to the Supreme Court, and they think they can win.\r\nFired FTC commissioners on fi… [+45090 chars]	https://www.theverge.com/decoder-podcast-with-nilay-patel/657115/ftc-bedoya-slaughter-trump-fired-supreme-court-interview	https://platform.theverge.com/wp-content/uploads/sites/2/2025/04/DCD-Bedoya-Slaughter-2.png?quality=90&strip=all&crop=0%2C10.711631919237%2C100%2C78.576736161526&w=1200	2025-04-28 14:00:17
178	0	11	NewsAPI	9 Ways to Tick Off Your Patients	Personal Perspective: Healthcare is a service industry. If we forget this, and focus only on the medical problem at hand, we risk patient disaffection and dissatisfaction.	We live in miraculous times. We have treatmentsoften very effective treatmentsfor so many of the ailments that have plagued humankind for millennia. In fact, our interventions are so effective, that … [+6363 chars]	https://www.psychologytoday.com/us/blog/rich-encounters/202505/9-ways-to-tick-off-your-patients	https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/teaser_image/blog_entry/2025-05/Screenshot%202025-05-02%20at%202.53.29%E2%80%AFPM.png.jpg?itok=3KDMrk2-	2025-05-02 20:07:29
179	0	11	NewsAPI	How Chargers' Derwin James Jr. became University of Bridgeport's commencement speaker	The Chargers' defensive leader showed his versatility while addressing Bridgeport's graduating class.	LOS ANGELES -- In between Chargers recent offseason workouts, safety Derwin James Jr. leaned on his teammates for advice. James had agreed to be the commencement speaker at the University of Bridgepo… [+3750 chars]	https://www.espn.com/nfl/story/_/id/44998264/los-angeles-chargers-safety-derwin-james-jr-bridgeport-commencement-speaker-2025	https://a1.espncdn.com/combiner/i?img=%2Fphoto%2F2025%2F0504%2Fr1488011_1296x729_16%2D9.jpg	2025-05-05 11:41:19
180	0	11	NewsAPI	Mastering Healthcare SEO: How Patients In Your Area Can Find You Online	Implementing a comprehensive and ethical SEO strategy is vital for healthcare providers aiming to enhance their online presence and connect with local patients.	Lauren Parr is the co-founder and Product Director at RepuGen, one of the leading healthcare reputation management platforms. \r\ngetty\r\nImagine a patient in your area searching online for a healthcare… [+7200 chars]	https://www.forbes.com/councils/forbescommunicationscouncil/2025/05/08/mastering-healthcare-seo-how-patients-in-your-area-can-find-you-online/	https://imageio.forbes.com/specials-images/imageserve/681b5ab201ccd8be71602118/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 11:30:00
181	0	11	NewsAPI	Technology In Nursing Education: A Transformative Shift	The healthcare sector has embraced digital tools, and nursing education has followed suit, integrating telehealth, virtual simulations, and online platforms.	By Kimberly Nerud, PhD, RN &amp; Yolanda Smith, EdD, MSN, RN\r\nPOST UNIVERSITY\r\nThe landscape of nursing education is changing rapidly, and as leaders in nursing education who have experienced firstha… [+12894 chars]	https://www.forbes.com/sites/post-university/2025/05/01/technology-in-nursing-education-a-transformative-shift/	https://imageio.forbes.com/specials-images/imageserve/680fed8430db329dbe5ab56c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 13:08:26
182	0	11	NewsAPI	From Hype To Infrastructure: The Great Compression Of Health AI	Within healthcare, the AI arms race will be won by those who build quietly, partner wisely and think long term.	Amber Nigam is CEO and cofounder of basys.ai, a Harvard-based company streamlining prior authorization for health plans with generative AI.\r\ngetty\r\nThe generative AI boom in healthcare feels inevitab… [+6582 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/05/20/from-hype-to-infrastructure-the-great-compression-of-health-ai/	https://imageio.forbes.com/specials-images/imageserve/682b3cf646ddfbf9cc2bff24/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-20 13:45:00
183	0	11	NewsAPI	Exclusive: Ginko Raises $1.5M To Launch The First Doctor-Backed Digital Wellness App For Families	Meet Ginko, by the self-proclaimed "Alex Cooper of digital wellness, without the swear words" and a clinical psychiatrist. Here to help kids chase dreams, not screens.	Cofounders of Ginko, Dr. Raghu Appasani and Larissa "Larz" May, Photo Credit: KTSura\r\nPhoto Credit: KTSura\r\nWhen Larissa May (known to most as Larz) was a college student navigating anxiety and depre… [+8687 chars]	https://www.forbes.com/sites/karineldor/2025/05/07/exclusive-ginko-raises-15m-to-launch-the-first-doctor-backed-digital-wellness-app-for-families/	https://imageio.forbes.com/specials-images/imageserve/681b9652da3b99c70333f696/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-07 17:39:17
184	0.633	12	NewsDATA	CompuGroup Medical’s CGM AMBI named 'Best AI-Assisted Software Solution' in 9th annual MedTech Breakthrough Awards	AUSTIN, TX, UNITED STATES, May 27, 2025 /EINPresswire.com/ -- CompuGroup Medical US (CGM), a leading provider of innovative healthcare IT solutions and ARIA revenue cycle management services, today announced that CGM AMBI has been selected as “Best AI-Assisted Software Solution” in the 9th annual MedTech Breakthrough Awards program conducted by MedTech Breakthrough, an independent market intelligence organization that recognizes the top companies, technologies and products in the global digital health and medical technology market. CompuGroup Medical’s CGM AMBI Ambient AI Solution enhances clinical documentation and improves patient care through AI-driven insights. CGM AMBI transcribes clinical encounters, saving time for providers and allowing for a more patient-focused, doctor-patient connection. The solution “listens to” and interprets the entire patient visit, extracting and transcribing relevant details from the doctor, patient, staff, and accompanying family members. “We are incredibly honored to receive the award for Best Integrated Ambient AI Technology, a testament to our team's relentless innovation and commitment to excellence. This recognition not only highlights our pioneering advancements in AI but also underscores our leadership in strategically investing in solutions and services that enhance both clinical and administrative domains” stated Benedikt Brueckle, Chief Executive Officer of CompuGroup Medical US. “At CGM, we believe that the future of healthcare lies in seamlessly integrating AI to improve patient outcomes and operational efficiency. This award reaffirms our mission to empower healthcare professionals with intelligent tools that drive better decisions and foster a more connected healthcare ecosystem.” CGM AMBI organizes pertinent information into the appropriate sections of the EHR note: chief complaint, history of present illness (HPI), review of systems, examination, medication, services performed, plan, and more. It also proposes diagnoses, orders, and billing codes with confidence ratings to support reporting and assist with speedier review. Its order creation works with a provider's saved templates, and providers can quickly review, edit, and send the order. The MedTech Breakthrough Awards program celebrates excellence and innovation in the health and medical technology industry. This year’s program saw a record-breaking number of nominations from leading companies and startups across more than 18 countries, showcasing the global impact and momentum of the digital healthcare industry today. “CGM AMBI improves operational efficiencies and fundamentally enhances the standard of care that patients receive,” said Steve Johansson, managing director, MedTech Breakthrough. “CGM AMBI bridges the gap between traditional healthcare practices and modern technological advancements. This innovative use of AI maximizes the efficiency of practices and reduces the risk of human error in clinical records, while also enhancing the patient experience. Congratulations on winning ‘Best AI-Assisted Software Solution!’” CompuGroup Medical’s CGM APRIMA also won the MedTech Breakthrough Award for Best Electronic Health Record solution in 2024. About CompuGroup Medical SE & Co. KGaA CompuGroup Medical is one of the leading e-health companies in the world. With a revenue base of EUR 1.19 billion in 2023, its software products are designed to support all medical and organizational activities in doctors’ offices, pharmacies, laboratories, hospitals and social welfare institutions. Its information services for all parties involved in the healthcare system and its web-based personal health records contribute towards safer and more efficient healthcare. The basis of CompuGroup Medical's services is its unique customer base, including doctors, dentists, pharmacists and other healthcare professionals in inpatient and outpatient facilities, as well as insurance and pharmaceutical companies. CompuGroup Medical has offices in 19 countries and offers its solutions in 60 countries worldwide. More than 8,700 highly qualified employees support customers with innovative solutions for the steadily growing demands of the healthcare system. About MedTech Breakthrough Part of Tech Breakthrough, a leading market intelligence and recognition platform for global technology innovation and leadership, the MedTech Breakthrough Awards program is devoted to honoring excellence and innovation in medical & health technology companies, products, services and people. The MedTech Breakthrough Awards provide a platform for public recognition around the achievements of breakthrough healthcare and medical companies and products in categories that include Patient Experience & Engagement, Health & Fitness, Medical Devices, Clinical Administration, Connected Healthcare, Medical Data, Healthcare Cybersecurity and more. For more information visit MedTechBreakthrough.com. Tech Breakthrough LLC does not endorse any vendor, product or service depicted in our recognition programs, and does not advise technology users to select only those vendors with award designations. Tech Breakthrough LLC recognition consists of the opinions of the Tech Breakthrough LLC organization and should not be construed as statements of fact. Tech Breakthrough LLC disclaims all warranties, expressed or implied, with respect to this recognition program, including any warranties of merchantability or fitness for a particular purpose.Patrick Hall CompuGroup Medical US +1 512-638-6966 patrick.hall@cgm.com Visit us on social media: LinkedIn Facebook X Other Legal Disclaimer: EIN Presswire provides this news content "as is" without warranty of any kind. We do not accept any responsibility or liability for the accuracy, content, images, videos, licenses, completeness, legality, or reliability of the information contained in this article. If you have any complaints or copyright issues related to this article, kindly contact the author above.	ONLY AVAILABLE IN PAID PLANS	https://kalkinemedia.com/news/world-news/compugroup-medicals-cgm-ambi-named-best-ai-assisted-software-solution-in-9th-annual-medtech-breakthrough-awards	https://kalkinemedia.com/storage/uploads/thumbnail/1748368123_6835fafbe3156_22251919_cgm_logo_1280x1263.jpeg	2025-05-27 11:30:00
185	0.4	12	NewsDATA	Ambience announces OpenAI-powered medical coding model that outperforms physicians	Ambience Healthcare on Tuesday announced a new medical coding AI model that outperforms doctors by 27%. The company trained the new model using OpenAI’s reinforcement fine-tuning technology. Ambience is part of the red-hot market that uses AI to draft clinical notes in real time as doctors consensually record their visits with patients.Artificial intelligence startup Ambience Healthcare on Tuesday announced a new medical coding model that outperforms doctors by 27%.Ambience uses AI to draft clinical notes in real-time as doctors consensually record their visits with patients. The company used tools from OpenAI to build the new model.The startup is part of a fiercely competitive market that has taken off as health-care executives search for solutions to help reduce staff burnout and daunting administrative workloads. The company’s new model can listen to patient encounters and identify ICD-10 codes, which are internationally standardized classifications for different diseases and conditions. There are about 70,000 ICD-10 codes that are regularly updated and used to facilitate billing and other reporting processes in health care. Ambience said its new ICD-10 model can reduce billing mistakes and help clinicians and professional coders work more efficiently. The model notched a “27% relative improvement over physician benchmarks,” according to a release on Tuesday. “We’re not replacing doctors or coders,” Brendan Fortuner, Ambience’s head of engineering, told CNBC in an interview. “What we’re doing is we’re liberating them from administration, and we’re fixing mistakes that help make health care better, safer, more cost-effective.” From ‘Cockroach Award’ to the Big Board: Hinge Health’s unlikely path to IPOHow UnitedHealthcare became the face of America’s health insurance frustrationsWhen 20,000 devices were paralyzed by a bad update, a Georgia health system turned to AppleDocumenting ICD-10 codes has traditionally been a labor-intensive task in health care, but it’s a crucial way to track outcomes, mortalities and morbidities in a standardized way, said Dr. Will Morris, the chief medical officer of Ambience.“If you think about it from a data perspective, it’s how you can compare and contrast clinician A to B, or health system A to B,” Morris said in an interview. “It’s the cornerstone for quality.”Ambience’s technology is used at more than 40 health-care organizations, like Cleveland Clinic and UCSF Health. It has raised more than $100 million, according to PitchBook, from investors including Kleiner Perkins, Andreessen Horowitz and the OpenAI Startup Fund. The company is reportedly seeking fresh capital at a valuation of over $1 billion, according to a report from The Information. Ambience declined to comment on the report. Ambience trained its new AI model using OpenAI’s reinforcement fine-tuning technology. This technology allows companies to tune OpenAI’s best reasoning models for very specific domains, like health care. To validate the model, Ambience tested it against a “gold panel” set of labels, the company said. The labels were established by a group of expert clinicians who evaluated complex clinical cases and came to an agreement on what the right codes were. Courtesy of Ambience HealthcareAmbience’s AI platform for compliant documentation, CDI, and coding.The company then recruited 18 different board-certified doctors and compared their performance on ICD-10 coding accuracy to the model’s performance. That comparison showed the Ambience technology performed 27% better than the physician baseline. “It shows for the first time that an AI system can actually surpass clinician experts at a very, very important administrative task, especially in coding,” Fortuner said. Ambience already has similar capabilities available for other medical codes like Current Procedural Terminology (CPT) codes, and Fortuner said it’s exploring how to tackle other areas like prior authorizations, utilization management and clinical trial matching. The company’s new ICD-10 model will roll out to customers over the summer.“Getting it right at the point of care is a fundamental change,” Morris said.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcphiladelphia.com/news/business/money-report/ambience-announces-openai-powered-medical-coding-model-that-outperforms-physicians/4194561/	https://media.nbcphiladelphia.com/2025/05/108150592-1748346884055-Clinician_entering_an_exam_room.jpg?fit=1700%2C1000&quality=85&strip=all	2025-05-27 09:05:25
186	0.329	12	NewsAPI	What is clinical AI?	Clinical AI deploys artificial intelligence in clinical settings, specifically to support medical decision-making and patient care.	Clinical AI deploys artificial intelligence in clinical settings, specifically to support medical decision-making and patient care. Its purpose is to improve patient outcomes within the medical care … [+6666 chars]	https://www.techtarget.com/healthtechanalytics/definition/clinical-AI	https://www.techtarget.com/ITKE/images/logos/TTlogo-379x201.png	2025-05-19 13:18:00
187	0.1	12	NewsAPI	Our Healthcare Infrastructure Deserves Better Cybersecurity	Adopting PQC now isn’t just about responding to future threats—it's an opportunity to make a strategic, long-term investment in the security of your patient’s data.	Ali El Kaafarani is founder and CEO of PQShield, a British cybersecurity startup specializing in quantum-secure solutions.\r\ngetty\r\nWe trust the healthcare system with vast amounts of sensitive data a… [+6495 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/05/01/our-healthcare-infrastructure-deserves-better-cybersecurity/	https://imageio.forbes.com/specials-images/imageserve/643983780a9290602c6b19d2/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-01 10:15:00
188	0.1	12	NewsAPI	Concerns raised over prescribing boom of 'Chernobyl-strength' medicinal cannabis	New data has revealed alarming practices in the prescribing of medicinal cannabis, with one doctor appearing to issue a script every 4 minutes.	Australian medical practitioners are writing scripts for high-strength medicinal cannabis products with alarming speed, raising concerns some are putting "profit over patient safety", according to th… [+12984 chars]	https://www.abc.net.au/news/2025-05-19/medicinal-cannabis-ahpra-prescription-boom/105295086	https://live-production.wcms.abc-cdn.net.au/accc46ec03bd7daca7bf819b2f99cb4f?impolicy=wcms_watermark_news&cropH=2813&cropW=5000&xPos=0&yPos=321&width=862&height=485&imformat=generic	2025-05-18 18:43:25
189	0.1	12	NewsAPI	U.S. Patient Referral Management Software Market Trends Analysis Report 2025-2030: Increasing Demand for Coordinated Care and Rising Adoption of Healthcare IT and Digital Health Platforms Fuel Growth	Growth is attributed to the growing emphasis on enhancing care coordination among healthcare providers, fueled by the shift toward value-based care models. The increasing adoption of healthcare IT and digital platforms has created a favorable environment for …	Dublin, May 22, 2025 (GLOBE NEWSWIRE) -- The "U.S. Patient Referral Management Software Market Size, Share &amp; Trends Analysis Report by Type (Inbound, Outbound), Deployment Mode (Cloud &amp; Web-b… [+4264 chars]	https://www.globenewswire.com/news-release/2025/05/22/3086821/28124/en/U-S-Patient-Referral-Management-Software-Market-Trends-Analysis-Report-2025-2030-Increasing-Demand-for-Coordinated-Care-and-Rising-Adoption-of-Healthcare-IT-and-Digital-Health-Plat.html	https://ml.globenewswire.com/Resource/Download/908fb457-7f8e-4a08-9081-5565e3dfb3d7	2025-05-22 14:23:00
190	0.1	12	NewsAPI	The All New WHOOP: The World’s Most Powerful Health Wearable	WHOOP is redefining what a health wearable can be—bringing clinical-grade insights to your wrist with continuous vitals, edge and cloud-powered AI coaching.	Will Ahmed, Founder and CEO poses with Emily Capodilupo, SVP of Research Algorithms and Data on the ... More morning of their new product launch at WHOOP HQ in Boston, MA\r\nJohn Werner\r\nNew science on… [+11336 chars]	https://www.forbes.com/sites/johnwerner/2025/05/08/the-all-new-whoop-the-worlds-most-powerful-health-wearable/	https://imageio.forbes.com/specials-images/imageserve/681d2bc93949879059c77a4c/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 23:00:06
191	0.1	12	NewsAPI	Health Care's AI Governance Requires Transparency and Testing, Experts Say	Dr. Brian Anderson of the Coalition for Health AI said there is "a real urgency" to ensure AI models are managed "robustly and appropriately."	As health care systems scale the adoption of new technologies, there is a growing need for strong leadership and policies to ensure the new technology aligns with patient safety goals.\r\nOn Tuesday, M… [+6063 chars]	https://www.newsweek.com/health-care-ai-governance-transparency-webinar-access-health-2074967	https://d.newsweek.com/en/full/2645924/ai-governance-risk-management-health.png	2025-05-20 21:57:53
192	0.1	12	NewsAPI	Treatment.com AI and Rocket Doctor Applaud US Health Secretary RFK Jr.’s Call for Greater Investment in Telehealth and AI-Driven Diagnostic Tools	‏VANCOUVER, BC, May 15, 2025 (GLOBE NEWSWIRE) -- Treatment.com AI Inc. (CSE: TRUE, OTC: TREIF, Frankfurt: 939) (“Treatment”) and Rocket Doctor, its wholly owned online care platform, applaud United States Secretary of Health and Human Services, Robert F. Kenn…	<ul><li>RFK Jr. calls for a revolution in telehealth and AI to reduce ER visits and improve at-home care.</li><li>Treatment.com AI and Rocket Doctor applaud the remarks, citing strong alignment with … [+7367 chars]	https://www.globenewswire.com/news-release/2025/05/15/3082244/0/en/Treatment-com-AI-and-Rocket-Doctor-Applaud-US-Health-Secretary-RFK-Jr-s-Call-for-Greater-Investment-in-Telehealth-and-AI-Driven-Diagnostic-Tools.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-15 13:02:00
193	0.1	12	NewsAPI	Top Challenges Impacting Patient Access to Healthcare	Healthcare organizations must look into convenient care options and other patient services to drive more patient access to healthcare.	Patient access to care sets the baseline for all patient encounters with the healthcare industry. When a patient cannot access her clinician, it is impossible to receive medical care, build relations… [+15500 chars]	https://www.techtarget.com/patientengagement/news/366584287/Top-Challenges-Impacting-Patient-Access-to-Healthcare	https://www.techtarget.com/rms/onlineimages/code_g1078919244.jpg	2025-05-20 14:30:00
194	0.1	12	NewsAPI	Patient-facing online triage tools and clinician decision-making: a systematic review	Objective To evaluate the role of using outputs from patient-facing online triage tools in clinical decision-making in primary care.\n\nDesign Systematic review.\n\nData sources Medline, Embase, Cumulative Index to Nursing and Allied Health Literature, Web of Sci…	Background\r\nPatient-facing online triage tools in primary care facilitate contact between the patient and their primary care service provider. The tools gather information about patients clinical nee… [+8301 chars]	https://bmjopen.bmj.com/content/15/5/e094068	https://bmjopen.bmj.com/pages/wp-content/uploads/sites/7/2019/07/bmjopen-default-cover.png	2025-05-09 04:11:55
195	0	12	NewsAPI	Top Three Ways Clinicians Are Using AI To Maximize ROI	If you were to ask a doctor, nurse practitioner, or therapist why they first entered medicine, the most common answer would be to heal and care for others.	Red arrow over stack of money coins arranged as a graph on wood table with blurry the doctor ... More stethoscope around neck a scene in the back, concept of financial health and medical expenses\r\nge… [+5764 chars]	https://www.forbes.com/sites/jaimecatmull/2025/05/05/top-three-ways-clinicians-are-using-ai-to-maximize-roi/	https://imageio.forbes.com/specials-images/imageserve/6818e08aeefb0aaab6f1e001/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-05 16:20:49
196	0	12	NewsAPI	Americans’ Trust In The Healthcare System Is Plummeting. How Can It Be Repaired?	Trust in the U.S. healthcare system is eroding, but experts say rebuilding it is possible. They say this will require both payers and providers to prioritize empathy, transparency, and personalized communication.\nThe post Americans’ Trust In The Healthcare Sy…	Americans’ trust in the overall healthcare system is dwindling — but experts believe it can be rebuilt.\r\nPublic trust in the U.S. healthcare system fell from 71.5% in 2020 to 40.1% in 2024, according… [+9665 chars]	https://medcitynews.com/2025/05/healthcare-trust/	https://medcitynews.com/wp-content/uploads/sites/7/2024/12/GettyImages-2096576682.jpg	2025-05-09 21:47:00
197	0	12	NewsAPI	Smartinhaler ensures effective asthma treatment when it’s needed	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017; now its makers want it to be available to Aussie asthmatics…	The Hailie Smartinhaler, from med-tech company Adherium, improves asthma control by ensuring inhalers are used effectively and at the right time. It has been assisting American asthmatics since 2017;… [+4094 chars]	https://newatlas.com/medical-devices/adherium-hailie-smartinhaler-asthma-control/	https://assets.newatlas.com/dims4/default/bdaa95b/2147483647/strip/true/crop/2000x1050+0+38/resize/1200x630!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2Fee%2F9a%2Faa2690dc4db0a8472e60ef499a0f%2Fbanner-our-technology-2023.jpg&na.image_optimisation=0	2025-05-15 04:22:40
198	0	12	NewsAPI	The Silent Mental Health Crisis: How Technology Can Bridge The Gap	Technology can revolutionize how we approach mental health care for children and young people.	Founder-CEO, Koa Health. Neuroscientist, psychiatrist, and former McKinsey. 20 years' experience delivering scalable health tech solutions.\r\ngetty\r\nMental disorders are the chronic diseases of the yo… [+6632 chars]	https://www.forbes.com/councils/forbestechcouncil/2025/05/08/the-silent-mental-health-crisis-how-technology-can-bridge-the-gap/	https://imageio.forbes.com/specials-images/imageserve/681b78ffc64205a45c8b02b6/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-08 11:30:00
199	0	12	NewsAPI	What Happens To Medicine When Machines Are As Good As Doctors?	Imagine if every physician had a virtual clinical partner as knowledgeable and reliable as they are. With AGI, that day may be closer than most people expect.	IBM defines AGI as the moment an artificial intelligence system can match or exceed the cognitive ... More abilities of human beings across any task.\r\ngetty\r\nImagine if every physician and nurse had … [+8339 chars]	https://www.forbes.com/sites/robertpearl/2025/05/12/what-happens-to-medicine-when-machines-are-as-good-as-doctors/	https://imageio.forbes.com/specials-images/imageserve/6820c1cae5f5fef52c054977/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-12 07:15:00
200	0	12	NewsAPI	Behavioural analysis of factors influencing prescribing for neurodegenerative diseases: A rapid review	Background The incidence and prevalence of neurodegenerative diseases (NDs) are growing worldwide. In an environment where healthcare resources are already stretched, it is important to optimise treatment choice to help alleviate healthcare burden. This rapid…	Abstract\r\nBackground\r\nThe incidence and prevalence of neurodegenerative diseases (NDs) are growing worldwide. In an environment where healthcare resources are already stretched, it is important to op… [+59769 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322324	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322324.g002&size=inline	2025-05-06 14:00:00
201	0	12	NewsAPI	Newsweek's Next Virtual Event Aims to Build Health Care's AI Playbook	Health Care's AI Playbook: Building Safe, Smart and Scalable Systems virtual event begins Tuesday, May 20 at 2:15 pm EST.	Artificial intelligence (AI) has been integrated into almost every industry. In health care, AI has been used for detection and analysis and to help with physician burnout, but it is also susceptible… [+5802 chars]	https://www.newsweek.com/newsweek-virtual-event-build-health-care-ai-playbook-access-health-2073297	https://d.newsweek.com/en/full/2644660/updated-ai-webinar-promo-landscape.png	2025-05-16 17:45:59
202	0	12	NewsAPI	Rocket Doctor Partners with Melanoma Canada to Expand Access to Follow-Up Care for At-Risk Patients	‎‎ New collaboration will connect patients flagged during mobile skin cancer screenings with Rocket Doctor physicians across Ontario, Alberta, and British Columbia	New collaboration will connect patients flagged during mobile skin cancer screenings with Rocket Doctor physicians across Ontario, Alberta, and British Columbia\r\nRocket Doctor has partnered with Mela… [+7458 chars]	https://www.globenewswire.com/news-release/2025/05/20/3084555/0/en/Rocket-Doctor-Partners-with-Melanoma-Canada-to-Expand-Access-to-Follow-Up-Care-for-At-Risk-Patients.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-20 07:00:00
203	0	12	NewsAPI	Rocket Doctor Named Clinical Innovator of the Year at NEXUS 2025	Recognition highlights Rocket Doctor’s leadership in advancing physician-led virtual care models across North America Recognition highlights Rocket Doctor’s leadership in advancing physician-led virtual care models across North America	<ul><li>Rocket Doctor named Clinical Innovator of the Year at the Innovators Challenge during NEXUS 2025 in New Orleans.</li><li>Award recognizes Rocket Doctors physician-led virtual care model, desi… [+6775 chars]	https://www.globenewswire.com/news-release/2025/05/06/3075195/0/en/Rocket-Doctor-Named-Clinical-Innovator-of-the-Year-at-NEXUS-2025.html	https://ml.globenewswire.com/Resource/Download/4a636d73-4f14-46ab-8bbf-3c561a076db6	2025-05-06 13:41:00
204	0.145	13	NewsDATA	WNBA star A'ja Wilson overcomes dyslexia to start foundation and candle business	A’ja Wilson has accomplished everything in her professional career.The Las Vegas Aces star has earned every accolade imaginable: two WNBA championships, three WNBA MVP awards, two WNBA Defensive Player of the Year awards and two Olympic gold medals, to name a few.But the 28-year-old South Carolina alum opened up about the struggle she deals with: dyslexia. Wilson’s learning disability, she said, has shaped the way she’s approached her life as a famous figure.“I feel like when people see me, they see the accolades, they see the resume, and they’re like, ‘Oh my gosh, this girl, she’s perfect,'” Wilson told NBC in the latest episode of “My New Favorite Baller.” “But knowing that I have a learning disability, knowing that I struggle with this, with anxiety and depression, it shows people that I’m normal. It shows people that I struggle with similar things.“So, they go through and we can relate on a more humane level. And you don’t get that a lot from your role models or from us as professional athletes. So, I think it just takes me as just a human in understanding and feeling those feelings and knowing that I know you guys see A’ja and love it and it’s such a vibe.”BasketballMay 19My New Favorite Baller: How NBA and WNBA basketball stars give backWNBAFeb 4A'ja Wilson's Nike collection release shows growth, interest in women's sportsWilson has always been interested in relating to people, no matter how much her stardom blossoms.Since being drafted first overall by the Aces in 2018, Wilson has completely transformed the franchise. The team relocated from San Antonio to Sin City in the same offseason where it acquired Wilson — following three straight seasons of single-digit wins and missing the playoffs.For an organization that hadn’t won a championship in its 21-year history before Wilson arrived, her arrival was a turning point. After missing the playoffs by one game in her rookie year, the Aces haven’t missed out since.Despite winning back-to-back titles in 2022 and 2023 and going 102-28 from 2020 to 2023, Wilson still felt no pressure during the Aces’ quest to three-peat last season. Las Vegas ultimately came up short, losing in the semifinals.“I feel like the joy is going to always outweigh the pressure, because that is truly the moment where you have the most fun,” Wilson said. “Pressure makes diamonds and diamonds look great, but sometimes you have to find joy in the process of it. And I think that’s what kind of user it’s being like, wanting to be around each other, wanting to come in to work every day and to get better.”That sort of mindset has seeped into Wilson’s every day life — on and off the court. Her only goal is to win for her team and form a true bond with the women around her.“My first success, obviously, would be winning a championship,” Wilson said. “And I feel like that is always the go-to answer. But, I feel like I’m in a space where I’m like, I want everybody to eat. I want my teammates, I don’t want it just to be me.“I mean, it’s like they talk about — it’s lonely at the top. I don’t want it to be that. I want everybody to eat because it’s we deserve it. We’ve worked so hard to get to this situation and as fast as we can, and a lot of people have counted us out against us, especially now when we when we weren’t the perfect Aces.“And so now that’s like success to me. It’s proving them wrong and kind of getting the egg off their face a little bit. And so I think that’s what I’m doing. Success like that and then obviously that when we come with hoisting a trophy at the end, but even then it’s like seeing a shake back, digging out of holes, understanding, being resilient on both sides of the basketball.”Another critical step in Wilson’s life came in 2023, when she shared in an Instagram post that she helped her mother retire from a lengthy career in education.“It meant the world to me,” Wilson said. “... But she’s such a hard worker and my mom is someone that has to stay busy. Like she’s the Black mom that puts on the music and they have the whole house up. That’s the wake up because she’s up and now is cleaning. Like, that’s my mom. And she did that 365 days, 24 hours, seven days a week. That’s who she was.“So, I knew was going to be very hard for me to pull her away from that, because she’s such a hard worker. And so to be able to be like, ‘Mom, you can be a hard worker now for my foundation and for my candle company. It just meant the world to me because that’s truly, obviously what she really wanted to do, and that’s what she loves the most, is just being alongside me.”Wilson’s mother Eva now serves as the executive director of the A’ja Wilson Foundation and chief operating officer of her daughter’s candle business, Burnt Wax Candle Company. Not exactly a quiet retired life, but that’s exactly the way she likes it.“It’s one of the No. 1 things I wanted to do once I became a professional athlete,” the younger Wilson said when asked about starting a foundation. “... I knew instantly, seeing the resources that I got in college, I wanted to make sure that a lot of young kids could have those resources, not just the top athletes at power five schools — everyone deserves this. And starting from the teachers all the way down to the students.“And so when it came to my foundation, I poured a lot into it. And I wanted to make it like a foundation where we do bus trips. And when you learn trivia, you get a meal for going to it, you get to go to a WNBA game. But yeah, you also see that your donations are going toward certifying teachers to be able to notice when a child is struggling and identifying with them and being like, ‘Let’s get you tested and see what your learning disability may be.'”It all connects back to Wilson’s own struggles with dyslexia, and how she has overcome that challenge as one of the most successful female athletes of all-time.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcphiladelphia.com/news/sports/wnba/aja-wilson-wnba-aces-dyslexia-foundation-candle-business/4193682/	https://media.nbcphiladelphia.com/2025/05/250525-aja-wilson-getty.jpg?fit=6719%2C3780&quality=85&strip=all	2025-05-27 16:41:12
205	0.145	13	NewsDATA	WNBA star A'ja Wilson overcomes dyslexia to start foundation and candle business	A’ja Wilson has accomplished everything in her professional career.The Las Vegas Aces star has earned every accolade imaginable: two WNBA championships, three WNBA MVP awards, two WNBA Defensive Player of the Year awards and two Olympic gold medals, to name a few.But the 28-year-old South Carolina alum opened up about the struggle she deals with: dyslexia. Wilson’s learning disability, she said, has shaped the way she’s approached her life as a famous figure.“I feel like when people see me, they see the accolades, they see the resume, and they’re like, ‘Oh my gosh, this girl, she’s perfect,'” Wilson told NBC in the latest episode of “My New Favorite Baller.” “But knowing that I have a learning disability, knowing that I struggle with this, with anxiety and depression, it shows people that I’m normal. It shows people that I struggle with similar things.“So, they go through and we can relate on a more humane level. And you don’t get that a lot from your role models or from us as professional athletes. So, I think it just takes me as just a human in understanding and feeling those feelings and knowing that I know you guys see A’ja and love it and it’s such a vibe.”BasketballMay 19My New Favorite Baller: How NBA and WNBA basketball stars give backWNBAFeb 4A'ja Wilson's Nike collection release shows growth, interest in women's sportsWilson has always been interested in relating to people, no matter how much her stardom blossoms.Since being drafted first overall by the Aces in 2018, Wilson has completely transformed the franchise. The team relocated from San Antonio to Sin City in the same offseason where it acquired Wilson — following three straight seasons of single-digit wins and missing the playoffs.For an organization that hadn’t won a championship in its 21-year history before Wilson arrived, her arrival was a turning point. After missing the playoffs by one game in her rookie year, the Aces haven’t missed out since.Despite winning back-to-back titles in 2022 and 2023 and going 102-28 from 2020 to 2023, Wilson still felt no pressure during the Aces’ quest to three-peat last season. Las Vegas ultimately came up short, losing in the semifinals.“I feel like the joy is going to always outweigh the pressure, because that is truly the moment where you have the most fun,” Wilson said. “Pressure makes diamonds and diamonds look great, but sometimes you have to find joy in the process of it. And I think that’s what kind of user it’s being like, wanting to be around each other, wanting to come in to work every day and to get better.”That sort of mindset has seeped into Wilson’s every day life — on and off the court. Her only goal is to win for her team and form a true bond with the women around her.“My first success, obviously, would be winning a championship,” Wilson said. “And I feel like that is always the go-to answer. But, I feel like I’m in a space where I’m like, I want everybody to eat. I want my teammates, I don’t want it just to be me.“I mean, it’s like they talk about — it’s lonely at the top. I don’t want it to be that. I want everybody to eat because it’s we deserve it. We’ve worked so hard to get to this situation and as fast as we can, and a lot of people have counted us out against us, especially now when we when we weren’t the perfect Aces.“And so now that’s like success to me. It’s proving them wrong and kind of getting the egg off their face a little bit. And so I think that’s what I’m doing. Success like that and then obviously that when we come with hoisting a trophy at the end, but even then it’s like seeing a shake back, digging out of holes, understanding, being resilient on both sides of the basketball.”Another critical step in Wilson’s life came in 2023, when she shared in an Instagram post that she helped her mother retire from a lengthy career in education.“It meant the world to me,” Wilson said. “... But she’s such a hard worker and my mom is someone that has to stay busy. Like she’s the Black mom that puts on the music and they have the whole house up. That’s the wake up because she’s up and now is cleaning. Like, that’s my mom. And she did that 365 days, 24 hours, seven days a week. That’s who she was.“So, I knew was going to be very hard for me to pull her away from that, because she’s such a hard worker. And so to be able to be like, ‘Mom, you can be a hard worker now for my foundation and for my candle company. It just meant the world to me because that’s truly, obviously what she really wanted to do, and that’s what she loves the most, is just being alongside me.”Wilson’s mother Eva now serves as the executive director of the A’ja Wilson Foundation and chief operating officer of her daughter’s candle business, Burnt Wax Candle Company. Not exactly a quiet retired life, but that’s exactly the way she likes it.“It’s one of the No. 1 things I wanted to do once I became a professional athlete,” the younger Wilson said when asked about starting a foundation. “... I knew instantly, seeing the resources that I got in college, I wanted to make sure that a lot of young kids could have those resources, not just the top athletes at power five schools — everyone deserves this. And starting from the teachers all the way down to the students.“And so when it came to my foundation, I poured a lot into it. And I wanted to make it like a foundation where we do bus trips. And when you learn trivia, you get a meal for going to it, you get to go to a WNBA game. But yeah, you also see that your donations are going toward certifying teachers to be able to notice when a child is struggling and identifying with them and being like, ‘Let’s get you tested and see what your learning disability may be.'”It all connects back to Wilson’s own struggles with dyslexia, and how she has overcome that challenge as one of the most successful female athletes of all-time.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcnewyork.com/news/sports/wnba/aja-wilson-wnba-aces-dyslexia-foundation-candle-business/6277599/	https://media.nbcnewyork.com/2025/05/250525-aja-wilson-getty.jpg?fit=6719%2C3780&quality=85&strip=all	2025-05-27 16:41:12
206	0.145	13	NewsDATA	Dawn Staley recalls how she became a basketball coach and shares the key to her success	A’ja Wilson has accomplished everything in her professional career.The Las Vegas Aces star has earned every accolade imaginable: two WNBA championships, three WNBA MVP awards, two WNBA Defensive Player of the Year awards and two Olympic gold medals, to name a few.But the 28-year-old South Carolina alum opened up about the struggle she deals with: dyslexia. Wilson’s learning disability, she said, has shaped the way she’s approached her life as a famous figure.“I feel like when people see me, they see the accolades, they see the resume, and they’re like, ‘Oh my gosh, this girl, she’s perfect,'” Wilson told NBC in the latest episode of “My New Favorite Baller.” “But knowing that I have a learning disability, knowing that I struggle with this, with anxiety and depression, it shows people that I’m normal. It shows people that I struggle with similar things.“So, they go through and we can relate on a more humane level. And you don’t get that a lot from your role models or from us as professional athletes. So, I think it just takes me as just a human in understanding and feeling those feelings and knowing that I know you guys see A’ja and love it and it’s such a vibe.”BasketballMay 19My New Favorite Baller: How NBA and WNBA basketball stars give backWNBAFeb 4A'ja Wilson's Nike collection release shows growth, interest in women's sportsWilson has always been interested in relating to people, no matter how much her stardom blossoms.Since being drafted first overall by the Aces in 2018, Wilson has completely transformed the franchise. The team relocated from San Antonio to Sin City in the same offseason where it acquired Wilson — following three straight seasons of single-digit wins and missing the playoffs.For an organization that hadn’t won a championship in its 21-year history before Wilson arrived, her arrival was a turning point. After missing the playoffs by one game in her rookie year, the Aces haven’t missed out since.Despite winning back-to-back titles in 2022 and 2023 and going 102-28 from 2020 to 2023, Wilson still felt no pressure during the Aces’ quest to three-peat last season. Las Vegas ultimately came up short, losing in the semifinals.“I feel like the joy is going to always outweigh the pressure, because that is truly the moment where you have the most fun,” Wilson said. “Pressure makes diamonds and diamonds look great, but sometimes you have to find joy in the process of it. And I think that’s what kind of user it’s being like, wanting to be around each other, wanting to come in to work every day and to get better.”That sort of mindset has seeped into Wilson’s every day life — on and off the court. Her only goal is to win for her team and form a true bond with the women around her.“My first success, obviously, would be winning a championship,” Wilson said. “And I feel like that is always the go-to answer. But, I feel like I’m in a space where I’m like, I want everybody to eat. I want my teammates, I don’t want it just to be me.“I mean, it’s like they talk about — it’s lonely at the top. I don’t want it to be that. I want everybody to eat because it’s we deserve it. We’ve worked so hard to get to this situation and as fast as we can, and a lot of people have counted us out against us, especially now when we when we weren’t the perfect Aces.“And so now that’s like success to me. It’s proving them wrong and kind of getting the egg off their face a little bit. And so I think that’s what I’m doing. Success like that and then obviously that when we come with hoisting a trophy at the end, but even then it’s like seeing a shake back, digging out of holes, understanding, being resilient on both sides of the basketball.”Another critical step in Wilson’s life came in 2023, when she shared in an Instagram post that she helped her mother retire from a lengthy career in education.“It meant the world to me,” Wilson said. “... But she’s such a hard worker and my mom is someone that has to stay busy. Like she’s the Black mom that puts on the music and they have the whole house up. That’s the wake up because she’s up and now is cleaning. Like, that’s my mom. And she did that 365 days, 24 hours, seven days a week. That’s who she was.“So, I knew was going to be very hard for me to pull her away from that, because she’s such a hard worker. And so to be able to be like, ‘Mom, you can be a hard worker now for my foundation and for my candle company. It just meant the world to me because that’s truly, obviously what she really wanted to do, and that’s what she loves the most, is just being alongside me.”Wilson’s mother Eva now serves as the executive director of the A’ja Wilson Foundation and chief operating officer of her daughter’s candle business, Burnt Wax Candle Company. Not exactly a quiet retired life, but that’s exactly the way she likes it.“It’s one of the No. 1 things I wanted to do once I became a professional athlete,” the younger Wilson said when asked about starting a foundation. “... I knew instantly, seeing the resources that I got in college, I wanted to make sure that a lot of young kids could have those resources, not just the top athletes at power five schools — everyone deserves this. And starting from the teachers all the way down to the students.“And so when it came to my foundation, I poured a lot into it. And I wanted to make it like a foundation where we do bus trips. And when you learn trivia, you get a meal for going to it, you get to go to a WNBA game. But yeah, you also see that your donations are going toward certifying teachers to be able to notice when a child is struggling and identifying with them and being like, ‘Let’s get you tested and see what your learning disability may be.'”It all connects back to Wilson’s own struggles with dyslexia, and how she has overcome that challenge as one of the most successful female athletes of all-time.	ONLY AVAILABLE IN PAID PLANS	https://www.nbcphiladelphia.com/news/sports/dawn-staley-basketball-coach-story-key-success/4195007/	https://media.nbcphiladelphia.com/2025/05/GettyImages-2208320690-e1748377518422.jpg?fit=3069%2C1729&quality=85&strip=all	2025-05-27 16:39:28
207	0.073	13	NewsAPI	How to Be a More Effective Teacher	From the Cool Cat Teacher Blog by Vicki Davis Subscribe to the 10 Minute Teacher Podcast anywhere you listen to podcasts.\nWhat really works in teaching? Nathaniel Hansford shares scientific, evidence-based strategies to help you become a more effective teache…	When youre standing in front of a classroom, what actually works? In this episode, Nathaniel Hansford shares the scientific principles every teacher should know. He draws from meta-analysis and globa… [+2851 chars]	https://www.coolcatteacher.com/e899/	https://www.coolcatteacher.com/wp-content/uploads/2025/05/graphic-image-899-1.png	2025-05-08 01:17:03
208	0	13	NewsAPI	'Teachers are having scissors thrown at them - we've had enough'	Staff say they are often unable to teach as large groups of students roam the school.	Charlie Jones\r\nScience teacher Sophie Walker says she and her colleagues have reached breaking point\r\nWhen Sophie Walker graduated and became a teacher 10 years ago, she felt excited for the future.\r… [+7826 chars]	https://www.bbc.com/news/articles/cvgq98edegxo	https://ichef.bbci.co.uk/news/1024/branded_news/de10/live/1718cc20-3193-11f0-8947-7d6241f9fce9.jpg	2025-05-17 00:12:51
209	0	13	NewsAPI	Former teacher of the year gets 30 years in California prison for sexually assaulting students	A onetime county teacher of the year at a Southern California elementary school has been sentenced to 30 years to life in prison for grooming and sexually...	SAN DIEGO (AP) A onetime county teacher of the year at a Southern California elementary school has been sentenced to 30 years to life in prison for grooming and sexually assaulting two young boys on … [+1327 chars]	https://www.yahoo.com/news/former-teacher-gets-30-years-165204484.html	https://s.yimg.com/cv/apiv2/social/images/yahoo_default_logo-1200x1200.png	2025-05-13 16:52:04
210	0	13	NewsAPI	Oklahoma education standards say students must identify 2020 election 'discrepancies'	New academic standards in Oklahoma call for the teaching of "discrepancies" in the 2020 election, continuing the spread of a false narrative years after it was first pushed by Trump and his allies.	TULSA, Okla. New academic standards in Oklahoma call for the teaching of "discrepancies" in the 2020 election results, continuing the spread of a false narrative years after it was first pushed by Pr… [+6097 chars]	https://www.npr.org/2025/05/14/nx-s1-5384282/oklahoma-education-standards-2020-election	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/4639x2609+0+88/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fc3%2F8e%2Ff868d977431fac66f7adec1c1297%2Fap25027772468178.jpg	2025-05-14 09:00:00
211	0	13	NewsAPI	Congress celebrates impactful teachers: 'We certainly do appreciate them'	Lawmakers are celebrating Teacher Appreciation Week 2025 by paying tribute to the educators who helped them ascend to Congress.	Lawmakers are celebrating Teacher Appreciation Week 2025 by paying tribute to the educators who helped them ascend to Congress.\r\nHouse Speaker Mike Johnson, R-La., said his wife and mother-in-law, wh… [+4677 chars]	https://abcnews.go.com/Politics/congress-celebrates-impactful-teachers/story?id=121612463	https://i.abcnewsfe.com/a/fbc5b046-6d9e-47f6-afbe-3c61711b2a8f/mike-johnson-gty-jt-250508_1746736389060_hpMain_16x9.jpg?w=1600	2025-05-09 17:40:41
212	0	13	NewsAPI	I Thought ChatGPT Was Killing My Students’ Skills. It’s Killing Something More Important Than That.	Trust between teacher and student was tricky way before A.I. hit us.	This essay was adapted from Phil Christmans newsletter, the Tourist. Subscribe here.\r\nBefore 2023, my teaching year used to follow a predictable emotional arc. In September, I was always excited, not… [+8447 chars]	https://slate.com/life/2025/05/college-student-cheating-ai-detector-chatgpt-school-education.html	https://compote.slate.com/images/3d0398d8-cc18-4673-824f-9579b3f09728.jpeg?crop=1560%2C1040%2Cx0%2Cy0&width=1560	2025-05-14 19:38:52
213	0	13	NewsAPI	Special education teachers gets thrown under the bus by her supervisor, so she gathers the receipts and gets him fired: ‘He sent me a formal letter of apology…'	Being a teacher is not easy. You have to take car of children, many children, every single day! Ask any parent, that is a difficult job. There is a reason you have to get a teacher's degree in order to do it. Some kids can be really mean, especially teenagers…	Being a teacher is not easy. You have to take car of children, many children, every single day! Ask any parent, that is a difficult job. There is a reason you have to get a teacher's degree in order … [+651 chars]	https://cheezburger.com/40441861/special-education-teachers-gets-thrown-under-the-bus-by-her-supervisor-so-she-gathers-the-receipts	https://i.chzbgr.com/thumb1200/40441861/hD92474F5/her-supervisor-so-she-gathers-the-receipts-and-gets-him-fired-he-sent-me-a-formal-letter-of-apology	2025-05-08 17:00:00
214	0	13	NewsAPI	What to know about a federal proposal to help families pay for private school	Republicans want to use the federal tax code to create a national school voucher even in states where voters have fought such efforts.	A first-of-its-kind effort to leverage federal tax dollars to help families pay for private school tuition anywhere in the U.S. is one step closer to becoming a reality.\r\nRepublicans on the House Way… [+6314 chars]	https://www.npr.org/2025/05/14/nx-s1-5397945/private-school-vouchers-choice-reconciliation	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+198/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F66%2Fb0%2F0411f356468caf668e0eee30cd28%2Fgettyimages-2199281234.jpg	2025-05-14 20:46:27
215	0	13	NewsAPI	Fox News AI Newsletter: Teacher's tech tell-all goes viral	Stay up to date on the latest AI technology advancements and learn about the challenges and opportunities AI presents now and for the future.	Welcome to Fox News Artificial Intelligence newsletter with the latest AI technology advancements.\r\nIN TODAY'S NEWSLETTER:- Teacher quits profession after viral rant on how AI is 'ruining' education-… [+3126 chars]	https://www.foxnews.com/tech/ai-newsletter-teachers-tech-tell-all-goes-viral	https://static.foxnews.com/foxnews.com/content/uploads/2025/05/teacher.png	2025-05-17 12:30:24
216	0	13	NewsAPI	Blue Origin's next crew includes entrepreneurs and founders. Here's who's following Katy Perry and Lauren Sánchez into space.	Blue Origin's next crew includes business figures and entrepreneurs after the high-profile mission featuring Katy Perry and Lauren Sánchez.	Blue Origin has unveiled the crew for its next mission.Blue Origin\r\n<ul><li>Blue Origin announced new crewmembers for its next space mission, NS-32.</li><li>It will be the first mission since its Apr… [+3242 chars]	https://www.businessinsider.com/blue-origin-crew-entrepreneurs-business-space-ceos-jeff-bezos-2025-5	https://i.insider.com/682f0c5d6ffb6822ec613285?width=1106&format=jpeg	2025-05-23 07:08:42
217	0	13	NewsAPI	Parents refuse to let 17-year-old go on school Marine Biology trip after telling her to refuse $45 "handout" for the fee from her teacher: 'They have been calling me ungrateful and spoiled'	Sometimes you literally can't afford to turn down a favor. It might be hard to swallow your pride, but you have to accept that those wanting to help don't look down on you; they just want to help, and that's where it begins and ends. When your education, futu…	Sometimes you literally can't afford to turn down a favor. It might be hard to swallow your pride, but you have to accept that those wanting to help don't look down on you; they just want to help, an… [+1155 chars]	https://cheezburger.com/40348933/parents-refuse-to-let-17-year-old-go-on-school-marine-biology-trip-after-telling-her-to-refuse-45	https://i.chzbgr.com/original/40348933/hE2F0DE04/family-pregnant-reddit-thread-parent-raising-kids-parenting-fail-parents-children-family-40348933	2025-04-29 16:00:00
218	0	13	NewsAPI	Palm Beach County schools bypassed screening in hiring educator facing molestation charges	Norman Riemer, a former Palm Beach County School District educator facing molestation charges, needed a waiver to be hired in 1999.	Palm Beach County School District records show that the district bypassed its normal process in the 1999 hiring of Norman Riemer, the former science teacher who was arrested last month and faces five… [+8390 chars]	https://www.palmbeachpost.com/story/news/education/2025/05/16/florida-teacher-facing-molestation-charges-failed-screening-in-1999/83608953007/	https://s.yimg.com/ny/api/res/1.2/vqDnFyfuhl_48IAFOKAomw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/palm-beach-daily-news/5342ccc2ada7b20ab5de415d54e13d5c	2025-05-16 09:01:48
259	0	15	NewsAPI	School Choice	Now that Texas and South Carolina have passed school choice bills, parents will be able to choose the best school for their kids in 17... Read More\nThe post School Choice appeared first on The Daily Signal.	Now that Texas and South Carolina have passed school choice bills, parents will be able to choose the best school for their kids in 17 states.\r\nWhy not all states?\r\nAfter all, competition improves se… [+4300 chars]	https://www.dailysignal.com/2025/05/25/school-choice/	https://www.dailysignal.com/wp-content/uploads/2025/05/GettyImages-2189228375.jpgRS_-scaled.jpg	2025-05-25 22:00:00
219	0	13	NewsAPI	Trump threatened school funding in Maine. Here's how that money is used	Schools in Maine are in the middle of a political and legal battle between the Trump administration and Gov. Janet Mills. Key programs for the most vulnerable students are at stake.	Jonathan Moody runs a rural school district in and around Skowhegan, Maine, about 90 miles north of Portland. His office is in an old, converted farmhouse; the conference room was once a chicken coop… [+8659 chars]	https://www.npr.org/2025/05/19/nx-s1-5398545/trump-schools-maine-education-funding	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+314/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F3a%2Ffa%2F36d01b304d37820e4837ecc51b63%2Fgrybus-npr-titleone-hr-02-9328.jpg	2025-05-19 10:00:00
220	0	13	NewsAPI	On Teacher Appreciation Week, union leaders say teachers are underpaid and under attack	The presidents of the National Education Association and American Federation of Teachers say the political climate has added to age-old money problems for teachers, such as underfunded schools.	It's Teacher Appreciation Week a time when educators often receive apples, mugs and gift cards from students and their families.\r\nBut union leaders say that, for many teachers, the outpouring of grat… [+4678 chars]	https://www.npr.org/2025/05/08/nx-s1-5388994/teacher-appreciation-week-salary-finances	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/7728x4347+0+403/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F81%2Fc0%2Faf1cf05d45709ba82fb30da0decd%2Fnpr-k-147-copy.jpg	2025-05-08 09:00:00
221	0	13	NewsAPI	Attention SAVE Borrowers: Don't Expect Student Loan Payments to Resume This Year. Do This While You Wait	The Department of Education's website says the SAVE payment pause will last until at least this fall. Experts think it will last longer.	If you're one of the eight million borrowers who signed up for the Saving on a Valuable Education student loan repayment plan, you're probably wondering what's next for your student loans. \r\nThere ha… [+4150 chars]	https://www.cnet.com/personal-finance/loans/attention-save-borrowers-dont-expect-student-loan-payments-to-resume-this-year-do-this-while-you-wait/	https://www.cnet.com/a/img/resize/2d9d6676d59f22058d0321f1209141a81cedda86/hub/2025/05/22/69437114-7521-479b-806b-66450970bca0/may-13-copy-of-money-headshots-240430-2025-05-22t134320-026.png?auto=webp&fit=crop&height=675&width=1200	2025-05-23 11:00:07
222	0	13	NewsAPI	Did Brigitte Macron Push the French President in the Face? What to Know About Their Moment on the Plane	Emmanuel Macron dismisses speculation over Brigitte's gesture as playful interaction.	The office of French President Emmanuel Macron has dismissed suggestions of discord after footage emerged appearing to show his wife, Brigitte Macron, pushing him in the face before the couple disemb… [+3607 chars]	https://time.com/7288678/macron-wife-brigitte-plane-shove/	https://api.time.com/wp-content/uploads/2025/05/marcon-1.jpg?quality=85&w=1200&h=628&crop=1	2025-05-26 16:59:07
223	0	13	NewsAPI	I dropped out of college, but reenrolled as a 44-year-old multimillionaire with 5 kids. I needed to finish what I started.	I became a multimillionaire even though I dropped out of college. In my 40s, I felt like something was missing, so I reenrolled to get my degree.	The author went back to college when she was a multimillionaire.Thai Liang Lim/Getty Images\r\n<ul><li>Amber Duncan founded a company that's now worth $50 million.</li><li>She never finished her bachel… [+3614 chars]	https://www.businessinsider.com/reenrolled-college-as-multimillionaire-with-kids-2025-5	https://i.insider.com/682cce60c6ad288d14817123?width=1200&format=jpeg	2025-05-21 15:36:57
224	0.16	14	NewsDATA	Chhattisgarh rationalises 10,463 schools, outperforms national average in PTR across all school levels	Chhattisgarh government has rationalized 10,463 schools to improve education quality, reduce dropouts, and ensure equitable teacher distribution, aligning with RTE Act 2009 and NEP 2020. The initiative addresses teacher shortages and imbalances, consolidating schools and resources for better infrastructure and student retention. Despite protests, the government emphasizes the move's benefits for students and efficient resource use.	ONLY AVAILABLE IN PAID PLANS	https://timesofindia.indiatimes.com/city/raipur/chhattisgarh-rationalises-10463-schools-outperforms-national-average-in-ptr-across-all-school-levels/articleshow/121439686.cms	https://static.toiimg.com/thumb/msid-121439686,width-1070,height-580,imgsize-null,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg	2025-05-27 12:57:34
225	0.08	14	NewsAPI	5 Digital Products Teachers Can Create And Sell	Teachers are turning to digital products as the perfect side hustle. Discover why creating lesson plans, workbooks, and templates outperforms traditional second jobs.	A young woman teacher creating her digital products. \r\ngetty\r\nIn classrooms across America, teachers are increasingly looking beyond their primary roles for financial stability. Federal data shows th… [+7964 chars]	https://www.forbes.com/sites/sarahhernholm/2025/05/17/5-digital-products-teachers-can-create-and-sell/	https://imageio.forbes.com/specials-images/imageserve/6828d7f6cc7225b4ff1f3e79/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-17 18:49:58
226	0.08	14	NewsAPI	Phone and shouting ban 'transforms' school plagued by fights	A head teacher says pupil exclusions for violence reduced "almost overnight" when phones were banned.	Bethan LewisEducation &amp; Family Correspondent, BBC Wales News\r\nHead teacher Mike Tate says exclusions for violence at his school have fallen by 72% since banning phones last summer\r\nFights arrange… [+6368 chars]	https://www.bbc.com/news/articles/czxy1n9dgl3o	https://ichef.bbci.co.uk/news/1024/branded_news/e9d8/live/8dac3f80-357f-11f0-9b2c-138cad92aeb3.jpg	2025-05-21 22:08:14
227	0.08	14	NewsAPI	7 Mother’s Day Gifts That Show Love And Protect The Planet	Discover 7 sustainable Mother’s Day gifts that show deep love while protecting the planet—thoughtful, last-minute ideas for a greener, more meaningful celebration.	Daughter hugging mother\r\ngetty\r\nMothers Day is just days away, and while we scramble for thoughtful ways to show love, we often overlook the hidden environmental costs that come with last-minute gift… [+6404 chars]	https://www.forbes.com/sites/dianneplummer/2025/05/09/7--mothers-day-gifts-that-show-love-and-protect-the-planet/	https://imageio.forbes.com/specials-images/imageserve/681dee502e08370b6353b8db/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-09 12:21:02
228	0.08	14	NewsAPI	New Survey from Prodigy Education Finds Teacher Stress Levels Have Surpassed Pandemic-Era Highs	Nearly half of U.S. teachers say this is the most stressful school year of their careers, signaling a tipping point for support needed beyond Teacher Appreciation Week this year Nearly half of U.S. teachers say this is the most stressful school year of their …	Toronto, May 05, 2025 (GLOBE NEWSWIRE) -- Toronto, May 5, 2025: As Teacher Appreciation Week begins, new survey data from Prodigy Education\r\n (Prodigy) reveals that Americas K-12 educators are more s… [+5011 chars]	https://www.globenewswire.com/news-release/2025/05/05/3073872/0/en/New-Survey-from-Prodigy-Education-Finds-Teacher-Stress-Levels-Have-Surpassed-Pandemic-Era-Highs.html	https://ml.globenewswire.com/Resource/Download/9ef63f49-480f-4699-ab10-2566aca3d49a	2025-05-05 10:00:00
229	0	14	NewsAPI	Trump threatened school funding in Maine. Here's how that money is used	Schools in Maine are in the middle of a political and legal battle between the Trump administration and Gov. Janet Mills. Key programs for the most vulnerable students are at stake.	Jonathan Moody runs a rural school district in and around Skowhegan, Maine, about 90 miles north of Portland. His office is in an old, converted farmhouse; the conference room was once a chicken coop… [+8659 chars]	https://www.npr.org/2025/05/19/nx-s1-5398545/trump-schools-maine-education-funding	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+314/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F3a%2Ffa%2F36d01b304d37820e4837ecc51b63%2Fgrybus-npr-titleone-hr-02-9328.jpg	2025-05-19 10:00:00
230	0	14	NewsAPI	A critical fight over “quality” child care could shape millions of kids	America’s lack of affordable child care has brought a long-simmering question to a boil: What exactly makes child care “good”?  Everyone wants quality care for kids, and the need for child care or preschool to be considered “high quality” has been embraced by…	America’s lack of affordable child care has brought a long-simmering question to a boil: What exactly makes child care “good”? \n\nEveryone wants quality care for kids, and the need for child care or p… [+12126 chars]	https://www.vox.com/child-care/413120/child-care-daycare-quality-preschool-head-start-qris-standards-children	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/kids.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200	2025-05-16 23:01:33
231	0	14	NewsAPI	What to know about a federal proposal to help families pay for private school	Republicans want to use the federal tax code to create a national school voucher even in states where voters have fought such efforts.	A first-of-its-kind effort to leverage federal tax dollars to help families pay for private school tuition anywhere in the U.S. is one step closer to becoming a reality.\r\nRepublicans on the House Way… [+6314 chars]	https://www.npr.org/2025/05/14/nx-s1-5397945/private-school-vouchers-choice-reconciliation	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3000x1688+0+198/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F66%2Fb0%2F0411f356468caf668e0eee30cd28%2Fgettyimages-2199281234.jpg	2025-05-14 20:46:27
232	0	14	NewsAPI	Fond du Lac School District layoffs & the latest on 7 more top stories from April	Last month's top news included post-election stories, new businesses in Fond du Lac and a final look back at the height of COVID-19 after five years.	FOND DU LAC Spring has a variety of appealing aspects to Fond du Lac, and so did the top stories of April.\r\nSome of the most-read stories of last month were related to the spring election April 1, wh… [+6543 chars]	https://www.fdlreporter.com/story/news/local/2025/05/02/fond-du-lac-school-district-budget-cuts-layoffs-more-top-news-from-april/83385799007/	https://s.yimg.com/ny/api/res/1.2/5GjytiEvfUqkI9RowBNjFA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD05MDA-/https://media.zenfs.com/en/fdl-reporter-the-reporter/3afbd69e7b9abce9b8e79f65c98ff345	2025-05-02 10:02:09
233	0	14	NewsAPI	Happy teacher, happy class	PETALING JAYA: Giving teachers the option to request for a transfer after just two years of service can make the profession more appealing to the younger generation, say stakeholders. Read full story	PETALING JAYA: Giving teachers the option to request for a transfer after just two years of service can make the profession more appealing to the younger generation, say stakeholders.\r\nUniversiti Mal… [+3625 chars]	https://www.thestar.com.my/news/nation/2025/05/17/happy-teacher-happy-class	https://apicms.thestar.com.my/uploads/images/2025/05/17/3319548.jpg	2025-05-16 16:00:00
234	0	14	NewsAPI	Rethinking Contemporary Education: How Generative AI Can Fill The Gaps Of A Shifting System	If the last decade in edtech was about bringing classrooms online, the next one must be about making them feel human again.	Nina Greenwood is a passionate educator, founder and CEO of Happy Plum Language Learning, an Ed-Tech startup based out of Harvard i-lab.\r\ngetty\r\nAs a former educator, founder of an AI-powered languag… [+5569 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/05/21/rethinking-contemporary-education-how-generative-ai-can-fill-the-gaps-of-a-shifting-system/	https://imageio.forbes.com/specials-images/imageserve/682c8991f543511355c56b07/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-21 13:30:00
235	0	14	NewsAPI	Trying to teach in the age of the AI homework machine	Trying to teach in the age of the AI homework machine.	Last summer I made the case for bringing the principle of Dunes Butlerian Jihad  Thou shalt not make a machine in the likeness of a human mind to our broader discourse on AI. It seemed like a good wa… [+17705 chars]	https://www.solarshades.club/p/dispatch-from-the-trenches-of-the	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fde63320e-16b0-4351-a920-afbca4650558_3213x3024.jpeg	2025-05-26 19:20:19
236	0	14	NewsAPI	Dysolve: Tackling The Dyslexia Crisis & Pandemic Learning Loss With AI	Dysolve leverages AI-driven games to combat dyslexia and pandemic-induced learning deficits, reshaping literacy outcomes and transforming education affordably.	Using a series of generative AI games, Dysolve helps students overcome the challenge of dyslexia.\r\nDysolve\r\nFifteen months ago, Dysolve, an innovative AI-driven solution for dyslexia developed by Dr.… [+5751 chars]	https://www.forbes.com/sites/rayravaglia/2025/05/21/dysolve-tackling-the-dyslexia-crisis--pandemic-learning-loss-with-ai/	https://imageio.forbes.com/specials-images/imageserve/682d98c16ca824180342a379/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-21 10:00:05
237	0	14	NewsAPI	P.E.I. schools to track complaints after substitute who sexually touched student kept teaching	P.E.I.'s Public Schools Branch has implemented a central reporting system to track all complaints regarding staff after it was revealed in court that substitute teacher Matthew Alan Craswell was able to continue working after sexually touching a student at a …	WARNING: This story contains descriptions of child sex abuse and other content that may be disturbing to readers.\r\nP.E.I.'s Public Schools Branch has implemented a central reporting system to track a… [+6581 chars]	https://www.cbc.ca/news/canada/prince-edward-island/pei-craswell-third-party-review-1.7524110	https://i.cbc.ca/1.7298696.1746040124!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_1180/matthew-alan-craswell.jpg?im=Resize%3D620	2025-05-01 19:50:29
238	0	14	NewsAPI	States Are Scrambling to Fill School Vacancies Left by Burned Out Teachers	States are softening teacher training and licensing requirements amid widespread turmoil in public schools.	As another school year ends, superintendents across the United States are staring down an autumn staffing crisis, with 1 in 8 teaching positions either vacant or filled by an underqualified educator.… [+10144 chars]	https://stateline.org/2025/05/21/as-teacher-burnout-deepens-states-scramble-to-fill-school-job-vacancies/	https://truthout.org/app/uploads/2025/05/GettyImages-1246345848-scaled.jpg	2025-05-25 13:21:11
239	0	14	NewsAPI	[Eugene Volokh] Requiring Fifth-Graders to Read Pro-Gender-Ideology Books to Kindergarten Students (with No Opt Out) May Violate First Amendment	From Judge James Lorenz's order yesterday in S.E. v. Grey (S.D. Cal.): The school activity at issue occurred in the context of the buddy program, a weekly	From Judge James Lorenz's order yesterday in S.E. v. Grey (S.D. Cal.):\r\nThe school activity at issue occurred in the context of the buddy program, a weekly class pairing younger and older students. T… [+7752 chars]	https://reason.com/volokh/2025/05/13/requiring-fifth-graders-to-read-pro-gender-ideology-books-to-kindergarten-students-with-no-opt-out-may-violate-first-amendment/	https://d2eehagpk5cl65.cloudfront.net/img/q60/uploads/2021/11/the-volokh-conspiracy.jpg	2025-05-13 12:01:07
240	0	14	NewsAPI	Long Before AGI: Three AI Milestones That Will Challenge You	Before AI reaches AGI, it will cross other significant milestones that will challenge human society. We list three that are already occuring.	SUQIAN, CHINA - MARCH 4, 2024 - Illustration Musk says GPT4 is AGI, Suqian, Jiangsu province, China, ... More March 4, 2024. (Photo credit should read CFOTO/Future Publishing via Getty Images)\r\nFutur… [+4156 chars]	https://www.forbes.com/sites/nishatalagala/2025/05/07/long-before-agi-three-ai-milestones-that-will-challenge-you/	https://imageio.forbes.com/specials-images/imageserve/681b81cf131e9d09dfa54225/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-07 16:08:29
241	0	14	NewsAPI	Developer Spotlight: Andrew Woan	A beautifully honest, unexpectedly funny reflection on creativity, code, and being human—this is not your average dev story.	Free course recommendation:Master JavaScript animation with GSAP through 34 free video lessons, step-by-step projects, and hands-on demos. Enroll now \r\nHey everyone, I’m Andrew! I love cute things (e… [+114569 chars]	https://tympanus.net/codrops/2025/05/15/developer-spotlight-andrew-woan/	https://codrops-1f606.kxcdn.com/codrops/wp-content/uploads/2025/05/Actual-Dev-Spotlight.png?x68737	2025-05-15 12:43:39
242	0	14	NewsAPI	NEA: Trump Slashes Education Budget, Encourages Privatization of Public Schools	The National Education Association analyzed Trump ‘s proposed budget and finds that it contains deep cuts and massive support for privatization by promoting vouchers and charter schools. The proposal mirrors Project 2025 by turning Titl 1 for low-income stude…	The National Education Association analyzed Trump ‘s proposed budget and finds that it contains deep cuts and massive support for privatization by promoting vouchers and charter schools. The proposal… [+2515 chars]	https://dianeravitch.net/2025/05/13/nea-trump-slashes-education-budget-encourages-privatization-of-public-schools/	https://dianeravitch.net/wp-content/uploads/2017/12/diane.jpg?w=200	2025-05-13 13:00:00
243	0	14	NewsAPI	What Can the Federal Government Do to Promote Learning?	On May 10, Dana Goldstein wrote a long article in The New York Times about how education disappeared as a national or federal issue. Why, she wondered, did the two major parties ignore education in the 2024 campaign? Kamala Harris supported public schools and…	On May 10, Dana Goldstein wrote a long article in The New York Times about how education disappeared as a national or federal issue. Why, she wondered, did the two major parties ignore education in t… [+11189 chars]	https://dianeravitch.net/2025/05/23/what-can-the-federal-government-do-to-promote-learning/	https://dianeravitch.net/wp-content/uploads/2017/12/diane.jpg?w=200	2025-05-23 13:00:00
244	0.185	15	NewsAPI	The Future of Standardized Assessment	With Daniel McCaffrey, ETS Research Institute \nWednesday, May 21, 2025, 12 – 1 p.m. PT / 3 – 4 p.m. ET \nThis is a virtual event.	Dr. Daniel McCaffrey, Frederic Lord Chair of Measurement and Statistics in the ETS Research Institute, will discuss the current trends in standardized testing and leverage these to make conjectures a… [+3075 chars]	https://www.rand.org/events/2025/05/future-of-standardized-assessment.html	https://www.rand.org/content/rand/events/2025/05/future-of-standardized-assessment/jcr:content/par/teaser.crop.1200x900.cm.jpeg/1746651596061.jpeg	2025-05-14 00:06:35
245	0.178	15	NewsAPI	6 eLearning Trends Reshaping Corporate Training	Take a look at six top eLearning trends for corporate training and learn how to provide your staff with exceptional learning experiences.\nThis post was first published on eLearning Industry.	Corporate eLearning Trends For Your Next Training\r\nThe world of eLearning has been evolving fast over the past few years. As we approach 2025, the shelf life of skills is decreasing, and learner expe… [+5620 chars]	https://elearningindustry.com/elearning-trends-reshaping-corporate-training	https://cdn.elearningindustry.com/wp-content/uploads/2025/05/6-eLearning-Trends-Reshaping-Corporate-Training.jpg	2025-05-10 15:00:39
246	0.089	15	NewsAPI	10 High-Paying Jobs In Education That Don't Require A Degree	Find high-paying teaching jobs that don’t require a degree. Use your skills and experience to break into the education field—no diploma needed.	As the education sector evolves, it will move toward greater personalization, online learning and a ... More focus on skills over traditional credentials.\r\ngetty\r\nWhile many assume education careers … [+11511 chars]	https://www.forbes.com/sites/carolinecastrillon/2025/05/07/high-paying-teaching-jobs-no-degree/	https://imageio.forbes.com/specials-images/imageserve/681a7de2eb802b247b791028/0x0.jpg?format=jpg&crop=2469,1389,x0,y222,safe&height=900&width=1600&fit=bounds	2025-05-07 17:00:00
247	0.089	15	NewsAPI	The College Board Exposed: Nonprofit Or $1.6 Billion Testing Monopoly In Disguise?	Is the College Board a non-profit or corporation?  Profits, labor practices and off-shore financing suggest the latter.	Students testing on computers\r\ngetty\r\nFounded 1900 to democratize college access, the College Board now straddles an uncomfortable line between its nonprofit mission and corporate-scale revenues. Whi… [+5317 chars]	https://www.forbes.com/sites/scottwhite/2025/05/26/the-college-board-exposed-nonprofit-or-16-billion-testing-monopoly-in-disguise/	https://imageio.forbes.com/specials-images/imageserve/6834fb68527d97aedc71f5f1/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-26 23:44:52
248	0.089	15	NewsAPI	Standardized Admission Tests Are Not Biased. In Fact, They’re Fairer Than Other Measures	This article challenges common misconceptions, providing robust scientific evidence that standardized admission tests are fair, unbiased, and accurate predictors of academic success, ultimately arguing that removing these tests would make admissions less equi…	It aint what you know that gets you into trouble. Its what you know for sure that just aint so. Mark Twain\r\nWhen it comes to opinions concerning standardized tests, it seems that most people know for… [+22399 chars]	https://www.skeptic.com/article/standardized-admission-tests-fairer-than-other-measures-not-biased/	https://www.skeptic.com/content/images/size/w1200/2025/04/students-taking-SAT.webp	2025-05-22 22:08:36
249	0.089	15	NewsAPI	Professional identity and its relationships with AI readiness and interprofessional collaboration	Background In contemporary healthcare practices, the convergence of Artificial Intelligence (AI) and interprofessional collaboration represents a transformative era marked by unprecedented opportunities and challenges. The introduction of AI technologies is a…	Abstract\r\nBackground\r\nIn contemporary healthcare practices, the convergence of Artificial Intelligence (AI) and interprofessional collaboration represents a transformative era marked by unprecedented… [+36032 chars]	https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0322794	https://journals.plos.org/plosone/article/figure/image?id=10.1371/journal.pone.0322794.t004&size=inline	2025-05-16 14:00:00
250	0	15	NewsAPI	A critical fight over “quality” child care could shape millions of kids	America’s lack of affordable child care has brought a long-simmering question to a boil: What exactly makes child care “good”?  Everyone wants quality care for kids, and the need for child care or preschool to be considered “high quality” has been embraced by…	America’s lack of affordable child care has brought a long-simmering question to a boil: What exactly makes child care “good”? \n\nEveryone wants quality care for kids, and the need for child care or p… [+12126 chars]	https://www.vox.com/child-care/413120/child-care-daycare-quality-preschool-head-start-qris-standards-children	https://platform.vox.com/wp-content/uploads/sites/2/2025/05/kids.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200	2025-05-16 23:01:33
251	0	15	NewsAPI	Inspiration – The Quintessence Of Education Amid AI. A Teacher Roadmap	As AI redefines our world the question isn’t just what to teach, but how to ignite a genuine passion for knowledge We reignite the true heart of education – inspiration.	Close-up photo of child's hands touch painting rainbow on window. Family life background. Image of ... More kids leisure at home, childcare, safety joy symbol.\r\ngetty\r\nAs AI redefines our world, educ… [+8743 chars]	https://www.forbes.com/sites/corneliawalther/2025/05/23/inspiration--the-quintessence-of-education-amid-ai-a-teacher-roadmap/	https://imageio.forbes.com/specials-images/imageserve/6830cfd6d74e81db8d9e23c1/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-23 19:54:33
252	0	15	NewsAPI	How AI Can Make Education More Human	By automating administrative tasks, AI can free educators to do what only humans can do effectively: inspire, mentor and connect.	Max Bohun is Founder &amp; CEO of GradeWiz, a Y Combinator-backed edtech featured in TechCrunch's "10 startups to watch from YCs W25 Demo Day."\r\ngetty\r\nEducation is currently facing a significant cha… [+7096 chars]	https://www.forbes.com/councils/forbesbusinesscouncil/2025/05/15/how-ai-can-make-education-more-human/	https://imageio.forbes.com/specials-images/imageserve/6824c375e93ac80e3cb9a230/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-05-15 11:30:00
253	0	15	NewsAPI	Peace Of Mind Over Paychecks: The New Financial Literacy Gen Z Needs	Gen Z redefines financial success by valuing peace of mind over wealth, seeking financial education on their own terms, and calling for new financial literacy approaches.	Gen Z redefines financial success: valuing peace of mind over wealth, seeking financial education on ... More their terms, and facing a complex financial landscape that requires new literacy approach… [+9940 chars]	https://www.forbes.com/sites/alisongriffin/2025/04/30/peace-of-mind-over-paychecks-the-new-financial-literacy-gen-z-needs/	https://imageio.forbes.com/specials-images/imageserve/681155fdc4f7f9987626aa7a/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-30 10:00:00
254	0	15	NewsAPI	I’m a Public-School English Teacher. The Most Vocal Defenders of K–12 Liberal Arts Are Not Who You’d Expect.	Common Core and the College Board are my enemies. But the classical education movement is not my friend.	Sign up for the Slatest to get the most insightful analysis, criticism, and advice out there, delivered to your inbox daily.\r\nOn May 6, the Texas House Committee on Public Education discussed S.B. 13… [+13708 chars]	https://slate.com/life/2025/05/classical-education-book-banning-literacy-reading.html	https://compote.slate.com/images/8261849e-e7fc-4ea6-a359-ecddd0d74172.jpeg?crop=1560%2C1040%2Cx0%2Cy0&width=1560	2025-05-23 17:38:16
255	0	15	NewsAPI	Is Data Driving or Hijacking Education Policy in India? (Blog)	Data-driven decision-making has become central to education in India. While data provides invaluable insights, using it to shape policy is not without its risks.	Not everything that can be counted counts, and not everything that counts can be counted.William Bruce Cameron\r\nIt is often said that anything you can say about India, the opposite is equally valid. … [+15287 chars]	https://ssir.org/articles/entry/india-education-policy-data	https://ssir.org/images/blog/india-education-policy-data-737x737.jpg	2025-05-01 12:00:00
256	0	15	NewsAPI	The Elements Of A Digital Classroom	In a digital classroom, teachers can become worried that no ‘real learning’ is happening or that they’ve somehow failed to plan sufficiently.\nSource	by TeachThought Staff\r\nWhat makes up a classroom?\r\nIs it the space? A room, for example?\r\nIs it the purpose? Can a regular meeting space in a garden be a horticulture classroom?\r\nIs it the people? Ca… [+14889 chars]	https://www.teachthought.com/technology/digital-classroom/	https://www.teachthought.com/wp-content/uploads/2017/12/917CA939-A647-4C04-837B-309F81ADC0D0-e1512371320490.jpeg	2025-05-19 04:01:00
257	0	15	NewsAPI	Texas’s School Choice Bill Isn’t As Good As Claimed	On May 3, Texas Governor Abbott signed the state’s first school choice bill, which he has hailed as a “historic victory.” Moving forward, half of American students will live in states with school choice. Although Abbott touts the pr...	On May 3, Texas Governor Abbott signed the state’s first school choice bill, which he has hailed as a “historic victory.” Moving forward, half of American students will live in states with school cho… [+6907 chars]	https://www.americanthinker.com/articles/2025/05/texas_s_school_choice_bill_isn_t_as_good_as_claimed.html	https://images.americanthinker.com/ex/exdfhhovdc9b1ktrzzgi_800.jpg	2025-05-04 04:00:00
258	0	15	NewsAPI	Competition Improves Services. So Why Not Apply That to Schools?	Now that Texas and South Carolina have passed school choice bills, parents will be able to choose the best school for their kids in 17 states. Why not all	Now that Texas and South Carolina have passed school choice bills, parents will be able to choose the best school for their kids in 17 states. Why not all states? After all, competition improves serv… [+4323 chars]	https://reason.com/2025/05/21/competition-improves-services-so-why-not-apply-that-to-schools/	https://d2eehagpk5cl65.cloudfront.net/img/q60/uploads/2025/05/john-stossel-school-choice-scaled.png	2025-05-21 15:56:19
260	0	15	NewsAPI	What Can the Federal Government Do to Promote Learning?	On May 10, Dana Goldstein wrote a long article in The New York Times about how education disappeared as a national or federal issue. Why, she wondered, did the two major parties ignore education in the 2024 campaign? Kamala Harris supported public schools and…	On May 10, Dana Goldstein wrote a long article in The New York Times about how education disappeared as a national or federal issue. Why, she wondered, did the two major parties ignore education in t… [+11189 chars]	https://dianeravitch.net/2025/05/23/what-can-the-federal-government-do-to-promote-learning/	https://dianeravitch.net/wp-content/uploads/2017/12/diane.jpg?w=200	2025-05-23 13:00:00
261	0	15	NewsAPI	Dual Enrollment Numbers Are Rising. Colleges Want Them to Keep Growing.	As more high school students benefit from taking college classes, education experts want to make sure that all districts, not just wealthy ones, give ...	Dual enrollment courses are considered some of the best ways to prepare students for the rigor and content in college-level curricula. \r\nNot only do these courses offer students a jump-start on credi… [+8699 chars]	https://www.edsurge.com/news/2025-05-09-dual-enrollment-numbers-are-rising-colleges-want-them-to-keep-growing	https://edsurge.imgix.net/uploads/post/image/16279/shutterstock_2129873411-1746640550.jpg?auto=compress%2Cformat&w=1024&h=512&fit=crop	2025-05-09 09:51:00
262	0	15	NewsAPI	Democratic California Rep. Ro Khanna Blasts Left-Wing School District For Ditching Honors Program	Democratic Rep. Ro Khanna is among several voices flaying the Palo Alto Unified School District's (PAUSD) decision to eliminate its honors program in biology.	A California Democrat is among several voices flaying the Palo Alto Unified School District’s (PAUSD) decision to eliminate its honors program in biology.\r\nDemocratic California Rep. Ro Khanna said M… [+4295 chars]	https://dailycaller.com/2025/05/12/ro-khanna-palo-alto-unified-school-district-honors-biology-program/	https://cdn01.dailycaller.com/wp-content/uploads/2024/09/DCNF-Khanna-Wealth-Tax-Harris-Featured.jpg	2025-05-12 20:05:32
263	0	15	NewsAPI	Cheers for school choice — competition makes ALL education better	In most of America, when it comes to choosing a school for our kids, bureaucrats decide.	Now that Texas and South Carolina have passed school choice bills, parents will be able to choose the best school for their kids in 17 states.\r\nWhy not all states?\r\nAfter all, competition improves se… [+4403 chars]	https://nypost.com/2025/05/21/opinion/cheers-for-school-choice-because-competition-improves-all/	https://nypost.com/wp-content/uploads/sites/2/2025/05/W343RW.jpg?quality=75&strip=all&w=1024	2025-05-22 00:35:35
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
4	4	qe9QSCF-d88	Yoshua Bengio — the world's most-cited computer scientist and a "godfather" of artificial intelligence — is deadly concerned about ...	https://i.ytimg.com/vi/qe9QSCF-d88/hqdefault.jpg	14	3
5	13	uiUPD-z9DTg	Who runs the world? Political scientist Ian Bremmer argues it's not as simple as it used to be. With some eye-opening questions ...	https://i.ytimg.com/vi/uiUPD-z9DTg/hqdefault.jpg	57	3
7	8	5412adH3cS8	Learn how to use AI to grow your business. Access 20+ expert courses & community—free for 7 days: https://bit.ly/skill-leap Here ...	https://i.ytimg.com/vi/5412adH3cS8/hqdefault.jpg	37	1
8	1	HQ-Kg_xgdhE	Inflation is one of the most important concepts in economics. It's also one of the simplest. It's just the average rate that prices are ...	https://i.ytimg.com/vi/HQ-Kg_xgdhE/hqdefault.jpg	2	1
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
146	1	1
67	2	3
143	3	3
132	4	3
146	5	3
224	6	3
243	7	3
205	8	3
222	9	3
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
7	1	3
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, topic_id, text, keywords, "order") FROM stdin;
1	1	How do supply-side bottlenecks interact with monetary policy to shape current inflationary pressures?	side bottlenecks interact, monetary policy, supply	0
2	1	What is the Phillips Curve's relevance in today's economy, and how should we interpret wage-price spirals?	price spirals, phillips curve, interpret wage, today, relevance	1
3	1	How can fiscal policy be optimally designed to complement monetary policy in controlling inflation without hindering long-term growth?	complement monetary policy, fiscal policy, term growth, optimally designed	2
4	2	How can short-term weather forecasts better incorporate long-term climate trends to improve accuracy?	term climate trends, improve accuracy, short	0
5	2	What are the most effective ways to communicate climate change impacts on local weather patterns to the public?	local weather patterns, effective ways, public	1
6	2	How are changing climate conditions affecting the frequency and intensity of extreme weather events, and how can we better prepare?	extreme weather events, better prepare, intensity, frequency	2
7	3	How do we ensure AI models remain accurate and reliable over time as data changes?	data changes, time, reliable	0
8	3	What methods can we use to effectively explain complex AI model decisions to stakeholders?	use, stakeholders, methods	1
9	3	How can data scientists adapt their skills to leverage emerging AI technologies responsibly?	data scientists adapt, skills	2
10	4	How can we reduce administrative burdens to prioritize patient care?	reduce administrative burdens, prioritize patient care	0
11	4	What innovations will best address the growing physician burnout crisis?	best address, innovations	1
12	4	How can data better inform treatment decisions and improve patient outcomes?	improve patient outcomes	2
13	5	How can we better support diverse learners' individual needs within limited classroom resources?		0
14	5	What strategies can reduce teacher burnout and promote well-being while maintaining high-quality instruction?	reduce teacher burnout, quality instruction, promote well, maintaining high, strategies	1
15	5	How do we measure and foster critical thinking skills in an era of standardized testing?	standardized testing, measure, era	2
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
1	Inflation	Economist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_1_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044514Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=e2a18d189fe5ee3eb10aa1522ca9e40b42e148e0b2e4cf93843cc3c33d0fa382,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_1_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044515Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=95227f0d9a3bb6e44f1ffe6688e9b707634e629b41eb108b1d1f59b30a6656e6,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_1_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044516Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6b924c686b143b21a6676d80c98c23bba85f78a6ae541c65a514243aec32195b}
2	Climate	Meteorologist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_2_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044524Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=b3fbb41d500dfe5811ee813b89e9d974f1bc85e11455a146ce566c94013ce11a,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_2_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044525Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=bb9d4dd08d50bea927077bfd4f02bc3fbe84e646f9d2720d756c3f48025e81b2,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_2_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044527Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ab115adddf187caf5f5f623560a544073915a3c8a4230662ced16863253f9f2f}
3	AI	Data Scientist	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_3_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044536Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=0293cea3f599a96d702171d3773eafefc87cd57dc1495b724cd940f26496d414,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_3_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044537Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=67aed09ed66536aa39406215fdf63355224e0f1946d3b4b1b9ff8072c7cd1d37,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_3_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044538Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9fffd6df5e60f2075af65e3cc065e9790bd53fcdbb8b8e99d2930860b5968ae5}
4	Healthcare	Doctor	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_4_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044547Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=6736c332c355ac5f75b222455f1e1dd968510091f85ee854fb08bb5fd546640e,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_4_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044548Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=3a0320521a68a0b570ddb0cc4cd3df15c786e5d6d2b2b8afa7e76477831e7e89,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_4_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044549Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=f637a52c87d2fef567dcc9009bcfc443c3dfdf9e37e59432e99fccf2e30e3ce9}
5	Education	Teacher	{https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_5_0.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044556Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=ee396a1299a528669cb891e0729d62099c2b09fe8653612381bc9293af1130db,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_5_1.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044558Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=a665f24e4000559fd3f0b3a9987dc5ab94df80adc5fee4e4016eda2ec0dde849,https://s3.us-east-2.amazonaws.com/newsroom.bucket/2025-05/2025-05-27/topic_5_2.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAZ4O64PIAVCEY4J4I%2F20250528%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20250528T044559Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=698184515c389b6bec29e6db6ad5808f524745e5977bceb290efac1758832e07}
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
1	1	bv-uNNkE39I	In this video I overview fiscal and monetary policy and how the economy adjust in the long run. Keep in mind that fiscal and ...	https://i.ytimg.com/vi/bv-uNNkE39I/hqdefault.jpg
2	1	o0Yt6buayZ4	Governments are typically concerned with curbing both unemployment and inflation, and there are two ways they approach this, ...	https://i.ytimg.com/vi/o0Yt6buayZ4/hqdefault.jpg
3	1	R8VBRCs2jTU	When central banks raise interest rates, the impact is felt far and wide. Mortgages become more expensive, house prices might fall ...	https://i.ytimg.com/vi/R8VBRCs2jTU/hqdefault.jpg
4	1	a2azB2eag5I	In this video I explain the most important graph in your macroeconomics class. The aggregate demand and supply model.	https://i.ytimg.com/vi/a2azB2eag5I/hqdefault.jpg
5	1	PvfdPfEd-gk	Supply Side Policies (Interventionist and Market Based) - With Evaluation. Video covering everything you need to know regarding ...	https://i.ytimg.com/vi/PvfdPfEd-gk/hqdefault.jpg
6	2	spmI8yBwrT0	Hey students. In this video I show you how to draw and shift the Phillips curve. Remember that there are two curves: the short-run ...	https://i.ytimg.com/vi/spmI8yBwrT0/hqdefault.jpg
7	2	y234PB-ORp4	What is the #Phillips #Curve? This video explains the #PhillipsCurve It starts with a quick 1 minute introduction to the Phillips ...	https://i.ytimg.com/vi/y234PB-ORp4/hqdefault.jpg
8	2	H_LHFs_Htak	Bill Phillips' curve historically described an inverse relationship between the rate of unemployment and the rate of wage (and ...	https://i.ytimg.com/vi/H_LHFs_Htak/hqdefault.jpg
9	2	USj52Vlvd5M	In this video I explain hyperinflation and the difference between cost-push and demand-pull inflation. Need help? Check out the ...	https://i.ytimg.com/vi/USj52Vlvd5M/hqdefault.jpg
10	2	eN20tOlnyb8	Long run and short run Phillips curves.	https://i.ytimg.com/vi/eN20tOlnyb8/hqdefault.jpg
11	3	bv-uNNkE39I	In this video I overview fiscal and monetary policy and how the economy adjust in the long run. Keep in mind that fiscal and ...	https://i.ytimg.com/vi/bv-uNNkE39I/hqdefault.jpg
12	3	o0Yt6buayZ4	Governments are typically concerned with curbing both unemployment and inflation, and there are two ways they approach this, ...	https://i.ytimg.com/vi/o0Yt6buayZ4/hqdefault.jpg
13	3	R8VBRCs2jTU	When central banks raise interest rates, the impact is felt far and wide. Mortgages become more expensive, house prices might fall ...	https://i.ytimg.com/vi/R8VBRCs2jTU/hqdefault.jpg
14	3	uBaTPugw3M4	Monetary Policy - Interest Rates, Money Supply & Exchange Rate. Video covering everything you need to know regrading ...	https://i.ytimg.com/vi/uBaTPugw3M4/hqdefault.jpg
15	3	IMkLAP_aj3I	All you need to know about Monetary Policy in 4 minutes: The objectives and instruments of Monetary Policy. Central banks.	https://i.ytimg.com/vi/IMkLAP_aj3I/hqdefault.jpg
16	4	fSintmGf4HA	How Do Climate Models Help To Predict Weather? In this informative video, we will discuss the role of climate models in ...	https://i.ytimg.com/vi/fSintmGf4HA/hqdefault.jpg
17	4	Jwz1--cwnCs	The science of weather is known as meteorology. It is the study of the atmosphere, its properties, and the processes that cause ...	https://i.ytimg.com/vi/Jwz1--cwnCs/hqdefault.jpg
18	4	wQ5tNHSrNsw	Discover the cutting-edge techniques in meteorological data analysis with our in-depth exploration of bias correction and quantile ...	https://i.ytimg.com/vi/wQ5tNHSrNsw/hqdefault.jpg
19	4	eXxynonlQnk	Meteorology is the scientific study of the Earth's atmosphere, weather, and climate. It encompasses the examination of various ...	https://i.ytimg.com/vi/eXxynonlQnk/hqdefault.jpg
20	4	dhPQb2grVgE	World meteorology refers to the study of weather patterns, atmospheric conditions, and climate on a global scale. It encompasses ...	https://i.ytimg.com/vi/dhPQb2grVgE/hqdefault.jpg
21	5	H8u7oqFxqVk	Science On Screen® brings you to the Film Society of Minneapolis St. Paul in Minneapolis, MN for a screening of Ice and the Sky.	https://i.ytimg.com/vi/H8u7oqFxqVk/hqdefault.jpg
22	5	fdErsR8_NaU	This new cartoon, narrated by Konnie Huq, asks how weather forecasting works and how forecasts help us plan ahead. To learn ...	https://i.ytimg.com/vi/fdErsR8_NaU/hqdefault.jpg
23	5	4i8l2_oZK_c	What Are The Impacts Of Climate Change On Meteorological Patterns? Climate change is reshaping our weather systems in ...	https://i.ytimg.com/vi/4i8l2_oZK_c/hqdefault.jpg
24	5	MbZlFWt8fus	Explore the science of meteorology and its study of weather patterns and climate. Learn about atmospheric phenomena, weather ...	https://i.ytimg.com/vi/MbZlFWt8fus/hqdefault.jpg
25	5	nNmWAo0kDGk	You probably know about weather, but do you know what it actually is, how it works, and why it changes depending on where you ...	https://i.ytimg.com/vi/nNmWAo0kDGk/hqdefault.jpg
26	6	NCPTbfQyMt8	Explore the differences between weather and climate – what they are, how we predict them, and what those predictions can tell us ...	https://i.ytimg.com/vi/NCPTbfQyMt8/hqdefault.jpg
27	6	WiIB80-QnUI	How Could Global Climate Change Affect Extreme Meteorological Events? In this informative video, we will discuss the impact of ...	https://i.ytimg.com/vi/WiIB80-QnUI/hqdefault.jpg
28	6	IVDGKcxcvi0	Can Weather Forecasting Help Us Prepare For Extreme Weather Intensification? Have you ever thought about how weather ...	https://i.ytimg.com/vi/IVDGKcxcvi0/hqdefault.jpg
29	6	1N334Kv7zsw	Climate Change is causing extreme weather events around the world and South Asia is facing worst weather due to climate ...	https://i.ytimg.com/vi/1N334Kv7zsw/hqdefault.jpg
30	6	v0QLkI-Lc7s	We've all asked ourselves: does that storm, fire or drought we just lived through have anything to do with climate change? Thanks ...	https://i.ytimg.com/vi/v0QLkI-Lc7s/hqdefault.jpg
31	7	cfrZ3Yiubxk	Join me as we dive into a deep discussion about the future of data science in the era of rapidly evolving AI. Whether you're a data ...	https://i.ytimg.com/vi/cfrZ3Yiubxk/hqdefault.jpg
32	7	jZGWOUNeiFY	Data Engineer vs. Data Scientist: What's the difference? Comment below if you have any questions #sundaskhalid #bigtech ...	https://i.ytimg.com/vi/jZGWOUNeiFY/hqdefault.jpg
33	7	g4qRple_dmM	Should you get a Master's degree in data science? Maybe or maybe not. Subscribe to my data science channel: ...	https://i.ytimg.com/vi/g4qRple_dmM/hqdefault.jpg
34	7	99VAnyVX5rY	DataRobot's Chief Scientist, Michael Schmidt, explains the time series technology, obstacles, and its huge impact on data ...	https://i.ytimg.com/vi/99VAnyVX5rY/hqdefault.jpg
35	8	Vxw0nE1qfZc	Get the guide to generative AI → https://ibm.biz/BdmSiA Explore the technology → https://ibm.biz/BdmSi9 Breakthroughs in ...	https://i.ytimg.com/vi/Vxw0nE1qfZc/hqdefault.jpg
36	8	9R3X0JoCLyU	Go from zero to a data scientist in 12 months. This step-by-step roadmap covers the essential skills you must learn to become a ...	https://i.ytimg.com/vi/9R3X0JoCLyU/hqdefault.jpg
37	8	zD73uHl4k8w	Check out this proven roadmap to become a Data Scientist in 2025!	https://i.ytimg.com/vi/zD73uHl4k8w/hqdefault.jpg
38	8	vNc2z2u_nh0	Artificial Intelligence Engineer (IBM) ...	https://i.ytimg.com/vi/vNc2z2u_nh0/hqdefault.jpg
39	8	5x3hnmU-OSU	We are data scientists ‍   what did we miss? Follow @sundaskhalidd for more tech content ✨ Tags 🏷️ #datascientist ...	https://i.ytimg.com/vi/5x3hnmU-OSU/hqdefault.jpg
40	9	jZGWOUNeiFY	Data Engineer vs. Data Scientist: What's the difference? Comment below if you have any questions #sundaskhalid #bigtech ...	https://i.ytimg.com/vi/jZGWOUNeiFY/hqdefault.jpg
41	9	M7WdWtlb_3E	Check out Udemy Machine Learning A to Z (more below) https://bit.ly/machine-learning-atoz In this video, we are discussing ...	https://i.ytimg.com/vi/M7WdWtlb_3E/hqdefault.jpg
42	9	9R3X0JoCLyU	Go from zero to a data scientist in 12 months. This step-by-step roadmap covers the essential skills you must learn to become a ...	https://i.ytimg.com/vi/9R3X0JoCLyU/hqdefault.jpg
43	9	zD73uHl4k8w	Check out this proven roadmap to become a Data Scientist in 2025!	https://i.ytimg.com/vi/zD73uHl4k8w/hqdefault.jpg
44	9	5x3hnmU-OSU	We are data scientists ‍   what did we miss? Follow @sundaskhalidd for more tech content ✨ Tags 🏷️ #datascientist ...	https://i.ytimg.com/vi/5x3hnmU-OSU/hqdefault.jpg
45	10	UJ2znpMYU3c	Senator Maggie Hassan, during a Senate Health, Education, Labor, and Pension (HELP) committee hearing, discussed the need ...	https://i.ytimg.com/vi/UJ2znpMYU3c/hqdefault.jpg
46	10	6mFkj__7fyg	MedRevN: Your Partner in Efficiency MedRevN offers a comprehensive suite of services designed to reduce administrative ...	https://i.ytimg.com/vi/6mFkj__7fyg/hqdefault.jpg
47	10	WXZEVB1rJSE	Can Healthcare Outsourcing Make Patient Care More Efficient? Healthcare providers are constantly looking for ways to improve ...	https://i.ytimg.com/vi/WXZEVB1rJSE/hqdefault.jpg
48	10	M_GOrftZqvk	How Can Virtual Medical Scribes Reduce Administrative Burdens?	https://i.ytimg.com/vi/M_GOrftZqvk/hqdefault.jpg
49	11	OBbGYCjAeAE	➱ Instagram: https://www.instagram.com/mikirai/ ➱ Kev's Insta: https://www.instagram.com/k3vmd/ ➱ TikTok: mikiraiofficial + ...	https://i.ytimg.com/vi/OBbGYCjAeAE/hqdefault.jpg
50	11	jh5U5BnpGN8	The future of healthcare will bring far-reaching changes, but what will it look like? We believe that medicine will become more ...	https://i.ytimg.com/vi/jh5U5BnpGN8/hqdefault.jpg
51	11	TfkHrvct1hg	Artificial intelligence is taking the world by storm, and its impact will be felt in all corners of society, including medicine. Is AI in ...	https://i.ytimg.com/vi/TfkHrvct1hg/hqdefault.jpg
52	11	uvqDTbusdUU	Artificial intelligence has the ability to revolutionise and personalise targeted healthcare for individual patients. The regulatory ...	https://i.ytimg.com/vi/uvqDTbusdUU/hqdefault.jpg
53	11	9zlUNw3y5rg	Are we moving towards an era where robots will replace doctors? Hear out this dialogue by Dr Marcus Ranney where he points ...	https://i.ytimg.com/vi/9zlUNw3y5rg/hqdefault.jpg
54	12	0eJL_yqdDDw	2023 Federal Health-at-Home Technology Summit Speakers: Anne Bailey, PharmD, BCPS Director, HHS/VA/Office of Healthcare ...	https://i.ytimg.com/vi/0eJL_yqdDDw/hqdefault.jpg
55	12	TfkHrvct1hg	Artificial intelligence is taking the world by storm, and its impact will be felt in all corners of society, including medicine. Is AI in ...	https://i.ytimg.com/vi/TfkHrvct1hg/hqdefault.jpg
56	12	Ilq0WMUi1Nk	Ontarians who need health care the most often have the most trouble accessing it. Why? Why do doctors drop complex patients?	https://i.ytimg.com/vi/Ilq0WMUi1Nk/hqdefault.jpg
57	12	ghci7IW3W4Y	Watch the full interview here: https://www.youtube.com/watch?v=j7RqO4DfV5A&t=2170s I'll teach you how to become to media's ...	https://i.ytimg.com/vi/ghci7IW3W4Y/hqdefault.jpg
58	12	rFagS54mmOQ	I can now benefit from millions of patients' life experiences because I'm given best practices, probabilities, and models. It's math ...	https://i.ytimg.com/vi/rFagS54mmOQ/hqdefault.jpg
59	13	diFrz4RENEY	In this talk, Gregory Chahrozian delves into the profound impact of teachers and explores how their character and qualities have ...	https://i.ytimg.com/vi/diFrz4RENEY/hqdefault.jpg
60	13	KVLTxKyxioA	Scientific evidence suggests that the secret to thriving students and a good education are amazing teachers. To teach with us, gift ...	https://i.ytimg.com/vi/KVLTxKyxioA/hqdefault.jpg
61	13	1usi5qmWYtE	Watch the full episode here: https://youtu.be/Qro1ixcT-cI Check out our MERCH!	https://i.ytimg.com/vi/1usi5qmWYtE/hqdefault.jpg
62	13	O_95Io07tM4	This is my first #shorts YouTube video. Special education teachers vs. general education teachers when the gift-giving holiday ...	https://i.ytimg.com/vi/O_95Io07tM4/hqdefault.jpg
63	13	nK2PDKPKd7k	SUPPORT THIS CHANNEL: Help keep me going with a tip or contribution https://paypal.me/frankavella?locale.x=en_US ...	https://i.ytimg.com/vi/nK2PDKPKd7k/hqdefault.jpg
64	14	YaCLoUB9aVY	We discuss the growing trend of teachers leaving the profession, which is concerning given the need for quality education.	https://i.ytimg.com/vi/YaCLoUB9aVY/hqdefault.jpg
65	14	mF4O31Vk3Rg	In this video, I'll share my teacher burnout hack for staying in teaching. It's my 23rd year of teaching! Let's start the year by taking ...	https://i.ytimg.com/vi/mF4O31Vk3Rg/hqdefault.jpg
66	14	UdwYL41DH2c	Avoid teacher burnout with these 5 tips for self-care and stress management. Stay positive, find adventure, and prioritize your ...	https://i.ytimg.com/vi/UdwYL41DH2c/hqdefault.jpg
67	14	_Nw14J61BVQ	Teacher burnout is a serious issue impacting educators across the country. In this video, leaders of K-12 schools in California ...	https://i.ytimg.com/vi/_Nw14J61BVQ/hqdefault.jpg
68	14	dbT9KtYOr-8	The complex nature of being a classroom teacher can lead to both emotional and physical fatigue. Burnout is a long term ...	https://i.ytimg.com/vi/dbT9KtYOr-8/hqdefault.jpg
69	15	rlArEdgnYKA	MAKE YOUR OWN WHITEBOARD ANIMATIONS. CLICK THE LINK! http://tidd.ly/69da8562 . This is an affiliate link.	https://i.ytimg.com/vi/rlArEdgnYKA/hqdefault.jpg
70	15	TbPyeNO3_Iw	A former Polk County special education teacher has resigned last week, saying she's had enough of students taking test after test.	https://i.ytimg.com/vi/TbPyeNO3_Iw/hqdefault.jpg
71	15	J6lyURyVz7k	American students face a ridiculous amount of testing. John Oliver explains how standardized tests impact school funding, the ...	https://i.ytimg.com/vi/J6lyURyVz7k/hqdefault.jpg
72	15	_e8mA7zTEPQ	Modern education is becoming more dynamic and engaging. Evaluation of students can be tricky, standardization or performance ...	https://i.ytimg.com/vi/_e8mA7zTEPQ/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.articles_id_seq', 263, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 7, true);


--
-- Name: fav_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fav_videos_id_seq', 8, true);


--
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favourites_id_seq', 1, false);


--
-- Name: hidden_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hidden_articles_id_seq', 9, true);


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

SELECT pg_catalog.setval('public.videos_id_seq', 72, true);


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

