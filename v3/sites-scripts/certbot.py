import os
import shutil
from argparse import ArgumentParser


def letsencrypt_cert_cleaner(domain, root='/etc/letsencrypt/', paths=('live', 'archive', 'renewal')):
    """Remove Letsencrypt directories that contain dummy certs and .conf's."""
    domain = domain.strip()
    for path in (os.path.join(root, p) for p in paths):
        # Renewal conf's
        if path.endswith('renewal'):
            removal = os.path.join(path, domain + '.conf')

        # Live & archive certs
        else:
            removal = os.path.join(path, domain)

        # Delete file/directory
        status = 'Success'
        try:
            os.remove(removal)
        except IsADirectoryError:
            shutil.rmtree(removal)
        except FileNotFoundError:
            status = 'Skipped' if not os.path.exists(removal) else 'Error'
        print('{0} deleting: {1}'.format(status, removal))


def domain_args(domains):
    """Return a string of domain arguments to pass to certbot."""
    return ' ' + ' '.join(['-d {0}'.format(domain) for domain in domains])


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

    # Clean directories for each domain
    # for domain in args['domains']:
    #     letsencrypt_cert_cleaner(domain)

    # Execute certbot command
    print("### Requesting Let's Encrypt certificate for {0} ...".format(' '.join(args['domains'])))
    os.system('domain_args="{0}" sh /sites-scripts/certify.sh'.format(domain_args(args['domains'])))


if __name__ == '__main__':
    main()
