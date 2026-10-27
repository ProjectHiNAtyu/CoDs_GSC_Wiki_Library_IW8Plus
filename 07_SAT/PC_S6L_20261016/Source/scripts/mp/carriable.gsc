// scripts\mp\carriable.gsc  (hash_2fc321d925a41e8f.gscc) (size: 25047 Bytes / 0x61d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe138edfb (3778604539)
// size ...... 25047 (0x61d7)
// includes .. 19  (offset: 0x5b17)
// strings ... 91  (offset: 0x5baf)
// dev strs .. 10  (offset: 0x615f)
// exports ... 50  (offset: 0x3baf)
// cseg ...... 0x876 + 0x3339 (0x3baf)
// imports ... 195 (offset: 0x437f)
// animtree1 . 0   (offset: 0x61d7)
// animtree2 . 0   (offset: 0x61d7)
#using scripts\common\gasmask;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\supers;

#namespace carriable;

// Namespace carriable
// Params 0
// Checksum 0x1be973f8, Offset: 0x894
// Size: 0x530
function initcarriables()
{
    setdvarifuninitialized( @"hash_29937c7775cf43e8", 0 );
    setdvarifuninitialized( @"hash_4e50a1220c7fd1b7", 300 );
    setdvarifuninitialized( @"scr_br_carriable_spawn_system", 0 );
    setdvarifuninitialized( @"hash_b52d6fd4249064e5", 50 );
    setdvarifuninitialized( @"scr_br_carriable_spawn_chance", 0 );
    
    /#
        if ( getdvarint( @"hash_74cacae425805743", 0 ) > 0 )
        {
            return;
        }
    #/
    
    precachestring( &"mp_br_ingame/pickup_propane" );
    precachestring( &"mp_br_ingame/pickup_poison" );
    setdvarifuninitialized( @"carriablefusetime", 5 );
    setdvarifuninitialized( @"hash_30e08e7aa2432f46", 500 );
    level.carriabletypes = [];
    level.carriabletypes[ "propane" ] = spawnstruct();
    level.carriabletypes[ "propane" ].weaponname = "gas_can_mp";
    level.carriabletypes[ "propane" ].modelname = "offhand_wm_container_gas_tank_01";
    level.carriabletypes[ "propane" ].hinttext = &"mp_br_ingame/pickup_propane";
    level.carriabletypes[ "propane" ].detonatefunc = &carriable_detonate_propane;
    level.carriabletypes[ "propane" ].detonatesound = "gas_tank_explode";
    level.carriabletypes[ "propane" ].detonatefx = "vfx_propane_exp_main";
    level.carriabletypes[ "propane" ].detonatefxair = "vfx_propane_exp_air";
    level.carriabletypes[ "propane" ].fusefx = "vfx_carriable_fuse";
    level.carriabletypes[ "propane" ].spoutfx = "vfx_fire_spout";
    level.carriabletypes[ "propane" ].fusesound = "canister_warning";
    level.carriabletypes[ "propane" ].weaponref = makeweapon( level.carriabletypes[ "propane" ].weaponname );
    level.carriabletypes[ "neurotoxin" ] = spawnstruct();
    level.carriabletypes[ "neurotoxin" ].weaponname = "gas_can_toxic_mp";
    level.carriabletypes[ "neurotoxin" ].modelname = "offhand_wm_container_gas_tank_02";
    level.carriabletypes[ "neurotoxin" ].hinttext = &"mp_br_ingame/pickup_poison";
    level.carriabletypes[ "neurotoxin" ].detonatefunc = &carriable_detonate_neurotoxin;
    level.carriabletypes[ "neurotoxin" ].detonatesound = "neuro_tank_explode";
    level.carriabletypes[ "neurotoxin" ].detonatefx = "vfx_ntoxin_exp_main";
    level.carriabletypes[ "neurotoxin" ].detonatefxair = "vfx_ntoxin_exp_air";
    level.carriabletypes[ "neurotoxin" ].gasfxground = "vfx_ntoxin_ground_gas";
    level.carriabletypes[ "neurotoxin" ].gasfxair = "vfx_ntoxin_air_gas";
    level.carriabletypes[ "neurotoxin" ].fusefx = "vfx_carriable_fuse";
    level.carriabletypes[ "neurotoxin" ].fusesound = "canister_warning";
    level.carriabletypes[ "neurotoxin" ].weaponref = makeweapon( level.carriabletypes[ "neurotoxin" ].weaponname );
    level._effect[ "flash_bang_explode" ] = loadfxasset( "vfx_iw8_mp_equip_flashbang" );
    level._effect[ "vfx_propane_exp_main" ] = loadfxasset( "vfx_iw8_br_equip_propane_explo_main" );
    level._effect[ "vfx_propane_exp_air" ] = loadfxasset( "vfx_iw8_br_equip_propane_explo_air" );
    level._effect[ "fire_drip_test" ] = loadfxasset( "vfx_core_smktrail_smoke_geotrail_rpg" );
    level._effect[ "vfx_carriable_fuse" ] = loadfxasset( "vfx_iw8_br_equip_canister_fuse" );
    level._effect[ "vfx_fire_spout" ] = loadfxasset( "vfx_iw8_br_equip_fire_spout" );
    level._effect[ "vfx_lighter_ignite" ] = loadfxasset( "vfx_iw8_br_equip_lighter_ignite" );
    level._effect[ "vfx_ntoxin_ground_gas" ] = loadfxasset( "vfx_iw8_br_equip_ntoxin_ground_gas" );
    level._effect[ "vfx_ntoxin_air_gas" ] = loadfxasset( "vfx_iw8_br_equip_ntoxin_air_gas" );
    level._effect[ "vfx_ntoxin_exp_main" ] = loadfxasset( "vfx_iw8_br_equip_ntoxin_explo_main" );
    level._effect[ "vfx_ntoxin_exp_air" ] = loadfxasset( "vfx_iw8_br_equip_ntoxin_explo_air" );
    level.usablecarriables = [];
    level.carriablemagicgrenades = [];
    scriptable::scriptable_addusedcallbackbypart( "br_carriable_pickup", &scriptable_carriable_use );
    scriptable::scriptable_adddamagedcallback( &scriptable_carriable_damage );
    clean_and_spawn_carriables();
    br_circle::registercirclecallbacks( 9, &dangercircletick_carriable );
}

