#!/bin/bash
/usr/local/tomcat9/bin/startup.sh
chown -R tomcat:tomcat /usr/local/tomcat9/webapps/uptime/
python3.8 /root/exercise.py 
