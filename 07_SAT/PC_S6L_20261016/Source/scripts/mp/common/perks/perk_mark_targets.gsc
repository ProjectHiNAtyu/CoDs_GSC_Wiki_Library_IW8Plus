// scripts\mp\common\perks\perk_mark_targets.gsc  (hash_1d23236f809ebb5f.gscc) (size: 960 Bytes / 0x3c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x732ef737 (1932457783)
// size ...... 960 (0x3c0)
// includes .. 2   (offset: 0x3b0)
// strings ... 0   (offset: 0x3c0)
// dev strs .. 0   (offset: 0x3c0)
// exports ... 6   (offset: 0x1dc)
// cseg ...... 0x58 + 0x184 (0x1dc)
// imports ... 8   (offset: 0x2cc)
// animtree1 . 0   (offset: 0x3c0)
// animtree2 . 0   (offset: 0x3c0)
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace perk_mark_targets;

// Namespace perk_mark_targets
// Params 0
// Checksum 0x54cd1c7b, Offset: 0x76
// Size: 0x2
function marktarget_init()
{
    
}

// Namespace perk_mark_targets
// Params 3
// Checksum 0x8f23aa8a, Offset: 0x80
// Size: 0x78
function marktarget_run( victim, objweapon, smeansofdeath )
{
    if ( utility::isbulletdamage( smeansofdeath ) && isplayer( victim ) && player::isreallyalive( victim ) && victim.team != self.team && isdefined( objweapon ) && !objweapon.isalternate )
    {
        thread marktarget_execute( victim );
    }
}

// Namespace perk_mark_targets
// Params 1
// Checksum 0x6da7b115, Offset: 0x100
// Size: 0x4c
function marktarget_execute( target )
{
    target notify( #"delayhealing_started" );
    target endon( #"delayhealing_started" );
    target.healthregendisabled = 1;
    tagmarkedplayer( target );
    
    if ( isdefined( target ) )
    {
        target removemarkfromtarget();
    }
}

// Namespace perk_mark_targets
// Params 1
// Checksum 0x7cbfc811, Offset: 0x154
// Size: 0x74
function tagmarkedplayer( target )
{
    self endon( #"death_or_disconnect" );
    target endon( #"death_or_disconnect" );
    var_928612c5ea399b56 = utility::callsharedfunc( #"hash_63fcc6a20d91f33f", #"hash_e03a171fd81a1b93" ) ?? 1;
    timemarked = gettime() + 3500 * var_928612c5ea399b56;
    
    while ( gettime() < timemarked )
    {
        waitframe();
    }
}

// Namespace perk_mark_targets
// Params 0
// Checksum 0x39181499, Offset: 0x1d0
// Size: 0xc
function removemarkfromtarget()
{
    self.healthregendisabled = undefined;
}

