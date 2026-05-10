/* See LICENSE file for copyright and license details. */
#include <stddef.h>

/* appearance */
static const unsigned int refresh_rate        = 180;  /* matches dwm's mouse event processing to your monitor's refresh rate for smoother window interactions */
static const unsigned int enable_noborder     = 1;   /* toggles noborder feature (0=disabled, 1=enabled) */
static const unsigned int borderpx            = 2;   /* border pixel of windows */
static const unsigned int snap                = 8;   /* snap pixel */
static unsigned int gappih                    = 10;  /* inner horizontal gap between windows */
static unsigned int gappiv                    = 10;  /* inner vertical gap between windows */
static unsigned int gappoh                    = 10;  /* outer horizontal gap between windows and screen edge */
static unsigned int gappov                    = 10;  /* outer vertical gap between windows and screen edge */
static int smartgaps                          = 0;   /* 1 means no outer gap when there is only one window */
static const int swallowfloating              = 1;   /* 1 means swallow floating windows by default */
static const unsigned int systraypinning      = 1;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft       = 0;   /* 0: systray in the right corner, >0: s:systray on left of status text */
static const unsigned int systrayspacing      = 6;   /* systray spacing */
static const int systraypinningfailfirst      = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor */
static const int showsystray                  = 1;   /* 0 means no systray */
static const int showbar                      = 1;   /* 0 means no bar */
static const int topbar                       = 1;   /* 0 means bottom bar */
#define ICONSIZE                              12    /* icon size */
#define ICONSPACING                           6      /* space between icon and title */
#define SHOWWINICON                           1      /* 0 means no winicon */
static const char *fonts[]                    = { "MesloLGS Nerd Font Mono:size=11", "NotoColorEmoji:pixelsize=11:antialias=true:autohint=true" };
static const char normbordercolor[]       = "#5c0099";  /* Vibrant purple border (inactive) */
static const char normbgcolor[]           = "#110022";  /* Dark deep violet background */
static const char normfgcolor[]           = "#b388ff";  /* Neon Violet text */
static const char selbordercolor[]        = "#ff2200";  /* Neon Red-Orange accent (active) */
static const char selbgcolor[]            = "#bd00ff";  /* Electric Violet active background */
static const char selfgcolor[]            = "#ffffff";  /* White text (active) */

static const char urgbordercolor[]        = "#ff0000";  /* Red border for urgent windows */
static const char urgbgcolor[]            = "#ff0000";  /* Red background for urgent tags */
static const char urgfgcolor[]            = "#ffffff";  /* White text for urgent tags */

static const char titlebordercolor[]      = "#5c0099";  /* Same as norm border */
static const char titlebgcolor[]          = "#1a0033";  /* Slightly lighter violet for title */
static const char titlefgcolor[]          = "#ffffff";  /* White text for title */

static const char layoutbordercolor[]     = "#5c0099";  /* Same as norm border */
static const char layoutbgcolor[]         = "#000000";  /* Black background for layout symbol */
static const char layoutfgcolor[]         = "#00ffff";  /* Cyan text for layout symbol */

static const char *colors[][3] = {
    /*               fg              bg              border            */
    [SchemeNorm]   = { normfgcolor,   normbgcolor,    normbordercolor   },
    [SchemeSel]    = { selfgcolor,    selbgcolor,     selbordercolor    },
    [SchemeUrg]    = { urgfgcolor,    urgbgcolor,     urgbordercolor    },
    [SchemeTitle]  = { titlefgcolor,  titlebgcolor,   titlebordercolor  },
    [SchemeLayout] = { layoutfgcolor, layoutbgcolor,  layoutbordercolor },
};

