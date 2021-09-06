#---------------------------------
# This script deletes evected pods
#---------------------------------

#!/bin/bash
for each in $(kubectl get pods | grep Evicted | awk '{print $1}');
do
kubectl delete pods $each
done
