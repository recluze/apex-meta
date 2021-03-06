#!/usr/bin/python 
import re
import sys

target_process = 'system_server'
seperator_string = 'NEW ENTRY' 

stats_for = "CPU"; 
if len(sys.argv) > 2 and sys.argv[2] == 'MEM': 
    stats_for = "MEM_ALLOCATED"; 

seaching_for_timestamp = True

for line in open(sys.argv[1], 'r'):
    if seaching_for_timestamp:
        found_stats = False
        m = re.match(r"Time of measurement: (\d+)", line)
        if m:
            # we found the time of stat
            # print 'Time:', 
            print m.group(1), ', ',
            seaching_for_timestamp = False 

    else:
        # searching for stats 
	if stats_for == "CPU": 
       	    m = re.match(r"[^\d]*([\d.]+)%.*"+target_process+": ([\d.]+)% user \+ ([\d.]+)% kernel.*", line)
            if (m):
                # total 
                print m.group(1), ',',  
                # user 
                print m.group(2), ',', 
                # kernel 
                print m.group(3), ',', 
                print ' '
                seaching_for_timestamp = True
	elif stats_for == "MEM_ALLOCATED": 
	    # m = re.match(r".*allocated:\ *[^\ ]*\ *[^\ ]*\ *[^\ ]*\ *(.*)", line)
	    m = re.match(r".*free:\ *[^\ ]*\ *[^\ ]*\ *[^\ ]*\ *(.*)", line)
	    if m: 
	        print m.group(1) 
                seaching_for_timestamp = True

	# or no stat is found and we have arrived at a new entry
        searching_for_timestamp = False
        m = re.match(r".*"+seperator_string+".*", line)
        if m:
            # no stats! :(
            seaching_for_timestamp = True
            print 'no stats found'
        
