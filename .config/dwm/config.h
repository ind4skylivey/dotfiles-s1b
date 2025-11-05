/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int refresh_rate        = 180;  /* matches dwm's mouse event processing to your monitor's refresh rate for smoother window interactions */
static const unsigned int enable_noborder     = 1;   /* toggles noborder feature (0=disabled, 1=enabled) */
static const unsigned int borderpx            = 3;   /* border pixel of windows */
static const unsigned int snap                = 10;  /* snap pixel */
static const int swallowfloating              = 1;   /* 1 means swallow floating windows by default */
static const unsigned int systraypinning      = 1;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft       = 0;   /* 0: systray in the right corner, >0: s:systray on left of status text */
static const unsigned int systrayspacing      = 8;   /* systray spacing */
static const int systraypinningfailfirst      = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor */
static const int showsystray                  = 1;   /* 0 means no systray */
static const int showbar                      = 1;   /* 0 means no bar */
static const int topbar                       = 1;   /* 0 means bottom bar */
#define ICONSIZE                              10    /* icon size */
#define ICONSPACING                           4      /* space between icon and title */
#define SHOWWINICON                           1      /* 0 means no winicon */
static const char *fonts[]                    = { "MesloLGS Nerd Font Mono:size=11", "NotoColorEmoji:pixelsize=11:antialias=true:autohint=true" };
// Change these lines:
static const char normbordercolor[]       = "#7b3ff2";  // Dark purple for inactive window border
static const char normbgcolor[]           = "#5d2a5c";  // Dark purple background
static const char normfgcolor[]           = "#cdd6f4";  // Light text for inactive windows
static const char selbordercolor[]        = "#cba6f7";  // Bright purple border for active window (Catppuccin Mauve)
static const char selbgcolor[]            = "#b4befe";  // Light purple background for active window (Catppuccin Lavender)
static const char selfgcolor[]            = "#1e1e2e";  // Dark text for active window foreground




static const char *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
    [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor },
};

static const char *const autostart[] = {
    "xset", "s", "off", NULL,
    "xset", "s", "noblank", NULL,
    "xset", "-dpms", NULL,
    "dbus-update-activation-environment", "--systemd", "--all", NULL,
    "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1", NULL,
    "flameshot", NULL,
    "sh", "-c", "openrgb --startminimized &", NULL,
    "sh", "-c", "emacs --daemon &", NULL,
    "sh", "-c", "legcord &", NULL,
    "dunst", NULL,
    "xset", "r", "rate", "300", "50", NULL,  // Keyboard repeat rate faster
    "picom", "-b", NULL,
    "sh", "-c", "feh --randomize --bg-fill ~/Pictures/backgrounds/*", NULL,
    "synergy", NULL,
    "slstatus", NULL,
    "xrandr", "--output", "DisplayPort-0", "--primary", "--mode", "1920x1080", "--rate", "180",
    "--output", "DisplayPort-1", "--mode", "1920x1080", "--rate", "60", "--left-of", "DisplayPort-0", "--rotate", "left", "--pos", "0x0",
    "--output", "HDMI-A-0", "--mode", "1920x1080", "--rate", "60", "--above", "DisplayPort-0", "--pos", "0x1080",
    NULL,
    NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "", "", "󰊖", "", "" };

static const char ptagf[] = "[%s %s]";  /* format of a tag label */
static const char etagf[] = "[%s]";     /* format of an empty tag */
static const int lcaselbl = 0;          /* 1 means make tag label lowercase */

