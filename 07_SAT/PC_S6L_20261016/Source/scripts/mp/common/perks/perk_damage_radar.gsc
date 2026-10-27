// scripts\mp\common\perks\perk_damage_radar.gsc  (hash_76a610ddd325d831.gscc) (size: 3253 Bytes / 0xcb5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeb5086ea (3947923178)
// size ...... 3253 (0xcb5)
// includes .. 7   (offset: 0xc65)
// strings ... 1   (offset: 0xc9d)
// dev strs .. 0   (offset: 0xcb5)
// exports ... 9   (offset: 0x7e9)
// cseg ...... 0x72 + 0x777 (0x7e9)
// imports ... 27  (offset: 0x951)
// animtree1 . 0   (offset: 0xcb5)
// animtree2 . 0   (offset: 0xcb5)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\equipment;

#namespace perk_damage_radar;

// Namespace perk_damage_radar
// Params 0, eflags: 0x1
// Checksum 0x8451d975, Offset: 0x90
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace perk_damage_radar
// Params 1
// Checksum 0x11d522c5, Offset: 0xb0
// Size: 0xfe
function registerperk( params )
{
    bundle = level.perkbundles[ "specialty_damage_radar" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    specialties = [];
    
    if ( isdefined( bundle.specialties ) )
    {
        foreach ( specialty in bundle.specialties )
        {
            specialties[ specialties.size ] = specialty.bundle;
        }
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_damage_radar", &function_1fcd4e4255326665, &function_8e3be796ca0219de, specialties, &initdamageradar );
    }
}

// Namespace perk_damage_radar
// Params 0
// Checksum 0x34304e82, Offset: 0x1b6
// Size: 0x2
function initdamageradar()
{
    
}

// Namespace perk_damage_radar
// Params 0, eflags: 0x4
// Checksum 0x1465c02d, Offset: 0x1c0
// Size: 0x172
function private function_1fcd4e4255326665()
{
    bundle = level.perkbundles[ "specialty_damage_radar" ];
    
    if ( !bundle )
    {
        return;
    }
    
    self.var_c36269996253c559 = { #var_84f1289ab8e8b033:bundle.var_d283a32fb018ed4c ?? #"self", #var_1e2805287bfef690:bundle.var_1e2805287bfef690 ?? 0, #var_4e19a63d008c835b:bundle.var_4e19a63d008c835b ?? 0, #var_c4edaf982d93da33:bundle.var_c4edaf982d93da33 ?? 0, #var_89b066062ed2af10:bundle.var_d5bad0c2aa357009 ?? 1, #var_e8586dda0c8912a1:bundle.var_6095c743f5a1703e ?? 5, #var_11a45d4b82e41038:&pingvictim, #var_4e0caacb60f9e217:&function_a310a421089135 };
    
    if ( isdefined( bundle.specialties ) )
    {
        foreach ( specialty in bundle.specialties )
        {
            perk::giveperk( specialty );
        }
    }
}

// Namespace perk_damage_radar
// Params 0, eflags: 0x4
// Checksum 0x1fcdedea, Offset: 0x33a
// Size: 0xb6
function private function_8e3be796ca0219de()
{
    bundle = level.perkbundles[ "specialty_damage_radar" ];
    
    if ( !bundle )
    {
        return;
    }
    
    self.var_c36269996253c559 = undefined;
    
    if ( isdefined( bundle.specialties ) )
    {
        foreach ( specialty in bundle.specialties )
        {
            perk::removeperk( specialty );
        }
    }
}

// Namespace perk_damage_radar
// Params 4
// Checksum 0xb553bd1a, Offset: 0x3f8
// Size: 0x193, Type: bool
function function_a310a421089135( weaponobj, attacker, meansofdeath, damage )
{
    victim = self;
    
    if ( !player_utility::playersareenemies( victim, attacker ) )
    {
        return false;
    }
    
    if ( attacker.var_c36269996253c559.var_1e2805287bfef690 && ( !player::isreallyalive( self ) || damage >= self.health ) )
    {
        return false;
    }
    
    var_42d28022726a799f = attacker.var_c36269996253c559.var_c4edaf982d93da33 && isexplosivedamagemod( meansofdeath );
    
    if ( !var_42d28022726a799f )
    {
        return false;
    }
    
    lastpingtimeseconds = victim.var_b96a2725710c9481.lastpingtimeseconds ?? -1;
    
    if ( lastpingtimeseconds > 0 )
    {
        var_80af201340498a0f = gettime() / 1000 - lastpingtimeseconds;
        
        if ( var_80af201340498a0f < attacker.var_c36269996253c559.var_89b066062ed2af10 )
        {
            return false;
        }
    }
    
    var_ef52274dc1fa3e5 = utility::getsharedfunc( #"jamming_system", #"hash_f3a152be2dbc14b9" );
    
    if ( isdefined( var_ef52274dc1fa3e5 ) && victim [[ var_ef52274dc1fa3e5 ]]() )
    {
        return false;
    }
    
    if ( victim isplayerghost() )
    {
        return false;
    }
    
    if ( attacker.var_c36269996253c559.var_4e19a63d008c835b && equipment_mp::function_65ff545a795c7f55( weaponobj ) )
    {
        equipmentname = equipment_mp::getequipmentreffromweapon( weaponobj );
        
        if ( equipment_mp::isequipmenttactical( equipmentname ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace perk_damage_radar
// Params 2
// Checksum 0x209af1fd, Offset: 0x594
// Size: 0x1a8
function pingvictim( attacker, inflictor )
{
    if ( !isdefined( attacker.var_c36269996253c559 ) )
    {
        return;
    }
    
    victim = self;
    victim endon( #"disconnect" );
    
    if ( !isdefined( victim.var_b96a2725710c9481 ) )
    {
        victim.var_b96a2725710c9481 = {};
    }
    
    victim.var_b96a2725710c9481.lastpingtimeseconds = gettime() / 1000;
    attacker callback::callback( #"hash_bdda5c524eb0eb00" );
    
    if ( isdefined( inflictor ) )
    {
        if ( !isdefined( inflictor.var_3642ac04db718b4d ) )
        {
            inflictor.var_3642ac04db718b4d = {};
        }
        
        if ( !inflictor.var_3642ac04db718b4d.var_ea0abd26665f4c64 )
        {
            inflictor.var_3642ac04db718b4d.var_ea0abd26665f4c64 = 1;
            attacker thread points::doscoreevent( #"hash_1a3f021e21caf186" );
        }
    }
    
    millisecondsrevealed = int( attacker.var_c36269996253c559.var_e8586dda0c8912a1 * 1000 );
    
    switch ( attacker.var_c36269996253c559.var_84f1289ab8e8b033 )
    {
        case #"self":
            function_367ca543df797e71( victim, attacker, 0, millisecondsrevealed );
            break;
        case #"hash_4e8e1551cf0ffa0b":
            if ( level.teambased )
            {
                function_367ca543df797e71( victim, attacker, 1, millisecondsrevealed );
            }
            else
            {
                function_367ca543df797e71( victim, attacker, 0, millisecondsrevealed );
            }
            
            break;
    }
    
    victim.var_4395a821533743e7[ attacker.team ] = gettime();
}

// Namespace perk_damage_radar
// Params 4
// Checksum 0x533d614a, Offset: 0x744
// Size: 0xa5
function function_367ca543df797e71( victim, attacker, var_709ac30a7320fb20, millisecondsrevealed )
{
    if ( var_709ac30a7320fb20 )
    {
        attacker function_7b4f73a93178f87d( 5, [ attacker.team ], victim, 1 );
        waitframe();
        victim function_71c7c5be98d11198( [ attacker.team ], millisecondsrevealed );
        attacker function_7b4f73a93178f87d( 5, [ attacker.team ], victim, 0 );
        return;
    }
    
    attacker setplayercompassoriginstoclient( 5, victim, 1 );
    waitframe();
    victim pingplayerforplayer( attacker, millisecondsrevealed );
    attacker setplayercompassoriginstoclient( 5, victim, 0 );
}

