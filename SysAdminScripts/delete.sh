#MARIADB

#CentOS
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $OS = "mac" ]
	then
		mysql -e "DELETE FROM $COUNTRY WHERE uid = '$USERNAME'" country
		mysql -e "DELETE FROM $FRUIT WHERE uid = '$FRUIT'" fruits
	fi
done <"/root/hrion001.csv"

#Fedora
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $OS = "mac" ]
	then
		mysql -e "DELETE FROM $COLOR WHERE uid = '$USERNAME'" color
		mysql -e "DELETE FROM $GENDER WHERE uid = '$FRUIT'" gender
	fi
done <"/root/hrion001.csv"

#MONGODB

#CentOS
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $OS = "mac" ]
	then
		echo "use country
		db.$COUNTRY.remove({'uid':'$USERNAME'})
		use fruits
		db.$FRUIT.remove({'uid':'$USERNAME'})" > /root/mongopart.js
		mongo < /root/mongopart.js
	fi
done <"/root/hrion001.csv"
rm /root/mongopart.js

#Fedora
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $OS = "windows" ]
	then
		echo "use color
		db.$COLOR.remove({'uid':'$USERNAME'})
		use gender
		db.$GENDER.remove({'uid':'$USERNAME'})" > /root/mongopart.js
		mongo < /root/mongopart.js
	fi
done <"/root/hrion001.csv"
rm /root/mongopart.js