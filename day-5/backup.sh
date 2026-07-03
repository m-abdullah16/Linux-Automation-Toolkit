#!bin/bash
########################################################
###########################################################
$ mkdir -p ~/day5-practice/myapp
$ mkdir -p ~/day5-practice/backups
$ cd ~/day5-practice

# Create some fake app files to back up
$ echo "App version 1.0" > myapp/app.py
$ echo "DB_HOST=localhost" > myapp/config.env
$ echo "Hello World" > myapp/index.html
$ ls -la myapp/

