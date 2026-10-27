// scripts\mp\zm\weapons\zm_sat_ww_mantis.gsc  (hash_7d8c56b1761da52e.gscc) (size: 13449 Bytes / 0x3489 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x687da5eb (1753064939)
// size ...... 13449 (0x3489)
// includes .. 15  (offset: 0x313d)
// strings ... 43  (offset: 0x31b5)
// dev strs .. 7   (offset: 0x3435)
// exports ... 41  (offset: 0x1a75)
// cseg ...... 0x2ac + 0x17c9 (0x1a75)
// imports ... 139 (offset: 0x20dd)
// animtree1 . 0   (offset: 0x3489)
// animtree2 . 0   (offset: 0x3489)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;

#namespace weap_ww_mantis;

// Namespace weap_ww_mantis
// Params 0, eflags: 0x5
// Checksum 0xd4eeb49a, Offset: 0x2ca
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"weap_ww_mantis", undefined, &pre_main, &post_main );
}

// Namespace weap_ww_mantis
// Params 1
// Checksum 0xd5cd0355, Offset: 0x2ef
// Size: 0x5a, Type: bool
function is_sundergat( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( weapon.basename != level.ww_mantis_basename )
    {
        return false;
    }
    
    if ( isdefined( weapon.attachments ) && arraycontains( weapon.attachments, "sat_bar_ww_mantis" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0xe17e1240, Offset: 0x352
// Size: 0x13
function private pre_main()
{
    init();
    
    /#
        init_ww_mantis_devgui();
    #/
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0xbb001826, Offset: 0x36d
// Size: 0x54
function private post_main()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_fd70e8d09b590d87", &function_694e7049cde679d );
    level utility::registersharedfunc( #"ww_mantis", #"hash_b3e97e9465134b1b", &function_665a2e95405c2b96 );
    
    /#
        if ( getdvarint( @"hash_954427c98e58ade", 0 ) == 1 )
        {
            thread give_sundergat();
        }
    #/
}

/#

    // Namespace weap_ww_mantis
    // Params 0, eflags: 0x4
    // Checksum 0x2978eef, Offset: 0x3c9
    // Size: 0x9c, Type: dev
    function private give_sundergat()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( !level.player )
            {
                waitframe();
                continue;
            }
            
            player = level.player;
            var_7442dc53ac56d6c2 = weapon::buildweapon( "<dev string:x24>" );
            sundergat = var_7442dc53ac56d6c2 withattachment( "<dev string:x35>" );
            player inventory_utility::_giveweapon( sundergat );
            player setweaponammoclip( sundergat, weaponclipsize( sundergat ) );
            player setweaponammostock( sundergat, weaponmaxammo( sundergat ) );
            player inventory_utility::_switchtoweaponimmediate( sundergat );
            break;
        }
    }

#/

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xfc8b284e, Offset: 0x46d
// Size: 0xe1
function private function_a8d27574578f1f31( specified_player )
{
    player = undefined;
    
    if ( specified_player == "random" )
    {
        player = utility::array_random( level.players );
    }
    else
    {
        if ( specified_player == "me" )
        {
            specified_player = getdvar( @"cheat_player" );
        }
        
        foreach ( var_5e2221840c5be55d in level.players )
        {
            if ( issubstr( tolower( var_5e2221840c5be55d.name ), tolower( specified_player ) ) )
            {
                return var_5e2221840c5be55d;
            }
        }
    }
    
    return player;
}

// Namespace weap_ww_mantis
// Params 1
// Checksum 0xb6cbb5d8, Offset: 0x557
// Size: 0xc3
function function_9c301135b2aa5641( pap_level = 0 )
{
    drop_pos = ( 0, 0, 0 );
    forward = anglestoforward( self getplayerangles() );
    drop_pos = self.origin + forward * 100;
    drop_pos = utility::drop_to_ground( drop_pos, 100 ) + ( 0, 0, 8 );
    item_bundle_name = "zm_sat_item_weapon_ww_mantis_upgraded";
    item_bundle = getscriptbundle( hashcat( %"itemspawnentry:", item_bundle_name ) );
    spawn_options = common_item::items_initspawnoptions_spawnfromentity( self );
    spawn_options.overridepaplvl = pap_level;
    common_item::function_61c2c0251e742ffd( item_bundle, 1, spawn_options );
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xd71a2e6b, Offset: 0x622
// Size: 0x15f
function private function_694e7049cde679d( params )
{
    pap_level = undefined;
    player = undefined;
    
    if ( isdefined( params ) )
    {
        foreach ( param in params )
        {
            param_delimited = strtok( param, ":" );
            
            if ( isstartstr( param, "player:" ) )
            {
                player = function_a8d27574578f1f31( param_delimited[ 1 ] );
                continue;
            }
            
            if ( isstartstr( param, "pap:" ) )
            {
                pap_level = int( param_delimited[ 1 ] );
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        foreach ( player in level.players )
        {
            player function_9c301135b2aa5641( pap_level );
        }
        
        return;
    }
    
    player function_9c301135b2aa5641( pap_level );
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0x3280b8fa, Offset: 0x789
// Size: 0x75
function private init()
{
    if ( !isdefined( level.ww_mantis_basename ) )
    {
        level.ww_mantis_basename = utility::get_scripted_weapon_name( #"blundergat" );
    }
    
    level callback::add( #"player_weapon_change", &on_weapon_change );
    level zombie_utils::function_dfae6a5bd222c586( &function_8d7e02690d31e565 );
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level callback::add( #"player_connect", &on_player_connect );
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xb3eeea74, Offset: 0x806
// Size: 0x21
function private on_player_connect( params )
{
    callback::add( #"player_used_item", &on_pickup_sundergat );
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x2afc9929, Offset: 0x82f
// Size: 0x60
function private on_pickup_sundergat( params )
{
    key = "ww_mantis2_tutorial_message_has_displayed";
    
    if ( is_sundergat( params.item.weaponobj ) )
    {
        if ( !utility::ent_flag( key ) )
        {
            utility::ent_flag_set( key );
            thread ww_shared::show_hud_tutorial_message( &"zm_sat_mantis/zm_ww_mantis2_tutorial_message" );
        }
    }
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0xaac8e398, Offset: 0x897
// Size: 0x114
function private function_b63980f0807dbada()
{
    current_weapon = self getcurrentweapon();
    
    if ( !isdefined( current_weapon ) )
    {
        return;
    }
    
    if ( !is_sundergat( current_weapon ) && current_weapon.basename == level.ww_mantis_basename )
    {
        var_7442dc53ac56d6c2 = current_weapon;
        var_951c89546ec50477 = pack_a_punch::get_pap_level( current_weapon );
        
        if ( var_951c89546ec50477 > 0 )
        {
            new_blundergat = weapon::buildweapon( "sat_ww_mantis_zm" );
            var_7442dc53ac56d6c2 = new_blundergat;
        }
        
        sundergat = var_7442dc53ac56d6c2 withattachment( "sat_bar_ww_mantis" );
        
        if ( sundergat )
        {
            sundergat = sundergat withoutattachment( "sat_rec_ww_mantis" );
            sundergat = sundergat withattachment( "sat_rec_ww_mantis2" );
            inventory_utility::_takeweapon( current_weapon );
            
            if ( var_951c89546ec50477 < 1 )
            {
                self setweaponammoclip( sundergat, weaponclipsize( sundergat ) );
                self setweaponammostock( sundergat, weaponstartammo( sundergat ) );
                inventory_utility::_giveweapon( sundergat );
                inventory_utility::_switchtoweaponimmediate( sundergat );
            }
            else
            {
                sundergat = pack_a_punch::pap_weapon( sundergat, var_951c89546ec50477 - 1, undefined, 1, undefined, 1 );
            }
            
            item_weapon::function_40e1cbd0e1f47d1a( sundergat, 6 );
        }
    }
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x1a16a76d, Offset: 0x9b3
// Size: 0x8f
function private function_8d7e02690d31e565( params )
{
    if ( params.eattacker && is_sundergat( params.objweapon ) && params.smeansofdeath != "MOD_MELEE" )
    {
        self.b_disable_annihilate = 1;
        utility::function_32b24db3127bff40( "ww_mantis2_soul_impact", "on" );
        
        if ( params.idamage >= self.health )
        {
            utility::ent_flag_set( "dissolve" );
        }
    }
    
    return params.idamage;
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xff338a8c, Offset: 0xa4b
// Size: 0x51
function private on_ai_killed( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( is_sundergat( params.sweapon ) )
    {
        function_a0f64a4997a73c38( params.eattacker, params.vdir );
    }
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0xffc186c7, Offset: 0xaa4
// Size: 0x1f
function private function_6cc53ecc02220835()
{
    if ( self tagexists( "j_spine4" ) )
    {
        return self gettagorigin( "j_spine4" );
    }
    
    return self getcentroid();
}

// Namespace weap_ww_mantis
// Params 2, eflags: 0x4
// Checksum 0x32856af3, Offset: 0xacc
// Size: 0x37
function private function_665a2e95405c2b96( player, b_disable_vfx )
{
    data = player get_ww_mantis_player_data();
    data.var_665a2e95405c2b96 = b_disable_vfx;
}

// Namespace weap_ww_mantis
// Params 2, eflags: 0x4
// Checksum 0xeb0f422c, Offset: 0xb0b
// Size: 0xb7
function private function_a0f64a4997a73c38( attacker, vdir )
{
    data = attacker get_ww_mantis_player_data();
    
    if ( data.var_665a2e95405c2b96 )
    {
        return;
    }
    
    if ( !vdir )
    {
        return;
    }
    
    angles = vectortoangles( -1 * anglestoforward( vectortoangles( vdir ) ) ) * ( 0, 1, 0 );
    soul_spl = spawnscriptable( %"scriptable_ww_mantis_zmb_soul", self.origin, angles );
    soul_spl utility::function_32b24db3127bff40( self.defaultasm, "on" );
    soul_spl utility::delaycallendon( 5, "death", &freescriptable );
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0x536471d8, Offset: 0xbca
// Size: 0x37
function private get_ww_mantis_player_data()
{
    assert( isplayer( self ), "<dev string:x47>" );
    
    if ( !self.ww_mantis_player_data )
    {
        self.ww_mantis_player_data = spawnstruct();
    }
    
    return self.ww_mantis_player_data;
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x789aceac, Offset: 0xc0a
// Size: 0x2c
function private function_b6759d5040e13258( str )
{
    return get_ww_mantis_player_data().is_pap ? str + "_pap" : str;
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x5b570f32, Offset: 0xc3f
// Size: 0xfa
function private on_weapon_change( params )
{
    if ( !self getscriptablehaspart( "ww_mantis_charge" ) )
    {
        return;
    }
    
    if ( params.weapon.basename == level.ww_mantis_basename )
    {
        data = get_ww_mantis_player_data();
        data.is_pap = utility::callsharedfunc( #"zombie", #"get_pap_level", params.weapon ) > 0;
    }
    
    if ( is_sundergat( params.weapon ) )
    {
        thread function_9cf132f2dea63843( params.weapon );
        thread function_432ce68e20af0d5f( params.weapon );
        return;
    }
    
    self notify( #"hash_a16cbba90ff8fe9d" );
    self notify( #"hash_b7981fd8c0482209" );
    val::reset_all( "ww_mantis2_charge" );
    self.var_e433852bf6fe86cb = undefined;
    utility::function_7c10ea82c1e305b8( "ww_mantis_charge", "off" );
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x558e65e6, Offset: 0xd41
// Size: 0x98
function private function_432ce68e20af0d5f( weapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b7981fd8c0482209" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        
        if ( self getcurrentweapon() != weapon )
        {
            continue;
        }
        
        if ( isdefined( self.var_e433852bf6fe86cb ) )
        {
            fire_charge_duration = utility::function_6f5d2e1f1ff70482( gettime() - self.var_e433852bf6fe86cb );
            
            if ( fire_charge_duration >= weapon.weaponcustomsettings.var_dac7d4e9f10d0a64 )
            {
                thread function_543f5cfc5a706db5( weapon );
            }
        }
    }
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x2aa5bf8f, Offset: 0xde1
// Size: 0xa2
function private function_9cf132f2dea63843( weapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b7981fd8c0482209" );
    self.var_91bd5d2dff60a896 = 0;
    
    while ( true )
    {
        self waittill( #"hash_69562b0de38a064f", var_91288cf063b806d4 );
        
        switch ( var_91288cf063b806d4 )
        {
            case 0:
            case 1:
                function_bf1f27ffe11a2c13( weapon );
                break;
            case 2:
                function_d1757bc1143bf9be();
                break;
            default:
                break;
        }
    }
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x90c6e23, Offset: 0xe8b
// Size: 0xce
function private function_bf1f27ffe11a2c13( weapon )
{
    /#
        if ( getdvarint( @"hash_3e8e9e1e62b0aff7", 0 ) == 1 )
        {
            thread function_572e461e90147262( weapon );
        }
    #/
    
    if ( self isshooting() )
    {
        return;
    }
    
    thread function_e3b0b0229a1f4c63( weapon );
    val::set( "ww_mantis2_charge", "mantle", 0 );
    val::set( "ww_mantis2_charge", "sprint", 0 );
    val::set( "ww_mantis2_charge", "offhand_weapons", 0 );
    val::set( "ww_mantis2_charge", "gesture", 0 );
    val::set( "ww_mantis2_charge", "allow_haywire", 0 );
    val::set( "ww_mantis2_charge", "melee", 0 );
    self.var_e433852bf6fe86cb = gettime();
    utility::function_32b24db3127bff40( "ww_mantis_charge", function_b6759d5040e13258( "start" ) );
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0x8ab03ecb, Offset: 0xf61
// Size: 0x50
function private function_d1757bc1143bf9be()
{
    self notify( #"hash_a16cbba90ff8fe9d" );
    val::reset_all( "ww_mantis2_charge" );
    self.var_e433852bf6fe86cb = undefined;
    self.var_91bd5d2dff60a896 = 0;
    utility::function_32b24db3127bff40( "ww_mantis_heartbeat", "off" );
    utility::function_32b24db3127bff40( "ww_mantis_charge", "end" );
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x634610be, Offset: 0xfb9
// Size: 0xe6
function private function_e3b0b0229a1f4c63( weapon )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a16cbba90ff8fe9d" );
    wait weapon.weaponcustomsettings.var_dac7d4e9f10d0a64;
    self.var_c6dc679b7c670e65 = 1;
    
    while ( true )
    {
        self.var_91bd5d2dff60a896 = 1;
        utility::function_32b24db3127bff40( "ww_mantis_heartbeat", function_b6759d5040e13258( "beat" ) );
        wait weapon.weaponcustomsettings.var_a85fc25f84768c93;
        self.var_91bd5d2dff60a896 = 0;
        utility::function_32b24db3127bff40( "ww_mantis_heartbeat", "base" );
        wait clamp( weapon.weaponcustomsettings.var_8c1f2461f8908c29 - weapon.weaponcustomsettings.var_a85fc25f84768c93, 0, weapon.weaponcustomsettings.var_8c1f2461f8908c29 );
    }
}

// Namespace weap_ww_mantis
// Params 3, eflags: 0x4
// Checksum 0xdae7836b, Offset: 0x10a7
// Size: 0x40
function private function_b27163a093c96a84( offset_forward, var_5daf71431dd688bf, offset_up )
{
    target_position = rotatevector( ( offset_forward, var_5daf71431dd688bf, offset_up ), self getplayerangles() );
    return self getvieworigin() + target_position;
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0x2fb2358a, Offset: 0x10f0
// Size: 0x43
function private function_55be2b10c050c4f7()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self getcamerathirdperson() )
    {
        start = self gettagorigin( "tag_flash", 1 );
    }
    else
    {
        start = function_b27163a093c96a84( 50, -2, -3 );
    }
    
    return start;
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0xa1322998, Offset: 0x113b
// Size: 0x51
function private function_553c16d20065e9f0()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    start = function_55be2b10c050c4f7();
    
    if ( !isdefined( start ) )
    {
        return;
    }
    
    angles = self getplayerangles();
    fire = spawnscriptable( %"scriptable_ww_mantis_fire", start, angles );
    return fire;
}

// Namespace weap_ww_mantis
// Params 0, eflags: 0x4
// Checksum 0x4796c01c, Offset: 0x1195
// Size: 0x4f
function private function_66afa769e82dfb6f()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    angles = self getplayerangles() * ( 0, 1, 0 );
    purge_ground = spawnscriptable( %"scriptable_ww_mantis_purge_ground", self.origin, angles );
    return purge_ground;
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xce55fb16, Offset: 0x11ed
// Size: 0x16b
function private function_543f5cfc5a706db5( weapon )
{
    self endon( #"death_or_disconnect" );
    ammo_stock = self getweaponammostock( weapon );
    purged = 0;
    var_79deac58fdd57813 = 0;
    sunder_fire = function_553c16d20065e9f0();
    var_d74ee1e550f87587 = function_66afa769e82dfb6f();
    
    if ( self.var_c6dc679b7c670e65 && ammo_stock >= weapon.weaponcustomsettings.var_6dfc09708b183ca1 )
    {
        purged = sunder_purge( weapon, sunder_fire, var_d74ee1e550f87587 );
        self.var_c6dc679b7c670e65 = 0;
    }
    
    if ( self.var_91bd5d2dff60a896 && ammo_stock >= weapon.weaponcustomsettings.var_4be06a5314447f1d )
    {
        var_79deac58fdd57813 = function_8a74d789a090f86b( weapon, sunder_fire );
    }
    
    if ( purged )
    {
        var_e4bd0a95cb64df53 = weapon.weaponcustomsettings.var_6dfc09708b183ca1;
        
        if ( var_79deac58fdd57813 )
        {
            var_e4bd0a95cb64df53 = max( weapon.weaponcustomsettings.var_6dfc09708b183ca1, weapon.weaponcustomsettings.var_4be06a5314447f1d );
        }
        
        self setweaponammostock( weapon, int( ammo_stock - var_e4bd0a95cb64df53 ) );
    }
    
    if ( sunder_fire )
    {
        sunder_fire utility::delaycallendon( 5, "death", &freescriptable );
    }
    
    if ( var_d74ee1e550f87587 )
    {
        var_d74ee1e550f87587 utility::delaycallendon( 5, "death", &freescriptable );
    }
}

// Namespace weap_ww_mantis
// Params 3, eflags: 0x4
// Checksum 0x3b8719e6, Offset: 0x1360
// Size: 0x173, Type: bool
function private sunder_purge( weapon, sunder_fire, var_d74ee1e550f87587 )
{
    fov = weapon.weaponcustomsettings.var_4110fccbb78592a9;
    purge_radius = weapon.weaponcustomsettings.var_9620b81b8523e3ab;
    
    /#
        if ( getdvarint( @"hash_eeeed9c499ada29a", 0 ) == 1 )
        {
            level thread utility::draw_circle( self getcentroid(), purge_radius, ( 1, 0, 0 ), 1, 1, 200 );
        }
    #/
    
    if ( isdefined( sunder_fire ) )
    {
        if ( self getcamerathirdperson() )
        {
            sunder_fire utility::function_32b24db3127bff40( "purge", function_b6759d5040e13258( "on_3p" ) );
        }
        else
        {
            sunder_fire utility::function_32b24db3127bff40( "purge", function_b6759d5040e13258( "on_1p" ) );
        }
    }
    
    if ( isdefined( var_d74ee1e550f87587 ) )
    {
        var_d74ee1e550f87587 utility::function_32b24db3127bff40( "purge", function_b6759d5040e13258( "on" ) );
    }
    
    targets = self function_906f4c75be23ff6c( purge_radius, fov, 65536, 0 );
    var_9a1ca4dd9d8ef2b8 = [];
    
    for ( i = 0; i < targets.size ; i++ )
    {
        target = targets[ i ];
        
        if ( is_damageable( target ) )
        {
            knock_down( target );
            var_9a1ca4dd9d8ef2b8[ var_9a1ca4dd9d8ef2b8.size ] = target;
        }
    }
    
    thread function_e5600a7fe9046ec9( weapon, var_9a1ca4dd9d8ef2b8, self.origin );
    return true;
}

// Namespace weap_ww_mantis
// Params 3, eflags: 0x4
// Checksum 0x4a9446c3, Offset: 0x14dc
// Size: 0xcf
function private function_e5600a7fe9046ec9( weapon, targets, origin )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( targets ) || !targets.size )
    {
        return;
    }
    
    max_per_frame = 6;
    i = 0;
    
    while ( i < targets.size )
    {
        for ( processed_this_frame = 0; processed_this_frame < max_per_frame && i < targets.size ; processed_this_frame++ )
        {
            ai = targets[ i ];
            i++;
            
            if ( !is_damageable( ai ) )
            {
                continue;
            }
            
            ai dodamage( weapon.weaponcustomsettings.var_852182de51000fb, origin, self, self, "MOD_IMPACT", weapon );
        }
        
        if ( i < targets.size )
        {
            waitframe();
        }
    }
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xbe7c7334, Offset: 0x15b3
// Size: 0x54
function private knock_down( ai )
{
    if ( isagent( ai ) && isalive( ai ) )
    {
        if ( ai.aicategory == "normal" && !ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            ai zombie_knockdown::function_6fc167d4a3590991( ai.origin );
        }
    }
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x56c4335b, Offset: 0x160f
// Size: 0x95
function private function_9f6fc7b39a31f247( sunder_fire )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a16cbba90ff8fe9d" );
    
    if ( self getcamerathirdperson() )
    {
        sunder_fire utility::function_32b24db3127bff40( "exile", function_b6759d5040e13258( "on_3p" ) );
    }
    else
    {
        sunder_fire utility::function_32b24db3127bff40( "exile", function_b6759d5040e13258( "on_1p" ) );
    }
    
    sunder_fire utility::function_32b24db3127bff40( "exile", function_b6759d5040e13258( "on" ) );
    wait 1;
    
    if ( sunder_fire )
    {
        sunder_fire utility::function_32b24db3127bff40( "exile", "off" );
    }
}

// Namespace weap_ww_mantis
// Params 2, eflags: 0x4
// Checksum 0xb24bc64, Offset: 0x16ac
// Size: 0x241, Type: bool
function private function_8a74d789a090f86b( weapon, sunder_fire )
{
    thread function_9f6fc7b39a31f247( sunder_fire );
    forward = anglestoforward( self getplayerangles() );
    player_eye_pos = self geteye();
    beam_start = player_eye_pos + forward * weapon.weaponcustomsettings.var_9620b81b8523e3ab;
    beam_end = player_eye_pos + forward * weapon.weaponcustomsettings.var_674c22631c614116;
    contents = trace::create_contents( 0, 1, 0, 1, 1, 1 );
    wall_trace = trace::ray_trace( player_eye_pos, beam_end, self, contents );
    trace_fraction = wall_trace[ "fraction" ];
    effective_beam_end = player_eye_pos + forward * weapon.weaponcustomsettings.var_674c22631c614116 * trace_fraction;
    trace = trace::sphere_trace_get_all_results( beam_start, effective_beam_end, weapon.weaponcustomsettings.var_86041e0d14064bf7, self, trace::create_contents( 1 ) );
    
    /#
        if ( getdvarint( @"hash_9b1fcc0042973746", 0 ) == 1 )
        {
            trace::draw_trace( trace, ( 1, 0.5, 0 ), undefined, 200 );
        }
    #/
    
    foreach ( trace_result in trace )
    {
        entity = trace_result[ "entity" ];
        
        if ( is_damageable( entity ) )
        {
            dmg_point = get_damage_point( entity );
            
            if ( dmg_point )
            {
                if ( entity.aicategory == "normal" && !entity zombie_knockdown::function_19d6107cb6bdff5c() )
                {
                    entity zombie_knockdown::function_6fc167d4a3590991( player_eye_pos );
                }
                
                entity dodamage( weapon.weaponcustomsettings.var_13f191baf3cbb067, dmg_point, self, self, "MOD_IMPACT", weapon );
            }
        }
    }
    
    return true;
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0x8cb3e968, Offset: 0x18f6
// Size: 0x6f, Type: bool
function private get_damage_point( target )
{
    assert( isalive( target ) );
    
    if ( target.model && modelexists( target.model ) )
    {
        point = target gettagorigin( "j_spineupper", 1 ) ?? target gettagorigin( "j_spine4", 1 );
    }
    
    return point ?? target getcentroid();
}

// Namespace weap_ww_mantis
// Params 1, eflags: 0x4
// Checksum 0xfc2c30cc, Offset: 0x196e
// Size: 0x5b, Type: bool
function private is_damageable( entity )
{
    return entity && isai( entity ) && entity.aicategory && entity.team != self.team && isalive( entity ) && entity val::get( "damage" );
}

/#

    // Namespace weap_ww_mantis
    // Params 0
    // Checksum 0x3943dc1b, Offset: 0x19d2
    // Size: 0x2e, Type: dev
    function init_ww_mantis_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7b>" );
        devgui::add_devgui_func( "<dev string:x95>", "<dev string:xaa>", &function_5ee2f0c4aa4e30e6 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weap_ww_mantis
    // Params 0
    // Checksum 0xdff16969, Offset: 0x1a08
    // Size: 0x15, Type: dev
    function function_5ee2f0c4aa4e30e6()
    {
        level.player function_b63980f0807dbada();
    }

    // Namespace weap_ww_mantis
    // Params 1, eflags: 0x4
    // Checksum 0xb9adf5eb, Offset: 0x1a25
    // Size: 0x50, Type: dev
    function private function_572e461e90147262( weapon )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self endon( #"hash_a16cbba90ff8fe9d" );
        
        while ( true )
        {
            iprintlnbold( "<dev string:xc9>" + self.var_91bd5d2dff60a896 );
            waitframe();
        }
    }

#/
