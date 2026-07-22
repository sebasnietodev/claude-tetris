# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Vanilla JavaScript Tetris implementation using HTML5 Canvas. No dependencies, no build step, no package.json — just `index.html`, `style.css`, and `game.js`.

## Running the game

Open `index.html` directly in a browser, or serve it locally:

```bash
python3 -m http.server 8000   # or: npx serve .
```

There is no build, lint, or test command — the project has no tooling configured.

## Architecture

Everything lives in `game.js` as module-level state and functions (no classes, no build-time modules). The three files cooperate as:

- `index.html` — DOM structure: `#board` canvas (300×600, 10×20 cells at `BLOCK=30`px), `#next-canvas` piece preview, HUD spans (`#score`, `#lines`, `#level`), and the pause/game-over `#overlay`.
- `style.css` — dark/retro arcade visual theme.
- `game.js` — all game logic, in these pieces:
  - **Board model**: `board` is a `ROWS × COLS` matrix; each cell is `0` (empty) or a color index `1–7` identifying the locked piece type.
  - **Pieces**: `PIECES` holds the 7 tetromino shapes as square matrices. Rotation is done via matrix transpose+reverse in `rotateCW`.
  - **Collision**: `collide(shape, ox, oy)` checks bounds and overlap against `board`.
  - **Wall kicks**: `tryRotate()` rotates then tries offsets `[0, -1, 1, -2, 2]` until one doesn't collide.
  - **Game loop**: `loop(ts)` runs via `requestAnimationFrame`, accumulates `dt` into `dropAccum`, and drops the piece one row once `dropAccum >= dropInterval`.
  - **Line clearing**: `clearLines()` scans bottom-up, splices full rows and unshifts empty ones at the top.
  - **Scoring**: `LINE_SCORES = [0, 100, 300, 500, 800]` multiplied by `level`; hard drop adds 2 pts/cell dropped, soft drop adds 1 pt/row.
  - **Leveling**: level increases every 10 lines; `dropInterval = max(100, 1000 - (level-1)*90)` ms.
  - **Ghost piece**: `ghostY()` projects the current piece straight down; drawn at `globalAlpha = 0.2`.

Control flow: `init()` builds the board and starts the loop → `loop()` drives gravity and redraw each frame → `keydown` listener handles move/rotate/soft-drop/hard-drop/pause → `spawn()` promotes `next` to `current` and generates a new `next`, triggering `endGame()` if the new piece immediately collides.

Tunable constants live at the top of `game.js`: `COLS`, `ROWS`, `BLOCK`, `COLORS`, `LINE_SCORES`, `dropInterval`. If `COLS`, `ROWS`, or `BLOCK` change, update the `#board` canvas `width`/`height` in `index.html` to match (`COLS × BLOCK` by `ROWS × BLOCK`).
