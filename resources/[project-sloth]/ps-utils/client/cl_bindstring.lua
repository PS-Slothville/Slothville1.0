-- https://gist.github.com/DemmyDemon/69d53b78b005a7c1a6fdb9036e401f4c
--[[
    ↑ <kbd>&uarr;</kbd>
    ↓ <kbd>&darr;</kbd>
    ← <kbd>&larr;</kbd>
    → <kbd>&rarr;</kbd>

    Ⓐ &#x24B6;
    Ⓑ &#x24B7;
    Ⓒ &#x24B8;
    Ⓛ &#x24C1;
    Ⓞ &#x24C4;
    Ⓡ &#x24C7;
    Ⓤ &#x24CA;
    Ⓧ &#x24CD;
    Ⓨ &#x24CE;
    Ⓩ &#x24CF;
    ⓐ &#x24D0;
    ⓑ &#x24D1;
    ⓒ &#x24D2;
    ⓧ &#x24E7;
    ⓨ &#x24E8;
    ⓩ &#x24E9;
    △ &#x25B3;
    ○ &#x25CB;
    ✕ &#x2715;
    □ &#x25A1;
    ① &#x2460;
    ② &#x2461;
    ◉ &#x25C9;

    L <kbd>L</kbd>
    R <kbd>R</kbd>
    L1 <kbd>L1</kbd>
    L2 <kbd>L2</kbd>
    R1 <kbd>R1</kbd>
    R2 <kbd>R2</kbd>
    + <kbd>+</kbd>
    - <kbd>-</kbd>
    home <kbd>home</kbd>
    options <kbd>options</kbd>
    select <kbd>select</kbd>
    share <kbd>share</kbd>
    start <kbd>start</kbd>
]]

local myControl = "xbox"

RegisterCommand("setcontroller", function(s,a)
    if allowed_controllers[a[1]] then
        myControl = a[1]
    else 
        print("'xbox' or 'ps' only work pls")
    end
end)

local allowed_controllers = {
    ["xbox"] = {
        b_30 = "Ⓐ",
        b_31 = "Ⓑ",
        b_32 = "Ⓧ",
        b_33 = "Ⓨ",
        b_34 = "LB",
        b_35 = "LT",
        b_36 = "RB",
        b_37 = "RT",
    },
    ["ps"] = {
        b_30 = "✕",
        b_31 = "○",
        b_32 = "□",
        b_33 = "△",
        b_34 = "L1",
        b_35 = "L2",
        b_36 = "R1",
        b_37 = "R2",
    },
}


