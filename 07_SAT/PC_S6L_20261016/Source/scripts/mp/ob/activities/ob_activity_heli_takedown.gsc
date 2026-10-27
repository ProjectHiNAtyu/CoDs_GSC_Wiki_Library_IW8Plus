// scripts\mp\ob\activities\ob_activity_heli_takedown.gsc  (hash_5a7f5653d552ce86.gscc) (size: 22582 Bytes / 0x5836 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbc615e5 (3150321125)
// size ...... 22582 (0x5836)
// includes .. 28  (offset: 0x51ee)
// strings ... 85  (offset: 0x52ce)
// dev strs .. 10  (offset: 0x57b6)
// exports ... 53  (offset: 0x339e)
// cseg ...... 0x64d + 0x2d51 (0x339e)
// imports ... 185 (offset: 0x3be6)
// animtree1 . 0   (offset: 0x5836)
// animtree2 . 0   (offset: 0x5836)
#using script_2304453c69e996e2;
#using script_3455b106458253e7;
#using script_60cd1c57e94be8d7;
#using script_6e05fdc2c6f5fa06;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\ob\activities\ob_activity_composite_utils;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objectives\exfil;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\vehicles\vehicle_hack;

#namespace ob_activity_heli_takedown;

// Namespace ob_activity_heli_takedown
// Params 0, eflags: 0x5
// Checksum 0x8c7cd49e, Offset: 0x66b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_heli_takedown", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_heli_takedown
// Params 0, eflags: 0x4
// Checksum 0xf73dee9e, Offset: 0x694
// Size: 0x3e
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HELI_TAKEDOWN", &function_9d6ec7d3ef6fd6f4 );
    
    if ( !isdefined( level._effect[ "gunship_flares" ] ) )
    {
        level._effect[ "gunship_flares" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_flares" );
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xe67e3156, Offset: 0x6da
// Size: 0xc0
function function_9d6ec7d3ef6fd6f4()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_HELI_TAKEDOWN", 0, &function_be28fdca30786fae );
    activity_common::function_944074f3079c1d4e( "REV_OB_HELI_TAKEDOWN", 1, &function_619c1d310f7073d6 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HELI_TAKEDOWN", 2, &function_4e32465b8060c132 );
    activity_common::function_944074f3079c1d4e( "REV_OB_HELI_TAKEDOWN", 3, &function_40a50f2aae01d43d );
    activity_common::function_944074f3079c1d4e( "REV_OB_HELI_TAKEDOWN", 4, &function_668d79b5bd8dca20 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_2c052c6824ef56b0, "REV_OB_HELI_TAKEDOWN" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_fd5f1e5e3a926fa0, "REV_OB_HELI_TAKEDOWN" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_3759e05d0f006901, "REV_OB_HELI_TAKEDOWN" );
    utility::registersharedfunc( #"vtol", #"hack", &vtol_hack );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xa97cb899, Offset: 0x7a2
// Size: 0x129
function function_be28fdca30786fae()
{
    function_fb53b392296c145c();
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    self.takeoff_delay = activityvariantdefinition.takeoffdelay ?? 20;
    self.var_18910046ae5f697 = utility::getstruct( self.varianttag, "targetname" );
    assert( isdefined( self.var_18910046ae5f697 ), "<dev string:x24>" + self.varianttag );
    self.start_location = undefined;
    self.var_2a47db6ce749f4a9 = undefined;
    self.var_5b3a4570324587cd = undefined;
    self.var_f783b83a4994c799 = undefined;
    self.str_badplace_name = undefined;
    self.var_223e3733b267b175 = [];
    self.var_98a4a9cc1110cb97 = [];
    
    if ( flags::gameflagexists( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    self.start_location = self.var_18910046ae5f697 namespace_be3150865da9d2f1::get_linked_struct();
    heli_takedown_heli_spawn();
    function_7e4c27cb65d41473();
    thread function_78df2951bc6b1cef();
    setup_heli_takedown_cover();
    thread function_acc404a695902264();
    waitframe();
    ob_activity_utility::ob_enable_cover_nodes();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x5f237b95, Offset: 0x8d3
// Size: 0xd3
function function_619c1d310f7073d6()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_2a47db6ce749f4a9 endon( #"death" );
    utility::waittill_any( "combat", "player_in_takeoff_distance" );
    utility::waittill_any_timeout( self.takeoff_delay, "takeoff_at_once" );
    thread function_43dfd86524c78b6d();
    function_95401236ea7e4f70();
    self.var_2a47db6ce749f4a9.state = "hover";
    self.var_2a47db6ce749f4a9.var_c3c4d711e69d5ab9 = 0;
    wait 10;
    
    if ( self.var_2a47db6ce749f4a9.var_70e5107fa80844df >= 1 )
    {
        wait self.var_2a47db6ce749f4a9.var_2e202280347d2700;
    }
    
    ob_activity_utility::function_894ac80e038636c5( "wcavtolwarning" );
    function_e016f8e40b55e835();
}

// Namespace ob_activity_heli_takedown
// Params 2
// Checksum 0xda1ef333, Offset: 0x9ae
// Size: 0x2f
function vtol_hack( hackeffect, attacker )
{
    utility::function_32b24db3127bff40( "hide_body", "off" );
    function_dbcbd62d080e141( hackeffect );
}

// Namespace ob_activity_heli_takedown
// Params 1, eflags: 0xc
// Checksum 0x8d94fe52, Offset: 0x9e5
// Size: 0x1a0
function private function_dbcbd62d080e141( hackeffect )
{
    self notify( #"hash_8b35b8b20be3c2e9" );
    self endon( #"hash_8b35b8b20be3c2e9" );
    self endon( #"death", #"activity_ended", #"game_ended", #"vtol_flee" );
    vehicle_hack::function_c0127e2aa29fa8b7();
    var_2e202280347d2700 = hackeffect.hackduration * 0.001;
    
    if ( self.state == "hover" )
    {
        wait var_2e202280347d2700;
    }
    else
    {
        self.is_speed_overridden = 1;
        self.hack_speed_scale = hackeffect.speedscale;
        original_speed = self vehicle_getspeed();
        self vehicle_setspeedimmediate( original_speed * hackeffect.speedscale );
        
        if ( self.state == "climb" )
        {
            thread function_5074251e544bb75c( hackeffect.hackduration, hackeffect.speedscale );
        }
        
        wait var_2e202280347d2700;
        
        if ( self.state == "climb" )
        {
            self vehicle_setspeed( level.var_60312a4146f172ee, level.var_328258b5444888ed, level.var_595350916585c0f8 );
        }
        
        if ( self.state == "escape" )
        {
            escape_speed = self.var_677dfac95a9a8a5f ?? level.var_4211d1e162e82fb2;
            self vehicle_setspeed( escape_speed, level.var_76d7e14e4d6491e9, level.var_6110fc2f90352874 );
        }
        
        self.is_speed_overridden = undefined;
        self.hack_speed_scale = undefined;
        self.var_677dfac95a9a8a5f = undefined;
    }
    
    vehicle_hack::function_719a8b957386c2a6( 1 );
}

// Namespace ob_activity_heli_takedown
// Params 2, eflags: 0x4
// Checksum 0xfa12d795, Offset: 0xb8d
// Size: 0x81
function private function_5074251e544bb75c( var_2e202280347d2700, hack_speed_scale )
{
    self endon( #"death", #"activity_ended" );
    var_9a799714757a0cb3 = gettime() + var_2e202280347d2700;
    
    while ( gettime() < var_9a799714757a0cb3 )
    {
        if ( self.state == "escape" && self.is_speed_overridden )
        {
            self vehicle_setspeedimmediate( level.var_328258b5444888ed * hack_speed_scale );
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x698d30a9, Offset: 0xc16
// Size: 0x10
function function_4e32465b8060c132()
{
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    namespace_d6b7e33ec877018f::function_36bad4a225ab3edb();
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x62e4bbe7, Offset: 0xc2e
// Size: 0xf1
function function_40a50f2aae01d43d()
{
    if ( isdefined( self.str_badplace_name ) )
    {
        badplace_delete( self.str_badplace_name );
    }
    
    if ( isdefined( self.var_2a47db6ce749f4a9 ) && self.var_2a47db6ce749f4a9.state != "flee" )
    {
        self.var_2a47db6ce749f4a9 notify( #"choppersupport_gone" );
        self.var_2a47db6ce749f4a9.dontspawnhusk = 1;
        
        if ( self.var_2a47db6ce749f4a9.var_dc64ea91291dad76 )
        {
            self.var_2a47db6ce749f4a9.var_dc64ea91291dad76 delete();
        }
        
        level thread vehicle::death( self.var_2a47db6ce749f4a9 );
    }
    
    if ( isdefined( self.var_5b3a4570324587cd ) )
    {
        self.var_5b3a4570324587cd freescriptable();
    }
    
    if ( self.scriptable_covers.size > 0 )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.scriptable_covers );
    }
    
    ob_activity_utility::ob_disable_cover_nodes();
}

/#

    // Namespace ob_activity_heli_takedown
    // Params 0
    // Checksum 0xf8973326, Offset: 0xd27
    // Size: 0x5, Type: dev
    function function_be29b3206f10bd28()
    {
        
    }

#/

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x5a6034c3, Offset: 0xd34
// Size: 0xeb
function function_7e4c27cb65d41473()
{
    self endon( #"activity_ended" );
    radiant_struct = utility::getstruct( self.varianttag + "_RADIANT", "targetname" );
    var_3543973e66a36661 = radiant_struct.target;
    
    if ( var_3543973e66a36661 )
    {
        self.var_f783b83a4994c799 = activity_ai_encounters::function_92b671064b0b1ce2( var_3543973e66a36661, 1, 1, 1, 2 );
        
        if ( isdefined( self.var_f783b83a4994c799 ) )
        {
            activity_ai_encounters::function_52d1342183200a8f( self.var_f783b83a4994c799, &function_254b3fbce32336a, self );
            activity_ai_encounters::function_6bf4ff2fbde584ee( self.var_f783b83a4994c799, &function_479f79b7006d76df, self );
            function_1a9d724a960fa19d( self.var_f783b83a4994c799, region_difficulty_manager::get_region_difficulty( self.start_location.origin ), 1 );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x6b>" + self.varianttag );
    activity_instance_common::function_9aeeabe50fc9cc3e( self );
}

// Namespace ob_activity_heli_takedown
// Params 4
// Checksum 0x7c971c25, Offset: 0xe27
// Size: 0x107
function function_254b3fbce32336a( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    
    if ( isalive( agent ) )
    {
        ob_activity_utility::setup_dawg_on_spawned( agent );
        activityinstance = userdata;
        activityinstance endon( #"activity_ended" );
        activityinstance.var_223e3733b267b175[ activityinstance.var_223e3733b267b175.size ] = agent;
        var_5a1054ece784d718 = undefined;
        var_e77567b7ebad286 = "sg_" + activityinstance.varianttag + "_" + requestid;
        var_5a1054ece784d718 = function_ff2498f19618e5fa( var_e77567b7ebad286 );
        
        if ( !isdefined( var_5a1054ece784d718 ) )
        {
            var_5a1054ece784d718 = stealthinitgroup( var_e77567b7ebad286 );
        }
        
        stealthaddtogroup( var_e77567b7ebad286, agent );
        agent thread function_afaafc0114d56ae8( activityinstance );
        
        if ( arraycontains( strtok( agent.classname, "_" ), "rocketeer" ) )
        {
            agent.var_e94a0381e288005e = #"vtol_takedown_rocketeer";
        }
    }
}

// Namespace ob_activity_heli_takedown
// Params 3
// Checksum 0xb6086cfc, Offset: 0xf36
// Size: 0x53
function function_479f79b7006d76df( requestid, userdata, data )
{
    activityinstance = userdata;
    
    if ( isdefined( activityinstance.var_2a47db6ce749f4a9 ) )
    {
        activityinstance.var_2a47db6ce749f4a9.var_e038900b11ddf286 = 1;
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x767923f8, Offset: 0xf91
// Size: 0x148
function function_78df2951bc6b1cef()
{
    self endon( #"activity_ended" );
    var_ec53abb317948a11 = undefined;
    
    while ( true )
    {
        self waittill( #"player_attacking", player );
        self.lastattackedtime = gettime();
        
        if ( isdefined( player ) )
        {
            if ( player == var_ec53abb317948a11 )
            {
                wait 1;
                continue;
            }
            
            self.var_223e3733b267b175 = utility::array_removedead_or_dying( self.var_223e3733b267b175 );
            
            foreach ( soldier in self.var_223e3733b267b175 )
            {
                if ( isdefined( soldier ) && !isdefined( soldier.enemy ) )
                {
                    soldier notify( #"startCombatRush" );
                    soldier aieventlistenerevent( "combat", player, player.origin );
                    soldier.favoriteenemy = player;
                    soldier getenemyinfo( player );
                    soldier forcethreatupdate();
                    waitframe();
                }
            }
            
            var_ec53abb317948a11 = player;
        }
        
        wait 1;
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x97db5ee1, Offset: 0x10e1
// Size: 0x9e
function function_afaafc0114d56ae8( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"heli_escaped" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        activityinstance notify( #"combat" );
        
        if ( arraycontains( level.players, attacker ) )
        {
            activityinstance notify( #"player_attacking", attacker );
        }
        
        wait 1;
    }
}

/#

    // Namespace ob_activity_heli_takedown
    // Params 0
    // Checksum 0x183dda47, Offset: 0x1187
    // Size: 0x5, Type: dev
    function function_8213dd7f1c1f55b2()
    {
        
    }

#/

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x48d475fd, Offset: 0x1194
// Size: 0x92
function function_fb53b392296c145c()
{
    level.var_60312a4146f172ee = getdvarint( @"hash_4ed011e73d5fe128", 20 );
    level.var_328258b5444888ed = getdvarint( @"hash_8e9196a150ff178b", 5 );
    level.var_595350916585c0f8 = getdvarint( @"hash_a0faa1bae8a03262", 5 );
    level.var_4211d1e162e82fb2 = getdvarint( @"hash_4cbf527d204f6c90", 40 );
    level.var_76d7e14e4d6491e9 = getdvarint( @"hash_b73bf2c1f68b9363", 5 );
    level.var_6110fc2f90352874 = getdvarint( @"hash_4e3ef6c3a26505a", 10 );
}

// Namespace ob_activity_heli_takedown
// Params 3
// Checksum 0xcff6e6a, Offset: 0x122e
// Size: 0x489
function heli_takedown_heli_spawn( heli_ref = %"hash_3de08ee4ce53144f", var_ce77771bd81d50c7 = 1, mid_air_spawn = 0 )
{
    self endon( #"activity_ended" );
    assert( isdefined( self.start_location ), "<dev string:x99>" + self.varianttag );
    self.start_location.origin += ( 0, 0, 10 );
    self.var_2a47db6ce749f4a9 = namespace_28acf6540b1bc740::heli_spawn_simple( self.start_location, heli_ref, !mid_air_spawn, 1 );
    self.var_2a47db6ce749f4a9.maxarmorhealth = -1;
    self.var_2a47db6ce749f4a9.var_8839162ef17bfbc1 = 1;
    self.var_2a47db6ce749f4a9.flaresreservecount = 3;
    self.var_2a47db6ce749f4a9.flareslive = [];
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        self.var_2a47db6ce749f4a9 thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &function_95a0f194fa02e69c );
    }
    
    self.var_2a47db6ce749f4a9 forcenetfieldhighlod( 1 );
    self.var_2a47db6ce749f4a9 vehicleshowonminimap( 0 );
    self.var_2a47db6ce749f4a9 thread function_ff5870f68a2a6d1f( 1, mid_air_spawn );
    
    if ( !is_supply_chain() )
    {
        self.var_2a47db6ce749f4a9.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_heli_takedown_marker", 1, 0 );
        self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.start_location.origin );
        hovercardid = ob_activity_definition_utils::function_5620c3a2241ef9c5( self, %"hovercard:hovercard_sat_ob_vtol_takedown_objective_marker" );
        objidpoolmanager::function_1a27e9b999215f16( self.var_2a47db6ce749f4a9.objidnum, hovercardid );
        objidpoolmanager::update_objective_onentity( self.var_2a47db6ce749f4a9.objidnum, self.var_2a47db6ce749f4a9 );
    }
    
    if ( !isdefined( self.var_2a47db6ce749f4a9.deathcallbacks ) )
    {
        self.var_2a47db6ce749f4a9.deathcallbacks = [];
    }
    
    helitakedown_lowhealth = getdvarint( @"helitakedown_lowhealth", 0 );
    
    if ( helitakedown_lowhealth == 1 )
    {
        self.var_2a47db6ce749f4a9.health = int( self.var_2a47db6ce749f4a9.health * 0.25 );
    }
    
    self.var_2a47db6ce749f4a9 setmaxpitchroll( 15, 15 );
    self.var_2a47db6ce749f4a9 setneargoalnotifydist( 128 );
    self.var_2a47db6ce749f4a9 setturningability( 0.02 );
    self.var_2a47db6ce749f4a9.hover_min_height = 0;
    self.var_2a47db6ce749f4a9.heightoffset = ( 0, 0, 0 );
    self.var_2a47db6ce749f4a9.damagestate = 0;
    self.var_2a47db6ce749f4a9.var_c3c4d711e69d5ab9 = 1;
    healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_6ed4fde0ed0bcf9b" );
    self.var_2a47db6ce749f4a9.healthbarsettingsid = healthbarsettingsid;
    self.var_2a47db6ce749f4a9.var_24954f14e27b448d = 1;
    waitframe();
    self.var_5b3a4570324587cd = self.var_2a47db6ce749f4a9 function_78633a5ecb80b183( self );
    self.var_2a47db6ce749f4a9.crate = self.var_5b3a4570324587cd;
    self.var_2a47db6ce749f4a9.var_dc64ea91291dad76 = self.var_2a47db6ce749f4a9 setup_ramp();
    vehicleref = self.var_2a47db6ce749f4a9 vehicle::get_ref();
    vehicle_damage::set_post_mod_damage_callback( vehicleref, &function_be2e13be460159ba );
    
    if ( var_ce77771bd81d50c7 )
    {
        if ( !is_supply_chain() )
        {
            thread activity_participation::function_d041ee0ec570299d( self.var_2a47db6ce749f4a9 );
            self.var_2a47db6ce749f4a9 thread function_652e2a9f2312e37a( self );
        }
        
        self.var_2a47db6ce749f4a9 thread function_8096d41efe549f14( self );
        self.var_2a47db6ce749f4a9 thread function_80560cff98222b02( self );
        self.var_2a47db6ce749f4a9 thread function_5ef0d9a6be31142e( self );
        ob_resource_manager::activity_register_vehicle( self.var_2a47db6ce749f4a9 );
    }
}

// Namespace ob_activity_heli_takedown
// Params 2
// Checksum 0x33fda58f, Offset: 0x16bf
// Size: 0x15
function function_bbf2651b65359bdb( oldstateref, data )
{
    
}

// Namespace ob_activity_heli_takedown
// Params 2
// Checksum 0xb2993b30, Offset: 0x16dc
// Size: 0xac
function function_ff5870f68a2a6d1f( delay, mid_air_spawn )
{
    self endon( #"death" );
    
    if ( !mid_air_spawn )
    {
        wait delay;
    }
    
    self setscriptablepartstate( "blinking_lights", "on", 0 );
    self setscriptablepartstate( "interior_light", "on", 0 );
    self setscriptablepartstate( "pilot_cockpit_light", "on", 0 );
    self setscriptablepartstate( "co_pilot_cockpit_light", "on", 0 );
    
    if ( !mid_air_spawn )
    {
        self setscriptablepartstate( "landing_gear", "down", 1 );
        self setscriptablepartstate( "thrusters", "vertical", 1 );
        return;
    }
    
    self setscriptablepartstate( "engine", "booster", 0 );
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0xe6e856c5, Offset: 0x1790
// Size: 0xee
function function_652e2a9f2312e37a( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    self endon( #"death" );
    heli_takeoff_dist_sqr = ( self.heli_takeoff_dist_sqr ?? 3000 ) * 3000;
    
    while ( true )
    {
        foreach ( player in activityinstance.playerparticipants )
        {
            if ( distance2dsquared( player.origin, self.origin ) < heli_takeoff_dist_sqr )
            {
                activityinstance notify( #"player_in_takeoff_distance" );
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0xe3a4316e, Offset: 0x1886
// Size: 0xb2
function function_78633a5ecb80b183( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    heli_tag = "tag_interior";
    crate_offset = -110;
    crate_position = self gettagorigin( heli_tag ) + ( 0, 0, crate_offset );
    crate = spawnscriptable( "sat_ob_vtol_crate_attached", crate_position );
    crate.angles = self.angles;
    var_61f05a26f7857951 = coordtransformtranspose( crate_position, self.origin, self.angles );
    crate scriptablesetparententity( self, var_61f05a26f7857951, ( 0, 0, 0 ) );
    return crate;
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x5c16c4e8, Offset: 0x1941
// Size: 0xcc
function function_8096d41efe549f14( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    var_6cae0d23eff456e6 = 384;
    
    if ( isdefined( activityinstance.var_18910046ae5f697.radius ) )
    {
        var_6cae0d23eff456e6 = activityinstance.var_18910046ae5f697.radius;
    }
    
    activityinstance.str_badplace_name = "bp_" + activityinstance.varianttag;
    badplace_cylinder( activityinstance.str_badplace_name, -1, activityinstance.var_18910046ae5f697.origin, var_6cae0d23eff456e6, 256, "team_hundred_ninety", "team_two_hundred" );
    utility::waittill_any( "death", "takeoff" );
    badplace_delete( activityinstance.str_badplace_name );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x4c93736, Offset: 0x1a15
// Size: 0x39
function function_43dfd86524c78b6d()
{
    self endon( #"activity_ended" );
    self.var_2a47db6ce749f4a9 endon( #"death" );
    wait 120;
    self.var_2a47db6ce749f4a9 notify( #"leaving" );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x1d256740, Offset: 0x1a56
// Size: 0x14a
function function_95401236ea7e4f70()
{
    self.var_2a47db6ce749f4a9 endon( #"death" );
    self.var_2a47db6ce749f4a9 setrotorsactive( 1 );
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "on_main", 0 );
    self.var_2a47db6ce749f4a9 playsound( "veh_vtol_ob_takeoff_far" );
    wait 1.5;
    self.var_2a47db6ce749f4a9 vehicle_occupancy::turn_engine_on();
    self.var_2a47db6ce749f4a9 vehicle_occupancy::function_474d87fe62493d22();
    self.var_2a47db6ce749f4a9 setrotorsactive( 1 );
    hover_pos = self.start_location.origin + ( 0, 0, 300 );
    self.var_2a47db6ce749f4a9 setyawspeed( 10, 10 );
    self.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::function_7fb408948b1225e0( hover_pos, 1, undefined, 1, self.var_2a47db6ce749f4a9.angles[ 1 ] + 45, 1, 5, 5, undefined, undefined, 1 );
    self.var_2a47db6ce749f4a9 sethoverparams( 35, 35, 35 );
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "thrusters", "dynamic", 0 );
    childthread function_79384fadf2c4cf26();
    self.var_2a47db6ce749f4a9 waittill( #"goal" );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xeef62d8, Offset: 0x1ba8
// Size: 0x4a
function function_79384fadf2c4cf26()
{
    wait 1;
    self.var_2a47db6ce749f4a9 setrotorsactive( 1 );
    wait 3;
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "landing_gear", "up", 0 );
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "flaps", "on", 0 );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xa48fc6b7, Offset: 0x1bfa
// Size: 0x28e
function function_e016f8e40b55e835()
{
    self.var_2a47db6ce749f4a9 endon( #"death" );
    
    /#
        iprintlnbold( "<dev string:xed>" );
    #/
    
    var_f0a264ca52a727a1 = utility::getstruct( self.start_location.target, "targetname" );
    self.var_2a47db6ce749f4a9 notify( #"takeoff" );
    self.var_2a47db6ce749f4a9 setyawspeed( 100, 25, 25, 0.1 );
    self.var_2a47db6ce749f4a9.var_66985f8f48b0cef7 = 0;
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "flaps", "off", 0 );
    self.var_2a47db6ce749f4a9.state = "climb";
    self.var_2a47db6ce749f4a9.var_c3c4d711e69d5ab9 = 0;
    self.var_2a47db6ce749f4a9 namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_f0a264ca52a727a1, 0, undefined, 1, self.var_2a47db6ce749f4a9.angles[ 1 ], 0, level.var_60312a4146f172ee, level.var_328258b5444888ed );
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "on_all", 0 );
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "thrusters", "horizontal", 0 );
    self.var_2a47db6ce749f4a9.speed = level.var_4211d1e162e82fb2;
    self.var_2a47db6ce749f4a9.state = "escape";
    
    if ( !self.var_2a47db6ce749f4a9.is_speed_overridden )
    {
        self.var_2a47db6ce749f4a9 vehicle_setspeed( level.var_4211d1e162e82fb2, level.var_76d7e14e4d6491e9, level.var_6110fc2f90352874 );
    }
    
    self.var_2a47db6ce749f4a9 vehicle_allowplayerstandon( 0 );
    self.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::action_follow_path( var_f0a264ca52a727a1, undefined, undefined, undefined, 1 );
    self.var_2a47db6ce749f4a9 utility::waittill_any( "leaving", "follow_path_complete" );
    self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "booster", 0 );
    self.var_2a47db6ce749f4a9 thread vehicle::godon();
    waitframe();
    self notify( #"heli_escaped" );
    self.var_2a47db6ce749f4a9.state = "flee";
    self.var_2a47db6ce749f4a9 thread function_ec2bfddde8f4bf8d();
    
    /#
        iprintlnbold( "<dev string:x10d>" );
    #/
    
    if ( activity_instance_common::getactivitytype( self ) == "REV_OB_HELI_TAKEDOWN" )
    {
        ob_activity_utility::function_894ac80e038636c5( "wcavtolfail" );
        activity_instance_common::endactivity( self, 0 );
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xa69651b5, Offset: 0x1e90
// Size: 0x29e
function function_38600f3ed402332f()
{
    self endon( #"activity_ended" );
    self.var_2a47db6ce749f4a9 endon( #"death" );
    
    /#
        if ( self.var_2a47db6ce749f4a9.var_d74745d8ad920b40 )
        {
            iprintlnbold( "<dev string:x12a>" );
            return;
        }
        
        iprintlnbold( "<dev string:xed>" );
    #/
    
    if ( self.using_vtol )
    {
        self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "booster", 0 );
        wait 2;
    }
    
    var_f0a264ca52a727a1 = utility::getstruct( self.start_location.target, "targetname" );
    self.var_2a47db6ce749f4a9.state = "climb";
    self.var_2a47db6ce749f4a9.var_c3c4d711e69d5ab9 = 0;
    self.var_2a47db6ce749f4a9.speed = level.var_60312a4146f172ee;
    self.var_2a47db6ce749f4a9 vehicle_setspeed( level.var_60312a4146f172ee, level.var_328258b5444888ed, level.var_595350916585c0f8 );
    self.var_2a47db6ce749f4a9 notify( #"takeoff" );
    self.var_2a47db6ce749f4a9.var_66985f8f48b0cef7 = 0;
    self.var_2a47db6ce749f4a9 namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_f0a264ca52a727a1, 0, undefined, 1 );
    self.var_2a47db6ce749f4a9.speed = level.var_60312a4146f172ee;
    self.var_2a47db6ce749f4a9.state = "escape";
    self.var_2a47db6ce749f4a9 vehicle_setspeed( level.var_4211d1e162e82fb2, level.var_76d7e14e4d6491e9, level.var_6110fc2f90352874 );
    
    if ( self.using_vtol )
    {
        self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine_vector", "horizontal", 0 );
        self.var_2a47db6ce749f4a9 setscriptablepartstate( "flaps", "off", 0 );
    }
    
    self.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::action_follow_path( var_f0a264ca52a727a1 );
    self.var_2a47db6ce749f4a9 utility::waittill_any( "leaving", "follow_path_complete" );
    self.var_2a47db6ce749f4a9 thread vehicle::godon();
    
    /#
        iprintlnbold( "<dev string:x10d>" );
    #/
    
    self.var_2a47db6ce749f4a9.state = "flee";
    waitframe();
    self notify( #"heli_escaped" );
    self.var_2a47db6ce749f4a9 notify( #"heli_escaped" );
    self.var_2a47db6ce749f4a9 thread function_ec2bfddde8f4bf8d();
    
    if ( activity_instance_common::getactivitytype( self ) == "REV_OB_HELI_TAKEDOWN" )
    {
        activity_instance_common::endactivity( self, 0 );
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x5f0b97c1, Offset: 0x2136
// Size: 0x10f
function function_ec2bfddde8f4bf8d()
{
    self endon( #"death" );
    self.var_c3c4d711e69d5ab9 = 1;
    
    if ( self.var_2a47db6ce749f4a9.is_speed_overridden )
    {
        self notify( #"vtol_flee" );
        vehicle_hack::function_719a8b957386c2a6( 1 );
        self.is_speed_overridden = undefined;
        self.hack_speed_scale = undefined;
        self.var_677dfac95a9a8a5f = undefined;
    }
    
    var_bc91c47077ce6461 = anglestoforward( self.angles ) * 30000;
    var_1bec7f7a50506bdd = self.origin + ( var_bc91c47077ce6461[ 0 ], var_bc91c47077ce6461[ 1 ], 750 );
    namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_1bec7f7a50506bdd, 0, undefined, 1, undefined, 0, 800, 100 );
    thread vehicle::godoff();
    waitframe();
    
    if ( isdefined( self.crate ) )
    {
        self.crate freescriptable();
    }
    
    self notify( #"choppersupport_gone" );
    self.dontspawnhusk = 1;
    
    if ( self.var_dc64ea91291dad76 )
    {
        self.var_dc64ea91291dad76 delete();
    }
    
    level thread vehicle::death( self );
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x3480fcad, Offset: 0x224d
// Size: 0x201
function function_80560cff98222b02( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"heli_escaped" );
    self waittill( #"death", attacker, meansofdeath );
    
    /#
        iprintlnbold( "<dev string:x15b>" );
    #/
    
    activityinstance ob_activity_utility::function_894ac80e038636c5( "directhit" );
    v_drop_pos = namespace_28acf6540b1bc740::heli_finddroplocation( self.origin );
    
    if ( isdefined( self.crate ) )
    {
        var_9a77cc5a4611d58 = self.crate.origin;
        v_angles = self.crate.angles;
        self.crate freescriptable();
    }
    else
    {
        var_9a77cc5a4611d58 = self.origin + ( 0, 0, -30 );
        v_angles = self.angles;
        
        if ( !isdefined( v_angles ) )
        {
            v_angles = ( 0, 0, 0 );
        }
    }
    
    /#
        iprintlnbold( "<dev string:x179>" );
    #/
    
    if ( !isdefined( attacker ) )
    {
        if ( isdefined( activityinstance.playerparticipants ) && activityinstance.playerparticipants.size > 0 )
        {
            attacker = activityinstance.playerparticipants[ 0 ];
        }
        else
        {
            attacker = level.players[ 0 ];
        }
    }
    
    data = spawnstruct();
    data.streakname = "precision_airstrike";
    data.supportsreroll = 0;
    activity_definition_utils::updateprogress( 1, activityinstance );
    self waittill( #"explode" );
    ob_activity_utility::drop_loot( activityinstance, "activity_vtol_takedown" );
    
    if ( self.var_dc64ea91291dad76 )
    {
        self.var_dc64ea91291dad76 delete();
    }
    
    waitframe();
    
    if ( activity_instance_common::getactivitytype( activityinstance ) == "REV_OB_HELI_TAKEDOWN" )
    {
        activityinstance ob_activity_utility::function_894ac80e038636c5( "wcavtolsuccess", undefined, undefined, undefined, undefined, &function_b1e030f72cee040e );
        activity_instance_common::endactivity( activityinstance, 1 );
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x89c237fc, Offset: 0x2456
// Size: 0x37
function function_b1e030f72cee040e( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcavtolsuccess_kagan" || var_73f4f05f29c6770a == "wcavtolsuccess_razor" )
    {
        return [ "activitiesvtolclapback", "activitiesvtollastword" ];
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x774ee733, Offset: 0x2496
// Size: 0xcf
function function_acc404a695902264()
{
    self endon( #"activity_ended" );
    struct_array = utility::getstructarray( "s_veh_" + self.varianttag, "targetname" );
    
    if ( struct_array.size > 0 )
    {
        if ( struct_array.size > 1 )
        {
            n_min_vehicles = int( min( struct_array.size, 1 ) );
            n_max_vehicles = int( min( struct_array.size, 3 ) );
            
            if ( n_max_vehicles > n_min_vehicles )
            {
                var_a3ac6fb908f611b0 = randomintrange( n_min_vehicles, n_max_vehicles );
            }
            else
            {
                var_a3ac6fb908f611b0 = n_min_vehicles;
            }
            
            var_49b1d4c03abc1262 = arrayrandomize( struct_array );
            structs_sliced = utility::array_slice( var_49b1d4c03abc1262, 0, var_a3ac6fb908f611b0 );
        }
        else
        {
            structs_sliced = struct_array;
        }
        
        ob_activity_utility::function_4ad66bfa02812252( "veh_sat_medium_truck_ob", structs_sliced, 3000 );
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x16734515, Offset: 0x256d
// Size: 0x179
function function_9d85e36cee9bd6bd( data )
{
    thrusterradius = 125;
    var_33b5b37d59099f58 = thrusterradius * 0.5;
    var_c7beb966f4f78b7f = thrusterradius * thrusterradius;
    tagoffset = anglestoright( self.angles ) * var_33b5b37d59099f58;
    var_f7620ec70e55c31e = self gettagorigin( "tag_engine_ri_rotate_animate" ) + tagoffset;
    var_f76218c70e55d91c = self gettagorigin( "tag_engine_le_rotate_animate" ) - tagoffset;
    
    /#
        var_4a177ab31c96cdef = getdvarint( @"hash_c9c5ab8ba6684356", 0 ) == 1;
    #/
    
    var_9a7859ec3774529a = getdvarfloat( @"hash_249bdfb019027017", 2 );
    
    if ( distancesquared( data.point, var_f7620ec70e55c31e ) < var_c7beb966f4f78b7f )
    {
        /#
            if ( var_4a177ab31c96cdef )
            {
                sphere( var_f7620ec70e55c31e, thrusterradius, ( 1, 1, 1 ), 1, 300 );
                iprintlnbold( "<dev string:x198>" );
            }
        #/
        
        data.damage *= var_9a7859ec3774529a;
        return;
    }
    
    if ( distancesquared( data.point, var_f76218c70e55d91c ) < var_c7beb966f4f78b7f )
    {
        /#
            if ( var_4a177ab31c96cdef )
            {
                sphere( var_f76218c70e55d91c, thrusterradius, ( 1, 1, 1 ), 1, 300 );
                iprintlnbold( "<dev string:x19f>" );
            }
        #/
        
        data.damage *= var_9a7859ec3774529a;
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x72f1d173, Offset: 0x26ee
// Size: 0x29, Type: bool
function function_be2e13be460159ba( data )
{
    function_9d85e36cee9bd6bd( data );
    damage_utility::function_723dcec170ec23be( data.attacker );
    return true;
}

// Namespace ob_activity_heli_takedown
// Params 4
// Checksum 0x188e3a7c, Offset: 0x2720
// Size: 0x159
function function_95a0f194fa02e69c( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) || !isdefined( missiletarget.var_66985f8f48b0cef7 ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        current_time = gettime();
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 && current_time - missiletarget.var_66985f8f48b0cef7 > 20000 )
        {
            missiletarget.var_66985f8f48b0cef7 = current_time;
            missiletarget.flaresreservecount--;
            missiletarget thread function_6723a9bc88dc2035( fxtagoverride );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            self.var_458d8d6ca334fa52 = 1;
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            level notify( #"flares", player );
            return;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0xc79fd006, Offset: 0x2881
// Size: 0xab
function function_6723a9bc88dc2035( fxtagoverride )
{
    self endon( #"death" );
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
    wait 2.5;
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
    wait 2.5;
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xd9767087, Offset: 0x2934
// Size: 0x28
function function_35df7482fb3f81()
{
    self endon( #"death" );
    wait 10;
    self.var_3336f45888f9c216 = 1;
    self.var_66985f8f48b0cef7 = -20000;
}

/#

    // Namespace ob_activity_heli_takedown
    // Params 0
    // Checksum 0xaab79c88, Offset: 0x2964
    // Size: 0x5, Type: dev
    function function_f38fa020c9a104ae()
    {
        
    }

#/

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0xb6a443d6, Offset: 0x2971
// Size: 0x26
function function_668d79b5bd8dca20()
{
    return isdefined( self.var_2a47db6ce749f4a9 ) ? self.var_2a47db6ce749f4a9.origin : undefined;
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x4797f12e, Offset: 0x29a0
// Size: 0x317
function function_5ef0d9a6be31142e( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"heli_escaped" );
    self endon( #"death" );
    var_120aa7d8a42087f6 = self.health * 0.3;
    var_bbc2f9e64b280be8 = self.health * 0.6;
    var_e27b40fc7b9fa533 = self.health * 0.3;
    var_9d54813ab10bf96a = 0;
    var_280d2ed48e35b13c = 0;
    var_f254106b536f51c7 = 0;
    
    if ( !isdefined( activityinstance.var_fda2b8f23081ab7e ) )
    {
        activityinstance.var_fda2b8f23081ab7e = [];
    }
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        activityinstance notify( #"combat" );
        current_time = gettime();
        
        if ( arraycontains( level.players, attacker ) )
        {
            activityinstance notify( #"player_attacking", attacker );
            
            if ( !activityinstance is_supply_chain() )
            {
                if ( !arraycontains( activityinstance.playerparticipants, attacker ) )
                {
                    if ( !arraycontains( activityinstance.var_fda2b8f23081ab7e, attacker ) )
                    {
                        activityinstance ob_activity_utility::function_894ac80e038636c5( "wcavtolbrief", [ attacker ] );
                        activityinstance.var_fda2b8f23081ab7e[ activityinstance.var_fda2b8f23081ab7e.size ] = attacker;
                    }
                    else
                    {
                        activityinstance ob_activity_utility::function_894ac80e038636c5( "wcavtolfight", [ attacker ] );
                    }
                    
                    activity_participation::function_bc67362dace4370c( activityinstance, attacker, "PlayerJoinedDamage" );
                }
                
                assert( self == activityinstance.var_2a47db6ce749f4a9 );
                squad_mates = attacker squad_utility::getsquadmembers();
                var_62194e33f1e2cad9 = -100000;
                
                foreach ( squad_mate in squad_mates )
                {
                    if ( squad_mate.var_22e4698c606f56f3 > var_62194e33f1e2cad9 )
                    {
                        var_62194e33f1e2cad9 = squad_mate.var_22e4698c606f56f3;
                    }
                }
                
                if ( current_time - var_62194e33f1e2cad9 > utility::function_4b74c15943231980( 120 ) )
                {
                    attacker calloutmarkerping::function_5d7b7302e94b97c2( self.objidnum, self.origin );
                    attacker.var_22e4698c606f56f3 = current_time;
                }
            }
        }
        
        if ( !var_280d2ed48e35b13c && self.health < var_bbc2f9e64b280be8 && !activityinstance.var_f642f2383c933550 )
        {
            activityinstance ob_activity_utility::function_894ac80e038636c5( "wcavtollow" );
            activityinstance.var_f642f2383c933550 = 1;
        }
        
        if ( !var_f254106b536f51c7 && self.health <= var_e27b40fc7b9fa533 )
        {
            activityinstance notify( #"takeoff_at_once" );
            var_f254106b536f51c7 = 1;
        }
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0xece5dd96, Offset: 0x2cbf
// Size: 0x142
function function_f53fcc31f8f76f72( max_pilots )
{
    var_7a9514a516d8f9ef = [ "c_sat_ava_opforce_grunt_guild_body_1", "c_sat_ava_opforce_grunt_guild_body_1" ];
    var_e882642c5a8f5ac9 = [ "iw9_mp_heli_palfa_seat_0_idle", "iw9_heli_palfa_seat_1_idle" ];
    var_e95121c0e4dc8c10 = [ "tag_seat_0", "tag_seat_1" ];
    self.pilots = [];
    max_pilots = isdefined( max_pilots ) ? min( max_pilots, var_e95121c0e4dc8c10.size ) : var_e95121c0e4dc8c10.size;
    pilot_count = 0;
    
    foreach ( i, var_40d811ae13304e9a in var_7a9514a516d8f9ef )
    {
        if ( pilot_count >= max_pilots )
        {
            break;
        }
        
        var_90d8386c4be2a54c = exfil::function_1ed3863eb7edf534( i, var_e95121c0e4dc8c10[ i ], var_e882642c5a8f5ac9[ i ], var_40d811ae13304e9a, "c_sat_ava_opforce_grunt_guild_head_1" );
        
        if ( isdefined( var_90d8386c4be2a54c ) )
        {
            self.pilots[ self.pilots.size ] = var_90d8386c4be2a54c;
            pilot_count++;
        }
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x961ba1c1, Offset: 0x2e09
// Size: 0xcc
function function_76fe109b4453884a( activityinstance )
{
    utility::waittill_any_ents( self, "death", activityinstance, "heli_escaped", activityinstance, "activity_ended", activityinstance, "instance_destroyed" );
    
    foreach ( pilot in self.pilots )
    {
        if ( isent( pilot ) )
        {
            if ( pilot.head )
            {
                pilot.head delete();
            }
            
            pilot delete();
        }
    }
}

/#

    // Namespace ob_activity_heli_takedown
    // Params 0
    // Checksum 0x9e6167b6, Offset: 0x2edd
    // Size: 0x5, Type: dev
    function function_a14483b98fdc7e3()
    {
        
    }

#/

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x6af0d696, Offset: 0x2eea
// Size: 0xe8
function function_2c052c6824ef56b0( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
    
    foreach ( player in player_list )
    {
        if ( isplayer( player ) )
        {
            if ( var_99e714060e093089 == "PlayerJoinedProximity" )
            {
                self notify( #"player_proximity", player );
                continue;
            }
            
            if ( var_99e714060e093089 == "PlayerJoinedDamage" )
            {
                self notify( #"player_attacking", player );
            }
        }
    }
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0xedc35a39, Offset: 0x2fda
// Size: 0x23
function function_fd5f1e5e3a926fa0( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_heli_takedown
// Params 1
// Checksum 0x2ec55261, Offset: 0x3005
// Size: 0xdd
function function_3759e05d0f006901( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( !isdefined( self.var_fda2b8f23081ab7e ) )
    {
        self.var_fda2b8f23081ab7e = [];
    }
    
    foreach ( player in player_list )
    {
        if ( !arraycontains( self.var_fda2b8f23081ab7e, player ) )
        {
            ob_activity_utility::function_894ac80e038636c5( "wcavtolbrief", [ player ] );
            self.var_fda2b8f23081ab7e[ self.var_fda2b8f23081ab7e.size ] = player;
        }
    }
}

// Namespace ob_activity_heli_takedown
// Params 0
// Checksum 0x6d79726a, Offset: 0x30ea
// Size: 0x47
function setup_heli_takedown_cover()
{
    self endon( #"activity_ended" );
    
    if ( isdefined( self.varianttag ) )
    {
        var_edd0cb6e9ee724e9 = "heli_takedown_cover_" + self.varianttag;
        self.scriptable_covers = ob_soldier_util::function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
    }
}

// Namespace ob_activity_heli_takedown
// Params 0, eflags: 0x4
// Checksum 0x80d57a1b, Offset: 0x3139
// Size: 0x11, Type: bool
function private is_supply_chain()
{
    return self.type == "REV_OB_SUPPLY_CHAIN";
}

// Namespace ob_activity_heli_takedown
// Params 0, eflags: 0x4
// Checksum 0x171f3ffa, Offset: 0x3153
// Size: 0x9e
function private setup_ramp()
{
    ramplocation = self gettagorigin( "tag_ramp_lower_animate" );
    rampangles = self gettagangles( "tag_ramp_lower_animate" );
    var_dc64ea91291dad76 = spawn( "script_model", ramplocation );
    var_dc64ea91291dad76.angles = rampangles;
    var_dc64ea91291dad76 setmodel( %"veh_sat_mil_air_vtol_buzzard_ramp_lower" );
    var_dc64ea91291dad76 linkto( self, "tag_ramp_lower_animate" );
    var_dc64ea91291dad76.parent = self;
    var_dc64ea91291dad76 thread damage::monitordamage( self.maxhealth, "none", &namespace_cf9a4f547edbca10::ramp_modifydamage, &namespace_cf9a4f547edbca10::ramp_modifydamage, 1 );
    return var_dc64ea91291dad76;
}

/#

    // Namespace ob_activity_heli_takedown
    // Params 2
    // Checksum 0x234ac9c3, Offset: 0x31fa
    // Size: 0x67, Type: dev
    function function_15d39375b20ff24a( hover_pos, ground_pos )
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        
        while ( true )
        {
            sphere( hover_pos, 120, ( 1, 1, 1 ), 0 );
            sphere( ground_pos, 20, ( 1, 0, 0 ), 0 );
            waitframe();
        }
    }

    // Namespace ob_activity_heli_takedown
    // Params 0
    // Checksum 0x951765a0, Offset: 0x3269
    // Size: 0x135, Type: dev
    function function_e7691700dab27162()
    {
        self endon( #"death" );
        var_5de21a10a873b53b = 0;
        var_5f9f663db6f0dea8 = 0;
        var_9f60eaf7ca90150b = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_9eb98fc4a75a6dd1", -1 ) >= 0 || getdvarint( @"hash_e03afb921342d89e", -1 ) >= 0 || getdvarint( @"hash_4071d301502f7a1d", -1 ) >= 0 )
            {
                r = getdvarint( @"hash_9eb98fc4a75a6dd1", -1 );
                s = getdvarint( @"hash_e03afb921342d89e", -1 );
                a = getdvarint( @"hash_4071d301502f7a1d", -1 );
                var_5de21a10a873b53b = r >= 0 ? r : var_5de21a10a873b53b;
                var_5f9f663db6f0dea8 = s >= 0 ? s : var_5f9f663db6f0dea8;
                var_9f60eaf7ca90150b = a >= 0 ? a : var_9f60eaf7ca90150b;
                self sethoverparams( var_5de21a10a873b53b, var_5f9f663db6f0dea8, var_9f60eaf7ca90150b );
                setdvar( @"hash_9eb98fc4a75a6dd1", -1 );
                setdvar( @"hash_e03afb921342d89e", -1 );
                setdvar( @"hash_4071d301502f7a1d", -1 );
            }
            
            wait 0.2;
        }
    }

#/
