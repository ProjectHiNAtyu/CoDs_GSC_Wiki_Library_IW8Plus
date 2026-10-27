// scripts\mp\br\gametypes\br_bunker_alt.gsc  (hash_234d36d553a80275.gscc) (size: 7685 Bytes / 0x1e05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53529879 (1397921913)
// size ...... 7685 (0x1e05)
// includes .. 8   (offset: 0x1bd9)
// strings ... 27  (offset: 0x1c19)
// dev strs .. 7   (offset: 0x1db1)
// exports ... 19  (offset: 0x11bd)
// cseg ...... 0x20c + 0xfb1 (0x11bd)
// imports ... 57  (offset: 0x14b5)
// animtree1 . 0   (offset: 0x1e05)
// animtree2 . 0   (offset: 0x1e05)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_bunker_loot_vaults;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace br_bunker_alt;

// Namespace br_bunker_alt
// Params 0
// Checksum 0x2f08781d, Offset: 0x22a
// Size: 0x24, Type: bool
function isbunkeraltenabled()
{
    return getdvarint( @"scr_br_bunker_alt_enabled", 1 ) && getdvarint( @"scr_sierra_sidequest_enabled", 1 );
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0xd705169f, Offset: 0x257
// Size: 0xe0
function initnonbunkerdoors()
{
    if ( !isdefined( level.br_bunker_alt ) )
    {
        level.br_bunker_alt = spawnstruct();
    }
    
    level.br_bunker_alt.nonbunkerdoors = [];
    level.br_bunker_alt.nonbunkerdoors[ "barn" ] = getentitylessscriptablearray( "br_bunker_alt_barn", #script_noteworthy );
    level.br_bunker_alt.nonbunkerdoors[ "outhouse" ] = getentitylessscriptablearray( "br_bunker_alt_outhouse", #script_noteworthy );
    level.br_bunker_alt.nonbunkerdoors[ "shed_01" ] = getentitylessscriptablearray( "br_bunker_alt_shed_01", #script_noteworthy );
    level.br_bunker_alt.nonbunkerdoors[ "shed_02" ] = getentitylessscriptablearray( "br_bunker_alt_shed_02", #script_noteworthy );
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0x55b0f493, Offset: 0x33f
// Size: 0x22f
function init()
{
    if ( !isbunkeraltenabled() )
    {
        return;
    }
    
    level.br_bunker_alt = spawnstruct();
    initnonbunkerdoors();
    level.br_bunker_alt.bunkervaults = spawnstruct();
    level.br_bunker_alt.bunkervaults.doors = [];
    level.br_bunker_alt.bunkervaults.hints = [];
    var_c79a0d7906fada9f = getentarray( "bunker_door_" + 1, #targetname );
    var_3c2d6a3da3de33c7 = getentitylessscriptablearray( "bunker_door_" + 1, #targetname );
    level.br_bunker_alt.bunkervaults.doors[ 1 ] = var_3c2d6a3da3de33c7[ 0 ] ?? var_c79a0d7906fada9f[ 0 ];
    var_c79a0e7906fadcd2 = getentarray( "bunker_door_" + 3, #targetname );
    var_3c2d6b3da3de35fa = getentitylessscriptablearray( "bunker_door_" + 3, #targetname );
    level.br_bunker_alt.bunkervaults.doors[ 3 ] = var_3c2d6b3da3de35fa[ 0 ] ?? var_c79a0e7906fadcd2[ 0 ];
    var_c79a0f7906fadf05 = getentarray( "bunker_door_" + 10, #targetname );
    var_3c2d6c3da3de382d = getentitylessscriptablearray( "bunker_door_" + 10, #targetname );
    level.br_bunker_alt.bunkervaults.doors[ 10 ] = var_3c2d6c3da3de382d[ 0 ] ?? var_c79a0f7906fadf05[ 0 ];
    var_c79a087906facfa0 = getentarray( "bunker_door_" + 0, #targetname );
    var_3c2d653da3de28c8 = getentitylessscriptablearray( "bunker_door_" + 0, #targetname );
    level.br_bunker_alt.bunkervaults.doors[ 0 ] = var_3c2d653da3de28c8[ 0 ] ?? var_c79a087906facfa0[ 0 ];
    scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_alt", &keypadscriptableused_altbunker );
    level thread initpostmain();
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0xfb2261b4, Offset: 0x576
// Size: 0x11
function initnonbr()
{
    initnonbunkerdoors();
    level thread locknonbunkerdoors();
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0xda4ab2a, Offset: 0x58f
// Size: 0x2b
function initbrmechanics()
{
    initnonbunkerdoors();
    level initnonbunkerdoorkeypad();
    level scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_alt", &keypadscriptableused_altbunker );
    level thread locknonbunkerdoors();
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0x32f7328d, Offset: 0x5c2
// Size: 0x204
function initpostmain()
{
    waittillframeend();
    var_17f03e2dd8633a99 = getdvarint( @"hash_dbf8b77ea6cffc8d", 1 );
    var_4fd3767a07fccf29 = getdvarint( hashcat( @"hash_2ac45dbf3d037071", 2, "_enabled" ), 1 ) && var_17f03e2dd8633a99;
    var_4fd3737a07fcc890 = getdvarint( hashcat( @"hash_2ac45dbf3d037071", 3, "_enabled" ), 1 ) && var_17f03e2dd8633a99;
    var_4fd3747a07fccac3 = getdvarint( hashcat( @"hash_2ac45dbf3d037071", 8, "_enabled" ), 1 ) && var_17f03e2dd8633a99;
    var_4fd3797a07fcd5c2 = getdvarint( hashcat( @"hash_2ac45dbf3d037071", 1, "_enabled" ), 1 ) && var_17f03e2dd8633a99;
    ignorelightfx = 1;
    level thread br_bunker_utility::initbunkerdoor( level.br_bunker_alt.bunkervaults.doors[ 1 ], var_4fd3767a07fccf29, ignorelightfx );
    level thread br_bunker_utility::initbunkerdoor( level.br_bunker_alt.bunkervaults.doors[ 3 ], var_4fd3737a07fcc890, ignorelightfx );
    level thread br_bunker_utility::initbunkerdoor( level.br_bunker_alt.bunkervaults.doors[ 10 ], var_4fd3747a07fccac3, ignorelightfx );
    level thread br_bunker_utility::initbunkerdoor( level.br_bunker_alt.bunkervaults.doors[ 0 ], var_4fd3797a07fcd5c2, ignorelightfx );
    
    if ( getdvarint( @"scr_br_bunker_alt_keypad_enable", 1 ) )
    {
        forwardfacing = 1;
        altbunker = 1;
        level br_bunker_loot_vaults::initlootvaultkeypad( var_4fd3767a07fccf29, 1, forwardfacing, altbunker );
        level br_bunker_loot_vaults::initlootvaultkeypad( var_4fd3737a07fcc890, 3, forwardfacing, altbunker );
        level br_bunker_loot_vaults::initlootvaultkeypad( var_4fd3747a07fccac3, 10, forwardfacing, altbunker );
        level br_bunker_loot_vaults::initlootvaultkeypad( var_4fd3797a07fcd5c2, 0, 0, altbunker );
    }
    
    if ( getdvarint( @"scr_br_bunker_alt_keypad_enable", 1 ) )
    {
        level initnonbunkerdoorkeypad();
    }
    
    level thread locknonbunkerdoors();
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0xa1732739, Offset: 0x7ce
// Size: 0x108
function locknonbunkerdoors()
{
    var_2cebe14d10c5cf53 = getdvarint( @"hash_c9065088441a5ba4", 10 );
    wait var_2cebe14d10c5cf53;
    
    foreach ( var_7c1f6fbb352b3415 in level.br_bunker_alt.nonbunkerdoors )
    {
        foreach ( nonbunkerdoor in var_7c1f6fbb352b3415 )
        {
            nonbunkerdoor scriptabledoorfreeze( 1 );
        }
    }
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0xf4df0117, Offset: 0x8de
// Size: 0x1e1
function initnonbunkerdoorkeypad()
{
    if ( !getdvarint( @"scr_br_bunker_alt_keypad_enable", 1 ) )
    {
        return;
    }
    
    foreach ( var_778711f7eea7cc07, var_7c1f6fbb352b3415 in level.br_bunker_alt.nonbunkerdoors )
    {
        if ( !isdefined( var_7c1f6fbb352b3415[ 0 ] ) )
        {
            continue;
        }
        
        firstdoor = var_7c1f6fbb352b3415[ 0 ];
        seconddoor = var_7c1f6fbb352b3415[ 1 ];
        forwardangles = anglestoforward( firstdoor.angles );
        leftangles = anglestoleft( firstdoor.angles );
        
        switch ( var_778711f7eea7cc07 )
        {
            case #"hash_51929d2eb8e4fbfc":
                forwardscale = 72;
                leftscale = -10;
                break;
            case #"hash_c38a833e41a93969":
                forwardscale = -28;
                leftscale = 10;
                break;
            case #"hash_ad3a177bd9ddb713":
                forwardscale = 62;
                leftscale = -10;
                break;
            case #"hash_ad3a187bd9ddb8a6":
                forwardscale = 62;
                leftscale = 10;
                break;
            default:
                forwardscale = 0;
                leftscale = 0;
                assertmsg( "<dev string:x24>" );
                break;
        }
        
        hintorigin = firstdoor.origin + ( 0, 0, 45 ) + forwardangles * forwardscale + leftangles * leftscale;
        var_e1857b2e3a4d8b97 = spawnscriptable( "maphint_keypad_bunker_alt", hintorigin );
        var_e1857b2e3a4d8b97.door = firstdoor;
        
        if ( isdefined( seconddoor ) )
        {
            var_e1857b2e3a4d8b97.door2 = seconddoor;
        }
    }
}

// Namespace br_bunker_alt
// Params 1
// Checksum 0xc5bf01a8, Offset: 0xac7
// Size: 0x2b, Type: bool
function isaltbunkerscriptable( keypadscriptableinstance )
{
    bunkerindex = getaltbunkerkeypadindexforscriptable( keypadscriptableinstance );
    
    if ( bunkerindex >= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_bunker_alt
// Params 1
// Checksum 0x4fa38cd, Offset: 0xafb
// Size: 0x4c
function getaltbunkerkeypadindexforscriptable( keypadscriptableinstance )
{
    if ( !isbunkeraltenabled() )
    {
        return -1;
    }
    
    bunkername = getbunkernamefromkeypadscriptableinstance( keypadscriptableinstance );
    
    if ( !isstring( bunkername ) )
    {
        return -1;
    }
    
    bunkerindex = getaltbunkerindexforname( bunkername );
    return bunkerindex;
}

// Namespace br_bunker_alt
// Params 1
// Checksum 0x1e54b5b3, Offset: 0xb50
// Size: 0x83
function getbunkernamefromkeypadscriptableinstance( keypadscriptableinstance )
{
    if ( isdefined( keypadscriptableinstance ) && isdefined( keypadscriptableinstance.door ) )
    {
        if ( isdefined( keypadscriptableinstance.door.targetname ) )
        {
            return keypadscriptableinstance.door.targetname;
        }
        else if ( isdefined( keypadscriptableinstance.door.script_noteworthy ) )
        {
            return keypadscriptableinstance.door.script_noteworthy;
        }
    }
    
    return 0;
}

// Namespace br_bunker_alt
// Params 6
// Checksum 0x18ae3ad3, Offset: 0xbdc
// Size: 0x62
function keypadscriptableused_altbunker( instance, part, state, player, bautouse, usestring )
{
    if ( !isbunkeraltenabled() )
    {
        return;
    }
    
    if ( !instance.inuse )
    {
        player thread _keypadscriptableused_bunkeralt( instance, part, state, player, bautouse );
    }
}

// Namespace br_bunker_alt
// Params 5
// Checksum 0x6a682343, Offset: 0xc46
// Size: 0x17d
function _keypadscriptableused_bunkeralt( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x4c>" );
    isaltbunker = isaltbunkerscriptable( instance );
    assert( isaltbunker, "<dev string:x66>" );
    player notify( #"hash_179b5b572f285ed7" );
    player endon( #"hash_179b5b572f285ed7" );
    
    if ( !flags::gameflag( "prematch_done" ) && !getdvarint( @"scr_br_bunker_alt_devtest", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_cb72ef230bf544ae", 1 ) && !self.br_infilstarted )
    {
        return;
    }
    
    bunkeraltindex = getaltbunkerkeypadindexforscriptable( instance );
    
    if ( bunkeraltindex == -1 )
    {
        return;
    }
    
    /#
        if ( !isbrgamemode() && getdvarint( @"scr_br_bunker_alt_devtest", 0 ) )
        {
            iprintlnbold( "<dev string:xbb>" );
            openaltbunker( instance );
            return;
        }
    #/
    
    if ( instance.inuse )
    {
        /#
            player iprintlnbold( "<dev string:x103>" );
        #/
        
        return;
    }
    
    instance.inuse = 1;
    
    if ( instance.isdooropened )
    {
        /#
            player iprintlnbold( "<dev string:x123>" );
        #/
        
        return;
    }
    
    player bunkeralt_playerinteractwithkeypadloop( bunkeraltindex, instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    instance.inuse = undefined;
}

// Namespace br_bunker_alt
// Params 2
// Checksum 0x929530d2, Offset: 0xdcb
// Size: 0x22b
function bunkeralt_playerinteractwithkeypadloop( bunkeraltindex, instance )
{
    level endon( #"game_ended" );
    self endon( #"bunkeralt_kickplayerfromkeypadmsg" );
    thread bunkeralt_damagedeathdisconnectwatch();
    thread bunkeralt_playeridlewatch();
    br_keypad_util::playersetkeypadstateindex( 1 );
    br_keypad_util::playersetkeypadcodelengthindex( 8 );
    
    while ( isdefined( self ) && br_keypad_util::getkeypadstatefromomnvar() != 0 )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( isdefined( message ) )
        {
            if ( message == "submit_br_keypad" )
            {
                if ( getdvarint( @"scr_br_bunker_alt_refresh_idle_timer_on_try", 0 ) )
                {
                    thread bunkeralt_playeridlewatch();
                }
                
                if ( verifybunkercode( bunkeraltindex, value ) && getdvarint( hashcat( @"hash_7b8e27e53a0ff743", bunkeraltindex ), 1 ) )
                {
                    br_keypad_util::playersetkeypadstateindex( 2 );
                    self dlog_recordplayerevent( "dlog_event_br_bunker_data", [ "index", instance.bunkernumber, "isaltbunker", 1, "success", 1 ] );
                    teammatecount = teams::getsquadmates( self.team, self.sessionsquadid, 0 ).size;
                    points::function_40522c040a4e7b1( self.team, #"br_bunker_opened" );
                    utility::callsharedfunc( #"br_bunkers", #"hash_7df9a859177613d0", instance.bunkernumber );
                    level thread waittoopenaltbunker( instance );
                    break;
                }
                else
                {
                    if ( soundexists( "br_keypad_deny" ) )
                    {
                        playsoundatpos( self.origin, "br_keypad_deny" );
                    }
                    
                    self dlog_recordplayerevent( "dlog_event_br_bunker_data", [ "index", instance.bunkernumber, "isaltbunker", 1, "success", 0 ] );
                    br_keypad_util::playersetkeypadstateindex( 3 );
                    msg = utility::waittill_any_timeout( 2, "luinotifyserver" );
                    
                    if ( isdefined( self ) )
                    {
                        br_keypad_util::playersetkeypadstateindex( 1 );
                    }
                }
                
                continue;
            }
            
            if ( message == "exit_br_keypad" )
            {
                break;
            }
        }
    }
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0xbfd73818, Offset: 0xffe
// Size: 0x3c
function bunkeralt_damagedeathdisconnectwatch()
{
    self endon( #"bunkeralt_kickplayerfromkeypadmsg" );
    level endon( #"game_ended" );
    utility::waittill_any( "death", "disconnect", "damage" );
    self notify( #"bunkeralt_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_alt
// Params 0
// Checksum 0x2ce611ba, Offset: 0x1042
// Size: 0x42
function bunkeralt_playeridlewatch()
{
    self endon( #"bunkeralt_kickplayerfromkeypadmsg" );
    self notify( #"hash_269e3f9df098b8ce" );
    self endon( #"hash_269e3f9df098b8ce" );
    wait getdvarint( @"hash_a7f55bd602c77336", 30 );
    self notify( #"bunkeralt_kickplayerfromkeypadmsg" );
}

// Namespace br_bunker_alt
// Params 1
// Checksum 0xbd091e2e, Offset: 0x108c
// Size: 0x40
function waittoopenaltbunker( var_6660b1bfa0ac05d6 )
{
    level endon( #"game_ended" );
    var_6660b1bfa0ac05d6.isdooropened = 1;
    wait getdvarint( @"hash_487f91ad6699c497", 2 );
    level openaltbunker( var_6660b1bfa0ac05d6 );
}

// Namespace br_bunker_alt
// Params 1
// Checksum 0x421e4fd8, Offset: 0x10d4
// Size: 0xe9
function openaltbunker( var_6660b1bfa0ac05d6 )
{
    if ( isbunkeraltenabled() )
    {
        if ( isdefined( var_6660b1bfa0ac05d6.door.targetname ) )
        {
            level thread br_bunker_utility::openbunkerdoor( var_6660b1bfa0ac05d6.door, 0, "bunker_loot_shared", "door_open" );
            var_6660b1bfa0ac05d6 setscriptablepartstate( "maphint_keypad_bunker_alt", "off" );
            return;
        }
        
        if ( isdefined( var_6660b1bfa0ac05d6.door.script_noteworthy ) )
        {
            var_6660b1bfa0ac05d6.door scriptabledooropen( "away", var_6660b1bfa0ac05d6.origin );
            
            if ( isdefined( var_6660b1bfa0ac05d6.door2 ) )
            {
                var_6660b1bfa0ac05d6.door2 scriptabledooropen( "away", var_6660b1bfa0ac05d6.origin );
            }
            
            var_6660b1bfa0ac05d6 setscriptablepartstate( "maphint_keypad_bunker_alt", "off" );
            return;
        }
        
        assertmsg( "<dev string:x147>" );
    }
}

