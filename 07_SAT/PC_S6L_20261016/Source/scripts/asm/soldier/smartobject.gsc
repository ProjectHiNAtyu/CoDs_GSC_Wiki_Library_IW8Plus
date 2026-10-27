// scripts\asm\soldier\smartobject.gsc  (hash_2fc5f0c2a4c01b47.gscc) (size: 6699 Bytes / 0x1a2b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3244817f (843350399)
// size ...... 6699 (0x1a2b)
// includes .. 8   (offset: 0x18e3)
// strings ... 15  (offset: 0x1923)
// dev strs .. 5   (offset: 0x19eb)
// exports ... 30  (offset: 0xeff)
// cseg ...... 0xf8 + 0xe07 (0xeff)
// imports ... 42  (offset: 0x13af)
// animtree1 . 0   (offset: 0x1a2b)
// animtree2 . 0   (offset: 0x1a2b)
#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\move;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\patrol;
#using scripts\common\ai\smartobjects\utility;

#namespace smartobject;

// Namespace smartobject
// Params 3
// Checksum 0xa835ad1c, Offset: 0x116
// Size: 0x71
function smartobjectinit( asmname, startname, params )
{
    assert( !isdefined( self.asm.smartobject ) );
    self.asm.smartobject = asm_bb::bb_getrequestedsmartobject();
    assert( isdefined( self.asm.smartobject ) );
}

// Namespace smartobject
// Params 3
// Checksum 0xe4df1943, Offset: 0x18f
// Size: 0x85
function smartobjectcomplete( asmname, statename, params )
{
    self.asm.smartobject.lastusetime = gettime();
    self.asm.smartobject utility::smartobject_setnextuse();
    self.asm.smartobject = undefined;
    asm_bb::bb_clearplaysmartobject();
    asm::asm_fireephemeralevent( "smartobject", "finished" );
}

// Namespace smartobject
// Params 0
// Checksum 0x2446b15e, Offset: 0x21c
// Size: 0x3e
function getsmartobjectinfo()
{
    type = utility::getsmartobjecttype( self.asm.smartobject.script_smartobject );
    return [[ type.fngetinfo ]]();
}

// Namespace smartobject
// Params 4
// Checksum 0x7e23ba58, Offset: 0x263
// Size: 0x4d, Type: bool
function smartobjecthasintro( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    
    if ( !isdefined( info.hasintro ) )
    {
        return false;
    }
    
    return true;
}

// Namespace smartobject
// Params 4
// Checksum 0x10b0961f, Offset: 0x2b9
// Size: 0x29, Type: bool
function smartobjecthaslogic( asmname, statename, tostatename, params )
{
    return true;
}

// Namespace smartobject
// Params 4
// Checksum 0x7e23ba58, Offset: 0x2eb
// Size: 0x4d, Type: bool
function smartobjecthasoutro( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    
    if ( !isdefined( info.hasoutro ) )
    {
        return false;
    }
    
    return true;
}

// Namespace smartobject
// Params 4
// Checksum 0x7e23ba3e, Offset: 0x341
// Size: 0x45, Type: bool
function smartobjecthasexits( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.hasexits );
}

// Namespace smartobject
// Params 4
// Checksum 0xb1ac13db, Offset: 0x38f
// Size: 0x45, Type: bool
function shouldplaysmartobjectpain( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.haspain );
}

// Namespace smartobject
// Params 4
// Checksum 0x55cd3e5f, Offset: 0x3dd
// Size: 0x45, Type: bool
function shouldplaysmartobjectdeath( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.hasdeath );
}

// Namespace smartobject
// Params 4
// Checksum 0x55cd3e5f, Offset: 0x42b
// Size: 0x45, Type: bool
function shouldplaysmartobjectreact( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    return istrue( info.hasreact );
}

// Namespace smartobject
// Params 4
// Checksum 0x3fd567ab, Offset: 0x479
// Size: 0xa0, Type: bool
function shouldsmartobjectreact( asmname, statename, tostatename, params )
{
    info = getsmartobjectinfo();
    
    if ( info.bdonotreact )
    {
        return false;
    }
    
    if ( self function_e5f83bf33ca29242() )
    {
        return true;
    }
    
    if ( isdefined( info.fninterrupt ) && self [[ info.fninterrupt ]]() )
    {
        if ( !isdefined( self.var_6002aa8166897fd7 ) )
        {
            self.var_6002aa8166897fd7 = "med";
        }
        
        self.var_ddfc4fd4a4d066b2 = gettime();
        return true;
    }
    
    return false;
}

