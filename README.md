# SkCode

一个还不错的前端开发个人 Nvim 配置。

## 环境

1. [neovim >= 0.8](https://github.com/neovim/neovim): 必须
2. [lazygit](https://github.com/jesseduffield/lazygit): 可选

## 安装

```bash
git clone https://github.com/itsuki0927/SkCode ~/.config/nvim
nvim
:Lazy
```

## 效果

### 首页

![nvim-alpha](https://static.itsuki.cn/article/nvim-alpha.png)

### 文件树

![nvim-tree](https://static.itsuki.cn/article/skcode/nvim-tree.png)

### 自动完成

![nvim-cmp](https://static.itsuki.cn/article/skcode/nvim-cmp.png)

### lsp

![nvim-lsp](https://static.itsuki.cn/article/skcode/nvim-lsp.png)

#### Code Actions

![nvim-code-actions](https://static.itsuki.cn/article/skcode/nvim-code-actions.png)

#### 重命名

![nvim-code-renamer](https://static.itsuki.cn/article/skcode/nvim-code-renamer.png)

### 模糊搜索

![nvim-telescope](https://static.itsuki.cn/article/nvim-telescope.png)

### Git Signs

![Git Signs](https://static.itsuki.cn/article/skcode/nvim-gitsigns.png)

### Git Blame

![Git Blame](https://static.itsuki.cn/article/skcode/nvim-git-blame.png)

### Todo 高亮

![todo-highlight](https://static.itsuki.cn/article/todo-highlight.png)

### indent-blankline

![indent-blankline](https://static.itsuki.cn/article/indent-line.png)

### 弹窗 + lazygit

![nvim-floatrem](https://static.itsuki.cn/article/nvim-floatrem.png)

## 如何实现像上面图片中的样式：

1. 使用的终端是 kitty + zsh（一开始使用过 iterm2，但是太卡了，感觉不是很流畅）。
2. 终端使用字体是 IBMPlex，可以[在这里](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IBMPlexMono)下载。
3. 默认配置是前端开发基本配置（你也可以自己魔改）。
4. 如果 cmp 的图标不生效，可以看看这个[Issue](https://github.com/itsuki0927/SkCode/issues/8)

### 安装 Lsp 服务

因为会需要各种各样的 lsp，在 VsCode 中内置了这些 Lsp，但是在 Nvim 中你需要自己独立去安装。

```javascript
// 默认的Lsp配置：在文件default_config.lua中
const lsp = {
  // 默认会启动的Lsp
  tsserver: true, // typescript
  cssls: true, // css
  cssmodules_ls: true, // css module
  jsonls: true, // json
  html: true, // html
  eslint: true, // eslint
  sumneko_lua: true, // lua
  tailwindcss: true, // tailwindcss

  // 不会启动的Lsp
  emmet_ls: false, // emmet
  marksman: false, // markdown
  rust_analyzer: false, // rust
  volar: false, // vue3
  vuels: false, // vue2
};
```

所以需要安装上面值为 true 的 Lsp 服务，设置为 false 表示不启用该 Lsp，可以自己去动态的设置某一个 Lsp 的开启和关闭，这取决于你。

所以我们需要安装上面的 Lsp 的服务

> 前端 Lsp 服务一般是 npm、yarn、pnpm 进行安装，这里我会展示 yarn 进行安装，至于 npm 和 pnpm 如何全局安装欢迎谷歌。

| Lsp 服务                    | 描述                       | yarn 安装                                               |
| --------------------------- | -------------------------- | ------------------------------------------------------- |
| cssls、html、jsonls、eslint | 前端常用四件套             | `yarn global add vscode-langservers-extracted`          |
| tsserver                    | typescript                 | `yarn global add typescript typescript-language-server` |
| tailwindcss                 | tailwindcss                | `yarn global add @tailwindcss/language-server`          |
| cssmodules_ls               | css module                 | `yarn global add cssmodules-language-server`            |
| volar                       | Vue3（设置`volar = true`） | `yarn global add @volar/vue-language-server`            |
| vuels                       | Vue2（设置`vuels = true`） | `yarn global add vls`                                   |

关于如何安装其他的 Lsp，可以查看[这个文档](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)，输入你想安装的语言就可以了。

### 安装格式化

格式化我是使用的`Prettier`这个工具，如果你需要这个格式化工具只需要使用以下命令安装即可:

```shell
- npm: `npm i -g prettier`
- yarn: `yarn global add prettier`
- pnpm: `pnpm global add prettier`
```

默认设置的保存自动格式化，你也可以禁用掉这个行为。

> 如果你还想格式化 lua 语言，可以添加`stylua`具体安装办法[在这里](https://github.com/JohnnyMorganz/StyLua)。

> 如果你还想安装其他语言的格式化，可以在这里找到[更多资料](https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes)，进行相对应的配置即可。

## 配置

### 键位配置

键位配置可以参看键位配置文件: [mappings](https://github.com/itsuki0927/SkCode/blob/main/lua/core/mappings.lua)，或者查看对应插件的配置，它们有提供默认的键位配置。

你也可以使用`<space>sk`来查看/搜索键位配置。

## 自定义

### 添加 LSP

在添加 Lsp 服务之前, **请确保你安装了 Lsp 服务在本地, 具体可以查看[lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)**. 其次在`plugins/lsp/install.lua`进行添加.

#### 直接安装的 Lsp

如果是直接安装的 Lsp, 只需要在`core/default_config.lsp`中添加即可.

比如说需要添加一个 python 的语言服务器。

第一步：安装 python 的 lsp

[在这里](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)找到 python 的 Lsp 服务，我这边找到 python 的 Lsp 是`pyright`。

所以在[pyright 的 README](https://github.com/microsoft/pyright)中找到安装方法，可以看到这里的安装命令是`pip install pyright`。

第二步：在 nvim 配置开启 python 的 lsp。

```lua
-- core/default_config.lua
M.lsp = {
  servers  = {
    -- 添加 pyright
    pyright = true,
    -- 你可以使用false, 禁用某个lsp
    tailwindcss = false,
  }
}
```

这样子你就安装好一个 python 的语言服务器，其他语言类似。

#### 需要传入参数的 Lsp

如果需要对 Lsp 服务传入参数, 上面两步的基础上添加两步。

1. 在 core/lsp/providers 文件夹下新建一个 xxx.lua。
2. 查看 core/lsp/install.lua 的 `install_lsp` 函数。

```lua
local install_lsp = function(lspconfig)
  local opts
  for server, enable in pairs(servers) do
    if enable then
      ------------- 在这里新添加一个if判断 ---------------
      if server == '新添加的 Lsp名称' then
        opts = skcode.merge(default_opts, require('core.lsp.providers.新添加的 Lsp文件'))
      ----------------------------------------------------
      else
        opts = default_opts
      end

      lspconfig[server].setup(opts)
    end
  end
end
```

这里我就不做演示了，可以看看 providers 下的文件和`install_lsp`函数就明白了。

### 添加插件

具体可以看看[lazy.nvim 的 README](https://github.com/folke/lazy.nvim)就可以知道如何添加插件了。

### 功能插件

- Git: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
- 注释: [Comment.nvim](https://github.com/numToStr/Comment.nvim).
- 文件树: [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua).
- 启动页: [alpha-nvim](https://github.com/goolord/alpha-nvim).
- 包管理器: [lazy.nvim](https://github.com/folke/lazy.nvim)..
- Lsp 配置: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- 自动完成: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
- 模糊搜索: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- 弹窗: [vim-floatrem.nvim](https://github.com/voldikss/vim-floaterm).
- 自动补全括号: [nvim-autopairs](https://github.com/windwp/nvim-autopairs).
- 提供格式化、诊断: [formatter.nvim](https://github.com/mhartington/formatter.nvim).
- 管理 tabs、buffers: [bufferline.nvim](https://github.com/akinsho/bufferline.nvim).
- 调用函数显示函数签名: [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim).
- 几个常用的文件快速跳转: [harpoon.nvim](https://github.com/ThePrimeagen/harpoon).

### UI 插件

- 主题: [base64](https://github.com/itsuki0927/base64.lua).
- 图标:[nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons).
- 缩进线: [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim).
- 状态栏: [feline.nvim](https://github.com/feline-nvim/feline.nvim).
- Todo 高亮: [todo-comments.nvim](https://github.com/folke/todo-comments.nvim).
- 语法高亮: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
- 颜色高亮:[nvim-colorizer](https://github.com/NvChad/nvim-colorizer.lua).

## 为什么不用 vscode ?

1. 当习惯了 vim 之后, 双手可以不用离开键盘去打字真的很舒服, 它不会打乱你的思考逻辑, 特别是如果你有自己的一套工作流, 它的速度会想象不到的快.

2. vscode + nvim, 我之前尝试过, 但是这样子你得去尝试解决 vscode 键位冲突, 还得去学习 vscode 额外的配置等等一系列操作, 这个成本是很高的.

## 感谢

1. [LunarVim](https://github.com/LunarVim/LunarVim)
2. [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch)
3. [VapourNvim](https://github.com/VapourNvim/VapourNvim)
4. [NvChad](https://github.com/NvChad/NvChad)
5. [Neovim IDE from Scratch with ChrisAtMachine](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ&index=1)
6. [Neovim Lua From Scratch with Neil Sabde](https://www.youtube.com/watch?v=r3NOB8UjIPc)

### 一些小想法

从 20 年开始接触 vim, 一开始可能是为了装逼, 后面发现 vim 还是挺不错的, 特别是用熟了之后形成了自己的工作流, 要方便很多. 我没有学过 vimscript, 基本上 所有的插件都是看的官方文档或者别人的配置文件, 所以就属于直接拿代码的状态, 没有去好好去研究过, 后面接触到了可以使用 lua 来配置, 寒假在家没事做, 于是学习了一下 lua 来配置 vim , 我一直认为最好的学习是写代码、借鉴优秀的代码 .

最开始看的 lua 配置的 vim 是[LunarVim](https://github.com/LunarVim/LunarVim), 当时才不到几百 star, 转眼间现在已经 7k star 了, 我的 vim 配置是从这个库的作者[ChristianChiarulli](https://github.com/ChristianChiarulli)他身上学到的, 然后最近他开了一个新的仓库, 讲解就是如何使用 lua 一步步配置 vim: [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch), 所以一开始我在不断的做加法, 然后在学习他的配置时又看到了另外一个库[VapourNvim](https://github.com/VapourNvim/VapourNvim), 这个更加的简单易上手, 他们都有配套的视频, 这是我觉得最棒的地方, 就在这样子的一点点看视频+看官方文档+看他们配置之后, 我的 SkCode 有了第一版.

而最终 SkCode 是根据 [NvChad](https://github.com/NvChad/NvChad)(它是一个优秀且支持拓展的 nvim lua 配置)"抄袭"而来, 你可以理解成 SkCode 它的代码都来源于这个仓库. SkCode 的代码结构是来源于 NvChad, 但是 SkCode 也绝不是简简单单的抄代码, 我希望 nvim 的配置更加简单, 所以将一些代码进行优化, 删除不需要的功能, 添加人性化的键位绑定, 以及提供前端的 Lsp 配置, 于是就出现了 SkCode.
