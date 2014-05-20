Data for frog
=============

The dataset attached contains **129** indicators from **~20** sources. The files are organized as follows:

- value.csv
- indicator.csv
- dataset.csv

All of them are compressed within a ZIP file (data.zip). The data is also available as a SQLite database (db.sqlite).


Description of Files
--------------------
You can find prepared data in the `frog-data` folder. Here are the four files you find there with their respective descriptions:

- **value.csv:** Value has the actual data there. There are four fields in this file:
-- dsID: Unique identifier of the "source" of the data.
-- region: The country / territory the data is about.
-- indID: The unique ID of the indicator in our data model.
-- period: The time period the data is about. Usually a four-digit year.
-- value: The value of the observation / record.
-- is_numer: A boolean that explains if the observation is a number.
-- source: The source (link, generally) of the data.

- **indicator.csv**: Here you find a list of the indicators in the database, together with their names and type of data.
-- indID: The unique ID of the indicator in our data model.
-- name: Long name of the indicator.
-- units: The type of data that observation is about.

- **dataset.csv**: Here you find information about the sources of the data.
-- dsID: Unique identifier of the "source" of the data.
-- last_updated: The last time the data has been updated at the source level.
-- last_scraped: The last time the data has been scraped.
-- name: The long name of the source.


UNHCR Data
----------
UNHCR data can be found in the `unhcr-data`. The UNHCR data isn't merged in the database above because it contains a different structure than the indicators we are working above. Right now it doesn't fit the data-model used. But the data-model will evolve and adapt to this data.

The single most important difference is that UNHCR data uses *country pairs* as unique identifiers of each record. That is, a refugee comes from a country and goes to a country. That pair identifies a record. Our data-model uses single countries as identifiers of records. That is, Kenya as an X poverty rate as of year 2013.

There are two files in the UNHCR dataset:

- **unhcr-refugee-data.csv**
- **unhcr-refugee-countries.csv**

The fields are self-explanatory.


