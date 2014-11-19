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
declare void @GC_init(...)
declare i8* @GC_malloc(i64)
declare i8* @GC_realloc(i8*, i64)

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
    i32 5, label %58
    i32 3, label %60
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

define i1 @listsEqual(%struct.List* %list1, %struct.List* %list2) #0 {
  %1 = alloca i1, align 4
  %2 = alloca %struct.List*, align 8
  %3 = alloca %struct.List*, align 8
  %i = alloca i32, align 4
  store %struct.List* %list1, %struct.List** %2, align 8
  store %struct.List* %list2, %struct.List** %3, align 8
  %4 = load %struct.List** %2, align 8
  %5 = getelementptr inbounds %struct.List* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = load %struct.List** %3, align 8
  %8 = getelementptr inbounds %struct.List* %7, i32 0, i32 0
  %9 = load i32* %8, align 4
  %10 = icmp ne i32 %6, %9
  br i1 %10, label %11, label %12

; \<label>:11                                      ; preds = %0
  store i1 0, i1* %1
  br label %146

; \<label>:12                                      ; preds = %0
  store i32 0, i32* %i, align 4
  br label %13

; \<label>:13                                      ; preds = %142, %12
  %14 = load i32* %i, align 4
  %15 = load %struct.List** %2, align 8
  %16 = getelementptr inbounds %struct.List* %15, i32 0, i32 0
  %17 = load i32* %16, align 4
  %18 = icmp slt i32 %14, %17
  br i1 %18, label %19, label %145

; \<label>:19                                      ; preds = %13
  %20 = load i32* %i, align 4
  %21 = sext i32 %20 to i64
  %22 = load %struct.List** %2, align 8
  %23 = getelementptr inbounds %struct.List* %22, i32 0, i32 2
  %24 = load %struct.Object** %23, align 8
  %25 = getelementptr inbounds %struct.Object* %24, i64 %21
  %26 = getelementptr inbounds %struct.Object* %25, i32 0, i32 0
  %27 = load i32* %26, align 4
  %28 = load i32* %i, align 4
  %29 = sext i32 %28 to i64
  %30 = load %struct.List** %3, align 8
  %31 = getelementptr inbounds %struct.List* %30, i32 0, i32 2
  %32 = load %struct.Object** %31, align 8
  %33 = getelementptr inbounds %struct.Object* %32, i64 %29
  %34 = getelementptr inbounds %struct.Object* %33, i32 0, i32 0
  %35 = load i32* %34, align 4
  %36 = icmp ne i32 %27, %35
  br i1 %36, label %37, label %38

; \<label>:37                                      ; preds = %19
  store i1 0, i1* %1
  br label %146

; \<label>:38                                      ; preds = %19
  %39 = load i32* %i, align 4
  %40 = sext i32 %39 to i64
  %41 = load %struct.List** %2, align 8
  %42 = getelementptr inbounds %struct.List* %41, i32 0, i32 2
  %43 = load %struct.Object** %42, align 8
  %44 = getelementptr inbounds %struct.Object* %43, i64 %40
  %45 = getelementptr inbounds %struct.Object* %44, i32 0, i32 0
  %46 = load i32* %45, align 4
  switch i32 %46, label %140 [
    i32 0, label %47
    i32 1, label %70
    i32 2, label %93
    i32 3, label %115
    i32 4, label %138
    i32 5, label %139
    i32 6, label %139
  ]

; \<label>:47                                      ; preds = %38
  %48 = load i32* %i, align 4
  %49 = sext i32 %48 to i64
  %50 = load %struct.List** %2, align 8
  %51 = getelementptr inbounds %struct.List* %50, i32 0, i32 2
  %52 = load %struct.Object** %51, align 8
  %53 = getelementptr inbounds %struct.Object* %52, i64 %49
  %54 = getelementptr inbounds %struct.Object* %53, i32 0, i32 1
  %55 = bitcast %union.Value* %54 to i8**
  %56 = load i8** %55, align 8
  %57 = load i32* %i, align 4
  %58 = sext i32 %57 to i64
  %59 = load %struct.List** %3, align 8
  %60 = getelementptr inbounds %struct.List* %59, i32 0, i32 2
  %61 = load %struct.Object** %60, align 8
  %62 = getelementptr inbounds %struct.Object* %61, i64 %58
  %63 = getelementptr inbounds %struct.Object* %62, i32 0, i32 1
  %64 = bitcast %union.Value* %63 to i8**
  %65 = load i8** %64, align 8
  %66 = call i32 @strcmp(i8* %56, i8* %65)
  %67 = icmp ne i32 %66, 0
  br i1 %67, label %68, label %69

; \<label>:68                                      ; preds = %47
  store i1 0, i1* %1
  br label %146

; \<label>:69                                      ; preds = %47
  br label %141

