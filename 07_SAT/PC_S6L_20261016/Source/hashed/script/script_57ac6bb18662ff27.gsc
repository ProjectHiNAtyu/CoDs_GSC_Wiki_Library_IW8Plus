// script_57ac6bb18662ff27  (hash_57ac6bb18662ff27.gscc) (size: 3152 Bytes / 0xc50 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x338eeaad (865004205)
// size ...... 3152 (0xc50)
// includes .. 5   (offset: 0xb90)
// strings ... 9   (offset: 0xbb8)
// dev strs .. 0   (offset: 0xc50)
// exports ... 9   (offset: 0x7f8)
// cseg ...... 0xd6 + 0x722 (0x7f8)
// imports ... 19  (offset: 0x960)
// animtree1 . 0   (offset: 0xc50)
// animtree2 . 0   (offset: 0xc50)
#using script_16ea1b94f0f381b3;
#using script_6802bb17a0c535f3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon_utility;

#namespace deadliest_weapon_ai;

// Namespace deadliest_weapon_ai
// Params 0, eflags: 0x1
// Checksum 0xb1fd91b1, Offset: 0xf4
// Size: 0x35
function autoexec register_init()
{
    aar_tracking::function_e32d863f90d794a1( #"deadliest_weapon_ai", &init_deadliest_tracking );
    utility::registersharedfunc( #"deadliest_weapon_ai", #"add_deadliest_weapon", &add_deadliest_weapon );
}

// Namespace deadliest_weapon_ai
// Params 1, eflags: 0x4
// Checksum 0x18a66e01, Offset: 0x131
// Size: 0x56
function private init_deadliest_tracking( aar_tracking_ref )
{
    if ( level.gametypebundle.var_b8748c0cba9a9623 == #"versus_ai" )
    {
        callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
        callback::add( #"game_ended", &on_game_ended );
    }
}

// Namespace deadliest_weapon_ai
// Params 2, eflags: 0x4
// Checksum 0x7b35731d, Offset: 0x18f
// Size: 0x42
function private add_deadliest_weapon( var_eadb663a1292c9e8, can_track = 1 )
{
    if ( !isdefined( level.var_a4dd5273b76df16d ) )
    {
        level.var_a4dd5273b76df16d = [];
    }
    
    level.var_a4dd5273b76df16d[ var_eadb663a1292c9e8 ] = can_track;
}

// Namespace deadliest_weapon_ai
// Params 1, eflags: 0x4
// Checksum 0xfa47f771, Offset: 0x1d9
// Size: 0x4f
function private function_8c5e06ee1e60aeb7( params )
{
    if ( isplayer( params.eattacker ) )
    {
        params.eattacker track_elimination( params.sweapon, istrue( self.last_dmg_struct.biscritical ) );
    }
}

// Namespace deadliest_weapon_ai
// Params 1, eflags: 0x4
// Checksum 0x4a07bec7, Offset: 0x230
// Size: 0xf3
function private function_43fef757978b336b( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return 0;
    }
    
    if ( weaponobj.basenamehash && isdefined( level.var_a4dd5273b76df16d[ weaponobj.basenamehash ] ) )
    {
        return level.var_a4dd5273b76df16d[ weaponobj.basenamehash ];
    }
    
    iskillstreakweaponfunc = level.sharedfuncs[ #"killstreak" ][ #"iskillstreakweapon" ];
    
    if ( isdefined( iskillstreakweaponfunc ) && self [[ iskillstreakweaponfunc ]]( weaponobj.basename ) )
    {
        return 0;
    }
    
    isbulletweaponfunc = level.sharedfuncs[ #"weapons" ][ #"isbulletweapon" ];
    
    if ( isdefined( isbulletweaponfunc ) && self [[ isbulletweaponfunc ]]( weaponobj ) )
    {
        return 1;
    }
    
    if ( weapon_utility::function_186e07887b6bbeb1( weaponobj ) )
    {
        return 1;
    }
    
    if ( weaponobj.ismelee )
    {
        return 1;
    }
    
    return 0;
}

// Namespace deadliest_weapon_ai
// Params 2, eflags: 0x4
// Checksum 0x9e730e1e, Offset: 0x32c
// Size: 0x1bd
function private track_elimination( weaponobj, iscritical )
{
    var_68c0794db78b3724 = self.pers[ #"deadliest_weapon_tracking" ];
    
    if ( !isdefined( var_68c0794db78b3724 ) )
    {
        self.pers[ #"deadliest_weapon_tracking" ] = spawnstruct();
        var_68c0794db78b3724 = self.pers[ #"deadliest_weapon_tracking" ];
    }
    
    if ( !isdefined( var_68c0794db78b3724.weaponstats ) )
    {
        var_68c0794db78b3724.weaponstats = [];
    }
    
    if ( function_43fef757978b336b( weaponobj ) )
    {
        attacker_weapon_stats = var_68c0794db78b3724.weaponstats[ weaponobj.basename ];
        
        if ( !isdefined( attacker_weapon_stats ) )
        {
            var_68c0794db78b3724.weaponstats[ weaponobj.basename ] = { #blueprintid:getweaponvariantindex( weaponobj ), #rarity:0, #PAPlvl:0, #elimspap:0, #var_ef4475d810a1ca18:0, #elims:1 };
            attacker_weapon_stats = var_68c0794db78b3724.weaponstats[ weaponobj.basename ];
        }
        else
        {
            attacker_weapon_stats.elims++;
        }
        
        var_951c89546ec50477 = namespace_9d8e359c3b1041e5::function_1d4087075103b248( weaponobj );
        
        if ( var_951c89546ec50477 )
        {
            attacker_weapon_stats.elimspap++;
            
            if ( var_951c89546ec50477 > attacker_weapon_stats.PAPlvl )
            {
                attacker_weapon_stats.PAPlvl = var_951c89546ec50477;
            }
        }
        
        if ( iscritical )
        {
            attacker_weapon_stats.var_ef4475d810a1ca18++;
        }
        
        rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( weaponobj );
        
        if ( rarity > attacker_weapon_stats.rarity )
        {
            attacker_weapon_stats.rarity = rarity;
        }
    }
}

// Namespace deadliest_weapon_ai
// Params 2
// Checksum 0x63b4e6e5, Offset: 0x4f1
// Size: 0x266
function function_c588b98a77b1e36a( player, var_6f9b00680ed002d8 )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    deadliest_weapon = "none";
    deadliest_weapon_paplvl = 0;
    deadliest_weapon_elims = 0;
    deadliest_weapon_elims_pap = 0;
    deadliest_weapon_critcal_kills = 0;
    var_992769da1fcb6f42 = player.pers[ #"deadliest_weapon_tracking" ].weaponstats;
    
    if ( isdefined( var_992769da1fcb6f42 ) )
    {
        foreach ( weaponname, weaponstats in var_992769da1fcb6f42 )
        {
            if ( !( isdefined( weaponstats.elims ) && isdefined( weaponstats.var_ef4475d810a1ca18 ) ) )
            {
                continue;
            }
            
            if ( !isdefined( deadliest_weapon ) || weaponstats.elims > deadliest_weapon_elims || weaponstats.elims == deadliest_weapon_elims && deadliest_weapon_critcal_kills < weaponstats.var_ef4475d810a1ca18 )
            {
                deadliest_weapon = weaponname;
                deadliest_weapon_paplvl = weaponstats.PAPlvl ?? 0;
                deadliest_weapon_elims = weaponstats.elims ?? 0;
                deadliest_weapon_elims_pap = weaponstats.elimspap ?? 0;
                deadliest_weapon_critcal_kills = weaponstats.var_ef4475d810a1ca18 ?? 0;
                deadliest_weapon_blueprint_id = weaponstats.blueprintid ?? 0;
            }
        }
    }
    
    player setplayerdata( var_6f9b00680ed002d8, "aarData", "deadliestWeaponData", "eliminations", deadliest_weapon_elims ?? 0 );
    player setplayerdata( var_6f9b00680ed002d8, "aarData", "deadliestWeaponData", "eliminationsPAP", deadliest_weapon_elims_pap ?? 0 );
    player setplayerdata( var_6f9b00680ed002d8, "aarData", "deadliestWeaponData", "criticalKills", deadliest_weapon_critcal_kills ?? 0 );
    player setplayerdata( var_6f9b00680ed002d8, "aarData", "deadliestWeaponData", "PAPlvl", deadliest_weapon_paplvl ?? 0 );
    player setplayerdata( var_6f9b00680ed002d8, "aarData", "deadliestWeaponData", "ref", getxhash( deadliest_weapon ?? "none" ) );
    player setplayerdata( var_6f9b00680ed002d8, "aarData", "deadliestWeaponData", "blueprintID", deadliest_weapon_blueprint_id ?? 0 );
}

// Namespace deadliest_weapon_ai
// Params 1, eflags: 0x4
// Checksum 0xf7404ab6, Offset: 0x75f
// Size: 0x99
function private on_game_ended( params )
{
    var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
    
    foreach ( player in level.players )
    {
        function_c588b98a77b1e36a( player, var_6f9b00680ed002d8 );
    }
}

