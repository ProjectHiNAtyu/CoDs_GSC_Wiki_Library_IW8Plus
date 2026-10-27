// script_4a941421347ff7df  (hash_4a941421347ff7df.gscc) (size: 3708 Bytes / 0xe7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5659be4f (1448721999)
// size ...... 3708 (0xe7c)
// includes .. 13  (offset: 0xce8)
// strings ... 18  (offset: 0xd50)
// dev strs .. 4   (offset: 0xe4c)
// exports ... 14  (offset: 0x6e8)
// cseg ...... 0x11c + 0x5cc (0x6e8)
// imports ... 33  (offset: 0x918)
// animtree1 . 0   (offset: 0xe7c)
// animtree2 . 0   (offset: 0xe7c)
#using script_2ca303a73fb6436d;
#using script_37d9a569491ff1e0;
#using script_47366beb5ba9fa22;
#using script_4ae1a952802852f7;
#using script_5adad3b6e57811aa;
#using script_626264ce9b97c032;
#using script_67bad8bd9685e057;
#using script_7845ba34dcf9b77b;
#using script_7a9487f45303d680;
#using script_7bf46d34c10761a4;
#using script_d74ae0b4aa21186;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\common\utility\game_utility;

#namespace mind_config;

// Namespace mind_config
// Params 0
// Checksum 0xdbe79ff6, Offset: 0x13a
// Size: 0x9
function createevents()
{
    function_aad8f797fb852e02();
}

// Namespace mind_config
// Params 0
// Checksum 0x4fcd2474, Offset: 0x14b
// Size: 0x28
function function_aad8f797fb852e02()
{
    var_b9b23cce1c7f97fe = 7800;
    nearby_targets::createevent( var_b9b23cce1c7f97fe );
    namespace_c11142cfacfb2826::createevent();
    interactable_fobs::createevent();
}

// Namespace mind_config
// Params 0
// Checksum 0x26734d37, Offset: 0x17b
// Size: 0xf
function function_d4ff4acc71410acb()
{
    function_5db957a61d1facfa();
    return function_c5721a6eacea2886();
}

// Namespace mind_config
// Params 0
// Checksum 0xdf012e36, Offset: 0x193
// Size: 0xb1
function function_c5721a6eacea2886()
{
    descriptions = [];
    
    if ( getdvarint( @"hash_e4dae95c1ca21e20", 0 ) )
    {
        descriptions[ "AutoRunMap" ] = mind::function_5a8d4f1e3543b4ba( &namespace_cfbf3e363210f7ae::createdecision, undefined );
        return descriptions;
    }
    
    descriptions[ "Combat" ] = mind::function_5a8d4f1e3543b4ba( &namespace_95c62566abc47727::createdecision, &namespace_cf699c4c504e63f::combatconstants );
    descriptions[ "Wander" ] = mind::function_5a8d4f1e3543b4ba( &namespace_73faf998e0ac6104::createdecision, &namespace_cf699c4c504e63f::wanderconstants );
    descriptions[ "CaptureFlag" ] = mind::function_5a8d4f1e3543b4ba( &capture_flag::createdecision, &namespace_cf699c4c504e63f::function_7fdae62b3066f367 );
    descriptions[ "CaptureFlagGW" ] = mind::function_5a8d4f1e3543b4ba( &capture_flag_gw::createdecision, &namespace_cf699c4c504e63f::function_522644131a5491b1 );
    descriptions[ "CaptureHardpoint" ] = mind::function_5a8d4f1e3543b4ba( &capture_hardpoint::createdecision, &namespace_cf699c4c504e63f::function_876ade716e9c3a9a );
    return descriptions;
}

