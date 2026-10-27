// scripts\mp\br\gametypes\br_spawnrespawn.gsc  (hash_0c1669dee369bdb5.gscc) (size: 31608 Bytes / 0x7b78 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3d759aa (3285670314)
// size ...... 31608 (0x7b78)
// includes .. 44  (offset: 0x72e8)
// strings ... 128 (offset: 0x7448)
// dev strs .. 2   (offset: 0x7b60)
// exports ... 58  (offset: 0x4d64)
// cseg ...... 0xb5a + 0x420a (0x4d64)
// imports ... 230 (offset: 0x5674)
// animtree1 . 0   (offset: 0x7b78)
// animtree2 . 0   (offset: 0x7b78)
#using script_6962ddc481c4af49;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_rewards;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\execution;
#using scripts\mp\gametypes\skydive_protection;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\quickprompt;
#using scripts\mp\spectating;
#using scripts\mp\weapons;

#namespace br_spawnrespawn;

// Namespace br_spawnrespawn
// Params 8
// Checksum 0x5553d08d, Offset: 0xb78
// Size: 0xb7
function br_kioskrevive( squadmate, sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0, var_32ae392479866916, var_7bf158c6738dc0ea, var_fc49d709b55e5de7 )
{
    if ( utility::issharedfuncdefined( #"gametype", #"kioskreviveplayer" ) )
    {
        squadmate thread utility::callsharedfunc( #"gametype", #"kioskreviveplayer", sponsor );
        return;
    }
    
    if ( isdefined( var_fc49d709b55e5de7 ) )
    {
        context = var_fc49d709b55e5de7;
    }
    else
    {
        context = "br_kioskRevive";
    }
    
    squadmate thread br_gulag::playergulagautowin( context, sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0, var_32ae392479866916, var_7bf158c6738dc0ea, var_fc49d709b55e5de7 );
}

// Namespace br_spawnrespawn
// Params 3
// Checksum 0xc90c6694, Offset: 0xc37
// Size: 0x279
function br_doingrespawn( var_d296473efaa1266a, respawnstruct, var_574bfd1851c0264b )
{
    player = self;
    
    if ( level.brgametype.var_b52c9c755958c06 )
    {
        player notify( #"started_spawnplayer" );
    }
    
    if ( isdefined( respawnstruct.preparerespawn ) )
    {
        respawnready = self [[ respawnstruct.preparerespawn ]]( respawnstruct.optparams );
        
        if ( !respawnready )
        {
            return;
        }
    }
    
    streamtimeout = br_public::getdefaultstreamhinttimeoutms() / 1000;
    
    if ( isdefined( var_574bfd1851c0264b ) )
    {
        spawnpoint = var_574bfd1851c0264b;
    }
    else
    {
        spawnpoint = playergetrespawnpoint( 0, streamtimeout, undefined, respawnstruct );
        
        if ( isdefined( level.br_circle ) )
        {
            circleindex = level.br_circle.circleindex;
            logstring( "[br_spawnrespawn] Point chosen: matchTime=" + gettime() / 1000 + " circle=" + circleindex + " spawnType='" + spawnpoint.type + "' timeToSpawn=" + streamtimeout );
        }
    }
    
    utility::callsharedfunc( #"gametype", #"hash_2476bd080a905815", spawnpoint, streamtimeout );
    
    if ( isdefined( var_574bfd1851c0264b ) )
    {
        streamorigin = spawnpoint.origin;
    }
    else
    {
        streamorigin = playerprestreamrespawnorigin( spawnpoint );
    }
    
    self.forcespawnorigin = streamorigin;
    
    if ( isdefined( var_d296473efaa1266a ) )
    {
        wait var_d296473efaa1266a;
    }
    
    if ( respawnstruct.handleoverlay )
    {
        player thread [[ respawnstruct.handleoverlay ]]( respawnstruct.optparams );
    }
    else
    {
        player thread function_1d2f70d591e967bc();
        player thread function_3af483f3b14c0be8();
    }
    
    player br_spectate::playerclearspectatekillchainsystem();
    pre_spawn_delay = 1;
    wait pre_spawn_delay;
    player hud_message::clearsplashqueue();
    player playerlogic::spawnplayer( undefined, 0 );
    player execution::_clearexecution();
    
    if ( function_cbf2e3ddae51ea99() )
    {
        if ( utility::issharedfuncdefined( #"respawn", #"nuke_all_values" ) )
        {
            [[ utility::getsharedfunc( #"respawn", #"nuke_all_values" ) ]]( player );
        }
        else
        {
            player val::nuke_all();
        }
    }
    
    player.respawningfromtoken = undefined;
    
    if ( isdefined( respawnstruct.var_4b2efbbf9066123b ) )
    {
        player thread triggerrespawnoverlay( respawnstruct.var_4b2efbbf9066123b );
    }
    
    if ( isdefined( player ) )
    {
        br_respawn( spawnpoint, streamorigin, respawnstruct );
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x5953e1bb, Offset: 0xeb8
// Size: 0x11, Type: bool
function function_cbf2e3ddae51ea99()
{
    return !getdvarint( @"hash_31951221975b4d61", 0 );
}

// Namespace br_spawnrespawn
// Params 3
// Checksum 0x7aa9f720, Offset: 0xed2
// Size: 0x781
function br_respawn( spawnpoint, streamorigin, respawnstruct )
{
    thread br::function_48a77bf6c5c416();
    calloutmarkerping::function_5a33bcee47519dd6();
    
    if ( utility::issharedfuncdefined( #"teamassim", #"isenabled" ) && [[ utility::getsharedfunc( #"teamassim", #"isenabled" ) ]]() && utility::issharedfuncdefined( #"teamassim", #"enableplayer" ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"enableplayer" ) ]]( self, "player_dead" );
    }
    
    if ( utility::issharedfuncdefined( #"teamassim", #"isenabled" ) && [[ utility::getsharedfunc( #"teamassim", #"isenabled" ) ]]() && utility::issharedfuncdefined( #"teamassim", #"enableplayer" ) )
    {
        [[ utility::getsharedfunc( #"teamassim", #"enableplayer" ) ]]( self, "br_gulag" );
    }
    
    respawndone = 0;
    
    if ( isdefined( respawnstruct.prerespawn ) )
    {
        respawndone = self [[ respawnstruct.prerespawn ]]( respawnstruct.optparams );
    }
    
    if ( !getdvarint( @"hash_c6b2a81c842303b0", 0 ) )
    {
        foreach ( crate in level.br_crates )
        {
            crate airdrop::function_b9fc17612f972c6f( self, 1 );
        }
    }
    
    level notify( #"hash_7f6b2a7b2d05df3e" );
    thread function_34bcb0f8d8646cf( respawndone );
    self.var_2f8b6417bc00b4a0 = undefined;
    br::givelaststandifneeded( self );
    
    if ( isdefined( level.var_5e5ae35d1b932ce ) )
    {
        self [[ level.var_5e5ae35d1b932ce ]]( 0 );
    }
    
    if ( respawndone )
    {
        return;
    }
    
    if ( !isdefined( spawnpoint ) )
    {
        spawnpoint = playergetrespawnpoint();
    }
    
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
    startorigin = spawnorigin;
    
    if ( isdefined( streamorigin ) )
    {
        startorigin = streamorigin;
    }
    
    function_e61300d028a4bd67();
    function_4a36121aa04feff4( startorigin, spawnangles );
    linker = spawn( "script_model", startorigin );
    linker setmodel( "tag_origin" );
    linker.angles = spawnangles;
    linker hide();
    linker showtoplayer( self );
    self playerlinktoabsolute( linker, "tag_origin" );
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "br_spawnrespawn::br_respawn()" );
    thread playercleanupentondisconnect( linker );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( respawnstruct.respawncleanup ) )
    {
        self [[ respawnstruct.respawncleanup ]]( respawnstruct.optparams );
    }
    
    if ( getdvarint( @"scr_skip_respawn_gate", 1 ) == 0 )
    {
        streamhint::playerwaittillstreamhintcomplete();
    }
    
    /#
        while ( getdvarint( @"scr_br_gulag_win_hold", 0 ) != 0 )
        {
            waitframe();
        }
    #/
    
    br_public::playerclearstreamhintorigin();
    
    if ( isdefined( streamorigin ) )
    {
        linker.origin = spawnorigin;
    }
    
    damage_effects::function_e8cba6f10a4635e9();
    self clearsoundsubmix( "iw9_mp_killcam" );
    wait 0.5;
    
    if ( isdefined( respawnstruct.respawnsound ) )
    {
        linker playsoundtoplayer( respawnstruct.respawnsound, self );
    }
    
    wait 1;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self islinked() )
    {
        function_4a36121aa04feff4( spawnorigin, spawnangles );
        
        /#
            script::demoforcesre( "<dev string:x24>" + self.name + "<dev string:x2c>" );
        #/
    }
    
    self unlink();
    self clearclienttriggeraudiozone( 1 );
    
    if ( br_public::isbrpracticemode() )
    {
        self clearsoundsubmix( "iw8_br_gulag_tutorial", 2 );
    }
    else
    {
        self clearsoundsubmix( "solo_cin_igc_music_br_hack", 2 );
    }
    
    player_utility::function_b54a1e23734ef07( 1 );
    function_45fa421c1d07d98d( 1 );
    falltime = 0;
    
    if ( isdefined( level.parachutedeploydelay ) )
    {
        falltime = level.parachutedeploydelay;
    }
    
    if ( !br_public::function_379fb7b09f4ef13e() && !self.isjuggernaut )
    {
        if ( respawnstruct.skipparachute )
        {
            self thread [[ level.parachuterestoreweaponscb ]]();
        }
        else
        {
            thread parachute::startfreefall( falltime, 0, undefined, undefined, 1 );
        }
    }
    else if ( self.isjuggernaut )
    {
        self skydive_setbasejumpingstatus( 0 );
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_show_spectateHud", -1 );
        self setclientomnvar( "ui_cash_dropped", 0 );
    }
    
    resetplayermovespeedscale();
    
    if ( isdefined( respawnstruct.onrespawnoverlay ) )
    {
        thread triggerrespawnoverlay( respawnstruct.onrespawnoverlay );
    }
    
    if ( respawnstruct.var_b006b462cca49b6e )
    {
        self setclientomnvar( "ui_br_transition_type", 0 );
    }
    
    if ( !br_gametypes::isfeaturedisabled( #"armor" ) && !respawnstruct.optparams.var_95914ba827231b73 )
    {
        var_4b0b17846cf1e4e1 = function_c5621bae444318d1();
        respawnreserveplates = getmatchrulesdata( "commonOption", "respawnReservePlates" );
        armor::givestartingarmor( var_4b0b17846cf1e4e1, respawnreserveplates );
    }
    
    br_contract_manager::onplayerrespawn();
    br_quest_util::onplayerrespawn();
    br_rewards::onplayerrespawn();
    br_supply_drops_common::function_f3eb6eaf154a9ee3();
    level callback::callback( #"br_player_respawn", { #player:self } );
    
    if ( isdefined( respawnstruct.onrespawn ) )
    {
        self [[ respawnstruct.onrespawn ]]( respawnstruct.optparams );
    }
    
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        thread function_24b79e9319c6f02f();
    }
    
    self notify( #"hash_88b506e95217aeab" );
    thread br::function_61e2f390df19d678();
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    linker delete();
    
    if ( !respawnstruct.skipbattlechatter )
    {
        level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_respawn" );
    }
    
    if ( level.skydive_spawnprotectionactive )
    {
        skydive_protection::initprotection();
    }
    
    if ( br_public::isbrpracticemode() )
    {
        self notify( #"hash_3dc1831c6d6b9f" );
    }
    
    self notify( #"can_show_splashes" );
    
    if ( !level.ignoregulagredeploysplash && isdefined( respawnstruct.var_eb6bb120ed0fc29b ) )
    {
        thread hud_message::showsplash( respawnstruct.var_eb6bb120ed0fc29b, respawnstruct.var_90c07df9f9f97990, undefined, undefined, undefined, respawnstruct.var_3c1e3fc0d07880b );
    }
    
    if ( !level.var_a3457727219f4536 && isdefined( respawnstruct.var_5741f15e15e0a2f4 ) )
    {
        br_public::brleaderdialogplayer( respawnstruct.var_5741f15e15e0a2f4, self, undefined, undefined, 0, undefined, respawnstruct.var_9ff9818c3edc5770 );
    }
    
    if ( isdefined( respawnstruct.postrespawn ) )
    {
        self [[ respawnstruct.postrespawn ]]( respawnstruct.optparams );
    }
    
    if ( quickprompt::quickpromptisenabled() )
    {
        if ( isdefined( respawnstruct.optparams.sponsor ) && respawnstruct.optparams.sponsor != self )
        {
            thread quickprompt::quickpromptshow( 1 );
        }
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_b5a77ed63d3b12cb" ) )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_b5a77ed63d3b12cb", self );
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x34d40e10, Offset: 0x165b
// Size: 0x35
function function_34bcb0f8d8646cf( respawndone )
{
    if ( !respawndone )
    {
        self endon( #"death_or_disconnect" );
        waitframe();
        waittillframeend();
    }
    
    if ( isdefined( self.oobimmunity ) )
    {
        outofbounds::disableoobimmunity( self );
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xb4d8dbd1, Offset: 0x1698
// Size: 0x6a
function function_c5621bae444318d1()
{
    var_4b0b17846cf1e4e1 = getmatchrulesdata( "commonOption", "respawnArmor" );
    
    if ( isdefined( self.overriderespawnarmor ) )
    {
        var_4b0b17846cf1e4e1 = self.overriderespawnarmor;
        self.overriderespawnarmor = undefined;
    }
    
    if ( level.pe_heavyarmor_active && level.pe_heavyarmor.var_ac765b716054b321 )
    {
        var_4b0b17846cf1e4e1 += 50;
    }
    
    return var_4b0b17846cf1e4e1;
}

// Namespace br_spawnrespawn
// Params 3
// Checksum 0xa2c349b8, Offset: 0x170b
// Size: 0x6a
function function_1ecfc7c6647ddf97( cleanupcallback, soundalias, var_b006b462cca49b6e )
{
    rs = spawnstruct();
    rs.respawncleanup = cleanupcallback;
    rs.respawnsound = soundalias;
    rs.var_b006b462cca49b6e = var_b006b462cca49b6e;
    rs.optparams = spawnstruct();
    return rs;
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x9829b1f0, Offset: 0x177e
// Size: 0x17
function function_ffd4cf4c20eae881( var_379062e08f6b6330 )
{
    self.preparerespawn = var_379062e08f6b6330;
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x1f869b10, Offset: 0x179d
// Size: 0x2b
function function_ecc6ed28c3fae86b( var_ab687b18622a8ce, var_4b2efbbf9066123b )
{
    self.prerespawn = var_ab687b18622a8ce;
    self.var_4b2efbbf9066123b = var_4b2efbbf9066123b;
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x9a65a2e0, Offset: 0x17d0
// Size: 0x2b
function function_b9b32e1004a183cb( onrespawncallback, onrespawnoverlay )
{
    self.onrespawn = onrespawncallback;
    self.onrespawnoverlay = onrespawnoverlay;
}

// Namespace br_spawnrespawn
// Params 6
// Checksum 0xe762bf65, Offset: 0x1803
// Size: 0xff
function function_7275e4fc001d486a( var_30396c9ce4ba150f, var_eb6bb120ed0fc29b, var_90c07df9f9f97990, var_3c1e3fc0d07880b, var_5741f15e15e0a2f4, var_9ff9818c3edc5770 )
{
    self.postrespawn = level.brgametype.var_30396c9ce4ba150f ?? var_30396c9ce4ba150f;
    self.var_eb6bb120ed0fc29b = level.brgametype.var_eb6bb120ed0fc29b ?? var_eb6bb120ed0fc29b;
    self.var_90c07df9f9f97990 = level.brgametype.var_90c07df9f9f97990 ?? var_90c07df9f9f97990;
    self.var_3c1e3fc0d07880b = level.brgametype.var_3c1e3fc0d07880b ?? var_3c1e3fc0d07880b;
    self.var_5741f15e15e0a2f4 = level.brgametype.var_5741f15e15e0a2f4 ?? var_5741f15e15e0a2f4;
    self.var_9ff9818c3edc5770 = level.brgametype.var_9ff9818c3edc5770 ?? var_9ff9818c3edc5770;
}

// Namespace br_spawnrespawn
// Params 6
// Checksum 0x16182705, Offset: 0x190a
// Size: 0x175
function playerhandlesponsor( sponsor, tokenused, var_ec22479f7c93f2e0, skipoverlay, var_32ae392479866916, context )
{
    player = self;
    var_313fb092441483ee = player;
    analyticsevent = "token";
    
    if ( isdefined( sponsor ) )
    {
        viprevive = player.br_iseliminated && !isalive( player ) && player.wasingulag;
        assert( isplayer( sponsor ) );
        
        if ( var_32ae392479866916 )
        {
            assert( player.gulag && !isalive( player ) );
        }
        else
        {
            assert( player br_public::iseligibleforteamrevive() || viprevive );
        }
        
        var_313fb092441483ee = sponsor;
        analyticsevent = "token_sponsored";
    }
    
    if ( isdefined( sponsor ) || var_ec22479f7c93f2e0 )
    {
        if ( !arraycontains( level.teamdata[ player.team ][ "alivePlayers" ], player ) )
        {
            player playerlogic::addtoalivecount( context );
        }
        
        br_utility::unmarkplayeraseliminated( player, context );
    }
    
    br_analytics::branalytics_gulagstart( player, analyticsevent );
    br_analytics::branalytics_respawn( self, int( isdefined( sponsor ) ), context );
    
    if ( tokenused && var_313fb092441483ee.hasrespawntoken )
    {
        var_313fb092441483ee item_redeploy_token::function_16ab0a48337237ef();
    }
    
    return [ var_313fb092441483ee, analyticsevent ];
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x860409d4, Offset: 0x1a88
// Size: 0x54
function playerprestreamrespawnorigin( spawnpoint, timeoutms )
{
    droporigin = br_public::playerstreamhintdroptoground( spawnpoint.origin, spawnpoint.height );
    self setpredictedstreamloaddist( 0 );
    streamhint::playerstreamhintlocation( droporigin, timeoutms );
    return droporigin;
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xef2ddef3, Offset: 0x1ae5
// Size: 0xd
function function_e61300d028a4bd67()
{
    self setallstreamloaddist( 0 );
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0xa46bb58d, Offset: 0x1afa
// Size: 0x69
function function_4a36121aa04feff4( origin, angles )
{
    self cancelmantle();
    
    if ( self.sessionstate != "spectator" )
    {
        utility::callsharedfunc( #"gametype", #"onplayerteleport", self, self.origin, origin, "respawn" );
        self setorigin( origin, 1 );
        self setplayerangles( angles );
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x1fbf30e6, Offset: 0x1b6b
// Size: 0x8c
function function_e6323b87b5e1d738( testpos )
{
    circleready = isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent );
    
    if ( !circleready )
    {
        return 1;
    }
    
    if ( br_circle_util::function_7c3401c47d505872() > 1 )
    {
        return br_circle_util::function_7dba95e6f0e08799( testpos );
    }
    
    safeorigin = br_circle::getsafecircleorigin();
    saferadius = br_circle::getsafecircleradius();
    dist = distance2d( testpos, safeorigin );
    return dist < saferadius;
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x99ef203b, Offset: 0x1c00
// Size: 0x8c
function function_9f3b8b1feb934c92( testpos )
{
    circleready = isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent );
    
    if ( !circleready )
    {
        return 1;
    }
    
    if ( br_circle_util::function_7c3401c47d505872() > 1 )
    {
        return br_circle_util::ispointinmulticircledanger( testpos );
    }
    
    dangerorigin = br_circle::getdangercircleorigin();
    dangerradius = br_circle::getdangercircleradius();
    dist = distance2d( testpos, dangerorigin );
    return dist < dangerradius;
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x483d3adb, Offset: 0x1c95
// Size: 0x8a, Type: bool
function function_a2b4a87644b31939( testpos )
{
    if ( level.br_circle_disabled || !isdefined( level.br_circle ) )
    {
        return false;
    }
    
    dangerorigin = br_circle::getdangercircleorigin();
    dangerradius = br_circle::getdangercircleradius();
    var_5a21873a61d73405 = getdvarfloat( @"hash_642a747362b46b75", 1575 );
    disttocenter = distance2d( testpos, dangerorigin );
    var_51c583eb5c29b242 = dangerradius - disttocenter;
    return var_51c583eb5c29b242 <= var_5a21873a61d73405;
}

// Namespace br_spawnrespawn
// Params 3
// Checksum 0xa4a313ad, Offset: 0x1d28
// Size: 0x1b2, Type: bool
function function_319e192e1937d43( testpos, timeuntilspawn, checkbadcircles )
{
    if ( !br_c130::ispointinbounds( testpos, 1 ) )
    {
        return false;
    }
    
    if ( checkbadcircles )
    {
        if ( br_circle::_ispointinbadarea( testpos ) )
        {
            return false;
        }
    }
    
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) && isdefined( level.br_circle.dangercircleent ) ) )
    {
        return true;
    }
    
    if ( br_circle_util::function_209532a1558406f() && br_circle_util::ispointinmulticircledanger( testpos ) )
    {
        return true;
    }
    
    var_a860b6cc615c4bdb = br_circle::function_a860b6cc615c4bdb( level.br_circle.circleindex );
    
    if ( !var_a860b6cc615c4bdb && function_e6323b87b5e1d738( testpos ) )
    {
        return true;
    }
    
    if ( !function_9f3b8b1feb934c92( testpos ) )
    {
        return false;
    }
    
    if ( isdefined( timeuntilspawn ) )
    {
        var_848876b000d62aab = br_circle::getmintimetillpointindangercircle( testpos );
        
        if ( timeuntilspawn > var_848876b000d62aab )
        {
            return false;
        }
    }
    
    safeorigin = br_circle::getsafecircleorigin();
    saferadius = br_circle::getsafecircleradius();
    dangerorigin = br_circle::getdangercircleorigin();
    dangerradius = br_circle::getdangercircleradius();
    var_72d5539287199a29 = length( dangerorigin - safeorigin );
    var_6f12b617e0bb1aa3 = vectornormalize( dangerorigin - safeorigin );
    interppct = level.respawncircleinterppct;
    var_a975a88cb07c7b42 = safeorigin + var_6f12b617e0bb1aa3 * var_72d5539287199a29 * interppct;
    var_2c00eae450874526 = saferadius + ( dangerradius - saferadius ) * interppct;
    dist = distance2d( testpos, var_a975a88cb07c7b42 );
    return dist < var_2c00eae450874526;
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x66d7f841, Offset: 0x1ee3
// Size: 0x6f, Type: bool
function isplayervalidrespawntarget( player, timeuntilspawn )
{
    if ( player == self )
    {
        return false;
    }
    
    if ( !isalive( player ) || player br_public::isplayerinorgoingtogulag() || player.br_iseliminated || player.aetherisland )
    {
        return false;
    }
    
    if ( !function_319e192e1937d43( player.origin, timeuntilspawn ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_spawnrespawn
// Params 6
// Checksum 0x9d90f1f0, Offset: 0x1f5b
// Size: 0x4ed
function playergetbestrespawnteammate( forcefallback, timeuntilspawn, skipself, skipbot, overrideteammates, respawnstruct )
{
    ignoreplayer = undefined;
    aliveteammates = overrideteammates ?? teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid, 1 );
    var_8d6f3c7b29f7e57c = !skipbot;
    
    if ( var_8d6f3c7b29f7e57c )
    {
        humanplayers = [];
        var_60b7aa88b6711b93 = [];
        
        foreach ( player in aliveteammates )
        {
            if ( isbot( player ) )
            {
                var_60b7aa88b6711b93[ var_60b7aa88b6711b93.size ] = player;
                continue;
            }
            
            humanplayers[ humanplayers.size ] = player;
        }
    }
    
    if ( isdefined( respawnstruct.optparams.sponsor ) && self != respawnstruct.optparams.sponsor )
    {
        var_d092c6b267d3a77b = respawnstruct.optparams.sponsor;
        
        if ( !isplayervalidrespawntarget( var_d092c6b267d3a77b, timeuntilspawn ) )
        {
            var_d092c6b267d3a77b = undefined;
        }
        else
        {
            return var_d092c6b267d3a77b;
        }
    }
    
    if ( isdefined( self.lastdeathpos ) )
    {
        var_d092c6b267d3a77b = undefined;
        
        if ( var_8d6f3c7b29f7e57c )
        {
            var_acbf292ef138bf9e = humanplayers.size > 1 ? sortbydistance( humanplayers, self.lastdeathpos ) : humanplayers;
            var_64616605b087124a = var_60b7aa88b6711b93.size > 1 ? sortbydistance( var_60b7aa88b6711b93, self.lastdeathpos ) : var_60b7aa88b6711b93;
            players = arraycombine( var_acbf292ef138bf9e, var_64616605b087124a );
        }
        else
        {
            players = sortbydistance( aliveteammates, self.lastdeathpos );
        }
        
        foreach ( player in players )
        {
            if ( skipbot && isbot( player ) )
            {
                continue;
            }
            
            if ( ignoreplayer == player )
            {
                continue;
            }
            
            if ( player isparachuting() || player isskydiving() )
            {
                continue;
            }
            
            if ( !isplayervalidrespawntarget( player, timeuntilspawn ) )
            {
                continue;
            }
            
            var_d092c6b267d3a77b = player;
            break;
        }
        
        if ( isdefined( var_d092c6b267d3a77b ) && forcefallback && !isdefined( ignoreplayer ) )
        {
            ignoreplayer = var_d092c6b267d3a77b;
            var_d092c6b267d3a77b = undefined;
            
            foreach ( player in players )
            {
                if ( skipbot && isbot( player ) )
                {
                    continue;
                }
                
                if ( ignoreplayer == player )
                {
                    continue;
                }
                
                if ( player isparachuting() || player isskydiving() )
                {
                    continue;
                }
                
                if ( !isplayervalidrespawntarget( player, timeuntilspawn ) )
                {
                    continue;
                }
                
                var_d092c6b267d3a77b = player;
                break;
            }
        }
        
        if ( isdefined( var_d092c6b267d3a77b ) )
        {
            return var_d092c6b267d3a77b;
        }
    }
    
    var_d092c6b267d3a77b = undefined;
    
    if ( var_8d6f3c7b29f7e57c )
    {
        var_e26a7a2b3b22ce9a = humanplayers.size > 1 ? arrayrandomize( humanplayers ) : humanplayers;
        var_2bf258f234b9ae66 = var_60b7aa88b6711b93.size > 1 ? arrayrandomize( var_60b7aa88b6711b93 ) : var_60b7aa88b6711b93;
        var_5cbb6fb07c209bb5 = arraycombine( var_e26a7a2b3b22ce9a, var_2bf258f234b9ae66 );
    }
    else
    {
        var_5cbb6fb07c209bb5 = arrayrandomize( aliveteammates );
    }
    
    foreach ( squadmember in var_5cbb6fb07c209bb5 )
    {
        if ( skipbot && isbot( squadmember ) )
        {
            continue;
        }
        
        if ( ignoreplayer == squadmember )
        {
            continue;
        }
        
        if ( !isplayervalidrespawntarget( squadmember, timeuntilspawn ) )
        {
            continue;
        }
        
        var_d092c6b267d3a77b = squadmember;
        
        if ( squadmember br_public::isplayerbrsquadleader() )
        {
            break;
        }
    }
    
    if ( isdefined( var_d092c6b267d3a77b ) )
    {
        return var_d092c6b267d3a77b;
    }
    
    if ( !skipself )
    {
        if ( game_utility::getgametype() == "plunder" )
        {
            teamcount = teams::getteamdata( self.team, "teamCount" );
            
            if ( teamcount == 1 && !self.disconnecting && !outofbounds::ispointinoutofbounds( self.origin ) )
            {
                return self;
            }
        }
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xdcb381e8, Offset: 0x2451
// Size: 0xcc
function function_8c6115ae32ae90c3()
{
    teammates = level.teamdata[ self.team ][ "players" ];
    
    foreach ( squadmember in teammates )
    {
        if ( squadmember == self )
        {
            continue;
        }
        
        var_b813217974861fe4 = squadmember.forcespawnorigin;
        
        if ( !isdefined( var_b813217974861fe4 ) )
        {
            var_b813217974861fe4 = squadmember.var_a477f50bf8df2b90;
        }
        
        if ( !isdefined( var_b813217974861fe4 ) )
        {
            continue;
        }
        
        return var_b813217974861fe4;
    }
}

// Namespace br_spawnrespawn
// Params 4
// Checksum 0x254a8041, Offset: 0x2526
// Size: 0x21c
function getsafeoriginaroundpoint( point, maxdistaway, timeuntilspawn, checkbadcircles )
{
    safeorigins = br_circle_util::function_a698f8bf61cd6736();
    
    foreach ( safeorigin in safeorigins )
    {
        safetopoint = vectornormalize( point - safeorigin );
        ang = vectortoangles( safetopoint );
        randomyaw = randomfloatrange( getdvarfloat( @"hash_83a1498acddbc2fa", 0 ), getdvarfloat( @"hash_83c5338ace040d50", 359 ) );
        dir = vectornormalize( anglestoforward( ang + ( 0, utility::cointoss() ? randomyaw : randomyaw * -1, 0 ) ) );
        origin = point + dir * maxdistaway;
        
        if ( function_319e192e1937d43( origin, timeuntilspawn, checkbadcircles ) )
        {
            return origin;
        }
        
        dir *= -1;
        origin = point + dir * maxdistaway;
        
        if ( function_319e192e1937d43( origin, timeuntilspawn, checkbadcircles ) )
        {
            return origin;
        }
        
        dir = vectornormalize( safeorigin - point );
        origin = point + dir * maxdistaway;
        
        if ( function_319e192e1937d43( origin, timeuntilspawn, checkbadcircles ) )
        {
            return origin;
        }
        
        arclength = maxdistaway;
        radius = distance2d( point, safeorigin );
        radius = radius == 0 ? 1 : radius;
        angle = min( arclength / radius, 3.14159 );
        angledeg = angle * 57.2958;
        origin = rotatepointaroundvector( ( 0, 0, 1 ), point - safeorigin, angledeg ) + safeorigin;
        
        if ( function_319e192e1937d43( origin, timeuntilspawn, checkbadcircles ) )
        {
            return origin;
        }
        
        origin = br_circle::getrandompointincircle( point, maxdistaway );
        
        if ( function_319e192e1937d43( origin, timeuntilspawn, checkbadcircles ) )
        {
            return origin;
        }
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xe9ddd38b, Offset: 0x274b
// Size: 0x95
function playergetbestrespawnmissionorigin()
{
    if ( br_gametypes::isfeaturedisabled( #"missions" ) )
    {
        return;
    }
    
    contract = br_contract_manager::function_28779161e0912456( br_contract_manager::function_6b738bc71eb53bd4() );
    
    if ( isdefined( contract ) )
    {
        if ( isdefined( contract.type.funcs[ "bestRespawnMissionOrigin" ] ) )
        {
            return contract [[ contract.type.funcs[ "bestRespawnMissionOrigin" ] ]]();
        }
        
        logprint( "No spawn origin func for contract type: " + contract.type.ref );
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x50fd41ce, Offset: 0x27e9
// Size: 0xf7
function playergetbestdropbagorigin( timeuntilspawn )
{
    foreach ( crate in level.br_crates )
    {
        if ( !( isdefined( crate ) && isdefined( crate.team ) ) || crate.team != self.team )
        {
            continue;
        }
        
        if ( isdefined( crate.playerscaptured ) && isdefined( crate.playerscaptured[ self getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( function_319e192e1937d43( crate.origin, timeuntilspawn ) )
        {
            return crate.origin;
        }
    }
}

// Namespace br_spawnrespawn
// Params 4
// Checksum 0x2239bb95, Offset: 0x28e8
// Size: 0xf8a
function playergetrespawnpoint( forcefallback, timeuntilspawn, overrideheight, respawnstruct )
{
    spawnorigin = undefined;
    spawnangles = undefined;
    height = overrideheight;
    offsetheight = 1;
    spawntype = "";
    
    if ( isdefined( self.setspawnpoint ) )
    {
        spawnorigin = self.setspawnpoint.playerspawnpos;
        spawnangles = self.setspawnpoint.playerspawnangles;
        spawntype = "setSpawnPoint";
    }
    
    if ( level.var_66a069174249c72b == 1 || level.var_66a069174249c72b == 2 )
    {
        spawnpoint = spawnstruct();
        spawnpoint.origin = level.prematchspawnorigins[ 0 ].origin;
        spawnpoint.angles = ( 0, 0, 0 );
        spawnpoint.height = 0;
        return spawnpoint;
    }
    
    if ( level.var_66a069174249c72b == 3 )
    {
        spawnpoint = spawnstruct();
        spawnpoint.origin = self.var_2f0ddab01d0817d3.origin;
        spawnpoint.angles = self.var_2f0ddab01d0817d3.angles ?? ( 0, 0, 0 );
        spawnpoint.height = self.var_2f0ddab01d0817d3.height ?? 0;
        return spawnpoint;
    }
    
    var_3bbe4cbaaa0f5d43 = getdvarfloat( @"scr_br_respawnmaxlastdeathoffset", -1 );
    
    if ( !isdefined( spawnorigin ) && var_3bbe4cbaaa0f5d43 >= 0 && isdefined( self.lastdeathpos ) )
    {
        startorigin = getsafeoriginaroundpoint( self.lastdeathpos, var_3bbe4cbaaa0f5d43, timeuntilspawn );
        
        if ( isdefined( startorigin ) )
        {
            spawnorigin = br_public::droptogroundmultitrace( startorigin );
            spawnangles = function_46f3bef64ca7cfca( spawnorigin, startorigin );
            spawntype = "lastDeath";
        }
    }
    
    var_3bbe4cbaaa0f5d43 = getdvarfloat( @"scr_br_respawnmaxteammateoffset", 1000 );
    
    if ( !isdefined( spawnorigin ) && var_3bbe4cbaaa0f5d43 >= 0 )
    {
        var_837112ff5ff3188b = playergetbestrespawnteammate( forcefallback, timeuntilspawn, undefined, undefined, undefined, respawnstruct );
        
        if ( isdefined( var_837112ff5ff3188b ) )
        {
            blackscreentime = getdvarfloat( @"hash_879a2fde5543837", 5 ) * 1000;
            redeploywindow = getdvarfloat( @"hash_5845ae9020002373", 30 ) * 1000;
            gametype = game_utility::getgametype();
            
            if ( ( gametype == "plunder" || gametype == "kingslayer" ) && isdefined( level.teamdata[ self.team ][ "lastParachuteTime" ] ) && level.teamdata[ self.team ][ "lastParachuteTime" ] + redeploywindow > gettime() + blackscreentime && distance2d( level.teamdata[ self.team ][ "lastParachuteOrigin" ], var_837112ff5ff3188b.origin ) < getdvarfloat( @"scr_br_respawnmaxteammateoffset", 1000 ) * 1.25 )
            {
                checkbadcircles = getdvarint( @"hash_6b9d098d821de0bf", 1 ) == 1;
                spawnorigin = getsafeoriginaroundpoint( level.teamdata[ self.team ][ "lastParachuteOrigin" ], var_3bbe4cbaaa0f5d43, timeuntilspawn, checkbadcircles );
                
                if ( !isdefined( spawnorigin ) )
                {
                    var_4e4d4cdbbedf0070 = level.teamdata[ self.team ][ "lastParachuteOrigin" ];
                    
                    if ( function_319e192e1937d43( var_4e4d4cdbbedf0070, timeuntilspawn, checkbadcircles ) )
                    {
                        spawnorigin = var_4e4d4cdbbedf0070;
                    }
                }
                
                spawnangles = level.teamdata[ self.team ][ "lastParachuteAngles" ];
                
                if ( isdefined( spawnorigin ) && function_a2b4a87644b31939( var_837112ff5ff3188b.origin ) )
                {
                    spawnangles = function_46f3bef64ca7cfca( spawnorigin, br_circle::getsafecircleorigin() );
                }
                
                spawntype = "abovePlayerCached";
            }
            else
            {
                checkbadcircles = getdvarint( @"hash_899e9302a5910263", 1 ) == 1;
                spawnorigin = getsafeoriginaroundpoint( var_837112ff5ff3188b.origin, var_3bbe4cbaaa0f5d43, timeuntilspawn, checkbadcircles );
                
                if ( isdefined( spawnorigin ) )
                {
                    spawnorigin = br_public::droptogroundmultitrace( spawnorigin );
                    
                    if ( function_a2b4a87644b31939( var_837112ff5ff3188b.origin ) )
                    {
                        spawnangles = function_46f3bef64ca7cfca( spawnorigin, br_circle::getsafecircleorigin() );
                    }
                    else
                    {
                        spawnangles = function_46f3bef64ca7cfca( spawnorigin, var_837112ff5ff3188b.origin );
                    }
                    
                    spawntype = "abovePlayer";
                    level.teamdata[ self.team ][ "lastParachuteOrigin" ] = spawnorigin;
                    level.teamdata[ self.team ][ "lastParachuteAngles" ] = spawnangles;
                    level.teamdata[ self.team ][ "lastParachuteTime" ] = gettime();
                }
            }
        }
        
        if ( !isdefined( spawnorigin ) )
        {
            teammateorigin = function_8c6115ae32ae90c3();
            
            if ( isdefined( teammateorigin ) )
            {
                spawnorigin = getsafeoriginaroundpoint( teammateorigin, var_3bbe4cbaaa0f5d43, timeuntilspawn );
                
                if ( isdefined( spawnorigin ) )
                {
                    spawnorigin = br_public::droptogroundmultitrace( spawnorigin );
                    spawnangles = function_46f3bef64ca7cfca( spawnorigin, teammateorigin );
                    spawntype = "respawningTeammate";
                }
            }
        }
    }
    
    var_3bbe4cbaaa0f5d43 = getdvarfloat( @"hash_525860b720e2a5d6", -1 );
    
    if ( !isdefined( spawnorigin ) && var_3bbe4cbaaa0f5d43 >= 0 && isdefined( self.lastdeathpos ) )
    {
        spawnorigin = getsafeoriginaroundpoint( self.lastdeathpos, var_3bbe4cbaaa0f5d43, timeuntilspawn );
        
        if ( isdefined( spawnorigin ) )
        {
            spawnorigin = br_public::droptogroundmultitrace( spawnorigin );
            spawnangles = function_46f3bef64ca7cfca( spawnorigin, self.lastdeathpos );
            spawntype = "lastDeathIfNoTeammateToRespawn";
        }
    }
    
    var_3bbe4cbaaa0f5d43 = getdvarfloat( @"hash_721aa1f6148749eb", 3000 );
    
    if ( !isdefined( spawnorigin ) && var_3bbe4cbaaa0f5d43 >= 0 )
    {
        missionorigin = playergetbestrespawnmissionorigin();
        
        if ( isdefined( missionorigin ) )
        {
            checkbadcircles = getdvarint( @"hash_f12e3202f176d28d", 1 ) == 1;
            spawnorigin = getsafeoriginaroundpoint( missionorigin, var_3bbe4cbaaa0f5d43, timeuntilspawn, checkbadcircles );
            spawnangles = function_46f3bef64ca7cfca( spawnorigin, missionorigin );
            spawntype = "missionOrigin";
        }
    }
    
    var_3bbe4cbaaa0f5d43 = getdvarfloat( @"hash_5243c598e26f304a", 3000 );
    
    if ( !isdefined( spawnorigin ) && var_3bbe4cbaaa0f5d43 >= 0 )
    {
        crateorigin = playergetbestdropbagorigin( timeuntilspawn );
        
        if ( isdefined( crateorigin ) )
        {
            spawnorigin = getsafeoriginaroundpoint( crateorigin, var_3bbe4cbaaa0f5d43, timeuntilspawn );
            spawnangles = function_46f3bef64ca7cfca( spawnorigin, crateorigin );
            spawntype = "dropBagOrigin";
        }
    }
    
    if ( !isdefined( spawnorigin ) )
    {
        spawnorigin = utility::callsharedfunc( #"gametype", #"playerGetRespawnPoint", forcefallback, timeuntilspawn, overrideheight );
        
        if ( isdefined( spawnorigin ) )
        {
            spawntype = "playerGetRespawnPoint";
        }
    }
    
    if ( !isdefined( spawnorigin ) )
    {
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
        {
            multicirclemerge = br_circle_util::function_209532a1558406f();
            
            if ( !isdefined( spawnorigin ) )
            {
                maxradiuspct = getdvarfloat( @"hash_2fc319e6652da3d9", 0.9 );
                
                if ( getdvarint( @"hash_f1d47ddb5b62548b", 1 ) )
                {
                    spawnorigin = br_circle::function_15469901d945c6e6( maxradiuspct, timeuntilspawn );
                    spawntype = "perimeterPointFromSquadmate";
                }
                
                if ( !isdefined( spawnorigin ) && getdvarint( @"hash_ef1ac888d0efeb04", 1 ) )
                {
                    spawnorigin = br_circle::function_7f760bea4038ceb9( maxradiuspct, timeuntilspawn );
                    spawntype = "perimeterPointFromLoadout";
                }
                
                if ( isdefined( spawnorigin ) )
                {
                    spawnangles = function_46f3bef64ca7cfca( spawnorigin, br_circle::getsafecircleorigin() );
                }
            }
            
            if ( !isdefined( spawnorigin ) )
            {
                origin = br_circle::getsafecircleorigin();
                radius = br_circle::getsafecircleradius();
                
                if ( multicirclemerge )
                {
                    origin = br_circle::getdangercircleorigin();
                    radius = br_circle::getdangercircleradius();
                }
                else if ( !br_circle_util::ispointindangercircle( origin ) )
                {
                    origin = br_circle::getdangercircleorigin();
                }
                
                minradiuspct = getdvarfloat( @"hash_8eb0ced475a9baf1", 0.5 );
                maxradiuspct = getdvarfloat( @"hash_4e9825c71ceb94ff", 0.9 );
                droptoground = getdvarint( @"hash_951c7b13ffdd6905", 1 );
                var_f5661efe10a6d8d5 = getdvarint( @"hash_7017ad29dbedc8b1", 1 );
                checkbadcircles = getdvarint( @"hash_7371a5983f296bd6", 1 );
                spawnorigin = br_circle::getrandompointinboundscircle( origin, radius, minradiuspct, maxradiuspct, droptoground, var_f5661efe10a6d8d5, checkbadcircles, timeuntilspawn );
                spawntype = "randomPointInBounds";
            }
        }
        else if ( isdefined( level.prematchspawnorigins ) )
        {
            if ( isdefined( level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ] ) && isdefined( level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] ) && isdefined( level.autorespawnwaittime ) && level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] + level.autorespawnwaittime * 1000 > gettime() )
            {
                spawnorigin = level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ];
                spawntype = "chosenOrigin";
            }
            else
            {
                potentialspawnloc = [];
                
                foreach ( struct in level.prematchspawnorigins )
                {
                    if ( distance2dsquared( struct.origin, self.origin ) > var_3bbe4cbaaa0f5d43 )
                    {
                        potentialspawnloc[ potentialspawnloc.size ] = struct;
                    }
                }
                
                if ( potentialspawnloc.size == 0 )
                {
                    potentialspawnloc = level.prematchspawnorigins;
                }
                
                potentialspawnloc = arrayrandomize( potentialspawnloc );
                spawnorigin = potentialspawnloc[ 0 ].origin;
                spawnorigin += math::random_vector_2d() * randomfloatrange( 100, 500 );
                spawntype = "randomPotential";
                level.teamdata[ self.team ][ "chosenSpawnWipeOrigin" ] = spawnorigin;
                level.teamdata[ self.team ][ "spawnWipeOriginUseStartTime" ] = gettime();
            }
            
            spawnangles = ( 0, 0, 0 );
            
            if ( spawnorigin[ 2 ] > 10000 )
            {
                offsetheight = 0;
                height = br_infils_util::getinfilspawnoffset();
            }
        }
        else
        {
            spawnorigin = ( 0, 0, 0 );
            spawnangles = ( 0, 0, 0 );
            spawntype = "zero";
        }
    }
    
    if ( !isdefined( spawnangles ) )
    {
        circleorigin = br_circle::getsafecircleorigin();
        var_1bc7de998fb61520 = vectortoyaw( circleorigin - spawnorigin );
        spawnangles = ( 0, var_1bc7de998fb61520, 0 );
    }
    
    if ( offsetheight )
    {
        if ( !isdefined( height ) )
        {
            height = parachute::getc130height();
        }
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_fba4f384e28bf0aa" ) )
        {
            height *= utility::callsharedfunc( #"gametype", #"hash_fba4f384e28bf0aa" );
        }
        
        if ( isdefined( level.var_7a699d76269b09dd ) && game_utility::getgametype() != "dmz" )
        {
            height = level.var_7a699d76269b09dd;
        }
        
        if ( isdefined( level.respawnheightoverride ) )
        {
            height = level.respawnheightoverride;
        }
        
        if ( level.var_4000387528ae054e && game_utility::getgametype() != "dmz" )
        {
            height = function_cac58a82af2065a0( height );
        }
        
        dropspawnoffset = ( 0, 0, height );
        spawnorigin = br::getoffsetspawnoriginmultitrace( spawnorigin, dropspawnoffset );
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawnorigin;
    spawnpoint.angles = spawnangles;
    spawnpoint.height = height;
    spawnpoint.type = spawntype;
    
    if ( getdvarint( @"hash_3055e0f04ccac0e4", 1 ) )
    {
        if ( outofbounds::ispointinoutofbounds( spawnpoint.origin ) )
        {
            switch ( spawntype )
            {
                case #"hash_881585932f5309f8":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using setSpawnPoint" );
                    break;
                case #"hash_92d9b519cc4ed831":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using lastDeath" );
                    break;
                case #"hash_5ebf5fe3ac8c1009":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using abovePlayerCached" );
                    break;
                case #"hash_32dde0b86dfcf603":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using abovePlayer" );
                    break;
                case #"hash_ce247261a67b199d":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using respawningTeammate" );
                    break;
                case #"hash_523f16a1bd5c632b":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using missionOrigin" );
                    break;
                case #"hash_2407d21162ec8264":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using dropBagOrigin" );
                    break;
                case #"hash_4866a4440a9d2f4d":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using brGameTypeFunc" );
                    break;
                case #"hash_9bb2da60407fd710":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using pointFromSquadmate" );
                    break;
                case #"hash_ee97f72782afbedd":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using perimeterPointFromSquadmate" );
                    break;
                case #"hash_fd00b142d0523bb2":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using perimeterPointFromLoadout" );
                    break;
                case #"hash_7b5c236dc48a8946":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using randomPointInBounds" );
                    break;
                case #"hash_36f5ff8a130e852d":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using chosenOrigin" );
                    break;
                case #"hash_237a346d94c046e4":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using randomPotential" );
                    break;
                case #"hash_6e4a8ac4007a65c3":
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using zero" );
                    break;
                default:
                    script::demoforcesre( "Spawning in OOB - trying to spawn at " + spawnpoint.origin + " for player " + self.name + " using " + spawntype );
                    break;
            }
        }
    }
    
    return spawnpoint;
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x1764aee1, Offset: 0x387b
// Size: 0x58
function function_46f3bef64ca7cfca( startorigin, facingorigin )
{
    if ( isdefined( startorigin ) && isdefined( facingorigin ) )
    {
        yawtopoint = vectortoyaw( facingorigin - startorigin );
        angles = ( getdvarfloat( @"hash_d6f7a211c05b441f", 75 ), yawtopoint, 0 );
        return angles;
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0xc06a4784, Offset: 0x38db
// Size: 0x33
function playercleanupentondisconnect( ent )
{
    ent endon( #"death" );
    self waittill( #"disconnect" );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x6d0c35e3, Offset: 0x3916
// Size: 0x2c
function function_45fa421c1d07d98d( enable )
{
    if ( enable )
    {
        self enableoffhandweapons();
        self enableusability();
        return;
    }
    
    self disableoffhandweapons();
    self disableusability();
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x52e0bff8, Offset: 0x394a
// Size: 0x7e
function triggerrespawnoverlay( overlaytype )
{
    self endon( #"disconnect" );
    gametyperesult = utility::callsharedfunc( #"gametype", #"triggerrespawnoverlay" );
    
    if ( gametyperesult )
    {
        return;
    }
    
    wait 0.5;
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagGetWinSplashName" ) )
    {
        splashname = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagGetWinSplashName" );
    }
    else
    {
        splashname = "br_gulag_winner";
    }
    
    thread hud_message::showsplash( splashname );
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xe1747935, Offset: 0x39d0
// Size: 0x25
function resetplayermovespeedscale()
{
    player = self;
    player.fastcrouchspeedmod = 0;
    player weapons::updatemovespeedscale();
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x3378507f, Offset: 0x39fd
// Size: 0x41
function fadeoutin( fadetime )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( fadetime ) )
    {
        fadetime = 1;
    }
    
    playercinematicfadein();
    wait fadetime;
    function_24b79e9319c6f02f();
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x14a175b1, Offset: 0x3a46
// Size: 0x1f
function function_1d2f70d591e967bc( fadespectators )
{
    playercinematicfadein();
    
    if ( fadespectators )
    {
        function_5d4a5b47f8379be6();
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x21f69a09, Offset: 0x3a6d
// Size: 0x33
function function_3af483f3b14c0be8()
{
    self endon( #"disconnect" );
    self endon( #"hash_88b506e95217aeab" );
    level waittill( #"game_ended" );
    self setclientomnvar( "ui_br_bink_overlay_state", 0 );
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xd9658a5d, Offset: 0x3aa8
// Size: 0x10
function function_24b79e9319c6f02f()
{
    thread playercinematicfadeout();
    function_20a55c2045d87009();
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x9ccc5743, Offset: 0x3ac0
// Size: 0x85
function function_5d4a5b47f8379be6()
{
    spectators = br_spectate::getspectatorsofplayer( self );
    
    foreach ( spectator in spectators )
    {
        spectator playercinematicfadein();
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x566d4214, Offset: 0x3b4d
// Size: 0x85
function function_20a55c2045d87009()
{
    spectators = br_spectate::getspectatorsofplayer( self );
    
    foreach ( spectator in spectators )
    {
        spectator thread playercinematicfadeout();
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0xdf3e70d1, Offset: 0x3bda
// Size: 0x41
function fadeoutinspectatorsofplayer( fadetime )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( fadetime ) )
    {
        fadetime = 1;
    }
    
    function_5d4a5b47f8379be6();
    wait fadetime;
    function_20a55c2045d87009();
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x60034d36, Offset: 0x3c23
// Size: 0x36, Type: bool
function playeriscinematiclayeron()
{
    if ( !isbrgamemode() )
    {
        return false;
    }
    
    var_14d8333365f3e831 = self getclientomnvar( "ui_br_bink_overlay_state" );
    
    if ( var_14d8333365f3e831 != 0 && var_14d8333365f3e831 != 6 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x108b2e97, Offset: 0x3c62
// Size: 0x1d, Type: bool
function playeriscinematicblacklayeron()
{
    var_14d8333365f3e831 = self getclientomnvar( "ui_br_bink_overlay_state" );
    return var_14d8333365f3e831 == 7;
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xc192f19e, Offset: 0x3c88
// Size: 0xf
function playercinematicfadein()
{
    self setclientomnvar( "ui_br_bink_overlay_state", 7 );
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xd9fb5dd, Offset: 0x3c9f
// Size: 0xf
function function_b995a9d3493c8016()
{
    self setclientomnvar( "ui_br_bink_overlay_state", 11 );
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0xfeff95d0, Offset: 0x3cb6
// Size: 0x3f
function playercinematicfadeout()
{
    self endon( #"disconnect" );
    
    if ( playeriscinematiclayeron() )
    {
        self setclientomnvar( "ui_br_bink_overlay_state", 6 );
        wait 1;
        self setclientomnvar( "ui_br_bink_overlay_state", 0 );
        self notify( #"hash_ab0234dbcc755765" );
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x5985e689, Offset: 0x3cfd
// Size: 0x471
function plunderplayerrespawn()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( getdvarint( @"hash_fe3afd6ead4aa523", 1 ) == 1 )
    {
        self endon( #"hash_36e455a1fbf78b10" );
    }
    
    teamcount = teams::getteamdata( self.team, "teamCount" );
    
    if ( !self.squadwiped || teamcount == 1 )
    {
        var_17f3151ec6647b00 = 1;
        wait var_17f3151ec6647b00;
    }
    
    if ( self.hasrespawntoken && isdefined( level.tokenrespawnwaittime ) )
    {
        spawnwait = level.tokenrespawnwaittime;
    }
    else if ( level.incrementalrespawnpunish > 0 )
    {
        spawnwait = clamp( self.pers[ "deaths" ] * level.incrementalrespawnpunish, 0, level.incrementalrespawnpunishmax );
    }
    else if ( isdefined( level.autorespawnwaittime ) )
    {
        spawnwait = level.autorespawnwaittime;
    }
    else
    {
        spawnwait = getdvarint( @"hash_5639a8f49b94dacb", 20 );
    }
    
    var_7ae41cb151b43258 = getdvarfloat( @"hash_de0dfc4549393ba2", 10 );
    
    if ( spawnwait < var_7ae41cb151b43258 )
    {
        spawnwait = var_7ae41cb151b43258;
    }
    
    if ( level.respawntimedisable != 0 )
    {
        spawnwait = 0;
    }
    
    var_887d7794502fe6a0 = getdvarfloat( @"hash_cc53a64fa6e4897b", 5 );
    utility::ent_flag_init( "playerRespawn_intermission_spawned" );
    self.intermissionspawnorigin = undefined;
    self.intermissionspawntime = undefined;
    
    if ( self.squadwiped || teamcount == 1 )
    {
        spawnpoint = playergetrespawnpoint();
        streamorigin = playerprestreamrespawnorigin( spawnpoint );
        thread fadetogearingup( 0, teamcount > 1 );
        wait var_887d7794502fe6a0;
    }
    else if ( !br_public::function_379fb7b09f4ef13e() )
    {
        lower_message::setlowermessageomnvar( "waiting_to_spawn", int( gettime() + spawnwait * 1000 ) );
        prestreamwait = spawnwait - var_7ae41cb151b43258;
        var_5061bd2ffc2167a1 = spawnwait - prestreamwait;
        blackscreenwait = spawnwait - getdvarfloat( @"hash_879a2fde5543837", 6 );
        thread fadetogearingup( blackscreenwait );
        result = utility::waittill_any_ents_or_timeout_return( prestreamwait, self, "squad_wipe_death", self, "plunder_early_respawn" );
        
        if ( result == "squad_wipe_death" )
        {
            spawnpoint = playergetrespawnpoint();
            streamorigin = playerprestreamrespawnorigin( spawnpoint );
            thread fadetogearingup( 0, 1 );
            wait var_887d7794502fe6a0;
        }
        else
        {
            thread updateprestreamrespawn();
            
            if ( result != "plunder_early_respawn" )
            {
                result = utility::waittill_any_ents_or_timeout_return( var_5061bd2ffc2167a1, self, "squad_wipe_death", self, "plunder_early_respawn" );
            }
            else
            {
                utility::ent_flag_wait_or_timeout( "playerRespawn_intermission_spawned", var_5061bd2ffc2167a1 );
            }
            
            if ( result == "squad_wipe_death" )
            {
                spawnpoint = playergetrespawnpoint();
                streamorigin = playerprestreamrespawnorigin( spawnpoint );
                thread fadetogearingup( 0, 1 );
                wait var_887d7794502fe6a0;
            }
        }
    }
    
    self notify( #"hash_90ac94f1376250d4" );
    spawnpoint = playergetrespawnpoint();
    streamorigin = playerprestreamrespawnorigin( spawnpoint );
    
    if ( self.squadwiped )
    {
        self.squadwiped = 0;
        
        if ( teamcount > 1 && !br_public::function_379fb7b09f4ef13e() )
        {
            hud_message::showsplash( "bm_your_squad_wiped" );
        }
    }
    
    if ( isteamextracted( self.team ) )
    {
        return;
    }
    
    if ( self.hasrespawntoken )
    {
        thread triggerrespawnoverlay( 4 );
        self.tokenrespawned = 1;
        item_redeploy_token::function_16ab0a48337237ef();
    }
    
    if ( isteamextracted( self.team ) )
    {
        return;
    }
    
    if ( getdvarint( @"scr_skip_respawn_gate", 1 ) == 0 )
    {
        streamhint::playerwaittillstreamhintcomplete();
    }
    
    utility::ent_flag_clear( "playerRespawn_intermission_spawned" );
    self.intermissionspawnorigin = undefined;
    self.intermissionspawntime = undefined;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    playerlogic::spawnplayer( undefined, 0 );
    execution::_clearexecution();
    
    if ( br_public::function_379fb7b09f4ef13e() && isdefined( level.player_respawn_struct ) )
    {
        spawnpoint = utility::getstruct( level.player_respawn_struct, "targetname" );
    }
    
    br_gulag::gulagwinnerrespawn( 1, undefined, spawnpoint, 1, streamorigin, 1 );
    br_utility::unmarkplayeraseliminated( self, "plunderPlayerRespawn" );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_respawn" );
    omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 0 );
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x51fe4407, Offset: 0x4176
// Size: 0x13e
function fadetogearingup( waittime, squadwiped )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self notify( #"hash_910faf4d1446a162" );
    self endon( #"hash_910faf4d1446a162" );
    
    if ( waittime > 0 )
    {
        result = utility::waittill_notify_or_timeout_return( "plunder_early_respawn", waittime );
    }
    
    pre_spawn_delay = 1;
    thread function_390452263f5d56c9();
    wait pre_spawn_delay - 0.25;
    
    if ( squadwiped )
    {
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 6 );
    }
    else
    {
        omnvar_utility::setcachedclientomnvar( "ui_br_transition_type", 2 );
    }
    
    wait 0.25;
    
    if ( getdvarint( @"hash_f006294ef8b720a4", 1 ) == 1 )
    {
        br_public::playerclearstreamhintorigin();
        spawnpoint = playergetrespawnpoint();
        br_spectate::playerclearspectatekillchainsystem();
        br::spawnintermission( spawnpoint.origin, spawnpoint.angles );
        spectating::setdisabled();
        self.intermissionspawnorigin = spawnpoint.origin;
        self.intermissionspawntime = gettime();
        utility::ent_flag_set( "playerRespawn_intermission_spawned" );
    }
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x2f69a414, Offset: 0x42bc
// Size: 0x35
function function_390452263f5d56c9()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    function_1d2f70d591e967bc();
    self waittill( #"spawned_player" );
    function_24b79e9319c6f02f();
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x6d01e2bc, Offset: 0x42f9
// Size: 0xdf
function updateprestreamrespawn()
{
    self endon( #"disconnect" );
    self endon( #"spawned_player" );
    self endon( #"hash_90ac94f1376250d4" );
    
    while ( true )
    {
        if ( utility::ent_flag( "playerRespawn_intermission_spawned" ) )
        {
            spawnpoint = playergetrespawnpoint();
            currenttime = gettime();
            assert( isdefined( self.intermissionspawntime ) );
            assert( self.intermissionspawntime <= currenttime );
            
            if ( currenttime - self.intermissionspawntime >= getdvarfloat( @"hash_57fbcc1bae0f210a", 2 ) * 1000 )
            {
                spawnpoint = playergetrespawnpoint( 1 );
                streamorigin = playerprestreamrespawnorigin( spawnpoint );
            }
        }
        else
        {
            spawnpoint = playergetrespawnpoint();
            streamorigin = playerprestreamrespawnorigin( spawnpoint );
        }
        
        wait 1;
    }
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0xb2c586fc, Offset: 0x43e0
// Size: 0x21
function setteamasextracted( team )
{
    level.teamdata[ team ][ "extracted" ] = 1;
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0xa087f558, Offset: 0x4409
// Size: 0x1f, Type: bool
function isteamextracted( team )
{
    return istrue( level.teamdata[ team ][ "extracted" ] );
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x96980121, Offset: 0x4431
// Size: 0xa1
function function_cac58a82af2065a0( height )
{
    if ( isdefined( level.var_83c0d2a5e8ba8f63 ) )
    {
        if ( level.var_33202c0f3d019a6a < 0 || level.br_circle.circleindex < level.var_33202c0f3d019a6a )
        {
            var_c114c75876fbe2fe = level.var_83c0d2a5e8ba8f63 * level.br_circle.circleindex;
            height = function_e6807518d99c4d92( height, var_c114c75876fbe2fe );
        }
        else
        {
            var_c114c75876fbe2fe = level.var_83c0d2a5e8ba8f63 * level.var_33202c0f3d019a6a;
            height = function_e6807518d99c4d92( height, var_c114c75876fbe2fe );
        }
    }
    
    return height;
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x3d0c8e3, Offset: 0x44db
// Size: 0x4e
function function_e6807518d99c4d92( height, var_c114c75876fbe2fe )
{
    if ( var_c114c75876fbe2fe > 0 )
    {
        var_7ff11ddbda3c6c7e = height * var_c114c75876fbe2fe;
        height -= var_7ff11ddbda3c6c7e;
        
        if ( height <= level.var_e2f750d22e646497 )
        {
            height = level.var_e2f750d22e646497;
        }
    }
    
    return height;
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x8cb8bc09, Offset: 0x4532
// Size: 0x179
function function_aa3d7586c93300d()
{
    tablename = getmatchrulesdata( "brData", "respawnLoadoutTable" );
    
    if ( tablename == "" )
    {
        return;
    }
    
    respawnloadouttable = getscriptbundle( "respawnloadouttable:" + tablename );
    
    if ( !isdefined( respawnloadouttable ) )
    {
        script::demoforcesre( "Respawn loadout table " + tablename + " does not exist" );
        return;
    }
    
    var_36de975efccb9a5a = [];
    
    foreach ( respawnloadout in respawnloadouttable.loadoutlist )
    {
        circleindex = respawnloadout.circleindex;
        respawnloadouts = function_d19a5086c01444cc( "classtable:" + respawnloadout.table, respawnloadout.var_f8b07d5cc269687f );
        
        if ( !isdefined( var_36de975efccb9a5a[ circleindex ] ) )
        {
            var_36de975efccb9a5a[ circleindex ] = respawnloadouts;
            continue;
        }
        
        var_36de975efccb9a5a[ circleindex ] = arraycombine( var_36de975efccb9a5a[ circleindex ], respawnloadouts );
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_6ba99bb58daf2866" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_6ba99bb58daf2866", var_36de975efccb9a5a );
        return;
    }
    
    function_95d67bf50df688f3( var_36de975efccb9a5a );
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0xa99f8ec6, Offset: 0x46b3
// Size: 0x86
function function_d19a5086c01444cc( table, var_f8b07d5cc269687f )
{
    var_2f4e6505b731029a = class::function_868832c7872f848e( table );
    respawnloadouts = [];
    
    for ( classindex = 0; classindex < var_2f4e6505b731029a ; classindex++ )
    {
        var_6717ec7589ba5992 = spawnstruct();
        var_6717ec7589ba5992.loadout = function_e7c6288b3961d735( classindex, table );
        var_6717ec7589ba5992.var_f8b07d5cc269687f = var_f8b07d5cc269687f;
        respawnloadouts[ respawnloadouts.size ] = var_6717ec7589ba5992;
    }
    
    return respawnloadouts;
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x4b070c44, Offset: 0x4742
// Size: 0x95
function function_95d67bf50df688f3( var_36de975efccb9a5a )
{
    level.respawnloadout = [];
    
    foreach ( circleindex, circleloadout in var_36de975efccb9a5a )
    {
        level.respawnloadout[ circleindex ] = circleloadout[ randomint( circleloadout.size ) ];
    }
}

// Namespace br_spawnrespawn
// Params 2
// Checksum 0x8fbe03cc, Offset: 0x47df
// Size: 0x43f
function function_e7c6288b3961d735( classindex, table )
{
    var_596fc0475db17612 = class::table_getitem( table, classindex );
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = var_596fc0475db17612.primaryweapon.weapon;
    loadout[ "loadoutPrimaryAttachment" ] = var_596fc0475db17612.primaryweapon.attachment1;
    loadout[ "loadoutPrimaryAttachment2" ] = var_596fc0475db17612.primaryweapon.attachment2;
    loadout[ "loadoutPrimaryAttachment3" ] = var_596fc0475db17612.primaryweapon.attachment3;
    loadout[ "loadoutPrimaryAttachment4" ] = var_596fc0475db17612.primaryweapon.attachment4;
    loadout[ "loadoutPrimaryAttachment5" ] = var_596fc0475db17612.primaryweapon.attachment5;
    loadout[ "loadoutPrimaryCamo" ] = var_596fc0475db17612.primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = var_596fc0475db17612.primaryweapon.reticle;
    loadout[ "loadoutSecondary" ] = var_596fc0475db17612.secondaryweapon.weapon;
    loadout[ "loadoutSecondaryAttachment" ] = var_596fc0475db17612.secondaryweapon.attachment1;
    loadout[ "loadoutSecondaryAttachment2" ] = var_596fc0475db17612.secondaryweapon.attachment2;
    loadout[ "loadoutSecondaryAttachment3" ] = var_596fc0475db17612.secondaryweapon.attachment3;
    loadout[ "loadoutSecondaryAttachment4" ] = var_596fc0475db17612.secondaryweapon.attachment4;
    loadout[ "loadoutSecondaryAttachment5" ] = var_596fc0475db17612.secondaryweapon.attachment5;
    loadout[ "loadoutSecondaryCamo" ] = var_596fc0475db17612.secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = var_596fc0475db17612.secondaryweapon.reticle;
    loadout[ "loadoutTertiary" ] = var_596fc0475db17612.tertiaryWeapon.weapon;
    loadout[ "loadoutTertiaryCamo" ] = var_596fc0475db17612.tertiaryWeapon.camo;
    loadout[ "loadoutTertiaryReticle" ] = var_596fc0475db17612.tertiaryWeapon.reticle;
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = var_596fc0475db17612.equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = var_596fc0475db17612.equipment.secondary;
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = getkillstreakloadout( var_596fc0475db17612.killstreak.killstreak1 );
    loadout[ "loadoutKillstreak2" ] = getkillstreakloadout( var_596fc0475db17612.killstreak.killstreak2 );
    loadout[ "loadoutKillstreak3" ] = getkillstreakloadout( var_596fc0475db17612.killstreak.killstreak3 );
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ var_596fc0475db17612.perks.perk1, var_596fc0475db17612.perks.perk2, var_596fc0475db17612.perks.perk3, var_596fc0475db17612.extraperks.perk1, var_596fc0475db17612.extraperks.perk2, var_596fc0475db17612.extraperks.perk3 ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "tableColumn" ] = classindex;
    loadout[ "loadoutFieldUpgrade1" ] = var_596fc0475db17612.fieldUpgrades.fieldupgrade1;
    loadout[ "loadoutFieldUpgrade2" ] = var_596fc0475db17612.fieldUpgrades.fieldupgrade2;
    loadout[ "loadoutFieldUpgrade3" ] = var_596fc0475db17612.fieldUpgrades.fieldupgrade3;
    return loadout;
}

// Namespace br_spawnrespawn
// Params 1
// Checksum 0x6553d04, Offset: 0x4c27
// Size: 0x38
function getkillstreakloadout( killstreakref )
{
    if ( !isdefined( killstreakref ) )
    {
        return "none";
    }
    else if ( isint( killstreakref ) )
    {
        return ( loot::function_f54ecb89dfab8e8c( killstreakref ) ?? "none" );
    }
    
    return killstreakref;
}

// Namespace br_spawnrespawn
// Params 0
// Checksum 0x3caef4d4, Offset: 0x4c68
// Size: 0xfb
function function_a4305f2e039b471e()
{
    loadout = level.br_standard_loadout;
    noextraammo = 0;
    
    if ( isdefined( level.respawnloadout ) )
    {
        circleindex = 0;
        
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            circleindex = level.br_circle.circleindex;
            
            if ( circleindex == -1 )
            {
                circleindex = 0;
            }
        }
        
        if ( circleindex > 0 && br_circle::function_8bdcbb2e3fe350() )
        {
            circleindex -= 1;
        }
        
        for ( index = 0; index <= circleindex ; index++ )
        {
            if ( isdefined( level.respawnloadout[ index ] ) )
            {
                loadout = level.respawnloadout[ index ].loadout;
                noextraammo = level.respawnloadout[ index ].var_f8b07d5cc269687f;
            }
        }
    }
    
    return [ loadout, noextraammo ];
}

