#!/bin/bash

destcert=/etc/pulp/entitlements/newer/cert.pem
sourcedir="/etc/pki/entitlement"
cd $sourcedir
file1=$(ls $sourcedir/*.pem | grep -v 'key')
file2=$(ls $sourcedir/*.pem | grep 'key')
echo $file1
echo $file2
cat $file1 $file2 > newcert.tmp
firstmd5=$(md5sum newcert.tmp | awk '{print $1}')
secondm5=$(md5sum $destcert | awk '{print $1}')
echo $firstmd5
echo $secondm5
if [[ $firstmd5 != $secondm5 ]]; then
  echo "needs replacing"
  /bin/cp $sourcedir/newcert.tmp $destcert
  for F in $( pulp-admin rpm repo list | grep rhel | grep Id: |  grep -v rhel-base | awk '{print $2}'); do pulp-admin rpm repo update --feed-cert=$destcert --feed-key=$destcert --repo-id $F; done
else
  echo "No need to replace."
fi

