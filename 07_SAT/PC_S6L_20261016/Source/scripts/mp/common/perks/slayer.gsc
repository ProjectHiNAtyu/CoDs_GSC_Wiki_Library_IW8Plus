// scripts\mp\common\perks\slayer.gsc  (hash_5ec45660ba50ef16.gscc) (size: 2693 Bytes / 0xa85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4977f18 (4103569176)
// size ...... 2693 (0xa85)
// includes .. 2   (offset: 0x9f9)
// strings ... 8   (offset: 0xa09)
// dev strs .. 0   (offset: 0xa85)
// exports ... 12  (offset: 0x5e1)
// cseg ...... 0xda + 0x507 (0x5e1)
// imports ... 20  (offset: 0x7c1)
// animtree1 . 0   (offset: 0xa85)
// animtree2 . 0   (offset: 0xa85)
#using scripts\common\callbacks;
#using scripts\mp\challenges;

#namespace slayer;

// Namespace slayer
// Params 0, eflags: 0x1
// Checksum 0x30ba5c77, Offset: 0xf8
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_3610ed5e20015d0d );
}

// Namespace slayer
// Params 1
// Checksum 0xc9ddca9c, Offset: 0x118
// Size: 0x99
function function_3610ed5e20015d0d( params )
{
    bundle = level.perkbundles[ "specialty_slayer" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_slayer", &setslayer, &unsetslayer );
    }
    
    if ( isdefined( params.var_5109b530c69d18a1 ) )
    {
        level [[ params.var_5109b530c69d18a1 ]]( "specialty_slayer", &slayer_onkill );
    }
    
    callback::add( #"hash_6a8a551945faab9", &function_930290e469b15dee );
}

// Namespace slayer
// Params 0
// Checksum 0x1efd1921, Offset: 0x1b9
// Size: 0xc
function setslayer()
{
    self.var_63490a14ef1618a3 = 0;
}

// Namespace slayer
// Params 0
// Checksum 0x439af450, Offset: 0x1cd
// Size: 0x12
function unsetslayer()
{
    function_fb60303c4964c516( 0 );
    slayer_resetfov( 0 );
}

// Namespace slayer
// Params 1
// Checksum 0xef21507d, Offset: 0x1e7
// Size: 0x132
function slayer_onkill( params )
{
    smeansofdeath = params.smeansofdeath ?? "";
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" )
    {
        return;
    }
    
    self notify( #"slayeronkill_buff" );
    function_6e31d9bc7fd20582();
    function_e2513a6ee2a0c07a();
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        bundle = level.perkbundles[ "specialty_slayer" ];
        
        foreach ( perkbuff in bundle.var_ee1c92198ad66b2f )
        {
            self [[ var_2c124e2ccc1e8842 ]]( bundle, perkbuff.var_fbd59bd982c1fe7c );
        }
    }
}

// Namespace slayer
// Params 1, eflags: 0xc
// Checksum 0x54caa859, Offset: 0x321
// Size: 0x64
function private function_4fcca85696da9c8c( buffduration )
{
    self notify( #"hash_20e5d8b7424a1f7e" );
    self endon( #"hash_20e5d8b7424a1f7e" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_f05d2dfb2652889f ) )
    {
        self.var_f05d2dfb2652889f = 0;
    }
    
    self.var_f05d2dfb2652889f++;
    challenges::function_8118ace38657d9b1();
    wait buffduration;
    self.var_f05d2dfb2652889f = undefined;
}

// Namespace slayer
// Params 0
// Checksum 0xe2ae4f44, Offset: 0x38d
// Size: 0xb0
function function_6e31d9bc7fd20582()
{
    bundle = level.perkbundles[ "specialty_slayer" ];
    buffduration = bundle.slayerbuffduration ?? 0;
    thread function_4fcca85696da9c8c( buffduration );
    
    if ( !isdefined( self.cranked ) )
    {
        self.var_63490a14ef1618a3 = 1;
        thread function_fb60303c4964c516( buffduration );
        var_f427dd18ac2fe135 = level.sharedfuncs[ #"playerhealth" ][ #"hash_edc16c12ca11400" ];
        
        if ( isdefined( var_f427dd18ac2fe135 ) )
        {
            self [[ var_f427dd18ac2fe135 ]]( #"hash_d00fd8ba30a6f44e", bundle.var_8dd8d1fb73e2f4e4 ?? 0.5 );
        }
    }
}

// Namespace slayer
// Params 1
// Checksum 0xaf7be55, Offset: 0x445
// Size: 0x74
function function_fb60303c4964c516( delaytime )
{
    if ( delaytime )
    {
        self endon( #"slayeronkill_buff" );
        self endon( #"death_or_disconnect" );
        wait delaytime;
    }
    
    self.var_63490a14ef1618a3 = 0;
    var_1c2fdadc1c73aca8 = level.sharedfuncs[ #"playerhealth" ][ #"hash_325a50f0cddc1ff" ];
    
    if ( isdefined( var_1c2fdadc1c73aca8 ) )
    {
        self [[ var_1c2fdadc1c73aca8 ]]( #"hash_d00fd8ba30a6f44e" );
    }
}

// Namespace slayer
// Params 0
// Checksum 0x734fc16b, Offset: 0x4c1
// Size: 0x54
function function_e2513a6ee2a0c07a()
{
    bundle = level.perkbundles[ "specialty_slayer" ];
    buffduration = bundle.slayerbuffduration ?? 0;
    self setclientomnvar( "ui_slayerBuff", 1 );
    self function_a508a08653df6bcc( 1 );
    thread slayer_resetfov( buffduration );
}

// Namespace slayer
// Params 1
// Checksum 0x73a95a80, Offset: 0x51d
// Size: 0x55
function slayer_resetfov( delaytime )
{
    if ( delaytime )
    {
        self endon( #"slayeronkill_buff" );
        self endon( #"death_or_disconnect" );
        wait delaytime;
    }
    
    self setclientomnvar( "ui_slayerBuff", 0 );
    self function_a508a08653df6bcc( 0 );
    self lerpfovbypreset( "slayer_zoom_out" );
    self playlocalsound( "mpl_slayer_end" );
}

// Namespace slayer
// Params 1
// Checksum 0x72885742, Offset: 0x57a
// Size: 0x67
function function_930290e469b15dee( params )
{
    if ( self.var_63490a14ef1618a3 )
    {
        bundle = level.perkbundles[ "specialty_slayer" ];
        var_4646a7e478dea931 = bundle.var_c7220e6a9cc42223 ?? 1;
        params.var_2b32a8de075bfd54 *= var_4646a7e478dea931;
    }
}

