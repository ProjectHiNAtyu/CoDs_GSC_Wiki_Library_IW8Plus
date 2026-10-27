// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rh_coffin.gsc  (hash_53d8a642c173e600.gscc) (size: 3348 Bytes / 0xd14 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd660c45 (3446017093)
// size ...... 3348 (0xd14)
// includes .. 6   (offset: 0xba8)
// strings ... 18  (offset: 0xbd8)
// dev strs .. 8   (offset: 0xcb0)
// exports ... 7   (offset: 0x7cc)
// cseg ...... 0x123 + 0x6a9 (0x7cc)
// imports ... 22  (offset: 0x8e4)
// animtree1 . 0   (offset: 0xd14)
// animtree2 . 0   (offset: 0xd14)
#using script_2e008c550c5daf6d;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_sat_scarab_rh_coffin;

// Namespace zm_sat_scarab_rh_coffin
// Params 0, eflags: 0x5
// Checksum 0x6a133070, Offset: 0x141
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_ddc3b13b7768dfa2", undefined, undefined, &postmain_init );
}

// Namespace zm_sat_scarab_rh_coffin
// Params 0, eflags: 0x4
// Checksum 0x2b1efa9f, Offset: 0x162
// Size: 0x7f
function private postmain_init()
{
    if ( !getdvarint( @"enable_rh", 0 ) )
    {
        return;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level callback::add( "rh_toys_set", &function_8b42f6b34089b053 );
    
    if ( !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        level utility::flag_wait_or_timeout( "rh_validation_set", 120 );
    }
    
    if ( !level.rh_enabled && !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        return;
    }
    
    /#
        level thread function_8fc7769142efc2a6();
    #/
}

// Namespace zm_sat_scarab_rh_coffin
// Params 1
// Checksum 0x3924105d, Offset: 0x1e9
// Size: 0x35f
function function_8b42f6b34089b053( params )
{
    player = params.player;
    map = params.map;
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( player.var_fcb89b0f4082ab ) )
        {
            player.var_fcb89b0f4082ab = [];
        }
        
        var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
        
        if ( player namespace_e9202f9dfde1fc3a::can_spawn_toys( map ) )
        {
            if ( map == "zm_sat_firefly" )
            {
                s_loc = get_cabinet_struct( "1" );
                scr_toy = spawnscriptable( %"hash_1fe73125f4807aa5", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
            }
            else if ( map == "zm_sat_ruby" )
            {
                s_loc = get_cabinet_struct( "2" );
                scr_toy = spawnscriptable( %"hash_784d0f605e424377", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
            }
            else if ( map == "zm_sat_mantis" )
            {
                s_loc = get_cabinet_struct( "3" );
                scr_toy = spawnscriptable( %"hash_710bceeae6bbc2db", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
            }
            else if ( map == "zm_sat_locust" )
            {
                s_loc = get_cabinet_struct( "5" );
                scr_toy = spawnscriptable( %"hash_260c0eeb4cffbe71", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
            }
            else if ( map == "zm_sat_hornet" )
            {
                s_loc = get_cabinet_struct( "4" );
                scr_toy = spawnscriptable( %"hash_784d10605e42452a", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
            }
            else if ( map == "zm_sat_scarab" )
            {
                s_loc = get_cabinet_struct( "6" );
                scr_toy = spawnscriptable( %"hash_477b41eb17a3aa26", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
            }
        }
        
        if ( player.var_fcb89b0f4082ab.size == 6 )
        {
            foreach ( toy in player.var_fcb89b0f4082ab )
            {
                toy utility::function_7c10ea82c1e305b8( "glow", "on" );
            }
        }
    }
}

// Namespace zm_sat_scarab_rh_coffin
// Params 1
// Checksum 0x6868ab2c, Offset: 0x550
// Size: 0xbe
function get_cabinet_struct( id )
{
    a_structs = utility::getstructarray( "bird", "targetname" );
    
    if ( !isdefined( a_structs ) || a_structs.size == 0 )
    {
        return;
    }
    
    foreach ( struct in a_structs )
    {
        if ( !isdefined( struct ) )
        {
            continue;
        }
        
        if ( id == struct.script_noteworthy )
        {
            return struct;
        }
    }
}

/#

    // Namespace zm_sat_scarab_rh_coffin
    // Params 0
    // Checksum 0xca11de97, Offset: 0x616
    // Size: 0x2e, Type: dev
    function function_8fc7769142efc2a6()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x45>", "<dev string:x45>", &spawn_all_toys );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_rh_coffin
    // Params 0
    // Checksum 0x47679e3f, Offset: 0x64c
    // Size: 0x180, Type: dev
    function spawn_all_toys()
    {
        var_7c170ceae0649b57 = [ #"teamselect", level.players[ 0 ] getentitynumber() ];
        s_loc = get_cabinet_struct( "<dev string:x54>" );
        scr_toy = spawnscriptable( %"hash_1fe73125f4807aa5", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
        s_loc = get_cabinet_struct( "<dev string:x56>" );
        scr_toy = spawnscriptable( %"hash_784d0f605e424377", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
        s_loc = get_cabinet_struct( "<dev string:x58>" );
        scr_toy = spawnscriptable( %"hash_710bceeae6bbc2db", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
        s_loc = get_cabinet_struct( "<dev string:x5a>" );
        scr_toy = spawnscriptable( %"hash_260c0eeb4cffbe71", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
        s_loc = get_cabinet_struct( "<dev string:x5c>" );
        scr_toy = spawnscriptable( %"hash_784d10605e42452a", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
        s_loc = get_cabinet_struct( "<dev string:x5e>" );
        scr_toy = spawnscriptable( %"hash_477b41eb17a3aa26", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
    }

#/
