while IFS=, read -r USERNAME GENDER COLOR FRUIT PERMISSION
do
	if [ $GENDER = 'm' ]
	then
		mysql -e "GRANT $PERMISSION ON *.* to $USERNAME@'%' IDENTIFIED by '$COLOR'"
	else
		mysql -e "GRANT $PERMISSION ON *.* to $USERNAME@'%' IDENTIFIED by '$FRUIT'"
	fi 
done <"allusers.txt"


useradd [user] -p [pass] -c '[comment]'
htpasswd -b /var/www/html/.htpasswd [user] [pass]
mysql -e "GRANT ALL ON *.* TO [user]@'%' IDENTIFIED BY '[password]'"
