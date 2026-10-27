// scripts\mp\gametypes\frune_free_run_evo.gsc  (hash_41e8717f431a2fbe.gscc) (size: 26058 Bytes / 0x65ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfce9ed3 (265199315)
// size ...... 26058 (0x65ca)
// includes .. 34  (offset: 0x5dca)
// strings ... 41  (offset: 0x5eda)
// dev strs .. 81  (offset: 0x6122)
// exports ... 65  (offset: 0x3b12)
// cseg ...... 0x3da + 0x3738 (0x3b12)
// imports ... 206 (offset: 0x453a)
// animtree1 . 0   (offset: 0x65ca)
// animtree2 . 0   (offset: 0x65ca)
#using script_1b6226c923babd4a;
#using script_32ab226b6fbdeba;
#using script_3b5f1fa53313feda;
#using script_44280f644740bac;
#using script_589df2aa09741eb8;
#using script_7e874027fd36f44f;
#using scripts\common\scripted_widgets;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\class;
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
#using scripts\mp\gametypes\frune_checkpoints;
#using scripts\mp\gametypes\frune_cinematics;
#using scripts\mp\gametypes\frune_collectible;
#using scripts\mp\gametypes\frune_fx;
#using scripts\mp\gametypes\frune_killzone;
#using scripts\mp\gametypes\frune_shootable_target;
#using scripts\mp\gametypes\frune_telemetry;
#using scripts\mp\gametypes\frune_vo;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\menus;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;

#namespace frune_free_run_evo;

// Namespace frune_free_run_evo
// Params 0
// Checksum 0x1e18c812, Offset: 0x3f8
// Size: 0x733
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
    game[ #"frune_tuning" ] = {};
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.frune_bundle ) )
    {
        modeinfo.frune_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frune" );
    }
    
    modeinfo.var_ce9f827624de9f5f = getdvarint( @"hash_51ed2fd9390ffea5", modeinfo.frune_bundle.var_1ba3ad338e77bb6a ?? 1 );
    modeinfo.var_2ddfe36056b858d0 = getdvarfloat( @"hash_ea12f09997b119d8", modeinfo.frune_bundle.var_5ff86ed2e4472191 ?? 4 );
    modeinfo.var_e5db2ad69bda179b = getdvarint( @"hash_993db2aefc70b529", modeinfo.frune_bundle.var_63f625ab9b2e6dfa ?? 0 );
    modeinfo.var_42de21d3a24f6797 = getdvarint( @"hash_af2fd17f72080da9", modeinfo.frune_bundle.var_629157bf510e40c2 ?? 1 );
    modeinfo.var_b1501e30fc6ffc70 = getdvarint( @"hash_2056479b43f4b21", modeinfo.frune_bundle.var_a451588f6ba3834a ?? 1 );
    modeinfo.var_e86ace2672c2a256 = getdvarint( @"hash_512e3daff304e062", modeinfo.frune_bundle.var_32a8fea418e8eeeb ?? 0 );
    modeinfo.var_aa4094dbfbb439f1 = getdvarint( @"hash_66de6716c34c1f31", modeinfo.frune_bundle.var_1f12b1cf6504dbd4 ?? 1 );
    modeinfo.var_cdcc4702644fb40d = getdvarint( @"hash_3c91fbf02af78812", modeinfo.frune_bundle.var_8c3836e4862fa581 ?? 3 );
    modeinfo.var_b6baa88473a824e1 = getdvarint( @"hash_4e790ff5931493ca", modeinfo.frune_bundle.var_60b0465e79c3e53d ?? 1 );
    modeinfo.var_62e75879d10527f3 = getdvarint( @"hash_451c4eaaec45be30", modeinfo.frune_bundle.var_12ffddeaf899ba81 ?? 0 );
    modeinfo.var_1f482f42b0072192 = getdvarint( @"hash_bdf0a34ae842c54f", modeinfo.frune_bundle.var_b3d47164f4b1fb36 ?? 0 );
    modeinfo.var_1c5b086d3bc7aead = getdvarint( @"hash_8526dc6739b1429d", modeinfo.frune_bundle.var_f56d2a85f28ceb76 ?? 1 );
    modeinfo.var_495800f29bb0acd4 = getdvarint( @"hash_9cb3d5c5cf722744", modeinfo.frune_bundle.var_ba35ae8091105ed ?? 1 );
    modeinfo.var_3ad8603ed9b0723b = getdvarint( @"hash_fe319f90aaf3b545", modeinfo.frune_bundle.var_93f749b1e84b79ba ?? 1000 );
    modeinfo.var_ec90ab50128015c = getdvarint( @"hash_6a4a851adbd12a96", modeinfo.frune_bundle.var_ce82f48d0e9f6545 ?? 1 );
    modeinfo.var_f6a177f6d3e62463 = getdvarint( @"hash_9d08553279aa6eef", modeinfo.frune_bundle.var_b409a82c04f2cad2 ?? 30000 );
    modeinfo.var_979cf85c0f407975 = getdvarint( @"hash_85735de91262067b", modeinfo.frune_bundle.var_1075959c16675be ?? 0 );
    modeinfo.var_97f19e1eeb7a467c = getdvarfloat( @"hash_5eed5643062c6617", modeinfo.frune_bundle.var_41de28f3394266fc ?? 2 );
    modeinfo.var_f3c4dc835a629017 = getdvarint( @"hash_389e9a6dd62a7043", modeinfo.frune_bundle.var_d372ebdcf838f26e ?? 0 );
    modeinfo.var_13aedfadc6d2b151 = getdvarint( @"hash_7b2871cd1cce3040", modeinfo.frune_bundle.var_75cae4ef961745c3 ?? 1 );
    modeinfo.var_e151c0af80a3ad2e = getdvarint( @"hash_882cfe33fced6f20", modeinfo.frune_bundle.var_52c82bec1fa82cab ?? 1 );
    modeinfo.var_4878d12f6f1c320f = utility::function_4b74c15943231980( getdvarint( @"hash_61144af46b8178c8", modeinfo.frune_bundle.var_99154d702b7d5cbd ?? 10 ) );
    modeinfo.var_7deb2b87c100328c = getdvarint( @"hash_41e75cc97c511e26", 1 );
    modeinfo.var_150cbad0a1859804 = getdvarint( @"hash_f02e4e9cbf9e517b", modeinfo.frune_bundle.var_3c1ca135873285d0 ?? 0 );
    setdvar( @"hash_606b9abf1a1ec029", -1000 );
    setdvar( @"bg_falldamageminheight", 3100 );
    setdvar( @"bg_falldamagemaxheight", 3200 );
    level.var_702ea1a2fc683e54 = getdvarint( @"hash_a04518df9d9f211e", getmatchrulesdata( "commonOption", "overrideScoringOnKillsFFA" ) ?? 0 );
    level.onstartgametype = &onstartgametype;
    level.n_total_players = 0;
    level.var_b301fb5fca6e1388 = [];
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.getspawnpoint = &frune_checkpoints::get_spawn_point;
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
    utility::registersharedfunc( #"frun_challenges", #"hash_25c85cd46694dd52", &function_efb4d650159d4cb );
    setteammode( "ffa" );
    
    /#
        level thread init_debug_free_run();
    #/
    
    level thread frune_checkpoints::init();
    level thread frune_killzone::init();
    level thread namespace_c41f357b2d127aee::init();
    level thread namespace_27888f54e9b5bb16::init();
    level thread frune_telemetry::init();
    level thread frune_shootable_target::init();
    level thread namespace_94a725a4853ac529::init();
    level thread frune_cinematics::init();
    level thread frune_vo::init();
    level thread frune_fx::init();
    level thread frune_collectible::init();
    level thread namespace_596312de8f8f3064::init();
    level thread namespace_1cac7a6a80266fcc::init();
}

