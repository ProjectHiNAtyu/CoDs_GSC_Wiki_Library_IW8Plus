// script_64bbd0df6dd3f69b  (hash_64bbd0df6dd3f69b.gscc) (size: 824 Bytes / 0x338 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57a0cb8c (1470155660)
// size ...... 824 (0x338)
// includes .. 1   (offset: 0x320)
// strings ... 1   (offset: 0x328)
// dev strs .. 0   (offset: 0x338)
// exports ... 5   (offset: 0x190)
// cseg ...... 0x6d + 0x123 (0x190)
// imports ... 7   (offset: 0x258)
// animtree1 . 0   (offset: 0x338)
// animtree2 . 0   (offset: 0x338)
#using scripts\common\callbacks;

#namespace specialty_skulker;

// Namespace specialty_skulker
// Params 0, eflags: 0x1
// Checksum 0x93a85c74, Offset: 0x8b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_skulker
// Params 1, eflags: 0x4
// Checksum 0x90eea270, Offset: 0xab
// Size: 0x5a
function private registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_skulker" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_skulker", &setskulker, &unsetskulker );
    }
}

// Namespace specialty_skulker
// Params 0, eflags: 0x4
// Checksum 0x5a3bdf6c, Offset: 0x10d
// Size: 0x3c
function private setskulker()
{
    swimspeedscale = self.var_9842326056fd7207.var_da6d3c03cd93fff1;
    
    if ( swimspeedscale )
    {
        /#
            self.var_da6d3c03cd93fff1 = swimspeedscale;
        #/
        
        self setswimspeedscale( swimspeedscale );
    }
}

// Namespace specialty_skulker
// Params 0, eflags: 0x4
// Checksum 0x17840420, Offset: 0x151
// Size: 0x3f
function private unsetskulker()
{
    /#
        var_7b0a6d7f9910489b = self getswimspeedscale();
        assert( self.var_da6d3c03cd93fff1 == var_7b0a6d7f9910489b );
        self.var_da6d3c03cd93fff1 = undefined;
    #/
    
    self setswimspeedscale( 1 );
}

