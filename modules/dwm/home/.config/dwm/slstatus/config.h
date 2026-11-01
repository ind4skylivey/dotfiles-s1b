/* See LICENSE file for copyright and license details. */

const unsigned int interval = 1000;

static const char unknown_str[] = "n/a";

#define MAXLEN 2048

/*
 * STATUS2D COLOR CODES:
 * ^c#rrggbb^ → fg color   ^b#rrggbb^ → bg color   ^d^ → reset
 *
 * PALETTE:
 * normbg  #110022   normfg #b388ff
 * selbg   #bd00ff   selfg  #ffffff
 * cyan    #00ffff   green  #00ff88
 * red     #ff3333   amber  #ffaa00
 * dark1   #1a0033
 */

static const struct arg args[] = {

	/* ── CPU ─────────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^^c#b388ff^ ⚡ '" },
	{ cpu_perc, "^c#ffffff^%s%%^d^", NULL },

	/* ── RAM ─────────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^ ^c#b388ff^󰍛 '" },
	{ ram_used, "^c#ffffff^%s^d^", NULL },

	/* ── UPTIME ──────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^ ^c#b388ff^󱎫 '" },
	{ run_command, "%s",
	  "uptime -p | sed 's/up //;s/ hours,/h/;s/ hour,/h/;s/ minutes/m/;s/ minute/m/' "
	  "| awk '{printf \"^c#ffffff^%s^d^\", $0}'" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── NET SPEEDS ──────────────────────────────── */
	{ netspeed_tx, "^b#1a0033^^c#00ff88^↑%s ^d^", "enp5s0" },
	{ netspeed_rx, "^b#1a0033^^c#00ffff^↓%s^d^", "enp5s0" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── VOLUME ──────────────────────────────────── */
	{ run_command, "%s",
	  "vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk 'NR==1{print $5}' | tr -d '%'); "
	  "muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}'); "
	  "if [ \"$muted\" = 'yes' ]; then "
	    "printf '^b#1a0033^^c#ff3333^ 󰖁 off^d^'; "
	  "else "
	    "printf '^b#1a0033^^c#00ffff^ 󰕾 ^c#ffffff^%s%%^d^' \"$vol\"; "
	  "fi" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── MUSIC (playerctl) ───────────────────────── */
	{ run_command, "%s",
	  "st=$(playerctl status 2>/dev/null); "
	  "if [ \"$st\" = 'Playing' ] || [ \"$st\" = 'Paused' ]; then "
	    "artist=$(playerctl metadata artist 2>/dev/null); "
	    "title=$(playerctl metadata title 2>/dev/null); "
	    "printf '^b#1a0033^^c#ffaa00^ ♪ ^c#ffffff^%s^c#b388ff^ – ^c#ffffff^%s^d^' "
	      "\"$artist\" \"$title\"; "
	  "else "
	    "printf '^b#1a0033^^c#ff3333^ ♪ off^d^'; "
	  "fi" },

	/* ── SEPARATOR ───────────────────────────────── */
	{ run_command, "%s", "printf '^b#110022^^c#bd00ff^ │ ^d^'" },

	/* ── USER ────────────────────────────────────── */
	{ run_command, "%s", "printf '^b#1a0033^^c#00ffff^%s^d^' \"$(printf '\\357\\214\\203')\"" },

	/* ── DATE & TIME ─────────────────────────────── */
	{ datetime, "%s", "^b#110022^ ^c#b388ff^󰃰 ^c#ffffff^%b%d ^c#b388ff^%H:%M ^d^" },
};
