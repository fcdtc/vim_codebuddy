" Final test of CodeBuddy integration

" Load the config
source INSTALL_CODEBUDDY.vim

echo "Final configuration test:"
echo "CodeBuddy shell: " . g:floaterm_shell
echo "Terminal width: " . g:floaterm_width
echo "Window type: " . g:floaterm_wintype
echo "Position: " . g:floaterm_position

if exists(':CodeBuddy')
  echo "Command available: :CodeBuddy"
else
  echo "ERROR: CodeBuddy command not found"
endif

echo "CodeBuddy integration is ready!"
echo "To use in Neovim/Vim:"
echo "1. Run :source INSTALL_CODEBUDDY.vim"
echo "2. Run :CodeBuddy to open terminal"