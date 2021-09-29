#----------------------------------------------------------------------------------------------------
#This script makes a mongodb database mongorestore, having previously downloaded a backup from aws s3
#----------------------------------------------------------------------------------------------------

#!/bin/bash

sudo aws s3 cp --recursive s3://mongodbdump-shared-mongo/dump_test_26Sep2021_05:02/ /root/mongo/dump
sudo docker run -it -v /root/mongo/dump/:/dump mongo /bin/bash -c "mongorestore -h <host> -u <user> -p <password>"
