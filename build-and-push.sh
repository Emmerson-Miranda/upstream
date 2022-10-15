#!/bin/bash 
IMAGE_NAME=emmerson/upstream:mockv2

#curl https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.26.3/wiremock-standalone-2.26.3.jar -o wiremock-standalone.jar

docker build -t $IMAGE_NAME . --iidfile imageid.txt
export IMAGE_ID=$(cat imageid.txt)

#rm wiremock-standalone.jar

echo "Image Name: $IMAGE_NAME"
echo "Image ID: $IMAGE_ID"

#docker tag $IMAGE_ID emmerson/$IMAGE_NAME
#docker push emmerson/$IMAGE_NAME