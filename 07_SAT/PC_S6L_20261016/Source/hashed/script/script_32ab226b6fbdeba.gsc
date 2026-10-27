// script_32ab226b6fbdeba  (hash_032ab226b6fbdeba.gscc) (size: 11095 Bytes / 0x2b57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f77e663 (1064822371)
// size ...... 11095 (0x2b57)
// includes .. 10  (offset: 0x293f)
// strings ... 9   (offset: 0x298f)
// dev strs .. 23  (offset: 0x2a0f)
// exports ... 38  (offset: 0x1caf)
// cseg ...... 0x143 + 0x1b6c (0x1caf)
// imports ... 51  (offset: 0x229f)
// animtree1 . 0   (offset: 0x2b57)
// animtree2 . 0   (offset: 0x2b57)
#using script_44280f644740bac;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\frune_checkpoints;

#namespace namespace_27888f54e9b5bb16;

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0xfe576d65, Offset: 0x161
// Size: 0x208
function init()
{
    level endon( #"game_ended" );
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x45>", "<dev string:x58>", &function_6b14346b00be4ec5, helptext, "<dev string:x5c>", undefined );
        }
        
        helptext = "<dev string:x62>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x97>", "<dev string:x58>", &function_47a6f1c8ef24d7a9, helptext, "<dev string:x5c>", undefined );
        }
        
        helptext = "<dev string:xad>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xde>", "<dev string:x58>", &function_2f3eecfa5a742d60, helptext, "<dev string:x5c>", undefined );
        }
    #/
    
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_44f7e6549b9e6660 = { #var_2432c465f4c82730:[], #var_3523439287b94b71:0, #var_586f225864ecfb50:0, #var_fd4537658eddb311:0, #var_4b15c6bc82854648:0 };
    modeinfo.var_44f7e6549b9e6660.var_5b43e88a528bcbfd = utility::function_6f5d2e1f1ff70482( getdvarint( @"hash_756e1b5cd766a0f4", modeinfo.frune_bundle.var_7f464a02983f1fb ?? 100 ) );
    modeinfo.var_44f7e6549b9e6660.var_bc27ac64ea592610 = getdvarint( @"hash_ecede5d88f6deed", modeinfo.frune_bundle.var_b613f90dec296780 ?? 720000 );
    
    if ( !isdefined( modeinfo.var_2750a906451d1008 ) )
    {
        modeinfo.var_2750a906451d1008 = [];
    }
    
    level thread function_becc3e076da59d8();
    setomnvar( o"ui_free_run_low_time_seconds", -1 );
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0xe924e6fd, Offset: 0x371
// Size: 0x4b
function function_341bd1e1d757b178()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_44f7e6549b9e6660.var_4b15c6bc82854648 = 1;
    modeinfo.var_44f7e6549b9e6660.var_586f225864ecfb50 = gettime();
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0x92a65696, Offset: 0x3c4
// Size: 0x4b
function function_2cd83eafed2d9a50()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_44f7e6549b9e6660.var_fd4537658eddb311 = 1;
    modeinfo.var_44f7e6549b9e6660.var_3523439287b94b71 = gettime();
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0x63842802, Offset: 0x417
// Size: 0x106
function function_853cc26a8cd32347()
{
    self notify( #"hash_7344fc9ce3390792" );
    self endon( #"hash_7344fc9ce3390792" );
    level endon( #"game_ended" );
    var_44f7e6549b9e6660 = game[ #"frune_tuning" ].var_44f7e6549b9e6660;
    
    while ( true )
    {
        if ( !var_44f7e6549b9e6660.var_4b15c6bc82854648 )
        {
            continue;
        }
        
        if ( var_44f7e6549b9e6660.var_fd4537658eddb311 )
        {
            break;
        }
        
        var_da2142e8cf5376b6 = function_a3a4bf509f50b65e();
        
        foreach ( player in level.players )
        {
            function_40f18858f93418b( player, var_da2142e8cf5376b6 );
        }
        
        wait var_44f7e6549b9e6660.var_5b43e88a528bcbfd;
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 0, eflags: 0xc
// Checksum 0x43246e65, Offset: 0x525
// Size: 0x111
function private function_becc3e076da59d8()
{
    self notify( #"hash_3f4db8cf30a80239" );
    self endon( #"hash_3f4db8cf30a80239" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    var_4ed450b3c3cd419 = 0;
    
    while ( true )
    {
        timeremaining = int( gamelogic_mp::gettimeremaining() );
        
        if ( timeremaining < 11000 && timeremaining >= 0 )
        {
            setomnvar( o"ui_free_run_low_time_seconds", int( utility::function_6f5d2e1f1ff70482( timeremaining ) ) );
            
            if ( !var_4ed450b3c3cd419 )
            {
                var_4ed450b3c3cd419 = 1;
                
                foreach ( player in level.players )
                {
                    player gameplay_sound_fx::playlocalsoundfx( #"countdown_warning" );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0xd1a15e09, Offset: 0x63e
// Size: 0xae
function function_a3a4bf509f50b65e()
{
    var_44f7e6549b9e6660 = game[ #"frune_tuning" ].var_44f7e6549b9e6660;
    
    if ( !var_44f7e6549b9e6660.var_4b15c6bc82854648 || var_44f7e6549b9e6660.var_586f225864ecfb50 < 0 )
    {
        return 0;
    }
    
    if ( var_44f7e6549b9e6660.var_fd4537658eddb311 )
    {
        var_da2142e8cf5376b6 = var_44f7e6549b9e6660.var_3523439287b94b71 - var_44f7e6549b9e6660.var_586f225864ecfb50;
        return var_da2142e8cf5376b6;
    }
    
    currenttimems = gettime();
    var_da2142e8cf5376b6 = currenttimems - var_44f7e6549b9e6660.var_586f225864ecfb50;
    
    if ( var_da2142e8cf5376b6 < 0 )
    {
        assertmsg( "<dev string:xf7>" );
        var_da2142e8cf5376b6 = 0;
    }
    
    return var_da2142e8cf5376b6;
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x849fa41f, Offset: 0x6f5
// Size: 0x40
function function_76ba268d368eed64( player )
{
    currenttime = gettime();
    var_b6fb06989a9ed9c9 = currenttime - player.freeruninfo.var_a882e795141bf183;
    return var_b6fb06989a9ed9c9;
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x8e51493a, Offset: 0x73e
// Size: 0x40
function function_99b4e6f99655aaf8( player )
{
    currenttime = gettime();
    var_b6fb06989a9ed9c9 = currenttime - player.freeruninfo.var_2dbea8ea2c8af83b;
    return var_b6fb06989a9ed9c9;
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x44384c35, Offset: 0x787
// Size: 0x40
function function_96f81f582f42c16c( player )
{
    currenttime = gettime();
    var_2d10d7f654c64c81 = currenttime - player.freeruninfo.var_5271a39f8b21d4a3;
    return var_2d10d7f654c64c81;
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x8c37b4b, Offset: 0x7d0
// Size: 0x40
function function_dd9b2c9be9a1c678( player )
{
    currenttime = gettime();
    var_2d10d7f654c64c81 = currenttime - player.freeruninfo.var_b2c9df167adcea1b;
    return var_2d10d7f654c64c81;
}

// Namespace namespace_27888f54e9b5bb16
// Params 2
// Checksum 0x455f7d0a, Offset: 0x819
// Size: 0x41
function function_40f18858f93418b( player, var_da2142e8cf5376b6 )
{
    player setclientomnvar( "ui_free_run_timer_time", player.freeruninfo.var_b84d513c2e04b50e ?? utility::function_6f5d2e1f1ff70482( var_da2142e8cf5376b6 ) );
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x4ac1a3f9, Offset: 0x862
// Size: 0x21b
function function_b5fd5ae9eb439ed5( player )
{
    modeinfo = game[ #"frune_tuning" ];
    guid = player player::getuniqueid();
    var_180d0632f74d285a = function_a3a4bf509f50b65e();
    finishinfo = { #var_da2142e8cf5376b6:var_180d0632f74d285a, #guid:guid };
    modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730[ modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730.size ] = finishinfo;
    var_1112a71b5834aa94 = modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730.size;
    podiumscoreevent = function_dc67948b753f1bc6( var_1112a71b5834aa94 );
    player.teamplacement = var_1112a71b5834aa94;
    var_cd9344241b3bfdd0 = max( var_180d0632f74d285a - player.freeruninfo.var_f5a96581fe746943, 0 );
    
    if ( !isdefined( player.pers[ #"objective_use_time" ] ) )
    {
        player.pers[ #"objective_use_time" ] = {};
    }
    
    player.pers[ #"objective_use_time" ].totaltime = var_cd9344241b3bfdd0;
    
    if ( podiumscoreevent )
    {
        player thread points::doscoreevent( podiumscoreevent );
    }
    
    function_e727d44909823051( player, var_180d0632f74d285a );
    function_b03b92a632497cb8( player );
    player notify( #"hash_9e9bf21e01b8eb5", var_1112a71b5834aa94 );
    player.freeruninfo.var_b84d513c2e04b50e = utility::function_6f5d2e1f1ff70482( var_180d0632f74d285a );
    player.freeruninfo.var_328df64682b9ec5c = gettime();
    player stats::setextrascore3( int( var_180d0632f74d285a / 100 ) );
    player setclientomnvar( o"ui_free_run_current_player_finish_time", utility::function_6f5d2e1f1ff70482( player.freeruninfo.var_328df64682b9ec5c - modeinfo.var_44f7e6549b9e6660.var_586f225864ecfb50 ) );
    player setclientomnvar( o"ui_free_run_has_finished_race", 1 );
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x1573be9, Offset: 0xa85
// Size: 0xb8
function function_b02442a42a7c59d9( player )
{
    guid = player player::getuniqueid();
    
    foreach ( index, finishinfo in game[ #"frune_tuning" ].var_44f7e6549b9e6660.var_2432c465f4c82730 )
    {
        if ( finishinfo.guid == guid )
        {
            return index;
        }
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0xdfdcf01, Offset: 0xb46
// Size: 0x38, Type: bool
function function_bccf2e7ccbcd2299( player )
{
    var_1112a71b5834aa94 = function_b02442a42a7c59d9( player );
    
    if ( !isdefined( var_1112a71b5834aa94 ) )
    {
        return false;
    }
    else if ( var_1112a71b5834aa94 > 2 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_27888f54e9b5bb16
// Params 1, eflags: 0x4
// Checksum 0xeb960aec, Offset: 0xb87
// Size: 0x9a
function private function_dc67948b753f1bc6( var_12ece92bc5316787 )
{
    switch ( var_12ece92bc5316787 )
    {
        case 1:
            return #"hash_9cba676c1f43dc1c";
        case 2:
            return #"hash_ccc1fc9876376e6a";
        case 3:
            return #"hash_5c58bc5356411a47";
        case 4:
            return #"hash_81dac381451ad85a";
        case 5:
            return #"hash_4a60916c81bbe8cb";
        default:
            return #"hash_2efc64d1008176b6";
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x17428910, Offset: 0xc29
// Size: 0xc5, Type: bool
function function_28ad61cb6b5e840c( player )
{
    var_2432c465f4c82730 = game[ #"frune_tuning" ].var_44f7e6549b9e6660.var_2432c465f4c82730;
    guid = player player::getuniqueid();
    
    foreach ( finishinfo in var_2432c465f4c82730 )
    {
        if ( finishinfo.guid == guid )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0xb8d92622, Offset: 0xcf7
// Size: 0x82, Type: bool
function function_c590a853e39425f8()
{
    foreach ( player in level.players )
    {
        if ( !function_28ad61cb6b5e840c( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_27888f54e9b5bb16
// Params 2
// Checksum 0x75f874bb, Offset: 0xd82
// Size: 0x3e, Type: bool
function function_1705192ef6e67ca7( player, checkpoint )
{
    guid = player player::getuniqueid();
    
    if ( checkpoint.var_e7524bbf3eaa3688[ guid ] )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_27888f54e9b5bb16
// Params 2
// Checksum 0xc8712025, Offset: 0xdc9
// Size: 0xbd
function function_ad72883c191a0570( player, checkpoint )
{
    if ( !isdefined( checkpoint.var_e7524bbf3eaa3688 ) )
    {
        checkpoint.var_e7524bbf3eaa3688 = [];
    }
    
    guid = player player::getuniqueid();
    var_e71edf491faa3f73 = frune_checkpoints::function_2a11cd287cd4fdc1( checkpoint );
    checkpoint.var_e7524bbf3eaa3688[ guid ] = { #var_da2142e8cf5376b6:function_a3a4bf509f50b65e(), #arriveorder:checkpoint.var_e7524bbf3eaa3688.size, #var_e71edf491faa3f73:var_e71edf491faa3f73, #zoneindex:checkpoint.zoneindex, #checkpointindex:checkpoint.checkpointindex };
}

// Namespace namespace_27888f54e9b5bb16
// Params 2
// Checksum 0x9960e5c1, Offset: 0xe8e
// Size: 0x52
function function_5c97a2de0e27328a( player, checkpoint )
{
    guid = player player::getuniqueid();
    arriveinfo = checkpoint.var_e7524bbf3eaa3688[ guid ];
    
    if ( arriveinfo )
    {
        return arriveinfo.arriveorder;
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 2, eflags: 0x4
// Checksum 0x64f40a4b, Offset: 0xee9
// Size: 0x52
function private function_c732d7d380a7b861( player, checkpoint )
{
    guid = player player::getuniqueid();
    arriveinfo = checkpoint.var_e7524bbf3eaa3688[ guid ];
    
    if ( arriveinfo )
    {
        return arriveinfo.var_da2142e8cf5376b6;
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0xd5079839, Offset: 0xf44
// Size: 0x1b8
function function_a0cad25ab7e3540d()
{
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_2750a906451d1008 = [];
    var_7f6b8b00be70706 = modeinfo.var_afad088dc0cd7ba7.size;
    discoveredplayers = [];
    
    for ( izone = var_7f6b8b00be70706; izone > 0 ; izone-- )
    {
        var_aa316401a0aed86 = modeinfo.var_afad088dc0cd7ba7[ izone ].size;
        
        for ( icheckpoint = var_aa316401a0aed86; icheckpoint >= 0 ; icheckpoint-- )
        {
            currentcheckpoint = modeinfo.var_afad088dc0cd7ba7[ izone ][ icheckpoint ].checkpoint;
            
            foreach ( guid, var_d798c19f3f523323 in currentcheckpoint.var_e7524bbf3eaa3688 )
            {
                if ( discoveredplayers[ guid ] )
                {
                    continue;
                }
                
                discoveredplayers[ guid ] = 1;
                var_b2ceb6d5c790fba0 = { #var_da2142e8cf5376b6:var_d798c19f3f523323.var_da2142e8cf5376b6, #var_e71edf491faa3f73:var_d798c19f3f523323.var_e71edf491faa3f73, #zoneindex:var_d798c19f3f523323.zoneindex, #checkpointindex:var_d798c19f3f523323.checkpointindex, #guid:guid };
                modeinfo.var_2750a906451d1008[ modeinfo.var_2750a906451d1008.size ] = var_b2ceb6d5c790fba0;
            }
        }
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 0
// Checksum 0xd84e98cf, Offset: 0x1104
// Size: 0x10d
function function_a4e3a49755aa5bef()
{
    function_a0cad25ab7e3540d();
    modeinfo = game[ #"frune_tuning" ];
    
    foreach ( var_8405081a1ab3b4a1, arriveinfo in modeinfo.var_2750a906451d1008 )
    {
        player = player::getplayerforguid( arriveinfo.guid );
        
        if ( !player )
        {
            continue;
        }
        
        function_5861820d8f05a959( var_8405081a1ab3b4a1, player );
    }
    
    function_2c7370cf70955488();
    podiumplayercount = max( modeinfo.var_2750a906451d1008.size ?? 0, level.players.size );
    totalplayers = clampint( podiumplayercount, 1, 99 );
    setomnvar( "ui_free_run_max_placement", totalplayers );
}

// Namespace namespace_27888f54e9b5bb16
// Params 0, eflags: 0x4
// Checksum 0xb1c873bb, Offset: 0x1219
// Size: 0x1ca
function private function_2c7370cf70955488()
{
    var_2540a5c8c17aca22 = 8;
    var_ae55d10e91a863e3 = var_2540a5c8c17aca22 + 1;
    var_4a4aebaefc620173 = var_ae55d10e91a863e3 + 5;
    var_a20503675f83c69 = var_4a4aebaefc620173 + 5;
    modeinfo = game[ #"frune_tuning" ];
    
    for ( i = 0; i < 3 ; i++ )
    {
        packeddata = 0;
        finishtime = 0;
        
        if ( i < modeinfo.var_2750a906451d1008.size )
        {
            var_b2ceb6d5c790fba0 = modeinfo.var_2750a906451d1008[ i ];
            lastcheckpoint = var_b2ceb6d5c790fba0.checkpointindex ?? 1;
            var_192fd6574a1c198c = var_b2ceb6d5c790fba0.zoneindex ?? 1;
            finishtime = utility::function_6f5d2e1f1ff70482( var_b2ceb6d5c790fba0.var_da2142e8cf5376b6 );
            isfinished = var_b2ceb6d5c790fba0.var_e71edf491faa3f73;
            hasleft = 0;
            clientnum = 0;
            player = player::getplayerforguid( var_b2ceb6d5c790fba0.guid );
            
            if ( !player )
            {
                hasleft = 1;
            }
            else
            {
                clientnum = player getentitynumber() + 1;
            }
            
            clientnummax = 255;
            var_dcde557148517ca2 = 31;
            checkpointmax = 31;
            packeddata |= hasleft << var_a20503675f83c69;
            packeddata |= ( lastcheckpoint & checkpointmax ) << var_4a4aebaefc620173;
            packeddata |= ( var_192fd6574a1c198c & var_dcde557148517ca2 ) << var_ae55d10e91a863e3;
            packeddata |= isfinished << var_2540a5c8c17aca22;
            packeddata |= clientnum & clientnummax;
        }
        
        setomnvar( "ui_free_run_finish_time_place_" + i + 1, finishtime ?? 0 );
        setomnvar( "ui_free_run_leaderboard_data_" + i + 1, packeddata );
    }
}

// Namespace namespace_27888f54e9b5bb16
// Params 2, eflags: 0x4
// Checksum 0x54ea66f5, Offset: 0x13eb
// Size: 0x4f
function private function_5861820d8f05a959( var_8405081a1ab3b4a1, player )
{
    podiumrank = isdefined( var_8405081a1ab3b4a1 ) ? var_8405081a1ab3b4a1 + 1 : clampint( level.players.size, 1, 99 );
    player setclientomnvar( "ui_free_run_current_placement", podiumrank );
}

// Namespace namespace_27888f54e9b5bb16
// Params 1, eflags: 0x4
// Checksum 0x58dc249, Offset: 0x1442
// Size: 0x3b
function private function_4e54316673f6525( player )
{
    if ( getdvarint( @"hash_6bd24a4ec4fcc4c3", 0 ) )
    {
        return 0;
    }
    
    return int( player getplayerdata( "mp", "frunePersonalBestTimeMS" ) ?? 0 );
}

// Namespace namespace_27888f54e9b5bb16
// Params 1
// Checksum 0x919284d2, Offset: 0x1485
// Size: 0x5a
function function_d1ac3daa005490d5( player )
{
    var_f86607a638e6f785 = utility::function_6f5d2e1f1ff70482( function_4e54316673f6525( player ) );
    
    if ( var_f86607a638e6f785 <= 0 )
    {
        var_f86607a638e6f785 = utility::function_6f5d2e1f1ff70482( game[ #"frune_tuning" ].var_44f7e6549b9e6660.var_bc27ac64ea592610 );
    }
    
    return int( var_f86607a638e6f785 );
}

// Namespace namespace_27888f54e9b5bb16
// Params 2, eflags: 0x4
// Checksum 0xbac4a8d8, Offset: 0x14e8
// Size: 0x3d
function private function_9995282d1a213141( player, timems )
{
    if ( getdvarint( @"hash_6bd24a4ec4fcc4c3", 0 ) )
    {
        return;
    }
    
    player setplayerdata( "mp", "frunePersonalBestTimeMS", timems );
}

// Namespace namespace_27888f54e9b5bb16
// Params 2, eflags: 0x4
// Checksum 0x43ff0a8d, Offset: 0x152d
// Size: 0xdb
function private function_e727d44909823051( player, var_ec0762ff80df97e0 )
{
    var_1ec7808c395869f0 = function_4e54316673f6525( player );
    player.freeruninfo.var_cc5e2854e7317e16 = var_1ec7808c395869f0 == 0 || var_ec0762ff80df97e0 < var_1ec7808c395869f0;
    
    if ( game_utility_mp::matchmakinggame() && player.freeruninfo.var_cc5e2854e7317e16 )
    {
        player setclientomnvar( o"ui_free_run_show_personal_best", var_1ec7808c395869f0 > 0 );
        player setclientomnvar( o"ui_free_run_prev_personal_best", utility::function_6f5d2e1f1ff70482( var_1ec7808c395869f0 ) );
        function_9995282d1a213141( player, var_ec0762ff80df97e0 );
    }
    
    player.freeruninfo.var_9d3bc37eee7f5ce1 = var_ec0762ff80df97e0 < game[ #"frune_tuning" ].var_44f7e6549b9e6660.var_bc27ac64ea592610;
}

// Namespace namespace_27888f54e9b5bb16
// Params 2, eflags: 0x4
// Checksum 0x9422e7e3, Offset: 0x1610
// Size: 0x46
function private function_64fe3557b4013d43( player, flatindex )
{
    if ( getdvarint( @"hash_6bd24a4ec4fcc4c3", 0 ) )
    {
        return 0;
    }
    
    return int( player getplayerdata( "mp", "fruneCheckpointBestTimesMS", flatindex ) ?? 0 );
}

// Namespace namespace_27888f54e9b5bb16
// Params 3
// Checksum 0x8c062d3, Offset: 0x165e
// Size: 0x69
function function_1d78941edaf8827e( player, flatindex, elapsedtimems )
{
    if ( flatindex < 0 || flatindex >= 256 )
    {
        assertmsg( "<dev string:x112>" + flatindex + "<dev string:x133>" + 255 + "<dev string:x14a>" );
        return;
    }
    
    player.freeruninfo.var_f7f77add9ccca410[ flatindex ] = elapsedtimems;
}

// Namespace namespace_27888f54e9b5bb16
// Params 1, eflags: 0x4
// Checksum 0xbacf404b, Offset: 0x16cf
// Size: 0x10e
function private function_b03b92a632497cb8( player )
{
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    if ( getdvarint( @"hash_6bd24a4ec4fcc4c3", 0 ) )
    {
        return;
    }
    
    foreach ( index, elapsedtimems in player.freeruninfo.var_f7f77add9ccca410 )
    {
        if ( index < 0 || index >= 256 )
        {
            assertmsg( "<dev string:x112>" + index + "<dev string:x133>" + 255 + "<dev string:x14a>" );
            continue;
        }
        
        var_ab70aa5b97af68ad = function_64fe3557b4013d43( player, index );
        
        if ( var_ab70aa5b97af68ad == 0 || elapsedtimems < var_ab70aa5b97af68ad )
        {
            player setplayerdata( "mp", "fruneCheckpointBestTimesMS", index, elapsedtimems );
        }
    }
}

/#

    // Namespace namespace_27888f54e9b5bb16
    // Params 2, eflags: 0x4
    // Checksum 0x66f25f53, Offset: 0x17e5
    // Size: 0x22, Type: dev
    function private function_47a6f1c8ef24d7a9( host, args )
    {
        function_9995282d1a213141( host, 0 );
    }

    // Namespace namespace_27888f54e9b5bb16
    // Params 2, eflags: 0x4
    // Checksum 0x242e124, Offset: 0x180f
    // Size: 0x48, Type: dev
    function private function_2f3eecfa5a742d60( host, args )
    {
        for ( i = 0; i < 256 ; i++ )
        {
            host setplayerdata( "<dev string:x14c>", "<dev string:x14f>", i, 0 );
        }
    }

    // Namespace namespace_27888f54e9b5bb16
    // Params 2, eflags: 0x4
    // Checksum 0x4c374e9, Offset: 0x185f
    // Size: 0x5a, Type: dev
    function private function_6b14346b00be4ec5( host, args )
    {
        var_8005b965951cc17 = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x58>" );
        var_8005b965951cc17.var_58dbee33b4330156 = !var_8005b965951cc17.var_58dbee33b4330156;
        level thread function_cfcc327299bb3865( var_8005b965951cc17.var_58dbee33b4330156 );
    }

    // Namespace namespace_27888f54e9b5bb16
    // Params 1, eflags: 0xc
    // Checksum 0x2508d08, Offset: 0x18c1
    // Size: 0x3e, Type: dev
    function private function_cfcc327299bb3865( enabled )
    {
        self notify( #"hash_94e40240f4247772" );
        self endon( #"hash_94e40240f4247772" );
        
        if ( !enabled )
        {
            return;
        }
        
        while ( true )
        {
            function_6664ee99684fe22d();
            waitframe();
        }
    }

    // Namespace namespace_27888f54e9b5bb16
    // Params 0, eflags: 0x4
    // Checksum 0x1edbe464, Offset: 0x1907
    // Size: 0x3a8, Type: dev
    function private function_6664ee99684fe22d()
    {
        modeinfo = game[ #"frune_tuning" ];
        var_79a033234d11dea = "<dev string:x16a>" + utility::function_6f5d2e1f1ff70482( modeinfo.var_44f7e6549b9e6660.var_586f225864ecfb50 ) + "<dev string:x178>" + utility::function_6f5d2e1f1ff70482( function_a3a4bf509f50b65e() );
        heightoffset = 100;
        printtoscreen2d( 75, heightoffset, var_79a033234d11dea, ( 1, 1, 1 ), 1.5 );
        finishposition = 0;
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x18e>", ( 1, 1, 1 ), 1.5 );
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x1ad>", ( 1, 1, 1 ), 1.5 );
        
        foreach ( finishinfo in modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730 )
        {
            finishposition++;
            spacer = finishposition < 10 ? "<dev string:x1bf>" : "<dev string:x1c4>";
            player = player::getplayerforguid( finishinfo.guid );
            playerlabel = player ? player.name : finishinfo.guid;
            finishseconds = utility::function_6f5d2e1f1ff70482( finishinfo.var_da2142e8cf5376b6 );
            playerentry = finishposition + spacer + playerlabel + "<dev string:x1c8>" + finishseconds;
            heightoffset += 50;
            printtoscreen2d( 75, heightoffset, playerentry, ( 1, 1, 1 ), 1.5 );
        }
        
        var_bf75ec0e958132f4 = 0;
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x18e>", ( 1, 1, 1 ), 1.5 );
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x1cc>", ( 1, 1, 1 ), 1.5 );
        
        foreach ( arriveinfo in modeinfo.var_2750a906451d1008 )
        {
            var_bf75ec0e958132f4++;
            spacer = var_bf75ec0e958132f4 < 10 ? "<dev string:x1bf>" : "<dev string:x1c4>";
            var_4cc7a4743eb7f2b2 = arriveinfo.zoneindex + "<dev string:x14a>" + arriveinfo.checkpointindex;
            player = player::getplayerforguid( arriveinfo.guid );
            playerlabel = player ? player.name : arriveinfo.guid;
            arriveseconds = utility::function_6f5d2e1f1ff70482( arriveinfo.var_da2142e8cf5376b6 );
            playerentry = var_bf75ec0e958132f4 + spacer + playerlabel + "<dev string:x1c8>" + var_4cc7a4743eb7f2b2 + "<dev string:x1dd>" + arriveseconds;
            heightoffset += 50;
            printtoscreen2d( 75, heightoffset, playerentry, ( 1, 1, 1 ), 1.5 );
        }
    }

#/
