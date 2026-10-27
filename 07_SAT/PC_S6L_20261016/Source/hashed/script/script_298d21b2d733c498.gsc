// script_298d21b2d733c498  (hash_298d21b2d733c498.gscc) (size: 5754 Bytes / 0x167a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde21153d (3726710077)
// size ...... 5754 (0x167a)
// includes .. 6   (offset: 0x15c2)
// strings ... 9   (offset: 0x15f2)
// dev strs .. 2   (offset: 0x1662)
// exports ... 19  (offset: 0xcfe)
// cseg ...... 0xfb + 0xc03 (0xcfe)
// imports ... 50  (offset: 0xff6)
// animtree1 . 0   (offset: 0x167a)
// animtree2 . 0   (offset: 0x167a)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;

#namespace namespace_9a55388c9191eb1b;

// Namespace namespace_9a55388c9191eb1b
// Params 0
// Checksum 0x3a8ad0a9, Offset: 0x119
// Size: 0x44
function init()
{
    level.var_bc017a8d71349d84 = { #callbacksregistered:0, #lethalpool:[], #weaponpool:[] };
    utility::flag_wait( "equipment_initialized" );
    function_50394df4170a4045();
    registercallbacks();
}

// Namespace namespace_9a55388c9191eb1b
// Params 0, eflags: 0x4
// Checksum 0x5837ff2c, Offset: 0x165
// Size: 0x23a
function private function_50394df4170a4045()
{
    if ( level.var_4e147a96a4a5740d.var_4e5947b5de95e77f )
    {
        foreach ( entry in level.var_4e147a96a4a5740d.var_4e5947b5de95e77f )
        {
            if ( !entry.weapon )
            {
                continue;
            }
            
            weaponobj = utility::function_64003742d8f5c781( entry.weapon );
            
            if ( !isweapon( weaponobj ) || weaponobj == level.weaponnone )
            {
                continue;
            }
            
            var_26eec689699a7c08 = { #weight:entry.weight ?? 1, #weaponname:weaponobj.basename };
            level.var_bc017a8d71349d84.weaponpool[ level.var_bc017a8d71349d84.weaponpool.size ] = var_26eec689699a7c08;
        }
    }
    
    if ( level.var_4e147a96a4a5740d.var_cc520e02f757a41 )
    {
        foreach ( entry in level.var_4e147a96a4a5740d.var_cc520e02f757a41 )
        {
            if ( !entry.equipment )
            {
                continue;
            }
            
            var_98425c392d79cbae = { #weight:entry.weight ?? 1, #ref:entry.equipment };
            level.var_bc017a8d71349d84.lethalpool[ level.var_bc017a8d71349d84.lethalpool.size ] = var_98425c392d79cbae;
        }
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 0, eflags: 0x4
// Checksum 0xfb9eee17, Offset: 0x3a7
// Size: 0x86
function private registercallbacks()
{
    if ( level.var_bc017a8d71349d84.callbacksregistered )
    {
        return;
    }
    
    level.var_bc017a8d71349d84.callbacksregistered = 1;
    level callback::add( "on_zombie_ai_killed", &function_36e82b3eaa874d78 );
    
    if ( level.var_bc017a8d71349d84.weaponpool.size > 0 )
    {
        level callback::add( #"item_spawn_weapon_obj", &function_89dcc2fb4a6b7fc6 );
        level callback::add( #"hash_28245a6d2061f779", &function_4ae9a049d40ec16f );
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 1
// Checksum 0x4db66543, Offset: 0x435
// Size: 0x8b
function function_36e82b3eaa874d78( params )
{
    zombie = self;
    attacker = params.eattacker;
    
    if ( attacker && !isplayer( attacker ) && isplayer( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( zombie.specialproperties.var_7957a5f65931aaea )
    {
        zombie function_9a433475b1404d4d( attacker );
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 1
// Checksum 0x28021113, Offset: 0x4c8
// Size: 0x108
function function_9a433475b1404d4d( attacker )
{
    zombie = self;
    
    if ( !isplayer( attacker ) || !isdefined( attacker.team ) )
    {
        return;
    }
    
    rewardteam = attacker.team;
    
    if ( level.var_bc017a8d71349d84.weaponpool.size > 0 )
    {
        weaponref = function_84d03a5cd94f9c2e( level.var_bc017a8d71349d84.weaponpool );
        
        if ( weaponref )
        {
            spawnorigin = getclosestpointonnavmesh( zombie.origin ) ?? zombie.origin;
            function_8eee14bab22f61f4( spawnorigin, rewardteam, weaponref );
        }
    }
    
    if ( level.var_bc017a8d71349d84.lethalpool.size > 0 )
    {
        lethalref = function_84d03a5cd94f9c2e( level.var_bc017a8d71349d84.lethalpool );
        
        if ( lethalref )
        {
            function_50ffea504a44cc95( rewardteam, lethalref );
        }
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0xdd5adefb, Offset: 0x5d8
// Size: 0xc6
function private function_84d03a5cd94f9c2e( pool )
{
    if ( pool.size == 0 )
    {
        return;
    }
    
    weights = [];
    
    foreach ( entry in pool )
    {
        weights[ weights.size ] = entry.weight;
    }
    
    selected = utility::random_weighted( pool, weights );
    return selected.ref ?? selected.weaponname;
}

// Namespace namespace_9a55388c9191eb1b
// Params 3, eflags: 0x4
// Checksum 0x551ccac3, Offset: 0x6a7
// Size: 0x1ed
function private function_8eee14bab22f61f4( origin, team, weaponname )
{
    weaponobj = weapon_utility::function_d2c8356dc369d9ce( weaponname );
    
    if ( weaponobj === level.weaponnone )
    {
        assertmsg( "<dev string:x24>" + weaponname );
        return;
    }
    
    spawnorigin = origin + ( 0, 0, 32 );
    spawnflags = 1;
    weaponentity = utility::function_a0b2f814bf08507f( weaponname, spawnorigin, [], ( 45, 45, 45 ), spawnflags );
    
    if ( !weaponentity )
    {
        assertmsg( "<dev string:x65>" );
        return;
    }
    
    weaponentity makeunusable();
    weaponentity hudoutlineenable( "outlinefill_golden_gun" );
    pickup = {};
    pickup.weaponname = weaponobj.basename;
    pickup.weaponobj = weaponobj;
    pickup.team = team;
    pickup.claimed = 0;
    pickup.weaponentity = weaponentity;
    pickup.useobject = spawn( "script_model", weaponentity.origin );
    pickup.useobject setmodel( "tag_origin" );
    pickup.useobject linkto( weaponentity );
    pickup.useobject makeusable();
    pickup.useobject setuserange( 96 );
    pickup.useobject setuseholdduration( "duration_none" );
    pickup.useobject setcursorhint( "HINT_NOICON" );
    pickup.useobject sethintdisplayrange( 96 );
    pickup.useobject sethintstring( &"mp_ingame_only/roulette_gun_pick_up" );
    level thread function_6a57c6709b599326( pickup );
    level thread function_8637f87bbc38d9f1( pickup );
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0x21a9b35d, Offset: 0x89c
// Size: 0xa0
function private function_6a57c6709b599326( pickup )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        pickup.useobject waittill( #"trigger", player );
        
        if ( pickup.claimed )
        {
            return;
        }
        
        if ( !isplayer( player ) || !player::isreallyalive( player ) || player utility::isusingremote() )
        {
            continue;
        }
        
        if ( player.team != pickup.team )
        {
            continue;
        }
        
        player function_8bbe69c014a26ed1( pickup );
        return;
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0xf6418cf1, Offset: 0x944
// Size: 0x33
function private function_8637f87bbc38d9f1( pickup )
{
    level endon( #"game_ended" );
    wait 45;
    
    if ( pickup.claimed )
    {
        return;
    }
    
    function_aea1d72c449fe71d( pickup );
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0x6e5392d5, Offset: 0x97f
// Size: 0xaf
function private function_8bbe69c014a26ed1( pickup )
{
    if ( function_2a4d0fa223098ec3( self ) )
    {
        self takeweapon( self.var_aef0b9d8492125ef );
    }
    
    function_a0c27e82735f79( self );
    self giveweapon( pickup.weaponobj );
    
    if ( !self hasweapon( pickup.weaponobj ) )
    {
        return;
    }
    
    self switchtoweaponimmediate( pickup.weaponobj );
    self.var_aef0b9d8492125ef = pickup.weaponobj;
    self.var_3adad58c3dd27659 = pickup.weaponname;
    self notify( #"hash_6f87885fa9c990ad" );
    pickup.claimed = 1;
    function_aea1d72c449fe71d( pickup );
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0x30ccad82, Offset: 0xa36
// Size: 0x66
function private function_aea1d72c449fe71d( pickup )
{
    pickup.claimed = 1;
    
    if ( pickup.useobject )
    {
        pickup.useobject makeunusable();
        pickup.useobject delete();
    }
    
    if ( pickup.weaponentity )
    {
        pickup.weaponentity delete();
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 2, eflags: 0x4
// Checksum 0xb91028e8, Offset: 0xaa4
// Size: 0xc7
function private function_50ffea504a44cc95( team, lethalref )
{
    awardplayers = teams::getteamdata( team, "alivePlayers" ) ?? [];
    
    foreach ( player in awardplayers )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player equipment_mp::giveequipment( lethalref, "primary" );
        player equipment_mp::setequipmentslotammo( "primary", 1 );
    }
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0xe5406c9c, Offset: 0xb73
// Size: 0x75
function private function_89dcc2fb4a6b7fc6( params )
{
    player = self;
    
    if ( !params.weapon || !function_99c30e2806cebd97( player ) )
    {
        return;
    }
    
    if ( !function_1a5b34bf2e930437( player, params.weapon ) )
    {
        return;
    }
    
    if ( params.instance )
    {
        params.instance freescriptable();
    }
    
    function_a0c27e82735f79( player );
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0x6cedb8dd, Offset: 0xbf0
// Size: 0x14
function private function_4ae9a049d40ec16f( params )
{
    function_a0c27e82735f79( self );
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0x4daeb93, Offset: 0xc0c
// Size: 0x26, Type: bool
function private function_99c30e2806cebd97( player )
{
    return player.var_aef0b9d8492125ef && player.var_3adad58c3dd27659;
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0x51bdbb10, Offset: 0xc3b
// Size: 0x3c, Type: bool
function private function_2a4d0fa223098ec3( player )
{
    if ( !function_99c30e2806cebd97( player ) )
    {
        return false;
    }
    
    if ( !player hasweapon( player.var_aef0b9d8492125ef ) )
    {
        function_a0c27e82735f79( player );
        return false;
    }
    
    return true;
}

// Namespace namespace_9a55388c9191eb1b
// Params 2, eflags: 0x4
// Checksum 0x766e9408, Offset: 0xc80
// Size: 0x4c, Type: bool
function private function_1a5b34bf2e930437( player, weaponobj )
{
    if ( !function_99c30e2806cebd97( player ) )
    {
        return false;
    }
    
    return player.var_aef0b9d8492125ef == weaponobj || player.var_3adad58c3dd27659 == weaponobj.basename;
}

// Namespace namespace_9a55388c9191eb1b
// Params 1, eflags: 0x4
// Checksum 0xcd5f8a87, Offset: 0xcd5
// Size: 0x29
function private function_a0c27e82735f79( player )
{
    if ( !player )
    {
        return;
    }
    
    player.var_aef0b9d8492125ef = undefined;
    player.var_3adad58c3dd27659 = undefined;
}

