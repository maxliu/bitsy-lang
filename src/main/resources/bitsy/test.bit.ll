@.newline = internal constant [2 x i8] c"\0A\00"
@.double = internal constant [3 x i8] c"%g\00"
@.true = internal constant [5 x i8] c"true\00"
@.false = internal constant [6 x i8] c"false\00"
@.str1 = internal constant [28 x i8] c"hello lets get itsy-bitsy\0A\0A\00"
@.str2 = internal constant [23 x i8] c"Some more lines down\0A\0A\00"
@.str3 = internal constant [10 x i8] c"\0AWoohoo!\0A\00"
@.str4 = internal constant [9 x i8] c"1234.123\00"
@.str5 = internal constant [5 x i8] c"test\00"
@.str6 = internal constant [2 x i8] c"1\00"

declare i32 @printf(i8 *, ...)

define i32 @main() {
    %a = alloca i8*
    %c = alloca double
    %b = alloca i32
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([28 x i8]* @.str1, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([23 x i8]* @.str2, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([10 x i8]* @.str3, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([3 x i8]* @.double, i32 0, i32 0), double 1234.123)
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    store i8* getelementptr ([5 x i8]* @.str5, i32 0, i32 0), i8** %a
    store double 123.0, double* %c
    store i32 1, i32* %b
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    %r6 = load i8** %a 
    call i32 (i8 *, ...)* @printf(i8* %r6)
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    %r7 = load i32* %b
    %c7 = icmp ne i32 %r7, 0
    br i1 %c7, label %true7, label %false7
    true7: 
    	call i32 (i8 *, ...)* @printf(i8* getelementptr ([5 x i8]* @.true, i32 0, i32 0))
    	br label %endif7
    false7:
    	call i32 (i8 *, ...)* @printf(i8* getelementptr ([6 x i8]* @.false, i32 0, i32 0))
    	br label %endif7
    endif7:
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    %r8 = load double* %c 
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([3 x i8]* @.double, i32 0, i32 0), double %r8)
    call i32 (i8 *, ...)* @printf(i8* getelementptr ([2 x i8]* @.newline, i32 0, i32 0))
    ret i32 0;
}