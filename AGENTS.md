# AGENTS.md - SkCode Neovim Configuration Handover Document

## Project Overview
SkCode is a customized Neovim configuration based on NvChad, specifically optimized for frontend development. It provides a modern, feature-rich development environment with extensive language support, intelligent autocompletion, and efficient workflows.

## Architecture & Structure
```
.
├── init.lua              # Main entry point
├── lua/
│   ├── chadrc.lua        # Main configuration (themes, UI, etc.)
│   └── config/
│       ├── options.lua   # Neovim options (indentation, line numbers, etc.)
│       ├── mappings.lua  # Custom key mappings
│       ├── autocmds.lua  # Auto-commands and event handlers
│       ├── lazy.lua      # Lazy.nvim plugin manager setup
│       ├── plugins/      # Individual plugin configurations
│       └── utils/        # Custom utility functions
├── lazy-lock.json        # Plugin version lockfile
└── .stylua.toml          # Lua formatting configuration
```

## Plugin Management
- **Plugin Manager**: Lazy.nvim (auto-installs on first run)
- **Plugin Directory**: `~/.local/share/nvim/lazy/`
- **Lockfile**: `lazy-lock.json` tracks exact plugin versions
- **Update Command**: `:Lazy update` or `:Lazy sync`

## Build/Lint/Test Commands
- **Format Lua files**: `stylua --search-parent-directories --indent-type Spaces <file>`
- **Format JS/TS/CSS/HTML**: `prettier` or `prettierd` (auto-format on save)
- **LSP diagnostics**: Configured for TypeScript, Lua, CSS, ESLint, etc.
- **No test framework** - this is a Neovim configuration repository

## Development Workflow

### Initial Setup
1. Clone repository to `~/.config/nvim/`
2. Run `nvim` - Lazy.nvim will auto-install
3. Install LSP servers globally (see README.md for details)
4. Install formatters: `prettier`, `stylua`, `black`, `isort`, `rustfmt`

### Daily Usage
- **Auto-format**: Files format automatically on save via conform.nvim
- **LSP**: Language servers auto-start based on file type
- **Telescope**: Fuzzy finder for files, grep, buffers, etc.
- **Treesitter**: Syntax highlighting and text objects
- **Git Integration**: Gitsigns for inline git status

### Key Development Features
1. **Auto-completion**: nvim-cmp with LSP, snippets, and buffer sources
2. **Code Actions**: LSP-powered refactoring and fixes
3. **Organize Imports**: TypeScript import organization command
4. **Debugging**: Diagnostic navigation and quickfix lists
5. **Session Management**: Persistence.nvim for session restore

## Code Style Guidelines
- **Indentation**: 2 spaces (configured in `.stylua.toml` and `options.lua`)
- **Line width**: 120 characters (StyLua config)
- **Line endings**: Unix (LF)
- **Quotes**: Auto-prefer single quotes (StyLua)
- **Lua imports**: Use `require()` with relative paths in `lua/` directory
- **Naming**: camelCase for variables/functions, PascalCase for modules
- **Error handling**: Use `pcall()` for protected calls, `vim.notify()` for messages

## Language-Specific Formatting
- **Lua**: Stylua with Spaces indentation
- **JavaScript/TypeScript**: Prettier
- **CSS/SCSS/Less**: Prettier
- **HTML/JSON/Vue**: Prettier
- **Python**: isort + black
- **Rust**: rustfmt

## LSP Configuration

### Enabled LSP Servers
- **TypeScript/JavaScript**: tsserver with organize imports command
- **Lua**: lua_ls with workspace library configuration
- **CSS/SCSS/Less**: cssls with validation disabled
- **ESLint**: Auto-fix on save enabled
- **TailwindCSS**: Supports multiple filetypes
- **HTML**: html
- **JSON**: jsonls
- **Stylelint**: stylelint_lsp with auto-fix on save

### LSP Features
- **Diagnostics**: Real-time error/warning highlighting
- **Code Actions**: Quick fixes and refactorings
- **Hover Information**: Documentation on hover
- **Signature Help**: Function signatures as you type
- **Document Symbols**: Outline and navigation
- **Workspace Symbols**: Search across project

### Custom LSP Integrations
- **Creative Monorepo Support**: Special handling for `creative-tool-emo` and `creative_one_monorepo` projects
- **ESLint Root Detection**: Smart ESLint configuration detection
- **TypeScript Organize Imports**: Custom command for import organization

## Plugin Ecosystem

### Core Plugins
- **UI**: nvim-tree (file explorer), lualine (statusline), nvim-web-devicons
- **Editing**: nvim-autopairs, nvim-surround, nvim-comment, treesitter
- **Navigation**: telescope (fuzzy finder), harpoon (bookmarks), flash.nvim
- **LSP**: nvim-lspconfig, blink.cmp (autocomplete), fidget.nvim (progress)
- **Git**: gitsigns.nvim, lazygit.nvim
- **Formatting**: conform.nvim (auto-format), prettier, stylua
- **Terminal**: toggleterm.nvim, lazygit.nvim

