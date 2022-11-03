#!/bin/bash

billing_known_hash="a71bafe694f78580e94c0bbb6c541d30"
employee_known_hash="ca5e94f8f68cee0afcc75b7f8f69e966"
material_known_hash="bd9d75e33a5720615a2ff2d4d8e22fa8"

sudo smbclient \\\\host1\\C -U Administrator tartans --directory Users/Public/CompanyFiles -c "get billing_data.csv"
sudo smbclient \\\\host1\\C -U Administrator tartans --directory Users/Public/CompanyFiles -c "get employee_data.csv"
sudo smbclient \\\\host1\\C -U Administrator tartans --directory Users/Public/CompanyFiles -c "get MaterialDataSheet.pdf"

billing_hash=$(md5sum ./billing_data.csv | cut -d " " -f1)
employee_hash=$(md5sum ./employee_data.csv | cut -d " " -f1)
material_hash=$(md5sum ./MaterialDataSheet.pdf | cut -d " " -f1)

if [[ "$billing_hash" = "$billing_known_hash" ]] && [[ "$employee_hash" = "$employee_known_hash" ]] && [[ "$material_hash" = "$material_known_hash" ]]; then
echo "FileRestoration: Success. Files are restored to their original state."
else
echo "FileRestoration: Failure. The files are not in their restored state."
fi

rm -f ./billing_data.csv
rm -f ./employee_data.csv
rm -f ./MaterialDataSheet.pdf

if nc -z host1 445 && ! nc -z host1 22; then
echo "NetworkState: Success. Network is in the required state."
else
echo "NetworkState: Failure. Network is not in the required state."
fi
