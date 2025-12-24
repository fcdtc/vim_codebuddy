" Start with clean state
set packpath=
set runtimepath+=.

" Manually source our plugin file
echo "Sourcing plugin file..."
source plugin/floaterm.vim

" Check our forced configuration values
echo "After loading plugin:"
echo "floaterm_shell: " . get(g:, 'floaterm_shell', 'NOT SET')
echo "floaterm_width: " . get(g:, 'floaterm_width', 'NOT SET')
echo "floaterm_height: " . get(g:, 'floaterm_height', 'NOT SET')
echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', 'NOT SET')
echo "floaterm_position: " . get(g:, 'floaterm_position', 'NOT SET')

" Check for command existence
if exists(':CodeBuddy')
  echo "CodeBuddy command: EXISTS"
else
  echo "CodeBuddy command: NOT FOUND"
endif

if exists(':FloatermNew')
  echo "FloatermNew command: EXISTS"
else
  echo "FloatermNew command: NOT FOUND"
endif

echo "Configuration test complete"