### Custom Utilities
- **javascript.lua**: Auto-add `async` keyword when typing `await`
- **JSON utilities**: Custom JSON handling functions
- **Autocmds**: Custom auto-commands for cursor lines, yank highlighting, etc.

## Key Conventions & Mappings

### Leader Keys
- **Global Leader**: `<space>` (configured in `options.lua`)
- **Local Leader**: `\` (backslash)

### Essential Mappings
- **Window Navigation**: `<C-h/j/k/l>` for window movement
- **Buffer Management**: `<tab>`/`<S-tab>` for buffer navigation, `<leader>x` to close buffer
- **File Operations**: `<leader>w` save, `<leader>q` quit
- **Telescope**: `<leader>ff` find files, `<leader>fg` live grep
- **NvimTree**: `<leader>e` toggle file explorer
- **Terminal**: `<space>st` open horizontal terminal

### Custom Mappings
- **Visual Mode**: `p` to paste without overwriting register
- **Insert Mode**: `<C-e>` end of line, `<C-b>` beginning of line
- **Diagnostics**: `[d`/`]d` navigate diagnostics
- **Quickfix**: `<M-j>`/`<M-k>` navigate quickfix list

## Configuration Management

### Adding New Plugins
1. Create new file in `lua/config/plugins/`
2. Return plugin specification table
3. Run `:Lazy sync` to install

### Modifying Existing Configuration
- **Options**: Edit `lua/config/options.lua`
- **Mappings**: Edit `lua/config/mappings.lua`
- **Autocmds**: Edit `lua/config/autocmds.lua`
- **Plugin Configs**: Edit corresponding file in `lua/config/plugins/`

### Theme Customization
- **Current Theme**: onedark (configured in `chadrc.lua`)
- **Theme Toggle**: Between `one_light` and `onedark`
- **Customization**: Modify `base46` settings in `chadrc.lua`

## Troubleshooting & Maintenance

### Common Issues
1. **LSP not starting**: Ensure LSP servers are installed globally
2. **Formatting not working**: Check if formatters (prettier, stylua) are installed
3. **Plugin errors**: Run `:Lazy debug` to see plugin loading issues
4. **Performance issues**: Check for large files (>100KB) disabling treesitter

### Maintenance Tasks
- **Regular Updates**: Run `:Lazy update` weekly
- **Clean Installation**: Delete `~/.local/share/nvim/lazy/` and restart for clean install
- **Backup Configuration**: Backup `~/.config/nvim/` before major changes
- **Check Health**: Run `:checkhealth` for system diagnostics

### Debugging Tools
- **LSP Logs**: `:LspLog` to view LSP server logs
- **Plugin Status**: `:Lazy` to manage and debug plugins
- **Diagnostics**: `:Telescope diagnostics` to view all diagnostics
- **Keymaps**: `:Telescope keymaps` to search key mappings

## Performance Considerations
- **Large Files**: Treesitter highlighting disabled for files >100KB
- **Lazy Loading**: Most plugins load on-demand based on events
- **Incremental Parsing**: Treesitter uses incremental parsing for efficiency
- **Debounced Updates**: LSP updates debounced to prevent performance issues

## Dependencies & Requirements

### System Requirements
- **Neovim**: >= 0.8.0
- **Node.js**: For JavaScript/TypeScript LSP and formatters
- **Python**: For Python LSP and formatters
- **Rust**: For Rust LSP and formatters

### External Tools
- **Git**: Required for plugin management
- **Lazygit**: Optional but recommended for git operations
- **Prettier**: Required for JavaScript/TypeScript/CSS formatting
- **StyLua**: Required for Lua formatting

## Future Development & Roadmap

### Potential Enhancements
1. **Additional LSP Support**: More language servers as needed
2. **Debugger Integration**: nvim-dap for debugging support
3. **Test Runner Integration**: Test execution within Neovim
4. **Enhanced UI**: More theme options and UI customizations

### Contribution Guidelines
1. Follow existing code style and patterns
2. Test changes thoroughly before committing
3. Update documentation when adding new features
4. Consider backward compatibility for existing users

## Emergency Contacts & Resources
- **Original Repository**: https://github.com/itsuki0927/SkCode
- **Base Configuration**: NvChad (https://github.com/NvChad/NvChad)
- **Plugin Manager**: Lazy.nvim (https://github.com/folke/lazy.nvim)
- **LSP Configuration**: nvim-lspconfig (https://github.com/neovim/nvim-lspconfig)

---

*This document provides comprehensive guidance for maintaining and developing the SkCode Neovim configuration. Regular updates to this document are recommended as the configuration evolves.*
