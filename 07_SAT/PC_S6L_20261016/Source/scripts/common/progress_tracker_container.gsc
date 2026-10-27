// scripts\common\progress_tracker_container.gsc  (hash_3e31016b9c11a616.gscc) (size: 1619 Bytes / 0x653 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57a2c226 (1470284326)
// size ...... 1619 (0x653)
// includes .. 1   (offset: 0x5f7)
// strings ... 0   (offset: 0x5ff)
// dev strs .. 4   (offset: 0x5ff)
// exports ... 10  (offset: 0x327)
// cseg ...... 0x58 + 0x2cf (0x327)
// imports ... 9   (offset: 0x4b7)
// animtree1 . 0   (offset: 0x653)
// animtree2 . 0   (offset: 0x653)
#using scripts\common\progress_tracker;

#namespace progress_tracker_container;

// Namespace progress_tracker_container
// Params 0
// Checksum 0xbfabf840, Offset: 0x76
// Size: 0xc
function function_4854307e3a8d494b()
{
    self.progresstrackers = [];
}

// Namespace progress_tracker_container
// Params 0
// Checksum 0x9ce70d2b, Offset: 0x8a
// Size: 0x11, Type: bool
function function_ab32c21fadcfccfa()
{
    return isdefined( self ) && isdefined( self.progresstrackers );
}

// Namespace progress_tracker_container
// Params 1
// Checksum 0x5d27035a, Offset: 0xa4
// Size: 0x45
function getprogresstracker( uniquename )
{
    assert( function_ab32c21fadcfccfa(), "<dev string:x24>" );
    assert( isdefined( self.progresstrackers[ uniquename ] ), "<dev string:x65>" );
    return self.progresstrackers[ uniquename ];
}

// Namespace progress_tracker_container
// Params 2
// Checksum 0x8d95490d, Offset: 0xf2
// Size: 0x59
function addprogresstracker( uniquename, progresstracker )
{
    if ( !function_ab32c21fadcfccfa() )
    {
        function_4854307e3a8d494b();
    }
    
    assert( !isdefined( self.progresstrackers[ uniquename ] ), "<dev string:xb2>" );
    progresstracker progress_tracker::setuniquename( uniquename );
    self.progresstrackers[ uniquename ] = progresstracker;
}

// Namespace progress_tracker_container
// Params 1
// Checksum 0x3374ea2c, Offset: 0x153
// Size: 0x5c
function endprogresstracker( uniquename )
{
    assert( function_ab32c21fadcfccfa(), "<dev string:x24>" );
    assert( isdefined( self.progresstrackers[ uniquename ] ), "<dev string:x65>" );
    self.progresstrackers[ uniquename ] notify( #"hash_308138f33e37837e" );
    self.progresstrackers[ uniquename ] = undefined;
}

// Namespace progress_tracker_container
// Params 2
// Checksum 0x3a7d8d04, Offset: 0x1b7
// Size: 0x56
function function_62443c6229d7e9ea( uniquename, incrementvalue )
{
    assert( function_ab32c21fadcfccfa(), "<dev string:x24>" );
    assert( isdefined( self.progresstrackers[ uniquename ] ), "<dev string:x108>" );
    self.progresstrackers[ uniquename ] progress_tracker::incrementcurrentprogress( incrementvalue );
}

// Namespace progress_tracker_container
// Params 2
// Checksum 0x8159a0a, Offset: 0x215
// Size: 0x56
function function_b1f5209537075d76( uniquename, decrementvalue )
{
    assert( function_ab32c21fadcfccfa(), "<dev string:x24>" );
    assert( isdefined( self.progresstrackers[ uniquename ] ), "<dev string:x108>" );
    self.progresstrackers[ uniquename ] progress_tracker::decrementcurrentprogress( decrementvalue );
}

// Namespace progress_tracker_container
// Params 2
// Checksum 0x206727a4, Offset: 0x273
// Size: 0x56
function function_c47bfeecd65c7559( uniquename, progressvalue )
{
    assert( function_ab32c21fadcfccfa(), "<dev string:x24>" );
    assert( isdefined( self.progresstrackers[ uniquename ] ), "<dev string:x108>" );
    self.progresstrackers[ uniquename ] progress_tracker::setcurrentprogress( progressvalue );
}

// Namespace progress_tracker_container
// Params 2
// Checksum 0x17a45f, Offset: 0x2d1
// Size: 0x56
function function_9b26069820498cb4( uniquename, finalvalue )
{
    assert( function_ab32c21fadcfccfa(), "<dev string:x24>" );
    assert( isdefined( self.progresstrackers[ uniquename ] ), "<dev string:x108>" );
    self.progresstrackers[ uniquename ] progress_tracker::setfinalvalue( finalvalue );
}

