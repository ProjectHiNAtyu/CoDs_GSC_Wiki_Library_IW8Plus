// script_149ff34eed9c940e  (hash_149ff34eed9c940e.gscc) (size: 19247 Bytes / 0x4b2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x745fb37e (1952428926)
// size ...... 19247 (0x4b2f)
// includes .. 18  (offset: 0x482b)
// strings ... 32  (offset: 0x48bb)
// dev strs .. 11  (offset: 0x4aab)
// exports ... 52  (offset: 0x2ebb)
// cseg ...... 0x307 + 0x2bb4 (0x2ebb)
// imports ... 148 (offset: 0x36db)
// animtree1 . 0   (offset: 0x4b2f)
// animtree2 . 0   (offset: 0x4b2f)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_gametype_bongo;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\hud_message;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_cradle_gas_cs;
#using scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_cradle_gas_cs;

#namespace activity_bongo_cradle_gas_bomb;

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x5
// Checksum 0x180570e6, Offset: 0x325
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c88ab6a52bb80d4d", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0x53267265, Offset: 0x34e
// Size: 0x31
function private function_538033a540e63c70()
{
    gametype = game_utility::getgametype();
    
    if ( gametype != "bongo" )
    {
        return;
    }
    
    activity_common::registeractivitytype( "BONGO_CRADLE_GAS_BOMB", &activity_type_init );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x7ad4614e, Offset: 0x387
// Size: 0x9
function init()
{
    initleveldata();
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x4194a755, Offset: 0x398
// Size: 0x89
function initleveldata()
{
    level.bongobreach = {};
    level.bongobreach.zombiezones = [];
    level.bongobreach.zombies = [];
    level.bongobreach.breaches = [];
    level.bongobreach.tags = [];
    airdrop_scriptbundle::registerairdrop( "saw_airdrop_bongo_breach_bomb" );
    airdrop_scriptbundle::registerairdrop( "saw_airdrop_bongo_breach_loot" );
    thread managezombies();
    
    /#
        debug_missile_locations();
    #/
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x8ce74710, Offset: 0x429
// Size: 0x56
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_CRADLE_GAS_BOMB", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_CRADLE_GAS_BOMB", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_CRADLE_GAS_BOMB", 2, &activity_end );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_25a4bd6454614af4", "BONGO_CRADLE_GAS_BOMB_VARIANT" );
    function_917ecb108bc83c14();
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x321567dc, Offset: 0x487
// Size: 0x3c
function function_917ecb108bc83c14()
{
    switch ( game_utility::getmapname() )
    {
        case #"hash_9557c6d7c58bd42":
            mp_saw_mechanics_cradle_gas_cs::main();
            break;
        case #"hash_14bcaf472a3106a4":
            mp_saw_avalon_bongo_cradle_gas_cs::main();
            break;
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0xe8bef68d, Offset: 0x4cb
// Size: 0x1be
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    definitionoverride = activity_instance_common::function_a45920af4495e9f( activity_instance ).scheduleractivitydefinition;
    
    if ( definitionoverride )
    {
        scriptbundle = getscriptbundle( hashcat( %"activitydefinition:", definitionoverride ) );
        activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( scriptbundle );
    }
    
    activity_instance.var_8b752b615d176d4c = 0;
    activity_instance.killcredits = [];
    
    if ( !isdefined( level.activities.definitions[ self.var_332f929de1894b2b.subactivity ] ) )
    {
        activity_definition_utils::function_74af1ab4059e3c06( self.var_332f929de1894b2b.subactivity, self.var_332f929de1894b2b.subactivity );
    }
    
    level.bongobreach.var_b4dd4140901ffcd5 = activity_instance.var_332f929de1894b2b.var_b4dd4140901ffcd5;
    level.bongobreach.var_ca7ec6d2c1b114b5 = activity_instance.var_332f929de1894b2b.var_ca7ec6d2c1b114b5;
    level.bongobreach.tags = arraycombineunique( level.bongobreach.tags, [ activity_instance.var_332f929de1894b2b.var_e6b3b0185b6f0a60 ] );
    function_bc041d7a3efbfe87( activity_instance.varianttag, activity_instance.var_332f929de1894b2b );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x8b697c8d, Offset: 0x691
// Size: 0x82
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.bongobreach.breaches[ level.bongobreach.breaches.size ] = activity_instance;
    utility::registersharedfunc( #"activity_cradle_gas", #"hash_89cf90274de1da20", &function_84af973bb1201a35 );
    function_442476e85e8c952a();
    activity_instance thread function_37f1891189f3bf13();
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0x2e0b748a, Offset: 0x71b
// Size: 0x14f
function activity_end( success )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.bongobreach.breaches = arrayremove( level.bongobreach.breaches, activity_instance );
    function_f1d524c5b838ad8d( activity_instance );
    
    if ( isent( activity_instance.exclusionzone ) )
    {
        exclusion_zones::function_5fc2ac1152c0aa19( activity_instance.exclusionzone );
    }
    
    if ( activity_instance.zombieactivity )
    {
        activity_instance_common::endactivity( activity_instance.zombieactivity, 1 );
    }
    
    if ( activity_instance.subactivity )
    {
        activity_instance_common::endactivity( activity_instance.subactivity, 0 );
    }
    
    if ( activity_instance.missile && !activity_instance.missile.var_cdfee38a78fe4760 )
    {
        if ( isdefined( activity_instance.missile.var_f82dd71df52f14e2 ) )
        {
            activity_instance.missile.var_f82dd71df52f14e2 freescriptable();
        }
    }
    
    function_5af99fe2a14decaf( activity_instance );
    disablezombies( activity_instance );
    function_a174abf94915abf2( activity_instance );
    function_4efedd41374e980f( activity_instance );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0x1cd8adb6, Offset: 0x872
// Size: 0x108
function private function_37f1891189f3bf13()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    instance_id = self.id;
    trackedplayers = [];
    
    while ( true )
    {
        radius = function_5ef02ff9650ff4f7( self );
        trackedplayers = function_5713d46873b29625( trackedplayers );
        playersinradius = getplayersinradius( self.bomborigin, radius, undefined, undefined, trackedplayers );
        
        foreach ( player in playersinradius )
        {
            if ( !isdefined( player.var_25acb16897ed5cb4[ instance_id ] ) )
            {
                thread function_9ebdacca24ffe1cc( player );
                trackedplayers[ trackedplayers.size ] = player;
            }
        }
        
        wait 0.1;
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0xf9f31c16, Offset: 0x982
// Size: 0x72
function private function_9ebdacca24ffe1cc( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    instance_id = self.id;
    function_715070517d42ef2c( player, instance_id );
    
    if ( player.var_25acb16897ed5cb4[ instance_id ] )
    {
        br_analytics::function_ac82ba72661fcfd5( self, player, "circle_end" );
    }
    
    player.var_25acb16897ed5cb4[ instance_id ] = undefined;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0xc79f6a3d, Offset: 0x9fc
// Size: 0xe5
function private function_715070517d42ef2c( player, instance_id )
{
    self endon( #"activity_ended" );
    player.var_25acb16897ed5cb4 = player.var_25acb16897ed5cb4 ?? [];
    player.var_25acb16897ed5cb4[ instance_id ] = 0;
    
    while ( true )
    {
        wait 0.1;
        isingas = function_f7a0613d888ba72a( self, player.origin );
        
        if ( isingas && !player.var_25acb16897ed5cb4[ instance_id ] )
        {
            br_analytics::function_29ad92fb1ce29560( self, player );
            player.var_25acb16897ed5cb4[ instance_id ] = 1;
            continue;
        }
        
        if ( !isingas && player.var_25acb16897ed5cb4[ instance_id ] )
        {
            br_analytics::function_ac82ba72661fcfd5( self, player, "traveled_out" );
            player.var_25acb16897ed5cb4[ instance_id ] = 0;
        }
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x69e87bcd, Offset: 0xae9
// Size: 0x32
function function_1cb6b6bbdfc6eee7()
{
    if ( !isdefined( self.var_25acb16897ed5cb4 ) )
    {
        return;
    }
    
    if ( isarray( self.var_25acb16897ed5cb4 ) )
    {
        return arraycontains( self.var_25acb16897ed5cb4, 1 );
    }
    
    return 0;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0x6a73f2a0, Offset: 0xb24
// Size: 0xc8
function private function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "cradle_bomb_" + variantname + "_deploy_in" ] ) )
    {
        game[ "dialog" ][ "cradle_bomb_" + variantname + "_deploy_in" ] = data.var_a2ae63c23db6bf77;
        game[ "dialog" ][ "cradle_bomb_" + variantname + "_deploy_out" ] = data.var_d1b2572df6ee819c;
        game[ "dialog" ][ "cradle_bomb_" + variantname + "_explode" ] = data.var_5b2f4f6fa4d0824;
        game[ "dialog" ][ "cradle_bomb_" + variantname + "_shrink" ] = data.var_9897639076eeaa5e;
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0xd843d9ca, Offset: 0xbf4
// Size: 0x1a5
function private function_442476e85e8c952a()
{
    activity = self;
    linkedstructs = activity_instance_common::function_c78d8509d1f980d4( activity );
    
    foreach ( struct in linkedstructs )
    {
        if ( struct.script_noteworthy == "missile_impact" )
        {
            activity.bomborigin = struct.origin;
            activity.planeangles = struct.angles;
            break;
        }
    }
    
    if ( !activity.bomborigin )
    {
        activity.bomborigin = activity_instance_common::function_776ee11e7acc64a5( activity );
    }
    
    function_b22f8c67a9a13827();
    function_313a7cf1f9f57b8c();
    overridestruct = {};
    overridestruct.droporigin = activity.bomborigin;
    overridestruct.extradata = { #planeangles:activity.planeangles, #activity:activity };
    overridestruct.var_a4021a4bc7d38fea = &function_8d91dbbe93e5a68b;
    overridestruct.instance = activity;
    level thread airdrop_scriptbundle::startairdrop( "saw_airdrop_bongo_breach_bomb", undefined, undefined, overridestruct );
    activity function_3b34325bd0196234( overridestruct.droporigin, activity.var_332f929de1894b2b.expandradius );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0xe240ef72, Offset: 0xda1
// Size: 0x229
function function_8d91dbbe93e5a68b( airdropsettings )
{
    var_f0754750a1f39494 = getdvarfloat( @"scr_test_dist", 5000 );
    instance = airdropsettings.instance;
    instance endon( #"hash_3dfecad360ebd2e" );
    dist = distance2d( self.startpt, airdropsettings.droparea.origin ) - var_f0754750a1f39494;
    time = dist / self.speed;
    missileorigin = airdropsettings.droparea.origin;
    missileangles = ( 0, self.angles[ 1 ], 0 );
    missilescriptable = spawnscriptable( %"saw_scriptable_bongo_cradle_gas_bomb", missileorigin, missileangles );
    missilescriptable.airdropsettings = airdropsettings;
    instance.missilescriptable = missilescriptable;
    playsoundatpos( airdropsettings.droparea.origin + ( 0, 0, 2500 ), #"hash_4f74628170cbe786" );
    wait time;
    missileent = spawn( "script_model", missileorigin );
    missileent.angles = missileangles;
    missileent setmodel( "xcomp_veh_sat_mil_bomb_cradle_cannister" );
    missileent forcenetfieldhighlod( 1 );
    instance.missileent = missileent;
    missileent scriptmodelplayanim( "saw_mp_veh_mil_bomb_cradle_drop", "missile" );
    missilescriptable setscriptablepartstate( "missile", "spawn" );
    wait getdvarfloat( @"scr_missile_impact_time", 2.98 );
    missilescriptable setscriptablepartstate( "missile", "explosion" );
    airdropsettings.extradata.activity thread function_fa389d9b2bb50894();
    missileent waittillmatch( #"missile", #"end" );
    missilescriptable setscriptablepartstate( "missile", "idle" );
    missileent delete();
    level thread function_b11022652c9a2aeb( instance, missilescriptable );
    thread stopgas( missilescriptable );
    level thread function_6e87e1e26ca721db( missilescriptable, instance );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0x134591ed, Offset: 0xfd2
// Size: 0xaa
function function_fa389d9b2bb50894()
{
    foreach ( player in level.players )
    {
        level thread br_public::brleaderdialogplayer( "cradle_bomb_" + self.varianttag + "_explode", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_b02370f3ba96e5c0 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0
// Checksum 0xfbb9df28, Offset: 0x1084
// Size: 0xaa
function function_cbb1956f33ba6bbe()
{
    foreach ( player in level.players )
    {
        level thread br_public::brleaderdialogplayer( "cradle_bomb_" + self.varianttag + "_shrink", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_48e6e6906cd8b872 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0xb768ec37, Offset: 0x1136
// Size: 0x32
function stopgas( missilescriptable )
{
    wait getdvarfloat( @"hash_fd2901a9407ee3da", 15 );
    
    if ( missilescriptable )
    {
        missilescriptable setscriptablepartstate( "missile", "idle_nosmoke" );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2
// Checksum 0xfa32b9b9, Offset: 0x1170
// Size: 0x6f
function function_9a84162b44bb3b58( missileent, missilescriptable )
{
    while ( true )
    {
        if ( isdefined( missileent ) )
        {
            /#
                sphere( missileent gettagorigin( "<dev string:x2b>" ), 300, ( 1, 0, 0 ) );
            #/
        }
        
        if ( isdefined( missilescriptable ) )
        {
            /#
                sphere( missilescriptable.origin, 100, ( 1, 1, 0 ) );
            #/
        }
        
        waitframe();
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0x97feb5ae, Offset: 0x11e7
// Size: 0x58
function function_f1d524c5b838ad8d( instance )
{
    instance notify( #"hash_3dfecad360ebd2e" );
    
    if ( instance.missileent )
    {
        instance.missileent delete();
    }
    
    /#
        if ( instance.missilescriptable )
        {
            instance.missilescriptable freescriptable();
        }
    #/
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2
// Checksum 0x2b6726e4, Offset: 0x1247
// Size: 0x29b
function function_6e87e1e26ca721db( missile, instance )
{
    level endon( #"game_ended" );
    instance endon( #"hash_3dfecad360ebd2e" );
    activity = missile.airdropsettings.extradata.activity;
    activity.missile = missile;
    origin = missile.origin;
    activity.bomborigin = origin;
    
    if ( activity.var_332f929de1894b2b.initialdelay > 0 )
    {
        wait activity.var_332f929de1894b2b.initialdelay;
    }
    
    thread function_43bfc9d52782fe78( activity, origin );
    thread enablezombies( activity, origin );
    expand_seq = [ { #duration:activity.var_332f929de1894b2b.expandtime, #endradius:activity.var_332f929de1894b2b.expandradius, #startradius:activity.var_332f929de1894b2b.initialradius, #endorigin:undefined, #startorigin:origin, #delay:0 } ];
    activity function_90d51d11ccd2a665( expand_seq );
    activity thread callback::callback( "bongo_cradle_gas_expanding", { #activity:activity } );
    activity thread function_274e964565c34bd8( origin );
    activity thread function_fef8f1fd08b3b284( origin );
    activity.missile setscriptablepartstate( "objective", "hidden" );
    
    if ( activity.var_332f929de1894b2b.holdtime > 0 )
    {
        wait activity.var_332f929de1894b2b.holdtime;
    }
    
    shrink_seq = [ { #duration:activity.var_332f929de1894b2b.shrinktime, #endradius:activity.var_332f929de1894b2b.shrinkradius, #startradius:undefined, #endorigin:undefined, #startorigin:undefined, #delay:0 } ];
    activity function_cbb1956f33ba6bbe();
    activity function_90d51d11ccd2a665( shrink_seq );
    
    if ( activity.var_332f929de1894b2b.deletedelay > 0 )
    {
        wait activity.var_332f929de1894b2b.deletedelay;
    }
    
    activity_instance_common::endactivity( activity, 1 );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0x896b7eed, Offset: 0x14ea
// Size: 0xcb
function private function_274e964565c34bd8( origin )
{
    activity = self;
    
    if ( activity.var_332f929de1894b2b.lootdelay < 0 )
    {
        return;
    }
    
    if ( activity.var_332f929de1894b2b.lootdelay > 0 )
    {
        wait activity.var_332f929de1894b2b.lootdelay;
    }
    
    function_28ead9adce9a786e();
    overridestruct = {};
    overridestruct.droporigin = origin;
    overridestruct.dropradius = activity.var_332f929de1894b2b.expandradius * activity.var_332f929de1894b2b.var_3d5b4f6abaacd74c;
    airdrop_scriptbundle::startairdrop( "saw_airdrop_bongo_breach_loot", undefined, undefined, overridestruct );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0xda627991, Offset: 0x15bd
// Size: 0x67
function private function_fef8f1fd08b3b284( origin )
{
    activity = self;
    activity.subactivity = activity_instance_common::function_9b387cb1af0d5b4b( self.var_332f929de1894b2b.subactivity, origin, { #var_2d9a19e909b50b4e:self.varianttag } );
    activity thread function_7e8ed3a00c965e09( activity.subactivity );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0x40d84b0d, Offset: 0x162c
// Size: 0x41
function private function_7e8ed3a00c965e09( subactivity )
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    subactivity waittill( #"instance_destroyed" );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0x1a785f23, Offset: 0x1675
// Size: 0x2c6
function private enablezombies( activity, origin )
{
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    zombiezones = function_99a5f7bfb440cb49( origin, activity.var_332f929de1894b2b.expandradius );
    activity.zombiezones = [];
    
    foreach ( zone in zombiezones )
    {
        activity.zombiezones[ activity.zombiezones.size ] = { #subzoneindex:zone.subzoneindex, #zoneindex:zone.zoneindex, #origin:zone.midpoint };
    }
    
    activity.zombiezones = function_628bac9faa9d1e86( activity.zombiezones, origin );
    activity.var_23fcc91a40fbc75f = -1;
    
    while ( true )
    {
        wait 5;
        
        if ( activity.var_8b752b615d176d4c >= activity.var_332f929de1894b2b.maxspawncount )
        {
            disablezombies( activity );
            continue;
        }
        
        radius = function_5ef02ff9650ff4f7( activity );
        radiussqr = radius * radius;
        
        for ( zoneindex = activity.var_23fcc91a40fbc75f + 1; zoneindex < activity.zombiezones.size ; zoneindex++ )
        {
            zone = activity.zombiezones[ zoneindex ];
            
            if ( distance2dsquared( origin, zone.origin ) <= radiussqr )
            {
                activity.var_23fcc91a40fbc75f++;
                function_695cd9fa39912b71( zone.zoneindex, zone.subzoneindex, activity.var_332f929de1894b2b.var_e6b3b0185b6f0a60 );
                continue;
            }
            
            break;
        }
        
        for ( zoneindex = activity.var_23fcc91a40fbc75f; zoneindex >= 0 ; zoneindex-- )
        {
            zone = activity.zombiezones[ zoneindex ];
            
            if ( distance2dsquared( origin, zone.origin ) > radiussqr )
            {
                activity.var_23fcc91a40fbc75f--;
                function_66de01ae9b978030( zone.zoneindex, zone.subzoneindex, activity.var_332f929de1894b2b.var_e6b3b0185b6f0a60 );
                continue;
            }
            
            break;
        }
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0xa4e5680e, Offset: 0x1943
// Size: 0x88
function private disablezombies( activity )
{
    for ( zoneindex = 0; zoneindex <= activity.var_23fcc91a40fbc75f ; zoneindex++ )
    {
        zone = activity.zombiezones[ zoneindex ];
        function_66de01ae9b978030( zone.zoneindex, zone.subzoneindex, activity.var_332f929de1894b2b.var_e6b3b0185b6f0a60 );
    }
    
    activity.var_23fcc91a40fbc75f = -1;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 3, eflags: 0x4
// Checksum 0x8347e5ff, Offset: 0x19d3
// Size: 0xd8
function private function_695cd9fa39912b71( zoneindex, subzoneindex, zonetag )
{
    if ( !isdefined( level.bongobreach.zombiezones[ zoneindex ] ) )
    {
        level.bongobreach.zombiezones[ zoneindex ] = [];
    }
    
    if ( !isdefined( level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ] ) )
    {
        level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ] = 0;
    }
    
    level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ]++;
    
    if ( level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ] == 1 )
    {
        function_2a814d41ec6b9609( zoneindex, #"hash_377a7499c246237b", 1 );
        function_5866063fb64cf1a9( zoneindex, subzoneindex, zonetag, 1 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 3, eflags: 0x4
// Checksum 0xa5be81d6, Offset: 0x1ab3
// Size: 0xba
function private function_66de01ae9b978030( zoneindex, subzoneindex, zonetag )
{
    level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ]--;
    
    if ( level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ] == 0 )
    {
        level.bongobreach.zombiezones[ zoneindex ][ subzoneindex ] = undefined;
        
        if ( level.bongobreach.zombiezones[ zoneindex ].size == 0 )
        {
            level.bongobreach.zombiezones[ zoneindex ] = undefined;
        }
        
        function_2a814d41ec6b9609( zoneindex, #"hash_377a7499c246237b", 1 );
        function_5866063fb64cf1a9( zoneindex, subzoneindex, zonetag, 0 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0x9b7f4de2, Offset: 0x1b75
// Size: 0x3c
function private function_5ef02ff9650ff4f7( activity )
{
    if ( !isent( activity.exclusionzone ) )
    {
        return 0;
    }
    
    return activity.exclusionzone function_465f674722f8d216()[ 0 ] / 2;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0x5d583a1e, Offset: 0x1bba
// Size: 0x26a
function private function_90d51d11ccd2a665( circle_sequence )
{
    activity = self;
    
    for ( i = 0; i < circle_sequence.size ; i++ )
    {
        step = circle_sequence[ i ];
        
        if ( step.delay )
        {
            wait step.delay;
        }
        
        if ( !activity.exclusionzone )
        {
            origin = utility::drop_to_ground( step.startorigin );
            dimensions = step.startradius * 2;
            zone_id = exclusion_zones::function_13326ea977bfb539( origin, ( dimensions, dimensions, dimensions ), ( 0, 0, 0 ), 1, 1, 2 );
            zone = level.exclusionzones[ zone_id ];
            activity.exclusionzone = zone;
            activity function_aea7d613892bf90a( origin, step.startradius );
        }
        
        if ( step.endradius )
        {
            if ( isent( activity.exclusionzone ) )
            {
                dimensions = step.endradius * 2;
                activity.exclusionzone exclusion_zones::function_a1a887e23f767ba0( ( dimensions, dimensions, dimensions ), step.duration );
            }
            
            activity function_cc7ebc129d0563c4( activity.missile.origin, step.endradius, step.duration );
        }
        else
        {
            activity function_3b34325bd0196234( step.endorigin, int( function_5ef02ff9650ff4f7( activity ) ) );
            endorigin = utility::drop_to_ground( step.endorigin );
            
            if ( step.startorigin )
            {
                startorigin = utility::drop_to_ground( step.startorigin );
                activity.exclusionzone function_640eed49e718161c( startorigin );
            }
            
            activity.exclusionzone function_640eed49e718161c( endorigin, undefined, undefined, step.duration );
            activity function_cc7ebc129d0563c4( endorigin, int( function_5ef02ff9650ff4f7( activity ) ), step.duration );
        }
        
        if ( step.duration )
        {
            wait step.duration;
        }
        
        activity.dangerquestcircle game_utility::questcircle_delete();
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2
// Checksum 0x702194c5, Offset: 0x1e2c
// Size: 0x63
function function_3b34325bd0196234( origin, radius )
{
    if ( !isdefined( self.dangerquestcircle ) )
    {
        self.dangerquestcircle = {};
    }
    
    self.dangerquestcircle game_utility::questcircle_delete();
    self.dangerquestcircle game_utility::questcircle_create( "Danger_Bongo", origin, radius );
    self.dangerquestcircle game_utility::questcircle_showtoall();
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2
// Checksum 0x2e14d1f9, Offset: 0x1e97
// Size: 0x63
function function_aea7d613892bf90a( origin, radius )
{
    if ( !isdefined( self.breachquestcircle ) )
    {
        self.breachquestcircle = {};
    }
    
    self.breachquestcircle game_utility::questcircle_delete();
    self.breachquestcircle game_utility::questcircle_create( "Breach_Bongo", origin, radius );
    self.breachquestcircle game_utility::questcircle_showtoall();
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 3
// Checksum 0x9ff464b9, Offset: 0x1f02
// Size: 0x46
function function_cc7ebc129d0563c4( neworigin, newradius, time )
{
    if ( !self.breachquestcircle game_utility::questcircle_exists() )
    {
        return;
    }
    
    self.breachquestcircle game_utility::questcircle_moveto( neworigin, newradius, time );
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0x2e8932fc, Offset: 0x1f50
// Size: 0x4c
function function_a174abf94915abf2( activity_instance )
{
    if ( activity_instance.dangerquestcircle )
    {
        activity_instance.dangerquestcircle game_utility::questcircle_delete();
    }
    
    if ( activity_instance.breachquestcircle )
    {
        activity_instance.breachquestcircle game_utility::questcircle_delete();
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0xb1c3dc94, Offset: 0x1fa4
// Size: 0xda
function private function_313a7cf1f9f57b8c()
{
    origin = self.bomborigin;
    bombradius = self.var_332f929de1894b2b.expandradius;
    
    foreach ( player in level.players )
    {
        if ( distance2dsquared( player.origin, origin ) <= bombradius * bombradius )
        {
            player thread hud_message::showsplash( "br_bongo_cradle_breach_imminent" );
            continue;
        }
        
        player thread hud_message::showsplash( "br_bongo_killstreak_used_cradle_breach" );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0xadd4538, Offset: 0x2086
// Size: 0x12e
function private function_b22f8c67a9a13827()
{
    origin = self.bomborigin;
    bombradius = self.var_332f929de1894b2b.expandradius;
    
    foreach ( player in level.players )
    {
        if ( distance2dsquared( player.origin, origin ) <= bombradius * bombradius )
        {
            level thread br_public::brleaderdialogplayer( "cradle_bomb_" + self.varianttag + "_deploy_in", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_201382d17e68756b );
            continue;
        }
        
        level thread br_public::brleaderdialogplayer( "cradle_bomb_" + self.varianttag + "_deploy_out", player, 1, undefined, 2, undefined, self.var_332f929de1894b2b.var_8daaf566ed85d298 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0x94898a60, Offset: 0x21bc
// Size: 0x80
function private function_28ead9adce9a786e()
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "br_bongo_cradle_breach_crate_drop" );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0xcf090bff, Offset: 0x2244
// Size: 0x189
function private function_43bfc9d52782fe78( activity, origin )
{
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    activity.aethercaches = br_gametype_bongo::function_bbe3d6cf9ddda498( origin, activity.var_332f929de1894b2b.expandradius );
    activity.aethercaches = function_628bac9faa9d1e86( activity.aethercaches, origin );
    activity.var_b7843ba8e3cf7eb6 = -1;
    
    while ( true )
    {
        wait 5;
        radius = function_5ef02ff9650ff4f7( activity );
        radiussqr = radius * radius;
        
        for ( cacheindex = activity.var_b7843ba8e3cf7eb6 + 1; cacheindex < activity.aethercaches.size ; cacheindex++ )
        {
            cache = activity.aethercaches[ cacheindex ];
            
            if ( distance2dsquared( origin, cache.origin ) <= radiussqr )
            {
                activity.var_b7843ba8e3cf7eb6++;
                function_e5e54b4110a6b8c( cache );
                continue;
            }
            
            break;
        }
        
        for ( cacheindex = activity.var_b7843ba8e3cf7eb6; cacheindex >= 0 ; cacheindex-- )
        {
            cache = activity.aethercaches[ cacheindex ];
            
            if ( distance2dsquared( origin, cache.origin ) > radiussqr )
            {
                activity.var_b7843ba8e3cf7eb6--;
                cache thread function_d27a2e72415f2267( cache, 10 );
                continue;
            }
            
            break;
        }
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0xc45a621d, Offset: 0x23d5
// Size: 0x47
function private function_5af99fe2a14decaf( activity )
{
    for ( cacheindex = 0; cacheindex <= activity.var_b7843ba8e3cf7eb6 ; cacheindex++ )
    {
        thread function_d27a2e72415f2267( activity.aethercaches[ cacheindex ], 10 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0xfb00d250, Offset: 0x2424
// Size: 0x44
function private function_d27a2e72415f2267( cache, delay )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    cache.var_21eb0442f7d3aeff--;
    
    if ( cache.var_21eb0442f7d3aeff == 0 )
    {
        br_gametype_bongo::function_d27a2e72415f2267( cache );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0xc60a8c97, Offset: 0x2470
// Size: 0x44
function private function_e5e54b4110a6b8c( cache )
{
    cache.var_21eb0442f7d3aeff = ( cache.var_21eb0442f7d3aeff ?? 0 ) + 1;
    
    if ( cache.var_21eb0442f7d3aeff == 1 )
    {
        br_gametype_bongo::function_e5e54b4110a6b8c( cache );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0xa48e5555, Offset: 0x24bc
// Size: 0x96, Type: bool
function function_84af973bb1201a35( origin )
{
    foreach ( breachactivity in level.bongobreach.breaches )
    {
        if ( function_f7a0613d888ba72a( breachactivity, origin ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0x4e02e487, Offset: 0x255b
// Size: 0x5c, Type: bool
function private function_f7a0613d888ba72a( activity, origin )
{
    if ( !activity.bomborigin )
    {
        return false;
    }
    
    radius = function_5ef02ff9650ff4f7( activity );
    radiussqr = radius * radius;
    return distance2dsquared( origin, activity.bomborigin ) <= radiussqr;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 3, eflags: 0x4
// Checksum 0xdf4c05ca, Offset: 0x25c0
// Size: 0x1f6
function private function_10046dedb4ec9f21( agent, requestid, spawndata )
{
    requesttags = function_f92267986b091ba3( requestid );
    
    if ( arrayintersection( requesttags, level.bongobreach.tags ).size > 0 )
    {
        level.bongobreach.zombies[ level.bongobreach.zombies.size ] = agent;
        var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
        agent function_fa32376aaa88a7a2( var_41f9287c4987add7.origin, var_41f9287c4987add7.radius * 1.5 );
        
        if ( !isdefined( agent.bongotelemetry ) )
        {
            agent.bongotelemetry = spawnstruct();
        }
        
        agent.bongotelemetry.context = "Cradle_Gas_Pocket";
        agent.bongotelemetry.spawn_request_id = requestid;
        agent.bongotelemetry.encounter = var_41f9287c4987add7.encounterbundle;
        agent.bongotelemetry.encounter_spawn_count = var_41f9287c4987add7.var_f05db2e05804484d;
        agent.bongotelemetry.encounter_killed_count = var_41f9287c4987add7.var_b7cabcb75223b342;
        owningactivity = function_f43e8ce0a8bd27e( agent );
        agent utility::callsharedfunc( #"zombie_utils", #"setmovespeed", owningactivity.var_332f929de1894b2b.var_3583b8fc5ee89f90, "bongo", 1000 );
        
        if ( owningactivity )
        {
            br_activity_util::additemdrops( requestid, owningactivity, agent, spawndata );
            owningactivity.var_8b752b615d176d4c++;
            
            if ( owningactivity.var_8b752b615d176d4c >= owningactivity.var_332f929de1894b2b.maxspawncount )
            {
                disablezombies( owningactivity );
            }
        }
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1
// Checksum 0x526dc449, Offset: 0x27be
// Size: 0xd5
function function_f43e8ce0a8bd27e( agent )
{
    mindistancesq = undefined;
    closestbreach = undefined;
    
    foreach ( breach in level.bongobreach.breaches )
    {
        var_4b946e03cf244ca6 = distance2dsquared( activity_instance_common::function_776ee11e7acc64a5( breach ), agent.origin );
        
        if ( !mindistancesq || var_4b946e03cf244ca6 < mindistancesq )
        {
            mindistancesq = var_4b946e03cf244ca6;
            closestbreach = breach;
        }
    }
    
    return closestbreach;
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 0, eflags: 0x4
// Checksum 0xa3e90ce7, Offset: 0x289c
// Size: 0x1ae
function private managezombies()
{
    level endon( #"game_ended" );
    ai_spawn_director::function_c83497dcedebe189( &function_10046dedb4ec9f21 );
    zombieindex = 0;
    
    while ( true )
    {
        waitframe();
        
        if ( level.bongobreach.zombies.size == 0 )
        {
            continue;
        }
        
        if ( zombieindex >= level.bongobreach.zombies.size )
        {
            zombieindex = 0;
        }
        
        key = getarraykey( level.bongobreach.zombies, zombieindex );
        zombie = level.bongobreach.zombies[ key ];
        zombieindex++;
        
        if ( zombie )
        {
            owningactivity = function_f43e8ce0a8bd27e( zombie );
            
            if ( !isalive( zombie ) )
            {
                if ( owningactivity )
                {
                    owningactivity.var_8b752b615d176d4c--;
                }
                
                level.bongobreach.zombies = arrayremove( level.bongobreach.zombies, zombie );
                continue;
            }
            
            isingas = function_f7a0613d888ba72a( owningactivity, zombie.origin );
            
            if ( !isingas )
            {
                if ( owningactivity )
                {
                    owningactivity.var_8b752b615d176d4c--;
                }
                
                level.bongobreach.zombies = arrayremove( level.bongobreach.zombies, zombie );
                thread killzombie( zombie, ( level.bongobreach.var_b4dd4140901ffcd5 ?? 0 ) + randomfloat( level.bongobreach.var_ca7ec6d2c1b114b5 ?? 0 ) );
            }
        }
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0xb4e65c54, Offset: 0x2a52
// Size: 0x54
function private killzombie( zombie, delay )
{
    zombie endon( #"death" );
    wait delay;
    
    if ( zombie )
    {
        zombie.dontdroploot = 1;
        nuke::function_6c5906115e825d8f( zombie.origin, [ zombie ], undefined, 1 );
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 2, eflags: 0x4
// Checksum 0x238b2b75, Offset: 0x2aae
// Size: 0x129
function private function_b11022652c9a2aeb( instance, missilescriptable )
{
    if ( getdvarint( @"hash_c5085d962fc09b33", 0 ) == 1 )
    {
        crate_count = 4;
        forward_offset = -20;
        base_z_offset = 20;
        z_offset_increment = 50;
        offsetvector = anglestoforward( missilescriptable.angles ) * forward_offset;
        missileorigin = missilescriptable.origin + offsetvector;
        instance.var_cf145135bade3224 = [];
        prefab_brushmodel = getent( "care_package_col", #targetname );
        
        for ( i = 0; i < crate_count ; i++ )
        {
            zoffset = base_z_offset + i * z_offset_increment;
            crateorigin = missileorigin + ( 0, 0, zoffset );
            model = spawn( "script_model", crateorigin );
            model clonebrushmodeltoscriptmodel( prefab_brushmodel );
            instance.var_cf145135bade3224[ instance.var_cf145135bade3224.size ] = model;
        }
    }
}

// Namespace activity_bongo_cradle_gas_bomb
// Params 1, eflags: 0x4
// Checksum 0x580fa4bb, Offset: 0x2bdf
// Size: 0x89
function private function_4efedd41374e980f( instance )
{
    foreach ( crate in instance.var_cf145135bade3224 ?? [] )
    {
        crate delete();
    }
}

/#

    // Namespace activity_bongo_cradle_gas_bomb
    // Params 0
    // Checksum 0x6c331706, Offset: 0x2c70
    // Size: 0x24b, Type: dev
    function debug_missile_locations()
    {
        if ( getdvarint( @"scr_debug_missile_locations", 0 ) == 0 )
        {
            return;
        }
        
        utility::flag_wait( "<dev string:x34>" );
        structs = utility::getstructarray( "<dev string:x4e>", "<dev string:x5d>" );
        level waittill( #"player_spawned", player );
        
        if ( !player isnoclip() )
        {
            player noclip();
        }
        
        index = 0;
        level.devmissile = spawn( "<dev string:x6f>", ( 0, 0, 0 ) );
        level.devmissile.angles = ( 0, 0, 0 );
        level.devmissile setmodel( "<dev string:x7c>" );
        level.devmissile scriptmodelplayanim( "<dev string:x9e>", "<dev string:xbe>" );
        
        while ( true )
        {
            struct = structs[ index ];
            
            if ( !struct.angles )
            {
                struct.angles = ( 0, 0, 0 );
            }
            
            offset = ( -500, 0, 500 );
            org = struct.origin + offset;
            angles = vectortoangles( struct.origin - org );
            player setorigin( org );
            player setplayerangles( angles );
            level.devmissile.origin = struct.origin;
            level.devmissile.angles = struct.angles;
            
            while ( getdvarint( @"scr_missile_next", 0 ) == 0 )
            {
                sphere( struct.origin, 50, ( 0, 1, 0 ), 1, 1 );
                print3d( struct.origin, index + "<dev string:xc6>" + structs.size - 1 + "<dev string:xca>" + struct.origin, ( 1, 1, 0 ) );
                waitframe();
            }
            
            setdvar( @"scr_missile_next", 0 );
            index++;
            
            if ( index >= structs.size )
            {
                index = 0;
            }
        }
    }

#/
