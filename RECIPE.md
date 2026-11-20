# macOS

A light, native-looking macOS window for Herdr. The whole window is one frosted pane of
glass over the blurred desktop: the sidebar, tab bar and status bar sit directly on it
with no boxes of their own, and the terminals are soft white cards. Selections and menu
highlights are macOS system blue with white text, menus are rounded like Tahoe's, and
type is San Francisco and SF Mono. Built from Herdr Glass 0.1.0 on herdr-app 0.1.16.

## What you see

Left to right, with 10px of window around and between regions (root `padding 10`,
`gap 10`). The window itself is `#f4f4f7a6` with `window_blur: true`: the desktop shows
through, blurred, under a light grey tint.

- **Sidebar** (250px, min 44, max 480; rail under 160px): no background, border or
  shadow of its own; it is part of the window, like Finder's.
  - Top row (46px): Herdr logo and name, search, sidebar fold button. macOS traffic
    lights at `[24, 26]`.
  - **Spaces** heading: 11px semibold, `dim`. Under it, one header per machine
    ("This computer", then each ssh machine): 32px tall with 6px above it, the name
    14px semibold in `muted`; a 16px monitor/server icon, the `+` (new space there)
    18px in a 22px hit area with radius 6 that hovers `hover`, a 7px status dot and a
    14px chevron, all `dim`; state text stays 11px. Space rows (26–28px, radius 8)
    below each machine, each with a 12px fold arrow on the left.
  - **Tabs under each space**: one 26px row per tab (radius 8, 12.5px text), indented
    past the space's name: the focused pane's program icon (14px), Herdr's tab name
    (`Z` when zoomed) and the tab's status mark (working spinner, blocked or done dot).
    A split tab is still one row; panes are not listed.
  - **Agents** heading: 11px semibold, `dim`; agents grouped by space, 30px rows,
    radius 8; sub-agents indented on 26px rows.
  - Footer (97px): Settings, Appearance, Add machine. No divider lines anywhere in the
    sidebar.
  - **Selected rows are blue**: the shown space, the focused agent, a shown sub-agent
    and the selected rail number get `accent` (`#007aff`), and everything on the row
    turns white (name, branch icon and text, ↑/↓ counts, time, spinner, done dot,
    "Needs you" badge). Hovering a selected row keeps it blue; other rows hover
    `#0000000d`.
- **Work column**:
  - Tab bar (42px): no card; tabs are pills (`raised` `#ffffffe0` for the active one),
    then `+`, Files and Changes buttons.
  - Terminal panes: radius 16, fill `#ffffffbf`, border `#ffffff80`, a blue focus ring
    `#007aff8c` on the focused pane, a 30px header on every pane (`lone: true`),
    terminal text `[12, 14]` in. Terminal: SF Mono 13, weight 400, line height 1.1,
    `terminal_opacity: 0` (the rounded frame paints the white).
  - Right panel (340px, min 280, max 900, hidden until Files or Changes is pressed):
    the only floating card, `#ffffff73`, border `#ffffff8c`, radius 16, shadow `sm`.
  - Status bar (30px): no card, text straight on the window.
- **Menus** (right-click on a terminal, tab or space; the `+` menu; the agents sort
  menu): Herdr's frame is off and the menu draws its own panel: radius 13, `popover`
  `#f6f6f8e6`, 1px `border`, shadow `md`, 8px transparent margin for the shadow, 5px
  inner padding. Rows 26px, radius 8, 13px text. Shortcuts in Apple notation
  (`⇧⌘D`, `⌘N`, `↩`).
- **Type**: UI in `.SF NS` (San Francisco); terminals in SF Mono.
- **Colors** (`themes/macos.json`, Apple's light system colors): foreground `#1d1d1f`,
  muted `#3c3c43a6`, dim `#3c3c4373`, border `#0000001a`, selected `#0000001a`,
  accent / solid `#007aff` with white, selection `#b3d7ff`, working `#007aff`,
  blocked `#ff9500`, done `#34c759`. ANSI on white: `#1d1d1f #d70015 #248a3d #b25000
  #0040dd #8944ab #0071a4 #8e8e93`, brights `#6e6e73 #ff3b30 #34c759 #ff9500 #007aff
  #af52de #32ade6 #c7c7cc` (dark variants first so yellow, green and cyan read on white).

## How it behaves

- Agent status as in Herdr: working spinner (blue), blocked "Needs you" (orange), done
  dot (green), idle ring. On a selected (blue) row all of them are white.
- **Menus**: nothing is highlighted when a menu opens. The pointer or ↑/↓ moves one
  shared highlight (accent blue, white text, icon and shortcut); leaving a row clears
  it; Enter picks the highlighted row; Esc or a click outside closes the menu.
- **Fold**: the sidebar button folds to the rail and back, as in Herdr Glass.
- **Tab list**: spaces start expanded; a space's arrow folds its tabs away, and folded
  spaces are remembered (`localStorage` `tree.folded`). Clicking a tab row shows that
  space and tab; right-clicking it opens the tab menu. One row is blue: the shown tab,
  or the shown space while it is folded; an expanded shown space keeps a grey
  `selected` pill. The rail (under 160px) shows no tabs.
- **Appearance** (sidebar footer): Herdr Glass's dialog, adapted.
  - Glass: Clear / Light / Medium / Tinted / Solid sets the right panel's alpha
    (`40`/`66`/`99`/`c2`/`eb` on `#ffffff`) and the panes' (`bf`/`d9`/`e6`/`f0`/`fa`
    on `#ffffff`). The sidebar, tab bar and status bar are never given a card.
  - Image: **Desktop** (the default: no picture, the window's `#f4f4f7a6` tint over
    the blurred desktop), Graphite, and every picture in
    `~/.config/herdr-app/backgrounds/` (Herdr Glass's presets are copied there the
    first time the dialog opens). If the picture in use is deleted, it goes back to
    Desktop.
  - Components: switches Spaces, Agents, pane headers and notifications between the
    `macos-*` mods and Herdr's own.

