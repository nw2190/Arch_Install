#!/bin/bash

echo "Stopping    netctl-auto@wlp2s0..."
sudo systemctl stop netctl-auto@wlp2s0

sleep 10

echo "Restarting  netctl-auto@wlp2s0..."
sudo systemctl start netctl-auto@wlp2s0

sleep 10

echo "Ping Results:"
ping -c 5 www.google.com
