forStatement(id, fromVal, toVal, block, scope, label) ::= <<
for ((<id>=<int(fromVal)>; <id>\<=<int(toVal)>; <id>++))
do
   <block>
done

>>