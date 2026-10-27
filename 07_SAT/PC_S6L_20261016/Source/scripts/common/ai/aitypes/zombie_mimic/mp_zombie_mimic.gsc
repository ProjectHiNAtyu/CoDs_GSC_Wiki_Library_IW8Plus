// scripts\common\ai\aitypes\zombie_mimic\mp_zombie_mimic.gsc  (hash_1e3684a3b8b6557a.gscc) (size: 1798 Bytes / 0x706 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x896052e9 (2304791273)
// size ...... 1798 (0x706)
// includes .. 5   (offset: 0x682)
// strings ... 7   (offset: 0x6aa)
// dev strs .. 0   (offset: 0x706)
// exports ... 5   (offset: 0x3a2)
// cseg ...... 0xe6 + 0x2bc (0x3a2)
// imports ... 19  (offset: 0x46a)
// animtree1 . 0   (offset: 0x706)
// animtree2 . 0   (offset: 0x706)
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_prop_spawn;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;

#namespace mp_zombie_mimic;

// Namespace mp_zombie_mimic
// Params 2
// Checksum 0xf63abc53, Offset: 0x104
// Size: 0xb1
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_559af509a83b6172 ) )
    {
        return;
    }
    
    level.var_559af509a83b6172 = 1;
    level thread namespace_a3764ff99ce0cd56::function_de819190b982b94e();
    level.var_29b254229e44041c = "mimicproplist:jup_mimic_prop_list_default";
    namespace_a3764ff99ce0cd56::function_e38030e0f56f312b( 1, &namespace_a3764ff99ce0cd56::function_931cd02a834f49f7, &function_38ee6a14779dd269 );
    
    if ( !isdefined( level.var_35b49e9ab3037480 ) )
    {
        aitypes = agent_utils::get_aitype_by_subclass( "zombie_mimic" );
        level.var_35b49e9ab3037480 = utility::array_random( aitypes );
    }
    
    level callback::add( "mimic_spawned", &killstreak_weapon_on_spawn );
    level callback::add( "on_entity_hidden_in_prop", &function_e6e4d173c6451de8 );
}

// Namespace mp_zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x64518e8, Offset: 0x1bd
// Size: 0x2b
function private killstreak_weapon_on_spawn( params )
{
    weapon::registerkillstreakweaponmap( "zombie_mimic", self.grenadeweapon.basename );
}

// Namespace mp_zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0xd128ac70, Offset: 0x1f0
// Size: 0x94, Type: bool
function private function_38ee6a14779dd269( lure_prop_struct )
{
    if ( lure_prop_struct.interact ishintinoperable() || !lure_prop_struct.interact function_45c212dce7227aa7() || !lure_prop_struct.interact isusable() )
    {
        return false;
    }
    
    if ( lure_prop_struct.interact isscriptable() && lure_prop_struct.interact getscriptablehaspart( "base" ) && lure_prop_struct.interact getscriptablepartstate( "base" ) == "power_off" )
    {
        return false;
    }
    
    return true;
}

// Namespace mp_zombie_mimic
// Params 1, eflags: 0x4
// Checksum 0x5891991e, Offset: 0x28d
// Size: 0x115
function private function_e6e4d173c6451de8( params )
{
    level endon( #"game_ended" );
    self notify( #"hash_680d8f6a58819720" );
    self endon( #"hash_680d8f6a58819720" );
    var_82209d06b3fad29d = self.var_82209d06b3fad29d;
    self waittill( #"death", killer, meansofdeath );
    
    if ( meansofdeath != "MOD_DESPAWN" )
    {
        return;
    }
    
    if ( !isarray( var_82209d06b3fad29d ) )
    {
        return;
    }
    
    foreach ( prop in var_82209d06b3fad29d )
    {
        if ( !isdefined( prop ) )
        {
            continue;
        }
        
        if ( isdefined( prop.var_8aa77779eb1a5e0b ) )
        {
            [[ prop.var_8aa77779eb1a5e0b ]]();
        }
        
        level thread namespace_a3764ff99ce0cd56::function_c727c09ec08aed83( prop );
    }
}