// Namespace carriable
// Params 3
// Checksum 0x7ad40d6d, Offset: 0xdcc
// Size: 0x1e1
function spawn_entity_carriable( type, origin, angles )
{
    if ( !isdefined( type ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    level.usablecarriables = function_5713d46873b29625( level.usablecarriables );
    maxents = getdvarint( @"hash_b52d6fd4249064e5", 50 );
    
    if ( level.usablecarriables.size >= maxents )
    {
        lastdropedtime = 999999999;
        oldestcarriable = undefined;
        
        foreach ( carriable in level.usablecarriables )
        {
            if ( carriable.fuselit || carriable islinked() )
            {
                continue;
            }
            
            if ( carriable.lastdropedtime < lastdropedtime )
            {
                lastdropedtime = carriable.lastdropedtime;
                oldestcarriable = carriable;
            }
        }
        
        if ( !isdefined( oldestcarriable ) )
        {
            assertmsg( "<dev string:x65>" );
        }
        
        oldestcarriable delete();
    }
    
    newcarriable = spawn( "script_model", origin );
    newcarriable setmodel( type.modelname );
    newcarriable.angles = angles;
    newcarriable.carriabletype = type;
    newcarriable carriable_init( type );
    level.usablecarriables[ level.usablecarriables.size ] = newcarriable;
    return newcarriable;
}

// Namespace carriable
// Params 0
// Checksum 0x100232dd, Offset: 0xfb6
// Size: 0x106
function clean_and_spawn_carriables()
{
    foreach ( carriable in level.usablecarriables )
    {
        if ( !isdefined( carriable ) )
        {
            continue;
        }
        
        if ( carriable islinked() )
        {
            carriable carriable_set_dropped( 1 );
        }
        
        carriable delete();
    }
    
    level.usablecarriables = [];
    
    switch ( getdvarint( @"scr_br_carriable_spawn_system", 0 ) )
    {
        case 0:
            spawn_carriables_from_scriptables_total_percentage();
            break;
        case 1:
            spawn_carriables_from_scriptables_individual_percentage();
            break;
        default:
            assertmsg( "<dev string:xaa>" );
            spawn_carriables_from_scriptables_total_percentage();
            break;
    }
}

// Namespace carriable
// Params 0
// Checksum 0xf60dbfd3, Offset: 0x10c4
// Size: 0xd2
function spawn_carriables_from_scriptables_total_percentage()
{
    scriptablepropane = getentitylessscriptablearray( "scriptable_br_carriable_propane", #classname );
    scriptableneurotoxin = getentitylessscriptablearray( "scriptable_br_carriable_neurotoxin", #classname );
    allcarriables = arraycombine( scriptablepropane, scriptableneurotoxin );
    allcarriables = arrayrandomize( allcarriables );
    
    if ( allcarriables.size == 0 )
    {
        return;
    }
    
    spawnchance = getdvarfloat( @"scr_br_carriable_spawn_chance", 0 );
    numenabled = floor( spawnchance * allcarriables.size );
    
    for ( i = 0; i < allcarriables.size ; i++ )
    {
        if ( i < numenabled )
        {
            allcarriables[ i ] setscriptablepartstate( "br_carriable_pickup", "useable" );
            continue;
        }
        
        allcarriables[ i ] setscriptablepartstate( "br_carriable_pickup", "disabled" );
    }
}

// Namespace carriable
// Params 0
// Checksum 0xad576eca, Offset: 0x119e
// Size: 0x11c
function spawn_carriables_from_scriptables_individual_percentage()
{
    spawnchance = getdvarfloat( @"scr_br_carriable_spawn_chance", 0 );
    scriptablepropane = getentitylessscriptablearray( "scriptable_br_carriable_propane", #classname );
    scriptablepropane = arrayrandomize( scriptablepropane );
    scriptableneurotoxin = getentitylessscriptablearray( "scriptable_br_carriable_neurotoxin", #classname );
    scriptableneurotoxin = arrayrandomize( scriptableneurotoxin );
    
    if ( scriptablepropane.size > 0 )
    {
        numenabled = floor( spawnchance * scriptablepropane.size );
        
        for ( i = 0; i < scriptablepropane.size ; i++ )
        {
            if ( i < numenabled )
            {
                scriptablepropane[ i ] setscriptablepartstate( "br_carriable_pickup", "useable" );
                continue;
            }
            
            scriptablepropane[ i ] setscriptablepartstate( "br_carriable_pickup", "disabled" );
        }
    }
    
    if ( scriptableneurotoxin.size > 0 )
    {
        numenabled = floor( spawnchance * scriptableneurotoxin.size );
        
        for ( i = 0; i < scriptableneurotoxin.size ; i++ )
        {
            if ( i < numenabled )
            {
                scriptableneurotoxin[ i ] setscriptablepartstate( "br_carriable_pickup", "useable" );
                continue;
            }
            
            scriptableneurotoxin[ i ] setscriptablepartstate( "br_carriable_pickup", "disabled" );
        }
    }
}

// Namespace carriable
// Params 6
// Checksum 0x8e514f9, Offset: 0x12c2
// Size: 0x14b
function scriptable_carriable_use( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:xd8>" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !player player::isreallyalive() || player.inlaststand )
    {
        return;
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        if ( isdefined( level.showuseresultsfeedback ) )
        {
            player [[ level.showuseresultsfeedback ]]( 17 );
            return;
        }
    }
    
    if ( !instance carriable_can_pickup( player ) )
    {
        return;
    }
    
    if ( state == "useable" )
    {
        type = level.carriabletypes[ "propane" ];
        
        if ( instance.classname == "scriptable_br_carriable_neurotoxin" )
        {
            type = level.carriabletypes[ "neurotoxin" ];
        }
        
        instance setscriptablepartstate( "br_carriable_pickup", "disabled" );
        level notify( "carriable_kill_callout_" + instance.origin );
        newcarriable = spawn_entity_carriable( type, player.origin );
        newcarriable thread carriable_pickup( player );
        level thread respawn_scriptible_carriable_wait( instance, part );
    }
}

// Namespace carriable
// Params 1
// Checksum 0x92322f07, Offset: 0x1415
// Size: 0x32, Type: bool
function iscarriablescriptable( instance )
{
    return instance.type == "br_carriable_neurotoxin" || instance.type == "br_carriable_propane";
}

// Namespace carriable
// Params 11
// Checksum 0xcf645aa, Offset: 0x1450
// Size: 0x8a
function scriptable_carriable_damage( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !iscarriablescriptable( instance ) )
    {
        return;
    }
    
    level thread scriptable_carriable_damage_internal( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
}

// Namespace carriable
// Params 11
// Checksum 0xa46fcf4b, Offset: 0x14e2
// Size: 0x155
function scriptable_carriable_damage_internal( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    waittillframeend();
    type = level.carriabletypes[ "propane" ];
    
    if ( instance.type == "br_carriable_neurotoxin" )
    {
        type = level.carriabletypes[ "neurotoxin" ];
    }
    
    level notify( "carriable_kill_callout_" + instance.origin );
    entitycarriable = spawn_entity_carriable( type, instance.origin, instance.angles );
    entitycarriable.owner = eattacker;
    entitycarriable.team = eattacker.team;
    entitycarriable thread [[ type.detonatefunc ]]();
    entitycarriable makeunusable();
    entitycarriable hide();
    entitycarriable.origin = instance.origin + ( 0, 0, 10000 );
    wait 5;
    entitycarriable delete();
}

// Namespace carriable
// Params 2
// Checksum 0x47f9bdcb, Offset: 0x163f
// Size: 0x4b
function respawn_scriptible_carriable_wait( instance, part )
{
    respawntime = getdvarfloat( @"hash_29937c7775cf43e8", 0 );
    
    if ( respawntime == 0 )
    {
        return;
    }
    
    wait respawntime;
    instance setscriptablepartstate( "br_carriable_pickup", "useable" );
}

// Namespace carriable
// Params 1
// Checksum 0xf4648c48, Offset: 0x1692
// Size: 0x6b
function spawn_carriable_at_struct( struct )
{
    arg = "propane";
    
    if ( struct.script_noteworthy == "carriable_neurotoxin" )
    {
        arg = "neurotoxin";
    }
    
    type = level.carriabletypes[ arg ];
    newcarriable = spawn_entity_carriable( type, struct.origin );
}

/#

    // Namespace carriable
    // Params 1
    // Checksum 0x499e4a83, Offset: 0x1705
    // Size: 0xff, Type: dev
    function function_fea736cef62e8226( arg )
    {
        if ( !isdefined( level.usablecarriables ) )
        {
            initcarriables();
        }
        
        type = level.carriabletypes[ arg ];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isbot( player ) || isai( player ) || player isplayerheadless() )
            {
                continue;
            }
            
            newcarriable = spawn_entity_carriable( type, player.origin + ( 0, 0, 10 ) );
        }
    }

    // Namespace carriable
    // Params 0
    // Checksum 0xd7d1a3af, Offset: 0x180c
    // Size: 0x24, Type: dev
    function function_8390d3c9f27b19bf()
    {
        if ( !isdefined( level.usablecarriables ) )
        {
            initcarriables();
            return;
        }
        
        clean_and_spawn_carriables();
    }

#/

// Namespace carriable
// Params 1
// Checksum 0x82fda11d, Offset: 0x1838
// Size: 0x73
function carriable_init( carriabletype )
{
    self.start_origin = self.origin;
    self.carriabletype = carriabletype;
    
    if ( !isdefined( self.script_health ) )
    {
        self.script_health = 16;
    }
    
    self setnonstick( 1 );
    carriable_ready();
    self sethintstring( self.carriabletype.hinttext );
    self setuseholdduration( "duration_short" );
}

// Namespace carriable
// Params 0
// Checksum 0x62f607c3, Offset: 0x18b3
// Size: 0x21
function carriable_respawn()
{
    self.origin = self.start_origin;
    self show();
    carriable_ready();
}

// Namespace carriable
// Params 0
// Checksum 0xb1946139, Offset: 0x18dc
// Size: 0x90
function carriable_ready()
{
    self physics_takecontrol( 1 );
    self physics_registerforcollisioncallback();
    thread carriable_watch_for_physics_collison();
    self.lastdropedtime = gettime();
    
    if ( !isdefined( self.fuselit ) )
    {
        self.fuselit = 0;
    }
    
    if ( !self.fuselit )
    {
        self makeusable();
        thread carriable_pickup_wait();
        thread carriable_inactive_delete_wait();
    }
    
    if ( self.script_health > 0 )
    {
        self setcandamage( 1 );
        self.damage_taken = 0;
        self.health = 99999999;
        thread carriable_damage_wait();
    }
}

// Namespace carriable
// Params 0
// Checksum 0x4a491e67, Offset: 0x1974
// Size: 0x133
function carriable_damage_wait()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"pickup" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vhitdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon );
        self.health = 99999999;
        
        if ( idamage < 2 )
        {
            thread carriable_lightfuse( eattacker );
            continue;
        }
        
        switch ( smeansofdeath )
        {
            case #"hash_40a94c5d9e4e265b":
            case #"hash_a5123f4d02745600":
            case #"hash_abb1587cdc6def23":
            case #"hash_b1078ff213fddba6":
                continue;
            default:
                self.owner = eattacker;
                self.team = eattacker.team;
                thread carriable_explode();
                return;
        }
    }
}

// Namespace carriable
// Params 1
// Checksum 0x724946da, Offset: 0x1aaf
// Size: 0xf1
function carriable_lightfuse( player )
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"pickup" );
    
    if ( self.fuselit )
    {
        return;
    }
    
    if ( false )
    {
        thread carriable_fuse_ui( player );
    }
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_gas_can_status", 2 );
    }
    
    self.fuselit = 1;
    self playsoundonmovingent( self.carriabletype.fusesound );
    playfxontag( level._effect[ self.carriabletype.fusefx ], self, "tag_fx" );
    fuse = getdvarfloat( @"carriablefusetime", 5 );
    wait fuse;
    self.owner = player;
    self.team = player.team;
    thread carriable_explode();
}

