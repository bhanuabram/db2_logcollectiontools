#!/bin/sh

# Description:
# The following shell script is used to gather general database information,
# on the given date/timestamp this script is ran. Here are some of the types of
# information collected:
#
# 1. 60 seconds of database monitoring.
# 2. Real-time memory information.
# 3. Database Manager and All Databases snapshot.
#
# Usage:
# ./db_diagnostic.sh [date with format YYYY-MM-DD] [end timestamp with format HH.HH] [how long + 2 hours]
# eg: ./db_diagnostic.sh 2022-12-10 23.00 8
# this only takes 6 hours prior to end timestamp

date=$1
time=$2
hours=$3
plus2=2
duration=$((hours - plus2))

# Connect to mdmdb
db2 connect to mdmdb

# Collect db2diag logs
echo "Started ["$(date '+%F %T:%z')"]: Collect db2diag logs"
echo "Collecting db2diag logs for "$duration" hours"
db2diag -H $hoursh:$1-$2 > db2diag_$1-$2.log
echo "Finished ["$(date '+%F %T:%z')"]: Collect db2diag logs"
