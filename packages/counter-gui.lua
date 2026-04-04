-- counter app 

local count = 0
local btn_x, btn_y, btn_w, btn_h = 20, 60, 120, 30
local was_clicked = false

shinx.gui_register(
    "counter-gui",
    "Counter",          
    "__counter_draw",   
    "__counter_key",    
    200, 150,           
    300, 180            
)

function __counter_draw()
    local w = shinx.gui_width()

    shinx.gui_text(10, 10, "Count: " .. count, "black")

    local clicked = shinx.gui_click()
    local mx, my  = shinx.gui_mouse()
    local hover   = mx >= btn_x and mx <= btn_x + btn_w
                and my >= btn_y and my <= btn_y + btn_h

    shinx.gui_rectfill(btn_x, btn_y, btn_w, btn_h, hover and "cyan" or "gray")
    shinx.gui_rect(btn_x, btn_y, btn_w, btn_h, "black")
    shinx.gui_text(btn_x + 30, btn_y + 8, "Click me", "black")

    if clicked and hover then
        if not was_clicked then
            count = count + 1
            was_clicked = true
        end
    else
        was_clicked = false
    end

    shinx.gui_rectfill(btn_x, btn_y + 40, btn_w, btn_h, "darkred")
    shinx.gui_rect(btn_x, btn_y + 40, btn_w, btn_h, "white")
    shinx.gui_text(btn_x + 35, btn_y + 48, "Reset", "white")

    if clicked and mx >= btn_x and mx <= btn_x + btn_w
               and my >= btn_y + 40 and my <= btn_y + 70 then
        count = 0
    end
end

function __counter_key(key)
    if key.key == "Escape" then
        shinx.gui_close("counter")
    end
    if key.key == "Add" or key.char == "+" then
        count = count + 1
    end
    if key.key == "Subtract" or key.char == "-" then
        count = count - 1
    end
end
