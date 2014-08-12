#!/bin/bash

BASENAME=foreman_el6
NUM=1
BACKING_FILE=/home/images/rhel6.qcow2
SIZE=10
RAM=4096
#PUBLIC_KEY="$(<~sstar/.ssh/id_rsa.pub)"
PUBLIC_KEY="$(</home/sstar/.vagrant.d/insecure_public_key.pub)"
ROOT_PASSWORD=redhat

# Additional options
DISK_POOL=default
NETWORK=default
VCPUS=2

# Specify app paths here, so we can change them if needed
QEMU_IMG=$(which qemu-img)
VIRT_INSTALL=$(which virt-install)
VIRSH=$(which virsh)

# Inferred variables
POOL_PATH=$(virsh pool-dumpxml "$DISK_POOL" | xml_grep '/pool/target/path'  --text_only)
if [[ -z $POOL_PATH ]]; then
    echo "Unable to determine filesystem path for pool '$DISK_POOL'." 2>/dev/null
    echo "Only 'dir' type pools are currently supported." 2>/dev/null
    exit 1
fi

# Parse command line arguments

function create_guests(){
    for n in $(eval echo {1..$NUM}); do
        NAME=${BASENAME}-i${n}
        OUTPUT_FILE=/var/lib/libvirt/images/${NAME}.qcow2

        # Create our guests overlay image based on our chosen backing file
        $QEMU_IMG create -f qcow2 -o backing_file=$BACKING_FILE $OUTPUT_FILE

        # Refresh our pool so that we can see the new disk.
        $VIRSH pool-refresh $DISK_POOL

        # Run some setup steps against the image
        setup_guests

        # Use virt-install to setup our libvirt guest
        $VIRT_INSTALL \
            --name $NAME \
            --memory=$RAM \
            --vcpus=$VCPUS \
            --import \
            --disk vol=${DISK_POOL}/$(basename $OUTPUT_FILE),bus=virtio \
            --network=${NETWORK},model=virtio \
            --console pty,target_type=virtio \
            --graphics spice \
            --noautoconsole

    done
}

function delete_guests(){
    for n in $(eval echo {1..$NUM}); do
        NAME=${BASENAME}-i${n}

        virsh destroy ${NAME}
        virsh undefine --remove-all-storage ${NAME}

    done
}

function setup_guests(){
    # Set SSH root keys and password
    if [[ -z "$ROOT_PASSWORD" ]]; then pass=$(getPass); else pass=$ROOT_PASSWORD; fi
    virt-customize -a $OUTPUT_FILE --run-command "fgrep -q \"$PUBLIC_KEY\" /root/authorized_keys && echo \"Key already exists.\" || mkdir -p -m 0700 /root/.ssh; echo \"$PUBLIC_KEY\" >> /root/.ssh/authorized_keys" --root-password "password:$pass" --hostname $NAME

}

function usage(){
    echo "Usage $0 (create|delete|status)"
}

function getPass(){
    python -c "import string, random; print \"\".join([random.choice(string.letters + string.digits) for i in range(8)])"
}

case $* in

    create)
        create_guests
        ;;

    delete)
        delete_guests
        ;;

    status)
        # Todo
        echo "Not implemented"
        ;;

    *)
        usage
        ;;

esac
