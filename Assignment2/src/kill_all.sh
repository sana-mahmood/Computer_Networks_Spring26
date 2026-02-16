#!/bin/bash

pkill -9 sr_solution
pkill -9 sr_solution_macm
pkill -9 sr
pgrep pox | xargs kill -9
pgrep mininet | xargs kill -9
ps aux | grep topo | awk '{print $2}' | sudo xargs kill -9
ps aux | grep webserver | awk '{print $2}' | sudo xargs kill -9