#!/bin/bash
source /usr/local/etc/ocp4.config

oc login -u "${RHT_OCP4_DEV_USER}" -p "${RHT_OCP4_DEV_PASSWORD}" "${RHT_OCP4_API}"

mongo_pod=$(oc get pod -n adoptapup -l app=mongodb -o jsonpath='{.items[0].metadata.name}')

echo
echo 'Checking if animal data is loaded into MongoDB...'
echo
oc exec -i  ${mongo_pod} -c mongodb -- sh -c "mongo -u developer -p developer adopt-a-pup --quiet --eval 'db.animals.find()'"

echo
echo 'Checking if shelter data is loaded into MongoDB...'
echo
oc exec -i  ${mongo_pod} -c mongodb -- sh -c "mongo -u developer -p developer adopt-a-pup --quiet --eval 'db.shelters.find()'"
