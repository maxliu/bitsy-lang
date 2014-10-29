runtime() ::= <<
@.newline = internal constant [2 x i8] c"\0A\00"
@.double = internal constant [3 x i8] c"%g\00"
@.true = internal constant [5 x i8] c"true\00"
@.false = internal constant [6 x i8] c"false\00"
@.stringnumber = internal constant [5 x i8] c"%s%g\00"
@.stringstring = internal constant [5 x i8] c"%s%s\00"
@.numberstring = internal constant [5 x i8] c"%g%s\00"

declare i32 @printf(i8 *, ...)
declare i32 @strcmp(i8*, i8*)
declare i32 @snprintf(i8*, i64, i8*, ...)
declare i64 @strlen(i8*)
declare i8* @malloc(i64)
declare double @atof(i8*)
declare void @exit(i32)
declare double @fmod(double, double)
declare double @pow(double, double)

>>