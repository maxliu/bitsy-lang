listExpression(register, list, listBytes) ::= <<
; Allocate List 
%listVoidPtr<register> = call i8* @GC_malloc(i64 16)
%r<register> = bitcast i8* %listVoidPtr<register> to %struct.List*

; Allocate Item Array
%objectVoidPtr<register> = call i8* @GC_malloc(i64 <listBytes>)
%objectPtr<register> = bitcast i8* %objectVoidPtr<register> to %struct.Object*

; Get List structure
%list_size<register> = getelementptr inbounds %struct.List* %r<register>, i32 0, i32 0
%list_capacity<register> = getelementptr inbounds %struct.List* %r<register>, i32 0, i32 1
%list_items<register> = getelementptr inbounds %struct.List* %r<register>, i32 0, i32 2

; Store length, capacity and item(object) array pointers
store i32 <length(list)>, i32* %list_size<register>
store i32 <length(list)>, i32* %list_capacity<register>
store %struct.Object* %objectPtr<register>, %struct.Object** %list_items<register>

; Populate each item
<list:{ value | <addToList(register, i0, length(list), value)>}; separator="\n">
>>