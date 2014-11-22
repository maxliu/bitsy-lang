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

define void @listResize(%struct.List* %list, i32 %newsize) #0 {
  %1 = alloca %struct.List*, align 8
  %2 = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  store i32 %newsize, i32* %2, align 4
  %3 = load %struct.List** %1, align 8
  %4 = getelementptr inbounds %struct.List* %3, i32 0, i32 1
  %5 = load i32* %4, align 4
  %6 = load %struct.List** %1, align 8
  %7 = getelementptr inbounds %struct.List* %6, i32 0, i32 0
  %8 = load i32* %7, align 4
  %9 = load i32* %2, align 4
  %10 = add nsw i32 %8, %9
  %11 = icmp slt i32 %5, %10
  br i1 %11, label %12, label %29

; \<label>:12                                      ; preds = %0
  %13 = load %struct.List** %1, align 8
  %14 = getelementptr inbounds %struct.List* %13, i32 0, i32 2
  %15 = load %struct.Object** %14, align 8
  %16 = bitcast %struct.Object* %15 to i8*
  %17 = load i32* %2, align 4
  %18 = add nsw i32 %17, 10
  %19 = sext i32 %18 to i64
  %20 = mul i64 16, %19
  %21 = call i8* @GC_realloc(i8* %16, i64 %20)
  %22 = bitcast i8* %21 to %struct.Object*
  %23 = load %struct.List** %1, align 8
  %24 = getelementptr inbounds %struct.List* %23, i32 0, i32 2
  store %struct.Object* %22, %struct.Object** %24, align 8
  %25 = load i32* %2, align 4
  %26 = add nsw i32 %25, 10
  %27 = load %struct.List** %1, align 8
  %28 = getelementptr inbounds %struct.List* %27, i32 0, i32 1
  store i32 %26, i32* %28, align 4
  br label %29

; \<label>:29                                      ; preds = %12, %0
  %30 = load i32* %2, align 4
  %31 = load %struct.List** %1, align 8
  %32 = getelementptr inbounds %struct.List* %31, i32 0, i32 0
  store i32 %30, i32* %32, align 4
  ret void
}

; Function Attrs: nounwind ssp uwtable
define %struct.List* @listCopy(%struct.List* %from) #0 {
  %1 = alloca %struct.List*, align 8
  %to = alloca %struct.List*, align 8
  store %struct.List* %from, %struct.List** %1, align 8
  %2 = call i8* @GC_malloc(i64 16)
  %3 = bitcast i8* %2 to %struct.List*
  store %struct.List* %3, %struct.List** %to, align 8
  %4 = load %struct.List** %1, align 8
  %5 = getelementptr inbounds %struct.List* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = add nsw i32 %6, 10
  %8 = sext i32 %7 to i64
  %9 = mul i64 16, %8
  %10 = call i8* @GC_malloc(i64 %9)
  %11 = bitcast i8* %10 to %struct.Object*
  %12 = load %struct.List** %to, align 8
  %13 = getelementptr inbounds %struct.List* %12, i32 0, i32 2
  store %struct.Object* %11, %struct.Object** %13, align 8
  %14 = load %struct.List** %to, align 8
  %15 = load %struct.List** %1, align 8
  %16 = call %struct.List* @addListToList(%struct.List* %14, %struct.List* %15)
  %17 = load %struct.List** %to, align 8
  ret %struct.List* %17
}


; Function Attrs: nounwind ssp uwtable
define %struct.List* @addListToList(%struct.List* %list, %struct.List* %add) #0 {
  %1 = alloca %struct.List*, align 8
  %2 = alloca %struct.List*, align 8
  %size = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  store %struct.List* %add, %struct.List** %2, align 8
  %3 = load %struct.List** %1, align 8
  %4 = getelementptr inbounds %struct.List* %3, i32 0, i32 0
  %5 = load i32* %4, align 4
  store i32 %5, i32* %size, align 4
  %6 = load %struct.List** %1, align 8
  %7 = load i32* %size, align 4
  %8 = load %struct.List** %2, align 8
  %9 = getelementptr inbounds %struct.List* %8, i32 0, i32 0
  %10 = load i32* %9, align 4
  %11 = add nsw i32 %7, %10
  call void @listResize(%struct.List* %6, i32 %11)
  %12 = load i32* %size, align 4
  store i32 %12, i32* %i, align 4
  store i32 0, i32* %j, align 4
  br label %13

; \<label>:13                                      ; preds = %134, %0
  %14 = load i32* %i, align 4
  %15 = load i32* %size, align 4
  %16 = load %struct.List** %2, align 8
  %17 = getelementptr inbounds %struct.List* %16, i32 0, i32 0
  %18 = load i32* %17, align 4
  %19 = add nsw i32 %15, %18
  %20 = icmp slt i32 %14, %19
  br i1 %20, label %21, label %139

