// scripts\mp\zm\ztron\ztron_save.gsc  (hash_1847cd33f2e06647.gscc) (size: 30922 Bytes / 0x78ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x54a1b1ff (1419883007)
// size ...... 30922 (0x78ca)
// includes .. 25  (offset: 0x6b82)
// strings ... 122 (offset: 0x6c4a)
// dev strs .. 7   (offset: 0x7876)
// exports ... 30  (offset: 0x536a)
// cseg ...... 0xa32 + 0x4938 (0x536a)
// imports ... 139 (offset: 0x581a)
// animtree1 . 0   (offset: 0x78ca)
// animtree2 . 0   (offset: 0x78ca)
#using script_31ee2a173f3499b7;
#using script_3401cf8ba2ee045;
#using script_4ce55cfc81c444ad;
#using script_5441a11286579ddc;
#using script_54a05cbb2455bc6f;
#using script_75994df35243cb2a;
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\stats;
#using scripts\mp\hud_message;
#using scripts\mp\supers;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_telemetry;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace ztron_save;

// Namespace ztron_save
// Params 0
// Checksum 0x665fa9f2, Offset: 0xa50
// Size: 0x158
function init()
{
    if ( level.ztron.cabinetmode )
    {
        return;
    }
    
    level.ztron.saveservice = spawnstruct();
    level.ztron.saveservice.version = getdvarint( @"current_season", 1 );
    level.ztron.saveservice.sessionsave = [];
    level.ztron.var_d1ba5603edba9e9f = getdvarint( @"hash_6a7f8c09d1c4c848", 0 ) > 0;
    level thread function_6a6982e376ce9a84();
    level thread function_cf0124117aa04ea3();
    level thread function_5c7749e52ce78569();
    level thread function_9f1fd5af96f0f186();
    level.ztron.var_e0684383d714e65b = &function_970f8cd0a0744c21;
    level callback::add( #"player_connect", &function_f303375f2775b114 );
    level callback::add( #"player_disconnect", &function_6bcaf49516491aa8 );
    level callback::add( #"player_spawned", &function_e909125e4502a22c );
    utility::flag_init( "ztron_restore_finished" );
    level ui::lui_registercallback( "save_and_end_game", &menu_save_and_end_game );
    utility::registersharedfunc( #"zombie", #"hash_e1eecff22a023276", &function_fcccc3d2a616b1c7 );
}

// Namespace ztron_save
// Params 0, eflags: 0x4
// Checksum 0xeecae99, Offset: 0xbb0
// Size: 0x12b
function private function_9f1fd5af96f0f186()
{
    level endon( #"ztron_game_is_over" );
    
    if ( !function_556fca66ceb3bb53() )
    {
        return;
    }
    
    level waittill( #"hash_ed5d7ed8f6aecadb" );
    
    if ( level.var_838b34ec9c6565aa )
    {
        return;
    }
    
    if ( level utility::flag_exist( "ztron_game_is_over" ) || level.gameended )
    {
        return;
    }
    
    if ( !function_dd4205207008db19() )
    {
        return;
    }
    
    function_fb94d517aa254043( 1, 1 );
    level.ztron.var_9b56dda5ea34b207 = 1;
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"hash_be8c1e50ae7da3ff", 1 );
    }
    
    assert( game[ "<dev string:x24>" ][ "<dev string:x2f>" ] == 77 );
    level thread ztron_main::function_940659c4c664d91b( game[ "end_reason" ][ "save_and_end_game" ] );
}

// Namespace ztron_save
// Params 0, eflags: 0x4
// Checksum 0x476a9523, Offset: 0xce3
// Size: 0xf0, Type: bool
function private function_dd4205207008db19()
{
    assert( isdefined( level.players ) );
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate != "playing" )
        {
            return false;
        }
        
        if ( !isalive( player ) || player::isinlaststand( player ) )
        {
            return false;
        }
        
        if ( player.health < player.maxhealth )
        {
            return false;
        }
    }
    
    if ( isdefined( level.s_exfil_active ) )
    {
        return false;
    }
    
    if ( getomnvar( "ui_was_savegame_loaded_this_round" ) == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_save
// Params 0, eflags: 0x4
// Checksum 0x3326f29d, Offset: 0xddc
// Size: 0xc3
function private function_5c7749e52ce78569()
{
    level endon( #"hash_e4b7a00ad502de4d" );
    level waittill( #"ztron_game_is_over" );
    
    if ( !function_fcccc3d2a616b1c7() )
    {
        return;
    }
    
    if ( !zmsaveinvalidate() )
    {
        ztron_debug::debugmsg( "Ztron ManualSave Invalidate Failed" );
        return;
    }
    
    ztron_debug::debugmsg( "Ztron ManualSave Invalidate Success" );
    
    foreach ( player in level.players )
    {
        player thread set_autosave_stat( 0 );
    }
}

// Namespace ztron_save
// Params 1
// Checksum 0x68637941, Offset: 0xea7
// Size: 0x14
function function_f303375f2775b114( params )
{
    thread set_autosave_stat( 0 );
}

// Namespace ztron_save
// Params 1
// Checksum 0x1cd5f497, Offset: 0xec3
// Size: 0x25
function function_e909125e4502a22c( params )
{
    waitframe();
    params = spawnstruct();
    callback::callback( #"hash_79b197636e7199f", params );
}

// Namespace ztron_save
// Params 1
// Checksum 0xf70d0c74, Offset: 0xef0
// Size: 0x8f
function function_6bcaf49516491aa8( params )
{
    if ( !function_556fca66ceb3bb53() )
    {
        return;
    }
    
    if ( level utility::flag_exist( "ztron_game_is_over" ) || level.gameended )
    {
        return;
    }
    
    if ( level.ztron.disconnect_save )
    {
        return;
    }
    
    if ( level.players.size == 0 )
    {
        level.ztron.disconnect_save = 1;
        level.ztron.var_9b56dda5ea34b207 = 1;
        function_fb94d517aa254043( 1 );
    }
}

// Namespace ztron_save
// Params 1
// Checksum 0x15a5f4b7, Offset: 0xf87
// Size: 0x15c
function menu_save_and_end_game( val )
{
    if ( !function_556fca66ceb3bb53() )
    {
        return;
    }
    
    if ( level.var_838b34ec9c6565aa )
    {
        return;
    }
    
    if ( level utility::flag_exist( "ztron_game_is_over" ) || level.gameended )
    {
        return;
    }
    
    if ( !function_d84e1589696a8b99( 0 ) )
    {
        foreach ( player in level.players )
        {
            player openmenu( "ZMSaveFailed" );
            player hud_message::showerrormessage( %"SAVE_LOAD/SAVE_FAILED" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player setclientdvar( @"hash_be8c1e50ae7da3ff", 0 );
    }
    
    level thread ztron_main::function_940659c4c664d91b( val );
}

// Namespace ztron_save
// Params 0, eflags: 0x4
// Checksum 0x4a24089c, Offset: 0x10eb
// Size: 0xe8
function private function_cf0124117aa04ea3()
{
    level waittill( #"ztron_game_is_over" );
    
    if ( !function_556fca66ceb3bb53() )
    {
        return;
    }
    
    if ( !level.ztron.var_f5f3283763443139 )
    {
        return;
    }
    
    if ( level.ztron.var_9b56dda5ea34b207 )
    {
        return;
    }
    
    if ( !zmsaveinvalidate( 1 ) )
    {
        ztron_debug::debugmsg( "Ztron Autosave Invalidate Failed" );
        return;
    }
    
    ztron_debug::debugmsg( "Ztron Autosave Invalidate Success" );
    
    foreach ( player in level.players )
    {
        player thread set_autosave_stat( 0 );
    }
}

// Namespace ztron_save
// Params 0
// Checksum 0xdc024f86, Offset: 0x11db
// Size: 0x8a, Type: bool
function function_556fca66ceb3bb53()
{
    if ( level.ztron.blitzmode )
    {
        return false;
    }
    
    if ( !level.ztron.var_d1ba5603edba9e9f )
    {
        return false;
    }
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_3bcb298d5c2940 )
    {
        if ( isdedicatedserver() )
        {
            var_ee7e4762f16f61fd = getdvarint( @"party_maxplayers", 0 );
            
            if ( var_ee7e4762f16f61fd == 1 )
            {
                return true;
            }
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_save
// Params 0
// Checksum 0xf1d18850, Offset: 0x126e
// Size: 0x19, Type: bool
function function_fcccc3d2a616b1c7()
{
    if ( !function_556fca66ceb3bb53() )
    {
        return false;
    }
    
    if ( function_8eee0591fd5c5449() )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_save
// Params 0
// Checksum 0xa87ec8c4, Offset: 0x1290
// Size: 0x18c
function try_restore_from_cloud_save()
{
    self notify( #"hash_829977283286e0c1" );
    self endon( #"hash_829977283286e0c1" );
    level endon( #"ztron_game_is_over" );
    utility::flag_wait_all( "ztron_game_initialized" );
    ztron_debug::debugmsg( "restore_from_cloud_save" );
    
    if ( !function_fcccc3d2a616b1c7() )
    {
        utility::flag_set( "ztron_restore_finished", 1 );
        return;
    }
    
    level.ztron.var_ad327faac9d676e5 = 1;
    level.ztron.var_cccdb0a426251ee0 = 1;
    function_b3404dffa5f42712();
    level.ztron.var_14f99018e323773 = level.ztron.var_3f4113a10dece01d;
    num_players = zmsaveread( "num_players" );
    
    for ( var_6787895101874fb4 = 0; var_6787895101874fb4 < num_players ; var_6787895101874fb4++ )
    {
        xuid = zmsaveread( "player_xuids", var_6787895101874fb4 );
        data = function_dee931d5323f3cc3( var_6787895101874fb4 );
        xuidstring = function_4957884b403aaede( "" + xuid );
        data.xuid = function_d82f268d740c23cc( xuidstring );
        level.ztron.saveservice.sessionsave[ xuidstring ] = data;
        ztron_debug::debugmsg( "restore player struct from cloud index = " + var_6787895101874fb4 + " xuid " + xuid + " hex uid = " + xuidstring );
    }
    
    utility::flag_set( "ztron_restore_finished", 1 );
    setomnvar( "ui_was_savegame_loaded_this_round", 1 );
}

// Namespace ztron_save
// Params 0
// Checksum 0x3d89ed13, Offset: 0x1424
// Size: 0x5b8
function function_b3404dffa5f42712()
{
    level.ztron.var_3f4113a10dece01d = zmsaveread( "save", "round_num" );
    
    if ( level.ztron.var_3f4113a10dece01d > 0 )
    {
        arenacounts = int( floor( ( level.ztron.var_3f4113a10dece01d - 1 ) / 4 ) );
        
        if ( level.ztron.var_371903e5801e0e08 )
        {
            var_c5ec41baaa738294 = zmsaveread( "save", "casual_selected_branch_count" );
            assert( var_c5ec41baaa738294 >= arenacounts, "<dev string:x41>" );
            var_950efcb596f941cd = zmsaveread( "save", "casual_selected_branch_bits" );
            ztron_util::function_ee48ff8cfbc2fe5( var_950efcb596f941cd, arenacounts );
            arenaid = ztron_util::function_8cebff05cffb4fa5();
        }
        else
        {
            arenaid = arenacounts % 20;
        }
        
        left_round = 4 - int( ( level.ztron.var_3f4113a10dece01d - 1 ) % 4 );
        level.ztron.var_9550382645aa427e = arenaid;
        level.ztron.var_89860c0b6bc5f6e3 = left_round;
        level.ztron.var_ad327faac9d676e5 = 1;
    }
    
    level.ztron.game_laps = zmsaveread( "save", "game_laps" );
    level.ztron.itemdef.uniqueid = zmsaveread( "save", "item_UniqueID" );
    level.ztron.zombie_base_speed = zmsaveread( "save", "zombie_base_speed" );
    level.ztron.var_f1569c16a29ffcbf = zmsaveread( "save", "zombie_base_health" );
    level.ztron.var_b669c00c4c0cdf55 = zmsaveread( "save", "bonus_rooms_blocked_untilRnd" );
    level.ztron.arenaCamFlip = zmsaveread( "save", "arenaCamFlip" );
    level.ztron.arena_rounds_left = zmsaveread( "save", "arena_rounds_left" );
    level.ztron.game_duration = zmsaveread( "save", "game_duration" );
    level.ztron.lastBonusRoomRound = zmsaveread( "save", "lastBonusRoomRound" );
    level.ztron.lastPapabackSpawn = zmsaveread( "save", "lastPapabackSpawn" );
    level.ztron.skipNextTeleportOnRoundStart = zmsaveread( "save", "skipNextTeleportOnRoundStart" );
    
    for ( index = 0; index < 32 ; index++ )
    {
        key = zmsaveread( "save", "bonusRooms", index, "name" );
        
        if ( key != "" && isdefined( level.ztron.bonusRooms[ key ] ) )
        {
            level.ztron.bonusRooms[ key ].maxvisits = zmsaveread( "save", "bonusRooms", index, "maxvisits" );
            level.ztron.bonusRooms[ key ].cooldowntimeout = zmsaveread( "save", "bonusRooms", index, "cooldown" ) + gettime();
            level.ztron.bonusRooms[ key ].discoveryNeeded = zmsaveread( "save", "bonusRooms", index, "discoveryNeeded" );
        }
    }
    
    storeForcedBonusRoom = zmsaveread( "save", "storeForcedBonusRoom" );
    
    if ( storeForcedBonusRoom )
    {
        ztron_bonus_room::function_b018ee630661e155( storeForcedBonusRoom );
    }
    
    for ( index = 0; index < 128 ; index++ )
    {
        key = zmsaveread( "save", "itemDefs", index, "name" );
        
        if ( key != "" )
        {
            item = ztron_item::function_44d7d2feb29ee403( key );
        }
        
        if ( isdefined( item ) )
        {
            item.cooldown = zmsaveread( "save", "itemDefs", index, "cooldown" );
            continue;
        }
        
        if ( arraycontains( level.ztron.slayer.store.var_d71b77c99f606a75, key ) )
        {
            cooldown = zmsaveread( "save", "itemDefs", index, "cooldown" );
            level.ztron.slayer.store.var_457f81b71bd7d50a[ key ] = gettime() + cooldown;
        }
    }
    
    storeArcadeItem = zmsaveread( "save", "storeArcadeItem" );
    
    for ( i = 0; i < storeArcadeItem ; i++ )
    {
        ztron_item::function_6dc56ae0eba06de1( "ztron_arcade", 1 );
    }
    
    var_c00c6b8aafb601d = 3;
    arena = ztron_arena::function_973956bb5a6e60f7( "aethereal_swamp" );
    
    for ( index = 0; index < var_c00c6b8aafb601d ; index++ )
    {
        lootpoint = arena.var_9df48f55f947471f[ index ];
        
        if ( lootpoint )
        {
            lootpoint.itemused = zmsaveread( "save", "arena", "aethereal_swamp_fixedLootSpotsMask", index );
        }
    }
    
    ztron_debug::debugmsg( "restore level state success current restoredRoundNumber " + level.ztron.var_3f4113a10dece01d );
}

// Namespace ztron_save
// Params 1
// Checksum 0x90e60e3e, Offset: 0x19e4
// Size: 0xa44
function function_a9049320e5338e7f( player )
{
    var_544c5ff332716173 = spawnstruct();
    var_544c5ff332716173.version = getdvarint( @"current_season", 1 );
    var_544c5ff332716173.name = player.name;
    var_544c5ff332716173.xuid = player getxuidint64();
    var_544c5ff332716173.gametime = gettime();
    var_544c5ff332716173.roundnumber = level.ztron.roundnumber;
    var_544c5ff332716173.scorepoints = player.ztron.score.desired_points;
    var_544c5ff332716173.scoreGems = player.ztron.score.desired_gems;
    var_544c5ff332716173.scoreGemsCurLevel = player.ztron.score.gemscurlevel;
    var_544c5ff332716173.scoreGemsNextLevel = player.ztron.score.gemsnextlevel;
    var_544c5ff332716173.scoreMultiX = player.ztron.score.multix;
    var_544c5ff332716173.scoreLives = player.ztron.score.lives;
    var_544c5ff332716173.scoreBombs = player.ztron.score.bombs;
    var_544c5ff332716173.scoreBoosts = player.ztron.score.var_59f1f1595961cbe;
    var_544c5ff332716173.scoreKills = player.ztron.score.kills ?? 0;
    var_544c5ff332716173.scoreMultiProgress = player.ztron.score.multiprogress;
    var_544c5ff332716173.scoreNextExtraLife = player.ztron.score.nextextralife;
    var_544c5ff332716173.healthRegenScale = player.ztron.healthRegenScale;
    var_544c5ff332716173.fatemask = player.ztron.fatemask;
    var_544c5ff332716173.fatesubmask = player.ztron.fatesubmask;
    var_544c5ff332716173.upgradeMask = player.ztron.upgradeMask;
    var_544c5ff332716173.fatetemp = 0;
    var_544c5ff332716173.deaths = player.pers[ "deaths" ] ?? 0;
    var_544c5ff332716173.gemsCount = player.pers[ "extrascore4" ] ?? 0;
    var_544c5ff332716173.scriptItemUsed = player.ztron.total_scripted_item_used ?? 0;
    var_544c5ff332716173.totalChickenSaved = player.ztron.var_fefb4fe9ce470900 ?? 0;
    var_544c5ff332716173.totalCashOwned = player.ztron.total_cash_earned ?? 0;
    var_544c5ff332716173.lastStandCount = player.last_stand_count ?? 0;
    var_544c5ff332716173.special_eliminations = player.pers[ "telemetry" ].special_eliminations ?? 0;
    var_544c5ff332716173.boss_eliminations = player.pers[ "telemetry" ].boss_eliminations ?? 0;
    var_544c5ff332716173.elite_eliminations = player.pers[ "telemetry" ].elite_eliminations ?? 0;
    var_544c5ff332716173.permBarrel = isdefined( player.ztron.permabarrel ) ? 1 : 0;
    
    if ( isdefined( player.ztron.fate_timeout ) )
    {
        var_947fad59a3186674 = 0;
        keys = getarraykeys( player.ztron.fate_timeout );
        
        foreach ( key in keys )
        {
            fatetype = key;
            fatetime = int( player.ztron.fate_timeout[ key ] / 60 );
            fatepacked = ( fatetype << 5 ) + fatetime;
            var_544c5ff332716173.fatetemp += fatepacked << 8 * var_947fad59a3186674;
            var_947fad59a3186674++;
            
            if ( var_947fad59a3186674 > 3 )
            {
                assert( 0, "<dev string:xa4>" );
                break;
            }
        }
    }
    
    var_544c5ff332716173.var_75b1838949260501 = isdefined( player.ztron.default_ammo_mod ) ? getxhash( player.ztron.default_ammo_mod ) : undefined;
    var_544c5ff332716173.var_df607951d801f84 = isdefined( player.ztron.superid ) ? getxhash( player.ztron.superid ) : undefined;
    var_544c5ff332716173.superpoints = 0;
    
    if ( isdefined( player.ztron.superid ) )
    {
        var_544c5ff332716173.superpoints = int( player supers_mp::getcurrentsuperpoints() );
        var_544c5ff332716173.var_945ef487faad2413 = player.ztron.var_945ef487faad2413;
    }
    
    var_544c5ff332716173.var_4095e0b1332ea87 = player.ztron.var_4095e0b1332ea87;
    var_544c5ff332716173.var_6fe8ea86c8758aec = player.ztron.var_6fe8ea86c8758aec;
    var_544c5ff332716173.xbgb = [];
    
    if ( isdefined( player.var_b02f6e7abbbc8a84 ) )
    {
        assert( -1 );
        
        for ( index = 0; index < 3 ; index++ )
        {
            slot = index + 1;
            
            if ( isdefined( player.var_b02f6e7abbbc8a84[ slot ] ) && player.var_b02f6e7abbbc8a84[ slot ] != "none" )
            {
                var_66cc4d3d21a0ce0d = player.var_b02f6e7abbbc8a84[ slot ];
                is_enabled = player bgb::is_enabled( var_66cc4d3d21a0ce0d );
                is_active = player bgb::is_active( var_66cc4d3d21a0ce0d );
                time_left = 0;
                is_free = 0;
                
                if ( isdefined( player.var_4317de3baf10e68d ) && player.var_4317de3baf10e68d[ 0 ] === var_66cc4d3d21a0ce0d )
                {
                    is_free = 1;
                }
                
                if ( is_enabled || is_active )
                {
                    assert( isdefined( level.bgb ) );
                    
                    switch ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 )
                    {
                        case #"hash_4f89286e3448ad44":
                            assert( isdefined( player.bgb_enabled[ var_66cc4d3d21a0ce0d ].start_time ) );
                            assert( isdefined( player.bgb_enabled[ var_66cc4d3d21a0ce0d ].time_left_at_start ) );
                            time_elapsed = gettime() - player.bgb_enabled[ var_66cc4d3d21a0ce0d ].start_time;
                            time_left = maxint( 0, int( player.bgb_enabled[ var_66cc4d3d21a0ce0d ].time_left_at_start * 1000 ) - time_elapsed );
                            break;
                        case #"hash_d80a36cf43c842b8":
                            assert( isdefined( player.bgb_enabled[ var_66cc4d3d21a0ce0d ].rounds_left ) );
                            time_left = maxint( 0, player.bgb_enabled[ var_66cc4d3d21a0ce0d ].rounds_left - 1 );
                            break;
                        case #"hash_d9a7b65f9477385c":
                            if ( var_66cc4d3d21a0ce0d == "support_group" )
                            {
                                xuid = function_fffbd405b1911268( player getxuid() );
                                time_left = level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ];
                                is_enabled = 1;
                            }
                            
                            break;
                        default:
                            break;
                    }
                }
                
                var_544c5ff332716173.xbgb[ index ] = spawnstruct();
                var_544c5ff332716173.xbgb[ index ].ref = var_66cc4d3d21a0ce0d;
                var_544c5ff332716173.xbgb[ index ].is_enabled = is_enabled;
                var_544c5ff332716173.xbgb[ index ].time_left = time_left;
                var_544c5ff332716173.xbgb[ index ].is_free = is_free;
            }
        }
    }
    
    var_544c5ff332716173.cash = player ztron_player_utility::function_da0857c472c9dc5e();
    var_544c5ff332716173.reroll_tokens = player ztron_slayer::function_659833ab56efd4cc();
    var_544c5ff332716173.var_7dfbe91ba26771c5 = player.ztron.var_8103a5c573d38485 ?? 0;
    var_544c5ff332716173.allow_instant_bgb_pack_switching = player.allow_instant_bgb_pack_switching;
    var_544c5ff332716173.telemetry = player ztron_telemetry::function_46543842b0ef2739();
    var_544c5ff332716173.var_4adf4b0726661b95 = player function_a3e8127360ed9156();
    return var_544c5ff332716173;
}

// Namespace ztron_save
// Params 2
// Checksum 0xb1349577, Offset: 0x2431
// Size: 0x863
function function_f241ca31ffa23bd8( player, var_544c5ff332716173 )
{
    xuid = player getxuidint64();
    
    if ( xuid != var_544c5ff332716173.xuid )
    {
        assertmsg( "<dev string:xc2>" );
        return;
    }
    
    rounddelta = level.ztron.roundnumber - var_544c5ff332716173.roundnumber;
    var_59f038029efa5d19 = gettime() - var_544c5ff332716173.gametime;
    player.ztron.var_8103a5c573d38485 = var_544c5ff332716173.var_7dfbe91ba26771c5;
    
    if ( rounddelta > 5 || var_59f038029efa5d19 > 1800000 )
    {
        player.ztron.var_8103a5c573d38485 = 1;
    }
    
    player.ztron.score.multix = var_544c5ff332716173.scoreMultiX;
    player ztron_score::function_4ea454cb6435a318();
    player.ztron.score.points = var_544c5ff332716173.scorepoints;
    player.ztron.score.desired_points = var_544c5ff332716173.scorepoints;
    player ztron_score::function_eeef9f859a7ebd1();
    player.ztron.score.gems = var_544c5ff332716173.scoreGems;
    player.ztron.score.desired_gems = var_544c5ff332716173.scoreGems;
    player.ztron.score.gemscurlevel = var_544c5ff332716173.scoreGemsCurLevel;
    player.ztron.score.gemsnextlevel = var_544c5ff332716173.scoreGemsNextLevel;
    player.ztron.score.multiprogress = var_544c5ff332716173.scoreMultiProgress;
    player.ztron.score.var_e294e535d5856517 = player.ztron.score.gemsnextlevel * 0.1;
    player ztron_score::function_33efcadca04bd395();
    player ztron_score::function_928d324dea557052( var_544c5ff332716173.scoreLives, 1 );
    player namespace_a6a7fe92789f4ad9::function_8cab6adef8e1bef2( var_544c5ff332716173.scoreBombs, 1 );
    player namespace_33e886a9a5b55137::function_992dffefa33a9534( var_544c5ff332716173.scoreBoosts, 1 );
    player.ztron.score.kills = var_544c5ff332716173.scoreKills;
    player.ztron.score.nextextralife = var_544c5ff332716173.scoreNextExtraLife;
    player.ztron.healthRegenScale = var_544c5ff332716173.healthRegenScale;
    player.ztron.default_ammo_mod = ztron_weapon::function_8ad73e6461c844a8( var_544c5ff332716173.var_75b1838949260501 );
    player.ztron.superid = ztron_player_utility::function_ba9d8c3e2b4f18ad( var_544c5ff332716173.var_df607951d801f84 );
    player.ztron.var_4095e0b1332ea87 = var_544c5ff332716173.var_4095e0b1332ea87;
    player.ztron.var_6fe8ea86c8758aec = var_544c5ff332716173.var_6fe8ea86c8758aec;
    player ztron_ui::function_38a72e402dc87ace();
    
    for ( i = 1; i <= 3 ; i++ )
    {
        player bgb::clear_action_slot( i );
    }
    
    for ( index = 0; index < 3 ; index++ )
    {
        if ( isdefined( var_544c5ff332716173.xbgb[ index ] ) )
        {
            player function_632d9183815400b6( var_544c5ff332716173.xbgb[ index ].ref, index + 1, var_544c5ff332716173.xbgb[ index ].is_enabled, var_544c5ff332716173.xbgb[ index ].time_left, var_544c5ff332716173.xbgb[ index ].is_free );
        }
    }
    
    player ztron_player_utility::function_8e1155bcebb3b7b3( var_544c5ff332716173.cash, 0, 0 );
    player ztron_slayer::function_e1ee4667cc096f60( var_544c5ff332716173.reroll_tokens );
    player.allow_instant_bgb_pack_switching = var_544c5ff332716173.allow_instant_bgb_pack_switching ?? 0;
    
    if ( var_544c5ff332716173.permBarrel )
    {
        player thread namespace_73e2c42fdcce1e90::activatebarrel( player, 0, 1, 1 );
    }
    
    while ( var_544c5ff332716173.fatetemp > 0 )
    {
        fatepacked = var_544c5ff332716173.fatetemp & 255;
        var_544c5ff332716173.fatetemp >>= 8;
        fatetime = ( fatepacked & 31 ) * 60;
        fatetype = fatepacked >> 5;
        var_544c5ff332716173.fatemask &= ~( 1 << fatetype );
        player thread ztron_fate::function_3eee572c160b94e8( fatetype, 0, 0, fatetime, 0, 1 );
    }
    
    if ( var_544c5ff332716173.fatemask > 0 )
    {
        player ztron_fate::function_6b69ec848417cf3b( var_544c5ff332716173.fatemask, 0, 0, 1 );
        player.ztron.fatesubmask = var_544c5ff332716173.fatesubmask;
    }
    
    player.ztron.upgradeMask = var_544c5ff332716173.upgradeMask;
    
    if ( isdefined( player.ztron.superid ) )
    {
        player ztron_player_utility::function_64952a50eba73135( player.ztron.superid, 0 );
        player supers_mp::givesuperpoints( var_544c5ff332716173.superpoints );
        player thread ztron_player_utility::function_33e6a52cd856a38( var_544c5ff332716173.var_945ef487faad2413 );
    }
    
    player ztron_telemetry::function_7458ce8ed1b1205c( var_544c5ff332716173 );
    player.pers[ "score" ] = var_544c5ff332716173.scorepoints;
    player.score = var_544c5ff332716173.scorepoints;
    scoreKills = var_544c5ff332716173.scoreKills ?? 0;
    scoreKills = int( clamp( scoreKills, 0, 15000 ) );
    player.pers[ "kills" ] = scoreKills;
    player.kills = scoreKills;
    player.pers[ "deaths" ] = var_544c5ff332716173.deaths;
    player.deaths = var_544c5ff332716173.deaths;
    player stats::setextrascore4( var_544c5ff332716173.gemsCount );
    player.ztron.total_scripted_item_used = var_544c5ff332716173.scriptItemUsed;
    player stats::function_fe615555f60e88b9( var_544c5ff332716173.scriptItemUsed );
    player.ztron.var_fefb4fe9ce470900 = var_544c5ff332716173.totalChickenSaved;
    player stats::setextrascore3( var_544c5ff332716173.totalChickenSaved );
    player.ztron.total_cash_earned = var_544c5ff332716173.totalCashOwned;
    player ztron_player_utility::function_c2b330b498256506();
    player.last_stand_count = var_544c5ff332716173.lastStandCount;
    player.pers[ "telemetry" ].special_eliminations = var_544c5ff332716173.special_eliminations;
    player.pers[ "telemetry" ].boss_eliminations = var_544c5ff332716173.boss_eliminations;
    player.pers[ "telemetry" ].elite_eliminations = var_544c5ff332716173.elite_eliminations;
    player thread ztron_slayer::function_15570363a5ae870b( var_544c5ff332716173.var_4adf4b0726661b95 );
}

// Namespace ztron_save
// Params 5, eflags: 0x4
// Checksum 0x20f6e709, Offset: 0x2c9c
// Size: 0x332
function private function_632d9183815400b6( hash_bgb, slot, is_enabled, time_left, is_free = 0 )
{
    if ( is_free )
    {
        if ( isxhash( hash_bgb ) )
        {
            keys = getarraykeys( level.bgb );
            
            foreach ( key in keys )
            {
                if ( getxhash( key ) === hash_bgb )
                {
                    hash_bgb = key;
                }
            }
        }
        
        self.var_4317de3baf10e68d[ 0 ] = hash_bgb;
    }
    
    keys = getarraykeys( level.bgb );
    
    foreach ( var_66cc4d3d21a0ce0d in keys )
    {
        if ( var_66cc4d3d21a0ce0d == hash_bgb )
        {
            if ( !level.onlinegame || bgb::get_gum_count( var_66cc4d3d21a0ce0d ) > 0 )
            {
                if ( is_enabled && level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 == "activated" )
                {
                    if ( var_66cc4d3d21a0ce0d == "support_group" )
                    {
                        xuid = function_fffbd405b1911268( self getxuid() );
                        level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] = time_left;
                    }
                    
                    if ( level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] >= 2 )
                    {
                        bgb::function_4818e19472b65502( var_66cc4d3d21a0ce0d );
                        level.var_60ef36d37839ce06[ xuid ][ var_66cc4d3d21a0ce0d ] = undefined;
                        return;
                    }
                }
                
                bgb::set_action_slot( slot, var_66cc4d3d21a0ce0d, 0, 0 );
                
                if ( is_enabled )
                {
                    switch ( level.bgb[ var_66cc4d3d21a0ce0d ].var_882452eafdaa1626 )
                    {
                        case #"hash_4f89286e3448ad44":
                            override_limit = time_left * 0.001;
                            break;
                        case #"hash_d80a36cf43c842b8":
                            override_limit = time_left;
                            break;
                        case #"hash_d9a7b65f9477385c":
                            override_limit = time_left;
                            break;
                        default:
                            override_limit = undefined;
                            break;
                    }
                    
                    self.ztron.var_3c6c0516b9bba99e = spawnstruct();
                    self.ztron.var_3c6c0516b9bba99e.name = var_66cc4d3d21a0ce0d;
                    self.ztron.var_3c6c0516b9bba99e.var_e97a4f4962bc3f25 = slot;
                    bgb::give_slot( slot, var_66cc4d3d21a0ce0d, override_limit, level.bgb[ var_66cc4d3d21a0ce0d ].var_f7a5175f1157cddd );
                    
                    if ( isdefined( level.bgb[ var_66cc4d3d21a0ce0d ].var_925d847561d6b98e ) )
                    {
                        self thread [[ level.bgb[ var_66cc4d3d21a0ce0d ].var_925d847561d6b98e ]]( override_limit );
                    }
                }
            }
            
            break;
        }
    }
}

// Namespace ztron_save
// Params 0
// Checksum 0xd3f410ed, Offset: 0x2fd6
// Size: 0x154
function function_970f8cd0a0744c21()
{
    self endon( #"disconnect" );
    assert( self.ztron.initialized, "<dev string:xd3>" );
    var_f38c65a250c7b724 = 0;
    xuid = self getxuid();
    
    if ( isdefined( level.ztron.saveservice.sessionsave[ xuid ] ) )
    {
        function_f241ca31ffa23bd8( self, level.ztron.saveservice.sessionsave[ xuid ] );
        var_f38c65a250c7b724 = 1;
    }
    else if ( isdefined( level.ztron.gamestarted ) )
    {
        timedelta = gettime() - level.ztron.gamestarted;
        
        if ( level.ztron.roundnumber > 15 || timedelta > 1800000 )
        {
            self.ztron.var_8103a5c573d38485 = 1;
            var_f38c65a250c7b724 = 1;
        }
    }
    
    if ( var_f38c65a250c7b724 )
    {
        if ( !self.ztron.var_8103a5c573d38485 )
        {
            ztron_dialog::function_927bb94feca983e8( getxhash( "player_save_restored" ) );
            return;
        }
        
        ztron_dialog::function_927bb94feca983e8( getxhash( "player_save_restored_late" ) );
    }
}

// Namespace ztron_save
// Params 0
// Checksum 0x5bb2c818, Offset: 0x3132
// Size: 0xb0
function function_3801ed44c5e06a2e()
{
    self notify( #"hash_8bd17a5072caecd" );
    self endon( #"hash_8bd17a5072caecd" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( self.ztron.storepurchases && self.ztron.storepurchases.size > 0 )
    {
        while ( self.ztron.storepurchases.size > 0 )
        {
            waitframe();
        }
        
        wait 0.5;
        level.ztron.saveservice.sessionsave[ self getxuid() ] = function_a9049320e5338e7f( self );
    }
}

// Namespace ztron_save
// Params 0
// Checksum 0xf194ea1, Offset: 0x31ea
// Size: 0x19d
function function_6a6982e376ce9a84()
{
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        foreach ( player in level.players )
        {
            level.ztron.saveservice.sessionsave[ player getxuid() ] = function_a9049320e5338e7f( player );
            player thread function_3801ed44c5e06a2e();
        }
        
        shouldsave = function_556fca66ceb3bb53() && level.ztron.roundnumber >= 2;
        
        if ( shouldsave )
        {
            if ( function_fcccc3d2a616b1c7() && level.ztron.var_cccdb0a426251ee0 )
            {
                if ( !zmsaveinvalidate() )
                {
                    ztron_debug::debugmsg( "Ztron ManualSave Invalidate Failed" );
                }
                else
                {
                    ztron_debug::debugmsg( "Ztron ManualSave Invalidate Success" );
                }
                
                level notify( #"hash_e4b7a00ad502de4d" );
            }
            
            if ( !level.ztron.var_cccdb0a426251ee0 || level.ztron.roundnumber > level.ztron.var_14f99018e323773 )
            {
                function_d84e1589696a8b99( 1 );
                setomnvar( "ui_was_savegame_loaded_this_round", 0 );
            }
        }
    }
}

// Namespace ztron_save
// Params 1
// Checksum 0xf42208db, Offset: 0x338f
// Size: 0x201
function function_d84e1589696a8b99( savetype )
{
    assert( isdefined( level.players ) );
    
    if ( getactiveclientcount( 0 ) == 0 )
    {
        ztron_debug::debugmsg( "No active clients for save system, aborting" );
        return 0;
    }
    
    var_dc4fa75655c6106d = [];
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && player.sessionstate == "playing" && isalive( player ) && !ztron_player_utility::function_baf22e7b5779b533( player ) && player isconnected() )
        {
            var_dc4fa75655c6106d[ var_dc4fa75655c6106d.size ] = player;
        }
    }
    
    if ( var_dc4fa75655c6106d.size == 0 )
    {
        ztron_debug::debugmsg( "Incorrect number of players (" + var_dc4fa75655c6106d.size + ") for save system, aborting" );
        return 0;
    }
    
    playlist_id = getplaylistid();
    
    if ( !zmsaveinit( playlist_id, var_dc4fa75655c6106d ) )
    {
        ztron_debug::debugmsg( "Failed to initialize save, aborting" );
        return 0;
    }
    
    ztron_debug::debugmsg( "Save initialization complete" );
    function_1165610657dc0f70();
    index = 0;
    
    foreach ( var_544c5ff332716173 in level.ztron.saveservice.sessionsave )
    {
        function_5076d5f513563547( var_544c5ff332716173, index );
        index += 1;
    }
    
    function_9b1b5c35ccb1953c( savetype );
    return function_fb94d517aa254043( savetype );
}

// Namespace ztron_save
// Params 1, eflags: 0x4
// Checksum 0x9a8774ed, Offset: 0x3599
// Size: 0x10d
function private function_9b1b5c35ccb1953c( savetype )
{
    var_c00c6b8aafb601d = 3;
    
    if ( savetype == 1 || !isdefined( level.ztron.saveservice.var_d0fa7a02c8791794 ) )
    {
        mask = [];
        arena = ztron_arena::function_973956bb5a6e60f7( "aethereal_swamp" );
        
        for ( index = 0; index < var_c00c6b8aafb601d ; index++ )
        {
            mask[ index ] = istrue( arena.var_9df48f55f947471f[ index ].itemused );
        }
        
        level.ztron.saveservice.var_d0fa7a02c8791794 = mask;
    }
    
    for ( index = 0; index < var_c00c6b8aafb601d ; index++ )
    {
        itemused = istrue( level.ztron.saveservice.var_d0fa7a02c8791794[ index ] );
        zmsavewrite( "save", "arena", "aethereal_swamp_fixedLootSpotsMask", index, itemused );
    }
}

// Namespace ztron_save
// Params 2, eflags: 0x4
// Checksum 0xf4ad884b, Offset: 0x36ae
// Size: 0x100, Type: bool
function private function_fb94d517aa254043( savetype, var_d2ed90247986516 = 0 )
{
    if ( isdedicatedserver() )
    {
        if ( zmsavepush( savetype ) )
        {
            ztron_debug::debugmsg( "Commit/Push completed successfully" );
            
            if ( savetype == 1 )
            {
                level.ztron.var_f5f3283763443139 = 1;
                
                foreach ( player in level.players )
                {
                    player thread set_autosave_stat( 1, var_d2ed90247986516 );
                }
            }
            
            return true;
        }
    }
    else
    {
        /#
            if ( zmsavecommit() )
            {
                ztron_debug::debugmsg( "<dev string:xfe>" );
                return true;
            }
        #/
    }
    
    ztron_debug::debugmsg( "Failed to commit/push save." );
    return false;
}

// Namespace ztron_save
// Params 2, eflags: 0x4
// Checksum 0x7edbd6a4, Offset: 0x37b7
// Size: 0x7f
function private set_autosave_stat( val, var_d2ed90247986516 = 0 )
{
    self endon( #"disconnect" );
    assert( isdefined( val ) );
    self setplayerdata( level.var_6f9b00680ed002d8, "auto_save_available", val );
    self setplayerdata( level.var_6f9b00680ed002d8, "auto_save_due_to_pause_timer", var_d2ed90247986516 );
    self setplayerdata( level.var_6f9b00680ed002d8, "auto_save_type", 1 );
    waitframe();
    self function_432458e83a394206( 2 );
}

// Namespace ztron_save
// Params 0
// Checksum 0xd07620a6, Offset: 0x383e
// Size: 0x788
function function_1165610657dc0f70()
{
    zmsavewrite( "save_version", getdvarint( @"current_season", 1 ) );
    timestamp = getsystemtime();
    assert( timestamp > 0 );
    zmsavewrite( "save", "timestamp", timestamp );
    zmsavewrite( "save", "round_num", level.ztron.roundnumber );
    zmsavewrite( "save", "game_laps", level.ztron.game_laps );
    zmsavewrite( "save", "item_UniqueID", level.ztron.itemdef.uniqueid );
    zmsavewrite( "save", "zombie_base_speed", level.ztron.zombie_base_speed );
    zmsavewrite( "save", "zombie_base_health", level.ztron.var_f1569c16a29ffcbf );
    zmsavewrite( "save", "bonus_rooms_blocked_untilRnd", level.ztron.var_b669c00c4c0cdf55 );
    zmsavewrite( "save", "arenaCamFlip", level.ztron.arenaCamFlip );
    zmsavewrite( "save", "arena_rounds_left", level.ztron.arena_rounds_left );
    zmsavewrite( "save", "game_duration", level.ztron.game_duration );
    zmsavewrite( "save", "lastBonusRoomRound", level.ztron.lastBonusRoomRound );
    zmsavewrite( "save", "lastPapabackSpawn", level.ztron.lastPapabackSpawn );
    zmsavewrite( "save", "skipNextTeleportOnRoundStart", level.ztron.skipNextTeleportOnRoundStart );
    zmsavewrite( "save", "storeForcedBonusRoom", level.ztron.slayer.forcedbonusroom ?? "" );
    zmsavewrite( "save", "storeArcadeItem", level.ztron.slayer.arcadeitem ?? 0 );
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        branchcount = ztron_util::function_d0cfe1c172136d8a();
        zmsavewrite( "save", "casual_selected_branch_count", branchcount );
        bitarray = ztron_util::function_34cfaede9c9a96ef();
        zmsavewrite( "save", "casual_selected_branch_bits", bitarray );
    }
    else
    {
        zmsavewrite( "save", "casual_selected_branch_count", 0 );
        zmsavewrite( "save", "casual_selected_branch_bits", 0 );
    }
    
    var_9c15549c0ecb598a = [];
    
    foreach ( room in level.ztron.bonusRooms )
    {
        var_ffff991a5d77dee = spawnstruct();
        var_ffff991a5d77dee.name = room.name;
        var_ffff991a5d77dee.maxvisits = room.maxvisits;
        var_ffff991a5d77dee.cooldowntimeout = room.cooldowntimeout > gettime() ? room.cooldowntimeout - gettime() : 0;
        var_ffff991a5d77dee.discoveryNeeded = room.discoveryNeeded;
        var_9c15549c0ecb598a[ var_9c15549c0ecb598a.size ] = var_ffff991a5d77dee;
        assert( var_9c15549c0ecb598a.size < 32 );
    }
    
    for ( index = 0; index < 32 ; index++ )
    {
        if ( index < var_9c15549c0ecb598a.size && isdefined( var_9c15549c0ecb598a[ index ] ) )
        {
            zmsavewrite( "save", "bonusRooms", index, "name", var_9c15549c0ecb598a[ index ].name );
            zmsavewrite( "save", "bonusRooms", index, "cooldown", var_9c15549c0ecb598a[ index ].cooldowntimeout );
            zmsavewrite( "save", "bonusRooms", index, "maxvisits", var_9c15549c0ecb598a[ index ].maxvisits );
            zmsavewrite( "save", "bonusRooms", index, "discoveryNeeded", var_9c15549c0ecb598a[ index ].discoveryNeeded );
            continue;
        }
        
        zmsavewrite( "save", "bonusRooms", index, "name", "" );
    }
    
    itemcooldowns = [];
    
    foreach ( item in level.ztron.itemdef.itemdata )
    {
        var_b7826e5ec4612f10 = spawnstruct();
        var_b7826e5ec4612f10.name = item.ref;
        var_b7826e5ec4612f10.cooldown = int( item.cooldown );
        itemcooldowns[ itemcooldowns.size ] = var_b7826e5ec4612f10;
        assert( itemcooldowns.size < 128 );
    }
    
    foreach ( itemref in getarraykeys( level.ztron.slayer.store.var_457f81b71bd7d50a ) )
    {
        cooldown = level.ztron.slayer.store.var_457f81b71bd7d50a[ itemref ] - gettime();
        
        if ( cooldown < 0 )
        {
            cooldown = 0;
        }
        
        cooldown = clampint( cooldown, 0, cooldown );
        var_b7826e5ec4612f10 = spawnstruct();
        var_b7826e5ec4612f10.name = itemref;
        var_b7826e5ec4612f10.cooldown = int( cooldown );
        itemcooldowns[ itemcooldowns.size ] = var_b7826e5ec4612f10;
        assert( itemcooldowns.size < 128 );
    }
    
    for ( index = 0; index < 128 ; index++ )
    {
        if ( index < itemcooldowns.size && isdefined( itemcooldowns[ index ] ) )
        {
            zmsavewrite( "save", "itemDefs", index, "name", itemcooldowns[ index ].name );
            zmsavewrite( "save", "itemDefs", index, "cooldown", itemcooldowns[ index ].cooldown );
            continue;
        }
        
        zmsavewrite( "save", "itemDefs", index, "name", "" );
    }
    
    zmsavewrite( "save", "is_hard_core", istrue( level.ztron.var_95d8c7a469393957 ) );
    zmsavewrite( "save", "is_force_fps", istrue( level.ztron.var_74a3707334cfe144 ) );
}

// Namespace ztron_save
// Params 2
// Checksum 0x738c289f, Offset: 0x3fce
// Size: 0x840
function function_5076d5f513563547( data, var_6787895101874fb4 )
{
    if ( !isdefined( data ) )
    {
        return;
    }
    
    zmsavewrite( "save", "players", var_6787895101874fb4, "gameTime", data.gametime );
    zmsavewrite( "save", "players", var_6787895101874fb4, "roundNumber", data.roundnumber );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scorePoints", data.scorepoints );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreGems", data.scoreGems );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreGemsCurLevel", data.scoreGemsCurLevel );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreGemsNextLevel", data.scoreGemsNextLevel );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreMultiX", data.scoreMultiX );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreLives", data.scoreLives );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreBombs", data.scoreBombs );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreBoosts", data.scoreBoosts );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreKills", data.scoreKills );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreMultiProgress", data.scoreMultiProgress );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scoreNextExtraLife", data.scoreNextExtraLife );
    zmsavewrite( "save", "players", var_6787895101874fb4, "healthRegenScale", data.healthRegenScale );
    zmsavewrite( "save", "players", var_6787895101874fb4, "fatemask", data.fatemask );
    zmsavewrite( "save", "players", var_6787895101874fb4, "fatesubmask", data.fatesubmask );
    zmsavewrite( "save", "players", var_6787895101874fb4, "fatemaskTemp", data.fatetemp );
    zmsavewrite( "save", "players", var_6787895101874fb4, "upgradeMask", data.upgradeMask );
    
    if ( isdefined( data.var_75b1838949260501 ) )
    {
        zmsavewrite( "save", "players", var_6787895101874fb4, "ammoMod", data.var_75b1838949260501 );
    }
    else
    {
        zmsavewrite( "save", "players", var_6787895101874fb4, "ammoMod", "" );
    }
    
    if ( isdefined( data.var_df607951d801f84 ) )
    {
        super = supers_mp::function_8738421e46f2cfbc( data.var_df607951d801f84 );
        zmsavewrite( "save", "players", var_6787895101874fb4, "super", "name", data.var_df607951d801f84 );
        zmsavewrite( "save", "players", var_6787895101874fb4, "super", "charge", data.superpoints );
        zmsavewrite( "save", "players", var_6787895101874fb4, "super", "rechargePoints", data.var_945ef487faad2413 );
    }
    else
    {
        zmsavewrite( "save", "players", var_6787895101874fb4, "super", "name", "none" );
        zmsavewrite( "save", "players", var_6787895101874fb4, "super", "charge", 0 );
        zmsavewrite( "save", "players", var_6787895101874fb4, "super", "rechargePoints", 0 );
    }
    
    for ( index = 0; index < 3 ; index++ )
    {
        if ( isdefined( data.xbgb[ index ] ) )
        {
            zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "ref", data.xbgb[ index ].ref );
            zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "is_enabled", data.xbgb[ index ].is_enabled );
            zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "time_left", data.xbgb[ index ].time_left );
            zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "is_free", data.xbgb[ index ].is_free );
            continue;
        }
        
        zmsavewrite( "save", "players", var_6787895101874fb4, "gums", index, "ref", "" );
    }
    
    zmsavewrite( "save", "players", var_6787895101874fb4, "cash", data.cash );
    zmsavewrite( "save", "players", var_6787895101874fb4, "reroll_tokens", data.reroll_tokens );
    zmsavewrite( "save", "players", var_6787895101874fb4, "deaths", data.deaths );
    zmsavewrite( "save", "players", var_6787895101874fb4, "gemsCount", data.gemsCount );
    zmsavewrite( "save", "players", var_6787895101874fb4, "scriptItemUsed", data.scriptItemUsed );
    zmsavewrite( "save", "players", var_6787895101874fb4, "totalChickenSaved", data.totalChickenSaved );
    zmsavewrite( "save", "players", var_6787895101874fb4, "totalCashOwned", data.totalCashOwned );
    zmsavewrite( "save", "players", var_6787895101874fb4, "lastStandCount", data.lastStandCount );
    zmsavewrite( "save", "players", var_6787895101874fb4, "special_eliminations", data.special_eliminations );
    zmsavewrite( "save", "players", var_6787895101874fb4, "boss_eliminations", data.boss_eliminations );
    zmsavewrite( "save", "players", var_6787895101874fb4, "elite_eliminations", data.elite_eliminations );
    zmsavewrite( "save", "players", var_6787895101874fb4, "permBarrel", data.permBarrel );
    zmsavewrite( "save", "players", var_6787895101874fb4, "armor_vest", data.var_4095e0b1332ea87 );
    zmsavewrite( "save", "players", var_6787895101874fb4, "armor_plates", data.var_6fe8ea86c8758aec );
    zmsavewrite( "save", "players", var_6787895101874fb4, "allow_instant_bgb_pack_switching", data.allow_instant_bgb_pack_switching );
    zmsavewrite( "save", "players", var_6787895101874fb4, "telemetry", "timePlayed", data.telemetry.timeplayed );
    zmsavewrite( "save", "players", var_6787895101874fb4, "telemetry", "gemsEarned", data.telemetry.gemsEarned );
    zmsavewrite( "save", "players", var_6787895101874fb4, "telemetry", "coinsEarned", data.telemetry.coinsEarned );
    zmsavewrite( "save", "players", var_6787895101874fb4, "telemetry", "silverbackEliminations", data.telemetry.silverbackEliminations );
    zmsavewrite( "save", "players", var_6787895101874fb4, "telemetry", "matchID", data.telemetry.var_f745ee6944b463f2 );
    
    for ( index = 0; index < 24 ; index++ )
    {
        itemsave = data.var_4adf4b0726661b95[ index ];
        
        if ( itemsave.ref )
        {
            zmsavewrite( "save", "players", var_6787895101874fb4, "slayerMartItems", index, "ref", itemsave.ref );
            zmsavewrite( "save", "players", var_6787895101874fb4, "slayerMartItems", index, "timeLeft", itemsave.duration );
        }
    }
}

// Namespace ztron_save
// Params 1
// Checksum 0xb139fe93, Offset: 0x4816
// Size: 0x7d1
function function_dee931d5323f3cc3( var_6787895101874fb4 )
{
    data = spawnstruct();
    data.gametime = zmsaveread( "save", "players", var_6787895101874fb4, "gameTime" );
    data.roundnumber = zmsaveread( "save", "players", var_6787895101874fb4, "roundNumber" );
    data.scorepoints = zmsaveread( "save", "players", var_6787895101874fb4, "scorePoints" );
    data.scoreGems = zmsaveread( "save", "players", var_6787895101874fb4, "scoreGems" );
    data.scoreGemsCurLevel = zmsaveread( "save", "players", var_6787895101874fb4, "scoreGemsCurLevel" );
    data.scoreGemsNextLevel = zmsaveread( "save", "players", var_6787895101874fb4, "scoreGemsNextLevel" );
    data.scoreMultiX = zmsaveread( "save", "players", var_6787895101874fb4, "scoreMultiX" );
    data.scoreLives = zmsaveread( "save", "players", var_6787895101874fb4, "scoreLives" );
    data.scoreBombs = zmsaveread( "save", "players", var_6787895101874fb4, "scoreBombs" );
    data.scoreBoosts = zmsaveread( "save", "players", var_6787895101874fb4, "scoreBoosts" );
    data.scoreKills = zmsaveread( "save", "players", var_6787895101874fb4, "scoreKills" );
    data.scoreMultiProgress = zmsaveread( "save", "players", var_6787895101874fb4, "scoreMultiProgress" );
    data.scoreNextExtraLife = zmsaveread( "save", "players", var_6787895101874fb4, "scoreNextExtraLife" );
    data.healthRegenScale = zmsaveread( "save", "players", var_6787895101874fb4, "healthRegenScale" );
    data.fatemask = zmsaveread( "save", "players", var_6787895101874fb4, "fatemask" );
    data.fatesubmask = zmsaveread( "save", "players", var_6787895101874fb4, "fatesubmask" );
    data.fatetemp = zmsaveread( "save", "players", var_6787895101874fb4, "fatemaskTemp" );
    data.upgradeMask = int( zmsaveread( "save", "players", var_6787895101874fb4, "upgradeMask" ) );
    ammo_mod = zmsaveread( "save", "players", var_6787895101874fb4, "ammoMod" );
    
    if ( ammo_mod != "" )
    {
        data.var_75b1838949260501 = ammo_mod;
    }
    
    super = zmsaveread( "save", "players", var_6787895101874fb4, "super", "name" );
    
    if ( isdefined( super ) && super != "none" )
    {
        data.var_df607951d801f84 = super;
        data.superpoints = zmsaveread( "save", "players", var_6787895101874fb4, "super", "charge" );
        data.var_945ef487faad2413 = zmsaveread( "save", "players", var_6787895101874fb4, "super", "rechargePoints" );
    }
    
    data.xbgb = [];
    
    for ( index = 0; index < 3 ; index++ )
    {
        saved_bgb = zmsaveread( "save", "players", var_6787895101874fb4, "gums", index, "ref" );
        
        if ( saved_bgb == "" )
        {
            continue;
        }
        
        data.xbgb[ index ] = spawnstruct();
        data.xbgb[ index ].ref = saved_bgb;
        data.xbgb[ index ].is_enabled = zmsaveread( "save", "players", var_6787895101874fb4, "gums", index, "is_enabled" );
        data.xbgb[ index ].time_left = zmsaveread( "save", "players", var_6787895101874fb4, "gums", index, "time_left" );
        data.xbgb[ index ].is_free = zmsaveread( "save", "players", var_6787895101874fb4, "gums", index, "is_free" );
    }
    
    data.cash = zmsaveread( "save", "players", var_6787895101874fb4, "cash" );
    data.reroll_tokens = zmsaveread( "save", "players", var_6787895101874fb4, "reroll_tokens" );
    data.deaths = zmsaveread( "save", "players", var_6787895101874fb4, "deaths" );
    data.gemsCount = zmsaveread( "save", "players", var_6787895101874fb4, "gemsCount" );
    data.scriptItemUsed = zmsaveread( "save", "players", var_6787895101874fb4, "scriptItemUsed" );
    data.totalChickenSaved = zmsaveread( "save", "players", var_6787895101874fb4, "totalChickenSaved" );
    data.totalCashOwned = zmsaveread( "save", "players", var_6787895101874fb4, "totalCashOwned" );
    data.lastStandCount = zmsaveread( "save", "players", var_6787895101874fb4, "lastStandCount" );
    data.special_eliminations = zmsaveread( "save", "players", var_6787895101874fb4, "special_eliminations" );
    data.boss_eliminations = zmsaveread( "save", "players", var_6787895101874fb4, "boss_eliminations" );
    data.elite_eliminations = zmsaveread( "save", "players", var_6787895101874fb4, "elite_eliminations" );
    data.permBarrel = zmsaveread( "save", "players", var_6787895101874fb4, "permBarrel" );
    data.var_4095e0b1332ea87 = zmsaveread( "save", "players", var_6787895101874fb4, "armor_vest" );
    data.var_6fe8ea86c8758aec = zmsaveread( "save", "players", var_6787895101874fb4, "armor_plates" );
    data.allow_instant_bgb_pack_switching = zmsaveread( "save", "players", var_6787895101874fb4, "allow_instant_bgb_pack_switching" );
    telemetry = spawnstruct();
    telemetry.timeplayed = zmsaveread( "save", "players", var_6787895101874fb4, "telemetry", "timePlayed" );
    telemetry.gemsEarned = zmsaveread( "save", "players", var_6787895101874fb4, "telemetry", "gemsEarned" );
    telemetry.coinsEarned = zmsaveread( "save", "players", var_6787895101874fb4, "telemetry", "coinsEarned" );
    telemetry.silverbackEliminations = zmsaveread( "save", "players", var_6787895101874fb4, "telemetry", "silverbackEliminations" );
    telemetry.var_f745ee6944b463f2 = zmsaveread( "save", "players", var_6787895101874fb4, "telemetry", "matchID" );
    data.telemetry = telemetry;
    var_4adf4b0726661b95 = [];
    
    for ( index = 0; index < 24 ; index++ )
    {
        save = spawnstruct();
        save.ref = zmsaveread( "save", "players", var_6787895101874fb4, "slayerMartItems", index, "ref" );
        
        if ( save.ref == "" )
        {
            continue;
        }
        
        save.duration = zmsaveread( "save", "players", var_6787895101874fb4, "slayerMartItems", index, "timeLeft" );
        var_4adf4b0726661b95[ var_4adf4b0726661b95.size ] = save;
    }
    
    data.var_4adf4b0726661b95 = var_4adf4b0726661b95;
    return data;
}

// Namespace ztron_save
// Params 1, eflags: 0x4
// Checksum 0xd9331324, Offset: 0x4ff0
// Size: 0x1b2
function private function_d82f268d740c23cc( hex )
{
    hex = string( hex );
    intvalue = int( 0 );
    
    for ( i = 0; i < hex.size ; i++ )
    {
        nib = hex[ i ];
        nibvalue = 0;
        
        switch ( nib )
        {
            case #"hash_31100bbc01bd3230":
            case #"hash_31100cbc01bd33c3":
            case #"hash_31100dbc01bd3556":
            case #"hash_31100ebc01bd36e9":
            case #"hash_31100fbc01bd387c":
            case #"hash_311010bc01bd3a0f":
            case #"hash_311011bc01bd3ba2":
            case #"hash_311012bc01bd3d35":
            case #"hash_311017bc01bd4514":
            case #"hash_311018bc01bd46a7":
                nibvalue = int( nib );
                break;
            case #"hash_31103fbc01bd840c":
            case #"hash_31105fbc01bdb66c":
                nibvalue = 10;
                break;
            case #"hash_311042bc01bd88c5":
            case #"hash_311062bc01bdbb25":
                nibvalue = 11;
                break;
            case #"hash_311041bc01bd8732":
            case #"hash_311061bc01bdb992":
                nibvalue = 12;
                break;
            case #"hash_31103cbc01bd7f53":
            case #"hash_31105cbc01bdb1b3":
                nibvalue = 13;
                break;
            case #"hash_31103bbc01bd7dc0":
            case #"hash_31105bbc01bdb020":
                nibvalue = 14;
                break;
            case #"hash_31103ebc01bd8279":
            case #"hash_31105ebc01bdb4d9":
                nibvalue = 15;
                break;
        }
        
        intvalue = int( intvalue << 4 | int( nibvalue ) );
    }
    
    return intvalue;
}

// Namespace ztron_save
// Params 1
// Checksum 0x5eb0e625, Offset: 0x51ab
// Size: 0x53
function function_70c11aca4f83fcda( save )
{
    var_4adf4b0726661b95 = self.ztron.var_4adf4b0726661b95 ?? [];
    var_4adf4b0726661b95[ var_4adf4b0726661b95.size ] = save;
    function_cdc669dbc8ea2101( var_4adf4b0726661b95 );
    self.ztron.var_4adf4b0726661b95 = var_4adf4b0726661b95;
}

// Namespace ztron_save
// Params 0, eflags: 0x4
// Checksum 0xfd29cac1, Offset: 0x5206
// Size: 0x163
function private function_a3e8127360ed9156()
{
    var_4adf4b0726661b95 = [];
    
    for ( i = 0; i < self.ztron.var_4adf4b0726661b95.size ; i++ )
    {
        if ( i >= 24 )
        {
            break;
        }
        
        save = self.ztron.var_4adf4b0726661b95[ i ];
        
        if ( save.entity )
        {
            packedsave = spawnstruct();
            packedsave.ref = save.ref;
            packedsave.duration = save.entity [[ save.var_c93abd0f18db7640 ]]() ?? 0;
            ztron_debug::debugmsg( "ZTRON_SAVE: PackSlayerMartItemsSaveData\t" + save.ref + " - " + packedsave.duration );
            
            if ( packedsave.duration > 0 )
            {
                var_4adf4b0726661b95[ var_4adf4b0726661b95.size ] = packedsave;
            }
            else
            {
                self.ztron.var_4adf4b0726661b95[ i ] = undefined;
            }
            
            continue;
        }
        
        self.ztron.var_4adf4b0726661b95[ i ] = undefined;
    }
    
    if ( self.ztron.var_4adf4b0726661b95 )
    {
        function_cdc669dbc8ea2101( self.ztron.var_4adf4b0726661b95 );
    }
    
    return var_4adf4b0726661b95;
}

