local ABW = function(key)
    -- angle bracket wrapper
    return '<' .. key  .. '>';
end

local CtrlWith = function(char)
    return string.format(ABW 'C-%s', char);
end

return {
    ENTER = ABW 'CR',
    ESC   = ABW 'Esc',
    SPACE = ABW 'Space',

    CtrlWith = CtrlWith,
};
