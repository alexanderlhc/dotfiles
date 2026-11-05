#!/usr/bin/env python3
"""Enlarge the cursor while it's shaken. Polls Hyprland's socket."""
import os, socket, time

BASE, BIG = 24, 72
THEME = "default"
POLL = 1 / 30
WINDOW = 0.5        # seconds of motion considered
REVERSALS = 4       # direction flips inside WINDOW that count as a shake
MIN_STEP = 25       # px of travel between flips; filters out normal small moves
HOLD = 0.8          # seconds to stay big after the shake ends

path = f"{os.environ['XDG_RUNTIME_DIR']}/hypr/{os.environ['HYPRLAND_INSTANCE_SIGNATURE']}/.socket.sock"

def ask(cmd):
    with socket.socket(socket.AF_UNIX) as s:
        s.connect(path)
        s.sendall(cmd.encode())
        return s.recv(256).decode()

def main():
    flips, last_x, anchor, direction, big_until, big = [], None, 0, 0, 0.0, False
    try:
        while True:
            now = time.monotonic()
            x = int(ask("cursorpos").split(",")[0])
            if last_x is not None:
                d = (x > last_x) - (x < last_x)
                if d and d != direction:
                    if direction and abs(last_x - anchor) >= MIN_STEP:
                        flips.append(now)
                    direction, anchor = d, last_x
            last_x = x
            flips = [t for t in flips if now - t <= WINDOW]
            if len(flips) >= REVERSALS:
                big_until = now + HOLD
                if not big:
                    ask(f"setcursor {THEME} {BIG}"); big = True
            elif big and now > big_until:
                ask(f"setcursor {THEME} {BASE}"); big = False
            time.sleep(POLL)
    finally:
        if big:
            ask(f"setcursor {THEME} {BASE}")

main()
