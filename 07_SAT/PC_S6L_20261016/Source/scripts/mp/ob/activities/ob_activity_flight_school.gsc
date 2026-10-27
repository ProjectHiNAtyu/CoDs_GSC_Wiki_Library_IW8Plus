// scripts\mp\ob\activities\ob_activity_flight_school.gsc  (hash_1396905b844df2eb.gscc) (size: 8556 Bytes / 0x216c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b142248 (722739784)
// size ...... 8556 (0x216c)
// includes .. 15  (offset: 0x1f8c)
// strings ... 21  (offset: 0x2004)
// dev strs .. 4   (offset: 0x213c)
// exports ... 24  (offset: 0x12d4)
// cseg ...... 0x225 + 0x10af (0x12d4)
// imports ... 77  (offset: 0x1694)
// animtree1 . 0   (offset: 0x216c)
// animtree2 . 0   (offset: 0x216c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_prop_hunt;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\overlord;

#namespace ob_activity_flight_school;

// Namespace ob_activity_flight_school
// Params 0, eflags: 0x5
// Checksum 0x5607525, Offset: 0x243
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_flight_school", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_flight_school
// Params 0, eflags: 0x4
// Checksum 0x828b5ab5, Offset: 0x26c
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_FLIGHT_SCHOOL", &flight_school_init );
}

// Namespace ob_activity_flight_school
// Params 0
// Checksum 0xbdf14bc4, Offset: 0x287
// Size: 0x8a
function flight_school_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_FLIGHT_SCHOOL", 0, &flight_school_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_FLIGHT_SCHOOL", 1, &flight_school_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_FLIGHT_SCHOOL", 2, &flight_school_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_FLIGHT_SCHOOL", 3, &flight_school_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_cad72c963168f5e4, "REV_OB_FLIGHT_SCHOOL" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_155ba947c92c810b, "REV_OB_FLIGHT_SCHOOL" );
    scriptable::scriptable_addusedcallbackbypart( "sat_ob_flight_school_portal", &function_154c71bd0a2ec74b );
}

// Namespace ob_activity_flight_school
// Params 0
// Checksum 0x80d1a7a9, Offset: 0x319
// Size: 0xb0
function flight_school_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_center = activity_instance_common::function_776ee11e7acc64a5( self );
    activity_instance.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance.handler_list = [ "karm", "mars" ];
    activity_instance thread function_8dbbb91a9d25fbb3();
    level._effect[ "vfx_sat_ob_gameplay_wc_teleport_screen" ] = loadfxasset( "vfx_sat_ob_gameplay_wc_teleport_screen" );
    level._effect[ "vfx_sat_ob_gameplay_wc_butterflies_caught_screen" ] = loadfxasset( "vfx_sat_ob_gameplay_wc_butterflies_caught_screen" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace ob_activity_flight_school
// Params 0
// Checksum 0xe1275aed, Offset: 0x3d1
// Size: 0xc6
function flight_school_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    /#
        activity_instance thread debug_draw();
    #/
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x24>" );
    #/
    
    self.portal = spawnscriptable( "sat_ob_flight_school_portal", self.var_599a45c993e5624e.origin, self.var_599a45c993e5624e.angles );
    self.portal setscriptablepartstate( #"sat_ob_flight_school_portal", #"usable" );
    self.portal interaction::set_interact_hint_callback( &portal_hint_callback );
    self.portal.activity_instance = self;
}

// Namespace ob_activity_flight_school
// Params 1
// Checksum 0x6f580ac6, Offset: 0x49f
// Size: 0x50
function flight_school_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_cleanup();
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x35>" + ( istrue( activity_succeeded ) ? "<dev string:x3f>" : "<dev string:x49>" ) );
    #/
}

// Namespace ob_activity_flight_school
// Params 0
// Checksum 0xb28e839c, Offset: 0x4f7
// Size: 0x23
function flight_school_destroy()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_cleanup();
}

// Namespace ob_activity_flight_school
// Params 0, eflags: 0x4
// Checksum 0x6be0813c, Offset: 0x522
// Size: 0x36
function private activity_cleanup()
{
    if ( self.portal )
    {
        self.portal freescriptable();
    }
    
    if ( self.butterfly )
    {
        self.butterfly freescriptable();
    }
}

