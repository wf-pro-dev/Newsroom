--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.17 (Ubuntu 14.17-0ubuntu0.22.04.1)

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
-- Name: entity_type; Type: TYPE; Schema: public; Owner: will
--

CREATE TYPE public.entity_type AS ENUM (
    'article',
    'video'
);


ALTER TYPE public.entity_type OWNER TO will;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.articles (
    id integer NOT NULL,
    score double precision,
    question_id integer NOT NULL,
    api_source character varying(50),
    title character varying(255) NOT NULL,
    description text,
    content text,
    url character varying(500),
    "urlToImage" character varying(500),
    "publishedAt" timestamp without time zone
);


ALTER TABLE public.articles OWNER TO will;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_id_seq OWNER TO will;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: fav_articles; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.fav_articles (
    id integer NOT NULL,
    score double precision,
    question_id integer NOT NULL,
    obj_id integer,
    api_source character varying(50),
    title character varying(255) NOT NULL,
    description text,
    content text,
    url character varying(500),
    "urlToImage" character varying(500),
    "publishedAt" timestamp without time zone
);


ALTER TABLE public.fav_articles OWNER TO will;

--
-- Name: fav_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.fav_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fav_articles_id_seq OWNER TO will;

--
-- Name: fav_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.fav_articles_id_seq OWNED BY public.fav_articles.id;


--
-- Name: fav_videos; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.fav_videos (
    id integer NOT NULL,
    obj_id integer NOT NULL,
    question_id integer NOT NULL,
    video_id character varying(255) NOT NULL,
    description character varying(255),
    thumbnail character varying(255)
);


ALTER TABLE public.fav_videos OWNER TO will;

--
-- Name: fav_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.fav_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fav_videos_id_seq OWNER TO will;

--
-- Name: fav_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.fav_videos_id_seq OWNED BY public.fav_videos.id;


--
-- Name: favourites; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.favourites (
    id integer NOT NULL,
    entity_id integer NOT NULL,
    entity_type public.entity_type NOT NULL
);


ALTER TABLE public.favourites OWNER TO will;

--
-- Name: favourites_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.favourites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favourites_id_seq OWNER TO will;

--
-- Name: favourites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.favourites_id_seq OWNED BY public.favourites.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    topic_id integer,
    text character varying(255) NOT NULL,
    keywords character varying(255) NOT NULL
);


ALTER TABLE public.questions OWNER TO will;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO will;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.topics (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);


ALTER TABLE public.topics OWNER TO will;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topics_id_seq OWNER TO will;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(120) NOT NULL,
    email character varying(120) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp without time zone,
    is_active boolean
);


ALTER TABLE public.users OWNER TO will;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO will;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: will
--

CREATE TABLE public.videos (
    id integer NOT NULL,
    question_id integer NOT NULL,
    video_id character varying(255) NOT NULL,
    description character varying(255),
    thumbnail character varying(255)
);


ALTER TABLE public.videos OWNER TO will;

--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: will
--

CREATE SEQUENCE public.videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videos_id_seq OWNER TO will;

--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: will
--

ALTER SEQUENCE public.videos_id_seq OWNED BY public.videos.id;


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: fav_articles id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.fav_articles ALTER COLUMN id SET DEFAULT nextval('public.fav_articles_id_seq'::regclass);


--
-- Name: fav_videos id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.fav_videos ALTER COLUMN id SET DEFAULT nextval('public.fav_videos_id_seq'::regclass);


