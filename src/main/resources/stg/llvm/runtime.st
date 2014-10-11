runtime() ::= <<
@.newline = internal constant [2 x i8] c"\0A\00"
@.double = internal constant [3 x i8] c"%g\00"
@.true = internal constant [5 x i8] c"true\00"
@.false = internal constant [6 x i8] c"false\00"

declare i32 @printf(i8 *, ...)
declare i32 @strcmp(i8*, i8*)
declare i32 @snprintf(i8*, i64, i8*, ...)

define i32 @comparestringstring(i8* %s1, i8* %s2) {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  store i8* %s1, i8** %1, align 8
  store i8* %s2, i8** %2, align 8
  %3 = load i8** %1, align 8
  %4 = load i8** %2, align 8
  %5 = call i32 @strcmp(i8* %3, i8* %4)
  %6 = icmp eq i32 %5, 0
  %7 = zext i1 %6 to i32
  ret i32 %7
}

define i32 @comparestringnumber(i8* %s, double %d) {
  %1 = alloca i8*, align 8
  %2 = alloca double, align 8
  %out = alloca [100 x i8], align 16
  store i8* %s, i8** %1, align 8
  store double %d, double* %2, align 8
  %3 = getelementptr inbounds [100 x i8]* %out, i32 0, i32 0
  %4 = load double* %2, align 8
  %5 = call i32 (i8*, i64, i8*, ...)* @snprintf(i8* %3, i64 100, i8* getelementptr inbounds ([3 x i8]* @.double, i32 0, i32 0), double %4)
  %6 = load i8** %1, align 8
  %7 = getelementptr inbounds [100 x i8]* %out, i32 0, i32 0
  %8 = call i32 @comparestringstring(i8* %6, i8* %7)
  ret i32 %8
}

define i32 @comparenumberstring(double %d, i8* %s) {
  %1 = alloca double, align 8
  %2 = alloca i8*, align 8
  store double %d, double* %1, align 8
  store i8* %s, i8** %2, align 8
  %3 = load i8** %2, align 8
  %4 = load double* %1, align 8
  %5 = call i32 @comparestringnumber(i8* %3, double %4)
  ret i32 %5
}

define i32 @comparestringboolean(i8* %s, i32 %b) {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %sb = alloca i32, align 4
  store i8* %s, i8** %1, align 8
  store i32 %b, i32* %2, align 4
  %3 = load i8** %1, align 8
  %4 = load i8* %3, align 1
  %5 = sext i8 %4 to i32
  %6 = icmp ne i32 %5, 0
  %7 = zext i1 %6 to i32
  store i32 %7, i32* %sb, align 4
  %8 = load i32* %sb, align 4
  %9 = load i32* %2, align 4
  %10 = icmp eq i32 %8, %9
  %11 = zext i1 %10 to i32
  ret i32 %11
}

define i32 @comparebooleanstring(i32 %b, i8* %s) {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  store i32 %b, i32* %1, align 4
  store i8* %s, i8** %2, align 8
  %3 = load i8** %2, align 8
  %4 = load i32* %1, align 4
  %5 = call i32 @comparestringboolean(i8* %3, i32 %4)
  ret i32 %5
}

define i32 @comparenumberboolean(double %d, i32 %b) {
  %1 = alloca double, align 8
  %2 = alloca i32, align 4
  %db = alloca i32, align 4
  store double %d, double* %1, align 8
  store i32 %b, i32* %2, align 4
  %3 = load double* %1, align 8
  %4 = fcmp une double %3, 0.000000e+00
  %5 = zext i1 %4 to i32
  store i32 %5, i32* %db, align 4
  %6 = load i32* %db, align 4
  %7 = load i32* %2, align 4
  %8 = icmp eq i32 %6, %7
  %9 = zext i1 %8 to i32
  ret i32 %9
}

define i32 @comparebooleannumber(i32 %b, double %d) {
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  store i32 %b, i32* %1, align 4
  store double %d, double* %2, align 8
  %3 = load double* %2, align 8
  %4 = load i32* %1, align 4
  %5 = call i32 @comparenumberboolean(double %3, i32 %4)
  ret i32 %5
}

define i32 @comparenumbernumber(double %d1, double %d2) {
  %1 = alloca double, align 8
  %2 = alloca double, align 8
  store double %d1, double* %1, align 8
  store double %d2, double* %2, align 8
  %3 = load double* %1, align 8
  %4 = load double* %2, align 8
  %5 = fsub double %3, %4
  %6 = fcmp oeq double %5, 0.000000e+00
  %7 = zext i1 %6 to i32
  ret i32 %7
}

define i32 @comparebooleanboolean(i32 %b1, i32 %b2) {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %b1, i32* %1, align 4
  store i32 %b2, i32* %2, align 4
  %3 = load i32* %1, align 4
  %4 = load i32* %2, align 4
  %5 = icmp eq i32 %3, %4
  %6 = zext i1 %5 to i32
  ret i32 %6
}
>>