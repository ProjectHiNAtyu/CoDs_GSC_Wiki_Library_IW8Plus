// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_cafe.gsc  (hash_4ed969029bbaa7c4.gscc) (size: 15270 Bytes / 0x3ba6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x527c69c0 (1383885248)
// size ...... 15270 (0x3ba6)
// includes .. 14  (offset: 0x3862)
// strings ... 37  (offset: 0x38d2)
// dev strs .. 14  (offset: 0x3afe)
// exports ... 30  (offset: 0x268a)
// cseg ...... 0x2a2 + 0x23e8 (0x268a)
// imports ... 108 (offset: 0x2b3a)
// animtree1 . 0   (offset: 0x3ba6)
// animtree2 . 0   (offset: 0x3ba6)
#using scripts\anim\dialogue;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_cafe_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_ee_cafe;

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x5
// Checksum 0xcd3fdce1, Offset: 0x2c0
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_cafe", #"zm_quest", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x24c6674d, Offset: 0x2ed
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x1aa10991, Offset: 0x2f7
// Size: 0x9b
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_69a0d03100d359b3", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_cafe_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_cafe = zm_quest::get_quest( #"hornet_ee_cafe" );
    zm_quest::register_quest_step( #"hornet_ee_cafe", #"kitfinder", &setup_locate_cat_step, &cleanup_locate_cat_step );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hornet_ee_cafe" );
    
    /#
        register_cafe_devgui();
    #/
}

