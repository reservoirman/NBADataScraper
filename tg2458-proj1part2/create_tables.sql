CREATE TABLE Players (
 PID INTEGER,
 PlayerName CHAR(40) NOT NULL,
 DOB DATE,
 POSITION CHAR(8),
 PRIMARY KEY (PID));

#attribute-based check: Earliest NBA season was the 1946-1947 season  
CREATE TABLE Seasons (
 SeasonYear INTEGER,
 PRIMARY KEY (SeasonYear),
 CHECK (SeasonYear >= 1947));

#tuple-based check: all teams must have at least one player 
#tuple-based check: all teams belong to at least one season
CREATE TABLE Teams (
 TID INTEGER,
 PRIMARY KEY (TID),
 CHECK ( NOT EXISTS (
		SELECT TID FROM Teams
		WHERE TID NOT IN (SELECT TID FROM IndPerf))),
 CHECK ( NOT EXISTS (
		SELECT TID FROM Teams
		WHERE TID NOT IN (SELECT TID FROM BelongsTo))));

#attribute-based check: Home team cannot be equal to the Away team 
#tuple-based check: all games must have at least one player
CREATE TABLE Games (
 GameID INTEGER,
 GameDate DATE,
 Home…TID INTEGER NOT NULL,
 Away…TID INTEGER NOT NULL,
 SeasonYear INTEGER NOT NULL,
 PRIMARY KEY (GameID),
 FOREIGN KEY (SeasonYear) REFERENCES Seasons (SeasonYear),
 FOREIGN KEY (Home…TID) REFERENCES Teams(TID),
 FOREIGN KEY (Away…TID) REFERENCES Teams(TID),
 CHECK (Home != Away),
 CHECK ( NOT EXISTS (
		SELECT GameID FROM Games
		WHERE GameID NOT IN (SELECT GameID FROM IndPerf))));
 

#constraint: stats must be non-negative
CREATE TABLE IndPerf (
 GameID INTEGER,
 PID INTEGER,
 TID INTEGER NOT NULL,
 FGM INTEGER UNSIGNED NOT NULL,
 FGA INTEGER UNSIGNED NOT NULL,
 TPM INTEGER UNSIGNED NOT NULL,
 TPA INTEGER UNSIGNED NOT NULL,
 FTM INTEGER UNSIGNED NOT NULL,
 FTA INTEGER UNSIGNED NOT NULL,
 Reb INTEGER UNSIGNED NOT NULL,
 Ast INTEGER UNSIGNED NOT NULL,
 Stl INTEGER UNSIGNED NOT NULL,
 Blk INTEGER UNSIGNED NOT NULL,
 Turnovers INTEGER UNSIGNED NOT NULL,
 PF INTEGER UNSIGNED NOT NULL,
 Pts INTEGER UNSIGNED NOT NULL,
 PRIMARY KEY (GameID, PID),
 FOREIGN KEY (GameID) REFERENCES Games (GameID),
 FOREIGN KEY (PID) REFERENCES Players (PID),
 FOREIGN KEY (TID) REFERENCES Teams (TID));

#attribute check: number of DNPs must be positive 
CREATE TABLE DidNotPlay (
 PID INTEGER,
 SeasonYear INTEGER NOT NULL,
 Count INTEGER NOT NULL,
 PRIMARY KEY (PID, SeasonYear),
 FOREIGN KEY (PID) REFERENCES Players (PID),
 FOREIGN KEY (SeasonYear) REFERENCES Seasons (SeasonYear),
 CHECK (Count > 0));
 

CREATE TABLE BelongsTo (
 TID INTEGER,
 SeasonYear INTEGER NOT NULL,
 TeamName CHAR(40) NOT NULL,
 TeamAbbr CHAR(3) NOT NULL,
 PRIMARY KEY (TID, SeasonYear),
 FOREIGN KEY (TID) REFERENCES Teams (TID),
 FOREIGN KEY (SeasonYear) REFERENCES Seasons (SeasonYear));

#attribute check: number of ejections must be positive 
CREATE TABLE Ejections (
 PID INTEGER,
 SeasonYear INTEGER NOT NULL,
 Count INTEGER NOT NULL,
 PRIMARY KEY (PID, SeasonYear),
 FOREIGN KEY (PID) REFERENCES Players (PID),
 FOREIGN KEY (SeasonYear) REFERENCES Seasons (SeasonYear),
 CHECK (Count > 0));
 
#attribute check: number of flagrant fouls must be positive
CREATE TABLE FlagrantFouls (
 PID INTEGER,
 SeasonYear INTEGER NOT NULL,
 Count INTEGER NOT NULL,
 PRIMARY KEY (PID, SeasonYear),
 FOREIGN KEY (PID) REFERENCES Players (PID),
 FOREIGN KEY (SeasonYear) REFERENCES Seasons (SeasonYear),
 CHECK (Count > 0));


