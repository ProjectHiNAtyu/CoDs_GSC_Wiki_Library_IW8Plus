// scripts\mp\disguise_controller.gsc  (hash_67015c88c47ec4f8.gscc) (size: 5056 Bytes / 0x13c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf651d056 (4132556886)
// size ...... 5056 (0x13c0)
// includes .. 5   (offset: 0x1338)
// strings ... 6   (offset: 0x1360)
// dev strs .. 0   (offset: 0x13c0)
// exports ... 20  (offset: 0xc38)
// cseg ...... 0x318 + 0x920 (0xc38)
// imports ... 35  (offset: 0xf58)
// animtree1 . 0   (offset: 0x13c0)
// animtree2 . 0   (offset: 0x13c0)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\equipment\disguise;
#using scripts\mp\common\utility\player;

#namespace disguise_controller;

// Namespace disguise_controller
// Params 1
// Checksum 0xa76c8b5d, Offset: 0x336
// Size: 0x38
function function_eb742d3b36f4ccf1( var_1f88345b6ac6ff1a )
{
    thread function_8fc2d2561ce91039();
    thread function_be1291282fdc5175();
    thread function_8817bc2a53d21f2a();
    
    if ( !isdefined( var_1f88345b6ac6ff1a.execution ) )
    {
        thread function_3a3b52241719e76a();
    }
}

// Namespace disguise_controller
// Params 1
// Checksum 0x1528bfca, Offset: 0x376
// Size: 0x15
function function_3601ee2e43fa5779( var_3961c21bd8aa49ae )
{
    thread disguise::function_f7776d7012343e70( var_3961c21bd8aa49ae );
}

// Namespace disguise_controller
// Params 0
// Checksum 0x5a6db317, Offset: 0x393
// Size: 0x2b
function function_5a4052b50f6dd35c()
{
    if ( !self.var_aea9c1f9cbb526f1 )
    {
        br_gametype_dmz::showdmzsplash( "dmz_disguise_destroyed", [ self ] );
    }
    
    self.var_aea9c1f9cbb526f1 = undefined;
}

