file(fileName, strings, scope, block) ::= <<
#!/bin/bash

main() {
	<block>
}

<runtime()>

main "$@"
>>
