FROM openjdk:8u92-jdk-alpine
LABEL AUTHOR="emmerson.miranda@gmail.com" 

COPY . /usr/src/upstream
WORKDIR /usr/src/upstream

EXPOSE 10003
EXPOSE 10443

#ENV JAEGER_SERVICE_NAME=upstream 
#ENV JAEGER_AGENT_HOST=jaeger  
#ENV JAEGER_AGENT_PORT=6831  
#ENV JAEGER_SAMPLER_TYPE=const 
#ENV JAEGER_SAMPLER_PARAM=1 
#CMD ["java", "-jar", "wiremock-standalone.jar", "--verbose", "--port", "10003", "--https-port", "10443"]

CMD ["./startup.sh"]

# https://github.com/jaegertracing/jaeger-client-java/blob/master/jaeger-core/README.md#configuration-via-environment
# java -javaagent:./opentracing-specialagent-1.7.4.jar -Dsa.init.defer=false -Dsa.exporter=jaeger -Dsa.log.level=FINER -DJAEGER_SERVICE_NAME=upstream -DJAEGER_AGENT_HOST=jaeger  -DJAEGER_AGENT_PORT=6831  -DJAEGER_SAMPLER_TYPE=const -DJAEGER_SAMPLER_PARAM=1 -jar wiremock-standalone.jar --verbose --port 10003 --https-port 10443 
