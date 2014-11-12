listExpression(register, list) ::= <<
; Allocate List and Item Array
%item_array<register> = alloca [<length(list)> x %struct.Object]
%r<register> = alloca %struct.List

; Get List structure
%list_size<register> = getelementptr inbounds %struct.List* %r<register>, i32 0, i32 0
%list_capacity<register> = getelementptr inbounds %struct.List* %r<register>, i32 0, i32 1
%list_items<register> = getelementptr inbounds %struct.List* %r<register>, i32 0, i32 2
%item_array_ptr<register> = getelementptr inbounds [<length(list)> x %struct.Object]* %item_array<register>, i32 0, i32 0

; Store length, capacity and item array pointers
store i32 <length(list)>, i32* %list_size<register>
store i32 <length(list)>, i32* %list_capacity<register>
store %struct.Object* %item_array_ptr<register>, %struct.Object** %list_items<register>

; Populate each item
<list:{ value | <addToList(register, i0, length(list), value)>}; separator="\n">
>>