# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

vim-floaterm is a Vim/Neovim plugin that enables terminal windows in floating/popup windows. It supports both Neovim's floatwin and Vim8's popupwin features.

## Development Commands

### Testing
```bash
# Run all tests with nvim (default)
./test/test.sh

# Run tests with specific vim binary
./test/test.sh vim
./test/test.sh nvim
```

Tests use the Vader testing framework. Test files are located in `test/` with subdirectories for different test categories:
- `test_commands/` - Command tests (FloatermNew, FloatermToggle, etc.)
- `test_options/` - Configuration option tests
- `test_extensions/` - Integration tests with other plugins
- `test_functions/` - Internal function tests

## Architecture

### Core Components

**Buffer Management (buflist.vim)**
- Implements a double-circular-linkedlist to manage multiple floaterm instances
- Each node contains a buffer number and links to next/prev terminals
- Allows navigation between terminals with FloatermNext/FloatermPrev

**Terminal Management (terminal.vim)**
- Handles terminal lifecycle: spawn, send commands, kill
- Uses `termopen()` for Neovim and `term_start()` for Vim8
- Manages job callbacks and exit handlers
- Maintains `s:channel_map` mapping bufnr to channels for command sending

**Window Management (window.vim)**
- Calculates window position based on configuration (center, topleft, etc.)
- Handles both float/popup windows and split windows
- Manages window hiding/showing and title rendering

**Configuration (config.vim)**
- Parses and validates floaterm options (width, height, position, etc.)
- Supports both global defaults and per-terminal overrides
- Options can be passed via `--key=value` syntax in commands

### Command Flow

When `:FloatermNew [cmd]` is executed:
1. `plugin/floaterm.vim` - Command definition calls `floaterm#run()`
2. `autoload/floaterm.vim` - `floaterm#run()` parses args and calls `floaterm#new()`
3. `floaterm#new()` checks for wrappers in `autoload/floaterm/wrapper/`
4. `terminal.vim` - `s:spawn_terminal()` creates buffer and opens terminal
5. `window.vim` - Opens float/popup or split window
6. `buflist.vim` - Adds terminal to the linked list

### Wrapper System

Wrappers intercept commands for specific tools (fzf, ranger, etc.) and provide enhanced integration. Located in `autoload/floaterm/wrapper/`:

- Each wrapper is a function named `floaterm#wrapper#<tool>#(cmd, jobopts, config)`
- Returns `[send2shell, cmd]` where:
  - `send2shell=v:true` - Command runs in shell, `cmd` sent after startup
  - `send2shell=v:false` - Command passed directly to `termopen()`/`term_start()`
- Wrappers can register `on_exit` callbacks in `jobopts` for custom cleanup

### Edita Integration

The `autoload/floaterm/edita/` directory provides integration to open files from within terminal without nesting Vim instances:

- Sets `$FLOATERM` environment variable to an RPC command
- The `bin/floaterm` script uses `$FLOATERM` to open files in parent Vim
- Separate implementations for Neovim (`neovim/`) and Vim (`vim/`)

## Key Design Patterns

**Platform Abstraction**: Code uses `has('nvim')` checks to handle differences between Neovim and Vim8 terminal APIs.

**Configuration Inheritance**: Options follow priority: command-line args > buffer-local > global defaults.

**Event-Driven Lifecycle**: Uses autocmds (FloatermOpen, BufHidden, etc.) and job callbacks for state management.

**Lazy Window Creation**: Terminal buffers can be created with `--silent` and toggled later, supporting background terminal workflows.
