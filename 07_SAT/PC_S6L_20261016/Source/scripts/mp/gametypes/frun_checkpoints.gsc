// scripts\mp\gametypes\frun_checkpoints.gsc  (hash_223a7dcb8f1c31b9.gscc) (size: 18388 Bytes / 0x47d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x11c01447 (297800775)
// size ...... 18388 (0x47d4)
// includes .. 13  (offset: 0x44f4)
// strings ... 40  (offset: 0x455c)
// dev strs .. 8   (offset: 0x4774)
// exports ... 46  (offset: 0x2f2c)
// cseg ...... 0x3a9 + 0x2b83 (0x2f2c)
// imports ... 123 (offset: 0x365c)
// animtree1 . 0   (offset: 0x47d4)
// animtree2 . 0   (offset: 0x47d4)
#using script_2be31009a4044baf;
#using script_76f51e444edfa58f;
#using script_77eccf1055ba6c0;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\flags;
#using scripts\mp\gametypes\frun_free_run;
#using scripts\mp\gametypes\frun_telemetry;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;

#namespace frun_checkpoints;

// Namespace frun_checkpoints
// Params 0
// Checksum 0xa50ca6a1, Offset: 0x3c7
// Size: 0x11c
function init()
{
    level endon( #"game_ended" );
    level waittill( #"hash_f75c923c050b621d" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_246cf322625e8f25 = getdvarint( @"hash_34c0c92e9277fe81", modeinfo.frun_bundle.var_571fdefd3bcdfe42 ?? 0 );
    modeinfo.var_24aac20c8e5544c5 = getdvarint( @"hash_2934252bd1dcfa9", modeinfo.frun_bundle.var_2d70b67f8defe1e2 ?? 0 );
    modeinfo.var_71b7ca7563cc2b95 = getdvarint( @"hash_47ce6c9fea1f675f", modeinfo.frun_bundle.var_5bed36d0dd8c8158 ?? 0 );
    modeinfo.var_44a07aa875eb41 = getdvarfloat( @"hash_24f2bad15dd5b38b", modeinfo.frun_bundle.var_159508ff2ba29e32 ?? 1000 );
    initcheckpoints();
    function_a5014cf09fbe8971();
    function_2391b41c53f9038f();
    level thread function_b87286f6bbfe0628();
    level thread function_de9a70e5fb87150d();
}

// Namespace frun_checkpoints
// Params 0, eflags: 0x4
// Checksum 0x1df84801, Offset: 0x4eb
// Size: 0x2fb
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
        t_next_checkpoint.var_5fac99c61ce13251 = t_next_checkpoint.script_parameters == "wingsuit_required";
        t_next_checkpoint.flatindex = var_8d2785cd5614e129;
        var_8d2785cd5614e129 += 1;
        t_next_checkpoint thread function_5364db96ccf17970();
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
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    checkpointcount = max( modeinfo.var_afad088dc0cd7ba7.size ?? 1, 1 );
    setomnvar( o"ui_free_run_max_zones", checkpointcount );
    function_69fc6b1d75fe6daa();
}

// Namespace frun_checkpoints
// Params 3, eflags: 0x4
// Checksum 0xbae45263, Offset: 0x7ee
// Size: 0xc9
function private function_9f32230402fa5453( checkpoint, zone, checkpointindex )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace frun_checkpoints
// Params 2
// Checksum 0x19be63ac, Offset: 0x8bf
// Size: 0x37
function getcheckpoint( zoneindex, checkpointindex )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    return modeinfo.var_afad088dc0cd7ba7[ zoneindex ][ checkpointindex ];
}

// Namespace frun_checkpoints
// Params 1, eflags: 0x4
// Checksum 0x580aade, Offset: 0x8ff
// Size: 0x34
function private function_2f33e2b4b9719312( checkpoint )
{
    checkpoint.pickuploadout = namespace_e36fb96d2958d7cd::function_1801310b8744ec73( checkpoint.zoneindex, checkpoint.checkpointindex );
}

