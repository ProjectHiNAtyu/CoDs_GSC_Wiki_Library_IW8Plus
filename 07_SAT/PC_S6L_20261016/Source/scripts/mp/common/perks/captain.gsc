// scripts\mp\common\perks\captain.gsc  (hash_41b63e0cbdea62ea.gscc) (size: 2230 Bytes / 0x8b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5db2f5a (3051040602)
// size ...... 2230 (0x8b6)
// includes .. 4   (offset: 0x842)
// strings ... 5   (offset: 0x862)
// dev strs .. 0   (offset: 0x8b6)
// exports ... 8   (offset: 0x556)
// cseg ...... 0xa5 + 0x4b1 (0x556)
// imports ... 15  (offset: 0x696)
// animtree1 . 0   (offset: 0x8b6)
// animtree2 . 0   (offset: 0x8b6)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\supers;

#namespace captain;

// Namespace captain
// Params 0, eflags: 0x1
// Checksum 0x2c43b14, Offset: 0xc3
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_936c1102f7fcfd5 );
}

// Namespace captain
// Params 1
// Checksum 0xaaa51089, Offset: 0xe3
// Size: 0x84
function function_936c1102f7fcfd5( params )
{
    bundle = level.perkbundles[ "specialty_captain" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_captain", &setcaptain, &unsetcaptain );
    }
    
    if ( isdefined( params.var_5109b530c69d18a1 ) )
    {
        level [[ params.var_5109b530c69d18a1 ]]( "specialty_captain", &function_9c9fcdbdd0d96cf );
    }
}

// Namespace captain
// Params 1
// Checksum 0xdea26d21, Offset: 0x16f
// Size: 0x13b
function function_9c9fcdbdd0d96cf( params )
{
    if ( !function_3a35a82e9be58d3d( params ) )
    {
        return;
    }
    
    self notify( #"captainonkillbuff" );
    self.var_b85b83ea0a347ac3 = gettime();
    bundle = level.perkbundles[ "specialty_captain" ];
    superpoints = bundle.var_9defa51b3300632 ?? 100;
    thread supers_mp::givesuperpoints( superpoints );
    thread points::doscoreevent( #"captain_stealth_kill" );
    self.var_de0e5e468776d901 = 1;
    var_2c124e2ccc1e8842 = level.sharedfuncs[ #"perk" ][ #"notifyperkbuffactive" ];
    
    if ( isdefined( var_2c124e2ccc1e8842 ) )
    {
        foreach ( perkbuff in bundle.var_ee1c92198ad66b2f )
        {
            self [[ var_2c124e2ccc1e8842 ]]( bundle, perkbuff.var_fbd59bd982c1fe7c );
        }
    }
}

// Namespace captain
// Params 0
// Checksum 0xc5b09370, Offset: 0x2b2
// Size: 0x32
function setcaptain()
{
    bundle = level.perkbundles[ "specialty_captain" ];
    
    if ( bundle.var_41187badcca3cdca )
    {
        thread captainwatchvisibility();
    }
}

// Namespace captain
// Params 0
// Checksum 0x7a5e8a3e, Offset: 0x2ec
// Size: 0xe
function unsetcaptain()
{
    self notify( #"captainwatchvisibility" );
}

// Namespace captain
// Params 0
// Checksum 0xde739caf, Offset: 0x302
// Size: 0xe2
function captainwatchvisibility()
{
    self notify( #"captainwatchvisibility" );
    self endon( #"captainwatchvisibility" );
    self endon( #"death_or_disconnect" );
    bundle = level.perkbundles[ "specialty_captain" ];
    var_8fab0534ce60df9a = int( ( bundle.var_ac0b9c697ca31976 ?? 3 ) * 1000 );
    self.var_deda91cf8fa2fb2a = 0;
    
    while ( true )
    {
        sightingplayers = self getplayerssightingme();
        currenttime = gettime();
        
        if ( sightingplayers.size > 0 )
        {
            self.var_60d39f40a7383b40 = 1;
            self.var_deda91cf8fa2fb2a = currenttime;
        }
        else if ( self.var_60d39f40a7383b40 && currenttime - self.var_deda91cf8fa2fb2a >= var_8fab0534ce60df9a )
        {
            self.var_60d39f40a7383b40 = 0;
        }
        
        wait 0.25;
    }
}

// Namespace captain
// Params 1
// Checksum 0x1155ff41, Offset: 0x3ec
// Size: 0x169, Type: bool
function function_3a35a82e9be58d3d( deathdata )
{
    smeansofdeath = deathdata.smeansofdeath ?? "";
    currenttime = gettime();
    bundle = level.perkbundles[ "specialty_captain" ];
    cooldownms = ( bundle.var_a6f76cfe906dbe9b ?? 10 ) * 1000;
    
    if ( self.var_b85b83ea0a347ac3 > currenttime - cooldownms )
    {
        return false;
    }
    
    if ( bundle.var_6690867bb6204e91 && deathdata.objweapon issilenced() )
    {
        return true;
    }
    
    if ( bundle.var_41187badcca3cdca && !self.var_60d39f40a7383b40 )
    {
        return true;
    }
    
    if ( bundle.var_bcea45c9701b0ec )
    {
        if ( smeansofdeath == "MOD_MELEE" )
        {
            return true;
        }
        
        if ( smeansofdeath == "MOD_MELEE_TAKEDOWN" )
        {
            return true;
        }
        
        if ( smeansofdeath == "MOD_EXECUTION" )
        {
            return true;
        }
    }
    
    if ( bundle.var_5331692498cabc0 && weapon::function_e1a6c47f66c6de20( deathdata.objweapon ) )
    {
        return true;
    }
    
    var_835c51befc9941d1 = ( bundle.var_8abb2882ed9990d1 ?? 0.75 ) * 1000;
    
    if ( bundle.var_5064b8ba56c4edaa && self.activecamoendtime >= currenttime - var_835c51befc9941d1 )
    {
        return true;
    }
    
    return false;
}

