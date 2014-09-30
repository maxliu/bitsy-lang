@.newline = internal constant [1 x i8] c"\0A"
@.str1 = internal constant [28 x i8] c"hello lets get itsy-bitsy\0A\0A\00"
@.str2 = internal constant [23 x i8] c"Some more lines down\0A\0A\00"
@.str3 = internal constant [10 x i8] c"\0AWoohoo!\0A\00"
@.str4 = internal constant [7 x i8] c"1234.0\00"
@.str5 = internal constant [5 x i8] c"test\00"
@.str6 = internal constant [2 x i8] c"a\00"
@.str7 = internal constant [2 x i8] c"b\00"
@.str8 = internal constant [2 x i8] c"c\00"

declare i32 @printf(i8 *, ...)

define i32 @main() {
    %a = alloca i8*
    %c = alloca double
    %b = alloca double
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([28 x i8]* @.str1, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([23 x i8]* @.str2, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([10 x i8]* @.str3, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([7 x i8]* @.str4, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    store i8* getelementptr ([5 x i8]* @.str5, i32 0, i32 0), i8** %a
    store double 123.0, double* %c
    %r1 = load double* %c
    store double %r1, double* %b
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.str6, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.str7, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.str8, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([1 x i8]* @.newline, i32 0, i32 0))
    ret i32 0;
}