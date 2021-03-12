#!/bin/bash

checkandstartvboxvm()
{
    vm=$1

    saved=$(vboxmanage showvminfo "$vm" | grep -E -c -i "State:[[:space:]]+saved")

    if [ "$saved" != "0" ]; then
        VBoxManage startvm "$vm"

        sleep 5s

        while true; do
            poweredoff=$(vboxmanage showvminfo "$vm" | grep -E -c -i "State:[[:space:]]+powered off")
            if [ "$poweredoff" == "1" ]; then
                break
            fi

            sleep 10s
        done
    fi
}

VBoxManage list vms -s | awk '{print $NF}' | while read line; do checkandstartvboxvm "$line" ; done

exit 0

