#!/bin/bash

INVENTORY=$HOME/lesson2_files/tools/hosts
PLAYBOOK=$HOME/lesson2_files/tools/playbook.yml
HOSTADDR="192.168.166.210"
WP="${USER}_wordpress"

case $1 in
        up)
                echo
                echo "Setup ..."
                ansible-playbook -i $INVENTORY -t bootup -e user=$USER $PLAYBOOK $2
                CPORT=`/bin/docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' ${USER}_target | gawk '{ print $3 }'`
                echo
                echo "========================================================="
                echo
                echo "Try the link below after executing the ansible playbook."
                echo
                echo "http://$HOSTADDR:$CPORT/$WP/ ."
                echo
                echo "========================================================="
                echo ;;
        stop)
                echo
                echo "Stopping ..."
                ansible-playbook -i $INVENTORY -t remove -e "user=$USER  ops=stopped" $PLAYBOOK $2;;
        delete)
                echo
                echo "Deleting ..."
                ansible-playbook -i $INVENTORY -t remove -e "user=$USER  ops=absent" $PLAYBOOK $2;;
        restart)
                echo
                echo "Restarting ..."
                ansible-playbook -i $INVENTORY -t remove -e user=$USER $PLAYBOOK $2
                sleep 1
                ansible-playbook -i $INVENTORY -t bootup -e user=$USER $PLAYBOOK $2
                CPORT=`/bin/docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' ${USER}_target | gawk '{ print $3 }'`
                echo
                echo "========================================================="
                echo
                echo "Try the link below after executing the ansible playbook."
                echo
                echo "http://$HOSTADDR:$CPORT/$WP/ ."
                echo
                echo "========================================================="
                echo ;;
        *)
                echo
                echo "=== USAGE ==="
                echo
                echo "ex)"
                echo "    # ./setup.sh [up|remove|restart] [-v]"
                echo
                echo "Description"
                echo "      up      : Bootup containers"
                echo "      stop    : Stop containers"
                echo "      delete  : Delete containers"
                echo "      restart : Deleate and Bootup containers"
                echo
esac
