file(fileName, strings, locals, block) ::= <<
<strings:{s | @.str<i> = internal constant <llvmConstant(s)>}; separator="\n">

define i32 @main() {
    <block>
    ret i32 0;
}

;
; Bitsy Runtime methods and strings
;
<runtime()>
>>
