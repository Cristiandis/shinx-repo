-- counter app

local count = 0
local was_clicked = false

shinx.gui_register(
    "counter-gui",
    "Counter",
    "__counter_draw",
    "__counter_key",
    200, 150,
    300, 180,
    "__counter_resize",
    true
)

shinx.gui_bounds("counter-gui", 220, 140, 640, 420)

function __counter_draw()
    local w = shinx.gui_width()
    local h = shinx.gui_height()

    local btn_w = math.max(80, math.min(160, w - 20))
    local btn_h = 30
    local btn_x = math.floor((w - btn_w) / 2)
    local btn_y = math.floor(math.max(45, (h - 70) / 2))
    if btn_x < 10 then btn_x = 10 end

    local reset_y = btn_y + 40

    shinx.gui_label(10, 10, "Count: " .. count, "black")

    local clicked = shinx.gui_click()
    local mx, my = shinx.gui_mouse()
    local hover = mx >= btn_x and mx <= btn_x + btn_w
               and my >= btn_y and my <= btn_y + btn_h

    shinx.gui_rectfill(btn_x, btn_y, btn_w, btn_h, hover and "cyan" or "gray")
    shinx.gui_rect(btn_x, btn_y, btn_w, btn_h, "black")
    shinx.gui_label(btn_x + math.floor((btn_w - 40) / 2), btn_y + 8, "Click me", "black")

    if clicked and hover then
        if not was_clicked then
            count = count + 1
            was_clicked = true
        end
    else
        was_clicked = false
    end

    shinx.gui_rectfill(btn_x, reset_y, btn_w, btn_h, "darkred")
    shinx.gui_rect(btn_x, reset_y, btn_w, btn_h, "white")
    shinx.gui_label(btn_x + math.floor((btn_w - 25) / 2), reset_y + 8, "Reset", "white")

    if clicked and mx >= btn_x and mx <= btn_x + btn_w
               and my >= reset_y and my <= reset_y + btn_h then
        count = 0
    end
end

function __counter_key(key)
    if key.key == "Escape" then
        shinx.gui_close("counter-gui")
    end
    if key.key == "Add" or key.char == "+" then
        count = count + 1
    end
    if key.key == "Subtract" or key.char == "-" then
        count = count - 1
    end
end

function __counter_resize(w, h)
end
