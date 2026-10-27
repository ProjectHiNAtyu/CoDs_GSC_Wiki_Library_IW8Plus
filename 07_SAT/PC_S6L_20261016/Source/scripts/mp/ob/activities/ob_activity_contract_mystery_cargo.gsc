// scripts\mp\ob\activities\ob_activity_contract_mystery_cargo.gsc  (hash_6b3cae34073ad571.gscc) (size: 15981 Bytes / 0x3e6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a1c08b6 (706480310)
// size ...... 15981 (0x3e6d)
// includes .. 26  (offset: 0x3b1d)
// strings ... 48  (offset: 0x3bed)
// dev strs .. 1   (offset: 0x3e61)
// exports ... 37  (offset: 0x2445)
// cseg ...... 0x451 + 0x1ff4 (0x2445)
// imports ... 147 (offset: 0x2a0d)
// animtree1 . 0   (offset: 0x3e6d)
// animtree2 . 0   (offset: 0x3e6d)
#using script_22aa38b6bedad90a;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_berserk;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\ai_behavior;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\ob_music;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_contract_mystery_cargo;

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x5
// Checksum 0x7a09fc2, Offset: 0x46f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c783d42d729135c9", #"activity_common", &function_74986478773bc543, undefined );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x20ef9683, Offset: 0x498
// Size: 0x13
function private function_74986478773bc543()
{
    activity_common::registeractivitytype( "REV_OB_MYSTERY_CARGO", &mystery_cargo_activity_type_init );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0
// Checksum 0x259b1aa4, Offset: 0x4b3
// Size: 0x10a
function mystery_cargo_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_MYSTERY_CARGO", 0, &mystery_cargo_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_MYSTERY_CARGO", 1, &mystery_cargo_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_MYSTERY_CARGO", 2, &mystery_cargo_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_MYSTERY_CARGO", 3, &mystery_cargo_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_MYSTERY_CARGO", 5, &function_53233ab5af5b39f9 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_c9b11ff444330c81, "REV_OB_MYSTERY_CARGO" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_c9b11ff444330c81, "REV_OB_MYSTERY_CARGO" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_4b55ce0113456ec6, "REV_OB_MYSTERY_CARGO" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_e9b21f217e341a73, "REV_OB_MYSTERY_CARGO" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_ed7bd71dd3c47b3d, "REV_OB_MYSTERY_CARGO" );
    utility::add_fx( "zombie_corpse_cleanup", "vfx_sat_wc_ai_cradle_soldier_death_01" );
    utility::registersharedfunc( "ob_mystery_cargo_hackable", #"hack", &function_ae4bc073b54e5c4 );
    scriptable::scriptable_addusedcallbackbypart( "interaction", &function_be237c977a7882d1 );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0
// Checksum 0xcfb0bf39, Offset: 0x5c5
// Size: 0x1e5
function mystery_cargo_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.masterstruct = utility::getstruct( self.varianttag, "script_noteworthy" );
    self.variantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.handler_list = [ "marshall", "karma" ];
    self.villain_list = [ "voss" ];
    self.lootlist = self.variantdefinition.loots.var_fded57a906944459.var_8fd0c4b7126384ce;
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.masterstruct.origin );
    self.var_73e9a88025b535ef = 1;
    self.var_f6fd7cb912ba8acc = [];
    level ob_music::function_859fd7ab75f367c2( self );
    
    switch ( self.difficulty_region )
    {
        case #"hash_af83e47edfa8900a":
            self.lootlist = self.variantdefinition.loots.var_2a3903fe77396bac.var_8fd0c4b7126384ce;
            break;
        case #"hash_5343b465e56ec9a4":
            self.lootlist = self.variantdefinition.loots.var_a10af3d6b2113d87.var_8fd0c4b7126384ce;
            break;
        case #"hash_651f76c0ad6741ec":
        case #"hash_c0250ffc2e87f2ff":
            self.lootlist = self.variantdefinition.loots.var_af4d91a169ad1dfa.var_8fd0c4b7126384ce;
            break;
        default:
            break;
    }
    
    function_91b750196c661bfc();
    spawn_cargo_container();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0
// Checksum 0x7ce5bd8, Offset: 0x7b2
// Size: 0x4d
function mystery_cargo_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    start_mystery_cargo();
    self waittill( #"mystery_cargo_finish" );
    ob_activity_utility::function_894ac80e038636c5( "wcpvemysterysuccess", undefined, undefined, undefined, undefined, &function_afe66eff7164d5d3 );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1
// Checksum 0x676d5004, Offset: 0x807
// Size: 0x2b
function function_afe66eff7164d5d3( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcpvemysterysuccess_voss" )
    {
        return [ "wcpvemysteryclapback", "wcpvemysterylastword" ];
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0
// Checksum 0xced71f7, Offset: 0x83b
// Size: 0x37
function mystery_cargo_activity_end()
{
    level ob_music::function_be4c0727a998b18b( self );
    
    if ( self.cargocontainer )
    {
        self.cargocontainer setscriptablepartstate( #"interaction", #"unusable" );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0
// Checksum 0xc41ee182, Offset: 0x87a
// Size: 0xab
function mystery_cargo_activity_destroy()
{
    level ob_music::function_be4c0727a998b18b( self );
    
    if ( self.cargocontainer )
    {
        destroynavobstacle( self.cargocontainer.navobstacleid );
        self.cargocontainer notify( #"hash_e640d417556308a2" );
        self.cargocontainer freescriptable();
        self.cargocontainer = undefined;
    }
    
    if ( self.cargoloot )
    {
        self.cargoloot freescriptable();
        self.cargoloot = undefined;
    }
    
    if ( self.abilitycase )
    {
        self.abilitycase freescriptable();
        self.abilitycase = undefined;
    }
    
    thread ob_flying_drone::entity_cleanup( undefined );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1
// Checksum 0xb982f811, Offset: 0x92d
// Size: 0x40
function function_53233ab5af5b39f9( relevantinfostruct )
{
    var_c786523ebe9c85c0 = 1;
    var_983974fc347bb3cb = ob_activity_rewards::function_f23d5e30cd73e104( self.rewardspawnlocation, var_c786523ebe9c85c0, self.riftoffset );
    return var_983974fc347bb3cb;
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x434494ac, Offset: 0x976
// Size: 0x23a
function private function_91b750196c661bfc()
{
    var_a0248ce218558d99 = self.variantdefinition.var_a0248ce218558d99;
    var_99c7fe6161238828 = self.variantdefinition.var_99c7fe6161238828;
    var_8eb22aaba3639ea6 = self.variantdefinition.var_8eb22aaba3639ea6;
    var_719ecd76d2637047 = var_99c7fe6161238828 + var_a0248ce218558d99 + var_8eb22aaba3639ea6;
    var_81fd845db78e8778 = randomint( var_719ecd76d2637047 ) + 1;
    var_657340629986de6d = [ { #spawnfunction:&function_da0e774c9b865470, #weight:var_a0248ce218558d99, #name:#"loot" }, { #spawnfunction:&function_2737b02bc2622f88, #weight:var_99c7fe6161238828, #name:#"boss" }, { #spawnfunction:&function_c8830c636a2a312d, #weight:var_8eb22aaba3639ea6, #name:#"drones" } ];
    
    /#
        var_fba62222d0901180 = getdvarint( @"hash_8507888a58a6f81e", -1 );
        
        if ( var_fba62222d0901180 >= 0 )
        {
            self.var_39b52ffb1dd661f9 = var_657340629986de6d[ var_fba62222d0901180 ].name;
            self.var_77566f5f1f28ffe3 = var_657340629986de6d[ var_fba62222d0901180 ].spawnfunction;
            return;
        }
    #/
    
    var_e6559cda3728e76 = 0;
    
    foreach ( variation in var_657340629986de6d )
    {
        var_e6559cda3728e76 += variation.weight;
        
        if ( var_81fd845db78e8778 <= var_e6559cda3728e76 )
        {
            self.var_39b52ffb1dd661f9 = variation.name;
            self.var_77566f5f1f28ffe3 = variation.spawnfunction;
            break;
        }
    }
    
    if ( !self.var_77566f5f1f28ffe3 )
    {
        assertmsg( "<dev string:x24>" );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x2c2a212f, Offset: 0xbb8
// Size: 0x3d
function private start_mystery_cargo()
{
    init_cargo_container_objective_marker();
    function_c31ab630a48e13();
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcamysteryboxbrief" );
    self.cargocontainer setscriptablepartstate( #"interaction", #"hackable" );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0xc838a4e9, Offset: 0xbfd
// Size: 0xe5
function private spawn_cargo_container()
{
    cargocontainer = spawnscriptable( %"sat_ob_mystery_cargo_container", self.masterstruct.origin, self.masterstruct.angles );
    cargocontainer.activityinstance = self;
    level spatial_zone_container::function_847140d2863dfbf8( self, "music_awareness_zone", cargocontainer.origin, 2500, 1 );
    cargocontainer setscriptablepartstate( #"container", self.var_39b52ffb1dd661f9 );
    cargocontainer.navobstacleid = function_8bf6c5fe849106c4( cargocontainer.origin, cargocontainer.angles, 6, 130, 100 );
    self.cargocontainer = cargocontainer;
    self.rewardspawnlocation = self.masterstruct.origin;
    self.var_c7966a62af5e7dca = 0;
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x7f54e8ce, Offset: 0xcea
// Size: 0xd1
function private init_cargo_container_objective_marker()
{
    cargocontainer = self.cargocontainer;
    cargocontainer.objectivemarker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "mystery_cargo_marker", 0, 1 );
    objidpoolmanager::update_objective_position( cargocontainer.objectivemarker, cargocontainer.origin + ( 0, 0, 125 ) );
    options = spawnstruct();
    options.maxprogress = 0;
    options.rewardamount = 100;
    options.timeremaining = 0;
    options.step = 0;
    ob_contract_ui_widget::function_bb923ce693c606f9( %"hash_50cfd6093ac9ec45", self.playerparticipants, options );
    ob_contract_ui_widget::function_3b7d5e996ba0c975( ob_activity_definition_utils::function_e55fda458ce2c4cc( self ), self.playerparticipants );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x5d9b7649, Offset: 0xdc3
// Size: 0x37
function private function_c31ab630a48e13()
{
    self.var_7947fa3a0f87237b = activity_ai_encounters::function_eb8506829193f5eb( %"hash_388f5746d00a39bb", self.masterstruct.origin, 500, 1, 0, 1, 2 );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 6, eflags: 0x4
// Checksum 0xcdffb863, Offset: 0xe02
// Size: 0xa8
function private function_be237c977a7882d1( cargocontainer, part, state, player, bautouse, usestring )
{
    activityinstance = cargocontainer.activityinstance;
    var_a8839a94f36d1f2e = isplayer( player ) && isalive( player ) && !player.inlaststand && !player isreloading() && !player isgestureplaying();
    
    if ( !activityinstance || !var_a8839a94f36d1f2e )
    {
        return;
    }
    
    cargocontainer thread function_205e28597a20c2ed( player );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0xeff1e94f, Offset: 0xeb2
// Size: 0x107
function private function_205e28597a20c2ed( player )
{
    if ( !player || !self )
    {
        return;
    }
    
    player endon( #"disconnect" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self disablescriptableplayeruse( player );
    activity_instance = self.activityinstance;
    
    if ( activity_instance.var_8b18b11557702694 )
    {
        activity_instance.rewardspawnlocation = activity_instance.playerparticipants[ 0 ].origin;
        activity_instance [[ activity_instance.var_77566f5f1f28ffe3 ]]();
        self setscriptablepartstate( #"container", "doors_open" );
        self setscriptablepartstate( #"interaction", #"unusable" );
        return;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 3, undefined, 1, 1, 1, -1, "ClinkInteractions" );
    self enablescriptableplayeruse( player );
    
    if ( var_fab006cdb4f6e516 )
    {
        function_ae4bc073b54e5c4( undefined, player );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 2, eflags: 0x4
// Checksum 0xd9186e13, Offset: 0xfc1
// Size: 0x6f
function private function_ae4bc073b54e5c4( hackeffect, attacker )
{
    if ( isdefined( attacker ) )
    {
        if ( self.cracking_started )
        {
            return;
        }
        
        self.cracking_started = 1;
        utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
        self.activityinstance spawn_helicopter_encounter();
        self.activityinstance function_e569da508cf1f185( self, attacker );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 2, eflags: 0x4
// Checksum 0x21f9a, Offset: 0x1038
// Size: 0x13b
function private function_e569da508cf1f185( cargocontainer, player )
{
    cargocontainer.trigger = spawn( "noent_volume_trigger_radius", cargocontainer.origin, 0, 500, 500 );
    ob_contract_ui_widget::function_33c02efd4a127b9e( 1, self.playerparticipants );
    cargocontainer setscriptablepartstate( #"interaction", #"unusable" );
    self.var_c7966a62af5e7dca = 1;
    cargocontainer thread function_5eca3afcbbdda087();
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcpvemysterywave" );
    var_76c6366eaf2d3b38 = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" );
    var_50055ffc7bf83dd3 = spatial_zone_container::function_231d9e91d8ef7b5f( var_76c6366eaf2d3b38[ 0 ] );
    game_utility::questcircle_create( "Search_Area_Contract_Ob", cargocontainer.origin, var_50055ffc7bf83dd3 );
    
    foreach ( player in self.playerparticipants )
    {
        game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x3db3903, Offset: 0x117b
// Size: 0x2d0
function private function_5eca3afcbbdda087()
{
    level endon( #"game_ended" );
    activityinstance = self.activityinstance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance endon( #"mystery_cargo_finish" );
    cargocontainer = activityinstance.cargocontainer;
    progresspercentage = 0;
    var_71a1b579936fe5d6 = 0;
    var_309549d1a1dc82c1 = 0;
    var_be36122ba0442589 = activityinstance.variantdefinition.var_be36122ba0442589;
    
    /#
        var_be36122ba0442589 = getdvarint( @"hash_5f3210438a03ad52", var_be36122ba0442589 );
    #/
    
    objidpoolmanager::objective_show_progress( cargocontainer.objectivemarker, 1 );
    
    while ( true )
    {
        if ( !activityinstance.var_6d780168574f32a3 )
        {
            var_71a1b579936fe5d6 += level.framedurationseconds;
            activityinstance.var_aa778d21f7d75252 = var_71a1b579936fe5d6;
            progresspercentage = clamp( var_71a1b579936fe5d6 / var_be36122ba0442589 * 100, 0, 100 );
            progresspercentage = int( progresspercentage );
            activityinstance ob_contract_ui_widget::setprogress( progresspercentage, 100, activityinstance.playerparticipants );
            objidpoolmanager::objective_set_progress( cargocontainer.objectivemarker, progresspercentage / 100 );
            
            if ( !var_309549d1a1dc82c1 && var_71a1b579936fe5d6 >= activityinstance.variantdefinition.var_ea197c323958358e )
            {
                activityinstance spawn_helicopter_encounter();
                var_309549d1a1dc82c1 = 1;
            }
            
            if ( var_71a1b579936fe5d6 >= var_be36122ba0442589 )
            {
                if ( activityinstance game_utility::questcircle_exists() )
                {
                    activityinstance game_utility::questcircle_delete();
                }
                
                activityinstance.var_8b18b11557702694 = 1;
                cargocontainer setscriptablepartstate( #"interaction", #"hash_7494895d08f1d3f9" );
                pos = activityinstance.masterstruct.origin + anglestoforward( activityinstance.masterstruct.angles ) * 60;
                objidpoolmanager::update_objective_position( cargocontainer.objectivemarker, pos + ( 0, 0, 50 ) );
                activityinstance ob_contract_ui_widget::setprogress( progresspercentage, 0, activityinstance.playerparticipants );
                activityinstance ob_contract_ui_widget::function_33c02efd4a127b9e( 2, activityinstance.playerparticipants );
                objidpoolmanager::objective_show_progress( cargocontainer.objectivemarker, 0 );
                
                foreach ( var_a464bb19566d7677 in activityinstance.var_f6fd7cb912ba8acc )
                {
                    ai_spawn_director::cancel_spawn_request( var_a464bb19566d7677, 0 );
                }
                
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0xb6cfd487, Offset: 0x1453
// Size: 0xc0
function private function_c9b11ff444330c81( relevantinfostruct )
{
    if ( !self.var_c7966a62af5e7dca )
    {
        return;
    }
    
    var_cada9626b9041434 = 0;
    
    foreach ( player in self.playerparticipants )
    {
        if ( self.var_aef199e9dadf99c2[ player.guid ] )
        {
            var_cada9626b9041434 = 1;
            break;
        }
    }
    
    self.var_6d780168574f32a3 = !var_cada9626b9041434;
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0xbe67433f, Offset: 0x151b
// Size: 0x95
function private function_49e414f330720db0( player_list )
{
    foreach ( player in player_list )
    {
        self.cargocontainer disablescriptableplayeruse( player );
    }
    
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0x4266c709, Offset: 0x15b8
// Size: 0x1e
function private function_e9b21f217e341a73( relevant_info_struct )
{
    function_49e414f330720db0( relevant_info_struct.playerlist );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0x7c8f496c, Offset: 0x15de
// Size: 0x3b
function private function_ed7bd71dd3c47b3d( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    function_49e414f330720db0( player_list );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcpvemysteryabandon", player_list );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0x361a8a62, Offset: 0x1621
// Size: 0x9a
function private function_4b55ce0113456ec6( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        self.cargocontainer enablescriptableplayeruse( player );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x3337909b, Offset: 0x16c3
// Size: 0x62
function private spawn_helicopter_encounter()
{
    var_a464bb19566d7677 = activity_ai_encounters::function_92b671064b0b1ce2( self.varianttag + string( self.var_73e9a88025b535ef ), 1, 0, 1, 2 );
    self.var_73e9a88025b535ef++;
    self.var_f6fd7cb912ba8acc[ self.var_f6fd7cb912ba8acc.size ] = var_a464bb19566d7677;
    ai_spawn_director::function_baa5d26d8804d5da( var_a464bb19566d7677, &function_d7a512983e93b1f5, self );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 4
// Checksum 0x715e236d, Offset: 0x172d
// Size: 0xe7
function function_d7a512983e93b1f5( requestid, userdata, agent, data )
{
    self endon( #"death" );
    activity_instance = userdata;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( self.stealth )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        self setstealthstate( "combat" );
        
        if ( self.nearbyplayers.size > 0 )
        {
            var_95b86e61b2c6a7 = utility::array_random( self.nearbyplayers );
            self getenemyinfo( var_95b86e61b2c6a7 );
            self.favoriteenemy = var_95b86e61b2c6a7;
            self forcethreatupdate();
        }
        
        cargocontainer = activity_instance.cargocontainer;
        thread ai_behavior::behavior_combatRushOrigin( self, cargocontainer.origin );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0xea4ae723, Offset: 0x181c
// Size: 0x2e6
function private function_c8830c636a2a312d()
{
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.cargocontainer.objectivemarker );
    ob_contract_ui_widget::function_33c02efd4a127b9e( 4, self.playerparticipants );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcpvemysterydrones" );
    ob_flying_drone::setup_helper_drones();
    spawnoptions = { #var_ab7bc43443a29388:1, #launchexplosion:0, #difficulty_region:self.difficulty_region, #var_2858c1d9ffae3f84:self.variantdefinition.var_2858c1d9ffae3f84, #canlootdrop:0, #canmove:0, #enableaimassist:1, #candamage:1 };
    var_fc680594a77c7eda = self.masterstruct.origin + anglestoforward( self.masterstruct.angles ) * 2;
    var_ce3dc4f05a55cd47 = self.masterstruct.origin + anglestoforward( self.masterstruct.angles ) * -1;
    var_5e7f460f58d8fec5 = var_fc680594a77c7eda + anglestoright( self.masterstruct.angles ) * 40;
    var_fd9f922ca902e75e = var_ce3dc4f05a55cd47 + anglestoright( self.masterstruct.angles ) * -40;
    var_3734ba7bc49a769d = var_5e7f460f58d8fec5 + ( 0, 0, 62.5 );
    var_d2e0a2e12384f1d6 = var_fd9f922ca902e75e + ( 0, 0, 62.5 );
    spawnposoffsets = [ var_3734ba7bc49a769d, var_d2e0a2e12384f1d6 ];
    self.dronescount = spawnposoffsets.size;
    
    for ( index = 0; index < self.dronescount ; index++ )
    {
        spawnoptions.spawnpos = spawnposoffsets[ index ];
        drone = ob_flying_drone::function_d664e23d9508b462( spawnoptions );
        rot = index == 0 ? ( 90, 0, 90 ) : ( 90, 0, 270 );
        drone rotateto( self.masterstruct.angles + rot, 0.01 );
        drone ob_flying_drone::function_b62d57c03a13139d();
        drone ob_flying_drone::function_c2373db857efa03( self.playerparticipants );
        thread ob_flying_drone::function_6395a1838cd983f5( drone );
        thread function_269d16b72101f64( drone );
        drone setscriptablepartstate( "sparks", "on" );
        drone.objectivemarker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "mystery_cargo_marker", 0, 1 );
        objidpoolmanager::update_objective_position( drone.objectivemarker, drone.origin + ( 0, 0, 25 ) );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0x50236604, Offset: 0x1b0a
// Size: 0x95
function private function_269d16b72101f64( drone )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    drone waittill( #"main_drone_destroyed" );
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( drone.objectivemarker );
    self.dronescount--;
    
    if ( self.dronescount <= 0 )
    {
        ob_flying_drone::function_a08f109bc062fffe();
        function_1f83519881fc294d( self.masterstruct.origin );
        self notify( #"mystery_cargo_finish" );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0xd6c0241d, Offset: 0x1ba7
// Size: 0x116
function private function_da0e774c9b865470()
{
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcpvemysteryloot" );
    forwardpos = self.masterstruct.origin + anglestoforward( self.masterstruct.angles ) * -37;
    totalpos = forwardpos + anglestoright( self.masterstruct.angles ) * -2;
    cargo_loot = common_cache::function_9bc018c1b8aad720( #"hash_aea9af15e079b779", totalpos + ( 0, 0, 15 ), self.masterstruct.angles + ( 0, 180, 0 ) );
    cargo_loot.activityinstance = self;
    cargo_loot.var_6e39895e14c70e34 = &function_30f4a9d3b94f89b1;
    self.cargoloot = cargo_loot;
    objidpoolmanager::update_objective_position( self.cargocontainer.objectivemarker, cargo_loot.origin + ( 0, 0, 50 ) );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 2, eflags: 0x4
// Checksum 0xef05b08b, Offset: 0x1cc5
// Size: 0x50
function private function_30f4a9d3b94f89b1( cargo, player )
{
    activity_instance = cargo.activityinstance;
    
    if ( activity_instance && activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_instance notify( #"mystery_cargo_finish" );
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x8a1d1a25, Offset: 0x1d1d
// Size: 0xbf
function private function_2737b02bc2622f88()
{
    boss_vos = [ "wcpvemysteryboss", "wcpvemysterycradle" ];
    var_4ca232b6685dd7cb = utility::array_random( boss_vos );
    ob_activity_vo_utility::function_639b0047db8aec67( self, var_4ca232b6685dd7cb );
    self.cargocontainer setscriptablepartstate( "cradle_gas", "on" );
    self.request_id = activity_ai_encounters::function_eb8506829193f5eb( %"hash_39fa56759c8007f9", self.masterstruct.origin, 0, 1, 0, 1, 2 );
    function_64ac8c4e752f4dca( self.request_id, 0 );
    ai_spawn_director::add_spawned_callback( self.request_id, &finished_spawning, self );
    ob_contract_ui_widget::function_33c02efd4a127b9e( 3, self.playerparticipants );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 4, eflags: 0x4
// Checksum 0xb90831f, Offset: 0x1de4
// Size: 0x181
function private finished_spawning( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    data.animscripted_alias = "no_anim";
    agent.var_50b2eb7be2a4c8b0 = 1;
    agent._blackboard.var_b213ded5043dfa2b = activity_instance.cargocontainer.origin;
    agent._blackboard.var_6a8c50efac75caa1 = 5000;
    targetloc = activity_instance.cargocontainer.origin + ( 0, 0, 25 );
    objectivemarker = activity_instance.cargocontainer.objectivemarker;
    agent forceteleport( targetloc, activity_instance.cargocontainer.angles );
    explosionfx = utility::getfx( "zombie_corpse_cleanup" );
    
    if ( explosionfx )
    {
        playfx( explosionfx, targetloc );
    }
    
    activity_instance thread function_77fa482d98d21b5d( agent, activity_instance.cargocontainer, activity_instance.cargocontainer.origin, activity_instance.cargocontainer.angles );
    activity_instance thread function_66a414d5281473dc( agent );
    objidpoolmanager::update_objective_onentity( objectivemarker, agent );
    objidpoolmanager::update_objective_setzoffset( objectivemarker, 100 );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 4, eflags: 0x4
// Checksum 0xb7a2d3a3, Offset: 0x1f6d
// Size: 0x181
function private function_77fa482d98d21b5d( enemy, cargocontainer, var_e9004e18b5e6ea67, var_7ffcd37e2f70bc29 )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    destroynavobstacle( cargocontainer.navobstacleid );
    enemy.ignoreall = 1;
    var_1d016b4edfbc212a = var_e9004e18b5e6ea67 + anglestoforward( cargocontainer.angles ) * 200;
    
    /#
        sphere( var_1d016b4edfbc212a, 30, ( 1, 0, 0 ), 0, int( 10 / level.framedurationseconds ) );
        line( enemy.origin, var_1d016b4edfbc212a, ( 1, 0, 0 ), 1, 0, int( 10 / level.framedurationseconds ) );
    #/
    
    enemy setbtgoalpos( 4, var_1d016b4edfbc212a );
    time = 3;
    
    if ( enemy.subclass == "zombie_mangler" )
    {
        enemy function_786bb6aa1b76c7ee( "show_berserk", 1 );
        wait 1.8;
        enemy thread namespace_ac69c03f7b7eefc2::function_dd6d54fa5b6feae8( 1, 0 );
        enemy thread function_42f06cd3a1352127();
        time = 1;
    }
    
    if ( isalive( enemy ) )
    {
        enemy utility::waittill_any_timeout( time, "goal", "death" );
        enemy clearbtgoal( 4 );
        enemy.ignoreall = 0;
    }
    
    cargocontainer.navobstacleid = function_8bf6c5fe849106c4( var_e9004e18b5e6ea67, var_7ffcd37e2f70bc29, 6, 130, 100 );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 0, eflags: 0x4
// Checksum 0x4a1adbdd, Offset: 0x20f6
// Size: 0x1f8
function private function_42f06cd3a1352127()
{
    self endon( #"death" );
    self endon( #"exit_berserk" );
    
    while ( isalive( self ) )
    {
        velocity = self.velocity;
        var_ec649bf9628b9bce = lengthsquared( velocity );
        var_a31efe9e906c523b = var_ec649bf9628b9bce >= 900;
        
        if ( var_a31efe9e906c523b )
        {
            var_e634391cd94f5e81 = 0.2;
            move_vector = velocity * var_e634391cd94f5e81;
            predicted_pos = self getcentroid() + move_vector;
            players = getplayersinradius( predicted_pos, 64 );
            
            foreach ( player in players )
            {
                if ( !isalive( player ) || player vehicle::is_in_vehicle() )
                {
                    continue;
                }
                
                facing_vec = anglestoforward( self.angles );
                enemy_vec = player.origin - self.origin;
                var_9daa30d9ff167aa7 = ( enemy_vec[ 0 ], enemy_vec[ 1 ], 0 );
                facing_yaw_vec = ( facing_vec[ 0 ], facing_vec[ 1 ], 0 );
                var_9daa30d9ff167aa7 = vectornormalize( var_9daa30d9ff167aa7 );
                facing_yaw_vec = vectornormalize( facing_yaw_vec );
                enemy_dot = vectordot( facing_yaw_vec, var_9daa30d9ff167aa7 );
                
                if ( enemy_dot < 0 )
                {
                    continue;
                }
                
                player playlocalsound( "melee_character_gunmed_pri_1_hit_npc" );
                player dodamage( 20, player.origin, self, undefined, "MOD_IMPACT" );
                player setvelocity( vectornormalize( player.origin - self.origin ) * 480 );
            }
        }
        
        wait 0.2;
    }
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0xa6c11b99, Offset: 0x22f6
// Size: 0x6a
function private function_66a414d5281473dc( ai )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ai waittill( #"death" );
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.cargocontainer.objectivemarker );
    function_1f83519881fc294d( ai.origin );
    self notify( #"mystery_cargo_finish" );
}

// Namespace ob_activity_contract_mystery_cargo
// Params 1, eflags: 0x4
// Checksum 0xccb7ee86, Offset: 0x2368
// Size: 0xdd
function private function_1f83519881fc294d( position )
{
    groundposition = getgroundposition( position, 1 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( groundposition );
    level common_item::function_38cde6a6acb68ea6( self.lootlist, 11, spawnoptions );
    ability_case_struct = utility::getstruct( "ability_case_" + self.varianttag, "targetname" );
    
    if ( ability_case_struct.origin )
    {
        self.abilitycase = utility::callsharedfunc( #"ability_case", #"spawn", ability_case_struct.origin, undefined, undefined, #"default", ability_case_struct.angles );
        
        if ( self.abilitycase )
        {
            self.abilitycase.dynamicoptions = 1;
        }
    }
}

