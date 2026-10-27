// script_480bb8d22e030f14  (hash_480bb8d22e030f14.gscc) (size: 4864 Bytes / 0x1300 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x990874e9 (2567468265)
// size ...... 4864 (0x1300)
// includes .. 7   (offset: 0x11c8)
// strings ... 19  (offset: 0x1200)
// dev strs .. 0   (offset: 0x1300)
// exports ... 11  (offset: 0xa8c)
// cseg ...... 0x1e8 + 0x8a4 (0xa8c)
// imports ... 49  (offset: 0xc44)
// animtree1 . 0   (offset: 0x1300)
// animtree2 . 0   (offset: 0x1300)
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\damage;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight;
#using scripts\mp\zm\systems\zm_quest;

#namespace namespace_a2abfabbd7a982fc;

// Namespace namespace_a2abfabbd7a982fc
// Params 1
// Checksum 0xf4b43f28, Offset: 0x206
// Size: 0x143
function function_a110c6bb969aea4d( var_844a74aceafb732f )
{
    level endon( #"game_ended" );
    
    foreach ( index, var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72.var_ce48f2c047f39d9 = index;
        var_576d220b01160c72 thread function_8bae66641a0bec2();
    }
    
    thread zm_quest::update_guidance( [ [ level.s_dark_heart.var_dd5147eb36a3795b[ 0 ].var_6b70d581e6e6843c[ 0 ] ], [ level.s_dark_heart.var_dd5147eb36a3795b[ 1 ].var_6b70d581e6e6843c[ 0 ] ], [ level.s_dark_heart.var_dd5147eb36a3795b[ 2 ].var_6b70d581e6e6843c[ 0 ] ] ], #"mantis_mq_guidance", #"hash_2779cf97f29bfbe7" );
}

// Namespace namespace_a2abfabbd7a982fc
// Params 0
// Checksum 0x739abf97, Offset: 0x351
// Size: 0x12c
function function_8bae66641a0bec2()
{
    level endon( #"game_ended" );
    var_cb675ba16ad4fc66 = [];
    
    foreach ( index, time_knot in self.var_6b70d581e6e6843c )
    {
        time_knot.myowner = self;
        time_knot thread spawn_time_knot( level.s_dark_heart.phase_data[ "phase_2" ].var_d912e26b01baf2bf, level.s_dark_heart.phase_data[ "phase_2" ].var_ba1a99d9d41baedb, time_knot.targetname + string( index ) );
        var_cb675ba16ad4fc66[ var_cb675ba16ad4fc66.size ] = time_knot.targetname + string( index );
    }
    
    level utility::flag_wait_all_array( var_cb675ba16ad4fc66 );
    self.b_released = 1;
    zm_sat_mantis_boss_fight::function_3176083662ac618d( 0 );
}

// Namespace namespace_a2abfabbd7a982fc
// Params 3
// Checksum 0x7f71f6e6, Offset: 0x485
// Size: 0x158
function spawn_time_knot( var_f93a08c86c2cd513, var_f942691f0182b60d, str_flag )
{
    level endon( #"game_ended" );
    self.var_f109c8ae1b7b81e0 = 0;
    self.var_65e18da5b1320c72 = utility::spawn_model( "sat_zm_mantis_papq_knot", self.origin );
    self.var_65e18da5b1320c72 setscriptablepartstate( "body", "locked" );
    self.var_65e18da5b1320c72 thread damage::monitordamage( var_f93a08c86c2cd513, "hithealth", &function_4b7c8fbdead0eff5 );
    self.var_65e18da5b1320c72 waittill( #"hash_49a826a8a8eb3ea2" );
    self.var_65e18da5b1320c72 damage::monitordamageend();
    self.var_f942691f0182b60d = var_f942691f0182b60d;
    thread cannonball_zombies( var_f942691f0182b60d );
    function_c9950d6a489cd23f();
    zm_quest::function_5b5c737326035ea( self.myowner.var_ce48f2c047f39d9 );
    zm_sat_mantis_boss_fight::release_holdout( self.myowner );
    
    if ( isdefined( str_flag ) )
    {
        level utility::flag_set( str_flag );
    }
    
    waitframe();
    self.myowner.mdl.sbl setscriptablepartstate( "vfx", "pre_shield" );
    self.var_65e18da5b1320c72 setscriptablepartstate( "body", "destroyed" );
    wait 0.5;
    self.var_65e18da5b1320c72 delete();
}

// Namespace namespace_a2abfabbd7a982fc
// Params 1
// Checksum 0x23ee8de8, Offset: 0x5e5
// Size: 0x26
function function_4b7c8fbdead0eff5( params )
{
    self notify( #"hash_49a826a8a8eb3ea2" );
    level notify( #"hash_49a826a8a8eb3ea2", params );
}

// Namespace namespace_a2abfabbd7a982fc
// Params 1
// Checksum 0x4068224e, Offset: 0x613
// Size: 0x1d9
function cannonball_zombies( var_f942691f0182b60d )
{
    level endon( #"game_ended" );
    
    if ( utility::ent_flag( "cannonball_zombies_spawned" ) )
    {
        utility::ent_flag_clear( "cannonball_zombies_spawned" );
    }
    
    self.spawned_zombies = [];
    settings = zombie_cannonball::adv_settings( 0.5, 20, 0 );
    i = 0;
    
    while ( i < var_f942691f0182b60d )
    {
        playfx( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_knot_pulse" ), self.origin );
        playsoundatpos( self.origin, "evt_temporal_storm_knot_pulse_spawn_zombie" );
        launch_direction = anglestoforward( ( 0, randomfloat( 360 ), 0 ) );
        zombie = zm_quest::spawn_zombies_at_location( "zombie_base", ( 0, 0, 0 ), 1, 0, undefined, 1, undefined, 1 )[ 0 ];
        
        if ( isdefined( zombie ) )
        {
            zombie invisiblenotsolid();
            zombie.origin = self.origin;
            zombie thread function_b2c8080802968641( self );
            beam_target = zombie function_a18b43656e601486();
            zombie.beam = function_f5f8abcd7522eee2( utility::getfx( "vfx_sat_levels_zm_mantis_temporal_storm_beam_zombie" ), zombie gettagorigin( beam_target, 1 ) ?? zombie.origin, self.origin );
            zombie thread function_6cb208e0d80a9c4e( self );
            zombie thread zombie_cannonball::cannonball_ai( launch_direction, 200, settings, "roll_forward" );
            waitframe();
            zombie visiblesolid();
            zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
            zombie.var_7843e28f7ad65080 = self;
            zombie callback::add( "on_zombie_ai_killed", &function_11abbe6f795df41f );
            self.spawned_zombies[ self.spawned_zombies.size ] = zombie;
            i++;
        }
        
        wait 0.2;
    }
    
    utility::ent_flag_set( "cannonball_zombies_spawned" );
}

// Namespace namespace_a2abfabbd7a982fc
// Params 1
// Checksum 0x67a718ff, Offset: 0x7f4
// Size: 0xa1
function function_11abbe6f795df41f( params )
{
    time_knot = self.var_7843e28f7ad65080;
    time_knot.spawned_zombies = arrayremove( time_knot.spawned_zombies, self );
    time_knot.spawned_zombies = function_5713d46873b29625( time_knot.spawned_zombies );
    
    if ( isdefined( self.beam ) )
    {
        self.beam delete();
    }
    
    if ( params.eattacker != self.var_7843e28f7ad65080.var_65e18da5b1320c72 )
    {
        time_knot.var_f109c8ae1b7b81e0++;
    }
}

// Namespace namespace_a2abfabbd7a982fc
// Params 0
// Checksum 0xe9188f25, Offset: 0x89d
// Size: 0x7d
function function_c9950d6a489cd23f()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !utility::ent_flag( "cannonball_zombies_spawned" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.spawned_zombies.size == 0 )
        {
            if ( self.var_f109c8ae1b7b81e0 >= self.var_f942691f0182b60d )
            {
                break;
            }
            else
            {
                var_e4e8616556d50d02 = self.var_f942691f0182b60d - self.var_f109c8ae1b7b81e0;
                thread cannonball_zombies( var_e4e8616556d50d02 );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_a2abfabbd7a982fc
// Params 0, eflags: 0x4
// Checksum 0x69916869, Offset: 0x922
// Size: 0x37
function private function_a18b43656e601486()
{
    if ( isdefined( self.model ) )
    {
        return ( modelhastag( self.model, "j_spineupper" ) ? "j_spineupper" : "tag_origin" );
    }
    
    return "tag_origin";
}

// Namespace namespace_a2abfabbd7a982fc
// Params 1, eflags: 0x4
// Checksum 0x782623f9, Offset: 0x962
// Size: 0x99
function private function_6cb208e0d80a9c4e( var_aefb555866741102 )
{
    level endon( #"papq_end" );
    self endon( #"death" );
    
    while ( isdefined( self.beam ) )
    {
        beam_target = function_a18b43656e601486();
        
        if ( !isdefined( beam_target ) && isdefined( self.beam ) )
        {
            self.beam delete();
            return;
        }
        
        self.beam function_13a61377e568d700( self gettagorigin( beam_target, 1 ) ?? self.origin, var_aefb555866741102.origin );
        waitframe();
    }
}

// Namespace namespace_a2abfabbd7a982fc
// Params 1, eflags: 0x4
// Checksum 0xf21395cf, Offset: 0xa03
// Size: 0x89
function private function_b2c8080802968641( var_aefb555866741102 )
{
    level endon( #"papq_end" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( distancesquared( self.origin, var_aefb555866741102.origin ) > squared( getdvarfloat( @"hash_2791ebb9d5489a27", 600 ) ) )
        {
            zombie_stun::stun_ai( 1 );
            wait 1;
            self.forceannihilate = 1;
            self kill( undefined, var_aefb555866741102.var_65e18da5b1320c72 );
            return;
        }
        
        wait 1;
    }
}

