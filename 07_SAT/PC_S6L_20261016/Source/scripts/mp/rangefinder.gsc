// scripts\mp\rangefinder.gsc  (hash_5b79f5ce7e653825.gscc) (size: 2046 Bytes / 0x7fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63fab4f1 (1677374705)
// size ...... 2046 (0x7fe)
// includes .. 0   (offset: 0x776)
// strings ... 10  (offset: 0x776)
// dev strs .. 0   (offset: 0x7fe)
// exports ... 8   (offset: 0x46e)
// cseg ...... 0xfe + 0x370 (0x46e)
// imports ... 15  (offset: 0x5ae)
// animtree1 . 0   (offset: 0x7fe)
// animtree2 . 0   (offset: 0x7fe)
#namespace rangefinder;

// Namespace rangefinder
// Params 0
// Checksum 0x2679fa75, Offset: 0x11c
// Size: 0x93
function runmprangefinder()
{
    precachemodel( "mw_scale_soldier" );
    precachemodel( "mw_test_soldier" );
    precachemodel( "mw_dist_soldier" );
    wait 5;
    
    while ( true )
    {
        if ( getdvarint( @"scr_rangefinder", 0 ) == 1 )
        {
            node = createcamnode();
            thread addmodeltoplayer( node );
            
            while ( getdvarint( @"scr_rangefinder", 0 ) == 1 )
            {
                wait 0.01;
            }
            
            node delete();
            level notify( #"rangefinder_end" );
        }
        
        wait 0.01;
    }
}

// Namespace rangefinder
// Params 0
// Checksum 0x5092953f, Offset: 0x1b7
// Size: 0x51
function createcamnode()
{
    cam = spawn( "script_origin", level.players[ 0 ].origin );
    cam.targetname = "createCamNode";
    cam thread monitorplacement();
    cam thread managelink();
    return cam;
}

// Namespace rangefinder
// Params 0
// Checksum 0xa5cd7311, Offset: 0x211
// Size: 0xb0
function monitorplacement()
{
    level endon( #"game_ended" );
    level endon( #"rangefinder_end" );
    self.placementmode = "player";
    
    while ( true )
    {
        if ( getdvarint( @"scr_rangefinder", 0 ) == 1 )
        {
            if ( level.players[ 0 ] usebuttonpressed() )
            {
                self.placementmode = self.placementmode == "player" ? "stationary" : "player";
                level.players[ 0 ] notify( #"hash_2a34035bc5bc7854" );
                
                while ( level.players[ 0 ] usebuttonpressed() )
                {
                    waitframe();
                }
            }
        }
        
        wait 0.01;
    }
}

// Namespace rangefinder
// Params 0
// Checksum 0x1adce880, Offset: 0x2c9
// Size: 0x76
function managelink()
{
    level endon( #"game_ended" );
    level endon( #"rangefinder_end" );
    thread softlink();
    
    while ( true )
    {
        level.players[ 0 ] waittill( #"hash_2a34035bc5bc7854" );
        
        if ( self.placementmode == "player" )
        {
            iprintlnbold( "LINKED MODE" );
            thread softlink();
        }
        else
        {
            iprintlnbold( "STATIONARY MODE" );
        }
        
        wait 0.01;
    }
}

// Namespace rangefinder
// Params 0
// Checksum 0xe72704de, Offset: 0x347
// Size: 0xa2
function softlink()
{
    level.players[ 0 ] endon( #"hash_2a34035bc5bc7854" );
    level endon( #"rangefinder_end" );
    
    while ( true )
    {
        self.angles = ( 0, 90 + level.players[ 0 ].angles[ 1 ], 0 );
        offset = anglestoforward( level.players[ 0 ].angles ) * 40;
        self.origin = level.players[ 0 ].origin - offset;
        wait 0.01;
    }
}

// Namespace rangefinder
// Params 1
// Checksum 0xdf579eb2, Offset: 0x3f1
// Size: 0x60
function addmodeltoplayer( node )
{
    rangefinder = spawn( "script_model", node.origin );
    rangefinder.angles = node.angles;
    rangefinder setmodel( "mw_dist_soldier" );
    rangefinder linkto( node );
    rangefinder thread watchrangefinderend();
}

// Namespace rangefinder
// Params 0
// Checksum 0x4327c5da, Offset: 0x459
// Size: 0x15
function watchrangefinderend()
{
    level waittill( #"rangefinder_end" );
    self delete();
}

