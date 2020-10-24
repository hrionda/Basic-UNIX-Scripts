echo Hello my name is: Hector Rionda
echo Hello my user name is: `whoami`
echo Todays date and time is: `date`
echo This file has `cat basicscript.sh | wc -l` lines
echo This file has `cat basicscript.sh | wc -w` words
echo This file has `cat basicscript.sh | wc -c` bytes

echo Please enter any number
read NUMBER
echo Your number $NUMBER \* 2 = `expr $NUMBER \* 2`
echo Press any key to continue...
read keyboard
clear

echo Enter a line of numbers, leaving one space between each number
read LINE

ADDING=0
for NUM in $LINE
do
sleep 1
echo $NUM
ADDING=`expr $ADDING + $NUM`
done
echo $LINE = $ADDING

#This loop will end when any number wholly divisible by 5 is entered.
while true
do
echo Enter a number
read INPUT
RESULT=`expr $INPUT % 5`
if [ $RESULT -lt 0 ] || [ $RESULT -gt 0 ]; then
echo $INPUT mod 5 = $RESULT
else
echo $INPUT mod 5 = $RESULT
break
fi
done


