skip_vim_plugin "command-t"
vim_plugin_task "phpfolding", "https://github.com/vim-scripts/phpfolding.vim.git"
vim_plugin_task "BufOnly" do
  sh "curl http://www.vim.org/scripts/download_script.php?src_id=3388 > plugin/bufonly.vim"
end
