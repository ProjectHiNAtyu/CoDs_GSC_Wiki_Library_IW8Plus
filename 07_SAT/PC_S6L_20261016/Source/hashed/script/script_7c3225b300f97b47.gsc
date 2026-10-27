// script_7c3225b300f97b47  (hash_7c3225b300f97b47.gscc) (size: 9405 Bytes / 0x24bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8fba1071 (2411335793)
// size ...... 9405 (0x24bd)
// includes .. 14  (offset: 0x22b5)
// strings ... 23  (offset: 0x2325)
// dev strs .. 1   (offset: 0x24ad)
// exports ... 30  (offset: 0x1475)
// cseg ...... 0x1ef + 0x1286 (0x1475)
// imports ... 83  (offset: 0x1925)
// animtree1 . 0   (offset: 0x24bd)
// animtree2 . 0   (offset: 0x24bd)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_common_kiosk;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_timedrun_quest;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\objidpoolmanager;

#namespace namespace_feb0cf2daf7e4f97;

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x5
// Checksum 0xe19a10b2, Offset: 0x20d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e943b722ec29fa58", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x1838a359, Offset: 0x236
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_TIMEDRUN", &timedrun_activity_type_init );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0
// Checksum 0x825a92ca, Offset: 0x251
// Size: 0x110
function timedrun_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_TIMEDRUN", 0, &timedrun_activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_TIMEDRUN", 1, &timedrun_activity_begin );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_TIMEDRUN", 2, &timedrun_activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_TIMEDRUN", 3, &timedrun_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &timedrun_player_joined_activity, "BR_CONTRACT_TIMEDRUN" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_CONTRACT_TIMEDRUN" );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &timedrun_timer_expired, "BR_CONTRACT_TIMEDRUN" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &timedrun_player_killed, "BR_CONTRACT_TIMEDRUN" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &function_816d78babcafb5d9, "BR_CONTRACT_TIMEDRUN" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &timedrun_player_respawn, "BR_CONTRACT_TIMEDRUN" );
    activity_common::function_2dd4f07fa5c3e911( "BRCircleTick", &function_5349093e7f95bc29, "BR_CONTRACT_TIMEDRUN" );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    level._effect[ "vfx_marker_base_orange_pulse" ] = loadfxasset( "vfx_iw8_br_gameplay_tr_marker" );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0
