// scripts\mp\gametypes\vortex_playlist_util.gsc  (hash_32c2f4a699e57e1e.gscc) (size: 15355 Bytes / 0x3bfb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc58182f7 (3313599223)
// size ...... 15355 (0x3bfb)
// includes .. 17  (offset: 0x364f)
// strings ... 90  (offset: 0x36d7)
// dev strs .. 6   (offset: 0x3baf)
// exports ... 33  (offset: 0x222f)
// cseg ...... 0x743 + 0x1aec (0x222f)
// imports ... 123 (offset: 0x2757)
// animtree1 . 0   (offset: 0x3bfb)
// animtree2 . 0   (offset: 0x3bfb)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\battlerage;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\weapons;

#namespace vortex_playlist_util;

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x83381ba2, Offset: 0x761
// Size: 0xc0
function vortex_playlist_init()
{
    level._effect[ "vfx_arc_pickup" ] = loadfxasset( "vfx_jup_modes_arc_pickup" );
    function_971c593cd53d5ca0();
    setup_map_pickups();
    level callback::add( #"player_death", &on_death_spawn_weapon );
    callback::add( #"player_spawned", &onplayerspawned );
    level.var_a44ba6c01eac941 = &function_86f96ac3a260d307;
    level._effect[ "arcade_force_field_on" ] = loadfxasset( "vfx_jup_modes_arc_shield_orb_01" );
    level._effect[ "arcade_force_field_damaged" ] = loadfxasset( "vfx_jup_modes_arc_shield_orb_02" );
    level._effect[ "arcade_force_field_break" ] = loadfxasset( "vfx_jup_modes_arc_shield_orb_break" );
    audio_utility::snd_transient_load( "jup_mode_shared_vortex" );
    thread function_8937f899fd7b241a();
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0xe47a0d10, Offset: 0x829
// Size: 0x20
function on_connect_setup( params )
{
    self waittill( #"loadout_class_selected" );
    function_ce5f4df0a51f36e9();
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0x273f282b, Offset: 0x851
// Size: 0x43
function onplayerspawned( params )
{
    if ( self.battlerageactive )
    {
        thread battlerage::function_eeeeed58090ed956();
    }
    else if ( self getscriptablepartstate( "battleRageVfx" ) == "vfx_start" )
    {
        battlerage::function_f73ea867311dfe58();
    }
    
    function_ce5f4df0a51f36e9();
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x82067df7, Offset: 0x89c
// Size: 0x42
function function_ce5f4df0a51f36e9()
{
    if ( !isdefined( self.perks[ "specialty_treadless_boots" ] ) )
    {
        perk::giveperk( "specialty_treadless_boots" );
    }
    
    if ( !isdefined( self.perks[ "specialty_assault_gloves" ] ) )
    {
        perk::giveperk( "specialty_assault_gloves" );
    }
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0xd5dbc0c9, Offset: 0x8e6
// Size: 0x20
function on_death_spawn_weapon( params )
{
    if ( utility::cointoss() )
    {
        function_40a121860bf4b992( params, 1 );
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xf8f515b6, Offset: 0x90e
// Size: 0x1f9
function function_dd0cefaaa4441543()
{
    level waittill( #"prematch_started" );
    
    if ( isdefined( level.weaponmapdata ) )
    {
        foreach ( weapon in level.weaponmapdata )
        {
            if ( issubstr( weapon.assetname, "none" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "compound" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "balpha27" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "kappa98" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "spapa12" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "me" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "la" ) )
            {
                continue;
            }
            
            if ( issubstr( weapon.assetname, "goldengun" ) )
            {
                level.vortexweaponlist[ weapon.assetname ] = weapon;
            }
            
            if ( issubstr( weapon.assetname, "raygun" ) )
            {
                level.vortexweaponlist[ weapon.assetname ] = weapon;
            }
            
            if ( issubstr( weapon.assetname, "dg2" ) )
            {
                level.vortexweaponlist[ weapon.assetname ] = weapon;
            }
            
            if ( issubstr( weapon.assetname, "iw" ) )
            {
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x5b6391c1, Offset: 0xb0f
// Size: 0x195
function function_971c593cd53d5ca0()
{
    level waittill( #"prematch_started" );
    var_86f64d77b07a56ae = makeweapon( "jup_jp23_me_pdango_arcade_mp", [ "jup_me_pdango" ], undefined, "jup_camo_17c", 0 );
    var_74a980d2b9a15f72 = weapon::buildweapon( "jup_jp35_sn_moscar", [ "jup_moscar_rec", "jup_jp35_sn_moscar_stock", "jup_jp35_sn_moscar_pgrip", "jup_moscar_bipod", "jup_ammo_rail_std", "jup_moscar_scope", "jup_jp35_sn_moscar_bar_explode", "jup_jp35_sn_moscar_bolt_hvy" ], "jup_camo_17c", "none" );
    rocket_shotgun = weapon::buildweapon( "jup_cp01_sh_aromeo410", [ "jup_ammo_410g_vortex", "jup_cp01_sh_aromeo410_pgrip_tac" ], "jup_camo_17c", "none" );
    mini_gun = makeweapon( "iw9_lm_dblmg_jup_mp", [ "ammo_762n_vortex" ], undefined, "jup_camo_17c", 0 );
    weaponlist = [ var_86f64d77b07a56ae, var_74a980d2b9a15f72, rocket_shotgun, mini_gun ];
    
    foreach ( weapon in weaponlist )
    {
        level.var_ff841c3a655891d1[ weapon.basename ] = weapon;
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xc5ba7ea0, Offset: 0xcac
// Size: 0x57
function function_1df0af43405e047d()
{
    if ( isdefined( level.var_ff841c3a655891d1 ) )
    {
        weaponlist = level.var_ff841c3a655891d1;
    }
    else
    {
        assertmsg( "<dev string:x24>" );
    }
    
    key = utility::random_key( weaponlist );
    
    if ( isdefined( weaponlist[ key ] ) )
    {
        return weaponlist[ key ];
    }
    
    return;
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x15b2cbe8, Offset: 0xd0b
// Size: 0x155
function getrandomspawnweapon_vortex()
{
    if ( isdefined( level.vortexweaponlist ) )
    {
        weaponlist = level.vortexweaponlist;
    }
    else if ( isdefined( level.weaponmapdata ) )
    {
        weaponlist = level.weaponmapdata;
    }
    else
    {
        weaponlist = level.weaponlistbundle;
    }
    
    if ( weaponlist.size > 0 )
    {
        newweapon = "";
        
        for ( loopcount = 0; true ; loopcount++ )
        {
            weapon = utility::array_random( weaponlist );
            var_7237854e3be197ca = weapon.rootname;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
            
            var_7237854e3be197ca = weapon.assetname;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
            
            if ( !issubstr( weapon, "equip" ) )
            {
                rootname = weapon::getweaponrootname( weapon );
            }
            else
            {
                rootname = weapon;
            }
            
            if ( loopcount > weaponlist.size )
            {
                level.selectedweapons[ rootname ] = 1;
                newweapon = weapon;
                
                for ( i = 0; i < level.allweapons.size ; i++ )
                {
                    if ( level.allweapons[ weapon ] == newweapon )
                    {
                        break;
                    }
                }
                
                break;
            }
        }
        
        return newweapon;
    }
    
    assertmsg( "<dev string:x48>" );
    return "none";
}

// Namespace vortex_playlist_util
// Params 2
// Checksum 0xe21c3bc0, Offset: 0xe68
// Size: 0x13c
function weapon_trigger_think( weapon, loc )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        self waittill( #"trigger", player, droppeditem );
        
        if ( isdefined( self.sfxloop ) )
        {
            self.sfxloop stoploopsound();
        }
        
        player playsoundtoplayer( "jup_arcade_weapon_pickup", player );
        player playsoundtoteam( "jup_arcade_weapon_pickup_ally", player.team );
        player playsoundtoteam( "jup_arcade_weapon_pickup_enemy", game_utility_mp::getotherteam( player.team )[ 0 ] );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !gameobjects::proxtriggerlos( player ) )
        {
            continue;
        }
        
        player drop_weapon_think();
        player inventory_utility::_giveweapon( weapon, undefined, undefined, 0 );
        player inventory_utility::_switchtoweapon( weapon );
        
        if ( isdefined( loc ) )
        {
            loc notify( #"weapon_respawn" );
        }
        
        if ( isdefined( self.sfxloop ) )
        {
            self.sfxloop delete();
        }
        
        self makeunusable();
        self delete();
    }
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0xbb62d24b, Offset: 0xfac
// Size: 0x130
function item_prox_trigger_think( item )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    trigger = spawn( "trigger_radius", self.origin, 0, 32, 32 );
    trigger enablelinkto();
    trigger linkto( self );
    self.trigger = trigger;
    trigger endon( #"death" );
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( isdefined( self.sfxloop ) )
        {
            self.sfxloop stoploopsound();
        }
        
        player playsoundtoplayer( "jup_arcade_powerup_pickup", player );
        player playsoundtoteam( "jup_arcade_powerup_pickup_ally", player.team );
        player playsoundtoteam( "jup_arcade_powerup_pickup_enemy", game_utility_mp::getotherteam( player.team )[ 0 ] );
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player thread apply_powerup( item );
        
        if ( isdefined( self.sfxloop ) )
        {
            self.sfxloop delete();
        }
        
        self makeunusable();
        self delete();
        break;
    }
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0x56d38bf, Offset: 0x10e4
// Size: 0xa0
function function_79fc1d6b1b55f4da( time_in_seconds )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"death" );
    start_time = gettime();
    current_time = 0;
    
    while ( true )
    {
        waitframe();
        current_time = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        
        if ( current_time >= 10 )
        {
            if ( isdefined( self.sfxloop ) )
            {
                self.sfxloop stoploopsound();
                self.sfxloop delete();
            }
            
            self makeunusable();
            self delete();
        }
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x14d2206a, Offset: 0x118c
// Size: 0x92
function drop_weapon_think()
{
    objweapon = self getcurrentweapon();
    item = self dropitem( objweapon );
    
    if ( !isdefined( item ) )
    {
        return 0;
    }
    
    item itemweaponsetammo( objweapon.maxammo, 1 );
    item sethintdisplayrange( 96 );
    item setuserange( 96 );
    item.owner = self;
    item.targetname = "dropped_weapon";
    item.objweapon = objweapon;
    item thread weapons::watchpickup( self );
    item thread weapons::deletepickupafterawhile();
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0x727793a, Offset: 0x1226
// Size: 0xfa
function giveweapon_vortex( objweapon )
{
    assert( isweapon( objweapon ) );
    var_fbf52781a23e4114 = objweapon getnoaltweapon();
    currentweapon = self getcurrentweapon();
    
    if ( self hasweapon( objweapon ) )
    {
        ammoinclip = self getweaponammoclip( objweapon );
        
        if ( ammoinclip > 0 )
        {
            self dropitem( objweapon );
            inventory_utility::_giveweapon( var_fbf52781a23e4114 );
        }
        else if ( !issubstr( currentweapon.basename, objweapon.basename ) )
        {
            inventory_utility::_takeweapon( objweapon );
            inventory_utility::_giveweapon( var_fbf52781a23e4114 );
        }
        
        var_bc2b88d7f86c136e = self getweaponammoclip( currentweapon ) == 0;
        var_1f5413729b80918a = issubstr( currentweapon.basename, "iw9_me_fists_mp" );
        
        if ( var_1f5413729b80918a || var_bc2b88d7f86c136e )
        {
            inventory_utility::_switchtoweapon( var_fbf52781a23e4114 );
        }
        
        self setweaponammoclip( var_fbf52781a23e4114, var_fbf52781a23e4114.maxammo );
        return;
    }
}

// Namespace vortex_playlist_util
// Params 2
// Checksum 0x37c43995, Offset: 0x1328
// Size: 0x1eb
function function_2d6b9f279d8f1ff3( params, death_drop )
{
    if ( death_drop )
    {
        loc = params.victim;
    }
    else
    {
        loc = params.origin;
    }
    
    weaponoffset = ( 0, 0, 36 );
    targetposworld = loc.origin + weaponoffset;
    targetposangles = ( loc.angles[ 0 ], loc.angles[ 1 ], loc.angles[ 2 ] );
    var_5534ee0990246282 = ( 0, -5, 0 );
    weapon_rootname = getrandomspawnweapon_vortex();
    
    if ( isdefined( weapon_rootname ) )
    {
        weapon = weapon_utility::function_d2c8356dc369d9ce( weapon_rootname );
        
        if ( !isweapon( weapon ) )
        {
            assertmsg( "<dev string:x5c>" );
            return;
        }
    }
    else
    {
        assertmsg( "<dev string:x96>" );
        return;
    }
    
    weapon_pickup = function_2535619d314c1099( weapon, targetposworld, targetposangles );
    var_cd42b2a7832a77a8 = weapon_pickup localtoworldcoords( var_5534ee0990246282 );
    weapon_pickup.origin = var_cd42b2a7832a77a8;
    var_177018b3984d2e6a = ( 0, 0.5, 0 );
    targetposworld = weapon_pickup localtoworldcoords( var_177018b3984d2e6a );
    var_c6ec37af26231409 = 0.2;
    weapon_pickup moveto( targetposworld, var_c6ec37af26231409 );
    weapon_pickup hudoutlineenable( "outline_nodepth_green" );
    weapon_pickup makeusable();
    weapon_pickup sethinttag( "tag_origin" );
    weapon_pickup setuseholdduration( "duration_short" );
    playsoundatpos( targetposworld, "jup_arcade_weapon_drop" );
    weapon_pickup.sfxloop = spawn( "script_model", targetposworld );
    weapon_pickup.sfxloop playloopsound( "jup_arcade_weapon_lp" );
    weapon_pickup thread function_79fc1d6b1b55f4da();
    weapon_pickup thread weapon_trigger_think( weapon );
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0xb4bb9c4e, Offset: 0x151b
// Size: 0x16a
function function_e0408fd6218c6cf3( loc )
{
    weaponoffset = ( 0, 0, 26 );
    targetposworld = loc.origin + weaponoffset;
    targetposangles = loc.angles + ( 0, 0, 90 );
    var_c6ec37af26231409 = 0.2;
    weapon = function_1df0af43405e047d();
    
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:xc5>" );
        return;
    }
    
    weapon_pickup = function_2535619d314c1099( weapon, targetposworld, targetposangles );
    weapon_pickup moveto( targetposworld, var_c6ec37af26231409 );
    weapon_pickup makeusable();
    weapon_pickup sethinttag( "tag_origin" );
    weapon_pickup setuseholdduration( "duration_short" );
    weapon_pickup hudoutlineenable( "outline_nodepth_green" );
    weapon_pickup thread weapon_trigger_think( weapon, loc );
    playsoundatpos( targetposworld, "jup_arcade_weapon_drop" );
    weapon_pickup.sfxloop = spawn( "script_model", targetposworld );
    weapon_pickup.sfxloop playloopsound( "jup_arcade_weapon_lp" );
    level.vortexfx = spawnfx( level._effect[ "vfx_arc_pickup" ], loc.origin + ( 0, 0, 23 ) );
    triggerfx( level.vortexfx );
    loc thread function_d5b55ae0cdd9a97d( loc );
}

// Namespace vortex_playlist_util
// Params 2
// Checksum 0x512dd089, Offset: 0x168d
// Size: 0x164
function function_40a121860bf4b992( params, death_drop )
{
    if ( death_drop )
    {
        loc = params.victim;
    }
    else
    {
        loc = params.origin;
    }
    
    itemoffset = ( 0, 0, 36 );
    targetposworld = loc.origin + itemoffset;
    var_5534ee0990246282 = ( 0, -5, 0 );
    item = spawn( "script_model", targetposworld );
    item setmodel( "military_dogtags_iw9_blue" );
    var_cd42b2a7832a77a8 = item localtoworldcoords( var_5534ee0990246282 );
    item.origin = var_cd42b2a7832a77a8;
    var_177018b3984d2e6a = ( 0, 0.5, 0 );
    targetposworld = item localtoworldcoords( var_177018b3984d2e6a );
    var_c6ec37af26231409 = 0.2;
    item moveto( targetposworld, var_c6ec37af26231409 );
    item makeusable();
    item hudoutlineenable( "outline_nodepth_green" );
    playsoundatpos( targetposworld, "jup_arcade_powerup_drop" );
    item.sfxloop = spawn( "script_model", targetposworld );
    item.sfxloop playloopsound( "jup_arcade_powerup_lp" );
    itemtype = get_random_powerup();
    item thread item_prox_trigger_think( itemtype );
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xdb079e24, Offset: 0x17f9
// Size: 0x52
function get_random_powerup()
{
    powerup_list = [ "unlimited_grenade", "unlimited_ammo", "aoe_drop_damage", "force_field" ];
    key = utility::random_key( powerup_list );
    
    if ( isdefined( powerup_list[ key ] ) )
    {
        return powerup_list[ key ];
    }
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0x17582fe4, Offset: 0x1853
// Size: 0x7b
function apply_powerup( powerup_type )
{
    switch ( powerup_type )
    {
        case #"hash_ac736f279bf91dc5":
            thread set_player_unlimited_grenade();
            break;
        case #"hash_57ebf8ef67187ec7":
            thread set_player_unlimited_ammo();
            break;
        case #"hash_4af08d383fb772cb":
            thread set_player_force_field();
            break;
        case #"hash_2c9395bfba7d8880":
            thread set_player_aoe_drop_damage();
            break;
        default:
            return;
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x916db0c6, Offset: 0x18d6
// Size: 0xda
function set_player_unlimited_grenade()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"unlimited_grenade_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    thread hud_message::showsplash( "arcade_unlimited_frag" );
    replace_equip = undefined;
    
    if ( !equipment_mp::hasequipment( "equip_frag" ) )
    {
        equipment_ref = equipment_mp::getcurrentequipment( "primary" );
        start_ammo = equipment_mp::getequipmentstartammo( equipment_ref );
        replace_equip = 1;
        equipment_mp::giveequipment( "equip_frag", "primary" );
    }
    
    equipment_mp::incrementequipmentslotammo( "primary", 9999 );
    wait 20;
    equipment_mp::decrementequipmentslotammo( "primary" );
    self playlocalsound( "jup_arcade_powerup_expire" );
    
    if ( isdefined( replace_equip ) )
    {
        equipment_mp::giveequipment( equipment_ref, "primary" );
        equipment_mp::setequipmentammo( equipment_ref, start_ammo );
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xda962169, Offset: 0x19b8
// Size: 0x5c
function set_player_unlimited_ammo()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"unlimited_ammo_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    thread hud_message::showsplash( "arcade_unlimited_ammo" );
    thread weapon::infiniteammothread( 0.5 );
    wait 15;
    thread weapon::stopinfiniteammothread();
    self playlocalsound( "jup_arcade_powerup_expire" );
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x85b7cdb3, Offset: 0x1a1c
// Size: 0x121
function set_player_force_field()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"force_field_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    thread hud_message::showsplash( "arcade_force_field" );
    self.force_field = 1;
    self.force_field_health = 300;
    shield = playfxontag( utility::getfx( "arcade_force_field_on" ), self, "j_mainroot" );
    self setscriptablepartstate( "conf_v_super_speed_fx", "super_speed_on" );
    self waittill( #"force_field_damaged" );
    stopfxontag( utility::getfx( "arcade_force_field_on" ), self, "j_mainroot" );
    shield_damaged = playfxontag( utility::getfx( "arcade_force_field_damaged" ), self, "j_mainroot" );
    self waittill( #"force_field_break" );
    stopfxontag( utility::getfx( "arcade_force_field_damaged" ), self, "j_mainroot" );
    shield_break = playfxontag( utility::getfx( "arcade_force_field_break" ), self, "j_mainroot" );
    self setscriptablepartstate( "conf_v_super_speed_fx", "super_speed_off" );
    self.force_field = 0;
}

// Namespace vortex_playlist_util
// Params 16
// Checksum 0xa7a094ad, Offset: 0x1b45
// Size: 0xfa, Type: bool
function function_86f96ac3a260d307( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2 )
{
    if ( victim.force_field )
    {
        victim.force_field_health -= idamage;
        
        if ( victim.force_field_health <= 150 )
        {
            victim notify( #"force_field_damaged" );
        }
        
        if ( victim.force_field_health <= 0 )
        {
            victim notify( #"force_field_break" );
        }
        
        return true;
    }
    
    return false;
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xe02f1a60, Offset: 0x1c48
// Size: 0xb7
function set_player_aoe_drop_damage()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"aoe_drop_end" );
    
    if ( getdvarint( @"hash_a608897998bad970", 0 ) == 1 )
    {
        return;
    }
    
    thread hud_message::showsplash( "arcade_aoe_drop_damage" );
    self.herodrop = 0;
    thread function_3872622ffbb08366();
    thread function_494bd6d1f10118f6();
    
    while ( true )
    {
        thread function_f7f5b7400d921739();
        self waittill( #"hash_76158f9795c6f611" );
        
        if ( !self.herodrop )
        {
            self.herodrop = 1;
            self radiusdamage( self.origin, 200, 300, 100, self, "MOD_CRUSH" );
            thread player_setherodropscriptable();
        }
        
        waitframe();
    }
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0xd98bc51f, Offset: 0x1d07
// Size: 0x8d
function function_494bd6d1f10118f6( time_in_seconds )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"aoe_drop_end" );
    self.var_7bd7c1cdaac36207 = 0;
    start_time = gettime();
    current_time = 0;
    
    while ( true )
    {
        waitframe();
        current_time = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        
        if ( current_time >= 40 )
        {
            self playlocalsound( "jup_arcade_powerup_expire" );
            self notify( #"aoe_drop_end" );
            return;
        }
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xd5a16f0, Offset: 0x1d9c
// Size: 0xbc
function function_3872622ffbb08366()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"aoe_drop_end" );
    var_e0c6ec148bd7e9f4 = 0;
    
    while ( true )
    {
        if ( self isdiving() || self isjumping() )
        {
            if ( !var_e0c6ec148bd7e9f4 )
            {
                var_e0c6ec148bd7e9f4 = 1;
            }
            
            if ( self isonground() && var_e0c6ec148bd7e9f4 )
            {
                self notify( #"hash_76158f9795c6f611" );
                var_e0c6ec148bd7e9f4 = 0;
                
                while ( self isdiving() || self isjumping() )
                {
                    wait 0.1;
                }
            }
        }
        else if ( self isparachuting() || self isinfreefall() )
        {
            var_e0c6ec148bd7e9f4 = 0;
        }
        else if ( var_e0c6ec148bd7e9f4 )
        {
            self notify( #"hash_76158f9795c6f611" );
            var_e0c6ec148bd7e9f4 = 0;
        }
        
        waitframe();
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xa96390c2, Offset: 0x1e60
// Size: 0x55
function player_setherodropscriptable()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"aoe_drop_end" );
    self setscriptablepartstate( "heroDiveVfx", "impact", 0 );
    wait 1;
    self setscriptablepartstate( "heroDiveVfx", "off", 0 );
    self.herodrop = 0;
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x13dc453a, Offset: 0x1ebd
// Size: 0x11b
function function_f7f5b7400d921739()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"aoe_drop_end" );
    self endon( #"hash_76158f9795c6f611" );
    droploop = 0;
    var_6db36452433e1d8 = 0.5;
    delaycounter = var_6db36452433e1d8;
    var_41652c8314b5014d = getdvarint( @"bg_falldamageminheight" );
    
    if ( !isdefined( var_41652c8314b5014d ) )
    {
        var_41652c8314b5014d = 225;
    }
    
    while ( true )
    {
        if ( function_5b7a30f052ec8aea() )
        {
            delaycounter -= level.framedurationseconds;
            
            if ( delaycounter <= 0 )
            {
                delaycounter = 0;
                
                if ( !droploop )
                {
                    var_5af4a1560001bee = trace::ray_trace_passed( self.origin, self.origin - ( 0, 0, var_41652c8314b5014d ), self );
                    
                    if ( var_5af4a1560001bee )
                    {
                        droploop = 1;
                        self setscriptablepartstate( "heroDiveVfx", "falling", 0 );
                    }
                }
            }
        }
        else if ( droploop && !self.herodrop )
        {
            droploop = 0;
            delaycounter = var_6db36452433e1d8;
            self setscriptablepartstate( "heroDiveVfx", "off", 0 );
        }
        
        waitframe();
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xadf54248, Offset: 0x1fe0
// Size: 0x42, Type: bool
function function_5b7a30f052ec8aea()
{
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( !self isonground() )
    {
        if ( self isparachuting() )
        {
            return false;
        }
        
        if ( self isswimming() )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace vortex_playlist_util
// Params 1
// Checksum 0x81c0992f, Offset: 0x202b
// Size: 0x3d
function function_d5b55ae0cdd9a97d( loc )
{
    level endon( #"game_ended" );
    self endon( #"game_ended" );
    self waittill( #"weapon_respawn" );
    wait 20;
    function_e0408fd6218c6cf3( loc );
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0xae1f5ea3, Offset: 0x2070
// Size: 0x199
function setup_map_pickups()
{
    locs = utility::getstructarray( "weapon_pickup", "targetname" );
    assert( locs.size > 0, "<dev string:xed>" );
    
    if ( level.mapname == "mp_shoothouse2" )
    {
        foreach ( loc in locs )
        {
            if ( loc.script_label == "pball" )
            {
                function_e0408fd6218c6cf3( loc );
            }
        }
        
        return;
    }
    
    foreach ( loc in locs )
    {
        if ( loc.script_label == "1" || loc.script_label == "2" || loc.script_label == "3" || loc.script_label == "4" || loc.script_label == "5" )
        {
            function_e0408fd6218c6cf3( loc );
        }
    }
}

// Namespace vortex_playlist_util
// Params 0
// Checksum 0x3557c095, Offset: 0x2211
// Size: 0x1e
function function_8937f899fd7b241a()
{
    level waittill( #"game_ended" );
    wait 3;
    audio_utility::snd_transient_unload( "jup_mode_shared_vortex" );
}

