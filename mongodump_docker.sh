#---------------------------------------------------------------------------
# This scripts doing mongodump database mongodb and copy this dump on s3 aws
#---------------------------------------------------------------------------

#!/bin/bash
sudo docker run --rm --name mongodump -v ${PWD}:/dump -w /dump mongo /bin/bash -c  "mongodump -h <host> -u <username> -p <password>"
DATE=`date +%d%b%Y_%H:%M`
sudo mv /home/artyomd/dump /home/artyomd/dump_$DATE
sudo aws s3 cp --recursive /home/artyomd/dump_$DATE s3://mongodbdump/dump_$DATE
sudo rm -rf /home/artyomd/dump_$DATE

