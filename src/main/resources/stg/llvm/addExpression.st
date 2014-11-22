addExpression(lval, rval, scope) ::= <<
<loadOperands(lval, rval, scope)>
<if(lval.number&&rval.number)>
%r<scope.register> = fadd double <argRegister(lval, "lval", scope.register)>, <argRegister(rval, "rval", scope.register)>
<elseif(lval.number&&rval.string)>
%llength<scope.register> = call i64 @strlen(i8* <argRegister(rval, "rval", scope.register)>)
%size<scope.register> = add i64 24, %llength<scope.register>
%r<scope.register> = call i8* @malloc(i64 %size<scope.register>)
call i32 (i8*, i64, i8*, ...)* @snprintf(i8* %r<scope.register>, i64 %size<scope.register>, i8* getelementptr inbounds ([5 x i8]* @.numberstring, i32 0, i32 0), double <argRegister(lval, "lval", scope.register)>, i8* <argRegister(rval, "rval", scope.register)>)
<elseif(lval.string&&rval.number)>
%llength<scope.register> = call i64 @strlen(i8* <argRegister(lval, "lval", scope.register)>)
%size<scope.register> = add i64 24, %llength<scope.register>
%r<scope.register> = call i8* @malloc(i64 %size<scope.register>)
call i32 (i8*, i64, i8*, ...)* @snprintf(i8* %r<scope.register>, i64 %size<scope.register>, i8* getelementptr inbounds ([5 x i8]* @.stringnumber, i32 0, i32 0), i8* <argRegister(lval, "lval", scope.register)>, double <argRegister(rval, "rval", scope.register)>)
<elseif(lval.string&&rval.string)>
%llength<scope.register> = call i64 @strlen(i8* <argRegister(lval, "lval", scope.register)>)
%rlength<scope.register> = call i64 @strlen(i8* <argRegister(rval, "rval", scope.register)>)
%sizeshort<scope.register> = add i64 %llength<scope.register>, %rlength<scope.register>
%size<scope.register> = add i64 1, %sizeshort<scope.register>
%r<scope.register> = call i8* @malloc(i64 %size<scope.register>)
call i32 (i8*, i64, i8*, ...)* @snprintf(i8* %r<scope.register>, i64 %size<scope.register>, i8* getelementptr inbounds ([5 x i8]* @.stringstring, i32 0, i32 0), i8* <argRegister(lval, "lval", scope.register)>, i8* <argRegister(rval, "rval", scope.register)>)
<elseif(lval.list)>
	%listCopy<scope.register> = call %struct.List* @listCopy(%struct.List* <argRegister(lval, "lval", scope.register)>)
	<if(rval.string)>
	%r<scope.register> = call %struct.List* @addStringToList(%struct.List* %listCopy<scope.register>, i8* <argRegister(rval, "rval", scope.register)>)
	<elseif(rval.number)>
	%r<scope.register> = call %struct.List* @addNumberToList(%struct.List* %listCopy<scope.register>, double <argRegister(rval, "rval", scope.register)>)
	<elseif(rval.boolean)>
	%r<scope.register> = call %struct.List* @addBooleanToList(%struct.List* %listCopy<scope.register>, i1 <argRegister(rval, "rval", scope.register)>)
	<elseif(rval.null)>
	%r<scope.register> = call %struct.List* @addNullToList(%struct.List* %listCopy<scope.register>)
	<elseif(rval.list)>
	%r<scope.register> = call %struct.List* @addListToList(%struct.List* %listCopy<scope.register>, %struct.List* <argRegister(rval, "rval", scope.register)>)
	<endif>
<elseif(rval.list)>
	%listCopy<scope.register> = call %struct.List* @listCopy(%struct.List* <argRegister(rval, "rval", scope.register)>)
	<if(lval.string)>
	%r<scope.register> = call %struct.List* @addStringToList(%struct.List* %listCopy<scope.register>, i8* <argRegister(lval, "lval", scope.register)>)
	<elseif(lval.number)>
	%r<scope.register> = call %struct.List* @addNumberToList(%struct.List* %listCopy<scope.register>, double <argRegister(lval, "lval", scope.register)>)
	<elseif(lval.boolean)>
	%r<scope.register> = call %struct.List* @addBooleanToList(%struct.List* %listCopy<scope.register>, i1 <argRegister(lval, "lval", scope.register)>)
	<elseif(lval.null)>
	%r<scope.register> = call %struct.List* @addNullToList(%struct.List* %listCopy<scope.register>)
	<elseif(lval.list)>
	%r<scope.register> = call %struct.List* @addListToList(%struct.List* %listCopy<scope.register>, %struct.List* <argRegister(lval, "lval", scope.register)>)
	<endif>
<endif>
>>