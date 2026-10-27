// scripts\mp\awards.gsc  (hash_699319ebb3058664.gscc) (size: 7341 Bytes / 0x1cad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf64e2ff (258269951)
// size ...... 7341 (0x1cad)
// includes .. 7   (offset: 0x1aa5)
// strings ... 13  (offset: 0x1add)
// dev strs .. 12  (offset: 0x1c11)
// exports ... 21  (offset: 0x1049)
// cseg ...... 0xf7 + 0xf52 (0x1049)
// imports ... 61  (offset: 0x1391)
// animtree1 . 0   (offset: 0x1cad)
// animtree2 . 0   (offset: 0x1cad)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\rank;

#namespace awards;

// Namespace awards
// Params 0
// Checksum 0xc81bb6ab, Offset: 0x115
// Size: 0x43
function init()
{
    initawards();
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"prematch_done", &onprematchdone );
    level thread onplayerconnect();
    level thread saveaarawardsonroundswitch();
}

// Namespace awards
// Params 0
// Checksum 0xd235e540, Offset: 0x160
// Size: 0x97
function onplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        assert( level.var_299faa498c02cc0d );
        var_c352d178ef795a8e = 1;
        
        if ( level.var_299faa498c02cc0d )
        {
            if ( level.aartracking.trackmedals || level.aartracking.var_f8b55c8fa205391 )
            {
                var_c352d178ef795a8e = 0;
            }
        }
        
        if ( var_c352d178ef795a8e )
        {
            player thread initaarawardlist();
        }
        
        player.awardqueue = [];
    }
}

// Namespace awards
// Params 1
// Checksum 0xabef311f, Offset: 0x1ff
// Size: 0x16
function onplayerspawned( params )
{
    self.awardsthislife = [];
}

// Namespace awards
// Params 1
// Checksum 0x56204993, Offset: 0x21d
// Size: 0x89
function onprematchdone( params )
{
    foreach ( player in level.players )
    {
        player.awardqueue = [];
    }
}

// Namespace awards
// Params 0
// Checksum 0x7ecea124, Offset: 0x2ae
// Size: 0x9
function initawards()
{
    initmidmatchawards();
}

// Namespace awards
// Params 1
// Checksum 0x46f4e286, Offset: 0x2bf
// Size: 0x61
function function_329b78d5e436d05b( ref )
{
    assert( isdefined( ref ) );
    aarpriority = tablelookup( "mp/awardtable.csv", 0, ref, 1 );
    
    if ( aarpriority > 0 )
    {
        randomvalue = randomfloat( 1 );
        level.var_413a3092a9fe127d[ ref ] = float( aarpriority ) + randomvalue;
    }
}

// Namespace awards
// Params 1
// Checksum 0x638e9b76, Offset: 0x328
// Size: 0x15
function initmidmatchaward( ref )
{
    function_329b78d5e436d05b( ref );
}

// Namespace awards
// Params 0
// Checksum 0x3335281b, Offset: 0x345
// Size: 0x6c
function initmidmatchawards()
{
    for ( row = 0; true ; row++ )
    {
        ref = tablelookupbyrow( "mp/awardtable.csv", row, 0 );
        
        if ( !isdefined( ref ) || ref == "" )
        {
            break;
        }
        
        if ( !isxhash( ref ) )
        {
            assert( 0, ref );
            ref = getxhash( ref );
        }
        
        initmidmatchaward( ref );
    }
}

// Namespace awards
// Params 1
// Checksum 0x39dfbd9b, Offset: 0x3b9
// Size: 0x40
function incplayerrecord( ref )
{
    recordvalue = self getplayerdata( "common", "awards", ref );
    self setplayerdata( "common", "awards", ref, recordvalue + 1 );
}