static const Rule rules[] = {
    /* class                instance  title                 tags mask  isfloating  isterminal  noswallow  monitor */
    { "St",                 NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "kitty",              NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "Alacritty",          NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "terminator",         NULL,     NULL,                    0,         0,          1,          0,         0 },
    { "lutris",             NULL,     NULL,                    0,         1,          0,          0,         0 },
    { "steam_app_default",  NULL,     NULL,                    0,         1,          0,          0,         0 },
    { "dolphin",            NULL,     NULL,                    0,         1,          0,          0,         0 },
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
    { "",      tile },    /* first entry is default */
    { "",      NULL },    /* no layout function means floating behavior */
    { "",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR "dwmblocks"
/* commands */
static const char *launchercmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]     = { "kitty", NULL };

static Key keys[] = {
    /* modifier                     key                        function        argument */
    { MODKEY,                       XK_z,                      spawn,          {.v = launchercmd} },
    { MODKEY|ControlMask,           XK_r,                      spawn,          SHCMD ("protonrestart")},
    { MODKEY,                       XK_x,                      spawn,          {.v = termcmd } },
    { MODKEY,                       XK_b,                      spawn,          SHCMD ("xdg-open https://")},
    { MODKEY,                       XK_p,                      spawn,          SHCMD ("flameshot full -p ~/Screenshots/")},
    { MODKEY|ShiftMask,             XK_p,                      spawn,          SHCMD ("flameshot gui -p ~/Screenshots/")},
    { MODKEY|ControlMask,           XK_p,                      spawn,          SHCMD ("flameshot gui --clipboard")},
    { 0,                            XK_Print,                  spawn,          SHCMD ("flameshot gui")},  // Print key = GUI
    { MODKEY,                       XK_e,                      spawn,          SHCMD ("pcmanfm-qt")},
    { MODKEY,                       XK_w,                      spawn,          SHCMD ("looking-glass-client -F")},
    { MODKEY|ShiftMask,             XK_w,                      spawn,          SHCMD ("feh --randomize --bg-fill ~/Pictures/backgrounds/*")},
    { 0,                            XF86XK_MonBrightnessUp,    spawn,          SHCMD ("xbacklight -inc 10")},
    { 0,                            XF86XK_MonBrightnessDown,  spawn,          SHCMD ("xbacklight -dec 10")},
    { 0,                            XF86XK_AudioLowerVolume,   spawn,          SHCMD ("amixer sset Master 5%- unmute")},
    { 0,                            XF86XK_AudioMute,          spawn,          SHCMD ("amixer sset Master $(amixer get Master | grep -q '\\[on\\]' && echo 'mute' || echo 'unmute')")},
    { 0,                            XF86XK_AudioRaiseVolume,   spawn,          SHCMD ("amixer sset Master 5%+ unmute")},
    { MODKEY|ShiftMask,             XK_b,                      togglebar,      {0} },
    { MODKEY,                       XK_j,                      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,                      focusstack,     {.i = -1 } },
    { MODKEY|ShiftMask,             XK_j,                      movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_k,                      movestack,      {.i = -1 } },
    { MODKEY,                       XK_i,                      incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_d,                      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,                      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,                      setmfact,       {.f = +0.05} },
    { MODKEY|ShiftMask,             XK_h,                      setcfact,       {.f = +0.25} },
    { MODKEY|ShiftMask,             XK_l,                      setcfact,       {.f = -0.25} },
    { MODKEY|ShiftMask,             XK_o,                      setcfact,       {.f =  0.00} },
    { MODKEY,                       XK_Return,                 zoom,           {0} },
    { MODKEY|ShiftMask,             XK_l,                      spawn,          SHCMD("/home/il1v3y/lockscreen.sh") },
    { MODKEY,                       XK_Tab,                    view,           {0} },
    { MODKEY,                       XK_q,                      killclient,     {0} },
    { MODKEY,                       XK_t,                      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_f,                      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_m,                      fullscreen,     {0} },
    { MODKEY,                       XK_space,                  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_m,                      togglefloating, {0} },
    { MODKEY|ShiftMask,             XK_y,                      togglefakefullscreen, {0} },
    { MODKEY,                       XK_0,                      view,           {.ui = ~0 } },
    { MODKEY,                       XK_comma,                  focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period,                 focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,                  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period,                 tagmon,         {.i = +1 } },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    { MODKEY|ShiftMask,             XK_q,                      quit,           {0} },
    { MODKEY|ControlMask,           XK_q,                      spawn,          SHCMD("$HOME/.config/rofi/powermenu.sh")},
    { MODKEY|ControlMask|ShiftMask, XK_r,                      spawn,          SHCMD("systemctl reboot")},
    { MODKEY|ControlMask|ShiftMask, XK_s,                      spawn,          SHCMD("systemctl suspend")},
    // Browser - Zen Browser
  { MODKEY, XK_n, spawn, SHCMD ("zen-browser")},  // Super+n = Zen Browser

  // Quick picom toggle (transparency on/off)
  { MODKEY|ShiftMask, XK_c, spawn, SHCMD ("pkill picom || picom -b")},
  
  // System monitor
  { MODKEY, XK_Escape, spawn, SHCMD ("kitty -e htop")},
  };

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
    { ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 2} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