// Namespace smartobject
// Params 3
// Checksum 0x931849fc, Offset: 0x522
// Size: 0x6f
function playsmartobjectintro( asmname, statename, params )
{
    smartobject = self.asm.smartobject;
    
    if ( isdefined( smartobject.angles ) )
    {
        self orientmode( "face angle", smartobject.angles[ 1 ] );
    }
    
    playsmartobjectanim( asmname, statename );
}

// Namespace smartobject
// Params 3
// Checksum 0x1d8bc700, Offset: 0x599
// Size: 0xc1
function playsmartobjectlogic( asmname, statename, params )
{
    self endon( statename + "_finished" );
    smartobject = self.asm.smartobject;
    
    if ( isdefined( smartobject.angles ) )
    {
        self orientmode( "face angle", smartobject.angles[ 1 ] );
    }
    
    info = getsmartobjectinfo();
    
    if ( isdefined( info.fnonuse ) )
    {
        self [[ info.fnonuse ]]( smartobject );
    }
    
    playsmartobjectanim( asmname, statename, 0.1, "finished" );
    self asmfireevent( asmname, "smartobject_finished" );
}

// Namespace smartobject
// Params 3
// Checksum 0xf3490776, Offset: 0x662
// Size: 0x9d
function choosesmartobjectanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    
    if ( info.var_8305aedf56bda069 )
    {
        return;
    }
    
    animalias = info.animlist[ statename ];
    data = spawnstruct();
    data.animindex = asm::asm_lookupanimfromalias( info.animstatename, animalias );
    data.statename = info.animstatename;
    return data;
}

// Namespace smartobject
// Params 4
// Checksum 0x853cb010, Offset: 0x708
// Size: 0x141
function playsmartobjectanim( asmname, statename, earlytime, earlynotify )
{
    self endon( statename + "_finished" );
    animdata = asm::asm_getanim( asmname, statename );
    
    if ( !isdefined( animdata ) )
    {
        self waittill( #"forever" );
    }
    
    self aisetanim( animdata.statename, animdata.animindex );
    asm::asm_playfacialanim( asmname, animdata.statename, asm::asm_getxanim( animdata.statename, animdata.animindex ) );
    
    if ( isdefined( earlytime ) && isdefined( earlynotify ) )
    {
        xanim = asm::asm_getxanim( animdata.statename, animdata.animindex );
        waittime = getanimlength( xanim ) - earlytime;
        childthread smartobject_earlynotifier( waittime, earlynotify );
    }
    
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ), undefined, animdata.statename );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, statename, undefined, undefined, animdata.statename );
    }
}

// Namespace smartobject
// Params 2
// Checksum 0x3e2ba200, Offset: 0x851
// Size: 0x26
function smartobject_earlynotifier( waittime, earlynotify )
{
    wait waittime;
    asm::asm_fireephemeralevent( "smartobject", earlynotify );
}

// Namespace smartobject
// Params 1
// Checksum 0xb967c376, Offset: 0x87f
// Size: 0x4a
function smartobject_notetrackhandler( note )
{
    if ( notetracks::notetrack_prefix_handler( note ) )
    {
        return;
    }
    
    info = getsmartobjectinfo();
    
    if ( isdefined( info.fnnotetrackhandle ) )
    {
        return self [[ info.fnnotetrackhandle ]]( note );
    }
}

// Namespace smartobject
// Params 4
// Checksum 0xef73f756, Offset: 0x8d1
// Size: 0x45, Type: bool
function smartobject_shouldexitintomove( asmname, statename, tostatename, params )
{
    return isdefined( self.pathgoalpos ) && length2dsquared( self.velocity ) > 1;
}

// Namespace smartobject
// Params 3
// Checksum 0x1ce33ea6, Offset: 0x91f
// Size: 0x70
function playsmartobjectexit( asmname, statename, params )
{
    info = getsmartobjectinfo();
    exitanim = asm::asm_getanim( asmname, statename );
    
    if ( !isdefined( exitanim ) )
    {
        asm::asm_fireevent( asmname, "abort" );
        return;
    }
    
    move::playstartanim( asmname, info.animstatename, exitanim, 0 );
}

// Namespace smartobject
// Params 3
// Checksum 0xb2d0cc82, Offset: 0x997
// Size: 0x45
function choosesmartobjectexitanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    return move::chooseanim_exit( asmname, info.animstatename, params );
}

