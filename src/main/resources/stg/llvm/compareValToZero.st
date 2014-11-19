compareValToZero(value, register) ::= <<
<if(value.symbol)>
<if(value.boolean)>
%r<register> = load i1* %<bitsyVariable(value)>
%c<register> = icmp ne i1 %r<register>, 0<elseif(value.number)>
%r<register> = load double* %<bitsyVariable(value)>
%c<register> = fcmp une double %r<register>, 0.0<else>
%r<register> = load i8** %<bitsyVariable(value)>
%s<register> = load i8* %r<register>
%c<register> = icmp ne i8 %s<register>, 0<endif>
<elseif(value.reference)>
<if(value.boolean)>
%c<register> = icmp ne i1 %r<value>, 0<elseif(value.number)>
%c<register> = fcmp une double %r<value>, 0.0<else>
%s<register> = load i8* %r<value>
%c<register> = icmp ne i8 %s<register>, 0<endif>
<else>
%r<register> = add i1 0, <value.toBoolean>
%c<register> = icmp ne i1 %r<register>, 0<endif>
>>