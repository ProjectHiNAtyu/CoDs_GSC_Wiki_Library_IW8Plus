// scripts\mp\ob\activities\ob_activity_destroy_supplies.gsc  (hash_507e5fcbce6623c2.gscc) (size: 18415 Bytes / 0x47ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce0cc0b8 (3456942264)
// size ...... 18415 (0x47ef)
// includes .. 28  (offset: 0x43af)
// strings ... 57  (offset: 0x448f)
// dev strs .. 2   (offset: 0x47d7)
// exports ... 44  (offset: 0x2bc3)
// cseg ...... 0x4cc + 0x26f7 (0x2bc3)
// imports ... 143 (offset: 0x32a3)
// animtree1 . 0   (offset: 0x47ef)
// animtree2 . 0   (offset: 0x47ef)
#using script_61b40095fd0502f0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\objective_marker_bundle_helper;
#using scripts\common\scene;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\hud_message;
#using scripts\mp\ob\activities\ob_activity_composite_utils;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_destroy_supplies;

// Namespace ob_activity_destroy_supplies
// Params 0, eflags: 0x5
// Checksum 0xa76f640d, Offset: 0x4ea
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_destroy_supplies", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0xa414e1d9, Offset: 0x513
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_DESTROY_SUPPLIES", &function_463b7a0cad84079a );
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x69e940a5, Offset: 0x52e
// Size: 0xb6
function function_463b7a0cad84079a()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_DESTROY_SUPPLIES", 0, &destroy_supplies_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_DESTROY_SUPPLIES", 1, &destroy_supplies_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_DESTROY_SUPPLIES", 2, &destroy_supplies_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_DESTROY_SUPPLIES", 3, &destroy_supplies_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_ecd4f836350dd94f, "REV_OB_DESTROY_SUPPLIES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_a632ed8597bc3a0b, "REV_OB_DESTROY_SUPPLIES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_86f4091657fdabf7, "REV_OB_DESTROY_SUPPLIES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_927e6f9865b60802, "REV_OB_DESTROY_SUPPLIES" );
    scriptable::scriptable_addusedcallbackbypart( "ob_supply_bombzone", &function_c13bd7c5f3e5dbcd );
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x16c38553, Offset: 0x5ec
// Size: 0x105
function destroy_supplies_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    /#
        if ( getdvarint( @"hash_19f9ca91e2fc48b", 0 ) )
        {
            thread debug_zones();
        }
    #/
    
    self.master_struct = utility::getstruct( self.varianttag, "script_noteworthy" );
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.master_struct.origin );
    self.var_271b79911658d573 = utility::getstructarray( self.master_struct.target, "targetname" );
    self.exploded_site = 0;
    self.planted_site = 0;
    self.var_31026d7ca0ad6e7c = [];
    self.planter_array = [];
    self.reinforcement_wave = -1;
    self.var_7c8ac045f1d4ae1f = 0;
    thread setup_bomb_site_cover();
    waitframe();
    ob_activity_utility::ob_enable_cover_nodes();
    namespace_d6b7e33ec877018f::function_934ca6cc64ad906d();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0xe47004ad, Offset: 0x6f9
