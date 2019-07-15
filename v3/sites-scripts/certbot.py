import os
from argparse import ArgumentParser

from dirutility import SystemCommand


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
        SystemCommand('domain={0} sh /sites-scripts/certify.sh'.format(domain))


if __name__ == '__main__':
    main()
