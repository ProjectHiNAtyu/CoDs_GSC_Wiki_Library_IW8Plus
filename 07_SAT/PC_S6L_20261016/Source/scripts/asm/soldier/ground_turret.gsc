// scripts\asm\soldier\ground_turret.gsc  (hash_15f86984da58cda7.gscc) (size: 2028 Bytes / 0x7ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe75740bb (3881255099)
// size ...... 2028 (0x7ec)
// includes .. 4   (offset: 0x78c)
// strings ... 4   (offset: 0x7ac)
// dev strs .. 0   (offset: 0x7ec)
// exports ... 9   (offset: 0x3f4)
// cseg ...... 0x89 + 0x36b (0x3f4)
// imports ... 18  (offset: 0x55c)
// animtree1 . 0   (offset: 0x7ec)
// animtree2 . 0   (offset: 0x7ec)
#using scripts\asm\asm;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\pain;
#using scripts\common\ai;

#namespace ground_turret;

// Namespace ground_turret
// Params 4
// Checksum 0x8a50b5cc, Offset: 0xa7
// Size: 0x5a, Type: bool
function aigroundturret_shouldcompletedismount( asmname, statename, tostatename, params )
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    turret cleartargetentity();
    return true;
}

// Namespace ground_turret
// Params 0, eflags: 0x4
// Checksum 0x8e8af0b8, Offset: 0x10a
// Size: 0x57
function private disablegroundturret()
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    turret.inuse = 0;
    turret setturretteam( "neutral" );
    turret setmode( "manual" );
    self stopuseturret();
}

// Namespace ground_turret
// Params 3
// Checksum 0xae25211b, Offset: 0x169
// Size: 0x5a
function playanim_mountturret( asmname, statename, params )
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    ai::aigroundturret_mountcompleted();
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret
// Params 3
// Checksum 0x8a34217, Offset: 0x1cb
// Size: 0xf8
function playanim_aioperateturret( asmname, statename, params )
{
    turret = self._blackboard.aigroundturretref;
    assert( isdefined( turret ) );
    origin = turret gettagorigin( "tag_gunner" );
    angles = turret gettagangles( "tag_gunner" );
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    turret.inuse = 1;
    turret setturretteam( self.team );
    
    if ( isdefined( turret.usemode ) )
    {
        turret setmode( turret.usemode );
    }
    else
    {
        turret setmode( "auto_nonai" );
    }
    
    self forceteleport( origin, angles );
    self linktoblendtotag( turret, "tag_gunner", 0 );
    self useturret( turret );
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret
// Params 3
// Checksum 0x73b1bcab, Offset: 0x2cb
// Size: 0x30
function playanim_aibegindismountturret( asmname, statename, params )
{
    disablegroundturret();
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret
// Params 3
// Checksum 0xbfdea5a5, Offset: 0x303
// Size: 0x3e
function playanim_aidismountturret( asmname, statename, params )
{
    if ( self islinked() )
    {
        self unlink();
    }
    
    ai::aigroundturret_dismountcompleted();
    asm::asm_playanimstate( asmname, statename, params );
}

// Namespace ground_turret
// Params 3
// Checksum 0xc50b225d, Offset: 0x349
// Size: 0x73
function playdeathanim_groundturret( asmname, statename, params )
{
    turret = self._blackboard.aigroundturretref;
    
    if ( isdefined( turret ) )
    {
        turret.inuse = 0;
        turret setturretteam( "neutral" );
        turret setmode( "manual" );
    }
    
    death::playdeathanim( asmname, statename, params );
}

// Namespace ground_turret
// Params 3
// Checksum 0xbb9209cf, Offset: 0x3c4
// Size: 0x30
function playpainanim_groundturret( asmname, statename, params )
{
    disablegroundturret();
    pain::playpainanim( asmname, statename, params );
}

