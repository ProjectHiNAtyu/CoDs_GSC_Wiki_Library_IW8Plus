// scripts\common\scriptable.gsc  (hash_70a710e9c0b2022d.gscc) (size: 7351 Bytes / 0x1cb7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x445bfc60 (1146879072)
// size ...... 7351 (0x1cb7)
// includes .. 1   (offset: 0x1caf)
// strings ... 0   (offset: 0x1cb7)
// dev strs .. 0   (offset: 0x1cb7)
// exports ... 46  (offset: 0x133b)
// cseg ...... 0x90 + 0x12ab (0x133b)
// imports ... 18  (offset: 0x1a6b)
// animtree1 . 0   (offset: 0x1cb7)
// animtree2 . 0   (offset: 0x1cb7)
#using scripts\common\scriptable;

#namespace scriptable;

// Namespace scriptable/scriptable_init
// Params 0, eflags: 0x20
// Checksum 0x59034803, Offset: 0xae
// Size: 0x9
function event_handler[scriptable_init] scriptable_initialize()
{
    scriptable_engineinitialize();
}

// Namespace scriptable/scriptable_postinit
// Params 0, eflags: 0x20
// Checksum 0x79f7b69e, Offset: 0xbf
// Size: 0x9
function event_handler[scriptable_postinit] scriptable_post_initialize()
{
    scriptable_enginepostinitialize();
}

// Namespace scriptable/scriptable_used
// Params 6, eflags: 0x20
// Checksum 0x5c1ce20c, Offset: 0xd0
// Size: 0x48
function event_handler[scriptable_used] scriptable_used( instance, part, state, player, bautouse, usestring )
{
    scriptable_engineused( instance, part, state, player, bautouse, usestring );
}

// Namespace scriptable
// Params 1
// Checksum 0xf33c5548, Offset: 0x120
// Size: 0x39
function scriptable_addautousecallback( usecallback )
{
    if ( !isdefined( level.scriptable_autouse_funcs ) )
    {
        level.scriptable_autouse_funcs = [];
    }
    
    level.scriptable_autouse_funcs[ level.scriptable_autouse_funcs.size ] = usecallback;
}

// Namespace scriptable
// Params 1
// Checksum 0xecf02368, Offset: 0x161
// Size: 0x39
function function_956535bbfd32b7d6( canbeusedcallback )
{
    if ( !isdefined( level.var_c600434e0043e180 ) )
    {
        level.var_c600434e0043e180 = [];
    }
    
    level.var_c600434e0043e180[ level.var_c600434e0043e180.size ] = canbeusedcallback;
}

// Namespace scriptable
// Params 1
// Checksum 0x6f1dc62b, Offset: 0x1a2
// Size: 0x39
function scriptable_adddamagedcallback( damagedcallback )
{
    if ( !isdefined( level.scriptable_damaged_funcs ) )
    {
        level.scriptable_damaged_funcs = [];
    }
    
    level.scriptable_damaged_funcs[ level.scriptable_damaged_funcs.size ] = damagedcallback;
}

// Namespace scriptable
// Params 2
// Checksum 0x1c630898, Offset: 0x1e3
// Size: 0x64
function scriptable_addnotifycallback( funckey, func )
{
    if ( !isdefined( level.scriptable_notify_callback_funcs ) )
    {
        level.scriptable_notify_callback_funcs = [];
    }
    
    if ( !isdefined( level.scriptable_notify_callback_funcs[ funckey ] ) )
    {
        level.scriptable_notify_callback_funcs[ funckey ] = [];
    }
    
    level.scriptable_notify_callback_funcs[ funckey ][ level.scriptable_notify_callback_funcs[ funckey ].size ] = func;
}

// Namespace scriptable
// Params 1
// Checksum 0x3f0286f5, Offset: 0x24f
// Size: 0x39
function scriptable_addpostinitcallback( callback )
{
    if ( !isdefined( level.scriptable_postinit ) )
    {
        level.scriptable_postinit = [];
    }
    
    level.scriptable_postinit[ level.scriptable_postinit.size ] = callback;
}

