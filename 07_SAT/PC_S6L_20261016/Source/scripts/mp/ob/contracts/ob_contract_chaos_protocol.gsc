// scripts\mp\ob\contracts\ob_contract_chaos_protocol.gsc  (hash_5d462da714ad154e.gscc) (size: 2721 Bytes / 0xaa1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x284501f4 (675611124)
// size ...... 2721 (0xaa1)
// includes .. 8   (offset: 0xa15)
// strings ... 3   (offset: 0xa55)
// dev strs .. 2   (offset: 0xa89)
// exports ... 11  (offset: 0x4c9)
// cseg ...... 0x90 + 0x439 (0x4c9)
// imports ... 32  (offset: 0x681)
// animtree1 . 0   (offset: 0xaa1)
// animtree2 . 0   (offset: 0xaa1)
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\mp\ob\activities\ob_activity_protocol_utility;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_cradle_gas_circle;

#namespace ob_contract_chaos_protocol;

// Namespace ob_contract_chaos_protocol
// Params 0, eflags: 0x5
// Checksum 0xa69d932b, Offset: 0xae
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_51b50b6eec133875", #"activity_common", &function_65a6ca1ff703990f, undefined );
}

// Namespace ob_contract_chaos_protocol
// Params 0, eflags: 0x4
// Checksum 0xc3894bad, Offset: 0xd7
// Size: 0x13
function private function_65a6ca1ff703990f()
{
    activity_common::registeractivitytype( "REV_OB_CHAOS_PROTOCOL", &function_fa50b3e6158a58b2 );
}

// Namespace ob_contract_chaos_protocol
// Params 0
// Checksum 0x6b77e308, Offset: 0xf2
// Size: 0x5e
function function_fa50b3e6158a58b2()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_CHAOS_PROTOCOL", 0, &function_934890a36dd48f5d );
    activity_common::function_944074f3079c1d4e( "REV_OB_CHAOS_PROTOCOL", 1, &function_480efba83e75e225 );
    activity_common::function_944074f3079c1d4e( "REV_OB_CHAOS_PROTOCOL", 2, &function_259e3ff679e51a5 );
    activity_common::function_944074f3079c1d4e( "REV_OB_CHAOS_PROTOCOL", 3, &function_2a53c7ecfa1aa39a );
    scriptable::scriptable_addusedcallbackbypart( "vent", &function_2312e27f9c064d63 );
}

// Namespace ob_contract_chaos_protocol
// Params 6
// Checksum 0xc98317c7, Offset: 0x158
// Size: 0xfd
function function_2312e27f9c064d63( instance, part, state, player, bautouse, usestring )
{
    if ( getxhash( instance getscriptablepartstate( #"vent" ) ) != #"operation_turn_on" )
    {
        return;
    }
    
    instance setscriptablepartstate( #"vent", #"on" );
    
    if ( isdefined( instance.entity ) )
    {
        activity_instance = instance.entity.activity_instance;
        activity_instance ob_cradle_gas_circle::function_715467b4b7feb05a( activity_instance.core_struct );
        
        if ( !arraycontains( activity_instance.opened_vents, instance ) )
        {
            activity_instance.opened_vents[ activity_instance.opened_vents.size ] = instance;
        }
        
        if ( activity_instance function_1af6e1e7d2defccf() )
        {
            activity_instance_common::endactivity( activity_instance, 1 );
        }
    }
}

// Namespace ob_contract_chaos_protocol
// Params 0
// Checksum 0x3390315f, Offset: 0x25d
// Size: 0x39, Type: bool
function function_1af6e1e7d2defccf()
{
    assert( self.opened_vents.size <= self.cradle_vent_struct_array.size, "<dev string:x24>" );
    return self.opened_vents.size == self.cradle_vent_struct_array.size;
}

// Namespace ob_contract_chaos_protocol
// Params 0
// Checksum 0x176b7c6d, Offset: 0x29f
// Size: 0x60
function function_934890a36dd48f5d()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.opened_vents = [];
    self.cradle_vent_struct_array = [];
    self.core_struct = undefined;
    ob_activity_protocol_utility::function_8618ee5905c91177( self.varianttag );
    ob_activity_protocol_utility::function_3e12732acab2906a( #"off" );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_contract_chaos_protocol
// Params 0
// Checksum 0x62cda0f6, Offset: 0x307
// Size: 0xf1
function function_480efba83e75e225()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    encounterid = activity_ai_encounters::function_eb8506829193f5eb( %"hash_436af564e0445400", self.core_struct.origin, 1500, 1, 1, 1, 2 );
    function_1a9d724a960fa19d( encounterid, "spawner_zombie_base", 1 );
    
    foreach ( vent_struct in self.cradle_vent_struct_array )
    {
        vent_struct.ent_scriptable setscriptablepartstate( #"vent", #"operation_turn_on" );
    }
}

// Namespace ob_contract_chaos_protocol
// Params 1
// Checksum 0x7d38be41, Offset: 0x400
// Size: 0x15
function function_259e3ff679e51a5( activity_succeeded )
{
    thread function_8e61b6c5d58de536( 20 );
}

// Namespace ob_contract_chaos_protocol
// Params 1
// Checksum 0xb4ef18d3, Offset: 0x41d
// Size: 0x81
function function_8e61b6c5d58de536( timeout )
{
    linked_instances = ob_activity_manager::function_ed1dae3a9cce08d2( self.varianttag );
    assert( isdefined( linked_instances[ 0 ] ), "<dev string:x56>" );
    
    if ( !isdefined( linked_instances[ 0 ] ) )
    {
        return;
    }
    
    linked_cradle_vents = linked_instances[ 0 ];
    spawn_data = spawnstruct();
    spawn_data.linked_variant_tag = self.varianttag;
    wait timeout;
    ob_activity_manager::function_8c2371421d37415a( linked_cradle_vents, 100, spawn_data );
}

// Namespace ob_contract_chaos_protocol
// Params 0
// Checksum 0xcd6cba70, Offset: 0x4a6
// Size: 0x23
function function_2a53c7ecfa1aa39a()
{
    if ( !function_1af6e1e7d2defccf() )
    {
        ob_activity_protocol_utility::function_c658b31196b794b();
        ob_cradle_gas_circle::function_ad1c37731b23fb82( self.core_struct );
    }
}

