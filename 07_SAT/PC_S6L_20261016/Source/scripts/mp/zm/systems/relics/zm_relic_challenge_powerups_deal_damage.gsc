// scripts\mp\zm\systems\relics\zm_relic_challenge_powerups_deal_damage.gsc  (hash_014523b40a2d895a.gscc) (size: 1907 Bytes / 0x773 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5ac70e3 (3584848099)
// size ...... 1907 (0x773)
// includes .. 4   (offset: 0x72f)
// strings ... 1   (offset: 0x74f)
// dev strs .. 2   (offset: 0x75b)
// exports ... 8   (offset: 0x3d7)
// cseg ...... 0x67 + 0x370 (0x3d7)
// imports ... 19  (offset: 0x517)
// animtree1 . 0   (offset: 0x773)
// animtree2 . 0   (offset: 0x773)
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\systems\zm_powerups;

#namespace zm_relic_challenge_powerups_deal_damage;

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 0, eflags: 0x5
// Checksum 0x5e82736e, Offset: 0x85
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_d85ae51e3409e6f7", undefined, &function_84fad588721a7fb7, undefined );
}

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 0
// Checksum 0x10bd9e62, Offset: 0xa6
// Size: 0xa
function function_84fad588721a7fb7()
{
    level thread function_db7924ea8c747980();
}

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 0
// Checksum 0x3911f898, Offset: 0xb8
// Size: 0x1c
function function_db7924ea8c747980()
{
    zm_relic_challenges::register_relic_challenge_functions( #"powerups_deal_damage", &function_2394190d0b8c6e5e, &function_3c8763b3951fa7d );
}

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 0
// Checksum 0x501db996, Offset: 0xdc
// Size: 0x153
function function_2394190d0b8c6e5e()
{
    level.default_powerups_root = powerups::get_powerups_root();
    level.powerups_root_override = structcopy( level.default_powerups_root, 1 );
    
    foreach ( var_80666b216a7f972 in level.powerups_root_override.powerups )
    {
        var_80666b216a7f972.func_grab_powerup = &override_func_grab_powerup;
    }
    
    level.powerups_root = level.powerups_root_override;
    level.powerups_root.powerup_droprate = 0.45;
    level.powerups_root.is_allowed_drop_event = 1;
    
    if ( level.active_relic_challenge )
    {
        level.active_relic_challenge.var_55fa97ff4c8976a3 = 1;
    }
    
    powerups::register_powerup_dropped_callback( &function_ac8b95bb5965f259 );
    level.var_db574ba71bb3d2ef = level.powerups_root.dropped_callbacks.size - 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 0
// Checksum 0xdb8d3288, Offset: 0x237
// Size: 0x87
function function_3c8763b3951fa7d()
{
    level.powerups_root_override.powerups = undefined;
    level.powerups_root_override = undefined;
    level.relic_challenge_powerups = undefined;
    
    if ( level.active_relic_challenge )
    {
        level.active_relic_challenge.var_55fa97ff4c8976a3 = undefined;
    }
    
    level.powerups_root = level.default_powerups_root;
    level.powerups_root.dropped_callbacks[ level.var_db574ba71bb3d2ef ] = undefined;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x55>" );
    #/
}

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 2
// Checksum 0x7de47ba7, Offset: 0x2c6
// Size: 0x5d
function override_func_grab_powerup( str_powerup, ent_powerup )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self earthquakeforplayer( 0.5, 1, self.origin, 100 );
    self dodamage( self.maxhealth * 0.6, self.origin, ent_powerup, ent_powerup, "MOD_UNKNOWN" );
}

// Namespace zm_relic_challenge_powerups_deal_damage
// Params 1
// Checksum 0xb1348aff, Offset: 0x32b
// Size: 0xac
function function_ac8b95bb5965f259( powerup )
{
    if ( level.powerups_root_override )
    {
        level.powerups_root.powerup_droprate = 0.45;
        namespace_c0d2b08434f47155::set_current_round_drop_count( 0 );
        
        if ( !isdefined( level.relic_challenge_powerups ) )
        {
            level.relic_challenge_powerups = [];
        }
        
        level.relic_challenge_powerups[ level.relic_challenge_powerups.size ] = powerup;
        level.relic_challenge_powerups = function_5713d46873b29625( level.relic_challenge_powerups );
        
        if ( level.relic_challenge_powerups.size > 15 )
        {
            powerup_last = level.relic_challenge_powerups[ 0 ];
            powerup_last powerups::powerup_delete();
        }
    }
}

