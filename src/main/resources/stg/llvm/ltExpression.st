ltExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
<if(lval.string&&rval.string)>
%r<scope.nextRegister> = call i32 @strcmp(<args(lval, rval, scope)>)
%r<scope.nextRegister> = icmp slt i32 %r<scope.lastRegister>, 0
<elseif(lval.string&&rval.number)>
%r<scope.nextRegister> = call double @atof(i8* <argRegister(lval,"lval",scope.lastRegister)>)
%r<scope.nextRegister> = fsub double %r<scope.lastRegister>, <argRegister(rval,"rval",scope.lastRegister)>
%r<scope.nextRegister> = fcmp ole double %r<scope.lastRegister>, 0.0
<elseif(lval.number&&rval.string)>
%r<scope.nextRegister> = call double @atof(i8* <argRegister(rval,"rval",scope.lastRegister)>)
%r<scope.nextRegister> = fsub double <argRegister(lval,"lval",scope.lastRegister)>, %r<scope.lastRegister> 
%r<scope.nextRegister> = fcmp ole double %r<scope.lastRegister>, 0.0
<elseif(lval.number&&rval.number)>
%r<scope.nextRegister> = fsub double <argRegister(lval,"lval",scope.lastRegister)>, <argRegister(rval,"rval",scope.lastRegister)>
%r<scope.nextRegister> = fcmp ole double %r<scope.lastRegister>, 0.0
<endif>
>>
