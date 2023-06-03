To init project run:
```
make init
```

Use composer:
```
ARGS="require --dev phpunit" make composer install
```

Add local generated certs to authority if necessary (Ubuntu 22.04 example): 
```
make cert
sudo sh -c 'rm -f /usr/local/share/ca-certificates/game-local.crt | cp ./nginx/cert.pem /usr/local/share/ca-certificates/game-local.crt'
sudo update-ca-certificates
```