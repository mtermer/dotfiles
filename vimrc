" =============================================================================
" MINIMALISTICKÝ .VIMRC PRO UNIX ADMINA
" =============================================================================

" --- DETEKCE SCHOPNOSTÍ (Fallback pro Tiny/Minimal) ---
silent! let g:is_tiny = !has('syntax') || !has('multi_byte')

if !g:is_tiny
  set laststatus=2
  " --- ZÁKLADNÍ NASTAVENÍ ---
  set nocompatible              " Vypne kompatibilitu s historickým vi
  filetype plugin indent on     " Detekce typu souboru a načtení pluginů/odsazení
  syntax on                     " Zapne zvýraznění syntaxe
  set number                    " Zobrazí čísla řádků
  " set relativenumber            " Relativní číslování (skvělé pro skoky typu 5j)
  set mouse=a                   " Povolí myš ve všech režimech
  set encoding=utf-8            " Standardní kódování
  set hidden                    " Umožní přepínat mezi buffery bez uložení

  " --- ODSAZENÍ A TABULÁTORY ---
  " Nastaveno na 2 mezery dle preference
  set expandtab                 " Převádí tabulátory na mezery
  set shiftwidth=2              " Velikost odsazení (při >> nebo <<)
  set softtabstop=2             " Počet mezer, které tabulátor vloží
  set tabstop=2                 " Šířka tabulátoru

  " --- CHOVÁNÍ A VYHLEDÁVÁNÍ ---
  set ignorecase                " Ignorovat velikost písmen při hledání
  set smartcase                 " Pokud napíšete velké písmeno, začne na velikosti záležet
  set incsearch                 " Vyhledávání během psaní
  set hlsearch                  " Zvýraznit výsledky hledání
  set laststatus=2              " Vždy zobrazit stavový řádek
  set noshowmode                " (Volitelné) Skryje --INSERT--, pokud používáte statusline

  " --- PASTE REŽIM (Schránka) ---
  " Toggle paste režimu pomocí klávesy F2 (zabrání rozbití odsazení při vkládání myší)
  set pastetoggle=<F2>

  " --- VLASTNÍ STAVOVÝ ŘÁDEK (STATUSLINE) ---
  set laststatus=2              " Vždy zobrazit stavový řádek
  set statusline=
  set statusline+=%f            " Cesta k souboru
  set statusline+=\ %m          " Příznak změny [+] (pokud není uloženo)
  set statusline+=\ %r          " Příznak [RO] (Read Only - užitečné pro root soubory)
  set statusline+=%=            " Oddělovač (vše za ním bude vpravo)
  set statusline+=\ %y          " Typ souboru (python, yaml, atd.)
  set statusline+=\ [%{&ff}]    " Formát konce řádku (unix/dos) - u admina kritické
  set statusline+=\ %p%%        " Procentuální pozice v souboru
  set statusline+=\ %l:%c       " Číslo řádku : Číslo sloupce

  " --- DOPLŇOVÁNÍ (Omni Completion) ---
  " Vim má vestavěné doplňování (Ctrl+N nebo Ctrl+P v insert módu)
  " Pro Python a YAML využijeme vestavěné omnicomplete:
  set wildmenu                  " Grafické menu pro příkazy
  set wildmode=list:longest,full
  " Vyvolání doplnění: Ctrl+X následované Ctrl+O (v insert módu)
  autocmd FileType python setlocal omnifunc=python3complete#Complete
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " --- SPECIÁLNÍ ÚPRAVY PRO ADMINY ---
  " Odstraní nadbytečné mezery na konci řádku při uložení
  autocmd BufWritePre * %s/\s\+$//e

  " Zvýraznění sloupce na 80. znaku (volitelné, pro čistotu kódu)
  set colorcolumn=80
  " Nastavení decentní barvy pro ColorColumn
  highlight ColorColumn ctermbg=235 ctermfg=NONE

  " --- MAPOVÁNÍ KLÁVES (LEADER) ---
  " Nastavíme Leader na čárku, je to pro admina lépe po ruce než backslash
  let mapleader = ","

  " Rychlé přepínání pastemode (náhrada za nespolehlivé F2)
  nnoremap <leader>p :set invpaste paste?<CR>

  " --- PRÁCE S BUFFERY (OTEVŘENÝMI SOUBORY) ---
  " Přepínání mezi buffery pomocí šipek (nebo zkratek ,n a ,p)
  nnoremap <leader>n :bnext<CR>
  nnoremap <leader>p :bprevious<CR>
  " Smazání bufferu (zavření souboru, ale ne Vimu)
  nnoremap <leader>c :bdelete<CR>
  " Výpis bufferů a příprava na přepnutí
  nnoremap <leader>l :ls<CR>:b

  " --- ROZDĚLENÍ OBRAZOVKY (SPLIT) ---
  " Vertikální rozdělení a otevření nového bufferu
  nnoremap <leader>v :vnew<CR>
  " Horizontální rozdělení
  nnoremap <leader>h :new<CR>

  " Pohyb mezi okny (Ctrl + směr) - funguje i v PuTTY
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " --- DIFF REŽIM ---
  " Zapne diff na aktuální dvě okna (užitečné pro porovnání configů)
  nnoremap <leader>dt :diffthis<CR>
  " Vypne diff
  nnoremap <leader>do :diffoff<CR>

  " --- EFEKTIVNÍ ZKRATKY S CTRL (CAPS LOCK) ---

  " Ukládání souboru (Ctrl + s) - klasika, co šetří čas
  nnoremap <C-s> :w<CR>
  inoremap <C-s> <Esc>:w<CR>a

  " Rychlé ukončení bufferu (Ctrl + q)
  nnoremap <C-q> :bd<CR>

  " Vyvolání doplňování v insert módu (Ctrl + Space)
  " Poznámka: V terminálu se Ctrl+Space často posílá jako Ctrl+@ nebo Ctrl+n
  inoremap <C-Space> <C-n>

  " --- OPRAVA BAREV A TERMINÁLU ---
  set background=dark       " Řekne Vimu, že máte tmavé pozadí (upraví barvy fontu)
  set t_Co=256              " Vynutí 256 barev (klíčové pro PuTTY)

  " --- ŠETRNÉ DIFF BARVY (Ponechává syntaxi, mění jen pozadí) ---
  " ctermbg čísla odpovídají temným odstínům v 256-barevné paletě
  " 235 = velmi tmavě šedá, 22 = tmavě zelená, 52 = tmavě červená, 17 = tmavě modrá

  highlight DiffAdd    cterm=NONE ctermfg=NONE ctermbg=22
  highlight DiffDelete cterm=NONE ctermfg=NONE ctermbg=52
  highlight DiffChange cterm=NONE ctermfg=NONE ctermbg=17
  highlight DiffText   cterm=bold ctermfg=NONE ctermbg=19  " Výraznější modrá pro konkrétní změnu

  " --- SPOUŠTĚNÍ SKRIPTŮ ---
  function! RunCurrentScript()
    " Uložit soubor před spuštěním
    silent write

    " Název dočasného bufferu pro výstup
    let l:output_buf_name = "__Vim_Output__"

    " Pokud už okno s výstupem existuje, zavři ho
    let l:buf_win_id = bufwinnr(l:output_buf_name)
    if l:buf_win_id != -1
      execute l:buf_win_id . "wincmd q"
    endif

    " Definice příkazu podle typu souboru
    if &filetype == 'python'
      let l:cmd = "python3 " . expand('%')
    elseif &filetype == 'sh'
      let l:cmd = "bash " . expand('%')
    else
      echo "Neznámý typ souboru pro spuštění."
      return
    endif

    " Otevři nové okno dole, 10 řádků vysoké, a načti do něj výstup příkazu
    execute "botright 10new"
    setlocal buftype=nofile bufhidden=wipe noswapfile nowrap
    execute "file " . l:output_buf_name
    execute "read !" . l:cmd

    " Skoč na začátek výstupu a vrať se kurzorem do původního okna (volitelné)
    normal! gg
    wincmd p
  endfunction

  " Mapování na Leader + r (Run)
  nnoremap <leader>r :call RunCurrentScript()<CR>

else
  " --- Fallback pro Vim-tiny / Vi ---
  " V tiny verzi 'syntax on' vyhodí chybu, tak ji ani nezkoušíme
  set nocompatible    " Zajistí, že se to nechová jako úplně tupé 'vi'
  set backspace=2     " Aby fungoval backspace normálně
endif

" Základní věci, které většinou fungují všude
set number
set hlsearch
set incsearch

