// scripts\mp\ob\activities\ob_activity_protocol_utility.gsc  (hash_11eff7198823fe3d.gscc) (size: 1443 Bytes / 0x5a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe6fa2bfc (3875154940)
// size ...... 1443 (0x5a3)
// includes .. 2   (offset: 0x563)
// strings ... 4   (offset: 0x573)
// dev strs .. 0   (offset: 0x5a3)
// exports ... 5   (offset: 0x3b3)
// cseg ...... 0x94 + 0x31f (0x3b3)
// imports ... 8   (offset: 0x47b)
// animtree1 . 0   (offset: 0x5a3)
// animtree2 . 0   (offset: 0x5a3)
#using scripts\common\utility;
#using scripts\mp\ob\systems\ob_resource_manager;

#namespace ob_activity_protocol_utility;

// Namespace ob_activity_protocol_utility
// Params 1
// Checksum 0x9c7396ac, Offset: 0xb2
// Size: 0xdc
function function_8618ee5905c91177( varianttag )
{
    struct_array = utility::getstructarray( varianttag, "script_noteworthy" );
    
    foreach ( struct in struct_array )
    {
        if ( struct.targetname == "power_core" )
        {
            self.core_struct = struct;
            continue;
        }
        
        if ( issubstr( struct.targetname, "vent_" ) )
        {
            self.cradle_vent_struct_array[ self.cradle_vent_struct_array.size ] = struct;
        }
    }
}

// Namespace ob_activity_protocol_utility
// Params 2
// Checksum 0x7c807374, Offset: 0x196
// Size: 0x168
function function_3e12732acab2906a( var_b862b7ade8aec0ec = undefined, var_cf34d10873711169 = undefined )
{
    foreach ( vent_struct in self.cradle_vent_struct_array )
    {
        if ( !isdefined( vent_struct.ent_scriptable ) )
        {
            vent_struct.ent_scriptable = ob_resource_manager::activity_spawn_entity( "script_model", vent_struct.origin );
            vent_struct.ent_scriptable setmodel( %"ob_cradle_vent" );
            vent_struct.ent_scriptable.angles = vent_struct.angles;
        }
        
        vent_struct.ent_scriptable.activity_instance = self;
        vent_struct.ent_scriptable.parent = vent_struct;
        
        if ( isdefined( var_b862b7ade8aec0ec ) )
        {
            vent_struct.ent_scriptable setscriptablepartstate( #"vent", var_b862b7ade8aec0ec );
        }
        
        if ( isdefined( var_cf34d10873711169 ) )
        {
            [[ var_cf34d10873711169 ]]( vent_struct.ent_scriptable, self );
        }
    }
}

// Namespace ob_activity_protocol_utility
// Params 0
// Checksum 0x158aceaf, Offset: 0x306
// Size: 0x9c
function function_ee1bdabad1c1cbd2()
{
    foreach ( vent_struct in self.cradle_vent_struct_array )
    {
        if ( isdefined( vent_struct.ent_scriptable ) )
        {
            vent_struct.ent_scriptable delete();
            vent_struct.ent_scriptable = undefined;
        }
    }
}

// Namespace ob_activity_protocol_utility
// Params 0
// Checksum 0xcc75ce32, Offset: 0x3aa
// Size: 0x9
function function_c658b31196b794b()
{
    function_ee1bdabad1c1cbd2();
}

