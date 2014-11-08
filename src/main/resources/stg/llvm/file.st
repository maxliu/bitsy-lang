file(fileName, strings, functions, scope, block) ::= <<
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
