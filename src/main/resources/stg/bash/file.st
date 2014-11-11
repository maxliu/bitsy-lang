file(fileName, strings, functions, block, localCount) ::= <<
#!/bin/bash

<functions:{f | <f>}; separator="\n">
main() {
	<block>
}

<runtime()>

main "$@"
>>
