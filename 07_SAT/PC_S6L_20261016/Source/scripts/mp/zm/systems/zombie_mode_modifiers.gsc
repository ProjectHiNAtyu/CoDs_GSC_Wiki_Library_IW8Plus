// scripts\mp\zm\systems\zombie_mode_modifiers.gsc  (hash_7f0ced39b52ff8a4.gscc) (size: 73386 Bytes / 0x11eaa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7205c9f3 (1912982003)
// size ...... 73386 (0x11eaa)
// includes .. 33  (offset: 0x11322)
// strings ... 152 (offset: 0x1142a)
// dev strs .. 18  (offset: 0x11dc6)
// exports ... 172 (offset: 0xbeba)
// cseg ...... 0xd8b + 0xb12f (0xbeba)
// imports ... 433 (offset: 0xd99a)
// animtree1 . 0   (offset: 0x11eaa)
// animtree2 . 0   (offset: 0x11eaa)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\wallbuy_armor;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zombie_mode_modifiers;

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x5
// Checksum 0xf4fcd20d, Offset: 0xda9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_mode_modifiers", undefined, &function_7f0c7103552b38c7, undefined );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x998bd0e4, Offset: 0xdca
// Size: 0x87c
function function_7f0c7103552b38c7()
{
    level.zm_mode_modifiers = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_zm_mode" ) ?? {};
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651", &function_fd75fceccbae5b4 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_d6ffe8bb178fbd1f", &function_92f63fb81d75b37a );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_fbbb0712f33c62e6", &function_4b709d26a6ee1179 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_16b8fb81542b725d", &function_add23b128d832ec4 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_weapon_change_carousel", &set_weapon_change_carousel );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_elemental_base_zombies", &set_elemental_base_zombies );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_fc4a6888094c2e9b", &function_e83cb78caa4379c8 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_545ec0b85eae52fc", &function_94e176e1a5bdaf75 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_7dfc9bdac73805a2", &function_976a35587fc99fb5 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_70586852998134e2", &function_f92dc7521b5280d );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_wallbuy_refill_ammo", &set_wallbuy_refill_ammo );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_no_self_revives", &set_no_self_revives );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_no_augments", &set_no_augments );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_no_ammo_cache", &set_no_ammo_cache );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_enemy_health_regen", &set_enemy_health_regen );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_delay_health_regen", &set_delay_health_regen );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_e632fde24edc95ba", &function_df9d58cae704cd17 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_electric_fields", &set_electric_fields );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_extra_bullet_cost", &set_extra_bullet_cost );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_no_armor", &set_no_armor );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_classic_points", &set_classic_points );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_952324a16c7cdfa5", &function_58783a99a744b5ce );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_8ecfa4a159b4a6b1", &function_e9561d9de97e194c );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_74e12d08ec24b807", &function_bee359d0ac0b705c );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_a681a2a6dfb281f0", &function_e5b02c0a2de2d037 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_no_mystery_box", &set_no_mystery_box );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_no_arsenal", &set_no_arsenal );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_2ec63fc4ecf657ea", &function_aa4686f6b37cd86d );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_zombies_explode_on_death", &set_zombies_explode_on_death );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_randomize_wallbuys", &set_randomize_wallbuys );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_only_critical_damage", &set_only_critical_damage );
    utility::registersharedfunc( #"zm_mode_modifiers", #"set_perk_machines_give_random_perks", &set_perk_machines_give_random_perks );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_8d7cb05856e28f7c", &function_2127454f44effa85 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_weapon_change_carousel", &disable_weapon_change_carousel );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_elemental_base_zombies", &disable_elemental_base_zombies );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_3e65155aca0efc1b", &function_2758f18ecfacc3b8 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_2cda259edf2ea2dd", &function_42d398a91a18e1d4 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_wallbuy_refill_ammo", &disable_wallbuy_refill_ammo );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_786cc79d952b8fc3", &function_d16770e41a7cf076 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_no_ammo_cache", &disable_no_ammo_cache );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_enemy_health_regen", &disable_enemy_health_regen );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_delay_health_regen", &disable_delay_health_regen );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_27b0c2185066ee3a", &function_8f7e749dccbefae7 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_electric_fields", &disable_electric_fields );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_extra_bullet_cost", &disable_extra_bullet_cost );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_no_armor", &disable_no_armor );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_cf734eacedf02322", &function_f603703b26e4b9e5 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_c3f6cb2e4d0c662", &function_291689d167db0ffd );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_a6783edcfb547925", &function_72789ed1f1c172de );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_10c8316937744987", &function_c2ac51278202f46c );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_b39effb9248ec731", &function_e619c5dce119c47c );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_4268a7072b021370", &function_789406545fb68be7 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_no_mystery_box", &disable_no_mystery_box );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_no_arsenal", &disable_no_arsenal );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_1d327898b0ab96a", &function_2561eb7557877d );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_9eb1ad3b8dd931f2", &function_7c445ae2fe3f2291 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"disable_randomize_wallbuys", &disable_randomize_wallbuys );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_bc21eef9c580b8f6", &function_c773e3123015f85d );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_f9cefde5c456883b", &function_b4f14329fffc472 );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_6843c64da905f4f8", &function_de2be231627b8af );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_d63c9c5b24a5004a", &function_602da0d19bc240ef );
    utility::registersharedfunc( #"zm_mode_modifiers", #"hash_f24df7e0f48f68ca", &function_483ce4653e168eff );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed );
    callback::add( "on_round_start", &on_round_start );
    callback::add( "on_round_end", &on_round_end );
    callback::add( #"item_weapon_picked_up", &function_221696eef23d2d0e );
    callback::add( #"player_item_drop", &on_item_dropped );
    callback::add( "wallbuy_armor_purchased", &on_wallbuy_armor_purchased );
    callback::add( "on_loot_consumed", &function_caa75d1d05e4043b );
    callback::add( #"player_weapon_change", &on_weapon_change );
    
    /#
        level thread function_d165ef11386fd51f();
    #/
    
    level._effect[ #"hash_e6eca969a60a9d62" ] = loadfxasset( "vfx_t10_gameplay_zm_magic_box_depart" );
    level._effect[ #"hash_cb3cba5fd0230e37" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_hound_hell_dth_aoe" );
    level._effect[ #"hash_52d0619ac30eb8c7" ] = loadfxasset( "vfx_sat_zm_hornet_cr_strike_warning" );
    function_dfc6bea3e0fa35d8();
    level notify( #"hash_460bdcc553e603b2" );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x2d673a17, Offset: 0x164e
// Size: 0xc, Type: bool
function function_fd75fceccbae5b4()
{
    return isdefined( level.zm_mode_modifiers );
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x5a33ee27, Offset: 0x1663
// Size: 0xb2
function private function_dfc6bea3e0fa35d8()
{
    if ( level.zm_mode_modifiers.var_a551bdc7e905a4fd )
    {
        function_92f63fb81d75b37a();
    }
    
    if ( level.zm_mode_modifiers.var_17778bfafdc97691 )
    {
        function_4b709d26a6ee1179();
    }
    
    if ( level.zm_mode_modifiers.var_12d1573e5e613c31 )
    {
        function_add23b128d832ec4();
    }
    
    if ( level.zm_mode_modifiers.var_8d8c37fcd619848e )
    {
        level thread set_weapon_change_carousel();
    }
    
    if ( level.zm_mode_modifiers.var_d3644cfcd25048c2 )
    {
        level thread function_94e176e1a5bdaf75();
    }
    
    if ( level.zm_mode_modifiers.var_7f34cf570cef6d7f )
    {
        set_classic_points();
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x1c878858, Offset: 0x171d
// Size: 0x110
function private on_player_spawned( params )
{
    if ( level.zm_mode_modifiers.var_a551bdc7e905a4fd )
    {
        if ( !zm_save::function_1dda3554974a999e() )
        {
            thread function_2bcdcde1ea4b896b();
        }
    }
    
    if ( level.zm_mode_modifiers.var_883a0291ac45b227 )
    {
        thread function_aac93cc049fd5090();
    }
    
    if ( level.zm_mode_modifiers.var_75911fb102b4859d )
    {
        laststand::function_39844c1e879cc048( 0 );
        self.var_4877be4da79014b0 = 0;
        self.var_63cd4b355dddbeba = 0;
    }
    
    if ( level.zm_mode_modifiers.var_fc36798e78798216 )
    {
        if ( level.zm_mode_modifiers.var_4f8488d097859883 )
        {
            playerhealth::function_fd91e6d94cab77e7( #"regen_delay_relics", level.zm_mode_modifiers.var_4f8488d097859883 );
        }
    }
    
    if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        function_fc10d319e7a6226f();
    }
    
    if ( level.zm_mode_modifiers.var_43c8defc5fca8698 )
    {
        self setclientomnvar( "ui_laststand_visibility", 0 );
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xf6b9f881, Offset: 0x1835
// Size: 0x7b
function private on_zombie_ai_killed( params )
{
    if ( level.zm_mode_modifiers.var_17778bfafdc97691 )
    {
        if ( !self.var_698cf8d8d4a8cbb9 && !self.var_a13bed1ac47e1b2c )
        {
            function_1f2f8b0afe729ae0( params );
        }
        
        if ( self.var_46b1f5d89aec84a9 && level.var_7376e4ac664af8e0 > 0 )
        {
            level.var_7376e4ac664af8e0 = maxint( 0, level.var_7376e4ac664af8e0 - 1 );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x968f2d8, Offset: 0x18b8
// Size: 0xc
function private on_round_start( params )
{
    
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x10407a6d, Offset: 0x18cc
// Size: 0x249
function private on_round_end( params )
{
    if ( level.zm_mode_modifiers.var_8d8c37fcd619848e )
    {
        if ( params.roundnumber >= 1 && !level.var_dc81f03d76612023 )
        {
            level thread function_5e149ac730612b2();
            
            if ( isdefined( level.players[ 0 ] ) )
            {
                level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
            }
            
            foreach ( player in level.players )
            {
                player thread function_edc8d5fff869404f();
            }
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.var_91de35e3f6debd56 ) )
            {
                player.var_91de35e3f6debd56 = 0;
            }
            
            player.var_91de35e3f6debd56 = maxint( player.var_91de35e3f6debd56 - 1, 0 );
        }
    }
    
    if ( level.zm_mode_modifiers.var_d3644cfcd25048c2 )
    {
        if ( params.roundnumber >= 1 && !level.var_dc81f03d76612023 )
        {
            level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
            
            foreach ( player in level.players )
            {
                player thread function_95c515bcfb53a6ee();
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x3d097329, Offset: 0x1b1d
// Size: 0xf8
function private function_fc10d319e7a6226f()
{
    if ( !isdefined( self.var_ff0364688a06b38a ) )
    {
        self.var_ff0364688a06b38a = armor::function_22290101992e4874();
    }
    
    armor::function_b359444c252374fc( 0 );
    
    if ( hasomnvar( "ui_equipment_id_health_numStowed" ) )
    {
        self setclientomnvar( "ui_equipment_id_health_numStowed", 0 );
    }
    
    params = spawnstruct();
    params.player = self;
    
    if ( self.var_a1faa64d8c07872e )
    {
        self.platecarrierlevel = 3;
        zm_armor::function_fdbe2cad6d8bb7e7( 3 );
        armorhealth = zm_armor::get_max_armor_health();
        self.maxarmorhealth = armorhealth;
        self setclientomnvar( "ui_show_armor_global", 1 );
        params.activate = 1;
    }
    else
    {
        self.maxarmorhealth = 0;
        armor::setarmorhealth( 0 );
        self setclientomnvar( "ui_show_armor_global", 0 );
        self setclientomnvar( "ui_armor_current_level", 0 );
        params.activate = 0;
    }
    
    callback::callback( "toggle_squad_armor", params );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xe6b93e72, Offset: 0x1c1d
// Size: 0x29
function private on_wallbuy_armor_purchased( params )
{
    if ( level.zm_mode_modifiers.var_2dc492758425fa76 )
    {
        function_fc10d319e7a6226f();
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x99b71541, Offset: 0x1c4e
// Size: 0x106
function private on_weapon_change( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.zm_mode_modifiers.var_c6d4537d0158feaa && params.weapon && isweapon( params.weapon ) )
    {
        if ( weapon::iswonderweapon( params.weapon ) || params.weapon.basename && level.zm_mode_modifiers.var_c6d4537d0158feaa.var_ccfebad31911f4d5[ params.weapon.basename ] )
        {
            if ( function_58839c55212a1a37( params.weapon ) )
            {
                return;
            }
            
            if ( !function_e1ff41c2463c3e49( params.weapon ) )
            {
                self.var_ba3dc11e269136ed[ self.var_ba3dc11e269136ed.size ] = params.weapon.basename;
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x22b27782, Offset: 0x1d5c
// Size: 0x122
function private function_221696eef23d2d0e( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.zm_mode_modifiers.var_c6d4537d0158feaa && params.newweaponobj && isweapon( params.newweaponobj ) )
    {
        if ( params.item.from_quest || weapon::iswonderweapon( params.newweaponobj ) && !params.item.var_b9ee5f4f2da11ed6 )
        {
            self.var_ba3dc11e269136ed = arraycombineunique( self.var_ba3dc11e269136ed, [ params.newweaponobj.basename ] );
        }
        
        if ( params.item.var_b9ee5f4f2da11ed6 )
        {
            if ( isarray( self.var_b40b3df94af64ed8 ) )
            {
                if ( !function_58839c55212a1a37( params.newweaponobj ) )
                {
                    self.var_b40b3df94af64ed8[ self.var_b40b3df94af64ed8.size ] = params.newweaponobj;
                }
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xd3acc2a1, Offset: 0x1e86
// Size: 0x1bf
function private on_item_dropped( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.zm_mode_modifiers.var_c6d4537d0158feaa && params.weaponobj && isweapon( params.weaponobj ) )
    {
        is_ignored_weapon = function_e1ff41c2463c3e49( params.weaponobj );
        is_from_carousel = function_58839c55212a1a37( params.weaponobj );
        
        if ( is_ignored_weapon && !is_from_carousel )
        {
            params.item.from_quest = 1;
            self.var_ba3dc11e269136ed = arrayremove( self.var_ba3dc11e269136ed, params.weaponobj.basename );
        }
        else
        {
            params.item.var_b9ee5f4f2da11ed6 = 1;
        }
        
        if ( !params.item.from_quest && !weapon::iswonderweapon( params.weaponobj ) || params.item.var_b9ee5f4f2da11ed6 )
        {
            if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07 ) )
            {
                level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07 = [];
            }
            
            level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07[ level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07.size ] = params.item;
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xe5e0eb9e, Offset: 0x204d
// Size: 0x53, Type: bool
function private function_e1ff41c2463c3e49( weaponobj )
{
    if ( !isdefined( self.var_ba3dc11e269136ed ) )
    {
        self.var_ba3dc11e269136ed = [];
    }
    
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    return self.var_ba3dc11e269136ed.size > 0 && arraycontains( self.var_ba3dc11e269136ed, weaponobj.basename );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xe4920efb, Offset: 0x20a9
// Size: 0x4a, Type: bool
function private function_58839c55212a1a37( weaponobj )
{
    if ( !isdefined( self.var_b40b3df94af64ed8 ) )
    {
        self.var_b40b3df94af64ed8 = [];
    }
    
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    return self.var_b40b3df94af64ed8.size > 0 && arraycontains( self.var_b40b3df94af64ed8, weaponobj );
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x282501c, Offset: 0x20fc
// Size: 0xa4
function private function_5e149ac730612b2()
{
    var_b8940482a4a47246 = level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07;
    
    foreach ( item in var_b8940482a4a47246 )
    {
        common_item::function_869d7676e359a627( item );
        waitframe();
    }
    
    var_b8940482a4a47246 = function_5713d46873b29625( var_b8940482a4a47246 );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x86372194, Offset: 0x21a8
// Size: 0x38
function function_92f63fb81d75b37a( params )
{
    level.zm_mode_modifiers.var_a551bdc7e905a4fd = 1;
    level.zm_mode_modifiers.var_c610cba5603efe73 = params;
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0xb29c85f7, Offset: 0x21e8
// Size: 0x228
function private function_2bcdcde1ea4b896b()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 1;
    
    if ( self.var_ec38617d35c96690 )
    {
        self.var_ec38617d35c96690 = undefined;
        gameplay_telemetry::function_3e91d2222fa2419f();
        return;
    }
    
    zm_utility::function_92275a9d3969d91d( 0, 0, 0, 0, 0 );
    var_86314955846eddd7 = level.laststandweapon;
    
    if ( level.zm_mode_modifiers.var_c610cba5603efe73 )
    {
        if ( level.zm_mode_modifiers.var_c610cba5603efe73.var_557b1d29216f692b )
        {
            var_86314955846eddd7 = level.zm_mode_modifiers.var_c610cba5603efe73.var_557b1d29216f692b;
        }
        
        if ( level.zm_mode_modifiers.var_c610cba5603efe73.lethal_override )
        {
            starting_lethal = level.zm_mode_modifiers.var_c610cba5603efe73.lethal_override;
        }
        
        if ( level.zm_mode_modifiers.var_c610cba5603efe73.melee_override )
        {
            starting_melee = level.zm_mode_modifiers.var_c610cba5603efe73.melee_override;
        }
    }
    
    if ( var_86314955846eddd7 && !isweapon( var_86314955846eddd7 ) )
    {
        weapon = weapon_utility::function_d2c8356dc369d9ce( var_86314955846eddd7 );
        
        if ( weapon == nullweapon() || !weapon )
        {
            weapon = weapon_utility::function_d2c8356dc369d9ce( level.laststandweapon );
        }
    }
    
    if ( starting_lethal && !isweapon( starting_lethal ) )
    {
        lethal = makeweapon( starting_lethal );
    }
    
    if ( starting_melee && !isweapon( starting_melee ) )
    {
        melee_weapon = weapon_utility::function_d2c8356dc369d9ce( starting_melee );
    }
    
    if ( weapon )
    {
        self giveweapon( weapon );
    }
    
    if ( melee_weapon )
    {
        self giveweapon( melee_weapon );
        weapon::function_b4c9549dee5d0fc5( melee_weapon );
    }
    
    if ( lethal )
    {
        lethal_ref = equipment_mp::getequipmentreffromweapon( lethal );
        equipment_mp::giveequipment( lethal_ref, "primary" );
        equipment_mp::setequipmentammo( lethal_ref, 2 );
    }
    
    waitframe();
    self switchtoweapon( weapon );
    gameplay_telemetry::function_3e91d2222fa2419f();
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x587f40a8, Offset: 0x2418
// Size: 0x7d
function function_a4090684fa288efb()
{
    params = { #mimic_spawn_chance:10, #mimic_spawn_limit:5, #var_110c03042c33c6bb:%"hash_316026ac255921e9" };
    level.zm_mode_modifiers.var_893592d56948086f = params;
    
    if ( !isdefined( level.var_7376e4ac664af8e0 ) )
    {
        level.var_7376e4ac664af8e0 = 0;
    }
    
    level.var_35b49e9ab3037480 = level.var_57382c7d3b462f0d[ "zombie_mimic_emp" ][ 0 ];
}

// Namespace zombie_mode_modifiers
// Params 4
// Checksum 0x4683fdcf, Offset: 0x249d
// Size: 0xeb
function function_4b709d26a6ee1179( var_110c03042c33c6bb, mimic_spawn_limit, mimic_spawn_chance, mimic_drop_list )
{
    if ( !isdefined( level.zm_mode_modifiers.var_893592d56948086f ) )
    {
        function_a4090684fa288efb();
    }
    
    if ( var_110c03042c33c6bb )
    {
        level.zm_mode_modifiers.var_893592d56948086f.var_110c03042c33c6bb = var_110c03042c33c6bb;
    }
    
    if ( mimic_spawn_limit )
    {
        level.zm_mode_modifiers.var_893592d56948086f.mimic_spawn_limit = mimic_spawn_limit;
    }
    
    if ( mimic_spawn_chance )
    {
        level.zm_mode_modifiers.var_893592d56948086f.mimic_spawn_chance = mimic_spawn_chance;
    }
    
    level.zm_mode_modifiers.var_893592d56948086f.mimic_drop_list = mimic_drop_list;
    level.zm_mode_modifiers.var_17778bfafdc97691 = 1;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x9b2947fe, Offset: 0x2590
// Size: 0x2f6
function function_1f2f8b0afe729ae0( params )
{
    if ( utility::percent_chance( level.zm_mode_modifiers.var_893592d56948086f.mimic_spawn_chance ) && level.var_7376e4ac664af8e0 < level.zm_mode_modifiers.var_893592d56948086f.mimic_spawn_limit )
    {
        var_7d4c78b7d42d3e = level.zm_mode_modifiers.var_893592d56948086f.var_110c03042c33c6bb ?? %"hash_316026ac255921e9";
        
        if ( !isxhashasset( var_7d4c78b7d42d3e ) )
        {
            var_f473f8c1c05c78b3 = hashcat( %"hash_1c2171e1d2452b6c", var_7d4c78b7d42d3e );
        }
        else
        {
            var_f473f8c1c05c78b3 = var_7d4c78b7d42d3e;
        }
        
        origin = getclosestpointonnavmesh( self.origin );
        spawn_struct = { #no_spawn_fx:1, #ignore_spawn_distance:1, #scriptbundlename:var_f473f8c1c05c78b3, #angles:( 0, 0, 0 ), #origin:origin + ( 0, 0, 10 ) };
        spawn_points = [ spawn_struct ];
        
        if ( utility::issharedfuncdefined( #"mimic_prop", #"hash_652981ac6cb6e8c9" ) )
        {
            mimic_prop = utility::callsharedfunc( #"mimic_prop", #"hash_652981ac6cb6e8c9", spawn_points, undefined, undefined, var_f473f8c1c05c78b3, &function_808680a36a729692 );
            mimic_prop thread function_8981342092a9621();
            mimic_prop.var_34cdd5cda21b2ad1.origin = mimic_prop.origin;
            mimic_prop.var_34cdd5cda21b2ad1 utility::scriptable_setparententity( mimic_prop );
            mimic_prop.var_34cdd5cda21b2ad1.mimic_prop = mimic_prop;
            
            if ( !isdefined( level.var_7376e4ac664af8e0 ) )
            {
                level.var_7376e4ac664af8e0 = 0;
            }
            
            level.var_7376e4ac664af8e0++;
            mimic_prop.team = utility::callsharedfunc( #"ai", #"get_aitype_default_spawn_team_SharedFunc" );
            mimic_prop.var_a13bed1ac47e1b2c = 1;
            mimic_prop.no_powerups = 1;
            mimic_prop.var_46b1f5d89aec84a9 = 1;
            mimic_prop.ignore_enemy_count = 1;
            mimic_prop.var_15598d8e493afe88 = 1;
            mimic_prop.var_b8721a7a25f98eaf = gettime();
            
            if ( level.zm_mode_modifiers.var_893592d56948086f.mimic_drop_list )
            {
                mimic_prop.var_a13bed1ac47e1b2c = 0;
                mimic_prop.var_f895c28d17024434 = 1;
                mimic_prop.var_2dfd8b4c56744f49 = 1;
                mimic_prop.var_50c96a5c56dab386 = &function_c59744b6b41b8123;
            }
            
            mimic_prop moveto( mimic_prop.origin + ( 0, 0, 1 ), 0.5 );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x21d781f0, Offset: 0x288e
// Size: 0x63
function private function_8981342092a9621()
{
    self endon( #"death" );
    wait 20;
    
    if ( utility::issharedfuncdefined( #"mimic_prop", #"hash_fcfe4302fe1691b6" ) )
    {
        level.var_7376e4ac664af8e0 = maxint( 0, level.var_7376e4ac664af8e0 - 1 );
        waitframe();
        utility::callsharedfunc( #"mimic_prop", #"hash_fcfe4302fe1691b6", self, 1 );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x8fc340e2, Offset: 0x28f9
// Size: 0x62
function function_808680a36a729692()
{
    if ( utility::issharedfuncdefined( #"mimic_prop", #"hash_992dc6999e4dab86" ) )
    {
        player = utility::callsharedfunc( #"mimic_prop", #"hash_992dc6999e4dab86", 65 );
        
        if ( isdefined( player ) && gettime() >= self.var_b8721a7a25f98eaf + 3000 )
        {
            return player;
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x3f362e3d, Offset: 0x2963
// Size: 0x9e
function function_caa75d1d05e4043b( params )
{
    if ( params.loot.mimic_prop )
    {
        if ( utility::issharedfuncdefined( #"mimic_prop", #"hash_fcfe4302fe1691b6" ) )
        {
            level.var_7376e4ac664af8e0 = maxint( 0, level.var_7376e4ac664af8e0 - 1 );
            params.loot.mimic_prop utility::callsharedfunc( #"mimic_prop", #"hash_fcfe4302fe1691b6", params.loot.mimic_prop, 1 );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xa43113f6, Offset: 0x2a09
// Size: 0x84
function function_c59744b6b41b8123()
{
    zombie_droplist = level.zm_mode_modifiers.var_893592d56948086f.mimic_drop_list;
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x81f9a5c6, Offset: 0x2a96
// Size: 0x9f
function function_add23b128d832ec4( var_c37ed24cab7bdaad = 0.75 )
{
    params = { #var_c37ed24cab7bdaad:var_c37ed24cab7bdaad };
    level.zm_mode_modifiers.var_12d1573e5e613c31 = 1;
    level.zm_mode_modifiers.var_dc4af56c0e9d7d4f = params;
    level.var_545d992d40a9d7de = &function_6d48483f3385646;
    level callback::add( #"hash_da9c9f574ec3737b", &function_5e3310ba30fd91b3 );
    level utility::registersharedfunc( #"hash_d042b9b95fefa1e", #"hash_d042b9b95fefa1e", &function_a2e48d68cd5193c6 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xf48a9940, Offset: 0x2b3d
// Size: 0x5
function function_a2e48d68cd5193c6()
{
    wait 5;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xbd30e0ab, Offset: 0x2b4b
// Size: 0x72
function function_6d48483f3385646()
{
    var_92262c681fbd62ee = [[ level.var_6781718da4f78d1c.var_7ccf298a00a225de ]]();
    
    if ( level.var_832a827c32d0f42f )
    {
        var_92262c681fbd62ee = [[ level.var_832a827c32d0f42f ]]();
    }
    
    new_round_delay = int( abs( var_92262c681fbd62ee - var_92262c681fbd62ee * level.zm_mode_modifiers.var_dc4af56c0e9d7d4f.var_c37ed24cab7bdaad ) );
    return new_round_delay;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xa631954c, Offset: 0x2bc6
// Size: 0x3c
function function_42d398a91a18e1d4()
{
    level callback::remove( #"hash_da9c9f574ec3737b", &function_5e3310ba30fd91b3 );
    level utility::clearsharedfunc( #"hash_d042b9b95fefa1e", #"hash_d042b9b95fefa1e" );
    level.var_545d992d40a9d7de = undefined;
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xf4229766, Offset: 0x2c0a
// Size: 0x2e
function private function_5e3310ba30fd91b3( params )
{
    level.var_832a827c32d0f42f = params.new_override;
    level.var_545d992d40a9d7de = &function_6d48483f3385646;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x9e3dc1d7, Offset: 0x2c40
// Size: 0x11d
function function_94e176e1a5bdaf75()
{
    level utility::flag_wait_or_timeout( "setup_magicbox_weapons", 5 );
    level.zm_mode_modifiers.var_d3644cfcd25048c2 = 1;
    level.zm_mode_modifiers.var_346079b6c9b0a9c6 = {};
    level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_a48db1565ccbb269 = [];
    level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_8e9ef5de5c0cc446 = [];
    level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_6810b19957c31285 = %"hash_45fd0faf82352a4e";
    level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_f49ccdc6c659ef82 = %"hash_7428dcc43764ca03";
    level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_783b84ee4ce237e3 = [ "equip_europa_remote_control", "equip_decoy_trinket_sat_zm", "equip_attractor", "equip_grappling_hook", "equip_grappling_hook_dreadspinner_ee_sat", "equip_grappling_hook_upgraded_sat" ];
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x75f84266, Offset: 0x2d65
// Size: 0x17
function function_2127454f44effa85()
{
    level.zm_mode_modifiers.var_d3644cfcd25048c2 = 0;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x35692197, Offset: 0x2d84
// Size: 0x264
function function_95c515bcfb53a6ee()
{
    self notify( #"hash_eb2b1e2223cc70b0" );
    self endon( #"hash_eb2b1e2223cc70b0" );
    self.crafting_table_disabled = 1;
    self.interactions_disabled = 1;
    val::set( "modifier_equipment_carousel", "disallow_loot_but_auto_loot", 1 );
    lethal_item_name = function_c11af7a197679429( level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_6810b19957c31285, 1 );
    lethal_item = getscriptbundle( lethal_item_name[ 0 ] );
    var_7cd95030bb831871 = get_ammo_count( "primary" );
    var_cc73f481366180b4 = min( var_7cd95030bb831871, lethal_item.maxcount );
    tactical_item_name = function_c11af7a197679429( level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_f49ccdc6c659ef82, 1 );
    tactical_item = getscriptbundle( tactical_item_name[ 0 ] );
    var_19eb2cbc84a121e9 = get_ammo_count( "secondary" );
    var_a0b28abb89a04cac = min( var_19eb2cbc84a121e9, tactical_item.maxcount );
    primary_equipment = equipment_mp::getcurrentequipment( "primary" );
    secondary_equipment = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( isdefined( primary_equipment ) && isdefined( level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_783b84ee4ce237e3 ) && !arraycontains( level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_783b84ee4ce237e3, primary_equipment ) )
    {
        equipment_mp::giveequipment( lethal_item.ref, "primary" );
        equipment_mp::setequipmentammo( lethal_item.ref, var_cc73f481366180b4 );
    }
    
    if ( isdefined( secondary_equipment ) && isdefined( level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_783b84ee4ce237e3 ) && !arraycontains( level.zm_mode_modifiers.var_346079b6c9b0a9c6.var_783b84ee4ce237e3, secondary_equipment ) )
    {
        equipment_mp::giveequipment( tactical_item.ref, "secondary" );
        equipment_mp::setequipmentammo( tactical_item.ref, var_a0b28abb89a04cac );
    }
    
    self.crafting_table_disabled = 0;
    self.interactions_disabled = 0;
    val::reset( "modifier_equipment_carousel", "disallow_loot_but_auto_loot" );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x555a0475, Offset: 0x2ff0
// Size: 0x3c
function get_ammo_count( slot )
{
    currentequipment = equipment_mp::getcurrentequipment( slot );
    currentammo = 0;
    
    if ( currentequipment )
    {
        currentammo = equipment_mp::getequipmentammo( currentequipment );
    }
    
    return currentammo;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x45f7b1, Offset: 0x3035
// Size: 0x368
function set_weapon_change_carousel()
{
    level utility::flag_wait_or_timeout( "setup_magicbox_weapons", 5 );
    level.zm_mode_modifiers.var_8d8c37fcd619848e = 1;
    
    if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa ) )
    {
        level.zm_mode_modifiers.var_c6d4537d0158feaa = {};
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07 ) )
    {
        level.zm_mode_modifiers.var_c6d4537d0158feaa.var_541fb04ce7a8ee07 = [];
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_98979194809943ec ) )
    {
        level.zm_mode_modifiers.var_c6d4537d0158feaa.var_98979194809943ec = %"hash_20df5ee1afe0bd9";
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_2f457b2522263641 ) )
    {
        level.zm_mode_modifiers.var_c6d4537d0158feaa.var_2f457b2522263641 = level.var_8b6bf63f61fe01f9;
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_fb8319975521166e ) )
    {
        level.zm_mode_modifiers.var_c6d4537d0158feaa.var_fb8319975521166e = [];
    }
    
    level.zm_mode_modifiers.var_c6d4537d0158feaa.var_fb8319975521166e[ "sat_ww_locust_zm" ] = 1;
    
    if ( !isdefined( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_ccfebad31911f4d5 ) )
    {
        level.zm_mode_modifiers.var_c6d4537d0158feaa.var_ccfebad31911f4d5 = [];
    }
    
    level.zm_mode_modifiers.var_c6d4537d0158feaa.var_ccfebad31911f4d5[ "sat_me_elnath_mp" ] = 1;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.var_ba3dc11e269136ed ) )
        {
            player.var_ba3dc11e269136ed = [];
        }
        
        if ( !isdefined( player.var_b40b3df94af64ed8 ) )
        {
            player.var_b40b3df94af64ed8 = [];
        }
        
        primary_weapons = player getweaponslist( "primary" );
        
        foreach ( weapon in primary_weapons )
        {
            if ( weapon::iswonderweapon( weapon ) && weapon.basename )
            {
                player.var_ba3dc11e269136ed = arraycombineunique( player.var_ba3dc11e269136ed, [ weapon.basename ] );
            }
        }
    }
    
    if ( !level.var_e003389e431ee9d5.size > 0 )
    {
        level function_a6388bebb314e446();
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x2068da8e, Offset: 0x33a5
// Size: 0x17
function disable_weapon_change_carousel()
{
    level.zm_mode_modifiers.var_8d8c37fcd619848e = 0;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x589b678a, Offset: 0x33c4
// Size: 0xe7a
function function_edc8d5fff869404f()
{
    self notify( #"hash_8a65423929e792a4" );
    self endon( #"hash_8a65423929e792a4" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    function_47f8bfe8d79821ab();
    self.var_432159241a2f9367 = 1;
    self.var_e830497a1d286f74 = 1;
    self.interactions_disabled = 1;
    self.var_d6157e607ef0ac64 = 1;
    val::set( "modifier_weapon_carousel", "disallow_loot_but_auto_loot", 1 );
    val::set( "modifier_weapon_carousel", "weapon_pickup", 0 );
    val::set( "modifier_weapon_carousel", "allow_scripted_bgb_use", 0 );
    
    if ( !callback::exists( "on_powerup_pickup", &function_250cba32db828bbe ) )
    {
        callback::add( "on_powerup_pickup", &function_250cba32db828bbe );
    }
    
    wait 1;
    var_41965f6cdd4230ba = self function_a4f068798d87b7ea( 0 );
    var_906ce4e7b26a1606 = self function_a4f068798d87b7ea( 1 );
    
    if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" ) && isdefined( self.var_3bf72dcd2775aa78 ) && self hasweapon( self.var_3bf72dcd2775aa78 ) )
    {
        w_z_mod = self.var_3bf72dcd2775aa78;
        var_6943c5d3a73c3e02 = -1;
    }
    else
    {
        w_z_mod = undefined;
        var_6943c5d3a73c3e02 = -1;
    }
    
    var_37cf32b7c306dd96 = self getweaponmeleeslot() ?? nullweapon();
    var_dd24a0ea22fd7a01 = item_weapon::function_fb81bd2fe070faa6( var_37cf32b7c306dd96 ) ?? 0;
    var_5f9bad607791330e = self hasweapon( level.defaultfist );
    switch_index = 0;
    var_9932ed269bd0cdfe = [];
    var_718ffcf2649db354 = [];
    starting_weapons = [ var_41965f6cdd4230ba, var_906ce4e7b26a1606, var_37cf32b7c306dd96, w_z_mod ];
    rarity_values = [];
    pap_values = [];
    ammomod_values = [];
    var_18ed785f59c42f10 = [];
    var_d7b9dca56d76e590 = [];
    
    for ( key = 0; key < starting_weapons.size ; key++ )
    {
        if ( !isplayer( self ) || !isalive( self ) )
        {
            return;
        }
        
        var_75eb13a26f593d58 = starting_weapons[ key ];
        
        if ( var_75eb13a26f593d58 == nullweapon() )
        {
            continue;
        }
        
        next_weapon_baseweapon = undefined;
        var_26b8fb5fe4e9b4 = 0;
        roll_attempts = 0;
        
        if ( self getcurrentweapon() == var_75eb13a26f593d58 )
        {
            switch_index = key;
        }
        
        do
        {
            var_7e4a8fa5e67bd230 = [];
            var_26b8fb5fe4e9b4 = 0;
            roll_attempts++;
            
            if ( !var_75eb13a26f593d58.ismelee )
            {
                var_718ffcf2649db354[ key ] = utility::array_random( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_e003389e431ee9d5 );
                var_7e4a8fa5e67bd230 = level.zm_mode_modifiers.var_c6d4537d0158feaa.var_e003389e431ee9d5;
                next_weapon_name = getscriptbundlefieldvalue( var_718ffcf2649db354[ key ], #"baseweapon" );
                next_weapon_baseweapon = makeweapon( next_weapon_name );
                is_ignored_weapon = function_e1ff41c2463c3e49( var_75eb13a26f593d58 );
                is_from_carousel = function_58839c55212a1a37( var_75eb13a26f593d58 );
                
                if ( is_ignored_weapon && !is_from_carousel )
                {
                    var_9932ed269bd0cdfe = arraycombineunique( var_9932ed269bd0cdfe, [ var_75eb13a26f593d58.basename ] );
                    var_718ffcf2649db354[ key ] = undefined;
                    var_26b8fb5fe4e9b4 = 0;
                    continue;
                }
                
                if ( var_75eb13a26f593d58.basename == next_weapon_name && var_7e4a8fa5e67bd230.size > 1 )
                {
                    var_26b8fb5fe4e9b4 = 1;
                }
                
                for ( previous_key = key - 1; previous_key >= 0 ; previous_key-- )
                {
                    if ( var_718ffcf2649db354[ previous_key ].basename == next_weapon_name )
                    {
                        var_26b8fb5fe4e9b4 = 1;
                    }
                }
                
                var_33a2fed5694fb948 = 0;
                
                foreach ( var_3248d20086ef13a0 in self getweaponslist( "primary" ) )
                {
                    var_4d2571bbc7397806 = var_3248d20086ef13a0 getbaseweapon();
                    
                    if ( issameweapon( var_4d2571bbc7397806, next_weapon_baseweapon ) )
                    {
                        var_33a2fed5694fb948 = 1;
                        break;
                    }
                }
                
                if ( weapon::iswonderweapon( next_weapon_baseweapon ) && !var_26b8fb5fe4e9b4 && !var_33a2fed5694fb948 )
                {
                    if ( utility::percent_chance( 5 ) && self.var_91de35e3f6debd56 == 0 )
                    {
                        self.var_91de35e3f6debd56 = 5;
                    }
                    else
                    {
                        var_26b8fb5fe4e9b4 = 1;
                    }
                }
                
                if ( var_33a2fed5694fb948 && var_7e4a8fa5e67bd230.size > 1 )
                {
                    var_26b8fb5fe4e9b4 = 1;
                }
                
                if ( roll_attempts > 15 )
                {
                    var_26b8fb5fe4e9b4 = 0;
                }
                
                continue;
            }
            
            var_718ffcf2649db354[ key ] = utility::array_random( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_c5e9cf6ced3139c6 );
            var_7e4a8fa5e67bd230 = level.zm_mode_modifiers.var_c6d4537d0158feaa.var_c5e9cf6ced3139c6;
            next_weapon_name = getscriptbundlefieldvalue( var_718ffcf2649db354[ key ], #"baseweapon" );
            next_weapon_baseweapon = makeweapon( next_weapon_name );
            is_ignored_weapon = function_e1ff41c2463c3e49( var_75eb13a26f593d58 );
            is_from_carousel = function_58839c55212a1a37( var_75eb13a26f593d58 );
            
            if ( is_ignored_weapon && !is_from_carousel )
            {
                var_9932ed269bd0cdfe = arraycombineunique( var_9932ed269bd0cdfe, [ var_75eb13a26f593d58.basename ] );
                var_718ffcf2649db354[ key ] = undefined;
                var_26b8fb5fe4e9b4 = 0;
                continue;
            }
            
            if ( var_75eb13a26f593d58.basename == next_weapon_baseweapon.basename && var_7e4a8fa5e67bd230.size > 1 )
            {
                var_26b8fb5fe4e9b4 = 1;
            }
            
            if ( weapon::iswonderweapon( next_weapon_baseweapon ) && !var_26b8fb5fe4e9b4 )
            {
                if ( utility::percent_chance( 5 ) && self.var_91de35e3f6debd56 == 0 )
                {
                    self.var_91de35e3f6debd56 = 5;
                }
                else
                {
                    var_26b8fb5fe4e9b4 = 1;
                }
            }
            
            if ( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_fb8319975521166e[ next_weapon_baseweapon.basename ] && var_7e4a8fa5e67bd230.size > 1 )
            {
                var_26b8fb5fe4e9b4 = 1;
            }
            
            if ( roll_attempts > 15 )
            {
                var_26b8fb5fe4e9b4 = 0;
            }
        }
        while ( var_26b8fb5fe4e9b4 );
        
        if ( !isplayer( self ) || !isalive( self ) )
        {
            return;
        }
        
        if ( !var_718ffcf2649db354[ key ] )
        {
            continue;
        }
        
        pap_lvl = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", var_75eb13a26f593d58 );
        var_4c506782108851c7 = utility::callsharedfunc( #"zombie", #"get_ammo_mod_name", var_75eb13a26f593d58 );
        rarity = minint( item_weapon::function_fb81bd2fe070faa6( var_75eb13a26f593d58 ), 5 );
        
        if ( weapon::iswonderweapon( next_weapon_baseweapon ) )
        {
            if ( !weapon::iswonderweapon( var_75eb13a26f593d58 ) )
            {
                self.var_5034d3c0bfbbd9cb[ key ] = rarity;
                self.var_9e8e0b0593c46936[ key ] = var_4c506782108851c7;
            }
            
            rarity = 6;
            var_4c506782108851c7 = undefined;
        }
        else if ( weapon::iswonderweapon( var_75eb13a26f593d58 ) && isdefined( self.var_5034d3c0bfbbd9cb[ key ] ) )
        {
            rarity = self.var_5034d3c0bfbbd9cb[ key ];
            var_4c506782108851c7 = self.var_9e8e0b0593c46936[ key ];
            self.var_5034d3c0bfbbd9cb[ key ] = undefined;
            self.var_9e8e0b0593c46936[ key ] = undefined;
        }
        else if ( weapon::iswonderweapon( var_75eb13a26f593d58 ) )
        {
            rarity = 4;
        }
        
        rarity_values[ key ] = rarity;
        pap_values[ key ] = pap_lvl;
        ammomod_values[ key ] = var_4c506782108851c7;
        var_18ed785f59c42f10[ key ] = self getweaponammoclip( var_75eb13a26f593d58 ) / maxint( weaponclipsize( var_75eb13a26f593d58 ), 1 );
        stock_size = utility::get_max_stock_ammo( var_75eb13a26f593d58 );
        
        if ( stock_size > 0 || var_75eb13a26f593d58.ismelee )
        {
            var_d7b9dca56d76e590[ key ] = self getweaponammostock( var_75eb13a26f593d58 ) / maxint( stock_size, 1 );
        }
        else if ( self.var_8752d0465bd10d1d )
        {
            var_d7b9dca56d76e590[ key ] = self.var_8752d0465bd10d1d[ key ] ?? 0;
            self.var_8752d0465bd10d1d[ key ] = undefined;
        }
        else
        {
            var_d7b9dca56d76e590[ key ] = self getweaponammostock( var_75eb13a26f593d58 ) / maxint( stock_size, 1 );
        }
        
        if ( utility::get_max_stock_ammo( var_75eb13a26f593d58 ) < 50 )
        {
            var_d7b9dca56d76e590[ key ] *= 1.5;
        }
        
        if ( weaponclipsize( var_75eb13a26f593d58 ) < 20 )
        {
            var_18ed785f59c42f10[ key ] *= 1.5;
        }
        
        if ( weapon::iswonderweapon( next_weapon_baseweapon ) )
        {
            var_d7b9dca56d76e590[ key ] *= 2.5;
            var_18ed785f59c42f10[ key ] *= 2.5;
        }
        
        rarity_str = function_f22b4a773d5b8f32( rarity );
        
        if ( rarity_str )
        {
            var_11de796f43c1273c = hashcat( var_718ffcf2649db354[ key ], "_", rarity_str );
            
            if ( getscriptbundlefieldvalue( var_11de796f43c1273c, #"baseweapon" ) )
            {
                var_718ffcf2649db354[ key ] = var_11de796f43c1273c;
            }
        }
        
        var_718ffcf2649db354[ key ] = getscriptbundle( var_718ffcf2649db354[ key ] );
        
        if ( isplayer( self ) )
        {
            favoriteweapon = weaponmetadata::function_c68204eff69ed046( next_weapon_baseweapon.basename );
        }
        
        if ( isdefined( favoriteweapon ) )
        {
            var_718ffcf2649db354[ key ] = favoriteweapon;
        }
        else
        {
            var_6828becb300b1c44 = item_weapon::function_e3101668a21a4237( var_718ffcf2649db354[ key ] );
            var_718ffcf2649db354[ key ] = weapon::buildweapon( next_weapon_baseweapon.basename, var_6828becb300b1c44.attachments );
        }
        
        if ( var_75eb13a26f593d58 == w_z_mod )
        {
            var_6943c5d3a73c3e02 = key;
        }
        
        var_c1642703ffb309f3 = 0.5;
        self loadweaponsforplayer( [ var_718ffcf2649db354[ key ] ], 1 );
        wait var_c1642703ffb309f3;
    }
    
    if ( isplayer( self ) )
    {
        if ( self.var_b40b3df94af64ed8.size > 0 )
        {
            self.var_b40b3df94af64ed8 = [];
        }
        
        function_47f8bfe8d79821ab();
        zm_utility::function_92275a9d3969d91d( 0, 0, 0, 1, 1, 0, 0, var_9932ed269bd0cdfe );
        primary_weapons_left = self getweaponslistprimaries();
        
        if ( primary_weapons_left.size > 0 )
        {
            foreach ( left_weapon in primary_weapons_left )
            {
                if ( !arraycontains( var_9932ed269bd0cdfe, left_weapon.basename ) )
                {
                    self takeweapon( left_weapon );
                }
            }
        }
    }
    else
    {
        return;
    }
    
    for ( key = 0; key < starting_weapons.size ; key++ )
    {
        if ( !isplayer( self ) || !isalive( self ) )
        {
            return;
        }
        
        weapon = starting_weapons[ key ];
        
        if ( weapon == nullweapon() )
        {
            continue;
        }
        
        if ( !var_718ffcf2649db354[ key ] )
        {
            continue;
        }
        
        if ( key == var_6943c5d3a73c3e02 && !utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" ) )
        {
            continue;
        }
        
        var_5d8cc93233d1451a = var_718ffcf2649db354[ key ];
        var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
        self giveweapon( var_5d8cc93233d1451a, undefined, 0, -1, 1 );
        self assignweaponprimaryslot( var_5d8cc93233d1451a );
        
        if ( var_718ffcf2649db354[ key ].ismelee )
        {
            weapon::function_b4c9549dee5d0fc5( var_5d8cc93233d1451a );
        }
        
        if ( key == var_6943c5d3a73c3e02 )
        {
            self.var_3bf72dcd2775aa78 = var_5d8cc93233d1451a;
            self.var_1dbdf5cd10dc5432 = item_weapon::function_1464d1c9177c4934( var_5d8cc93233d1451a );
            
            if ( self function_5c766d1d0140b86( "ui_gameplay_telemetry_mule_weap_lootid" ) )
            {
                lootid = weapon::getweaponlootid( self.var_3bf72dcd2775aa78 );
                self setclientomnvar( "ui_gameplay_telemetry_mule_weap_lootid", lootid );
            }
        }
        
        if ( rarity_values[ key ] > 0 )
        {
            item_weapon::function_40e1cbd0e1f47d1a( var_5d8cc93233d1451a, rarity_values[ key ] );
        }
        
        if ( pap_values[ key ] > 0 )
        {
            var_5d8cc93233d1451a = utility::callsharedfunc( #"pack_a_punch", #"pap_weapon", var_5d8cc93233d1451a, pap_values[ key ] - 1, undefined, 1, undefined, 0, 1 );
        }
        
        if ( ammomod_values[ key ] )
        {
            utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", var_5d8cc93233d1451a, ammomod_values[ key ], 1 );
        }
        
        if ( utility::get_max_stock_ammo( var_5d8cc93233d1451a ) <= 0 && !var_5d8cc93233d1451a.ismelee )
        {
            if ( !isdefined( self.var_8752d0465bd10d1d ) )
            {
                self.var_8752d0465bd10d1d = [];
            }
            
            self.var_8752d0465bd10d1d[ key ] = var_d7b9dca56d76e590[ key ];
        }
        
        if ( self.var_c497325736d50160 )
        {
            var_18ed785f59c42f10[ key ] = 1;
        }
        
        var_8c89128940c238d0 = int( var_18ed785f59c42f10[ key ] * weaponclipsize( var_5d8cc93233d1451a ) );
        self setweaponammoclip( var_5d8cc93233d1451a, var_8c89128940c238d0 );
        
        if ( self.var_c497325736d50160 )
        {
            var_d7b9dca56d76e590[ key ] = 1;
        }
        
        var_bd48e8dd61a3c03c = int( var_d7b9dca56d76e590[ key ] * utility::get_max_stock_ammo( var_5d8cc93233d1451a ) );
        self setweaponammostock( var_5d8cc93233d1451a, var_bd48e8dd61a3c03c, var_482e9999b75ed3d8 );
        var_718ffcf2649db354[ key ] = var_5d8cc93233d1451a;
        
        if ( !isdefined( self.var_b40b3df94af64ed8 ) )
        {
            self.var_b40b3df94af64ed8 = [];
        }
        
        self.var_b40b3df94af64ed8[ self.var_b40b3df94af64ed8.size ] = var_5d8cc93233d1451a;
    }
    
    function_47f8bfe8d79821ab();
    waitframe();
    b_ignore_switch = var_9932ed269bd0cdfe.size > 0 && arraycontains( var_9932ed269bd0cdfe, getweaponbasename( self getcurrentweapon() ) );
    
    if ( self getcurrentweapon() && !b_ignore_switch )
    {
        if ( isweapon( var_718ffcf2649db354[ switch_index ] ) && !isnullweapon( var_718ffcf2649db354[ switch_index ] ) && self hasweapon( var_718ffcf2649db354[ switch_index ] ) )
        {
            self switchtoweaponimmediate( var_718ffcf2649db354[ switch_index ] );
        }
        else
        {
            inventory_utility::forcevalidweapon();
        }
    }
    
    waittillframeend();
    
    foreach ( var_98836911dfa2335e in self getweaponslist( "primary" ) )
    {
        if ( weapon::iswonderweapon( var_98836911dfa2335e ) && item_weapon::function_fb81bd2fe070faa6( var_98836911dfa2335e ) != 6 )
        {
            item_weapon::function_40e1cbd0e1f47d1a( var_98836911dfa2335e, 6 );
        }
    }
    
    utility::callsharedfunc( #"pack_a_punch", #"hash_7f95018b0780f0f1" );
    utility::callsharedfunc( #"ammo_mod", #"hash_88a73fb490c01c96" );
    utility::callsharedfunc( #"zombie", #"hash_d7c108d9a9770758" );
    wait 1;
    self.var_432159241a2f9367 = 0;
    self.var_e830497a1d286f74 = 0;
    self.interactions_disabled = 0;
    self.var_d6157e607ef0ac64 = undefined;
    self.var_c497325736d50160 = undefined;
    self notify( #"weapon_carousel_finished" );
    
    if ( callback::exists( "on_powerup_pickup", &function_250cba32db828bbe ) )
    {
        callback::remove( "on_powerup_pickup", &function_250cba32db828bbe );
    }
    
    val::reset( "modifier_weapon_carousel", "disallow_loot_but_auto_loot" );
    val::reset( "modifier_weapon_carousel", "weapon_pickup" );
    val::reset( "modifier_weapon_carousel", "allow_scripted_bgb_use" );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xe07a5031, Offset: 0x4246
// Size: 0x42
function private function_250cba32db828bbe( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( params.str_powerup == "full_ammo" && self.var_d6157e607ef0ac64 )
    {
        self.var_c497325736d50160 = 1;
    }
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0xb26b46a1, Offset: 0x4290
// Size: 0x98
function private function_47f8bfe8d79821ab()
{
    vehicle = player_utility::getvehicle();
    isdriving = 0;
    
    while ( !val::get( "weapon_switch" ) || !val::get( "fire" ) || !val::get( "offhand_primary_weapons" ) || isdriving || self.inlaststand )
    {
        isdriving = isdefined( vehicle ) && ( vehicle.occupants[ "driver" ] == self || vehicle.occupants[ "gunner" ] == self );
        waitframe();
    }
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x51dd67ad, Offset: 0x4330
// Size: 0x3b2
function private function_a6388bebb314e446()
{
    level endon( #"game_ended" );
    weapon_list_bundle = getscriptbundle( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_98979194809943ec );
    ww_list_bundle = getscriptbundle( level.zm_mode_modifiers.var_c6d4537d0158feaa.var_2f457b2522263641 );
    level.zm_mode_modifiers.var_c6d4537d0158feaa.var_e003389e431ee9d5 = [];
    level.zm_mode_modifiers.var_c6d4537d0158feaa.var_c5e9cf6ced3139c6 = [];
    weapon_item_list = [];
    
    foreach ( list_entry in weapon_list_bundle.itemlistentries )
    {
        if ( !isdefined( list_entry.weight ) || list_entry.weight == 0 )
        {
            continue;
        }
        
        weapon_list_bundle = getscriptbundle( hashcat( %"itemspawnlist:", list_entry.itemspawnlist ) );
        
        foreach ( var_827e6c420604dd2 in weapon_list_bundle.itementries )
        {
            if ( !isdefined( var_827e6c420604dd2.weight ) || var_827e6c420604dd2.weight == 0 )
            {
                continue;
            }
            
            weapon_item_list[ weapon_item_list.size ] = var_827e6c420604dd2.itemspawnentry;
        }
    }
    
    foreach ( var_827e6c420604dd2 in ww_list_bundle.itementries )
    {
        weapon_item_list[ weapon_item_list.size ] = var_827e6c420604dd2.itemspawnentry;
    }
    
    foreach ( entry in weapon_item_list )
    {
        entry_baseweapon = getscriptbundlefieldvalue( entry, #"baseweapon" );
        
        if ( !isdefined( entry_baseweapon ) )
        {
            continue;
        }
        
        weaponobj = makeweapon( entry_baseweapon );
        
        if ( weaponobj.ismelee )
        {
            level.zm_mode_modifiers.var_c6d4537d0158feaa.var_c5e9cf6ced3139c6[ level.zm_mode_modifiers.var_c6d4537d0158feaa.var_c5e9cf6ced3139c6.size ] = entry;
            continue;
        }
        
        if ( !isnullweapon( weaponobj ) )
        {
            level.zm_mode_modifiers.var_c6d4537d0158feaa.var_e003389e431ee9d5[ level.zm_mode_modifiers.var_c6d4537d0158feaa.var_e003389e431ee9d5.size ] = entry;
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x11fe56d1, Offset: 0x46ea
// Size: 0x7d
function private function_f22b4a773d5b8f32( rarity )
{
    switch ( rarity )
    {
        case 1:
            return "green";
        case 2:
            return "blue";
        case 3:
            return "purple";
        case 4:
            return "orange";
        case 5:
            return "ultra";
        default:
            return;
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xe467efc1, Offset: 0x476f
// Size: 0x21
function private function_8d9823d8f2627371( subclass_asset )
{
    if ( subclass_asset )
    {
        return getscriptbundlefieldvalue( subclass_asset, #"name" );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xdecc4c9f, Offset: 0x4798
// Size: 0x1d
function set_elemental_base_zombies( list )
{
    callback::add( "on_round_start", &function_d94061eb20b49d7c );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xcd60567c, Offset: 0x47bd
// Size: 0x13
function disable_elemental_base_zombies()
{
    callback::remove( "on_round_start", &function_d94061eb20b49d7c );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xa36c0ad4, Offset: 0x47d8
// Size: 0xa1
function private function_d94061eb20b49d7c( params )
{
    list = level.zm_relic_modifiers[ #"elemental_base_zombies" ].var_8e9fbd5f12c83b6a;
    count = list.size + 1;
    index = randomint( count );
    subclass_asset = list[ index ].aisubclass;
    subclass_name = function_8d9823d8f2627371( subclass_asset ) ?? "zombie_base";
    zm_round_spawning::function_5dbb675c70d96223( "zombie_base" );
    zm_round_spawning::function_6d2ff2952b39d0d7( "zombie_base", subclass_name );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x82fd31de, Offset: 0x4881
// Size: 0x26f
function function_e83cb78caa4379c8()
{
    info = function_52239da21c0c9e4c();
    
    if ( info )
    {
        foreach ( fromelite in info.var_e9e7122c00034883 )
        {
            var_3c5af7ddf8aba056 = function_8d9823d8f2627371( fromelite.aisubclass );
            
            foreach ( toelite in info.replacementelites )
            {
                var_99792c23a46475b5 = function_8d9823d8f2627371( toelite.aisubclass );
                
                if ( var_3c5af7ddf8aba056 && var_99792c23a46475b5 )
                {
                    zm_round_spawning::function_6d2ff2952b39d0d7( var_3c5af7ddf8aba056, var_99792c23a46475b5 );
                }
            }
        }
        
        foreach ( fromspecial in info.var_50e803a05d6df7af )
        {
            var_aa3cec46582c6436 = function_8d9823d8f2627371( fromspecial.aisubclass );
            
            foreach ( tospecial in info.var_5288ae99ec6ceda2 )
            {
                var_3832b4da7d7af3f1 = function_8d9823d8f2627371( tospecial.aisubclass );
                
                if ( var_aa3cec46582c6436 && var_3832b4da7d7af3f1 )
                {
                    zm_round_spawning::function_6d2ff2952b39d0d7( var_aa3cec46582c6436, var_3832b4da7d7af3f1 );
                }
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x731958f2, Offset: 0x4af8
// Size: 0x141
function function_2758f18ecfacc3b8()
{
    info = function_52239da21c0c9e4c();
    
    if ( info )
    {
        foreach ( fromelite in info.var_e9e7122c00034883 )
        {
            var_3c5af7ddf8aba056 = function_8d9823d8f2627371( fromelite.aisubclass );
            zm_round_spawning::function_5dbb675c70d96223( var_3c5af7ddf8aba056 );
        }
        
        foreach ( fromspecial in info.var_50e803a05d6df7af )
        {
            var_aa3cec46582c6436 = function_8d9823d8f2627371( fromspecial.aisubclass );
            zm_round_spawning::function_5dbb675c70d96223( var_aa3cec46582c6436 );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x2c2824d4, Offset: 0x4c41
// Size: 0x11f
function private function_52239da21c0c9e4c()
{
    list = level.zm_relic_modifiers[ #"hash_5bb600c492d2656e" ].var_a0c42422fce9a3a7;
    mapname = getxhash( level.mapname );
    var_5e7d392e2987ea0c = level.gametype == "zm_rb_r_mod_survival";
    poiname = level.poiname ? getxhash( level.poiname ) : undefined;
    
    foreach ( info in list )
    {
        if ( info.mapname == mapname )
        {
            if ( info.var_5e7d392e2987ea0c == var_5e7d392e2987ea0c )
            {
                if ( info.survivallocation === poiname )
                {
                    return info;
                }
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x3e3d6a98, Offset: 0x4d69
// Size: 0x59
function function_976a35587fc99fb5( var_fe525c96105d375f = 4 )
{
    params = { #var_fe525c96105d375f:var_fe525c96105d375f };
    level.zm_mode_modifiers.var_89fa68db4cdb1044 = 1;
    level.zm_mode_modifiers.var_ea2b964809851284 = params;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x3e38f955, Offset: 0x4dca
// Size: 0x17
function function_f603703b26e4b9e5()
{
    level.zm_mode_modifiers.var_89fa68db4cdb1044 = 0;
}

// Namespace zombie_mode_modifiers
// Params 4
// Checksum 0x55ca4dee, Offset: 0x4de9
// Size: 0x11b
function function_de2be231627b8af( perk, bought, is_item_perk, is_special_returned )
{
    if ( !isdefined( self.var_9413068bac411438 ) )
    {
        self.var_9413068bac411438 = [];
    }
    
    oldest_perk = "";
    size_limit = level.zm_mode_modifiers.var_ea2b964809851284.var_fe525c96105d375f;
    
    if ( self.var_9413068bac411438.size >= size_limit && !bought && !is_item_perk || is_special_returned )
    {
        return;
    }
    
    self.var_9413068bac411438[ self.var_9413068bac411438.size ] = perk;
    
    if ( self.var_9413068bac411438.size > size_limit )
    {
        oldest_perk = self.var_9413068bac411438[ 0 ];
        self.var_9413068bac411438[ 0 ] = undefined;
        
        if ( isint( 0 ) )
        {
            function_cdc669dbc8ea2101( self.var_9413068bac411438 );
        }
    }
    
    if ( self.perks_active.size > size_limit )
    {
        utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103", oldest_perk );
        waitframe();
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xd6330756, Offset: 0x4f0c
// Size: 0x24
function function_f92dc7521b5280d()
{
    level.zm_mode_modifiers.var_3bacdb0dd3796c03 = 1;
    setomnvar( "ui_total_perk_price_scaling_active", 1 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xf5f1a389, Offset: 0x4f38
// Size: 0x20
function function_291689d167db0ffd()
{
    level.zm_mode_modifiers.var_3bacdb0dd3796c03 = undefined;
    setomnvar( "ui_total_perk_price_scaling_active", 0 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x28939307, Offset: 0x4f60
// Size: 0x54
function set_wallbuy_refill_ammo()
{
    level.zm_mode_modifiers.var_9fc3bdcc2aa3a4c6 = 1;
    utility::registersharedfunc( #"wallbuy", #"player_has_weapon_override", &function_21da8105947ab024 );
    utility::registersharedfunc( #"wallbuy", #"hash_24b240b4ca884d15", &function_3a939a558b8c1652 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x494d3656, Offset: 0x4fbc
// Size: 0x51
function disable_wallbuy_refill_ammo()
{
    level.zm_mode_modifiers.var_9fc3bdcc2aa3a4c6 = 0;
    level.sharedfuncs[ #"wallbuy" ][ #"player_has_weapon_override" ] = undefined;
    level.sharedfuncs[ #"wallbuy" ][ #"hash_24b240b4ca884d15" ] = undefined;
}

// Namespace zombie_mode_modifiers
// Params 2, eflags: 0x4
// Checksum 0xc630c211, Offset: 0x5015
// Size: 0x209, Type: bool
function private function_21da8105947ab024( player, itementry )
{
    item_bundle = getscriptbundle( itementry );
    weaponobj = item_weapon::function_477bf1207c6672a5( item_bundle );
    var_1d54b58625d294b5 = weaponobj getbaseweapon();
    var_ab13966355ea575f = undefined;
    
    foreach ( weapon in player.primaryinventory )
    {
        var_4d2571bbc7397806 = weapon getbaseweapon();
        
        if ( issameweapon( var_1d54b58625d294b5, var_4d2571bbc7397806 ) )
        {
            var_ab13966355ea575f = weapon;
        }
    }
    
    if ( !isdefined( var_ab13966355ea575f ) )
    {
        return false;
    }
    
    if ( player attackbuttonpressed() )
    {
        return true;
    }
    
    if ( var_ab13966355ea575f.ismelee )
    {
        return true;
    }
    
    if ( !weapon::isprimaryweapon( var_ab13966355ea575f ) )
    {
        return true;
    }
    
    currencytype = #"essence";
    var_50bac4dcea60a475 = utility::callsharedfunc( #"ammo_cache", #"hash_2c8f07b47ebbf19d", player, var_ab13966355ea575f );
    bfullammo = player is_weapon_ammo_full( var_ab13966355ea575f );
    
    if ( bfullammo )
    {
        if ( isdefined( level.currency[ currencytype ].denysound ) )
        {
            player playsoundtoplayer( level.currency[ currencytype ].denysound, player );
        }
        
        return true;
    }
    
    if ( !isdefined( currencytype ) || var_50bac4dcea60a475 == 0 )
    {
        player utility::callsharedfunc( #"ammo_cache", #"ammo_cache_give_ammo", var_ab13966355ea575f );
    }
    else if ( player currency::attempt_purchase( currencytype, var_50bac4dcea60a475, 1, 0, #"ammo_cache" ) )
    {
        player utility::callsharedfunc( #"ammo_cache", #"ammo_cache_give_ammo", var_ab13966355ea575f );
    }
    
    return true;
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x338d1636, Offset: 0x5227
// Size: 0x98
function private is_weapon_ammo_full( var_ab13966355ea575f )
{
    player = self;
    var_50bac4dcea60a475 = utility::callsharedfunc( #"ammo_cache", #"hash_2c8f07b47ebbf19d", player, var_ab13966355ea575f );
    max_clip_ammo = weaponclipsize( var_ab13966355ea575f );
    max_stock_ammo = weaponmaxammo( var_ab13966355ea575f );
    currentclipammo = player getweaponammoclip( var_ab13966355ea575f );
    currentstockammo = player getweaponammostock( var_ab13966355ea575f );
    var_63753858c2ea9497 = currentclipammo >= max_clip_ammo && currentstockammo >= max_stock_ammo;
    return var_63753858c2ea9497;
}

// Namespace zombie_mode_modifiers
// Params 4, eflags: 0x4
// Checksum 0xec10d4b6, Offset: 0x52c8
// Size: 0x20a
function private function_3a939a558b8c1652( player, var_436166def74e7611, weapon_name, weapon_icon )
{
    var_1d54b58625d294b5 = var_436166def74e7611 getbaseweapon();
    var_ab13966355ea575f = undefined;
    
    foreach ( weapon in player.primaryinventory )
    {
        var_4d2571bbc7397806 = weapon getbaseweapon();
        
        if ( issameweapon( var_1d54b58625d294b5, var_4d2571bbc7397806 ) )
        {
            var_ab13966355ea575f = weapon;
        }
    }
    
    if ( !isdefined( var_ab13966355ea575f ) )
    {
        return;
    }
    
    cost = utility::callsharedfunc( #"ammo_cache", #"hash_2c8f07b47ebbf19d", player, var_ab13966355ea575f );
    obj = { #icon:weapon_icon, #icon_text_value:cost, #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #description:&"SHARED_HINTSTRINGS/WALLBUY_REFILL_AMMO", #title:weapon_name, #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #type:"HINT_BUTTON" };
    var_bacc0c211bfcfcac = player currency::get_currency_amount( #"essence" );
    
    if ( var_bacc0c211bfcfcac < cost )
    {
        obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        obj.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        obj.interactable = 0;
        return obj;
    }
    
    bfullammo = player is_weapon_ammo_full( var_ab13966355ea575f );
    
    if ( bfullammo )
    {
        obj.aux_text = &"SHARED_HINTSTRINGS/WALLBUY_AMMO_FULL";
        obj.interactable = 0;
        return obj;
    }
    
    return obj;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x7132b463, Offset: 0x54db
// Size: 0x5a
function set_no_self_revives()
{
    level.zm_mode_modifiers.var_75911fb102b4859d = 1;
    setomnvar( "ui_show_self_revive", 0 );
    level.var_71b6079fc23545cd = &function_a35b515309ed4c69;
    function_1dc994a3a9803834( %"equip_self_revive" );
    common_item::function_f77c7eedea4fc99f( %"itemspawnentry:zm_sat_item_revive_self_revive", %"none" );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x10f8d961, Offset: 0x553d
// Size: 0x43
function function_d16770e41a7cf076()
{
    level.zm_mode_modifiers.var_75911fb102b4859d = 0;
    setomnvar( "ui_show_self_revive", 1 );
    function_2fa87093c5176d7d( %"equip_self_revive" );
    common_item::function_6de05583881c7e60( %"itemspawnentry:zm_sat_item_revive_self_revive" );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x2faabb7f, Offset: 0x5588
// Size: 0x62
function function_1dc994a3a9803834( ref )
{
    if ( !isxhashasset( ref ) )
    {
        ref = getxhashasset( ref );
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_24a8fa99110eda39 ) )
    {
        level.zm_mode_modifiers.var_24a8fa99110eda39 = [];
    }
    
    level.zm_mode_modifiers.var_24a8fa99110eda39[ ref ] = 1;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x18135d49, Offset: 0x55f2
// Size: 0x5f
function function_2fa87093c5176d7d( ref )
{
    if ( !isxhashasset( ref ) )
    {
        ref = getxhashasset( ref );
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_24a8fa99110eda39 ) )
    {
        level.zm_mode_modifiers.var_24a8fa99110eda39 = [];
    }
    
    level.zm_mode_modifiers.var_24a8fa99110eda39[ ref ] = undefined;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xfb5d6521, Offset: 0x5659
// Size: 0x62
function function_b35451878ed8b4b9( ref )
{
    if ( !isxhash( ref ) )
    {
        ref = getxhashasset( ref );
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_1339a4e02399cb52 ) )
    {
        level.zm_mode_modifiers.var_1339a4e02399cb52 = [];
    }
    
    level.zm_mode_modifiers.var_1339a4e02399cb52[ ref ] = 1;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x396eb379, Offset: 0x56c3
// Size: 0x5f
function function_c64c9bc5ccd7270e( ref )
{
    if ( !isxhash( ref ) )
    {
        ref = getxhash( ref );
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_1339a4e02399cb52 ) )
    {
        level.zm_mode_modifiers.var_1339a4e02399cb52 = [];
    }
    
    level.zm_mode_modifiers.var_1339a4e02399cb52[ ref ] = undefined;
}

// Namespace zombie_mode_modifiers
// Params 2
// Checksum 0xd924f110, Offset: 0x572a
// Size: 0xb5, Type: bool
function function_a35b515309ed4c69( var_c5fb7b9c0ca383b7, current_response )
{
    if ( var_c5fb7b9c0ca383b7.itemref && level.zm_mode_modifiers.var_24a8fa99110eda39[ getxhashasset( var_c5fb7b9c0ca383b7.itemref ) ] )
    {
        return false;
    }
    
    if ( level.zm_mode_modifiers.var_1339a4e02399cb52.size > 0 )
    {
        bundle = common_item::function_cf68ad18114498b2( var_c5fb7b9c0ca383b7.itemref );
        type = common_item::function_16e8c106491eeaca( bundle );
        
        if ( level.zm_mode_modifiers.var_1339a4e02399cb52[ getxhash( type ) ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x9479100f, Offset: 0x57e8
// Size: 0x20
function set_no_augments()
{
    level.zm_mode_modifiers.var_883a0291ac45b227 = 1;
    level thread function_7396b31a749b1933();
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xf1355bd8, Offset: 0x5810
// Size: 0x29
function function_aac93cc049fd5090()
{
    utility::waittill_any_timeout( 2, "player_loadout_augments_given" );
    utility::callsharedfunc( #"zombie", #"hash_ce4704a324ef399f" );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0xc
// Checksum 0x3cda9757, Offset: 0x5841
// Size: 0xf1
function private function_7396b31a749b1933( params )
{
    self notify( #"hash_5f4b5f62807cae10" );
    self endon( #"hash_5f4b5f62807cae10" );
    monitor_time = 15;
    
    for ( i = 0; i < monitor_time ; i++ )
    {
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && !player utility::ent_flag( "loadout_augments_setup_in_progress" ) )
            {
                player thread utility::callsharedfunc( #"zombie", #"hash_ce4704a324ef399f" );
            }
        }
        
        wait 2;
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x1bf072b7, Offset: 0x593a
// Size: 0xc0
function function_58783a99a744b5ce()
{
    level callback::add( #"player_spawned", &function_7b202d7a511a2310 );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player utility::callsharedfunc( #"full_power", #"hash_cee7fddde600119a" );
            player val::set( "zombie_mode_modifiers", "allow_give_super_point", 0 );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x44481985, Offset: 0x5a02
// Size: 0x37
function private function_7b202d7a511a2310( params )
{
    utility::callsharedfunc( #"full_power", #"hash_cee7fddde600119a" );
    val::set( "zombie_mode_modifiers", "allow_give_super_point", 0 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x221e0b95, Offset: 0x5a41
// Size: 0x9b
function function_72789ed1f1c172de()
{
    level callback::remove( #"player_spawned", &function_7b202d7a511a2310 );
    
    foreach ( player in level.players )
    {
        player val::reset( "zombie_mode_modifiers", "allow_give_super_point" );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x6f8ce7df, Offset: 0x5ae4
// Size: 0x18
function function_e9561d9de97e194c()
{
    level callback::add( #"on_ai_killed", &function_410eecbd49a8d678 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xcb7eaf66, Offset: 0x5b04
// Size: 0x18
function function_e619c5dce119c47c()
{
    level callback::remove( #"on_ai_killed", &function_410eecbd49a8d678 );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xb6aa8429, Offset: 0x5b24
// Size: 0x1ae
function private function_410eecbd49a8d678( params )
{
    if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
    }
    else if ( isplayer( params.einflictor.owner ) )
    {
        player = params.einflictor.owner;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_d88a7cf3f55c9e72 ) )
    {
        player.var_d88a7cf3f55c9e72 = 0;
    }
    
    player.var_d88a7cf3f55c9e72++;
    var_8bb764f5289351ee = level.zm_relic_modifiers[ #"hash_3385fa4802fa103e" ].var_c7936ba2a928b771;
    
    if ( getdvarint( @"hash_69a73bdd305393b5", 0 ) )
    {
        var_8bb764f5289351ee = getdvarint( @"hash_69a73bdd305393b5", 0 );
    }
    
    if ( player.var_d88a7cf3f55c9e72 >= var_8bb764f5289351ee )
    {
        player.var_d88a7cf3f55c9e72 = 0;
        var_f535a53680fa3221 = 0;
        var_5754b8a57d078e09 = 0;
        n_starting_perk_count = player.perks_active.size;
        
        while ( n_starting_perk_count && !var_5754b8a57d078e09 && var_f535a53680fa3221 < n_starting_perk_count )
        {
            str_perk = player.perks_active[ var_f535a53680fa3221 ];
            
            if ( str_perk == "specialty_quickrevive" && var_f535a53680fa3221 == 0 && n_starting_perk_count > 1 )
            {
                var_f535a53680fa3221++;
                str_perk = player.perks_active[ var_f535a53680fa3221 ];
            }
            
            var_5754b8a57d078e09 = player utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103", str_perk );
            var_f535a53680fa3221++;
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x8f0f306e, Offset: 0x5cda
// Size: 0x13
function function_bee359d0ac0b705c()
{
    common_item::function_5734400f32ca9803( "salvage", &function_58a1927e3da3ed2c );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x9ffd7247, Offset: 0x5cf5
// Size: 0x28
function function_58a1927e3da3ed2c( params )
{
    if ( utility::cointoss() )
    {
        waittillframeend();
        common_item::function_869d7676e359a627( params.item );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xcad33aea, Offset: 0x5d25
// Size: 0x13
function function_c2ac51278202f46c()
{
    common_item::function_134b9624f3886a06( "salvage", &function_58a1927e3da3ed2c );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xfc20e89, Offset: 0x5d40
// Size: 0x16
function function_e5b02c0a2de2d037()
{
    level val::set( "zombie_mode_modifiers", "zombie_damage_to_player_multiplier", 2 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x9a8930ec, Offset: 0x5d5e
// Size: 0x14
function function_789406545fb68be7()
{
    level val::reset( "zombie_mode_modifiers", "zombie_damage_to_player_multiplier" );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xabcd6133, Offset: 0x5d7a
// Size: 0x167
function set_no_mystery_box()
{
    level.zm_mode_modifiers.var_7d3d84e96a1a43b5 = 1;
    
    if ( utility::flag_exist( "magicbox_ready" ) )
    {
        level utility::flag_wait( "magicbox_ready" );
    }
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        var_349a0723ed9ac19c function_8d19879eb3148b11();
    }
    
    if ( !level callback::exists( #"hash_9325330e77aef2ad", &on_firesale_start ) )
    {
        level callback::add( #"hash_9325330e77aef2ad", &on_firesale_start );
    }
    
    if ( !level callback::exists( #"firesale_end", &on_firesale_end ) )
    {
        level callback::add( #"firesale_end", &on_firesale_end );
    }
    
    if ( !level callback::exists( #"hash_ad40d2adc92426c", &on_spawn_magicbox ) )
    {
        level callback::add( #"hash_ad40d2adc92426c", &on_spawn_magicbox );
    }
    
    if ( !level callback::exists( #"hash_1476c6ebca52a63f", &function_f62438893051cd6a ) )
    {
        callback::add( #"hash_1476c6ebca52a63f", &function_f62438893051cd6a );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xdb0c998f, Offset: 0x5ee9
// Size: 0x1ce
function disable_no_mystery_box( var_158b8be86b431178 )
{
    level.zm_mode_modifiers.var_7d3d84e96a1a43b5 = 0;
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        playfx( level._effect[ #"hash_e6eca969a60a9d62" ], var_349a0723ed9ac19c.origin );
        waitframe();
        
        if ( var_349a0723ed9ac19c.var_f14b2b4820b635e7 )
        {
            var_349a0723ed9ac19c utility::callsharedfunc( #"zombie", #"hash_d66633c1e4eea8f1" );
        }
        
        if ( var_349a0723ed9ac19c.mdl_magicbox.mr_peeks_disable )
        {
            var_349a0723ed9ac19c.mdl_magicbox.mr_peeks_disable freescriptable();
        }
    }
    
    if ( !var_158b8be86b431178 )
    {
        if ( level callback::exists( #"hash_9325330e77aef2ad", &on_firesale_start ) )
        {
            level callback::remove( #"hash_9325330e77aef2ad", &on_firesale_start );
        }
        
        if ( level callback::exists( #"firesale_end", &on_firesale_end ) )
        {
            level callback::remove( #"firesale_end", &on_firesale_end );
        }
        
        if ( level callback::exists( #"hash_ad40d2adc92426c", &on_spawn_magicbox ) )
        {
            level callback::remove( #"hash_ad40d2adc92426c", &on_spawn_magicbox );
        }
        
        if ( level callback::exists( #"hash_1476c6ebca52a63f", &function_f62438893051cd6a ) )
        {
            level callback::remove( #"hash_1476c6ebca52a63f", &function_f62438893051cd6a );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x4ccd0e1a, Offset: 0x60bf
// Size: 0x15
function on_firesale_start( params )
{
    disable_no_mystery_box( 1 );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x9a33be40, Offset: 0x60dc
// Size: 0x13
function on_firesale_end( params )
{
    set_no_mystery_box();
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x6eb5686a, Offset: 0x60f7
// Size: 0x100
function function_8d19879eb3148b11()
{
    playfx( level._effect[ #"hash_e6eca969a60a9d62" ], self.origin );
    waitframe();
    
    if ( !self )
    {
        return;
    }
    
    utility::callsharedfunc( #"zombie", #"hash_ba00127cec14a5b2", 1, 1 );
    
    if ( self.mdl_magicbox && !self.mdl_magicbox.mr_peeks_disable && self.mdl_magicbox.model != "t10_zm_mystery_box_all_fxanim" )
    {
        self.mdl_magicbox.mr_peeks_disable = spawnscriptable( %"sat_zm_mr_peeks_disabled", self.mdl_magicbox.origin + ( 0, 0, 24 ), self.mdl_magicbox.angles );
        self.mdl_magicbox.mr_peeks_disable thread function_88046eb9464afac6( self.mdl_magicbox );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x176f668c, Offset: 0x61ff
// Size: 0x49
function on_spawn_magicbox( params )
{
    if ( !level.zm_mode_modifiers.var_7d3d84e96a1a43b5 )
    {
        return;
    }
    
    if ( utility::flag_exist( "magicbox_ready" ) )
    {
        level utility::flag_wait( "magicbox_ready" );
    }
    
    wait 5;
    function_8d19879eb3148b11();
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x6082478d, Offset: 0x6250
// Size: 0x32
function function_f62438893051cd6a( params )
{
    if ( !level.zm_mode_modifiers.var_7d3d84e96a1a43b5 )
    {
        return;
    }
    
    wait 1;
    
    if ( self )
    {
        function_8d19879eb3148b11();
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x53486f53, Offset: 0x628a
// Size: 0x56
function private set_ammo_cache_icon( var_5207c09168cffe2d )
{
    self endon( #"death" );
    result = utility::ent_flag_wait_or_timeout( "minimap_floor_setup_init", 5 );
    
    if ( result != "timeout" )
    {
        utility::ent_flag_wait( "minimap_floor_setup_complete" );
    }
    
    utility::function_7c10ea82c1e305b8( "icon", var_5207c09168cffe2d );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x595ab268, Offset: 0x62e8
// Size: 0xef
function set_no_ammo_cache()
{
    level.zm_mode_modifiers.var_3177d46e962e42e5 = 1;
    level utility::flag_wait_or_timeout( "ammo_caches_initialized", 5 );
    
    if ( level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        foreach ( cache_spawn in level._ammo_cache_info.var_ea07e36d8fd28578 )
        {
            cache_spawn function_e17b0e5f7ee69e9c();
        }
    }
    
    if ( !level callback::exists( #"hash_406f38242baa9b03", &on_spawn_ammo_cache ) )
    {
        level callback::add( #"hash_406f38242baa9b03", &on_spawn_ammo_cache );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x2c30acd8, Offset: 0x63df
// Size: 0x1a9
function disable_no_ammo_cache()
{
    level.zm_mode_modifiers.var_3177d46e962e42e5 = 0;
    
    if ( level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        foreach ( cache_spawn in level._ammo_cache_info.var_ea07e36d8fd28578 )
        {
            playfx( level._effect[ #"hash_e6eca969a60a9d62" ], cache_spawn.origin );
            waitframe();
            model = cache_spawn.ammocache_trigger.var_a3338cc37b82b7b3;
            model utility::function_7c10ea82c1e305b8( "attract_audio", "active" );
            model utility::function_7c10ea82c1e305b8( "light", "base" );
            model thread set_ammo_cache_icon( "active" );
            
            if ( model.mr_peeks_disable )
            {
                model.mr_peeks_disable freescriptable();
            }
            
            if ( cache_spawn.ammocache_trigger )
            {
                cache_spawn.ammocache_trigger.var_94d1ab5da995e573 = undefined;
                cache_spawn.ammocache_trigger utility::function_7c10ea82c1e305b8( "ammo_cache_use", "ammo_cache_use" );
            }
        }
    }
    
    if ( level callback::exists( #"hash_406f38242baa9b03", &on_spawn_ammo_cache ) )
    {
        level callback::remove( #"hash_406f38242baa9b03", &on_spawn_ammo_cache );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x7841a63, Offset: 0x6590
// Size: 0x121
function function_e17b0e5f7ee69e9c()
{
    playfx( level._effect[ #"hash_e6eca969a60a9d62" ], self.origin );
    waitframe();
    model = self.ammocache_trigger.var_a3338cc37b82b7b3;
    model utility::function_7c10ea82c1e305b8( "attract_audio", "hidden" );
    model utility::function_7c10ea82c1e305b8( "light", "hidden" );
    model thread set_ammo_cache_icon( "disable" );
    
    if ( !model.mr_peeks_disable )
    {
        model.mr_peeks_disable = spawnscriptable( %"sat_zm_mr_peeks_disabled", model.origin + ( 0, 0, 43 ), model.angles + ( 0, -90, 0 ) );
        model.mr_peeks_disable thread function_88046eb9464afac6( model );
    }
    
    if ( self.ammocache_trigger )
    {
        self.ammocache_trigger.var_94d1ab5da995e573 = 1;
        self.ammocache_trigger utility::function_7c10ea82c1e305b8( "ammo_cache_use", "ammo_cache_disable" );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x52b1a535, Offset: 0x66b9
// Size: 0x2e
function on_spawn_ammo_cache( params )
{
    if ( !level.zm_mode_modifiers.var_3177d46e962e42e5 )
    {
        return;
    }
    
    wait 2;
    function_e17b0e5f7ee69e9c();
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x6ac8535, Offset: 0x66ef
// Size: 0xcc
function private set_classic_points()
{
    level.zm_mode_modifiers.var_7f34cf570cef6d7f = 1;
    level callback::add( "on_zombie_ai_damaged", &function_c93d01aa38871882 );
    level callback::add( "on_zombie_ai_killed", &function_1f2b1e1c798dc766 );
    level callback::add( #"player_laststand_revived", &function_e566e400fa7f7fa4 );
    level callback::add( #"player_laststand", &function_995ec3ccf7a0e305 );
    level callback::add( #"player_death", &function_13cdd0f8bc4038db );
    level callback::add( "on_living_world_prop_zombie_killed", &function_bd2965317fe3516d );
    utility::registersharedfunc( #"points", #"hash_f8ef1411750d5b3c", &function_b974e99070f35bd1 );
    utility::registersharedfunc( #"points", #"zm_give_points_override", &zm_give_points_override );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xbfee6a80, Offset: 0x67c3
// Size: 0x291
function private function_c93d01aa38871882( sparams )
{
    if ( !isalive( self ) || !isalive( sparams.eattacker ) )
    {
        return;
    }
    
    if ( self.var_698cf8d8d4a8cbb9 )
    {
        return;
    }
    
    if ( !self.kiastring )
    {
        return;
    }
    
    if ( !val::get( "allow_give_point" ) )
    {
        return;
    }
    
    if ( sparams.sweapon.basename == "none" )
    {
        return;
    }
    
    if ( sparams.sweapon.isfieldupgrade )
    {
        return;
    }
    
    if ( self.var_f8128ec93742e435 && self.var_f8128ec93742e435 > self.maxhealth )
    {
        return;
    }
    
    if ( utility::ent_flag( "lightray_damage" ) )
    {
        return;
    }
    
    if ( equipment_mp::function_65ff545a795c7f55( sparams.sweapon ) || sparams.sweapon.var_25b0062cbe4d9c99 == #"molotov" )
    {
        return;
    }
    
    if ( sparams.objweapon && weapon::iskillstreakweapon( sparams.objweapon ) )
    {
        return;
    }
    
    if ( self.var_183f4d5d5cc70f29 )
    {
        return;
    }
    
    if ( !sparams.idamage > 0 )
    {
        return;
    }
    
    if ( val::get( "damageshield" ) )
    {
        return;
    }
    
    switch ( self.kiastring )
    {
        case #"hash_2a7922a73e6eb69":
        case #"zombie_kia_mission_kill_special":
        case #"zombie_kia_mission_kill_elite":
        case #"zombie_kia_mission_kill":
            return;
    }
    
    victimstruct = { #health:self.health, #idamage:self.last_dmg_struct.idamage, #aicategory:self.aicategory };
    
    if ( isplayer( sparams.eattacker ) && victimstruct.idamage < victimstruct.health )
    {
        if ( victimstruct.aicategory == "special" || victimstruct.aicategory == "elite" || victimstruct.aicategory == "hvt" || victimstruct.aicategory == "boss" )
        {
            return;
        }
        
        points = 10;
        level function_6e0037662b85ec40( sparams.eattacker, points, #"hash_e617e3c7e6a21a01", undefined, 0, sparams.idamage );
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x1ad6015f, Offset: 0x6a5c
// Size: 0x15
function private function_bd2965317fe3516d( sparams )
{
    function_1f2b1e1c798dc766( sparams );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x978f968d, Offset: 0x6a79
// Size: 0x807
function private function_1f2b1e1c798dc766( sparams )
{
    victimstruct = { #eattacker:sparams.eattacker, #einflictor:sparams.einflictor, #objweapon:sparams.objweapon, #a_n_player_damage:self.a_n_player_damage, #aicategory:self.aicategory, #biscritical:self.last_dmg_struct.biscritical, #shitloc:self.last_dmg_struct.shitloc };
    
    if ( !val::get( "allow_give_point" ) )
    {
        return;
    }
    
    scoreevent_info = spawnstruct();
    
    if ( !isplayer( sparams.eattacker ) )
    {
        if ( sparams.eattacker && sparams.eattacker vehicle::is_vehicle() && isdefined( sparams.eattacker.occupants ) && isplayer( sparams.eattacker.occupants[ "driver" ] ) )
        {
            victimstruct.einflictor = sparams.eattacker;
            victimstruct.eattacker = sparams.eattacker.occupants[ "driver" ];
        }
        else if ( isplayer( sparams.eattacker.owner ) )
        {
            victimstruct.eattacker = sparams.eattacker.owner;
        }
        else if ( isplayer( sparams.einflictor.activator ) )
        {
            victimstruct.eattacker = sparams.einflictor.activator;
        }
        else if ( isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
        {
            victimstruct.eattacker = sparams.eattacker.var_bd22ba6c600a23a3;
            turned_zombie_kill = 1;
        }
        else
        {
            return;
        }
    }
    
    if ( self.var_698cf8d8d4a8cbb9 )
    {
        return;
    }
    
    if ( !self.kiastring )
    {
        return;
    }
    
    isteamkill = 0;
    points = 60;
    scoreevent_ref = #"zombie_kia_r_mod";
    
    if ( sparams.var_769b3a755c2cec3c )
    {
        points = 50;
    }
    
    if ( isdefined( victimstruct.shitloc ) )
    {
        if ( issubstr( victimstruct.shitloc, "leg" ) )
        {
            points = 50;
        }
        
        if ( issubstr( victimstruct.shitloc, "arm" ) )
        {
            points = 50;
        }
        
        if ( issubstr( victimstruct.shitloc, "torso_upper" ) )
        {
            points = 70;
        }
    }
    
    if ( victimstruct.biscritical )
    {
        points = 100;
    }
    
    if ( isdefined( sparams.smeansofdeath ) )
    {
        if ( sparams.smeansofdeath == "MOD_MELEE" )
        {
            points = 130;
            scoreevent_ref = #"zombie_kia_r_mod_melee";
            scoreevent_info.smeansofdeath = "MOD_MELEE";
            
            if ( utility::issharedfuncdefined( #"zombie", #"hash_3930894d8d2f0ee6" ) && sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_closing_argument" ) )
            {
                bonuspoints = level.zombie_augments[ #"m_mod_closing_argument" ].var_b27cab6c58e80e1e ?? 0;
                points += bonuspoints;
            }
        }
        else if ( sparams.smeansofdeath == "MOD_EXPLOSIVE" || sparams.smeansofdeath == "MOD_EXPLOSIVE_BULLET" || sparams.smeansofdeath == "MOD_GRENADE" || sparams.smeansofdeath == "MOD_GRENADE_SPLASH" || sparams.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            points = 50;
        }
        
        if ( turned_zombie_kill )
        {
            scoreevent_ref = #"zombie_kia_r_mod_ammomod";
        }
    }
    
    if ( victimstruct.einflictor && victimstruct.einflictor vehicle::is_vehicle() && !victimstruct.einflictor.isequipment )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_vehicle";
    }
    
    if ( victimstruct.objweapon && ( weapon::isweaponequipment( victimstruct.objweapon ) || victimstruct.einflictor.isequipment ) )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_equipment";
    }
    
    if ( victimstruct.objweapon && weapon::iskillstreakweapon( victimstruct.objweapon ) )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_scorestreak";
    }
    
    if ( victimstruct.eattacker && victimstruct.objweapon && victimstruct.eattacker zm_utility::is_weapon_field_upgrade( victimstruct.objweapon ) )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_super";
    }
    
    if ( zm_utility::function_87c7047a00d0f447() || victimstruct.einflictor.var_bd22ba6c600a23a3 )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_ammomod";
    }
    
    if ( zm_utility::is_killed_by_augment() )
    {
        points = 50;
    }
    
    if ( self.killed_by_phd_flopper )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_perk";
    }
    
    if ( self.var_dd22e69947766504 )
    {
        points = 50;
        scoreevent_ref = #"zombie_kia_r_mod_perk";
    }
    
    if ( sparams.objweapon.basename == "none" && sparams.smeansofdeath != "MOD_MELEE" )
    {
        points = 50;
    }
    
    if ( victimstruct.einflictor.trap_scriptable )
    {
        points = 10;
        scoreevent_ref = #"zombie_kia_r_mod_trap";
    }
    
    if ( victimstruct.aicategory )
    {
        switch ( victimstruct.aicategory )
        {
            case #"hash_8c089e813083e510":
                points = 250;
                isteamkill = 1;
                scoreevent_ref = #"zombie_kia_r_mod_special";
                break;
            case #"hash_7b0e2f2ed84f34":
                points = 500;
                isteamkill = 1;
                scoreevent_ref = #"zombie_kia_r_mod_elite";
                break;
            case #"hash_4e47eb6c32f5b165":
                points = 750;
                isteamkill = 1;
                scoreevent_ref = #"zombie_kia_r_mod_elite";
                break;
            case #"hash_7e8a002ed096276c":
                points = 1000;
                isteamkill = 1;
                scoreevent_ref = #"zombie_kia_r_mod_boss";
                break;
        }
    }
    
    switch ( self.kiastring )
    {
        case #"hash_2a7922a73e6eb69":
        case #"zombie_kia_mission_kill_special":
        case #"zombie_kia_mission_kill_elite":
        case #"zombie_kia_mission_kill":
            points = 10;
            break;
    }
    
    level function_6e0037662b85ec40( victimstruct.eattacker, points, scoreevent_ref, scoreevent_info, 1, sparams.idamage );
    
    if ( isteamkill && isarray( victimstruct.a_n_player_damage ) )
    {
        foreach ( assistplayer in victimstruct.a_n_player_damage )
        {
            if ( assistplayer === victimstruct.eattacker )
            {
                continue;
            }
            
            level function_6e0037662b85ec40( assistplayer, points, scoreevent_ref, scoreevent_info, 1 );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x1f9f97d7, Offset: 0x7288
// Size: 0x72
function private function_e566e400fa7f7fa4( params )
{
    if ( isplayer( params.reviver ) && params.reviver != self )
    {
        points = 0.05 * points::zm_get_points();
        points = function_890ea9f833797404( points );
        level function_6e0037662b85ec40( params.reviver, points, #"hash_73e2b6dc80a9da9b", undefined, 1 );
    }
}

// Namespace zombie_mode_modifiers
// Params 4, eflags: 0x4
// Checksum 0x49654887, Offset: 0x7302
// Size: 0x36
function private zm_give_points_override( player, points, scoreevent_ref, scoreevent_info )
{
    function_6e0037662b85ec40( player, points, scoreevent_ref, scoreevent_info, 1 );
}

// Namespace zombie_mode_modifiers
// Params 6, eflags: 0x4
// Checksum 0x59b69ced, Offset: 0x7340
// Size: 0x8b
function private function_6e0037662b85ec40( player, points, scoreevent_ref, scoreevent_info, var_bbc055a93d3b130b, idamage )
{
    if ( isplayer( player ) )
    {
        if ( !points )
        {
            points = rank::getscoreinfovalue( scoreevent_ref );
        }
        
        if ( !isdefined( points ) )
        {
            points = 0;
        }
        
        points = player points::zm_modify_points( points, scoreevent_ref, player, undefined, scoreevent_info ) ?? 0;
        player points::zm_add_points( points );
        player function_b974e99070f35bd1( scoreevent_ref, points, undefined, scoreevent_info, 0, var_bbc055a93d3b130b, idamage );
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xd81b535, Offset: 0x73d3
// Size: 0x56
function private function_995ec3ccf7a0e305( params )
{
    player = self;
    var_48029d7d9a7c0d7e = player points::zm_get_points();
    var_1a6f797b83cf01b = var_48029d7d9a7c0d7e * 0.05;
    var_1a6f797b83cf01b = function_890ea9f833797404( var_1a6f797b83cf01b );
    player points::function_b660af7031bca4bd( int( var_1a6f797b83cf01b ) );
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xb0c93f34, Offset: 0x7431
// Size: 0xc0
function private function_13cdd0f8bc4038db( params )
{
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            var_48029d7d9a7c0d7e = player points::zm_get_points();
            var_1a6f797b83cf01b = var_48029d7d9a7c0d7e * 0.1;
            var_1a6f797b83cf01b = function_890ea9f833797404( var_1a6f797b83cf01b );
            player points::function_b660af7031bca4bd( int( var_1a6f797b83cf01b ) );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 7, eflags: 0x4
// Checksum 0x3c8219b6, Offset: 0x74f9
// Size: 0x10f
function private function_b974e99070f35bd1( event, points, objweapon, eventinfo, var_36106582138abca1 = 1, var_bbc055a93d3b130b, idamage )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !points )
    {
        points = rank::getscoreinfovalue( event );
    }
    
    if ( points > 0 )
    {
        if ( var_36106582138abca1 )
        {
            points = points::zm_modify_points( points, event, self, undefined, eventinfo ) ?? 0;
        }
        
        if ( self.var_313f179273456000 > 50 )
        {
            self notify( #"hash_d4ca18e348001d56" );
            self.var_313f179273456000 = 0;
        }
        
        if ( event == #"profit_sharing" )
        {
            var_bbc055a93d3b130b = 0;
        }
        
        if ( getdvarint( @"hash_9f88e1076d1c95a9", 0 ) && idamage )
        {
            level mp_agent_damage::function_2b26b84aa6ce249c( self, 1, idamage, ( 0, 0, 0 ), 0, undefined, var_bbc055a93d3b130b );
            return;
        }
        
        level mp_agent_damage::function_2b26b84aa6ce249c( self, 6, points, ( 0, 0, 0 ), 0, undefined, var_bbc055a93d3b130b );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x73bbeb2a, Offset: 0x7610
// Size: 0x18
function function_890ea9f833797404( number )
{
    return 5 * round( number / 5 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x69a10e31, Offset: 0x7631
// Size: 0x101
function function_602da0d19bc240ef()
{
    level.zm_mode_modifiers.var_63da2ef147f344a4 = 1;
    
    foreach ( player in level.players )
    {
        player callback::add( "zm_packed_weapon", &function_264ab604df8e3aed );
    }
    
    if ( !level callback::exists( #"item_weapon_picked_up", &function_e659cdce98499e43 ) )
    {
        level callback::add( #"item_weapon_picked_up", &function_e659cdce98499e43 );
    }
    
    if ( !level callback::exists( #"hash_9aafcac01b1facc6", &function_4c6033f645b53fc7 ) )
    {
        level callback::add( #"hash_9aafcac01b1facc6", &function_4c6033f645b53fc7 );
    }
    
    level thread function_141e967de9b3f292();
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xb106cd43, Offset: 0x773a
// Size: 0xc6
function function_483ce4653e168eff()
{
    level.zm_mode_modifiers.var_63da2ef147f344a4 = 0;
    
    foreach ( player in level.players )
    {
        player callback::remove( "zm_packed_weapon", &function_264ab604df8e3aed );
    }
    
    level callback::remove( #"hash_9aafcac01b1facc6", &function_4c6033f645b53fc7 );
    level callback::remove( #"item_weapon_picked_up", &function_e659cdce98499e43 );
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0xa8bac2ba, Offset: 0x7808
// Size: 0x7b
function private function_141e967de9b3f292()
{
    foreach ( player in level.players )
    {
        player function_46cfaa11de9c5c1b();
    }
}

// Namespace zombie_mode_modifiers
// Params 0, eflags: 0x4
// Checksum 0x8b157741, Offset: 0x788b
// Size: 0x213
function private function_46cfaa11de9c5c1b()
{
    packed_weapons = [];
    
    foreach ( weapon in self getweaponslist( "primary" ) )
    {
        pap_level = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
        
        if ( pap_level > 0 )
        {
            packed_weapons[ packed_weapons.size ] = weapon;
        }
    }
    
    if ( packed_weapons.size <= 1 )
    {
        return;
    }
    
    current_weapon = self getcurrentweapon();
    var_ef175dbb563d91e2 = packed_weapons[ 0 ];
    
    foreach ( weapon in packed_weapons )
    {
        if ( weapon == current_weapon )
        {
            var_ef175dbb563d91e2 = weapon;
            break;
        }
    }
    
    /#
        iprintlnbold( "<dev string:x24>" + var_ef175dbb563d91e2.rootname );
    #/
    
    foreach ( weapon in packed_weapons )
    {
        if ( weapon == var_ef175dbb563d91e2 )
        {
            continue;
        }
        
        /#
            iprintlnbold( "<dev string:x5a>" + weapon.rootname );
        #/
        
        dropped_weapon = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #weapon:weapon } );
        
        if ( dropped_weapon )
        {
            thread function_a5df484bd75e9568( dropped_weapon );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x7477500b, Offset: 0x7aa6
// Size: 0x218
function private function_264ab604df8e3aed( params )
{
    if ( !level.zm_mode_modifiers.var_63da2ef147f344a4 )
    {
        return;
    }
    
    new_weapon = params.var_101633ed971732ba;
    
    if ( !isweapon( new_weapon ) )
    {
        return;
    }
    
    foreach ( weapon in self getweaponslist( "primary" ) )
    {
        if ( weapon == new_weapon || weapon.basename == params.var_39044599845b54cf.basename )
        {
            continue;
        }
        
        existing_pap_level = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
        
        if ( existing_pap_level > 0 )
        {
            /#
                iprintlnbold( "<dev string:x83>" + weapon.rootname );
            #/
            
            if ( weapon::function_6b74ecd475e99b4( weapon ) )
            {
                rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
                dropped_weapon = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:weapon } );
                newweap = weapon::buildweapon( weapon.basename );
                self giveweapon( newweap );
                self assignweaponmeleeslot( newweap );
                weapon::function_b4c9549dee5d0fc5( newweap );
                item_weapon::function_40e1cbd0e1f47d1a( newweap, rarity, 1 );
                continue;
            }
            
            rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
            dropped_weapon = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #weapon:weapon } );
            
            if ( dropped_weapon )
            {
                if ( isdefined( dropped_weapon.var_6828becb300b1c44 ) )
                {
                    dropped_weapon.var_6828becb300b1c44.rarity = rarity;
                }
                
                thread function_a5df484bd75e9568( dropped_weapon );
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x5109a4e5, Offset: 0x7cc6
// Size: 0x275
function private function_e659cdce98499e43( params )
{
    if ( !level.zm_mode_modifiers.var_63da2ef147f344a4 )
    {
        return;
    }
    
    new_weapon = params.newweaponobj;
    
    if ( isdefined( params.item.var_6828becb300b1c44.rarity ) )
    {
        item_weapon::function_40e1cbd0e1f47d1a( params.newweaponobj, params.item.var_6828becb300b1c44.rarity, 1 );
    }
    
    if ( !isweapon( new_weapon ) )
    {
        return;
    }
    
    new_weapon_pap_level = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", new_weapon );
    
    if ( new_weapon_pap_level <= 0 )
    {
        return;
    }
    
    foreach ( weapon in self getweaponslist( "primary" ) )
    {
        if ( weapon == new_weapon )
        {
            continue;
        }
        
        existing_pap_level = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
        
        if ( existing_pap_level > 0 )
        {
            /#
                iprintlnbold( "<dev string:x83>" + weapon.rootname );
            #/
            
            if ( weapon::function_6b74ecd475e99b4( weapon ) )
            {
                rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
                dropped_weapon = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:weapon } );
                newweap = weapon::buildweapon( weapon.basename );
                self giveweapon( newweap );
                self assignweaponmeleeslot( newweap );
                weapon::function_b4c9549dee5d0fc5( newweap );
                item_weapon::function_40e1cbd0e1f47d1a( newweap, rarity, 1 );
                continue;
            }
            
            rarity = item_weapon::function_fb81bd2fe070faa6( weapon );
            dropped_weapon = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #weapon:weapon } );
            
            if ( dropped_weapon )
            {
                if ( isdefined( dropped_weapon.var_6828becb300b1c44 ) )
                {
                    dropped_weapon.var_6828becb300b1c44.rarity = rarity;
                }
                
                thread function_a5df484bd75e9568( dropped_weapon );
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x556f6097, Offset: 0x7f43
// Size: 0x42
function private function_a5df484bd75e9568( dropped_item )
{
    self notify( #"hash_cdc6203bf5282d64" );
    self endon( #"hash_cdc6203bf5282d64" );
    self endon( #"disconnect" );
    wait 30;
    
    if ( isdefined( dropped_item ) )
    {
        common_item::function_869d7676e359a627( dropped_item );
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x466403b4, Offset: 0x7f8d
// Size: 0x193
function private function_4c6033f645b53fc7( params )
{
    existing_pap_level = params.instance.var_951c89546ec50477 ?? 0;
    maxheldweapons = item_weapon::function_21fb8b54da9c5825();
    var_830f507989d01c8 = params.player item_weapon::function_db94c1441f6cd802();
    var_482e9999b75ed3d8 = istrue( params.player utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" ) );
    
    if ( existing_pap_level > 0 && maxheldweapons == var_830f507989d01c8 && var_482e9999b75ed3d8 )
    {
        foreach ( weapon in self getweaponslist( "primary" ) )
        {
            existing_pap_level = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
            
            if ( existing_pap_level > 0 )
            {
                /#
                    iprintlnbold( "<dev string:x83>" + weapon.rootname );
                #/
                
                if ( !weapon::function_6b74ecd475e99b4( weapon ) )
                {
                    dropped_weapon = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #weapon:weapon } );
                    
                    if ( dropped_weapon )
                    {
                        thread function_a5df484bd75e9568( dropped_weapon );
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x13023190, Offset: 0x8128
// Size: 0xad
function set_extra_bullet_cost( overrideparams )
{
    level.zm_mode_modifiers.var_ac12b3bfd707875b = 1;
    level.zm_mode_modifiers.extrabullets = overrideparams.extrabullets ?? 1;
    level.zm_mode_modifiers.extradamage = overrideparams.extradamage ?? 0.25;
    
    if ( !level callback::exists( #"hash_474490f7ce8b74d0", &function_47ccfdd40c528e99 ) )
    {
        level callback::add( #"hash_474490f7ce8b74d0", &function_47ccfdd40c528e99 );
    }
    
    function_9c9da0455f2c2a45( "extra_bullet_cost", &function_793fdd5b6b3dd56f );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xc640fab0, Offset: 0x81dd
// Size: 0x37
function disable_extra_bullet_cost()
{
    level.zm_mode_modifiers.var_ac12b3bfd707875b = undefined;
    level callback::remove( #"hash_474490f7ce8b74d0", &function_47ccfdd40c528e99 );
    function_d7f9a944fe0b5fd9( "extra_bullet_cost" );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xae5e60fe, Offset: 0x821c
// Size: 0x8c
function function_793fdd5b6b3dd56f( dmg_struct )
{
    if ( !isdefined( dmg_struct.eattacker ) || !isplayer( dmg_struct.eattacker ) )
    {
        return dmg_struct.idamage;
    }
    
    if ( dmg_struct.sweapon.basename == "sat_ww_ruby_zm" )
    {
        return dmg_struct.idamage;
    }
    
    return int( dmg_struct.idamage * ( 1 + level.zm_mode_modifiers.extradamage ) );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x11ab3bec, Offset: 0x82b1
// Size: 0x4cd
function function_47ccfdd40c528e99( params )
{
    if ( params.objweapon.basename == "sat_ww_ruby_zm" )
    {
        return;
    }
    
    waitframe();
    
    if ( params.objweapon.isdualwield )
    {
        ammo_left = self getweaponammoclip( params.objweapon, "left" );
        ammo_right = self getweaponammoclip( params.objweapon, "right" );
        
        if ( ammo_left > 0 || ammo_right > 0 )
        {
            if ( !isdefined( self.var_c57bbb4da453d754 ) )
            {
                self.var_c57bbb4da453d754 = 1;
            }
            
            if ( ammo_right <= 0 )
            {
                ammo_left = self getweaponammoclip( params.objweapon, "left" );
                
                if ( ammo_left > 0 )
                {
                    self function_b6cee937ad0428d1( params.objweapon, level.zm_mode_modifiers.extrabullets * -1, "left" );
                }
            }
            else if ( ammo_left <= 0 )
            {
                ammo_right = self getweaponammoclip( params.objweapon, "right" );
                
                if ( ammo_right > 0 )
                {
                    self function_b6cee937ad0428d1( params.objweapon, level.zm_mode_modifiers.extrabullets * -1, "right" );
                }
            }
            else if ( self.var_c57bbb4da453d754 )
            {
                self.var_c57bbb4da453d754 = 0;
                ammo_left = self getweaponammoclip( params.objweapon, "left" );
                
                if ( ammo_left > 0 )
                {
                    self function_b6cee937ad0428d1( params.objweapon, level.zm_mode_modifiers.extrabullets * -1, "left" );
                }
            }
            else if ( !self.var_c57bbb4da453d754 )
            {
                self.var_c57bbb4da453d754 = 1;
                ammo_right = self getweaponammoclip( params.objweapon, "right" );
                
                if ( ammo_right > 0 )
                {
                    self function_b6cee937ad0428d1( params.objweapon, level.zm_mode_modifiers.extrabullets * -1, "right" );
                }
            }
            
            return;
        }
        
        currentstockammo = self getweaponammostock( params.objweapon );
        newstockammo = int( max( currentstockammo - level.zm_mode_modifiers.extrabullets, 0 ) );
        self setweaponammostock( params.objweapon, newstockammo );
        return;
    }
    
    ammo = self getweaponammoclip( params.objweapon );
    var_b5890ee726834495 = level.zm_mode_modifiers.extrabullets;
    
    if ( isdefined( self.var_5f1acb83e9ba9cf9 ) && self.var_5f1acb83e9ba9cf9 == gettime() && isdefined( self.var_576b4263e3a6d501 ) && self.var_576b4263e3a6d501 == params.objweapon && params.objweapon.basename == "sat_ww_raygun_mp" )
    {
        return;
    }
    
    self.var_5f1acb83e9ba9cf9 = gettime();
    self.var_576b4263e3a6d501 = params.objweapon;
    
    if ( ammo > 0 )
    {
        if ( params.objweapon.isbolt )
        {
            wait params.objweapon.firetime;
        }
        
        self function_b6cee937ad0428d1( params.objweapon, var_b5890ee726834495 * -1 );
        newammo = self getweaponammoclip( params.objweapon );
        
        if ( newammo == 0 && self getweaponammostock( params.objweapon ) == 0 && weapon::iskillstreakweapon( params.objweapon ) )
        {
            streakinfo = self.var_f1883f6e151e0ab;
            
            if ( isdefined( streakinfo ) )
            {
                streakinfo notify( params.objweapon.basename + "_killstreak_ammo_used_all" );
            }
            else
            {
                killstreaks::removekillstreak( 1 );
            }
        }
        
        return;
    }
    
    if ( weapon::iskillstreakweapon( params.objweapon ) )
    {
        currentstockammo = self getweaponammostock( params.objweapon );
        newstockammo = int( max( currentstockammo - var_b5890ee726834495, 0 ) );
        self setweaponammostock( params.objweapon, newstockammo );
        
        if ( newstockammo == 0 )
        {
            streakinfo = self.var_f1883f6e151e0ab;
            
            if ( isdefined( streakinfo ) )
            {
                streakinfo notify( params.objweapon.basename + "_killstreak_ammo_used_all" );
                return;
            }
            
            killstreaks::removekillstreak( 1 );
            return;
        }
    }
    
    currentstockammo = self getweaponammostock( params.objweapon );
    newstockammo = int( max( currentstockammo - var_b5890ee726834495, 0 ) );
    self setweaponammostock( params.objweapon, newstockammo );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xbc03ccb8, Offset: 0x8786
// Size: 0xaa
function function_df9d58cae704cd17( overrideparams )
{
    level.zm_mode_modifiers.var_43c8defc5fca8698 = 1;
    level.var_bf82e408b7a0e3c3 = 1;
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_laststand_visibility", 0 );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x3ee6d562, Offset: 0x8838
// Size: 0x21
function function_8f7e749dccbefae7()
{
    level.zm_mode_modifiers.var_43c8defc5fca8698 = 0;
    level.var_bf82e408b7a0e3c3 = 0;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x7989d340, Offset: 0x8861
// Size: 0x42
function set_electric_fields( overrideparams )
{
    level.zm_mode_modifiers.var_d6f68a024fbc3ffe = 1;
    level thread thread_electric_fields( overrideparams );
    level callback::add( #"player_spawned", &on_player_spawned_electric_fields );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x6ebc6bab, Offset: 0x88ab
// Size: 0x2d
function disable_electric_fields()
{
    level callback::remove( #"player_spawned", &on_player_spawned_electric_fields );
    level.zm_mode_modifiers.var_d6f68a024fbc3ffe = 0;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x174a8d4d, Offset: 0x88e0
// Size: 0x24
function on_player_spawned_electric_fields( params )
{
    self.electric_field_immune = 1;
    wait 5;
    self.electric_field_immune = 0;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x56186ec1, Offset: 0x890c
// Size: 0x18c
function thread_electric_fields( overrideparams )
{
    level endon( #"game_ended" );
    wait overrideparams.var_d8738ec9cef3fcdb;
    
    while ( level.zm_mode_modifiers.var_d6f68a024fbc3ffe )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_2e9e9cd9d57e1f85 ) && isalive( player ) && !player.electric_field_immune && player val::get( "allow_movement" ) )
            {
                if ( distance2dsquared( player.origin, player.var_2e9e9cd9d57e1f85 ) < overrideparams.spawnradius * overrideparams.spawnradius )
                {
                    level thread spawn_electric_field( overrideparams, player.origin );
                }
            }
            
            player.var_2e9e9cd9d57e1f85 = player.origin;
        }
        
        wait overrideparams.var_d8738ec9cef3fcdb - 5;
        level.zm_mode_modifiers.electric_field_warning = 1;
        thread function_c34de3b091f47c3a( overrideparams );
        wait 5;
        level.zm_mode_modifiers.electric_field_warning = undefined;
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x6fc8a4fd, Offset: 0x8aa0
// Size: 0x27f
function function_c34de3b091f47c3a( overrideparams )
{
    level endon( #"game_ended" );
    
    while ( level.zm_mode_modifiers.electric_field_warning )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_2e9e9cd9d57e1f85 ) && isalive( player ) && !player.electric_field_immune && player val::get( "allow_movement" ) )
            {
                if ( distance2dsquared( player.origin, player.var_2e9e9cd9d57e1f85 ) < overrideparams.spawnradius * overrideparams.spawnradius )
                {
                    if ( !player.var_2d739e230bcaf0f4 )
                    {
                        player.var_2d739e230bcaf0f4 = 1;
                        player utility::function_7c10ea82c1e305b8( "electric_fields_fov_fx", "on" );
                        playfxontag( level._effect[ #"hash_52d0619ac30eb8c7" ], player, "tag_origin" );
                    }
                    
                    continue;
                }
                
                offstate = player.var_2d739e230bcaf0f4 ? "off_audio" : "off";
                player utility::function_7c10ea82c1e305b8( "electric_fields_fov_fx", offstate );
                player.var_2d739e230bcaf0f4 = undefined;
                stopfxontag( level._effect[ #"hash_52d0619ac30eb8c7" ], player, "tag_origin" );
            }
        }
        
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        offstate = player.var_2d739e230bcaf0f4 ? "off_audio" : "off";
        player utility::function_7c10ea82c1e305b8( "electric_fields_fov_fx", offstate );
        player.var_2d739e230bcaf0f4 = undefined;
        stopfxontag( level._effect[ #"hash_52d0619ac30eb8c7" ], player, "tag_origin" );
    }
}

// Namespace zombie_mode_modifiers
// Params 2
// Checksum 0xd82ba5dc, Offset: 0x8d27
// Size: 0x169
function spawn_electric_field( overrideparams, position )
{
    /#
    #/
    
    electric_field = spawnscriptable( %"hash_139a9d2b47751b07", position );
    players = getplayersinradius( position, overrideparams.damageradius );
    
    foreach ( player in players )
    {
        if ( !player::isreallyalive( player ) || player.electric_field_immune || !function_e6f2f9cf54d19f8( position, player ) || player.var_d1c4c78b9fb7d153 || !player val::get( "allow_movement" ) )
        {
            continue;
        }
        
        player dodamage( overrideparams.var_1fc0ceac8cf654c8, player.origin, player, undefined, "MOD_ELEMENTAL_ELEC" );
    }
    
    electric_field thread electric_field_damage( overrideparams, position );
    utility::waittill_notify_or_timeout( "cancel_all_electric_fields", overrideparams.var_66691c6b8ccdeb7b );
    
    if ( electric_field )
    {
        electric_field setscriptablepartstate( "explosion", "delete" );
        wait 1;
        electric_field freescriptable();
    }
}

// Namespace zombie_mode_modifiers
// Params 2
// Checksum 0xd0e22e, Offset: 0x8e98
// Size: 0x14f
function electric_field_damage( overrideparams, position )
{
    level endon( #"game_ended" );
    wait overrideparams.tickrate;
    
    while ( isdefined( self ) )
    {
        if ( !level.zm_mode_modifiers.var_d6f68a024fbc3ffe )
        {
            return;
        }
        
        players = getplayersinradius( position, overrideparams.damageradius );
        
        foreach ( player in players )
        {
            if ( !player::isreallyalive( player ) || player.electric_field_immune || !function_e6f2f9cf54d19f8( position, player ) || player.var_d1c4c78b9fb7d153 || !player val::get( "allow_movement" ) )
            {
                continue;
            }
            
            player dodamage( overrideparams.var_934c3232f51d2a7b, player.origin, player, undefined, "MOD_ELEMENTAL_ELEC" );
        }
        
        wait overrideparams.tickrate;
    }
}

// Namespace zombie_mode_modifiers
// Params 2, eflags: 0x4
// Checksum 0xe848e713, Offset: 0x8fef
// Size: 0x44, Type: bool
function private function_e6f2f9cf54d19f8( point, player )
{
    var_78a9bbaea0e11692 = abs( point[ 2 ] - player.origin[ 2 ] );
    
    if ( var_78a9bbaea0e11692 > 100 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x706ee7e0, Offset: 0x903c
// Size: 0xde
function set_delay_health_regen( overrideparams )
{
    level.zm_mode_modifiers.var_fc36798e78798216 = 1;
    level.zm_mode_modifiers.var_4f8488d097859883 = overrideparams.var_786c9fa7547cf486 ?? -1.5;
    
    foreach ( player in level.players )
    {
        player playerhealth::function_fd91e6d94cab77e7( #"regen_delay_relics", level.zm_mode_modifiers.var_4f8488d097859883 );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xefdffad3, Offset: 0x9122
// Size: 0xac
function disable_delay_health_regen()
{
    level.zm_mode_modifiers.var_fc36798e78798216 = 0;
    
    foreach ( player in level.players )
    {
        player playerhealth::function_c690215778ca5c25( #"regen_delay_relics" );
    }
    
    level.zm_mode_modifiers.var_4f8488d097859883 = undefined;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x65d50853, Offset: 0x91d6
// Size: 0x209
function set_no_armor( overrideparams )
{
    level.zm_mode_modifiers.var_2dc492758425fa76 = 1;
    setomnvar( "ui_show_armor_plates_crafting_bench", 0 );
    common_item::function_5734400f32ca9803( "armor", &function_59dcbcf15bc70812 );
    
    foreach ( player in level.players )
    {
        waitframe();
        player function_fc10d319e7a6226f();
    }
    
    foreach ( instance in level.contentmanager.spawnedinstances[ "wallbuy" ] )
    {
        if ( isdefined( instance.var_1d6cddfc47031bff[ "wallbuy_spawn" ] ) )
        {
            foreach ( wallbuy_spawn in instance.var_1d6cddfc47031bff[ "wallbuy_spawn" ] )
            {
                if ( isdefined( wallbuy_spawn.wallbuy_scriptable ) && wallbuy_spawn.wallbuy_scriptable.variant_type == "armor" )
                {
                    wallbuy_spawn.wallbuy_scriptable setscriptablepartstate( "wallbuy", "orange" );
                }
            }
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x9028607e, Offset: 0x93e7
// Size: 0x123
function disable_no_armor()
{
    level.zm_mode_modifiers.var_2dc492758425fa76 = undefined;
    setomnvar( "ui_show_armor_plates_crafting_bench", 1 );
    common_item::function_134b9624f3886a06( "armor", &function_59dcbcf15bc70812 );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_show_armor_global", 1 );
        params = spawnstruct();
        params.player = player;
        params.activate = 1;
        player callback::callback( "toggle_squad_armor", params );
        player wallbuy_armor::function_fdbe2cad6d8bb7e7( 1 );
        
        if ( isdefined( player.var_ff0364688a06b38a ) )
        {
            player armor::function_b359444c252374fc( player.var_ff0364688a06b38a );
            player.var_ff0364688a06b38a = undefined;
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x365a13b4, Offset: 0x9512
// Size: 0x3d
function function_59dcbcf15bc70812( params )
{
    if ( params.itembundle.subtype == "armor" )
    {
        waittillframeend();
        common_item::function_869d7676e359a627( params.item );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xe507d916, Offset: 0x9557
// Size: 0x335
function set_enemy_health_regen( overrideparams )
{
    var_786c9fa7547cf486 = overrideparams.var_786c9fa7547cf486 ?? 1;
    var_1f2e7fef2279c144 = [];
    var_1f2e7fef2279c144[ "normal" ] = {};
    var_1f2e7fef2279c144[ "normal" ].var_7df6a590dfd9d111 = overrideparams.var_1f2e7fef2279c144[ "normal" ].var_7df6a590dfd9d111 ?? 0.1;
    var_1f2e7fef2279c144[ "normal" ].var_2ebe82c4c0441f06 = overrideparams.var_1f2e7fef2279c144[ "normal" ].var_2ebe82c4c0441f06 ?? {};
    var_1f2e7fef2279c144[ "special" ] = {};
    var_1f2e7fef2279c144[ "special" ].var_7df6a590dfd9d111 = overrideparams.var_1f2e7fef2279c144[ "special" ].var_7df6a590dfd9d111 ?? 0.1;
    var_1f2e7fef2279c144[ "special" ].var_2ebe82c4c0441f06 = overrideparams.var_1f2e7fef2279c144[ "special" ].var_2ebe82c4c0441f06 ?? {};
    var_1f2e7fef2279c144[ "elite" ] = {};
    var_1f2e7fef2279c144[ "elite" ].var_7df6a590dfd9d111 = overrideparams.var_1f2e7fef2279c144[ "elite" ].var_7df6a590dfd9d111 ?? 0.1;
    var_1f2e7fef2279c144[ "elite" ].var_2ebe82c4c0441f06 = overrideparams.var_1f2e7fef2279c144[ "elite" ].var_2ebe82c4c0441f06 ?? {};
    var_1f2e7fef2279c144[ "boss" ] = {};
    var_1f2e7fef2279c144[ "boss" ].var_7df6a590dfd9d111 = overrideparams.var_1f2e7fef2279c144[ "boss" ].var_7df6a590dfd9d111 ?? 0.1;
    var_1f2e7fef2279c144[ "boss" ].var_2ebe82c4c0441f06 = overrideparams.var_1f2e7fef2279c144[ "boss" ].var_2ebe82c4c0441f06 ?? {};
    
    foreach ( aicategory_stat in var_1f2e7fef2279c144 )
    {
        foreach ( player_count in aicategory_stat.var_2ebe82c4c0441f06 )
        {
            if ( !isdefined( player_count.regenstarttime ) )
            {
                player_count.regenstarttime = 2;
            }
            
            player_count.regenstarttime *= 1000;
        }
    }
    
    level.var_4285e3e8f3754163 = 1;
    params = { #var_786c9fa7547cf486:var_786c9fa7547cf486, #var_1f2e7fef2279c144:var_1f2e7fef2279c144 };
    level thread watch_enemy_health_regen( params );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x6d25fa79, Offset: 0x9894
// Size: 0x18
function disable_enemy_health_regen()
{
    level.var_4285e3e8f3754163 = 0;
    level notify( #"hash_baf33c6f0a9e1b0f" );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x1b55f13f, Offset: 0x98b4
// Size: 0x2f4
function watch_enemy_health_regen( params )
{
    self notify( #"hash_50f97be863c39f4" );
    self endon( #"hash_50f97be863c39f4" );
    level endon( #"game_ended" );
    level endon( #"hash_baf33c6f0a9e1b0f" );
    
    while ( level.var_4285e3e8f3754163 )
    {
        var_d3bf5c32e7a64eb1 = getaiarray( zm_utility::get_zombie_team() );
        
        foreach ( enemy in var_d3bf5c32e7a64eb1 )
        {
            if ( !isdefined( level.zmModeEnemyRegen_throttle ) )
            {
                level.zmModeEnemyRegen_throttle = throttle::throttle_initialize( "zmModeEnemyRegen_throttle", 1 );
            }
            
            level throttle::throttle_wait_in_queue( level.zmModeEnemyRegen_throttle, enemy );
            
            if ( isalive( enemy ) && enemy.health < enemy.maxhealth )
            {
                aicategory = enemy.aicategory ?? "normal";
                
                if ( aicategory == "hvt" )
                {
                    aicategory = "elite";
                }
                
                health_regen_cap = int( enemy.var_d200801f77f0de0 ?? enemy.maxhealth );
                regen_start_time = params.var_1f2e7fef2279c144[ aicategory ].var_2ebe82c4c0441f06[ level.players.size - 1 ].regenstarttime;
                
                if ( isdefined( regen_start_time ) && !enemy utility::ent_flag( "zm_mod_health_regen_disable" ) && enemy.health < health_regen_cap && enemy.damagetime && gettime() > enemy.damagetime + regen_start_time )
                {
                    health_regen_perc = params.var_1f2e7fef2279c144[ aicategory ].var_7df6a590dfd9d111;
                    var_fb2f98f9e8f799fa = enemy.health;
                    new_health = minint( health_regen_cap, enemy.health + int( enemy.maxhealth * health_regen_perc ) );
                    enemy.health = new_health ?? enemy.health;
                    enemy callback::callback( "health_regenerated", { #new_health:new_health, #var_fb2f98f9e8f799fa:var_fb2f98f9e8f799fa } );
                    
                    if ( enemy.aicategory == "boss" )
                    {
                        level callback::callback( "on_boss_progress_updated", { #maxhealth:enemy.maxhealth, #health:new_health } );
                    }
                }
            }
        }
        
        wait params.var_786c9fa7547cf486;
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x4a59d122, Offset: 0x9bb0
// Size: 0xcd
function set_no_arsenal()
{
    level.zm_mode_modifiers.var_e07d21157dd37afb = 1;
    level utility::flag_wait( "arsenal_ready" );
    
    foreach ( s_arsenal_info in level.var_52e94a468e66d601 )
    {
        s_arsenal_info function_813d8e8074464c87();
    }
    
    if ( !level callback::exists( #"hash_4748a46076e129e0", &function_8fc70260b6ecd80f ) )
    {
        level callback::add( #"hash_4748a46076e129e0", &function_8fc70260b6ecd80f );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x3adfd748, Offset: 0x9c85
// Size: 0x16d
function disable_no_arsenal()
{
    level.zm_mode_modifiers.var_e07d21157dd37afb = 0;
    level utility::flag_wait( "arsenal_ready" );
    
    foreach ( s_arsenal_info in level.var_52e94a468e66d601 )
    {
        playfx( level._effect[ #"hash_e6eca969a60a9d62" ], s_arsenal_info.mdl_arsenal.origin );
        s_arsenal_info utility::callsharedfunc( #"arsenal", #"enable_arsenal", 1 );
        s_arsenal_info.mdl_arsenal.interact function_e203bba36cfb19d0();
        s_arsenal_info.mdl_arsenal.b_forced_off_model = undefined;
        
        if ( s_arsenal_info.mdl_arsenal.mr_peeks_disable )
        {
            s_arsenal_info.mdl_arsenal.mr_peeks_disable freescriptable();
        }
    }
    
    if ( level callback::exists( #"hash_4748a46076e129e0", &function_8fc70260b6ecd80f ) )
    {
        level callback::remove( #"hash_4748a46076e129e0", &function_8fc70260b6ecd80f );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xd8865dbb, Offset: 0x9dfa
// Size: 0x161
function function_813d8e8074464c87()
{
    playfx( level._effect[ #"hash_e6eca969a60a9d62" ], self.mdl_arsenal.origin );
    utility::callsharedfunc( #"arsenal", #"disable_arsenal", 1, 1 );
    pos = self.mdl_arsenal.origin + anglestoforward( self.mdl_arsenal.angles ) * 20 + ( 0, 0, 31 );
    angles = self.mdl_arsenal.angles - ( 0, 90, 10 );
    
    if ( !self.mdl_arsenal.mr_peeks_disable )
    {
        self.mdl_arsenal.mr_peeks_disable = spawnscriptable( %"sat_zm_mr_peeks_disabled", pos, angles );
        self.mdl_arsenal.mr_peeks_disable thread function_88046eb9464afac6( self.mdl_arsenal );
    }
    
    self.mdl_arsenal.interact function_7653c765b6c7b815();
    waitframe();
    self.mdl_arsenal setmodel( %"sat_zm_weapon_machine_off_fxanim_relic" );
    self.mdl_arsenal.b_forced_off_model = 1;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xcad6412d, Offset: 0x9f63
// Size: 0x2e
function function_8fc70260b6ecd80f( params )
{
    if ( !level.zm_mode_modifiers.var_e07d21157dd37afb )
    {
        return;
    }
    
    wait 2;
    function_813d8e8074464c87();
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x38b894ed, Offset: 0x9f99
// Size: 0x5e
function function_aa4686f6b37cd86d()
{
    if ( !isdefined( level.var_71b6079fc23545cd ) )
    {
        level.var_71b6079fc23545cd = &function_a35b515309ed4c69;
    }
    
    setomnvar( "ui_show_killstreaks", 0 );
    function_b35451878ed8b4b9( #"killstreak" );
    common_item::function_e08da1075e1758ef( "killstreak", &function_3c1c8d8f71005ba5 );
    level callback::add( #"hash_8e2728470d1fa87a", &function_55d3d1d98d7e61a2 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x57b7dbf8, Offset: 0x9fff
// Size: 0x45
function function_2561eb7557877d()
{
    setomnvar( "ui_show_killstreaks", 1 );
    function_c64c9bc5ccd7270e( #"killstreak" );
    common_item::function_134b9624f3886a06( "killstreak", &function_3c1c8d8f71005ba5 );
    level callback::remove( #"hash_8e2728470d1fa87a", &function_55d3d1d98d7e61a2 );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xb484245d, Offset: 0xa04c
// Size: 0x6e
function function_3c1c8d8f71005ba5( params )
{
    waittillframeend();
    
    if ( params.item.var_e78811eec0c27aa )
    {
        return;
    }
    
    if ( params.spawnoptions.spawningentity && isplayer( params.spawnoptions.spawningentity ) )
    {
        return;
    }
    
    common_item::function_869d7676e359a627( params.item );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xc059bf3d, Offset: 0xa0c2
// Size: 0x2a, Type: bool
function function_55d3d1d98d7e61a2( params )
{
    if ( common_item::function_16e8c106491eeaca( params.itembundle ) == "killstreak" )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x1ba2478d, Offset: 0xa0f5
// Size: 0x13
function set_zombies_explode_on_death()
{
    callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed_explode_death );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xadfa8dbe, Offset: 0xa110
// Size: 0x13
function function_7c445ae2fe3f2291()
{
    callback::remove( "on_zombie_ai_killed", &on_zombie_ai_killed_explode_death );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xa9114c70, Offset: 0xa12b
// Size: 0x23f
function on_zombie_ai_killed_explode_death( params )
{
    origin = self.origin;
    angles = self.angles;
    radius = 100;
    
    if ( !utility::function_1b9fac8cf533a8ae( origin ) )
    {
        return;
    }
    
    damaged_players = getplayersinradius( origin, radius );
    
    if ( utility::cointoss() )
    {
        self playsound( #"evt_zm_core_powerup_nuke_soul" );
    }
    
    damage = 80;
    
    foreach ( player in damaged_players )
    {
        damage += player.armorhealth * 0.1;
        player dodamage( damage, origin, self, self, "MOD_EXPLOSIVE" );
    }
    
    potential_targets = getaiarrayinradius( origin, radius );
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) || target == self )
        {
            continue;
        }
        
        if ( !target utility::callsharedfunc( #"zombie", #"iszombieinknockdown" ) )
        {
            target utility::callsharedfunc( #"zombie", #"knockdownzombie", origin );
        }
    }
    
    wait 0.2;
    corpse = self getcorpseentity();
    
    if ( corpse && corpse getscriptablehaspart( "r_mod_cr_explode" ) )
    {
        corpse utility::function_7c10ea82c1e305b8( "r_mod_cr_explode", "explode_on" );
        return;
    }
    
    explosion_vfx = spawnscriptable( %"zm_sat_mantis_cr_z_explode", origin, angles );
    wait 1;
    
    if ( explosion_vfx )
    {
        explosion_vfx freescriptable();
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x3c3e1125, Offset: 0xa372
// Size: 0x33
function set_perk_machines_give_random_perks()
{
    level utility::registersharedfunc( #"perk_machine", #"hash_41ac71b59679409c", &function_7f27bbb1d1722e67 );
    level.var_3ae3959c37a85611 = 1;
    set_perk_machine_effects();
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xa544165b, Offset: 0xa3ad
// Size: 0x32
function function_b4f14329fffc472()
{
    level utility::clearsharedfunc( #"perk_machine", #"hash_41ac71b59679409c" );
    level.var_3ae3959c37a85611 = undefined;
    level notify( #"hash_57459154b9c4e898" );
}

// Namespace zombie_mode_modifiers
// Params 4
// Checksum 0x629b7e08, Offset: 0xa3e7
// Size: 0x15d
function function_7f27bbb1d1722e67( usable, perk_root, var_4c22addfe5b4f20e, hint_data )
{
    var_4c22addfe5b4f20e = zombie_perks::function_77331fd62580dd0a();
    
    if ( currency::can_afford( currency::get_perk_machine_currency( usable.script_notify ), var_4c22addfe5b4f20e ) )
    {
        hint_data.aux_text = undefined;
        hint_data.interactable = 1;
        hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
    }
    else
    {
        hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        hint_data.interactable = 0;
    }
    
    override_data = { #interactable:hint_data.interactable, #aux_text:hint_data.aux_text, #icon_text_value:var_4c22addfe5b4f20e, #var_776a268784e089af:hint_data.var_776a268784e089af, #buttoncallout:hint_data.buttoncallout, #icon:"sat_ui_icon_gamemode_zm_cursed_relics", #description:&"zm_sat_r_mod/dancing_arnie_modifier", #title:&"zm_sat_r_mod/r_mod", #type:"HINT_BUTTON" };
    return override_data;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x1675edfa, Offset: 0xa54d
// Size: 0x13b
function set_perk_machine_effects()
{
    foreach ( perk_machine in level.a_s_perk_machines )
    {
        if ( isdefined( perk_machine.mdl_perk_machine.origin ) )
        {
            offset_val = 5;
            
            if ( perk_machine.script_noteworthy == "specialty_vulture_aid" )
            {
                offset_val = 10;
            }
            
            forward = anglestoforward( perk_machine.mdl_perk_machine.angles );
            mdl_fx = utility::spawn_model( "tag_origin", perk_machine.mdl_perk_machine.origin + forward * offset_val, perk_machine.mdl_perk_machine.angles );
            playfxontag( level._effect[ "relic_perk_machines_give_random_perks" ], mdl_fx, "tag_origin" );
            level thread function_885f4ed7679991ee( mdl_fx );
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xbfe0db67, Offset: 0xa690
// Size: 0x40
function function_885f4ed7679991ee( mdl_perk_machine )
{
    level endon( #"game_ended" );
    level waittill( #"hash_57459154b9c4e898" );
    stopfxontag( level._effect[ "relic_perk_machines_give_random_perks" ], mdl_perk_machine, "tag_origin" );
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x9cbb752f, Offset: 0xa6d8
// Size: 0xc5
function set_randomize_wallbuys( params )
{
    level.zm_mode_modifiers.var_15a59900eb1cb459 = 1;
    
    if ( !isdefined( level.zm_mode_modifiers.var_baa2e34a68beadf7 ) )
    {
        level.zm_mode_modifiers.var_baa2e34a68beadf7 = {};
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ebfc84c1ca50cc8 ) )
    {
        level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ebfc84c1ca50cc8 = [];
    }
    
    callback::add( "on_round_end", &function_f6753d2bfe7c179 );
    
    if ( !level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ad30efe2c82ab0e )
    {
        function_4500b47b7ef6fa87();
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xcf2f7aa3, Offset: 0xa7a5
// Size: 0x32
function disable_randomize_wallbuys( params )
{
    level.zm_mode_modifiers.var_15a59900eb1cb459 = 0;
    callback::remove( "on_round_end", &function_f6753d2bfe7c179 );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xe36ae5e, Offset: 0xa7df
// Size: 0x125
function function_4500b47b7ef6fa87()
{
    level.zm_mode_modifiers.var_baa2e34a68beadf7.a_small_weapons = [];
    level.zm_mode_modifiers.var_baa2e34a68beadf7.var_da8406a264206513 = [];
    level.zm_mode_modifiers.var_baa2e34a68beadf7.var_44fe80e13024a397 = [];
    level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ad30efe2c82ab0e = 1;
    
    foreach ( key, var_b87c8459d148bf6a in level.var_c9c6c666b81696b6 )
    {
        size = function_e1ed1cd5e0b119fc( var_b87c8459d148bf6a.weaponclass, key );
        array_to_add = function_3fbf88d04391fe5b( size );
        array_to_add[ array_to_add.size ] = var_b87c8459d148bf6a;
    }
}

// Namespace zombie_mode_modifiers
// Params 2
// Checksum 0x4ee2398e, Offset: 0xa90c
// Size: 0x103
function function_e1ed1cd5e0b119fc( weapon_class, weapon_root_name )
{
    if ( weapon_root_name )
    {
        switch ( weapon_root_name )
        {
            case %"sat_ar_falcon":
                return "small";
            default:
                break;
        }
    }
    
    switch ( weapon_class )
    {
        case #"hash_719417cb1de832b6":
            return "small";
        case #"hash_2f2d546c2247838f":
            return "large";
        case #"hash_ba39cac9c099d4f1":
            return "large";
        case #"hash_fa41bcf6bd77c363":
            return "large";
        case #"hash_fa18d2f6bd57925a":
            return "medium";
        case #"hash_40a94c5d9e4e265b":
            return "small";
        case #"hash_900cb96c552c5e8e":
            return "small";
        case #"hash_23209741b93850b5":
            return "medium";
        case #"hash_6191aaef9f922f96":
            return "large";
        default:
            return "large";
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xaff50b1e, Offset: 0xaa17
// Size: 0xbe
function function_3fbf88d04391fe5b( size )
{
    switch ( size )
    {
        case #"hash_5971965ed985a26c":
            return level.zm_mode_modifiers.var_baa2e34a68beadf7.a_small_weapons;
        case #"hash_c71b112fe04823d6":
            return level.zm_mode_modifiers.var_baa2e34a68beadf7.var_da8406a264206513;
        case #"hash_4bf33d595d8f4894":
            return level.zm_mode_modifiers.var_baa2e34a68beadf7.var_44fe80e13024a397;
        default:
            return level.zm_mode_modifiers.var_baa2e34a68beadf7.var_44fe80e13024a397;
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0xd86f0c1d, Offset: 0xaadd
// Size: 0x29b
function private function_f6753d2bfe7c179( params )
{
    if ( !level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ebfc84c1ca50cc8.size > 0 )
    {
        level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ebfc84c1ca50cc8 = function_89b2528b4a999090();
    }
    
    foreach ( wallbuy_struct in level.var_caf65b937e9cbfaf )
    {
        if ( wallbuy_struct.wallbuy_scriptable.var_8f971982b0ee9b70 )
        {
            continue;
        }
        
        new_wallbuy_name = wallbuy_struct.wallbuy_scriptable function_4a5ae3337908b874();
        
        if ( new_wallbuy_name && !isdefined( wallbuy_struct.wallbuy_scriptable.disable_upgrade ) )
        {
            if ( !wallbuy_struct.var_30d9a555b66585b9 )
            {
                wallbuy_struct.var_30d9a555b66585b9 = wallbuy_struct.script_noteworthy;
            }
            
            rarity = wallbuy_struct.wallbuy_scriptable.rarity;
            
            if ( wallbuy_struct.wallbuy_scriptable )
            {
                wallbuy_struct.wallbuy_scriptable freescriptable();
                
                if ( wallbuy_struct.wallbuy_scriptable.var_5499b4433cb4a919 )
                {
                    wallbuy_struct.wallbuy_scriptable.var_5499b4433cb4a919 delete();
                }
            }
            
            wallbuy_struct.script_noteworthy = new_wallbuy_name;
            wallbuy_struct utility::callsharedfunc( #"wallbuy", #"hash_d188728d6e7395f5", wallbuy_struct, rarity );
            
            if ( wallbuy_struct.wallbuy_scriptable && wallbuy_struct.script_noteworthy != wallbuy_struct.var_30d9a555b66585b9 )
            {
                function_8aee443ce950d61d( wallbuy_struct );
            }
            
            if ( wallbuy_struct.wallbuy_scriptable )
            {
                fxdir = anglestoright( wallbuy_struct.wallbuy_scriptable.angles );
                updir = anglestoup( wallbuy_struct.wallbuy_scriptable.angles );
                playfx( utility::getfx( "vfx_wallbuy_upgrade" ), wallbuy_struct.wallbuy_scriptable.origin, fxdir, updir );
            }
        }
        
        waitframe();
    }
    
    level callback::callback( #"hash_6e3acfc32f60c580" );
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xc5cd114a, Offset: 0xad80
// Size: 0xb1
function function_89b2528b4a999090()
{
    excluded_weapons = [];
    
    foreach ( wallbuy_struct in level.var_caf65b937e9cbfaf )
    {
        if ( wallbuy_struct.wallbuy_scriptable.var_8f971982b0ee9b70 )
        {
            excluded_weapons[ wallbuy_struct.wallbuy_scriptable.weapon ] = 1;
        }
    }
    
    return excluded_weapons;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xd9227c9, Offset: 0xae3a
// Size: 0xf7
function function_4a5ae3337908b874()
{
    wallbuy_chosen = self.weapon;
    choices = 0;
    
    while ( wallbuy_chosen == self.weapon && choices < 20 )
    {
        weapon_entry = level.var_c9c6c666b81696b6[ self.weapon_root_name ];
        size = function_e1ed1cd5e0b119fc( weapon_entry.weaponclass, self.weapon_root_name );
        var_f099280d3e9d85d7 = function_3fbf88d04391fe5b( size );
        chosen_struct = utility::array_random( var_f099280d3e9d85d7 );
        
        if ( chosen_struct.wallbuyscriptable )
        {
            wallbuy_chosen = chosen_struct.weapon;
            
            if ( wallbuy_chosen && level.zm_mode_modifiers.var_baa2e34a68beadf7.var_4ebfc84c1ca50cc8[ wallbuy_chosen ] )
            {
                wallbuy_chosen = self.weapon;
            }
        }
        
        choices++;
        waitframe();
    }
    
    return wallbuy_chosen;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x3ad6a6af, Offset: 0xaf3a
// Size: 0x377
function function_8aee443ce950d61d( wallbuy_struct )
{
    switch ( wallbuy_struct.script_noteworthy )
    {
        case #"hash_22ac67dc9e7defc9":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoup( wallbuy_struct.wallbuy_scriptable.angles ) * 2;
            break;
        case #"hash_e1d28935c783b478":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoup( wallbuy_struct.wallbuy_scriptable.angles ) * 2;
            break;
        case #"hash_dd56d3e8fbf49ef0":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoup( wallbuy_struct.wallbuy_scriptable.angles ) * -1 + anglestoforward( wallbuy_struct.wallbuy_scriptable.angles ) * 7;
            break;
        case #"hash_4aa9cc5005d6af5f":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoforward( wallbuy_struct.wallbuy_scriptable.angles ) * 2;
            break;
        case #"hash_147fbfa420fffdf7":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoforward( wallbuy_struct.wallbuy_scriptable.angles ) * 3 + anglestoright( wallbuy_struct.wallbuy_scriptable.angles ) * 1;
            break;
        case #"hash_d2c7ec717bbf7d7c":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoforward( wallbuy_struct.wallbuy_scriptable.angles ) * 3;
            break;
        case #"hash_47ff7b6685837679":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoforward( wallbuy_struct.wallbuy_scriptable.angles ) * 3 + anglestoright( wallbuy_struct.wallbuy_scriptable.angles ) * 1;
            break;
        case #"hash_204f8d47ab7c6dde":
            wallbuy_struct.wallbuy_scriptable.origin += anglestoforward( wallbuy_struct.wallbuy_scriptable.angles ) * 5 + anglestoup( wallbuy_struct.wallbuy_scriptable.angles ) * 1 + anglestoright( wallbuy_struct.wallbuy_scriptable.angles ) * 1;
            break;
        default:
            break;
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x9619a38d, Offset: 0xb2b9
// Size: 0x261
function set_only_critical_damage()
{
    level.zm_mode_modifiers.var_ec86147eb5afdfe = 1;
    
    if ( !isdefined( level.zm_mode_modifiers.var_26d1ac1d9963c5ba ) )
    {
        level.zm_mode_modifiers.var_26d1ac1d9963c5ba = {};
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_b3c8a091451e9502 ) )
    {
        level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_b3c8a091451e9502 = [];
    }
    
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_b3c8a091451e9502[ %"sat_ww_locust_fireball" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_b3c8a091451e9502[ %"sat_ww_firefly_liquid_zm" ] = 1;
    
    if ( !isdefined( level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778 ) )
    {
        level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778 = [];
    }
    
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_galileo" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_galileo_drone" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_wither" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_wither_shadow" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_wither_bomb" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_wither_shadow_mq" ] = 1;
    level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ "settings_zombie_wither_scpq" ] = 1;
    function_9c9da0455f2c2a45( "only_critical_dmg", &function_309ee76ffd6083c2 );
    
    if ( !callback::exists( "on_zombie_ai_spawned", &function_fd06eebce17d06ae ) )
    {
        level callback::add( "on_zombie_ai_spawned", &function_fd06eebce17d06ae );
    }
    
    level.var_cdca5e730e05bc39 = 1;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x6dd3ff0c, Offset: 0xb522
// Size: 0xe1
function function_c773e3123015f85d()
{
    level.zm_mode_modifiers.var_ec86147eb5afdfe = 0;
    function_d7f9a944fe0b5fd9( "only_critical_dmg" );
    
    if ( callback::exists( "on_zombie_ai_spawned", &function_fd06eebce17d06ae ) )
    {
        level callback::remove( "on_zombie_ai_spawned", &function_fd06eebce17d06ae );
    }
    
    level.var_cdca5e730e05bc39 = 0;
    var_d3bf5c32e7a64eb1 = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in var_d3bf5c32e7a64eb1 )
    {
        if ( isalive( zombie ) )
        {
            zombie function_908a1b8613e50514();
        }
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xdfd718cb, Offset: 0xb60b
// Size: 0x271
function function_309ee76ffd6083c2( dmg_struct )
{
    if ( !self )
    {
        return dmg_struct.idamage;
    }
    
    if ( !isent( self ) || !isagent( self ) )
    {
        return dmg_struct.idamage;
    }
    
    is_ignored_weapon = dmg_struct.sweapon.basenamehash && level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_b3c8a091451e9502[ dmg_struct.sweapon.basenamehash ];
    is_trap_dmg = dmg_struct.einflictor.targetname == "trap_attacker" || dmg_struct.eattacker.targetname == "trap_attacker";
    is_invalid_attacker = ( dmg_struct.eattacker.classname == "script_vehicle" || dmg_struct.einflictor.classname == "script_vehicle" || dmg_struct.eattacker.classname == "script_origin" ) && !dmg_struct.einflictor.streakinfo;
    
    if ( self.zombieaisetting && isstring( self.zombieaisetting ) )
    {
        is_invalid_ai = level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ self.zombieaisetting ] ?? 0;
    }
    
    if ( !dmg_struct.biscritical && self.aicategory != "boss" && !weapon::function_3e8739d232e1b023( dmg_struct.sweapon ) && !is_ignored_weapon && !is_invalid_ai && !is_trap_dmg && !is_invalid_attacker )
    {
        if ( dmg_struct.metabonename )
        {
            function_908a1b8613e50514();
            utility::callsharedfunc( #"zombie_damage", #"damagemetabone", dmg_struct );
            dmg_struct.idamage = 1;
        }
        else
        {
            dmg_struct.idamage *= 0;
            set_zombie_damage_invuln();
        }
    }
    else
    {
        function_908a1b8613e50514();
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0xf7cd0d5a, Offset: 0xb885
// Size: 0x134
function set_zombie_damage_invuln()
{
    if ( self.magic_bullet_shield )
    {
        return;
    }
    
    if ( self.b_cleanup_no_respawn || self.var_825b17c932865df || self.var_15598d8e493afe88 || self.ignore_enemy_count )
    {
        return;
    }
    
    if ( self.zombieaisetting && isstring( self.zombieaisetting ) )
    {
        if ( level.zm_mode_modifiers.var_26d1ac1d9963c5ba.var_4e4d555d3a43a778[ self.zombieaisetting ] )
        {
            return;
        }
    }
    
    if ( !self || !isent( self ) || !isagent( self ) || utility::ent_flag( "scene_active" ) || val::get( "death" ) == 0 || self.aifrozen )
    {
        return;
    }
    
    if ( isalive( self ) && !self.var_698cf8d8d4a8cbb9 && self.aicategory != "boss" )
    {
        val::set( "relic_damage_shield", "ignore_blackhole_bomb", 1 );
        val::set( "relic_damage_shield", "shadow_rift_lethal_tele_immune", 1 );
        val::set( "relic_damage_shield", "ignore_instakill_powerup", 1 );
    }
}

// Namespace zombie_mode_modifiers
// Params 0
// Checksum 0x31c6c7ca, Offset: 0xb9c1
// Size: 0x39
function function_908a1b8613e50514()
{
    if ( self )
    {
        val::reset( "relic_damage_shield", "ignore_blackhole_bomb" );
        val::reset( "relic_damage_shield", "shadow_rift_lethal_tele_immune" );
        val::reset( "relic_damage_shield", "ignore_instakill_powerup" );
    }
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0x4
// Checksum 0x1f17fb80, Offset: 0xba02
// Size: 0x13
function private function_fd06eebce17d06ae( params )
{
    set_zombie_damage_invuln();
}

// Namespace zombie_mode_modifiers
// Params 2
// Checksum 0x83a816b8, Offset: 0xba1d
// Size: 0x93
function function_9c9da0455f2c2a45( ref, func )
{
    if ( !utility::issharedfuncdefined( #"zombie", #"hash_890056d50c508463" ) )
    {
        level utility::registersharedfunc( #"zombie", #"hash_890056d50c508463", &function_48ba8880f1d3aff4 );
    }
    
    if ( !isdefined( level.zm_mode_modifiers.var_83a9c9e74a7ba60d ) )
    {
        level.zm_mode_modifiers.var_83a9c9e74a7ba60d = [];
    }
    
    level.zm_mode_modifiers.var_83a9c9e74a7ba60d[ ref ] = func;
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0x18899627, Offset: 0xbab8
// Size: 0x54
function function_d7f9a944fe0b5fd9( ref )
{
    level.zm_mode_modifiers.var_83a9c9e74a7ba60d[ ref ] = undefined;
    
    if ( !level.zm_mode_modifiers.var_83a9c9e74a7ba60d.size )
    {
        level utility::clearsharedfunc( #"zombie", #"hash_890056d50c508463" );
    }
}

// Namespace zombie_mode_modifiers
// Params 1
// Checksum 0xeaf3c7a2, Offset: 0xbb14
// Size: 0xc7
function function_48ba8880f1d3aff4( dmg_struct )
{
    if ( isdefined( self ) && level.zm_mode_modifiers.var_83a9c9e74a7ba60d.size )
    {
        foreach ( func in level.zm_mode_modifiers.var_83a9c9e74a7ba60d )
        {
            if ( isdefined( func ) )
            {
                dmg_struct.idamage = self [[ func ]]( dmg_struct );
            }
        }
    }
    
    return dmg_struct.idamage;
}

// Namespace zombie_mode_modifiers
// Params 1, eflags: 0xc
// Checksum 0x2279cf64, Offset: 0xbbe4
// Size: 0x61
function private function_88046eb9464afac6( parent )
{
    self notify( #"hash_b72aef52e0718b26" );
    self endon( #"hash_b72aef52e0718b26" );
    level endon( #"game_ended" );
    parent waittill( #"death" );
    
    if ( parent.mr_peeks_disable )
    {
        parent.mr_peeks_disable = undefined;
    }
    
    if ( self )
    {
        self freescriptable();
    }
}

/#

    // Namespace zombie_mode_modifiers
    // Params 0
    // Checksum 0x931bf6d9, Offset: 0xbc4d
    // Size: 0x89, Type: dev
    function function_d165ef11386fd51f()
    {
        wait 2;
        devgui::function_9082edeb5db93280( "<dev string:xa6>" );
        devgui::add_devgui_func( "<dev string:xbc>", "<dev string:xeb>", &function_5312e80b617dd8ae );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10b>", "<dev string:x137>", &function_1a3142f5ef426036 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x159>", "<dev string:x184>", &function_1a3142f5ef426036 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a5>", "<dev string:x1d0>", &function_1a3142f5ef426036 );
        devgui::add_devgui_func( "<dev string:x1f1>", "<dev string:x21b>", &function_d6e0fa6c60598dee );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_mode_modifiers
    // Params 0
    // Checksum 0x72617272, Offset: 0xbcde
    // Size: 0xc, Type: dev
    function function_d6e0fa6c60598dee()
    {
        function_f6753d2bfe7c179();
    }

    // Namespace zombie_mode_modifiers
    // Params 0
    // Checksum 0xcb57a07f, Offset: 0xbcf2
    // Size: 0xe2, Type: dev
    function function_5312e80b617dd8ae()
    {
        var_d3bf5c32e7a64eb1 = getaiarray( zm_utility::get_zombie_team() );
        level.var_a0629ddff32e30e3 = !level.var_a0629ddff32e30e3;
        
        foreach ( enemy in var_d3bf5c32e7a64eb1 )
        {
            if ( isalive( enemy ) )
            {
                if ( level.var_a0629ddff32e30e3 )
                {
                    enemy utility::ent_flag_set( "<dev string:x239>" );
                    continue;
                }
                
                enemy utility::ent_flag_clear( "<dev string:x239>" );
            }
        }
        
        iprintlnbold( "<dev string:x255>" + string( !level.var_a0629ddff32e30e3 ) );
    }

    // Namespace zombie_mode_modifiers
    // Params 1
    // Checksum 0x200f98da, Offset: 0xbddc
    // Size: 0xde, Type: dev
    function function_1a3142f5ef426036( params )
    {
        var_d3bf5c32e7a64eb1 = getaiarray( zm_utility::get_zombie_team() );
        cap_perc = int( params[ 0 ] );
        cap_perc *= 0.01;
        
        foreach ( enemy in var_d3bf5c32e7a64eb1 )
        {
            if ( isalive( enemy ) )
            {
                enemy.var_d200801f77f0de0 = enemy.maxhealth * cap_perc;
            }
        }
        
        iprintlnbold( "<dev string:x273>" + params[ 0 ] + "<dev string:x291>" );
    }

#/
