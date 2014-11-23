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

; From bcw_gc library
declare void @GC_init(...)
declare i8* @GC_malloc(i64)
declare i8* @GC_realloc(i8*, i64)

; Runtime functions from bitsy.c
declare void @printList(%struct.List*) 
declare zeroext i1 @listsEqual(%struct.List*, %struct.List*) 
declare zeroext i1 @isEmpty(%struct.List*) 
declare void @listResize(%struct.List*, i32) 
declare %struct.List* @initList(i32) 
declare %struct.List* @listCopy(%struct.List*) 
declare %struct.List* @addListToList(%struct.List*, %struct.List*) 
declare %struct.List* @addStringToList(%struct.List*, i8*) 
declare %struct.List* @addNumberToList(%struct.List*, double) 
declare %struct.List* @addBooleanToList(%struct.List*, i1 zeroext) 
declare %struct.List* @addNullToList(%struct.List*) 

>>