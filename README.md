# SkCode

## 前言

从 20 年开始接触 vim, 一开始可能是为了装逼, 后面发现 vim 还是挺不错的, 特别是用熟了之后形成了自己的工作流, 要方便很多. 我没有学过 vimscript, 基本上 所有的插件都是看的官方文档或者别人的配置文件, 所以就属于直接拿代码的状态, 没有去好好去研究过, 后面接触到了可以使用 lua 来配置, 寒假在家没事做, 于是学习了一下 lua 来配置 vim , 我一直认为最好的学习是写代码、借鉴优秀的代码 .

最开始看的 lua 配置 vim 是[LunarVim](https://github.com/LunarVim/LunarVim), 当时才不到几百 star, 转眼间现在已经 7k star 了, 我的 vim 配置是从这个库的作者[ChristianChiarulli](https://github.com/ChristianChiarulli)他身上学到的, 然后最近他开了一个新的仓库, 讲解就是如何使用 lua 一步步配置 vim: [Neovim-from-scratch](https://github.com/LunarVim/Neovim-from-scratch), 所以一开始我在不断的做加法, 然后在学习他的配置时又看到了另外一个库[VapourNvim](https://github.com/VapourNvim/VapourNvim), 这个更加的简单易上手, 他们都有配套的视频, 这是我觉得最棒的地方, 就在这样子的一点点看视频+看官方文档+看他们配置之后, 我的 SkCode 有了第一版.

而最终 SkCode 是根据 [NvChad](https://github.com/NvChad/NvChad)(它是一个优秀且非常简约的 nvim lua 配置)"抄袭"而来, 你可以理解成 SkCode 它的代码都来源于这个仓库. SkCode 的代码结构是来源于 NvChad, 但是 SkCode 也绝不是简简单单的抄代码, 因为有了前面这两个库的代码积累, 将一些代码进行优化, 删除不需要的功能, 添加人性化的键位绑定, 所以就出现了 SkCode.

## 效果

### 主题

![nvim-theme](https://static.itsuki.cn/article/nvim-theme.png)

### 首页

![nvim-alpha](https://static.itsuki.cn/article/nvim-alpha.png)

### 自动完成

![nvim-cmp](https://static.itsuki.cn/article/nvim-cmp.png)

### lsp

![nvim-lsp](https://static.itsuki.cn/article/nvim-lsp.png)

### 文件树

![nvim-tree](https://static.itsuki.cn/article/nvim-tree.png)

### 模糊搜索

![nvim-telescope](https://static.itsuki.cn/article/nvim-telescope.png)

## 环境

1. [neovim](https://github.com/neovim/neovim)
2. [lazygit](https://github.com/jesseduffield/lazygit)

## 安装

```bash
git clone https://github.com/itsuki0927/SkCode ~/.config/nvim
nvim +PackerSync
```

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

