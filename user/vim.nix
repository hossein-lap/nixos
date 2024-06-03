{ pkgs, ... }:
{
  environment.variables = { EDITOR = "vim"; };
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        set nu rnu
        set nocp
        set showmode showcmd showmatch
        set autoindent smartindent cindent
        set bs=2 ls=2
        set hlsearch incsearch
        set scrolloff=8
        nnoremap Q <nop>
        syntax on
        set background=dark
        " set t_Co=256
        " colorscheme lunaperche
        " colorscheme torte
        colorscheme slate
        set wildmenu wildmode=full
        set foldmethod=marker
        set splitbelow splitright
        set tabstop=4 shiftwidth=4
        au FileType yaml expandtab tabstop=2 shiftwidth=2
        set colorcolumn=80
        set undofile undodir=$HOME/.vim/undo undolevels=1000 undoreload=10000
        nnoremap <silent> ]t :tabnext<CR>
        nnoremap <silent> [t :tabprev<CR>
        nnoremap <silent> ]b :bnext<CR>
        nnoremap <silent> [b :bprev<CR>
        hi! Normal ctermbg=NONE guibg=NONE
        " hi! StatusLine ctermbg=232 guibg='#080808' ctermfg=darkblue guifg=darkblue
        set showtabline=2
      '';
    }
  )];
}
