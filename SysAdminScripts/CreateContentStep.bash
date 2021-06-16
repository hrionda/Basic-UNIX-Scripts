#CentOS
while IFS=, read USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUITS OS SHELL PERMISSION 
do
	MONTH=$(echo "$DOB" | sed 's\ .*\\g')
	if [ $MONTH = "january" ] || [ $MONTH = "march" ] || [ $MONTH = "may" ] || [ $MONTH = "july" ] || [ $MONTH = "september" ] || [ $MONTH = "november" ]
	then
		echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUITS,$OS,$SHELL,$PERMISSION" >> /var/www/$FRUITS/index.html
	fi
done <"hrion001.csv"

systemctl restart httpd

#Fedora
while IFS=, read USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUITS OS SHELL PERMISSION 
do
	MONTH=$(echo "$DOB" | sed 's\ .*\\g')
	if [ $MONTH = "february" ] || [ $MONTH = "april" ] || [ $MONTH = "june" ] || [ $MONTH = "august" ] || [ $MONTH = "october" ] || [ $MONTH = "december" ]
	then
		echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUITS,$OS,$SHELL,$PERMISSION" >> /var/www/$FRUITS/index.html
	fi
done <"hrion001.csv"

systemctl restart httpd