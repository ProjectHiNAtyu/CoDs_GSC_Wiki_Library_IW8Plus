// script_5e7dba7c18c08f5a  (hash_5e7dba7c18c08f5a.gscc) (size: 1413 Bytes / 0x585 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x83b578f2 (2209708274)
// size ...... 1413 (0x585)
// includes .. 5   (offset: 0x4b5)
// strings ... 11  (offset: 0x4dd)
// dev strs .. 0   (offset: 0x585)
// exports ... 4   (offset: 0x2e1)
// cseg ...... 0xf3 + 0x1ee (0x2e1)
// imports ... 11  (offset: 0x381)
// animtree1 . 0   (offset: 0x585)
// animtree2 . 0   (offset: 0x585)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_fc27622d9019ee2f;

// Namespace namespace_fc27622d9019ee2f
// Params 0
// Checksum 0x6a85d7e2, Offset: 0x111
// Size: 0x25
function init()
{
    if ( getdvarint( @"hash_124531c7380b8e64", 0 ) )
    {
        level callback::add( "on_zombie_ai_spawned", &function_589342a9c3b10055 );
    }
}

// Namespace namespace_fc27622d9019ee2f
// Params 1, eflags: 0x4
// Checksum 0x40260b86, Offset: 0x13e
// Size: 0x50
function private function_589342a9c3b10055( params )
{
    var_31a025cdd36577c7 = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( issubstr( var_31a025cdd36577c7.script_zone_name, "zone_ts" ) )
    {
        init_tz_zombie( self );
        iprintlnbold( "zombie Spawned" );
    }
}

// Namespace namespace_fc27622d9019ee2f
// Params 1, eflags: 0x4
// Checksum 0xb0ac2ffc, Offset: 0x196
// Size: 0x14b
function private init_tz_zombie( zombie )
{
    zombie.no_powerups = 1;
    
    if ( zombie.aicategory == "normal" )
    {
        zombie.kiastring = #"zombie_kia_mission_kill";
    }
    
    if ( zombie.subclass == "zombie_base" )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
    }
    
    round_increase = zm_round_logic::get_rb_round_number() + 5;
    zombie zombie_utils::set_zombie_round_difficulty( round_increase );
    zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "super_sprint" == "super_sprint" || "super_sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "super_sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "super_sprint" == "sprint" ? "run" : "super_sprint", "zm_tz_zombie", 6 );
}

