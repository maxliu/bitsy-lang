file(fileName, strings, functions, block, localCount) ::= <<
%union.Value = type { double }
%struct.Object = type { i32, %union.Value }

<strings:{s | @.str<i> = internal constant <llvmConstant(s)>}; separator="\n">

<functions:{f | <f>}; separator="\n">
define i32 @main() {
    <block>
    ret i32 0;
}

;
; Bitsy Runtime methods and strings
;
<runtime()>
>>
