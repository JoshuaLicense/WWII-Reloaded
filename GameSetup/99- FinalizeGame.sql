-----------------------------------------------
-- Reset ID of tables
----------------------------------------------
CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Units ORDER by ID;
UPDATE Units SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Units.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

UPDATE sqlite_sequence SET seq = (SELECT COUNT(ID) FROM Units)-1 WHERE name = 'Units';

CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Projects ORDER by ID;
UPDATE Projects SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Projects.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

UPDATE sqlite_sequence SET seq = (SELECT COUNT(ID) FROM Projects)-1 WHERE name = 'Projects';

CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM MinorCivilizations ORDER by ID;
UPDATE MinorCivilizations SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE MinorCivilizations.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

UPDATE sqlite_sequence SET seq = (SELECT COUNT(ID) FROM MinorCivilizations)-1 WHERE name = 'MinorCivilizations';

CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM Leaders ORDER by ID;
UPDATE Leaders SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE Leaders.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

UPDATE sqlite_sequence SET seq = (SELECT COUNT(ID) FROM Leaders)-1 WHERE name = 'Leaders';

CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM AICityStrategies ORDER by ID;
UPDATE AICityStrategies SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE AICityStrategies.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

CREATE TABLE IDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO IDRemapper (Type) SELECT Type FROM AIEconomicStrategies ORDER by ID;
UPDATE AIEconomicStrategies SET ID = ( SELECT IDRemapper.id-1 FROM IDRemapper WHERE AIEconomicStrategies.Type = IDRemapper.Type);
DROP TABLE IDRemapper;

--------------------------------------------------------------
-- Projects to science
--------------------------------------------------------------
INSERT INTO Project_Flavors (ProjectType, FlavorType, Flavor) 
	SELECT Type, 'FLAVOR_SCIENCE', 25 FROM Projects;