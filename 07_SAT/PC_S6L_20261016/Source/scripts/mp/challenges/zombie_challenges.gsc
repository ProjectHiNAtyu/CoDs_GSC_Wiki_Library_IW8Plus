// scripts\mp\challenges\zombie_challenges.gsc  (hash_76cd7ded40cbb9ae.gscc) (size: 62645 Bytes / 0xf4b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xecef2951 (3975096657)
// size ...... 62645 (0xf4b5)
// includes .. 20  (offset: 0xee65)
// strings ... 102 (offset: 0xef05)
// dev strs .. 11  (offset: 0xf41d)
// exports ... 117 (offset: 0xb495)
// cseg ...... 0x8eb + 0xabaa (0xb495)
// imports ... 224 (offset: 0xc6dd)
// animtree1 . 0   (offset: 0xf4b5)
// animtree2 . 0   (offset: 0xf4b5)
#using script_16ea1b94f0f381b3;
#using script_7fb33ffa16b6839a;
#using scripts\common\ae_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\systems\zone_manager;

#namespace zombie_challenges;

// Namespace zombie_challenges
// Params 0, eflags: 0x5
// Checksum 0xc7e4093e, Offset: 0x909
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_7305513195fadf7e", undefined, &init_zombie_challenges, undefined );
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x291ed605, Offset: 0x92a
// Size: 0x17
function init_zombie_challenges()
{
    level thread post_init_zombie_challenges();
    level utility::flag_init( "zm_challenges_initialized" );
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x9061ed9a, Offset: 0x949
// Size: 0x60a
function post_init_zombie_challenges()
{
    level endon( #"game_ended" );
    wait 1;
    
    if ( !challenges::challengesenabled() )
    {
        return;
    }
    
    level.var_78b06bc85775ee0 = [];
    level.var_73d6fa41113ea1a8 = [];
    level.var_495da479d5fbbec7 = 1;
    callback::add( "magicbox_purchase", &function_bdcc5e9dfecd8a55 );
    callback::add( #"on_magicbox_melee_share", &function_9e54e5130f31aa82 );
    callback::add( "wallbuy_purchase", &function_b17e1618d76e2537 );
    callback::add( #"on_ai_killed", &function_4dbc0f4c240c401e );
    callback::add( #"player_item_pickup", &report_on_item_pickup );
    callback::add( "loot_crystal_destroyed", &loot_crystal_destroyed );
    callback::add( "on_pap_machine_purchase", &report_on_pap_machine_purchase );
    callback::add( "zm_packed_weapon", &function_9f675ac37fb9cc33 );
    callback::add( "ammomod_proc", &function_7c5758499baefdf5 );
    callback::add( "special_ammomod_proc", &function_7c5758499baefdf5 );
    callback::add( "zm_exfil_success", &function_d138191ce239a10b );
    callback::add( "on_soldier_ai_damaged", &function_b5178a27f638123b );
    callback::add( "on_zombie_ai_damaged", &function_b5178a27f638123b );
    callback::add( "zm_perk_purchased", &function_c539cf5c6db3329b );
    callback::add( "on_powerup_pickup", &report_on_powerup_pickup );
    callback::add( "on_round_start", &report_on_round_start );
    callback::add( "on_round_end", &report_on_round_end );
    callback::add( #"player_used_item", &function_4926a00c84ab47ba );
    callback::add( "on_rapid_kill_end", &report_multikill );
    callback::add( "zm_perk_obtained", &function_e15a297978fd0e62 );
    callback::add( "doorbuy_bought", &report_door_bought );
    callback::add( "wallbuy_armor_purchased", &function_d2f4b465ee4f4d0f );
    callback::add( "doorbuy_contributed", &report_door_bought );
    callback::add( "arsenal_craft_weapon_tier", &function_79b4c95960d83f1 );
    callback::add( "arsenal_craft_ammo_mod", &function_79b4c95960d83f1 );
    callback::add( "on_crafting_item_success", &function_63cb1b56d737b4ce );
    callback::add( #"zm_mq_quest_complete", &function_4fc593c58798bebd );
    callback::add( "zm_sq_quest_complete", &function_4fc593c58798bebd );
    callback::add( "zm_super_ee_quest_complete", &function_4fc593c58798bebd );
    callback::add( "zm_ee_quest_complete", &function_4fc593c58798bebd );
    callback::add( "sam_trial_end", &report_sam_trial_end );
    callback::add( "tedd_task_end", &report_sam_trial_end );
    callback::add( #"hash_476fcd5501956e2c", &report_intel_collected );
    callback::add( "on_essence_gained", &on_essence_gained );
    callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    callback::add( #"on_used_super", &on_start_field_upgrade );
    callback::add( #"on_super_use_finished", &on_end_field_upgrade );
    callback::add( "zm_ee_discovered", &function_16cada0ca12d7ba1 );
    callback::add( "killstreak_end", &on_killstreak_end );
    callback::add( "killstreak_equipped", &on_killstreak_equipped );
    callback::add( "ammo_mod_equipped", &on_ammo_mod_equipped );
    callback::add( #"player_damaged", &on_player_damaged );
    callback::add( #"player_laststand", &function_3a1defe7d6d76819 );
    callback::add( #"player_connect", &on_player_connect );
    callback::add( "on_player_augment_given", &on_player_augment_given );
    callback::add( "on_gobblegum_activated", &on_gobblegum_activated );
    callback::add( "blackhole_bomb_end", &function_f58ffb28c637144d );
    callback::add( #"hash_a6fef0a8a142afb1", &function_56b999378fe58366 );
    callback::add( "powerup_insta_kill_end", &on_powerup_insta_kill_end );
    callback::add( "on_gobblegum_consumed", &on_gobblegum_consumed );
    callback::add( #"anywhere_but_here_kill", &function_3306064ab1dbaa74 );
    callback::add( #"hash_ba09e0678d865ab6", &function_4d1a7ca08f8d6c4f );
    callback::add( #"hash_24c992da2403a55e", &function_c1e782d2b1efc015 );
    callback::add( #"hash_ab8dca76e6e4b303", &function_c1e782d2b1efc015 );
    callback::add( #"hash_342f380b82a1456a", &function_af7d3364b83e2d2d );
    callback::add( #"hash_f994b5010602c07d", &function_4d5ce745868a7fd6 );
    callback::add( "on_rapid_kill_counted", &function_c67ef634ef9b96d3 );
    callback::add( #"hash_eee96f780807d870", &function_704e55c96eef0c91 );
    callback::add( #"medal_earned", &function_b014cc2869194602 );
    callback::add( "on_weapon_rarity_set_complete", &on_set_weapon_rarity );
    callback::add( "ammo_cache_used", &function_f53d30e3d2841fc9 );
    callback::add( "zone_changed", &function_ae049c12c2d76943 );
    callback::add( #"relics_activated", &function_c2d2c5e8d279228 );
    callback::add( #"relics_deactivated", &function_c2d2c5e8d279228 );
    callback::add( #"hash_bc5df80f274f1e34", &function_d0d158594d322667 );
    callback::add( "zombie_score_event", &on_score_event );
    callback::add( "usurped_power_deploying", &on_usurped_power_deploying );
    callback::add( #"store_chompy_purchase", &store_chompy_purchase );
    zombie_utils::function_dfae6a5bd222c586( &function_a9403b28b7a4ae8e );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"get_zm_map_name_bit", &get_zm_map_name_bit );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"hash_134d493924be6c4", &function_71dd86fcdbbdd5ef );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"hash_15800b43a7bb4ab8", &function_37e122b643059d9 );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"hash_9d1f38c29e4aa24a", &function_418c0f0bce7d095b );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", &function_a482047f6afd7f23 );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"hash_1ecbe1cb707c4156", &function_19ce2b86e77773b7 );
    utility::registersharedfunc( #"hash_7305513195fadf7e", #"hash_87e01be9659e3568", &function_39299860f4a62121 );
    level utility::flag_set( "zm_challenges_initialized" );
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xd279586e, Offset: 0xf5b
// Size: 0x21
function function_f53d30e3d2841fc9( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.b_used_ammo_cache = 1;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x4ef426b3, Offset: 0xf84
// Size: 0x127
function function_ae049c12c2d76943( params )
{
    eventname = #"zm_area_unlock";
    eventid = ae_utility::function_8645a430dc4bffb9( eventname );
    
    if ( !isdefined( eventid ) )
    {
        return;
    }
    
    if ( !isdefined( self.a_zones_reached ) )
    {
        self.a_zones_reached = [];
    }
    
    zone_name = zone_manager::function_2bcd755aabfd3cad( params.zone_struct );
    
    if ( isdefined( zone_name ) )
    {
        self.a_zones_reached = arraycombineunique( self.a_zones_reached, [ getxhash( zone_name ) ] );
    }
    
    zm_all_areas_unlocked_modifiers = 0;
    zm_area_unlock_modifiers = 0;
    var_ea3fb1284f044ce5 = function_de3647be2b1f89d8();
    zm_all_areas_unlocked_modifiers = function_fa9ed9671f89990f( zm_all_areas_unlocked_modifiers, var_ea3fb1284f044ce5, self );
    
    if ( zm_all_areas_unlocked_modifiers == 0 && zm_area_unlock_modifiers == 0 )
    {
        return;
    }
    
    eventparams = [];
    challenges::function_f4c306eea6673ab0( eventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_all_areas_unlocked" ) ] = zm_all_areas_unlocked_modifiers;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_areas_unlocked" ) ] = zm_area_unlock_modifiers;
    
    if ( isplayer( self ) )
    {
        self function_2e45314624fdfdb8( eventid, eventparams );
    }
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x3827946e, Offset: 0x10b3
// Size: 0x35
function function_de3647be2b1f89d8()
{
    var_ea3fb1284f044ce5 = [];
    var_ea3fb1284f044ce5[ #"hash_153aed48eb5628da" ] = ae_utility::function_2d1565a236387b2( #"zm_all_areas_unlocked", #"hash_153aed48eb5628da" );
    return var_ea3fb1284f044ce5;
}

// Namespace zombie_challenges
// Params 3
// Checksum 0x29f57aff, Offset: 0x10f1
// Size: 0x19d
function function_fa9ed9671f89990f( zm_all_areas_unlocked_modifiers, var_ea3fb1284f044ce5, player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !player.var_207668ae3120d53 )
    {
        var_e7dcc3c3cfc7ce46 = function_bee58f50413c897f();
        
        if ( !isdefined( var_e7dcc3c3cfc7ce46 ) )
        {
            return zm_all_areas_unlocked_modifiers;
        }
        
        var_db000c35d50cd79a = 0;
        
        foreach ( zones in var_e7dcc3c3cfc7ce46 )
        {
            foreach ( reached_zone in player.a_zones_reached )
            {
                if ( arraycontains( zones, reached_zone ) )
                {
                    var_db000c35d50cd79a++;
                    break;
                }
                
                waitframe();
            }
            
            waitframe();
        }
        
        /#
            iprintlnbold( var_db000c35d50cd79a + "<dev string:x24>" + var_e7dcc3c3cfc7ce46.size + "<dev string:x29>" );
        #/
        
        if ( var_db000c35d50cd79a == var_e7dcc3c3cfc7ce46.size )
        {
            player.var_207668ae3120d53 = 1;
            zm_all_areas_unlocked_modifiers = challenges::function_a23641f33e985edb( zm_all_areas_unlocked_modifiers, var_ea3fb1284f044ce5[ #"hash_153aed48eb5628da" ] );
        }
    }
    
    return zm_all_areas_unlocked_modifiers;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xd7fa0e5b, Offset: 0x1297
// Size: 0xec
function function_bee58f50413c897f()
{
    switch ( getxhash( level.mapname ) )
    {
        case #"zm_sat_firefly":
            return [ [ #"zone_jplaza_roundabout" ], [ #"zone_lakefront_path_south", #"zone_lakefront_path_north" ], [ #"zone_farm_close_to_tower", #"zone_farm_road", #"zone_farm_gate" ], [ #"zone_sunken_north", #"zone_sunken_south" ], [ #"zone_launchpad_close_to_sunken", #"zone_launchpad_close_to_exit115" ], [ #"zone_exit115_close_to_sunken", #"zone_exit115_close_to_launchpad" ] ];
        default:
            return;
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xff62c433, Offset: 0x138b
// Size: 0x1a8
function function_b014cc2869194602( params )
{
    var_1b87b14ec25ab214 = params.ref;
    eventname = #"zm_get_medals";
    aeeventid = ae_utility::function_8645a430dc4bffb9( eventname );
    
    if ( !isdefined( aeeventid ) )
    {
        return;
    }
    
    var_255a933363706cec = function_5355ce24d6ae2018();
    var_7ce941ef357bf57f = 0;
    var_161b08ee57f44811 = level.var_61098ea01390d8f4[ var_1b87b14ec25ab214 ];
    
    if ( isdefined( var_161b08ee57f44811 ) )
    {
        scriptbundle = getscriptbundle( var_161b08ee57f44811 );
        
        if ( isdefined( scriptbundle ) )
        {
            if ( scriptbundle.var_ef87850cf8aae8a2.var_ed6c1633d62a12c3 )
            {
                var_7ce941ef357bf57f = challenges::function_a23641f33e985edb( var_7ce941ef357bf57f, var_255a933363706cec[ #"hash_5627429a74a37b7" ] );
            }
        }
    }
    
    foreach ( medal_name, data in var_255a933363706cec )
    {
        if ( medal_name == var_1b87b14ec25ab214 )
        {
            var_7ce941ef357bf57f = challenges::function_a23641f33e985edb( var_7ce941ef357bf57f, var_255a933363706cec[ medal_name ] );
        }
    }
    
    if ( var_7ce941ef357bf57f == 0 )
    {
        return;
    }
    
    eventparams = [];
    challenges::function_f4c306eea6673ab0( eventname, eventparams );
    map_bit = get_zm_map_name_bit();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_medal_bitfield" ) ] = var_7ce941ef357bf57f;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_map_name" ) ] = map_bit;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xd5bf2e4b, Offset: 0x153b
// Size: 0xaf0
function function_4dbc0f4c240c401e( sparams )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    victimstruct = zombie_shared_challenges::function_e7dd3022963df094( sparams.eattacker, sparams.einflictor, sparams.sweapon, sparams.smeansofdeath );
    var_2c80d6c4e950c1f0 = sparams.einflictor.glgrenadeparent;
    
    if ( !isdefined( level.zombieChallengesOnAiKilled_throttle ) )
    {
        level.zombieChallengesOnAiKilled_throttle = throttle::throttle_initialize( "zombieChallengesOnAiKilled_throttle", 1 );
    }
    
    level throttle::throttle_wait_in_queue( level.zombieChallengesOnAiKilled_throttle, victimstruct );
    var_402b24cf11902d1 = 0;
    var_eaf102363a015939 = 0;
    field_upgrade_lootid = 0;
    var_c0f0d3ca6839224e = 0;
    perks_active_modifiers = 0;
    player = sparams.eattacker;
    elementalmodifiers = 0;
    essenceamount = 0;
    squadsize = 0;
    augmentmodifiers = 0;
    trap_kill_amount = 0;
    gobblegum_modifiers = 0;
    sweapon = sparams.sweapon;
    
    if ( isplayer( player ) && isweapon( var_2c80d6c4e950c1f0 ) )
    {
        sweapon = var_2c80d6c4e950c1f0;
    }
    
    if ( isdefined( victimstruct.var_56d69f6ef35661b0 ) )
    {
        zombie_killed_time = int( abs( victimstruct.var_56d69f6ef35661b0 - victimstruct.var_e26538d32bf084ea ) );
    }
    
    var_36006ff03baee124 = sparams.einflictor.targetname == "trap_attacker" && isdefined( sparams.einflictor.trap_scriptable );
    
    if ( isplayer( player ) && !var_36006ff03baee124 )
    {
        if ( victimstruct.unittype == "soldier" )
        {
        }
        else
        {
            var_c0f0d3ca6839224e = zombie_shared_challenges::function_f603dd218dbf4618( victimstruct, var_c0f0d3ca6839224e );
        }
        
        playerperks = player.perks_active;
        
        foreach ( perk in playerperks )
        {
            var_159fac47584985ef = level function_92b358bedf399fa();
            perk_name = getxhash( perk );
            
            if ( isdefined( var_159fac47584985ef[ perk_name ] ) )
            {
                perks_active_modifiers = challenges::function_a23641f33e985edb( perks_active_modifiers, var_159fac47584985ef[ perk_name ] );
                continue;
            }
            
            println( "<dev string:x39>" + getxhashsourcename( perk_name ) + "<dev string:x58>" );
        }
        
        field_upgrade_lootid = player get_field_upgrade_lootid( victimstruct );
        elementalmodifiers = player zombie_shared_challenges::function_216bb7c532af802f( victimstruct, sparams.smeansofdeath, sweapon );
        sweapon = player zombie_shared_challenges::function_e755757ca2b10ec9( sweapon, victimstruct );
        rarity = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( sweapon );
        n_pap_lvl = player pack_a_punch::get_pap_level( sweapon );
        player zombie_shared_challenges::function_814eb8fe3432a1ca( victimstruct, sweapon, sparams.smeansofdeath, sparams.einflictor );
        essenceamount = player currency::get_currency_amount( #"essence" );
        armorlevel = player.platecarrierlevel;
        var_402b24cf11902d1 = function_c9d258b22d7613ae( player, var_402b24cf11902d1, sweapon, victimstruct );
        var_eaf102363a015939 = function_31880e8a5fc733de( player, var_eaf102363a015939, sweapon, victimstruct, field_upgrade_lootid );
        augmentmodifiers = player function_a18982b98d8c1910( augmentmodifiers, victimstruct );
        player function_49d793381ff3116b( sweapon, sparams.smeansofdeath );
        
        if ( victimstruct.weapon_basenamehash != %"sat_mini_sentry_turret" )
        {
            level.var_71d163e3f8f5b14f = 0;
        }
        
        gobblegum_modifiers = player function_f11dd746392bbbbf( gobblegum_modifiers );
        relic_modifiers = function_de8dd95bf4f43af();
    }
    else
    {
        if ( isdefined( sparams.eattacker ) && isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
        {
            zombie_augment_bits = level function_a4617805bca49724();
            zombie_kill_bits = level function_b6811d8825ae7875();
            elementalmodifiers = sparams.eattacker zombie_shared_challenges::function_ebe3b18f036aacae();
            player = sparams.eattacker.var_bd22ba6c600a23a3;
            
            if ( sparams.eattacker.var_6d31abe6b171ada8 )
            {
                sweapon = sparams.eattacker.var_6d31abe6b171ada8;
            }
            
            var_c0f0d3ca6839224e = zombie_shared_challenges::function_f603dd218dbf4618( victimstruct, var_c0f0d3ca6839224e );
            
            if ( sparams.eattacker.aicategory == "elite" )
            {
                augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"brainrot_big_game" ] );
            }
            
            if ( sparams.eattacker.subclass === victimstruct.subclass )
            {
                var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"betrayal_brainrot" ] );
            }
            
            if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
            {
                player utility::callsharedfunc( #"medal", #"track_rapid_kill", "ammomod" );
            }
        }
        
        if ( isdefined( sparams.eattacker ) && isplayer( sparams.eattacker.var_fb2e0070ae6f04e4 ) )
        {
            zombie_kill_bits = level function_b6811d8825ae7875();
            player = sparams.eattacker.var_fb2e0070ae6f04e4;
            
            if ( victimstruct.var_a00e421c491cccb3 )
            {
                var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_a9e32cb31b4d50f1" ] );
            }
        }
        
        if ( sparams.einflictor.targetname == "trap_attacker" && isdefined( sparams.einflictor.trap_scriptable ) || sparams.eattacker.targetname == "trap_attacker" && isdefined( sparams.eattacker.trap_scriptable ) )
        {
            player = sparams.einflictor.activator;
            trap_kill_amount = sparams.einflictor.var_59419e7814190b1d;
            zombie_kill_bits = level function_b6811d8825ae7875();
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"trap_kill" ] );
            
            if ( isdefined( sparams.einflictor.var_fcda7168a743663a ) )
            {
                trap_kill_modifier = 0;
                trap_kill_bit = ae_utility::function_2d1565a236387b2( #"zm_trap_kill_bitfield", getxhash( sparams.einflictor.var_fcda7168a743663a ) );
                
                if ( isdefined( trap_kill_bit ) )
                {
                    trap_kill_modifier = challenges::function_a23641f33e985edb( trap_kill_modifier, trap_kill_bit );
                }
            }
        }
        
        if ( victimstruct.var_c513c9032dfc2f0d )
        {
            if ( ( victimstruct.subclass == "zombie_viper" || issubstr( victimstruct.subclass, "zombie_viper_hvt" ) ) && issubstr( victimstruct.var_c513c9032dfc2f0d, "zombie_viper_mini" ) && !issubstr( victimstruct.var_c513c9032dfc2f0d, "popcorn" ) )
            {
                zombie_kill_bits = level function_b6811d8825ae7875();
                var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_ff0130ef8ee8765c" ] );
                
                if ( victimstruct.var_cda6c8bc587acedf && victimstruct.var_cda6c8bc587acedf.size > 0 )
                {
                    player = victimstruct.var_cda6c8bc587acedf[ 0 ];
                    
                    foreach ( playerassist in victimstruct.var_cda6c8bc587acedf )
                    {
                        if ( isplayer( playerassist ) && playerassist != player )
                        {
                            playerassist function_8c4b87e9914a3388( #"hash_ff0130ef8ee8765c" );
                        }
                    }
                }
            }
        }
        
        if ( isplayer( player ) )
        {
            if ( var_c0f0d3ca6839224e == 0 )
            {
                var_c0f0d3ca6839224e = zombie_shared_challenges::function_f603dd218dbf4618( victimstruct, var_c0f0d3ca6839224e );
            }
        }
        
        if ( isdefined( sparams.eattacker.var_456d7e952c40ccba ) && sparams.smeansofdeath == "MOD_EXPLOSIVE" && sparams.eattacker.targetname == "zm_urchin" )
        {
            player = sparams.eattacker.var_456d7e952c40ccba;
            zombie_kill_bits = level function_b6811d8825ae7875();
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"urchin_explosive_kill" ] );
        }
        
        if ( isplayer( player ) && victimstruct.weapon_basenamehash != %"sat_mini_sentry_turret" )
        {
            level.var_71d163e3f8f5b14f = 0;
        }
    }
    
    if ( isplayer( player ) )
    {
        map_bit = get_zm_map_name_bit();
        additionaleventparams = [];
        additionaleventparams[ #"zm_zombie_type_bitfield" ] = var_c0f0d3ca6839224e ?? 0;
        additionaleventparams[ #"zm_perk_type_bitfield" ] = perks_active_modifiers ?? 0;
        additionaleventparams[ #"zm_kill_bitfield" ] = var_402b24cf11902d1 ?? 0;
        additionaleventparams[ #"hash_94380a81ceea17af" ] = var_eaf102363a015939 ?? 0;
        additionaleventparams[ #"zm_field_upgrade_lootid" ] = field_upgrade_lootid ?? 0;
        additionaleventparams[ #"zm_elemental_ammomod_bitfield" ] = elementalmodifiers ?? 0;
        additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
        additionaleventparams[ #"zm_pap_level" ] = n_pap_lvl ?? 0;
        additionaleventparams[ #"zm_essence_amount" ] = essenceamount ?? 0;
        additionaleventparams[ #"zm_armor_tier" ] = armorlevel ?? 0;
        additionaleventparams[ #"team_size" ] = level.players.size ?? 0;
        additionaleventparams[ #"zm_trap_kill_amount" ] = trap_kill_amount ?? 0;
        additionaleventparams[ #"zm_parts_broken" ] = victimstruct.var_8a1185d821a93b21 ?? 0;
        additionaleventparams[ #"zm_augments" ] = augmentmodifiers ?? 0;
        additionaleventparams[ #"critical_kill_chain" ] = player.criticalkillchain ?? 0;
        additionaleventparams[ #"zm_gobblegum_bitfield" ] = gobblegum_modifiers ?? 0;
        additionaleventparams[ #"zm_trap_kill_bitfield" ] = trap_kill_modifier ?? 0;
        additionaleventparams[ #"timestamp_ms" ] = zombie_killed_time ?? 0;
        additionaleventparams[ #"zm_map_name" ] = map_bit;
        additionaleventparams[ #"zm_relics_active_bitfield" ] = relic_modifiers;
        additionaleventparams[ #"zm_relic_tier" ] = level.zm_relic_tier;
        challenges::onagentkilled( self, sparams.einflictor, player, sparams.idamage, sparams.smeansofdeath, sweapon, player.modifiers, additionaleventparams );
        function_f84f936412e18900( player, victimstruct, additionaleventparams );
    }
}

// Namespace zombie_challenges
// Params 3, eflags: 0x4
// Checksum 0xf9022f55, Offset: 0x2033
// Size: 0x2ec
function private function_f84f936412e18900( player, victimstruct, additionaleventparams )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isarray( victimstruct.a_n_player_damage ) )
    {
        foreach ( assistplayer in victimstruct.a_n_player_damage )
        {
            if ( assistplayer != player )
            {
                if ( !isplayer( assistplayer ) )
                {
                    continue;
                }
                
                var_402b24cf11902d1 = 0;
                var_eaf102363a015939 = 0;
                currentweapon = assistplayer getcurrentweapon();
                victimstruct.var_9908bb4c86f01f8f = undefined;
                rarity = assistplayer namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( assistplayer.primaryweaponobj );
                n_pap_lvl = assistplayer pack_a_punch::get_pap_level( assistplayer.primaryweaponobj );
                field_upgrade_lootid = assistplayer get_field_upgrade_lootid( victimstruct );
                victimstruct.var_9908bb4c86f01f8f = zombie_shared_challenges::function_b23fb0c74ffd6362( assistplayer );
                armorlevel = assistplayer.platecarrierlevel;
                playerperks = assistplayer.perks_active;
                
                foreach ( perk in playerperks )
                {
                    var_159fac47584985ef = level function_92b358bedf399fa();
                    perk_name = getxhash( perk );
                    perks_active_modifiers = 0;
                    
                    if ( isdefined( var_159fac47584985ef[ perk_name ] ) )
                    {
                        perks_active_modifiers = challenges::function_a23641f33e985edb( perks_active_modifiers, var_159fac47584985ef[ perk_name ] );
                        continue;
                    }
                    
                    println( "<dev string:x39>" + getxhashsourcename( perk_name ) + "<dev string:x58>" );
                }
                
                var_402b24cf11902d1 = function_c9d258b22d7613ae( assistplayer, var_402b24cf11902d1, currentweapon, victimstruct );
                var_eaf102363a015939 = function_31880e8a5fc733de( assistplayer, var_eaf102363a015939, currentweapon, victimstruct, field_upgrade_lootid );
                additionaleventparams[ #"zm_perk_type_bitfield" ] = perks_active_modifiers ?? 0;
                additionaleventparams[ #"zm_field_upgrade_lootid" ] = field_upgrade_lootid ?? 0;
                additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
                additionaleventparams[ #"zm_pap_level" ] = n_pap_lvl ?? 0;
                additionaleventparams[ #"zm_kill_bitfield" ] = var_402b24cf11902d1 ?? 0;
                additionaleventparams[ #"hash_94380a81ceea17af" ] = var_eaf102363a015939 ?? 0;
                additionaleventparams[ #"zm_armor_tier" ] = armorlevel ?? 0;
                assistplayer challenges::function_3ef859e4837f4249( victimstruct, assistplayer, currentweapon, additionaleventparams );
            }
        }
    }
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x7cb6781, Offset: 0x2327
// Size: 0x159
function function_8c4b87e9914a3388( kill_bitfield_str, additionaleventparams )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    aeeventname = #"zm_kill";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    zombie_kill_bits = level function_b6811d8825ae7875();
    var_402b24cf11902d1 = 0;
    
    if ( isdefined( zombie_kill_bits[ kill_bitfield_str ] ) )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ kill_bitfield_str ] );
    }
    else
    {
        println( "<dev string:x88>" + getxhashsourcename( kill_bitfield_str ) + "<dev string:x9d>" );
    }
    
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_kill_bitfield" ) ] = var_402b24cf11902d1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_field_upgrade_lootid" ) ] = 0;
    
    if ( isdefined( additionaleventparams ) )
    {
        foreach ( paramkey, paramval in additionaleventparams )
        {
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, paramkey ) ] = paramval;
        }
    }
    
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 4, eflags: 0x4
// Checksum 0x6ca1dfb4, Offset: 0x2488
// Size: 0x821
function private function_c9d258b22d7613ae( player, var_402b24cf11902d1, weapon, victimstruct )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    zombie_kill_bits = level function_b6811d8825ae7875();
    
    if ( level.var_78b06bc85775ee0 && arraycontains( level.var_78b06bc85775ee0, weapon ) && weapon.basenamehash != %"none" )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"wallbuy_kill" ] );
        
        if ( !isdefined( player.var_1eeb908de6f0aece ) )
        {
            player.var_1eeb908de6f0aece = [];
            
            foreach ( key, val in level.var_e69afc14a07b4f3d )
            {
                player.var_1eeb908de6f0aece[ key ] = int( 0 );
            }
        }
        else
        {
            if ( isdefined( player.var_1eeb908de6f0aece[ weapon.var_1616e6fbba9a722d ] ) )
            {
                player.var_1eeb908de6f0aece[ weapon.var_1616e6fbba9a722d ] += 1;
                
                if ( player.var_1eeb908de6f0aece[ weapon.var_1616e6fbba9a722d ] == 10 )
                {
                    player.var_1eeb908de6f0aece[ weapon.var_1616e6fbba9a722d ] = undefined;
                }
            }
            
            if ( player.var_1eeb908de6f0aece.size == 0 )
            {
                var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_b6eed3492ac1cc0" ] );
            }
        }
    }
    
    if ( level.var_73d6fa41113ea1a8 && arraycontains( level.var_73d6fa41113ea1a8, weapon ) && weapon.basenamehash != %"none" )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"magicbox_kill" ] );
    }
    else if ( weapon::iskillstreakweapon( weapon ) )
    {
        weaponname = weapon::getweaponname( weapon );
        
        if ( !isdefined( player.magicbox_weapons_killstreaks ) )
        {
            player.magicbox_weapons_killstreaks = [];
        }
        
        if ( arraycontains( player.magicbox_weapons_killstreaks, level.killstreakweaponmap[ weaponname ] ) )
        {
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"magicbox_kill" ] );
        }
    }
    
    if ( weapon::iskillstreakweapon( weapon ) )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"killstreak_kill" ] );
    }
    
    if ( victimstruct.last_dmg_struct.biscritical || victimstruct.var_1480bf6f03b7e0be.biscritical )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"critical_kill" ] );
        
        if ( !isdefined( player.criticalkillchain ) )
        {
            player.criticalkillchain = int( 0 );
        }
        
        player.criticalkillchain++;
    }
    else
    {
        player.criticalkillchain = int( 0 );
    }
    
    if ( player utility::ent_flag( "powerup_insta_kill_active" ) )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"instakill_active" ] );
        
        if ( player.var_5940e8eafaf36688 )
        {
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_88fddad2bf7dbf2" ] );
        }
    }
    
    if ( player.ismutantinjection )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"zm_minj" ] );
    }
    
    if ( isarray( player.var_581a52d13206a1ea ) && player.var_581a52d13206a1ea.size >= 4 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_77c4ba7d8cde02aa" ] );
        player.var_581a52d13206a1ea = [];
    }
    
    if ( isarray( player.var_733f91fe71fc6e22 ) && player.var_733f91fe71fc6e22.size >= 3 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_256db123e3c7e79a" ] );
        player.var_733f91fe71fc6e22 = [];
    }
    
    if ( victimstruct.var_7ff4a6a3ceadd15e )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"all_parts_broken" ] );
    }
    
    if ( isdefined( player.var_ebbf54a154def53a ) && player.var_ebbf54a154def53a != 0 && player.var_ebbf54a154def53a % 20 == 0 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_8a95de6eb781a166" ] );
    }
    
    var_402b24cf11902d1 = function_5ee02188ec14bc43( player, victimstruct, zombie_kill_bits, var_402b24cf11902d1 );
    
    if ( isdefined( level.var_8cff5e93e7f5e8 ) && ( level.var_4c46644122fad513 || level.var_fd94a3cfab1edb0 ) )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"trial_active_kill" ] );
    }
    
    if ( player.var_95fba532131152c )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_8b85d4daa2d43ffc" ] );
    }
    
    if ( player.var_d3e2938f77d566a5 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_6de439b5bd984657" ] );
    }
    
    if ( victimstruct.var_1ea85eb65d2a34e )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_5a31eb9d9fe07465" ] );
    }
    
    if ( isdefined( player.var_d6913f5f1b92e528 ) && gettime() <= player.var_d6913f5f1b92e528 + 5000 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_96036ea48f33edf7" ] );
    }
    
    if ( isweapon( weapon ) )
    {
        if ( !isdefined( player.var_bfe6c18bf28d5d06 ) )
        {
            player.var_bfe6c18bf28d5d06 = [];
        }
        
        if ( ( player weapon::function_d57c5d3783f44042( weapon ) || arraycontains( player.var_bfe6c18bf28d5d06, weapon ) ) && player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( weapon ) >= 4 )
        {
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_cd8953e705c263f1" ] );
        }
    }
    
    if ( player.var_410da1ddd36f0142 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_ae92f2c04afbddc5" ] );
        player.var_410da1ddd36f0142 = 0;
    }
    
    if ( victimstruct.killed_by_melee_macchiato )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"melee_macchiato_kill" ] );
    }
    
    if ( victimstruct.killed_by_phd_flopper )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"phd_kill" ] );
    }
    
    if ( isarray( player.medal_challenges ) )
    {
        foreach ( key, val in player.medal_challenges )
        {
            if ( player.medal_challenges[ key ] > 0 )
            {
                var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ key ] );
                player.medal_challenges[ key ] -= 1;
                continue;
            }
            
            player.medal_challenges[ key ] = undefined;
        }
    }
    
    if ( player utility::ent_flag( "is_mutant_injection_disciple" ) )
    {
        if ( victimstruct.var_455a1156e4873285 )
        {
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_a8358d1c5e3f11fd" ] );
        }
        
        if ( victimstruct.var_d1bd56975b2c12be )
        {
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_2c412731e3af63ca" ] );
        }
    }
    
    if ( victimstruct.var_592c67bb7c3220ba )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_46da7ac2fade01e3" ] );
    }
    
    if ( victimstruct.weapon_basenamehash == %"sat_pluto_dg2" )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_80651614a0bef3f1" ] );
    }
    
    if ( victimstruct.killed_by_jumppad )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"jumppad_kill" ] );
    }
    
    if ( victimstruct.var_a00e421c491cccb3 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, zombie_kill_bits[ #"hash_a9e32cb31b4d50f1" ] );
    }
    
    return var_402b24cf11902d1;
}

// Namespace zombie_challenges
// Params 5, eflags: 0x4
// Checksum 0x727bd58e, Offset: 0x2cb2
// Size: 0x260
function private function_31880e8a5fc733de( player, var_eaf102363a015939, weapon, victimstruct, field_upgrade_lootid )
{
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    zombie_kill_bits = level function_b6811d8825ae7875();
    
    if ( victimstruct.var_dd22e69947766504 )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"wmod_kill" ] );
    }
    
    if ( victimstruct.var_81b4cdec2f289400 )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"zmod_kill" ] );
    }
    
    if ( weapon::iskillstreakweapon( weapon ) )
    {
        weaponname = weapon::getweaponname( weapon );
        
        if ( isarray( player.var_489e0f352d75f224 ) && arraycontains( player.var_489e0f352d75f224, level.killstreakweaponmap[ weaponname ] ) )
        {
            var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"hash_320282153bf66912" ] );
        }
    }
    
    if ( field_upgrade_lootid > 0 || victimstruct.var_9908bb4c86f01f8f )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"hash_3941d8d4e4376858" ] );
    }
    
    if ( victimstruct.var_31bef6a9b871492e )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"hash_943931480f65ce20" ] );
    }
    
    if ( victimstruct.b_glocke_drop_floating )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"glocke_drop_floating" ] );
    }
    
    if ( victimstruct.weapon_basenamehash == %"sat_zm_wunderbarrage_missile_proj" )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"hash_2f10a0cc7e452168" ] );
    }
    
    if ( player.ridingloom )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"hash_cce1d2563fa78bbb" ] );
    }
    
    if ( isplayer( player ) && victimstruct.cyclone_kill )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"hash_6fdcf0669aac1891" ] );
    }
    
    if ( victimstruct.weapon_basenamehash == %"t10_inc_fire_zm_scarab_torch" || victimstruct.weapon_basenamehash == %"sat_molotov_zm_scarab_torch" || victimstruct.weapon_basenamehash == %"sat_molotov_zm_purple" || victimstruct.weapon_basenamehash == %"t10_inc_fire_zm_scarab_torch_cosmic" )
    {
        var_eaf102363a015939 = challenges::function_a23641f33e985edb( var_eaf102363a015939, zombie_kill_bits[ #"usurped_power_kill" ] );
    }
    
    return var_eaf102363a015939;
}

// Namespace zombie_challenges
// Params 4
// Checksum 0x243354b, Offset: 0x2f1b
// Size: 0x3a0
function function_5ee02188ec14bc43( player, victimstruct, var_a9a7b9c85da97c1f, var_402b24cf11902d1 )
{
    if ( !isdefined( victimstruct ) )
    {
        return;
    }
    
    var_11153868f4d7e6b4 = undefined;
    var_7692b65019120977 = 0;
    
    if ( isdefined( victimstruct.target_attractor.source ) )
    {
        if ( victimstruct.target_attractor.source.grenade.equipmentref == "equip_monkey_bomb" || victimstruct.weapon_basenamehash == %"cer_monkey_bomb_zm" || victimstruct.weapon_basenamehash == %"sat_monkey_bomb_zm" )
        {
            var_11153868f4d7e6b4 = "equip_monkey_bomb";
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"monkey_bomb_affected_kill" ] );
            var_7692b65019120977 = 1;
        }
        else if ( isdefined( victimstruct.target_attractor.source.equipmentref ) )
        {
            var_11153868f4d7e6b4 = "equip_decoy";
            var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"decoy_grenade_affected_kill" ] );
            var_7692b65019120977 = 1;
        }
    }
    else if ( victimstruct.weapon_basenamehash == %"cer_monkey_bomb_zm" || victimstruct.weapon_basenamehash == %"sat_monkey_bomb_zm" )
    {
        var_11153868f4d7e6b4 = "equip_monkey_bomb";
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"monkey_bomb_affected_kill" ] );
        var_7692b65019120977 = 1;
    }
    
    if ( victimstruct.var_f142682e078001d1 && victimstruct.var_a8e9ab5fba96d982 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"stun_grenade_affected_kill" ] );
        var_7692b65019120977 = 1;
    }
    
    if ( victimstruct.var_2b0a191e23e4d460 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"blackhole_bomb_affected_kill" ] );
        var_7692b65019120977 = 1;
    }
    
    if ( isdefined( var_11153868f4d7e6b4 ) )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"attractor_tactical_affected_kill" ] );
        var_7692b65019120977 = 1;
    }
    
    if ( isarray( victimstruct.var_81b406cea4293e1d ) && victimstruct.var_81b406cea4293e1d.size > 0 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"shockstick_affected_kill" ] );
        var_7692b65019120977 = 1;
        
        foreach ( shockstick in victimstruct.var_81b406cea4293e1d )
        {
            if ( isdefined( shockstick ) )
            {
                if ( shockstick.enemies_shocked >= 15 || shockstick.var_ed334b7d3e808371 )
                {
                    if ( !isdefined( shockstick.kills_at_once ) )
                    {
                        shockstick.kills_at_once = int( 0 );
                    }
                    
                    shockstick.var_ed334b7d3e808371 = 1;
                    shockstick.kills_at_once++;
                    
                    if ( shockstick.kills_at_once === 15 )
                    {
                        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"hash_d7ffb2525d1076cd" ] );
                    }
                }
            }
        }
    }
    
    if ( victimstruct.in_smoke_grenade )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"smoke_grenade_affected_kill" ] );
        var_7692b65019120977 = 1;
    }
    
    if ( isdefined( player.var_2bee526696230275[ #"adrenaline_used_recently" ] ) )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"stim_shot_kill" ] );
    }
    
    if ( var_7692b65019120977 == 1 )
    {
        var_402b24cf11902d1 = challenges::function_a23641f33e985edb( var_402b24cf11902d1, var_a9a7b9c85da97c1f[ #"tactical_affected_kill" ] );
    }
    
    return var_402b24cf11902d1;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xacddd330, Offset: 0x32c4
// Size: 0x280
function private get_field_upgrade_lootid( victimstruct )
{
    fieldupgradeweapon = undefined;
    
    if ( victimstruct.energy_mine_kill || victimstruct.weapon_basenamehash == %"energy_mine" || victimstruct.var_7f8f0ee3e5799bcc == %"energy_mine" )
    {
        fieldupgradeweapon = makeweapon( %"energy_mine_zm" );
    }
    else if ( victimstruct.mary_paris_kill || victimstruct.weapon_basenamehash == %"mary_paris" || victimstruct.var_7f8f0ee3e5799bcc == %"mary_paris" )
    {
        fieldupgradeweapon = makeweapon( %"mary_paris_zm" );
    }
    else if ( utility::ent_flag( "tesla_storm_active" ) && !utility::ent_flag( "tesla_storm_buff_active" ) )
    {
        fieldupgradeweapon = makeweapon( %"tesla_storm_zm" );
    }
    else if ( victimstruct.frost_blast_active )
    {
        fieldupgradeweapon = makeweapon( %"frost_blast_zm" );
    }
    else if ( utility::ent_flag( "frenzied_guard_active" ) )
    {
        fieldupgradeweapon = makeweapon( %"frenzied_guard_zm" );
    }
    else if ( victimstruct.killed_by_dark_flare )
    {
        fieldupgradeweapon = makeweapon( %"dark_flare_zm" );
        
        if ( !isdefined( self.var_29c29a6b4c12bc6 ) )
        {
            self.var_29c29a6b4c12bc6 = [];
        }
        
        if ( isdefined( victimstruct.subclass ) )
        {
            self.var_733f91fe71fc6e22[ victimstruct.subclass ] = 1;
        }
    }
    else if ( self.aether_shroud_active )
    {
        fieldupgradeweapon = makeweapon( %"aether_shroud_zm" );
    }
    else if ( isdefined( self.last_healing_aura ) && victimstruct.var_e26538d32bf084ea <= self.last_healing_aura + 5000 )
    {
        fieldupgradeweapon = makeweapon( %"healing_aura_zm" );
    }
    else if ( victimstruct.var_2259f0a89be4759f )
    {
        fieldupgradeweapon = makeweapon( %"toxic_growth_zm" );
    }
    else if ( self.wiley_fox_settings.active || victimstruct.weapon_basenamehash == %"sat_molotov_zm_wileyfox" || victimstruct.weapon_basenamehash == %"wiley_fox_zm" )
    {
        fieldupgradeweapon = makeweapon( %"wiley_fox_zm" );
    }
    
    if ( isdefined( fieldupgradeweapon ) )
    {
        field_upgrade_lootid = challenges::getweaponlootid( fieldupgradeweapon, fieldupgradeweapon.basename );
    }
    
    return field_upgrade_lootid;
}

// Namespace zombie_challenges
// Params 2, eflags: 0x4
// Checksum 0x9514d983, Offset: 0x354d
// Size: 0x41e
function private function_a18982b98d8c1910( augmentmodifiers, victimstruct )
{
    zombie_augment_bits = level function_a4617805bca49724();
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_shadow_blade" ) && self.aether_shroud_active && isdefined( victimstruct.aicategory ) )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"aether_shroud_shadowblade" ] );
        
        if ( !isdefined( self.var_56d069534ac2ca05 ) )
        {
            self.var_56d069534ac2ca05 = [];
        }
        
        if ( !isdefined( self.var_56d069534ac2ca05[ victimstruct.aicategory ] ) )
        {
            self.var_56d069534ac2ca05[ victimstruct.aicategory ] = int( 0 );
        }
        
        self.var_56d069534ac2ca05[ victimstruct.aicategory ]++;
        
        if ( !isdefined( self.var_56d069534ac2ca05[ "normal" ] ) )
        {
            self.var_56d069534ac2ca05[ "normal" ] = 0;
        }
        
        if ( !isdefined( self.var_56d069534ac2ca05[ "special" ] ) )
        {
            self.var_56d069534ac2ca05[ "special" ] = 0;
        }
        
        if ( !isdefined( self.var_56d069534ac2ca05[ "elite" ] ) )
        {
            self.var_56d069534ac2ca05[ "elite" ] = 0;
        }
        
        if ( self.var_56d069534ac2ca05[ "normal" ] >= 3 && self.var_56d069534ac2ca05[ "special" ] >= 2 && self.var_56d069534ac2ca05[ "elite" ] >= 1 )
        {
            augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"hash_63eaf7070e3cb19e" ] );
            self.var_56d069534ac2ca05 = [];
        }
    }
    
    if ( victimstruct.napalm_burned && victimstruct.aicategory == "elite" )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"napalm_burst_big_game" ] );
    }
    
    if ( victimstruct.var_6b1845284e358d3e )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"frenzied_guard_retribution" ] );
    }
    
    if ( victimstruct.electric_cherry_kill || victimstruct.var_443189a33694d681 )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"electric_cherry" ] );
    }
    
    if ( victimstruct.var_c13640c265c43c23 )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"hash_c8046af3c161d22" ] );
    }
    
    if ( victimstruct.napalmburst_incendiary_burnt )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"napalmburst_incendiary_burnt" ] );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_overwhelming_force" ) && victimstruct.killed_by_melee_macchiato )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"m_mod_augment_o" ] );
    }
    
    if ( victimstruct.killed_by_phd_slider )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"phdflopper_augment_s" ] );
    }
    
    if ( isdefined( self.var_4df597be2980bf60 ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"toxic_growth_pollination" ) && victimstruct.weapon_basenamehash == %"toxic_growth_zm" && !self.var_901b08308f13264a )
    {
        self.var_4df597be2980bf60++;
        
        if ( self.var_4df597be2980bf60 >= 20 )
        {
            /#
                iprintlnbold( "<dev string:xbb>" );
            #/
            
            self.var_901b08308f13264a = 1;
            augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"hash_dcda5709152f888f" ] );
        }
    }
    
    if ( victimstruct.target_attractor.source.state == "monkey" )
    {
        augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"hash_a4befdb0657fe9e1" ] );
    }
    
    if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_z_mod" ) )
    {
        if ( self.var_3bf72dcd2775aa78.basenamehash == victimstruct.weapon_basenamehash )
        {
            augmentmodifiers = challenges::function_a23641f33e985edb( augmentmodifiers, zombie_augment_bits[ #"hash_3e49aa4afbd1c2b5" ] );
        }
    }
    
    return augmentmodifiers;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x6e54559c, Offset: 0x3974
// Size: 0x38
function on_player_augment_given( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.zm_mode_modifiers.var_883a0291ac45b227 )
    {
        return;
    }
    
    self.var_8ba28984e9b77eb8 = 1;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xa933fe73, Offset: 0x39b4
// Size: 0x7d
function function_b5178a27f638123b( sparams )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( isdefined( self.health ) && isdefined( self.maxhealth ) && self.health >= self.maxhealth )
    {
        self.var_d3a7b3f093df2ff1 = gettime();
    }
    
    if ( sparams.idamage > 0 )
    {
        if ( !isdefined( self.var_56d69f6ef35661b0 ) )
        {
            self.var_56d69f6ef35661b0 = gettime();
        }
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xa8ce409, Offset: 0x3a39
// Size: 0x1b8
function function_a9403b28b7a4ae8e( params )
{
    if ( !isagent( self ) || !isdefined( self.subclass ) )
    {
        return params.idamage;
    }
    
    if ( isplayer( params.eattacker ) && getxhash( self.subclass ) == #"zombie_triton" && isweapon( params.sweapon ) )
    {
        if ( isdefined( params.sweapon.var_1616e6fbba9a722d ) )
        {
            weapon = params.sweapon.var_1616e6fbba9a722d;
            
            if ( !isdefined( params.eattacker.var_6323ff254aa88129 ) )
            {
                params.eattacker.var_6323ff254aa88129 = 3;
            }
            
            switch ( weapon )
            {
                case %"hash_31a0ad83eb48e6f":
                case %"hash_d4c4ab4be4a68d5":
                case %"hash_daa14c777735feb":
                case %"hash_13e556c1bc36777e":
                case %"hash_15c76cff15390217":
                case %"hash_1c36cf41821b5253":
                case %"hash_3f2aaaf04ce7f636":
                case %"hash_411b1535a40859a3":
                case %"hash_570e95bba6bcb9c5":
                case %"none":
                case %"hash_7c242fcd65f30b99":
                    break;
                default:
                    params.eattacker.var_6323ff254aa88129 = max( 0, params.eattacker.var_6323ff254aa88129 - 1 );
                    break;
            }
        }
    }
    
    return params.idamage;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x60e4272a, Offset: 0x3bfa
// Size: 0x39
function private function_4d5ce745868a7fd6( params )
{
    if ( isplayer( params.player ) )
    {
        params.player function_8c4b87e9914a3388( #"hash_7652dbc72bd2299d" );
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x42d87c01, Offset: 0x3c3b
// Size: 0x38
function on_player_damaged( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_1a750b53551a95c3 = 1;
    
    if ( isdefined( self.var_955aea0d916a87f7 ) )
    {
        self.var_955aea0d916a87f7 = 0;
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x98a09ec2, Offset: 0x3c7b
// Size: 0x54
function function_3a1defe7d6d76819( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_bf28468f33958718 = 1;
    
    if ( isdefined( self.var_52b527f146b1e929 ) && gettime() <= self.var_52b527f146b1e929 + 10000 )
    {
        function_39299860f4a62121( #"hash_985b6810f4f14798" );
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xe63919d9, Offset: 0x3cd7
// Size: 0x3d
function on_score_event( params )
{
    if ( params.scoreevent == #"loose_change" && isplayer( self ) )
    {
        function_39299860f4a62121( #"loose_change_collected" );
    }
}

// Namespace zombie_challenges
// Params 2, eflags: 0x4
// Checksum 0xdaf67459, Offset: 0x3d1c
// Size: 0xdf
function private function_49d793381ff3116b( weapon, meansofdeath )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( weapon.basenamehash == %"none" )
    {
        return;
    }
    
    switch ( meansofdeath )
    {
        case #"hash_a5123f4d02745600":
            return;
        case #"hash_b1078ff213fddba6":
            if ( isweapon( weapon ) && weapon.classname == "throwingknife" )
            {
                return;
            }
        case #"hash_a911a1880d996edb":
        case #"hash_daad53adb4557616":
            if ( weapon.damagemodcategory == #"melee" || weapon.ismelee )
            {
                return;
            }
        default:
            self.var_b8e6a8c9bfecb39 = 1;
            break;
    }
    
    self.var_b8e6a8c9bfecb39 = 1;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x77c4aa93, Offset: 0x3e03
// Size: 0xf0
function on_player_connect( params )
{
    if ( level.players.size == 1 )
    {
        level.var_98490f0292873839 = 1;
    }
    else
    {
        level.var_98490f0292873839 = 0;
    }
    
    round_number = level.var_6781718da4f78d1c.roundnumber;
    
    if ( isdefined( self ) && round_number > 1 )
    {
        self.var_b8e6a8c9bfecb39 = 1;
        self.var_1a750b53551a95c3 = 1;
        self.var_8ba28984e9b77eb8 = 1;
        self.var_bf28468f33958718 = 1;
        self.var_998090d04c25480b = 1;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 2;
    
    if ( isplayer( self ) )
    {
        self.var_bfe6c18bf28d5d06 = [];
        
        if ( isdefined( self.var_cc1262e66dbb1c79 ) )
        {
            self.var_bfe6c18bf28d5d06[ self.var_bfe6c18bf28d5d06.size ] = self.var_cc1262e66dbb1c79;
        }
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x99e382bb, Offset: 0x3efb
// Size: 0x55
function on_zombie_ai_spawned( sparams )
{
    if ( self.subclass == "zombie_base_armored_heavy" || self.subclass == "zombie_base_armored_light" || self.subclass == "zombie_amalgam" )
    {
        callback::add( "metabone_destroyed", &zombie_metabone_destroyed );
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xada32b1d, Offset: 0x3f58
// Size: 0x123
function private zombie_metabone_destroyed( params )
{
    var_7ff4a6a3ceadd15e = 1;
    
    if ( !isdefined( self.var_8a1185d821a93b21 ) )
    {
        self.var_8a1185d821a93b21 = int( 0 );
    }
    
    metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
    
    foreach ( metabone in metabones_def.metabones )
    {
        metabone_state = self getscriptablepartstate( metabone.name );
        
        if ( isdefined( metabone_state ) && metabone_state != "exposed" && metabone_state != "destroyed" && metabone_state != "off" )
        {
            var_7ff4a6a3ceadd15e = 0;
        }
    }
    
    self.var_7ff4a6a3ceadd15e = var_7ff4a6a3ceadd15e;
    self.var_8a1185d821a93b21++;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xc5696214, Offset: 0x4083
// Size: 0x1cd
function function_7c5758499baefdf5( params )
{
    if ( !isent( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !isent( params.victim ) || !isagent( params.victim ) )
    {
        return;
    }
    
    aeeventname = #"zm_ammo_mod_proc";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    weaponlootid = int( 0 );
    var_26ac81b0923da84d = params.sweapon;
    var_49a734ae41b667b3 = challenges::getweaponclass( params.sweapon ) ?? int( 0 );
    lootid = ammo_mod::get_ammo_mod_loot_id( params.ammomod_name ) ?? int( 0 );
    var_285b99084d3252f0 = zombie_shared_challenges::function_f603dd218dbf4618( params.victim );
    brainrot_count = self.brainrotted_ai_count ?? 0;
    
    if ( isweapon( var_26ac81b0923da84d ) )
    {
        weaponlootid = weapon::function_57559cfce1d2812d( var_26ac81b0923da84d );
    }
    
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = challenges::function_4dc87d9356c76d42( weaponlootid, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = challenges::function_4dc87d9356c76d42( var_49a734ae41b667b3, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = challenges::function_4dc87d9356c76d42( lootid, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_zombie_type_bitfield" ) ] = challenges::function_4dc87d9356c76d42( var_285b99084d3252f0, aeeventname );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_brainrot_count" ) ] = challenges::function_4dc87d9356c76d42( brainrot_count, aeeventname );
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x1322dde7, Offset: 0x4258
// Size: 0x1e
function private on_ammo_mod_equipped( params )
{
    function_a8c9fe83f718e077();
    self.var_8ba28984e9b77eb8 = 1;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x4fdf22fa, Offset: 0x427e
// Size: 0x3b
function private function_56b999378fe58366( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    params.player function_39299860f4a62121( #"ammomod_lightray_healed" );
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xee5d19e9, Offset: 0x42c1
// Size: 0x222
function function_b17e1618d76e2537( sparams )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isweapon( sparams.objweapon ) )
    {
        level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = sparams.objweapon;
        
        if ( sparams.objweapon.hasalternate )
        {
            altweapon = sparams.objweapon getaltweapon();
            level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = altweapon;
        }
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"wallbuy" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    
    if ( isweapon( sparams.objweapon ) )
    {
        rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( sparams.objweapon );
    }
    
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( sparams.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    purchase_modifiers = 0;
    purchase_bitfield_array = get_zm_purchase_bitfield_array();
    
    if ( sparams.var_6691fe43150a092f && sparams.cost == 10 )
    {
        purchase_modifiers = challenges::function_a23641f33e985edb( purchase_modifiers, purchase_bitfield_array[ #"hash_16dcd68e635c9cbe" ] );
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    additionaleventparams[ #"zm_purchase_bitfield" ] = purchase_modifiers ?? 0;
    challenges::function_efec954cceb5599d( self, sparams.lootid, undefined, undefined, 1, sparams.cost, buy_action, additionaleventparams );
    self.var_8ba28984e9b77eb8 = 1;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x66faafed, Offset: 0x44eb
// Size: 0x166
function report_on_item_pickup( sparams )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( sparams.item ) && isdefined( sparams.itembundle ) )
    {
        rarity = sparams.itembundle.rarity ?? 0;
        lootid = loot::getlootidfromref( sparams.itembundle.ref ) ?? 0;
        quantity = sparams.item.count ?? 0;
        quantity = maxint( 0, quantity );
        additionaleventparams = [];
        additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
        challenges::reportlootitemevent( self, lootid, undefined, 0, quantity, 0, 0, additionaleventparams );
    }
    
    if ( isweapon( sparams.item.weaponobj ) && weapon::isprimaryweapon( sparams.item.weaponobj ) )
    {
        function_a8c9fe83f718e077();
    }
    
    if ( isweapon( sparams.item.weaponobj ) && !weapon::function_d57c5d3783f44042( sparams.item.weaponobj ) )
    {
        self.var_8ba28984e9b77eb8 = 1;
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x74b40336, Offset: 0x4659
// Size: 0x101
function private function_4926a00c84ab47ba( sparams )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( sparams.item ) && isdefined( sparams.itembundle ) )
    {
        rarity = sparams.itembundle.rarity ?? 0;
        lootid = loot::getlootidfromref( sparams.itembundle.ref ) ?? 0;
        quantity = sparams.item.count ?? 0;
        quantity = maxint( 0, quantity );
        essenceamount = currency::get_currency_amount( #"essence" ) ?? 0;
        additionaleventparams = [];
        additionaleventparams[ #"zm_rarity" ] = rarity;
        additionaleventparams[ #"zm_essence_amount" ] = essenceamount;
        challenges::function_4cfe18f48cc7a55c( self, lootid, undefined, undefined, quantity, additionaleventparams );
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x8870c99, Offset: 0x4762
// Size: 0xaa
function function_45c0a258de6e39d4( raritydef )
{
    if ( isdefined( raritydef ) )
    {
        raritybundle = getscriptbundle( raritydef );
        rarityname = raritybundle.magicboxrarity;
        
        switch ( rarityname )
        {
            case #"hash_db653a4972b3c13b":
                return 0;
            case #"hash_540f19f4cb02adc3":
                return 1;
            case #"hash_209fa8900070d83d":
                return 2;
            case #"hash_95068103fe897bc8":
                return 3;
            case #"hash_d6c98e710a88aa4a":
                return 4;
            case #"hash_22aea56c1711fd5":
                return 5;
            default:
                return 0;
        }
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xdf04b79f, Offset: 0x4814
// Size: 0x12d
function private function_c1e782d2b1efc015( params )
{
    if ( params.source == #"wallbuy" )
    {
        if ( isweapon( params.objweapon ) )
        {
            level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = params.objweapon;
            
            if ( params.objweapon.hasalternate )
            {
                altweapon = params.objweapon getaltweapon();
                level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = altweapon;
            }
        }
        
        return;
    }
    
    if ( params.source == #"magicbox" )
    {
        if ( isweapon( params.objweapon ) )
        {
            level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = params.objweapon;
            
            if ( params.objweapon.hasalternate )
            {
                altweapon = params.objweapon getaltweapon();
                level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = altweapon;
            }
        }
    }
}

// Namespace zombie_challenges
// Params 0, eflags: 0x4
// Checksum 0x45aa8b72, Offset: 0x4949
// Size: 0x13c
function private function_a8c9fe83f718e077()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    weaponlist = self getweaponslistprimaries();
    var_5342f855fac69352 = int( 0 );
    
    foreach ( weapon in weaponlist )
    {
        if ( isweapon( weapon ) && !weapon.isalternate )
        {
            pap_lvl = pack_a_punch::get_pap_level( weapon );
            rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( weapon );
            ammomod = ammo_mod::get_ammo_mod_name( weapon );
            
            if ( pap_lvl >= 3 && rarity >= 4 && ammomod != "" )
            {
                var_5342f855fac69352++;
            }
        }
    }
    
    if ( var_5342f855fac69352 >= 3 && isarray( self.perks_active ) && self.perks_active.size >= 8 )
    {
        function_39299860f4a62121( #"hash_3b7cd73ecd7266ed" );
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xd9a01cec, Offset: 0x4a8d
// Size: 0x324
function function_bdcc5e9dfecd8a55( sparams )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    waitframe();
    self.var_8ba28984e9b77eb8 = 1;
    purchase_modifiers = 0;
    purchase_bitfield_array = get_zm_purchase_bitfield_array();
    
    if ( isweapon( sparams.objweapon ) )
    {
        level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = sparams.objweapon;
        
        if ( sparams.objweapon.hasalternate )
        {
            altweapon = sparams.objweapon getaltweapon();
            level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = altweapon;
        }
        
        if ( !isdefined( self.purchased_magicbox_weapons ) )
        {
            self.purchased_magicbox_weapons = [];
        }
        
        self.purchased_magicbox_weapons[ sparams.objweapon.var_1616e6fbba9a722d ] = 1;
        
        if ( self.purchased_magicbox_weapons.size >= level.var_c94175b5e96b794c.size || self.purchased_magicbox_weapons.size >= 37 )
        {
            purchase_modifiers = challenges::function_a23641f33e985edb( purchase_modifiers, purchase_bitfield_array[ #"hash_802e17ea8d5c269d" ] );
        }
    }
    else if ( sparams.var_4e0aa9a7c35d4dce )
    {
        if ( !isdefined( self.purchased_magicbox_weapons ) )
        {
            self.purchased_magicbox_weapons = [];
        }
        
        self.purchased_magicbox_weapons[ getxhashasset( sparams.itembundle.ref ) ] = 1;
        
        if ( self.purchased_magicbox_weapons.size >= level.var_c94175b5e96b794c.size || self.purchased_magicbox_weapons.size >= 37 )
        {
            purchase_modifiers = challenges::function_a23641f33e985edb( purchase_modifiers, purchase_bitfield_array[ #"hash_802e17ea8d5c269d" ] );
        }
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"magicbox" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    
    if ( isweapon( sparams.objweapon ) )
    {
        rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( sparams.objweapon );
    }
    
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( sparams.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    
    if ( sparams.var_6691fe43150a092f && sparams.cost === 10 )
    {
        purchase_modifiers = challenges::function_a23641f33e985edb( purchase_modifiers, purchase_bitfield_array[ #"hash_16dcd68e635c9cbe" ] );
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    additionaleventparams[ #"zm_purchase_bitfield" ] = purchase_modifiers ?? 0;
    challenges::function_efec954cceb5599d( self, sparams.lootid, undefined, undefined, 1, sparams.cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x8077549c, Offset: 0x4db9
// Size: 0x2c
function function_9e54e5130f31aa82( params )
{
    if ( level.players.size > 1 )
    {
        function_39299860f4a62121( #"magicbox_melee_share" );
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xa82ca07b, Offset: 0x4ded
// Size: 0x1d2
function private report_on_pap_machine_purchase( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waitframe();
    
    if ( !self )
    {
        return;
    }
    
    self.b_used_pap_machine = 1;
    var_1b697978a3640779 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"pack_a_punch" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    var_1b697978a3640779 = function_252a237ad2d4f650( var_1b697978a3640779, params.model );
    lootid = 0;
    rarity = 0;
    
    if ( isdefined( params.weapon ) )
    {
        if ( isweapon( params.weapon ) )
        {
            rarity = params.rarity ?? namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.weapon ) ?? 0;
            lootid = weapon::function_57559cfce1d2812d( params.weapon ) ?? 0;
        }
    }
    
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    additionaleventparams = [];
    additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
    additionaleventparams[ #"zm_purchase_source" ] = var_1b697978a3640779 ?? 0;
    additionaleventparams[ #"zm_pap_level" ] = params.var_951c89546ec50477 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, params.cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x15dc89fe, Offset: 0x4fc7
// Size: 0x60
function function_252a237ad2d4f650( var_1b697978a3640779, model_name )
{
    if ( model_name && issubstr( model_name, "pluto" ) )
    {
        bit = ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"tessie_pack" );
        
        if ( isdefined( bit ) )
        {
            var_1b697978a3640779 = challenges::function_a23641f33e985edb( var_1b697978a3640779, bit );
        }
    }
    
    return var_1b697978a3640779;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x92f5b7b, Offset: 0x5030
// Size: 0x1d2
function private function_9f675ac37fb9cc33( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    newalt = params.var_101633ed971732ba getaltweapon();
    oldweapon = params.var_39044599845b54cf;
    var_7bdf08af13d4f1a9 = params.var_101633ed971732ba;
    self.var_b728f74baa7e0b47 = 1;
    
    if ( isdefined( oldweapon ) )
    {
        if ( isdefined( var_7bdf08af13d4f1a9 ) )
        {
            params.objweapon = var_7bdf08af13d4f1a9;
            level thread function_704e55c96eef0c91( params );
        }
        
        if ( isdefined( newalt ) )
        {
            params.objweapon = newalt;
            level thread function_704e55c96eef0c91( params );
        }
    }
    
    var_285b99084d3252f0 = 0;
    aeeventname = #"zm_pack_a_punched_weapon";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    weaponlootid = 0;
    var_26ac81b0923da84d = oldweapon;
    var_49a734ae41b667b3 = challenges::getweaponclass( oldweapon ) ?? 0;
    rarity = params.rarity ?? namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( oldweapon ) ?? 0;
    n_pap_lvl = params.var_951c89546ec50477 ?? 0;
    
    if ( isweapon( var_26ac81b0923da84d ) )
    {
        weaponlootid = weapon::function_57559cfce1d2812d( var_26ac81b0923da84d );
    }
    
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_loot_id" ) ] = weaponlootid;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"weapon_class_bitfield" ) ] = var_49a734ae41b667b3;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_rarity" ) ] = rarity;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_pap_level" ) ] = n_pap_lvl;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
    function_a8c9fe83f718e077();
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x664b47fd, Offset: 0x520a
// Size: 0x159
function private function_704e55c96eef0c91( params )
{
    var_da9895ad63747df9 = params.var_39044599845b54cf getaltweapon();
    player = params.player;
    
    if ( arraycontains( level.var_78b06bc85775ee0, params.var_39044599845b54cf ) || arraycontains( level.var_78b06bc85775ee0, var_da9895ad63747df9 ) )
    {
        level.var_78b06bc85775ee0[ level.var_78b06bc85775ee0.size ] = params.objweapon;
        return;
    }
    
    if ( arraycontains( level.var_73d6fa41113ea1a8, params.var_39044599845b54cf ) || arraycontains( level.var_73d6fa41113ea1a8, var_da9895ad63747df9 ) )
    {
        level.var_73d6fa41113ea1a8[ level.var_73d6fa41113ea1a8.size ] = params.objweapon;
        return;
    }
    
    if ( isarray( player.var_bfe6c18bf28d5d06 ) )
    {
        if ( player weapon::function_d57c5d3783f44042( params.var_39044599845b54cf ) || arraycontains( player.var_bfe6c18bf28d5d06, params.var_39044599845b54cf ) || arraycontains( player.var_bfe6c18bf28d5d06, var_da9895ad63747df9 ) )
        {
            player.var_bfe6c18bf28d5d06[ player.var_bfe6c18bf28d5d06.size ] = params.objweapon;
        }
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xb290dde7, Offset: 0x536b
// Size: 0x137
function private function_c539cf5c6db3329b( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"perk_machine" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    lootid = loot::getlootidfromref( params.perkref ) ?? 0;
    cost = params.cost ?? 0;
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    additionaleventparams = [];
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, cost, buy_action, additionaleventparams );
    self.var_8ba28984e9b77eb8 = 1;
    self.b_used_perk_machine = 1;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xcf7de72b, Offset: 0x54aa
// Size: 0x1bc
function private report_on_powerup_pickup( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.str_powerup ) )
    {
        return;
    }
    
    aeeventname = #"zm_power_up_pickup";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    powerup = params.str_powerup;
    var_d9fe77d870af7ee1 = function_9da34a48981e280c();
    powerup_bit = 0;
    powerup_bit = challenges::function_a23641f33e985edb( powerup_bit, var_d9fe77d870af7ee1[ getxhash( params.str_powerup ) ] ?? 0 );
    powerup_source_array = function_4de082d6f8a9089();
    
    if ( !isdefined( params.powerup_source ) )
    {
        params.powerup_source = "drop";
    }
    
    source_name = getxhash( params.powerup_source );
    powerup_source = 0;
    powerup_source = challenges::function_a23641f33e985edb( powerup_source, powerup_source_array[ source_name ] ?? 0 );
    
    if ( params.powerup_source == "gobblegum" )
    {
        self.var_5940e8eafaf36688 = 1;
    }
    
    essenceamount = currency::get_currency_amount( #"essence" ) ?? 0;
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_powerup_bitfield" ) ] = powerup_bit;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_powerup_source_bitfield" ) ] = powerup_source;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_essence_amount" ) ] = essenceamount;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
    
    if ( params.str_powerup == "free_perk" )
    {
        function_5f8e5f3037fa760f( aeeventid, eventparams );
    }
}

// Namespace zombie_challenges
// Params 2, eflags: 0x4
// Checksum 0x729b2f8, Offset: 0x566e
// Size: 0x9f
function private function_5f8e5f3037fa760f( aeeventid, eventparams )
{
    foreach ( player in level.players )
    {
        if ( isplayer( player ) && self != player )
        {
            player function_2e45314624fdfdb8( aeeventid, eventparams );
        }
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xb3e1780, Offset: 0x5715
// Size: 0x79
function private on_powerup_insta_kill_end( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( params.ref == "insta_kill" )
    {
        self.var_5940e8eafaf36688 = undefined;
    }
    
    aeeventname = #"zm_power_up_instakill_end";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xceb8d56c, Offset: 0x5796
// Size: 0x240
function private report_on_round_end( params )
{
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        roundnumber = params.roundnumber;
        
        if ( !zone_manager::is_zone_enabled( "zone_safehouse_exterior" ) && roundnumber >= 30 )
        {
            level.var_c37dcd11f92ca540 = 1;
        }
        
        eventname = #"zm_round_completed";
        eventid = ae_utility::function_8645a430dc4bffb9( eventname );
        
        if ( !isdefined( eventid ) )
        {
            return;
        }
        
        var_57eaa35157351a84 = 0;
        var_defcdf3c93bbae4a = function_53fb55561443adaf();
        var_57eaa35157351a84 = function_29e7744e27b957ee( player, var_57eaa35157351a84, var_defcdf3c93bbae4a );
        team_size = level.players.size;
        map_modifiers = get_zm_map_name_bit();
        eventparams = [];
        challenges::function_f4c306eea6673ab0( eventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_round_bitfield" ) ] = var_57eaa35157351a84;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_round_number" ) ] = roundnumber;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"team_size" ) ] = team_size;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_relic_tier" ) ] = level.zm_relic_tier;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_map_name" ) ] = map_modifiers;
        
        if ( game_utility::function_21211f3255f8ea58() && isdefined( level.poiname ) )
        {
            survival_poi_bit = 0;
            var_15622187c60344f1 = function_996564cd0853c418();
            survival_poi_bit = challenges::function_a23641f33e985edb( survival_poi_bit, var_15622187c60344f1[ getxhash( level.poiname ) ] );
            eventparams[ ae_utility::function_70b8bc68f3d8031e( eventname, #"zm_survival_poi" ) ] = survival_poi_bit;
        }
        
        player function_2e45314624fdfdb8( eventid, eventparams );
        challenges::function_21b5f21603591966( player );
    }
    
    level.var_71d163e3f8f5b14f = undefined;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x4addce14, Offset: 0x59de
// Size: 0x25e
function private report_on_round_start( params )
{
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        aeeventname = #"zm_round_start";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        roundnumber = params.roundnumber;
        essenceamount = player currency::get_currency_amount( #"essence" ) ?? 0;
        rampage_consecutive_rounds = level.var_4a38700181272d10;
        map_modifiers = 0;
        
        if ( isdefined( level.mapname ) )
        {
            map_name = getxhash( level.mapname );
            var_b7047ee1b7352a20 = function_4e695aee1675ae93();
            map_modifiers = challenges::function_a23641f33e985edb( 0, var_b7047ee1b7352a20[ map_name ] );
        }
        
        round_bitfield_array = get_zm_round_bitfield_array();
        round_modifiers = 0;
        round_modifiers = function_2fa89a888c84750c( player, round_modifiers, round_bitfield_array );
        relic_modifiers = function_de8dd95bf4f43af();
        eventparams = [];
        challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_round_number" ) ] = roundnumber;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_essence_amount" ) ] = essenceamount;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_rampage_consecutive_rounds" ) ] = rampage_consecutive_rounds;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_round_bitfield" ) ] = round_modifiers;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_doors_bought" ) ] = player.doorbuycount ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_map_name" ) ] = map_modifiers ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_relics_active_bitfield" ) ] = relic_modifiers;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_relic_tier" ) ] = level.zm_relic_tier;
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace zombie_challenges
// Params 3, eflags: 0x4
// Checksum 0xaaaa2246, Offset: 0x5c44
// Size: 0x1df
function private function_2fa89a888c84750c( player, round_modifiers, round_bitfield_array )
{
    if ( player.was_frozen )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"was_frozen" ] );
    }
    
    if ( !player.var_1a750b53551a95c3 )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"hash_25db9d7573e5e3bf" ] );
    }
    
    if ( !player.var_8ba28984e9b77eb8 )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"hash_efa7699c5e0ba053" ] );
    }
    
    if ( !player.var_bf28468f33958718 )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"never_downed" ] );
    }
    
    if ( !player.var_b8e6a8c9bfecb39 )
    {
        if ( level.var_98490f0292873839 )
        {
            round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"hash_39bbd352b0711afd" ] );
        }
    }
    
    if ( !level.any_doorbuy_opened )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"no_doorbuys_opened" ] );
    }
    
    if ( !player.var_998090d04c25480b )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"hash_25e909303a59d8a0" ] );
    }
    
    if ( !player.b_used_ammo_cache )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"hash_51d929a6bc477559" ] );
    }
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"is_special_round" ] );
    }
    
    if ( level.var_98490f0292873839 )
    {
        if ( player.var_fd11612ab6b01a53 )
        {
            if ( !isdefined( player.var_8d495fa9f3ccdb1 ) )
            {
                player.var_8d495fa9f3ccdb1 = int( 0 );
            }
            
            player.var_8d495fa9f3ccdb1++;
            
            if ( player.var_8d495fa9f3ccdb1 == 5 )
            {
                round_modifiers = challenges::function_a23641f33e985edb( round_modifiers, round_bitfield_array[ #"hash_5af92d0965e172b9" ] );
            }
        }
    }
    
    return round_modifiers;
}

// Namespace zombie_challenges
// Params 3, eflags: 0x4
// Checksum 0x858a4262, Offset: 0x5e2c
// Size: 0x188
function private function_29e7744e27b957ee( player, var_8e2022e2c9ca4d35, var_b2a88f77c966be46 )
{
    if ( player.was_frozen )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"was_frozen" ] );
    }
    
    if ( !isdefined( level.var_71d163e3f8f5b14f ) )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_a7a59d75caaf58fa" ] );
    }
    
    if ( !player.b_used_ammo_cache )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_51d929a6bc477559" ] );
    }
    
    if ( !player.b_used_pap_machine )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_7a4e6dfddc99401d" ] );
    }
    
    if ( !player.b_used_perk_machine )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_8f576fcf4ee3db88" ] );
    }
    
    if ( !player.var_998090d04c25480b )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_25e909303a59d8a0" ] );
    }
    
    if ( !player.var_b728f74baa7e0b47 )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_40bc34d46eeefe4b" ] );
    }
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"is_special_round" ] );
    }
    
    if ( !level.any_doorbuy_opened )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"no_doorbuys_opened" ] );
    }
    
    if ( level.var_c37dcd11f92ca540 )
    {
        var_8e2022e2c9ca4d35 = challenges::function_a23641f33e985edb( var_8e2022e2c9ca4d35, var_b2a88f77c966be46[ #"hash_e712874f2a4d1e3b" ] );
    }
    
    return var_8e2022e2c9ca4d35;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x2059b068, Offset: 0x5fbd
// Size: 0xc
function function_fc27a0b9674db4d5()
{
    if ( !isplayer( self ) )
    {
        return;
    }
}

// Namespace zombie_challenges
// Params 1
// Checksum 0xb4a6e119, Offset: 0x5fd1
// Size: 0xc
function loot_crystal_destroyed( sparams )
{
    
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xc89e1658, Offset: 0x5fe5
// Size: 0x152
function private function_d138191ce239a10b( params )
{
    a_exfil_players = params.a_exfil_players ?? level.players;
    
    foreach ( player in a_exfil_players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        aeeventname = #"zm_exfil";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        roundnumber = level.var_6781718da4f78d1c.roundnumber ?? 0;
        essenceamount = player currency::get_currency_amount( #"essence" ) ?? 0;
        eventparams = [];
        challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"essence_extracted" ) ] = essenceamount;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_round_number" ) ] = roundnumber;
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x8d72b7bb, Offset: 0x613f
// Size: 0xa2
function function_71dd86fcdbbdd5ef( player, eventparams = [] )
{
    if ( utility::issharedfuncdefined( #"hash_7305513195fadf7e", #"get_zm_map_name_bit" ) )
    {
        zm_map_bit = utility::callsharedfunc( #"hash_7305513195fadf7e", #"get_zm_map_name_bit" );
    }
    
    eventparams[ #"zm_essence_collected" ] = player.essencegained;
    eventparams[ #"zm_map_name" ] = zm_map_bit;
    eventparams[ #"zm_round_number" ] = level.var_6781718da4f78d1c.roundnumber;
    return eventparams;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x75a19694, Offset: 0x61ea
// Size: 0xe4
function private function_f11dd746392bbbbf( gobblegummodifiers )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.bgb_enabled ) )
    {
        return;
    }
    
    var_ca3c6e63d9865d12 = level function_b42a6901df822ab();
    
    foreach ( name, bgb in self.bgb_enabled )
    {
        if ( isdefined( name ) )
        {
            bgb_hash = getxhash( name );
            
            if ( isdefined( var_ca3c6e63d9865d12[ bgb_hash ] ) )
            {
                gobblegummodifiers = challenges::function_a23641f33e985edb( gobblegummodifiers, var_ca3c6e63d9865d12[ bgb_hash ] );
            }
            
            continue;
        }
        
        assertmsg( "<dev string:xeb>" );
    }
    
    return gobblegummodifiers;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x6b3ec7dc, Offset: 0x62d7
// Size: 0xdd
function function_c67ef634ef9b96d3( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    if ( params.rapidkill_type == "critical" && params.rapidkill_count == 25 )
    {
        gobblegummodifiers = 0;
        gobblegummodifiers = params.player function_f11dd746392bbbbf( gobblegummodifiers );
        additionaleventparams[ #"zm_gobblegum_bitfield" ] = gobblegummodifiers ?? 0;
        params.player function_8c4b87e9914a3388( #"hash_ae92f2c04afbddc5", additionaleventparams );
    }
    
    if ( params.rapidkill_type == "critical" && params.rapidkill_count >= 25 )
    {
        params.player.var_410da1ddd36f0142 = 1;
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xb1da9d94, Offset: 0x63bc
// Size: 0x36b
function private report_multikill( params )
{
    if ( !isdefined( params.rapidkill_type ) )
    {
        return;
    }
    
    if ( params.rapidkill_count < 5 )
    {
        return;
    }
    
    var_1fca3c4a5462d810 = spawnstruct();
    
    if ( !isdefined( level.zombieChallengesMultiKill_throttle ) )
    {
        level.zombieChallengesMultiKill_throttle = throttle::throttle_initialize( "zombieChallengesMultiKill_throttle", 1 );
    }
    
    level throttle::throttle_wait_in_queue( level.zombieChallengesMultiKill_throttle, var_1fca3c4a5462d810 );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    multikill_array = function_9d53d6dbb6ca3b97();
    zombie_augment_array = function_a4617805bca49724();
    multikill_type = params.rapidkill_type;
    multikill_type = getxhash( params.rapidkill_type );
    var_6b3a524051a04fcd = 0;
    var_412d10e75a0490fb = 0;
    round_number = level.var_6781718da4f78d1c.roundnumber ?? 0;
    
    if ( isdefined( multikill_array[ multikill_type ] ) )
    {
        var_6b3a524051a04fcd = challenges::function_a23641f33e985edb( var_6b3a524051a04fcd, multikill_array[ multikill_type ] );
    }
    else if ( isdefined( zombie_augment_array[ multikill_type ] ) )
    {
        var_412d10e75a0490fb = challenges::function_a23641f33e985edb( var_412d10e75a0490fb, zombie_augment_array[ multikill_type ] );
    }
    else
    {
        println( "<dev string:x11f>" + getxhashsourcename( multikill_type ) + "<dev string:x134>" );
        return;
    }
    
    weaponlootid = 0;
    var_49a734ae41b667b3 = 0;
    rarity = 0;
    
    if ( isweapon( params.rapidkill_weapon ) )
    {
        weaponlootid = challenges::getweaponlootid( params.rapidkill_weapon, params.rapidkill_weapon.basename );
        
        if ( !isdefined( weaponlootid ) )
        {
            weaponlootid = 0;
        }
        
        if ( weaponlootid == 0 )
        {
            equipmentweaponname = challenges::function_ff0a3bbd357d5501( params.rapidkill_weapon );
            equipmentstruct = level.equipment.table[ equipmentweaponname ];
            
            if ( isdefined( equipmentstruct ) )
            {
                weaponlootid = loot::getlootidfromref( equipmentstruct.ref );
            }
            
            if ( weaponlootid == 0 && isdefined( equipmentweaponname ) )
            {
                superstr = "super_" + equipmentweaponname;
                weaponlootid = loot::getlootidfromref( superstr );
            }
        }
        
        if ( isdefined( weaponlootid ) && weaponlootid != 0 )
        {
            weaponref = loot::function_f54ecb89dfab8e8c( weaponlootid );
            assetname = weapon::getweaponassetname( weaponref );
            var_49a734ae41b667b3 = 0;
            
            if ( isdefined( assetname ) )
            {
                weapon = makeweapon( assetname );
                var_49a734ae41b667b3 = 0;
                
                if ( weapon.var_1616e6fbba9a722d != %"none" )
                {
                    var_49a734ae41b667b3 = challenges::getweaponclass( weapon ) ?? 0;
                }
            }
        }
        
        if ( isplayer( self ) )
        {
            rarity = namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.rapidkill_weapon );
        }
    }
    
    gobblegummodifiers = 0;
    gobblegummodifiers = function_f11dd746392bbbbf( gobblegummodifiers );
    additionaleventparams = [];
    additionaleventparams[ #"zm_rarity" ] = rarity ?? 0;
    additionaleventparams[ #"zm_multikill_type_bitfield" ] = var_6b3a524051a04fcd;
    additionaleventparams[ #"zm_augments" ] = var_412d10e75a0490fb ?? 0;
    additionaleventparams[ #"zm_round_number" ] = round_number ?? 0;
    additionaleventparams[ #"weapon_class_bitfield" ] = var_49a734ae41b667b3 ?? 0;
    additionaleventparams[ #"zm_gobblegum_bitfield" ] = gobblegummodifiers ?? 0;
    additionaleventparams[ #"weapon_loot_id" ] = weaponlootid;
    challenges::function_28e766b836fbfc46( self, 0, params.rapidkill_count, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x4e59aa81, Offset: 0x672f
// Size: 0x10c
function private function_e15a297978fd0e62( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( params.var_ffc1674def575bfa ) )
    {
        return;
    }
    
    aeeventname = #"zm_perk_gain";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    lootid = loot::getlootidfromref( params.var_ffc1674def575bfa );
    round_number = level.var_6781718da4f78d1c.roundnumber ?? 0;
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = lootid ?? 0;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_consecutive_perks" ) ] = self.perks_active.size ?? 0;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_round_number" ) ] = round_number;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
    function_a8c9fe83f718e077();
    self.var_998090d04c25480b = 1;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x1d470af3, Offset: 0x6843
// Size: 0x10d
function private report_door_bought( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"doorbuy" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    lootid = 0;
    cost = params.cost ?? 0;
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    additionaleventparams = [];
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x12eaf8a4, Offset: 0x6958
// Size: 0x128
function private function_d2f4b465ee4f4d0f( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"armor_wallbuy" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    lootid = 0;
    cost = params.cost ?? 0;
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    additionaleventparams = [];
    additionaleventparams[ #"zm_rarity" ] = params.armor_level ?? 0;
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xd3cad984, Offset: 0x6a88
// Size: 0x186
function private function_63cb1b56d737b4ce( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"crafting_table" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    lootid = 0;
    cost = params.cost ?? 0;
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    
    if ( isweapon( params.weapon ) )
    {
        lootid = weapon::function_57559cfce1d2812d( params.weapon );
    }
    else if ( isdefined( params.item.itemref ) )
    {
        lootid = loot::getlootidfromref( params.item.itemref );
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"zm_rarity" ] = params.rarity ?? 0;
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x953bf35b, Offset: 0x6c16
// Size: 0x172
function private function_79b4c95960d83f1( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"arsenal" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    lootid = 0;
    cost = params.cost ?? 0;
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    
    if ( isweapon( params.weapon ) )
    {
        lootid = weapon::function_57559cfce1d2812d( params.weapon );
    }
    else if ( isdefined( params.item ) )
    {
        lootid = loot::getlootidfromref( params.item );
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"zm_rarity" ] = params.rarity ?? 0;
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x341224b4, Offset: 0x6d90
// Size: 0x170
function private store_chompy_purchase( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_30151b5e639c9482 = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"zm_purchase_source", #"store_chompy" ) );
    buy_action = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"buy_action", #"buy" ) );
    lootid = 0;
    cost = params.cost ?? 0;
    var_c138ce31d36e2211 = function_7f8b5a0febd331eb();
    currencytype = getxhash( params.currency );
    currency_bit = challenges::function_a23641f33e985edb( 0, var_c138ce31d36e2211[ currencytype ] );
    
    if ( isdefined( params.var_1344b6c6ccd6e526 ) )
    {
        if ( params.var_1344b6c6ccd6e526.type == "item" && params.var_1344b6c6ccd6e526.var_827e6c420604dd2 )
        {
            lootid = common_item::function_b01955b20c77371d( params.var_1344b6c6ccd6e526.var_827e6c420604dd2 );
        }
    }
    
    additionaleventparams = [];
    additionaleventparams[ #"zm_purchase_source" ] = var_30151b5e639c9482 ?? 0;
    additionaleventparams[ #"zm_currency_type" ] = currency_bit ?? 0;
    challenges::function_efec954cceb5599d( self, lootid, undefined, undefined, 1, cost, buy_action, additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x203bdb09, Offset: 0x6f08
// Size: 0xae
function private function_901eabfdc9577bb6( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    aeeventname = #"zm_rarity_upgraded";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    map_bit = get_zm_map_name_bit();
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"playlist_id" ) ] = getplaylistid();
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_rarity" ) ] = params.rarity;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_map_name" ) ] = map_bit;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x7a81f654, Offset: 0x6fbe
// Size: 0x1c
function private on_set_weapon_rarity( params )
{
    thread function_901eabfdc9577bb6( params );
    function_a8c9fe83f718e077();
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xc83ed058, Offset: 0x6fe2
// Size: 0x36e
function private function_4fc593c58798bebd( params )
{
    if ( !isdefined( params.questname ) )
    {
        return;
    }
    
    if ( params.is_main_quest && utility::flag( "mq_complete_on_load" ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    wait 1;
    a_players = params.var_be82617e5e8087bd ?? level.players;
    
    foreach ( player in a_players )
    {
        if ( !isplayer( player ) )
        {
            return;
        }
        
        var_bddb08d06fd14b82 = function_77862a3ac198ca62();
        quest_bit = challenges::function_a23641f33e985edb( 0, var_bddb08d06fd14b82[ params.questname ] );
        quest_bit = player get_quest_complete_modifiers( quest_bit, params );
        var_7f59740e1d828d3e = function_e5f7d63b6e91046d();
        
        if ( getmatchrulesdata( "zmData", "useModeRulesZombieSnacks" ) )
        {
            var_488f6962b039e568 = challenges::function_a23641f33e985edb( 0, var_7f59740e1d828d3e[ #"hash_2db6418a72d47cd0" ] );
        }
        
        if ( getmatchrulesdata( "zmData", "useModeChallengeVersion" ) )
        {
            var_488f6962b039e568 = challenges::function_a23641f33e985edb( 0, var_7f59740e1d828d3e[ #"hash_59ea62cf052daf65" ] );
        }
        
        map_bit = get_zm_map_name_bit();
        relic_modifiers = function_de8dd95bf4f43af();
        timestamp = player.pers[ "telemetry" ].mq_complete_time_ms ?? params.timestamp;
        aeeventname = #"zm_quest_complete";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        roundnumber = level.var_6781718da4f78d1c.roundnumber ?? 0;
        team_size = level.players.size;
        operatorlootid = player challenges::function_6a3bd1af73a5a390();
        eventparams = [];
        challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"timestamp_ms" ) ] = timestamp ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_quest_bitfield" ) ] = quest_bit ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"score" ) ] = params.score ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_round_number" ) ] = roundnumber;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_gametype_mrules" ) ] = var_488f6962b039e568;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_map_name" ) ] = map_bit;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_relics_active_bitfield" ) ] = relic_modifiers;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_relic_tier" ) ] = level.zm_relic_tier;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"team_size" ) ] = team_size;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"operator_id" ) ] = operatorlootid;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_5ee126c936835014" ) ] = level.active_relics.size;
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace zombie_challenges
// Params 2, eflags: 0x4
// Checksum 0xcf4b77a1, Offset: 0x7358
// Size: 0x109
function private get_quest_complete_modifiers( quest_bit = 0, params )
{
    var_bddb08d06fd14b82 = function_77862a3ac198ca62();
    
    if ( self.var_6323ff254aa88129 > 0 )
    {
        quest_bit = challenges::function_a23641f33e985edb( quest_bit, var_bddb08d06fd14b82[ #"hash_386c8969bdff903a" ] );
    }
    
    if ( utility::ent_flag( "player_has_finished_rcxd_racing" ) && !self.var_d6f653dbf5426557 )
    {
        quest_bit = challenges::function_a23641f33e985edb( quest_bit, var_bddb08d06fd14b82[ #"hash_4bfb1e1d1b7518e2" ] );
        self.var_d6f653dbf5426557 = 1;
    }
    
    if ( params.is_main_quest && isdefined( var_bddb08d06fd14b82[ #"is_main_quest" ] ) )
    {
        quest_bit = challenges::function_a23641f33e985edb( quest_bit, var_bddb08d06fd14b82[ #"is_main_quest" ] );
    }
    
    if ( level.timetravel )
    {
        if ( !isdefined( level.var_cea2fe0ea477724a ) )
        {
            level.var_cea2fe0ea477724a = 0;
        }
        
        if ( level.var_cea2fe0ea477724a <= 1 )
        {
            quest_bit = challenges::function_a23641f33e985edb( quest_bit, var_bddb08d06fd14b82[ #"hash_429e3b403a0d6aad" ] );
        }
    }
    
    return quest_bit;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x6e0968f0, Offset: 0x746a
// Size: 0x26
function private function_af7d3364b83e2d2d( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_39299860f4a62121( #"hash_342f380b82a1456a" );
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x5e6966e8, Offset: 0x7498
// Size: 0x9d
function function_37e122b643059d9( var_1d326eaf2cb0b19f, var_be82617e5e8087bd )
{
    if ( !isxhash( var_1d326eaf2cb0b19f ) )
    {
        assertmsg( "<dev string:x15d>" );
        return;
    }
    
    params = { #event:#"zm_sq_quest_complete", #var_be82617e5e8087bd:var_be82617e5e8087bd ?? level.players, #questname:var_1d326eaf2cb0b19f, #timestamp:gettime() };
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( "zm_sq_quest_complete", params );
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x5cff3ebe, Offset: 0x753d
// Size: 0xac
function function_418c0f0bce7d095b( var_1d326eaf2cb0b19f, var_be82617e5e8087bd )
{
    if ( !isxhash( var_1d326eaf2cb0b19f ) )
    {
        assertmsg( "<dev string:x15d>" );
        return;
    }
    
    params = { #event:#"zm_mq_quest_complete", #var_be82617e5e8087bd:var_be82617e5e8087bd ?? level.players, #is_main_quest:1, #questname:var_1d326eaf2cb0b19f, #timestamp:gettime() };
    level callback::callback( #"zm_mq_quest_complete", params );
    level callback::callback( #"hash_6c71d319dc089c27", params );
}

// Namespace zombie_challenges
// Params 2
// Checksum 0xb8ed8093, Offset: 0x75f1
// Size: 0x9d
function function_a482047f6afd7f23( var_1d326eaf2cb0b19f, var_be82617e5e8087bd )
{
    if ( !isxhash( var_1d326eaf2cb0b19f ) )
    {
        assertmsg( "<dev string:x15d>" );
        return;
    }
    
    params = { #event:#"hash_7a32172d9106caeb", #var_be82617e5e8087bd:var_be82617e5e8087bd ?? level.players, #questname:var_1d326eaf2cb0b19f, #timestamp:gettime() };
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( "zm_super_ee_quest_complete", params );
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x29a6c9a9, Offset: 0x7696
// Size: 0x9d
function function_19ce2b86e77773b7( var_1d326eaf2cb0b19f, var_be82617e5e8087bd )
{
    if ( !isxhash( var_1d326eaf2cb0b19f ) )
    {
        assertmsg( "<dev string:x15d>" );
        return;
    }
    
    params = { #event:#"hash_4e0c5e5e46ea8fef", #var_be82617e5e8087bd:var_be82617e5e8087bd ?? level.players, #questname:var_1d326eaf2cb0b19f, #timestamp:gettime() };
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( "zm_ee_quest_complete", params );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x706b1a13, Offset: 0x773b
// Size: 0x1bc
function private report_sam_trial_end( params )
{
    trial_result = 0;
    result = level utility::waittill_any_return_params_or_timeout( 5, "trial_result" );
    
    if ( result[ "message" ] != "timeout" && isdefined( result[ 0 ] ) )
    {
        trial_result = result[ 0 ];
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            return;
        }
        
        trial_id = params.var_7c00f823b7c297d4;
        mastery_achieved = params.mastery_achieved;
        aeeventname = #"zm_trial_end";
        aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
        var_b7d1de47cbb818b3 = 0;
        var_b7d1de47cbb818b3 = function_a310958d5265bb26( var_b7d1de47cbb818b3, params.var_c2afe1a671205584 );
        reward_level = trial_result;
        eventparams = [];
        challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"value" ) ] = trial_id ?? 0;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"completed" ) ] = mastery_achieved;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_e576037392c126c0" ) ] = var_b7d1de47cbb818b3;
        eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_525b4303e8019ae2" ) ] = reward_level;
        player function_2e45314624fdfdb8( aeeventid, eventparams );
    }
}

// Namespace zombie_challenges
// Params 2
// Checksum 0x52416cc7, Offset: 0x78ff
// Size: 0x3f
function function_a310958d5265bb26( var_b7d1de47cbb818b3, trial_name )
{
    trial_bits = function_843f8b4c377ef508();
    
    if ( isdefined( trial_bits[ trial_name ] ) )
    {
        var_b7d1de47cbb818b3 = challenges::function_a23641f33e985edb( var_b7d1de47cbb818b3, trial_bits[ trial_name ] );
    }
    
    return var_b7d1de47cbb818b3;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x54253854, Offset: 0x7947
// Size: 0x55
function private report_intel_collected( params )
{
    var_421961f0ecaecd92 = utility::getsharedfunc( #"intel", #"hash_e95998f599062eec" );
    
    if ( !var_421961f0ecaecd92 )
    {
        script::demoforcesre( "No shared function defined for sending 'collected Zombie Intel' AE Event, this event will be dropped!" );
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    [[ var_421961f0ecaecd92 ]]( self, params );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x23999111, Offset: 0x79a4
// Size: 0x12f
function private on_essence_gained( params )
{
    challenge_str = #"none";
    currency_type = #"none";
    
    if ( !isdefined( self.var_7fa66e4f618737f3 ) )
    {
        self.var_7fa66e4f618737f3 = 0;
    }
    
    self.var_7fa66e4f618737f3 += params.points;
    
    if ( self.var_7fa66e4f618737f3 >= 50000 )
    {
        self.var_7fa66e4f618737f3 -= 50000;
        challenge_str = #"hash_937f899d919a161f";
        currency_type = #"essence";
        function_33c62d6e2cb6253c( challenge_str, currency_type );
    }
    
    if ( self.var_ba9fb2cbfdff1497 && self.var_4d9aa99d337cc8b9 )
    {
        if ( !isdefined( self.var_955aea0d916a87f7 ) )
        {
            self.var_955aea0d916a87f7 = int( 0 );
        }
        
        self.var_955aea0d916a87f7 += params.points;
        
        if ( self.var_955aea0d916a87f7 >= 20000 )
        {
            challenge_str = #"hash_8982114859ce236c";
            currency_type = #"essence";
            function_33c62d6e2cb6253c( challenge_str, currency_type );
        }
    }
}

// Namespace zombie_challenges
// Params 2, eflags: 0x4
// Checksum 0x6ba0dd3f, Offset: 0x7adb
// Size: 0xf2
function private function_33c62d6e2cb6253c( challenge_str, currency_type )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    str_name = challenge_str;
    str_currency_name = currency_type;
    currency_type_array = function_7f8b5a0febd331eb();
    currency_type_bit = challenges::function_a23641f33e985edb( 0, currency_type_array[ str_currency_name ] );
    var_bfb3c9e569e5b013 = get_zm_currency_bitfield_array();
    currency_bit = challenges::function_a23641f33e985edb( 0, var_bfb3c9e569e5b013[ str_name ] );
    aeeventname = #"zm_interact";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_currency_bitfield" ) ] = currency_bit;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_currency_type" ) ] = currency_type_bit;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x932530d0, Offset: 0x7bd5
// Size: 0xa2
function private function_39299860f4a62121( challenge_str )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    str_name = challenge_str;
    interact_bit_array = get_zm_interact_bitfield_array();
    var_b49086900a644544 = challenges::function_a23641f33e985edb( 0, interact_bit_array[ str_name ] );
    aeeventname = #"zm_interact";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_interact_bitfield" ) ] = var_b49086900a644544;
    self function_2e45314624fdfdb8( aeeventid, eventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x749e14bb, Offset: 0x7c7f
// Size: 0x12e
function private on_start_field_upgrade( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    if ( !isdefined( params.superinfo.staticdata.objweapon ) )
    {
        return;
    }
    
    loot_id = challenges::getweaponlootid( params.superinfo.staticdata.objweapon, params.superinfo.staticdata.weaponname );
    aeeventname = #"zm_field_upgrade_start";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" ) ] = loot_id ?? 0;
    params.player function_2e45314624fdfdb8( aeeventid, eventparams );
    params.player.var_8ba28984e9b77eb8 = 1;
    params.player.var_d6913f5f1b92e528 = gettime();
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x8bf5a839, Offset: 0x7db5
// Size: 0x8a
function private on_end_field_upgrade( params )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 1.5;
    
    if ( !self )
    {
        return;
    }
    
    if ( params.staticdata.var_efcbef98efb5e5d == #"super_dark_flare" )
    {
        self.var_733f91fe71fc6e22 = [];
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_shadow_blade" ) )
    {
        self.var_56d069534ac2ca05 = [];
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xc521a80f, Offset: 0x7e47
// Size: 0x198
function private function_16cada0ca12d7ba1( params )
{
    if ( !isdefined( params.ee_name ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_6391c64c9f788c56 ) )
    {
        level.var_6391c64c9f788c56 = [];
    }
    
    if ( !isdefined( level.var_6391c64c9f788c56[ params.ee_name ] ) )
    {
        level.var_6391c64c9f788c56[ params.ee_name ] = 1;
        
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) )
            {
                return;
            }
            
            var_bddb08d06fd14b82 = function_77862a3ac198ca62();
            quest_bit = challenges::function_a23641f33e985edb( 0, var_bddb08d06fd14b82[ #"any_hidden_ee" ] );
            timestamp = params.timestamp;
            aeeventname = #"zm_quest_complete";
            aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
            eventparams = [];
            challenges::function_f4c306eea6673ab0( aeeventname, eventparams );
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"timestamp_ms" ) ] = timestamp ?? 0;
            eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"zm_quest_bitfield" ) ] = quest_bit ?? 0;
            player function_2e45314624fdfdb8( aeeventid, eventparams );
        }
    }
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xb10b2f68, Offset: 0x7fe7
// Size: 0x56
function get_zm_map_name_bit()
{
    if ( level.mapname )
    {
        map_name = getxhash( level.mapname );
        var_b7047ee1b7352a20 = function_4e695aee1675ae93();
        
        if ( isdefined( var_b7047ee1b7352a20[ map_name ] ) )
        {
            map_modifiers = challenges::function_a23641f33e985edb( 0, var_b7047ee1b7352a20[ map_name ] );
        }
    }
    
    return map_modifiers;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xdf5671af, Offset: 0x8046
// Size: 0x13e
function private on_killstreak_end( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( params.streakname ) )
    {
        if ( !isdefined( self.var_67a385d4db036c6 ) )
        {
            self.var_67a385d4db036c6 = [];
        }
        
        if ( !isdefined( self.var_67a385d4db036c6[ params.streakname ] ) && params.kills >= 10 )
        {
            function_8c4b87e9914a3388( #"hash_e0b671345973108b" );
            self.var_67a385d4db036c6[ params.streakname ] = 1;
        }
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 2;
    
    if ( !self )
    {
        return;
    }
    
    var_ebaf6674f8057859 = self.magicbox_weapons_killstreaks;
    streakname = params.streakname;
    
    if ( isplayer( self ) && isarray( var_ebaf6674f8057859 ) && isdefined( streakname ) )
    {
        var_ebaf6674f8057859 = function_5713d46873b29625( var_ebaf6674f8057859 );
        self.magicbox_weapons_killstreaks = utility::function_d751969553a4bddd( var_ebaf6674f8057859, streakname );
    }
    
    if ( isarray( self.var_489e0f352d75f224 ) && isdefined( streakname ) )
    {
        self.var_489e0f352d75f224 = utility::function_d751969553a4bddd( self.var_489e0f352d75f224, streakname );
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xbf0a8a7e, Offset: 0x818c
// Size: 0xd2
function private on_killstreak_equipped( params )
{
    if ( !isplayer( self ) || !isdefined( params.streakname ) )
    {
        return;
    }
    
    if ( params.streakitem.source == "magicbox" )
    {
        if ( !isdefined( self.magicbox_weapons_killstreaks ) )
        {
            self.magicbox_weapons_killstreaks = [];
        }
        
        self.magicbox_weapons_killstreaks[ self.magicbox_weapons_killstreaks.size ] = params.streakname;
        return;
    }
    
    if ( params.streakitem.source == "presentbox" )
    {
        if ( !isdefined( self.var_489e0f352d75f224 ) )
        {
            self.var_489e0f352d75f224 = [];
        }
        
        self.var_489e0f352d75f224[ self.var_489e0f352d75f224.size ] = params.streakname;
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xfa611ffd, Offset: 0x8266
// Size: 0x75
function private on_gobblegum_activated( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( params.name == "perkaholic" )
    {
        self.var_52b527f146b1e929 = gettime();
    }
    
    if ( params.rarity == "Legendary" )
    {
        self.var_95fba532131152c = 1;
    }
    
    if ( params.rarity == "Ultra" )
    {
        self.var_d3e2938f77d566a5 = 1;
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xc70419f9, Offset: 0x82e3
// Size: 0x54
function private on_gobblegum_consumed( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( params.rarity == "Legendary" )
    {
        self.var_95fba532131152c = 1;
    }
    
    if ( params.rarity == "Ultra" )
    {
        self.var_d3e2938f77d566a5 = 1;
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x2da5c35a, Offset: 0x833f
// Size: 0x8a
function private function_3306064ab1dbaa74( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    var_ca3c6e63d9865d12 = level function_b42a6901df822ab();
    gobblegummodifiers = 0;
    gobblegummodifiers = challenges::function_a23641f33e985edb( gobblegummodifiers, var_ca3c6e63d9865d12[ #"anywhere_but_here" ] );
    additionaleventparams[ #"zm_gobblegum_bitfield" ] = gobblegummodifiers ?? 0;
    params.player function_8c4b87e9914a3388( #"none", additionaleventparams );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xfbab7f03, Offset: 0x83d1
// Size: 0x61
function private function_f58ffb28c637144d( params )
{
    if ( !isplayer( self.owner ) )
    {
        return;
    }
    
    if ( self.teleportedowner && isdefined( self.agents_killed ) && self.agents_killed >= 10 )
    {
        self.owner function_39299860f4a62121( #"mad_science" );
    }
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x18d14777, Offset: 0x843a
// Size: 0x3f
function private on_usurped_power_deploying( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player.var_11231ee61267ee36 = int( 0 );
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xde68d37b, Offset: 0x8481
// Size: 0x24
function private function_4d1a7ca08f8d6c4f( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_8d495fa9f3ccdb1 = int( 0 );
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x92d40fd2, Offset: 0x84ad
// Size: 0x128
function function_de8dd95bf4f43af()
{
    if ( level.var_691c22ced4bc15ed )
    {
        return level.var_691c22ced4bc15ed;
    }
    
    relicmodifiers = 0;
    var_16de63e653a8a411 = get_zm_relics_active_bitfield_array();
    
    if ( level.active_relics && level.zm_relics )
    {
        foreach ( relic_hash in level.active_relics )
        {
            relic_loot_id = level.zm_relics[ relic_hash ].lootid;
            
            if ( !isdefined( relic_loot_id ) )
            {
                continue;
            }
            
            relic_ref = loot::function_f54ecb89dfab8e8c( relic_loot_id );
            relic_xhash = getxhash( relic_ref );
            
            if ( relic_xhash )
            {
                relicmodifiers = challenges::function_a23641f33e985edb( relicmodifiers, var_16de63e653a8a411[ relic_xhash ] );
            }
        }
    }
    
    level.var_691c22ced4bc15ed = relicmodifiers;
    return relicmodifiers;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0x30695c7c, Offset: 0x85de
// Size: 0x16
function private function_c2d2c5e8d279228( params )
{
    level.var_691c22ced4bc15ed = undefined;
}

// Namespace zombie_challenges
// Params 2, eflags: 0x4
// Checksum 0x6ebc7e27, Offset: 0x85fc
// Size: 0x39
function private function_2da03be5aed13eb9( str_id, func )
{
    if ( !isdefined( level.var_b626b7280fca71fa ) )
    {
        level.var_b626b7280fca71fa = [];
    }
    
    level.var_b626b7280fca71fa[ str_id ] = func;
}

// Namespace zombie_challenges
// Params 1
// Checksum 0x9c4104fa, Offset: 0x863d
// Size: 0xc
function on_mission_complete( params )
{
    
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x3009cbb7, Offset: 0x8651
// Size: 0x202
function function_92b358bedf399fa()
{
    if ( isdefined( level.zm_perk_type_bits ) && isdefined( level.zm_perk_type_bits.size ) && level.zm_perk_type_bits.size != 0 )
    {
        return level.zm_perk_type_bits;
    }
    
    zm_perk_type_bits = [];
    zm_perk_type_bits[ #"specialty_juggernog" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_juggernog" );
    zm_perk_type_bits[ #"specialty_staminup" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_staminup" );
    zm_perk_type_bits[ #"specialty_speedcola" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_speedcola" );
    zm_perk_type_bits[ #"specialty_deadshot" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_deadshot" );
    zm_perk_type_bits[ #"specialty_death_perception" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_death_perception" );
    zm_perk_type_bits[ #"specialty_quickrevive" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_quickrevive" );
    zm_perk_type_bits[ #"specialty_elemental_pop" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_elemental_pop" );
    zm_perk_type_bits[ #"specialty_phd_flopper" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_phd_flopper" );
    zm_perk_type_bits[ #"specialty_tombstone" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_tombstone" );
    zm_perk_type_bits[ #"specialty_m_mod" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_m_mod" );
    zm_perk_type_bits[ #"specialty_vulture_aid" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_vulture_aid" );
    zm_perk_type_bits[ #"specialty_d_mod" ] = ae_utility::function_2d1565a236387b2( #"zm_perk_type_bitfield", #"specialty_d_mod" );
    level.zm_perk_type_bits = zm_perk_type_bits;
    return zm_perk_type_bits;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x7f1c4f6a, Offset: 0x885c
// Size: 0xaba
function function_b6811d8825ae7875()
{
    if ( isdefined( level.zombie_kill_bits ) && isdefined( level.zombie_kill_bits.size ) && level.zombie_kill_bits.size != 0 )
    {
        return level.zombie_kill_bits;
    }
    
    zombie_kill_bits = [];
    zombie_kill_bits[ #"magicbox_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"magicbox_kill" );
    zombie_kill_bits[ #"wallbuy_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"wallbuy_kill" );
    zombie_kill_bits[ #"critical_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"critical_kill" );
    zombie_kill_bits[ #"instakill_active" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"instakill_active" );
    zombie_kill_bits[ #"trap_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"trap_kill" );
    zombie_kill_bits[ #"zm_minj" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"zm_minj" );
    zombie_kill_bits[ #"betrayal_brainrot" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"betrayal_brainrot" );
    zombie_kill_bits[ #"hash_77c4ba7d8cde02aa" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_77c4ba7d8cde02aa" );
    zombie_kill_bits[ #"hash_256db123e3c7e79a" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_256db123e3c7e79a" );
    zombie_kill_bits[ #"phd_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"phd_kill" );
    zombie_kill_bits[ #"hash_e0b671345973108b" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_e0b671345973108b" );
    zombie_kill_bits[ #"all_parts_broken" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"all_parts_broken" );
    zombie_kill_bits[ #"hash_ac9c3b94e1b00d8" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_ac9c3b94e1b00d8" );
    zombie_kill_bits[ #"melee_macchiato_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"melee_macchiato_kill" );
    zombie_kill_bits[ #"hash_8a95de6eb781a166" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_8a95de6eb781a166" );
    zombie_kill_bits[ #"medal_hideandseek" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_hideandseek" );
    zombie_kill_bits[ #"medal_beamed" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_beamed" );
    zombie_kill_bits[ #"medal_maintank" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_maintank" );
    zombie_kill_bits[ #"medal_combatmedic" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_combatmedic" );
    zombie_kill_bits[ #"medal_fulmination" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_fulmination" );
    zombie_kill_bits[ #"medal_fullycharged" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_fullycharged" );
    zombie_kill_bits[ #"medal_bombingrun" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_bombingrun" );
    zombie_kill_bits[ #"medal_fireaway" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_fireaway" );
    zombie_kill_bits[ #"medal_obliterator" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_obliterator" );
    zombie_kill_bits[ #"medal_scorchedearth" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_scorchedearth" );
    zombie_kill_bits[ #"tactical_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"tactical_affected_kill" );
    zombie_kill_bits[ #"medal_megalomaniac" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_megalomaniac" );
    zombie_kill_bits[ #"medal_alchemist" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_alchemist" );
    zombie_kill_bits[ #"stun_grenade_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"stun_grenade_affected_kill" );
    zombie_kill_bits[ #"blackhole_bomb_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"blackhole_bomb_affected_kill" );
    zombie_kill_bits[ #"attractor_tactical_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"attractor_tactical_affected_kill" );
    zombie_kill_bits[ #"decoy_grenade_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"decoy_grenade_affected_kill" );
    zombie_kill_bits[ #"shockstick_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"shockstick_affected_kill" );
    zombie_kill_bits[ #"smoke_grenade_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"smoke_grenade_affected_kill" );
    zombie_kill_bits[ #"monkey_bomb_affected_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"monkey_bomb_affected_kill" );
    zombie_kill_bits[ #"stim_shot_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"stim_shot_kill" );
    zombie_kill_bits[ #"medal_rapidkill_5" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_rapidkill_5" );
    zombie_kill_bits[ #"medal_immolate" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_immolate" );
    zombie_kill_bits[ #"medal_glaciate" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_glaciate" );
    zombie_kill_bits[ #"medal_voltaic" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_voltaic" );
    zombie_kill_bits[ #"medal_cystemic" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_cystemic" );
    zombie_kill_bits[ #"trial_active_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"trial_active_kill" );
    zombie_kill_bits[ #"hash_d7ffb2525d1076cd" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_d7ffb2525d1076cd" );
    zombie_kill_bits[ #"medal_monkeybusiness" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_monkeybusiness" );
    zombie_kill_bits[ #"medal_antiparasitic" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_antiparasitic" );
    zombie_kill_bits[ #"hash_cd8953e705c263f1" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_cd8953e705c263f1" );
    zombie_kill_bits[ #"hash_b6eed3492ac1cc0" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_b6eed3492ac1cc0" );
    zombie_kill_bits[ #"hash_8b85d4daa2d43ffc" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_8b85d4daa2d43ffc" );
    zombie_kill_bits[ #"hash_6de439b5bd984657" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_6de439b5bd984657" );
    zombie_kill_bits[ #"medal_graviton" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"medal_graviton" );
    zombie_kill_bits[ #"hash_5a31eb9d9fe07465" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_5a31eb9d9fe07465" );
    zombie_kill_bits[ #"hash_88fddad2bf7dbf2" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_88fddad2bf7dbf2" );
    zombie_kill_bits[ #"hash_96036ea48f33edf7" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_96036ea48f33edf7" );
    zombie_kill_bits[ #"hash_7652dbc72bd2299d" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_7652dbc72bd2299d" );
    zombie_kill_bits[ #"killstreak_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"killstreak_kill" );
    zombie_kill_bits[ #"hash_ae92f2c04afbddc5" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_ae92f2c04afbddc5" );
    zombie_kill_bits[ #"hash_ff0130ef8ee8765c" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_ff0130ef8ee8765c" );
    zombie_kill_bits[ #"hash_a8358d1c5e3f11fd" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_a8358d1c5e3f11fd" );
    zombie_kill_bits[ #"hash_2c412731e3af63ca" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_2c412731e3af63ca" );
    zombie_kill_bits[ #"hash_46da7ac2fade01e3" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_46da7ac2fade01e3" );
    zombie_kill_bits[ #"hash_80651614a0bef3f1" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_80651614a0bef3f1" );
    zombie_kill_bits[ #"hash_ed3f3e3f00753415" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_ed3f3e3f00753415" );
    zombie_kill_bits[ #"jumppad_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"jumppad_kill" );
    zombie_kill_bits[ #"hash_a9e32cb31b4d50f1" ] = ae_utility::function_2d1565a236387b2( #"zm_kill_bitfield", #"hash_a9e32cb31b4d50f1" );
    zombie_kill_bits[ #"wmod_kill" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"wmod_kill" );
    zombie_kill_bits[ #"zmod_kill" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"zmod_kill" );
    zombie_kill_bits[ #"hash_320282153bf66912" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"hash_320282153bf66912" );
    zombie_kill_bits[ #"hash_3941d8d4e4376858" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"hash_3941d8d4e4376858" );
    zombie_kill_bits[ #"hash_943931480f65ce20" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"hash_943931480f65ce20" );
    zombie_kill_bits[ #"glocke_drop_floating" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"glocke_drop_floating" );
    zombie_kill_bits[ #"hash_2f10a0cc7e452168" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"hash_2f10a0cc7e452168" );
    zombie_kill_bits[ #"hash_cce1d2563fa78bbb" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"hash_cce1d2563fa78bbb" );
    zombie_kill_bits[ #"hash_6fdcf0669aac1891" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"hash_6fdcf0669aac1891" );
    zombie_kill_bits[ #"usurped_power_kill" ] = ae_utility::function_2d1565a236387b2( #"hash_94380a81ceea17af", #"usurped_power_kill" );
    level.zombie_kill_bits = zombie_kill_bits;
    return zombie_kill_bits;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xef1f8364, Offset: 0x931f
// Size: 0x226
function function_a4617805bca49724()
{
    if ( isdefined( level.zombie_augment_bits ) && isdefined( level.zombie_augment_bits.size ) && level.zombie_augment_bits.size != 0 )
    {
        return level.zombie_augment_bits;
    }
    
    zombie_augment_bits = [];
    zombie_augment_bits[ #"brainrot_big_game" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"brainrot_big_game" );
    zombie_augment_bits[ #"aether_shroud_shadowblade" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"aether_shroud_shadowblade" );
    zombie_augment_bits[ #"phdflopper_augment_s" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"phd_slider" );
    zombie_augment_bits[ #"m_mod_augment_o" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"m_mod_overwhelming_force" );
    zombie_augment_bits[ #"hash_63eaf7070e3cb19e" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"hash_63eaf7070e3cb19e" );
    zombie_augment_bits[ #"napalm_burst_big_game" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"napalm_burst_big_game" );
    zombie_augment_bits[ #"electric_cherry" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"electric_cherry" );
    zombie_augment_bits[ #"frenzied_guard_retribution" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"frenzied_guard_retribution" );
    zombie_augment_bits[ #"hash_c8046af3c161d22" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"hash_c8046af3c161d22" );
    zombie_augment_bits[ #"napalmburst_incendiary_burnt" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"napalmburst_incendiary_burnt" );
    zombie_augment_bits[ #"hash_dcda5709152f888f" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"hash_dcda5709152f888f" );
    zombie_augment_bits[ #"hash_a4befdb0657fe9e1" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"hash_a4befdb0657fe9e1" );
    zombie_augment_bits[ #"hash_3e49aa4afbd1c2b5" ] = ae_utility::function_2d1565a236387b2( #"zm_augments", #"hash_3e49aa4afbd1c2b5" );
    level.zombie_augment_bits = zombie_augment_bits;
    return zombie_augment_bits;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xd72102e4, Offset: 0x954e
// Size: 0x1ba
function function_9da34a48981e280c()
{
    if ( isdefined( level.zm_powerup_type_bits ) && isdefined( level.zm_powerup_type_bits.size ) && level.zm_powerup_type_bits.size != 0 )
    {
        return level.zm_powerup_type_bits;
    }
    
    zm_powerup_type_bits = [];
    zm_powerup_type_bits[ #"nuke" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"nuke" );
    zm_powerup_type_bits[ #"insta_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"insta_kill" );
    zm_powerup_type_bits[ #"full_armor" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"full_armor" );
    zm_powerup_type_bits[ #"full_ammo" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"full_ammo" );
    zm_powerup_type_bits[ #"full_power" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"full_power" );
    zm_powerup_type_bits[ #"fire_sale" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"fire_sale" );
    zm_powerup_type_bits[ #"double_points" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"double_points" );
    zm_powerup_type_bits[ #"bonus_points" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"bonus_points" );
    zm_powerup_type_bits[ #"free_perk" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"free_perk" );
    zm_powerup_type_bits[ #"bonus_points_team" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_bitfield", #"bonus_points_team" );
    level.zm_powerup_type_bits = zm_powerup_type_bits;
    return zm_powerup_type_bits;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x3e4ddeb1, Offset: 0x9711
// Size: 0x2da
function function_9d53d6dbb6ca3b97()
{
    if ( isdefined( level.var_16729c72d450e85b ) && isdefined( level.var_16729c72d450e85b.size ) && level.var_16729c72d450e85b.size != 0 )
    {
        return level.var_16729c72d450e85b;
    }
    
    var_16729c72d450e85b = [];
    var_16729c72d450e85b[ #"primary" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"primary" );
    var_16729c72d450e85b[ #"single_explosive_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"single_explosive_kill" );
    var_16729c72d450e85b[ #"vehicle_crush_or_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"vehicle_crush_or_kill" );
    var_16729c72d450e85b[ #"killstreak_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"killstreak_kill" );
    var_16729c72d450e85b[ #"elemental_kill_fire" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"elemental_kill_fire" );
    var_16729c72d450e85b[ #"elemental_kill_cold" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"elemental_kill_cold" );
    var_16729c72d450e85b[ #"elemental_kill_electrical" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"elemental_kill_electrical" );
    var_16729c72d450e85b[ #"elemental_kill_toxic" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"elemental_kill_toxic" );
    var_16729c72d450e85b[ #"burn_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"burn_kill" );
    var_16729c72d450e85b[ #"freeze_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"freeze_kill" );
    var_16729c72d450e85b[ #"electrocuted_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"electrocuted_kill" );
    var_16729c72d450e85b[ #"multielement_kill" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"multielement_kill" );
    var_16729c72d450e85b[ #"critical" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"critical" );
    var_16729c72d450e85b[ #"deadwire" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"deadwire" );
    var_16729c72d450e85b[ #"cryofreeze" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"cryofreeze" );
    var_16729c72d450e85b[ #"napalmburst" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"napalmburst" );
    var_16729c72d450e85b[ #"multi_ammomod" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"multi_ammomod" );
    var_16729c72d450e85b[ #"ammomod" ] = ae_utility::function_2d1565a236387b2( #"zm_multikill_type_bitfield", #"ammomod" );
    level.var_16729c72d450e85b = var_16729c72d450e85b;
    return var_16729c72d450e85b;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x26ce1021, Offset: 0x99f4
// Size: 0xe2
function function_4de082d6f8a9089()
{
    if ( isdefined( level.zm_powerup_source_bits ) && isdefined( level.zm_powerup_source_bits.size ) && level.zm_powerup_source_bits.size != 0 )
    {
        return level.zm_powerup_source_bits;
    }
    
    zm_powerup_source_bits = [];
    zm_powerup_source_bits[ #"drop" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_source_bitfield", #"drop" );
    zm_powerup_source_bits[ #"GOBBLEGUM" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_source_bitfield", #"GOBBLEGUM" );
    zm_powerup_source_bits[ #"quest" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_source_bitfield", #"quest" );
    zm_powerup_source_bits[ #"hidden_ee" ] = ae_utility::function_2d1565a236387b2( #"zm_powerup_source_bitfield", #"hidden_ee" );
    level.zm_powerup_source_bits = zm_powerup_source_bits;
    return zm_powerup_source_bits;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xd2cd2daa, Offset: 0x9adf
// Size: 0x9a
function function_7f8b5a0febd331eb()
{
    if ( isdefined( level.zm_currency_type ) && isdefined( level.zm_currency_type.size ) && level.zm_currency_type.size != 0 )
    {
        return level.zm_currency_type;
    }
    
    zm_currency_type = [];
    zm_currency_type[ #"essence" ] = ae_utility::function_2d1565a236387b2( #"zm_currency_type", #"essence" );
    zm_currency_type[ #"salvage" ] = ae_utility::function_2d1565a236387b2( #"zm_currency_type", #"salvage" );
    level.zm_currency_type = zm_currency_type;
    return zm_currency_type;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x4cecacc8, Offset: 0x9b82
// Size: 0x9a
function get_zm_currency_bitfield_array()
{
    if ( isdefined( level.zm_currency_bitfield ) && isdefined( level.zm_currency_bitfield.size ) && level.zm_currency_bitfield.size != 0 )
    {
        return level.zm_currency_bitfield;
    }
    
    zm_currency_bitfield = [];
    zm_currency_bitfield[ #"hash_937f899d919a161f" ] = ae_utility::function_2d1565a236387b2( #"zm_currency_bitfield", #"hash_937f899d919a161f" );
    zm_currency_bitfield[ #"hash_8982114859ce236c" ] = ae_utility::function_2d1565a236387b2( #"zm_currency_bitfield", #"hash_8982114859ce236c" );
    level.zm_currency_bitfield = zm_currency_bitfield;
    return zm_currency_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xfc8016dc, Offset: 0x9c25
// Size: 0x196
function get_zm_interact_bitfield_array()
{
    if ( isdefined( level.zm_interact_bitfield ) && isdefined( level.zm_interact_bitfield.size ) && level.zm_interact_bitfield.size != 0 )
    {
        return level.zm_interact_bitfield;
    }
    
    zm_interact_bitfield = [];
    zm_interact_bitfield[ #"hash_3b7cd73ecd7266ed" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"hash_3b7cd73ecd7266ed" );
    zm_interact_bitfield[ #"hash_985b6810f4f14798" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"hash_985b6810f4f14798" );
    zm_interact_bitfield[ #"mad_science" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"mad_science" );
    zm_interact_bitfield[ #"ammomod_lightray_healed" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"ammomod_lightray_healed" );
    zm_interact_bitfield[ #"hash_342f380b82a1456a" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"hash_342f380b82a1456a" );
    zm_interact_bitfield[ #"magicbox_melee_share" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"magicbox_melee_share" );
    zm_interact_bitfield[ #"loose_change_collected" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"loose_change_collected" );
    zm_interact_bitfield[ #"hash_cfd61d3a394ba4eb" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"hash_cfd61d3a394ba4eb" );
    zm_interact_bitfield[ #"zm_sat_hornet_assault_round_success" ] = ae_utility::function_2d1565a236387b2( #"zm_interact_bitfield", #"zm_sat_hornet_assault_round_success" );
    level.zm_interact_bitfield = zm_interact_bitfield;
    return zm_interact_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xf84ebe75, Offset: 0x9dc4
// Size: 0x1ba
function get_zm_round_bitfield_array()
{
    if ( isdefined( level.zm_round_bitfield ) && isdefined( level.zm_round_bitfield.size ) && level.zm_round_bitfield.size != 0 )
    {
        return level.zm_round_bitfield;
    }
    
    zm_round_bitfield = [];
    zm_round_bitfield[ #"hash_25db9d7573e5e3bf" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_25db9d7573e5e3bf" );
    zm_round_bitfield[ #"hash_efa7699c5e0ba053" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_efa7699c5e0ba053" );
    zm_round_bitfield[ #"never_downed" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"never_downed" );
    zm_round_bitfield[ #"hash_39bbd352b0711afd" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_39bbd352b0711afd" );
    zm_round_bitfield[ #"no_doorbuys_opened" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"no_doorbuys_opened" );
    zm_round_bitfield[ #"hash_25e909303a59d8a0" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_25e909303a59d8a0" );
    zm_round_bitfield[ #"hash_5af92d0965e172b9" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_5af92d0965e172b9" );
    zm_round_bitfield[ #"hash_51d929a6bc477559" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_51d929a6bc477559" );
    zm_round_bitfield[ #"was_frozen" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"was_frozen" );
    zm_round_bitfield[ #"is_special_round" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"is_special_round" );
    level.zm_round_bitfield = zm_round_bitfield;
    return zm_round_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x8c281f1c, Offset: 0x9f87
// Size: 0x179
function function_53fb55561443adaf()
{
    zm_round_bitfield = [];
    zm_round_bitfield[ #"hash_a7a59d75caaf58fa" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_a7a59d75caaf58fa" );
    zm_round_bitfield[ #"hash_e712874f2a4d1e3b" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_e712874f2a4d1e3b" );
    zm_round_bitfield[ #"hash_7a4e6dfddc99401d" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_7a4e6dfddc99401d" );
    zm_round_bitfield[ #"hash_51d929a6bc477559" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_51d929a6bc477559" );
    zm_round_bitfield[ #"hash_25e909303a59d8a0" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_25e909303a59d8a0" );
    zm_round_bitfield[ #"hash_8f576fcf4ee3db88" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_8f576fcf4ee3db88" );
    zm_round_bitfield[ #"hash_40bc34d46eeefe4b" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"hash_40bc34d46eeefe4b" );
    zm_round_bitfield[ #"is_special_round" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"is_special_round" );
    zm_round_bitfield[ #"no_doorbuys_opened" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"no_doorbuys_opened" );
    zm_round_bitfield[ #"was_frozen" ] = ae_utility::function_2d1565a236387b2( #"zm_round_bitfield", #"was_frozen" );
    return zm_round_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x88c18112, Offset: 0xa109
// Size: 0xc5
function function_5355ce24d6ae2018()
{
    zm_get_medals_bitfield = [];
    zm_get_medals_bitfield[ #"hash_5627429a74a37b7" ] = ae_utility::function_2d1565a236387b2( #"zm_medal_bitfield", #"hash_5627429a74a37b7" );
    zm_get_medals_bitfield[ #"medal_crispy" ] = ae_utility::function_2d1565a236387b2( #"zm_medal_bitfield", #"medal_crispy" );
    zm_get_medals_bitfield[ #"medal_shieldbreaker" ] = ae_utility::function_2d1565a236387b2( #"zm_medal_bitfield", #"medal_shieldbreaker" );
    zm_get_medals_bitfield[ #"medal_supercriticalcanine" ] = ae_utility::function_2d1565a236387b2( #"zm_medal_bitfield", #"medal_supercriticalcanine" );
    zm_get_medals_bitfield[ #"medal_duelist" ] = ae_utility::function_2d1565a236387b2( #"zm_medal_bitfield", #"medal_duelist" );
    return zm_get_medals_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x29dac3a6, Offset: 0xa1d7
// Size: 0x9a
function get_zm_purchase_bitfield_array()
{
    if ( isdefined( level.zm_purchase_bitfield ) && isdefined( level.zm_purchase_bitfield.size ) && level.zm_purchase_bitfield.size != 0 )
    {
        return level.zm_purchase_bitfield;
    }
    
    zm_purchase_bitfield = [];
    zm_purchase_bitfield[ #"hash_802e17ea8d5c269d" ] = ae_utility::function_2d1565a236387b2( #"zm_purchase_bitfield", #"hash_802e17ea8d5c269d" );
    zm_purchase_bitfield[ #"hash_16dcd68e635c9cbe" ] = ae_utility::function_2d1565a236387b2( #"zm_purchase_bitfield", #"hash_16dcd68e635c9cbe" );
    level.zm_purchase_bitfield = zm_purchase_bitfield;
    return zm_purchase_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xaade755d, Offset: 0xa27a
// Size: 0x6a6
function function_77862a3ac198ca62()
{
    if ( isdefined( level.zm_quest_type ) && isdefined( level.zm_quest_type.size ) && level.zm_quest_type.size != 0 )
    {
        return level.zm_quest_type;
    }
    
    zm_quest_type = [];
    zm_quest_type[ #"zm_t10_garnet_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_t10_garnet_mq" );
    zm_quest_type[ #"hash_35d9cda6e2eb2d59" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_35d9cda6e2eb2d59" );
    zm_quest_type[ #"any_hidden_ee" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"any_hidden_ee" );
    zm_quest_type[ #"hash_14fd2df8c657c9e4" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_14fd2df8c657c9e4" );
    zm_quest_type[ #"hash_18e6f3365db404a1" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_18e6f3365db404a1" );
    zm_quest_type[ #"hash_b7bed27835857d00" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_b7bed27835857d00" );
    zm_quest_type[ #"hash_8067331e537e4778" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_8067331e537e4778" );
    zm_quest_type[ #"hash_386c8969bdff903a" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_386c8969bdff903a" );
    zm_quest_type[ #"zm_t10_jade_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_t10_jade_mq" );
    zm_quest_type[ #"zm_sat_firefly_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_firefly_mq" );
    zm_quest_type[ #"hash_4bfb1e1d1b7518e2" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_4bfb1e1d1b7518e2" );
    zm_quest_type[ #"zm_sat_dempsey_ee" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_dempsey_ee" );
    zm_quest_type[ #"zm_sat_firefly_dmps_ee" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_firefly_dmps_ee" );
    zm_quest_type[ #"zm_sat_firefly_slorpy_quest" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_firefly_slorpy_quest" );
    zm_quest_type[ #"bullseye_ee" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"bullseye_ee" );
    zm_quest_type[ #"is_main_quest" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"is_main_quest" );
    zm_quest_type[ #"ruby_pap" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"ruby_pap" );
    zm_quest_type[ #"r_mod_unlock" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"r_mod_unlock" );
    zm_quest_type[ #"zm_sat_ruby_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_ruby_mq" );
    zm_quest_type[ #"zm_sat_ruby_sq_echoes" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_ruby_sq_echoes" );
    zm_quest_type[ #"r_mod_unlock_ruby" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"r_mod_unlock_ruby" );
    zm_quest_type[ #"hash_27822ef1318a56d" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_27822ef1318a56d" );
    zm_quest_type[ #"hash_d8480ab5fe951793" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_d8480ab5fe951793" );
    zm_quest_type[ #"zm_sat_mantis_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_mantis_mq" );
    zm_quest_type[ #"hash_429e3b403a0d6aad" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_429e3b403a0d6aad" );
    zm_quest_type[ #"zm_sat_locust_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_locust_mq" );
    zm_quest_type[ #"hash_f4e9aa4b1cdb96a9" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_f4e9aa4b1cdb96a9" );
    zm_quest_type[ #"hash_b0a4a3586a7d8781" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_b0a4a3586a7d8781" );
    zm_quest_type[ #"hash_7a419acaa1cd605f" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_7a419acaa1cd605f" );
    zm_quest_type[ #"hash_c600658fe1a5ad9f" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_c600658fe1a5ad9f" );
    zm_quest_type[ #"hash_f9f817db9f222614" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_f9f817db9f222614" );
    zm_quest_type[ #"zm_sat_hornet_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_hornet_mq" );
    zm_quest_type[ #"zm_sat_scarab_mq" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_scarab_mq" );
    zm_quest_type[ #"hash_40a87ea5e50a468b" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_40a87ea5e50a468b" );
    zm_quest_type[ #"hash_58325bc2d2c7df55" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_58325bc2d2c7df55" );
    zm_quest_type[ #"hash_d9803c2cd329e3ab" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_d9803c2cd329e3ab" );
    zm_quest_type[ #"hash_33247e43e074586c" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_33247e43e074586c" );
    zm_quest_type[ #"hash_d8231004a6da13db" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_d8231004a6da13db" );
    zm_quest_type[ #"hash_c4ee866a99e123b1" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_c4ee866a99e123b1" );
    zm_quest_type[ #"hash_41fe2d401527b850" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_41fe2d401527b850" );
    zm_quest_type[ #"hash_8f4de46115e0d713" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_8f4de46115e0d713" );
    zm_quest_type[ #"hash_560db69c562e574c" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_560db69c562e574c" );
    zm_quest_type[ #"zm_sat_scarab_dance_ee" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"zm_sat_scarab_dance_ee" );
    zm_quest_type[ #"hash_c160143b866710ac" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_c160143b866710ac" );
    zm_quest_type[ #"hash_7f142f510dae3c5f" ] = ae_utility::function_2d1565a236387b2( #"zm_quest_bitfield", #"hash_7f142f510dae3c5f" );
    level.zm_quest_type = zm_quest_type;
    return zm_quest_type;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xfb3c0357, Offset: 0xa929
// Size: 0xe2
function function_b42a6901df822ab()
{
    if ( isdefined( level.zm_gobblegum_type ) && isdefined( level.zm_gobblegum_type.size ) && level.zm_gobblegum_type.size != 0 )
    {
        return level.zm_gobblegum_type;
    }
    
    zm_gobblegum_type = [];
    zm_gobblegum_type[ #"idle_eyes" ] = ae_utility::function_2d1565a236387b2( #"zm_gobblegum_bitfield", #"idle_eyes" );
    zm_gobblegum_type[ #"free_fire" ] = ae_utility::function_2d1565a236387b2( #"zm_gobblegum_bitfield", #"free_fire" );
    zm_gobblegum_type[ #"shields_up" ] = ae_utility::function_2d1565a236387b2( #"zm_gobblegum_bitfield", #"shields_up" );
    zm_gobblegum_type[ #"anywhere_but_here" ] = ae_utility::function_2d1565a236387b2( #"zm_gobblegum_bitfield", #"anywhere_but_here" );
    level.zm_gobblegum_type = zm_gobblegum_type;
    return zm_gobblegum_type;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x3acaf940, Offset: 0xaa14
// Size: 0x1e5
function function_4e695aee1675ae93()
{
    if ( level.zm_map_bitfield.size > 0 )
    {
        return level.zm_map_bitfield;
    }
    
    zm_map_bitfield = [];
    zm_map_bitfield[ #"zm_t10_bloodstone" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_t10_bloodstone" );
    zm_map_bitfield[ #"zm_t10_garnet" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_t10_garnet" );
    zm_map_bitfield[ #"zm_t10_opal" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_t10_opal" );
    zm_map_bitfield[ #"zm_t10_quartz" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_t10_quartz" );
    zm_map_bitfield[ #"zm_t10_topaz" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_t10_topaz" );
    zm_map_bitfield[ #"zm_t10_jade" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_t10_jade" );
    zm_map_bitfield[ #"zm_sat_firefly" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_sat_firefly" );
    zm_map_bitfield[ #"zm_sat_ruby" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_sat_ruby" );
    zm_map_bitfield[ #"zm_sat_mantis" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_sat_mantis" );
    zm_map_bitfield[ #"zm_sat_locust" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_sat_locust" );
    zm_map_bitfield[ #"zm_sat_hornet" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_sat_hornet" );
    zm_map_bitfield[ #"zm_sat_scarab" ] = ae_utility::function_2d1565a236387b2( #"zm_map_name", #"zm_sat_scarab" );
    level.zm_map_bitfield = zm_map_bitfield;
    return zm_map_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x60b122ab, Offset: 0xac02
// Size: 0x155
function function_996564cd0853c418()
{
    if ( level.zm_survival_poi_bitfield.size > 0 )
    {
        return level.zm_survival_poi_bitfield;
    }
    
    zm_survival_poi_bitfield = [];
    zm_survival_poi_bitfield[ #"zone_farm" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"zone_farm" );
    zm_survival_poi_bitfield[ #"zone_exit115" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"zone_exit115" );
    zm_survival_poi_bitfield[ #"zone_launchpad" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"zone_launchpad" );
    zm_survival_poi_bitfield[ #"ashwood" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"ashwood" );
    zm_survival_poi_bitfield[ #"zone_temple" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"zone_temple" );
    zm_survival_poi_bitfield[ #"future" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"future" );
    zm_survival_poi_bitfield[ #"zone_lighthouse" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"zone_lighthouse" );
    zm_survival_poi_bitfield[ #"castle" ] = ae_utility::function_2d1565a236387b2( #"zm_survival_poi", #"castle" );
    level.zm_survival_poi_bitfield = zm_survival_poi_bitfield;
    return zm_survival_poi_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0xa6af1f16, Offset: 0xad60
// Size: 0x7d
function function_e5f7d63b6e91046d()
{
    if ( level.var_bd6697cfade438f0.size > 0 )
    {
        return level.var_bd6697cfade438f0;
    }
    
    var_bd6697cfade438f0 = [];
    var_bd6697cfade438f0[ #"hash_2db6418a72d47cd0" ] = ae_utility::function_2d1565a236387b2( #"zm_gametype_mrules", #"hash_2db6418a72d47cd0" );
    var_bd6697cfade438f0[ #"hash_59ea62cf052daf65" ] = ae_utility::function_2d1565a236387b2( #"zm_gametype_mrules", #"hash_59ea62cf052daf65" );
    level.var_bd6697cfade438f0 = var_bd6697cfade438f0;
    return var_bd6697cfade438f0;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x506dbb4a, Offset: 0xade6
// Size: 0x545
function get_zm_relics_active_bitfield_array()
{
    if ( level.zm_relics_active_bitfield.size > 0 )
    {
        return level.zm_relics_active_bitfield;
    }
    
    zm_relics_active_bitfield = [];
    zm_relics_active_bitfield[ #"hash_aacd4365e60dc230" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_ae70861ea4724b05" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_beta_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_beta_relic" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_delta_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_delta_relic" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_epsilon_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_epsilon_relic" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_eta_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_eta_relic" );
    zm_relics_active_bitfield[ #"hash_adfdde6553b39411" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_ed196f1a52ef8db4" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_iota_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_iota_relic" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_kappa_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_kappa_relic" );
    zm_relics_active_bitfield[ #"hash_c132ef48706d5ca7" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_45a316821c9948a8" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_mu_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_mu_relic" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_nu_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_nu_relic" );
    zm_relics_active_bitfield[ #"hash_2afa05937b627fcb" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_11b3ebc134bd2c42" );
    zm_relics_active_bitfield[ #"hash_8b3726fa245ee210" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_d077909a8a10d705" );
    zm_relics_active_bitfield[ #"sat_zm_firefly_xi_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_firefly_xi_relic" );
    zm_relics_active_bitfield[ #"hash_215217151651f692" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_bcbb82ba0e502259" );
    zm_relics_active_bitfield[ #"sat_zm_ruby_phi_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_ruby_phi_relic" );
    zm_relics_active_bitfield[ #"sat_zm_ruby_pi_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_ruby_pi_relic" );
    zm_relics_active_bitfield[ #"sat_zm_ruby_rho_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_ruby_rho_relic" );
    zm_relics_active_bitfield[ #"sat_zm_ruby_sigma_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_ruby_sigma_relic" );
    zm_relics_active_bitfield[ #"sat_zm_ruby_tau_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_ruby_tau_relic" );
    zm_relics_active_bitfield[ #"sat_zm_ruby_upsilon_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_ruby_upsilon_relic" );
    zm_relics_active_bitfield[ #"zm_sat_mantis_heta_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_sat_mantis_heta_relic" );
    zm_relics_active_bitfield[ #"zm_sat_mantis_koppa_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_sat_mantis_koppa_relic" );
    zm_relics_active_bitfield[ #"zm_sat_mantis_sampi_relic" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"zm_sat_mantis_sampi_relic" );
    zm_relics_active_bitfield[ #"sat_zm_locust_alpha_cr" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_ddfc781d487c49c4" );
    zm_relics_active_bitfield[ #"sat_zm_locust_cancer_cr" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_4ea875d4c5f155a0" );
    zm_relics_active_bitfield[ #"sat_zm_locust_gamma_cr" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_a635e248f06290e3" );
    zm_relics_active_bitfield[ #"sat_zm_locust_lambda_cr" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_eda8b630f5a27675" );
    zm_relics_active_bitfield[ #"sat_zm_locust_leo_cr" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_356ba8d26e7f1da4" );
    zm_relics_active_bitfield[ #"sat_zm_locust_taurus_cr" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_285f7e1bf4718ac8" );
    zm_relics_active_bitfield[ #"hash_a04bf8924a51558d" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_bc0c8b6ed4791460" );
    zm_relics_active_bitfield[ #"hash_cccf3546fd2ffb9a" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_77c4a79619817f73" );
    zm_relics_active_bitfield[ #"hash_1fc7cb59dbbfcee" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_7af3212979ca5ccd" );
    zm_relics_active_bitfield[ #"hash_2efc350b1167e37f" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_5a6b2951439d6aa2" );
    zm_relics_active_bitfield[ #"hash_184d1e56b412676" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_1aef9279537e0577" );
    zm_relics_active_bitfield[ #"hash_617a7afcdd8a1d6b" ] = ae_utility::function_2d1565a236387b2( #"zm_relics_active_bitfield", #"hash_2ee2204115fc3c70" );
    level.zm_relics_active_bitfield = zm_relics_active_bitfield;
    return zm_relics_active_bitfield;
}

// Namespace zombie_challenges
// Params 0
// Checksum 0x5517c854, Offset: 0xb334
// Size: 0x59
function function_843f8b4c377ef508()
{
    if ( level.var_a653e329656d421f.size > 0 )
    {
        return level.var_a653e329656d421f;
    }
    
    var_a653e329656d421f = [];
    var_a653e329656d421f[ #"ol_tessie_race" ] = ae_utility::function_2d1565a236387b2( #"hash_e576037392c126c0", #"ol_tessie_race" );
    level.var_a653e329656d421f = var_a653e329656d421f;
    return var_a653e329656d421f;
}

// Namespace zombie_challenges
// Params 1, eflags: 0x4
// Checksum 0xbd37912e, Offset: 0xb396
// Size: 0xff
function private function_d0d158594d322667( sparams )
{
    player = sparams.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    victimstruct = sparams.victimstruct;
    
    if ( !isdefined( victimstruct.subclass ) )
    {
        return;
    }
    
    zombie_name = getxhash( victimstruct.subclass );
    
    if ( !isdefined( player.var_45a4ac1d19aac911 ) )
    {
        player.var_45a4ac1d19aac911 = [];
    }
    
    if ( !isdefined( player.var_45a4ac1d19aac911[ zombie_name ] ) )
    {
        player.var_45a4ac1d19aac911[ zombie_name ] = 0;
    }
    
    player.var_45a4ac1d19aac911[ zombie_name ]++;
    
    if ( isdefined( player.var_45a4ac1d19aac911[ #"zombie_amalgam" ] ) && player.var_45a4ac1d19aac911[ #"zombie_amalgam" ] >= 2 )
    {
        player function_8c4b87e9914a3388( #"hash_ac9c3b94e1b00d8" );
    }
}

