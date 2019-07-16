import os
from argparse import ArgumentParser

from dirutility import SystemCommand


def letsencrypt_cert_cleaner(domain, root='/etc/letsencrypt/', paths=('live', 'archive', 'renewal')):
    """Remove Letsencrypt directories that contain dummy certs and .conf's."""
    domain = domain.strip()
    for path in (os.path.join(root, p) for p in paths):
        # Renewal conf's
        if path.endswith('renewal'):
            os.remove(os.path.join(path, domain + '.conf'))

        # Live & archive certs
        else:
            os.remove(os.path.join(path, domain))


def main():
    # Declare argparse argument descriptions
    usage = 'AWS S3 command-line-interface wrapper.'
    description = 'Execute AWS S3 commands.'
    helpers = {
        'domain': "List of domain names separated by spaces.",
    }

    # construct the argument parse and parse the arguments
    parser = ArgumentParser(usage=usage, description=description)
    parser.add_argument('--domains', help=helpers['domain'], type=str)

    # Parse Arguments
    args = vars(parser.parse_args())
    args['domains'] = args['domains'].split(' ')

    # Run certify.sh for each domain
    for domain in args['domains']:
        # Clean directories
        letsencrypt_cert_cleaner(domain)

        # Execute certbot command
        SystemCommand('domain={0} sh /sites-scripts/certify.sh'.format(domain))


if __name__ == '__main__':
    main()
