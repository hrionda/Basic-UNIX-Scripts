#CentOS
#cat /root/hrion001.csv | cut -d, -f8 | sort -u > fruits.txt
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

#PantherID = 56756(97)
PNUM=8897
while IFS=, read FRUIT
do
	CreateVirtualHost $FRUIT $PNUM
	PNUM=$((PNUM+1))
done <"fruits.txt"

systemctl restart httpd

#Fedora

CreateVirtualHost() {
touch /etc/httpd/conf.d/hrion001/$1.conf
mkdir /var/www/$1
cat<<EOF > /etc/httpd/conf.d/hrion001/$1.conf
<VirtualHost *:$2>
	ServerName localhost 
	DocumentRoot /var/www/$1/
	SSLEngine on
	SSLCertificateFile /root/hrion001-selfsigned.crt
	SSLCertificateKeyFile /root/hrion001-selfsigned.key
</VirtualHost>
EOF
}

#PantherID = 56756(97)
PNUM=9997
while IFS=, read FRUIT
do
	CreateVirtualHost $FRUIT $PNUM
	PNUM=$((PNUM+1))
done <"fruits.txt"
systemctl restart httpd

