" This overwrite the default vim go compiler option

let compiler='go'
CompilerSet makeprg=go\ build\ ./...
CompilerSet errorformat=%E%f:%l%c:%m

" You can now simply 
" compiler go
" make go projects
