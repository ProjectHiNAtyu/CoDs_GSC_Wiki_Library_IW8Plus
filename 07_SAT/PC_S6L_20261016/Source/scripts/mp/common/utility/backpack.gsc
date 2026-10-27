// scripts\mp\common\utility\backpack.gsc  (hash_01ad67fd5a48925d.gscc) (size: 835 Bytes / 0x343 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x685062b2 (1750098610)
// size ...... 835 (0x343)
// includes .. 0   (offset: 0x30b)
// strings ... 2   (offset: 0x30b)
// dev strs .. 2   (offset: 0x32b)
// exports ... 3   (offset: 0x1c7)
// cseg ...... 0x88 + 0x13f (0x1c7)
// imports ... 7   (offset: 0x23f)
// animtree1 . 0   (offset: 0x343)
// animtree2 . 0   (offset: 0x343)
#namespace backpack;

// Namespace backpack
// Params 1
// Checksum 0x713e5a11, Offset: 0xa6
// Size: 0xa2
function attachbag( bagmodel )
{
    assert( isplayer( self ), "<dev string:x24>" );
    
    if ( !level.gametypebundle.showbackpack )
    {
        return;
    }
    
    if ( isdefined( self.attached_bag ) )
    {
        detachbag();
    }
    
    self attach( bagmodel, "tag_stowed_back3", 1, 1 );
    
    if ( !isdefined( self.operatorcustomization.body ) )
    {
        if ( self tagexists( "TAG_STOWED_BACKPACK_HIDE" ) )
        {
            self hidepart( "TAG_STOWED_BACKPACK_HIDE" );
        }
    }
    
    self.attached_bag = bagmodel;
    self notify( #"backpack_attachbag" );
}

// Namespace backpack
// Params 0
// Checksum 0xd536e807, Offset: 0x150
// Size: 0x77
function detachbag()
{
    assert( isplayer( self ), "<dev string:x5f>" );
    
    if ( !level.gametypebundle.showbackpack || !isdefined( self.attached_bag ) )
    {
        return;
    }
    
    self detach( self.attached_bag, "tag_stowed_back3" );
    self.var_93f641b22a146494 = self.attached_bag;
    self.attached_bag = undefined;
    self notify( #"backpack_detachbag" );
}

