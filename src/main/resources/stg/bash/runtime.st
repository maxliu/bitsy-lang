runtime() ::= <<

comparestringstring() {
    if [ "$1" == "$2" ]; then echo 1     
    else echo 0
    fi
}

comparestringnumber() {
	echo $(echo "$1 == $2"|bc)
}

comparenumberstring() {
	echo $(echo "$1 == $2"|bc)
}
>>