{
  preamble = ''
    set nocompatible
    set encoding=utf-8

    set showcmd                     " display incomplete commands

    "" Unfold by default
    set foldlevel=99

    "" Whitespace
    set nowrap                      " don't wrap lines
    set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
    set expandtab                   " use spaces, not tabs (optional)

    "" Searching
    set hlsearch                    " highlight matches
    set ignorecase                  " searches are case insensitive...
    set smartcase                   " ... unless they contain at least one capital letter

    set laststatus=2

    set number relativenumber
    set numberwidth=4
    highlight LineNr guifg=LightGrey

    set smartindent
    '';

  jkToEsc = ''
    "" map jk to ESC to save some pinky stretching
    inoremap jk <ESC>
    vnoremap jk <ESC>

    "" unmap esc and arrows to break the habit of using them
    inoremap <ESC> <NOP>
    vnoremap <ESC> <NOP>

    inoremap <Left> <NOP>
    inoremap <Right> <NOP>
    inoremap <Up> <NOP>
    inoremap <Down> <NOP>

    noremap <Left> <NOP>
    noremap <Right> <NOP>
    noremap <Up> <NOP>
    noremap <Down> <NOP>
  '';

  swapColonComma = ''
    "" swap colon and comma re: https://konfekt.github.io/blog/2016/10/03/get-the-leader-right
    nnoremap : ,
    xnoremap : ,
    onoremap : ,

    nnoremap , :
    xnoremap , :
    onoremap , :

    nnoremap g: g,
    nnoremap g, <NOP>

    nnoremap @, @:
    nnoremap @: <NOP>
  '';

  switchWinOnGSpace = ''
    """ split window switch
    noremap g<space> <C-w>w
  '';

  applyTheme = ''
    if (has("termguicolors"))
     set termguicolors
    endif
    set background=light
    let g:solarized_termcolors=256
    colorscheme solarized
  '';

  setupLightline = ''
    " Lightline
    let g:lightline = {
      \     'colorscheme': 'solarized',
      \     'active': {
      \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
      \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
      \     }
      \ }
  '';

  setupFzf = ''
    nnoremap <C-p> :Files<CR>
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \}
  '';

  setupNerdcomment = ''
    " Nerd Commenter
    " " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1
    " " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " " Map ++ to call NERD Commenter and use iTerm key bindings 
    " " to bind Ctmd+/ to ++
    vmap ++ <plug>NERDCommenterToggle
    nmap ++ <plug>NERDCommenterToggle
  '';

  setupNerdtree = ''
    " NERDTree
    let g:NERDTreeShowHidden = 1 
    let g:NERDTreeMinimalUI = 1 " hide helper
    let g:NERDTreeIgnore = ['^node_modules$', '^.venv$', '.swp$', '^target$'] " ignore node_modules to increase load speed 
    let g:NERDTreeStatusline = "" " set to empty to use lightline

    " " Toggle
    noremap <silent> <C-b> :NERDTreeToggle<CR>
    " " Close window if NERDTree is the last one
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " " Map to open current file in NERDTree and set size
    nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>

    " NERDTree Syntax Highlight
    " " Enables folder icon highlighting using exact match
    let g:NERDTreeHighlightFolders = 1 
    " " Highlights the folder name
    let g:NERDTreeHighlightFoldersFullName = 1 
    " " Color customization
    let s:brown = "905532"
    let s:aqua =  "3AFFDB"
    let s:blue = "689FB6"
    let s:darkBlue = "44788E"
    let s:purple = "834F79"
    let s:lightPurple = "834F79"
    let s:red = "AE403F"
    let s:beige = "F5C06F"
    let s:yellow = "F09F17"
    let s:orange = "D4843E"
    let s:darkOrange = "F16529"
    let s:pink = "CB6F6F"
    let s:salmon = "EE6E73"
    let s:green = "8FAA54"
    let s:lightGreen = "31B53E"
    let s:white = "FFFFFF"
    let s:rspec_red = 'FE405F'
    let s:git_orange = 'F54D27'
    " " This line is needed to avoid error
    let g:NERDTreeExtensionHighlightColor = {} 
    " " Sets the color of css files to blue
    let g:NERDTreeExtensionHighlightColor['css'] = s:blue 
    " " This line is needed to avoid error
    let g:NERDTreeExactMatchHighlightColor = {} 
    " " Sets the color for .gitignore files
    let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange 
    " " This line is needed to avoid error
    let g:NERDTreePatternMatchHighlightColor = {} 
    " " Sets the color for files ending with _spec.rb
    let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb''$'] = s:rspec_red 
    " " Sets the color for folders that did not match any rule
    let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
    " " Sets the color for files that did not match any rule
    let g:WebDevIconsDefaultFileSymbolColor = s:blue 
  '';
}
