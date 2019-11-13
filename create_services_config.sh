#https://github.com/containous/traefik/issues/3770
#I have the same problem. Backend stickyness as described in the documentation does not work with 1.7, while it works with 1.6 with the same configuration.


## Api
# apiblue
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apiblue/servers/api1/url -d 'http://api1blue:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apiblue/servers/api2/url -d 'http://api2blue:80'
# https://docs.traefik.io/v1.7/basics/#sticky-sessions
#curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apiblue/loadbalancer/stickiness/cookieName -d 'API_SERVICE' #не работает c большой буквы (cookieName)
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apiblue/loadbalancer/stickiness/cookiename -d 'API_SERVICE' 
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apiblue/loadbalancer/stickiness -d 'true' #нет в документации, искал в коде
#curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apiblue/loadbalancer/sticky -d 'true' #debreacated

# apigreen
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apigreen/servers/api1/url -d 'http://api1green:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apigreen/servers/api2/url -d 'http://api2green:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apigreen/loadbalancer/stickiness/cookiename -d 'API_SERVICE'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/apigreen/loadbalancer/stickiness -d 'true'

# api blue/green
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/frontends/api/routes/host/rule -d 'Host:api.localhost'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/frontends/api/backend -d 'apiblue'


## Auth 
# authblue
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authblue/servers/auth1/url -d 'http://auth1blue:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authblue/servers/auth2/url -d 'http://auth2blue:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authblue/loadbalancer/stickiness/cookiename -d 'AUTH_SERVICE' 
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authblue/loadbalancer/stickiness -d 'true'

# authgreen
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authgreen/servers/auth1/url -d 'http://auth1green:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authgreen/servers/auth2/url -d 'http://auth2green:80'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authgreen/loadbalancer/stickiness/cookiename -d 'AUTH_SERVICE'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/backends/authgreen/loadbalancer/stickiness -d 'true'

# auth blue/green
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/frontends/auth/routes/host/rule -d 'Host:auth.localhost'
curl -XPUT http://127.0.0.1:8500/v1/kv/traefik/frontends/auth/backend -d 'authblue'