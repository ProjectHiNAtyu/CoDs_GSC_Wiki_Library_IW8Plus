// scripts\mp\common\powerups\frozen.gsc  (hash_549f4e82f12e518c.gscc) (size: 3001 Bytes / 0xbb9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52a5d2de (1386599134)
// size ...... 3001 (0xbb9)
// includes .. 7   (offset: 0xac5)
// strings ... 4   (offset: 0xafd)
// dev strs .. 5   (offset: 0xb7d)
// exports ... 8   (offset: 0x605)
// cseg ...... 0x96 + 0x56f (0x605)
// imports ... 29  (offset: 0x745)
// animtree1 . 0   (offset: 0xbb9)
// animtree2 . 0   (offset: 0xbb9)
#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace frozen;

// Namespace frozen
// Params 0, eflags: 0x1
// Checksum 0x5cb3d2eb, Offset: 0xb4
// Size: 0xa
function autoexec main()
{
    level thread init_frozen();
}

// Namespace frozen
// Params 1, eflags: 0x4
// Checksum 0x86acfbd2, Offset: 0xc6
// Size: 0x76
function private init_frozen( var_a53a6962d153065f )
{
    system::function_eca4bddb3f37e51b();
    
    if ( !powerups::function_66b5c6704004966d( "frozen" ) )
    {
        return;
    }
    
    powerups::register_powerup( "frozen", &function_903320fd0eec0f7c );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e>", "<dev string:x5b>", &devgui_powerup_frozen );
        devgui::function_cd4e263c1f3018ae( "<dev string:x71>", "<dev string:x9c>", &devgui_powerup_frozen );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace frozen
    // Params 1
    // Checksum 0xf1dfc471, Offset: 0x144
    // Size: 0xcc, Type: dev
    function devgui_powerup_frozen( params )
    {
        foreach ( player in level.players )
        {
            if ( player.team != params[ 0 ] )
            {
                player thread function_8e36ab348c76f469();
                return;
            }
        }
        
        level.players[ 0 ].var_e39ab0a9685d6e03 = level.players;
        level.players[ 0 ] thread function_8e36ab348c76f469();
    }

#/

// Namespace frozen
// Params 0
// Checksum 0x89ada8, Offset: 0x218
// Size: 0x4e
function function_8e36ab348c76f469()
{
    thread function_903320fd0eec0f7c( "frozen" );
    params = { #splash:"zm_griefstreak_frozen", #owner:self };
    utility::callsharedfunc( #"zm_grief", #"hash_efd919bddb0f5974", params );
}

// Namespace frozen
// Params 2
// Checksum 0x4a2c25d2, Offset: 0x26e
// Size: 0xeb
function function_903320fd0eec0f7c( str_powerup, ent_powerup )
{
    str_team = self.team;
    a_players = self.var_e39ab0a9685d6e03 ?? powerups::get_powerup_players( str_powerup );
    self.var_e39ab0a9685d6e03 = undefined;
    root = powerups::get_powerups_root();
    n_lifetime = powerups::function_f379817a62e3850c( "frozen", 1 );
    
    foreach ( player in a_players )
    {
        player thread function_b08a4dbc8695c17d( n_lifetime, root );
    }
}

// Namespace frozen
// Params 2, eflags: 0xc
// Checksum 0x282b044f, Offset: 0x361
// Size: 0x20f
function private function_b08a4dbc8695c17d( n_lifetime, root )
{
    self notify( #"hash_53a8c661a5385617" );
    self endon( #"hash_53a8c661a5385617" );
    self endon( #"disconnect" );
    thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( "frozen", n_lifetime );
    utility::function_7c10ea82c1e305b8( #"ltm_mode_fx", #"jh_freeze_on" );
    utility::ent_flag_set( "powerup_frozen" );
    self notify( #"hash_b4d05534452c225e" );
    
    if ( n_lifetime > 4 )
    {
        weapons::function_4512b7715789e4cf( "powerup_frozen", 0 );
        common::function_1f09590404e452e4( "powerup_frozen", 0 );
        weapons::updatemovespeedscale();
        utility::waittill_any_timeout( 4, "death" );
        
        if ( isalive( self ) )
        {
            n_move_speed_scalar = root.powerups[ "frozen" ].var_630df38d69e9d245 ?? 0.5;
            thread function_7617bb66bb19f507( n_move_speed_scalar );
            utility::waittill_any_timeout( 6, "death" );
            self notify( #"hash_b4d05534452c225e" );
            
            if ( isalive( self ) )
            {
                weapons::function_4512b7715789e4cf( "powerup_frozen", n_move_speed_scalar );
                common::function_1f09590404e452e4( "powerup_frozen", n_move_speed_scalar );
                weapons::updatemovespeedscale();
                n_remaining_time = n_lifetime - 4 - 6;
                utility::waittill_any_timeout( n_remaining_time, "death" );
            }
        }
    }
    else
    {
        n_move_speed_scalar = root.powerups[ "frozen" ].var_630df38d69e9d245 ?? 0.5;
        weapons::function_4512b7715789e4cf( "powerup_frozen", n_move_speed_scalar );
        common::function_1f09590404e452e4( "powerup_frozen", n_move_speed_scalar );
        weapons::updatemovespeedscale();
        utility::waittill_any_timeout( n_lifetime, "death" );
    }
    
    utility::ent_flag_clear( "powerup_frozen" );
    utility::function_7c10ea82c1e305b8( #"ltm_mode_fx", #"jh_freeze_off" );
    common::function_1f09590404e452e4( "powerup_frozen", 1 );
    weapons::function_986fc44dada307f4( "powerup_frozen" );
    weapons::updatemovespeedscale();
    wait 1;
    utility::function_7c10ea82c1e305b8( #"ltm_mode_fx", #"all_vfx_off" );
}

// Namespace frozen
// Params 1, eflags: 0x4
// Checksum 0x87ef688a, Offset: 0x578
// Size: 0x8d
function private function_7617bb66bb19f507( n_move_speed_scalar )
{
    self endon( #"disconnect", #"hash_b4d05534452c225e" );
    n_move_speed_step = n_move_speed_scalar / 6;
    n_tick_length = 0.05;
    n_current_speed_scalar = 0;
    
    while ( isalive( self ) && n_current_speed_scalar <= n_move_speed_scalar )
    {
        n_current_speed_scalar += n_move_speed_step * n_tick_length;
        weapons::function_4512b7715789e4cf( "powerup_frozen", n_current_speed_scalar );
        common::function_1f09590404e452e4( "powerup_frozen", n_current_speed_scalar );
        weapons::updatemovespeedscale();
        wait n_tick_length;
    }
}

