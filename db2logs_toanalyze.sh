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
# ./db2logs_toanalyze.sh [date with format YYYYMMDD] [database name]
# eg: ./db2logs_toanalyze.sh 20221210 mdmdb

date=$1
dbname=$2

# Connect to database
db2 connect to $dbname

# Monitor database for 60 seconds
echo "Started ["$(date '+%F %T:%z')"]: Monitor database for 60 seconds"
db2 "call monreport.connection(60)" > connection_$date.report
db2 "call monreport.dbsummary(60)" > summary_$date.report
echo "Finished ["$(date '+%F %T:%z')"]: Monitor database for 60 seconds"
sleep 10

# Gather real-time memory information
echo "Started ["$(date '+%F %T:%z')"]: Gather real-time memory information"
db2pd -db $dbname -bufferpools > bufferpools_$date.out
db2pd -allmembers -inst -alldbs -dbptnmem -memsets -mempools > memory_util_$date.out
db2pd -db $dbname -transactions > transactions_$date.out
db2pd -db $dbname -dynamic > dynamic_$date.out
db2pd -db $dbname -tcbstats > tcbstats_$date.out
db2pd -db $dbname -locks > locks_$date.out
db2pd -db $dbname -wlocks > wlocks_$date.out
db2pd -db $dbname -tablespaces > tablespaces_$date.out
db2mtrk -i -d -w -v > memory_track_$date.out
db2 list applications show detail > applications_$date.info
echo "Finished ["$(date '+%F %T:%z')"]: Gather real-time memory information"
sleep 10

# Get dbm and all db snapshots
echo "Started ["$(date '+%F %T:%z')"]: Get dbm and db snapshots"
db2 get snapshot for dbm > dbm_snap_$date.out
db2 get snapshot for all databases > dbs_snap_$date.out
echo "Finished ["$(date '+%F %T:%z')"]: Get dbm and db snapshots"