// Namespace carriable
// Params 1
// Checksum 0x49676971, Offset: 0x1ba8
// Size: 0x9b
function carriable_fuse_ui( player )
{
    usebar = player hud_util::createprimaryprogressbar();
    var_b593d9f41a046171 = player hud_util::createprimaryprogressbartext();
    var_b593d9f41a046171 settext( "FUSE LIT" );
    fuse = getdvarfloat( @"carriablefusetime", 5 );
    
    if ( fuse <= 0 )
    {
        fuse = 1;
    }
    
    usebar hud_util::updatebar( 0, 1 / fuse );
    player utility::waittill_any( "death", "weapon_fired", "drop_object" );
    usebar hud_util::destroyelem();
    var_b593d9f41a046171 hud_util::destroyelem();
}

// Namespace carriable
// Params 0
// Checksum 0x806994c6, Offset: 0x1c4b
// Size: 0xe3
function carriable_explode()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"explode" );
    level notify( "carriable_kill_callout_" + self.origin );
    
    if ( self.fuselit )
    {
        stopfxontag( level._effect[ self.carriabletype.fusefx ], self, "tag_fx" );
    }
    
    if ( self islinked() )
    {
        thread carriable_physics_launch_drop( ( 0, 0, -90 ), self.owner );
        wait 0.1;
    }
    
    self [[ self.carriabletype.detonatefunc ]]();
    self makeunusable();
    self hide();
    self.origin += ( 0, 0, 10000 );
    wait 5;
    self delete();
}

