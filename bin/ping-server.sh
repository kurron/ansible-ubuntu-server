#!/bin/bash

ansible atlantis -vvvvv --module-name ping
ansible stargate -vvvvv --module-name ping
