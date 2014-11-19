storeResult(value, prefix, register, temp="tmp") ::= <<
<if(value.symbol)>
%<temp><scope.register> = load <llvmType(value)>* %<bitsyVariable(value)>
store <typeMap.(value.type)> %<temp><scope.register>, <typeMap.(value.type)>* %<prefix><register>
<elseif(value.reference)>
store <typeMap.(value.type)> %r<value>,<typeMap.(value.type)>* %<prefix><register>  
<elseif(value.string)>
store i8* <getString(value)>, i8** %<prefix><register>
<elseif(value.number)>
store double <value>, double* %<prefix><register>
<elseif(value.boolean)>
store i1 <value>, i1* %<prefix><register>
<endif>
>>