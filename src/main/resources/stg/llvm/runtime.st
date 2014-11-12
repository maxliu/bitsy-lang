runtime() ::= <<
@.newline = internal constant [2 x i8] c"\0A\00"
@.double = internal constant [3 x i8] c"%g\00"
@.true = internal constant [5 x i8] c"true\00"
@.false = internal constant [6 x i8] c"false\00"
@.stringnumber = internal constant [5 x i8] c"%s%g\00"
@.stringstring = internal constant [5 x i8] c"%s%s\00"
@.numberstring = internal constant [5 x i8] c"%g%s\00"
@.opensquarebracket = private unnamed_addr constant [2 x i8] c"[\00"
@.closesquarebracket = private unnamed_addr constant [2 x i8] c"]\00"
@.comma = private unnamed_addr constant [3 x i8] c", \00"
@.quotedstring = private unnamed_addr constant [5 x i8] c"\22%s\22\00" 
@.null = private unnamed_addr constant [5 x i8] c"null\00"

declare i32 @printf(i8 *, ...)
declare i32 @strcmp(i8*, i8*)
declare i32 @snprintf(i8*, i64, i8*, ...)
declare i64 @strlen(i8*)
declare i8* @malloc(i64)
declare double @atof(i8*)
declare void @exit(i32)
declare double @fmod(double, double)
declare double @pow(double, double)

define void @printList(%struct.List* %list) #0 {
  %1 = alloca %struct.List*, align 8
  %i = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.opensquarebracket, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %3

; \<label>:3                                       ; preds = %72, %0
  %4 = load i32* %i, align 4
  %5 = load %struct.List** %1, align 8
  %6 = getelementptr inbounds %struct.List* %5, i32 0, i32 0
  %7 = load i32* %6, align 4
  %8 = icmp slt i32 %4, %7
  br i1 %8, label %9, label %75

; \<label>:9                                       ; preds = %3
  %10 = load i32* %i, align 4
  %11 = icmp sgt i32 %10, 0
  br i1 %11, label %12, label %14

; \<label>:12                                      ; preds = %9
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.comma, i32 0, i32 0))
  br label %14

; \<label>:14                                      ; preds = %12, %9
  %15 = load i32* %i, align 4
  %16 = sext i32 %15 to i64
  %17 = load %struct.List** %1, align 8
  %18 = getelementptr inbounds %struct.List* %17, i32 0, i32 2
  %19 = load %struct.Object** %18, align 8
  %20 = getelementptr inbounds %struct.Object* %19, i64 %16
  %21 = getelementptr inbounds %struct.Object* %20, i32 0, i32 0
  %22 = load i32* %21, align 4
  switch i32 %22, label %70 [
    i32 0, label %23
    i32 1, label %34
    i32 2, label %45
    i32 3, label %58
    i32 5, label %60
  ]

; \<label>:23                                      ; preds = %14
  %24 = load i32* %i, align 4
  %25 = sext i32 %24 to i64
  %26 = load %struct.List** %1, align 8
  %27 = getelementptr inbounds %struct.List* %26, i32 0, i32 2
  %28 = load %struct.Object** %27, align 8
  %29 = getelementptr inbounds %struct.Object* %28, i64 %25
  %30 = getelementptr inbounds %struct.Object* %29, i32 0, i32 1
  %31 = bitcast %union.Value* %30 to i8**
  %32 = load i8** %31, align 8
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.quotedstring, i32 0, i32 0), i8* %32)
  br label %71

; \<label>:34                                      ; preds = %14
  %35 = load i32* %i, align 4
  %36 = sext i32 %35 to i64
  %37 = load %struct.List** %1, align 8
  %38 = getelementptr inbounds %struct.List* %37, i32 0, i32 2
  %39 = load %struct.Object** %38, align 8
  %40 = getelementptr inbounds %struct.Object* %39, i64 %36
  %41 = getelementptr inbounds %struct.Object* %40, i32 0, i32 1
  %42 = bitcast %union.Value* %41 to double*
  %43 = load double* %42, align 8
  %44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.double, i32 0, i32 0), double %43)
  br label %71

; \<label>:45                                      ; preds = %14
  %46 = load i32* %i, align 4
  %47 = sext i32 %46 to i64
  %48 = load %struct.List** %1, align 8
  %49 = getelementptr inbounds %struct.List* %48, i32 0, i32 2
  %50 = load %struct.Object** %49, align 8
  %51 = getelementptr inbounds %struct.Object* %50, i64 %47
  %52 = getelementptr inbounds %struct.Object* %51, i32 0, i32 1
  %53 = bitcast %union.Value* %52 to i32*
  %54 = load i32* %53, align 4
  %55 = icmp eq i32 %54, 1
  %56 = select i1 %55, i8* getelementptr inbounds ([5 x i8]* @.true, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8]* @.false, i32 0, i32 0)
  %57 = call i32 (i8*, ...)* @printf(i8* %56)
  br label %71

; \<label>:58                                      ; preds = %14
  %59 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.null, i32 0, i32 0))
  br label %71

; \<label>:60                                      ; preds = %14
  %61 = load i32* %i, align 4
  %62 = sext i32 %61 to i64
  %63 = load %struct.List** %1, align 8
  %64 = getelementptr inbounds %struct.List* %63, i32 0, i32 2
  %65 = load %struct.Object** %64, align 8
  %66 = getelementptr inbounds %struct.Object* %65, i64 %62
  %67 = getelementptr inbounds %struct.Object* %66, i32 0, i32 1
  %68 = bitcast %union.Value* %67 to %struct.List**
  %69 = load %struct.List** %68, align 8
  call void @printList(%struct.List* %69)
  br label %71

; \<label>:70                                      ; preds = %14
  br label %71

; \<label>:71                                      ; preds = %70, %60, %58, %45, %34, %23
  br label %72

; \<label>:72                                      ; preds = %71
  %73 = load i32* %i, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %i, align 4
  br label %3

; \<label>:75                                      ; preds = %3
  %76 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.closesquarebracket, i32 0, i32 0))
  ret void
}

>>