; \<label>:21                                      ; preds = %13
  %22 = load i32* %j, align 4
  %23 = sext i32 %22 to i64
  %24 = load %struct.List** %2, align 8
  %25 = getelementptr inbounds %struct.List* %24, i32 0, i32 2
  %26 = load %struct.Object** %25, align 8
  %27 = getelementptr inbounds %struct.Object* %26, i64 %23
  %28 = getelementptr inbounds %struct.Object* %27, i32 0, i32 0
  %29 = load i32* %28, align 4
  switch i32 %29, label %129 [
    i32 0, label %30
    i32 1, label %42
    i32 2, label %54
    i32 3, label %67
    i32 5, label %130
  ]

; \<label>:30                                      ; preds = %21
  %31 = load %struct.List** %1, align 8
  %32 = load i32* %j, align 4
  %33 = sext i32 %32 to i64
  %34 = load %struct.List** %2, align 8
  %35 = getelementptr inbounds %struct.List* %34, i32 0, i32 2
  %36 = load %struct.Object** %35, align 8
  %37 = getelementptr inbounds %struct.Object* %36, i64 %33
  %38 = getelementptr inbounds %struct.Object* %37, i32 0, i32 1
  %39 = bitcast %union.Value* %38 to i8**
  %40 = load i8** %39, align 8
  %41 = call %struct.List* @addStringToList(%struct.List* %31, i8* %40)
  br label %133

; \<label>:42                                      ; preds = %21
  %43 = load %struct.List** %1, align 8
  %44 = load i32* %j, align 4
  %45 = sext i32 %44 to i64
  %46 = load %struct.List** %2, align 8
  %47 = getelementptr inbounds %struct.List* %46, i32 0, i32 2
  %48 = load %struct.Object** %47, align 8
  %49 = getelementptr inbounds %struct.Object* %48, i64 %45
  %50 = getelementptr inbounds %struct.Object* %49, i32 0, i32 1
  %51 = bitcast %union.Value* %50 to double*
  %52 = load double* %51, align 8
  %53 = call %struct.List* @addNumberToList(%struct.List* %43, double %52)
  br label %133

; \<label>:54                                      ; preds = %21
  %55 = load %struct.List** %1, align 8
  %56 = load i32* %j, align 4
  %57 = sext i32 %56 to i64
  %58 = load %struct.List** %2, align 8
  %59 = getelementptr inbounds %struct.List* %58, i32 0, i32 2
  %60 = load %struct.Object** %59, align 8
  %61 = getelementptr inbounds %struct.Object* %60, i64 %57
  %62 = getelementptr inbounds %struct.Object* %61, i32 0, i32 1
  %63 = bitcast %union.Value* %62 to i8*
  %64 = load i8* %63, align 1
  %65 = trunc i8 %64 to i1
  %66 = call %struct.List* @addBooleanToList(%struct.List* %55, i1 zeroext %65)
  br label %133

