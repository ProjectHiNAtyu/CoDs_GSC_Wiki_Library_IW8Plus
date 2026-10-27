// scripts\mp\common\killstreaks\airdrop_mp.gsc  (hash_697980dd287ce599.gscc) (size: 7723 Bytes / 0x1e2b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74593087 (1952002183)
// size ...... 7723 (0x1e2b)
// includes .. 19  (offset: 0x1b23)
// strings ... 35  (offset: 0x1bbb)
// dev strs .. 7   (offset: 0x1dd7)
// exports ... 21  (offset: 0x102f)
// cseg ...... 0x267 + 0xdc8 (0x102f)
// imports ... 65  (offset: 0x1377)
// animtree1 . 0   (offset: 0x1e2b)
// animtree2 . 0   (offset: 0x1e2b)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\analyticslog;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\airdrop_escort;
#using scripts\mp\common\killstreaks\airdrop_multiple;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\target_marker;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\entityheadicons;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;
#using scripts\mp\movers;
#using scripts\mp\rank;

#namespace airdrop_mp;

// Namespace airdrop_mp
// Params 0
// Checksum 0xf40f2268, Offset: 0x285
// Size: 0x3c3
function init()
{
    killstreaks::registerkillstreak( "airdrop", &airdrop::tryuseairdropmarkerfromstruct );
    utility::registersharedfunc( #"airdrop", #"airdropmultipleinit", &airdrop_airdropmultipleinit );
    utility::registersharedfunc( #"airdrop", #"airdropescortinit", &function_3929b24d05e343ab );
    utility::registersharedfunc( #"airdrop", #"registerscoreinfo", &airdrop_registerscoreinfo );
    utility::registersharedfunc( #"airdrop", #"registeractionset", &airdrop_registeractionset );
    utility::registersharedfunc( #"airdrop", #"updateuiprogress", &airdrop_updateuiprogress );
    utility::registersharedfunc( #"airdrop", #"allowactionset", &airdrop_allowactionset );
    utility::registersharedfunc( #"airdrop", #"unresolvedcollisionnearestnode", &airdrop_unresolvedcollisionnearestnode );
    utility::registersharedfunc( #"airdrop", #"awardkillstreak", &airdrop_awardkillstreak );
    utility::registersharedfunc( #"airdrop", #"showkillstreaksplash", &airdrop_showkillstreaksplash );
    utility::registersharedfunc( #"airdrop", #"gettargetmarker", &airdrop_gettargetmarker );
    utility::registersharedfunc( #"airdrop", #"airdropmultipledropcrates", &airdrop_airdropmultipledropcrates );
    utility::registersharedfunc( #"airdrop", #"hash_77dba996a613078b", &function_ca8299b90ca53efc );
    utility::registersharedfunc( #"airdrop", #"outlinedisable", &airdrop_outlinedisable );
    utility::registersharedfunc( #"airdrop", #"capturelootcachecallback", &airdrop_capturelootcachecallback );
    utility::registersharedfunc( #"airdrop", #"applyimmediatejuggernaut", &airdrop_applyimmediatejuggernaut );
    utility::registersharedfunc( #"airdrop", #"airdropselectloadout", &function_d2e2d636c6b34c14 );
    utility::registersharedfunc( #"airdrop", #"attachxrays", &airdrop_attachxrays );
    airdrop_bundle = level.streakglobals.streakbundles[ "airdrop" ];
    crate_bundle = level.streakglobals.streakbundles[ "airdrop_crate" ];
    explosion_bundle = level.streakglobals.streakbundles[ "airdrop_explosion" ];
    
    if ( isdefined( airdrop_bundle.deployweaponname ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "airdrop", airdrop_bundle.deployweaponname, #"oneshot" );
    }
    
    if ( isdefined( crate_bundle.var_f35887e9870ee93d ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "airdrop_crate", crate_bundle.var_f35887e9870ee93d, #"oneshot" );
    }
    
    if ( isdefined( explosion_bundle.var_31bfffbff5c08ae1 ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "airdrop_explosion", explosion_bundle.var_31bfffbff5c08ae1, #"large" );
    }
    
    foreach ( model_override in airdrop_bundle.var_b6e36b250a73be73 )
    {
        if ( getdvarint( model_override.dvarstring, 0 ) && model_override.var_4d6b96b09a993801 )
        {
            level._effect[ model_override.var_4d6b96b09a993801 ] = loadfxasset( model_override.var_4d6b96b09a993801 );
            break;
        }
    }
}

// Namespace airdrop_mp
// Params 0
// Checksum 0xccfa222f, Offset: 0x650
// Size: 0x9
function airdrop_airdropmultipleinit()
{
    airdrop_multiple::airdrop_multiple_init();
}

// Namespace airdrop_mp
// Params 0
// Checksum 0x7a05d004, Offset: 0x661
// Size: 0x9
function function_3929b24d05e343ab()
{
    airdrop_escort::airdrop_escort_init();
}

// Namespace airdrop_mp
// Params 0
// Checksum 0x228f7f2b, Offset: 0x672
// Size: 0x1d
function airdrop_registerscoreinfo()
{
    rank::registerscoreinfo( #"little_bird", #"value", 200 );
}

// Namespace airdrop_mp
// Params 0
// Checksum 0xa5792626, Offset: 0x697
// Size: 0x136
function airdrop_registeractionset()
{
    var_55b610f22013b3ac = getdvarint( @"scr_airdrop_use_weapon", 1 );
    
    if ( var_55b610f22013b3ac )
    {
        val::group_register( "crateUse", [ "offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers", "sprint", "allow_jump", "mantle", "slide" ] );
        val::group_register( "juggCrateUse", [ "offhand_weapons", "weapon", "killstreaks", "supers", "sprint", "allow_jump", "mantle", "slide" ] );
        return;
    }
    
    val::group_register( "crateUse", [ "offhand_weapons", "weapon", "killstreaks", "supers", "sprint", "allow_jump", "mantle", "slide" ] );
}

// Namespace airdrop_mp
// Params 2
// Checksum 0x23b795d6, Offset: 0x7d5
// Size: 0x39
function airdrop_updateuiprogress( object, bool )
{
    if ( object )
    {
        object.usetime = object airdrop::getusetime( self );
        gameobjects::updateuiprogress( object, bool );
    }
}

// Namespace airdrop_mp
// Params 2
// Checksum 0x456e3bca, Offset: 0x816
// Size: 0x30
function airdrop_allowactionset( name, allow )
{
    if ( allow )
    {
        val::group_reset( name );
        return;
    }
    
    val::group_set( name, allow );
}

// Namespace airdrop_mp
// Params 3
// Checksum 0xc2f591a6, Offset: 0x84e
// Size: 0x29
function airdrop_unresolvedcollisionnearestnode( player, ballowsuicide, mover )
{
    childthread movers::unresolved_collision_nearest_node( player, ballowsuicide, mover );
}

// Namespace airdrop_mp
// Params 3
// Checksum 0x7d014033, Offset: 0x87f
// Size: 0x21d
function airdrop_awardkillstreak( streakname, owner, crate )
{
    if ( level.gametype == "grnd" || game_utility::isinfectedgametype() || level.gametype == "ob" || level.gametype == "training_course" || level.gametype == "wm" || common::function_70adce42ed4205fe() )
    {
        overrideowner = owner;
        overridelifeid = 0;
        var_469a3c9c3145a68 = 0;
    }
    else if ( owner != crate.streakinfo.owner )
    {
        overrideowner = owner;
        overridelifeid = owner.lifeid;
        var_469a3c9c3145a68 = owner.matchdatalifeindex;
    }
    else
    {
        overrideowner = crate.streakinfo.owner;
        overridelifeid = crate.streakinfo.mpstreaksysteminfo.streaklifeid;
        var_469a3c9c3145a68 = crate.streakinfo.mpstreaksysteminfo.streakmatchlifeid;
    }
    
    thread killstreaks::awardkillstreak( streakname, "carepackage", overridelifeid, var_469a3c9c3145a68, overrideowner );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "carepackagesCaptured" ] ) )
        {
            self.leaderboarddata[ "carepackagesCaptured" ] = self.leaderboarddata[ "carepackagesCaptured" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "carepackagesCaptured" ] ) )
        {
            [[ level.leaderboardfunc[ "carepackagesCaptured" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( self.pers[ "carepackagesCaptured" ] ) )
        {
            self.pers[ "carepackagesCaptured" ] = self.pers[ "carepackagesCaptured" ] + 1;
        }
    }
}

// Namespace airdrop_mp
// Params 3
// Checksum 0xb24b987b, Offset: 0xaa4
// Size: 0x29
function airdrop_showkillstreaksplash( splashref, streakval, fromcarepackage )
{
    hud_message::showkillstreaksplash( splashref, streakval, fromcarepackage );
}

// Namespace airdrop_mp
// Params 1
// Checksum 0x32ea872d, Offset: 0xad5
// Size: 0x14
function airdrop_gettargetmarker( streakinfo )
{
    return target_marker::gettargetmarker( streakinfo );
}

// Namespace airdrop_mp
// Params 7
// Checksum 0xa96cbf45, Offset: 0xaf2
// Size: 0x52
function airdrop_airdropmultipledropcrates( owner, team, position, angles, destination, reservevehicle, streakinfo )
{
    return airdrop_multiple::airdrop_multiple_dropcrates( owner, team, position, angles, destination, reservevehicle, streakinfo );
}

// Namespace airdrop_mp
// Params 6
// Checksum 0xe75ab716, Offset: 0xb4d
// Size: 0x49, Type: bool
function function_ca8299b90ca53efc( owner, team, position, angles, destination, streakinfo )
{
    return airdrop_escort::function_fe4fcae6b5300dcc( owner, position, "crate", streakinfo );
}

// Namespace airdrop_mp
// Params 2
// Checksum 0x67e25e05, Offset: 0xb9f
// Size: 0x1f
function airdrop_outlinedisable( id, var_a180bd51b09ab4ad )
{
    outline::outlinedisable( id, var_a180bd51b09ab4ad );
}

// Namespace airdrop_mp
// Params 1
// Checksum 0x42cd976, Offset: 0xbc6
// Size: 0x26
function airdrop_capturelootcachecallback( player )
{
    player notify( #"opened_cache", self );
    player playlocalsound( "ammo_crate_use" );
}

// Namespace airdrop_mp
// Params 2
// Checksum 0xc5b1cc1f, Offset: 0xbf4
// Size: 0x170
function airdrop_applyimmediatejuggernaut( useimmediate, isrecon )
{
    streakname = "juggernaut";
    
    if ( isrecon )
    {
        streakname = "juggernaut_recon";
    }
    
    streakitem = killstreaks::createstreakitemstruct( streakname );
    streakitem.madeavailabletime = matchdata::gettimefrommatchstart( gettime() );
    streakitem.streaklifeid = self.lifeid;
    streakitem.streakmatchlifeid = self.matchdatalifeindex;
    streakitem.owner = self;
    streakitem.ownerxuid = self getxuid();
    streakitem.activatedtime = matchdata::gettimefrommatchstart( gettime() );
    analyticslog::logevent_killstreakactivated( self, streakitem.streaklifeid, streakitem.streakname, streakitem.isgimme, streakitem.activatedtime, self.origin );
    killstreaks::combatrecordkillstreakuse( streakname );
    killstreak_utility::playkillstreakusedialog( streakname );
    streakinfo = killstreak_utility::createstreakinfo( streakname, self );
    streakinfo.mpstreaksysteminfo = streakitem;
    
    if ( isrecon )
    {
        tryusefunc = level.sharedfuncs[ #"killstreak_juggernaut_recon" ][ #"hash_6a6ddfa2a5228ad1" ];
        
        if ( isdefined( tryusefunc ) )
        {
            self [[ tryusefunc ]]( streakinfo, useimmediate );
        }
        
        return;
    }
    
    juggernaut::tryusejuggernautfromstruct( streakinfo, useimmediate );
}

// Namespace airdrop_mp
// Params 1
// Checksum 0xebf5980e, Offset: 0xd6c
// Size: 0x1a8
function function_d2e2d636c6b34c14( crate )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( level.gameended )
    {
        return;
    }
    
    self freezecontrols( 1 );
    self.instantclassswapallowed = 1;
    println( "<dev string:x4a>" );
    println( "<dev string:x71>" );
    self setclientomnvar( "ui_open_menu_from_script", -1 );
    println( "<dev string:x9f>" );
    wait 0.1;
    println( "<dev string:xcb>" );
    self setclientomnvar( "ui_loadout_drop_use", 1 );
    self setclientomnvar( "ui_open_menu_from_script", 2 );
    println( "<dev string:x109>" );
    thread function_da9c1cb6060ba6a3( "death" );
    thread function_da9c1cb6060ba6a3( "last_stand_enter" );
    thread function_da9c1cb6060ba6a3( "luinotifyserver" );
    thread function_da9c1cb6060ba6a3( "meatshield_victim_start" );
    crate thread function_2cf72f25d33f489( self );
    self waittill( #"exit_airdrop_loadout", result );
    self.instantclassswapallowed = 0;
    self freezecontrols( 0 );
    self setclientomnvar( "ui_loadout_drop_use", 0 );
    println( "<dev string:x13e>" );
    
    if ( result && isdefined( crate ) )
    {
        crate airdrop::loadoutcratepostcapture();
        entityheadicons::setheadicon_removeclientfrommask( crate.headiconid, self );
        return;
    }
    
    if ( isdefined( crate ) && isdefined( crate.playerscaptured[ self getentitynumber() ] ) )
    {
        if ( crate.playerscaptured[ self getentitynumber() ] == self )
        {
            crate.playerscaptured = arrayremove( crate.playerscaptured, self );
        }
    }
    
    return;
}

// Namespace airdrop_mp
// Params 1
// Checksum 0x15fbbcd4, Offset: 0xf1c
// Size: 0x40
function function_2cf72f25d33f489( var_f618598aaa0a055f )
{
    var_f618598aaa0a055f endon( #"death_or_disconnect" );
    self endon( #"exit_airdrop_loadout" );
    self waittill( #"death" );
    var_f618598aaa0a055f notify( #"exit_airdrop_loadout", 0 );
}

// Namespace airdrop_mp
// Params 1
// Checksum 0x15e03a73, Offset: 0xf64
// Size: 0x91
function function_da9c1cb6060ba6a3( actionnotify )
{
    self endon( #"exit_airdrop_loadout" );
    selectedloadout = 0;
    
    while ( true )
    {
        self waittill( actionnotify, param1, param2 );
        
        if ( actionnotify == "luinotifyserver" )
        {
            if ( param1 != "class_select" )
            {
                if ( param1 == "class_menu_closed" )
                {
                    self notify( #"exit_airdrop_loadout", selectedloadout );
                    break;
                }
                
                continue;
            }
            
            selectedloadout = 1;
        }
        
        self notify( #"exit_airdrop_loadout", selectedloadout );
        break;
    }
}

// Namespace airdrop_mp
// Params 1
// Checksum 0x2beb305, Offset: 0xffd
// Size: 0x31
function airdrop_attachxrays( crate )
{
    if ( isdefined( crate.team ) )
    {
        crate setentityhudoutlinedata( 3, crate.team );
    }
    
    return crate;
}

