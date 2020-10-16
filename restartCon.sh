# file name: restartCon.sh
# description: SSH to server and restart container

EXAMPLE="./restartCon.sh nextcloud 0"

# define name of container you want to restart
if [[ -z "$1" ]]
then
    echo "Container name is undefined. Exit."
    echo "Runtime example:"
    echo $EXAMPLE
    sleep 3
    exit 1
else
    CNAME=$1
fi

# define if privlidged or not [ 0 | 1 ]. if unset, make unprivlidged
if [[ -z "$2" ]] 
then 
    echo "Invalid PRIV defined. Exit."
    echo "Runtime example:"
    echo $EXAMPLE
    sleep 3
    exit 1
else
    PRIV=$2
fi

# prompt user to continue
read -p "Do you want to proceed with $CNAME restart?" -n 1 -r
echo # new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# get sudo password
export SSHPASS=$(cat .sshpassfile)

# check if directed to use Sudo or Not
if [[ $PRIV == 0 ]]
then
    echo "Restarting UNPRIV $CNAME"
    OUTPUT=$(sshpass -e ssh barn@192.168.1.32 "systemctl --user restart $CNAME")
elif [[ $PRIV == 1 ]]
then
    echo "Restarting PRIV $CNAME"
    OUTPUT=$(sshpass -e ssh barn@192.168.1.32 "echo $SSHPASS | sudo -S systemctl restart $CNAME")
fi

echo $OUTPUT
echo $OUTPUT >> restartCon.log
echo "END SCRIPT. OUTPUT added to restartCon.log"
sleep 3
exit 0