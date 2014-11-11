forStatement(id, symbol, fromVal, toVal, block, label, register) ::= <<
; forStatement <id> <fromVal> <toVal>
<load(fromVal)>
dstore <symbol.local>

forStatement<label>:
    dload <symbol.local>
    <load(toVal)>
    dcmpg
    ifgt endFor<label>

    <block>

    dload <symbol.local>
    dconst_1
    dadd
    dstore <symbol.local>
    goto forStatement<label>
endFor<label>:
>>