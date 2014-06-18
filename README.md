![data for frogs](https://raw.githubusercontent.com/luiscape/data-for-frog/master/frog_jumping_over_data.jpg)

**NOTE:** This data is for working and demonstration purposes only. It should note be trusted as authoritative data or alike. For more information get in touch with the HDX team [here](http://docs.hdx.rwlabs.org/get-involved/).

Here you can find **153** indicators from **~23** sources that are now part of the [Common Humanitarian Dataset](http://docs.hdx.rwlabs.org/project-details/analytics/common-humanitarian-dataset/). The folder [frog-data]() contains data in two formats: CSV and SQLite. The data is organized as follows: 

- CSV
  - value.csv
  - indicator.csv
  - dataset.csv
  - denorm_data.csv

- SQLite
  - cps_model_db.sqlite (3 tables like the CSV files above, value, indicator, and dataset)
  - denormalized_db.sqlite (single flat table)


Description of Files
--------------------
You can find prepared data in the `frog_data` folder. Here are the four files you find there with their respective descriptions:

- **value.csv:** Value contains the actual observational data. There are 7 fields in this file:
  - dsID: Unique identifier of the "source" of the data.
  - region: The country / territory the data is about.
  - indID: The unique ID of the indicator in our data model.
  - period: The time period the data is about. Usually a four-digit year.
  - value: The value of the observation / record.
  - is_numer: A boolean that explains if the observation is a number.
  - source: The source (link, generally) of the data.

- **indicator.csv**: Here you find a list of the indicators in the database, together with their names and type of data.
  - indID: The unique ID of the indicator in our data model.
  - name: Long name of the indicator.
  - units: The type of data that observation is about.

- **dataset.csv**: Here you find information about the sources of the data.
  - dsID: Unique identifier of the "source" of the data.
  - last_updated: The last time the data has been updated at the source level.
  - last_scraped: The last time the data has been scraped.
  - name: The long name of the source.

**Note:** UNHCR data is not included in these files as it doesn't quite fit the data-model yet. (It isn't on CPS).
