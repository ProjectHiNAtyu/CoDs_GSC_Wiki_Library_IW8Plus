// script_66d9d3d21abca38d  (hash_66d9d3d21abca38d.gscc) (size: 11429 Bytes / 0x2ca5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e02db5f (2114116447)
// size ...... 11429 (0x2ca5)
// includes .. 20  (offset: 0x2a0d)
// strings ... 28  (offset: 0x2aad)
// dev strs .. 8   (offset: 0x2c35)
// exports ... 36  (offset: 0x17f9)
// cseg ...... 0x28f + 0x156a (0x17f9)
// imports ... 108 (offset: 0x1d99)
// animtree1 . 0   (offset: 0x2ca5)
// animtree2 . 0   (offset: 0x2ca5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\magicbox;
#using scripts\mp\weaponmetadata;

#namespace activity_mystery_box;

// Namespace activity_mystery_box
// Params 0, eflags: 0x5
// Checksum 0xcf58d443, Offset: 0x2ad
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_mystery_box", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0x39ea5e02, Offset: 0x2d6
// Size: 0x25
function private function_538033a540e63c70()
{
    if ( !validatemode() )
    {
        return;
    }
    
    activity_common::registeractivitytype( "BONGO_MYSTERY_BOX", &activity_type_init );
    function_67cbae2775d0e61();
}

