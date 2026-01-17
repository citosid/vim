# NeoVim configuration

This is my personal configuration for NeoVim using Lazy vim.

## Screenshots

![Alpha Dashboard](./screenshots/01.alpha.png)

![Telescope](./screenshots/02.telescope.find.files.png)

![Completions](./screenshots/03.completions.png)

![NeoTree](./screenshots/04.neotree.png)

![Zen Mode](./screenshots/05.zenmode.png)

## Terminal

The terminal is Alacritty. Configuration for it:

```toml
import = ["~/.config/alacritty/rose-pine.toml"]

[cursor.style]
blinking = "Always"

[font]
size = 14

[font.normal]
family = "FiraCode Nerd Font Mono"
style = "Regular"

[window]
blur = true
decorations = "None"
opacity = 0.65
```

Theme is [`rose-pine`][1].

Background can be found [here][2].

## Autocompletions

Autocompletions work out of the box with the following languages (I've not tested with others):

- Python
- TypeScript
- Lua


## Keybinding proposal (generated 2026-01-17T15:22:24.551Z)

This table shows the proposed streamlined keybinding scheme. Prefix rules: b = buffers, f = finders, g = git, l = lsp
, t = toggle/term, p = project/publish, s = spelling/search, h = highlight.

| Old | New | Reason |
|---|---|---|
| <leader>bn / <leader>l | <leader>bn / <leader>bp | Keep 'b' prefix for buffers; 'n'/'p' mnemonic for next/previous and avoid duplicates |
| <leader>h | <leader>bp | Move previous buffer to b-prefix for consistency |
| <leader>w | <leader>w | Keep save mapping; familiar and low friction |
| <leader>ff / <leader>fw / <leader>fg / <leader><space> | <leader>f f / <leader>f w / <leader>f g / <leader>f <space> | Group finders under 'f' with mnemonic seconds (files/grep/multigrep/buffers) |
| <leader>p (Neotree) | <leader>e | 'e' is ergonomic mnemonic for explorer; frees 'p' for project tools |
| <leader>bp / <leader>bl (pandoc) | <leader>p b / <leader>p l | Group pandoc/printing under project/publish prefix 'p' |
| <leader>gB | <leader>g b | Use 'g' prefix for git and lowercase subkey for blame |
| <leader>dd / <leader>dc / <leader>di / <leader>do / <leader>dt | <leader>d d/c/i/o/t | Keep DAP under 'd' (debugging) |
| <leader>k / <leader>D / <leader>rn / <leader>ca / <leader>f | <leader>l k / <leader>l D / <leader>l r / <leader>l a / <leader>l f | Group LSP actions under 'l' for consistency and mnemonic clarity |
| <leader>/ (comment) | <leader>/ | Keep comment toggle; intuitive and ergonomic |
| <leader>sa / <leader>sd / <leader>sg / <leader>sn / <leader>s? / <leader>s/ | <leader>s a/d/g/n/?/ | Keep 's' for spelling/search and consistent second letters |
| <leader>us / <leader>uw / <leader>ud / <leader>ul / <leader>uh | <leader>t s/w/d/l/h | Use 't' prefix for toggles (t s = toggle spelling, t w = toggle wrap, etc.) |
| <leader>hy / <leader>hg / <leader>hb / <leader>hr / <leader>ho / <leader>hp / <leader>hq / <leader>tmp / <leader>tsp / <leader>ttp / <leader>tqp / <leader>tup | <leader>h y/g/b/r/o/p/q / <leader>h m/s/t/q/u | 'h' prefix for highlights; second key for color/type shortens long tokens |


Notes:

- Keep built-in idiomatic mappings (gd, gD, K, gi) unchanged.
- Favor single-character subkeys after prefix to reduce finger travel and improve memorability.

If this proposal looks good, a follow-up patch can rename mappings in lua/keymaps.lua to match.

[1]: https://github.com/rose-pine/alacritty
[2]: https://github.com/rose-pine/wallpapers/blob/main/something-beautiful-in-nature.jpg
