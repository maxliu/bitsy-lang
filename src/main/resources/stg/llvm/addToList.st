addToList(register, i, length, value) ::= <<
%item<register>_<i> = getelementptr inbounds %struct.Object* %objectPtr<register>, i64 <i>
%item<register>_type_<i> = getelementptr inbounds %struct.Object* %item<register>_<i>, i32 0, i32 0
%item<register>_value_<i> = getelementptr inbounds %struct.Object* %item<register>_<i>, i32 0, i32 1
<loadOperand(value, register, prefixIndex("item", i))>
<if(value.boolean)> 
store i32 2, i32* %item<register>_type_<i>
%item<register>_value_union_<i> = bitcast %union.Value* %item<register>_value_<i> to i32*
store i32 <argRegister(value, prefixIndex("item", i), register)>, i32* %item<register>_value_union_<i>
<elseif(value.number)>
store i32 1, i32* %item<register>_type_<i>
%item<register>_value_union_<i> = bitcast %union.Value* %item<register>_value_<i> to double*
store double <argRegister(value, prefixIndex("item", i), register)>, double* %item<register>_value_union_<i>
<elseif(value.string)>
store i32 0, i32* %item<register>_type_<i>
%item<register>_value_union_<i> = bitcast %union.Value* %item<register>_value_<i> to i8**
store i8* <argRegister(value, prefixIndex("item", i), register)>, i8** %item<register>_value_union_<i>
<elseif(value.list)>
store i32 3, i32* %item<register>_type_<i>
%item<register>_value_union_<i> = bitcast %union.Value* %item<register>_value_<i> to %struct.List**
store %struct.List* <argRegister(value, prefixIndex("item", i), register)>, %struct.List** %item<register>_value_union_<i>
<else>
store i32 5, i32* %item<register>_type_<i>
<endif>
>>