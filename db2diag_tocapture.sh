#!/bin/sh

# Description:
# The following shell script is used to gather database diagnostic information
# based on IBM's documentation, using the db2diag command on a specific timeframe
# (https://www.ibm.com/docs/en/db2/11.5?topic=commands-db2diag-db2diag-logs-analysis-tool)

# Usage:
# ./db_diagnostic.sh [date with format YYYY-MM-DD] [start timestamp with format HH.HH] [duration + 2 hours]
# eg: ./db_diagnostic.sh 2022-12-10 00.00 26
# this command will take db2diag logs starting from 00.00, 10 December 2022 up to 23.59, 11 December 2022.

date=$1
starttime=$2
hours=$3
plus2=2
duration=$((hours - plus2))

# Connect to mdmdb
db2 connect to mdmdb

# Collect db2diag logs
echo "Started ["$(date '+%F %T:%z')"]: Collect db2diag logs"
echo "Collecting db2diag logs for "$duration" hours"
db2diag -H $hoursh:$date-$starttime > db2diag_$date-$starttime.log
echo "Finished ["$(date '+%F %T:%z')"]: Collect db2diag logs"
