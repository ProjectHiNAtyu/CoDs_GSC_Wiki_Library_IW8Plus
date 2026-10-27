// script_b5a23e035b539d1  (hash_0b5a23e035b539d1.gscc) (size: 4676 Bytes / 0x1244 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdb1a5411 (3675935761)
// size ...... 4676 (0x1244)
// includes .. 9   (offset: 0x10ac)
// strings ... 21  (offset: 0x10f4)
// dev strs .. 4   (offset: 0x1214)
// exports ... 11  (offset: 0xaf0)
// cseg ...... 0x274 + 0x87c (0xaf0)
// imports ... 35  (offset: 0xca8)
// animtree1 . 0   (offset: 0x1244)
// animtree2 . 0   (offset: 0x1244)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_black_market;

#namespace activity_black_market_kills;

// Namespace activity_black_market_kills
// Params 0, eflags: 0x5
// Checksum 0x777ef0a8, Offset: 0x292
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_black_market_kills", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace activity_black_market_kills
// Params 0, eflags: 0x4
// Checksum 0x4b0f3109, Offset: 0x2cd
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_BLACK_MARKET_KILLS", &activity_type_init );
}

// Namespace activity_black_market_kills
// Params 0
// Checksum 0x1be12aec, Offset: 0x2e8
// Size: 0x6d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_KILLS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_KILLS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_KILLS", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_KILLS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_BLACK_MARKET_KILLS" );
    
    /#
        debug_init();
    #/
}

// Namespace activity_black_market_kills
// Params 0
// Checksum 0x1143d9fb, Offset: 0x35d
// Size: 0x32
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = namespace_9085ae059032a84f::function_9129cd8075c85c09( self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_black_market_kills
// Params 0
// Checksum 0x45f0f3d9, Offset: 0x397
// Size: 0x24d
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.kills = 0;
    
    switch ( self.varianttag )
    {
        case #"hash_9f9d2db85caa3503":
            self.numkills = getdvarint( @"hash_2fcbf0b061a60810", self.var_332f929de1894b2b.numkills );
            break;
        case #"hash_c749fb5a2d540296":
            self.numkills = getdvarint( @"hash_2fcbf3b061a60ea9", self.var_332f929de1894b2b.numkills );
            break;
        case #"hash_4a55eca53bfe10f":
            self.numkills = getdvarint( @"hash_9282d30e18d0a1e6", self.var_332f929de1894b2b.numkills );
            break;
        case #"hash_6bf7634831bfbc0b":
            self.numkills = getdvarint( @"hash_7a9c39a0a304ad84", self.var_332f929de1894b2b.numkills );
            break;
        case #"hash_c556cf15a69cc3d1":
            self.numkills = getdvarint( @"hash_7c816c9004a95296", self.var_332f929de1894b2b.numkills );
            break;
        case #"hash_938802bdda5ee16":
            self.numkills = getdvarint( @"hash_c7d5dd850752d325", self.var_332f929de1894b2b.numkills );
            break;
        case #"hash_f998f916a5828c8e":
            self.numkills = getdvarint( @"hash_62d4ce113e5081f5", self.var_332f929de1894b2b.numkills );
            break;
        default:
            self.numkills = self.var_332f929de1894b2b.numkills;
            break;
    }
    
    br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.kills, self.var_332f929de1894b2b.numkills );
    self.callbackparams = { #activity:self };
    level callback::add( #"player_death", &on_player_death, self.callbackparams );
}

// Namespace activity_black_market_kills
// Params 0
// Checksum 0xde5e1101, Offset: 0x5ec
// Size: 0x94
function activity_ended()
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( succeeded )
    {
        level callback::callback( self.activitycallback, { #activity:self, #team:self.team } );
    }
    
    if ( level callback::exists( #"player_death", &on_player_death, self.callbackparams ) )
    {
        level callback::remove( #"player_death", &on_player_death, self.callbackparams );
    }
}

// Namespace activity_black_market_kills
// Params 0
// Checksum 0x8f0c0eb, Offset: 0x688
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
}

// Namespace activity_black_market_kills
// Params 2
// Checksum 0xd279bda8, Offset: 0x6ac
// Size: 0x324
function on_player_death( params, additionalparams )
{
    activity = additionalparams.activity;
    
    if ( activity_participation::function_e7fc1202ac164928( activity, params.attacker ) )
    {
        if ( activity.completed )
        {
            return;
        }
        
        if ( activity.varianttag == "black_market_kills_handcannon_t2" && params.objweapon.basename != "sat_ks_handcannon_wz" )
        {
            return;
        }
        
        if ( activity.varianttag == "black_market_kills_sniperdrone_t2" && params.objweapon.basename != "sat_sniper_drone_turret_wz" && params.objweapon.basename != "sat_sniper_drone_grenade_wz" )
        {
            return;
        }
        
        if ( activity.varianttag == "black_market_kills_melee_t2" && !( params.meansofdeath == "MOD_MELEE" || params.meansofdeath == "MOD_EXECUTION" || params.meansofdeath == "MOD_MELEE_TAKEDOWN" || params.meansofdeath == "MOD_MEATSHIELD" && self.meatshieldstate == 9 ) )
        {
            return;
        }
        
        if ( activity.varianttag == "black_market_kills_execution_t2" && !( params.meansofdeath == "MOD_EXECUTION" || params.meansofdeath == "MOD_MELEE_TAKEDOWN" || params.meansofdeath == "MOD_MEATSHIELD" && ( self.meatshieldstate == 0 || self.meatshieldstate == 15 ) ) )
        {
            return;
        }
        
        if ( activity.varianttag == "black_market_kills_explosive_t2" && !( params.meansofdeath == "MOD_GRENADE" || params.meansofdeath == "MOD_GRENADE_SPLASH" || params.meansofdeath == "MOD_PROJECTILE" || params.meansofdeath == "MOD_PROJECTILE_SPLASH" || params.meansofdeath == "MOD_EXPLOSIVE" || params.meansofdeath == "MOD_MEATSHIELD" && self.meatshieldstate == 13 ) )
        {
            return;
        }
        
        activity.kills++;
        activity br_black_market::function_538557e757f948f0( activity.var_f118922d6f1d1e00, activity.kills );
        br_black_market::function_89707e63629ff7e6( activity.team, activity.varianttag, string( activity.kills ) + " / " + string( activity.var_332f929de1894b2b.numkills ) + " kills acquired." );
        
        if ( activity.kills >= activity.var_332f929de1894b2b.numkills )
        {
            activity.completed = 1;
            activity_instance_common::endactivity( activity, 1 );
        }
    }
}

/#

    // Namespace activity_black_market_kills
    // Params 0
    // Checksum 0xe1eda126, Offset: 0x9d8
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x44>", "<dev string:x4d>", &function_e9dab2f816702373 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_black_market_kills
    // Params 0
    // Checksum 0x87aab64c, Offset: 0xa0e
    // Size: 0xe2, Type: dev
    function function_e9dab2f816702373()
    {
        var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( level.players[ 0 ], [ "<dev string:x69>" ] );
        
        if ( var_657a3abce2509b48.size == 0 )
        {
            return;
        }
        
        killactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
        killactivity.kills++;
        killactivity br_black_market::function_538557e757f948f0( killactivity.var_f118922d6f1d1e00, killactivity.kills );
        
        if ( killactivity.kills >= killactivity.var_332f929de1894b2b.numkills )
        {
            killactivity.kills = killactivity.var_332f929de1894b2b.numkills;
            killactivity.completed = 1;
            activity_instance_common::endactivity( killactivity, 1 );
        }
    }

#/
