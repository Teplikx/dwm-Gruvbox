static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */

static const char *fonts[] = {
        "JetBrainsMono Nerd Font:style=Regular:size=11:antialias=true:autohint=true"
};

static const char *prompt      = " ";

static const char *colors[SchemeLast][2] = {
	/*               fg         bg       */
	[SchemeNorm] = { "#cdd6f4", "#1e1e2e" }, /* Текст (Text) на темному фоні (Base) */
	[SchemeSel]  = { "#1e1e2e", "#89b4fa" }, /* Темний текст (Base) на синьому фоні (Blue) */
	[SchemeOut]  = { "#1e1e2e", "#89dceb" }, /* Темний текст (Base) на блакитному (Sky) */
};

static unsigned int lines      = 3;

static const char worddelimiters[] = " ";