// Checksum 0x359b16c4, Offset: 0x369
// Size: 0x4b
function timedrun_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 2
// Checksum 0xb148378d, Offset: 0x3bc
// Size: 0xc8
function function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "mission_timedrun_" + variantname + "_accept" ] ) )
    {
        game[ "dialog" ][ "mission_timedrun_" + variantname + "_accept" ] = data.acceptvo;
        game[ "dialog" ][ "mission_timedrun_" + variantname + "_success" ] = data.successvo;
        game[ "dialog" ][ "mission_timedrun_" + variantname + "_fail_time" ] = data.var_f3d9be6b6ae42780;
        game[ "dialog" ][ "mission_timedrun_" + variantname + "_fail_circle" ] = data.var_7996b2d5b768cfd1;
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0
// Checksum 0x51515f7b, Offset: 0x48c
// Size: 0xe6
function timedrun_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !function_8ea86d47e4c2bab8() )
    {
        self.endstate = "NoTargetError";
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    br_activity_util::function_3fbbc67df36be7bb( self.var_332f929de1894b2b.contracttime );
    level thread br_public::brleaderdialogteam( "mission_timedrun_" + self.varianttag + "_accept", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_11c52046ee17c775, undefined, 1 );
    params = spawnstruct();
    
    if ( isdefined( self.var_f92f09f90f2d2d99 ) )
    {
        params.distance = distance2d( self.var_441d26d05f86b224, self.var_f92f09f90f2d2d99 );
    }
    
    br_activity_util::startcontract( params );
    timedrun_sequence();
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1
// Checksum 0x3e6ebe8b, Offset: 0x57a
// Size: 0x3b
function timedrun_activity_ended( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    timerun_ended( succeeded );
    timedrun_cleanup();
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0
// Checksum 0xe1184e44, Offset: 0x5bd
// Size: 0x15
function timedrun_activity_destroy()
{
    self endon( #"instance_destroyed" );
    timedrun_clear_objective();
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1
// Checksum 0xf5834f16, Offset: 0x5da
// Size: 0x38
function timedrun_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0xde5952a1, Offset: 0x61a
// Size: 0x1c
function private function_8ea86d47e4c2bab8()
{
    self.origin = self.var_1103806baee402d5;
    return function_6f377b2839c7d7b6( 1 );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0xed780630, Offset: 0x63f
// Size: 0x17
function private timedrun_sequence()
{
    thread function_ab4aa5399e0c313e();
    function_2cebad3129de4ff8();
    timedrun_finish();
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0x9ef0f29e, Offset: 0x65e
// Size: 0x15e, Type: bool
function private function_b5b84366c48382f7( target )
{
    if ( !isdefined( target ) )
    {
        if ( isdefined( self.var_f92f09f90f2d2d99 ) )
        {
            timedrun_clear_objective();
        }
        
        self.var_60de57e0dd65d20a = undefined;
        self.var_f92f09f90f2d2d99 = undefined;
        self.var_39251d60a63fc227 = undefined;
        self.var_d10d820d66d107b9 = undefined;
        self.var_caf7fc719888db86 = undefined;
        self.kiosk = undefined;
        return false;
    }
    
    targetid = target.targetid;
    targetorigin = target.origin;
    targetangles = target.angles ?? ( 0, 0, 0 );
    var_105588ce51ab93a1 = target.followentity;
    targetpending = target.var_9aaebddcbd952541;
    targetkiosk = target.kiosk;
    
    if ( targetpending && isdefined( targetid ) && self.var_60de57e0dd65d20a != targetid )
    {
        br_deployable_kiosk::function_723054718bc154a5( targetid );
    }
    
    self.var_60de57e0dd65d20a = targetid;
    self.var_f92f09f90f2d2d99 = targetorigin;
    self.var_39251d60a63fc227 = targetangles;
    self.var_d10d820d66d107b9 = var_105588ce51ab93a1;
    self.var_caf7fc719888db86 = targetpending;
    self.kiosk = targetkiosk;
    return true;
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 2, eflags: 0x4
// Checksum 0xf31deeea, Offset: 0x7c5
// Size: 0x121, Type: bool
function private function_6f377b2839c7d7b6( var_15b6ccbc6b90dfb8 = 0, var_4084e963af9ed72e = 1 )
{
    target = undefined;
    
    if ( isdefined( self.var_60de57e0dd65d20a ) )
    {
        target = br_timedrun_quest::function_8a755cb0912dd0e4( self.var_60de57e0dd65d20a );
        
        if ( isdefined( target ) && !target.var_9aaebddcbd952541 && !br_timedrun_quest::function_c1ae0bcd765767f1( target.kiosk ) )
        {
            target = undefined;
        }
    }
    else if ( br_timedrun_quest::function_c1ae0bcd765767f1( self.kiosk ) )
    {
        target = { #kiosk:self.kiosk, #var_9aaebddcbd952541:0, #angles:self.kiosk.angles, #origin:self.kiosk.origin };
    }
    else if ( var_15b6ccbc6b90dfb8 )
    {
        self.origin = self.var_1103806baee402d5;
        target = br_timedrun_quest::function_20ecef5ae3a6c07b( self.var_332f929de1894b2b, var_4084e963af9ed72e );
    }
    
    return function_b5b84366c48382f7( target );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x4c994150, Offset: 0x8ef
// Size: 0x2d, Type: bool
function private function_9d9a24c5a045ba46()
{
    return isdefined( self.var_f92f09f90f2d2d99 ) && !self.var_caf7fc719888db86 && br_timedrun_quest::function_c1ae0bcd765767f1( self.kiosk );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x65947ec0, Offset: 0x925
// Size: 0x83
function private function_b0c7b89b833e9b9c()
{
    if ( self.var_caf7fc719888db86 )
    {
        if ( !isdefined( self.var_f92f09f90f2d2d99 ) )
        {
            return self.curorigin;
        }
        
        return self.var_f92f09f90f2d2d99;
    }
    
    if ( !isdefined( self.var_f92f09f90f2d2d99 ) )
    {
        return;
    }
    
    forwardvector = ( 0, 0, 0 );
    
    if ( !self.var_caf7fc719888db86 )
    {
        forwardvector = anglestoforward( self.var_39251d60a63fc227 );
    }
    
    return self.var_f92f09f90f2d2d99 + forwardvector * 12;
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0xb063a114, Offset: 0x9b1
// Size: 0x32
function private function_2246249835a91c33()
{
    if ( !self.var_caf7fc719888db86 )
    {
        return;
    }
    
    if ( !isdefined( self.var_d10d820d66d107b9.origin ) )
    {
        return;
    }
    
    return self.var_d10d820d66d107b9;
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x26ce005d, Offset: 0x9ec
// Size: 0x4a
function private function_ab4aa5399e0c313e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        function_6f377b2839c7d7b6();
        
        if ( isdefined( self.var_f92f09f90f2d2d99 ) )
        {
            timedrun_create_objective();
        }
        
        waitframe();
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0x94e3af5d, Offset: 0xa3e
// Size: 0x91
function private timedrun_clear_objective( clearvfx = 1 )
{
    if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
    {
        br_contract_manager::deletequestobjicon();
    }
    
    self.objectiveiconid = undefined;
    self.var_b4e138523d13478e = undefined;
    
    if ( clearvfx && isdefined( self.finishlinevfx ) )
    {
        self.finishlinevfx delete();
        self.finishlinevfx = undefined;
    }
    
    if ( clearvfx )
    {
        self.finishlinevfxkiosk = undefined;
    }
    
    self.curorigin = undefined;
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x2d7b4034, Offset: 0xad7
// Size: 0x29b
function private timedrun_create_objective()
{
    self.curorigin = function_b0c7b89b833e9b9c();
    
    if ( !isdefined( self.curorigin ) )
    {
        return;
    }
    
    var_bc3098e0bcc7ac67 = function_2246249835a91c33();
    
    if ( self.var_caf7fc719888db86 && !isdefined( var_bc3098e0bcc7ac67 ) )
    {
        timedrun_clear_objective( 0 );
        return;
    }
    
    objectiveorigin = self.curorigin + ( 0, 0, 65 );
    
    if ( isdefined( var_bc3098e0bcc7ac67 ) )
    {
        objectiveorigin = var_bc3098e0bcc7ac67.origin;
    }
    else if ( isdefined( self.var_b4e138523d13478e ) )
    {
        timedrun_clear_objective( 0 );
    }
    
    if ( !isdefined( self.objectiveiconid ) || self.objectiveiconid == -1 )
    {
        br_contract_manager::createquestobjicon( "ui_map_icon_obj_supplyrun", "current", objectiveorigin, self );
        self.var_b4e138523d13478e = undefined;
        
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objective_removeallfrommask( self.objectiveiconid );
            br_contract_manager::function_b6def068f44f04c9( self.objectiveiconid, self.team );
            objective_setshowdistance( self.objectiveiconid, 1 );
            objective_setshowoncompass( self.objectiveiconid, 1 );
            function_2b8e3d3ae2a6414a( self.objectiveiconid, 0 );
            function_44a344c68a68f28d( self.objectiveiconid, 0 );
            function_461834c350793158( self.objectiveiconid, 1 );
            function_5a1f9b4d7de0b23b( self.objectiveiconid, 1 );
            objective_sethideelevation( self.objectiveiconid, 1 );
            
            if ( var_bc3098e0bcc7ac67 )
            {
                self.var_b4e138523d13478e = var_bc3098e0bcc7ac67;
                objective_setzoffset( self.objectiveiconid, 65 );
            }
            else
            {
                self.var_b4e138523d13478e = undefined;
                br_contract_manager::movequestobjicon( objectiveorigin );
                objective_setzoffset( self.objectiveiconid, 0 );
            }
        }
    }
    
    if ( !isdefined( self.objectiveiconid ) || self.objectiveiconid == -1 )
    {
        return;
    }
    
    if ( self.var_caf7fc719888db86 )
    {
        if ( isdefined( self.finishlinevfx ) )
        {
            self.finishlinevfx delete();
            self.finishlinevfx = undefined;
        }
        
        objective_position( self.objectiveiconid, objectiveorigin );
        self.finishlinevfxkiosk = undefined;
        return;
    }
    
    if ( self.finishlinevfxkiosk != self.kiosk )
    {
        if ( isdefined( self.finishlinevfx ) )
        {
            self.finishlinevfx delete();
            self.finishlinevfx = undefined;
        }
        
        self.finishlinevfxkiosk = self.kiosk;
    }
    
    if ( !isdefined( self.finishlinevfx ) )
    {
        function_7a2ea8cf2577cf59();
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x3e1152d1, Offset: 0xd7a
// Size: 0xff
function private function_7a2ea8cf2577cf59()
{
    if ( !isdefined( self.curorigin ) )
    {
        return;
    }
    
    finishlinevfx = spawnfx( level._effect[ "vfx_marker_base_orange_pulse" ], self.curorigin + ( 0, 0, 10 ) );
    finishlinevfx.angles = vectortoangles( ( 0, 0, 1 ) );
    finishlinevfx hide();
    triggerfx( finishlinevfx );
    players = self.playerparticipants;
    
    foreach ( player in players )
    {
        finishlinevfx showtoplayer( player );
    }
    
    self.finishlinevfx = finishlinevfx;
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0xbc2b676f, Offset: 0xe81
// Size: 0x109
function private function_2cebad3129de4ff8()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    radiussq = self.var_332f929de1894b2b.captureradius * self.var_332f929de1894b2b.captureradius;
    
    while ( true )
    {
        if ( !function_9d9a24c5a045ba46() )
        {
            waitframe();
            continue;
        }
        
        players = self.playerparticipants;
        
        foreach ( player in players )
        {
            if ( distancesquared( player.origin, self.var_f92f09f90f2d2d99 ) < radiussq )
            {
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0x34a76768, Offset: 0xf92
// Size: 0x5b
function private timedrun_finish()
{
    level thread br_public::brleaderdialogteam( "mission_timedrun_" + self.varianttag + "_success", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_61dfddd29578c7ba, undefined, 1 );
    self.endstate = "Win";
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0x2d8a9f2c, Offset: 0xff5
// Size: 0x64
function private timedrun_timer_expired( relevant_info_struct )
{
    level thread br_public::brleaderdialogteam( "mission_timedrun_" + self.varianttag + "_fail_time", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_ed34f1483a8e251c, undefined, 1 );
    self.endstate = "Time";
    activity_instance_common::endactivity( self, 0 );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0xd1879aec, Offset: 0x1061
// Size: 0x43
function private timedrun_player_killed( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.victim ) )
    {
        if ( !br_activity_util::function_79f1eba39959ffed( self ) )
        {
            self.endstate = "Killed";
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0x7f2eb9ec, Offset: 0x10ac
// Size: 0x59
function private function_816d78babcafb5d9( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.player ) )
    {
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, params.player );
        }
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0x13fc5119, Offset: 0x110d
// Size: 0x59
function private timedrun_player_respawn( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.player ) )
    {
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, params.player );
        }
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0xef0e18ec, Offset: 0x116e
// Size: 0xa5
function private function_5349093e7f95bc29( params )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    if ( isdefined( self.var_f92f09f90f2d2d99 ) )
    {
        if ( !br_circle_util::ispointindangercircle( self.var_f92f09f90f2d2d99, level.var_ea96217a33eb6457 ) )
        {
            level thread br_public::brleaderdialogteam( "mission_timedrun_" + self.varianttag + "_fail_circle", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_bddea2f4a049fb25, undefined, 1 );
            self.var_b6c5eeeebd9383f5 = 1;
            self.endstate = "Circle";
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 1, eflags: 0x4
// Checksum 0x7e8a9dd2, Offset: 0x121b
// Size: 0x1c3
function private timerun_ended( succeeded )
{
    if ( succeeded )
    {
        if ( self.var_332f929de1894b2b.var_8f0553f03845fb80 )
        {
            var_e74988f46612c668 = self.playerparticipants;
            
            foreach ( player in var_e74988f46612c668 )
            {
                if ( !isdefined( player.timedrunkiosks ) )
                {
                    player.timedrunkiosks = [];
                }
                
                if ( player.timedrunkiosks.size > 0 )
                {
                    foreach ( kiosk in player.timedrunkiosks )
                    {
                        if ( common_kiosk::function_c892a782bb09e4b8( kiosk, player ) )
                        {
                            br_common_kiosk::kioskfiresaledoneforplayer( kiosk, player );
                        }
                    }
                    
                    player.timedrunkiosks = [];
                }
                
                player.timedrunkiosks[ player.timedrunkiosks.size ] = self.kiosk;
            }
        }
        
        rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.rewardgroup, self.kiosk );
    }
    
    br_activity_util::endcontract( succeeded, rewards, self.endstate );
}

// Namespace namespace_feb0cf2daf7e4f97
// Params 0, eflags: 0x4
// Checksum 0xd774e58c, Offset: 0x13e6
// Size: 0x8f
function private timedrun_cleanup()
{
    timedrun_clear_objective( 0 );
    
    if ( self.var_332f929de1894b2b.cleanupdelay > 0 && isdefined( self.finishlinevfx ) )
    {
        thread br_timedrun_quest::function_72fefa9e7d41c11f( self.var_332f929de1894b2b.cleanupdelay, self.finishlinevfx );
    }
    else if ( isdefined( self.finishlinevfx ) )
    {
        self.finishlinevfx delete();
    }
    
    self.finishlinevfx = undefined;
    self.finishlinevfxkiosk = undefined;
    self.curorigin = undefined;
}