; \<label>:67                                      ; preds = %21
  %68 = load i32* %i, align 4
  %69 = sext i32 %68 to i64
  %70 = load %struct.List** %1, align 8
  %71 = getelementptr inbounds %struct.List* %70, i32 0, i32 2
  %72 = load %struct.Object** %71, align 8
  %73 = getelementptr inbounds %struct.Object* %72, i64 %69
  %74 = getelementptr inbounds %struct.Object* %73, i32 0, i32 0
  store i32 3, i32* %74, align 4
  %75 = call i8* @GC_malloc(i64 16)
  %76 = bitcast i8* %75 to %struct.List*
  %77 = load i32* %i, align 4
  %78 = sext i32 %77 to i64
  %79 = load %struct.List** %1, align 8
  %80 = getelementptr inbounds %struct.List* %79, i32 0, i32 2
  %81 = load %struct.Object** %80, align 8
  %82 = getelementptr inbounds %struct.Object* %81, i64 %78
  %83 = getelementptr inbounds %struct.Object* %82, i32 0, i32 1
  %84 = bitcast %union.Value* %83 to %struct.List**
  store %struct.List* %76, %struct.List** %84, align 8
  %85 = load i32* %j, align 4
  %86 = sext i32 %85 to i64
  %87 = load %struct.List** %2, align 8
  %88 = getelementptr inbounds %struct.List* %87, i32 0, i32 2
  %89 = load %struct.Object** %88, align 8
  %90 = getelementptr inbounds %struct.Object* %89, i64 %86
  %91 = getelementptr inbounds %struct.Object* %90, i32 0, i32 1
  %92 = bitcast %union.Value* %91 to %struct.List**
  %93 = load %struct.List** %92, align 8
  %94 = getelementptr inbounds %struct.List* %93, i32 0, i32 0
  %95 = load i32* %94, align 4
  %96 = sext i32 %95 to i64
  %97 = mul i64 16, %96
  %98 = call i8* @GC_malloc(i64 %97)
  %99 = bitcast i8* %98 to %struct.Object*
  %100 = load i32* %i, align 4
  %101 = sext i32 %100 to i64
  %102 = load %struct.List** %1, align 8
  %103 = getelementptr inbounds %struct.List* %102, i32 0, i32 2
  %104 = load %struct.Object** %103, align 8
  %105 = getelementptr inbounds %struct.Object* %104, i64 %101
  %106 = getelementptr inbounds %struct.Object* %105, i32 0, i32 1
  %107 = bitcast %union.Value* %106 to %struct.List**
  %108 = load %struct.List** %107, align 8
  %109 = getelementptr inbounds %struct.List* %108, i32 0, i32 2
  store %struct.Object* %99, %struct.Object** %109, align 8
  %110 = load i32* %i, align 4
  %111 = sext i32 %110 to i64
  %112 = load %struct.List** %1, align 8
  %113 = getelementptr inbounds %struct.List* %112, i32 0, i32 2
  %114 = load %struct.Object** %113, align 8
  %115 = getelementptr inbounds %struct.Object* %114, i64 %111
  %116 = getelementptr inbounds %struct.Object* %115, i32 0, i32 1
  %117 = bitcast %union.Value* %116 to %struct.List**
  %118 = load %struct.List** %117, align 8
  %119 = load i32* %j, align 4
  %120 = sext i32 %119 to i64
  %121 = load %struct.List** %2, align 8
  %122 = getelementptr inbounds %struct.List* %121, i32 0, i32 2
  %123 = load %struct.Object** %122, align 8
  %124 = getelementptr inbounds %struct.Object* %123, i64 %120
  %125 = getelementptr inbounds %struct.Object* %124, i32 0, i32 1
  %126 = bitcast %union.Value* %125 to %struct.List**
  %127 = load %struct.List** %126, align 8
  %128 = call %struct.List* @addListToList(%struct.List* %118, %struct.List* %127)
  br label %133

; \<label>:129                                     ; preds = %21
  br label %130

; \<label>:130                                     ; preds = %21, %129
  %131 = load %struct.List** %1, align 8
  %132 = call %struct.List* @addNullToList(%struct.List* %131)
  br label %133

; \<label>:133                                     ; preds = %130, %67, %54, %42, %30
  br label %134

; \<label>:134                                     ; preds = %133
  %135 = load i32* %i, align 4
  %136 = add nsw i32 %135, 1
  store i32 %136, i32* %i, align 4
  %137 = load i32* %j, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, i32* %j, align 4
  br label %13

; \<label>:139                                     ; preds = %13
  %140 = load %struct.List** %1, align 8
  ret %struct.List* %140
}

; Function Attrs: nounwind ssp uwtable
define %struct.List* @addStringToList(%struct.List* %list, i8* %string) #0 {
  %1 = alloca %struct.List*, align 8
  %2 = alloca i8*, align 8
  %size = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  store i8* %string, i8** %2, align 8
  %3 = load %struct.List** %1, align 8
  %4 = getelementptr inbounds %struct.List* %3, i32 0, i32 0
  %5 = load i32* %4, align 4
  store i32 %5, i32* %size, align 4
  %6 = load %struct.List** %1, align 8
  %7 = load i32* %size, align 4
  %8 = add nsw i32 %7, 1
  call void @listResize(%struct.List* %6, i32 %8)
  %9 = load i32* %size, align 4
  %10 = sext i32 %9 to i64
  %11 = load %struct.List** %1, align 8
  %12 = getelementptr inbounds %struct.List* %11, i32 0, i32 2
  %13 = load %struct.Object** %12, align 8
  %14 = getelementptr inbounds %struct.Object* %13, i64 %10
  %15 = getelementptr inbounds %struct.Object* %14, i32 0, i32 0
  store i32 0, i32* %15, align 4
  %16 = load i8** %2, align 8
  %17 = load i32* %size, align 4
  %18 = sext i32 %17 to i64
  %19 = load %struct.List** %1, align 8
  %20 = getelementptr inbounds %struct.List* %19, i32 0, i32 2
  %21 = load %struct.Object** %20, align 8
  %22 = getelementptr inbounds %struct.Object* %21, i64 %18
  %23 = getelementptr inbounds %struct.Object* %22, i32 0, i32 1
  %24 = bitcast %union.Value* %23 to i8**
  store i8* %16, i8** %24, align 8
  %25 = load %struct.List** %1, align 8
  ret %struct.List* %25
}

