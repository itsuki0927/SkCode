# SkCode

## 前言

从 20 年开始接触 vim, 一开始可能是为了装逼, 后面发现 vim 还是挺不错的, 特别是用熟了之后形成了自己的工作流, 要方便很多. 我没有学过 vimscript, 基本上 所有的插件都是看的官方文档或者别人的配置文件, 所以就属于直接拿代码的状态, 没有去好好去研究过, 后面接触到了可以使用 lua 来配置, 寒假在家没事做, 于是学习了一下 lua 来配置 vim , 我一直认为最好的学习是写代码、借鉴优秀的代码 .

最开始看的 lua 配置的 vim 是[LunarVim](https://github.com/LunarVim/LunarVim), 当时才不到几百 star, 转眼间现在已经 7k star 了, 我的 vim 配置是从这个库的作者[ChristianChiarulli](https://github.com/ChristianChiarulli)他身上学到的, 然后最近他开了一个新的仓库, 讲解就是如何使用 lua 一步步配置 vim: [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch), 所以一开始我在不断的做加法, 然后在学习他的配置时又看到了另外一个库[VapourNvim](https://github.com/VapourNvim/VapourNvim), 这个更加的简单易上手, 他们都有配套的视频, 这是我觉得最棒的地方, 就在这样子的一点点看视频+看官方文档+看他们配置之后, 我的 SkCode 有了第一版.

而最终 SkCode 是根据 [NvChad](https://github.com/NvChad/NvChad)(它是一个优秀且支持拓展的 nvim lua 配置)"抄袭"而来, 你可以理解成 SkCode 它的代码都来源于这个仓库. SkCode 的代码结构是来源于 NvChad, 但是 SkCode 也绝不是简简单单的抄代码, 我希望 vim 的配置更加简单, 所以将一些代码进行优化, 删除不需要的功能, 添加人性化的键位绑定, 以及提供前端的 Lsp 配置, 于是就出现了 SkCode.

## 特点

1. 开箱即用
2. 简单快速
3. 风格统一

### 开箱即用

SkCode 提供了前端(React、Vue)等基本的开发配置, 保证了在前端方面(自己是前端, 懒得提供其他的了)的开箱即用, 如果你想使用其他语言, 只需要在 [Lsp 文件](https://github.com/itsuki0927/SkCode/blob/main/lua/plugins/configs/lsp/install.lua) 服务即可.

### 简单快速

SkCode 借鉴了 NvChad 的 Packer 配置, 通过懒加载的方式加载所有插件, 因此它有很快的启动速度.

### 风格统一

NvChad 提供了风格统一的主题, SkCode 在此基础上进行了扩展, 在 Code Actions、Code renamer、Telescope 等插件上都进行了配置, 以达到相同的 UI 显示效果, 具体看下面效果图.

## 环境

1. [neovim >= 0.6](https://github.com/neovim/neovim): 必须
2. [lazygit](https://github.com/jesseduffield/lazygit): 可选

## 安装

```bash
git clone https://github.com/itsuki0927/SkCode ~/.config/nvim
nvim +PackerSync
```

## 效果

### 首页

![nvim-alpha](https://static.itsuki.cn/article/nvim-alpha.png)

### 文件树

![nvim-tree](https://static.itsuki.cn/article/nvim-tree.png)

### 自动完成

![nvim-cmp](https://static.itsuki.cn/article/nvim-cmp.png)

### lsp

![nvim-lsp](https://static.itsuki.cn/article/nvim-lsp.png)

#### Code Actions

![nvim-code-actions](https://static.itsuki.cn/article/nvim-code-actions.png)

#### 重命名

![nvim-code-renamer](https://static.itsuki.cn/article/nvim-code-renamer.png)

### 模糊搜索

![nvim-telescope](https://static.itsuki.cn/article/nvim-telescope.png)

### Todo 高亮

![todo-highlight](https://static.itsuki.cn/article/todo-highlight.png)

### indent-blankline

![indent-blankline](https://static.itsuki.cn/article/indent-line.png)

### 折叠

![nvim-fold](https://static.itsuki.cn/article/nvim-fold.png)

### 弹窗 + lazygit

![nvim-floatrem](https://static.itsuki.cn/article/nvim-floatrem.png)

## 配置

### 键位配置

SkCode 提供了默认的键位配置. 以下是常用的键位配置, 更多的键位配置可以参看键位配置文件: [mappings](https://github.com/itsuki0927/SkCode/blob/main/lua/core/mappings.lua),
或者查看对应插件的配置, 它们有提供默认的键位配置.

#### 常用键位

| 键位           | 含义            |
| -------------- | --------------- |
| `<ctrl>h`      | 聚焦到左窗口    |
| `<ctrl>l`      | 聚焦到右窗口    |
| `<ctrl>k`      | 聚焦到上窗口    |
| `<ctrl>j`      | 聚焦到下窗口    |
| `<leader>x`    | 关闭当前 Buffer |
| `<leader>w`    | 保存当前 Buffer |
| `<leader>q`    | 退出当前 Buffer |
| `<leader><CR>` | 取消高亮        |
| `jk`           | Esc             |

#### Renamer

| 键位         | 含义       |
| ------------ | ---------- |
| `<leader>rn` | 变量重命名 |

#### bufferline

| 键位      | 含义          |
| --------- | ------------- |
| `<tab>`   | 下一个 Buffer |
| `<S-tab>` | 上一个 Buffer |

#### Comment

| 键位        | 含义     |
| ----------- | -------- |
| `<leader>/` | 切换注释 |
| `gcc`       | 切换注释 |

#### todo-comments

| 键位         | 含义      |
| ------------ | --------- |
| `<leader>tl` | todo 列表 |
| `<leader>ts` | todo 搜索 |

#### NvimTree

| 键位        | 含义           |
| ----------- | -------------- |
| `<leader>e` | 切换 NvimTree  |
| `a`         | 创建文件       |
| `d`         | 删除文件       |
| `h`         | 折叠当前节点树 |
| `l`         | 编辑当前文件   |

#### [Telescope](https://github.com/itsuki0927/SkCode/blob/main/lua/plugins/configs/telescope.lua)

| 键位         | 含义                  |
| ------------ | --------------------- |
| `<leader>f`  | 搜索文件              |
| `<leader>F`  | 搜索文件内容          |
| `<leader>sb` | 搜索当前打开的 Buffer |
| `<leader>sk` | 搜索设置的 keymaps    |
| `<leader>sc` | 搜索设置的 commands   |

插入模式:

| 键位       | 含义             |
| ---------- | ---------------- |
| `<ctrl>j`  | 移动到下一项     |
| `<ctrl>k`  | 移动到上一项     |
| `<esc>`    | 关闭 Telescope   |
| `<ctrl-[>` | 关闭 Telescope   |
| `<cr>`     | 打开文件         |
| `<ctrl-x>` | 向下分屏打开文件 |
| `<ctrl-v>` | 向右分屏打开文件 |
| `<M-p>`    | 切换文件预览     |

正常模式:

| 键位 | 含义           |
| ---- | -------------- |
| `j`  | 移动到下一项   |
| `k`  | 移动到上一项   |
| `gg` | 移动到第一项   |
| `G`  | 移动到最后一项 |

#### Lsp

| 键位         | 含义             |
| ------------ | ---------------- |
| `gD`         | 查看类型定义     |
| `gd`         | 查看定义         |
| `K`          | hover            |
| `gi`         | 查看实现         |
| `gk`         | 查看当前文档     |
| `gr`         | 查看引用         |
| `gl`         | 显示当前行的诊断 |
| `[d`         | 上一个诊断       |
| `]d`         | 下一个诊断       |
| `<leader>ca` | Code Actions     |

#### Gitsign

| 键位         | 含义              |
| ------------ | ----------------- |
| `]c`         | 下一个 hunk       |
| `[c`         | 上一个 hunk       |
| `<leader>hr` | reset hunk        |
| `<leader>hR` | reset buffer hunk |
| `<leader>hs` | stage hunk        |
| `<leader>hS` | reset buffer hunk |
| `<leader>hu` | undo stage hunk   |
| `<leader>hp` | preview hunk      |
| `<leader>hb` | blame line        |
| `<leader>tb` | toggle blame line |
| `<leader>hd` | diff              |

#### vim-floatrem

| 键位         | 含义                   |
| ------------ | ---------------------- |
| `<ctrl-\>`   | 切换弹窗               |
| `<leader>tg` | 打开 lazygit(需要安装) |
| `<leader>tr` | 打开 ranger (需要安装) |

## 目录结构

```sh
├── README.md                                    # 文档
├── init.lua                                     # 入口文件
├── lua
│   ├── colors
│   │   ├── highlights.lua                       # 高亮
│   │   └── init.lua                             # 主题
│   ├── core                                     # 核心功能文件夹
│   │   ├── autocmds.lua                         # 自动命令
│   │   ├── default_config.lua                   # 默认配置
│   │   ├── mappings.lua                         # 键位配置
│   │   ├── options.lua                          # vim 选项配置
│   │   └── utils.lua                            # 工具函数
│   └── plugin-configs                           # 插件配置文件夹
│       ├── configs                              # 插件配置
│       │   ├── icons.lua                        # 图标
│       │   ├── lsp                              # LSP 配置
│       │   │   ├── init.lua                     # LSP 入口
│       │   │   ├── install.lua                  # LSP 安装
│       │   │   ├── opts.lua                     # LSP 参数
│       │   │   └── setup.lua                    # LSP 安装前的配置
│       │   ├── others.lua                       # 其他插件配置
│       │   └── xxxx.lua                         # 某一个插件配置
│       ├── init.lua                             # 插件列表
│       └── packerInit.lua                       # Packer插件初始化
```

## 自定义

### 添加 LSP

在添加 Lsp 服务之前, **请确保你安装了 Lsp 服务在本地, 具体可以查看[lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)**. 其次在`plugins/lsp/install.lua`进行添加.

1. 如果是直接安装的 Lsp, 只需要在`core/default_config.lsp`中添加即可.
2. 如果需要对 Lsp 服务传入参数, 需要在第一步基础上, 在`core/lsp/providers`中添加配置, 然后在`core/lsp/install.lua`添加判断即可进行添加.

```lua
-- 直接安装的 lsp 示例
-- core/default_config.lua
M.lsp = {
  servers  = {
    -- 添加
    newLsp = true,
    -- 你可以使用false, 禁用某个lsp
    tailwindcss = false,
  }
}

-- 需要传入参数的Lsp
-- 查看core/lsp/provider/xxx.lua
-- 查看core/lsp/install.lua的install_lsp函数
```

### 自定义添加插件

1. 在`core/plugin/init.lua`中添加插件.
3. 在`core/mappings.lua`添加插件快捷键(如果需要).
4. 在`plugin-configs/插件名.lua`添加插件配置.

```lua
-- plugin-configs/插件名.lua

-- /core/plugin/init.lua
use({
  '插件名',
  config = function()
    -- 添加插件的配置
    -- require('plugin-configs.插件名.lua')
  end,
  setup = function()
    -- 插件的前置函数, 一般用来添加键位
    -- require('core.mappings').插件名()
  end,
  -- 其他配置
})

-- core/mappings.lua
M.'插件名' = function()
-- 添加键位
end
```

## 插件列表

你可以在`core/default_config.lua`中进行禁用.

```lua
M.plugins = {
  status = {
    nvimtree = false -- 禁用nvimtree
  }
}
```

### 功能插件

- Git: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
- 注释: [Comment.nvim](https://github.com/numToStr/Comment.nvim).
- 文件树: [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua).
- 启动页: [alpha-nvim](https://github.com/goolord/alpha-nvim).
- 重命名: [renamer.nvim](https://github.com/filipdutescu/renamer.nvim).
- 包管理器: [packer.nvim](https://github.com/wbthomason/packer.nvim)..
- Lsp 配置: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- 自动完成: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
- 模糊搜索: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
- 代码片段:[LuaSnip](https://github.com/L3MON4D3/LuaSnip).
- 弹窗: [vim-floatrem.nvim](https://github.com/voldikss/vim-floaterm).
- 自动补全括号: [nvim-autopairs](https://github.com/windwp/nvim-autopairs).
- 提供格式化、诊断: [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim).
- 管理 tabs、buffers: [bufferline.nvim](https://github.com/akinsho/bufferline.nvim).
- 调用函数显示函数签名: [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim).

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
