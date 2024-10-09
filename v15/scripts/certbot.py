import os
import shutil
from argparse import ArgumentParser

from dirutility import TextDump
from requests import get


DOMAINS_FILE = '/etc/letsencrypt/domains.txt'


def console_sep(char='- ', length=40):
    """Return a separator line to the console output."""
    return ''.join([char * length])


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


def main():
    # Declare argparse argument descriptions
    usage = 'certbot Certificate Manager.'
    description = 'Manage Lets Encrypt SSL certificates.'
    helpers = {
        'domain': "List of domain names separated by spaces.",
        'email': "Letsencrypt account email address.",
        'staging': "Enable/disable staging environment for dev configs.",
        'validation-domain': "SSL validation server domain.",
    }

    # construct the argument parse and parse the arguments
    parser = ArgumentParser(usage=usage, description=description)
    parser.add_argument('--domains', help=helpers['domain'],
                        default=TextDump(DOMAINS_FILE).read().splitlines())
    parser.add_argument('--email', help=helpers['email'], type=str)
    parser.add_argument('--staging', help=helpers['staging'], type=int, default=1)
    parser.add_argument('--validation-domain', help=helpers['validation-domain'], type=str)

    # Parse Arguments
    args = vars(parser.parse_args())
    if isinstance(args['domains'], str):
        args['domains'] = args['domains'].strip().split(' ')

    # Send request to validation server
    for domain in args['domains']:
        print('Domain: {0}'.format(domain))
        print('### Sending cert request for domain {} to the validation server...'.format(domain))
        response = get('http://' + args['validation_domain'] + '/cert', params={'domain': domain,
                                                                                'email': args['email'],
                                                                                'staging': args['staging']})
        print('\n' + response.text)
        print('### Received response to cert request for domain {} from the validation server...'.format(domain))


if __name__ == '__main__':
    main()
