// scripts\mp\zm\gametypes\zm_rb_r_mod.gsc  (hash_60b9c6f799b0d5d8.gscc) (size: 7061 Bytes / 0x1b95 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2e2932e (3806499630)
// size ...... 7061 (0x1b95)
// includes .. 8   (offset: 0x1951)
// strings ... 37  (offset: 0x1991)
// dev strs .. 2   (offset: 0x1b7d)
// exports ... 23  (offset: 0xec5)
// cseg ...... 0x394 + 0xb31 (0xec5)
// imports ... 59  (offset: 0x125d)
// animtree1 . 0   (offset: 0x1b95)
// animtree2 . 0   (offset: 0x1b95)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\gametypes\zm_rb;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_rb_r_mod;

// Namespace zm_rb_r_mod
// Params 0, eflags: 0x5
// Checksum 0x280cc42c, Offset: 0x3b2
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_rb_r_mod", undefined, &pre_main, &post_main );
}

// Namespace zm_rb_r_mod
// Params 0
// Checksum 0x76a74927, Offset: 0x3d7
// Size: 0xa5
function main()
{
    if ( !is_mode_zm_rb_r_mod() )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "zm_rb_r_mod_survival" )
    {
        zm_rb_survival::main();
        level callback::add( "on_round_start", &function_78a05ca7518e025f );
        level callback::add( "on_round_end", &function_d96aed2dfc1b1f2c );
        return;
    }
    
    if ( game_utility::getgametype() == "zm_rb_rh_mod" )
    {
        zm_rb::main();
        level.var_6a45d9ce4d5f5e82 = %"hash_4892c7f3a800e1e8";
        level thread init_zm_rb_rh_mod();
        level.var_8a98c33a6b47db4a = 1;
        level.var_d73c5ded92f4f4bd = 1;
        level.var_6891dd100da9df37 = 1;
        return;
    }
    
    zm_rb::main();
}

