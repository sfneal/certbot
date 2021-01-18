# certbot

[![Build Status](https://img.shields.io/travis/sfneal/actions/master.svg?style=flat-square)](https://travis-ci.org/sfneal/certbot)
[![Total Downloads](https://img.shields.io/docker/pulls/stephenneal/certbot?style=flat-square)](https://hub.docker.com/r/stephenneal/certbot)
[![Latest Version](https://img.shields.io/docker/v/stephenneal/certbot?style=flat-square)](https://hub.docker.com/r/stephenneal/certbot)


Certbot Docker image for managing Lets Encrypt SSL certificates.  Requests & validates certificates from a validation server (configured with environment vars) that can be shared with webserver containers through Docker volumes.

## Usage

Add a 'certbot' container with a certs volume that is shared with your webserver(s) to your docker-compose.yml.  

```yaml
certbot:
  image: stephenneal/certbot:v8
  container_name: certbot
  volumes:
    - certs:/etc/letsencrypt
  environment:
    - validation_domain=validation.example.com
    - email=user@example.com
    - staging=1 # use '1' for development environments
  depends_on:
    - webserver
  restart: "no"
```

When used in conjunction with stephenneal/nginx-* containers all of the domains being used by the webserver's will be written to a text file ('/etc/letsencrypt/domains.txt') that is parsed by the certbot to determine what domains to request certificates for.

## Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) for details.

### Security

If you discover any security related issues, please email stephen.neal14@gmail.com instead of using the issue tracker.

## Credits

- [Stephen Neal](https://github.com/sfneal)
- [All Contributors](../../contributors)

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.

## Laravel Package Boilerplate

This package was generated using the [Laravel Package Boilerplate](https://laravelpackageboilerplate.com).
