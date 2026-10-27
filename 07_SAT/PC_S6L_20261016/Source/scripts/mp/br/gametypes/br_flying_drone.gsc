// scripts\mp\br\gametypes\br_flying_drone.gsc  (hash_141c197ecc2ac486.gscc) (size: 43792 Bytes / 0xab10 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x587b8e32 (1484492338)
// size ...... 43792 (0xab10)
// includes .. 27  (offset: 0xa490)
// strings ... 71  (offset: 0xa568)
// dev strs .. 34  (offset: 0xa960)
// exports ... 106 (offset: 0x6f34)
// cseg ...... 0x4d5 + 0x6a5f (0x6f34)
// imports ... 301 (offset: 0x7fc4)
// animtree1 . 0   (offset: 0xab10)
// animtree2 . 0   (offset: 0xab10)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\functionals_utility;
#using scripts\common\math;
#using scripts\common\spatial_zone_container;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_peek;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\objidpoolmanager;

#namespace br_flying_drone;

// Namespace br_flying_drone
// Params 2
// Checksum 0xcfcf97b0, Offset: 0x4f3
// Size: 0x3e7
function function_d664e23d9508b462( spawnoptions, activity_instance )
{
    drone = 0;
    drone = spawn( "script_model", spawnoptions.spawnpos );
    drone setmodel( %"veh_saw_mil_air_drone_dart_leader_bongo" );
    drone setcandamage( spawnoptions.candamage );
    
    if ( spawnoptions.enableaimassist )
    {
        drone enableaimassist();
    }
    
    drone.spawn_pos = spawnoptions.spawnpos;
    drone.angles = spawnoptions.spawn_angles ?? ( 0, 0, 0 );
    drone.canmove = spawnoptions.canmove;
    drone.can_lootdrop = spawnoptions.canlootdrop;
    drone.goal = spawnoptions.goal ?? #"none";
    drone.launchexplosion = spawnoptions.launchexplosion ?? 1;
    drone.var_ab7bc43443a29388 = spawnoptions.var_ab7bc43443a29388;
    drone.var_1cb68d8eeac5c90d = spawnoptions.var_1cb68d8eeac5c90d ?? 0;
    drone.allow_visited = spawnoptions.allow_visited ?? 0;
    drone.showhealthbar = spawnoptions.showhealthbar ?? 1;
    drone.var_4aca1c6aee1548b7 = 1;
    drone.var_747f794eb2595108 = 0;
    drone.helperdrone_type = select_random_drone_type();
    drone.var_26ad585bf3f8d930 = spawnoptions.var_2858c1d9ffae3f84;
    drone.difficulty = spawnoptions.difficulty_region;
    
    if ( activity_instance )
    {
        activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
        drone.var_26ad585bf3f8d930 = activityvariantdefinition.var_2858c1d9ffae3f84;
        drone.difficulty = activity_instance.difficulty_region;
    }
    
    function_2021bb53c318b078( drone );
    drone.activity_instance = activity_instance;
    drone.type = %"main_drone";
    drone.var_d62ad5bfd64ba592 = "tag_origin";
    
    if ( drone.showhealthbar )
    {
        drone.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_206c315a33469052" );
        drone.var_24954f14e27b448d = 1;
    }
    
    drone.memory = { #bad_pos:[], #vis_stack:[] };
    drone.emp_speed_scale = 0.5;
    drone.static_idle = spawnoptions.static_idle ?? 0;
    
    if ( !level utility::issharedfuncdefined( #"flying_drone_unit", #"hack" ) )
    {
        level utility::registersharedfunc( #"flying_drone_unit", #"hack", &function_3ebe82fd94134869 );
    }
    
    drone emp_debuff::set_start_emp_callback( &add_emp );
    drone emp_debuff::set_clear_emp_callback( &remove_emp );
    
    if ( drone.canmove )
    {
        drone thread function_afbbd06f0ab74b0b();
        drone thread functionals_utility::function_3d1c0cb00ce4d44e( 20, 10, 7 );
        drone thread function_ee97628f4ae363d2( 1, drone.var_cf18d9f8c9aadf2c, "main_drone_destroyed" );
    }
    
    visibility_mode::function_3afc3bc470c80e61( drone, "team_hundred_ninety_seven" );
    
    if ( !isdefined( level.huntdrones ) )
    {
        level.huntdrones = [];
    }
    
    level.huntdrones[ level.huntdrones.size ] = drone;
    drone thread function_c905b1cd9125edb3();
    drone enableplayermarks( #"air_killstreak" );
    drone function_326ed7483e566ce4();
    return drone;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x2952d238, Offset: 0x8e3
// Size: 0x2e
function private function_cf1cc23975f9c938()
{
    self endon( #"main_drone_destroyed" );
    
    while ( true )
    {
        utility::waittill_any( "player_scanned", "damage" );
        thread drone_engaged();
    }
}

// Namespace br_flying_drone
// Params 3, eflags: 0x4
// Checksum 0x4ef05c81, Offset: 0x919
// Size: 0xfc
function private function_ee97628f4ae363d2( is_main_drone, var_bb87da9f15b57fae, deathnotifyoverride = "death" )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self endon( deathnotifyoverride );
    
    while ( true )
    {
        waitframe();
        
        if ( !self.targetplayer || self.goal == #"flee" )
        {
            continue;
        }
        
        if ( function_80f6e0b383eae3aa( is_main_drone ) )
        {
            if ( var_bb87da9f15b57fae )
            {
                wait var_bb87da9f15b57fae;
            }
            
            radius = is_main_drone ? self.var_82cedb79f1d56e1 : self.options.var_75fab83acb648e4e ?? 750;
            function_9878399de2b61b61( radius );
            
            if ( !self.targetplayer && is_main_drone )
            {
                self.goal = #"hash_6573e43fb6b70d11";
                function_e0de4dce57ae487();
                thread function_dbc3536438aea5e0();
            }
        }
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x26d716d8, Offset: 0xa1d
// Size: 0x86, Type: bool
function private function_80f6e0b383eae3aa( is_main_drone )
{
    if ( self.targetplayer.ignoreme || self.targetplayer.notarget )
    {
        return true;
    }
    
    if ( is_main_drone )
    {
        var_3a6934f5e814b149 = self.var_1a2c8816083e2770;
        distance_to_target = distancesquared( self.origin, self.targetplayer.origin );
        return ( distance_to_target > var_3a6934f5e814b149 );
    }
    
    return false;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xfa169acb, Offset: 0xaac
// Size: 0x75
function private set_target_player( new_target, debug )
{
    /#
        player_name = new_target ? new_target.name : "<dev string:x24>";
        
        if ( debug && getdvarint( @"hash_b6b8f93be406d1f", 0 ) )
        {
            iprintlnbold( self.model + "<dev string:x2e>" + player_name );
        }
    #/
    
    self.targetplayer = new_target;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xfc3330c7, Offset: 0xb29
// Size: 0x49
function private drone_engaged()
{
    self endon( #"main_drone_destroyed" );
    self endon( #"hash_53309d9cf6cef8" );
    self endon( #"death" );
    function_b62d57c03a13139d();
    utility::waittill_any_timeout( self.var_4922a62c04b53c20, "engage_phase" );
    function_5366327c25ea5eb2();
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x897d7da3, Offset: 0xb7a
// Size: 0x50
function private function_9878399de2b61b61( range, random_fallback )
{
    nearby_players = get_valid_nearby_players( range );
    closest_valid_player = get_closest_player( nearby_players, self.origin, range, random_fallback );
    set_target_player( closest_valid_player );
}

// Namespace br_flying_drone
// Params 4, eflags: 0x4
// Checksum 0x6dadaec8, Offset: 0xbd2
// Size: 0x5d
function private get_closest_player( players, origin, range, random_fallback )
{
    closest_player = undefined;
    
    if ( players.size > 0 )
    {
        closest_player = function_47c86977a18df38b( players, origin, range );
    }
    
    if ( !closest_player && random_fallback )
    {
        closest_player = function_c2373db857efa03( self );
    }
    
    return closest_player;
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xaa0db846, Offset: 0xc38
// Size: 0xc6
function private get_valid_nearby_players( var_67f9e5a5f6aed92 )
{
    nearbyplayers = getplayersinradius( self.origin, var_67f9e5a5f6aed92 );
    
    if ( nearbyplayers )
    {
        validplayers = [];
        
        foreach ( player in nearbyplayers )
        {
            if ( !player.ignoreme && !player.notarget )
            {
                validplayers[ validplayers.size ] = player;
            }
        }
    }
    
    return validplayers;
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x7c67185d, Offset: 0xd07
// Size: 0x26f
function private function_2021bb53c318b078( drone )
{
    var_3af1960784817aa8 = drone.var_26ad585bf3f8d930.var_3af1960784817aa8;
    var_5b5f27d5b9e3ff84 = drone.var_26ad585bf3f8d930.dronedifficulty;
    var_f263818e27888a37 = drone.var_26ad585bf3f8d930.var_16f2e0e09b0d8793;
    
    if ( !var_3af1960784817aa8 || !var_5b5f27d5b9e3ff84 || !var_f263818e27888a37 )
    {
        assertmsg( "<dev string:x42>" );
    }
    
    difficultysettings = drone function_2d29a63cff8b23fc( var_5b5f27d5b9e3ff84, var_f263818e27888a37 );
    function_992019640fb9a57e( drone, difficultysettings.difficulty );
    drone.loot_item_list = difficultysettings.lootitemlist;
    drone.loot_item_count = difficultysettings.var_96656a7c0b586e3e;
    drone.var_13393fdcef643f57 = difficultysettings.var_d94ade3fcf8eb28f;
    drone.var_d13e9fbd20acbc22 = squared( var_3af1960784817aa8.var_d527fe070d34d975 );
    drone.var_6f8e1815c814e080 = var_3af1960784817aa8.var_9d6e5c4f83529fed;
    drone.var_6f6b0e15c7ee82ca = var_3af1960784817aa8.var_9d4b464f832c27d3;
    drone.var_5e66b7c01aeca260 = var_3af1960784817aa8.var_6f91fe8c43809c29;
    drone.var_a4680a90389f44d6 = var_3af1960784817aa8.var_1b296c2e6e6d9a93;
    drone.var_4922a62c04b53c20 = var_3af1960784817aa8.var_e78c1777d326e787;
    drone.pingtimeout = var_3af1960784817aa8.var_492ad2865ab05fc4;
    drone.var_82cedb79f1d56e1 = var_3af1960784817aa8.var_9fc76fa9c11fbf46;
    drone.var_9f8e8ae05c599b85 = squared( drone.var_82cedb79f1d56e1 );
    drone.explosivedamageresistance = var_3af1960784817aa8.var_f12362f801752580;
    drone.var_cf18d9f8c9aadf2c = var_3af1960784817aa8.var_ba9d47e7795035fc ?? 1;
    drone.var_2062fb08de3993a8 = var_3af1960784817aa8.var_91c5217173fdf4fb ?? 3000;
    drone.var_1a2c8816083e2770 = squared( drone.var_2062fb08de3993a8 );
    drone.fleedistance = var_3af1960784817aa8.var_208144d2e1fce0be ?? 4000;
    drone.var_d5efa8ae738e81c = var_f263818e27888a37.var_985728444a03d820;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x90d91b2f, Offset: 0xf7e
// Size: 0x130
function private function_2d29a63cff8b23fc( var_5b5f27d5b9e3ff84, var_f263818e27888a37 )
{
    selecteddifficulty = var_5b5f27d5b9e3ff84.lvl1difficulty;
    var_ebb91a48b05fc839 = var_f263818e27888a37.var_fded57a906944459;
    
    switch ( self.difficulty )
    {
        case #"hash_af83e47edfa8900a":
            selecteddifficulty = var_5b5f27d5b9e3ff84.lvl2difficulty;
            var_ebb91a48b05fc839 = var_f263818e27888a37.var_2a3903fe77396bac;
            break;
        case #"hash_5343b465e56ec9a4":
            selecteddifficulty = var_5b5f27d5b9e3ff84.lvl3difficulty;
            var_ebb91a48b05fc839 = var_f263818e27888a37.var_a10af3d6b2113d87;
            break;
        case #"hash_651f76c0ad6741ec":
            selecteddifficulty = var_5b5f27d5b9e3ff84.var_bd1cf01969b3d151;
            var_ebb91a48b05fc839 = var_f263818e27888a37.var_af4d91a169ad1dfa;
            break;
        case #"hash_7bb2cd766703d463":
        default:
            break;
    }
    
    return { #var_d94ade3fcf8eb28f:var_ebb91a48b05fc839.var_d94ade3fcf8eb28f, #var_96656a7c0b586e3e:var_ebb91a48b05fc839.var_d34b703260bcafbe, #lootitemlist:var_ebb91a48b05fc839.var_2850ce95abe69659, #difficulty:selecteddifficulty };
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x8d6d8a63, Offset: 0x10b7
// Size: 0x31f
function private function_992019640fb9a57e( drone, difficultysettings )
{
    drone.cooldowndamage = difficultysettings.dronemovement.var_b3026cfc7e4daf26;
    drone.var_c48a311adb63f5da = difficultysettings.dronemovement.var_edf875e30f2f8517;
    drone.var_7a09c045385eacee = difficultysettings.dronemovement.var_9afdf5191ed4751;
    drone.movedistance = difficultysettings.dronemovement.drone_movedistance;
    drone.dashdistance = difficultysettings.dronemovement.var_68dfdedd55faba72;
    drone.var_4f9479db21cbaf60 = difficultysettings.dronemovement.var_aed01ab7cb6658fb;
    drone.alertmovetime = difficultysettings.dronemovement.var_f6e6c625fc0fcdf1;
    drone.engagedmovetime = difficultysettings.dronemovement.var_87d7945fbecb2fe2;
    drone.dashmovetime = difficultysettings.dronemovement.var_a5037729afceb0c5;
    drone.stationarytime = difficultysettings.dronemovement.var_582bb0ca7e32e33e;
    drone.var_afa203784875c0ba = difficultysettings.dronemovement.var_ea0b90fd208d0f05;
    drone.var_caddd4583ba66891 = difficultysettings.dronemovement.var_d1ff72ec13b33fda;
    drone.var_9c314d416ddd1b3b = difficultysettings.var_2f81e488ee941e35.var_a7be53be8c562950 * 0.01;
    drone.var_5872025589d5212a = difficultysettings.var_2f81e488ee941e35.var_dba813c2547d1e65;
    drone.var_1fb9c0976545cc48 = difficultysettings.var_2f81e488ee941e35.var_26be19cde5d33b33;
    drone.var_5d4aa07606eb3b32 = difficultysettings.var_2f81e488ee941e35.var_2031e83d46a7615f;
    drone.var_a05cdaf885c11d8f = difficultysettings.var_2f81e488ee941e35.var_f8c8a53f06d60950;
    drone.var_eb07cea38ab10894 = difficultysettings.var_2f81e488ee941e35.var_a8f26bbfbd90fe93;
    drone.var_8dfccfdc3bf47ba0 = difficultysettings.var_2f81e488ee941e35.var_5989e4df12b17be5;
    drone.var_bbaa752c5f96f86a = difficultysettings.var_2f81e488ee941e35.var_44b8cd2df6b9d533;
    drone.var_1ea01df8fa00c328 = difficultysettings.var_2f81e488ee941e35.var_cbd002da22a03c11;
    drone.var_1ddf4d1db13ee342 = difficultysettings.var_2f81e488ee941e35.var_662f523ec7d4c3a7;
    drone.maxhealth = difficultysettings.drone_maxhealth;
    drone.health = drone.maxhealth;
}

// Namespace br_flying_drone
// Params 0
// Checksum 0x976ceca0, Offset: 0x13de
// Size: 0x2a7
function drone_movebehavior()
{
    self notify( #"hash_4e6bc6dda0ff092" );
    self endon( #"hash_4e6bc6dda0ff092" );
    
    if ( !self )
    {
        assertmsg( "<dev string:x9f>" );
        return;
    }
    
    if ( self.activity_instance )
    {
        self.activity_instance endon( #"activity_ended" );
        self.activity_instance endon( #"instance_destroyed" );
    }
    
    self endon( #"main_drone_destroyed" );
    self endon( #"hash_84941674cca5e76d" );
    self endon( #"drone_cleaned_up" );
    self endon( #"death" );
    
    /#
        debug_draw_frames = int( function_fca6a3a6f6163080( self ) * 1 / level.framedurationseconds );
    #/
    
    while ( true )
    {
        /#
            if ( getdvarint( @"harvesterorb_move", 1 ) == 0 )
            {
                wait 1;
                continue;
            }
        #/
        
        if ( !self.alert && self.goal != #"flee" && self.targetplayer && distancesquared( self.targetplayer.origin, self.origin ) < squared( self.var_a4680a90389f44d6 ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.static_idle && !( self.alert || self.var_f6891b6fecc0bdbb ) )
        {
            waitframe();
            continue;
        }
        
        move_time = function_fca6a3a6f6163080( self );
        var_b1dd718a8fbb3c1c = function_58b0e89a196a240( self.movedistance, 0, move_time );
        var_ef6d5eb620e7538b = self.origin;
        
        /#
            if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
            {
                line( self.origin, var_b1dd718a8fbb3c1c, ( 0, 1, 0 ), 1, 0, debug_draw_frames );
                debugstar( var_b1dd718a8fbb3c1c, ( 0, 1, 0 ), debug_draw_frames, "<dev string:xd3>", 1 );
            }
        #/
        
        drone_move_to( var_b1dd718a8fbb3c1c, move_time, 1 );
        
        if ( self.goal == #"flee" )
        {
            self.var_747f794eb2595108 += distance( var_ef6d5eb620e7538b, var_b1dd718a8fbb3c1c );
            
            if ( self.var_afa203784875c0ba )
            {
                wait self.var_afa203784875c0ba;
            }
        }
        else if ( self.goal == #"hash_6573e43fb6b70d11" )
        {
            wait self.stationarytime;
        }
        else if ( self.goal == #"follow" )
        {
            if ( self.var_caddd4583ba66891 )
            {
                wait self.var_caddd4583ba66891;
            }
        }
        
        waitframe();
    }
}

// Namespace br_flying_drone
// Params 1
// Checksum 0xb76bea7, Offset: 0x168d
// Size: 0xe4
function function_aba08bf509c70293( node )
{
    self notify( #"hash_84ac759dc79b5b9" );
    self endon( #"hash_84ac759dc79b5b9" );
    
    if ( !self )
    {
        assertmsg( "<dev string:xdd>" );
        return;
    }
    
    self endon( #"main_drone_destroyed" );
    self endon( #"hash_84941674cca5e76d" );
    self endon( #"drone_cleaned_up" );
    self endon( #"death" );
    move_time = function_fca6a3a6f6163080( self );
    currnode = node;
    
    while ( currnode && currnode.target )
    {
        nextnode = utility::getstruct( currnode.target, "targetname" );
        
        if ( nextnode )
        {
            drone_move_to( nextnode.origin, move_time );
        }
        
        currnode = nextnode;
        wait self.stationarytime;
    }
}

// Namespace br_flying_drone
// Params 0
// Checksum 0xf43eb232, Offset: 0x1779
// Size: 0x89
function function_e0de4dce57ae487()
{
    self notify( #"hash_53309d9cf6cef8" );
    self setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"on" );
    self setscriptablepartstate( #"scanner", #"on" );
    self setscriptablepartstate( #"light", #"on_idle" );
    
    if ( self.activity_instance )
    {
        self.activity_instance.focusstage = 0;
        activity_definition_utils::function_16b3cfd89a1669f7( 2, self.activity_instance );
    }
}

// Namespace br_flying_drone
// Params 0
// Checksum 0xbdb016c5, Offset: 0x180a
// Size: 0x3d
function function_b62d57c03a13139d()
{
    self.alert = 1;
    self setscriptablepartstate( #"scanner", #"off" );
    self setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"on_alarm" );
}

// Namespace br_flying_drone
// Params 0
// Checksum 0x796e9786, Offset: 0x184f
// Size: 0x82
function function_5366327c25ea5eb2()
{
    if ( !self )
    {
        return;
    }
    
    self.alert = 0;
    self.var_f6891b6fecc0bdbb = 1;
    
    if ( self.activity_instance )
    {
        self.activity_instance.focusstage = 1;
        activity_definition_utils::function_16b3cfd89a1669f7( 1, self.activity_instance );
    }
    
    utility::function_32b24db3127bff40( #"hash_c62470ae8c9fe1d0", #"on" );
    self setscriptablepartstate( #"light", #"on_engaged" );
}

// Namespace br_flying_drone
// Params 0
// Checksum 0x8e5650d, Offset: 0x18d9
// Size: 0x199
function drone_dash()
{
    self.canmove = 0;
    
    if ( self.activity_instance )
    {
        self.activity_instance endon( #"activity_ended" );
        self.activity_instance endon( #"instance_destroyed" );
    }
    
    self endon( #"main_drone_destroyed" );
    self endon( #"stop_moving" );
    self endon( #"drone_cleaned_up" );
    self notify( #"hash_84941674cca5e76d" );
    
    /#
        debug_draw_frames = int( 4.5 / level.framedurationseconds );
    #/
    
    var_b1dd718a8fbb3c1c = function_58b0e89a196a240( self.dashdistance, 0, self.dashmovetime );
    var_ef6d5eb620e7538b = self.origin;
    
    /#
        if ( getdvarint( @"hash_35fd8d2baf7e74ff", 0 ) )
        {
            line( self.origin, var_b1dd718a8fbb3c1c, ( 1, 0.5, 0 ), 1, 0, debug_draw_frames );
            debugstar( var_b1dd718a8fbb3c1c, ( 1, 0.5, 0 ), debug_draw_frames, "<dev string:x11a>", 1 );
        }
    #/
    
    drone_move_to( var_b1dd718a8fbb3c1c, self.dashmovetime, 1 );
    
    if ( self.goal == #"flee" )
    {
        self.var_747f794eb2595108 += distance( var_ef6d5eb620e7538b, var_b1dd718a8fbb3c1c );
    }
    
    self setscriptablepartstate( "audio_move", "drone_move" );
    thread drone_movebehavior();
    
    if ( self.cooldowndamage > 0 )
    {
        wait self.cooldowndamage;
    }
    
    self.canmove = 1;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xe85f8489, Offset: 0x1a7a
// Size: 0x180
function private function_d3b6d436abfc8a57()
{
    if ( self.activity_instance )
    {
        self.activity_instance endon( #"activity_ended" );
        self.activity_instance endon( #"instance_destroyed" );
    }
    
    self endon( #"main_drone_destroyed" );
    self endon( #"drone_cleaned_up" );
    fleedistance = self.fleedistance;
    
    while ( fleedistance > self.var_747f794eb2595108 )
    {
        wait 1;
    }
    
    self.var_747f794eb2595108 = 0;
    newtarget = undefined;
    
    if ( self.targetplayer )
    {
        if ( distancesquared( self.origin, self.targetplayer.origin ) > self.var_1a2c8816083e2770 * 0.75 )
        {
            teammates = teams::getteamdata( self.targetplayer.team, "players" );
            newtarget = get_closest_player( teammates, self.origin, self.var_a4680a90389f44d6, 0 );
        }
        else
        {
            newtarget = self.targetplayer;
        }
    }
    
    set_target_player( newtarget );
    
    if ( newtarget )
    {
        self.goal = #"follow";
        self.activity_instance thread function_6395a1838cd983f5( self, self.helperdrone_type );
        return;
    }
    
    self.goal = #"hash_6573e43fb6b70d11";
    function_e0de4dce57ae487();
    thread function_dbc3536438aea5e0();
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xd63b6517, Offset: 0x1c02
// Size: 0x2b
function private function_754154cc2de43d5a( hackeffect, attacker )
{
    if ( hackeffect.var_bfc0167eb5f93d9d )
    {
        explosive_drone_explosion( self );
    }
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x16ffdefa, Offset: 0x1c35
// Size: 0xed
function private function_3ebe82fd94134869( hackeffect, attacker )
{
    foreach ( ent in level.huntdrones )
    {
        if ( ent != self )
        {
            ent thread function_a153a610e50d7d7d( hackeffect.speedscale, hackeffect.hackduration * 0.001 );
        }
    }
    
    if ( hackeffect.var_bfc0167eb5f93d9d )
    {
        explosive_drone_explosion( self );
        return;
    }
    
    thread function_a153a610e50d7d7d( hackeffect.speedscale, hackeffect.hackduration * 0.001 );
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x80d954ff, Offset: 0x1d2a
// Size: 0x490
function private function_c905b1cd9125edb3()
{
    drone = self;
    
    if ( drone.activity_instance )
    {
        drone.activity_instance endon( #"activity_ended" );
        drone.activity_instance endon( #"instance_destroyed" );
    }
    
    drone endon( #"main_drone_destroyed" );
    drone endon( #"drone_cleaned_up" );
    
    while ( true )
    {
        waitframe();
        drone waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        dmg_struct = spawnstruct();
        dmg_struct.einflictor = einflictor;
        dmg_struct.objweapon = objweapon;
        dmg_struct.meansofdeath = smeansofdeath;
        drone.health += idamage;
        
        if ( !isplayer( eattacker ) )
        {
            if ( isplayer( eattacker.owner ) )
            {
                eattacker = eattacker.owner;
            }
            else
            {
                continue;
            }
        }
        
        dmg_struct.eattacker = eattacker;
        
        if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_d276db87d69299de" ) )
        {
            var_b92817d29e3cb812 = utility::callsharedfunc( #"zombie_damage", #"hash_d276db87d69299de", dmg_struct.objweapon, dmg_struct.eattacker );
            idamage *= var_b92817d29e3cb812;
        }
        
        if ( isexplosivedamagemod( smeansofdeath ) )
        {
            idamage *= drone.explosivedamageresistance;
        }
        
        drone.health -= int( idamage );
        dmg_struct.damage = idamage;
        
        if ( drone.var_4aca1c6aee1548b7 )
        {
            drone.var_4aca1c6aee1548b7 = 0;
            drone notify( #"drone_first_damage" );
            drone.goal = #"flee";
            drone thread drone_engaged();
            drone thread function_d3b6d436abfc8a57();
        }
        
        if ( drone.activity_instance )
        {
            if ( drone.activity_instance.state == "Idle" )
            {
                activity_instance_common::function_46135a69bddfec2c( drone.activity_instance );
            }
            
            if ( !activity_participation::function_e7fc1202ac164928( drone.activity_instance, eattacker ) )
            {
                drone.activity_instance activity_participation::function_bc67362dace4370c( drone.activity_instance, eattacker, "PlayerJoinedDamage" );
            }
            
            progress = drone.maxhealth - max( drone.health, 0 );
            progress = int( mapfloat( 0, drone.maxhealth, 0, 100, progress ) );
            activity_definition_utils::updateprogress( progress, drone.activity_instance, 100 );
        }
        
        if ( !drone is_smoking() && drone.health < drone.maxhealth / 2 )
        {
            drone thread smoke();
        }
        
        shmd = damagefeedback::function_63bdec1d3fd95d25( 0, drone, 1, objweapon );
        shmd.var_f561a4dd442b0d91 = 1;
        eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined, undefined, undefined, shmd, 1 );
        mp_agent_damage::function_eb8ba16055d6da7c( eattacker, drone, "none", smeansofdeath, objweapon, int( idamage ), vpoint, 0, undefined, 0, 0 );
        drone set_target_player( eattacker, 1 );
        
        if ( drone.goal == #"hash_6573e43fb6b70d11" && drone.targetplayer )
        {
            drone thread drone_engaged();
            drone.activity_instance thread function_6395a1838cd983f5( drone, drone.helperdrone_type );
            drone.goal = #"follow";
        }
        
        if ( drone.canmove )
        {
            if ( getdvarint( @"harvesterorb_move", 1 ) )
            {
                drone thread drone_dash();
            }
        }
        
        drone thread function_96802b2371d041a0( vdir, vpoint, dmg_struct );
    }
}

// Namespace br_flying_drone
// Params 1
// Checksum 0xb0c4c47b, Offset: 0x21c2
// Size: 0x4e
function function_c2373db857efa03( playerparticipants )
{
    drone = self;
    randomplayer = undefined;
    
    if ( playerparticipants.size > 0 )
    {
        randomindex = randomintrange( 0, playerparticipants.size );
        randomplayer = playerparticipants[ randomindex ];
    }
    
    drone set_target_player( randomplayer );
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x3cadf4b5, Offset: 0x2218
// Size: 0xc, Type: bool
function private is_smoking()
{
    return isdefined( self.var_c0a925dd22ba77e8 );
}

// Namespace br_flying_drone
// Params 0, eflags: 0xc
// Checksum 0x1c65dcbc, Offset: 0x222d
// Size: 0x86
function private smoke()
{
    self notify( #"hash_fb3b256f00b9e93f" );
    self endon( #"hash_fb3b256f00b9e93f" );
    self endon( #"death" );
    
    if ( !isdefined( self.var_c0a925dd22ba77e8 ) )
    {
        self.var_c0a925dd22ba77e8 = utility::getfx( "drone_damaged_smoke_vfx" );
        playfxontag( self.var_c0a925dd22ba77e8, self, "tag_origin" );
    }
    
    utility::waittill_any( "drone_cleaned_up" );
    killfxontag( self.var_c0a925dd22ba77e8, self, "tag_origin" );
    self.var_c0a925dd22ba77e8 = undefined;
}

// Namespace br_flying_drone
// Params 0
// Checksum 0x54ff22b9, Offset: 0x22bb
// Size: 0x25e
function function_dbc3536438aea5e0()
{
    self notify( #"hash_9513be83a0b786e6" );
    self endon( #"hash_9513be83a0b786e6" );
    drone = self;
    drone endon( #"death" );
    drone endon( #"damage" );
    
    while ( true )
    {
        droneheight = drone.var_6f8e1815c814e080;
        dronehalfheight = droneheight / 2;
        scanradius = droneheight * tan( 40 );
        cylinderorigin = ( drone.origin[ 0 ], drone.origin[ 1 ], drone.origin[ 2 ] - dronehalfheight );
        nearbyplayers = get_valid_nearby_players( scanradius );
        
        if ( nearbyplayers.size >= 1 )
        {
            closest_nearby_player = nearbyplayers[ 0 ];
            drone notify( #"player_scanned" );
            
            if ( drone.activity_instance )
            {
                if ( !activity_participation::function_e7fc1202ac164928( drone.activity_instance, closest_nearby_player ) )
                {
                    activity_participation::function_bc67362dace4370c( drone.activity_instance, closest_nearby_player, "PlayerJoinedOther" );
                }
                
                if ( drone.activity_instance.state == "Idle" )
                {
                    drone notify( #"hash_84941674cca5e76d" );
                    activity_instance_common::function_46135a69bddfec2c( drone.activity_instance );
                    drone thread drone_movebehavior();
                }
            }
            
            drone set_target_player( closest_nearby_player, 1 );
            
            if ( drone.goal == #"hash_6573e43fb6b70d11" )
            {
                if ( drone.var_4aca1c6aee1548b7 )
                {
                    drone.var_4aca1c6aee1548b7 = 0;
                    drone.goal = #"flee";
                    drone thread drone_engaged();
                    drone thread function_d3b6d436abfc8a57();
                }
                else
                {
                    drone thread drone_engaged();
                    drone.activity_instance thread function_6395a1838cd983f5( drone, drone.helperdrone_type );
                    drone.goal = #"follow";
                }
                
                if ( drone.canmove )
                {
                    drone thread drone_dash();
                }
            }
            
            break;
        }
        
        /#
            if ( getdvarint( @"hash_544d0f0b10ec00a4", 0 ) )
            {
                utility::draw_capsule( cylinderorigin, scanradius, dronehalfheight * 2, undefined, undefined, undefined, 5 );
            }
        #/
        
        wait 0.5;
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x191039, Offset: 0x2521
// Size: 0x4b
function private function_fca6a3a6f6163080( drone )
{
    if ( drone.var_f6891b6fecc0bdbb )
    {
        return drone.engagedmovetime;
    }
    
    if ( drone.alert )
    {
        return drone.alertmovetime;
    }
    
    return drone.var_4f9479db21cbaf60;
}

// Namespace br_flying_drone
// Params 3, eflags: 0x4
// Checksum 0xd9f4d362, Offset: 0x2575
// Size: 0x682
function private function_58b0e89a196a240( ideal_move_distance, is_critical, debug_move_time )
{
    drone = self;
    min_move_distance = ideal_move_distance / 2;
    trace_counter = 0;
    var_444fd2dad0a6522b = 0;
    out_of_bounds_counter = 0;
    out_of_range_tolerance = 10;
    trace_tolerance = 6;
    var_39f7f3da63333599 = 40;
    var_99a9d9639bf2be72 = 60;
    directions = drone function_1b697f7c55150386( is_critical );
    direction_index = 0;
    
    /#
        debug_draw_frames = int( debug_move_time * 1 / level.framedurationseconds );
    #/
    
    new_pos = drone.origin;
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) == 2 )
            {
                new_pos = drone function_8d581c582c31e50a();
                
                if ( isdefined( new_pos ) )
                {
                    line( drone.origin, new_pos, ( 0, 1, 0 ), 1, 0, debug_draw_frames );
                    debugstar( new_pos, ( 0, 1, 0 ), debug_draw_frames, "<dev string:x124>", 1 );
                    break;
                }
            }
        #/
        
        if ( direction_index >= directions.size )
        {
            directions = drone function_1b697f7c55150386( is_critical );
            direction_index = 0;
            waitframe();
        }
        
        direction_vec = directions[ direction_index ];
        direction_index++;
        move_distance = ideal_move_distance;
        
        if ( direction_index > 1 )
        {
            move_distance = randomfloatrange( min_move_distance, ideal_move_distance );
        }
        
        forward = vectornormalize( direction_vec ) * move_distance + drone.origin;
        
        if ( br_circle_util::gettimetilldangerforpoint( forward ) < var_99a9d9639bf2be72 && drone.goal != #"follow" )
        {
            direction_vec = br_circle::getsafecircleorigin() - drone.origin;
            angles = vectortoangles( direction_vec );
            angles += ( 0, randomintrange( var_39f7f3da63333599 * -1, var_39f7f3da63333599 ), 0 );
            direction_vec = anglestoforward( angles );
            forward = vectornormalize( direction_vec ) * move_distance + drone.origin;
        }
        
        ground_pos = function_9449b8c8732d5b40( forward );
        elevation = function_8399761ad6cf92b7( drone );
        throttle::throttle_wait_in_queue( level.ob_drone_throttle, drone );
        
        if ( direction_vec == ( 0, 0, 1 ) )
        {
            if ( elevation < min_move_distance )
            {
                elevation = randomfloatrange( elevation, min_move_distance );
            }
        }
        
        new_pos = ( ground_pos[ 0 ], ground_pos[ 1 ], ground_pos[ 2 ] + elevation );
        exclude = drone function_ff84fddba0052fb4( new_pos );
        
        if ( !exclude )
        {
            drone.var_2d79ae35ed58827b = 0;
        }
        else if ( !drone.var_2d79ae35ed58827b )
        {
            out_of_bounds_counter++;
            throttle::throttle_wait_in_queue( level.ob_drone_throttle, drone );
            
            if ( out_of_bounds_counter > out_of_range_tolerance )
            {
                new_pos = drone function_8d581c582c31e50a();
                
                if ( isdefined( new_pos ) )
                {
                    break;
                }
                else
                {
                    drone.var_2d79ae35ed58827b = 1;
                }
            }
            else
            {
                continue;
            }
        }
        
        if ( !drone function_ab7b5c2e05aa6b0f( new_pos ) && var_444fd2dad0a6522b < 10 )
        {
            var_444fd2dad0a6522b++;
            throttle::throttle_wait_in_queue( level.ob_drone_throttle, drone );
            continue;
        }
        
        trace = drone function_5f430a07467a815e( drone.origin, new_pos );
        
        if ( trace[ "fraction" ] >= 1 )
        {
            break;
        }
        
        throttle::throttle_wait_in_queue( level.ob_drone_throttle, drone );
        
        /#
            if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
            {
                trace::draw_trace( trace, ( 1, 0, 0 ), 1, debug_draw_frames );
            }
        #/
        
        trace_distance_safe = distance( drone.origin, new_pos ) * trace[ "fraction" ] - 50;
        
        if ( trace_distance_safe > min_move_distance )
        {
            move_distance = randomfloatrange( min_move_distance, trace_distance_safe );
            new_pos = vectornormalize( new_pos - drone.origin ) * move_distance + drone.origin;
            
            /#
                if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
                {
                    line( drone.origin, new_pos, ( 0, 1, 1 ), 1, 0, debug_draw_frames );
                    debugstar( new_pos, ( 0, 1, 1 ), debug_draw_frames, "<dev string:x134>", 1 );
                }
            #/
            
            break;
        }
        
        trace_counter++;
        
        if ( trace_counter >= trace_tolerance )
        {
            forward = anglestoforward( drone.angles ) * 50 + drone.origin;
            ground_pos = utility::drop_to_ground( forward, 3500, -1000 );
            elevation = abs( ground_pos[ 2 ] - drone.origin[ 2 ] ) + function_8399761ad6cf92b7( drone );
            new_pos = ( drone.origin[ 0 ], drone.origin[ 1 ], ground_pos[ 2 ] + elevation );
            
            /#
                if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
                {
                    line( drone.origin, new_pos, ( 1, 0.75, 0.75 ), 1, 0, debug_draw_frames );
                    debugstar( new_pos, ( 1, 0.75, 0.75 ), debug_draw_frames, "<dev string:x13f>", 1 );
                }
            #/
            
            contentsoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 1, 1 );
            trace = drone function_36b59443bc6b6eb2( drone.origin + ( 0, 0, 25 ), new_pos, 50 );
            ascend = trace[ "fraction" ] >= 1 || trace[ "fraction" ] == 0;
            
            if ( !ascend )
            {
                drone function_84ca92ad891f6496( drone.origin );
                
                if ( drone function_f75ba697583360af() > 3 )
                {
                    if ( randomint( 100 ) > 50 )
                    {
                        new_pos = drone function_96acffdc781d88f4();
                    }
                }
                
                new_pos = drone function_8d581c582c31e50a();
                
                /#
                    if ( new_pos && getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
                    {
                        line( drone.origin, new_pos, ( 1, 0.5, 1 ), 1, 0, debug_draw_frames );
                        debugstar( new_pos, ( 1, 0.5, 1 ), debug_draw_frames, "<dev string:x124>", 1 );
                    }
                #/
                
                if ( !isdefined( new_pos ) )
                {
                    wait 1;
                    continue;
                }
            }
            
            break;
        }
        
        throttle::throttle_wait_in_queue( level.ob_drone_throttle, drone );
    }
    
    throttle::throttle_wait_in_queue( level.ob_drone_throttle, drone );
    return new_pos;
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xd54cc07b, Offset: 0x2c00
// Size: 0x132
function private function_1b697f7c55150386( is_critical = 0 )
{
    if ( self.goal == #"flee" )
    {
        return function_6f933a9ed92b52de();
    }
    
    directions = [];
    directions[ directions.size ] = function_3e4625cb05272411();
    directions[ directions.size ] = function_3e4625cb05272411();
    preferred_direction = directions[ 0 ];
    search_directions = 4;
    var_37a73e5a8a8cc973 = 2;
    angles = vectortoangles( preferred_direction );
    dir_map = [ 0, 1, 3, 2 ];
    
    for ( i = 1; i < search_directions ; i++ )
    {
        if ( is_critical && i > var_37a73e5a8a8cc973 )
        {
            break;
        }
        
        if ( i == search_directions - 1 )
        {
            directions[ directions.size ] = ( 0, 0, 1 );
        }
        
        yaw = angleclamp( angles[ 1 ] + dir_map[ i ] * 360 / search_directions );
        forward = anglestoforward( ( angles[ 0 ], yaw, angles[ 2 ] ) );
        directions[ directions.size ] = forward;
    }
    
    return directions;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x7734baba, Offset: 0x2d3b
// Size: 0x41
function private function_6f933a9ed92b52de()
{
    directions = [];
    var_60e4fbde584e47f4 = 6;
    
    for ( i = 0; i < var_60e4fbde584e47f4 ; i++ )
    {
        directions[ directions.size ] = function_3e4625cb05272411();
    }
    
    return directions;
}

// Namespace br_flying_drone
// Params 3, eflags: 0x4
// Checksum 0xe791a00c, Offset: 0x2d85
// Size: 0x217
function private function_96802b2371d041a0( var_a21c0ba6ea3deb5d, contact_point, dmg_struct )
{
    drone = self;
    
    if ( drone.activity_instance )
    {
        drone.activity_instance endon( #"activity_ended" );
        drone.activity_instance endon( #"instance_destroyed" );
    }
    
    drone endon( #"main_drone_destroyed" );
    drone endon( #"drone_cleaned_up" );
    
    /#
        if ( getdvarint( @"hash_7ac01265efe4f622", 0 ) )
        {
            drone thread drone_shutdown( var_a21c0ba6ea3deb5d, contact_point );
            return;
        }
    #/
    
    if ( drone.health / drone.maxhealth <= drone.var_9c314d416ddd1b3b )
    {
        drone notify( #"engage_phase" );
    }
    
    if ( drone.health <= 0 )
    {
        attacker = dmg_struct.eattacker;
        activity_participation::function_5213b2515c8b4f77( drone.activity_instance, attacker );
        activity_participation::function_5e5913e13bf9cb28( drone.activity_instance );
        drone.var_24954f14e27b448d = 0;
        visibility_mode::function_4e6c654251b854e0( drone );
        
        if ( drone.activity_instance )
        {
            activity_definition_utils::function_a0a94881bc380bbf( 1, drone.activity_instance );
        }
        
        br_activity_util::function_333e692c891758bb( br_activity_util::function_501ceea91ee698e7( attacker ), "specialEnemiesKilled" );
        
        if ( attacker && attacker.team && drone.var_d5efa8ae738e81c )
        {
            br_circle_peek::function_6de0d379275546d1( attacker.team );
        }
        
        drone.isagent = 1;
        drone.agent_type = "actor_saw_bongo_enemy_guild_drone_bot";
        challenges::onkill( attacker, drone, undefined, dmg_struct.damage, dmg_struct.meansofdeath, dmg_struct.objweapon, dmg_struct.einflictor, attacker.modifiers, 0 );
        drone thread drone_shutdown( var_a21c0ba6ea3deb5d, contact_point, attacker.team );
        return;
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xab5dcd3c, Offset: 0x2fa4
// Size: 0x18f, Type: bool
function private function_ab7b5c2e05aa6b0f( origin )
{
    if ( !origin )
    {
        return false;
    }
    
    memory = self.memory;
    tolerance = squared( 100 );
    
    for ( index = memory.bad_pos.size - 1; index >= 0 ; index-- )
    {
        if ( index < memory.bad_pos.size - 10 )
        {
            break;
        }
        
        if ( distancesquared( memory.bad_pos[ index ], origin ) < tolerance )
        {
            /#
                debugstar( origin, ( 1, 0, 0 ), 500, "<dev string:x14b>", 1 );
                line( memory.bad_pos[ index ], origin, ( 1, 0, 0 ), 1, 0, 500 );
            #/
            
            return false;
        }
    }
    
    if ( !self.allow_visited )
    {
        for ( index = memory.vis_stack.size - 1; index >= 0 ; index-- )
        {
            if ( index < memory.vis_stack.size - 10 )
            {
                break;
            }
            
            if ( distancesquared( memory.vis_stack[ index ], origin ) < tolerance )
            {
                /#
                    debugstar( origin, ( 1, 0, 0 ), 500, "<dev string:x156>", 1 );
                    line( memory.vis_stack[ index ], origin, ( 1, 0, 0 ), 1, 0, 500 );
                #/
                
                return false;
            }
        }
    }
    
    if ( function_e519a73548f4c803( origin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x22c41d15, Offset: 0x313c
// Size: 0x124, Type: bool
function private function_e519a73548f4c803( destination )
{
    drone = self;
    
    if ( drone.goal != #"hash_6573e43fb6b70d11" )
    {
        return false;
    }
    
    closestactivity = activity_common::function_3eba33db536a1da6( destination, undefined, level.bongodrone.var_1204ae2e4bfd2455 );
    
    if ( closestactivity )
    {
        spatialzonename = undefined;
        
        foreach ( zone in [ "Awareness_Zone", "Proximity_Join_Zone" ] )
        {
            if ( spatial_zone_container::function_3819f09eefb741e2( closestactivity, zone ) )
            {
                spatialzonename = zone;
                break;
            }
        }
        
        if ( spatialzonename && !spatial_zone_container::function_4f49a4fe9f39d32b( drone.origin, closestactivity, spatialzonename ) && spatial_zone_container::function_4f49a4fe9f39d32b( destination, closestactivity, spatialzonename ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_flying_drone
// Params 3, eflags: 0x4
// Checksum 0xff10b09f, Offset: 0x3269
// Size: 0xa5
function private drone_move_to( var_b1dd718a8fbb3c1c, move_time, memory_tracking = 0 )
{
    drone = self;
    
    if ( drone.emp_enabled )
    {
        move_time *= drone.emp_speed_scale;
    }
    
    accel_time = move_time * drone.var_c48a311adb63f5da / 100;
    var_af19742ed09a0a72 = move_time * drone.var_7a09c045385eacee / 100;
    drone moveto( var_b1dd718a8fbb3c1c, move_time, accel_time, var_af19742ed09a0a72 );
    wait move_time;
    
    if ( memory_tracking )
    {
        drone function_244a614c6273b6f1( var_b1dd718a8fbb3c1c );
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x3d837450, Offset: 0x3316
// Size: 0x9f
function private function_8d581c582c31e50a( should_pop = 1 )
{
    memory = self.memory;
    
    if ( memory.vis_stack.size <= 1 )
    {
        return;
    }
    
    last_pos = memory.vis_stack[ memory.vis_stack.size - 2 ];
    
    if ( should_pop )
    {
        memory.vis_stack[ memory.vis_stack.size - 1 ] = undefined;
        memory.vis_stack[ memory.vis_stack.size - 1 ] = undefined;
    }
    
    return last_pos;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xd7a0014c, Offset: 0x33be
// Size: 0x83
function private function_9449b8c8732d5b40( origin, updist )
{
    ground_pos_result = br_public::function_3881e27a5abdb6ff( origin, updist ?? 3500 );
    ground_pos = ground_pos_result[ "position" ];
    navmesh_pos = getclosestpointonnavmesh( ground_pos, undefined, 0, 0, 1, 0, 1 );
    
    if ( !isdefined( ground_pos_result[ "hittype" ] ) )
    {
        return ( navmesh_pos[ 0 ], navmesh_pos[ 1 ], navmesh_pos[ 2 ] );
    }
    
    return ( navmesh_pos[ 0 ], navmesh_pos[ 1 ], ground_pos[ 2 ] );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x5fdf0503, Offset: 0x3449
// Size: 0x26
function private function_8399761ad6cf92b7( drone )
{
    return randomfloatrange( drone.var_6f6b0e15c7ee82ca, drone.var_6f8e1815c814e080 );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xfbc581a1, Offset: 0x3478
// Size: 0x114
function private function_ff84fddba0052fb4( point )
{
    drone = self;
    
    if ( drone.goal == #"hash_6573e43fb6b70d11" )
    {
        exclude = 0;
        
        if ( !exclude )
        {
            foreach ( area in self.var_4531031c457be57b )
            {
                if ( distance2dsquared( point, area.origin ) <= squared( area.radius ) )
                {
                    exclude = 1;
                }
            }
        }
        
        /#
            if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) && exclude )
            {
                debugstar( point, ( 1, 0, 0 ), 500, "<dev string:x161>", 1 );
            }
        #/
        
        return exclude;
    }
    
    return 0;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xc2bbfbc5, Offset: 0x3595
// Size: 0x79
function private function_5f430a07467a815e( start, end )
{
    drone = self;
    height = 200;
    offset = ( 0, 0, height / 2 );
    contentsoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 1, 0 );
    return trace::capsule_trace( start - offset, end - offset, 50, height, undefined, [ drone ], contentsoverride );
}

// Namespace br_flying_drone
// Params 4, eflags: 0x4
// Checksum 0xda3687ea, Offset: 0x3617
// Size: 0x6c
function private function_36b59443bc6b6eb2( start, end, radius, ignore )
{
    drone = self;
    contentsoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 1, 0 );
    
    if ( !isdefined( ignore ) )
    {
        ignore = [ drone ];
    }
    
    return trace::sphere_trace( start, end, radius, ignore, contentsoverride );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xa6240593, Offset: 0x368c
// Size: 0xa7
function private function_84ca92ad891f6496( origin )
{
    memory = self.memory;
    
    if ( memory.bad_pos.size >= 20 )
    {
        for ( index = 0; index < 10 ; index++ )
        {
            memory.bad_pos[ index ] = memory.bad_pos[ 10 + index ];
        }
        
        for ( index = 19; index >= 10 ; index-- )
        {
            memory.bad_pos[ index ] = undefined;
        }
    }
    
    memory.bad_pos[ memory.bad_pos.size ] = origin;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xdac300c0, Offset: 0x373b
// Size: 0x23
function private function_f75ba697583360af()
{
    memory = self.memory;
    return memory.vis_stack.size;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x127d16c8, Offset: 0x3767
// Size: 0x6c
function private function_96acffdc781d88f4()
{
    memory = self.memory;
    
    if ( memory.vis_stack.size < 1 )
    {
        return;
    }
    
    last_pos = memory.vis_stack[ memory.vis_stack.size - 1 ];
    memory.vis_stack[ memory.vis_stack.size - 1 ] = undefined;
    return last_pos;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x3fd220fc, Offset: 0x37dc
// Size: 0xaf
function private function_3e4625cb05272411()
{
    drone = self;
    activity_instance = self.activity_instance;
    
    if ( drone.targetplayer )
    {
        if ( drone.goal == #"follow" )
        {
            point = drone function_264fafe3df850264( drone.targetplayer );
            return vectornormalize( point - drone.origin );
        }
        else if ( drone.goal == #"flee" )
        {
            return drone function_cd92c130e25283a0( drone.targetplayer );
        }
    }
    
    return utility::randomvector( 1 );
}

// Namespace br_flying_drone
// Params 3
// Checksum 0x7f3d3a7f, Offset: 0x3894
// Size: 0xe5
function drone_shutdown( damagedirection, impactpoint, team )
{
    level endon( #"game_ended" );
    drone = self;
    drone notify( #"stop_moving" );
    drone notify( #"hash_84941674cca5e76d" );
    drone setcandamage( 0 );
    
    if ( drone.launchexplosion )
    {
        drone function_ab08c932b914cae4( damagedirection, impactpoint );
    }
    else
    {
        drone notify( #"explode" );
        drone setscriptablepartstate( #"exit", #"first_explode" );
        wait 3;
        drone setscriptablepartstate( #"exit", #"second_explode" );
    }
    
    if ( drone.can_lootdrop )
    {
        drone function_30486e1b910c89e5( team );
    }
    
    drone notify( #"main_drone_destroyed" );
    drone drone_destroy();
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x85a835ad, Offset: 0x3981
// Size: 0x2fb
function private function_ab08c932b914cae4( damagedirection, impactpoint )
{
    drone = self;
    safelaunch = 1;
    impulse = 200;
    launchforce = 3000;
    newpos = drone.origin;
    
    if ( isdefined( damagedirection ) )
    {
        newpos = drone.origin + vectornormalize( damagedirection ) * impulse;
    }
    
    groundpos = getgroundposition( newpos, 1 );
    altitudeoffset = ( 0, 0, newpos[ 2 ] - groundpos[ 2 ] );
    
    if ( !ispointonnavmesh( newpos ) && !drone.var_1cb68d8eeac5c90d )
    {
        safelaunch = 0;
        newpos = getclosestpointonnavmesh( newpos ) + altitudeoffset;
    }
    
    trace = drone function_36b59443bc6b6eb2( drone.origin, newpos, 25 );
    
    /#
        if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
        {
            trace::draw_trace( trace, ( 1, 0, 1 ), 1, 1000 );
        }
    #/
    
    if ( trace[ "fraction" ] < 1 )
    {
        newpos = trace[ "shape_position" ];
        safelaunch = 0;
    }
    
    drone setscriptablepartstate( #"exit", #"first_explode" );
    
    /#
        if ( getdvarint( @"hash_7ac01265efe4f622", 0 ) )
        {
            line( newpos, newpos + ( 0, 0, -500 ), ( 1, 0, 0 ), 1, 1, 1000 );
            iprintlnbold( safelaunch ? "<dev string:x178>" : "<dev string:x17d>" );
        }
    #/
    
    if ( !safelaunch )
    {
        drone moveto( newpos, 0.5, 0.5 );
        drone setscriptablepartstate( "audio_move", "drone_move" );
        wait 0.5;
        damagedirection = ( 0, 0, 1 );
        drone setscriptablepartstate( #"exit", #"second_explode" );
    }
    
    drone notify( #"explode" );
    drone.moverdoesnotkill = 1;
    drone physicslaunchserver( impactpoint, damagedirection * launchforce );
    drone physics_registerforcollisioncallback();
    drone thread function_1d579e383a6d4812();
    drone waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
    surface = physics_getsurfacetypefromflags( flag1 );
    surfacetype = surface[ "name" ];
    
    if ( surfacetype == "surftype_water" )
    {
        drone.physics_settled = 1;
    }
    
    drone setscriptablepartstate( #"exit", #"collide_explode" );
    
    if ( !drone.physics_settled )
    {
        drone waittill( #"physics_settled" );
    }
}

// Namespace br_flying_drone
// Params 0
// Checksum 0xca6347cd, Offset: 0x3c84
// Size: 0x1c, Type: bool
function is_main_drone()
{
    if ( self.type == %"main_drone" )
    {
        return true;
    }
    
    return false;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x2c5f96ce, Offset: 0x3ca9
// Size: 0x17
function private function_60565c02f10c727a()
{
    return "light" + "_" + self.type;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x7c11e56e, Offset: 0x3cc9
// Size: 0xab
function private function_3966d4c5fee88857( spawn_on_ground, team )
{
    drone = self;
    spawn_position = drone.origin;
    
    if ( spawn_on_ground )
    {
        spawn_position = getgroundposition( spawn_position, 1 );
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawn_position );
    
    if ( team )
    {
        spawnoptions.payload = [ #"teamselect", team ];
        spawnoptions.spawningteam = team;
    }
    
    level common_item::function_38cde6a6acb68ea6( drone.loot_item_list, drone.loot_item_count, spawnoptions );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x4a5e0743, Offset: 0x3d7c
// Size: 0x46
function private function_30486e1b910c89e5( team )
{
    drone = self;
    drone function_3966d4c5fee88857( 1, team );
    drone utility::function_7c10ea82c1e305b8( "item_spawn", "spawn" );
    drone notify( #"loot_spawned" );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xd5a86af, Offset: 0x3dca
// Size: 0xa7
function private function_244a614c6273b6f1( origin )
{
    memory = self.memory;
    
    if ( memory.vis_stack.size >= 20 )
    {
        for ( index = 0; index < 10 ; index++ )
        {
            memory.vis_stack[ index ] = memory.vis_stack[ 10 + index ];
        }
        
        for ( index = 19; index >= 10 ; index-- )
        {
            memory.vis_stack[ index ] = undefined;
        }
    }
    
    memory.vis_stack[ memory.vis_stack.size ] = origin;
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x98d6e119, Offset: 0x3e79
// Size: 0x6c
function private function_264fafe3df850264( target )
{
    drone = self;
    targetorigin = target.origin;
    newposition = function_78a5b128a3e32460( targetorigin, drone.var_a4680a90389f44d6, drone.var_5e66b7c01aeca260 );
    return ( newposition[ 0 ], newposition[ 1 ], drone.origin[ 2 ] );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x87870699, Offset: 0x3eee
// Size: 0x7e
function private function_cd92c130e25283a0( var_8ab33cfe021d23aa )
{
    angle = 90;
    drone = self;
    playerorigin = var_8ab33cfe021d23aa.origin;
    direction_vec = vectornormalize2( drone.origin - playerorigin );
    angles = vectortoangles( direction_vec );
    angles += ( 0, randomintrange( angle * -1, angle ), 0 );
    return anglestoforward( angles );
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xf7a73c47, Offset: 0x3f75
// Size: 0x102
function private function_1d579e383a6d4812()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    check_frequency = 0.1;
    velocity_threshold = 1;
    time_threshold_ms = utility::function_4b74c15943231980( 5 );
    time_start_falling = gettime();
    
    while ( true )
    {
        wait check_frequency;
        bodyid = self physics_getbodyid( 0 );
        linearvelocity = length( physics_getbodylinvel( bodyid ) );
        
        /#
            if ( getdvarint( @"hash_7ac01265efe4f622", 0 ) )
            {
                debugstar( self.origin, ( 1, 1, 0 ), int( check_frequency * 1 / level.framedurationseconds ), "<dev string:x186>" + linearvelocity, 0.7 );
            }
        #/
        
        if ( linearvelocity < velocity_threshold || gettime() - time_start_falling > time_threshold_ms )
        {
            self.physics_settled = 1;
            self notify( #"physics_settled" );
            return;
        }
    }
}

// Namespace br_flying_drone
// Params 3, eflags: 0x4
// Checksum 0x56c35441, Offset: 0x407f
// Size: 0x96
function private function_78a5b128a3e32460( origin, radius, minradius = 0 )
{
    if ( minradius == 0 )
    {
        return math::function_78a5b128a3e32460( origin, radius );
    }
    
    theta = randomfloat( 360 );
    radius = sqrt( randomfloatrange( squared( minradius ), squared( radius ) ) );
    offset = ( radius * cos( theta ), radius * sin( theta ), 0 );
    randompoint = origin + offset;
    randompoint = getclosestpointonnavmesh( randompoint );
    return randompoint;
}

// Namespace br_flying_drone
// Params 1
// Checksum 0xd5ab4f79, Offset: 0x411e
// Size: 0x9f
function function_50b8681675cdb7f6( var_1564b16dac510452 )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone notify( #"stop_moving" );
    drone notify( #"hash_84941674cca5e76d" );
    var_7ebe7e0e464b71b6 = ( drone.origin[ 0 ], drone.origin[ 1 ], drone.origin[ 2 ] + var_1564b16dac510452 );
    move_time = drone.var_4f9479db21cbaf60;
    drone moveto( var_7ebe7e0e464b71b6, move_time );
    wait move_time;
    clean_up_drone();
}

// Namespace br_flying_drone
// Params 3
// Checksum 0xba61bf4, Offset: 0x41c5
// Size: 0x23a
function function_afbbd06f0ab74b0b( var_31fe29b7c09cbb46 = 7.5, var_4bd73a36d000f6e4 = 1, deathnotifyoverride = "death" )
{
    self notify( #"hash_e910841b9821b193" );
    self endon( deathnotifyoverride );
    level endon( #"game_ended" );
    self endon( #"hash_e910841b9821b193" );
    self.previousorigin = self.origin;
    self.targetangles = self.angles;
    
    while ( isdefined( self ) )
    {
        stepvector = self.origin - self.previousorigin;
        length = distancesquared( self.previousorigin, self.origin );
        var_cd739a494d593929 = var_31fe29b7c09cbb46 * var_31fe29b7c09cbb46;
        yawangle = self.targetangles[ 1 ];
        
        if ( self.targetplayer && !self.targetplayer.ignoreme )
        {
            yawangle = vectortoangles( self.targetplayer.origin - self.origin )[ 1 ];
        }
        else if ( length >= var_4bd73a36d000f6e4 )
        {
            yawangle = vectortoangles( stepvector )[ 1 ];
        }
        
        v_diff = vectornormalize( stepvector );
        f_forward_dot = vectordot( v_diff, anglestoforward( self.angles ) );
        f_right_dot = vectordot( v_diff, anglestoright( self.angles ) );
        cross = vectorcross( v_diff, ( 0, 0, 1 ) );
        proportion = length / var_cd739a494d593929;
        var_78aad7e94592ce97 = proportion * 20;
        var_78aad7e94592ce97 = clamp( var_78aad7e94592ce97, 0, 20 );
        
        if ( length( cross ) <= 0.1 )
        {
            tiltpitch = 0;
            tiltroll = 0;
        }
        else
        {
            tiltpitch = var_78aad7e94592ce97 * f_forward_dot;
            tiltroll = var_78aad7e94592ce97 * f_right_dot;
        }
        
        self.previousorigin = self.origin;
        self.targetangles = ( tiltpitch, yawangle, tiltroll );
        waitframe();
    }
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xfd46c53f, Offset: 0x4407
// Size: 0x7d
function private drone_destroy()
{
    drone = self;
    drone setscriptablepartstate( #"exit", #"final_explode" );
    drone setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"off" );
    drone setscriptablepartstate( #"scanner", #"off" );
    drone setscriptablepartstate( #"light", #"off" );
    waitframe();
    drone function_25c91463a5c7d654();
}

// Namespace br_flying_drone
// Params 0
// Checksum 0x721c6c59, Offset: 0x448c
// Size: 0x76
function setup_helper_drones()
{
    level.var_ca8bc9130358e5fb = [];
    add_helper_drone_type( "shock", %"veh_sat_mil_air_drone_dart_guild", &shock_drone_think );
    add_helper_drone_type( "turret", %"veh_sat_mil_air_drone_dart_guild", &turret_drone_think, &turret_drone_cleanup );
    add_helper_drone_type( "explosive", %"veh_sat_mil_air_drone_dart_guild", &explosive_drone_think );
    
    /#
        thread function_76bc89c08728368f();
    #/
    
    level utility::flag_set( "helper_drones_setup_done" );
}

// Namespace br_flying_drone
// Params 5
// Checksum 0xb2ecae50, Offset: 0x450a
// Size: 0x9e
function add_helper_drone_type( typename, model, behaviorfunc, cleanupfunc, manuallyspawned = 0 )
{
    var_de286fe0655773a6 = spawnstruct();
    var_de286fe0655773a6.model = model;
    var_de286fe0655773a6.behavior = behaviorfunc;
    var_de286fe0655773a6.cleanup = cleanupfunc;
    var_de286fe0655773a6.manuallyspawned = manuallyspawned;
    
    if ( !level.var_ca8bc9130358e5fb[ typename ] )
    {
        level.var_ca8bc9130358e5fb[ typename ] = var_de286fe0655773a6;
    }
}

// Namespace br_flying_drone
// Params 6
// Checksum 0x97a5ed84, Offset: 0x45b0
// Size: 0x3af, Type: bool
function spawn_helper_drone( dronetype, target, spawn_locations_array, start_struct, options, maindrone )
{
    if ( !isdefined( self.helper_drones ) )
    {
        self.helper_drones = [];
    }
    
    if ( !spawn_locations_array && !start_struct )
    {
        return false;
    }
    
    locationpath = undefined;
    
    if ( spawn_locations_array )
    {
        locationpath = spawn_locations_array;
    }
    else if ( start_struct && isstruct( start_struct ) )
    {
        locationpath = helper_drone_get_path_array( start_struct );
    }
    
    if ( !locationpath )
    {
        return false;
    }
    
    spawnlocation = locationpath[ 0 ];
    locationpath[ 0 ] = undefined;
    
    if ( isint( 0 ) )
    {
        function_cdc669dbc8ea2101( locationpath );
    }
    
    var_4a2ecdf7c2ab2198 = level.var_ca8bc9130358e5fb[ dronetype ];
    assert( isdefined( var_4a2ecdf7c2ab2198 ), "<dev string:x18b>" + dronetype + "<dev string:x197>" );
    drone = spawn( "script_model", spawnlocation );
    
    if ( !drone )
    {
        return false;
    }
    
    drone setmodel( var_4a2ecdf7c2ab2198.model );
    drone.angles = ( 0, vectortoyaw( target.origin - spawnlocation ), 0 );
    drone setcandamage( 1 );
    drone enableaimassist();
    drone.type = dronetype;
    drone.health = 1;
    drone.maxhealth = 1;
    drone.options = options;
    drone.var_c48a311adb63f5da = 25;
    drone.var_7a09c045385eacee = 25;
    drone.locationpath = locationpath;
    drone.loot_item_list = drone.options.lootitemlist;
    drone.loot_item_count = drone.options.var_96656a7c0b586e3e;
    drone.can_lootdrop = drone.loot_item_list && drone.loot_item_count;
    drone.maindrone = maindrone;
    drone.var_6f8e1815c814e080 = maindrone.var_6f8e1815c814e080;
    drone.var_6f6b0e15c7ee82ca = maindrone.var_6f6b0e15c7ee82ca;
    drone.var_5e66b7c01aeca260 = maindrone.var_5e66b7c01aeca260;
    drone.var_a4680a90389f44d6 = maindrone.var_a4680a90389f44d6;
    drone.movedistance = maindrone.movedistance;
    drone.state = 1;
    drone setscriptablepartstate( "audio_engine", "on" );
    drone_startcamo( drone );
    drone enableplayermarks( #"air_killstreak" );
    visibility_mode::function_3afc3bc470c80e61( drone, "team_hundred_ninety_seven" );
    turret::function_6697525b8034338a( drone );
    self.helper_drones[ self.helper_drones.size ] = drone;
    
    if ( !level utility::issharedfuncdefined( #"flying_drone_unit_helper", #"hack" ) )
    {
        level utility::registersharedfunc( #"flying_drone_unit_helper", #"hack", &function_754154cc2de43d5a );
    }
    
    if ( !isdefined( level.huntdrones ) )
    {
        level.huntdrones = [];
    }
    
    level.huntdrones[ level.huntdrones.size ] = drone;
    self notify( #"helper_drone_spawned", drone );
    
    /#
        if ( getdvarint( @"hash_b6b8f93be406d1f", 0 ) )
        {
            iprintlnbold( "<dev string:x1a8>" + dronetype + "<dev string:x1bd>" + spawnlocation );
        }
    #/
    
    thread helper_drone_activate( drone, var_4a2ecdf7c2ab2198.behavior );
    return true;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xb3245bbc, Offset: 0x4968
// Size: 0x19a
function private helper_drone_activate( drone, behaviorfunc )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    thread helper_drone_monitor_death( drone );
    thread function_c57f5ca81e7cb55e( drone );
    drone thread function_c773fc369f62c529();
    drone thread function_f7e5cb4fafcf4c9a();
    drone thread function_afbbd06f0ab74b0b();
    drone thread functionals_utility::function_3d1c0cb00ce4d44e( 20, 10, 7 );
    
    if ( drone.locationpath )
    {
        foreach ( position in drone.locationpath )
        {
            if ( position == drone.origin )
            {
                continue;
            }
            
            move_time = isnumber( drone.options.var_bd2b4756836f0b9a ) ? drone.options.var_bd2b4756836f0b9a : 3;
            drone drone_move_to( position, move_time );
        }
    }
    
    thread helper_drone_hover( drone );
    self thread [[ behaviorfunc ]]( drone );
    thread function_5391f630c9faf4b2( drone );
    drone thread function_ee97628f4ae363d2();
    
    if ( drone.options.scannerlogic )
    {
        thread function_b1c761ec31834456( drone );
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xd03b1ece, Offset: 0x4b0a
// Size: 0x117
function private helper_drone_monitor_death( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone waittill( #"death", attacker );
    self.helper_drones = arrayremove( self.helper_drones, drone );
    level.huntdrones = arrayremove( level.huntdrones, drone );
    var_4a2ecdf7c2ab2198 = level.var_ca8bc9130358e5fb[ drone.type ];
    
    if ( isdefined( var_4a2ecdf7c2ab2198.cleanup ) )
    {
        self [[ var_4a2ecdf7c2ab2198.cleanup ]]( drone );
    }
    
    visibility_mode::function_4e6c654251b854e0( drone );
    drone setscriptablepartstate( "exit", "explose" );
    drone setscriptablepartstate( "audio_engine", "off" );
    drone setscriptablepartstate( "type_light", "off" );
    drone setscriptablepartstate( "scanner", "off" );
    br_activity_util::function_333e692c891758bb( br_activity_util::function_501ceea91ee698e7( attacker ), "specialEnemiesKilled" );
    waitframe();
    drone delete();
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x4bf76711, Offset: 0x4c29
// Size: 0x91
function private function_c773fc369f62c529()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.is_camo_activated )
        {
            continue;
        }
        
        if ( self.state == 1 )
        {
            utility::function_32b24db3127bff40( #"engage_light", #"off" );
            continue;
        }
        
        if ( self.state == 2 )
        {
            utility::function_32b24db3127bff40( #"engage_light", #"on" );
        }
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x7195b37f, Offset: 0x4cc2
// Size: 0x176
function private function_c57f5ca81e7cb55e( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    
    while ( true )
    {
        drone waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isplayer( eattacker ) )
        {
            if ( !isplayer( eattacker.owner ) )
            {
                drone.health += idamage;
                continue;
            }
            else
            {
                eattacker = eattacker.owner;
            }
        }
        
        eattacker damagefeedback::updatehitmarker( "standard", drone.health == 0, 0, 1, "hitequip" );
        
        if ( drone.health <= 0 )
        {
            if ( drone.can_lootdrop )
            {
                drone function_3966d4c5fee88857( 0, eattacker.team );
            }
            
            drone notify( #"death" );
        }
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xf85d01d7, Offset: 0x4e40
// Size: 0x394
function private function_5391f630c9faf4b2( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    drone endon( #"stop_movement" );
    var_75fab83acb648e4e = drone.options.var_75fab83acb648e4e ?? 750;
    
    while ( true )
    {
        waitframe();
        
        if ( drone.emp_enabled )
        {
            waitframe();
            continue;
        }
        
        drone set_target_player( undefined );
        drone.state = 1;
        closeplayers = getplayersinradius( drone.origin, var_75fab83acb648e4e );
        
        if ( closeplayers.size > 0 )
        {
            foreach ( player in closeplayers )
            {
                invehicle = player isvehicleactive();
                content_override = trace::create_contents( 1, 1, 1, 1, 0, !invehicle );
                var_90867e9c050d37b = trace::ray_trace_passed( drone.origin, player geteye(), [ drone, player ], content_override );
                
                if ( player.ignoreme || player.notarget || !var_90867e9c050d37b )
                {
                    continue;
                }
                
                drone set_target_player( player );
                drone.state = 2;
                drone notify( #"target_player" );
                break;
            }
            
            continue;
        }
        
        wait 0.2;
        
        if ( drone.maindrone.targetplayer )
        {
            target = drone.maindrone.targetplayer;
        }
        else if ( drone.maindrone )
        {
            target = drone.maindrone;
        }
        else
        {
            continue;
        }
        
        point = drone function_264fafe3df850264( target );
        direction_vec = vectornormalize( point - drone.origin );
        movedistance = randomfloatrange( drone.movedistance / 2, drone.movedistance );
        destination = drone.origin + direction_vec * movedistance;
        ground_pos = function_9449b8c8732d5b40( destination, 0 );
        elevation = function_8399761ad6cf92b7( drone );
        destination = ( ground_pos[ 0 ], ground_pos[ 1 ], ground_pos[ 2 ] + elevation );
        trace = drone function_36b59443bc6b6eb2( drone.origin, destination, 45, [ drone, target ] );
        trace_passed = !isdefined( trace[ "hittype" ] ) || trace[ "hittype" ] == "hittype_none";
        
        /#
            if ( getdvarint( @"hash_9352ee559e7ab76f", 0 ) )
            {
                trace::draw_trace( trace, trace_passed ? ( 0, 1, 0 ) : ( 0.5, 0, 1 ), 1, 60 );
            }
        #/
        
        if ( trace_passed )
        {
            drone notify( #"stop_hover" );
            drone drone_move_to( destination, 3 );
        }
        
        thread helper_drone_hover( drone );
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x2a209f57, Offset: 0x51dc
// Size: 0x67
function private function_b1c761ec31834456( drone )
{
    level endon( #"game_ended" );
    drone endon( #"death" );
    drone endon( #"entitydeleted" );
    drone setscriptablepartstate( "scanner", "on" );
    drone utility::waittill_any( "damage", "target_player" );
    drone setscriptablepartstate( "scanner", "off" );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x1597f12b, Offset: 0x524b
// Size: 0xff
function private helper_drone_hover( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    drone endon( #"stop_movement" );
    drone endon( #"stop_hover" );
    drone.centerpos = drone.origin;
    hovertime = isnumber( drone.options.hovertime ) ? drone.options.hovertime : randomfloatrange( 1.5, 2 );
    drone setscriptablepartstate( "idle_vfx", "visible" );
    
    while ( true )
    {
        dir = utility::randomvector( 1 );
        goal = drone.centerpos + dir * 15;
        drone drone_move_to( goal, hovertime );
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xa3f23aae, Offset: 0x5352
// Size: 0x89
function private helper_drone_get_path_array( startstruct )
{
    path_array = [];
    path_array[ path_array.size ] = startstruct.origin;
    
    for ( currnode = startstruct; currnode && currnode.target ; currnode = nextnode )
    {
        nextnode = utility::getstruct( currnode.target, "targetname" );
        
        if ( nextnode )
        {
            path_array[ path_array.size ] = nextnode.origin;
        }
    }
    
    return path_array;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x179e87a4, Offset: 0x53e4
// Size: 0x6b
function private function_f7e5cb4fafcf4c9a()
{
    waittime = isnumber( self.options.activationdelay ) ? self.options.activationdelay : 2;
    utility::waittill_any_timeout( waittime, "target_player" );
    function_9022369d3fc8a419( self );
    self setscriptablepartstate( #"type_light", function_60565c02f10c727a() );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xf3c7d495, Offset: 0x5457
// Size: 0x62
function private turret_drone_think( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    /#
        thread function_aa022112ed9c7c9f( drone, "<dev string:x1c2>", ( 1, 1, 1 ) );
    #/
    
    turret_drone_spawn_turret( drone );
    thread turret_drone_attack_loop( drone );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xd7749c1f, Offset: 0x54c1
// Size: 0x9f
function private turret_drone_attack_loop( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    while ( true )
    {
        waittime = 1;
        
        if ( drone.targetplayer )
        {
            turret_drone_fire( drone );
            waittime = drone.options.var_d0089c3b20eff2fd ?? 3;
        }
        else if ( drone.turret )
        {
            drone.turret laseroff();
        }
        
        wait waittime;
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x6aea989f, Offset: 0x5568
// Size: 0x10c
function private turret_drone_fire( drone )
{
    level endon( #"game_ended" );
    
    if ( !drone.turret )
    {
        return;
    }
    
    drone endon( #"death", #"entitydeleted" );
    drone.turret endon( #"death", #"entitydeleted" );
    drone.turret laseroff();
    target = drone.targetplayer;
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( !target )
        {
            break;
        }
        
        targetloc = target gettagorigin( "j_spine4" );
        heightoffset = targetloc - target.origin;
        drone.turret snaptotargetentity( target, heightoffset );
        drone.turret shootturret();
        wait 0.2;
    }
    
    drone.turret laseron();
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x3e7886c3, Offset: 0x567c
// Size: 0xbf
function private turret_drone_spawn_turret( drone )
{
    turretweapon = spawnturret( "misc_turret", drone.origin, %"sat_ob_invis_turret_drone" );
    turretweapon setmodel( %"sat_ob_invis_turret" );
    turretweapon.angles = drone.angles;
    turretweapon linkto( drone );
    turretweapon turretfireenable();
    turretweapon setdefaultdroppitch( 0 );
    turretweapon setmode( "manual" );
    turretweapon setnodeploy( 1 );
    turretweapon maketurretinoperable();
    turretweapon setusableenabled( 0 );
    turretweapon setturretteam( "team_hundred_ninety_seven" );
    turretweapon.owner = drone;
    drone.turret = turretweapon;
}

// Namespace br_flying_drone
// Params 1
// Checksum 0xa0c9d0eb, Offset: 0x5743
// Size: 0x3a
function turret_drone_cleanup( drone )
{
    if ( drone.turret )
    {
        drone.turret laseroff();
        drone.turret delete();
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x92631e84, Offset: 0x5785
// Size: 0x59
function private shock_drone_think( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    /#
        thread function_aa022112ed9c7c9f( drone, "<dev string:x1cf>", ( 0, 0, 1 ) );
    #/
    
    thread shock_drone_attack_loop( drone );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x3977fa20, Offset: 0x57e6
// Size: 0x66
function private shock_drone_attack_loop( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    while ( true )
    {
        waittime = 1;
        
        if ( drone.targetplayer )
        {
            function_3b33d641fd3a8730( drone );
            waittime = 3;
        }
        
        wait waittime;
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x476400d8, Offset: 0x5854
// Size: 0x123
function private function_3b33d641fd3a8730( drone )
{
    if ( !isdefined( drone.var_2db42cf2b39085c1 ) )
    {
        drone.var_2db42cf2b39085c1 = 0;
    }
    
    var_8b0c4e78c85d9963 = randomfloat( 360 );
    
    for ( i = 0; i < 1 ; i++ )
    {
        if ( drone.var_2db42cf2b39085c1 >= 3 )
        {
            break;
        }
        
        var_374b2994374fef27 = randomintrange( 150, 300 );
        var_a3031508254beebf = randomintrange( 75, 150 );
        frontvector = vectornormalize( anglestoforward( ( 0, function_63a2ef74ebcc6413( var_8b0c4e78c85d9963 + 120 * i ), 0 ) ) );
        shockstick = magicgrenademanual( "shock_stick_mp", drone.origin + frontvector * 30 + ( 0, 0, 50 ), frontvector * var_374b2994374fef27 + ( 0, 0, var_a3031508254beebf ) );
        shockstick setscriptablepartstate( "electric", "active", 0 );
        shockstick setscriptablepartstate( "detonate", "detonate", 0 );
        drone.var_2db42cf2b39085c1++;
        shockstick thread function_394f12a68648f1f5( drone );
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xbee23fd6, Offset: 0x597f
// Size: 0xf8
function private function_394f12a68648f1f5( drone )
{
    victim_array = [];
    
    for ( var_99734d34b9b3181c = 0; var_99734d34b9b3181c <= 50 ; var_99734d34b9b3181c++ )
    {
        var_fc34ba2af1bf33a4 = getplayersinradius( self.origin, 150 );
        
        foreach ( player in var_fc34ba2af1bf33a4 )
        {
            if ( arraycontains( victim_array, player ) || player isvehicleactive() )
            {
                continue;
            }
            
            thread lightning_strike_onplayer( player );
            victim_array[ victim_array.size ] = player;
        }
        
        wait 0.1;
    }
    
    shock_stick::shockstick_destroy();
    
    if ( isdefined( drone ) )
    {
        drone.var_2db42cf2b39085c1--;
    }
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x1407d670, Offset: 0x5a7f
// Size: 0x32
function private start_emp()
{
    self setscriptablepartstate( "emp", "on" );
    self.emp_enabled = 1;
    self.targetplayer = undefined;
    self.state = 1;
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xc6c7b49c, Offset: 0x5ab9
// Size: 0x1c
function private clear_emp()
{
    self setscriptablepartstate( "emp", "off" );
    self.emp_enabled = undefined;
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xe31c5942, Offset: 0x5add
// Size: 0x57
function private function_a153a610e50d7d7d( speed_scale, var_5ff489aa5b485c7d )
{
    self endon( #"main_drone_destroyed" );
    self endon( #"death" );
    self.emp_speed_scale = speed_scale;
    add_emp();
    wait var_5ff489aa5b485c7d;
    remove_emp();
    self.emp_speed_scale = 0.5;
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xff962304, Offset: 0x5b3c
// Size: 0x42
function private add_emp( data )
{
    if ( !isdefined( self.var_c89e5b2444c6faa4 ) )
    {
        self.var_c89e5b2444c6faa4 = 0;
    }
    
    self.var_c89e5b2444c6faa4++;
    
    if ( self.var_c89e5b2444c6faa4 == 1 )
    {
        start_emp();
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x5c583679, Offset: 0x5b86
// Size: 0x2b
function private remove_emp( var_39bf183c57b8c062 )
{
    self.var_c89e5b2444c6faa4--;
    
    if ( self.var_c89e5b2444c6faa4 == 0 )
    {
        clear_emp();
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x30232be0, Offset: 0x5bb9
// Size: 0x140
function private lightning_strike_onplayer( victim )
{
    if ( player::isinlaststand( victim ) )
    {
        return;
    }
    
    if ( victim.ishaywire || victim utility::isusingremote() || !player::isreallyalive( victim ) )
    {
        return;
    }
    
    haywirebundle = { #var_f3447a3874df563f:1, #var_b110dbf60f7e2c47:1, #var_bd94b71ffdfd39c:1 };
    
    if ( !isdefined( self.tableinfo ) )
    {
        self.tableinfo = {};
    }
    
    self.tableinfo.bundle = haywirebundle;
    shock_stick::function_5f89a63c19349cd5( { #victim:victim }, haywirebundle );
    victim setscriptablepartstate( "harvesterOrbSfx", "sfx_start", 0 );
    haywireduration = 4;
    victim utility::waittill_any_timeout( haywireduration, "haywire_cleared", "haywire_max_duration", "shockstick_interrupt", "killed_player", "last_stand_enter" );
    
    if ( !victim )
    {
        return;
    }
    
    victim setscriptablepartstate( "harvesterOrbSfx", "sfx_done", 0 );
    fromdeath = !player::isreallyalive( victim ) || player::isinlaststand( victim );
    victim shock_stick::function_396a585ccd7071f5( { #victim:victim }, fromdeath, haywirebundle );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x900bc9b3, Offset: 0x5d01
// Size: 0x73
function private explosive_drone_think( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    /#
        thread function_aa022112ed9c7c9f( drone, "<dev string:x1dd>", ( 1, 0, 0 ) );
    #/
    
    while ( true )
    {
        if ( drone.targetplayer )
        {
            thread function_59be79642701ad4e( drone );
            break;
        }
        
        waitframe();
    }
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x60cdcafd, Offset: 0x5d7c
// Size: 0x111
function private function_59be79642701ad4e( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    if ( drone.targetplayer )
    {
        target = drone.targetplayer;
        drone notify( #"stop_movement" );
        drone setscriptablepartstate( "audio_lock", "tracker" );
        var_861ad406b117f046 = drone.options.var_b18a266dca6eb55f ?? 3;
        wait var_861ad406b117f046;
        
        if ( target != drone.targetplayer )
        {
            target = drone.targetplayer;
            
            if ( !drone.targetplayer )
            {
                targetpos = drone.var_9e9bed3107ce8f37;
                thread explosive_drone_target( drone, targetpos );
                return;
            }
        }
        
        targetpos = target gettagorigin( "j_spine4" );
        drone setscriptablepartstate( "audio_lock", "locked_on" );
        thread explosive_drone_target( drone, targetpos );
    }
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x8fb4db99, Offset: 0x5e95
// Size: 0x12e
function private explosive_drone_target( drone, targetpos )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    vectorforward = vectornormalize( targetpos - drone.origin );
    life_timer = gettime() + 5000;
    
    while ( gettime() < life_timer )
    {
        var_7c4a5b9ed05b577f = drone.origin + vectorforward * 25;
        
        /#
            if ( getdvarint( @"hash_736c13ebede01a1b", 0 ) )
            {
                line( drone.origin, var_7c4a5b9ed05b577f, ( 0, 1, 0 ), 1, 0, 30 );
                debugstar( var_7c4a5b9ed05b577f, ( 0, 1, 0 ), 30, "<dev string:x1ed>", 1 );
            }
        #/
        
        var_90867e9c050d37b = trace::ray_trace_passed( drone.origin, var_7c4a5b9ed05b577f, drone );
        
        if ( !var_90867e9c050d37b )
        {
            explosive_drone_explosion( drone );
            return;
        }
        
        drone.origin = var_7c4a5b9ed05b577f;
        waitframe();
    }
    
    explosive_drone_explosion( drone );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xac7e9bd2, Offset: 0x5fcb
// Size: 0x7b
function private explosive_drone_explosion( drone )
{
    minimaldamage = drone.options.var_ae7ccfca8ea91285 ?? 20;
    var_14abad88d1088fa2 = drone.options.var_acea9f0acc0e62c3 ?? 50;
    drone radiusdamage( drone.origin, 50, var_14abad88d1088fa2, minimaldamage, drone );
    drone notify( #"death" );
}

// Namespace br_flying_drone
// Params 2
// Checksum 0xb2d22f77, Offset: 0x604e
// Size: 0x299
function function_6395a1838cd983f5( drone, var_cdffe119ed60d14d )
{
    drone endon( #"main_drone_destroyed" );
    drone endon( #"drone_cleaned_up" );
    drone endon( #"hash_53309d9cf6cef8" );
    drone endon( #"death" );
    
    if ( !drone || drone.health <= 0 )
    {
        return;
    }
    
    var_839027d0dafbf825 = 0;
    type = var_cdffe119ed60d14d ?? select_random_drone_type();
    var_2cfb0e6cd65573b3 = drone function_ea04470da79b949b( type );
    
    while ( true )
    {
        if ( drone.emp_enabled )
        {
            waitframe();
            continue;
        }
        
        if ( drone.targetplayer && distancesquared( drone.targetplayer.origin, drone.origin ) < drone.var_9f8e8ae05c599b85 )
        {
            spawn_timer = randomintrange( drone.var_5872025589d5212a, drone.var_1fb9c0976545cc48 );
            var_ddf17f01750c5a57 = randomintrange( 1, drone.var_5d4aa07606eb3b32 + 1 );
            
            if ( self.helper_drones )
            {
                if ( drone.var_ab7bc43443a29388 )
                {
                    var_ddf17f01750c5a57 = drone.var_a05cdaf885c11d8f - self.helper_drones.size;
                }
                else
                {
                    function_783366e3adbf39df( drone, var_ddf17f01750c5a57 );
                }
            }
            
            while ( var_ddf17f01750c5a57 > 0 )
            {
                var_ddf17f01750c5a57--;
                spawn_path_array = undefined;
                trycount = 0;
                droneoptions = spawnstruct();
                droneoptions.var_d0089c3b20eff2fd = drone.var_8dfccfdc3bf47ba0;
                droneoptions.var_b18a266dca6eb55f = drone.var_bbaa752c5f96f86a;
                droneoptions.var_ae7ccfca8ea91285 = drone.var_1ea01df8fa00c328;
                droneoptions.var_acea9f0acc0e62c3 = drone.var_1ddf4d1db13ee342;
                droneoptions.lootitemlist = var_2cfb0e6cd65573b3.var_a35ce03e66ef2df5;
                droneoptions.var_96656a7c0b586e3e = var_2cfb0e6cd65573b3.var_865307e4799ee162;
                
                while ( !isdefined( spawn_path_array ) && trycount < 3 )
                {
                    spawn_path_array = get_helper_drone_spawn_pos( drone );
                    trycount++;
                }
                
                if ( isdefined( spawn_path_array ) && !drone.emp_enabled )
                {
                    if ( spawn_helper_drone( type, drone.targetplayer, spawn_path_array, undefined, droneoptions, drone ) )
                    {
                        var_839027d0dafbf825++;
                        
                        if ( var_839027d0dafbf825 >= drone.var_eb07cea38ab10894 )
                        {
                            return;
                        }
                    }
                }
            }
            
            wait spawn_timer;
        }
        
        waitframe();
    }
}

// Namespace br_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x543418e3, Offset: 0x62ef
// Size: 0x8b
function private function_783366e3adbf39df( drone, count )
{
    missing_slots = self.helper_drones.size + count - drone.var_a05cdaf885c11d8f;
    
    if ( missing_slots > 0 )
    {
        function_628bac9faa9d1e86( self.helper_drones, drone.origin, 1 );
        
        for ( index = 0; index < missing_slots ; index++ )
        {
            self.helper_drones[ index ] notify( #"death" );
        }
    }
}

// Namespace br_flying_drone
// Params 1
// Checksum 0x94d4e8a0, Offset: 0x6382
// Size: 0x155
function get_helper_drone_spawn_pos( drone )
{
    locations = [];
    centerpos = drone.origin;
    target_location = function_78a5b128a3e32460( centerpos, 500 ) + ( 0, 0, 150 );
    locations[ locations.size ] = target_location;
    spawn_location = target_location + ( 0, 0, 300 );
    locations = arraycombine( [ spawn_location ], locations );
    
    /#
        if ( getdvarint( @"hash_8dc748569b10ed9", 0 ) )
        {
            level thread debug::drawsphere( target_location, 45, 3, ( 1, 0.75, 0.75 ) );
        }
    #/
    
    contentsoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 1, 1 );
    trace = trace::sphere_trace( spawn_location, target_location, 45, drone, contentsoverride );
    trace_passed = !isdefined( trace[ "hittype" ] ) || trace[ "hittype" ] == "hittype_none";
    
    /#
        if ( getdvarint( @"hash_8dc748569b10ed9", 0 ) )
        {
            trace::draw_trace( trace, trace_passed ? ( 0, 1, 0 ) : ( 0.5, 0, 1 ), 1, 60 );
        }
    #/
    
    if ( trace_passed )
    {
        return locations;
    }
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x4c2cb5f7, Offset: 0x64e0
// Size: 0xbb
function private select_random_drone_type()
{
    /#
        if ( isdvardefined( @"hash_795d3aed192a4b63" ) )
        {
            return getdvar( @"hash_795d3aed192a4b63" );
        }
    #/
    
    var_5de8720be690db32 = [];
    
    foreach ( var_f3dc352df97f52c8, var_cdffe119ed60d14d in level.var_ca8bc9130358e5fb )
    {
        if ( !var_cdffe119ed60d14d.manuallyspawned )
        {
            var_5de8720be690db32[ var_f3dc352df97f52c8 ] = var_cdffe119ed60d14d;
        }
    }
    
    return utility::random_key( var_5de8720be690db32 );
}

// Namespace br_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x913d06a4, Offset: 0x65a4
// Size: 0xb2
function private function_ea04470da79b949b( type )
{
    var_13393fdcef643f57 = self.var_13393fdcef643f57;
    
    if ( !var_13393fdcef643f57 )
    {
        return;
    }
    
    foreach ( var_11a197e119a34fa in var_13393fdcef643f57 )
    {
        if ( var_11a197e119a34fa.helperdrone_type && var_11a197e119a34fa.helperdrone_type == type )
        {
            return var_11a197e119a34fa;
        }
    }
}

// Namespace br_flying_drone
// Params 1
// Checksum 0x8f8c6f45, Offset: 0x665e
// Size: 0x5b
function drone_startcamo( drone )
{
    if ( drone.is_camo_activated )
    {
        return;
    }
    
    drone.is_camo_activated = 1;
    
    if ( isdefined( drone getscriptablepartstate( "active_camo_fx", 0 ) ) )
    {
        drone setscriptablepartstate( "active_camo_fx", "on", 0 );
        return;
    }
    
    assertmsg( "<dev string:x1fd>" );
}

// Namespace br_flying_drone
// Params 1
// Checksum 0xd06dbce, Offset: 0x66c1
// Size: 0x5b
function function_9022369d3fc8a419( drone )
{
    if ( !drone.is_camo_activated )
    {
        return;
    }
    
    drone.is_camo_activated = 0;
    
    if ( isdefined( drone getscriptablepartstate( "active_camo_fx", 0 ) ) )
    {
        drone setscriptablepartstate( "active_camo_fx", "deactivate", 0 );
        return;
    }
    
    assertmsg( "<dev string:x1fd>" );
}

// Namespace br_flying_drone
// Params 0
// Checksum 0xf7af6570, Offset: 0x6724
// Size: 0x36
function clean_up_drone()
{
    self notify( #"drone_cleaned_up" );
    self.activity_instance thread entity_cleanup( self );
    level.huntdrones = arrayremove( level.huntdrones, self );
}

// Namespace br_flying_drone
// Params 1
// Checksum 0x54900141, Offset: 0x6762
// Size: 0x21
function entity_cleanup( maindrone )
{
    function_a08f109bc062fffe();
    
    if ( maindrone )
    {
        maindrone function_25c91463a5c7d654();
    }
}

// Namespace br_flying_drone
// Params 0, eflags: 0xc
// Checksum 0xac675e63, Offset: 0x678b
// Size: 0x98
function private function_25c91463a5c7d654()
{
    self notify( #"hash_22913fa93b4ec269" );
    self endon( #"hash_22913fa93b4ec269" );
    
    if ( !self )
    {
        return;
    }
    
    if ( isdefined( level.ob_drones ) && arraycontains( level.ob_drones, self ) )
    {
        level.ob_drones = arrayremove( level.ob_drones, self );
    }
    
    if ( self.activity_instance )
    {
        self.activity_instance.drone = undefined;
    }
    
    if ( isdefined( self.scriptedobjid ) )
    {
        objidpoolmanager::returnobjectiveid( self.scriptedobjid );
    }
    
    self delete();
}

// Namespace br_flying_drone
// Params 0
// Checksum 0xc43ca6b, Offset: 0x682b
// Size: 0x97
function function_a08f109bc062fffe()
{
    self notify( #"hash_a1298e35c527aedc" );
    self endon( #"hash_a1298e35c527aedc" );
    
    foreach ( drone in self.helper_drones )
    {
        drone notify( #"death" );
    }
}

// Namespace br_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xf46d876, Offset: 0x68ca
// Size: 0xeb
function private function_326ed7483e566ce4()
{
    drone = self;
    drone.scriptedobjid = drone objidpoolmanager::createobjective_internal( "saw_ui_icon_drone", 1, 0 );
    
    if ( drone.scriptedobjid == -1 )
    {
        return;
    }
    
    objidpoolmanager::function_373aaf492aabde6f( drone.scriptedobjid, 174, 247, 135 );
    objidpoolmanager::function_9d4895ed38151e46( drone.scriptedobjid, 1 );
    objidpoolmanager::function_586b631e7bbb592a( drone.scriptedobjid, 1 );
    objective_disableping( drone.scriptedobjid, 0 );
    function_461834c350793158( drone.scriptedobjid, 1 );
    objective_setlabel( drone.scriptedobjid, &"br_gametype_bongo/activity_drone_hunt" );
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_saw_bongo_activity_drone_hunt" );
    function_3f1a6a0ae5901866( drone.scriptedobjid, hovercardid );
}

/#

    // Namespace br_flying_drone
    // Params 0
    // Checksum 0x6477a9df, Offset: 0x69bd
    // Size: 0x2cb, Type: dev
    function function_5fc6b44c9edd444a()
    {
        drone = self;
        
        if ( drone.activity_instance )
        {
            drone.activity_instance endon( #"activity_ended" );
            drone.activity_instance endon( #"instance_destroyed" );
        }
        
        drone endon( #"death" );
        drone endon( #"drone_cleaned_up" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
            {
                sphere( drone.spawn_pos, drone.var_26ad585bf3f8d930.var_3af1960784817aa8.var_d527fe070d34d975, ( 0, 0, 1 ), 1 );
                str = "<dev string:x235>";
                
                switch ( drone.goal )
                {
                    case #"hash_6573e43fb6b70d11":
                        str += "<dev string:x23b>";
                        break;
                    case #"follow":
                        str += "<dev string:x242>";
                        break;
                    case #"flee":
                        str += "<dev string:x249>";
                        break;
                }
                
                if ( drone.var_2d79ae35ed58827b )
                {
                    str += "<dev string:x24e>";
                }
                
                debugstar( drone.origin, ( 1, 1, 0 ), 1, str, 0.7 );
                memory = drone.memory;
                
                if ( memory.vis_stack.size > 0 )
                {
                    for ( i = 0; i < memory.vis_stack.size ; i++ )
                    {
                        sphere( memory.vis_stack[ i ], 50, ( 1, 1, 0 ), 0 );
                        debugstar( memory.vis_stack[ i ], ( 1, 1, 0 ), 1, "<dev string:x257>" + i, 0.7 );
                        
                        if ( i < memory.vis_stack.size - 1 )
                        {
                            line( memory.vis_stack[ i ], memory.vis_stack[ i + 1 ], ( 1, 1, 0 ), 1, 0 );
                        }
                    }
                }
                
                if ( memory.bad_pos.size > 0 )
                {
                    for ( i = 0; i < memory.bad_pos.size ; i++ )
                    {
                        sphere( memory.bad_pos[ i ], 50, ( 1, 0, 0 ), 0 );
                        debugstar( memory.bad_pos[ i ], ( 1, 0, 0 ), 1, "<dev string:x260>" + i, 0.7 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_flying_drone
    // Params 3, eflags: 0x4
    // Checksum 0xcad9c8e0, Offset: 0x6c90
    // Size: 0xc6, Type: dev
    function private function_aa022112ed9c7c9f( drone, name, color )
    {
        level endon( #"game_ended" );
        
        if ( drone.activity_instance )
        {
            drone.activity_instance endon( #"activity_ended" );
            drone.activity_instance endon( #"instance_destroyed" );
        }
        
        drone endon( #"entitydeleted" );
        drone endon( #"death" );
        
        while ( true )
        {
            if ( drone.centerpos )
            {
                print3d( drone.centerpos + ( 0, 0, 25 ), name, color, 1, 0.25, 60, 1 );
            }
            
            wait 1;
        }
    }

    // Namespace br_flying_drone
    // Params 0, eflags: 0x4
    // Checksum 0x15cd42eb, Offset: 0x6d5e
    // Size: 0x17c, Type: dev
    function private function_76bc89c08728368f()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            dronetype = getdvar( @"hash_529e071d05d4d0bf", "<dev string:x26a>" );
            
            if ( dronetype != "<dev string:x26a>" )
            {
                setdvar( @"hash_529e071d05d4d0bf", "<dev string:x26a>" );
                var_4a2ecdf7c2ab2198 = level.var_ca8bc9130358e5fb[ dronetype ];
                
                if ( !isdefined( var_4a2ecdf7c2ab2198 ) )
                {
                    assertmsg( "<dev string:x18b>" + dronetype + "<dev string:x197>" );
                    continue;
                }
                
                pos = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 200;
                var_83af36daad2905ff = spawn( "<dev string:x26b>", pos + ( 0, 0, 100 ) );
                var_83af36daad2905ff setmodel( var_4a2ecdf7c2ab2198.model );
                var_83af36daad2905ff set_target_player( level.players[ 0 ] );
                var_83af36daad2905ff.angles = ( 0, vectortoyaw( var_83af36daad2905ff.targetplayer.origin - pos ), 0 );
                wait 3;
                self [[ function_688e9353411f5a0( dronetype ) ]]( var_83af36daad2905ff );
                wait 2;
                
                if ( isdefined( var_4a2ecdf7c2ab2198.cleanup ) )
                {
                    self [[ var_4a2ecdf7c2ab2198.cleanup ]]( var_83af36daad2905ff );
                }
                
                var_83af36daad2905ff delete();
            }
            
            wait 0.2;
        }
    }

    // Namespace br_flying_drone
    // Params 1, eflags: 0x4
    // Checksum 0x4127c63e, Offset: 0x6ee2
    // Size: 0x52, Type: dev
    function private function_688e9353411f5a0( dronetype )
    {
        switch ( dronetype )
        {
            case #"hash_1f1d7b3efcb82111":
                return &function_3b33d641fd3a8730;
            case #"hash_d4850e4dfbc48417":
                return &turret_drone_fire;
            default:
                break;
        }
    }

#/
