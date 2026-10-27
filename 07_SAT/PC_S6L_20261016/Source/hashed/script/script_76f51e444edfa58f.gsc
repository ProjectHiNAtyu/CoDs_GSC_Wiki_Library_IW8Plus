// script_76f51e444edfa58f  (hash_76f51e444edfa58f.gscc) (size: 10944 Bytes / 0x2ac0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f8b62de (1602970334)
// size ...... 10944 (0x2ac0)
// includes .. 11  (offset: 0x28a0)
// strings ... 9   (offset: 0x28f8)
// dev strs .. 23  (offset: 0x2978)
// exports ... 37  (offset: 0x1be8)
// cseg ...... 0x141 + 0x1aa7 (0x1be8)
// imports ... 53  (offset: 0x21b0)
// animtree1 . 0   (offset: 0x2ac0)
// animtree2 . 0   (offset: 0x2ac0)
#using script_44280f644740bac;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\frun_checkpoints;
#using scripts\mp\gametypes\frun_free_run;

#namespace namespace_fcff552b98571df1;

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0xc030a31, Offset: 0x15f
// Size: 0x203
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
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_44f7e6549b9e6660 = { #var_2432c465f4c82730:[], #var_3523439287b94b71:0, #var_586f225864ecfb50:0, #var_fd4537658eddb311:0, #var_4b15c6bc82854648:0 };
    modeinfo.var_44f7e6549b9e6660.var_5b43e88a528bcbfd = utility::function_6f5d2e1f1ff70482( getdvarint( @"hash_85ee9256ced5d647", modeinfo.frun_bundle.var_ac2c56c2d4ef798e ?? 100 ) );
    modeinfo.var_44f7e6549b9e6660.var_bc27ac64ea592610 = getdvarint( @"hash_71283cffc7d38024", modeinfo.frun_bundle.var_5680b237ba5d7b8f ?? 720000 );
    
    if ( !isdefined( modeinfo.var_2750a906451d1008 ) )
    {
        modeinfo.var_2750a906451d1008 = [];
    }
    
    level thread function_becc3e076da59d8();
    setomnvar( o"ui_free_run_low_time_seconds", -1 );
}

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0x42c63621, Offset: 0x36a
// Size: 0x46
function function_341bd1e1d757b178()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_44f7e6549b9e6660.var_4b15c6bc82854648 = 1;
    modeinfo.var_44f7e6549b9e6660.var_586f225864ecfb50 = gettime();
}

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0x3944864a, Offset: 0x3b8
// Size: 0x46
function function_2cd83eafed2d9a50()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_44f7e6549b9e6660.var_fd4537658eddb311 = 1;
    modeinfo.var_44f7e6549b9e6660.var_3523439287b94b71 = gettime();
}

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0x1051b9b8, Offset: 0x406
// Size: 0x10c
function function_853cc26a8cd32347()
{
    self notify( #"hash_d32e4c5116925145" );
    self endon( #"hash_d32e4c5116925145" );
    level endon( #"game_ended" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    var_44f7e6549b9e6660 = modeinfo.var_44f7e6549b9e6660;
    
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

// Namespace namespace_fcff552b98571df1
// Params 0, eflags: 0xc
// Checksum 0xeaf189c8, Offset: 0x51a
// Size: 0x111
function private function_becc3e076da59d8()
{
    self notify( #"hash_f815a06254222a6c" );
    self endon( #"hash_f815a06254222a6c" );
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

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0xa274cfb3, Offset: 0x633
// Size: 0xb4
function function_a3a4bf509f50b65e()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    var_44f7e6549b9e6660 = modeinfo.var_44f7e6549b9e6660;
    
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

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0x2d4a43b2, Offset: 0x6f0
// Size: 0x40
function function_76ba268d368eed64( player )
{
    currenttime = gettime();
    var_b6fb06989a9ed9c9 = currenttime - player.freeruninfo.var_a882e795141bf183;
    return var_b6fb06989a9ed9c9;
}

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0x2784ae97, Offset: 0x739
// Size: 0x40
function function_99b4e6f99655aaf8( player )
{
    currenttime = gettime();
    var_b6fb06989a9ed9c9 = currenttime - player.freeruninfo.var_2dbea8ea2c8af83b;
    return var_b6fb06989a9ed9c9;
}

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0xededab98, Offset: 0x782
// Size: 0x40
function function_96f81f582f42c16c( player )
{
    currenttime = gettime();
    var_2d10d7f654c64c81 = currenttime - player.freeruninfo.var_5271a39f8b21d4a3;
    return var_2d10d7f654c64c81;
}

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0xa1169ce6, Offset: 0x7cb
// Size: 0x40
function function_dd9b2c9be9a1c678( player )
{
    currenttime = gettime();
    var_2d10d7f654c64c81 = currenttime - player.freeruninfo.var_b2c9df167adcea1b;
    return var_2d10d7f654c64c81;
}

// Namespace namespace_fcff552b98571df1
// Params 2
// Checksum 0xec8a9aa7, Offset: 0x814
// Size: 0x41
function function_40f18858f93418b( player, var_da2142e8cf5376b6 )
{
    player setclientomnvar( "ui_free_run_timer_time", player.freeruninfo.var_b84d513c2e04b50e ?? utility::function_6f5d2e1f1ff70482( var_da2142e8cf5376b6 ) );
}

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0x80e80202, Offset: 0x85d
// Size: 0x1ef
function function_b5fd5ae9eb439ed5( player )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    guid = player player::getuniqueid();
    var_180d0632f74d285a = function_a3a4bf509f50b65e();
    finishinfo = { #var_da2142e8cf5376b6:var_180d0632f74d285a, #guid:guid };
    modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730[ modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730.size ] = finishinfo;
    var_1112a71b5834aa94 = modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730.size;
    podiumscoreevent = function_dc67948b753f1bc6( var_1112a71b5834aa94 );
    player.teamplacement = var_1112a71b5834aa94;
    
    if ( !isdefined( player.pers[ #"objective_use_time" ] ) )
    {
        player.pers[ #"objective_use_time" ] = {};
    }
    
    player.pers[ #"objective_use_time" ].totaltime = var_180d0632f74d285a;
    
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

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0x7282aa53, Offset: 0xa54
// Size: 0xbe
function function_b02442a42a7c59d9( player )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    guid = player player::getuniqueid();
    
    foreach ( index, finishinfo in modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730 )
    {
        if ( finishinfo.guid == guid )
        {
            return index;
        }
    }
}

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0xa42828ac, Offset: 0xb1b
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

// Namespace namespace_fcff552b98571df1
// Params 1, eflags: 0x4
// Checksum 0x9a74ac0b, Offset: 0xb5c
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

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0x649718aa, Offset: 0xbfe
// Size: 0xcb, Type: bool
function function_28ad61cb6b5e840c( player )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    var_2432c465f4c82730 = modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730;
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

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0x110cc18f, Offset: 0xcd2
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

// Namespace namespace_fcff552b98571df1
// Params 2
// Checksum 0xf7755847, Offset: 0xd5d
// Size: 0xbd
function function_ad72883c191a0570( player, checkpoint )
{
    if ( !isdefined( checkpoint.var_e7524bbf3eaa3688 ) )
    {
        checkpoint.var_e7524bbf3eaa3688 = [];
    }
    
    guid = player player::getuniqueid();
    var_e71edf491faa3f73 = frun_checkpoints::function_2a11cd287cd4fdc1( checkpoint );
    checkpoint.var_e7524bbf3eaa3688[ guid ] = { #var_da2142e8cf5376b6:function_a3a4bf509f50b65e(), #arriveorder:checkpoint.var_e7524bbf3eaa3688.size, #var_e71edf491faa3f73:var_e71edf491faa3f73, #zoneindex:checkpoint.zoneindex, #checkpointindex:checkpoint.checkpointindex };
}

// Namespace namespace_fcff552b98571df1
// Params 2
// Checksum 0xe8824326, Offset: 0xe22
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

// Namespace namespace_fcff552b98571df1
// Params 2, eflags: 0x4
// Checksum 0x1516acac, Offset: 0xe7d
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

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0xa6d209af, Offset: 0xed8
// Size: 0x1b3
function function_a0cad25ab7e3540d()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
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

// Namespace namespace_fcff552b98571df1
// Params 0
// Checksum 0xab9b0959, Offset: 0x1093
// Size: 0x108
function function_a4e3a49755aa5bef()
{
    function_a0cad25ab7e3540d();
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace namespace_fcff552b98571df1
// Params 0, eflags: 0x4
// Checksum 0x1a2aa367, Offset: 0x11a3
// Size: 0x1c5
function private function_2c7370cf70955488()
{
    var_2540a5c8c17aca22 = 8;
    var_ae55d10e91a863e3 = var_2540a5c8c17aca22 + 1;
    var_4a4aebaefc620173 = var_ae55d10e91a863e3 + 5;
    var_a20503675f83c69 = var_4a4aebaefc620173 + 5;
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace namespace_fcff552b98571df1
// Params 2, eflags: 0x4
// Checksum 0x2508c012, Offset: 0x1370
// Size: 0x4f
function private function_5861820d8f05a959( var_8405081a1ab3b4a1, player )
{
    podiumrank = isdefined( var_8405081a1ab3b4a1 ) ? var_8405081a1ab3b4a1 + 1 : clampint( level.players.size, 1, 99 );
    player setclientomnvar( "ui_free_run_current_placement", podiumrank );
}

// Namespace namespace_fcff552b98571df1
// Params 1, eflags: 0x4
// Checksum 0x201f536b, Offset: 0x13c7
// Size: 0x24
function private function_4e54316673f6525( player )
{
    return int( player getplayerdata( "mp", "frunPersonalBestTimeMS" ) ?? 0 );
}

// Namespace namespace_fcff552b98571df1
// Params 1
// Checksum 0xe2471568, Offset: 0x13f4
// Size: 0x60
function function_d1ac3daa005490d5( player )
{
    var_f86607a638e6f785 = utility::function_6f5d2e1f1ff70482( function_4e54316673f6525( player ) );
    
    if ( var_f86607a638e6f785 <= 0 )
    {
        modeinfo = frun_free_run::function_97dc8f6dff0a9255();
        var_f86607a638e6f785 = utility::function_6f5d2e1f1ff70482( modeinfo.var_44f7e6549b9e6660.var_bc27ac64ea592610 );
    }
    
    return int( var_f86607a638e6f785 );
}

// Namespace namespace_fcff552b98571df1
// Params 2, eflags: 0x4
// Checksum 0x476178a5, Offset: 0x145d
// Size: 0x28
function private function_9995282d1a213141( player, timems )
{
    player setplayerdata( "mp", "frunPersonalBestTimeMS", timems );
}

// Namespace namespace_fcff552b98571df1
// Params 2, eflags: 0x4
// Checksum 0x302a9b37, Offset: 0x148d
// Size: 0xe1
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
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    player.freeruninfo.var_9d3bc37eee7f5ce1 = var_ec0762ff80df97e0 < modeinfo.var_44f7e6549b9e6660.var_bc27ac64ea592610;
}

// Namespace namespace_fcff552b98571df1
// Params 2, eflags: 0x4
// Checksum 0x327be7b4, Offset: 0x1576
// Size: 0x2f
function private function_64fe3557b4013d43( player, flatindex )
{
    return int( player getplayerdata( "mp", "frunCheckpointBestTimesMS", flatindex ) ?? 0 );
}

// Namespace namespace_fcff552b98571df1
// Params 3
// Checksum 0xa115857e, Offset: 0x15ae
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

// Namespace namespace_fcff552b98571df1
// Params 1, eflags: 0x4
// Checksum 0xc4a1012e, Offset: 0x161f
// Size: 0xfc
function private function_b03b92a632497cb8( player )
{
    if ( !game_utility_mp::matchmakinggame() )
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
            player setplayerdata( "mp", "frunCheckpointBestTimesMS", index, elapsedtimems );
        }
    }
}

/#

    // Namespace namespace_fcff552b98571df1
    // Params 2, eflags: 0x4
    // Checksum 0xcf27b8fe, Offset: 0x1723
    // Size: 0x22, Type: dev
    function private function_47a6f1c8ef24d7a9( host, args )
    {
        function_9995282d1a213141( host, 0 );
    }

    // Namespace namespace_fcff552b98571df1
    // Params 2, eflags: 0x4
    // Checksum 0xab970689, Offset: 0x174d
    // Size: 0x48, Type: dev
    function private function_2f3eecfa5a742d60( host, args )
    {
        for ( i = 0; i < 256 ; i++ )
        {
            host setplayerdata( "<dev string:x14c>", "<dev string:x14f>", i, 0 );
        }
    }

    // Namespace namespace_fcff552b98571df1
    // Params 2, eflags: 0x4
    // Checksum 0xad169344, Offset: 0x179d
    // Size: 0x5a, Type: dev
    function private function_6b14346b00be4ec5( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x58>" );
        var_e192ef1147f518ac.var_58dbee33b4330156 = !var_e192ef1147f518ac.var_58dbee33b4330156;
        level thread function_cfcc327299bb3865( var_e192ef1147f518ac.var_58dbee33b4330156 );
    }

    // Namespace namespace_fcff552b98571df1
    // Params 1, eflags: 0xc
    // Checksum 0xab856aa5, Offset: 0x17ff
    // Size: 0x3e, Type: dev
    function private function_cfcc327299bb3865( enabled )
    {
        self notify( #"hash_96b96c82924d2cdd" );
        self endon( #"hash_96b96c82924d2cdd" );
        
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

    // Namespace namespace_fcff552b98571df1
    // Params 0, eflags: 0x4
    // Checksum 0x6d0e75f2, Offset: 0x1845
    // Size: 0x3a3, Type: dev
    function private function_6664ee99684fe22d()
    {
        modeinfo = frun_free_run::function_97dc8f6dff0a9255();
        var_79a033234d11dea = "<dev string:x169>" + utility::function_6f5d2e1f1ff70482( modeinfo.var_44f7e6549b9e6660.var_586f225864ecfb50 ) + "<dev string:x177>" + utility::function_6f5d2e1f1ff70482( function_a3a4bf509f50b65e() );
        heightoffset = 100;
        printtoscreen2d( 75, heightoffset, var_79a033234d11dea, ( 1, 1, 1 ), 1.5 );
        finishposition = 0;
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x18d>", ( 1, 1, 1 ), 1.5 );
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x1ac>", ( 1, 1, 1 ), 1.5 );
        
        foreach ( finishinfo in modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730 )
        {
            finishposition++;
            spacer = finishposition < 10 ? "<dev string:x1be>" : "<dev string:x1c3>";
            player = player::getplayerforguid( finishinfo.guid );
            playerlabel = player ? player.name : finishinfo.guid;
            finishseconds = utility::function_6f5d2e1f1ff70482( finishinfo.var_da2142e8cf5376b6 );
            playerentry = finishposition + spacer + playerlabel + "<dev string:x1c7>" + finishseconds;
            heightoffset += 50;
            printtoscreen2d( 75, heightoffset, playerentry, ( 1, 1, 1 ), 1.5 );
        }
        
        var_bf75ec0e958132f4 = 0;
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x18d>", ( 1, 1, 1 ), 1.5 );
        heightoffset += 50;
        printtoscreen2d( 75, heightoffset, "<dev string:x1cb>", ( 1, 1, 1 ), 1.5 );
        
        foreach ( arriveinfo in modeinfo.var_2750a906451d1008 )
        {
            var_bf75ec0e958132f4++;
            spacer = var_bf75ec0e958132f4 < 10 ? "<dev string:x1be>" : "<dev string:x1c3>";
            var_4cc7a4743eb7f2b2 = arriveinfo.zoneindex + "<dev string:x14a>" + arriveinfo.checkpointindex;
            player = player::getplayerforguid( arriveinfo.guid );
            playerlabel = player ? player.name : arriveinfo.guid;
            arriveseconds = utility::function_6f5d2e1f1ff70482( arriveinfo.var_da2142e8cf5376b6 );
            playerentry = var_bf75ec0e958132f4 + spacer + playerlabel + "<dev string:x1c7>" + var_4cc7a4743eb7f2b2 + "<dev string:x1dc>" + arriveseconds;
            heightoffset += 50;
            printtoscreen2d( 75, heightoffset, playerentry, ( 1, 1, 1 ), 1.5 );
        }
    }

#/
