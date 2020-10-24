#CentOS
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $GENDER = 'f' ]
	then
		MD5=$(echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$PERMISSION" | md5sum)
		echo "use country
		db.createCollection('$COUNTRY');
		db.$COUNTRY.insert({'uid':'$USERNAME','first':'$FNAME','last':'$LNAME','md5':'$MD5'});
		use fruits
		db.createCollection('$FRUIT');
		db.$FRUIT.insert({'uid':'$USERNAME','first':'$FNAME','last':'$LNAME','md5':'$MD5'});" > mongostep.js
		mongo < mongostep.js 
	fi
done <"hrion001.csv"

#Fedora
while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	if [ $GENDER = 'm' ]
	then
		MD5=$(echo "$USERNAME,$FNAME,$LNAME,$GENDER,$DOB,$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$PERMISSION" | md5sum)
		echo "use color
		db.createCollection('$COLOR');
		db.$COLOR.insert({'uid':'$USERNAME','first':'$FNAME','last':'$LNAME','md5':'$MD5'});
		use gender
		db.createCollection('$GENDER');
		db.$GENDER.insert({'uid':'$USERNAME','first':'$FNAME','last':'$LNAME','md5':'$MD5'});" > mongostep.js
		mongo < mongostep.js
	fi
done <"hrion001.csv"