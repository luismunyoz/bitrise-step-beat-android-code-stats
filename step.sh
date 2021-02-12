#!/bin/bash
set -ex

echo "This is the value specified for the input 'project_location': $project_location"

cd $project_location
kt_code=$(cloc $project_location --exclude-dir=build | grep 'Kotlin' | awk '{print $5}')
java_code=$(cloc $project_location --exclude-dir=build | grep 'Java' | awk '{print $5}')
xml_code=$(cloc $project_location --exclude-dir=build | grep 'XML' | awk '{print $5}')
doc_files=$(cloc $project_location --exclude-dir=build | grep 'Markdown' | awk '{print $2}')
total_code=$(expr $kt_code \+ $java_code)
kt_percentage=$(expr $kt_code \* 100 / $total_code)
java_percentage=$(expr 100 \- $kt_percentage)


envman add --key KOTLIN_PERCENTAGE_CODE --value $kt_percentage
envman add --key JAVA_PERCENTAGE_CODE --value $java_percentage
envman add --key XML_LINES_CODE --value $xml_code
envman add --key JAVA_LINES_CODE --value $java_code
envman add --key KOTLIN_LINES_CODE --value $kt_code
envman add --key DOCUMENTATION_FILES --value $doc_files
