" Variable
syntax match Identifier +\(\W\|^\)\@<=let\(\W\|$\)\@=+

" Global parameters
syntax match Identifier +\(\W\|^\)\@<=execute:\(\W\|$\)\@=+
syntax match Identifier +\(\W\|^\)\@<=audit\(\s\+.*=\)\@=+

" Audit profiles
syntax match Identifier +\(\W\|^\)\@<=audit profile\(\W\|$\)\@=+

" Including
syntax match Identifier +\(\W\|^\)\@<=use\(\s*EDL\)*\(\W\|$\)\@=+

" Security object model
syntax match Identifier +\(\W\|^\)\@<=policy object\(\W\|$\)\@=+

" Security events
syntax match Identifier +\(\W\|^\)\@<=request\(\W\|$\)\@=+
syntax match Identifier +\(\W\|^\)\@<=response\(\W\|$\)\@=+
syntax match Identifier +\(\W\|^\)\@<=error\(\W\|$\)\@=+
syntax match Identifier +\(\W\|^\)\@<=security\(\W\|$\)\@=+
syntax match Identifier +\(\W\|^\)\@<=execute\(\W\|$\)\@=+

" Security model methods
syntax match Number +\(\W\|^\)\@<=match\(\W\|$\)\@=+
syntax match Number +\(\W\|^\)\@<=choice\(\W\|$\)\@=+
syntax match Statement +\(\W\|^\)\@<=grant\(\W\|$\)\@=+
syntax match Statement +\(\W\|^\)\@<=assert\(\W\|$\)\@=+
syntax match Statement +\(\W\|^\)\@<=deny\(\W\|$\)\@=+
syntax match Statement +\(\W\|^\)\@<=set_level\(\W\|$\)\@=+

" Strings
syntax match String +"[^"]*"+

" Comment
syntax region Comment start=+/\*+ end=+\*/+
syntax match Comment +//.*$+