// Namespace frune_free_run_evo
// Params 2
// Checksum 0x5f04cac1, Offset: 0xb33
// Size: 0x69
function function_efb4d650159d4cb( player, additionaleventparams = [] )
{
    additionaleventparams[ #"kill_amount" ] = player.freeruninfo.var_84b9cdcdd98678cb ?? 0;
    additionaleventparams[ #"reload_amount" ] = player.freeruninfo.var_b068e106117c8b4e ?? 0;
    return additionaleventparams;
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0x9b48e502, Offset: 0xba5
// Size: 0xb
function private initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata( 1 );
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xa5e74372, Offset: 0xbb8
// Size: 0x202
function private onplayerconnect( player )
{
    if ( !level.gameended && player.pers[ #"hash_728cbcbfbe4a7f9c" ] == #"stopped" )
    {
        player.pers[ #"hash_728cbcbfbe4a7f9c" ] = #"started";
    }
    
    player.current_weapon = undefined;
    player.freeruninfo = { #var_f3f0c8973953f4d5:0, #var_18293adcc77e8ac5:0, #var_88b6290864fae386:0, #var_b068e106117c8b4e:0, #var_dd64197455956651:[], #var_a29dd559ee99f24d:[], #var_f7f77add9ccca410:[], #var_546094b50f04eeba:[], #var_e9402cc2764ece1a:[], #var_84b9cdcdd98678cb:0, #var_328df64682b9ec5c:0, #var_f5a96581fe746943:namespace_27888f54e9b5bb16::function_a3a4bf509f50b65e() ?? 0, #var_59e2fdeca3342c99:0, #var_b2c9df167adcea1b:0, #var_5271a39f8b21d4a3:0, #var_2dbea8ea2c8af83b:0, #var_a882e795141bf183:0, #checkpointindex:0, #zoneindex:0 };
    player thread namespace_c41f357b2d127aee::function_3abb5b856fc03d10();
    player thread namespace_c41f357b2d127aee::function_35a441a1867a3b39( player );
    player thread namespace_c41f357b2d127aee::function_1c6d21480ed20b1f( player );
    player thread function_541ead12eeef804b( player );
    player thread function_e65cb2300b1d85( player );
    player thread function_ab5196100d625c8a( player );
    player thread function_be99deec6a154153( player );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_7deb2b87c100328c )
    {
        player frune_collectible::function_cbc2bc1bb506cbcd();
    }
    
    namespace_27888f54e9b5bb16::function_a4e3a49755aa5bef();
    
    if ( utility::flag( "frune_music_start" ) )
    {
        musicbank_utility::function_5aca66c390aa347d( player, #"mp_freerun_start" );
        utility::delaycall( 1, &musicbank_utility::function_5aca66c390aa347d, player, #"hash_9bdc077c73dd04f2" );
    }
    
    frune_checkpoints::function_c550caa7c086c7d2( player );
    player setsoundsubmix( "mp_sat_freerun_submix" );
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x79811736, Offset: 0xdc2
// Size: 0x258
function private function_e65cb2300b1d85( player )
{
    player endon( #"death_or_disconnect" );
    modeinfo = game[ #"frune_tuning" ];
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
        var_d9f2beaee4f21ad0 = utility::function_6f5d2e1f1ff70482( modeinfo.var_f6a177f6d3e62463 - namespace_27888f54e9b5bb16::function_76ba268d368eed64( player ) );
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

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x915acdba, Offset: 0x1022
// Size: 0x129
function private function_541ead12eeef804b( player )
{
    player endon( #"death_or_disconnect" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_13aedfadc6d2b151 )
    {
        if ( !isdefined( hintwidget ) )
        {
            hintwidget = scripted_widgets::function_652736891a41e948( "scripted_widget_frun_evo_grapple_gun_hint" );
        }
        
        if ( !scripted_widgets::is_active( hintwidget ) )
        {
            player thread scripted_widgets::create( "scripted_widget_frun_evo_grapple_gun_hint", hintwidget );
        }
    }
    else
    {
        return;
    }
    
    while ( player && player isconnected() )
    {
        var_6826778503f36daf = function_142e08ba582267cf( player );
        
        /#
            if ( modeinfo.var_f3c4dc835a629017 )
            {
                var_1d8ebbd892674a0 = "<dev string:x3b>";
                var_f5c0fe1662ce9e16 = var_6826778503f36daf ? ( 0, 1, 0 ) : ( 0.75, 0.75, 0.75 );
                printtoscreen2d( 75, 1000, var_1d8ebbd892674a0, var_f5c0fe1662ce9e16, 2 );
            }
        #/
        
        if ( var_6826778503f36daf )
        {
            player thread scripted_widgets::set_state( "scripted_widget_frun_evo_grapple_gun_hint", "Show" );
        }
        else
        {
            player thread scripted_widgets::set_state( "scripted_widget_frun_evo_grapple_gun_hint", "Hide" );
        }
        
        waitframe();
    }
}

// Namespace frune_free_run_evo
// Params 1
// Checksum 0xd9dc5070, Offset: 0x1153
// Size: 0x21
function function_6f77d9609644f225( player )
{
    player.freeruninfo.var_e1131634a13f87ef = undefined;
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x9e806c53, Offset: 0x117c
// Size: 0x144, Type: bool
function private function_142e08ba582267cf( player )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_13aedfadc6d2b151 )
    {
        return false;
    }
    
    zoneindex = player.freeruninfo.zoneindex;
    checkpointindex = player.freeruninfo.checkpointindex;
    
    if ( zoneindex != 5 )
    {
        return false;
    }
    
    if ( checkpointindex < 8 || checkpointindex > 15 )
    {
        return false;
    }
    
    var_e54fdf152a7e7fbb = player.freeruninfo.var_e9402cc2764ece1a[ zoneindex ][ checkpointindex ] ?? 0;
    
    if ( var_e54fdf152a7e7fbb < modeinfo.var_e151c0af80a3ad2e )
    {
        return false;
    }
    
    currenttimems = gettime();
    var_94a4fafea6946b3d = currenttimems - ( player.freeruninfo.var_e1131634a13f87ef ?? currenttimems );
    
    if ( var_94a4fafea6946b3d > modeinfo.var_4878d12f6f1c320f )
    {
        return false;
    }
    
    if ( !isdefined( player.freeruninfo.var_e1131634a13f87ef ) )
    {
        player.freeruninfo.var_e1131634a13f87ef = currenttimems;
    }
    
    return true;
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xe0128243, Offset: 0x12c9
// Size: 0xc3
function private function_ab5196100d625c8a( player )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_1f482f42b0072192 )
    {
        player notifyonplayercommand( "skip_to_next_checkpoint", "+frag" );
        player notifyonplayercommand( "reset_to_current_checkpoint", "+smoke" );
    }
    
    /#
        if ( !modeinfo.var_1f482f42b0072192 && modeinfo.var_62e75879d10527f3 && !isbot( player ) )
        {
            player notifyonplayercommand( "<dev string:x4b>", "<dev string:x63>" );
            player notifyonplayercommand( "<dev string:x71>", "<dev string:x8d>" );
            player notifyonplayercommand( "<dev string:x4b>", "<dev string:x9b>" );
            player notifyonplayercommand( "<dev string:x71>", "<dev string:xa2>" );
        }
    #/
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0xc
// Checksum 0x6f4f0794, Offset: 0x1394
// Size: 0xf3
function private function_be99deec6a154153( player )
{
    self notify( #"hash_72b175e223656e9a" );
    self endon( #"hash_72b175e223656e9a" );
    
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
        
        modeinfo = game[ #"frune_tuning" ];
        player.freeruninfo.var_200b73194ecf6485 = 1;
        wait modeinfo.var_97f19e1eeb7a467c;
    }
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x21b5b6e3, Offset: 0x148f
// Size: 0x152, Type: bool
function private function_686b97d7146deee6( player )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_ec90ab50128015c )
    {
        return false;
    }
    
    if ( player.freeruninfo.var_200b73194ecf6485 )
    {
        return false;
    }
    
    if ( namespace_27888f54e9b5bb16::function_76ba268d368eed64( player ) <= modeinfo.var_f6a177f6d3e62463 )
    {
        return false;
    }
    
    zoneindex = player.freeruninfo.zoneindex;
    checkpointindex = player.freeruninfo.checkpointindex;
    
    if ( !( isdefined( zoneindex ) && isdefined( checkpointindex ) ) || zoneindex <= 1 && checkpointindex <= 1 )
    {
        return false;
    }
    
    finalcheckpoint = frune_checkpoints::function_879e36be517c8598();
    var_af0fe6911b642e7c = finalcheckpoint.flatindex - 1;
    
    if ( player.freeruninfo.currentcheckpoint.flatindex >= var_af0fe6911b642e7c )
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

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xf63b233f, Offset: 0x15ea
// Size: 0x2c
function private function_c5d13dd7e4d7f44b( player )
{
    if ( !function_686b97d7146deee6( player ) )
    {
        return;
    }
    
    player thread frune_telemetry::function_254ea37e913e3c00( player );
    frune_checkpoints::function_9896bb059895d97( player );
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x73dedb59, Offset: 0x161e
// Size: 0x69, Type: bool
function private function_94d5ac71bb49712e( player )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_495800f29bb0acd4 )
    {
        return false;
    }
    
    if ( player.freeruninfo.var_200b73194ecf6485 )
    {
        return false;
    }
    
    if ( namespace_27888f54e9b5bb16::function_76ba268d368eed64( player ) <= modeinfo.var_3ad8603ed9b0723b )
    {
        return false;
    }
    
    return true;
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xca09f83c, Offset: 0x1690
// Size: 0x2c
function private function_86ab1aeb8d15373( player )
{
    if ( !function_94d5ac71bb49712e( player ) )
    {
        return;
    }
    
    player thread frune_telemetry::function_560b21c5a425f69e( player );
    frune_checkpoints::function_829dfb8cf6166f33( player );
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xeda86421, Offset: 0x16c4
// Size: 0x39
function private onplayerdisconnect( player )
{
    level thread frune_telemetry::function_b90947072f2f81c1( player );
    player thread scripted_widgets::destroy( "scripted_widget_input_prompts_frun_checkpoints" );
    player thread scripted_widgets::destroy( "scripted_widget_frun_evo_grapple_gun_hint" );
    namespace_27888f54e9b5bb16::function_a4e3a49755aa5bef();
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0xc60efa13, Offset: 0x1705
// Size: 0x24
function private function_49d74288e86abd6d()
{
    if ( namespace_27888f54e9b5bb16::function_28ad61cb6b5e840c( self ) )
    {
        return self.freeruninfo.var_328df64682b9ec5c;
    }
    
    return gettime();
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x7fa133ac, Offset: 0x1732
// Size: 0xac
function private function_ce323339907d05fa( player )
{
    player game_utility::stopkeyearning( level.endgamewinner ?? "all" );
    
    if ( level.gameended || player.matchbonus > 0 )
    {
        return;
    }
    
    if ( !namespace_27888f54e9b5bb16::function_28ad61cb6b5e840c( player ) )
    {
        return;
    }
    
    var_ae3586f008b36f1 = ( gettime() - ( game[ "startTimeFromMatchStart" ] ?? 0 ) ) / 1000;
    playerscore = player gamelogic_mp::calculatematchbonus( #"win", var_ae3586f008b36f1 );
    player.matchbonus = playerscore;
    player gamelogic_mp::givematchbonus( "win", playerscore );
}

// Namespace frune_free_run_evo
// Params 11, eflags: 0x4
// Checksum 0xe67b7e50, Offset: 0x17e6
// Size: 0xc6
function private modifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( isplayer( eattacker ) )
    {
        return 0;
    }
    
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_e86ace2672c2a256 && smeansofdeath == "MOD_CRUSH" )
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

// Namespace frune_free_run_evo
// Params 1, eflags: 0xc
// Checksum 0xd118b08, Offset: 0x18b5
// Size: 0x2d
function private function_a95e26639e732b21( player )
{
    self notify( #"hash_92cf1eb39a11fb86" );
    self endon( #"hash_92cf1eb39a11fb86" );
    frune_checkpoints::function_6c7105f996cfb744( player );
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0x9a6324dd, Offset: 0x18ea
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

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x14bc2afa, Offset: 0x1a4a
// Size: 0x50
function private onplayerspawn( spawndata )
{
    level notify( #"spawned_player" );
    thread function_7d4110829f4ddb5();
    thread function_afe6d42eac36bc69();
    thread function_4d6cfee0485fdbc1();
    namespace_27888f54e9b5bb16::function_a4e3a49755aa5bef();
    thread namespace_94a725a4853ac529::function_ca7da31bda8e254c();
    thread namespace_94a725a4853ac529::function_183ded8ab72ea1da();
    thread namespace_94a725a4853ac529::function_a7538c20aa2dd747();
    thread namespace_94a725a4853ac529::function_fa8cd9286636aa86();
}

// Namespace frune_free_run_evo
// Params 0
// Checksum 0xe93f5533, Offset: 0x1aa2
// Size: 0x98
function function_4d6cfee0485fdbc1()
{
    self waittill( #"giveloadout" );
    
    if ( !self )
    {
        return;
    }
    
    class::loadout_clearperks();
    perk::giveperk( "specialty_no_target" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_42de21d3a24f6797 )
    {
        perk::giveperk( "specialty_adaptive_ads_speed" );
    }
    
    val::set( "frune_player_val", "collide_with_players", 0 );
    val::set( "frune_player_val", "ignore_ascender_collision", 1 );
    val::set( "frune_player_val", "weapon_switch", 0 );
    function_c19956ed01128b1d( self );
}

// Namespace frune_free_run_evo
// Params 0
// Checksum 0x7757811c, Offset: 0x1b42
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
    
    namespace_c41f357b2d127aee::function_b90bc384cbf8537a( self, self.freeruninfo.var_caed4acc269c7041 );
}

// Namespace frune_free_run_evo
// Params 0
// Checksum 0x3e481a9f, Offset: 0x1b8b
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

// Namespace frune_free_run_evo
// Params 6, eflags: 0x4
// Checksum 0x26f84ae3, Offset: 0x1bf2
// Size: 0x39
function private onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    
}

// Namespace frune_free_run_evo
// Params 15, eflags: 0x4
// Checksum 0xb90e4d24, Offset: 0x1c33
// Size: 0x8a
function private onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0xd2ec58ef, Offset: 0x1cc5
// Size: 0x9
function private ontimelimit()
{
    thread function_3b70154f87c66b9d();
}

// Namespace frune_free_run_evo
// Params 1
// Checksum 0xc8070858, Offset: 0x1cd6
// Size: 0x69
function function_c19956ed01128b1d( player )
{
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_b1501e30fc6ffc70 )
    {
        return;
    }
    
    player utility::function_32b24db3127bff40( #"hash_3c6f8fb958e4a9ad", #"off" );
    player utility::function_32b24db3127bff40( #"hash_3c6f8fb958e4a9ad", #"on" );
}

// Namespace frune_free_run_evo
// Params 1
// Checksum 0x4d23f507, Offset: 0x1d47
// Size: 0xc0
function function_e8f4bdacae514c81( player )
{
    level endon( #"game_ended" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( namespace_27888f54e9b5bb16::function_28ad61cb6b5e840c( player ) )
    {
        return;
    }
    
    player thread frune_telemetry::function_ae6206f684bbf151( player );
    namespace_27888f54e9b5bb16::function_b5fd5ae9eb439ed5( player );
    namespace_27888f54e9b5bb16::function_a4e3a49755aa5bef();
    setomnvar( o"ui_free_run_num_players_finished", modeinfo.var_44f7e6549b9e6660.var_2432c465f4c82730.size );
    
    if ( namespace_27888f54e9b5bb16::function_bccf2e7ccbcd2299( player ) )
    {
        function_44939156d9f63618( player );
    }
    
    wait modeinfo.var_2ddfe36056b858d0;
    function_59cb3f6a06c20c5d( player );
    
    if ( namespace_27888f54e9b5bb16::function_c590a853e39425f8() )
    {
        namespace_27888f54e9b5bb16::function_2cd83eafed2d9a50();
        frune_telemetry::function_3c3209794fe4047a();
        function_3b70154f87c66b9d();
    }
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0x81b795f7, Offset: 0x1e0f
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

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xbb4f97b1, Offset: 0x1ed6
// Size: 0x97
function private function_44939156d9f63618( var_c8bb5d2c806d4c3f )
{
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( "free_run_player_finished_callout", var_c8bb5d2c806d4c3f.clientid, var_c8bb5d2c806d4c3f );
    }
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0xa0b9d05e, Offset: 0x1f75
// Size: 0xd7
function private function_646954ae9722165a()
{
    modeinfo = game[ #"frune_tuning" ];
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

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0x9dd143d8, Offset: 0x2054
// Size: 0xe2
function private function_3b70154f87c66b9d()
{
    modeinfo = game[ #"frune_tuning" ];
    
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

// Namespace frune_free_run_evo
// Params 3, eflags: 0x4
// Checksum 0xd3f2b410, Offset: 0x213e
// Size: 0x5a
function private endmatch( winner, endreasontext, nukedetonated )
{
    function_646954ae9722165a();
    endreasontext = game[ "end_reason" ][ "free_run_finished_race" ];
    endreasontextloss = game[ "end_reason" ][ "time_limit_reached" ];
    gamelogic_mp::endgame_regularmp( winner, endreasontext, endreasontextloss, nukedetonated );
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x32db4332, Offset: 0x21a0
// Size: 0x9e
function private function_59cb3f6a06c20c5d( player )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    player.nocorpse = 1;
    player.skipcorpse = 1;
    
    if ( !namespace_27888f54e9b5bb16::function_c590a853e39425f8() && namespace_27888f54e9b5bb16::function_28ad61cb6b5e840c( player ) )
    {
        player thread function_7e69d19e2a320860();
    }
    
    modeinfo = game[ #"frune_tuning" ];
    
    if ( modeinfo.var_ce9f827624de9f5f )
    {
        player thread function_ef19476a614f41ec();
        return;
    }
    
    player freezecontrols( 1 );
    player playerhide();
}

// Namespace frune_free_run_evo
// Params 0, eflags: 0x4
// Checksum 0xbc8edd50, Offset: 0x2246
// Size: 0x4e
function private function_ef19476a614f41ec()
{
    level endon( #"game_ended" );
    level.spectateoverride[ self.pers[ "team" ] ].allowenemyspectate = 1;
    thread scripted_widgets::destroy( "scripted_widget_input_prompts_frun_checkpoints" );
    spectating::updatespectatesettings();
    menus::setspectator();
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0xb4ecb44e, Offset: 0x229c
// Size: 0x14, Type: bool
function private function_bb8b355d1daea488( player )
{
    return namespace_27888f54e9b5bb16::function_28ad61cb6b5e840c( player );
}

// Namespace frune_free_run_evo
// Params 1, eflags: 0x4
// Checksum 0x61c49551, Offset: 0x22b9
// Size: 0x36
function private function_8bd80b07029ff212( player )
{
    if ( namespace_27888f54e9b5bb16::function_28ad61cb6b5e840c( player ) )
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

// Namespace frune_free_run_evo
// Params 5, eflags: 0x4
// Checksum 0x2bddb6a0, Offset: 0x22f8
// Size: 0x30
function private onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    
}

// Namespace frune_free_run_evo
// Params 1
// Checksum 0x55130783, Offset: 0x2330
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

// Namespace frune_free_run_evo
// Params 2, eflags: 0x4
// Checksum 0xaa5eede4, Offset: 0x23f0
// Size: 0x2c, Type: bool
function private function_f78f06ef8f09122( left, right )
{
    return left.score >= right.score;
}

/#

    // Namespace frune_free_run_evo
    // Params 0, eflags: 0x4
    // Checksum 0x4c2add04, Offset: 0x2425
    // Size: 0x2d7, Type: dev
    function private init_debug_free_run()
    {
        namespace_ec33f26de741e14e::function_5a52677cbdd3e5e5( "<dev string:xab>" );
        modeinfo = game[ #"frune_tuning" ];
        
        while ( !modeinfo.var_afad088dc0cd7ba7 )
        {
            waitframe();
        }
        
        namespace_ec33f26de741e14e::registercommand( "<dev string:xaf>", "<dev string:xab>", &debughelp, "<dev string:xb4>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:xd4>", "<dev string:xab>", &function_ce2f4ada6b54487e, "<dev string:xe9>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x105>", "<dev string:xab>", &function_b716dee3a4834dce, "<dev string:x121>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x146>", "<dev string:xab>", &function_59cb5638812a60c2, "<dev string:x15f>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x19a>", "<dev string:xab>", &function_cd0d5abb586964e7, "<dev string:x1b0>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x1e5>", "<dev string:xab>", &function_3d3da41742c4bfd, "<dev string:x1f7>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x228>", "<dev string:xab>", &function_8f24278cdfdb9b22, "<dev string:x241>", "<dev string:xcf>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x26a>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x2ad>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x2ba>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x2cc>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x2d8>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x2f3>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x309>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x325>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x33c>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x354>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x36e>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x382>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x391>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x3ab>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x3c0>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x3d9>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x3f7>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x412>" ] );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x432>", "<dev string:xab>", &function_4928dd331df16a15, "<dev string:x27d>", "<dev string:x2a6>", [ "<dev string:x44c>" ] );
        init_checkpoint_commands();
        namespace_ec33f26de741e14e::function_67acbc0c7e614803( "<dev string:x46b>", "<dev string:xab>" );
    }

    // Namespace frune_free_run_evo
    // Params 0, eflags: 0x4
    // Checksum 0xd7811728, Offset: 0x2704
    // Size: 0x198, Type: dev
    function private init_checkpoint_commands()
    {
        modeinfo = game[ #"frune_tuning" ];
        
        foreach ( zoneinfo in modeinfo.var_afad088dc0cd7ba7 )
        {
            foreach ( checkpointinfo in zoneinfo )
            {
                checkpointindex = checkpointinfo.checkpoint.checkpointindex;
                zoneindex = checkpointinfo.checkpoint.zoneindex;
                var_c99692f6ad82be3c = zoneindex < 10 ? "<dev string:x478>" + zoneindex : zoneindex;
                command = "<dev string:x47a>" + zoneindex + "<dev string:x490>" + checkpointindex;
                namespace_ec33f26de741e14e::registercommand( command, "<dev string:xab>", &function_ce2f4ada6b54487e, "<dev string:x492>", "<dev string:x49e>" + var_c99692f6ad82be3c, [ zoneindex, checkpointindex ] );
            }
        }
    }

    // Namespace frune_free_run_evo
    // Params 5, eflags: 0x4
    // Checksum 0xc9bd0cb5, Offset: 0x28a4
    // Size: 0x5b, Type: dev
    function private registercommand( name, function, help, path, var_b054babccc6dec6 )
    {
        if ( !isdefined( path ) )
        {
            path = "<dev string:x4b0>";
        }
        
        if ( !isdefined( var_b054babccc6dec6 ) )
        {
            var_b054babccc6dec6 = [];
        }
        
        namespace_ec33f26de741e14e::registercommand( name, "<dev string:xab>", function, help, path, var_b054babccc6dec6 );
    }

    // Namespace frune_free_run_evo
    // Params 1
    // Checksum 0xbf91ad5c, Offset: 0x2907
    // Size: 0xa9, Type: dev
    function function_d660450ac1c6adde( player )
    {
        if ( !player )
        {
            assertmsg( "<dev string:x4b1>" );
            return;
        }
        
        start = player geteye();
        dir = anglestoforward( player getplayerangles() );
        end = start + 8000 * dir;
        trace = trace::_bullet_trace( start, end, 1, player );
        target = undefined;
        
        if ( isplayer( trace[ "<dev string:x4e4>" ] ) && player::isreallyalive( trace[ "<dev string:x4e4>" ] ) )
        {
            target = trace[ "<dev string:x4e4>" ];
        }
        
        return target;
    }

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0x2bfc6967, Offset: 0x29b8
    // Size: 0xf1, Type: dev
    function private debughelp( host, args )
    {
        level thread utility::function_72ef0ebf3a428eb9( "<dev string:x4eb>", 30 );
        print( "<dev string:x525>" );
        
        foreach ( name, command in level.var_6ee9e53b11ece9ae.categories[ "<dev string:xab>" ].registeredcommands )
        {
            print( name + "<dev string:x53e>" + ( command.help ?? "<dev string:x541>" ) + "<dev string:x53e>" + command.function );
        }
    }

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0xb2c3aefc, Offset: 0x2ab1
    // Size: 0x5a, Type: dev
    function private function_cd0d5abb586964e7( host, args )
    {
        var_8005b965951cc17 = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:xab>" );
        var_8005b965951cc17.var_7fa2185b014deaa4 = !var_8005b965951cc17.var_7fa2185b014deaa4;
        level thread function_3480ead251c6707( var_8005b965951cc17.var_7fa2185b014deaa4 );
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0xc
    // Checksum 0xff34fa09, Offset: 0x2b13
    // Size: 0x1fb, Type: dev
    function private function_3480ead251c6707( enabled )
    {
        self notify( #"hash_89409d96b9e33359" );
        self endon( #"hash_89409d96b9e33359" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        
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

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0xdb53c8f3, Offset: 0x2d16
    // Size: 0x5a, Type: dev
    function private function_3d3da41742c4bfd( host, args )
    {
        var_8005b965951cc17 = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:xab>" );
        var_8005b965951cc17.var_42a47e4d0e8c77de = !var_8005b965951cc17.var_42a47e4d0e8c77de;
        level thread function_babfa1290207041d( var_8005b965951cc17.var_42a47e4d0e8c77de );
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0xc
    // Checksum 0x8f17840a, Offset: 0x2d78
    // Size: 0x1a0, Type: dev
    function private function_babfa1290207041d( enabled )
    {
        self notify( #"hash_2528335f5257ee82" );
        self endon( #"hash_2528335f5257ee82" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        
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

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0x4
    // Checksum 0xb6c8e5c8, Offset: 0x2f20
    // Size: 0x102, Type: dev
    function private function_a687625d6669d44b( var_50da2b323998951c )
    {
        modeinfo = game[ #"frune_tuning" ];
        
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
            
            if ( distancesq < 100000 )
            {
                var_50da2b323998951c.var_3896b8fa7aec8fad = 1;
            }
        }
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0x4
    // Checksum 0x37737b93, Offset: 0x302a
    // Size: 0x41f, Type: dev
    function private function_3856b08552cf6bc6( checkpointinfo )
    {
        origin = checkpointinfo.checkpoint.origin;
        
        if ( !isdefined( checkpointinfo.checkpointheader ) )
        {
            checkpointinfo.checkpointheader = "<dev string:x551>" + checkpointinfo.checkpoint.zoneindex + "<dev string:x558>" + checkpointinfo.checkpoint.checkpointindex;
        }
        
        if ( !isdefined( checkpointinfo.checkpointdetail ) )
        {
            checkpointinfo.checkpointdetail = "<dev string:x566>" + ( checkpointinfo.checkpoint.script_parameters ?? "<dev string:x4b0>" ) + ( checkpointinfo.checkpoint.var_59e2fdeca3342c99 ? "<dev string:x575>" : "<dev string:x589>" );
        }
        
        loadout = checkpointinfo.checkpoint.pickuploadout;
        
        if ( !isdefined( checkpointinfo.var_8637c126dcf95da4 ) )
        {
            checkpointinfo.var_8637c126dcf95da4 = "<dev string:x59e>" + loadout.debugname;
        }
        
        if ( !isdefined( checkpointinfo.loadoutdetail ) )
        {
            checkpointinfo.loadoutdetail = "<dev string:x5a8>" + loadout.equipment.wingsuit + "<dev string:x5b1>" + ( loadout.weapons.weaponprimary ? loadout.weapons.weaponprimary.basenamehash : 0 ) + "<dev string:x5bc>" + ( loadout.weapons.var_f8995ffbf8047610 ? loadout.weapons.var_f8995ffbf8047610.basenamehash : 0 ) + "<dev string:x5c9>" + loadout.equipment.tactical + "<dev string:x5d5>" + loadout.equipment.lethal;
        }
        
        print3d( origin, checkpointinfo.checkpointheader, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -20 ), checkpointinfo.checkpointdetail, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -40 ), checkpointinfo.var_8637c126dcf95da4, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( origin + ( 0, 0, -60 ), checkpointinfo.loadoutdetail, ( 1, 1, 1 ), 1, 1, 1, 1 );
        box( origin, 0, ( 0, 0, 1 ), 0, 1 );
        drawtrigger( checkpointinfo.checkpoint, ( 0, 0, 1 ), 1 );
        modeinfo = game[ #"frune_tuning" ];
        
        foreach ( spawnpoint in checkpointinfo.checkpoint.a_spawn_points )
        {
            var_ed7f96be80d2f70f = !modeinfo.var_71b7ca7563cc2b95 && spawnpoint.var_94373324515af0b7 ? ( 0, 1, 0 ) : ( 0.75, 0.75, 0.75 );
            box( spawnpoint.origin, 0, var_ed7f96be80d2f70f, 1, 1 );
        }
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0x4
    // Checksum 0x48b08a10, Offset: 0x3451
    // Size: 0x187, Type: dev
    function private function_71c23bdea028e328( pickupinfo )
    {
        origin = pickupinfo.pickupentity.origin;
        
        if ( !isdefined( pickupinfo.loadoutdetail ) )
        {
            pickupinfo.loadoutdetail = "<dev string:x5df>" + pickupinfo.iswingsuit + "<dev string:x5e7>" + pickupinfo.isequipment + "<dev string:x5f4>" + ( pickupinfo.iswingsuit ? "<dev string:x5fc>" : pickupinfo.itemname ?? "<dev string:x4b0>" );
        }
        
        if ( !isdefined( pickupinfo.shortdisplayname ) )
        {
            pickupinfo.shortdisplayname = "<dev string:x605>" + getsubstr( pickupinfo.pickupentity.e_pickup_display.model, 0, 15 );
        }
        
        if ( !pickupinfo.var_3896b8fa7aec8fad )
        {
            print3d( origin + ( 0, 0, 60 ), pickupinfo.loadoutdetail, ( 1, 1, 1 ), 1, 1, 1, 1 );
            print3d( origin + ( 0, 0, 40 ), pickupinfo.shortdisplayname, ( 1, 1, 1 ), 1, 1, 1, 1 );
        }
        
        drawtrigger( pickupinfo.pickupentity, ( 1, 0.75, 0.75 ), 1 );
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0x4
    // Checksum 0xdc99b36f, Offset: 0x35e0
    // Size: 0xb1, Type: dev
    function private function_70dc3506340774cf( player )
    {
        modeinfo = game[ #"frune_tuning" ];
        var_8e8a8aacc07d7a85 = modeinfo.var_afad088dc0cd7ba7[ player.freeruninfo.zoneindex ][ player.freeruninfo.checkpointindex ];
        
        if ( !var_8e8a8aacc07d7a85 )
        {
            return;
        }
        
        var_b2bacc46aa83ae4f = var_8e8a8aacc07d7a85.checkpoint.origin;
        line( player.origin, var_b2bacc46aa83ae4f, ( 0, 0, 1 ), 1, 0, 1 );
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0x4
    // Checksum 0x3838ef88, Offset: 0x3699
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

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0xe382b15c, Offset: 0x3705
    // Size: 0xd5, Type: dev
    function private function_ce2f4ada6b54487e( host, args )
    {
        player = function_d660450ac1c6adde( host ) ?? host;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        zoneindex = int( args[ 0 ] ?? 1 );
        checkpointindex = int( args[ 1 ] ?? 1 );
        checkpointinfo = frune_checkpoints::function_93836aea1333e750( zoneindex, checkpointindex );
        player thread function_8265d8da04af0e50();
        checkpointinfo.checkpoint frune_checkpoints::function_453eed18285c9df7( player, checkpointinfo.checkpoint, 1 );
        newspawnpoint = player frune_checkpoints::get_spawn_point();
        frune_checkpoints::function_bbd98e9afa4895de( player, player.freeruninfo.currentcheckpoint, newspawnpoint );
    }

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0xf61e75ac, Offset: 0x37e2
    // Size: 0x21, Type: dev
    function private function_b716dee3a4834dce( host, args )
    {
        frune_checkpoints::function_829dfb8cf6166f33( host );
    }

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0xf1f2eccf, Offset: 0x380b
    // Size: 0x21, Type: dev
    function private function_59cb5638812a60c2( host, args )
    {
        frune_checkpoints::function_9896bb059895d97( host );
    }

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0x90ff950a, Offset: 0x3834
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

    // Namespace frune_free_run_evo
    // Params 2
    // Checksum 0x4272b9bb, Offset: 0x38d4
    // Size: 0x6d, Type: dev
    function function_d73a3ff7943a2f95( host, args )
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
        
        state = args[ 1 ];
        
        if ( !state )
        {
            return;
        }
        
        player utility::function_32b24db3127bff40( part, state );
    }

    // Namespace frune_free_run_evo
    // Params 0, eflags: 0xc
    // Checksum 0x519752e2, Offset: 0x3949
    // Size: 0x4f, Type: dev
    function private function_8265d8da04af0e50()
    {
        self notify( #"hash_f9cfea93e2716678" );
        self endon( #"hash_f9cfea93e2716678" );
        self.freeruninfo.var_391bebe82698b3d4 = 1;
        waitframe();
        
        if ( !self )
        {
            return;
        }
        
        self.freeruninfo.var_391bebe82698b3d4 = 0;
    }

    // Namespace frune_free_run_evo
    // Params 1, eflags: 0x4
    // Checksum 0x44b04a0d, Offset: 0x39a0
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
        
        if ( result[ "<dev string:x60d>" ] == 1 || result[ "<dev string:x616>" ][ 2 ] <= -10000 )
        {
            return origin;
        }
        
        return result[ "<dev string:x616>" ];
    }

    // Namespace frune_free_run_evo
    // Params 3, eflags: 0x4
    // Checksum 0x78f187d0, Offset: 0x3a58
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

    // Namespace frune_free_run_evo
    // Params 2, eflags: 0x4
    // Checksum 0x21a587f1, Offset: 0x3aa5
    // Size: 0x6d, Type: dev
    function private function_8f24278cdfdb9b22( host, args )
    {
        modeinfo = game[ #"frune_tuning" ];
        modeinfo.var_23a26c9f664b6db2 = !modeinfo.var_23a26c9f664b6db2;
        iprintlnbold( "<dev string:x61f>" + ( modeinfo.var_23a26c9f664b6db2 ? "<dev string:x635>" : "<dev string:x63d>" ) );
    }

#/
