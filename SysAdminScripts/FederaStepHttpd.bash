firewall-cmd --add-port=21/tcp
firewall-cmd --add-port=22/tcp
firewall-cmd --add-port=53/tcp
firewall-cmd --add-port=143/tcp
firewall-cmd --add-port=443/tcp

yes | dnf install httpd
systemctl start httpd

cat /root/hrion001.csv | cut -d, -f1-4 > begin
cat /root/hrion001.csv | cut -d, -f5 | sed 's/ .*//' > months
cat /root/hrion001.csv | cut -d, -f6-11 > end
paste -d ',' begin months end > inputfile.csv

while IFS=, read -r USERNAME FNAME LNAME GENDER MONTH COUNTRY COLOR FRUIT OS SHELL PERMISSION
do
	cd /var/www/html/
    mkdir -p "$PERMISSION"/"$MONTH"
	cd "$PERMISSION"/"$MONTH"
	echo "$COUNTRY,$COLOR,$FRUIT,$OS,$SHELL,$USERNAME,$FNAME,$LNAME,$GENDER" >> index.html
done <"inputfile.csv"

rm /root/begin
rm /root/months
rm /root/end
rm /root/inputfile.csv