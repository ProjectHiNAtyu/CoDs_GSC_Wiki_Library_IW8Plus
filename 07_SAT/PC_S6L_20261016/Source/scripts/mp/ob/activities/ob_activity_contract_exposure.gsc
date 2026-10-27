// scripts\mp\ob\activities\ob_activity_contract_exposure.gsc  (hash_6876c630ba81f56a.gscc) (size: 9461 Bytes / 0x24f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xad006f67 (2902486887)
// size ...... 9461 (0x24f5)
// includes .. 17  (offset: 0x22e1)
// strings ... 26  (offset: 0x2369)
// dev strs .. 2   (offset: 0x24dd)
// exports ... 30  (offset: 0x1539)
// cseg ...... 0x263 + 0x12d6 (0x1539)
// imports ... 78  (offset: 0x19e9)
// animtree1 . 0   (offset: 0x24f5)
// animtree2 . 0   (offset: 0x24f5)
#using script_22aa38b6bedad90a;
#using script_42808e5693e44510;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_cradle_gas_circle;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_contract_exposure;

// Namespace ob_activity_contract_exposure
// Params 0, eflags: 0x5
// Checksum 0xae66541b, Offset: 0x281
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ad5c1a12ef31e9d8", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_contract_exposure
// Params 0, eflags: 0x4
// Checksum 0xeb65e77d, Offset: 0x2aa
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_EXPOSURE", &exposure_activity_type_init );
}

// Namespace ob_activity_contract_exposure
// Params 0
// Checksum 0x19f100f5, Offset: 0x2c5
// Size: 0x8c
function exposure_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_EXPOSURE", 0, &exposure_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_EXPOSURE", 1, &exposure_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_EXPOSURE", 2, &exposure_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_EXPOSURE", 3, &exposure_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_EXPOSURE", 5, &function_604ee113c5bd624 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_6bc4b211e43c1c86, "REV_OB_EXPOSURE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_644aedcce70fef11, "REV_OB_EXPOSURE" );
}

