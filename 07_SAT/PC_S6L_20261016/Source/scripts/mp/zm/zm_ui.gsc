// scripts\mp\zm\zm_ui.gsc  (hash_02df2457595c5b24.gscc) (size: 1185 Bytes / 0x4a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc78e81a3 (3348005283)
// size ...... 1185 (0x4a1)
// includes .. 2   (offset: 0x449)
// strings ... 6   (offset: 0x459)
// dev strs .. 0   (offset: 0x4a1)
// exports ... 5   (offset: 0x289)
// cseg ...... 0xcf + 0x1ba (0x289)
// imports ... 8   (offset: 0x351)
// animtree1 . 0   (offset: 0x4a1)
// animtree2 . 0   (offset: 0x4a1)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\stats;

#namespace zm_ui;

// Namespace zm_ui
// Params 0
// Checksum 0x77e37a9b, Offset: 0xed
// Size: 0x18
function init_zm_ui()
{
    level callback::add( #"player_connect", &zm_ui_on_connect );
}

// Namespace zm_ui
// Params 1
// Checksum 0x7fffad33, Offset: 0x10d
// Size: 0x4a
function zm_ui_on_connect( params )
{
    callback::add( "currency_add", &function_f15ba904df264c50 );
    callback::add( "currency_sub", &function_f15ba904df264c50 );
    callback::add( "currency_set", &function_f15ba904df264c50 );
    setomnvar( "ui_hide_nameplates_for_zero_health", 0 );
}

// Namespace zm_ui
// Params 1
// Checksum 0xf6ae6784, Offset: 0x15f
// Size: 0x90
function function_f15ba904df264c50( sparams )
{
    if ( isdefined( sparams.currencytype ) )
    {
        switch ( sparams.currencytype )
        {
            case #"salvage":
                self setclientomnvar( "zm_salvage", int( self.currency[ #"salvage" ] ) );
                break;
            case #"rare_salvage":
                self setclientomnvar( "zm_rare_salvage", int( self.currency[ #"rare_salvage" ] ) );
                break;
        }
    }
}

// Namespace zm_ui
// Params 0
// Checksum 0x5f7d185f, Offset: 0x1f7
// Size: 0x92
function function_b814b25c8d99fd02()
{
    if ( level.var_a7b38b9723de06b8 )
    {
        return;
    }
    
    if ( !isdefined( self.revivecount ) )
    {
        self.revivecount = 0;
    }
    
    if ( !isdefined( self.doorbuycount ) )
    {
        self.doorbuycount = 0;
    }
    
    packedvalue = self.revivecount;
    
    if ( packedvalue > 1023 )
    {
        packedvalue = 1024;
    }
    
    if ( self.doorbuycount > 63 )
    {
        self.doorbuycount = 64;
    }
    
    packedvalue += self.doorbuycount << 10;
    stats::setextrascore3( packedvalue );
}

