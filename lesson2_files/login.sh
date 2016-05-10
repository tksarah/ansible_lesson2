#!/bin/bash
HOST="${USER}_${1}"

case $1 in
        host)
                echo
                echo "Login Ansible Host... "
                echo
                docker exec -it $HOST bash
                echo ;;
        target)
                echo
                echo "Login Ansible Target... "
                echo
                docker exec -it $HOST bash
                echo ;;
        *)
                echo
                echo "=== USAGE ==="
                echo
                echo "ex)"
                echo "    # ./login.sh [host|target|]"
                echo
                echo "Description"
                echo "      host      : login ansible host"
                echo "      target    : login ansible target"
                echo
esac