; Function Attrs: nounwind ssp uwtable
define %struct.List* @addNumberToList(%struct.List* %list, double %number) #0 {
  %1 = alloca %struct.List*, align 8
  %2 = alloca double, align 8
  %size = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  store double %number, double* %2, align 8
  %3 = load %struct.List** %1, align 8
  %4 = getelementptr inbounds %struct.List* %3, i32 0, i32 0
  %5 = load i32* %4, align 4
  store i32 %5, i32* %size, align 4
  %6 = load %struct.List** %1, align 8
  %7 = load i32* %size, align 4
  %8 = add nsw i32 %7, 1
  call void @listResize(%struct.List* %6, i32 %8)
  %9 = load i32* %size, align 4
  %10 = sext i32 %9 to i64
  %11 = load %struct.List** %1, align 8
  %12 = getelementptr inbounds %struct.List* %11, i32 0, i32 2
  %13 = load %struct.Object** %12, align 8
  %14 = getelementptr inbounds %struct.Object* %13, i64 %10
  %15 = getelementptr inbounds %struct.Object* %14, i32 0, i32 0
  store i32 1, i32* %15, align 4
  %16 = load double* %2, align 8
  %17 = load i32* %size, align 4
  %18 = sext i32 %17 to i64
  %19 = load %struct.List** %1, align 8
  %20 = getelementptr inbounds %struct.List* %19, i32 0, i32 2
  %21 = load %struct.Object** %20, align 8
  %22 = getelementptr inbounds %struct.Object* %21, i64 %18
  %23 = getelementptr inbounds %struct.Object* %22, i32 0, i32 1
  %24 = bitcast %union.Value* %23 to double*
  store double %16, double* %24, align 8
  %25 = load %struct.List** %1, align 8
  ret %struct.List* %25
}

; Function Attrs: nounwind ssp uwtable
define %struct.List* @addBooleanToList(%struct.List* %list, i1 zeroext %boolean) #0 {
  %1 = alloca %struct.List*, align 8
  %2 = alloca i8, align 1
  %size = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  %3 = zext i1 %boolean to i8
  store i8 %3, i8* %2, align 1
  %4 = load %struct.List** %1, align 8
  %5 = getelementptr inbounds %struct.List* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  store i32 %6, i32* %size, align 4
  %7 = load %struct.List** %1, align 8
  %8 = load i32* %size, align 4
  %9 = add nsw i32 %8, 1
  call void @listResize(%struct.List* %7, i32 %9)
  %10 = load i32* %size, align 4
  %11 = sext i32 %10 to i64
  %12 = load %struct.List** %1, align 8
  %13 = getelementptr inbounds %struct.List* %12, i32 0, i32 2
  %14 = load %struct.Object** %13, align 8
  %15 = getelementptr inbounds %struct.Object* %14, i64 %11
  %16 = getelementptr inbounds %struct.Object* %15, i32 0, i32 0
  store i32 1, i32* %16, align 4
  %17 = load i8* %2, align 1
  %18 = trunc i8 %17 to i1
  %19 = load i32* %size, align 4
  %20 = sext i32 %19 to i64
  %21 = load %struct.List** %1, align 8
  %22 = getelementptr inbounds %struct.List* %21, i32 0, i32 2
  %23 = load %struct.Object** %22, align 8
  %24 = getelementptr inbounds %struct.Object* %23, i64 %20
  %25 = getelementptr inbounds %struct.Object* %24, i32 0, i32 1
  %26 = bitcast %union.Value* %25 to i8*
  %27 = zext i1 %18 to i8
  store i8 %27, i8* %26, align 1
  %28 = load %struct.List** %1, align 8
  ret %struct.List* %28
}

; Function Attrs: nounwind ssp uwtable
define %struct.List* @addNullToList(%struct.List* %list) #0 {
  %1 = alloca %struct.List*, align 8
  %size = alloca i32, align 4
  store %struct.List* %list, %struct.List** %1, align 8
  %2 = load %struct.List** %1, align 8
  %3 = getelementptr inbounds %struct.List* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  store i32 %4, i32* %size, align 4
  %5 = load %struct.List** %1, align 8
  %6 = load i32* %size, align 4
  %7 = add nsw i32 %6, 1
  call void @listResize(%struct.List* %5, i32 %7)
  %8 = load i32* %size, align 4
  %9 = sext i32 %8 to i64
  %10 = load %struct.List** %1, align 8
  %11 = getelementptr inbounds %struct.List* %10, i32 0, i32 2
  %12 = load %struct.Object** %11, align 8
  %13 = getelementptr inbounds %struct.Object* %12, i64 %9
  %14 = getelementptr inbounds %struct.Object* %13, i32 0, i32 0
  store i32 5, i32* %14, align 4
  %15 = load %struct.List** %1, align 8
  ret %struct.List* %15
}

>>