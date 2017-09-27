#!/usr/bin/python

import os
import argparse
import json
import subprocess

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument('--list',
                   action='store_true')
    p.add_argument('--host')
    return p.parse_args()

def get_hosts():
    hosts = subprocess.check_output([
        'heat', 'output-show', 'heat1', 'Appservers_ip'])

    hosts = json.loads(hosts)
    return hosts

def main():
    args = parse_args()

    hosts = get_hosts()

    if args.list:
        print json.dumps(dict(all=hosts))
    elif args.host:
        print json.dumps({})
    else:
        print 'Use --host or --list'
        print hosts

if __name__ == '__main__':
    main()
