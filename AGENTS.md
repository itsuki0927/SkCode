# AGENTS.md - SkCode Neovim Configuration

## Build/Lint/Test Commands
- **Format Lua files**: `stylua --search-parent-directories --indent-type Spaces <file>`
- **Format JS/TS/CSS/HTML**: `prettier` or `prettierd` (auto-format on save)
- **LSP diagnostics**: Configured for TypeScript, Lua, CSS, ESLint, etc.
- **No test framework** - this is a Neovim configuration repository

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
- **TypeScript**: tsserver with organize imports command
- **Lua**: lua_ls with workspace library configuration
- **CSS**: cssls with validation disabled
- **ESLint**: Auto-fix on save enabled
- **TailwindCSS**: Supports multiple filetypes

## Key Conventions
- Files auto-format on save via conform.nvim
- Use `vim.opt` for Neovim options
- Leader key is space (`<space>`)
- Local leader is backslash (`\`)
- Follow existing patterns in `lua/config/` directory