--
-- Name: favourites id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.favourites ALTER COLUMN id SET DEFAULT nextval('public.favourites_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.videos ALTER COLUMN id SET DEFAULT nextval('public.videos_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.articles (id, score, question_id, api_source, title, description, content, url, "urlToImage", "publishedAt") FROM stdin;
4	0.3	2	NewsDATA	P448 LAUNCHES ITS NEXT INVASIVE SKINS CAPSULE WITH THE TA'APE FISH UTILIZING INNOVATIVE CHROMIUM-FREE TANNING PROCESS	Partnering with Nonprofit Conservation International, P448 Continues Its Mission to Educate & Bring Awareness to the Use of Invasive Fish Skins as an Emerging Trim Material in Sustainable Footwear Manufacturing "We see using the skins of invasive species in our footwear as an opportunity to help prevent future environmental degradation, while repurposing existing resources and replacing other materials in the process," said Wayne Kulkin, CEO of P448.NEW YORK, April 14, 2025 /PRNewswire/ -- For the Spring 2025 season, P448 Project Sustainability launches its 3rd invasive fish leather capsule with the bluestripe snapper, known locally in Hawaiʻi by its Tahitian name, ta'ape. The launch follows previous P448 invasive fish leather capsules, which included the lionfish and carp. This is a dedicated capsule to bring awareness to the issues posed by ta'ape to Hawaii's fragile ecosystems and highlights a new alternative to the leather category with invasive fish. Easily identified by its electric-blue stripes and lemon-yellow skin, the bluestripe snapper, or ta'ape, is a striking tropical fish. Ta'ape were first introduced to the eastern shores of the island of Oʻahu, Hawaiʻi seven decades ago from the South Pacific with the original intent to provide additional fishing opportunities and food sources for Hawaiʻi. Ta'ape, which naturally school in the hundreds and even thousands, quickly swelled to an unwelcomed spread across the 1,500-mile Hawaiian archipelago ranging from shallow reefs to ocean depths of over 6400 feet. As an invasive species, the ta'ape are competing with native fish for food and habitat, while also causing losses for the local fishing industry by invading and even taking over local fishing spots pushing native fish out of their homes.Through its partnership with Conservation International—a leading environmental non-profit focused on science, policy, and collaboration with businesses, governments, and communities—P448 has sourced 2,000 ta'ape skins from the island of Moloka'i for this capsule collection. This collaboration builds on the Ta'ape Project, launched in 2020 by Conservation International Hawai'i in partnership with local nonprofit Chef Hui, to encourage consumption of the invasive reef fish, supporting the local economy, improving island food security and reducing the species' environmental impact. CI's partnership with P448 is the first outside of the food industry connecting local fishers to the fashion industry to utilize the skins of the caught ta'ape fish for footwear manufacturing. Thus, creating a new market for ta'ape skins while offering a sustainable business opportunity for the community."Throughout the globe, climate change is expected to exacerbate the impacts of invasive species. We need to be developing solutions to address this challenge while meeting other growing needs such as food security and community resilience. We are honored to be a part of this innovative collaboration because it does exactly that. By removing ta'ape, the initiative benefits Hawaii's native marine life, feeds communities, and supports the local economy," said Matt Ramsey, Senior Director, Conservation International's Hawai'i program. "Additionally with the lack of government-led programs to tackle the challenge of ta'ape, this initiative directly addresses these gaps."Moloka'i, where the fish were sourced by net for this capsule, is one of the most rural of Hawaii's major islands with a population of 7,400 nestled between O'ahu and Maui. The island remains untouched by mass tourism. In fact, there are no traffic lights on the island and no buildings can be constructed taller than a palm tree. In essence, it is considered the last real Hawai'i in which the land is chief and man is servant. With ...Full story available on Benzinga.com	ONLY AVAILABLE IN PAID PLANS	https://www.benzinga.com/pressreleases/25/04/n44788025/p448-launches-its-next-invasive-skins-capsule-with-the-taape-fish-utilizing-innovative-chromium-fr	https://mma.prnewswire.com/media/2341850/P448_Logo.jpg	2025-04-14 13:01:00
5	0.1	2	NewsDATA	Trump's NOAA firings raise doubts for Pacific Northwest fisheries	Owen Liu was hired to help solve a mystery. Fishers had been plying the Pacific Ocean in search of hake, a species making up one of the most lucrative fisheries on the West Coast. But the	ONLY AVAILABLE IN PAID PLANS	http://www.chronline.com/stories/trumps-noaa-firings-raise-doubts-for-pacific-northwest-fisheries,378685	https://cdn3.creativecirclemedia.com/lafromboise/large/20240930-181531-876-news.241001.WeekendWildart.os-4.jpg	2025-04-14 15:07:48
6	0	2	NewsAPI	The Trump administration’s climate policies jeopardize research in disaster-prone Puerto Rico	As one of the regions most affected by the global climate crisis, local scientists are struggling with canceled research grants and funding cuts from federal agencies.	This story was originally published by el Centro de Periodismo Investigativo.\r\nProfessor Maritza Barreto Orta had planned to complete two federal funding applications crucial for her research on coas… [+24758 chars]	http://grist.org/extreme-weather/the-trump-administrations-climate-policies-jeopardize-research-in-disaster-prone-puerto-rico/	https://grist.org/wp-content/uploads/2025/03/Portada-CPI-Fiona-Salinas.jpg?quality=75&strip=all	2025-03-23 13:00:00
7	0	2	NewsAPI	Weekly Climate and Energy News Roundup #635	Quote of the Week: “Beware the Ides of March” — Soothsayer to Julius Caesar by William Shakespeare.	Quote of the Week:Beware the Ides of March\r\n Soothsayer to Julius Caesar by William Shakespeare.\r\nNumber of the Week: Tripled in 60 years\r\nTHIS WEEK:\r\nBy Ken Haapala, President, Science and Environme… [+66587 chars]	https://wattsupwiththat.com/2025/03/17/weekly-climate-and-energy-news-roundup-635/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/03/charlesrotter_a_sharp_scenic_photo_of_glacier_bay_midjouney.webp?fit=1024%2C512&ssl=1	2025-03-17 09:00:00
8	0	2	NewsAPI	Skeptical Science New Research for Week #12 2025	Open access notables\nThe severe 2020 coral bleaching event in the tropical Atlantic linked to marine heatwaves, Rodrigues et al., Communications Earth & Environment:\n\nMarine heatwaves can amplify the vulnerabilities of regional marine ecosystems and jeopardis…	Posted on 20 March 2025 by Doug Bostrom, Marc Kodack\r\nOpen access notables\r\nThe severe 2020 coral bleaching event in the tropical Atlantic linked to marine heatwaves, Rodrigues et al., Communications… [+41403 chars]	https://skepticalscience.com/new_research_2025_12.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-03-20 06:36:20
9	0	2	NewsAPI	Weekly Climate and Energy News Roundup #638	Quote of the Week: “Prediction is very difficult, especially if it's about the future!” —Niels Bohr, Nobel laureate in Physics and father of the atomic model. [H/t Richard Lindzen]	Quote of the Week:Prediction is very difficult, especially if it’s about the future! \r\nNiels Bohr, Nobel laureate in Physics and father of the atomic model. [H/t Richard Lindzen]\r\nNumber of the Week:… [+73228 chars]	https://wattsupwiththat.com/2025/04/07/weekly-climate-and-energy-news-roundup-638/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/04/charlesrotter_gorgeous_sunset_in_glacier_national_park_amidjourney.webp?fit=1024%2C512&ssl=1	2025-04-07 09:00:00
10	0	2	NewsAPI	‘Coexistence, My Ass!’ Wins Top Award At Thessaloniki Int’l Documentary Festival; ‘Free Leonard Peltier’ Earns Three Awards (Full Winners List)	Coexistence, My Ass!, a film about Israeli comedian Noam Shuster-Eliassi who dares to advocate for peaceful coexistence between Israelis and Palestinians, won the Golden Alexander Sunday at the Thessaloniki International Documentary Festival, TiDF’s top award…	Coexistence, My Ass!, a film about Israeli comedian Noam Shuster-Eliassi who dares to advocate for peaceful coexistence between Israelis and Palestinians, won the Golden Alexander Sunday at the Thess… [+46382 chars]	http://deadline.com/2025/03/2025-thessaloniki-international-documentary-festival-awards-1236327780/	https://deadline.com/wp-content/uploads/2025/01/Still-2-COEXISTENCE-MY-ASS_Noam-Shuster-Eliassi-on-stage.jpg?w=1024	2025-03-16 14:59:58
11	0	2	NewsDATA	Humanity depends on the ocean — Here is what we need to prioritize for immediate ocean science research	This article was originally published on The Conversation, an independent and nonprofit source of news, analysis and commentary from academic experts. Disclosure information is available on the original site.	ONLY AVAILABLE IN PAID PLANS	https://www.burnabynow.com/science-news/humanity-depends-on-the-ocean-here-is-what-we-need-to-prioritize-for-immediate-ocean-science-research-10519577	https://www.burnabynow.com/images/blank.gif	2025-04-14 15:11:17
12	0	2	NewsDATA	Kedrion Biopharma closes 2024 with a growth of +10% and unveils its new identity	The company's new image is built on the power of rare connections CASTELVECCHIO PASCOLI, Italy, April 14, 2025 /PRNewswire/ -- Kedrion Biopharma, a biopharmaceutical company that collects and fractionates plasma, today presents its new identity and shares the financial results of 2024....	ONLY AVAILABLE IN PAID PLANS	https://www.prnewswire.co.uk/news-releases/kedrion-biopharma-closes-2024-with-a-growth-of-10-and-unveils-its-new-identity-302427671.html	https://mma.prnewswire.com/media/2662888/Kedrion_Logo.jpg?p=publish	2025-04-14 13:50:00
13	0	2	NewsDATA	Kedrion Biopharma closes 2024 with a growth of +10% and unveils its new identity	The company's new image is built on the power of rare connections CASTELVECCHIO PASCOLI, Italy, April 14, 2025 /PRNewswire/ -- Kedrion Biopharma, a biopharmaceutical company that collects and fractionates plasma, today presents its new identity and shares the financial results of 2024....	ONLY AVAILABLE IN PAID PLANS	https://www.prnewswire.com/news-releases/kedrion-biopharma-closes-2024-with-a-growth-of-10-and-unveils-its-new-identity-302427669.html	https://mma.prnewswire.com/media/2662888/5263836/Kedrion_Logo.jpg?p=original	2025-04-14 13:46:00
14	0	2	NewsDATA	Phase Two of Tech4Nature Jaguar Protection Project Launched in Mexico	MERIDA, Mexico, April 14, 2025 /PRNewswire/ -- At the recent 2025 Tech4Nature Summit, Huawei, International Union of Conservation for Nature (IUCN), and local partners launched Phase Two of the Mexico Tech4Nature project, which aims to strengthen the protection of jaguars in Dzilam de Bravo State Re...	ONLY AVAILABLE IN PAID PLANS	https://www.itbiznews.com/news/articleView.html?idxno=165657	https://cdn.itbiznews.com/news/photo/202504/165657_166764_4510.jpg	2025-04-14 13:16:08
15	0	2	NewsDATA	P448 LAUNCHES ITS NEXT INVASIVE SKINS CAPSULE WITH THE TA'APE FISH UTILIZING INNOVATIVE CHROMIUM-FREE TANNING PROCESS	Partnering with Nonprofit Conservation International, P448 Continues Its Mission to Educate & Bring Awareness to the Use of Invasive Fish Skins as an Emerging Trim Material in Sustainable Footwear Manufacturing "We see using the skins of invasive species in our footwear as an opportunity...	ONLY AVAILABLE IN PAID PLANS	https://www.prnewswire.com/news-releases/p448-launches-its-next-invasive-skins-capsule-with-the-taape-fish-utilizing-innovative-chromium-free-tanning-process-302425173.html	https://mma.prnewswire.com/media/2341850/P448_Logo.jpg?p=original	2025-04-14 13:01:00
16	0.378	3	NewsDATA	Saving traditional varieties of seeds	At a time when extreme weather events are threatening food production, we are sidelining the very varieties that can withstand droughts, floods, and replenish depleted soils	ONLY AVAILABLE IN PAID PLANS	https://www.thehindu.com/opinion/op-ed/saving-traditional-varieties-of-seeds/article69446064.ece	https://th-i.thgim.com/public/latest-news/1ak5di/article69447312.ece/alternates/LANDSCAPE_1200/MSSRF%E2%80%99s%20Tribal%20Agrobiodiversity%20Centre%20in%20Jeypore%20Odisha.jpg	2025-04-13 18:45:00
17	0.089	3	NewsAPI	'Their loss diminishes us all': Scientists emphasize how Trump's mass NOAA layoffs endanger the world	"From our perspective down in the trenches actually working for the government, it feels like the people up top just have no clue about anything."	For decades, the U.S. National Oceanic and Atmospheric Administration (NOAA) has been the beating heart of weather forecasts that keep our society safe.\r\nIts employees regularly collect weather data … [+16656 chars]	https://www.space.com/the-universe/earth/their-loss-diminishes-us-all-scientists-emphasize-how-trumps-mass-noaa-layoffs-endanger-the-world	https://cdn.mos.cms.futurecdn.net/xAV5ZavxejZKZKojBWJsaD-1200-80.jpg	2025-03-14 09:00:00
18	0.089	3	NewsAPI	Nature Is Medicine: A Doctor’s Call To Rethink Health In The Age Of Climate Change	After decades in medicine, I’ve come to see something fundamental: the health of our planet and the health of our people are inseparable.	What if the most powerful medicine we have isnt found in a pill or a procedurebut in the soil beneath our feet, the air we breathe, and the trees outside our window?\r\nAfter decades in medicineas a he… [+6944 chars]	https://www.forbes.com/sites/billfrist/2025/04/07/nature-is-medicine-a-doctors-call-to-rethink-health-in-the-age-of-climate-change/	https://imageio.forbes.com/specials-images/imageserve/67f42512d71c7d033a1eed0f/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-07 20:22:21
19	0.089	3	NewsAPI	‘Apocalyptic’: Experts warn Trump plan would be ‘science demolition derby’	President Donald Trump’s proposed 2026 budget reportedly seeks to effectively dismantle the scientific research arm of the National Oceanic and Atmospheric Administration, shut down critical weather laboratories, and slash the agency’s budget by more than 25 …	President Donald Trumps proposed 2026 budget reportedly seeks to effectively dismantle the scientific research arm of the National Oceanic and Atmospheric Administration, shut down critical weather l… [+3952 chars]	https://www.rawstory.com/trump-noaa-2671755614/	https://www.rawstory.com/media-library/u-s-president-donald-trump-looks-on-while-on-board-air-force-one-on-the-way-to-palm-beach-international-airport-west-palm-beac.jpg?id=59886487&width=1200&height=600&coordinates=0%2C459%2C0%2C460	2025-04-12 02:32:21
20	0.089	3	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #15	A listing of 36 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 6, 2025 thru Sat, April 12, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. …	Posted on 13 April 2025 by BaerbelW, Doug Bostrom, John Hartz\r\nA listing of 36 news and opinion articles we found interesting and shared on social media during the past week: Sun, April 6, 2025 thru … [+7717 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_15.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-04-13 08:05:44
21	0.089	3	NewsDATA	Climate change doesn't care if Trump believes in it	The populist right might be hoping to cancel climate change by vilifying words and cutting funding. But the planet is unmoved by narrative battles and culture wars, as we found out this week from some of the world’s leading climate scientists.	ONLY AVAILABLE IN PAID PLANS	https://www.nationalobserver.com/2025/04/14/opinion/climate-change-global-economy-trump	https://www.nationalobserver.com/sites/default/files/styles/scale_width_lg_1x/public/img/2025/04/11/antarctic_nsidc_20250301_lrg.jpg?itok=eJlZaP7K	2025-04-14 09:09:06
22	0.089	3	NewsDATA	Coastal economies rely on NOAA, from Maine to Florida, Texas and Alaska – even if they don’t realize it	NOAA’s work has kept fisheries from collapsing, helped coastal ecosystems survive extreme heat and battled invasive species, among many other tasks essential to coastal economies.	ONLY AVAILABLE IN PAID PLANS	https://ca.news.yahoo.com/coastal-economies-rely-noaa-maine-003947865.html	https://s.yimg.com/ny/api/res/1.2/9ZaAJtM7AYQixOSR_0Fj5w--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03ODg-/https://media.zenfs.com/en/the_conversation_us_articles_815/e49afecf5ac6581bd8d66565741627a4	2025-04-14 00:39:47
23	0	3	NewsAPI	These are the impacts some scientists fear most from EPA deregulation	Several of the environmental benefits Americans experience today -- clean air, clean water, clean rain -- could soon be in jeopardy from EPA deregulation efforts.	Environmental lawyers would argue that part of the American dream is the right to live in a clean environment a freedom from worry that the air you breathe, the food you eat and the water you drink a… [+7156 chars]	https://abcnews.go.com/US/impacts-scientists-fear-epa-deregulation/story?id=119983525	https://i.abcnewsfe.com/a/d44fd97e-6f74-45bf-91fd-6893fd111f09/EPA-ap-er-250324_1742851431724_hpMain_16x9.jpg?w=1600	2025-03-26 09:32:24
24	0	3	NewsAPI	Why Trump Just Axed a Major Climate Program	The dismemberment of the U.S. Global Change Research Program was outlined in Project 2025 as a way to elevate the “benefits” of climate change when fighting regulations in court	CLIMATEWIRE | The Trump administration is dismantling a 35-year-old effort to track global climate change that was used to shape regulations and policies across the government.\r\nFederal employees at … [+5274 chars]	https://subscriber.politicopro.com/article/eenews/2025/04/10/why-trump-axed-the-global-change-research-program-00282731	https://static.scientificamerican.com/dam/m/32cf19a87acdbd34/original/Donald-Trump-Visits-Areas-Affected-By-Hurricane-Helene.jpg?m=1744312287.368&w=1200	2025-04-10 19:30:00
25	0	3	NewsAPI	What a Microscopic Creature Taught Me About Parenting	A single-celled organism helped shift my perspective on climate change—and on my child’s future.	One evening earlier this year, I came downstairs after putting our 4-year-old daughter to bed to find my husband looking at a series of maps of the United States, each showing possible futures given … [+9523 chars]	https://www.theatlantic.com/family/archive/2025/04/mother-creature-kin-parenting-microscope-foram/682316/	https://cdn.theatlantic.com/thumbor/X33-h36xgQePyxTNUnz1zsjDOVs=/0x1577:2157x2700/1200x625/media/img/mt/2025/04/Foraminifera/original.jpg	2025-04-06 12:00:00
26	0	3	NewsAPI	See photos of Camp Century, a secret US military base built beneath Greenland's ice sheet	Camp Century was built to store nukes beneath Greenland's ice. See photos of the underground, "Star Wars"-like site.	Engineers collected ice cores for testing inside the trenches of Camp Century.ERDC Cold Regions Research and Engineering Laboratory\r\n<ul><li>The US has had a military presence in Greenland since Worl… [+9699 chars]	https://www.businessinsider.com/camp-century-photos-secret-underground-us-military-base-greenland-2025-2	https://i.insider.com/67aa798eeb4be2fff9a42f90?width=1140&format=jpeg	2025-03-26 23:14:01
27	0	3	NewsAPI	NIH Ends Future Funding to Study the Health Effects of Climate Change	by Annie Waldman and Sharon Lerner \n \n\n \n \n ProPublica is a nonprofit newsroom that investigates abuses of power. Sign up to receive our biggest stories as soon as they’re published.\n\n \n\n \n\n \n \n\n\n\n \nThe National Institutes of Health will no longer be funding …	ProPublica is a nonprofit newsroom that investigates abuses of power. Sign up to receive our biggest stories as soon as theyre published.\r\nThe National Institutes of Health will no longer be funding … [+7241 chars]	https://www.propublica.org/article/nih-funding-climate-change-public-health	https://img.assets-d.propublica.org/v5/images/GettyImages-1740048611_maxWidth_3000_maxHeight_3000_ppi_72_quality_95_embedColorProfile_true2mb.jpg?crop=focalpoint&fit=crop&fp-x=0.5&fp-y=0.5&h=630&imgixProfile=propublicaAssetsV5&q=90&w=1200&s=e3aa0cbc9d2160904553180dfb85ac08	2025-03-24 20:15:00
28	0	3	NewsAPI	The Trump administration’s climate policies jeopardize research in disaster-prone Puerto Rico	As one of the regions most affected by the global climate crisis, local scientists are struggling with canceled research grants and funding cuts from federal agencies.	This story was originally published by el Centro de Periodismo Investigativo.\r\nProfessor Maritza Barreto Orta had planned to complete two federal funding applications crucial for her research on coas… [+24758 chars]	http://grist.org/extreme-weather/the-trump-administrations-climate-policies-jeopardize-research-in-disaster-prone-puerto-rico/	https://grist.org/wp-content/uploads/2025/03/Portada-CPI-Fiona-Salinas.jpg?quality=75&strip=all	2025-03-23 13:00:00
29	0	3	NewsAPI	NIH ends future funding to study health effects of climate change	by Annie Waldman and Sharon LernerProPublica is a Pulitzer Prize-winning investigative newsroom. Sign up for The Big Story newsletter to receive stories like this one in your inbox.The National Institutes of Health will no longer be funding work on the health…	ProPublica is a Pulitzer Prize-winning investigative newsroom. Sign up for The Big Story newsletter to receive stories like this one in your inbox.The National Institutes of Health will no longer be … [+6273 chars]	https://www.rawstory.com/nih-2671397702/	https://www.rawstory.com/media-library/file-photo-the-patient-s-entrance-at-the-national-institutes-of-health-is-shown-in-bethesda-maryland-october-16-2014-reuters.jpg?id=58413328&width=1200&height=600&coordinates=0%2C189%2C0%2C189	2025-03-25 01:25:40
30	0	3	NewsAPI	The National Geographic 33 Spotlights The Visionaries Shaping Tomorrow	Discover how National Geographic 33 honors changemakers like Dr. Shu Yang, blending technology, sustainability, and innovation to shape a better future for our planet.	Celebrating the bold visionaries reshaping our worldNational Geographic 33 honors 33 changemakers ... More driving innovation, sustainability, and hope for a better future.\r\nNational Geographic\r\nFor … [+6390 chars]	https://www.forbes.com/sites/tonybradley/2025/03/21/the-national-geographic-33-spotlights-the-visionaries-shaping-tomorrow/	https://imageio.forbes.com/specials-images/imageserve/67dd6a648d0c40103d667b2d/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-03-21 13:38:13
31	0	3	NewsAPI	Telling the Bees	Bees have long been witness to human grief, carrying messages between the living and the dead. Finding solace in the company of bees, Emily Polk opens to the widening circles of loss around her and an enduring spirit of survival.	Listen to this StoryNarrated by Emily Polk\r\nContributor BiosEmily Polk lives and writes on a small island east of San Francisco and teaches environmental writing at Stanford University. Her writing a… [+26348 chars]	https://emergencemagazine.org/essay/telling-the-bees/	https://emergencemagazine.org/app/uploads/2025/02/Telling_the_Bees_SEO.jpg	2025-04-09 19:49:37
32	0	3	NewsAPI	Climate Change Triggers More Extreme Weather – From Deluges to Drought	Around the globe, rising temperatures stoked by climate change are increasing the odds of both severe drought and heavier precipitation that wreak havoc on people and the environment. Rainfall can disappear for years only to return with a vengeance, as …	Around the globe, rising temperatures stoked by climate change are increasing the odds of both severe drought and heavier precipitation that wreak havoc on people and the environment.\r\nRainfall can d… [+2954 chars]	https://www.insurancejournal.com/news/international/2025/03/27/817284.htm	https://www.insurancejournal.com/app/uploads/2025/03/drought-hits-of-amazon-river-in-colombia-AP-scaled.jpg	2025-03-27 05:15:45
33	0	3	NewsAPI	How an Israeli-US Startup Wants to Make Geoengineering Profitable	Forget contrails. Here's a geoengineering initiative that should give cause for pause.	Yves here. For those living in Asia and other parts of the world where big cities generally = bad to dangerously bad air, the idea of putting more stuff in the atmosphere because global warming sound… [+20135 chars]	https://www.nakedcapitalism.com/2025/03/how-an-israeli-us-startup-wants-to-make-geoengineering-profitable.html	https://www.nakedcapitalism.com/wp-content/uploads/2025/03/00-geoengineering-1.jpg	2025-03-20 09:55:30
34	0	3	NewsAPI	The Hill Misleads, Trump’s Energy Policy Won’t Damage the Climate and Will Advance American Interests	Almost every claim made in Becker’s article in The Hill is provably wrong. The post is long on hyperbole and misinformation, but short on facts and data. Real world weather data shows no increase in extreme weather, incidences of weather disasters, or weather…	From ClimateREALISM\r\nBy Heartland Institute\r\nA recent post by The Hill, Disaster as Trumps energy policy totally disregards climate change, claims that President Donald Trump is implementing irration… [+6661 chars]	https://wattsupwiththat.com/2025/04/06/the-hill-misleads-trumps-energy-policy-wont-damage-the-climate-and-will-advance-american-interests/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/04/ChatGPT-Image-ghibli-trump.webp?fit=1024%2C512&ssl=1	2025-04-06 21:00:00
35	0	3	NewsAPI	Study: Economic Uncertainty Diverting Executive Attention From Sustainability	It’s the economy stupid, and it seems that a lot of executives are using their brain power on their current worries rather than on the climate concerns of tomorrow—despite those concerns materializing in the here and now. Executives are focused …	It’s the economy stupid, and it seems that a lot of executives are using their brain power on their current worries rather than on the climate concerns of tomorrowdespite those concerns materializing… [+5016 chars]	https://www.insurancejournal.com/news/national/2025/03/28/817499.htm	https://www.insurancejournal.com/app/uploads/2025/03/climate-risk-ranking-chart-01.webp	2025-03-28 11:31:40
36	0.185	4	NewsAPI	Use AI, grow local cyberdefence industry to ward off cyberthreats, experts urge	KUALA LUMPUR: The country's cyber defence system must be strengthened in pace with rapidly evolving technology amid growing threats from radical extremist groups that use cyber attacks to generate income. Read full story	KUALA LUMPUR: The country's cyber defence system must be strengthened in pace with rapidly evolving technology amid growing threats from radical extremist groups that use cyber attacks to generate in… [+2836 chars]	https://www.thestar.com.my/news/nation/2025/03/27/use-ai-grow-local-cyberdefence-industry-to-ward-off-cyberthreats-experts-urge	https://apicms.thestar.com.my/uploads/images/2025/03/27/3236579.jpeg	2025-03-27 02:22:00
37	0	4	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/05/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-05 10:33:12
38	0	4	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/11/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-11 10:33:12
39	0	4	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/03/21/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-03-21 10:33:12
40	0	4	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/03/29/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-03-29 10:33:12
41	0	4	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/03/14/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-03-14 10:33:12
42	0	5	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/05/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-05 10:33:12
65	0	10	NewsDATA	Understanding Trump’s America	Why is the US President Donald Trump waging a trade war against its closest neighbors and allies, Mexico and Canada? Why is the United States abandoning Ukraine and its security commitments to Europe? Why is he befriending Russia’s authoritarian, Vladimir Putin, and sacrificing Europe, which shares democratic values with the United States? Why does Trump [...]	ONLY AVAILABLE IN PAID PLANS	https://www.bworldonline.com/opinion/2025/04/14/665564/understanding-trumps-america/	https://www.bworldonline.com/wp-content/uploads/2025/04/Illustration-Trump-300x300.jpg	2025-04-13 16:04:42
43	0	5	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/04/11/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-04-11 10:33:12
44	0	5	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/03/21/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-03-21 10:33:12
45	0	5	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/03/29/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-03-29 10:33:12
46	0	5	NewsAPI	Dave Vellante’s Breaking Analysis: The complete collection	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLE’s theCUBE with spending data from Enterprise Technology Research. Branded as theCUBE Insights, Powered by ETR, the program is our opportunity to share independent, unfiltere…	Breaking Analysis is a weekly editorial program combining knowledge from SiliconANGLEs theCUBE with spending data from Enterprise Technology Research.\r\nBranded as theCUBE Insights, Powered by ETR, th… [+182839 chars]	https://siliconangle.com/2025/03/14/dave-vellantes-breaking-analysis-complete-collection/	https://d15shllkswkct0.cloudfront.net/wp-content/blogs.dir/1/files/2023/09/dave-breaking-analysis.png	2025-03-14 10:33:12
47	0	5	NewsAPI	AI #109: Google Fails Marketing Forever	What if they released the new best LLM, and almost no one noticed?	What if they released the new best LLM, and almost no one noticed?\r\nGoogle seems to have pulled that off this week with Gemini 2.5 Pro. \r\nIts a great model, sir. I have a ton of reactions, and its 90… [+60065 chars]	https://thezvi.substack.com/p/ai-109-google-fails-marketing-forever	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F45bea6de-3520-41b0-907e-4b76d6600fbd_1024x1024.jpeg	2025-03-27 14:51:36
48	0	5	NewsDATA	News – Quantum Computing Report	Recent news items published within the last 6 months on quantum computing developments are listed below. Click on the hyperlinked item to go to the press release or news article for more details. For older news items published in 2024 click here, for 2023 click here, for 2022 click here, for 2021 click here, for 2020 click here, for 2019 [...]	ONLY AVAILABLE IN PAID PLANS	https://zephyrnet.com/news-quantum-computing-report-2/	https://zephyrnet.com/wp-content/uploads/2022/11/Logo.png	2025-04-13 14:36:00
49	0.16	6	NewsAPI	Bringing manufacturing back to America, one fab lab at a time	Hundreds of fab labs modeled after the original one at MIT have sprouted up across the country, helping communities make their own products.	Reindustrializing America will require action from not only businesses but also a new wave of people that have the skills, experience, and drive to make things. While many efforts in this area have f… [+7896 chars]	https://news.mit.edu/2025/bringing-manufacturing-back-america-fab-labs-0413	https://news.mit.edu/sites/default/files/images/202504/MIT_FabLab-01-Press.jpg	2025-04-13 04:00:00
50	0.08	6	NewsAPI	AI #109: Google Fails Marketing Forever	What if they released the new best LLM, and almost no one noticed?	What if they released the new best LLM, and almost no one noticed?\r\nGoogle seems to have pulled that off this week with Gemini 2.5 Pro. \r\nIts a great model, sir. I have a ton of reactions, and its 90… [+60065 chars]	https://thezvi.substack.com/p/ai-109-google-fails-marketing-forever	https://substackcdn.com/image/fetch/w_1200,h_600,c_fill,f_jpg,q_auto:good,fl_progressive:steep,g_auto/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F45bea6de-3520-41b0-907e-4b76d6600fbd_1024x1024.jpeg	2025-03-27 14:51:36
51	0	6	NewsAPI	America and Its Universities Need a New Social Contract	$50 for STEM, 5¢ for citizenship—that's how America apportions its education dollars. Our beleaguered universities must redress the balance—helping the country and themselves.	The life of the mind may be a deeply personal thing, but as embodied in colleges and universities, it is also a very public thing—and the two go hand in hand. Since taking office, the Trump administr… [+23664 chars]	https://www.theatlantic.com/ideas/archive/2025/04/stem-academia-universities-citizenship-civics/682384/	https://cdn.theatlantic.com/thumbor/Af9BfihrzTmco--WF02lZAjCxEo=/0x0:3994x2080/1200x625/media/img/mt/2025/04/WeTheSweater/original.png	2025-04-13 12:30:00
52	0	6	NewsAPI	California College Professors Divided on AI’s Role in Education	Some educators see AI as a tool to enhance learning efficiency and personalize education, while others express concerns about potential overreliance on technology and its impact on critical thinking skills.	“Be very careful with personal information,” Valier said. “Especially if you have sources, or people that you want to protect, be very careful putting names and information that is sensitive.”\r\nValie… [+7830 chars]	https://www.kqed.org/news/12031556/california-college-professors-divided-on-ais-role-in-education	https://cdn.kqed.org/wp-content/uploads/sites/10/2025/03/1-COVER-PHOTO-CG-@-CSULB-1020x680.jpeg	2025-03-16 21:30:49
66	0.433	11	NewsDATA	Changing the economic world order	“If Trump has his way, the United States will lose its global influence, standards of living of Americans will decrease, including for those who supported him, and the world will not be safer, more secure or more prosperous.” This is the considered view of Nobel Prize winner Joseph E. Stiglitz as expressed in his latest book ‘Globalisation and its Discontents Revisited: Anti-globalisation in the Era of Trump’.Looking at the latest developments, Mr Stiglitz’s views are supported by observers who say that two top foreign policy priorities — ending the wars in Gaza and Ukraine — both appear mired in the kind of messy details and conflicting agendas that often obstruct lasting peace.Mr Stiglitz hopes that the United States and the world will emerge from this episode with a greater resolve to create fairer and better globalisation, as he has long advocated. Protests citing grievances against Trump’s agenda, ranging from social to economic issues, were held in all 50 US states on April 5.In the early 1970s, it may be recalled, the emerging strategy for people-centric economic development was replaced by the now-faltering West-led financial globalisation, with most economies finally hit by the balance of payment crises and widening disparity in incomes among them and within nations. As Trump’s protectionist policies shake global order, experts warn of deepening inequality, economic instability, and diminishing US global influenceTo end the global disorder, the time has come for public policies to shift towards evolving growth and development strategies for people’s welfare, with the international community extending mutual cooperation for their step-by-step implementation. It is also clear from the US’s tariff policies that US-driven financial globalisation has also become counterproductive over time in many ways for the American economy.When elite wealth outpaces economic growth and capital flows into unproductive sectors, it deepens inequality and stifles real progress, says analyst Ali Asad Sabir of the Lahore University of Management Sciences.That is evident from the narrative in the book titled ‘The Lords of Easy Money: How the Federal Reserve Broke the American Economy’, by Christopher Leonard, business journalist of The New York Times.In many important ways, he writes that the financial crash of 2008 never ended. It was a long crash that crippled the economy for years. The dollar, for decades a safe haven, fell about 1.7pc on April 3, its highest daily drop since November 2022, after President Trump imposed tariffs on importsThe problems that caused it were almost unsolved. And the financial crash was accompanied by a long crash in the strength of the American democratic institutions.When America relied on the Federal Reserve to address its economic problems, it relied on a deeply flawed tool. All the Fed’s money only widened the distance between winners and losers and laid the foundation for instability. “The value of workers had been diminished, but the value of other commodities was on the rise. The Fed was making sure of it,” observes Mr Leonard.Trump has also opened up so many fronts, confronting foes and friends alike and upsetting domestic stakeholders with unilateral actions that tend more to destabilise the existing order rather than help build a new one.Experts warn the tariff move risks triggering a recession at home and sparking a trade war. “If this trade war continues through Labour Day [September 1], the US economy will likely suffer a recession this year,” Mark Zandi, chief economist of Moody’s Analytics, told AFP.The dollar, for decades a safe haven, fell about 1.7pc on April 3, its highest daily drop since November 2022, after President Trump imposed tariffs on imports. Stock markets also tanked as tariffs ignited recession worries.Left unchecked, a crisis of confidence in the dollar could also undermine its position as the world’s reserve currency, according to market commentaries.The likely implementation of US tariffs imposed on April 2 can be seen as “the start of a march towards Europe’s independence”, European Central Bank head Christine Lagarde told France Inter radio.The US administration’s not-so-secret plan is also to rebalance trade by weakening the dollar, analysts say, adding a way to do that would be to enlist foreign central banks in a coordinated effort to revalue their own currencies.Dwelling on Trump, tariffs and the fate of the dollar, Scottish-American political economist Mark Blyth argues that America’s protectionist policies reflect a global economic reordering that was already underway.Minutes before the markets opened in New York on April 7, Trump said his tariff reforms were “a chance to do something that should have been done decades ago”. “Don’t be weak! Don’t be stupid! Be strong, courageous, and patient, and greatness will be the result!” he urged.A full-blown war is upon us as the era of the rule-based multilateral trading order is nearly over, say analysts at Dawn. The American leader has made it clear that he would not make a deal with other countries unless the trade deficit is solved. Optimism is welcome, but we must be prepared to brace ourselves for the possible shocks. Published in Dawn, The Business and Finance Weekly, April 14th, 2025	ONLY AVAILABLE IN PAID PLANS	https://www.dawn.com/news/1904142/changing-the-economic-world-order	https://i.dawn.com/large/2025/04/14095156fdaa0b3.jpg?r=095237	2025-04-14 04:52:37
53	0	6	NewsAPI	Princeton Precision Health: An interdisciplinary, AI-driven approach to tackling big questions about health and disease	PPH researchers apply cutting-edge AI and computational models to massive datasets to develop a deep understanding of the factors that shape health and illness.	Human health is influenced by an extraordinarily complicated range of factors, from genetics and socioeconomics to air quality and lifestyle factors like exercise. Princeton Precision Health (PPH) is… [+13397 chars]	https://www.princeton.edu/news/2025/03/18/princeton-precision-health-interdisciplinary-ai-driven-approach-tackling-big	https://www.princeton.edu/sites/default/files/styles/scale_1440/public/images/2025/01/PPH%20hero%20editorial%201Artboard%201%20copy%204.jpg?itok=VMb37lJ2	2025-03-18 18:48:48
54	0	6	NewsDATA	News – Quantum Computing Report	Recent news items published within the last 6 months on quantum computing developments are listed below. Click on the hyperlinked item to go to the press release or news article for more details. For older news items published in 2024 click here, for 2023 click here, for 2022 click here, for 2021 click here, for 2020 click here, for 2019 [...]	ONLY AVAILABLE IN PAID PLANS	https://zephyrnet.com/news-quantum-computing-report-2/	https://zephyrnet.com/wp-content/uploads/2022/11/Logo.png	2025-04-13 14:36:00
55	0	6	NewsDATA	Bringing manufacturing back to America, one fab lab at a time	A collaborative network of makerspaces has spread from MIT across the country, helping communities make their own products.	ONLY AVAILABLE IN PAID PLANS	https://news.mit.edu/2025/bringing-manufacturing-back-america-fab-labs-0413	https://news.mit.edu/sites/default/files/styles/news_article__cover_image__original/public/images/202504/MIT_FabLab-01-Press.jpg?itok=0Fm5wF9t	2025-04-13 04:00:00
56	0.08	8	NewsDATA	Viatris Appoints Hemanth J. Varghese as Chief Strategy Officer	PITTSBURGH, April 14, 2025 /PRNewswire/ -- Viatris Inc. (Nasdaq: VTRS) today announced that Hemanth J. Varghese has joined the Company as Chief Strategy Officer. Varghese will be a member of the Company's Executive Leadership Team. Varghese is an accomplished healthcare leader with more...	ONLY AVAILABLE IN PAID PLANS	https://www.prnewswire.com/news-releases/viatris-appoints-hemanth-j-varghese-as-chief-strategy-officer-302427162.html	https://mma.prnewswire.com/media/2663194/Viatris_Hemanth_Varghese.jpg?p=original	2025-04-14 10:59:00
57	0	8	NewsDATA	Viatris Appoints Hemanth J. Varghese as Chief Strategy Officer	PITTSBURGH, April 14, 2025 /PRNewswire/ -- Viatris Inc. (Nasdaq: VTRS) today announced that Hemanth J. Varghese has joined the Company as Chief Strategy Officer. Varghese will be a member of the Company's Executive Leadership Team.	ONLY AVAILABLE IN PAID PLANS	https://www.news-journal.com/viatris-appoints-hemanth-j-varghese-as-chief-strategy-officer/article_14e38e8e-86e6-5555-8fb5-871a39b9e138.html	https://bloximages.newyork1.vip.townnews.com/news-journal.com/content/tncms/assets/v3/editorial/1/9b/19b95ee2-4b0f-5683-89b4-2aab74ed8827/67fcf1d6ad3d8.image.jpg?resize=300%2C200	2025-04-14 10:59:00
58	0.067	9	NewsDATA	Certara Reports Preliminary First Quarter 2025 Financial Results; Announces $100 Million Share Repurchase Authorization	Reiterates Full-Year 2025 GuidanceArsenal Capital Partners agrees to a one-year lock-upRADNOR, Pa., April 14, 2025 (GLOBE NEWSWIRE) -- Certara, Inc. (Nasdaq: CERT), a global leader in model-informed drug development, today announced expected revenue and bookings for the first quarter of 2025 based upon a preliminary review of first quarter results. Additionally, the company announced that its Board of Directors has authorized a stock repurchase program under which the company may repurchase up to $100 million of its outstanding common stock."We are pleased with our first quarter performance, driven by strong commercial execution and demand for our software and services,” said William F. Feehery, Chief Executive Officer. "We are committed to creating shareholder value over the long term at Certara. The Board's recent $100 million repurchase authorization reflects continued confidence in our strategy and the investments we are making using AI across the Certara platform. We are encouraged by the robust interest in our solutions from customers and are focused on executing our 2025 commercial and R&D goals.”The company also announced that Arsenal Capital Partners has agreed to a one-year lock-up on the sale of shares acquired by Arsenal and affiliates from EQT in a December 2022 transaction. "Arsenal has been an investor in Certara since 2013. We are very proud of the contribution Certara has made to the development and acceptance of Model Informed Drug Discovery. Arsenal is committed to supporting Certara's continued investment in the science and technologies necessary to enhance safe and effective pharmaceutical development for the benefit of patients around the world,” said Steve McLean, Senior Partner, Healthcare Group at Arsenal Capital Partners.Preliminary financials for the first quarter of 2025 are expected to be as follows:Revenue of $106.0 million, compared to $96.7 million in the first quarter of 2024, representing growth of 10%. Software revenue of $46.4 million, compared to $39.3 million in the first quarter of 2024, representing growth of 18%.Services revenue of $59.6 million, compared to $57.3 million in the first quarter of 2024, representing growth of 4%. Bookings of $118.0 million, compared to $105.8 million in the first quarter of 2024, representing growth of 12%. Software bookings of $40.6 million, compared to $33.1 million in the first quarter of 2024, representing growth of 22%.Services bookings of $77.4 million, compared to $72.7 million in the first quarter of 2024, representing growth of 7%. Preliminary revenue and bookings include Chemaxon revenue of $5.9 million and bookings of $4.9 million.Adjusted EBITDA1 in the range of $33-$35 million, compared to $29.1 million in the first quarter of 2024, representing growth of 13-20%. These preliminary first quarter results are unaudited and subject to the finalization of the company's regular financial and accounting procedures. As a result, these preliminary estimates may differ from the actual results that will be reflected in the company's consolidated financial statements for the first quarter when they are completed and publicly disclosed, and any changes may be material. The Company's expectations with respect to its unaudited results for the periods discussed above are based on management's current estimates.2025 Financial OutlookCertara is reiterating its guidance for the full year 2025:Full year 2025 revenue to be in the range of $415 million to $425 million.Full year adjusted EBITDA1 margin to be in the range of 30-32%.Full year adjusted diluted earnings per share is expected to be in the range of $0.42 - $0.46.Fully diluted shares are expected to be in the range of 162 million to 164 million. Update on Regulatory Services Strategic ReviewCertara has continued to pursue a strategic evaluation of the regulatory services business. Following public announcement of the internal business review, the company has engaged in discussions with several external parties regarding the regulatory services business. At this time, those discussions remain preliminary.First Quarter Earnings Webcast and Conference Call DetailsCertara will host a conference call on May 5, 2025, at 5:00 p.m. ET to discuss its first quarter 2025 financial results. Investors interested in listening to the conference call are required to register online in advance of the call. A live and archived webcast of the event will be available on the "Investors” section of the Certara website at https://ir.certara.com.1.) A reconciliation of adjusted EBITDA margin to net income margin (loss) and adjusted diluted earnings per share to diluted earnings per share has not been provided in the outlook included herein as the quantification of certain items included in the calculation of GAAP net income (loss) and earnings per share cannot be calculated or predicted at this time without unreasonable efforts. For example, the non-GAAP adjustment for equity-based compensation expense requires additional inputs such as number of shares granted and market price that are not currently ascertainable. For the same reasons, the company is unable to address the probable significance of the unavailable information, which could have a potentially unpredictable, and potentially significant, impact on its future GAAP financial results. See "Forward-Looking Statements" and "A Note on Non-GAAP Financial Measures."About CertaraCertara accelerates medicines using proprietary biosimulation software, technology and services to transform traditional drug discovery and development. Its clients include more than 2,400 biopharmaceutical companies, academic institutions, and regulatory agencies across 70 countries.Please visit our website at www.certara.com. We intend to use our website as a means of disclosing material, non-public information and for complying with our disclosure obligations under Regulation FD. Such disclosures will be included in the Investor Relations section of our website at https://ir.certara.com. Accordingly, investors should monitor such portion of our website, in addition to following our press releases, Securities and Exchange Commission filings and public conference calls and webcasts.Forward-Looking StatementsThis press release contains certain statements that constitute forward-looking statements within the meaning of the "safe harbor” provisions of the Private Securities Litigation Reform Act of 1995, with respect to the company's estimated first quarter 2025 results, our 2025 commercial and R&D goals, statements regarding our share repurchase authorization and statements regarding Arsenal's ability to sell shares of our common stock. These statements typically contain words such as "believe,” "may,” "potential,” "will,” "plan,” "could,” "estimate,” "expects” and "anticipates” or the negative of these words or other similar terms or expressions. Any statement in this press release that is not a statement of historical fact is a forward-looking statement and involves significant risks and uncertainties. Although we believe that the expectations reflected in these forward-looking statements are reasonable, we cannot provide any assurance that these expectations will prove to be correct. You should not rely upon forward-looking statements as predictions of future events and actual results, events, or circumstances. Actual results may differ materially from those described in the forward-looking statements and are subject to a variety of assumptions, uncertainties, risks and factors that are beyond our control, including any deceleration in, or resistance to, the acceptance of model-informed biopharmaceutical discovery and development; our ability to compete within our market; changes or delays in government regulation relating to the biopharmaceutical industry; trends in research and development ("R&D”) spending, the use of third parties by biopharmaceutical companies and a shift toward more R&D occurring at smaller biotechnology companies; consolidation within the biopharmaceutical industry; our ability to successfully increase our customer base, expand our relationships and the products and services we provide, and enter new markets; our ability to retain key personnel or recruit additional qualified personnel; risks related to the mischaracterization of our independent contractors; any delays or defects in our release of new or enhanced software or other biosimulation tools; issues relating to the use of artificial intelligence and machine learning in our products and services; failure of our existing customers to renew their software licenses or any delays or terminations of contracts or reductions in scope of work by our existing customers; risks related to our contracts with government customers, including the ability of third parties to challenge our receipt of such contracts; our ability to sustain historic growth rates; any future acquisitions and our ability to successfully integrate such acquisitions; the accuracy of our addressable market estimates; our ability to successfully operate a global business; adverse global economic conditions; our ability to comply with applicable anti-corruption, trade compliance and economic sanctions laws and regulations; risks related to litigation against us; the adequacy of our insurance coverage and our ability to obtain adequate insurance coverage in the future; our ability to perform our services in accordance with contractual requirements, regulatory standards and ethical considerations; the loss of more than one of our major customers; the ability or inability of our bookings to accurately predict our future revenue and our ability to realize the anticipated revenue reflected in our bookings; any disruption in the operations of the third-party providers who host our software solutions or any limitations on their capacity or interference with our use; our ability to reliably meet our data storage and management requirements, or the experience of any failures or interruptions in the delivery of our services over the internet; any unauthorized access to or use of customer or other proprietary or confidential data or other breach of our cybersecurity measures; the occurrence of natural disasters, pandemics, epidemic diseases, and public health crises, which may result in delays or cancellations of customer contracts or decreased utilization by our employees; our ability to comply with the terms of any licenses governing our use of third-party open source software utilized in our software solutions; our ability to comply with applicable privacy and cybersecurity laws; our ability to adequately enforce or defend our ownership and use of our intellectual property and other proprietary rights; any allegations that we are infringing, misappropriating or otherwise violating a third party's intellectual property rights; our ability to meet the obligations under our current or future indebtedness as they become due; any limitations on our ability to pursue our business strategies due to restrictions under our current or future indebtedness or inability to comply with any restrictions under such indebtedness; any impairment of goodwill or other intangible assets; the accuracy of our estimates and judgments relating to our critical accounting policies and any changes in financial reporting standards or interpretations; any inability to design, implement, and maintain effective internal controls when required by law, or inability to timely remediate internal controls that are deemed ineffective; and the other factors detailed under the captions "Risk Factors”, "Management's Discussion and Analysis of Financial Condition and Results of Operations” and "Special Note Regarding Forward-Looking Statements” and elsewhere in our Securities and Exchange Commission ("SEC”) filings, and reports, including the Form 10-K filed by the company with the SEC on February 26, 2025, and subsequent reports filed with the SEC. Any forward-looking statements speak only as of the date of this release and, except to the extent required by applicable securities laws, we expressly disclaim any obligation to update or revise any of them to reflect actual results, any changes in expectations or any change in events.Repurchases of shares of the company's common stock may be conducted through open market purchases or privately negotiated transactions in compliance with Rule 10b-18 under the Securities Exchange Act of 1934, as amended (the "Exchange Act”), including through trading plans pursuant to Rule 10b5-1 under the Exchange Act. The actual timing and amount of future repurchases are subject to business and market conditions, corporate and regulatory requirements, stock price, acquisition opportunities and other factors. The stock repurchase program does not obligate the company to acquire any particular amount of common stock, and the program may be suspended or terminated at any time by the company at its discretion without prior notice.A Note on Non-GAAP Financial MeasuresThis press release contains "non-GAAP measures” which are financial measures that either exclude or include amounts that are not excluded or included in the most directly comparable measures calculated and presented in accordance with U.S. generally accepted accounting principles ("GAAP”). Specifically, the company makes use of the non-GAAP financial measures adjusted EBITDA, adjusted EBITDA margin and adjusted diluted earnings per share, which are not a recognized metrics under GAAP. These measures should not be considered an alternative to net income (loss), net income (loss) margin or diluted earnings per share derived in accordance with GAAP and should not be considered a measure of discretionary cash available to the company to invest in the growth of its business. The presentation of this measure has limitations as an analytical tool and should not be considered in isolation, or as a substitute for the company's results as reported under GAAP. Because not all companies use identical calculations, the presentations of these measures may not be comparable to other similarly titled measures of other companies and can differ significantly from company to company.Management uses non-GAAP measures such as adjusted EBITDA, adjusted EBITDA margin and adjusted diluted earnings per share to measure and assess the performance of the company's business, to evaluate the effectiveness of its business strategies, to make budgeting decisions, to make certain compensation decisions, and to compare the company's performance against that of other peer companies using similar measures. In addition, management believes these metrics provide useful measures for period-to-period comparisons of the company's business, as they remove the effect of certain non-cash expenses and other items not indicative of its ongoing operating performance.Management believes that disclosing adjusted EBITDA adjusted EBITDA margin and adjusted diluted earnings per share is helpful to investors, analysts, and other interested parties because they can assist in providing a more consistent and comparable overview of our operations across our historical periods. In addition, these non-GAAP measures are frequently used by analysts, investors, and other interested parties to evaluate and assess performance.Adjusted EBITDA represents net income excluding interest expense, provision (benefit) for income taxes, depreciation and amortization expense, intangible asset amortization, equity-based compensation expense, goodwill impairment, change in fair value of contingent consideration, acquisition and integration expense and other items not indicative of our ongoing operating performance. Adjusted diluted earnings per share excludes the effect of equity-based compensation expense, amortization of acquisition-related intangible assets, goodwill impairment, change in fair value of contingent consideration, acquisition and integration expense, and other items not indicative of our ongoing operating performance as well as income tax provision adjustment for such charges.In evaluating adjusted EBITDA, adjusted EBITDA margin and adjusted diluted earnings per share, you should be aware that in the future the Company may incur expenses similar to those eliminated in this presentation and this presentation should not be construed as an inference that future results will be unaffected by unusual items.Contacts:Investor Relations Contact:David DeuchlerGilmartin Groupir@certara.comMedia Contact:Alyssa HorowitzPan Communicationscertara@pancomm.com	ONLY AVAILABLE IN PAID PLANS	https://www.manilatimes.net/2025/04/14/tmt-newswire/globenewswire/certara-reports-preliminary-first-quarter-2025-financial-resultsannounces-100-million-share-repurchase-authorization/2091851	https://www.manilatimes.net/manilatimes/uploads/images/2025/04/14/594313.png	2025-04-14 12:11:41
59	0	9	NewsDATA	Russia Pharmaceutical Market 2025 : Industry Size to Reach USD 14.4 Billion by 2033, At a CAGR of 4.70%	How Big is Russia Pharmaceutical Market Industry?The Russia pharmaceutical market size reached USD 9.2 Billion in 2024 and expected to reach USD 14.4 Billion by 2033, exhibiting a growth rate (CAGR) of 4.70% during 2025-2033.Download sample copy of the Report:	ONLY AVAILABLE IN PAID PLANS	https://www.openpr.com/news/3969879/russia-pharmaceutical-market-2025-industry-size-to-reach-usd	https://cdn.open-pr.com/L/4/L414361951_g.jpg	2025-04-14 12:36:48
60	0	9	NewsDATA	Viatris Appoints Hemanth J. Varghese as Chief Strategy Officer	PITTSBURGH, April 14, 2025 /PRNewswire/ -- Viatris Inc. (Nasdaq: VTRS) today announced that Hemanth J. Varghese has joined the Company as Chief Strategy Officer. Varghese will be a member of the Company's Executive Leadership Team. Varghese is an accomplished healthcare leader with more...	ONLY AVAILABLE IN PAID PLANS	https://www.prnewswire.com/news-releases/viatris-appoints-hemanth-j-varghese-as-chief-strategy-officer-302427162.html	https://mma.prnewswire.com/media/2663194/Viatris_Hemanth_Varghese.jpg?p=original	2025-04-14 10:59:00
61	0	9	NewsDATA	Viatris Appoints Hemanth J. Varghese as Chief Strategy Officer	PITTSBURGH, April 14, 2025 /PRNewswire/ -- Viatris Inc. (Nasdaq: VTRS) today announced that Hemanth J. Varghese has joined the Company as Chief Strategy Officer. Varghese will be a member of the Company's Executive Leadership Team.	ONLY AVAILABLE IN PAID PLANS	https://www.news-journal.com/viatris-appoints-hemanth-j-varghese-as-chief-strategy-officer/article_14e38e8e-86e6-5555-8fb5-871a39b9e138.html	https://bloximages.newyork1.vip.townnews.com/news-journal.com/content/tncms/assets/v3/editorial/1/9b/19b95ee2-4b0f-5683-89b4-2aab74ed8827/67fcf1d6ad3d8.image.jpg?resize=300%2C200	2025-04-14 10:59:00
62	0	9	NewsDATA	Certara Reports Preliminary First Quarter 2025 Financial Results; Announces $100 Million Share Repurchase Authorization	(MENAFN - GlobeNewsWire - Nasdaq) Reiterates Full-Year 2025 GuidanceArsenal Capital Partners agrees to a one-year lock-up RADNOR, Pa., April 14, 2025 (GLOBE NEWSWIRE) -- Certara, Inc. (Nasdaq: ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109427139/Certara-Reports-Preliminary-First-Quarter-2025-Financial-ResultsAnnounces-100-Million-Share-Repurchase-Authorization	https://menafn.com/images/Menafn_SmallLogo.jpg	2025-04-14 08:16:14
63	0	9	NewsDATA	Viatris Appoints Hemanth J. Varghese As Chief Strategy Officer	(MENAFN - PR Newswire)Prior to joining Viatris, Varghese was President and Chief Operating Officer at Venus Concept, an innovative global medical aesthetic technology company. He previously served ...	ONLY AVAILABLE IN PAID PLANS	https://menafn.com/1109426725/Viatris-Appoints-Hemanth-J-Varghese-As-Chief-Strategy-Officer	https://menafn.com/updates/pr/2025-04/14/PN_61d60image_story.jpg	2025-04-14 07:01:26
64	0	10	NewsAPI	From Nkrumah to neoliberalism	On the podcast, we explore: How did Ghana go from Nkrumah’s radical vision to neoliberal entrenchment? Gyekye Tanoh unpacks the forces behind its political stability, deepening inequality, and the fractures shaping its future.	On the podcast, we explore: How did Ghana go from Nkrumah’s radical vision to neoliberal entrenchment? Gyekye Tanoh unpacks the forces behind its political stability, deepening inequality, and the fr… [+78811 chars]	https://africasacountry.com/2025/03/from-nkrumah-to-neoliberalism/	https://images.jacobinmag.com/wp-content/uploads/sites/3/2025/03/17113138/shutterstock_2218621431-scaled.jpg	2025-03-17 11:36:22
67	0.267	11	NewsAPI	Equity analysis: India’s billionaire boom isn’t a sign of a hunky-dory economy	The country is an outlier when assessed by the growth in its count of billionaires. This reflects deep structural problems and raises questions about an economic model that has yielded little shared prosperity.	In a recent talk at the Institute for Social and Economic Change, economist Sanjay Reddy noted a startling fact about Indias growth process. According to the International Monetary Fund, in 2024, Ind… [+5639 chars]	https://www.livemint.com/opinion/online-views/india-growth-billionaires-india-inequality-wealth-distribution-nifty50-bse-nse-forbes-billionaires-list-richest-indian-11742903748373.html	https://www.livemint.com/lm-img/img/2025/03/25/1600x900/2-0-75808670-BSE-4Cnew--0_1681478439435_1742904127502.jpg	2025-03-26 08:30:15
68	0.133	11	NewsAPI	Joseph Stiglitz Warns Of The Looming Inequality Amid AI Monopoly Power	Stiglitz, renowned economist said, unlike Adam's Smith view, "The pursuit of self-interest in the age of AI does not mean the well-being of society.”	US economist and recipient of the Nobel Prize in Economic Sciences Joseph E. Stiglitz poses during a ... More photo session in Paris on September 15, 2022. (Photo by JOEL SAGET / AFP) (Photo by JOEL … [+10947 chars]	https://www.forbes.com/sites/hessiejones/2025/04/13/joseph-stiglitz-warns-of-the-looming-inequality-amid-ai-monopoly-power/	https://imageio.forbes.com/specials-images/imageserve/67fc2c3aadc3a3f52f54e542/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-13 22:00:42
69	0.133	11	NewsAPI	Trump’s Big Wealth Tax	Many progressives have long pushed for a wealth tax to lessen some of the huge fortunes that have been built as a result of the rise in inequality over the last half-century. Regardless of the merits of a wealth tax, to many of us it seemed like an impossible…	Photograph by Nathaniel St. Clair\r\nMany progressives have long pushed for a wealth tax to lessen some of the huge fortunes that have been built as a result of the rise in inequality over the last hal… [+2105 chars]	https://www.counterpunch.org/2025/04/10/trumps-big-wealth-tax/	https://www.counterpunch.org/wp-content/uploads/2024/07/IMG_8111-scaled.jpeg	2025-04-10 05:52:25
70	0.133	11	NewsAPI	The Data is Right: Americans are Prospering Economically	A recent essay by Eugene Ludwig published by Politico argues that despite most economic data showing a healthy US economy in 2024, things are actually really bad. He tries to convince us by providing alternative data. However, a close examination of his alter…	A recent essay by Eugene Ludwig published by Politico argues that despite most economic data showing a healthy US economy in 2024, things are actually really bad. He tries to convince us by providing… [+6227 chars]	https://www.econlib.org/the-data-is-right-americans-are-prospering-economically/	https://www.econlib.org/wp-content/uploads/2025/03/EconomicData.jpg	2025-03-19 20:00:28
71	0.133	11	NewsDATA	Poverty Is Global Issue, We Should Rather Focus On Addressing It – Fasua	Tope Fasua is the Special Adviser to President Bola Tinubu on Economic Affairs. In this interview he speaks on the various reforms of the current administration which have impacted positively on the citizens, why focus should be on addressing poverty which is a global issue, the need for the people to also pay attention to what the governments at the state level are doing rather than mounting [...]	ONLY AVAILABLE IN PAID PLANS	https://independent.ng/poverty-is-global-issue-we-should-rather-focus-on-addressing-it-fasua/	https://independent.ng/wp-content/uploads/download-67.jpg	2025-04-14 06:08:04
72	0	11	NewsAPI	Mercantilism	Comments	Seaport at sunset, a painting by Claude Lorrain, completed in 1639 at the height of mercantilism\r\nMercantilism is a nationalisteconomic policy that is designed to maximize the exports and minimize th… [+49551 chars]	https://en.wikipedia.org/wiki/Mercantilism	https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/F0087_Louvre_Gellee_port_au_soleil_couchant-_INV4715_rwk.jpg/1200px-F0087_Louvre_Gellee_port_au_soleil_couchant-_INV4715_rwk.jpg	2025-04-05 01:40:25
73	0	11	NewsAPI	The Gaping Hole in the Center of the Abundance Agenda	America has a housing affordability crisis. Ezra Klein and Derek Thompson’s Abundance, Yoni Appelbaum’s Stuck, and Mark Dunkelman’s Why Nothing Works argue to varying degrees that land-use restrictions, mostly at the local level, are what created this problem…	This blind spot about stagnating wages is pretty glaring. Klein and Thompson cite the economist Ed Glaesers finding that prior to the 1980s wages in New York City were unusually high compared to the … [+1825 chars]	https://newrepublic.com/article/193346/economic-inequality-keynes-abundance-agenda	https://images.newrepublic.com/45a9eeecdd28c4d94b4af9e277a3ab3f60b17695.jpeg?w=1200&h=630&crop=faces&fit=crop&fm=jpg	2025-03-31 10:00:00
74	0	11	NewsAPI	Trump’s tariffs are a doomed attempt at time travel	President Donald Trump’s defenders often frame his trade policies as prioritizing economic development over the free market.  In their telling, America has an interest in manufacturing valuable goods domestically, even if producing such wares in the US is not…	Donald Trump speaks while holding a chart illustrating non-reciprocal tariff examples during a meeting in the Cabinet Room of the White House in Washington, D.C., U.S., Thursday, Jan. 24, 2019.\r\n\n\nPr… [+17262 chars]	https://www.vox.com/politics/407025/trump-tariffs-reciprocal-trade-war-why-explanation-nostalgia	https://platform.vox.com/wp-content/uploads/sites/2/2025/04/gettyimages-1088026342.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200	2025-04-03 19:34:00
75	0	11	NewsAPI	Trump’s Tariffs Buck the Global Neoliberal Order — But Still Serve the 1 Percent	Trump’s tariffs threaten to widen inequality in the US, making the rich richer and impoverishing the working class.	Since assuming office, the Trump administration has taken actions resembling those of an absolutist state: undermining civil rights and democracy at home while introducing a reciprocal tariffs plan t… [+15021 chars]	https://truthout.org/articles/trumps-tariffs-buck-the-global-neoliberal-order-but-still-serve-the-1-percent/	https://truthout.org/app/uploads/2025/04/2025_0410-trump-wo-scaled.jpg	2025-04-10 17:11:37
76	0	11	NewsAPI	Not Even America's Richest Live as Long as Some of Europe's Poorest	New research shows a significant gap in mortality rates between the US and Europe, with even the wealthiest Americans more likely to meet an early death than the wealthiest Europeans – and in some cases, more likely than the poorest in some European countries…	New research shows a significant gap in mortality rates between the US and Europe, with even the wealthiest Americans more likely to meet an early death than the wealthiest Europeans and in some case… [+2981 chars]	https://www.sciencealert.com/not-even-americas-richest-live-as-long-as-some-of-europes-poorest	https://www.sciencealert.com/images/2025/04/DollarBills.jpg	2025-04-08 03:05:33
77	0	11	NewsAPI	To instill confidence, China tries to reassure private entrepreneurs of support	As the country faces slowing economic growth and a trade war with the U.S., China has taken pains to reassure entrepreneurs by telling them they can start businesses, create jobs and benefit society.	BEIJING Every once in a while, China's government makes a high-profile effort to right a wrong or rehabilitate a well-known person who has fallen from favor. They are gestures to restore public confi… [+6458 chars]	https://www.npr.org/2025/04/11/g-s1-58893/china-economy-entrepreneurs-trade-war-jack-ma	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/6833x3844+0+593/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Ff7%2F61%2F10e5fa4747e09cee771de68eda1e%2Fgettyimages-2177786037.jpg	2025-04-11 15:31:00
78	0	11	NewsAPI	Nitin Pai: Trump’s tariffs serve political ends even if they lack economic logic	In India, we should view his trade aggression from a lens of economic statecraft and use the current upheaval to effect essential reforms. Where his tariff juggernaut goes would then matter less.	Some of Donald Trumps reasons for imposing tariffs on countries are understandable, even if their fitness for the purpose is debatable. Demanding that Mexico impose tighter border controls, Europe ra… [+5152 chars]	https://www.livemint.com/opinion/online-views/donald-trump-tariffs-geopolitical-economic-logic-stephen-miran-robert-lighthizer-us-economy-mexico-tariffs-china-tariffs-11742475026127.html	https://www.livemint.com/lm-img/img/2025/03/20/1600x900/APTOPIX-Trump-Speech-3_1741142468679_1742475288012.jpg	2025-03-23 07:30:11
79	0	11	NewsAPI	From Nkrumah to neoliberalism	On the podcast, we explore: How did Ghana go from Nkrumah’s radical vision to neoliberal entrenchment? Gyekye Tanoh unpacks the forces behind its political stability, deepening inequality, and the fractures shaping its future.	On the podcast, we explore: How did Ghana go from Nkrumah’s radical vision to neoliberal entrenchment? Gyekye Tanoh unpacks the forces behind its political stability, deepening inequality, and the fr… [+78811 chars]	https://africasacountry.com/2025/03/from-nkrumah-to-neoliberalism/	https://images.jacobinmag.com/wp-content/uploads/sites/3/2025/03/17113138/shutterstock_2218621431-scaled.jpg	2025-03-17 11:36:22
80	0	11	NewsAPI	No, President Trump, the Income Tax Wasn’t A Mistake. But It Was an Accident.	by Jesse Eisinger \n \n\n \n \n ProPublica is a nonprofit newsroom that investigates abuses of power. Sign up to receive our biggest stories as soon as they’re published.\n\n \n\n \n\n \n \n\n\n\n \nIn his Rose Garden speech launching a global trade war by announcing the most…	ProPublica is a nonprofit newsroom that investigates abuses of power. Sign up to receive our biggest stories as soon as theyre published.\r\nIn his Rose Garden speech launching a global trade war by an… [+11727 chars]	https://www.propublica.org/article/history-income-tax-history-16th-amendment-trump-tariffs-great-depression	https://img.assets-d.propublica.org/v5/images/GettyImages-3069163.jpg?crop=focalpoint&fit=crop&fp-x=0.3887&fp-y=0.5113&h=630&imgixProfile=propublicaAssetsV5&q=90&w=1200&s=6549e5f9599b6bbdbbabba32f3ebee6c	2025-04-08 15:15:00
81	0	11	NewsAPI	Friday essay: why it’s time to ditch the myth of the heroic billionaire	As global inequality soars, President Donald Trump has recruited a bloat of fellow billionaires to help run his administration, including the world’s richest man.	In February, the world’s richest man, Elon Musk, wielded a chainsaw at a conservative gathering as he gleefully spoke of his new role as head of the Department of Government Efficiency (DOGE), where … [+12808 chars]	https://theconversation.com/friday-essay-why-its-time-to-ditch-the-myth-of-the-heroic-billionaire-252641	https://images.theconversation.com/files/657433/original/file-20250325-56-nb6tog.jpg?ixlib=rb-4.1.0&rect=0%2C168%2C5097%2C2541&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-03 19:02:34
82	0	11	NewsAPI	Puerto Rico Protests Against Higher Ed Cuts Follow Long Fight Against Austerity	The university showdown is the latest chapter in a decades-long struggle against austerity on the archipelago.	This February, President Luis A. Ferrao Delgado of the University of Puerto Rico resigned after attempting to suspend 64 educational programs. The measure targeted core disciplines such as history, p… [+20812 chars]	https://truthout.org/articles/puerto-rico-protests-against-higher-ed-cuts-follow-long-fight-against-austerity/	https://truthout.org/app/uploads/2025/03/2025_0327-puerto-rico-scaled.jpg	2025-03-27 14:58:10
83	0	11	NewsAPI	Climate Change Policies Driving California’s Golden Road to Decline	California's decline, driven by misguided climate policies and rising inequality, threatens its status as an economic powerhouse. This critical analysis unveils the state’s challenges and the urgent need for reform.\nThe post Climate Change Policies Driving Ca…	Critics say this vision is at odds with the facts on the ground. Rather than the exemplar of a new progressive capitalism and a model for social justice, California both accommodates the highest numb… [+23900 chars]	https://www.thegatewaypundit.com/2025/04/climate-change-driving-californias-golden-road-decline/	https://www.thegatewaypundit.com/wp-content/uploads/2025/04/high-res-image-43-1200x630.png	2025-04-06 02:00:54
84	0	11	NewsAPI	Letter from London: Blessed Are the Young, for They Shall Inherit the National Debt	It was something Grace Blakeley said that first drew my attention to the little-discussed relationship between young people and trade unions in the UK today. For those unfamiliar with Blakeley, she’s a prominent economist, writer, and journalist known for her…	It was something Grace Blakeley said that first drew my attention to the little-discussed relationship between young people and trade unions in the UK today.\r\nFor those unfamiliar with Blakeley, shes… [+5788 chars]	https://www.counterpunch.org/2025/04/11/letter-from-london-blessed-are-the-young-for-they-shall-inherit-the-national-debt/	https://www.counterpunch.org/wp-content/uploads/2021/06/cp-default-share.png	2025-04-11 05:48:05
85	0	11	NewsAPI	2025: The fall of globalism, the rise of Trumpism	'To take care of the people was not popular – until the 47th president arrived'	Read Hanne’s The Herland Report.\r\nAmid the seismic geopolitical changes President Donald Trump dramatically and unapologetically causes, the globalist norms that have governed the West since the fall… [+4905 chars]	https://www.wnd.com/2025/03/2025-the-fall-of-globalism-the-rise-of-trumpism/	https://www.wnd.com/wp-content/uploads/2018/09/trump-united-nations.jpg	2025-03-27 23:07:37
86	0	12	NewsAPI	Friday essay: why it’s time to ditch the myth of the heroic billionaire	As global inequality soars, President Donald Trump has recruited a bloat of fellow billionaires to help run his administration, including the world’s richest man.	In February, the world’s richest man, Elon Musk, wielded a chainsaw at a conservative gathering as he gleefully spoke of his new role as head of the Department of Government Efficiency (DOGE), where … [+12808 chars]	https://theconversation.com/friday-essay-why-its-time-to-ditch-the-myth-of-the-heroic-billionaire-252641	https://images.theconversation.com/files/657433/original/file-20250325-56-nb6tog.jpg?ixlib=rb-4.1.0&rect=0%2C168%2C5097%2C2541&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-03 19:02:34
87	0	12	NewsAPI	Time to ask Al Sharpton: Why should DEI exist in the first place?	Even the most ardent Al Sharpton watchers are likely to have groaned at news that “the Rev.” has called for yet another boycott of companies that are scrapping their DEI initiatives. This time the target is Pepsi, which Sharpton “put on notice” last Saturday …	Even the most ardent Al Sharpton watchers are likely to have groaned at news that the Rev. has called for yet another boycott of companies that are scrapping their DEI initiatives.\r\nThis time the tar… [+6714 chars]	https://nypost.com/2025/04/12/opinion/time-to-ask-al-sharpton-why-should-dei-exist-in-the-first-place/	https://nypost.com/wp-content/uploads/sites/2/2025/04/newspress-collage-fte9172tt-1744319405744.jpg?quality=75&strip=all&1744305065&w=1024	2025-04-12 10:00:00
88	0	12	NewsAPI	Why Social Democrats in Germany Are Facing Extinction	The coalition negotiations between the social democratic SPD and conservative right CDU/CSU are going surprisingly smoothly, almost harmoniously. Lars Klingbeil, co-chairman of the SPD, explains that he and CDU leader Friedrich Merz get along well. A Shadow o…	Image by Eddie Zhang.\r\nThe coalition negotiations between the social democratic SPD and conservative right CDU/CSU are going surprisingly smoothly, almost harmoniously. Lars Klingbeil, co-chairman of… [+16540 chars]	https://www.counterpunch.org/2025/04/10/why-social-democrats-in-germany-are-facing-extinction/	https://www.counterpunch.org/wp-content/uploads/2025/04/eddie-zhang-XsjH-O-slkA-unsplash-scaled.jpg	2025-04-10 05:45:39
89	0	12	NewsDATA	Poverty Is Global Issue, We Should Rather Focus On Addressing It – Fasua	Tope Fasua is the Special Adviser to President Bola Tinubu on Economic Affairs. In this interview he speaks on the various reforms of the current administration which have impacted positively on the citizens, why focus should be on addressing poverty which is a global issue, the need for the people to also pay attention to what the governments at the state level are doing rather than mounting [...]	ONLY AVAILABLE IN PAID PLANS	https://independent.ng/poverty-is-global-issue-we-should-rather-focus-on-addressing-it-fasua/	https://independent.ng/wp-content/uploads/download-67.jpg	2025-04-14 06:08:04
90	0	13	NewsAPI	Capturing the cosmos on canvas: How art helps scientists and space agencies communicate with the public	Astrophysicist and artist Ed Belbruno explains how art helps scientists communicate their work to the public and even discover solutions to spaceflight and astronomy problems.	For Ed Belbruno the universe around us is more than eye-catching. It's a medium for infinite fine art, an inspiration for artistic renderings that can break boundaries and be used for spacecraft miss… [+6987 chars]	https://www.space.com/space-exploration/capturing-the-cosmos-on-canvas-how-art-helps-scientists-and-space-agencies-communicate-with-the-public	https://cdn.mos.cms.futurecdn.net/kjF4NcjE4fKtTiSwQzAnLk-1200-80.jpg	2025-03-27 14:00:00
91	0	13	NewsAPI	I’m headed to STARMUS La Palma 2025, where curious minds will gather under one of the darkest skies on Earth	STARMUS La Palma 2025 is set to unite space, science and stargazing with presentations and concerts under some of the darkest skies in the world.	In just a couple of weeks, I'll be packing my bags and heading to a beautiful island just off the coast of northwestern Africa shaped by volcanic activity and dense, forested terrain. However, while … [+3668 chars]	https://www.space.com/why-i-am-heading-to-starmus-la-palma-2025-festival-celebrating-space	https://cdn.mos.cms.futurecdn.net/XMdemiL52GZ9GavFJ8PfMG-1200-80.jpg	2025-04-13 13:00:00
92	0	13	NewsAPI	'Earth to Space' art festival set to launch at Kennedy Center this week	A nearly month-long mission is ready to lift off, with preparations being made at the Kennedy Center. To be clear, not NASA's Kennedy Space Center, but the Kennedy Center for the Performing Arts.	A nearly month-long space mission is ready to lift off, with final preparations being made at the Kennedy Center.\r\nTo be clear, not NASA's Kennedy Space Center in Florida, but rather the John F. Kenn… [+6881 chars]	http://www.collectspace.com/news/news-032425a-earth-to-space-arts-breaking-sky-festival-kennedy-center.html	https://cdn.mos.cms.futurecdn.net/PyWknMGS9Q6Gn8wuvgag5M-1200-80.jpg	2025-03-25 21:00:00
93	0	13	NewsAPI	New documentary 'Children of the Sky' asks the bold question: Can we raise kids in space? (op-ed)	A new 28-minute film explores the medical, social, political and ethical challenges of parenthood and child-rearing that truly permanent communities in space will need to solve.	Dave Brody writes and directs space-themed non-fiction documentary television.\r\nThere is much talk lately about cities on Mars, multiple bases on the moon, free orbiting "islands" in space where tens… [+14787 chars]	https://www.space.com/entertainment/new-documentary-children-of-the-sky-asks-the-bold-question-can-we-raise-kids-in-space-op-ed	https://cdn.mos.cms.futurecdn.net/Nvy2utGp4W3SvwAb3TQMoB-1200-80.jpg	2025-03-26 13:00:00
94	0	13	NewsAPI	"So Much Good Science": The Black Hole Visuals In Christopher Nolan's $759M Oscar-Nominated Sci-Fi Movie Called "One Of The Most Accurate Depictions Of The Environment" By Expert, Who Gives It A Near-Perfect Score	Christopher Nolan's 2014 sci-fi movie gets analyzed by a real astrophysicist, who sings the movie's praises despite occasional errors.	Christopher Nolan has created some impressive universes over the course of his filmmaking career. These worlds can stem from both the real-world and the sci-fi space, as Nolan has honed his ability t… [+7726 chars]	https://screenrant.com/interstellar-2014-movie-space-science-accuracy-paul-sutter-reaction/	https://static1.srcdn.com/wordpress/wp-content/uploads/2025/01/timothee-chalamet-as-tom-cooper-in-interstellar.jpg	2025-03-25 13:40:22
95	0	13	NewsAPI	What happens to the human body in deep space?	Washington (AFP) Mar 18, 2025\n\n\n Bone and muscle deterioration, radiation exposure, vision impairment - these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation. \n\nAs US…	What happens to the human body in deep space?By Issam AHMEDWashington (AFP) Mar 18, 2025\r\nBone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenge… [+4348 chars]	https://www.spacedaily.com/reports/What_happens_to_the_human_body_in_deep_space_999.html	https://www.spxdaily.com/images-hg/female-astronaut-jessica-meir-caves-shirt-international-space-station-hg.jpg	2025-03-18 10:13:19
96	0	13	NewsAPI	What Happens To The Human Body In Deep Space?	Bone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation.	Bone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychologica… [+4162 chars]	https://www.ibtimes.com/what-happens-human-body-deep-space-3766639	https://d.ibtimes.com/en/full/4587631/astronauts-butch-wilmore-suni-williams-prepare-return-home-after-nine-months-aboard.jpg	2025-03-18 01:42:21
97	0	13	NewsAPI	Antarctic bases are hotbeds of stress and violence. Space stations could face the same challenges	Recent allegations of violence at the SANAE IV Antarctic research base highlight the urgent need to improve safety in remote and extreme places.	The South African National Antarctic Expedition research base, SANAE IV, at Vesleskarvet, Queen Maud Land, Antarctica.\n Dr Ross Hofmeyr/Wikimedia, CC BY-SA\r\nEarlier this week, reports emerged that a … [+6373 chars]	https://theconversation.com/antarctic-bases-are-hotbeds-of-stress-and-violence-space-stations-could-face-the-same-challenges-252720	https://images.theconversation.com/files/656505/original/file-20250320-56-22mhep.jpg?ixlib=rb-4.1.0&rect=0%2C23%2C798%2C398&q=45&auto=format&w=1356&h=668&fit=crop	2025-03-20 19:09:31
98	0	13	NewsAPI	If You Miss The Expanse & Wish Season 7 Was Happening Like I Do, Watch These 5 Sci-Fi TV Shows On Streaming	Although nothing would be better than actually getting The Expanse season 7, these other sci-fi TV shows available on streaming are worth watching.	Its a real shame The Expanseseason 7 isnt happening, and Im disappointed about that, but there sci-fi TV shows are available on streaming services to help fill the gap. The Expanse season 7 is an ins… [+6206 chars]	https://screenrant.com/the-expanse-season-7-similar-tv-shows-streaming-recommendation/	https://static1.srcdn.com/wordpress/wp-content/uploads/2025/03/if-you-miss-the-expanse-wish-season-7-was-happening-like-i-do-watch-these-5-sci-fi-tv-shows-on-streaming.jpg	2025-03-23 19:40:13
99	0	13	NewsAPI	TOI-1453 system hosts contrasting super-Earth and low-mass sub-Neptune	Paris, France (SPX) Mar 17, 2025\n\n\nAstronomers have identified two planets orbiting the star TOI-1453, located approximately 250 light years from Earth in the constellation Draco. The system, which includes a super-Earth and a sub-Neptune, provides an intrigu…	TOI-1453 system hosts contrasting super-Earth and low-mass sub-Neptuneby Erica MarchandParis, France (SPX) Mar 17, 2025\r\nAstronomers have identified two planets orbiting the star TOI-1453, located ap… [+3234 chars]	https://www.spacedaily.com/reports/TOI_1453_system_hosts_contrasting_super_Earth_and_low_mass_sub_Neptune_999.html	https://www.spxdaily.com/images-hg/extrasolar-spix-hg.jpg	2025-03-17 07:21:03
100	0	13	NewsAPI	'What Your PM Told Me...': Neil deGrasse Tyson On India's Space Dreams	India&#039;s space programme is limited only by the ambition of its people, astrophysicist Neil deGrasse Tyson told NDTV in an interview that began with American astronauts Sunita Williams and Butch Wilmore&#039;s return from a nine-month stay in space.	New Delhi: India's space programme is limited only by the ambition of its people, astrophysicist Neil deGrasse Tyson told NDTV Friday, in a free-wheeling interview that began with American astronauts… [+3230 chars]	https://www.ndtv.com/world-news/neil-degrasse-tyson-ndtv-interview-pm-modi-isro-chandrayaan-3-sunita-williams-return-from-iss-7967666	https://c.ndtvimg.com/2023-06/rnq102go_neil-degrasse-tyson-and-pm-modi_625x300_21_June_23.jpg?im=FeatureCrop,algorithm=dnn,width=1200,height=738	2025-03-20 09:55:17
101	0	13	NewsAPI	Trump and Musk's Planned Mission to Mars Could Actually Happen, Experts Say	Trump aims to send a crew to Mars by the end of his term, which Musk calls 'doable.' Astronauts question the time frame but said a flight would soon be possible	The resoluteness of NASA's ambitious vision to send astronauts to Mars—a round-trip voyage of more than a billion miles once limited to science fiction—appears stronger than ever, albeit not without … [+31294 chars]	https://www.newsweek.com/2025/04/11/donald-trump-elon-musk-space-mission-mars-experts-2053151.html	https://d.newsweek.com/en/full/2617086/fea01-mars-01.jpg	2025-04-02 09:00:02
102	0	13	NewsAPI	Joseph Farrell’s “The Cosmic War”: Did an interplanetary conflict reshape the solar system?	Joseph Farrell’s “The Cosmic War” proposes that myths of godly battles may reflect a real interplanetary conflict fought with advanced technology, altering the solar system. The asteroid belt between Mars and Jupiter could be remnants of a Saturn-sized planet…	<ul><li>Joseph Farrell's "The Cosmic War" proposes that myths of godly battles may reflect a real interplanetary conflict fought with advanced technology, altering the solar system.</li><li>The aster… [+4363 chars]	https://www.naturalnews.com/2025-03-31-did-an-interplanetary-conflict-reshape-solar-system.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/03/solar-system-planets-space-cosmic-earth-mars-jupiter-5.jpg	2025-03-31 06:00:00
103	0	13	NewsAPI	What happens to the human body in deep space?	Bone and muscle deterioration, radiation exposure, vision impairment — these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation. As US astronauts Butch Wilmore and Suni …	As astronauts Butch Wilmore and Suni Williams prepare to return home after nine months aboard the International Space Station (ISS), some of the health risks they've faced are well-documented and man… [+4463 chars]	https://www.digitaljournal.com/world/what-happens-to-the-human-body-in-deep-space/article	https://www.digitaljournal.com/wp-content/uploads/2025/03/46c200d89c9b37dacfd3fb6e9c94ef5021ed7026.jpg	2025-03-18 01:45:29
104	0	13	NewsAPI	foster + partners’ lunar habitats & cai guo-qiang’s fireworks land at EARTH to SPACE festival	from march 28th 2025, the john f. kennedy center in washington dc hosts exhibitions and performances on the natural world.\nThe post foster + partners’ lunar habitats & cai guo-qiang’s fireworks land at EARTH to SPACE festival appeared first on designboom | ar…	EARTH to SPACE festival hosts Foster + Partners and Cai Guo-Qiang\r\nFoster + Partners’ lunar habitats and Cai Guo-Qiang’s fireworks show up at the EARTH to SPACE Festival in the John F. Kennedy Center… [+4846 chars]	https://www.designboom.com/design/foster-partners-lunar-habitats-cai-guo-qiang-fireworks-land-earth-space-festival-03-19-2025/	https://www.designboom.com/twitterimages/uploads/2025/03/foster-partners-lunar-habitats-cai-guo-qiang-fireworks-EARTH-to-SPACE-festival-designboom-fb.jpg	2025-03-19 04:10:55
105	0	13	NewsAPI	Career Spotlight: Scientist (Ages 14-18)	What does a scientist do? Science is about exploring answers to questions. A scientist uses research and evidence to form hypotheses, test variables, and then share their findings. NASA scientists conduct groundbreaking research to answer some of humanity’s m…	Science is about exploring answers to questions. A scientist uses research and evidence to form hypotheses, test variables, and then share their findings.\r\nNASA scientists conduct groundbreaking rese… [+3768 chars]	https://www.nasa.gov/learning-resources/career-spotlight-scientist/	https://www.nasa.gov/wp-content/uploads/2025/01/jason2large.jpg	2025-03-31 17:44:46
116	0.089	15	NewsAPI	'Earth to Space' art festival set to launch at Kennedy Center this week	A nearly month-long mission is ready to lift off, with preparations being made at the Kennedy Center. To be clear, not NASA's Kennedy Space Center, but the Kennedy Center for the Performing Arts.	A nearly month-long space mission is ready to lift off, with final preparations being made at the Kennedy Center.\r\nTo be clear, not NASA's Kennedy Space Center in Florida, but rather the John F. Kenn… [+6881 chars]	http://www.collectspace.com/news/news-032425a-earth-to-space-arts-breaking-sky-festival-kennedy-center.html	https://cdn.mos.cms.futurecdn.net/PyWknMGS9Q6Gn8wuvgag5M-1200-80.jpg	2025-03-25 21:00:00
106	0	13	NewsAPI	'First send Elon Musk's mother to Mars if you want me to...': Neil deGrasse Tyson's jab at SpaceX CEO	Neil deGrasse Tyson has once again taken a jab at tech billionaire and world's richest person Elon Musk. He said that travel to Mars will be considered safe after Elon Musk's mother goes to the red planet. Elon Musk has a very strong obsession with space and …	Neil deGrasse Tyson, an acclaimed astrophysicist, has claimed that Elon Musk's travel to Mars will be deemed safe after tech mogul's mother visits the red planet. Neil deGrasse Tyson doesn't think ve… [+4658 chars]	https://economictimes.indiatimes.com/news/international/global-trends/us-news-elon-musk-mars-humans-first-send-elon-musks-mother-to-mars-if-you-want-me-to-neil-degrasse-tysons-jab-at-spacex-ceo/articleshow/119259573.cms	https://img.etimg.com/thumb/msid-119259725,width-1200,height-630,imgsize-741730,overlay-economictimes/articleshow.jpg	2025-03-20 12:59:00
107	0	13	NewsAPI	Cancer risk for US astronauts Butch Wilmore, Sunita Williams? What we know so far	Astronauts must attend NASA's 45-day post-mission rehabilitation program.	As US astronauts Butch Wilmore and Sunita Williams prepare to return home after nine months aboard the International Space Station (ISS), some of the health risks they've faced are well-documented an… [+2014 chars]	https://economictimes.indiatimes.com/news/international/us/cancer-risk-for-us-astronauts-butch-wilmore-sunita-williams-what-we-know-so-far/articleshow/119168882.cms	https://img.etimg.com/thumb/msid-119169004,width-1200,height-630,imgsize-162214,overlay-economictimes/articleshow.jpg	2025-03-18 15:06:36
108	0	13	NewsAPI	Antarctic bases are hotbeds of stress and violence; space stations could face the same challenges	Earlier this week, reports emerged that a scientist at South Africa's SANAE IV Antarctic research base had accused a colleague of physical assault.	Earlier this week, reports emerged that a scientist at South Africa's SANAE IV Antarctic research base had accused a colleague of physical assault.\r\nWe research Antarctic governance and crime in isol… [+6576 chars]	https://phys.org/news/2025-03-antarctic-bases-hotbeds-stress-violence.html	https://scx2.b-cdn.net/gfx/news/2025/antarctic-bases-are-ho.jpg	2025-03-21 14:40:01
109	0	13	NewsAPI	What happens to the human body in deep space?	Bone and muscle deterioration, radiation exposure, vision impairment—these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation.	Bone and muscle deterioration, radiation exposure, vision impairmentthese are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological to… [+4572 chars]	https://phys.org/news/2025-03-human-body-deep-space.html	https://scx2.b-cdn.net/gfx/news/2025/as-astronauts-butch-wi.jpg	2025-03-18 11:09:30
110	0	14	NewsAPI	Capturing the cosmos on canvas: How art helps scientists and space agencies communicate with the public	Astrophysicist and artist Ed Belbruno explains how art helps scientists communicate their work to the public and even discover solutions to spaceflight and astronomy problems.	For Ed Belbruno the universe around us is more than eye-catching. It's a medium for infinite fine art, an inspiration for artistic renderings that can break boundaries and be used for spacecraft miss… [+6987 chars]	https://www.space.com/space-exploration/capturing-the-cosmos-on-canvas-how-art-helps-scientists-and-space-agencies-communicate-with-the-public	https://cdn.mos.cms.futurecdn.net/kjF4NcjE4fKtTiSwQzAnLk-1200-80.jpg	2025-03-27 14:00:00
111	0	14	NewsAPI	Antarctic bases are hotbeds of stress and violence. Space stations could face the same challenges	Recent allegations of violence at the SANAE IV Antarctic research base highlight the urgent need to improve safety in remote and extreme places.	The South African National Antarctic Expedition research base, SANAE IV, at Vesleskarvet, Queen Maud Land, Antarctica.\n Dr Ross Hofmeyr/Wikimedia, CC BY-SA\r\nEarlier this week, reports emerged that a … [+6373 chars]	https://theconversation.com/antarctic-bases-are-hotbeds-of-stress-and-violence-space-stations-could-face-the-same-challenges-252720	https://images.theconversation.com/files/656505/original/file-20250320-56-22mhep.jpg?ixlib=rb-4.1.0&rect=0%2C23%2C798%2C398&q=45&auto=format&w=1356&h=668&fit=crop	2025-03-20 19:09:31
112	0	14	NewsAPI	Trump and Musk's Planned Mission to Mars Could Actually Happen, Experts Say	Trump aims to send a crew to Mars by the end of his term, which Musk calls 'doable.' Astronauts question the time frame but said a flight would soon be possible	The resoluteness of NASA's ambitious vision to send astronauts to Mars—a round-trip voyage of more than a billion miles once limited to science fiction—appears stronger than ever, albeit not without … [+31294 chars]	https://www.newsweek.com/2025/04/11/donald-trump-elon-musk-space-mission-mars-experts-2053151.html	https://d.newsweek.com/en/full/2617086/fea01-mars-01.jpg	2025-04-02 09:00:02
113	0	14	NewsAPI	Career Spotlight: Scientist (Ages 14-18)	What does a scientist do? Science is about exploring answers to questions. A scientist uses research and evidence to form hypotheses, test variables, and then share their findings. NASA scientists conduct groundbreaking research to answer some of humanity’s m…	Science is about exploring answers to questions. A scientist uses research and evidence to form hypotheses, test variables, and then share their findings.\r\nNASA scientists conduct groundbreaking rese… [+3768 chars]	https://www.nasa.gov/learning-resources/career-spotlight-scientist/	https://www.nasa.gov/wp-content/uploads/2025/01/jason2large.jpg	2025-03-31 17:44:46
114	0	14	NewsAPI	foster + partners’ lunar habitats & cai guo-qiang’s fireworks land at EARTH to SPACE festival	from march 28th 2025, the john f. kennedy center in washington dc hosts exhibitions and performances on the natural world.\nThe post foster + partners’ lunar habitats & cai guo-qiang’s fireworks land at EARTH to SPACE festival appeared first on designboom | ar…	EARTH to SPACE festival hosts Foster + Partners and Cai Guo-Qiang\r\nFoster + Partners’ lunar habitats and Cai Guo-Qiang’s fireworks show up at the EARTH to SPACE Festival in the John F. Kennedy Center… [+4846 chars]	https://www.designboom.com/design/foster-partners-lunar-habitats-cai-guo-qiang-fireworks-land-earth-space-festival-03-19-2025/	https://www.designboom.com/twitterimages/uploads/2025/03/foster-partners-lunar-habitats-cai-guo-qiang-fireworks-EARTH-to-SPACE-festival-designboom-fb.jpg	2025-03-19 04:10:55
115	0	14	NewsAPI	Antarctic bases are hotbeds of stress and violence; space stations could face the same challenges	Earlier this week, reports emerged that a scientist at South Africa's SANAE IV Antarctic research base had accused a colleague of physical assault.	Earlier this week, reports emerged that a scientist at South Africa's SANAE IV Antarctic research base had accused a colleague of physical assault.\r\nWe research Antarctic governance and crime in isol… [+6576 chars]	https://phys.org/news/2025-03-antarctic-bases-hotbeds-stress-violence.html	https://scx2.b-cdn.net/gfx/news/2025/antarctic-bases-are-ho.jpg	2025-03-21 14:40:01
117	0.089	15	NewsAPI	New documentary 'Children of the Sky' asks the bold question: Can we raise kids in space? (op-ed)	A new 28-minute film explores the medical, social, political and ethical challenges of parenthood and child-rearing that truly permanent communities in space will need to solve.	Dave Brody writes and directs space-themed non-fiction documentary television.\r\nThere is much talk lately about cities on Mars, multiple bases on the moon, free orbiting "islands" in space where tens… [+14787 chars]	https://www.space.com/entertainment/new-documentary-children-of-the-sky-asks-the-bold-question-can-we-raise-kids-in-space-op-ed	https://cdn.mos.cms.futurecdn.net/Nvy2utGp4W3SvwAb3TQMoB-1200-80.jpg	2025-03-26 13:00:00
118	0.089	15	NewsAPI	"So Much Good Science": The Black Hole Visuals In Christopher Nolan's $759M Oscar-Nominated Sci-Fi Movie Called "One Of The Most Accurate Depictions Of The Environment" By Expert, Who Gives It A Near-Perfect Score	Christopher Nolan's 2014 sci-fi movie gets analyzed by a real astrophysicist, who sings the movie's praises despite occasional errors.	Christopher Nolan has created some impressive universes over the course of his filmmaking career. These worlds can stem from both the real-world and the sci-fi space, as Nolan has honed his ability t… [+7726 chars]	https://screenrant.com/interstellar-2014-movie-space-science-accuracy-paul-sutter-reaction/	https://static1.srcdn.com/wordpress/wp-content/uploads/2025/01/timothee-chalamet-as-tom-cooper-in-interstellar.jpg	2025-03-25 13:40:22
119	0.089	15	NewsAPI	What Happens To The Human Body In Deep Space?	Bone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation.	Bone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychologica… [+4162 chars]	https://www.ibtimes.com/what-happens-human-body-deep-space-3766639	https://d.ibtimes.com/en/full/4587631/astronauts-butch-wilmore-suni-williams-prepare-return-home-after-nine-months-aboard.jpg	2025-03-18 01:42:21
120	0.089	15	NewsAPI	'What Your PM Told Me...': Neil deGrasse Tyson On India's Space Dreams	India&#039;s space programme is limited only by the ambition of its people, astrophysicist Neil deGrasse Tyson told NDTV in an interview that began with American astronauts Sunita Williams and Butch Wilmore&#039;s return from a nine-month stay in space.	New Delhi: India's space programme is limited only by the ambition of its people, astrophysicist Neil deGrasse Tyson told NDTV Friday, in a free-wheeling interview that began with American astronauts… [+3230 chars]	https://www.ndtv.com/world-news/neil-degrasse-tyson-ndtv-interview-pm-modi-isro-chandrayaan-3-sunita-williams-return-from-iss-7967666	https://c.ndtvimg.com/2023-06/rnq102go_neil-degrasse-tyson-and-pm-modi_625x300_21_June_23.jpg?im=FeatureCrop,algorithm=dnn,width=1200,height=738	2025-03-20 09:55:17
121	0.089	15	NewsAPI	What happens to the human body in deep space?	Bone and muscle deterioration, radiation exposure, vision impairment — these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation. As US astronauts Butch Wilmore and Suni …	As astronauts Butch Wilmore and Suni Williams prepare to return home after nine months aboard the International Space Station (ISS), some of the health risks they've faced are well-documented and man… [+4463 chars]	https://www.digitaljournal.com/world/what-happens-to-the-human-body-in-deep-space/article	https://www.digitaljournal.com/wp-content/uploads/2025/03/46c200d89c9b37dacfd3fb6e9c94ef5021ed7026.jpg	2025-03-18 01:45:29
122	0.089	15	NewsAPI	foster + partners’ lunar habitats & cai guo-qiang’s fireworks land at EARTH to SPACE festival	from march 28th 2025, the john f. kennedy center in washington dc hosts exhibitions and performances on the natural world.\nThe post foster + partners’ lunar habitats & cai guo-qiang’s fireworks land at EARTH to SPACE festival appeared first on designboom | ar…	EARTH to SPACE festival hosts Foster + Partners and Cai Guo-Qiang\r\nFoster + Partners’ lunar habitats and Cai Guo-Qiang’s fireworks show up at the EARTH to SPACE Festival in the John F. Kennedy Center… [+4846 chars]	https://www.designboom.com/design/foster-partners-lunar-habitats-cai-guo-qiang-fireworks-land-earth-space-festival-03-19-2025/	https://www.designboom.com/twitterimages/uploads/2025/03/foster-partners-lunar-habitats-cai-guo-qiang-fireworks-EARTH-to-SPACE-festival-designboom-fb.jpg	2025-03-19 04:10:55
123	0.089	15	NewsAPI	Cancer risk for US astronauts Butch Wilmore, Sunita Williams? What we know so far	Astronauts must attend NASA's 45-day post-mission rehabilitation program.	As US astronauts Butch Wilmore and Sunita Williams prepare to return home after nine months aboard the International Space Station (ISS), some of the health risks they've faced are well-documented an… [+2014 chars]	https://economictimes.indiatimes.com/news/international/us/cancer-risk-for-us-astronauts-butch-wilmore-sunita-williams-what-we-know-so-far/articleshow/119168882.cms	https://img.etimg.com/thumb/msid-119169004,width-1200,height-630,imgsize-162214,overlay-economictimes/articleshow.jpg	2025-03-18 15:06:36
124	0.089	15	NewsAPI	What happens to the human body in deep space?	Bone and muscle deterioration, radiation exposure, vision impairment—these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation.	Bone and muscle deterioration, radiation exposure, vision impairmentthese are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological to… [+4572 chars]	https://phys.org/news/2025-03-human-body-deep-space.html	https://scx2.b-cdn.net/gfx/news/2025/as-astronauts-butch-wi.jpg	2025-03-18 11:09:30
125	0.089	15	NewsAPI	What Happens To The Human Body In Deep Space?	Bone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation.	Bone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychologica… [+4162 chars]	https://www.ibtimes.com.au/what-happens-human-body-deep-space-1856981	https://d.ibtimes.com.au/en/full/1876229/astronauts-butch-wilmore-suni-williams-prepare-return-home-after-nine-months-aboard.jpg	2025-03-18 11:56:34
126	0.089	15	NewsDATA	I’m headed to STARMUS La Palma 2025, where curious minds will gather under one of the darkest skies on Earth	STARMUS La Palma 2025 is set to unite space, science and stargazing with presentations and concerts under some of the darkest skies in the world.	ONLY AVAILABLE IN PAID PLANS	https://www.space.com/why-i-am-heading-to-starmus-la-palma-2025-festival-celebrating-space	https://cdn.mos.cms.futurecdn.net/XMdemiL52GZ9GavFJ8PfMG.jpg	2025-04-13 13:00:00
127	0.089	15	NewsDATA	'We're bringing a little spice to space!' Katy Perry and Lauren Sanchez pose in their bodycon suits designed by Jeff Bezos' wife and her Met Gala team as they prepare for their 11 minute all-female Blue Origin mission	Katy Perry looked ready for action on Sunday as she posed alongside Lauren Sánchez in their bodycon space outfits ahead of their Blue Origin space mission on Monday.	ONLY AVAILABLE IN PAID PLANS	https://www.dailymail.co.uk/tvshowbiz/article-14604229/Were-bringing-little-spice-space-Katy-Perry-Lauren-Sanchez-pose-bodycon-suits-designed-Jeff-Bezos-wife-Met-Gala-team-prepare-11-minute-female-Blue-Origin-mission.html	https://i.dailymail.co.uk/1s/2025/04/13/11/97222287-0-image-a-53_1744540364445.jpg	2025-04-13 10:42:41
128	0	15	NewsAPI	Capturing the cosmos on canvas: How art helps scientists and space agencies communicate with the public	Astrophysicist and artist Ed Belbruno explains how art helps scientists communicate their work to the public and even discover solutions to spaceflight and astronomy problems.	For Ed Belbruno the universe around us is more than eye-catching. It's a medium for infinite fine art, an inspiration for artistic renderings that can break boundaries and be used for spacecraft miss… [+6987 chars]	https://www.space.com/space-exploration/capturing-the-cosmos-on-canvas-how-art-helps-scientists-and-space-agencies-communicate-with-the-public	https://cdn.mos.cms.futurecdn.net/kjF4NcjE4fKtTiSwQzAnLk-1200-80.jpg	2025-03-27 14:00:00
129	0	15	NewsAPI	I’m headed to STARMUS La Palma 2025, where curious minds will gather under one of the darkest skies on Earth	STARMUS La Palma 2025 is set to unite space, science and stargazing with presentations and concerts under some of the darkest skies in the world.	In just a couple of weeks, I'll be packing my bags and heading to a beautiful island just off the coast of northwestern Africa shaped by volcanic activity and dense, forested terrain. However, while … [+3668 chars]	https://www.space.com/why-i-am-heading-to-starmus-la-palma-2025-festival-celebrating-space	https://cdn.mos.cms.futurecdn.net/XMdemiL52GZ9GavFJ8PfMG-1200-80.jpg	2025-04-13 13:00:00
130	0	15	NewsAPI	What happens to the human body in deep space?	Washington (AFP) Mar 18, 2025\n\n\n Bone and muscle deterioration, radiation exposure, vision impairment - these are just a few of the challenges space travelers face on long-duration missions, even before considering the psychological toll of isolation. \n\nAs US…	What happens to the human body in deep space?By Issam AHMEDWashington (AFP) Mar 18, 2025\r\nBone and muscle deterioration, radiation exposure, vision impairment -- these are just a few of the challenge… [+4348 chars]	https://www.spacedaily.com/reports/What_happens_to_the_human_body_in_deep_space_999.html	https://www.spxdaily.com/images-hg/female-astronaut-jessica-meir-caves-shirt-international-space-station-hg.jpg	2025-03-18 10:13:19
131	0	15	NewsAPI	Antarctic bases are hotbeds of stress and violence. Space stations could face the same challenges	Recent allegations of violence at the SANAE IV Antarctic research base highlight the urgent need to improve safety in remote and extreme places.	The South African National Antarctic Expedition research base, SANAE IV, at Vesleskarvet, Queen Maud Land, Antarctica.\n Dr Ross Hofmeyr/Wikimedia, CC BY-SA\r\nEarlier this week, reports emerged that a … [+6373 chars]	https://theconversation.com/antarctic-bases-are-hotbeds-of-stress-and-violence-space-stations-could-face-the-same-challenges-252720	https://images.theconversation.com/files/656505/original/file-20250320-56-22mhep.jpg?ixlib=rb-4.1.0&rect=0%2C23%2C798%2C398&q=45&auto=format&w=1356&h=668&fit=crop	2025-03-20 19:09:31
132	0	15	NewsAPI	If You Miss The Expanse & Wish Season 7 Was Happening Like I Do, Watch These 5 Sci-Fi TV Shows On Streaming	Although nothing would be better than actually getting The Expanse season 7, these other sci-fi TV shows available on streaming are worth watching.	Its a real shame The Expanseseason 7 isnt happening, and Im disappointed about that, but there sci-fi TV shows are available on streaming services to help fill the gap. The Expanse season 7 is an ins… [+6206 chars]	https://screenrant.com/the-expanse-season-7-similar-tv-shows-streaming-recommendation/	https://static1.srcdn.com/wordpress/wp-content/uploads/2025/03/if-you-miss-the-expanse-wish-season-7-was-happening-like-i-do-watch-these-5-sci-fi-tv-shows-on-streaming.jpg	2025-03-23 19:40:13
133	0	15	NewsAPI	TOI-1453 system hosts contrasting super-Earth and low-mass sub-Neptune	Paris, France (SPX) Mar 17, 2025\n\n\nAstronomers have identified two planets orbiting the star TOI-1453, located approximately 250 light years from Earth in the constellation Draco. The system, which includes a super-Earth and a sub-Neptune, provides an intrigu…	TOI-1453 system hosts contrasting super-Earth and low-mass sub-Neptuneby Erica MarchandParis, France (SPX) Mar 17, 2025\r\nAstronomers have identified two planets orbiting the star TOI-1453, located ap… [+3234 chars]	https://www.spacedaily.com/reports/TOI_1453_system_hosts_contrasting_super_Earth_and_low_mass_sub_Neptune_999.html	https://www.spxdaily.com/images-hg/extrasolar-spix-hg.jpg	2025-03-17 07:21:03
134	0	15	NewsAPI	Joseph Farrell’s “The Cosmic War”: Did an interplanetary conflict reshape the solar system?	Joseph Farrell’s “The Cosmic War” proposes that myths of godly battles may reflect a real interplanetary conflict fought with advanced technology, altering the solar system. The asteroid belt between Mars and Jupiter could be remnants of a Saturn-sized planet…	<ul><li>Joseph Farrell's "The Cosmic War" proposes that myths of godly battles may reflect a real interplanetary conflict fought with advanced technology, altering the solar system.</li><li>The aster… [+4363 chars]	https://www.naturalnews.com/2025-03-31-did-an-interplanetary-conflict-reshape-solar-system.html	https://www.naturalnews.com/wp-content/uploads/sites/91/2025/03/solar-system-planets-space-cosmic-earth-mars-jupiter-5.jpg	2025-03-31 06:00:00
135	0	15	NewsAPI	Trump and Musk's Planned Mission to Mars Could Actually Happen, Experts Say	Trump aims to send a crew to Mars by the end of his term, which Musk calls 'doable.' Astronauts question the time frame but said a flight would soon be possible	The resoluteness of NASA's ambitious vision to send astronauts to Mars—a round-trip voyage of more than a billion miles once limited to science fiction—appears stronger than ever, albeit not without … [+31294 chars]	https://www.newsweek.com/2025/04/11/donald-trump-elon-musk-space-mission-mars-experts-2053151.html	https://d.newsweek.com/en/full/2617086/fea01-mars-01.jpg	2025-04-02 09:00:02
136	0.17	16	NewsAPI	Welcoming Science: CGIAR Week-Long Focus on Innovation for Food, Climate-Secure Future	The world’s leading scientists and decision-makers in agriculture, climate, and health are meeting in Nairobi this week to promote innovation and partnerships towards a food, nutrition, and climate-secure future. As current agrifood systems buckle under multi…	Africa, Biodiversity, Civil Society, Climate Action, Climate Change, Development &amp; Aid, Economy &amp; Trade, Editors' Choice, Environment, Featured, Food and Agriculture, Food Security and Nutrit… [+9273 chars]	https://www.ipsnews.net/2025/04/welcoming-science-week-long-focus-innovation-food-climate-secure-future/	https://www.ipsnews.net/Library/2025/04/CGIAR-and-the-Kenyan-Agricultural-and-Livestock-Research-Organization-KALRO-have-convened-the-very-first-CGIAR-Science-Week-April-7-to-12-2025.-Photo-Joyce-Chimbi.jpg	2025-04-07 16:01:30
137	0.17	16	NewsAPI	Insight to Impact: CGIAR Inaugural Flagship Report for Decision Makers Navigating Food System Science	“To have impact, it was crucial to understand what impact was wanted,” CGIAR’s Executive Managing Director Dr. Ismahane Elouafi said at the launch of the organization’s flagship report, Insight to Impact: A decision-maker’s guide to navigating food system sci…	Africa, Biodiversity, Climate Action, Climate Change, Cooperatives, Development &amp; Aid, Economy &amp; Trade, Editors' Choice, Featured, Food and Agriculture, Food Systems, Global, Headlines, Human… [+6301 chars]	https://www.ipsnews.net/2025/04/insight-to-impact-cgiar-inaugural-flagship-report-for-decision-makers-navigating-food-system-science/	https://www.ipsnews.net/Library/2025/04/EMD-e1744303651570.jpg	2025-04-10 16:52:29
138	0.08	16	NewsAPI	Nature Is Medicine: A Doctor’s Call To Rethink Health In The Age Of Climate Change	After decades in medicine, I’ve come to see something fundamental: the health of our planet and the health of our people are inseparable.	What if the most powerful medicine we have isnt found in a pill or a procedurebut in the soil beneath our feet, the air we breathe, and the trees outside our window?\r\nAfter decades in medicineas a he… [+6944 chars]	https://www.forbes.com/sites/billfrist/2025/04/07/nature-is-medicine-a-doctors-call-to-rethink-health-in-the-age-of-climate-change/	https://imageio.forbes.com/specials-images/imageserve/67f42512d71c7d033a1eed0f/0x0.jpg?format=jpg&height=900&width=1600&fit=bounds	2025-04-07 20:22:21
139	0.08	16	NewsAPI	2025 SkS Weekly Climate Change & Global Warming News Roundup #11	A listing of 26 news and opinion articles we found interesting and shared on social media during the past week: Sun, March 9, 2025 thru Sat, March 15, 2025.\nThis week's roundup is again published by category and sorted by number of articles included in each. …	Posted on 16 March 2025 by BaerbelW, Doug Bostrom, John Hartz\r\nA listing of 26 news and opinion articles we found interesting and shared on social media during the past week: Sun, March 9, 2025 thru … [+6635 chars]	https://skepticalscience.com/2025-SkS-Weekly-News-Roundup_11.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-03-16 08:23:56
140	0.08	16	NewsAPI	Some US Scientists Stick with the IPCC Despite the Administration Pulling Out of International Climate Work	A handful of U.S. researchers joined a critical meeting on climate and cities this week in Japan. “For me, this process is so important that if I had to self-fund, I would,” said one.	Despite a series of directives from the Trump administration aimed at disengaging the U.S. government from international climate collaboration, five U.S. scientists are part of the Intergovernmental … [+14304 chars]	https://insideclimatenews.org/news/15032025/us-ipcc-scientific-authors-climate-report/	https://insideclimatenews.org/wp-content/uploads/2025/03/IPCC-Osaka.jpg	2025-03-18 05:47:01
141	0.08	16	NewsAPI	Engineering hope: how I made it my mission to help rebuild Ukraine’s critical infrastructure	Bridges are not just engineering projects, they are lifelines.	The war in Ukraine is often marked by specific dates, like February 24, 2022 – the day of the full-scale invasion. But for many Ukrainians, that February never really ended. For me, then a 22-year-ol… [+21353 chars]	https://theconversation.com/engineering-hope-how-i-made-it-my-mission-to-help-rebuild-ukraines-critical-infrastructure-251857	https://images.theconversation.com/files/658022/original/file-20250327-56-v70gth.jpg?ixlib=rb-4.1.0&rect=0%2C1340%2C7972%2C3986&q=45&auto=format&w=1356&h=668&fit=crop	2025-04-02 13:02:31
142	0.08	16	NewsAPI	Trump Wants to Convince the World That Climate Change Is a Good Thing	The president, who regularly attacks renewable energy, is apparently ready to argue that climate change would benefit humans	Windmills cause cancer. They’re killing birds and whales. Electric vehicles don’t work. Have you heard about the electric sharks? Climate changeis a hoax. There are many things Donald Trump has said … [+6336 chars]	http://www.rollingstone.com/politics/politics-features/trump-convince-world-climate-change-good-1235306675/	https://www.rollingstone.com/wp-content/uploads/2025/03/cilmate-change-trump.jpg?crop=0px%2C11px%2C1798px%2C1014px&resize=1600%2C900	2025-03-31 14:20:17
143	0.08	16	NewsDATA	Coastal economies rely on NOAA, from Maine to Florida, Texas and Alaska – even if they don’t realize it	NOAA’s work has kept fisheries from collapsing, helped coastal ecosystems survive extreme heat and battled invasive species, among many other tasks essential to coastal economies.	ONLY AVAILABLE IN PAID PLANS	https://ca.news.yahoo.com/coastal-economies-rely-noaa-maine-003947865.html	https://s.yimg.com/ny/api/res/1.2/9ZaAJtM7AYQixOSR_0Fj5w--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03ODg-/https://media.zenfs.com/en/the_conversation_us_articles_815/e49afecf5ac6581bd8d66565741627a4	2025-04-14 00:39:47
144	0.08	16	NewsDATA	Saving traditional varieties of seeds	At a time when extreme weather events are threatening food production, we are sidelining the very varieties that can withstand droughts, floods, and replenish depleted soils	ONLY AVAILABLE IN PAID PLANS	https://www.thehindu.com/opinion/op-ed/saving-traditional-varieties-of-seeds/article69446064.ece	https://th-i.thgim.com/public/latest-news/1ak5di/article69447312.ece/alternates/LANDSCAPE_1200/MSSRF%E2%80%99s%20Tribal%20Agrobiodiversity%20Centre%20in%20Jeypore%20Odisha.jpg	2025-04-13 18:45:00
145	0	16	NewsAPI	'Their loss diminishes us all': Scientists emphasize how Trump's mass NOAA layoffs endanger the world	"From our perspective down in the trenches actually working for the government, it feels like the people up top just have no clue about anything."	For decades, the U.S. National Oceanic and Atmospheric Administration (NOAA) has been the beating heart of weather forecasts that keep our society safe.\r\nIts employees regularly collect weather data … [+16656 chars]	https://www.space.com/the-universe/earth/their-loss-diminishes-us-all-scientists-emphasize-how-trumps-mass-noaa-layoffs-endanger-the-world	https://cdn.mos.cms.futurecdn.net/xAV5ZavxejZKZKojBWJsaD-1200-80.jpg	2025-03-14 09:00:00
146	0	16	NewsAPI	Telling the Bees	Bees have long been witness to human grief, carrying messages between the living and the dead. Finding solace in the company of bees, Emily Polk opens to the widening circles of loss around her and an enduring spirit of survival.	Listen to this StoryNarrated by Emily Polk\r\nContributor BiosEmily Polk lives and writes on a small island east of San Francisco and teaches environmental writing at Stanford University. Her writing a… [+26348 chars]	https://emergencemagazine.org/essay/telling-the-bees/	https://emergencemagazine.org/app/uploads/2025/02/Telling_the_Bees_SEO.jpg	2025-04-09 19:49:37
147	0	16	NewsAPI	Skeptical Science New Research for Week #12 2025	Open access notables\nThe severe 2020 coral bleaching event in the tropical Atlantic linked to marine heatwaves, Rodrigues et al., Communications Earth & Environment:\n\nMarine heatwaves can amplify the vulnerabilities of regional marine ecosystems and jeopardis…	Posted on 20 March 2025 by Doug Bostrom, Marc Kodack\r\nOpen access notables\r\nThe severe 2020 coral bleaching event in the tropical Atlantic linked to marine heatwaves, Rodrigues et al., Communications… [+41403 chars]	https://skepticalscience.com/new_research_2025_12.html	https://skepticalscience.com/public/assets/images/og/button_sks_200.jpg	2025-03-20 06:36:20
148	0	16	NewsAPI	Weekly Climate and Energy News Roundup #635	Quote of the Week: “Beware the Ides of March” — Soothsayer to Julius Caesar by William Shakespeare.	Quote of the Week:Beware the Ides of March\r\n Soothsayer to Julius Caesar by William Shakespeare.\r\nNumber of the Week: Tripled in 60 years\r\nTHIS WEEK:\r\nBy Ken Haapala, President, Science and Environme… [+66587 chars]	https://wattsupwiththat.com/2025/03/17/weekly-climate-and-energy-news-roundup-635/	https://i0.wp.com/wattsupwiththat.com/wp-content/uploads/2025/03/charlesrotter_a_sharp_scenic_photo_of_glacier_bay_midjouney.webp?fit=1024%2C512&ssl=1	2025-03-17 09:00:00
149	0	16	NewsAPI	Ferrets, water testing and future scientists at risk due to DOGE spending cuts	Interior Department employees say they have been scrambling to keep the lights on and do their jobs as budget cuts driven by the Department of Government efficiency team start to bite.	The National Black-Footed Ferret Conservation Center in Carr, Colo., is at risk of losing heat and power as its remaining employees rush to prepare for the animal's breeding season.\r\nA federal mainte… [+12086 chars]	https://www.npr.org/2025/03/20/nx-s1-5333655/interior-department-budget-cuts-doge	https://npr.brightspotcdn.com/dims3/default/strip/false/crop/3150x1772+0+0/resize/1400/quality/100/format/jpeg/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2F6b%2F61%2F635fff154b9baa59363b719fcf82%2Fbff-clone-noreen-1-credit-kika-tuff-revive-restore.jpg	2025-03-20 09:00:00
150	0	16	NewsAPI	Pesticide concerns for COP30 host Brazil	Pesticide concerns for COP30 host Brazil\n\n \n Channel\n News\n \nbrendan\n20th March 2025\n\n\n \n Teaser Media	Dr Ferrante, a renowned Brazilian scientist and advocate for sustainable trade, has been at the forefront of international discussions, raising these pressing concerns to ensure that Brazil aligns wi… [+3404 chars]	https://theecologist.org/2025/mar/20/pesticide-concerns-cop30-host-brazil	https://theecologist.org/sites/default/files/styles/facebook/public/2025-03/53368624410_f0de456bfe_k.jpg?h=a1e1a043&itok=mgXwppKO	2025-03-20 07:00:00
151	0	16	NewsAPI	India plans study on detection of zoonotic diseases that could spill over from birds to humans	India is launching a major study to detect zoonotic diseases in select bird sanctuaries across Sikkim, Maharashtra, and Tamil Nadu. Using the One Health approach, the study aims to monitor human populations, migratory birds, and their environment. This initia…	India is set to begin an ambitious, inter-ministerial scientific study aimed at detecting zoonotic diseases that could spill over from birds to humans. The first-of-its-kind study, 'Building a survei… [+4046 chars]	https://economictimes.indiatimes.com/news/india/india-plans-study-on-detection-of-zoonotic-diseases-that-could-spill-over-from-birds-to-humans/articleshow/119983693.cms	https://img.etimg.com/thumb/msid-119983723,width-1200,height-630,imgsize-64384,overlay-economictimes/articleshow.jpg	2025-04-04 13:50:34
152	0	16	NewsAPI	The Great Spring 2025 Preview	It’s been a painfully long winter here in New York City, but the glinting promise of spring—and spring books—has bolstered me through these cold, hard months. Here you’ll find just over 100 titles that we’re looking forward to here at The Millions. Some we’ve…	It’s been a painfully long winter here in New York City, but the glinting promise of springand spring bookshas bolstered me through these cold, hard months. Here youll find just over 100 titles that … [+32937 chars]	https://themillions.com/2025/04/the-great-spring-2025-preview.html	https://themillions.com/wp-content/uploads/2025/04/Screen-Shot-2025-04-08-at-12.01.16-PM-1024x570.png	2025-04-11 16:40:19
153	0	16	NewsAPI	How repairing peat could prevent Glasgow's tap water turning brown	Scottish Water is restoring 400 hectares of degraded peat around Loch Katrine which feeds the city's drinking water.	Kevin KeaneBBC Scotland's environment correspondent\r\nReporting from\r\nLoch Katrine\r\nOrganic matter from degraded peat can discolour the water which runs into Loch Katrine\r\nHundreds of hectares of peat… [+4027 chars]	https://www.bbc.com/news/articles/c871nq9j7d8o	https://ichef.bbci.co.uk/news/1024/branded_news/b81b/live/3275be50-070a-11f0-9c05-777b0d061377.jpg	2025-03-26 22:50:52
154	0	16	NewsAPI	Who is Sam Jones, the influencer who grabbed an Australian baby wombat from its mom?	A now viral video of an American wildlife influencer snatching a baby wombat from its mother on camera during a visit to Australia has caused outraged officials.	A video of an American wildlife influencer grabbing a baby wombat away from its mother and holding it up to a camera during a visit to Australia has outraged the nation's politicians and conservation… [+5425 chars]	https://www.today.com/news/who-is-sam-jones-baby-wombat-rcna196406	https://media-cldnry.s-nbcnews.com/image/upload/t_social_share_1200x630_center,f_auto,q_auto:best/rockcms/2025-03/baby-wombat-mc-250314-2d28ee.jpg	2025-03-14 16:11:36
155	0	16	NewsAPI	Acid Rain	Acid precipitation, also known as acid rain, is any form of precipitation—snow, rain, sleet, or hail—that contains a heavy concentration of sulfuric and nitric acids. Automobiles, certain industrial operations, and electric power plants that burn fossil fuels…	For other uses, see Acid rain (disambiguation).\r\nAcid rain is a rain or any other form of precipitation that is unusually acidic, meaning that it possesses elevated levels of hydrogen ions (low pH). … [+30733 chars]	https://encyclopedia.thefreedictionary.com/acid+rain	http://img.tfd.com/TFDlogo1200x1200.png	2025-04-09 04:10:46
\.


--
-- Data for Name: fav_articles; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.fav_articles (id, score, question_id, obj_id, api_source, title, description, content, url, "urlToImage", "publishedAt") FROM stdin;
\.


--
-- Data for Name: fav_videos; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.fav_videos (id, obj_id, question_id, video_id, description, thumbnail) FROM stdin;
\.


--
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.favourites (id, entity_id, entity_type) FROM stdin;
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.questions (id, topic_id, text, keywords) FROM stdin;
2	1	What are the most effective strategies for communicating climate risks to diverse communities?	communicating climate risks, effective strategies, diverse communities
3	1	How can we accurately predict and manage the ecological impacts of extreme weather events?	extreme weather events, ecological impacts, accurately predict, manage
4	2	How can we ensure AI education adapts to rapidly evolving models and techniques?	rapidly evolving models, techniques
5	2	What formal methods can guarantee safety and ethical alignment in complex AI systems?	complex ai systems, guarantee safety, formal methods, ethical alignment
6	2	How will AI impact CS curricula, and what new skills must we teach students?	new skills must, teach students
7	3	How will proposed reforms impact healthcare access for vulnerable populations, and what mitigation strategies are needed?	vulnerable populations, mitigation strategies, needed
8	3	What are the projected long-term impacts of healthcare reform on national health expenditures and economic productivity?	national health expenditures, term impacts, projected long, healthcare reform, economic productivity
9	3	How do proposed reforms balance cost containment with maintaining or improving the quality of care and patient outcomes?	patient outcomes, quality, maintaining, improving, care
10	4	How do tax policies impact income distribution and overall economic efficiency?	overall economic efficiency
11	4	What are the long-term effects of wealth concentration on economic growth?	wealth concentration, term effects, economic growth, long
12	4	To what extent does unequal access to education perpetuate income disparities?	unequal access, extent
13	5	How can space-based telescopes better characterize exoplanet atmospheres for biosignatures?	space, biosignatures
14	5	What novel propulsion methods could drastically reduce interstellar travel times for scientific missions?	scientific missions
15	5	How does the increasing space debris population impact long-term astronomical observation capabilities?	
16	1	How can we accurately measure the long-term impact of climate change on specific, vulnerable ecosystems?	vulnerable ecosystems, term impact, climate change, accurately measure, specific
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.topics (id, title, role) FROM stdin;
1	Climate Change	Environmental Scientist
2	Artificial Intelligence	Computer Science Professor
3	Healthcare Reform	Health Policy Analyst
4	Economic Inequality	Economist
5	Space Exploration	Astrophysicist
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.users (id, username, email, password_hash, created_at, is_active) FROM stdin;
1	will	wfotso21@gmail.com	scrypt:32768:8:1$QPAl9n9f8mcuFjUN$588cb8782a104814104559278d30b7a15d145e1604cc8ab1a7395bb02e372504ad758bf6181d1b2be006ef3c98b9d823fe519b2c21f15f1ef04990d37be34f73	2025-04-15 03:27:14.244024	t
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: will
--

COPY public.videos (id, question_id, video_id, description, thumbnail) FROM stdin;
6	2	BdO4ABGjAtY	Work Towards Understanding & Solving Climate Change By Applying Now.	https://i.ytimg.com/vi/BdO4ABGjAtY/hqdefault.jpg
7	2	I87Qndgp0uM	Here's your Monday news breakdown of last week's top stories from Mongabay. View the full stories at Mongabay.com. #oceans ...	https://i.ytimg.com/vi/I87Qndgp0uM/hqdefault.jpg
8	2	G4H1N_yXBiA	What causes climate change (also known as global warming)? And what are the effects of climate change? Learn the human ...	https://i.ytimg.com/vi/G4H1N_yXBiA/hqdefault.jpg
9	2	yhW3_bNxUNg	The climate change movement must embrace diverse perspectives from marginalized communities in order to advance its goals.	https://i.ytimg.com/vi/yhW3_bNxUNg/hqdefault.jpg
10	3	CzdZcYou8KA	From the Scripps Institution of Oceanography Extreme Climate Workshop held Dec. 13, 2011. Vulnerability and Adaptation to ...	https://i.ytimg.com/vi/CzdZcYou8KA/hqdefault.jpg
11	3	pRcIKyU3DXQ	This EIA Community Debate explores how climate and extreme weather resilience can be considered at the design stage for ...	https://i.ytimg.com/vi/pRcIKyU3DXQ/hqdefault.jpg
12	3	NOSt_WW3UVA	Explore the connection between climate change and extreme weather events. Experts discuss the increasing frequency and ...	https://i.ytimg.com/vi/NOSt_WW3UVA/hqdefault.jpg
13	3	ArC60_PhWIA	Katharine Hayhoe, a climate scientist, talks about how climate change impacts extreme weather. #foxweather #climatechange ...	https://i.ytimg.com/vi/ArC60_PhWIA/hqdefault.jpg
14	3	2njn71TqkjA	What could our future world look like if we continue to do nothing about climate change? Take a look at the possibilities. -- While ...	https://i.ytimg.com/vi/2njn71TqkjA/hqdefault.jpg
15	4	N7gCq5b9-dw	Synthetic Intelligence Forum convened a masterclass on computational chemistry and machine learning by Professor Alán ...	https://i.ytimg.com/vi/N7gCq5b9-dw/hqdefault.jpg
16	4	_6R7Ym6Vy_I	How are technologies like ChatGPT created? And what does the future hold for AI language models? This talk was filmed at the ...	https://i.ytimg.com/vi/_6R7Ym6Vy_I/hqdefault.jpg
17	4	4RixMPF4xis	Learn more about watsonx: https://ibm.biz/BdvxDS What is really the difference between Artificial intelligence (AI) and machine ...	https://i.ytimg.com/vi/4RixMPF4xis/hqdefault.jpg
18	4	-8tpLhl2ZG4	Artificial Intelligence (AI) may not be up for the Fields Medal (mathematics' Nobel Prize) any time soon, but it may act as an ...	https://i.ytimg.com/vi/-8tpLhl2ZG4/hqdefault.jpg
19	5	HXYw38NoAK8	Amal Iyer, Sr. Staff AI Scientist at Fiddler AI, discusses the need to shift focus from the capabilities of ML models to considering ...	https://i.ytimg.com/vi/HXYw38NoAK8/hqdefault.jpg
20	5	HnzXHbkP-E0	Reflections on how we should align AI in moral dilemmas such as the trolley problem: should we kill one person to save five ...	https://i.ytimg.com/vi/HnzXHbkP-E0/hqdefault.jpg
21	5	5-hiClFT7Pw	James Zou, Assistant Professor of Biomedical Data Science and of Computer Science & Electrical Engineering, Stanford ...	https://i.ytimg.com/vi/5-hiClFT7Pw/hqdefault.jpg
22	5	vyuEWEI6qaA	By 2030, millions of AI agents will be deployed, operating autonomously. While this will make some processes more efficient, ...	https://i.ytimg.com/vi/vyuEWEI6qaA/hqdefault.jpg
23	5	5mXZDyIZtaM	Why are we now talking about alignment in AI and why is it important? Alignment has become important in AI because we can no ...	https://i.ytimg.com/vi/5mXZDyIZtaM/hqdefault.jpg
24	6	ogcSQ-cFRVM	The emergence of ChatGPT in November of 2022 took the world by storm: particularly the world of education. With this technology ...	https://i.ytimg.com/vi/ogcSQ-cFRVM/hqdefault.jpg
25	6	hJP5GqnTrNo	Sal Khan, the founder and CEO of Khan Academy, thinks artificial intelligence could spark the greatest positive transformation ...	https://i.ytimg.com/vi/hJP5GqnTrNo/hqdefault.jpg
26	6	JMLsHI8aV0g	A growing number of classrooms in China are equipped with artificial-intelligence cameras and brain-wave trackers. While many ...	https://i.ytimg.com/vi/JMLsHI8aV0g/hqdefault.jpg
27	6	KKNCiRWd_j0	When it comes to artificial intelligence, what are we actually creating? Even those closest to its development are struggling to ...	https://i.ytimg.com/vi/KKNCiRWd_j0/hqdefault.jpg
28	6	KG4_CYbVpTo	Add AI Tools at any part of your teaching routine. From lesson planning, presenting, and to automating tasks, AI can help! Watch to ...	https://i.ytimg.com/vi/KG4_CYbVpTo/hqdefault.jpg
29	7	WHPYFgIxRKM	While significant attention has been paid to shifts in national health policy, it is equally important to understand the promise, ...	https://i.ytimg.com/vi/WHPYFgIxRKM/hqdefault.jpg
30	7	0FXa9SJM-EQ	Health Systems Architect Jonathan Gruber provides a detailed and emotional perspective evaluating the implications of health ...	https://i.ytimg.com/vi/0FXa9SJM-EQ/hqdefault.jpg
31	7	7UySIA_qwEY	Michael Cannon argues that we must put healthcare consumers in control to drive down costs and improve quality. Any efforts to ...	https://i.ytimg.com/vi/7UySIA_qwEY/hqdefault.jpg
32	7	7fYJgN0pysQ	Health Care Outlook” is an expert series featuring Johns Hopkins Nursing faculty members who are redefining nursing through ...	https://i.ytimg.com/vi/7fYJgN0pysQ/hqdefault.jpg
33	7	RCfKSe7BtrA	Sask Budget 2018: health policy analyst on what the government can do to improve our health care system.	https://i.ytimg.com/vi/RCfKSe7BtrA/hqdefault.jpg
34	8	IrTzZ6nml90	For more information, go to http://informationstation.org/	https://i.ytimg.com/vi/IrTzZ6nml90/hqdefault.jpg
35	8	vowTLTCRgCY	Thomas Zenty, CEO of University Hospitals discusses the impact of healthcare reform on health systems, hospitals and patient ...	https://i.ytimg.com/vi/vowTLTCRgCY/hqdefault.jpg
36	8	9hdXDEgQB7Q	Watch more Politics 101 videos: http://www.howcast.com/videos/420378-How-to-Understand-Health-Care-Reform Wondering ...	https://i.ytimg.com/vi/9hdXDEgQB7Q/hqdefault.jpg
37	8	0FXa9SJM-EQ	Health Systems Architect Jonathan Gruber provides a detailed and emotional perspective evaluating the implications of health ...	https://i.ytimg.com/vi/0FXa9SJM-EQ/hqdefault.jpg
38	8	-LqNWKC6pf0	Healthcare has undergone several changes over the past couple years, and according to Jennifer Gillespie, FSA, those changes ...	https://i.ytimg.com/vi/-LqNWKC6pf0/hqdefault.jpg
39	9	tgEwtUmkbEA	2021 Institute for Healthcare Improvement. IHI's Don Berwick explains why ignoring health care policy isn't an option for clinicians ...	https://i.ytimg.com/vi/tgEwtUmkbEA/hqdefault.jpg
40	9	gCrnngzaJnk	Whether you already have health insurance or will soon be shopping for coverage through one of the insurance exchanges, what ...	https://i.ytimg.com/vi/gCrnngzaJnk/hqdefault.jpg
41	9	GSUusjmklU4	The Affordable Care Act and health care reform explained in a short video.	https://i.ytimg.com/vi/GSUusjmklU4/hqdefault.jpg
42	9	IrTzZ6nml90	For more information, go to http://informationstation.org/	https://i.ytimg.com/vi/IrTzZ6nml90/hqdefault.jpg
43	9	RCfKSe7BtrA	Sask Budget 2018: health policy analyst on what the government can do to improve our health care system.	https://i.ytimg.com/vi/RCfKSe7BtrA/hqdefault.jpg
44	10	0xMCWr0O3Hs	Inequality is a big, big subject. There's racial inequality, gender inequality, and lots and lots of other kinds of inequality. This is ...	https://i.ytimg.com/vi/0xMCWr0O3Hs/hqdefault.jpg
45	10	I9yDGdf_tNA	How much biological advantage will money buy in the future? As new technologies offer more advanced 'body upgrades', we ...	https://i.ytimg.com/vi/I9yDGdf_tNA/hqdefault.jpg
46	10	rEnf_CFoyv0	Explore how economic inequality can be measured and how it is impacted by different governmental policy choices. -- Income ...	https://i.ytimg.com/vi/rEnf_CFoyv0/hqdefault.jpg
47	11	rEnf_CFoyv0	Explore how economic inequality can be measured and how it is impacted by different governmental policy choices. -- Income ...	https://i.ytimg.com/vi/rEnf_CFoyv0/hqdefault.jpg
48	11	0xMCWr0O3Hs	Inequality is a big, big subject. There's racial inequality, gender inequality, and lots and lots of other kinds of inequality. This is ...	https://i.ytimg.com/vi/0xMCWr0O3Hs/hqdefault.jpg
49	11	ouhJrEcrCzQ	Thomas Piketty of the Paris School of Economics, tells The CORE Project what long-run data into the distribution of wealth tells us ...	https://i.ytimg.com/vi/ouhJrEcrCzQ/hqdefault.jpg
50	11	cZ7LzE3u7Bw	http://www.ted.com We feel instinctively that societies with huge income gaps are somehow going wrong. Richard Wilkinson ...	https://i.ytimg.com/vi/cZ7LzE3u7Bw/hqdefault.jpg
51	11	rmF7uJaf1ho	Many people believe that poverty and inequality (economic inequality, income inequality and so on) are the same thing but... well, ...	https://i.ytimg.com/vi/rmF7uJaf1ho/hqdefault.jpg
52	12	rEnf_CFoyv0	Explore how economic inequality can be measured and how it is impacted by different governmental policy choices. -- Income ...	https://i.ytimg.com/vi/rEnf_CFoyv0/hqdefault.jpg
53	12	0xMCWr0O3Hs	Inequality is a big, big subject. There's racial inequality, gender inequality, and lots and lots of other kinds of inequality. This is ...	https://i.ytimg.com/vi/0xMCWr0O3Hs/hqdefault.jpg
54	12	I9yDGdf_tNA	How much biological advantage will money buy in the future? As new technologies offer more advanced 'body upgrades', we ...	https://i.ytimg.com/vi/I9yDGdf_tNA/hqdefault.jpg
55	12	rmF7uJaf1ho	Many people believe that poverty and inequality (economic inequality, income inequality and so on) are the same thing but... well, ...	https://i.ytimg.com/vi/rmF7uJaf1ho/hqdefault.jpg
56	13	pjaN2WHAHVo	mindblowingfacts #briancox #universe Renowned astrophysicist, Professor Brian Cox explains some of the biggest mysteries in ...	https://i.ytimg.com/vi/pjaN2WHAHVo/hqdefault.jpg
57	13	_RakXz4r3kY	Check out our second channel, @StarTalkPlus Get the NEW StarTalk book, 'To Infinity and Beyond: A Journey of Cosmic ...	https://i.ytimg.com/vi/_RakXz4r3kY/hqdefault.jpg
58	13	otmaMNMPTxs	Reality of Earths Outer Space  ‍   #space #astronomy #universe #earth #cosmos #science #spaceexploration #space #skibidi ...	https://i.ytimg.com/vi/otmaMNMPTxs/hqdefault.jpg
59	13	u43kpacCGLU	Join esteemed astrophysicist Brian Cox as he takes you on an exciting journey into the realm of light speed and the vastness of ...	https://i.ytimg.com/vi/u43kpacCGLU/hqdefault.jpg
60	14	UEitCTCSzkw	Discover the most astonishing scientific breakthroughs of 2024 that flew under the radar! From groundbreaking advancements in ...	https://i.ytimg.com/vi/UEitCTCSzkw/hqdefault.jpg
61	14	otmaMNMPTxs	Reality of Earths Outer Space  ‍   #space #astronomy #universe #earth #cosmos #science #spaceexploration #space #skibidi ...	https://i.ytimg.com/vi/otmaMNMPTxs/hqdefault.jpg
62	14	V9Mpmidh69E	Dive into the latest breakthroughs in warp drive technology! Discover how recent physics advancements could turn the dream of ...	https://i.ytimg.com/vi/V9Mpmidh69E/hqdefault.jpg
63	14	jNTZ7PuWkBI	In this thrilling episode, we dive into the heart of cosmic mystery as Voyager 1 sends back a groundbreaking signal after months of ...	https://i.ytimg.com/vi/jNTZ7PuWkBI/hqdefault.jpg
64	14	Z_3ariM_qQ0	Dive into our comprehensive space documentary 2024 that explores the wonders of the universe, planets, and astronomy.	https://i.ytimg.com/vi/Z_3ariM_qQ0/hqdefault.jpg
65	15	pjaN2WHAHVo	mindblowingfacts #briancox #universe Renowned astrophysicist, Professor Brian Cox explains some of the biggest mysteries in ...	https://i.ytimg.com/vi/pjaN2WHAHVo/hqdefault.jpg
66	15	_RakXz4r3kY	Check out our second channel, @StarTalkPlus Get the NEW StarTalk book, 'To Infinity and Beyond: A Journey of Cosmic ...	https://i.ytimg.com/vi/_RakXz4r3kY/hqdefault.jpg
67	15	c64hqovEG-U	How do we uncover distant planets' secrets? Neil deGrasse Tyson and comedian Chuck Nice explore the recent discoveries in ...	https://i.ytimg.com/vi/c64hqovEG-U/hqdefault.jpg
68	16	TKq42KpKtFY	Dr. Praveen Subedi helps us understand Florida Sunshine State Standard SC.912.L.17.4 Describe changes in ecosystems ...	https://i.ytimg.com/vi/TKq42KpKtFY/hqdefault.jpg
69	16	G4H1N_yXBiA	What causes climate change (also known as global warming)? And what are the effects of climate change? Learn the human ...	https://i.ytimg.com/vi/G4H1N_yXBiA/hqdefault.jpg
70	16	EuwMB1Dal-4	Access lesson resources for this video + more elementary science videos for free on ClickView ✓ https://clickv.ie/w/TaAw ...	https://i.ytimg.com/vi/EuwMB1Dal-4/hqdefault.jpg
71	16	PfSm29EyANU	AP Environmental Science Unit Review of the Unit 9 material. Climate Change, Biodiversity, Global Warming, Ozone Depletion.	https://i.ytimg.com/vi/PfSm29EyANU/hqdefault.jpg
72	16	kWvHUA12dyc	Webinar was live on 4/17/20 Presenter Eric Leibensperger, SUNY Plattsburgh Take Home Activity Links: ...	https://i.ytimg.com/vi/kWvHUA12dyc/hqdefault.jpg
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.articles_id_seq', 155, true);


--
-- Name: fav_articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.fav_articles_id_seq', 1, false);


--
-- Name: fav_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.fav_videos_id_seq', 1, false);


--
-- Name: favourites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.favourites_id_seq', 1, false);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.questions_id_seq', 16, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.topics_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: will
--

SELECT pg_catalog.setval('public.videos_id_seq', 72, true);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: fav_articles fav_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.fav_articles
    ADD CONSTRAINT fav_articles_pkey PRIMARY KEY (id);


--
-- Name: fav_videos fav_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.fav_videos
    ADD CONSTRAINT fav_videos_pkey PRIMARY KEY (id);


--
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: articles articles_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: questions questions_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- Name: videos videos_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: will
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- PostgreSQL database dump complete
--

