// scripts\common\ai\stealth\friendly.gsc  (hash_51b5b9b62c387798.gscc) (size: 2449 Bytes / 0x991 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6108086 (3322970246)
// size ...... 2449 (0x991)
// includes .. 5   (offset: 0x8c5)
// strings ... 7   (offset: 0x8ed)
// dev strs .. 1   (offset: 0x985)
// exports ... 9   (offset: 0x479)
// cseg ...... 0xb9 + 0x3c0 (0x479)
// imports ... 25  (offset: 0x5e1)
// animtree1 . 0   (offset: 0x991)
// animtree2 . 0   (offset: 0x991)
#using scripts\common\ai\stealth\callbacks;
#using scripts\common\ai\stealth\debug;
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;

#namespace friendly;

// Namespace friendly
// Params 0
// Checksum 0xee9fdb0e, Offset: 0xd7
// Size: 0x41
function main()
{
    if ( !isdefined( level.stealth ) )
    {
        stealth_manager::main();
    }
    
    init_settings();
    self.stealth_groupname = self.script_stealthgroup;
    thread spotted_thread();
    
    /#
        thread debug::debug_friendly();
    #/
}

// Namespace friendly
// Params 0
// Checksum 0xec1ddf4b, Offset: 0x120
// Size: 0x7d
function init_settings()
{
    assert( !isdefined( self.stealth ), "<dev string:x24>" );
    self.stealth = spawnstruct();
    self.stealth.funcs = [];
    utility::ent_flag_init( "stealth_enabled" );
    utility::ent_flag_set( "stealth_enabled" );
    utility::ent_flag_init( "stealth_in_shadow" );
    utility::group_flag_init( "stealth_spotted" );
    utility::group_add();
    self.stealth_bsmstate = 0;
}

// Namespace friendly
// Params 0
// Checksum 0xc052578, Offset: 0x1a5
// Size: 0xa2
function spotted_thread()
{
    self endon( #"death" );
    self notify( #"spotted_thread" );
    self endon( #"spotted_thread" );
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        utility::group_flag_waitopen( "stealth_spotted" );
        
        if ( !utility::ent_flag( "stealth_enabled" ) )
        {
            utility::ent_flag_wait( "stealth_enabled" );
        }
        
        thread state_hidden();
        utility::ent_flag_wait( "stealth_enabled" );
        utility::group_flag_wait( "stealth_spotted" );
        
        if ( !utility::ent_flag( "stealth_enabled" ) )
        {
            utility::ent_flag_wait( "stealth_enabled" );
        }
        
        thread state_spotted();
    }
}

// Namespace friendly
// Params 0
// Checksum 0xbecf7787, Offset: 0x24f
// Size: 0x7a
function state_hidden()
{
    thread utility::setbattlechatter( 0 );
    self.stealth.oldgrenadeammo = self.grenadeammo;
    self.grenadeammo = 0;
    self.forcesidearm = 0;
    self.dontevershoot = 1;
    self.dontattackme = 1;
    
    if ( isdefined( self.stealth.funcs[ "hidden" ] ) )
    {
        callbacks::stealth_call_thread( "hidden" );
    }
}

// Namespace friendly
// Params 0
// Checksum 0x3ea9111d, Offset: 0x2d1
// Size: 0x9e
function state_spotted()
{
    assert( !isplayer( self ) );
    thread utility::setbattlechatter( 1 );
    
    if ( isdefined( self.stealth.oldgrenadeammo ) )
    {
        self.grenadeammo = self.stealth.oldgrenadeammo;
    }
    else
    {
        self.grenadeammo = 3;
    }
    
    self.dontevershoot = 0;
    self.dontattackme = 0;
    self pushplayer( 0 );
    
    if ( isdefined( self.stealth.funcs[ "spotted" ] ) )
    {
        callbacks::stealth_call_thread( "spotted" );
    }
}

// Namespace friendly
// Params 0
// Checksum 0xbd23433f, Offset: 0x377
// Size: 0xe
function getup_from_prone()
{
    self endon( #"death" );
}

// Namespace friendly
// Params 0
// Checksum 0x3f6cc9ef, Offset: 0x38d
// Size: 0x5b
function visibility_thread()
{
    self endon( #"death" );
    self endon( #"long_death" );
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        
        if ( !isdefined( self.stealth.ignore_visibility ) )
        {
            self.maxvisibledist = get_detect_range();
        }
        
        wait 0.05;
    }
}

// Namespace friendly
// Params 0
// Checksum 0x25791c59, Offset: 0x3f0
// Size: 0x88
function get_detect_range()
{
    stance = self.currentpose;
    
    if ( stance == "back" )
    {
        stance = "prone";
    }
    
    if ( utility::group_spotted_flag() )
    {
        detection = "spotted";
    }
    else
    {
        detection = "hidden";
    }
    
    range = getstealthdetectrange( detection, stance );
    
    if ( utility::ent_flag( "stealth_in_shadow" ) )
    {
        range = max( getstealthdetectrange( "hidden", "prone" ), range * 0.5 );
    }
    
    return range;
}

