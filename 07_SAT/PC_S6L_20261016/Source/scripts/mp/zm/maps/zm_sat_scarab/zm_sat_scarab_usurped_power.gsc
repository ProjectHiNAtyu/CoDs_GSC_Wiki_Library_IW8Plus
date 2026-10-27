// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_usurped_power.gsc  (hash_2609e086157464e0.gscc) (size: 18394 Bytes / 0x47da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e15ab49 (504736585)
// size ...... 18394 (0x47da)
// includes .. 22  (offset: 0x40fa)
// strings ... 101 (offset: 0x41aa)
// dev strs .. 0   (offset: 0x47da)
// exports ... 23  (offset: 0x2c6e)
// cseg ...... 0x95b + 0x2313 (0x2c6e)
// imports ... 142 (offset: 0x3006)
// animtree1 . 0   (offset: 0x47da)
// animtree2 . 0   (offset: 0x47da)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\equipment;
#using scripts\mp\equipmentdeploy;
#using scripts\mp\gametypes\common;
#using scripts\mp\health_overcharge;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\supers;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_pap_quest;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_usurped_power;

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0xc04b65da, Offset: 0x979
// Size: 0xea
function init()
{
    level.usurpedpowerbundle = equipment_mp::getEquipmentBundleFromWeaponName( "t10_inc_fire_zm_scarab_torch" );
    level.equipment.callbacks[ "equip_inc_fire_t10_zm_scarab_torch" ][ "onFired" ] = &onequipmentfired;
    level.equipment.callbacks[ "equip_inc_fire_t10_zm_scarab_torch_cosmic" ][ "onFired" ] = &onequipmentfired;
    level utility::add_fx( "up_fire_trail_fx", "vfx_sat_scarab_usurped_power_fireball_projectile" );
    level utility::add_fx( "up_fire_explosion_fx", "vfx_sat_scarab_usurped_power_fireball_explosion" );
    level utility::add_fx( "cosmic_fire_trail_fx", "vfx_sat_scarab_usurped_power_fireball_projectile_purple" );
    level.var_66fd79d91a313ecc = &get_molotov_data;
    level callback::add( #"on_ai_killed", &function_8ce2db0f40bc5f13 );
    equipment_mp::function_2e4e9b7492b36578( "equip_molotov_sat_zm_scarab_torch" );
    equipment_mp::function_2e4e9b7492b36578( "equip_molotov_sat_zm_purple" );
    equipment_mp::function_2e4e9b7492b36578( "t10_inc_fire_zm_scarab_torch" );
    equipment_mp::function_2e4e9b7492b36578( "t10_inc_fire_zm_scarab_torch_cosmic" );
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0x93182cf8, Offset: 0xa6b
// Size: 0xd9
function private function_8ce2db0f40bc5f13( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    weaponname = params.sweapon.basename ?? "";
    
    if ( weaponname != "t10_inc_fire_zm_scarab_torch" && weaponname != "t10_inc_fire_zm_scarab_torch_cosmic" && weaponname != "sat_molotov_zm_scarab_torch" && weaponname != "sat_molotov_zm_purple" )
    {
        return;
    }
    
    level.scarab_pap_quest thread zm_sat_scarab_pap_quest::play_vo_banter( #"hash_2049f009accbf065", 20, params.eattacker, undefined, 1 );
    waittillframeend();
    
    if ( weaponname == "t10_inc_fire_zm_scarab_torch_cosmic" || weaponname == "sat_molotov_zm_purple" )
    {
        self.var_e797f68de73ece4e = "_usurp_cosmic";
        return;
    }
    
    self.var_e797f68de73ece4e = "_usurp";
}

// Namespace zm_sat_scarab_usurped_power
// Params 2, eflags: 0x4
// Checksum 0x687b9edf, Offset: 0xb4c
// Size: 0x5d
function private get_usurped_power_fx_state( statepercent, var_997d4b6005a845d1 )
{
    if ( statepercent == 30 )
    {
        return ( var_997d4b6005a845d1 ? "f_carrying_fire_30_cosmic" : "f_carrying_fire_30" );
    }
    
    if ( statepercent == 60 )
    {
        return ( var_997d4b6005a845d1 ? "f_carrying_fire_60_cosmic" : "f_carrying_fire_60" );
    }
    
    return var_997d4b6005a845d1 ? "f_carrying_fire_100_cosmic" : "f_carrying_fire_100";
}

// Namespace zm_sat_scarab_usurped_power
// Params 3
// Checksum 0xf2579dd3, Offset: 0xbb2
// Size: 0x54b
function give_usurped_power( player, var_997d4b6005a845d1, additionalinfo )
{
    level endon( #"game_ended" );
    
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
    {
        return;
    }
    
    if ( !player isonground() && !player isswimming() )
    {
        return;
    }
    
    if ( player isonladder() || player function_41360f0bcfc012aa() )
    {
        return;
    }
    
    if ( player utility::ent_flag( "is_usurped_power_grabbed" ) )
    {
        return;
    }
    
    if ( player.var_7a1bba3b82189d4c )
    {
        return;
    }
    
    equipmentweaponname = var_997d4b6005a845d1 ? "t10_inc_fire_zm_scarab_torch_cosmic" : "t10_inc_fire_zm_scarab_torch";
    
    if ( !player candomonitoredswitchtoweapon( equipmentweaponname ) )
    {
        return;
    }
    
    player utility::ent_flag_set( "is_usurped_power_grabbed" );
    
    if ( var_997d4b6005a845d1 )
    {
        player utility::ent_flag_set( "holding_cosmic_usurped_power" );
        player utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", get_usurped_power_fx_state( 100, 1 ) );
        var_877ea1a0b9a95b4c = player.var_68e0e97561171104.overcharge_sources[ "usurped_power" ] ?? 0;
        var_9c5719d336ead8d0 = max( 0, 50 - var_877ea1a0b9a95b4c );
        
        if ( var_9c5719d336ead8d0 > 0 )
        {
            health_overcharge::function_f6da758a8ee4c988( player, "usurped_power", var_9c5719d336ead8d0 );
        }
        
        player weapons::addextramovespeed( "usurped_power", 0.4 );
        
        if ( !player common::function_8ff835bf23198a0( "usurped_power" ) )
        {
            player common::function_ac4bf3256b2545e3( "usurped_power", 0.4 );
        }
        
        player weapons::updatemovespeedscale();
        level notify( #"cosmic_usurped_power_deployed" );
    }
    else
    {
        player utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", get_usurped_power_fx_state( 100, 0 ) );
        level notify( #"usurped_power_deployed" );
    }
    
    equipref = var_997d4b6005a845d1 ? "equip_inc_fire_t10_zm_scarab_torch_cosmic" : "equip_inc_fire_t10_zm_scarab_torch";
    deployweapon = level.equipment.table[ equipref ].objweapon;
    
    if ( !isdefined( deployweapon ) )
    {
        deployweapon = makeweapon( equipmentweaponname );
    }
    
    equipinfo = { #additionalinfo:additionalinfo, #var_997d4b6005a845d1:var_997d4b6005a845d1, #team:player.team, #owner:player, #deployweapon:deployweapon };
    equipinfo.fireballs = [];
    equipinfo.var_21f1b0b4d8d3ea8f = "usurped_power";
    player.var_505f402b07ceece1 = equipinfo;
    timeoutendons = [ "usurped_power_restore", "death_or_disconnect", "cancel_all_equip_deployments", "equip_finished_with_deploy_weapon" ];
    level val::group_register( equipinfo.var_21f1b0b4d8d3ea8f, [ "weapon_switch", "interactions", "weapon_pickup", "allow_scripted_bgb_use", "supers", "killstreaks", "ledgehang", "melee", "allow_full_ammo_powerup" ] );
    player val::set( equipinfo.var_21f1b0b4d8d3ea8f, "offhand_secondary_weapons", 0 );
    player utility::delaythreadendon( 1, timeoutendons, &val::reset, equipinfo.var_21f1b0b4d8d3ea8f, "offhand_secondary_weapons" );
    player val::set_array( equipinfo.var_21f1b0b4d8d3ea8f, [ "disallow_weapon_wallbuy", "disallow_magicbox", "disallow_loot_but_auto_loot" ], 1 );
    player.ammo_cache_disabled = 1;
    player.arsenal_disabled = 1;
    timeoutduration = var_997d4b6005a845d1 ? 20 + ( level zm_quest::function_b0a5181ebe7bb905() ? 5 : 0 ) : additionalinfo.var_3dfb48cd2da760ed ? 45 : 60;
    equipinfo.timeduration = timeoutduration;
    
    if ( var_997d4b6005a845d1 )
    {
        player.var_499637249aa97555 = gettime() + int( utility::function_4b74c15943231980( timeoutduration ) );
    }
    
    player utility::delaythreadendon( timeoutduration, timeoutendons, &restoreplayer );
    player callback::callback( "usurped_power_deploying", { #deployweapon:deployweapon, #equipinfo:equipinfo, #player:player } );
    player canceloffhands();
    player cancelgrapple();
    player releaseoffhand();
    player stopanimscriptsceneevent();
    player stopgestureviewmodel();
    
    if ( player isviewmodelanimplaying() )
    {
        player stopviewmodelanim();
    }
    
    deployresult = player equipmentdeploy::function_465d5501b11f1b36( equipinfo, deployweapon, "grenade_fire", undefined, &onswitchended, &onequipmentfired, &function_f5c3aee3d143ba01 );
    equipinfo.deployresult = deployresult;
    
    if ( !deployresult )
    {
        player utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", "off" );
        player callback::callback( "usurped_power_switch_fail", { #deployresult:deployresult, #equipinfo:equipinfo, #player:player } );
        player restoreplayer();
    }
    
    player callback::callback( "usurped_power_deployed", { #deployresult:deployresult, #deployweapon:deployweapon, #equipinfo:equipinfo, #player:player } );
    player val::reset_all( equipinfo.var_21f1b0b4d8d3ea8f );
    return equipinfo;
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0x2c18d8f7, Offset: 0x1106
// Size: 0x12a, Type: bool
function private candomonitoredswitchtoweapon( baseweaponname )
{
    if ( !val::get( "weapon" ) )
    {
        return false;
    }
    
    if ( !val::get( "weapon_switch" ) && !val::get( "script_weapon_switch" ) )
    {
        return false;
    }
    
    if ( self isviewmodelanimplaying() )
    {
        return false;
    }
    
    currenthighpriorityweapon = inventory_utility::getcurrentmonitoredweaponswitchweapon();
    
    if ( isdefined( currenthighpriorityweapon ) )
    {
        weaponbasename = baseweaponname;
        newweaponhaspriority = 0;
        
        if ( weaponbasename == "briefcase_bomb_mp" || weaponbasename == "briefcase_bomb_defuse_mp" || weaponbasename == "briefcase_silent_mp" || weaponbasename == "briefcase_defuse_silent_mp" || weaponbasename == "counter_attack_bomb_mp" || weaponbasename == "counter_attack_bomb_defuse_mp" || weaponbasename == "counter_attack_bomb_silent_mp" || weaponbasename == "counter_attack_bomb_defuse_silent_mp" || weaponbasename == "briefcase_bomb_mp_nuke" || weaponbasename == "iw9_cyberemp_mp" || weaponbasename == "iw7_tdefball_mp" || weaponbasename == "rex_hijack_bomb_carry_mp" )
        {
            newweaponhaspriority = 1;
        }
        else if ( weaponinventorytype( currenthighpriorityweapon ) == "primary" )
        {
            newweaponhaspriority = 1;
        }
        
        if ( !newweaponhaspriority )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_usurped_power
// Params 3, eflags: 0x4
// Checksum 0x561fa22e, Offset: 0x1239
// Size: 0x7c
function private function_f5c3aee3d143ba01( equipinfo, switchresult, deployweaponobj )
{
    restoreplayer();
    inventory_utility::getridofweapon( deployweaponobj, istrue( self.var_45ab03788f1a0a4d ) );
    self.var_45ab03788f1a0a4d = undefined;
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.basename == "none" )
    {
        inventory_utility::forcevalidweapon();
    }
    
    if ( switchresult )
    {
        function_8817bc70cda7e0c3( equipinfo );
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0xd1a61581, Offset: 0x12bd
// Size: 0x67
function private function_8817bc70cda7e0c3( equipinfo )
{
    if ( !isdefined( equipinfo ) || self.var_505f402b07ceece1 != equipinfo )
    {
        return;
    }
    
    callback::callback( "usurped_power_finished", { #switchresult:1, #equipinfo:equipinfo, #player:self } );
    self notify( #"usurped_power_finished" );
    self.var_505f402b07ceece1 = undefined;
}

// Namespace zm_sat_scarab_usurped_power
// Params 1
// Checksum 0xff1e08f1, Offset: 0x132c
// Size: 0x296
function restoreplayer( check_volume )
{
    self endon( #"death_or_disconnect" );
    
    if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( self, 0, 1 ) )
    {
        return;
    }
    
    if ( !utility::ent_flag( "is_usurped_power_grabbed" ) )
    {
        return;
    }
    
    if ( self.a_saved_weapons )
    {
        var_e186aae232a8ab4f = self.a_saved_weapons[ "equip_secondary" ][ "weapon" ];
        var_73d638367af1fe67 = 0;
        
        if ( equipment_mp::getequipmentreffromweapon( var_e186aae232a8ab4f ) == "equip_grappling_hook" || equipment_mp::getequipmentreffromweapon( var_e186aae232a8ab4f ) == "equip_grappling_hook_upgraded" || self.var_87522aee8be7890b.ref || self.var_819dfee5ff9a56d6 )
        {
            var_73d638367af1fe67 = 1;
        }
        
        var_20231d0ef435c90e = self.old_weapon_obj ?? self.a_saved_weapons[ "primary" ][ "weapon" ];
        zm_utility::function_663d59490abc834f( var_20231d0ef435c90e, undefined, undefined, var_73d638367af1fe67 );
    }
    
    suit = utility::function_f825237e0eda5adf();
    player::_setsuit( suit );
    utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", "off" );
    
    if ( utility::ent_flag( "holding_cosmic_usurped_power" ) )
    {
        weapons::removeextramovespeed( "usurped_power" );
        
        if ( common::function_8ff835bf23198a0( "usurped_power" ) )
        {
            common::function_d85a92c557ea5a52( "usurped_power" );
        }
        
        weapons::updatemovespeedscale();
        utility::ent_flag_clear( "holding_cosmic_usurped_power" );
        self.var_499637249aa97555 = undefined;
    }
    
    self notify( #"usurped_power_restore" );
    self notify( #"equip_finished_with_deploy_weapon" );
    utility::ent_flag_clear( "is_usurped_power_grabbed" );
    
    if ( self.var_b8f7685b92948edf && self.var_b8f7685b92948edf.size > 0 )
    {
        self.var_b8f7685b92948edf = arrayremove( self.var_b8f7685b92948edf, &restoreplayer );
    }
    
    self.ammo_cache_disabled = 0;
    self.arsenal_disabled = 0;
    callback::callback( "usurped_power_removed", { #player:self } );
    
    if ( self.var_505f402b07ceece1.switchresult )
    {
        thread function_8817bc70cda7e0c3( self.var_505f402b07ceece1 );
    }
    
    if ( self.var_b5e2fe4feddf6164 )
    {
        wait 1;
        full_ammo::function_cf46f312587658ee();
        self.var_b5e2fe4feddf6164 = undefined;
    }
    
    var_b1a757fc9a331099 = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_ol_reliable" );
    
    if ( var_b1a757fc9a331099 && isdefined( self.var_3bf72dcd2775aa78 ) && !self hasweapon( self.var_3bf72dcd2775aa78 ) )
    {
        thread function_c4b108df5d4f5dcd();
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 0, eflags: 0x4
// Checksum 0xa8a3d738, Offset: 0x15ca
// Size: 0x114
function private function_c4b108df5d4f5dcd()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( isplayer( self ) )
    {
        item_weapon::function_96add18b226ff731( self.var_3bf72dcd2775aa78 );
        var_8bb1b2bde27b267c = self.var_a7acf43fb611891 ?? utility::get_max_stock_ammo( self.var_3bf72dcd2775aa78, 1 );
        self setweaponammostock( self.var_3bf72dcd2775aa78, var_8bb1b2bde27b267c );
        
        if ( isdefined( self.var_18988f80052a4d58 ) )
        {
            item_weapon::function_40e1cbd0e1f47d1a( self.var_3bf72dcd2775aa78, self.var_18988f80052a4d58 );
        }
        
        if ( isdefined( self.var_15c8a1faad39f870 ) )
        {
            utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", self.var_3bf72dcd2775aa78, self.var_15c8a1faad39f870, 0 );
        }
        
        if ( isdefined( self.var_bbc0991cb44019fc ) )
        {
            if ( utility::issharedfuncdefined( #"ammo_mod", #"hash_24f1a2cf1ed6660d" ) )
            {
                utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", self.var_3bf72dcd2775aa78, self.var_bbc0991cb44019fc, 0 );
            }
        }
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 2, eflags: 0x4
// Checksum 0xe806af40, Offset: 0x16e6
// Size: 0x346
function private onswitchended( equipinfo, switchresult )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    equipinfo.switchresult = switchresult;
    
    if ( !switchresult )
    {
        self.var_505f402b07ceece1 = undefined;
        utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", "off" );
        callback::callback( "usurped_power_switch_fail", { #switchresult:switchresult, #equipinfo:equipinfo, #player:self } );
        restoreplayer();
        return;
    }
    
    zm_utility::function_d47920bb0d5fa327( "scarab_usurpedpower" );
    var_2273f954ad3787c4 = self.equipment[ "secondary" ] == "equip_grappling_hook" || self.equipment[ "secondary" ] == "equip_grappling_hook_upgraded";
    zm_utility::function_92275a9d3969d91d( undefined, undefined, undefined, undefined, var_2273f954ad3787c4 );
    player::_setsuit( "sat_defaultsuit_zm_scarab_torch" );
    supers_mp::clearsuper( 1 );
    self cancelgrapple();
    
    if ( equipinfo.additionalinfo.var_3dfb48cd2da760ed )
    {
        if ( equipinfo.additionalinfo.ammocount )
        {
            self setweaponammoclip( equipinfo.deployweapon, equipinfo.additionalinfo.ammocount );
        }
        else
        {
            self givemaxammo( equipinfo.deployweapon );
        }
    }
    
    if ( !isdefined( self.var_b8f7685b92948edf ) )
    {
        self.var_b8f7685b92948edf = [];
    }
    
    self.var_b8f7685b92948edf[ self.var_b8f7685b92948edf.size ] = &restoreplayer;
    thread function_cf2eadf4cfd227de();
    
    if ( !utility::ent_flag( "first_usurped_power" ) )
    {
        utility::ent_flag_set( "first_usurped_power" );
        thread ww_shared::show_hud_tutorial_message( &"hash_163c70cdbb32baa5" );
    }
    
    thread function_51e87126c8e86f63( equipinfo );
    thread function_3330fc002bbcfd78( equipinfo );
    timeduration = equipinfo.timeduration;
    utility::delaythreadendon( timeduration * 0.4, [ "death_or_disconnect", "playing_game_over_scene", "last_stand_enter", "equip_finished_with_deploy_weapon", "cancel_deploy", "weapon_switch_started", "cancel_all_equip_deployments", "usurped_power_restore" ], &utility::function_7c10ea82c1e305b8, "scb_pq_fx_energy", get_usurped_power_fx_state( 60, equipinfo.var_997d4b6005a845d1 ) );
    utility::delaythreadendon( timeduration * 0.7, [ "death_or_disconnect", "playing_game_over_scene", "last_stand_enter", "equip_finished_with_deploy_weapon", "cancel_deploy", "weapon_switch_started", "cancel_all_equip_deployments", "usurped_power_restore" ], &utility::function_7c10ea82c1e305b8, "scb_pq_fx_energy", get_usurped_power_fx_state( 30, equipinfo.var_997d4b6005a845d1 ) );
    result = utility::waittill_any_in_array_return( [ "death_or_disconnect", "playing_game_over_scene", "last_stand_enter", "equip_finished_with_deploy_weapon", "cancel_deploy", "weapon_switch_started", "cancel_all_equip_deployments", "usurped_power_restore" ] );
    utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", "off" );
}

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0xeeabb567, Offset: 0x1a34
// Size: 0x41
function function_cf2eadf4cfd227de()
{
    self endon( #"death_or_disconnect", #"usurped_power_restore", #"cancel_all_equip_deployments", #"equip_finished_with_deploy_weapon" );
    level waittill( #"zmb_max_ammo_level" );
    self.var_b5e2fe4feddf6164 = 1;
}

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0xea2ec495, Offset: 0x1a7d
// Size: 0x2b
function function_9fc03331e9d54fd2()
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_819dfee5ff9a56d6 && !self function_41360f0bcfc012aa() )
    {
        waitframe();
        self stopgestureviewmodel();
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 3, eflags: 0x4
// Checksum 0x8fdb9e6a, Offset: 0x1ab0
// Size: 0x171
function private onequipmentfired( equipinfo, weaponobj, fireball )
{
    thread function_9fc03331e9d54fd2();
    fireball.equipinfo = equipinfo;
    
    if ( !isdefined( equipinfo.fireballs ) )
    {
        equipinfo.fireballs = [];
    }
    
    equipinfo.fireballs[ equipinfo.fireballs.size ] = fireball;
    self playsoundonmovingent( #"hash_44d187f56bbc28fe" );
    fireball.fireballfx = equipinfo.var_997d4b6005a845d1 ? utility::getfx( "cosmic_fire_trail_fx" ) : utility::getfx( "up_fire_trail_fx" );
    playfxontag( fireball.fireballfx, fireball, "tag_origin" );
    thread function_ad3ab4a8384d74f4( equipinfo, fireball, weaponobj );
    callback::callback( "usurped_power_fired", { #fireball:fireball, #weaponobj:weaponobj, #equipinfo:equipinfo, #player:self } );
    remainingammo = self getammocount( equipinfo.deployweapon );
    
    if ( remainingammo > 0 )
    {
        waitframe();
        remainingammo = self getammocount( equipinfo.deployweapon );
    }
    
    var_b298667debd88882 = remainingammo < 1;
    
    if ( var_b298667debd88882 && isalive( self ) )
    {
        restoreplayer();
    }
    
    return var_b298667debd88882 ? "success" : "continue";
}

// Namespace zm_sat_scarab_usurped_power
// Params 3, eflags: 0x4
// Checksum 0x86b80112, Offset: 0x1c2a
// Size: 0x305
function private function_ad3ab4a8384d74f4( equipinfo, fireball, weaponobj )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"hash_91190f763106885c" );
    fireball endon( #"death" );
    fireball thread utility::delete_after_delay( 8 );
    thread function_6385b32b47e4f654( fireball );
    fireball waittill( #"missile_stuck", stuckto, hitentpart, surfacetype, velocity, var_55bc4979ee147531, normal );
    
    if ( !equipinfo.var_997d4b6005a845d1 )
    {
        var_6a6aebeb09fa550 = utility::getfx( "up_fire_explosion_fx" );
        playfx( var_6a6aebeb09fa550, fireball.origin );
    }
    
    if ( !fireball.equipinfo.b_skip_molotov )
    {
        var_2f4d750bcced51a = vectornormalize( anglestoforward( self getgunangles() ) );
        var_b0ec4782a33e87a5 = vectornormalize( anglestoright( self getgunangles() ) );
        torchrange = 1000;
        torchspeed = 1000;
        var_55ceac6f42cd3527 = self geteye() + var_b0ec4782a33e87a5 * var_2f4d750bcced51a * -1;
        var_b09dc14de956f922 = self geteye() + var_2f4d750bcced51a * torchrange;
        impactvelocity = vectornormalize( var_b09dc14de956f922 - var_55ceac6f42cd3527 ) * torchspeed;
        fireball.var_61041a515545d346 = equipinfo.var_997d4b6005a845d1 ? #"zombie_kia_usurp_cosmic" : #"zombie_kia_usurp";
        stopfxontag( fireball.fireballfx, fireball, "tag_origin" );
        molotovname = equipinfo.var_997d4b6005a845d1 ? "sat_molotov_zm_purple" : "sat_molotov_zm_scarab_torch";
        molotovgrenade = makeweapon( molotovname );
        var_e8bc2eff36d2ee25 = self launchgrenade( molotovgrenade, fireball.origin, impactvelocity );
        var_e8bc2eff36d2ee25.fireball = fireball;
    }
    else if ( fireball )
    {
        fireball delete();
    }
    
    round_difficulty = zm_utility::get_round_number();
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    self radiusdamage( fireball.origin, 100, zombie_base_health, zombie_base_health * 0.6, self, "MOD_PROJECTILE_SPLASH", weaponobj );
    earthquake( 0.35, 0.5, fireball.origin, 300 );
    playrumbleonposition( "damage_heavy", fireball.origin );
    callback::callback( "usurped_power_land", { #weaponobj:weaponobj, #var_55bc4979ee147531:var_55bc4979ee147531, #stuckto:stuckto, #fireball:fireball, #equipinfo:equipinfo, #player:self } );
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0x1c0392f5, Offset: 0x1f37
// Size: 0x1e6
function private get_molotov_data( grenade )
{
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    damage_tick_rate = 0.5;
    var_9f850d4366c1e21e = 0.5;
    var_70e23e8ce05f7ac5 = 0.25;
    var_28ba0189b20bf308 = 0.17;
    
    if ( grenade.weapon_name == "sat_molotov_zm_purple" )
    {
        burnbundle = getscriptbundle( %"hash_76f08a49a597b861" );
        burnbundle.means_of_death = "MOD_ELEMENTAL_DARK";
        burnbundle.var_61041a515545d346 = "_usurp_cosmic";
    }
    else if ( grenade.weapon_name == "sat_molotov_zm_scarab_torch" )
    {
        burnbundle = getscriptbundle( %"hash_685d83ac47f97170" );
        burnbundle.var_61041a515545d346 = "_usurp";
    }
    else
    {
        return;
    }
    
    round_difficulty = zm_utility::get_round_number();
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    burnbundle.var_35807474702938c6 = 1;
    burnbundle.var_c3f25b11c2247a29 = int( zombie_base_health * var_9f850d4366c1e21e );
    burnbundle.var_78880e1476d45684 = int( zombie_base_health * var_70e23e8ce05f7ac5 );
    burnbundle.var_7ceb375188b38c13 = int( zombie_base_health * var_28ba0189b20bf308 );
    burnbundle.var_b4261d601af6a28a = 6;
    burnbundle.var_797382a688d68a64 = 6;
    burnbundle.var_209153533613c440 = 2;
    burnbundle.var_726e9b33a65af54f = 4;
    burnbundle.var_29dd3c8b7a515774 = damage_tick_rate;
    burnbundle.var_13727c7357581d8d = 0;
    burnbundle.molotov_damage_flags = 1073741824;
    grenade.var_5b038f631de3ad97 = burnbundle;
    
    if ( isdefined( grenade.fireball ) )
    {
        grenade.fireball.var_5b038f631de3ad97 = burnbundle;
    }
    
    return burnbundle;
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0x84b2781e, Offset: 0x2126
// Size: 0x1b2
function private function_6385b32b47e4f654( fireball )
{
    self endon( #"death_or_disconnect" );
    fireball endon( #"death" );
    
    while ( true )
    {
        var_d6e73970c1a32733 = getplayersinradius( fireball.origin, 65, undefined, 1, [ self ] );
        
        foreach ( player in var_d6e73970c1a32733 )
        {
            if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) )
            {
                continue;
            }
            
            fireball notify( #"missile_stuck", player );
            return;
        }
        
        var_2930ba2398818c6 = getaiarrayinradius( fireball.origin, 100 );
        
        foreach ( zombie in var_2930ba2398818c6 )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( !zombie tagexists( "j_spine4" ) || distancesquared( fireball.origin, zombie gettagorigin( "j_spine4", 1 ) ) > squared( 55 ) )
            {
                continue;
            }
            
            fireball notify( #"missile_stuck", zombie );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0x121548fc, Offset: 0x22e0
// Size: 0x3a8
function private function_51e87126c8e86f63( equipinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"usurped_power_restore", #"cancel_all_equip_deployments", #"equip_finished_with_deploy_weapon" );
    currentround = zm_utility::get_round_number();
    var_633489ee645e852b = int( namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", currentround ) );
    equipinfo.var_e71a91736918de1b = var_633489ee645e852b;
    
    if ( equipinfo.var_997d4b6005a845d1 )
    {
        equipinfo.var_e71a91736918de1b *= 1.2;
    }
    
    equipinfo.var_f65e14b8682e1504 = 75;
    var_1743d7de6d5bd6bf = 0;
    var_a8dbffa306ec9e71 = equipinfo.var_3dfb48cd2da760ed ? 35 : 20;
    var_7dff4eed3b9fde2c = var_633489ee645e852b * ( equipinfo.var_3dfb48cd2da760ed ? 0.8 : 0.6 );
    
    while ( true )
    {
        var_40465bf1f7337a23 = getaiarrayinradius( self.origin, 75 );
        
        foreach ( zombie in var_40465bf1f7337a23 )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( zombie.aicategory == "elite" || zombie.aicategory == "boss" || zombie.aicategory == "hvt" )
            {
                continue;
            }
            
            if ( zombie status_effects::function_fa35fc2723e956eb( "burn", "usurped_power" ) )
            {
                continue;
            }
            
            var_2f4d750bcced51a = anglestoforward( self getplayerangles() );
            var_ee6433c31961982d = vectornormalize( zombie.origin - self.origin );
            to_target_dot = vectordot( var_2f4d750bcced51a, var_ee6433c31961982d );
            
            if ( to_target_dot < 0.5 )
            {
                continue;
            }
            
            var_ed0d0651a82b76e3 = var_a8dbffa306ec9e71 * 0.66;
            
            if ( var_1743d7de6d5bd6bf >= var_ed0d0651a82b76e3 )
            {
                var_a77a7baed79d52a2 = var_7dff4eed3b9fde2c / 5;
            }
            else if ( var_1743d7de6d5bd6bf >= var_ed0d0651a82b76e3 * 0.5 )
            {
                var_a77a7baed79d52a2 = equipinfo.var_e71a91736918de1b / 5;
            }
            else
            {
                var_a77a7baed79d52a2 = equipinfo.var_e71a91736918de1b;
            }
            
            var_749345f344f55b77 = utility::ent_flag( "holding_cosmic_usurped_power" ) ? "purple_fire" : "fire";
            var_1f217c82f24fabf = utility::ent_flag( "holding_cosmic_usurped_power" ) ? "_usurp_cosmic" : "_usurp";
            zombie thread effect_burn::burn( 5, var_a77a7baed79d52a2, 1, self, "usurped_power", var_1f217c82f24fabf, undefined, var_749345f344f55b77, 1, equipinfo.deployweapon, 1 );
            var_1743d7de6d5bd6bf++;
            callback::callback( "usurped_power_set_ablaze", { #equipinfo:equipinfo, #player:self } );
            
            if ( var_1743d7de6d5bd6bf >= var_a8dbffa306ec9e71 * 0.7 )
            {
                utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", get_usurped_power_fx_state( 30, equipinfo.var_997d4b6005a845d1 ) );
            }
            else if ( var_1743d7de6d5bd6bf >= var_a8dbffa306ec9e71 * 0.4 )
            {
                utility::function_7c10ea82c1e305b8( "scb_pq_fx_energy", get_usurped_power_fx_state( 60, equipinfo.var_997d4b6005a845d1 ) );
            }
            
            if ( var_1743d7de6d5bd6bf >= var_a8dbffa306ec9e71 )
            {
                self notify( #"equip_finished_with_deploy_weapon" );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 1, eflags: 0x4
// Checksum 0xb7f8949f, Offset: 0x2690
// Size: 0x37d
function private function_3330fc002bbcfd78( equipinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"usurped_power_restore", #"cancel_all_equip_deployments", #"equip_finished_with_deploy_weapon" );
    equipinfo.var_28079045bda30435 = [];
    
    while ( true )
    {
        waitframe();
        scriptables = getentitylessscriptablearray( undefined, undefined, self.origin, 75 );
        
        foreach ( scriptable in scriptables )
        {
            if ( !scriptable val::get( "damage" ) )
            {
                continue;
            }
            
            scriptable scriptabledodamage( 1, self, self, scriptable.origin, undefined, "MOD_ELEMENTAL_FIRE", equipinfo.deployweapon );
        }
        
        var_cbc6281866161630 = damage_utility::function_cf1c753aefa70ea1( self.team );
        
        foreach ( ent in var_cbc6281866161630 )
        {
            if ( !isent( ent ) )
            {
                continue;
            }
            
            if ( !ent.var_1355a2eee0e45cf0 )
            {
                continue;
            }
            
            if ( distancesquared( ent.origin, self.origin ) > squared( 75 ) )
            {
                continue;
            }
            
            ent dodamage( 1, self.origin, self, self, "MOD_ELEMENTAL_FIRE", equipinfo.deployweapon, "none", undefined, 536936449 );
        }
        
        equipinfo.var_28079045bda30435 = function_5713d46873b29625( equipinfo.var_28079045bda30435 );
        equipinfo.var_28079045bda30435 = function_46f9072493651dc9( equipinfo.var_28079045bda30435 );
        
        if ( equipinfo.var_28079045bda30435.size < 1 || !isalive( self ) )
        {
            continue;
        }
        
        var_aa3ef88295aa5148 = function_6a293b884c444a20( equipinfo.var_28079045bda30435, self.origin, 75 );
        
        if ( var_aa3ef88295aa5148.size < 1 )
        {
            continue;
        }
        
        foreach ( target in var_aa3ef88295aa5148 )
        {
            if ( !target val::get( "damage" ) )
            {
                continue;
            }
            
            if ( isent( target ) )
            {
                target dodamage( 1, self.origin, self, self, "MOD_ELEMENTAL_FIRE", equipinfo.deployweapon, "none", undefined, 536936449 );
                continue;
            }
            
            if ( !isent( target ) && target isscriptableinstance() )
            {
                target scriptabledodamage( 1, self, self, target.origin, undefined, "MOD_ELEMENTAL_FIRE", equipinfo.deployweapon );
            }
        }
    }
}

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0x5805572d, Offset: 0x2a15
// Size: 0x86, Type: bool
function function_635a6a03916a35f0()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "is_usurped_power_grabbed" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0x5f983bec, Offset: 0x2aa4
// Size: 0x86, Type: bool
function function_fa42c671f89f2b5()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "holding_cosmic_usurped_power" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0x66990e85, Offset: 0x2b33
// Size: 0x90, Type: bool
function function_d6a312f7971182ff()
{
    foreach ( brazier in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
    {
        if ( brazier utility::ent_flag( "is_lit" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_usurped_power
// Params 0
// Checksum 0x68a347ec, Offset: 0x2bcc
// Size: 0xa1, Type: bool
function function_c9d7a7dadf1c7b4e()
{
    foreach ( brazier in level.scarab_pap_quest.var_c6b9e23aac03b4d0 )
    {
        if ( brazier utility::ent_flag( "is_lit" ) && brazier utility::ent_flag( "has_cosmic_power" ) )
        {
            return true;
        }
    }
    
    return false;
}

