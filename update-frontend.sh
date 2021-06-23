#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# This script pumps out the necessary artifacts from the ecr-registry and copies it to s3 aws, plus cloudfront is configured for this s3 bucket - therefore, in the end it makes another invalidate (cleaning cache on cloudfront).
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#!/bin/bash

dir=$(pwd)
echo "$dir"

tagdesign=$(grep 'tag: front-design' /$dir/helm/charts/kreo-app/values-release.yaml | awk '{print $2}') #Here I look at the current version of the front

echo $tagdesign

eval $(aws ecr get-login --region eu-west-2 --no-include-email) #Getting a token from AWS

sudo docker pull <your id aws>.dkr.ecr.<your region>.amazonaws.com/<your repository on ecr>:$tagdesign #Pumping out the docker container

sudo docker container create --name front-design 015631917131.dkr.ecr.eu-west-2.amazonaws.com/front:$tagdesign #Created docker container


sudo docker cp front-design:/opt /front-design #Copy artifacts


sudo docker pull amazon/aws-cli #Pumping out aws-cli

sudo docker run --rm -it -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v /front-design:/front-design -v ~/.aws:/root/.aws amazon/aws-cli s3 cp /front-design s3://your-s3-backet/ --recursive #Copy artifacts on aws s3


aws configure set preview.cloudfront true
aws cloudfront create-invalidation \
    --distribution-id <id> \
    --paths "/*"

sudo docker rm front-design #Delete container

echo "Del container front-design"

sudo rm -rf /front-design #delete folder

echo "Del folder front-design"