// Namespace frun_checkpoints
// Params 0, eflags: 0x4
// Checksum 0x72758937, Offset: 0x93b
// Size: 0x7b
function private function_5364db96ccf17970()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", var_b37d5221d1f6697a );
        
        if ( isalive( var_b37d5221d1f6697a ) && isplayer( var_b37d5221d1f6697a ) && !var_b37d5221d1f6697a.freeruninfo.var_391bebe82698b3d4 )
        {
            function_453eed18285c9df7( var_b37d5221d1f6697a, self, 0 );
            
            if ( function_2a11cd287cd4fdc1( self ) )
            {
                var_b37d5221d1f6697a thread frun_free_run::function_e8f4bdacae514c81( var_b37d5221d1f6697a );
            }
        }
    }
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0xe30bd290, Offset: 0x9be
// Size: 0x1d, Type: bool
function function_2a11cd287cd4fdc1( checkpoint )
{
    return checkpoint.targetname == "final_line_checkpoint";
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0xe4db2020, Offset: 0x9e4
// Size: 0x7d
function function_829dfb8cf6166f33( player )
{
    if ( !player )
    {
        return;
    }
    
    player.freeruninfo.var_88b6290864fae386++;
    player utility::function_32b24db3127bff40( #"frun_checkpoint_reset", #"off" );
    player utility::function_32b24db3127bff40( #"frun_checkpoint_reset", #"on" );
    function_781cb0bf9fc5f096( player.freeruninfo.currentcheckpoint, player );
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0xda19ad8b, Offset: 0xa69
// Size: 0xd1
function function_9896bb059895d97( player )
{
    if ( !player )
    {
        return;
    }
    
    player utility::function_32b24db3127bff40( #"frun_checkpoint_skip", #"on" );
    var_eccc074cdf6009bd = function_d3a1f0eaf94950a5( player.freeruninfo.currentcheckpoint );
    player.freeruninfo.var_b068e106117c8b4e++;
    player.freeruninfo.var_f3f0c8973953f4d5 = 1;
    flatindex = var_eccc074cdf6009bd.checkpoint.flatindex;
    player.freeruninfo.var_a29dd559ee99f24d[ flatindex ] = 1;
    function_781cb0bf9fc5f096( var_eccc074cdf6009bd.checkpoint, player );
}

// Namespace frun_checkpoints
// Params 1, eflags: 0x4
// Checksum 0xb6f24e24, Offset: 0xb42
// Size: 0x5c
function private function_d3a1f0eaf94950a5( checkpoint )
{
    var_428d1d0f5659eff3 = function_d48afbc252add92b( checkpoint.zoneindex, checkpoint.checkpointindex );
    var_eccc074cdf6009bd = function_93836aea1333e750( var_428d1d0f5659eff3.zoneindex, var_428d1d0f5659eff3.checkpointindex );
    return var_eccc074cdf6009bd;
}

// Namespace frun_checkpoints
// Params 2, eflags: 0x4
// Checksum 0x9ecb5bd4, Offset: 0xba7
// Size: 0x99
function private function_d48afbc252add92b( zoneindex, checkpointindex )
{
    freeruninfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace frun_checkpoints
// Params 2
// Checksum 0xc7cab4e4, Offset: 0xc49
// Size: 0x38
function function_93836aea1333e750( zoneindex, checkpointindex )
{
    checkpointinfo = frun_free_run::function_97dc8f6dff0a9255().var_afad088dc0cd7ba7[ zoneindex ][ checkpointindex ];
    return checkpointinfo;
}

// Namespace frun_checkpoints
// Params 0, eflags: 0xc
// Checksum 0xd2770526, Offset: 0xc8a
// Size: 0x109
function private function_b87286f6bbfe0628()
{
    self notify( #"hash_2cbe5424387be2be" );
    self endon( #"hash_2cbe5424387be2be" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace frun_checkpoints
// Params 4
// Checksum 0x6be84d, Offset: 0xd9b
// Size: 0x1e9
function function_453eed18285c9df7( player, checkpoint, var_3d9410a387ca814d, var_bf0868dcb6a183fa )
{
    if ( checkpoint.zoneindex == player.freeruninfo.zoneindex && checkpoint.checkpointindex == player.freeruninfo.checkpointindex )
    {
        return;
    }
    
    if ( !var_bf0868dcb6a183fa && checkpoint.var_5fac99c61ce13251 && !player.freeruninfo.wingsuitequipped )
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
        function_4a5568af18c10f6e( player, checkpoint, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 );
        function_5b1e5b2ea09adec1( player, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 );
    }
    
    if ( var_3d9410a387ca814d )
    {
        function_f5d7a1e93e6ed0ef( player, checkpoint );
    }
    else if ( var_493fa46b6c2816e7 )
    {
        function_f5d7a1e93e6ed0ef( player, checkpoint );
        function_5a7e4eec54c799e8( player, checkpoint );
        player thread frun_telemetry::function_7dfa050e71fb01c1( player );
    }
    
    namespace_fcff552b98571df1::function_a4e3a49755aa5bef();
    namespace_e36fb96d2958d7cd::function_b90bc384cbf8537a( player, player.freeruninfo.var_caed4acc269c7041 );
}

// Namespace frun_checkpoints
// Params 2, eflags: 0x4
// Checksum 0xb70a940a, Offset: 0xf8c
// Size: 0xc8
function private function_5a7e4eec54c799e8( player, checkpoint )
{
    namespace_fcff552b98571df1::function_ad72883c191a0570( player, checkpoint );
    elapsedtimems = namespace_fcff552b98571df1::function_a3a4bf509f50b65e();
    
    if ( elapsedtimems > 0 )
    {
        namespace_fcff552b98571df1::function_1d78941edaf8827e( player, checkpoint.flatindex, elapsedtimems );
        var_2343880007e2c9f = int( player getplayerdata( "mp", "frunCheckpointBestTimesMS", checkpoint.flatindex ) ?? 0 );
        
        if ( var_2343880007e2c9f > 0 )
        {
            delta = player.freeruninfo.var_f7f77add9ccca410[ checkpoint.flatindex ] - var_2343880007e2c9f;
            player setclientomnvar( o"ui_free_run_checkpoint_personal_best_delta", utility::function_6f5d2e1f1ff70482( delta ) );
        }
    }
}

// Namespace frun_checkpoints
// Params 4, eflags: 0x4
// Checksum 0x1f911174, Offset: 0x105c
// Size: 0xc0
function private function_4a5568af18c10f6e( player, checkpointreached, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    for ( var_54134b699a2e720a = player.freeruninfo.var_57182f65a2d0b140 ?? 0; var_54134b699a2e720a < modeinfo.var_42dbfbf02021b4db.size ; var_54134b699a2e720a++ )
    {
        if ( var_54134b699a2e720a > checkpointreached.flatindex )
        {
            return;
        }
        
        checkpoint = modeinfo.var_42dbfbf02021b4db[ var_54134b699a2e720a ];
        player.freeruninfo.var_57182f65a2d0b140 = var_54134b699a2e720a;
        function_d9f5c99b3209bbd9( player, checkpoint );
    }
}

// Namespace frun_checkpoints
// Params 2, eflags: 0x4
// Checksum 0xc9a05100, Offset: 0x1124
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

// Namespace frun_checkpoints
// Params 3, eflags: 0x4
// Checksum 0x79b1f836, Offset: 0x1249
// Size: 0x83
function private function_5b1e5b2ea09adec1( player, var_c8a1b8ec68dc0daf, var_493fa46b6c2816e7 )
{
    var_4b8953535b8bf4da = frun_free_run::function_97dc8f6dff0a9255().var_150cbad0a1859804;
    
    if ( var_c8a1b8ec68dc0daf )
    {
        player utility::function_32b24db3127bff40( #"frun_new_zone", #"on" );
        return;
    }
    
    if ( var_493fa46b6c2816e7 && var_4b8953535b8bf4da )
    {
        player utility::function_32b24db3127bff40( #"frun_new_checkpoint", #"on" );
    }
}

// Namespace frun_checkpoints
// Params 4, eflags: 0x4
// Checksum 0xb7c5ec23, Offset: 0x12d4
// Size: 0xaa
function private function_dd8d273a50f39ba6( player, zoneindex, var_c8a1b8ec68dc0daf, var_f4ec16d7f40a032d )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !var_c8a1b8ec68dc0daf )
    {
        return;
    }
    
    freeruninfo = frun_free_run::function_97dc8f6dff0a9255();
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

// Namespace frun_checkpoints
// Params 2, eflags: 0x4
// Checksum 0xb4a4c13f, Offset: 0x1386
// Size: 0x2bb
function private function_f5d7a1e93e6ed0ef( player, checkpoint )
{
    currenttimems = gettime();
    player.freeruninfo.var_2dbea8ea2c8af83b = player.freeruninfo.var_a882e795141bf183;
    player.freeruninfo.var_a882e795141bf183 = currenttimems;
    
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
    player.freeruninfo.var_caed4acc269c7041 = checkpoint.pickuploadout;
    namespace_fcff552b98571df1::function_a0cad25ab7e3540d();
    function_21ed31a9df94acb7( player, checkpoint.zoneindex, checkpoint.checkpointindex );
    function_137f5e6b9158c3f3( player, checkpoint.zoneindex, checkpoint.checkpointindex );
    function_c550caa7c086c7d2( player );
    function_378cb66b0a4cbe3d( player, checkpoint );
    player setclientomnvar( "ui_free_run_current_zone", checkpoint.zoneindex );
    player setclientomnvar( "ui_free_run_current_checkpoint", checkpoint.checkpointindex );
    player thread function_f1ff3437ca0de25b();
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0x213e3ba9, Offset: 0x1649
// Size: 0xaf
function function_c550caa7c086c7d2( player )
{
    player stats::setextrascore0( player.freeruninfo.zoneindex ?? 1, "player_zone_index" );
    player stats::setextrascore1( player.freeruninfo.var_84b9cdcdd98678cb ?? 0, "player_fault_count" );
    
    if ( !player.freeruninfo.var_e86126071016f584 )
    {
        player.freeruninfo.var_e86126071016f584 = 1;
        var_f86607a638e6f785 = namespace_fcff552b98571df1::function_d1ac3daa005490d5( player );
        player stats::setextrascore2( var_f86607a638e6f785, "player_best_time_seconds" );
    }
}

// Namespace frun_checkpoints
// Params 0, eflags: 0xc
// Checksum 0x778ed4b0, Offset: 0x1700
// Size: 0x54
function private function_f1ff3437ca0de25b()
{
    self notify( #"hash_3c5cfe717a3b130f" );
    self endon( #"hash_3c5cfe717a3b130f" );
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

// Namespace frun_checkpoints
// Params 2, eflags: 0x4
// Checksum 0xc77cb59, Offset: 0x175c
// Size: 0x157
function private function_378cb66b0a4cbe3d( player, checkpoint )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace frun_checkpoints
// Params 0
// Checksum 0xe0382587, Offset: 0x18bb
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

// Namespace frun_checkpoints
// Params 0, eflags: 0xc
// Checksum 0xadc4b848, Offset: 0x190a
// Size: 0x10e
function private function_de9a70e5fb87150d()
{
    self notify( #"hash_c9fcdf74ef8d0a7d" );
    self endon( #"hash_c9fcdf74ef8d0a7d" );
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_freerun_start" );
    utility::delaycall( 1, &musicbank_utility::function_5aca66c390aa347d, level.players, #"hash_9bdc077c73dd04f2" );
    utility::flag_set( "frun_music_start" );
    namespace_fcff552b98571df1::function_341bd1e1d757b178();
    level thread namespace_fcff552b98571df1::function_853cc26a8cd32347();
    frun_telemetry::function_cda276c101c430d4();
    wait 1;
    
    foreach ( player in level.players )
    {
        player hud_message::showsplash( "free_run_benchmark" );
    }
}

// Namespace frun_checkpoints
// Params 0, eflags: 0x4
// Checksum 0xfbdbabbd, Offset: 0x1a20
// Size: 0x26f
function private function_a5014cf09fbe8971()
{
    /#
        var_5bf349e1e9de1a4f = ( 0, 0, 0 );
        var_67ce164c6605b3f0 = ( 100, 300, 500 );
        angles = ( 0, 0, 0 );
        function_64ff19cdc4f4210e( "<dev string:x8c>", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, "<dev string:x9d>", 1, 1, 3 );
    #/
    
    var_5bf349e1e9de1a4f = ( -4350, -1800, 7250 );
    var_67ce164c6605b3f0 = ( 150, 1600, 100 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "pool_edge_01", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -2900, -3400, 7250 );
    var_67ce164c6605b3f0 = ( 1600, 150, 100 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "pool_edge_02", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -1600, -1800, 7250 );
    var_67ce164c6605b3f0 = ( 150, 1600, 100 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "pool_edge_03", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -2900, -200, 7250 );
    var_67ce164c6605b3f0 = ( 1600, 150, 100 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "pool_edge_04", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -6500, 1500, 11000 );
    var_67ce164c6605b3f0 = ( 1800, 150, 700 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "wingsuit_start_01", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -5700, 2600, 11000 );
    var_67ce164c6605b3f0 = ( 2400, 150, 700 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "wingsuit_start_02", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -8000, 2000, 11000 );
    var_67ce164c6605b3f0 = ( 150, 2000, 700 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "wingsuit_start_03", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
    var_5bf349e1e9de1a4f = ( -5300, 2000, 10900 );
    var_67ce164c6605b3f0 = ( 500, 600, 300 );
    angles = ( 0, 0, 0 );
    function_64ff19cdc4f4210e( "wingsuit_start_04", var_5bf349e1e9de1a4f, var_67ce164c6605b3f0, angles, undefined, 0, undefined, undefined );
}

// Namespace frun_checkpoints
// Params 8, eflags: 0x4
// Checksum 0xcb508bd8, Offset: 0x1c97
// Size: 0x114
function private function_64ff19cdc4f4210e( targetname, var_3941bc5c13322d9e, var_67ce164c6605b3f0, angles, var_3d6a1a85fa4c99e6, var_5fac99c61ce13251, var_9bdca9e20b45de1b, var_defa4e1809f8bd9b )
{
    var_42cf502b6d79c11c = spawn( "trigger_box", var_3941bc5c13322d9e, 0, var_67ce164c6605b3f0, var_67ce164c6605b3f0 );
    var_42cf502b6d79c11c.targetname = targetname;
    var_42cf502b6d79c11c.angles = angles;
    var_42cf502b6d79c11c.script_noteworthy = "kill";
    var_42cf502b6d79c11c.script_label = var_5fac99c61ce13251 ? "wingsuit_required" : undefined;
    var_42cf502b6d79c11c.isscripted = 1;
    
    if ( function_b6e966c8f8346c15( var_3d6a1a85fa4c99e6 ) && var_9bdca9e20b45de1b && var_defa4e1809f8bd9b )
    {
        var_42cf502b6d79c11c.script_parameters = var_3d6a1a85fa4c99e6;
        var_dbde0eb9148a5d9d = getcheckpoint( var_9bdca9e20b45de1b, var_defa4e1809f8bd9b );
        var_42cf502b6d79c11c.target = var_dbde0eb9148a5d9d.checkpoint.targetname;
    }
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0x71610ebb, Offset: 0x1db3
// Size: 0x63
function function_b6e966c8f8346c15( var_3d6a1a85fa4c99e6 )
{
    if ( !var_3d6a1a85fa4c99e6 )
    {
        return 0;
    }
    
    switch ( var_3d6a1a85fa4c99e6 )
    {
        case #"hash_adb1cd289479419c":
        case #"hash_b3c007b3f6f8b165":
        case #"hash_bf0b551225d7e040":
            return 1;
        default:
            assertmsg( "<dev string:xc2>" + var_3d6a1a85fa4c99e6 );
            return 0;
    }
}

// Namespace frun_checkpoints
// Params 0, eflags: 0x4
// Checksum 0xe2536f3, Offset: 0x1e1e
// Size: 0x3b1
function private function_2391b41c53f9038f()
{
    killzonelist = getentarray( "kill", "script_noteworthy" );
    
    foreach ( var_42cf502b6d79c11c in killzonelist )
    {
        targetname = var_42cf502b6d79c11c.targetname;
        
        if ( targetname )
        {
            var_94f507c4cee24d37 = hashcat( @"hash_1c73e8bf72bc26fd", targetname );
            dvardisabled = getdvarint( var_94f507c4cee24d37, 0 );
            
            if ( dvardisabled )
            {
                continue;
            }
        }
        
        if ( isdefined( var_42cf502b6d79c11c.script_label ) )
        {
            switch ( var_42cf502b6d79c11c.script_label )
            {
                case #"hash_5212723eea4ea3a1":
                    var_42cf502b6d79c11c.var_5fac99c61ce13251 = 1;
                    break;
                default:
                    assertmsg( "<dev string:xef>" + var_42cf502b6d79c11c.script_group + "<dev string:x106>" );
                    break;
            }
        }
        
        if ( isdefined( var_42cf502b6d79c11c.target ) && var_42cf502b6d79c11c.target != "" )
        {
            var_5a9c48a0186c1117 = getent( var_42cf502b6d79c11c.target, "targetname" );
            
            if ( function_b6e966c8f8346c15( var_42cf502b6d79c11c.script_parameters ) && var_5a9c48a0186c1117 )
            {
                switch ( var_42cf502b6d79c11c.script_parameters )
                {
                    case #"hash_bf0b551225d7e040":
                        var_42cf502b6d79c11c.var_7d2a381382af2584 = var_5a9c48a0186c1117.zoneindex;
                        var_42cf502b6d79c11c.var_23b6e02ec1962b54 = var_5a9c48a0186c1117.checkpointindex;
                        break;
                    case #"hash_b3c007b3f6f8b165":
                        var_42cf502b6d79c11c.var_7f6b8b00be70706 = var_5a9c48a0186c1117.zoneindex;
                        var_42cf502b6d79c11c.var_aa316401a0aed86 = var_5a9c48a0186c1117.checkpointindex;
                        break;
                    case #"hash_adb1cd289479419c":
                        var_42cf502b6d79c11c.var_ba156ddd023dd332 = var_5a9c48a0186c1117.zoneindex;
                        var_42cf502b6d79c11c.var_faff550e7091af5a = var_5a9c48a0186c1117.checkpointindex;
                        break;
                }
            }
            else
            {
                var_33fb6384e0bc0010 = utility::getstructarray( var_42cf502b6d79c11c.target, "targetname" );
                
                foreach ( connectedstruct in var_33fb6384e0bc0010 )
                {
                    if ( connectedstruct.script_noteworthy == "killzone_on" )
                    {
                        var_5a9c48a0186c1117 = getent( connectedstruct.target, "targetname" );
                        var_42cf502b6d79c11c.var_7d2a381382af2584 = var_5a9c48a0186c1117.zoneindex;
                        var_42cf502b6d79c11c.var_23b6e02ec1962b54 = var_5a9c48a0186c1117.checkpointindex;
                        continue;
                    }
                    
                    if ( connectedstruct.script_noteworthy == "killzone_off" )
                    {
                        var_5a9c48a0186c1117 = getent( connectedstruct.target, "targetname" );
                        var_42cf502b6d79c11c.var_7f6b8b00be70706 = var_5a9c48a0186c1117.zoneindex;
                        var_42cf502b6d79c11c.var_aa316401a0aed86 = var_5a9c48a0186c1117.checkpointindex;
                    }
                }
            }
        }
        
        function_639d5f2e618b926f( var_42cf502b6d79c11c );
        var_42cf502b6d79c11c thread function_100349365d8368c();
    }
}

// Namespace frun_checkpoints
// Params 1, eflags: 0x4
// Checksum 0x45466d58, Offset: 0x21d7
// Size: 0x169
function private function_639d5f2e618b926f( var_42cf502b6d79c11c )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.killzonelist ) )
    {
        modeinfo.killzonelist = [];
    }
    
    if ( var_42cf502b6d79c11c.var_7d2a381382af2584 && var_42cf502b6d79c11c.var_23b6e02ec1962b54 )
    {
        var_9083c1d9e333ef44 = modeinfo.var_afad088dc0cd7ba7[ var_42cf502b6d79c11c.var_7d2a381382af2584 ][ var_42cf502b6d79c11c.var_23b6e02ec1962b54 ];
    }
    
    if ( var_42cf502b6d79c11c.var_7f6b8b00be70706 && var_42cf502b6d79c11c.var_aa316401a0aed86 )
    {
        var_d9d2c167551d546a = modeinfo.var_afad088dc0cd7ba7[ var_42cf502b6d79c11c.var_7f6b8b00be70706 ][ var_42cf502b6d79c11c.var_aa316401a0aed86 ];
    }
    
    if ( var_42cf502b6d79c11c.var_ba156ddd023dd332 && var_42cf502b6d79c11c.var_faff550e7091af5a )
    {
        var_3df6b9a672d36926 = modeinfo.var_afad088dc0cd7ba7[ var_42cf502b6d79c11c.var_ba156ddd023dd332 ][ var_42cf502b6d79c11c.var_faff550e7091af5a ];
    }
    
    killzoneinfo = { #var_3df6b9a672d36926:var_3df6b9a672d36926, #var_d9d2c167551d546a:var_d9d2c167551d546a, #var_9083c1d9e333ef44:var_9083c1d9e333ef44, #var_42cf502b6d79c11c:var_42cf502b6d79c11c };
    modeinfo.killzonelist[ modeinfo.killzonelist.size ] = killzoneinfo;
}

// Namespace frun_checkpoints
// Params 0, eflags: 0x4
// Checksum 0xa3a95b76, Offset: 0x2348
// Size: 0x82
function private function_100349365d8368c()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", var_b37d5221d1f6697a );
        
        if ( !isplayer( var_b37d5221d1f6697a ) || !isalive( var_b37d5221d1f6697a ) || var_b37d5221d1f6697a.freeruninfo.var_59e2fdeca3342c99 )
        {
            continue;
        }
        
        if ( function_319f1cee3a98304f( var_b37d5221d1f6697a, self ) )
        {
            function_aae76b5997fc6288( var_b37d5221d1f6697a );
            var_b37d5221d1f6697a notify( #"frun_killzone_death" );
        }
    }
}

// Namespace frun_checkpoints
// Params 2
// Checksum 0x5b4b6b89, Offset: 0x23d2
// Size: 0x21
function function_781cb0bf9fc5f096( checkpoint, player )
{
    function_fac532e61f9e8351( checkpoint, player, 0, 0 );
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0x56a0ea41, Offset: 0x23fb
// Size: 0x2d
function function_aae76b5997fc6288( player )
{
    function_fac532e61f9e8351( player.freeruninfo.currentcheckpoint, player, 1, 0 );
}

// Namespace frun_checkpoints
// Params 1
// Checksum 0xa9a0b4ad, Offset: 0x2430
// Size: 0x2d
function function_6c7105f996cfb744( player )
{
    function_fac532e61f9e8351( player.freeruninfo.currentcheckpoint, player, 0, 1 );
}

// Namespace frun_checkpoints
// Params 4, eflags: 0x4
// Checksum 0x1a39f6a0, Offset: 0x2465
// Size: 0x124
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
        function_453eed18285c9df7( player, checkpoint, 0, 1 );
    }
    
    if ( var_7a8da02a977c0e3e )
    {
        player utility::function_32b24db3127bff40( #"frun_fault", #"on" );
    }
    
    function_789e1abc18068628( player, checkpoint, var_7a8da02a977c0e3e, isfalldamage );
    currentspawnpoint = player get_spawn_point();
    function_bbd98e9afa4895de( player, player.freeruninfo.currentcheckpoint, currentspawnpoint );
    namespace_e36fb96d2958d7cd::function_b90bc384cbf8537a( player, player.freeruninfo.var_caed4acc269c7041 );
    namespace_e36fb96d2958d7cd::function_b51d5e13aaac51cf( player );
}

// Namespace frun_checkpoints
// Params 4, eflags: 0x4
// Checksum 0x1508dde4, Offset: 0x2591
// Size: 0x1fc
function private function_789e1abc18068628( player, checkpoint, var_7a8da02a977c0e3e, isfalldamage )
{
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
    player thread frun_telemetry::function_3bca9cbf30164638( player, var_7a8da02a977c0e3e, isfalldamage );
}

// Namespace frun_checkpoints
// Params 2
// Checksum 0xfddbc08f, Offset: 0x2795
// Size: 0x54
function function_a5c43a91dc8632ab( player, checkpoint )
{
    faultcount = player.freeruninfo.var_e9402cc2764ece1a[ checkpoint.zoneindex ][ checkpoint.checkpointindex ] ?? 0;
    return faultcount;
}

// Namespace frun_checkpoints
// Params 2
// Checksum 0x14ff570a, Offset: 0x27f2
// Size: 0x3f
function function_998a0c9a3974ea3( player, zoneindex )
{
    faultcount = player.freeruninfo.var_546094b50f04eeba[ zoneindex ] ?? 0;
    return faultcount;
}

// Namespace frun_checkpoints
// Params 2
// Checksum 0x3d10ac5, Offset: 0x283a
// Size: 0x1d9, Type: bool
function function_319f1cee3a98304f( player, var_42cf502b6d79c11c )
{
    var_25aec1fa1cee3985 = player.freeruninfo.zoneindex;
    currentcheckpoint = player.freeruninfo.checkpointindex;
    
    if ( isdefined( var_42cf502b6d79c11c.var_7d2a381382af2584 ) && isdefined( var_42cf502b6d79c11c.var_23b6e02ec1962b54 ) )
    {
        var_5356a009a56bbc32 = var_25aec1fa1cee3985 > var_42cf502b6d79c11c.var_7d2a381382af2584;
        var_cdc54b9b62bcc60e = var_25aec1fa1cee3985 == var_42cf502b6d79c11c.var_7d2a381382af2584 && currentcheckpoint >= var_42cf502b6d79c11c.var_23b6e02ec1962b54;
        overmin = var_5356a009a56bbc32 || var_cdc54b9b62bcc60e;
    }
    else
    {
        overmin = 1;
    }
    
    if ( isdefined( var_42cf502b6d79c11c.var_7f6b8b00be70706 ) && isdefined( var_42cf502b6d79c11c.var_aa316401a0aed86 ) )
    {
        var_817e9dc6299e35f4 = var_25aec1fa1cee3985 < var_42cf502b6d79c11c.var_7f6b8b00be70706;
        var_13b7839d5357528 = var_25aec1fa1cee3985 == var_42cf502b6d79c11c.var_7f6b8b00be70706 && currentcheckpoint < var_42cf502b6d79c11c.var_aa316401a0aed86;
        undermax = var_817e9dc6299e35f4 || var_13b7839d5357528;
    }
    else
    {
        undermax = 1;
    }
    
    if ( isdefined( var_42cf502b6d79c11c.var_ba156ddd023dd332 ) && isdefined( var_42cf502b6d79c11c.var_faff550e7091af5a ) )
    {
        var_f770c1906521788e = var_42cf502b6d79c11c.var_ba156ddd023dd332 == var_25aec1fa1cee3985 && var_42cf502b6d79c11c.var_faff550e7091af5a == currentcheckpoint;
    }
    else
    {
        var_f770c1906521788e = 1;
    }
    
    var_a84d4a7a164d2350 = !var_42cf502b6d79c11c.var_5fac99c61ce13251 || player.freeruninfo.wingsuitequipped;
    return overmin && undermax && var_f770c1906521788e && var_a84d4a7a164d2350;
}

// Namespace frun_checkpoints
// Params 0, eflags: 0x4
// Checksum 0x4ed70348, Offset: 0x2a1c
// Size: 0x149
function private function_69fc6b1d75fe6daa()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
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

// Namespace frun_checkpoints
// Params 3
// Checksum 0x45364ece, Offset: 0x2b6d
// Size: 0x1a2
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
    player setorigin( spawnpoint.origin );
    player setvelocity( ( 0, 0, 0 ) );
    player setplayerangles( spawnpoint.angles );
    player setstance( "stand", 1, 1, 1 );
    
    if ( isdefined( checkpoint.var_635026ea67b026d1 ) )
    {
        player namespace_29443a521c37a7fc::function_1ca79e09e9f633d2();
        player namespace_29443a521c37a7fc::function_a144ec87d3acc2ad( checkpoint.var_635026ea67b026d1 );
    }
    
    if ( checkpoint.var_5fac99c61ce13251 )
    {
        modeinfo = frun_free_run::function_97dc8f6dff0a9255();
        playerangles = player getplayerangles( 1 );
        pushdirection = anglestoforward( ( 0, playerangles[ 1 ], 0 ) );
        pushvector = pushdirection * modeinfo.var_44a07aa875eb41;
        player setvelocity( pushvector );
        namespace_29443a521c37a7fc::function_105c09e54abd16c2( player );
    }
    else
    {
        player thread function_332c6380b92a56c2();
    }
    
    frun_free_run::function_c19956ed01128b1d( player );
}

// Namespace frun_checkpoints
// Params 0, eflags: 0xc
// Checksum 0xe9d813af, Offset: 0x2d17
// Size: 0x72
function private function_332c6380b92a56c2()
{
    self notify( #"hash_ba91dcf4109273f4" );
    self endon( #"hash_ba91dcf4109273f4" );
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

// Namespace frun_checkpoints
// Params 0, eflags: 0xc
// Checksum 0x2860318b, Offset: 0x2d91
// Size: 0x50
function private function_8f2ed93c786cb2b7()
{
    self notify( #"hash_ecc16563f7231cd8" );
    self endon( #"hash_ecc16563f7231cd8" );
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

// Namespace frun_checkpoints
// Params 3, eflags: 0x4
// Checksum 0x8e95c64, Offset: 0x2de9
// Size: 0xe9
function private function_21ed31a9df94acb7( player, zoneindex, checkpointindex )
{
    var_b12e379fc5e202df = 5;
    var_b12e389fc5e20512 = 9;
    var_a7f9c0db5d3366b5 = 16;
    var_b12e399fc5e20745 = 9;
    var_766786c3d2b81050 = 17;
    var_88b466b50af2930a = 11;
    
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
    
    if ( zoneindex == var_b12e399fc5e20745 && var_766786c3d2b81050 == checkpointindex )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"hash_9bdc057c73dd018c" );
        return;
    }
    
    if ( zoneindex == var_88b466b50af2930a )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"mp_freerun_complete" );
    }
}

// Namespace frun_checkpoints
// Params 3, eflags: 0x4
// Checksum 0x6a563c36, Offset: 0x2eda
// Size: 0x52
function private function_137f5e6b9158c3f3( player, zoneindex, checkpointindex )
{
    if ( zoneindex == 10 )
    {
        if ( checkpointindex >= 6 && checkpointindex < 9 )
        {
            player setsoundsubmix( "mp_sat_freerun_tunnel_submix" );
            return;
        }
        
        player clearsoundsubmix( "mp_sat_freerun_tunnel_submix" );
    }
}

