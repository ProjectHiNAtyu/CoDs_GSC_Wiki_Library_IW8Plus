// scripts\mp\ob\save.gsc  (hash_6015fed41640593f.gscc) (size: 2768 Bytes / 0xad0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4dfc1d29 (1308368169)
// size ...... 2768 (0xad0)
// includes .. 8   (offset: 0xa00)
// strings ... 9   (offset: 0xa40)
// dev strs .. 0   (offset: 0xad0)
// exports ... 8   (offset: 0x5c4)
// cseg ...... 0xe3 + 0x4e1 (0x5c4)
// imports ... 25  (offset: 0x704)
// animtree1 . 0   (offset: 0xad0)
// animtree2 . 0   (offset: 0xad0)
#using scripts\common\callbacks;
#using scripts\common\save;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\flags;

#namespace save;

// Namespace save
// Params 0, eflags: 0x5
// Checksum 0x75028787, Offset: 0x101
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"save_ob", #"save", &pre_init_ob, undefined );
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0xf38a697f, Offset: 0x12a
// Size: 0xf9
function private pre_init_ob()
{
    level.coop_reload = getdvarint( @"ob_sm_reload", 0 );
    setdvar( @"ob_sm_reload", 0 );
    
    switch ( level.coop_reload )
    {
        case 0:
        case 2:
            mission_clear_data( #"transient" );
            break;
    }
    
    if ( level.coop_reload == 1 && isdefined( level.var_10459e4184c44ea4 ) )
    {
        function_bc5c3d231d744203();
        level thread [[ level.var_10459e4184c44ea4 ]]();
    }
    
    level callback::add( #"player_connect", &sm_on_player_connect );
    
    if ( level.coop_reload != 0 )
    {
        level.var_8671749938fb45db = 1;
        level utility::flag_set( "bink_complete" );
        level utility::flag_set( "squad_play_begin" );
        level thread sm_reload_fade_in_players();
        return;
    }
    
    setdvar( @"hash_c13903c5a48147e3", 1 );
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0xb34fd76b, Offset: 0x22b
// Size: 0x9
function private function_bc5c3d231d744203()
{
    flags::function_3e5944c25de5ff61();
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0xd88e0400, Offset: 0x23c
// Size: 0xed
function private sm_reload_fade_in_players()
{
    assert( level.coop_reload != 0 );
    coop::player_ready_check( undefined, 0, 0 );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player utility::ent_flag_set( "bink_complete" );
        player utility::ent_flag_set( "squad_play_begin" );
        squad = teams::function_72b89edf6b47c40a( player );
        squad utility::ent_flag_set( "bink_complete" );
        squad utility::ent_flag_set( "squad_play_begin" );
    }
    
    thread sm_reload_fade_in();
}

// Namespace save
// Params 1, eflags: 0x4
// Checksum 0xff8c22fe, Offset: 0x331
// Size: 0x1f
function private sm_on_player_connect( params )
{
    if ( level.coop_reload )
    {
        thread function_9fb362b5c2fd6c03();
    }
}

// Namespace save
// Params 0, eflags: 0xc
// Checksum 0xbf49778f, Offset: 0x358
// Size: 0x5f
function private function_9fb362b5c2fd6c03()
{
    self notify( #"hash_9b04bfc9e9b2dacd" );
    self endon( #"hash_9b04bfc9e9b2dacd" );
    assert( isplayer( self ) );
    player = self;
    player endon( #"hash_7843d437486ef9a", #"disconnect" );
    
    while ( true )
    {
        player thread coop::player_fade_with_shader( 1, 0 );
        waitframe();
    }
}

// Namespace save
// Params 0, eflags: 0x4
// Checksum 0x276a056b, Offset: 0x3bf
// Size: 0x205
function private sm_reload_fade_in()
{
    allplaying = 0;
    
    while ( !allplaying )
    {
        allplaying = 1;
        
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player val::set( "sm_reload_fade_in", "show_hud", 0 );
            player val::set( "sm_reload_fade_in", "freezecontrols", 1 );
            player val::set( "sm_reload_fade_in", "allow_movement", 0 );
            player val::set( "sm_reload_fade_in", "ignoreme", 1 );
            player val::set( "sm_reload_fade_in", "damage", 0 );
            
            if ( player.sessionstate != "playing" )
            {
                allplaying = 0;
            }
        }
        
        waitframe();
    }
    
    utility::players_stream_wait( level.players, level.coop_reload == 1 ? 6 : undefined );
    level.coop_reload = 0;
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player setclientdvar( @"hash_cb4dbcc0d4238fdf", 0 );
        player val::reset_all( "sm_reload_fade_in" );
        player notify( #"hash_7843d437486ef9a" );
        player thread coop::player_fade_with_shader( 0, 0.5 );
    }
    
    wait 1;
    setdvar( @"hash_c13903c5a48147e3", 1 );
}

