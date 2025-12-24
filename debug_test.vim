" Make sure no other floaterm is loaded
set packpath=
set runtimepath+=.

" Debug step by step
echo "Step 1: Before loading plugin"
echo "g:floaterm_shell exists: " . exists('g:floaterm_shell')
echo "g:floaterm_shell value: " . get(g:, 'floaterm_shell', 'NOT SET')

echo "Step 2: Sourcing plugin..."
let debug_output = system("cat plugin/floaterm.vim | head -n 20")
echo debug_output

source plugin/floaterm.vim

echo "Step 3: After loading plugin"
echo "g:floaterm_shell exists: " . exists('g:floaterm_shell')
echo "g:floaterm_shell value: " . get(g:, 'floaterm_shell', 'NOT SET')
echo "g:floaterm_width: " . get(g:, 'floaterm_width', 'NOT SET')
echo "g:floaterm_wintype: " . get(g:, 'floaterm_wintype', 'NOT SET')

" Check specifically what lines are in the plugin
echo "Reading actual plugin content lines 16-25:"
echo system("sed -n '16,25p' plugin/floaterm.vim")