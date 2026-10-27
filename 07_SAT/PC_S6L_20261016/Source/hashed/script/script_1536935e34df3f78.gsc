// script_1536935e34df3f78  (hash_1536935e34df3f78.gscc) (size: 933 Bytes / 0x3a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bcf4966 (2614053222)
// size ...... 933 (0x3a5)
// includes .. 2   (offset: 0x389)
// strings ... 1   (offset: 0x399)
// dev strs .. 0   (offset: 0x3a5)
// exports ... 6   (offset: 0x1d5)
// cseg ...... 0x7a + 0x15b (0x1d5)
// imports ... 7   (offset: 0x2c5)
// animtree1 . 0   (offset: 0x3a5)
// animtree2 . 0   (offset: 0x3a5)
#using scripts\common\callbacks;
#using scripts\mp\gamelogic;

#namespace specialty_supersprint_enhanced;

// Namespace specialty_supersprint_enhanced
// Params 0, eflags: 0x1
// Checksum 0xe80e3521, Offset: 0x98
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_supersprint_enhanced
// Params 1
// Checksum 0x25f515f7, Offset: 0xb8
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_supersprint_enhanced", &setsupersprintenhanced, &unsetsupersprintenhanced, [] );
    }
}

// Namespace specialty_supersprint_enhanced
// Params 0
// Checksum 0x1cb23a62, Offset: 0xfa
// Size: 0x4c
function setsupersprintenhanced()
{
    self.supersprintduration = self.var_9842326056fd7207.supersprintduration ?? 2000;
    self.var_a1333e0889be8729 = self.var_9842326056fd7207.var_a1333e0889be8729 ?? 1;
    thread watchforsupersprintenhancedused();
}

// Namespace specialty_supersprint_enhanced
// Params 0
// Checksum 0x30e8424c, Offset: 0x14e
// Size: 0xe
function unsetsupersprintenhanced()
{
    self notify( #"hash_d2402b2b9567b7e3" );
}

// Namespace specialty_supersprint_enhanced
// Params 0
// Checksum 0xd6572941, Offset: 0x164
// Size: 0x71
function watchforsupersprintenhancedused()
{
    self endon( #"hash_d2402b2b9567b7e3" );
    self endon( #"disconnect" );
    var_712cdbcf2abf339b = 0;
    
    while ( self.supersprintduration > var_712cdbcf2abf339b )
    {
        waitframe();
        
        if ( self issupersprinting() )
        {
            deltatime = level.frameduration;
            var_712cdbcf2abf339b += deltatime;
        }
    }
    
    if ( self.var_a1333e0889be8729 )
    {
        gamelogic_mp::sethasdonecombat( self, 1 );
    }
}

