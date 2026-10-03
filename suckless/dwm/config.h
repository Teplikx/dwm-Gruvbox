#include <X11/XF86keysym.h>

/* Parameters */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 10;       /* gaps between windows */
static const unsigned int snap      = 16;       /* snap pixel */

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

/* Rice */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:style=Regular:size=11:antialias=true:autohint=true" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:style=Regular:size=11:antialias=true:autohint=true";

static const char col_gray1[]       = "#282828";    /* Фон статус-бару (bg0) */
static const char col_gray2[]       = "#3c3836";    /* Рамка неактивних вікон (темна) */
static const char col_gray3[]       = "#a89984";    /* Текст неактивних тегів (gray) */
static const char col_gray4[]       = "#fbf1c7";    /* Світлий текст */
static const char col_orange[]      = "#fe8019";    /* Акцентний помаранчевий */

static const char *colors[][3]      = {
    /*               fg          bg          border   */
    [SchemeNorm] = { col_gray3,  col_gray1,  col_gray2 },
    [SchemeSel]  = { col_gray1,  col_orange, col_orange }, /* Темний текст поверх оранжевого = чіткий контраст */
};

static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9"};

/* Don't use */
static const Rule rules[] = {
    /* class      instance    title       tags mask     isfloating   monitor */
    { NULL,       NULL,       NULL,       0,            1,           -1 },
};

static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;   
static const int lockfullscreen = 1; 
static const int refreshrate = 120;  

static const Layout layouts[] = {
	{"󰣇 ",      NULL },   
};

/* Macros */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
static char dmenumon[2] = "0";

/* Commands */
static const char *screnshoot[] = { "flameshoot", "gui", NULL };
static const char *wallpapers[] = { "variety", "--selector", NULL };

static const char *dmenucmd[]   = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_orange, "-sf", col_gray4, NULL };
static const char *termcmd[]    = { "st", NULL };

static const char *volumeup[]   = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+1%", NULL };
static const char *volumedown[] = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-1%", NULL };

static const char *brightup[] 	= { "brightnessctl", "set", "1+%", NULL };
static const char *brightdown[] = { "brightnessctl", "set", "1-%", NULL };

static const Key keys[] = {

	/* Commands */
	{ 0,                            XF86XK_AudioLowerVolume, 	   spawn,    {.v = volumedown } },
	{ 0, 			        XF86XK_AudioRaiseVolume, 	   spawn,    {.v = volumeup   } },
	{ 0,                            XF86XK_MonBrightnessUp, 	   spawn,    {.v = brightup   } },
	{ 0,                            XF86XK_MonBrightnessDown,	   spawn,    {.v = brightdown } },

	/* Programs */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd   } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd    } },
	{ MODKEY|ShiftMask,		XK_s,      spawn,	   {.v = screnshoot } },
	{ MODKEY,			XK_w,	   spawn,	   {.v = wallpapers } },

	/* Window managment */
	{ MODKEY|ShiftMask,             XK_q, killclient,     {0} },
	
	/* Worspackes */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	
	/* Quit */
	{ MODKEY|ShiftMask,             XK_r,      quit,           {0} },
};

static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
