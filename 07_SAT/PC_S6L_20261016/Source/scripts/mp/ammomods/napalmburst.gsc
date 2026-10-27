// scripts\mp\ammomods\napalmburst.gsc  (hash_62f0521afcf9e13f.gscc) (size: 7076 Bytes / 0x1ba4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bc4c0d8 (2613362904)
// size ...... 7076 (0x1ba4)
// includes .. 9   (offset: 0x1a08)
// strings ... 11  (offset: 0x1a50)
// dev strs .. 5   (offset: 0x1b68)
// exports ... 14  (offset: 0x12f4)
// cseg ...... 0xed + 0x1207 (0x12f4)
// imports ... 41  (offset: 0x1524)
// animtree1 . 0   (offset: 0x1ba4)
// animtree2 . 0   (offset: 0x1ba4)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;

#namespace napalmburst;

// Namespace napalmburst
// Params 0, eflags: 0x5
// Checksum 0xcb712ee7, Offset: 0x10b
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "napalmburst", undefined, &__init__, undefined );
}

// Namespace napalmburst
// Params 0
// Checksum 0x6f1fd1b7, Offset: 0x128
// Size: 0xa
function __init__()
{
    level thread function_dd0377cbd2d3eeae();
}

// Namespace napalmburst
// Params 0
// Checksum 0xdbe6dcbd, Offset: 0x13a
// Size: 0x1e4
function function_dd0377cbd2d3eeae()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    napalmburstbundle = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ];
    
    if ( !isdefined( napalmburstbundle ) )
    {
        return;
    }
    
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "napalmburst_ready" );
    procpercent = napalmburstbundle.procpercent ?? 0.2;
    var_a3e31d9c9d0c8ca6 = napalmburstbundle.var_9225566c1a61c6ca ?? 0.05;
    cooldownentity = napalmburstbundle.cooldownentity ?? 0;
    cooldownattacker = napalmburstbundle.cooldownattacker ?? 3;
    cooldownglobal = napalmburstbundle.cooldownglobal ?? 3;
    var_92c00cb857963986 = napalmburstbundle.occursondeath ?? 1;
    var_2d38a15555828531 = napalmburstbundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = napalmburstbundle.var_1c73b60ea00808df ?? "";
    element = napalmburstbundle.element ?? "fire";
    
    if ( !isdefined( level.var_7665c08aecfeab11 ) )
    {
        level.var_7665c08aecfeab11 = [];
    }
    
    if ( !isdefined( level.var_7a528f29b93aec7f ) )
    {
        level.var_7a528f29b93aec7f = [];
    }
    
    ammo_mod::register_ammo_mod( "napalmburst", napalmburstbundle.id ?? 4, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_8fdbbbe47da44e6b, var_2d38a15555828531, var_1c73b60ea00808df, &function_6f8d6d1219f03221, element );
    utility::flag_set( "napalmburst_ready" );
    callback::add( #"on_ai_killed", &on_napalmburst_kill );
    
    /#
        level thread setup_napalmburst_devgui();
    #/
}

// Namespace napalmburst
// Params 1
// Checksum 0x24a57726, Offset: 0x326
// Size: 0x39
function register_napalmburst_result_func( func )
{
    if ( !isdefined( level.var_7665c08aecfeab11 ) )
    {
        level.var_7665c08aecfeab11 = [];
    }
    
    level.var_7665c08aecfeab11[ level.var_7665c08aecfeab11.size ] = func;
}

// Namespace napalmburst
// Params 1
// Checksum 0x4685cd8a, Offset: 0x367
// Size: 0x39
function register_napalmburst_validation_func( func )
{
    if ( !isdefined( level.var_7a528f29b93aec7f ) )
    {
        level.var_7a528f29b93aec7f = [];
    }
    
    level.var_7a528f29b93aec7f[ level.var_7a528f29b93aec7f.size ] = func;
}

// Namespace napalmburst
// Params 1, eflags: 0x4
// Checksum 0xd7e05cd6, Offset: 0x3a8
// Size: 0xb2
function private function_8fdbbbe47da44e6b( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    function_c4bcd20083d8d745( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
}

// Namespace napalmburst
// Params 8
// Checksum 0xc29fea05, Offset: 0x462
// Size: 0xf6
function function_c4bcd20083d8d745( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread = 0 )
{
    if ( level.var_7665c08aecfeab11.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_7665c08aecfeab11 )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread );
        }
        
        return;
    }
    
    thread function_bda956d76cf76213( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread );
}

