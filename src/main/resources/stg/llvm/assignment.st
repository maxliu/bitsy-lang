assignment(name, value, scope) ::= <<
<if(value.reference)>
%r<scope.nextRegister> = load <llvmType(value)>* %<register(value)>
store <llvmType(value)> %r<scope.register>, <llvmType(value)>* %<bitsyVariable(name)><else>
store <llvmType(value)> <llvmValue(value)>, <llvmType(value)>* %<bitsyVariable(name)><endif>
>>
