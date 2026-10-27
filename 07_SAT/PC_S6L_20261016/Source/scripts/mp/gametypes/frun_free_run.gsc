// scripts\mp\gametypes\frun_free_run.gsc  (hash_73f8a94f71cc2f5c.gscc) (size: 25975 Bytes / 0x6577 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39b31a7 (60502439)
// size ...... 25975 (0x6577)
// includes .. 30  (offset: 0x5d47)
// strings ... 36  (offset: 0x5e37)
// dev strs .. 92  (offset: 0x6033)
// exports ... 66  (offset: 0x3a9b)
// cseg ...... 0x386 + 0x3715 (0x3a9b)
// imports ... 203 (offset: 0x44eb)
// animtree1 . 0   (offset: 0x6577)
// animtree2 . 0   (offset: 0x6577)
#using script_2be31009a4044baf;
#using script_44280f644740bac;
#using script_76f51e444edfa58f;
#using script_77eccf1055ba6c0;
#using scripts\common\scripted_widgets;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\frun_checkpoints;
#using scripts\mp\gametypes\frun_cinematics;
#using scripts\mp\gametypes\frun_collectible;
#using scripts\mp\gametypes\frun_fx;
#using scripts\mp\gametypes\frun_shootable_target;
#using scripts\mp\gametypes\frun_telemetry;
#using scripts\mp\gametypes\frun_vo;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;

#namespace frun_free_run;

// Namespace frun_free_run
// Params 0
// Checksum 0x2626a1d4, Offset: 0x3a4
// Size: 0x5bc
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.frun_bundle ) )
    {
        modeinfo.frun_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frun" );
    }
    
    modeinfo.var_ce9f827624de9f5f = getdvarint( @"hash_f27bccfc433f996e", modeinfo.frun_bundle.var_d19a8b17b7f2af1f ?? 0 );
    modeinfo.var_2ddfe36056b858d0 = getdvarfloat( @"hash_61387ee68bfc3d65", modeinfo.frun_bundle.var_cea93b93d1113a76 ?? 4 );
    modeinfo.var_e5db2ad69bda179b = getdvarint( @"hash_2641411787f55d8e", modeinfo.frun_bundle.var_e2bb2b402686b13f ?? 0 );
    modeinfo.var_42de21d3a24f6797 = getdvarint( @"hash_d1f477e612770abe", modeinfo.frun_bundle.var_fc4191fd80f54d4f ?? 1 );
    modeinfo.var_b1501e30fc6ffc70 = getdvarint( @"hash_7362840f69876bf6", modeinfo.frun_bundle.frun_player_racing_trail_enabled ?? 1 );
    modeinfo.var_aa4094dbfbb439f1 = getdvarint( @"hash_9249cda93c203798", modeinfo.frun_bundle.var_8b8c6f490143b4ef ?? 1 );
    modeinfo.var_cdcc4702644fb40d = getdvarint( @"hash_123ad719a99e09e5", modeinfo.frun_bundle.var_c7b3235073530d58 ?? 3 );
    modeinfo.var_b6baa88473a824e1 = getdvarint( @"hash_c00a74167c009831", modeinfo.frun_bundle.var_dbf81f0e1ea27a00 ?? 1 );
    modeinfo.var_62e75879d10527f3 = getdvarint( @"hash_48ba50dfca709fcd", modeinfo.frun_bundle.var_626e0e0adf10321a ?? 0 );
    modeinfo.var_1f482f42b0072192 = getdvarint( @"hash_4a2f6be70dc206da", modeinfo.frun_bundle.var_dc5da62ee26d5805 ?? 0 );
    modeinfo.var_1c5b086d3bc7aead = getdvarint( @"hash_b9d98adb53b4c312", modeinfo.frun_bundle.var_bb61a6cbad58cb7f ?? 1 );
    modeinfo.var_495800f29bb0acd4 = getdvarint( @"hash_82b5feb13894cc51", modeinfo.frun_bundle.frun_checkpoint_reset_enabled ?? 1 );
    modeinfo.var_ec90ab50128015c = getdvarint( @"hash_efb684e1b7c8aa99", modeinfo.frun_bundle.frun_checkpoint_skip_enabled ?? 1 );
    modeinfo.var_f6a177f6d3e62463 = getdvarint( @"hash_12cad4887bdba15e", modeinfo.frun_bundle.var_7883a58cb49ae5a1 ?? 30000 );
    modeinfo.var_979cf85c0f407975 = getdvarint( @"hash_5f2f5c87816813fa", modeinfo.frun_bundle.var_52d1c05bc66ef65d ?? 0 );
    modeinfo.var_97f19e1eeb7a467c = getdvarfloat( @"hash_7f28cbab1b5b0948", modeinfo.frun_bundle.var_a7fc6090e4a67d45 ?? 2 );
    modeinfo.var_7deb2b87c100328c = getdvarint( @"hash_293658e24c25fdc7", 1 );
    modeinfo.var_150cbad0a1859804 = getdvarint( @"hash_d54462d250b0692c", modeinfo.frun_bundle.var_62b664cbf07116fd ?? 0 );
    level.var_702ea1a2fc683e54 = getdvarint( @"hash_a04518df9d9f211e", getmatchrulesdata( "commonOption", "overrideScoringOnKillsFFA" ) ?? 0 );
    level.onstartgametype = &onstartgametype;
    level.n_total_players = 0;
    level.var_b301fb5fca6e1388 = [];
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.getspawnpoint = &frun_checkpoints::get_spawn_point;
    level.ontimelimit = &ontimelimit;
    level.endgame = &endmatch;
    level.modeonspawnplayer = &onplayerspawn;
    level.onplayerdamaged = &onplayerdamaged;
    level.var_29c1e82ec1325523 = &function_bb8b355d1daea488;
    level.var_5e94a673782a6314 = &function_8bd80b07029ff212;
    level.modifyplayerdamage = &modifyplayerdamage;
    level.blockweapondrops = 1;
    level.overridetimelimitclock = 10;
    level.disableforfeit = 1;
    level.var_578fa1a580a1bc21 = &function_49d74288e86abd6d;
    disconnect_event_aggregator::function_f460203966e88ab0( &function_ce323339907d05fa );
    
    if ( isdefined( level.var_2d26813259dde738 ) )
    {
        level thread [[ level.var_2d26813259dde738 ]]();
    }
    
    /#
        level thread init_debug_free_run();
    #/
    
    level thread frun_checkpoints::init();
    level thread namespace_e36fb96d2958d7cd::init();
    level thread namespace_fcff552b98571df1::init();
    level thread frun_telemetry::init();
    level thread frun_shootable_target::init();
    level thread namespace_29443a521c37a7fc::init();
    level thread frun_cinematics::init();
    level thread frun_vo::init();
    level thread frun_fx::init();
    
    if ( modeinfo.var_7deb2b87c100328c )
    {
        level thread frun_collectible::init();
    }
    
    utility::registersharedfunc( #"frun_challenges", #"hash_25c85cd46694dd52", &function_efb4d650159d4cb );
}

