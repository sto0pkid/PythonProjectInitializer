#!/bin/bash

# Arguments:
# project name
# project directory
# project version
# Python version
# project dependencies

for i in "$@"
do
case $i in
    -n=*|--name=*)
    PROJECT_NAME="${i#*=}"
    shift # past argument=value
    ;;
    -d=*|--dir=*)
    PROJECT_DIRECTORY="${i#*=}"
    shift # past argument=value
    ;;
    -v=*|--version=*)
    PROJECT_VERSION="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

# handle Python version

# if not exists (project directory):
if [ ! -d $PROJECT_DIRECTORY ]; then
 mkdir $PROJECT_DIRECTORY
fi
cd $PROJECT_DIRECTORY
git init

# setup Python virtual environment
# http://thefourtheye.in/2014/12/30/Python-venv-problem-with-ensurepip-in-Ubuntu/
python3 -m venv venv --without-pip

source venv/bin/activate
# install dependencies
# pip
# https://bootstrap.pypa.io/
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
# test that pip installed properly
rm get-pip.py 

# make and git add (project directory)/setup.py file
echo -e "from setuptools import setup, find_packages\n\nsetup(\n\tname=\"${PROJECT_NAME}\",\n\tversion=\"${PROJECT_VERSION}\",\n\tpackages=find_packages()\n)" > setup.py
git add setup.py

# make and git add (project directory)/README.md file
echo -e "# ${PROJECT_NAME} v. ${PROJECT_VERSION}" > README.md
git add README.md
#	README contents?

# make source directory:
mkdir src

# make and git add (project directory)/src/__init__.py file
echo -e "" > src/__init__.py
git add src/__init__.py

# check pip installation
# pip install the package in editable/develop mode
#pip install -e .
# check the installation

# make first commit
git commit -a -m "Initializing ${PROJECT_NAME} repository"
