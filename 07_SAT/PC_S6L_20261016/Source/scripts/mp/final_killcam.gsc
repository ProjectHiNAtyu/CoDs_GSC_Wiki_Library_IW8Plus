// scripts\mp\final_killcam.gsc  (hash_6c56be85dc248d98.gscc) (size: 27668 Bytes / 0x6c14 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa04ac720 (2689255200)
// size ...... 27668 (0x6c14)
// includes .. 18  (offset: 0x5db8)
// strings ... 108 (offset: 0x5e48)
// dev strs .. 86  (offset: 0x65c8)
// exports ... 39  (offset: 0x44b0)
// cseg ...... 0xe0e + 0x36a2 (0x44b0)
// imports ... 150 (offset: 0x4ac8)
// animtree1 . 1   (offset: 0x6ae4)
// animtree2 . 16  (offset: 0x6b14)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\anim;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\killcam;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\potg;

#namespace final_killcam;

// Namespace final_killcam
// Params 4, eflags: 0x4
// Checksum 0xc99b1103, Offset: 0xe2c
// Size: 0xcb
function private potg_killcam_debugprint( tag, severity, msg, throttlems )
{
    /#
        if ( !getdvarint( @"scr_potg_debug", 0 ) )
        {
            return;
        }
        
        if ( isdefined( throttlems ) )
        {
            if ( !isdefined( level.var_578b0ef7a48eb047 ) )
            {
                level.var_578b0ef7a48eb047 = [];
            }
            
            tagkey = "<dev string:x24>" + tag;
            lastlog = level.var_578b0ef7a48eb047[ tagkey ];
            
            if ( !isdefined( lastlog ) )
            {
                lastlog = 0;
            }
            
            nowms = gettime();
            
            if ( nowms - lastlog < throttlems )
            {
                return;
            }
            
            level.var_578b0ef7a48eb047[ tagkey ] = nowms;
        }
        
        println( severity + "<dev string:x2c>" + tag + "<dev string:x33>" + msg );
    #/
}

