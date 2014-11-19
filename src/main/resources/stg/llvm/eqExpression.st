eqExpression(lval, rval, scope) ::= << ; EQ EXPR [<lval.type> <rval.type>]
<loadOperands(lval, rval, scope)>
<if(lval.string&&rval.string)>
%r<scope.register> = call i32 @strcmp(<args(lval, rval, scope)>)
%r<scope.nextRegister> = icmp eq i32 %r<scope.lastRegister>, 0
<elseif(lval.string&&rval.number)>
%r<scope.register> = call double @atof(i8* <argRegister(lval,"lval",scope.register)>)
%r<scope.nextRegister> = fsub double %r<scope.lastRegister>, <argRegister(rval,"rval",scope.lastRegister)>
%r<scope.nextRegister> = fcmp oeq double %r<scope.lastRegister>, 0.0
<elseif(lval.number&&rval.string)>
%r<scope.register> = call double @atof(i8* <argRegister(rval,"rval",scope.register)>)
%r<scope.nextRegister> = fsub double <argRegister(lval,"lval",scope.lastRegister)>, %r<scope.lastRegister> 
%r<scope.nextRegister> = fcmp oeq double %r<scope.lastRegister>, 0.0
<elseif(lval.number&&rval.number)>
%r<scope.register> = fsub double <argRegister(lval,"lval",scope.register)>, <argRegister(rval,"rval",scope.register)>
%r<scope.nextRegister> = fcmp oeq double %r<scope.lastRegister>, 0.0
<elseif(lval.number&&rval.boolean)>
%r<scope.register> = fcmp one double <argRegister(lval,"lval",scope.register)>, 0.0
%r<scope.nextRegister> = icmp eq i1 <argRegister(rval,"rval",scope.lastRegister)>, %r<scope.lastRegister>
<elseif(lval.boolean&&rval.number)>
%r<scope.register> = fcmp one double <argRegister(rval,"rval",scope.register)>, 0.0
%r<scope.nextRegister> = icmp eq i1 <argRegister(lval,"lval",scope.lastRegister)>, %r<scope.lastRegister>
<elseif(lval.string&&rval.boolean)>
%r<scope.register> = call i64 @strlen(i8* <argRegister(lval,"lval",scope.register)>)
%l<scope.register> = icmp ne i64 %r<scope.register>, 0
%r<scope.nextRegister> = icmp eq i1 %l<scope.lastRegister>, <argRegister(rval,"rval",scope.lastRegister)>
<elseif(lval.boolean&&rval.string)>
%r<scope.register> = call i64 @strlen(i8* <argRegister(rval,"rval",scope.register)>)
%l<scope.register> = icmp ne i64 %r<scope.register>, 0
%r<scope.nextRegister> = icmp eq i1 %l<scope.lastRegister>, <argRegister(lval,"lval",scope.lastRegister)>
<elseif(lval.boolean&&rval.boolean)>
%r<scope.nextRegister> = icmp eq i1 <argRegister(lval,"lval",scope.lastRegister)>, <argRegister(rval,"rval",scope.lastRegister)>
<elseif(lval.list&&rval.boolean)>
%sizeptr<scope.register> = getelementptr inbounds %struct.List* %lval<scope.register>, i32 0, i32 0
%size<scope.register> = load i32* %sizeptr<scope.register>
%c<scope.register> = icmp sgt i32 %size<scope.register>, 0
%r<scope.nextRegister> = icmp eq i1 %c<scope.lastRegister>, <argRegister(rval,"rval",scope.lastRegister)>
<elseif(lval.boolean&&rval.list)>
%size<scope.register> = getelementptr inbounds %struct.List* %rval<scope.register>, i32 0, i32 0
%c<scope.register> = icmp sgt i32 %size<scope.register>, 0
%r<scope.nextRegister> = icmp eq i1 %c<scope.lastRegister>, <argRegister(lval,"lval",scope.lastRegister)>
<endif>
>>
