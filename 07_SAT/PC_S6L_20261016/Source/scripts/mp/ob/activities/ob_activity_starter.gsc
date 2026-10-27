// scripts\mp\ob\activities\ob_activity_starter.gsc  (hash_1f01ba433c716f7f.gscc) (size: 8983 Bytes / 0x2317 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7df03f0b (2112896779)
// size ...... 8983 (0x2317)
// includes .. 23  (offset: 0x20cb)
// strings ... 19  (offset: 0x2183)
// dev strs .. 12  (offset: 0x2283)
// exports ... 20  (offset: 0x148b)
// cseg ...... 0x227 + 0x1264 (0x148b)
// imports ... 78  (offset: 0x17ab)
// animtree1 . 0   (offset: 0x2317)
// animtree2 . 0   (offset: 0x2317)
#using scripts\anim\utility;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_objective_rewards;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\poi;
#using scripts\mp\rank;

#namespace ob_activity_starter;

// Namespace ob_activity_starter
// Params 0
// Checksum 0x2078be14, Offset: 0x245
// Size: 0xfd
function init_activity_starter()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    utility::flag_wait( "common_items_init" );
    common_item::function_4b30c091d3b04a25( "activitystarter" );
    common_item::function_84174b793b5fe9a7( "activitystarter", #"use", &function_ca1008a00c603258 );
    common_item::function_84174b793b5fe9a7( "activitystarter", #"canautouse", &function_4a0f3c1794b67700 );
    common_item::function_84174b793b5fe9a7( "activitystarter", #"hash_9e49dfaa7c147654", &function_7e1ef2bf7ff6cb97 );
    scriptable::scriptable_addusedcallbackbypart( "nexus_activity_joiner_phone", &function_155f215f9079002a );
    
    if ( isdefined( level.var_e607236b193eb0c1 ) && !isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
    {
        level.var_e607236b193eb0c1.var_9433e6119f67c877 = [];
        level.var_e607236b193eb0c1.var_ca2624de39435df5 = 1;
        callback::add( #"player_connect", &function_2211db4a758fb20b );
        
        /#
            level thread function_bc18ddce85eee3f9();
            level thread function_4cb8dfbde1a6a6ab();
        #/
    }
}

// Namespace ob_activity_starter
// Params 1, eflags: 0x4
// Checksum 0xb899f533, Offset: 0x34a
// Size: 0x13
function private function_2211db4a758fb20b( params )
{
    thread function_4035d49ae8d96ec();
}

// Namespace ob_activity_starter
// Params 1
// Checksum 0x88a507ec, Offset: 0x365
// Size: 0xb5
function function_366c395db7231a5e( var_2df5fe0a59c30a3c )
{
    activity_instance = var_2df5fe0a59c30a3c[ 0 ];
    activity_starters = var_2df5fe0a59c30a3c[ 1 ];
    
    foreach ( activity_starter in activity_starters )
    {
        if ( activity_instance.var_7b4b87ca9df65b73 )
        {
            thread function_45faf66b2ce46649( activity_instance, activity_starter );
            continue;
        }
        
        activate_activity_starter( activity_instance, activity_starter );
    }
}

// Namespace ob_activity_starter
// Params 2
// Checksum 0x1129838d, Offset: 0x422
// Size: 0x2d
function function_45faf66b2ce46649( activity_instance, activity_starter_scriptable )
{
    activity_instance waittill( #"activate_activity_starter" );
    activate_activity_starter( activity_instance, activity_starter_scriptable );
}

// Namespace ob_activity_starter
// Params 2
// Checksum 0xd378875f, Offset: 0x457
// Size: 0x12d
function activate_activity_starter( activity_instance, activity_starter_scriptable )
{
    if ( isdefined( activity_starter_scriptable ) )
    {
        var_ea54c0ab42a167ca = activity_starter_scriptable.origin;
        activity_starter_scriptable.var_ea54c0ab42a167ca = var_ea54c0ab42a167ca;
        activity_starter_scriptable.activity_instance = activity_instance;
        activity_instance.activity_starter_scriptable = activity_starter_scriptable;
        activity_starter_scriptable show_activity_starter();
        activitytype = activity_instance_common::getactivitytype( activity_instance );
        activity_starter_scriptable.poiindex = poi::function_98b6b43120545617( poi::function_c14b808f44505866( var_ea54c0ab42a167ca, 0, 0 ) );
        rewarddifficultyregion = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( activity_instance ) );
        scoreevent = namespace_34bb2a33b8502c64::get_score_event( activity_instance, rewarddifficultyregion );
        activity_starter_scriptable.var_3506f5fa83bec7a = rank::getscoreinfovalue( scoreevent );
        
        if ( !isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
        {
            level.var_e607236b193eb0c1.var_9433e6119f67c877 = [];
        }
        
        level.var_e607236b193eb0c1.var_9433e6119f67c877[ level.var_e607236b193eb0c1.var_9433e6119f67c877.size ] = activity_starter_scriptable;
    }
}

// Namespace ob_activity_starter
// Params 4
// Checksum 0x279c581, Offset: 0x58c
// Size: 0x304
function create_activity_starter( suffix, var_ea54c0ab42a167ca, var_c227859f4287d510, var_a55ddda07af89823 )
{
    assert( isdefined( suffix ) && isdefined( var_ea54c0ab42a167ca ) );
    activity_instance = self;
    var_3373cb87f51bc981 = isdefined( var_c227859f4287d510 ) ? squared( var_c227859f4287d510 ) : 0;
    var_59d90f46b4aff93c = isdefined( var_a55ddda07af89823 ) ? squared( var_a55ddda07af89823 ) : 0;
    var_dff4d7922372f56d = [];
    var_7ee9a290cba8690 = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "nexus_activity_joiner_phone" );
    var_7ee9a290cba8690 = function_79ffbc74a1f0ee58( var_7ee9a290cba8690 );
    
    foreach ( starter in var_7ee9a290cba8690 )
    {
        if ( suffix == getsubstr( starter.type, 24 ) )
        {
            var_dff4d7922372f56d[ var_dff4d7922372f56d.size ] = starter;
        }
    }
    
    activity_starter = undefined;
    var_a8317b4304c6bb2 = 999999999;
    
    foreach ( starter in var_dff4d7922372f56d )
    {
        dist = distancesquared( starter.origin, var_ea54c0ab42a167ca );
        diff = abs( dist - var_59d90f46b4aff93c );
        
        if ( diff < var_a8317b4304c6bb2 && dist >= var_3373cb87f51bc981 )
        {
            if ( diff < 150 )
            {
                activity_starter = starter;
                break;
            }
            
            activity_starter = starter;
            var_a8317b4304c6bb2 = diff;
        }
    }
    
    if ( isdefined( activity_starter ) )
    {
        activity_starter.var_ea54c0ab42a167ca = var_ea54c0ab42a167ca;
        activity_starter.activity_instance = activity_instance;
        activity_instance.activity_starter = activity_starter;
        activity_starter show_activity_starter();
        activitytype = activity_instance_common::getactivitytype( activity_instance );
        rewarddifficultyregion = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( activity_instance ) );
        scoreevent = namespace_34bb2a33b8502c64::get_score_event( activity_instance, rewarddifficultyregion );
        activity_starter.var_3506f5fa83bec7a = rank::getscoreinfovalue( scoreevent );
        activity_starter.poiindex = poi::function_98b6b43120545617( poi::function_c14b808f44505866( var_ea54c0ab42a167ca, 0, 0 ) );
        
        if ( !isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
        {
            level.var_e607236b193eb0c1.var_9433e6119f67c877 = [ activity_starter ];
        }
        else
        {
            level.var_e607236b193eb0c1.var_9433e6119f67c877[ level.var_e607236b193eb0c1.var_9433e6119f67c877.size ] = activity_starter;
        }
    }
    
    return activity_starter;
}

// Namespace ob_activity_starter
// Params 0
// Checksum 0x34ccf085, Offset: 0x899
// Size: 0x46
function show_activity_starter()
{
    if ( level.var_e607236b193eb0c1.var_ca2624de39435df5 )
    {
        self setscriptablepartstate( "nexus_activity_joiner_phone", "visible" );
    }
    else
    {
        self setscriptablepartstate( "nexus_activity_joiner_phone", "visible_no_icon" );
    }
    
    self.visible = 1;
}

// Namespace ob_activity_starter
// Params 1
// Checksum 0x2acfca0c, Offset: 0x8e7
// Size: 0x5b
function hide_activity_starter( player )
{
    level notify( "tablethide_kill_callout_" + self.origin );
    
    if ( isdefined( self.var_4d30a4ab99bcbf83 ) )
    {
        self [[ self.var_4d30a4ab99bcbf83 ]]( player );
    }
    
    self setscriptablepartstate( "nexus_activity_joiner_phone", "hidden" );
    calloutmarkerping::function_608710c894185549();
    self.visible = 0;
}

// Namespace ob_activity_starter
// Params 2
// Checksum 0x25cf6a2f, Offset: 0x94a
// Size: 0x93
function function_6320d38e74183e21( team, enabled )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        function_2438cf16ab938bcd( player, enabled );
    }
}

// Namespace ob_activity_starter
// Params 2
// Checksum 0xb4465a48, Offset: 0x9e5
// Size: 0xd1
function function_2438cf16ab938bcd( player, enabled )
{
    if ( isdefined( player ) && isdefined( level.var_e607236b193eb0c1 ) && isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
    {
        foreach ( starter in level.var_e607236b193eb0c1.var_9433e6119f67c877 )
        {
            if ( enabled )
            {
                starter enablescriptableplayeruse( player );
                continue;
            }
            
            starter disablescriptableplayeruse( player );
        }
    }
}

// Namespace ob_activity_starter
// Params 4
// Checksum 0xf151fb14, Offset: 0xabe
// Size: 0x28, Type: bool
function function_ca1008a00c603258( item_bundle, item, autouse, var_981c264073bf1154 )
{
    return false;
}

// Namespace ob_activity_starter
// Params 4
// Checksum 0x3d52383, Offset: 0xaef
// Size: 0x28, Type: bool
function function_4a0f3c1794b67700( item_bundle, item, auto_use, allow_swap )
{
    return false;
}

// Namespace ob_activity_starter
// Params 4
// Checksum 0x633819d9, Offset: 0xb20
// Size: 0x28, Type: bool
function function_7e1ef2bf7ff6cb97( var_cc52b81fcdf79849, item, auto_use, allow_swap )
{
    return false;
}

// Namespace ob_activity_starter
// Params 0
// Checksum 0xd3deaf69, Offset: 0xb51
// Size: 0x1ed
function function_4035d49ae8d96ec()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level.var_4777da776c93d2ce ) )
    {
        level.var_4777da776c93d2ce = throttle::throttle_initialize( "ob_activity_starter_nearby", getdvarint( @"scr_ob_activity_starter_nearby_throttle", 2 ) );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.var_4777da776c93d2ce, self );
        
        if ( level.var_e607236b193eb0c1.var_9433e6119f67c877.size == 0 || !isalive( self ) || !isdefined( self.origin ) )
        {
            continue;
        }
        
        var_8198ac8dcdbb5dea = 0;
        var_502a5f74699d2293 = namespace_e55955ff7520be97::function_ef912bdece1bc4ef( self );
        
        foreach ( instanceid, activityinfostruct in var_502a5f74699d2293.participatingactivities )
        {
            activityinstance = level.activities.instances[ instanceid ];
            
            if ( "Contract" == activityinstance.category )
            {
                var_8198ac8dcdbb5dea = 1;
                break;
            }
        }
        
        if ( !var_8198ac8dcdbb5dea )
        {
            closest = sortbydistance( level.var_e607236b193eb0c1.var_9433e6119f67c877, self.origin )[ 0 ];
            omnvar_utility::setcachedclientomnvar( "ui_dmz_activity_starter_poi_name", closest.poiindex );
            omnvar_utility::setcachedclientomnvar( "ui_dmz_activity_starter_reward", closest.var_3506f5fa83bec7a );
            difficulty = namespace_4a69edc3725e741::function_a74c120ee76094a2( closest.activity_instance );
            omnvar_utility::setcachedclientomnvar( "ui_ob_contract_loot_card_difficulty", difficulty ?? 0 );
        }
    }
}

