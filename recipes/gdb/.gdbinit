set history save
set verbose off
set print pretty on
set print array off
set print array-indexes on

define bs
save breakpoints ~/.gdb_breakpoints
end

define bl
source ~/.gdb_breakpoints
end