// Namespace carriable
// Params 0
// Checksum 0x4d67b76b, Offset: 0x1d36
// Size: 0x66
function carriable_pickup_wait()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"pickup" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isalive( player ) && carriable_can_pickup( player ) )
        {
            thread carriable_pickup( player );
            return;
        }
    }
}

// Namespace carriable
// Params 1
// Checksum 0x547a66ce, Offset: 0x1da4
// Size: 0x23f
function carriable_pickup( player )
{
    self notify( #"pickup" );
    level notify( "carriable_kill_callout_" + self.origin );
    linkedparent = self getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        self unlink();
    }
    
    player val::set( "carriable", "equipment_primary", 0 );
    player val::set( "carriable", "equipment_secondary", 0 );
    self physicslaunchserver( self.origin, ( 0, 0, 0 ) );
    self physicsstopserver();
    self show();
    self hide( 1 );
    self linkto( player, "tag_accessory_right", ( 0, 0, 0 ), player.angles );
    
    if ( isdefined( self.projectile ) )
    {
        self.projectile delete();
    }
    
    self setcandamage( 0 );
    self setotherent( player );
    self makeunusable();
    self.carrier = player;
    self.owner = player;
    player.iscarrying = 1;
    player.prepickupweapon = player getcurrentweapon();
    player giveweapon( self.carriabletype.weaponref );
    player setweaponammoclip( self.carriabletype.weaponref, 1 );
    player switchtoweapon( self.carriabletype.weaponref );
    player thread carriable_throw_watch( self );
    player thread carriable_fuse_light_watch( self );
    player thread carriable_weapon_change_watch( self );
    player thread carriable_player_death_watch( self );
    player thread carriable_player_state_drop_watch( self );
    player thread carriable_error_messsage_watch();
    
    if ( !isai( player ) )
    {
        player notifyonplayercommand( "lethal_attempt_carriable", "+frag" );
        player notifyonplayercommand( "lethal_attempt_carriable", "+smoke" );
        player notifyonplayercommand( "fuse_attempt_carriable", "+speed_throw" );
        
        if ( !player isconsoleplayer() )
        {
            player notifyonplayercommand( "fuse_attempt_carriable", "+toggleads_throw" );
        }
    }
    
    player val::set( "carriable", "supers", 0 );
    player allowmelee( 0 );
    player allowsupersprint( 0 );
    player setclientomnvar( "ui_gas_can_status", 1 );
}

