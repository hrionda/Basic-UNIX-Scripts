#CentOS
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $GENDER = 'f' ]
	then
		MD5=$(echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$PERMISSION" | md5sum)
		mysql -e "CREATE TABLE IF NOT EXISTS $COUNTRY (uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255));" country
		mysql -e "INSERT INTO $COUNTRY (uid, first, last, md5) VALUES ('$USERNAME', '$FNAME', '$LNAME', '$MD5');" country
		mysql -e "CREATE TABLE IF NOT EXISTS $FRUIT (uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255));" fruits
		mysql -e "INSERT INTO $FRUIT (uid, first, last, md5) VALUES ('$USERNAME', '$FNAME', '$LNAME', '$MD5');" fruits
	fi
done <"hrion001.csv"

#Fedora
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $GENDER = 'm' ]
	then
		MD5=$(echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$PERMISSION" | md5sum)
		mysql -e "CREATE TABLE IF NOT EXISTS $COLOR (uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255));" color
		mysql -e "INSERT INTO $COLOR (uid, first, last, md5) VALUES ('$USERNAME', '$FNAME', '$LNAME', '$MD5');" color
		mysql -e "CREATE TABLE IF NOT EXISTS $GENDER (uid varchar(255), first varchar(255), last varchar(255), md5 varchar(255));" gender
		mysql -e "INSERT INTO $GENDER (uid, first, last, md5) VALUES ('$USERNAME', '$FNAME', '$LNAME', '$MD5');" gender
	fi
done <"hrion001.csv"