# db2_logcollectiontools
 Tools to gather log information on Db2 for analysis and troubleshooting.


## Gathering General Database Information
### db2logs_toanalyze.sh
#### Description:
The following shell script is used to gather general database information, on the given date/timestamp this script is ran. Here are some of the types of information collected:

1. 60 seconds of database monitoring.
2. Real-time memory information.
3. Database Manager and All Databases snapshot.

#### Usage:
./db2logs_toanalyze.sh [date with format YYYYMMDD] [database name]
eg: ./db2logs_toanalyze.sh 20221210 mdmdb

## Gathering Db2 Diagnostic Information
### db2diag_tocapture.sh
#### Description:
The following shell script is used to gather database diagnostic information based on IBM's documentation, using the db2diag command on a specific timeframe (https://www.ibm.com/docs/en/db2/11.5?topic=commands-db2diag-db2diag-logs-analysis-tool)

#### Usage:
./db2diag_tocapture.sh [date with format YYYY-MM-DD] [start timestamp with format HH.HH] [duration + 2 hours]
eg: ./db2diag_tocapture.sh 2022-12-10 00.00 26
Note: this command will take db2diag logs starting from 00.00, 10 December 2022 up to 23.59, 11 December 2022.
