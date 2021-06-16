#Add LDAP groups
GNUM=678

while IFS=, read COLOR
do
echo "dn: cn=$COLOR,dc=hrion001,dc=fiu,dc=edu
objectClass: top
objectClass: posixGroup
gidNumber: $GNUM
" | ldapadd -x -D cn=admin,dc=hrion001,dc=fiu,dc=edu -w 5675697

GNUM=$((GNUM+1))
done <"colors.txt"
systemctl restart slapd

#Adding LDAP users and adding them to their respective group
while IFS=, read USERNAME FNAME LNAME GENDER DOB COUNTRY COLOR FRUITS OS SHELL PERMISSION 
do

echo "dn: uid=$USERNAME,dc=hrion001,dc=fiu,dc=edu
uid: $USERNAME
objectClass: person
objectClass: top
objectClass: inetOrgPerson
sn: $LNAME
cn: $FNAME
mobile: $GENDER
description: $DOB
title: $SHELL
" | ldapadd -x -D cn=admin,dc=hrion001,dc=fiu,dc=edu -w 5675697

echo "dn: cn=$COLOR,dc=hrion001,dc=fiu,dc=edu
changetype: modify
add: memberuid
memberuid: $USERNAME
" | ldapmodify -x -D cn=admin,dc=hrion001,dc=fiu,dc=edu -w 5675697
done <"hrion001.csv"

#check work with ldapsearch -x -b 'dc=fiu,dc=edu'