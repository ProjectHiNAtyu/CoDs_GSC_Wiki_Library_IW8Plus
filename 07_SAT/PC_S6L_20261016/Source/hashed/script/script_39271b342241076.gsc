// script_39271b342241076  (hash_039271b342241076.gscc) (size: 5981 Bytes / 0x175d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x772bc650 (1999357520)
// size ...... 5981 (0x175d)
// includes .. 16  (offset: 0x15cd)
// strings ... 14  (offset: 0x164d)
// dev strs .. 6   (offset: 0x1715)
// exports ... 15  (offset: 0xc4d)
// cseg ...... 0x15b + 0xaf2 (0xc4d)
// imports ... 64  (offset: 0xea5)
// animtree1 . 0   (offset: 0x175d)
// animtree2 . 0   (offset: 0x175d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_black_market;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\poi;

#namespace activity_black_market_deposit;

// Namespace activity_black_market_deposit
// Params 0, eflags: 0x5
// Checksum 0x18d96f81, Offset: 0x179
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_black_market_deposit", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace activity_black_market_deposit
// Params 0, eflags: 0x4
// Checksum 0x14c425da, Offset: 0x1b4
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_BLACK_MARKET_DEPOSIT", &activity_type_init );
}

// Namespace activity_black_market_deposit
// Params 0
// Checksum 0x442a3e3f, Offset: 0x1cf
// Size: 0x6d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_DEPOSIT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_DEPOSIT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_DEPOSIT", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_DEPOSIT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_BLACK_MARKET_DEPOSIT" );
    
    /#
        debug_init();
    #/
}