// Namespace awards
// Params 9, eflags: 0x4
// Checksum 0x12793980, Offset: 0x401
// Size: 0x1b2
function private giveaward( ref, objweapon, pointsoverride, xpoverride, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo )
{
    if ( !rank::function_4d2b4b1cc1dec6fd( ref ) )
    {
        assertmsg( "<dev string:x24>" + ref + "<dev string:x3c>" );
        return;
    }
    
    if ( !isdefined( pointsoverride ) )
    {
        pointsoverride = rank::getscoreinfovalue( ref );
    }
    
    if ( pointsoverride > 0 || rank::function_d1309dc6fb66ebc( ref ) > 0 )
    {
        points::giveunifiedpoints( ref, objweapon, pointsoverride, -1, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo );
    }
    
    self endon( #"disconnect" );
    waitframe();
    script::waittillslowprocessallowed();
    
    if ( level.aartracking.trackmedals )
    {
        callback::callback( #"medal_earned", { #ref:ref } );
    }
    else if ( !level.aartracking.var_f8b55c8fa205391 )
    {
        if ( isenumvaluevalid( level.var_6f9b00680ed002d8, "Awards", getxhashhexname( ref ) ) )
        {
            addawardtoaarlist( ref );
        }
    }
    
    xp = xpoverride ?? rank::getscoreinfoxp( ref );
    
    if ( xp > 0 )
    {
        rank::giverankxp( ref, xp, objweapon, undefined, 0, undefined, eventinfo );
    }
    
    script::bufferednotify( "earned_award_buffered", ref );
    
    if ( isdefined( self.awardsthislife[ ref ] ) )
    {
        self.awardsthislife[ ref ]++;
    }
    else
    {
        self.awardsthislife[ ref ] = 1;
    }
    
    utility::trycall( level.matchdata_logaward, ref );
}

// Namespace awards
// Params 10
// Checksum 0xdc4be931, Offset: 0x5bb
// Size: 0x103
function queuemidmatchaward( ref, objweapon, pointsoverride, xpoverride, var_ae2a12845c1ef7c1, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo )
{
    awardinfo = { #eventinfo:eventinfo, #var_c9f5190087459c78:var_c9f5190087459c78, #streakinfo:streakinfo, #cankillchain:cankillchain, #victim:victim, #var_ae2a12845c1ef7c1:var_ae2a12845c1ef7c1, #xpoverride:xpoverride, #pointsoverride:pointsoverride, #objweapon:objweapon, #ref:[ ref, gettime() ] };
    self.awardqueue[ self.awardqueue.size ] = awardinfo;
    thread flushmidmatchawardqueuewhenable();
}

// Namespace awards
// Params 0
// Checksum 0xa301e431, Offset: 0x6c6
// Size: 0x105
function flushmidmatchawardqueue()
{
    assert( !shouldqueuemidmatchaward(), "<dev string:x9a>" );
    
    foreach ( award in self.awardqueue )
    {
        givemidmatchaward( award.ref, award.objweapon, award.pointsoverride, award.xpoverride, award.var_ae2a12845c1ef7c1, award.victim, award.cankillchain, award.streakinfo, award.var_c9f5190087459c78, award.eventinfo );
    }
    
    self.awardqueue = [];
}

// Namespace awards
// Params 0
// Checksum 0xd3b1f5c9, Offset: 0x7d3
// Size: 0x4f
function flushmidmatchawardqueuewhenable()
{
    self notify( #"hash_d9b706e0926153fc" );
    self endon( #"hash_d9b706e0926153fc" );
    self endon( #"disconnect" );
    level endon( #"prematch_done" );
    
    while ( true )
    {
        if ( !shouldqueuemidmatchaward() )
        {
            break;
        }
        
        waitframe();
    }
    
    thread flushmidmatchawardqueue();
}

// Namespace awards
// Params 1
// Checksum 0x7b35babd, Offset: 0x82a
// Size: 0xb1, Type: bool
function shouldqueuemidmatchaward( var_2a0df070ba5cb96a )
{
    if ( level.gameended )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_9779e069cc4f5bc8", 0 ) > 0 )
        {
            level.var_a661b06c70d4dc97 = getdvarint( @"hash_9779e069cc4f5bc8", 0 );
            setdvar( @"hash_9779e069cc4f5bc8", 0 );
        }
        
        if ( isdefined( level.var_a661b06c70d4dc97 ) )
        {
            if ( level.var_a661b06c70d4dc97 > 0 )
            {
                level.var_a661b06c70d4dc97--;
                return true;
            }
            
            level.var_a661b06c70d4dc97 = undefined;
        }
    #/
    
    if ( !player::isreallyalive( self ) )
    {
        if ( !var_2a0df070ba5cb96a || player::isinkillcam() )
        {
            if ( !utility::isusingremote() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace awards
// Params 10
// Checksum 0x7a99007b, Offset: 0x8e4
// Size: 0x13b
function givemidmatchaward( ref, objweapon, pointsoverride, xpoverride, var_ae2a12845c1ef7c1, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( level.gameended )
    {
        isvalidevent = 0;
        
        if ( isarray( ref ) )
        {
            if ( isnumber( level.gameendtime ) )
            {
                if ( ref[ 1 ] <= level.gameendtime )
                {
                    isvalidevent = 1;
                    ref = ref[ 0 ];
                }
            }
        }
        else if ( isdefined( ref ) )
        {
            isvalidevent = 1;
        }
        
        if ( !isvalidevent )
        {
            return;
        }
    }
    else if ( isarray( ref ) )
    {
        ref = ref[ 0 ];
    }
    
    if ( !isxhash( ref ) )
    {
        assert( 0, ref );
        ref = getxhash( ref );
    }
    
    if ( shouldqueuemidmatchaward( var_ae2a12845c1ef7c1 ) )
    {
        queuemidmatchaward( ref, objweapon, pointsoverride, xpoverride, var_ae2a12845c1ef7c1, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo );
        return;
    }
    
    analyticslog::logevent_awardgained( ref );
    thread giveaward( ref, objweapon, pointsoverride, xpoverride, victim, cankillchain, streakinfo, var_c9f5190087459c78, eventinfo );
}

// Namespace awards
// Params 1
// Checksum 0xc844ae5d, Offset: 0xa27
// Size: 0x393
function addawardtoaarlist( ref )
{
    if ( level.aartracking.trackmedals || level.aartracking.var_f8b55c8fa205391 )
    {
        assertmsg( "<dev string:xdd>" );
        return;
    }
    
    if ( !isdefined( self.aarawards ) )
    {
        self.aarawards = [];
        self.aarawardcount = 0;
        
        for ( awardindex = 0; awardindex < 10 ; awardindex++ )
        {
            struct = spawnstruct();
            self.aarawards[ awardindex ] = struct;
            struct.ref = "none";
            struct.count = 0;
        }
    }
    
    foreach ( awardindex, awardinfo in self.aarawards )
    {
        if ( awardinfo.ref == ref )
        {
            awardinfo.count++;
            self setplayerdata( "common", "round", "awards", awardindex, "value", awardinfo.count );
            return;
        }
    }
    
    newpriority = level.var_413a3092a9fe127d[ ref ] ?? 0;
    
    for ( insertindex = 0; insertindex < self.aarawards.size ; insertindex++ )
    {
        awardinfo = self.aarawards[ insertindex ];
        
        if ( awardinfo.ref == "none" )
        {
            break;
        }
        
        otherpriority = level.var_413a3092a9fe127d[ awardinfo.ref ] ?? 0;
        
        if ( newpriority > otherpriority )
        {
            break;
        }
    }
    
    if ( insertindex >= self.aarawards.size )
    {
        return;
    }
    
    for ( listindex = self.aarawards.size - 2; listindex >= insertindex ; listindex-- )
    {
        newindex = listindex + 1;
        self.aarawards[ newindex ] = self.aarawards[ listindex ];
        awardinfo = self.aarawards[ newindex ];
        
        if ( awardinfo.ref != "none" )
        {
            self setplayerdata( "common", "round", "awards", newindex, "award", getxhashhexname( awardinfo.ref ) );
            self setplayerdata( "common", "round", "awards", newindex, "value", awardinfo.count );
        }
    }
    
    awardinfo = spawnstruct();
    self.aarawards[ insertindex ] = awardinfo;
    awardinfo.ref = ref;
    awardinfo.count = 1;
    self setplayerdata( "common", "round", "awards", insertindex, "award", getxhashhexname( awardinfo.ref ) );
    self setplayerdata( "common", "round", "awards", insertindex, "value", awardinfo.count );
    
    if ( self.aarawardcount < 10 )
    {
        self.aarawardcount++;
        self setplayerdata( "common", "round", "awardCount", self.aarawardcount );
    }
    
    if ( self.savedaarawards )
    {
        saveaarawards();
    }
}

// Namespace awards
// Params 0
// Checksum 0x605acf18, Offset: 0xdc2
// Size: 0xaf
function initaarawardlist()
{
    self.aarawards = self.pers[ "aarAwards" ];
    self.aarawardcount = self.pers[ "aarAwardCount" ];
    
    if ( isdefined( self.aarawards ) )
    {
        return;
    }
    
    self setplayerdata( "common", "round", "awardCount", 0 );
    
    for ( awardindex = 0; awardindex < 10 ; awardindex++ )
    {
        self setplayerdata( "common", "round", "awards", awardindex, "award", "none" );
        self setplayerdata( "common", "round", "awards", awardindex, "value", 0 );
    }
}

// Namespace awards
// Params 0
// Checksum 0xcd73db6, Offset: 0xe79
// Size: 0x99
function saveaarawardsonroundswitch()
{
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !isbot( player ) )
        {
            player saveaarawards();
        }
    }
}

// Namespace awards
// Params 0
// Checksum 0x82b2e088, Offset: 0xf1a
// Size: 0x3f
function saveaarawards()
{
    self.pers[ "aarAwards" ] = self.aarawards;
    self.pers[ "aarAwardCount" ] = self.aarawardcount;
    self.savedaarawards = 1;
}

/#

    // Namespace awards
    // Params 0
    // Checksum 0xc51126ea, Offset: 0xf61
    // Size: 0xe8, Type: dev
    function function_5fb07a9941f6b818()
    {
        for ( awardindex = 0; awardindex < self.aarawards.size ; awardindex++ )
        {
            awardinfo = self.aarawards[ awardindex ];
            pdref = self getplayerdata( "<dev string:x154>", "<dev string:x15b>", "<dev string:x161>", awardindex, "<dev string:x168>" );
            pdcount = self getplayerdata( "<dev string:x154>", "<dev string:x15b>", "<dev string:x161>", awardindex, "<dev string:x16e>" );
            assert( awardinfo.ref == pdref );
            assert( awardinfo.count == pdcount );
            println( "<dev string:x174>" + awardindex + 1 + "<dev string:x17f>" + awardinfo.ref + "<dev string:x182>" + awardinfo.count );
        }
    }

#/
