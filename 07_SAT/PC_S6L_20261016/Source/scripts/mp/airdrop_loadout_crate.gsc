// scripts\mp\airdrop_loadout_crate.gsc  (hash_6d8b7d16980bf2e6.gscc) (size: 6257 Bytes / 0x1871 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd81d800f (3625811983)
// size ...... 6257 (0x1871)
// includes .. 10  (offset: 0x1699)
// strings ... 30  (offset: 0x16e9)
// dev strs .. 0   (offset: 0x1871)
// exports ... 18  (offset: 0xec1)
// cseg ...... 0x289 + 0xc38 (0xec1)
// imports ... 44  (offset: 0x1191)
// animtree1 . 0   (offset: 0x1871)
// animtree2 . 0   (offset: 0x1871)
#using scripts\common\ae_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\hud_message;

#namespace airdrop_loadout_crate;

// Namespace airdrop_loadout_crate
// Params 0, eflags: 0x5
// Checksum 0x81151ac2, Offset: 0x2a7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"airdrop_loadout_crate", #"hash_60ba902b1d647a74", undefined, &post_main );
}

// Namespace airdrop_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0x87dcfc97, Offset: 0x2d0
// Size: 0x9
function private post_main()
{
    initializeairdrop();
}

// Namespace airdrop_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0x9a8a0512, Offset: 0x2e1
// Size: 0x61
function private initializeairdrop()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    gamemodebundle = getgamemodescriptbundle();
    level.var_f04aa33339fc802a = gamemodebundle.var_f04aa33339fc802a;
    
    if ( !airdrop_scriptbundle::function_fa19528c206bd43( level.var_f04aa33339fc802a ) )
    {
        function_8930c8ccd0ad3e9e( level.var_f04aa33339fc802a );
    }
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x449cd247, Offset: 0x34a
// Size: 0x6c
function private function_8930c8ccd0ad3e9e( airdropidentifier )
{
    airdrop_scriptbundle::registerairdrop( airdropidentifier, &function_41c25c2506e23c49 );
    
    if ( !airdrop_scriptbundle::function_fa19528c206bd43( airdropidentifier ) )
    {
        return;
    }
    
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"hash_f35f0e2b6123474f", &function_86280b6e97cf260c );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"crateactivatefunc", &function_58ba692fd39b8d86 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( airdropidentifier, #"cratedestroyfunc", &function_72c88a72a331b6f9 );
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x56e14531, Offset: 0x3be
// Size: 0x167
function private function_41c25c2506e23c49( crate )
{
    player = self;
    player endon( #"disconnect" );
    
    if ( self.insertingarmorplate )
    {
        player notify( #"try_armor_cancel", "loadout_open" );
    }
    
    var_a6975c3b19393da1 = 1;
    
    if ( ( isbot( player ) || isautopilot( player ) ) && isdefined( level.bot_funcs[ "select_class_from_airdrop" ] ) )
    {
        retval = player [[ level.bot_funcs[ "select_class_from_airdrop" ] ]]();
        var_a6975c3b19393da1 = 0;
    }
    else
    {
        retval = player br::br_selectdropbagclass( crate );
    }
    
    if ( retval )
    {
        crate brloadoutcratepostcapture( player );
    }
    else
    {
        return;
    }
    
    if ( var_a6975c3b19393da1 )
    {
        br::br_giveselectedclass( player, 1, 1 );
    }
    
    loadouttype = isstartstr( player.class, "custom" ) ? 1 : 0;
    player challenges::function_1a5812d73b979e8( loadouttype );
    player.endmatchstats[ "loadoutsOpened" ] = ( player.endmatchstats[ "loadoutsOpened" ] ?? 0 ) + 1;
    dropbagpos = crate.origin;
    wait 0.5;
    br_analytics::branalytics_dropbagused( player, dropbagpos, crate );
    br_analytics::branalytics_inventory_snapshot( player, "dropbag_used" );
    crate notify( #"hash_edb785fbd228830b", self );
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0xabb7ba96, Offset: 0x52d
// Size: 0x1e2
function private function_86280b6e97cf260c( airdropsettings )
{
    spawntype = airdropsettings.extradata.spawntype ?? 0;
    self.dropbagspawntypeenum = spawntype;
    
    if ( spawntype == 1 )
    {
        self setscriptablepartstate( "objective", "active_squad" );
    }
    
    if ( !airdropsettings.extradata.staticSpawn && isdefined( level.teamdata[ self.team ][ "alivePlayers" ] ) )
    {
        foreach ( teammate in level.teamdata[ self.team ][ "alivePlayers" ] )
        {
            if ( isdefined( teammate ) && !teammate br_public::isplayeringulag() )
            {
                if ( spawntype == 1 )
                {
                    teammate thread hud_message::showsplash( "br_airdrop_incoming_squad" );
                    continue;
                }
                
                teammate thread hud_message::showsplash( "br_airdrop_incoming" );
            }
        }
        
        if ( !br_public::istutorial() )
        {
            br_public::brleaderdialogteam( "dropbag_incoming", self.team, 1, 2, undefined );
        }
    }
    
    if ( airdropsettings.player )
    {
        br_analytics::branalytics_dropbagdeployed( airdropsettings.player, self.origin, spawntype, self );
    }
    
    if ( isdefined( airdropsettings.extradata.var_6bb90fbad80400c ) && isdefined( airdropsettings.instance ) )
    {
        self [[ airdropsettings.extradata.var_6bb90fbad80400c ]]( airdropsettings.instance );
    }
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0x373b8c67, Offset: 0x717
// Size: 0x2b
function private function_58ba692fd39b8d86( isfirstactivation )
{
    if ( isfirstactivation )
    {
        utility::callsharedfunc( #"airdrop", #"registercrateforcleanup", self );
    }
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0xc65b7f95, Offset: 0x74a
// Size: 0x7c
function private function_72c88a72a331b6f9( immediate )
{
    utility::callsharedfunc( #"airdrop", #"bronloadoutcratedestroyed", immediate );
    
    if ( self.numuses > 0 && isplayer( self.owner ) )
    {
        self.owner challenges::function_a0936b0e5b4550f3( "super_loadout_drop", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.numuses );
    }
}

// Namespace airdrop_loadout_crate
// Params 4
// Checksum 0xa21544ee, Offset: 0x7ce
// Size: 0xe3
function spawnloadoutcrate( player, position, spawntype, staticSpawn )
{
    overridestruct = { #dropheight:staticSpawn ? position[ 2 ] : undefined, #droporigin:position };
    overridestruct.extradata = { #staticSpawn:staticSpawn, #spawntype:spawntype };
    [ crate ] = airdrop_scriptbundle::startairdrop( level.var_f04aa33339fc802a, player, undefined, overridestruct );
    airdrop::function_93131a7c7bf0090e( crate, [ "position":position, "spawnType":spawntype, "staticSpawn":staticSpawn, "player.origin":player.origin, "func":"spawnLoadoutCrate" ] );
    return crate;
}

// Namespace airdrop_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0x706e36ed, Offset: 0x8ba
// Size: 0x69
function private function_6982ded1427379e3()
{
    overridestruct = { #var_506f162fae5199cc:1, #skipminimapicon:1, #var_f1b1db4ae9e5ccbc:1, #var_aa2bfcf28487c0ca:0 };
    overridestruct.extradata = { #var_478454c30af633da:1, #staticSpawn:1, #spawntype:0 };
    return overridestruct;
}

// Namespace airdrop_loadout_crate
// Params 0, eflags: 0x4
// Checksum 0xb0041a24, Offset: 0x92c
// Size: 0x8c
function private function_68de6181146665da()
{
    overridestruct = { #var_506f162fae5199cc:1, #skipminimapicon:1, #var_f1b1db4ae9e5ccbc:1, #var_aa2bfcf28487c0ca:0, #planescount:1, #var_8e83b15472993439:0, #droplocationtype:"map_center" };
    overridestruct.extradata = { #var_478454c30af633da:1, #staticSpawn:1, #spawntype:0 };
    return overridestruct;
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0xaf850119, Offset: 0x9c1
// Size: 0x4c
function private function_d40ac651b7041327( overridestruct )
{
    if ( !isdefined( level.var_f04aa33339fc802a ) || !airdrop_scriptbundle::function_fa19528c206bd43( level.var_f04aa33339fc802a ) )
    {
        initializeairdrop();
    }
    
    return airdrop_scriptbundle::startairdrop( level.var_f04aa33339fc802a, undefined, "neutral", overridestruct );
}

// Namespace airdrop_loadout_crate
// Params 1, eflags: 0x4
// Checksum 0xf89f36d4, Offset: 0xa16
// Size: 0x3a
function private function_c70ddeac40572b8( overridestruct )
{
    if ( !airdrop_scriptbundle::function_fa19528c206bd43( "airdrop_loadout_crate_contested" ) )
    {
        function_8930c8ccd0ad3e9e( "airdrop_loadout_crate_contested" );
    }
    
    return airdrop_scriptbundle::startairdrop( "airdrop_loadout_crate_contested", undefined, "neutral", overridestruct );
}

// Namespace airdrop_loadout_crate
// Params 2, eflags: 0x4
// Checksum 0x3f1acb54, Offset: 0xa59
// Size: 0x42
function private function_860c6f1b6907a1a2( overridestruct, debugdata )
{
    [ crate ] = function_d40ac651b7041327( overridestruct );
    airdrop::function_93131a7c7bf0090e( crate, debugdata );
    return crate;
}

// Namespace airdrop_loadout_crate
// Params 3
// Checksum 0x217d0eca, Offset: 0xaa4
// Size: 0x95
function spawnBattleRoyaleLoadoutCrate( dropstart, dropend, angles = undefined )
{
    overridestruct = function_6982ded1427379e3();
    overridestruct.droporigin = dropend;
    overridestruct.dropheight = dropstart[ 2 ];
    overridestruct.dropangles = angles ?? ( 0, randomfloat( 360 ), 0 );
    return function_860c6f1b6907a1a2( overridestruct, [ "dropEnd":dropend, "dropStart":dropstart, "func":"spawnBattleRoyaleLoadoutCrate" ] );
}

// Namespace airdrop_loadout_crate
// Params 8
// Checksum 0x753f372d, Offset: 0xb42
// Size: 0x228
function startPublicEventBattleRoyaleLoadoutPlaneAirdrop( activityinstance, var_6bb90fbad80400c, cratecount, droporigin, dropradius, planeangles = undefined, planeheight = undefined, var_4f6fef3211483c93 = undefined )
{
    overridestruct = function_68de6181146665da();
    overridestruct.droporigin = droporigin;
    overridestruct.dropradius = dropradius;
    overridestruct.dropheight = planeheight ?? level.var_4280cdebdfea8385 ?? 12000;
    overridestruct.var_e99a789e113b7ba4 = cratecount;
    overridestruct.instance = activityinstance;
    overridestruct.extradata.var_6bb90fbad80400c = var_6bb90fbad80400c;
    overridestruct.extradata.planeangles = planeangles;
    
    if ( isdefined( var_4f6fef3211483c93 ) )
    {
        overridestruct.planepathradius = var_4f6fef3211483c93.pathradius;
        overridestruct.var_a238f8847e16057e = var_4f6fef3211483c93.var_72c0afeaa1bb09fc;
        overridestruct.var_7ce84f7710a333d1 = var_4f6fef3211483c93.var_764e4f15c5c12fb3;
        overridestruct.var_55c241b661fa662f = var_4f6fef3211483c93.dropfunc;
        overridestruct.extradata.var_1e435386c7339add = var_4f6fef3211483c93.dropdata;
    }
    
    cratesarray = function_c70ddeac40572b8( overridestruct );
    
    foreach ( crate in cratesarray )
    {
        airdrop::function_93131a7c7bf0090e( crate, [ "dropRadius":dropradius, "dropOrigin":droporigin, "crateCount":cratecount, "func":"startPublicEventBattleRoyaleLoadoutPlaneAirdrop" ] );
    }
    
    return cratesarray;
}

// Namespace airdrop_loadout_crate
// Params 1
// Checksum 0x88195051, Offset: 0xd73
// Size: 0x14e
function brloadoutcratepostcapture( player )
{
    if ( !isdefined( self.numuses ) )
    {
        self.numuses = 0;
    }
    
    if ( !isdefined( self.playersused ) )
    {
        self.playersused = [];
    }
    
    if ( !isdefined( self.playerscaptured ) )
    {
        self.playerscaptured = [];
    }
    
    self.playerscaptured[ player getentitynumber() ] = player;
    self.playersused[ self.playersused.size ] = player;
    self.numuses++;
    airdrop::function_b9fc17612f972c6f( player, 0 );
    self notify( #"hash_46171d7389a9f291", player );
    player notify( #"loadout_crate_captured", self );
    
    if ( self.strongholdcrate || self.var_fa487df922edd83a )
    {
        return;
    }
    
    if ( !self.airdropsettings.extradata.var_478454c30af633da && self.numuses >= level.teamdata[ player.team ][ "teamCount" ] )
    {
        if ( self.choosenlocation.inuse )
        {
            self.choosenlocation.inuse = 0;
        }
        
        thread airdrop::destroycrate();
    }
    
    challenges::function_37e945722d6497f3( player, "pickup_airdrop_crate", 1 );
}

