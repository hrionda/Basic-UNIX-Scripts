#Part 1: Division by Zero
echo Section One: Division
touch results.txt
echo `whoami` >> results.txt
echo `date` >> results.txt

#This loop will end if the user enters 44 as either one of the two number inputs.
while true
do
	echo Enter your first number:
	read NUMBER1
	if [ $NUMBER1 -eq 44 ]
	then break
	fi

	echo Enter your second number:
	read NUMBER2

	if [ $NUMBER2 -eq 44 ]
	then break
	elif [ $NUMBER2 -eq 0 ]
	then
		while [ $NUMBER2 -eq 0 ]
		do
			echo You cannot divide by zero. Please enter another number:
			read NUMBER2
		done
	fi

	echo $NUMBER1 divided by $NUMBER2 = `expr $NUMBER1 / $NUMBER2`
	echo $NUMBER1 divided by $NUMBER2 = `expr $NUMBER1 / $NUMBER2` >> results.txt
done
#All solutions to the given inputs will be sent to an output file, results.txt.

clear

#Part 2: Counting ACGT Substrings
echo Section 2: Counting ACGT Substrings

COUNT=`head -n 1995 hs_alt_HuRef_chr10.fa | grep -o ACGT | wc -w`

echo There are $COUNT ACGT substrings inside this file.
sleep 5



