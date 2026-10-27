// scripts\mp\common\supers\redeploy_drone_beacon.gsc  (hash_2357d2da662f08a9.gscc) (size: 14922 Bytes / 0x3a4a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72a91af5 (1923685109)
// size ...... 14922 (0x3a4a)
// includes .. 26  (offset: 0x3732)
// strings ... 35  (offset: 0x3802)
// dev strs .. 10  (offset: 0x39d2)
// exports ... 44  (offset: 0x2256)
// cseg ...... 0x419 + 0x1e3d (0x2256)
// imports ... 122 (offset: 0x2936)
// animtree1 . 0   (offset: 0x3a4a)
// animtree2 . 0   (offset: 0x3a4a)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\functionals_utility;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_redeploy_drone;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace redeploy_drone_beacon;

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x5
// Checksum 0x17ed80b3, Offset: 0x437
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &redeploydronebeaconregister );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0xc902410b, Offset: 0x457
// Size: 0x73
function private redeploydronebeaconregister( params )
{
    if ( isdefined( params.var_a3817c24c60dccd2 ) )
    {
        weapons::registerusedcallback( "redeploy_drone_beacon", &function_1f0cca89fb5560f3 );
        scriptable::scriptable_addusedcallbackbypart( "super_redeploy_drone_beacon", &function_a0ae1275d83d575b );
        utility::registersharedfunc( #"superredeploydronebeacon", #"hash_3dd4fa0f710a2eff", &function_2d081ea2c9d0d3dc );
        initvariables();
        br_redeploy_drone::function_3d109d207b3bed3c();
        
        /#
            initdevgui();
        #/
    }
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0x446a1b0, Offset: 0x4d2
// Size: 0x233
function private initvariables()
{
    level.var_84113f58ceb29def = spawnstruct();
    level.var_84113f58ceb29def.var_99940544898cd60a = [];
    level.var_84113f58ceb29def.var_4559102c9e61b694 = [];
    level.var_84113f58ceb29def.var_64b444b311a94327 = function_fab30c0cb4afb103();
    level.var_84113f58ceb29def.var_44a4a4d9d8cef6a = getdvarfloat( @"hash_fd4c74dc92420799", 60 );
    level.var_84113f58ceb29def.var_5b2b05026adeb2c6 = getdvarfloat( @"hash_b44a498da7e9c4b9", 60 );
    level.var_84113f58ceb29def.var_ea05f6991f62a021 = getdvarint( @"hash_fc527cb8aae04365" );
    level.var_84113f58ceb29def.var_5b5adc941b3eef0b = getdvarint( @"hash_936a0d8dbe3e4d50", 0 );
    level.var_84113f58ceb29def.superbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_redeploy_drone_beacon" );
    level.var_84113f58ceb29def.var_446629d199376e1c = getdvarfloat( @"hash_7b7280da5e242548", 0.3 );
    level.var_84113f58ceb29def.var_196f9af72d3e0ce6 = getdvarfloat( @"hash_65b75e4806eff5c8", 5 );
    level.var_84113f58ceb29def.var_b57299604f9859a6 = level.var_84113f58ceb29def.var_196f9af72d3e0ce6 * 1000;
    character = 0;
    worldtest = 1;
    glass = 1;
    shotclip = 1;
    item = 0;
    vehicle = 1;
    playerclip = 1;
    ainosight = 0;
    itemclip = 0;
    vehicleclip = 1;
    waterclip = 0;
    cameraclip = 0;
    level.var_84113f58ceb29def.physicscontents = trace::create_contents( character, worldtest, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip, vehicleclip, waterclip, cameraclip );
    function_58b9cd8e5390f63a();
    function_5f17c457e1a102fb();
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x9fcd1b7c, Offset: 0x70d
// Size: 0x3d
function private getbrushmodel( targetname )
{
    brushmodel = undefined;
    var_e2ed23938634d061 = getentarray( targetname, "targetname" );
    
    if ( var_e2ed23938634d061.size > 0 )
    {
        brushmodel = var_e2ed23938634d061[ 0 ];
    }
    
    return brushmodel;
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0xdf0d9525, Offset: 0x753
// Size: 0x189
function private function_58b9cd8e5390f63a()
{
    level.var_84113f58ceb29def.var_5a845e43c11f08af = [];
    level.var_84113f58ceb29def.var_5a845e43c11f08af[ 0 ] = getbrushmodel( "dynamic_redeploy_drone" );
    
    if ( !isdefined( level.var_84113f58ceb29def.var_5a845e43c11f08af[ 0 ] ) )
    {
        level.var_84113f58ceb29def.var_5a845e43c11f08af[ 0 ] = getbrushmodel( "dynamic_redeploy_drone_high" );
    }
    
    level.var_84113f58ceb29def.var_5a845e43c11f08af[ 2 ] = getbrushmodel( "dynamic_redeploy_drone_short" );
    level.var_84113f58ceb29def.var_5a845e43c11f08af[ 3 ] = getbrushmodel( "dynamic_redeploy_drone_very_short" );
    level.var_84113f58ceb29def.var_c6aa67b3666df296 = [];
    
    foreach ( dronetype, brushmodel in level.var_84113f58ceb29def.var_5a845e43c11f08af )
    {
        if ( isdefined( brushmodel ) )
        {
            zoffset = ( brushmodel.origin - brushmodel getpointinbounds( 0, 0, -1 ) )[ 2 ];
            level.var_84113f58ceb29def.var_c6aa67b3666df296[ dronetype ] = ( 0, 0, zoffset );
        }
    }
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0x45c67a41, Offset: 0x8e4
// Size: 0x1ac
function private function_5f17c457e1a102fb()
{
    level.var_84113f58ceb29def.movementparameters = spawnstruct();
    level.var_84113f58ceb29def.movementparameters.i_min_speed = getdvarint( @"hash_521bf4fafecb1dca", 60 );
    level.var_84113f58ceb29def.movementparameters.i_max_speed = getdvarint( @"hash_88b474bd6434b0a1", 200 );
    level.var_84113f58ceb29def.movementparameters.var_551db378f3d8f9d9 = getdvarfloat( @"hash_b62baf4cdccb0ac4", 500 );
    level.var_84113f58ceb29def.movementparameters.var_97160ac0ed09c3bb = getdvarfloat( @"hash_d4bce7a24c7fce3", 0.7 );
    level.var_84113f58ceb29def.movementparameters.var_10ba80ea9aef8808 = getdvarfloat( @"hash_1aa5e66fc225fe8d", 10 );
    level.var_84113f58ceb29def.movementparameters.var_bdf1a2f11c76b413 = getdvarfloat( @"hash_c30189c200d92109", 0.5 );
    level.var_84113f58ceb29def.movementparameters.var_f5123fffd5f1ad01 = getdvarfloat( @"hash_9a3a9642c10c1abb", 0.7 );
    level.var_84113f58ceb29def.movementparameters.var_fc5691fd2a2c4b00 = 1;
    level.var_84113f58ceb29def.movementparameters.b_show_objective_icon = getdvarint( @"hash_67b4d342165a62a8", 1 );
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0x885578c0, Offset: 0xa98
// Size: 0x4a
function private function_fab30c0cb4afb103()
{
    if ( isdvardefined( @"hash_44fc3109edd021d8" ) )
    {
        var_ee170620906fa1e3 = getdvarint( @"hash_44fc3109edd021d8" );
    }
    else
    {
        var_a3a9247b786f513f = function_bd2420ff11262fda();
        var_ee170620906fa1e3 = var_a3a9247b786f513f ?? 3000;
    }
    
    return var_ee170620906fa1e3;
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0xe745dfd5, Offset: 0xaeb
// Size: 0xd7
function private function_bd2420ff11262fda()
{
    var_e7d3a1ab0b898fea = br_redeploy_drone::function_e2f8d56220cffff5();
    dronesmaxheight = -2147483647;
    var_8a39ec3fa371e894 = 0;
    
    if ( var_e7d3a1ab0b898fea.size > 0 )
    {
        foreach ( var_77ae4bc307b47e36 in var_e7d3a1ab0b898fea )
        {
            if ( isdefined( var_77ae4bc307b47e36 ) && dronesmaxheight < var_77ae4bc307b47e36.origin[ 2 ] )
            {
                dronesmaxheight = var_77ae4bc307b47e36.origin[ 2 ];
                var_8a39ec3fa371e894 = 1;
            }
        }
    }
    
    return var_8a39ec3fa371e894 ? dronesmaxheight : undefined;
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0x264e9df8, Offset: 0xbcb
// Size: 0x3b
function private function_2d081ea2c9d0d3dc()
{
    if ( isdefined( level.var_84113f58ceb29def ) && isdefined( level.var_84113f58ceb29def.var_99940544898cd60a ) )
    {
        return level.var_84113f58ceb29def.var_99940544898cd60a;
    }
    
    return [];
}

// Namespace redeploy_drone_beacon
// Params 2, eflags: 0x4
// Checksum 0x1ba38696, Offset: 0xc0f
// Size: 0x40
function private function_48376b58a631055c( messageref, var_f3f0e1a3ca12dad9 )
{
    player = self;
    
    if ( var_f3f0e1a3ca12dad9 )
    {
        player playlocalsound( "fly_pickup_deny" );
    }
    
    player lower_message::setlowermessageomnvar( messageref, undefined, 5 );
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0x6767b555, Offset: 0xc57
// Size: 0x4a
function private function_5e80cd52e9aaf9b3()
{
    player = self;
    candeploy = 1;
    failurereason = "";
    
    if ( player isswimming() )
    {
        candeploy = 0;
        failurereason = "redeploy_drone_beacon_player_swimming";
    }
    
    return [ candeploy, failurereason ];
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x5b7ece58, Offset: 0xcaa
// Size: 0x203
function private function_1f0cca89fb5560f3( grenade )
{
    player = self;
    beacon = grenade;
    
    if ( !isdefined( beacon ) )
    {
        return;
    }
    
    beacon endon( #"death" );
    level endon( #"game_ended" );
    beacon.bundle = level.var_84113f58ceb29def.superbundle;
    function_febbf08f8d5ff5b5( player );
    
    if ( isdefined( player ) )
    {
        level.var_84113f58ceb29def.var_4559102c9e61b694[ player getentitynumber() ] = beacon;
    }
    
    beacon waittill( #"missile_stuck" );
    beacon thread damage::monitordamage( beacon.bundle.maxhealth, "hitequip", &beacon_handlefataldamage, &functionals_utility::function_cdfa6ea614436cc, 0 );
    beacon haywire::function_7f69a1eb3d590f76( &function_b71530d08035e82a );
    [ redeploydronetype, var_39acc192cf8b5b7d ] = function_1cb50bd1b9afca23( beacon.origin );
    [ var_6e3627af6b3fcb27, failurereason ] = function_dc655e1a815473cd( beacon, var_39acc192cf8b5b7d );
    utility::function_969f9f5596dba07a( beacon, &function_b71530d08035e82a );
    
    /#
        thread function_58292be7f9335e94( player, beacon, var_39acc192cf8b5b7d );
    #/
    
    if ( var_6e3627af6b3fcb27 )
    {
        beacon setscriptablepartstate( "super_redeploy_drone_beacon", "connected_to_drone" );
        thread function_ebc9af355a671df( beacon, var_39acc192cf8b5b7d, redeploydronetype, player );
        challenges::function_4cfe18f48cc7a55c( player, undefined, "redeploy_beacon" );
        challenges::function_a0936b0e5b4550f3( "super_personal_redeploy_drone", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
        return;
    }
    
    beacon setscriptablepartstate( "super_redeploy_drone_beacon", "disconnected_from_drone" );
    beacon function_f686fbd2674f8ee8( player );
    beacon.headiconid = beacon entityheadicons::setheadicon_factionimage( 0, 10 );
    thread function_e2a57cc053399752( beacon );
    function_48376b58a631055c( failurereason );
    level thread br_analytics::function_57c1853cf6070a76( 0 );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x9d91aa5e, Offset: 0xeb5
// Size: 0x44
function private function_febbf08f8d5ff5b5( player )
{
    beacon = undefined;
    
    if ( isdefined( player ) )
    {
        beacon = level.var_84113f58ceb29def.var_4559102c9e61b694[ player getentitynumber() ];
    }
    
    function_983d8d57bfd53ce3( beacon );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0xf549aef4, Offset: 0xf01
// Size: 0x35
function private beacon_handlefataldamage( data )
{
    beacon = self;
    beacon beacon_givepointsfordeath( data.attacker );
    function_983d8d57bfd53ce3( self );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x66a9a95b, Offset: 0xf3e
// Size: 0x15e
function private function_1cb50bd1b9afca23( positiononground )
{
    var_500a806248824ec7 = positiononground[ 2 ];
    redeploydronetype = undefined;
    cablelength = undefined;
    
    /#
        var_24519650b345291e = getdvar( @"hash_a020da1472e07198", "<dev string:x24>" );
        
        if ( var_24519650b345291e == "<dev string:x25>" || var_24519650b345291e == "<dev string:x2d>" )
        {
            redeploydronetype = 0;
            cablelength = 2744;
            return [ redeploydronetype, cablelength ];
        }
        else if ( var_24519650b345291e == "<dev string:x34>" )
        {
            redeploydronetype = 2;
            cablelength = 2254;
            return [ redeploydronetype, cablelength ];
        }
        else if ( var_24519650b345291e == "<dev string:x3a>" || var_24519650b345291e == "<dev string:x45>" )
        {
            redeploydronetype = 3;
            cablelength = 1636;
            return [ redeploydronetype, cablelength ];
        }
    #/
    
    if ( var_500a806248824ec7 + 2744 <= level.var_84113f58ceb29def.var_64b444b311a94327 )
    {
        redeploydronetype = 0;
        cablelength = 2744;
    }
    else if ( var_500a806248824ec7 + 2254 <= level.var_84113f58ceb29def.var_64b444b311a94327 )
    {
        redeploydronetype = 2;
        cablelength = 2254;
    }
    else
    {
        redeploydronetype = 3;
        cablelength = 1636;
    }
    
    if ( !isdefined( level.var_84113f58ceb29def.var_5a845e43c11f08af[ redeploydronetype ] ) )
    {
        redeploydronetype = 0;
        cablelength = 2744;
    }
    
    return [ redeploydronetype, cablelength ];
}

// Namespace redeploy_drone_beacon
// Params 2, eflags: 0x4
// Checksum 0x6e2eab12, Offset: 0x10a5
// Size: 0x123
function private function_dc655e1a815473cd( beacon, var_39acc192cf8b5b7d )
{
    canspawn = 1;
    failurereason = "";
    var_d0b43a20707ea6d9 = utility::function_e153375527829ec3( level.redeploy_drone_info_struct.movingdrones, [] );
    var_d0b43a20707ea6d9[ var_d0b43a20707ea6d9.size ] = beacon;
    
    if ( level.var_84113f58ceb29def.var_ea05f6991f62a021 && level.var_84113f58ceb29def.var_99940544898cd60a.size >= level.var_84113f58ceb29def.var_ea05f6991f62a021 )
    {
        canspawn = 0;
        failurereason = "redeploy_drone_beacon_max_drones_limit_reached";
    }
    else if ( beacon islinked() )
    {
        canspawn = 0;
        failurereason = "redeploy_drone_beacon_moving_platforms_not_allowed";
    }
    else if ( outofbounds::ispointinoutofbounds( beacon.origin ) )
    {
        canspawn = 0;
        failurereason = "redeploy_drone_beacon_oob";
    }
    else if ( !function_cabdc37291d265c8( beacon, var_39acc192cf8b5b7d, var_d0b43a20707ea6d9 ) )
    {
        canspawn = 0;
        failurereason = "redeploy_drone_beacon_insufficient_space";
    }
    else if ( !function_19e3a546dd5016d3( beacon, var_39acc192cf8b5b7d, var_d0b43a20707ea6d9 ) )
    {
        canspawn = 0;
        failurereason = "redeploy_drone_beacon_insufficient_space";
    }
    
    return [ canspawn, failurereason ];
}

// Namespace redeploy_drone_beacon
// Params 3, eflags: 0x4
// Checksum 0x388535a0, Offset: 0x11d1
// Size: 0x9d, Type: bool
function private function_cabdc37291d265c8( beacon, var_609a8d45a401712a, var_d0b43a20707ea6d9 )
{
    targetpositiononground = beacon.origin;
    var_9681c1c8f6304ed9 = 1;
    var_3a60ebaf56fd4086 = targetpositiononground + ( -90, -90, var_609a8d45a401712a - 50 );
    var_3a83fdaf5723afd4 = targetpositiononground + ( 90, 90, var_609a8d45a401712a + 50 );
    hashit = physics_aabbquery( var_3a60ebaf56fd4086, var_3a83fdaf5723afd4, level.var_84113f58ceb29def.physicscontents, var_d0b43a20707ea6d9, "physicsquery_any", var_9681c1c8f6304ed9 );
    return !hashit;
}

// Namespace redeploy_drone_beacon
// Params 3, eflags: 0x4
// Checksum 0x205de01, Offset: 0x1277
// Size: 0x89, Type: bool
function private function_19e3a546dd5016d3( beacon, var_609a8d45a401712a, var_d0b43a20707ea6d9 )
{
    [ cablestartposition, cableendposition, sphereradius ] = function_7e8a1767296c22c2( beacon, var_609a8d45a401712a );
    hasfreespace = trace::sphere_trace_passed( cablestartposition, cableendposition, sphereradius, var_d0b43a20707ea6d9, level.var_84113f58ceb29def.physicscontents );
    return istrue( hasfreespace );
}

// Namespace redeploy_drone_beacon
// Params 2, eflags: 0x4
// Checksum 0x4eef5f96, Offset: 0x1309
// Size: 0x7d
function private function_7e8a1767296c22c2( beacon, var_609a8d45a401712a )
{
    var_47eadb96cc01a60 = 70;
    sphereradius = 21;
    cablestartposition = beacon.origin + ( 0, 0, var_609a8d45a401712a );
    cableendposition = beacon.origin + ( 0, 0, var_47eadb96cc01a60 + sphereradius );
    return [ cablestartposition, cableendposition, sphereradius ];
}

// Namespace redeploy_drone_beacon
// Params 5
// Checksum 0x47315a69, Offset: 0x138f
// Size: 0x152
function function_ebc9af355a671df( beacon, var_9f43d9d20c3ceb38, redeploydronetype, ownerplayer, scriptableoverride )
{
    level endon( #"game_ended" );
    function_aaea23d1e4dfe58a( ownerplayer );
    stationaryredeploydrone = function_b0dbc633d5ee4a19( beacon, var_9f43d9d20c3ceb38, redeploydronetype, scriptableoverride );
    stationaryredeploydrone thread watchgameended();
    stationaryredeploydrone thread function_ea7d84813d178622();
    var_b92c815eeebde2e = function_f31faa23480fab4e( ownerplayer, stationaryredeploydrone.origin );
    departurescriptable = undefined;
    targetscriptable = stationaryredeploydrone;
    var_bfdd887656bee07c = 1;
    var_2c89aec68e0f8239 = 1;
    
    /#
        function_5f17c457e1a102fb();
    #/
    
    var_c053aa99fadec150 = br_redeploy_drone::function_baa604d4fd5d4f8b( var_b92c815eeebde2e, departurescriptable, targetscriptable, redeploydronetype, var_bfdd887656bee07c, var_2c89aec68e0f8239, level.var_84113f58ceb29def.movementparameters );
    
    if ( var_c053aa99fadec150 )
    {
        stationaryredeploydrone br_redeploy_drone::set_redeploy_drone_available();
        stationaryredeploydrone function_209f89a0619f52fb();
        stationaryredeploydrone thread function_11af88963d229c78( redeploydronetype );
        stationaryredeploydrone thread function_6510cc0c22532795( redeploydronetype );
        stationaryredeploydrone thread function_564f1ce4838346a9( ownerplayer );
        stationaryredeploydrone thread function_3d86928823a0d849( beacon );
        
        if ( isdefined( beacon ) )
        {
            beacon setscriptablepartstate( "super_redeploy_drone_beacon", "inactive" );
        }
        
        return;
    }
    
    function_84844726fa2c77e6( stationaryredeploydrone );
}

// Namespace redeploy_drone_beacon
// Params 2, eflags: 0x4
// Checksum 0x458a563c, Offset: 0x14e9
// Size: 0x65
function private function_f31faa23480fab4e( ownerplayer, var_e34ce8a55488e525 )
{
    if ( !isdefined( ownerplayer ) )
    {
        return ( var_e34ce8a55488e525 + ( 0, 0, 2800 ) );
    }
    
    horizontaldir = var_e34ce8a55488e525 - ownerplayer.origin;
    horizontaldir = vectornormalize2( horizontaldir );
    return var_e34ce8a55488e525 + ( horizontaldir[ 0 ] * -500, horizontaldir[ 1 ] * -500, 2800 );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x6213e124, Offset: 0x1557
// Size: 0xaa
function private function_f686fbd2674f8ee8( ownerplayer )
{
    beacon = self;
    
    if ( isdefined( ownerplayer ) )
    {
        beacon enablescriptableplayeruse( ownerplayer );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            if ( player != ownerplayer )
            {
                beacon disablescriptableplayeruse( player );
            }
        }
    }
}

// Namespace redeploy_drone_beacon
// Params 4, eflags: 0x4
// Checksum 0xcc92fe06, Offset: 0x1609
// Size: 0x157
function private function_b0dbc633d5ee4a19( beacon, var_9f43d9d20c3ceb38, redeploydronetype, scriptableoverride )
{
    spawnpositiononground = beacon.origin;
    spawnposition = spawnpositiononground + ( 0, 0, var_9f43d9d20c3ceb38 );
    scriptablesnames = [ "scriptable_redeploy_drone", "scriptable_redeploy_drone_extended", "scriptable_redeploy_drone_short", "scriptable_redeploy_drone_very_short" ];
    scriptablename = scriptableoverride ?? scriptablesnames[ redeploydronetype ];
    stationarydrone = spawnscriptable( scriptablename, spawnposition );
    assert( isdefined( stationarydrone ) );
    stationarydrone setscriptablepartstate( "redeploy_drone", "unavailable" );
    stationarydrone.var_bd4fec0091dedb5c = spawnpositiononground;
    stationarydrone.isredeploydrone = 1;
    stationarydrone.beacon = beacon;
    stationarydrone.var_fa94b25ca4c43790 = 1;
    stationarydrone.redeploydronetype = redeploydronetype;
    stationarydrone.b_skip_repopulate = 1;
    stationarydrone.b_skip_replace = 1;
    level.var_84113f58ceb29def.var_99940544898cd60a[ level.var_84113f58ceb29def.var_99940544898cd60a.size ] = stationarydrone;
    level thread br_analytics::function_57c1853cf6070a76( 1 );
    return stationarydrone;
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0xbe669b6c, Offset: 0x1769
// Size: 0xc3
function private function_209f89a0619f52fb()
{
    stationarydrone = self;
    assert( isdefined( level.var_84113f58ceb29def.var_5a845e43c11f08af[ stationarydrone.redeploydronetype ] ), "<dev string:x4f>" );
    spawnpositiononground = stationarydrone.var_bd4fec0091dedb5c;
    brushmodelspawnposition = spawnpositiononground + level.var_84113f58ceb29def.var_c6aa67b3666df296[ stationarydrone.redeploydronetype ];
    stationarydrone.brushmodel = spawn( "script_model", brushmodelspawnposition );
    stationarydrone.brushmodel clonebrushmodeltoscriptmodel( level.var_84113f58ceb29def.var_5a845e43c11f08af[ stationarydrone.redeploydronetype ] );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0xb37e5b1f, Offset: 0x1834
// Size: 0xa0
function private function_6510cc0c22532795( redeploydronetype )
{
    stationaryredeploydrone = self;
    
    if ( !isdefined( stationaryredeploydrone.brushmodel ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    stationaryredeploydrone endon( #"death" );
    stationaryredeploydrone endon( #"redeploy_drone_destroyed" );
    
    while ( true )
    {
        stationaryredeploydrone.brushmodel waittill( #"touching_platform" );
        
        if ( stationaryredeploydrone getscriptablepartstate( "redeploy_drone" ) == "available" )
        {
            stationaryredeploydrone.var_620062056e436253 = 1;
            stationaryredeploydrone notify( #"force_drone_departure" );
            return;
        }
        
        waitframe();
    }
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0xf9d3369, Offset: 0x18dc
// Size: 0xfe
function private function_aaea23d1e4dfe58a( ownerplayer )
{
    if ( !isdefined( ownerplayer ) )
    {
        return;
    }
    
    var_ef832427c68eff57 = teams::getteamdata( ownerplayer.team, "alivePlayers" );
    
    foreach ( var_57b719901237f64d in var_ef832427c68eff57 )
    {
        if ( !isdefined( var_57b719901237f64d ) || var_57b719901237f64d br_public::isplayerinorgoingtogulag() || var_57b719901237f64d.extracted || isbot( var_57b719901237f64d ) )
        {
            continue;
        }
        
        if ( level.var_84113f58ceb29def.var_5b5adc941b3eef0b && var_57b719901237f64d == ownerplayer )
        {
            continue;
        }
        
        var_57b719901237f64d thread hud_message::showsplash( "br_redeploy_drone_beacon_notification", undefined, ownerplayer );
    }
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0xc
// Checksum 0xf8762c12, Offset: 0x19e2
// Size: 0x9e
function private function_30c77e5f99495a14( var_723f4827ff8bee0e )
{
    self notify( #"hash_d6b097ff681ee71b" );
    self endon( #"hash_d6b097ff681ee71b" );
    wait level.var_84113f58ceb29def.var_446629d199376e1c;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_b00939656410ff3a = gettime() - ( self.var_7f8b13390aaca2ad ?? 0 );
    
    if ( var_b00939656410ff3a < level.var_84113f58ceb29def.var_b57299604f9859a6 )
    {
        return;
    }
    
    if ( self isonascender() )
    {
        var_723f4827ff8bee0e points::doscoreevent( #"super_redeploy_drone_beacon_supporting_teammate" );
        self.var_7f8b13390aaca2ad = gettime();
    }
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x4c1d912b, Offset: 0x1a88
// Size: 0xa7
function private function_564f1ce4838346a9( var_723f4827ff8bee0e )
{
    stationaryredeploydrone = self;
    
    if ( !isdefined( var_723f4827ff8bee0e ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    var_723f4827ff8bee0e endon( #"death_or_disconnect" );
    stationaryredeploydrone endon( #"death" );
    stationaryredeploydrone endon( #"redeploy_drone_destroyed" );
    
    while ( true )
    {
        stationaryredeploydrone waittill( #"redeploy_drone_scriptable_used", var_37ab4be4fe43eb33 );
        
        if ( isdefined( var_37ab4be4fe43eb33 ) && var_37ab4be4fe43eb33.team == var_723f4827ff8bee0e.team && var_37ab4be4fe43eb33 != var_723f4827ff8bee0e )
        {
            var_37ab4be4fe43eb33 childthread function_30c77e5f99495a14( var_723f4827ff8bee0e );
        }
    }
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0xb6ca4f5e, Offset: 0x1b37
// Size: 0x60
function private function_3d86928823a0d849( beacon )
{
    stationaryredeploydrone = self;
    level endon( #"game_ended" );
    stationaryredeploydrone endon( #"death" );
    stationaryredeploydrone endon( #"redeploy_drone_destroyed" );
    
    if ( isdefined( beacon ) )
    {
        beacon waittill( #"death" );
    }
    
    stationaryredeploydrone notify( #"force_drone_departure" );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x8c5e73c5, Offset: 0x1b9f
// Size: 0x96
function private function_84844726fa2c77e6( stationaryredeploydrone )
{
    level.var_84113f58ceb29def.var_99940544898cd60a = arrayremove( level.var_84113f58ceb29def.var_99940544898cd60a, stationaryredeploydrone );
    
    if ( stationaryredeploydrone getscriptablepartstate( "redeploy_drone" ) == "available" )
    {
        stationaryredeploydrone br_redeploy_drone::set_redeploy_drone_unavailable();
    }
    
    function_cda45129efacf721( stationaryredeploydrone.brushmodel );
    function_983d8d57bfd53ce3( stationaryredeploydrone.beacon );
    stationaryredeploydrone freescriptable();
    level thread br_analytics::function_9f3cb493eb7c33ee();
    stationaryredeploydrone notify( #"death" );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x473d94fc, Offset: 0x1c3d
// Size: 0x19
function private function_cda45129efacf721( brushmodel )
{
    if ( isdefined( brushmodel ) )
    {
        brushmodel delete();
    }
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0xfb033355, Offset: 0x1c5e
// Size: 0x32
function private watchgameended()
{
    stationaryredeploydrone = self;
    stationaryredeploydrone endon( #"death" );
    level waittill( #"game_ended" );
    function_84844726fa2c77e6( stationaryredeploydrone );
}

// Namespace redeploy_drone_beacon
// Params 0, eflags: 0x4
// Checksum 0x43a4d7ff, Offset: 0x1c98
// Size: 0x33
function private function_ea7d84813d178622()
{
    stationaryredeploydrone = self;
    stationaryredeploydrone endon( #"death" );
    stationaryredeploydrone waittill( #"redeploy_drone_destroyed" );
    function_84844726fa2c77e6( stationaryredeploydrone );
}

// Namespace redeploy_drone_beacon
// Params 6, eflags: 0x4
// Checksum 0xbccfa422, Offset: 0x1cd3
// Size: 0x199
function private function_a0ae1275d83d575b( instance, part, state, player, bautouse, usestring )
{
    if ( !( isdefined( instance ) && isdefined( player ) ) )
    {
        return;
    }
    
    beacon = instance;
    itemgiven = 0;
    var_fef370645e63bc2a = istrue( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) );
    
    if ( var_fef370645e63bc2a )
    {
        scriptablename = common_item::function_70d4affb770e8103( "super_redeploy_drone_beacon" );
        item = { #count:1, #type:scriptablename };
        itemgiven = player common_item::function_2b5e2ff57d5f392( item, 0, 0 );
    }
    else
    {
        itemgiven = br_pickups::br_forcegivecustompickupitem( player, "brloot_super_redeploy_drone_beacon", 1, 1 );
    }
    
    if ( itemgiven )
    {
        view_origin = player getvieworigin();
        var_b8b2f39fcba6d824 = 0;
        quantity = 1;
        
        if ( var_fef370645e63bc2a )
        {
            level thread common_item::function_e8dfe5e68a7a03b4( player, level.var_84113f58ceb29def.superbundle );
        }
        else
        {
            player br_pickups::function_55de798ca5dc4080( 82841, view_origin, var_b8b2f39fcba6d824, quantity );
        }
        
        hasexplosion = 0;
        function_983d8d57bfd53ce3( beacon.entity, hasexplosion );
        callbackparams = { #supername:"super_redeploy_drone_beacon", #player:player };
        callback::callback( #"super_reclaimed", callbackparams );
    }
}

// Namespace redeploy_drone_beacon
// Params 2, eflags: 0x4
// Checksum 0x247a6a9, Offset: 0x1e74
// Size: 0x42
function private function_983d8d57bfd53ce3( beacon, hasexplosion )
{
    hasexplosion = hasexplosion ?? 1;
    
    if ( isdefined( beacon ) )
    {
        if ( hasexplosion )
        {
            thread function_de3ccd022f011713( beacon.origin );
        }
        
        beacon delete();
    }
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x45806bee, Offset: 0x1ebe
// Size: 0x46
function private function_de3ccd022f011713( spawnposition )
{
    if ( level.gameended )
    {
        return;
    }
    
    explosion = spawnscriptable( "super_redeploy_drone_beacon_explosion", spawnposition );
    level utility::waittill_any_timeout( 5, "game_ended" );
    explosion freescriptable();
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x59cb8920, Offset: 0x1f0c
// Size: 0x58
function private function_e2a57cc053399752( beacon )
{
    if ( !isdefined( beacon ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    beacon endon( #"death" );
    waittime = level.var_84113f58ceb29def.var_5b2b05026adeb2c6;
    wait waittime;
    function_983d8d57bfd53ce3( beacon );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x620cfa96, Offset: 0x1f6c
// Size: 0xc7
function private function_11af88963d229c78( redeploydronetype )
{
    stationaryredeploydrone = self;
    stationaryredeploydrone notify( #"hash_7d446bd565644380" );
    stationaryredeploydrone endon( #"hash_7d446bd565644380" );
    level endon( #"game_ended" );
    stationaryredeploydrone endon( #"death" );
    stationaryredeploydrone endon( #"redeploy_drone_destroyed" );
    waittime = level.var_84113f58ceb29def.var_44a4a4d9d8cef6a;
    stationaryredeploydrone utility::waittill_any_timeout( waittime, "force_drone_departure" );
    function_983d8d57bfd53ce3( stationaryredeploydrone.beacon );
    function_cda45129efacf721( stationaryredeploydrone.brushmodel );
    stationaryredeploydrone br_redeploy_drone::function_5feb841850cc465d( redeploydronetype, stationaryredeploydrone.var_620062056e436253 );
    function_84844726fa2c77e6( stationaryredeploydrone );
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0x3c459c64, Offset: 0x203b
// Size: 0x5b
function private beacon_givepointsfordeath( attacker )
{
    beacon = self;
    
    if ( isplayer( attacker ) && isdefined( beacon.owner ) && player_utility::playersareenemies( beacon.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
}

// Namespace redeploy_drone_beacon
// Params 1, eflags: 0x4
// Checksum 0xbb94c88, Offset: 0x209e
// Size: 0x22
function private function_b71530d08035e82a( data )
{
    beacon = self;
    function_983d8d57bfd53ce3( beacon );
}

/#

    // Namespace redeploy_drone_beacon
    // Params 0, eflags: 0x4
    // Checksum 0x9e7fcb7d, Offset: 0x20c8
    // Size: 0x29, Type: dev
    function private initdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x99>" );
        devgui::add_devgui_command( "<dev string:xbe>", "<dev string:xd4>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace redeploy_drone_beacon
    // Params 3, eflags: 0x4
    // Checksum 0xb413e1b2, Offset: 0x20f9
    // Size: 0xb9, Type: dev
    function private function_58292be7f9335e94( player, beacon, var_39acc192cf8b5b7d )
    {
        if ( !( isdefined( player ) && isdefined( beacon ) ) )
        {
            return;
        }
        
        player endon( #"disconnect" );
        beacon endon( #"death" );
        level endon( #"game_ended" );
        waittime = 0.5;
        var_7dcefe966ed44576 = ( 1, 0, 0 );
        
        while ( true )
        {
            wait waittime;
            isdebugenabled = getdvarint( @"hash_e0b5816cbcf9bbd1", 0 ) == 1;
            
            if ( !isdebugenabled )
            {
                continue;
            }
            
            function_6d788666a4327191( beacon, var_39acc192cf8b5b7d, waittime, var_7dcefe966ed44576 );
        }
    }

    // Namespace redeploy_drone_beacon
    // Params 4, eflags: 0x4
    // Checksum 0x553777d2, Offset: 0x21ba
    // Size: 0x9c, Type: dev
    function private function_6d788666a4327191( beacon, var_39acc192cf8b5b7d, waittime, var_7dcefe966ed44576 )
    {
        [ cablestartposition, cableendposition, sphereradius ] = function_7e8a1767296c22c2( beacon, var_39acc192cf8b5b7d );
        level thread debug_utility::drawcylinder( cablestartposition, sphereradius, cableendposition[ 2 ] - cablestartposition[ 2 ], waittime, var_7dcefe966ed44576 );
        level thread debug::drawsphere( cablestartposition, sphereradius, waittime, var_7dcefe966ed44576 );
        level thread debug::drawsphere( cableendposition, sphereradius, waittime, var_7dcefe966ed44576 );
    }

#/
