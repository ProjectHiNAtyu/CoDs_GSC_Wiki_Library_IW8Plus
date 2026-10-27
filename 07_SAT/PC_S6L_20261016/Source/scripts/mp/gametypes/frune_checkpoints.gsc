// scripts\mp\gametypes\frune_checkpoints.gsc  (hash_791d33f366fa4602.gscc) (size: 14839 Bytes / 0x39f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x132cebde (321711070)
// size ...... 14839 (0x39f7)
// includes .. 13  (offset: 0x37f7)
// strings ... 29  (offset: 0x385f)
// dev strs .. 3   (offset: 0x39d3)
// exports ... 41  (offset: 0x2447)
// cseg ...... 0x27f + 0x21c8 (0x2447)
// imports ... 115 (offset: 0x2aaf)
// animtree1 . 0   (offset: 0x39f7)
// animtree2 . 0   (offset: 0x39f7)
#using script_32ab226b6fbdeba;
#using script_3b5f1fa53313feda;
#using script_7e874027fd36f44f;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\flags;
#using scripts\mp\gametypes\frune_free_run_evo;
#using scripts\mp\gametypes\frune_telemetry;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;

#namespace frune_checkpoints;

// Namespace frune_checkpoints
// Params 0
// Checksum 0x61f636b4, Offset: 0x29d
// Size: 0x120
function init()
{
    level endon( #"game_ended" );
    level waittill( #"hash_f75c923c050b621d" );
    modeinfo = game[ #"frune_tuning" ];
    modeinfo.var_246cf322625e8f25 = getdvarint( @"hash_f14ead5fcfe846ec", modeinfo.frune_bundle.var_6e5f3d3a97e786c5 ?? 0 );
    modeinfo.var_24aac20c8e5544c5 = getdvarint( @"hash_a2f5d985e2697704", modeinfo.frune_bundle.var_8f0e55d6c8a55465 ?? 0 );
    modeinfo.var_71b7ca7563cc2b95 = getdvarint( @"hash_7db45d42a0d27ec2", modeinfo.frune_bundle.var_d1082a34e52a37f3 ?? 1 );
    modeinfo.var_44a07aa875eb41 = getdvarfloat( @"hash_8e81785a62a46190", modeinfo.frune_bundle.var_baafab3cc3e87e47 ?? 1000 );
    initcheckpoints();
    level notify( #"hash_557be8499a49cc19" );
    level thread function_b87286f6bbfe0628();
    level thread function_de9a70e5fb87150d();
}

// Namespace frune_checkpoints
// Params 0, eflags: 0x4
// Checksum 0x8bec8b09, Offset: 0x3c5
// Size: 0x2f5
function private initcheckpoints()
{
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    a_all_spawn_points = spawnlogic::function_491fcfcdc1232e11( spawnkey );
    
    if ( !isdefined( var_57fa145072c696b6 ) )
    {
        var_57fa145072c696b6 = [];
    }
    
    foreach ( spawnpoint in a_all_spawn_points )
    {
        spawnpoint.var_94373324515af0b7 = 0;
        
        if ( !isdefined( var_57fa145072c696b6[ spawnpoint.target ] ) )
        {
            var_57fa145072c696b6[ spawnpoint.target ] = [];
        }
        
        var_57fa145072c696b6[ spawnpoint.target ][ var_57fa145072c696b6[ spawnpoint.target ].size ] = spawnpoint;
    }
    
    checkpointindex = 0;
    zoneindex = 0;
    t_start_line = getent( "start_line", "script_noteworthy" );
    t_next_checkpoint = t_start_line;
    var_8d2785cd5614e129 = 0;
    
    while ( t_next_checkpoint )
    {
        if ( t_next_checkpoint.script_noteworthy == "zone_start" || t_next_checkpoint.script_noteworthy == "start_line" )
        {
            checkpointindex = 1;
            zoneindex++;
        }
        else
        {
            checkpointindex++;
        }
        
        t_next_checkpoint.zoneindex = zoneindex;
        t_next_checkpoint.checkpointindex = checkpointindex;
        t_next_checkpoint.var_59e2fdeca3342c99 = t_next_checkpoint.script_label == "backtrack";
        t_next_checkpoint.var_5fac99c61ce13251 = t_next_checkpoint.script_noteworthy == "wingsuit_checkpoint";
        t_next_checkpoint.flatindex = var_8d2785cd5614e129;
        var_8d2785cd5614e129 += 1;
        t_next_checkpoint thread function_2422938f1b6a12b7();
        t_next_checkpoint.a_spawn_points = var_57fa145072c696b6[ t_next_checkpoint.targetname ];
        str_checkpoint_label = "zone_" + t_next_checkpoint.zoneindex + "_checkpoint_" + t_next_checkpoint.checkpointindex;
        
        if ( t_next_checkpoint.a_spawn_points )
        {
            spawnlogic::registerspawnset( str_checkpoint_label, t_next_checkpoint.a_spawn_points, level.teams, str_checkpoint_label );
            spawnlogic::function_2e4fbfaa2e5bf603( str_checkpoint_label, str_checkpoint_label );
        }
        else
        {
            assertmsg( "<dev string:x24>" + str_checkpoint_label + "<dev string:x31>" );
        }
        
        function_2f33e2b4b9719312( t_next_checkpoint );
        function_9f32230402fa5453( t_next_checkpoint, t_next_checkpoint.zoneindex, t_next_checkpoint.checkpointindex );
        t_next_checkpoint = getent( t_next_checkpoint.target, "targetname" );
    }
    
    checkpointcount = max( game[ #"frune_tuning" ].var_afad088dc0cd7ba7.size ?? 1, 1 );
    setomnvar( o"ui_free_run_max_zones", checkpointcount );
    function_69fc6b1d75fe6daa();
}

// Namespace frune_checkpoints
// Params 3, eflags: 0x4
// Checksum 0x1290e17f, Offset: 0x6c2
// Size: 0xce
function private function_9f32230402fa5453( checkpoint, zone, checkpointindex )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.var_afad088dc0cd7ba7 ) )
    {
        modeinfo.var_afad088dc0cd7ba7 = [];
    }
    
    if ( !isdefined( modeinfo.var_afad088dc0cd7ba7[ zone ] ) )
    {
        modeinfo.var_afad088dc0cd7ba7[ zone ] = [];
    }
    
    checkpointinfo = { #checkpoint:checkpoint };
    modeinfo.var_afad088dc0cd7ba7[ zone ][ checkpointindex ] = checkpointinfo;
    
    if ( !isdefined( modeinfo.var_42dbfbf02021b4db ) )
    {
        modeinfo.var_42dbfbf02021b4db = [];
    }
    
    modeinfo.var_42dbfbf02021b4db[ checkpoint.flatindex ] = checkpoint;
}

// Namespace frune_checkpoints
// Params 0
// Checksum 0x3a6104a8, Offset: 0x798
// Size: 0x40
function function_879e36be517c8598()
{
    modeinfo = game[ #"frune_tuning" ];
    finalcheckpoint = modeinfo.var_42dbfbf02021b4db[ modeinfo.var_42dbfbf02021b4db.size - 1 ];
    return finalcheckpoint;
}

// Namespace frune_checkpoints
// Params 2
// Checksum 0xb1cad0b0, Offset: 0x7e1
// Size: 0x3c
function getcheckpoint( zoneindex, checkpointindex )
{
    modeinfo = game[ #"frune_tuning" ];
    return modeinfo.var_afad088dc0cd7ba7[ zoneindex ][ checkpointindex ];
}

// Namespace frune_checkpoints
// Params 1, eflags: 0x4
// Checksum 0x323d8bcf, Offset: 0x826
// Size: 0x34
function private function_2f33e2b4b9719312( checkpoint )
{
    checkpoint.pickuploadout = namespace_c41f357b2d127aee::function_1801310b8744ec73( checkpoint.zoneindex, checkpoint.checkpointindex );
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0x29d66d7f, Offset: 0x862
// Size: 0x54
function function_689377905ae386ba( vehicle )
{
    vehicleowner = vehicle.owningplayer;
    
    if ( vehicleowner && vehicle.classname == "script_vehicle" && isalive( vehicleowner ) && isplayer( vehicleowner ) )
    {
        return vehicleowner;
    }
}

// Namespace frune_checkpoints
// Params 0, eflags: 0x4
// Checksum 0x9dc4a691, Offset: 0x8bf
// Size: 0xa2
function private function_2422938f1b6a12b7()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", var_b37d5221d1f6697a );
        targetplayer = function_689377905ae386ba( var_b37d5221d1f6697a );
        
        if ( !targetplayer && isalive( var_b37d5221d1f6697a ) && isplayer( var_b37d5221d1f6697a ) )
        {
            targetplayer = var_b37d5221d1f6697a;
        }
        
        if ( !targetplayer )
        {
            continue;
        }
        
        if ( targetplayer.freeruninfo.var_391bebe82698b3d4 )
        {
            continue;
        }
        
        function_453eed18285c9df7( targetplayer, self, 0 );
        
        if ( function_2a11cd287cd4fdc1( self ) )
        {
            targetplayer thread frune_free_run_evo::function_e8f4bdacae514c81( targetplayer );
        }
    }
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0x494856fd, Offset: 0x969
// Size: 0x1d, Type: bool
function function_2a11cd287cd4fdc1( checkpoint )
{
    return checkpoint.targetname == "final_line_checkpoint";
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0xd8493b82, Offset: 0x98f
// Size: 0x7d
function function_829dfb8cf6166f33( player )
{
    if ( !player )
    {
        return;
    }
    
    player.freeruninfo.var_88b6290864fae386++;
    player utility::function_32b24db3127bff40( #"frune_checkpoint_reset", #"off" );
    player utility::function_32b24db3127bff40( #"frune_checkpoint_reset", #"on" );
    function_781cb0bf9fc5f096( player.freeruninfo.currentcheckpoint, player );
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0x9c4ed7d1, Offset: 0xa14
// Size: 0xd1
function function_9896bb059895d97( player )
{
    if ( !player )
    {
        return;
    }
    
    player utility::function_32b24db3127bff40( #"frune_checkpoint_skip", #"on" );
    var_eccc074cdf6009bd = function_d3a1f0eaf94950a5( player.freeruninfo.currentcheckpoint );
    player.freeruninfo.var_b068e106117c8b4e++;
    player.freeruninfo.var_f3f0c8973953f4d5 = 1;
    flatindex = var_eccc074cdf6009bd.checkpoint.flatindex;
    player.freeruninfo.var_a29dd559ee99f24d[ flatindex ] = 1;
    function_781cb0bf9fc5f096( var_eccc074cdf6009bd.checkpoint, player );
}

// Namespace frune_checkpoints
// Params 1, eflags: 0x4
// Checksum 0x1cb1ca49, Offset: 0xaed
// Size: 0x5c
function private function_d3a1f0eaf94950a5( checkpoint )
{
    var_428d1d0f5659eff3 = function_d48afbc252add92b( checkpoint.zoneindex, checkpoint.checkpointindex );
    var_eccc074cdf6009bd = function_93836aea1333e750( var_428d1d0f5659eff3.zoneindex, var_428d1d0f5659eff3.checkpointindex );
    return var_eccc074cdf6009bd;
}

// Namespace frune_checkpoints
// Params 2, eflags: 0x4
// Checksum 0x36bfe8c8, Offset: 0xb52
// Size: 0x9e
function private function_d48afbc252add92b( zoneindex, checkpointindex )
{
    freeruninfo = game[ #"frune_tuning" ];
    
    if ( freeruninfo.var_afad088dc0cd7ba7[ zoneindex ].size > checkpointindex )
    {
        nextzoneindex = zoneindex;
        var_428d1d0f5659eff3 = checkpointindex + 1;
    }
    else if ( freeruninfo.var_afad088dc0cd7ba7.size > zoneindex )
    {
        nextzoneindex = zoneindex + 1;
        var_428d1d0f5659eff3 = 1;
    }
    else
    {
        nextzoneindex = 1;
        var_428d1d0f5659eff3 = 1;
    }
    
    return { #checkpointindex:var_428d1d0f5659eff3, #zoneindex:nextzoneindex };
}

// Namespace frune_checkpoints
// Params 2
// Checksum 0x6fbe07f8, Offset: 0xbf9
// Size: 0x3d
function function_93836aea1333e750( zoneindex, checkpointindex )
{
    checkpointinfo = game[ #"frune_tuning" ].var_afad088dc0cd7ba7[ zoneindex ][ checkpointindex ];
    return checkpointinfo;
}

// Namespace frune_checkpoints
// Params 0, eflags: 0xc
// Checksum 0xecd229f5, Offset: 0xc3f
// Size: 0x10e
function private function_b87286f6bbfe0628()
{
    self notify( #"hash_7dd63569800d8c6b" );
    self endon( #"hash_7dd63569800d8c6b" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_246cf322625e8f25 == 0 && modeinfo.var_24aac20c8e5544c5 == 0 )
    {
        return;
    }
    
    var_a786d56bcce42b38 = modeinfo.var_afad088dc0cd7ba7[ modeinfo.var_246cf322625e8f25 ][ modeinfo.var_24aac20c8e5544c5 ];
    
    foreach ( player in level.players )
    {
        function_781cb0bf9fc5f096( var_a786d56bcce42b38.checkpoint, player );
    }
}

// Namespace frune_checkpoints
// Params 3
// Checksum 0x4f7894ad, Offset: 0xd55
// Size: 0x222
function function_453eed18285c9df7( player, checkpoint, var_bf0868dcb6a183fa )
{
    if ( !var_bf0868dcb6a183fa && checkpoint.var_5fac99c61ce13251 && !player.freeruninfo.wingsuitequipped )
    {
        return;
    }
    
    player.freeruninfo.var_caed4acc269c7041 = checkpoint.pickuploadout;
    namespace_c41f357b2d127aee::function_b90bc384cbf8537a( player, player.freeruninfo.var_caed4acc269c7041 );
    
    if ( checkpoint.zoneindex == player.freeruninfo.zoneindex && checkpoint.checkpointindex == player.freeruninfo.checkpointindex )
    {
        return;
    }
    
    var_4c50d2ec45f2389b = player.freeruninfo.zoneindex;
    var_b7a5d0257436641b = player.freeruninfo.checkpointindex;
    var_c8a1b8ec68dc0daf = player.freeruninfo.zoneindex < checkpoint.zoneindex;
    var_f30a019cb17e645 = var_4c50d2ec45f2389b == checkpoint.zoneindex && var_b7a5d0257436641b < checkpoint.checkpointindex;
    var_493fa46b6c2816e7 = var_c8a1b8ec68dc0daf || var_f30a019cb17e645;
    var_e71edf491faa3f73 = function_2a11cd287cd4fdc1( checkpoint );
    thread function_dd8d273a50f39ba6( player, checkpoint.zoneindex, var_c8a1b8ec68dc0daf, var_e71edf491faa3f73 );
    
    if ( !var_bf0868dcb6a183fa )
    {
        player thread function_b077483858a3fd5c( player, checkpoint, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 );
        function_5b1e5b2ea09adec1( player, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 );
    }
    
    var_42ed1da533f72298 = !namespace_27888f54e9b5bb16::function_1705192ef6e67ca7( player, checkpoint );
    
    if ( var_493fa46b6c2816e7 && var_42ed1da533f72298 )
    {
        function_f5d7a1e93e6ed0ef( player, checkpoint );
        function_5a7e4eec54c799e8( player, checkpoint );
        player thread frune_telemetry::function_7dfa050e71fb01c1( player );
    }
    else if ( var_493fa46b6c2816e7 || var_bf0868dcb6a183fa )
    {
        function_f5d7a1e93e6ed0ef( player, checkpoint );
    }
    
    namespace_27888f54e9b5bb16::function_a4e3a49755aa5bef();
}

// Namespace frune_checkpoints
// Params 2, eflags: 0x4
// Checksum 0x42876fa1, Offset: 0xf7f
// Size: 0xdf
function private function_5a7e4eec54c799e8( player, checkpoint )
{
    namespace_27888f54e9b5bb16::function_ad72883c191a0570( player, checkpoint );
    elapsedtimems = namespace_27888f54e9b5bb16::function_a3a4bf509f50b65e();
    
    if ( elapsedtimems > 0 )
    {
        namespace_27888f54e9b5bb16::function_1d78941edaf8827e( player, checkpoint.flatindex, elapsedtimems );
        
        if ( getdvarint( @"hash_6bd24a4ec4fcc4c3", 0 ) )
        {
            var_2343880007e2c9f = 0;
        }
        else
        {
            var_2343880007e2c9f = int( player getplayerdata( "mp", "fruneCheckpointBestTimesMS", checkpoint.flatindex ) ?? 0 );
        }
        
        if ( var_2343880007e2c9f > 0 )
        {
            delta = player.freeruninfo.var_f7f77add9ccca410[ checkpoint.flatindex ] - var_2343880007e2c9f;
            player setclientomnvar( o"ui_free_run_checkpoint_personal_best_delta", utility::function_6f5d2e1f1ff70482( delta ) );
        }
    }
}

// Namespace frune_checkpoints
// Params 4, eflags: 0xc
// Checksum 0xe7c9a15c, Offset: 0x1066
// Size: 0xfa
function private function_b077483858a3fd5c( player, checkpointreached, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 )
{
    self notify( #"hash_524f99b21f46572e" );
    self endon( #"hash_524f99b21f46572e" );
    modeinfo = game[ #"frune_tuning" ];
    scorethrottle = 0;
    
    for ( var_54134b699a2e720a = player.freeruninfo.var_57182f65a2d0b140 ?? 0; var_54134b699a2e720a < modeinfo.var_42dbfbf02021b4db.size ; var_54134b699a2e720a++ )
    {
        if ( var_54134b699a2e720a > checkpointreached.flatindex )
        {
            return;
        }
        
        checkpoint = modeinfo.var_42dbfbf02021b4db[ var_54134b699a2e720a ];
        player.freeruninfo.var_57182f65a2d0b140 = var_54134b699a2e720a;
        function_d9f5c99b3209bbd9( player, checkpoint );
        scorethrottle = ( scorethrottle + 1 ) % 8;
        
        if ( scorethrottle == 0 )
        {
            waitframe();
        }
    }
}

// Namespace frune_checkpoints
// Params 2, eflags: 0x4
// Checksum 0x63e3d56d, Offset: 0x1168
// Size: 0x11d
function private function_d9f5c99b3209bbd9( player, checkpoint )
{
    var_7e0c073eb0716e19 = !player.freeruninfo.var_a29dd559ee99f24d[ checkpoint.flatindex ];
    
    if ( var_7e0c073eb0716e19 )
    {
        player thread points::doscoreevent( #"hash_272e8355ecacb5c6" );
        challenges::function_20d2d944fbb9e725( player );
        player.freeruninfo.var_a29dd559ee99f24d[ checkpoint.flatindex ] = 1;
    }
    
    var_105fcfed0ce985be = checkpoint.checkpointindex == 1;
    
    if ( var_105fcfed0ce985be )
    {
        var_2b49eab638f9c2f1 = !player.freeruninfo.var_dd64197455956651[ checkpoint.zoneindex ];
        
        if ( checkpoint.zoneindex > 1 && var_2b49eab638f9c2f1 )
        {
            player thread points::doscoreevent( #"hash_4f2c4febed5ba073" );
            player.freeruninfo.var_dd64197455956651[ checkpoint.zoneindex ] = 1;
        }
    }
}

// Namespace frune_checkpoints
// Params 3, eflags: 0x4
// Checksum 0x2991cc2a, Offset: 0x128d
// Size: 0x88
function private function_5b1e5b2ea09adec1( player, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 )
{
    var_4b8953535b8bf4da = game[ #"frune_tuning" ].var_150cbad0a1859804;
    
    if ( var_c8a1b8ec68dc0daf )
    {
        player utility::function_32b24db3127bff40( #"frune_new_zone", #"on" );
        return;
    }
    
    if ( var_493fa46b6c2816e7 && var_4b8953535b8bf4da )
    {
        player utility::function_32b24db3127bff40( #"hash_f31edefc8140a233", #"on" );
    }
}

// Namespace frune_checkpoints
// Params 4, eflags: 0x4
// Checksum 0x1fb15f3f, Offset: 0x131d
// Size: 0xaf
function private function_dd8d273a50f39ba6( player, zoneindex, var_c8a1b8ec68dc0daf, var_f4ec16d7f40a032d )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !var_c8a1b8ec68dc0daf )
    {
        return;
    }
    
    freeruninfo = game[ #"frune_tuning" ];
    player setclientomnvar( o"ui_free_run_max_checkpoints", freeruninfo.var_afad088dc0cd7ba7[ zoneindex ].size ?? 0 );
    
    if ( !var_f4ec16d7f40a032d )
    {
        if ( zoneindex == 1 )
        {
            wait 4;
        }
        
        if ( player && isalive( player ) )
        {
            player hud_message::showsplash( "free_run_zone_tracker" );
        }
    }
}

// Namespace frune_checkpoints
// Params 2, eflags: 0x4
// Checksum 0x52c830e9, Offset: 0x13d4
// Size: 0x2a3
function private function_f5d7a1e93e6ed0ef( player, checkpoint )
{
    currenttimems = gettime();
    player.freeruninfo.var_2dbea8ea2c8af83b = player.freeruninfo.var_a882e795141bf183;
    player.freeruninfo.var_a882e795141bf183 = currenttimems;
    frune_free_run_evo::function_6f77d9609644f225( player );
    
    if ( player.freeruninfo.zoneindex != checkpoint.zoneindex )
    {
        player.freeruninfo.var_b2c9df167adcea1b = player.freeruninfo.var_5271a39f8b21d4a3;
        player.freeruninfo.var_5271a39f8b21d4a3 = currenttimems;
        outgoingzone = player.freeruninfo.zoneindex;
        
        if ( outgoingzone > 0 )
        {
            if ( !player.freeruninfo.var_f3f0c8973953f4d5 )
            {
                player.freeruninfo.var_18293adcc77e8ac5++;
            }
            else
            {
                player.freeruninfo.var_18293adcc77e8ac5 = 0;
            }
        }
        
        player.freeruninfo.var_f3f0c8973953f4d5 = 0;
        
        if ( player.freeruninfo.var_18293adcc77e8ac5 >= 3 )
        {
            challenges::function_bfa6ec40ac588a76( player );
            player.freeruninfo.var_18293adcc77e8ac5 = 0;
        }
    }
    
    player.freeruninfo.zoneindex = checkpoint.zoneindex;
    player.freeruninfo.checkpointindex = checkpoint.checkpointindex;
    player.freeruninfo.currentcheckpoint = checkpoint;
    player.freeruninfo.var_59e2fdeca3342c99 = checkpoint.var_59e2fdeca3342c99;
    namespace_27888f54e9b5bb16::function_a0cad25ab7e3540d();
    function_21ed31a9df94acb7( player, checkpoint.zoneindex, checkpoint.checkpointindex );
    function_137f5e6b9158c3f3( player, checkpoint.zoneindex, checkpoint.checkpointindex );
    function_c550caa7c086c7d2( player );
    function_378cb66b0a4cbe3d( player, checkpoint );
    player setclientomnvar( "ui_free_run_current_zone", checkpoint.zoneindex );
    player setclientomnvar( "ui_free_run_current_checkpoint", checkpoint.checkpointindex );
    player thread function_f1ff3437ca0de25b();
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0x534afe8e, Offset: 0x167f
// Size: 0xaf
function function_c550caa7c086c7d2( player )
{
    player stats::setextrascore0( player.freeruninfo.zoneindex ?? 1, "player_zone_index" );
    player stats::setextrascore1( player.freeruninfo.var_84b9cdcdd98678cb ?? 0, "player_fault_count" );
    
    if ( !player.freeruninfo.var_e86126071016f584 )
    {
        player.freeruninfo.var_e86126071016f584 = 1;
        var_f86607a638e6f785 = namespace_27888f54e9b5bb16::function_d1ac3daa005490d5( player );
        player stats::setextrascore2( var_f86607a638e6f785, "player_best_time_seconds" );
    }
}

// Namespace frune_checkpoints
// Params 0, eflags: 0xc
// Checksum 0xddcd50dd, Offset: 0x1736
// Size: 0x54
function private function_f1ff3437ca0de25b()
{
    self notify( #"hash_125501edb102784e" );
    self endon( #"hash_125501edb102784e" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_free_run_show_checkpoint_hit", 1 );
    wait 1;
    
    if ( !self )
    {
        return;
    }
    
    self setclientomnvar( "ui_free_run_show_checkpoint_hit", 0 );
}

// Namespace frune_checkpoints
// Params 2, eflags: 0x4
// Checksum 0x32d2e78a, Offset: 0x1792
// Size: 0x15c
function private function_378cb66b0a4cbe3d( player, checkpoint )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_71b7ca7563cc2b95 )
    {
        player.freeruninfo.activespawnpoint = checkpoint.a_spawn_points[ 0 ];
        return;
    }
    
    claimedcheckpoint = 0;
    
    foreach ( spawnpoint in checkpoint.a_spawn_points )
    {
        if ( !spawnpoint.var_94373324515af0b7 )
        {
            if ( player.freeruninfo.activespawnpoint )
            {
                player.freeruninfo.activespawnpoint.var_94373324515af0b7 = 0;
            }
            
            claimedcheckpoint = 1;
            spawnpoint.var_94373324515af0b7 = 1;
            player.freeruninfo.activespawnpoint = spawnpoint;
        }
    }
    
    assert( claimedcheckpoint, "<dev string:x52>" );
}

// Namespace frune_checkpoints
// Params 0
// Checksum 0x4a7ba1ea, Offset: 0x18f6
// Size: 0x46
function get_spawn_point()
{
    if ( self.freeruninfo.activespawnpoint )
    {
        return self.freeruninfo.activespawnpoint;
    }
    
    var_9ef48d240280a1c4 = spawnlogic::getstartspawnpoints();
    return spawnlogic::getspawnpoint_startspawn( var_9ef48d240280a1c4 );
}

// Namespace frune_checkpoints
// Params 0, eflags: 0xc
// Checksum 0x5fe2340, Offset: 0x1945
// Size: 0x10e
function private function_de9a70e5fb87150d()
{
    self notify( #"hash_9494df8fbf93baf1" );
    self endon( #"hash_9494df8fbf93baf1" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_freerun_start" );
    utility::delaycall( 1, &musicbank_utility::function_5aca66c390aa347d, level.players, #"hash_9bdc077c73dd04f2" );
    utility::flag_set( "frune_music_start" );
    namespace_27888f54e9b5bb16::function_341bd1e1d757b178();
    level thread namespace_27888f54e9b5bb16::function_853cc26a8cd32347();
    frune_telemetry::function_cda276c101c430d4();
    wait 1;
    
    foreach ( player in level.players )
    {
        player hud_message::showsplash( "free_run_evo_benchmark" );
    }
}

// Namespace frune_checkpoints
// Params 2
// Checksum 0x67d9702b, Offset: 0x1a5b
// Size: 0x21
function function_781cb0bf9fc5f096( checkpoint, player )
{
    function_fac532e61f9e8351( checkpoint, player, 0, 0 );
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0x6a32f1e3, Offset: 0x1a84
// Size: 0x2d
function function_aae76b5997fc6288( player )
{
    function_fac532e61f9e8351( player.freeruninfo.currentcheckpoint, player, 1, 0 );
}

// Namespace frune_checkpoints
// Params 1
// Checksum 0x9532af0f, Offset: 0x1ab9
// Size: 0x2d
function function_6c7105f996cfb744( player )
{
    function_fac532e61f9e8351( player.freeruninfo.currentcheckpoint, player, 0, 1 );
}

// Namespace frune_checkpoints
// Params 4, eflags: 0x4
// Checksum 0xdb5ad3e9, Offset: 0x1aee
// Size: 0x122
function private function_fac532e61f9e8351( checkpoint, player, var_7a8da02a977c0e3e, isfalldamage )
{
    if ( !player )
    {
        return;
    }
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    if ( player isspectatinganyone() || player.team == "spectator" || player.sessionstate == "spectator" )
    {
        return;
    }
    
    if ( !checkpoint )
    {
        return;
    }
    
    if ( player.freeruninfo.currentcheckpoint != checkpoint )
    {
        function_453eed18285c9df7( player, checkpoint, 1 );
    }
    
    if ( var_7a8da02a977c0e3e )
    {
        player utility::function_32b24db3127bff40( #"frune_fault", #"on" );
    }
    
    function_789e1abc18068628( player, checkpoint, var_7a8da02a977c0e3e, isfalldamage );
    currentspawnpoint = player get_spawn_point();
    function_bbd98e9afa4895de( player, player.freeruninfo.currentcheckpoint, currentspawnpoint );
    namespace_94a725a4853ac529::function_f6c7f9bb7bb8881d( player );
    namespace_c41f357b2d127aee::function_b90bc384cbf8537a( player, checkpoint.pickuploadout );
    namespace_c41f357b2d127aee::function_b51d5e13aaac51cf( player );
}

// Namespace frune_checkpoints
// Params 4, eflags: 0x4
// Checksum 0x8951875c, Offset: 0x1c18
// Size: 0x240
function private function_789e1abc18068628( player, checkpoint, var_7a8da02a977c0e3e, isfalldamage )
{
    nowms = gettime();
    
    if ( player.freeruninfo.var_481884b28566a5d7 == nowms )
    {
        return;
    }
    
    player.freeruninfo.var_481884b28566a5d7 = nowms;
    player.freeruninfo.var_84b9cdcdd98678cb++;
    player.freeruninfo.var_f3f0c8973953f4d5 = 1;
    
    if ( !isdefined( player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ] ) )
    {
        player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ] = [];
    }
    
    if ( !isdefined( player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ][ checkpoint.checkpointindex ] ) )
    {
        player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ][ checkpoint.checkpointindex ] = 0;
    }
    
    player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ][ checkpoint.checkpointindex ] += 1;
    
    if ( !isdefined( player.freeruninfo.var_546094b50f04eeba[ checkpoint.zoneindex ] ) )
    {
        player.freeruninfo.var_546094b50f04eeba[ checkpoint.zoneindex ] = 0;
    }
    
    player.freeruninfo.var_546094b50f04eeba[ checkpoint.zoneindex ] += 1;
    function_c550caa7c086c7d2( player );
    player thread frune_telemetry::function_3bca9cbf30164638( player, var_7a8da02a977c0e3e, isfalldamage );
}

// Namespace frune_checkpoints
// Params 2
// Checksum 0x579844e2, Offset: 0x1e60
// Size: 0x54
function function_a5c43a91dc8632ab( player, checkpoint )
{
    faultcount = player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ][ checkpoint.checkpointindex ] ?? 0;
    return faultcount;
}

// Namespace frune_checkpoints
// Params 2
// Checksum 0xbebcd367, Offset: 0x1ebd
// Size: 0x3f
function function_998a0c9a3974ea3( player, zoneindex )
{
    faultcount = player.freeruninfo.var_546094b50f04eeba[ zoneindex ] ?? 0;
    return faultcount;
}

// Namespace frune_checkpoints
// Params 0, eflags: 0x4
// Checksum 0xe6a3b054, Offset: 0x1f05
// Size: 0x14e
function private function_69fc6b1d75fe6daa()
{
    modeinfo = game[ #"frune_tuning" ];
    
    foreach ( checkpoint in modeinfo.var_42dbfbf02021b4db )
    {
        checkpointsuffix = checkpoint.zoneindex + "_" + checkpoint.checkpointindex;
        offsetstr = getdvar( hashcat( @"hash_1245eff96c8ca5c4", checkpointsuffix ), "" );
        
        if ( !offsetstr )
        {
            continue;
        }
        
        fields = strtok( offsetstr, "," );
        
        if ( fields.size < 3 )
        {
            continue;
        }
        
        x = float( fields[ 0 ] );
        y = float( fields[ 1 ] );
        z = float( fields[ 2 ] );
        checkpoint.origin += ( x, y, z );
    }
}

// Namespace frune_checkpoints
// Params 3
// Checksum 0x67f80b2f, Offset: 0x205b
// Size: 0x1eb
function function_bbd98e9afa4895de( player, checkpoint, spawnpoint )
{
    player thread function_8f2ed93c786cb2b7();
    player utility::function_bed40b09860f8227( 1 );
    player setvelocity( ( 0, 0, 0 ) );
    player function_5c764e554642cf04();
    player cancelmantle();
    player dropoffascender();
    player skydive_interrupt();
    player function_64f1800c957cf63c();
    
    while ( player && player isonascender() )
    {
        waitframe();
    }
    
    if ( !player )
    {
        return;
    }
    
    pbgpostfxbundlestart( player, "frun_teleport_death" );
    player stopgestureviewmodel();
    player utility::function_bed40b09860f8227( 0 );
    player dontinterpolate();
    
    if ( player.spawnedvehicle )
    {
        if ( player islinked() )
        {
            player lerpviewangleclamp( 0, 0, 0, 0, 0, 0, 0, 1 );
        }
        
        player.spawnedvehicle vehicle_teleport( spawnpoint.origin, spawnpoint.angles );
        player function_322635f31e0cf293( 1 );
    }
    else
    {
        player setorigin( spawnpoint.origin );
        player setvelocity( ( 0, 0, 0 ) );
        player setplayerangles( spawnpoint.angles );
        player setstance( "stand", 1, 1, 1 );
    }
    
    namespace_94a725a4853ac529::function_2e7b310429c9cfe5( player, checkpoint );
    
    if ( checkpoint.var_5fac99c61ce13251 )
    {
        modeinfo = game[ #"frune_tuning" ];
        pushdirection = anglestoforward( ( 0, spawnpoint.angles[ 1 ], 0 ) );
        pushvector = pushdirection * modeinfo.var_44a07aa875eb41;
        player setvelocity( pushvector );
        namespace_94a725a4853ac529::function_105c09e54abd16c2( player, checkpoint.var_a66b1fa9a85ebac8.var_ac8ee80b02649fcd );
    }
    else
    {
        player thread function_332c6380b92a56c2();
    }
    
    frune_free_run_evo::function_c19956ed01128b1d( player );
}

// Namespace frune_checkpoints
// Params 0, eflags: 0xc
// Checksum 0x439b97c2, Offset: 0x224e
// Size: 0x72
function private function_332c6380b92a56c2()
{
    self notify( #"hash_3cb8cd8c8869a167" );
    self endon( #"hash_3cb8cd8c8869a167" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    endtimems = gettime() + 250;
    
    while ( self )
    {
        if ( gettime() > endtimems )
        {
            return;
        }
        
        if ( self isonground() )
        {
            self setstance( "stand", 1, 1, 1 );
            return;
        }
        
        waitframe();
    }
}

// Namespace frune_checkpoints
// Params 0, eflags: 0xc
// Checksum 0x8223b5e6, Offset: 0x22c8
// Size: 0x50
function private function_8f2ed93c786cb2b7()
{
    self notify( #"hash_59b943004805a567" );
    self endon( #"hash_59b943004805a567" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.falldamageprotection = 1;
    wait 1;
    
    if ( !self )
    {
        return;
    }
    
    self.falldamageprotection = 0;
}

// Namespace frune_checkpoints
// Params 3, eflags: 0x4
// Checksum 0xd0c614c2, Offset: 0x2320
// Size: 0xd5
function private function_21ed31a9df94acb7( player, zoneindex, checkpointindex )
{
    var_b12e379fc5e202df = 3;
    var_b12e389fc5e20512 = 5;
    var_a7f9c0db5d3366b5 = 14;
    var_b12e399fc5e20745 = 6;
    var_88b466b50af2930a = 7;
    
    if ( zoneindex == var_b12e379fc5e202df )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"hash_9bdc067c73dd033f" );
        return;
    }
    
    if ( zoneindex == var_b12e389fc5e20512 && var_a7f9c0db5d3366b5 == checkpointindex )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"hash_2679acd7d1676b26" );
        return;
    }
    
    if ( zoneindex == var_b12e399fc5e20745 )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"hash_9bdc057c73dd018c" );
        return;
    }
    
    if ( zoneindex == var_88b466b50af2930a )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"mp_freerun_complete" );
    }
}

// Namespace frune_checkpoints
// Params 3, eflags: 0x4
// Checksum 0xb27974c6, Offset: 0x23fd
// Size: 0x4a
function private function_137f5e6b9158c3f3( player, zoneindex, checkpointindex )
{
    if ( zoneindex == 5 && checkpointindex >= 15 )
    {
        player setsoundsubmix( "mp_sat_freerun_tunnel_submix" );
        return;
    }
    
    player clearsoundsubmix( "mp_sat_freerun_tunnel_submix" );
}

