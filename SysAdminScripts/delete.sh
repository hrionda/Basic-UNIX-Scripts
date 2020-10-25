#CentOS
systemctl start mariadb
systemctl start mongod

while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $OS = "mac" ]
	then
		#MariaDB
		mysql -e "DELETE FROM $COUNTRY WHERE uid = '$USERNAME'" country
		mysql -e "DELETE FROM $FRUIT WHERE uid = '$USERNAME'" fruits
		#MongoDB
		echo "use country
		db.$COUNTRY.remove({'uid':'$USERNAME'})
		use fruits
		db.$FRUIT.remove({'uid':'$USERNAME'})" > /root/mongopart.js
		mongo < /root/mongopart.js
	fi
done <"/root/hrion001.csv"

#Fedora
systemctl start mariadb
systemctl start mongod

while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $OS = "windows" ]
	then
		#MariaDB
		mysql -e "DELETE FROM $COLOR WHERE uid = '$USERNAME'" color
		mysql -e "DELETE FROM $GENDER WHERE uid = '$USERNAME'" gender
		#MongoDB
		echo "use color
		db.$COLOR.remove({'uid':'$USERNAME'})
		use gender
		db.$GENDER.remove({'uid':'$USERNAME'})" > /root/mongopart.js
		mongo < /root/mongopart.js
	fi
done <"/root/hrion001.csv"
