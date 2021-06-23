#------------------------------------------------------------------------------------------------------------------------------------
# This script checks the availability of the page on the Internet, using the example of google, and returns an error or success code.
#------------------------------------------------------------------------------------------------------------------------------------

#!/bin/bash
logfile=google
b=$(curl --max-time 10 -s -o /dev/null -w "%{http_code}" https://www.google.ru/)
echo $(date) code: ${b} >> ${logfile}.log
