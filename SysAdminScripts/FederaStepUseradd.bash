firewall-cmd --add-port=443/tcp
firewall-cmd --add-port=80/tcp

while IFS=, read -r USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	groupadd -f "$COLOR"
	groupadd -f "$FRUIT"
	cd /home/
	mkdir -p /home/"$OS"/"$COUNTRY"/
	useradd -d /home/"$OS"/"$COUNTRY"/"$USERNAME" "$USERNAME"
	cd /home/"$OS"/"$COUNTRY"/"$USERNAME"/
	
	if [ $OS = "mac" ]
	then
		usermod -g "$COLOR" "$USERNAME"
		touch .DS_Store
		echo -e "$FNAME $LNAME\n$DOB" > about
	else
		usermod -g "$FRUIT" "$USERNAME"
		touch Thumbs.db
		echo -e "$LNAME $FNAME\n$SHELL" > about
	fi
done <"hrion001.csv"