// Namespace mind_config
// Params 0
// Checksum 0x97c10d65, Offset: 0x24d
// Size: 0x19a
function function_5db957a61d1facfa()
{
    if ( isdefined( level.mind.personalities ) )
    {
        return;
    }
    
    personalities = [];
    sumproportion = 0;
    proportions = function_d677870d61ebcf51();
    
    foreach ( name, proportion in proportions )
    {
        assert( proportion >= 0, "<dev string:x24>" + name + "<dev string:x45>" );
        sumproportion += proportion;
        personality = spawnstruct();
        personality.proportion = proportion;
        personality.decisionnames = function_28316fe680626ef( name );
        personalities[ name ] = personality;
    }
    
    assert( sumproportion > 0 );
    
    foreach ( personality in personalities )
    {
        personality.proportion /= sumproportion;
    }
    
    level.mind.personalities = personalities;
}

// Namespace mind_config
// Params 0
// Checksum 0x47824707, Offset: 0x3ef
// Size: 0x54
function function_d677870d61ebcf51()
{
    proportions = [];
    proportions[ "default" ] = getdvarfloat( @"hash_dfd0051082e1f237", 1 );
    proportions[ "sniper" ] = getdvarfloat( @"hash_8a746ee0f068d111", 0 );
    proportions[ "babysitter" ] = getdvarfloat( @"hash_eaeeb4a12c7dcde5", 0 );
    return proportions;
}

// Namespace mind_config
// Params 1
// Checksum 0xf3e79970, Offset: 0x44c
// Size: 0x42
function function_28316fe680626ef( mind_personality )
{
    decisionset = mind::runcallback( "GetDecisionSet", mind_personality );
    var_7237854e3be197ca = decisionset;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return function_659075cc673426e2( mind_personality );
}

// Namespace mind_config
// Params 1, eflags: 0x4
// Checksum 0xd68d3661, Offset: 0x497
// Size: 0x5b
function private function_659075cc673426e2( mind_personality )
{
    switch ( mind_personality )
    {
        case #"hash_6191aaef9f922f96":
        case #"hash_7038dec66d8275be":
        case #"hash_79cb20639fcda706":
            return function_d7308b3b2b54a661();
        default:
            assertmsg( "<dev string:x5e>" );
            return;
    }
}

// Namespace mind_config
// Params 0
// Checksum 0x910977c8, Offset: 0x4fa
// Size: 0x31
function function_d7308b3b2b54a661()
{
    if ( getdvarint( @"hash_e4dae95c1ca21e20", 0 ) )
    {
        return [ "AutoRunMap" ];
    }
    
    return [ "Combat", "Wander" ];
}

// Namespace mind_config
// Params 0
// Checksum 0xeb361231, Offset: 0x534
// Size: 0x53
function function_ad32ada0fcba9ef0()
{
    assert( isdefined( self.mind_personality ) );
    personality = level.mind.personalities[ self.mind_personality ];
    assert( isdefined( personality ) );
    return personality.decisionnames;
}

// Namespace mind_config
// Params 0
// Checksum 0x8cf86774, Offset: 0x590
// Size: 0x7
function function_118a22c088e91252()
{
    return &namespace_ef4547f85724edd1::function_8e48d7e569f73fa2;
}

// Namespace mind_config
// Params 0
// Checksum 0x5d171920, Offset: 0x5a0
// Size: 0xdd
function function_9104eae940a20cf2()
{
    assert( isdefined( self.mind_personality ) );
    gametype = game_utility::getgametype();
    botmindpersonality = self.mind_personality ?? "undefined";
    botdifficulty = self botgetdifficulty() ?? "undefined";
    return [ gametype + "." + botmindpersonality + "." + botdifficulty, gametype + "." + botmindpersonality + ".*", gametype + ".*." + botdifficulty, gametype + ".*.*", "*." + botmindpersonality + "." + botdifficulty, "*." + botmindpersonality + ".*", "*.*." + botdifficulty, "" ];
}

// Namespace mind_config
// Params 2
// Checksum 0x44c0f5e5, Offset: 0x686
// Size: 0x62
function function_45262766d75ca7f5( var_ed6895dc7a69735, matchlist )
{
    for ( index = 0; index < matchlist.size ; index++ )
    {
        metatag = matchlist[ index ];
        var_7237854e3be197ca = var_ed6895dc7a69735[ metatag ];
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    assertmsg( "<dev string:x7c>" );
}

