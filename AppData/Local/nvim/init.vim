" ================== 基础核心配置 ==================
set nocompatible
set nu ru relativenumber    " 显示绝对行号+相对行号
set wrap showcmd showmode    " 自动折行/显示指令/模式状态
set mouse=a incsearch        " 鼠标支持/实时搜索
set undofile                 " 启用持久撤销
set undodir=~\.vim\undo      " 撤销文件存储路径
set wildmenu wildmode=full   " 增强命令行补全
syntax on                    " 开启语法高亮
" ================ 跨平台适配配置 ================
if has('win32')
  let $SHELL = 'powershell.exe'  " Windows平台使用PowerShell
  set undodir=~/vimfiles/undo    " Windows专用撤销目录
endif

" ================ 智能文件类型配置 ================
augroup filetype_settings
  autocmd!

  " ---- Python开发环境 ----
  autocmd FileType python setlocal expandtab shiftwidth=4
  autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>   " 快速注释
  autocmd FileType python nnoremap <buffer> <localleader>n F#x<esc>   " 快速取消注释
  autocmd FileType python nnoremap <buffer> <F5> :w<CR>:botright 10sp term://python3 %<CR>
  autocmd FileType python inoremap <buffer> <F5> <esc>:w<CR>:botright 10sp term://python -i %<CR>
  autocmd FileType python iabbrev <buffer> main if __name__ == "__main__":

  " ---- Web开发环境 ----
  autocmd FileType html setlocal nowrap
  autocmd FileType javascript,typescript,vue setlocal tabstop=2
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>

  " ---- java开发环境 ----
  autocmd FileType java nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType java nnoremap <buffer> <localleader>n :s#//##g<CR>:noh<CR>

  " ---- C语言环境 ----
  autocmd FileType c iabbrev <buffer> main int main(int argc, char* argv[])
  autocmd FileType c,cpp nnoremap <buffer> <F5> :w<CR>:!g++ % -o %:r && %:r.exe<CR>
  autocmd FileType c iabbrev <buffer> stdio #include <stdio.h>
  autocmd FileType c iabbrev <buffer> stdlib #include <stdlib.h>
  autocmd FileType c iabbrev <buffer> fori for (int i=0; i<; i++)<Left><Left><Left><Left>

  " ---- 通用文件处理 ----
  autocmd BufWritePre *.js,*.ts,*.vue normal mzgg=G`z  
  autocmd BufNewFile * w | echo "New File"              
augroup END

" ================ 终端深度集成配置 ================
augroup terminal_integration
  autocmd!
  autocmd TermEnter * setlocal scrollback=10000  " 保留10000行终端历史
  autocmd BufEnter term://* startinsert          " 进入终端自动插入模式
  autocmd TermOpen * startinsert                 " 进入终端自动插入模式
  autocmd TermOpen * setlocal nobuflisted        " 隐藏终端缓冲区
  autocmd TermClose * setlocal bufhidden=hide    " 保留终端历史记录
  autocmd TermOpen * startinsert                 " 打开即进入编辑模式
  autocmd TermOpen * normal G                    
augroup END

" ================ 高效快捷键系统 ================
let mapleader = " "  " 全局前缀键配置
let maplocalleader = " "  " 本地前缀键配置

" 配置管理快捷键
nnoremap <leader>ee :botright vsp $MYVIMRC<CR>  " 垂直分割打开配置文件
nnoremap <leader>ss :w<CR>:source $MYVIMRC<CR>:q<CR>  " 保存并重载配置
nnoremap <leader>jp yyp

" 终端控制快捷键
nnoremap <leader>tt :botright 10sp term://$SHELL<CR>  
tnoremap <leader>q <C-\><C-n>:bd!<CR>                " 安全关闭终端

" 文本操作快捷键
nnoremap <leader>jp yy"0p
nnoremap <leader>" viw<esc>bi"<esc>ea"<esc>  " 快速添加双引号
nnoremap <Leader>, mzA;<esc>`z               " 行尾智能加分号


" ================ 调试扩展配置 ================
" 取消注释以下配置以启用调试功能
" nnoremap <F5> :lua require('dap').continue()<CR>
" nnoremap <leader>b :lua require('dap').toggle_breakpoint()<CR>
" nnoremap <F10> :lua require('dap').step_over()<CR>
" nnoremap <F11> :lua require('dap').step_into()<CR>
" nnoremap <F12> :lua require('dap').step_out()<CR>

