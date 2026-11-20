-- widget demo

local progress_val = 0
local log_text = "App started.\n"

shinx.gui_register(
    "widgetdemo",
    "Widget Demo",
    "__wd_draw",
    "__wd_key",
    120, 80,
    460, 380,
    "__wd_resize",
    true
)

shinx.gui_bounds("widgetdemo", 320, 300, 900, 700)

function __wd_draw()
    local w = shinx.gui_width()
    local h = shinx.gui_height()

    shinx.gui_rectfill(0, 0, w, h, "lightgray")

    shinx.gui_label(10, 8, "Widget Demo", "black")
    shinx.gui_line(0, 24, w, 24, "darkgray")

    local input_w = math.max(80, math.min(180, w - 210))
    local greet_x = 70 + input_w + 10

    shinx.gui_label(10, 34, "Name:", "black")
    local name = shinx.gui_input("name_field", 60, 30, input_w, "enter name...", "black", "white", "darkgray")

    if shinx.gui_button(greet_x, 30, 100, 22, "Greet", "darkblue", "cyan", "white") then
        if name ~= "" then
            log_text = log_text .. "Hello, " .. name .. "!\n"
        else
            log_text = log_text .. "Please enter a name.\n"
        end
    end

    shinx.gui_label(10, 65, "Options:", "black")
    local loud    = shinx.gui_checkbox("opt_loud",    10, 82,  "Loud mode")
    local verbose = shinx.gui_checkbox("opt_verbose", 10, 104, "Verbose")

    local status_x = math.max(170, w - 130)
    if shinx.gui_button(status_x, 82, 120, 22, "Log status", "darkgreen", "white", "white") then
        local msg = "Status: "
        if loud    then msg = msg .. "[LOUD] "    end
        if verbose then msg = msg .. "[VERBOSE] " end
        if not loud and not verbose then msg = msg .. "normal" end
        log_text = log_text .. msg .. "\n"
    end

    shinx.gui_label(10, 136, "Progress:", "black")
    shinx.gui_progressbar(10, 154, w - 20, 22, progress_val, 100, "cyan")

    if shinx.gui_button(10,  184, 80, 22, "+10",   "gray",    "white", "white") then
        progress_val = math.min(100, progress_val + 10)
    end
    if shinx.gui_button(100, 184, 80, 22, "Reset", "darkred", "white", "white") then
        progress_val = 0
    end

    shinx.gui_line(0, 215, w, 215, "darkgray")

    shinx.gui_label(10, 220, "Log:", "black")
    local log_h = h - 248
    if log_h < 20 then log_h = 20 end
    shinx.gui_textbox(10, 238, w - 20, log_h, log_text, "black", "white", "darkgray")
end

function __wd_key(key)
    if key.key == "Escape" then
        shinx.gui_close("widgetdemo")
    end
end

function __wd_resize(w, h)
end
