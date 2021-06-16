while IFS=, read COLOR
do
	sed -i 's/10.10./192.128./g' /etc/named/zones/db.$COLOR.hrion001.cts4348.fiu.edu
done <"colors.txt"
systemctl restart named
