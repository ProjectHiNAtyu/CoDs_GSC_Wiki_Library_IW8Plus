// scripts\mp\common\killstreaks\proxyagent.gsc  (hash_530448a1c2a55f03.gscc) (size: 2825 Bytes / 0xb09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9ed7c72 (3387784306)
// size ...... 2825 (0xb09)
// includes .. 9   (offset: 0xa85)
// strings ... 4   (offset: 0xacd)
// dev strs .. 1   (offset: 0xafd)
// exports ... 15  (offset: 0x585)
// cseg ...... 0xa9 + 0x4dc (0x585)
// imports ... 24  (offset: 0x7dd)
// animtree1 . 0   (offset: 0xb09)
// animtree2 . 0   (offset: 0xb09)
#using scripts\common\utility;
#using scripts\mp\archetypes\archassault;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_util;

#namespace proxyagent;

// Namespace proxyagent
// Params 6
// Checksum 0xec939740, Offset: 0xc7
// Size: 0xc7, Type: bool
function controlproxyagent( agent, streakinfo, endnotifymsg, playerkillstreaktimeout, var_540f150f459d248d, visionset )
{
    self.proxydisableweapon = undefined;
    
    if ( playerkillstreaktimeout < 3 )
    {
        return false;
    }
    
    result = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo );
    
    if ( !result )
    {
        return false;
    }
    
    thread watchplayerkillstreakend( endnotifymsg );
    thread watchgameend();
    
    if ( !var_540f150f459d248d )
    {
        thread watchplayerkillstreakearlyexit( endnotifymsg );
    }
    
    if ( isalive( agent ) && !agent.dying )
    {
        startcontrol( agent, streakinfo.streakname, endnotifymsg, visionset );
    }
    else
    {
        self notify( endnotifymsg );
        return false;
    }
    
    return true;
}

// Namespace proxyagent
// Params 2
// Checksum 0xd271a226, Offset: 0x197
// Size: 0xf5
function watchplayerkillstreakdeath( endnotifymsg, streakname )
{
    self endon( #"disconnect" );
    self endon( endnotifymsg );
    
    while ( true )
    {
        self waittill( #"player_killstreak_death", einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon );
        
        if ( eattacker != self && isplayer( eattacker ) )
        {
            eattacker thread points::doscoreevent( hashcat( #"destroyed_", streakname ) );
            thread hud_util::teamplayercardsplash( "callout_destroyed_" + streakname, eattacker );
            objweapon = makeweaponfromstring( sweapon );
            thread challenges::killstreakkilled( self, streakname, self, eattacker, idamage, smeansofdeath, objweapon );
            thread dialog::leaderdialogonplayer( streakname + "_destroyed", undefined, undefined, self.origin );
        }
        
        self notify( endnotifymsg, 1 );
    }
}

// Namespace proxyagent
// Params 1
// Checksum 0xc5fbb695, Offset: 0x294
// Size: 0x25
function watchplayerkillstreakdisconnect( endnotifymsg )
{
    self endon( endnotifymsg );
    self waittill( #"disconnect" );
    self notify( endnotifymsg, 1 );
}

// Namespace proxyagent
// Params 1
// Checksum 0x657076a7, Offset: 0x2c1
// Size: 0x25
function watchplayerkillstreakswitchteam( endnotifymsg )
{
    self endon( endnotifymsg );
    self waittill( #"joined_team" );
    self notify( endnotifymsg, 1 );
}

// Namespace proxyagent
// Params 1
// Checksum 0xe76749b9, Offset: 0x2ee
// Size: 0x7d
function watchplayerkillstreakearlyexit( endnotifymsg )
{
    self endon( #"disconnect" );
    self endon( endnotifymsg );
    updaterate = level.framedurationseconds;
    
    while ( true )
    {
        timeused = 0;
        
        while ( self usebuttonpressed() )
        {
            timeused += updaterate;
            
            if ( timeused > 0.75 )
            {
                self.playerkillstreakearlyexitlocation = self.origin;
                self notify( endnotifymsg );
                return;
            }
            
            wait updaterate;
        }
        
        waitframe();
    }
}

// Namespace proxyagent
// Params 2
// Checksum 0xf2471ee3, Offset: 0x373
// Size: 0x30
function watchplayerkillstreaktimeout( endnotifymsg, timeoutamount )
{
    self endon( #"disconnect" );
    self endon( endnotifymsg );
    wait timeoutamount;
    self notify( endnotifymsg, 1 );
}

// Namespace proxyagent
// Params 1
// Checksum 0x8ed92ddf, Offset: 0x3ab
// Size: 0x4b
function watchplayerkillstreakemp( endnotifymsg )
{
    self endon( #"disconnect" );
    self endon( endnotifymsg );
    
    while ( true )
    {
        self waittill( #"hash_1e92cef67075cf3b", attacker, duration );
        
        /#
        #/
    }
}

// Namespace proxyagent
// Params 1
// Checksum 0x67c9f269, Offset: 0x3fe
// Size: 0x21
function watchplayerkillstreakend( endnotifymsg )
{
    utility::waittill_any( endnotifymsg, "level_game_ended" );
    stopcontrol();
}

// Namespace proxyagent
// Params 0
// Checksum 0x96d9902f, Offset: 0x427
// Size: 0x1b
function watchgameend()
{
    level waittill( #"game_ended" );
    self notify( #"level_game_ended" );
}

// Namespace proxyagent
// Params 4
// Checksum 0x2f7a4f87, Offset: 0x44a
// Size: 0x58
function startcontrol( agent, streakname, endnotifymsg, visionset )
{
    if ( isdefined( self ) && isalive( agent ) )
    {
        self controlagent( agent );
        
        if ( isdefined( visionset ) )
        {
            self visionsetnakedforplayer( visionset, 0 );
        }
        
        self.playerproxyagent = agent;
    }
}

// Namespace proxyagent
// Params 0
// Checksum 0x3228266c, Offset: 0x4aa
// Size: 0x4d
function stopcontrol()
{
    if ( isdefined( self ) )
    {
        if ( killstreak::iscontrollingproxyagent() )
        {
            self restorecontrolagent();
            self visionsetnakedforplayer( "", 0 );
        }
        
        assertmsg( "<dev string:x24>" );
        self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        self.playerproxyagent = undefined;
    }
}

// Namespace proxyagent
// Params 1
// Checksum 0x22396454, Offset: 0x4ff
// Size: 0x13
function cleararchetype( classstruct )
{
    class::loadout_clearperks();
}

// Namespace proxyagent
// Params 1
// Checksum 0xf58afdb1, Offset: 0x51a
// Size: 0x57
function reapplyarchetype( classstruct )
{
    funcapply = undefined;
    
    switch ( classstruct.loadoutarchetype )
    {
        case #"hash_98ff6f21872f18e0":
            funcapply = &archassault::applyarchetype;
            break;
    }
    
    class::loadout_updateplayerperks( classstruct );
    
    if ( isdefined( funcapply ) )
    {
        self [[ funcapply ]]();
    }
}

// Namespace proxyagent
// Params 1
// Checksum 0x8204bd83, Offset: 0x579
// Size: 0xc
function killproxy( keepcorpse )
{
    
}

