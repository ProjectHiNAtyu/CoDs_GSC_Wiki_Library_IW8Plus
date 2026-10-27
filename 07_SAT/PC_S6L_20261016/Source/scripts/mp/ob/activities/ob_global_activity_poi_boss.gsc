// scripts\mp\ob\activities\ob_global_activity_poi_boss.gsc  (hash_2582f22190db4b68.gscc) (size: 28716 Bytes / 0x702c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6e29137 (3605172535)
// size ...... 28716 (0x702c)
// includes .. 22  (offset: 0x6b74)
// strings ... 58  (offset: 0x6c24)
// dev strs .. 13  (offset: 0x6f80)
// exports ... 62  (offset: 0x4a9c)
// cseg ...... 0x538 + 0x4564 (0x4a9c)
// imports ... 182 (offset: 0x544c)
// animtree1 . 0   (offset: 0x702c)
// animtree2 . 0   (offset: 0x702c)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_global_activity_poi_boss;

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x5
// Checksum 0x3690910b, Offset: 0x556
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_global_activity_poi_boss", #"activity_common", &function_ae01289389644ad1, undefined );
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x4
// Checksum 0x74385447, Offset: 0x57f
// Size: 0x13
function private function_ae01289389644ad1()
{
    activity_common::registeractivitytype( "REV_OB_POI_BOSS", &activityinit );
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0xad5512ca, Offset: 0x59a
// Size: 0xd6
function activityinit()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_POI_BOSS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_POI_BOSS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_POI_BOSS", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_POI_BOSS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "REV_OB_POI_BOSS", 4, &function_a4d92da898877ff7 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_POI_BOSS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_POI_BOSS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &player_entered_awareness_zone, "REV_OB_POI_BOSS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_30cc03d1c63234b6, "REV_OB_POI_BOSS" );
    utility::registersharedfunc( #"zombie_phobos", #"hash_7c6ed9822fa04c81", &function_c776da50ac1a6683 );
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x4
// Checksum 0x81fc1c5d, Offset: 0x678
// Size: 0xdc
function private function_56c531401028d79a()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::ent_flag_wait( "in_phobos_leap" );
        
        if ( getdvarint( @"hash_ec43e87050217282", 1 ) )
        {
            thread function_349ed2fdf856e361();
        }
        
        /#
            if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
            {
                if ( self._blackboard.var_497e751941b50bed )
                {
                    sphere( self._blackboard.var_497e751941b50bed, 2, ( 1, 0, 1 ), 0, 300 );
                }
                
                sphere( self.origin, 2, ( 0, 0.5, 0.5 ), 0, 300 );
            }
        #/
        
        utility::ent_flag_waitopen_or_timeout( "in_phobos_leap", 10 );
        self.var_c3c26fd223625df0 = 0;
        childthread function_c6e9e5579176321b();
    }
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x4
// Checksum 0xe8d29128, Offset: 0x75c
// Size: 0x38
function private function_349ed2fdf856e361()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait getdvarfloat( @"hash_7c989361609e524b", 0.2 );
    self.var_c3c26fd223625df0 = 1;
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0xc
// Checksum 0x751b4a13, Offset: 0x79c
// Size: 0x238
function private function_c6e9e5579176321b()
{
    self notify( #"hash_152a10fbbd0bb1ab" );
    self endon( #"hash_152a10fbbd0bb1ab" );
    self endon( #"in_phobos_leap" );
    secondsduration = 0;
    var_cabfa898bbf55d6a = getdvarfloat( @"hash_b94469c2aff41023", 0.5 );
    var_44fc5698bbfcebd2 = getdvarfloat( @"hash_8396c7a077a22223", 8 );
    var_6c0f9495799d7de8 = getdvarint( @"hash_50d961bc0af2ede1", 100 );
    var_f520a021c6d440a5 = getdvarint( @"hash_42d55a2b8a0a670f", 30 );
    
    while ( secondsduration <= var_44fc5698bbfcebd2 )
    {
        var_7d7836ec3b55ab23 = self.origin + ( 0, 0, var_6c0f9495799d7de8 );
        groundpos = getgroundposition( var_7d7836ec3b55ab23, var_f520a021c6d440a5 );
        
        /#
            if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
            {
                sphere( self.origin, 1, ( 0, 0.5, 0.5 ), 0, 300 );
                sphere( groundpos, 1, ( 1, 1, 1 ), 0, 300 );
                sphere( var_7d7836ec3b55ab23, 1, ( 0, 0, 0 ), 0, 300 );
                cylinder( self.origin, groundpos, var_f520a021c6d440a5, ( 1, 1, 1 ), 0, 300 );
            }
        #/
        
        if ( self.origin[ 2 ] < groundpos[ 2 ] && abs( self.origin[ 2 ] - groundpos[ 2 ] ) > 0.1 )
        {
            teleportpos = getclosestpointonnavmesh( groundpos, self );
            
            if ( !teleportpos )
            {
                var_97858203822f35e7 = getdvarint( @"hash_fc57dbff717e1c2a", 20 );
                newz = groundpos[ 2 ] + var_97858203822f35e7;
                teleportpos = ( self.origin[ 0 ], self.origin[ 1 ], newz );
            }
            
            /#
                iprintlnbold( "<dev string:x24>" );
                
                if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
                {
                    sphere( teleportpos, 3, ( 1, 0, 0 ), 0, 300 );
                }
            #/
            
            self setorigin( teleportpos, 1 );
            return;
        }
        
        secondsduration += var_cabfa898bbf55d6a;
        wait var_cabfa898bbf55d6a;
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0xcfec2dd7, Offset: 0x9dc
// Size: 0x37, Type: bool
function function_c776da50ac1a6683( player )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( player && player iswingsuitdeployed() )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x3a9f6b36, Offset: 0xa1c
// Size: 0x9a
function function_a4d92da898877ff7()
{
    if ( self.boss )
    {
        if ( isalive( self.boss ) )
        {
            centerpoint = self.boss.origin;
        }
    }
    else if ( self.s_center )
    {
        centerpoint = self.s_center.origin;
    }
    
    if ( self.questcircleconfig && self.questcircleconfig game_utility::questcircle_exists() && centerpoint )
    {
        self.questcircleconfig game_utility::questcircle_move( centerpoint );
    }
    
    return centerpoint;
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x74ea06db, Offset: 0xabf
// Size: 0x4e7
function activity_setup()
{
    if ( isdefined( level.var_66d5e15cc9735435 ) )
    {
        [[ level.var_66d5e15cc9735435 ]]();
    }
    
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    activityinstance.var_91c91f4a631c481d = activityvariantdefinition;
    activityinstance.maxduration = activityinstance.var_91c91f4a631c481d.maxtime;
    activityinstance.collectrequired = activityinstance.var_91c91f4a631c481d.collectcount;
    activityinstance.var_9b3c3fd82c3ec95f = activityinstance.var_91c91f4a631c481d.var_9b3c3fd82c3ec95f;
    activityinstance.currentcollected = 0;
    activityinstance.floodradius = activityinstance.var_91c91f4a631c481d.floodradius;
    activityinstance.floodencounters = activityinstance.var_91c91f4a631c481d.floodencounters;
    activityinstance.var_afe14a3b46e02b2b = activityinstance.var_91c91f4a631c481d.var_afe14a3b46e02b2b;
    activityinstance.var_27e1fa755727d362 = activityinstance.var_91c91f4a631c481d.var_27e1fa755727d362;
    activityinstance.var_de3b390bcf0f7658 = activityinstance.var_91c91f4a631c481d.var_de3b390bcf0f7658;
    activityinstance.finalbossencounter = activityinstance.var_91c91f4a631c481d.finalbossencounter;
    activityinstance.var_49480b5e37323a87 = activityinstance.var_91c91f4a631c481d.var_741d341fb2c07e57;
    activityinstance.var_612d3112c43ed169 = getdvarint( @"hash_db004231a913bdfa", 100 );
    activityinstance.s_center = utility::getstruct( self.varianttag, "script_noteworthy" );
    activityinstance.var_5f7ae86d7c3b2953 = utility::getstructarray( self.s_center.target, "targetname" );
    activityinstance.s_deposit_portals = [];
    activityinstance.s_boss_spawn_pos_abom = [];
    activityinstance.s_boss_spawn_pos_phobos = [];
    activityinstance.difficulty_region = region_difficulty_manager::get_region_difficulty( activityinstance.s_center.origin );
    activityinstance.var_8e144aca979d1f01 = 0;
    activityinstance.portalstates = [ #"off", #"portal_stage_01", #"portal_stage_02", #"portal_stage_03", #"portal_stage_04", #"portal_stage_05", #"portal_stage_06" ];
    activityinstance.var_dcfee9bbb5135a78 = "Search_Area_WorldEvent_Ob";
    
    if ( getdvarint( @"hash_ed5d60fd8e84f97", 0 ) > 0 )
    {
        activityinstance.collectrequired = getdvarint( @"hash_ed5d60fd8e84f97", 0 );
    }
    
    foreach ( struct in activityinstance.var_5f7ae86d7c3b2953 )
    {
        if ( struct.script_noteworthy == "s_deposit_portal" )
        {
            activityinstance.s_deposit_portals = arraycombineunique( activityinstance.s_deposit_portals, [ struct ] );
            continue;
        }
        
        if ( struct.script_noteworthy == "s_boss_spawn_pos" )
        {
            activityinstance.s_boss_spawn_pos_abom = arraycombineunique( activityinstance.s_boss_spawn_pos_abom, [ struct ] );
            continue;
        }
        
        if ( struct.script_noteworthy == "s_boss_spawn_pos_alt" )
        {
            activityinstance.s_boss_spawn_pos_phobos = arraycombineunique( activityinstance.s_boss_spawn_pos_phobos, [ struct ] );
            continue;
        }
        
        if ( struct.script_noteworthy == "s_boss_tether_data" )
        {
            activityinstance.s_boss_tether_data_struct = struct;
        }
    }
    
    activityinstance.should_shutdown_flood_fill = 0;
    level.var_405b4ed476bec54e = 1;
    
    if ( utility::issharedfuncdefined( #"hash_473f3455c9e039dc", #"hash_463ebc02d3a3b4a4" ) || utility::callsharedfunc( #"hash_473f3455c9e039dc", #"hash_463ebc02d3a3b4a4" ) )
    {
        if ( !utility::callsharedfunc( #"hash_473f3455c9e039dc", #"hash_463ebc02d3a3b4a4" ) )
        {
            activity_instance_common::function_46135a69bddfec2c( activityinstance );
        }
    }
    else
    {
        activity_instance_common::function_46135a69bddfec2c( activityinstance );
    }
    
    level.var_15ce4166f92c5163 = 1;
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x9538adfe, Offset: 0xfae
// Size: 0xbb
function function_477932e3884ea1fd()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activity_definition_utils::function_a0a94881bc380bbf( 0, activityinstance, { #players:activityinstance.playerparticipants } );
    
    /#
        iprintlnbold( "<dev string:x52>" );
    #/
    
    thread ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "poi_appears", level.players );
    thread function_aea232a70c62b53e( activityinstance );
    thread function_68936764b9b67262( activityinstance );
    activityinstance thread spawnflood();
    level callback::add( "scripted_item_used", &artifactusedcallback );
    level callback::add( "scripted_item_can_use", &artifactcanuse );
    hud_util::showsplashtoall( #"hash_b5792ee0129b5d22" );
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x1b73e6bb, Offset: 0x1071
// Size: 0x106
function private function_1b99bd5845b06078( player )
{
    mindistancesquared = undefined;
    var_d37e5b51f53a0b1f = undefined;
    var_5cc3ae7a5f64e9b = activity_participation::function_e8eabd79cc49540e( player, [ "REV_OB_POI_BOSS" ] );
    
    if ( var_5cc3ae7a5f64e9b.size )
    {
        foreach ( instanceid, activityinfostruct in var_5cc3ae7a5f64e9b )
        {
            activityinstance = level.activities.instances[ instanceid ];
            distancesquared = distance2dsquared( activityinstance function_a4d92da898877ff7(), player.origin );
            
            if ( !var_d37e5b51f53a0b1f || distancesquared < mindistancesquared )
            {
                var_d37e5b51f53a0b1f = activityinstance;
                mindistancesquared = distancesquared;
            }
        }
    }
    
    return var_d37e5b51f53a0b1f;
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x6b442ff6, Offset: 0x1180
// Size: 0xca, Type: bool
function private artifactcanuse( params )
{
    if ( !function_aff432e1963cb935( params.bundle ) )
    {
        return true;
    }
    
    itembundle = params.bundle;
    item = params.scriptable;
    player = params.player;
    focusedactivity = function_1b99bd5845b06078( player );
    
    if ( focusedactivity && focusedactivity.type == "REV_OB_POI_BOSS" )
    {
        if ( !isdefined( player.var_ee63524948755bfc ) )
        {
            player.var_ee63524948755bfc = 0;
        }
        
        if ( player.var_ee63524948755bfc < focusedactivity.var_9b3c3fd82c3ec95f )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x3e7e5479, Offset: 0x1253
// Size: 0x25b
function private function_67179e3a4a4131c5( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( !isdefined( activityinstance.var_491847e095ef9a1d ) )
    {
        activityinstance.var_491847e095ef9a1d = [];
    }
    
    var_6b4e10b1f85c0ca9 = getdvarint( @"hash_b2ad1c2fbe260825", 0 );
    portalscreated = 0;
    
    if ( var_6b4e10b1f85c0ca9 > 0 )
    {
        activityinstance.s_deposit_portals = arrayrandomize( activityinstance.s_deposit_portals );
    }
    
    foreach ( portalstruct in activityinstance.s_deposit_portals )
    {
        if ( var_6b4e10b1f85c0ca9 > 0 && var_6b4e10b1f85c0ca9 <= portalscreated )
        {
            break;
        }
        
        portal = spawnscriptable( %"sat_wc_portal_poi_deposit", portalstruct.origin, portalstruct.angles );
        portal.depositremaining = activityinstance.collectrequired;
        portal setscriptablepartstate( #"interact", #"usable" );
        portal setscriptablepartstate( #"portal", #"portal_stage_06" );
        portal setscriptablepartstate( #"beam", #"usable" );
        interaction::register_scriptable_interact( portal, &function_87d67d8368ed3fa3 );
        portal interaction::set_interact_hint_callback( &function_a5877fac671bb886 );
        portal.var_29e65c404675612c = gettime() - 10000;
        portal.completed = 0;
        portal.obstacleid = createnavobstaclebybounds( portalstruct.origin, ( 30, 85, 50 ), portalstruct.angles );
        activityinstance.var_491847e095ef9a1d[ activityinstance.var_491847e095ef9a1d.size ] = portal;
        portalscreated++;
    }
    
    activityinstance.portalscreated = portalscreated;
    activityinstance.portalscompleted = 0;
    activityinstance namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, portalscreated );
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0xbaf42439, Offset: 0x14b6
// Size: 0x394
function private function_87d67d8368ed3fa3( player )
{
    portal = self;
    focusedactivity = function_1b99bd5845b06078( player );
    
    if ( focusedactivity && focusedactivity.type == "REV_OB_POI_BOSS" )
    {
        if ( player.var_ee63524948755bfc > 0 )
        {
            portal.depositremaining -= player.var_ee63524948755bfc;
            player.var_ee63524948755bfc = 0;
            player setclientomnvar( "ui_hud_carried_item_index", 5 );
            player setclientomnvar( "ui_hud_carried_item_count", player.var_ee63524948755bfc );
            
            if ( portal.depositremaining <= 0 )
            {
                /#
                    iprintlnbold( "<dev string:x72>" );
                #/
                
                portal setscriptablepartstate( #"interact", #"unusable" );
                portal setscriptablepartstate( #"portal", #"off" );
                portal setscriptablepartstate( #"pulse", #"off" );
                portal setscriptablepartstate( #"beam", #"unusable" );
                portal setscriptablepartstate( #"portal_pending", #"off" );
                portal.completed = 1;
                focusedactivity.portalscompleted++;
                focusedactivity activity_definition_utils::updateprogress( focusedactivity.portalscompleted, focusedactivity, focusedactivity.portalscreated );
                focusedactivity.var_491847e095ef9a1d = arrayremove( focusedactivity.var_491847e095ef9a1d, portal );
                thread deleteportal( portal, focusedactivity );
                thread ob_activity_vo_utility::function_3a48100939e009e9( focusedactivity, "poi_boss_crack_closed", focusedactivity.playerparticipants );
                
                foreach ( agent in focusedactivity.spawnedenemies )
                {
                    if ( agent.guardingportal && agent.guardingportal == portal && agent.var_466b9b449dbbd91e )
                    {
                        agent setgoalpos( agent.var_466b9b449dbbd91e.goalpos, agent.var_466b9b449dbbd91e.goalradius );
                        agent._blackboard.var_b213ded5043dfa2b = agent.var_466b9b449dbbd91e.wanderorigin;
                        agent._blackboard.var_8d11b98561e1eb81 = agent.var_466b9b449dbbd91e.var_570ccc20a378c863;
                        agent._blackboard.var_8d34ab856208146f = agent.var_466b9b449dbbd91e.var_5730c220a3a12d1d;
                        agent._blackboard.var_6a8c50efac75caa1 = agent.var_466b9b449dbbd91e.tetherrange;
                    }
                }
                
                return;
            }
            
            var_fce0fcdb99e552f1 = portal.depositremaining == 1;
            state = focusedactivity.portalstates[ portal.depositremaining ];
            portal setscriptablepartstate( #"portal", state );
            thread portalpulse( portal, 1 );
        }
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2, eflags: 0x4
// Checksum 0x80dd7561, Offset: 0x1852
// Size: 0x83
function private function_a5877fac671bb886( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( player.var_ee63524948755bfc && player.var_ee63524948755bfc > 0 )
        {
            return { #string:&"sat_ob_activities/global_activity_poi_boss_deposit_artifact", #type:"HINT_NOICON" };
        }
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace ob_global_activity_poi_boss
// Params 2, eflags: 0x4
// Checksum 0x6d9fa5b0, Offset: 0x18de
// Size: 0x4e
function private deleteportal( portal, activity )
{
    level endon( #"game_ended" );
    wait 3;
    
    if ( portal )
    {
        if ( portal.obstacleid )
        {
            destroynavobstacle( portal.obstacleid );
        }
        
        portal freescriptable();
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2, eflags: 0x4
// Checksum 0x881cf79, Offset: 0x1934
// Size: 0xa8
function private portalpulse( portal, useescape = 0 )
{
    portal endon( #"portal_closed" );
    level endon( #"game_ended" );
    pulsestate = useescape ? "escape" : "capturing";
    portal setscriptablepartstate( #"pulse", pulsestate );
    portal setscriptablepartstate( #"portal_pending", "portal_stage_01" );
    wait 1;
    portal setscriptablepartstate( #"pulse", "off" );
    portal setscriptablepartstate( #"portal_pending", "off" );
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0x4968f2f9, Offset: 0x19e4
// Size: 0x64
function function_b8b3cec9d319a02d( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( activityinstance.var_491847e095ef9a1d.size > 0 )
    {
        wait 1;
    }
    
    activityinstance.increasetimer = 1;
    activityinstance notify( #"hash_180ec986ea4e5efd" );
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0x1a5b9fd6, Offset: 0x1a50
// Size: 0x4b1
function activity_complete( activity_succeeded, params = undefined )
{
    activityinstance = self;
    level endon( #"game_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    if ( params && params.victim )
    {
        originpos = params.victim.origin;
    }
    else
    {
        originpos = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    }
    
    if ( self.success_wait )
    {
        return;
    }
    
    if ( activity_succeeded )
    {
        self.success_wait = 1;
        wait 7.5;
        utility::callsharedfunc( #"ob_skill_tracks", #"hash_92aa850c92f2fac0", activityinstance.playerparticipants, 1 );
        groundpos = getgroundposition( originpos - ( 0, 0, -700 ), 16 );
        adjustedspawnpos = getclosestpointonnavmesh( groundpos );
        spawnoptions = { #critical:1, #var_18608bd8660b3a19:0, #var_cce4312374b1b531:level.gametypebundle.var_cce4312374b1b531, #dropradiusscale:1, #var_8d4f327170228364:0, #var_23d3495c57d61bdf:0, #baseangles:( 0, 0, 0 ), #baseorigin:adjustedspawnpos, #spawnpositionindex:0 };
        exoticloot = common_item::function_61c2c0251e742ffd( %"hash_44b1a671abff99a8", undefined, spawnoptions );
        playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_spawn" ), exoticloot.origin + ( 0, 0, 0 ) );
        
        foreach ( player in activityinstance.playerparticipants )
        {
            exoticloot.pingindex = player calloutmarkerping::function_920a63c06abdefe8( exoticloot.index );
        }
    }
    
    activityinstance thread function_db74503fed9beba( activity_succeeded, activityinstance.playerparticipants );
    
    if ( activityinstance.var_75bb6d092b9bb9d3 && activityinstance.var_75bb6d092b9bb9d3.size > 0 )
    {
        activityinstance thread function_db74503fed9beba( activity_succeeded, activityinstance.var_75bb6d092b9bb9d3 );
    }
    
    thread function_bb12ad771fbabe4e( activityinstance, activityinstance.playerparticipants, activity_succeeded );
    level callback::remove( "scripted_item_used", &artifactusedcallback );
    level callback::remove( "scripted_item_can_use", &artifactcanuse );
    self.var_c7c26860d5cf1bf2 = 1;
    var_5f02c0e7bdcf33d3 = 0;
    
    foreach ( portal in activityinstance.var_491847e095ef9a1d )
    {
        portal freescriptable();
        var_5f02c0e7bdcf33d3++;
        
        if ( var_5f02c0e7bdcf33d3 % 3 == 0 )
        {
            waitframe();
        }
    }
    
    var_89c0f3c8a54fcded = 0;
    
    foreach ( enemy in activityinstance.spawnedenemies )
    {
        if ( enemy.subclass == "zombie_phobos" && isalive( enemy ) )
        {
            enemy thread phobos_despawn();
        }
        else
        {
            enemy kill();
        }
        
        var_89c0f3c8a54fcded++;
        
        if ( var_89c0f3c8a54fcded % 2 == 0 )
        {
            waitframe();
        }
    }
    
    foreach ( player in activityinstance.playerparticipants )
    {
        player.var_ee63524948755bfc = 0;
    }
    
    activity_instance_common::endactivity( self, activity_succeeded );
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x6c30d61e, Offset: 0x1f09
// Size: 0x2
function activity_ended()
{
    
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x4
// Checksum 0x1e1e5a03, Offset: 0x1f13
// Size: 0x36
function private phobos_despawn()
{
    level endon( #"game_ended" );
    self.nocorpse = 1;
    utility::function_7c10ea82c1e305b8( "despawn_reveal", "despawn_reveal" );
    wait 1.7;
    self kill();
}

// Namespace ob_global_activity_poi_boss
// Params 3, eflags: 0x4
// Checksum 0x25b02a97, Offset: 0x1f51
// Size: 0x99
function private function_bb12ad771fbabe4e( activityinstance, playerparticipants, success )
{
    var_1b58f21e64038cae = success ? "poi_boss_success_local" : "poi_boss_fail_local";
    var_a315717111838cda = success ? "poi_boss_success_global" : "poi_boss_fail_global";
    thread ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, var_1b58f21e64038cae, playerparticipants );
    nonparticipants = arrayremove( level.players, playerparticipants );
    
    if ( isarray( nonparticipants ) && nonparticipants.size > 0 )
    {
        thread ob_activity_vo_utility::function_3a48100939e009e9( self, var_a315717111838cda, nonparticipants );
    }
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x7abea243, Offset: 0x1ff2
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activityinstance = self;
    activityinstance endon( #"instance_destroyed" );
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0x54d3aded, Offset: 0x2016
// Size: 0x2ab
function function_aea232a70c62b53e( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"phobos_killed" );
    level endon( #"game_ended" );
    timeremaining = int( activityinstance.maxduration );
    
    /#
        if ( getdvarint( @"hash_ccbba3c4037bde4a", 0 ) > 0 )
        {
            timeremaining = getdvarint( @"hash_ccbba3c4037bde4a", 0 );
        }
    #/
    
    while ( timeremaining >= 0 )
    {
        if ( activityinstance.increasetimer )
        {
            timeremaining += getdvarint( @"hash_a707073baf4b502b", 480 );
            activityinstance.increasetimer = 0;
        }
        
        if ( timeremaining > 0 )
        {
            activity_definition_utils::updatetimer( timeremaining, activityinstance );
        }
        
        if ( getdvarint( @"hash_9d0d8435ee47767a", 0 ) > 0 )
        {
            foreach ( participant in activityinstance.playerparticipants )
            {
                if ( participant.var_ee63524948755bfc < activityinstance.var_9b3c3fd82c3ec95f )
                {
                    function_425e5ef7782ab50c( participant );
                }
            }
            
            setdvar( @"hash_9d0d8435ee47767a", 0 );
        }
        
        /#
            if ( getdvarint( @"hash_e85fb5e2398920eb", 0 ) )
            {
                if ( activityinstance.var_e1588666c9ccb28b && activityinstance.var_e11525350dfc7f0 > 0 )
                {
                    thread utility::draw_circle( activityinstance.var_e1588666c9ccb28b, activityinstance.var_e11525350dfc7f0, ( 1, 0, 1 ), 1, 0, level.frameduration );
                }
                
                if ( activityinstance.boss && activityinstance.boss.enemy )
                {
                    thread utility::draw_arrow( activityinstance.boss.origin, activityinstance.boss.enemy.origin, ( 1, 0, 1 ), 1, 0, level.frameduration );
                }
            }
            
            if ( getdvarint( @"scr_poi_boss_force_timeout", 0 ) > 0 )
            {
                timeremaining = 5;
                setdvar( @"scr_poi_boss_force_timeout", 0 );
            }
        #/
        
        timeremaining--;
        wait 1;
    }
    
    /#
        iprintlnbold( "<dev string:x9e>" );
    #/
    
    activity_complete( 0 );
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0x27ce011c, Offset: 0x22c9
// Size: 0x116
function function_68936764b9b67262( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activityinstance.var_620a1f7973258c9 = 1;
    thread function_67179e3a4a4131c5( activityinstance );
    thread function_b8b3cec9d319a02d( activityinstance );
    activityinstance waittill( #"hash_180ec986ea4e5efd" );
    activityinstance.var_620a1f7973258c9 = 0;
    activityinstance.should_shutdown_flood_fill = 1;
    
    foreach ( enemy in activityinstance.spawnedenemies )
    {
        if ( enemy.var_e94a0381e288005e )
        {
            enemy.var_e94a0381e288005e = undefined;
        }
        
        enemy kill();
    }
    
    activityinstance thread spawnboss();
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0xd99f124d, Offset: 0x23e7
// Size: 0x243
function spawnflood()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    n_spawn_radius = self.floodradius;
    
    foreach ( portal in self.var_491847e095ef9a1d )
    {
        var_9573911a6f37ae5d = utility::array_random( self.floodencounters );
        var_27e70e45edcbce89 = utility::array_random( self.var_afe14a3b46e02b2b );
        encounter_name = "ai_encounter:" + var_9573911a6f37ae5d.floodencounter;
        elite_encounter_name = "ai_encounter:" + var_27e70e45edcbce89.floodencounter;
        
        if ( getdvarint( @"hash_34f1f6f5522eb666", 1 ) )
        {
            request_id = activity_ai_encounters::function_eb8506829193f5eb( encounter_name, portal.origin, n_spawn_radius, 1, 1, 1, 2 );
            activity_ai_encounters::function_52d1342183200a8f( request_id, &function_6996b89b8420cf44, [ self, portal ] );
            activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_acaf02cc75e63408, [ self, portal ] );
            activity_ai_encounters::function_d33de057e760c97b( request_id, &function_df498a556520510d, [ self, portal ] );
            activity_ai_encounters::function_16b0131751c4fb39( request_id, &function_21337cf08b0473ca, [ self, portal ] );
        }
        
        var_f2bf3aee5f706783 = activity_ai_encounters::function_eb8506829193f5eb( elite_encounter_name, portal.origin, n_spawn_radius, 1, 1, 1, 2 );
        activity_ai_encounters::function_52d1342183200a8f( var_f2bf3aee5f706783, &function_c40ad6af173d680e, [ self, portal ] );
        activity_ai_encounters::function_dcf6bdb6ee9d1ca0( var_f2bf3aee5f706783, &function_33a79d753c96f645, [ self, portal ] );
        activity_ai_encounters::function_d33de057e760c97b( var_f2bf3aee5f706783, &function_df498a556520510d, [ self, portal ] );
        portal.encounterid = request_id;
        portal.var_dcd5152714bba2b7 = var_f2bf3aee5f706783;
    }
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x29dab349, Offset: 0x2632
// Size: 0x2c0
function spawnboss()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    wait 3;
    n_spawn_radius = self.floodradius;
    var_9573911a6f37ae5d = utility::array_random( self.finalbossencounter );
    
    if ( self.s_boss_spawn_pos_abom && self.s_boss_spawn_pos_abom.size > 0 )
    {
        bosspos = utility::array_random( self.s_boss_spawn_pos_abom );
    }
    else
    {
        bosspos = activity_instance_common::function_776ee11e7acc64a5( self );
    }
    
    if ( isarray( self.var_49480b5e37323a87 ) && self.finalbossencounter.size > 0 && self.var_612d3112c43ed169 > 0 && randomint( 100 ) < self.var_612d3112c43ed169 )
    {
        var_9573911a6f37ae5d = utility::array_random( self.var_49480b5e37323a87 );
        
        if ( self.s_boss_spawn_pos_phobos && self.s_boss_spawn_pos_phobos.size > 0 )
        {
            phobosstruct = utility::array_random( self.s_boss_spawn_pos_phobos );
            bosspos = phobosstruct.origin;
        }
        else
        {
            bosspos = activity_instance_common::function_776ee11e7acc64a5( self );
        }
    }
    
    finalbossencounter = "ai_encounter:" + var_9573911a6f37ae5d.encounter;
    var_ae4e4185fcc632dd = activity_ai_encounters::function_eb8506829193f5eb( finalbossencounter, bosspos, n_spawn_radius, 1, 0, 1, 2 );
    function_64ac8c4e752f4dca( var_ae4e4185fcc632dd, 0 );
    activity_ai_encounters::function_52d1342183200a8f( var_ae4e4185fcc632dd, &function_b781ebdff818349, [ self ] );
    
    if ( getdvarint( @"hash_7fd2b222bc97f1f8", 0 ) != 1 )
    {
        var_417440de0bf39298 = utility::array_random( self.var_27e1fa755727d362 );
        var_42c2cfe69ff25404 = utility::array_random( self.var_de3b390bcf0f7658 );
        bodyguardsencounter = "ai_encounter:" + var_417440de0bf39298.encounter;
        fodderencounter = "ai_encounter:" + var_42c2cfe69ff25404.floodencounter;
        var_dc50a815f2f8fac0 = activity_ai_encounters::function_eb8506829193f5eb( bodyguardsencounter, bosspos, n_spawn_radius, 1, 0, 1, 2 );
        var_9a1c3a996a47e812 = activity_ai_encounters::function_eb8506829193f5eb( fodderencounter, bosspos, n_spawn_radius, 1, 0, 1, 2 );
        activity_ai_encounters::function_52d1342183200a8f( var_dc50a815f2f8fac0, &function_6996b89b8420cf44, [ self ] );
        activity_ai_encounters::function_52d1342183200a8f( var_9a1c3a996a47e812, &function_6996b89b8420cf44, [ self ] );
        activity_ai_encounters::function_dcf6bdb6ee9d1ca0( var_9a1c3a996a47e812, &function_acaf02cc75e63408, [ self ] );
        activity_ai_encounters::function_d33de057e760c97b( var_9a1c3a996a47e812, &function_2a29a26e5b1f74b1, [ self ] );
    }
    
    self.var_c7c26860d5cf1bf2 = 0;
    activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:self.playerparticipants } );
    activity_definition_utils::updateprogress( 0, self, 1 );
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x4
// Checksum 0x64e4ad4b, Offset: 0x28fa
// Size: 0x103
function private function_4934aab48cf5864a()
{
    if ( !self )
    {
        return;
    }
    
    activityinstance = self;
    
    if ( getdvarint( @"hash_7fd2b222bc97f1f8", 0 ) == 1 )
    {
        return;
    }
    
    if ( !activityinstance.boss || !isalive( activityinstance.boss ) )
    {
        return;
    }
    
    if ( !isarray( activityinstance.var_27e1fa755727d362 ) || activityinstance.var_27e1fa755727d362.size == 0 )
    {
        return;
    }
    
    var_417440de0bf39298 = utility::array_random( activityinstance.var_27e1fa755727d362 );
    bosspos = activityinstance.boss.origin;
    bodyguardsencounter = "ai_encounter:" + var_417440de0bf39298.encounter;
    requestid = activityinstance activity_ai_encounters::function_eb8506829193f5eb( bodyguardsencounter, bosspos, activityinstance.floodradius, 1, 0, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( requestid, &function_6996b89b8420cf44, [ activityinstance ] );
}

// Namespace ob_global_activity_poi_boss
// Params 4
// Checksum 0x4f67668, Offset: 0x2a05
// Size: 0x324
function function_c40ad6af173d680e( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activityinstance = userdata[ 0 ];
    agent.poibossactivity = activityinstance;
    agent.var_6fb8224240879ded = 1;
    agent.var_466b9b449dbbd91e = {};
    
    if ( userdata.size > 1 && activityinstance.var_620a1f7973258c9 )
    {
        agent.var_e94a0381e288005e = #"hash_12483469cf49f686";
        guardingportal = userdata[ 1 ];
        
        if ( guardingportal )
        {
            agent.guardingportal = guardingportal;
            agent.var_466b9b449dbbd91e.goalpos = agent.goalpos;
            agent.var_466b9b449dbbd91e.goalradius = agent.goalradius;
            goalorigin = getclosestpointonnavmesh( guardingportal.origin );
            var_19841f06242011fe = getdvarint( @"hash_6eb7a94115fc862", -1 );
            
            if ( getdvarint( @"hash_f48380f4b1a1be46", 1 ) )
            {
                if ( var_19841f06242011fe >= 0 )
                {
                    agent setgoalpos( goalorigin, var_19841f06242011fe );
                }
                else
                {
                    agent setgoalpos( goalorigin );
                }
            }
            
            agent.var_466b9b449dbbd91e.wanderorigin = agent._blackboard.var_b213ded5043dfa2b;
            agent.var_466b9b449dbbd91e.var_570ccc20a378c863 = agent._blackboard.var_8d11b98561e1eb81;
            agent.var_466b9b449dbbd91e.var_5730c220a3a12d1d = agent._blackboard.var_8d34ab856208146f;
            agent.var_466b9b449dbbd91e.tetherrange = agent._blackboard.var_6a8c50efac75caa1;
            
            if ( getdvarint( @"hash_c7898894024748b4", 1 ) )
            {
                agent._blackboard.var_b213ded5043dfa2b = goalorigin;
                agent._blackboard.var_8d11b98561e1eb81 = getdvarint( @"hash_b85da75f492cf38f", 100 );
                agent._blackboard.var_8d34ab856208146f = getdvarint( @"hash_b83a955f49068441", 400 );
            }
            
            if ( getdvarint( @"hash_770f64a5f46e84ea", 1 ) )
            {
                agent._blackboard.var_6a8c50efac75caa1 = getdvarint( @"hash_b934b5fa78056168", 3000 );
            }
            
            guardingportal.var_2d765cc2797fe935 = agent;
        }
    }
    
    if ( !isdefined( activityinstance.spawnedenemies ) )
    {
        activityinstance.spawnedenemies = [];
    }
    
    activityinstance.spawnedenemies = arraycombineunique( activityinstance.spawnedenemies, [ agent ] );
    agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty_darkaether" );
    agent callback::add( #"on_ai_killed", &onAIKilled );
}

// Namespace ob_global_activity_poi_boss
// Params 4
// Checksum 0x9dbca0e3, Offset: 0x2d31
// Size: 0x140
function function_6996b89b8420cf44( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activityinstance = userdata[ 0 ];
    agent.poibossactivity = activityinstance;
    agent.var_6fb8224240879ded = 1;
    iselite = 0;
    
    if ( agent.subclass == "zombie_ghoul" )
    {
        agent.var_e94a0381e288005e = #"hash_12483469cf49f686";
        iselite = 1;
    }
    
    if ( userdata.size > 1 )
    {
        guardingportal = userdata[ 1 ];
        
        if ( guardingportal && !iselite )
        {
            agent setgoalpos( getclosestpointonnavmesh( guardingportal.origin ) );
            agent.guardingportal = guardingportal;
        }
    }
    
    agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty_darkaether" );
    
    if ( !isdefined( activityinstance.spawnedenemies ) )
    {
        activityinstance.spawnedenemies = [];
    }
    
    activityinstance.spawnedenemies = arraycombineunique( activityinstance.spawnedenemies, [ agent ] );
    agent callback::add( #"on_ai_killed", &onAIKilled );
}

// Namespace ob_global_activity_poi_boss
// Params 4
// Checksum 0x1220518, Offset: 0x2e79
// Size: 0x426
function function_b781ebdff818349( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activityinstance = userdata[ 0 ];
    agent.poibossactivity = activityinstance;
    agent.var_87db68283cfc14fb = 1;
    agent.var_6fb8224240879ded = 1;
    agent.activityinstance = activityinstance;
    activityinstance.boss = agent;
    agent.poi_boss_enemy = 1;
    
    if ( agent.subclass == "zombie_phobos" )
    {
        activityinstance.phobosboss = agent;
        agent.var_5c986686a4df80fc = 1;
        agent.var_a960fcfc44d5bc9b = 1;
        agent.var_2e7cd1e5b6deabc7 = 0;
        agent thread function_bcc18bc26598abe();
        agent thread utility::thread_on_notify_no_endon_death( "death", &function_b4e6def723cb5af8, agent, agent );
        activityinstance thread function_a85d5f7f680b8adf();
        agent.ob_boss_healthbar_priority = 1;
        agent zombie_boss_healthbar::function_d16104a6c7125d2d();
        function_6fcabcfd70b85763( activityinstance, activityinstance.playerparticipants );
        agent callback::add( "on_zombie_ai_damaged", &function_7f4f2763d6ce8403 );
        
        foreach ( player in activityinstance.playerparticipants )
        {
            activityinstance thread function_a45d3ff676b353ae( agent, player );
        }
        
        agent utility::function_7c10ea82c1e305b8( "spawn_reveal", "spawn_reveal" );
        spatial_zone_container::function_39b907f49cc2d987( activityinstance, "Awareness_Zone" );
        spatial_zone_container::function_39b907f49cc2d987( activityinstance, "Proximity_Join_Zone" );
        spatial_zone_container::function_39b907f49cc2d987( activityinstance, "Proximity_Abandon_Zone" );
        activityinstance.var_e1588666c9ccb28b = activityinstance.s_boss_tether_data_struct ? getclosestpointonnavmesh( activityinstance.s_boss_tether_data_struct.origin, agent ) : getclosestpointonnavmesh( agent.origin, agent );
        
        if ( !activityinstance.var_e1588666c9ccb28b || activityinstance.var_e1588666c9ccb28b == ( 0, 0, 0 ) )
        {
            activityinstance.var_e1588666c9ccb28b = getclosestpointonnavmesh( activity_instance_common::function_776ee11e7acc64a5( activityinstance ), agent );
        }
        
        activityinstance.var_e11525350dfc7f0 = activityinstance.s_boss_tether_data_struct ? activityinstance.s_boss_tether_data_struct.radius : 5000;
        agent._blackboard.var_b213ded5043dfa2b = activityinstance.var_e1588666c9ccb28b;
        agent._blackboard.var_8d11b98561e1eb81 = 100;
        agent._blackboard.var_8d34ab856208146f = 800;
        agent._blackboard.var_6a8c50efac75caa1 = activityinstance.var_e11525350dfc7f0;
        
        if ( getdvarint( @"hash_50a5d69df27d1a8d", 1 ) )
        {
            agent thread function_56c531401028d79a();
        }
        
        if ( getdvarint( @"hash_b5a7f287312e838", 1 ) )
        {
            agent thread function_a60870b37f188d09( activityinstance );
        }
    }
    
    thread ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "poi_boss_portal_activates", activityinstance.playerparticipants );
    thread ob_activity_vo_utility::function_3a48100939e009e9( activityinstance, "poi_boss_reaction_conversation", activityinstance.playerparticipants );
    
    if ( getdvarint( @"hash_3ba240740fb23281", 0 ) )
    {
        agent thread function_9a7e7b9ab8c7e3a4( activityinstance );
    }
    
    if ( !isdefined( activityinstance.spawnedenemies ) )
    {
        activityinstance.spawnedenemies = [];
    }
    
    activityinstance.spawnedenemies = arraycombineunique( activityinstance.spawnedenemies, [ agent ] );
    agent callback::add( #"on_ai_killed", &onAIKilled );
    agent zombie_utils::function_dfae6a5bd222c586( &function_f329cea31484089d );
    activityinstance thread function_72b126fda719b80d();
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0xd5ed688f, Offset: 0x32a7
// Size: 0x93
function private function_a60870b37f188d09( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self.origin[ 2 ] < -700 )
        {
            /#
                iprintlnbold( "<dev string:xc3>" );
            #/
            
            killresult = function_269f216cf367c130( activityinstance );
            
            if ( !killresult )
            {
                thread phobos_despawn();
                activity_complete( 0 );
            }
            
            return;
        }
        
        wait 5;
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x3f90cf04, Offset: 0x3342
// Size: 0xe3
function private function_b4e6def723cb5af8( phobos )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( utility::callsharedfunc( #"zombie_phobos", #"is_player_attached", player ) )
        {
            utility::callsharedfunc( #"zombie_phobos", #"hash_b1059ccb2f0cdb27", phobos, player );
            
            if ( phobos.activityinstance )
            {
                phobos.activityinstance function_1f3ca46c0a0259fc( player );
            }
        }
    }
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0x4
// Checksum 0xa4c8d5cd, Offset: 0x342d
// Size: 0x169
function private function_72b126fda719b80d()
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    boss = activityinstance.boss;
    waitframe();
    maxhealth = boss.maxhealth ? boss.maxhealth : boss.health;
    
    if ( maxhealth <= 0 )
    {
        return;
    }
    
    activityinstance.var_6f94fa5144e7c68 = [];
    thresholdwaves = 3;
    
    for ( thresholdidx = 1; thresholdidx <= thresholdwaves ; thresholdidx++ )
    {
        activityinstance.var_6f94fa5144e7c68[ activityinstance.var_6f94fa5144e7c68.size ] = int( maxhealth * ( 1 - thresholdidx * 0.25 ) );
    }
    
    activityinstance.var_f3adf9fc61bba8e6 = 0;
    
    while ( isalive( boss ) && activityinstance.var_f3adf9fc61bba8e6 < activityinstance.var_6f94fa5144e7c68.size )
    {
        targetvalue = activityinstance.var_6f94fa5144e7c68[ activityinstance.var_f3adf9fc61bba8e6 ];
        
        if ( boss.health <= targetvalue )
        {
            activityinstance thread function_4934aab48cf5864a();
            activityinstance.var_f3adf9fc61bba8e6++;
        }
        
        wait 0.2;
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2, eflags: 0x4
// Checksum 0x1f0aa15f, Offset: 0x359e
// Size: 0xc3
function private function_a45d3ff676b353ae( phobos, player )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    phobos endon( #"death" );
    phobos utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( phobos )
    {
        scriptableindex = phobos getscriptableindex();
        
        if ( scriptableindex >= 0 )
        {
            player.var_e2c1df7959722f57 = player calloutmarkerping::function_920a63c06abdefe8( scriptableindex );
        }
        
        if ( player.var_e2c1df7959722f57 )
        {
            phobos thread calloutmarkerping::function_3c501da3379eca0a( player, player.var_e2c1df7959722f57, undefined, [ "death" ] );
        }
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x6db59725, Offset: 0x3669
// Size: 0x35
function private function_7f4f2763d6ce8403( params )
{
    activity_instance = self.activityinstance;
    function_6fcabcfd70b85763( activity_instance, activity_instance.playerparticipants );
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x17966c27, Offset: 0x36a6
// Size: 0x10f
function private function_eafcdbb087949037( player )
{
    activityinstance = self;
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_phobos", activityinstance.phobosboss );
        }
        else if ( player.var_71c37977095602df == "ob_boss_phobos" )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
        else if ( player ob_story_mission_utils::function_6ec505041dcea08e( activityinstance.phobosboss ) )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_phobos", activityinstance.phobosboss );
        }
    }
    else if ( player ob_story_mission_utils::function_6ec505041dcea08e( activityinstance.phobosboss ) )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_phobos", activityinstance.phobosboss );
    }
    
    if ( player.var_71c37977095602df == "ob_boss_phobos" )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2, eflags: 0x4
// Checksum 0xaedb31e1, Offset: 0x37bd
// Size: 0x9c
function private function_6fcabcfd70b85763( activityinstance, var_594f895c46df539c )
{
    if ( activityinstance && activityinstance.phobosboss )
    {
        foreach ( player in var_594f895c46df539c )
        {
            activityinstance thread function_eafcdbb087949037( player );
        }
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x76aa002, Offset: 0x3861
// Size: 0x29
function private function_1f3ca46c0a0259fc( player )
{
    if ( player.var_71c37977095602df == "ob_boss_phobos" )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2, eflags: 0x4
// Checksum 0xe3a58a40, Offset: 0x3892
// Size: 0x88
function private function_d06760cd75ebadd8( activityinstance, var_bde93b870aa42ced )
{
    foreach ( player in var_bde93b870aa42ced )
    {
        activityinstance function_1f3ca46c0a0259fc( player );
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x51e52d6e, Offset: 0x3922
// Size: 0xf8, Type: bool
function private function_269f216cf367c130( activityinstance )
{
    if ( activityinstance )
    {
        foreach ( player in activityinstance.playerparticipants )
        {
            if ( player )
            {
                damageamount = self.health;
                self.var_7037157e68c4992b = damageamount;
                idflags = 65536;
                idflags |= 536870912;
                idflags |= 1073741824;
                self dodamage( damageamount, self.origin, player, player, "MOD_EXPLOSIVE", undefined, undefined, undefined, idflags );
                return true;
            }
        }
    }
    
    /#
        iprintln( "<dev string:xed>" );
    #/
    
    return false;
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x4ce85907, Offset: 0x3a23
// Size: 0x135
function private function_9a7e7b9ab8c7e3a4( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( isalive( self ) )
    {
        if ( getdvarint( @"scr_poi_boss_force_kill", 0 ) )
        {
            function_269f216cf367c130( activityinstance );
            setdvar( @"scr_poi_boss_force_kill", 0 );
        }
        
        if ( getdvarint( @"hash_e723bcbfd07472d9", 0 ) )
        {
            player = activityinstance.playerparticipants[ 0 ];
            
            if ( player )
            {
                damageamount = self.health - 10;
                self.var_7037157e68c4992b = damageamount;
                idflags = 65536;
                idflags |= 536870912;
                self dodamage( damageamount, self.origin, player, player, "MOD_EXPLOSIVE", undefined, undefined, undefined, idflags );
            }
            
            setdvar( @"hash_e723bcbfd07472d9", 0 );
        }
        
        /#
            if ( getdvarint( @"hash_36534dff8566a357", 0 ) )
            {
                thread function_c880d4375562dcfb();
                setdvar( @"hash_36534dff8566a357", 0 );
            }
        #/
        
        wait 5;
    }
}

// Namespace ob_global_activity_poi_boss
// Params 0, eflags: 0xc
// Checksum 0x44bf1ede, Offset: 0x3b60
// Size: 0x78
function private function_c880d4375562dcfb()
{
    self notify( #"hash_1852f6310733a152" );
    self endon( #"hash_1852f6310733a152" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        teleportpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 50 );
        self setorigin( teleportpos, 1 );
        waitframe();
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0x765af6e2, Offset: 0x3be0
// Size: 0x3a
function function_acaf02cc75e63408( requestid, userdata )
{
    activityinstance = userdata[ 0 ];
    
    if ( !activityinstance )
    {
        return 0;
    }
    
    shouldspawn = 1;
    return shouldspawn;
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0x7d478112, Offset: 0x3c23
// Size: 0xa4, Type: bool
function function_33a79d753c96f645( requestid, userdata )
{
    activityinstance = userdata[ 0 ];
    
    if ( !activityinstance )
    {
        return false;
    }
    
    if ( userdata.size > 1 )
    {
        portal = userdata[ 1 ];
        
        if ( portal )
        {
            if ( !isdefined( portal.var_29e65c404675612c ) )
            {
                portal.var_29e65c404675612c = gettime() - 10000;
            }
            
            var_322d4d15320c5f8e = gettime() - portal.var_29e65c404675612c;
            
            if ( isalive( portal.var_2d765cc2797fe935 ) || var_322d4d15320c5f8e < 10000 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0xcbcdf37d, Offset: 0x3cd0
// Size: 0x2f
function function_2a29a26e5b1f74b1( requestid, userdata )
{
    activityinstance = userdata[ 0 ];
    return activityinstance.var_c7c26860d5cf1bf2;
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0x620cba98, Offset: 0x3d08
// Size: 0x67
function function_df498a556520510d( requestid, userdata )
{
    activityinstance = userdata[ 0 ];
    
    if ( !activityinstance )
    {
        return 1;
    }
    
    if ( userdata.size > 1 )
    {
        portal = userdata[ 1 ];
        
        if ( !portal || portal.completed )
        {
            return 1;
        }
    }
    
    return activityinstance.should_shutdown_flood_fill;
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0xe29ae67, Offset: 0x3d78
// Size: 0x71, Type: bool
function function_21337cf08b0473ca( requestid, userdata )
{
    activityinstance = userdata[ 0 ];
    
    if ( !activityinstance )
    {
        return false;
    }
    
    if ( userdata.size > 1 )
    {
        portal = userdata[ 1 ];
        
        if ( activityinstance.state == "Active" || !portal || portal.completed )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x969da2bd, Offset: 0x3df2
// Size: 0x2ab
function private onAIKilled( params )
{
    level endon( #"game_ended" );
    
    if ( params.victim )
    {
        if ( params.victim.poi_boss_enemy && params.victim.poibossactivity && ( params.eattacker.classname != "worldspawn" || isplayer( self.var_1480bf6f03b7e0be.eattacker ) ) )
        {
            toxicai = entity::function_cd55d7a649cb9c44( params.victim.origin, 2000, "team_hundred_ninety" );
            
            foreach ( agent in toxicai )
            {
                if ( agent.agent_type == "actor_sat_spawner_zombie_base_toxic_ob" )
                {
                    agent kill();
                }
            }
            
            params.victim notify( #"roar_end" );
            radiusdamage( params.victim.origin, 1024, 1000, 500, undefined, undefined, undefined, undefined, 0 );
            params.victim.poibossactivity notify( #"phobos_killed" );
            params.victim.poibossactivity activity_complete( 1, params );
        }
        else if ( params.victim.guardingportal )
        {
            params.victim.guardingportal.var_2d765cc2797fe935 = undefined;
            params.victim.guardingportal.var_29e65c404675612c = gettime();
        }
        
        if ( params.victim.poibossactivity && isarray( params.victim.poibossactivity.spawnedenemies ) )
        {
            params.victim.poibossactivity.spawnedenemies = arrayremove( params.victim.poibossactivity.spawnedenemies, params.victim );
        }
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0xe81a4e17, Offset: 0x40a5
// Size: 0xce
function function_f329cea31484089d( damagestruct )
{
    if ( !damagestruct || !damagestruct.eattacker || !damagestruct.idamage || !self || !self.poibossactivity )
    {
        return -1;
    }
    
    player = damagestruct.eattacker;
    
    if ( !isplayer( player ) && damagestruct.eattacker.owner )
    {
        player = damagestruct.eattacker.owner;
    }
    
    if ( isplayer( player ) )
    {
        idamage = function_7852f2a8ff218c90( player, damagestruct.idamage, self.poibossactivity );
        return idamage;
    }
    
    return -1;
}

// Namespace ob_global_activity_poi_boss
// Params 3, eflags: 0x4
// Checksum 0x53d3a426, Offset: 0x417c
// Size: 0xe3
function private function_7852f2a8ff218c90( player, indamage, activityinstance )
{
    outdamage = 0.1;
    
    if ( arraycontains( activityinstance.playerparticipants, player ) )
    {
        awareness_zone_sphere = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "Awareness_Zone" );
        awareness_zone_radius = spatial_zone_container::function_231d9e91d8ef7b5f( awareness_zone_sphere[ 0 ] );
        abandon_zone_sphere = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "Proximity_Abandon_Zone" );
        abandon_zone_radius = spatial_zone_container::function_231d9e91d8ef7b5f( abandon_zone_sphere[ 0 ] );
        playerdistance = distance2d( abandon_zone_sphere[ 0 ].origin, player.origin );
        damageratio = clamp( ( abandon_zone_radius - playerdistance ) / ( abandon_zone_radius - awareness_zone_radius ), 0.1, 1 );
        outdamage = indamage * damageratio;
    }
    
    return outdamage;
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x624127a1, Offset: 0x4268
// Size: 0x62
function function_bcc18bc26598abe()
{
    level endon( #"game_ended" );
    utility::ent_flag_wait( "marked_for_death" );
    utility::ent_flag_wait_or_timeout( "space_to_die", 3 );
    
    if ( !utility::ent_flag_exist( "space_to_die" ) )
    {
        self.nocorpse = 1;
        utility::function_7c10ea82c1e305b8( "death_failsafe", "death_failsafe" );
        utility::delaycall( 0.3, &kill );
    }
}

// Namespace ob_global_activity_poi_boss
// Params 0
// Checksum 0x87c7d5e1, Offset: 0x42d2
// Size: 0xb2
function function_a85d5f7f680b8adf()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.5;
        awareness_zone_sphere = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" );
        awareness_zone_radius = spatial_zone_container::function_231d9e91d8ef7b5f( awareness_zone_sphere[ 0 ] );
        awareness_zone_center = spatial_zone_container::function_46a131256b075dc1( self, "Awareness_Zone" );
        addplayers = arrayremove( getplayersinradius( awareness_zone_center, awareness_zone_radius, undefined, 0, self.playerparticipants ), self.playerparticipants );
        
        if ( addplayers )
        {
            activity_participation::function_fb0ec90aaf6d4c61( self, addplayers, "PlayerJoinedProximity" );
        }
    }
}

// Namespace ob_global_activity_poi_boss
// Params 2
// Checksum 0xc7fe8c4a, Offset: 0x438c
// Size: 0xc1
function function_db74503fed9beba( success = 1, splashplayers )
{
    level endon( #"game_ended" );
    splashid = success ? #"hash_722490fe5e0520d4" : #"hash_e096eae69c74f925";
    
    foreach ( player in splashplayers )
    {
        player hud_message::showsplash( splashid );
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0xcf00a1be, Offset: 0x4455
// Size: 0xe5
function artifactusedcallback( params )
{
    if ( !function_aff432e1963cb935( params.bundle ) )
    {
        return;
    }
    
    itembundle = params.bundle;
    item = params.scriptable;
    player = params.player;
    focusedactivity = function_1b99bd5845b06078( player );
    
    if ( focusedactivity && focusedactivity.type == "REV_OB_POI_BOSS" )
    {
        function_425e5ef7782ab50c( player );
        
        /#
            playernamestring = player.name ? player.name : "<dev string:x147>";
            iprintlnbold( "<dev string:x149>" + playernamestring + "<dev string:x151>" + player.var_ee63524948755bfc );
        #/
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1, eflags: 0x4
// Checksum 0x6515005a, Offset: 0x4542
// Size: 0x58
function private function_425e5ef7782ab50c( player )
{
    if ( !isdefined( player.var_ee63524948755bfc ) )
    {
        player.var_ee63524948755bfc = 0;
    }
    
    player.var_ee63524948755bfc++;
    player setclientomnvar( "ui_hud_carried_item_index", 5 );
    player setclientomnvar( "ui_hud_carried_item_count", player.var_ee63524948755bfc );
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0x4985c683, Offset: 0x45a2
// Size: 0x1d, Type: bool
function function_aff432e1963cb935( itembundle )
{
    return itembundle.ref == "sat_ob_convergence_artifact";
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0xbf5633af, Offset: 0x45c8
// Size: 0x2b0
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.var_8e144aca979d1f01 === 0 )
    {
        thread ob_activity_vo_utility::function_3a48100939e009e9( self, "poi_boss_first_enter_local", player_list );
        nonparticipants = arrayremove( level.players, player_list );
        
        if ( isarray( nonparticipants ) && nonparticipants.size > 0 )
        {
            thread ob_activity_vo_utility::function_3a48100939e009e9( self, "poi_boss_first_enter_global", nonparticipants );
        }
        
        self.var_8e144aca979d1f01 = 1;
    }
    else
    {
        thread ob_activity_vo_utility::function_3a48100939e009e9( self, "poi_boss_approaching", player_list );
    }
    
    foreach ( player in player_list )
    {
        if ( !isdefined( player.var_ee63524948755bfc ) )
        {
            player.var_ee63524948755bfc = 0;
        }
        
        /#
            playernamestring = "<dev string:x167>";
            newplayer = player.name ? player.name : "<dev string:x147>";
            playernamestring += newplayer;
            iprintlnbold( "<dev string:x168>" + playernamestring + "<dev string:x171>" );
        #/
    }
    
    if ( !isdefined( self.portalscompleted ) )
    {
        self.portalscompleted = 0;
    }
    
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, self.portalscompleted, self.portalscreated );
    
    if ( self.portalscompleted >= self.portalscreated )
    {
        activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:player_list } );
        activity_definition_utils::updateprogress( 0, self, 1, { #players:player_list } );
    }
    
    if ( self.phobosboss )
    {
        function_6fcabcfd70b85763( self, player_list );
        
        foreach ( player in player_list )
        {
            thread function_a45d3ff676b353ae( self.phobosboss, player );
        }
    }
    
    if ( !isdefined( self.var_75bb6d092b9bb9d3 ) )
    {
        self.var_75bb6d092b9bb9d3 = [];
    }
    
    var_2095c1b13abcbddd = arrayintersection( self.var_75bb6d092b9bb9d3, player_list );
    self.var_75bb6d092b9bb9d3 = arrayremove( self.var_75bb6d092b9bb9d3, var_2095c1b13abcbddd );
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0x82c43673, Offset: 0x4880
// Size: 0x1b0
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    /#
        playernamestring = "<dev string:x167>";
        
        foreach ( player in player_list )
        {
            newplayer = player.name ? player.name : "<dev string:x147>";
            playernamestring += newplayer;
        }
        
        iprintlnbold( "<dev string:x168>" + playernamestring + "<dev string:x192>" );
    #/
    
    if ( self.phobosboss )
    {
        function_d06760cd75ebadd8( self, player_list );
        
        foreach ( player in player_list )
        {
            if ( player.var_e2c1df7959722f57 )
            {
                player calloutmarkerping::function_7c0ee9d4b604e6d6( player.var_e2c1df7959722f57 );
                player.var_e2c1df7959722f57 = undefined;
            }
        }
    }
    
    if ( !isdefined( self.var_75bb6d092b9bb9d3 ) )
    {
        self.var_75bb6d092b9bb9d3 = [];
    }
    
    self.var_75bb6d092b9bb9d3 = arraycombineunique( self.var_75bb6d092b9bb9d3, player_list );
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0xc15b6c2, Offset: 0x4a38
// Size: 0x39
function player_entered_awareness_zone( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.phobosboss )
    {
        function_6fcabcfd70b85763( self, player_list );
    }
}

// Namespace ob_global_activity_poi_boss
// Params 1
// Checksum 0x36a51f81, Offset: 0x4a79
// Size: 0x23
function function_30cc03d1c63234b6( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

