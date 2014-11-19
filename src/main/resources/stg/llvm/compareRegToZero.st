compareRegToZero(prefix, value, register, lastRegister, op="eq") ::= <<
<if(value.string)>
%<prefix><register> = load i8* <argRegister(value, prefix, lastRegister)>
%<prefix>_sext<register> = sext i8 %<prefix><register> to i32
%<prefix>_cmp<register> = icmp <op> i32 %<prefix>_sext<register>, 0
<elseif(value.number)>
%<prefix><register> = fadd double <argRegister(value, prefix, lastRegister)>, 0.0
%<prefix>_cmp<register> = fcmp u<op> double %<prefix><register>, 0.000000e+00
<elseif(value.boolean)>
%<prefix><register> = add i1 <argRegister(value, prefix, lastRegister)>, 0
%<prefix>_cmp<register> = icmp <op> i1 %<prefix><register>, 0
<endif>
>>