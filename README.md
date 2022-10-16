# Introduction
Simple "UPSTREAM" mock server powered by wiremock.

Listening:
- Listen HTTP requests on 10003 port.
- Listen HTTPS requests on 10443 port.

Resources:
- /microservice/myservice
- /microservice/modsecurity

### Simulating response status codes
Call "/microservice/myservice" resource passing X-US-SCENARIO header, to simulate error scenarios, the supported values are: 200, 400, 500. 

# Usage

## Start the image

Using docker run
```
docker run -p 10003:10003 -p 10443:10443 --name upstream-mock emmerson/upstream:mockv2
```

Using docker compose
```
docker-compose -f docker-compose.yaml up
```

## Test the image - curl examples

$ curl http://localhost:10003/microservice/myservice -d "body" -H "X-US-SCENARIO: 400" -v
```
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 10003 (#0)
> POST /microservice/myservice HTTP/1.1
> Host: localhost:10003
> User-Agent: curl/7.64.1
> Accept: */*
> X-US-SCENARIO: 400
> Content-Length: 4
> Content-Type: application/x-www-form-urlencoded
> 
* upload completely sent off: 4 out of 4 bytes
< HTTP/1.1 400 Bad Request
< Content-Type: application/json
< Matched-Stub-Id: df576bbc-74b8-4ff4-b85d-10de3b746e8f
< Transfer-Encoding: chunked
< Server: Jetty(9.2.z-SNAPSHOT)
< 
* Connection #0 to host localhost left intact
{"upstream":"You reach the upstream but there is a business error."}
```

$ curl http://localhost:10003/microservice/myservice -d "body" -H "X-US-SCENARIO: 500" -v
```
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 10003 (#0)
> POST /microservice/myservice HTTP/1.1
> Host: localhost:10003
> User-Agent: curl/7.64.1
> Accept: */*
> X-US-SCENARIO: 500
> Content-Length: 4
> Content-Type: application/x-www-form-urlencoded
> 
* upload completely sent off: 4 out of 4 bytes
< HTTP/1.1 500 Server Error
< Content-Type: application/json
< Matched-Stub-Id: 2a99c976-0bd4-4c2f-ab35-1f36cb3a1931
< Transfer-Encoding: chunked
< Server: Jetty(9.2.z-SNAPSHOT)
< 
* Connection #0 to host localhost left intact
{"upstream":"You reach the upstream but there is a internal error."}

```

$ curl https://localhost:10443/microservice/modsecurity -d "body"  -v -k
```
*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 10443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/cert.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: C=Unknown; ST=Unknown; L=Unknown; O=Unknown; OU=Unknown; CN=Tom Akehurst
*  start date: Feb 24 13:58:50 2015 GMT
*  expire date: Jan 31 13:58:50 2115 GMT
*  issuer: C=Unknown; ST=Unknown; L=Unknown; O=Unknown; OU=Unknown; CN=Tom Akehurst
*  SSL certificate verify result: self signed certificate (18), continuing anyway.
> POST /microservice/modsecurity HTTP/1.1
> Host: localhost:10443
> User-Agent: curl/7.64.1
> Accept: */*
> Content-Length: 4
> Content-Type: application/x-www-form-urlencoded
> 
* upload completely sent off: 4 out of 4 bytes
< HTTP/1.1 202 Accepted
< Matched-Stub-Id: 66ae2fd7-3cd4-4bf7-b4b8-48c0f124649c
< Transfer-Encoding: chunked
< Server: Jetty(9.2.z-SNAPSHOT)
< 
* Connection #0 to host localhost left intact
{"upstream":"ACK ModSecurity entry."}* Closing connection 0
```

$ curl http://localhost:10003/microservice/myservice -d "@examples/curl_soap_request" -H "X-US-SCENARIO: 200" -H "Content-Type: text/plain" -v
```
*   Trying 127.0.0.1:10003...
* Connected to localhost (127.0.0.1) port 10003 (#0)
> POST /microservice/myservice HTTP/1.1
> Host: localhost:10003
> User-Agent: curl/7.79.1
> Accept: */*
> X-US-SCENARIO: 200
> Content-Type: text/plain
> Content-Length: 290
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: application/json
< Matched-Stub-Id: df9b45d6-7e22-473a-ac12-3d72693ef837
< Transfer-Encoding: chunked
< Server: Jetty(9.2.z-SNAPSHOT)
< 
* Connection #0 to host localhost left intact
{"upstream":"You reach the upstream and your request its been processed."}
```

$ curl http://localhost:10003/microservice/myservice -d "@examples/curl_json_request" -H "X-US-SCENARIO: 200" -H "Content-Type: application/json" -v
```
*   Trying 127.0.0.1:10003...
* Connected to localhost (127.0.0.1) port 10003 (#0)
> POST /microservice/myservice HTTP/1.1
> Host: localhost:10003
> User-Agent: curl/7.79.1
> Accept: */*
> X-US-SCENARIO: 200
> Content-Type: application/json
> Content-Length: 19
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: application/json
< Matched-Stub-Id: df9b45d6-7e22-473a-ac12-3d72693ef837
< Transfer-Encoding: chunked
< Server: Jetty(9.2.z-SNAPSHOT)
< 
* Connection #0 to host localhost left intact
{"upstream":"You reach the upstream and your request its been processed."}
```

## Test the image - netcat examples

$ cat ./examples/nc_text_request | nc localhost 10003
```
HTTP/1.1 200 OK
Content-Type: application/json
Matched-Stub-Id: df9b45d6-7e22-473a-ac12-3d72693ef837
Server: Jetty(9.2.z-SNAPSHOT)

{"upstream":"You reach the upstream and your request its been processed."}
```

$ cat ./examples/nc_soap_request | nc localhost 10003
```
HTTP/1.1 200 OK
Content-Type: application/json
Matched-Stub-Id: df9b45d6-7e22-473a-ac12-3d72693ef837
Server: Jetty(9.2.z-SNAPSHOT)

{"upstream":"You reach the upstream and your request its been processed."}
```

$ cat ./examples/nc_text_request | nc localhost 10003
```
HTTP/1.1 200 OK
Content-Type: application/json
Matched-Stub-Id: df9b45d6-7e22-473a-ac12-3d72693ef837
Server: Jetty(9.2.z-SNAPSHOT)

{"upstream":"You reach the upstream and your request its been processed."}
```
