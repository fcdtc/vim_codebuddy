" Simple test script to verify the codebuddy terminal functionality
" Save this as test_codebuddy.vim and run: nvim -S test_codebuddy.vim

" Test 1: Check if custom configuration values are set correctly
echo "Testing default configuration values..."
echo "floaterm_shell: " . get(g:, 'floaterm_shell', 'NOT SET')
echo "floaterm_width: " . get(g:, 'floaterm_width', 0.6)
echo "floaterm_height: " . get(g:, 'floaterm_height', 0.6)
echo "floaterm_wintype: " . get(g:, 'floaterm_wintype', 'float')
echo "floaterm_position: " . get(g:, 'floaterm_position', 'center')

" Test 2: Execute CodeBuddy command to open terminal
echo "Opening CodeBuddy terminal..."

try
  CodeBuddy
  echo "CodeBuddy command executed successfully"
catch
  echo "Error executing CodeBuddy: " . v:exception
endtry