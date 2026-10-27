// script_3e8f5758c6655e94  (hash_3e8f5758c6655e94.gscc) (size: 5250 Bytes / 0x1482 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8854330f (2287219471)
// size ...... 5250 (0x1482)
// includes .. 6   (offset: 0x12f6)
// strings ... 17  (offset: 0x1326)
// dev strs .. 7   (offset: 0x142e)
// exports ... 16  (offset: 0xcc2)
// cseg ...... 0x1d1 + 0xaf1 (0xcc2)
// imports ... 31  (offset: 0xf42)
// animtree1 . 0   (offset: 0x1482)
// animtree2 . 0   (offset: 0x1482)
#using scripts\common\callbacks;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;

#namespace specialty_perkstreak;

// Namespace specialty_perkstreak
// Params 0, eflags: 0x5
// Checksum 0xfe3cd9b, Offset: 0x1ef
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_6f273c0a8836f1ce );
}

// Namespace specialty_perkstreak
// Params 1, eflags: 0x4
// Checksum 0x5e2ca101, Offset: 0x20f
// Size: 0x78
function private function_6f273c0a8836f1ce( params )
{
    bundle = level.perkbundles[ "specialty_perkstreaks" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_perkstreaks", &setperkstreaks, &unsetperkstreaks, [], &initperkstreaks );
    }
    
    level callback::add( #"hash_bc53f926031ea3f6", &function_5cc1f88469699f3d );
}

// Namespace specialty_perkstreak
// Params 0, eflags: 0x4
// Checksum 0x89afd84b, Offset: 0x28f
// Size: 0x1f5
function private initperkstreaks()
{
    bundle = level.perkbundles[ "specialty_perkstreaks" ];
    level.var_1031594445c3f405 = {};
    level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 0 ] = { #score:bundle.var_be657902c2c7f327 ?? 200 };
    level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 1 ] = { #score:bundle.var_ba7b5513d585d15e ?? 400 };
    level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 2 ] = { #score:bundle.var_e3a7c40601dce6d ?? 600 };
    level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 3 ] = { #score:bundle.var_18efca2709d97b2a ?? 1200 };
    level.var_1031594445c3f405.slotomnvars = [];
    level.var_1031594445c3f405.slotomnvars[ 0 ] = "ui_perk_streak_index_0";
    level.var_1031594445c3f405.slotomnvars[ 1 ] = "ui_perk_streak_index_1";
    level.var_1031594445c3f405.slotomnvars[ 2 ] = "ui_perk_streak_index_2";
    level.var_1031594445c3f405.slotomnvars[ 3 ] = "ui_perk_streak_index_3";
    level.var_1031594445c3f405.costomnvars = [];
    level.var_1031594445c3f405.costomnvars[ 0 ] = "ui_perk_streak_cost_0";
    level.var_1031594445c3f405.costomnvars[ 1 ] = "ui_perk_streak_cost_1";
    level.var_1031594445c3f405.costomnvars[ 2 ] = "ui_perk_streak_cost_2";
    level.var_1031594445c3f405.costomnvars[ 3 ] = "ui_perk_streak_cost_3";
}

// Namespace specialty_perkstreak
// Params 0, eflags: 0x4
// Checksum 0xb77a4451, Offset: 0x48c
// Size: 0x100
function private setperkstreaks()
{
    for ( i = 0; i <= 3 ; i++ )
    {
        self setclientomnvar( level.var_1031594445c3f405.costomnvars[ i ], level.var_1031594445c3f405.var_aab4b2f95c49b7df[ i ].score );
    }
    
    callback::add( #"hash_62785a5e7e758499", &function_3f8ef14f42bdb62f );
    callback::add( #"player_death", &ondeath );
    
    if ( !isdefined( self.pers[ "perkPoints" ] ) )
    {
        self.pers[ "perkPoints" ] = 0;
    }
    
    if ( class::haschangedclass() )
    {
        self.pers[ "perkPoints" ] = 0;
    }
    
    self setclientomnvar( "ui_perk_streak_progress", self.pers[ "perkPoints" ] );
    function_f9ce68bc165a1114( self.perkstreaks );
    function_767a323fd4ff9f52( self.pers[ "perkPoints" ] );
}

// Namespace specialty_perkstreak
// Params 0, eflags: 0x4
// Checksum 0x54c59944, Offset: 0x594
// Size: 0x2c
function private unsetperkstreaks()
{
    callback::remove( #"hash_62785a5e7e758499", &function_3f8ef14f42bdb62f );
    callback::remove( #"player_death", &ondeath );
}

// Namespace specialty_perkstreak
// Params 1, eflags: 0x4
// Checksum 0x3d0d07c4, Offset: 0x5c8
// Size: 0x1e
function private function_3f8ef14f42bdb62f( params )
{
    function_12bca2b73724bdb2( params.scorepoints );
}

// Namespace specialty_perkstreak
// Params 1
// Checksum 0x5c03e84c, Offset: 0x5ee
// Size: 0x42
function function_5cc1f88469699f3d( params )
{
    if ( !params.struct.loadoutusingspecialist )
    {
        return;
    }
    
    function_f9ce68bc165a1114( params.struct.loadoutperkstreaks );
}

// Namespace specialty_perkstreak
// Params 1
// Checksum 0xffa8507d, Offset: 0x638
// Size: 0xdb
function function_767a323fd4ff9f52( points )
{
    for ( i = 0; i < 3 ; i++ )
    {
        if ( self.pers[ "perkPoints" ] < level.var_1031594445c3f405.var_aab4b2f95c49b7df[ i ].score )
        {
            continue;
        }
        
        if ( self.perkstreaks[ i ] )
        {
            class::loadout_giveperk( self.perkstreaks[ i ] );
            
            if ( i == self.perkstreaks.size - 1 )
            {
                self.var_9b8c24cccee1a519 = 1;
            }
        }
    }
    
    var_eedcf14a8d569be1 = level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 3 ];
    
    if ( var_eedcf14a8d569be1 && points >= var_eedcf14a8d569be1.score )
    {
        function_411c641304808fe7();
    }
}

// Namespace specialty_perkstreak
// Params 1, eflags: 0x4
// Checksum 0x2736fa82, Offset: 0x71b
// Size: 0x1c3
function private function_12bca2b73724bdb2( points )
{
    var_eedcf14a8d569be1 = level.var_1031594445c3f405.var_aab4b2f95c49b7df[ 3 ];
    
    if ( self.pers[ "perkPoints" ] >= var_eedcf14a8d569be1.score )
    {
        self.var_9b8c24cccee1a519 = 1;
        callback::remove( #"hash_62785a5e7e758499", &function_3f8ef14f42bdb62f );
        return;
    }
    
    newpoints = max( self.pers[ "perkPoints" ] + points, 0 );
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( self.pers[ "perkPoints" ] >= level.var_1031594445c3f405.var_aab4b2f95c49b7df[ i ].score )
        {
            continue;
        }
        
        if ( newpoints < level.var_1031594445c3f405.var_aab4b2f95c49b7df[ i ].score )
        {
            continue;
        }
        
        if ( self.perkstreaks[ i ] == "specialty_null" )
        {
            continue;
        }
        
        if ( self.perkstreaks[ i ] )
        {
            challenges::function_4330c4e0266b0055();
            thread class::loadout_giveperk( self.perkstreaks[ i ] );
            self setclientomnvar( "ui_spawn_perk_" + i + 3, self.perkstreaks[ i ] );
            self setclientomnvar( "ui_spawn_perks_updated", gettime() );
        }
    }
    
    if ( var_eedcf14a8d569be1 && newpoints >= var_eedcf14a8d569be1.score )
    {
        challenges::function_4330c4e0266b0055();
        function_411c641304808fe7();
    }
    
    self.pers[ "perkPoints" ] = newpoints;
    self setclientomnvar( "ui_perk_streak_progress", self.pers[ "perkPoints" ] );
}

// Namespace specialty_perkstreak
// Params 0
// Checksum 0xb9da3b07, Offset: 0x8e6
// Size: 0x145
function function_411c641304808fe7()
{
    var_fe70c602efa09fe7 = perks::function_73c2b12682fac654();
    var_fe70c602efa09fe7 = arrayremove( var_fe70c602efa09fe7, "specialty_supersprint" );
    var_222e15f0ab6a381c = arraycombine( self.pers[ "loadoutPerks" ], self.perkstreaks );
    
    foreach ( perk in var_222e15f0ab6a381c )
    {
        var_fe70c602efa09fe7 = arrayremove( var_fe70c602efa09fe7, perk );
    }
    
    foreach ( perkref in var_fe70c602efa09fe7 )
    {
        class::loadout_giveperk( perkref );
    }
    
    thread hud_message::showsplash( #"hash_bd8abae3b7c0825e", undefined, undefined, undefined, 1, %"hash_27779808ae60cdd4" );
}

/#

    // Namespace specialty_perkstreak
    // Params 1
    // Checksum 0x1f672e96, Offset: 0xa33
    // Size: 0x93, Type: dev
    function function_2bf249fa10fcb0a7( params )
    {
        perks = [ "<dev string:x24>", "<dev string:x37>", "<dev string:x48>", "<dev string:x65>", "<dev string:x7a>", "<dev string:x92>" ];
        bonusperks = [ "<dev string:xad>" ];
        params.struct.loadoutperkstreaks = { #bonusperks:bonusperks, #perks:perks };
    }

#/

// Namespace specialty_perkstreak
// Params 0
// Checksum 0xce96fe2e, Offset: 0xace
// Size: 0x50
function function_8bb1928c3e0867ea()
{
    var_d1826cb19f27d502 = [];
    
    for ( slotnumber = 0; slotnumber <= 3 ; slotnumber++ )
    {
        var_d1826cb19f27d502[ var_d1826cb19f27d502.size ] = slotnumber;
    }
    
    params = { #var_d1826cb19f27d502:var_d1826cb19f27d502 };
    return params.var_d1826cb19f27d502;
}

// Namespace specialty_perkstreak
// Params 1
// Checksum 0x22f69d6d, Offset: 0xb27
// Size: 0xad
function function_f9ce68bc165a1114( perkstreaks )
{
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_a73c024444a7c5b0 ) )
    {
        self.var_a73c024444a7c5b0 = function_8bb1928c3e0867ea();
    }
    
    foreach ( perkstreakslot in self.var_a73c024444a7c5b0 )
    {
        function_50553a90ee4e5eef( perkstreaks, perkstreakslot );
    }
}

// Namespace specialty_perkstreak
// Params 2
// Checksum 0x6dccf38c, Offset: 0xbdc
// Size: 0xc1
function function_50553a90ee4e5eef( perks, slotnumber )
{
    perkstreaksdata = level.var_1031594445c3f405;
    
    if ( !perkstreaksdata )
    {
        return;
    }
    
    perkstreakitem = perks[ slotnumber ];
    
    if ( !isdefined( perkstreakitem ) || perkstreakitem == "specialty_null" )
    {
        return;
    }
    
    index = undefined;
    
    if ( isdefined( perkstreakitem ) )
    {
        index = perks::getperkid( perkstreakitem );
    }
    
    if ( index > -1 )
    {
        self setclientomnvar( perkstreaksdata.slotomnvars[ slotnumber ], index );
        return;
    }
    
    if ( self function_5c766d1d0140b86( perkstreaksdata.slotomnvars[ slotnumber ] ?? "" ) )
    {
        self setclientomnvar( perkstreaksdata.slotomnvars[ slotnumber ], 0 );
    }
}

// Namespace specialty_perkstreak
// Params 1
// Checksum 0xb88e55d9, Offset: 0xca5
// Size: 0x1d
function ondeath( params )
{
    self.pers[ "perkPoints" ] = 0;
}

