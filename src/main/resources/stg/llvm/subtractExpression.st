subtractExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
<if(lval.number&&rval.number)>
%r<scope.register> = fsub double <argRegister(lval, "lval", scope.register)>, <argRegister(rval, "rval", scope.register)>
<elseif(lval.number&&rval.string)>
%r<scope.register> = call double @atof(i8* <argRegister(rval,"rval",scope.register)>)
%r<scope.nextRegister> = fsub double <argRegister(lval, "lval", scope.lastRegister)>, %r<scope.lastRegister>
<elseif(lval.string&&rval.number)>
%r<scope.register> = call double @atof(i8* <argRegister(lval,"lval",scope.register)>)
%r<scope.nextRegister> = fsub double %r<scope.lastRegister>, <argRegister(rval, "rval", scope.lastRegister)>
<elseif(lval.string&&rval.string)>
%ld<scope.register> = call double @atof(i8* <argRegister(lval,"lval",scope.register)>)
%rd<scope.register> = call double @atof(i8* <argRegister(rval,"rval",scope.register)>)
%r<scope.register> = fsub double %rd, %ld
<endif>
>>