// Namespace activity_black_market_deposit
// Params 0
// Checksum 0x6da40630, Offset: 0x244
// Size: 0x32
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = namespace_9085ae059032a84f::function_9129cd8075c85c09( self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_black_market_deposit
// Params 0
// Checksum 0x48b162d1, Offset: 0x27e
// Size: 0x2e6
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.cashdeposited = 0;
    
    if ( self.varianttag == "black_market_deposit" )
    {
        self.totalcash = getdvarint( @"hash_55c7bf8e8be3ae1d", self.var_332f929de1894b2b.totalcash );
    }
    else
    {
        self.totalcash = getdvarint( @"hash_55c7bc8e8be3a784", self.var_332f929de1894b2b.totalcash );
    }
    
    self.var_1456a5c4a368ab40 = function_9df7c275a5add39( self.playerparticipants[ 0 ].origin, self.var_332f929de1894b2b );
    
    if ( !isdefined( self.var_1456a5c4a368ab40 ) )
    {
        self.var_e31e2f92f674112e = 1;
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    selectedpoi = function_59fa963e5daaf84c( self.var_1456a5c4a368ab40 );
    self.var_a72ac4dda42a6b4e = level.poi[ selectedpoi ][ "calloutIndex" ];
    br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.cashdeposited, self.totalcash * 10, self.var_a72ac4dda42a6b4e );
    player = teams::getteamdata( self.team, "players" )[ 0 ];
    depositorigin = ( self.var_1456a5c4a368ab40[ 0 ], self.var_1456a5c4a368ab40[ 1 ], self.var_1456a5c4a368ab40[ 2 ] );
    payload = [ #"teamselect", player getentitynumber() ];
    self.depositinteract = spawnscriptable( "black_market_deposit_interact", depositorigin, undefined, undefined, payload );
    self.depositinteract setscriptablepartstate( "black_market_deposit_interact", "enabled" );
    interaction::register_scriptable_interact( self.depositinteract, &function_c78a931a745c9478, undefined, undefined, &deposit_hint_callback );
    br_contract_manager::createquestobjicon( "ui_map_icon_top_earners_piggy", "active", self.var_1456a5c4a368ab40 - ( 0, 0, 50 ) );
    objective_setpinned( self.objectiveiconid, 1 );
    objective_setlabel( self.objectiveiconid, &"hash_65073e9ef8a23cb0" );
    
    foreach ( player in level.players )
    {
        if ( self.team == player.team )
        {
            br_contract_manager::showquestobjicontoplayer( player );
            continue;
        }
        
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace activity_black_market_deposit
// Params 0
// Checksum 0xceeca34c, Offset: 0x56c
// Size: 0x7f
function activity_ended()
{
    self endon( #"instance_destroyed" );
    
    if ( br_contract_manager::checkforactiveobjicon() )
    {
        br_contract_manager::deletequestobjicon();
    }
    
    if ( isdefined( self.depositinteract ) )
    {
        self.depositinteract freescriptable();
    }
    
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( succeeded )
    {
        level callback::callback( self.activitycallback, { #activity:self, #team:self.team } );
    }
}

// Namespace activity_black_market_deposit
// Params 0
// Checksum 0x74171f20, Offset: 0x5f3
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
}

// Namespace activity_black_market_deposit
// Params 2
// Checksum 0x639069ca, Offset: 0x617
// Size: 0x1fc
function function_9df7c275a5add39( origin, paramstruct )
{
    validlocations = [];
    
    foreach ( location in [ ( -4968, 2308, 1272 ), ( -1293, -2207, 215 ), ( -116, -5189, 116 ), ( 6796, 1339, 1021 ), ( -1133, 3529, 1386 ), ( 3359, 1504, 1205 ), ( -11531, -548, 136 ), ( -6140, -4456, 1440 ), ( -2433, 8395, 128 ), ( 12002, -3604, 514 ), ( 13766, 2552, 204 ), ( 4856, -5860, 140 ), ( 8608, 5272, 624 ) ] )
    {
        dist = distance2d( location, origin );
        
        if ( dist > paramstruct.locationmaxdist )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_38d96d7578ce6c6a = br_circle_util::function_472c93858e491e0a( location );
            var_16588246e974e557 = br_circle_util::function_b880c0f9998fdd69( var_38d96d7578ce6c6a );
            traveltime = dist / 190;
            var_16588246e974e557 -= traveltime;
            
            if ( var_16588246e974e557 > paramstruct.var_540b35ff024488bc )
            {
                validlocations[ validlocations.size ] = location;
            }
        }
    }
    
    var_1456a5c4a368ab40 = utility::array_random( validlocations );
    return var_1456a5c4a368ab40;
}

// Namespace activity_black_market_deposit
// Params 1
// Checksum 0x58f856d7, Offset: 0x81c
// Size: 0xdb
function function_59fa963e5daaf84c( origin )
{
    if ( !isdefined( origin ) || !level.poi_structs )
    {
        return;
    }
    
    if ( poi::poi_issystemactive() )
    {
        pois = function_628bac9faa9d1e86( level.poi_structs, origin );
        
        foreach ( poi in pois )
        {
            poiname = poi.name;
            
            if ( arraycontains( getarraykeys( level.var_74e93adf71e0b98f ), poiname ) )
            {
                return poiname;
            }
        }
    }
}

// Namespace activity_black_market_deposit
// Params 1
// Checksum 0xa2819248, Offset: 0x8ff
// Size: 0x19a
function function_c78a931a745c9478( player )
{
    var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( player, [ "BR_BLACK_MARKET_DEPOSIT" ] );
    
    if ( var_657a3abce2509b48.size == 0 )
    {
        return;
    }
    
    depositactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
    
    if ( depositactivity.completed )
    {
        return;
    }
    
    cashremaining = depositactivity.totalcash - depositactivity.cashdeposited;
    playercash = player currency::get_currency_amount( "cash" );
    
    if ( playercash == 0 )
    {
        return;
    }
    
    cashtaken = min( playercash, cashremaining );
    depositactivity.cashdeposited += cashtaken;
    player playgestureviewmodel( "iw8_ges_plyr_cash_handoff" );
    player currency::function_b5fe1e05c892a7f3( "cash", cashtaken );
    depositactivity br_black_market::function_538557e757f948f0( depositactivity.var_f118922d6f1d1e00, depositactivity.cashdeposited * 10 );
    br_black_market::function_89707e63629ff7e6( depositactivity.team, depositactivity.varianttag, string( depositactivity.cashdeposited ) + " / " + string( depositactivity.totalcash ) + " cash deposited." );
    
    if ( depositactivity.cashdeposited >= depositactivity.totalcash )
    {
        depositactivity.completed = 1;
        depositactivity.depositinteract freescriptable();
        activity_instance_common::endactivity( depositactivity, 1 );
    }
}

// Namespace activity_black_market_deposit
// Params 2
// Checksum 0x49513bd4, Offset: 0xaa1
// Size: 0x36
function deposit_hint_callback( interact, player )
{
    return { #string:&"hash_a6241a00f2a09be", #type:"HINT_BUTTON" };
}

/#

    // Namespace activity_black_market_deposit
    // Params 0
    // Checksum 0x7cef6620, Offset: 0xae0
    // Size: 0x44, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x54>", &debug_deposit );
        devgui::add_devgui_func( "<dev string:x74>", "<dev string:x88>", &function_2925c2df90f15aeb );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_black_market_deposit
    // Params 0
    // Checksum 0x66851fa7, Offset: 0xb2c
    // Size: 0xdf, Type: dev
    function debug_deposit()
    {
        var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( level.players[ 0 ], [ "<dev string:xaf>" ] );
        
        if ( var_657a3abce2509b48.size == 0 )
        {
            return;
        }
        
        depositactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
        depositactivity.cashdeposited += 100;
        depositactivity br_black_market::function_538557e757f948f0( depositactivity.var_f118922d6f1d1e00, depositactivity.cashdeposited * 10 );
        
        if ( depositactivity.cashdeposited >= depositactivity.totalcash )
        {
            depositactivity.cashdeposited = depositactivity.totalcash;
            depositactivity.completed = 1;
            activity_instance_common::endactivity( depositactivity, 1 );
        }
    }

    // Namespace activity_black_market_deposit
    // Params 0
    // Checksum 0xbbbe83f4, Offset: 0xc13
    // Size: 0x3a, Type: dev
    function function_2925c2df90f15aeb()
    {
        sphere( level.var_ab06be8f65123f71.depositinteract.origin, 25, ( 0, 0, 1 ), 0, 600 );
    }

#/