// Namespace scriptable
// Params 1
// Checksum 0x1cb0f8a4, Offset: 0x290
// Size: 0x39
function function_c1b772bddb62be66( var_1be521526c5ef145 )
{
    if ( !isdefined( level.var_27e161a3bcab8269 ) )
    {
        level.var_27e161a3bcab8269 = [];
    }
    
    level.var_27e161a3bcab8269[ level.var_27e161a3bcab8269.size ] = var_1be521526c5ef145;
}

// Namespace scriptable
// Params 1
// Checksum 0x84cbab97, Offset: 0x2d1
// Size: 0x39
function function_be440da6d723d8e8( var_56e0bbdb3bc87831 )
{
    if ( !isdefined( level.var_2f3d3eb6b16bc8b2 ) )
    {
        level.var_2f3d3eb6b16bc8b2 = [];
    }
    
    level.var_2f3d3eb6b16bc8b2[ level.var_2f3d3eb6b16bc8b2.size ] = var_56e0bbdb3bc87831;
}

// Namespace scriptable
// Params 1
// Checksum 0xe36c5cac, Offset: 0x312
// Size: 0x39
function scriptable_addtouchedcallback( touchedcallback )
{
    if ( !isdefined( level.scriptable_touched_funcs ) )
    {
        level.scriptable_touched_funcs = [];
    }
    
    level.scriptable_touched_funcs[ level.scriptable_touched_funcs.size ] = touchedcallback;
}

// Namespace scriptable
// Params 1
// Checksum 0x2cabbc57, Offset: 0x353
// Size: 0x39
function scriptable_addusedcallback( usedcallback )
{
    if ( !isdefined( level.scriptable_used_funcs ) )
    {
        level.scriptable_used_funcs = [];
    }
    
    level.scriptable_used_funcs[ level.scriptable_used_funcs.size ] = usedcallback;
}

// Namespace scriptable
// Params 2
// Checksum 0x7d93a599, Offset: 0x394
// Size: 0x64
function scriptable_addusedcallbackbypart( part, usedcallback )
{
    if ( !isdefined( level.scriptable_used_by_part_funcs ) )
    {
        level.scriptable_used_by_part_funcs = [];
    }
    
    if ( !isdefined( level.scriptable_used_by_part_funcs[ part ] ) )
    {
        level.scriptable_used_by_part_funcs[ part ] = [];
    }
    
    level.scriptable_used_by_part_funcs[ part ][ level.scriptable_used_by_part_funcs[ part ].size ] = usedcallback;
}

// Namespace scriptable
// Params 1
// Checksum 0x4d250907, Offset: 0x400
// Size: 0x39
function function_9a667ada3074523a( callback )
{
    if ( !isdefined( level.var_dc7848b4278e9d43 ) )
    {
        level.var_dc7848b4278e9d43 = [];
    }
    
    level.var_dc7848b4278e9d43[ level.var_dc7848b4278e9d43.size ] = callback;
}

// Namespace scriptable
// Params 2
// Checksum 0x4ddb116c, Offset: 0x441
// Size: 0x64
function function_b49bec4b67c1221e( part, usedcallback )
{
    if ( !isdefined( level.var_4e9ab6c139c9bf3b ) )
    {
        level.var_4e9ab6c139c9bf3b = [];
    }
    
    if ( !isdefined( level.var_4e9ab6c139c9bf3b[ part ] ) )
    {
        level.var_4e9ab6c139c9bf3b[ part ] = [];
    }
    
    level.var_4e9ab6c139c9bf3b[ part ][ level.var_4e9ab6c139c9bf3b[ part ].size ] = usedcallback;
}

// Namespace scriptable/scriptable_canbeused
// Params 4, eflags: 0x20
// Checksum 0x3254b919, Offset: 0x4ad
// Size: 0x33
function event_handler[scriptable_canbeused] scriptable_can_be_used( instance, part, state, player )
{
    return function_904787b1a7ed4f61( instance, part, state, player );
}

// Namespace scriptable
// Params 2
// Checksum 0x636f34d4, Offset: 0x4e9
// Size: 0x38, Type: bool
function function_cebc7347386f7824( instance, player )
{
    if ( !instance scriptablemaskallowed() )
    {
        return false;
    }
    
    if ( !instance function_50b79f4d4032e234( player ) )
    {
        return false;
    }
    
    instance function_6113853a877d5460( self );
    return true;
}

