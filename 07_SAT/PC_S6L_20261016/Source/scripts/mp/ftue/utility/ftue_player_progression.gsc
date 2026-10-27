// scripts\mp\ftue\utility\ftue_player_progression.gsc  (hash_530f3ea26428deba.gscc) (size: 3225 Bytes / 0xc99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7dc87139 (2110288185)
// size ...... 3225 (0xc99)
// includes .. 6   (offset: 0xc11)
// strings ... 7   (offset: 0xc41)
// dev strs .. 0   (offset: 0xc99)
// exports ... 15  (offset: 0x5a5)
// cseg ...... 0xa9 + 0x4fc (0x5a5)
// imports ... 35  (offset: 0x7fd)
// animtree1 . 0   (offset: 0xc99)
// animtree2 . 0   (offset: 0xc99)
#using scripts\common\progression_utility;
#using scripts\common\weapon;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\gamelogic;
#using scripts\mp\rank;
#using scripts\mp\weaponrank;

#namespace ftue_player_progression;

// Namespace ftue_player_progression
// Params 0
// Checksum 0xaca6851d, Offset: 0xc7
// Size: 0x1e, Type: bool
function function_42a11a46de05070e()
{
    return ftue_progress::ftue_enabled() && getdvarint( @"hash_81f6cb3096a4d43d", 1 ) == 1;
}

// Namespace ftue_player_progression
// Params 0
// Checksum 0x4265abaa, Offset: 0xee
// Size: 0x28, Type: bool
function function_76ad20455a04c832()
{
    player = self;
    return player ftue_progress::function_53132d48c3fb23af( 2 ) && !player ftue_progress::function_53132d48c3fb23af( 3 );
}

// Namespace ftue_player_progression
// Params 1
// Checksum 0x2a9c0b46, Offset: 0x11f
// Size: 0x4b
function function_1eaf19809fb8566f( player )
{
    if ( !ftue_progress::ftue_enabled() || isbot( player ) )
    {
        return;
    }
    
    if ( player function_76ad20455a04c832() )
    {
        player ftue_progress::function_5dcbb86a0b038621( 3, 1 );
        
        if ( function_42a11a46de05070e() )
        {
            return player function_97e20e39cb3db7a8();
        }
    }
}

// Namespace ftue_player_progression
// Params 0
// Checksum 0x654876a4, Offset: 0x173
// Size: 0x72
function function_4a8cbb20b35eb6d1()
{
    if ( !ftue_progress::function_53132d48c3fb23af( 2 ) )
    {
        return 0;
    }
    
    var_b4ed688511c264e4 = function_76ad20455a04c832();
    
    if ( var_b4ed688511c264e4 )
    {
        self.var_15dfdd0e99a759e5 = 1;
    }
    
    tipsenabled = var_b4ed688511c264e4;
    
    if ( !tipsenabled )
    {
        for ( progress = 3; progress <= 12 ; progress++ )
        {
            if ( function_8f7ab9c09eb1de1c( progress ) )
            {
                tipsenabled = 1;
                break;
            }
        }
    }
    
    return tipsenabled;
}

// Namespace ftue_player_progression
// Params 1, eflags: 0x4
// Checksum 0xe65e620d, Offset: 0x1ee
// Size: 0x96, Type: bool
function private function_8f7ab9c09eb1de1c( match )
{
    if ( match < 3 )
    {
        return false;
    }
    
    if ( match == 4 || match == 6 )
    {
        return false;
    }
    
    if ( ftue_progress::function_53132d48c3fb23af( match ) )
    {
        return false;
    }
    
    setprogress = 1;
    
    if ( self getprivatepartysize() > 1 )
    {
        setprogress = getdvarint( @"hash_c8e3d38b6e1b91f8", 1 ) == 0;
        
        if ( setprogress )
        {
            setprogress = getdvarint( @"hash_d9d26a804ed1a1aa", 1 ) == 0 || !self isfireteamleader();
        }
    }
    
    if ( setprogress )
    {
        ftue_progress::function_5dcbb86a0b038621( match, 1 );
    }
    
    return true;
}

