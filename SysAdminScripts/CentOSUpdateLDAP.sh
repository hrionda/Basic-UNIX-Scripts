#Add permissions to groups
cat hrion001.csv | cut -d, -f11 | sort -u > /root/permlist.txt
PNUM=123
while IFS=, read PERMISSION
do
echo "dn: cn=$PERMISSION,dc=hrion001,dc=fiu,dc=edu
objectClass: top
objectClass: posixGroup
gidNumber: $PNUM
" | ldapadd -x -D cn=admin,dc=hrion001,dc=fiu,dc=edu -w 5675697
PNUM=$((PNUM+1))
done <"/root/permlist.txt"
rm /root/permlist.txt


while IFS=, read USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUITS OS SHELL PERMISSION 
do
#Remove Windows OS users, Add Mac OS users to perm groups
	if [ $OS = "windows" ]
	then
		echo "dn: cn=$COLOR,dc=hrion001,dc=fiu,dc=edu
changetype: modify
delete: memberuid
memberuid: $USERNAME
" | ldapmodify -x -D cn=admin,dc=hrion001,dc=fiu,dc=edu -w 5675697
	elif [ $OS = "mac" ]
	then
		echo "dn: cn=$PERMISSION,dc=hrion001,dc=fiu,dc=edu
changetype: modify
add: memberuid
memberuid: $USERNAME
" | ldapmodify -x -D cn=admin,dc=hrion001,dc=fiu,dc=edu -w 5675697
	fi

done <"/root/hrion001.csv"