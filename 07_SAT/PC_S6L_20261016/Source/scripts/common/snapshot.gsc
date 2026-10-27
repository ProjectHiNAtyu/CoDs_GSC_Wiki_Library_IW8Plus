// scripts\common\snapshot.gsc  (hash_4d07edb4ba32d3b2.gscc) (size: 1149 Bytes / 0x47d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdec770d3 (3737612499)
// size ...... 1149 (0x47d)
// includes .. 1   (offset: 0x431)
// strings ... 5   (offset: 0x439)
// dev strs .. 0   (offset: 0x47d)
// exports ... 5   (offset: 0x27d)
// cseg ...... 0xac + 0x1d1 (0x27d)
// imports ... 8   (offset: 0x345)
// animtree1 . 0   (offset: 0x47d)
// animtree2 . 0   (offset: 0x47d)
#using scripts\common\utility;

#namespace snapshot;

// Namespace snapshot
// Params 0
// Checksum 0x50ce2797, Offset: 0xca
// Size: 0x98
function function_23f4614f16363579()
{
    self endon( #"disconnect" );
    
    if ( utility::isusingremote() )
    {
        return;
    }
    
    if ( isdefined( level.gamemodebundle.pbgpostfxbundle_marked ) )
    {
        pbgpostfxbundlestart( self, level.gamemodebundle.pbgpostfxbundle_marked );
        return;
    }
    
    visionset = "recon_drone_flash";
    
    if ( self.pers[ "useNVG" ] )
    {
        visionset = "recon_drone_flash_nvg";
    }
    
    self visionsetfadetoblackforplayer( visionset, 0.05 );
    wait 0.08;
    self visionsetfadetoblackforplayer( "", 1.2 );
}

// Namespace snapshot
// Params 0
// Checksum 0x5f56cb2f, Offset: 0x16a
// Size: 0x75
function function_c802f1ac50040a2c()
{
    if ( !isdefined( self.markedomnvar ) )
    {
        self.markedomnvar = 1;
        self setclientomnvar( "ui_rcd_target_notify", self.markedomnvar );
        thread function_41179923bd856516();
        return;
    }
    
    if ( self.markedomnvar == 1 )
    {
        self.markedomnvar = 2;
    }
    else
    {
        self.markedomnvar = 1;
    }
    
    self setclientomnvar( "ui_rcd_target_notify", self.markedomnvar );
}

// Namespace snapshot
// Params 0
// Checksum 0x3cbc1f01, Offset: 0x1e7
// Size: 0x6a
function function_41179923bd856516()
{
    self endon( #"disconnect" );
    self notify( #"hash_4f6c70212967e71e" );
    self endon( #"hash_4f6c70212967e71e" );
    
    if ( utility::issharedfuncdefined( #"helper_drone", #"hash_6d6d7607c322a1b1" ) )
    {
        wait self [[ utility::getsharedfunc( #"helper_drone", #"hash_6d6d7607c322a1b1" ) ]]();
    }
    else
    {
        wait 3;
    }
    
    thread function_9f8f232c138a6f15();
}

// Namespace snapshot
// Params 0
// Checksum 0x488cc0d1, Offset: 0x259
// Size: 0x24
function function_9f8f232c138a6f15()
{
    self notify( #"hash_4f6c70212967e71e" );
    self.markedomnvar = undefined;
    self setclientomnvar( "ui_rcd_target_notify", 0 );
}

