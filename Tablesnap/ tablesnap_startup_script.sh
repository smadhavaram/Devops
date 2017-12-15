#Add this script to etc/init.d/tablesnap
#After adding the script execute the following command (chkconfig --level 345 tablesnap on)
#After this we can execte the following commands in order to start and stop the tablesnap service
   service tablesnap start
	 service tablesnap stop
# Once the above commands are executed, tablesnap will automatically start during system bootup.

#(Script to add in /etc/init.d/tablesnap)

#!/bin/bash
# chkconfig: 2345 20 80
# description: Description comes here....

# Source function library.
. /etc/init.d/functions

TABLESNAP_CMD="/usr/local/bin/tablesnap"
AWS_REGION=""
AWS_ACCESS_KEY=""
AWS_SECURITY_KEY=""
AWS_S3_BUCKET=""
BACKUP_PATH=""


start() {
	echo "Starting tablesnap. Please check /var/log/tablesnap.log"
	nohup $TABLESNAP_CMD -B --aws-region $AWS_REGION -k $AWS_REGION -s $AWS_SECURITY_KEY $AWS_S3_BUCKET $BACKUP_PATH -a -r >> /var/log/tablesnap.log &
}

stop() {
	echo "Stopping tablesnap."
	killall -9 tablesnap
}

case "$1" in
    start)
       start
       ;;
    stop)
       stop
       ;;
    restart)
       stop
       start
       ;;
    *)
       echo "Usage: $0 {start|stop|restart}"
esac
