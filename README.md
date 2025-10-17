<p align="center">
  <img src="https://github.com/folksoftware/nvim/blob/master/crow.webp"/>
</p>

Neovim colorschemes by [folk.lol](https://folk.lol) — **abraxas**, **ushirogami**, **snawfus**, **mandragola**, and **zaratan**.

## How

**Add to your config:**

```lua
-- In your lazy.nvim setup (e.g., ~/.config/nvim/lua/plugins/theme.lua)
{
  "folksoftware/nvim",
  name = "folk",
  priority = 1000,
  config = function()
    require("folk").setup({
      flavour = "abraxas", -- or "ushirogami", "snawfus", "mandragola", "zaratan", "auto"
    })
    vim.cmd.colorscheme "folk-abraxas"
  end
}
```

**Restart neovim** — that's it!

## Switch

```vim
:colorscheme folk-abraxas
:colorscheme folk-ushirogami
:colorscheme folk-snawfus
:colorscheme folk-mandragola
:colorscheme folk-zaratan

" Or use the command
:Folk abraxas
:Folk ushirogami
:Folk snawfus
:Folk mandragola
:Folk zaratan
:Folk auto
```


## Development

```lua
vim.opt.runtimepath:append("~/folk/nvim")
vim.g.folk_debug = true
require("folk").setup({ flavour = "abraxas" })
vim.cmd.colorscheme "folk-abraxas"
```

<p align="center">
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_1.webp" width="20%"/>
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_2.webp" width="20%"/>
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_1.webp" width="20%"/>
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_2.webp" width="20%"/>
</p>

> Vibing over [catppuccin/nvim](https://github.com/catppuccin/nvim) `<3`

MIT — Copyright &copy; 2025 [folk.lol](https://folk.lol)
