// scripts\mp\bots\bots_gametype_arena.gsc  (hash_7639fc49d22c75c2.gscc) (size: 6099 Bytes / 0x17d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf5030e9e (4110618270)
// size ...... 6099 (0x17d3)
// includes .. 12  (offset: 0x1663)
// strings ... 19  (offset: 0x16c3)
// dev strs .. 0   (offset: 0x17d3)
// exports ... 14  (offset: 0xe67)
// cseg ...... 0x264 + 0xc03 (0xe67)
// imports ... 49  (offset: 0x1097)
// animtree1 . 0   (offset: 0x17d3)
// animtree2 . 0   (offset: 0x17d3)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\arena;

#namespace bots_gametype_arena;

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x1d7e6c86, Offset: 0x282
// Size: 0x1b
function main()
{
    level.var_ae4d3fde002fedb4 = 1;
    setup_callbacks();
    setup_bot_arena();
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x2789ceca, Offset: 0x2a5
// Size: 0x66
function setup_callbacks()
{
    if ( arena::ispickuploadouts() )
    {
        level.bot_think_funcs[ "seek_dropped_weapon" ] = &arena_bot_think_seek_dropped_weapons;
        level.bot_funcs[ "dropped_weapon_cancel" ] = &arena_should_stop_seeking_weapon;
    }
    
    level.bot_funcs[ "gametype_think" ] = &bot_arena_think;
    autopilot::initialize( undefined, undefined, [ "bot_arena_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x69e181a9, Offset: 0x313
// Size: 0x17
function setup_bot_arena()
{
    if ( !arena::isnormalloadouts() )
    {
        level.bots_gametype_handles_class_choice = 1;
    }
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x2d348b02, Offset: 0x332
// Size: 0x153
function bot_arena_think()
{
    self notify( #"bot_arena_think" );
    self endon( #"bot_arena_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 0.1;
    
    if ( !arena::isnormalloadouts() )
    {
        if ( self botgetdifficultysetting( "advancedPersonality" ) && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            bots_personality::function_cc26fb6ecde979dc( 1 );
        }
    }
    
    self.otflaggoal = 0;
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.arenaflag ) && gameobjects_shared::is_activated( level.arenaflag ) )
        {
            if ( !isdefined( level.arenaflag.tacpoints ) )
            {
                level.arenaflag.tacpoints = bots_gametype_common::function_3491b57e9cace1d5( level.arenaflag, 1 );
            }
            
            if ( !bots_scripted_defense::is_capturing() || !self.otflaggoal )
            {
                bots_scripted_defense::capture_zone( gameobjects_shared::get_origin( level.arenaflag ), level.arenaflag.tacpoints, level.arenaflag );
                self.otflaggoal = 1;
            }
        }
        else
        {
            self [[ self.personality_update_function ]]();
        }
        
        wait 0.05;
    }
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0xcf442213, Offset: 0x48d
// Size: 0x29c
function arena_bot_think_seek_dropped_weapons()
{
    self notify( #"bot_think_seek_dropped_weapons" );
    self endon( #"bot_think_seek_dropped_weapons" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    throwing_knife_name = "throwingknife_mp";
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        if ( arena_bot_out_of_ammo() || bots_util::bot_get_low_on_all_ammo( 0.33 ) )
        {
            if ( self [[ level.bot_funcs[ "should_pickup_weapons" ] ]]() && !bots_util::bot_is_remote_or_linked() )
            {
                dropped_weapons = getentarray( "dropped_weapon", #targetname );
                dropped_weapons_sorted = utility::get_array_of_closest( self.origin, dropped_weapons );
                
                if ( dropped_weapons_sorted.size > 0 )
                {
                    dropped_weapon = dropped_weapons_sorted[ 0 ];
                    level.dropped_weapon = dropped_weapon;
                    arena_bot_seek_dropped_weapon( dropped_weapon );
                }
            }
        }
        
        if ( !bots_util::bot_in_combat() && !bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            var_aab543b0ce6a431a = self hasweapon( throwing_knife_name );
            knife_thrown = var_aab543b0ce6a431a && self getammocount( throwing_knife_name ) == 0;
            
            if ( knife_thrown )
            {
                if ( isdefined( self.going_for_knife ) )
                {
                    wait 5;
                    continue;
                }
                
                dropped_knives = getentarray( "dropped_knife", #targetname );
                dropped_knives_sorted = utility::get_array_of_closest( self.origin, dropped_knives );
                
                foreach ( knife in dropped_knives_sorted )
                {
                    if ( !isdefined( knife ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( knife.calculated_closest_point ) )
                    {
                        result = self getclosestreachablepointonnavmesh( knife.origin );
                        
                        if ( isdefined( knife ) )
                        {
                            knife.closest_point_on_grid = result;
                            knife.calculated_closest_point = 1;
                        }
                        else
                        {
                            continue;
                        }
                    }
                    
                    if ( isdefined( knife.closest_point_on_grid ) )
                    {
                        self.going_for_knife = 1;
                        arena_bot_seek_dropped_weapon( knife );
                    }
                }
            }
            else if ( var_aab543b0ce6a431a )
            {
                self.going_for_knife = undefined;
            }
        }
        
        wait randomfloatrange( 0.25, 0.75 );
    }
}

// Namespace bots_gametype_arena
// Params 1
// Checksum 0x28a7c4da, Offset: 0x731
// Size: 0x256
function arena_bot_seek_dropped_weapon( dropped_weapon )
{
    if ( bots_tactical_goals::has_tactical_goal( "seek_dropped_weapon", dropped_weapon ) == 0 )
    {
        if ( level.snowballfight )
        {
            bot_lethal = self botfirstavailablegrenade( "lethal" );
            bot_tactical = self botfirstavailablegrenade( "tactical" );
            
            if ( isdefined( bot_lethal ) && bot_lethal.basename == "snowball_mp" )
            {
                eq = equipment_mp::getcurrentequipment( "primary" );
                eqammo = equipment_mp::getequipmentammo( eq );
                
                if ( bot_lethal.basename == "snowball_mp" && eqammo > 3 )
                {
                    return;
                }
            }
            
            if ( isdefined( bot_tactical ) && bot_tactical.basename == "pball_mp" )
            {
                eq = equipment_mp::getcurrentequipment( "secondary" );
                eqammo = equipment_mp::getequipmentammo( eq );
                
                if ( bot_tactical.basename == "pball_mp" )
                {
                    return;
                }
            }
        }
        
        action_thread = undefined;
        
        if ( dropped_weapon.targetname == "dropped_weapon" )
        {
            var_9d66e89aefc3eae7 = 1;
            heldweapons = self getweaponslistprimaries();
            
            foreach ( held_weapon in heldweapons )
            {
                if ( dropped_weapon.model == getweaponmodel( held_weapon ) )
                {
                    var_9d66e89aefc3eae7 = 0;
                }
            }
            
            if ( var_9d66e89aefc3eae7 )
            {
                action_thread = &arena_bot_pickup_weapon;
            }
        }
        
        extra_params = spawnstruct();
        extra_params.object = dropped_weapon;
        extra_params.script_goal_radius = 12;
        extra_params.should_abort = level.bot_funcs[ "dropped_weapon_cancel" ];
        extra_params.action_thread = action_thread;
        nearestnode = dropped_weapon.origin;
        
        if ( isdefined( dropped_weapon.bot_pickup_origin ) )
        {
            nearestnode = dropped_weapon.bot_pickup_origin;
        }
        
        bots_tactical_goals::new_tactical_goal( "seek_dropped_weapon", nearestnode, 100, extra_params );
    }
}

// Namespace bots_gametype_arena
// Params 1
// Checksum 0x7c4d12dc, Offset: 0x98f
// Size: 0x23
function arena_bot_pickup_weapon( goal )
{
    self botpressbutton( "use", 0.5 );
    thread updatebotpersonalitybasedonweapon();
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x5add1cba, Offset: 0x9ba
// Size: 0x43
function updatebotpersonalitybasedonweapon()
{
    self notify( #"hash_277da69943dfee37" );
    self endon( #"hash_277da69943dfee37" );
    wait 2;
    
    if ( self botgetdifficultysetting( "advancedPersonality" ) && self botgetdifficultysetting( "strategyLevel" ) > 0 )
    {
        bots_personality::function_cc26fb6ecde979dc( 1 );
    }
}

// Namespace bots_gametype_arena
// Params 1
// Checksum 0x557d768f, Offset: 0xa05
// Size: 0x188, Type: bool
function arena_should_stop_seeking_weapon( goal )
{
    if ( arena_bot_get_total_gun_ammo() > 0 )
    {
        var_5c059d723e21a23c = weapon::getweapongroup( self getcurrentweapon() );
        
        if ( isdefined( goal.object ) )
        {
            dropped_weapon_name = goal.object.classname;
            
            if ( isstartstr( dropped_weapon_name, "weapon_" ) )
            {
                dropped_weapon_name = getsubstr( dropped_weapon_name, 7 );
            }
            
            weapgroup = weapon::getweapongroup( dropped_weapon_name );
            
            if ( !bot_weapon_is_better_class( var_5c059d723e21a23c, weapgroup ) )
            {
                return true;
            }
        }
    }
    
    if ( !isdefined( goal.object ) )
    {
        return true;
    }
    
    if ( goal.object.targetname == "dropped_weapon" )
    {
        foreach ( weapon in self.weaponlist )
        {
            if ( weapon::isfistweapon( weapon ) )
            {
                return false;
            }
        }
        
        if ( arena_bot_get_total_gun_ammo() > 0 )
        {
            return true;
        }
    }
    else if ( goal.object.targetname == "dropped_knife" )
    {
        if ( bots_util::bot_in_combat() )
        {
            self.going_for_knife = undefined;
            return true;
        }
    }
    
    return false;
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x8d342dba, Offset: 0xb96
// Size: 0xd8
function arena_bot_get_total_gun_ammo()
{
    total_ammo = 0;
    weapon_list = undefined;
    
    if ( self.weaponlist.size > 0 )
    {
        weapon_list = self.weaponlist;
    }
    else
    {
        weapon_list = self getweaponslistprimaries();
    }
    
    foreach ( weapon in weapon_list )
    {
        total_ammo += self getweaponammoclip( weapon );
        total_ammo += self getweaponammostock( weapon );
    }
    
    if ( weapon_list.size == 1 && weapon::isfistweapon( weapon_list[ 0 ] ) )
    {
        total_ammo = 0;
    }
    
    return total_ammo;
}

// Namespace bots_gametype_arena
// Params 0
// Checksum 0x9de515ec, Offset: 0xc77
// Size: 0xd1, Type: bool
function arena_bot_out_of_ammo()
{
    weapon_list = undefined;
    
    if ( self.weaponlist.size > 0 )
    {
        weapon_list = self.weaponlist;
    }
    else
    {
        weapon_list = self getweaponslistprimaries();
    }
    
    if ( weapon_list.size == 1 && weapon::isfistweapon( weapon_list[ 0 ] ) )
    {
        return true;
    }
    
    foreach ( weapon in weapon_list )
    {
        if ( self getweaponammoclip( weapon ) > 0 )
        {
            return false;
        }
        
        if ( self getweaponammostock( weapon ) > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots_gametype_arena
// Params 1
// Checksum 0x815ab6c, Offset: 0xd51
// Size: 0xcd
function bot_rank_weapon_class( weapgroup )
{
    weaprank = 0;
    
    switch ( weapgroup )
    {
        case #"hash_2a94fec6c49569e9":
        case #"hash_94b6083b667776c8":
        case #"hash_9d18adab1b65a661":
        case #"hash_f52e65764345d6c0":
            break;
        case #"hash_34340d457a63e7f1":
            weaprank = 1;
            break;
        case #"hash_47368bc0d2ef1565":
        case #"hash_c095d67337b1f5a1":
            weaprank = 2;
            break;
        case #"hash_bef5ec0b3e197ae":
        case #"hash_16cf6289ab06bd30":
        case #"hash_8af0086b038622b5":
        case #"hash_ab10f9c080fe4faf":
        case #"hash_dd616da0b395a0b0":
            weaprank = 3;
            break;
    }
    
    return weaprank;
}

// Namespace bots_gametype_arena
// Params 2
// Checksum 0xc87ed42c, Offset: 0xe27
// Size: 0x3f, Type: bool
function bot_weapon_is_better_class( oldweapclass, newweapclass )
{
    var_8fbec696ce15d654 = bot_rank_weapon_class( oldweapclass );
    var_23de4cfe06883ee7 = bot_rank_weapon_class( newweapclass );
    return var_23de4cfe06883ee7 > var_8fbec696ce15d654;
}

