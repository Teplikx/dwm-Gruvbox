const unsigned int interval = 100;

static const char unknown_str[] = "?";

#define MAXLEN 6048

static const struct arg args[] = {
        { battery_perc,    " |   %s%% | ", "BAT0" },
        { run_command,     "  %s | ",   "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%.0f%%\", $2 * 100}'" },
        { keymap,          "󰌌  %s | ",  NULL },
        { datetime,        "󰥔  %s | ",  "%H:%M" },
        { datetime,        "  %s |",     "%F" },
};
