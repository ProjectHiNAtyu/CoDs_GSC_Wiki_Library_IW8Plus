// script_607ef68f7eca6183  (hash_607ef68f7eca6183.gscc) (size: 8483 Bytes / 0x2123 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21b2d323 (565367587)
// size ...... 8483 (0x2123)
// includes .. 5   (offset: 0x1deb)
// strings ... 49  (offset: 0x1e13)
// dev strs .. 9   (offset: 0x20b7)
// exports ... 26  (offset: 0x14a3)
// cseg ...... 0x4e3 + 0xfc0 (0x14a3)
// imports ... 40  (offset: 0x18b3)
// animtree1 . 0   (offset: 0x2123)
// animtree2 . 0   (offset: 0x2123)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;

#namespace namespace_2be4972bbff8c613;

// Namespace namespace_2be4972bbff8c613
// Params 2
// Checksum 0xf1e69fdc, Offset: 0x501
// Size: 0x2f
function setkillcamkilledbyitemomnvars( type, itemid )
{
    self setclientomnvar( "ui_killcam_killedby_item_type", type );
    self setclientomnvar( "ui_killcam_killedby_item_id", itemid );
}

// Namespace namespace_2be4972bbff8c613
// Params 2
// Checksum 0xf71354b6, Offset: 0x538
// Size: 0x2f
function function_faad689abc10239e( masteryprogress, masteryisdiamond )
{
    self setclientomnvar( "ui_killcam_killedby_progress", masteryprogress );
    self setclientomnvar( "ui_killcam_killedby_isdiamond", masteryisdiamond );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0xf7979a79, Offset: 0x56f
// Size: 0x1a
function function_a2554b36d79edd49()
{
    self setclientomnvar( "ui_killcam_killedby_progress", 0 );
    self setclientomnvar( "ui_killcam_killedby_isdiamond", 0 );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0xe73afd46, Offset: 0x591
// Size: 0x1c
function clearlootweaponomnvars()
{
    self setclientomnvar( "ui_killcam_killedby_loot_variant_id", -1 );
    self setclientomnvar( "ui_killcam_killedby_weapon_rarity", -1 );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0x92897793, Offset: 0x5b5
// Size: 0x30
function clearkillcamattachmentomnvars()
{
    for ( attachindex = 0; attachindex < 9 ; attachindex++ )
    {
        self setclientomnvar( "ui_killcam_killedby_attachment" + attachindex + 1, -1 );
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 2
// Checksum 0x2f5f75e0, Offset: 0x5ed
// Size: 0x1a3
function function_9740a1c0ad1f3945( rootweaponname, objweapon )
{
    if ( rootweaponname != "iw8_knife" )
    {
        attachments = getweaponattachments( objweapon );
        defaultattachments = [];
        
        if ( !isdefined( attachments ) )
        {
            attachments = [];
        }
        else
        {
            defaultattachments = getweapondefaultattachments( objweapon );
        }
        
        visibleattachments = 0;
        
        foreach ( fullattachment in attachments )
        {
            if ( arraycontains( defaultattachments, fullattachment ) )
            {
                continue;
            }
            
            attachmentdata = function_333a08591af6b59( objweapon, fullattachment );
            
            if ( attachmentdata )
            {
                var_4ac84104531b60f7 = getscriptbundle( attachmentdata );
                
                if ( weapon::attachmentisselectablerootname( rootweaponname, fullattachment ) && var_4ac84104531b60f7.category )
                {
                    if ( visibleattachments >= 9 )
                    {
                        if ( getdvarint( @"hash_acc60eefe697543f", 0 ) == 0 )
                        {
                            assertmsg( "<dev string:x24>" + getcompleteweaponname( objweapon ) );
                        }
                        
                        break;
                    }
                    
                    attachmentlootid = level.weaponattachments[ fullattachment ];
                    
                    if ( isdefined( attachmentlootid ) )
                    {
                        self setclientomnvar( "ui_killcam_killedby_attachment" + visibleattachments + 1, attachmentlootid );
                        visibleattachments++;
                    }
                }
            }
        }
        
        for ( attachindex = visibleattachments; attachindex < 9 ; attachindex++ )
        {
            self setclientomnvar( "ui_killcam_killedby_attachment" + attachindex + 1, -1 );
        }
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 1
// Checksum 0xa9c91945, Offset: 0x798
// Size: 0x26
function setkillcamuitimer( killcamlengthsec )
{
    self setclientomnvar( "ui_killcam_end_milliseconds", int( killcamlengthsec * 1000 ) + gettime() );
}

// Namespace namespace_2be4972bbff8c613
// Params 1
// Checksum 0x47a5887e, Offset: 0x7c6
// Size: 0xb8
function setkillcamkillstreaktypeomnvars( objweapon )
{
    killstreakindex = killstreak_utility::getkillstreakindex( level.killstreakweaponmap[ objweapon.basename ] );
    
    if ( isdefined( self.scorestreakvariantattackerinfo ) )
    {
        killstreakindex = self.scorestreakvariantattackerinfo.id;
        killstreakrarity = self.scorestreakvariantattackerinfo.rarity;
        self setclientomnvar( "ui_killcam_killedby_item_type", 1 );
        self setclientomnvar( "ui_killcam_killedby_loot_variant_id", killstreakindex );
        self setclientomnvar( "ui_killcam_killedby_weapon_rarity", killstreakrarity - 1 );
    }
    else
    {
        setkillcamkilledbyitemomnvars( 1, killstreakindex );
        clearlootweaponomnvars();
    }
    
    clearkillcamattachmentomnvars();
}

// Namespace namespace_2be4972bbff8c613
// Params 1
// Checksum 0xc2194e9e, Offset: 0x886
// Size: 0x71
function function_ba84a9360f330de9( objweapon )
{
    killstreakvehicleturret = 0;
    
    switch ( objweapon.basenamehash )
    {
        case %"airdrop_escort_turret_ballistics_mp":
        case %"chopper_support_turret_mp":
        case %"hover_jet_turret_mp":
        case %"hover_jet_turret_ballistics_mp":
        case %"airdrop_escort_turret_mp":
            killstreakvehicleturret = 1;
            break;
    }
    
    return killstreakvehicleturret;
}

// Namespace namespace_2be4972bbff8c613
// Params 2
// Checksum 0x74dcad34, Offset: 0x900
// Size: 0x39
function function_2b22128f01edca04( weaponname, functionpointer )
{
    if ( !isdefined( level.var_434562e911536bba ) )
    {
        level.var_434562e911536bba = [];
    }
    
    level.var_434562e911536bba[ weaponname ] = functionpointer;
}

// Namespace namespace_2be4972bbff8c613
// Params 1
// Checksum 0x6cf833c5, Offset: 0x941
// Size: 0x18
function function_739f75dbc29564c4( weaponname )
{
    return level.var_434562e911536bba[ weaponname ];
}

// Namespace namespace_2be4972bbff8c613
// Params 7
// Checksum 0xcf4de2b0, Offset: 0x962
// Size: 0x1e1
function trimkillcamtime( inflictoragentinfo, attacker, camtime, postdelay, predelay, maxtime, attackerlastspawntime )
{
    killcamlength = camtime + postdelay;
    
    if ( killcamlength > maxtime )
    {
        if ( maxtime < 2 )
        {
            return;
        }
        
        if ( maxtime - camtime >= 1 )
        {
            postdelay = maxtime - camtime;
        }
        else
        {
            postdelay = 1;
            camtime = maxtime - 1;
        }
        
        killcamlength = camtime + postdelay;
    }
    
    killcamoffset = camtime + predelay;
    currenttime = gettime();
    lastattackerspawntime = currenttime;
    
    if ( isdefined( inflictoragentinfo ) && isdefined( inflictoragentinfo.lastspawntime ) )
    {
        lastattackerspawntime = inflictoragentinfo.lastspawntime;
    }
    else
    {
        if ( isdefined( attackerlastspawntime ) )
        {
            lastattackerspawntime = attackerlastspawntime;
        }
        else if ( isdefined( attacker.lastspawntime ) )
        {
            lastattackerspawntime = attacker.lastspawntime;
        }
        
        if ( isdefined( attacker.deathtime ) )
        {
            if ( currenttime - attacker.deathtime < postdelay * 1000 )
            {
                postdelay = 1;
                postdelay -= level.framedurationseconds;
                killcamlength = camtime + postdelay;
            }
        }
    }
    
    if ( isdefined( lastattackerspawntime ) )
    {
        alivetime = ( currenttime - lastattackerspawntime ) / 1000;
    }
    else
    {
        alivetime = currenttime - 10000;
    }
    
    if ( killcamoffset > alivetime && alivetime > predelay )
    {
        var_c39e13b4dbb919ee = alivetime - predelay;
        
        if ( camtime > var_c39e13b4dbb919ee )
        {
            camtime = var_c39e13b4dbb919ee;
            killcamlength = camtime + postdelay;
            killcamoffset = camtime + predelay;
        }
    }
    
    result = spawnstruct();
    result.camtime = camtime;
    result.postdelay = postdelay;
    result.killcamlength = killcamlength;
    result.killcamoffset = killcamoffset;
    return result;
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0xa4ccfc00, Offset: 0xb4c
// Size: 0x17
function function_520f48ae7cc39a2d()
{
    wait 0.1;
    self stoplocalsound( level.var_4c05236cc4daf4b1 );
}

// Namespace namespace_2be4972bbff8c613
// Params 3
// Checksum 0xfe71d14a, Offset: 0xb6b
// Size: 0x45
function setcinematiccamerastyle( camerastyle, var_4819967de29114c8, var_398d04049d711d25 )
{
    self setclientomnvar( "cam_scene_name", camerastyle );
    self setclientomnvar( "cam_scene_lead", var_4819967de29114c8 );
    self setclientomnvar( "cam_scene_support", var_398d04049d711d25 );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0x15cc03d9, Offset: 0xbb8
// Size: 0x1c
function clearkillcamkilledbyitemomnvars()
{
    self setclientomnvar( "ui_killcam_killedby_item_type", -1 );
    self setclientomnvar( "ui_killcam_killedby_item_id", -1 );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0x5eec74c4, Offset: 0xbdc
// Size: 0x26
function function_f927db33929b39fc()
{
    self setclientomnvar( "ui_killstreak_controls", 0 );
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    self setclientomnvar( "ui_killstreak_index", 0 );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0xe936880b, Offset: 0xc0a
// Size: 0x85
function clearkillcamomnvars()
{
    clearkillcamkilledbyitemomnvars();
    self setclientomnvar( "ui_killcam_end_milliseconds", 0 );
    self setclientomnvar( "ui_killcam_killedby_id", -1 );
    self setclientomnvar( "ui_killcam_victim_id", -1 );
    self setclientomnvar( "ui_killcam_killedby_loot_variant_id", -1 );
    self setclientomnvar( "ui_killcam_killedby_weapon_rarity", -1 );
    clearkillcamattachmentomnvars();
    function_f927db33929b39fc();
    
    for ( perkindex = 0; perkindex < 6 ; perkindex++ )
    {
        self setclientomnvar( "ui_killcam_killedby_perk" + perkindex, "none" );
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 4
// Checksum 0x28f5ec8, Offset: 0xc97
// Size: 0x10d
function beginarchiveplayback( var_a7446692f5fc38c2, rewindtime, playbackduration, psoffsettime )
{
    player_utility::updatesessionstate( "spectator" );
    self.spectatekillcam = 1;
    self.forcespectatorclient = var_a7446692f5fc38c2;
    self.killcamentity = -1;
    self.archivetime = rewindtime;
    self.killcamlength = playbackduration;
    self.psoffsettime = psoffsettime ?? 0;
    self allowspectateteam( "freelook", 1 );
    self allowspectateteam( "none", 1 );
    
    foreach ( teamname in level.teamnamelist )
    {
        self allowspectateteam( teamname, 1 );
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 7
// Checksum 0xe5e44606, Offset: 0xdac
// Size: 0x16d, Type: bool
function setkillcamerastyle( einflictor, inflictoragentinfo, attackernum, evictim, killcamentityindex, killcaminfo, objweapon )
{
    killcaminfo.camerastyle = "unknown";
    
    if ( isdefined( inflictoragentinfo ) && isdefined( inflictoragentinfo.agent_type ) )
    {
        setcinematiccamerastyle( "killcam_agent", einflictor getentitynumber(), evictim getentitynumber() );
        killcaminfo.camerastyle = "killcam_agent";
        return true;
    }
    else if ( isdefined( einflictor ) && einflictor.isracecar )
    {
        if ( getdvarint( @"hash_1a5e4af153d0e5bb", 1 ) == 0 )
        {
            setcinematiccamerastyle( "killcam_racecar", einflictor.killcamentlookforward getentitynumber(), evictim getentitynumber() );
            killcaminfo.camerastyle = "killcam_racecar";
            return true;
        }
    }
    else if ( isdefined( objweapon.basenamehash ) )
    {
        if ( objweapon.basenamehash == %"manual_turret_mp" || objweapon.basenamehash == %"manual_turret_jup_mp" )
        {
            return true;
        }
    }
    else if ( killcamentityindex > 0 )
    {
        setcinematiccamerastyle( "unknown", -1, -1 );
        return false;
    }
    else
    {
        setcinematiccamerastyle( "unknown", -1, -1 );
        return false;
    }
    
    return false;
}

// Namespace namespace_2be4972bbff8c613
// Params 6
// Checksum 0x92685af8, Offset: 0xf22
// Size: 0xd0
function setkillcamentity( killcamentityindex, killcamoffset, starttime, killcamlookatentityindex, killcamentstickstolookatent, var_c9f36c9b6da231a2 )
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    killcamtime = gettime() - killcamoffset * 1000;
    
    if ( starttime > killcamtime )
    {
        waitframe();
        killcamoffset = self.archivetime;
        killcamtime = gettime() - killcamoffset * 1000;
        
        if ( starttime > killcamtime )
        {
            wait ( starttime - killcamtime ) / 1000;
        }
    }
    
    self.killcamentity = killcamentityindex;
    
    if ( isdefined( killcamlookatentityindex ) )
    {
        self.killcamentitylookat = killcamlookatentityindex;
    }
    
    if ( isdefined( killcamentstickstolookatent ) )
    {
        self setkillcamentstickstolookatent( killcamentstickstolookatent );
    }
    
    if ( isdefined( var_c9f36c9b6da231a2 ) )
    {
        self function_e277518068267b6c( var_c9f36c9b6da231a2 );
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 1
// Checksum 0x3f909f03, Offset: 0xffa
// Size: 0x222
function checkkillcamtruncation( killcamoffset )
{
    if ( !isdefined( killcamoffset ) )
    {
        return;
    }
    
    assert( self.archivetime <= killcamoffset + 0.0001, "<dev string:x59>" + self.archivetime + "<dev string:x67>" + killcamoffset );
    
    if ( self.archivetime + 0.015 < killcamoffset )
    {
        /#
            var_4def2e6b544115de = killcamoffset - self.archivetime;
        #/
        
        if ( game[ "truncated_killcams" ] < 32 )
        {
            println( "<dev string:x86>" + game[ "<dev string:xb4>" ] );
            game[ "truncated_killcams" ]++;
        }
        
        /#
            println( "<dev string:xc7>" + var_4def2e6b544115de + "<dev string:xee>" );
            
            if ( getdvarint( @"hash_d82edd92078136c7", 0 ) == 1 )
            {
                assertmsg( "<dev string:x12a>" + var_4def2e6b544115de + "<dev string:x144>" );
            }
        #/
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "killcam - Truncated killcam - " + killcamoffset - self.archivetime );
        }
        
        self dlog_recordplayerevent( "dlog_event_killcam_truncated", [ "archive_requested", int( killcamoffset / level.framedurationseconds ), "archive_available", int( ( self.archivetime ?? 0 ) / level.framedurationseconds ), "game_time", gettime() / ( 1000 ?? 0 ), "map_name", level.mapname ?? "", "playlist_name", getplaylistname() ?? "", "playlist_id", getplaylistid() ?? 0, "br_circle_index", level.br_circle.circleindex ?? 0, "alive_player_count", level.var_fc71e82557e9a9c2 ?? 0 ] );
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 2
// Checksum 0x947aae40, Offset: 0x1224
// Size: 0x116
function dokillcamslowmo( camtime, isfinalkillcam )
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    
    if ( isdefined( level.doingkillcamslowmo ) )
    {
        return;
    }
    
    level.doingkillcamslowmo = 1;
    accumtime = 0;
    var_94e6bc93ed828d48 = camtime;
    
    if ( var_94e6bc93ed828d48 > 1 )
    {
        var_94e6bc93ed828d48 = 1;
        accumtime += 1;
        wait camtime - accumtime;
    }
    
    if ( !isdefined( level.killcam_timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "killcam" );
        level.killcam_timescalefactor = 1;
    }
    
    if ( isfinalkillcam )
    {
        self playlocalsound( "uin_finalkillcam_slowmo_enter" );
    }
    
    level.doingkillcamslowmo = 1;
    callback::callback( #"hash_2b0737f47cfada7e" );
    setslowmotion( 1, 0.25, var_94e6bc93ed828d48 );
    wait var_94e6bc93ed828d48 + 0.5;
    
    if ( isfinalkillcam && isdefined( self ) )
    {
        self playlocalsound( "uin_finalkillcam_slowmo_exit" );
    }
    
    setslowmotion( 0.25, 1, 1 );
    level.doingkillcamslowmo = undefined;
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0xd3930c00, Offset: 0x1342
// Size: 0x89
function endkillcamifnothingtoshow()
{
    self endon( #"disconnect" );
    self endon( #"killcam_ended" );
    
    while ( true )
    {
        if ( self.archivetime <= 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    player_utility::printspawnmessage( "killcam::endKillcamIfNothingToShow() Killcam SKIPPED" );
    self notify( #"abort_killcam" );
    
    if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
    {
        logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "endKillcamIfNothingToShow - abort_killcam" );
    }
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0x17bc3d55, Offset: 0x13d3
// Size: 0x55
function waittillkillcamover()
{
    self endon( #"abort_killcam" );
    player_utility::printspawnmessage( "killcam::waittillKillcamOver() START" );
    waittime = self.killcamlength - level.frameduration / 1000;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    player_utility::printspawnmessage( "killcam::waittillKillcamOver() COMPLETE" );
}

// Namespace namespace_2be4972bbff8c613
// Params 0
// Checksum 0xb5570493, Offset: 0x1430
// Size: 0x73
function function_f1bdd64504937120()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"spawned" );
    
    if ( level.killcam )
    {
        while ( !isdefined( self.willshowkillcam ) )
        {
            waitframe();
        }
        
        if ( level.killcam && self.killcam )
        {
            utility::waittill_any( "killcam_ended", "killcam_canceled", "abort_killcam" );
        }
    }
}

