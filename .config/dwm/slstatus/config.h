/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

/*
 * STATUS2D COLOR CODES (DWM patch applied):
 *
 *   ^c#rrggbb^  → set foreground color
 *   ^b#rrggbb^  → set background color
 *   ^d^         → reset to SchemeNorm
 *
 * PALETTE (matches DWM config.h):
 *   normbg   #110022   normfg   #b388ff
 *   selbg    #bd00ff   selfg    #ffffff
 *   cyan     #00ffff   orange   #ff8800
 *   red      #ff3333   amber    #ffaa00
 *   green    #00ff88   teal bg  #001a2e
 *   purple2  #1a0033   redbg    #1a0000
 */

static const struct arg args[] = {

	/* ── CPU ─────────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^^c#b388ff^ ⚡ '" },
	{ cpu_perc,    "^c#ffffff^%s%%^d^", NULL },

	/* ── RAM ─────────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^ ^c#b388ff^󰍛  '" },
	{ ram_used,    "^c#ffffff^%s^d^", NULL },

	/* ── UPTIME ──────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^ ^c#b388ff^󱎫  '" },
	{ run_command, "%s", "uptime -p | sed 's/up //; s/ hours,/h/; s/ hour,/h/; s/ minutes/m/; s/ minute/m/' | awk '{printf \"^c#ffffff^%s^d^\", $0}'" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── NETWORK SPEED ───────────────────────────── */
	{ run_command, "%s", "printf '^b#001a2e^^c#00ffff^ '" },
	{ netspeed_rx, "^c#00ff88^↓%sB/s^d^", "enp5s0" },
	{ run_command, "%s", "printf ' '" },
	{ netspeed_tx, "^c#ff8800^↑%sB/s^d^", "enp5s0" },

	/* ── KERNEL ──────────────────────────────────── */
	{ run_command, "%s", "printf '^b#001a2e^ ^c#00ffff^󰌢  ^c#ffffff^%s^d^' \"$(uname -r | cut -d- -f1)\"" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── VPN / tun0 IP ───────────────────────────── */
	{ run_command, "%s",
		"ip=$(ip -4 addr show tun0 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1); "
		"if [ -n \"$ip\" ]; then "
		  "printf '^b#001a2e^^c#00ffff^ 󰖂  ^c#00ff88^'\"$ip\"'^d^'; "
		"else "
		  "printf '^b#1a0000^^c#ffffff^ 󰖂  off  ^d^'; "
		"fi"
	},

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── NOW PLAYING (playerctl) ─────────────────── */
	{ run_command, "%s",
		"info=$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null | cut -c1-35); "
		"if [ -n \"$info\" ]; then "
		  "printf '^b#2a0050^^c#ffffff^ 󰎇  %s^d^' \"$info\"; "
		"else "
		  "printf '^b#1a0033^^c#555566^ 󰎇  idle^d^'; "
		"fi"
	},

	/* ── VOLUME ──────────────────────────────────── */
	{ run_command, "%s",
		"vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk 'NR==1{print $5}' | tr -d '%'); "
		"muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}'); "
		"if [ \"$muted\" = 'yes' ]; then "
		  "printf '^b#1a0033^^c#ff3333^ 󰖁  mute^d^'; "
		"else "
		  "printf '^b#1a0033^^c#00ffff^ 󰕾  ^c#ffffff^%s%%^d^' \"$vol\"; "
		"fi"
	},

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── USER (ROOT indicator) ───────────────────── */
	{ run_command, "%s", "printf '^b#1a0000^^c#ff3333^ 󱄙   ^c#ffffff^%s ^d^' \"$(whoami)\"" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── DATE & TIME ─────────────────────────────── */
	{ datetime,    "%s", "^b#110022^^c#b388ff^ 󰃰  ^c#ffffff^%b%d ^c#b388ff^%H:%M   ^d^" },
};
