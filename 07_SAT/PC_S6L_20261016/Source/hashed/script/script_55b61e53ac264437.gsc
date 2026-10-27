// script_55b61e53ac264437  (hash_55b61e53ac264437.gscc) (size: 2228 Bytes / 0x8b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x906ca1ff (2423038463)
// size ...... 2228 (0x8b4)
// includes .. 11  (offset: 0x734)
// strings ... 21  (offset: 0x78c)
// dev strs .. 0   (offset: 0x8b4)
// exports ... 4   (offset: 0x498)
// cseg ...... 0x19a + 0x2fe (0x498)
// imports ... 17  (offset: 0x538)
// animtree1 . 0   (offset: 0x8b4)
// animtree2 . 0   (offset: 0x8b4)
#using script_124c3dc959a2430c;
#using script_1459628e92c0f05a;
#using script_35543b8dc89223a6;
#using scripts\common\active_env\moving_platforms;
#using scripts\common\utility;
#using scripts\mp\animation_suite;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\sat_training_course;
#using scripts\mp\load;

#namespace namespace_65ecfd1724fd06ac;

// Namespace namespace_65ecfd1724fd06ac
// Params 0
// Checksum 0x4b59099b, Offset: 0x1b8
// Size: 0xe7
function main()
{
    namespace_f254d36f3163399e::main();
    namespace_da3902b02b690c7f::main();
    namespace_ea322b52c92d7525::main();
    load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    compass::setupminimap( "compass_map_mp_sat_the_forge_traincourse" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_409cf34875e21eb5 = 0.5;
    level.var_75d8bf80bd40a615 = 175;
    level.var_6dd339a918cc7198 = 64;
    level.var_5ac924e35a6a476 = 0.3;
    
    if ( game_utility::getgametype() == "training_course" )
    {
        thread sat_training_course::trainingcourse_init();
    }
    
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread animation_suite::animationsuite();
    level thread moving_platforms::moving_platforms_init();
}

// Namespace namespace_65ecfd1724fd06ac
// Params 0
// Checksum 0xe087838f, Offset: 0x2a7
// Size: 0xce
function forge_turret_controller()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    var_d837ba3329221216 = getscriptablearray( "forge_turret", #script_noteworthy );
    var_9cdd550610bb80d9 = getscriptablearray( "turret_pigeon", #script_noteworthy );
    
    if ( var_d837ba3329221216.size == 0 || var_9cdd550610bb80d9.size == 0 )
    {
        return;
    }
    
    if ( level.prematchperiod > 0 )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    for ( i = 0; i < var_d837ba3329221216.size ; i++ )
    {
        var_d837ba3329221216[ i ] setscriptablepartstate( "base", "idle" );
        var_9cdd550610bb80d9[ i ] setscriptablepartstate( "base", "fly_in" );
        childthread function_e64afe1da9c9e504( var_d837ba3329221216[ i ], var_9cdd550610bb80d9[ i ] );
    }
}

// Namespace namespace_65ecfd1724fd06ac
// Params 2
// Checksum 0xaef5d61e, Offset: 0x37d
// Size: 0x11b
function function_e64afe1da9c9e504( scr_forge_turret, var_e84a891c8565b66c )
{
    var_19369eb17170a50 = 0;
    var_d0e6552c7b13f061 = getdvarint( @"hash_aa28e36e07da4c54", 4 );
    var_99f989d038e733ce = getdvarint( @"hash_6aa38eb6bd5e7ab8", 1 );
    var_d0e6552c7b13f061 = max( 1, var_d0e6552c7b13f061 );
    var_99f989d038e733ce = max( 1, var_99f989d038e733ce );
    var_52d6df8a75442078 = 1;
    
    while ( true )
    {
        scr_forge_turret waittillmatch( #"scriptablenotification", #"idle_anim_done" );
        var_19369eb17170a50++;
        var_f3191c2eaf0284c8 = var_52d6df8a75442078 ? var_99f989d038e733ce : var_d0e6552c7b13f061;
        
        if ( var_19369eb17170a50 < var_f3191c2eaf0284c8 )
        {
            continue;
        }
        
        scr_forge_turret setscriptablepartstate( "base", "test_sequence" );
        var_e84a891c8565b66c setscriptablepartstate( "base", "turret_sequence" );
        var_52d6df8a75442078 = 0;
        scr_forge_turret waittillmatch( #"scriptablenotification", #"hash_b5c5532047d9d030" );
        scr_forge_turret setscriptablepartstate( "base", "idle" );
        var_e84a891c8565b66c setscriptablepartstate( "base", "fly_in" );
        var_19369eb17170a50 = 0;
    }
}

