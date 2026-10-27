// script_290fd9e732c8d0fe  (hash_290fd9e732c8d0fe.gscc) (size: 4606 Bytes / 0x11fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde81e881 (3733055617)
// size ...... 4606 (0x11fe)
// includes .. 5   (offset: 0x1176)
// strings ... 7   (offset: 0x119e)
// dev strs .. 0   (offset: 0x11fe)
// exports ... 14  (offset: 0xc0e)
// cseg ...... 0x114 + 0xafa (0xc0e)
// imports ... 27  (offset: 0xe3e)
// animtree1 . 0   (offset: 0x11fe)
// animtree2 . 0   (offset: 0x11fe)
#using script_6802bb17a0c535f3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;

#namespace deadliest_weapon;

// Namespace deadliest_weapon
// Params 0, eflags: 0x1
// Checksum 0x3322de35, Offset: 0x132
// Size: 0x35
function autoexec register_init()
{
    aar_tracking::function_e32d863f90d794a1( #"deadliest_weapon", &init_deadliest_tracking );
    utility::registersharedfunc( #"deadliestweapon", #"hash_a4f0254e8a3abe2a", &get_deadliest_weapon );
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0xc4ba569f, Offset: 0x16f
// Size: 0xdc
function private init_deadliest_tracking( aar_tracking_ref )
{
    if ( level.gametypebundle.var_b8748c0cba9a9623 == #"versus_player" )
    {
        if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
        {
            callback::add( #"hash_eb54ccc016130a88", &track_elimination );
        }
        else
        {
            callback::add( #"player_death", &track_kill );
        }
        
        callback::add( #"player_death", &player_killed );
        callback::add( #"game_ended", &on_game_ended );
        callback::add( #"player_disconnect", &on_player_disconnected );
        
        if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
        {
            callback::add( #"elimination_assist", &track_elimination );
        }
    }
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0xf807224c, Offset: 0x253
// Size: 0x19a
function private player_killed( params )
{
    if ( flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    victim = self;
    var_73275236360bd4d1 = victim.pers[ #"deadliest_weapon_tracking" ];
    
    if ( !isdefined( var_73275236360bd4d1 ) )
    {
        victim.pers[ #"deadliest_weapon_tracking" ] = {};
        var_73275236360bd4d1 = victim.pers[ #"deadliest_weapon_tracking" ];
    }
    
    if ( !isdefined( var_73275236360bd4d1.weaponstats ) )
    {
        var_73275236360bd4d1.weaponstats = [];
    }
    
    victim_held_weapon = victim.lastweaponobj;
    
    if ( level.var_816b62bfa4ae6207[ victim_held_weapon.basenamehash ?? #"hash_2db1ec1962f1dc38" ] ?? function_43fef757978b336b( victim_held_weapon ) )
    {
        var_23420ae7f1087fd9 = var_73275236360bd4d1.weaponstats[ victim_held_weapon.basename ];
        
        if ( !isdefined( var_23420ae7f1087fd9 ) )
        {
            var_73275236360bd4d1.weaponstats[ victim_held_weapon.basename ] = { #deaths:1 };
        }
        else
        {
            if ( !isdefined( var_23420ae7f1087fd9.deaths ) )
            {
                var_23420ae7f1087fd9.deaths = 0;
            }
            
            var_23420ae7f1087fd9.deaths++;
        }
        
        if ( getdvarint( @"hash_b9556075191d1405", 0 ) )
        {
            logstring( "deadliest_weapon::player_killed - victim (" + victim.name + ") killed while holding " + victim_held_weapon.basename );
        }
    }
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0xbf4421dc, Offset: 0x3f5
// Size: 0x61
function private function_43fef757978b336b( weaponobj )
{
    if ( level.var_816b62bfa4ae6207.size > 300 )
    {
        level.var_816b62bfa4ae6207 = [];
    }
    
    var_76d695161fa6efcd = function_92f2408881e05645( weaponobj );
    level.var_816b62bfa4ae6207[ weaponobj.basenamehash ?? #"hash_2db1ec1962f1dc38" ] = var_76d695161fa6efcd;
    return var_76d695161fa6efcd;
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0x204bc9f, Offset: 0x45f
// Size: 0xac, Type: bool
function private function_92f2408881e05645( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    iskillstreakweaponfunc = level.sharedfuncs[ #"killstreak" ][ #"iskillstreakweapon" ];
    
    if ( isdefined( iskillstreakweaponfunc ) && self [[ iskillstreakweaponfunc ]]( weaponobj ) )
    {
        return false;
    }
    
    isbulletweaponfunc = level.sharedfuncs[ #"weapons" ][ #"isbulletweapon" ];
    
    if ( isdefined( isbulletweaponfunc ) && self [[ isbulletweaponfunc ]]( weaponobj ) )
    {
        return true;
    }
    
    if ( weapon_utility::function_186e07887b6bbeb1( weaponobj ) )
    {
        return true;
    }
    
    if ( weaponobj.ismelee )
    {
        return true;
    }
    
    return false;
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0x6f7c80a, Offset: 0x514
// Size: 0x5d
function private track_kill( params )
{
    victim = self;
    
    if ( isplayer( params.attacker ) )
    {
        params.attacker track_elimination( { #victim:victim, #attackerweaponobj:params.objweapon } );
    }
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0x29047b15, Offset: 0x579
// Size: 0x1c0
function private track_elimination( params )
{
    if ( flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    var_68c0794db78b3724 = self.pers[ #"deadliest_weapon_tracking" ];
    
    if ( !isdefined( var_68c0794db78b3724 ) )
    {
        self.pers[ #"deadliest_weapon_tracking" ] = {};
        var_68c0794db78b3724 = self.pers[ #"deadliest_weapon_tracking" ];
    }
    
    if ( !isdefined( var_68c0794db78b3724.weaponstats ) )
    {
        var_68c0794db78b3724.weaponstats = [];
    }
    
    attacker_weapon = params.attackerweaponobj ?? params.objweapon;
    
    if ( level.var_816b62bfa4ae6207[ attacker_weapon.basenamehash ?? #"hash_2db1ec1962f1dc38" ] ?? function_43fef757978b336b( attacker_weapon ) )
    {
        attacker_weapon_stats = var_68c0794db78b3724.weaponstats[ attacker_weapon.basename ];
        
        if ( !isdefined( attacker_weapon_stats ) )
        {
            var_68c0794db78b3724.weaponstats[ attacker_weapon.basename ] = { #blueprintid:getweaponvariantindex( attacker_weapon ), #elims:1 };
        }
        else
        {
            if ( !isdefined( attacker_weapon_stats.elims ) )
            {
                attacker_weapon_stats.elims = 0;
            }
            
            attacker_weapon_stats.elims++;
        }
        
        if ( getdvarint( @"hash_b9556075191d1405", 0 ) )
        {
            logstring( "deadliest_weapon::track_elimination - eliminator (" + self.name + ") eliminated " + params.victim.name + " with " + attacker_weapon.basename );
        }
    }
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0xaf1342a2, Offset: 0x741
// Size: 0x13
function private on_game_ended( params )
{
    function_1767f163598647b9();
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0xb3839754, Offset: 0x75c
// Size: 0x14
function private on_player_disconnected( params )
{
    function_618538ddebb077fc( self );
}

// Namespace deadliest_weapon
// Params 1
// Checksum 0xd9d7b39d, Offset: 0x778
// Size: 0xd9
function get_deadliest_weapon( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    function_618538ddebb077fc( player );
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        var_7d284148c7e252c1 = { #accuracy:player.var_79fdd123b2914535.deadliest_weapon_accuracy ?? 0, #deaths:player.var_79fdd123b2914535.deadliest_weapon_deaths ?? 0, #eliminations:player.var_79fdd123b2914535.deadliest_weapon_elims ?? 0, #name:player.var_79fdd123b2914535.deadliest_weapon ?? #"none" };
    }
    
    return var_7d284148c7e252c1;
}

// Namespace deadliest_weapon
// Params 0, eflags: 0x4
// Checksum 0xb10b4d01, Offset: 0x85a
// Size: 0xbe
function private function_1767f163598647b9()
{
    var_166078d287b7fbea = level.sharedfuncs[ #"script" ][ #"hash_ef833ca514caad4b" ];
    
    if ( isdefined( var_166078d287b7fbea ) )
    {
        while ( [[ var_166078d287b7fbea ]]() < 0.1 )
        {
            wait 0.1;
        }
    }
    
    foreach ( player in level.players )
    {
        function_618538ddebb077fc( player );
    }
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0x84a1b50c, Offset: 0x920
// Size: 0x2e
function private function_618538ddebb077fc( player )
{
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        function_31421a9cf460d8( player );
    }
}

// Namespace deadliest_weapon
// Params 1, eflags: 0x4
// Checksum 0xda9e8118, Offset: 0x956
// Size: 0x2b8
function private function_31421a9cf460d8( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( player.var_a69253abe3176935 )
    {
        return;
    }
    
    player.var_a69253abe3176935 = 1;
    var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
    deadliest_weapon = #"none";
    deadliest_weapon_elims = 0;
    deadliest_weapon_deaths = 0;
    deadliest_weapon_accuracy = 0;
    var_992769da1fcb6f42 = player.pers[ #"deadliest_weapon_tracking" ].weaponstats;
    
    if ( isdefined( var_992769da1fcb6f42 ) )
    {
        foreach ( weaponname, weaponstats in var_992769da1fcb6f42 )
        {
            if ( !isdefined( weaponstats.elims ) )
            {
                continue;
            }
            
            if ( !isdefined( weaponstats.deaths ) )
            {
                weaponstats.deaths = 0;
            }
            
            if ( !isdefined( deadliest_weapon ) || weaponstats.elims > deadliest_weapon_elims || weaponstats.elims == deadliest_weapon_elims && deadliest_weapon_deaths < weaponstats.deaths )
            {
                deadliest_weapon = weaponname;
                deadliest_weapon_elims = weaponstats.elims;
                deadliest_weapon_deaths = weaponstats.deaths;
                deadliest_weapon_accuracy = player.pers[ "weap_accuracy" ][ weaponname ] ?? 0;
                deadliest_weapon_blueprint_id = weaponstats.blueprintid ?? 0;
            }
        }
    }
    
    deadliest_weapon = getxhash( deadliest_weapon );
    player.var_79fdd123b2914535 = { #deadliest_weapon_accuracy:deadliest_weapon_accuracy, #deadliest_weapon_deaths:deadliest_weapon_deaths, #deadliest_weapon_elims:deadliest_weapon_elims, #deadliest_weapon:deadliest_weapon };
    
    if ( !player hasplayerdata() )
    {
        return;
    }
    
    player setplayerdata( var_6f9b00680ed002d8, #"aardata", #"deadliestweapondata", #"eliminations", deadliest_weapon_elims );
    player setplayerdata( var_6f9b00680ed002d8, #"aardata", #"deadliestweapondata", #"deaths", deadliest_weapon_deaths );
    player setplayerdata( var_6f9b00680ed002d8, #"aardata", #"deadliestweapondata", #"ref", deadliest_weapon );
    player setplayerdata( var_6f9b00680ed002d8, #"aardata", #"deadliestweapondata", #"blueprintid", deadliest_weapon_blueprint_id ?? 0 );
}

