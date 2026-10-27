// scripts\mp\common\perks\forwardintel.gsc  (hash_65a35a03db740cdb.gscc) (size: 945 Bytes / 0x3b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x279a7d77 (664436087)
// size ...... 945 (0x3b1)
// includes .. 1   (offset: 0x38d)
// strings ... 2   (offset: 0x395)
// dev strs .. 0   (offset: 0x3b1)
// exports ... 7   (offset: 0x1cd)
// cseg ...... 0x90 + 0x13d (0x1cd)
// imports ... 6   (offset: 0x2e5)
// animtree1 . 0   (offset: 0x3b1)
// animtree2 . 0   (offset: 0x3b1)
#using scripts\common\callbacks;

#namespace forwardintel;

// Namespace forwardintel
// Params 0, eflags: 0x1
// Checksum 0x3df2976a, Offset: 0xae
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerforwardintel );
}

// Namespace forwardintel
// Params 1
// Checksum 0x47f917e, Offset: 0xce
// Size: 0x66
function registerforwardintel( params )
{
    bundle = level.perkbundles[ "specialty_forwardintel" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_forwardintel", &setforwardintel, &unsetforwardintel, [ "specialty_expanded_minimap" ] );
    }
}

// Namespace forwardintel
// Params 0
// Checksum 0xb0a4863d, Offset: 0x13c
// Size: 0x10
function setforwardintel()
{
    thread function_7d44e2d35e28528e();
    thread function_7d3ee6be26520f69();
}

// Namespace forwardintel
// Params 0
// Checksum 0xf63780ab, Offset: 0x154
// Size: 0x18
function unsetforwardintel()
{
    self.radarshowenemydirection = 0;
    self notify( #"hash_ba52f19c75f7418f" );
}

// Namespace forwardintel
// Params 0
// Checksum 0x8e065d6a, Offset: 0x174
// Size: 0x13
function function_7d44e2d35e28528e()
{
    waitframe();
    
    if ( isdefined( self ) )
    {
        self.radarshowenemydirection = 1;
    }
}

// Namespace forwardintel
// Params 0
// Checksum 0xa60c24dc, Offset: 0x18f
// Size: 0x3e
function function_7d3ee6be26520f69()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_ba52f19c75f7418f" );
    waitframe();
    
    while ( true )
    {
        if ( !self.radarshowenemydirection )
        {
            self.radarshowenemydirection = 1;
        }
        
        wait 1;
    }
}

