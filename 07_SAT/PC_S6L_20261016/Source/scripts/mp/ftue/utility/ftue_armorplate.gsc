// scripts\mp\ftue\utility\ftue_armorplate.gsc  (hash_4a852353eb9522f6.gscc) (size: 1437 Bytes / 0x59d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xabc59e51 (2881855057)
// size ...... 1437 (0x59d)
// includes .. 1   (offset: 0x565)
// strings ... 1   (offset: 0x56d)
// dev strs .. 3   (offset: 0x579)
// exports ... 8   (offset: 0x335)
// cseg ...... 0x6e + 0x2c7 (0x335)
// imports ... 8   (offset: 0x475)
// animtree1 . 0   (offset: 0x59d)
// animtree2 . 0   (offset: 0x59d)
#using scripts\mp\armor;

#namespace ftue_armorplate;

// Namespace ftue_armorplate
// Params 3
// Checksum 0xcb08741e, Offset: 0x8c
// Size: 0x60
function function_7d089489f61c1716( player, position, pickedcallback )
{
    var_78e7416ea6080fad = function_6191995d63b2053c( player );
    item = function_278dc864ee00dcdf( position, ( 0, 0, 0 ), player );
    player thread function_b922ef0b941a4b5( var_78e7416ea6080fad, pickedcallback );
    return item;
}

// Namespace ftue_armorplate
// Params 1, eflags: 0x4
// Checksum 0x17931796, Offset: 0xf5
// Size: 0x22
function private function_6191995d63b2053c( player )
{
    count = player armor::function_22290101992e4874();
    return count;
}

// Namespace ftue_armorplate
// Params 3, eflags: 0x4
// Checksum 0x9197e837, Offset: 0x120
// Size: 0x59
function private function_278dc864ee00dcdf( position, rotation, player )
{
    item = spawnscriptable( "brloot_armor_plate", position, rotation, undefined, 0 );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    function_ee57abb0b2a74452( item );
    item.count = 1;
    return item;
}

// Namespace ftue_armorplate
// Params 1, eflags: 0x4
// Checksum 0x7144f0e4, Offset: 0x182
// Size: 0xb7
function private function_ee57abb0b2a74452( instance )
{
    assert( isdefined( level.br_pickups ), "<dev string:x24>" );
    assert( isdefined( level.br_pickups.scriptables ), "<dev string:x6c>" );
    assert( !isdefined( instance.brpickupscriptableid ), "<dev string:xaf>" );
    id = level.br_pickups.scriptablescurid;
    instance.brpickupscriptableid = id;
    level.br_pickups.scriptables[ id ] = instance;
    level.br_pickups.scriptablescurid++;
}

// Namespace ftue_armorplate
// Params 2, eflags: 0x4
// Checksum 0xd340eb48, Offset: 0x241
// Size: 0x59
function private function_b922ef0b941a4b5( var_299f220557bb499f, pickedcallback )
{
    self endon( #"death_or_disconnect" );
    currentvalue = function_6191995d63b2053c( self );
    
    while ( var_299f220557bb499f == currentvalue )
    {
        currentvalue = function_6191995d63b2053c( self );
        
        if ( currentvalue < var_299f220557bb499f )
        {
            var_299f220557bb499f = currentvalue;
        }
        
        waitframe();
    }
    
    self [[ pickedcallback ]]();
}

// Namespace ftue_armorplate
// Params 2
// Checksum 0x9b85dd48, Offset: 0x2a2
// Size: 0x37
function function_91df8a090f98b63e( player, equipcallback )
{
    currentarmorhealth = player.armorhealth;
    player thread function_5dcb92ced3904f82( currentarmorhealth, equipcallback );
}

// Namespace ftue_armorplate
// Params 2, eflags: 0x4
// Checksum 0x49b0413d, Offset: 0x2e1
// Size: 0x54
function private function_5dcb92ced3904f82( originalarmorhealth, equipcallback )
{
    self endon( #"death_or_disconnect" );
    
    while ( originalarmorhealth == self.armorhealth )
    {
        waitframe();
        
        if ( self.armorhealth < originalarmorhealth )
        {
            originalarmorhealth = self.armorhealth;
        }
    }
    
    self [[ equipcallback ]]();
}