// Namespace napalmburst
// Params 8
// Checksum 0x62c90906, Offset: 0x560
// Size: 0x691
function function_bda956d76cf76213( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread = 0 )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    var_c48d782ca0a28b21 = 0;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier )
    {
        switch ( ai_tier )
        {
            case 1:
            case 2:
                var_c48d782ca0a28b21 = 1;
                break;
            case 3:
                var_c48d782ca0a28b21 = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_big_game" );
            default:
                break;
        }
    }
    else if ( self.aisettings.var_652102b804cce911 )
    {
        var_c48d782ca0a28b21 = 1;
    }
    
    if ( var_c48d782ca0a28b21 )
    {
        napalmbursttime = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].ammomodduration ?? 10;
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        
        if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_extension" ) )
        {
            napalmbursttime += napalmbursttime * ( level.zombie_augments[ #"napalmburst_extension" ].var_23cfcce98f8bf0c5 ?? 1 );
        }
        
        if ( self.type == "zombie" )
        {
            if ( self.aicategory == "elite" )
            {
                var_364fdf2f495fe02b = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_1f56a5bf31d3ae89 ?? 0.025;
            }
            else
            {
                var_364fdf2f495fe02b = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_a9ad3c62dfcc8a47 ?? 0.1;
            }
        }
        else
        {
            var_436eff40bc7dec36 = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_e1252cdb4cdd7d34 ?? 0;
            var_364fdf2f495fe02b = var_436eff40bc7dec36 / zombie_base_health;
        }
        
        if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_damage_boost" ) )
        {
            var_364fdf2f495fe02b += var_364fdf2f495fe02b * ( level.zombie_augments[ #"napalmburst_damage_boost" ].var_e3d0eb79fd6fe167 ?? 0.5 );
        }
        
        var_39b5b4282d55b138 = isdefined( zombie_base_health );
        napalmburstdamage = isdefined( zombie_base_health ) ? zombie_base_health * var_364fdf2f495fe02b : 20;
        params = spawnstruct();
        params.death = death;
        params.attacker = attacker;
        params.mod = mod;
        params.sweapon = sweapon;
        params.vpoint = vpoint;
        params.shitloc = shitloc;
        params.modelindex = modelindex;
        params.napalmbursttime = napalmbursttime;
        params.napalmburstdamage = napalmburstdamage;
        params.var_39b5b4282d55b138 = var_39b5b4282d55b138;
        
        if ( nospread )
        {
            if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_contact_burn" ) )
            {
                return;
            }
            
            if ( isalive( self ) )
            {
                self.napalmburst_proc_weapon = sweapon;
                success = effect_burn::burn( napalmbursttime, napalmburstdamage, 1, attacker, "napalmburst", "_nburst", undefined, "fire", undefined, undefined, var_39b5b4282d55b138 );
            }
        }
        else
        {
            maxspread = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_c17b4c0bceb0f584 ?? 2;
            spreadrange = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_e82466cb096d7d91 ?? 50;
            
            if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_backdraft" ) )
            {
                var_985237f073ec85a3 = level.zombie_augments[ #"napalmburst_backdraft" ].var_1daeb0ae26475aa2 ?? 1;
                spreadrange += spreadrange * var_985237f073ec85a3;
            }
            
            zombies = getaiarrayinradius( self.origin, spreadrange );
            numspread = 0;
            
            foreach ( zombie in zombies )
            {
                if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                {
                    if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, zombie ) )
                    {
                        continue;
                    }
                }
                
                if ( zombie != self && numspread < maxspread && !zombie zombie_utils::function_bf1464d09f4e4b40() )
                {
                    zombie callback::callback( "napalmburst_proc", params );
                    numspread++;
                    
                    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_contact_burn" ) )
                    {
                        continue;
                    }
                    
                    zombie.napalmburst_proc_weapon = sweapon;
                    success = zombie effect_burn::burn( napalmbursttime, napalmburstdamage, 1, attacker, "napalmburst", "_nburst", undefined, "fire", undefined, undefined, var_39b5b4282d55b138 );
                }
            }
            
            if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_contact_burn" ) )
            {
                return;
            }
            
            if ( isalive( self ) )
            {
                self.napalmburst_proc_weapon = sweapon;
                success = effect_burn::burn( napalmbursttime, napalmburstdamage, 1, attacker, "napalmburst", "_nburst", undefined, "fire", undefined, undefined, var_39b5b4282d55b138 );
            }
        }
        
        callback::callback( "napalmburst_proc", params );
    }
}

// Namespace napalmburst
// Params 10
// Checksum 0xe955f67a, Offset: 0xbf9
// Size: 0x4c0
function function_2d2890b8aaa96ed4( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, nospread = 0, var_56bb046d7e4c8043 = 0, postfix = "_nburst" )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    var_c48d782ca0a28b21 = 0;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier )
    {
        switch ( ai_tier )
        {
            case 1:
            case 2:
                var_c48d782ca0a28b21 = 1;
                break;
            default:
                break;
        }
    }
    else if ( self.aisettings.var_652102b804cce911 )
    {
        var_c48d782ca0a28b21 = 1;
        self.var_30465dead0b9fadb = 1;
    }
    
    if ( var_c48d782ca0a28b21 )
    {
        napalmbursttime = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].ammomodduration ?? 10;
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        
        if ( self.type == "zombie" )
        {
            var_364fdf2f495fe02b = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_a9ad3c62dfcc8a47 ?? 0.1;
        }
        else
        {
            var_436eff40bc7dec36 = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_e1252cdb4cdd7d34 ?? 0;
            var_364fdf2f495fe02b = var_436eff40bc7dec36 / zombie_base_health;
        }
        
        var_39b5b4282d55b138 = isdefined( zombie_base_health );
        napalmburstdamage = isdefined( zombie_base_health ) ? zombie_base_health * var_364fdf2f495fe02b : 20;
        params = spawnstruct();
        params.death = death;
        params.attacker = attacker;
        params.mod = mod;
        params.sweapon = sweapon;
        params.vpoint = vpoint;
        params.shitloc = shitloc;
        params.modelindex = modelindex;
        params.napalmbursttime = napalmbursttime;
        params.napalmburstdamage = napalmburstdamage;
        params.var_39b5b4282d55b138 = var_39b5b4282d55b138;
        params.var_9f3ca9dcada2e0ef = 1;
        callback::callback( "napalmburst_proc", params );
        self.var_56bb046d7e4c8043 = var_56bb046d7e4c8043;
        
        if ( nospread )
        {
            self.napalmburst_proc_weapon = sweapon;
            success = effect_burn::burn( napalmbursttime, napalmburstdamage, 1, attacker, "napalmburst", postfix, undefined, "fire", undefined, undefined, var_39b5b4282d55b138 );
            return;
        }
        
        maxspread = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_c17b4c0bceb0f584 ?? 2;
        spreadrange = level.var_b7d9d7926154819d.ammomodbundles[ "napalmburst" ].var_e82466cb096d7d91 ?? 50;
        zombies = getaiarrayinradius( self.origin, spreadrange );
        numspread = 0;
        
        foreach ( zombie in zombies )
        {
            if ( zombie != self && numspread < maxspread && !zombie zombie_utils::function_bf1464d09f4e4b40() )
            {
                zombie callback::callback( "napalmburst_proc", params );
                numspread++;
                
                if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"napalmburst_contact_burn" ) )
                {
                    continue;
                }
                
                zombie.napalmburst_proc_weapon = sweapon;
                success = zombie effect_burn::burn( napalmbursttime, napalmburstdamage, 1, attacker, "napalmburst", postfix, undefined, "fire", undefined, undefined, var_39b5b4282d55b138 );
            }
        }
        
        self.napalmburst_proc_weapon = sweapon;
        success = effect_burn::burn( napalmbursttime, napalmburstdamage, 1, attacker, "napalmburst", postfix, undefined, "fire", undefined, undefined, var_39b5b4282d55b138 );
    }
}