// Namespace carriable
// Params 1
// Checksum 0xb93b1115, Offset: 0x1feb
// Size: 0xd1, Type: bool
function valid_carriable_pickup_weapon( weapon )
{
    objweapon = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( objweapon ) )
    {
        return false;
    }
    
    if ( isnullweapon( weapon ) )
    {
        return false;
    }
    
    foreach ( carriabletype in level.carriabletypes )
    {
        if ( carriabletype.weaponref == weapon )
        {
            return false;
        }
    }
    
    if ( killstreak_shared::isremotekillstreakweapon( objweapon ) )
    {
        return false;
    }
    
    if ( weapon::iskillstreakweapon( objweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace carriable
// Params 1
// Checksum 0x8a54f762, Offset: 0x20c5
// Size: 0x1a5, Type: bool
function carriable_can_pickup( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "weapon" ) )
    {
        return false;
    }
    
    if ( player supers_mp::issuperinuse() )
    {
        return false;
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    if ( player.isreviving )
    {
        return false;
    }
    
    if ( player isskydiving() )
    {
        return false;
    }
    
    if ( player.isjuggernaut )
    {
        if ( isdefined( level.showuseresultsfeedback ) )
        {
            player [[ level.showuseresultsfeedback ]]( 16 );
            return false;
        }
    }
    
    if ( isdefined( player.manuallyjoiningkillstreak ) && player.manuallyjoiningkillstreak )
    {
        return false;
    }
    
    if ( player.iscarrying )
    {
        if ( isdefined( level.showuseresultsfeedback ) )
        {
            player [[ level.showuseresultsfeedback ]]( 3 );
            return false;
        }
    }
    
    currentweapon = player getcurrentweapon();
    
    if ( isdefined( currentweapon ) )
    {
        if ( !valid_carriable_pickup_weapon( currentweapon ) )
        {
            player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
            return false;
        }
    }
    
    nextweapon = player.changingweapon;
    
    if ( isdefined( nextweapon ) && player isswitchingweapon() )
    {
        if ( !valid_carriable_pickup_weapon( nextweapon ) )
        {
            return false;
        }
    }
    
    if ( player inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        nextweapon = player inventory_utility::getcurrentmonitoredweaponswitchweapon();
        
        if ( !valid_carriable_pickup_weapon( nextweapon ) )
        {
            return false;
        }
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    if ( self.fuselit )
    {
        return false;
    }
    
    if ( player.insertingarmorplate )
    {
        return false;
    }
    
    return true;
}

// Namespace carriable
// Params 1
// Checksum 0xfcc9fc37, Offset: 0x2273
// Size: 0x145
function carriable_throw_watch( carriable )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    extra_pitch = 0;
    force = getdvarfloat( @"hash_30e08e7aa2432f46", 500 );
    spawnorigin = undefined;
    
    while ( true )
    {
        self waittill( #"grenade_fire", projectile, objweapon );
        
        if ( objweapon != carriable.carriabletype.weaponref )
        {
            continue;
        }
        
        if ( isdefined( projectile ) )
        {
            spawnorigin = projectile.origin;
            waitframe();
            projectile delete();
        }
        
        self setweaponammoclip( carriable.carriabletype.weaponref, 0 );
        break;
    }
    
    if ( self issprintsliding() )
    {
        extra_pitch = -12;
        force += 200;
    }
    
    playerangles = self getplayerangles();
    playerangles += ( extra_pitch, 0, 0 );
    playerangles = ( clamp( playerangles[ 0 ], -85, 85 ), playerangles[ 1 ], playerangles[ 2 ] );
    dir = anglestoforward( playerangles );
    carriable thread carriable_physics_launch_drop( dir * force, self, spawnorigin );
}

// Namespace carriable
// Params 0
// Checksum 0xb0afe1ac, Offset: 0x23c0
// Size: 0x24
function disable_weapon_swap_until_swap_finished()
{
    self disableweaponswitch();
    utility::waittill_any( "weapon_change", "death_or_disconnect", "drop_object" );
    self enableweaponswitch();
}

// Namespace carriable
// Params 1
// Checksum 0xef636e87, Offset: 0x23ec
// Size: 0x8a
function carriable_weapon_change_watch( carriable )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    thread disable_weapon_swap_until_swap_finished();
    
    while ( true )
    {
        self waittill( #"weapon_change", objweapon );
        
        if ( !isdefined( objweapon ) )
        {
            continue;
        }
        
        if ( objweapon != carriable.carriabletype.weaponref )
        {
            break;
        }
    }
    
    carriable thread carriable_set_dropped( 0 );
}

// Namespace carriable
// Params 0
// Checksum 0x56676882, Offset: 0x247e
// Size: 0x4b
function carriable_error_messsage_watch()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    
    while ( true )
    {
        self waittill( #"lethal_attempt_carriable" );
        hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
    }
}

// Namespace carriable
// Params 1
// Checksum 0xdd9bffa2, Offset: 0x24d1
// Size: 0x8b
function carriable_player_state_drop_watch( carriable )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    
    while ( true )
    {
        if ( self isskydiving() )
        {
            break;
        }
        
        if ( supers_mp::issuperinuse() )
        {
            if ( !carriable.var_c201b706686e928e )
            {
                break;
            }
        }
        
        if ( vehicle::is_in_vehicle( 1 ) )
        {
            break;
        }
        
        if ( self isinexecutionattack() || self isinexecutionvictim() )
        {
            break;
        }
        
        waitframe();
    }
    
    carriable thread carriable_set_dropped( 0 );
}

// Namespace carriable
// Params 1
// Checksum 0x85e7c351, Offset: 0x2564
// Size: 0x9f
function carriable_fuse_light_watch( carriable )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"drop_object" );
    
    while ( true )
    {
        self waittill( #"fuse_attempt_carriable" );
        
        if ( self getcurrentweapon() == carriable.carriabletype.weaponref && !self attackbuttonpressed() )
        {
            fadeouttime = self getgestureanimlength( "ges_gas_can_ignite" );
            thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gas_can_ignite", fadeouttime );
            wait fadeouttime;
            carriable thread carriable_lightfuse( self );
            return;
        }
    }
}

// Namespace carriable
// Params 1
// Checksum 0xa37836e6, Offset: 0x260b
// Size: 0x83
function carriable_player_death_watch( carriable )
{
    level endon( #"game_ended" );
    self endon( #"drop_object" );
    self waittill( #"death_or_disconnect" );
    playerangles = self getplayerangles();
    playerangles = ( clamp( playerangles[ 0 ], -85, 85 ), absangleclamp180( playerangles[ 1 ] ), 0 );
    dir = anglestoforward( playerangles );
    force = 90;
    carriable thread carriable_physics_launch_drop( dir * force, self );
}

// Namespace carriable
// Params 3
// Checksum 0xff01e7a4, Offset: 0x2696
// Size: 0x1c3
function carriable_physics_launch( force, droppingplayer, spawnorigin )
{
    self.origin_prev = undefined;
    owner = self;
    
    if ( !isdefined( spawnorigin ) )
    {
        if ( isdefined( droppingplayer ) )
        {
            spawnorigin = droppingplayer geteye();
        }
        else
        {
            spawnorigin = self.origin;
        }
    }
    
    if ( isdefined( droppingplayer ) )
    {
        var_1bccf2d8e2f17856 = vectortoangles( ( force[ 0 ], force[ 1 ], -45 ) );
        var_1bccf2d8e2f17856 += ( 0, 0, -45 );
        self.angles = var_1bccf2d8e2f17856;
        owner = droppingplayer;
        right = anglestoright( force );
        origin = spawnorigin + ( right[ 0 ], right[ 1 ], 0 ) * 7;
        
        if ( droppingplayer issprintsliding() )
        {
            origin += ( 0, 0, 10 );
        }
        
        startpos = origin;
        delta = vectornormalize( force ) * 80;
        content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
        contentoverride = physics_createcontents( content );
        trace = trace::sphere_trace( startpos, startpos + delta, 38, droppingplayer, contentoverride );
        
        if ( trace[ "fraction" ] < 1 )
        {
            t = 0.7 * trace[ "fraction" ];
            self.origin = startpos + delta * t;
        }
        else
        {
            self.origin = trace[ "position" ];
        }
    }
    
    self dontinterpolate();
    self physicslaunchserver( self.origin, force );
}

// Namespace carriable
// Params 0
// Checksum 0x57feb586, Offset: 0x2861
// Size: 0xf1
function carriable_watch_for_physics_collison()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"pickup" );
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( !self.fuselit )
        {
            continue;
        }
        
        if ( isdefined( ent ) && isdefined( ent vehicle::get_ref() ) )
        {
            if ( !isdefined( self.owner ) )
            {
                driver = vehicle_occupancy::get_driver( ent );
                
                if ( !isplayer( driver ) )
                {
                    continue;
                }
                
                self.owner = driver;
            }
            
            thread carriable_explode();
            break;
        }
    }
}