local BINDSTRING = {
    -- [[ TODO: All the controller stuff
    b_0 = '',
    b_1 = '',
    b_2 = '',
    b_3 = '',
    b_4 = '↑',
    b_5 = '↓',
    b_6 = '←',
    b_7 = '→',
    b_8 = '',
    b_9 = '',
    b_10 = '',
    b_11 = '',
    b_12 = '',
    b_13 = '',
    b_14 = '',
    b_15 = '',
    b_16 = '',
    b_17 = '',
    b_18 = '',
    b_19 = 'L◉', -- 'LEFT ANALOG STICK IN',
    b_20 = '',
    b_21 = '',
    b_22 = '',
    b_23 = '',
    b_24 = '',
    b_25 = 'R◉', -- 'RIGHT ANALOG STICK IN',
    b_26 = '',
    b_27 = '',
    b_28 = '',
    b_29 = '',
    b_30 = allowed_controllers[myControl].b_30,
    b_31 = allowed_controllers[myControl].b_31,
    b_32 = allowed_controllers[myControl].b_32,
    b_33 = allowed_controllers[myControl].b_33,
    b_34 = allowed_controllers[myControl].b_34,
    b_35 = allowed_controllers[myControl].b_35,
    b_36 = allowed_controllers[myControl].b_36,
    b_37 = allowed_controllers[myControl].b_37,
    b_38 = '①', -- 'PAUSE BUTTON',
    b_39 = '②', -- 'SHARE BUTTON',
    b_40 = '',
    b_41 = '',
    b_42 = '',
    b_43 = '',
    b_44 = '',
    b_45 = '',
    b_46 = '',
    b_47 = '',
    --]]
    b_100 = 'Mouse 1',
    b_101 = 'Mouse 2',
    b_102 = 'Mouse 3',
    b_103 = 'Mouse 4',
    b_104 = 'Mouse 5',
    b_105 = 'Mouse 6',
    b_106 = 'Mouse 7',
    b_107 = 'Mouse 8',
    b_108 = 'Mouse left',
    b_109 = 'Mouse right',
    b_110 = 'Mouse up',
    b_111 = 'Mouse down',
    b_112 = 'Mouse left/right',
    b_113 = 'Mouse up/down',
    b_114 = 'Mouse',
    b_115 = 'Scroll up',
    b_116 = 'Scroll down',
    b_117 = 'Scroll wheel',
    b_130 = 'Num -',
    b_131 = 'Num +',
    b_132 = 'Num .',
    b_133 = 'Num /',
    b_134 = 'Num *',
    b_135 = 'Num Enter', -- FIXME Fonts do not have ↲ in them
    b_136 = 'Num 0',
    b_137 = 'Num 1',
    b_138 = 'Num 2',
    b_139 = 'Num 3',
    b_140 = 'Num 4',
    b_141 = 'Num 5',
    b_142 = 'Num 6',
    b_143 = 'Num 7',
    b_144 = 'Num 8',
    b_145 = 'Num 9',
    b_146 = 'Num =',
    b_147 = 'Num ,',
    b_148 = 'Num ÷', -- FIXME Do the fonts have ÷ in them?
    b_149 = 'Num x',
    b_150 = 'Intro',
    b_151 = '???',-- FIXME some sort of upper line?!
    b_170 = 'F1',
    b_171 = 'F2',
    b_172 = 'F3',
    b_173 = 'F4',
    b_174 = 'F5',
    b_175 = 'F6',
    b_176 = 'F7',
    b_177 = 'F8',
    b_178 = 'F9',
    b_179 = 'F10',
    b_180 = 'F11',
    b_181 = 'F12',
    b_182 = 'F13',
    b_183 = 'F14',
    b_184 = 'F15',
    b_185 = 'F16',
    b_186 = 'F17',
    b_187 = 'F18',
    b_188 = 'F19',
    b_189 = 'F20',
    b_190 = 'F21',
    b_191 = 'F22',
    b_192 = 'F23',
    b_193 = 'F24',
    b_194 = 'Up Arrow',
    b_195 = 'Down Arrow',
    b_196 = 'Left Arrow',
    b_197 = 'Right Arrow',
    b_198 = 'Del',
    b_199 = 'Esc',
    b_200 = 'Ins',
    b_201 = 'End',
    b_202 = 'Suppr',
    b_203 = 'Échap',
    b_204 = 'Fin',
    b_205 = 'Entf',
    b_206 = 'Einfg',
    b_207 = 'Ende',
    b_208 = 'Canc',
    b_209 = 'Fine',
    b_210 = 'Supr',
    b_211 = 'Insertar',
    b_212 = 'Fin',
    b_213 = 'Supr',
    b_214 = 'Insertar',
    b_215 = 'Fin',
    b_216 = '¨',
    b_217 = '`',
    b_995 = '???', -- Literally says so on the sprite. In red.
    --b_996 = '', -- Button outline sprite
    --b_997 = '', -- Button outline sprite
    b_998 = '+', -- The + in things like Ctrl+A?
    --b_999 = '', -- Button outline sprite
    b_1000 = 'L Shift', -- FIXME Fonts do not have ⇑ in them. What can be used for Shift?
    b_1001 = 'R Shift', -- FIXME Same problem as above
    b_1002 = 'Tab',
    b_1003 = 'Enter', -- FIXME Common key, undrawable glyph. Fonts to not have ↲ in them.
    b_1004 = 'Backspace', -- FIXME ← is easily confused with left arrow...
    b_1005 = 'Print Screen',
    b_1006 = 'Scroll Lock',
    b_1007 = 'Pause',
    b_1008 = 'Home',
    b_1009 = 'Page Up',
    b_1010 = 'Page Down',
    b_1011 = 'Num Lock',
    b_1012 = 'Caps',
    b_1013 = 'L Ctrl',
    b_1014 = 'R Ctrl',
    b_1015 = 'L Alt',
    b_1016 = 'R Alt',
    b_1017 = 'Menu',
    b_1018 = 'L Win',
    b_1019 = 'R Win',
    b_1020 = 'Imppr écran',
    b_1021 = 'Arrèt défil',
    b_1022 = '↖', -- TODO Check if the fonts have this symbol.
    b_1023 = '⇞', -- TODO Do the fonts even have this symbol? What *is* this?
    b_1024 = '⇟', -- TODO Do the fonts even have this symbol? What *is* this?
    b_1025 = 'Verr Numm',
    b_1026 = 'Verr Maj',
    b_1027 = 'Ctrl G',
    b_1028 = 'Ctrl D',
    b_1029 = 'Druck',
    b_1030 = 'Rollen ↓',
    b_1031 = 'Pos 1',
    b_1032 = 'Bild ↑',
    b_1033 = 'Bild ↓',
    b_1034 = 'Num ↓',
    b_1035 = '⇓', -- TODO Probably an invisible glyph again. WTF even is this?
    b_1036 = 'Strg L',
    b_1037 = 'Strg R',
    b_1038 = 'Maiusc sx',
    b_1039 = 'Maiusc dx',
    b_1040 = 'Invio',
    b_1041 = 'Stampa',
    b_1042 = 'Bloc Scorr',
    b_1043 = 'Pausa',
    b_1044 = '↖', -- TODO Do the fonts even have this symbol? What *is* this?
    b_1045 = 'Pag ↑',
    b_1046 = 'Pag ↓',
    b_1047 = 'Bloc Num',
    b_1048 = 'Bloc Maiusc',
    b_1049 = 'Ctrl sx',
    b_1050 = 'Ctrl dx',
    b_1051 = 'Alt gr',
    b_1052 = 'Impr Pant',
    b_1053 = 'Bloq Despl',
    b_1054 = 'Pausa',
    b_1055 = 'Inicio',
    b_1056 = 'Re Pág',
    b_1057 = 'Av Pág',
    b_1058 = 'Bloq Num',
    b_1059 = 'Bloq Mayús',
    b_1060 = 'Ctrl I',
    b_1061 = 'Ctrl D',
    b_1062 = 'Menú',
    b_1063 = 'Impr Pant',
    b_1064 = 'Bloq Despl',
    b_1065 = 'Pausa',
    b_1066 = 'Inicio',
    b_1067 = 'Re Pág',
    b_1068 = 'Av Pág',
    b_1069 = 'Bloq Num',
    b_1070 = 'Mayús',
    b_1071 = 'Opsciones',
    b_1072 = 'Maj G',
    b_1073 = 'Maj D',
    b_1074 = 'Alt',
    b_1075 = 'Alt D',
    b_1076 = 'I Shift',
    b_1077 = 'D Shift',
    b_2000 = 'Space',
}

function pBindString(group,key,bool)
    local rawButtonString = GetControlInstructionalButton(group,key,bool)
    local justKey = rawButtonString:gsub("^t_", "")
    if rawButtonString ~= justKey then
        return justKey
    else
        if BINDSTRING[rawButtonString] then
            return BINDSTRING[rawButtonString]
        else
            return rawButtonString
        end
    end
end