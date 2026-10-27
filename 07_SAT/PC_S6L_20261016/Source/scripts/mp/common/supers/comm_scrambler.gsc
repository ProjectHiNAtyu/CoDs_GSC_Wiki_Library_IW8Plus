// scripts\mp\common\supers\comm_scrambler.gsc  (hash_12a0c2fc4e109b95.gscc) (size: 13917 Bytes / 0x365d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9480fa98 (2491480728)
// size ...... 13917 (0x365d)
// includes .. 14  (offset: 0x3469)
// strings ... 27  (offset: 0x34d9)
// dev strs .. 1   (offset: 0x3651)
// exports ... 38  (offset: 0x2161)
// cseg ...... 0x26d + 0x1ef4 (0x2161)
// imports ... 107 (offset: 0x2751)
// animtree1 . 0   (offset: 0x365d)
// animtree2 . 0   (offset: 0x365d)
#using scripts\common\ae_utility;
#using scripts\common\functionals_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace comm_scrambler;

// Namespace comm_scrambler
// Params 0, eflags: 0x1
// Checksum 0xee2301b, Offset: 0x28b
// Size: 0x36
function autoexec main()
{
    utility::registersharedfunc( "super_comm_scrambler", #"init", &commscrambler_init );
    utility::registersharedfunc( "super_comm_scrambler", #"hash_dd5999d684fc5003", &function_581abb08863386f4 );
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x1ff5beea, Offset: 0x2c9
// Size: 0x8c
function commscrambler_init()
{
    level.var_a41e633b2dc63a7d = [];
    
    if ( utility::issharedfuncdefined( #"team_utility", #"hash_88f640371045bcb9" ) )
    {
        [[ utility::getsharedfunc( #"team_utility", #"hash_5de02d9395de8621" ) ]]( &commscrambler_updateheadicononjointeam );
    }
    
    utility::registersharedfunc( "super_comm_scrambler", #"commscrambler_used", &commscrambler_used );
    utility::registersharedfunc( "super_comm_scrambler", #"commscrambler_onhacked", &commscrambler_onhacked );
    weapons::registerusedcallback( "comm_scrambler", &commscrambler_used );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x39aa6794, Offset: 0x35d
// Size: 0x319
function commscrambler_used( grenade )
{
    grenade endon( #"death" );
    level endon( #"game_ended" );
    grenade.owner = self;
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ "super_comm_scrambler" ].id;
    grenade.bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_comm_scrambler" );
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade thread commscrambler_watchlifetime();
    grenade thread function_731911d4e2146f9e();
    grenade thread function_6976d1f712b37244( self );
    grenade waittill( #"missile_stuck", stuckto );
    grenade commscrambler_handlemovingplatforms( stuckto );
    
    if ( utility::issharedfuncdefined( #"weapons", #"onequipmentplanted" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"onequipmentplanted" ) ]]( grenade, "equip_comm_scrambler", &commscrambler_destroy );
    }
    
    grenade setscriptablepartstate( "activate", "activate", 0 );
    level.var_a41e633b2dc63a7d[ grenade getentitynumber() ] = grenade;
    grenade emp_debuff::set_apply_emp_callback( &commscrambler_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &commscrambler_empapplied;
    }
    
    grenade emp_debuff::set_clear_emp_callback( &commscrambler_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempclearcallback = &commscrambler_empcleared;
    }
    
    grenade haywire::function_7f69a1eb3d590f76( &commscrambler_haywireapplied );
    grenade commscrambler_makedamageable();
    grenade.isactive = 1;
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    grenade.minimapid = grenade objidpoolmanager::createobjective( "jup_hud_icon_minimap_fieldupgrade_commscrambler", grenade.team, 0, 1, 1 );
    triggerradius = getdvarfloat( @"hash_304ea9c01d3fa58b", grenade.bundle.commscramblertriggerradius );
    grenade game_utility::questcircle_create( "TestCircle", grenade.origin, triggerradius );
    grenade game_utility::questcircle_showtoall();
    grenade commscrambler_create_trigger();
    grenade setscriptablepartstate( "enemies_present", "not_present", 0 );
    grenade childthread function_e9c73ecad230b647();
    grenade childthread function_5d11755086113923();
    
    if ( !isai( self ) && grenade.bundle.var_2a67ab57b6a60bdb && utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
    {
        grenade childthread function_7ed6a6508a198b46();
        grenade.var_a57706f38444d58c = 0;
        grenade.var_6e91df3d5b8d4e09 = [];
        grenade childthread function_64ca789d3414977f();
        grenade childthread function_e895aba9f8e9912b();
        grenade childthread function_26b87ba87c34e8d();
    }
    
    challenges::function_a0936b0e5b4550f3( "super_comm_scrambler", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xd40ce9a9, Offset: 0x67e
// Size: 0xa8
function commscrambler_destroy( wasdestroyed )
{
    deletiondelay = 0.1;
    moving_platform = undefined;
    fxoriginoffset = undefined;
    thread commscrambler_delete( deletiondelay, wasdestroyed );
    
    if ( isdefined( self ) )
    {
        fxorigin = self.origin;
        var_6978ba6f62479219 = self getlinkedparent();
        
        if ( isdefined( var_6978ba6f62479219 ) )
        {
            moving_platform = var_6978ba6f62479219;
            fxoriginoffset = moving_platform.origin - fxorigin;
        }
        
        self setscriptablepartstate( "destroy", "active", 0 );
        
        if ( isent( moving_platform ) )
        {
            fxorigin = moving_platform.origin - fxoriginoffset;
        }
    }
}

// Namespace comm_scrambler
// Params 2
// Checksum 0x5b88509b, Offset: 0x72e
// Size: 0x151
function commscrambler_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    wait deletiondelay;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self setcandamage( 0 );
    self.exploding = 1;
    
    if ( isdefined( self.owner ) && utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
    {
        self.owner [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( self );
    }
    
    commscrambler_removeheadicon();
    functionals_utility::clearminimapid();
    game_utility::questcircle_delete();
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    }
    
    function_d946e94bf90057aa();
    level.var_a41e633b2dc63a7d[ self getentitynumber() ] = undefined;
    self.owner challenges::function_a0936b0e5b4550f3( "super_comm_scrambler", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
    self delete();
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x3049665, Offset: 0x887
// Size: 0xa5
function function_d946e94bf90057aa()
{
    if ( !isdefined( self.trigger ) )
    {
        return;
    }
    
    foreach ( id, player in self.trigger.playersintrigger )
    {
        player function_8bfd81814783eec( self, id );
    }
    
    self.trigger delete();
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x3c20aae3, Offset: 0x934
// Size: 0x191
function commscrambler_create_trigger()
{
    triggerradius = getdvarint( @"hash_304ea9c01d3fa58b", self.bundle.commscramblertriggerradius );
    triggerheight = getdvarint( @"hash_d9d5ba0482f401a", self.bundle.commscramblertriggerheight );
    spawnpoint = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - triggerheight / 2 );
    self.trigger = spawn( "trigger_radius", spawnpoint, 0, triggerradius, triggerheight );
    self.trigger.playersintrigger = [];
    self.trigger.var_5b460b317b70085e = [];
    self.trigger.var_cec13317732947c3 = [];
    self.trigger enablelinkto();
    self.trigger linkto( self );
    
    /#
        if ( getdvarint( @"hash_7a6de10a710dbdbe", 0 ) == 1 )
        {
            end = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + triggerheight / 2 );
            lifetime = getdvarint( @"hash_2467b36602d82d7f", self.bundle.maxlifetime );
            cylinder( spawnpoint, end, triggerradius, ( 1, 0, 0 ), 0, 20 * lifetime );
        }
    #/
}

// Namespace comm_scrambler
// Params 0
// Checksum 0xd5532987, Offset: 0xacd
// Size: 0x110
function function_e9c73ecad230b647()
{
    while ( true )
    {
        self.trigger waittill( #"trigger" );
        var_af75573ca791efe3 = self.trigger getistouchingentities( level.players );
        
        foreach ( player in var_af75573ca791efe3 )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            entitynumber = player getentitynumber();
            
            if ( !isdefined( self.trigger.playersintrigger[ entitynumber ] ) )
            {
                self.trigger.playersintrigger[ entitynumber ] = player;
                
                if ( self.isactive )
                {
                    player function_467653ea8bdd80df( self, entitynumber );
                }
            }
        }
    }
}

// Namespace comm_scrambler
// Params 2
// Checksum 0xcd54bcfa, Offset: 0xbe5
// Size: 0x12c
function function_467653ea8bdd80df( grenade, id )
{
    if ( player_utility::isenemy( grenade.owner ) )
    {
        if ( grenade.trigger.var_cec13317732947c3.size == 0 )
        {
            grenade setscriptablepartstate( "enemies_present", "present", 0 );
        }
        
        grenade.trigger.var_cec13317732947c3 = arraycombineunique( grenade.trigger.var_cec13317732947c3, [ id ] );
        
        if ( !isdefined( self.var_ba321cc2bbfdb66a ) )
        {
            self.var_ba321cc2bbfdb66a = [];
        }
        
        self.var_ba321cc2bbfdb66a = arraycombineunique( self.var_ba321cc2bbfdb66a, [ grenade ] );
        self setclientomnvar( "ui_gameplay_comm_scrambler_active", 1 );
        self playsoundtoplayer( "eqp_comm_scrambler_ui_enemyscrambled_transient", self );
        return;
    }
    
    grenade.trigger.var_5b460b317b70085e = arraycombineunique( grenade.trigger.var_5b460b317b70085e, [ id ] );
    self setplayerghost( 1 );
    self setplayeradvanceduavdot( 1 );
    self.var_82e5268591e32cb2 = 1;
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x1996b59a, Offset: 0xd19
// Size: 0x14d
function function_5d11755086113923()
{
    while ( true )
    {
        foreach ( id, player in self.trigger.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.trigger.playersintrigger[ id ] = undefined;
                self.trigger.var_5b460b317b70085e = arrayremove( self.trigger.var_5b460b317b70085e, id );
                self.trigger.var_cec13317732947c3 = arrayremove( self.trigger.var_cec13317732947c3, id );
                continue;
            }
            
            if ( !player istouching( self.trigger ) || !player player::isreallyalive() )
            {
                self.trigger.playersintrigger[ id ] = undefined;
                
                if ( self.isactive )
                {
                    player function_8bfd81814783eec( self, id );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace comm_scrambler
// Params 3
// Checksum 0xbcfa5877, Offset: 0xe6e
// Size: 0x126
function function_8bfd81814783eec( grenade, id, owner = grenade.owner )
{
    if ( player_utility::isenemy( owner ) )
    {
        grenade.trigger.var_cec13317732947c3 = arrayremove( grenade.trigger.var_cec13317732947c3, id );
        
        if ( grenade.trigger.var_cec13317732947c3.size == 0 )
        {
            grenade setscriptablepartstate( "enemies_present", "not_present", 0 );
        }
        
        if ( isdefined( self.var_ba321cc2bbfdb66a ) )
        {
            self.var_ba321cc2bbfdb66a = arrayremove( self.var_ba321cc2bbfdb66a, grenade );
        }
        else
        {
            assertmsg( "<dev string:x24>" );
        }
        
        self setclientomnvar( "ui_gameplay_comm_scrambler_active", 0 );
        return;
    }
    
    grenade.trigger.var_5b460b317b70085e = arrayremove( grenade.trigger.var_5b460b317b70085e, id );
    self setplayerghost( 0 );
    self setplayeradvanceduavdot( 0 );
    self.var_82e5268591e32cb2 = 0;
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xc1dae25e, Offset: 0xf9c
// Size: 0xed
function function_581abb08863386f4( streakitem )
{
    if ( self.var_ba321cc2bbfdb66a.size > 0 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"super_mp/comm_scrambler_killstreak_blocked_message" );
        }
        
        self playsoundtoplayer( "eqp_comm_scrambler_ui_killstreak_disabled", self );
        
        foreach ( commscrambler in self.var_ba321cc2bbfdb66a )
        {
            commscrambler notify( #"killstreak_blocked", self );
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace comm_scrambler
// Params 0
// Checksum 0xfbd3796c, Offset: 0x1091
// Size: 0xcd
function function_7ed6a6508a198b46()
{
    self.var_31a670aad381de8c = [];
    
    while ( true )
    {
        self waittill( #"killstreak_blocked", playerblocked );
        playerentitynum = playerblocked getentitynumber();
        currenttime = gettime();
        mintime = self.bundle.var_9635885f17644e75 * 1000;
        
        if ( !isdefined( self.var_31a670aad381de8c[ playerentitynum ] ) || currenttime - self.var_31a670aad381de8c[ playerentitynum ] > mintime )
        {
            self.var_31a670aad381de8c[ playerentitynum ] = currenttime;
            self.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"super_comm_scrambler_killstreak_blocked" );
        }
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x539ba5e2, Offset: 0x1166
// Size: 0x1fb
function function_64ca789d3414977f()
{
    var_51d02b0ea09e3638 = self.bundle.var_f95ec52455ca3e4d * 1000;
    
    while ( true )
    {
        var_17bb25d0a5511d48 = gettime() - self.var_a57706f38444d58c;
        
        if ( var_17bb25d0a5511d48 < var_51d02b0ea09e3638 )
        {
            wait ( var_51d02b0ea09e3638 - var_17bb25d0a5511d48 ) / 1000;
        }
        
        if ( self.isactive )
        {
            var_bd6783b86e945141 = 0;
            
            if ( level.teambased )
            {
                if ( level.var_f3d1cde89907a07a )
                {
                    var_bd6783b86e945141 = level.activeuavs[ self.owner.sessionsquadid ] ?? 0;
                }
                else
                {
                    var_bd6783b86e945141 = level.activeuavs[ self.owner.team ] ?? 0;
                }
            }
            else
            {
                var_bd6783b86e945141 = level.activeuavs[ self.owner.guid ] ?? 0;
            }
            
            hasuav = level.totalactiveuavs - var_bd6783b86e945141 > 0;
            
            if ( !hasuav )
            {
                var_d824015f4d7b43b6 = 0;
                
                if ( level.teambased )
                {
                    if ( level.var_f3d1cde89907a07a )
                    {
                        var_d824015f4d7b43b6 = level.activeadvanceduavs[ self.owner.sessionsquadid ] ?? 0;
                    }
                    else
                    {
                        var_d824015f4d7b43b6 = level.activeadvanceduavs[ self.owner.team ] ?? 0;
                    }
                }
                else
                {
                    var_d824015f4d7b43b6 = level.activeadvanceduavs[ self.owner.guid ] ?? 0;
                }
                
                hasuav = level.activeadvanceduavcount - var_d824015f4d7b43b6 > 0;
            }
            
            if ( hasuav )
            {
                var_158048cfe9550627 = arrayremove( self.trigger.var_5b460b317b70085e, self.var_6e91df3d5b8d4e09 );
                
                if ( var_158048cfe9550627.size > 0 )
                {
                    function_234e4e27b836c556( var_158048cfe9550627 );
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x428c02f1, Offset: 0x1369
// Size: 0x62
function function_e895aba9f8e9912b()
{
    while ( true )
    {
        level waittill( #"portable_radar_ping", pingposition, pingplayer, pingradius );
        
        if ( self.isactive && pingplayer player_utility::isenemy( self.owner ) )
        {
            function_9370361ac77720a5( pingposition, pingradius );
        }
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0xa2244bd0, Offset: 0x13d3
// Size: 0xba
function function_26b87ba87c34e8d()
{
    while ( true )
    {
        level waittill( #"hash_a933076aaaf7d216", pingindex, pingposition, pingteam, pingradius, sweeptime, squadid );
        
        if ( isint( pingposition ) && isvector( pingteam ) && isstring( pingradius ) )
        {
            temp = pingteam;
            pingteam = pingradius;
            pingradius = pingposition;
            pingposition = temp;
        }
        
        if ( self.isactive && pingteam != self.owner.team )
        {
            function_9370361ac77720a5( pingposition, pingradius );
        }
    }
}

// Namespace comm_scrambler
// Params 2
// Checksum 0xd45388e2, Offset: 0x1495
// Size: 0x16a
function function_9370361ac77720a5( pingposition, pingradius )
{
    var_51d02b0ea09e3638 = self.bundle.var_f95ec52455ca3e4d * 1000;
    var_17bb25d0a5511d48 = gettime() - self.var_a57706f38444d58c;
    
    if ( var_17bb25d0a5511d48 < var_51d02b0ea09e3638 )
    {
        return;
    }
    
    var_c649482225966f26 = arrayremove( self.trigger.var_5b460b317b70085e, self.var_6e91df3d5b8d4e09 );
    var_aa426d51f8d4c0f7 = [];
    
    foreach ( var_b50fbb34db8a1d75 in var_c649482225966f26 )
    {
        var_71b325b53a6bdb02 = self.trigger.playersintrigger[ var_b50fbb34db8a1d75 ];
        var_404bb131e5459958 = distancesquared( var_71b325b53a6bdb02.origin, pingposition );
        var_a711dc250e09ce5 = float( pingradius * pingradius );
        
        if ( var_404bb131e5459958 < var_a711dc250e09ce5 )
        {
            var_aa426d51f8d4c0f7 = arraycombineunique( var_aa426d51f8d4c0f7, [ var_b50fbb34db8a1d75 ] );
        }
    }
    
    if ( var_aa426d51f8d4c0f7.size > 0 )
    {
        function_234e4e27b836c556( var_aa426d51f8d4c0f7 );
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x85f7e930, Offset: 0x1607
// Size: 0x5e
function function_234e4e27b836c556( var_158048cfe9550627 )
{
    self.owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"super_comm_scrambler_ghost" );
    self.var_a57706f38444d58c = gettime();
    self.var_6e91df3d5b8d4e09 = arraycombine( self.var_6e91df3d5b8d4e09, var_158048cfe9550627 );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x20089ce8, Offset: 0x166d
// Size: 0x133
function commscrambler_set_active( isactive )
{
    if ( isactive == self.isactive )
    {
        return;
    }
    
    if ( isactive )
    {
        self.isactive = 1;
        
        foreach ( id, player in self.trigger.playersintrigger )
        {
            player function_467653ea8bdd80df( self, id );
        }
        
        return;
    }
    
    self.isactive = 0;
    
    foreach ( id, player in self.trigger.playersintrigger )
    {
        player function_8bfd81814783eec( self, id );
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x691e69e0, Offset: 0x17a8
// Size: 0x5b
function commscrambler_makedamageable()
{
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        self thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( self.bundle.maxhealth, "hitequip", &commscrambler_handlefataldamage, &functionals_utility::function_cdfa6ea614436cc );
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x57097435, Offset: 0x180b
// Size: 0x27
function commscrambler_handlefataldamage( data )
{
    commscrambler_givepointsfordeath( data.attacker );
    thread commscrambler_destroy( 1 );
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x375f28e9, Offset: 0x183a
// Size: 0x4f
function commscrambler_removeowneroutline()
{
    if ( isdefined( self.outlineid ) )
    {
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( self.outlineid, self );
        }
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x41b2095a, Offset: 0x1891
// Size: 0x50
function commscrambler_removeheadicon()
{
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
    }
    
    if ( isdefined( self.headiconfaction ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconfaction );
        self.headiconfaction = undefined;
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xa79ec27e, Offset: 0x18e9
// Size: 0x70
function commscrambler_givepointsfordeath( attacker )
{
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"destroyed_equipment" );
        }
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xad5c8335, Offset: 0x1961
// Size: 0x14
function commscrambler_onmovingplatformdeath( data )
{
    commscrambler_destroy( 0 );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xcf004135, Offset: 0x197d
// Size: 0x106
function function_2cd1718422d0406d( data )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    superinfo = undefined;
    
    if ( utility::issharedfuncdefined( #"player", #"hash_45a211ad5df3fd3" ) )
    {
        superinfo = owner [[ utility::getsharedfunc( #"player", #"hash_45a211ad5df3fd3" ) ]]();
    }
    
    if ( isdefined( superinfo ) && level.allowsupers )
    {
        superinfo.wasrefunded = 1;
        
        if ( utility::issharedfuncdefined( #"supers", #"getsuperpointsneeded" ) && utility::issharedfuncdefined( #"supers", #"hash_79c2eee2c78b598" ) )
        {
            owner [[ utility::getsharedfunc( #"supers", #"hash_79c2eee2c78b598" ) ]]( owner [[ utility::getsharedfunc( #"supers", #"getsuperpointsneeded" ) ]]() );
        }
    }
    
    commscrambler_destroy( 0 );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xf6e90dc9, Offset: 0x1a8b
// Size: 0xcc
function commscrambler_handlemovingplatforms( stuckto )
{
    data = spawnstruct();
    data.linkparent = stuckto;
    data.deathoverridecallback = &commscrambler_onmovingplatformdeath;
    data.invalidparentoverridecallback = &function_2cd1718422d0406d;
    data.endonstring = "death";
    data.validateaccuratetouching = 1;
    
    if ( isdefined( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
    {
        data.var_f07590e06f628942 = 1;
        self setmissileantilagged( 1 );
    }
    
    if ( utility::issharedfuncdefined( #"game", #"handlemovingplatforms" ) )
    {
        self thread [[ utility::getsharedfunc( #"game", #"handlemovingplatforms" ) ]]( data );
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x361501fc, Offset: 0x1b5f
// Size: 0x13b
function function_6976d1f712b37244( player )
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    player endon( #"disconnect" );
    msg = utility::waittill_any_timeout( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_fbaf852c9cb6dff8 = -2000;
    traceend = self.origin + ( 0, 0, var_fbaf852c9cb6dff8 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        groundentity = traceresults[ "entity" ];
        
        if ( isdefined( groundentity ) )
        {
            if ( utility::is_moving_platform_ent( groundentity ) )
            {
                self.origin = player.origin;
            }
        }
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x5d59c644, Offset: 0x1ca2
// Size: 0x7f
function commscrambler_watchlifetime()
{
    self endon( #"death" );
    
    if ( utility::issharedfuncdefined( #"hostmigration", #"waitLongDurationWithPause" ) )
    {
        [[ utility::getsharedfunc( #"hostmigration", #"waitLongDurationWithPause" ) ]]( getdvarfloat( @"hash_2467b36602d82d7f", self.bundle.maxlifetime ) );
    }
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        thread commscrambler_destroy( 0 );
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x7803b1c2, Offset: 0x1d29
// Size: 0x54
function function_731911d4e2146f9e()
{
    self endon( #"death" );
    self endon( #"comm_scrambler_hacked" );
    self.owner utility::waittill_any_return_no_endon_death( "disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( self ) && !self.isdestroyed )
    {
        thread commscrambler_destroy( 0 );
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x34fe5a1b, Offset: 0x1d85
// Size: 0x73
function commscrambler_empapplied( data )
{
    commscrambler_set_active( 0 );
    
    if ( isdefined( data.attacker ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_comm_scrambler", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x793550c8, Offset: 0x1e00
// Size: 0x15
function commscrambler_empcleared( data )
{
    commscrambler_set_active( 1 );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x8f80c370, Offset: 0x1e1d
// Size: 0x35
function commscrambler_haywireapplied( data )
{
    attacker = data.attacker;
    commscrambler_givepointsfordeath( attacker );
    thread commscrambler_destroy( 1 );
}

// Namespace comm_scrambler
// Params 1
// Checksum 0xc8a5947d, Offset: 0x1e5a
// Size: 0x8c
function commscrambler_updateheadicononjointeam( player )
{
    foreach ( commscrambler in level.var_a41e633b2dc63a7d )
    {
        if ( isdefined( commscrambler ) )
        {
            commscrambler commscrambler_updateheadicon( player );
        }
    }
}

// Namespace comm_scrambler
// Params 0
// Checksum 0x88fe7b7b, Offset: 0x1eee
// Size: 0x83
function commscrambler_updateheadiconallplayers()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        commscrambler_updateheadicon( player );
    }
}

// Namespace comm_scrambler
// Params 1
// Checksum 0x4ef9889, Offset: 0x1f79
// Size: 0xc9
function commscrambler_updateheadicon( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    isfriendly = player_utility::isfriendly( self.owner.team, player );
    isused = isdefined( self.playersused ) && isdefined( self.playersused[ player getentitynumber() ] );
    
    if ( isfriendly && !isused )
    {
        entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        return;
    }
    
    if ( isfriendly )
    {
        entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

// Namespace comm_scrambler
// Params 2
// Checksum 0x5005fc31, Offset: 0x204a
// Size: 0x117
function commscrambler_onhacked( newowner, oldowner )
{
    functionals_utility::clearminimapid();
    self.minimapid = objidpoolmanager::createobjective( "jup_hud_icon_minimap_fieldupgrade_commscrambler", self.team, 0, 1, 1 );
    
    foreach ( id, player in self.trigger.playersintrigger )
    {
        player function_8bfd81814783eec( self, id, oldowner );
    }
    
    self.trigger.playersintrigger = [];
    self.trigger.var_5b460b317b70085e = [];
    self.trigger.var_cec13317732947c3 = [];
    self notify( #"comm_scrambler_hacked" );
    thread function_731911d4e2146f9e();
}

