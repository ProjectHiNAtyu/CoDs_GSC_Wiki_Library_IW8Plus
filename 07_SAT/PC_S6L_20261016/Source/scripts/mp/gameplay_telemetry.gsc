// scripts\mp\gameplay_telemetry.gsc  (hash_4f69ac46e7de953a.gscc) (size: 6210 Bytes / 0x1842 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe83b495c (3896199516)
// size ...... 6210 (0x1842)
// includes .. 2   (offset: 0x158e)
// strings ... 38  (offset: 0x159e)
// dev strs .. 0   (offset: 0x1842)
// exports ... 16  (offset: 0xfba)
// cseg ...... 0x30a + 0xcb0 (0xfba)
// imports ... 28  (offset: 0x123a)
// animtree1 . 0   (offset: 0x1842)
// animtree2 . 0   (offset: 0x1842)
#using scripts\common\weapon;
#using scripts\mp\common\utility\gameplay_telemetry_utils;

#namespace gameplay_telemetry;

// Namespace gameplay_telemetry
// Params 0
// Checksum 0x1f3074ef, Offset: 0x328
// Size: 0xb0
function function_a2ca0c0d5139a904()
{
    self endon( #"disconnect" );
    level.var_80179eab175b88f7 = [];
    
    if ( isplayer( self ) )
    {
        if ( isbrgamemode() )
        {
            function_d0e460a163b93ca9();
        }
        else if ( level.gamemodebundle.aegamemode == "ZM" )
        {
            function_bb92c5e0a133a684();
        }
        else if ( level.gamemodebundle.aegamemode == "OB" || level.gamemodebundle.aegamemode == "WC" )
        {
            function_f5d5c4fc49c12aa8();
        }
        else
        {
            function_de679de2e29c43e4();
        }
        
        function_b27eb5b31365c0c9();
        waitframe();
        function_3e91d2222fa2419f();
    }
}

// Namespace gameplay_telemetry
// Params 0, eflags: 0x4
// Checksum 0xf1524476, Offset: 0x3e0
// Size: 0x143
function private function_b27eb5b31365c0c9()
{
    gameplay_telemetry_utils::function_138547b76fca2153( "shotAccuracy" );
    self.damagedealt = isdefined( self.pers[ "damageDealt" ] ) ? self.pers[ "damageDealt" ] : 0;
    
    if ( !isdefined( self.pers[ "shotsBulletHit" ] ) )
    {
        self.pers[ "shotsBulletHit" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "shotsFired" ] ) )
    {
        self.pers[ "shotsFired" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "weap_kills" ] ) )
    {
        self.pers[ "weap_kills" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_shotFired" ] ) )
    {
        self.pers[ "weap_shotFired" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_shotHit" ] ) )
    {
        self.pers[ "weap_shotHit" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_accuracy" ] ) )
    {
        self.pers[ "weap_accuracy" ] = [];
    }
    
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_kills";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_accuracy";
}

// Namespace gameplay_telemetry
// Params 0, eflags: 0x4
// Checksum 0xa0e358b, Offset: 0x52b
// Size: 0x18c
function private function_de679de2e29c43e4()
{
    level.var_bd8514fd3f70e2f1 = 1;
    childthread function_254087da70362771();
    gameplay_telemetry_utils::function_138547b76fca2153( "operatorKills" );
    gameplay_telemetry_utils::function_138547b76fca2153( "operatorKD" );
    gameplay_telemetry_utils::function_138547b76fca2153( "operatorDeaths" );
    
    if ( !isdefined( self.pers[ "weap_deaths" ] ) )
    {
        self.pers[ "weap_deaths" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_kdratio" ] ) )
    {
        self.pers[ "weap_kdratio" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_headShot_count" ] ) )
    {
        self.pers[ "weap_headShot_count" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_headShot_accuracy" ] ) )
    {
        self.pers[ "weap_headShot_accuracy" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_damagedealt" ] ) )
    {
        self.pers[ "weap_damagedealt" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_destruction" ] ) )
    {
        self.pers[ "weap_destruction" ] = [];
    }
    
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_kdratio";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_headshot_count";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_headshot_accuracy";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_damagedealt";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_destruction";
}

// Namespace gameplay_telemetry
// Params 0, eflags: 0x4
// Checksum 0xf5d33a95, Offset: 0x6bf
// Size: 0x17a
function private function_d0e460a163b93ca9()
{
    level.var_bd8514fd3f70e2f1 = 2;
    gameplay_telemetry_utils::function_138547b76fca2153( "operatorKills" );
    gameplay_telemetry_utils::function_138547b76fca2153( "operatorKD" );
    gameplay_telemetry_utils::function_138547b76fca2153( "operatorDowns" );
    gameplay_telemetry_utils::function_138547b76fca2153( "teamRevive" );
    gameplay_telemetry_utils::function_138547b76fca2153( "teamWipe" );
    
    if ( !isdefined( self.pers[ "weap_downs" ] ) )
    {
        self.pers[ "weap_downs" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_dist" ] ) )
    {
        self.pers[ "weap_dist" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_longest_dist" ] ) )
    {
        self.pers[ "weap_longest_dist" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_damagedealt" ] ) )
    {
        self.pers[ "weap_damagedealt" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_destruction" ] ) )
    {
        self.pers[ "weap_destruction" ] = [];
    }
    
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_downs";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_dist";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_longest_dist";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_damagedealt";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_destruction";
}

// Namespace gameplay_telemetry
// Params 0, eflags: 0x4
// Checksum 0xa1276d31, Offset: 0x841
// Size: 0x101
function private function_bb92c5e0a133a684()
{
    level.var_bd8514fd3f70e2f1 = 4;
    
    if ( !isdefined( self.pers[ "weap_critical_kills" ] ) )
    {
        self.pers[ "weap_critical_kills" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_critical_accuracy" ] ) )
    {
        self.pers[ "weap_critical_accuracy" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_special_kills" ] ) )
    {
        self.pers[ "weap_special_kills" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_ammo_mod_triggered" ] ) )
    {
        self.pers[ "weap_ammo_mod_triggered" ] = [];
    }
    
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_critical_kills";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_critical_accuracy";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_special_kills";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_ammo_mod_triggered";
}

// Namespace gameplay_telemetry
// Params 0, eflags: 0x4
// Checksum 0xa6640317, Offset: 0x94a
// Size: 0x101
function private function_f5d5c4fc49c12aa8()
{
    level.var_bd8514fd3f70e2f1 = 8;
    
    if ( !isdefined( self.pers[ "weap_special_kills" ] ) )
    {
        self.pers[ "weap_special_kills" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_critical_kills" ] ) )
    {
        self.pers[ "weap_critical_kills" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_critical_accuracy" ] ) )
    {
        self.pers[ "weap_critical_accuracy" ] = [];
    }
    
    if ( !isdefined( self.pers[ "weap_damagedealt" ] ) )
    {
        self.pers[ "weap_damagedealt" ] = [];
    }
    
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_critical_kills";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_critical_accuracy";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_special_kills";
    level.var_80179eab175b88f7[ level.var_80179eab175b88f7.size ] = "weap_damagedealt";
}

// Namespace gameplay_telemetry
// Params 4
// Checksum 0xdc00afba, Offset: 0xa53
// Size: 0x64
function function_383cde919fd850c4( var_3291c43e227488dc, gamemodelist, value = 1, intoverride = 1 )
{
    self endon( #"disconnect" );
    
    if ( gameplay_telemetry_utils::function_ab5801f54c55eee8( gamemodelist ) )
    {
        gameplay_telemetry_utils::function_c7f73c82e4054e10( var_3291c43e227488dc, "ui_gameplay_telemetry_" + var_3291c43e227488dc, value, intoverride );
    }
}

// Namespace gameplay_telemetry
// Params 4
// Checksum 0xacfcd63e, Offset: 0xabf
// Size: 0x5b
function function_f98fbe3bbb2ed9f1( var_3291c43e227488dc, gamemodelist, value, intoverride = 1 )
{
    self endon( #"disconnect" );
    
    if ( gameplay_telemetry_utils::function_ab5801f54c55eee8( gamemodelist ) )
    {
        gameplay_telemetry_utils::function_46061476250367dd( var_3291c43e227488dc, "ui_gameplay_telemetry_" + var_3291c43e227488dc, value, intoverride );
    }
}

// Namespace gameplay_telemetry
// Params 5
// Checksum 0xe0d3e737, Offset: 0xb22
// Size: 0x77
function function_3b8d40426c725ea0( var_3291c43e227488dc, weaponname, gamemodelist, value = 1, intoverride = 1 )
{
    if ( gameplay_telemetry_utils::function_ab5801f54c55eee8( gamemodelist ) )
    {
        var_b976c5a3d69d66ee = gameplay_telemetry_utils::function_8437da42a22966b4( weaponname );
        
        if ( var_b976c5a3d69d66ee )
        {
            gameplay_telemetry_utils::function_272e03c2ab47fa34( var_3291c43e227488dc, weaponname, var_b976c5a3d69d66ee + var_3291c43e227488dc, value, intoverride );
        }
    }
}

// Namespace gameplay_telemetry
// Params 5
// Checksum 0x971f208, Offset: 0xba1
// Size: 0x6e
function function_83a6a8db9fcbb065( var_3291c43e227488dc, weaponname, gamemodelist, value, intoverride = 1 )
{
    if ( gameplay_telemetry_utils::function_ab5801f54c55eee8( gamemodelist ) )
    {
        var_b976c5a3d69d66ee = gameplay_telemetry_utils::function_8437da42a22966b4( weaponname );
        
        if ( var_b976c5a3d69d66ee )
        {
            gameplay_telemetry_utils::function_aa2d78134e623dd9( var_3291c43e227488dc, weaponname, var_b976c5a3d69d66ee + var_3291c43e227488dc, value, intoverride );
        }
    }
}

// Namespace gameplay_telemetry
// Params 2
// Checksum 0x1138381c, Offset: 0xc17
// Size: 0x6f, Type: bool
function function_42040e5fa41218b3( var_7e2e012bec81f493, weaponname = undefined )
{
    self endon( #"disconnect" );
    substrings = strtok( var_7e2e012bec81f493, "_" );
    
    if ( substrings[ 0 ] == "weap" )
    {
        return ( self.pers[ var_7e2e012bec81f493 ][ weaponname ] ?? 0 );
    }
    
    return self.pers[ var_7e2e012bec81f493 ] ?? 0;
}

// Namespace gameplay_telemetry
// Params 0, eflags: 0xc
// Checksum 0x1ea082b2, Offset: 0xc8f
// Size: 0x60
function private function_254087da70362771()
{
    self notify( #"hash_b56479236d7f8cd" );
    self endon( #"hash_b56479236d7f8cd" );
    level endon( #"game_ended" );
    
    if ( !gameplay_telemetry_utils::function_ab5801f54c55eee8( 1 ) )
    {
        return;
    }
    
    while ( true )
    {
        spm = gameplay_telemetry_utils::function_8f71c8ffb480ebc3();
        function_f98fbe3bbb2ed9f1( "inStatSPM", 1, spm );
        wait 1;
    }
}

// Namespace gameplay_telemetry
// Params 2
// Checksum 0xaa3e314d, Offset: 0xcf7
// Size: 0xf9
function function_10952c3c9a272c6d( current_weapon, gamemodes )
{
    if ( !gameplay_telemetry_utils::function_ab5801f54c55eee8( gamemodes ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_ee97b24db8ffccaa ) )
    {
        self.var_ee97b24db8ffccaa = 0;
    }
    
    var_dfcb452d77391058 = self.var_6383d93366491c31 ?? undefined;
    weapon_index = getweaponindex( current_weapon );
    weaponname = current_weapon.basename;
    currentkillcount = self.pers[ "weap_kills" ][ weaponname ] ?? 0;
    
    if ( var_dfcb452d77391058 == weapon_index )
    {
        self.var_ee97b24db8ffccaa = currentkillcount;
    }
    else if ( self.var_ee97b24db8ffccaa < currentkillcount )
    {
        self.var_ee97b24db8ffccaa = currentkillcount;
        self.weapon_most_kills = current_weapon;
        self.var_74281cfd6d423260 = weapon::getweaponlootid( current_weapon );
    }
    else
    {
        return;
    }
    
    self setclientomnvar( "ui_gameplay_telemetry_weap_most_kills", self.var_74281cfd6d423260 );
}

// Namespace gameplay_telemetry
// Params 2
// Checksum 0x846c6bf3, Offset: 0xdf8
// Size: 0xf9
function function_318b3726867c0e81( current_weapon, gamemodes )
{
    if ( !gameplay_telemetry_utils::function_ab5801f54c55eee8( gamemodes ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_152ae313ad2ff742 ) )
    {
        self.var_152ae313ad2ff742 = 0;
    }
    
    var_dfcb452d77391058 = self.var_fdcf6fb7ad71b079 ?? undefined;
    weapon_index = getweaponindex( current_weapon );
    weaponname = current_weapon.basename;
    var_8f5861ce07bed455 = self.pers[ "weap_damagedealt" ][ weaponname ] ?? 0;
    
    if ( var_dfcb452d77391058 == weapon_index )
    {
        self.var_152ae313ad2ff742 = var_8f5861ce07bed455;
    }
    else if ( var_8f5861ce07bed455 > self.var_152ae313ad2ff742 )
    {
        self.var_152ae313ad2ff742 = var_8f5861ce07bed455;
        self.var_cdc77dd39cc1462e = current_weapon;
        self.var_f140eb6184081808 = weapon::getweaponlootid( current_weapon );
    }
    else
    {
        return;
    }
    
    self setclientomnvar( "ui_gameplay_telemetry_weapon_most_damage", self.var_f140eb6184081808 );
}

// Namespace gameplay_telemetry
// Params 2
// Checksum 0x30f00a16, Offset: 0xef9
// Size: 0xc1
function function_3e91d2222fa2419f( isendgame = 0, var_ee77eec8c032a41f )
{
    if ( !gameplay_telemetry_utils::function_f78eef1203724422() )
    {
        return;
    }
    
    if ( !var_ee77eec8c032a41f )
    {
        gameplay_telemetry_utils::function_36707ddf39464a70();
    }
    
    statsweapons = gameplay_telemetry_utils::function_7e422cf7672bb058( isendgame );
    
    foreach ( statsname in level.var_80179eab175b88f7 )
    {
        gameplay_telemetry_utils::function_393d5636f0bd5c27( statsname, statsweapons );
    }
}

