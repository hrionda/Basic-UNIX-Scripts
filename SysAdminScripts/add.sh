#CentOS
systemctl start mariadb
systemctl start mongod

mysql -e "CREATE DATABASE shells"

while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $GENDER = 'f' ]
	then
		MD5=$(echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$PERMISSION" | md5sum)
		NEWSHELL=$(echo "$SHELL" | sed 's*/bin/**g')
		#MariaDB
		mysql -e "CREATE TABLE IF NOT EXISTS $NEWSHELL (uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255));" shells
		mysql -e "INSERT INTO $NEWSHELL (uid, first, last, md5) VALUES ('$USERNAME', '$FNAME', '$LNAME', '$MD5');" shells
		#MongoDB
		echo "use shells
		db.createCollection('$NEWSHELL');
		db.$NEWSHELL.insert({'uid':'$USERNAME','first':'$FNAME','last':'$LNAME','md5':'$MD5'});" > mongostep.js
		mongo < mongostep.js
	fi
done <"/root/hrion001.csv"

#Fedora
systemctl start mariadb
systemctl start mongod

mysql -e "CREATE DATABASE shells"

while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $GENDER = 'm' ]
	then
		MD5=$(echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$PERMISSION" | md5sum)
		NEWSHELL=$(echo "$SHELL" | sed 's*/bin/**g')
		#MariaDB
		mysql -e "CREATE TABLE IF NOT EXISTS $NEWSHELL (uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255));" shells
		mysql -e "INSERT INTO $NEWSHELL (uid, first, last, md5) VALUES ('$USERNAME', '$FNAME', '$LNAME', '$MD5');" shells
		#MongoDB
		echo "use shells
		db.createCollection('$NEWSHELL');
		db.$NEWSHELL.insert({'uid':'$USERNAME','first':'$FNAME','last':'$LNAME','md5':'$MD5'});" > mongostep.js
		mongo < mongostep.js
	fi
done <"/root/hrion001.csv"