// Namespace final_killcam
// Params 0
// Checksum 0xf99e336d, Offset: 0xeff
// Size: 0xfb
function initfinalkillcam()
{
    level.finalkillcamenabled = level.finalkillcamtype == 0;
    level.finalkillcams = [];
    
    foreach ( teamname in level.teamnamelist )
    {
        level.finalkillcams[ teamname ] = undefined;
    }
    
    level.finalkillcams[ "none" ] = undefined;
    level.finalkillcam_winner = undefined;
    level.recordfinalkillcam = 1;
    
    if ( isbrgamemode() && !utility::callsharedfunc( #"gametype", #"hash_e5435a50cbd76321" ) )
    {
        level.finalkillcamenabled = 1;
        return;
    }
    
    /#
        level thread function_ed78e7dbba9ceb4();
    #/
}

// Namespace final_killcam
// Params 0
// Checksum 0x5acc73bd, Offset: 0x1002
// Size: 0x54
function erasefinalkillcam()
{
    for ( i = 0; i < level.teamnamelist.size ; i++ )
    {
        level.finalkillcams[ level.teamnamelist[ i ] ] = undefined;
    }
    
    level.finalkillcams[ "none" ] = undefined;
    level.finalkillcam_winner = undefined;
}

// Namespace final_killcam
// Params 0
// Checksum 0x695c9f6, Offset: 0x105e
// Size: 0x34f
function preloadfinalkillcam()
{
    spectateentity = undefined;
    
    if ( level.nukeinfo.detonated )
    {
        return;
    }
    
    if ( level.brdisablefinalkillcam )
    {
        return;
    }
    
    if ( getdvarint( @"hash_166b51bf7450fc22", 0 ) == 1 )
    {
        return;
    }
    
    if ( level.skipfinalkillcam )
    {
        return;
    }
    
    assert( level.finalkillcamenabled || level.potgenabled, "<dev string:x38>" );
    
    if ( level.potgenabled )
    {
        if ( potg::shouldskippotg() )
        {
            /#
                potg_killcam_debugprint( "<dev string:x94>", "<dev string:x9c>", "<dev string:x9f>" + "<dev string:xe6>" + level.potgenabled, undefined );
            #/
            
            level.potgenabled = 0;
            level.finalkillcamtype = 0;
            level.finalkillcamenabled = 1;
        }
    }
    
    killcamstruct = undefined;
    
    if ( level.finalkillcamenabled )
    {
        killcamstruct = level.finalkillcams[ level.finalkillcam_winner ];
        
        if ( !isdefined( killcamstruct ) )
        {
            flags::levelflagset( "final_killcam_preloaded" );
            return;
        }
        
        spectateentity = killcamstruct.attacker;
    }
    else
    {
        assert( level.potgenabled );
        
        while ( !potg::issystemfinalized() )
        {
            waitframe();
        }
        
        if ( potg::shouldskippotg() == 0 )
        {
            potginfo = potg::getfinalpotginfo();
            
            if ( !isdefined( potginfo ) )
            {
                /#
                    potg_killcam_debugprint( "<dev string:x94>", "<dev string:xf5>", "<dev string:xf8>", undefined );
                #/
                
                flags::levelflagset( "final_killcam_preloaded" );
                return;
            }
            
            spectateentity = potginfo.spectateentity;
        }
        else
        {
            /#
                potg_killcam_debugprint( "<dev string:x94>", "<dev string:x9c>", "<dev string:x147>" + "<dev string:x17d>" + level.finalkillcam_winner, undefined );
            #/
            
            level.potgenabled = 0;
            level.finalkillcamtype = 0;
            level.finalkillcamenabled = 1;
            killcamstruct = level.finalkillcams[ level.finalkillcam_winner ];
            
            if ( !isdefined( killcamstruct ) )
            {
                flags::levelflagset( "final_killcam_preloaded" );
                return;
            }
            
            spectateentity = killcamstruct.attacker;
        }
    }
    
    if ( !isplayer( spectateentity ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x94>", "<dev string:xf5>", "<dev string:x187>" + ( spectateentity ?? "<dev string:x1cb>" ), undefined );
        #/
        
        flags::levelflagset( "final_killcam_preloaded" );
        return;
    }
    
    if ( isdefined( killcamstruct ) && isdefined( killcamstruct.streampos ) )
    {
        var_aea880cebd692ae7 = killcamstruct.streampos;
    }
    else
    {
        var_aea880cebd692ae7 = spectateentity geteye();
    }
    
    foreach ( player in level.players )
    {
        player loadcustomizationplayerview( spectateentity );
        player predictstreamposuntilcleared( var_aea880cebd692ae7 );
    }
    
    if ( level.potgenabled )
    {
        /#
            potg_killcam_debugprint( "<dev string:x94>", "<dev string:x1da>", "<dev string:x1dd>" + "<dev string:x1f7>" + gettime(), undefined );
        #/
        
        wait 1;
    }
    
    flags::levelflagset( "final_killcam_preloaded" );
}

// Namespace final_killcam
// Params 1
// Checksum 0xb5c228c, Offset: 0x13b5
// Size: 0x3c5
function dopotgkillcam( potginfo = undefined )
{
    if ( level.skipfinalkillcam || level.nukeinfo.detonated )
    {
        return;
    }
    
    level.showingfinalkillcam = 1;
    level.maxkillcamdelay = 0;
    setglobalsoundcontext( "atmosphere", "killcam", 0.1 );
    
    if ( level.gametypebundle.var_c6dba97e65cd67ce && function_4042d2fbe6237835( #"hash_a1c42204f0dbdfd4" ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x204>", "<dev string:x9c>", "<dev string:x20a>", undefined );
        #/
        
        level.gametypebundle.var_c6dba97e65cd67ce = 0;
    }
    
    if ( !isdefined( potginfo ) )
    {
        potginfo = potg::getfinalpotginfo();
    }
    
    if ( !isdefined( potginfo ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x259>", "<dev string:xf5>", "<dev string:x25e>", undefined );
        #/
        
        level.showingfinalkillcam = 0;
        return;
    }
    
    if ( level.gametypebundle.var_c6dba97e65cd67ce )
    {
        /#
            potg_killcam_debugprint( "<dev string:x204>", "<dev string:x1da>", "<dev string:x29f>" + "<dev string:x2b7>" + ( isdefined( potginfo.firstweapon ) ? potginfo.firstweapon.basename : "<dev string:x2c9>" ) + "<dev string:x2d3>" + ( isdefined( potginfo.spectateentity ) ? potginfo.spectateentity.name : "<dev string:x2c9>" ), undefined );
        #/
        
        if ( isdefined( potginfo.spectateentity ) )
        {
            if ( potginfo.spectateentity )
            {
                data = spawnstruct();
                data.victim = potginfo.spectateentity;
                shock_stick::function_396a585ccd7071f5( data, 0 );
            }
            
            function_bfe1d46eb1d3f070( potginfo );
            wait 1;
            
            foreach ( player in level.players )
            {
                level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
            }
            
            level function_4fdbde962ed80391( potginfo );
        }
        else
        {
            /#
                potg_killcam_debugprint( "<dev string:x204>", "<dev string:xf5>", "<dev string:x2e5>", undefined );
            #/
        }
    }
    
    foreach ( player in level.players )
    {
        player thread dopotgkillcamforplayer( potginfo );
    }
    
    function_fbe534e93adf2542( potginfo );
    function_d5b1d5f61bceaeb8();
    
    while ( true )
    {
        anyplayersinkillcam = 0;
        
        foreach ( player in level.players )
        {
            if ( player.inpotgkillcam )
            {
                anyplayersinkillcam = 1;
                break;
            }
        }
        
        if ( !anyplayersinkillcam )
        {
            break;
        }
        
        waitframe();
    }
    
    level.showingfinalkillcam = 0;
    function_778a0548e7d63d50();
    setglobalsoundcontext( "atmosphere", "", 0.1 );
}

// Namespace final_killcam
// Params 1
// Checksum 0x3161ad90, Offset: 0x1782
// Size: 0x2d4
function dopotgkillcamforplayer( potginfo )
{
    self endon( #"disconnect" );
    self notify( #"showing_potg" );
    self.inpotgkillcam = 1;
    
    /#
        potg_killcam_debugprint( "<dev string:x319>", "<dev string:x1da>", "<dev string:x320>" + "<dev string:x33d>" + self.name, undefined );
    #/
    
    if ( isdefined( level.gamemodebundle.var_ea62e097837e641 ) )
    {
        self setsoundsubmix( level.gamemodebundle.var_ea62e097837e641 );
    }
    else
    {
        self setclienttriggeraudiozonepartial( "killcam", "mix" );
    }
    
    thread callback::callback( #"music_potg_killcam" );
    player::restorebasevisionset( 0 );
    self setclientomnvar( "post_game_state", 4 );
    self function_d2db513e6d31fe8( 1 );
    
    if ( !( isdefined( potginfo ) && isdefined( potginfo.spectateentity ) ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x319>", "<dev string:xf5>", "<dev string:x347>" + "<dev string:x370>" + self.name + "<dev string:x383>" + isdefined( potginfo ), undefined );
        #/
        
        logstring( "^5 END MATCH FLOW -- skipping POTG for player due to bad potgInfo" );
        potgkillcamover();
        return;
    }
    
    self setclientomnvar( "ui_killcam_killedby_operator_weapon_loot_id", weapon::getweaponlootid( potginfo.firstweapon ) );
    
    /#
        potg_killcam_debugprint( "<dev string:x396>", "<dev string:x1da>", "<dev string:x39d>" + "<dev string:x3b7>" + self.name + "<dev string:x3c6>" + ( isdefined( potginfo.firstweapon ) ? potginfo.firstweapon.basename : "<dev string:x2c9>" ) + "<dev string:x3d5>" + weapon::getweaponlootid( potginfo.firstweapon ), undefined );
    #/
    
    thread killcam::potg_killcam( potginfo.spectateentity, potginfo.psoffsettime, potginfo.starttime, potginfo.endtime, potginfo.var_f12d8ea92054e01e, potginfo.killcamentindex, potginfo.killcamentstarttime, potginfo.killcamlookatentityindex, potginfo.killcamentstickstolookatent, potginfo.firstweapon, potginfo.killtimes, potginfo.smeansofdeath );
    result = utility::waittill_any_return_no_endon_death( "begin_killcam", "killcam_ended" );
    
    if ( result == "killcam_ended" )
    {
        potgkillcamover();
        return;
    }
    
    thread game_utility_mp::setuipostgamefade( 1, self.killcamlength - 0.5 );
    self waittill( #"killcam_ended" );
    self clearclienttriggeraudiozone( 4 );
    
    if ( isdefined( level.gamemodebundle.var_ea62e097837e641 ) )
    {
        self clearsoundsubmix( level.gamemodebundle.var_ea62e097837e641 );
    }
    
    potgkillcamover();
}

// Namespace final_killcam
// Params 0
// Checksum 0xba41a22, Offset: 0x1a5e
// Size: 0x55
function potgkillcamover()
{
    if ( !isbrgamemode() || !utility::callsharedfunc( #"gametype", #"hash_e5435a50cbd76321" ) )
    {
        self setclientomnvar( "post_game_state", 1 );
        thread callback::callback( #"hash_46734d7f98d5f72a" );
    }
    
    self function_d2db513e6d31fe8( 0 );
    self.inpotgkillcam = 0;
}

// Namespace final_killcam
// Params 1
// Checksum 0x1ccb022f, Offset: 0x1abb
// Size: 0x1d3
function function_fbe534e93adf2542( potginfo )
{
    potgscene = potg::getcurpotgscene();
    
    if ( !isdefined( potgscene ) )
    {
        logstring( "^5[POTG] sendDlogEventOnPOTGKillcam -- potgScene is undefined, skipping dlog" );
        return;
    }
    
    archivestarttimems = getpotgstarttime();
    archiveendtimems = archivestarttimems + getpotgduration();
    playbackstarttime = potgscene.playbackstarttime ?? 0;
    playbackendtime = potgscene.playbackendtime ?? 0;
    var_a8c36f66c485273b = potg::function_b489dd728d45043e( potgscene.events );
    var_16ce39a3fe33e26c = [ "total_score", potgscene.score, "scene_start_time", playbackstarttime, "scene_end_time", playbackendtime, "archive_start_time", archivestarttimems, "archive_end_time", archiveendtimems, "initial_time_clamping", archivestarttimems - playbackstarttime, "end_time_clamping", playbackendtime - archiveendtimems ];
    
    if ( isplayer( potgscene.primaryentity ) )
    {
        potgscene.primaryentity dlog_recordplayerevent( "dlog_event_mp_potg_final", [ "final_potg_score_events", var_a8c36f66c485273b, "potg_info", var_16ce39a3fe33e26c, "final_kill_start_time", potginfo.var_df0519c0d8a13bbb ?? -1, "final_kill_end_time", potginfo.var_f12d8ea92054e01e ?? -1, "projectile_follow_start_time", potginfo.killcamentstarttime ?? -1, "projectile_follow_sticks_to_look_at_entity", istrue( potginfo.killcamentstickstolookatent ) ] );
    }
}

// Namespace final_killcam
// Params 0
// Checksum 0xa95502e1, Offset: 0x1c96
// Size: 0x3e2
function dofinalkillcam()
{
    if ( !level.finalkillcamenabled )
    {
        assert( 0, "<dev string:x3e4>" );
        logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - level.finalKillcamEnabled is false." );
        return 0;
    }
    
    if ( level.skipfinalkillcam )
    {
        logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - level.skipFinalKillcam is true." );
        return 0;
    }
    
    if ( level.nukeinfo.detonated )
    {
        logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - level.nukeInfo.detonated is true." );
        return 0;
    }
    
    level.showingfinalkillcam = 1;
    winner = level.finalkillcam_winner ?? "none";
    killcamstruct = level.finalkillcams[ winner ];
    
    if ( !isdefined( killcamstruct ) )
    {
        level.showingfinalkillcam = 0;
        logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - killcamStruct is undefined." );
        return 0;
    }
    
    attacker = killcamstruct.attacker;
    victim = killcamstruct.victim;
    
    if ( !( isdefined( victim ) && isdefined( attacker ) ) )
    {
        if ( !isdefined( victim ) )
        {
            logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - victim is undefined." );
        }
        else if ( !isdefined( attacker ) )
        {
            logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - attacker is undefined." );
        }
        
        level.showingfinalkillcam = 0;
        return 0;
    }
    
    var_43a8eace2412c566 = 20;
    killcamoffsettime = game_utility_mp::getsecondspassed() - killcamstruct.timerecorded;
    
    if ( killcamoffsettime > var_43a8eace2412c566 )
    {
        logstring( "^5 END MATCH FLOW -- doFinalKillcam() cancelled - killCamOffsetTime is longer than the buffer." );
        level.showingfinalkillcam = 0;
        return 0;
    }
    
    postdeathdelay = ( gettime() - victim.deathtime ) / 1000;
    setglobalsoundcontext( "atmosphere", "killcam", 0.1 );
    level.maxkillcamdelay = 0;
    
    foreach ( player in level.players )
    {
        player player::restorebasevisionset( 0 );
        player.killcamentitylookat = victim getentitynumber();
        player damage::updatedeathdetails( killcamstruct.attackers, killcamstruct.attackerdata, attacker );
        
        if ( !weapon::iskillstreakweapon( killcamstruct.objweapon.basename ) )
        {
            player killcam::setkillcamnormalweaponomnvars( killcamstruct.objweapon, killcamstruct.smeansofdeath, killcamstruct.einflictor, killcamstruct.executionref, killcamstruct.attacker );
        }
        
        player setclientomnvar( "post_game_state", 3 );
        player setclientomnvar( "ui_killcam_victim_or_attacker", 1 );
        
        if ( player iscodcaster() )
        {
            player setclientomnvar( "ui_killcam_killedby_health_ratio", killcamstruct.attackerhealthratio );
        }
        
        player playlocalsound( "final_killcam_in" );
        
        if ( isdefined( level.gamemodebundle.var_ea62e097837e641 ) )
        {
            player setsoundsubmix( level.gamemodebundle.var_ea62e097837e641 );
        }
        else
        {
            player setclienttriggeraudiozonepartial( "killcam", "mix" );
        }
        
        bundle = level.gametypebundle;
        
        if ( bundle.var_814ae59a5bcf401 )
        {
            player thread killcam::function_4ee45dfd828c326a();
        }
        
        if ( level.var_90b47db0527eb6c5 )
        {
            player thread killcam::dokillcamfromstruct( killcamstruct, postdeathdelay, 0, 0, player );
            player notify( #"showing_final_br_killcam" );
            continue;
        }
        
        player thread killcam::dokillcamfromstruct( killcamstruct, postdeathdelay, 0, 1 );
    }
    
    wait 0.15 + level.maxkillcamdelay;
    level thread waitanyplayersinkillcam();
    level utility::waittill_notify_or_timeout( "waitAnyPlayersInKillcam", 15 );
    level notify( #"hash_4d2c0aae10a3a7e" );
    level.showingfinalkillcam = 0;
}

// Namespace final_killcam
// Params 0
// Checksum 0x39294ebd, Offset: 0x2080
// Size: 0x27
function waitanyplayersinkillcam()
{
    level endon( #"hash_4d2c0aae10a3a7e" );
    
    while ( anyplayersinkillcam() )
    {
        waitframe();
    }
    
    level notify( #"waitAnyPlayersInKillcam" );
}

// Namespace final_killcam
// Params 0
// Checksum 0xcb3f5aeb, Offset: 0x20af
// Size: 0x67
function finalkillcamplaybackbegin()
{
    self notify( #"showing_final_killcam" );
    
    if ( level.gametypebundle.var_c6dba97e65cd67ce )
    {
        level thread game_utility::fadetoblackforplayer( self, 0, 0.25 );
    }
    
    thread game_utility_mp::setuipostgamefade( 0 );
    thread game_utility_mp::setuipostgamefade( 1, self.killcamlength - 0.5 );
    self setclientomnvar( "post_game_state", 3 );
    thread watchplaybackend();
}

// Namespace final_killcam
// Params 0
// Checksum 0x6b40e73f, Offset: 0x211e
// Size: 0x88
function watchplaybackend()
{
    self endon( #"killcam_canceled" );
    self waittill( #"killcam_ended" );
    setglobalsoundcontext( "atmosphere", "", 0.5 );
    
    if ( game_utility::getgametype() != "arena" )
    {
        self playlocalsound( "final_killcam_out" );
    }
    
    self clearclienttriggeraudiozone( 4 );
    
    if ( isdefined( level.gamemodebundle.var_ea62e097837e641 ) )
    {
        self clearsoundsubmix( level.gamemodebundle.var_ea62e097837e641 );
    }
    
    thread playerlogic::spawnendofgame();
}

// Namespace final_killcam
// Params 12
// Checksum 0xac407292, Offset: 0x21ae
// Size: 0x304
function recordfinalkillcam( delay, victim, attacker, attackernum, einflictor, killcamentityindex, killcamentitystarttime, var_3e6da21c70e12522, objweapon, psoffsettime, smeansofdeath, var_c9f36c9b6da231a2 )
{
    if ( level.skipfinalkillcam )
    {
        if ( getdvarint( @"scr_debug_final_killcam", 1 ) )
        {
            logstring( "[FINAL KILLCAM DEBUG] [" + ( victim ? victim.name : "undefined" ) + "] " + "recordFinalKillCam - skip final killcam - level.skipFinalKillcam=" + level.skipfinalkillcam );
        }
        
        return;
    }
    
    inflictoragentinfo = spawnstruct();
    
    if ( isagent( einflictor ) )
    {
        inflictoragentinfo.agent_type = einflictor.agent_type;
        inflictoragentinfo.lastspawntime = einflictor.lastspawntime;
        
        if ( !isdefined( inflictoragentinfo.lastspawntime ) )
        {
            inflictoragentinfo.lastspawntime = einflictor.spawntime;
        }
        
        assert( isdefined( inflictoragentinfo.lastspawntime ), "<dev string:x411>" );
    }
    
    perkarray = [];
    
    foreach ( perk in attacker.pers[ "loadoutPerks" ] ?? [] )
    {
        perkarray[ perkarray.size ] = perk;
    }
    
    killcamstruct = killcam::makekillcamdata( einflictor, inflictoragentinfo, attackernum, killcamentityindex, killcamentitystarttime, victim getentitynumber(), var_3e6da21c70e12522, objweapon, psoffsettime, 12, attacker, victim, smeansofdeath, perkarray, 0, 1, var_c9f36c9b6da231a2 );
    killcamstruct.timerecorded = game_utility_mp::getsecondspassed();
    
    if ( smeansofdeath == "MOD_EXECUTION" || smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        killcamstruct.timerecorded -= 3;
        killcamstruct.timerecorded = max( 0, killcamstruct.timerecorded );
    }
    
    killcamstruct.attackers = victim.attackers;
    killcamstruct.attackerdata = victim.attackerdata;
    
    if ( level.teambased && isdefined( attacker.team ) )
    {
        level.finalkillcams[ attacker.team ] = killcamstruct;
    }
    else if ( !level.teambased )
    {
        level.finalkillcams[ attacker.guid ] = killcamstruct;
    }
    
    level.finalkillcams[ "none" ] = killcamstruct;
}

// Namespace final_killcam
// Params 0
// Checksum 0x7082132b, Offset: 0x24ba
// Size: 0x53
function waitskipkillcambuttonduringdeathtimer()
{
    self endon( #"disconnect" );
    self endon( #"killcam_death_done_waiting" );
    self notifyonplayercommand( "death_respawn", "+usereload" );
    self notifyonplayercommand( "death_respawn", "+activate" );
    self waittill( #"death_respawn" );
    self notify( #"killcam_death_button_cancel" );
}

// Namespace final_killcam
// Params 0
// Checksum 0x9cfed475, Offset: 0x2515
// Size: 0x53
function function_76371c7287902c5f()
{
    self endon( #"disconnect" );
    self endon( #"killcam_death_done_waiting" );
    self notifyonplayercommand( "death_respawn_no_spawn_point", "+movedown" );
    self notifyonplayercommand( "death_respawn_no_spawn_point", "+stance" );
    self waittill( #"death_respawn_no_spawn_point" );
    self notify( #"killcam_death_button_cancel_no_spawn_point" );
}

// Namespace final_killcam
// Params 1
// Checksum 0xa6b5080e, Offset: 0x2570
// Size: 0x33
function waitskipkillcamduringdeathtimer( waittime )
{
    self endon( #"disconnect" );
    self endon( #"killcam_death_button_cancel" );
    wait waittime;
    self notify( #"killcam_death_done_waiting" );
}

// Namespace final_killcam
// Params 0
// Checksum 0x637cb357, Offset: 0x25ab
// Size: 0xb2
function function_eedaaca673d4ab81()
{
    self endon( #"disconnect" );
    self endon( #"killcam_death_done_waiting" );
    hold_timer = 0;
    frame_duration_ms = level.framedurationseconds * 1000;
    self setclientomnvar( "ui_exit_progress", 0 );
    
    while ( true )
    {
        if ( self usebuttonpressed() )
        {
            hold_timer += frame_duration_ms;
            self setclientomnvar( "ui_exit_progress", hold_timer / 250 );
        }
        else if ( hold_timer > 0 )
        {
            hold_timer -= frame_duration_ms;
            
            if ( hold_timer < 0 )
            {
                hold_timer = 0;
            }
            
            self setclientomnvar( "ui_exit_progress", hold_timer / 250 );
        }
        
        if ( hold_timer >= 250 )
        {
            self notify( #"killcam_death_hold_to_show" );
            break;
        }
        
        waitframe();
    }
}

// Namespace final_killcam
// Params 3
// Checksum 0x403a297, Offset: 0x2665
// Size: 0x2f2
function function_42a11fbfb54cbf4c( waittime, deathcamtime, isautoskipkillcam )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self.skippedkillcam = 0;
    self.skippedspawnpoint = 0;
    
    if ( level.showingfinalkillcam )
    {
        return;
    }
    
    if ( !isai( self ) )
    {
        self.skippedkillcam = isautoskipkillcam;
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "handleSkipKillcamInputDuringDeathTimer - self.skippedKillcam=" + self.skippedkillcam );
        }
        
        thread waitskipkillcamduringdeathtimer( deathcamtime );
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
        
        if ( isautoskipkillcam )
        {
            thread function_eedaaca673d4ab81();
            
            if ( isdefined( self.setspawnpoint ) && utility::callsharedfunc( #"hash_ddfd165eca1acbee", #"hash_34e67067fbad9026" ) )
            {
                thread function_76371c7287902c5f();
            }
        }
        else
        {
            thread waitskipkillcambuttonduringdeathtimer();
        }
        
        result = utility::waittill_any_return( "killcam_death_done_waiting", "killcam_death_button_cancel", "killcam_death_button_cancel_no_spawn_point", "killcam_death_hold_to_show" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !isdefined( result ) )
        {
            if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
            {
                logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "handleSkipKillcamInputDuringDeathTimer - result=undefined" );
            }
            
            return;
        }
        
        if ( result == "killcam_death_button_cancel_no_spawn_point" )
        {
            self.skippedspawnpoint = 1;
        }
        
        self.skippedkillcam = result == "killcam_death_button_cancel" || result == "killcam_death_button_cancel_no_spawn_point" || isautoskipkillcam && result != "killcam_death_hold_to_show";
        
        if ( getdvarint( @"hash_ab82f2876dcac200", 0 ) )
        {
            logstring( "[KILLCAM DEBUG] [" + ( self ? self.name : "undefined" ) + "] " + "handleSkipKillcamInputDuringDeathTimer - self.skippedKillcam=" + self.skippedkillcam + ", result=" + result );
        }
        
        if ( !isautoskipkillcam && self.skippedkillcam )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "skippedKillcams" ] ) )
                {
                    self.leaderboarddata[ "skippedKillcams" ] = self.leaderboarddata[ "skippedKillcams" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "skippedKillcams" ] ) )
                {
                    [[ level.leaderboardfunc[ "skippedKillcams" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x439>" );
                
                if ( isdefined( self.pers[ "skippedKillcams" ] ) )
                {
                    self.pers[ "skippedKillcams" ] = self.pers[ "skippedKillcams" ] + 1;
                }
            }
        }
    }
}

// Namespace final_killcam
// Params 0
// Checksum 0x88602fac, Offset: 0x295f
// Size: 0x85, Type: bool
function anyplayersinkillcam()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.killcam ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace final_killcam
// Params 1
// Checksum 0x7592b299, Offset: 0x29ed
// Size: 0xa7
function pbg_start( notifynote )
{
    bundleasset = getxhashasset( level.var_52bbdef5c6f301dd[ "_player" ][ "_intro" ] );
    
    foreach ( spectator in level.players )
    {
        pbgpostfxbundlestart( spectator, bundleasset );
    }
}

// Namespace final_killcam
// Params 1
// Checksum 0x37a2bb8e, Offset: 0x2a9c
// Size: 0x20
function timescale_start( notifynote )
{
    setslowmotion( 1, 0.5, 0.25 );
}

// Namespace final_killcam
// Params 1
// Checksum 0xaface3e, Offset: 0x2ac4
// Size: 0x1d
function timescale_stop( notifynote )
{
    setslowmotion( 0.5, 1, 0.25 );
}

// Namespace final_killcam
// Params 1
// Checksum 0xafdfbb73, Offset: 0x2ae9
// Size: 0x20
function timescale_heavy_start( notifynote )
{
    setslowmotion( 1, 0.25, 0.25 );
}

// Namespace final_killcam
// Params 1
// Checksum 0xff2b893d, Offset: 0x2b11
// Size: 0x1d
function timescale_heavy_stop( notifynote )
{
    setslowmotion( 0.25, 1, 0.25 );
}

#using_animtree( "script_model" );

// Namespace final_killcam
// Params 1
// Checksum 0x54e64967, Offset: 0x2b36
// Size: 0x590
function function_d1d4b99181888b73( seqtype )
{
    if ( level.var_d1d4b99181888b73 && !getdvarint( @"hash_a8d6f0b654204b81", 0 ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x45f>", "<dev string:x1da>", "<dev string:x466>" + "<dev string:x48d>" + seqtype, undefined );
        #/
        
        return;
    }
    
    /#
        potg_killcam_debugprint( "<dev string:x45f>", "<dev string:x1da>", "<dev string:x498>" + "<dev string:x48d>" + seqtype, undefined );
    #/
    
    activateworldevent( "POTG_light_on" );
    level.scr_animtree[ "_player" ] = #animtree;
    level.scr_eventname[ "_player" ][ "_intro" ] = "anim_et_potg_begin";
    
    switch ( seqtype )
    {
        case #"hash_fa18d2f6bd57925a":
            scene_type = "_ar";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_ar_intro_player;
            level.scr_animtree[ "_actor_01" ] = #animtree;
            level.scr_anim[ "_actor_01" ][ "_intro" ] = %mp_rex_scene_potg_ar_intro_ally;
            break;
        case #"hash_9de6871a978222ba":
            scene_type = "_knife";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_knife_intro_player;
            level.scr_animtree[ "_actor_01" ] = #animtree;
            level.scr_anim[ "_actor_01" ][ "_intro" ] = %mp_rex_scene_potg_knife_intro_actor_01;
            level.scr_animtree[ "_actor_02" ] = #animtree;
            level.scr_anim[ "_actor_02" ][ "_intro" ] = %mp_rex_scene_potg_knife_intro_actor_02;
            break;
        case #"hash_2f2d546c2247838f":
            scene_type = "_lmg";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_lmg_intro_player;
            level.scr_animtree[ "_actor_01" ] = #animtree;
            level.scr_anim[ "_actor_01" ][ "_intro" ] = %mp_rex_scene_potg_lmg_intro_ally_01;
            level.scr_animtree[ "_actor_02" ] = #animtree;
            level.scr_anim[ "_actor_02" ][ "_intro" ] = %mp_rex_scene_potg_lmg_intro_ally_02;
            level.scr_animtree[ "_actor_03" ] = #animtree;
            level.scr_anim[ "_actor_03" ][ "_intro" ] = %mp_rex_scene_potg_lmg_intro_ally_03;
            break;
        case #"hash_719417cb1de832b6":
            scene_type = "_pistol";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_pistol_intro_player;
            level.scr_animtree[ "_actor_01" ] = #animtree;
            level.scr_anim[ "_actor_01" ][ "_intro" ] = %mp_rex_scene_potg_pistol_intro_actor_01;
            level.scr_animtree[ "_actor_02" ] = #animtree;
            level.scr_anim[ "_actor_02" ][ "_intro" ] = %mp_rex_scene_potg_pistol_intro_actor_02;
            break;
        case #"hash_23209741b93850b5":
            scene_type = "_shotgun";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_shotgun_intro_player;
            break;
        case #"hash_900cb96c552c5e8e":
            scene_type = "_smg";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_smg_intro_player;
            level.scr_animtree[ "_actor_01" ] = #animtree;
            level.scr_anim[ "_actor_01" ][ "_intro" ] = %mp_rex_scene_potg_smg_intro_ally;
            break;
        case #"hash_6191aaef9f922f96":
            scene_type = "_sniper";
            level.scr_anim[ "_player" ][ "_intro" ] = %mp_rex_scene_potg_sniper_intro_player;
            break;
        default:
            /#
                potg_killcam_debugprint( "<dev string:x45f>", "<dev string:xf5>", "<dev string:x4b7>" + "<dev string:x48d>" + seqtype, undefined );
            #/
            
            return;
    }
    
    shot_name = "mp_rex_scene_potg" + scene_type + "_intro" + "_player";
    level.scr_eventanim[ "_player" ][ "_intro" ] = getxhashasset( shot_name );
    level.scr_xcam[ "_player" ][ "_intro" ] = "mp_rex_scene_potg" + scene_type + "_intro";
    level.var_52bbdef5c6f301dd[ "_player" ][ "_intro" ] = "mp_rex_scene_potg" + scene_type + "_pulse";
    
    /#
        potg_killcam_debugprint( "<dev string:x45f>", "<dev string:x1da>", "<dev string:x4f8>" + "<dev string:x514>" + seqtype + "<dev string:x522>" + scene_type + "<dev string:x530>" + shot_name + "<dev string:x53e>" + level.scr_xcam[ "<dev string:x54c>" ][ "<dev string:x554>" ], undefined );
    #/
    
    if ( !isdefined( level.var_d1d4b99181888b73 ) || getdvarint( @"hash_a8d6f0b654204b81", 0 ) )
    {
        animation::addnotetrack_customfunction( "_player", "timescale_start", &timescale_start );
        animation::addnotetrack_customfunction( "_player", "timescale_stop", &timescale_stop );
        animation::addnotetrack_customfunction( "_player", "timescale_heavy_start", &timescale_heavy_start );
        animation::addnotetrack_customfunction( "_player", "timescale_heavy_stop", &timescale_heavy_stop );
        animation::addnotetrack_customfunction( "_player", "pbg_start", &pbg_start );
    }
    
    self.shot_name = shot_name;
    level.var_d1d4b99181888b73 = 1;
}

// Namespace final_killcam
// Params 1
// Checksum 0xd69789c3, Offset: 0x30ce
// Size: 0x9d
function function_4fdbde962ed80391( potginfo )
{
    if ( !isdefined( potginfo ) || !isdefined( potginfo.spectateentity ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x55b>", "<dev string:xf5>", "<dev string:x561>", undefined );
        #/
        
        return;
    }
    
    player = potginfo.spectateentity;
    firstweapon = potginfo.firstweapon;
    scene_type = potg::getweapontype( firstweapon );
    weaponlootid = weapon::getweaponlootid( firstweapon );
    setupPOTGIntroSceneInternal( player, scene_type, firstweapon, weaponlootid, undefined );
}

// Namespace final_killcam
// Params 4
// Checksum 0xae6abf4c, Offset: 0x3173
// Size: 0x63
function function_28956980289101e5( potgplayer, firstweapon, showdebug, sceneindex = undefined )
{
    scene_type = potg::getweapontype( firstweapon );
    weaponlootid = weapon::getweaponlootid( firstweapon );
    setupPOTGIntroSceneInternal( potgplayer, scene_type, firstweapon, weaponlootid, sceneindex );
}

// Namespace final_killcam
// Params 5, eflags: 0x4
// Checksum 0xcf85e015, Offset: 0x31de
// Size: 0x355
function private setupPOTGIntroSceneInternal( player, scene_type, firstweapon, weaponlootid, sceneindex )
{
    var_d2d8d5a07568050 = getdvarfloat( @"r_volumetricdepth", 1 );
    
    foreach ( spectator in level.players )
    {
        spectator function_a565dafac620d68e( %"hash_6aa3f7540f3010f5" );
    }
    
    if ( !isdefined( level.var_ab0c75d6829ff0b6 ) || getdvarint( @"hash_a8d6f0b654204b81", 0 ) )
    {
        if ( !isdefined( sceneindex ) )
        {
            scene_node = potg::function_55bc1ddd313f9156( undefined, scene_type );
        }
        else
        {
            scene_node = potg::function_55bc1ddd313f9156( undefined, scene_type, sceneindex );
        }
        
        /#
            potg_killcam_debugprint( "<dev string:x55b>", "<dev string:x1da>", "<dev string:x5a5>" + "<dev string:x5c1>" + ( isdefined( firstweapon ) ? firstweapon.basename : "<dev string:x2c9>" ) + "<dev string:x5d6>" + scene_type + "<dev string:x5eb>" + sceneindex + "<dev string:x600>" + isdefined( scene_node ), undefined );
        #/
        
        if ( !isdefined( scene_node ) )
        {
            /#
                potg_killcam_debugprint( "<dev string:x55b>", "<dev string:xf5>", "<dev string:x615>" + "<dev string:x522>" + scene_type + "<dev string:x642>" + player.name, undefined );
            #/
            
            return;
        }
        
        function_d1d4b99181888b73( scene_type );
        scene = spawn( "script_origin", scene_node.origin );
        scene.angles = scene_node.angles ?? ( 0, 0, 0 );
        scene.targetname = "setupPOTGIntroSceneInternal";
        scene.scene_node = scene_node;
        level.var_ab0c75d6829ff0b6 = scene;
    }
    
    /#
        potg_killcam_debugprint( "<dev string:x650>", "<dev string:x1da>", "<dev string:x65d>" + "<dev string:x677>" + ( isdefined( player ) ? player.name : "<dev string:x2c9>" ) + "<dev string:x5c1>" + ( isdefined( firstweapon ) ? firstweapon.basename : "<dev string:x2c9>" ) + "<dev string:x5d6>" + scene_type + "<dev string:x68c>" + weaponlootid + "<dev string:x600>" + isdefined( level.var_ab0c75d6829ff0b6.scene_node ), undefined );
    #/
    
    level.var_ab0c75d6829ff0b6 scenethink( player, scene_type, firstweapon, weaponlootid );
    
    foreach ( spectator in level.players )
    {
        spectator function_72cf2eee8e035013( %"hash_6aa3f7540f3010f5" );
    }
    
    setdvar( @"r_volumetricdepth", var_d2d8d5a07568050 );
    setomnvar( "ui_potg_intro_stage", 0 );
    level.var_ab0c75d6829ff0b6 = undefined;
}

// Namespace final_killcam
// Params 4
// Checksum 0x1536f7e3, Offset: 0x353b
// Size: 0x50a
function scenethink( potgplayer, scene_type, firstweapon, weaponlootid )
{
    waitframe();
    
    /#
        potg_killcam_debugprint( "<dev string:x6a1>", "<dev string:x1da>", "<dev string:x6a7>" + "<dev string:x6b8>" + potgplayer.name + "<dev string:x6c8>" + scene_type + "<dev string:x6d8>" + ( isdefined( firstweapon ) ? firstweapon.basename : "<dev string:x2c9>" ) + "<dev string:x6e8>" + weaponlootid, undefined );
    #/
    
    scene_node = self.scene_node;
    scene_origin = scene_node.origin;
    self.linktoent = spawn( "script_model", scene_origin );
    self.linktoent setmodel( "tag_origin" );
    self.linktoent.angles = scene_node.angles ?? ( 0, 0, 0 );
    xcament = spawn( "script_model", scene_origin );
    xcament setmodel( "tag_origin" );
    xcament.angles = scene_node.angles ?? ( 0, 0, 0 );
    level.scr_actors = [];
    function_c1229944d00cc563( scene_type );
    level thread function_e78ebc6876e1f416();
    
    if ( !isdefined( level.scr_anim[ "_player" ][ "_intro" ] ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x6a1>", "<dev string:xf5>", "<dev string:x6f8>" + "<dev string:x522>" + scene_type, undefined );
        #/
        
        self.linktoent delete();
        xcament delete();
        return;
    }
    
    animlength = getanimlength( level.scr_anim[ "_player" ][ "_intro" ] );
    level thread function_557ef6e53bd36b6a( animlength );
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            if ( player getspectatingplayer() )
            {
                continue;
            }
        }
        
        player setorigin( scene_node.origin );
        
        if ( player != potgplayer )
        {
            player playerhide();
        }
        
        outofbounds::enableoobimmunity( player );
        player setclientomnvar( "ui_killcam_killedby_id", potgplayer getentitynumber() );
        player setclientomnvar( "ui_killcam_killedby_operator_skin_loot_id", potgplayer.operatorcustomization.skinlootid );
        player setclientomnvar( "ui_killcam_killedby_operator_weapon_loot_id", weaponlootid );
        
        /#
            potg_killcam_debugprint( "<dev string:x396>", "<dev string:x1da>", "<dev string:x720>" + "<dev string:x749>" + player.name + "<dev string:x6e8>" + weaponlootid, undefined );
        #/
        
        player playlocalsound( "uin_potg_intro" );
        player playxcamontag( level.scr_xcam[ "_player" ][ "_intro" ], 0, xcament, "tag_origin", undefined, undefined, 0 );
    }
    
    foreach ( actor in level.scr_actors )
    {
        self.linktoent thread animation::anim_single_solo( actor, "_intro" );
    }
    
    potgplayer thread infilexfil::infil_player_rig_updated( "_player", scene_node.origin, scene_node.angles );
    var_b905e63569e53669 = 0;
    
    while ( !isdefined( potgplayer.player_rig ) && var_b905e63569e53669 < 100 )
    {
        waitframe();
        var_b905e63569e53669 += level.framedurationseconds * 1000;
    }
    
    if ( !isdefined( potgplayer.player_rig ) )
    {
        /#
            potg_killcam_debugprint( "<dev string:x6a1>", "<dev string:x9c>", "<dev string:x759>" + "<dev string:x79c>" + potgplayer.name, undefined );
        #/
    }
    else
    {
        potg_killcam_debugprint( "SCENE", "^5", "starting potgPlayer anim_player_solo" + "  potgPlayer      =" + potgplayer.name + "  scene_type      =" + scene_type + "  shot            =" + "_intro" + "  selectedShotName=" + self.shot_name + "  rigWaitMs=" + var_b905e63569e53669, undefined );
        self.linktoent anim_mp::anim_player_solo( potgplayer, potgplayer.player_rig, "_intro", "tag_origin" );
    }
    
    setslowmotion( 1, 1, 0 );
    potgplayer notify( #"remove_rig" );
    self.linktoent delete();
    xcament delete();
}

// Namespace final_killcam
// Params 1
// Checksum 0x4e6d3d67, Offset: 0x3a4d
// Size: 0x9e
function function_557ef6e53bd36b6a( duration )
{
    fadetime = 0.25;
    wait duration - fadetime;
    
    foreach ( player in level.players )
    {
        player thread game_utility::fadetoblackforplayer( player, 1, fadetime );
    }
}

// Namespace final_killcam
// Params 1
// Checksum 0x3529005, Offset: 0x3af3
// Size: 0x26b
function function_c1229944d00cc563( scene_type )
{
    if ( isdefined( scene_type ) )
    {
        switch ( scene_type )
        {
            case #"hash_fa18d2f6bd57925a":
                level.scr_actors[ 0 ] = self.linktoent spawn_anim_model( "_actor_01", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                break;
            case #"hash_9de6871a978222ba":
                level.scr_actors[ 0 ] = self.linktoent spawn_anim_model( "_actor_01", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                level.scr_actors[ 1 ] = self.linktoent spawn_anim_model( "_actor_02", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                break;
            case #"hash_2f2d546c2247838f":
                level.scr_actors[ 0 ] = self.linktoent spawn_anim_model( "_actor_01", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                level.scr_actors[ 1 ] = self.linktoent spawn_anim_model( "_actor_02", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                level.scr_actors[ 2 ] = self.linktoent spawn_anim_model( "_actor_03", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                break;
            case #"hash_719417cb1de832b6":
                level.scr_actors[ 0 ] = self.linktoent spawn_anim_model( "_actor_01", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                level.scr_actors[ 1 ] = self.linktoent spawn_anim_model( "_actor_02", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                break;
            case #"hash_23209741b93850b5":
                break;
            case #"hash_900cb96c552c5e8e":
                level.scr_actors[ 0 ] = self.linktoent spawn_anim_model( "_actor_01", "tag_origin", "fullbody_usmc_ar", undefined, "wpn_rex_wm_ar_mike4" );
                break;
            case #"hash_6191aaef9f922f96":
                break;
            default:
                /#
                    potg_killcam_debugprint( "<dev string:x6a1>", "<dev string:xf5>", "<dev string:x7aa>" + "<dev string:x522>" + scene_type, undefined );
                #/
                
                break;
        }
    }
}

// Namespace final_killcam
// Params 5
// Checksum 0x556942bd, Offset: 0x3d66
// Size: 0x1cd
function spawn_anim_model( animname, linkto_ent, body, head, weapon )
{
    if ( body == "random" )
    {
        index = randomint( 3 );
        
        if ( index == 0 )
        {
            body = "fullbody_usmc_ar";
        }
        else if ( index == 1 )
        {
            body = "body_opforce_london_civ_1_1";
        }
        else if ( index == 2 )
        {
            body = "civ_london_male_2_5";
        }
    }
    
    actor = spawn( "script_model", ( 0, 0, 0 ) );
    actor setmodel( body );
    
    if ( isdefined( head ) )
    {
        actor_head = spawn( "script_model", ( 0, 0, 0 ) );
        actor_head setmodel( head );
        actor_head linkto( actor, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        actor.head = actor_head;
        actor thread utility::delete_on_death( actor_head );
    }
    
    if ( isdefined( weapon ) )
    {
        actor_weapon = spawn( "script_model", ( 0, 0, 0 ) );
        actor_weapon setmodel( weapon );
        actor_weapon linkto( actor, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        actor thread utility::delete_on_death( actor_weapon );
        actor.weapon = actor_weapon;
    }
    
    actor.animname = animname;
    actor animation::setanimtree();
    
    if ( isdefined( linkto_ent ) )
    {
        thread utility::delete_on_death( actor );
        actor linkto( self, linkto_ent, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    return actor;
}

// Namespace final_killcam
// Params 0
// Checksum 0xbe4b5a4, Offset: 0x3f3c
// Size: 0x2c
function function_e78ebc6876e1f416()
{
    setomnvarforallclients( "post_game_state", 19 );
    setomnvar( "ui_potg_intro_stage", 1 );
    wait 0.1;
    setomnvar( "ui_potg_intro_stage", 2 );
}

// Namespace final_killcam
// Params 1
// Checksum 0x6960c9d8, Offset: 0x3f70
// Size: 0x29
function function_bfe1d46eb1d3f070( potginfo )
{
    equip_swap_weapon( potginfo.spectateentity, potginfo.firstweapon );
}

// Namespace final_killcam
// Params 2
// Checksum 0x3b1638bc, Offset: 0x3fa1
// Size: 0x13b
function equip_swap_weapon( potgplayer, weaponobj )
{
    /#
        potg_killcam_debugprint( "<dev string:x396>", "<dev string:x1da>", "<dev string:x7e9>" + "<dev string:x801>" + potgplayer.name + "<dev string:x812>" + ( isdefined( weaponobj ) ? weaponobj.basename : "<dev string:x2c9>" ) + "<dev string:x823>" + ( isdefined( potgplayer.currentweapon ) ? potgplayer.currentweapon.basename : "<dev string:x2c9>" ), undefined );
    #/
    
    if ( isdefined( potgplayer ) && isdefined( weaponobj ) )
    {
        if ( potgplayer.currentweapon != weaponobj )
        {
            if ( potgplayer hasweapon( weaponobj ) )
            {
                potgplayer inventory_utility::domonitoredweaponswitch( weaponobj, 1, 1, 1 );
            }
            else
            {
                potgplayer inventory_utility::_giveweapon( weaponobj, undefined, undefined, 1 );
                potgplayer inventory_utility::domonitoredweaponswitch( weaponobj, 1, 1, 1 );
            }
            
            weapon::fixupplayerweapons( potgplayer, weaponobj );
        }
        
        /#
            if ( getdvarint( @"hash_a8d6f0b654204b81", 0 ) )
            {
                maxammo = weaponmaxammo( weaponobj );
                potgplayer setweaponammoclip( weaponobj, maxammo );
            }
        #/
        
        if ( isbot( potgplayer ) )
        {
            potgplayer botsetflag( "ignore_script_weapon", 0 );
        }
    }
}

/#

    // Namespace final_killcam
    // Params 0
    // Checksum 0x908d6a63, Offset: 0x40e4
    // Size: 0x1e3, Type: dev
    function function_ed78e7dbba9ceb4()
    {
        while ( true )
        {
            waitframe();
            var_7db748a274897590 = getdvarint( @"hash_9b6a4e59cbc55f70", 0 );
            
            if ( !level.showingfinalkillcam && ( getdvarint( @"potg", 0 ) == 1 || var_7db748a274897590 ) )
            {
                setdvar( @"potg_all", 0 );
                setdvar( @"potg", 0 );
                setdvar( @"hash_a8d6f0b654204b81", 1 );
                level function_bf43b24418221d35( var_7db748a274897590 );
                
                foreach ( player in level.players )
                {
                    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
                }
                
                setdvar( @"hash_a8d6f0b654204b81", 0 );
            }
            
            if ( !level.showingfinalkillcam && getdvarint( @"hash_91ea920a88eca93a", 0 ) == 1 )
            {
                setdvar( @"hash_91ea920a88eca93a", 0 );
                setdvar( @"hash_a8d6f0b654204b81", 1 );
                level function_b86cb71f27b91f74();
                
                foreach ( player in level.players )
                {
                    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
                }
                
                setdvar( @"hash_a8d6f0b654204b81", 0 );
            }
        }
    }

    // Namespace final_killcam
    // Params 1, eflags: 0x4
    // Checksum 0x99629cee, Offset: 0x42cf
    // Size: 0x10d, Type: dev
    function private function_bf43b24418221d35( var_7db748a274897590 )
    {
        potgplayer = gamelogic_mp::gethostplayer( 1 );
        firstweapon = potg::function_296c5de29e610d83( potgplayer, potgplayer.currentweapon );
        equip_swap_weapon( potgplayer, firstweapon );
        firstweapon = potgplayer.currentweapon;
        var_8a5595cb6e53a5be = potg::getweapontype( firstweapon );
        
        /#
            potg_killcam_debugprint( "<dev string:x834>", "<dev string:x1da>", "<dev string:x839>" + "<dev string:x3b7>" + potgplayer.name + "<dev string:x3c6>" + ( isdefined( firstweapon ) ? firstweapon.basename : "<dev string:x2c9>" ) + "<dev string:x858>" + var_8a5595cb6e53a5be, undefined );
        #/
        
        if ( var_7db748a274897590 == 1 )
        {
            numscenes = potg::function_f3e3504d21033a7( var_8a5595cb6e53a5be );
            
            for ( sceneindex = 0; sceneindex < numscenes ; sceneindex++ )
            {
                level function_28956980289101e5( potgplayer, firstweapon, 0, sceneindex );
            }
            
            return;
        }
        
        level function_28956980289101e5( potgplayer, firstweapon, 0 );
    }

    // Namespace final_killcam
    // Params 0, eflags: 0x4
    // Checksum 0x40ae5193, Offset: 0x43e4
    // Size: 0xcc, Type: dev
    function private function_b86cb71f27b91f74()
    {
        potginfo = potg::getfinalpotginfo();
        
        if ( !isdefined( potginfo ) )
        {
            /#
                potg_killcam_debugprint( "<dev string:x834>", "<dev string:x9c>", "<dev string:x867>", undefined );
            #/
            
            return;
        }
        
        /#
            potg_killcam_debugprint( "<dev string:x834>", "<dev string:x1da>", "<dev string:x8ab>" + "<dev string:x3b7>" + ( isdefined( potginfo.spectateentity ) ? potginfo.spectateentity.name : "<dev string:x2c9>" ) + "<dev string:x3c6>" + ( isdefined( potginfo.firstweapon ) ? potginfo.firstweapon.basename : "<dev string:x2c9>" ), undefined );
        #/
        
        function_bfe1d46eb1d3f070( potginfo );
        level function_4fdbde962ed80391( potginfo );
    }

#/
