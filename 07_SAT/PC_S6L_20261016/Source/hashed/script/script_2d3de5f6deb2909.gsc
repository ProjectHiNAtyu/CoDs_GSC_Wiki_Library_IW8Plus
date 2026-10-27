// script_2d3de5f6deb2909  (hash_02d3de5f6deb2909.gscc) (size: 2119 Bytes / 0x847 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec3c2e41 (3963366977)
// size ...... 2119 (0x847)
// includes .. 3   (offset: 0x7ff)
// strings ... 4   (offset: 0x817)
// dev strs .. 0   (offset: 0x847)
// exports ... 8   (offset: 0x527)
// cseg ...... 0xa8 + 0x47f (0x527)
// imports ... 14  (offset: 0x667)
// animtree1 . 0   (offset: 0x847)
// animtree2 . 0   (offset: 0x847)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\outline;
#using scripts\mp\flags;

#namespace specialty_outline_enemy_vehicles;

// Namespace specialty_outline_enemy_vehicles
// Params 0, eflags: 0x1
// Checksum 0xce210b56, Offset: 0xc6
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_outline_enemy_vehicles
// Params 1
// Checksum 0x9d9b4048, Offset: 0xe6
// Size: 0x38
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_outline_enemy_vehicles", &setspecialty, &unsetspecialty );
    }
}

// Namespace specialty_outline_enemy_vehicles
// Params 0
// Checksum 0x73891d28, Offset: 0x126
// Size: 0x4b
function setspecialty()
{
    self.var_1d3c49652b764335 = { #hudoutline:self.var_9842326056fd7207.var_bfc4e2286570f78d, #viewdistance:self.var_9842326056fd7207.var_7c6b448f5058f43 };
    thread function_81750e775da7ad4b();
}

// Namespace specialty_outline_enemy_vehicles
// Params 0
// Checksum 0x4eb6acff, Offset: 0x179
// Size: 0x1f
function unsetspecialty()
{
    self notify( #"hash_fa7d1f4bb4203a01" );
    self.var_1d3c49652b764335 = undefined;
    function_85e9a5de0b65f845();
}

// Namespace specialty_outline_enemy_vehicles
// Params 0
// Checksum 0x5ae09c26, Offset: 0x1a0
// Size: 0x1ea
function function_81750e775da7ad4b()
{
    self notify( #"hash_81311b1649d3e367" );
    self endon( #"hash_81311b1649d3e367" );
    level endon( #"game_ended" );
    self endon( #"hash_fa7d1f4bb4203a01" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    self.var_e8a78c1731b49279 = [];
    
    while ( true )
    {
        var_a4b8ba057e8c7245 = function_a870dcfd8f3eda2d();
        
        foreach ( vehicle in var_a4b8ba057e8c7245 )
        {
            entnum = vehicle getentitynumber();
            
            if ( !self.var_e8a78c1731b49279[ entnum ] )
            {
                id = outline::outlineenableforplayer( vehicle, self, self.var_1d3c49652b764335.hudoutline ?? "sat_mp_engineer", "perk" );
                self.var_e8a78c1731b49279[ entnum ] = { #vehicle:vehicle, #id:id };
            }
        }
        
        foreach ( entnum, data in self.var_e8a78c1731b49279 )
        {
            if ( !arraycontains( var_a4b8ba057e8c7245, data.vehicle ) )
            {
                outline::outlinedisable( id, data.vehicle );
                self.var_e8a78c1731b49279[ entnum ] = undefined;
            }
        }
        
        wait 1;
    }
}

// Namespace specialty_outline_enemy_vehicles
// Params 0, eflags: 0x4
// Checksum 0x4a1c1fed, Offset: 0x392
// Size: 0xf3
function private function_a870dcfd8f3eda2d()
{
    vehiclesinrange = function_c44b31a67523b336( level.vehicle.all, self.origin, self.var_1d3c49652b764335.viewdistance );
    validvehicles = [];
    
    foreach ( vehicle in vehiclesinrange )
    {
        if ( !vehicle.isempty && vehicle.ownerteam && vehicle.ownerteam != self.team )
        {
            validvehicles[ validvehicles.size ] = vehicle;
        }
    }
    
    return validvehicles;
}

// Namespace specialty_outline_enemy_vehicles
// Params 0, eflags: 0x4
// Checksum 0x21b9f77b, Offset: 0x48e
// Size: 0x99
function private function_85e9a5de0b65f845()
{
    foreach ( data in self.var_e8a78c1731b49279 )
    {
        outline::outlinedisable( data.id, data.vehicle );
    }
    
    self.var_e8a78c1731b49279 = undefined;
}

