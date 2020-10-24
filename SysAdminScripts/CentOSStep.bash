while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	cd /home/
	useradd -d /home/"$OS"/"$COUNTRY"/"$USERNAME" "$USERNAME"
	cd /home/"$OS"/"$COUNTRY"/"$USERNAME"/
	
	if [ $OS = "mac" ]
	then
		usermod -g "$COLOR" "$USERNAME"
		touch .DS_Store
		echo "$FNAME $LNAME
		$DOB" > about
	else
		usermod -g "$FRUIT" "$USERNAME"
		touch Thumbs.db
		echo "$FNAME $LNAME
		$SHELL" > about
	fi
done <"hrion001.csv"
