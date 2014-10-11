println(value, scope) ::= <<
<if(value&&value.symbol)>
<if(value.string)>
%r<scope.nextRegister> = load i8** %<bitsyVariable(value)> 
call i32 (i8 *, ...)* @printf(i8* %r<scope.register>)
<elseif(value.number)>
%r<scope.nextRegister> = load double* %<bitsyVariable(value)> 
call i32 (i8 *, ...)* @printf(i8* getelementptr ([3 x i8]* @.double, i32 0, i32 0), double %r<scope.register>)
<elseif(value.boolean)>
%r<scope.nextRegister> = load i32* %<bitsyVariable(value)>
%c<scope.register> = icmp ne i32 %r<scope.register>, 0
br i1 %c<scope.register>, label %true<scope.register>, label %false<scope.register>
true<scope.register>: 
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([5 x i8]* @.true, i32 0, i32 0))
    br label %endif<scope.register>
false<scope.register>:
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([6 x i8]* @.false, i32 0, i32 0))
    br label %endif<scope.register>
endif<scope.register>:
<endif>
<elseif(value&&value.reference)>
<if(value.string)>
call i32 (i8 *, ...)* @printf(i8* %r<value>)
<elseif(value.number)>
call i32 (i8 *, ...)* @printf(i8* getelementptr ([3 x i8]* @.double, i32 0, i32 0), double %r<value>)
<elseif(value.boolean)>
%c<scope.nextRegister> = icmp ne i32 %r<value>, 0
br i1 %c<scope.register>, label %true<scope.register>, label %false<scope.register>
true<scope.register>: 
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([5 x i8]* @.true, i32 0, i32 0))
    br label %endif<scope.register>
false<scope.register>:
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([6 x i8]* @.false, i32 0, i32 0))
    br label %endif<scope.register>
endif<scope.register>:
<endif>
<elseif(value)>
<if(value.string)>
call i32 (i8 *, ...)* @printf(i8* <getString(value)>)
<elseif(value.number)>
call i32 (i8 *, ...)* @printf(i8* getelementptr ([3 x i8]* @.double, i32 0, i32 0), double <value>)
<elseif(value.boolean)>
<if(value.onTrue)>
call i32 (i8 *, ...)* @printf(i8* getelementptr ([5 x i8]* @.true, i32 0, i32 0))
<else>
call i32 (i8 *, ...)* @printf(i8* getelementptr ([6 x i8]* @.false, i32 0, i32 0))
<endif>
<endif>
<endif>call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
>>