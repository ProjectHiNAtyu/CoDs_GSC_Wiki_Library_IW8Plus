// script_611390344d345d7  (hash_0611390344d345d7.gscc) (size: 3587 Bytes / 0xe03 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaca4d95d (2896484701)
// size ...... 3587 (0xe03)
// includes .. 6   (offset: 0xd27)
// strings ... 12  (offset: 0xd57)
// dev strs .. 1   (offset: 0xdf7)
// exports ... 14  (offset: 0x5eb)
// cseg ...... 0x134 + 0x4b7 (0x5eb)
// imports ... 45  (offset: 0x81b)
// animtree1 . 0   (offset: 0xe03)
// animtree2 . 0   (offset: 0xe03)
#using script_71cef547a69e4a26;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;

#namespace ability_guts_throw;

// Namespace ability_guts_throw
// Params 0, eflags: 0x5
// Checksum 0xccc6adfd, Offset: 0x152
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ability_guts_throw", #"ability_manager", &pre_main, undefined );
}

// Namespace ability_guts_throw
// Params 0, eflags: 0x4
// Checksum 0x2f606a9a, Offset: 0x17b
// Size: 0x5e
function private pre_main()
{
    ability_manager::register_ability( { #refresh_func:&function_5ac3aeae527733e2, #cleanup_func:&function_be18bee7c6706875, #assigned_func:&function_733af978fbb2ceb9, #activate_func:&on_activate_ability, #can_activate_func:&can_activate_ability, #ref:"guts_throw" } );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0x4f68f9bc, Offset: 0x1e1
// Size: 0x125, Type: bool
function private can_activate_ability( params )
{
    if ( equipment_mp::getequipmentammo( params.var_83195f10e1e12a6a.equipment ) <= 0 )
    {
        return false;
    }
    
    if ( self ismeleeing() )
    {
        return false;
    }
    
    if ( self ismantling() || self ishanging() )
    {
        return false;
    }
    
    if ( self isonzipline() || self isonascender() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self ismeatshieldactive() )
    {
        return false;
    }
    
    if ( !self isweaponsenabled() )
    {
        return false;
    }
    
    if ( self function_c14b349706b01c1b() || self function_a6d700f2335edc93() )
    {
        return false;
    }
    
    if ( self isskydiving() || self isinfreefall() || self isparachuting() )
    {
        return false;
    }
    
    if ( self isswimming() || self isswimunderwater() || self function_fbf06f80548d841d() )
    {
        return false;
    }
    
    if ( params.slot == "lethal" )
    {
        if ( !val::get( "offhand_primary_weapons" ) )
        {
            return false;
        }
        
        if ( !val::get( "equipment_primary" ) )
        {
            return false;
        }
    }
    else
    {
        if ( !val::get( "offhand_secondary_weapons" ) )
        {
            return false;
        }
        
        if ( !val::get( "equipment_secondary" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0xf3b8f792, Offset: 0x30f
// Size: 0x34
function private on_activate_ability( params )
{
    childthread function_594e7a2a3468698f( params );
    childthread function_42111ebb0b3fb2fc( params );
    utility::waittill_any( "guts_thrown", "offhand_end", "tripped_failsafe" );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0x75b0b0e9, Offset: 0x34b
// Size: 0x1e
function private function_733af978fbb2ceb9( params )
{
    childthread function_958da60d0dd0736b( params );
    refill_equipment( params );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0xc81d0c01, Offset: 0x371
// Size: 0x15
function private function_5ac3aeae527733e2( params )
{
    refill_equipment( params );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0xa2cc5068, Offset: 0x38e
// Size: 0x15
function private function_be18bee7c6706875( params )
{
    take_equipment( params );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0x59e37088, Offset: 0x3ab
// Size: 0x52
function private refill_equipment( params )
{
    equipment_slot = get_equipment_slot( params.slot );
    equipment_mp::giveequipment( params.var_83195f10e1e12a6a.equipment, equipment_slot );
    equipment_mp::setequipmentslotammo( equipment_slot, 1 );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0x1ac06fc4, Offset: 0x405
// Size: 0xe3
function private function_958da60d0dd0736b( params )
{
    level endon( #"game_ended" );
    self endon( #"hash_27eaf97f3f25fa11" );
    self endon( #"death_or_disconnect" );
    
    for ( ;; )
    {
        self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
        
        if ( !weapon::grenadethrown( grenade ) )
        {
            continue;
        }
        
        self playsound( "zxp_grenade_vo_npc", undefined, self );
        ability = ability_manager::function_d9911c70ee1ac503( "guts_throw" );
        
        if ( !ability.is_active )
        {
            assertmsg( "<dev string:x24>" );
            refill_equipment( params );
            continue;
        }
        
        wait 0.5;
        self notify( #"guts_thrown", grenade );
        take_equipment( params );
    }
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0xb37614a3, Offset: 0x4f0
// Size: 0x32
function private function_594e7a2a3468698f( params )
{
    self endon( #"grenade_fire" );
    utility::waittill_any( "offhand_end", "tripped_failsafe" );
    take_equipment( params );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0xc0126c0, Offset: 0x52a
// Size: 0x68
function private function_42111ebb0b3fb2fc( params )
{
    self endon( #"grenade_fire" );
    self endon( #"offhand_end" );
    start_time = gettime();
    
    while ( !utility::time_has_passed( start_time, 0.5 ) )
    {
        if ( self isthrowinggrenade() || weapon::grenadeinpullback() )
        {
            return;
        }
        
        waitframe();
    }
    
    self notify( #"tripped_failsafe" );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0x77543a1b, Offset: 0x59a
// Size: 0x24
function private take_equipment( params )
{
    equipment_mp::takeequipment( get_equipment_slot( params.slot ) );
}

// Namespace ability_guts_throw
// Params 1, eflags: 0x4
// Checksum 0x9759daf0, Offset: 0x5c6
// Size: 0x24
function private get_equipment_slot( slot )
{
    return slot == "lethal" ? "primary" : "secondary";
}

