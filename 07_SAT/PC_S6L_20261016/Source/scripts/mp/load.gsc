// scripts\mp\load.gsc  (hash_7d419d1dfd062946.gscc) (size: 8055 Bytes / 0x1f77 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2c1a123 (3804340515)
// size ...... 8055 (0x1f77)
// includes .. 42  (offset: 0x1c07)
// strings ... 42  (offset: 0x1d57)
// dev strs .. 0   (offset: 0x1f77)
// exports ... 9   (offset: 0xfa7)
// cseg ...... 0x348 + 0xc5f (0xfa7)
// imports ... 96  (offset: 0x110f)
// animtree1 . 0   (offset: 0x1f77)
// animtree2 . 0   (offset: 0x1f77)
#using scripts\code\ai;
#using scripts\common\ai_devgui;
#using scripts\common\callbacks;
#using scripts\common\create_cover_nodes;
#using scripts\common\damage_tuning;
#using scripts\common\devgui;
#using scripts\common\exploder;
#using scripts\common\flags;
#using scripts\common\fx;
#using scripts\common\scriptable_door;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_spawn;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;
#using scripts\mp\anim;
#using scripts\mp\animatedmodels;
#using scripts\mp\art;
#using scripts\mp\audio;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\createfx;
#using scripts\mp\damagefeedback;
#using scripts\mp\destructables;
#using scripts\mp\destructible;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gametypes\vortex_playlist_util;
#using scripts\mp\heartbeat_cp_mp;
#using scripts\mp\hud_util;
#using scripts\mp\minefields;
#using scripts\mp\movers;
#using scripts\mp\playerlogic;
#using scripts\mp\rat_mp;
#using scripts\mp\scriptable;
#using scripts\mp\spawnlogic;
#using scripts\mp\swim_cp_mp;
#using scripts\mp\visibility_mode_mp;

#namespace load;

// Namespace load/bootstrap
// Params 0, eflags: 0x24
// Checksum 0x47e75607, Offset: 0x366
// Size: 0x10
function private event_handler[bootstrap] bootstrap()
{
    level.struct_filter = &filterstructs;
}

