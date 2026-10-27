// script_2a23525b482401e3  (hash_2a23525b482401e3.gscc) (size: 4573 Bytes / 0x11dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbaa657fd (3131463677)
// size ...... 4573 (0x11dd)
// includes .. 2   (offset: 0x113d)
// strings ... 8   (offset: 0x114d)
// dev strs .. 3   (offset: 0x11b9)
// exports ... 16  (offset: 0xa39)
// cseg ...... 0x17a + 0x8bf (0xa39)
// imports ... 40  (offset: 0xcb9)
// animtree1 . 0   (offset: 0x11dd)
// animtree2 . 0   (offset: 0x11dd)
#using script_53651341190c5aab;
#using scripts\common\utility;

#namespace solo_interaction;

// Namespace solo_interaction
// Params 1
// Checksum 0xee43ba38, Offset: 0x198
// Size: 0xe4
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_485066ed1df7b390":
            return &function_d8226e0ee60ea057;
        case #"hash_fe0e9f8796a0acad":
            return &onuserinit;
        case #"hash_e93ace2ec1639636":
            return &onuserterminate;
        case #"hash_1bda0008592d217c":
            return &function_49dbcf7b7d75e2ab;
        case #"hash_f67d8dffeaed2c04":
            return &function_fae218336da05ff3;
        case #"hash_9f9e07224ff2a95a":
            return &calcstartorigin;
        case #"hash_4a175d8c6c612f":
            return &function_e0cffd5a6184f258;
        case #"hash_5bdce04e7ba622e6":
            return &function_5216bdad0d656ca3;
        case #"hash_d4dd8779b1436104":
            return &function_e76ad3d21dcfa183;
        case #"hash_6b02200fcc19d461":
            return &hasaliases;
        case #"hash_2ef64b5876180466":
            return &function_6f5b605688b4cd7d;
    }
    
    return interaction_common::function_d4be89b1cf3d4993( funcid );
}

// Namespace solo_interaction
// Params 1
// Checksum 0x280de4a2, Offset: 0x285
// Size: 0x41
function onuserinit( interactionid )
{
    self.var_dc3eaabf09c13bd5 = 0;
    self.var_65b1528eab2fb4ea = 0;
    self._bseq_animlength = 0;
    self.customarrivalhandler = &function_d8226e0ee60ea057;
    interaction_common::function_b4c8cc8d02ad0b95( interactionid );
}