// Namespace zm_rb_r_mod
// Params 0, eflags: 0x4
// Checksum 0x2e1a5ecd, Offset: 0x484
// Size: 0x29
function private init_zm_rb_rh_mod()
{
    utility::flag_wait_or_timeout( "zm_rb_rh_mod_initialized", 10 );
    utility::callsharedfunc( #"zm_rb_rh_mod", #"main" );
}

// Namespace zm_rb_r_mod
// Params 0, eflags: 0x4
// Checksum 0xe6bf98e0, Offset: 0x4b5
// Size: 0x25
function private pre_main()
{
    if ( !is_mode_zm_rb_r_mod() )
    {
        return;
    }
    
    level.var_8a98c33a6b47db4a = 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_rb_r_mod
// Params 0, eflags: 0x4
// Checksum 0xcb225bb, Offset: 0x4e2
// Size: 0xce
function private post_main()
{
    if ( !is_mode_zm_rb_r_mod() )
    {
        return;
    }
    
    level.var_2d25ada27bbb5f35 = 1;
    level.var_f5062c36d13e920c = 1;
    params = { #var_557b1d29216f692b:"sat_pi_alcor_mp", #melee_override:"sat_me_knife_mp", #lethal_override:"sat_frag_grenade_zm" };
    level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d6ffe8bb178fbd1f", params );
    
    if ( utility::issharedfuncdefined( #"zm_mode_modifiers", #"set_classic_points" ) )
    {
        level utility::callsharedfunc( #"zm_mode_modifiers", #"set_classic_points" );
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    
    /#
        iprintlnbold( "<dev string:x3a>" );
    #/
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0xf41abe8, Offset: 0x5b8
// Size: 0x32, Type: bool
function function_dca20960f17b024e( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedRModItem" ) || getdvarint( @"zm_r_mod_unlocked", 0 );
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0x6a60e81f, Offset: 0x5f3
// Size: 0x21
function function_c01042c7810d30a5( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedRModItem", 0 );
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0x81705e32, Offset: 0x61d
// Size: 0x22
function function_e650e7b9546885a8( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedRModItem", 1 );
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0x2ee8c7eb, Offset: 0x648
// Size: 0x22
function function_a607582307100c98( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedRModItem", 2 );
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0x876577bc, Offset: 0x673
// Size: 0x22
function function_9dfb7a015141021e( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedRModItem", 3 );
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0xf8bafc11, Offset: 0x69e
// Size: 0x22
function function_6ea91dc0353e88b8( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedRModItem", 4 );
}

// Namespace zm_rb_r_mod
// Params 1
// Checksum 0x23ab9b2d, Offset: 0x6c9
// Size: 0x32, Type: bool
function function_887f2f1c4ea09d91( player )
{
    return player getplayerdata( level.loadoutsgroup, "equippedMRPMode" ) || getdvarint( @"hash_7f3a78389cf0b692", 0 );
}

// Namespace zm_rb_r_mod
// Params 0, eflags: 0x4
// Checksum 0xa05d7012, Offset: 0x704
// Size: 0x8, Type: bool
function private is_mode_zm_rb_r_mod()
{
    return game_utility::function_d68874417f3eea5c();
}

// Namespace zm_rb_r_mod
// Params 1, eflags: 0x4
// Checksum 0x8ee8b9a6, Offset: 0x715
// Size: 0x28a
function private on_player_connect( params )
{
    if ( !level.var_28359899eb71db4b )
    {
        level.var_28359899eb71db4b = gettime();
        logstring( "[R_MOD] Starting player unlock validation at timestamp: " + gettime() + "ms" );
    }
    
    var_852621c77d569e4f = getdvarint( @"hash_f0d872030e10bf53", 10000 );
    var_775aa5568f796f35 = abs( gettime() - level.var_28359899eb71db4b ) <= var_852621c77d569e4f;
    
    if ( level.onlinegame && var_775aa5568f796f35 )
    {
        level.var_a2a101c72300bd85 = 0;
        map_name = game_utility::getmapname();
        
        if ( function_c01042c7810d30a5( self ) && map_name && issubstr( map_name, "firefly" ) )
        {
            level.var_df10a374e4c21ceb = 1;
            level.var_a2a101c72300bd85 = 1;
            logstring( "[R_MOD] Player: " + self.name + " has unlocked Relic Easter Eggs In FireFly!" );
        }
        
        if ( function_e650e7b9546885a8( self ) && map_name && issubstr( map_name, "ruby" ) )
        {
            level.var_f504cb20a9eeb54c = 1;
            level.var_a2a101c72300bd85 = 1;
            logstring( "[R_MOD] Player: " + self.name + " has unlocked Relic Easter Eggs In Ruby!" );
        }
        
        if ( function_a607582307100c98( self ) && map_name && issubstr( map_name, "mantis" ) )
        {
            level.var_49d838013a096e6c = 1;
            level.var_a2a101c72300bd85 = 1;
            logstring( "[R_MOD] Player: " + self.name + " has unlocked Relic Easter Eggs In Mantis!" );
        }
        
        if ( function_9dfb7a015141021e( self ) && map_name && issubstr( map_name, "locust" ) )
        {
            level.var_bffa8890dbd9dca = 1;
            level.var_a2a101c72300bd85 = 1;
            logstring( "[R_MOD] Player: " + self.name + " has unlocked Relic Easter Eggs in Locust!" );
        }
        
        if ( function_6ea91dc0353e88b8( self ) && map_name && issubstr( map_name, "hornet" ) )
        {
            level.var_75e4ad2e594a0834 = 1;
            level.var_a2a101c72300bd85 = 1;
            logstring( "[R_MOD] Player: " + self.name + " has unlocked Relic Easter Eggs in Hornet!" );
        }
        
        if ( self isfireteamleader() && game_utility::getgametype() == "zm_rb_rh_mod" )
        {
            if ( !function_887f2f1c4ea09d91( self ) )
            {
                level thread gamelogic_zm::forceend( game[ "end_reason" ][ "mpm_mode_validation_failed" ] );
            }
        }
        
        if ( level.var_a2a101c72300bd85 )
        {
            level utility::flag_set( "cursed_mode_validation_set" );
        }
    }
    
    self setclientomnvar( "ui_show_tac_map", 0 );
}

// Namespace zm_rb_r_mod
// Params 0
// Checksum 0xb9422cba, Offset: 0x9a7
// Size: 0x12f
function function_2d620be90b9d8657()
{
    level.r_tablet = spawnscriptable( %"zm_relic_t_unlock", level.var_d55f004bd25138f1.origin, level.var_d55f004bd25138f1.angles );
    level.r_tablet thread function_a4d5580b706de841( 5 );
    waitframe();
    level.r_tablet_interact = zm_quest::function_91f9590e98d57ff6( level.r_tablet.origin, &function_a2ee27e4c3d4fee1, &function_22045593d3073b9d, "small" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.r_tablet ) && !player function_f0b243c1a9acc44d() )
        {
            level.r_tablet_interact enablescriptableplayeruse( player );
            continue;
        }
        
        level.r_tablet_interact disablescriptableplayeruse( player );
    }
}

// Namespace zm_rb_r_mod
// Params 2
// Checksum 0x85c46277, Offset: 0xade
// Size: 0x7a
function function_22045593d3073b9d( interact, player )
{
    return { #icon:"sat_ui_icon_gamemode_zm_r_mod_sm", #buttoncallout:&"zm_sat_firefly/firefly_r_mod_unlock", #description:&"zm_sat_firefly/r_mod_desc", #title:&"zm_sat_firefly/r_m_title", #string:&"zm_sat_firefly/firefly_r_mod_unlock", #type:"HINT_BUTTON" };
}

// Namespace zm_rb_r_mod
// Params 1, eflags: 0x4
// Checksum 0xec3e48cb, Offset: 0xb61
// Size: 0x156
function private function_a2ee27e4c3d4fee1( player )
{
    level.r_tablet_interact freescriptable();
    level.r_tablet setscriptablepartstate( "material", "off" );
    level.r_tablet setscriptablepartstate( "vfx", "off" );
    
    if ( !level.var_23850f4ef56baf27 )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_ee_unlock_relic_stinger", player );
        player setplayerdata( level.var_6f9b00680ed002d8, "zombieRMod", level.var_23850f4ef56baf27, 1 );
    }
    
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = level.var_9881b011f1094b24;
    params.var_be82617e5e8087bd = level.players;
    level callback::callback( "zm_sq_quest_complete", params );
    wait 5;
    level.r_tablet freescriptable();
}

// Namespace zm_rb_r_mod
// Params 0
// Checksum 0x40305044, Offset: 0xcbf
// Size: 0x3b
function function_f0b243c1a9acc44d()
{
    if ( !level.var_23850f4ef56baf27 )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "zombieRMod", level.var_23850f4ef56baf27 ) )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace zm_rb_r_mod
// Params 1, eflags: 0x4
// Checksum 0x72486682, Offset: 0xd03
// Size: 0xc6
function private function_a4d5580b706de841( bobspeed )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    moveable_link = utility::spawn_model( "tag_origin", self.origin, self.angles );
    utility::scriptable_setparententity( moveable_link );
    moveable_link thread function_3234c508cb3a52b();
    moveable_link movez( 3, 0.1 );
    moveable_link waittill( #"movedone" );
    move_dir = 1;
    acceleration_const = bobspeed * 0.25;
    
    while ( isdefined( self ) )
    {
        moveable_link movez( 5 * move_dir, bobspeed, acceleration_const, acceleration_const );
        moveable_link waittill( #"movedone" );
        move_dir *= -1;
    }
}

// Namespace zm_rb_r_mod
// Params 0, eflags: 0x4
// Checksum 0xa452e3a5, Offset: 0xdd1
// Size: 0x37
function private function_3234c508cb3a52b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( isdefined( self.linkedchildren[ 0 ] ) )
    {
        waitframe();
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace zm_rb_r_mod
// Params 1, eflags: 0x4
// Checksum 0xd69a2699, Offset: 0xe10
// Size: 0x44
function private function_78a05ca7518e025f( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_8b52dcc4e869e5e5" ) && params.roundnumber >= 100 )
    {
        level.var_feea89643359c08a = 1;
    }
}

// Namespace zm_rb_r_mod
// Params 1, eflags: 0x4
// Checksum 0x9d0111b6, Offset: 0xe5c
// Size: 0x69
function private function_d96aed2dfc1b1f2c( params )
{
    if ( params.roundnumber >= 100 && !level.var_feea89643359c08a )
    {
        switch ( level.zm_relic_tier )
        {
            case 1:
                break;
            case 2:
                break;
            case 3:
                break;
        }
    }
}

