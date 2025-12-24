set packpath+=.
set runtimepath+=.

" Load the plugin
source plugin/floaterm.vim

" Test configuration
echo "Test 1: Configuration values"
echo "floaterm_shell: " . get(g:, 'floaterm_shell', 'NOT SET')
echo "floaterm_width: " . get(g:, 'floaterm_width', 0.6)
echo "floaterm_height: " . get(g:, 'floaterm_height', 0.6)
echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', 'float')
echo "floaterm_position: " . get(g:, 'floaterm_position', 'center')

" Test if CodeBuddy command exists
echo "Test 2: Command existence"
if exists(':CodeBuddy')
  echo "CodeBuddy command: EXISTS"
else
  echo "CodeBuddy command: NOT FOUND"
endif

" Test if FloatermNew command exists
if exists(':FloatermNew')
  echo "FloatermNew command: EXISTS"
else
  echo "FloatermNew command: NOT FOUND"
endif

" Try to execute the command (this might fail in headless mode)
echo "Test 3: Command execution"
try
  " This might not work in headless mode, but let's see
  " CodeBuddy
  echo "Skipping actual terminal creation in headless mode"
catch
  echo "Expected error in headless mode: " . v:exception
endtry

echo "Test completed"