// Namespace disguise_controller
// Params 0
// Checksum 0xe10beea2, Offset: 0x3c6
// Size: 0x44
function function_8fc2d2561ce91039()
{
    level endon( #"game_ended" );
    self endon( #"disguise_ended" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    self notify( #"disguise_state_change", "death" );
}

// Namespace disguise_controller
// Params 0
// Checksum 0xc82cb11d, Offset: 0x412
// Size: 0x2d
function function_be1291282fdc5175()
{
    level endon( #"game_ended" );
    self endon( #"disguise_ended" );
    self endon( #"death_or_disconnect" );
    childthread function_25d681aacdd7708a();
}

// Namespace disguise_controller
// Params 0
// Checksum 0xe23a110d, Offset: 0x447
// Size: 0x5c
function function_17158d7964b0f9de()
{
    level endon( #"game_ended" );
    self endon( #"disguise_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        
        if ( function_79aa305d29025cb5() )
        {
            self notify( #"disguise_state_change", "combat" );
            break;
        }
        
        waitframe();
    }
}

// Namespace disguise_controller
// Params 0
// Checksum 0x9f77c897, Offset: 0x4ab
// Size: 0xc5, Type: bool
function function_79aa305d29025cb5()
{
    potentialagents = disguise::function_353f336a0e9e77c2();
    
    foreach ( agent in potentialagents )
    {
        if ( agent cansee( self ) )
        {
            agent setthreatsight( self, 1 );
            agent setpatrolreact( self.origin, "med" );
            
            if ( agent.stealth_enabled )
            {
                agent setstealthstate( "combat" );
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace disguise_controller
// Params 0
// Checksum 0x15c3b030, Offset: 0x579
// Size: 0x9f
function function_25d681aacdd7708a()
{
    level endon( #"game_ended" );
    self endon( #"disguise_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"grenade_thrown", grenade );
        weaponrootname = getweaponrootstring( grenade.weapon_object );
        shouldnotify = 1;
        
        if ( function_cdeaa3a81c939e69( weaponrootname ) )
        {
            shouldnotify = 0;
        }
        else
        {
            shouldnotify = function_79aa305d29025cb5();
        }
        
        if ( shouldnotify )
        {
            self notify( #"disguise_state_change", "combat" );
            break;
        }
        
        waitframe();
    }
}

// Namespace disguise_controller
// Params 1
// Checksum 0xe324056, Offset: 0x620
// Size: 0xe7
function function_7f6fe31e8ead7333( weaponrootname )
{
    switch ( weaponrootname )
    {
        case #"hash_11a03a12f93f62b2":
        case #"hash_1ff8309cfb0a09c5":
        case #"hash_2ab98cab4066a74e":
        case #"hash_333525cef39d0c66":
        case #"hash_36b7174a04de8799":
        case #"hash_3c2d21aea30374d4":
        case #"hash_3cc897796b318cd9":
        case #"hash_42dcb6ce7ecb709c":
        case #"hash_8670ac083666f3a4":
        case #"hash_8747706404533493":
        case #"hash_9d57562863499a06":
        case #"hash_b7f5380094623046":
        case #"hash_b97f84c02b147504":
        case #"hash_e1f6f84e4cd950eb":
        case #"hash_fa1e80f6bd5b8e72":
        case #"hash_fb36696c0708bf42":
            return 1;
        default:
            return 0;
    }
}

// Namespace disguise_controller
// Params 1
// Checksum 0x5909cb51, Offset: 0x70f
// Size: 0x123
function function_cdeaa3a81c939e69( weaponrootname )
{
    switch ( weaponrootname )
    {
        case #"hash_7a494a6441a8df6":
        case #"hash_e61f1a05dec2770":
        case #"hash_13d1f84d0ae96a5f":
        case #"hash_17d5fde761fc574b":
        case #"hash_22dbe57b7df54899":
        case #"hash_26f2bb279cde043f":
        case #"hash_444e24c19329aec0":
        case #"hash_526718f50b85440e":
        case #"hash_64358af9c6c1edea":
        case #"hash_6bc36a1e4f485a79":
        case #"hash_72d6951f1472c8b3":
        case #"hash_7983828e72e83a3e":
        case #"hash_7e0a03ed7c4c87be":
        case #"hash_85d7e1863dca54c4":
        case #"hash_8ae2b02f9a08357a":
        case #"hash_a68928468343f517":
        case #"hash_c03ed6f6f4fe9dad":
        case #"hash_c749c88b18be256f":
        case #"hash_d197e38e5fa659dd":
        case #"hash_e5163523e542c46c":
        case #"hash_f219d5163a73c117":
            return 1;
        default:
            return 0;
    }
}

// Namespace disguise_controller
// Params 0
// Checksum 0xdc85baa8, Offset: 0x83a
// Size: 0x94
function function_8817bc2a53d21f2a()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"disguise_ended" );
    
    while ( true )
    {
        self waittill( #"disguise_state_change", statechange );
        
        if ( function_563eebb62e85fb89( statechange ) )
        {
            var_3961c21bd8aa49ae = statechange == "damaged";
            
            if ( statechange == "damaged" || statechange == "combat" )
            {
                thread function_a2b9617f4c0353bc();
            }
            
            function_3601ee2e43fa5779( var_3961c21bd8aa49ae );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace disguise_controller
// Params 1
// Checksum 0x8ace0027, Offset: 0x8d6
// Size: 0x48
function function_563eebb62e85fb89( disguisestate )
{
    if ( !isdefined( disguisestate ) )
    {
        return 0;
    }
    
    switch ( disguisestate )
    {
        case #"hash_62ff127829215ed0":
        case #"hash_f3194deac31f2ae6":
            return 1;
        default:
            return 0;
    }
}

// Namespace disguise_controller
// Params 0
// Checksum 0xd414966b, Offset: 0x926
// Size: 0x59
function function_c0504b97209f6146()
{
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    if ( isnullweapon( self.currentweapon ) || !isdefined( self.currentweapon ) )
    {
        return 0;
    }
    
    if ( player::isincombat() )
    {
        return 0;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        return 0;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return 0;
    }
    
    return function_da5fe9800abc67ee();
}

// Namespace disguise_controller
// Params 0
// Checksum 0x930d9936, Offset: 0x987
// Size: 0x25, Type: bool
function function_9b4a3491d0fde433()
{
    if ( isnullweapon( self.currentweapon ) || !isdefined( self.currentweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace disguise_controller
// Params 1
// Checksum 0xc468ba83, Offset: 0x9b5
// Size: 0x124
function function_e55cff6322653311( damage )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"disguise_ended" );
    thread function_a2b9617f4c0353bc();
    var_8d50e50be7ca218f = function_4129496151a49c1d( damage );
    disguisedata = disguise::function_8d106ba9f2beec05();
    
    if ( disguisedata.var_d260fc4aa8c9fdef )
    {
        return;
    }
    
    curhealth = disguisedata.health;
    newhealth = curhealth - damage;
    newhealth = int( clamp( newhealth, 0, 108 ) );
    disguisedata.health = newhealth;
    
    if ( isdefined( disguisedata.backpackslot ) )
    {
        br_default_inventory::function_d625d28b11a26654( self, disguisedata.backpackslot, newhealth, 0 );
    }
    
    statemsg = newhealth == 0 ? "end_disguise" : "damaged";
    self notify( #"disguise_state_change", statemsg );
    
    if ( statemsg == "end_disguise" )
    {
        utility::delaythread( getdvarfloat( @"hash_307d1884bcaef28f", 0.45 ), &function_5a4052b50f6dd35c );
    }
}

// Namespace disguise_controller
// Params 1
// Checksum 0x8f99434e, Offset: 0xae1
// Size: 0xe
function function_4129496151a49c1d( damage )
{
    return damage;
}

// Namespace disguise_controller
// Params 1
// Checksum 0x5fef4fa5, Offset: 0xaf8
// Size: 0x9e
function function_a2b9617f4c0353bc( cooldowntime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"killed_player" );
    self notify( #"hash_32e35e95d48a614d" );
    self notify( #"hash_32e35e95d48a614d" );
    
    if ( !isdefined( cooldowntime ) )
    {
        cooldowntime = 5;
    }
    
    self.disguisecooldown = 1;
    counter = 0;
    
    while ( counter < cooldowntime )
    {
        if ( player::isincombat() )
        {
            counter = 0;
        }
        else
        {
            counter += level.framedurationseconds;
        }
        
        waitframe();
    }
    
    self.disguisecooldown = undefined;
}

// Namespace disguise_controller
// Params 0
// Checksum 0x5ea0f16d, Offset: 0xb9e
// Size: 0x50
function function_da5fe9800abc67ee()
{
    if ( !isdefined( self.lastdamagedtime ) )
    {
        return 1;
    }
    
    currenttime = gettime();
    var_13413661eaf5079f = ( currenttime - self.lastdamagedtime ) / 1000;
    
    if ( var_13413661eaf5079f <= 5 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace disguise_controller
// Params 0
// Checksum 0x2bc3590e, Offset: 0xbf6
// Size: 0x42
function function_3a3b52241719e76a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"disguise_ended" );
    
    while ( true )
    {
        self waittill( #"execution_begin" );
        disguise::function_6c48f27f6e373236();
    }
}