// Namespace solo_interaction
// Params 1
// Checksum 0x915f95f8, Offset: 0x2ce
// Size: 0xa6
function onuserterminate( interactionid )
{
    self.var_dc3eaabf09c13bd5 = undefined;
    self.var_65b1528eab2fb4ea = 0;
    self._bseq_animlength = undefined;
    self clearbtgoal( 3 );
    interaction_common::function_dabb6663ba0a5177( interactionid );
    
    if ( self.asmname != self.defaultasm && ( function_e76ad3d21dcfa183() || filtershouldreact() ) )
    {
        self._blackboard.bseqphase = "react";
    }
    else
    {
        self._blackboard.bseqphase = "end";
    }
    
    self notify( #"hash_9e3bcc37fe65dad1" );
}

// Namespace solo_interaction
// Params 3
// Checksum 0xc669d5b6, Offset: 0x37c
// Size: 0x1f, Type: bool
function function_49dbcf7b7d75e2ab( receiver, info, origin )
{
    return false;
}

// Namespace solo_interaction
// Params 2
// Checksum 0xdcb62c50, Offset: 0x3a4
// Size: 0x8a
function function_d8226e0ee60ea057( statename, params )
{
    role = "guy";
    capinfo = getcapinfoforrole( self, role );
    
    if ( issubstr( self.animsetname, "guard" ) || issubstr( self.animsetname, "pistol" ) )
    {
        capinfo = getcapinfoforrole( self, "pistol" );
        
        if ( capinfo )
        {
            role = "pistol";
        }
    }
    
    interaction_common::startcap( statename, [ role ] );
}

// Namespace solo_interaction
// Params 2
// Checksum 0xb0bb424a, Offset: 0x436
// Size: 0x141
function calcstartorigin( statename, role )
{
    capinfo = getcapinfoforrole( self, role );
    animset = capinfo.animation;
    arrivalstateoverride = capinfo.arrivalstateoverride;
    introstatename = capinfo.initialstate;
    introaliasname = capinfo.initialalias;
    id = self getinteractionid();
    assert( isdefined( id ) );
    origin = getinteractionorigin( id );
    angles = getinteractionangles( id );
    
    if ( isdefined( introstatename ) && isdefined( introaliasname ) )
    {
        animid = archetypegetrandomalias( animset, introstatename, introaliasname );
        assert( animid >= 0 );
        xanim = animsetgetanimfromindex( animset, introstatename, animid );
        origin = getstartorigin( origin, angles, xanim );
    }
    
    if ( isdefined( self._blackboard.idlenode ) && self._blackboard.idlenode.script_faceangles )
    {
        self.customarrivalangles = angles;
    }
    
    return origin;
}

// Namespace solo_interaction
// Params 1
// Checksum 0x777ba618, Offset: 0x580
// Size: 0x16, Type: bool
function filtershouldreact( params )
{
    return isdefined( self.var_6002aa8166897fd7 );
}

// Namespace solo_interaction
// Params 2
// Checksum 0xe1b0cbbc, Offset: 0x59f
// Size: 0x3b, Type: bool
function function_e76ad3d21dcfa183( statename, params )
{
    return self.bisincombat || isdefined( self.stealth ) && self.stealth_bsmstate != 0;
}

// Namespace solo_interaction
// Params 2
// Checksum 0x1f9fbe44, Offset: 0x5e3
// Size: 0x2e, Type: bool
function function_fae218336da05ff3( statename, params )
{
    return self._blackboard.bseqphase == "looping";
}

// Namespace solo_interaction
// Params 4
// Checksum 0x1032f45d, Offset: 0x61a
// Size: 0x66, Type: bool
function hasaliases( asmname, statename, tostatename, params )
{
    hasstate = archetypehasstate( self.animsetname, tostatename );
    
    if ( !hasstate )
    {
        return false;
    }
    
    aliases = archetypegetaliases( self.animsetname, tostatename );
    return isdefined( aliases );
}

// Namespace solo_interaction
// Params 3
// Checksum 0x97310cb5, Offset: 0x689
// Size: 0x24c
function function_e0cffd5a6184f258( asmname, statename, params )
{
    if ( self.asmname != "cap_solo_interaction" )
    {
        entnum = self.entity_number ?? -1;
        asmname = self.asmname ?? "None";
        animsetname = self.animsetname ?? "None";
        assertmsg( "<dev string:x24>" + string( self.entity_number ) + "<dev string:x28>" + self.asmname + "<dev string:x61>" + self.animsetname );
    }
    
    looptime = self._bseq_animlength * 1000;
    
    if ( isdefined( self.var_2a83cd5a466893d4 ) )
    {
        looptime = self.var_2a83cd5a466893d4 * 1000;
    }
    else if ( self._blackboard.idlenode )
    {
        if ( isdefined( self._blackboard.idlenode.script_delay_min ) && isdefined( self._blackboard.idlenode.script_delay_max ) )
        {
            looptime = int( randomfloatrange( self._blackboard.idlenode.script_delay_min, self._blackboard.idlenode.script_delay_max ) * 1000 );
        }
        else if ( isdefined( self._blackboard.idlenode.script_delay ) )
        {
            looptime = int( self._blackboard.idlenode.script_delay * 1000 );
        }
    }
    
    if ( self._blackboard.idlenode.script_cleanexit || self.var_c37a94dd3608bf47 )
    {
        numloops = ceil( looptime / 1000 / self._bseq_animlength );
        looptime = self._bseq_animlength * numloops * 1000;
    }
    
    self.var_dc3eaabf09c13bd5 = looptime;
    self.var_65b1528eab2fb4ea = looptime + gettime();
}

// Namespace solo_interaction
// Params 4
// Checksum 0xbaaf7e10, Offset: 0x8dd
// Size: 0x80, Type: bool
function function_fedf9d33e95a43f7( asmname, statename, tostatename, params )
{
    if ( utility::isflashed() )
    {
        return false;
    }
    
    curtime = gettime();
    
    if ( curtime - self.var_553ae45c1a5786fb < 250 )
    {
        return false;
    }
    
    if ( curtime - self._blackboard.var_ba9517cfc0287af8 < 250 )
    {
        return false;
    }
    
    return hasaliases( asmname, statename, tostatename, params );
}

// Namespace solo_interaction
// Params 4
// Checksum 0x600e4d4b, Offset: 0x966
// Size: 0x42, Type: bool
function function_25ee909a85e4e057( asmname, statename, tostatename, params )
{
    if ( isdefined( self.var_f925e2193283ac0b ) )
    {
        return false;
    }
    
    return hasaliases( asmname, statename, tostatename, params );
}

// Namespace solo_interaction
// Params 2
// Checksum 0xa107730b, Offset: 0x9b1
// Size: 0x41
function function_5216bdad0d656ca3( statename, params )
{
    if ( params[ 0 ] )
    {
        self clearpath();
        self setbtgoalstationary( 3 );
        self setbtgoalradius( 3, 32 );
        return;
    }
    
    self clearbtgoal( 3 );
}

// Namespace solo_interaction
// Params 4
// Checksum 0x80d989dd, Offset: 0x9fa
// Size: 0x3e, Type: bool
function function_6f5b605688b4cd7d( asmname, statename, tostatename, params )
{
    return isdefined( self.var_286d9284164cc9c5 ) && self.var_286d9284164cc9c5;
}

