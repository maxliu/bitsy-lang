assignment(name, symbol, value, scope) ::= <<
<if(value.reference)>
<if(value.symbol)>%r<scope.nextRegister> = load <llvmType(value)>* %r<value>
<elseif(value.list)>%r<scope.nextRegister> = getelementptr inbounds [<value.size> x %struct.Object]* %r<scope.lastRegister>, i32 0, i32 0
<endif>
store <llvmType(value)> %r<scope.register>, <llvmType(value)>* %<bitsyVariable(name)>
<else>
store <llvmType(value)> <llvmValue(value)>, <llvmType(value)>* %<bitsyVariable(name)><endif>
>>
