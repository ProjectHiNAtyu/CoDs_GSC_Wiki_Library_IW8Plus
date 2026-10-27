// scripts\mp\vintage.gsc  (hash_3bdb5206acb499de.gscc) (size: 2690 Bytes / 0xa82 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x56e50d55 (1457851733)
// size ...... 2690 (0xa82)
// includes .. 6   (offset: 0x99e)
// strings ... 12  (offset: 0x9ce)
// dev strs .. 0   (offset: 0xa82)
// exports ... 9   (offset: 0x53e)
// cseg ...... 0x151 + 0x3ed (0x53e)
// imports ... 26  (offset: 0x6a6)
// animtree1 . 0   (offset: 0xa82)
// animtree2 . 0   (offset: 0xa82)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;

#namespace vintage;

// Namespace vintage
// Params 0, eflags: 0x1
// Checksum 0x1171204b, Offset: 0x16f
// Size: 0xa
function autoexec init()
{
    level thread init_onstartgametype();
}

// Namespace vintage
// Params 0
// Checksum 0xf2622ae1, Offset: 0x181
// Size: 0xf3
function init_onstartgametype()
{
    level endon( #"game_ended" );
    utility::flag_wait( "onStartGameTypeFinished" );
    level.vintageModeEnabled = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vintageModeEnabled" );
    
    if ( level.vintageModeEnabled )
    {
        callback::add( #"loadout_given", &function_9cd6f2e7c37b4eea );
        callback::add( #"player_spawned", &onspawnplayer );
        callback::add( #"player_connect", &onplayerconnect );
        level.var_8f92f9719855e8f1 = &function_79227851d2d572a;
        knifebundle = getscriptbundle( level.gamemodebundle.defaultknife );
        knifeassetname = knifebundle.asset;
        knifeweapon = weapon_utility::function_d2c8356dc369d9ce( knifeassetname );
        level.var_7271fd8a60a05e16 = knifeweapon;
    }
}

// Namespace vintage
// Params 1
// Checksum 0x3da1bb8a, Offset: 0x27c
// Size: 0xa4
function function_9cd6f2e7c37b4eea( params )
{
    val::set( "Vintage", "slide", 0 );
    
    if ( isdefined( self.perks[ "specialty_melee_infinite_tac_sprint" ] ) )
    {
        perk::removeperk( "specialty_melee_infinite_tac_sprint" );
    }
    
    if ( !isdefined( self.perks[ "specialty_looper" ] ) )
    {
        perk::giveperk( "specialty_looper" );
    }
    
    if ( !isdefined( self.perks[ "specialty_melee_without_swap" ] ) )
    {
        perk::giveperk( "specialty_melee_without_swap" );
    }
    
    waitframe();
    
    if ( isdefined( self.perks[ "specialty_hand_to_hand" ] ) )
    {
        perk::removeperk( "specialty_hand_to_hand" );
    }
    
    function_b31abf7e6e7d3da3();
}

// Namespace vintage
// Params 1
// Checksum 0x8e3e6a7a, Offset: 0x328
// Size: 0x54
function onspawnplayer( params )
{
    val::set( "Vintage", "slide", 0 );
    val::set( "Vintage", "mount_top", 0 );
    val::set( "Vintage", "mount_side", 0 );
    val::set( "Vintage", "execution_attack", 0 );
}

// Namespace vintage
// Params 1
// Checksum 0x816ee3d5, Offset: 0x384
// Size: 0x2d
function onplayerconnect( params )
{
    self endon( #"disconnect" );
    level waittill( #"player_spawned" );
    waitframe();
    thread function_560c1f004f962310();
}

// Namespace vintage
// Params 0, eflags: 0x4
// Checksum 0x625e647a, Offset: 0x3b9
// Size: 0x67
function private function_b31abf7e6e7d3da3()
{
    tertiaryobj = self.var_cc1262e66dbb1c79;
    
    if ( tertiaryobj === level.var_7271fd8a60a05e16 )
    {
        return;
    }
    
    if ( self hasweapon( tertiaryobj ) )
    {
        self takeweapon( tertiaryobj );
    }
    
    self giveweapon( level.var_7271fd8a60a05e16 );
    weapon::function_b4c9549dee5d0fc5( level.var_7271fd8a60a05e16 );
    self assignweaponmeleeslot( level.var_7271fd8a60a05e16 );
}

// Namespace vintage
// Params 0, eflags: 0x4
// Checksum 0xb3ba8ca7, Offset: 0x428
// Size: 0x9d
function private function_79227851d2d572a()
{
    var_bb7c5ef1945a7e0b = [];
    
    foreach ( streakname in getarraykeys( level.cratedata.ksweights ) )
    {
        if ( killstreakisrestricted( streakname ) )
        {
            var_bb7c5ef1945a7e0b[ var_bb7c5ef1945a7e0b.size ] = streakname;
        }
    }
    
    return var_bb7c5ef1945a7e0b;
}

// Namespace vintage
// Params 0, eflags: 0x4
// Checksum 0x40ed12e0, Offset: 0x4ce
// Size: 0x70
function private function_560c1f004f962310()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( level.matchcountdowntime <= 2 || getdvarint( @"hash_fa2d5369cdc37f2a", 1 ) == 0 )
    {
        return;
    }
    
    pbgpostfxbundlestart( self, %"hash_4fceb64d6fe8a7fe" );
    
    while ( level.matchcountdowntime >= 2 )
    {
        waitframe();
    }
    
    pbgpostfxbundleend( self, %"hash_4fceb64d6fe8a7fe" );
}