// Size: 0x12e
function destroy_supplies_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    foreach ( pos in self.var_271b79911658d573 )
    {
        profilestart();
        supply_site = bomb_site_spawn( pos );
        profilestop();
        self.var_31026d7ca0ad6e7c[ self.var_31026d7ca0ad6e7c.size ] = supply_site;
    }
    
    destroy_supplies_center_objective_marker();
    childthread function_9e0ec69eb7fc82ac();
    thread function_d75b51975c8b5879();
    
    while ( self.exploded_site < self.var_31026d7ca0ad6e7c.size )
    {
        wait 0.2;
    }
    
    if ( gettime() <= self.var_511b071d67775c39 )
    {
        self.successtype = #"within_time";
        self.var_511b071d67775c39 = undefined;
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x62434a28, Offset: 0x82f
// Size: 0x178
function destroy_supplies_end( activity_succeeded )
{
    if ( self.activity_obj_id )
    {
        objidpoolmanager::returnobjectiveid( self.activity_obj_id );
        self.activity_obj_id = undefined;
    }
    
    if ( self.var_31026d7ca0ad6e7c )
    {
        foreach ( bomb_site in self.var_31026d7ca0ad6e7c )
        {
            bomb_site function_7653c765b6c7b815();
            
            if ( bomb_site.var_1674515c4a4c0655 )
            {
                foreach ( player in bomb_site.var_1674515c4a4c0655 )
                {
                    if ( player )
                    {
                        player.var_c6e1464ec410750f = 1;
                    }
                }
            }
            
            if ( bomb_site.objidnum )
            {
                objidpoolmanager::returnobjectiveid( bomb_site.objidnum );
                bomb_site.objidnum = undefined;
            }
        }
    }
    
    namespace_d6b7e33ec877018f::function_36bad4a225ab3edb();
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x4e777ba1, Offset: 0x9af
// Size: 0x14a
function destroy_supplies_destroy()
{
    foreach ( bomb_site in self.var_31026d7ca0ad6e7c )
    {
        bomb_site freescriptable();
    }
    
    thread clean_up_cover();
    ob_activity_utility::ob_disable_cover_nodes();
    
    if ( self.activity_obj_id )
    {
        objidpoolmanager::returnobjectiveid( self.activity_obj_id );
        self.activity_obj_id = undefined;
    }
    
    if ( self.var_31026d7ca0ad6e7c )
    {
        foreach ( bomb_site in self.var_31026d7ca0ad6e7c )
        {
            if ( bomb_site.objidnum )
            {
                objidpoolmanager::returnobjectiveid( bomb_site.objidnum );
                bomb_site.objidnum = undefined;
            }
        }
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x75a53113, Offset: 0xb01
// Size: 0xc9
function function_ecd4f836350dd94f( relevantinfostruct )
{
    foreach ( player in relevantinfostruct.playerlist )
    {
        if ( arraycontains( self.playerparticipants, player ) )
        {
            continue;
        }
        
        var_538c0694c880e740 = player squad_utility::getsquadmembers();
        
        if ( arrayintersection( var_538c0694c880e740, self.planter_array ).size > 0 )
        {
            activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedSquad" );
        }
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xb566e00c, Offset: 0xbd2
// Size: 0xd1
function function_a632ed8597bc3a0b( relevantinfostruct )
{
    player_list = relevantinfostruct.playerlist;
    
    if ( self.planted_site == self.var_31026d7ca0ad6e7c.size )
    {
        return;
    }
    
    foreach ( player in player_list )
    {
        if ( !activity_participation::function_e7fc1202ac164928( self, player ) )
        {
            continue;
        }
        
        activity_participation::function_61aa2b2879f2c0a2( self, player, 1 );
        ob_activity_utility::function_894ac80e038636c5( "wcadestroychargefail", [ player ] );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xb4384365, Offset: 0xcab
// Size: 0x59
function function_86f4091657fdabf7( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    startingprogress = self.exploded_site ?? 0;
    maxprogress = self.var_271b79911658d573.size;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, startingprogress, maxprogress );
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xd6b30d75, Offset: 0xd0c
// Size: 0xc
function function_927e6f9865b60802( relevant_info_struct )
{
    
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x314670db, Offset: 0xd20
// Size: 0xd1
function bomb_site_spawn( spawn_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    origin = ob_activity_utility::function_fd8fc0e0d2300792( spawn_struct.origin );
    angles = ob_activity_utility::function_fd8fc0e0d2300792( spawn_struct.angles );
    supply_site = spawnscriptable( "sat_ob_destroy_supply_scriptable", origin, angles );
    supply_site.activity_instance = activity_instance;
    supply_site create_site_objective_marker();
    supply_site childthread function_868f37fc74733f44();
    supply_site setscriptablepartstate( #"audio_loop", #"on" );
    supply_site.script_label = spawn_struct.script_label;
    return supply_site;
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x9f9cb555, Offset: 0xdfa
// Size: 0x2dc
function function_9e0ec69eb7fc82ac()
{
    var_217df86d790d5a91 = [];
    var_beb335f971237047 = [];
    var_21d0a2e34f14af98 = [];
    var_c1ca81eab612db1a = self.master_struct.radius ?? 2000;
    
    while ( true )
    {
        wait 0.2;
        
        if ( self.planted_site < self.var_31026d7ca0ad6e7c.size )
        {
            player_array = function_d63fe6a4c08ba6f5( self.master_struct.origin, 4000, 2000, 0, var_217df86d790d5a91 );
            
            foreach ( player in player_array )
            {
                ob_activity_utility::function_894ac80e038636c5( "wcadestroychargebrief", [ player ] );
                var_217df86d790d5a91[ var_217df86d790d5a91.size ] = player;
            }
        }
        
        player_array = function_d63fe6a4c08ba6f5( self.master_struct.origin, var_c1ca81eab612db1a, 2000, 0, var_21d0a2e34f14af98 );
        
        foreach ( player in player_array )
        {
            if ( !activity_player_common::function_a5abbbd5e6dac189( player, [ self ] ) && !activity_participation::function_7d9e88b09010d55a( player, self.varianttag ) )
            {
                continue;
            }
            
            if ( !arraycontains( var_beb335f971237047, player ) && self.planted_site < self.var_31026d7ca0ad6e7c.size )
            {
                var_beb335f971237047[ var_beb335f971237047.size ] = player;
                ob_activity_utility::function_894ac80e038636c5( "wcadestroychargeexp", [ player ] );
            }
            
            var_21d0a2e34f14af98[ var_21d0a2e34f14af98.size ] = player;
            function_b6a9cd8d57eff74c( player );
        }
        
        foreach ( player in var_21d0a2e34f14af98 )
        {
            if ( !activity_player_common::function_a5abbbd5e6dac189( player, [ self ] ) && !activity_participation::function_7d9e88b09010d55a( player, self.varianttag ) || distance2dsquared( player.origin, self.master_struct.origin ) > squared( var_c1ca81eab612db1a * 1.25 ) )
            {
                function_ea7f57c7b9edee68( player );
                var_21d0a2e34f14af98 = arrayremove( var_21d0a2e34f14af98, player );
            }
        }
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x47e2e79a, Offset: 0x10de
// Size: 0x2ed
function function_868f37fc74733f44()
{
    self waittill( #"bomb_planted", planter );
    Awareness_Zone = self.activity_instance.var_8339fb4f2d23dabf.zones[ "Awareness_Zone" ].spheres[ 0 ];
    var_6a6d70d3da67863f = getplayersinradius( Awareness_Zone.origin, Awareness_Zone.radius );
    planter_squad_members = planter squad_utility::getsquadmembers();
    var_142908e9f0d5324b = arrayintersection( var_6a6d70d3da67863f, planter_squad_members );
    valid_squad_members = arrayremove( var_142908e9f0d5324b, self.activity_instance.playerparticipants );
    
    foreach ( player in valid_squad_members )
    {
        join_reason = player == planter ? "PlayerJoinedInteract" : "PlayerJoinedSquad";
        activity_participation::function_bc67362dace4370c( self.activity_instance, player, join_reason );
    }
    
    self.activity_instance.planter_array[ self.activity_instance.planter_array.size ] = planter;
    self.activity_instance.planted_site += 1;
    thread function_eef769dbcdf00aaf( 30 );
    
    /#
        thread function_b97cf2388310b18a();
    #/
    
    bomb_ticker = 0;
    
    while ( bomb_ticker < 30 )
    {
        /#
            if ( self.debug_detonate_bomb )
            {
                break;
            }
        #/
        
        bomb_ticker++;
        wait 1;
    }
    
    objidpoolmanager::returnobjectiveid( self.objidnum );
    self.objidnum = undefined;
    function_ea52fec09fd4fa32();
    self.activity_instance.exploded_site += 1;
    activity_definition_utils::updateprogress( self.activity_instance.exploded_site, self.activity_instance );
    
    if ( self.activity_instance.exploded_site == self.activity_instance.var_31026d7ca0ad6e7c.size )
    {
        thread function_b924645f4bf1d312();
    }
    
    if ( self.activity_instance.exploded_site == self.activity_instance.var_31026d7ca0ad6e7c.size )
    {
        self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcadestroychargesuc", undefined, undefined, undefined, undefined, &function_a282d6d6418298a9 );
        return;
    }
    
    self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcadestroychargeblast" );
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x2d88b144, Offset: 0x13d3
// Size: 0x37
function function_a282d6d6418298a9( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcadestroychargesuc_kagan" || var_73f4f05f29c6770a == "wcadestroychargesuc_razor" )
    {
        return [ "wcadestroychrgclpbck", "wcadestroychargerslw" ];
    }
}

// Namespace ob_activity_destroy_supplies
// Params 6
// Checksum 0x9d011c1e, Offset: 0x1413
// Size: 0x91
function function_c13bd7c5f3e5dbcd( instance, part, state, player, bautouse, usestring )
{
    if ( player.ismutantinjection || player.carryinghostage || player.inlaststand || player.isjuggernaut )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return;
    }
    
    instance thread function_fb9c1eaeb2412dc6( player );
}

// Namespace ob_activity_destroy_supplies
// Params 1, eflags: 0x4
// Checksum 0xf630b40b, Offset: 0x14ac
// Size: 0x188
function private function_fb9c1eaeb2412dc6( player )
{
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    self setscriptablepartstate( #"ob_supply_bombzone", #"unusable_planting" );
    self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcadestroychargehack", [ player ] );
    
    if ( !self.reinforcement_arrive )
    {
        thread reinforce_bomb_site();
        self.reinforcement_arrive = 1;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        if ( !isdefined( self.activity_instance.var_511b071d67775c39 ) )
        {
            self.activity_instance.var_511b071d67775c39 = gettime() + 60300;
        }
        
        self setscriptablepartstate( #"ob_supply_bombzone", #"unusable_planted" );
        self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcadestroychargersdelay", [ player ] );
        self.activity_instance notify( #"hash_2069901c0abf5f10" );
        self.activity_instance.var_7c8ac045f1d4ae1f = 1;
        self.is_compromised = 1;
        self notify( #"bomb_planted", player );
        return;
    }
    
    if ( self.activity_instance.state == "Active" )
    {
        self setscriptablepartstate( #"ob_supply_bombzone", #"usable" );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x9ef2450b, Offset: 0x163c
// Size: 0x245
function reinforce_bomb_site()
{
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_62af4e109e8f9aeb = 1;
    
    if ( isdefined( activity_instance.encounterid ) )
    {
        foreach ( label in [ "_a", "_b" ] )
        {
            if ( label == self.script_label )
            {
                function_1a9d724a960fa19d( activity_instance.encounterid, "backup" + label, 1 );
                continue;
            }
            
            function_1a9d724a960fa19d( activity_instance.encounterid, "backup" + label, 0 );
        }
        
        if ( self.activity_instance.master_struct.script_parameters == "indoor" )
        {
            function_1a9d724a960fa19d( activity_instance.encounterid, "smoke_bomb_infil", 1 );
            function_1a9d724a960fa19d( activity_instance.encounterid, "vtol_infil", 0 );
            function_1a9d724a960fa19d( activity_instance.encounterid, "parachute_infil", 0 );
        }
        else if ( self.activity_instance.master_struct.script_parameters == "vtol_infil" )
        {
            function_1a9d724a960fa19d( activity_instance.encounterid, "smoke_bomb_infil", 0 );
            function_1a9d724a960fa19d( activity_instance.encounterid, "vtol_infil", 1 );
            function_1a9d724a960fa19d( activity_instance.encounterid, "parachute_infil", 0 );
            var_62af4e109e8f9aeb = 0;
        }
        else
        {
            function_1a9d724a960fa19d( activity_instance.encounterid, "smoke_bomb_infil", 0 );
            function_1a9d724a960fa19d( activity_instance.encounterid, "vtol_infil", 0 );
            function_1a9d724a960fa19d( activity_instance.encounterid, "parachute_infil", 1 );
        }
        
        if ( var_62af4e109e8f9aeb )
        {
            self waittill( #"bomb_planted" );
        }
        
        activity_instance.reinforcement_wave++;
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0xe142bb61, Offset: 0x1889
// Size: 0x2
function function_b924645f4bf1d312()
{
    
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x3bb990, Offset: 0x1893
// Size: 0xbe
function function_ea52fec09fd4fa32()
{
    self setscriptablepartstate( #"ob_supply_bombzone", #"unusable_destroyed" );
    wait 2;
    self notify( #"exploded" );
    explosionpos = self.origin + ( 0, 0, 50 );
    physicsexplosionsphere( explosionpos, 200, 100, 3 );
    radiusdamage( explosionpos, 750, 500, 10, undefined, "MOD_EXPLOSIVE" );
    self setscriptablepartstate( #"audio_loop", #"off" );
    
    if ( getdvarint( @"hash_fe9a68bfacea1b40", 0 ) != 1 )
    {
        thread function_b6a0345f45205c47( self.origin, 750 );
    }
    
    wait 0.05;
    self.bomb_exploded = 1;
}

// Namespace ob_activity_destroy_supplies
// Params 2, eflags: 0x4
// Checksum 0x83b3f6c7, Offset: 0x1959
// Size: 0x14a
function private function_b6a0345f45205c47( position, radius )
{
    empd_ents = emp_debuff::empdebuff_get_emp_ents( position, radius );
    players = getplayersinradius( position, radius );
    emp_weapon = makeweapon( "emp_pulse_mp" );
    empd_ents = arraycombineunique( empd_ents, players );
    
    foreach ( ent in empd_ents )
    {
        data = damage_utility::packdamagedata( self, ent, 1, emp_weapon );
        isvehicle = ent vehicle::is_vehicle();
        
        if ( isplayer( ent ) )
        {
            ent thread function_9d0c0427aa229571( 10 );
            continue;
        }
        
        if ( isvehicle )
        {
            ent thread emp_debuff::function_1fdeda386a85c7c7( data, 60 );
            continue;
        }
        
        if ( ent.subclass == "dawg" && "inactive" == ent.mode )
        {
            continue;
        }
        
        ent thread emp_debuff::function_1fdeda386a85c7c7( data, 30 );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1, eflags: 0x4
// Checksum 0x7c3a4bc5, Offset: 0x1aab
// Size: 0x38
function private function_9d0c0427aa229571( duration_seconds )
{
    self endon( #"disconnect" );
    emp_debuff::play_emp_scramble( 5 );
    utility::waittill_any_timeout( duration_seconds, "emp_removed" );
    emp_debuff::stop_emp_scramble( 5 );
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x71b88d2b, Offset: 0x1aeb
// Size: 0x99
function destroy_supplies_center_objective_marker()
{
    marker_origin = utility::drop_to_ground( self.master_struct.origin ) + ( 0, 0, 200 );
    self.activity_obj_id = objective_marker_bundle_helper::function_d98e9d627f2d8c28( "sat_ob_supplies_site_activity_marker" );
    objidpoolmanager::update_objective_position( self.activity_obj_id, marker_origin );
    var_b1fa80e8a41b41ed = %"hovercard:hovercard_sat_ob_power_supply_objective_marker";
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", var_b1fa80e8a41b41ed );
    objidpoolmanager::function_1a27e9b999215f16( self.activity_obj_id, hovercardid );
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x76448439, Offset: 0x1b8c
// Size: 0xb1
function function_b6a9cd8d57eff74c( player )
{
    objidpoolmanager::objective_playermask_hidefrom( self.activity_obj_id, player );
    
    foreach ( site in self.var_31026d7ca0ad6e7c )
    {
        if ( isdefined( site.objidnum ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( site.objidnum, player );
        }
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x2ca715bb, Offset: 0x1c45
// Size: 0xb1
function function_ea7f57c7b9edee68( player )
{
    objidpoolmanager::objective_playermask_addshowplayer( self.activity_obj_id, player );
    
    foreach ( site in self.var_31026d7ca0ad6e7c )
    {
        if ( isdefined( site.objidnum ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( site.objidnum, player );
        }
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x2eadec0c, Offset: 0x1cfe
// Size: 0x5b
function create_site_objective_marker()
{
    if ( !isdefined( self.objidnum ) )
    {
        self.objidnum = objective_marker_bundle_helper::function_d98e9d627f2d8c28( "sat_ob_supplies_site_marker" );
        objidpoolmanager::update_objective_position( self.objidnum, self.origin + ( 0, 0, 45 ) );
        objidpoolmanager::function_eb808b97701a4793( self.objidnum );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0x4bedfeae, Offset: 0x1d61
// Size: 0xdd
function function_eef769dbcdf00aaf( var_ccd5594a8890e558 )
{
    self endon( #"death" );
    self endon( #"exploded" );
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    objidpoolmanager::update_objective_description( self.objidnum, &"sat_ob_activities/activity_destroy_supplies_bomb_countdown" );
    objidpoolmanager::objective_show_progress( self.objidnum, 1 );
    elapsed_seconds = 0;
    
    while ( true )
    {
        if ( elapsed_seconds == var_ccd5594a8890e558 )
        {
            objidpoolmanager::objective_set_progress( self.objidnum, 1 );
            break;
        }
        
        progress_to_show = elapsed_seconds / var_ccd5594a8890e558;
        objidpoolmanager::objective_set_progress( self.objidnum, progress_to_show );
        elapsed_seconds = min( elapsed_seconds + 0.5, var_ccd5594a8890e558 );
        wait 0.5;
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x2602dd47, Offset: 0x1e46
// Size: 0x217
function function_cb266856cf4930af()
{
    self.nearby_players_array = [];
    
    while ( true )
    {
        if ( !isdefined( self ) || !self.objidnum )
        {
            return;
        }
        
        players = getplayersinradius( self.origin, 150 );
        
        if ( self.activity_instance is_supply_chain() )
        {
            players = arrayintersection( players, self.activity_instance.playerparticipants );
        }
        
        foreach ( player in players )
        {
            if ( !arraycontains( self.nearby_players_array, player ) )
            {
                objidpoolmanager::function_beebd729a49b6cc3( player );
                
                if ( objidpoolmanager::function_72efeaceb614613a( self.objidnum, player, 1, 2, &"sat_ob_activities/activity_destroy_supplies_bomb_countdown" ) )
                {
                    self.nearby_players_array[ self.nearby_players_array.size ] = player;
                    objidpoolmanager::objective_pin_player( self.objidnum, player );
                }
            }
        }
        
        foreach ( player_nearby in self.nearby_players_array )
        {
            if ( isalive( player_nearby ) && distance2dsquared( self.origin, player_nearby.origin ) < 24750 )
            {
                continue;
            }
            
            objidpoolmanager::function_6ac40386d1cd0d9a( self.objidnum, player_nearby );
            objidpoolmanager::objective_unpin_player( self.objidnum, player_nearby );
            self.nearby_players_array = arrayremove( self.nearby_players_array, player_nearby );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0
// Checksum 0x77f1d9b1, Offset: 0x2065
// Size: 0xce
function function_d75b51975c8b5879()
{
    self.encounterid = activity_ai_encounters::function_92b671064b0b1ce2( self.varianttag, 1, 0, 1, 2 );
    
    if ( isdefined( self.encounterid ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.encounterid, &function_23b1a8df1c24cd04, self );
        function_1a9d724a960fa19d( self.encounterid, self.difficulty_region, 1 );
        ai_spawn_director::function_5c8b22954b3bfa37( self.encounterid, &function_5e07aff9ca505517, [ self ] );
    }
    
    var_800c2bb10a61a860 = self.varianttag + "_charging_pad";
    self.var_7aa66b4cbd92fe02 = activity_ai_encounters::function_92b671064b0b1ce2( var_800c2bb10a61a860, 1, 0, 1, 2 );
    
    if ( isdefined( self.var_7aa66b4cbd92fe02 ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.var_7aa66b4cbd92fe02, &function_23b1a8df1c24cd04, self );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 4
// Checksum 0xa93b3465, Offset: 0x213b
// Size: 0x218
function function_23b1a8df1c24cd04( requestid, activity_instance, agent, data )
{
    agent endon( #"death" );
    
    if ( agent.subclass == "dawg" )
    {
        ob_activity_utility::setup_dawg_on_spawned( agent );
        agent thread function_288436f0a3ca071( activity_instance );
    }
    
    if ( issubstr( agent.agent_type, "guild_bot" ) )
    {
        agent emp_debuff::set_apply_emp_callback( &on_emp_applied );
        emp_debuff::add_emp_ent( agent );
        agent emp_debuff::set_clear_emp_callback( &on_emp_cleared );
    }
    
    if ( data.waveindex == 0 )
    {
        if ( data.spawnfilter == #"guild_bot_charging_pad" || data.spawnfilter == #"advanced_guild_bot_charging_pad" || data.spawnfilter == #"dawg_charging_pad" )
        {
            linked_supply_site = undefined;
            
            foreach ( site in activity_instance.var_31026d7ca0ad6e7c )
            {
                if ( !site.script_label || !data.script_parameters )
                {
                    if ( !linked_supply_site || distance2dsquared( linked_supply_site.origin, agent.origin ) > distance2dsquared( site.origin, agent.origin ) )
                    {
                        linked_supply_site = site;
                    }
                    
                    continue;
                }
                
                if ( site.script_label == data.script_parameters )
                {
                    linked_supply_site = site;
                    break;
                }
            }
            
            if ( !linked_supply_site.is_compromised )
            {
                activity_instance thread function_8e231efbddecc102( agent );
                activity_instance thread function_1815c73148aa764d( agent, linked_supply_site );
            }
        }
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xeb1ec6c1, Offset: 0x235b
// Size: 0x123
function function_288436f0a3ca071( activity_instance )
{
    self endon( #"death" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        closest_distsq = 999999999;
        var_4b22821b73373a65 = undefined;
        
        foreach ( site in activity_instance.var_31026d7ca0ad6e7c )
        {
            dist = distancesquared( site.origin, self.origin );
            
            if ( dist < closest_distsq && !site.bomb_exploded )
            {
                closest_distsq = dist;
                var_4b22821b73373a65 = site;
            }
        }
        
        if ( !var_4b22821b73373a65 )
        {
            return;
        }
        
        dawg::function_be8f466b087210a0( var_4b22821b73373a65.origin );
        wait 10;
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xa9224bdf, Offset: 0x2486
// Size: 0x85
function on_emp_applied( data )
{
    self._blackboard.shockedendtime = gettime() + 30000;
    self._blackboard.var_ba9517cfc0287af8 = gettime();
    
    if ( self.allowpain && self asmhaspainstate( self.asmname ) )
    {
        self asmevalpaintransition( self.asmname );
    }
    
    self setscriptablepartstate( #"shockStickVfx", #"vfx_start" );
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xe4cbad93, Offset: 0x2513
// Size: 0x24
function on_emp_cleared( data )
{
    self setscriptablepartstate( #"shockStickVfx", #"off" );
}

// Namespace ob_activity_destroy_supplies
// Params 3
// Checksum 0x2a75e061, Offset: 0x253f
// Size: 0x3b, Type: bool
function function_5e07aff9ca505517( requestid, userdata, wavenumber )
{
    activity_instance = userdata[ 0 ];
    return activity_instance.reinforcement_wave == wavenumber;
}

// Namespace ob_activity_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0x6b932e05, Offset: 0x2583
// Size: 0x5b
function private setup_bomb_site_cover()
{
    self endon( #"activity_ended" );
    
    if ( isdefined( self.master_struct.script_noteworthy ) )
    {
        var_edd0cb6e9ee724e9 = "cover_" + self.master_struct.script_noteworthy;
        self.scriptable_covers = ob_soldier_util::function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0x8a14b583, Offset: 0x25e6
// Size: 0x21
function private clean_up_cover()
{
    if ( self.scriptable_covers.size > 0 )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.scriptable_covers );
    }
}

// Namespace ob_activity_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0x6dbcb901, Offset: 0x260f
// Size: 0x11, Type: bool
function private is_supply_chain()
{
    return self.type == "REV_OB_SUPPLY_CHAIN";
}

// Namespace ob_activity_destroy_supplies
// Params 1
// Checksum 0xfbd84e03, Offset: 0x2629
// Size: 0x1b3, Type: bool
function function_8e231efbddecc102( robot )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    robot endon( #"death" );
    robot.var_24954f14e27b448d = 0;
    robot val::set( "supply_site_charging", "ignoreme", 1 );
    robot val::set( "supply_site_charging", "ignoreall", 1 );
    robot val::set( "supply_site_charging", "damage", 0 );
    robot.script_pushable_by_ai = 0;
    robot.script_pushable = 0;
    robot.kfe_ignore = 1;
    
    if ( issubstr( robot.agent_type, "guild_bot" ) )
    {
        scene_root = spawnstruct();
        scene_root.origin = robot.origin;
        scene_root.angles = robot.angles;
        scene_root scene::init( [ robot ], "idle", "sat_ai_guildbot_folded" );
        scene_root thread scene::play( [ robot ], "idle" );
        robot.scene_root = scene_root;
        robot callback::add( #"asm_death_anim", &function_90e45f2a0031143e );
        robot val::set( "supply_site_charging", "allow_battlechatter_vo", 0 );
    }
    
    if ( robot.subclass == "dawg" )
    {
        robot.mode = "inactive";
        robot.var_e88e025ae79c116e = 1;
        robot.turret val::set( "supply_site_charging", "damage", 0 );
    }
    
    return true;
}

// Namespace ob_activity_destroy_supplies
// Params 2
// Checksum 0x9705c062, Offset: 0x27e5
// Size: 0x71
function function_1815c73148aa764d( robot, var_7fec6d131f9e2827 )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    robot endon( #"death" );
    
    if ( isdefined( var_7fec6d131f9e2827 ) )
    {
        var_7fec6d131f9e2827 waittill( #"bomb_planted" );
    }
    else
    {
        script::demoforcesre( "Can't find the linked charge station scriptable for a charging pad in + " + self.varianttag );
        return;
    }
    
    thread _activate_robot( robot );
}

// Namespace ob_activity_destroy_supplies
// Params 1, eflags: 0x4
// Checksum 0x5913d1e5, Offset: 0x285e
// Size: 0x32
function private function_90e45f2a0031143e( params )
{
    if ( self.scene_root )
    {
        self.scene_root scene::stop();
        self.scene_root = undefined;
    }
}

// Namespace ob_activity_destroy_supplies
// Params 1, eflags: 0x4
// Checksum 0x7b4821c3, Offset: 0x2898
// Size: 0x13f
function private _activate_robot( robot )
{
    robot.var_24954f14e27b448d = 1;
    robot val::set( "supply_site_charging", "ignoreme", 0 );
    robot val::set( "supply_site_charging", "ignoreall", 0 );
    robot val::set( "supply_site_charging", "damage", 1 );
    robot.script_pushable_by_ai = 1;
    robot.script_pushable = 1;
    robot.kfe_ignore = undefined;
    
    if ( issubstr( robot.agent_type, "guild_bot" ) )
    {
        robot val::set( "supply_site_charging", "allow_battlechatter_vo", 1 );
        robot.scene_root scene::play( [ robot ], utility::array_random( [ "exit_01", "exit_02", "exit_03", "exit_04" ] ) );
        robot.scene_root = undefined;
        return;
    }
    
    if ( robot.subclass == "dawg" )
    {
        robot.turret val::set( "supply_site_charging", "damage", 1 );
        robot.mode = "attack";
    }
}

/#

    // Namespace ob_activity_destroy_supplies
    // Params 0
    // Checksum 0xdfbdae0d, Offset: 0x29df
    // Size: 0x56, Type: dev
    function function_b97cf2388310b18a()
    {
        level endon( #"game_ended" );
        self endon( #"exploded" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_2840695f42f0e94a", 0 ) )
            {
                setdvar( @"hash_2840695f42f0e94a", 0 );
                self.debug_detonate_bomb = 1;
            }
            
            wait 0.2;
        }
    }

    // Namespace ob_activity_destroy_supplies
    // Params 0
    // Checksum 0xf5ecee4d, Offset: 0x2a3d
    // Size: 0x186, Type: dev
    function debug_zones()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            color = ( 1, 1, 1 );
            
            foreach ( struct in self.var_8339fb4f2d23dabf.zones )
            {
                if ( isdefined( struct.spheres[ 0 ].origin ) && isdefined( struct.spheres[ 0 ].radius ) )
                {
                    if ( struct.spheres[ 0 ].associatedspatialzonename == "<dev string:x24>" )
                    {
                        color = ( 0, 0, 1 );
                    }
                    else if ( struct.spheres[ 0 ].associatedspatialzonename == "<dev string:x3b>" )
                    {
                        color = ( 1, 0, 0 );
                    }
                    
                    utility::draw_circle( struct.spheres[ 0 ].origin, struct.spheres[ 0 ].radius, color, 1, 0, level.frameduration );
                }
            }
            
            waitframe();
        }
    }

#/
