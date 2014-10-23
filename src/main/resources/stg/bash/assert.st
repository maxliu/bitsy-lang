assert(value, scope, label, message, line) ::= <<
# assert line <line>
if ! [ <isTrue(value)>  ] ; then
	<println(message, scope)>
	exit 1
fi

>>