; \<label>:70                                      ; preds = %38
  %71 = load i32* %i, align 4
  %72 = sext i32 %71 to i64
  %73 = load %struct.List** %2, align 8
  %74 = getelementptr inbounds %struct.List* %73, i32 0, i32 2
  %75 = load %struct.Object** %74, align 8
  %76 = getelementptr inbounds %struct.Object* %75, i64 %72
  %77 = getelementptr inbounds %struct.Object* %76, i32 0, i32 1
  %78 = bitcast %union.Value* %77 to double*
  %79 = load double* %78, align 8
  %80 = load i32* %i, align 4
  %81 = sext i32 %80 to i64
  %82 = load %struct.List** %3, align 8
  %83 = getelementptr inbounds %struct.List* %82, i32 0, i32 2
  %84 = load %struct.Object** %83, align 8
  %85 = getelementptr inbounds %struct.Object* %84, i64 %81
  %86 = getelementptr inbounds %struct.Object* %85, i32 0, i32 1
  %87 = bitcast %union.Value* %86 to double*
  %88 = load double* %87, align 8
  %89 = fsub double %79, %88
  %90 = fcmp une double %89, 0.000000e+00
  br i1 %90, label %91, label %92

; \<label>:91                                      ; preds = %70
  store i1 0, i1* %1
  br label %146

; \<label>:92                                      ; preds = %70
  br label %141

; \<label>:93                                      ; preds = %38
  %94 = load i32* %i, align 4
  %95 = sext i32 %94 to i64
  %96 = load %struct.List** %2, align 8
  %97 = getelementptr inbounds %struct.List* %96, i32 0, i32 2
  %98 = load %struct.Object** %97, align 8
  %99 = getelementptr inbounds %struct.Object* %98, i64 %95
  %100 = getelementptr inbounds %struct.Object* %99, i32 0, i32 1
  %101 = bitcast %union.Value* %100 to i32*
  %102 = load i32* %101, align 4
  %103 = load i32* %i, align 4
  %104 = sext i32 %103 to i64
  %105 = load %struct.List** %3, align 8
  %106 = getelementptr inbounds %struct.List* %105, i32 0, i32 2
  %107 = load %struct.Object** %106, align 8
  %108 = getelementptr inbounds %struct.Object* %107, i64 %104
  %109 = getelementptr inbounds %struct.Object* %108, i32 0, i32 1
  %110 = bitcast %union.Value* %109 to i32*
  %111 = load i32* %110, align 4
  %112 = icmp ne i32 %102, %111
  br i1 %112, label %113, label %114

; \<label>:113                                     ; preds = %93
  store i1 0, i1* %1
  br label %146

; \<label>:114                                     ; preds = %93
  br label %141

; \<label>:115                                     ; preds = %38
  %116 = load i32* %i, align 4
  %117 = sext i32 %116 to i64
  %118 = load %struct.List** %2, align 8
  %119 = getelementptr inbounds %struct.List* %118, i32 0, i32 2
  %120 = load %struct.Object** %119, align 8
  %121 = getelementptr inbounds %struct.Object* %120, i64 %117
  %122 = getelementptr inbounds %struct.Object* %121, i32 0, i32 1
  %123 = bitcast %union.Value* %122 to %struct.List**
  %124 = load %struct.List** %123, align 8
  %125 = load i32* %i, align 4
  %126 = sext i32 %125 to i64
  %127 = load %struct.List** %3, align 8
  %128 = getelementptr inbounds %struct.List* %127, i32 0, i32 2
  %129 = load %struct.Object** %128, align 8
  %130 = getelementptr inbounds %struct.Object* %129, i64 %126
  %131 = getelementptr inbounds %struct.Object* %130, i32 0, i32 1
  %132 = bitcast %union.Value* %131 to %struct.List**
  %133 = load %struct.List** %132, align 8
  %134 = call i1 @listsEqual(%struct.List* %124, %struct.List* %133)
  %135 = icmp ne i1 %134, 1
  br i1 %135, label %136, label %137

; \<label>:136                                     ; preds = %115
  store i1 0, i1* %1
  br label %146

; \<label>:137                                     ; preds = %115
  br label %141

; \<label>:138                                     ; preds = %38
  br label %141

; \<label>:139                                     ; preds = %38, %38
  br label %141

; \<label>:140                                     ; preds = %38
  store i1 0, i1* %1
  br label %146

; \<label>:141                                     ; preds = %139, %138, %137, %114, %92, %69
  br label %142

; \<label>:142                                     ; preds = %141
  %143 = load i32* %i, align 4
  %144 = add nsw i32 %143, 1
  store i32 %144, i32* %i, align 4
  br label %13

; \<label>:145                                     ; preds = %13
  store i1 1, i1* %1
  br label %146

; \<label>:146                                     ; preds = %145, %140, %136, %113, %91, %68, %37, %11
  %147 = load i1* %1
  ret i1 %147
}

>>