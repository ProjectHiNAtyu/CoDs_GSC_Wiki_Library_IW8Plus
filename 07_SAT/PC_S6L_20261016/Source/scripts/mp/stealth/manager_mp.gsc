// scripts\mp\stealth\manager_mp.gsc  (hash_1407e72346815bc3.gscc) (size: 914 Bytes / 0x392 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbbbf9a2 (3686529442)
// size ...... 914 (0x392)
// includes .. 3   (offset: 0x35e)
// strings ... 1   (offset: 0x376)
// dev strs .. 1   (offset: 0x382)
// exports ... 6   (offset: 0x19a)
// cseg ...... 0x7c + 0x11e (0x19a)
// imports ... 7   (offset: 0x28a)
// animtree1 . 0   (offset: 0x392)
// animtree2 . 0   (offset: 0x392)
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\stealth\utility;

#namespace manager_mp;

// Namespace manager_mp
// Params 0
// Checksum 0xbca99183, Offset: 0x9a
// Size: 0x2
function init()
{
    
}

// Namespace manager_mp
// Params 0
// Checksum 0xc954ad01, Offset: 0xa4
// Size: 0x3c
function init_player()
{
    self waittill( #"giveloadout" );
    
    if ( isdefined( level.stealth.fnsixthsense ) )
    {
        [[ level.stealth.fnsixthsense ]]();
    }
}

// Namespace manager_mp
// Params 0
// Checksum 0x8b63fea9, Offset: 0xe8
// Size: 0x4f
function sixthsense_init()
{
    self endon( #"death" );
    self.sixthsense = spawnstruct();
    self.sixthsense.active = 1;
    
    /#
        setdvarifuninitialized( @"hash_3a87475a75de0350", 0 );
    #/
    
    perk::giveperk( "specialty_ai_stealth_sixth_sense" );
}

// Namespace manager_mp
// Params 0
// Checksum 0xd1f8de08, Offset: 0x13f
// Size: 0x2b
function dropaiaccuracy()
{
    if ( !utility::level_supports_ai() )
    {
        return;
    }
    
    assert( isplayer( self ), "<dev string:x24>" );
    utility::setattackeraccuracy( 0.1 );
}

// Namespace manager_mp
// Params 0
// Checksum 0x948d8a9b, Offset: 0x172
// Size: 0x28
function revertaiaccuracy()
{
    if ( !utility::level_supports_ai() )
    {
        return;
    }
    
    assert( isplayer( self ), "<dev string:x24>" );
    utility::setattackeraccuracy( 1 );
}

