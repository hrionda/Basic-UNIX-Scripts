CNUM=97
while IFS=, read COLOR
do
#This server doesn't exist anymore; don't try to access it.
echo "zone \"$COLOR.hrion001.cts4348.fiu.edu\" {
    type master;
    file \"/etc/named/zones/db.$COLOR.hrion001.cts4348.fiu.edu\"; 
};
" >> /etc/named/hrion001.conf.local

echo "\$TTL    604800
@       IN      SOA     ns1.cts4348.fiu.edu. hrion001.cts4348.fiu.edu. (
                              3         ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800 )   ; Negative Cache TTL

    IN      NS      ns1.cts4348.fiu.edu.
    IN      NS      ns2.cts4348.fiu.edu.
" >> /etc/named/zones/db.$COLOR.hrion001.cts4348.fiu.edu

#Add zone info for users of same color
UNUM=1
while IFS=, read USERNAME COL
do
	if [ $COL = $COLOR ]
	then
		echo "$USERNAME IN A 10.10.$CNUM.$UNUM" >> /etc/named/zones/db.$COLOR.hrion001.cts4348.fiu.edu
		UNUM=$((UNUM+1))
	fi
done <"namecolor.txt"

CNUM=$((CNUM+1))
done <"colors.txt"

#restart named after changes
systemctl restart named
