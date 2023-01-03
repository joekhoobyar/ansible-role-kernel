#!/bin/bash -eux
find scripts -type f -perm /111 -exec sh -c 'if file -b {} | egrep "^ELF.*x86-64"; then rm {}; fi' \;

( cd scripts

	gcc mkkrnlimg.c -o "mkkrnlimg"
	gcc kallsyms.c -o "kallsyms"
	[ -f pnmtologo.c ] && gcc pnmtologo.c -o "pnmtologo"
	[ -f conmakehash.c ] && gcc conmakehash.c -o "conmakehash"
	gcc resource_tool.c -o "resource_tool"
	[ -f basic/bin2c.c ] && gcc ./basic/bin2c.c -o "basic/bin2c"
	gcc recordmcount.c -o "recordmcount"
	[ -f sortextable.c ] && gcc -I../tools/include sortextable.c -o "sortextable"
	gcc unifdef.c -o "unifdef"
	gcc ./basic/fixdep.c -o "basic/fixdep"
	gcc extract-cert.c -o "extract-cert" -lssl -lcrypto
	gcc ./mod/modpost.c ./mod/file2alias.c ./mod/sumversion.c -o "mod/modpost"
	gcc ./mod/mk_elfconfig.c -o "mod/mk_elfconfig"
	gcc  -I../include asn1_compiler.c -o "asn1_compiler"

	gcc ./genksyms/genksyms.c ./genksyms/parse.tab.c ./genksyms/lex.lex.c -o "genksyms/genksyms"
)
