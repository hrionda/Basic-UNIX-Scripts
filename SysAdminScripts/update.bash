#CentOS

CreateVirtualHost() {
touch /etc/httpd/conf.d/hrion001/$1.conf
mkdir /var/www/$1
cat<<EOF > /etc/httpd/conf.d/hrion001/$1.conf
Listen $2
<VirtualHost *:$2>
	ServerName localhost 
	DocumentRoot /var/www/$1/
	SSLEngine on
	SSLCertificateFile /root/hrion001-selfsigned.crt
	SSLCertificateKeyFile /root/hrion001-selfsigned.key
</VirtualHost>
EOF
}

#Clearing hrion001
yes | rm -r /etc/httpd/conf.d/hrion001
mkdir /etc/httpd/conf.d/hrion001

#Clearing /var/www of fruit folders
cat /root/hrion001.csv | cut -d, -f8 | sort -u > /root/fruitlist.txt
while IFS=, read FRUIT
do
	rm -r /var/www/$FRUIT
done <"/root/fruitlist.txt"
rm /root/fruitlist.txt

#Changing httpd config files
#PantherID = 56756(97)
cat /root/hrion001.csv | cut -d, -f9 | sort -u > /root/operatingsystems.txt
PNUM=8897
while IFS=, read OS
do
	CreateVirtualHost $OS $PNUM
	PNUM=$((PNUM+1))
done <"/root/operatingsystems.txt"
rm /root/operatingsystems.txt

#Changing index.html files
while IFS=, read USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUITS OS SHELL PERMISSION 
do
	MONTH=$(echo "$DOB" | sed 's\ .*\\g')
	if [ $MONTH = "january" ] || [ $MONTH = "march" ] || [ $MONTH = "may" ] || [ $MONTH = "july" ] || [ $MONTH = "september" ] || [ $MONTH = "november" ]
	then
		echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUITS,$OS,$SHELL,$PERMISSION" >> /var/www/$OS/index.html
	fi
done <"/root/hrion001.csv"

#Preparation for relaunch
firewall-cmd --remove-port=8897-8916/tcp
firewall-cmd --add-port=8897/tcp
firewall-cmd --add-port=8898/tcp
setenforce 0
systemctl restart httpd


#Ubuntu

echo "global
    log 127.0.0.1 local0 notice
    maxconn 2000
    user haproxy
    group haproxy

defaults
    log     global
    mode    tcp
    timeout connect  5000
    timeout client  10000
    timeout server  10000
	
frontend  mac
    bind :7797
    default_backend mac
 
backend mac
    balance     roundrobin
    server  mac1 10.128.1.137:8897
    server  mac2 10.128.1.138:9997
	
frontend  windows
    bind :7798
    default_backend windows
	
backend windows
    balance     roundrobin
    server  windows1 10.128.1.137:8898
    server  windows2 10.128.1.138:9998" > /etc/haproxy/haproxy.cfg

systemctl restart haproxy


#Fedora

CreateVirtualHost() {
touch /etc/httpd/conf.d/hrion001/$1.conf
mkdir /var/www/$1
cat<<EOF > /etc/httpd/conf.d/hrion001/$1.conf
Listen $2
<VirtualHost *:$2>
	ServerName localhost 
	DocumentRoot /var/www/$1/
	SSLEngine on
	SSLCertificateFile /root/hrion001-selfsigned.crt
	SSLCertificateKeyFile /root/hrion001-selfsigned.key
</VirtualHost>
EOF
}

#Clearing hrion001
yes | rmdir -r /etc/httpd/conf.d/hrion001
mkdir /etc/httpd/conf.d/hrion001

#Clearing /var/www of fruit folders
cat /root/hrion001.csv | cut -d, -f8 | sort -u > /root/fruitlist.txt
while IFS=, read FRUIT
do
	rmdir -r /var/www/$FRUIT
done <"/root/fruitlist.txt"
rm /root/fruitlist.txt

#Changing httpd config files
#PantherID = 56756(97)
cat /root/hrion001.csv | cut -d, -f9 | sort -u > /root/operatingsystems.txt
PNUM=9997
while IFS=, read OS
do
	CreateVirtualHost $OS $PNUM
	PNUM=$((PNUM+1))
done <"/root/operatingsystems.txt"
rm /root/operatingsystems.txt

#Changing index.html files
while IFS=, read USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUITS OS SHELL PERMISSION 
do
	MONTH=$(echo "$DOB" | sed 's\ .*\\g')
	if [ $MONTH = "february" ] || [ $MONTH = "april" ] || [ $MONTH = "june" ] || [ $MONTH = "august" ] || [ $MONTH = "october" ] || [ $MONTH = "december" ]
	then
		echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUITS,$OS,$SHELL,$PERMISSION" >> /var/www/$OS/index.html
	fi
done <"/root/hrion001.csv"

#Preparation for relaunch
firewall-cmd --remove-port=9997-10016/tcp
firewall-cmd --add-port=9997/tcp
firewall-cmd --add-port=9998/tcp
setenforce 0
systemctl restart httpd

