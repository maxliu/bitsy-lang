file(fileName, strings, functions, block) ::= <<
#!/bin/bash

<functions:{f | <f>}; separator="\n">
main() {
	<block>
}

<runtime()>

main "$@"
>>
