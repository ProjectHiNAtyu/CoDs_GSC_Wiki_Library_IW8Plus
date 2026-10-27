// script_2dcd5249c38ac422  (hash_2dcd5249c38ac422.gscc) (size: 21757 Bytes / 0x54fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f7c7626 (1601992230)
// size ...... 21757 (0x54fd)
// includes .. 32  (offset: 0x4d19)
// strings ... 103 (offset: 0x4e19)
// dev strs .. 12  (offset: 0x5461)
// exports ... 42  (offset: 0x3441)
// cseg ...... 0x8f6 + 0x2b4b (0x3441)
// imports ... 151 (offset: 0x3ad1)
// animtree1 . 0   (offset: 0x54fd)
// animtree2 . 0   (offset: 0x54fd)
#using script_3e8f5758c6655e94;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\class;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\damage;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;

#namespace ctdm;

// Namespace ctdm
// Params 0
// Checksum 0xa01c4f34, Offset: 0x914
// Size: 0x131
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level callback::add( #"hash_fa7263897b3164e", &scoreeventcallback );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerkilled = &onplayerkilled;
    level.onnormaldeath = &onnormaldeath;
    level.onsuicidedeath = &onsuicidedeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerconnect = &onplayerconnect;
    level.var_813f2ea1f9452bdb = &function_e17e444b691a74ba;
    level.objectivehinttext = &"objectives/ctdm";
    function_3160c3f47051cdc3();
    
    if ( game_utility::getgametype() == "ffa_ctdm" )
    {
        level.onplayerscore = &onplayerscore;
        level.teambased = 0;
    }
    
    /#
        debug_init();
    #/
}