// Namespace napalmburst
// Params 1
// Checksum 0x1ca1c6d3, Offset: 0x10c1
// Size: 0x7b
function on_napalmburst_kill( params )
{
    if ( isagent( self ) && isplayer( params.eattacker ) && utility::ent_flag( "napalm_burned" ) )
    {
        if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
        {
            params.eattacker utility::callsharedfunc( #"medal", #"track_rapid_kill", "napalmburst" );
        }
    }
}

// Namespace napalmburst
// Params 0
// Checksum 0xd1aaf8e8, Offset: 0x1144
// Size: 0xd0, Type: bool
function function_6f8d6d1219f03221()
{
    if ( level.ammo_mods[ "napalmburst" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( isdefined( self.var_afd0e6115acbd5ab ) )
    {
        failnapalmburst = [[ self.var_afd0e6115acbd5ab ]]();
        
        if ( !failnapalmburst )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_7a528f29b93aec7f )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

/#

    // Namespace napalmburst
    // Params 0
    // Checksum 0xb5d3baa7, Offset: 0x121d
    // Size: 0xa0, Type: dev
    function function_f559ef8e9d4f5469()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x30>" );
        }
    }

    // Namespace napalmburst
    // Params 0
    // Checksum 0x3c750008, Offset: 0x12c5
    // Size: 0x2f, Type: dev
    function setup_napalmburst_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4a>" );
        devgui::add_devgui_func( "<dev string:x5b>", "<dev string:x6d>", &function_f559ef8e9d4f5469, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