// Namespace smartobject
// Params 3
// Checksum 0xad3afcdd, Offset: 0x9e5
// Size: 0x45
function playsmartobjectreactanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    patrol::playanim_patrolreact_internal( asmname, statename, info.animstatename );
}

// Namespace smartobject
// Params 3
// Checksum 0x5b6c87ad, Offset: 0xa32
// Size: 0xf3
function choosesmartobjectreactanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    
    if ( isdefined( info.animlist[ statename ] ) )
    {
        assert( asm::asm_hasalias( info.animstatename, info.animlist[ statename ] ) );
        return asm::asm_lookupanimfromalias( info.animstatename, info.animlist[ statename ] );
    }
    
    directionindex = patrol::getpatrolreactdirindex();
    alias = "react_med_" + directionindex;
    assert( asm::asm_hasalias( info.animstatename, alias ), "<dev string:x24>" + info.animstatename + "<dev string:x47>" + alias );
    return asm::asm_lookupanimfromalias( info.animstatename, alias );
}

// Namespace smartobject
// Params 3
// Checksum 0x8f6574bb, Offset: 0xb2e
// Size: 0x49
function playsmartobjectpainanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    pain::playpainaniminternal( asmname, statename, params, 0, 1, info.animstatename );
}

// Namespace smartobject
// Params 3
// Checksum 0xca78a67f, Offset: 0xb7f
// Size: 0x5f
function playsmartobjectdeathanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    self.deathstate = info.animstatename;
    self.deathalias = choosesmartobjectdeathalias( statename );
    death::playdeathanim( asmname, statename );
}

// Namespace smartobject
// Params 3
// Checksum 0x3a9216de, Offset: 0xbe6
// Size: 0xe7
function choosesmartobjectpainanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    
    if ( isdefined( info.animlist[ statename ] ) )
    {
        assert( asm::asm_hasalias( info.animstatename, info.animlist[ statename ] ) );
        return asm::asm_lookupanimfromalias( info.animstatename, info.animlist[ statename ] );
    }
    
    painalias = "pain_" + smtobjgetdamagedir();
    assert( asm::asm_hasalias( info.animstatename, painalias ), "<dev string:x73>" + info.animstatename + "<dev string:x47>" + painalias );
    return asm::asm_lookupanimfromalias( info.animstatename, painalias );
}

// Namespace smartobject
// Params 0
// Checksum 0x744a47b1, Offset: 0xcd6
// Size: 0x72
function smtobjgetdamagedir()
{
    anglediff = angleclamp180( self.damageyaw - self.angles[ 1 ] );
    
    if ( anglediff < -135 )
    {
        return "2";
    }
    
    if ( anglediff < -45 )
    {
        return "4";
    }
    
    if ( anglediff > 135 )
    {
        return "2";
    }
    
    if ( anglediff > 45 )
    {
        return "6";
    }
    
    return "8";
}

// Namespace smartobject
// Params 3
// Checksum 0x9c9a65ff, Offset: 0xd50
// Size: 0x55
function choosesmartobjectdeathanim( asmname, statename, params )
{
    info = getsmartobjectinfo();
    deathalias = choosesmartobjectdeathalias( statename );
    return asm::asm_lookupanimfromalias( info.animstatename, deathalias );
}

// Namespace smartobject
// Params 1
// Checksum 0xab6b863e, Offset: 0xdae
// Size: 0xb3
function choosesmartobjectdeathalias( statename )
{
    info = getsmartobjectinfo();
    
    if ( isdefined( info.animlist[ statename ] ) )
    {
        assert( asm::asm_hasalias( info.animstatename, info.animlist[ statename ] ) );
        return info.animlist[ statename ];
    }
    
    deathalias = "death_" + smtobjgetdamagedir();
    assert( asm::asm_hasalias( info.animstatename, deathalias ), "<dev string:x92>" + info.animstatename + "<dev string:xb2>" + deathalias );
    return deathalias;
}

// Namespace smartobject
// Params 3
// Checksum 0x785764dd, Offset: 0xe6a
// Size: 0x94, Type: bool
function needtoturntosmartobject( asmname, statename, params )
{
    smartobj = asm_bb::bb_getrequestedsmartobject();
    
    if ( !isdefined( smartobj ) )
    {
        return false;
    }
    
    if ( !isdefined( smartobj.angles ) )
    {
        return false;
    }
    
    anglediff = angleclamp180( smartobj.angles[ 1 ] - self.angles[ 1 ] );
    
    if ( -45 < anglediff && anglediff < 45 )
    {
        return false;
    }
    
    self.desiredturnyaw = anglediff;
    return true;
}

