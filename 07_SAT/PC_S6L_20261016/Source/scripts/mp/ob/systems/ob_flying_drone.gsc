// scripts\mp\ob\systems\ob_flying_drone.gsc  (hash_017ecb46df92fab1.gscc) (size: 42877 Bytes / 0xa77d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9cad60ff (2628608255)
// size ...... 42877 (0xa77d)
// includes .. 25  (offset: 0xa105)
// strings ... 67  (offset: 0xa1cd)
// dev strs .. 34  (offset: 0xa5cd)
// exports ... 112 (offset: 0x6aa9)
// cseg ...... 0x46b + 0x663e (0x6aa9)
// imports ... 303 (offset: 0x7c29)
// animtree1 . 0   (offset: 0xa77d)
// animtree2 . 0   (offset: 0xa77d)
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\skills\skill_damage_upgrade;
#using scripts\mp\sentientpoolmanager;

#namespace ob_flying_drone;

// Namespace ob_flying_drone
// Params 0, eflags: 0x5
// Checksum 0xc91650b1, Offset: 0x489
// Size: 0xe
function private autoexec main()
{
    scriptable::scriptable_adddamagedcallback( &function_8a1319f5b1d357fa );
}

// Namespace ob_flying_drone
// Params 2
// Checksum 0xb45d89d2, Offset: 0x49f
// Size: 0x3fb
function function_d664e23d9508b462( spawnoptions, drone )
{
    if ( !drone )
    {
        drone = spawn( "script_model", spawnoptions.spawnpos );
    }
    
    drone setmodel( %"veh_sat_mil_air_drone_dart_leader_guild" );
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
    drone.constantalarm = spawnoptions.constantalarm ?? 1;
    drone.vehiclename = "ob_guild_drone";
    drone.hackable = spawnoptions.hackable ?? 1;
    drone.var_d2239bfa942af92e = spawnoptions.var_d2239bfa942af92e ?? 0;
    drone.var_26ad585bf3f8d930 = spawnoptions.var_2858c1d9ffae3f84;
    drone.difficulty = spawnoptions.difficulty_region;
    function_2021bb53c318b078( drone );
    drone.type = %"main_drone";
    drone.var_d62ad5bfd64ba592 = "tag_origin";
    drone sentientpoolmanager::registersentient( "Drone", "team_hundred_ninety" );
    drone.maxarmorhealth = drone.armorhealth;
    
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
    drone thread function_cf1cc23975f9c938();
    
    if ( drone.canmove )
    {
        drone thread function_afbbd06f0ab74b0b( undefined, undefined, "main_drone_destroyed" );
        drone thread functionals_utility::function_3d1c0cb00ce4d44e( 20, 10, 7, "main_drone_destroyed" );
        drone thread function_ee97628f4ae363d2( 1, drone.var_cf18d9f8c9aadf2c ?? 1, "main_drone_destroyed" );
    }
    
    visibility_mode::function_3afc3bc470c80e61( drone, "team_hundred_ninety" );
    
    if ( !isdefined( level.huntdrones ) )
    {
        level.huntdrones = [];
    }
    
    level.huntdrones[ level.huntdrones.size ] = drone;
    drone thread function_c905b1cd9125edb3();
    drone enableplayermarks( #"air_killstreak" );
    return drone;
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xd6b4065d, Offset: 0x8a3
// Size: 0x2e
function private function_cf1cc23975f9c938()
{
    self endon( #"main_drone_destroyed" );
    
    while ( true )
    {
        utility::waittill_any( "player_scanned", "damage" );
        thread engage_target_player();
    }
}

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0x1ab56f02, Offset: 0x8d9
// Size: 0x10d
function private function_ee97628f4ae363d2( is_main_drone, var_bb87da9f15b57fae, deathnotifyoverride = "death" )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self endon( deathnotifyoverride );
    
    while ( true )
    {
        waitframe();
        
        if ( !self.targetplayer )
        {
            continue;
        }
        
        if ( function_80f6e0b383eae3aa( is_main_drone ) )
        {
            self.var_9e9bed3107ce8f37 = self.targetplayer.origin;
            
            if ( var_bb87da9f15b57fae )
            {
                wait var_bb87da9f15b57fae;
            }
            
            radius = is_main_drone ? self.var_82cedb79f1d56e1 : self.options.var_75fab83acb648e4e ?? 500;
            function_9878399de2b61b61( is_main_drone, radius );
            
            if ( !self.targetplayer && is_main_drone )
            {
                self.goal = #"hash_6573e43fb6b70d11";
                function_e0de4dce57ae487();
                self.undamaged = 1;
                thread function_dbc3536438aea5e0();
            }
        }
    }
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xb00c1a1d, Offset: 0x9ee
// Size: 0x90, Type: bool
function private function_80f6e0b383eae3aa( is_main_drone )
{
    if ( self.targetplayer.ignoreme || self.targetplayer.notarget )
    {
        return true;
    }
    
    if ( is_main_drone )
    {
        var_3a6934f5e814b149 = squared( self.var_2062fb08de3993a8 ?? 3000 );
        distance_to_target = distancesquared( self.origin, self.targetplayer.origin );
        return ( distance_to_target > var_3a6934f5e814b149 );
    }
    
    return false;
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x3308fc, Offset: 0xa87
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

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x2e58fd2f, Offset: 0xb04
// Size: 0x3d
function private engage_target_player()
{
    self endon( #"main_drone_destroyed" );
    self endon( #"hash_53309d9cf6cef8" );
    function_b62d57c03a13139d();
    utility::waittill_any_timeout( self.var_4922a62c04b53c20, "engage_phase" );
    function_5366327c25ea5eb2();
}

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0xe9e4a1a9, Offset: 0xb49
// Size: 0x5a
function private function_9878399de2b61b61( is_main_drone, range, random_fallback )
{
    nearby_players = get_valid_nearby_players( range, is_main_drone );
    closest_valid_player = get_closest_player( nearby_players, self.origin, range, random_fallback );
    set_target_player( closest_valid_player );
}

// Namespace ob_flying_drone
// Params 4, eflags: 0x4
// Checksum 0x97883cff, Offset: 0xbab
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

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xbf8fa5d3, Offset: 0xc11
// Size: 0x148
function private get_valid_nearby_players( var_67f9e5a5f6aed92, is_cylinder_scan )
{
    if ( is_cylinder_scan )
    {
        droneheight = self.var_6f8e1815c814e080;
        dronehalfheight = droneheight / 2;
        scanradius = get_scan_radius();
        cylinderorigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - droneheight );
        nearbyplayers = utility::playersincylinder( cylinderorigin, scanradius, undefined, dronehalfheight );
    }
    else
    {
        nearbyplayers = getplayersinradius( self.origin, var_67f9e5a5f6aed92 );
    }
    
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x7629dd2d, Offset: 0xd62
// Size: 0x1e3
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
    drone.var_d13e9fbd20acbc22 = squared( var_3af1960784817aa8.var_d527fe070d34d975 );
    drone.var_6f8e1815c814e080 = var_3af1960784817aa8.var_9d6e5c4f83529fed;
    drone.var_6f6b0e15c7ee82ca = var_3af1960784817aa8.var_9d4b464f832c27d3;
    drone.var_5e66b7c01aeca260 = var_3af1960784817aa8.var_6f91fe8c43809c29;
    drone.var_a4680a90389f44d6 = var_3af1960784817aa8.var_1b296c2e6e6d9a93;
    drone.var_4922a62c04b53c20 = var_3af1960784817aa8.var_e78c1777d326e787;
    drone.pingtimeout = var_3af1960784817aa8.var_492ad2865ab05fc4;
    drone.var_82cedb79f1d56e1 = var_3af1960784817aa8.var_9fc76fa9c11fbf46;
    drone.explosivedamageresistance = var_3af1960784817aa8.var_f12362f801752580;
    drone.var_cf18d9f8c9aadf2c = var_3af1960784817aa8.var_ba9d47e7795035fc;
    drone.var_2062fb08de3993a8 = var_3af1960784817aa8.var_91c5217173fdf4fb;
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x718bbf07, Offset: 0xf4d
// Size: 0x11c
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
        case #"hash_c0250ffc2e87f2ff":
            selecteddifficulty = var_5b5f27d5b9e3ff84.var_bd1cf01969b3d151;
            var_ebb91a48b05fc839 = var_f263818e27888a37.var_af4d91a169ad1dfa;
            break;
        default:
            break;
    }
    
    return { #var_96656a7c0b586e3e:var_ebb91a48b05fc839.var_d34b703260bcafbe, #lootitemlist:var_ebb91a48b05fc839.var_2850ce95abe69659, #difficulty:selecteddifficulty };
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x1d0b46ea, Offset: 0x1072
// Size: 0x2bc
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
    drone.var_9c314d416ddd1b3b = difficultysettings.var_2f81e488ee941e35.var_a7be53be8c562950 * 0.01;
    drone.var_5872025589d5212a = difficultysettings.var_2f81e488ee941e35.var_dba813c2547d1e65;
    drone.var_1fb9c0976545cc48 = difficultysettings.var_2f81e488ee941e35.var_26be19cde5d33b33;
    drone.var_5d4aa07606eb3b32 = difficultysettings.var_2f81e488ee941e35.var_2031e83d46a7615f;
    drone.var_a05cdaf885c11d8f = difficultysettings.var_2f81e488ee941e35.var_f8c8a53f06d60950;
    drone.var_8dfccfdc3bf47ba0 = difficultysettings.var_2f81e488ee941e35.var_5989e4df12b17be5;
    drone.var_bbaa752c5f96f86a = difficultysettings.var_2f81e488ee941e35.var_44b8cd2df6b9d533;
    drone.var_1ea01df8fa00c328 = difficultysettings.var_2f81e488ee941e35.var_cbd002da22a03c11;
    drone.var_1ddf4d1db13ee342 = difficultysettings.var_2f81e488ee941e35.var_662f523ec7d4c3a7;
    drone.maxhealth = difficultysettings.drone_maxhealth;
    drone.health = drone.maxhealth;
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0x7f7d74fc, Offset: 0x1336
// Size: 0x1f9
function drone_movebehavior()
{
    self notify( #"hash_1c1eb1e44b7c3811" );
    self endon( #"hash_1c1eb1e44b7c3811" );
    
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
        
        if ( !self.alert && self.targetplayer && distancesquared( self.targetplayer.origin, self.origin ) < squared( self.var_a4680a90389f44d6 ) )
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
        
        /#
            if ( getdvarint( @"hash_c686b2680dbb00a2", 0 ) )
            {
                line( self.origin, var_b1dd718a8fbb3c1c, ( 0, 1, 0 ), 1, 0, debug_draw_frames );
                debugstar( var_b1dd718a8fbb3c1c, ( 0, 1, 0 ), debug_draw_frames, "<dev string:xd3>", 1 );
            }
        #/
        
        drone_move_to( var_b1dd718a8fbb3c1c, move_time, 1 );
        
        if ( self.goal == #"hash_6573e43fb6b70d11" )
        {
            wait self.stationarytime;
        }
        
        waitframe();
    }
}

// Namespace ob_flying_drone
// Params 1
// Checksum 0xdcde351d, Offset: 0x1537
// Size: 0xd8
function function_aba08bf509c70293( node )
{
    self notify( #"hash_eb817ddaa909b735" );
    self endon( #"hash_eb817ddaa909b735" );
    
    if ( !self )
    {
        assertmsg( "<dev string:xdd>" );
        return;
    }
    
    self endon( #"main_drone_destroyed" );
    self endon( #"hash_84941674cca5e76d" );
    self endon( #"drone_cleaned_up" );
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

// Namespace ob_flying_drone
// Params 0
// Checksum 0x263710c3, Offset: 0x1617
// Size: 0x56
function function_e0de4dce57ae487()
{
    self notify( #"hash_53309d9cf6cef8" );
    self setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"on" );
    self setscriptablepartstate( #"scanner", #"on" );
    self setscriptablepartstate( #"light", #"on_idle" );
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0x479584f2, Offset: 0x1675
// Size: 0x3d
function function_b62d57c03a13139d()
{
    self.alert = 1;
    self setscriptablepartstate( #"scanner", #"off" );
    self setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"on_alarm" );
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0x43ab535b, Offset: 0x16ba
// Size: 0x74
function function_5366327c25ea5eb2()
{
    if ( !self )
    {
        return;
    }
    
    self.alert = 0;
    self.var_f6891b6fecc0bdbb = 1;
    scriptable_state = self.constantalarm ? #"on_alarm" : #"on";
    utility::function_32b24db3127bff40( #"hash_c62470ae8c9fe1d0", scriptable_state );
    self setscriptablepartstate( #"light", #"on_engaged" );
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0xe90abc31, Offset: 0x1736
// Size: 0x13e
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
    
    /#
        if ( getdvarint( @"hash_35fd8d2baf7e74ff", 0 ) )
        {
            line( self.origin, var_b1dd718a8fbb3c1c, ( 1, 0.5, 0 ), 1, 0, debug_draw_frames );
            debugstar( var_b1dd718a8fbb3c1c, ( 1, 0.5, 0 ), debug_draw_frames, "<dev string:x11a>", 1 );
        }
    #/
    
    drone_move_to( var_b1dd718a8fbb3c1c, self.dashmovetime, 1 );
    self setscriptablepartstate( "audio_move", "drone_move" );
    thread drone_movebehavior();
    self.canmove = 1;
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xb6a2b940, Offset: 0x187c
// Size: 0x2b
function private function_754154cc2de43d5a( hackeffect, attacker )
{
    if ( hackeffect.var_bfc0167eb5f93d9d )
    {
        explosive_drone_explosion( self );
    }
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x766602c1, Offset: 0x18af
// Size: 0x109
function private function_3ebe82fd94134869( hackeffect, attacker )
{
    if ( hackeffect.hackduration )
    {
        foreach ( ent in level.huntdrones )
        {
            if ( ent != self )
            {
                ent thread function_a153a610e50d7d7d( hackeffect.speedscale, hackeffect.hackduration * 0.001 );
            }
        }
    }
    
    if ( hackeffect.var_bfc0167eb5f93d9d )
    {
        explosive_drone_explosion( self );
        return;
    }
    
    if ( hackeffect.hackduration )
    {
        thread function_a153a610e50d7d7d( hackeffect.speedscale, hackeffect.hackduration * 0.001 );
    }
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xf16f7cc8, Offset: 0x19c0
// Size: 0x400
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
    drone.undamaged = 1;
    
    while ( true )
    {
        waitframe();
        drone waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        dmg_struct = spawnstruct();
        dmg_struct.einflictor = einflictor;
        dmg_struct.objweapon = objweapon;
        dmg_struct.idamage = idamage;
        dmg_struct.smeansofdeath = smeansofdeath;
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
        
        drone damage_utility::function_723dcec170ec23be( eattacker );
        dmg_struct.eattacker = eattacker;
        drone function_98e8387747817ac( dmg_struct, eattacker, objweapon, smeansofdeath );
        drone.health -= int( dmg_struct.idamage );
        
        if ( drone.undamaged )
        {
            drone.undamaged = 0;
            drone notify( #"drone_first_damage" );
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
        }
        
        if ( !drone is_smoking() )
        {
            drone thread smoke();
        }
        
        if ( drone.canmove )
        {
            if ( getdvarint( @"harvesterorb_move", 1 ) )
            {
                drone thread drone_dash();
                drone set_target_player( eattacker, 1 );
                
                if ( drone.goal == #"hash_6573e43fb6b70d11" && drone.targetplayer )
                {
                    drone.goal = #"follow";
                }
            }
        }
        
        if ( drone.health <= 0 )
        {
            foreach ( player in drone.a_n_player_damage )
            {
                if ( player == eattacker )
                {
                    eattacker thread utility::callsharedfunc( #"player", #"doScoreEvent", #"guild_drone_destroyed" );
                    continue;
                }
                
                player thread utility::callsharedfunc( #"player", #"doScoreEvent", #"guild_drone_destroyed_assist" );
            }
        }
        
        drone thread function_96802b2371d041a0( vdir, vpoint, dmg_struct );
    }
}

// Namespace ob_flying_drone
// Params 4, eflags: 0x4
// Checksum 0x95d6abbb, Offset: 0x1dc8
// Size: 0xa6
function private function_98e8387747817ac( dmg_struct, eattacker, objweapon, smeansofdeath )
{
    function_6229eec46b16b31f( eattacker.var_1a7d1b6efaad038f, dmg_struct );
    dmg_struct.idamage = skill_damage_upgrade::function_d58c577b1023f91( dmg_struct.idamage, objweapon, eattacker );
    dmg_struct.idamage = function_8eab21742cb4b1d3( dmg_struct );
    
    if ( isexplosivedamagemod( smeansofdeath ) && self.explosivedamageresistance )
    {
        dmg_struct.idamage *= self.explosivedamageresistance;
    }
}

// Namespace ob_flying_drone
// Params 11, eflags: 0x4
// Checksum 0x2ac9d7c1, Offset: 0x1e76
// Size: 0x91
function private function_8a1319f5b1d357fa( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( instance.type != "sat_ob_activity_drone_hunt" )
    {
        return;
    }
    
    function_5464cd28c06e40b2( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname );
}

// Namespace ob_flying_drone
// Params 11, eflags: 0x4
// Checksum 0x37893e0, Offset: 0x1f0f
// Size: 0x14b
function private function_5464cd28c06e40b2( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( !isplayer( eattacker ) )
    {
        eattacker = eattacker.owner;
    }
    
    if ( !eattacker || !isplayer( eattacker ) || !eattacker isconnected() )
    {
        return;
    }
    
    drone = instance.entity;
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.objweapon = objweapon;
    dmg_struct.idamage = idamage;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.eattacker = eattacker;
    function_98e8387747817ac( dmg_struct, eattacker, objweapon, smeansofdeath );
    mp_agent_damage::function_eb8ba16055d6da7c( eattacker, drone, "none", smeansofdeath, objweapon, int( dmg_struct.idamage ), shitloc, 0, undefined, 0, 0 );
    eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x387fd24d, Offset: 0x2062
// Size: 0xab
function private function_6229eec46b16b31f( callback_list, dmg_struct )
{
    foreach ( func in callback_list )
    {
        new_damage = self [[ func ]]( dmg_struct );
        
        if ( new_damage && new_damage != -1 )
        {
            dmg_struct.idamage = new_damage;
        }
    }
}

// Namespace ob_flying_drone
// Params 1
// Checksum 0x4ae1564c, Offset: 0x2115
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

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xc6886682, Offset: 0x216b
// Size: 0xc, Type: bool
function private is_smoking()
{
    return isdefined( self.var_c0a925dd22ba77e8 );
}

// Namespace ob_flying_drone
// Params 0, eflags: 0xc
// Checksum 0xe6404e8b, Offset: 0x2180
// Size: 0x86
function private smoke()
{
    self notify( #"hash_12bc25e0c41eb6d1" );
    self endon( #"hash_12bc25e0c41eb6d1" );
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

// Namespace ob_flying_drone
// Params 0
// Checksum 0x8f800b2, Offset: 0x220e
// Size: 0x1c8
function function_dbc3536438aea5e0()
{
    self notify( #"hash_b8d868f0ac5faa5a" );
    self endon( #"hash_b8d868f0ac5faa5a" );
    drone = self;
    drone endon( #"death" );
    drone endon( #"damage" );
    
    while ( true )
    {
        scanradius = drone get_scan_radius();
        nearbyplayers = get_valid_nearby_players( scanradius, 1 );
        
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
                drone.goal = #"follow";
            }
            
            break;
        }
        
        /#
            if ( getdvarint( @"hash_544d0f0b10ec00a4", 0 ) )
            {
                droneheight = drone.var_6f8e1815c814e080;
                cylinderorigin = ( drone.origin[ 0 ], drone.origin[ 1 ], drone.origin[ 2 ] - droneheight );
                utility::draw_capsule( cylinderorigin, scanradius, droneheight, undefined, undefined, undefined, 5 );
            }
        #/
        
        wait 0.5;
    }
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x8f27e7de, Offset: 0x23de
// Size: 0x20
function private get_scan_radius()
{
    droneheight = self.var_6f8e1815c814e080;
    return droneheight * tan( 40 );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xfa3c820e, Offset: 0x2407
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

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0xf50ad981, Offset: 0x245b
// Size: 0x5b8
function private function_58b0e89a196a240( ideal_move_distance, is_critical, debug_move_time )
{
    drone = self;
    min_move_distance = ideal_move_distance / 2;
    trace_counter = 0;
    var_444fd2dad0a6522b = 0;
    out_of_bounds_counter = 0;
    out_of_range_tolerance = 10;
    trace_tolerance = 6;
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
        ground_pos = function_9449b8c8732d5b40( forward );
        elevation = function_8399761ad6cf92b7( drone );
        
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
    
    return new_pos;
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xc0eb5c16, Offset: 0x2a1c
// Size: 0x115
function private function_1b697f7c55150386( is_critical = 0 )
{
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

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0x2b5d4b1d, Offset: 0x2b3a
// Size: 0x138
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
            drone thread drone_shutdown( var_a21c0ba6ea3deb5d, contact_point, dmg_struct );
            return;
        }
    #/
    
    if ( drone.health / drone.maxhealth <= drone.var_9c314d416ddd1b3b )
    {
        drone notify( #"engage_phase" );
    }
    
    if ( drone.health <= 0 )
    {
        drone.health = 1;
        drone.var_24954f14e27b448d = 0;
        visibility_mode::function_4e6c654251b854e0( drone );
        
        if ( drone.activity_instance )
        {
            namespace_9085ae059032a84f::updateprogress( 1, drone.activity_instance );
        }
        
        drone thread drone_shutdown( var_a21c0ba6ea3deb5d, contact_point, dmg_struct );
        return;
    }
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x18b5c1a1, Offset: 0x2c7a
// Size: 0x182, Type: bool
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
    
    return true;
}

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0x53522a8, Offset: 0x2e05
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xc7a6e667, Offset: 0x2eb2
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x79172a8a, Offset: 0x2f5a
// Size: 0x42
function private function_9449b8c8732d5b40( origin )
{
    navmesh_pos = getclosestpointonnavmesh( origin );
    ground_pos = utility::drop_to_ground( navmesh_pos, 3500, -1000 );
    return ( navmesh_pos[ 0 ], navmesh_pos[ 1 ], ground_pos[ 2 ] );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x3f46d954, Offset: 0x2fa5
// Size: 0x26
function private function_8399761ad6cf92b7( drone )
{
    return randomfloatrange( drone.var_6f6b0e15c7ee82ca, drone.var_6f8e1815c814e080 );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x7e755548, Offset: 0x2fd4
// Size: 0x138
function private function_ff84fddba0052fb4( point )
{
    drone = self;
    
    if ( drone.goal == #"hash_6573e43fb6b70d11" )
    {
        exclude = 0;
        
        if ( distance2dsquared( point, drone.spawn_pos ) > drone.var_d13e9fbd20acbc22 )
        {
            exclude = 1;
        }
        
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

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x389e69f2, Offset: 0x3115
// Size: 0x79
function private function_5f430a07467a815e( start, end )
{
    drone = self;
    height = 200;
    offset = ( 0, 0, height / 2 );
    contentsoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 1, 0 );
    return trace::capsule_trace( start - offset, end - offset, 50, height, undefined, [ drone ], contentsoverride );
}

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0x2d9bc34a, Offset: 0x3197
// Size: 0x5b
function private function_36b59443bc6b6eb2( start, end, radius )
{
    drone = self;
    contentsoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 1, 0 );
    return trace::sphere_trace( start, end, radius, [ drone ], contentsoverride );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x5c0197a4, Offset: 0x31fb
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

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x20e692f7, Offset: 0x32aa
// Size: 0x23
function private function_f75ba697583360af()
{
    memory = self.memory;
    return memory.vis_stack.size;
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xe85884ff, Offset: 0x32d6
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

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x3359ea2, Offset: 0x334b
// Size: 0x80
function private function_3e4625cb05272411()
{
    drone = self;
    activity_instance = self.activity_instance;
    
    if ( drone.goal == #"follow" )
    {
        if ( drone.targetplayer )
        {
            point = drone function_de9fae46bc8e22dc( drone.targetplayer );
            return vectornormalize( point - drone.origin );
        }
    }
    
    return utility::randomvector( 1 );
}

// Namespace ob_flying_drone
// Params 3
// Checksum 0xc8357b49, Offset: 0x33d4
// Size: 0x10f
function drone_shutdown( damagedirection, impactpoint, dmg_struct )
{
    level endon( #"game_ended" );
    drone = self;
    drone notify( #"stop_moving" );
    drone notify( #"hash_84941674cca5e76d" );
    drone setcandamage( 0 );
    drone setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"hash_bf8376017b63605" );
    callback::callback( #"guild_drone_destroyed", dmg_struct );
    
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
        drone function_3966d4c5fee88857();
    }
    
    drone notify( #"main_drone_destroyed" );
    drone drone_destroy();
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x4deb7bbe, Offset: 0x34eb
// Size: 0x3c7
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
    
    if ( drone.var_d2239bfa942af92e )
    {
        drone notify( #"main_drone_destroyed" );
    }
    
    linked_children = drone getlinkedchildren();
    
    foreach ( child in linked_children )
    {
        child unlink();
        child delete();
    }
    
    drone setnonstick( 0 );
    drone setnodeploy( 0 );
    waitframe();
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
    
    if ( drone.var_d2239bfa942af92e )
    {
        drone notify( #"hash_c5b00d1f474077b8" );
    }
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0x3046d5fa, Offset: 0x38ba
// Size: 0x1c, Type: bool
function is_main_drone()
{
    if ( self.type == %"main_drone" )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xd67a04f9, Offset: 0x38df
// Size: 0x17
function private function_60565c02f10c727a()
{
    return "light" + "_" + self.type;
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xdcebf968, Offset: 0x38ff
// Size: 0x5c
function private function_3966d4c5fee88857()
{
    groundposition = getgroundposition( self.origin, 1 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( groundposition );
    level common_item::function_38cde6a6acb68ea6( self.loot_item_list, self.loot_item_count, spawnoptions );
    utility::function_7c10ea82c1e305b8( "item_spawn", "spawn" );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xf77f1498, Offset: 0x3963
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xe5c8b36d, Offset: 0x3a12
// Size: 0x72
function private function_de9fae46bc8e22dc( var_57f06685d6d47d0f )
{
    drone = self;
    playerorigin = var_57f06685d6d47d0f.origin;
    newaltitude = function_8399761ad6cf92b7( drone );
    newposition = function_78a5b128a3e32460( playerorigin, drone.var_a4680a90389f44d6, drone.var_5e66b7c01aeca260 );
    return ( newposition[ 0 ], newposition[ 1 ], newaltitude );
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xd82ae70, Offset: 0x3a8d
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

// Namespace ob_flying_drone
// Params 3, eflags: 0x4
// Checksum 0xace6c676, Offset: 0x3b97
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

// Namespace ob_flying_drone
// Params 1
// Checksum 0x2f8edd4e, Offset: 0x3c36
// Size: 0x9f
function function_50b8681675cdb7f6( var_1564b16dac510452 )
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone notify( #"stop_moving" );
    drone notify( #"hash_84941674cca5e76d" );
    var_8610c6497eb5309 = ( drone.origin[ 0 ], drone.origin[ 1 ], drone.origin[ 2 ] + var_1564b16dac510452 );
    move_time = drone.var_4f9479db21cbaf60;
    drone moveto( var_8610c6497eb5309, move_time );
    wait move_time;
    clean_up_drone();
}

// Namespace ob_flying_drone
// Params 3
// Checksum 0x6b3fc7a3, Offset: 0x3cdd
// Size: 0x23a
function function_afbbd06f0ab74b0b( var_31fe29b7c09cbb46 = 7.5, var_4be93e36d0153d0c = 1, deathnotifyoverride = "death" )
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
        else if ( length >= var_4be93e36d0153d0c )
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

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xa29f1965, Offset: 0x3f1f
// Size: 0xa3
function private drone_destroy()
{
    drone = self;
    
    if ( !drone.var_d2239bfa942af92e )
    {
        drone setscriptablepartstate( #"exit", #"final_explode" );
    }
    
    drone setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"off" );
    drone setscriptablepartstate( #"scanner", #"off" );
    drone setscriptablepartstate( #"light", #"off" );
    
    if ( drone.var_d2239bfa942af92e )
    {
        waitframe();
    }
    else
    {
        wait 0.75;
    }
    
    drone function_25c91463a5c7d654();
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x4bfd094c, Offset: 0x3fca
// Size: 0xeb
function private function_8eab21742cb4b1d3( dmg_struct )
{
    objweapon = dmg_struct.objweapon;
    eattacker = dmg_struct.eattacker;
    smeansofdeath = dmg_struct.smeansofdeath;
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_d276db87d69299de" ) )
    {
        var_b92817d29e3cb812 = utility::callsharedfunc( #"zombie_damage", #"hash_d276db87d69299de", objweapon, eattacker );
        dmg_struct.idamage *= var_b92817d29e3cb812;
    }
    
    rarity = eattacker zombie_damage::function_af20e81da38c49bc( objweapon );
    var_b92817d29e3cb812 = zombie_damage::function_6786d0923b8261db( objweapon, smeansofdeath, rarity );
    dmg_struct.idamage *= var_b92817d29e3cb812;
    return dmg_struct.idamage;
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0x8839fe6e, Offset: 0x40be
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

// Namespace ob_flying_drone
// Params 5
// Checksum 0xd2757207, Offset: 0x413c
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

// Namespace ob_flying_drone
// Params 6
// Checksum 0xb900f7e6, Offset: 0x41e2
// Size: 0x347
function spawn_helper_drone( dronetype, target, spawn_locations_array, start_struct, options, var_549eab4252c605ef = 1 )
{
    if ( !isdefined( self.helper_drones ) )
    {
        self.helper_drones = [];
    }
    
    if ( !spawn_locations_array && !start_struct )
    {
        return;
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
        return;
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
        return;
    }
    
    drone setmodel( var_4a2ecdf7c2ab2198.model );
    drone.angles = ( 0, vectortoyaw( target.origin - spawnlocation ), 0 );
    drone setcandamage( 1 );
    drone enableaimassist();
    drone.type = dronetype;
    drone.health = 5;
    drone.maxhealth = 5;
    drone.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_2c342785e20cc7ff" );
    drone.var_24954f14e27b448d = 1;
    drone.options = options;
    drone.var_c48a311adb63f5da = 25;
    drone.var_7a09c045385eacee = 25;
    drone.locationpath = locationpath;
    drone.subclass = "ob_helper_drone";
    drone.hackable = options.hackable ?? 1;
    drone.state = 1;
    drone setscriptablepartstate( "audio_engine", "on" );
    drone_startcamo( drone );
    drone enableplayermarks( #"air_killstreak" );
    
    if ( var_549eab4252c605ef )
    {
        drone sentientpoolmanager::registersentient( "Drone", "team_hundred_ninety" );
    }
    else
    {
        drone.team = "team_hundred_ninety";
    }
    
    visibility_mode::function_3afc3bc470c80e61( drone, "team_hundred_ninety" );
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
    
    /#
        if ( getdvarint( @"hash_b6b8f93be406d1f", 0 ) )
        {
            iprintlnbold( "<dev string:x1a8>" + dronetype + "<dev string:x1bd>" + spawnlocation );
        }
    #/
    
    thread helper_drone_activate( drone, var_4a2ecdf7c2ab2198.behavior );
    return drone;
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xd3bd87ec, Offset: 0x4532
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
    drone thread function_5391f630c9faf4b2();
    drone thread function_ee97628f4ae363d2();
    
    if ( drone.options.scannerlogic )
    {
        thread function_b1c761ec31834456( drone );
    }
}

// Namespace ob_flying_drone
// Params 2
// Checksum 0x8bed8c02, Offset: 0x46d4
// Size: 0xc3
function move_helper_drone( node, move_time = 3 )
{
    self notify( #"hash_f0065af481cb758d" );
    self endon( #"hash_f0065af481cb758d" );
    
    if ( !self )
    {
        assertmsg( "<dev string:x1c2>" );
        return;
    }
    
    self endon( #"entitydeleted" );
    self endon( #"death" );
    
    for ( currnode = node; currnode && currnode.target ; currnode = nextnode )
    {
        nextnode = utility::getstruct( currnode.target, "targetname" );
        
        if ( nextnode )
        {
            drone_move_to( nextnode.origin, move_time );
        }
    }
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x3c57d9de, Offset: 0x479f
// Size: 0x102
function private helper_drone_monitor_death( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone waittill( #"death" );
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
    drone function_76b76816d532b680();
    waitframe();
    drone delete();
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xb1d2f526, Offset: 0x48a9
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x837a348c, Offset: 0x4942
// Size: 0x1cb
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
        
        drone damage_utility::function_723dcec170ec23be( eattacker );
        eattacker damagefeedback::updatehitmarker( "standard", drone.health == 0, 0, 1, "hitequip" );
        
        if ( drone.health <= 0 )
        {
            drone notify( #"death" );
            eattacker thread utility::callsharedfunc( #"player", #"doScoreEvent", #"hash_eed5397ff48259b2" );
            drone callback::callback( #"hash_86d4084ead08d3be", { #meansofdeath:smeansofdeath, #objweapon:objweapon, #damage:idamage, #inflictor:eattacker, #attacker:eattacker } );
        }
    }
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xcd9874ae, Offset: 0x4b15
// Size: 0x1ae
function private function_5391f630c9faf4b2()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self endon( #"death" );
    self endon( #"stop_movement" );
    var_75fab83acb648e4e = self.options.var_75fab83acb648e4e ?? 500;
    
    while ( true )
    {
        if ( self.emp_enabled )
        {
            waitframe();
            continue;
        }
        
        set_target_player( undefined );
        self.state = 1;
        closeplayers = getplayersinradius( self.origin, var_75fab83acb648e4e );
        
        if ( closeplayers.size > 0 )
        {
            foreach ( player in closeplayers )
            {
                invehicle = player isvehicleactive();
                content_override = trace::create_contents( 1, 1, 1, 1, 0, !invehicle );
                var_90867e9c050d37b = trace::ray_trace_passed( self.origin, player geteye(), [ self, player ], content_override );
                
                if ( player.ignoreme || player.notarget || !var_90867e9c050d37b )
                {
                    continue;
                }
                
                set_target_player( player );
                self.state = 2;
                self notify( #"target_player" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xd0050d60, Offset: 0x4ccb
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xadc52f46, Offset: 0x4d3a
// Size: 0xf2
function private helper_drone_hover( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    drone endon( #"stop_movement" );
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x59d7a899, Offset: 0x4e34
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

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xedbb1593, Offset: 0x4ec6
// Size: 0x6b
function private function_f7e5cb4fafcf4c9a()
{
    waittime = isnumber( self.options.activationdelay ) ? self.options.activationdelay : 2;
    utility::waittill_any_timeout( waittime, "target_player" );
    function_9022369d3fc8a419( self );
    self setscriptablepartstate( #"type_light", function_60565c02f10c727a() );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x935e08c2, Offset: 0x4f39
// Size: 0x62
function private turret_drone_think( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    /#
        thread function_aa022112ed9c7c9f( drone, "<dev string:x1f6>", ( 1, 1, 1 ) );
    #/
    
    turret_drone_spawn_turret( drone );
    thread turret_drone_attack_loop( drone );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x2d510e28, Offset: 0x4fa3
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xa7344c8, Offset: 0x504a
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x6675ad28, Offset: 0x515e
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
    turretweapon setturretteam( "team_hundred_ninety" );
    turretweapon.owner = drone;
    drone.turret = turretweapon;
}

// Namespace ob_flying_drone
// Params 1
// Checksum 0x5aec42dc, Offset: 0x5225
// Size: 0x3a
function turret_drone_cleanup( drone )
{
    if ( drone.turret )
    {
        drone.turret laseroff();
        drone.turret delete();
    }
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x68468cb3, Offset: 0x5267
// Size: 0x59
function private shock_drone_think( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    /#
        thread function_aa022112ed9c7c9f( drone, "<dev string:x203>", ( 0, 0, 1 ) );
    #/
    
    thread shock_drone_attack_loop( drone );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x59ee2677, Offset: 0x52c8
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xbd4192ef, Offset: 0x5336
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xa13ef9f7, Offset: 0x5461
// Size: 0x223
function private function_394f12a68648f1f5( drone )
{
    self endon( #"death" );
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
        
        ais_in_range = getaiarrayinradius( self.origin, 150 );
        
        foreach ( ai in ais_in_range )
        {
            if ( arraycontains( victim_array, ai ) )
            {
                continue;
            }
            
            if ( drone.options.immuneteam && ai.team == drone.options.immuneteam )
            {
                continue;
            }
            
            if ( isdefined( ai.type ) )
            {
                if ( ai.type == "human" )
                {
                    thread function_8dd23e8abf8c79a5( ai );
                }
                else if ( ai.type == "zombie" )
                {
                    thread function_75755563c691e96f( ai );
                }
                
                victim_array[ victim_array.size ] = ai;
            }
        }
        
        wait 0.1;
    }
    
    if ( drone )
    {
        drone.var_2db42cf2b39085c1--;
    }
    
    shock_stick::shockstick_destroy();
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x9831bfac, Offset: 0x568c
// Size: 0xdb
function private function_8dd23e8abf8c79a5( victim )
{
    victim endon( #"death" );
    firstshock = gettime() > victim._blackboard.var_ba9517cfc0287af8 + 4;
    victim._blackboard.var_ba9517cfc0287af8 = gettime();
    
    if ( victim asmhaspainstate( victim.asmname ) && firstshock )
    {
        victim asmevalpaintransition( victim.asmname );
    }
    
    victim setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    victim dodamage( 1, victim.origin );
    wait 4;
    
    if ( isalive( victim ) && victim getscriptablehaspart( "shockStickVfx" ) )
    {
        victim setscriptablepartstate( "shockStickVfx", "off", 0 );
    }
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x65381108, Offset: 0x576f
// Size: 0x63
function private function_75755563c691e96f( victim )
{
    victim endon( #"death" );
    victim zombie_stun::stun_ai( 4 );
    victim setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    wait 4;
    
    if ( isalive( victim ) && victim getscriptablehaspart( "shockStickVfx" ) )
    {
        victim setscriptablepartstate( "shockStickVfx", "off", 0 );
    }
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x749e0a27, Offset: 0x57da
// Size: 0x32
function private start_emp()
{
    self setscriptablepartstate( "emp", "on" );
    self.emp_enabled = 1;
    self.targetplayer = undefined;
    self.state = 1;
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xa65e68cb, Offset: 0x5814
// Size: 0x1c
function private clear_emp()
{
    self setscriptablepartstate( "emp", "off" );
    self.emp_enabled = undefined;
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0xae089c98, Offset: 0x5838
// Size: 0x4b
function private function_a153a610e50d7d7d( speed_scale, var_5ff489aa5b485c7d )
{
    self endon( #"main_drone_destroyed" );
    self.emp_speed_scale = speed_scale;
    add_emp();
    wait var_5ff489aa5b485c7d;
    remove_emp();
    self.emp_speed_scale = 0.5;
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x9f0fff53, Offset: 0x588b
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x3cc1ea2e, Offset: 0x58d5
// Size: 0x2b
function private remove_emp( var_39bf183c57b8c062 )
{
    self.var_c89e5b2444c6faa4--;
    
    if ( self.var_c89e5b2444c6faa4 == 0 )
    {
        clear_emp();
    }
}

// Namespace ob_flying_drone
// Params 1
// Checksum 0xe99af371, Offset: 0x5908
// Size: 0x5c
function lightning_strike_onplayer( victim )
{
    if ( isplayer( victim ) )
    {
        gestureref = "vm_ges_shockstick_react";
        curweapon = victim getcurrentweapon();
        
        if ( weapon::isfistweapon( curweapon ) )
        {
            gestureref = "vm_ges_shockstick_react_fists";
        }
    }
    
    function_587b716c0017a582( victim, gestureref );
    function_31824bd75805628( victim, gestureref );
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x2c3fcb0c, Offset: 0x596c
// Size: 0xf2
function private function_587b716c0017a582( victim, gestureref )
{
    if ( !player::isreallyalive( victim ) )
    {
        return;
    }
    
    victim endon( #"death_or_disconnect" );
    victim shock_stick::function_904e61c3aefb61c2( 1 );
    
    if ( victim.revivingteammate )
    {
        victim.var_45ab03788f1a0a4d = 1;
    }
    
    victim setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    victim setscriptablepartstate( "harvesterOrbSfx", "sfx_start", 0 );
    currentweapon = victim getcurrentweapon();
    
    if ( gestureref && currentweapon && !isnullweapon( currentweapon ) )
    {
        while ( !victim isgestureplaying( gestureref ) )
        {
            victim forceplaygestureviewmodel( gestureref );
            waitframe();
        }
    }
    
    victim startforcedfire();
    
    if ( !victim.isjuggernaut )
    {
        victim shock_stick::function_ef03efbecb279b8a( 1 );
    }
    
    victim setmovespeedscale( 0.8 );
    victim setempjammed( 1 );
    wait 4;
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x80ab43c3, Offset: 0x5a66
// Size: 0x74
function private function_31824bd75805628( victim, gestureref )
{
    if ( !victim )
    {
        return;
    }
    
    victim shock_stick::function_904e61c3aefb61c2( 0 );
    victim stopgestureviewmodel( gestureref );
    victim stopforcedfire();
    victim setscriptablepartstate( "shockStickVfx", "off", 0 );
    victim setscriptablepartstate( "harvesterOrbSfx", "sfx_done", 0 );
    victim shock_stick::function_ef03efbecb279b8a( 0 );
    victim setmovespeedscale( 1 );
    victim setempjammed( 0 );
}

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x6a2e5b84, Offset: 0x5ae2
// Size: 0x73
function private explosive_drone_think( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"death" );
    
    /#
        thread function_aa022112ed9c7c9f( drone, "<dev string:x211>", ( 1, 0, 0 ) );
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0x5416aa, Offset: 0x5b5d
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

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x759149ae, Offset: 0x5c76
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
                debugstar( var_7c4a5b9ed05b577f, ( 0, 1, 0 ), 30, "<dev string:x221>", 1 );
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

// Namespace ob_flying_drone
// Params 1, eflags: 0x4
// Checksum 0xcce74785, Offset: 0x5dac
// Size: 0x7b
function private explosive_drone_explosion( drone )
{
    minimaldamage = drone.options.var_ae7ccfca8ea91285 ?? 20;
    var_14abad88d1088fa2 = drone.options.var_acea9f0acc0e62c3 ?? 50;
    drone radiusdamage( drone.origin, 50, var_14abad88d1088fa2, minimaldamage, drone );
    drone notify( #"death" );
}

// Namespace ob_flying_drone
// Params 2
// Checksum 0x978dffa7, Offset: 0x5e2f
// Size: 0x243
function function_6395a1838cd983f5( drone, var_cdffe119ed60d14d )
{
    drone endon( #"main_drone_destroyed" );
    drone endon( #"drone_cleaned_up" );
    
    if ( !drone || drone.health <= 0 )
    {
        return;
    }
    
    type = "shock";
    
    while ( true )
    {
        if ( drone.emp_enabled )
        {
            waitframe();
            continue;
        }
        
        if ( drone.targetplayer && distancesquared( drone.targetplayer.origin, drone.origin ) < squared( drone.var_82cedb79f1d56e1 ) )
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
                droneoptions.hackable = drone.hackable;
                
                while ( !isdefined( spawn_path_array ) && trycount < 3 )
                {
                    spawn_path_array = get_helper_drone_spawn_pos( drone.targetplayer.origin );
                    trycount++;
                }
                
                if ( isdefined( spawn_path_array ) && !drone.emp_enabled )
                {
                    thread spawn_helper_drone( type, drone.targetplayer, spawn_path_array, undefined, droneoptions );
                }
            }
            
            wait spawn_timer;
        }
        
        waitframe();
    }
}

// Namespace ob_flying_drone
// Params 2, eflags: 0x4
// Checksum 0x34adc4b4, Offset: 0x607a
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

// Namespace ob_flying_drone
// Params 1
// Checksum 0x87215a43, Offset: 0x610d
// Size: 0xcd
function get_helper_drone_spawn_pos( centerpos )
{
    locations = [];
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
    
    if ( trace::sphere_trace_passed( spawn_location, target_location, 45, undefined, contentsoverride ) )
    {
        return locations;
    }
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0xbaf45d28, Offset: 0x61e3
// Size: 0x9a
function private select_random_drone_type()
{
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

// Namespace ob_flying_drone
// Params 1
// Checksum 0xef15b312, Offset: 0x6286
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
    
    assertmsg( "<dev string:x231>" );
}

// Namespace ob_flying_drone
// Params 1
// Checksum 0x6d9f0799, Offset: 0x62e9
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
    
    assertmsg( "<dev string:x231>" );
}

// Namespace ob_flying_drone
// Params 0, eflags: 0x4
// Checksum 0x35f4512a, Offset: 0x634c
// Size: 0x45
function private function_76b76816d532b680()
{
    ammo_item = %"itemspawnentry:ob_sat_item_ammo";
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
    common_item::function_61c2c0251e742ffd( ammo_item, undefined, spawnoptions );
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0xd8af747, Offset: 0x6399
// Size: 0x36
function clean_up_drone()
{
    self notify( #"drone_cleaned_up" );
    self.activity_instance thread entity_cleanup( self );
    level.huntdrones = arrayremove( level.huntdrones, self );
}

// Namespace ob_flying_drone
// Params 1
// Checksum 0xaeb59376, Offset: 0x63d7
// Size: 0x21
function entity_cleanup( maindrone )
{
    function_a08f109bc062fffe();
    
    if ( maindrone )
    {
        maindrone function_25c91463a5c7d654();
    }
}

// Namespace ob_flying_drone
// Params 0, eflags: 0xc
// Checksum 0xf8d17ec3, Offset: 0x6400
// Size: 0xa4
function private function_25c91463a5c7d654()
{
    self notify( #"hash_872025021fe27f7" );
    self endon( #"hash_872025021fe27f7" );
    
    if ( !self )
    {
        return;
    }
    
    if ( isdefined( level.ob.drones ) && arraycontains( level.ob.drones, self ) )
    {
        level.ob.drones = arrayremove( level.ob.drones, self );
    }
    
    if ( self.activity_instance )
    {
        self.activity_instance.drone = undefined;
    }
    
    self delete();
}

// Namespace ob_flying_drone
// Params 0
// Checksum 0xf8bdd06e, Offset: 0x64ac
// Size: 0x97
function function_a08f109bc062fffe()
{
    self notify( #"hash_b7a5cc1e7cc9f093" );
    self endon( #"hash_b7a5cc1e7cc9f093" );
    
    foreach ( drone in self.helper_drones )
    {
        drone notify( #"death" );
    }
}

/#

    // Namespace ob_flying_drone
    // Params 0
    // Checksum 0xca7d2233, Offset: 0x654b
    // Size: 0x2b2, Type: dev
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
                str = "<dev string:x269>";
                
                switch ( drone.goal )
                {
                    case #"hash_6573e43fb6b70d11":
                        str += "<dev string:x26f>";
                        break;
                    case #"follow":
                        str += "<dev string:x276>";
                        break;
                }
                
                if ( drone.var_2d79ae35ed58827b )
                {
                    str += "<dev string:x27d>";
                }
                
                debugstar( drone.origin, ( 1, 1, 0 ), 1, str, 0.7 );
                memory = drone.memory;
                
                if ( memory.vis_stack.size > 0 )
                {
                    for ( i = 0; i < memory.vis_stack.size ; i++ )
                    {
                        sphere( memory.vis_stack[ i ], 50, ( 1, 1, 0 ), 0 );
                        debugstar( memory.vis_stack[ i ], ( 1, 1, 0 ), 1, "<dev string:x286>" + i, 0.7 );
                        
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
                        debugstar( memory.bad_pos[ i ], ( 1, 0, 0 ), 1, "<dev string:x28f>" + i, 0.7 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_flying_drone
    // Params 3, eflags: 0x4
    // Checksum 0xaa4014b7, Offset: 0x6805
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

    // Namespace ob_flying_drone
    // Params 0, eflags: 0x4
    // Checksum 0xefe8d0dc, Offset: 0x68d3
    // Size: 0x17c, Type: dev
    function private function_76bc89c08728368f()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            dronetype = getdvar( @"hash_529e071d05d4d0bf", "<dev string:x299>" );
            
            if ( dronetype != "<dev string:x299>" )
            {
                setdvar( @"hash_529e071d05d4d0bf", "<dev string:x299>" );
                var_4a2ecdf7c2ab2198 = level.var_ca8bc9130358e5fb[ dronetype ];
                
                if ( !isdefined( var_4a2ecdf7c2ab2198 ) )
                {
                    assertmsg( "<dev string:x18b>" + dronetype + "<dev string:x197>" );
                    continue;
                }
                
                pos = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 200;
                var_83af36daad2905ff = spawn( "<dev string:x29a>", pos + ( 0, 0, 100 ) );
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

    // Namespace ob_flying_drone
    // Params 1, eflags: 0x4
    // Checksum 0xbb025409, Offset: 0x6a57
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