## Built from

- `layouts/macos.json`: a `layout.clone` of Herdr Glass. Root: `titlebar: none`,
  `traffic_lights [24, 26]`, `theme: macos`, `colors` with `canvas`, `chrome` and
  `background` transparent, `window_blur: true`, `background "#f4f4f7a6"`,
  `toast: macos-toast`, `terminal_menu: macos-menu`, `ui_font ".SF NS"`, fonts above,
  `preview: layouts/macos.svg`. Tree: `sidebar` column (`brand`, `sidebar-lists`
  [`spaces`, `agents`], `sidebar-footer`) and `work` column (`tabs` row → `tab-strip`,
  `work-body` row → `main` tab block and `panel` column → `panel-body` stack
  [`files`, `changes`], `status`).
- `themes/macos.json`: the layout's own theme (named like the layout, so Settings
  offers it only there).
- Mods, all `mod.clone` copies: of Herdr Glass's mods (`macos-tabs`, `macos-pane`,
  `macos-toast`, `macos-chrome`, `macos-status`, `macos-agents`, `macos-spaces`, and
  `macos-appearance` from `herdr-glass-bg`) and of Herdr's `menu` and `new-menu`
  (`macos-menu`, `macos-new-menu`). Every reference between them names the `macos-*`
  copy. Changes, marked `macos:` in the code:
  - `macos-menu`: blue shared highlight, rows 26px radius 8, own rounded panel,
    Apple-notation shortcuts; its `mod.json` sets `overlay {width 236, height 300,
    frame: "none"}` for the terminal right-click menu Herdr opens.
  - `macos-new-menu`, `macos-agents` (sort menu): the same highlight and panel.
  - `macos-tabs`, `macos-spaces`, `macos-agents` open their menus with
    `frame: "none"` and 16px more width and height for the shadow margin.
  - `macos-spaces`, `macos-agents`: blue selected rows via `onBlue(t)`, a copy of the
    theme with white text colors passed to the selected row; semibold 11px headings;
    machine headers 14px semibold `muted` with larger icon, `+` and chevron; no
    divider line above Agents.
  - `macos-spaces`: the tabs listed under each space, with fold arrows.
  - `macos-chrome`: no divider line above the footer; opens `macos-appearance`.
  - `macos-appearance`: white glass tints, the Desktop choice, cards limited to
    `panel`.
- Uses Herdr's shipped files: `files`, `changes`, `worktree`, `machine-add`, icons in
  `mods/workspace-chrome/` and `icons/`, and Herdr Glass's preset pictures (carried in
  `mods/macos-appearance/presets/`).

## Watch out

- `herdr-app shot` draws the window over black, not the desktop, so screenshots of a
  `window_blur` layout look much darker than the real window. Judge transparency on
  the screen.
- A low window alpha (below ~`a6`) over a dark wallpaper makes the whole light theme
  murky: macOS's own materials keep a strong light tint.
- `ui_font: ".SystemUIFont"` and `".SF NS"` both reach San Francisco; `"SF Pro"` isn't
  a family on a stock Mac.
- A menu's hover text color can't come from a theme: `.hover()` doesn't recolor
  children that set their own `text_color`, so the highlighted row is tracked with
  `on_hover` and rendered with white children.
- `frame: "none"` menus must leave a transparent margin, or the shadow is cut at the
  overlay's edge; the openers' sizes include it.
- `gpui-kit`'s `.bg()` takes colors, not `{gradient}` objects.
- Theme colors may carry alpha (`dim`, `muted`): never append alpha digits to them. The
  agents mod appends `26` to `blocked`, so `blocked` stays a 6-digit color (also in
  `onBlue`).
- The clones don't follow Herdr updates; re-clone and re-apply the `macos:` changes
  when Herdr changes `menu`, `new-menu`, `tabs`, `spaces`, `agents`, `pane`,
  `workspace-chrome`, `workspace-status` or `toast`.
- Light only; there is no dark variant. Only macOS is tested.

## Done when

- `herdr-app check` passes for all ten `macos-*` mods and `herdr-app status` shows no
  errors with the layout shown.
- The desktop shows blurred through the window; the sidebar, tab bar and status bar
  have no box of their own; only the panes and the right panel are cards.
- Right-clicking a terminal, a tab or a space opens a rounded menu with nothing
  highlighted; moving the pointer or pressing ↓ gives a blue row with white text and
  icon; shortcuts read like `⌘N`.
- The shown space and the focused agent are blue rows with white text, including the
  branch and ↑/↓ counts.
- Machine names read as small headers above their spaces.
- Each space lists its tabs; the shown tab is blue; folding a space hides its tabs and
  survives a restart.
- Appearance offers Desktop first; picking Desktop removes the picture.
