// scripts\common\vehicle_aianim.gsc  (hash_1da5ee063934c32c.gscc) (size: 32063 Bytes / 0x7d3f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x92bff0b5 (2462052533)
// size ...... 32063 (0x7d3f)
// includes .. 12  (offset: 0x7827)
// strings ... 59  (offset: 0x7887)
// dev strs .. 24  (offset: 0x7c07)
// exports ... 70  (offset: 0x50a3)
// cseg ...... 0x3fe + 0x4ca5 (0x50a3)
// imports ... 228 (offset: 0x5b93)
// animtree1 . 1   (offset: 0x7d2f)
// animtree2 . 0   (offset: 0x7d3f)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\vehicle\vehicle_common;

#namespace vehicle_aianim;

// Namespace vehicle_aianim
// Params 3
// Checksum 0xb7d804d2, Offset: 0x41c
// Size: 0x402
function guy_enter( guy, var_12adb1f13b90f22f, var_a5a3e93973f5d241 = 1 )
{
    guy endon( #"death_or_disconnect" );
    assert( !isspawner( self ), "<dev string:x24>" );
    assert( !isdefined( guy.ridingvehicle ), "<dev string:x47>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.vehicletype ) )
    {
        return;
    }
    
    classname = vehicle_code::get_vehicle_classname();
    vehicleanim = level.vehicle.templates.aianims[ classname ];
    pos = set_pos( guy, vehicleanim );
    
    if ( !isdefined( pos ) )
    {
        return;
    }
    
    if ( pos == 0 )
    {
        guy.drivingvehicle = 1;
    }
    
    animpos = anim_pos( self, pos );
    self.usedpositions[ pos ] = 1;
    guy.vehicle_position = pos;
    guy.vehicle_idling = 0;
    guy.ridingvehicle = self;
    guy.orghealth = guy.health;
    guy.vehicle_idle = animpos.idle;
    guy.vehicle_standattack = animpos.standattack;
    guy.standing = 0;
    guy.allowdeath = 1;
    
    if ( !isdefined( guy.magic_bullet_shield ) && vehicle_allows_rider_death() )
    {
        guy.allowdeath = !isdefined( guy.script_allowdeath ) || guy.script_allowdeath;
    }
    
    if ( !isdefined( guy.classname ) )
    {
        return;
    }
    
    if ( guy.classname == "script_model" )
    {
        if ( isdefined( animpos.death ) && guy.allowdeath && ( !isdefined( guy.script_allowdeath ) || guy.script_allowdeath ) )
        {
            thread guy_death( guy, animpos );
        }
    }
    
    self.riders[ self.riders.size ] = guy;
    vehicle_occupancy::update_occupancy( self );
    
    if ( guy.classname != "script_model" && ai::spawn_failed( guy ) )
    {
        return;
    }
    
    org = self gettagorigin( animpos.sittag );
    angles = self gettagangles( animpos.sittag );
    
    if ( guy.classname != "script_model" && !guy vehicle_common::hasvehicle() )
    {
        chosenpos = vehicle_getinstart( pos );
        guy vehicle_common::entervehicle( self, var_a5a3e93973f5d241, chosenpos, animpos );
    }
    
    if ( isai( guy ) )
    {
        if ( var_a5a3e93973f5d241 )
        {
            guy forceteleport( org, angles );
        }
        
        if ( isdefined( animpos.bhasgunwhileriding ) && !animpos.bhasgunwhileriding )
        {
            guy ai::gun_remove();
        }
        
        if ( guy_should_man_turret( animpos ) )
        {
            thread guy_man_turret( guy, pos, var_12adb1f13b90f22f );
        }
    }
    else
    {
        if ( isdefined( animpos.bhasgunwhileriding ) && !animpos.bhasgunwhileriding )
        {
            detach_models_with_substr( guy, "weapon_" );
        }
        
        guy.origin = org;
        guy.angles = angles;
    }
    
    if ( pos == 0 )
    {
        self.driver = guy;
        thread driverdead( guy );
    }
    
    self notify( #"guy_entered", guy, pos );
    guy notify( #"loaded" );
    utility::ent_flag_clear( "unloaded" );
    thread guy_handle( guy, pos );
    
    if ( isdefined( animpos.rider_func ) )
    {
        guy [[ animpos.rider_func ]]();
        return;
    }
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xed48d5c1, Offset: 0x826
// Size: 0x1b
function vehicle_allows_driver_death()
{
    if ( !isdefined( self.script_allow_driver_death ) )
    {
        return 0;
    }
    
    return self.script_allow_driver_death;
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xec0074f, Offset: 0x84a
// Size: 0x1c
function vehicle_allows_rider_death()
{
    if ( !isdefined( self.script_allow_rider_deaths ) )
    {
        return 1;
    }
    
    return self.script_allow_rider_deaths;
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0xba3b3189, Offset: 0x86f
// Size: 0x39, Type: bool
function guy_should_man_turret( animpos )
{
    if ( !isdefined( animpos.mgturret ) )
    {
        return false;
    }
    
    if ( !isdefined( self.script_nomg ) )
    {
        return true;
    }
    
    return !self.script_nomg;
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0x2171605f, Offset: 0x8b1
// Size: 0x179
function handle_attached_guys()
{
    classname = vehicle_code::get_vehicle_classname();
    self.attachedguys = [];
    
    if ( !( isdefined( level.vehicle.templates.aianims ) && isdefined( level.vehicle.templates.aianims[ classname ] ) ) )
    {
        return;
    }
    
    maxpos = level.vehicle.templates.aianims[ classname ].size;
    
    if ( self.script_noteworthy == "ai_wait_go" )
    {
        thread ai_wait_go();
    }
    
    self.runningtovehicle = [];
    self.usedpositions = [];
    self.var_2c1b14ee4b7cd97c = [];
    self.getinorgs = [];
    self.delayer = 0;
    vehicleanim = level.vehicle.templates.aianims[ classname ];
    
    for ( i = 0; i < maxpos ; i++ )
    {
        self.usedpositions[ i ] = 0;
        self.var_2c1b14ee4b7cd97c[ i ] = 0;
        
        if ( isdefined( vehicleanim[ i ].bisgunner ) && self.script_nomg && vehicleanim[ i ].bisgunner )
        {
            self.usedpositions[ i ] = 1;
        }
    }
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x67d5696f, Offset: 0xa32
// Size: 0x17
function load_ai_goddriver( array )
{
    load_ai( array, 1 );
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x895265fe, Offset: 0xa51
// Size: 0xe8
function guy_death( guy, animpos )
{
    waittillframeend();
    assert( !isai( guy ) );
    guy setcandamage( 1 );
    guy endon( #"death" );
    guy.allowdeath = 0;
    guy.health = 10150;
    
    if ( isdefined( guy.script_startinghealth ) )
    {
        guy.health += guy.script_startinghealth;
    }
    
    guy endon( #"jumping_out" );
    
    if ( guy.magic_bullet_shield )
    {
        while ( guy.magic_bullet_shield )
        {
            wait 0.05;
        }
    }
    
    while ( guy.health > 10000 )
    {
        guy waittill( #"damage" );
    }
    
    thread guy_deathimate_me( guy, animpos );
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x6fa0ce7c, Offset: 0xb41
// Size: 0xc6
function guy_deathimate_me( guy, animpos )
{
    guy = convert_guy_to_drone( guy );
    detach_models_with_substr( guy, "weapon_" );
    guy linkto( self );
    guy notsolid();
    guy setanim( animpos.death );
    
    if ( isai( guy ) )
    {
        guy utility::script_func( "anim_dropallaiweapons" );
    }
    else
    {
        detach_models_with_substr( guy, "weapon_" );
    }
    
    if ( isdefined( animpos.death_delayed_ragdoll ) )
    {
        guy unlink();
        
        if ( isdefined( guy.fnpreragdoll ) )
        {
            guy [[ guy.fnpreragdoll ]]();
        }
        
        guy startragdoll();
        wait animpos.death_delayed_ragdoll;
        guy delete();
        return;
    }
}

// Namespace vehicle_aianim
// Params 4
// Checksum 0x6b29739f, Offset: 0xc0f
// Size: 0x9c
function load_ai( array, bgoddriver, group, spawninvehicle )
{
    self endon( #"death" );
    assert( self.code_classname == "<dev string:x73>" );
    
    if ( array.size )
    {
        if ( !isdefined( bgoddriver ) )
        {
            bgoddriver = 0;
        }
        
        utility::ent_flag_clear( "unloaded" );
        utility::ent_flag_clear( "loaded" );
        utility::array_levelthread( array, &get_in_vehicle, bgoddriver, group, spawninvehicle );
        utility::array_wait( array, "loaded" );
    }
    
    utility::ent_flag_set( "loaded" );
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x39a53e3c, Offset: 0xcb3
// Size: 0x45, Type: bool
function is_rider( guy )
{
    for ( i = 0; i < self.riders.size ; i++ )
    {
        if ( self.riders[ i ] == guy )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim
// Params 4
// Checksum 0x4c7d819f, Offset: 0xd01
// Size: 0x5f
function get_in_vehicle( guy, bgoddriver, group, spawninvehicle )
{
    if ( is_rider( guy ) )
    {
        return;
    }
    
    if ( !handle_detached_guys_check() )
    {
        return;
    }
    
    assert( isalive( guy ), "<dev string:x82>" );
    guy_runtovehicle( guy, self, bgoddriver, group, spawninvehicle );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xd93a6946, Offset: 0xd68
// Size: 0x70
function handle_detached_guys_check()
{
    if ( vehicle_hasavailablespots() )
    {
        return 1;
    }
    
    if ( !utility::issp() )
    {
        classname = self.classname_mp;
    }
    else
    {
        classname = self.class;
    }
    
    assertmsg( "<dev string:xdc>" + level.vehicle.templates.aianims[ classname ].size + "<dev string:x109>" );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0x6efd93c6, Offset: 0xde0
// Size: 0x3d
function vehicle_hasavailablespots()
{
    if ( level.vehicle.templates.aianims[ vehicle_code::get_vehicle_classname() ].size - self.runningtovehicle.size )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_aianim
// Params 2, eflags: 0x4
// Checksum 0xa9f8f43d, Offset: 0xe25
// Size: 0x8a
function private guy_runtovehicle_loaded( guy, vehicle )
{
    vehicle endon( #"death" );
    vehicle endon( #"stop_loading" );
    
    if ( !guy vehicle_common::waitforentervehicle() && isdefined( guy.forced_startingposition ) )
    {
        vehicle.usedpositions[ guy.forced_startingposition ] = 0;
    }
    
    vehicle.runningtovehicle = arrayremove( vehicle.runningtovehicle, guy );
    vehicle_loaded_if_full( vehicle );
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x15d4aae0, Offset: 0xeb7
// Size: 0x94
function vehicle_loaded_if_full( vehicle )
{
    if ( isdefined( vehicle.vehicletype ) && isdefined( vehicle.vehicle_loaded_notify_size ) )
    {
        if ( vehicle.riders.size == vehicle.vehicle_loaded_notify_size )
        {
            vehicle utility::ent_flag_set( "loaded" );
        }
        
        return;
    }
    
    if ( !vehicle.runningtovehicle.size && vehicle.riders.size )
    {
        if ( vehicle.usedpositions[ 0 ] )
        {
            vehicle utility::ent_flag_set( "loaded" );
        }
    }
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x1e831c16, Offset: 0xf53
// Size: 0x26
function remove_magic_bullet_shield_from_guy_on_unload_or_death( guy )
{
    utility::waittill_any( "unload", "death" );
    guy ai::stop_magic_bullet_shield();
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0xb2773907, Offset: 0xf81
// Size: 0xa5
function function_c6605f39022b3372( guy )
{
    if ( !isdefined( guy.script_startingposition ) )
    {
        return;
    }
    
    vehicleanim = level.vehicle.templates.aianims[ vehicle_code::get_vehicle_classname() ];
    
    if ( !isdefined( vehicleanim ) )
    {
        return;
    }
    
    if ( self.usedpositions[ guy.script_startingposition ] || !vehicleanim[ guy.script_startingposition ] || vehicleanim[ guy.script_startingposition ].var_14f441f730dc229d )
    {
        guy.script_startingposition = undefined;
    }
}

// Namespace vehicle_aianim
// Params 3
// Checksum 0x53e5fba2, Offset: 0x102e
// Size: 0xed
function choose_vehicle_position( guy, vehiclepositions, bgoddriver = 0 )
{
    guy endon( #"stop_loading" );
    self endon( #"stop_loading" );
    
    if ( isdefined( guy.script_startingposition ) )
    {
        chosenorg = vehicle_getinstart( guy.script_startingposition );
    }
    else if ( !self.usedpositions[ 0 ] )
    {
        chosenorg = vehicle_getinstart( 0 );
        
        if ( bgoddriver )
        {
            assert( !isdefined( guy.magic_bullet_shield ), "<dev string:x10c>" );
            guy thread ai::magic_bullet_shield();
            thread remove_magic_bullet_shield_from_guy_on_unload_or_death( guy );
        }
    }
    else if ( vehiclepositions.availablepositions.size )
    {
        chosenorg = function_47c86977a18df38b( vehiclepositions.availablepositions, guy.origin );
    }
    else
    {
        chosenorg = undefined;
    }
    
    return chosenorg;
}

// Namespace vehicle_aianim
// Params 5
// Checksum 0xcb4638f1, Offset: 0x1124
// Size: 0x53a
function guy_runtovehicle( guy, vehicle, bgoddriver = 0, group, spawninvehicle = 0 )
{
    guy endon( #"stop_loading" );
    vehicle endon( #"stop_loading" );
    var_12adb1f13b90f22f = 1;
    vehicleanim = level.vehicle.templates.aianims[ vehicle vehicle_code::get_vehicle_classname() ];
    
    if ( isdefined( vehicle.runtovehicleoverride ) )
    {
        vehicle thread [[ vehicle.runtovehicleoverride ]]( guy );
        return;
    }
    
    vehicle endon( #"death" );
    guy endon( #"death" );
    vehicle.runningtovehicle[ vehicle.runningtovehicle.size ] = guy;
    thread guy_runtovehicle_loaded( guy, vehicle );
    availablepositions = [];
    chosenorg = undefined;
    origin = 0;
    
    if ( !isdefined( guy.get_in_moving_vehicle ) )
    {
        while ( vehicle vehicle_getspeed() > 1 )
        {
            wait 0.05;
        }
    }
    
    positions = vehicle get_availablepositions( group );
    
    if ( !positions.availablepositions.size && positions.nonanimatedpositions.size )
    {
        guy notify( #"enteredvehicle" );
        vehicle guy_enter( guy, var_12adb1f13b90f22f );
        return;
    }
    
    chosenorg = choose_vehicle_position( guy, positions, bgoddriver );
    
    if ( !isdefined( chosenorg ) )
    {
        return;
    }
    
    origin = chosenorg.origin;
    angles = chosenorg.angles;
    guy.forced_startingposition = chosenorg.vehicle_position;
    vehicle.usedpositions[ chosenorg.vehicle_position ] = 1;
    
    if ( spawninvehicle )
    {
        guy notify( #"enteredvehicle" );
        vehicle guy_enter( guy, var_12adb1f13b90f22f );
        return;
    }
    
    guy vehicle_common::requestentervehicle( self, 0, chosenorg, anim_pos( self, chosenorg.vehicle_position ) );
    guy vehicle_common::waitforarrivedatvehicle();
    animpos = anim_pos( vehicle, chosenorg.vehicle_position );
    guy.allowdeath = 0;
    animpos = vehicleanim[ chosenorg.vehicle_position ];
    
    if ( isdefined( chosenorg ) )
    {
        if ( isdefined( animpos.vehicle_getinanim_combat ) && ( guy isincombat() || !guy.stealth_enabled ) )
        {
            no_clear_anim = isdefined( guy.no_vehicle_getoutanim );
            
            if ( !no_clear_anim && !isagent( guy ) )
            {
                if ( isdefined( animpos.vehicle_getoutanim ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim, 0 );
                }
                
                if ( isdefined( animpos.vehicle_getoutanim_combat ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim_combat, 0 );
                }
                
                if ( isdefined( animpos.vehicle_getoutanim_combat_run ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim_combat_run, 0 );
                }
            }
            
            vehicle = vehicle getanimatemodel();
            vehicle thread setanimrestart_once( animpos.vehicle_getinanim_combat, animpos.vehicle_getinanim_clear );
            vehicle thread notetrack::start_notetrack_wait( vehicle, "vehicle_anim_flag", undefined, undefined, animpos.vehicle_getinanim_combat );
        }
        else if ( isdefined( animpos.vehicle_getinanim ) )
        {
            no_clear_anim = isdefined( guy.no_vehicle_getoutanim );
            
            if ( !no_clear_anim && !isagent( guy ) )
            {
                if ( isdefined( animpos.vehicle_getoutanim ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim, 0 );
                }
                
                if ( isdefined( animpos.vehicle_getoutanim_combat ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim_combat, 0 );
                }
                
                if ( isdefined( animpos.vehicle_getoutanim_combat_run ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim_combat_run, 0 );
                }
            }
            
            vehicle = vehicle getanimatemodel();
            vehicle thread setanimrestart_once( animpos.vehicle_getinanim, animpos.vehicle_getinanim_clear );
            vehicle thread notetrack::start_notetrack_wait( vehicle, "vehicle_anim_flag", undefined, undefined, animpos.vehicle_getinanim );
        }
    }
    
    if ( isdefined( animpos.vehicle_getinsoundtag ) )
    {
        origin = vehicle gettagorigin( animpos.vehicle_getinsoundtag );
    }
    else
    {
        origin = vehicle.origin;
    }
    
    if ( isdefined( animpos.vehicle_getinsound ) )
    {
        playsoundatpos( origin, animpos.vehicle_getinsound );
    }
    
    getintags = undefined;
    getinthreads = undefined;
    
    if ( isdefined( animpos.getin_enteredvehicletrack ) )
    {
        getintags = [];
        getintags[ 0 ] = animpos.getin_enteredvehicletrack;
        getinthreads = [];
        getinthreads[ 0 ] = &entered_vehicle_notify;
        vehicle link_to_sittag( guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend );
    }
    
    guy vehicle_common::waitforentervehicle();
    guy notify( #"enteredvehicle" );
    vehicle guy_enter( guy, var_12adb1f13b90f22f );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0x37efb090, Offset: 0x1666
// Size: 0xe
function entered_vehicle_notify()
{
    self notify( #"enteredvehicle" );
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x1bb76b77, Offset: 0x167c
// Size: 0xc5
function driverdead( guy )
{
    if ( vehicle::ishelicopter() )
    {
        return;
    }
    
    self.driver = guy;
    self endon( #"death" );
    guy endon( #"jumping_out" );
    guy waittill( #"death" );
    
    if ( getdvarint( @"hash_bd29c0db2cf41967", 0 ) == 1 )
    {
        return;
    }
    
    if ( isdefined( self.vehicle_keeps_going_after_driver_dies ) )
    {
        return;
    }
    
    self notify( #"hash_170190d0a5ebf22f" );
    self.deaddriver = 1;
    
    if ( self.hasstarted )
    {
        vehicle_paths::_vehicle_stop_named( "driver_dead", 20, 20 );
        
        while ( self vehicle_getspeed() > 0 )
        {
            wait 0.15;
        }
    }
    
    if ( !self.donotunloadondriverdeath )
    {
        vehicle::vehicle_unload();
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x5e4de6da, Offset: 0x1749
// Size: 0xfe
function guy_becomes_real_ai( guy, pos )
{
    if ( isai( guy ) )
    {
        return guy;
    }
    
    if ( guy.drone_delete_on_unload )
    {
        guy delete();
        return;
    }
    
    guy = utility::script_func( "spawner_makerealai", guy );
    
    if ( utility::issp() )
    {
        classname = self.classname;
    }
    else
    {
        classname = self.classname_mp;
    }
    
    maxpos = level.vehicle.templates.aianims[ classname ].size;
    animpos = anim_pos( self, pos );
    link_to_sittag( guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend );
    guy.vehicle_idle = animpos.idle;
    return guy;
}

// Namespace vehicle_aianim
// Params 5
// Checksum 0xc8f790e9, Offset: 0x1850
// Size: 0x90
function link_to_sittag( guy, tag, origin_offset = ( 0, 0, 0 ), angles_offset = ( 0, 0, 0 ), linktoblend = 0 )
{
    if ( linktoblend && !isdefined( guy.script_drone ) )
    {
        guy linktoblendtotag( self, tag, 0 );
        return;
    }
    
    guy linkto( self, tag, origin_offset, angles_offset );
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x3864eb92, Offset: 0x18e8
// Size: 0x69
function anim_pos( vehicle, pos )
{
    assert( isdefined( pos ), "<dev string:x186>" + vehicle vehicle_code::get_vehicle_classname() + "<dev string:x197>" );
    
    if ( !isdefined( pos ) )
    {
        return spawnstruct();
    }
    
    return level.vehicle.templates.aianims[ vehicle vehicle_code::get_vehicle_classname() ][ pos ];
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0x8f5d2be6, Offset: 0x195a
// Size: 0x77
function setup_aianimthreads()
{
    if ( !isdefined( level.vehicle.aianimthread ) )
    {
        level.vehicle.aianimthread = [];
    }
    
    if ( !isdefined( level.vehicle.aianimcheck ) )
    {
        level.vehicle.aianimcheck = [];
    }
    
    level.vehicle.aianimthread[ "unload" ] = &guy_unload;
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x210f1511, Offset: 0x19d9
// Size: 0x2d
function guy_handle( guy, pos )
{
    guy.vehicle_idling = 1;
    thread vehicle_ai::handle_rider_death( guy, pos );
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x9d89b689, Offset: 0x1a0e
// Size: 0x87
function guy_unload_watcher( guy )
{
    self endon( #"death" );
    wait 50;
    
    if ( isdefined( guy ) && arraycontains( self.unloadque, guy ) )
    {
        self.unloadque = arrayremove( self.unloadque, guy );
        
        if ( !self.unloadque.size )
        {
            utility::ent_flag_set( "unloaded" );
            self.unload_group = "default";
            self function_3a59b1430ed51a61();
        }
        
        guy notify( #"jumpedout" );
    }
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0xe44a91ea, Offset: 0x1a9d
// Size: 0x88
function guy_unload_que( guy )
{
    self endon( #"death" );
    self.unloadque[ self.unloadque.size ] = guy;
    guy utility::waittill_any( "death", "jumpedout" );
    self.unloadque = arrayremove( self.unloadque, guy );
    
    if ( !self.unloadque.size )
    {
        utility::ent_flag_set( "unloaded" );
        self.unload_group = "default";
        self function_3a59b1430ed51a61();
    }
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0xefc466f4, Offset: 0x1b2d
// Size: 0xc4, Type: bool
function riders_unloadable( unload_group )
{
    if ( !isdefined( self.riders ) )
    {
        return false;
    }
    
    if ( !self.riders.size )
    {
        return false;
    }
    
    for ( i = 0; i < self.riders.size ; i++ )
    {
        if ( !isalive( self.riders[ i ] ) && !isdefined( self.riders[ i ].isvehicle ) )
        {
            continue;
        }
        
        if ( !isdefined( self.riders[ i ].vehicle_position ) )
        {
            continue;
        }
        
        if ( check_unloadgroup( self.riders[ i ].vehicle_position, unload_group ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x37b62d7d, Offset: 0x1bfa
// Size: 0xf7
function function_b7200b981d41e212( unload_group )
{
    if ( !isdefined( self.riders ) )
    {
        return [];
    }
    
    if ( !self.riders.size )
    {
        return [];
    }
    
    group = [];
    
    foreach ( rider in self.riders )
    {
        if ( !isalive( rider ) && !isdefined( rider.isvehicle ) )
        {
            continue;
        }
        
        if ( !isdefined( rider.vehicle_position ) )
        {
            continue;
        }
        
        if ( check_unloadgroup( rider.vehicle_position, unload_group ) )
        {
            group[ group.size ] = rider;
        }
    }
    
    return group;
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xbf61d000, Offset: 0x1cfa
// Size: 0x10a
function get_unload_group()
{
    group = [];
    unloadgroups = [];
    unload_group = "default";
    
    if ( isdefined( self.unload_group ) )
    {
        unload_group = self.unload_group;
    }
    
    unloadgroups = level.vehicle.templates.unloadgroups[ vehicle_code::get_vehicle_classname() ][ unload_group ];
    
    if ( !isdefined( unloadgroups ) )
    {
        unloadgroups = level.vehicle.templates.unloadgroups[ vehicle_code::get_vehicle_classname() ][ "default" ];
    }
    
    foreach ( pos in unloadgroups )
    {
        group[ pos ] = pos;
    }
    
    return group;
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x76301b5b, Offset: 0x1e0d
// Size: 0x125, Type: bool
function check_unloadgroup( pos, unload_group = self.unload_group )
{
    classname = vehicle_code::get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.unloadgroups[ classname ] ) )
    {
        return true;
    }
    
    if ( !isdefined( level.vehicle.templates.unloadgroups[ classname ][ unload_group ] ) )
    {
        /#
            if ( isdefined( self.currentnode ) )
            {
                println( "<dev string:x1b0>" + self.currentnode.origin + "<dev string:x1d9>" + unload_group + "<dev string:x1e9>" );
            }
        #/
        
        println( "<dev string:x1ed>" );
        return true;
    }
    
    group = level.vehicle.templates.unloadgroups[ classname ][ unload_group ];
    
    for ( i = 0; i < group.size ; i++ )
    {
        if ( pos == group[ i ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim
// Params 5
// Checksum 0x47604109, Offset: 0x1f3b
// Size: 0x3bc
function getoutrig_model( animpos, model, tag, animation, var_3fbf3458dbd0f99e )
{
    self endon( #"death" );
    classname = vehicle_code::get_vehicle_classname();
    thread utility::delete_on_death( model );
    origin = self gettagorigin( tag );
    angles = self gettagangles( tag );
    xanim = level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].idleanim;
    startorg = getstartorigin( origin, angles, xanim );
    startangles = getstartangles( origin, angles, xanim );
    startangles = self.angles;
    tagorigin = model gettagorigin( "j_rope_1", 1 );
    
    if ( !isdefined( tagorigin ) )
    {
        tagorigin = self.origin;
    }
    
    tagoffset = tagorigin - self.origin;
    
    if ( var_3fbf3458dbd0f99e )
    {
        model.origin = startorg;
        model.angles = startangles;
        thread utility::script_func( "fastrope_anim", model, xanim, "getoutrigidle" );
        utility::ent_flag_wait( "unloaded" );
    }
    
    origin = self gettagorigin( tag );
    angles = self gettagangles( tag );
    
    if ( vehicle_ai::has_anim_intro() )
    {
        if ( riders_unloadable( self.currentnode.script_unload ) )
        {
            ropeorigin = origin;
            thread getoutrig_abort( model, undefined, animation, ropeorigin );
            
            if ( !vehicle_code::vehicle_iscrashing() )
            {
                model unlink();
                model.origin = origin;
                model.angles = angles;
                thread utility::script_func( "fastrope_anim", model, animation, "getoutrigfall" );
            }
        }
    }
    else
    {
        moveangles = self.angles - startangles;
        moveangles = ( angleclamp( moveangles[ 0 ] ), angleclamp( moveangles[ 1 ] ), angleclamp( moveangles[ 2 ] ) );
        traceorigin = rotatevector( tagoffset, moveangles ) + self.origin;
        results = trace::ray_trace( traceorigin, traceorigin - ( 0, 0, 1000 ), self, trace::create_world_contents() );
        ropeheight = traceorigin[ 2 ] - 400;
        
        if ( isdefined( results[ "position" ] ) )
        {
            ropeheight = results[ "position" ][ 2 ];
        }
        
        ropeorigin = ( origin[ 0 ], origin[ 1 ], ropeheight );
        
        if ( self.var_24929b195372afe6 )
        {
            ropeorigin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] );
        }
        
        if ( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].dropusestraceorigin )
        {
            ropeorigin = ( traceorigin[ 0 ], traceorigin[ 1 ], ropeheight );
        }
        
        /#
            if ( getdvarint( @"hash_c318492e4a168bb3", 0 ) == 1 )
            {
                line( traceorigin, traceorigin - ( 0, 0, 1000 ), ( 0, 0, 1 ), 1, 0, 400 );
                sphere( ropeorigin, 4, ( 0, 1, 0 ), 0, 400 );
            }
        #/
        
        thread getoutrig_abort( model, undefined, animation, ropeorigin );
        
        if ( !vehicle_code::vehicle_iscrashing() )
        {
            model unlink();
            model.origin = ropeorigin;
            thread utility::script_func( "fastrope_anim", model, animation, "getoutrigfall" );
        }
    }
    
    self.fastroperig[ animpos.fastroperig ] = undefined;
    wait 10;
    model delete();
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xdd8c6262, Offset: 0x22ff
// Size: 0x4a
function getoutrig_disable_abort_notify_after_riders_out()
{
    wait 0.05;
    
    while ( isalive( self ) && self.unloadque.size > 2 )
    {
        wait 0.05;
    }
    
    if ( !isalive( self ) || vehicle_code::vehicle_iscrashing() )
    {
        return;
    }
    
    self notify( #"getoutrig_disable_abort" );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xff7d7a9c, Offset: 0x2351
// Size: 0xe8
function getoutrig_abort_while_deploying()
{
    self notify( #"hash_1367e95820d399df" );
    self endon( #"hash_1367e95820d399df" );
    self endon( #"end_getoutrig_abort_while_deploying" );
    self endon( #"death" );
    
    while ( !vehicle_code::vehicle_iscrashing() )
    {
        wait 0.05;
    }
    
    updatedriders = [];
    
    foreach ( rider in self.riders )
    {
        if ( isalive( rider ) )
        {
            updatedriders[ updatedriders.size ] = rider;
        }
    }
    
    utility::array_delete( updatedriders );
    self notify( #"crashed_while_deploying" );
    updatedriders = undefined;
}

// Namespace vehicle_aianim
// Params 4
// Checksum 0xdc3a2b90, Offset: 0x2441
// Size: 0x2e3
function getoutrig_abort( model, tag, animation, ropeorigin )
{
    totalanimtime = getanimlength( animation );
    var_380a7b5a14894bae = totalanimtime - 1;
    
    if ( self.vehicletype == "mi17" )
    {
        var_380a7b5a14894bae = totalanimtime - 0.5;
    }
    
    var_be49b1d9db359c31 = 0.8;
    assert( totalanimtime > var_be49b1d9db359c31 );
    assert( var_380a7b5a14894bae - var_be49b1d9db359c31 > 0 );
    self endon( #"getoutrig_disable_abort" );
    thread getoutrig_disable_abort_notify_after_riders_out();
    thread getoutrig_abort_while_deploying();
    utility::waittill_notify_or_timeout( "crashed_while_deploying", var_be49b1d9db359c31 );
    self notify( #"end_getoutrig_abort_while_deploying" );
    
    while ( !isdefined( self.vehiclecrashing ) )
    {
        waitframe();
    }
    
    if ( isdefined( model ) )
    {
        if ( !isdefined( tag ) && isdefined( ropeorigin ) )
        {
            model unlink();
            model.origin = ropeorigin;
            
            if ( !utility::issp() )
            {
                animindex = model asm::asm_lookupanimfromalias( "animscripted", animation );
                xanim = model asm::asm_getxanim( "animscripted", animindex );
                startorg = getstartorigin( self.origin, self.angles, xanim );
                startangles = getstartangles( self.origin, self.angles, xanim );
                model dontinterpolate();
                model forceteleport( startorg, startangles );
                model animmode( "nogravity" );
                model aisetanim( "animscripted", animindex );
            }
            else
            {
                model animscripted( "getoutrigfall", model.origin, model.angles, animation, undefined, undefined, 0 );
            }
        }
        else
        {
            thread animontag( model, tag, animation );
        }
        
        waittillframeend();
        model setanimtime( animation, var_380a7b5a14894bae / totalanimtime );
    }
    
    attacker = self;
    
    if ( isdefined( self.original_attacker ) )
    {
        attacker = self.original_attacker;
    }
    
    for ( i = 0; i < self.riders.size ; i++ )
    {
        if ( !isdefined( self.riders[ i ] ) )
        {
            continue;
        }
        
        if ( !isdefined( self.riders[ i ].ragdoll_getout_death ) )
        {
            continue;
        }
        
        if ( self.riders[ i ].ragdoll_getout_death != 1 )
        {
            continue;
        }
        
        if ( !isdefined( self.riders[ i ].ridingvehicle ) )
        {
            continue;
        }
        
        self.riders[ i ].forcefallthroughonropes = 1;
        
        if ( isalive( self.riders[ i ] ) )
        {
            thread animontag_ragdoll_death_fall( self.riders[ i ], self, attacker );
        }
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x332c0fe6, Offset: 0x272c
// Size: 0x7e
function setanimrestart_once( vehicle_anim, bclearanim )
{
    self endon( #"death" );
    self endon( #"dont_clear_anim" );
    
    if ( !isdefined( bclearanim ) )
    {
        bclearanim = 1;
    }
    
    cycletime = getanimlength( vehicle_anim );
    self endon( #"death" );
    thread utility::script_func( "vehicle_door_anim", self, vehicle_anim );
    wait cycletime;
    
    if ( utility::issp() && bclearanim )
    {
        self clearanim( vehicle_anim, 0 );
    }
}

#using_animtree( "script_model" );

// Namespace vehicle_aianim
// Params 3
// Checksum 0xeaf7b01, Offset: 0x27b2
// Size: 0x280
function getout_rigspawn( animatemodel, animpos, var_3fbf3458dbd0f99e = 1 )
{
    classname = vehicle_code::get_vehicle_classname();
    
    if ( isdefined( self.attach_model_override[ animpos.fastroperig ] ) )
    {
        overrridegetoutrig = 1;
    }
    else
    {
        overrridegetoutrig = 0;
    }
    
    if ( !isdefined( animpos.fastroperig ) || isdefined( self.fastroperig[ animpos.fastroperig ] ) || overrridegetoutrig )
    {
        return;
    }
    
    origin = animatemodel gettagorigin( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag );
    angles = animatemodel gettagangles( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag );
    self.fastroperiganimating[ animpos.fastroperig ] = 1;
    getoutrig_model = spawn( "script_model", origin );
    getoutrig_model.angles = angles;
    getoutrig_model.origin = origin;
    getoutrig_model useanimtree( #animtree );
    getoutrig_model setmodel( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].model );
    self.fastroperig[ animpos.fastroperig ] = getoutrig_model;
    getoutrig_model linkto( animatemodel, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag );
    thread getoutrig_model( animpos, getoutrig_model, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].dropanim, var_3fbf3458dbd0f99e );
    return getoutrig_model;
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0xadb2b11, Offset: 0x2a3b
// Size: 0x61
function check_sound_tag_dupe( soundtag )
{
    if ( !isdefined( self.sound_tag_dupe ) )
    {
        self.sound_tag_dupe = [];
    }
    
    duped = 0;
    
    if ( !isdefined( self.sound_tag_dupe[ soundtag ] ) )
    {
        self.sound_tag_dupe[ soundtag ] = 1;
    }
    else
    {
        duped = 1;
    }
    
    thread check_sound_tag_dupe_reset( soundtag );
    return duped;
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x50e320e6, Offset: 0x2aa5
// Size: 0x75
function check_sound_tag_dupe_reset( soundtag )
{
    wait 0.05;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.sound_tag_dupe[ soundtag ] = 0;
    keys = getarraykeys( self.sound_tag_dupe );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( self.sound_tag_dupe[ keys[ i ] ] )
        {
            return;
        }
    }
    
    self.sound_tag_dupe = undefined;
}

// Namespace vehicle_aianim
// Params 3
// Checksum 0xe33b8807, Offset: 0x2b22
// Size: 0xe8
function vehicle_play_exit_anim( animpos, vehicle_getoutanim, vehicle_getoutanim_clear )
{
    animatemodel = getanimatemodel();
    
    if ( !isdefined( vehicle_getoutanim ) )
    {
        vehicle_getoutanim = animpos.vehicle_getoutanim;
    }
    
    if ( !isdefined( vehicle_getoutanim_clear ) )
    {
        vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;
    }
    
    if ( isdefined( vehicle_getoutanim ) )
    {
        animatemodel thread setanimrestart_once( vehicle_getoutanim, vehicle_getoutanim_clear );
        var_5d839596714f4fa9 = 0;
        
        if ( isdefined( animpos.vehicle_getoutsoundtag ) )
        {
            var_5d839596714f4fa9 = check_sound_tag_dupe( animpos.vehicle_getoutsoundtag );
            origin = animatemodel gettagorigin( animpos.vehicle_getoutsoundtag );
        }
        else
        {
            origin = animatemodel.origin;
        }
        
        if ( isdefined( animpos.vehicle_getoutsound ) && !var_5d839596714f4fa9 )
        {
            playsoundatpos( origin, animpos.vehicle_getoutsound );
        }
        
        var_5d839596714f4fa9 = undefined;
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0xc22a14f2, Offset: 0x2c12
// Size: 0xce
function vehicle_end_loop_sounds( guy, pos )
{
    animpos = anim_pos( self, pos );
    
    if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_loop ) )
    {
        level.player thread utility::script_func( "playloopsound_on_entity", animpos.player_getout_sound_loop );
    }
    
    if ( isdefined( animpos.getoutloopsnd ) )
    {
        guy thread utility::script_func( "playloopsound_on_entity", animpos.getoutloopsnd );
    }
    
    if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_end ) )
    {
        level.player thread utility::script_func( "playsound_on_entity", animpos.player_getout_sound_end );
    }
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xf16ee2c0, Offset: 0x2ce8
// Size: 0xaa
function prepdoorsforunload()
{
    if ( self function_413a92383b3f82bc() )
    {
        return;
    }
    
    for ( i = 0; i < level.vehicle.templates.aianims[ vehicle_code::get_vehicle_classname() ].size ; i++ )
    {
        animpos = level.vehicle.templates.aianims[ vehicle_code::get_vehicle_classname() ][ i ];
        
        if ( isdefined( animpos.vehicle_getoutanim ) )
        {
            anim_name = getanimname( animpos.vehicle_getoutanim );
            self function_cbcabc88d34292ef( anim_name );
        }
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0xf6d3da5d, Offset: 0x2d9a
// Size: 0x1af
function wait_for_open_door( guy, animpos )
{
    guy endon( #"jumpedout" );
    guy endon( #"death" );
    self endon( #"death" );
    prepdoorsforunload();
    
    while ( !guy.requestopendoor && !vehicle_ai::has_anim_intro() )
    {
        waitframe();
    }
    
    if ( isdefined( animpos.vehicle_getoutanim ) )
    {
        anim_name = getanimname( animpos.vehicle_getoutanim );
        
        if ( !self function_c0a4dabbfae4a8b5( anim_name ) )
        {
            vehicle_getoutanim = animpos.vehicle_getoutanim;
            vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;
            
            if ( isdefined( guy.requestopendoorparams ) )
            {
                if ( guy.requestopendoorparams == "combat_run" && isdefined( animpos.vehicle_getoutanim_combat_run ) )
                {
                    vehicle_getoutanim = animpos.vehicle_getoutanim_combat_run;
                    vehicle_getoutanim_clear = animpos.vehicle_getoutanim_combat_run_clear;
                }
                else if ( guy.requestopendoorparams == "combat" && isdefined( animpos.vehicle_getoutanim_combat ) )
                {
                    vehicle_getoutanim = animpos.vehicle_getoutanim_combat;
                    vehicle_getoutanim_clear = animpos.vehicle_getoutanim_combat_clear;
                }
            }
            
            vehicle_play_exit_anim( animpos, vehicle_getoutanim, vehicle_getoutanim_clear );
            self function_d51ca5709183c041( anim_name );
        }
        
        if ( isdefined( animpos.fastroperig ) && !isdefined( self.fastroperig[ animpos.fastroperig ] ) )
        {
            animatemodel = getanimatemodel();
            getoutrig_model = getout_rigspawn( animatemodel, animpos, 1 );
        }
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x399dce21, Offset: 0x2f51
// Size: 0x87
function guy_setup_rope( guy, animpos )
{
    heli_ref = vehicle_code::get_vehicle_classname();
    
    if ( utility::issharedfuncdefined( heli_ref, #"setuprope" ) )
    {
        self [[ utility::getsharedfunc( heli_ref, #"setuprope" ) ]]( guy );
        return;
    }
    
    if ( isdefined( animpos.fastroperig ) )
    {
        thread wait_for_open_door( guy, animpos );
        guy vehicle_common::setuprope();
        return;
    }
    
    assertmsg( "<dev string:x201>" );
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x5c2f6eb3, Offset: 0x2fe0
// Size: 0x916
function guy_unload( guy, pos )
{
    isvehicle = 0;
    
    if ( isdefined( guy.isvehicle ) )
    {
        isvehicle = 1;
    }
    
    animpos = anim_pos( self, pos );
    type = self.vehicletype;
    
    if ( !check_unloadgroup( pos ) )
    {
        return;
    }
    
    if ( isdefined( self.script_keepdriver ) && pos == 0 )
    {
        return;
    }
    
    thread guy_unload_que( guy );
    
    if ( !utility::issp() )
    {
        thread guy_unload_watcher( guy );
    }
    
    self endon( #"death" );
    
    if ( isai( guy ) && isalive( guy ) )
    {
        guy endon( #"death" );
    }
    
    bnoanimunload = 0;
    
    if ( isdefined( guy.getoffvehiclefunc ) )
    {
        var_be069f744cfc56eb = guy [[ guy.getoffvehiclefunc ]]();
        
        if ( var_be069f744cfc56eb )
        {
            bnoanimunload = 1;
        }
    }
    
    if ( isdefined( guy.onrotatingvehicleturret ) )
    {
        guy.onrotatingvehicleturret = undefined;
        
        if ( isdefined( guy.getoffvehiclefunc ) )
        {
            guy [[ guy.getoffvehiclefunc ]]();
        }
    }
    
    guy notify( #"newanim" );
    
    if ( isdefined( animpos.bhasgunwhileriding ) && !animpos.bhasgunwhileriding )
    {
        if ( !isdefined( guy.disable_gun_recall ) )
        {
            guy ai::gun_recall();
        }
    }
    
    if ( isai( guy ) )
    {
        guy pushplayer( 1 );
    }
    
    if ( isdefined( animpos.bnoanimunload ) )
    {
        bnoanimunload = 1;
    }
    
    if ( guy should_give_orghealth() )
    {
        guy.health = guy.orghealth;
    }
    
    guy.orghealth = undefined;
    
    if ( isai( guy ) && isalive( guy ) )
    {
        guy endon( #"death" );
    }
    
    guy.allowdeath = 0;
    tag = animpos.sittag;
    
    if ( isdefined( guy.get_out_override ) )
    {
        animation = guy.get_out_override;
    }
    else if ( utility::ent_flag( "landed" ) && isdefined( animpos.getout_landed ) )
    {
        animation = animpos.getout_landed;
    }
    else if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout ) )
    {
        animation = animpos.player_getout;
    }
    else
    {
        animation = animpos.getout;
    }
    
    if ( !bnoanimunload )
    {
        if ( isdefined( animpos.getoutsnd ) )
        {
            guy thread utility::script_func( "playsound_on_tag", animpos.getoutsnd, "J_Wrist_RI", 1 );
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound ) )
        {
            guy thread utility::script_func( "playsound_on_tag", animpos.player_getout_sound );
        }
        
        if ( isdefined( animpos.getoutloopsnd ) )
        {
            guy thread utility::script_func( "playloopsound_on_tag", animpos.getoutloopsnd );
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_loop ) )
        {
            level.player thread utility::script_func( "playloopsound_on_tag", animpos.player_getout_sound_loop );
        }
        
        guy notify( #"newanim" );
        guy notify( #"jumping_out" );
        var_c4b99b4885885994 = 0;
        
        if ( !isai( guy ) && !isvehicle )
        {
            var_c4b99b4885885994 = 1;
        }
        
        if ( !isdefined( guy.script_stay_drone ) && !isvehicle )
        {
            guy = guy_becomes_real_ai( guy, pos );
        }
        
        if ( !isalive( guy ) && !isvehicle )
        {
            return;
        }
        
        if ( !isvehicle )
        {
            guy.ragdoll_getout_death = 1;
        }
        
        if ( isdefined( animpos.ragdoll_getout_death ) )
        {
            guy.ragdoll_getout_death = 1;
            
            if ( isdefined( animpos.ragdoll_fall_anim ) )
            {
                guy.ragdoll_fall_anim = animpos.ragdoll_fall_anim;
            }
        }
        
        if ( var_c4b99b4885885994 )
        {
            self.riders[ self.riders.size ] = guy;
            thread vehicle_ai::handle_rider_death( guy, pos );
            thread guy_unload_que( guy );
            guy.ridingvehicle = self;
        }
        
        if ( isai( guy ) )
        {
            guy endon( #"death" );
        }
        
        guy notify( #"newanim" );
        guy notify( #"jumping_out" );
        
        if ( animpos.littlebirde_getout_unlinks )
        {
            thread stable_unlink( guy );
        }
        
        if ( isalive( guy ) && isai( guy ) && guy_resets_goalpos( guy ) )
        {
            guy.goalradius = 600;
            guy setgoalpos( guy.origin );
        }
        
        if ( isdefined( animpos.getout_secondary ) )
        {
            animontag( guy, tag, animation );
            var_c2e1902b3ec1cda1 = tag;
            
            if ( isdefined( animpos.getout_secondary_tag ) )
            {
                var_c2e1902b3ec1cda1 = animpos.getout_secondary_tag;
            }
            
            animontag( guy, var_c2e1902b3ec1cda1, animpos.getout_secondary, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
        }
        else
        {
            hoverunload = 0;
            
            if ( isdefined( animpos.getout_hover_loop ) && isdefined( animpos.getout_hover_land ) )
            {
                thread guy_unload_land( guy, tag, animpos.getout, animpos.getout_hover_loop, animpos.getout_hover_land );
                hoverunload = 1;
            }
            else if ( !isvehicle )
            {
                guy.anim_end_early = 1;
            }
            
            thread wait_for_open_door( guy, animpos );
            guy vehicle_common::exitvehicle();
            
            if ( hoverunload )
            {
                guy waittill( #"hoverunload_done" );
            }
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_loop ) )
        {
            level.player thread utility::stop_loop_sound_on_entity( animpos.player_getout_sound_loop );
        }
        
        if ( isdefined( animpos.getoutloopsnd ) )
        {
            guy thread utility::stop_loop_sound_on_entity( animpos.getoutloopsnd );
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_end ) )
        {
            level.player thread utility::script_func( "playsound_on_entity", animpos.player_getout_sound_end );
        }
    }
    else if ( !isai( guy ) )
    {
        if ( guy.drone_delete_on_unload )
        {
            guy delete();
            return;
        }
        
        guy = utility::script_func( "spawner_makerealai", guy );
    }
    
    self.riders = arrayremove( self.riders, guy );
    self.usedpositions[ pos ] = 0;
    vehicle_occupancy::update_occupancy( self );
    guy.ridingvehicle = undefined;
    guy.drivingvehicle = undefined;
    
    if ( !isalive( self ) && !isdefined( animpos.unload_ondeath ) )
    {
        if ( isai( guy ) )
        {
            guy kill();
            return;
        }
        
        guy delete();
        return;
    }
    
    if ( !isdefined( guy.magic_bullet_shield ) )
    {
        guy.allowdeath = 1;
    }
    
    if ( isalive( guy ) || isvehicle )
    {
        guy.forced_startingposition = undefined;
        
        if ( isai( guy ) )
        {
            if ( isdefined( animpos.getoutstance ) )
            {
                guy.desired_anim_pose = animpos.getoutstance;
                guy allowedstances( "crouch" );
                guy thread utility::script_func( "anim_updateanimpose" );
                guy allowedstances( "stand", "crouch", "prone" );
            }
            
            guy pushplayer( 0 );
            guy notify( #"pushplayerchanged" );
        }
        else if ( isvehicle )
        {
            guy.vspawner.origin = guy.origin;
            guy.vspawner.angles = guy.angles;
            
            if ( isdefined( guy.vspawner.target ) )
            {
                guy.vspawner utility::callsharedfunc( #"vehicle", #"spawn_vehicle_and_gopath_sp_only" );
            }
            else
            {
                realvehicle = guy.vspawner utility::callsharedfunc( #"vehicle", #"spawn_vehicle_sp_only" );
            }
            
            guy delete();
        }
    }
    
    if ( guy.script_noteworthy == "delete_after_unload" )
    {
        if ( isai( guy ) )
        {
            guy kill();
            return;
        }
        
        guy delete();
        return;
    }
    
    if ( animpos.getout_delete )
    {
        if ( isai( guy ) )
        {
            guy kill();
            return;
        }
        
        guy delete();
        return;
    }
    
    guy guy_cleanup_vehiclevars();
}

// Namespace vehicle_aianim
// Params 5
// Checksum 0x2195c4df, Offset: 0x38fe
// Size: 0x2dd
function guy_unload_land( guy, exittag, jumpanim, loopanim, landanim )
{
    jumporigin = self gettagorigin( exittag );
    jumpangles = self gettagangles( exittag );
    startorigin = getstartorigin( jumporigin, jumpangles, jumpanim );
    startangles = getstartangles( jumporigin, jumpangles, jumpanim );
    move_delta = getmovedelta( jumpanim, 0, 1 );
    ent = utility::spawn_tag_origin();
    ent.origin = startorigin;
    ent.angles = startangles;
    endorigin = ent localtoworldcoords( move_delta );
    ent thread utility::delete_on_notify( "movedone" );
    fallstartorigin = endorigin;
    groundtrace = utility::groundpos( fallstartorigin );
    landstartorigin = getstartorigin( jumporigin, jumpangles, landanim );
    move_delta = getmovedelta( landanim, 0, 1 );
    landendorigin = landstartorigin + move_delta;
    landheight = landstartorigin[ 2 ] - landendorigin[ 2 ];
    fallendorigin = groundtrace + ( 0, 0, landheight );
    guy.allowdeath = 0;
    guy setcandamage( 0 );
    guy endon( #"death" );
    wait getanimlength( jumpanim ) - 0.1;
    guy unlink();
    guy notify( #"animontag_thread" );
    guy stopanimscripted();
    ent.origin = guy.origin;
    ent.angles = guy.angles;
    ent dontinterpolate();
    guy dontinterpolate();
    guy linkto( ent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    guy.allowdeath = 1;
    guy setcandamage( 1 );
    guy.unload_loopanim = loopanim;
    
    if ( isai( guy ) )
    {
        guy utility::script_func( "asm_animcustom", &guy_fall_loop, &guy_fall_loop_end );
    }
    else
    {
        guy thread guy_fall_loop();
    }
    
    falldist = length( ( 0, 0, fallendorigin[ 2 ] ) - ( 0, 0, fallstartorigin[ 2 ] ) );
    fallspeed = 350;
    falltime = falldist / fallspeed;
    ent moveto( fallendorigin, falltime );
    ent waittill( #"movedone" );
    guy unlink();
    guy animscripted( "dropship_land", guy.origin, guy.angles, landanim );
    wait getanimlength( landanim );
    guy notify( #"hoverunload_done" );
    guy notify( #"anim_on_tag_done" );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xaafd2335, Offset: 0x3be3
// Size: 0x7b
function guy_fall_loop()
{
    if ( isai( self ) )
    {
        if ( utility::actor_is3d() )
        {
            self orientmode( "face angle 3d", self.angles );
        }
        else
        {
            self orientmode( "face angle", self.angles[ 1 ] );
        }
        
        self animmode( "zonly_physics" );
        self clearanim( asm::asm_getbodyknob(), 0.2 );
    }
    
    self setanim( self.unload_loopanim, 1 );
    self waittill( #"dropship_land" );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0x1608a1da, Offset: 0x3c66
// Size: 0x2
function guy_fall_loop_end()
{
    
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x8576b44b, Offset: 0x3c70
// Size: 0xeb, Type: bool
function guy_resets_goalpos( guy )
{
    if ( isdefined( guy.script_delayed_playerseek ) )
    {
        return false;
    }
    
    if ( guy utility::script_func( "ai_has_color" ) )
    {
        return false;
    }
    
    if ( isdefined( guy.qsetgoalpos ) )
    {
        return false;
    }
    
    if ( !isdefined( guy.target ) )
    {
        return true;
    }
    
    nodes = getnodearray( guy.target, #targetname );
    structs = utility::getstructarray( guy.target, "targetname" );
    
    if ( nodes.size > 0 || structs.size > 0 )
    {
        return false;
    }
    
    ent = getent( guy.target, #targetname );
    
    if ( isdefined( ent ) && ent.classname == "info_volume" )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_aianim
// Params 8
// Checksum 0xb8a3ff11, Offset: 0x3d64
// Size: 0x31e
function animontag( guy, tag, animation, notetracks, sthreads, flag, origin_offset, angles_offset )
{
    guy notify( #"animontag_thread" );
    guy endon( #"animontag_thread" );
    
    if ( !isdefined( origin_offset ) )
    {
        origin_offset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( angles_offset ) )
    {
        angles_offset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( flag ) )
    {
        flag = "animontagdone";
    }
    
    if ( isdefined( self.modeldummy ) )
    {
        animatemodel = self.modeldummy;
    }
    else
    {
        animatemodel = self;
    }
    
    if ( !isdefined( tag ) || !utility::hastag( animatemodel.model, tag ) )
    {
        org = guy.origin;
        angles = guy.angles;
    }
    else
    {
        org = animatemodel gettagorigin( tag );
        angles = animatemodel gettagangles( tag ) + angles_offset;
        axes = anglestoaxis( angles );
        axesnames = [ "forward", "right", "up" ];
        
        for ( i = 0; i < axes.size ; i++ )
        {
            org += axes[ axesnames[ i ] ] * origin_offset[ i ];
        }
    }
    
    if ( isdefined( guy.ragdoll_getout_death ) )
    {
        level thread animontag_ragdoll_death( guy, self );
    }
    
    if ( !utility::issp() )
    {
        guy dontinterpolate();
        
        if ( isai( guy ) )
        {
            animindex = guy asm::asm_lookupanimfromalias( "animscripted", animation );
            xanim = guy asm::asm_getxanim( "animscripted", animindex );
            startorg = getstartorigin( self.origin, self.angles, xanim );
            startangles = getstartangles( self.origin, self.angles, xanim );
            guy forceteleport( startorg, startangles );
            guy animmode( "nogravity" );
            guy aisetanim( "animscripted", animindex );
        }
    }
    else
    {
        guy animscripted( flag, org, angles, animation );
    }
    
    if ( isai( guy ) )
    {
        thread donotetracks( guy, animatemodel, flag );
    }
    
    if ( isdefined( guy.anim_end_early ) )
    {
        guy.anim_end_early = undefined;
        animwait = getanimlength( animation ) - 0.25;
        
        if ( animwait > 0 )
        {
            wait animwait;
        }
        
        guy stopanimscripted();
        guy.interval = 0;
        guy thread recover_interval();
    }
    else
    {
        if ( isdefined( notetracks ) )
        {
            for ( i = 0; i < notetracks.size ; i++ )
            {
                guy waittillmatch( flag, notetracks[ i ] );
                guy thread [[ sthreads[ i ] ]]();
            }
        }
        
        guy waittillmatch( flag, #"end" );
    }
    
    guy notify( #"anim_on_tag_done" );
    guy.ragdoll_getout_death = undefined;
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xfd95ecfa, Offset: 0x408a
// Size: 0x2a
function recover_interval()
{
    self endon( #"death" );
    wait 2;
    
    if ( self.interval == 0 )
    {
        self.interval = 80;
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x9c45d0a, Offset: 0x40bc
// Size: 0xfb
function animontag_ragdoll_death( guy, vehicle )
{
    if ( guy.magic_bullet_shield )
    {
        return;
    }
    
    if ( !isai( guy ) )
    {
        guy setcandamage( 1 );
    }
    
    guy endon( #"anim_on_tag_done" );
    damage = undefined;
    attacker = undefined;
    var_4b017bc092dee052 = vehicle.health <= 0;
    
    while ( true )
    {
        if ( !var_4b017bc092dee052 && !( vehicle.health > 0 ) )
        {
            break;
        }
        
        guy waittill( #"damage", damage, attacker );
        
        if ( isdefined( guy.forcefallthroughonropes ) )
        {
            break;
        }
        
        if ( !isdefined( damage ) )
        {
            continue;
        }
        
        if ( damage < 1 )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) )
        {
            continue;
        }
        
        if ( isplayer( attacker ) )
        {
            break;
        }
    }
    
    if ( !isalive( guy ) )
    {
        return;
    }
    
    thread animontag_ragdoll_death_fall( guy, vehicle, attacker );
}

// Namespace vehicle_aianim
// Params 3
// Checksum 0x4a0f9b11, Offset: 0x41bf
// Size: 0x29f
function animontag_ragdoll_death_fall( guy, vehicle, attacker )
{
    guy.deathanim = undefined;
    guy.deathfunction = undefined;
    guy.anim_disablepain = 1;
    
    if ( isdefined( guy.ragdoll_fall_anim ) )
    {
        movedelta = getmovedelta( guy.ragdoll_fall_anim, 0, 1 );
        groundpos = physicstrace( guy.origin + ( 0, 0, 16 ), guy.origin - ( 0, 0, 10000 ) );
        distancefromground = distance( guy.origin + ( 0, 0, 16 ), groundpos );
        
        if ( abs( movedelta[ 2 ] + 16 ) <= abs( distancefromground ) )
        {
            guy thread utility::script_func( "playsound_on_entity", "generic_death_falling" );
            guy animscripted( "fastrope_fall", guy.origin, guy.angles, guy.ragdoll_fall_anim );
            guy waittillmatch( #"fastrope_fall", #"start_ragdoll" );
        }
    }
    
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    guy.deathanim = undefined;
    guy.deathfunction = undefined;
    guy.anim_disablepain = 1;
    guy notify( #"rope_death", attacker );
    guy kill( attacker.origin, attacker );
    
    if ( isdefined( guy.script_stay_drone ) )
    {
        guy notsolid();
        weapon_model = getweaponmodel( guy.weapon );
        weapon = guy.weapon;
        
        if ( isdefined( weapon_model ) )
        {
            guy detach( weapon_model, "tag_weapon_right" );
            org = guy gettagorigin( "tag_weapon_right" );
            ang = guy gettagangles( "tag_weapon_right" );
            level.gun = spawn( "weapon_" + getcompleteweaponname( weapon ), ( 0, 0, 0 ) );
            level.gun.angles = ang;
            level.gun.origin = org;
        }
    }
    else
    {
        guy utility::script_func( "anim_dropallaiweapons" );
    }
    
    if ( isdefined( guy.fnpreragdoll ) )
    {
        guy [[ guy.fnpreragdoll ]]();
    }
    
    guy startragdoll();
}

// Namespace vehicle_aianim
// Params 3
// Checksum 0x381b5202, Offset: 0x4466
// Size: 0x62
function donotetracks( guy, vehicle, flag )
{
    guy endon( #"idle" );
    guy endon( #"newanim" );
    vehicle endon( #"death" );
    guy endon( #"death" );
    guy utility::script_func( "anim_donotetracks", flag );
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xbc736bd, Offset: 0x44d0
// Size: 0x3b
function ai_wait_go()
{
    self notify( #"hash_eddc741fb8f6b33e" );
    self endon( #"hash_eddc741fb8f6b33e" );
    self endon( #"death" );
    self waittill( #"loaded" );
    vehicle_paths::gopath( self );
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0xfe84149a, Offset: 0x4513
// Size: 0x151
function set_pos( guy, vehicleanim )
{
    pos = guy.script_startingposition;
    
    /#
        if ( isdefined( pos ) )
        {
            assert( pos < vehicleanim.size && pos >= 0, "<dev string:x24e>" + vehicleanim.size - 1 );
        }
    #/
    
    if ( isdefined( guy.forced_startingposition ) )
    {
        pos = guy.forced_startingposition;
    }
    
    if ( isdefined( pos ) )
    {
        return pos;
    }
    
    assert( !isdefined( pos ), "<dev string:x290>" );
    
    for ( j = 0; j < self.usedpositions.size ; j++ )
    {
        if ( self.usedpositions[ j ] || !( vehicleanim[ j ].var_60b6d3b20648a38f ?? 1 ) )
        {
            continue;
        }
        
        if ( isdefined( guy.isvehicle ) && !isdefined( vehicleanim[ j ].isvehicle ) )
        {
            continue;
        }
        
        if ( !isdefined( guy.isvehicle ) && isdefined( vehicleanim[ j ].isvehicle ) )
        {
            continue;
        }
        
        return j;
    }
    
    if ( guy.isvehicle )
    {
        assertmsg( "<dev string:x2aa>" );
        return;
    }
    
    assertmsg( "<dev string:x2e8>" );
}

// Namespace vehicle_aianim
// Params 3
// Checksum 0xe9fcae44, Offset: 0x466c
// Size: 0x132
function guy_man_turret( guy, pos, var_12adb1f13b90f22f )
{
    animpos = anim_pos( self, pos );
    turret = self.mgturret[ 0 ];
    
    if ( !isalive( guy ) )
    {
        return;
    }
    
    turret endon( #"death" );
    guy endon( #"death" );
    
    if ( var_12adb1f13b90f22f && isdefined( animpos.passenger_2_turret_func ) )
    {
        [[ animpos.passenger_2_turret_func ]]( self, guy, pos, turret );
    }
    
    if ( turret.classname == "misc_turret" )
    {
        vehicle_code::set_turret_team( turret );
        turret setdefaultdroppitch( 0 );
    }
    
    wait 0.1;
    guy endon( #"guy_man_turret_stop" );
    
    if ( turret.classname == "misc_turret" )
    {
        level thread vehicle_code::vehicle_turret_difficulty( turret, utility::getdifficulty() );
    }
    
    if ( turret.classname == "misc_turret" )
    {
        guy asm_bb::bb_requestturret( turret );
        return;
    }
    
    if ( turret.classname == "script_vehicle" )
    {
        guy asm_bb::function_d97733fe1476f19e( turret, 1 );
    }
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0xd6021ce9, Offset: 0x47a6
// Size: 0x2c8
function guy_blowup( guy )
{
    if ( !isdefined( guy.vehicle_position ) )
    {
        return;
    }
    
    pos = guy.vehicle_position;
    anim_pos = anim_pos( self, pos );
    
    if ( !isdefined( anim_pos.explosion_death ) )
    {
        return;
    }
    
    guy.deathanim = anim_pos.explosion_death;
    angles = self.angles;
    origin = guy.origin;
    
    if ( isdefined( anim_pos.explosion_death_offset ) )
    {
        origin += anglestoforward( angles ) * anim_pos.explosion_death_offset[ 0 ];
        origin += anglestoright( angles ) * anim_pos.explosion_death_offset[ 1 ];
        origin += anglestoup( angles ) * anim_pos.explosion_death_offset[ 2 ];
    }
    
    guy = convert_guy_to_drone( guy );
    detach_models_with_substr( guy, "weapon_" );
    guy notsolid();
    guy.origin = origin;
    guy.angles = angles;
    guy animscripted( "deathanim", origin, angles, anim_pos.explosion_death );
    fraction = 0.3;
    
    if ( isdefined( anim_pos.explosion_death_ragdollfraction ) )
    {
        fraction = anim_pos.explosion_death_ragdollfraction;
    }
    
    animlength = getanimlength( anim_pos.explosion_death );
    timer = gettime() + animlength * 1000;
    wait animlength * fraction;
    force = ( 0, 0, 1 );
    org = guy.origin;
    
    if ( getdvarint( @"ragdoll_enable", 1 ) == 0 )
    {
        guy delete();
        return;
    }
    
    if ( isai( guy ) )
    {
        guy utility::script_func( "anim_dropallaiweapons" );
    }
    else
    {
        detach_models_with_substr( guy, "weapon_" );
    }
    
    while ( !guy isragdoll() && gettime() < timer )
    {
        org = guy.origin;
        wait 0.05;
        force = guy.origin - org;
        
        if ( isdefined( guy.fnpreragdoll ) )
        {
            guy [[ guy.fnpreragdoll ]]();
        }
        
        guy startragdoll();
    }
    
    wait 0.05;
    force *= 20000;
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( guy ) )
        {
            org = guy.origin;
        }
        
        wait 0.05;
    }
    
    if ( !guy isragdoll() )
    {
        guy delete();
    }
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x4d1c1f2c, Offset: 0x4a76
// Size: 0xef
function convert_guy_to_drone( guy, var_9295811a6211753c = 0 )
{
    model = spawn( "script_model", guy.origin );
    model.angles = guy.angles;
    model setmodel( guy.model );
    size = guy getattachsize();
    
    for ( i = 0; i < size ; i++ )
    {
        model attach( guy getattachmodelname( i ), guy getattachtagname( i ) );
    }
    
    model useanimtree( #animtree );
    
    if ( isdefined( guy.team ) )
    {
        model.team = guy.team;
    }
    
    if ( !var_9295811a6211753c )
    {
        guy delete();
    }
    
    model utility::self_func( "makefakeai" );
    return model;
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x99c5fcd9, Offset: 0x4b6e
// Size: 0x9f
function vehicle_getinstart( pos )
{
    animpos = anim_pos( self, pos );
    assert( isdefined( animpos ), "<dev string:x32c>" + vehicle_code::get_vehicle_classname() + "<dev string:x336>" + pos + "<dev string:x35d>" );
    assert( isdefined( animpos.sittag ), "<dev string:x32c>" + vehicle_code::get_vehicle_classname() + "<dev string:x36b>" + pos + "<dev string:x38b>" );
    return vehicle_getanimstart( animpos.getin, animpos.sittag, pos, animpos.canshootinvehicle );
}

// Namespace vehicle_aianim
// Params 4
// Checksum 0xe18b0ba5, Offset: 0x4c16
// Size: 0xf7
function vehicle_getanimstart( animation, tag, pos, canshootinvehicle )
{
    struct = spawnstruct();
    origin = undefined;
    angles = undefined;
    assert( isdefined( tag ), "<dev string:x32c>" + vehicle_code::get_vehicle_classname() + "<dev string:x38e>" );
    
    if ( !isdefined( tag ) )
    {
        tag = "tag_body";
    }
    
    org = self gettagorigin( tag );
    ang = self gettagangles( tag );
    
    if ( isdefined( animation ) )
    {
        origin = getstartorigin( org, ang, animation );
        angles = getstartangles( org, ang, animation );
    }
    else
    {
        origin = org;
        angles = ang;
    }
    
    struct.origin = origin;
    struct.angles = angles;
    struct.vehicle_position = pos;
    struct.canshootinvehicle = canshootinvehicle;
    return struct;
}

// Namespace vehicle_aianim
// Params 3
// Checksum 0x838cc77, Offset: 0x4d16
// Size: 0x105, Type: bool
function is_position_in_group( vehicle, pos, group )
{
    if ( !isdefined( group ) )
    {
        return true;
    }
    
    classname = vehicle vehicle_code::get_vehicle_classname();
    assert( isdefined( level.vehicle.templates.unloadgroups[ classname ][ group ] ) );
    vehicles_group = level.vehicle.templates.unloadgroups[ classname ][ group ];
    
    foreach ( member in vehicles_group )
    {
        if ( member == pos )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x5ce8ae5d, Offset: 0x4e24
// Size: 0x100
function get_availablepositions( group )
{
    vehicleanim = level.vehicle.templates.aianims[ vehicle_code::get_vehicle_classname() ];
    availablepositions = [];
    nonanimatedpositions = [];
    
    for ( i = 0; i < self.usedpositions.size ; i++ )
    {
        if ( self.usedpositions[ i ] || !( vehicleanim[ i ].var_60b6d3b20648a38f ?? 1 ) || vehicleanim[ i ].var_14f441f730dc229d )
        {
            continue;
        }
        
        if ( is_position_in_group( self, i, group ) )
        {
            availablepositions[ availablepositions.size ] = vehicle_getinstart( i );
            continue;
        }
        
        nonanimatedpositions[ nonanimatedpositions.size ] = i;
    }
    
    struct = spawnstruct();
    struct.availablepositions = availablepositions;
    struct.nonanimatedpositions = nonanimatedpositions;
    return struct;
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xeb415238, Offset: 0x4f2d
// Size: 0x21
function getanimatemodel()
{
    var_7237854e3be197ca = self.modeldummy;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return self;
}

// Namespace vehicle_aianim
// Params 2
// Checksum 0x5aba80bd, Offset: 0x4f57
// Size: 0xb8
function detach_models_with_substr( guy, substr )
{
    size = guy getattachsize();
    var_d39a52de9bccb3ba = [];
    var_551b9b0ac7e98ac2 = [];
    index = 0;
    
    for ( i = 0; i < size ; i++ )
    {
        modelname = guy getattachmodelname( i );
        tagname = guy getattachtagname( i );
        
        if ( issubstr( modelname, substr ) )
        {
            var_d39a52de9bccb3ba[ index ] = modelname;
            var_551b9b0ac7e98ac2[ index ] = tagname;
        }
    }
    
    for ( i = 0; i < var_d39a52de9bccb3ba.size ; i++ )
    {
        guy detach( var_d39a52de9bccb3ba[ i ], var_551b9b0ac7e98ac2[ i ] );
    }
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0xa363b9c5, Offset: 0x5017
// Size: 0x28, Type: bool
function should_give_orghealth()
{
    if ( !isai( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.orghealth ) )
    {
        return false;
    }
    
    return !isdefined( self.magic_bullet_shield );
}

// Namespace vehicle_aianim
// Params 1
// Checksum 0x56948ab4, Offset: 0x5048
// Size: 0x29
function stable_unlink( guy )
{
    self waittill( #"stable_for_unlink" );
    
    if ( isalive( guy ) )
    {
        guy unlink();
    }
}

// Namespace vehicle_aianim
// Params 0
// Checksum 0x5258df2e, Offset: 0x5079
// Size: 0x2a
function guy_cleanup_vehiclevars()
{
    self.vehicle_idling = undefined;
    self.standing = undefined;
    self.vehicle_position = undefined;
    self.delay = undefined;
}