// Namespace load
// Params 0
// Checksum 0xa5f18f7b, Offset: 0x37e
// Size: 0x58b
function main()
{
    if ( isdefined( level._loadstarted ) )
    {
        return;
    }
    
    utility::function_e00e472b5a03f8f1();
    level._loadstarted = 1;
    level.createfx_enabled = getdvar( @"createfx", "" ) != "";
    level.players_waiting_for_callback = [];
    flags::initgameflags();
    flags::initlevelflags();
    damage_tuning::init();
    thread playerlogic::queueconnectednotify();
    thread playerlogic::initglobalautopilot();
    flags::levelflaginit( "scriptables_ready", 0 );
    scriptable::scriptable_mpglobalcallback();
    ai::function_e06b11e360a8cb9a();
    level.generic_index = 0;
    level.flag_struct = spawnstruct();
    level.flag_struct flags::assign_unique_id();
    
    if ( !isdefined( level.flag ) )
    {
        level.flag = [];
        level.flags_lock = [];
    }
    
    level.createclientfontstring_func = &hud_util::createfontstring;
    level.hudsetpoint_func = &hud_util::setpoint;
    utility::create_func_ref( "precacheMpAnim", &precachempanim );
    utility::create_func_ref( "scriptModelPlayAnim", &scriptmodelplayanim );
    utility::create_func_ref( "scriptModelClearAnim", &scriptmodelclearanim );
    utility::create_func_ref( "scriptModelPlayAnimDeltaMotionFromPos", &scriptmodelplayanimdeltamotionfrompos );
    utility::create_func_ref( "slowmo_managed_start", utility::create_empty_func_ref( "empty_func" ) );
    utility::create_func_ref( "slowmo_managed_end", utility::create_empty_func_ref( "empty_func" ) );
    
    if ( !level.createfx_enabled )
    {
        thread minefields::minefields();
        thread movers::init();
        thread destructables::init();
        level notify( #"interactive_start" );
    }
    
    game[ "thermal_vision" ] = "thermal_mp";
    
    if ( !isdefined( level.gamemodebundle ) )
    {
        level.gamemodebundle = spawnstruct();
    }
    
    visionsetnaked( "", 0 );
    player::init_visionsetnight();
    visionsetmissilecam( "missilecam" );
    visionsetthermal( game[ "thermal_vision" ] );
    visionsetwhizby( "whizby" );
    callback::callback( #"register_fullscreenfx", spawnstruct() );
    
    if ( isdefined( level.sharedfuncs[ #"fullscreenfx" ][ #"hash_967b2afe3d37405" ] ) )
    {
        var_a78c7939578579e5 = level.sharedfuncs[ #"fullscreenfx" ][ #"hash_967b2afe3d37405" ];
        self [[ var_a78c7939578579e5 ]]();
    }
    
    lanterns = getentarray( "lantern_glowFX_origin", #targetname );
    
    for ( i = 0; i < lanterns.size ; i++ )
    {
        lanterns[ i ] thread lanterns();
    }
    
    audio::init_audio();
    art::main();
    level thread swim_cp_mp::main();
    level thread heartbeat_cp_mp::main();
    visibility_mode::main( &visibility_mode_mp::function_fb0d6f33cb09e933 );
    thread fx::initfx();
    exploder::setupexploders();
    anim_mp::init();
    
    if ( level.createfx_enabled )
    {
        spawnlogic::setmapcenterfordev();
        createfx::createfx();
    }
    
    /#
        level thread create_cover_nodes::create_cover_node_init();
    #/
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        dev_mp::reflectionprobe_hide_hp();
        dev_mp::reflectionprobe_hide_front();
        spawnlogic::setmapcenterfordev();
        level waittill( #"eternity" );
    }
    
    level thread destructible::rockable_cars_init();
    
    for ( p = 0; p < 6 ; p++ )
    {
        switch ( p )
        {
            case 0:
                triggertype = "trigger_multiple";
                break;
            case 1:
                triggertype = "trigger_once";
                break;
            case 2:
                triggertype = "trigger_use";
                break;
            case 3:
                triggertype = "trigger_radius";
                break;
            case 4:
                triggertype = "trigger_lookat";
                break;
            default:
                assert( p == 5 );
                triggertype = "trigger_damage";
                break;
        }
        
        triggers = getentarray( triggertype, #classname );
        
        for ( i = 0; i < triggers.size ; i++ )
        {
            if ( isdefined( triggers[ i ].script_prefab_exploder ) )
            {
                triggers[ i ].script_exploder = triggers[ i ].script_prefab_exploder;
            }
            
            if ( isdefined( triggers[ i ].script_exploder ) )
            {
                level thread exploder_load( triggers[ i ] );
            }
        }
    }
    
    thread animatedmodels::main();
    
    /#
        devgui::init_devgui();
        level thread debug_utility::function_ad307e20cea64956();
    #/
    
    utility::create_func_ref( "damagefeedback", &damagefeedback::updatedamagefeedback );
    level.laseron_func = &laseron;
    level.laseroff_func = &laseroff;
    level.connectpathsfunction = &connectpaths;
    level.disconnectpathsfunction = &disconnectpaths;
    level.fnbuildweapon = &weapon::buildweapon;
    level.fngetweaponrootname = &weapon::getweaponrootname;
    setdvar( @"ui_showinfo", 1 );
    setdvar( @"ui_showminimap", 1 );
    level thread setupdestructiblekillcaments();
    level.fauxvehiclecount = 0;
    level thread scriptable_door::system_init();
    
    /#
        level thread dvars::function_f0fc15052d9d9921();
    #/
    
    utility::spawncorpsehider();
    rat_mp::init();
    utility::fixplacedweapons();
    
    if ( getdvarint( @"vortex_playlist", 0 ) != 0 )
    {
        level thread vortex_playlist_util::vortex_playlist_init();
    }
    
    if ( game_utility_mp::function_57f7c589ea92d695() && getdvarint( @"hash_79900699601c9314", 1 ) )
    {
        level callback::add( #"player_spawned", &function_358a3a6855b77741 );
    }
    
    utility::flag_set( "load_main_completed" );
    
    /#
        ai_devgui::init_ai_devgui();
    #/
}

// Namespace load
// Params 1
// Checksum 0x82c97042, Offset: 0x911
// Size: 0x1e
function function_358a3a6855b77741( params )
{
    val::set( "snipersOnly", "melee", 0 );
}

// Namespace load
// Params 1
// Checksum 0xf92137fd, Offset: 0x937
// Size: 0x95
function exploder_load( trigger )
{
    level endon( "killexplodertridgers" + trigger.script_exploder );
    trigger waittill( #"trigger" );
    
    if ( randomfloat( 1 ) > trigger.script_chance )
    {
        if ( isdefined( trigger.script_delay ) )
        {
            wait trigger.script_delay;
        }
        else
        {
            wait 4;
        }
        
        level thread exploder_load( trigger );
        return;
    }
    
    utility::exploder( trigger.script_exploder );
    level notify( "killexplodertridgers" + trigger.script_exploder );
}

// Namespace load
// Params 0
// Checksum 0x6f6dd043, Offset: 0x9d4
// Size: 0x5e
function lanterns()
{
    if ( !isdefined( level._effect[ "lantern_light" ] ) )
    {
        level._effect[ "lantern_light" ] = loadfxasset( "vfx_props_glow_latern" );
    }
    
    fx::loopfx( "lantern_light", self.origin, 0.3, self.origin + ( 0, 0, 1 ) );
}

// Namespace load
// Params 0
// Checksum 0xc17fb153, Offset: 0xa3a
// Size: 0x36d
function setupdestructiblekillcaments()
{
    foreach ( dest in getentarray( "scriptable_destructible_barrel", #targetname ) )
    {
        bulletstart = dest.origin + ( 0, 0, 5 );
        bulletend = dest.origin + ( 0, 0, 128 );
        result = trace::_bullet_trace( bulletstart, bulletend, 0, dest );
        dest.killcament = spawn( "script_model", result[ "position" ] );
        dest.killcament.targetname = "killCamEnt_explodable_barrel";
        dest.killcament setscriptmoverkillcam( "explosive" );
        dest thread deletedestructiblekillcament();
    }
    
    foreach ( dest in getentarray( "scriptable_accessory_fire_extinguisher", #classname ) )
    {
        bulletstart = dest.origin + ( 0, 0, 5 );
        bulletend = dest.origin + ( 0, 0, 128 );
        result = trace::_bullet_trace( bulletstart, bulletend, 0, dest );
        dest setscriptmoverkillcam( "offset explosive", int( ( result[ "position" ] - dest.origin )[ 2 ] ), 0 );
    }
    
    utility::flag_wait( "rockable_cars_init" );
    
    foreach ( car in level.rockablecars.cars )
    {
        bulletstart = car.origin + ( 0, 0, 5 );
        bulletend = car.origin + ( 0, 0, 128 );
        result = trace::_bullet_trace( bulletstart, bulletend, 0, car );
        car setscriptmoverkillcam( "offset explosive", int( ( result[ "position" ] - car.origin )[ 2 ] ), 0 );
    }
    
    waitframe();
    
    foreach ( car in level.rockablecars.cars )
    {
        car willneverchange();
    }
}

// Namespace load
// Params 0
// Checksum 0x3aeaa609, Offset: 0xdaf
// Size: 0x4d
function deletedestructiblekillcament()
{
    level endon( #"game_ended" );
    killcament = self.killcament;
    killcament endon( #"death" );
    self waittill( #"death" );
    wait 10;
    
    if ( isdefined( killcament ) )
    {
        killcament delete();
    }
}

// Namespace load
// Params 1
// Checksum 0xc0224533, Offset: 0xe04
// Size: 0x1a2, Type: bool
function filterstructs( struct )
{
    if ( isdefined( struct.script_gameobjectname ) )
    {
        var_c65f4b15333d82d8 = struct.script_gameobjectname;
        invertlogic = 0;
        
        if ( getsubstr( var_c65f4b15333d82d8, 0, 1 ) == "!" )
        {
            var_c65f4b15333d82d8 = getsubstr( var_c65f4b15333d82d8, 1 );
            invertlogic = 1;
        }
        
        if ( invertlogic )
        {
            if ( game_utility_mp::testgamemodestringlist( struct.script_gameobjectname, game_utility::getgametype() ) )
            {
                return false;
            }
        }
        else if ( !game_utility_mp::testgamemodestringlist( struct.script_gameobjectname, game_utility::getgametype() ) )
        {
            if ( game_utility::getgametype() == "brtdm" )
            {
                if ( struct vehicle_spawn::is_vehicle_spawn_struct() )
                {
                    return true;
                }
            }
            else if ( level.isgroundwarsiege || level.var_bbafbc222fd80343 || level.var_20c310324a5716ad || level.var_94f7e9904f6d47e4 )
            {
                if ( issubstr( struct.script_gameobjectname, "arm" ) )
                {
                    return true;
                }
            }
            else if ( game_utility::getgametype() == "mini" )
            {
                if ( issubstr( struct.script_gameobjectname, "br" ) )
                {
                    return true;
                }
            }
            else if ( issubstr( struct.script_gameobjectname, "zm_" ) )
            {
                return true;
            }
            
            return false;
        }
    }
    
    if ( isdefined( struct.script_noteworthy ) && issubstr( struct.script_noteworthy, "locale_" ) )
    {
        if ( isdefined( game_utility::getlocaleid() ) && struct.script_noteworthy != level.localeid )
        {
            return false;
        }
    }
    
    return true;
}

