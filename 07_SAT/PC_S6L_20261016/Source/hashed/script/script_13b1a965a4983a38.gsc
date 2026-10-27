// script_13b1a965a4983a38  (hash_13b1a965a4983a38.gscc) (size: 15787 Bytes / 0x3dab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb7165e5 (4218512869)
// size ...... 15787 (0x3dab)
// includes .. 12  (offset: 0x3c97)
// strings ... 10  (offset: 0x3cf7)
// dev strs .. 1   (offset: 0x3d9b)
// exports ... 46  (offset: 0x287b)
// cseg ...... 0xec + 0x278f (0x287b)
// imports ... 97  (offset: 0x2fab)
// animtree1 . 0   (offset: 0x3dab)
// animtree2 . 0   (offset: 0x3dab)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\challenges_super;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;

#namespace jamming_system;

// Namespace jamming_system
// Params 0, eflags: 0x5
// Checksum 0x8b412fed, Offset: 0x10a
// Size: 0x263
function private autoexec main()
{
    level.jammingsystem = spawnstruct();
    level.jammingsystem.jammers = [];
    level.jammingsystem.var_28f210801095b778 = [];
    level.jammingsystem.var_f00386c701be7d81 = [];
    level.jammingsystem.var_f6387355c38eb8cc = 0;
    utility::registersharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", &function_b912ba1013990a58 );
    utility::registersharedfunc( #"jamming_system", #"hash_216d35a250cd860", &function_5c6a54d3c64b4881 );
    utility::registersharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", &function_12a403954753b2f5 );
    utility::registersharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", &function_f56a7ebc33ed463e );
    utility::registersharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", &function_20676e4fc4b96d0f );
    utility::registersharedfunc( #"jamming_system", #"hash_eb3c0dbf85c7f9de", &function_f78cfa4878bca77 );
    utility::registersharedfunc( #"jamming_system", #"registerjammer", &registerjammer );
    utility::registersharedfunc( #"jamming_system", #"deregisterjammer", &deregisterjammer );
    utility::registersharedfunc( #"jamming_system", #"hash_775c9b54e8085ae5", &function_bd0dbed54fbea4c2 );
    utility::registersharedfunc( #"jamming_system", #"hash_932edf414448e544", &function_428ea07fad49adf5 );
    utility::registersharedfunc( #"jamming_system", #"hash_23b4b2c8dfb75cde", &function_5a51435bfc2884a5 );
    utility::registersharedfunc( #"jamming_system", #"hash_f3a152be2dbc14b9", &function_232bea647a55e038 );
    utility::registersharedfunc( #"jamming_system", #"hash_a747cb95effb8523", &function_7bd4681d75dfcc00 );
    utility::registersharedfunc( #"jamming_system", #"hash_a9ecee5e61a86c7b", &function_40eda81e88c07d28 );
    utility::registersharedfunc( #"jamming_system", #"hash_6ce58048ce76814e", &function_807f605103879c39 );
    level callback::add( #"player_spawned", &onplayerspawned );
    level callback::add( #"loadout_given", &function_9cd6f2e7c37b4eea );
    level callback::add( "equipped_super", &function_255d9f6d68572aaf );
}

// Namespace jamming_system
// Params 1
// Checksum 0x3a72cb11, Offset: 0x375
// Size: 0x43
function onplayerspawned( params )
{
    if ( !isdefined( self.var_3702583f19e5f23b ) )
    {
        self.var_3702583f19e5f23b = [];
    }
    
    if ( !isdefined( self.var_bac127f4577a821e ) )
    {
        self.var_bac127f4577a821e = [];
    }
    
    self.var_952f9b24fe7ae1e4 = 1;
}

// Namespace jamming_system
// Params 1
// Checksum 0x81af1c26, Offset: 0x3c0
// Size: 0x44
function function_9cd6f2e7c37b4eea( params )
{
    if ( isdefined( self.perks[ "specialty_perceptive" ] ) || isdefined( self.perks[ "specialty_scrambler_resist" ] ) )
    {
        function_73fb16848d9607d7();
        return;
    }
    
    function_6f46bd56952345a8();
}

// Namespace jamming_system
// Params 0
// Checksum 0xdba73c46, Offset: 0x40c
// Size: 0x83, Type: bool
function function_7bd4681d75dfcc00()
{
    if ( !( isdefined( self ) && isdefined( level.jammingsystem.var_c37e347f5a8e0065 ) ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"player", #"getcurrentsuperref" ) )
    {
        superref = self [[ utility::getsharedfunc( #"player", #"getcurrentsuperref" ) ]]();
    }
    
    return isdefined( superref ) && arraycontains( level.jammingsystem.var_c37e347f5a8e0065, superref );
}

// Namespace jamming_system
// Params 1
// Checksum 0x9f830925, Offset: 0x498
// Size: 0x2c, Type: bool
function function_428ea07fad49adf5( player )
{
    return isdefined( player.var_3702583f19e5f23b[ self.entnum ?? utility::get_entity_number( self ) ] );
}

// Namespace jamming_system
// Params 0
// Checksum 0xf1ac050, Offset: 0x4cd
// Size: 0xe, Type: bool
function function_5a51435bfc2884a5()
{
    return self.var_3702583f19e5f23b.size > 0;
}

// Namespace jamming_system
// Params 0
// Checksum 0xd5b1d3e7, Offset: 0x4e4
// Size: 0xe, Type: bool
function function_232bea647a55e038()
{
    return self.var_bac127f4577a821e.size > 0;
}

// Namespace jamming_system
// Params 1
// Checksum 0xca110bf9, Offset: 0x4fb
// Size: 0x28
function function_40eda81e88c07d28( count )
{
    if ( isdefined( count ) )
    {
        level.jammingsystem.var_f6387355c38eb8cc = count;
    }
}

// Namespace jamming_system
// Params 1
// Checksum 0x9adcbfc7, Offset: 0x52b
// Size: 0x6a
function function_f78cfa4878bca77( var_676aeb43f5fd4e65 )
{
    if ( !isdefined( var_676aeb43f5fd4e65 ) )
    {
        return;
    }
    
    if ( !isdefined( level.jammingsystem.var_c37e347f5a8e0065 ) )
    {
        level.jammingsystem.var_c37e347f5a8e0065 = [];
    }
    
    level.jammingsystem.var_c37e347f5a8e0065[ level.jammingsystem.var_c37e347f5a8e0065.size ] = var_676aeb43f5fd4e65;
}

// Namespace jamming_system
// Params 3
// Checksum 0x7b84fde1, Offset: 0x59d
// Size: 0x72
function function_b912ba1013990a58( var_676aeb43f5fd4e65, var_49ec4152aad7790b, var_80341f0ab80f4d5f )
{
    assert( isdefined( var_676aeb43f5fd4e65 ) );
    var_676aeb43f5fd4e65.var_d2bfd30f061e7f56 = var_49ec4152aad7790b;
    var_676aeb43f5fd4e65.var_73cce24380743112 = var_80341f0ab80f4d5f;
    level.jammingsystem.var_f00386c701be7d81[ var_676aeb43f5fd4e65.entnum ?? utility::get_entity_number( var_676aeb43f5fd4e65 ) ] = var_676aeb43f5fd4e65;
}

// Namespace jamming_system
// Params 1
// Checksum 0x6066f2f5, Offset: 0x617
// Size: 0x3d
function function_5c6a54d3c64b4881( var_676aeb43f5fd4e65 )
{
    if ( !var_676aeb43f5fd4e65 )
    {
        return;
    }
    
    level.jammingsystem.var_f00386c701be7d81[ var_676aeb43f5fd4e65.entnum ?? utility::get_entity_number( var_676aeb43f5fd4e65 ) ] = undefined;
}

// Namespace jamming_system
// Params 3
// Checksum 0x24202825, Offset: 0x65c
// Size: 0x103
function function_12a403954753b2f5( var_676aeb43f5fd4e65, var_49ec4152aad7790b, var_80341f0ab80f4d5f )
{
    assert( isdefined( var_676aeb43f5fd4e65 ) );
    var_676aeb43f5fd4e65.var_d2bfd30f061e7f56 = var_49ec4152aad7790b;
    var_676aeb43f5fd4e65.var_73cce24380743112 = var_80341f0ab80f4d5f;
    var_676aeb43f5fd4e65.jammers = [];
    level.jammingsystem.var_28f210801095b778[ var_676aeb43f5fd4e65.entnum ?? utility::get_entity_number( var_676aeb43f5fd4e65 ) ] = var_676aeb43f5fd4e65;
    
    foreach ( jammer in level.jammingsystem.jammers )
    {
        function_5606ae179e00b250( var_676aeb43f5fd4e65, jammer );
    }
}

// Namespace jamming_system
// Params 1
// Checksum 0xaa0b11cb, Offset: 0x767
// Size: 0x35
function function_f56a7ebc33ed463e( var_676aeb43f5fd4e65 )
{
    if ( !( isdefined( var_676aeb43f5fd4e65 ) && isdefined( var_676aeb43f5fd4e65.jammers ) ) )
    {
        return;
    }
    
    function_223996142ee015c6( var_676aeb43f5fd4e65 );
    function_f8951a1cdd0f73c9( var_676aeb43f5fd4e65 );
}

// Namespace jamming_system
// Params 1
// Checksum 0x92fe0754, Offset: 0x7a4
// Size: 0x61
function function_20676e4fc4b96d0f( var_2c9abdcc6410a2db )
{
    if ( level.jammingsystem.var_28f210801095b778[ var_2c9abdcc6410a2db.entnum ?? utility::get_entity_number( var_2c9abdcc6410a2db ) ] )
    {
        function_f56a7ebc33ed463e( var_2c9abdcc6410a2db );
        function_12a403954753b2f5( var_2c9abdcc6410a2db, var_2c9abdcc6410a2db.var_d2bfd30f061e7f56, var_2c9abdcc6410a2db.var_73cce24380743112 );
    }
}

// Namespace jamming_system
// Params 2
// Checksum 0x20996db8, Offset: 0x80d
// Size: 0x290
function registerjammer( jammer, radius )
{
    assert( isdefined( jammer ) );
    assert( radius > 0 );
    jammer.ownerteam = self.team;
    jammer.var_28f210801095b778 = [];
    jammer.var_58218b1f217bd879 = [];
    jammer.radius = radius;
    jammer.var_4a0faaf3abd94a45 = squared( radius );
    jammer.var_4f5aa43d995e534f = 0;
    assert( !isdefined( self.jammers[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    self.jammers[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = jammer;
    level.jammingsystem.jammers[ jammer.entnum ] = jammer;
    
    foreach ( player in level.players )
    {
        if ( player function_5a51435bfc2884a5() )
        {
            continue;
        }
        
        if ( !player function_8a60c0241675ffc5( jammer ) )
        {
            jammer.friendlycircle game_utility::questcircle_showtoplayer( player );
            continue;
        }
        
        if ( player.radarstrength > getuavstrengthmin() )
        {
            if ( !( isdefined( player.perks[ "specialty_perceptive" ] ) || isdefined( player.perks[ "specialty_scrambler_resist" ] ) ) )
            {
                jammer.enemycircle game_utility::questcircle_showtoplayer( player );
            }
        }
    }
    
    if ( level.jammingsystem.jammers.size == 1 )
    {
        level thread function_fbfd0911f9675d2c();
    }
    
    foreach ( var_2c9abdcc6410a2db in level.jammingsystem.var_28f210801095b778 )
    {
        function_5606ae179e00b250( var_2c9abdcc6410a2db, jammer );
    }
}

// Namespace jamming_system
// Params 2
// Checksum 0x3ae95d33, Offset: 0xaa5
// Size: 0x3c6
function deregisterjammer( jammer, var_da375297fa8273f1 )
{
    if ( !isdefined( jammer ) )
    {
        return;
    }
    
    if ( !isdefined( level.jammingsystem.jammers[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) )
    {
        return;
    }
    
    assert( isdefined( self.jammers[ jammer.entnum ] ) );
    self.jammers[ jammer.entnum ] = undefined;
    
    foreach ( var_2c9abdcc6410a2db in jammer.var_28f210801095b778 )
    {
        var_2c9abdcc6410a2db.jammers[ jammer.entnum ] = undefined;
        
        if ( var_2c9abdcc6410a2db.jammers.size == 0 )
        {
            function_223996142ee015c6( var_2c9abdcc6410a2db );
        }
    }
    
    foreach ( var_676aeb43f5fd4e65 in level.jammingsystem.var_f00386c701be7d81 )
    {
        var_e3f9ab58c57e5662 = 0;
        
        foreach ( activejammer in level.jammingsystem.jammers )
        {
            if ( activejammer == jammer )
            {
                continue;
            }
            
            if ( function_7172b121cf6038e4( var_676aeb43f5fd4e65, activejammer ) )
            {
                activejammer function_4eb5813ee9670226( var_676aeb43f5fd4e65 );
                var_e3f9ab58c57e5662 = 1;
                break;
            }
        }
        
        if ( !var_e3f9ab58c57e5662 )
        {
            function_223996142ee015c6( var_676aeb43f5fd4e65 );
        }
    }
    
    level.jammingsystem.jammers[ jammer.entnum ] = undefined;
    
    foreach ( player in level.players )
    {
        var_2d4809fc33eded27 = isdefined( jammer.var_58218b1f217bd879[ player.entnum ?? utility::get_entity_number( player ) ] );
        var_5e46a262251b727e = player function_8a60c0241675ffc5( jammer );
        
        if ( var_da375297fa8273f1 )
        {
            var_5e46a262251b727e = !var_5e46a262251b727e;
        }
        
        if ( var_5e46a262251b727e )
        {
            if ( var_2d4809fc33eded27 )
            {
                if ( jammer.var_3695df5e0f59b718 && player.var_9a1bd8d2c3cf48ef[ jammer.entnum ] )
                {
                    player.var_9a1bd8d2c3cf48ef[ jammer.entnum ] = undefined;
                }
                
                function_c8db48cd60cd1195( player, jammer );
            }
            
            jammer.enemycircle game_utility::questcircle_hidefromplayer( player );
            continue;
        }
        
        if ( var_2d4809fc33eded27 )
        {
            function_85f7a2568a5963a8( player, jammer );
        }
        
        jammer.friendlycircle game_utility::questcircle_hidefromplayer( player );
    }
    
    jammer.var_58218b1f217bd879 = [];
}

// Namespace jamming_system
// Params 3
// Checksum 0xd529dd3, Offset: 0xe73
// Size: 0x49
function function_bd0dbed54fbea4c2( jammer, previousowner, newowner )
{
    radius = function_aace9b4e4fe1ceeb( jammer );
    previousowner deregisterjammer( jammer, 1 );
    newowner registerjammer( jammer, radius );
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0xc227f013, Offset: 0xec4
// Size: 0x44
function private function_aace9b4e4fe1ceeb( jammer )
{
    baseradius = jammer.radius;
    var_f19c394e83c2c484 = jammer.var_7b9f89adb3cab2ec ?? 1;
    return baseradius * var_f19c394e83c2c484;
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0x176e4915, Offset: 0xf11
// Size: 0x70
function private function_fbfd0911f9675d2c()
{
    level.var_fe598dc159aaa421 = [];
    
    while ( true )
    {
        if ( level.jammingsystem.jammers.size == 0 )
        {
            break;
        }
        
        function_88d14ff655dc7f5a();
        wait 0.1;
        
        if ( level.jammingsystem.var_f00386c701be7d81.size > 0 )
        {
            function_4f158f3a32e9a281();
        }
        
        wait 0.15;
        function_b22d728ab851d8b8();
        wait 0.25;
    }
}

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0x6cc7142b, Offset: 0xf89
// Size: 0xb3
function private function_4238f9d80d9edbe4( player, jammer )
{
    assert( !isdefined( player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    assert( !isdefined( player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = jammer;
    player function_7c95de7d181d749f( 1 );
    player player::function_e4f77222086e66b( 1 );
    player notify( #"jammer_ping_hidden_started" );
}

/#

    // Namespace jamming_system
    // Params 2, eflags: 0x4
    // Checksum 0x42e57ad4, Offset: 0x1044
    // Size: 0x6f, Type: dev
    function private function_ea3d300cea319548( player, jammer )
    {
        assert( isdefined( player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
        assert( !isdefined( player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    }

#/

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0x794e2bfc, Offset: 0x10bb
// Size: 0xbe
function private function_85f7a2568a5963a8( player, jammer )
{
    assert( isdefined( player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    assert( !isdefined( player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = undefined;
    
    if ( player.var_bac127f4577a821e.size == 0 )
    {
        player function_7c95de7d181d749f( 0 );
        player player::function_e4f77222086e66b( 0 );
        player notify( #"hash_2a597464c8c58f2d" );
    }
}

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0xf22531a0, Offset: 0x1181
// Size: 0x1cd
function private function_5fe63d2981ed09b1( player, jammer )
{
    assert( !isdefined( player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    assert( !isdefined( player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = jammer;
    jammer.enemycircle game_utility::questcircle_showtoplayer( player );
    
    if ( jammer.issuper == 1 && isdefined( jammer.var_8cd831a3c0cc9bdc ) )
    {
        if ( !isdefined( level.var_38f84e6d5f274bb.statustracker[ player.guid ][ jammer.owner.guid ][ jammer.var_8cd831a3c0cc9bdc ] ) )
        {
            status_tracking::applystatus( player, jammer.owner, jammer.var_8cd831a3c0cc9bdc, #"scrambler_scrambled" );
        }
    }
    
    player challenges::tracksuper( jammer.owner, jammer.superref );
    
    if ( jammer.issuper == 1 )
    {
        player.var_a195d2dcf0aee163[ jammer.owner getentitynumber() ] = 1;
    }
    
    if ( player.var_3702583f19e5f23b.size == 1 )
    {
        player.radarstrength = getuavstrengthmin();
        player notify( #"radar_ping_jamming_started" );
        player function_d84882cc619a02d4( 1 );
        player function_255d9f6d68572aaf();
        function_cbe67171d214b390( player );
    }
}

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0xe5c441, Offset: 0x1356
// Size: 0xb8
function private function_cd06c146241ab7b5( player, jammer )
{
    assert( !isdefined( player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    assert( isdefined( player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    
    if ( jammer.var_3695df5e0f59b718 )
    {
        self [[ jammer.var_3695df5e0f59b718 ]]( player, jammer );
    }
    
    if ( player.radarstrength != getuavstrengthmin() )
    {
        player.radarstrength = getuavstrengthmin();
        function_cbe67171d214b390( player );
    }
}

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0x8486e933, Offset: 0x1416
// Size: 0x1ac
function private function_c8db48cd60cd1195( player, jammer )
{
    assert( !isdefined( player.var_bac127f4577a821e[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    assert( isdefined( player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) );
    player.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = undefined;
    
    if ( jammer.issuper == 1 && isdefined( jammer.var_8cd831a3c0cc9bdc ) )
    {
        status_tracking::function_758095091e5512be( player, jammer.owner, jammer.var_8cd831a3c0cc9bdc );
    }
    
    jammer.enemycircle game_utility::questcircle_hidefromplayer( player );
    player challenges::function_ead174660f144273( jammer.owner, jammer.superref );
    
    if ( jammer.issuper == 1 )
    {
        player.var_a195d2dcf0aee163[ jammer.owner getentitynumber() ] = undefined;
        player.var_adf995dac725ef56[ jammer.owner getentitynumber() ] = gettime();
    }
    
    if ( player.var_3702583f19e5f23b.size == 0 )
    {
        player.radarstrength = uav::function_c6b46bde3b7bc0a1( player.team );
        player notify( #"radar_ping_jamming_stopped" );
        player function_d84882cc619a02d4( 0 );
        player val::reset( "jammer", "supers" );
        function_cbe67171d214b390( player );
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0x5af3a03f, Offset: 0x15ca
// Size: 0x3d6
function private function_a875bf88a3105649( jammer )
{
    if ( !isdefined( jammer ) )
    {
        return;
    }
    
    radius = function_aace9b4e4fe1ceeb( jammer );
    entmask = createentitytypemask( [ "etype_player", "etype_vehicle" ] );
    var_cbba057a46a18235 = getentitiesinradiusfrompartitiongrid( jammer.origin, radius, entmask );
    var_f21b89c9c5f8bd54 = [];
    
    foreach ( ent in var_cbba057a46a18235 )
    {
        playerent = undefined;
        
        if ( isplayer( ent ) )
        {
            if ( ent utility::isusingremote() && isdefined( ent.vehicle ) )
            {
                continue;
            }
            
            playerent = ent;
        }
        else
        {
            assert( ent vehicle::is_vehicle() );
            
            if ( !isplayer( ent.owner ) )
            {
                continue;
            }
            
            if ( !ent.owner utility::isusingremote() )
            {
                continue;
            }
            
            playerent = ent.owner;
        }
        
        assert( isdefined( playerent ) );
        
        if ( !isdefined( playerent.var_952f9b24fe7ae1e4 ) )
        {
            continue;
        }
        
        if ( isdefined( playerent.perks[ "specialty_perceptive" ] ) || isdefined( playerent.perks[ "specialty_scrambler_resist" ] ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( playerent ) )
        {
            continue;
        }
        
        var_f21b89c9c5f8bd54[ playerent.entnum ?? utility::get_entity_number( playerent ) ] = playerent;
    }
    
    foreach ( player in var_f21b89c9c5f8bd54 )
    {
        if ( !isdefined( jammer.var_58218b1f217bd879[ player.entnum ?? utility::get_entity_number( player ) ] ) )
        {
            if ( player function_8a60c0241675ffc5( jammer ) )
            {
                function_5fe63d2981ed09b1( player, jammer );
            }
            else
            {
                function_4238f9d80d9edbe4( player, jammer );
            }
        }
        
        if ( player function_8a60c0241675ffc5( jammer ) )
        {
            function_cd06c146241ab7b5( player, jammer );
        }
        else
        {
            /#
                function_ea3d300cea319548( player, jammer );
            #/
        }
        
        assert( player.var_bac127f4577a821e.size + player.var_3702583f19e5f23b.size <= level.jammingsystem.jammers.size, "<dev string:x24>" );
    }
    
    foreach ( player in jammer.var_58218b1f217bd879 )
    {
        if ( isdefined( var_f21b89c9c5f8bd54[ player.entnum ?? utility::get_entity_number( player ) ] ) )
        {
            continue;
        }
        
        if ( player function_8a60c0241675ffc5( jammer ) )
        {
            function_c8db48cd60cd1195( player, jammer );
        }
        else
        {
            function_85f7a2568a5963a8( player, jammer );
        }
        
        assert( player.var_bac127f4577a821e.size + player.var_3702583f19e5f23b.size <= level.jammingsystem.jammers.size, "<dev string:x24>" );
    }
    
    jammer.var_58218b1f217bd879 = var_f21b89c9c5f8bd54;
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0x6c6d5639, Offset: 0x19a8
// Size: 0x11d
function private function_88d14ff655dc7f5a()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        function_a875bf88a3105649( jammer );
    }
    
    foreach ( player in level.var_fe598dc159aaa421 )
    {
        if ( isbot( player ) || !isplayer( player ) )
        {
            continue;
        }
        
        function_d4131195421b04d5( player );
    }
    
    level.var_fe598dc159aaa421 = [];
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0x506f7f86, Offset: 0x1acd
// Size: 0x12b
function private function_4f158f3a32e9a281()
{
    foreach ( var_676aeb43f5fd4e65 in level.jammingsystem.var_f00386c701be7d81 )
    {
        var_d304144e042a317f = 0;
        
        foreach ( jammer in level.jammingsystem.jammers )
        {
            if ( function_7172b121cf6038e4( var_676aeb43f5fd4e65, jammer ) )
            {
                jammer function_4eb5813ee9670226( var_676aeb43f5fd4e65 );
                var_d304144e042a317f = 1;
                break;
            }
        }
        
        if ( !var_d304144e042a317f )
        {
            function_223996142ee015c6( var_676aeb43f5fd4e65 );
        }
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0x90276e6b, Offset: 0x1c00
// Size: 0x22a
function private function_b22d728ab851d8b8()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        if ( !jammer.var_55e93950292bdfbd )
        {
            continue;
        }
        
        foreach ( var_2c9abdcc6410a2db in jammer.var_28f210801095b778 )
        {
            if ( distancesquared( var_2c9abdcc6410a2db.origin, jammer.origin ) <= jammer.var_4a0faaf3abd94a45 )
            {
                continue;
            }
            
            var_2c9abdcc6410a2db.jammers[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = undefined;
            
            if ( var_2c9abdcc6410a2db.jammers.size == 0 )
            {
                function_223996142ee015c6( var_2c9abdcc6410a2db );
            }
            
            jammer.var_28f210801095b778[ var_2c9abdcc6410a2db.entnum ?? utility::get_entity_number( var_2c9abdcc6410a2db ) ] = undefined;
        }
        
        foreach ( var_2c9abdcc6410a2db in level.jammingsystem.var_28f210801095b778 )
        {
            if ( jammer.var_28f210801095b778[ var_2c9abdcc6410a2db.entnum ?? utility::get_entity_number( var_2c9abdcc6410a2db ) ] )
            {
                continue;
            }
            
            function_5606ae179e00b250( var_2c9abdcc6410a2db, jammer );
        }
    }
}

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0xe7f20b5e, Offset: 0x1e32
// Size: 0x92, Type: bool
function private function_7172b121cf6038e4( var_676aeb43f5fd4e65, jammer )
{
    if ( !( isdefined( var_676aeb43f5fd4e65 ) && isdefined( jammer ) ) )
    {
        return false;
    }
    
    isfriendly = jammer.ownerteam == var_676aeb43f5fd4e65.team;
    
    /#
        if ( getdvarint( @"hash_6ef4b7902262f43b", 0 ) )
        {
            isfriendly = 0;
        }
    #/
    
    if ( isfriendly )
    {
        return false;
    }
    
    if ( distancesquared( var_676aeb43f5fd4e65.origin, jammer.origin ) <= jammer.var_4a0faaf3abd94a45 )
    {
        return true;
    }
    
    return false;
}

// Namespace jamming_system
// Params 2, eflags: 0x4
// Checksum 0x91a423fb, Offset: 0x1ecd
// Size: 0xe0
function private function_5606ae179e00b250( var_676aeb43f5fd4e65, jammer )
{
    if ( !( isdefined( var_676aeb43f5fd4e65 ) && isdefined( jammer ) ) )
    {
        return;
    }
    
    isfriendly = jammer.ownerteam == var_676aeb43f5fd4e65.team;
    
    /#
        if ( getdvarint( @"hash_6ef4b7902262f43b", 0 ) )
        {
            isfriendly = 0;
        }
    #/
    
    if ( isfriendly )
    {
        return;
    }
    
    if ( distancesquared( var_676aeb43f5fd4e65.origin, jammer.origin ) <= jammer.var_4a0faaf3abd94a45 )
    {
        jammer.var_28f210801095b778[ var_676aeb43f5fd4e65.entnum ?? utility::get_entity_number( var_676aeb43f5fd4e65 ) ] = var_676aeb43f5fd4e65;
        var_676aeb43f5fd4e65.jammers[ jammer.entnum ?? utility::get_entity_number( jammer ) ] = jammer;
        jammer function_4eb5813ee9670226( var_676aeb43f5fd4e65 );
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0x98adde39, Offset: 0x1fb5
// Size: 0x42
function private function_255d9f6d68572aaf( struct )
{
    if ( function_7bd4681d75dfcc00() )
    {
        var_e341893112b4cd2e = function_5a51435bfc2884a5();
        val::set( "jammer", "supers", !var_e341893112b4cd2e );
        thread function_4b4c9b994308a1f7();
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0x8534bb0b, Offset: 0x1fff
// Size: 0xa6
function private function_4b4c9b994308a1f7()
{
    self notify( #"hash_cd18465704e58c8c" );
    self endon( #"hash_cd18465704e58c8c" );
    self endon( #"radar_ping_jamming_stopped" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self superbuttonpressed() )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) && function_7bd4681d75dfcc00() && function_5a51435bfc2884a5() )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_79b4bc4e0949e878" );
            }
            
            wait 2;
        }
        
        waitframe();
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0x3a329109, Offset: 0x20ad
// Size: 0xc2
function private function_f8951a1cdd0f73c9( var_676aeb43f5fd4e65 )
{
    var_cf093f3f06105592 = var_676aeb43f5fd4e65.entnum ?? utility::get_entity_number( var_676aeb43f5fd4e65 );
    
    foreach ( jammer in var_676aeb43f5fd4e65.jammers )
    {
        jammer.var_28f210801095b778[ var_cf093f3f06105592 ] = undefined;
        level.jammingsystem.var_28f210801095b778[ var_cf093f3f06105592 ] = undefined;
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0xe65a4cf, Offset: 0x2177
// Size: 0xfb
function private function_4eb5813ee9670226( var_676aeb43f5fd4e65 )
{
    if ( var_676aeb43f5fd4e65.isjammed )
    {
        return;
    }
    
    var_676aeb43f5fd4e65.isjammed = 1;
    
    if ( isdefined( self.owner ) )
    {
        if ( level.jammingsystem.var_f6387355c38eb8cc == 0 || self.var_4f5aa43d995e534f < level.jammingsystem.var_f6387355c38eb8cc )
        {
            self.owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_c480f3fbdb209f3d", self.weapon_object );
            
            if ( !isdefined( self.var_28dc346d5a435f02 ) )
            {
                self.var_28dc346d5a435f02 = 0;
            }
            
            self.var_28dc346d5a435f02++;
            self.var_4f5aa43d995e534f++;
        }
    }
    
    if ( var_676aeb43f5fd4e65 getscriptablehaspart( "jammed" ) )
    {
        var_676aeb43f5fd4e65 setscriptablepartstate( "jammed", "on", 0 );
    }
    
    if ( isdefined( var_676aeb43f5fd4e65.var_d2bfd30f061e7f56 ) )
    {
        var_676aeb43f5fd4e65 thread [[ var_676aeb43f5fd4e65.var_d2bfd30f061e7f56 ]]( var_676aeb43f5fd4e65 );
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0x811116ce, Offset: 0x227a
// Size: 0x69
function private function_223996142ee015c6( var_676aeb43f5fd4e65 )
{
    if ( !var_676aeb43f5fd4e65.isjammed )
    {
        return;
    }
    
    var_676aeb43f5fd4e65.isjammed = 0;
    
    if ( var_676aeb43f5fd4e65 getscriptablehaspart( "jammed" ) )
    {
        var_676aeb43f5fd4e65 setscriptablepartstate( "jammed", "off", 0 );
    }
    
    if ( isdefined( var_676aeb43f5fd4e65.var_73cce24380743112 ) )
    {
        var_676aeb43f5fd4e65 thread [[ var_676aeb43f5fd4e65.var_73cce24380743112 ]]( var_676aeb43f5fd4e65 );
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0xc9a55438, Offset: 0x22eb
// Size: 0xb1
function private function_7b264901acedfdf3()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        if ( !function_8a60c0241675ffc5( jammer ) )
        {
            jammer.friendlycircle game_utility::questcircle_hidefromplayer( self );
            continue;
        }
        
        jammer.enemycircle game_utility::questcircle_hidefromplayer( self );
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0xcc1ef0a1, Offset: 0x23a4
// Size: 0x9a
function private function_73fb16848d9607d7()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        if ( function_8a60c0241675ffc5( jammer ) )
        {
            jammer.enemycircle game_utility::questcircle_hidefromplayer( self );
        }
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0xfd0fe8c, Offset: 0x2446
// Size: 0x9a
function private function_6f46bd56952345a8()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        if ( function_8a60c0241675ffc5( jammer ) )
        {
            jammer.enemycircle game_utility::questcircle_showtoplayer( self );
        }
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0xee89b034, Offset: 0x24e8
// Size: 0xd6
function private function_5867bf7e8dbf7665()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        if ( !function_8a60c0241675ffc5( jammer ) )
        {
            jammer.friendlycircle game_utility::questcircle_hidefromplayer( self );
            continue;
        }
        
        if ( !isdefined( self.var_3702583f19e5f23b[ jammer.entnum ?? utility::get_entity_number( jammer ) ] ) )
        {
            jammer.enemycircle game_utility::questcircle_hidefromplayer( self );
        }
    }
}

// Namespace jamming_system
// Params 0, eflags: 0x4
// Checksum 0xf2499ee9, Offset: 0x25c6
// Size: 0xb1
function private function_74071760ac52fe0e()
{
    foreach ( jammer in level.jammingsystem.jammers )
    {
        if ( !function_8a60c0241675ffc5( jammer ) )
        {
            jammer.friendlycircle game_utility::questcircle_showtoplayer( self );
            continue;
        }
        
        jammer.enemycircle game_utility::questcircle_showtoplayer( self );
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0x4825148d, Offset: 0x267f
// Size: 0x43
function private function_8a60c0241675ffc5( jammer )
{
    if ( isdefined( jammer.owner ) )
    {
        return player_utility::playersareenemies( jammer.owner, self );
    }
    
    return jammer.ownerteam != self.team;
}

// Namespace jamming_system
// Params 1
// Checksum 0x5809cf64, Offset: 0x26cb
// Size: 0x1a
function function_cbe67171d214b390( player )
{
    function_807f605103879c39( [ player ] );
}

// Namespace jamming_system
// Params 1
// Checksum 0x1872f486, Offset: 0x26ed
// Size: 0xc1
function function_807f605103879c39( var_9b4af734b3b2d934 )
{
    if ( !isdefined( level.var_fe598dc159aaa421 ) )
    {
        level.var_fe598dc159aaa421 = [];
    }
    
    if ( !isarray( var_9b4af734b3b2d934 ) )
    {
        var_9b4af734b3b2d934 = [ var_9b4af734b3b2d934 ];
    }
    
    foreach ( player in var_9b4af734b3b2d934 )
    {
        level.var_fe598dc159aaa421[ player.entnum ?? utility::get_entity_number( player ) ] = player;
    }
}

// Namespace jamming_system
// Params 1, eflags: 0x4
// Checksum 0x57deb5b1, Offset: 0x27b6
// Size: 0xc5
function private function_d4131195421b04d5( player )
{
    if ( isdefined( player.perks[ "specialty_perceptive" ] ) || isdefined( player.perks[ "specialty_scrambler_resist" ] ) )
    {
        return;
    }
    
    var_4500e8798a78461f = player.radarstrength > getuavstrengthmin();
    
    if ( isbrgamemode() )
    {
        var_4500e8798a78461f = var_4500e8798a78461f || uav_bigmap::function_7a3c1e8741828e6a( player );
    }
    
    if ( player.var_3f7436d512ddf73e && !var_4500e8798a78461f )
    {
        player.var_3f7436d512ddf73e = 0;
        player function_5867bf7e8dbf7665();
        return;
    }
    
    if ( !player.var_3f7436d512ddf73e && var_4500e8798a78461f )
    {
        player.var_3f7436d512ddf73e = 1;
        player function_74071760ac52fe0e();
    }
}