static const char *const autostart[] = {
    "xset", "s", "off", NULL,
    "xset", "s", "noblank", NULL,
    "xset", "-dpms", NULL,
    "dbus-update-activation-environment", "--systemd", "--all", NULL,
    "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1", NULL,
    "sh", "-c", "QT_QPA_PLATFORM=xcb flameshot &", NULL,
    "sh", "-c", "openrgb --startminimized &", NULL,
    "sh", "-c", "emacs --daemon &", NULL,
    "sh", "-c", "legcord &", NULL,
    "sh", "-c", "solaar -w hide &", NULL,
    "dunst", NULL,
    "xset", "r", "rate", "300", "50", NULL,  /* Keyboard repeat rate faster */
    "picom", "-b", NULL,
    "sh", "-c", "feh --randomize --bg-fill ~/Pictures/backgrounds/*", NULL,
    "synergy", NULL,
    "/home/il1v3y/.config/dwm/slstatus/slstatus", NULL,
    "sh", "-c", "/home/il1v3y/.config/dwm/scripts/apply-xrandr-layout.sh", NULL,
    NULL,
    NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "", "", "󰊖", "", "", "", "", "", "" };

static const char ptagf[] = "[%s %s]";  /* format of a tag label */
static const char etagf[] = "[%s]";     /* format of an empty tag */
static const int lcaselbl = 0;          /* 1 means make tag label lowercase */

static const Rule rules[] = {
    /* class                instance  title                 tags mask  isfloating  isterminal  noswallow  monitor */
    { NULL,                 NULL,     "archynotch",            0,         1,          0,          0,        -1 },
    { "St",                 NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "kitty",              NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "Alacritty",          NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "terminator",         NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "firefox",            NULL,     NULL,               1 << 1,        0,          0,          0,        -1 },
    { "Google-chrome",      NULL,     NULL,               1 << 1,        0,          0,          0,        -1 },
    { "Brave-browser",      NULL,     NULL,               1 << 1,        0,          0,          0,        -1 },
    { "zen-alpha",          NULL,     NULL,               1 << 1,        0,          0,          0,        -1 },
    { "lutris",             NULL,     NULL,                    0,         1,          0,          0,         0 },
    { "steam_app_default",  NULL,     NULL,                    0,         1,          0,          0,         0 },
    { "gamescope",          NULL,     NULL,                    0,         0,          0,          0,         0 },
    { "dolphin",            NULL,     NULL,               1 << 3,        1,          0,          0,         0 },
    { "retroarch",          NULL,     NULL,                    0,         1,          0,          0,         0 },
    { "es-de",              NULL,     NULL,                    0,         1,          0,          0,         0 },
    { "Pcmanfm-qt",         NULL,     NULL,               1 << 3,        1,          0,          0,         0 },
    { "Thunar",             NULL,     NULL,               1 << 3,        1,          0,          0,         0 },
    { "vesktop",            NULL,     NULL,               1 << 4,        0,          0,          0,        -1 },
    { "discord",            NULL,     NULL,               1 << 4,        0,          0,          0,        -1 },
    { "Legcord",            NULL,     NULL,               1 << 4,        0,          0,          0,        -1 },
    { "BurpSuite",          NULL,     NULL,               1 << 5,        0,          0,          0,        -1 },
    { "Ghidra",             NULL,     NULL,               1 << 5,        0,          0,          0,        -1 },
    { "org.owasp.ZAP",      NULL,     NULL,               1 << 5,        0,          0,          0,        -1 },
    { "Wireshark",          NULL,     NULL,               1 << 6,        0,          0,          0,        -1 },
    { "Pavucontrol",        NULL,     NULL,                    0,         1,          0,          0,        -1 },
    { "Blueman-manager",    NULL,     NULL,                    0,         1,          0,          0,        -1 },
    { "Nm-connection-editor",NULL,    NULL,                    0,         1,          0,          0,        -1 },
    { NULL,                 NULL,     "GtkFileChooserDialog",  0,         1,          0,          0,        -1 },
    { NULL,                 NULL,     "xdg-desktop-portal",    0,         1,          0,          0,        -1 },
    { NULL,                 NULL,     "pop-up",                0,         1,          0,          0,        -1 },
    { NULL,                 NULL,     "Event Tester",          0,         0,          0,          1,        -1 } /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },     /* first entry is default */
    { "><>",      NULL },     /* no layout function means floating behavior */
    { "[M]",      monocle },
};

/* Key definitions */
#define MODKEY     Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY, view,       {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY, toggleview, {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY, toggletag,  {.ui = 1 << TAG} },

/* Helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)    { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR     "slstatus"

/* Commands */
static const char *launchercmd[]   = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]       = { "kitty", NULL };
static const char *editorcmd[]     = { "emacsclient", "-c", "-a", "emacs", NULL };
static const char *chatcmd[]       = { "legcord", NULL };
static const char *seccmd[]        = { "burpsuite", NULL };
static const char *gamescopecmd[]  = { "/home/il1v3y/.config/gamescope/steam-gamescope-session", NULL };

static Key keys[] = {
    /* modifier                     key                        function        argument */
    { MODKEY,                       XK_z,                      spawn,          {.v = launchercmd} },
    { MODKEY|ControlMask,           XK_r,                      spawn,          SHCMD ("protonrestart")},
    { MODKEY,                       XK_x,                      spawn,          {.v = termcmd } },
    { MODKEY,                       XK_a,                      spawn,          {.v = editorcmd } },
    { MODKEY,                       XK_v,                      spawn,          {.v = chatcmd } },
    { MODKEY,                       XK_g,                      spawn,          {.v = seccmd } },
    { MODKEY,                       XK_r,                      spawn,          SHCMD ("rofi -show window -modi window,run,drun,ssh") },
    { MODKEY,                       XK_F2,                     spawn,          SHCMD("pavucontrol") },
    { MODKEY,                       XK_F3,                     spawn,          SHCMD("blueman-manager") },
    { MODKEY,                       XK_F4,                     spawn,          SHCMD("nm-connection-editor") },
    { MODKEY|ShiftMask,             XK_f,                      spawn,          SHCMD("firefox") },
    { MODKEY|ShiftMask,             XK_z,                      spawn,          SHCMD("zaproxy &") },
    { MODKEY|ShiftMask,             XK_e,                      spawn,          SHCMD("dolphin") },
    { MODKEY|ShiftMask,             XK_t,                      spawn,          SHCMD("thunar") },
    { MODKEY|ControlMask,           XK_a,                      spawn,          SHCMD("emacsclient -c -a emacs --eval '(org-agenda)'") },
    { MODKEY,                       XK_o,                      spawn,          SHCMD("keepassxc") },
    { MODKEY,                       XK_c,                      spawn,          SHCMD("cliphist list | rofi -dmenu | cliphist decode | wl-copy || xclip -selection clipboard") },
    { MODKEY,                       XK_b,                      spawn,          SHCMD ("zen-browser")},
    { MODKEY,                       XK_p,                      spawn,          SHCMD ("flameshot full -p ~/Screenshots/")},
    { MODKEY|ShiftMask,             XK_p,                      spawn,          SHCMD ("flameshot gui -p ~/Screenshots/")},
    { MODKEY|ControlMask,           XK_p,                      spawn,          SHCMD ("flameshot gui --clipboard")},
    { 0,                            XK_Print,                  spawn,          SHCMD ("flameshot gui") }, /* Print key = GUI */
    { MODKEY,                       XK_e,                      spawn,          SHCMD ("pcmanfm-qt")},
    { MODKEY,                       XK_w,                      spawn,          SHCMD ("looking-glass-client -F")},
    { MODKEY|ShiftMask,             XK_w,                      spawn,          SHCMD ("feh --randomize --bg-fill ~/Pictures/backgrounds/*")},
    { MODKEY|ShiftMask,             XK_s,                      spawn,          {.v = gamescopecmd } },
    { 0,                            XF86XK_MonBrightnessUp,    spawn,          SHCMD ("xbacklight -inc 10 && dunstify -r 9992 -u low \"Brightness $(xbacklight -get | cut -d. -f1)%\"")},
    { 0,                            XF86XK_MonBrightnessDown,  spawn,          SHCMD ("xbacklight -dec 10 && dunstify -r 9992 -u low \"Brightness $(xbacklight -get | cut -d. -f1)%\"")},
    { 0,                            XF86XK_AudioLowerVolume,   spawn,          SHCMD ("amixer sset Master 5%- unmute && vol=$(amixer get Master | awk -F'[][]' '/Left:/{print $2; exit}') && dunstify -r 9991 -u low \"Volume $vol\"")},
    { 0,                            XF86XK_AudioMute,          spawn,          SHCMD ("amixer sset Master $(amixer get Master | grep -q '\\[on\\]' && echo 'mute' || echo 'unmute') && vol=$(amixer get Master | awk -F'[][]' '/Left:/{print $2; exit}') && dunstify -r 9991 -u low \"Volume $vol\"")},
    { 0,                            XF86XK_AudioRaiseVolume,   spawn,          SHCMD ("amixer sset Master 5%+ unmute && vol=$(amixer get Master | awk -F'[][]' '/Left:/{print $2; exit}') && dunstify -r 9991 -u low \"Volume $vol\"")},
    { MODKEY|ShiftMask,             XK_b,                      togglebar,      {0} },
    { MODKEY|ControlMask,           XK_plus,                   incrgaps,       {.i = +1 } },
    { MODKEY|ControlMask,           XK_minus,                  incrgaps,       {.i = -1 } },
    { MODKEY|ControlMask,           XK_equal,                  defaultgaps,    {0} },
    { MODKEY|ControlMask|ShiftMask, XK_g,                      togglegaps,     {0} },
    { MODKEY,                       XK_j,                      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,                      focusstack,     {.i = -1 } },
    { MODKEY|ShiftMask,             XK_j,                      movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_k,                      movestack,      {.i = -1 } },
    { MODKEY,                       XK_i,                      incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_d,                      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_F11,                    spawn,          SHCMD("redshift -O 3500") },
    { MODKEY|ShiftMask,             XK_F11,                    spawn,          SHCMD("redshift -x") },
    { MODKEY,                       XK_h,                      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,                      setmfact,       {.f = +0.05} },
    { MODKEY|ShiftMask,             XK_h,                      setcfact,       {.f = +0.25} },
    { MODKEY|ShiftMask,             XK_l,                      setcfact,       {.f = -0.25} },
    { MODKEY|ShiftMask,             XK_o,                      setcfact,       {.f =  0.00} },
    { MODKEY,                       XK_Return,                 zoom,           {0} },
    { MODKEY,                       XK_KP_Enter,               zoom,           {0} },
    { Mod1Mask,                     XK_Return,                 zoom,           {0} },
    { MODKEY|ControlMask|ShiftMask, XK_l,                      spawn,          SHCMD("/home/il1v3y/lockscreen.sh") },
    { MODKEY,                       XK_Tab,                    view,           {0} },
    { MODKEY,                       XK_q,                      killclient,     {0} },
    { MODKEY,                       XK_t,                      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_f,                      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_m,                      fullscreen,     {0} },
    { MODKEY,                       XK_space,                  setlayout,      {0} },
    { MODKEY|ControlMask,           XK_Left,                   cyclelayout,    {.i = -1 } },
    { MODKEY|ControlMask,           XK_Right,                  cyclelayout,    {.i = +1 } },
    { MODKEY|ShiftMask,             XK_m,                      togglefloating, {0} },
    { MODKEY|ShiftMask,             XK_y,                      togglefakefullscreen, {0} },
    { MODKEY,                       XK_Up,                     spawn,          SHCMD ("xbacklight -inc 10 && dunstify -r 9992 -u low \"Brightness $(xbacklight -get | cut -d. -f1)%\"") },
    { MODKEY,                       XK_Down,                   spawn,          SHCMD ("xbacklight -dec 10 && dunstify -r 9992 -u low \"Brightness $(xbacklight -get | cut -d. -f1)%\"") },
    { MODKEY|ControlMask,           XK_Up,                     spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5% && vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}') && dunstify -r 9991 -u low \"Volume $vol\"") },
    { MODKEY|ControlMask,           XK_Down,                   spawn,          SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5% && vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1{print $5}') && dunstify -r 9991 -u low \"Volume $vol\"") },
    { MODKEY|ControlMask,           XK_m,                      spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle; muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'); dunstify -r 9991 -u low \"Output: $([ \"$muted\" = yes ] && echo Muted || echo Live)\"") },
    { MODKEY|ShiftMask,             XK_F5,                     spawn,          SHCMD("playerctl play-pause") },
    { MODKEY|ShiftMask,             XK_F6,                     spawn,          SHCMD("playerctl stop") },
    { MODKEY|ShiftMask,             XK_F7,                     spawn,          SHCMD("playerctl previous") },
    { MODKEY|ShiftMask,             XK_F8,                     spawn,          SHCMD("playerctl next") },
    { MODKEY|ShiftMask,             XK_g,                      spawn,          SHCMD("ghidra &") },
    { MODKEY|ShiftMask,             XK_v,                      spawn,          SHCMD("wireshark &") },
    { MODKEY|ShiftMask,             XK_d,                      spawn,          SHCMD("dunstctl set-paused toggle; state=$(dunstctl is-paused); dunstify -r 9993 \"Do Not Disturb: $([ \"$state\" = true ] && echo ON || echo OFF)\"") },
    { MODKEY|ShiftMask,             XK_u,                      spawn,          SHCMD("pactl set-source-mute @DEFAULT_SOURCE@ toggle; muted=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}'); dunstify -r 9990 \"Mic: $([ \"$muted\" = yes ] && echo Muted || echo Live)\"") },
    { MODKEY,                       XK_0,                      view,           {.ui = ~0 } },
    { MODKEY,                       XK_bracketleft,            shiftview,      {.i = -1 } },
    { MODKEY,                       XK_bracketright,           shiftview,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_bracketleft,            shifttag,       {.i = -1 } },
    { MODKEY|ShiftMask,             XK_bracketright,           shifttag,       {.i = +1 } },
    { MODKEY,                       XK_semicolon,              spawn,          SHCMD("rofimoji --selector rofi --action copy") },
    { MODKEY,                       XK_comma,                  focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period,                 focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,                  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period,                 tagmon,         {.i = +1 } },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
    { MODKEY|ShiftMask,             XK_q,                      quit,           {0} },
    { MODKEY|ControlMask,           XK_q,                      spawn,          SHCMD("$HOME/.config/rofi/powermenu.sh")},
    { MODKEY|ControlMask|ShiftMask, XK_r,                      spawn,          SHCMD("systemctl reboot")},
    { MODKEY|ControlMask|ShiftMask, XK_s,                      spawn,          SHCMD("systemctl suspend") },

    /* Browser - Qutebrowser */
    { MODKEY,                       XK_n,                      spawn,          SHCMD ("qutebrowser") },

    /* Quick picom toggle (transparency on/off) */
    { MODKEY|ShiftMask,             XK_c,                      spawn,          SHCMD ("$HOME/.config/dwm/scripts/picom-profile-toggle.sh") },

    /* Scratchpad terminal */
    { MODKEY,                       XK_grave,                  spawn,          SHCMD ("$HOME/.config/dwm/scripts/scratchpad.sh") },

    /* Night light toggle */
    { MODKEY|ShiftMask,             XK_n,                      spawn,          SHCMD ("$HOME/.config/dwm/scripts/toggle-nightlight.sh") },

    /* Display profile toggle (work/gaming) */
    { MODKEY|ShiftMask,             XK_x,                      spawn,          SHCMD ("$HOME/.config/dwm/scripts/toggle-xrandr-profile.sh") },

    /* Lid safety toggle when docked */
    { MODKEY|ShiftMask,             XK_F12,                    spawn,          SHCMD ("$HOME/.config/dwm/scripts/toggle-lid-inhibit.sh") },

    /* System monitor */
    { MODKEY,                       XK_Escape,                 spawn,          SHCMD ("kitty -e htop") },
  };

/*
 * Button definitions
 * click: ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin
 */
static Button buttons[] = {
    /* click          event mask  button  function    argument */
    { ClkTagBar,      MODKEY,     Button1, tag,          {0} },
    { ClkTagBar,      MODKEY,     Button3, toggletag,    {0} },
    { ClkClientWin,   MODKEY,     Button1, moveorplace,  {.i = 2} },
    { ClkClientWin,   MODKEY,     Button3, resizemouse,  {0} },
    { ClkTagBar,      0,          Button1, view,         {0} },
    { ClkTagBar,      0,          Button3, toggleview,   {0} },
};