// Namespace frun_free_run
// Params 0
// Checksum 0x8b5e244f, Offset: 0x968
// Size: 0x21
function function_97dc8f6dff0a9255()
{
    if ( !isdefined( level.freeruninfo ) )
    {
        level.freeruninfo = {};
    }
    
    return level.freeruninfo;
}

// Namespace frun_free_run
// Params 2
// Checksum 0xc0489d15, Offset: 0x992
// Size: 0x69
function function_efb4d650159d4cb( player, additionaleventparams = [] )
{
    additionaleventparams[ #"kill_amount" ] = player.freeruninfo.var_84b9cdcdd98678cb ?? 0;
    additionaleventparams[ #"reload_amount" ] = player.freeruninfo.var_b068e106117c8b4e ?? 0;
    return additionaleventparams;
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0x404b2d6, Offset: 0xa04
// Size: 0xb
function private initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0xcbd1ed81, Offset: 0xa17
// Size: 0x1e0
function private onplayerconnect( player )
{
    if ( !level.gameended && player.pers[ #"hash_728cbcbfbe4a7f9c" ] == #"stopped" )
    {
        player.pers[ #"hash_728cbcbfbe4a7f9c" ] = #"started";
    }
    
    player.current_weapon = undefined;
    player.freeruninfo = { #var_f3f0c8973953f4d5:0, #var_18293adcc77e8ac5:0, #var_88b6290864fae386:0, #var_b068e106117c8b4e:0, #var_dd64197455956651:[], #var_a29dd559ee99f24d:[], #var_f7f77add9ccca410:[], #var_546094b50f04eeba:[], #var_e9402cc2764ece1a:[], #var_84b9cdcdd98678cb:0, #var_328df64682b9ec5c:0, #var_59e2fdeca3342c99:0, #var_b2c9df167adcea1b:0, #var_5271a39f8b21d4a3:0, #var_2dbea8ea2c8af83b:0, #var_a882e795141bf183:0, #checkpointindex:0, #zoneindex:0 };
    player thread namespace_e36fb96d2958d7cd::function_3abb5b856fc03d10();
    player thread namespace_e36fb96d2958d7cd::function_35a441a1867a3b39( player );
    player thread namespace_e36fb96d2958d7cd::function_1c6d21480ed20b1f( player );
    player thread function_e65cb2300b1d85( player );
    player thread function_ab5196100d625c8a( player );
    player thread function_be99deec6a154153( player );
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_7deb2b87c100328c )
    {
        player frun_collectible::function_cbc2bc1bb506cbcd();
    }
    
    namespace_fcff552b98571df1::function_a4e3a49755aa5bef();
    
    if ( utility::flag( "frun_music_start" ) )
    {
        musicbank_utility::function_5aca66c390aa347d( player, #"mp_freerun_start" );
        utility::delaycall( 1, &musicbank_utility::function_5aca66c390aa347d, player, #"hash_9bdc077c73dd04f2" );
    }
    
    frun_checkpoints::function_c550caa7c086c7d2( player );
    player setsoundsubmix( "mp_sat_freerun_submix" );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x41607fc1, Offset: 0xbff
// Size: 0x253
function private function_e65cb2300b1d85( player )
{
    player endon( #"death_or_disconnect" );
    modeinfo = function_97dc8f6dff0a9255();
    var_593840112d599ff4 = modeinfo.var_1c5b086d3bc7aead && modeinfo.var_ec90ab50128015c;
    
    if ( var_593840112d599ff4 )
    {
        if ( !isdefined( promptwidget ) )
        {
            promptwidget = scripted_widgets::function_652736891a41e948( "scripted_widget_input_prompts_frun_checkpoints" );
        }
        
        player thread scripted_widgets::create( "scripted_widget_input_prompts_frun_checkpoints", promptwidget );
    }
    
    while ( player && player isconnected() )
    {
        skipavailable = function_686b97d7146deee6( player );
        resetavailable = function_94d5ac71bb49712e( player );
        var_d9f2beaee4f21ad0 = utility::function_6f5d2e1f1ff70482( modeinfo.var_f6a177f6d3e62463 - namespace_fcff552b98571df1::function_76ba268d368eed64( player ) );
        var_cfad14f67f04859a = max( 0, var_d9f2beaee4f21ad0 );
        
        /#
            if ( modeinfo.var_62e75879d10527f3 )
            {
                if ( modeinfo.var_ec90ab50128015c )
                {
                    var_e3d5677f0a91914c = "<dev string:x24>" + var_cfad14f67f04859a;
                    var_5eef2e9bc55aa5fa = skipavailable ? ( 1, 1, 1 ) : ( 0.75, 0.75, 0.75 );
                    printtoscreen2d( 75, 1000, var_e3d5677f0a91914c, var_5eef2e9bc55aa5fa, 2 );
                }
                
                if ( modeinfo.var_495800f29bb0acd4 )
                {
                    var_dfb68417983a2af4 = "<dev string:x32>";
                    var_81c0616c052fcb72 = resetavailable ? ( 1, 1, 1 ) : ( 0.75, 0.75, 0.75 );
                    printtoscreen2d( 75, 1050, var_dfb68417983a2af4, var_81c0616c052fcb72, 2 );
                }
            }
        #/
        
        if ( var_593840112d599ff4 )
        {
            if ( skipavailable )
            {
                player thread scripted_widgets::function_981da8ea23741d2c( "scripted_widget_input_prompts_frun_checkpoints", #"nextcheckpoint" );
            }
            else
            {
                player thread scripted_widgets::function_17cb4d316aab4821( "scripted_widget_input_prompts_frun_checkpoints", #"nextcheckpoint" );
            }
            
            if ( resetavailable )
            {
                player thread scripted_widgets::function_981da8ea23741d2c( "scripted_widget_input_prompts_frun_checkpoints", #"resetcheckpoint" );
            }
            else
            {
                player thread scripted_widgets::function_17cb4d316aab4821( "scripted_widget_input_prompts_frun_checkpoints", #"resetcheckpoint" );
            }
        }
        
        player setclientomnvar( "ui_free_run_checkpoint_skip_seconds_disabled", var_cfad14f67f04859a );
        player setclientomnvar( "ui_free_run_checkpoint_skip_enabled", skipavailable );
        player setclientomnvar( "ui_free_run_checkpoint_reset_enabled", resetavailable );
        waitframe();
    }
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0xc4abfe, Offset: 0xe5a
// Size: 0xbe
function private function_ab5196100d625c8a( player )
{
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_1f482f42b0072192 )
    {
        player notifyonplayercommand( "skip_to_next_checkpoint", "+frag" );
        player notifyonplayercommand( "reset_to_current_checkpoint", "+smoke" );
    }
    
    /#
        if ( !modeinfo.var_1f482f42b0072192 && modeinfo.var_62e75879d10527f3 && !isbot( player ) )
        {
            player notifyonplayercommand( "<dev string:x3b>", "<dev string:x53>" );
            player notifyonplayercommand( "<dev string:x61>", "<dev string:x7d>" );
            player notifyonplayercommand( "<dev string:x3b>", "<dev string:x8b>" );
            player notifyonplayercommand( "<dev string:x61>", "<dev string:x92>" );
        }
    #/
}

// Namespace frun_free_run
// Params 1, eflags: 0xc
// Checksum 0xf234675a, Offset: 0xf20
// Size: 0xee
function private function_be99deec6a154153( player )
{
    self notify( #"hash_52c67ea8967e0924" );
    self endon( #"hash_52c67ea8967e0924" );
    
    while ( player )
    {
        player.freeruninfo.var_200b73194ecf6485 = 0;
        inputevent = player utility::waittill_any_return( "skip_to_next_checkpoint", "reset_to_current_checkpoint" );
        
        if ( !inputevent || !player )
        {
            continue;
        }
        
        switch ( inputevent )
        {
            case #"hash_191c68929c8adca9":
                function_c5d13dd7e4d7f44b( player );
                break;
            case #"hash_296cfc637f982569":
                function_86ab1aeb8d15373( player );
                break;
            default:
                break;
        }
        
        modeinfo = function_97dc8f6dff0a9255();
        player.freeruninfo.var_200b73194ecf6485 = 1;
        wait modeinfo.var_97f19e1eeb7a467c;
    }
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x4e2a1210, Offset: 0x1016
// Size: 0xfe, Type: bool
function private function_686b97d7146deee6( player )
{
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_ec90ab50128015c )
    {
        return false;
    }
    
    if ( player.freeruninfo.var_200b73194ecf6485 )
    {
        return false;
    }
    
    if ( namespace_fcff552b98571df1::function_76ba268d368eed64( player ) <= modeinfo.var_f6a177f6d3e62463 )
    {
        return false;
    }
    
    zoneindex = player.freeruninfo.zoneindex;
    checkpointindex = player.freeruninfo.checkpointindex;
    
    if ( !( isdefined( zoneindex ) && isdefined( checkpointindex ) ) || zoneindex <= 1 && checkpointindex <= 1 )
    {
        return false;
    }
    
    var_e54fdf152a7e7fbb = player.freeruninfo.var_e9402cc2764ece1a[ zoneindex ][ checkpointindex ] ?? 0;
    
    if ( var_e54fdf152a7e7fbb < modeinfo.var_979cf85c0f407975 )
    {
        return false;
    }
    
    return true;
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0xb86132ff, Offset: 0x111d
// Size: 0x2c
function private function_c5d13dd7e4d7f44b( player )
{
    if ( !function_686b97d7146deee6( player ) )
    {
        return;
    }
    
    player thread frun_telemetry::function_254ea37e913e3c00( player );
    frun_checkpoints::function_9896bb059895d97( player );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x22402bb6, Offset: 0x1151
// Size: 0x4b, Type: bool
function private function_94d5ac71bb49712e( player )
{
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_495800f29bb0acd4 )
    {
        return false;
    }
    
    if ( player.freeruninfo.var_200b73194ecf6485 )
    {
        return false;
    }
    
    return true;
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x8453e9fc, Offset: 0x11a5
// Size: 0x2c
function private function_86ab1aeb8d15373( player )
{
    if ( !function_94d5ac71bb49712e( player ) )
    {
        return;
    }
    
    player thread frun_telemetry::function_560b21c5a425f69e( player );
    frun_checkpoints::function_829dfb8cf6166f33( player );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x61462f77, Offset: 0x11d9
// Size: 0x2b
function private onplayerdisconnect( player )
{
    level thread frun_telemetry::function_b90947072f2f81c1( player );
    player thread scripted_widgets::destroy( "scripted_widget_input_prompts_frun_checkpoints" );
    namespace_fcff552b98571df1::function_a4e3a49755aa5bef();
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0xfcd8a5fe, Offset: 0x120c
// Size: 0x24
function private function_49d74288e86abd6d()
{
    if ( namespace_fcff552b98571df1::function_28ad61cb6b5e840c( self ) )
    {
        return self.freeruninfo.var_328df64682b9ec5c;
    }
    
    return gettime();
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x45776c41, Offset: 0x1239
// Size: 0xac
function private function_ce323339907d05fa( player )
{
    player game_utility::stopkeyearning( level.endgamewinner ?? "all" );
    
    if ( level.gameended || player.matchbonus > 0 )
    {
        return;
    }
    
    if ( !namespace_fcff552b98571df1::function_28ad61cb6b5e840c( player ) )
    {
        return;
    }
    
    var_ae3586f008b36f1 = ( gettime() - ( game[ "startTimeFromMatchStart" ] ?? 0 ) ) / 1000;
    playerscore = player gamelogic_mp::calculatematchbonus( #"win", var_ae3586f008b36f1 );
    player.matchbonus = playerscore;
    player gamelogic_mp::givematchbonus( "win", playerscore );
}

// Namespace frun_free_run
// Params 11, eflags: 0x4
// Checksum 0xba331c3d, Offset: 0x12ed
// Size: 0x92
function private modifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( isplayer( eattacker ) )
    {
        return 0;
    }
    
    if ( smeansofdeath == "MOD_FALLING" )
    {
        if ( idamage >= 100 )
        {
            victim thread function_a95e26639e732b21( victim );
        }
        
        return 0;
    }
    
    return idamage;
}

// Namespace frun_free_run
// Params 1, eflags: 0xc
// Checksum 0x48c4313, Offset: 0x1388
// Size: 0x2d
function private function_a95e26639e732b21( player )
{
    self notify( #"hash_6d391cda9ef635fd" );
    self endon( #"hash_6d391cda9ef635fd" );
    frun_checkpoints::function_6c7105f996cfb744( player );
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0x78823a7a, Offset: 0x13bd
// Size: 0x158
function private onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( entry, &"hash_2a05930690271b49" );
    }
    
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_e2bf4a9ddf11bc78( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start", "mp_dm_spawn_start", undefined, 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary", "mp_dm_spawn" );
        spawnlogic::function_9bd2654564d3372d( #"fallback", #"fallback", "mp_tdm_spawn_secondary", undefined, 1 );
    }
    
    spawnlogic::finalizemap();
    level.quickmessagetoall = 1;
    
    if ( isdefined( level.var_dba053ed1cfdefa0 ) )
    {
        level thread [[ level.var_dba053ed1cfdefa0 ]]();
    }
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0xd3d6fbd8, Offset: 0x151d
// Size: 0x49
function private onplayerspawn( spawndata )
{
    level notify( #"spawned_player" );
    thread function_7d4110829f4ddb5();
    thread function_afe6d42eac36bc69();
    thread function_4d6cfee0485fdbc1();
    namespace_fcff552b98571df1::function_a4e3a49755aa5bef();
    thread namespace_29443a521c37a7fc::function_ca7da31bda8e254c();
    thread namespace_29443a521c37a7fc::function_183ded8ab72ea1da();
    thread namespace_29443a521c37a7fc::function_a7538c20aa2dd747();
}

// Namespace frun_free_run
// Params 0
// Checksum 0x65d524df, Offset: 0x156e
// Size: 0x8c
function function_4d6cfee0485fdbc1()
{
    self waittill( #"giveloadout" );
    
    if ( !self )
    {
        return;
    }
    
    perk::giveperk( "specialty_no_target" );
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_42de21d3a24f6797 )
    {
        perk::giveperk( "specialty_adaptive_ads_speed" );
    }
    
    val::set( "frun_player_val", "collide_with_players", 0 );
    val::set( "frun_player_val", "ignore_ascender_collision", 1 );
    val::set( "frun_player_val", "weapon_switch", 0 );
    function_c19956ed01128b1d( self );
}

// Namespace frun_free_run
// Params 0
// Checksum 0x75e573b4, Offset: 0x1602
// Size: 0x41
function function_7d4110829f4ddb5()
{
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.1;
    
    if ( !self )
    {
        return;
    }
    
    namespace_e36fb96d2958d7cd::function_b90bc384cbf8537a( self, self.freeruninfo.var_caed4acc269c7041 );
}

// Namespace frun_free_run
// Params 0
// Checksum 0xa1044d4b, Offset: 0x164b
// Size: 0x5f
function function_afe6d42eac36bc69()
{
    self endon( #"game_ended" );
    self endon( #"disconnect" );
    val::set( "toggle_execution", "execution_attack", 0 );
    self function_3181733c19782bcc( 0 );
    self function_134cd2c60d3a7edf( 0 );
    self waittill( #"giveloadout" );
    
    if ( !self )
    {
        return;
    }
    
    val::set( "toggle_execution", "execution_attack", 0 );
}

// Namespace frun_free_run
// Params 6, eflags: 0x4
// Checksum 0xb9b41d37, Offset: 0x16b2
// Size: 0x39
function private onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    
}

// Namespace frun_free_run
// Params 15, eflags: 0x4
// Checksum 0x26421af0, Offset: 0x16f3
// Size: 0x8a
function private onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0x300d4648, Offset: 0x1785
// Size: 0x9
function private ontimelimit()
{
    thread function_3b70154f87c66b9d();
}

// Namespace frun_free_run
// Params 1
// Checksum 0x557c6896, Offset: 0x1796
// Size: 0x64
function function_c19956ed01128b1d( player )
{
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_b1501e30fc6ffc70 )
    {
        return;
    }
    
    player utility::function_32b24db3127bff40( #"frun_player_racing_trail", #"off" );
    player utility::function_32b24db3127bff40( #"frun_player_racing_trail", #"on" );
}

// Namespace frun_free_run
// Params 1
// Checksum 0xd05895c9, Offset: 0x1802
// Size: 0xbb
function function_e8f4bdacae514c81( player )
{
    level endon( #"game_ended" );
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( namespace_fcff552b98571df1::function_28ad61cb6b5e840c( player ) )
    {
        return;
    }
    
    player thread frun_telemetry::function_ae6206f684bbf151( player );
    namespace_fcff552b98571df1::function_b5fd5ae9eb439ed5( player );
    namespace_fcff552b98571df1::function_a4e3a49755aa5bef();
    setomnvar( o"ui_free_run_num_players_finished", modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730.size );
    
    if ( namespace_fcff552b98571df1::function_bccf2e7ccbcd2299( player ) )
    {
        function_44939156d9f63618( player );
    }
    
    wait modeinfo.var_2ddfe36056b858d0;
    function_59cb3f6a06c20c5d( player );
    
    if ( namespace_fcff552b98571df1::function_c590a853e39425f8() )
    {
        namespace_fcff552b98571df1::function_2cd83eafed2d9a50();
        frun_telemetry::function_3c3209794fe4047a();
        function_3b70154f87c66b9d();
    }
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0x1efbc223, Offset: 0x18c5
// Size: 0xbf
function private function_7e69d19e2a320860()
{
    level endon( #"start_game_ended" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "victory" ] );
    endreasontext = game[ "end_reason" ][ "free_run_finished_race" ];
    self setclientomnvar( o"ui_round_end_reason", endreasontext );
    self setclientomnvar( o"post_game_state", 21 );
    wait 4;
    game_utility::fadetoblackforplayer( self, 1, 0.5 );
    self setclientomnvar( o"post_game_state", 0 );
    game_utility::fadetoblackforplayer( self, 0 );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x2403c065, Offset: 0x198c
// Size: 0x97
function private function_44939156d9f63618( var_c8bb5d2c806d4c3f )
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "free_run_player_finished_callout", var_c8bb5d2c806d4c3f.clientid, var_c8bb5d2c806d4c3f );
    }
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0x3dc2b0fb, Offset: 0x1a2b
// Size: 0xd2
function private function_646954ae9722165a()
{
    modeinfo = function_97dc8f6dff0a9255();
    finishplayers = [];
    
    foreach ( finishinfo in modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730 )
    {
        player = player::getplayerforguid( finishinfo.guid );
        
        if ( player )
        {
            finishplayers[ finishplayers.size ] = player;
        }
    }
    
    level.placement[ "all" ] = finishplayers;
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0xaa237d, Offset: 0x1b05
// Size: 0xdd
function private function_3b70154f87c66b9d()
{
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_e5db2ad69bda179b )
    {
        return;
    }
    
    if ( level.gameending )
    {
        return;
    }
    
    function_646954ae9722165a();
    level.gameending = 1;
    
    foreach ( player in level.players )
    {
        function_59cb3f6a06c20c5d( player );
    }
    
    wait 1;
    endreasontext = game[ "end_reason" ][ "free_run_finished_race" ];
    gamelogic_mp::onscorelimit( undefined, endreasontext );
}

// Namespace frun_free_run
// Params 3, eflags: 0x4
// Checksum 0x3113aab7, Offset: 0x1bea
// Size: 0x5a
function private endmatch( winner, endreasontext, nukedetonated )
{
    function_646954ae9722165a();
    endreasontext = game[ "end_reason" ][ "free_run_finished_race" ];
    endreasontextloss = game[ "end_reason" ][ "time_limit_reached" ];
    gamelogic_mp::endgame_regularmp( winner, endreasontext, endreasontextloss, nukedetonated );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0xafa02397, Offset: 0x1c4c
// Size: 0x99
function private function_59cb3f6a06c20c5d( player )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    player.nocorpse = 1;
    player.skipcorpse = 1;
    
    if ( !namespace_fcff552b98571df1::function_c590a853e39425f8() && namespace_fcff552b98571df1::function_28ad61cb6b5e840c( player ) )
    {
        player thread function_7e69d19e2a320860();
    }
    
    modeinfo = function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_ce9f827624de9f5f )
    {
        player thread function_ef19476a614f41ec();
        return;
    }
    
    player freezecontrols( 1 );
    player playerhide();
}

// Namespace frun_free_run
// Params 0, eflags: 0x4
// Checksum 0x23c28a84, Offset: 0x1ced
// Size: 0x4e
function private function_ef19476a614f41ec()
{
    level endon( #"game_ended" );
    level.spectateoverride[ self.pers[ "team" ] ].allowenemyspectate = 1;
    thread scripted_widgets::destroy( "scripted_widget_input_prompts_frun_checkpoints" );
    spectating::updatespectatesettings();
    menus::setspectator();
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0xf397a2d0, Offset: 0x1d43
// Size: 0x14
function private function_bb8b355d1daea488( player )
{
    return namespace_fcff552b98571df1::function_28ad61cb6b5e840c( player );
}

// Namespace frun_free_run
// Params 1, eflags: 0x4
// Checksum 0x26bf83cf, Offset: 0x1d60
// Size: 0x36
function private function_8bd80b07029ff212( player )
{
    if ( namespace_fcff552b98571df1::function_28ad61cb6b5e840c( player ) )
    {
        return 1;
    }
    
    var_b6e08be52d7e640a = !gamelogic_mp::function_73dde611c43b49d1();
    
    if ( var_b6e08be52d7e640a )
    {
        return 2;
    }
    
    return 0;
}

// Namespace frun_free_run
// Params 5, eflags: 0x4
// Checksum 0xb491e174, Offset: 0x1d9f
// Size: 0x30
function private onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    
}

// Namespace frun_free_run
// Params 1
// Checksum 0xca5f5057, Offset: 0x1dd7
// Size: 0xb8
function dohalftimevo( attacker )
{
    attacker dialog::leaderdialogonplayer( #"ffa_lead_first" );
    newarray = arraysort( level.players, undefined, &function_f78f06ef8f09122 );
    
    if ( isdefined( newarray[ 1 ] ) )
    {
        newarray[ 1 ] dialog::leaderdialogonplayer( #"ffa_lead_second" );
    }
    
    if ( isdefined( newarray[ 2 ] ) && newarray.size > 2 )
    {
        newarray[ 2 ] dialog::leaderdialogonplayer( #"ffa_lead_third" );
    }
    
    if ( isdefined( newarray[ newarray.size - 1 ] ) && newarray.size > 3 )
    {
        newarray[ newarray.size - 1 ] dialog::leaderdialogonplayer( #"ffa_lead_last" );
    }
    
    level.didhalfscorevoboost = 1;
}

// Namespace frun_free_run
// Params 2, eflags: 0x4
// Checksum 0x3512ba30, Offset: 0x1e97
// Size: 0x2c, Type: bool
function private function_f78f06ef8f09122( left, right )
{
    return left.score >= right.score;
}

/#

    // Namespace frun_free_run
    // Params 0, eflags: 0x4
    // Checksum 0x41630239, Offset: 0x1ecc
    // Size: 0x2e9, Type: dev
    function private init_debug_free_run()
    {
        namespace_ec33f26de741e14e::function_5a52677cbdd3e5e5( "<dev string:x9b>" );
        modeinfo = function_97dc8f6dff0a9255();
        
        while ( !modeinfo.var_afad088dc0cd7ba7 )
        {
            waitframe();
        }
        
        namespace_ec33f26de741e14e::registercommand( "<dev string:x9f>", "<dev string:x9b>", &debughelp, "<dev string:xa4>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:xc4>", "<dev string:x9b>", &function_ce2f4ada6b54487e, "<dev string:xd9>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:xf5>", "<dev string:x9b>", &function_b716dee3a4834dce, "<dev string:x111>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x136>", "<dev string:x9b>", &function_59cb5638812a60c2, "<dev string:x14f>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x18a>", "<dev string:x9b>", &function_cd0d5abb586964e7, "<dev string:x1a0>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x1d5>", "<dev string:x9b>", &function_3d3da41742c4bfd, "<dev string:x1e7>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x218>", "<dev string:x9b>", &function_af1a52bea44f26f, "<dev string:x22c>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x25f>", "<dev string:x9b>", &function_17f62c554744cdbb, "<dev string:x27b>", "<dev string:xbf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x2b2>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x2f4>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x2ff>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x31a>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x32f>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x34b>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x361>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x379>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x392>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x3a6>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x3b4>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x3ce>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x3e2>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x3fb>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x418>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x433>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x452>", "<dev string:x9b>", &function_4928dd331df16a15, "<dev string:x2c4>", "<dev string:x2ed>", [ "<dev string:x46c>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x48a>", "<dev string:x9b>", &forcespectator, "<dev string:x499>", "<dev string:x2ed>", [] );
        init_checkpoint_commands();
        namespace_ec33f26de741e14e::function_67acbc0c7e614803( "<dev string:x4be>", "<dev string:x9b>" );
    }

    // Namespace frun_free_run
    // Params 0, eflags: 0x4
    // Checksum 0x37573e95, Offset: 0x21bd
    // Size: 0x193, Type: dev
    function private init_checkpoint_commands()
    {
        modeinfo = function_97dc8f6dff0a9255();
        
        foreach ( zoneinfo in modeinfo.var_afad088dc0cd7ba7 )
        {
            foreach ( checkpointinfo in zoneinfo )
            {
                checkpointindex = checkpointinfo.checkpoint.checkpointindex;
                zoneindex = checkpointinfo.checkpoint.zoneindex;
                var_c99692f6ad82be3c = zoneindex < 10 ? "<dev string:x4c7>" + zoneindex : zoneindex;
                command = "<dev string:x4c9>" + zoneindex + "<dev string:x4df>" + checkpointindex;
                namespace_ec33f26de741e14e::registercommand( command, "<dev string:x9b>", &function_ce2f4ada6b54487e, "<dev string:x4e1>", "<dev string:x4ed>" + var_c99692f6ad82be3c, [ zoneindex, checkpointindex ] );
            }
        }
    }

    // Namespace frun_free_run
    // Params 5, eflags: 0x4
    // Checksum 0x56f15b61, Offset: 0x2358
    // Size: 0x5b, Type: dev
    function private registercommand( name, function, help, path, var_b054babccc6dec6 )
    {
        if ( !isdefined( path ) )
        {
            path = "<dev string:x4ff>";
        }
        
        if ( !isdefined( var_b054babccc6dec6 ) )
        {
            var_b054babccc6dec6 = [];
        }
        
        namespace_ec33f26de741e14e::registercommand( name, "<dev string:x9b>", function, help, path, var_b054babccc6dec6 );
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0x5d70b3ff, Offset: 0x23bb
    // Size: 0xa9, Type: dev
    function private function_d660450ac1c6adde( player )
    {
        if ( !player )
        {
            assertmsg( "<dev string:x500>" );
            return;
        }
        
        start = player geteye();
        dir = anglestoforward( player getplayerangles() );
        end = start + 8000 * dir;
        trace = trace::_bullet_trace( start, end, 1, player );
        target = undefined;
        
        if ( isplayer( trace[ "<dev string:x533>" ] ) && player::isreallyalive( trace[ "<dev string:x533>" ] ) )
        {
            target = trace[ "<dev string:x533>" ];
        }
        
        return target;
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0xb4b03eb3, Offset: 0x246c
    // Size: 0xf1, Type: dev
    function private debughelp( host, args )
    {
        level thread utility::function_72ef0ebf3a428eb9( "<dev string:x53a>", 30 );
        print( "<dev string:x572>" );
        
        foreach ( name, command in level.var_6ee9e53b11ece9ae.categories[ "<dev string:x9b>" ].registeredcommands )
        {
            print( name + "<dev string:x589>" + ( command.help ?? "<dev string:x58c>" ) + "<dev string:x589>" + command.function );
        }
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x5022b05b, Offset: 0x2565
    // Size: 0x5a, Type: dev
    function private function_cd0d5abb586964e7( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x9b>" );
        var_e192ef1147f518ac.var_7fa2185b014deaa4 = !var_e192ef1147f518ac.var_7fa2185b014deaa4;
        level thread function_3480ead251c6707( var_e192ef1147f518ac.var_7fa2185b014deaa4 );
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0xc
    // Checksum 0x1fe2d3b4, Offset: 0x25c7
    // Size: 0x1f6, Type: dev
    function private function_3480ead251c6707( enabled )
    {
        self notify( #"hash_d7eecd25ae58a263" );
        self endon( #"hash_d7eecd25ae58a263" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = function_97dc8f6dff0a9255();
        
        while ( true )
        {
            zoneindex = 0;
            var_93a25a0f57ffdce9 = undefined;
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            function_70dc3506340774cf( player );
            function_66b7eaa46b20d154( player );
            
            foreach ( zoneinfo in modeinfo.var_afad088dc0cd7ba7 )
            {
                foreach ( checkpointinfo in zoneinfo )
                {
                    distancesq = distancesquared( player.origin, checkpointinfo.checkpoint.origin );
                    
                    if ( distancesq < 5000000 )
                    {
                        function_3856b08552cf6bc6( checkpointinfo );
                    }
                    
                    if ( var_93a25a0f57ffdce9 )
                    {
                        line( checkpointinfo.checkpoint.origin, var_93a25a0f57ffdce9.checkpoint.origin, ( 0, 0, 1 ), 1, 0, 1 );
                    }
                    
                    var_93a25a0f57ffdce9 = checkpointinfo;
                }
                
                zoneindex++;
            }
            
            waitframe();
        }
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x39b2d654, Offset: 0x27c5
    // Size: 0x5a, Type: dev
    function private function_3d3da41742c4bfd( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x9b>" );
        var_e192ef1147f518ac.var_42a47e4d0e8c77de = !var_e192ef1147f518ac.var_42a47e4d0e8c77de;
        level thread function_babfa1290207041d( var_e192ef1147f518ac.var_42a47e4d0e8c77de );
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0xc
    // Checksum 0x6fc1adb7, Offset: 0x2827
    // Size: 0x19b, Type: dev
    function private function_babfa1290207041d( enabled )
    {
        self notify( #"hash_d522b6ca1d6655ba" );
        self endon( #"hash_d522b6ca1d6655ba" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = function_97dc8f6dff0a9255();
        
        foreach ( pickupinfo in modeinfo.pickuplist )
        {
            if ( !isdefined( pickupinfo.var_3896b8fa7aec8fad ) )
            {
                function_a687625d6669d44b( pickupinfo );
            }
        }
        
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            foreach ( pickupinfo in modeinfo.pickuplist )
            {
                distancesq = distancesquared( player.origin, pickupinfo.pickupentity.origin );
                
                if ( distancesq < 5000000 )
                {
                    function_71c23bdea028e328( pickupinfo );
                }
            }
            
            waitframe();
        }
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x1872cedf, Offset: 0x29ca
    // Size: 0x5a, Type: dev
    function private function_af1a52bea44f26f( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x9b>" );
        var_e192ef1147f518ac.var_262b5c20a64e679c = !var_e192ef1147f518ac.var_262b5c20a64e679c;
        level thread function_a39cfbd5c0431e8f( var_e192ef1147f518ac.var_262b5c20a64e679c );
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0xc
    // Checksum 0x82532a99, Offset: 0x2a2c
    // Size: 0x11b, Type: dev
    function private function_a39cfbd5c0431e8f( enabled )
    {
        self notify( #"hash_a891cb8d63b4326e" );
        self endon( #"hash_a891cb8d63b4326e" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = function_97dc8f6dff0a9255();
        
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            foreach ( killzoneinfo in modeinfo.killzonelist )
            {
                distancesq = distancesquared( player.origin, killzoneinfo.var_42cf502b6d79c11c.origin );
                
                if ( distancesq < 50000000 )
                {
                    function_edc3ee7cf5d950ce( killzoneinfo, player );
                }
            }
            
            waitframe();
        }
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0xa10a3da8, Offset: 0x2b4f
    // Size: 0xfb, Type: dev
    function private function_a687625d6669d44b( var_50da2b323998951c )
    {
        modeinfo = function_97dc8f6dff0a9255();
        
        foreach ( pickupinfo in modeinfo.pickuplist )
        {
            if ( pickupinfo == var_50da2b323998951c )
            {
                continue;
            }
            
            if ( pickupinfo.var_3896b8fa7aec8fad )
            {
                continue;
            }
            
            distancesq = distancesquared( pickupinfo.pickupentity.origin, var_50da2b323998951c.pickupentity.origin );
            
            if ( distancesq < 10000 )
            {
                var_50da2b323998951c.var_3896b8fa7aec8fad = 1;
            }
        }
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x202387a9, Offset: 0x2c52
    // Size: 0xbd, Type: dev
    function private function_17f62c554744cdbb( host, args )
    {
        if ( !host )
        {
            return;
        }
        
        if ( !isdefined( level.debugfoo ) )
        {
            level.debugfoo = 0;
        }
        
        if ( level.debugfoo == 0 )
        {
            grappleequipment = level.equipment.table[ "<dev string:x59c>" ];
            host function_170d3d8b516b85d9( grappleequipment.objweapon );
        }
        else if ( level.debugfoo == 1 )
        {
            host releaseoffhand();
        }
        else if ( level.debugfoo == 2 )
        {
        }
        
        level.debugfoo = ( level.debugfoo + 1 ) % 3;
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0x20b00243, Offset: 0x2d17
    // Size: 0x41a, Type: dev
    function private function_3856b08552cf6bc6( checkpointinfo )
    {
        origin = checkpointinfo.checkpoint.origin;
        
        if ( !isdefined( checkpointinfo.checkpointheader ) )
        {
            checkpointinfo.checkpointheader = "<dev string:x5b1>" + checkpointinfo.checkpoint.zoneindex + "<dev string:x5b8>" + checkpointinfo.checkpoint.checkpointindex;
        }
        
        if ( !isdefined( checkpointinfo.checkpointdetail ) )
        {
            checkpointinfo.checkpointdetail = "<dev string:x5c6>" + ( checkpointinfo.checkpoint.script_parameters ?? "<dev string:x4ff>" ) + ( checkpointinfo.checkpoint.var_59e2fdeca3342c99 ? "<dev string:x5d5>" : "<dev string:x5e9>" );
        }
        
        loadout = checkpointinfo.checkpoint.pickuploadout;
        
        if ( !isdefined( checkpointinfo.var_8637c126dcf95da4 ) )
        {
            checkpointinfo.var_8637c126dcf95da4 = "<dev string:x5fe>" + loadout.debugname;
        }
        
        if ( !isdefined( checkpointinfo.loadoutdetail ) )
        {
            checkpointinfo.loadoutdetail = "<dev string:x608>" + loadout.equipment.wingsuit + "<dev string:x611>" + ( loadout.weapons.weaponprimary ? loadout.weapons.weaponprimary.basenamehash : 0 ) + "<dev string:x61c>" + ( loadout.weapons.var_f8995ffbf8047610 ? loadout.weapons.var_f8995ffbf8047610.basenamehash : 0 ) + "<dev string:x629>" + loadout.equipment.tactical + "<dev string:x635>" + loadout.equipment.lethal;
        }
        
        print3d( origin, checkpointinfo.checkpointheader, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -20 ), checkpointinfo.checkpointdetail, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -40 ), checkpointinfo.var_8637c126dcf95da4, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -60 ), checkpointinfo.loadoutdetail, ( 1, 1, 1 ), 1, 1, 1, 1 );
        box( origin, 0, ( 0, 0, 1 ), 0, 1 );
        drawtrigger( checkpointinfo.checkpoint, ( 0, 0, 1 ), 1 );
        modeinfo = function_97dc8f6dff0a9255();
        
        foreach ( spawnpoint in checkpointinfo.checkpoint.a_spawn_points )
        {
            var_ed7f96be80d2f70f = !modeinfo.var_71b7ca7563cc2b95 && spawnpoint.var_94373324515af0b7 ? ( 0, 1, 0 ) : ( 0.75, 0.75, 0.75 );
            box( spawnpoint.origin, 0, var_ed7f96be80d2f70f, 1, 1 );
        }
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0xd7fcddc4, Offset: 0x3139
    // Size: 0x187, Type: dev
    function private function_71c23bdea028e328( pickupinfo )
    {
        origin = pickupinfo.pickupentity.origin;
        
        if ( !isdefined( pickupinfo.loadoutdetail ) )
        {
            pickupinfo.loadoutdetail = "<dev string:x63f>" + pickupinfo.iswingsuit + "<dev string:x647>" + pickupinfo.isequipment + "<dev string:x654>" + ( pickupinfo.iswingsuit ? "<dev string:x65c>" : pickupinfo.itemname ?? "<dev string:x4ff>" );
        }
        
        if ( !isdefined( pickupinfo.shortdisplayname ) )
        {
            pickupinfo.shortdisplayname = "<dev string:x665>" + getsubstr( pickupinfo.pickupentity.e_pickup_display.model, 0, 15 );
        }
        
        if ( !pickupinfo.var_3896b8fa7aec8fad )
        {
            print3d( origin + ( 0, 0, 60 ), pickupinfo.loadoutdetail, ( 1, 1, 1 ), 1, 1, 1, 1 );
            print3d( origin + ( 0, 0, 40 ), pickupinfo.shortdisplayname, ( 1, 1, 1 ), 1, 1, 1, 1 );
        }
        
        drawtrigger( pickupinfo.pickupentity, ( 1, 0.75, 0.75 ), 1 );
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x815ac649, Offset: 0x32c8
    // Size: 0x33c, Type: dev
    function private function_edc3ee7cf5d950ce( killzoneinfo, player )
    {
        origin = killzoneinfo.var_42cf502b6d79c11c.origin;
        isactive = frun_checkpoints::function_319f1cee3a98304f( player, killzoneinfo.var_42cf502b6d79c11c );
        
        if ( killzoneinfo.var_3df6b9a672d36926 )
        {
            labelprefix = "<dev string:x66d>";
            triggercolor = isactive ? ( 1, 0.5, 0 ) : ( 0.5, 0.5, 0.5 );
            var_f1bc987bca91404 = ( 1, 0.5, 0 );
            var_c44b8733e10ec9d5 = killzoneinfo.var_3df6b9a672d36926;
        }
        else if ( killzoneinfo.var_9083c1d9e333ef44 )
        {
            labelprefix = "<dev string:x679>";
            triggercolor = isactive ? ( 0.5, 0.5, 1 ) : ( 0.5, 0.5, 0.5 );
            var_f1bc987bca91404 = ( 0.5, 0.5, 1 );
            var_c44b8733e10ec9d5 = killzoneinfo.var_9083c1d9e333ef44;
        }
        else if ( killzoneinfo.var_d9d2c167551d546a )
        {
            labelprefix = "<dev string:x684>";
            triggercolor = isactive ? ( 1, 0, 0 ) : ( 0.5, 0.5, 0.5 );
            var_f1bc987bca91404 = ( 1, 0, 0 );
            var_c44b8733e10ec9d5 = killzoneinfo.var_d9d2c167551d546a;
        }
        else
        {
            labelprefix = "<dev string:x68f>";
            triggercolor = ( 0, 0.75, 0 );
        }
        
        killzoneinfo.checkpointlabel = labelprefix + ( var_c44b8733e10ec9d5.checkpoint.zoneindex ?? "<dev string:x4ff>" ) + "<dev string:x5b8>" + ( var_c44b8733e10ec9d5.checkpoint.checkpointindex ?? "<dev string:x4ff>" );
        killzoneinfo.checkpointstate = "<dev string:x699>" + ( isactive ? "<dev string:x6a2>" : "<dev string:x6aa>" ) + "<dev string:x6b3>" + ( killzoneinfo.var_42cf502b6d79c11c.var_5fac99c61ce13251 ? "<dev string:x6c7>" : "<dev string:x6cc>" );
        
        if ( var_f1bc987bca91404 )
        {
            line( origin, var_c44b8733e10ec9d5.checkpoint.origin, var_f1bc987bca91404, 1 );
        }
        
        print3d( origin + ( 0, 0, 40 ), killzoneinfo.checkpointstate, ( 0.5, 0.5, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, 60 ), killzoneinfo.checkpointlabel, ( 0.5, 0.5, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, 80 ), "<dev string:x6d2>" + ( killzoneinfo.var_42cf502b6d79c11c.targetname ?? "<dev string:x4ff>" ) + "<dev string:x6de>", ( 1, 1, 1 ), 1, 1, 1, 1 );
        drawtrigger( killzoneinfo.var_42cf502b6d79c11c, triggercolor, 1 );
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0x3c4f9ad2, Offset: 0x360c
    // Size: 0xac, Type: dev
    function private function_70dc3506340774cf( player )
    {
        modeinfo = function_97dc8f6dff0a9255();
        var_8e8a8aacc07d7a85 = modeinfo.var_afad088dc0cd7ba7[ player.freeruninfo.zoneindex ][ player.freeruninfo.checkpointindex ];
        
        if ( !var_8e8a8aacc07d7a85 )
        {
            return;
        }
        
        var_b2bacc46aa83ae4f = var_8e8a8aacc07d7a85.checkpoint.origin;
        line( player.origin, var_b2bacc46aa83ae4f, ( 0, 0, 1 ), 1, 0, 1 );
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0xdad9f12f, Offset: 0x36c0
    // Size: 0x64, Type: dev
    function private function_66b7eaa46b20d154( player )
    {
        activespawnpoint = player.freeruninfo.activespawnpoint;
        
        if ( !activespawnpoint )
        {
            return;
        }
        
        line( player.origin, activespawnpoint.origin, ( 0, 1, 0 ), 1, 0, 1 );
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x7ccee69b, Offset: 0x372c
    // Size: 0xd7, Type: dev
    function private function_ce2f4ada6b54487e( host, args )
    {
        player = function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        zoneindex = int( args[ 0 ] ?? 1 );
        checkpointindex = int( args[ 1 ] ?? 1 );
        checkpointinfo = frun_checkpoints::function_93836aea1333e750( zoneindex, checkpointindex );
        player thread function_8265d8da04af0e50();
        checkpointinfo.checkpoint frun_checkpoints::function_453eed18285c9df7( player, checkpointinfo.checkpoint, 1, 1 );
        newspawnpoint = player frun_checkpoints::get_spawn_point();
        frun_checkpoints::function_bbd98e9afa4895de( player, player.freeruninfo.currentcheckpoint, newspawnpoint );
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0xff83bdb7, Offset: 0x380b
    // Size: 0x21, Type: dev
    function private function_b716dee3a4834dce( host, args )
    {
        frun_checkpoints::function_829dfb8cf6166f33( host );
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0xf86f24d4, Offset: 0x3834
    // Size: 0x21, Type: dev
    function private function_59cb5638812a60c2( host, args )
    {
        frun_checkpoints::function_9896bb059895d97( host );
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0x721e8bad, Offset: 0x385d
    // Size: 0x98, Type: dev
    function private function_4928dd331df16a15( host, args )
    {
        player = function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        part = args[ 0 ];
        
        if ( !part )
        {
            return;
        }
        
        currentenabled = player utility::function_9f2c41c1dcc8c94( part, #"on" );
        
        if ( !currentenabled )
        {
            player utility::function_32b24db3127bff40( part, #"on" );
            return;
        }
        
        player utility::function_32b24db3127bff40( part, #"off" );
    }

    // Namespace frun_free_run
    // Params 0, eflags: 0xc
    // Checksum 0xcedb0536, Offset: 0x38fd
    // Size: 0x4f, Type: dev
    function private function_8265d8da04af0e50()
    {
        self notify( #"hash_71df7600c0be6cc5" );
        self endon( #"hash_71df7600c0be6cc5" );
        self.freeruninfo.var_391bebe82698b3d4 = 1;
        waitframe();
        
        if ( !self )
        {
            return;
        }
        
        self.freeruninfo.var_391bebe82698b3d4 = 0;
    }

    // Namespace frun_free_run
    // Params 1, eflags: 0x4
    // Checksum 0xdbfc1dd9, Offset: 0x3954
    // Size: 0xb0, Type: dev
    function private droptoground( origin )
    {
        contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
        
        if ( !isdefined( ignoreents ) )
        {
            ignoreents = [];
        }
        
        start = origin + ( 0, 0, 25 );
        end = origin + ( 0, 0, -3000 );
        result = trace::ray_trace( start, end, ignoreents, contents );
        
        if ( result[ "<dev string:x6e0>" ] == 1 || result[ "<dev string:x6e9>" ][ 2 ] <= -10000 )
        {
            return origin;
        }
        
        return result[ "<dev string:x6e9>" ];
    }

    // Namespace frun_free_run
    // Params 2, eflags: 0x4
    // Checksum 0xdf585c65, Offset: 0x3a0c
    // Size: 0x42, Type: dev
    function private forcespectator( host, args )
    {
        player = function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player function_ef19476a614f41ec();
    }

    // Namespace frun_free_run
    // Params 3, eflags: 0x4
    // Checksum 0xe7bdd004, Offset: 0x3a56
    // Size: 0x45, Type: dev
    function private function_d01545556cb3060d( player, destination, facing )
    {
        if ( !( isdefined( player ) && isdefined( destination ) && isdefined( facing ) ) )
        {
            return;
        }
        
        player setorigin( destination );
        player setplayerangles( facing );
    }

#/
