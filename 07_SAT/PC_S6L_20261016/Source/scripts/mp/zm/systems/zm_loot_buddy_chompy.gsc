// scripts\mp\zm\systems\zm_loot_buddy_chompy.gsc  (hash_5d2d7cc4857dcd75.gscc) (size: 14937 Bytes / 0x3a59 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25271f1a (623320858)
// size ...... 14937 (0x3a59)
// includes .. 15  (offset: 0x35a9)
// strings ... 70  (offset: 0x3621)
// dev strs .. 11  (offset: 0x39d1)
// exports ... 31  (offset: 0x23cd)
// cseg ...... 0x69d + 0x1d30 (0x23cd)
// imports ... 108 (offset: 0x28a5)
// animtree1 . 0   (offset: 0x3a59)
// animtree2 . 0   (offset: 0x3a59)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_loot_buddy_chompy;

// Namespace zm_loot_buddy_chompy
// Params 0, eflags: 0x5
// Checksum 0x8585dc49, Offset: 0x6bb
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_loot_buddy_chompy", undefined, undefined, &post_init );
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0x7ec17f46, Offset: 0x6dc
// Size: 0x85
function post_init()
{
    if ( getdvarint( @"hash_1a200a5b437d0133", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait( "begin_round_logic" );
    level.var_4b87ada4484ec4cd = utility::getstructarray( "loot_buddy_chompy", "targetname" );
    
    if ( !isdefined( level.var_4b87ada4484ec4cd ) )
    {
        return;
    }
    
    level._effect[ "chompy_eliminate_equipment" ] = loadfxasset( "vfx_sat_zm_chompy_equipment_cleaned" );
    setup_loot_buddy_chompy();
    level callback::add( "zm_exfil_started", &on_exfil_start );
    
    /#
        function_351d7d070e44d5c3();
    #/
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0x58709e8d, Offset: 0x769
// Size: 0x28e
function setup_loot_buddy_chompy()
{
    level.var_9e882472caa078f1 = [ "molotov_zm", "frag_grenade_zm", "c4_zm", "semtex_zm", "combataxe_zm", "thermobaric_grenade_zm", "impact_grenade_zm", "monkey_bomb_zm", "cluster_grenade_zm", "concussion_grenade_zm", "gas_grenade_zm", "decoy_grenade_zm", "shock_stick_zm", "blackhole_bomb_zm", "mini_sentry_zm", "smart_seeker_zm", "smoke_grenade_mp" ];
    level.var_69fdad347dd6817 = [];
    
    foreach ( chompy_struct in level.var_4b87ada4484ec4cd )
    {
        chompy = spawnscriptable( "zm_sat_loot_chompy", chompy_struct.origin, chompy_struct.angles );
        chompy.zone = chompy_struct.script_noteworthy;
        createnavobstaclebybounds( chompy.origin, ( 16, 16, 80 ), chompy.angles );
        level.var_69fdad347dd6817[ level.var_69fdad347dd6817.size ] = chompy;
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", chompy, "icon" );
        chompy setscriptablepartstate( "health", "ignore_damage" );
        
        if ( game_utility::function_21211f3255f8ea58() )
        {
            chompy active_chompy();
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"zombie", #"is_chompy_activated" ) )
        {
            if ( utility::callsharedfunc( #"zombie", #"is_chompy_activated", chompy ) )
            {
                chompy active_chompy();
            }
        }
    }
    
    level.var_8883146a5000bc64 = throttle::throttle_initialize( "zm_chompy_grenade_throttle", 1, level.framedurationseconds );
    level callback::add( #"player_weapon_change", &function_bf20cb8e6472c74f );
    level callback::add( #"grenade_fire", &on_grenade_fire );
    level callback::add( "on_round_start", &on_round_start );
    scriptable::scriptable_adddamagedcallback( &function_b714aae6360c812a );
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0x98639a5a, Offset: 0x9ff
// Size: 0x76
function function_bf20cb8e6472c74f( params )
{
    if ( !isdefined( params.lastweapon ) )
    {
        return;
    }
    
    noaltweapon = params.lastweapon getnoaltweapon();
    
    if ( noaltweapon.hasalternate )
    {
        if ( params.lastweapon.isalternate )
        {
            self.var_76663d7dcc4df0b0 = 1;
            return;
        }
        
        self.var_76663d7dcc4df0b0 = 0;
    }
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0x3ebb904e, Offset: 0xa7d
// Size: 0x11d
function on_grenade_fire( params )
{
    if ( !function_4963515c86cea010( params.grenade.weapon_name ) )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.var_8883146a5000bc64, params.grenade );
    
    foreach ( chompy in level.var_69fdad347dd6817 )
    {
        if ( !chompy.activated || !chompy.opened || chompy.used )
        {
            continue;
        }
        
        if ( distance2dsquared( chompy.origin, self.origin ) < 262144 )
        {
            chompy thread function_b3c13d915e5dbc36( params.grenade );
        }
    }
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0xa253b37f, Offset: 0xba2
// Size: 0x21c
function on_round_start( params )
{
    roundnumber = params.roundnumber;
    
    if ( zm_round_spawning::is_special_round( roundnumber ) )
    {
        foreach ( chompy in level.var_69fdad347dd6817 )
        {
            if ( !chompy.is_spawning && ( chompy.activated == 1 || chompy.opened == 1 ) )
            {
                chompy deactive_chompy();
            }
        }
        
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        foreach ( chompy in level.var_69fdad347dd6817 )
        {
            if ( !chompy.activated && !utility::flag( "exfil_active" ) )
            {
                chompy active_chompy();
            }
        }
        
        return;
    }
    
    rand_array = arrayrandomize( level.var_69fdad347dd6817 );
    
    foreach ( chompy in rand_array )
    {
        if ( chompy.activated )
        {
            continue;
        }
        
        if ( zone_manager::function_65305a611c6226d9( chompy.origin ) )
        {
            chompy active_chompy();
            break;
        }
    }
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0x5300f1f5, Offset: 0xdc6
// Size: 0xb8
function on_exfil_start( params )
{
    foreach ( chompy in level.var_69fdad347dd6817 )
    {
        if ( !chompy.is_spawning && ( chompy.activated == 1 || chompy.opened == 1 ) )
        {
            chompy deactive_chompy();
        }
    }
}

// Namespace zm_loot_buddy_chompy
// Params 11
// Checksum 0xb8287914, Offset: 0xe86
// Size: 0x15f
function function_b714aae6360c812a( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_sat_loot_chompy" || !instance.activated || instance.is_spawning )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE" && !instance.opened )
    {
        if ( isplayer( eattacker ) )
        {
            eattacker damagefeedback::updatehitmarker( "standard" );
        }
        
        instance notify( #"lid_opened" );
        instance function_2ea3d5778c6eaee5();
        instance setscriptablepartstate( "anim", "open" );
        instance.opened = 1;
        instance.used = 0;
        instance thread function_6346ec74bef623d3();
        instance setscriptablepartstate( "use_part", "on" );
        
        if ( !isdefined( instance.interact ) )
        {
            instance.interact = interaction::register_scriptable_interact( instance, &function_af0a7215db834ce8, &function_af0a7215db834ce8, undefined, &chompy_hint_callback );
        }
        
        return;
    }
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0xb3cfdbaa, Offset: 0xfed
// Size: 0x3e
function active_chompy()
{
    self setscriptablepartstate( "health", "damage_detect" );
    self setscriptablepartstate( "simple_fx", "activated_fx" );
    self.activated = 1;
    self.used_count = 0;
    thread shake_shake();
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0xe4e8d4ea, Offset: 0x1033
// Size: 0x79
function deactive_chompy()
{
    waitframe();
    self setscriptablepartstate( "health", "ignore_damage" );
    self setscriptablepartstate( "use_part", "off" );
    self setscriptablepartstate( "simple_fx", "idle" );
    self notify( #"deactivated" );
    
    if ( self.opened )
    {
        self setscriptablepartstate( "anim", "close" );
    }
    
    self.is_spawning = 0;
    self.activated = 0;
    self.opened = 0;
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0x49fd8304, Offset: 0x10b4
// Size: 0x61
function shake_shake()
{
    level endon( #"game_ended" );
    self endon( #"lid_opened" );
    self endon( #"deactivated" );
    
    while ( true )
    {
        self setscriptablepartstate( "anim", "activated" );
        thread impact_zombie_corpses();
        wait 1;
        self setscriptablepartstate( "anim", "idle" );
        wait randomintrange( 2, 5 );
    }
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0x9d1675c5, Offset: 0x111d
// Size: 0x62
function impact_zombie_corpses()
{
    corpses = function_955f614470e71cb2( self.origin, 32 );
    
    if ( corpses.size > 0 )
    {
        physicsexplosionsphere( self.origin, 32, 0, 400, 0 );
        
        /#
            level thread utility::draw_circle( self.origin, 32, ( 1, 0, 0 ), 1, 0, 100 );
        #/
    }
}

// Namespace zm_loot_buddy_chompy
// Params 0, eflags: 0x4
// Checksum 0x92061e2f, Offset: 0x1187
// Size: 0x1f6
function private function_2ea3d5778c6eaee5()
{
    chompy = self;
    var_b73bdedd7cd65409 = getentarrayinradius( "grenade", #classname, self.origin, 512, 1 );
    
    /#
        if ( getdvarint( @"hash_37e54606b97511fa", 0 ) == 1 )
        {
            cylinder( chompy.origin, chompy.origin + anglestoup( chompy.angles ) * 54, 9, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    foreach ( var_dcee11752ff222a4 in var_b73bdedd7cd65409 )
    {
        if ( !function_4963515c86cea010( var_dcee11752ff222a4.weapon_name ) )
        {
            /#
                if ( getdvarint( @"hash_37e54606b97511fa", 0 ) == 1 )
                {
                    sphere( var_dcee11752ff222a4.origin, 5, ( 0, 1, 0 ), 0, 300 );
                }
            #/
            
            continue;
        }
        
        if ( !is_grenade_inbound( var_dcee11752ff222a4 ) )
        {
            /#
                if ( getdvarint( @"hash_37e54606b97511fa", 0 ) == 1 )
                {
                    sphere( var_dcee11752ff222a4.origin, 5, ( 0, 1, 0 ), 0, 300 );
                }
            #/
            
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_37e54606b97511fa", 0 ) == 1 )
            {
                sphere( var_dcee11752ff222a4.origin, 5, ( 1, 0, 0 ), 0, 300 );
            }
        #/
        
        playfx( level._effect[ "chompy_eliminate_equipment" ], var_dcee11752ff222a4.origin );
        var_dcee11752ff222a4 delete();
    }
}

// Namespace zm_loot_buddy_chompy
// Params 1, eflags: 0xc
// Checksum 0xd44679b, Offset: 0x1385
// Size: 0xd6
function private function_b3c13d915e5dbc36( var_c1c4dea3a061fc8 )
{
    self notify( #"hash_65dfbffa3496d296" );
    self endon( #"hash_65dfbffa3496d296" );
    level endon( #"game_ended" );
    self endon( #"deactivated" );
    self endon( #"fed" );
    
    while ( true )
    {
        if ( self.used )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_368a6e0fe7edb03e", 0 ) == 1 )
            {
                chompy_up = anglestoup( self.angles );
                cylinder( self.origin, self.origin + chompy_up * 54, 9, ( 0, 0, 1 ), 1, 2 );
            }
        #/
        
        if ( is_grenade_inbound( var_c1c4dea3a061fc8 ) )
        {
            thread process_reward( var_c1c4dea3a061fc8 );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_loot_buddy_chompy
// Params 1, eflags: 0x4
// Checksum 0xc309ecc, Offset: 0x1463
// Size: 0x246, Type: bool
function private is_grenade_inbound( var_dcee11752ff222a4 )
{
    chompy = self;
    
    if ( !var_dcee11752ff222a4 )
    {
        return false;
    }
    
    chompy_up_vec = anglestoup( chompy.angles );
    var_2ecc40091a72ad1d = vectordot( var_dcee11752ff222a4.origin - chompy.origin, chompy_up_vec );
    
    /#
        if ( getdvarint( @"hash_368a6e0fe7edb03e", 0 ) == 1 )
        {
            frames = 1000;
            line( chompy.origin, chompy.origin + chompy_up_vec * 54, ( 0, 0, 1 ), 1, 1, frames );
        }
    #/
    
    if ( var_2ecc40091a72ad1d < 0 || var_2ecc40091a72ad1d > 54 )
    {
        /#
            if ( getdvarint( @"hash_368a6e0fe7edb03e", 0 ) == 1 )
            {
                color = ( 1, 0, 0.5 );
                sphere( var_dcee11752ff222a4.origin, 2, color, 1, frames );
                var_51d9d9bd2ee1d437 = var_dcee11752ff222a4.origin - chompy_up_vec * var_2ecc40091a72ad1d;
                line( var_dcee11752ff222a4.origin, var_51d9d9bd2ee1d437 + chompy_up_vec * 54, color, 1, 1, frames );
                print3d( var_dcee11752ff222a4.origin, "<dev string:x24>" + var_2ecc40091a72ad1d - 54, color, 1, 0.1, frames );
            }
        #/
        
        return false;
    }
    
    var_ba3be218434b6076 = vectorfromlinetopoint( chompy.origin, chompy.origin + chompy_up_vec, var_dcee11752ff222a4.origin );
    var_78ed1c717233a899 = lengthsquared( var_ba3be218434b6076 );
    
    if ( var_dcee11752ff222a4.weapon_name == "sat_mini_sentry_zm" )
    {
        if ( var_78ed1c717233a899 >= 486 )
        {
            /#
                function_bb1876276197a304( var_dcee11752ff222a4, 486, var_ba3be218434b6076, frames );
            #/
            
            return false;
        }
    }
    else if ( var_78ed1c717233a899 >= 81 )
    {
        /#
            function_bb1876276197a304( var_dcee11752ff222a4, 81, var_ba3be218434b6076, frames );
        #/
        
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_368a6e0fe7edb03e", 0 ) == 1 )
        {
            sphere( var_dcee11752ff222a4.origin, 2, ( 0, 1, 0 ), 1, frames );
        }
    #/
    
    return true;
}

/#

    // Namespace zm_loot_buddy_chompy
    // Params 4, eflags: 0x4
    // Checksum 0xb37941bd, Offset: 0x16b2
    // Size: 0xfc, Type: dev
    function private function_bb1876276197a304( var_dcee11752ff222a4, limit_radius_squared, var_ba3be218434b6076, frames )
    {
        if ( !( getdvarint( @"hash_368a6e0fe7edb03e", 0 ) == 1 ) )
        {
            return;
        }
        
        limit_radius = limit_radius_squared;
        
        if ( limit_radius_squared >= 0.001 )
        {
            limit_radius = sqrt( limit_radius_squared );
        }
        
        color = ( 1, 0.5, 0 );
        sphere( var_dcee11752ff222a4.origin, 2, color, 1, frames );
        var_f5b64c15aa4502e7 = length( var_ba3be218434b6076 );
        diff = var_f5b64c15aa4502e7 - limit_radius;
        line( var_dcee11752ff222a4.origin, var_dcee11752ff222a4.origin - var_ba3be218434b6076 * diff / var_f5b64c15aa4502e7, color, 1, 1, frames );
        print3d( var_dcee11752ff222a4.origin, "<dev string:x27>" + diff, color, 1, 0.2, frames );
    }

#/

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0xe74f3c35, Offset: 0x17b6
// Size: 0xfa
function process_reward( ent )
{
    self notify( #"fed" );
    params = spawnstruct();
    params.chompy = self;
    params.var_84d654062e17327a = ent.weapon_name;
    params.player = ent.owner;
    level callback::callback( #"hash_9bb2110cc1b3cb2e", params );
    
    if ( isdefined( ent.turret ) )
    {
        ent.turret delete();
    }
    
    ent delete();
    self setscriptablepartstate( "simple_fx", "toss_in" );
    
    if ( utility::ent_flag( "skip_next_reward_drop" ) )
    {
        return;
    }
    
    self.used = 1;
    reward_result = function_30c6d7096006ff9b( params.var_84d654062e17327a );
    thread spawn_rewards( reward_result, params.player, "zm_round_reward_bundle_zm_loot_destruction_creature_equipment" );
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0x693d9324, Offset: 0x18b8
// Size: 0x3d
function function_6346ec74bef623d3()
{
    level endon( #"game_ended" );
    self endon( #"deactivated" );
    self endon( #"fed" );
    wait getdvarint( @"hash_7f9e3e283a784374", 30 );
    thread deactive_chompy();
}

// Namespace zm_loot_buddy_chompy
// Params 2
// Checksum 0x4ebcd22, Offset: 0x18fd
// Size: 0x10b
function chompy_hint_callback( interact, player )
{
    if ( !interact.opened || interact.used || player.ismutantinjection || is_current_weapon_invalid( player ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( !isdefined( interaction_description ) )
    {
        interaction_description = &"shared_hintstrings/buddy_chompy_use";
    }
    
    b_can_be_used = 1;
    aux_text_custom = &"";
    return { #interactable:b_can_be_used, #aux_text:aux_text_custom, #icon:"sat_ui_icon_zm_loot_devouring_creature", #buttoncallout:&"shared_hintstrings/buddy_chompy_button", #description:interaction_description, #title:&"shared_hintstrings/buddy_chompy_title", #type:"HINT_BUTTON" };
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0x7a32b6b5, Offset: 0x1a11
// Size: 0x69, Type: bool
function is_current_weapon_invalid( player )
{
    current_weapon = player getcurrentweapon();
    return isdefined( current_weapon ) && issubstr( current_weapon.basename, "_me_" ) || issubstr( current_weapon.basename, "_fists_" ) || issubstr( current_weapon.basename, "_ks_" );
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0xdbbd628a, Offset: 0x1a83
// Size: 0x3d
function function_af0a7215db834ce8( player )
{
    if ( player.ismutantinjection || is_current_weapon_invalid( player ) || self.used )
    {
        return;
    }
    
    function_e8ee978f3a23841e( player );
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0x63a3c9f, Offset: 0x1ac8
// Size: 0x2fb
function function_e8ee978f3a23841e( player )
{
    current_weapon = player getcurrentweapon();
    
    if ( !isdefined( current_weapon ) )
    {
        return;
    }
    
    no_alt_weapon = current_weapon getnoaltweapon();
    
    if ( !no_alt_weapon )
    {
        assert( "<dev string:x2a>" );
        return;
    }
    
    if ( no_alt_weapon.basename == "sat_ww_firefly_zm" || no_alt_weapon.basename == "t10_la_mangler_cannon_mp" )
    {
        return;
    }
    
    self.used = 1;
    self notify( #"fed" );
    reward_result = player item_weapon::function_fb81bd2fe070faa6( no_alt_weapon );
    player item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:no_alt_weapon } );
    var_3df86f0b126863ab = player getweaponslistprimaries();
    var_f2d094db5b2934f3 = 0;
    params = spawnstruct();
    params.player = player;
    params.chompy = self;
    params.weapon_rarity = reward_result;
    params.weapon = no_alt_weapon;
    level callback::callback( "chompy_eats_weapon", params );
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( isdefined( weapon.basename ) && !issubstr( weapon.basename, "_me_" ) && weapon.isalternate == istrue( player.var_76663d7dcc4df0b0 ) )
        {
            var_f2d094db5b2934f3 = 1;
            player inventory_utility::_switchtoweapon( weapon );
            break;
        }
    }
    
    if ( !var_f2d094db5b2934f3 )
    {
        player inventory_utility::_switchtoweapon( player.var_cc1262e66dbb1c79 );
    }
    
    itembundlename = item_weapon::function_3da93a43aae4473d( no_alt_weapon.basename, reward_result );
    
    if ( !isdefined( itembundlename ) )
    {
        return;
    }
    
    item_bundle = getscriptbundlefieldvalues( itembundlename, [ #"ref", #"subtype", #"rarity", #"scriptable" ] );
    subtype = isdefined( item_bundle.subtype ) && item_bundle.subtype != "" ? item_bundle.subtype : " ";
    var_990db5582ab12a24 = subtype == "ww" ? "legendary_noww" : undefined;
    thread spawn_rewards( reward_result, player, "zm_round_reward_bundle_zm_loot_destruction_creature_weapon", var_990db5582ab12a24 );
    playsoundatpos( self.origin, "evt_zm_loot_chompy_buddy_weapon_feed" );
}

// Namespace zm_loot_buddy_chompy
// Params 4
// Checksum 0xd53b1008, Offset: 0x1dcb
// Size: 0x9d
function spawn_rewards( reward_result, player, var_9de7955acb0bdf5, var_990db5582ab12a24 )
{
    level endon( #"game_ended" );
    self.is_spawning = 1;
    
    if ( !isdefined( var_990db5582ab12a24 ) )
    {
        var_990db5582ab12a24 = [ "common", "uncommon", "rare", "epic", "legendary", "wonder_weapon" ][ reward_result ];
    }
    
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( var_9de7955acb0bdf5, var_990db5582ab12a24 );
    function_2ef053681478d508( var_8b5270de14dff72e );
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0xa01d252c, Offset: 0x1e70
// Size: 0x1ce
function function_2ef053681478d508( var_8b5270de14dff72e )
{
    level endon( #"game_ended" );
    self endon( #"deactivated" );
    drop_point = vectornormalize( anglestoforward( self.angles ) ) * 50 + self.origin;
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        
        if ( !isdefined( itemspawnentryname ) )
        {
            continue;
        }
        
        itembundle = getscriptbundle( itemspawnentryname );
        assert( isdefined( itembundle ), "<dev string:x44>" + getxhashsourcename( itemspawnentryname ) + "<dev string:x77>" );
        
        if ( !isdefined( itembundle ) )
        {
            continue;
        }
        
        drop_point = utility::function_7afe366c29a77c34( drop_point, 16 );
        drop_point = utility::drop_to_ground( drop_point + ( 0, 0, 100 ), 100 );
        
        if ( itembundle.subtype == "ww" )
        {
            self setscriptablepartstate( "anim", "spit" );
            wait 0.7;
            reward_item = common_item::function_47324f290423b2d1( itembundle, self.origin + ( 0, 0, 40 ), drop_point );
        }
        else
        {
            self setscriptablepartstate( "anim", "spit" );
            wait 0.7;
            reward_item = common_item::function_47324f290423b2d1( itembundle, self.origin + ( 0, 0, 40 ), drop_point );
        }
        
        wait 0.5;
        self setscriptablepartstate( "anim", "idle" );
        waitframe();
    }
    
    self.used_count++;
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        thread chompy_cooldown();
        return;
    }
    
    if ( self.used_count < getdvarint( @"hash_37a7f3b97e04d313", 3 ) )
    {
        thread chompy_cooldown();
        return;
    }
    
    thread deactive_chompy();
}

// Namespace zm_loot_buddy_chompy
// Params 0
// Checksum 0x1da55136, Offset: 0x2046
// Size: 0x78
function chompy_cooldown()
{
    self setscriptablepartstate( "health", "ignore_damage" );
    self setscriptablepartstate( "simple_fx", "idle" );
    self notify( #"deactivated" );
    
    if ( self.opened )
    {
        self setscriptablepartstate( "anim", "close" );
    }
    
    self.is_spawning = 0;
    self.opened = 0;
    wait 3;
    self setscriptablepartstate( "health", "damage_detect" );
    thread shake_shake();
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0xc71e2ce, Offset: 0x20c6
// Size: 0x8a, Type: bool
function function_4963515c86cea010( var_84d654062e17327a )
{
    foreach ( sub_name in level.var_9e882472caa078f1 )
    {
        if ( issubstr( var_84d654062e17327a, sub_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_loot_buddy_chompy
// Params 1
// Checksum 0xb49f6198, Offset: 0x2159
// Size: 0xfd
function function_30c6d7096006ff9b( var_84d654062e17327a )
{
    switch ( var_84d654062e17327a )
    {
        case #"hash_194d3b2ed5e653f":
        case #"hash_44530a27aa4e5f44":
        case #"hash_561c8b746e410ccb":
        case #"hash_6ce1a0215875502b":
        case #"hash_97ea2681ba9bc629":
        case #"hash_a6f18a9bef96c440":
        case #"hash_b582765f5ca52859":
            return 0;
        case #"hash_15bfd734161777":
        case #"hash_3d75f593b48f3177":
        case #"hash_4c57d6c06d26f709":
        case #"hash_b89d39c917928224":
        case #"hash_c1db04d50cf2cdce":
        case #"hash_c55c1a8a6b7fe6ab":
        case #"hash_d29391c45c0cfd69":
        case #"hash_ff1dcda62f5d6430":
            return 1;
        case #"hash_601c9e67f8e4e0a6":
            return 2;
        case #"hash_99a952a970bfa5e4":
            return 3;
        default:
            break;
    }
    
    return 0;
}

/#

    // Namespace zm_loot_buddy_chompy
    // Params 0
    // Checksum 0xf2ca085f, Offset: 0x225f
    // Size: 0x44, Type: dev
    function function_351d7d070e44d5c3()
    {
        devgui::function_9082edeb5db93280( "<dev string:x79>" );
        devgui::add_devgui_func( "<dev string:x96>", "<dev string:x96>", &function_4c27fb4116a5a872 );
        devgui::add_devgui_func( "<dev string:xae>", "<dev string:xbf>", &function_260cc0469bc4bfb2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_loot_buddy_chompy
    // Params 0
    // Checksum 0x80383479, Offset: 0x22ab
    // Size: 0xa3, Type: dev
    function function_4c27fb4116a5a872()
    {
        foreach ( chompy in level.var_69fdad347dd6817 )
        {
            if ( chompy.activated )
            {
                continue;
            }
            
            if ( zone_manager::function_65305a611c6226d9( chompy.origin ) )
            {
                chompy active_chompy();
            }
        }
    }

    // Namespace zm_loot_buddy_chompy
    // Params 0, eflags: 0x4
    // Checksum 0x19996f96, Offset: 0x2356
    // Size: 0x77, Type: dev
    function private function_260cc0469bc4bfb2()
    {
        setdvar( @"scr_devgui_cmd", "<dev string:xd7>" );
        wait 1;
        function_4c27fb4116a5a872();
        wait 1;
        me = level.players[ 0 ];
        me setorigin( ( 4443.8, -2656.6, 278.2 ) );
        me setplayerangles( ( 46, 40, 0 ) );
        setdvar( @"scr_give_equipment", "<dev string:xfd>" );
    }

#/
