#!/bin/bash

tz=$(curl https://ipapi.co/timezone)
sudo timedatectl set-timezone "${tz}"
