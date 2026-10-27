// scripts\mp\br\gametypes\br_gametype_resurgence_loaded.gsc  (hash_5520ca4f94232fb2.gscc) (size: 8362 Bytes / 0x20aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8b162cb (3098632907)
// size ...... 8362 (0x20aa)
// includes .. 14  (offset: 0x1efe)
// strings ... 22  (offset: 0x1f6e)
// dev strs .. 3   (offset: 0x2086)
// exports ... 28  (offset: 0x12fe)
// cseg ...... 0x290 + 0x106e (0x12fe)
// imports ... 65  (offset: 0x175e)
// animtree1 . 0   (offset: 0x20aa)
// animtree2 . 0   (offset: 0x20aa)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\common\perks\wz\specialist_wz;
#using scripts\mp\common\perks\wz_perks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\parachute;

#namespace br_gametype_resurgence_loaded;

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x695a47ff, Offset: 0x2ae
// Size: 0x17
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x4b40ea55, Offset: 0x2cd
// Size: 0x19
function init()
{
    level br_gametype_resurgence::init();
    level thread init_callbacks();
    thread init_post_main();
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x535b8e5f, Offset: 0x2ee
// Size: 0x100
function init_callbacks()
{
    level callback::add( #"player_connect", &on_player_connect );
    flags::function_2f3408423ccc9b2e( "br_ready_to_jump" );
    level callback::add( #"loadout_given", &on_loadout_given );
    level callback::add( #"player_death", &on_player_death );
    
    if ( level.brgametype.var_2b9758b920ef9e26 )
    {
        level callback::add( #"hash_eb54ccc016130a88", &function_c01acc025ced4447 );
        level callback::add( #"elimination_assist", &function_c01acc025ced4447 );
    }
    
    if ( level.brgametype.loadoutrestore )
    {
        level.parachutecompletecb = &parachute_complete_resurgence_loaded;
        level.parachuterestoreweaponscb = &function_66d80248c16cbfc2;
        utility::registersharedfunc( #"gametype", #"hash_e0509a91e608241", &function_4d133214cf1996f5 );
    }
    
    utility::registersharedfunc( #"telemetry", #"hash_c2ff97bbe61f0a3f", &function_db2e4f5a5ec5fa51 );
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x2182aaf0, Offset: 0x3f6
// Size: 0x74
function init_post_main()
{
    level endon( #"game_ended" );
    level waittill( #"hash_378db2177ffe407a" );
    init_loaded_dialog();
    init_specialist_quest();
    utility::flag_wait( "common_items_init" );
    utility::registersharedfunc( #"perk", #"dropperks", &function_5b77e2df86bae7c7 );
    
    /#
        utility::registersharedfunc( #"loaded", #"hash_92c69cebc395b9e7", &run_command );
    #/
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x3d0a9d56, Offset: 0x472
// Size: 0x60
function init_loaded_dialog()
{
    audio_utility::snd_transient_load( "mp_gametype_resurgence_loaded" );
    level.brgametype.dialogprefix = "dx_br_brdm_";
    game[ "dialog" ][ "match_start" ] = "ldre_wzan_gmty";
    game[ "dialog" ][ "primary_objective_solo" ] = "ldre_wzan_gmds";
    game[ "dialog" ][ "primary_objective" ] = "ldre_wzan_gmds";
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x3709c7d6, Offset: 0x4da
// Size: 0x2f5
function init_specialist_quest()
{
    level.brgametype.settingsbundle = game_utility_mp::function_4b7180ed8c2e9742( #"gametypebundle_resurgence_loaded" );
    settingsbundle = level.brgametype.settingsbundle;
    level.brgametype.var_403fa52c46fb8e30 = utility::function_edc4cc03e9e60b3e( @"hash_f3ebf8dc53417f0d", 1, settingsbundle.specialistquest );
    
    if ( !level.brgametype.var_403fa52c46fb8e30 )
    {
        return;
    }
    
    level.brgametype.var_9b73a18aa43bd598 = utility::function_edc4cc03e9e60b3e( @"hash_c86d28c8307edba0", 5, settingsbundle.var_11555365ad4d1e45 );
    level.brgametype.var_ce098e89b6ac7591 = utility::function_edc4cc03e9e60b3e( @"hash_e38f60dee284ade7", 0, settingsbundle.var_e442e22cb6e18e68 );
    level.brgametype.var_360de2e5cc1f7e8b = utility::function_edc4cc03e9e60b3e( @"hash_d1b72153fbee9070", 0, settingsbundle.var_72ab60cab6ba2bb2 );
    level.brgametype.removeperkondeath = utility::function_edc4cc03e9e60b3e( @"hash_9f2645e0d7d2f1db", 1, settingsbundle.var_9be9df7a0ad733bc );
    level.brgametype.var_2b3568093368cdfb = utility::function_edc4cc03e9e60b3e( @"hash_7782a249fa82a9a0", 1, settingsbundle.var_c4285f0ba4b1de7d );
    level.brgametype.var_2b9758b920ef9e26 = utility::function_edc4cc03e9e60b3e( @"hash_d4b8d128a548f8cd", 1, settingsbundle.var_2b9758b920ef9e26 );
    level.brgametype.loadoutrestore = utility::function_edc4cc03e9e60b3e( @"hash_924c0684815f2648", 1, settingsbundle.var_fc7d8f99fe681164 );
    var_9d7c211bc7637698 = utility::function_49a778e73bbb0f58( @"hash_d24224c59133e90d", "", settingsbundle.var_9d7c211bc7637698 );
    level.brgametype.var_9d7c211bc7637698 = [];
    
    if ( isarray( var_9d7c211bc7637698 ) )
    {
        foreach ( perk in var_9d7c211bc7637698 )
        {
            level.brgametype.var_9d7c211bc7637698[ level.brgametype.var_9d7c211bc7637698.size ] = perk.ref;
        }
    }
    else if ( isstring( var_9d7c211bc7637698 ) )
    {
        level.brgametype.var_9d7c211bc7637698 = strtok( var_9d7c211bc7637698, "," );
    }
    
    init_perk_data();
    function_7cc635af40e88b79();
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x31d93d29, Offset: 0x7d7
// Size: 0x68
function init_perk_data()
{
    specialistbundle = level.perkbundles[ level.var_d846c03ec30479ec ];
    perklist = specialist_wz::getspecialistperks( specialistbundle );
    perklist = arrayremove( perklist, level.brgametype.var_9d7c211bc7637698 );
    level.brgametype.perklist = arrayrandomize( perklist );
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0xc0af18fe, Offset: 0x847
// Size: 0x66
function function_7cc635af40e88b79()
{
    poolcount = level.brgametype.var_9b73a18aa43bd598 + 3;
    assert( poolcount <= 15, "<dev string:x24>" );
    level.brgametype.perkpool = utility::array_slice( level.brgametype.perklist, 0, poolcount );
}

// Namespace br_gametype_resurgence_loaded
// Params 2
// Checksum 0x3ec00b38, Offset: 0x8b5
// Size: 0xd5
function function_30c41469cc7f496f( player, loadoutperks )
{
    questperks = [];
    
    for ( index = 0; index < level.brgametype.perkpool.size ; index++ )
    {
        var_e8624192c63bd52 = questperks.size < level.brgametype.var_9b73a18aa43bd598 - 1 ? level.brgametype.perkpool[ index ] : level.var_d846c03ec30479ec;
        
        if ( questperks.size >= level.brgametype.var_9b73a18aa43bd598 )
        {
            break;
        }
        
        if ( arraycontains( loadoutperks, var_e8624192c63bd52 ) )
        {
            continue;
        }
        
        questperks[ questperks.size ] = var_e8624192c63bd52;
    }
    
    player.var_9ac7e92c8fc49e31 = questperks;
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x33bf73a9, Offset: 0x992
// Size: 0x321
function function_274bc4108caee104( player )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( player.var_9ac7e92c8fc49e31.size == 0 )
    {
        loadoutperks = function_a85007d0f11b2a33( player );
        player.var_de38ab3a1731ddfa = loadoutperks;
        function_30c41469cc7f496f( player, loadoutperks );
    }
    
    if ( isplayer( player ) && player::isreallyalive( player ) && player.var_5ce06821cf5d5459 < level.brgametype.var_9b73a18aa43bd598 )
    {
        var_49bcbabb372980c3 = player.var_9ac7e92c8fc49e31[ player.var_5ce06821cf5d5459 ] == level.var_d846c03ec30479ec;
        
        if ( var_49bcbabb372980c3 )
        {
            foreach ( perk in player.var_da3d5e60fff4deb0 )
            {
                if ( isdefined( player.perks[ perk ] ) )
                {
                    player perk::removeperk( perk );
                }
            }
        }
        
        if ( !isdefined( player.var_9ac7e92c8fc49e31[ player.var_5ce06821cf5d5459 ] ) )
        {
            perkprint = "";
            logstring( "[LOADED GAMEMODE] Undefined perk name using quest perk index. Specialist Quest Perk Index : " + player.var_5ce06821cf5d5459 );
            logstring( "[LOADED GAMEMODE] Elimination Count for Specialist : " + level.brgametype.var_9b73a18aa43bd598 );
            
            foreach ( perkname in player.var_9ac7e92c8fc49e31 )
            {
                perkprint += perkname + " ";
            }
            
            logstring( "[LOADED GAMEMODE] Perk List in pool : " + perkprint );
        }
        
        player perk::giveperk( player.var_9ac7e92c8fc49e31[ player.var_5ce06821cf5d5459 ] );
        player thread points::doscoreevent( #"hash_66e08a2c099227ff" );
        var_362d72c356b64e2c = var_49bcbabb372980c3 ? #"hash_b2303a59d6056f56" : #"hash_e1d344dd9cbf9d85";
        player playlocalsound( var_362d72c356b64e2c );
        
        if ( !isdefined( player.var_da3d5e60fff4deb0 ) )
        {
            player.var_da3d5e60fff4deb0 = [];
        }
        
        player.var_da3d5e60fff4deb0[ player.var_da3d5e60fff4deb0.size ] = player.var_9ac7e92c8fc49e31[ player.var_5ce06821cf5d5459 ];
        function_c1b8f4d072ad74d4( player );
        player.var_5ce06821cf5d5459++;
        
        if ( player.var_5ce06821cf5d5459 > player.var_526c3f4b93e0afe8 )
        {
            player.var_526c3f4b93e0afe8 = player.var_5ce06821cf5d5459;
        }
    }
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x7dbda589, Offset: 0xcbb
// Size: 0xa9
function function_d78d8212de58811f( player )
{
    if ( player wz_perks::hasspecialist() )
    {
        player wz_perks::removespecialist();
    }
    
    foreach ( perk in player.var_da3d5e60fff4deb0 )
    {
        player perk::removeperk( perk );
    }
    
    player.var_da3d5e60fff4deb0 = [];
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x8a7414c0, Offset: 0xd6c
// Size: 0xd4
function function_47046302739c58c7( player )
{
    function_d78d8212de58811f( player );
    
    if ( function_369dd21b80a56972( player ) && !player wz_perks::hasspecialist() )
    {
        player perk::giveperk( level.var_d846c03ec30479ec );
    }
    else if ( !function_369dd21b80a56972( player ) )
    {
        for ( index = 0; index < player.var_5ce06821cf5d5459 ; index++ )
        {
            player perk::giveperk( player.var_9ac7e92c8fc49e31[ index ] );
            
            if ( !isdefined( player.var_da3d5e60fff4deb0 ) )
            {
                player.var_da3d5e60fff4deb0 = [];
            }
            
            player.var_da3d5e60fff4deb0[ player.var_da3d5e60fff4deb0.size ] = player.var_9ac7e92c8fc49e31[ index ];
        }
    }
    
    function_c1b8f4d072ad74d4( player );
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0xac5eb544, Offset: 0xe48
// Size: 0x35
function player_remove_perk( player )
{
    if ( player.var_5ce06821cf5d5459 > 0 && !function_369dd21b80a56972( player ) )
    {
        player.var_5ce06821cf5d5459--;
    }
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x9745f759, Offset: 0xe85
// Size: 0x2c
function function_c1b8f4d072ad74d4( player )
{
    player.lootperks = player.var_da3d5e60fff4deb0;
    player wz_perks::function_173a7a25c20d9891();
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x7f93bf99, Offset: 0xeb9
// Size: 0x5a
function on_player_connect( params )
{
    player = self;
    player.var_5ce06821cf5d5459 = 0;
    player.var_da3d5e60fff4deb0 = [];
    player.var_9ac7e92c8fc49e31 = [];
    player.var_de38ab3a1731ddfa = [];
    player.var_526c3f4b93e0afe8 = 0;
}

// Namespace br_gametype_resurgence_loaded
// Params 3
// Checksum 0x5593c76, Offset: 0xf1b
// Size: 0x89
function on_player_death( deathdata, victim = deathdata.victim, attacker = deathdata.attacker )
{
    if ( attacker != victim && !level.brgametype.var_2b9758b920ef9e26 )
    {
        function_274bc4108caee104( attacker );
    }
    
    if ( level.brgametype.removeperkondeath )
    {
        player_remove_perk( victim );
    }
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x83dcacc4, Offset: 0xfac
// Size: 0x19
function function_c01acc025ced4447( params )
{
    if ( isdefined( self ) )
    {
        function_274bc4108caee104( self );
    }
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x431da5ac, Offset: 0xfcd
// Size: 0xbf
function on_loadout_given( params )
{
    player = self;
    loadoutperks = function_a85007d0f11b2a33( player );
    
    if ( loadoutperks.size <= 0 )
    {
        logstring( "[LOADED GAMEMODE] Player has no loadout perks set:" + player.name );
    }
    
    if ( function_94045952d433bb26( player, loadoutperks ) )
    {
        player.var_5ce06821cf5d5459 = 0;
    }
    
    if ( player.var_de38ab3a1731ddfa.size == 0 || !arraycompare( player.var_de38ab3a1731ddfa, loadoutperks ) )
    {
        function_30c41469cc7f496f( player, loadoutperks );
        player.var_de38ab3a1731ddfa = loadoutperks;
    }
    
    function_47046302739c58c7( player );
    player.var_bbf688d90abc1e52 = self.class;
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0xe5fbe5db, Offset: 0x1094
// Size: 0x14
function parachute_complete_resurgence_loaded()
{
    parachute::parachutecompletedefault();
    self.var_cfc7100274835531 = 1;
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x4cf95396, Offset: 0x10b0
// Size: 0x1f
function function_66d80248c16cbfc2()
{
    if ( self.var_cfc7100274835531 )
    {
        br::nakeddrop();
        return;
    }
    
    br::loadoutdrop();
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0x53150475, Offset: 0x10d7
// Size: 0xc
function function_4d133214cf1996f5()
{
    self.var_cfc7100274835531 = undefined;
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x542bfb9f, Offset: 0x10eb
// Size: 0xc
function function_5b77e2df86bae7c7( spawnoptions )
{
    
}

// Namespace br_gametype_resurgence_loaded
// Params 2
// Checksum 0x63ece151, Offset: 0x1100
// Size: 0x9a
function function_94045952d433bb26( player, loadoutperks )
{
    shouldreset = 0;
    
    if ( function_369dd21b80a56972( player ) )
    {
        return 0;
    }
    
    if ( level.brgametype.var_360de2e5cc1f7e8b )
    {
        return 1;
    }
    
    if ( level.brgametype.var_ce098e89b6ac7591 )
    {
        if ( player.var_bbf688d90abc1e52 != player.class )
        {
            shouldreset = 1;
        }
        else if ( !arraycompare( player.var_de38ab3a1731ddfa, loadoutperks ) )
        {
            shouldreset = 1;
        }
    }
    
    return shouldreset;
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0xd6844e9a, Offset: 0x11a3
// Size: 0x1d
function function_a85007d0f11b2a33( player )
{
    return player.pers[ "loadoutPerks" ];
}

// Namespace br_gametype_resurgence_loaded
// Params 1
// Checksum 0x17a6342a, Offset: 0x11c9
// Size: 0x42, Type: bool
function function_369dd21b80a56972( player )
{
    return player.var_5ce06821cf5d5459 == level.brgametype.var_9b73a18aa43bd598 && level.brgametype.var_2b3568093368cdfb;
}

// Namespace br_gametype_resurgence_loaded
// Params 0
// Checksum 0xac4faef7, Offset: 0x1214
// Size: 0x60
function function_db2e4f5a5ec5fa51()
{
    player = self;
    player dlog_recordplayerevent( "dlog_event_br_res_loaded_match_end_supp", [ "has_specialist", player wz_perks::hasspecialist(), "perks_unlocked", player.var_526c3f4b93e0afe8 ?? 0, "game_type", game_utility::function_e9de4eeab29754c3() ] );
}

/#

    // Namespace br_gametype_resurgence_loaded
    // Params 1
    // Checksum 0x894797c, Offset: 0x127d
    // Size: 0x81, Type: dev
    function run_command( args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        command = args[ 0 ];
        player = level.player;
        
        if ( command == "<dev string:xaa>" )
        {
            function_274bc4108caee104( player );
            return;
        }
        
        if ( command == "<dev string:xb4>" )
        {
            if ( player.var_5ce06821cf5d5459 > 0 )
            {
                player.var_5ce06821cf5d5459--;
                function_47046302739c58c7( player );
            }
        }
    }

#/