// Namespace ob_activity_flight_school
// Params 1
// Checksum 0x11a8a26b, Offset: 0x560
// Size: 0x68
function function_cad72c963168f5e4( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    rewardamount = namespace_4a69edc3725e741::function_e55fda458ce2c4cc( self );
    activity_definition_utils::updatereward( rewardamount, self, { #players:player_list } );
    thread play_vo_brief( player_list );
}

// Namespace ob_activity_flight_school
// Params 1
// Checksum 0x9369b690, Offset: 0x5d0
// Size: 0x23
function function_155ba947c92c810b( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_flight_school
// Params 0
// Checksum 0x8af65914, Offset: 0x5fb
// Size: 0x256
function function_8dbbb91a9d25fbb3()
{
    self.var_599a45c993e5624e = utility::getstruct( self.varianttag + "_PORTAL", "target" );
    self.s_structs = utility::getstructarray( self.var_599a45c993e5624e.target, "targetname" );
    
    foreach ( struct in self.s_structs )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_82a752059c345694":
                self.teleport = struct;
                break;
            case #"hash_6797aa62e617d8e7":
                self.path_start = struct;
                break;
        }
    }
    
    self.var_9b6da1c3a3dea320 = [];
    self.var_7d4e3d37c2eb923a = [];
    self.var_9b6da1c3a3dea320[ self.var_9b6da1c3a3dea320.size ] = self.path_start;
    self.var_7d4e3d37c2eb923a[ self.var_7d4e3d37c2eb923a.size ] = self.path_start.origin;
    currnode = self.path_start;
    
    while ( currnode.target )
    {
        nextnode = utility::getstruct( currnode.target, "targetname" );
        
        if ( isdefined( nextnode ) )
        {
            self.var_9b6da1c3a3dea320[ self.var_9b6da1c3a3dea320.size ] = nextnode;
            self.var_7d4e3d37c2eb923a[ self.var_7d4e3d37c2eb923a.size ] = nextnode.origin;
            currnode = nextnode;
            nextnode = undefined;
            continue;
        }
        
        self.path_end = currnode;
        break;
    }
    
    self.pathdistance_sq = 0;
    
    for ( i = 0; i < self.var_7d4e3d37c2eb923a.size - 1 ; i++ )
    {
        self.pathdistance_sq += distancesquared( self.var_7d4e3d37c2eb923a[ i ], self.var_7d4e3d37c2eb923a[ i + 1 ] );
    }
}

// Namespace ob_activity_flight_school
// Params 6
// Checksum 0xa51e2606, Offset: 0x859
// Size: 0x1ab
function function_154c71bd0a2ec74b( instance, part, state, player, bautouse, usestring )
{
    if ( !function_7e5ba29e60957a72( player ) )
    {
        return;
    }
    
    activity_instance = instance.activity_instance;
    
    /#
        if ( getdvarint( @"hash_fd00fd074f57d58a", 0 ) != 0 )
        {
            activity_instance.butterfly_speed = getdvarint( @"hash_fd00fd074f57d58a", 0 );
        }
    #/
    
    if ( !isdefined( activity_instance.butterfly_speed ) )
    {
        activity_instance.butterfly_speed = activity_instance.var_9b6da1c3a3dea320[ 0 ].speed ?? 435;
    }
    
    activity_instance.pathtime = sqrt( activity_instance.pathdistance_sq ) / activity_instance.butterfly_speed;
    activity_participation::function_bc67362dace4370c( activity_instance, player );
    activity_instance.portal setscriptablepartstate( #"sat_ob_flight_school_portal", #"inactive" );
    player setorigin( activity_instance.teleport.origin );
    fx = playfxontagforclients( level._effect[ "vfx_sat_ob_gameplay_wc_teleport_screen" ], player, "tag_origin", player );
    player setplayerangles( activity_instance.teleport.angles, 0 );
    player skydive_beginfreefall();
    player setvelocity( ( 40, 0, 0 ) );
    player skydive_deployparachute();
    player thread function_c4e9314f7cfcfee0( activity_instance );
    activity_instance thread _start_butterfly();
}

// Namespace ob_activity_flight_school
// Params 1
// Checksum 0x98fe9ef2, Offset: 0xa0c
// Size: 0x241
function function_c4e9314f7cfcfee0( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"fail_cleanup" );
    self endon( #"death" );
    activity_instance waittill( #"butterfly_spawned" );
    activity_instance.success = -1;
    activity_instance.proxvo = 0;
    sq_goaldist = squared( 768 );
    var_bfc130dcbef6b4c7 = squared( 3072 );
    
    /#
        if ( getdvarint( @"scr_debug_flight_school", 0 ) )
        {
            activity_instance thread function_17c95881a3b44b90( activity_instance.butterfly );
        }
    #/
    
    wait 0.5;
    
    while ( true )
    {
        sq_dist = distancesquared( self.origin, activity_instance.butterfly.origin );
        
        if ( self isonground() || self isswimming() || self isswimunderwater() || self function_fbf06f80548d841d() || sq_dist > squared( 6500 ) )
        {
            activity_instance.success = 0;
            activity_instance.butterfly setscriptablepartstate( #"base", #"caught" );
            break;
        }
        else if ( sq_dist <= sq_goaldist && activity_instance.success != 1 )
        {
            activity_instance.success = 1;
            activity_instance.butterfly setscriptablepartstate( #"base", #"caught" );
            fx = playfxontagforclients( level._effect[ "vfx_sat_ob_gameplay_wc_butterflies_caught_screen" ], self, "tag_origin", self );
            break;
        }
        else if ( sq_dist > sq_goaldist && sq_dist < var_bfc130dcbef6b4c7 && activity_instance.success == -1 && !activity_instance.proxvo )
        {
            activity_instance.proxvo = 1;
            namespace_e81a4357e5094976::function_639b0047db8aec67( activity_instance, "flight_school_close" );
        }
        
        waitframe();
    }
    
    if ( activity_instance.success )
    {
        activity_instance function_307596c9cbf00814( self );
    }
    
    activity_instance _end_activity( activity_instance.success );
}

// Namespace ob_activity_flight_school
// Params 1, eflags: 0x4
// Checksum 0xa1876727, Offset: 0xc55
// Size: 0x16a
function private function_307596c9cbf00814( player )
{
    activity_difficulty = region_difficulty_manager::get_region_difficulty( self.teleport.origin );
    prophunts = [];
    var_16418eb0f6cb2d6a = [];
    
    foreach ( instance in level.activities.instances )
    {
        if ( activity_instance_common::getactivitytype( instance ) == "REV_OB_PROP_HUNT" && activity_instance_common::getactivitystate( instance ) == "Active" )
        {
            prophunts[ prophunts.size ] = instance;
            prophunt_center = activity_instance_common::function_776ee11e7acc64a5( instance );
            
            if ( activity_difficulty == region_difficulty_manager::get_region_difficulty( prophunt_center ) )
            {
                var_16418eb0f6cb2d6a[ var_16418eb0f6cb2d6a.size ] = instance;
            }
        }
    }
    
    if ( prophunts.size > 0 )
    {
        if ( isdefined( player.var_7ede550baeb15767 ) )
        {
            player.var_7ede550baeb15767 delete();
        }
        
        if ( var_16418eb0f6cb2d6a.size > 0 )
        {
            prophunt_instance = var_16418eb0f6cb2d6a[ randomint( var_16418eb0f6cb2d6a.size ) ];
        }
        else
        {
            prophunt_instance = prophunts[ randomint( prophunts.size ) ];
        }
        
        prophunt_instance ob_activity_prop_hunt::function_292e55702b780de7( player );
    }
}

// Namespace ob_activity_flight_school
// Params 0
// Checksum 0xbf069249, Offset: 0xdc7
// Size: 0x10d
function _start_butterfly()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"fail_cleanup" );
    self.butterfly = spawnscriptable( "sat_ob_flight_school_butterfly", self.var_7d4e3d37c2eb923a[ 0 ] );
    self.butterfly setscriptablepartstate( #"base", #"active" );
    
    if ( !isdefined( self.end_wait ) )
    {
        self.end_wait = self.path_end.wait_time ?? 1;
    }
    
    self notify( #"butterfly_spawned" );
    self.butterfly utility::function_2159dd4196ff4b81( self.var_7d4e3d37c2eb923a, self.pathtime, 1, 0, 1, 0.5, 0.75, getdvarint( @"scr_debug_flight_school", 0 ) );
    wait self.end_wait;
    self.butterfly setscriptablepartstate( #"base", #"caught" );
    _end_activity( 0 );
}

// Namespace ob_activity_flight_school
// Params 1
// Checksum 0xc0d34cd4, Offset: 0xedc
// Size: 0xed
function _end_activity( success )
{
    thread play_vo_end( success );
    
    if ( success )
    {
        activity_instance_common::endactivity( self, success );
        return;
    }
    
    self.portal setscriptablepartstate( #"sat_ob_flight_school_portal", #"usable" );
    self.butterfly setscriptablepartstate( #"base", #"caught" );
    
    foreach ( player in self.playerparticipants )
    {
        activity_participation::function_61aa2b2879f2c0a2( self, player );
    }
    
    self notify( #"fail_cleanup" );
}

// Namespace ob_activity_flight_school
// Params 1, eflags: 0x4
// Checksum 0x4204726b, Offset: 0xfd1
// Size: 0xac
function private play_vo_brief( player_list )
{
    namespace_e81a4357e5094976::function_639b0047db8aec67( self, "flight_school_brief", player_list );
    wait 0.5;
    overlord::function_29d8b7aaf2aa133a( player_list );
    
    foreach ( player in player_list )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( "flight_school_brief" + "_hero", [ player ] );
    }
}

// Namespace ob_activity_flight_school
// Params 1, eflags: 0x4
// Checksum 0x315420f0, Offset: 0x1085
// Size: 0x61
function private play_vo_end( success )
{
    player_list = self.playerparticipants;
    
    if ( overlord::function_dce0a14273dfa0a8( player_list ) )
    {
        overlord::function_29d8b7aaf2aa133a( player_list );
        wait 0.25;
    }
    
    if ( success )
    {
        namespace_e81a4357e5094976::function_639b0047db8aec67( self, "flight_school_success", player_list );
        return;
    }
    
    namespace_e81a4357e5094976::function_639b0047db8aec67( self, "flight_school_fail", player_list );
}

// Namespace ob_activity_flight_school
// Params 1, eflags: 0x4
// Checksum 0x56882ffd, Offset: 0x10ee
// Size: 0x23, Type: bool
function private function_7e5ba29e60957a72( player )
{
    if ( player isskydiving() || player function_41360f0bcfc012aa() )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_flight_school
// Params 2, eflags: 0x4
// Checksum 0x90ed4eb4, Offset: 0x111a
// Size: 0x63
function private portal_hint_callback( usable, player )
{
    if ( function_7e5ba29e60957a72( player ) )
    {
        return { #string:&"hash_3796af1259df1709", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

/#

    // Namespace ob_activity_flight_school
    // Params 0, eflags: 0x4
    // Checksum 0xa17ad5d8, Offset: 0x1186
    // Size: 0x2b, Type: dev
    function private debug_draw()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_flight_school", 0 ) )
            {
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_flight_school
    // Params 1, eflags: 0x4
    // Checksum 0x3ff20b97, Offset: 0x11b9
    // Size: 0x53, Type: dev
    function private function_8eeb50e8ea4082ae( text )
    {
        if ( !getdvarint( @"scr_debug_flight_school", 0 ) )
        {
            return;
        }
        
        print3d( activity_instance_common::function_776ee11e7acc64a5( self ) + ( 0, 0, 150 ), text, ( 1, 0, 0 ), 1, 1, 100, 1 );
    }

    // Namespace ob_activity_flight_school
    // Params 1
    // Checksum 0xf6ff2b6a, Offset: 0x1214
    // Size: 0xc0, Type: dev
    function function_17c95881a3b44b90( butterfly )
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        self endon( #"fail_cleanup" );
        butterfly endon( #"death" );
        radius = 768;
        vo = 1536;
        
        while ( self.success == -1 )
        {
            debug::drawsphere( butterfly.origin, radius, 0.05, ( 1, 0, 0 ) );
            debug::drawsphere( butterfly.origin, vo, 0.05, ( 1, 1, 0 ) );
            wait 0.05;
        }
    }

#/
