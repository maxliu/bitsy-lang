file(fileName, strings, functions, block, localCount) ::= <<
%union.Value = type { double }
%struct.Object = type { i32, %union.Value }
%struct.List = type { i32, i32, %struct.Object* }

<strings:{s | @.str<i> = internal constant <llvmConstant(s)>}; separator="\n">

<functions:{f | <f>}; separator="\n">
define i32 @main() {
	call void (...)* @GC_init()
    <block>
    ret i32 0;
}

;
; Bitsy Runtime methods and strings
;
<runtime()>
>>
