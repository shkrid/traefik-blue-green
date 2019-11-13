# Run and configure:
```
$ docker-compose up -d
$ ./create_traefik_config.sh
$ ./create_services_config.sh
```

# Api service:
```
$ curl -H "Host:api.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: API_SERVICE=http://api2blue:80; Path=/
Hostname: 5d7bffa761c5
$ curl -H "Host:api.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: API_SERVICE=http://api1blue:80; Path=/
Hostname: ff85f81fa286
```

# Check stickness:
```
$ curl -H "Host:api.localhost" -v -b "API_SERVICE=http://api1blue:80" http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
Hostname: ff85f81fa286
$ curl -H "Host:api.localhost" -v -b "API_SERVICE=http://api1blue:80" http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
Hostname: ff85f81fa286
```

# Switch to green:
```
$ ./green.sh
$ curl -H "Host:api.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: API_SERVICE=http://api2green:80; Path=/
Hostname: dc237c7df8f9
$ curl -H "Host:api.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: API_SERVICE=http://api1green:80; Path=/
Hostname: f92e48ecbfa0
```

# Switch back to blue:
```
$ ./blue.sh
$ curl -H "Host:api.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: API_SERVICE=http://api1blue:80; Path=/
Hostname: ff85f81fa286
$ curl -H "Host:api.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: API_SERVICE=http://api2blue:80; Path=/
Hostname: 5d7bffa761c5
```

# Auth service:
```
$ curl -H "Host:auth.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: AUTH_SERVICE=http://auth1blue:80; Path=/
Hostname: 988d3bf91114
$ curl -H "Host:auth.localhost" -v http://127.0.0.1:80 2>&1 | grep "Set-Cookie\|Hostname"
< Set-Cookie: AUTH_SERVICE=http://auth2blue:80; Path=/
Hostname: 5c50fc3b8db7
```
