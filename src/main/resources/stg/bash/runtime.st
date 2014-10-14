runtime() ::= <<

not() {
	if [ "$(convertboolean $1)" == "0" ]; then
		echo 1
	else
		echo 0
	fi 
}

convertboolean() {
    if [[ -z "$1" ]]; then echo 0
    elif [[ "$1" == true ]]; then echo 1 
    elif [[ "$1" == "1" ]]; then echo 1
    elif [[ $(echo "$1 != 0.0"|bc) -eq 1 ]]; then echo 1
    else echo 0
    fi
}

comparestringstring() {
    if [ "$1" == "$2" ]; then echo 1     
    else echo 0
    fi
}

comparestringnumber() {
	if [ -z "$1" ]; then echo 0
	else
		echo $(comparenumbernumber $1 $2)
	fi
}

comparestringboolean() {
    local sb=${#1}
    local b=$(convertboolean $2)
    if [[ "$1" == "false" || "$1" == "0" ]]; then sb=0; fi
    if [[ $sb -ne 0 && $(echo "$b != 0.0"|bc) -eq 1 ]]; then
            echo 1
    elif [[ $sb -eq 0 && $(echo "$b == 0"|bc) -eq 1 ]]; then 
            echo 1
    else
            echo 0
    fi   
}

comparenumberstring() {
	echo $(comparestringnumber "$2" $1)
}

comparenumbernumber() {
	echo $(echo "$1 == $2"|bc)
}

comparenumberboolean() {
	echo $(comparenumbernumber $1 $(convertboolean $2))
}

comparebooleanstring() {
	echo $(comparenumbernumber $1 "$2")
}

comparebooleannumber() {
	echo $(comparenumbernumber $(convertboolean $1) $2)
}

comparebooleanboolean() {
	echo $(comparenumbernumber $(convertboolean $1) $(convertboolean $2))
}


>>