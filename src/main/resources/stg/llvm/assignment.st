assignment(name, value, scope) ::= <<
<if(value.reference)>
<if(value.symbol)>%r<scope.nextRegister> = load <llvmType(value)>* %r<value><endif>
store <llvmType(value)> %r<scope.register>, <llvmType(value)>* %<bitsyVariable(name)><else>
store <llvmType(value)> <llvmValue(value)>, <llvmType(value)>* %<bitsyVariable(name)><endif>
>>
