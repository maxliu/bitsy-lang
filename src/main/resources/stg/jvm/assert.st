assert(value, scope, label, message, line) ::= <<
; START assert line <line>
<load(value)>
ifne endif<label>
	<println(message, scope)>
	iconst_1
    invokestatic java/lang/System/exit(I)V
endif<label>:
; END assert

>>