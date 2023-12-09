Config = Config or {}

Config.WindDirections = {
    -- Average Wind Speeds | The script handles the wind force
    ['NORTH']       = vector3(5.0, 25.0, 5.0),
    ['NORTHEAST']   = vector3(25.0, 25.0, 5.0),
    ['EAST']        = vector3(25.0, 5.0, 5.0),
    ['SOUTHEAST']   = vector3(25.0, -25.0, 5.0),
    ['SOUTH']       = vector3(5.0, -25.0, 5.0),
    ['SOUTHWEST']   = vector3(-25.0, -25.0, 5.0),
    ['WEST']        = vector3(-25.0, 5.0, 5.0),
    ['NORTHWEST']   = vector3(-25.0, 25.0, 5.0),
}

Config.AdvancedWeatherTypes = { -- Invalid no auto spawning atm
    'NONE',
    'LIGHTNING', 
    -- 'TORNADO', -- seperate resource (gd_tornado)
    'DUSTSTORM', -- this will be auto
    -- 'ALWAYSSNOW', -- /alwayssnow (so staff can set it)
}

Config.AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}

Config.DynamicWeather = {
    'EXTRASUNNY', 
    'EXTRASUNNY', 
    'EXTRASUNNY', 
    'EXTRASUNNY', 
    'EXTRASUNNY', 
    'EXTRASUNNY', 
    'CLEAR', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'OVERCAST', 
    'OVERCAST', 
    'CLOUDS', 
    'CLOUDS', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
}


Config.WindAnyProp = true
Config.WindProps = {
    [`prop_dumpster_01a`] = true,
    [`prop_dumpster_02b`] = true,
    [`prop_rub_binbag_03b`] = true,
    [`prop_rub_binbag_05`] = true,
    [`prop_rub_boxpile_04`] = true,
    [`prop_rub_boxpile_09`] = true,
    [`prop_rub_binbag_04`] = true,
    [`prop_bin_05a`] = true,
    [`prop_bin_01a`] = true,
    [`prop_news_disp_02a`] = true,
    [`prop_rub_binbag_06`] = true,
    [`prop_news_disp_01a`] = true,
    [`prop_bikerack_1a`] = true,
    [`prop_news_disp_03a`] = true,
    [`prop_rub_trolley01a`] = true,
    [`prop_rub_cardpile_03`] = true,
    [`prop_rub_cardpile_05`] = true,
    [`prop_bin_08a`] = true,
    [`prop_rub_couch03`] = true,
    [`prop_table_03b_chr`] = true,
    [`prop_bin_07a`] = true,
    [`prop_rub_pile_03`] = true,
    [`prop_rub_boxpile_01`] = true,
    [`prop_rub_boxpile_02`] = true,
    [`prop_roadcone02b`] = true,
    [`prop_wheel_tyre`] = true,
    [`prop_rub_boxpile_05`] = true,
    [`prop_rub_boxpile_05a`] = true,
    [`prop_boxpile_06b`] = true,
    [`prop_sacktruck_02b`] = true,
    [`prop_rub_trolley03a`] = true,
    [`prop_rub_cage01b`] =true,
    [`prop_cratepile_02a`] = true,
    [`prop_cratepile_01a`] = true,
    [`prop_roadcone01a`] = true,
    [`prop_table_03b`] = true,
    [`prop_cratepile_05a`] = true,
    [`prop_rub_binbag_03`] = true,
    [`prop_shopsign_01`] = true,
    [`prop_shopsign_02`] = true,
    [`prop_barrel_pile_03`] = true,
    [`prop_rub_binbag_01b`] = true,
    [`prop_cratepile_07`] = true,
    [`prop_cablespool_01a`] = true,
    [`prop_bench_05`] = true,
    [`prop_bench_09`] = true,
    [`prop_bench_1a`] =true,
    [`prop_wheelbarrow02a`] = true,
}

Config.WindForceProps = {
    [`prop_bench_05`] = 1.5,
    [`prop_bench_09`] = 1.5,
    [`prop_bench_1a`] = 1.5,
    [`prop_wheelbarrow02a`] = 1.5,
    [`prop_dumpster_01a`] = 1.5,
    [`prop_dumpster_02b`] = 1.5,
    [`prop_bin_05a`] = 1.5,
    [`prop_rub_trolley01a`] = 1.5,
    [`prop_boxpile_06b`] =1.5,
    [`prop_rub_cage01b`] = 1.5,
}

Config.WindDisableProp = {
    [`prop_keyboard_01a`] = true,
    [`v_ret_gc_folder1`] = true,
    [`v_ret_gc_folder2`] = true,
    [`v_res_paperfolders`] = true,
    [`prop_fire_exting_1a`] = true,
    [`prop_fax_01`] = true,
    [`v_corp_cd_chair`] = true,
}