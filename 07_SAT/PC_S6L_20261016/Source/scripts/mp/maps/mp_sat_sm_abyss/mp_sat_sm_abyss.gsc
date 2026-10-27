// scripts\mp\maps\mp_sat_sm_abyss\mp_sat_sm_abyss.gsc  (hash_5da7eaee02bf3df9.gscc) (size: 3777 Bytes / 0xec1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x912650e8 (2435207400)
// size ...... 3777 (0xec1)
// includes .. 9   (offset: 0xd81)
// strings ... 19  (offset: 0xdc9)
// dev strs .. 0   (offset: 0xec1)
// exports ... 10  (offset: 0x7bd)
// cseg ...... 0x169 + 0x654 (0x7bd)
// imports ... 37  (offset: 0x94d)
// animtree1 . 0   (offset: 0xec1)
// animtree2 . 0   (offset: 0xec1)
#using script_4592670a60fb0195;
#using scripts\common\active_env\moving_platforms;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_abyss\gen\mp_sat_sm_abyss_art;
#using scripts\mp\maps\mp_sat_sm_abyss\mp_sat_sm_abyss_fx;
#using scripts\mp\maps\mp_sat_sm_abyss\mp_sat_sm_abyss_lighting;
#using scripts\mp\maps\mp_sat_sm_abyss\mp_sat_sm_abyss_periscope;

#namespace mp_sat_sm_abyss;

// Namespace mp_sat_sm_abyss
// Params 0
// Checksum 0xf6a9c2d8, Offset: 0x187
// Size: 0x95
function main()
{
    mp_sat_sm_abyss_art::main();
    mp_sat_sm_abyss_fx::main();
    mp_sat_sm_abyss_lighting::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_sm_abyss" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread namespace_b3087bd586139a5a::function_7b5b0ace3857f472();
    level thread mp_sat_sm_abyss_periscope::init_periscope();
    level thread moving_platforms::moving_platforms_init();
    level thread function_6f86e9e5f1a96877();
}

// Namespace mp_sat_sm_abyss
// Params 2, eflags: 0x4
// Checksum 0xdc448932, Offset: 0x224
// Size: 0x30
function private trigger_hurt_custom_enter( var_73000a9a933f3e88, trigger )
{
    if ( isplayer( var_73000a9a933f3e88 ) )
    {
        if ( isalive( var_73000a9a933f3e88 ) )
        {
            var_73000a9a933f3e88 function_184f53ac053b0b15();
        }
    }
}

// Namespace mp_sat_sm_abyss
// Params 2, eflags: 0x4
// Checksum 0x4160e91c, Offset: 0x25c
// Size: 0x15
function private trigger_hurt_custom_exit( var_73000a9a933f3e88, trigger )
{
    
}

// Namespace mp_sat_sm_abyss
// Params 0, eflags: 0x4
// Checksum 0xd2a0107f, Offset: 0x279
// Size: 0x31
function private function_184f53ac053b0b15()
{
    if ( !arraycontains( level.var_c4186935e13c29bf, self ) )
    {
        function_dc035b6d9bb172fd();
        level.var_c4186935e13c29bf[ level.var_c4186935e13c29bf.size ] = self;
    }
}

// Namespace mp_sat_sm_abyss
// Params 0, eflags: 0x4
// Checksum 0xd9be26d, Offset: 0x2b2
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

// Namespace mp_sat_sm_abyss
// Params 2, eflags: 0x4
// Checksum 0xa1164d41, Offset: 0x2f5
// Size: 0x23
function private function_aeaeba94d70d29a8( e_player, str_state )
{
    e_player setscriptablepartstate( "ice_build_FX", str_state );
}

// Namespace mp_sat_sm_abyss
// Params 0, eflags: 0x4
// Checksum 0xa580dbc4, Offset: 0x320
// Size: 0x47
function private function_dc035b6d9bb172fd()
{
    self.n_tick_counter = 0;
    self.var_b1147892811890e7 = 1;
    self.var_4bfcff2b7dbb34ac = 3;
    self.var_4bc4244463213448 = 0;
    self.str_current_state = "reset";
    function_aeaeba94d70d29a8( self, "reset" );
}

// Namespace mp_sat_sm_abyss
// Params 0, eflags: 0x4
// Checksum 0xf4aff0b9, Offset: 0x36f
// Size: 0x80, Type: bool
function private function_f1db480eddaacea1()
{
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

// Namespace mp_sat_sm_abyss
// Params 0, eflags: 0x4
// Checksum 0x6b50cb33, Offset: 0x3f8
// Size: 0x3c5
function private function_6f86e9e5f1a96877()
{
    level endon( #"exitlevel_called" );
    level waittill( #"prematch_started" );
    level.var_c4186935e13c29bf = [];
    level.t_ice_water = getent( "trigger_hurt_custom", #script_noteworthy );
    
    if ( isdefined( level.t_ice_water ) )
    {
        trigger::makeenterexittrigger( level.t_ice_water, &trigger_hurt_custom_enter, &trigger_hurt_custom_exit );
    }
    
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
                        else if ( player.var_b1147892811890e7 <= 1 )
                        {
                            player.var_b1147892811890e7 += 7.5;
                        }
                        else
                        {
                            player function_c0bb24bd300d7565();
                        }
                        
                        if ( player.var_4bfcff2b7dbb34ac <= 3 )
                        {
                            player.var_4bfcff2b7dbb34ac += 7.5;
                        }
                    }
                    
                    clamp( player.var_b1147892811890e7, 0, 1 );
                    clamp( player.var_4bfcff2b7dbb34ac, 0, 3 );
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

