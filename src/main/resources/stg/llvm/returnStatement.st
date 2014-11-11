returnStatement(value, register) ::= <<
ret <typeMap.(value.type)> <argRegister(value, "r", register)>

>>