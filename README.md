# My Neovim Configuration

一套以 [LazyVim](https://www.lazyvim.org/) 为基础、面向 Linux 终端开发环境的个人 Neovim 配置。

这份 README 同时承担：

- 新机器从零安装手册；
- 当前配置和行为说明；
- 高频、易忘快捷键速查；
- 缩进、格式化、LSP 和插件问题排查指南；
- 修改配置后的验证清单。

当前配置已在 **Neovim 0.12.1** 上验证。`<leader>` 和 `<localleader>` 都设置为空格键。

## 目录

- [主要特性](#主要特性)
- [新机器安装](#新机器安装)
- [首次启动与健康检查](#首次启动与健康检查)
- [目录结构](#目录结构)
- [当前行为约定](#当前行为约定)
- [快捷键速查](#快捷键速查)
- [容易混淆的操作](#容易混淆的操作)
- [常用命令](#常用命令)
- [故障排查](#故障排查)
- [测试与验证](#测试与验证)
- [更新与维护](#更新与维护)

## 主要特性

- 使用 LazyVim 和 lazy.nvim 管理基础配置与插件；
- 使用 VSCode 风格主题，并针对 Neo-tree 调整配色；
- 使用 Snacks Picker 搜索文件、文本、快捷键和诊断；
- 使用 Blink 提供补全、函数签名和 Super Tab 体验；
- 使用 clangd 提供 C/C++ 跳转、引用、诊断和格式化能力；
- 使用 lua_ls 和 StyLua 支持 Lua 开发；
- 默认使用 4 空格缩进，不插入真实 Tab 字符；
- 支持可视模式下使用 `Tab` / `Shift-Tab` 调整多行缩进；
- 支持使用 `=` 按语言语法重新计算缩进；
- 默认关闭保存时自动格式化，格式化操作由用户主动触发；
- 自动恢复最近一次 Neovim 会话；
- 显示 Git 当前行 blame，并支持 Gitsigns；
- 右侧自动显示 mini.map 代码缩略图；
- 支持 Markdown 实时渲染；
- 内置右侧项目终端和当前目录终端。

## 新机器安装

### 1. 安装基础依赖

LazyVim 当前的核心要求包括：

- Neovim `>= 0.11.2`，并启用 LuaJIT；
- Git `>= 2.19.0`；
- `curl`；
- C 编译器和 `tree-sitter-cli`，用于 nvim-treesitter；
- Nerd Font v3 或更高版本，用于正确显示图标，推荐但非强制；
- `ripgrep`，用于全文搜索；
- `fd`，用于文件搜索；
- `fzf`、`lazygit` 为可选工具。

官方要求以 [LazyVim Getting Started](https://www.lazyvim.org/) 为准。

Ubuntu/Debian 可以先安装常用依赖：

```bash
sudo apt update
sudo apt install git curl unzip build-essential ripgrep fd-find
```

部分发行版把 `fd` 命令安装成 `fdfind`。如果文件搜索无法使用，请确认系统中存在 `fd` 或按发行版说明创建对应命令。

安装完成后检查版本：

```bash
nvim --version
git --version
rg --version
fd --version
```

如果系统软件源中的 Neovim 版本过旧，请按照 [Neovim 官方安装文档](https://github.com/neovim/neovim/blob/master/INSTALL.md) 安装较新的稳定版本。

### 2. 备份旧配置

如果新机器上已经存在 Neovim 配置，先备份再克隆。只执行实际存在的目录：

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

其中只有 `~/.config/nvim` 是必须备份的配置目录；另外三个目录保存插件、状态和缓存，备份它们有助于获得完全干净的首次启动环境。

不要在未确认目标路径时使用递归删除命令。

### 3. 克隆配置

```bash
git clone https://github.com/Yang-xinzhe/my-nvim-config.git ~/.config/nvim
```

### 4. 启动 Neovim

```bash
nvim
```

首次启动时 lazy.nvim 会自动安装 LazyVim 和插件。等待安装完成后重启一次 Neovim。

## 首次启动与健康检查

进入 Neovim 后依次执行：

```vim
:Lazy
:LazyHealth
:checkhealth
:Mason
```

用途：

- `:Lazy`：查看插件安装、更新和加载状态；
- `:LazyHealth`：加载所有插件并检查 LazyVim 环境；
- `:checkhealth`：运行 Neovim 和各插件的健康检查；
- `:Mason`：查看 LSP、formatter、linter 和调试工具。

如果主要开发 C/C++ 和 Lua，在 `:Mason` 界面中搜索并安装或确认以下工具可用：

```text
clangd
stylua
lua-language-server
```

在 Mason 界面中把光标移动到工具上，按 `i` 安装；按 `g?` 查看完整帮助。

也可以使用系统安装的 clangd：

```bash
clangd --version
```

检查当前文件实际使用的 formatter：

```vim
:ConformInfo
```

## 目录结构

```text
.
├── init.lua                    # 入口：先加载本地 options，再启动 LazyVim
├── lazy-lock.json              # 插件版本锁定文件
├── lazyvim.json                # LazyVim extras 和版本信息
├── stylua.toml                 # 本仓库 Lua 格式化策略
├── lua/
│   ├── config/
│   │   ├── autocmds.lua        # 自动命令、缓冲区选项、终端与 LSP 映射
│   │   ├── keymaps.lua         # 自定义全局快捷键
│   │   ├── lazy.lua            # lazy.nvim 引导与插件导入
│   │   └── options.lua         # 全局选项和 4 空格默认策略
│   └── plugins/
│       ├── blink.lua           # 补全和 Super Tab
│       ├── colorscheme.lua     # VSCode 主题和 Neo-tree 配色
│       ├── formatting.lua      # Conform、StyLua 和 Lua 格式化设置
│       ├── gitsigns.lua        # 当前行 Git blame
│       ├── lsp.lua             # clangd 设置
│       ├── markdown.lua        # Markdown 渲染
│       ├── minimap.lua         # 右侧代码缩略图
│       ├── neotree.lua         # 文件树过滤规则
│       ├── persistence.lua     # 会话自动恢复
│       ├── snacks.lua          # 终端行为
│       ├── treesitter*.lua     # Treesitter 与代码上下文
│       ├── ui.lua              # Dashboard、Bufferline 和 Lualine
│       └── which-key.lua       # 快捷键提示
└── tests/
    ├── indentation_spec.lua    # 4 空格和 C if 块缩进回归测试
    └── keymaps_spec.lua        # Tab / Shift-Tab 多行缩进回归测试
```

## 当前行为约定

### Leader 键

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
```

文档中的 `Space` 表示空格键，例如：

```text
Space s k
```

表示依次按空格、`s`、`k`，不需要同时按下。

### 缩进

普通代码缓冲区统一使用：

```text
tabstop=4
shiftwidth=4
softtabstop=4
expandtab
```

含义：

- 一个 Tab 显示为 4 列；
- 每一级自动缩进移动 4 列；
- 插入模式按 Tab 时按 4 列处理；
- 实际写入空格，不写入 `\t` 字符。

Dashboard、终端、文件树、Mason、Lazy 和 quickfix 等特殊缓冲区不会被强制应用代码缩进设置。

### 格式化

全局和本仓库缓冲区默认关闭保存时自动格式化：

```lua
vim.g.autoformat = false
```

需要格式化时主动按 `Space c f`。

Lua 文件使用本仓库的 `stylua.toml`：

```toml
indent_type = "Spaces"
indent_width = 4
column_width = 120
```

C/C++ 的 `Space c f` 由 clangd/clang-format 决定，优先读取项目的 `.clang-format`。如果项目没有 `.clang-format`，clangd 可能使用两空格的 LLVM 默认风格；这与 Neovim 的 `shiftwidth=4` 是两套独立规则。

### 会话

无文件参数启动 `nvim` 时自动恢复最近一次会话。显式打开文件或从标准输入读取内容时不会自动恢复旧会话。

### 终端

Snacks 终端默认直接进入插入模式。终端中使用 `Ctrl-g` 进入 terminal-normal 模式，避免使用可能会中断 Codex 或其他 TUI 的双 `Esc` 流程。

## 快捷键速查

### 忘记快捷键时

| 按键 | 模式 | 作用 |
|---|---|---|
| `Space` 后等待 | Normal | 打开 WhichKey 分级提示 |
| `Space s k` | Normal | 搜索全部快捷键 |
| `Space ?` | Normal | 查看当前缓冲区快捷键 |
| `Ctrl-w` | Normal | 打开窗口操作 WhichKey 循环菜单 |

最需要记住的“救命键”是：

```text
Space s k
```

打开后输入 `format`、`comment`、`terminal`、`definition` 等英文关键词即可查找对应按键。

### 文件、搜索和缓冲区

| 按键 | 模式 | 作用 |
|---|---|---|
| `Ctrl-p` | Normal | 从项目根目录查找文件 |
| `Space Space` | Normal | 从项目根目录查找文件 |
| `Space s g` | Normal | 从项目根目录全文搜索 |
| `Space /` | Normal | 从项目根目录全文搜索 |
| `Space ,` | Normal | 切换缓冲区 |
| `Shift-h` / `Shift-l` | Normal | 上一个 / 下一个缓冲区 |
| `Space b d` | Normal | 删除当前缓冲区 |
| `Space f r` | Normal | 打开最近文件 |
| `Space f p` | Normal | 选择项目 |
| `Space e` | Normal | 打开项目根目录文件浏览器 |

### 缩进和格式化

| 按键 | 模式 | 作用 |
|---|---|---|
| `Tab` | Visual | 选中行整体向右移动一级，并保留选区 |
| `Shift-Tab` | Visual | 选中行整体向左移动一级，并保留选区 |
| `=` | Visual | 根据语言语法重新计算选中代码缩进 |
| `==` | Normal | 重新计算当前行缩进 |
| `gg=G` | Normal | 重新计算整个文件缩进 |
| `Space c f` | Normal / Visual | 格式化整个文件 / 选区 |

### 注释

| 按键 | 模式 | 作用 |
|---|---|---|
| `gcc` | Normal | 注释或取消注释当前行 |
| `gc` | Visual | 注释或取消注释选中区域 |
| `gc` + motion | Normal | 注释指定范围，例如 `gcap` 注释当前段落 |
| `gco` | Normal | 在当前行下面新增注释行 |
| `gcO` | Normal | 在当前行上面新增注释行 |

多行注释示例：

```text
Vjjgc
```

表示选中当前行及下面两行，然后切换注释状态。

### LSP 与代码导航

下面的映射会在对应语言的 LSP 成功附加到当前代码缓冲区后生效：

| 按键 | 模式 | 作用 |
|---|---|---|
| `gd` | Normal | 跳转到定义 |
| `gD` | Normal | 跳转到声明 |
| `gr` | Normal | 查看引用 |
| `gI` | Normal | 跳转到实现 |
| `gy` | Normal | 跳转到类型定义 |
| `K` | Normal | 显示悬浮信息 |
| `Ctrl-k` | Insert | 显示函数签名帮助 |
| `Space c a` | Normal / Visual | Code Action |
| `Space c r` | Normal | 重命名符号 |
| `Space c l` | Normal | 查看 LSP 信息 |
| `[d` / `]d` | Normal | 上一个 / 下一个诊断 |
| `[e` / `]e` | Normal | 上一个 / 下一个错误 |

### 窗口和终端

| 按键 | 模式 | 作用 |
|---|---|---|
| `Ctrl-h/j/k/l` | Normal | 移动到左 / 下 / 上 / 右窗口 |
| `Ctrl-Left` / `Ctrl-Right` | Normal / Terminal | 减少 / 增加窗口宽度 |
| `Ctrl-Up` / `Ctrl-Down` | Normal / Terminal | 增加 / 减少窗口高度 |
| `Space f v` | Normal | 在右侧打开项目根目录终端 |
| `Space f V` | Normal | 在右侧打开当前工作目录终端 |
| `Ctrl-/` | Normal / Terminal | 打开项目根目录终端 |
| `Ctrl-g` | Terminal | 从终端插入模式进入 terminal-normal 模式 |
| `Enter` / `i` / `a` | Terminal Normal | 回到终端插入模式 |

### Git、界面和 Markdown

| 按键 | 模式 | 作用 |
|---|---|---|
| `Space g s` | Normal | Git 状态 |
| `Space g b` | Normal | 当前行 Git blame |
| `Space g f` | Normal | 当前文件 Git 历史 |
| `Space u B` | Normal | 切换当前行 Git blame |
| `Space u m` | Normal | 切换右侧代码缩略图 |
| `Space u c` | Normal | 切换顶部 sticky code context |
| `Space u t` | Normal | 打开主题选择器 |
| `Alt-v` | Markdown | 切换 Markdown 渲染 |
| `Space m p` | Markdown | 切换 Markdown 渲染 |
| `Ctrl-s` | Normal / Insert / Visual | 保存文件 |

## 容易混淆的操作

### `Tab` 和 `=` 不一样

`Tab` / `Shift-Tab` 只是在现有缩进基础上整体移动，不理解代码结构。

假设当前错误缩进是两个空格：

```c
if (ready) {
  run();
}
```

选中 `run();` 后按 `Tab` 会再增加 4 个空格，可能得到 6 个空格，并不会自动归一化。

选中后按 `=` 会根据 C 语法和 `shiftwidth=4` 重新计算：

```c
if (ready) {
    run();
}
```

记忆方式：

```text
Tab / Shift-Tab = 手动整体移动
=               = 按语法自动对齐
Space c f       = 调用完整 formatter
```

### `=` 和 `Space c f` 不一样

`=` 使用 Neovim 的语言缩进规则，只调整缩进。

`Space c f` 调用 StyLua、clangd 或其他 formatter，可能同时修改：

- 缩进；
- 空格；
- 参数换行；
- 括号布局；
- 引号或其他语言风格。

C/C++ formatter 不一定遵守 Neovim 的 `shiftwidth`。需要统一团队格式时，应在 C/C++ 项目根目录维护 `.clang-format`。

### `expandtab` 不显示数字

检查命令：

```vim
:setlocal tabstop? shiftwidth? softtabstop? expandtab?
```

正确结果类似：

```text
tabstop=4
shiftwidth=4
softtabstop=4
expandtab
```

`expandtab` 是布尔选项；如果看到 `noexpandtab`，说明当前缓冲区会插入真实 Tab 字符。

### `%` 在不同模式下含义不同

- Insert 模式输入 `%`：插入百分号；
- Normal 模式按 `%`：跳转到匹配括号。

输入 C/C++ `printf("%d", value)` 前，确认左下角显示 `-- INSERT --`。

### clangd 的实时报错

clangd 会在输入尚未完成时即时报告语法错误。例如刚输入：

```c
printf("%
```

字符串、格式说明符和括号都还不完整，临时报错属于正常现象。完成整条语句后诊断应自动消失：

```c
printf("%d", value);
```

## 常用命令

| 命令 | 作用 |
|---|---|
| `:Lazy` | 插件管理界面 |
| `:LazyHealth` | LazyVim 健康检查 |
| `:Mason` | LSP / formatter / linter 工具管理 |
| `:ConformInfo` | 查看当前缓冲区 formatter |
| `Space c l` | 查看当前缓冲区和可用 LSP 配置 |
| `:checkhealth` | Neovim 全局健康检查 |
| `:checkhealth vim.lsp` | 检查 Neovim LSP 状态 |
| `:checkhealth nvim-treesitter` | 检查 Treesitter 状态 |
| `:setlocal ...?` | 查看当前缓冲区局部选项 |
| `:verbose map <key>` | 查看按键映射及定义来源 |

示例：

```vim
:verbose xmap <Tab>
:verbose xmap <S-Tab>
:verbose nmap gcc
:verbose nmap <leader>cf
```

## 故障排查

### 忘记快捷键

```text
Space s k
```

搜索英文功能名。也可以按 `Space` 后停顿，逐级查看 WhichKey。

### Tab 或 Shift-Tab 没有缩进多行

确认处于 Visual 模式，并检查映射：

```vim
:verbose xmap <Tab>
:verbose xmap <S-Tab>
```

预期映射：

```text
<Tab>   -> >gv
<S-Tab> -> <gv
```

### 当前代码不是 4 空格

检查：

```vim
:setlocal tabstop? shiftwidth? softtabstop? expandtab?
```

如果选项正确但已有代码仍是两空格，使用：

```text
==      修正当前行
V...=   修正选中区域
gg=G    修正整个文件
```

修改选项不会自动重写文件中已经存在的缩进。

### `Space c f` 把 C/C++ 改成两空格

检查项目根目录是否存在 `.clang-format`。没有配置时 clangd 可能回退到 LLVM 两空格风格。

需要 4 空格时，在具体项目中使用类似配置：

```yaml
---
BasedOnStyle: LLVM
IndentWidth: 4
TabWidth: 4
UseTab: Never
```

项目自身的格式规范优先于本 Neovim 仓库的个人偏好。

### LSP 没有启动

依次检查：

```vim
:checkhealth vim.lsp
:Mason
```

也可以按 `Space c l` 查看当前缓冲区和已配置的 LSP。然后检查项目是否存在构建信息；clangd 通常需要 `compile_commands.json` 才能准确理解复杂 C/C++ 项目。

### 插件安装失败

检查 Git、网络和代理，然后执行：

```vim
:Lazy sync
:LazyHealth
```

如果只是缓存损坏，先退出所有 Neovim 进程，再备份 `~/.local/share/nvim` 后重新启动。不要直接删除未确认的目录。

## 测试与验证

在仓库根目录执行。

### 多行 Tab / Shift-Tab

```bash
XDG_STATE_HOME=/tmp/nvim-keymap-test-state \
XDG_CACHE_HOME=/tmp/nvim-keymap-test-cache \
nvim --headless -l tests/keymaps_spec.lua
```

### 4 空格与 C if 块缩进

```bash
XDG_STATE_HOME=/tmp/nvim-indent-test-state \
XDG_CACHE_HOME=/tmp/nvim-indent-test-cache \
nvim --headless -l tests/indentation_spec.lua
```

### 启动检查

```bash
XDG_STATE_HOME=/tmp/nvim-startup-test-state \
XDG_CACHE_HOME=/tmp/nvim-startup-test-cache \
nvim --headless +qa!
```

### Lua 格式和语法

如果 StyLua 由 Mason 安装：

```bash
~/.local/share/nvim/mason/bin/stylua \
  --check lua/config/autocmds.lua tests/indentation_spec.lua tests/keymaps_spec.lua
```

如果系统提供 `luac`：

```bash
luac -p lua/config/autocmds.lua
luac -p tests/indentation_spec.lua
luac -p tests/keymaps_spec.lua
```

检查 Git diff 中的空白错误：

```bash
git diff --check
```

## 更新与维护

### 拉取本仓库配置

先确认没有未提交改动：

```bash
cd ~/.config/nvim
git status
git pull --ff-only
```

然后进入 Neovim：

```vim
:Lazy sync
:LazyHealth
```

### 更新插件

在 `:Lazy` 中执行更新或运行：

```vim
:Lazy sync
```

更新插件后 `lazy-lock.json` 会发生变化。这个文件用于锁定插件提交，使新机器尽量恢复到同一组插件版本；应在确认插件更新和健康检查通过后单独审查并提交。

### 修改配置后的建议流程

1. 查看 `git diff`，确认只包含预期文件；
2. 运行本 README 中的回归测试；
3. 运行 `:LazyHealth` 或无头启动检查；
4. 检查 `git diff --check`；
5. 提交配置和对应测试；
6. 单独审查插件 lockfile 更新，不把无关版本升级混入功能提交。

## 参考资料

- [LazyVim 文档](https://www.lazyvim.org/)
- [LazyVim 安装说明](https://www.lazyvim.org/installation)
- [LazyVim 默认快捷键](https://www.lazyvim.org/keymaps)
- [Neovim 文档](https://neovim.io/doc/)
- [clangd 文档](https://clangd.llvm.org/)
- [StyLua](https://github.com/JohnnyMorganz/StyLua)