// Namespace zm_sat_hornet_ee_cafe
// Params 2, eflags: 0x4
// Checksum 0xd3e3fb9e, Offset: 0x39a
// Size: 0x42
function private setup_locate_cat_step( b_skipped, b_save_restored )
{
    if ( !b_save_restored )
    {
        if ( zm_save::function_1dda3554974a999e() )
        {
            function_e84737f01867e156();
        }
        else
        {
            function_189c3f635f1c1703();
        }
    }
    
    level waittill( #"hash_723432b3a73953f" );
}

// Namespace zm_sat_hornet_ee_cafe
// Params 2, eflags: 0x4
// Checksum 0xfd923379, Offset: 0x3e4
// Size: 0x47
function private cleanup_locate_cat_step( b_skipped, b_save_restored )
{
    level thread function_5a1205f1ffca32fe();
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_cafe", #"cafe_spawned", 1 );
    
    if ( !b_save_restored )
    {
        level thread function_776ca2609c67a0ce();
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x677367e, Offset: 0x433
// Size: 0x2bd
function private function_189c3f635f1c1703()
{
    level utility::flag_wait( "scriptables_ready" );
    level.ee_cafe.cats_found = 0;
    level.ee_cafe.var_c5429696c757d0c2 = 0;
    level.ee_cafe.a_cats = [];
    level.ee_cafe.var_b725444b1de4371d = arrayrandomize( utility::getstructarray( "cc_fo_loc" ) );
    level.ee_cafe.var_2bf888483a0e56fc = 0;
    level.ee_cafe.var_762544f632f6fe10 = [];
    var_ca9de60298de8b8f = sortbydistance( utility::getstructarray( "cc_lookit" ), ( 0, 0, 0 ) );
    a_loc_keys = [ #"hash_e121531f1bf2b9f2", #"hash_e121541f1bf2bba5", #"hash_e121511f1bf2b68c", #"hash_e121521f1bf2b83f", #"hash_e1214f1f1bf2b326", #"hash_e121501f1bf2b4d9", #"hash_e1214d1f1bf2afc0", #"hash_e1214e1f1bf2b173" ];
    
    for ( i = 0; i < var_ca9de60298de8b8f.size ; i++ )
    {
        var_ca9de60298de8b8f[ i ].var_5070887957673e34 = i;
    }
    
    var_4b9e0698bf633a21 = utility::array_random_slice( arrayrandomize( var_ca9de60298de8b8f ), 5 );
    
    foreach ( s_spawn in var_4b9e0698bf633a21 )
    {
        level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_cafe", a_loc_keys[ s_spawn.var_5070887957673e34 ], 1 );
        
        if ( isdefined( s_spawn.target ) )
        {
            s_mouse = utility::getstruct( s_spawn.target, "targetname" );
            mouse = spawnscriptable( %"zm_sat_hornet_cafe", s_mouse.origin, s_mouse.angles );
            mouse setscriptablepartstate( "model", "mo_to" );
            mouse setscriptablepartstate( "usable_state", "enabled" );
            mouse.s_parent_spawn = s_spawn;
            interaction::register_scriptable_interact( mouse, &function_7d9ccd6143d29b04, undefined, undefined, &function_7cf797774710f3bd );
        }
    }
    
    level.ee_cafe.a_remaining_spawns = var_4b9e0698bf633a21;
    level thread function_498c882e36cbe0a0();
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x58912210, Offset: 0x6f8
// Size: 0x478
function private function_e84737f01867e156()
{
    level utility::flag_wait( "scriptables_ready" );
    level.ee_cafe.cats_found = 0;
    level.ee_cafe.var_c5429696c757d0c2 = 0;
    level.ee_cafe.a_cats = [];
    level.ee_cafe.var_b725444b1de4371d = arrayrandomize( utility::getstructarray( "cc_fo_loc" ) );
    level.ee_cafe.var_2bf888483a0e56fc = 0;
    level.ee_cafe.var_762544f632f6fe10 = [];
    var_ca9de60298de8b8f = sortbydistance( utility::getstructarray( "cc_lookit" ), ( 0, 0, 0 ) );
    a_loc_keys = [ #"hash_e121531f1bf2b9f2", #"hash_e121541f1bf2bba5", #"hash_e121511f1bf2b68c", #"hash_e121521f1bf2b83f", #"hash_e1214f1f1bf2b326", #"hash_e121501f1bf2b4d9", #"hash_e1214d1f1bf2afc0", #"hash_e1214e1f1bf2b173" ];
    a_remaining_spawns = [];
    b_all_done = 1;
    
    for ( i = 0; i < var_ca9de60298de8b8f.size ; i++ )
    {
        s_spawn = var_ca9de60298de8b8f[ i ];
        s_spawn.var_5070887957673e34 = i;
        var_22754e38a04d6172 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_cafe", a_loc_keys[ i ] ) ?? 0;
        
        if ( var_22754e38a04d6172 == 0 )
        {
            continue;
        }
        
        var_868a7a3ce7a6d1b = var_22754e38a04d6172 == 2 || var_22754e38a04d6172 == 4;
        var_bd1e0f40ac6c962c = var_22754e38a04d6172 == 3 || var_22754e38a04d6172 == 4;
        
        if ( var_868a7a3ce7a6d1b )
        {
            level.ee_cafe.var_c5429696c757d0c2++;
            
            if ( level.ee_cafe.var_2bf888483a0e56fc < level.ee_cafe.var_b725444b1de4371d.size )
            {
                s_fo = level.ee_cafe.var_b725444b1de4371d[ level.ee_cafe.var_2bf888483a0e56fc ];
                toy = spawnscriptable( %"zm_sat_hornet_cafe", s_fo.origin, s_fo.angles );
                toy utility::function_32b24db3127bff40( "model", s_fo.script_noteworthy );
                level.ee_cafe.var_762544f632f6fe10[ level.ee_cafe.var_762544f632f6fe10.size ] = toy;
                level.ee_cafe.var_2bf888483a0e56fc++;
            }
        }
        else if ( isdefined( s_spawn.target ) )
        {
            s_mouse = utility::getstruct( s_spawn.target, "targetname" );
            mouse = spawnscriptable( %"zm_sat_hornet_cafe", s_mouse.origin, s_mouse.angles );
            mouse setscriptablepartstate( "model", "mo_to" );
            mouse setscriptablepartstate( "usable_state", "enabled" );
            mouse.s_parent_spawn = s_spawn;
            interaction::register_scriptable_interact( mouse, &function_7d9ccd6143d29b04, undefined, undefined, &function_7cf797774710f3bd );
        }
        
        if ( var_bd1e0f40ac6c962c )
        {
            level.ee_cafe.cats_found++;
            cat = function_d5f427d5fc5f939( s_spawn.script_noteworthy );
            
            if ( level.ee_cafe.cats_found == 5 )
            {
                level.ee_cafe.var_5f24e14d8375ccfe = cat;
            }
        }
        else
        {
            a_remaining_spawns[ a_remaining_spawns.size ] = s_spawn;
            b_all_done = 0;
        }
        
        if ( !var_bd1e0f40ac6c962c || !var_868a7a3ce7a6d1b )
        {
            b_all_done = 0;
        }
    }
    
    level.ee_cafe.a_remaining_spawns = a_remaining_spawns;
    
    if ( b_all_done && level.ee_cafe.cats_found == 5 && level.ee_cafe.var_c5429696c757d0c2 == 5 )
    {
        function_286930ea68d84dd5( level.ee_cafe.var_5f24e14d8375ccfe );
        return;
    }
    
    if ( a_remaining_spawns.size > 0 )
    {
        level thread function_498c882e36cbe0a0();
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0xb2067f0d, Offset: 0xb78
// Size: 0x1fb
function private function_498c882e36cbe0a0()
{
    level endon( #"game_ended" );
    level.ee_cafe endon( #"zm_quest_quit" );
    
    for ( n_index = 0; level.ee_cafe.a_remaining_spawns.size > 0 ; n_index++ )
    {
        a_spawns = level.ee_cafe.a_remaining_spawns;
        s_spawn = a_spawns[ n_index % a_spawns.size ];
        cat = spawnscriptable( %"zm_sat_hornet_kit", s_spawn.origin, s_spawn.angles );
        cat.s_spawn = s_spawn;
        level.ee_cafe.a_cats[ level.ee_cafe.a_cats.size ] = cat;
        
        if ( s_spawn.script_noteworthy )
        {
            cat utility::function_32b24db3127bff40( "model", s_spawn.script_noteworthy );
            cat.color = s_spawn.script_noteworthy;
        }
        
        lookat_trigger = spawn( "noent_volume_trigger_radius", s_spawn.origin - ( 0, 0, 200 ), 0, 300, 400 );
        cat.lookat_trigger = lookat_trigger;
        s_spawn.active_cat = cat;
        lookat_trigger thread cat_trigger_think( cat );
        
        for ( n_rounds_waited = 0; n_rounds_waited < 2 ; n_rounds_waited++ )
        {
            level waittill( #"on_round_end" );
        }
        
        if ( !arraycontains( level.ee_cafe.a_remaining_spawns, s_spawn ) )
        {
            continue;
        }
        
        if ( level.ee_cafe.a_remaining_spawns.size == 1 )
        {
            return;
        }
        
        s_spawn.active_cat = undefined;
        
        if ( lookat_trigger )
        {
            lookat_trigger delete();
        }
        
        cat thread cat_retreat( 0 );
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0x570f9f13, Offset: 0xd7b
// Size: 0x44
function private function_2980c4688d68fae( s_spawn )
{
    level.ee_cafe.a_remaining_spawns = arrayremove( level.ee_cafe.a_remaining_spawns, s_spawn );
    s_spawn.active_cat = undefined;
}

// Namespace zm_sat_hornet_ee_cafe
// Params 3, eflags: 0x4
// Checksum 0x6dbe766d, Offset: 0xdc7
// Size: 0xf0
function private cat_trigger_think( cat, success_func = &cat_retreat, angle_threshold = 20 )
{
    level.ee_cafe endon( #"zm_quest_quit" );
    cat endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && utility::function_af749a6c1f8241f0( ent, cat.origin, angle_threshold ) )
        {
            var_31b910cf81bdac48 = utility::function_476c996eed246db( ent, cat.origin, 4, angle_threshold );
            
            if ( var_31b910cf81bdac48 && isdefined( cat ) )
            {
                cat [[ success_func ]]();
                level.ee_cafe.team = ent.team;
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0x550d7c3, Offset: 0xebf
// Size: 0x3cc
function private cat_retreat( b_discovered = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.is_retreating )
    {
        return;
    }
    
    self.is_retreating = 1;
    
    if ( !isdefined( self.mover ) )
    {
        self.mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    }
    
    if ( isdefined( self ) && isdefined( self.mover ) && !self.linkedparent )
    {
        utility::scriptable_setparententity( self.mover, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    self.mover rotateby( ( 0, 180, 0 ), 1, 1, 0 );
    self.mover waittill( #"rotatedone" );
    
    if ( b_discovered )
    {
        playsoundatpos( self.origin, "evt_cat_cafe_single_yowl" );
    }
    
    self setscriptablepartstate( "model", "run" );
    offset = anglestoright( self.angles ) * 100;
    self.mover moveby( offset, 2.5 );
    self.mover waittill( #"movedone" );
    
    if ( b_discovered )
    {
        if ( self.s_spawn )
        {
            function_2980c4688d68fae( self.s_spawn );
            
            if ( isdefined( self.s_spawn.var_5070887957673e34 ) )
            {
                a_loc_keys = [ #"hash_e121531f1bf2b9f2", #"hash_e121541f1bf2bba5", #"hash_e121511f1bf2b68c", #"hash_e121521f1bf2b83f", #"hash_e1214f1f1bf2b326", #"hash_e121501f1bf2b4d9", #"hash_e1214d1f1bf2afc0", #"hash_e1214e1f1bf2b173" ];
                var_1789e3ae5e72b96f = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_cafe", a_loc_keys[ self.s_spawn.var_5070887957673e34 ] ) ?? 1;
                
                if ( var_1789e3ae5e72b96f < 4 )
                {
                    n_new_state = var_1789e3ae5e72b96f == 2 ? 4 : 3;
                    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_cafe", a_loc_keys[ self.s_spawn.var_5070887957673e34 ], n_new_state );
                }
            }
        }
        
        level.ee_cafe.cats_found++;
        
        if ( level.ee_cafe.cats_found == 1 )
        {
            foreach ( player in level.players )
            {
                player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_cat_cafe_first_cat", #"hash_5212ed7ec42f115a" );
            }
        }
        
        cat = function_d5f427d5fc5f939( self.color );
        
        if ( level.ee_cafe.cats_found == 5 )
        {
            level.ee_cafe.var_5f24e14d8375ccfe = cat;
            
            if ( level.ee_cafe.var_c5429696c757d0c2 == 5 )
            {
                function_286930ea68d84dd5( cat );
            }
        }
    }
    
    self.is_retreating = undefined;
    self.mover delete();
    self freescriptable();
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0x98b86ee7, Offset: 0x1293
// Size: 0x49
function private function_286930ea68d84dd5( cat )
{
    trigger = getnoentvolumearray( "cc_thau", #targetname )[ 0 ];
    cat.lookat_trigger = trigger;
    trigger thread cat_trigger_think( cat, &function_68602cda9cb197e8 );
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x228848b4, Offset: 0x12e4
// Size: 0xe
function private function_68602cda9cb197e8()
{
    level notify( #"hash_723432b3a73953f" );
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0x70d3e269, Offset: 0x12fa
// Size: 0x29e
function private function_7d9ccd6143d29b04( player )
{
    var_a7754bc017e65d98 = self.s_parent_spawn;
    self setscriptablepartstate( "usable_state", "disabled" );
    self freescriptable();
    
    if ( isdefined( var_a7754bc017e65d98 ) && isdefined( var_a7754bc017e65d98.var_5070887957673e34 ) )
    {
        a_loc_keys = [ #"hash_e121531f1bf2b9f2", #"hash_e121541f1bf2bba5", #"hash_e121511f1bf2b68c", #"hash_e121521f1bf2b83f", #"hash_e1214f1f1bf2b326", #"hash_e121501f1bf2b4d9", #"hash_e1214d1f1bf2afc0", #"hash_e1214e1f1bf2b173" ];
        var_1789e3ae5e72b96f = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_cafe", a_loc_keys[ var_a7754bc017e65d98.var_5070887957673e34 ] ) ?? 1;
        
        if ( var_1789e3ae5e72b96f < 4 )
        {
            n_new_state = var_1789e3ae5e72b96f == 3 ? 4 : 2;
            level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_cafe", a_loc_keys[ var_a7754bc017e65d98.var_5070887957673e34 ], n_new_state );
        }
    }
    
    if ( level.ee_cafe.var_2bf888483a0e56fc < level.ee_cafe.var_b725444b1de4371d.size )
    {
        s_fo = level.ee_cafe.var_b725444b1de4371d[ level.ee_cafe.var_2bf888483a0e56fc ];
        toy = spawnscriptable( %"zm_sat_hornet_cafe", s_fo.origin, s_fo.angles );
        toy utility::function_32b24db3127bff40( "model", s_fo.script_noteworthy );
        level.ee_cafe.var_762544f632f6fe10[ level.ee_cafe.var_762544f632f6fe10.size ] = toy;
        level.ee_cafe.var_2bf888483a0e56fc++;
    }
    
    level.ee_cafe.var_c5429696c757d0c2++;
    
    if ( level.ee_cafe.var_c5429696c757d0c2 == 1 )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_cat_cafe_find_first_cat_toy", #"hash_5212ed7ec42f115a" );
    }
    
    if ( level.ee_cafe.var_c5429696c757d0c2 == 5 && level.ee_cafe.cats_found == 5 )
    {
        function_286930ea68d84dd5( level.ee_cafe.var_5f24e14d8375ccfe );
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 2, eflags: 0x4
// Checksum 0x556712cb, Offset: 0x15a0
// Size: 0x36
function private function_7cf797774710f3bd( usable, player )
{
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0x4c05da3c, Offset: 0x15df
// Size: 0x12a
function private function_d5f427d5fc5f939( color )
{
    level.ee_cafe.var_84abf58c2ac2c9f0 = arrayrandomize( utility::getstructarray( "cc_hau" ) );
    
    foreach ( struct in level.ee_cafe.var_84abf58c2ac2c9f0 )
    {
        if ( !isdefined( struct.cat ) )
        {
            struct.cat = spawnscriptable( %"zm_sat_hornet_kit", struct.origin, struct.angles );
            
            if ( color )
            {
                struct.cat utility::function_32b24db3127bff40( "model", color );
                struct.cat.color = color;
            }
            
            return struct.cat;
        }
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x1ac9b4a6, Offset: 0x1711
// Size: 0x47c
function private function_5a1205f1ffca32fe()
{
    level endon( #"game_ended" );
    trigger = getnoentvolumearray( "cc_thau", #targetname )[ 0 ];
    var_adae4bc24d47644a = arrayrandomize( utility::getstructarray( "cc_plsp", "targetname" ) );
    a_affected_players = [];
    sp_index = 0;
    a_players = level.players;
    
    foreach ( player in a_players )
    {
        if ( player istouching( trigger ) )
        {
            player val::set( "ignoreme", "cafe", 1 );
            player thread zm_utility::white_screen_flash( 1, 0.2, 1, 0.5 );
            s_spawn = var_adae4bc24d47644a[ sp_index % var_adae4bc24d47644a.size ];
            player thread function_bd098fcc69dd7bbf( s_spawn );
            sp_index++;
            a_affected_players[ a_affected_players.size ] = player;
        }
    }
    
    level notify( #"cc_spawned" );
    function_151ab9cb7b6a4cb9();
    var_84abf58c2ac2c9f0 = level.ee_cafe.var_84abf58c2ac2c9f0 ?? utility::getstructarray( "cc_hau" );
    var_13b3968cf45958a4 = arrayrandomize( utility::getstructarray( "cc_hau_ins", "targetname" ) );
    
    foreach ( i, struct in var_84abf58c2ac2c9f0 )
    {
        if ( var_13b3968cf45958a4[ i ] )
        {
            new_cat = spawnscriptable( %"zm_sat_hornet_kit", var_13b3968cf45958a4[ i ].origin, var_13b3968cf45958a4[ i ].angles );
            
            if ( struct.cat.color )
            {
                new_cat utility::function_32b24db3127bff40( "model", struct.cat.color );
            }
        }
        
        if ( struct.cat )
        {
            struct.cat setscriptablepartstate( "model", "off" );
            struct.cat utility::delaycall( 0.25, &freescriptable );
            struct.cat = undefined;
        }
    }
    
    foreach ( toy in level.ee_cafe.var_762544f632f6fe10 )
    {
        if ( toy )
        {
            toy freescriptable();
        }
    }
    
    level.ee_cafe.var_762544f632f6fe10 = [];
    
    if ( !level.ee_cafe.var_248c9a267b7f40f3 )
    {
        level.ee_cafe.var_248c9a267b7f40f3 = 1;
        
        foreach ( player in a_affected_players )
        {
            if ( player )
            {
                player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_cat_cafe_first_arrival" );
            }
        }
    }
    
    foreach ( player in a_affected_players )
    {
        if ( isdefined( player ) )
        {
            player val::reset( "ignoreme", "cafe" );
        }
    }
    
    level thread function_fac868b2bd8a0678();
    level thread function_d7002bca1ed87bbe();
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0xc16d092f, Offset: 0x1b95
// Size: 0x40
function private function_bd098fcc69dd7bbf( s_spawn )
{
    self endon( #"hash_b3dcf8b166624477" );
    wait 0.2;
    self setorigin( s_spawn.origin );
    self setplayerangles( s_spawn.angles );
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x31555ac6, Offset: 0x1bdd
// Size: 0x199
function private function_151ab9cb7b6a4cb9()
{
    level utility::flag_wait( "scriptables_ready" );
    a_structs = utility::getstructarray( "cc_prop", "targetname" );
    
    foreach ( struct in a_structs )
    {
        if ( struct.script_noteworthy == "sus_cat" )
        {
            utility::spawn_model( %"hash_1b31f4cec6fd48e", struct.origin, struct.angles, undefined, 1 );
        }
        else if ( struct.script_noteworthy == "sus_ro" )
        {
            utility::spawn_model( %"hash_324ae510193aa0ea", struct.origin, struct.angles, undefined, 1 );
        }
        else if ( struct.script_noteworthy == "cc_sig" )
        {
            utility::spawn_model( %"hash_44764380ab4ea698", struct.origin, struct.angles, undefined, 1 );
        }
        else
        {
            cafe = spawnscriptable( %"zm_sat_hornet_cafe", struct.origin, struct.angles );
            cafe utility::function_32b24db3127bff40( "model", struct.script_noteworthy );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x2a2f5105, Offset: 0x1d7e
// Size: 0x13b
function private function_fac868b2bd8a0678()
{
    level endon( #"game_ended" );
    trigger = getnoentvolumearray( "cc_hhdea", #targetname )[ 0 ];
    var_dae0976d619cc067 = 0;
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isai( ent ) && isalive( ent ) && issubstr( ent.subclass, "hellhound" ) && level.ee_cafe.team != ent.team && ent != level.hornet_mq.chase_hellhound )
        {
            ent kill();
            n_time = gettime();
            
            if ( n_time - var_dae0976d619cc067 >= 2000 )
            {
                playsoundatpos( ent.origin, "evt_cat_cafe_multi_yowl" );
                var_dae0976d619cc067 = n_time;
            }
            
            wait 1;
            continue;
        }
        
        if ( zm_player::function_f37cfdf04b932a03( ent ) )
        {
            objweapon = ent getcurrentweapon();
            
            if ( issubstr( objweapon.basename, "ww_hornet" ) )
            {
                ent thread function_dbee200d97241cff();
            }
        }
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0xfb5eb9a5, Offset: 0x1ec1
// Size: 0x1f7
function private function_776ca2609c67a0ce()
{
    level endon( #"game_ended" );
    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_15800b43a7bb4ab8", #"hash_c600658fe1a5ad9f", level.players );
    potential_rewards = [ %"itemspawnentry:zm_t10_item_perk_death_perception", %"hash_63a8dbb95fa75efb", %"hash_35bfcd79fa72f41a", %"hash_63a8dbb95fa75efb", %"itemspawnentry:zm_t10_item_perk_juggernog" ];
    var_f6dd3752378c7ccd = arrayrandomize( utility::getstructarray( "cc_pk_rw", "targetname" ) );
    var_5c8de804e7f6774d = arrayrandomize( potential_rewards );
    
    if ( level.players.size == 1 && level.players[ 0 ] zombie_perks::function_cda78d45986a51a0() )
    {
        var_5c8de804e7f6774d = [ %"hash_63a8dbb95fa75efb", %"hash_63a8dbb95fa75efb" ];
    }
    
    for ( i = 0; i < 2 && i < var_f6dd3752378c7ccd.size ; i++ )
    {
        s_loc = var_f6dd3752378c7ccd[ i ];
        spawn_options = common_item::function_bc5ff2958b71a708( var_f6dd3752378c7ccd[ i ].origin, var_f6dd3752378c7ccd[ i ].angles );
        spawn_options.var_fd47e835523b473f = 1;
        common_item::function_61c2c0251e742ffd( var_5c8de804e7f6774d[ i ], 1, spawn_options );
    }
    
    wait 1.5;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player zombie_perks::function_ab9b4123275d6153();
        }
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0xb30f3816, Offset: 0x20c0
// Size: 0x97
function private function_dbee200d97241cff()
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_d672d7e7b4519c94 && !utility::time_has_passed( self.var_d672d7e7b4519c94, 120 ) )
    {
        return;
    }
    
    self.var_d672d7e7b4519c94 = gettime();
    wait 1;
    zm_quest::function_8934bb2a9028bdc5();
    
    while ( dialogue::is_speaking() )
    {
        wait 0.5;
    }
    
    objweapon = self getcurrentweapon();
    
    if ( issubstr( objweapon.basename, "ww_hornet" ) )
    {
        dialogue::say( "dx_zm_hesd_est1_nkmt_hesd1ccarv", undefined, undefined, undefined, undefined, "global" );
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 0, eflags: 0x4
// Checksum 0x3e64b16f, Offset: 0x215f
// Size: 0xe1
function private function_d7002bca1ed87bbe()
{
    level endon( #"game_ended" );
    var_e6c8089625d66386 = getnoentvolumearray( "cc_pusht", #targetname );
    
    if ( !isdefined( var_e6c8089625d66386 ) || var_e6c8089625d66386.size == 0 )
    {
        return;
    }
    
    trigger_house = getnoentvolumearray( "cc_thau", #targetname )[ 0 ];
    var_dac75f4116c98678 = trigger_house.origin;
    
    foreach ( trigger in var_e6c8089625d66386 )
    {
        trigger thread function_b04a1e7f856f8699( var_dac75f4116c98678 );
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 1, eflags: 0x4
// Checksum 0x507245e, Offset: 0x2248
// Size: 0x6d
function private function_b04a1e7f856f8699( var_dac75f4116c98678 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( !ent.var_81b818ef3727e9ed )
        {
            ent thread function_d48524988f947c0b( self, var_dac75f4116c98678 );
        }
    }
}

// Namespace zm_sat_hornet_ee_cafe
// Params 2, eflags: 0xc
// Checksum 0xdcb488f9, Offset: 0x22bd
// Size: 0xbf
function private function_d48524988f947c0b( trigger, var_dac75f4116c98678 )
{
    self notify( #"hash_9c3d5a74e870d500" );
    self endon( #"hash_9c3d5a74e870d500" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.var_81b818ef3727e9ed = 1;
    
    for ( i = 0; i < 5 ; i++ )
    {
        wait 1;
        
        if ( !isalive( self ) || !self istouching( trigger ) )
        {
            self.var_81b818ef3727e9ed = undefined;
            return;
        }
    }
    
    var_46b767ace215f1f9 = vectornormalize( var_dac75f4116c98678 - self.origin );
    self knockback( var_46b767ace215f1f9, 400, 1 );
    self.var_81b818ef3727e9ed = undefined;
}

/#

    // Namespace zm_sat_hornet_ee_cafe
    // Params 0, eflags: 0x4
    // Checksum 0x66207abc, Offset: 0x2384
    // Size: 0x7c, Type: dev
    function private register_cafe_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"hornet_ee_cafe" );
        devgui::add_devgui_func( "<dev string:x24>", "<dev string:x35>", &function_151ab9cb7b6a4cb9, 1 );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x55>", &spawn_spheres, 1 );
        devgui::add_devgui_func( "<dev string:x5f>", "<dev string:x74>", &function_392d6d9a3970db98, 1 );
        devgui::add_devgui_func( "<dev string:x7f>", "<dev string:x97>", &function_e317b0097ed55dce, 1 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_hornet_ee_cafe
    // Params 0, eflags: 0x4
    // Checksum 0x362ea776, Offset: 0x2408
    // Size: 0xa2, Type: dev
    function private spawn_spheres()
    {
        foreach ( cat in level.ee_cafe.a_cats )
        {
            sphere( cat.origin, 25, ( 255, 255, 0 ), 0, 6000 );
        }
    }

    // Namespace zm_sat_hornet_ee_cafe
    // Params 0, eflags: 0x4
    // Checksum 0x1ccca7a7, Offset: 0x24b2
    // Size: 0x1bf, Type: dev
    function private function_392d6d9a3970db98()
    {
        a_all_spawns = utility::getstructarray( "<dev string:xa8>" );
        
        foreach ( s_spawn in a_all_spawns )
        {
            cat = spawnscriptable( %"zm_sat_hornet_kit", s_spawn.origin, s_spawn.angles );
            
            if ( s_spawn.script_noteworthy )
            {
                cat utility::function_32b24db3127bff40( "<dev string:xb2>", s_spawn.script_noteworthy );
                cat.color = s_spawn.script_noteworthy;
            }
            
            cat.s_spawn = s_spawn;
            lookat_trigger = spawn( "<dev string:xb8>", s_spawn.origin - ( 0, 0, 200 ), 0, 300, 400 );
            cat.lookat_trigger = lookat_trigger;
            lookat_trigger thread cat_trigger_think( cat );
            level.ee_cafe.a_cats[ level.ee_cafe.a_cats.size ] = cat;
            sphere( s_spawn.origin, 25, ( 0, 255, 0 ), 0, 6000 );
            iprintlnbold( "<dev string:xd4>" + s_spawn.origin );
        }
        
        iprintlnbold( "<dev string:xe4>" + a_all_spawns.size + "<dev string:xed>" );
    }

    // Namespace zm_sat_hornet_ee_cafe
    // Params 0
    // Checksum 0x180b8b79, Offset: 0x2679
    // Size: 0x11, Type: dev
    function function_e317b0097ed55dce()
    {
        level notify( #"hash_723432b3a73953f" );
    }

#/
