import sys
import os
from configparser import ConfigParser, ExtendedInterpolation
import argparse

def build(repo, tag, cpath):
    config = ConfigParser(interpolation=ExtendedInterpolation())
    print(repo,tag)
    config.read('{}.ini'.format(os.path.join(cpath,tag)))

    # Build base image recursively
    if config.has_option('config', 'base'):
        build(repo, config['config']['base'],cpath)
    
    dockerfile = f'dockerfiles/{config["config"]["dockerfile"]}'

    # Construct build command
    cmd = f'docker build -t {repo}:{tag} -f {dockerfile} '

    # Add repo name and base tag name as --build-arg
    cmd += f'--build-arg REPO={repo} '
    if config.has_option('config', 'base'):
        cmd += f'--build-arg BASE={config["config"]["base"]} '

    # Add additional build arguments
    if config.has_section('build_args'):
        for arg_name, arg_value in config['build_args'].items():
            cmd += f'--build-arg {arg_name.upper()}={arg_value} '

    # Add additional build options
    if config.has_option('config', 'options'):
        cmd += f'{config["config"]["options"]} '

    # Build path is current directory
    cmd += '.'

    # Execute build command, exit on error
    print('################################################################################')
    print(f'# Building \'{tag}\'')
    print(f'# Command: {cmd}')
    print('################################################################################')

    ret = os.system(cmd)
    if ret != 0:
        exit(ret)

    print('################################################################################')
    print(f'# Finished \'{tag}\'')
    print('################################################################################')

# python build.py --repo benjamintherien --tag cu12.2.2-py3.11.4 --cpath tags/l2o

if __name__ == '__main__':
    print(sys.argv[1])
    print('ok')
    name = sys.argv[1].split(':')


    parser = argparse.ArgumentParser(description="Parser for repo, tag, and cpath fields.")

    parser.add_argument('--repo', type=str, required=True, help='Repository name')
    parser.add_argument('--tag', type=str, required=True, help='Tag for the repository')
    parser.add_argument('--cpath', type=str, required=True, help='Path to the configuration file')

    args = parser.parse_args()

    print(f"Repo: {args.repo}")
    print(f"Tag: {args.tag}")
    print(f"CPath: {args.cpath}")


    build(args.repo, args.tag, args.cpath)