// Namespace activity_mystery_box
// Params 0
// Checksum 0xf544f2b7, Offset: 0x303
// Size: 0x16, Type: bool
function validatemode()
{
    return isdefined( level.gametypebundle.magicboxbundle );
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0xfe8825dd, Offset: 0x322
// Size: 0xaf
function private function_67cbae2775d0e61()
{
    utility::registersharedfunc( #"zombie", #"hash_bad01cbc996e3dba", &utility::always_true, 1 );
    utility::registersharedfunc( #"game", #"roundNumberDifficulty", &function_60992da26c2418e );
    utility::registersharedfunc( #"zombie", #"hash_fc6574ba8b7263fc", &function_d0f4cf206be8ae7f );
    callback::add( "magicbox_used", &function_a045b4a9b76da7fb );
    level.var_8a032a823f2ea506 = 1;
    content_manager::init_content_manager();
    weaponmetadata::init_weaponmetadata();
    currency::init_currency();
    level.force_init_magicbox = 1;
    magicbox::function_bfabc0b272ff94ad();
    level.var_c7164a558fe3d921 = &function_d3c76f00454d51ec;
}

// Namespace activity_mystery_box
// Params 0
// Checksum 0xcc776d72, Offset: 0x3d9
// Size: 0xa7
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_MYSTERY_BOX", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_MYSTERY_BOX", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_MYSTERY_BOX", 3, &activity_destroyed );
    activity_common::function_944074f3079c1d4e( "BONGO_MYSTERY_BOX", 4, &activity_get_center_point );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined, "BONGO_MYSTERY_BOX" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerFocusedOnActivity", &player_focused, "BONGO_MYSTERY_BOX" );
    activity_common::function_2dd4f07fa5c3e911( "BRCircleTick", &function_5070b91897c7106, "BONGO_MYSTERY_BOX" );
    thread init_spawn_callback();
    thread on_prematch_end();
    
    /#
        registerdevgui();
    #/
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0x332d6fe6, Offset: 0x488
// Size: 0x1a
function private init_spawn_callback()
{
    utility::flag_wait( "ai_spawn_director_initialized" );
    ai_spawn_director::function_c83497dcedebe189( &function_10046dedb4ec9f21 );
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0x85f72b2a, Offset: 0x4aa
// Size: 0xa0
function private on_prematch_end()
{
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    magicboxes = getentitylessscriptablearray( "magicbox", "script_noteworthy" );
    
    foreach ( magicbox in magicboxes )
    {
        magicbox setscriptablepartstate( "model_and_collision", "show" );
    }
}

// Namespace activity_mystery_box
// Params 0
// Checksum 0xb1a6d93b, Offset: 0x552
// Size: 0x288
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance.trackeractivity = function_2efff91d1e411560( activity_instance_common::function_776ee11e7acc64a5( activity_instance ) );
    function_bc041d7a3efbfe87( activity_instance.varianttag, activity_instance.var_332f929de1894b2b );
    initial_origin = activity_instance activity_instance_common::function_94763020f8207b8b();
    var_f85d60d5d41b4962 = activity_instance_common::function_a45920af4495e9f( activity_instance );
    
    if ( !isdefined( var_f85d60d5d41b4962.gasbehavior ) )
    {
        var_f85d60d5d41b4962.gasbehavior = activity_instance.var_332f929de1894b2b.gasbehavior;
    }
    
    if ( !isdefined( var_f85d60d5d41b4962.origin ) )
    {
        var_f85d60d5d41b4962.origin = initial_origin;
    }
    
    if ( !isdefined( var_f85d60d5d41b4962.radius ) )
    {
        var_f85d60d5d41b4962.radius = 200000;
    }
    
    var_2d9a19e909b50b4e = activity_instance_common::function_a45920af4495e9f( activity_instance ).var_2d9a19e909b50b4e;
    magicboxes = getentitylessscriptablearray( var_2d9a19e909b50b4e, "targetname" );
    
    if ( !isdefined( level.var_555861d0d8973273 ) )
    {
        level.var_555861d0d8973273 = activity_instance.var_332f929de1894b2b.rolltime;
    }
    
    if ( magicboxes.size == 0 )
    {
        br_activity_util::activitylog( self, "Failed to find magicbox with targetname: " + var_2d9a19e909b50b4e );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    activity_instance.magicbox = magicboxes[ 0 ];
    activity_instance.magicbox.activity_instance = activity_instance;
    activity_instance.magicbox setscriptablepartstate( "model_and_collision", "hide" );
    activity_instance.magicbox magicbox::function_ab59e6993557d5b6();
    activity_instance.items_rolled = 0;
    activity_instance.magicbox magicbox::show_magicbox();
    activity_instance.magicbox.var_f14b2b4820b635e7 = 1;
    activity_instance.magicbox.script_cost = activity_instance.var_332f929de1894b2b.var_ff96def6d35c1e5c;
    activity_instance.magicbox.var_dc41a51effa51e7f = ( 0, 90, 0 );
    activity_instance.var_d7902a99156f281e = &function_d7902a99156f281e;
    activity_definition_utils::function_16b3cfd89a1669f7( 2, activity_instance );
    activity_definition_utils::function_a0a94881bc380bbf( 0, activity_instance );
    wait 5;
    waitframe();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace activity_mystery_box
// Params 0
// Checksum 0xdf0c2eda, Offset: 0x7e2
// Size: 0xc1
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance childthread function_4da014030bfc6e1f();
    activity_instance childthread function_7c508e032f5eb3f3();
    activity_instance childthread function_65b490c0c9b04cd2();
    
    foreach ( player in activity_instance_common::function_4225efca86f0dea9( activity_instance ) )
    {
        function_b9b877fa18fdd673( player );
    }
    
    function_759a484ecc8a70a();
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0xbf115ad9, Offset: 0x8ab
// Size: 0xdb
function private function_759a484ecc8a70a()
{
    origin = self.magicbox.origin - ( 0, 0, 50 );
    self.var_b9376415d6b959c5 = [];
    
    foreach ( modelname in level.var_c94175b5e96b794c )
    {
        model = spawn( "script_model", origin );
        model setmodel( modelname );
        self.var_b9376415d6b959c5[ self.var_b9376415d6b959c5.size ] = model;
    }
}

// Namespace activity_mystery_box
// Params 0
// Checksum 0x557d65eb, Offset: 0x98e
// Size: 0xd3
function activity_destroyed()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.magicbox thread magicbox::hide_magicbox();
    br_activity_util::function_333e692c891758bb( activity_instance.var_d148302ea55cc6d6 ?? [], "activitiesCompleted" );
    
    foreach ( model in activity_instance.var_b9376415d6b959c5 )
    {
        if ( isdefined( model ) )
        {
            model delete();
        }
    }
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0x48564b95, Offset: 0xa69
// Size: 0x22
function private activity_get_center_point()
{
    activity_instance = self;
    return self.magicbox.origin;
}

// Namespace activity_mystery_box
// Params 1
// Checksum 0x2fa2a927, Offset: 0xa94
// Size: 0xd1
function function_a045b4a9b76da7fb( params )
{
    if ( isdefined( self ) && isdefined( params.var_349a0723ed9ac19c.activity_instance ) )
    {
        magicbox = params.var_349a0723ed9ac19c;
        activity_instance = magicbox.activity_instance;
        callbackparams = spawnstruct();
        callbackparams.player = self;
        callbackparams.exp = activity_instance.var_332f929de1894b2b.var_eee681d9591bb1a1;
        callbackparams.scoreeventoverride = #"hash_4ea253efaf7752fa";
        utility::callsharedfunc( #"gametype", #"hash_4d30403ee025b771", callbackparams );
        challenges::function_37e945722d6497f3( self, "mystery_box_open", 1 );
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x5dfd0ef4, Offset: 0xb6d
// Size: 0xff
function private player_joined( info )
{
    if ( !isdefined( self.var_7b2ac829756f4854 ) )
    {
        self.var_7b2ac829756f4854 = [];
    }
    
    foreach ( player in info.playerlist )
    {
        function_b9b877fa18fdd673( player );
        
        if ( !arraycontains( self.var_7b2ac829756f4854, player ) )
        {
            self.var_7b2ac829756f4854[ self.var_7b2ac829756f4854.size ] = player;
            level thread br_public::brleaderdialogplayer( "mystery_box_" + self.varianttag + "_join", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_90d2488226a1079f );
        }
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x93aa6418, Offset: 0xc74
// Size: 0x99
function private player_focused( info )
{
    if ( getdvarint( @"hash_e4aee4631834928a", 1 ) )
    {
        foreach ( player in info.playerlist )
        {
            function_b9b877fa18fdd673( player );
        }
    }
}

// Namespace activity_mystery_box
// Params 2, eflags: 0x4
// Checksum 0xc021b5e5, Offset: 0xd15
// Size: 0x60
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "mystery_box_" + variantname + "_join" ] ) )
    {
        game[ "dialog" ][ "mystery_box_" + variantname + "_join" ] = data.var_4310ead0bb84e72b;
    }
}

// Namespace activity_mystery_box
// Params 2, eflags: 0x4
// Checksum 0x63ef970f, Offset: 0xd7d
// Size: 0x124
function private function_b9b877fa18fdd673( player, updatereason )
{
    if ( self.trackeractivity )
    {
        kills = minint( self.trackeractivity function_35b7818990764e03( player ), self.magicbox.script_cost );
        activity_definition_utils::updateprogress( kills, self, self.magicbox.script_cost, { #players:[ player ] } );
        var_68153141e21e46e1 = kills >= self.magicbox.script_cost;
        activitystate = !var_68153141e21e46e1 ? 2 : 1;
        activity_definition_utils::function_16b3cfd89a1669f7( activitystate, self, { #players:[ player ] } );
        
        if ( var_68153141e21e46e1 )
        {
            activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:[ player ] } );
        }
        else
        {
            activity_definition_utils::function_a0a94881bc380bbf( 0, self, { #players:[ player ] } );
        }
        
        player currency::set_currency_amount( currency::get_magicbox_currency(), kills, updatereason );
    }
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0xf9d820f9, Offset: 0xea9
// Size: 0xb5
function private function_4da014030bfc6e1f()
{
    var_f85d60d5d41b4962 = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( var_f85d60d5d41b4962.gasbehavior == "Unrestricted" )
    {
        return;
    }
    
    origin = activity_instance_common::function_776ee11e7acc64a5( self );
    var_4f3096b4d16e7562 = var_f85d60d5d41b4962.gasbehavior == "AlwaysInGas";
    
    while ( true )
    {
        var_171501653d192328 = br_circle::function_6bf5d4e680297398( origin ) || br_circle_util::function_4c6afbf2b757376a( origin, 1 );
        
        if ( var_4f3096b4d16e7562 != var_171501653d192328 )
        {
            br_activity_util::activitylog( self, "Ending because of Gas" );
            wait self.var_332f929de1894b2b.gracetime;
            activity_instance_common::endactivity( self, 0 );
        }
        
        wait 1;
    }
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0xad234702, Offset: 0xf66
// Size: 0xa9
function private function_7c508e032f5eb3f3()
{
    self.magicbox waittill( #"magicbox_left" );
    br_activity_util::activitylog( self, "Ending because of Teddy Bear roll" );
    
    foreach ( player in activity_instance_common::function_4225efca86f0dea9( self ) )
    {
        player thread hud_message::showsplash( "br_bongo_cradle_breach_mystery_box_vanished" );
    }
    
    activity_instance_common::endactivity( self, 0 );
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0x37136b0d, Offset: 0x1017
// Size: 0xeb
function private function_65b490c0c9b04cd2()
{
    while ( true )
    {
        self.magicbox.mdl_magicbox.interact waittill( #"magicbox_closed" );
        br_activity_util::activitylog( self, "Magic Box Rolled" );
        self.items_rolled++;
        
        if ( self.magicbox.var_37f3a4cd8252c9f0 )
        {
            self.trackeractivity function_cffce8283745e518( self.magicbox.var_37f3a4cd8252c9f0 );
            br_activity_util::function_333e692c891758bb( [ self.magicbox.var_37f3a4cd8252c9f0 ], "mysteryBoxesOpened" );
            
            if ( !isdefined( self.var_d148302ea55cc6d6 ) )
            {
                self.var_d148302ea55cc6d6 = [];
            }
            
            self.var_d148302ea55cc6d6 = arraycombineunique( self.var_d148302ea55cc6d6, [ self.magicbox.var_37f3a4cd8252c9f0 ] );
        }
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0xe0f85fe, Offset: 0x110a
// Size: 0x43, Type: bool
function private function_d7902a99156f281e( player )
{
    var_bacc0c211bfcfcac = player currency::get_currency_amount( currency::get_magicbox_currency() );
    
    if ( var_bacc0c211bfcfcac >= self.magicbox.script_cost )
    {
        return true;
    }
    
    return false;
}

// Namespace activity_mystery_box
// Params 3, eflags: 0x4
// Checksum 0xbc23bd7a, Offset: 0x1156
// Size: 0xd6
function private function_10046dedb4ec9f21( agent, requestid, spawndata )
{
    requesttags = function_f92267986b091ba3( requestid );
    
    if ( arrayintersection( requesttags, level.bongobreach.tags ).size > 0 )
    {
        agent waittill( #"death" );
        activity = function_2efff91d1e411560( agent.origin );
        
        if ( !activity )
        {
            return;
        }
        
        distance_sq = distance2dsquared( agent.origin, activity_instance_common::function_776ee11e7acc64a5( activity ) );
        
        if ( distance_sq > 56250000 )
        {
            return;
        }
        
        realattacker = br_activity_util::function_501ceea91ee698e7( agent.lastattacker );
        
        if ( realattacker )
        {
            activity function_8630d5aa2de9696e( realattacker );
        }
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x32d8afc6, Offset: 0x1234
// Size: 0xbc
function private function_8630d5aa2de9696e( player )
{
    tracker_instance = self;
    assert( tracker_instance.type == "<dev string:x2b>", "<dev string:x41>" );
    entnum = player getentitynumber();
    
    if ( !isdefined( tracker_instance.killcredits[ entnum ] ) )
    {
        tracker_instance.killcredits[ entnum ] = 0;
    }
    
    tracker_instance.killcredits[ entnum ]++;
    kills = tracker_instance.killcredits[ entnum ];
    activity_instance = tracker_instance.subactivity;
    
    if ( activity_instance )
    {
        activity_instance function_b9b877fa18fdd673( player, #"zombie_killed" );
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x3b5465b7, Offset: 0x12f8
// Size: 0x7b
function private function_cffce8283745e518( player )
{
    tracker_instance = self;
    assert( tracker_instance.type == "<dev string:x2b>", "<dev string:x41>" );
    entnum = player getentitynumber();
    tracker_instance.killcredits[ entnum ] = 0;
    activity_instance = tracker_instance.subactivity;
    
    if ( activity_instance )
    {
        activity_instance function_b9b877fa18fdd673( player );
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x48c6026a, Offset: 0x137b
// Size: 0x59, Type: bool
function private function_35b7818990764e03( player )
{
    tracker_instance = self;
    assert( tracker_instance.type == "<dev string:x2b>", "<dev string:x41>" );
    entnum = player getentitynumber();
    return tracker_instance.killcredits[ entnum ] ?? 0;
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x14964153, Offset: 0x13dd
// Size: 0x5b
function private function_5070b91897c7106( params )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    origin = activity_instance_common::function_776ee11e7acc64a5( self );
    
    if ( br_circle::function_6bf5d4e680297398( origin ) || br_circle_util::function_4c6afbf2b757376a( origin, 0 ) )
    {
        self.var_b6c5eeeebd9383f5 = 1;
        self notify( #"center_in_gas" );
    }
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0xe8364639, Offset: 0x1440
// Size: 0x30, Type: bool
function private function_60992da26c2418e( point )
{
    closestactivity = function_54c7f591a510d2a4( point );
    return closestactivity.roundnumber ?? 1;
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0xcba43feb, Offset: 0x1479
// Size: 0xc1, Type: bool
function private function_d3c76f00454d51ec()
{
    magicbox = self;
    activity_instance = function_54c7f591a510d2a4( magicbox.origin );
    
    if ( activity_instance.items_rolled < activity_instance.var_332f929de1894b2b.minpulls )
    {
        return false;
    }
    
    if ( activity_instance.items_rolled >= activity_instance.var_332f929de1894b2b.maxpulls )
    {
        return true;
    }
    
    relocate_chance = activity_instance.var_332f929de1894b2b.var_6e2fbfd46158b0c6 + activity_instance.var_332f929de1894b2b.var_d6f5a5025c89f60e * activity_instance.items_rolled;
    return randomfloat( 1 ) < relocate_chance;
}

// Namespace activity_mystery_box
// Params 2, eflags: 0x4
// Checksum 0x79d03aca, Offset: 0x1543
// Size: 0x26, Type: bool
function private function_ac894c97787eea27( activity_instance, params )
{
    return activity_instance.type == "BONGO_MYSTERY_BOX";
}

// Namespace activity_mystery_box
// Params 2, eflags: 0x4
// Checksum 0x8719a539, Offset: 0x1572
// Size: 0x23, Type: bool
function private function_86c4ec8696beeb4d( activity_instance, params )
{
    return activity_instance_common::getactivitystate( activity_instance ) == "Active";
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x4a50359f, Offset: 0x159e
// Size: 0x4e
function private function_54c7f591a510d2a4( origin )
{
    conditions = spawnstruct();
    conditions conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( conditions, &function_ac894c97787eea27, [] );
    conditional_container::addcondition( conditions, &function_86c4ec8696beeb4d, [] );
    return activity_common::function_3eba33db536a1da6( origin, undefined, conditions );
}

// Namespace activity_mystery_box
// Params 1, eflags: 0x4
// Checksum 0x58a22dfe, Offset: 0x15f5
// Size: 0xe0
function private function_2efff91d1e411560( origin )
{
    closestactivity = undefined;
    closestdistancesq = undefined;
    
    foreach ( activity in level.bongobreach.breaches )
    {
        activityorigin = activity_instance_common::function_776ee11e7acc64a5( activity );
        
        if ( !activityorigin )
        {
            continue;
        }
        
        distancesq = distancesquared( origin, activityorigin );
        
        if ( !closestdistancesq || distancesq < closestdistancesq )
        {
            closestdistancesq = distancesq;
            closestactivity = activity;
        }
    }
    
    return closestactivity;
}

// Namespace activity_mystery_box
// Params 0, eflags: 0x4
// Checksum 0xca7db1c7, Offset: 0x16de
// Size: 0x1f
function private function_d0f4cf206be8ae7f()
{
    if ( isdefined( level.var_555861d0d8973273 ) )
    {
        return level.var_555861d0d8973273;
    }
    
    return 5;
}

/#

    // Namespace activity_mystery_box
    // Params 0, eflags: 0x4
    // Checksum 0x5c57822f, Offset: 0x1705
    // Size: 0x2e, Type: dev
    function private registerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7b>" );
        devgui::add_devgui_func( "<dev string:x8e>", "<dev string:x9e>", &function_35b3e9b4b305526e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_mystery_box
    // Params 0, eflags: 0x4
    // Checksum 0x3ae5fda9, Offset: 0x173b
    // Size: 0xbe, Type: dev
    function private function_35b3e9b4b305526e()
    {
        foreach ( activity in level.activities.instances )
        {
            if ( activity_instance_common::getactivitytype( activity ) != "<dev string:xa9>" )
            {
                continue;
            }
            
            if ( activity_instance_common::getactivitystate( activity ) != "<dev string:xbb>" )
            {
                continue;
            }
            
            activity.magicbox.script_cost = 0;
        }
    }

#/
