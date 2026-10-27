// scripts\mp\zm\systems\zm_powerups_ee.gsc  (hash_606e2df9a1cbce1b.gscc) (size: 4985 Bytes / 0x1379 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x452f95b4 (1160746420)
// size ...... 4985 (0x1379)
// includes .. 6   (offset: 0x1259)
// strings ... 16  (offset: 0x1289)
// dev strs .. 0   (offset: 0x1379)
// exports ... 13  (offset: 0xb51)
// cseg ...... 0x170 + 0x9e1 (0xb51)
// imports ... 41  (offset: 0xd59)
// animtree1 . 0   (offset: 0x1379)
// animtree2 . 0   (offset: 0x1379)
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_powerups_ee;

// Namespace zm_powerups_ee
// Params 0, eflags: 0x5
// Checksum 0xaaec0fc1, Offset: 0x18e
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"powerups_ee", #"zm_quest", &pre_init_zm_powerups_ee, &post_init_zm_powerups_ee );
}

// Namespace zm_powerups_ee
// Params 0
// Checksum 0x683a60c4, Offset: 0x1bb
// Size: 0x7d
function pre_init_zm_powerups_ee()
{
    setdvarifuninitialized( @"hash_c5a3ce6529ef6314", 0 );
    
    if ( !getdvarint( @"hash_c5a3ce6529ef6314", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"powerups_ee", #"get_powerups", &spawn_powerup_models, &function_e3b6816ce8005f78 );
    zm_quest::register_quest_step( #"powerups_ee", #"final_powerup", &function_8da1b4a054be8d08, &function_976a5928bf74f094 );
}

// Namespace zm_powerups_ee
// Params 1
// Checksum 0x9adc9fe8, Offset: 0x240
// Size: 0x70
function post_init_zm_powerups_ee( var_6f88a6bfefadea5e )
{
    if ( !getdvarint( @"hash_c5a3ce6529ef6314", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "zm_powerups_init_done" );
    zm_save::function_1f44a48caae2acbf();
    scriptable::scriptable_adddamagedcallback( &function_a25ea7eadca352f3 );
    level thread zm_quest::start_quest( #"powerups_ee" );
}

// Namespace zm_powerups_ee
// Params 2
// Checksum 0xc7c164ac, Offset: 0x2b8
// Size: 0xdc
function function_e3b6816ce8005f78( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        var_7d1749d76868cceb = utility::getstructarray( "pu_ee_spawn", "targetname" );
        
        foreach ( s_spawn in var_7d1749d76868cceb )
        {
            if ( isdefined( s_spawn.scriptable ) && isplayer( level.players[ 0 ] ) )
            {
                s_spawn.scriptable powerup_ee_model_hit_success( level.players[ 0 ] );
            }
        }
    }
}

// Namespace zm_powerups_ee
// Params 2
// Checksum 0x865f6d0b, Offset: 0x39c
// Size: 0x21f
function spawn_powerup_models( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_save_restored && isdefined( zm_quest::function_73720cdf21c3cfd7( #"powerups_ee", #"fire_sale" ) ) )
    {
        return;
    }
    
    level utility::flag_wait( "init_powerups_complete" );
    var_b06607667f4568a5 = zm_quest::get_quest( #"powerups_ee" ).save_kvps.size;
    var_7d1749d76868cceb = utility::getstructarray( "pu_ee_spawn", "targetname" );
    
    foreach ( s_spawn in var_7d1749d76868cceb )
    {
        s_powerup_info = powerups::get_powerup_info( s_spawn.script_noteworthy );
        
        if ( !( isdefined( s_powerup_info ) && isdefined( s_powerup_info.model ) ) )
        {
            continue;
        }
        
        if ( var_b06607667f4568a5 && !isdefined( zm_quest::function_73720cdf21c3cfd7( #"powerups_ee", getxhash( s_spawn.script_noteworthy ) ) ) )
        {
            var_7d1749d76868cceb = arrayremove( var_7d1749d76868cceb, s_spawn );
            continue;
        }
        
        if ( !isdefined( s_spawn.angles ) )
        {
            s_spawn.angles = ( 0, 0, 0 );
        }
        
        scriptable = spawnscriptable( s_powerup_info.model + "_ee_scriptable", s_spawn.origin, s_spawn.angles );
        scriptable.s_spawn = s_spawn;
        s_spawn.scriptable = scriptable;
        zm_quest::function_4eefe6de31f5ddab( #"powerups_ee", getxhash( s_spawn.script_noteworthy ), 1 );
        scriptable thread function_563f9699d797327e();
        waitframe();
    }
    
    level utility::flag_set( "init_pu_ee_models" );
    utility::array_wait( var_7d1749d76868cceb, "powerup_complete" );
}

// Namespace zm_powerups_ee
// Params 11
// Checksum 0xfbcaf431, Offset: 0x5c3
// Size: 0x14d
function function_a25ea7eadca352f3( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    if ( !instance getscriptablehaspart( "powerup_ee_model" ) )
    {
        return;
    }
    
    if ( isarray( instance.var_d3160b7951e076d5 ) )
    {
        foreach ( func in instance.var_d3160b7951e076d5 )
        {
            var_9da5db4cafd64dce = [[ func ]]( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
            
            if ( var_9da5db4cafd64dce )
            {
                return;
            }
        }
    }
    
    if ( isplayer( eattacker ) && isdefined( instance.s_spawn ) )
    {
        instance notify( #"powerup_hit", eattacker );
    }
    
    return 0;
}

// Namespace zm_powerups_ee
// Params 0, eflags: 0x4
// Checksum 0x77f47f24, Offset: 0x719
// Size: 0x30
function private function_563f9699d797327e()
{
    self endon( #"death" );
    self waittill( #"powerup_hit", eattacker );
    thread powerup_ee_model_hit_success( eattacker );
}

// Namespace zm_powerups_ee
// Params 1
// Checksum 0xb786a291, Offset: 0x751
// Size: 0xa2
function powerup_ee_model_hit_success( eattacker )
{
    self.s_spawn.scriptable = undefined;
    self.s_spawn notify( #"powerup_complete" );
    zm_quest::function_6265be8d0549e1b1( #"powerups_ee", getxhash( self.s_spawn.script_noteworthy ) );
    eattacker thread powerups::force_powerup_drop( self.s_spawn.script_noteworthy, eattacker.origin, "hidden_ee" );
    self setscriptablepartstate( "model_health", "off" );
    utility::delaycall( 1, &freescriptable );
}

// Namespace zm_powerups_ee
// Params 2
// Checksum 0x4acb125f, Offset: 0x7fb
// Size: 0xf1
function function_8da1b4a054be8d08( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "init_powerups_complete" );
    var_cf8178bc59665bb6 = utility::getstructarray( "pu_ee_complete_spawn", "targetname" );
    
    if ( var_cf8178bc59665bb6[ 0 ].script_noteworthy == "fire_sale" )
    {
        var_fe804e5b5b5423c2 = var_cf8178bc59665bb6[ 0 ];
        var_1441037fdbe5fd6b = var_cf8178bc59665bb6[ 1 ];
    }
    else
    {
        var_fe804e5b5b5423c2 = var_cf8178bc59665bb6[ 1 ];
        var_1441037fdbe5fd6b = var_cf8178bc59665bb6[ 0 ];
    }
    
    if ( !zm_save::function_fcccc3d2a616b1c7() || zm_quest::function_73720cdf21c3cfd7( #"powerups_ee", #"fire_sale" ) )
    {
        level thread spawn_fire_sale( var_fe804e5b5b5423c2 );
    }
    
    if ( !zm_save::function_fcccc3d2a616b1c7() || zm_quest::function_73720cdf21c3cfd7( #"powerups_ee", #"free_perk" ) )
    {
        level thread spawn_free_perk( var_1441037fdbe5fd6b );
    }
    
    utility::array_wait( var_cf8178bc59665bb6, "powerup_complete" );
}

// Namespace zm_powerups_ee
// Params 1, eflags: 0x4
// Checksum 0x9de4ee83, Offset: 0x8f4
// Size: 0xaa
function private spawn_fire_sale( var_fe804e5b5b5423c2 )
{
    var_bf25b635b36775ce = powerups::get_powerup_info( var_fe804e5b5b5423c2.script_noteworthy );
    
    if ( isdefined( var_bf25b635b36775ce ) )
    {
        scriptable = spawnscriptable( var_bf25b635b36775ce.model + "_ee_scriptable", var_fe804e5b5b5423c2.origin, var_fe804e5b5b5423c2.angles );
        scriptable.s_spawn = var_fe804e5b5b5423c2;
        var_fe804e5b5b5423c2.scriptable = scriptable;
        zm_quest::function_4eefe6de31f5ddab( #"powerups_ee", getxhash( var_fe804e5b5b5423c2.script_noteworthy ), 1 );
        scriptable thread function_563f9699d797327e();
    }
}

// Namespace zm_powerups_ee
// Params 1, eflags: 0x4
// Checksum 0xa689306a, Offset: 0x9a6
// Size: 0xaa
function private spawn_free_perk( var_1441037fdbe5fd6b )
{
    var_62d28a8c426263e5 = powerups::get_powerup_info( var_1441037fdbe5fd6b.script_noteworthy );
    
    if ( isdefined( var_62d28a8c426263e5 ) )
    {
        scriptable = spawnscriptable( var_62d28a8c426263e5.model + "_ee_scriptable", var_1441037fdbe5fd6b.origin, var_1441037fdbe5fd6b.angles );
        scriptable.s_spawn = var_1441037fdbe5fd6b;
        var_1441037fdbe5fd6b.scriptable = scriptable;
        zm_quest::function_4eefe6de31f5ddab( #"powerups_ee", getxhash( var_1441037fdbe5fd6b.script_noteworthy ), 1 );
        scriptable thread function_563f9699d797327e();
    }
}

// Namespace zm_powerups_ee
// Params 2
// Checksum 0xf0938dda, Offset: 0xa58
// Size: 0xf9
function function_976a5928bf74f094( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    if ( b_skipped )
    {
        var_cf8178bc59665bb6 = utility::getstructarray( "pu_ee_complete_spawn", "targetname" );
        
        if ( var_cf8178bc59665bb6[ 0 ].script_noteworthy == "fire_sale" )
        {
            s_fire_sale = var_cf8178bc59665bb6[ 0 ];
            s_free_perk = var_cf8178bc59665bb6[ 1 ];
        }
        else
        {
            s_fire_sale = var_cf8178bc59665bb6[ 1 ];
            s_free_perk = var_cf8178bc59665bb6[ 0 ];
        }
        
        if ( isdefined( s_fire_sale.scriptable ) && isplayer( level.players[ 0 ] ) )
        {
            s_fire_sale.scriptable powerup_ee_model_hit_success( level.players[ 0 ] );
        }
        
        if ( isdefined( s_free_perk.scriptable ) && isplayer( level.players[ 0 ] ) )
        {
            s_free_perk.scriptable powerup_ee_model_hit_success( level.players[ 0 ] );
        }
    }
}