// Namespace ob_activity_contract_exposure
// Params 0
// Checksum 0x440b58de, Offset: 0x359
// Size: 0x26d
function exposure_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.settings = self.var_91c91f4a631c481d.settings;
    self.master_struct = utility::getstruct( self.varianttag, "script_noteworthy" );
    self.relay_struct_array = [];
    self.relay_array = [];
    self.var_6f2c2b19e74a9ea4 = 0;
    self.var_55961aa35cc594fb = 0;
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.master_struct.origin );
    self.reward_spawn_location = self.master_struct.orign;
    
    foreach ( struct in utility::getstructarray( self.master_struct.target, "targetname" ) )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_3c41cfbf57ec62e3":
                self.relay_struct_array[ self.relay_struct_array.size ] = struct;
                break;
            default:
                assertmsg( "<dev string:x24>" + struct.origin + "<dev string:x40>" );
                break;
        }
    }
    
    waitframe();
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ activity_instance.id ] ?? [];
    
    foreach ( joininteract in activityjoininteracts )
    {
        joininteract.var_875dcaee89ecc840 = 1;
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_contract_exposure
// Params 0
// Checksum 0x4bca7459, Offset: 0x5ce
// Size: 0x84
function exposure_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    start_exposure();
    self waittill( #"exposure_finish" );
    
    if ( activity_instance.var_da46b4f296148eae )
    {
        thread extract_container();
    }
    else
    {
        activity_instance.container utility::function_32b24db3127bff40( "container", "exploded" );
    }
    
    activity_instance_common::endactivity( self, activity_instance.var_da46b4f296148eae );
}

// Namespace ob_activity_contract_exposure
// Params 4
// Checksum 0xb1143203, Offset: 0x65a
// Size: 0x94
function function_cf76c5654595b986( requestid, userdata, agent, data )
{
    activity_instance = userdata[ 0 ];
    gas_radius = ob_cradle_gas_circle::get_gas_circle_radius( activity_instance.boss_gas_circle );
    agent._blackboard.var_b213ded5043dfa2b = activity_instance.boss_gas_circle.origin;
    agent._blackboard.var_6a8c50efac75caa1 = gas_radius;
}

// Namespace ob_activity_contract_exposure
// Params 0
// Checksum 0xcba9a849, Offset: 0x6f6
// Size: 0x107
function start_exposure()
{
    activity_instance = self;
    container = spawnscriptable( "sat_ob_exposure_container", self.master_struct.origin, self.master_struct.angles );
    container.activity_instance = activity_instance;
    container.hitpoints = activity_instance.settings.var_42ee8a9f35be4195;
    activity_instance.container = container;
    interaction::register_scriptable_interact( activity_instance.container, &function_6fe0009db84663f8 );
    waitframe();
    container.var_dc21504e32f2eda6 = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_exposure", 0, 1 );
    objidpoolmanager::update_objective_position( container.var_dc21504e32f2eda6, container.origin + ( 0, 0, 60 ) );
    ob_contract_ui_widget::function_724ff866fa7fb742( "REV_OB_EXPOSURE_SIGNAL" );
    ob_contract_ui_widget::function_3b7d5e996ba0c975( ob_activity_definition_utils::function_e55fda458ce2c4cc( self ), self.playerparticipants );
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0xae247ebc, Offset: 0x805
// Size: 0x18d
function function_6fe0009db84663f8( player )
{
    activity_instance = self.activity_instance;
    self setscriptablepartstate( "container", "unusable" );
    
    if ( isdefined( self.var_dc21504e32f2eda6 ) )
    {
        activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_dc21504e32f2eda6 );
        self.var_dc21504e32f2eda6 = undefined;
    }
    
    foreach ( relay_struct in activity_instance.relay_struct_array )
    {
        relay = activity_instance relay_spawn( relay_struct );
        activity_instance.relay_array[ activity_instance.relay_array.size ] = relay;
        relay.elite_struct = utility::getstruct( relay_struct.target, "targetname" );
        ob_interactions_util::function_b2920b846a11242b( "sat_hacking_device_ob", relay, &function_ae6f6ca8aa7bcb36, undefined, &function_9452223c33fadd7c, 5 );
        activity_instance thread relay_active( relay );
    }
    
    activity_instance.active_relays = activity_instance.relay_array;
    activity_instance ob_contract_ui_widget::function_724ff866fa7fb742( "REV_OB_EXPOSURE" );
    activity_instance ob_contract_ui_widget::function_855fd697c30b090c( activity_instance.var_55961aa35cc594fb );
    activity_instance ob_contract_ui_widget::function_9025afff14ea9bee( activity_instance.relay_array.size );
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0x522040dc, Offset: 0x99a
// Size: 0x6c
function relay_spawn( spawn_struct )
{
    activity_instance = self;
    relay = spawnscriptable( "sat_ob_exposure_relay", spawn_struct.origin, spawn_struct.angles );
    relay.activity_instance = activity_instance;
    relay.interacted = 0;
    relay.detonated = 0;
    return relay;
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0x46f5211d, Offset: 0xa0f
// Size: 0x7c
function relay_active( relay )
{
    activity_instance = self;
    relay setscriptablepartstate( "body", "off" );
    activity_instance thread function_d75b51975c8b5879( relay );
    waitframe();
    relay.var_dc21504e32f2eda6 = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "jup_ob_objectivemarker_bigbounty", 0, 1 );
    objidpoolmanager::update_objective_position( relay.var_dc21504e32f2eda6, relay.origin + ( 0, 0, 60 ) );
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0x609c3c16, Offset: 0xa93
// Size: 0x4c
function function_9452223c33fadd7c( player )
{
    relay = self;
    
    if ( !relay.interacted )
    {
        relay.interacted = 1;
        relay.activity_instance.var_55961aa35cc594fb++;
    }
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0x7397f494, Offset: 0xae7
// Size: 0x152
function function_ae6f6ca8aa7bcb36( player )
{
    relay = self;
    relay setscriptablepartstate( "body", "complete" );
    relay setscriptablepartstate( "sound", "complete" );
    activity_instance = relay.activity_instance;
    
    if ( !relay.detonated )
    {
        relay.detonated = 1;
        activity_instance.var_6f2c2b19e74a9ea4++;
        activity_instance.active_relays = arrayremove( activity_instance.active_relays, relay );
        activity_instance ob_contract_ui_widget::function_855fd697c30b090c( activity_instance.var_55961aa35cc594fb );
        
        if ( isdefined( relay.var_dc21504e32f2eda6 ) )
        {
            activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( relay.var_dc21504e32f2eda6 );
            relay.var_dc21504e32f2eda6 = undefined;
        }
        
        if ( activity_instance.var_6f2c2b19e74a9ea4 == activity_instance.settings.var_ef503834529c5a1 )
        {
            activity_instance thread function_4a1ac974e77351b();
        }
        
        if ( activity_instance.var_6f2c2b19e74a9ea4 == activity_instance.relay_array.size )
        {
            activity_instance.reward_spawn_location = player.origin;
            activity_instance.var_da46b4f296148eae = 1;
            activity_instance notify( #"exposure_finish" );
        }
    }
}

// Namespace ob_activity_contract_exposure
// Params 0, eflags: 0x4
// Checksum 0xbff4401b, Offset: 0xc41
// Size: 0x4e
function private function_4a1ac974e77351b()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_contract_ui_widget::function_724ff866fa7fb742( "REV_OB_EXPOSURE_DEFEND" );
    ob_contract_ui_widget::function_855fd697c30b090c( self.var_55961aa35cc594fb );
    ob_contract_ui_widget::function_9025afff14ea9bee( self.relay_array.size );
    spawn_dawgs();
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0x21cd8968, Offset: 0xc97
// Size: 0x45
function function_d75b51975c8b5879( relay )
{
    activity_instance = self;
    self.encounterid = activity_ai_encounters::function_eb8506829193f5eb( %"hash_713ec925ba2ba57f", relay.origin, 400, 1, 0, 1, 0 );
}

// Namespace ob_activity_contract_exposure
// Params 0, eflags: 0x4
// Checksum 0x7540c023, Offset: 0xce4
// Size: 0x8d
function private spawn_dawgs()
{
    self.dawgs = [];
    self.var_2727dfa13c55f9f = 1;
    self.ai_request_id = activity_ai_encounters::function_eb8506829193f5eb( %"hash_5fff1938df15c57d", self.container.origin, 3000, 1, 0, 1, 0 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( self.ai_request_id, &function_52a665b1347c356b, self );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( self.ai_request_id, &should_spawn_dawgs, self );
    activity_ai_encounters::function_d33de057e760c97b( self.ai_request_id, &should_shutdown_dawgs, self );
}

// Namespace ob_activity_contract_exposure
// Params 2
// Checksum 0x7520eb71, Offset: 0xd79
// Size: 0xdd
function function_52a665b1347c356b( requestid, userdata )
{
    activity_instance = userdata;
    
    if ( !isdefined( activity_instance ) || activity_instance.state != "Active" )
    {
        logstring( "[Exposure] dawgs spawned but activity is not in active state!" );
    }
    
    data = function_9b649316adcccbaa( requestid );
    
    foreach ( agent in data.ai )
    {
        if ( isalive( agent ) )
        {
            on_dawg_spawned( requestid, activity_instance, agent );
        }
    }
}

// Namespace ob_activity_contract_exposure
// Params 3, eflags: 0x4
// Checksum 0x7a8dbd39, Offset: 0xe5e
// Size: 0x9e
function private on_dawg_spawned( requestid, activity_instance, dawg )
{
    activity_instance.dawgs = arraycombineunique( activity_instance.dawgs, [ dawg ] );
    dawg callback::add( #"on_ai_killed", &function_c3c80cac61e220d7, activity_instance );
    dawg thread function_ac037a3edabd85f9( activity_instance );
    dawg.activity_instance = activity_instance;
    dawg.ignoreall = 1;
    dawg setgoalpos( activity_instance.container.origin, 350 );
}

// Namespace ob_activity_contract_exposure
// Params 2
// Checksum 0x910963e2, Offset: 0xf04
// Size: 0x34, Type: bool
function should_spawn_dawgs( requestid, activity_instance )
{
    if ( activity_instance.var_2727dfa13c55f9f )
    {
        activity_instance.var_2727dfa13c55f9f = 0;
        return true;
    }
    
    return false;
}

// Namespace ob_activity_contract_exposure
// Params 2
// Checksum 0x214aa534, Offset: 0xf41
// Size: 0x16, Type: bool
function should_shutdown_dawgs( requestid, activity_instance )
{
    return false;
}

// Namespace ob_activity_contract_exposure
// Params 2, eflags: 0x4
// Checksum 0x8ac87765, Offset: 0xf60
// Size: 0x55
function private function_c3c80cac61e220d7( params, activity_instance )
{
    activity_instance.dawgs = arrayremove( activity_instance.dawgs, params.victim );
    
    if ( activity_instance.dawgs.size == 0 )
    {
        thread function_a6f28a8ded979190( activity_instance );
    }
}

// Namespace ob_activity_contract_exposure
// Params 1, eflags: 0x4
// Checksum 0xfc77ac8f, Offset: 0xfbd
// Size: 0x4a
function private function_a6f28a8ded979190( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait activity_instance.settings.var_6ce8edb034b6adf2;
    activity_instance.var_2727dfa13c55f9f = 1;
}

// Namespace ob_activity_contract_exposure
// Params 1, eflags: 0x4
// Checksum 0x46c719ad, Offset: 0x100f
// Size: 0x52
function private function_ac037a3edabd85f9( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"death" );
    utility::waittill_any( "goal", "goal_reached", "near_goal" );
    wait 1;
    thread dawg_auto_destruct();
}

// Namespace ob_activity_contract_exposure
// Params 0, eflags: 0x4
// Checksum 0x537b190c, Offset: 0x1069
// Size: 0xbd
function private dawg_auto_destruct()
{
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.script_parameters = spawnstruct();
    self.script_parameters.is_auto_destruct = 1;
    self dodamage( self.maxhealth, ( 0, 0, 0 ) );
    wait 2;
    activity_instance.container.hitpoints--;
    
    if ( activity_instance.container.hitpoints == 0 )
    {
        activity_instance.var_da46b4f296148eae = 0;
        activity_instance notify( #"exposure_finish" );
    }
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0xba64d15e, Offset: 0x112e
// Size: 0x119
function exposure_activity_ended( activity_succeeded )
{
    foreach ( relay in self.relay_array )
    {
        relay utility::function_32b24db3127bff40( "body", "destroyed" );
        relay utility::function_32b24db3127bff40( "sound", "complete" );
    }
    
    foreach ( dawg in self.dawgs )
    {
        dawg dawg_auto_destruct();
    }
}

// Namespace ob_activity_contract_exposure
// Params 0
// Checksum 0xe91a5811, Offset: 0x124f
// Size: 0x143
function exposure_activity_destroy()
{
    activity_instance = self;
    
    if ( self.container )
    {
        self.container freescriptable();
    }
    
    foreach ( dawg in self.dawgs )
    {
        dawg dawg_auto_destruct();
    }
    
    foreach ( relay in self.relay_array )
    {
        if ( isdefined( relay.var_dc21504e32f2eda6 ) )
        {
            activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( relay.var_dc21504e32f2eda6 );
            relay.var_dc21504e32f2eda6 = undefined;
        }
        
        relay freescriptable();
    }
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0xbf3f3489, Offset: 0x139a
// Size: 0x40
function function_604ee113c5bd624( relevantinfostruct )
{
    var_c786523ebe9c85c0 = 1;
    var_983974fc347bb3cb = ob_activity_rewards::function_f23d5e30cd73e104( self.reward_spawn_location, var_c786523ebe9c85c0, self.riftoffset );
    return var_983974fc347bb3cb;
}

// Namespace ob_activity_contract_exposure
// Params 0
// Checksum 0x7f650d3c, Offset: 0x13e3
// Size: 0xeb
function extract_container()
{
    extractheli = self.container namespace_2fa0d8ac31fa2ddc::function_96b46bf7cb30b361( self.container.origin, ( 424.201, 0, 200 ) );
    extractheli waittill( #"loop_wait" );
    waitframe();
    angles = self.container.angles - extractheli.angles;
    self.container utility::scriptable_setparententity( extractheli.crate, ( 0, 0, -205 ), angles );
    extractheli.readytoleave = 1;
    extractheli notify( #"hash_8182ff35fd9e24b8" );
    extractheli.crate playsoundonmovingent( "mp_dmz_cargo_delivery_hook" );
    extractheli waittill( #"entitydeleted" );
    self.container freescriptable();
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0x5eeb443d, Offset: 0x14d6
// Size: 0x38
function function_6bc4b211e43c1c86( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace ob_activity_contract_exposure
// Params 1
// Checksum 0xd8d556d1, Offset: 0x1516
// Size: 0x23
function function_644aedcce70fef11( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

