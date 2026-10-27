// scripts\mp\maps\mp_sat_homestead\mp_sat_homestead.gsc  (hash_37f8ea6c2b5cf9bd.gscc) (size: 5379 Bytes / 0x1503 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde68b0ab (3731402923)
// size ...... 5379 (0x1503)
// includes .. 11  (offset: 0x133b)
// strings ... 27  (offset: 0x1393)
// dev strs .. 1   (offset: 0x14f7)
// exports ... 15  (offset: 0xabb)
// cseg ...... 0x213 + 0x8a8 (0xabb)
// imports ... 54  (offset: 0xd13)
// animtree1 . 0   (offset: 0x1503)
// animtree2 . 0   (offset: 0x1503)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_homestead\gen\mp_sat_homestead_art;
#using scripts\mp\maps\mp_sat_homestead\mp_sat_homestead_fx;
#using scripts\mp\maps\mp_sat_homestead\mp_sat_homestead_lighting;

#namespace mp_sat_homestead;

// Namespace mp_sat_homestead
// Params 0
// Checksum 0x8743c3fe, Offset: 0x231
// Size: 0x171
function main()
{
    mp_sat_homestead_art::main();
    mp_sat_homestead_fx::main();
    mp_sat_homestead_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_homestead" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    setdvar( @"hash_1673bfd92c93a024", 320 );
    callback::add( #"player_spawned", &on_player_spawned );
    level.var_c4186935e13c29bf = [];
    level.t_ice_water = getent( "trigger_hurt_custom", #script_noteworthy );
    
    if ( isdefined( level.t_ice_water ) )
    {
        trigger::makeenterexittrigger( level.t_ice_water, &trigger_hurt_custom_enter, &trigger_hurt_custom_exit );
    }
    
    level thread function_6f86e9e5f1a96877();
    level thread function_437f7b5fc91eb8fa();
    
    /#
        function_9c457e926dedece0();
    #/
    
    if ( getdvarint( @"hash_e452c497af332827", 0 ) )
    {
        level thread play_teaser();
    }
}

// Namespace mp_sat_homestead
// Params 1, eflags: 0x4
// Checksum 0x30565d25, Offset: 0x3aa
// Size: 0x23
function private on_player_spawned( params )
{
    if ( !utility::function_cfcadadaf7557e6b( self ) )
    {
        player::_setsuit( "sat_defaultsuit_mp_snow_deep" );
    }
}

// Namespace mp_sat_homestead
// Params 2, eflags: 0x4
// Checksum 0x77ab51da, Offset: 0x3d5
// Size: 0x3c
function private trigger_hurt_custom_enter( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( isplayer( var_fd3a9f9e9a2a06c2 ) )
    {
        if ( !isalive( var_fd3a9f9e9a2a06c2 ) || var_fd3a9f9e9a2a06c2 isonground() )
        {
            return;
        }
        
        var_fd3a9f9e9a2a06c2 function_184f53ac053b0b15();
    }
}

// Namespace mp_sat_homestead
// Params 2, eflags: 0x4
// Checksum 0x7b325848, Offset: 0x419
// Size: 0x15
function private trigger_hurt_custom_exit( var_cfc19047cc2d028c, trigger )
{
    
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0xec675714, Offset: 0x436
// Size: 0x31
function private function_184f53ac053b0b15()
{
    if ( !arraycontains( level.var_c4186935e13c29bf, self ) )
    {
        function_dc035b6d9bb172fd();
        level.var_c4186935e13c29bf[ level.var_c4186935e13c29bf.size ] = self;
    }
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0xffb4dcd1, Offset: 0x46f
// Size: 0x3b
function private function_c0bb24bd300d7565()
{
    if ( arraycontains( level.var_c4186935e13c29bf, self ) )
    {
        self.var_b7fd3ebe9ccfa0fd = 0;
        function_dc035b6d9bb172fd();
        level.var_c4186935e13c29bf = arrayremove( level.var_c4186935e13c29bf, self );
    }
}

// Namespace mp_sat_homestead
// Params 2, eflags: 0x4
// Checksum 0x533973fd, Offset: 0x4b2
// Size: 0x23
function private function_aeaeba94d70d29a8( e_player, str_state )
{
    e_player setscriptablepartstate( "ice_build_FX", str_state );
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0x57afe570, Offset: 0x4dd
// Size: 0x47
function private function_dc035b6d9bb172fd()
{
    self.n_tick_counter = 0;
    self.var_b1147892811890e7 = 5;
    self.var_4bfcff2b7dbb34ac = 15;
    self.var_4bc4244463213448 = 0;
    self.str_current_state = "reset";
    function_aeaeba94d70d29a8( self, "reset" );
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0xd8d6d9c5, Offset: 0x52c
// Size: 0x8d, Type: bool
function private function_f1db480eddaacea1()
{
    b_is_active_freezing = 0;
    
    if ( self isswimming() )
    {
        self.var_b7fd3ebe9ccfa0fd = 1;
        return true;
    }
    else if ( self isjumping() && self.var_b7fd3ebe9ccfa0fd )
    {
        self.var_b7fd3ebe9ccfa0fd = 0;
        return true;
    }
    else if ( self isonground() || self ismantling() )
    {
        if ( self istouching( level.t_ice_water ) )
        {
            self.var_b7fd3ebe9ccfa0fd = 1;
            return true;
        }
        else
        {
            self.var_b7fd3ebe9ccfa0fd = 0;
            return false;
        }
    }
    
    return false;
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0x8dcd23d3, Offset: 0x5c2
// Size: 0x36c
function private function_6f86e9e5f1a96877()
{
    level endon( #"game_ended" );
    
    if ( level.prematchperiodend > 0 )
    {
        level waittill( #"matchstarttimer_done" );
    }
    
    while ( true )
    {
        var_4a531313ea3ec7d = level.var_c4186935e13c29bf;
        
        foreach ( player in var_4a531313ea3ec7d )
        {
            if ( isalive( player ) )
            {
                if ( player.n_tick_counter < 1 )
                {
                    player.n_tick_counter += 0.21;
                }
                
                if ( player.n_tick_counter >= 1 )
                {
                    player.n_tick_counter = 0;
                    
                    if ( player function_f1db480eddaacea1() )
                    {
                        if ( player.var_b1147892811890e7 > 0 )
                        {
                            player.var_b1147892811890e7 -= 1;
                        }
                        else if ( player.var_4bc4244463213448 < 10 )
                        {
                            if ( player.str_current_state != "forward" )
                            {
                                player.str_current_state = "forward";
                                function_aeaeba94d70d29a8( player, "forward" );
                            }
                            
                            player.var_4bc4244463213448 += 1;
                        }
                        
                        if ( player.var_4bfcff2b7dbb34ac > 0 )
                        {
                            player.var_4bfcff2b7dbb34ac -= 1;
                        }
                        else if ( !isingodmode( player ) && !player isnoclip() )
                        {
                            player dodamage( 10, player.origin, player, level.t_ice_water, "MOD_FIRE" );
                            player playsoundtoplayer( "chr_ice_freeze_dmg", player );
                        }
                    }
                    else
                    {
                        if ( player.var_4bc4244463213448 > 0 )
                        {
                            if ( player.str_current_state != "reverse" )
                            {
                                player.str_current_state = "reverse";
                                var_44ebe474a4173728 = int( round( player.var_4bc4244463213448 / 10, 0.25 ) * 100 );
                                
                                if ( var_44ebe474a4173728 == 0 )
                                {
                                    function_aeaeba94d70d29a8( player, "reset" );
                                }
                                else
                                {
                                    function_aeaeba94d70d29a8( player, "reverse_" + var_44ebe474a4173728 );
                                }
                            }
                            
                            player.var_4bc4244463213448 -= 1;
                        }
                        else if ( player.var_b1147892811890e7 <= 5 )
                        {
                            player.var_b1147892811890e7 += 7.5;
                        }
                        else
                        {
                            player function_c0bb24bd300d7565();
                        }
                        
                        if ( player.var_4bfcff2b7dbb34ac <= 15 )
                        {
                            player.var_4bfcff2b7dbb34ac += 7.5;
                        }
                    }
                    
                    clamp( player.var_b1147892811890e7, 0, 5 );
                    clamp( player.var_4bfcff2b7dbb34ac, 0, 15 );
                    clamp( player.var_4bc4244463213448, 0, 10 );
                }
            }
            
            if ( !isalive( player ) )
            {
                player function_c0bb24bd300d7565();
            }
        }
        
        wait 0.21;
    }
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0xbfad1131, Offset: 0x936
// Size: 0xbc
function private function_437f7b5fc91eb8fa()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "rockable_cars_init" );
    var_cd1b8250379777d0 = [];
    var_cd1b8250379777d0 = arraycombine( var_cd1b8250379777d0, getscriptablearray( "lights_controller", #script_noteworthy ) );
    
    foreach ( scr_car in var_cd1b8250379777d0 )
    {
        scr_car setscriptablepartstate( "lights_controller", "on", 1 );
    }
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0xa81ec14, Offset: 0x9fa
// Size: 0x6d
function private play_teaser()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_455207c226282e7a = level.prematchperiodend <= 0;
    
    if ( !var_455207c226282e7a )
    {
        if ( game_utility_mp::isfirstround() )
        {
            level waittill( #"match_start_real_countdown" );
            wait 14;
        }
        else
        {
            level waittill( #"match_start_real_countdown" );
            wait 5;
        }
    }
    
    activateworldevent( "we_vfx_sleigh" );
}

// Namespace mp_sat_homestead
// Params 0, eflags: 0x4
// Checksum 0x1a57d46, Offset: 0xa6f
// Size: 0x17
function private function_9c457e926dedece0()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"play_teaser", &function_dee7f852fbfea865 );
}

// Namespace mp_sat_homestead
// Params 1, eflags: 0x4
// Checksum 0x67448e59, Offset: 0xa8e
// Size: 0x2d
function private function_dee7f852fbfea865( params )
{
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    deactivateworldevent( "we_vfx_sleigh" );
    activateworldevent( "we_vfx_sleigh" );
}