// Namespace ob_activity_starter
// Params 1
// Checksum 0x3a934170, Offset: 0xd46
// Size: 0x1ae
function function_79ffbc74a1f0ee58( locations )
{
    locksandkeys::function_774c7440eb2cceab();
    validlocations = [];
    var_19f8fd52b318c193 = getdvarint( @"hash_b54c660e3e9515b2", 1000 );
    var_26adf1586888b8a3 = var_19f8fd52b318c193 * var_19f8fd52b318c193;
    
    foreach ( location in locations )
    {
        if ( !isdefined( location.visible ) && !br_dmz_radiation::function_704454416dce7454( location.origin ) && ( !isdefined( level.poi_names ) || poi::function_4da557e2eb873ee6( location.origin ) ) && ( !isdefined( level.uniquedoors ) || level.uniquedoors.size == 0 || distance( sortbydistance( level.uniquedoors, location.origin )[ 0 ].origin, location.origin ) > 350 ) && ( validlocations.size == 0 || distancesquared( sortbydistance( validlocations, location.origin )[ 0 ].origin, location.origin ) > var_26adf1586888b8a3 ) && !ai_fortress::function_f45832ffece5dbb( location.origin ) )
        {
            validlocations[ validlocations.size ] = location;
        }
    }
    
    return validlocations;
}