// Namespace scriptable/scriptable_usestarted
// Params 5, eflags: 0x20
// Checksum 0x34eaf2d4, Offset: 0x52a
// Size: 0x3e
function event_handler[scriptable_usestarted] scriptable_use_started( instance, part, state, player, useduration )
{
    function_190abcbcb4f3a47c( instance, part, state, player, useduration );
}

// Namespace scriptable
// Params 0
// Checksum 0xdcc33078, Offset: 0x570
// Size: 0x15
function function_f9c7d74d26bf4d0f()
{
    return level.gamemodebundle.var_92fbf9f74ca4163d;
}

// Namespace scriptable
// Params 4
// Checksum 0x8c72d2b6, Offset: 0x58e
// Size: 0xc3
function function_904787b1a7ed4f61( instance, part, state, player )
{
    result = 1;
    
    if ( isdefined( level.var_c600434e0043e180 ) )
    {
        foreach ( can_be_used_func in level.var_c600434e0043e180 )
        {
            result = result && [[ can_be_used_func ]]( instance, part, state, player );
        }
    }
    
    return result;
}

// Namespace scriptable
// Params 11
// Checksum 0xb2930801, Offset: 0x65a
// Size: 0x144
function scriptable_enginedamaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( isdefined( level.scriptable_damaged_funcs ) )
    {
        if ( function_f9c7d74d26bf4d0f() && level.var_e6d6d55c30c55761 )
        {
            idamage = [[ level.var_e6d6d55c30c55761 ]]( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
        }
        
        foreach ( used_func in level.scriptable_damaged_funcs )
        {
            [[ used_func ]]( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
        }
    }
    
    instance notify( #"scriptable_engine_damaged", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
}

// Namespace scriptable
// Params 2
// Checksum 0x5cce9ac9, Offset: 0x7a6
// Size: 0x41
function function_1e33a4f0f19aa3a( instance, player )
{
    result = 0;
    
    if ( isdefined( level.var_2f0a93f86990f4d4 ) )
    {
        result = [[ level.var_2f0a93f86990f4d4 ]]( instance, player );
    }
    
    return result;
}

// Namespace scriptable
// Params 0
// Checksum 0x5159e6, Offset: 0x7f0
// Size: 0x84
function scriptable_engineinitialize()
{
    if ( isdefined( level.scriptable_init ) )
    {
        foreach ( init_func in level.scriptable_init )
        {
            [[ init_func ]]();
        }
    }
}

// Namespace scriptable
// Params 5
// Checksum 0xf3634126, Offset: 0x87c
// Size: 0xef
function scriptable_enginenotifycallback( instance, note, param, ent, var_64ffacba090c91be )
{
    if ( !isdefined( level.scriptable_notify_callback_funcs ) )
    {
        return;
    }
    
    funcarray = level.scriptable_notify_callback_funcs[ note ];
    
    if ( !isdefined( funcarray ) || funcarray.size == 0 )
    {
        return;
    }
    
    foreach ( func in funcarray )
    {
        if ( isdefined( ent ) )
        {
            ent [[ func ]]( instance, note, param, var_64ffacba090c91be );
            continue;
        }
        
        level [[ func ]]( instance, note, param, var_64ffacba090c91be );
    }
}

// Namespace scriptable
// Params 0
// Checksum 0xf8dfd8f, Offset: 0x973
// Size: 0x84
function scriptable_enginepostinitialize()
{
    if ( isdefined( level.scriptable_postinit ) )
    {
        foreach ( func in level.scriptable_postinit )
        {
            [[ func ]]();
        }
    }
}

// Namespace scriptable
// Params 2
// Checksum 0xd6b99efc, Offset: 0x9ff
// Size: 0x99
function function_ce0492ba57130ca4( id, scriptables )
{
    if ( isdefined( level.var_27e161a3bcab8269 ) )
    {
        foreach ( runtime_trigger_func in level.var_27e161a3bcab8269 )
        {
            [[ runtime_trigger_func ]]( id, scriptables );
        }
    }
}

// Namespace scriptable
// Params 2
// Checksum 0xecdaab2d, Offset: 0xaa0
// Size: 0x99
function function_f9851d1984d0205c( event, scriptables )
{
    if ( isdefined( level.var_2f3d3eb6b16bc8b2 ) )
    {
        foreach ( var_729fa13d338b2289 in level.var_2f3d3eb6b16bc8b2 )
        {
            [[ var_729fa13d338b2289 ]]( event, scriptables );
        }
    }
}

// Namespace scriptable
// Params 4
// Checksum 0x60ac887, Offset: 0xb41
// Size: 0xae
function scriptable_enginetouched( instance, part, state, player )
{
    if ( isdefined( level.scriptable_touched_funcs ) )
    {
        foreach ( touched_func in level.scriptable_touched_funcs )
        {
            [[ touched_func ]]( instance, part, state, player );
        }
    }
}

// Namespace scriptable
// Params 6
// Checksum 0xbdc0647d, Offset: 0xbf7
// Size: 0x1d3
function scriptable_engineused( instance, part, state, player, bautouse, usestring )
{
    if ( bautouse )
    {
        if ( isdefined( level.scriptable_autouse_funcs ) )
        {
            foreach ( used_func in level.scriptable_autouse_funcs )
            {
                [[ used_func ]]( instance, part, state, player, 1, usestring );
            }
        }
        
        return;
    }
    
    if ( isdefined( level.scriptable_used_funcs ) )
    {
        foreach ( used_func in level.scriptable_used_funcs )
        {
            [[ used_func ]]( instance, part, state, player, 0, usestring );
        }
    }
    
    if ( isdefined( level.scriptable_used_by_part_funcs[ part ] ) )
    {
        foreach ( used_func in level.scriptable_used_by_part_funcs[ part ] )
        {
            [[ used_func ]]( instance, part, state, player, 1, usestring );
        }
    }
}

// Namespace scriptable
// Params 5
// Checksum 0xe0128d8f, Offset: 0xdd2
// Size: 0x13c
function function_190abcbcb4f3a47c( instance, part, state, player, useduration )
{
    if ( isdefined( level.var_dc7848b4278e9d43 ) )
    {
        foreach ( func in level.var_dc7848b4278e9d43 )
        {
            [[ func ]]( instance, part, state, player, useduration );
        }
    }
    
    if ( isdefined( level.var_4e9ab6c139c9bf3b[ part ] ) )
    {
        foreach ( func in level.var_4e9ab6c139c9bf3b[ part ] )
        {
            [[ func ]]( instance, part, state, player, useduration );
        }
    }
}

// Namespace scriptable/event_fab19dbfa32508bc
// Params 2, eflags: 0x20
// Checksum 0xb344b9b9, Offset: 0xf16
// Size: 0x1e
function event_handler[event_fab19dbfa32508bc] function_fab19dbfa32508bc( instance, player )
{
    return function_1e33a4f0f19aa3a( instance, player );
}

// Namespace scriptable/scriptable_damage
// Params 13, eflags: 0x20
// Checksum 0x1c5d8b56, Offset: 0xf3d
// Size: 0x8e
function event_handler[scriptable_damage] function_dc8eae0479686591( note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    scriptable_enginedamaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
}

// Namespace scriptable
// Params 13
// Checksum 0x5151d8a1, Offset: 0xfd3
// Size: 0x8e
function riotshield_damaged( note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    scriptable_enginedamaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname );
}

// Namespace scriptable
// Params 1
// Checksum 0x61de5b6, Offset: 0x1069
// Size: 0x39
function scriptable_setinitcallback( initcallback )
{
    if ( !isdefined( level.scriptable_init ) )
    {
        level.scriptable_init = [];
    }
    
    level.scriptable_init[ level.scriptable_init.size ] = initcallback;
}

// Namespace scriptable/scriptable_touched
// Params 4, eflags: 0x20
// Checksum 0xdaf9ebd5, Offset: 0x10aa
// Size: 0x34
function event_handler[scriptable_touched] scriptable_touched( instance, part, state, player )
{
    scriptable_enginetouched( instance, part, state, player );
}

// Namespace scriptable
// Params 1
// Checksum 0x897a575e, Offset: 0x10e6
// Size: 0x33
function function_5afb9c6312cfcc47( usecallback )
{
    if ( !isdefined( level.scriptable_autouse_funcs ) )
    {
        return;
    }
    
    level.scriptable_autouse_funcs = arrayremove( level.scriptable_autouse_funcs, usecallback );
}

// Namespace scriptable
// Params 1
// Checksum 0xe2aecbc9, Offset: 0x1121
// Size: 0x33
function function_e72d5d504ed90c6f( canbeusedcallback )
{
    if ( !isdefined( level.var_c600434e0043e180 ) )
    {
        return;
    }
    
    level.var_c600434e0043e180 = arrayremove( level.var_c600434e0043e180, canbeusedcallback );
}

// Namespace scriptable
// Params 1
// Checksum 0x155bc43d, Offset: 0x115c
// Size: 0x33
function function_dc174fecebb79952( damagedcallback )
{
    if ( !isdefined( level.scriptable_damaged_funcs ) )
    {
        return;
    }
    
    level.scriptable_damaged_funcs = arrayremove( level.scriptable_damaged_funcs, damagedcallback );
}

// Namespace scriptable
// Params 2
// Checksum 0xda7e163, Offset: 0x1197
// Size: 0x45
function function_65c9f35ffd4310f8( funckey, func )
{
    if ( !isdefined( level.scriptable_notify_callback_funcs[ funckey ] ) )
    {
        return;
    }
    
    level.scriptable_notify_callback_funcs[ funckey ] = arrayremove( level.scriptable_notify_callback_funcs[ funckey ], func );
}

// Namespace scriptable
// Params 1
// Checksum 0x1d5260fe, Offset: 0x11e4
// Size: 0x33
function function_ecfda6e42bbe0ddc( usedcallback )
{
    if ( !isdefined( level.scriptable_used_funcs ) )
    {
        return;
    }
    
    level.scriptable_used_funcs = arrayremove( level.scriptable_used_funcs, usedcallback );
}

// Namespace scriptable
// Params 2
// Checksum 0x8db25863, Offset: 0x121f
// Size: 0x54
function function_369a834929711390( part, usedcallback )
{
    if ( !isdefined( level.scriptable_used_by_part_funcs ) )
    {
        return;
    }
    
    if ( !isdefined( level.scriptable_used_by_part_funcs[ part ] ) )
    {
        return;
    }
    
    level.scriptable_used_by_part_funcs[ part ] = arrayremove( level.scriptable_used_by_part_funcs[ part ], usedcallback );
}

// Namespace scriptable/event_90b3dac3d776d2f6
// Params 2, eflags: 0x20
// Checksum 0x8d5f398a, Offset: 0x127b
// Size: 0x1f
function event_handler[event_90b3dac3d776d2f6] function_b4f2f1e43208be2d( id, scriptables )
{
    function_ce0492ba57130ca4( id, scriptables );
}

// Namespace scriptable/event_c26bb161f32a8f79
// Params 2, eflags: 0x20
// Checksum 0x634c30e8, Offset: 0x12a2
// Size: 0x1f
function event_handler[event_c26bb161f32a8f79] function_e238758bb6d06ce2( event, scriptables )
{
    function_f9851d1984d0205c( event, scriptables );
}

// Namespace scriptable
// Params 2
// Checksum 0x6ff0660d, Offset: 0x12c9
// Size: 0x2b, Type: bool
function function_982b533206bc78a5( instance, player )
{
    if ( !instance scriptablemaskallowed() )
    {
        return false;
    }
    
    instance function_d6a7b7ef13a57f38( self );
    return true;
}

// Namespace scriptable/scriptable_notify
// Params 5, eflags: 0x20
// Checksum 0x41b3e772, Offset: 0x12fd
// Size: 0x3e
function event_handler[scriptable_notify] scriptable_notify_callback( instance, note, param, ent, var_64ffacba090c91be )
{
    scriptable_enginenotifycallback( instance, note, param, ent, var_64ffacba090c91be );
}

