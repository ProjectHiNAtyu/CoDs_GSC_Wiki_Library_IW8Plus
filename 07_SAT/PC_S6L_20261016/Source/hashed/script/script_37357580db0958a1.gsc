// script_37357580db0958a1  (hash_37357580db0958a1.gscc) (size: 1486 Bytes / 0x5ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed6a6e35 (3983175221)
// size ...... 1486 (0x5ce)
// includes .. 2   (offset: 0x596)
// strings ... 2   (offset: 0x5a6)
// dev strs .. 0   (offset: 0x5ce)
// exports ... 8   (offset: 0x352)
// cseg ...... 0x87 + 0x2cb (0x352)
// imports ... 9   (offset: 0x492)
// animtree1 . 0   (offset: 0x5ce)
// animtree2 . 0   (offset: 0x5ce)
#using scripts\common\callbacks;
#using scripts\common\vehicle_damage;

#namespace specialty_repair_occupied_vehicle;

// Namespace specialty_repair_occupied_vehicle
// Params 0, eflags: 0x1
// Checksum 0x9329eea1, Offset: 0xa5
// Size: 0x44
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"player_vehicle_enter", &function_74955eeb0cd63e85 );
    level callback::add( #"player_vehicle_exit", &function_471060c8e7d5933d );
}

// Namespace specialty_repair_occupied_vehicle
// Params 1
// Checksum 0x8c67d4dc, Offset: 0xf1
// Size: 0x38
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_repair_occupied_vehicle", &setspecialty, &unsetspecialty );
    }
}

// Namespace specialty_repair_occupied_vehicle
// Params 0
// Checksum 0x3b052be3, Offset: 0x131
// Size: 0x87
function setspecialty()
{
    bundle = self.var_9842326056fd7207;
    
    if ( !isdefined( bundle.var_ea0d2fc924adf611 ) )
    {
        return;
    }
    
    if ( !isdefined( bundle.var_6c2ade758ec6bfc0 ) )
    {
        return;
    }
    
    self.var_9979f16cb2458ebb = { #repairinterval:bundle.var_6c2ade758ec6bfc0, #repairamount:bundle.var_ea0d2fc924adf611 };
    
    if ( self.vehicle )
    {
        thread function_a135f6bf7c78b020( self.vehicle );
    }
}

// Namespace specialty_repair_occupied_vehicle
// Params 0
// Checksum 0x64a552da, Offset: 0x1c0
// Size: 0x1a
function unsetspecialty()
{
    self notify( "specialty_repair_occupied_vehicle" + "_unset" );
    self.var_9979f16cb2458ebb = undefined;
}

// Namespace specialty_repair_occupied_vehicle
// Params 1, eflags: 0x4
// Checksum 0x145d5c3a, Offset: 0x1e2
// Size: 0x5f
function private function_74955eeb0cd63e85( params )
{
    if ( !isdefined( params ) )
    {
        return;
    }
    
    vehicle = params.vehicle;
    player = params.player;
    
    if ( isdefined( player.perks[ "specialty_repair_occupied_vehicle" ] ) )
    {
        player thread function_a135f6bf7c78b020( vehicle );
    }
}

// Namespace specialty_repair_occupied_vehicle
// Params 1, eflags: 0x4
// Checksum 0x894fbe4a, Offset: 0x249
// Size: 0x38
function private function_471060c8e7d5933d( params )
{
    if ( !isdefined( params ) )
    {
        return;
    }
    
    player = params.player;
    player notify( #"exit_vehicle" );
}

// Namespace specialty_repair_occupied_vehicle
// Params 1, eflags: 0xc
// Checksum 0x178a9e6d, Offset: 0x289
// Size: 0xc9
function private function_a135f6bf7c78b020( vehicle )
{
    self notify( #"hash_b69f2b1735d868eb" );
    self endon( #"hash_b69f2b1735d868eb" );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( "specialty_repair_occupied_vehicle" + "_unset" );
    self endon( #"exit_vehicle" );
    var_575fa5fcfb8b6b1c = self.var_9979f16cb2458ebb.repairamount;
    interval = self.var_9979f16cb2458ebb.repairinterval;
    
    while ( true )
    {
        if ( vehicle.health < vehicle.maxhealth )
        {
            vehicle vehicle_damage::add_health( var_575fa5fcfb8b6b1c );
        }
        
        wait interval;
    }
}

