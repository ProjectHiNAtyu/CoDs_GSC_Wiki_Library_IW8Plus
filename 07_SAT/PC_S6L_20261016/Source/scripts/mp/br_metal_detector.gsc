// scripts\mp\br_metal_detector.gsc  (hash_00fc53edfa47f13b.gscc) (size: 3254 Bytes / 0xcb6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ca22ff0 (480391152)
// size ...... 3254 (0xcb6)
// includes .. 7   (offset: 0xbe6)
// strings ... 12  (offset: 0xc1e)
// dev strs .. 0   (offset: 0xcb6)
// exports ... 10  (offset: 0x786)
// cseg ...... 0x109 + 0x67d (0x786)
// imports ... 25  (offset: 0x916)
// animtree1 . 0   (offset: 0xcb6)
// animtree2 . 0   (offset: 0xcb6)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\game;
#using scripts\mp\compass_ping;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;

#namespace br_metal_detector;

// Namespace br_metal_detector
// Params 0
// Checksum 0x23b2cbe2, Offset: 0x127
// Size: 0x1d
function init()
{
    if ( !getdvarint( @"scr_br_metal_detector_enabled", 1 ) )
    {
        return;
    }
    
    thread metalinit();
}

// Namespace br_metal_detector
// Params 0
// Checksum 0x7f98beab, Offset: 0x14c
// Size: 0x199
function metalinit()
{
    level endon( #"game_ended" );
    scriptbundle = game_utility_mp::function_cb7ed8e67866f9d0( "metaldetectorrewards" );
    triggers = getnoentvolumearray( "metalalarm", #script_noteworthy );
    
    foreach ( trigger in triggers )
    {
        trigger.detector = function_73eac604ff999e59( trigger.target );
        
        if ( scriptbundle )
        {
            trigger.detector.dropstruct = function_abb69c0a47927d0f( trigger.detector.target );
            trigger.detector.rewarddata = scriptbundle;
        }
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    wait 1;
    
    foreach ( trigger in triggers )
    {
        if ( isdefined( trigger.detector ) )
        {
            trigger thread function_aec53d4c3cc29518();
        }
    }
}

// Namespace br_metal_detector
// Params 0
// Checksum 0x916f91a1, Offset: 0x2ed
// Size: 0x8d
function function_aec53d4c3cc29518()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", var_70028c1616e6ef89 );
        dlog_recordevent( "dlog_event_br_metal_detector", [ "detector_x", self.origin[ 0 ], "detector_y", self.origin[ 1 ], "detector_z", self.origin[ 2 ] ] );
        startalarm( var_70028c1616e6ef89 );
    }
}

// Namespace br_metal_detector
// Params 1
// Checksum 0x92bdc8d0, Offset: 0x382
// Size: 0x36
function function_73eac604ff999e59( targetname )
{
    [ ent ] = getentitylessscriptablearray( targetname, #targetname );
    return ent;
}

// Namespace br_metal_detector
// Params 1
// Checksum 0x9590b3f3, Offset: 0x3c1
// Size: 0x22
function function_abb69c0a47927d0f( targetname )
{
    struct = utility::getstruct( targetname );
    return struct;
}

// Namespace br_metal_detector
// Params 1
// Checksum 0x10f453fc, Offset: 0x3ec
// Size: 0xe6
function startalarm( var_70028c1616e6ef89 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.detector ) )
    {
        return;
    }
    
    if ( var_70028c1616e6ef89 vehicle::is_vehicle() )
    {
        var_70028c1616e6ef89 = vehicle_occupancy::get_driver( var_70028c1616e6ef89 );
    }
    
    if ( isplayer( var_70028c1616e6ef89 ) )
    {
        var_70028c1616e6ef89 thread compass_ping::function_dbdadcbcc530c346( 3000, 3000, 2000 );
        
        if ( self.detector.rewarddata )
        {
            var_edb960791061d05b = self.detector function_823b458d31144403( var_70028c1616e6ef89 );
        }
    }
    
    if ( var_edb960791061d05b )
    {
        self.detector setscriptablepartstate( "root", "special", 1 );
    }
    else
    {
        self.detector setscriptablepartstate( "root", "on", 1 );
    }
    
    wait 5;
    self.detector setscriptablepartstate( "root", "off", 1 );
}

// Namespace br_metal_detector
// Params 1
// Checksum 0x9ad2ad60, Offset: 0x4da
// Size: 0xb8, Type: bool
function function_823b458d31144403( player )
{
    if ( !isdefined( self.pingedplayers ) )
    {
        self.pingedplayers = [];
    }
    
    if ( !isdefined( self.pingedplayers[ player.name ] ) )
    {
        self.pingedplayers[ player.name ] = 0;
    }
    
    self.pingedplayers[ player.name ] += 1;
    
    if ( self.pingedplayers[ player.name ] == self.rewarddata.var_8db11a4c9838f427 )
    {
        spawnreward( player );
        return true;
    }
    
    return false;
}

// Namespace br_metal_detector
// Params 1
// Checksum 0x9592af7c, Offset: 0x59b
// Size: 0xf5
function spawnreward( player )
{
    rewards = function_39b4eb86f68511df( player );
    
    foreach ( rewardstruct in rewards )
    {
        rewardbundle = hashcat( %"itemspawnentry:", rewardstruct.reward );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.dropstruct.origin, self.dropstruct.angles );
        common_item::function_61c2c0251e742ffd( rewardbundle, rewardstruct.quantity, spawnoptions );
    }
}

// Namespace br_metal_detector
// Params 1
// Checksum 0xe51fed9e, Offset: 0x698
// Size: 0xed
function function_39b4eb86f68511df( player )
{
    rewards = [];
    
    foreach ( reward in self.rewarddata.rewardstruct )
    {
        if ( reward.requireditemtype == "nothing" || player common_item::function_c4c43ebb7aa636dc( reward.requireditemtype ) )
        {
            rewards[ rewards.size ] = { #quantity:reward.quantity, #reward:reward.rewarditemspawnentry };
        }
    }
    
    return rewards;
}

