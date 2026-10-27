// script_a729e95979717f8  (hash_0a729e95979717f8.gscc) (size: 9877 Bytes / 0x2695 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a1510d9 (706023641)
// size ...... 9877 (0x2695)
// includes .. 27  (offset: 0x23c5)
// strings ... 37  (offset: 0x249d)
// dev strs .. 1   (offset: 0x2689)
// exports ... 35  (offset: 0x125d)
// cseg ...... 0x2c5 + 0xf98 (0x125d)
// imports ... 104 (offset: 0x17d5)
// animtree1 . 0   (offset: 0x2695)
// animtree2 . 0   (offset: 0x2695)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\cash;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\lightarmor;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item_super;
#using scripts\mp\playerlogic;
#using scripts\mp\scoreboard;
#using scripts\mp\spawnlogic;

#namespace towerclimb;

// Namespace towerclimb
// Params 0
// Checksum 0xe0c25355, Offset: 0x2e3
// Size: 0x175
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    initializematchrules();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerconnectstream = &onplayerconnectstream;
    level.ononeleftevent = &brononeleftevent;
    level.forcegivesuper = &item_super::function_ea946b46f6cd671f;
    level.modeplayerkilledspawn = &preventrespawning;
    level thread initai();
    function_6c121b2b3272aa1d();
    level.var_a629e0989043efd8 = 1;
    level.disableforfeit = 1;
    level.var_b05cefe0c59dde7f = 1;
    level.var_d5c2787fbd88bebd = getdvarint( @"hash_31afd0e1d896114a", 1 );
    level.var_83afcf8757e058d3 = getdvarint( @"hash_eefb9c49e01093a6", 1 );
    level.var_3debc912ebccc10b = &function_3debc912ebccc10b;
    level thread common::updatecommongametypedvars();
    
    /#
    #/
    
    callback::add( #"player_spawned", &function_b9cda8115c942f37 );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"player_connect", &init_plunder_currency );
    currency::register_currency_type( #"plunder", undefined, &set_plunder_count );
    common_instance_inventory::init();
    setdvar( @"bg_piggybackarmoronnvg", 1 );
}

// Namespace towerclimb
// Params 0
// Checksum 0xb58d6d43, Offset: 0x460
// Size: 0xa
function onstartgametype()
{
    level thread function_4bb9eef494129762();
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0x19e73372, Offset: 0x472
// Size: 0xb7
function private function_6c121b2b3272aa1d()
{
    level.bcs_mindist = 500;
    level.bcs_neardist = 1625;
    level.var_d9e54908db3a5ba3 = 2125;
    level.bcs_fardist = 3500;
    level.var_1944a83fd1835aa9 = 1625;
    level.var_b0ea930c0b776ea = 180;
    level.var_deceff995bc40063 = squared( level.bcs_mindist );
    level.var_822444fd128d6523 = squared( level.bcs_neardist );
    level.var_38a0031c43023615 = squared( level.var_d9e54908db3a5ba3 );
    level.var_abf4710b2183b7ee = squared( level.bcs_fardist );
    level.var_2669df2a353bf04b = squared( level.var_1944a83fd1835aa9 );
}

// Namespace towerclimb
// Params 1, eflags: 0x4
// Checksum 0x858c501b, Offset: 0x531
// Size: 0x4a
function private init_plunder_currency( params )
{
    startingamount = 0;
    
    if ( getdvarint( @"hash_d5d3cbbdd6f5454b", 0 ) > 0 )
    {
        startingamount = getdvarint( @"hash_d5d3cbbdd6f5454b", 0 );
    }
    
    currency::init_player_currency( "plunder", startingamount );
}

// Namespace towerclimb
// Params 1, eflags: 0x4
// Checksum 0x19a87a2f, Offset: 0x583
// Size: 0x27
function private set_plunder_count( plunder )
{
    self.currency[ "plunder" ] = plunder;
    cash::playersetplunderomnvar( plunder );
}

// Namespace towerclimb
// Params 0
// Checksum 0x2743cc6a, Offset: 0x5b2
// Size: 0x9
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
}

// Namespace towerclimb
// Params 0
// Checksum 0x6fb94ab4, Offset: 0x5c3
// Size: 0x40
function function_7704813f7bab0e07()
{
    level.nosuspensemusic = 1;
    
    if ( getdvarint( @"hash_9c43b60485fbd92e", 0 ) != 1 )
    {
        level waittill( #"prematch_done" );
    }
    else
    {
        wait 5;
    }
    
    audio_utility::snd_transient_load( "mp_gamemode_dmz" );
}

// Namespace towerclimb
// Params 1
// Checksum 0x2d328e0e, Offset: 0x60b
// Size: 0xc
function brononeleftevent( team )
{
    
}

// Namespace towerclimb
// Params 1
// Checksum 0x8d95a8d5, Offset: 0x61f
// Size: 0xd5
function function_ada3345aa0195345( var_6119db8c873bf524 )
{
    level endon( #"game_ended" );
    currnode = var_6119db8c873bf524;
    
    if ( isdefined( var_6119db8c873bf524.target ) )
    {
        var_9c22959fe075abe9 = 0;
        var_265db828d5a9934e = 0;
        
        while ( !var_9c22959fe075abe9 )
        {
            nextnode = utility::getstruct( currnode.target, "targetname" );
            
            if ( !isdefined( nextnode ) || nextnode.var_87426aaf47de68d9 )
            {
                var_9c22959fe075abe9 = 1;
                continue;
            }
            
            currnode = nextnode;
            var_265db828d5a9934e++;
            
            if ( !isdefined( currnode.target ) )
            {
                var_9c22959fe075abe9 = 1;
            }
            
            if ( var_265db828d5a9934e > 9 )
            {
                assertmsg( "<dev string:x24>" );
                var_9c22959fe075abe9 = 1;
            }
        }
    }
    
    currnode.var_87426aaf47de68d9 = 1;
    return currnode;
}

// Namespace towerclimb
// Params 0
// Checksum 0x6b031d8b, Offset: 0x6fd
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace towerclimb
// Params 0
// Checksum 0x36e2cf46, Offset: 0x70f
// Size: 0x11, Type: bool
function onplayerconnectstream()
{
    thread function_31940dfe425b6ea6();
    thread function_d61ec1288412e4df();
    return false;
}

// Namespace towerclimb
// Params 1
// Checksum 0x43717b1, Offset: 0x729
// Size: 0x2c
function onspawnplayer( revivespawn )
{
    utility::callsharedfunc( #"dmz", #"hash_cbf29b092d14a705" );
    thread function_11f6d460e79e3a62();
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0xc853d092, Offset: 0x75d
// Size: 0x77
function private function_11f6d460e79e3a62()
{
    self endon( #"disconnect" );
    self waittill( #"giveloadout" );
    startingexecution = self.executionref;
    
    while ( true )
    {
        self waittill( #"melee_swipe_start" );
        var_ff27b6e0e0d50254 = function_ff27b6e0e0d50254();
        
        if ( var_ff27b6e0e0d50254 != function_6b74914a613b288d() )
        {
            execution::_giveexecution( var_ff27b6e0e0d50254 ? "execution_039" : startingexecution );
        }
    }
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0xed49a29d, Offset: 0x7dc
// Size: 0x4, Type: bool
function private function_ff27b6e0e0d50254()
{
    return true;
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0xdc7dd4a4, Offset: 0x7e9
// Size: 0x11, Type: bool
function private function_6b74914a613b288d()
{
    return self.executionref === "execution_039";
}

// Namespace towerclimb
// Params 1
// Checksum 0x1d4aa82a, Offset: 0x803
// Size: 0x34
function onplayerdeath( params )
{
    if ( isplayer( self ) )
    {
        common_inventory::function_1706ab4cdf733fb3();
        thread utility::callsharedfunc( #"pleaforhelp", #"callforhelp" );
    }
}

// Namespace towerclimb
// Params 1
// Checksum 0xe338bcd4, Offset: 0x83f
// Size: 0x2b
function function_b9cda8115c942f37( params = {} )
{
    if ( !params.revivespawn )
    {
        function_6686b887cea29d1b( self );
    }
}

// Namespace towerclimb
// Params 1
// Checksum 0x3ac23863, Offset: 0x872
// Size: 0xa2
function function_6686b887cea29d1b( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    weapons = self getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        self givemaxammo( weapon );
        self setweaponammoclip( weapon, weaponclipsize( weapon ) );
    }
}

// Namespace towerclimb
// Params 0
// Checksum 0xffd59ea0, Offset: 0x91c
// Size: 0x9
function initai()
{
    ai_mp_controller::init();
}

// Namespace towerclimb
// Params 0
// Checksum 0x132a25e1, Offset: 0x92d
// Size: 0x1d
function function_28ab54c9f4f2f44f()
{
    if ( getdvarint( @"hash_35086d04678deddb", 0 ) == 0 )
    {
        level thread ai_fortress::fortress_init();
    }
}

// Namespace towerclimb
// Params 0
// Checksum 0x818520d3, Offset: 0x952
// Size: 0x9
function function_da34607773c175f4()
{
    locksandkeys::init();
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0x3acbf150, Offset: 0x963
// Size: 0x21
function private function_4bb9eef494129762()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    gamelogic_mp::function_a14deb691144654e();
}

// Namespace towerclimb
// Params 3, eflags: 0x4
// Checksum 0x1b61329f, Offset: 0x98c
// Size: 0x29
function private fadetoblackforplayer( player, fadetoblack, fadetime )
{
    game_utility::fadetoblackforplayerkeepui( player, fadetoblack, fadetime );
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0xa9795d63, Offset: 0x9bd
// Size: 0x3c
function private function_31940dfe425b6ea6()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level fadetoblackforplayer( self, 1, 0 );
    function_8367a75eda2a48b2();
    level fadetoblackforplayer( self, 0, 0.5 );
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0xa55247b, Offset: 0xa01
// Size: 0x164
function private function_d61ec1288412e4df()
{
    setomnvar( "ui_in_infil", 3 );
    cg_drawcrosshair = getdvarint( @"cg_drawcrosshair" );
    cg_drawcrosshairnames = getdvarint( @"cg_drawcrosshairnames" );
    var_b485f091b524b27d = getdvarint( @"cg_drawfriendlynamesalways" );
    setdvar( @"cg_drawcrosshair", 0 );
    setdvar( @"cg_drawcrosshairnames", 1 );
    setdvar( @"cg_drawfriendlynamesalways", 1 );
    flags::gameflagwait( "prematch_done" );
    var_19608eba22f659ee = player::alwaysshowminimap();
    
    foreach ( player in level.players )
    {
        if ( var_19608eba22f659ee )
        {
            player player::showminimap();
            continue;
        }
        
        player player::hideminimap();
    }
    
    setomnvar( "ui_in_infil", -1 );
    setdvar( @"cg_drawcrosshair", cg_drawcrosshair );
    setdvar( @"cg_drawcrosshairnames", cg_drawcrosshairnames );
    setdvar( @"cg_drawfriendlynamesalways", var_b485f091b524b27d );
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0xea34aa9b, Offset: 0xb6d
// Size: 0x1a
function private function_8367a75eda2a48b2()
{
    self endon( #"hash_9a79955d46069b84" );
    flags::gameflagwait( "prematch_done" );
}

// Namespace towerclimb
// Params 0, eflags: 0x4
// Checksum 0x118d6c46, Offset: 0xb8f
// Size: 0x4e
function private function_86f4417dbaf458b8()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level fadetoblackforplayer( self, 1, 0.25 );
    utility::waittill_any_timeout( 4, "force_spectate_done", "br_team_fully_eliminated", "br_spectatorInitialized" );
    level fadetoblackforplayer( self, 0, 1 );
}

// Namespace towerclimb
// Params 0
// Checksum 0x66ca13c1, Offset: 0xbe5
// Size: 0x293
function onplayerexfilsuccess()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        thread function_86f4417dbaf458b8();
        
        if ( level.var_30246516d8d25d0b[ self.team ] )
        {
            self setclientomnvar( "ui_dmz_extract_successful", 2 );
        }
        else
        {
            fullyextracted = 1;
            
            foreach ( player in teams::getteamdata( self.team, "players" ) )
            {
                if ( !player.extracted )
                {
                    fullyextracted = 0;
                    break;
                }
            }
            
            if ( fullyextracted )
            {
                level.var_30246516d8d25d0b[ self.team ] = 1;
                self setclientomnvar( "ui_dmz_extract_successful", 2 );
            }
            else
            {
                self setclientomnvar( "ui_dmz_extract_successful", 1 );
            }
        }
        
        self.var_8ef52d653dbeb62e = 0;
        self.exfilpos = self.origin;
        self.spawnprotection = 1;
        lightarmor::setlightarmorvalue( self, 1000, undefined, 0 );
        val::group_register( "exfil_success", [ "usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch" ] );
        val::group_set( "exfil_success", 0 );
        self allowmovement( 0 );
        self allowfire( 0 );
        self freezecontrols( 1 );
        self notify( #"successful_exfil" );
        thread hud_message::showsplash( "callout_exfil_success" );
        
        if ( common_instance_inventory::isenabled() )
        {
            common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
            common_instance_inventory::function_8fd84f733b81e456();
        }
    }
    
    wait 0.25;
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.exfilpos ) )
        {
            self setorigin( self.exfilpos );
        }
        
        self playerhide();
        self sethidenameplate( 0 );
        self disableoffhandprimaryweapons();
        self disableoffhandsecondaryweapons();
        self disableweapons();
        self disableweaponswitch();
        self setcamerathirdperson( 1 );
        self allowcrouch( 0 );
        self allowmelee( 0 );
        self allowjump( 0 );
        self allowprone( 0 );
        self.ignoreme = 1;
        self.plotarmor = 1;
        hud_message::showerrormessage( %"mp_br_ingame/extracted_success" );
        level thread handleplayerexfildone( self );
    }
}

// Namespace towerclimb
// Params 1
// Checksum 0x1aca7fa2, Offset: 0xe80
// Size: 0x44
function updateclientmatchdata( player )
{
    gamelogic_mp::processlobbydataforclient( player );
    scoreboard::processcommonplayerdataforplayer( player );
    var_2505a68ce1f149cd = getdvarint( @"online_mp_clientmatchdata_enabled", 0 );
    
    if ( var_2505a68ce1f149cd )
    {
        player sendclientmatchdataforclient();
    }
}

// Namespace towerclimb
// Params 1
// Checksum 0x688ff07d, Offset: 0xecc
// Size: 0x14d
function handleplayerexfildone( player )
{
    spectatetimer = 5;
    player.var_8ef52d653dbeb62e = 1;
    wait spectatetimer;
    
    if ( isdefined( player ) )
    {
        if ( player.insertingarmorplate )
        {
            player notify( #"try_armor_cancel", "game_end" );
        }
        
        player damage_effects::onexitdeathsdoor( 0 );
        player.spawnprotection = 1;
        level.skipplaybodycountsound = 1;
        player playerlogic::removefromalivecount( 1, "dmzExfil" );
        teams::validatealivecount( "extract", player.team, player, "handlePlayerExfilDone" );
        spawnpoint = spawnstruct();
        spawnpoint.origin = player.exfilpos;
        spawnpoint.angles = player.angles;
        player playerlogic::spawnintermission( spawnpoint, undefined, 0 );
        player setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
        player setclientomnvar( "ui_round_end_reason", game[ "end_reason" ][ "objective_completed" ] );
        player setclientdvar( @"ui_opensummary", 1 );
        wait 5;
        kick( player getentitynumber(), &"exe/playerkicked_extracted" );
    }
    
    level thread function_f5c3fdf1885d56c6();
}

// Namespace towerclimb
// Params 0
// Checksum 0xd82f835b, Offset: 0x1021
// Size: 0x17f
function function_f5c3fdf1885d56c6()
{
    level notify( #"hash_bf70c8a2ce47af0f" );
    level endon( #"hash_bf70c8a2ce47af0f" );
    level endon( #"hash_4002dc144b5a3376" );
    wait 25;
    
    foreach ( entry in level.teamnamelist )
    {
        alivecount = teams::getteamdata( entry, "aliveCount" );
        
        if ( alivecount )
        {
            aliveplayers = teams::getteamdata( entry, "alivePlayers" );
            
            foreach ( player in aliveplayers )
            {
                if ( isdefined( player ) && !player.extracted )
                {
                    return;
                }
            }
        }
    }
    
    wait 1;
    level notify( #"hash_8c0ff6c6bbde244f" );
    gamelogic_mp::endgame_regularmp( "none", game[ "end_reason" ][ "time_limit_reached" ], game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace towerclimb
// Params 0
// Checksum 0xd0dde4e3, Offset: 0x11a8
// Size: 0x50
function packclientmatchdata()
{
    missionvalue = 0;
    
    if ( isdefined( self.brmissionscompleted ) )
    {
        missionvalue += self.brmissionscompleted;
    }
    
    if ( missionvalue > 15 )
    {
        missionvalue = 15;
    }
    
    setclientmatchdata( "players", self.clientmatchdataid, "extrascore4", missionvalue );
}

// Namespace towerclimb
// Params 2
// Checksum 0x5ad9016b, Offset: 0x1200
// Size: 0x3c, Type: bool
function function_3debc912ebccc10b( kiosk, poi )
{
    if ( poi == "social_area" && !level.gamemodebundle.var_16d9c869072e9138 )
    {
        return false;
    }
    
    return true;
}

// Namespace towerclimb
// Params 2
// Checksum 0xc91fbfc7, Offset: 0x1245
// Size: 0x17, Type: bool
function preventrespawning( deathdata, finaldeath )
{
    return true;
}

