# macOS for Herdr

A light, native-looking macOS layout for [Herdr](https://herdr.dev): one frosted window
over the blurred desktop, a Finder-style sidebar, white terminal cards, system-blue
selections and rounded Tahoe-style menus, in San Francisco with Operator Mono Italic terminals.

Built on [Herdr Glass](https://github.com/noah4520/herdr-glass) by Noah Chen.

## Install

Ask the agent in any Herdr terminal:

```
Add the Herdr layout at github.com/ChvilaMartin/herdr-macos-theme
```

Or from a clone of this repo:

```sh
./scripts/install.sh              # copies into ~/.config/herdr-app and checks each mod
herdr-app do layout.switch --name macos
```

The terminals use Operator Mono Italic, a paid font this repo doesn't include. If you
own Operator Mono, make the italic family Herdr can load (needs `pip install fonttools`):

```sh
python3 scripts/operator-mono-italic.py ~/Library/Fonts ~/.config/herdr-app/fonts
```

Without it, the terminals fall back to JetBrains Mono; or set the layout's `font` to
any font you have.

`cmd-shift-l` cycles layouts, so your previous one stays a key away. To remove it,
delete `layouts/macos.*`, `themes/macos.json` and `mods/macos-*` from
`~/.config/herdr-app`.

## What it changes

- **Window**: `window_blur` with a light `#f4f4f7a6` tint, like macOS window materials.
  The sidebar, tab bar and status bar sit on it without boxes; terminals are white
  rounded cards with a blue focus ring.
- **Sidebar**: no dividers, semibold section headings, machine names as small headers,
  each space's tabs listed under it (foldable), and the shown tab / focused agent as a
  blue row with white text.
- **Menus**: right-click (terminal, tab, space), `+` and the agents sort menu: rounded
  panels, a blue highlight shared by pointer and arrow keys, shortcuts as `⇧⌘D`.
- **Colors**: Apple's light system palette (`#007aff` accent, label greys), readable
  ANSI colors on white, `#b3d7ff` text selection.
- **Appearance** (sidebar footer): glass level for the panes and side panel, and a
  background choice: Desktop (blurred desktop, the default) or a picture.

It needs a Mac (window blur, SF fonts) and Operator Mono for the terminals and was built on herdr-app 0.1.16. Light only.

## Files

| Path | What |
|---|---|
| `layouts/macos.json` | the layout (preview `layouts/macos.svg`) |
| `themes/macos.json` | its theme |
| `mods/macos-*` | ten mods: sidebar, tabs, pane header, status, toast, menus, Appearance |
| `RECIPE.md` | the brief to rebuild it from scratch (Herdr's sharing format) |
| `scripts/install.sh` | copy into a Herdr home and check |
| `scripts/operator-mono-italic.py` | make the italic terminal font from your Operator Mono |

## License

MIT (`LICENSE`). Parts come from Herdr (Apache-2.0), Herdr Glass (MIT) and Lucide
(ISC): see `NOTICE` and `licenses/`.