// Namespace carriable
// Params 3
// Checksum 0x3859d9be, Offset: 0x295a
// Size: 0x44
function carriable_physics_launch_drop( force, droppingplayer, spawnorigin )
{
    self.moverdoesnotkill = 1;
    carriable_set_dropped( 1 );
    carriable_physics_launch( force, droppingplayer, spawnorigin );
    carriable_ready();
}

// Namespace carriable
// Params 1
// Checksum 0xfb06c30, Offset: 0x29a6
// Size: 0x18f, Type: bool
function carriable_set_dropped( skip_physics )
{
    default_movement_force = 40;
    drop_height_offset = 11;
    drop_forward_offset = 7.1;
    
    if ( !isdefined( skip_physics ) )
    {
        skip_physics = 0;
    }
    
    self.droptime = gettime();
    self notify( #"dropped" );
    dropangles = ( 0, 0, 0 );
    carrier = self.carrier;
    
    if ( isdefined( carrier ) && carrier.team != "spectator" )
    {
        droporigin = carrier.origin;
        dropangles = carrier.angles;
        carrier notify( #"drop_object" );
        carrier setclientomnvar( "ui_gas_can_status", 0 );
    }
    else
    {
        droporigin = self.start_origin;
    }
    
    angles = ( 0, dropangles[ 1 ], 0 );
    forward = anglestoforward( angles );
    droporigin += ( 0, 0, drop_height_offset ) + drop_forward_offset * forward;
    self.origin = droporigin;
    self.angles = dropangles;
    self show();
    linkedparent = self getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        self unlink();
    }
    
    carrier_cleanup();
    self dontinterpolate();
    self.ownerteam = "any";
    
    if ( !skip_physics )
    {
        velocity = forward * default_movement_force;
        carriable_physics_launch( velocity );
        carriable_ready();
    }
    
    return true;
}

// Namespace carriable
// Params 0
// Checksum 0x6180d431, Offset: 0x2b3e
// Size: 0xfc
function carrier_cleanup()
{
    if ( isdefined( self.carrier ) )
    {
        self.carrier.iscarrying = 0;
        self setotherent( undefined );
        self.carrier thread carrier_remove_carriable_weapon();
        self.carrier val::reset_all( "carriable" );
        
        if ( !isai( self.carrier ) )
        {
            self.carrier notifyonplayercommandremove( "lethal_attempt_carriable", "+frag" );
            self.carrier notifyonplayercommandremove( "lethal_attempt_carriable", "+smoke" );
            self.carrier notifyonplayercommandremove( "fuse_attempt_carriable", "+speed_throw" );
            
            if ( !self.carrier isconsoleplayer() )
            {
                self.carrier notifyonplayercommandremove( "fuse_attempt_carriable", "+toggleads_throw" );
            }
        }
        
        self.carrier allowmelee( 1 );
        self.carrier allowsupersprint( 1 );
        self.carrier = undefined;
    }
}

// Namespace carriable
// Params 0
// Checksum 0x803a3be3, Offset: 0x2c42
// Size: 0x10c
function carrier_remove_carriable_weapon()
{
    self endon( #"death_or_disconnect" );
    
    foreach ( carriabletype in level.carriabletypes )
    {
        if ( self getcurrentweapon() == carriabletype.weaponref )
        {
            if ( self getweaponammoclip( carriabletype.weaponref ) == 0 )
            {
                wait 0.3;
                self switchtoweaponimmediate( self.prepickupweapon );
            }
            else
            {
                self switchtoweaponimmediate( self.prepickupweapon );
            }
            
            self takeweapon( carriabletype.weaponref );
            break;
        }
        
        if ( self hasweapon( carriabletype.weaponref ) )
        {
            self takeweapon( carriabletype.weaponref );
            break;
        }
    }
}

// Namespace carriable
// Params 3
// Checksum 0xf0c1428d, Offset: 0x2d56
// Size: 0xdb
function dangercircletick_carriable( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !isdefined( level.usablecarriables ) )
    {
        return;
    }
    
    radiussquared = dangercircleradius * dangercircleradius;
    
    foreach ( carriable in level.usablecarriables )
    {
        if ( isdefined( carriable ) && !carriable islinked() && distance2dsquared( carriable.origin, dangercircleorigin ) > radiussquared )
        {
            carriable delete();
        }
    }
}

// Namespace carriable
// Params 0
// Checksum 0x800c9f27, Offset: 0x2e39
// Size: 0x53
function carriable_inactive_delete_wait()
{
    self endon( #"death" );
    self endon( #"explode" );
    self endon( #"pickup" );
    inactivetime = getdvarfloat( @"hash_4e50a1220c7fd1b7", 300 );
    
    if ( inactivetime == 0 )
    {
        return;
    }
    
    wait inactivetime;
    self delete();
}

// Namespace carriable
// Params 0
// Checksum 0xcc66391c, Offset: 0x2e94
// Size: 0x30b
function carriable_detonate_propane()
{
    var_35626ff4da0f807e = 2;
    bottom = self.origin + ( 0, 0, -96 );
    end_pos = physicstrace( self.origin, bottom );
    inairdetonation = end_pos == bottom;
    detonatestate = "detonateGround";
    
    if ( inairdetonation )
    {
        detonatestate = "detonateAir";
    }
    
    fxscriptable = spawnscriptable( "br_carriable_explosion_propane", self.origin, self.angles );
    fxscriptable setscriptablepartstate( "carrible_explode_base", detonatestate );
    fxscriptable thread cleanupexplosionleftovers( 5 );
    burnsource = spawn( "script_origin", self.origin );
    burnsource.targetname = "carriable_detonate_propane";
    burnsource.angles = self.angles;
    burnsource.owner = self.owner;
    burnsource.team = self.team;
    burnsource.script_noteworthy = "fake_molotov";
    burnsource.weapon_name = "gas_can_mp";
    
    if ( isplayer( self.owner ) )
    {
        self radiusdamage( burnsource.origin, 250, 400, 1, self.owner, "MOD_EXPLOSIVE", "c4_mp" );
    }
    else
    {
        self radiusdamage( burnsource.origin, 250, 400, 1, undefined, "MOD_EXPLOSIVE", "c4_mp" );
    }
    
    var_852c9c48983a1948 = "gas_can_fire_spout";
    var_efb79d1c35ff8a0a = 3;
    
    /#
        var_efb79d1c35ff8a0a = getdvarint( @"hash_2a07d883d78a5551", 3 );
    #/
    
    level.carriablemagicgrenades = function_46f9072493651dc9( level.carriablemagicgrenades );
    i = 0;
    vecarray = getfirespoutlaunchvectors( var_efb79d1c35ff8a0a );
    
    while ( i < var_efb79d1c35ff8a0a )
    {
        if ( level.carriablemagicgrenades.size >= 12 )
        {
            break;
        }
        
        grenade = magicgrenademanual( var_852c9c48983a1948, self.origin + vecarray[ i ] * 0.02, vecarray[ i ], 5 );
        level.carriablemagicgrenades[ level.carriablemagicgrenades.size ] = grenade;
        grenade thread firespoutwatch( burnsource );
        i++;
    }
    
    if ( end_pos != bottom )
    {
        burnsource molotov::molotov_simulate_impact( burnsource, end_pos, ( 0, 0, 0 ), undefined, ( 0, 0, 0 ), gettime() );
    }
    else if ( level.carriablemagicgrenades.size < 12 )
    {
        grenade = magicgrenademanual( var_852c9c48983a1948, self.origin + ( 0, 0, -30 ), ( 0, 0, -200 ), 5 );
        level.carriablemagicgrenades[ level.carriablemagicgrenades.size ] = grenade;
        grenade thread firespoutwatch( burnsource );
    }
    
    burnsource thread cleanupexplosionleftovers( 30 );
}

// Namespace carriable
// Params 1
// Checksum 0x2346cc2d, Offset: 0x31a7
// Size: 0xe1
function getfirespoutlaunchvectors( numvectors )
{
    vecarray = [];
    
    if ( numvectors <= 0 )
    {
        return vecarray;
    }
    
    var_e59b73d60fc73844 = 360 / numvectors;
    initaloffset = randomfloatrange( -1 * var_e59b73d60fc73844, var_e59b73d60fc73844 );
    
    for ( i = 0; i < numvectors ; i++ )
    {
        randomoffset = randomfloatrange( -0.5 * var_e59b73d60fc73844, 0.5 * var_e59b73d60fc73844 );
        angle = i * var_e59b73d60fc73844 + randomoffset + initaloffset;
        dir = vectornormalize( rotatepointaroundvector( ( 0, 0, 1 ), ( 0, 0.7, 0.7 ), angle ) );
        power = randomfloatrange( 250, 400 );
        vecarray[ vecarray.size ] = dir * power;
    }
    
    return vecarray;
}

// Namespace carriable
// Params 1
// Checksum 0xcc190625, Offset: 0x3291
// Size: 0x8a
function firespoutwatch( burnsource )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    self waittill( #"missile_stuck", stuckto );
    burnsource molotov::molotov_simulate_impact( burnsource, self.origin, burnsource.angles, undefined, ( 0, 0, 0 ), gettime() );
    level.carriablemagicgrenades = arrayremove( level.carriablemagicgrenades, self );
    self delete();
}

// Namespace carriable
// Params 1
// Checksum 0xf6806932, Offset: 0x3323
// Size: 0x40
function cleanupexplosionleftovers( waittime )
{
    self endon( #"death" );
    
    if ( !isdefined( waittime ) )
    {
        waittime = 5;
    }
    
    wait waittime;
    
    if ( isdefined( self ) )
    {
        if ( isent( self ) )
        {
            self delete();
            return;
        }
        
        self freescriptable();
    }
}

// Namespace carriable
// Params 0
// Checksum 0x34ae950d, Offset: 0x336b
// Size: 0xed
function carriable_detonate_neurotoxin()
{
    var_35626ff4da0f807e = 2;
    bottom = self.origin + ( 0, 0, -96 );
    end_pos = physicstrace( self.origin, bottom );
    inairdetonation = end_pos == bottom;
    gasowner = self.owner;
    
    if ( !isplayer( gasowner ) )
    {
        gasowner = undefined;
    }
    
    detonatestate = "detonateGround";
    
    if ( inairdetonation )
    {
        detonatestate = "detonateAir";
    }
    
    fxscriptable = spawnscriptable( "br_carriable_explosion_neurotoxin", self.origin, self.angles );
    fxscriptable setscriptablepartstate( "carrible_explode_base", detonatestate );
    self radiusdamage( self.origin, 150, 250, 1, gasowner, "MOD_EXPLOSIVE" );
    thread neurotoxin_damage_loop( fxscriptable, inairdetonation, gasowner );
}

// Namespace carriable
// Params 3
// Checksum 0x2397ec6e, Offset: 0x3460
// Size: 0xa6
function neurotoxin_damage_loop( fxscriptable, inairdetonation, owner )
{
    carriabletype = self.carriabletype;
    centerpoint = self.origin;
    detonatestate = "groundLoop";
    
    if ( inairdetonation )
    {
        detonatestate = "airLoop";
    }
    
    fxscriptable setscriptablepartstate( "carrible_neurotoxin_loop", detonatestate );
    level add_neurotoxin_damage_area( centerpoint, owner );
    wait float( 30 );
    
    if ( isdefined( fxscriptable ) )
    {
        fxscriptable setscriptablepartstate( "carrible_neurotoxin_loop", "gasEnd" );
        fxscriptable thread cleanupexplosionleftovers( 5 );
    }
}

// Namespace carriable
// Params 2
// Checksum 0x21f95ff7, Offset: 0x350e
// Size: 0x9b
function add_neurotoxin_damage_area( cloudorigin, owner )
{
    if ( !isdefined( level.active_neurotoxin_clouds ) )
    {
        level.active_neurotoxin_clouds = [];
    }
    
    gascloud = spawnstruct();
    gascloud.cloudorigin = cloudorigin;
    gascloud.damageendtime = gettime() + 30000;
    gascloud.owner = owner;
    level.active_neurotoxin_clouds[ level.active_neurotoxin_clouds.size ] = gascloud;
    
    if ( level.active_neurotoxin_clouds.size > 1 )
    {
        return;
    }
    
    level thread neurotoxin_damage_monitor();
}

// Namespace carriable
// Params 0
// Checksum 0xd5997ca2, Offset: 0x35b1
// Size: 0x32e
function neurotoxin_damage_monitor()
{
    neurotoxin_gas_radius = 250;
    damagetick = 9;
    
    while ( level.active_neurotoxin_clouds.size > 0 )
    {
        var_b016174ce7fe4491 = [];
        var_ef8fc5d47f6777a0 = [];
        
        foreach ( cloud in level.active_neurotoxin_clouds )
        {
            if ( gettime() > cloud.damageendtime )
            {
                var_b016174ce7fe4491[ var_b016174ce7fe4491.size ] = cloud;
                continue;
            }
            
            /#
                sphere( cloud.cloudorigin, neurotoxin_gas_radius, ( 0, 1, 0 ), 1, 60 );
            #/
            
            players = player_utility::script_getplayersinradius( cloud.cloudorigin, neurotoxin_gas_radius );
            
            foreach ( player in players )
            {
                player.cloudref = cloud;
            }
            
            var_ef8fc5d47f6777a0 = arraycombineunique( var_ef8fc5d47f6777a0, players );
        }
        
        foreach ( player in var_ef8fc5d47f6777a0 )
        {
            if ( !isdefined( player.cloudref ) )
            {
                continue;
            }
            
            if ( player.team == player.cloudref.owner.team && player != player.cloudref.owner )
            {
                player.cloudref = undefined;
                continue;
            }
            
            if ( gasmask::hasgasmask( player ) )
            {
                player thread neurotoxin_mask_monitor();
                
                if ( isdefined( level.var_548004405d16dcf8 ) )
                {
                    player [[ level.var_548004405d16dcf8 ]]( "carriable_neurotoxin" );
                }
                else if ( !player.gasmaskequipped )
                {
                    player notify( #"toggle_gasmask" );
                }
                
                player gasmask::processdamage( damagetick );
            }
            else
            {
                player dodamage( damagetick, player.origin, player.cloudref.owner, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
                player armor::damagearmor( damagetick );
                player br_circle::tryplaycoughaudio();
            }
            
            player.cloudref = undefined;
        }
        
        if ( var_b016174ce7fe4491.size > 0 )
        {
            level.active_neurotoxin_clouds = arrayremove( level.active_neurotoxin_clouds, var_b016174ce7fe4491 );
        }
        
        wait 1;
    }
}

// Namespace carriable
// Params 0
// Checksum 0xb2214502, Offset: 0x38e7
// Size: 0xc5
function neurotoxin_mask_monitor()
{
    player = self;
    var_e90c0bd9e9e62154 = 1100;
    
    if ( !isdefined( player.inneurotoxintimestamp ) )
    {
        player.inneurotoxintimestamp = gettime();
        
        while ( !player.gasmaskequipped || gettime() < player.inneurotoxintimestamp + var_e90c0bd9e9e62154 )
        {
            wait 0.5;
        }
        
        player.inneurotoxintimestamp = undefined;
        
        if ( isdefined( level.var_7518fcc73a6d4676 ) )
        {
            player [[ level.var_7518fcc73a6d4676 ]]( "carriable_neurotoxin" );
            return;
        }
        
        if ( player.gasmaskequipped )
        {
            player notify( #"toggle_gasmask" );
        }
        
        return;
    }
    
    player.inneurotoxintimestamp = gettime();
}

/#

    // Namespace carriable
    // Params 1
    // Checksum 0xd00ca0fb, Offset: 0x39b4
    // Size: 0x1fb, Type: dev
    function function_a9b5e8237eaa4b1c( args )
    {
        level notify( #"debug_show_carriables" );
        level endon( #"debug_show_carriables" );
        
        if ( !isdefined( args ) )
        {
            return;
        }
        
        drawdist = float( args );
        
        if ( drawdist == 0 )
        {
            return;
        }
        
        drawdistsqu = drawdist * drawdist;
        scriptablepropane = getentitylessscriptablearray( "<dev string:xec>", #classname );
        scriptableneurotoxin = getentitylessscriptablearray( "<dev string:x10c>", #classname );
        allcarriables = arraycombine( scriptablepropane, scriptableneurotoxin, level.var_549c5d38afec5806 );
        
        while ( true )
        {
            foreach ( carriable in allcarriables )
            {
                var_32d70331787a7547 = distance2dsquared( carriable.origin, level.players[ 0 ].origin );
                
                if ( var_32d70331787a7547 < drawdistsqu )
                {
                    if ( var_32d70331787a7547 < 1000000 )
                    {
                        name = "<dev string:x12f>";
                        
                        if ( carriable.type == "<dev string:x137>" )
                        {
                            name = "<dev string:x14f>";
                        }
                        
                        print3d( carriable.origin + ( 0, 0, 10 ), name, ( 1, 1, 1 ), 1, 0.95, 62, 1 );
                        continue;
                    }
                    
                    print3d( carriable.origin + ( 0, 0, 0 ), "<dev string:x15a>", ( 0, 1, 0 ), 1, 1.9, 62, 1 );
                }
            }
            
            wait 1;
        }
    }

#/