// Namespace ctdm
// Params 0
// Checksum 0x64b8610f, Offset: 0xa4d
// Size: 0x412
function function_3160c3f47051cdc3()
{
    level.var_92bcdfd315405e02 = #"hash_6a7fcdf184cc1827";
    level.var_f21454a57f19fe63 = [ #"elimination_assist", #"environment_kill", #"remote_robot_triple", #"sniper_drone_triple" ];
    
    if ( utility::issharedfuncdefined( #"hash_12eb2ef3dcc95127", #"hash_3200ef47334796e2" ) )
    {
        utility::callsharedfunc( #"hash_12eb2ef3dcc95127", #"hash_3200ef47334796e2" );
    }
    
    level.var_63b329f2ebf3c870[ #"common" ] = #"hash_d9ec3d266c100ec3";
    level.var_63b329f2ebf3c870[ #"uncommon" ] = #"hash_d583054e458a1d2e";
    level.var_63b329f2ebf3c870[ #"rare" ] = #"hash_e5f9879ef7b3578";
    level.var_63b329f2ebf3c870[ #"epic" ] = #"hash_9a9b92d42de7ce2b";
    level.var_63b329f2ebf3c870[ #"legendary" ] = #"hash_ebf0a482030c27f7";
    level.var_e2827e2fed21dd5d[ #"common" ] = #"hash_944dcd6c6ef8b9e9";
    level.var_e2827e2fed21dd5d[ #"uncommon" ] = #"hash_c766483b8c822eee";
    level.var_e2827e2fed21dd5d[ #"rare" ] = #"hash_48e517d584b019c8";
    level.var_e2827e2fed21dd5d[ #"epic" ] = #"hash_cf0398558b8ae51";
    level.var_e2827e2fed21dd5d[ #"legendary" ] = #"hash_7360a464ef73cf05";
    level.var_b51c62360e4bc2cb[ #"common" ] = 0;
    level.var_b51c62360e4bc2cb[ #"uncommon" ] = 1;
    level.var_b51c62360e4bc2cb[ #"rare" ] = 2;
    level.var_b51c62360e4bc2cb[ #"epic" ] = 3;
    level.var_b51c62360e4bc2cb[ #"legendary" ] = 4;
    level.perkbuff[ 0 ] = [ "specialty_ping_enemy_after_kill" ];
    level.perkbuff[ level.var_acc54b58c4908aff ] = [ "specialty_tracker_pro" ];
    level.perkbuff[ level.var_5a87d04183940118 ] = [ "specialty_gungho", "specialty_warhead", "specialty_super_speed" ];
    level.perkbuff[ level.var_6e2bc219f60565a9 ] = [ "specialty_bulletaccuracy", "specialty_quickdraw", "specialty_fastsprintrecovery", "specialty_fastreload", "specialty_quickswap", "specialty_tac_mask" ];
    level.perkbuff[ level.var_f9365466c3def42a ] = [ "specialty_engineer", "specialty_flak_jacket" ];
    level.perksplash[ level.var_6e2bc219f60565a9 ] = "ctdm_point_buff_active";
    level.var_6e56306c12fb1f14 = "uin_ctdm_combo_ends";
    level.currencysfx = [ "uin_ctdm_currency_acquired_1", "uin_ctdm_currency_acquired_2", "uin_ctdm_currency_acquired_3", "uin_ctdm_currency_acquired_4", "uin_ctdm_currency_acquired_5", "uin_ctdm_currency_acquired_6" ];
    level.buffsfx[ level.var_acc54b58c4908aff ] = "uin_ctdm_buff_activated_1";
    level.buffsfx[ level.var_5a87d04183940118 ] = "uin_ctdm_buff_activated_2";
    level.buffsfx[ level.var_281818ec1ca88c6f ] = "uin_ctdm_buff_activated_3";
    level.buffsfx[ level.var_6e2bc219f60565a9 ] = "uin_ctdm_double_points_activated";
    level.buffsfx[ level.var_f9365466c3def42a ] = "uin_ctdm_double_points_activated";
    level.nosuspensemusic = 1;
    level.var_58d8fc0be2622f35 = [ %"skewer_proj_mp", %"sat_dawg_turret", %"ground_drone_unit" ];
    thread initaudio();
}

// Namespace ctdm
// Params 0
// Checksum 0xccdd0ef9, Offset: 0xe67
// Size: 0x141
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.combotimer = getmatchrulesdata( "ctdmData", "comboTimer" );
    level.combobaseactionpoints = getmatchrulesdata( "ctdmData", "comboBaseActionPoints" );
    level.var_bf06f0e5d66eb6cc = getmatchrulesdata( "ctdmData", "uncommonPointMultiplier" );
    level.var_27cbe046e31462ae = getmatchrulesdata( "ctdmData", "rarePointMultiplier" );
    level.var_6ffed4bad05746bf = getmatchrulesdata( "ctdmData", "epicPointMultiplier" );
    level.var_ba75b67dcccc6b97 = getmatchrulesdata( "ctdmData", "legendaryPointMultiplier" );
    level.suicidecompletescombos = getmatchrulesdata( "ctdmData", "suicideCompletesCombos" );
    level.var_533212cd6946dc43 = getmatchrulesdata( "ctdmData", "buffPointMultiplier" );
    level.var_acc54b58c4908aff = getmatchrulesdata( "ctdmData", "buffunlockValue1" );
    level.var_5a87d04183940118 = getmatchrulesdata( "ctdmData", "buffunlockValue2" );
    level.var_281818ec1ca88c6f = getmatchrulesdata( "ctdmData", "buffunlockValue3" );
    level.var_6e2bc219f60565a9 = getmatchrulesdata( "ctdmData", "buffunlockValue4" );
    level.var_f9365466c3def42a = getdvarint( @"hash_f436c8ccd1181c23", getmatchrulesdata( "ctdmData", "buffunlockValue5" ) );
}

// Namespace ctdm
// Params 0, eflags: 0x4
// Checksum 0x5ea0d399, Offset: 0xfb0
// Size: 0x27
function private initaudio()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_ctdm_t10" );
}

// Namespace ctdm
// Params 0
// Checksum 0xf1d6c1fb, Offset: 0xfdf
// Size: 0x17b
function updategametypedvars()
{
    common::updatecommongametypedvars();
    setdvar( @"hash_94084550cb0f64e7", getdvar( @"hash_cb8812889ede7ffa", getmatchrulesdata( "ctdmData", "buffSpeedScalar" ) ) );
    setdvar( @"hash_1fb62cba30c88302", getdvar( @"scr_ctdm_perk_quickdrawspeedscalemp", getmatchrulesdata( "ctdmData", "buffQDScaleMP" ) ) );
    setdvar( @"hash_8632771afc580d81", getdvar( @"hash_eaa09100cc3f7f1a", getmatchrulesdata( "ctdmData", "buffQDScaleSniper" ) ) );
    setdvar( @"hash_e213f58b73990a36", getdvar( @"hash_12ca9a64c5172b8a", getmatchrulesdata( "ctdmData", "buffWeapSpreadMultiplier" ) ) );
    setdvar( @"hash_b7318d7f06303895", 1 );
    level.var_840a69ffc5af302d = getdvarint( @"hash_d5c6b4a56415ccfd", 5 );
    level.buffvisionminrange = getdvarint( @"hash_319b59a1769dc223", getmatchrulesdata( "ctdmData", "buffVisionMinRange" ) );
    level.buffvisionmaxrange = getdvarint( @"hash_8ce43d8a5d3fa3c9", getmatchrulesdata( "ctdmData", "buffVisionMaxRange" ) );
    level.cutmusic = getdvarint( @"hash_c19dac07692abf80", 0 );
    level.buffduration = getdvarfloat( @"hash_d5b8442ab13b8cfe", 1 );
    level.var_367eda7c3b627193 = getdvarint( @"hash_ca84f7985faefe32", 1 );
    level.var_d8b4e5f833325932 = getdvarint( @"hash_20226cc6fac3ea19", 0 );
}

// Namespace ctdm
// Params 5
// Checksum 0xea499092, Offset: 0x1162
// Size: 0x31, Type: bool
function onplayerscore( event, player, originalpoints, victim, eventinfo )
{
    return false;
}

// Namespace ctdm
// Params 0
// Checksum 0x927dce19, Offset: 0x119c
// Size: 0x4b, Type: bool
function function_e17e444b691a74ba()
{
    if ( level.scoremod[ "kill" ] > 0 && dialog_utility::dialogueexists( #"boost_groundwar", self.team ) )
    {
        dialog::leaderdialogonplayer( #"boost_groundwar", "introboost" );
        return true;
    }
    
    return false;
}

// Namespace ctdm
// Params 0
// Checksum 0xe9845ce6, Offset: 0x11f0
// Size: 0xd2
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace ctdm
// Params 0
// Checksum 0xe098d43c, Offset: 0x12ca
// Size: 0xe3
function onstartgametype()
{
    if ( level.scoremod[ "kill" ] > 0 )
    {
        game[ "dialog" ][ "offense_obj" ] = "boost_groundwar";
        game[ "dialog" ][ "defense_obj" ] = "boost_groundwar";
    }
    
    setclientnamemode( "auto_change" );
    
    if ( !level.var_8a8634aee437d120 )
    {
        initspawns();
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        game_utility_mp::setobjectivehinttext( teamname, level.objectivehinttext );
    }
    
    thread function_7bfa08bcf9cb4831();
}

// Namespace ctdm
// Params 1
// Checksum 0x1f0c5fad, Offset: 0x13b5
// Size: 0xa5
function onplayerconnect( player )
{
    player.combohighscore = 0;
    player stats::setextrascore0( player.pers[ "combo_score" ] ?? 0, "combo_score" );
    player stats::setextrascore1( player.pers[ "combo_high_score" ] ?? 0, "combo_high_score" );
    player stats::setextrascore2( player.pers[ "combo_action_count" ] ?? 0, "combo_action_count" );
    player stats::setextrascore3( player.pers[ "combo_heat_time" ] ?? 0, "combo_heat_time" );
}

// Namespace ctdm
// Params 1
// Checksum 0xc5e0bef7, Offset: 0x1462
// Size: 0x45
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    
    if ( isdefined( self.var_db13a7f13b28f6f3 ) )
    {
        thread function_603cb7c7498d7a58();
    }
    
    function_e2b3ca1c2b2ffc7e();
    thread function_f82f63cfdc45b6c2();
    thread function_64e31519156ac9fa();
}

// Namespace ctdm
// Params 1
// Checksum 0x4b10827e, Offset: 0x14af
// Size: 0x2c
function onsuicidedeath( victim )
{
    victim setscriptablepartstate( "ctdm_vfx", #"disabled" );
    victim thread completecombo( 1 );
}

// Namespace ctdm
// Params 10
// Checksum 0x397c857f, Offset: 0x14e3
// Size: 0x7b
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( damage::isteamkill( einflictor, attacker ) )
    {
        thread completecombo( 1, self.var_9a865e031e0b80c5 );
    }
}

// Namespace ctdm
// Params 6
// Checksum 0xe6d5a8c0, Offset: 0x1566
// Size: 0x150
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    victim setscriptablepartstate( "ctdm_vfx", #"disabled" );
    
    if ( isdefined( victim ) )
    {
        if ( attacker && victim.var_9a865e031e0b80c5 >= level.var_6e2bc219f60565a9 )
        {
            if ( level.var_92bcdfd315405e02 )
            {
                attacker thread points::doscoreevent( level.var_92bcdfd315405e02 );
            }
        }
        
        victim thread completecombo( 1 );
    }
    
    if ( isdefined( attacker ) )
    {
        var_29e11bcddabcdfcf = attacker.var_c3d35f71d5f4bd8c == 0 && arraycontains( level.var_58d8fc0be2622f35, objweapon.basenamehash );
        
        if ( attacker.var_c3d35f71d5f4bd8c >= level.var_acc54b58c4908aff - 1 && !var_29e11bcddabcdfcf )
        {
            attacker playerhealth::forcehealthregen( attacker, 0, 5 );
            attacker function_e3fbd6083c86dc72();
        }
        
        attacker.var_5857c12926dd5950++;
        
        if ( attacker.var_9a865e031e0b80c5 >= level.var_6e2bc219f60565a9 )
        {
            attacker.overdrive_eliminations++;
        }
    }
}

// Namespace ctdm
// Params 0
// Checksum 0x597d4338, Offset: 0x16be
// Size: 0x107
function function_e2b3ca1c2b2ffc7e()
{
    self notify( #"combo_reset" );
    self setclientomnvar( "ui_ctdm_buff_unlock_level", 0 );
    self setclientomnvar( "ui_ctdm_combo_score", 0 );
    self setclientomnvar( "ui_ctdm_timer", 0 );
    self setclientomnvar( "ui_ctdm_buff_level", 0 );
    self.combostack = [];
    self.var_9a865e031e0b80c5 = 0;
    self.var_5857c12926dd5950 = 0;
    self.overdrive_eliminations = 0;
    self.var_c3d35f71d5f4bd8c = 0;
    self.var_215ce6b49995180d = 0;
    self.var_fe3cbc0b2f8e77f4 = 0;
    self.var_a004d3f769e66611 = undefined;
    self.var_4c292e8f6d06e7b7 = 0;
    self.var_68472bad34e3a34c = 0;
    self.combo_overdrive_start_time = 0;
    self.combo_completion_method = "";
    self.combo_points = 0;
    self.common_actions = 0;
    self.uncommon_actions = 0;
    self.rare_actions = 0;
    self.epic_actions = 0;
    self.legendary_actions = 0;
    self.startedcombo = 0;
    thread debuffplayer();
}

// Namespace ctdm
// Params 0
// Checksum 0x21c31183, Offset: 0x17cd
// Size: 0x4a
function function_603cb7c7498d7a58()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 1;
    self setclientomnvar( "ui_ctdm_comboComplete", self.var_db13a7f13b28f6f3 );
    wait 1;
    self.var_db13a7f13b28f6f3 = undefined;
    self setclientomnvar( "ui_ctdm_comboComplete", 0 );
}

// Namespace ctdm
// Params 0
// Checksum 0xa23c9d41, Offset: 0x181f
// Size: 0x93
function function_d8785a5be4878b5()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_fd1a86b9543edfd8 = 0;
    
    while ( self.var_fe3cbc0b2f8e77f4 > 0 )
    {
        soundindex = var_fd1a86b9543edfd8 < level.currencysfx.size ? var_fd1a86b9543edfd8 : level.currencysfx.size - 1;
        self playlocalsound( level.currencysfx[ soundindex ] );
        var_fd1a86b9543edfd8++;
        self.var_fe3cbc0b2f8e77f4--;
        wait 0.2;
    }
    
    self.var_215ce6b49995180d = 0;
}

// Namespace ctdm
// Params 1
// Checksum 0xd11fbced, Offset: 0x18ba
// Size: 0x491
function function_cc9f2f21e60e2f31( eventrarity )
{
    buffmultiplier = self.var_9a865e031e0b80c5 >= level.var_6e2bc219f60565a9 ? level.var_533212cd6946dc43 : 1;
    thread points::doscoreevent( level.var_63b329f2ebf3c870[ eventrarity ] );
    
    if ( buffmultiplier != 1 )
    {
        thread points::doscoreevent( level.var_e2827e2fed21dd5d[ eventrarity ] );
    }
    
    switch ( eventrarity )
    {
        case #"common":
            self.common_actions += 1;
            break;
        case #"uncommon":
            buffmultiplier *= level.var_bf06f0e5d66eb6cc;
            self.uncommon_actions += 1;
            break;
        case #"rare":
            buffmultiplier *= level.var_27cbe046e31462ae;
            self.rare_actions += 1;
            break;
        case #"epic":
            buffmultiplier *= level.var_6ffed4bad05746bf;
            self.epic_actions += 1;
            break;
        case #"legendary":
            buffmultiplier *= level.var_ba75b67dcccc6b97;
            self.legendary_actions += 1;
            break;
        default:
            println( "<dev string:x24>" + getxhashsourcename( eventrarity ) + "<dev string:x42>" );
            break;
    }
    
    self.var_fe3cbc0b2f8e77f4 += int( buffmultiplier );
    
    if ( !self.var_215ce6b49995180d )
    {
        self.var_215ce6b49995180d = 1;
        thread function_d8785a5be4878b5();
    }
    
    finalpoints = int( level.combobaseactionpoints * buffmultiplier );
    self.var_9a865e031e0b80c5 += finalpoints;
    
    if ( level.gametype == "ffa_ctdm" )
    {
        self.score += finalpoints;
        thread gamelogic_mp::checkscorelimit();
    }
    else if ( !level.var_74e022d392216526 )
    {
        level gamescore::giveteamscoreforobjective( self.pers[ "team" ], finalpoints, 1 );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "combo_score" ] ) )
        {
            self.leaderboarddata[ "combo_score" ] = self.leaderboarddata[ "combo_score" ] + finalpoints;
        }
        
        if ( isdefined( level.leaderboardfunc[ "combo_score" ] ) )
        {
            [[ level.leaderboardfunc[ "combo_score" ] ]]( self, finalpoints );
        }
        
        assert( isint( finalpoints ) || isfloat( finalpoints ), "<dev string:x44>" );
        
        if ( isdefined( self.pers[ "combo_score" ] ) )
        {
            self.pers[ "combo_score" ] = self.pers[ "combo_score" ] + finalpoints;
        }
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "combo_action_count" ] ) )
        {
            self.leaderboarddata[ "combo_action_count" ] = self.leaderboarddata[ "combo_action_count" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "combo_action_count" ] ) )
        {
            [[ level.leaderboardfunc[ "combo_action_count" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x44>" );
        
        if ( isdefined( self.pers[ "combo_action_count" ] ) )
        {
            self.pers[ "combo_action_count" ] = self.pers[ "combo_action_count" ] + 1;
        }
    }
    
    if ( level.var_38fbee7174a3ef13 )
    {
        stats::setextrascore4( self.pers[ "combo_score" ] );
    }
    else
    {
        stats::setextrascore0( self.pers[ "combo_score" ] );
        stats::setextrascore2( self.pers[ "combo_action_count" ] );
    }
    
    for ( bufflevel = self.var_c3d35f71d5f4bd8c + 1; bufflevel <= self.var_9a865e031e0b80c5 ; bufflevel++ )
    {
        self setclientomnvar( "ui_ctdm_combo_score", bufflevel );
        buffplayer( bufflevel );
    }
    
    self.var_c3d35f71d5f4bd8c = self.var_9a865e031e0b80c5;
}

// Namespace ctdm
// Params 2
// Checksum 0x4cbaf2ac, Offset: 0x1d53
// Size: 0x36b
function completecombo( isdead, var_4845c90770c715b4 )
{
    self endon( #"death_or_disconnect" );
    self.var_9a865e031e0b80c5 = var_4845c90770c715b4 && self.var_9a865e031e0b80c5 == 0 ? var_4845c90770c715b4 : self.var_9a865e031e0b80c5;
    
    if ( !isdefined( self.var_9a865e031e0b80c5 ) )
    {
        return;
    }
    
    if ( isdead && level.suicidecompletescombos )
    {
        self.combo_completion_method = "death";
        function_cd7417bd40aaeb16();
        self setscriptablepartstate( "ctdm_vfx", #"disabled" );
        function_e2b3ca1c2b2ffc7e();
        return;
    }
    
    if ( self.var_9a865e031e0b80c5 != 0 && level.teambased )
    {
        self.combo_completion_method = "timer_end";
        
        if ( isdead )
        {
            self.combo_completion_method = "death";
        }
        
        self.var_9a865e031e0b80c5 = int( self.var_9a865e031e0b80c5 );
        
        if ( self.combohighscore < self.var_9a865e031e0b80c5 )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "combo_high_score" ] ) )
                {
                    self.leaderboarddata[ "combo_high_score" ] = self.leaderboarddata[ "combo_high_score" ] + self.var_9a865e031e0b80c5 - self.combohighscore;
                }
                
                if ( isdefined( level.leaderboardfunc[ "combo_high_score" ] ) )
                {
                    [[ level.leaderboardfunc[ "combo_high_score" ] ]]( self, self.var_9a865e031e0b80c5 - self.combohighscore );
                }
                
                assert( isint( self.var_9a865e031e0b80c5 - self.combohighscore ) || isfloat( self.var_9a865e031e0b80c5 - self.combohighscore ), "<dev string:x44>" );
                
                if ( isdefined( self.pers[ "combo_high_score" ] ) )
                {
                    self.pers[ "combo_high_score" ] = self.pers[ "combo_high_score" ] + self.var_9a865e031e0b80c5 - self.combohighscore;
                }
            }
            
            if ( level.var_38fbee7174a3ef13 )
            {
                stats::function_fe615555f60e88b9( self.pers[ "combo_high_score" ] );
            }
            else
            {
                stats::setextrascore1( self.pers[ "combo_high_score" ] );
            }
            
            self.combohighscore = self.var_9a865e031e0b80c5;
        }
        
        thread points::doscoreevent( #"ctdm_combo_complete", undefined, int( 0 ) );
        
        if ( isdead )
        {
            self.var_db13a7f13b28f6f3 = self.var_9a865e031e0b80c5;
            self setclientomnvar( "ui_ctdm_comboComplete", self.var_db13a7f13b28f6f3 );
        }
        else
        {
            self setclientomnvar( "ui_ctdm_comboComplete", self.var_9a865e031e0b80c5 );
        }
        
        self.combo_points = self.var_9a865e031e0b80c5;
        function_cd7417bd40aaeb16();
        
        if ( self.combo_points >= level.var_840a69ffc5af302d )
        {
            level.var_840a69ffc5af302d = self.combo_points + 1;
            thread hud_util::teamplayercardsplash( "splash_global_ctdm_high_score", self, undefined, self.combo_points );
        }
        
        self playlocalsound( level.var_6e56306c12fb1f14 );
    }
    
    self setscriptablepartstate( "ctdm_vfx", #"disabled" );
    function_e2b3ca1c2b2ffc7e();
    wait 1;
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_ctdm_comboComplete", 0 );
    }
}

// Namespace ctdm
// Params 0
// Checksum 0x2f19dfd9, Offset: 0x20c6
// Size: 0x130
function function_cd7417bd40aaeb16()
{
    self dlog_recordplayerevent( "dlog_event_mp_player_combo_complete", [ "combo_duration_ms", self.var_68472bad34e3a34c ?? 0, "combo_overdrive_start_time_ms", self.combo_overdrive_start_time ?? 0, "combo_completion_method", self.combo_completion_method ?? "", "combo_points", self.combo_points ?? 0, "total_eliminations", self.var_5857c12926dd5950 ?? 0, "overdrive_eliminations", self.overdrive_eliminations ?? 0, "common_actions", self.common_actions ?? 0, "uncommon_actions", self.uncommon_actions ?? 0, "rare_actions", self.rare_actions ?? 0, "epic_actions", self.epic_actions ?? 0, "legendary_actions", self.legendary_actions ?? 0 ] );
}

// Namespace ctdm
// Params 0
// Checksum 0x1053d42a, Offset: 0x21fe
// Size: 0x9c
function function_64e31519156ac9fa()
{
    self notify( #"hash_f65d9dc41ffcd830" );
    self endon( #"hash_f65d9dc41ffcd830" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"kill_event_buffered", victim );
        
        if ( !isdefined( victim ) )
        {
            continue;
        }
        
        victimid = victim getentitynumber();
        
        if ( isdefined( self.var_a004d3f769e66611[ victimid ] ) )
        {
            function_cc9f2f21e60e2f31( self.var_a004d3f769e66611[ victimid ] );
            self.var_a004d3f769e66611[ victimid ] = undefined;
        }
    }
}

// Namespace ctdm
// Params 1
// Checksum 0x83430cca, Offset: 0x22a2
// Size: 0x15c
function scoreeventcallback( params )
{
    event = params.event;
    rarity = rank::function_8d9af562bea8a67f( event );
    
    if ( rarity != #"" )
    {
        self.combostack[ self.combostack.size ] = event;
        
        if ( !isdefined( self.lastkilledplayer ) || arraycontains( level.var_f21454a57f19fe63, params.event ) )
        {
            function_cc9f2f21e60e2f31( rarity );
            function_e3fbd6083c86dc72();
        }
        else
        {
            victimid = self.lastkilledplayer getentitynumber();
            
            if ( isdefined( self.var_a004d3f769e66611[ victimid ] ) )
            {
                if ( level.var_b51c62360e4bc2cb[ rarity ] > level.var_b51c62360e4bc2cb[ self.var_a004d3f769e66611[ victimid ] ] )
                {
                    self.var_a004d3f769e66611[ victimid ] = rarity;
                }
            }
            else
            {
                self.var_a004d3f769e66611[ victimid ] = rarity;
            }
        }
        
        if ( !self.startedcombo )
        {
            self.startedcombo = 1;
            thread function_8f6c24dc8ff95957();
        }
        
        thread function_a48d34573687fda6( level.combotimer );
        thread function_dfe281c18003c646( level.combotimer );
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            self playlocalsound( #"mp_cranked_splash" );
        }
    }
}

// Namespace ctdm
// Params 1
// Checksum 0xcd8875ca, Offset: 0x2406
// Size: 0x18f
function function_a48d34573687fda6( waittime )
{
    self notify( #"hash_310cbe65994484e6" );
    self endon( #"hash_310cbe65994484e6" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    countdown_time = waittime;
    
    while ( countdown_time > 0 )
    {
        if ( self.var_b87cafbca06df20f )
        {
            waitframe();
            continue;
        }
        
        hostmigration::waitlongdurationwithgameendtimeupdate( 1 );
        countdown_time--;
        
        if ( self.var_9a865e031e0b80c5 >= level.var_6e2bc219f60565a9 )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "combo_heat_time" ] ) )
                {
                    self.leaderboarddata[ "combo_heat_time" ] = self.leaderboarddata[ "combo_heat_time" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "combo_heat_time" ] ) )
                {
                    [[ level.leaderboardfunc[ "combo_heat_time" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x44>" );
                
                if ( isdefined( self.pers[ "combo_heat_time" ] ) )
                {
                    self.pers[ "combo_heat_time" ] = self.pers[ "combo_heat_time" ] + 1;
                }
            }
            
            stats::setextrascore3( self.pers[ "combo_heat_time" ] );
        }
    }
    
    self setclientomnvar( "ui_ctdm_timer", 0 );
    
    if ( player::isreallyalive( self ) )
    {
        thread completecombo( 0 );
    }
}

// Namespace ctdm
// Params 1
// Checksum 0x2a972af2, Offset: 0x259d
// Size: 0xd4
function function_dfe281c18003c646( waittime )
{
    self notify( #"hash_e4a2524373f0593b" );
    self endon( #"hash_e4a2524373f0593b" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    currenttimelimitdelay = 0;
    
    if ( waittime != level.combotimer )
    {
        currenttimelimitdelay = level.combotimer - waittime;
    }
    
    self setclientomnvar( "ui_ctdm_timer", 1 );
    
    while ( isalive( self ) )
    {
        currenttimelimitdelay += self.var_b87cafbca06df20f ? 0 : level.framedurationseconds;
        progress = clamp( 1 - currenttimelimitdelay / level.combotimer, 0, 1 );
        self setclientomnvar( "ui_ctdm_timer", progress );
        waitframe();
    }
}

// Namespace ctdm
// Params 0
// Checksum 0xe727b637, Offset: 0x2679
// Size: 0x60
function function_8f6c24dc8ff95957()
{
    self endon( #"death_or_disconnect" );
    self endon( #"combo_reset" );
    var_8682d885f65314ac = gettime();
    
    while ( true )
    {
        var_38ab1a8ecfb1cfbd = gettime();
        self.var_68472bad34e3a34c += ( var_38ab1a8ecfb1cfbd - var_8682d885f65314ac ) / 1000;
        var_8682d885f65314ac = var_38ab1a8ecfb1cfbd;
        waitframe();
    }
}

// Namespace ctdm
// Params 0
// Checksum 0x169c1289, Offset: 0x26e1
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace ctdm
// Params 0
// Checksum 0xfd838b3e, Offset: 0x26f3
// Size: 0xa7
function function_f82f63cfdc45b6c2()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 2;
    
    if ( isdefined( level.perkbuff[ 0 ] ) )
    {
        foreach ( perk in level.perkbuff[ 0 ] )
        {
            perk::giveperk( perk );
        }
    }
}

// Namespace ctdm
// Params 1
// Checksum 0x4297778b, Offset: 0x27a2
// Size: 0x2b6
function buffplayer( bufflevel )
{
    self setclientomnvar( "ui_ctdm_buff_level", bufflevel );
    
    if ( isdefined( level.perksplash[ bufflevel ] ) )
    {
        hud_message::function_78fedf6f526825f4( level.perksplash[ bufflevel ], level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    if ( isdefined( level.perkbuff[ bufflevel ] ) )
    {
        foreach ( perk in level.perkbuff[ bufflevel ] )
        {
            perk::giveperk( perk );
            self.var_ee1c92198ad66b2f[ self.var_ee1c92198ad66b2f.size ] = perk;
        }
    }
    
    if ( isdefined( level.buffsfx[ bufflevel ] ) )
    {
        self playlocalsound( level.buffsfx[ bufflevel ] );
    }
    
    if ( bufflevel == level.var_281818ec1ca88c6f && !isbot( self ) )
    {
        self function_744ec8023439271f( 3000, 1000, 1500 );
        thread function_cf15054787c93a84( bufflevel );
        self setscriptablepartstate( "ctdm_vfx", #"hash_663cdfe28a2018e7" );
    }
    
    if ( bufflevel == level.var_5a87d04183940118 )
    {
        self.var_fff20d0e22e94e9c = 1;
        thread function_cf15054787c93a84( bufflevel );
        self setscriptablepartstate( "ctdm_vfx", #"hash_663ce0e28a201a9a" );
    }
    
    if ( bufflevel == level.var_6e2bc219f60565a9 )
    {
        thread function_804034e98448529f( #"hash_663ce1e28a201c4d" );
        wait 1;
        self playlocalsound( "uin_ctdm_double_points_activated" );
        thread function_cf15054787c93a84( bufflevel );
        thread function_b27ca7dfae6f0095( bufflevel );
        self.combo_overdrive_start_time = self.var_68472bad34e3a34c;
    }
    
    if ( bufflevel == level.var_f9365466c3def42a )
    {
        thread function_804034e98448529f( #"hash_663cdae28a201068" );
        val::set( "d_mod_augments", "fire_time_scale", getdvarint( @"hash_34383669aad7b1e0", 75 ) );
        
        if ( getdvarint( @"hash_84d0e2b40092d967", 0 ) )
        {
            specialty_perkstreak::function_411c641304808fe7();
        }
        
        weapons = self getweaponslistall();
        
        foreach ( weapon in weapons )
        {
            self givestartammo( weapon );
        }
    }
}

// Namespace ctdm
// Params 1
// Checksum 0xfc31b6d1, Offset: 0x2a60
// Size: 0xbf
function function_804034e98448529f( buffstate )
{
    self notify( #"hash_9474405f751c7ac4" );
    self endon( #"hash_9474405f751c7ac4" );
    self endon( #"death_or_disconnect" );
    self endon( #"combo_reset" );
    level endon( #"game_ended" );
    ishidden = 0;
    self setscriptablepartstate( "ctdm_vfx", buffstate );
    waitframe();
    
    while ( true )
    {
        var_8f12a71dc258dde8 = supers_mp::function_60dbd7e2f1b02c22();
        
        if ( var_8f12a71dc258dde8 && !ishidden )
        {
            self setscriptablepartstate( "ctdm_vfx", #"disabled" );
            ishidden = 1;
        }
        else if ( !var_8f12a71dc258dde8 && ishidden )
        {
            self setscriptablepartstate( "ctdm_vfx", buffstate );
            ishidden = 0;
        }
        
        waitframe();
    }
}

// Namespace ctdm
// Params 1
// Checksum 0xd01de577, Offset: 0x2b27
// Size: 0xec
function function_b27ca7dfae6f0095( bufflevel )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( bufflevel == level.var_6e2bc219f60565a9 && !level.cutmusic )
    {
        self.loopsoundstruct = spawn( "script_model", self gettagorigin( "j_spineupper" ) );
        self.loopsoundstruct setmodel( "tag_origin" );
        self.loopsoundstruct linkto( self, "j_spineupper", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        waitframe();
        
        if ( !self.var_9105cbb67934af01 )
        {
            thread musicbank_utility::function_5aca66c390aa347d( self, #"mp_overdrive_intro" );
            self.var_9105cbb67934af01 = 1;
        }
        else
        {
            thread musicbank_utility::function_5aca66c390aa347d( self, #"mp_overdrive_loop" );
        }
        
        thread function_17e129edfdc80f02( self.loopsoundstruct );
    }
}

// Namespace ctdm
// Params 1
// Checksum 0x8612d94d, Offset: 0x2c1b
// Size: 0x64
function function_cf15054787c93a84( bufflevel )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self.var_4c292e8f6d06e7b7 )
    {
        wait 3;
        thread function_cf15054787c93a84( bufflevel );
        return;
    }
    
    self setclientomnvar( "ui_ctdm_buff_unlock_level", bufflevel );
    self.var_4c292e8f6d06e7b7 = 1;
    wait 3;
    self.var_4c292e8f6d06e7b7 = 0;
}

// Namespace ctdm
// Params 0
// Checksum 0xb83f9379, Offset: 0x2c87
// Size: 0x12b
function debuffplayer()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.var_fff20d0e22e94e9c = 0;
    
    if ( isdefined( self.var_ee1c92198ad66b2f ) )
    {
        foreach ( perk in self.var_ee1c92198ad66b2f )
        {
            perk::removeperk( perk );
        }
    }
    
    self.var_ee1c92198ad66b2f = [];
    
    if ( self.pers[ "perkPoints" ] < level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 3 ].score )
    {
        function_49cd3d064d431196();
    }
    
    val::set( "d_mod_augments", "fire_time_scale", 100 );
    function_b0064754af8ab8e7( 0 );
    self function_c67c92094ae6ccf7();
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( "ctdm_vfx", #"disabled" );
    }
}

// Namespace ctdm
// Params 0
// Checksum 0xf53cb843, Offset: 0x2dba
// Size: 0x127
function function_49cd3d064d431196()
{
    var_fe70c602efa09fe7 = perks::function_73c2b12682fac654();
    var_fe70c602efa09fe7 = arrayremove( var_fe70c602efa09fe7, "specialty_supersprint" );
    var_222e15f0ab6a381c = arraycombine( self.pers[ "loadoutPerks" ], self.perkstreaks );
    
    foreach ( perk in var_222e15f0ab6a381c )
    {
        var_fe70c602efa09fe7 = arrayremove( var_fe70c602efa09fe7, perk );
    }
    
    foreach ( perkref in var_fe70c602efa09fe7 )
    {
        class::loadout_removeperk( perkref );
    }
}

// Namespace ctdm
// Params 0
// Checksum 0xf770c870, Offset: 0x2ee9
// Size: 0x32
function function_e3fbd6083c86dc72()
{
    if ( self.var_9a865e031e0b80c5 >= level.var_281818ec1ca88c6f - 1 )
    {
        setoperativeoutlines();
        thread function_b0064754af8ab8e7( level.buffduration );
    }
}

// Namespace ctdm
// Params 0
// Checksum 0x4ea8d355, Offset: 0x2f23
// Size: 0x16d
function setoperativeoutlines()
{
    self notify( #"hash_a644e5e2f0f12379" );
    self endon( #"hash_a644e5e2f0f12379" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"end_death_perception" );
    
    if ( !isdefined( self.var_2c91d8ad75e3895b ) )
    {
        self.var_2c91d8ad75e3895b = [];
    }
    
    enemyteam = team_utility::getotherteam( self.team );
    
    foreach ( enemy in level.teamdata[ enemyteam ][ "players" ] )
    {
        if ( level.var_367eda7c3b627193 && enemy.var_cbd4681f351fbad2 )
        {
            continue;
        }
        
        if ( level.var_d8b4e5f833325932 && enemy.canghost )
        {
            continue;
        }
        
        enemyentnum = enemy getentitynumber();
        
        if ( !isdefined( self.var_2c91d8ad75e3895b[ enemyentnum ] ) && isalive( enemy ) )
        {
            self.var_2c91d8ad75e3895b[ enemyentnum ] = outline::outlineenableforplayer( enemy, self, "sat_vision_pulse_hudoutline_player", "level_script" );
        }
    }
}

// Namespace ctdm
// Params 1
// Checksum 0xc8d6a805, Offset: 0x3098
// Size: 0x117
function function_b0064754af8ab8e7( delaytime )
{
    self notify( #"hash_43444019d5321228" );
    self endon( #"hash_43444019d5321228" );
    
    if ( !isarray( self.var_2c91d8ad75e3895b ) )
    {
        return;
    }
    
    if ( delaytime )
    {
        self endon( #"setoperative_outlines" );
        self endon( #"death_or_disconnect" );
        wait delaytime;
    }
    
    foreach ( enemy in level.players )
    {
        if ( !isplayer( enemy ) )
        {
            continue;
        }
        
        enemyentnum = enemy getentitynumber();
        
        if ( !isdefined( self.var_2c91d8ad75e3895b[ enemyentnum ] ) )
        {
            continue;
        }
        
        outline::outlinedisable( self.var_2c91d8ad75e3895b[ enemyentnum ], enemy );
        self.var_2c91d8ad75e3895b[ enemyentnum ] = undefined;
    }
}

// Namespace ctdm
// Params 1
// Checksum 0xa516f217, Offset: 0x31b7
// Size: 0x4d
function function_17e129edfdc80f02( loopsoundstruct )
{
    utility::waittill_any( "death_or_disconnect", "combo_reset", "game_ended" );
    
    if ( !level.cutmusic && loopsoundstruct )
    {
        thread musicbank_utility::function_5aca66c390aa347d( self, #"mp_overdrive_stop" );
        loopsoundstruct delete();
    }
}

// Namespace ctdm
// Params 0, eflags: 0x4
// Checksum 0x44314cc0, Offset: 0x320c
// Size: 0xa0
function private function_7bfa08bcf9cb4831()
{
    level waittill( #"start_game_ended" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player.combo_completion_method = "match_end";
            player thread completecombo( 0 );
        }
    }
}

/#

    // Namespace ctdm
    // Params 0, eflags: 0x4
    // Checksum 0x8bdaf620, Offset: 0x32b4
    // Size: 0x70, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6a>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x77>", "<dev string:x8d>", &function_c56596cfe7384e2a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x99>", "<dev string:xb0>", &function_c56596cfe7384e2a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xbc>", "<dev string:xd2>", &function_c56596cfe7384e2a );
        devgui::add_devgui_func( "<dev string:xde>", "<dev string:xf5>", &function_66938dd6b76a0434 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ctdm
    // Params 1, eflags: 0x4
    // Checksum 0xfaf0aa91, Offset: 0x332c
    // Size: 0x8f, Type: dev
    function private function_c56596cfe7384e2a( params )
    {
        foreach ( player in level.players )
        {
            player buffplayer( int( params[ 0 ] ) );
        }
    }

    // Namespace ctdm
    // Params 0, eflags: 0x4
    // Checksum 0x70afd70b, Offset: 0x33c3
    // Size: 0x7e, Type: dev
    function private function_66938dd6b76a0434()
    {
        foreach ( player in level.players )
        {
            player thread debuffplayer();
        }
    }

#/