// Namespace ob_activity_starter
// Params 6
// Checksum 0x2e49a09b, Offset: 0xefd
// Size: 0x44
function function_155f215f9079002a( instance, part, state, player, bautouse, usestring )
{
    level thread function_7936da2aba1c014f( instance, player );
}

// Namespace ob_activity_starter
// Params 2
// Checksum 0xf56e3cfa, Offset: 0xf49
// Size: 0x1f3
function function_7936da2aba1c014f( instance, player )
{
    activity_instance = instance.activity_instance;
    var_1583662d9667c84 = activity_instance.participationconditions;
    var_d9d1fd28d1251906 = conditional_container::function_33051347e9187361( var_1583662d9667c84, player );
    
    if ( !var_d9d1fd28d1251906 )
    {
        return;
    }
    
    var_c528dc91aeae04a3 = getdvarint( @"hash_f36bf60921c2315", 1 ) && !getdvarint( @"ob_rift_run", 0 ) && !instance.var_875dcaee89ecc840;
    level.var_e607236b193eb0c1.var_9433e6119f67c877 = arrayremove( level.var_e607236b193eb0c1.var_9433e6119f67c877, instance );
    
    if ( var_c528dc91aeae04a3 )
    {
        instance function_7653c765b6c7b815();
    }
    else
    {
        instance hide_activity_starter( player );
    }
    
    player playlocalsound( "mp_dmz_phone_pickup" );
    player notify( #"hash_3e25f50a75ccbd1c", activity_instance );
    
    if ( instance.var_875dcaee89ecc840 )
    {
    }
    else if ( getdvarint( @"ob_rift_run", 0 ) )
    {
        player utility::function_72b6372d2d8c997( "jup_ges_mrpeeks_pickup", 1 );
        wait 3;
    }
    else if ( var_c528dc91aeae04a3 )
    {
        var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 1.5, instance, 0, 1, 0, -2, "ClinkInteractions" );
        
        if ( var_fab006cdb4f6e516 )
        {
            instance hide_activity_starter( player );
        }
        else
        {
            instance function_e203bba36cfb19d0();
            return;
        }
    }
    else
    {
        player dmz_task_utils::function_ce0c366b96d23996();
    }
    
    rewarddifficultyregion = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( activity_instance ) );
    var_e7b67b42155f71ee = level.region_difficulty_manager.region_difficulty_to_int[ rewarddifficultyregion ];
    activity_instance_common::function_dde540f74dc06621( instance.activity_instance, "ui_ob_active_contract_region_difficulty", var_e7b67b42155f71ee );
    activity_participation::function_bc67362dace4370c( instance.activity_instance, player, "PlayerJoinedInteract" );
}

