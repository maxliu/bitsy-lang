file(fileName, strings, locals, block) ::= <<
#!/bin/bash

main() {
	<block>
}

<runtime()>

main "$@"
>>
