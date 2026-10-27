// scripts\mp\common\utility\killstreak.gsc  (hash_629fd7d4479d556d.gscc) (size: 29908 Bytes / 0x74d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57e8e035 (1474879541)
// size ...... 29908 (0x74d4)
// includes .. 21  (offset: 0x7164)
// strings ... 44  (offset: 0x720c)
// dev strs .. 8   (offset: 0x7474)
// exports ... 111 (offset: 0x4df8)
// cseg ...... 0x1042 + 0x3db6 (0x4df8)
// imports ... 155 (offset: 0x5f50)
// animtree1 . 0   (offset: 0x74d4)
// animtree2 . 0   (offset: 0x74d4)
#using scripts\common\damage_tuning;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\hud_util;
#using scripts\mp\vehicles\damage;

#namespace killstreak;

// Namespace killstreak
// Params 1
// Checksum 0x9bdcaf79, Offset: 0x1060
// Size: 0x1e, Type: bool
function hasplayerdiedwhileusingkillstreak( streakinfo )
{
    return streakinfo.lifeid != killstreak_utility::getcurrentplayerlifeidforkillstreak();
}

// Namespace killstreak
// Params 7
// Checksum 0xb44ca127, Offset: 0x1087
// Size: 0x443
function addtoactivekillstreaklist( streak, threatbiasgroup, owner, outline, teamheadicon, var_845024a5b0bb57cb, endnotifyoverride )
{
    if ( isstruct( streak ) )
    {
        streakinfo = streak;
        streakname = streakinfo.streakname;
    }
    else
    {
        streakinfo = undefined;
        streakname = streak;
    }
    
    assert( isdefined( streakname ), "<dev string:x24>" );
    entnumber = self getentitynumber();
    
    if ( isdefined( streakname ) )
    {
        if ( isremotekillstreak( streak ) || self.remotekillstreak )
        {
            addtoremotekillstreaklist( entnumber );
            thread removefromremotekillstreaklistondeath( entnumber );
        }
        
        if ( isuavkillstreak( streakname ) )
        {
            addtouavlist( entnumber, owner );
            thread removefromuavlistondeath( entnumber, owner );
        }
        else if ( isairstrikekillstreak( streakname ) )
        {
            addtoairstrikelist( entnumber );
            thread removefromairstrikelistondeath( entnumber );
        }
        else if ( islittlebirdkillstreak( streakname ) )
        {
            addtolittlebirdlist( entnumber );
            thread removefromlittlebirdlistondeath( entnumber );
        }
        else if ( ishelikillstreak( streakname ) )
        {
            addtohelilist( entnumber );
            thread removefromhelilistondeath( entnumber );
        }
        else if ( isturretkillstreak( streakname ) )
        {
            addtoturretlist( entnumber );
            thread removefromturretlistondeathorcarry( entnumber );
        }
        else if ( function_e8fd44aed0b7e44f( streakname ) )
        {
            function_45a1150ecedbfbc3();
            thread function_80d7210dbee48d0a( entnumber );
        }
        else if ( isprojectilekillstreak( streakname ) || self.isprojectile )
        {
            addtoprojectilelist( entnumber );
            thread removefromprojectilelistondeath( entnumber );
        }
        else if ( issupportdronekillstreak( streakname ) )
        {
            addtosupportdronelist( entnumber );
            thread removefromsupportdronelistondeath( entnumber );
        }
        else if ( isassaultdronekillstreak( streakname ) )
        {
            addtoassaultdronelist( entnumber );
            thread removefromassaultdronelistondeath( entnumber );
        }
        else if ( function_f2ba3c00491f1185( streakname ) )
        {
            function_be0afefdd5f0b7a1( entnumber );
            thread function_c96d231cebe1c470( entnumber );
        }
        else
        {
            addtoplayerkillstreaklist( entnumber );
            thread removefromplayerkillstreaklistondeath( entnumber );
        }
        
        if ( killstreak_shared::iskillstreaklockonable( streakname ) )
        {
            function_80e13cda8d6717d7( 1 );
        }
    }
    
    level.activekillstreaks[ entnumber ] = self;
    level.activekillstreaks[ entnumber ].streakname = streakname;
    
    if ( self.team )
    {
        if ( !isdefined( level.var_d29307e7a921c9d3[ self.team ] ) )
        {
            level.var_d29307e7a921c9d3[ self.team ] = [];
        }
        
        level.var_d29307e7a921c9d3[ self.team ][ entnumber ] = self;
    }
    
    bundle = level.streakglobals.streakbundles[ streakname ];
    self.isairkillstreak = 0;
    
    if ( isdefined( bundle.threatbiasgroupname ) )
    {
        self.isairkillstreak = bundle.threatbiasgroupname == #"killstreak_air";
    }
    else
    {
        self.isairkillstreak = threatbiasgroup == "Killstreak_Air";
    }
    
    if ( !bundle.var_590ce85b8bf088f9 )
    {
        if ( self.isairkillstreak )
        {
            self enableplayermarks( #"air_killstreak" );
        }
        else
        {
            self enableplayermarks( #"killstreak" );
        }
        
        if ( level.teambased )
        {
            self filteroutplayermarks( owner.team );
        }
        else
        {
            self filteroutplayermarks( owner );
        }
    }
    
    if ( outline && level.gamemodebundle.var_3b43279f885bc8f8 && !isdefined( self.outlineid ) )
    {
        self.outlineid = outline::outlineenableforplayer( self, owner, "killstreak_own", "lowest" );
        thread removeoutlineonnotify( self.outlineid, endnotifyoverride );
    }
    
    if ( teamheadicon && !isdefined( self.headiconid ) )
    {
        imageoverride = self.var_30656af96b2ac2a4.size > 0 ? bundle.buffedheadicon : undefined;
        self.headiconid = entityheadicons::setheadicon_killstreak( self, imageoverride );
        thread removeteamheadicononnotify( self.headiconid, endnotifyoverride );
    }
    
    /#
        thread function_80129b729abf4fed( streakname );
    #/
}

// Namespace killstreak
// Params 1
// Checksum 0xcdc9494a, Offset: 0x14d2
// Size: 0x4d
function function_80e13cda8d6717d7( isaffected = 1 )
{
    self.affectedbylockon = isaffected;
    
    if ( !isaffected )
    {
        self notify( #"disable_lockon" );
    }
    
    utility::callsharedfunc( #"flare_system", #"hash_58a53f4881a5cfa7", isaffected );
}

// Namespace killstreak
// Params 2
// Checksum 0x79c5da14, Offset: 0x1527
// Size: 0x5a
function removeoutlineonnotify( outlineid, endnotifyoverride )
{
    wait_array = [ "death" ];
    
    if ( isdefined( endnotifyoverride ) )
    {
        arraycombineunique( wait_array, endnotifyoverride );
    }
    
    utility::waittill_any_in_array_return_no_endon_death( wait_array );
    outline::outlinedisable( outlineid, self );
    
    if ( self )
    {
        self.outlineid = undefined;
    }
}

// Namespace killstreak
// Params 2
// Checksum 0x5ea04754, Offset: 0x1589
// Size: 0x52
function removeteamheadicononnotify( icon, endnotifyoverride )
{
    if ( !isdefined( endnotifyoverride ) )
    {
        return;
    }
    
    if ( isarray( endnotifyoverride ) )
    {
        wait_array = endnotifyoverride;
    }
    else
    {
        wait_array = [ endnotifyoverride ];
    }
    
    utility::waittill_any_in_array_return_no_endon_death( wait_array );
    entityheadicons::setheadicon_deleteicon( icon );
}

// Namespace killstreak
// Params 1
// Checksum 0x33aa773b, Offset: 0x15e3
// Size: 0x54
function removefromactivekillstreaklist( entnumber )
{
    level.activekillstreaks[ entnumber ] = undefined;
    
    if ( self.team && level.var_d29307e7a921c9d3[ self.team ][ entnumber ] )
    {
        level.var_d29307e7a921c9d3[ self.team ][ entnumber ] = undefined;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x74a9266b, Offset: 0x163f
// Size: 0x101
function function_5158f3269030d0fc( friendlyteam )
{
    result = [];
    
    foreach ( team, teamkillstreaks in level.var_d29307e7a921c9d3 )
    {
        if ( team == friendlyteam )
        {
            continue;
        }
        
        foreach ( ks in teamkillstreaks )
        {
            result[ result.size ] = ks;
        }
    }
    
    return result;
}

// Namespace killstreak
// Params 1
// Checksum 0xc27de869, Offset: 0x1749
// Size: 0x29, Type: bool
function activekillstreaklistcontains( entnumber )
{
    if ( !isdefined( level.activekillstreaks ) )
    {
        return false;
    }
    
    return isdefined( level.activekillstreaks[ entnumber ] );
}

// Namespace killstreak
// Params 1
// Checksum 0x25550856, Offset: 0x177b
// Size: 0x30
function addtoremotekillstreaklist( entnumber )
{
    if ( !isdefined( level.remotekillstreaks ) )
    {
        level.remotekillstreaks = [];
    }
    
    level.remotekillstreaks[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0xb3cd6c3c, Offset: 0x17b3
// Size: 0x2c
function removefromremotekillstreaklistondeath( entnumber )
{
    self waittill( #"death" );
    function_e35316622279e7b3();
    level.remotekillstreaks[ entnumber ] = undefined;
}

// Namespace killstreak
// Params 0
// Checksum 0xe0e2d1ac, Offset: 0x17e7
// Size: 0x1f
function function_e35316622279e7b3()
{
    if ( self.var_37ea0fa5533244a1 )
    {
        utility::waittill_notify_or_timeout( "killstreak_end_active_state", 1.5 );
    }
}

// Namespace killstreak
// Params 2
// Checksum 0xee73f08c, Offset: 0x180e
// Size: 0x1c0
function addtouavlist( entnumber, owner )
{
    if ( !isdefined( level.uavmodels ) )
    {
        level.uavmodels = [];
    }
    
    if ( level.teambased )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            level.uavmodels[ owner.sessionsquadid ][ level.uavmodels[ owner.sessionsquadid ].size ] = self;
        }
        else
        {
            if ( !isdefined( level.uavmodels[ self.team ] ) )
            {
                level.uavmodels[ self.team ] = [];
            }
            
            level.uavmodels[ self.team ][ level.uavmodels[ self.team ].size ] = self;
        }
    }
    else
    {
        level.uavmodels[ self.owner.guid + "_" + gettime() ] = self;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( self.uavtype == "uav" )
        {
            if ( !isdefined( self.owner.activeuavcount ) )
            {
                self.owner.activeuavcount = 0;
            }
            
            self.owner.activeuavcount += 1;
            return;
        }
        
        if ( self.uavtype == "directional_uav" )
        {
            self.owner.var_44f1c37319244499 = 1;
            return;
        }
        
        if ( self.uavtype == "counter_uav" )
        {
            self.owner.var_9605e867634181ab = 1;
        }
    }
}

// Namespace killstreak
// Params 2
// Checksum 0x61d429c3, Offset: 0x19d6
// Size: 0x1af
function removefromuavlistondeath( entnumber, owner )
{
    self waittill( #"death" );
    
    if ( isdefined( self.uavrig ) )
    {
        self.uavrig delete();
    }
    
    if ( level.teambased )
    {
        if ( level.var_f3d1cde89907a07a )
        {
            level.uavmodels[ owner.sessionsquadid ] = function_5713d46873b29625( level.uavmodels[ owner.sessionsquadid ] );
        }
        else
        {
            level.uavmodels[ self.team ] = function_5713d46873b29625( level.uavmodels[ self.team ] );
        }
    }
    else
    {
        level.uavmodels = function_5713d46873b29625( level.uavmodels );
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( self.uavtype == "uav" )
        {
            self.owner.activeuavcount -= 1;
            
            if ( self.owner.activeuavcount <= 0 )
            {
                self.owner.activeuavcount = undefined;
            }
        }
        else if ( self.uavtype == "directional_uav" )
        {
            self.owner.var_44f1c37319244499 = undefined;
        }
        else if ( self.uavtype == "counter_uav" )
        {
            self.owner.var_9605e867634181ab = undefined;
        }
    }
    
    removefromactivekillstreaklist( entnumber );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    level notify( #"uav_update" );
}

// Namespace killstreak
// Params 1
// Checksum 0x5331fcee, Offset: 0x1b8d
// Size: 0x30
function addtoairstrikelist( entnumber )
{
    if ( !isdefined( level.airstrikemodels ) )
    {
        level.airstrikemodels = [];
    }
    
    level.airstrikemodels[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0xf06e75db, Offset: 0x1bc5
// Size: 0x2e
function removefromairstrikelistondeath( entnumber )
{
    self waittill( #"death" );
    level.airstrikemodels[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0x7f9be7d6, Offset: 0x1bfb
// Size: 0x30
function addtolittlebirdlist( entnumber )
{
    if ( !isdefined( level.littlebirds ) )
    {
        level.littlebirds = [];
    }
    
    level.littlebirds[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0x5c28cd90, Offset: 0x1c33
// Size: 0x2e
function removefromlittlebirdlistondeath( entnumber )
{
    self waittill( #"death" );
    level.littlebirds[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0xe3287831, Offset: 0x1c69
// Size: 0x30
function addtohelilist( entnumber )
{
    if ( !isdefined( level.helis ) )
    {
        level.helis = [];
    }
    
    level.helis[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0x95da144, Offset: 0x1ca1
// Size: 0x21
function removefromhelilist( entnumber )
{
    level.helis[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0x4bef314c, Offset: 0x1cca
// Size: 0x2e
function removefromhelilistondeath( entnumber )
{
    self waittill( #"death" );
    level.helis[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0x4ff986df, Offset: 0x1d00
// Size: 0x30
function addtoturretlist( entnumber )
{
    if ( !isdefined( level.turrets ) )
    {
        level.turrets = [];
    }
    
    level.turrets[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0x60c96519, Offset: 0x1d38
// Size: 0x32
function removefromturretlistondeathorcarry( entnumber )
{
    utility::waittill_any( "death", "carried" );
    level.turrets[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 0
// Checksum 0x75807f82, Offset: 0x1d72
// Size: 0x9
function function_45a1150ecedbfbc3()
{
    weapon::registermine();
}

// Namespace killstreak
// Params 1
// Checksum 0xd8fb3c88, Offset: 0x1d83
// Size: 0x29
function function_80d7210dbee48d0a( entnumber )
{
    self waittill( #"death" );
    weapon::deregistermine();
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0x96e90554, Offset: 0x1db4
// Size: 0x30
function function_be0afefdd5f0b7a1( entnumber )
{
    if ( !isdefined( level.dawgs ) )
    {
        level.dawgs = [];
    }
    
    level.dawgs[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0x692bc69d, Offset: 0x1dec
// Size: 0x2e
function function_c96d231cebe1c470( entnumber )
{
    self waittill( #"death" );
    level.dawgs[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0x8f9e3ec2, Offset: 0x1e22
// Size: 0x30
function addtosupportdronelist( entnumber )
{
    if ( !isdefined( level.supportdrones ) )
    {
        level.supportdrones = [];
    }
    
    level.supportdrones[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0xcae924b8, Offset: 0x1e5a
// Size: 0x2e
function removefromsupportdronelistondeath( entnumber )
{
    self waittill( #"death" );
    level.supportdrones[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0xc3bc4119, Offset: 0x1e90
// Size: 0x30
function addtoassaultdronelist( entnumber )
{
    if ( !isdefined( level.assaultdrones ) )
    {
        level.assaultdrones = [];
    }
    
    level.assaultdrones[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0xc9ad86a2, Offset: 0x1ec8
// Size: 0x2e
function removefromassaultdronelistondeath( entnumber )
{
    self waittill( #"death" );
    level.assaultdrones[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0x88021e5f, Offset: 0x1efe
// Size: 0x3b
function addtoprojectilelist( entnumber )
{
    if ( !isdefined( level.projectilekillstreaks ) )
    {
        level.projectilekillstreaks = [];
    }
    
    self.isprojectilekillstreak = 1;
    level.projectilekillstreaks[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0x7886147c, Offset: 0x1f41
// Size: 0x35
function removefromprojectilelistondeath( entnumber )
{
    self waittill( #"death" );
    function_e35316622279e7b3();
    level.projectilekillstreaks[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 1
// Checksum 0xa688b22, Offset: 0x1f7e
// Size: 0x30
function addtoplayerkillstreaklist( entnumber )
{
    if ( !isdefined( level.playerkillstreaks ) )
    {
        level.playerkillstreaks = [];
    }
    
    level.playerkillstreaks[ entnumber ] = self;
}

// Namespace killstreak
// Params 1
// Checksum 0x3f73dd2c, Offset: 0x1fb6
// Size: 0x35
function removefromplayerkillstreaklistondeath( entnumber )
{
    self waittill( #"death" );
    function_e35316622279e7b3();
    level.playerkillstreaks[ entnumber ] = undefined;
    removefromactivekillstreaklist( entnumber );
}

// Namespace killstreak
// Params 9
// Checksum 0x8d843c15, Offset: 0x1ff3
// Size: 0x16a
function setkillstreakcontrolpriority( owner, hintstring, hintdisplayfov, var_17fc8fec71a04755, hintrange, userange, usepriority, var_cd060c54b771be2f, hinticon )
{
    self makeusable();
    
    if ( isdefined( hinticon ) )
    {
        self setcursorhint( "HINT_BUTTON" );
        self sethinticon( hinticon );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
    }
    
    self sethintonobstruction( "show" );
    self sethintstring( hintstring );
    self sethintdisplayfov( hintdisplayfov );
    self setusefov( var_17fc8fec71a04755 );
    self sethintdisplayrange( hintrange );
    self setuserange( userange );
    self setuseholdduration( "duration_short" );
    
    if ( !isdefined( usepriority ) )
    {
        usepriority = -1;
    }
    
    self setusepriority( usepriority );
    level thread applyplayercontrolonconnect( self );
    
    foreach ( player in level.players )
    {
        if ( player == owner && !var_cd060c54b771be2f )
        {
            self enableplayeruse( player );
            continue;
        }
        
        self disableplayeruse( player );
    }
}

// Namespace killstreak
// Params 1
// Checksum 0xff0aa58, Offset: 0x2165
// Size: 0x4e
function applyplayercontrolonconnect( killstreakuseent )
{
    killstreakuseent endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        killstreakuseent disableplayeruse( player );
    }
}

// Namespace killstreak
// Params 2
// Checksum 0xebb1d9c8, Offset: 0x21bb
// Size: 0x164
function applykillstreakplayeroutline( player, streakendnotify )
{
    assert( isdefined( self.owner ), "<dev string:x66>" );
    assert( isdefined( self.team ), "<dev string:xa0>" );
    killstreakteam = self.team;
    killstreakowner = self.owner;
    hudoutlineasset = undefined;
    perkcheck = undefined;
    
    if ( !player player::isreallyalive() || player.team == "spectator" || player.team == "codcaster" )
    {
        return;
    }
    
    if ( player == killstreakowner )
    {
        hudoutlineasset = "outlinefill_depth_cyan";
    }
    else if ( player != killstreakowner )
    {
        if ( level.teambased && player.team != killstreakteam || !level.teambased )
        {
            hudoutlineasset = "outlinefill_depth_orange";
            perkcheck = 1;
        }
        else
        {
            return;
        }
    }
    
    if ( isdefined( hudoutlineasset ) )
    {
        if ( perkcheck )
        {
            if ( isdefined( player.perks[ "specialty_noplayertarget" ] ) )
            {
                return;
            }
        }
        
        id = outline::outlineenableforplayer( player, self.owner, hudoutlineasset, "killstreak" );
        thread watchoutlineremoveonkillstreakend( id, player, streakendnotify );
        thread watchoutlineremoveonplayerend( id, player, streakendnotify );
    }
}

// Namespace killstreak
// Params 3
// Checksum 0x509c2f9, Offset: 0x2327
// Size: 0x47
function watchoutlineremoveonkillstreakend( id, player, streakendnotify )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self waittill( streakendnotify );
    outline::outlinedisable( id, player );
}

// Namespace killstreak
// Params 3
// Checksum 0xf31eaf8c, Offset: 0x2376
// Size: 0x47
function watchoutlineremoveonplayerend( id, player, streakendnotify )
{
    self endon( streakendnotify );
    level endon( #"game_ended" );
    player waittill( #"death_or_disconnect" );
    outline::outlinedisable( id, player );
}

// Namespace killstreak
// Params 7
// Checksum 0xff5a791b, Offset: 0x23c5
// Size: 0x6e
function getmodifieddamageusingdamagetuning( attacker, objweapon, mod, damageamount, maxhealth, var_20cb8f4e47f3353e, data )
{
    modifieddamage = damage_tuning::getmodifieddamageusingdamagetuning( attacker, objweapon, mod, damageamount, maxhealth, var_20cb8f4e47f3353e, data );
    modifieddamage = damage::handleapdamage( objweapon, mod, modifieddamage, attacker );
    return modifieddamage;
}

// Namespace killstreak
// Params 2
// Checksum 0x35573f7e, Offset: 0x243c
// Size: 0x97
function function_f779001cde237dc( weaponname, damagesize )
{
    assert( damagesize == #"oneshot" || damagesize == #"large" || damagesize == #"medium" || damagesize == #"low" || damagesize == #"tick" || damagesize == #"donotregister" );
    
    if ( damagesize == #"donotregister" )
    {
        return;
    }
    
    level.var_4ef5a6a094dcb0a0[ weaponname ] = damagesize;
}

// Namespace killstreak
// Params 11
// Checksum 0xdc371359, Offset: 0x24db
// Size: 0x943
function getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride )
{
    var_9bdf7cb3f330c64e = 0;
    var_41da35cb997c2cc0 = 0;
    
    if ( isdefined( meansofdeath ) )
    {
        switch ( meansofdeath )
        {
            case #"hash_4fb186ef47273ade":
            case #"hash_5f1054c48d66fd1c":
            case #"hash_966768b3f0c94767":
                break;
            case #"hash_3c20f39c73a1422b":
            case #"hash_571e46e17a3cf2e3":
            case #"hash_66cb246f3e55fbe2":
            case #"hash_a5123f4d02745600":
            case #"hash_a86d8c43482948a4":
            case #"hash_a911a1880d996edb":
            case #"hash_c22b13f81bed11f0":
            case #"hash_d8646db4e6ee3658":
                var_41da35cb997c2cc0 = 1;
                break;
            default:
                break;
        }
    }
    
    if ( var_41da35cb997c2cc0 )
    {
        divisor = undefined;
        
        if ( meansofdeath != "MOD_MELEE" )
        {
            damagesize = undefined;
            
            if ( isdefined( level.var_4ef5a6a094dcb0a0 ) && isdefined( objweapon ) )
            {
                damagesize = level.var_4ef5a6a094dcb0a0[ objweapon.basename ];
            }
            
            if ( !isdefined( damagesize ) && isdefined( objweapon ) )
            {
                switch ( objweapon.basename )
                {
                    case #"hash_48cc3a9a58208f82":
                    case #"hash_85ea99fcbe4116a4":
                    case #"hash_aae52fc2913829d0":
                        damagesize = #"oneshot";
                        break;
                    case #"hash_3e782fd775b72022":
                    case #"hash_a273a49e013eb008":
                    case #"hash_e704ecf8710c6f57":
                    case #"hash_c5c19fe9ae40cd0c":
                    case #"hash_13608f01c909bed3":
                    case #"hash_13a265ac820ea0df":
                    case #"hash_4f9064f9a7a4b7d1":
                    case #"hash_1a8f43f197f508a0":
                    case #"hash_7917bb9ef2886e20":
                    case #"hash_7a687f6a4d685110":
                    case #"hash_c124ad09158500e9":
                    case #"hash_1d6b88bde28b109a":
                    case #"hash_fe08358bc8f9a34a":
                    case #"hash_5c272c0617caebf0":
                    case #"hash_1fa9e128f4c7b140":
                    case #"hash_24936ab5bf8a0e20":
                    case #"hash_5cbb3a1a84d47f1d":
                    case #"hash_5e8f81314553dd36":
                    case #"hash_7b6c28c7a47537b7":
                    case #"hash_2f1a9d8e2f127205":
                    case #"hash_a9e31b8ffd42a67b":
                    case #"hash_a54e19ae2e8d865c":
                    case #"hash_348ae4b5cc97ad79":
                    case #"hash_3532a220183691a5":
                    case #"hash_7de9687a97e62d93":
                    case #"hash_f55c20924061bd15":
                    case #"hash_6b9700922cc910a9":
                    case #"hash_cb6c35c79573eb64":
                        damagesize = #"large";
                        break;
                    case #"hash_79ee9dd492804fa":
                    case #"hash_996455d7b14b362":
                    case #"hash_fbca161190fca27d":
                    case #"hash_fc4c0a8ee31549bb":
                    case #"hash_12a2863ecf2eeecd":
                    case #"hash_fd76dc693da26245":
                    case #"hash_fd79e0693da4a728":
                    case #"hash_1ba6982534c8d1d6":
                    case #"hash_1cb3f2dbe85b8540":
                    case #"hash_1ee2bbd1bc80ea9a":
                    case #"hash_254b6e155434f84d":
                    case #"hash_259ae6e25d936c3e":
                    case #"hash_25fc06d658620968":
                    case #"hash_2654d1bcc59b62b6":
                    case #"hash_3226ebed78234b14":
                    case #"hash_33aef56fb95396fd":
                    case #"hash_359ac460bda5f9b8":
                    case #"hash_3f2944fd91792508":
                    case #"hash_471c36daeb2a655a":
                    case #"hash_4e213f6d3f76b400":
                    case #"hash_4fd5d83c1a7f06a7":
                    case #"hash_51f4f5345b01f136":
                    case #"hash_62a9688b69906271":
                    case #"hash_6ac8f418ee829465":
                    case #"hash_708fb6e22f87a3a4":
                    case #"hash_73b4956c8f4b5217":
                    case #"hash_82a5b9368f3f35ae":
                    case #"hash_78ee9dd491b3907":
                    case #"hash_91a48ebfd2d03a40":
                    case #"hash_9386cafe3d8d6d59":
                    case #"hash_9f73f49d822d9acc":
                    case #"hash_a0bfc30978e56904":
                    case #"hash_a622e958420b92a0":
                    case #"hash_a9e5050965551dca":
                    case #"hash_acaf314732f4c8e4":
                    case #"hash_aef479d2af969a2d":
                    case #"hash_af540b603005b109":
                    case #"hash_af7c176030248498":
                    case #"hash_b1d4d0d68c2b0c0f":
                    case #"hash_b4fb660fd7773831":
                    case #"hash_bac656916e53b91c":
                    case #"hash_badacfdae124cc01":
                    case #"hash_c6ea1214797e3ea1":
                    case #"hash_cd6b1f03c24c25ff":
                    case #"hash_cf8515f17748a7d2":
                    case #"hash_d1ffad9819388638":
                    case #"hash_d30fa952a74e1642":
                    case #"hash_d4532f8e0fa86548":
                    case #"hash_d7f368cf53337cfd":
                    case #"hash_892911bfe6164871":
                    case #"hash_e7af9caef1aa7899":
                    case #"hash_e9ee40174ddfa406":
                    case #"hash_ec580a77ee20c7bd":
                    case #"hash_edf51f8e5118b630":
                    case #"hash_ee243b8e513db31d":
                    case #"hash_f003a3dc14dbdf3f":
                    case #"hash_f5f81c45da642380":
                    case #"hash_f816d2efb1dcbed0":
                        damagesize = #"medium";
                        break;
                    case #"hash_e5bd5c73b30f4a5":
                    case #"hash_17c70dc48424ba92":
                    case #"hash_1a9da8a4fac9fde4":
                    case #"hash_81d0787e9a579f3c":
                    case #"hash_d30bcd7e470500f3":
                    case #"hash_6a2e4f9c54756dc7":
                    case #"hash_d6565ec12efca627":
                    case #"hash_996849dc6e47c18f":
                    case #"hash_dd4d572af14a12c2":
                    case #"hash_e36b3928a0e518fa":
                    case #"hash_6547ec525f1340da":
                    case #"hash_8c12df11df01f306":
                    case #"hash_56ee829cc162271a":
                    case #"hash_c3639c6f29cf149a":
                    case #"hash_c4b9b21ecac2ced4":
                    case #"hash_1e6ad4ef0904a0f1":
                    case #"hash_5e4ccaa178cac19c":
                    case #"hash_4b87af60037f526f":
                    case #"hash_435258fc47768fa7":
                    case #"hash_cce14c95e4764532":
                    case #"hash_a009d256608f52ce":
                    case #"hash_ca48d454faafb042":
                        damagesize = #"low";
                        break;
                    case #"hash_104394c101679f9e":
                    case #"hash_a49fac234083ff01":
                    case #"hash_d78eda24c2fd8252":
                    case #"hash_b8c7008e1d8543df":
                    case #"hash_4c7de5619284e175":
                    case #"hash_8fd6158eb96a1f15":
                        damagesize = #"tick";
                        break;
                }
            }
        }
        else
        {
            damagesize = #"melee";
        }
        
        if ( isdefined( damagesize ) )
        {
            if ( damagesize == #"oneshot" )
            {
                self.largeprojectiledamage = 1;
                self.killoneshot = 1;
                divisor = 1;
            }
            else if ( damagesize == #"large" )
            {
                self.largeprojectiledamage = 1;
                divisor = divisorlrg;
            }
            else if ( damagesize == #"medium" )
            {
                self.largeprojectiledamage = 1;
                divisor = divisormed;
            }
            else if ( damagesize == #"low" )
            {
                self.largeprojectiledamage = 0;
                divisor = divisorlow;
            }
            else if ( damagesize == #"tick" )
            {
                self.largeprojectiledamage = 0;
                divisor = divisortick;
            }
            else if ( damagesize == #"melee" )
            {
                self.largeprojectiledamage = 0;
                divisor = divisormelee;
            }
        }
        
        /#
            if ( divisor )
            {
                assert( isdefined( maxhealth ), "<dev string:xd9>" );
            }
        #/
        
        if ( isdefined( divisor ) && isdefined( maxhealth ) )
        {
            amount = ceil( maxhealth / divisor );
            var_9bdf7cb3f330c64e = 1;
        }
    }
    
    if ( isdefined( explodeoverride ) )
    {
        self.largeprojectiledamage = explodeoverride;
    }
    
    var_215f461ee332af42 = 0;
    
    /#
        var_215f461ee332af42 = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    if ( !var_9bdf7cb3f330c64e && isdefined( objweapon ) )
    {
        amount = damage::handleshotgundamage( objweapon, meansofdeath, amount );
        amount = damage::handleapdamage( objweapon, meansofdeath, amount, attacker );
        amount = damage::function_a8689e5a2448ca1( amount, objweapon, attacker, meansofdeath );
        amount = damage::function_8280f3321b0c7d40( amount, objweapon, attacker );
    }
    
    if ( isdefined( attacker ) && isdefined( self.owner ) && !var_215f461ee332af42 )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
        
        if ( attacker == self.owner && !self.killoneshot )
        {
            amount = ceil( amount / 2 );
        }
    }
    
    return int( amount );
}

// Namespace killstreak
// Params 1
// Checksum 0x6ea673b6, Offset: 0x2e27
// Size: 0x18, Type: bool
function nulldamagecheck( attacker )
{
    return attacker == self.owner;
}

// Namespace killstreak
// Params 7
// Checksum 0xa6ac9d5f, Offset: 0x2e48
// Size: 0x16d
function dodamagetokillstreak( damage, attacker, inflictor, victimteam, sourceorigin, meansofdeath, weaponname )
{
    direction_vec = ( 0, 0, 0 );
    point = ( 0, 0, 0 );
    angles = ( 0, 0, 0 );
    normal = ( 0, 0, 0 );
    modelname = "";
    tagname = "";
    partname = "";
    idflags = undefined;
    
    if ( isdefined( victimteam ) )
    {
        if ( level.teambased )
        {
            if ( !entity::isvalidteamtarget( attacker, victimteam, self ) )
            {
                return;
            }
        }
        else if ( !entity::isvalidffatarget( attacker, victimteam, self ) )
        {
            return;
        }
    }
    
    if ( isagent( self ) )
    {
        self dodamage( damage, sourceorigin, attacker, inflictor, meansofdeath, weaponname );
        return;
    }
    
    if ( vehicle::is_vehicle() )
    {
        self dodamage( damage, sourceorigin, attacker, inflictor, meansofdeath, weaponname );
        return;
    }
    
    weapon = makeweaponfromstring( weaponname );
    self notify( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, sourceorigin, angles, normal, inflictor );
}

// Namespace killstreak
// Params 2
// Checksum 0xca54bc74, Offset: 0x2fbd
// Size: 0xea
function playdlightfx( posoffset, angleoffset )
{
    self endon( #"death" );
    
    if ( !isdefined( posoffset ) )
    {
        posoffset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( angleoffset ) )
    {
        angleoffset = ( 0, 0, 0 );
    }
    
    dlightfx = utility::getfx( "dlight_large" );
    
    if ( self.isairdrop )
    {
        dlightfx = utility::getfx( "dlight_small" );
    }
    
    self.fxdlightent = spawn( "script_model", self.origin );
    self.fxdlightent setmodel( "tag_origin" );
    self.fxdlightent linkto( self, "tag_origin", posoffset, angleoffset );
    self.fxdlightent thread deleteonparentdeath( self );
    wait 0.1;
    playfxontag( dlightfx, self.fxdlightent, "tag_origin" );
}

// Namespace killstreak
// Params 1
// Checksum 0x23ff459f, Offset: 0x30af
// Size: 0x31
function deleteonparentdeath( parent )
{
    self endon( #"death" );
    parent waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x1fc75ad6, Offset: 0x30e8
// Size: 0x32, Type: bool
function isaffectedbyblindeye( killstreakname )
{
    switch ( killstreakname )
    {
        case #"hash_576b868dbf9eab17":
        case #"hash_8b0d967838e55b97":
            return true;
    }
    
    return false;
}

// Namespace killstreak
// Params 3
// Checksum 0xa56698f5, Offset: 0x3123
// Size: 0x102
function function_7acb73c1355e75ce( attacker, killstreakowner, killstreakinfo )
{
    victim = self;
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    if ( !isdefined( killstreakowner ) )
    {
        return;
    }
    
    if ( !isdefined( killstreakinfo ) )
    {
        return;
    }
    
    if ( !isdefined( damage::_validateattacker( attacker ) ) )
    {
        return;
    }
    
    victim_team = victim.team ?? victim.agentteam;
    var_5a3cfe554c96d512 = victim_team == attacker.team;
    
    if ( var_5a3cfe554c96d512 )
    {
        return;
    }
    
    if ( attacker == killstreakowner )
    {
        if ( !isdefined( killstreakinfo.debuffkills ) )
        {
            killstreakinfo.debuffkills = 0;
        }
        
        killstreakinfo.debuffkills++;
        return;
    }
    
    if ( attacker.team == killstreakowner.team )
    {
        if ( !isdefined( killstreakinfo.debuffassists ) )
        {
            killstreakinfo.debuffassists = 0;
        }
        
        killstreakinfo.debuffassists++;
    }
}

// Namespace killstreak
// Params 3
// Checksum 0xf22a77c1, Offset: 0x322d
// Size: 0xa0
function function_b700fb2ad0fa69e9( victim, var_9e937bb145d126d3, killstreakinfo )
{
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    if ( !isdefined( var_9e937bb145d126d3 ) )
    {
        return;
    }
    
    if ( !isdefined( killstreakinfo ) )
    {
        return;
    }
    
    victim_team = victim.team ?? victim.agentteam;
    var_5a3cfe554c96d512 = victim_team == var_9e937bb145d126d3.team;
    
    if ( var_5a3cfe554c96d512 )
    {
        return;
    }
    
    if ( !isdefined( killstreakinfo.destructions ) )
    {
        killstreakinfo.destructions = 0;
    }
    
    killstreakinfo.destructions++;
}

// Namespace killstreak
// Params 1
// Checksum 0x21b0a7af, Offset: 0x32d5
// Size: 0x92
function watchsupertrophynotify( owner )
{
    owner endon( #"disconnect" );
    self endon( #"explode" );
    
    while ( true )
    {
        owner waittill( #"hash_e48f56f6b662855f", trophyowner, trophyweaponname, targetweaponname, targetorigin, targetangles );
        
        if ( targetweaponname != self.weapon_name )
        {
            continue;
        }
        
        owner damagefeedback::updatedamagefeedback( "" );
        break;
    }
}

// Namespace killstreak
// Params 3
// Checksum 0x28c6eac5, Offset: 0x336f
// Size: 0x104
function watchhostmigrationlifetime( var_7e6667fe856c7a51, lifetime, lifetimefunc )
{
    if ( var_7e6667fe856c7a51 != "death" )
    {
        self endon( #"death" );
    }
    
    self endon( var_7e6667fe856c7a51 );
    level endon( #"game_ended" );
    startinglifetime = gettime() + int( lifetime * 1000 );
    level waittill( #"host_migration_begin" );
    self notify( #"hash_c57511ed0c340dae" );
    hoststarttime = gettime();
    remaininglifetime = startinglifetime - hoststarttime;
    level waittill( #"host_migration_end" );
    hostendtime = gettime();
    newtime = hostendtime + remaininglifetime;
    remaininglifetime /= 1000;
    
    if ( isdefined( self.streakname ) && killstreak_utility::isridekillstreak( self.streakname ) )
    {
        self.owner setclientomnvar( "ui_killstreak_countdown", newtime );
    }
    
    self [[ lifetimefunc ]]( remaininglifetime );
}

// Namespace killstreak
// Params 1
// Checksum 0x531972b5, Offset: 0x347b
// Size: 0x9c
function getenemytargets( owner )
{
    enemytargets = [];
    
    foreach ( player in level.players )
    {
        if ( owner player_utility::isenemy( player ) )
        {
            enemytargets[ enemytargets.size ] = player;
        }
    }
    
    return enemytargets;
}

// Namespace killstreak
// Params 4
// Checksum 0x17677863, Offset: 0x3520
// Size: 0x15f
function _beginlocationselection( streakname, selectortype, var_fcc5b8f63709e0ee, size )
{
    self beginlocationselection( selectortype, var_fcc5b8f63709e0ee, "circle_marker", size );
    self.selectinglocation = 1;
    self setblurforplayer( 10.3, 0.3 );
    thread endselectiononaction( "cancel_location" );
    thread endselectiononaction( "death" );
    thread endselectiononaction( "disconnect" );
    thread endselectiononaction( "used" );
    thread endselectiononaction( "weapon_change" );
    self endon( #"hash_de79ac7f3d2be058" );
    thread endselectiononendgame();
    
    if ( isdefined( streakname ) && self.team != "spectator" && self.team != "codcaster" )
    {
        if ( isdefined( self.streakmsg ) )
        {
            self.streakmsg destroy();
        }
        
        if ( self issplitscreenplayer() )
        {
            self.streakmsg = hud_util::createfontstring( "default", 1.3 );
            self.streakmsg hud_util::setpoint( "CENTER", "CENTER", 0, -98 );
            return;
        }
        
        self.streakmsg = hud_util::createfontstring( "default", 1.6 );
        self.streakmsg hud_util::setpoint( "CENTER", "CENTER", 0, -190 );
    }
}

// Namespace killstreak
// Params 2
// Checksum 0x9486f009, Offset: 0x3687
// Size: 0x6c
function stoplocationselection( disconnected, reason = "generic" )
{
    if ( !disconnected )
    {
        self setblurforplayer( 0, 0.3 );
        self endlocationselection();
        self.selectinglocation = undefined;
        
        if ( isdefined( self.streakmsg ) )
        {
            self.streakmsg destroy();
        }
    }
    
    self notify( #"hash_de79ac7f3d2be058", reason );
}

// Namespace killstreak
// Params 1
// Checksum 0xe0dd1ed6, Offset: 0x36fb
// Size: 0x2e
function endselectiononaction( waitfor )
{
    self endon( #"hash_de79ac7f3d2be058" );
    self waittill( waitfor );
    thread stoplocationselection( waitfor == "disconnect", waitfor );
}

// Namespace killstreak
// Params 0
// Checksum 0xcef054a4, Offset: 0x3731
// Size: 0x28
function endselectiononendgame()
{
    self endon( #"hash_de79ac7f3d2be058" );
    level waittill( #"game_ended" );
    thread stoplocationselection( 0, "end_game" );
}

// Namespace killstreak
// Params 1
// Checksum 0x4a202895, Offset: 0x3761
// Size: 0x46, Type: bool
function streakshouldchain( streakname )
{
    var_b91de1d16961c644 = killstreaks::calcstreakcost( streakname );
    nextstreakname = killstreaks::getnextstreakname();
    nextstreakcost = killstreaks::calcstreakcost( nextstreakname );
    return var_b91de1d16961c644 < nextstreakcost;
}

// Namespace killstreak
// Params 2
// Checksum 0xa28d5f08, Offset: 0x37b0
// Size: 0x5f
function streakcheckistargetindoors( targetpos, ignorelist )
{
    isindoors = 0;
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    if ( !trace::ray_trace_passed( targetpos, targetpos + ( 0, 0, 10000 ), ignorelist, contents ) )
    {
        isindoors = 1;
    }
    
    return isindoors;
}

// Namespace killstreak
// Params 1
// Checksum 0xf2eea867, Offset: 0x3818
// Size: 0x44
function function_e8fd44aed0b7e44f( streakname )
{
    var_e8fd44aed0b7e44f = 0;
    
    switch ( streakname )
    {
        case #"hash_472d8b6c2f51a9c8":
        case #"hash_4d35eb58f9d545f0":
            var_e8fd44aed0b7e44f = 1;
            break;
    }
    
    return var_e8fd44aed0b7e44f;
}

// Namespace killstreak
// Params 1
// Checksum 0xcf3e3b33, Offset: 0x3865
// Size: 0x16d
function isremotekillstreak( streak )
{
    if ( isstring( streak ) )
    {
        bundle = level.streakglobals.streakbundles[ streak ];
        
        if ( isdefined( bundle ) && bundle.isremotekillstreak )
        {
            return 1;
        }
    }
    
    if ( isstruct( streak ) )
    {
        return streak.bundle.isremotekillstreak;
    }
    
    streakname = streak;
    
    if ( !isdefined( streakname ) )
    {
        return 0;
    }
    
    remotekillstreak = 0;
    
    switch ( streakname )
    {
        case #"hash_1b2a5d618e12f1c":
        case #"hash_11368ff3af541278":
        case #"hash_1fd582647e25c2c1":
        case #"hash_28d0236400e33fd0":
        case #"hash_3188799009d92bfe":
        case #"hash_349713b5ad494dda":
        case #"hash_363a333139801cbd":
        case #"hash_3cf911edc78eff33":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_568092dc521d2e1d":
        case #"hash_59aa7e461fc04a44":
        case #"hash_76e78a4e69f5d4f7":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_ab5712e297cd430e":
        case #"hash_bc14c03f08cfdfbd":
        case #"hash_c45eaeb429cf1944":
        case #"hash_cf0ef5bef19a311b":
            remotekillstreak = 1;
            break;
    }
    
    return remotekillstreak;
}

// Namespace killstreak
// Params 1
// Checksum 0xd964d28b, Offset: 0x39db
// Size: 0x5c
function isuavkillstreak( streakname )
{
    isuav = 0;
    
    switch ( streakname )
    {
        case #"hash_10e585c25e7e9f60":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
        case #"hash_e51f2e3d5cdd8ed8":
            isuav = 1;
            break;
    }
    
    return isuav;
}

// Namespace killstreak
// Params 1
// Checksum 0x65570d69, Offset: 0x3a40
// Size: 0x98
function isairstrikekillstreak( streakname )
{
    isairstrike = 0;
    
    switch ( streakname )
    {
        case #"hash_195360490caa3220":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_4220be38a5f150b8":
        case #"hash_568092dc521d2e1d":
        case #"hash_62810d05099e0103":
        case #"hash_7a687f6a4d685110":
        case #"hash_8c766d6477287bb6":
        case #"hash_a1031216158c7882":
        case #"hash_b161e185f1b8e117":
            isairstrike = 1;
            break;
    }
    
    return isairstrike;
}

// Namespace killstreak
// Params 1
// Checksum 0x55e594b2, Offset: 0x3ae1
// Size: 0x44
function islittlebirdkillstreak( streakname )
{
    islittlebird = 0;
    
    switch ( streakname )
    {
        case #"hash_2289ec11d77bce8f":
        case #"hash_56979e0566996b2e":
            islittlebird = 1;
            break;
    }
    
    return islittlebird;
}

// Namespace killstreak
// Params 1
// Checksum 0x3782a847, Offset: 0x3b2e
// Size: 0x68
function ishelikillstreak( streakname )
{
    isheli = 0;
    
    switch ( streakname )
    {
        case #"hash_bf2f9adbd2b41d5":
        case #"hash_349713b5ad494dda":
        case #"hash_363a333139801cbd":
        case #"hash_887ad77192b9c4fb":
        case #"hash_c45eaeb429cf1944":
            isheli = 1;
            break;
    }
    
    return isheli;
}

// Namespace killstreak
// Params 1
// Checksum 0xeed6953c, Offset: 0x3b9f
// Size: 0x80
function isturretkillstreak( streakname )
{
    isturret = 0;
    
    switch ( streakname )
    {
        case #"hash_ca256b5fd9d5adf":
        case #"hash_19dd9a3a4147e09e":
        case #"hash_4d5aa76e8707f47b":
        case #"hash_52d9b7ed584bec3e":
        case #"hash_ab5712e297cd430e":
        case #"hash_b571a6187bf67f9e":
        case #"hash_bf9dfeadd230a5a9":
            isturret = 1;
            break;
    }
    
    return isturret;
}

// Namespace killstreak
// Params 1
// Checksum 0xe68cd724, Offset: 0x3c28
// Size: 0x68
function isprojectilekillstreak( streakname )
{
    isprojectile = 0;
    
    switch ( streakname )
    {
        case #"hash_28d0236400e33fd0":
        case #"hash_568092dc521d2e1d":
        case #"hash_6362d6aae3e5a62e":
        case #"hash_7a687f6a4d685110":
        case #"hash_b4ac3581c343a029":
            isprojectile = 1;
            break;
    }
    
    return isprojectile;
}

// Namespace killstreak
// Params 1
// Checksum 0xaf900ab8, Offset: 0x3c99
// Size: 0x44
function issupportdronekillstreak( streakname )
{
    var_1267f0672e65bc29 = 0;
    
    switch ( streakname )
    {
        case #"hash_27002778019fb447":
        case #"hash_e40585107590f016":
            var_1267f0672e65bc29 = 1;
            break;
    }
    
    return var_1267f0672e65bc29;
}

// Namespace killstreak
// Params 1
// Checksum 0xb3894841, Offset: 0x3ce6
// Size: 0x47
function function_17736ca3e3ad4382( streakname )
{
    if ( !streakname )
    {
        return 0;
    }
    
    switch ( streakname )
    {
        case #"hash_8ef5b52c9e784884":
        case #"hash_e40585107590f016":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x5b2d72ad, Offset: 0x3d35
// Size: 0x44
function isassaultdronekillstreak( streakname )
{
    isassaultdrone = 0;
    
    switch ( streakname )
    {
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_cf0ef5bef19a311b":
            isassaultdrone = 1;
            break;
    }
    
    return isassaultdrone;
}

// Namespace killstreak
// Params 1
// Checksum 0x85878004, Offset: 0x3d82
// Size: 0x1d, Type: bool
function iscarepackage( ent )
{
    return ent.id == "care_package";
}

// Namespace killstreak
// Params 0
// Checksum 0x99a12ded, Offset: 0x3da8
// Size: 0x12, Type: bool
function function_2512509a946854ce()
{
    return isjuggernaut() || function_27766a07ce1d112a();
}

// Namespace killstreak
// Params 0
// Checksum 0x85440c45, Offset: 0x3dc3
// Size: 0xc, Type: bool
function isjuggernaut()
{
    return istrue( self.isjuggernaut );
}

// Namespace killstreak
// Params 0
// Checksum 0xcacf205, Offset: 0x3dd8
// Size: 0xc, Type: bool
function function_27766a07ce1d112a()
{
    return isdefined( self.var_3743638e74262366 );
}

// Namespace killstreak
// Params 0
// Checksum 0xc02db3a8, Offset: 0x3ded
// Size: 0xc, Type: bool
function ismutantinjection()
{
    return istrue( self.ismutantinjection );
}

// Namespace killstreak
// Params 1
// Checksum 0xcdcbbb4d, Offset: 0x3e02
// Size: 0x1f, Type: bool
function function_f2ba3c00491f1185( streakname )
{
    if ( !isai( self ) )
    {
        return false;
    }
    
    return streakname == "dawg";
}

// Namespace killstreak
// Params 1
// Checksum 0xe0432d50, Offset: 0x3e2a
// Size: 0x87
function isflyingkillstreak( streakname )
{
    switch ( streakname )
    {
        case #"hash_13353c75b92b3fcc":
        case #"hash_26a12ee6db5cd83c":
        case #"hash_2916b409ed596650":
        case #"hash_413c38e72fe8b5bf":
        case #"hash_56979e0566996b2e":
        case #"hash_8c766d6477287bb6":
        case #"hash_d5cb9b4efa4e54b6":
        case #"hash_ea61c6ba128ead64":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x80c83e20, Offset: 0x3eb9
// Size: 0xd7, Type: bool
function getkillstreakcost( streakname )
{
    bundle = function_85b2d8e857ab4898( streakname );
    
    if ( !bundle )
    {
        return false;
    }
    
    cost = bundle.kills;
    
    if ( level.gamemodebundle.streaktypeenabled )
    {
        streaktype = killstreaks::getstreaktype();
        cost = getscriptbundlefieldvalue( bundle.var_d80db24c90d421fb, streaktype.cost_field );
    }
    else if ( isdefined( self.perks[ "specialty_killstreak_to_scorestreak" ] ) && streakname != "nuke" )
    {
        cost = bundle.scorecost;
    }
    else if ( isdefined( self.perks[ "specialty_support_killstreaks" ] ) )
    {
        cost = bundle.supportcost;
    }
    
    return cost ?? 0;
}

// Namespace killstreak
// Params 2
// Checksum 0x5e0b314b, Offset: 0x3f99
// Size: 0x25d
function function_5dc4f0799a3948b8( streakname, cost )
{
    if ( isdefined( level.killstreak_escalation.overrides ) )
    {
        foreach ( override in level.killstreak_escalation.overrides )
        {
            if ( streakname == override.ref && isdefined( override.cost ) )
            {
                return override.cost;
            }
        }
    }
    
    if ( isdefined( self.var_9dd169071832cb54[ streakname ] ) )
    {
        foreach ( value in self.var_9dd169071832cb54[ streakname ].values )
        {
            if ( value < cost )
            {
                cost = value;
            }
        }
    }
    
    if ( isdefined( self.perks[ "specialty_hardline" ] ) && cost > 0 )
    {
        if ( isdefined( self.var_c81ed234731dd25a ) && arraycontains( self.var_c81ed234731dd25a, streakname ) )
        {
            if ( cost && getdvarfloat( @"hash_43017d2e803cc731", 1 ) != 1 )
            {
                cost = function_59f83d347c4e3afd( cost );
            }
            
            return cost;
        }
        
        if ( isdefined( self.perks[ "specialty_killstreak_to_scorestreak" ] ) )
        {
            if ( arraycontains( getarraykeys( self.var_897084b42d897956 ), streakname ) )
            {
                cost = self.var_897084b42d897956[ streakname ];
            }
        }
        else if ( arraycontains( getarraykeys( self.var_a336e68c123b86b2 ), streakname ) )
        {
            cost = self.var_a336e68c123b86b2[ streakname ];
        }
    }
    
    if ( cost && getdvarfloat( @"hash_43017d2e803cc731", 1 ) != 1 )
    {
        cost = function_59f83d347c4e3afd( cost );
    }
    
    return cost;
}

// Namespace killstreak
// Params 1, eflags: 0x4
// Checksum 0xb0744d0f, Offset: 0x41ff
// Size: 0x6b
function private function_59f83d347c4e3afd( cost )
{
    if ( isdefined( self.perks[ "specialty_killstreak_to_scorestreak" ] ) )
    {
        return max( 10, int( round( getdvarfloat( @"hash_43017d2e803cc731", 1 ) * cost * 0.1 ) ) * 10 );
    }
    
    return max( 1, int( getdvarfloat( @"hash_43017d2e803cc731", 1 ) * cost ) );
}

// Namespace killstreak
// Params 1
// Checksum 0x368c13, Offset: 0x4273
// Size: 0x4e
function getkillstreakoverheadicon( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return "";
    }
    
    return bundle.overheadicon ?? "";
}

// Namespace killstreak
// Params 1
// Checksum 0xd5900538, Offset: 0x42ca
// Size: 0x43, Type: bool
function function_debef5ec569c4557( streakname )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( bundle ) )
    {
        return false;
    }
    
    return istrue( bundle.var_108bb2cc215e8361 );
}

// Namespace killstreak
// Params 1
// Checksum 0x83cfbb93, Offset: 0x4316
// Size: 0xe3
function currentactivevehiclecount( extra = 0 )
{
    count = extra;
    
    if ( isdefined( level.helis ) )
    {
        count += level.helis.size;
    }
    
    if ( isdefined( level.littlebirds ) )
    {
        count += level.littlebirds.size;
    }
    
    if ( isdefined( level.ugvs ) )
    {
        count += level.ugvs.size;
    }
    
    if ( isdefined( level.bradley ) && isdefined( level.bradley.vehicles ) )
    {
        count += level.bradley.size;
    }
    
    if ( isdefined( level.supportdrones ) )
    {
        count += level.supportdrones.size;
    }
    
    if ( isdefined( level.assaultdrones ) )
    {
        count += level.assaultdrones.size;
    }
    
    return count;
}

// Namespace killstreak
// Params 0
// Checksum 0x33a237b1, Offset: 0x4402
// Size: 0x4
function maxvehiclesallowed()
{
    return 16;
}

// Namespace killstreak
// Params 0
// Checksum 0x13e9fb75, Offset: 0x440f
// Size: 0xb
function fauxvehiclecount()
{
    return level.fauxvehiclecount;
}

// Namespace killstreak
// Params 1
// Checksum 0x79f280bc, Offset: 0x4423
// Size: 0x35
function incrementfauxvehiclecount( value )
{
    if ( !isdefined( value ) )
    {
        level.fauxvehiclecount++;
        return;
    }
    
    level.fauxvehiclecount += value;
}

// Namespace killstreak
// Params 1
// Checksum 0x81dc5c3c, Offset: 0x4460
// Size: 0x4d
function decrementfauxvehiclecount( value )
{
    if ( !isdefined( value ) )
    {
        level.fauxvehiclecount--;
    }
    else
    {
        level.fauxvehiclecount -= value;
    }
    
    if ( level.fauxvehiclecount < 0 )
    {
        level.fauxvehiclecount = 0;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x5a7b432, Offset: 0x44b5
// Size: 0x4b
function isassaultkillstreak( refstring )
{
    switch ( refstring )
    {
        case #"hash_26a12ee6db5cd83c":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x4422399, Offset: 0x4508
// Size: 0x6f
function isresourcekillstreak( refstring )
{
    switch ( refstring )
    {
        case #"hash_155f01fe111e3395":
        case #"hash_283643e4f79541f8":
        case #"hash_36653f7e35d0878d":
        case #"hash_6969314db2c192ea":
        case #"hash_c244f66a067b8deb":
        case #"hash_c72f9e2dc5fac20b":
            return 1;
        default:
            return 0;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0xecd9c57f, Offset: 0x457f
// Size: 0xd, Type: bool
function issupportkillstreak( refstring )
{
    return false;
}

// Namespace killstreak
// Params 1
// Checksum 0x44b18a24, Offset: 0x4595
// Size: 0xd, Type: bool
function isspecialistkillstreak( refstring )
{
    return false;
}

// Namespace killstreak
// Params 0
// Checksum 0x4b760e0f, Offset: 0x45ab
// Size: 0xf
function gethelipilotmeshoffset()
{
    return ( 0, 0, 5000 );
}

// Namespace killstreak
// Params 0
// Checksum 0xa3b861cb, Offset: 0x45c3
// Size: 0xf
function gethelipilottraceoffset()
{
    return ( 0, 0, 2500 );
}

// Namespace killstreak
// Params 1
// Checksum 0x165e8aa0, Offset: 0x45db
// Size: 0x1b
function isnavmeshkillstreak( streakname )
{
    requiresnavmesh = 0;
    return requiresnavmesh;
}

// Namespace killstreak
// Params 0
// Checksum 0x8141b605, Offset: 0x45ff
// Size: 0x16, Type: bool
function iscontrollingproxyagent()
{
    if ( isalive( self.playerproxyagent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreak
// Params 1
// Checksum 0x1c8e6c94, Offset: 0x461e
// Size: 0x81, Type: bool
function killshouldaddtokillstreak( objweapon )
{
    if ( isbrgamemode() )
    {
        return true;
    }
    
    if ( isdefined( self.perks[ "specialty_explosivebullets" ] ) )
    {
        return false;
    }
    
    if ( weapon::iskillstreakweapon( objweapon.basename ) && !weapon::function_1344ad15d2d7bd21( objweapon.basename ) )
    {
        return false;
    }
    
    if ( level.var_4ee6fb337a3c7ac[ objweapon.basename ] )
    {
        return false;
    }
    
    if ( !points::function_1e926c5e888a364b( objweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace killstreak
// Params 0
// Checksum 0x9078987, Offset: 0x46a8
// Size: 0x24
function getairdropcrates()
{
    if ( isdefined( level.cratedata ) )
    {
        return level.cratedata.crates;
    }
    
    return [];
}

// Namespace killstreak
// Params 0
// Checksum 0x4c49732f, Offset: 0x46d5
// Size: 0x25
function getnumairdropcrates()
{
    if ( isdefined( level.cratedata ) )
    {
        return level.cratedata.crates.size;
    }
    
    return 0;
}

// Namespace killstreak
// Params 0
// Checksum 0xa9be712c, Offset: 0x4703
// Size: 0x45, Type: bool
function attackerinremotekillstreak()
{
    if ( !self )
    {
        return false;
    }
    
    if ( self == level.gunshipplayer )
    {
        return true;
    }
    
    if ( self == level.chopper.gunner )
    {
        return true;
    }
    
    if ( self.using_remote_tank )
    {
        return true;
    }
    
    return false;
}

// Namespace killstreak
// Params 4
// Checksum 0x8977ac40, Offset: 0x4751
// Size: 0x9a
function killstreak_make_vehicle( streakname, scorepopup, vodestroyed, destroyedsplash )
{
    self.vehiclename = streakname;
    self.scorepopup = scorepopup;
    self.vodestroyed = vodestroyed;
    self.destroyedsplash = destroyedsplash;
    self enableplayermarks( #"killstreak" );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( self.team );
    }
    else
    {
        self filteroutplayermarks( self.owner );
    }
    
    vehicle_damage::get_vehicle_mod_damage_data( streakname, 1 );
}

// Namespace killstreak
// Params 0
// Checksum 0x32a4e41f, Offset: 0x47f3
// Size: 0x44
function killstreak_vehicle_callback_init()
{
    if ( !level.kscallbackinitcomplete )
    {
        level.kscallbackinitcomplete = 1;
        level.kspremoddamagecallback = &killstreak_pre_mod_damage_callback;
        level.kspostmoddamagecallback = &killstreak_post_mod_damage_callback;
        level.ksdeathcallback = &killstreak_death_callback;
    }
}

// Namespace killstreak
// Params 1
// Checksum 0x53f40369, Offset: 0x483f
// Size: 0xc7
function killstreak_pre_mod_damage_callback( data )
{
    damage = data.damage;
    attacker = data.attacker;
    
    if ( !self.killoneshot && !self.debugdamage && data.meansofdeath != "MOD_CRUSH" )
    {
        if ( attacker == self.owner )
        {
            damage = int( ceil( damage * 0.5 ) );
        }
        
        data.damage = damage;
    }
    
    shouldcontinue = 1;
    premoddamagecallback = self.kspremoddamagecallback;
    
    if ( isdefined( premoddamagecallback ) )
    {
        shouldcontinue = self [[ premoddamagecallback ]]( data );
    }
    
    return shouldcontinue;
}

// Namespace killstreak
// Params 1
// Checksum 0x2c1fab96, Offset: 0x490f
// Size: 0x74
function killstreak_post_mod_damage_callback( data )
{
    killstreaks::killstreakhit( data.attacker, data.objweapon, self, data.meansofdeath, data.damage, data );
    shouldcontinue = 1;
    postmoddamagecallback = self.kspostmoddamagecallback;
    
    if ( isdefined( postmoddamagecallback ) )
    {
        shouldcontinue = self [[ postmoddamagecallback ]]( data );
    }
    
    return shouldcontinue;
}

// Namespace killstreak
// Params 1
// Checksum 0xc8e9d194, Offset: 0x498c
// Size: 0xb3
function killstreak_death_callback( data )
{
    damage::onkillstreakkilled( self.streakname, data.attacker, data.objweapon, data.meansofdeath, data.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash, self.skipdeathnotify, { #inflictor:data.inflictor } );
    shouldcontinue = 1;
    deathcallback = self.ksdeathcallback;
    
    if ( isdefined( deathcallback ) )
    {
        shouldcontinue = self [[ deathcallback ]]( data );
    }
    
    return shouldcontinue;
}

// Namespace killstreak
// Params 2
// Checksum 0x5b0e4702, Offset: 0x4a48
// Size: 0x39
function killstreak_set_pre_mod_damage_callback( streakname, premoddamagecallback )
{
    killstreak_vehicle_callback_init();
    damage::set_pre_mod_damage_callback( streakname, level.kspremoddamagecallback );
    self.kspremoddamagecallback = premoddamagecallback;
}

// Namespace killstreak
// Params 2
// Checksum 0xfd493c2a, Offset: 0x4a89
// Size: 0x39
function killstreak_set_post_mod_damage_callback( streakname, postmoddamagecallback )
{
    killstreak_vehicle_callback_init();
    damage::set_post_mod_damage_callback( streakname, level.kspostmoddamagecallback );
    self.kspostmoddamagecallback = postmoddamagecallback;
}

// Namespace killstreak
// Params 2
// Checksum 0x7fb6207f, Offset: 0x4aca
// Size: 0x39
function killstreak_set_death_callback( streakname, deathcallback )
{
    killstreak_vehicle_callback_init();
    damage::set_death_callback( streakname, level.ksdeathcallback );
    self.ksdeathcallback = deathcallback;
}

// Namespace killstreak
// Params 2
// Checksum 0x888f5d86, Offset: 0x4b0b
// Size: 0x1f
function function_ca92421b98cb1c5( streakname, var_b0f8c9baf11cb3dc )
{
    damage::register_additional_death_callback( streakname, var_b0f8c9baf11cb3dc );
}

// Namespace killstreak
// Params 1
// Checksum 0x4abe2d4f, Offset: 0x4b32
// Size: 0x21
function getkillstreaknamefromweapon( objweapon )
{
    return level.killstreakweaponmap[ objweapon.basename ];
}

// Namespace killstreak
// Params 2
// Checksum 0x9c7c9eab, Offset: 0x4b5c
// Size: 0xe7, Type: bool
function doesstreakinfomatchequippedstreak( streakinfo, slot )
{
    if ( !isdefined( streakinfo ) )
    {
        return false;
    }
    
    if ( !isdefined( self.streakdata ) )
    {
        return false;
    }
    
    if ( !isdefined( self.streakdata.streaks[ slot ] ) )
    {
        return false;
    }
    
    streakdata = self.streakdata.streaks[ slot ];
    
    if ( !( isdefined( streakinfo.streakname ) && isdefined( streakdata.streakname ) ) || streakinfo.streakname != streakdata.streakname )
    {
        return false;
    }
    
    if ( !( isdefined( streakinfo.id ) && isdefined( streakdata.uniqueid ) ) || streakinfo.id != streakdata.uniqueid )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace killstreak
    // Params 1
    // Checksum 0x4d6ba2bd, Offset: 0x4c4c
    // Size: 0x1ac, Type: dev
    function function_80129b729abf4fed( streakname )
    {
        level endon( #"game_ended" );
        devdvar = @"hash_b4fe29a00bfde823";
        setdevdvarifuninitialized( devdvar, 0 );
        
        while ( isdefined( self ) )
        {
            debugdamage = getdvarint( devdvar, 0 );
            
            if ( !debugdamage )
            {
                if ( self.debugdamage )
                {
                    self.debugdamage = undefined;
                }
                
                waitframe();
                continue;
            }
            
            self.debugdamage = 1;
            damageamount = 0;
            damagemod = "<dev string:x120>";
            debugweapon = "<dev string:x12e>";
            
            switch ( debugdamage )
            {
                case 1:
                    damageamount = int( self.maxhealth * 0.25 );
                    break;
                case 2:
                    damageamount = int( self.maxhealth * 0.5 );
                    break;
                case 3:
                    damageamount = int( self.maxhealth * 0.75 );
                    break;
                case 4:
                    damageamount = self.maxhealth;
                    damagemod = "<dev string:x13f>";
                    debugweapon = "<dev string:x150>";
                    break;
                case 5:
                    damageamount = self.maxhealth;
                    break;
            }
            
            if ( damageamount >= self.health )
            {
                self notify( #"debug_death" );
            }
            
            self dodamage( damageamount, self.origin, self.owner, self.owner, damagemod, makeweapon( debugweapon ) );
            waitframe();
            setdvar( devdvar, 0 );
        }
    }

#/
