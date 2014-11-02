forStatement(id, symbol, fromVal, toVal, block, scope, label, register) ::= <<
for ((<id>=<int(fromVal)>; <id>\<=<int(toVal)>; <id>++))
do
   <block>
done

>>