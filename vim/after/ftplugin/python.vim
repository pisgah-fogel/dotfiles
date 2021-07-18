setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
setlocal colorcolumn=80

" Only ok for small projects
setlocal path=.,** 
setlocal wildignore=*.pyc

" search all imports
" ^\s*\(from\|import\)\s*\zs\(\S\+\s\{-}\)*\ze\($\| as\)
"
" # 1
" import conv.metric
" /conv.metrics/
" conv/metrics
"
" # 2
" from conv import conversion as conv
" /conv import convertion/
" conv/conversion.py conv.py
"
" # 3
" from cocotb.triggers import FallingEdge
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
setlocal define=^\\s*\\(def\\\|class\\)

function! PyInclude(fname)
	let parts = split(a:fname, ' import ')
	" #1 conv.metrics
	" #2 [conv, conversion]
	let l = parts[0]
	" #1 conv.metrics
	" #2 conv
	if len(parts) > 1
		let r = parts[1]
		" #2 conversion
		let joined = join([l, r], '.')
		" #2 conv.convertion
		let fp = substitute(joined, '\.', '/', 'g') . 'py'
		let found = glob(fp, 1)
		if len(found)
			return found
		endif
	endif
	return substitute(l, '\.', '/', 'g') . 'py'
endfunction
setlocal includeexpr=PyInclude(v:fname)