/#

    // Namespace ob_activity_starter
    // Params 0, eflags: 0x4
    // Checksum 0x7b13f1d7, Offset: 0x1144
    // Size: 0x4b, Type: dev
    function private function_bc18ddce85eee3f9()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x45>", "<dev string:x4f>" );
        devgui::add_devgui_command( "<dev string:x77>", "<dev string:x88>" );
        devgui::add_devgui_command( "<dev string:xb7>", "<dev string:xcb>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_starter
    // Params 0, eflags: 0x4
    // Checksum 0x5197f90e, Offset: 0x1197
    // Size: 0x2f4, Type: dev
    function private function_4cb8dfbde1a6a6ab()
    {
        timer = 0;
        drawframeduration = 360;
        
        while ( true )
        {
            if ( getdvarint( @"hash_d0316f72a21f836e", 0 ) && timer == 0 )
            {
                foreach ( starter in level.var_e607236b193eb0c1.var_9433e6119f67c877 )
                {
                    print3d( starter.origin + ( 0, 0, 300 ), "<dev string:xfd>" + activity_instance_common::getactivitytype( starter.activity_instance ) + "<dev string:x104>" + starter.activity_instance.varianttag + "<dev string:x10f>" + activity_instance_common::getinstanceid( starter.activity_instance ), ( 1, 1, 1 ), 1, 2, drawframeduration, 1 );
                    line( starter.origin, starter.var_ea54c0ab42a167ca, ( 0, 0, 1 ), 1, 0, drawframeduration );
                    line( starter.origin, starter.origin + ( 0, 0, 3000 ), ( 1, 0, 1 ), 1, 0, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_7ab902fb378bcf96", 0 ) )
            {
                setdvar( @"hash_7ab902fb378bcf96", 0 );
                
                if ( getdvarint( @"ob_rift_run", 0 ) )
                {
                    level.players[ 0 ] utility::function_72b6372d2d8c997( "<dev string:x115>", 1 );
                    wait 3;
                }
                else if ( getdvarint( @"hash_f36bf60921c2315", 0 ) )
                {
                    level.players[ 0 ] thread utility::function_72b6372d2d8c997( "<dev string:x12c>", 1 );
                    wait 1.5;
                    level.players[ 0 ] takeweapon( "<dev string:x12c>" );
                }
                else
                {
                    level.players[ 0 ] dmz_task_utils::function_ce0c366b96d23996();
                }
            }
            
            if ( getdvarint( @"hash_a1e9c5a43f9fc548", 0 ) )
            {
                setdvar( @"hash_a1e9c5a43f9fc548", 0 );
                
                if ( isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
                {
                    closest = sortbydistance( level.var_e607236b193eb0c1.var_9433e6119f67c877, level.players[ 0 ].origin );
                    
                    if ( isdefined( closest ) )
                    {
                        level.players[ 0 ] setorigin( closest[ 0 ].origin + ( 64, 64, 64 ) );
                    }
                }
            }
            
            waitframe();
            timer++;
            
            if ( timer >= drawframeduration )
            {
                timer = 0;
            }
        }
    }

#/
