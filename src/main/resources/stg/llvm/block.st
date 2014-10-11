block(symbols, statements, scope) ::= <<
<symbols:{ s | %<bitsyVariable(s.name)> = alloca <symbolType(s.type)>}; separator="\n">
<statements;separator="\n">
>>