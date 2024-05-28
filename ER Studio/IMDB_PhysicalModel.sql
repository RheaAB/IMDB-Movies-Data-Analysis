--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      DimensionalModel.DM1
--
-- Date Created : Thursday, November 30, 2023 22:53:59
-- Target DBMS : MySQL 8.x
--

-- 
-- TABLE: Dim_Crew 
--

CREATE TABLE Dim_Crew(
    CrewSK            INT            NOT NULL,
    JobID             VARCHAR(10),
    tconst            VARCHAR(50),
    nconst            VARCHAR(50),
    Category          VARCHAR(10),
    DI_CreatedDate    DATETIME,
    PRIMARY KEY (CrewSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Date 
--

CREATE TABLE Dim_Date(
    DateSK            INT            NOT NULL,
    Day_Num           INT,
    Date_str          CHAR(10),
    Month_Num         INT,
    Month_Str         CHAR(10),
    Year_Num          INT,
    Is_Weekend        CHAR(20),
    Qtr_Num           INT,
    DI_CreatedDate    DATETIME,
    JobID             VARCHAR(10),
    dt                DATETIME,
    PRIMARY KEY (DateSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_Genre 
--

CREATE TABLE DIM_Genre(
    GenreSK           INT            NOT NULL,
    Movie_TitleSK     INT            NOT NULL,
    tconst            VARCHAR(10),
    genre             CHAR(50),
    DI_CreatedDate    DATETIME,
    Job_ID            CHAR(50),
    PRIMARY KEY (GenreSK, Movie_TitleSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Movie_Title 
--

CREATE TABLE Dim_Movie_Title(
    Movie_TitleSK     INT            NOT NULL,
    tconst            VARCHAR(10)    NOT NULL,
    titleType         CHAR(10),
    primaryTitle      CHAR(10),
    originalTitle     CHAR(10),
    isAdult           CHAR(1)        NOT NULL,
    startYear         DATE,
    runtimeMinutes    INT,
    genres            CHAR(100),
    DI_CreatedDate    DATETIME,
    JobID             VARCHAR(10),
    PRIMARY KEY (Movie_TitleSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Person 
--

CREATE TABLE Dim_Person(
    PersonSK          INT               NOT NULL,
    nconst            CHAR(50)          NOT NULL,
    primaryName       CHAR(20),
    birthYear         DECIMAL(20, 0),
    deathYear         DECIMAL(20, 0),
    DI_CreatedDate    DATETIME,
    JobID             VARCHAR(10),
    PRIMARY KEY (PersonSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Person_KnownFor 
--

CREATE TABLE Dim_Person_KnownFor(
    KnowFor_TitleSK    INT             NOT NULL,
    PersonSK           INT             NOT NULL,
    nconst             VARCHAR(50)     NOT NULL,
    knownForTitles     VARCHAR(500),
    DI_CreatedDate     DATETIME,
    JobID              VARCHAR(10),
    PRIMARY KEY (KnowFor_TitleSK, PersonSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_Person_Profession 
--

CREATE TABLE Dim_Person_Profession(
    ProfessionSK         INT            NOT NULL,
    PersonSK             INT            NOT NULL,
    nconst               CHAR(50)       NOT NULL,
    primaryProfession    CHAR(100),
    DI_CreatedDate       DATETIME,
    JobId                VARCHAR(10),
    PRIMARY KEY (ProfessionSK, PersonSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Dim_TitleRegion 
--

CREATE TABLE Dim_TitleRegion(
    TitleRegionSK      INT             NOT NULL,
    titleID            VARCHAR(10)     NOT NULL,
    Title              VARCHAR(100),
    Region             CHAR(10),
    Language           CHAR(10),
    Types              CHAR(10),
    Attributes         CHAR(10),
    isOriginalTitle    CHAR(1),
    DI_CreatedDate     DATETIME,
    JobID              VARCHAR(10),
    PRIMARY KEY (TitleRegionSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Fct_IMDB 
--

CREATE TABLE Fct_IMDB(
    IMDB_PK            INT            NOT NULL,
    CrewSK             INT            NOT NULL,
    PersonSK           INT            NOT NULL,
    TitleRegionSK      INT            NOT NULL,
    Movie_TitleSK      INT            NOT NULL,
    KnowFor_TitleSK    INT            NOT NULL,
    DI_CreatedDate     DATETIME,
    JobID              VARCHAR(10),
    RatingsSK          CHAR(10),
    PRIMARY KEY (IMDB_PK, CrewSK, PersonSK, TitleRegionSK, Movie_TitleSK, KnowFor_TitleSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: FCT_Movie_Earnings 
--

CREATE TABLE FCT_Movie_Earnings(
    MovieEarningsSK    INT                NOT NULL,
    DateSK             INT                NOT NULL,
    Movie_TitleSK      INT                NOT NULL,
    Rank               DECIMAL(5, 0),
    Gross              DECIMAL(100, 0),
    Theaters           DECIMAL(100, 0),
    PerTheater         DECIMAL(100, 0),
    TotalGross         DECIMAL(100, 0),
    Days               INT,
    DI_CreatedDate     DATETIME,
    JobId              VARCHAR(10),
    PRIMARY KEY (MovieEarningsSK, DateSK, Movie_TitleSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: Fct_Ratings 
--

CREATE TABLE Fct_Ratings(
    RatingsSK         CHAR(10)          NOT NULL,
    tconst            CHAR(50),
    Rating            FLOAT(8, 0),
    numVotes          DECIMAL(10, 0),
    runtimeMinutes    DECIMAL(10, 0),
    DI_CreatedDate    DATETIME,
    JobID             VARCHAR(10),
    PRIMARY KEY (RatingsSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: DIM_Genre 
--

ALTER TABLE DIM_Genre ADD CONSTRAINT RefDim_Movie_Title20 
    FOREIGN KEY (Movie_TitleSK)
    REFERENCES Dim_Movie_Title(Movie_TitleSK)
;


-- 
-- TABLE: Dim_Person_KnownFor 
--

ALTER TABLE Dim_Person_KnownFor ADD CONSTRAINT RefDim_Person19 
    FOREIGN KEY (PersonSK)
    REFERENCES Dim_Person(PersonSK)
;


-- 
-- TABLE: Dim_Person_Profession 
--

ALTER TABLE Dim_Person_Profession ADD CONSTRAINT RefDim_Person18 
    FOREIGN KEY (PersonSK)
    REFERENCES Dim_Person(PersonSK)
;


-- 
-- TABLE: Fct_IMDB 
--

ALTER TABLE Fct_IMDB ADD CONSTRAINT RefDim_Crew3 
    FOREIGN KEY (CrewSK)
    REFERENCES Dim_Crew(CrewSK)
;

ALTER TABLE Fct_IMDB ADD CONSTRAINT RefDim_Movie_Title6 
    FOREIGN KEY (Movie_TitleSK)
    REFERENCES Dim_Movie_Title(Movie_TitleSK)
;

ALTER TABLE Fct_IMDB ADD CONSTRAINT RefDim_TitleRegion9 
    FOREIGN KEY (TitleRegionSK)
    REFERENCES Dim_TitleRegion(TitleRegionSK)
;

ALTER TABLE Fct_IMDB ADD CONSTRAINT RefFct_Ratings15 
    FOREIGN KEY (RatingsSK)
    REFERENCES Fct_Ratings(RatingsSK)
;

ALTER TABLE Fct_IMDB ADD CONSTRAINT RefDim_Person_KnownFor21 
    FOREIGN KEY (KnowFor_TitleSK, PersonSK)
    REFERENCES Dim_Person_KnownFor(KnowFor_TitleSK, PersonSK)
;

ALTER TABLE Fct_IMDB ADD CONSTRAINT RefDim_Person22 
    FOREIGN KEY (PersonSK)
    REFERENCES Dim_Person(PersonSK)
;


-- 
-- TABLE: FCT_Movie_Earnings 
--

ALTER TABLE FCT_Movie_Earnings ADD CONSTRAINT RefDim_Movie_Title12 
    FOREIGN KEY (Movie_TitleSK)
    REFERENCES Dim_Movie_Title(Movie_TitleSK)
;

ALTER TABLE FCT_Movie_Earnings ADD CONSTRAINT RefDim_Date13 
    FOREIGN KEY (DateSK)
    REFERENCES Dim_Date(DateSK)
;


