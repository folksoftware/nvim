<p align="center">
  <img src="https://github.com/folksoftware/nvim/blob/master/crow.png"/>
</p>

Neovim colorschemes by [folk.lol](https://folk.lol) — **abraxas**, **ushirogami**, **snawfus**, **mandragola**, **zaratan**, **anqa**, **tatzelwurm**, and **yurei**.

## How

**Add to your config:**

```lua
-- In your lazy.nvim setup (e.g., ~/.config/nvim/init.lua)
{
  "folksoftware/nvim",
  name = "folk",
  priority = 1000,
  config = function()
    require("folk").setup({ flavour = "abraxas" })
    vim.cmd.colorscheme "folk-abraxas"
  end
}
```

**Restart neovim** — that's it!

## Themes

<table>
<tr>
<td width="50%" align="center">

### abraxas
<img src="screenshots/abraxas.png" alt="abraxas creature" width="50%"/>
<img src="screenshots/abraxas-theme.png" alt="abraxas theme"/>
<code>:colorscheme folk-abraxas</code>

</td>
<td width="50%" align="center">

### ushirogami
<img src="screenshots/ushirogami.png" alt="ushirogami creature" width="50%"/>
<img src="screenshots/ushirogami-theme.png" alt="ushirogami theme"/>
<code>:colorscheme folk-ushirogami</code>

</td>
</tr>
<tr>
<td width="50%" align="center">

### snawfus
<img src="screenshots/snawfus.png" alt="snawfus creature" width="50%"/>
<img src="screenshots/snawfus-theme.png" alt="snawfus theme"/>
<code>:colorscheme folk-snawfus</code>

</td>
<td width="50%" align="center">

### mandragola
<img src="screenshots/mandragola.png" alt="mandragola creature" width="50%"/>
<img src="screenshots/mandragola-theme.png" alt="mandragola theme"/>
<code>:colorscheme folk-mandragola</code>

</td>
</tr>
<tr>
<td width="50%" align="center">

### zaratan
<img src="screenshots/zaratan.png" alt="zaratan creature" width="50%"/>
<img src="screenshots/zaratan-theme.png" alt="zaratan theme"/>
<code>:colorscheme folk-zaratan</code>

</td>
<td width="50%" align="center">

### anqa
<img src="screenshots/anqa.png" alt="anqa creature" width="50%"/>
<img src="screenshots/anqa-theme.png" alt="anqa theme"/>
<code>:colorscheme folk-anqa</code>

</td>
</tr>
<tr>
<td width="50%" align="center">

### tatzelwurm
<img src="screenshots/tatzelwurm.png" alt="tatzelwurm creature" width="50%"/>
<img src="screenshots/tatzelwurm-theme.png" alt="tatzelwurm theme"/>
<code>:colorscheme folk-tatzelwurm</code>

</td>
<td width="50%" align="center">

### yurei
<img src="screenshots/yurei.png" alt="yurei creature" width="50%"/>
<img src="screenshots/yurei-theme.png" alt="yurei theme"/>
<code>:colorscheme folk-yurei</code>

</td>
</tr>
</table>

## Development

```lua
vim.opt.runtimepath:append("~/folk/nvim")
vim.g.folk_debug = true
require("folk").setup({ flavour = "abraxas" })
vim.cmd.colorscheme "folk-abraxas"
```

<p align="center">
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_1.png" width="20%"/>
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_2.png" width="20%"/>
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_1.png" width="20%"/>
  <img src="https://github.com/folksoftware/nvim/blob/master/fire_2.png" width="20%"/>
</p>

> Vibing over [catppuccin/nvim](https://github.com/catppuccin/nvim) `<3`

MIT — Copyright &copy; 2025 [folk.lol](https://folk.lol)
