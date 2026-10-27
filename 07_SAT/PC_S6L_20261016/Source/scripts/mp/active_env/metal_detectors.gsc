// scripts\mp\active_env\metal_detectors.gsc  (hash_5269b42fbb136cc8.gscc) (size: 1001 Bytes / 0x3e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef95261e (4019529246)
// size ...... 1001 (0x3e9)
// includes .. 0   (offset: 0x3b5)
// strings ... 4   (offset: 0x3b5)
// dev strs .. 0   (offset: 0x3e9)
// exports ... 5   (offset: 0x225)
// cseg ...... 0x7b + 0x1aa (0x225)
// imports ... 7   (offset: 0x2ed)
// animtree1 . 0   (offset: 0x3e9)
// animtree2 . 0   (offset: 0x3e9)
#namespace metal_detectors;

// Namespace metal_detectors
// Params 0
// Checksum 0x1b1b12cc, Offset: 0x99
// Size: 0xd5
function init_metal_detectors()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    var_c83b3ac7a0baf6dc = getnoentvolumearray( "metalalarm", #script_noteworthy );
    
    foreach ( var_b0f4270e0b5e5b2b in var_c83b3ac7a0baf6dc )
    {
        var_b0f4270e0b5e5b2b.scr_metal_detector = get_metal_detector( var_b0f4270e0b5e5b2b.target );
        
        if ( isdefined( var_b0f4270e0b5e5b2b.scr_metal_detector ) )
        {
            var_b0f4270e0b5e5b2b thread watch_trigger();
        }
    }
}

// Namespace metal_detectors
// Params 0
// Checksum 0xb08847f3, Offset: 0x176
// Size: 0x2a
function watch_trigger()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        start_alarm();
    }
}

// Namespace metal_detectors
// Params 1
// Checksum 0xf315d6ef, Offset: 0x1a8
// Size: 0x1d
function get_metal_detector( str_targetname )
{
    return getentitylessscriptablearray( str_targetname, #targetname )[ 0 ];
}

// Namespace metal_detectors
// Params 0
// Checksum 0xd3f9b496, Offset: 0x1ce
// Size: 0x57
function start_alarm()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.scr_metal_detector ) )
    {
        return;
    }
    
    self.scr_metal_detector setscriptablepartstate( "root", "on", 1 );
    wait 5;
    self.scr_metal_detector setscriptablepartstate( "root", "off", 1 );
}

