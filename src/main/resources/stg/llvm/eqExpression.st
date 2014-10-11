eqExpression(lexpr, rexpr, lval, rval, scope) ::= <<
<lexpr>
<rexpr>
<if(lval.symbol&&lval.string)><loadString(lval, "lval", scope.register)>
<elseif(lval.symbol&&lval.number)><loadNumber(lval, "lval", scope.register)>
<elseif(lval.symbol&&lval.boolean)><loadBoolean(lval, "lval", scope.register)>
<endif>
<if(rval.symbol&&rval.string)><loadString(rval, "rval", scope.register)>
<elseif(rval.symbol&&rval.number)><loadNumber(rval, "rval", scope.register)>
<elseif(rval.symbol&&rval.boolean)><loadBoolean(rval, "rval", scope.register)>
<endif>
%r<scope.register> = call i32 @compare<lval.type><rval.type>(<args(lval, rval, scope)>)
>>