// Namespace ftue_player_progression
// Params 0
// Checksum 0x12359615, Offset: 0x28d
// Size: 0x25, Type: bool
function function_31a08036b49e8462()
{
    return isplayer( self ) && !isbot( self ) && gamelogic_mp::inprematch() && function_76ad20455a04c832();
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0xcb840f41, Offset: 0x2bb
// Size: 0x11
function private function_15c46d9fdd221f85()
{
    return getdvarint( @"hash_13a4ace57e9b30c9", 3 );
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0x37f3cd98, Offset: 0x2d5
// Size: 0x11
function private function_5e56bf669a727ec7()
{
    return getdvarint( @"hash_6bc7552224fa36e3", 1 );
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0x38cd3e88, Offset: 0x2ef
// Size: 0x14
function private function_1581f89d56338f4d()
{
    return getdvar( @"hash_9652fdeee6b218ab", "iw9_ar_mike4" );
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0xe772dc8f, Offset: 0x30c
// Size: 0x2f, Type: bool
function private function_d5dc07e302f9ea3a()
{
    player = self;
    return !isbot( player ) && player rank::getrankxp() < progression_utility::getrankinfomaxxp( function_15c46d9fdd221f85() );
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0x92fc62b5, Offset: 0x344
// Size: 0x4b, Type: bool
function private function_247451f884aa89ee()
{
    player = self;
    curweapon = player getcurrentweapon();
    weapname = weapon::getweaponrootname( curweapon );
    return !isbot( player ) && weaponrank::getplayerweaponrank( weapname ) < function_5e56bf669a727ec7();
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0xe14d599, Offset: 0x398
// Size: 0x135
function private function_97e20e39cb3db7a8()
{
    player = self;
    givexpreward = player function_d5dc07e302f9ea3a();
    giveweaponxpreward = player function_247451f884aa89ee();
    values = spawnstruct();
    xpneeded = 0;
    
    if ( givexpreward )
    {
        xpneeded = player function_8f587fa2fcf452ae();
    }
    
    values.finalxp = xpneeded;
    values.timexp = xpneeded;
    values.basexp = xpneeded;
    values.placementxp = 0;
    values.bonusxp = 0;
    var_d1f8c8f330c59537 = 0;
    weaponlootid = 0;
    
    if ( giveweaponxpreward )
    {
        var_531437668a011b28 = function_1581f89d56338f4d();
        
        if ( isdefined( level.weaponmapdata[ var_531437668a011b28 ] ) && isdefined( level.weaponmapdata[ var_531437668a011b28 ].weaponlootid ) )
        {
            weaponlootid = level.weaponmapdata[ var_531437668a011b28 ].weaponlootid;
        }
        
        var_d1f8c8f330c59537 = player function_4fbb666a3769f3ce( var_531437668a011b28 );
    }
    
    values.weaponlootid = weaponlootid;
    values.weaponxp = var_d1f8c8f330c59537;
    return values;
}

// Namespace ftue_player_progression
// Params 0, eflags: 0x4
// Checksum 0x54d97280, Offset: 0x4d6
// Size: 0x86
function private function_8f587fa2fcf452ae()
{
    player = self;
    desiredrank = getdvarint( @"hash_13a4ace57e9b30c9", 0 );
    rankxp = progression_utility::getrankinfomaxxp( desiredrank );
    currentplayerxp = player getplayerdata( "common", "mpProgression", "playerLevel", "xp" ) + player.pers[ "summary" ][ "xp" ];
    return int( max( rankxp - 1 - currentplayerxp, 0 ) );
}

// Namespace ftue_player_progression
// Params 1, eflags: 0x4
// Checksum 0x4d69c6b9, Offset: 0x565
// Size: 0x3f
function private function_4fbb666a3769f3ce( rootweapon )
{
    player = self;
    return int( max( weaponrank::getweaponrankinfominxp( rootweapon, function_5e56bf669a727ec7() ) - player weaponrank::getplayerweaponrankxp( rootweapon, "mp" ), 0 ) );
}

