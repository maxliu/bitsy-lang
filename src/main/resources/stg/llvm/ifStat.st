ifStat(value, block, scope, label, sublevel) ::= <<
<compareValToZero(value, scope)>
br i1 %c<scope.register>, label %true<label>_<sublevel>, label %false<label>_<sublevel>
true<label>_<sublevel>: 
    <block>
    br label %endif<label>
false<label>_<sublevel>:

>>
