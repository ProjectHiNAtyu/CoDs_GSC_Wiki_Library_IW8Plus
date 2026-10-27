// scripts\mp\challenges\ob_challenges.gsc  (hash_57da0aefc6aa9587.gscc) (size: 49479 Bytes / 0xc147 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44c095b2 (1153471922)
// size ...... 49479 (0xc147)
// includes .. 25  (offset: 0xb7b7)
// strings ... 129 (offset: 0xb87f)
// dev strs .. 34  (offset: 0xbfab)
// exports ... 103 (offset: 0x865b)
// cseg ...... 0xb24 + 0x7b37 (0x865b)
// imports ... 227 (offset: 0x9673)
// animtree1 . 0   (offset: 0xc147)
// animtree2 . 0   (offset: 0xc147)
#using script_16ea1b94f0f381b3;
#using script_7fb33ffa16b6839a;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ae_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\save;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\events;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\systems\ob_power_tier;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\stat_limits;
#using scripts\mp\supers;

#namespace ob_challenges;

// Namespace ob_challenges
// Params 0, eflags: 0x1
// Checksum 0x939cd6c6, Offset: 0xb42
// Size: 0x9
function autoexec main()
{
    initchallenges();
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xd6d8cabd, Offset: 0xb53
// Size: 0x678
function private initchallenges()
{
    utility::flag_wait( "ob_systems_init_complete" );
    
    if ( !challenges::challengesenabled() )
    {
        return;
    }
    
    level.var_290a71888a72cd4c = {};
    level.var_290a71888a72cd4c.var_25b8a2894c1decb1 = [];
    level.var_290a71888a72cd4c.var_f63d5b886e17c93b = [];
    level.var_b4f38e8dfdc18cd5 = [];
    level.var_ba0183a9e3cbc26 = {};
    level.var_8ab0aad2759f6a74 = {};
    level.var_4940b39313b4703d = {};
    level.var_4940b39313b4703d.playersstarted = [];
    level.var_d579cd2f47ecca08 = {};
    level.var_d579cd2f47ecca08.playerscompleted = [];
    level.var_495da479d5fbbec7 = 1;
    callback::add( #"on_ai_killed", &function_56654cd020a2788f );
    callback::add( #"hash_9357451f2536bb84", &function_3c24d9903c59f12f );
    callback::add( #"hash_86d4084ead08d3be", &function_d08d01a8ca4e641 );
    callback::add( #"hash_5f04bed91965f0ec", &function_5ee92ed449ad8c07 );
    callback::add( #"hash_3f722221fa539420", &function_8c8463a102e46523 );
    callback::add( #"hash_91f2a0e70afebfe1", &function_8c8463a102e46523 );
    callback::add( #"aries_boss_started", &function_c70c220f328392a3 );
    callback::add( #"cabin_barrage_end", &function_e9d8c66b77c7942d );
    callback::add( #"cabin_barrage_start", &function_cc162135b7196ff4 );
    callback::add( #"hash_c692dcb8a92d659c", &function_a1376f3cea3f495c );
    callback::add( #"hash_131977a65232ba05", &function_68070e2bfbf77745 );
    callback::add( #"menendez_defeated", &function_65cc5db333a4b867 );
    callback::add( #"frogger_complete", &function_8b74f1fb9af68baa );
    level.var_864e37cb92a447c = [];
    level.var_864e37cb92a447c[ #"leo_nm_complete" ] = 1;
    level.var_864e37cb92a447c[ #"aries_nm_complete" ] = 1;
    level.var_864e37cb92a447c[ #"virgo_nm_complete" ] = 1;
    level.var_864e37cb92a447c[ #"gemini_nm_complete" ] = 1;
    level.var_864e37cb92a447c[ #"libra_nm_complete" ] = 1;
    level.var_864e37cb92a447c[ #"nm_portal_leo" ] = 1;
    level.var_864e37cb92a447c[ #"nm_portal_aries" ] = 1;
    level.var_864e37cb92a447c[ #"nm_portal_virgo" ] = 1;
    level.var_864e37cb92a447c[ #"nm_portal_gemini" ] = 1;
    level.var_864e37cb92a447c[ #"nm_portal_libra" ] = 1;
    level.var_864e37cb92a447c[ #"hash_968ba3fff62b366c" ] = 1;
    level.var_864e37cb92a447c[ #"nm_portal_aries_solo" ] = 1;
    level.var_864e37cb92a447c[ #"hash_528bc14574e39758" ] = 1;
    level.var_864e37cb92a447c[ #"have_exotic_weapon" ] = 1;
    level.var_864e37cb92a447c[ #"hash_7a66622c4c71c97e" ] = 1;
    level.var_864e37cb92a447c[ #"hash_dfd54cbf054317d7" ] = 1;
    level.var_864e37cb92a447c[ #"virgo_nm_solo" ] = 1;
    level.var_864e37cb92a447c[ #"hash_67122492117aadca" ] = 1;
    level.var_864e37cb92a447c[ #"hash_d842de1c48117b14" ] = 1;
    level.var_864e37cb92a447c[ #"hash_669cc12736b86353" ] = 1;
    level.var_864e37cb92a447c[ #"hash_8996b48b3485073b" ] = 1;
    level.var_864e37cb92a447c[ #"hash_8d02a676820106cb" ] = 1;
    
    foreach ( bitname, val in level.var_864e37cb92a447c )
    {
        callback::add( bitname, &mission_event, bitname );
    }
    
    callback::add( #"hash_4551d65bc8e0606f", &function_b4a40202a281e7ec );
    callback::add( #"skill_acquired", &function_37c677a0688cb904 );
    callback::add( #"cache_opened", &function_ff0cca529842eb06 );
    callback::add( #"guild_drone_destroyed", &function_5880168743ba110f );
    callback::add( #"resupply_armor_plates", &function_f074ce0b6e104168 );
    callback::add( #"player_used_item", &function_34da42d1c47d3917 );
    callback::add( #"on_used_super", &function_6c2eba803f44e3f );
    callback::add( #"hash_ea64b6a9c741bb10", &function_693de59de0f8407c );
    utility::registersharedfunc( #"stealth", #"spotted_event_handler", &function_ad18f638a0bf3489 );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &function_9bbe799f77e34961 );
    obsettings = ob::get_ob_settings();
    
    if ( obsettings.var_1d6b46c22d179e96 )
    {
        callback::add( #"ob_exfil_success", &onexfilsuccess );
    }
    
    callback::add( #"player_laststand", &function_db27cbc08cb84def );
    callback::add( #"player_death", &onplayerkilled );
    utility::registersharedfunc( #"challenges", #"hash_9a0a0c803c627950", &function_3899b7b9609e5689 );
    utility::flag_wait( "shared_functions_initialized" );
    utility::registersharedfunc( #"challenges", #"onVehicleKilled", &onvehiclekilled );
    utility::registersharedfunc( #"challenges", #"hash_fdebb4c8cc9f1d5e", &function_cf263d7c7bd3344b );
    utility::registersharedfunc( #"challenges", #"hash_2310b572de8d15ac", &function_75343d515a7338bf );
    utility::registersharedfunc( #"challenges", #"hash_331a82c13105b9dd", &function_fa07992db2ca3058 );
    utility::registersharedfunc( #"challenges", #"hash_c1ac67fc66891430", &function_a0936b0e5b4550f3 );
    utility::registersharedfunc( #"challenges", #"hash_8ec698d92f03a49a", &function_3d7a169dbae062fb );
    level.equipment.translation[ "sat_molotov_mp" ] = level.equipment.table[ "equip_molotov" ];
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x71728c04, Offset: 0x11d3
// Size: 0xbf
function private function_9bbe799f77e34961( params )
{
    activityinstance = self;
    
    if ( !activityinstance )
    {
        return;
    }
    
    activitycategory = activityinstance.category;
    
    if ( !isdefined( activitycategory ) )
    {
        return;
    }
    
    players = params.playerlist;
    
    if ( !players || players.size == 0 )
    {
        return;
    }
    
    switch ( activitycategory )
    {
        case #"hash_6306b8f9898bfbea":
        case #"hash_b1dc3483beee3c2c":
        case #"hash_c24b16fb9788caee":
            function_75a7b7237dc12b8a( players, activityinstance );
            return;
        case #"hash_d4354213f9160643":
            function_e80236f0009ade79( players, activityinstance );
            return;
        default:
            return;
    }
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xa5dd4e6b, Offset: 0x129a
// Size: 0x5f
function private function_cc162135b7196ff4( sparams )
{
    var_8e17e0296da4627b = sparams.players;
    
    if ( !var_8e17e0296da4627b || var_8e17e0296da4627b.size == 0 )
    {
        return;
    }
    
    level.var_8ab0aad2759f6a74.barragestarted = 1;
    level.var_8ab0aad2759f6a74.var_8e17e0296da4627b = var_8e17e0296da4627b;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x3bc64c4b, Offset: 0x1301
// Size: 0x171
function private function_e9d8c66b77c7942d( sparams )
{
    if ( !level.var_8ab0aad2759f6a74.barragestarted )
    {
        return;
    }
    
    var_2118c603a3e16dde = sparams.players;
    
    if ( !var_2118c603a3e16dde || var_2118c603a3e16dde.size == 0 )
    {
        return;
    }
    
    var_f3f256426975a85f = [];
    
    foreach ( player in var_2118c603a3e16dde )
    {
        if ( arraycontains( level.var_8ab0aad2759f6a74.var_8e17e0296da4627b, player ) && player::isreallyalive( player ) && !player::isinlaststand( player ) )
        {
            var_f3f256426975a85f[ var_f3f256426975a85f.size ] = player;
        }
    }
    
    if ( var_f3f256426975a85f.size == 0 )
    {
        level.var_8ab0aad2759f6a74 = undefined;
        return;
    }
    
    var_b9b106fa7c8aa47f = function_6c16fe5c6c502aeb();
    
    if ( !isdefined( var_b9b106fa7c8aa47f[ #"cabin_barrage_end" ] ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_71c9301ae528c0b2 = 0;
    var_71c9301ae528c0b2 = challenges::function_a23641f33e985edb( var_71c9301ae528c0b2, var_b9b106fa7c8aa47f[ #"cabin_barrage_end" ] );
    function_a91eb048b73c6b9a( var_f3f256426975a85f, var_71c9301ae528c0b2 );
    level.var_8ab0aad2759f6a74 = undefined;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xe80498a3, Offset: 0x147a
// Size: 0x1a0
function private function_8b1bd480fa218150( sparams )
{
    var_ffb3bff3046335ad = sparams.players;
    
    if ( !var_ffb3bff3046335ad || var_ffb3bff3046335ad.size == 0 )
    {
        return;
    }
    
    if ( level.var_ba0183a9e3cbc26.var_9b897bd74d9c248b.size > 0 )
    {
        return;
    }
    
    var_f3f256426975a85f = [];
    
    foreach ( player in var_ffb3bff3046335ad )
    {
        if ( arraycontains( level.var_ba0183a9e3cbc26.var_8e17e0296da4627b, player ) )
        {
            var_f3f256426975a85f[ var_f3f256426975a85f.size ] = player;
        }
    }
    
    var_b9b106fa7c8aa47f = function_6c16fe5c6c502aeb();
    
    if ( !isdefined( var_b9b106fa7c8aa47f[ #"aries_boss_defeated" ] ) )
    {
        assertmsg( "<dev string:x61>" );
        return;
    }
    
    var_71c9301ae528c0b2 = 0;
    var_71c9301ae528c0b2 = challenges::function_a23641f33e985edb( var_71c9301ae528c0b2, var_b9b106fa7c8aa47f[ #"aries_boss_defeated" ] );
    function_a91eb048b73c6b9a( var_f3f256426975a85f, var_71c9301ae528c0b2 );
    callback::remove( #"aries_boss_defeated", &function_8b1bd480fa218150 );
    callback::remove( #"player_damaged", &function_d6ffed92286e04dd );
    level.var_ba0183a9e3cbc26.battlestarted = undefined;
    level.var_ba0183a9e3cbc26.var_8e17e0296da4627b = undefined;
    level.var_ba0183a9e3cbc26.var_9b897bd74d9c248b = undefined;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x8c7961d9, Offset: 0x1622
// Size: 0x9e
function private function_c70c220f328392a3( sparams )
{
    players = sparams.players;
    
    if ( !players || players.size == 0 )
    {
        return;
    }
    
    level.var_ba0183a9e3cbc26.battlestarted = 1;
    level.var_ba0183a9e3cbc26.var_8e17e0296da4627b = players;
    level.var_ba0183a9e3cbc26.var_9b897bd74d9c248b = [];
    callback::add( #"aries_boss_defeated", &function_8b1bd480fa218150 );
    callback::add( #"player_damaged", &function_d6ffed92286e04dd );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x21c68355, Offset: 0x16c8
// Size: 0x105
function private onexfilsuccess( sparams )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    exfil = sparams.exfil;
    
    if ( !exfil )
    {
        assertmsg( "<dev string:xa1>" );
        return;
    }
    
    if ( exfil.noreport )
    {
        return;
    }
    
    if ( player utility::ent_flag( "exfil_no_weapon_fire" ) && exfil.door.activatedplayers[ player.guid ] )
    {
        player.var_db592ad7a2598820 = 1;
    }
    
    exfilorigin = exfil.origin;
    
    if ( !exfilorigin )
    {
        assertmsg( "<dev string:xc1>" );
        return;
    }
    
    exfiltype = sparams.exfiltype;
    
    if ( !exfiltype )
    {
        assertmsg( "<dev string:xef>" );
        return;
    }
    
    function_308028d5ee871d1f( player, exfilorigin, exfiltype );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x4b818253, Offset: 0x17d5
// Size: 0x3d
function private function_db27cbc08cb84def( params )
{
    player = isplayer( self ) ? self : params.victim;
    player.has_been_downed = 1;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x4b818253, Offset: 0x181a
// Size: 0x3d
function private onplayerkilled( params )
{
    player = isplayer( self ) ? self : params.victim;
    player.has_been_killed = 1;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xff5e70f9, Offset: 0x185f
// Size: 0x6e
function private function_ad18f638a0bf3489( spotted )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !level.var_4940b39313b4703d.playersstarted[ player.guid ] )
    {
        return;
    }
    
    if ( !spotted )
    {
        return;
    }
    
    level.var_4940b39313b4703d.playersstarted[ player.guid ] = undefined;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xe5663fd0, Offset: 0x18d5
// Size: 0xd2
function private function_a1376f3cea3f495c( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !level.var_4940b39313b4703d.playersstarted[ player.guid ] )
    {
        return;
    }
    
    var_b9b106fa7c8aa47f = function_6c16fe5c6c502aeb();
    
    if ( !isdefined( var_b9b106fa7c8aa47f[ #"hash_c692dcb8a92d659c" ] ) )
    {
        assertmsg( "<dev string:x114>" );
        return;
    }
    
    var_71c9301ae528c0b2 = 0;
    var_71c9301ae528c0b2 = challenges::function_a23641f33e985edb( var_71c9301ae528c0b2, var_b9b106fa7c8aa47f[ #"hash_c692dcb8a92d659c" ] );
    function_a91eb048b73c6b9a( [ player ], var_71c9301ae528c0b2 );
    level.var_4940b39313b4703d.playersstarted[ player.guid ] = undefined;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xf6818b9, Offset: 0x19af
// Size: 0x50
function private function_68070e2bfbf77745( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    level.var_4940b39313b4703d.playersstarted[ player.guid ] = 1;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xd369356b, Offset: 0x1a07
// Size: 0xcd
function private function_8b74f1fb9af68baa( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( level.var_d579cd2f47ecca08.playerscompleted[ player.guid ] ) )
    {
        return;
    }
    
    if ( player.var_600507ec1d8676a8 )
    {
        level.var_d579cd2f47ecca08.playerscompleted[ player.guid ] = 0;
        return;
    }
    
    var_71c9301ae528c0b2 = function_6a3e9c959b67d9be( #"frogger_complete" );
    function_a91eb048b73c6b9a( [ player ], var_71c9301ae528c0b2 );
    level.var_d579cd2f47ecca08.playerscompleted[ player.guid ] = 1;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x8b6b613f, Offset: 0x1adc
// Size: 0x1bf
function private function_65cc5db333a4b867( sparams )
{
    players = sparams.players;
    
    if ( !players || players.size == 0 )
    {
        return;
    }
    
    menendez = sparams.menendez;
    
    if ( !menendez )
    {
        return;
    }
    
    foreach ( player in players )
    {
        attackerdata = menendez.attackerdata[ player.guid ];
        
        if ( !isdefined( attackerdata.damagesources ) )
        {
            continue;
        }
        
        foreach ( weaponname, weaponstruct in attackerdata.damagesources )
        {
            if ( weaponname != level.machetesettings.streakname )
            {
                return;
            }
        }
    }
    
    var_b9b106fa7c8aa47f = function_6c16fe5c6c502aeb();
    
    if ( !isdefined( var_b9b106fa7c8aa47f[ #"menendez_defeated" ] ) )
    {
        return;
    }
    
    var_71c9301ae528c0b2 = 0;
    var_71c9301ae528c0b2 = challenges::function_a23641f33e985edb( var_71c9301ae528c0b2, var_b9b106fa7c8aa47f[ #"menendez_defeated" ] );
    function_a91eb048b73c6b9a( players, var_71c9301ae528c0b2 );
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0xc550eebc, Offset: 0x1ca3
// Size: 0x79
function private mission_event( sparams, missionbit )
{
    players = sparams.players;
    
    if ( !players || players.size == 0 )
    {
        return;
    }
    
    var_b9b106fa7c8aa47f = function_6c16fe5c6c502aeb();
    
    if ( !isdefined( var_b9b106fa7c8aa47f[ missionbit ] ) )
    {
        return;
    }
    
    var_71c9301ae528c0b2 = 0;
    var_71c9301ae528c0b2 = challenges::function_a23641f33e985edb( var_71c9301ae528c0b2, var_b9b106fa7c8aa47f[ missionbit ] );
    function_a91eb048b73c6b9a( players, var_71c9301ae528c0b2 );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x4e86dcb1, Offset: 0x1d24
// Size: 0x66
function private function_d6ffed92286e04dd( sparams )
{
    if ( !level.var_ba0183a9e3cbc26.battlestarted )
    {
        return;
    }
    
    if ( isdefined( level.var_ba0183a9e3cbc26.var_9b897bd74d9c248b[ self.guid ] ) )
    {
        return;
    }
    
    level.var_ba0183a9e3cbc26.var_9b897bd74d9c248b[ self.guid ] = 1;
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0x36213b81, Offset: 0x1d92
// Size: 0x35
function private function_cf263d7c7bd3344b( reviver, revivee, revivebitfield )
{
    revivebitfield = function_42a9e29ec3417d76( revivee, reviver, revivebitfield );
    challenges::function_cf263d7c7bd3344b( reviver, revivee, revivebitfield );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x45e49a6c, Offset: 0x1dcf
// Size: 0x91
function private function_b4a40202a281e7ec( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    traversaltype = sparams.traversaltype;
    
    if ( !traversaltype )
    {
        assertmsg( "<dev string:x152>" );
        return;
    }
    
    var_e42bba4b7b58eff = sparams.var_e42bba4b7b58eff;
    
    if ( !var_e42bba4b7b58eff )
    {
        assertmsg( "<dev string:x184>" );
        return;
    }
    
    function_6e0747409fa220e1( player, traversaltype, var_e42bba4b7b58eff );
}

// Namespace ob_challenges
// Params 1
// Checksum 0xef7916c4, Offset: 0x1e68
// Size: 0x1b3
function function_414273e1142aa748( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    skillref = sparams.skillref;
    
    if ( !skillref )
    {
        assertmsg( "<dev string:x1c7>" );
        return;
    }
    
    skilllevel = sparams.skilllevel;
    
    if ( !isdefined( skilllevel ) )
    {
        assertmsg( "<dev string:x1fc>" );
        return;
    }
    
    lootid = utility::callsharedfunc( #"skills", #"hash_1f0a435d01dc412b", skillref, skilllevel );
    
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:x233>" + getxhashsourcename( skillref ) );
        return;
    }
    
    skillcategory = utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel );
    
    if ( !isdefined( skillcategory ) )
    {
        assertmsg( "<dev string:x26a>" + getxhashsourcename( skillref ) );
        return;
    }
    
    rarity = utility::callsharedfunc( #"skills", #"hash_785df5a84d4d0b95", skillref, skilllevel );
    
    if ( !isdefined( rarity ) )
    {
        assertmsg( "<dev string:x2a8>" + getxhashsourcename( skillref ) );
        return;
    }
    
    var_fdae05f4940047b2 = function_39baaed6e56019ee( skillcategory );
    return { #var_fdae05f4940047b2:var_fdae05f4940047b2, #rarity:rarity, #skillcategory:skillcategory, #lootid:lootid, #skilllevel:skilllevel, #skillref:skillref, #player:player };
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x9efd1dfb, Offset: 0x2024
// Size: 0x104
function private function_37c677a0688cb904( sparams )
{
    info = function_414273e1142aa748( sparams );
    aeeventname = #"ob_acquire_skill";
    eventdata = function_8a1cde632fe3e0d9();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = info.lootid;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_skills_category_bitfield" ) ] = info.var_fdae05f4940047b2;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_rarity" ) ] = info.rarity;
    
    /#
        challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
    #/
    
    info.player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x2f3e1fc0, Offset: 0x2130
// Size: 0x135
function private function_ff0cca529842eb06( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    var_70c6fda1cd082fd4 = player save::player_get_data( "opened_caches", [] );
    cachekey = getxhash( "" + int( sparams.cache.origin[ 0 ] ) + "_" + int( sparams.cache.origin[ 1 ] ) + "_" + int( sparams.cache.origin[ 2 ] ) );
    
    if ( var_70c6fda1cd082fd4[ cachekey ] )
    {
        return;
    }
    
    var_70c6fda1cd082fd4[ cachekey ] = 1;
    player save::player_set_data( "opened_caches", var_70c6fda1cd082fd4 );
    var_f80a400bf692eb93 = function_be2516732994b5d6();
    
    if ( !isdefined( var_f80a400bf692eb93[ #"loot_cache_looted" ] ) )
    {
        assertmsg( "<dev string:x2df>" );
        return;
    }
    
    var_e251ab0e6629fbf3 = 0;
    var_e251ab0e6629fbf3 = challenges::function_a23641f33e985edb( var_e251ab0e6629fbf3, var_f80a400bf692eb93[ #"loot_cache_looted" ] );
    function_75343d515a7338bf( player, var_e251ab0e6629fbf3 );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x9b3cc19f, Offset: 0x226d
// Size: 0xb3
function private function_34da42d1c47d3917( sparams )
{
    if ( !sparams.item || !sparams.itembundle || !isplayer( self ) )
    {
        return;
    }
    
    if ( "killstreak" == common_item::function_16e8c106491eeaca( sparams.itembundle ) )
    {
        challenges::function_37e945722d6497f3( self, "killstreak", 1, 0, common_item::function_779887309ec71dfe( sparams.itembundle ) );
        
        if ( sparams.item.loot_source == "supply_drop" )
        {
            self.pers[ "killstreak_from_supply_drop" ] = 1;
            return;
        }
        
        self.pers[ "killstreak_from_supply_drop" ] = undefined;
    }
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xb56eb385, Offset: 0x2328
// Size: 0x9d
function private function_6c2eba803f44e3f( sparams )
{
    if ( isplayer( sparams.player ) && isdefined( sparams.superinfo ) )
    {
        if ( sparams.superinfo.staticdata.ref == "super_survival_life_drain" || sparams.superinfo.staticdata.ref == "super_bubble_shield" )
        {
            sparams.player.pers[ "nm_crash_shield_used" ] = 1;
        }
    }
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x19454a63, Offset: 0x23cd
// Size: 0x33
function private function_693de59de0f8407c( sparams )
{
    if ( self.var_3d5f9175ae9c72f4 )
    {
        sparams.newitem.loot_source = "supply_drop";
    }
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xf50b4abb, Offset: 0x2408
// Size: 0x146
function private function_8c8463a102e46523( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    interactionevent = sparams.interactionevent;
    var_cd58ed580761b4c7 = function_cb05e13fe0a75895( interactionevent );
    jailbreakmachine = sparams.jailbreakmachine;
    
    if ( jailbreakmachine.rarity == 5 )
    {
        if ( player function_9ffef1d182fe3752( interactionevent, jailbreakmachine ) )
        {
            return;
        }
        
        var_f80a400bf692eb93 = function_be2516732994b5d6();
        interactiontype = jailbreakmachine.current_interaction_type[ player getguid() ];
        
        if ( interactiontype == 3 && var_f80a400bf692eb93[ #"hash_830bd5a1815cbbe6" ] )
        {
            var_cd58ed580761b4c7 = challenges::function_a23641f33e985edb( var_cd58ed580761b4c7, var_f80a400bf692eb93[ #"hash_830bd5a1815cbbe6" ] );
        }
        else if ( interactiontype != 3 && var_f80a400bf692eb93[ #"hash_77963ced32f542e7" ] )
        {
            var_cd58ed580761b4c7 = challenges::function_a23641f33e985edb( var_cd58ed580761b4c7, var_f80a400bf692eb93[ #"hash_77963ced32f542e7" ] );
        }
    }
    else if ( sparams.exoticcase && player function_9ffef1d182fe3752( interactionevent, sparams.exoticcase ) )
    {
        return;
    }
    
    function_75343d515a7338bf( player, undefined, var_cd58ed580761b4c7 );
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0xf0848440, Offset: 0x2556
// Size: 0x8a
function private function_9ffef1d182fe3752( interactiontype, container )
{
    if ( !interactiontype )
    {
        assertmsg( "<dev string:x331>" );
        return;
    }
    
    if ( !container )
    {
        assertmsg( "<dev string:x364>" );
        return;
    }
    
    if ( !isdefined( container.openedplayers ) )
    {
        container.openedplayers = [];
    }
    
    if ( container.openedplayers[ self getguid() ] )
    {
        return 1;
    }
    
    container.openedplayers[ self getguid() ] = 1;
    return 0;
}

// Namespace ob_challenges
// Params 4, eflags: 0x4
// Checksum 0xf39e768b, Offset: 0x25e9
// Size: 0x167
function private onvehiclekilled( victim, attacker, damage, objweapon )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    var_7dd648d39a8c6b7f = attacker function_c59b6b0d16e7777a();
    
    if ( !var_7dd648d39a8c6b7f )
    {
        foreach ( assistplayer in victim.a_n_player_damage )
        {
            if ( assistplayer function_c59b6b0d16e7777a() )
            {
                var_7dd648d39a8c6b7f = 1;
                break;
            }
        }
    }
    
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( victim.origin, var_7dd648d39a8c6b7f );
    var_d83451c1bf446403 = 0;
    
    if ( !victim.var_e038900b11ddf286 )
    {
        var_d83451c1bf446403 = challenges::function_a23641f33e985edb( var_d83451c1bf446403, ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"before_deploy" ) );
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"ob_map_location" ] = var_e2454ccf8320aa42;
    additionaleventparams[ #"ob_enemy_type_bitfield" ] = var_d83451c1bf446403;
    challenges::vehiclekilled( victim, attacker, damage, objweapon, additionaleventparams );
    function_20cd6ba99993b39e( attacker, victim, additionaleventparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xecc108a7, Offset: 0x2758
// Size: 0x54
function private function_5ee92ed449ad8c07( sparams )
{
    if ( !sparams )
    {
        sparams = {};
        sparams.inflictor = self;
        sparams.objweapon = vehicle_damage::get_weapon_string( vehicle::get_ref() );
        sparams.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    vehicle_damage::on_death_score( sparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xc8635b04, Offset: 0x27b4
// Size: 0x15
function private function_5880168743ba110f( sparams )
{
    function_d08d01a8ca4e641( sparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x815c72e4, Offset: 0x27d1
// Size: 0x139
function private function_f074ce0b6e104168( sparams )
{
    superowner = sparams.superowner;
    
    if ( !isplayer( superowner ) )
    {
        return;
    }
    
    buffedplayer = sparams.buffedplayer;
    
    if ( !isplayer( buffedplayer ) )
    {
        return;
    }
    
    platecount = sparams.platecount;
    
    if ( platecount <= 0 )
    {
        return;
    }
    
    resupplysource = sparams.source;
    
    if ( !resupplysource )
    {
        return;
    }
    
    aeeventname = #"ob_armor";
    eventdata = function_4a03c07da0e71283();
    supersbitfield = function_940f19149d469aa3( resupplysource );
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = platecount;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"supers_bitfield" ) ] = supersbitfield;
    
    /#
        challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
    #/
    
    superowner function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xcd1618a6, Offset: 0x2912
// Size: 0xb8
function private function_3c24d9903c59f12f( sparams )
{
    attacker = sparams.attacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = self;
    
    if ( !isent( victim ) )
    {
        victim.isagent = 0;
    }
    
    damage = sparams.damage ?? 1;
    objweapon = sparams.objweapon ?? attacker getcurrentweapon();
    damagetype = sparams.meansofdeath ?? "MOD_UNKNOWN";
    challenges::equipmentdestroyed( victim, attacker, attacker, damage, undefined, damagetype, objweapon, undefined, undefined );
}

// Namespace ob_challenges
// Params 5
// Checksum 0x2025e036, Offset: 0x29d2
// Size: 0x100
function function_a0936b0e5b4550f3( ref, eventtypebit, value, var_9755e6d557d8a5d3 = 0, targetent )
{
    aeeventname = #"field_upgrade";
    additionalparams = [];
    
    if ( targetent )
    {
        [ enemytype, var_e0303092a359edc4 ] = challenges::findenemytype( targetent );
        additionalparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"enemy_type_bitfield" ) ] = enemytype;
        additionalparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_zombie_type_bitfield" ) ] = function_f603dd218dbf4618( targetent );
    }
    
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( self.origin, function_c59b6b0d16e7777a() );
    additionalparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_map_location" ) ] = var_e2454ccf8320aa42;
    challenges::function_a0936b0e5b4550f3( ref, eventtypebit, value, var_9755e6d557d8a5d3, additionalparams );
}

// Namespace ob_challenges
// Params 8
// Checksum 0x58f6fb9a, Offset: 0x2ada
// Size: 0xb4
function function_3d7a169dbae062fb( equipment, player, dist, eventtypebit, value = 1, var_62173a0431eae70d = 0, equipmentbitfield, victim )
{
    additionalparams = [];
    
    if ( isagent( victim ) )
    {
        aeeventname = #"equipment";
        additionalparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_zombie_type_bitfield" ) ] = function_f603dd218dbf4618( victim );
    }
    
    challenges::function_3d7a169dbae062fb( equipment, player, dist, eventtypebit, value, var_62173a0431eae70d, equipmentbitfield, victim, additionalparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xfa5a0e73, Offset: 0x2b96
// Size: 0x17b
function private function_d08d01a8ca4e641( sparams )
{
    attacker = sparams.attacker ?? sparams.eattacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    victim = self;
    
    if ( !isdefined( victim.owner ) )
    {
        victim.owner = level;
    }
    
    damage = sparams.damage ?? sparams.idamage;
    objweapon = sparams.objweapon ?? sparams.sweapon;
    damagetype = sparams.meansofdeath ?? sparams.smeansofdeath;
    var_7b2c34037035e4c0 = function_2847cd71ed069ca8( victim );
    additionaleventparams = [];
    additionaleventparams[ #"ob_enemy_type_bitfield" ] = var_7b2c34037035e4c0;
    
    if ( isplayer( attacker ) )
    {
        vehicle = attacker player_utility::getvehicle( 1 );
        
        if ( isdefined( vehicle ) )
        {
            attacker.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( attacker.modifiers[ "mask" ] ?? 0, ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"invehicle" ) );
        }
    }
    
    challenges::killstreakkilled( victim, undefined, undefined, attacker, damage, damagetype, objweapon, additionaleventparams );
    function_20cd6ba99993b39e( attacker, victim, additionaleventparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x4ece8fc3, Offset: 0x2d19
// Size: 0x79f
function private function_56654cd020a2788f( sparams )
{
    attacker = sparams.eattacker;
    
    if ( !isplayer( attacker ) && !isplayer( attacker.var_bd22ba6c600a23a3 ) && !isplayer( attacker.var_fb2e0070ae6f04e4 ) && !isplayer( attacker.owner ) )
    {
        return;
    }
    
    if ( attacker stat_limits::function_608486f90656f2f7( #"limitkills" ) )
    {
        return;
    }
    
    if ( function_32f1a309d6904b9c() )
    {
        function_d08d01a8ca4e641( sparams );
        return;
    }
    else if ( function_b47e3dd8f88a88c2() )
    {
        function_3c24d9903c59f12f( sparams );
        return;
    }
    
    inflictor = sparams.einflictor;
    objweapon = sparams.sweapon;
    meansofdeath = sparams.smeansofdeath;
    idflags = sparams.idflags;
    weapongroup = weapon::getweapongroup( objweapon );
    deathdata = {};
    deathdata.hitloc = sparams.shitloc;
    
    if ( getdvarint( @"hash_aad8f59a4eae57f3", 0 ) )
    {
        attacker events::function_a2d92a4b5cb17d36( self, objweapon, weapongroup, meansofdeath, inflictor, deathdata );
        victimstruct = self;
    }
    else
    {
        victimstruct = zombie_shared_challenges::function_e7dd3022963df094( attacker, inflictor, objweapon, meansofdeath );
        victimstruct = function_e7dd3022963df094( idflags, attacker, victimstruct );
        zombie_shared_challenges::function_6856007c45873b25();
        
        if ( isplayer( attacker ) )
        {
            attacker zombie_shared_challenges::function_814eb8fe3432a1ca( victimstruct, objweapon, meansofdeath, inflictor );
            attacker zombie_shared_challenges::function_920a35d38f329ffb( victimstruct );
            var_6eb61dc59ad8d126 = attacker zombie_shared_challenges::function_216bb7c532af802f( victimstruct, meansofdeath, objweapon );
            attacker events::function_920a35d38f329ffb( victimstruct );
            attacker events::function_8f26df18dbcd57c2( objweapon, meansofdeath, deathdata );
            attacker function_b4096ceeab158a58( victimstruct, meansofdeath );
            attacker function_415db442969048e3( victimstruct, inflictor, objweapon, meansofdeath );
            attacker function_e430004e0798aff2( victimstruct, inflictor, objweapon, meansofdeath, deathdata, weapongroup );
            attacker function_cb49457a6793ff21( victimstruct, inflictor, objweapon, meansofdeath );
            attacker function_65bd7657a9865d80( victimstruct, inflictor, meansofdeath, objweapon );
        }
        
        if ( !isdefined( level.obChallengesOnAiKilled_throttle ) )
        {
            level.obChallengesOnAiKilled_throttle = throttle::throttle_initialize( "obChallengesOnAiKilled_throttle", 1 );
        }
        
        level throttle::throttle_wait_in_queue( level.obChallengesOnAiKilled_throttle, victimstruct );
    }
    
    objweapon = attacker zombie_shared_challenges::function_e755757ca2b10ec9( objweapon, victimstruct );
    var_de8c8c811657e5f8 = 0;
    
    if ( isplayer( attacker ) )
    {
        attacker function_346e047cd09aa21b();
        var_de8c8c811657e5f8 = isagent( inflictor ) || inflictor.var_7ee4a7c2b172b5a7;
    }
    else if ( isplayer( attacker.var_bd22ba6c600a23a3 ) )
    {
        var_6eb61dc59ad8d126 = attacker zombie_shared_challenges::function_ebe3b18f036aacae();
        attacker = attacker.var_bd22ba6c600a23a3;
        var_de8c8c811657e5f8 = 1;
    }
    else if ( isplayer( attacker.var_fb2e0070ae6f04e4 ) )
    {
        attacker = attacker.var_fb2e0070ae6f04e4;
        var_de8c8c811657e5f8 = 1;
    }
    else if ( isplayer( attacker.owner ) )
    {
        attacker = attacker.owner;
        var_de8c8c811657e5f8 = 1;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    var_24d35773beab6cd6 = function_221ee6231e297a26( victimstruct );
    var_468af147eb683490 = function_956ad9e1687255a0( victimstruct );
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( victimstruct.origin, attacker function_c59b6b0d16e7777a() );
    superref = supers_mp::getsuperrefforsuperweapon( objweapon.basename );
    
    if ( superref )
    {
        if ( !isxhash( superref ) )
        {
            superref = getxhash( superref );
        }
        
        if ( !isdefined( var_49a734ae41b667b3 ) )
        {
            var_49a734ae41b667b3 = 0;
        }
        
        weaponclassarray = challenges::getweaponclassarray();
        
        foreach ( skilllevel in attacker.var_bcde97a1f15e0648 )
        {
            skillbundle = level.var_df3fc2ed023c3c0d[ superref ][ skilllevel ];
            
            if ( !skillbundle )
            {
                continue;
            }
            
            if ( skillbundle.abilityref != superref || skillbundle.skillcategory != #"ability" )
            {
                continue;
            }
            
            var_49a734ae41b667b3 = challenges::function_a23641f33e985edb( var_49a734ae41b667b3, weaponclassarray[ #"ability_upgrade" ] );
            break;
        }
        
        if ( !isdefined( attacker.modifiers[ #"weapon_class_bitfield" ] ) )
        {
            attacker.modifiers[ #"weapon_class_bitfield" ] = var_49a734ae41b667b3;
        }
    }
    
    activeskills = attacker.activeskills;
    var_30d51fb796c971be = function_ceab27509de5a042( activeskills, #"hash_e73ccaf791051828", level.var_290a71888a72cd4c.var_25b8a2894c1decb1 );
    var_e36666b6a27607e4 = function_ceab27509de5a042( activeskills, #"hash_e73ccdf791051d41", level.var_290a71888a72cd4c.var_f63d5b886e17c93b );
    rarity = getweaponrarity( attacker, objweapon );
    gametypebitfield = function_180dc844e4a0e4b5();
    difficulty = function_d27414bddcb6987e( victimstruct ) ?? 0;
    
    if ( victimstruct.var_495132567a05ca8a )
    {
        switch ( victimstruct.var_96d37c32bd7cc62 )
        {
            case #"hash_6306b8f9898bfbea":
            case #"hash_b1dc3483beee3c2c":
            case #"hash_c24b16fb9788caee":
                var_ccd0acd1fff0efae = function_971a0dd22469483e( victimstruct.var_495132567a05ca8a );
                break;
            case #"hash_d4354213f9160643":
                var_c74ca84e605aa691 = function_5c8f35200661f585( victimstruct.var_495132567a05ca8a );
                break;
            default:
                break;
        }
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"zm_zombie_type_bitfield" ] = function_f603dd218dbf4618( victimstruct );
    additionaleventparams[ #"ob_map_location" ] = var_e2454ccf8320aa42;
    additionaleventparams[ #"hash_e73ccaf791051828" ] = var_30d51fb796c971be;
    additionaleventparams[ #"hash_e73ccdf791051d41" ] = var_e36666b6a27607e4;
    additionaleventparams[ #"zm_rarity" ] = rarity;
    additionaleventparams[ #"ob_enemy_type_bitfield" ] = var_24d35773beab6cd6;
    additionaleventparams[ #"hash_9ab9749553b78b2c" ] = gametypebitfield;
    additionaleventparams[ #"ob_ai_team_bitfield" ] = var_468af147eb683490;
    additionaleventparams[ #"ob_ai_origin_tier_zone" ] = difficulty;
    additionaleventparams[ #"ob_power_tier" ] = int( max( 0, attacker ob_power_tier::function_6d4cdb24ee2c66c0() ) );
    additionaleventparams[ #"zm_elemental_ammomod_bitfield" ] = var_6eb61dc59ad8d126 ?? 0;
    additionaleventparams[ #"ob_activity_type" ] = var_ccd0acd1fff0efae ?? 0;
    additionaleventparams[ #"ob_contract_type" ] = var_c74ca84e605aa691 ?? 0;
    
    if ( var_de8c8c811657e5f8 )
    {
        if ( !isdefined( attacker.modifiers[ "mask5" ] ) )
        {
            attacker.modifiers[ "mask5" ] = 0;
        }
        
        attacker.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( attacker.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"allied_kill" ) );
        additionaleventparams[ #"hash_7f94e41c1787f8ae" ] = attacker.modifiers[ "mask5" ];
    }
    
    self.var_49b8b885e3f811e = 1;
    level challenges::onagentkilled( self, inflictor, attacker, sparams.idamage, meansofdeath, objweapon, attacker.modifiers, additionaleventparams );
    function_20cd6ba99993b39e( attacker, victimstruct, additionaleventparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xc991b390, Offset: 0x34c0
// Size: 0x4a
function private function_f603dd218dbf4618( victimstruct )
{
    var_c0f0d3ca6839224e = zombie_shared_challenges::function_f603dd218dbf4618( victimstruct );
    
    if ( victimstruct.activityboss )
    {
        var_c0f0d3ca6839224e = challenges::function_a23641f33e985edb( var_c0f0d3ca6839224e, zombie_shared_challenges::function_e56d7e27d2c774fd()[ #"boss" ] );
    }
    
    return var_c0f0d3ca6839224e;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x8cd19a7, Offset: 0x3513
// Size: 0x45
function private function_d27414bddcb6987e( victimstruct )
{
    if ( victimstruct.difficulty == "difficulty6" )
    {
        return level.difficulty_to_int[ "difficulty5" ];
    }
    
    return level.difficulty_to_int[ victimstruct.difficulty ];
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0x196ecf1b, Offset: 0x3561
// Size: 0x407
function private function_308028d5ee871d1f( player, exfilorigin, exfiltype )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    activities_data = player function_de6de8e060992e9a();
    aeeventname = #"ob_exfil";
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( exfilorigin, player function_c59b6b0d16e7777a() );
    exfilbitfield = function_9f500e37072fcb93( exfiltype, player.var_db592ad7a2598820 );
    eventdata = function_940ee4036e1a98ea();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_map_location" ) ] = var_e2454ccf8320aa42;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_exfil_bitfield" ) ] = exfilbitfield;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_power_tier" ) ] = player ob_power_tier::function_6d4cdb24ee2c66c0();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_has_been_downed" ) ] = player.has_been_downed ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_has_been_killed" ) ] = player.has_been_killed ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_clear_final_encounter" ) ] = player.var_19fcd75db86e0a15 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_operator_id" ) ] = player challenges::function_6a3bd1af73a5a390() ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_contracts_successfully_completed" ) ] = activities_data.var_e5e1693933011d1e ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_1577bc2a7f187352" ) ] = activities_data.var_6fb9048722063dcd ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_aade0f38626dad" ) ] = activities_data.var_5f899ba07fe62523 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_6c04f96afb94160" ) ] = activities_data.var_bbf2cdc133dedc8d ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_51900cb85a335073" ) ] = activities_data.var_578dd45c5c0c45f ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9bb6316fed0a5f3e" ) ] = activities_data.var_ee67fc5060c19cdb ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_activities_successfully_completed" ) ] = activities_data.var_390d4e9526bd6066 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_fbb85871da6cb482" ) ] = activities_data.var_f94f390fa541bb33 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f93d3172e19dedf7" ) ] = activities_data.var_bd3e4811319fe661 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_f8f08737c36b2458" ) ] = activities_data.var_8457ec60741563f3 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_fa689f710d9c2a05" ) ] = activities_data.var_9e66dc292b734275 ?? 0;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_661dc8d07b980936" ) ] = activities_data.var_24b2edda4d32bf9 ?? 0;
    
    /#
        challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
    #/
    
    player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0x1fc189fc, Offset: 0x3970
// Size: 0x2b7
function private function_75a7b7237dc12b8a( players, activityinstance )
{
    obsettings = ob::get_ob_settings();
    
    if ( !obsettings.var_e86ac0830ac429ae )
    {
        return;
    }
    
    aeeventname = #"end_activity";
    activitytype = activityinstance.type;
    var_ccd0acd1fff0efae = function_971a0dd22469483e( activitytype );
    activityorigin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    tracklocation = 0;
    
    foreach ( player in players )
    {
        if ( isplayer( player ) && player function_c59b6b0d16e7777a() )
        {
            tracklocation = 1;
            break;
        }
    }
    
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( activityorigin, tracklocation );
    eventdata = function_a453309ac5623b15();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_activity_type" ) ] = var_ccd0acd1fff0efae;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_map_location" ) ] = var_e2454ccf8320aa42;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_activity_complete_solo" ) ] = players.size == 1;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_2ef4e4fc4ff69f2b" ) ] = function_d1a959a997e41df7( activityinstance.successtype );
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_operator_id" ) ] = player challenges::function_6a3bd1af73a5a390() ?? 0;
        
        /#
            challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
        #/
        
        player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
        utility::callsharedfunc( #"ob_quest", #"activity_complete", player, activityinstance, 0 );
    }
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0x75b56c92, Offset: 0x3c2f
// Size: 0x2ea
function private function_e80236f0009ade79( players, activityinstance )
{
    obsettings = ob::get_ob_settings();
    
    if ( !obsettings.var_4a7b2548b61d297b )
    {
        return;
    }
    
    aeeventname = #"contract_end";
    activitytype = activityinstance.type;
    var_c74ca84e605aa691 = function_5c8f35200661f585( activitytype );
    activityorigin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    tracklocation = 0;
    
    foreach ( player in players )
    {
        if ( isplayer( player ) && player function_c59b6b0d16e7777a() )
        {
            tracklocation = 1;
            break;
        }
    }
    
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( activityorigin, tracklocation );
    
    if ( tracklocation && self.activity_starter_scriptable.var_ea54c0ab42a167ca )
    {
        difficulty_mask = 31;
        var_8cb0246e552a993c = function_e7100a5128eb181a( self.activity_starter_scriptable.var_ea54c0ab42a167ca, tracklocation );
        var_8cb0246e552a993c &= ~difficulty_mask;
        var_e2454ccf8320aa42 |= var_8cb0246e552a993c;
    }
    
    eventdata = function_47724ea0379fba88();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_contract_type" ) ] = var_c74ca84e605aa691;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_map_location" ) ] = var_e2454ccf8320aa42;
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        /#
            challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
        #/
        
        player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
        region = region_difficulty_manager::function_f9fbb630598afdc7( activityorigin );
        level callback::callback( #"hash_6c71d319dc089c27", { #regiondifficulty:region.difficulty, #player:player, #event:#"hash_57a7e5817efb1d97" } );
        utility::callsharedfunc( #"ob_quest", #"activity_complete", player, activityinstance, 1 );
    }
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0x917dd5dc, Offset: 0x3f21
// Size: 0x135
function private function_a91eb048b73c6b9a( players, var_71c9301ae528c0b2 )
{
    aeeventname = #"ob_mission";
    eventdata = function_ace61864e40cc0ec();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"wc_story_mission_bitfield" ) ] = var_71c9301ae528c0b2;
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_operator_id" ) ] = player challenges::function_6a3bd1af73a5a390() ?? 0;
        
        /#
            challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
        #/
        
        player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
    }
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0x15f5fe30, Offset: 0x405e
// Size: 0x3b
function private getweaponrarity( player, objweapon )
{
    rarity = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( objweapon ) ?? 0;
    
    if ( rarity == 6 )
    {
        return 5;
    }
    
    return rarity;
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0xe7ac9d11, Offset: 0x40a2
// Size: 0x137
function private function_20cd6ba99993b39e( killingplayer, victim, additionaleventparams = undefined )
{
    if ( !isplayer( killingplayer ) )
    {
        return;
    }
    
    if ( !isarray( victim.a_n_player_damage ) )
    {
        return;
    }
    
    victim.var_49b8b885e3f811e = 1;
    
    foreach ( assistplayer in victim.a_n_player_damage )
    {
        if ( !isplayer( assistplayer ) )
        {
            continue;
        }
        
        if ( assistplayer == killingplayer )
        {
            continue;
        }
        
        currentweapon = assistplayer getcurrentweapon();
        rarity = getweaponrarity( assistplayer, currentweapon );
        
        if ( !isdefined( additionaleventparams ) )
        {
            additionaleventparams = [];
        }
        
        additionaleventparams[ #"zm_rarity" ] = rarity;
        additionaleventparams[ #"ob_power_tier" ] = assistplayer ob_power_tier::function_6d4cdb24ee2c66c0();
        assistplayer challenges::function_3ef859e4837f4249( victim, assistplayer, currentweapon, additionaleventparams );
    }
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0xd5cfad7b, Offset: 0x41e1
// Size: 0x11e
function private function_6e0747409fa220e1( player, traversaltype, var_837a5d335e745ed )
{
    if ( !traversaltype )
    {
        assertmsg( "<dev string:x391>" );
        return;
    }
    
    if ( !var_837a5d335e745ed )
    {
        assertmsg( "<dev string:x3bf>" );
        return;
    }
    
    distancemeter = int( 0.0254 * var_837a5d335e745ed );
    
    if ( distancemeter <= 0 )
    {
        return;
    }
    
    eventdata = function_55d0c38345d25928();
    aeeventname = #"ob_traversal";
    var_8c40bc46633c2299 = function_270237fa63a3bfa5( traversaltype );
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = distancemeter;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_traversal_type_bitfield" ) ] = var_8c40bc46633c2299;
    
    /#
        challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
    #/
    
    player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0x4c2c6d5f, Offset: 0x4307
// Size: 0x119
function private function_75343d515a7338bf( player, var_e251ab0e6629fbf3, var_cd58ed580761b4c7 )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( var_e251ab0e6629fbf3 ) )
    {
        var_e251ab0e6629fbf3 = 0;
    }
    
    if ( !isdefined( var_cd58ed580761b4c7 ) )
    {
        var_cd58ed580761b4c7 = 0;
    }
    
    var_e2454ccf8320aa42 = function_e7100a5128eb181a( player getorigin(), player function_c59b6b0d16e7777a() );
    aeeventname = #"ob_interact";
    eventdata = function_5bc65db633e941a6();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_interact_bitfield" ) ] = var_e251ab0e6629fbf3;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_b431edc04f47bd9e" ) ] = var_cd58ed580761b4c7;
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"ob_map_location" ) ] = var_e2454ccf8320aa42;
    
    /#
        challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
    #/
    
    player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x5b21e348, Offset: 0x4428
// Size: 0xab
function private function_fa07992db2ca3058( sparams )
{
    aeeventname = #"damage_prevented";
    eventdata = function_933380e0031e705a();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = int( sparams.idamage );
    
    if ( sparams.lootid )
    {
        eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = sparams.lootid;
    }
    
    challenges::reportchallengeuserserializeddicteventinternal( self, aeeventname, eventdata.eventparams, 0 );
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xda9924b6, Offset: 0x44db
// Size: 0xa2
function private function_346e047cd09aa21b()
{
    obsettings = ob::get_ob_settings();
    
    if ( !obsettings.var_60f03fff07edce2e )
    {
        return;
    }
    
    curtime = gettime();
    
    if ( isdefined( self.var_9be15e9050f368b6 ) && curtime - self.var_9be15e9050f368b6 <= 2000 )
    {
        self.modifiers[ "after_wingsuit_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"after_wingsuit_kill" ) );
    }
}

// Namespace ob_challenges
// Params 1
// Checksum 0xd31713ec, Offset: 0x4585
// Size: 0x55
function function_5879d8d77ddcbe6e( origin )
{
    var_ebd85467250d2111 = function_fe6921cd509e52cf( 1, origin, 1 );
    poiregion = function_ba8494ae1c952908( 1, var_ebd85467250d2111 );
    
    if ( poiregion )
    {
        location = tolower( poiregion.name );
        return location;
    }
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0xb9ecc07c, Offset: 0x45e2
// Size: 0xea
function private function_e7100a5128eb181a( origin, tracklocation )
{
    var_e2454ccf8320aa42 = 0;
    obsettings = ob::get_ob_settings();
    
    if ( !obsettings.var_55fff8582c254160 )
    {
        return var_e2454ccf8320aa42;
    }
    
    region = region_difficulty_manager::function_f9fbb630598afdc7( origin );
    var_efcee59c9cf74c6f = function_1c52f2a5b172bc77();
    
    if ( !isdefined( var_efcee59c9cf74c6f[ region.difficulty ] ) )
    {
        assertmsg( "<dev string:x3ec>" + region.difficulty );
        return var_e2454ccf8320aa42;
    }
    
    var_e2454ccf8320aa42 = challenges::function_a23641f33e985edb( var_e2454ccf8320aa42, var_efcee59c9cf74c6f[ region.difficulty ] );
    
    if ( level.var_a78d7a5e7a1c74fb && tracklocation )
    {
        location = function_5879d8d77ddcbe6e( origin );
        
        if ( isdefined( var_efcee59c9cf74c6f[ location ] ) )
        {
            var_e2454ccf8320aa42 = challenges::function_a23641f33e985edb( var_e2454ccf8320aa42, var_efcee59c9cf74c6f[ location ] );
        }
    }
    
    return var_e2454ccf8320aa42;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x671d7076, Offset: 0x46d5
// Size: 0x1c
function private function_c59b6b0d16e7777a()
{
    assert( isdefined( self ), "<dev string:x420>" );
    return utility::ent_flag( "ob_quest_track_location" );
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x902eeb33, Offset: 0x46fa
// Size: 0x55
function private function_971a0dd22469483e( activitytype )
{
    var_ccd0acd1fff0efae = 0;
    var_512dbde1c68bdccb = function_3ad4ade74bf9c40c();
    
    if ( !isdefined( var_512dbde1c68bdccb[ activitytype ] ) )
    {
        println( "<dev string:x468>" + activitytype );
        return var_ccd0acd1fff0efae;
    }
    
    var_ccd0acd1fff0efae = challenges::function_a23641f33e985edb( var_ccd0acd1fff0efae, var_512dbde1c68bdccb[ activitytype ] );
    return var_ccd0acd1fff0efae;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x7ef6b83f, Offset: 0x4758
// Size: 0x65
function private function_d1a959a997e41df7( var_69146f12693e9dda )
{
    var_c168d07120d65807 = 0;
    
    if ( !var_69146f12693e9dda )
    {
        return var_c168d07120d65807;
    }
    
    var_a91061fd3ac9de62 = function_fd0e6c1bdd45c6eb();
    
    if ( !isdefined( var_a91061fd3ac9de62[ var_69146f12693e9dda ] ) )
    {
        assertmsg( "<dev string:x480>" + getxhashsourcename( var_69146f12693e9dda ) );
        return var_c168d07120d65807;
    }
    
    var_c168d07120d65807 = challenges::function_a23641f33e985edb( var_c168d07120d65807, var_a91061fd3ac9de62[ var_69146f12693e9dda ] );
    return var_c168d07120d65807;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xad904bea, Offset: 0x47c6
// Size: 0x55
function private function_5c8f35200661f585( activitytype )
{
    var_c74ca84e605aa691 = 0;
    var_a3eae5ae61c8e0b4 = function_2e63615423dcc2ad();
    
    if ( !isdefined( var_a3eae5ae61c8e0b4[ activitytype ] ) )
    {
        println( "<dev string:x4c1>" + activitytype );
        return var_c74ca84e605aa691;
    }
    
    var_c74ca84e605aa691 = challenges::function_a23641f33e985edb( var_c74ca84e605aa691, var_a3eae5ae61c8e0b4[ activitytype ] );
    return var_c74ca84e605aa691;
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0xdef5071b, Offset: 0x4824
// Size: 0x63
function private function_9f500e37072fcb93( exfiltype, var_b54c4fe061b1e0b0 )
{
    exfilbitfield = 0;
    exfilbits = function_616438edfae109d7();
    
    if ( exfilbits[ exfiltype ] )
    {
        exfilbitfield = challenges::function_a23641f33e985edb( exfilbitfield, exfilbits[ exfiltype ] );
    }
    
    if ( var_b54c4fe061b1e0b0 )
    {
        exfilbitfield = challenges::function_a23641f33e985edb( exfilbitfield, exfilbits[ #"never_fired" ] );
    }
    
    return exfilbitfield;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x295cf33b, Offset: 0x4890
// Size: 0x36d
function private function_de6de8e060992e9a()
{
    foreach ( activity in self.activities.completedactivities )
    {
        if ( !activity.success )
        {
            continue;
        }
        
        if ( activity.category == "Contract" )
        {
            if ( !isdefined( completed_contracts ) )
            {
                completed_contracts = 0;
            }
            
            completed_contracts++;
            
            switch ( activity.difficulty )
            {
                case #"hash_7bb2cd766703d463":
                    if ( !isdefined( var_6fb9048722063dcd ) )
                    {
                        var_6fb9048722063dcd = 0;
                    }
                    
                    var_6fb9048722063dcd++;
                    break;
                case #"hash_af83e47edfa8900a":
                    if ( !isdefined( var_5f899ba07fe62523 ) )
                    {
                        var_5f899ba07fe62523 = 0;
                    }
                    
                    var_5f899ba07fe62523++;
                    break;
                case #"hash_5343b465e56ec9a4":
                    if ( !isdefined( var_bbf2cdc133dedc8d ) )
                    {
                        var_bbf2cdc133dedc8d = 0;
                    }
                    
                    var_bbf2cdc133dedc8d++;
                    break;
                case #"hash_651f76c0ad6741ec":
                    if ( !isdefined( var_578dd45c5c0c45f ) )
                    {
                        var_578dd45c5c0c45f = 0;
                    }
                    
                    var_578dd45c5c0c45f++;
                    break;
                case #"hash_c0250ffc2e87f2ff":
                case #"hash_c02510fc2e87f492":
                    if ( !isdefined( var_ee67fc5060c19cdb ) )
                    {
                        var_ee67fc5060c19cdb = 0;
                    }
                    
                    var_ee67fc5060c19cdb++;
                    break;
                default:
                    assertmsg( "<dev string:x4d9>" + activity.difficulty );
                    break;
            }
            
            continue;
        }
        
        if ( activity.category == "Activity" || activity.category == "Startup" )
        {
            if ( !isdefined( completed_activities ) )
            {
                completed_activities = 0;
            }
            
            completed_activities++;
            
            switch ( activity.difficulty )
            {
                case #"hash_7bb2cd766703d463":
                    if ( !isdefined( var_f94f390fa541bb33 ) )
                    {
                        var_f94f390fa541bb33 = 0;
                    }
                    
                    var_f94f390fa541bb33++;
                    break;
                case #"hash_af83e47edfa8900a":
                    if ( !isdefined( var_bd3e4811319fe661 ) )
                    {
                        var_bd3e4811319fe661 = 0;
                    }
                    
                    var_bd3e4811319fe661++;
                    break;
                case #"hash_5343b465e56ec9a4":
                    if ( !isdefined( var_8457ec60741563f3 ) )
                    {
                        var_8457ec60741563f3 = 0;
                    }
                    
                    var_8457ec60741563f3++;
                    break;
                case #"hash_651f76c0ad6741ec":
                    if ( !isdefined( var_9e66dc292b734275 ) )
                    {
                        var_9e66dc292b734275 = 0;
                    }
                    
                    var_9e66dc292b734275++;
                    break;
                case #"hash_c0250ffc2e87f2ff":
                case #"hash_c02510fc2e87f492":
                    if ( !isdefined( var_24b2edda4d32bf9 ) )
                    {
                        var_24b2edda4d32bf9 = 0;
                    }
                    
                    var_24b2edda4d32bf9++;
                    break;
                default:
                    assertmsg( "<dev string:x4d9>" + activity.difficulty );
                    break;
            }
        }
    }
    
    var_c44c3b6dd3aa1abd = { #var_ee67fc5060c19cdb:var_ee67fc5060c19cdb, #var_578dd45c5c0c45f:var_578dd45c5c0c45f, #var_bbf2cdc133dedc8d:var_bbf2cdc133dedc8d, #var_5f899ba07fe62523:var_5f899ba07fe62523, #var_6fb9048722063dcd:var_6fb9048722063dcd, #var_e5e1693933011d1e:completed_contracts, #var_24b2edda4d32bf9:var_24b2edda4d32bf9, #var_9e66dc292b734275:var_9e66dc292b734275, #var_8457ec60741563f3:var_8457ec60741563f3, #var_bd3e4811319fe661:var_bd3e4811319fe661, #var_f94f390fa541bb33:var_f94f390fa541bb33, #var_390d4e9526bd6066:completed_activities };
    return var_c44c3b6dd3aa1abd;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xc61075a8, Offset: 0x4c06
// Size: 0x7b
function private function_180dc844e4a0e4b5()
{
    gametypebitfield = 0;
    obsettings = ob::get_ob_settings();
    
    if ( !obsettings.var_f13efcb2e25ea403 )
    {
        return gametypebitfield;
    }
    
    gametypebits = function_ba585f13a5906d20();
    
    if ( !isdefined( gametypebits[ #"endgame" ] ) )
    {
        assertmsg( "<dev string:x4fe>" );
        return gametypebitfield;
    }
    
    gametypebitfield = challenges::function_a23641f33e985edb( gametypebitfield, gametypebits[ #"endgame" ] );
    return gametypebitfield;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xa53c4345, Offset: 0x4c8a
// Size: 0x55
function private function_270237fa63a3bfa5( traversaltype )
{
    var_8c40bc46633c2299 = 0;
    var_aefd7e6d67380fdc = function_31d4ed9ba77a4e4d();
    
    if ( !isdefined( var_aefd7e6d67380fdc[ traversaltype ] ) )
    {
        assertmsg( "<dev string:x53d>" );
        return var_8c40bc46633c2299;
    }
    
    var_8c40bc46633c2299 = challenges::function_a23641f33e985edb( var_8c40bc46633c2299, var_aefd7e6d67380fdc[ traversaltype ] );
    return var_8c40bc46633c2299;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xf6ea8f4d, Offset: 0x4ce8
// Size: 0xa0
function private function_ba585f13a5906d20()
{
    if ( level.var_290a71888a72cd4c.var_7c2a859e7f9e6c84 && level.var_290a71888a72cd4c.var_7c2a859e7f9e6c84.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_7c2a859e7f9e6c84;
    }
    
    var_7c2a859e7f9e6c84 = [];
    var_7c2a859e7f9e6c84[ #"endgame" ] = ae_utility::function_2d1565a236387b2( #"hash_9ab9749553b78b2c", #"endgame" );
    level.var_290a71888a72cd4c.var_7c2a859e7f9e6c84 = var_7c2a859e7f9e6c84;
    return level.var_290a71888a72cd4c.var_7c2a859e7f9e6c84;
}

// Namespace ob_challenges
// Params 0
// Checksum 0xa81ed715, Offset: 0x4d91
// Size: 0x28e
function function_be2516732994b5d6()
{
    if ( level.var_290a71888a72cd4c.var_1c62a27564390e76 && level.var_1c62a27564390e76.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_1c62a27564390e76;
    }
    
    var_1c62a27564390e76 = [];
    var_1c62a27564390e76[ #"loot_cache_looted" ] = ae_utility::function_2d1565a236387b2( #"ob_interact_bitfield", #"loot_cache_looted" );
    var_1c62a27564390e76[ #"direct_line_ping" ] = ae_utility::function_2d1565a236387b2( #"ob_interact_bitfield", #"direct_line_ping" );
    var_1c62a27564390e76[ #"hash_51e40c907cc5dbce" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_51e40c907cc5dbce" );
    var_1c62a27564390e76[ #"hash_bb4dd3a6d8438047" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_bb4dd3a6d8438047" );
    var_1c62a27564390e76[ #"hash_efc27a44b70f66c1" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_efc27a44b70f66c1" );
    var_1c62a27564390e76[ #"hash_d34e1eadd49e5a21" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_d34e1eadd49e5a21" );
    var_1c62a27564390e76[ #"hash_b083169c6da221d9" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_b083169c6da221d9" );
    var_1c62a27564390e76[ #"hash_3a14200176a3c4aa" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_3a14200176a3c4aa" );
    var_1c62a27564390e76[ #"on_obtain_elite_weapon" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"on_obtain_elite_weapon" );
    var_1c62a27564390e76[ #"hash_77963ced32f542e7" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_77963ced32f542e7" );
    var_1c62a27564390e76[ #"hash_830bd5a1815cbbe6" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_830bd5a1815cbbe6" );
    var_1c62a27564390e76[ #"hash_a8733271ed9400d7" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_a8733271ed9400d7" );
    var_1c62a27564390e76[ #"hash_5907e591e1155d16" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_5907e591e1155d16" );
    var_1c62a27564390e76[ #"hash_4e33b5cdebad9e7a" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_4e33b5cdebad9e7a" );
    var_1c62a27564390e76[ #"hash_f68bb686d0f02577" ] = ae_utility::function_2d1565a236387b2( #"hash_b431edc04f47bd9e", #"hash_f68bb686d0f02577" );
    level.var_290a71888a72cd4c.var_1c62a27564390e76 = var_1c62a27564390e76;
    return level.var_290a71888a72cd4c.var_1c62a27564390e76;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x2616461a, Offset: 0x5028
// Size: 0x3bc
function private function_1c52f2a5b172bc77()
{
    if ( level.var_290a71888a72cd4c.var_94832695004d03ef && level.var_290a71888a72cd4c.var_94832695004d03ef.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_94832695004d03ef;
    }
    
    var_94832695004d03ef = [];
    var_94832695004d03ef[ "difficulty_easy" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"region_difficulty_1" );
    var_94832695004d03ef[ "difficulty_normal" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"region_difficulty_2" );
    var_94832695004d03ef[ "difficulty_hard" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"region_difficulty_3" );
    var_94832695004d03ef[ "difficulty_darkaether" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"region_difficulty_4" );
    var_94832695004d03ef[ "difficulty5" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"region_difficulty_5" );
    var_94832695004d03ef[ "avalon_region_trinitystadium" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_trinitystadium" );
    var_94832695004d03ef[ "avalon_region_golfclub" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_golfclub" );
    var_94832695004d03ef[ "avalon_region_residences" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_residences" );
    var_94832695004d03ef[ "avalon_region_winery" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_winery" );
    var_94832695004d03ef[ "avalon_region_casino" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_casino" );
    var_94832695004d03ef[ "avalon_region_resorts" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_resorts" );
    var_94832695004d03ef[ "avalon_region_excavationsite" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_excavationsite" );
    var_94832695004d03ef[ "avalon_region_colosseum" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_colosseum" );
    var_94832695004d03ef[ "avalon_region_clifftown" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_clifftown" );
    var_94832695004d03ef[ "avalon_region_watertreatment" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_watertreatment" );
    var_94832695004d03ef[ "avalon_region_heliport" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_heliport" );
    var_94832695004d03ef[ "avalon_region_carfactory" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_carfactory" );
    var_94832695004d03ef[ "avalon_region_oldarsenal" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_oldarsenal" );
    var_94832695004d03ef[ "avalon_region_chopshop" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_chopshop" );
    var_94832695004d03ef[ "avalon_region_pierdistrict" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_pierdistrict" );
    var_94832695004d03ef[ "avalon_region_listeningpost" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_listeningpost" );
    var_94832695004d03ef[ "avalon_region_fort" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_fort" );
    var_94832695004d03ef[ "avalon_region_firingrange" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_firingrange" );
    var_94832695004d03ef[ "avalon_region_coastalsecurity" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_coastalsecurity" );
    var_94832695004d03ef[ "avalon_region_hightown" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_hightown" );
    var_94832695004d03ef[ "avalon_region_oldtown" ] = ae_utility::function_2d1565a236387b2( #"ob_map_location", #"avalon_region_oldtown" );
    level.var_290a71888a72cd4c.var_94832695004d03ef = var_94832695004d03ef;
    return level.var_290a71888a72cd4c.var_94832695004d03ef;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x9d34eec7, Offset: 0x53ed
// Size: 0x1b4
function private function_6c16fe5c6c502aeb()
{
    if ( level.var_290a71888a72cd4c.var_b9b106fa7c8aa47f && level.var_290a71888a72cd4c.var_b9b106fa7c8aa47f.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_b9b106fa7c8aa47f;
    }
    
    var_b9b106fa7c8aa47f = [];
    var_b9b106fa7c8aa47f[ #"aries_boss_defeated" ] = ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", #"hash_4f48d2123abde629" );
    var_b9b106fa7c8aa47f[ #"cabin_barrage_end" ] = ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", #"hash_d9436bf3f3202132" );
    var_b9b106fa7c8aa47f[ #"hash_c692dcb8a92d659c" ] = ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", #"gemini_complete_stealth" );
    var_b9b106fa7c8aa47f[ #"frogger_complete" ] = ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", #"virgo_complete_frogger" );
    var_b9b106fa7c8aa47f[ #"menendez_defeated" ] = ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", #"hash_b4cb8ce8150db3a3" );
    
    foreach ( bitname, val in level.var_864e37cb92a447c )
    {
        var_b9b106fa7c8aa47f[ bitname ] = ae_utility::function_2d1565a236387b2( #"wc_story_mission_bitfield", bitname );
    }
    
    level.var_290a71888a72cd4c.var_b9b106fa7c8aa47f = var_b9b106fa7c8aa47f;
    return level.var_290a71888a72cd4c.var_b9b106fa7c8aa47f;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x207dc950, Offset: 0x55aa
// Size: 0xa0
function private function_31d4ed9ba77a4e4d()
{
    if ( level.var_290a71888a72cd4c.var_af00883a8b96e1e4 && level.var_290a71888a72cd4c.var_af00883a8b96e1e4.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_af00883a8b96e1e4;
    }
    
    var_af00883a8b96e1e4 = [];
    var_af00883a8b96e1e4[ #"wingsuit" ] = ae_utility::function_2d1565a236387b2( #"ob_traversal_type_bitfield", #"wingsuit" );
    level.var_290a71888a72cd4c.var_af00883a8b96e1e4 = var_af00883a8b96e1e4;
    return level.var_290a71888a72cd4c.var_af00883a8b96e1e4;
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0x9c5196a, Offset: 0x5653
// Size: 0xd4
function private function_ceab27509de5a042( activeskills, bitfieldkey, var_6559619f25a90d79 )
{
    skillbitfield = 0;
    
    foreach ( skillref, rarity in activeskills )
    {
        if ( var_6559619f25a90d79[ skillref ] )
        {
            skillbitfield = challenges::function_a23641f33e985edb( skillbitfield, var_6559619f25a90d79[ skillref ] );
            continue;
        }
        
        if ( ae_utility::function_545a7a23289934e6( bitfieldkey, skillref ) )
        {
            var_6559619f25a90d79[ skillref ] = ae_utility::function_2d1565a236387b2( bitfieldkey, skillref );
            skillbitfield = challenges::function_a23641f33e985edb( skillbitfield, var_6559619f25a90d79[ skillref ] );
        }
    }
    
    return skillbitfield;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x5fc0e64c, Offset: 0x5730
// Size: 0x7b
function private function_cb05e13fe0a75895( interactionevent )
{
    var_cd58ed580761b4c7 = 0;
    
    if ( !interactionevent )
    {
        assertmsg( "<dev string:x57a>" );
        return var_cd58ed580761b4c7;
    }
    
    var_f80a400bf692eb93 = function_be2516732994b5d6();
    
    if ( !isdefined( var_f80a400bf692eb93[ interactionevent ] ) )
    {
        assertmsg( "<dev string:x5c1>" + getxhashsourcename( interactionevent ) + "<dev string:x5e0>" );
        return var_cd58ed580761b4c7;
    }
    
    var_cd58ed580761b4c7 = challenges::function_a23641f33e985edb( var_cd58ed580761b4c7, var_f80a400bf692eb93[ interactionevent ] );
    return var_cd58ed580761b4c7;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xa7374dbf, Offset: 0x57b4
// Size: 0x4e
function private function_940f19149d469aa3( source )
{
    supersbitfield = 0;
    
    if ( !source )
    {
        return supersbitfield;
    }
    
    superbits = function_764bb5d39aab3699();
    
    if ( !isdefined( superbits[ source ] ) )
    {
        return supersbitfield;
    }
    
    supersbitfield = challenges::function_a23641f33e985edb( supersbitfield, superbits[ source ] );
    return supersbitfield;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x13886100, Offset: 0x580b
// Size: 0x5c
function private function_39baaed6e56019ee( skillcategory )
{
    var_cdb11cc45973c2d1 = 0;
    var_7614b5db563b55bf = function_c058b1dcc4248fdc();
    
    if ( !isdefined( var_7614b5db563b55bf[ skillcategory ] ) )
    {
        assertmsg( "<dev string:x610>" + getxhashsourcename( skillcategory ) );
        return var_cdb11cc45973c2d1;
    }
    
    var_cdb11cc45973c2d1 = challenges::function_a23641f33e985edb( var_cdb11cc45973c2d1, var_7614b5db563b55bf[ skillcategory ] );
    return var_cdb11cc45973c2d1;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x565b6471, Offset: 0x5870
// Size: 0xec
function private function_2847cd71ed069ca8( victim )
{
    if ( !isdefined( var_7b2c34037035e4c0 ) )
    {
        var_7b2c34037035e4c0 = 0;
    }
    
    enemysubclass = victim.subclass;
    
    if ( enemysubclass )
    {
        var_db09b7f06940fbdd = function_de8793257dfe4dd6();
        var_a39f27d577f5053d = getxhash( enemysubclass );
        
        if ( isdefined( var_db09b7f06940fbdd[ var_a39f27d577f5053d ] ) )
        {
            var_7b2c34037035e4c0 = challenges::function_a23641f33e985edb( var_7b2c34037035e4c0, var_db09b7f06940fbdd[ var_a39f27d577f5053d ] );
        }
    }
    
    ref = victim.vehicleref ?? victim vehicle::get_ref();
    subclass = victim.subclass ?? "";
    
    if ( ref && ref == "ob_guild_drone" || subclass == "ob_helper_drone" )
    {
        var_7b2c34037035e4c0 = challenges::function_a23641f33e985edb( var_7b2c34037035e4c0, ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_guild_drone" ) );
    }
    
    return var_7b2c34037035e4c0;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xc931ff, Offset: 0x5965
// Size: 0x156
function private function_221ee6231e297a26( victim )
{
    if ( !isdefined( var_24d35773beab6cd6 ) )
    {
        var_24d35773beab6cd6 = 0;
    }
    
    if ( !victim )
    {
        println( "<dev string:x63d>" );
        return var_24d35773beab6cd6;
    }
    
    enemysubclass = victim.subclass;
    
    if ( !enemysubclass )
    {
        println( "<dev string:x66f>" );
        return var_24d35773beab6cd6;
    }
    
    var_db09b7f06940fbdd = function_de8793257dfe4dd6();
    var_a39f27d577f5053d = getxhash( enemysubclass );
    
    if ( victim.unittype == "juggernaut" && var_a39f27d577f5053d == #"ob_grunt" )
    {
        var_24d35773beab6cd6 = challenges::function_a23641f33e985edb( var_24d35773beab6cd6, var_db09b7f06940fbdd[ #"hash_d4fd0ea4d1b14b6d" ] );
        return var_24d35773beab6cd6;
    }
    
    if ( victim.unittype == "juggernaut" && var_a39f27d577f5053d == #"ob_specialist" )
    {
        var_24d35773beab6cd6 = challenges::function_a23641f33e985edb( var_24d35773beab6cd6, var_db09b7f06940fbdd[ #"ob_juggernaut" ] );
        return var_24d35773beab6cd6;
    }
    
    if ( issubstr( enemysubclass, "_hvt" ) )
    {
        if ( isdefined( var_db09b7f06940fbdd[ #"hvt" ] ) )
        {
            var_24d35773beab6cd6 = challenges::function_a23641f33e985edb( var_24d35773beab6cd6, var_db09b7f06940fbdd[ #"hvt" ] );
        }
        
        enemysubclass = removesubstr( enemysubclass, "_hvt" );
        var_a39f27d577f5053d = getxhash( enemysubclass );
    }
    
    if ( isdefined( var_db09b7f06940fbdd[ var_a39f27d577f5053d ] ) )
    {
        var_24d35773beab6cd6 = challenges::function_a23641f33e985edb( var_24d35773beab6cd6, var_db09b7f06940fbdd[ var_a39f27d577f5053d ] );
    }
    
    return var_24d35773beab6cd6;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x4084eef7, Offset: 0x5ac4
// Size: 0x298
function private function_de8793257dfe4dd6()
{
    if ( level.var_290a71888a72cd4c.var_b793b5b66b879627 && level.var_290a71888a72cd4c.var_b793b5b66b879627.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_b793b5b66b879627;
    }
    
    var_b793b5b66b879627 = [];
    var_b793b5b66b879627[ #"ob_grunt" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_grunt" );
    var_b793b5b66b879627[ #"ob_soldier" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_soldier" );
    var_b793b5b66b879627[ #"ob_rocketeer" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_rocketeer" );
    var_b793b5b66b879627[ #"ob_sniper" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_sniper" );
    var_b793b5b66b879627[ #"ob_tactician" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_tactician" );
    var_b793b5b66b879627[ #"ob_rusher" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_rusher" );
    var_b793b5b66b879627[ #"ob_shielded" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_shielded" );
    var_b793b5b66b879627[ #"ob_specop_bot" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_specop_bot" );
    var_b793b5b66b879627[ #"dawg" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"dawg" );
    var_b793b5b66b879627[ #"juggerbot" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"juggerbot" );
    var_b793b5b66b879627[ #"ob_commander" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_commander" );
    var_b793b5b66b879627[ #"ob_juggernaut" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"ob_juggernaut" );
    var_b793b5b66b879627[ #"hash_d4fd0ea4d1b14b6d" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"hash_d4fd0ea4d1b14b6d" );
    var_b793b5b66b879627[ #"hvt" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"hvt" );
    var_b793b5b66b879627[ #"before_deploy" ] = ae_utility::function_2d1565a236387b2( #"ob_enemy_type_bitfield", #"before_deploy" );
    level.var_290a71888a72cd4c.var_b793b5b66b879627 = var_b793b5b66b879627;
    return level.var_290a71888a72cd4c.var_b793b5b66b879627;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xefec8438, Offset: 0x5d65
// Size: 0x94
function private function_956ad9e1687255a0( victim )
{
    if ( !isdefined( var_468af147eb683490 ) )
    {
        var_468af147eb683490 = 0;
    }
    
    if ( !victim )
    {
        return var_468af147eb683490;
    }
    
    aiteam = victim.team;
    
    if ( !aiteam )
    {
        return var_468af147eb683490;
    }
    
    var_121732e2d6a5e8cd = getxhash( aiteam );
    var_b4a44894bf35e5c4 = function_a519f76e09ef0c5a();
    
    if ( var_b4a44894bf35e5c4[ var_121732e2d6a5e8cd ] )
    {
        var_468af147eb683490 = challenges::function_a23641f33e985edb( var_468af147eb683490, var_b4a44894bf35e5c4[ var_121732e2d6a5e8cd ] );
    }
    else
    {
        var_468af147eb683490 = challenges::function_a23641f33e985edb( var_468af147eb683490, var_b4a44894bf35e5c4[ #"other" ] );
    }
    
    return var_468af147eb683490;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xf9e98de3, Offset: 0x5e02
// Size: 0x154
function private function_a519f76e09ef0c5a()
{
    if ( level.var_290a71888a72cd4c.aiteamarray && level.var_290a71888a72cd4c.aiteamarray.size != 0 )
    {
        return level.var_290a71888a72cd4c.aiteamarray;
    }
    
    aiteamarray = [];
    aiteamarray[ #"civilian" ] = ae_utility::function_2d1565a236387b2( #"ob_ai_team_bitfield", #"civilian" );
    aiteamarray[ #"team_two_hundred" ] = ae_utility::function_2d1565a236387b2( #"ob_ai_team_bitfield", #"team_two_hundred" );
    aiteamarray[ #"team_hundred_ninety" ] = ae_utility::function_2d1565a236387b2( #"ob_ai_team_bitfield", #"team_hundred_ninety" );
    aiteamarray[ #"allies" ] = ae_utility::function_2d1565a236387b2( #"ob_ai_team_bitfield", #"allies" );
    aiteamarray[ #"axis" ] = ae_utility::function_2d1565a236387b2( #"ob_ai_team_bitfield", #"axis" );
    aiteamarray[ #"other" ] = ae_utility::function_2d1565a236387b2( #"ob_ai_team_bitfield", #"other" );
    level.var_290a71888a72cd4c.aiteamarray = aiteamarray;
    return level.var_290a71888a72cd4c.aiteamarray;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x36ec74cb, Offset: 0x5f5f
// Size: 0x2e0
function private function_c058b1dcc4248fdc()
{
    if ( level.var_290a71888a72cd4c.var_ecdcbb227b5f8c60 && level.var_290a71888a72cd4c.var_ecdcbb227b5f8c60.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_ecdcbb227b5f8c60;
    }
    
    var_ecdcbb227b5f8c60 = [];
    var_ecdcbb227b5f8c60[ #"ability" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"ability" );
    var_ecdcbb227b5f8c60[ #"assassin" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"assassin" );
    var_ecdcbb227b5f8c60[ #"brawler" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"brawler" );
    var_ecdcbb227b5f8c60[ #"bruiser" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"bruiser" );
    var_ecdcbb227b5f8c60[ #"combat_medic" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"combat_medic" );
    var_ecdcbb227b5f8c60[ #"core_stat" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"core_stat" );
    var_ecdcbb227b5f8c60[ #"core_weapon" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"core_weapon" );
    var_ecdcbb227b5f8c60[ #"daredevil" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"daredevil" );
    var_ecdcbb227b5f8c60[ #"eagle_eye" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"eagle_eye" );
    var_ecdcbb227b5f8c60[ #"end_game" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"end_game" );
    var_ecdcbb227b5f8c60[ #"gunslinger" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"gunslinger" );
    var_ecdcbb227b5f8c60[ #"item" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"item" );
    var_ecdcbb227b5f8c60[ #"marathoner" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"marathoner" );
    var_ecdcbb227b5f8c60[ #"quartermaster" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"quartermaster" );
    var_ecdcbb227b5f8c60[ #"nightmare" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"nightmare" );
    var_ecdcbb227b5f8c60[ #"swarm_leader" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"swarm_leader" );
    var_ecdcbb227b5f8c60[ #"warden" ] = ae_utility::function_2d1565a236387b2( #"ob_skills_category_bitfield", #"warden" );
    level.var_290a71888a72cd4c.var_ecdcbb227b5f8c60 = var_ecdcbb227b5f8c60;
    return level.var_290a71888a72cd4c.var_ecdcbb227b5f8c60;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xed1a64a, Offset: 0x6248
// Size: 0xa0
function private function_764bb5d39aab3699()
{
    if ( level.var_290a71888a72cd4c.var_a883fa91eadc1c6d && level.var_290a71888a72cd4c.var_a883fa91eadc1c6d.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_a883fa91eadc1c6d;
    }
    
    var_a883fa91eadc1c6d = [];
    var_a883fa91eadc1c6d[ #"super_overcharge" ] = ae_utility::function_2d1565a236387b2( #"supers_bitfield", #"super_overcharge" );
    level.var_290a71888a72cd4c.var_a883fa91eadc1c6d = var_a883fa91eadc1c6d;
    return level.var_290a71888a72cd4c.var_a883fa91eadc1c6d;
}

// Namespace ob_challenges
// Params 1
// Checksum 0x3744420, Offset: 0x62f1
// Size: 0x52
function function_6a3e9c959b67d9be( storyevent )
{
    var_71c9301ae528c0b2 = 0;
    var_b9b106fa7c8aa47f = function_6c16fe5c6c502aeb();
    
    if ( !isdefined( var_b9b106fa7c8aa47f[ storyevent ] ) )
    {
        println( "<dev string:x6a8>" );
        return var_71c9301ae528c0b2;
    }
    
    var_71c9301ae528c0b2 = challenges::function_a23641f33e985edb( var_71c9301ae528c0b2, var_b9b106fa7c8aa47f[ storyevent ] );
    return var_71c9301ae528c0b2;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x828b211, Offset: 0x634c
// Size: 0x41c
function private function_3ad4ade74bf9c40c()
{
    if ( level.var_290a71888a72cd4c.var_545a13d8deacfb9c && level.var_290a71888a72cd4c.var_545a13d8deacfb9c.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_545a13d8deacfb9c;
    }
    
    var_545a13d8deacfb9c = [];
    var_545a13d8deacfb9c[ "REV_OB_CRADLE_VENTS" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"cradle_vents" );
    var_545a13d8deacfb9c[ "REV_OB_MERC_CAMP" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"ob_merc_camp" );
    var_545a13d8deacfb9c[ "REV_OB_MERC_STRONGHOLD" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"ob_merc_stronhghold" );
    var_545a13d8deacfb9c[ "REV_OB_QUARANTINE_ZONE" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"quarantine_stronghold" );
    var_545a13d8deacfb9c[ "REV_OB_CRASH_SITES" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"crash_sites" );
    var_545a13d8deacfb9c[ "REV_OB_DESTROY_SUPPLIES" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"power_supply" );
    var_545a13d8deacfb9c[ "REV_OB_HELI_TAKEDOWN" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"vtol_takedown" );
    var_545a13d8deacfb9c[ "REV_OB_ARMORED_CONVOY" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"ob_armored_convoy" );
    var_545a13d8deacfb9c[ "REV_OB_SAFECRACK" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"safe" );
    var_545a13d8deacfb9c[ "REV_OB_SUPPLY_DROP" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"supply_drop" );
    var_545a13d8deacfb9c[ "REV_OB_HUNT_SQUAD" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"hunt_squad" );
    var_545a13d8deacfb9c[ "REV_OB_HARVESTERORB" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"drone_hunt" );
    var_545a13d8deacfb9c[ "REV_OB_ROADSIDE_ASSISTANCE" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"roadside_assistance" );
    var_545a13d8deacfb9c[ "REV_OB_PRIME_TARGET" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"prime_target" );
    var_545a13d8deacfb9c[ "REV_OB_SURPRISE_SHIPMENT" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"surprise_shipment" );
    var_545a13d8deacfb9c[ "REV_OB_PROP_HUNT" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"prop_hunt" );
    var_545a13d8deacfb9c[ "REV_OB_FLIGHT_SCHOOL" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"flight_school" );
    var_545a13d8deacfb9c[ "REV_OB_TARGET_ELIMINATION" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"target_elimination" );
    var_545a13d8deacfb9c[ "REV_OB_RED_FLOOD" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"red_flood" );
    var_545a13d8deacfb9c[ "REV_OB_ABOM_HUNT" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"abom_hunt" );
    var_545a13d8deacfb9c[ "REV_OB_STRIKE_BOSS" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"strike_boss" );
    var_545a13d8deacfb9c[ "REV_OB_LOCKED_IN" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"locked_in" );
    var_545a13d8deacfb9c[ "REV_OB_POSSESSED_CONVOY" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"possessed_convoy" );
    var_545a13d8deacfb9c[ "OB_SCORPIO_INTERIOR" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"robot_boss" );
    var_545a13d8deacfb9c[ "REV_OB_POI_BOSS" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"hash_b360becd37e9eabb" );
    var_545a13d8deacfb9c[ "REV_OB_VTOL_BOSS" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"vtol_boss" );
    var_545a13d8deacfb9c[ "REV_OB_CRADLE_BOMB" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"cradle_bomb" );
    var_545a13d8deacfb9c[ "REV_OB_TOXIN_BOMB" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"toxin_bomb" );
    var_545a13d8deacfb9c[ "REV_OB_HAUNTING" ] = ae_utility::function_2d1565a236387b2( #"ob_activity_type", #"zombie_deathworm_boss_ob" );
    level.var_290a71888a72cd4c.var_545a13d8deacfb9c = var_545a13d8deacfb9c;
    return level.var_290a71888a72cd4c.var_545a13d8deacfb9c;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x7345915d, Offset: 0x6771
// Size: 0xf3
function private function_fd0e6c1bdd45c6eb()
{
    if ( level.var_290a71888a72cd4c.var_d63e7ab43a3054db.size )
    {
        return level.var_290a71888a72cd4c.var_d63e7ab43a3054db;
    }
    
    var_d63e7ab43a3054db = [];
    var_d63e7ab43a3054db[ #"timer_elapsed" ] = ae_utility::function_2d1565a236387b2( #"hash_2ef4e4fc4ff69f2b", #"timer_elapsed" );
    var_d63e7ab43a3054db[ #"all_enemies_killed" ] = ae_utility::function_2d1565a236387b2( #"hash_2ef4e4fc4ff69f2b", #"all_enemies_killed" );
    var_d63e7ab43a3054db[ #"hash_1639b37bf8a7b6a3" ] = ae_utility::function_2d1565a236387b2( #"hash_2ef4e4fc4ff69f2b", #"hash_1639b37bf8a7b6a3" );
    var_d63e7ab43a3054db[ #"within_time" ] = ae_utility::function_2d1565a236387b2( #"hash_2ef4e4fc4ff69f2b", #"within_time" );
    level.var_290a71888a72cd4c.var_d63e7ab43a3054db = var_d63e7ab43a3054db;
    return level.var_290a71888a72cd4c.var_d63e7ab43a3054db;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xb4f1c906, Offset: 0x686d
// Size: 0x17c
function private function_2e63615423dcc2ad()
{
    if ( level.var_290a71888a72cd4c.var_c178224adcb219d9 && level.var_290a71888a72cd4c.var_c178224adcb219d9.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_c178224adcb219d9;
    }
    
    var_c178224adcb219d9 = [];
    var_c178224adcb219d9[ "REV_OB_CONTRACT_PRECIOUS_CARGO" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"precious_cargo" );
    var_c178224adcb219d9[ "REV_OB_SUPPLY_CHAIN" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"supply_chain" );
    var_c178224adcb219d9[ "REV_OB_CONTRACT_HVT" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"ob_hvt" );
    var_c178224adcb219d9[ "REV_OB_HEIST" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"heist" );
    var_c178224adcb219d9[ "REV_OB_MYSTERY_CARGO" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"mystery_cargo" );
    var_c178224adcb219d9[ "REV_OB_ESCORT_DAWG" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"escort_dawg" );
    var_c178224adcb219d9[ "REV_OB_BECOME_MONSTERS" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"become_monsters" );
    var_c178224adcb219d9[ "REV_OB_HEAVY_METAL_HEROES" ] = ae_utility::function_2d1565a236387b2( #"ob_contract_type", #"heavy_metal_heroes" );
    level.var_290a71888a72cd4c.var_c178224adcb219d9 = var_c178224adcb219d9;
    return level.var_290a71888a72cd4c.var_c178224adcb219d9;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xb41175d8, Offset: 0x69f2
// Size: 0xc4
function private function_616438edfae109d7()
{
    if ( level.var_290a71888a72cd4c.exfilarray && level.var_290a71888a72cd4c.exfilarray.size != 0 )
    {
        return level.var_290a71888a72cd4c.exfilarray;
    }
    
    exfilarray = [];
    exfilarray[ #"hash_a796402786903f6" ] = ae_utility::function_2d1565a236387b2( #"ob_exfil_bitfield", #"hash_a796402786903f6" );
    exfilarray[ #"never_fired" ] = ae_utility::function_2d1565a236387b2( #"ob_exfil_bitfield", #"never_fired" );
    level.var_290a71888a72cd4c.exfilarray = exfilarray;
    return level.var_290a71888a72cd4c.exfilarray;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x5b39bb85, Offset: 0x6abf
// Size: 0xa0
function private function_63c34a4d16ecc413()
{
    if ( level.var_290a71888a72cd4c.var_9a075c8087fd7d03 && level.var_290a71888a72cd4c.var_9a075c8087fd7d03.size != 0 )
    {
        return level.var_290a71888a72cd4c.var_9a075c8087fd7d03;
    }
    
    var_9a075c8087fd7d03 = [];
    var_9a075c8087fd7d03[ #"super_survival_life_drain" ] = ae_utility::function_2d1565a236387b2( #"revive_bitfield", #"super_survival_life_drain" );
    level.var_290a71888a72cd4c.var_9a075c8087fd7d03 = var_9a075c8087fd7d03;
    return level.var_290a71888a72cd4c.var_9a075c8087fd7d03;
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0xf1d3c714, Offset: 0x6b68
// Size: 0xba
function private function_42a9e29ec3417d76( revivee, reviver, revivebitfield = undefined )
{
    if ( !isdefined( revivebitfield ) )
    {
        revivebitfield = 0;
    }
    
    if ( !isplayer( revivee ) )
    {
        return revivebitfield;
    }
    
    revivesource = revivee.revivesource[ reviver getguid() ];
    
    if ( !revivesource )
    {
        return revivebitfield;
    }
    
    var_9a075c8087fd7d03 = function_63c34a4d16ecc413();
    
    if ( !var_9a075c8087fd7d03[ revivesource ] )
    {
        assertmsg( "<dev string:x6e6>" + getxhashsourcename( revivesource ) );
        revivee.revivesource = undefined;
        return revivebitfield;
    }
    
    revivebitfield = challenges::function_a23641f33e985edb( revivebitfield, var_9a075c8087fd7d03[ revivesource ] );
    revivee.revivesource = undefined;
    return revivebitfield;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x1698688c, Offset: 0x6c2b
// Size: 0x8b
function private function_55d0c38345d25928()
{
    aeeventname = #"ob_traversal";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"value", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_traversal_type_bitfield", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xbcc13367, Offset: 0x6cbf
// Size: 0xa8
function private function_5bc65db633e941a6( player )
{
    aeeventname = #"ob_interact";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"ob_interact_bitfield", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_b431edc04f47bd9e", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_map_location", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x6d85895, Offset: 0x6d70
// Size: 0xc4
function private function_a453309ac5623b15()
{
    aeeventname = #"end_activity";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"ob_map_location", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_activity_type", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_activity_complete_solo", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_2ef4e4fc4ff69f2b", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_operator_id", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x686ff8ac, Offset: 0x6e3d
// Size: 0x8b
function private function_4a03c07da0e71283()
{
    aeeventname = #"ob_armor";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"supers_bitfield", 0 );
    function_c3045e6818419e49( aeeventname, #"value", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xb79cacaf, Offset: 0x6ed1
// Size: 0x8b
function private function_47724ea0379fba88()
{
    aeeventname = #"contract_end";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"ob_map_location", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_contract_type", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xa2d72f37, Offset: 0x6f65
// Size: 0x195
function private function_940ee4036e1a98ea()
{
    aeeventname = #"ob_exfil";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"ob_map_location", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_power_tier", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_has_been_downed", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_has_been_killed", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_contracts_successfully_completed", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_clear_final_encounter", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_operator_id", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_1577bc2a7f187352", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_aade0f38626dad", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_6c04f96afb94160", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_51900cb85a335073", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_activities_successfully_completed", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_fbb85871da6cb482", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_f93d3172e19dedf7", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_f8f08737c36b2458", 0 );
    function_c3045e6818419e49( aeeventname, #"hash_fa689f710d9c2a05", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x30fc2fce, Offset: 0x7103
// Size: 0x78
function private function_ace61864e40cc0ec()
{
    aeeventname = #"ob_mission";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"wc_story_mission_bitfield", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x24d32e44, Offset: 0x7184
// Size: 0x9e
function private function_8a1cde632fe3e0d9()
{
    aeeventname = #"ob_acquire_skill";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    function_c3045e6818419e49( aeeventname, #"loot_id", 0 );
    function_c3045e6818419e49( aeeventname, #"ob_skills_category_bitfield", 0 );
    function_c3045e6818419e49( aeeventname, #"zm_rarity", 0 );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0xf95a7e74, Offset: 0x722b
// Size: 0x65
function private function_933380e0031e705a()
{
    aeeventname = #"damage_prevented";
    
    if ( level.var_b4f38e8dfdc18cd5[ aeeventname ] && level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_b4f38e8dfdc18cd5[ aeeventname ];
    }
    
    function_805506ade89aed4f( aeeventname );
    return level.var_b4f38e8dfdc18cd5[ aeeventname ];
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0x19ac24d5, Offset: 0x7299
// Size: 0xde
function private function_805506ade89aed4f( aeeventname )
{
    level.var_b4f38e8dfdc18cd5[ aeeventname ] = {};
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    level.var_b4f38e8dfdc18cd5[ aeeventname ].aeeventid = aeeventid;
    gamemode = challenges::getchallengegamemode();
    gametype = challenges::function_9edd00e9e48c0821();
    level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams = [];
    function_c3045e6818419e49( aeeventname, #"version", 1 );
    function_c3045e6818419e49( aeeventname, #"gamemode", gamemode );
    function_c3045e6818419e49( aeeventname, #"gametype", gametype );
    gametypebitfield = function_180dc844e4a0e4b5();
    function_c3045e6818419e49( aeeventname, #"hash_9ab9749553b78b2c", gametypebitfield );
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0xaf26d32e, Offset: 0x737f
// Size: 0x41
function private function_c3045e6818419e49( aeeventname, key, value )
{
    level.var_b4f38e8dfdc18cd5[ aeeventname ].eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, key ) ] = value;
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xcfad43ed, Offset: 0x73c8
// Size: 0x2a, Type: bool
function private function_81243837d413c1c4( agent )
{
    if ( !isagent( agent ) )
    {
        return false;
    }
    
    if ( agent.var_1416dd8624fff097 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_challenges
// Params 3, eflags: 0x4
// Checksum 0x57114f06, Offset: 0x73fb
// Size: 0x462
function private function_e7dd3022963df094( idflags, attacker, var_a6727b2eafe34cb3 = undefined )
{
    victimstruct = var_a6727b2eafe34cb3 ?? {};
    victimstruct.laststandattacker = self.laststandattacker;
    victimstruct.inlaststand = self.inlaststand;
    victimstruct.lastattacker = self.lastattacker;
    victimstruct.damagedplayers = self.damagedplayers;
    victimstruct.flame_blast_burning = self.flame_blast_burning;
    victimstruct.var_917038143d36327f = [];
    victimstruct.var_917038143d36327f[ "flashed" ] = self.var_917038143d36327f[ "flashed" ];
    victimstruct.var_917038143d36327f[ "stunned" ] = self.var_917038143d36327f[ "stunned" ];
    victimstruct.var_917038143d36327f[ "shocked" ] = self.var_917038143d36327f[ "shocked" ];
    victimstruct.debuffinfo = self.debuffinfo;
    victimstruct.disguised = self.disguised;
    victimstruct.lastvehicle = self.lastvehicle;
    victimstruct.vehicle = vehicle::get_vehicle();
    victimstruct.onascender = self isonascender();
    victimstruct.onzipline = self isonzipline();
    victimstruct.var_bb4a9fa6d1698027 = events::function_853f2fa3d548d7ec( self ) || function_81243837d413c1c4( self );
    victimstruct.attackerposition = self.attackerposition;
    victimstruct.is_fall_explosions_damage = self.is_fall_explosions_damage;
    victimstruct.iswallrunning = self iswallrunning();
    victimstruct.isjumping = self isjumping();
    victimstruct.var_8e388104c7c4d011 = self.var_8e388104c7c4d011;
    victimstruct.issprinting = self issprinting();
    var_de58c87a0dc0b43c = self.var_2d5b79b93c51aa8f;
    
    if ( !var_de58c87a0dc0b43c )
    {
        var_de58c87a0dc0b43c = !( idflags & 524288 ) && idflags & 8 && !( idflags & 16384 );
    }
    
    victimstruct.var_de58c87a0dc0b43c = var_de58c87a0dc0b43c;
    victimstruct.is_shocking_reload_damage = self.is_shocking_reload_damage;
    victimstruct.kiastring = self.kiastring;
    victimstruct.var_8958572f8db5a345 = self.var_8958572f8db5a345;
    victimstruct.streakinfo = self.streakinfo;
    victimstruct.vehicleref = vehicle::get_ref();
    
    if ( victimstruct.vehicleref )
    {
        victimstruct.var_41866f02e46fb475 = vehicle::can_fly() ?? 0;
        victimstruct.var_749669a6a8dda7d0 = vehicle::is_boat() ?? 0;
        victimstruct.riders = self.riders ?? 0;
        victimstruct.var_b7aa763057412de8 = vehicle::function_1fe58ae318378aa8() ?? 0;
        victimstruct.var_fd4d41ef858858b2 = vehicle::is_enemy_to_player( self, attacker ) ?? 0;
    }
    
    victimstruct.equipmentref = self.equipmentref;
    victimstruct.isagent = isagent( self ) ?? 0;
    victimstruct.agent_type = self.agent_type;
    victimstruct.elite = self.elite;
    victimstruct.tier = self.tier ?? ai_utility::get_power_tier();
    victimstruct.category = self.category;
    victimstruct.subcategory = self.subcategory;
    victimstruct.sentrytype = self.sentrytype;
    
    if ( self.directorrequestid )
    {
        activityinstance = activity_ai_encounters::function_a6fb1c80ed15c11b( self.directorrequestid );
        
        if ( activityinstance )
        {
            victimstruct.var_495132567a05ca8a = activityinstance.type;
            victimstruct.var_96d37c32bd7cc62 = activityinstance.category;
        }
    }
    
    victimstruct.activityboss = self.activityboss;
    return victimstruct;
}

// Namespace ob_challenges
// Params 2, eflags: 0x4
// Checksum 0xa8db7b00, Offset: 0x7866
// Size: 0x104
function private function_b4096ceeab158a58( victimstruct, meansofdeath )
{
    if ( victimstruct.var_de58c87a0dc0b43c )
    {
        self.var_2d5b79b93c51aa8f = undefined;
        self.modifiers[ "wall_bang_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"wall_bang_kill" ) );
    }
    
    if ( !isdefined( victimstruct.damagedplayers[ self.guid ] ) )
    {
        events::cleankill();
    }
    
    if ( victimstruct.last_dmg_struct.biscritical )
    {
        self.modifiers[ "headshot" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"headshot" ) );
    }
}

// Namespace ob_challenges
// Params 4, eflags: 0x4
// Checksum 0x43bb4af1, Offset: 0x7972
// Size: 0x623
function private function_415db442969048e3( victim, inflictor, objweapon, meansofdeath )
{
    curtime = gettime();
    
    if ( victim.onascender || victim.onzipline )
    {
        self.modifiers[ "victim_on_zipline" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_on_zipline" ) );
    }
    
    if ( victim.var_8e388104c7c4d011 )
    {
        self.modifiers[ "sky_kill" ] = 1;
        victim.var_8e388104c7c4d011 = undefined;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_airborne" ) );
    }
    
    if ( self isonzipline() || self isonascender() )
    {
        self.modifiers[ "ascender_kill" ] = 1;
    }
    
    if ( events::function_8e315fc2393f2705() )
    {
        self.modifiers[ #"in_dtp" ] = 1;
        self.modifiers[ "dtp_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"dtp_kill" ) );
        
        if ( self.var_d9dbc6867528ff82 )
        {
            self.modifiers[ "non_forward_dtp_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_daecc6093d5a357e" ) );
        }
    }
    
    if ( victim.issprinting )
    {
        self.modifiers[ "victim_sprinting" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victimsprinting" ) );
    }
    
    if ( victim.var_bb4a9fa6d1698027 )
    {
        self.modifiers[ "victim_airborne" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_airborne" ) );
    }
    
    if ( self issprinting() )
    {
        self.modifiers[ "while_sprinting_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_sprinting_kill" ) );
    }
    
    if ( self.var_5799a77f18d0229a || isdefined( self.var_9e094dd56f970a03 ) && curtime - self.var_9e094dd56f970a03 <= 2500 )
    {
        self.modifiers[ "while_wall_jump_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_wall_jump_kill" ) );
    }
    
    if ( self.usingremote )
    {
        self.modifiers[ "remote_piloting_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"remote_piloting_kill" ) );
    }
    
    attackerisinflictor = events::attackerisinflictor( self, inflictor, objweapon, meansofdeath );
    
    if ( victim.var_bb4a9fa6d1698027 && events::function_853f2fa3d548d7ec( self ) )
    {
        if ( attackerisinflictor )
        {
            self.modifiers[ "air_to_air_kill" ] = 1;
        }
        
        return;
    }
    
    attackerposition = victim.attackerposition ?? self.origin;
    attackervelocity = self getvelocity();
    var_13ceed07351526e8 = vectornormalize( attackervelocity );
    var_2bf59c61b6d17e33 = anglestoforward( self getplayerangles() );
    var_f4061506239fc0bd = vectordot( var_2bf59c61b6d17e33, var_13ceed07351526e8 );
    var_7c42446588b35c76 = length2dsquared( attackervelocity );
    
    if ( attackerisinflictor )
    {
        if ( self iswallrunning() )
        {
            self.modifiers[ "wallkill" ] = 1;
        }
        else if ( events::events_issliding() )
        {
            if ( var_f4061506239fc0bd < 0.7071 && var_7c42446588b35c76 > 50 )
            {
                self.modifiers[ "non_forward_slide_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"non_forward_slide_kill" ) );
            }
        }
        else if ( self function_41360f0bcfc012aa() || isdefined( self.var_a0a222315f11cfef ) && curtime - self.var_a0a222315f11cfef <= 2000 )
        {
            self.modifiers[ "while_grappling_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_grappling_kill" ) );
        }
        
        if ( victim.is_fall_explosions_damage )
        {
            self.modifiers[ "fall_explosions_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"fall_explosions_kill" ) );
        }
    }
    
    if ( victim.iswallrunning )
    {
        self.modifiers[ "killonwall" ] = 1;
    }
}

// Namespace ob_challenges
// Params 6, eflags: 0x4
// Checksum 0xc48b218, Offset: 0x7f9d
// Size: 0x2fb
function private function_e430004e0798aff2( victim, inflictor, objweapon, meansofdeath, deathdata, weapongroup )
{
    attackerisinflictor = events::attackerisinflictor( self, inflictor, objweapon, meansofdeath );
    
    if ( !attackerisinflictor )
    {
        return;
    }
    
    if ( victim.ishaywire || victim.var_917038143d36327f[ "shocked" ] )
    {
        self.modifiers[ "victim_haywire" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_haywire" ) );
    }
    
    if ( isdefined( deathdata.damageflags ) && deathdata.damageflags & 8 && !( deathdata.damageflags & 16384 ) )
    {
        self.modifiers[ "coverkill" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"cover_kill" ) );
    }
    
    if ( self.attackerdata[ victim.guid ].var_1064e75bd343dd83[ victim.guid ] )
    {
        self.modifiers[ "victim_shot_attacker_first_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_shot_attacker_first_kill" ) );
    }
    
    var_bda53394c108f2e = isweapon( objweapon ) ? getcompleteweaponname( objweapon ) : "";
    
    if ( self.tookweaponfrom[ var_bda53394c108f2e ].var_3a1cc6241650f669.guid == victim.guid )
    {
        self.modifiers[ "backfire" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"backfire" ) );
    }
    
    if ( self.pers[ "killstreak_from_supply_drop" ] && ( "killstreak" == weapongroup || weapon::iskillstreakweapon( objweapon ) || objweapon.basenamehash == %"sat_dawg_turret" ) )
    {
        self.modifiers[ "care_package_streak_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"care_package_streak_kill" ) );
    }
}

// Namespace ob_challenges
// Params 4, eflags: 0x4
// Checksum 0x88f1e41d, Offset: 0x82a0
// Size: 0x104
function private function_cb49457a6793ff21( victim, inflictor, objweapon, meansofdeath )
{
    attackerisinflictor = events::attackerisinflictor( self, inflictor, objweapon, meansofdeath );
    
    if ( attackerisinflictor && victim.is_shocking_reload_damage )
    {
        self.modifiers[ "shocking_reload_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"shocking_reload_kill" ) );
    }
    
    if ( attackerisinflictor && inflictor.var_ef7442bad4acaf0e )
    {
        self.modifiers[ "technomancer_drone_kill" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"technomancer_drone_kill" ) );
    }
}

// Namespace ob_challenges
// Params 4, eflags: 0x4
// Checksum 0xdfe5411b, Offset: 0x83ac
// Size: 0x1d0
function private function_65bd7657a9865d80( victim, inflictor, meansofdeath, objweapon )
{
    victimvehicle = victim.vehicle;
    victimvehicle = victimvehicle ?? victim.lastvehicle;
    
    if ( victimvehicle )
    {
        self.modifiers[ "victim_in_vehicle" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victiminvehicle" ) );
        
        if ( victimvehicle vehicle::ishelicopter() )
        {
            self.modifiers[ "victim_in_heli" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_in_heli" ) );
        }
        
        if ( isarray( victimvehicle.riders ) && victimvehicle.riders.size == 0 )
        {
            self.modifiers[ "victim_final_rider" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_final_rider" ) );
        }
    }
    
    vehicle = vehicle::get_vehicle();
    
    if ( !vehicle )
    {
        return;
    }
    
    if ( vehicle vehicle::ishelicopter() )
    {
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"from_helicopter" ) );
    }
}

// Namespace ob_challenges
// Params 1, eflags: 0x4
// Checksum 0xdde4cb67, Offset: 0x8584
// Size: 0x39
function private function_3899b7b9609e5689( var_d83451c1bf446403 )
{
    if ( function_32f1a309d6904b9c() )
    {
        var_d83451c1bf446403 = challenges::function_a23641f33e985edb( var_d83451c1bf446403, ae_utility::function_2d1565a236387b2( #"enemy_type_bitfield", #"killstreak" ) );
    }
    
    return var_d83451c1bf446403;
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x19438b9a, Offset: 0x85c6
// Size: 0x7f, Type: bool
function private function_32f1a309d6904b9c()
{
    if ( vehicle::is_vehicle() )
    {
        vehicleref = vehicle::get_ref();
        
        if ( vehicleref == "ob_guild_drone" )
        {
            return true;
        }
        
        vehiclebundle = vehicle::get_data( vehicleref );
        
        if ( vehiclebundle && issubstr( vehiclebundle.ref, "veh_sat_mil_vtol_ob_" ) )
        {
            return true;
        }
    }
    
    return self.sentrytype == "ai_sentry_turret" || self.subclass == "ob_helper_drone";
}

// Namespace ob_challenges
// Params 0, eflags: 0x4
// Checksum 0x429a29b8, Offset: 0x864e
// Size: 0xc, Type: bool
function private function_b47e3dd8f88a88c2()
{
    return isdefined( self.equipmentref );
}

