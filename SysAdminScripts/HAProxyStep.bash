#Ubuntu
AddProxy() {
echo "
frontend  main
    bind :$2
    default_backend $1
 
backend $1
    balance     roundrobin
    server  $FRUIT 10.128.1.137:$3
    server  $FRUIT 10.128.1.138:$4" >> /etc/haproxy/haproxy.cfg
}

PNUM=7797
CNUM=8897
FNUM=9997
while IFS=, read FRUIT
do
	AddProxy $FRUIT $PNUM $CNUM $FNUM
	PNUM=$((PNUM+1))
	CNUM=$((CNUM+1))
	FNUM=$((FNUM+1))
done <"fruits.txt"
systemctl restart haproxy