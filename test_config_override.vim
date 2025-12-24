" Test loading floaterm then applying our configuration
set runtimepath+=.

" Load floaterm (using the system version)
packadd vim-floaterm

echo "After loading floaterm:"
echo "floaterm_shell: " . get(g:, 'floaterm_shell', 'NOT SET')
echo "floaterm_width: " . get(g:, 'floaterm_width', 'NOT SET')
echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', 'NOT SET')
echo "floaterm_position: " . get(g:, 'floaterm_position', 'NOT SET')

" Now load our configuration override
source codebuddy_config.vim

echo "After loading CodeBuddy config:"
echo "floaterm_shell: " . get(g:, 'floaterm_shell', 'NOT SET')
echo "floaterm_width: " . get(g:, 'floaterm_width', 'NOT SET')
echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', 'NOT SET')
echo "floaterm_position: " . get(g:, 'floaterm_position', 'NOT SET')

" Check if our command exists
if exists(':CodeBuddy')
  echo "CodeBuddy command: EXISTS"
else
  echo "CodeBuddy command: NOT FOUND"
endif

echo "Configuration override test complete"