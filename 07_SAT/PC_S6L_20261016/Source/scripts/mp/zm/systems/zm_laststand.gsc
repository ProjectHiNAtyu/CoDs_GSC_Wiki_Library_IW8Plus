// scripts\mp\zm\systems\zm_laststand.gsc  (hash_18849f80e7fa3007.gscc) (size: 34090 Bytes / 0x852a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc24c9952 (3259799890)
// size ...... 34090 (0x852a)
// includes .. 39  (offset: 0x7e1e)
// strings ... 69  (offset: 0x7f56)
// dev strs .. 31  (offset: 0x83a2)
// exports ... 64  (offset: 0x5312)
// cseg ...... 0x54a + 0x4dc8 (0x5312)
// imports ... 268 (offset: 0x5d12)
// animtree1 . 0   (offset: 0x852a)
// animtree2 . 0   (offset: 0x852a)
#using script_be7da0439d09064;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\points;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_ui;
#using scripts\mp\zm\zm_utility;

#namespace zm_laststand;

// Namespace zm_laststand
// Params 0, eflags: 0x5
// Checksum 0xfc82696, Offset: 0x568
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_laststand", undefined, &init_zm_laststand, undefined );
}

// Namespace zm_laststand
// Params 0
// Checksum 0xaa811921, Offset: 0x589
// Size: 0x204
function init_zm_laststand()
{
    level.laststand_always_disable_damage = 1;
    level.laststand_bleedout_think = &zm_bleedout_think;
    level.var_449c32a0f392eed7 = &function_3f7c6ebe141d8f06;
    level.modelaststandallowed = &zm_laststand_allowed;
    level.modeonlaststandfunc = &zm_on_enter_laststand;
    level.modeonexitlaststandfunc = &function_feb66a757c002961;
    level.modeplayerkilledspawn = &zm_spawn_on_player_killed;
    level.var_8cf3d608117ef48e = &function_4a1fc30948473401;
    level.removeselfrevivetoken = &zm_remove_self_revive;
    level.var_9a96921d9d23cc4f = &function_bda96b5d86433b85;
    level.var_db5fcc527a2c7a07 = &function_22e7f2e32acdf447;
    level.var_b60df5645662c1a7 = 1;
    level.var_894cf9c132c87505 = 1;
    level.var_9a67c2c3b00a701 = 1;
    level.var_da5320efd1fd6732 = 1;
    level.var_e24f88c6a48b65 = 1;
    level.var_b24f65709b8c089b = 1;
    level.var_62b49c3b2ec4111a = 1;
    level.disable_killcam = 1;
    level.var_538711d192c11c84 = 1;
    level.var_8d778b6ed49ccbc0 = 1;
    callback::add( "on_round_end", &zm_laststand_on_round_end );
    callback::add( #"player_laststand", &function_b1a70274e9508a18 );
    callback::add( #"player_laststand_revived", &on_revived );
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( #"player_death", &on_player_death );
    callback::add( #"hash_34d8a133c38aed30", &on_player_bleedout_tick );
    callback::add( #"hash_8c65892ba685a482", &function_a5d8ba76a2782b67 );
    utility::registersharedfunc( #"zm_laststand", #"zm_laststand_alive_check", &zm_laststand_alive_check );
    utility::registersharedfunc( #"zm_laststand", #"hash_7f936b8cb61507e7", &function_ee0e9425e9d2fd96 );
    level.var_29f27f9c8c97fa11 = [ "zombie_viper" ];
    
    /#
        setup_zm_laststand_devgui();
    #/
}

// Namespace zm_laststand
// Params 1
// Checksum 0x595b807d, Offset: 0x795
// Size: 0x29
function function_ee0e9425e9d2fd96( subtype )
{
    level.var_29f27f9c8c97fa11 = arraycombineunique( level.var_29f27f9c8c97fa11, [ subtype ] );
}

/#

    // Namespace zm_laststand
    // Params 0, eflags: 0x4
    // Checksum 0xaef61be1, Offset: 0x7c6
    // Size: 0x30e, Type: dev
    function private setup_zm_laststand_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x39>", "<dev string:x55>", &function_d9c81e67ae4e8d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6a>", "<dev string:xa2>", &function_9eccba297149e8c9 );
        var_c7f2665adacb0505 = getscriptbundlenames( "<dev string:xbe>" );
        var_ff3d04d0a67871f9 = [];
        a_str_aitype = [];
        
        foreach ( str_bundle in var_c7f2665adacb0505 )
        {
            s_bundle = getscriptbundle( str_bundle );
            
            foreach ( s_game_over_scene in s_bundle.var_f437355af0c34bc6 )
            {
                if ( isdefined( s_game_over_scene.scenebundle ) )
                {
                    if ( isdefined( s_game_over_scene.var_646c1d2dc488e227 ) )
                    {
                        var_a91be0a31c4b99e8 = strtok( s_game_over_scene.var_646c1d2dc488e227, "<dev string:xcd>" );
                        
                        if ( arraycontains( var_a91be0a31c4b99e8, level.mapname ) )
                        {
                            continue;
                        }
                    }
                    
                    var_ff3d04d0a67871f9 = arraycombineunique( var_ff3d04d0a67871f9, [ s_game_over_scene.scenebundle ] );
                    
                    if ( isdefined( s_game_over_scene.aitype_subclass ) )
                    {
                        a_str_aitype = arraycombineunique( a_str_aitype, [ s_game_over_scene.aitype_subclass ] );
                    }
                }
            }
        }
        
        foreach ( str_scene_name in var_ff3d04d0a67871f9 )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:xcf>" + str_scene_name, "<dev string:xe2>" + str_scene_name, &function_94969652b5c18d9f, 1 );
            devgui::function_cd4e263c1f3018ae( "<dev string:xff>" + str_scene_name, "<dev string:x11b>" + str_scene_name, &function_9eccba297149e8c9 );
        }
        
        foreach ( var_28acf052322e9b2f in a_str_aitype )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x132>" + var_28acf052322e9b2f, "<dev string:xe2>" + var_28acf052322e9b2f, &function_94969652b5c18d9f, 1 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_laststand
    // Params 1
    // Checksum 0x55556427, Offset: 0xadc
    // Size: 0x2e9, Type: dev
    function function_94969652b5c18d9f( params )
    {
        player = level.players[ 0 ];
        
        foreach ( live_player in level.players )
        {
            if ( isalive( live_player ) && live_player.sessionstate == "<dev string:x14f>" )
            {
                player = live_player;
                break;
            }
        }
        
        str_keywords = params[ 0 ];
        s_scene_struct = spawnstruct();
        
        if ( issubstr( str_keywords, "<dev string:x157>" ) )
        {
            s_scene_struct = function_5189df1acc69397e( str_keywords );
        }
        else
        {
            s_scene_struct.scenebundle = str_keywords;
        }
        
        if ( isdefined( s_scene_struct.scenebundle ) )
        {
            var_6225fb3dcaade4d3 = utility::getstructarray( "<dev string:x15f>", "<dev string:x176>" );
            var_a9c7c9fd7a0721 = [];
            
            foreach ( s_death_scene_loc in var_6225fb3dcaade4d3 )
            {
                if ( s_death_scene_loc.script_label == s_scene_struct.scenebundle || s_death_scene_loc.script_scenescriptbundle == s_scene_struct.scenebundle )
                {
                    var_a9c7c9fd7a0721[ var_a9c7c9fd7a0721.size ] = s_death_scene_loc;
                }
                
                if ( isdefined( s_death_scene_loc.script_parameters ) && isdefined( s_scene_struct.aitype_subclass ) )
                {
                    a_subclass = strtok( s_death_scene_loc.script_parameters, "<dev string:x188>" );
                    
                    if ( arraycontains( a_subclass, s_scene_struct.aitype_subclass ) )
                    {
                        var_a9c7c9fd7a0721[ var_a9c7c9fd7a0721.size ] = s_death_scene_loc;
                    }
                }
            }
            
            s_scene_loc = utility::get_array_of_closest( player.origin, var_a9c7c9fd7a0721 )[ 0 ];
        }
        
        if ( !isdefined( s_scene_loc ) )
        {
            s_scene_loc = player function_400be99570de9f41( s_scene_struct );
        }
        
        if ( isdefined( s_scene_struct.scenebundle ) )
        {
            player play_game_over_scene( s_scene_loc, s_scene_struct.scenebundle, 0 );
        }
        else if ( isdefined( s_scene_loc.script_noteworthy ) )
        {
            player play_game_over_scene( s_scene_loc, s_scene_loc.script_noteworthy, 0 );
        }
        
        if ( !level.b_zm_game_over )
        {
            player val::reset( "<dev string:x18a>", "<dev string:x193>" );
            player.health = player.maxhealth;
            setomnvarforallclients( "<dev string:x19c>", 0 );
        }
    }

    // Namespace zm_laststand
    // Params 1, eflags: 0x4
    // Checksum 0x70a3778b, Offset: 0xdcd
    // Size: 0x58, Type: dev
    function private function_9eccba297149e8c9( params )
    {
        str_scene = params[ 0 ];
        
        if ( str_scene == "<dev string:x1ac>" )
        {
            level.var_9c0d12c8f8edeb3d = undefined;
            iprintlnbold( "<dev string:x1b2>" );
            return;
        }
        
        level.var_9c0d12c8f8edeb3d = str_scene;
        iprintlnbold( "<dev string:x1d2>" + str_scene );
    }

    // Namespace zm_laststand
    // Params 0, eflags: 0x4
    // Checksum 0x471d8545, Offset: 0xe2d
    // Size: 0x20d, Type: dev
    function private function_d9c81e67ae4e8d()
    {
        var_344c87cda146b92c = ( 0, 0, -5 );
        n_text_size = 0.2;
        var_6225fb3dcaade4d3 = utility::getstructarray( "<dev string:x15f>", "<dev string:x176>" );
        
        while ( true )
        {
            foreach ( s_death_scene_loc in var_6225fb3dcaade4d3 )
            {
                v_position = s_death_scene_loc.origin;
                s_scene_zone = zone_manager::function_90e5c3e2272b0130( s_death_scene_loc.origin );
                sphere( v_position, 75, ( 0, 1, 0 ) );
                print3d( v_position, "<dev string:x1eb>" + ( s_death_scene_loc.script_scenescriptbundle ?? "<dev string:x1fd>" ), ( 0, 1, 0 ), 1, n_text_size );
                
                if ( isdefined( s_scene_zone.zone_name ) )
                {
                    print3d( v_position - var_344c87cda146b92c * 1, "<dev string:x21f>" + s_scene_zone.zone_name, ( 0, 1, 0 ), 1, n_text_size );
                }
                
                print3d( v_position + var_344c87cda146b92c * 2, "<dev string:x226>" + ( s_death_scene_loc.script_label ?? "<dev string:x251>" ), ( 0, 1, 0 ), 1, n_text_size );
                print3d( v_position + var_344c87cda146b92c * 3, "<dev string:x252>" + ( s_death_scene_loc.script_parameters ?? "<dev string:x251>" ), ( 0, 1, 0 ), 1, n_text_size );
                print3d( v_position + var_344c87cda146b92c * 4, "<dev string:x287>" + ( s_death_scene_loc.script_string ?? "<dev string:x251>" ), ( 0, 1, 0 ), 1, n_text_size );
            }
            
            waitframe();
        }
    }

#/

// Namespace zm_laststand
// Params 1
// Checksum 0xfef488de, Offset: 0x1042
// Size: 0x13
function on_player_connect( params )
{
    thread self_revive_player_setup();
}

// Namespace zm_laststand
// Params 1
// Checksum 0x92f8862e, Offset: 0x105d
// Size: 0x38
function on_player_disconnect( params )
{
    thread function_c9abd6c2db378137( params );
    thread zm_laststand_alive_check( 0 );
    
    if ( getdvarint( @"hash_4b008186f65ffa01", 0 ) == 0 )
    {
        level thread function_295feaeb0ae83e0b();
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0xe5af644a, Offset: 0x109d
// Size: 0x42
function on_player_death( params )
{
    br_public::setplayerdownedextrainfo( 0 );
    self.br_iseliminated = 1;
    br_public::function_7813786b92d850ff( 1 );
    br_utility::updateplayereliminatedomnvar();
    self.var_19da21739cdbefe6 = params;
    thread zm_laststand_alive_check( 0 );
}

// Namespace zm_laststand
// Params 0
// Checksum 0x38fc480a, Offset: 0x10e7
// Size: 0x13
function function_bda96b5d86433b85()
{
    usetime = 3000;
    return usetime;
}

// Namespace zm_laststand
// Params 0
// Checksum 0x8ee58bde, Offset: 0x1103
// Size: 0x17f
function self_revive_player_setup()
{
    self endon( #"disconnect" );
    laststand::function_39844c1e879cc048( 0 );
    self.var_aecc486f34e4dd66 = 0;
    self.var_4877be4da79014b0 = level.gametypebundle.var_4292e4b6ecbd86b5;
    self.var_63cd4b355dddbeba = level.gametypebundle.var_c5ebe645f8758bc3;
    self.var_3b2b912816c110b4 = 0;
    self.last_stand_count = 0;
    level thread function_c9abd6c2db378137();
    self waittill( #"spawned_player" );
    utility::flag_wait( "begin_round_logic" );
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        self_revive_info = zm_save::function_3df2221f7b1fd5a4();
        
        if ( isdefined( self_revive_info ) )
        {
            override_revive_count = self_revive_info.count;
            self.var_aecc486f34e4dd66 = self_revive_info.used;
            self.var_3b2b912816c110b4 = self_revive_info.var_6f806f859e675821;
            self.last_stand_count = self_revive_info.last_stand_count;
            self.var_4877be4da79014b0 += self.var_3b2b912816c110b4;
            self.var_63cd4b355dddbeba += self.var_3b2b912816c110b4;
        }
    }
    
    if ( level.players.size == 1 )
    {
        laststand::function_39844c1e879cc048( override_revive_count ?? self.var_4877be4da79014b0 );
        self.b_solo_self_revive = 1;
        return;
    }
    
    laststand::function_39844c1e879cc048( override_revive_count ?? self.var_63cd4b355dddbeba );
}

// Namespace zm_laststand
// Params 1
// Checksum 0xffd2fd52, Offset: 0x128a
// Size: 0x1c9
function function_c9abd6c2db378137( params )
{
    level notify( #"notify_check_self_revive_for_hotjoin" );
    level endon( #"notify_check_self_revive_for_hotjoin" );
    b_solo_mode = 0;
    var_31f016079b15de0e = 0;
    waitframe();
    var_95276aa22b5cd0a4 = level.players;
    
    if ( level.players.size == 1 )
    {
        b_solo_mode = 1;
        
        if ( !utility::flag( "solo_game" ) )
        {
            var_31f016079b15de0e = 1;
            utility::flag_set( "solo_game" );
        }
    }
    else if ( utility::flag( "solo_game" ) )
    {
        var_31f016079b15de0e = 1;
        utility::flag_clear( "solo_game" );
    }
    
    if ( var_31f016079b15de0e )
    {
        foreach ( player in level.players )
        {
            if ( b_solo_mode )
            {
                if ( player laststand::function_7072b516e6cffb7c() <= 0 )
                {
                    player.b_solo_self_revive = player.var_4877be4da79014b0 > player.var_aecc486f34e4dd66;
                    player laststand::function_39844c1e879cc048( int( max( 0, player.var_4877be4da79014b0 - player.var_aecc486f34e4dd66 ) ) );
                    
                    if ( player::isinlaststand( player ) && player laststand::function_aab0a23ef041d1f9() && player.var_8bec82459b31fc31 )
                    {
                        player.var_8bec82459b31fc31 thread laststand::selfrevivethink( 1 );
                    }
                }
                
                continue;
            }
            
            if ( player.b_solo_self_revive )
            {
                player thread function_da291ab2dd7d049();
            }
        }
    }
}

// Namespace zm_laststand
// Params 2, eflags: 0x4
// Checksum 0x77ecd538, Offset: 0x145b
// Size: 0x1ba
function private function_4a1fc30948473401( weaponobj, restorelastweapon )
{
    reviver = self;
    
    if ( self hasweapon( weaponobj ) )
    {
        if ( reviver inventory_utility::isswitchingtoweaponwithmonitoring( weaponobj ) )
        {
            reviver inventory_utility::abortmonitoredweaponswitch( weaponobj );
        }
        else
        {
            reviver inventory_utility::_takeweapon( weaponobj );
        }
    }
    
    if ( restorelastweapon )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && reviver utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_shadow_blade" ) && isweapon( reviver.var_cc1262e66dbb1c79 ) && reviver.aether_shroud_active )
        {
            reviver inventory_utility::domonitoredweaponswitch( reviver.var_cc1262e66dbb1c79, isbot( reviver ), 1 );
        }
        else
        {
            reviver inventory_utility::domonitoredweaponswitch( reviver.lastdroppableweaponobj, isbot( reviver ) );
        }
        
        fist_weapon = level.defaultfist ?? "t10_me_fists";
        
        if ( utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && reviver utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_fists_of_frenzy" ) && reviver hasweapon( fist_weapon ) && reviver.var_fb567d2e89888013 )
        {
            reviver inventory_utility::domonitoredweaponswitch( fist_weapon, isbot( reviver ), 1 );
        }
        else
        {
            reviver inventory_utility::domonitoredweaponswitch( fist_weapon, isbot( reviver ) );
        }
        
        currentweapon = reviver getcurrentweapon();
        
        if ( currentweapon.basename == "none" )
        {
            reviver inventory_utility::forcevalidweapon();
        }
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0xc
// Checksum 0xb96837b9, Offset: 0x161d
// Size: 0x6e
function private function_da291ab2dd7d049()
{
    self notify( #"hash_2c10a3d761a1dc44" );
    self endon( #"hash_2c10a3d761a1dc44" );
    self endon( #"disconnect" );
    
    if ( player::isinlaststand( self ) )
    {
        self waittill( #"last_stand_exit" );
    }
    
    laststand::function_39844c1e879cc048( int( max( 0, ( self.var_3b2b912816c110b4 ?? 0 ) + self.var_63cd4b355dddbeba - self.var_aecc486f34e4dd66 ) ) );
}

// Namespace zm_laststand
// Params 0
// Checksum 0x19b9c144, Offset: 0x1693
// Size: 0xf4
function function_92861fd7036b7aaf()
{
    self endon( #"disconnect" );
    perks = zombie_perks::get_active_perks_str_array();
    
    if ( isdefined( self.perma_perks ) )
    {
        perks = arrayremove( perks, self.perma_perks );
    }
    
    if ( level.gametypebundle.var_8a9e094f5cfd9af5 && !isdefined( self.bgb_enabled[ "aftertaste" ] ) )
    {
        if ( perks.size > 0 && perks.size <= 3 )
        {
            n_index = perks.size - 1;
            perks[ n_index ] = undefined;
            
            if ( isint( n_index ) )
            {
                function_cdc669dbc8ea2101( perks );
            }
        }
        
        if ( perks.size > 0 && perks.size > 3 )
        {
            for ( i = perks.size; i > 3 ; i-- )
            {
                perks[ i - 1 ] = undefined;
                
                if ( isint( i - 1 ) )
                {
                    function_cdc669dbc8ea2101( perks );
                }
            }
        }
        
        self.num_perks_decay = 0;
    }
    
    return perks;
}

// Namespace zm_laststand
// Params 0
// Checksum 0x38eef8a3, Offset: 0x1790
// Size: 0x502
function function_3f7c6ebe141d8f06()
{
    if ( isdefined( level.var_f94278b2fd45aaf3 ) )
    {
        self [[ level.var_f94278b2fd45aaf3 ]]();
    }
    
    var_a818cfdf1abf1ea2 = [];
    weaponlist = self.primaryweapons;
    var_3f7f963c1d0a720c = undefined;
    
    if ( isdefined( self.var_3bf72dcd2775aa78 ) )
    {
        finalperks = function_92861fd7036b7aaf();
        var_24dd065c4f49706 = 0;
        
        foreach ( permaperk in self.perma_perks )
        {
            if ( permaperk == "specialty_z_mod" )
            {
                var_24dd065c4f49706 = 1;
                break;
            }
        }
        
        foreach ( perk in finalperks )
        {
            if ( perk == "specialty_z_mod" )
            {
                var_24dd065c4f49706 = 1;
                break;
            }
        }
        
        if ( !var_24dd065c4f49706 )
        {
            removeidx = 0;
            
            foreach ( idx, weap in weaponlist )
            {
                if ( weap == self.var_3bf72dcd2775aa78 )
                {
                    removeidx = idx;
                    break;
                }
            }
            
            weaponlist[ removeidx ] = undefined;
            
            if ( isint( removeidx ) )
            {
                function_cdc669dbc8ea2101( weaponlist );
            }
        }
    }
    
    self.var_348359045a2cf8e1 = 1;
    
    foreach ( weaponobject in weaponlist )
    {
        weaponname = weaponobject.basename;
        var_9ce5e7e70c45b813 = weapon_utility::function_d2c8356dc369d9ce( weaponname );
        
        if ( ( weaponclass( var_9ce5e7e70c45b813 ) == "pistol" || level.weaponmetadata[ weaponobject.var_1616e6fbba9a722d ].laststandpriority > 0 ) && !weapon::function_6b74ecd475e99b4( weaponobject ) )
        {
            var_abad64ddac1ee681 = spawnstruct();
            var_abad64ddac1ee681.weaponname = weaponname;
            var_abad64ddac1ee681.weaponobject = weaponobject;
            
            if ( weapon::iswonderweapon( var_abad64ddac1ee681.weaponobject ) )
            {
                var_abad64ddac1ee681.b_wonder_weapon = 1;
            }
            
            var_abad64ddac1ee681.var_951c89546ec50477 = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weaponobject ) ?? 0;
            var_abad64ddac1ee681.n_rarity = item_weapon::function_fb81bd2fe070faa6( weaponobject ) ?? 0;
            var_abad64ddac1ee681.var_5eca5398df03e985 = level.weaponmetadata[ weaponobject.var_1616e6fbba9a722d ].laststandpriority ?? 0;
            var_a818cfdf1abf1ea2 = arraycombineunique( var_a818cfdf1abf1ea2, [ var_abad64ddac1ee681 ] );
        }
    }
    
    if ( var_a818cfdf1abf1ea2.size == 1 )
    {
        var_3f7f963c1d0a720c = var_a818cfdf1abf1ea2[ 0 ].weaponobject;
    }
    else if ( !var_a818cfdf1abf1ea2.size )
    {
        var_409d6e8d8966779 = level.laststandweapon ?? "t10_pi_p14_mable_mp";
        var_befe77de8697d410 = level.gametypebundle.var_e81084285fb4b6c9;
        
        if ( getdvar( @"hash_9a9b8c1f4f53654c", "" ) != "" )
        {
            var_409d6e8d8966779 = getdvar( @"hash_9a9b8c1f4f53654c", "t10_pi_p14_mable_mp" );
        }
        
        if ( getdvar( @"hash_2f311dffc4d3d6f7", "" ) != "" )
        {
            var_befe77de8697d410 = getdvar( @"hash_9a9b8c1f4f53654c", "t10_zm_mable" );
        }
        
        w_laststand_default = weapon_utility::function_d2c8356dc369d9ce( var_409d6e8d8966779 );
        
        if ( !w_laststand_default hasattachment( var_befe77de8697d410 ) && w_laststand_default canuseattachment( var_befe77de8697d410 ) )
        {
            w_laststand_default = w_laststand_default withattachment( var_befe77de8697d410 );
        }
        
        var_3f7f963c1d0a720c = w_laststand_default;
        self.var_348359045a2cf8e1 = 0;
    }
    else
    {
        var_ca11f26b2bfbc822 = get_best_wonder_weapon( var_a818cfdf1abf1ea2 );
        
        if ( !isdefined( var_ca11f26b2bfbc822 ) )
        {
            var_ca11f26b2bfbc822 = get_best_pap_weapon( var_a818cfdf1abf1ea2 );
        }
        
        if ( !isdefined( var_ca11f26b2bfbc822 ) )
        {
            var_ca11f26b2bfbc822 = get_best_rarity_weapon( var_a818cfdf1abf1ea2 );
        }
        
        if ( !isdefined( var_ca11f26b2bfbc822 ) )
        {
            var_ca11f26b2bfbc822 = get_highest_priority_weapon( var_a818cfdf1abf1ea2 );
        }
        
        var_3f7f963c1d0a720c = var_ca11f26b2bfbc822.weaponobject;
    }
    
    thread function_8eb6cdb18bda0629( var_3f7f963c1d0a720c );
    return var_3f7f963c1d0a720c;
}

// Namespace zm_laststand
// Params 1
// Checksum 0x1c63be3f, Offset: 0x1c9b
// Size: 0xc6
function function_5e8f908ebb11c36d( var_a818cfdf1abf1ea2 )
{
    var_c79c3ef9e4b11df = [];
    var_c79c3ef9e4b11df[ 0 ] = [];
    var_c79c3ef9e4b11df[ 1 ] = [];
    var_c79c3ef9e4b11df[ 2 ] = [];
    var_c79c3ef9e4b11df[ 3 ] = [];
    var_c79c3ef9e4b11df[ 4 ] = [];
    
    foreach ( var_abad64ddac1ee681 in var_a818cfdf1abf1ea2 )
    {
        var_c79c3ef9e4b11df[ var_abad64ddac1ee681.var_951c89546ec50477 ?? 0 ][ var_c79c3ef9e4b11df[ var_abad64ddac1ee681.var_951c89546ec50477 ?? 0 ].size ] = var_abad64ddac1ee681;
    }
    
    return var_c79c3ef9e4b11df;
}

// Namespace zm_laststand
// Params 1
// Checksum 0x378f999d, Offset: 0x1d6a
// Size: 0xd2
function function_a5623fde4d8b684f( var_a818cfdf1abf1ea2 )
{
    var_430a822db4ecc2d5 = [];
    var_430a822db4ecc2d5[ 0 ] = [];
    var_430a822db4ecc2d5[ 1 ] = [];
    var_430a822db4ecc2d5[ 2 ] = [];
    var_430a822db4ecc2d5[ 3 ] = [];
    var_430a822db4ecc2d5[ 4 ] = [];
    var_430a822db4ecc2d5[ 5 ] = [];
    var_430a822db4ecc2d5[ 6 ] = [];
    
    foreach ( var_abad64ddac1ee681 in var_a818cfdf1abf1ea2 )
    {
        var_430a822db4ecc2d5[ var_abad64ddac1ee681.n_rarity ?? 0 ][ var_430a822db4ecc2d5[ var_abad64ddac1ee681.n_rarity ?? 0 ].size ] = var_abad64ddac1ee681;
    }
    
    return var_430a822db4ecc2d5;
}

// Namespace zm_laststand
// Params 1
// Checksum 0x9e03ea48, Offset: 0x1e45
// Size: 0xb7
function get_best_wonder_weapon( var_a818cfdf1abf1ea2 )
{
    a_s_wonder_weapons = [];
    
    foreach ( var_abad64ddac1ee681 in var_a818cfdf1abf1ea2 )
    {
        if ( var_abad64ddac1ee681.b_wonder_weapon )
        {
            a_s_wonder_weapons[ a_s_wonder_weapons.size ] = var_abad64ddac1ee681;
        }
    }
    
    if ( a_s_wonder_weapons.size >= 1 )
    {
        if ( a_s_wonder_weapons.size == 1 )
        {
            return a_s_wonder_weapons[ 0 ];
        }
        
        return get_best_pap_weapon( a_s_wonder_weapons );
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0x5ccd50b5, Offset: 0x1f04
// Size: 0xd5
function get_best_pap_weapon( var_a818cfdf1abf1ea2 )
{
    var_c79c3ef9e4b11df = function_5e8f908ebb11c36d( var_a818cfdf1abf1ea2 );
    
    if ( var_c79c3ef9e4b11df[ 4 ].size >= 1 )
    {
        if ( var_c79c3ef9e4b11df[ 4 ].size == 1 )
        {
            return var_c79c3ef9e4b11df[ 4 ][ 0 ];
        }
        else
        {
            return get_best_rarity_weapon( var_c79c3ef9e4b11df[ 4 ] );
        }
        
        return;
    }
    
    if ( var_c79c3ef9e4b11df[ 3 ].size >= 1 )
    {
        if ( var_c79c3ef9e4b11df[ 3 ].size == 1 )
        {
            return var_c79c3ef9e4b11df[ 3 ][ 0 ];
        }
        else
        {
            return get_best_rarity_weapon( var_c79c3ef9e4b11df[ 3 ] );
        }
        
        return;
    }
    
    if ( var_c79c3ef9e4b11df[ 2 ].size >= 1 )
    {
        if ( var_c79c3ef9e4b11df[ 2 ].size == 1 )
        {
            return var_c79c3ef9e4b11df[ 2 ][ 0 ];
        }
        else
        {
            return get_best_rarity_weapon( var_c79c3ef9e4b11df[ 2 ] );
        }
        
        return;
    }
    
    if ( var_c79c3ef9e4b11df[ 1 ].size >= 1 )
    {
        if ( var_c79c3ef9e4b11df[ 1 ].size == 1 )
        {
            return var_c79c3ef9e4b11df[ 1 ][ 0 ];
        }
        
        return get_best_rarity_weapon( var_c79c3ef9e4b11df[ 1 ] );
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0x7e64cdb7, Offset: 0x1fe1
// Size: 0x131
function get_best_rarity_weapon( var_a818cfdf1abf1ea2 )
{
    var_430a822db4ecc2d5 = function_a5623fde4d8b684f( var_a818cfdf1abf1ea2 );
    
    if ( var_430a822db4ecc2d5[ 6 ].size >= 1 )
    {
        if ( var_430a822db4ecc2d5[ 6 ].size == 1 )
        {
            return var_430a822db4ecc2d5[ 6 ][ 0 ];
        }
        else
        {
            return get_highest_priority_weapon( var_430a822db4ecc2d5[ 6 ] );
        }
        
        return;
    }
    
    if ( var_430a822db4ecc2d5[ 5 ].size >= 1 )
    {
        if ( var_430a822db4ecc2d5[ 5 ].size == 1 )
        {
            return var_430a822db4ecc2d5[ 5 ][ 0 ];
        }
        else
        {
            return get_highest_priority_weapon( var_430a822db4ecc2d5[ 5 ] );
        }
        
        return;
    }
    
    if ( var_430a822db4ecc2d5[ 4 ].size >= 1 )
    {
        if ( var_430a822db4ecc2d5[ 4 ].size == 1 )
        {
            return var_430a822db4ecc2d5[ 4 ][ 0 ];
        }
        else
        {
            return get_highest_priority_weapon( var_430a822db4ecc2d5[ 4 ] );
        }
        
        return;
    }
    
    if ( var_430a822db4ecc2d5[ 3 ].size >= 1 )
    {
        if ( var_430a822db4ecc2d5[ 3 ].size == 1 )
        {
            return var_430a822db4ecc2d5[ 3 ][ 0 ];
        }
        else
        {
            return get_highest_priority_weapon( var_430a822db4ecc2d5[ 3 ] );
        }
        
        return;
    }
    
    if ( var_430a822db4ecc2d5[ 2 ].size >= 1 )
    {
        if ( var_430a822db4ecc2d5[ 2 ].size == 1 )
        {
            return var_430a822db4ecc2d5[ 2 ][ 0 ];
        }
        else
        {
            return get_highest_priority_weapon( var_430a822db4ecc2d5[ 2 ] );
        }
        
        return;
    }
    
    if ( var_430a822db4ecc2d5[ 1 ].size >= 1 )
    {
        if ( var_430a822db4ecc2d5[ 1 ].size == 1 )
        {
            return var_430a822db4ecc2d5[ 1 ][ 0 ];
        }
        
        return get_highest_priority_weapon( var_430a822db4ecc2d5[ 1 ] );
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0x399489a3, Offset: 0x211a
// Size: 0xb9
function get_highest_priority_weapon( var_a818cfdf1abf1ea2 )
{
    var_a818cfdf1abf1ea2 = arrayrandomize( var_a818cfdf1abf1ea2 );
    var_c1e8ec291728a76a = 0;
    var_ca11f26b2bfbc822 = var_a818cfdf1abf1ea2[ 0 ];
    
    foreach ( var_abad64ddac1ee681 in var_a818cfdf1abf1ea2 )
    {
        if ( var_abad64ddac1ee681.var_5eca5398df03e985 > var_c1e8ec291728a76a )
        {
            var_c1e8ec291728a76a = var_abad64ddac1ee681.var_5eca5398df03e985;
            var_ca11f26b2bfbc822 = var_abad64ddac1ee681;
        }
    }
    
    return var_ca11f26b2bfbc822;
}

// Namespace zm_laststand
// Params 1
// Checksum 0x253ec1c6, Offset: 0x21dc
// Size: 0x12a
function function_8eb6cdb18bda0629( var_3f7f963c1d0a720c )
{
    self notify( #"hash_caa0457b16be5485" );
    self endon( #"hash_caa0457b16be5485" );
    self endon( #"disconnect" );
    
    if ( !isweapon( var_3f7f963c1d0a720c ) )
    {
        while ( !isdefined( self.laststandweaponobj ) )
        {
            waitframe();
        }
        
        var_3f7f963c1d0a720c = self.laststandweaponobj;
    }
    
    while ( !self hasweapon( var_3f7f963c1d0a720c ) )
    {
        waitframe();
    }
    
    n_clip_start = self getweaponammoclip( var_3f7f963c1d0a720c );
    n_stock_start = self getweaponammostock( var_3f7f963c1d0a720c );
    self setweaponammoclip( var_3f7f963c1d0a720c, var_3f7f963c1d0a720c.clipsize );
    self setweaponammostock( var_3f7f963c1d0a720c, var_3f7f963c1d0a720c.clipsize * 2 );
    self waittill( #"last_stand_exit" );
    
    if ( self hasweapon( var_3f7f963c1d0a720c ) )
    {
        var_5cb6bb85d5c5aee7 = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" );
        max_stock_ammo = utility::get_max_stock_ammo( var_3f7f963c1d0a720c, var_5cb6bb85d5c5aee7 );
        
        if ( n_stock_start > max_stock_ammo )
        {
            n_stock_start = max_stock_ammo;
        }
        
        self setweaponammoclip( var_3f7f963c1d0a720c, n_clip_start );
        self setweaponammostock( var_3f7f963c1d0a720c, n_stock_start );
    }
}

// Namespace zm_laststand
// Params 9
// Checksum 0xf197023e, Offset: 0x230e
// Size: 0x83, Type: bool
function zm_laststand_allowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    return !( laststand::function_7072b516e6cffb7c() < 1 && !function_fc08a43f3c091f07() ) || level.var_59cd809a932c6ee1 || self.var_59cd809a932c6ee1;
}

// Namespace zm_laststand
// Params 0
// Checksum 0xa561b1e3, Offset: 0x239a
// Size: 0x3b
function zm_on_enter_laststand()
{
    self.var_25765b441347c2a9 = gettime();
    self.health = self.maxhealth;
    thread zm_laststand_alive_check( 0 );
    val::set( "zm_laststand_give_super_point", "allow_give_super_point", 0 );
}

// Namespace zm_laststand
// Params 1
// Checksum 0xe54dd04f, Offset: 0x23dd
// Size: 0x14
function function_a5d8ba76a2782b67( params )
{
    thread zm_laststand_alive_check( 0 );
}

// Namespace zm_laststand
// Params 1
// Checksum 0x3fd16feb, Offset: 0x23f9
// Size: 0x30
function function_feb66a757c002961( revived )
{
    thread zm_laststand_alive_check( revived );
    
    if ( revived )
    {
        self.var_25765b441347c2a9 = undefined;
    }
    
    val::reset_all( "zm_laststand_give_super_point" );
}

// Namespace zm_laststand
// Params 2
// Checksum 0xe30096c3, Offset: 0x2431
// Size: 0xa3
function zm_remove_self_revive( n_count, b_revived )
{
    if ( laststand::function_7072b516e6cffb7c() > 0 )
    {
        laststand::function_7a1a4fa42d3ac8e3( n_count, b_revived );
        return;
    }
    
    if ( isdefined( self.selfrevivedata ) )
    {
        if ( isdefined( self.selfrevivedata.weapon ) )
        {
            self takeweapon( self.selfrevivedata.weapon );
            
            if ( self.laststandoldweaponobj == self.selfrevivedata.weapon )
            {
                self.laststandoldweaponobj = inventory::getfirstprimaryweapon();
            }
            
            self.selfrevivedata = undefined;
        }
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0xad1bbf34, Offset: 0x24dc
// Size: 0x201
function get_alive_players( a_players )
{
    alive_players = [];
    
    if ( !isdefined( a_players ) )
    {
        a_players = level.players;
    }
    
    foreach ( player in a_players )
    {
        if ( !player.b_has_spawned_once && !player.var_5c81ab2cabcc273f && !player.var_282313ba8fafa8c6 )
        {
            alive_players[ alive_players.size ] = player;
            continue;
        }
        
        if ( !isdefined( player.var_84cde01ffd2cb360 ) )
        {
            player.var_84cde01ffd2cb360 = 0;
        }
        
        if ( player utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"quick_revive_last_chance" ) && player.var_84cde01ffd2cb360 < 3 )
        {
            alive_players[ alive_players.size ] = player;
            continue;
        }
        
        if ( !player::isinlaststand( player ) && isalive( player ) && ( player.sessionstate == "playing" || player.sessionstate == "playing_but_spectating" ) )
        {
            alive_players[ alive_players.size ] = player;
            continue;
        }
        
        if ( isalive( player ) && player laststand::function_7072b516e6cffb7c() > 0 )
        {
            alive_players[ alive_players.size ] = player;
            continue;
        }
        
        if ( isdefined( player.selfrevivedata ) )
        {
            alive_players[ alive_players.size ] = player;
            continue;
        }
        
        if ( level.var_e6e55ccba9ef0e84 > 0 )
        {
            alive_players[ alive_players.size ] = player;
            continue;
        }
        
        if ( player val::get( "allow_last_stand" ) )
        {
            alive_players[ alive_players.size ] = player;
        }
    }
    
    return alive_players;
}

// Namespace zm_laststand
// Params 2
// Checksum 0x1f2c5402, Offset: 0x26e6
// Size: 0xee, Type: bool
function function_d96558297a3c2b2b( str_team, var_b213c21b7e4de6c )
{
    a_players = [];
    
    if ( isdefined( str_team ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team == str_team )
            {
                a_players[ a_players.size ] = player;
            }
        }
    }
    else if ( isdefined( var_b213c21b7e4de6c ) )
    {
        a_players = var_b213c21b7e4de6c;
    }
    else
    {
        a_players = level.players;
    }
    
    if ( a_players.size > 0 && level.var_e6e55ccba9ef0e84 > 0 )
    {
        return true;
    }
    
    return get_alive_players( a_players ).size > 0;
}

// Namespace zm_laststand
// Params 0
// Checksum 0x7c5bbc97, Offset: 0x27dd
// Size: 0x27, Type: bool
function function_fc08a43f3c091f07()
{
    return function_d96558297a3c2b2b() || callback::response( 0, #"hash_bf2f3d5470c22e57", { #victim:self } );
}

// Namespace zm_laststand
// Params 2
// Checksum 0xd16f210, Offset: 0x280d
// Size: 0x56
function zm_laststand_alive_check( revived, var_5f24a9f0b0ddc048 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    
    if ( revived )
    {
        return;
    }
    
    if ( isdefined( level.var_916aae8097d37e9e ) )
    {
        self thread [[ level.var_916aae8097d37e9e ]]();
        return;
    }
    
    function_939a1c1c651dca54( revived, var_5f24a9f0b0ddc048 );
}

// Namespace zm_laststand
// Params 2
// Checksum 0x4debc571, Offset: 0x286b
// Size: 0x358
function function_939a1c1c651dca54( revived, var_5f24a9f0b0ddc048 )
{
    waitframe();
    
    if ( !isdefined( self ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && ( player::isinlaststand( player ) || !isalive( player ) ) )
            {
                player thread zm_laststand_alive_check( 0, 1 );
            }
        }
        
        return;
    }
    
    if ( level.b_zm_game_over )
    {
        return;
    }
    
    if ( !function_fc08a43f3c091f07() )
    {
        profilestart();
        
        foreach ( player in level.players )
        {
            player val::set( "zm_death", "ignoreme", 1 );
            player val::set( "zm_death", "allow_battlechatter_vo", 0 );
            player lower_message::clearlowermessages();
            player killstreaks::clearkillstreaks();
            
            if ( player != self )
            {
                if ( !utility::flag( "exfil_active" ) )
                {
                    player thread zm_laststand_fade_before_game_over_scene( 1, "game_over_scene_fade_in", self.origin, self.angles );
                }
            }
        }
        
        level notify( #"end_round_logic" );
        zm_exfil::function_e6ec4f11056ffdc7();
        zm_quest::function_4cee1b2cda04b53c();
        profilestop();
        level.b_zm_game_over = 1;
        level utility::flag_set( "zm_game_over" );
        level thread end_game();
        overlord::function_2fb527a541b257( 0 );
        level thread cleanup_zombie_intel_sound();
        
        if ( utility::flag( "begin_round_logic" ) && isdefined( self ) )
        {
            level.var_b2011147df61f080 = self;
            level callback::add( #"player_spawned", &function_3acf354222134436 );
            play_game_over_scene();
            level callback::remove( #"player_spawned", &function_3acf354222134436 );
        }
        
        level thread namespace_c0b4f2882c9d100f::vo_say_announcer( namespace_c0b4f2882c9d100f::function_157326aa0e824343( #"game_over" ) );
        wait 0.25;
        
        foreach ( player in level.players )
        {
            player notify( #"game_over_scene_fade_in" );
            player.br_iseliminated = 1;
            player br_public::function_7813786b92d850ff( 1 );
            player br_utility::updateplayereliminatedomnvar();
            player playlocalsound( #"hash_58071393496dd03e" );
            player thread playerlogic::spawnintermission( undefined, undefined, 0 );
        }
        
        setomnvarforallclients( "ui_br_squad_eliminated_active", 1 );
        level notify( #"zm_end_game_notify" );
        return;
    }
    
    if ( isdefined( self ) && !var_5f24a9f0b0ddc048 )
    {
        if ( !isdefined( self.last_stand_count ) )
        {
            self.last_stand_count = 0;
        }
        
        self.last_stand_count++;
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0xd3751252, Offset: 0x2bcb
// Size: 0x51
function function_3acf354222134436( params )
{
    if ( isalive( self ) && self != level.var_b2011147df61f080 && self.sessionstate == "playing" && zm_utility::get_round_number() == 1 )
    {
        thread zm_laststand_fade_before_game_over_scene( 1, 0.5 );
    }
}

// Namespace zm_laststand
// Params 0
// Checksum 0xf798f053, Offset: 0x2c24
// Size: 0x124
function cleanup_zombie_intel_sound()
{
    foreach ( player in level.players )
    {
        if ( isarray( player.var_1da75b5b0386a82 ) )
        {
            foreach ( e_intel_sound in player.var_1da75b5b0386a82 )
            {
                player notify( #"hash_497eab2ef470d568" );
                
                if ( isdefined( e_intel_sound ) )
                {
                    e_intel_sound stopsounds();
                    e_intel_sound thread utility::delaycallendon( 0.1, "death", &delete );
                }
            }
        }
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0x4
// Checksum 0xa9217fc4, Offset: 0x2d50
// Size: 0x35
function private end_game()
{
    level endon( #"game_ended" );
    utility::waittill_notify_or_timeout( "zm_end_game_notify", 20 );
    thread gamelogic_zm::endgame( "none", game[ "end_reason" ][ "mp_faction_eliminated" ] );
}

// Namespace zm_laststand
// Params 0, eflags: 0xc
// Checksum 0xe931418, Offset: 0x2d8d
// Size: 0x99
function private function_295feaeb0ae83e0b()
{
    self notify( #"hash_2ef8ca762744f7a1" );
    self endon( #"hash_2ef8ca762744f7a1" );
    level endon( #"game_ended" );
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    wait 30;
    
    if ( level.players.size > 0 )
    {
        return;
    }
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    level.b_zm_game_over = 1;
    level utility::flag_set( "zm_game_over" );
    level thread end_game();
    level notify( #"zm_end_game_notify" );
}

// Namespace zm_laststand
// Params 2
// Checksum 0xc85c35e5, Offset: 0x2e2e
// Size: 0xa1, Type: bool
function zm_spawn_on_player_killed( deathdata, finaldeath )
{
    deathdata.victim val::set( "zm_death", "ignoreme", 1 );
    
    if ( !level.b_zm_game_over )
    {
        if ( !level.var_2ddab79ae85798d2 && !deathdata.victim.var_2ddab79ae85798d2 )
        {
            deathdata.victim utility::delaythreadendon( 0.1, "spawned", &playerlogic::spawnspectator );
        }
        
        deathdata.victim lower_message::setlowermessageomnvar( "spawn_next_round" );
    }
    
    return true;
}

// Namespace zm_laststand
// Params 3
// Checksum 0x480f3468, Offset: 0x2ed8
// Size: 0x85a
function play_game_over_scene( var_85552802ebc4408e, str_scene_override, var_daa56e47112ca70b = 1 )
{
    self notify( #"hash_8b70f6f452800ed" );
    self endon( #"hash_8b70f6f452800ed" );
    self endon( #"disconnect" );
    
    if ( utility::flag( "exfil_active" ) )
    {
        if ( utility::issharedfuncdefined( #"zm_exfil", #"override_exfil_end" ) )
        {
            utility::callsharedfunc( #"zm_exfil", #"override_exfil_end" );
            return;
        }
        
        zm_exfil::function_bc6e8d7fad337c27( level.s_exfil_active );
        return;
    }
    
    if ( self.var_19da21739cdbefe6.objweapon.basename === level.projectbundle.var_68c894f5d919aa16 )
    {
        return;
    }
    
    var_73b6951c8a215a9a = function_5189df1acc69397e();
    
    if ( isarray( self.recentattackers ) && self.recentattackers.size )
    {
        var_69903b55f096b0af = utility::function_f1933af772476229( self.recentattackers );
        last_alive_time = self.var_25765b441347c2a9 ?? gettime();
        e_attacker = undefined;
        
        if ( last_alive_time <= var_69903b55f096b0af.ignoreaftertime )
        {
            e_attacker = var_69903b55f096b0af.attacker;
        }
        
        if ( level.var_1b2bc7c44eeecd0b )
        {
            e_attacker = level.var_1b2bc7c44eeecd0b;
        }
        
        if ( self.var_c36cb8f36e9afca1 )
        {
            var_73b6951c8a215a9a = function_5189df1acc69397e( self.var_c36cb8f36e9afca1 );
            self.var_c36cb8f36e9afca1 = undefined;
        }
        else if ( isalive( e_attacker ) && isdefined( e_attacker.subclass ) )
        {
            if ( isdefined( e_attacker.game_over_scene_subclass ) )
            {
                var_73b6951c8a215a9a = function_5189df1acc69397e( e_attacker.game_over_scene_subclass );
            }
            else
            {
                var_73b6951c8a215a9a = function_5189df1acc69397e( e_attacker.subclass );
            }
        }
    }
    else if ( level.var_1b2bc7c44eeecd0b )
    {
        e_attacker = level.var_1b2bc7c44eeecd0b;
    }
    else if ( self.var_c36cb8f36e9afca1 )
    {
        var_73b6951c8a215a9a = function_5189df1acc69397e( self.var_c36cb8f36e9afca1 );
        self.var_c36cb8f36e9afca1 = undefined;
    }
    
    s_scene_loc = function_400be99570de9f41( var_73b6951c8a215a9a );
    var_bc8620b756ba639 = function_65df54bd6a5792a7( var_73b6951c8a215a9a, s_scene_loc );
    
    if ( var_bc8620b756ba639.size == 0 )
    {
        var_73b6951c8a215a9a = function_5189df1acc69397e( "zombie_base" );
        s_scene_loc = function_400be99570de9f41( var_73b6951c8a215a9a );
        var_bc8620b756ba639 = function_65df54bd6a5792a7( var_73b6951c8a215a9a, s_scene_loc );
        var_73b6951c8a215a9a = utility::array_random( var_bc8620b756ba639 );
    }
    else
    {
        var_73b6951c8a215a9a = utility::array_random( var_bc8620b756ba639 );
    }
    
    s_scene_loc = var_73b6951c8a215a9a.var_6aed35bd84699db4 ?? function_400be99570de9f41( var_73b6951c8a215a9a );
    
    if ( isdefined( self ) && isdefined( s_scene_loc ) )
    {
        /#
            iprintlnbold( "<dev string:x2b7>" );
        #/
        
        wait 2;
        thread zm_laststand_fade_before_game_over_scene( undefined, "game_over_scene_fade_in" );
        wait 0.2;
        
        foreach ( player in level.players )
        {
            if ( player::isinlaststand( player ) )
            {
                player laststand::last_stand_exit_postfx();
            }
        }
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            self.var_14955bc056bab547 = 1;
            self.var_2d6ce24b1278055a = 1;
            self.forcespawnorigin = s_scene_loc.origin;
            
            if ( playerlogic::function_f50f2e6bc47756b7( self.team, self ) )
            {
                playerlogic::removefromalivecount( 0, "game_over" );
            }
            
            thread playerlogic::spawnplayer();
            utility::waittill_any_timeout( 10, "spawned_player" );
            waitframe();
            
            if ( self.sessionstate != "spectator" )
            {
                self setorigin( s_scene_loc.origin );
                self setplayerangles( s_scene_loc.angles ?? ( 0, 0, 0 ) );
            }
            
            self.forcespawnorigin = undefined;
            self.var_2d6ce24b1278055a = undefined;
            val::set( "zm_death", "ignoreme", 1 );
            val::set( "zm_play_game_over_scene", "damage", 0 );
        }
        else if ( player::isinlaststand( self ) )
        {
            laststand::exit( "last_stand_revived", self );
        }
        
        if ( self getstance() == "prone" || self getstance() == "crouch" )
        {
            b_stance_changed = self setstance( "stand", 0, 1, 1 );
        }
        
        val::set( "zm_play_game_over_scene", "crouch", 0 );
        val::set( "zm_play_game_over_scene", "prone", 0 );
        armor::setarmorhealth( 0, 1 );
        self.health = 1;
        a_ai = getaiarrayinradius( s_scene_loc.origin, 1000 );
        
        foreach ( ai in a_ai )
        {
            if ( isalive( ai ) && !ai.var_1f6335e27ced5dca )
            {
                ai hide();
                ai invisiblenotsolid();
            }
        }
        
        radiusdamage( s_scene_loc.origin, 1000, 9999, 9999, undefined, "MOD_EXPLOSIVE", "none", 1 );
        var_847d084dec62c9ef = function_955f614470e71cb2( s_scene_loc.origin, 1000 );
        
        foreach ( corpse in var_847d084dec62c9ef )
        {
            corpse delete();
        }
        
        var_aa3c4c43604cf37a = s_scene_loc.script_scenescriptbundle;
        self notify( #"playing_game_over_scene" );
        utility::flag_set( "playing_game_over_scene" );
        
        if ( isdefined( var_85552802ebc4408e ) && isdefined( str_scene_override ) )
        {
            play_game_over_scene_internal( var_85552802ebc4408e, str_scene_override, undefined, e_attacker );
        }
        else if ( isdefined( level.var_9c0d12c8f8edeb3d ) )
        {
            s_scene_loc = level.s_game_over_scene_override ?? s_scene_loc;
            play_game_over_scene_internal( s_scene_loc, level.var_9c0d12c8f8edeb3d, undefined, e_attacker );
        }
        else if ( isdefined( var_73b6951c8a215a9a.scenebundle ) )
        {
            play_game_over_scene_internal( s_scene_loc, var_73b6951c8a215a9a.scenebundle, undefined, e_attacker );
        }
        else if ( isdefined( s_scene_loc.script_scenescriptbundle ) )
        {
            play_game_over_scene_internal( s_scene_loc, s_scene_loc.script_scenescriptbundle, undefined, e_attacker );
        }
        else
        {
            s_scene = function_5189df1acc69397e();
            play_game_over_scene_internal( s_scene_loc, s_scene.scenebundle, undefined, e_attacker );
        }
        
        val::reset_all( "zm_play_game_over_scene" );
        s_scene_loc.script_scenescriptbundle = var_aa3c4c43604cf37a;
        
        foreach ( player in level.players )
        {
            player thread function_7b86ac5fadba1063();
        }
        
        if ( var_daa56e47112ca70b )
        {
            thread function_f68922f20a7aa6c6();
        }
        
        foreach ( ai in a_ai )
        {
            if ( isalive( ai ) )
            {
                ai show();
                ai visiblesolid();
            }
        }
        
        utility::flag_clear( "playing_game_over_scene" );
        setomnvarforallclients( "post_game_state", 1 );
    }
}

// Namespace zm_laststand
// Params 0, eflags: 0x4
// Checksum 0xe1e3ca12, Offset: 0x373a
// Size: 0x2e
function private function_f68922f20a7aa6c6()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 0.05;
    
    if ( isalive( self ) )
    {
        self suicide();
    }
}

// Namespace zm_laststand
// Params 4, eflags: 0x4
// Checksum 0xb59f7fa3, Offset: 0x3770
// Size: 0x118
function private play_game_over_scene_internal( s_scene_loc, scriptbundlename, var_4672ccb4dec711e = 2, e_attacker )
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"death_igc" );
    callback::callback( #"hash_7d450bcc4887da1e", { #e_attacker:e_attacker, #scriptbundlename:scriptbundlename, #s_scene_loc:s_scene_loc } );
    
    if ( s_scene_loc function_53e483a99c350334( scriptbundlename, e_attacker ) )
    {
        var_e24883555d64e383 = [ self, e_attacker ];
        scene::add_scene_func( scriptbundlename, &function_e8b0b9129d4400f9, "callback_play" );
        s_scene_loc scene::pre_stream_play( var_4672ccb4dec711e, var_e24883555d64e383, undefined, scriptbundlename );
    }
    else
    {
        scene::add_scene_func( scriptbundlename, &function_e8b0b9129d4400f9, "callback_play" );
        s_scene_loc scene::pre_stream_play( var_4672ccb4dec711e, self, undefined, scriptbundlename );
    }
    
    callback::callback( #"hash_7f6a3d9c503a8e0b", { #e_attacker:e_attacker, #scriptbundlename:scriptbundlename, #s_scene_loc:s_scene_loc } );
}

// Namespace zm_laststand
// Params 2
// Checksum 0xd27e1ecf, Offset: 0x3890
// Size: 0x184, Type: bool
function function_53e483a99c350334( scriptbundlename, e_attacker )
{
    support = 0;
    
    foreach ( subtype in level.var_29f27f9c8c97fa11 )
    {
        if ( issubstr( e_attacker.subclass, subtype ) )
        {
            support = 1;
            break;
        }
    }
    
    if ( !support )
    {
        return false;
    }
    
    objects = scene::get_objects_by_type( "Types_Actor", 0, scriptbundlename );
    
    if ( !isdefined( objects ) )
    {
        return false;
    }
    
    foreach ( obj in objects )
    {
        if ( obj.sceneobject.variant_object.aisubclass == e_attacker.subclass )
        {
            e_attacker setbtgoalstationary( 2 );
            e_attacker show();
            e_attacker visiblesolid();
            return true;
        }
    }
    
    return false;
}

// Namespace zm_laststand
// Params 0
// Checksum 0x485aea73, Offset: 0x3a1d
// Size: 0x80
function function_e8b0b9129d4400f9()
{
    waitframe();
    
    foreach ( player in level.players )
    {
        player notify( #"game_over_scene_fade_in" );
    }
}

// Namespace zm_laststand
// Params 1, eflags: 0x4
// Checksum 0x90f18ba0, Offset: 0x3aa5
// Size: 0xa8
function private get_game_over_scene_shot_length( scriptbundlename )
{
    scene::set_scriptbundle( scriptbundlename );
    shot_names = scene::get_shot_names();
    shot_total_length = 0;
    
    foreach ( shot_name in shot_names )
    {
        shot_total_length += scene::function_b3c7b792a7a154fa( shot_name );
    }
    
    return shot_total_length;
}

// Namespace zm_laststand
// Params 1
// Checksum 0x3092589b, Offset: 0x3b56
// Size: 0x45b
function function_400be99570de9f41( var_73b6951c8a215a9a )
{
    s_scene_loc = undefined;
    s_player_zone = zone_manager::get_current_zone();
    
    if ( isdefined( s_player_zone ) )
    {
        var_6225fb3dcaade4d3 = utility::getstructarray( "zombie_game_over_scene", "script_noteworthy" );
        var_fab10e177dda086f = [];
        
        foreach ( s_death_scene_loc in var_6225fb3dcaade4d3 )
        {
            s_scene_zone = zone_manager::function_90e5c3e2272b0130( s_death_scene_loc.origin );
            
            if ( isdefined( s_scene_zone ) && s_scene_zone.zone_name == s_player_zone.zone_name )
            {
                var_fab10e177dda086f[ var_fab10e177dda086f.size ] = s_death_scene_loc;
            }
        }
        
        if ( var_fab10e177dda086f.size == 0 )
        {
            var_4fe46938cb6db749 = utility::get_array_of_closest( self.origin, var_6225fb3dcaade4d3 );
            var_4b72969294841487 = zone_manager::function_90e5c3e2272b0130( var_4fe46938cb6db749[ 0 ].origin );
            
            if ( isdefined( var_4b72969294841487 ) )
            {
                foreach ( s_death_scene_loc in var_6225fb3dcaade4d3 )
                {
                    s_scene_zone = zone_manager::function_90e5c3e2272b0130( s_death_scene_loc.origin );
                    
                    if ( isdefined( s_scene_zone ) && s_scene_zone.zone_name == var_4b72969294841487.zone_name )
                    {
                        var_fab10e177dda086f[ var_fab10e177dda086f.size ] = s_death_scene_loc;
                    }
                }
            }
        }
        
        var_232318b9b1636a97 = [];
        
        if ( isdefined( var_73b6951c8a215a9a.scenebundle ) )
        {
            foreach ( death_scene_struct in var_fab10e177dda086f )
            {
                if ( death_scene_struct.script_label == var_73b6951c8a215a9a.scenebundle )
                {
                    var_232318b9b1636a97[ var_232318b9b1636a97.size ] = death_scene_struct;
                }
            }
        }
        
        if ( isdefined( var_73b6951c8a215a9a.aitype_subclass ) )
        {
            foreach ( death_scene_struct in var_fab10e177dda086f )
            {
                if ( isdefined( death_scene_struct.script_parameters ) )
                {
                    a_subclass = strtok( death_scene_struct.script_parameters, "|" );
                    
                    if ( arraycontains( a_subclass, var_73b6951c8a215a9a.aitype_subclass ) )
                    {
                        var_232318b9b1636a97[ var_232318b9b1636a97.size ] = death_scene_struct;
                    }
                }
            }
        }
        
        if ( var_232318b9b1636a97.size != 0 )
        {
            var_fab10e177dda086f = var_232318b9b1636a97;
        }
        else
        {
            var_7da78124ccd56266 = var_fab10e177dda086f;
            
            foreach ( scene_struct in var_fab10e177dda086f )
            {
                if ( isdefined( scene_struct.script_parameters ) || isdefined( scene_struct.script_label ) )
                {
                    var_7da78124ccd56266 = arrayremove( var_7da78124ccd56266, scene_struct );
                }
            }
            
            var_fab10e177dda086f = var_7da78124ccd56266;
        }
        
        var_fab10e177dda086f = utility::get_array_of_closest( self.origin, var_fab10e177dda086f );
        s_scene_loc = var_fab10e177dda086f[ 0 ];
    }
    
    if ( !isdefined( s_scene_loc ) )
    {
        var_6225fb3dcaade4d3 = utility::getstructarray( "zombie_game_over_scene", "script_noteworthy" );
        var_6225fb3dcaade4d3 = utility::get_array_of_closest( self.origin, var_6225fb3dcaade4d3 );
        s_scene_loc = var_6225fb3dcaade4d3[ 0 ];
    }
    
    if ( !isdefined( s_scene_loc ) )
    {
        s_scene_loc = { #angles:self.angles, #origin:self.origin };
    }
    
    return s_scene_loc;
}

// Namespace zm_laststand
// Params 2, eflags: 0x4
// Checksum 0xd64430f5, Offset: 0x3fba
// Size: 0x450
function private function_65df54bd6a5792a7( var_73b6951c8a215a9a, s_scene_loc )
{
    if ( !isdefined( str_aitype_subclass ) )
    {
        str_aitype_subclass = "zombie_base";
    }
    
    var_c7f2665adacb0505 = getscriptbundlenames( "gameoverscenes" );
    var_c27ffe14bcef875c = [];
    var_a999f3f02fbb73fa = strtok( s_scene_loc.script_string ?? "", "," );
    
    foreach ( str_bundle in var_c7f2665adacb0505 )
    {
        s_bundle = getscriptbundle( str_bundle );
        
        foreach ( s_game_over_scene in s_bundle.var_f437355af0c34bc6 )
        {
            var_7f60322f9613fef7 = spawnstruct();
            
            if ( isdefined( s_game_over_scene.scenebundle ) )
            {
                if ( isdefined( s_game_over_scene.var_646c1d2dc488e227 ) )
                {
                    var_a91be0a31c4b99e8 = strtok( s_game_over_scene.var_646c1d2dc488e227, "," );
                    
                    if ( arraycontains( var_a91be0a31c4b99e8, level.mapname ) )
                    {
                        continue;
                    }
                }
                
                if ( s_scene_loc.script_label && s_scene_loc.script_label != s_game_over_scene.scenebundle )
                {
                    continue;
                }
                
                str_bundle_subclass = s_game_over_scene.aitype_subclass ?? "zombie_base";
                
                if ( var_73b6951c8a215a9a.aitype_subclass == str_bundle_subclass && !arraycontains( var_a999f3f02fbb73fa, s_game_over_scene.scenebundle ) )
                {
                    var_e4fb09e5a6d2add7 = 0;
                    
                    foreach ( black_scene in var_a999f3f02fbb73fa )
                    {
                        if ( issubstr( s_game_over_scene.scenebundle, black_scene ) )
                        {
                            var_e4fb09e5a6d2add7 = 1;
                            break;
                        }
                    }
                    
                    if ( var_e4fb09e5a6d2add7 )
                    {
                        continue;
                    }
                    
                    var_7f60322f9613fef7.scenebundle = s_game_over_scene.scenebundle;
                    var_7f60322f9613fef7.aitype_subclass = s_game_over_scene.aitype_subclass;
                    var_c27ffe14bcef875c = arraycombineunique( var_c27ffe14bcef875c, [ var_7f60322f9613fef7 ] );
                }
            }
        }
    }
    
    if ( var_c27ffe14bcef875c.size == 0 && getdvarint( @"hash_c617fb213243c3dd", 1 ) )
    {
        var_6225fb3dcaade4d3 = utility::getstructarray( "zombie_game_over_scene", "script_noteworthy" );
        var_f6216a66b3908673 = [];
        
        foreach ( s_death_scene_loc in var_6225fb3dcaade4d3 )
        {
            if ( s_death_scene_loc.script_label == var_73b6951c8a215a9a.scenebundle )
            {
                var_f6216a66b3908673 = arraycombineunique( var_f6216a66b3908673, [ s_death_scene_loc ] );
            }
            
            if ( isdefined( s_death_scene_loc.script_parameters ) )
            {
                a_subclass = strtok( s_death_scene_loc.script_parameters, "|" );
                
                if ( arraycontains( a_subclass, var_73b6951c8a215a9a.aitype_subclass ) )
                {
                    var_f6216a66b3908673 = arraycombineunique( var_f6216a66b3908673, [ s_death_scene_loc ] );
                }
            }
        }
        
        if ( var_f6216a66b3908673.size )
        {
            var_f6216a66b3908673 = utility::get_array_of_closest( self.origin, var_f6216a66b3908673 );
            var_73b6951c8a215a9a.var_6aed35bd84699db4 = var_f6216a66b3908673[ 0 ];
            var_c27ffe14bcef875c = arraycombineunique( var_c27ffe14bcef875c, [ var_73b6951c8a215a9a ] );
        }
    }
    
    return var_c27ffe14bcef875c;
}

// Namespace zm_laststand
// Params 1
// Checksum 0xc0ca6b37, Offset: 0x4413
// Size: 0x267
function function_5189df1acc69397e( str_aitype_subclass )
{
    var_c7f2665adacb0505 = getscriptbundlenames( "gameoverscenes" );
    var_c27ffe14bcef875c = [];
    var_72b656f82ac01155 = [];
    s_scene = undefined;
    setomnvarforallclients( "post_game_state", 20 );
    
    foreach ( str_bundle in var_c7f2665adacb0505 )
    {
        s_bundle = getscriptbundle( str_bundle );
        
        foreach ( s_game_over_scene in s_bundle.var_f437355af0c34bc6 )
        {
            var_7f60322f9613fef7 = spawnstruct();
            
            if ( isdefined( s_game_over_scene.scenebundle ) )
            {
                if ( isdefined( s_game_over_scene.var_646c1d2dc488e227 ) )
                {
                    var_a91be0a31c4b99e8 = strtok( s_game_over_scene.var_646c1d2dc488e227, "," );
                    
                    if ( arraycontains( var_a91be0a31c4b99e8, level.mapname ) )
                    {
                        continue;
                    }
                }
                
                if ( !isdefined( s_game_over_scene.aitype_subclass ) || s_game_over_scene.aitype_subclass == "" )
                {
                    var_7f60322f9613fef7.scenebundle = s_game_over_scene.scenebundle;
                    var_7f60322f9613fef7.aitype_subclass = "zombie_base";
                    var_72b656f82ac01155 = arraycombineunique( var_72b656f82ac01155, [ var_7f60322f9613fef7 ] );
                    continue;
                }
                
                if ( str_aitype_subclass == s_game_over_scene.aitype_subclass )
                {
                    var_7f60322f9613fef7.scenebundle = s_game_over_scene.scenebundle;
                    var_7f60322f9613fef7.aitype_subclass = s_game_over_scene.aitype_subclass;
                    var_c27ffe14bcef875c = arraycombineunique( var_c27ffe14bcef875c, [ var_7f60322f9613fef7 ] );
                }
            }
        }
    }
    
    if ( isdefined( str_aitype_subclass ) && var_c27ffe14bcef875c.size )
    {
        s_scene = utility::array_random( var_c27ffe14bcef875c );
    }
    else
    {
        s_scene = utility::array_random( var_72b656f82ac01155 );
    }
    
    return s_scene;
}

// Namespace zm_laststand
// Params 4
// Checksum 0xe9af46dd, Offset: 0x4683
// Size: 0x186
function zm_laststand_fade_before_game_over_scene( var_7a6752c92396a567, var_9b2c391b704bb415 = 2, spectator_origin, spectator_angles )
{
    self endon( #"disconnect" );
    self endon( #"hash_c720b54f4141530" );
    logstring( "====ZM LASTSTAND: zm_laststand_fade_before_game_over_scene() called for " + self.name );
    utility::fadetoblackforplayer( self, 1, 0.1, 1, undefined, "zm_laststand" );
    game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
    wait 0.25;
    
    if ( var_7a6752c92396a567 )
    {
        if ( isalive( self ) && !self isspectatinganyone() && self.team != "spectator" && self.sessionstate != "spectator" )
        {
            playerlogic::removefromalivecount( 0, "game_over" );
        }
        
        if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_juggernog" ) )
        {
            if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103" ) )
            {
                utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103", "specialty_juggernog" );
            }
        }
        
        playerlogic::spawnspectator( spectator_origin, spectator_angles );
    }
    
    if ( isstring( var_9b2c391b704bb415 ) )
    {
        self waittill( var_9b2c391b704bb415 );
    }
    else
    {
        wait var_9b2c391b704bb415;
    }
    
    game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
    level thread utility::fadetoblackforplayer( self, 0, 1, 1, undefined, "zm_laststand" );
    lower_message::clearlowermessages();
}

// Namespace zm_laststand
// Params 0
// Checksum 0x499af8f2, Offset: 0x4811
// Size: 0x36
function function_7b86ac5fadba1063()
{
    self endon( #"disconnect" );
    self notify( #"hash_c720b54f4141530" );
    game_utility::fadetoblackforplayer( self, 1, 0 );
    wait 2;
    level thread game_utility::fadetoblackforplayer( self, 0, 1, 1 );
}

// Namespace zm_laststand
// Params 2
// Checksum 0x33b29d95, Offset: 0x484f
// Size: 0x42
function function_22e7f2e32acdf447( corpse, animduration )
{
    self endon( #"disconnect" );
    corpse endon( #"death" );
    self waittill( #"spawned_player" );
    corpse delete();
}

// Namespace zm_laststand
// Params 1
// Checksum 0x1b27de22, Offset: 0x4899
// Size: 0x107
function zm_laststand_on_round_end( params )
{
    if ( isdefined( level.var_4f74daf63a19988 ) )
    {
        [[ level.var_4f74daf63a19988 ]]( params );
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.waitingtospawnamortize )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player.var_14955bc056bab547 = 1;
            
            if ( !class::isvalidclass( player.class ) )
            {
                player.class = "default6";
            }
            
            player thread playerlogic::spawnclient();
        }
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0x197fda70, Offset: 0x49a8
// Size: 0xc5
function function_b1a70274e9508a18( params )
{
    thread br_public::setplayerdownedextrainfo( 1 );
    a_squad_members = squad_utility::getsquadmembers();
    
    foreach ( var_8a958389218cbbb3 in a_squad_members )
    {
        if ( !isdefined( var_8a958389218cbbb3 ) || var_8a958389218cbbb3 == self )
        {
            continue;
        }
        
        var_8a958389218cbbb3 thread hud_message::showsplash( "br_teammate_down", undefined, self );
        var_8a958389218cbbb3 thread br_ftue_popups::function_e05ce093ad06ba05( self );
    }
    
    self.var_19da21739cdbefe6 = params;
}

// Namespace zm_laststand
// Params 1
// Checksum 0x8f2158fb, Offset: 0x4a75
// Size: 0xab
function on_player_bleedout_tick( params )
{
    if ( !self isspectatinganyone() && isdefined( params.progress ) && level.var_9a67c2c3b00a701 )
    {
        if ( !self function_f955946904715208() )
        {
            self.maxhealth = self.maxhealth;
            self.health = int( self.maxhealth * params.progress );
            
            if ( isdefined( self.laststandreviveent.objidnum ) )
            {
                objidpoolmanager::objective_set_progress( self.laststandreviveent.objidnum, params.progress );
            }
        }
    }
}

// Namespace zm_laststand
// Params 1
// Checksum 0x86ef13d, Offset: 0x4b28
// Size: 0xa8
function on_revived( params )
{
    self endon( #"disconnect" );
    reviver = params.reviver;
    
    if ( self != reviver )
    {
        if ( !isdefined( reviver.revivecount ) )
        {
            reviver.revivecount = 0;
        }
        
        reviver.revivecount++;
        reviver zm_ui::function_b814b25c8d99fd02();
    }
    
    br_public::setplayerdownedextrainfo( 0 );
    
    if ( params.reason == "last_stand_self_revive" || params.reason == "last_stand_revived" )
    {
        thread function_a273e409bf63d9db( reviver );
    }
    
    waitframe();
    playerhealth::updatedeathsdoor();
}

// Namespace zm_laststand
// Params 1, eflags: 0x4
// Checksum 0x81c21c09, Offset: 0x4bd8
// Size: 0x69
function private function_a273e409bf63d9db( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    
    if ( isplayer( player ) )
    {
        points = player points::zm_get_points();
        player.currency[ #"essence" ] = points;
        player setclientomnvar( "zm_essence", points );
    }
}

// Namespace zm_laststand
// Params 0
// Checksum 0x8ad2aeb8, Offset: 0x4c49
// Size: 0xd3
function zm_bleedout_think()
{
    if ( level.var_bf82e408b7a0e3c3 )
    {
        if ( laststand::function_7072b516e6cffb7c() )
        {
            if ( isdefined( level.removeselfrevivetoken ) )
            {
                self [[ level.removeselfrevivetoken ]]( 1, 1 );
            }
            
            laststand::exit( "last_stand_self_revive" );
            return;
        }
    }
    
    thread laststand::bleedoutthink();
    thread laststand::suicidesetup();
    thread zm_laststand_text();
    val::set( "zm_laststand", "damage", 0 );
    val::set( "zm_laststand", "ignoreme", 1 );
    thread player_nav_obstacle();
    utility::waittill_any_ents( self, "death_or_disconnect", self, "last_stand_exit", level, "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_5c81ab2cabcc273f = 1;
    utility::delaythread( 3, &val::reset_all, "zm_laststand" );
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self forceusehintoff();
}

// Namespace zm_laststand
// Params 0
// Checksum 0x92732f7f, Offset: 0x4d24
// Size: 0x170
function player_nav_obstacle()
{
    level endon( #"game_ended" );
    
    if ( !getclosestpointonnavmesh( self.origin ) )
    {
        return;
    }
    
    nav_badplace = createnavbadplacebyent( self, 10 );
    v_origin = self.origin;
    var_b053cf64ee757d88 = gettime();
    check_time = var_b053cf64ee757d88;
    var_6787895101874fb4 = 0;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] == self )
        {
            var_6787895101874fb4 = i;
            break;
        }
    }
    
    repulsor_name = "player_" + var_6787895101874fb4 + "_laststand_repulsor";
    createnavrepulsor( repulsor_name, -1, self, 64 );
    
    while ( isalive( self ) && player::isinlaststand( self ) )
    {
        waitframe();
        
        if ( !isplayer( self ) )
        {
            break;
        }
        
        curr_time = gettime();
        
        if ( curr_time - check_time > 500 )
        {
            check_time = curr_time;
            dist_sqr = distance2dsquared( v_origin, self.origin );
            
            if ( dist_sqr > 64 || dist_sqr > 2 && gettime() - var_b053cf64ee757d88 > 2000 )
            {
                nav_badplace = function_793ef7e253521eac( self, 10 );
                v_origin = self.origin;
                var_b053cf64ee757d88 = curr_time;
            }
        }
    }
    
    if ( isdefined( nav_badplace ) )
    {
        destroynavobstacle( nav_badplace );
    }
    
    destroynavrepulsor( repulsor_name );
}

// Namespace zm_laststand
// Params 0, eflags: 0x4
// Checksum 0x724dab11, Offset: 0x4e9c
// Size: 0xa4
function private zm_laststand_text()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_exit" );
    
    while ( true )
    {
        lower_message::setlowermessageomnvar( "clear_lower_msg" );
        
        if ( self.beingrevived )
        {
            lower_message::setlowermessageomnvar( "being_revived" );
        }
        else if ( self.isselfreviving )
        {
            lower_message::setlowermessageomnvar( "reviving_self" );
        }
        else if ( isdefined( self.timeuntilbleedout ) )
        {
            if ( !laststand::function_7072b516e6cffb7c() )
            {
                if ( level.players.size > 1 )
                {
                    lower_message::setlowermessageomnvar( "revive_wait_bleedout_zm" );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_laststand
// Params 0
// Checksum 0x4679abe9, Offset: 0x4f48
// Size: 0x8b
function function_3b2825685e8bfee8()
{
    foreach ( player in level.players )
    {
        if ( player::isinlaststand( player ) )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
    }
}

// Namespace zm_laststand
// Params 0
// Checksum 0xa0706a06, Offset: 0x4fdb
// Size: 0x197
function function_cd13e317c03ffc08()
{
    level.var_59cd809a932c6ee1 = 1;
    level.var_daa8e6704828e14f = 1;
    
    if ( isdefined( level.var_916aae8097d37e9e ) )
    {
        level.saved_laststand_alive_check = level.var_916aae8097d37e9e;
    }
    
    level.var_916aae8097d37e9e = &function_8caa08553a044e2f;
    attack_proxy = utility::spawn_tag_origin();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.var_e5f2fcfec179654d = player laststand::function_7072b516e6cffb7c();
        player laststand::function_39844c1e879cc048( 0 );
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player.var_14955bc056bab547 = 1;
            player thread playerlogic::spawnclient();
            player utility::waittill_any_timeout( 3, "spawned_player" );
            player dodamage( 6666, player.origin, player, attack_proxy, "MOD_EXPLOSIVE" );
        }
        else if ( !player::isinlaststand( player ) )
        {
            player dodamage( 6666, player.origin, player, attack_proxy, "MOD_EXPLOSIVE" );
        }
        
        player val::set( "fake_laststand", "killstreaks", 0 );
    }
    
    attack_proxy delete();
}

// Namespace zm_laststand
// Params 0
// Checksum 0xab0fc965, Offset: 0x517a
// Size: 0xf2
function function_c94df23f6cd09962()
{
    level.var_59cd809a932c6ee1 = 0;
    level.var_daa8e6704828e14f = 0;
    
    if ( level.saved_laststand_alive_check )
    {
        level.var_916aae8097d37e9e = level.saved_laststand_alive_check;
        level.saved_laststand_alive_check = undefined;
    }
    else
    {
        level.var_916aae8097d37e9e = undefined;
    }
    
    function_3b2825685e8bfee8();
    
    foreach ( player in level.players )
    {
        if ( player.var_e5f2fcfec179654d )
        {
            player laststand::function_39844c1e879cc048( player.var_e5f2fcfec179654d );
        }
        
        player val::reset_all( "fake_laststand" );
    }
}

// Namespace zm_laststand
// Params 0
// Checksum 0xbbed8df7, Offset: 0x5274
// Size: 0x9e
function function_8caa08553a044e2f()
{
    self notify( #"hash_8e2e79d6d0cc9a96" );
    self endon( #"hash_8e2e79d6d0cc9a96" );
    level endon( #"game_ended" );
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    wait 30;
    
    if ( level.players.size > 0 )
    {
        return;
    }
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    level.b_zm_game_over = 1;
    level utility::flag_set( "zm_game_over" );
    thread gamelogic_zm::endgame( "none", game[ "end_reason" ][ "mp_faction_eliminated" ] );
}

