" 行番号を表示
set number

" シンタックスハイライトの有効化
syntax enable

" 検索時の小文字大文字無視
set ic

" 検索対象ハイライト
set hls

" tab space
set tabstop=2
set expandtab
set shiftwidth=2

" クリップぼーど有効化
"set clipboard=unnamedplus

"インデントキープ"
set autoindent

set history=200

set incsearch

set backspace=indent,eol,start

filetype plugin on


" key mappings
nnoremap U <c-r>


xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

let open_weather_appid = '37df8a0b623ec705ce4643439b0debf0'


" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
