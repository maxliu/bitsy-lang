assert(value, scope, label, message, line) ::= <<
 ; assert line <line>
<load(value)>
ifeq endif<label>
	<println(message, scope)>
	iconst_1
    invokestatic java/lang/System/exit(I)V
endif<label>:
>>