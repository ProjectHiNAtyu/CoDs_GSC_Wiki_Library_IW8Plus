// scripts\common\vehicle_ai.gsc  (hash_0563faa2d4a740f9.gscc) (size: 35655 Bytes / 0x8b47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc52e9173 (3308163443)
// size ...... 35655 (0x8b47)
// includes .. 15  (offset: 0x857f)
// strings ... 42  (offset: 0x85f7)
// dev strs .. 41  (offset: 0x88ff)
// exports ... 90  (offset: 0x56f3)
// cseg ...... 0x2ad + 0x5446 (0x56f3)
// imports ... 257 (offset: 0x6503)
// animtree1 . 0   (offset: 0x8b47)
// animtree2 . 0   (offset: 0x8b47)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\vehicle\vehicle_common;

#namespace vehicle_ai;

// Namespace vehicle_ai
// Params 0
// Checksum 0xb2d73c22, Offset: 0x2cb
// Size: 0x2a
function init()
{
    if ( !isdefined( level.var_8df7c17ba952d077 ) )
    {
        level.var_8df7c17ba952d077 = [];
    }
    
    /#
        setdevdvarifuninitialized( @"hash_2a67f2406b1d6460", 0 );
    #/
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x6a64c381, Offset: 0x2fd
// Size: 0x16f
function function_76f7ea069893edd2( data )
{
    if ( utility::ent_flag( "ai_initted" ) )
    {
        return;
    }
    
    utility::ent_flag_init( "unloaded" );
    utility::ent_flag_init( "loaded" );
    utility::ent_flag_init( "landed" );
    self.riders = [];
    self.lwriders = [];
    self.unloadque = [];
    self.unload_group = "default";
    self.fastroperig = [];
    
    if ( isdefined( data ) )
    {
        isheli = vehicle::ishelicopter();
        ref = self.vehiclename;
        self.vehicleanimalias = data.ai.vehicleanimalias;
        self.classname_mp = ref;
        self.deathfunc = &vehicle::death;
        self.script_badplace = !isheli;
        self.unload_land_offset = data.ai.unload_land_offset;
        self.unload_hover_offset = data.ai.unload_hover_offset;
        self.vehiclesetuprope = data.ai.vehiclesetuprope;
        vehicle_spawn::prevent_respawn();
        
        if ( isheli )
        {
            self vehicle_setspeed( 60, 20, 10 );
            vehicle_occupancy::function_474d87fe62493d22();
        }
    }
    
    thread vehicle_aianim::handle_attached_guys();
    utility::ent_flag_set( "ai_initted" );
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xd82aa37a, Offset: 0x474
// Size: 0xd
function function_c439ae025b2bf434()
{
    self addcomponent( "p2p" );
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x7036fcbb, Offset: 0x489
// Size: 0xd
function function_fb0af73dcefe123()
{
    self removecomponent( "p2p" );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xd2da81ea, Offset: 0x49e
// Size: 0xaf
function try_horn( final_dest )
{
    if ( !isdefined( self.var_1311060992aff23 ) || self.var_1311060992aff23 < 5 )
    {
        if ( distancesquared( self.origin, final_dest ) < squared( 750 ) )
        {
            if ( !isdefined( self.var_f969432374ae8c0b ) )
            {
                self.var_f969432374ae8c0b = 0;
                self.var_1311060992aff23 = 0;
            }
            
            if ( gettime() > self.var_f969432374ae8c0b )
            {
                if ( soundexists( "veh_horn_mid_random" ) )
                {
                    self playsoundonmovingent( "veh_horn_mid_random" );
                }
                
                self.var_1311060992aff23++;
                self.var_f969432374ae8c0b = gettime() + randomintrange( 200, 1000 );
            }
        }
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x9968d550, Offset: 0x555
// Size: 0x58, Type: bool
function has_anim_intro()
{
    ref = vehicle::get_ref();
    
    if ( vehicle::has_data( ref ) )
    {
        data = vehicle::get_data( ref );
        return ( isdefined( data.ai ) && data.ai.animintro );
    }
    
    return false;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xa79c1ce0, Offset: 0x5b6
// Size: 0xa8
function get_intro_anim()
{
    if ( !has_anim_intro() )
    {
        return;
    }
    
    foreach ( seat in vehicle::get_data( vehicle::get_ref() ).aiseats )
    {
        var_7237854e3be197ca = seat.vehicle_getoutanim;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xcd240e8a, Offset: 0x666
// Size: 0x4c
function get_intro_anim_time()
{
    if ( !has_anim_intro() )
    {
        return;
    }
    
    var_7237854e3be197ca = vehicle::get_data( vehicle::get_ref() ).ai.animintrolength;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return getanimlength( get_intro_anim() );
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x8de9d733, Offset: 0x6bb
// Size: 0x28, Type: bool
function function_3f791d10e984b5fc()
{
    return vehicle::get_data( vehicle::get_ref() ).ai.var_a5f09aae7b460b24 ?? 400;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x6ff6951f, Offset: 0x6ec
// Size: 0xe
function function_a17e8d27cb11154c()
{
    return function_69a7fc27a2f10141() * 17.6;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xfb3ff140, Offset: 0x703
// Size: 0x27, Type: bool
function function_69a7fc27a2f10141()
{
    return vehicle::get_data( vehicle::get_ref() ).ai.var_f7d3550554dbd6a9 ?? 10;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xdb965041, Offset: 0x733
// Size: 0x22
function function_b653bae885b293df()
{
    return vehicle::get_data( vehicle::get_ref() ).ai.var_f56254142506eaa8;
}

// Namespace vehicle_ai
// Params 4
// Checksum 0xb0c1ba7c, Offset: 0x75e
// Size: 0x141
function follow_path_struct( pathdata, speed, var_4520e0d9c889c80a, navmeshlayer )
{
    self endon( #"death" );
    self endon( #"unloaded" );
    self notify( #"hash_ff603c86bbe07fdb" );
    self endon( #"hash_ff603c86bbe07fdb" );
    
    while ( !isdefined( level.vehiclenavmeshlayer ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        increment_path_index( pathdata );
        try_horn( pathdata.path[ pathdata.index ].origin );
        adjustedspeed = get_node_speed_override( pathdata.path[ pathdata.index ], speed );
        
        if ( adjustedspeed != speed )
        {
            self setconfigvalue( "p2p", "goalThreshold", adjustedspeed * 4 );
        }
        
        result = function_1a6c0d0264fdd63c( self.origin, pathdata.path[ pathdata.index ].origin, adjustedspeed, undefined, undefined, navmeshlayer );
        
        if ( isdefined( var_4520e0d9c889c80a ) && result == "path_blocked" )
        {
            [[ var_4520e0d9c889c80a ]]();
        }
        
        waitframe();
    }
}

// Namespace vehicle_ai
// Params 2
// Checksum 0x2917d2c6, Offset: 0x8a7
// Size: 0x79
function get_node_speed_override( node, speed )
{
    if ( !isdefined( node.relativespeed ) )
    {
        return speed;
    }
    
    if ( node.relativespeed == "slow" )
    {
        return 20;
    }
    
    if ( node.relativespeed == "fast" )
    {
        return 80;
    }
    
    if ( node.relativespeed == "furious" )
    {
        return 128;
    }
    
    return speed;
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xbeec2d4a, Offset: 0x928
// Size: 0x70
function increment_path_index( pathdata )
{
    pathdata.index = ( pathdata.index + pathdata.direction ) % pathdata.path.size;
    
    if ( pathdata.index < 0 )
    {
        pathdata.index += pathdata.path.size;
    }
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x875ccc84, Offset: 0x9a0
// Size: 0x65
function damage_feedback( hittype )
{
    if ( hittype == "hitveharmorbreak" )
    {
        level notify( #"armorplate_broken", self );
    }
    
    if ( isplayer( self ) )
    {
        if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
        {
            self [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( hittype );
        }
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x3caab81, Offset: 0xa0d
// Size: 0x1a5
function armored_vehicle_death()
{
    if ( isdefined( self.aidriver ) )
    {
        self.aidriver.fn_shoulddodamage = undefined;
    }
    
    origin = self.origin + ( 0, 0, 40 );
    
    foreach ( rider in self.riders )
    {
        if ( !isalive( rider ) )
        {
            continue;
        }
        
        rider.do_immediate_ragdoll = 1;
        rider.ragdoll_immediate = 1;
        
        if ( !rider._blackboard.vehiclerequested )
        {
            anim_pos = vehicle_aianim::anim_pos( self, rider.vehicle_position );
            rider vehicle_common::requestentervehicle( self, 0, rider.vehicle_position, anim_pos );
        }
        
        if ( isdefined( rider._blackboard.chosenvehicleanimpos ) )
        {
            if ( rider._blackboard.chosenvehicleanimpos_deathimpulse )
            {
                rider._blackboard.chosenvehicleanimpos_deathragdoll = 1;
            }
        }
        
        rider dodamage( rider.health + 100, self.origin + ( 0, 0, -100 ), undefined, undefined, "MOD_EXPLOSIVE" );
    }
}

// Namespace vehicle_ai
// Params 6
// Checksum 0x7acae627, Offset: 0xbba
// Size: 0x1cb
function function_1a6c0d0264fdd63c( start_point, end_point, speed, setmaxspeed, var_a806fa27d4c8f0a8, navmeshlayer = level.vehiclenavmeshlayer )
{
    assert( isdefined( level.vehiclenavmeshlayer ), "<dev string:x24>" );
    var_88319952e6c79b9d = undefined;
    
    if ( !isdefined( setmaxspeed ) )
    {
        setmaxspeed = 1;
    }
    
    if ( !isdefined( var_a806fa27d4c8f0a8 ) )
    {
        var_a806fa27d4c8f0a8 = 0;
    }
    
    if ( distancesquared( start_point, end_point ) < 62500 )
    {
        var_88319952e6c79b9d = [ getclosestpointonnavmesh( end_point, navmeshlayer ) ];
    }
    else
    {
        var_88319952e6c79b9d = findpathcustom( start_point, getclosestpointonnavmesh( end_point, navmeshlayer ), 1, 1, navmeshlayer );
        var_88319952e6c79b9d[ 0 ] = undefined;
        
        /#
            if ( getdvar( @"hash_5932a654e8efe1fa", "<dev string:xab>" ) != "<dev string:xab>" )
            {
                foreach ( index, node in var_88319952e6c79b9d )
                {
                    sphere( node, 16, ( 1, 1, 1 ), 200000 );
                    
                    if ( isdefined( var_88319952e6c79b9d[ index + 1 ] ) )
                    {
                        line( node, var_88319952e6c79b9d[ index + 1 ], ( 0, 1, 0 ), 200000 );
                    }
                }
            }
            
            if ( getdvar( @"scr_debugvehpos", "<dev string:xab>" ) != "<dev string:xab>" )
            {
                sphere( end_point, 16, ( 1, 1, 1 ), 0, 2 );
            }
        #/
    }
    
    if ( var_88319952e6c79b9d.size >= 1 )
    {
        return go_to_path( var_88319952e6c79b9d, speed, setmaxspeed, var_a806fa27d4c8f0a8 );
    }
}

// Namespace vehicle_ai
// Params 4
// Checksum 0x6b132d8f, Offset: 0xd8d
// Size: 0x250
function go_to_path( var_88319952e6c79b9d, speed, setmaxspeed, var_a806fa27d4c8f0a8 )
{
    self notify( #"path_updated" );
    self endon( #"path_updated" );
    self endon( #"kill_thread_since_spotted" );
    self endon( #"death" );
    self endon( #"unloaded" );
    
    if ( !isdefined( speed ) && !isdefined( self.var_2c37025c6a0e1fe9 ) )
    {
        assertmsg( "<dev string:xac>" );
        return "path_blocked";
    }
    
    if ( setmaxspeed && isdefined( speed ) )
    {
        vehicle::vehicle_set_speed( speed );
    }
    
    last_point = undefined;
    
    if ( var_a806fa27d4c8f0a8 )
    {
        last_point = utility::function_f1933af772476229( var_88319952e6c79b9d );
    }
    
    foreach ( point in var_88319952e6c79b9d )
    {
        var_c65210324564022c = 62500;
        
        if ( isdefined( self.var_c65210324564022c ) )
        {
            var_c65210324564022c = self.var_c65210324564022c;
        }
        
        if ( distancesquared( self.origin, point ) < var_c65210324564022c )
        {
            continue;
        }
        
        self setconfigvalue( "p2p", "goalPoint", point );
        
        if ( var_a806fa27d4c8f0a8 && point == last_point )
        {
            self setconfigvalue( "p2p", "brakeAtGoal", 1 );
        }
        
        self.goalpoint = point;
        
        if ( !setmaxspeed && isdefined( speed ) )
        {
            dist = distance( self.origin, point );
            time = undefined;
            
            if ( dist > 0 )
            {
                time = get_duration_between_points( self.origin, point, speed );
            }
            
            key = function_abd1a501c0438a5b( "p2p", "targetTime" );
            
            if ( isdefined( time ) )
            {
                self setconfigvalue( key, time );
            }
            else
            {
                self setconfigvalue( key, 0.2 );
            }
        }
        
        result = utility::waittill_any_return( "near_goal", "path_blocked" );
        
        if ( result == "path_blocked" )
        {
            return "path_blocked";
        }
    }
    
    return "near_goal";
}

// Namespace vehicle_ai
// Params 4
// Checksum 0xf3106396, Offset: 0xfe6
// Size: 0x62
function get_duration_between_points( startpos, endpos, speed, convert )
{
    dist = distance( startpos, endpos );
    
    if ( convert )
    {
        dist *= 0.0568182;
    }
    
    moverate = dist / speed;
    return max( moverate, 0.05 );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x2faa4fc5, Offset: 0x1051
// Size: 0x128
function get_max_ai( var_99bcf2eb77efe27c )
{
    ref = isent( var_99bcf2eb77efe27c ) ? var_99bcf2eb77efe27c vehicle::get_ref() : var_99bcf2eb77efe27c;
    
    if ( !vehicle::has_data( ref ) )
    {
        return 0;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !isdefined( data.ai ) || !data.ai.supportsai )
    {
        return 0;
    }
    
    totalseats = data.aiseats.size;
    
    foreach ( seat in data.aiseats )
    {
        if ( seat.var_14f441f730dc229d || seat.var_60b6d3b20648a38f == 0 )
        {
            totalseats -= 1;
        }
    }
    
    return totalseats;
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x64eb883, Offset: 0x1182
// Size: 0x64, Type: bool
function supports_ai( var_99bcf2eb77efe27c )
{
    ref = isent( var_99bcf2eb77efe27c ) ? var_99bcf2eb77efe27c vehicle::get_ref() : var_99bcf2eb77efe27c;
    
    if ( !vehicle::has_data( ref ) )
    {
        return false;
    }
    
    data = vehicle::get_data( ref );
    return isdefined( data.ai.supportsai );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x1e4ace63, Offset: 0x11ef
// Size: 0xcb
function function_9133d94dfb2c34f( var_99bcf2eb77efe27c )
{
    ref = isent( var_99bcf2eb77efe27c ) ? var_99bcf2eb77efe27c vehicle::get_ref() : var_99bcf2eb77efe27c;
    
    if ( !vehicle::has_data( ref ) )
    {
        return 0;
    }
    
    data = vehicle::get_data( ref );
    
    if ( self isincombat() || !self.stealth_enabled )
    {
        return ( isdefined( data.ai.supportsai ) && isdefined( data.aiseats[ 0 ].vehicle_getinanim_combat ) );
    }
    
    return isdefined( data.ai.supportsai ) && isdefined( data.aiseats[ 0 ].vehicle_getinanim );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xf1f79983, Offset: 0x12c2
// Size: 0x25, Type: bool
function can_load( riders )
{
    return self && !vehicle::is_destroyed() && self.isempty;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x4
// Checksum 0x9ce29e86, Offset: 0x12f0
// Size: 0x4f
function private function_839272ea67669e14()
{
    msg = utility::waittill_any_return( "entervehicle", "failedentervehicle", "unloaded", "death", "long_death" );
    
    if ( msg != "death" && msg != "long_death" )
    {
        self.var_4f8a92ebabf37ee = 1;
    }
}

// Namespace vehicle_ai
// Params 5
// Checksum 0x36f5291c, Offset: 0x1347
// Size: 0x376
function load( riders, spawninvehicle = 0, var_a2ce7ad489be5c4f, group, goddriver )
{
    vehicleref = vehicle::get_ref();
    assert( utility::level_supports_ai() && vehicle::get_data( vehicleref ).ai.supportsai, "<dev string:xfa>" );
    
    if ( is_loading() )
    {
        return;
    }
    
    self.loading = 1;
    callback::callback( #"vehicle_loading", { #goddriver:goddriver, #group:group, #var_a2ce7ad489be5c4f:var_a2ce7ad489be5c4f, #spawninvehicle:spawninvehicle, #riders:riders } );
    
    if ( isagent( riders[ getarraykey( riders, 0 ) ] ) )
    {
        riders = vehicle_code::sort_by_startingpos( riders );
        
        foreach ( rider in riders )
        {
            if ( rider.bhasriotshieldattached )
            {
                savedmodel = rider.riotshieldmodel;
                rider._blackboard.var_86e1adabb762ade4 = 1;
                
                if ( utility::issp() )
                {
                    rider detach( rider.riotshieldmodel, rider.riotshieldmodeltag );
                }
                else
                {
                    rider aisetriotshieldweapon( nullweapon() );
                }
                
                rider.bhasriotshieldattached = undefined;
                rider.riotshieldmodel = savedmodel;
            }
            
            if ( spawninvehicle )
            {
                rider.dontkilloff = undefined;
            }
            
            if ( getdvarint( @"hash_4deba55716c47c46", 0 ) && !spawninvehicle && rider.var_4f8a92ebabf37ee )
            {
                rider.var_4f8a92ebabf37ee = 0;
                rider thread function_839272ea67669e14();
            }
        }
    }
    
    if ( !utility::ent_flag( "ai_initted" ) )
    {
        function_76f7ea069893edd2( vehicle::get_data( vehicleref ) );
    }
    
    if ( getdvarint( @"hash_4deba55716c47c46", 0 ) && utility::issharedfuncdefined( #"ai_mp_controller", #"hash_cbe331215c7d5cdf" ) && riders.size > 0 && isstruct( riders[ getarraykey( riders, 0 ) ] ) )
    {
        println( "<dev string:x145>" + self getentitynumber() + "<dev string:x15b>" + self.groupid + "<dev string:x160>" );
        utility::ent_flag_clear( "unloaded" );
        utility::ent_flag_clear( "loaded" );
        function_1fa2949c43e3887e( riders );
        function_c505198907e0d306( self.groupid, self );
        waitframe();
        println( "<dev string:x145>" + self getentitynumber() + "<dev string:x15b>" + self.groupid + "<dev string:x17d>" );
        self.loading = undefined;
        utility::ent_flag_set( "loaded" );
    }
    else if ( utility::issharedfuncdefined( vehicleref, #"loadAI" ) )
    {
        [[ utility::getsharedfunc( vehicleref, #"loadAI" ) ]]( riders, spawninvehicle, var_a2ce7ad489be5c4f );
    }
    else
    {
        default_load( riders, spawninvehicle, var_a2ce7ad489be5c4f, group, goddriver );
    }
    
    vehicle_occupancy::update_occupancy( self );
}

// Namespace vehicle_ai
// Params 5
// Checksum 0x4cff29b1, Offset: 0x16c5
// Size: 0x5a7
function default_load( riders, spawninvehicle = 0, var_a2ce7ad489be5c4f, group, goddriver )
{
    thread function_c40dc2214ed65c47();
    vehicle_spawn::stop_watching_abandoned();
    vehicledata = vehicle::get_data( vehicle::get_ref() );
    turrets = [];
    
    foreach ( turret in vehicle::get_turrets( self ) )
    {
        turrets[ turrets.size ] = turret;
    }
    
    var_6b123f50138e1aa7 = 0;
    turretindexes = vehicle::get_vehicle_turret_indexes( self, 0 );
    utility::ent_flag_clear( "unloaded" );
    utility::ent_flag_clear( "loaded" );
    
    if ( !spawninvehicle )
    {
        thread function_f9ce24d8c6696807( riders );
    }
    
    foreach ( rider in riders )
    {
        if ( !( isdefined( rider ) && isdefined( rider._blackboard ) ) )
        {
            /#
                function_8ab2ea58d1b45623( rider );
            #/
            
            continue;
        }
        
        if ( getdvarint( @"hash_b8d9dce6bbc23e00", 0 ) )
        {
            thread vehicle_aianim::guy_runtovehicle( rider, self, goddriver, group, spawninvehicle );
        }
        else
        {
            availablepositionsstruct = vehicle_aianim::get_availablepositions( group );
            
            if ( isdefined( rider.spawner.script_startingposition ) && !isdefined( rider.script_startingposition ) )
            {
                rider.script_startingposition = int( rider.spawner.script_startingposition );
            }
            
            vehicle_aianim::function_c6605f39022b3372( rider );
            pos = vehicle_aianim::choose_vehicle_position( rider, availablepositionsstruct, goddriver );
            
            if ( !isdefined( pos.vehicle_position ) || !pos.origin || !pos.angles )
            {
                continue;
            }
            
            rider.vehicle_position = pos.vehicle_position;
            self.usedpositions[ pos.vehicle_position ] = 1;
            anim_pos = vehicle_aianim::anim_pos( self, pos.vehicle_position );
            seat_id = get_ai_rider_seat_id( self, pos.vehicle_position );
            vehicle_occupancy::function_4793dd4d02d6e68c( self, seat_id, 1 );
            
            if ( !spawninvehicle )
            {
                if ( !isdefined( self.runningtovehicle ) )
                {
                    self.runningtovehicle = [];
                }
                
                self.runningtovehicle[ self.runningtovehicle.size ] = rider;
            }
            
            thread load_vehicle_rider( rider, spawninvehicle, pos, anim_pos );
            thread handle_rider_death( rider, pos.vehicle_position, seat_id );
            
            if ( isdefined( anim_pos.bhasgunwhileriding ) && !anim_pos.bhasgunwhileriding )
            {
                rider ai::gun_remove();
            }
        }
        
        if ( isdefined( rider.team ) && pos.vehicle_position == 0 )
        {
            self.aidriver = rider;
            self.aidriver.fn_shoulddodamage = &function_2f06fac2aaf75236;
            
            if ( !var_a2ce7ad489be5c4f )
            {
                rider thread function_e848c7917f1d317f( self );
            }
            
            if ( !spawninvehicle )
            {
                thread watch_cancel_load( rider );
            }
            
            continue;
        }
        
        if ( isdefined( vehicledata.aiseats[ pos.vehicle_position ] ) && vehicledata.aiseats[ pos.vehicle_position ].mgturret )
        {
            if ( !vehicle_aianim::guy_should_man_turret( anim_pos ) )
            {
                continue;
            }
            
            if ( !isdefined( self.mgturret ) )
            {
                self.mgturret = [];
            }
            
            if ( isdefined( turretindexes[ var_6b123f50138e1aa7 ] ) )
            {
                turret = turrets[ self.mgturret.size ];
                
                if ( !isdefined( turret ) )
                {
                    assert( "<dev string:x19f>" + rider getentitynumber() + "<dev string:x1a3>" );
                    continue;
                }
                
                self.mgturret[ self.mgturret.size ] = turret;
                rider asm_bb::function_d97733fe1476f19e( self, turretindexes[ var_6b123f50138e1aa7 ] );
                var_6b123f50138e1aa7 += 1;
                turret = self;
            }
            else if ( turrets.size > 0 )
            {
                if ( !isdefined( self.mgturret ) )
                {
                    self.mgturret = [];
                }
                
                turret = turrets[ self.mgturret.size ];
                
                if ( !isdefined( turret ) )
                {
                    assert( "<dev string:x19f>" + rider getentitynumber() + "<dev string:x1a3>" );
                    continue;
                }
                
                self.mgturret[ self.mgturret.size ] = turret;
                
                if ( turret != self )
                {
                    turret setturretteam( rider.team );
                }
                
                rider asm_bb::bb_requestturret( turret );
            }
            else
            {
                assert( "<dev string:x19f>" + rider getentitynumber() + "<dev string:x1a3>" );
                continue;
            }
            
            rider thread function_bab770ab3241c7c9( self, turret );
        }
    }
    
    if ( spawninvehicle )
    {
        utility::ent_flag_set( "loaded" );
        self.loading = undefined;
        return;
    }
    
    self endon( #"death" );
    self endon( #"cancel_load" );
    utility::ent_flag_wait( "loaded" );
    self.loading = undefined;
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xe820009f, Offset: 0x1c74
// Size: 0x1e5
function function_c454ed4f0ef1a162( groupid )
{
    assert( function_1792af6a0c1cbb3e() );
    self.groupid = groupid;
    self.aidriver = undefined;
    self.snapshotriders = [];
    function_c505198907e0d306( self.groupid, self );
    
    /#
        if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
        {
            println( "<dev string:x145>" + self getentitynumber() + "<dev string:x240>" );
            
            foreach ( index, lw in self.lwriders )
            {
                println( "<dev string:x145>" + self getentitynumber() + "<dev string:x251>" + lw.dormancyid + "<dev string:x269>" + lw.groupid + "<dev string:x274>" + lw.seatnumber );
                
                foreach ( compareindex, comparelw in self.lwriders )
                {
                    if ( compareindex == index )
                    {
                        continue;
                    }
                    
                    assert( comparelw.dormancyid != lw.dormancyid && comparelw.seatnumber != lw.seatnumber, "<dev string:x280>" + self getentitynumber() );
                }
            }
        }
    #/
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xf9e8a311, Offset: 0x1e61
// Size: 0x13f
function function_1d6ebf1dfab6be72()
{
    assert( !function_1792af6a0c1cbb3e() );
    assert( self.groupid );
    function_28fe15d9e2bfab0d( self.groupid );
    self.groupid = undefined;
    self.lwriders = [];
    self.snapshotriders = function_46f9072493651dc9( self.riders );
    
    /#
        if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
        {
            println( "<dev string:x145>" + self getentitynumber() + "<dev string:x2b9>" );
            
            foreach ( rider in self.riders )
            {
                println( "<dev string:x145>" + self getentitynumber() + "<dev string:x2da>" + rider getentitynumber() + "<dev string:x2f1>" + rider._blackboard.var_25799974c1f2939b );
            }
        }
    #/
    
    waitframe();
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_aab734ba99c0b239" );
    }
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xc6d8c352, Offset: 0x1fa8
// Size: 0xdb
function function_69ae68e26a68c8c7( dormancyid )
{
    var_33e53a48b0a11443 = 0;
    
    foreach ( lwrider in self.lwriders )
    {
        if ( lwrider.dormancyid == dormancyid )
        {
            var_33e53a48b0a11443 = 1;
            self.lwriders = arrayremove( self.lwriders, lwrider );
            break;
        }
    }
    
    assert( var_33e53a48b0a11443, "<dev string:x300>" + dormancyid + "<dev string:x321>" + self getentitynumber() + "<dev string:x336>" );
}

// Namespace vehicle_ai
// Params 1, eflags: 0x4
// Checksum 0x4b4ffbed, Offset: 0x208b
// Size: 0x1ba
function private function_1fa2949c43e3887e( riders )
{
    assert( riders.size > 0 );
    groupid = riders[ 0 ].groupid;
    assert( isdefined( groupid ) );
    
    /#
        if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
        {
            println( "<dev string:x145>" + self getentitynumber() + "<dev string:x351>" );
        }
    #/
    
    function_1d512e821c4b2994( groupid, self, riders, 1 );
    
    foreach ( rider in riders )
    {
        infopackage = utility::callsharedfunc( #"ai_mp_controller", #"hash_cbe331215c7d5cdf", rider.dormancyid );
        infopackage.vehicle = self;
        infopackage.seatnumber = rider.seatnumber;
        infopackage.var_f60cb46dafea871e = rider.var_f60cb46dafea871e;
        infopackage.var_cef5d8d02e0c6afd = rider.var_cef5d8d02e0c6afd;
        
        if ( vehicle_interact::can_use( self ) )
        {
            self notify( #"ai_enter" );
            vehicle_occupancy::set_team( self, infopackage.team );
            vehicle_occupancy::turn_engine_on();
            vehicle_interact::allow_use( self, 0 );
        }
        
        utility::callsharedfunc( #"ai_mp_controller", #"hash_8bc70bcda391eb5b", rider.dormancyid, infopackage );
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0x4
// Checksum 0x9ab1cae7, Offset: 0x224d
// Size: 0x1c, Type: bool
function private is_dead_or_dying()
{
    return !isalive( self ) || vehicle::is_destroyed() || vehicle_damage::is_burning_down();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x4
// Checksum 0x61b7cf16, Offset: 0x2272
// Size: 0x29, Type: bool
function private is_loading_error( finishedloading )
{
    if ( function_1792af6a0c1cbb3e() )
    {
        return false;
    }
    
    return finishedloading && !utility::ent_flag( "loaded" );
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xd38470bd, Offset: 0x22a4
// Size: 0x30, Type: bool
function function_f110c60f8b3c5383()
{
    if ( function_1792af6a0c1cbb3e() )
    {
        return true;
    }
    
    aliveriders = function_46f9072493651dc9( self.snapshotriders ?? [] );
    return aliveriders.size > 0;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x5f5a645e, Offset: 0x22dd
// Size: 0x12d, Type: bool
function is_driver_alive()
{
    if ( function_1792af6a0c1cbb3e() )
    {
        foreach ( lwrider in self.lwriders )
        {
            if ( lwrider.seatnumber == 0 )
            {
                return true;
            }
        }
    }
    
    if ( isalive( self.aidriver ) )
    {
        return true;
    }
    
    foreach ( rider in self.riders )
    {
        if ( rider._blackboard.var_25799974c1f2939b == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xd891d4d0, Offset: 0x2413
// Size: 0x65, Type: bool
function function_d87f5ae34394bf32()
{
    if ( function_1792af6a0c1cbb3e() )
    {
        return false;
    }
    
    aliveriders = function_46f9072493651dc9( self.riders );
    return is_veh_loaded() && ( self.snapshotriders ?? [].size - aliveriders.size >= 1 || !self.aidriver || !isalive( self.aidriver ) );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x308b3f6, Offset: 0x2481
// Size: 0x27, Type: bool
function is_finished_loading( wasloading )
{
    return !is_dead_or_dying() && !self.loading && wasloading;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x829299de, Offset: 0x24b1
// Size: 0x3c, Type: bool
function is_veh_loaded()
{
    if ( function_1792af6a0c1cbb3e() )
    {
        return ( self.lwriders.size > 0 );
    }
    
    return !is_dead_or_dying() && utility::ent_flag( "loaded" ) && !self.unloading;
}

// Namespace vehicle_ai
// Params 3
// Checksum 0xc8014c73, Offset: 0x24f6
// Size: 0x125, Type: bool
function function_7fb2807eb0dcc527( wasloading, ispatrol, showdebug )
{
    var_63e2bb735f9d500e = is_dead_or_dying();
    finishedloading = is_finished_loading( wasloading );
    loadingerror = is_loading_error( finishedloading );
    var_e640e3dc30da2248 = !var_63e2bb735f9d500e && vehicle_occupancy::get_driver( self );
    var_6fc2c9a4c70e267 = ispatrol && !function_f110c60f8b3c5383() && !vehicle::is_tank();
    
    if ( var_63e2bb735f9d500e || loadingerror || var_e640e3dc30da2248 || ispatrol && ( self.pathcomplete || var_6fc2c9a4c70e267 || self.forcecancel ) )
    {
        /#
            if ( showdebug )
            {
                print3d( self.origin + ( 0, 0, 100 ), "<dev string:x373>" + ( var_63e2bb735f9d500e ? "<dev string:x387>" : loadingerror ? "<dev string:x3a4>" : "<dev string:x3be>" ), ( 1, 1, 1 ), 1, 2, 100 );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace vehicle_ai
// Params 3
// Checksum 0x6f12bf1a, Offset: 0x2624
// Size: 0x40
function function_cab68329f61e0ed7( groupid, dormancyid, seatnumber )
{
    return { #seatnumber:seatnumber, #groupid:groupid, #dormancyid:dormancyid };
}

// Namespace vehicle_ai
// Params 4
// Checksum 0x17de3834, Offset: 0x266d
// Size: 0x6b
function function_68ffea92fc8dafc5( groupid, dormancyid, vehicle, seatnumber )
{
    if ( isdefined( vehicle ) )
    {
        lwrider = function_cab68329f61e0ed7( groupid, dormancyid, seatnumber );
        vehicle.lwriders[ vehicle.lwriders.size ] = lwrider;
        vehicle function_c454ed4f0ef1a162( groupid );
        return lwrider;
    }
}

// Namespace vehicle_ai
// Params 4
// Checksum 0x6ce3e620, Offset: 0x26e0
// Size: 0x45
function function_1d512e821c4b2994( groupid, vehicle, dormantriders, isloading )
{
    if ( isdefined( vehicle ) )
    {
        vehicle.lwriders = dormantriders;
        vehicle function_c454ed4f0ef1a162( groupid );
    }
}

// Namespace vehicle_ai
// Params 4
// Checksum 0x84e6c08b, Offset: 0x272d
// Size: 0x218
function function_f25ee752204f9f8b( vehicle, seatnumber, agent, dormancyid )
{
    if ( isdefined( vehicle ) )
    {
        vehicle function_69ae68e26a68c8c7( dormancyid );
        agent.script_startingposition = seatnumber;
        
        /#
            if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
            {
                vehicle vehicle_aianim::function_c6605f39022b3372( agent );
                assert( agent.script_startingposition == seatnumber );
                
                foreach ( rider in vehicle.riders )
                {
                    assert( rider._blackboard.var_25799974c1f2939b != seatnumber );
                }
                
                assert( !vehicle.loading );
            }
        #/
        
        riders = [ agent ];
        vehicle load( riders, 1 );
        
        /#
            if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
            {
                var_ec14e078f810122f = 0;
                
                foreach ( var_be45558a534b7f7b in vehicle.riders )
                {
                    if ( var_be45558a534b7f7b == agent )
                    {
                        var_ec14e078f810122f = 1;
                        break;
                    }
                }
                
                assert( var_ec14e078f810122f );
                assert( agent._blackboard.var_25799974c1f2939b == seatnumber );
            }
        #/
        
        if ( !vehicle function_1792af6a0c1cbb3e() )
        {
            vehicle thread function_1d6ebf1dfab6be72();
        }
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0xc
// Checksum 0xec3d3259, Offset: 0x294d
// Size: 0xff
function private watch_cancel_load( driver )
{
    self notify( #"hash_807b969a9cf7877b" );
    self endon( #"hash_807b969a9cf7877b" );
    self endon( #"death" );
    self endon( #"ai_enter" );
    self endon( #"loaded" );
    utility::waittill_any_ents( self, "player_enter", driver, "death", self, "force_cancel_load" );
    
    foreach ( rider in self.runningtovehicle )
    {
        if ( rider._blackboard )
        {
            rider vehicle_common::cancelentervehicle();
        }
    }
    
    self.loading = undefined;
    self notify( #"cancel_load" );
}

// Namespace vehicle_ai
// Params 1, eflags: 0xc
// Checksum 0x3ed76ba, Offset: 0x2a54
// Size: 0x79
function private function_f9ce24d8c6696807( array )
{
    self notify( #"hash_2b313e5b0df69cbb" );
    self endon( #"hash_2b313e5b0df69cbb" );
    self endon( #"cancel_load" );
    self endon( #"death" );
    
    if ( array.size )
    {
        utility::array_wait( array, "loaded" );
    }
    
    if ( has_riders() )
    {
        utility::ent_flag_set( "loaded" );
        return;
    }
    
    self.loading = undefined;
    function_8ff9c3181d3164de();
}

// Namespace vehicle_ai
// Params 4, eflags: 0x4
// Checksum 0x84f57ae7, Offset: 0x2ad5
// Size: 0x47b
function private load_vehicle_rider( rider, spawninvehicle, pos, anim_pos )
{
    self endon( #"cancel_load" );
    self endon( #"death" );
    vehicle = self;
    
    if ( spawninvehicle )
    {
        rider thread vehicle_common::entervehicle( vehicle, spawninvehicle, pos, anim_pos );
        
        if ( vehicle_interact::can_use( self ) )
        {
            self notify( #"ai_enter" );
            vehicle_occupancy::set_team( self, rider.team );
            vehicle_occupancy::turn_engine_on();
            vehicle_interact::allow_use( self, 0 );
        }
        
        self.riders[ self.riders.size ] = rider;
        rider.ridingvehicle = self;
        rider.vehicle = self;
    }
    else
    {
        rider vehicle_common::requestentervehicle( vehicle, 0, pos, anim_pos );
        rider vehicle_common::waitforarrivedatvehicle();
        
        if ( !isalive( rider ) )
        {
            return;
        }
        
        if ( vehicle_interact::can_use( self ) )
        {
            self notify( #"ai_enter" );
            vehicle_occupancy::set_team( self, rider.team );
            vehicle_occupancy::turn_engine_on();
            vehicle_interact::allow_use( self, 0 );
        }
        
        self.riders[ self.riders.size ] = rider;
        rider.ridingvehicle = self;
        rider.vehicle = self;
        
        if ( isdefined( pos ) )
        {
            if ( isdefined( anim_pos.vehicle_getinanim_combat ) && ( rider isincombat() || !rider.stealth_enabled ) )
            {
                no_clear_anim = isdefined( rider.no_vehicle_getoutanim );
                
                if ( !no_clear_anim && !isagent( rider ) )
                {
                    if ( isdefined( anim_pos.vehicle_getoutanim ) )
                    {
                        vehicle clearanim( anim_pos.vehicle_getoutanim, 0 );
                    }
                    
                    if ( isdefined( anim_pos.vehicle_getoutanim_combat ) )
                    {
                        vehicle clearanim( anim_pos.vehicle_getoutanim_combat, 0 );
                    }
                    
                    if ( isdefined( anim_pos.vehicle_getoutanim_combat_run ) )
                    {
                        vehicle clearanim( anim_pos.vehicle_getoutanim_combat_run, 0 );
                    }
                }
                
                vehicle = vehicle vehicle_aianim::getanimatemodel();
                vehicle thread vehicle_aianim::setanimrestart_once( anim_pos.vehicle_getinanim_combat, anim_pos.vehicle_getinanim_clear );
                vehicle thread notetrack::start_notetrack_wait( vehicle, "vehicle_anim_flag", undefined, undefined, anim_pos.vehicle_getinanim_combat );
            }
            else if ( isdefined( anim_pos.vehicle_getinanim ) )
            {
                no_clear_anim = isdefined( rider.no_vehicle_getoutanim );
                
                if ( !no_clear_anim && !isagent( rider ) )
                {
                    if ( isdefined( anim_pos.vehicle_getoutanim ) )
                    {
                        vehicle clearanim( anim_pos.vehicle_getoutanim, 0 );
                    }
                    
                    if ( isdefined( anim_pos.vehicle_getoutanim_combat ) )
                    {
                        vehicle clearanim( anim_pos.vehicle_getoutanim_combat, 0 );
                    }
                    
                    if ( isdefined( anim_pos.vehicle_getoutanim_combat_run ) )
                    {
                        vehicle clearanim( anim_pos.vehicle_getoutanim_combat_run, 0 );
                    }
                }
                
                vehicle = vehicle vehicle_aianim::getanimatemodel();
                vehicle thread vehicle_aianim::setanimrestart_once( anim_pos.vehicle_getinanim, anim_pos.vehicle_getinanim_clear );
                vehicle thread notetrack::start_notetrack_wait( vehicle, "vehicle_anim_flag", undefined, undefined, anim_pos.vehicle_getinanim );
            }
            
            if ( isdefined( anim_pos.vehicle_getinsoundtag ) )
            {
                origin = vehicle gettagorigin( anim_pos.vehicle_getinsoundtag );
            }
            else
            {
                origin = vehicle.origin;
            }
            
            if ( isdefined( anim_pos.vehicle_getinsound ) )
            {
                playsoundatpos( origin, anim_pos.vehicle_getinsound );
            }
            
            getintags = undefined;
            getinthreads = undefined;
            
            if ( isdefined( anim_pos.getin_enteredvehicletrack ) )
            {
                getintags = [];
                getintags[ 0 ] = anim_pos.getin_enteredvehicletrack;
                getinthreads = [];
                getinthreads[ 0 ] = &vehicle_aianim::entered_vehicle_notify;
                vehicle vehicle_aianim::link_to_sittag( rider, anim_pos.sittag, anim_pos.sittag_origin_offset, anim_pos.sittag_angles_offset, anim_pos.linktoblend );
            }
        }
        
        rider vehicle_common::waitforentervehicle();
    }
    
    if ( isalive( rider ) )
    {
        self.runningtovehicle = arrayremove( self.runningtovehicle, rider );
        rider notify( #"enteredvehicle" );
        rider notify( #"loaded" );
        self notify( #"guy_entered", rider, pos );
        
        if ( isdefined( anim_pos.rider_func ) )
        {
            rider [[ anim_pos.rider_func ]]();
        }
    }
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xeb04f, Offset: 0x2f58
// Size: 0x5e
function function_8ff9c3181d3164de( driver_in_combat )
{
    if ( !vehicle_interact::can_use( self ) )
    {
        vehicle_interact::allow_use( self, 1 );
    }
    
    if ( !vehicle_occupancy::get_driver( self ) )
    {
        vehicle_occupancy::set_team( self, "neutral" );
        
        if ( driver_in_combat )
        {
            thread vehicle_spawn::function_dbc69ecc19a5dca3();
        }
        else
        {
            vehicle_occupancy::turn_engine_off();
        }
    }
    
    vehicle_occupancy::update_occupancy( self );
    thread vehicle_spawn::watch_abandoned();
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xaed7e58d, Offset: 0x2fbe
// Size: 0xd1
function function_22c7e9c2186e23fe( ref )
{
    if ( !vehicle::has_data( ref ) )
    {
        return;
    }
    
    aiseats = vehicle::get_data( ref ).aiseats;
    
    if ( !isdefined( aiseats ) )
    {
        return;
    }
    
    positions = [];
    
    foreach ( index, seat in aiseats )
    {
        if ( seat.setuprope )
        {
            positions[ positions.size ] = index;
        }
    }
    
    if ( positions.size > 0 )
    {
        return positions;
    }
}

// Namespace vehicle_ai
// Params 2
// Checksum 0xa67fd8ae, Offset: 0x3097
// Size: 0x70
function get_ai_rider_seat_id( vehicle, seatindex )
{
    ref = vehicle vehicle::get_ref();
    
    if ( !vehicle::has_data( ref ) )
    {
        return;
    }
    
    aiseats = vehicle::get_data( ref ).aiseats;
    
    if ( !isdefined( aiseats ) )
    {
        return;
    }
    
    if ( !isdefined( seatindex ) )
    {
        return;
    }
    
    return aiseats[ seatindex ].playerseatref;
}

// Namespace vehicle_ai
// Params 2
// Checksum 0x5c1dddc, Offset: 0x3110
// Size: 0x1a3
function function_b74a31eb8af242a0( vehicle, seatid )
{
    if ( !isdefined( vehicle.riders ) && !vehicle function_1792af6a0c1cbb3e() )
    {
        return;
    }
    
    ref = vehicle vehicle::get_ref();
    
    if ( !vehicle::has_data( ref ) )
    {
        return;
    }
    
    aiseats = vehicle::get_data( ref ).aiseats;
    
    if ( !isdefined( aiseats ) )
    {
        return;
    }
    
    foreach ( ai_rider in vehicle.riders )
    {
        if ( aiseats[ ai_rider.vehicle_position ].playerseatref == seatid )
        {
            return ai_rider;
        }
    }
    
    if ( vehicle function_1792af6a0c1cbb3e() )
    {
        foreach ( lwrider in vehicle.lwriders )
        {
            if ( aiseats[ lwrider.seatnumber ].playerseatref == seatid )
            {
                return lwrider;
            }
        }
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x7d523149, Offset: 0x32bb
// Size: 0x18, Type: bool
function has_riders()
{
    return self.riders.size > 0 || function_1792af6a0c1cbb3e();
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x8477a847, Offset: 0x32dc
// Size: 0xe, Type: bool
function function_1792af6a0c1cbb3e()
{
    return self.lwriders.size > 0;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x46d5b49f, Offset: 0x32f3
// Size: 0xc, Type: bool
function is_unloading()
{
    return istrue( self.unloading );
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x57115f38, Offset: 0x3308
// Size: 0xc, Type: bool
function is_loading()
{
    return istrue( self.loading );
}

// Namespace vehicle_ai
// Params 1, eflags: 0x4
// Checksum 0x3b745bda, Offset: 0x331d
// Size: 0x84
function private function_d83622d750c42d31( var_fd73840b5474c1dd )
{
    self endon( #"death" );
    stop_moving( var_fd73840b5474c1dd );
    
    if ( self.aidriver && isalive( self.aidriver ) )
    {
        self.unload_group = "driver";
        self.aidriver.vehicle_position = 0;
        vehicle_code::_vehicle_unload( "driver" );
    }
    
    self waittill( #"unloaded" );
    self.aidriver = undefined;
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x20eeed6c, Offset: 0x33a9
// Size: 0xe0
function stop_moving( var_fd73840b5474c1dd )
{
    if ( self hascomponent( "c2p" ) && self hascomponent( "path" ) )
    {
        self setconfigvalue( "path", "targetSpeed", 0 );
        self setconfigvalue( "path", "softConstSpeed", 0 );
    }
    else if ( self hascomponent( "path" ) )
    {
        self stoppath();
        
        if ( var_fd73840b5474c1dd )
        {
            self removecomponent( "path" );
        }
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self setconfigvalue( "p2p", "manualSpeed", 0 );
        self setconfigvalue( "p2p", "brakeAtGoal", 1 );
        self setconfigvalue( "p2p", "goalPoint", self.origin );
    }
    
    if ( !vehicle_occupancy::get_driver( self ) )
    {
        self vehicle_setspeedimmediate( 0, 1, 1 );
    }
    
    self vehicle_cleardrivingstate();
    
    if ( var_fd73840b5474c1dd )
    {
        thread function_457d6fa30f2ac4d6();
    }
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x5aaef043, Offset: 0x3491
// Size: 0x44
function get_unload_group( unloadgroup )
{
    if ( vehicle::ishelicopter() )
    {
        return ( unloadgroup ?? "default" );
    }
    
    return unloadgroup ?? level.gamemodebundle.defaultunloadgroup ?? "default";
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xf02224b6, Offset: 0x34dd
// Size: 0x2c, Type: bool
function get_exit_type( exittype )
{
    return exittype ?? level.gamemodebundle.var_c10a2e4c98f6857b ?? "default";
}

// Namespace vehicle_ai
// Params 0, eflags: 0x4
// Checksum 0x78c60f58, Offset: 0x3512
// Size: 0x52
function private function_a97e6600093ebc9c()
{
    self endon( #"death" );
    self endon( #"hash_aab734ba99c0b239" );
    
    while ( true )
    {
        if ( isdefined( self.var_92e4adcc3845b4d6 ) )
        {
            if ( gettime() - self.var_92e4adcc3845b4d6 > 20000 )
            {
                self.unloading = undefined;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace vehicle_ai
// Params 3
// Checksum 0x5609c6d1, Offset: 0x356c
// Size: 0x764
function unload( var_fd73840b5474c1dd, exittype, unloadgroup )
{
    self endon( #"death" );
    
    if ( is_unloading() )
    {
        return;
    }
    
    if ( !has_riders() )
    {
        stop_moving( var_fd73840b5474c1dd );
        function_8ff9c3181d3164de();
        utility::ent_flag_clear( "unloaded" );
        utility::ent_flag_clear( "loaded" );
        return;
    }
    
    self.unloading = 1;
    
    if ( !isdefined( var_fd73840b5474c1dd ) )
    {
        var_fd73840b5474c1dd = level.gamemodebundle.var_a6234436bb66db37 ?? 1;
    }
    
    exittype = get_exit_type( exittype );
    unloadgroup = get_unload_group( unloadgroup );
    callback::callback( #"vehicle_unloading", { #unloadgroup:unloadgroup, #exittype:exittype, #var_fd73840b5474c1dd:var_fd73840b5474c1dd } );
    
    if ( getdvarint( @"hash_4deba55716c47c46", 0 ) )
    {
        if ( function_1792af6a0c1cbb3e() )
        {
            assert( self.groupid );
            function_13ae1bd118194c0e( self.groupid, 20000 );
            self.var_92e4adcc3845b4d6 = gettime();
            thread function_a97e6600093ebc9c();
            
            /#
                if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
                {
                    println( "<dev string:x145>" + self getentitynumber() + "<dev string:x15b>" + self.groupid + "<dev string:x3ce>" + ( self.var_92e4adcc3845b4d6 ?? 0 ) + "<dev string:x420>" + gettime() );
                    
                    foreach ( lw in self.lwriders )
                    {
                        println( "<dev string:x145>" + self getentitynumber() + "<dev string:x42b>" + lw.dormancyid + "<dev string:x15b>" + self.groupid + "<dev string:x274>" + lw.seatnumber );
                    }
                }
            #/
            
            self waittill( #"hash_aab734ba99c0b239" );
            self.var_92e4adcc3845b4d6 = undefined;
        }
        
        foreach ( rider in self.riders )
        {
            if ( rider.var_4f8a92ebabf37ee )
            {
                rider.var_4f8a92ebabf37ee = 0;
                rider thread function_839272ea67669e14();
            }
            
            /#
                if ( getdvarint( @"hash_836e1ee4b3242cd2", 0 ) )
                {
                    println( "<dev string:x145>" + self getentitynumber() + "<dev string:x269>" + self.groupid + "<dev string:x43d>" + "<dev string:x449>" + rider getentitynumber() + "<dev string:x274>" + rider._blackboard.var_25799974c1f2939b );
                }
            #/
        }
    }
    
    function_bb1331c371ffbd55( self.riders );
    
    if ( unloadgroup != "moving" )
    {
        stop_moving( var_fd73840b5474c1dd );
    }
    
    riders = self.riders;
    utility::ent_flag_clear( "unloaded" );
    utility::ent_flag_clear( "loaded" );
    waitframe();
    childthread function_52baa3db61f989e8();
    
    if ( !vehicle_damage::is_burning_down() )
    {
        foreach ( rider in self.riders )
        {
            var_8480bf8db86cd1a5 = unloadgroup == "moving" && self.aidriver == rider;
            
            if ( !var_8480bf8db86cd1a5 && !vehicle_aianim::check_unloadgroup( rider.vehicle_position, unloadgroup ) )
            {
                continue;
            }
            
            if ( rider.stealth_enabled && exittype == "combat" || exittype == "combat_run" )
            {
                rider.stealth_idledemeanor = "combat";
                rider.var_b52fca22f7f1e144 = "combat";
            }
            
            if ( exittype == "combat_run" )
            {
                rider.qsetgoalpos = 1;
            }
            
            if ( !( isdefined( rider ) && isdefined( rider.asmname ) && isdefined( rider._blackboard ) && isdefined( rider._blackboard.chosenvehicleanimpos_sittag ) && isdefined( rider._blackboard.var_25799974c1f2939b ) && isdefined( rider._blackboard.currentvehicleanimalias ) ) )
            {
                continue;
            }
            
            animindex = archetypegetrandomalias( rider._blackboard.currentvehicleanimalias, "get_out_vehicle_combat", rider._blackboard.chosenvehicleanimpos_seatalias );
            
            if ( !isdefined( animindex ) )
            {
                continue;
            }
            
            xanim = animsetgetanimfromindex( rider._blackboard.currentvehicleanimalias, "get_out_vehicle_combat", animindex );
            
            if ( !isdefined( xanim ) )
            {
                continue;
            }
            
            targetorigin = rider getvehicleanimtargetorigin( self, xanim, rider._blackboard.chosenvehicleanimpos_sittag, self.origin, self.angles, 1 );
            
            if ( distance2dsquared( targetorigin, getclosestpointonnavmesh( targetorigin ) ) > 6400 )
            {
                rider.skipdeathcount = 1;
                rider kill();
            }
        }
    }
    
    driver_unloading = vehicle_aianim::check_unloadgroup( 0, unloadgroup );
    driver_in_combat = 0;
    
    if ( unloadgroup == "moving" )
    {
        driver_unloading = 1;
        utility::delaythreadendon( 2, "death", &function_d83622d750c42d31, var_fd73840b5474c1dd );
    }
    
    vehicle_code::_vehicle_unload( unloadgroup );
    
    if ( vehicle_aianim::riders_unloadable( unloadgroup ) )
    {
        self waittill( #"unloaded" );
    }
    
    if ( driver_unloading )
    {
        driver_in_combat = isagent( self.aidriver ) ? self.aidriver isincombat() : 0;
    }
    
    utility::self_func( "vehicleClearAnims" );
    
    foreach ( rider in riders )
    {
        if ( !rider || !isalive( rider ) )
        {
            continue;
        }
        
        rider.vehicle_position = undefined;
        rider.script_startingposition = undefined;
        
        if ( rider.spawner )
        {
            rider.spawner.script_startingposition = undefined;
        }
    }
    
    if ( driver_unloading )
    {
        function_8ff9c3181d3164de( driver_in_combat );
    }
    
    self.var_af753e654dc7fe6c = gettime();
    self.unloading = undefined;
}

/#

    // Namespace vehicle_ai
    // Params 1, eflags: 0x4
    // Checksum 0x842014a4, Offset: 0x3cd8
    // Size: 0xc0, Type: dev
    function private function_8ab2ea58d1b45623( rider )
    {
        if ( !isdefined( rider ) )
        {
            println( "<dev string:x459>" );
        }
        else if ( !isdefined( rider._blackboard ) )
        {
            println( "<dev string:x4ac>" );
        }
        
        if ( isdefined( rider ) && isdefined( rider.origin ) )
        {
            println( "<dev string:x512>" + rider.origin );
        }
        
        if ( isdefined( rider ) )
        {
            category = rider.category;
            subcategory = rider.subcategory;
            println( "<dev string:x540>" + ( category ?? "<dev string:x56f>" ) + "<dev string:x579>" + ( subcategory ?? "<dev string:x56f>" ) );
        }
    }

#/

// Namespace vehicle_ai
// Params 3
// Checksum 0x27935601, Offset: 0x3da0
// Size: 0x111
function handle_rider_death( rider, pos, seat_id )
{
    self endon( #"death" );
    self endon( #"cancel_load" );
    entnum = rider getentitynumber();
    rider utility::waittill_any( "death", "unloaded" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isalive( rider ) )
    {
        return;
    }
    
    self.riders = arrayremove( self.riders, rider );
    self.usedpositions[ pos ] = 0;
    
    if ( self.riders.size == 0 )
    {
        self.var_6df564a41f1630bd = gettime();
    }
    
    vehicle_occupancy::update_occupancy( self );
    
    if ( !isactor( rider ) || !seat_id )
    {
        return;
    }
    
    vehicle_occupancy::function_7730eb57fd31aeea( rider, self, seat_id, 1 );
    
    while ( rider && !isactorcorpse( rider ) )
    {
        waitframe();
    }
    
    corpse = getentbynum( entnum );
    
    if ( isactorcorpse( corpse ) )
    {
        vehicle_occupancy::function_7730eb57fd31aeea( corpse, self, seat_id, 1 );
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xacfe274b, Offset: 0x3eb9
// Size: 0x3a
function function_c40dc2214ed65c47()
{
    self notify( #"hash_be6acb9caa79b2b5" );
    self endon( #"hash_be6acb9caa79b2b5" );
    self endon( #"unloaded" );
    self waittill( #"death" );
    thread kill_riders();
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x14e0faf3, Offset: 0x3efb
// Size: 0xe1
function function_e848c7917f1d317f( vehicle )
{
    self notify( #"hash_73578836a000d492" );
    self endon( #"hash_73578836a000d492" );
    vehicle endon( #"unloaded" );
    vehicle endon( #"death" );
    vehicle endon( #"cancel_load" );
    self waittill( #"death" );
    
    if ( isalive( vehicle ) && isdefined( vehicle.var_ad452e0ccaa3b809 ) )
    {
        vehicle thread [[ vehicle.var_ad452e0ccaa3b809 ]]();
        return;
    }
    
    if ( vehicle.isheli )
    {
        if ( vehicle.var_5b7f931693e7743f )
        {
            vehicle thread vehicle::function_767d9021690bb2f3();
        }
        else
        {
            wait 1.5;
            vehicle thread vehicle::explode( undefined, 1 );
        }
        
        return;
    }
    
    if ( vehicle.unloadondriverdeath )
    {
        vehicle thread unload( undefined, "combat", "moving" );
    }
}

// Namespace vehicle_ai
// Params 2
// Checksum 0x6f1d0025, Offset: 0x3fe4
// Size: 0x51
function function_bab770ab3241c7c9( vehicle, turret )
{
    vehicle endon( #"death" );
    utility::waittill_any( "death", "unload" );
    
    if ( turret == vehicle )
    {
        vehicle.gunner = undefined;
        return;
    }
    
    turret vehicle_occupancy::reset_turret();
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xdab631f8, Offset: 0x403d
// Size: 0x12f
function function_bb1331c371ffbd55( riders )
{
    foreach ( rider in riders )
    {
        rider.qsetgoalpos = undefined;
        
        if ( isdefined( rider.og_nocorpse ) )
        {
            rider.nocorpse = rider.og_nocorpse;
        }
        else
        {
            rider.nocorpse = undefined;
        }
        
        if ( isdefined( rider.og_dropweapon ) )
        {
            rider.dropweapon = rider.og_dropweapon;
        }
        
        if ( isdefined( rider.var_6613071a5bd473f1 ) )
        {
            rider.dontdroploot = rider.var_6613071a5bd473f1;
        }
        
        if ( isdefined( rider.var_e0810b143e10d30 ) )
        {
            rider.drop_on_death_funcs = rider.var_e0810b143e10d30;
        }
        
        rider allowvehiclepredictiveragdoll( 1 );
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x541e385f, Offset: 0x4174
// Size: 0x2b, Type: bool
function is_driver_dead()
{
    return isdefined( self ) && isdefined( self.aidriver ) && self.aidriver.health < 1;
}

// Namespace vehicle_ai
// Params 5
// Checksum 0x77b2d619, Offset: 0x41a8
// Size: 0xb9, Type: bool
function function_2f06fac2aaf75236( idamage, smeansofdeath, sweapon, partname, damageloc )
{
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        if ( isdefined( self._blackboard.currentvehicle.healthbuffer ) )
        {
            if ( self._blackboard.currentvehicle.health - idamage < self._blackboard.currentvehicle.healthbuffer )
            {
                return true;
            }
        }
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_ai
// Params 6, eflags: 0x4
// Checksum 0xce39d242, Offset: 0x426a
// Size: 0xa2
function private getvehicleanimtargetorigin( vehicle, vehicleanim, vehicletag, vehiclelocation, vehicleangles, animendfrac )
{
    tagorigin = vehicle gettagorigin( vehicletag );
    tagangles = vehicle gettagangles( vehicletag );
    startorigin = getstartorigin( tagorigin, tagangles, vehicleanim );
    startangles = getstartangles( tagorigin, tagangles, vehicleanim );
    movedelta = getmovedelta( vehicleanim, 0, animendfrac );
    return rotatevector( movedelta, startangles ) + startorigin;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x4
// Checksum 0x5a55057f, Offset: 0x4315
// Size: 0x18
function private function_52baa3db61f989e8()
{
    while ( self vehicle_getspeed() > 0 )
    {
        waitframe();
    }
    
    self vehphys_parkingbrake( 1 );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x3b0b69ac, Offset: 0x4335
// Size: 0xd4
function set_parking_brake( bool = 1 )
{
    assert( vehicle::is_vehicle() );
    assert( self vehicle_isphysveh() );
    
    if ( bool )
    {
        if ( !isdefined( self.parkingbrake ) )
        {
            self.parkingbrake = 0;
        }
        
        self.parkingbrake += 1;
        
        if ( self.parkingbrake == 1 )
        {
            self vehphys_parkingbrake( 1 );
        }
        
        return;
    }
    
    if ( !isdefined( self.parkingbrake ) )
    {
        assert( isdefined( self.parkingbrake ), "<dev string:x58c>" );
        return;
    }
    
    self.parkingbrake -= 1;
    
    if ( self.parkingbrake <= 0 )
    {
        self.parkingbrake = undefined;
        self vehphys_parkingbrake( 0 );
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0xc
// Checksum 0x9db95068, Offset: 0x4411
// Size: 0x81
function private function_457d6fa30f2ac4d6()
{
    self notify( #"hash_73f4f664b96db8f" );
    self endon( #"hash_73f4f664b96db8f" );
    self endon( #"death" );
    function_21e8e13eca0023cd();
    
    if ( self hascomponent( "p2p" ) )
    {
        self removecomponent( "p2p" );
    }
    
    if ( self hascomponent( "c2p" ) )
    {
        self removecomponent( "c2p" );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self removecomponent( "path" );
    }
    
    self notify( #"removed_components" );
}

// Namespace vehicle_ai
// Params 0, eflags: 0x4
// Checksum 0x691579a4, Offset: 0x449a
// Size: 0x59
function private function_21e8e13eca0023cd()
{
    self endon( #"vehicle_owner_update" );
    
    if ( self hascomponent( "c2p" ) )
    {
        utility::ent_flag_wait_or_timeout( "unloaded", 3 );
        return;
    }
    
    starttime = gettime();
    
    while ( self vehicle_getspeed() > 0 && !utility::time_has_passed( starttime, 3 ) )
    {
        waitframe();
    }
}

// Namespace vehicle_ai
// Params 1
// Checksum 0x2258f097, Offset: 0x44fb
// Size: 0x115
function set_rider_values( riders )
{
    foreach ( rider in riders )
    {
        if ( isdefined( rider.dropweapon ) )
        {
            rider.og_dropweapon = rider.dropweapon;
        }
        
        rider.dropweapon = 0;
        
        if ( isdefined( rider.dontdroploot ) )
        {
            rider.var_6613071a5bd473f1 = rider.dontdroploot;
        }
        
        rider.dontdroploot = 1;
        
        if ( isdefined( rider.drop_on_death_funcs ) )
        {
            rider.var_bcc9f8d847f02a59 = rider.drop_on_death_funcs;
        }
        
        rider.drop_on_death_funcs = undefined;
        rider allowvehiclepredictiveragdoll( 0 );
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xc3108cce, Offset: 0x4618
// Size: 0x215
function kill_riders()
{
    if ( self.pilot_killed && !is_unloading() )
    {
        self waittill( #"flavor_done" );
    }
    
    foreach ( rider in self.riders )
    {
        if ( !isalive( rider ) )
        {
            continue;
        }
        
        if ( !isdefined( rider.ridingvehicle ) )
        {
            continue;
        }
        
        if ( isdefined( rider.magic_bullet_shield ) )
        {
            rider ai::stop_magic_bullet_shield();
        }
        
        if ( isdefined( rider._blackboard ) && isdefined( rider._blackboard.chosenvehicleanimpos ) && rider._blackboard.chosenvehicleanimpos_deathimpulse )
        {
            var_b6c01c45c70ed011 = 100;
            velocity = self vehicle_getvelocity();
            rider.do_immediate_ragdoll = 1;
            rider.ragdollhitloc = "torso_lower";
            rider.ragdollimpactvector = ( rider.origin - self.origin ) * var_b6c01c45c70ed011 + velocity;
        }
        
        rider kill();
    }
    
    if ( function_1792af6a0c1cbb3e() )
    {
        foreach ( lwrider in self.lwriders )
        {
            utility::callsharedfunc( #"ai_mp_controller", #"hash_6ecc3979ca9e3ce5", lwrider.dormancyid );
        }
    }
}

// Namespace vehicle_ai
// Params 2
// Checksum 0x9427bec2, Offset: 0x4835
// Size: 0x195
function function_9b3723ecd75f11e5( spawnhusk, damagedata )
{
    var_2f7d098653e1480d = spawnhusk && level.var_c533d12f2be6403 && !self.var_d683648f8c548dc;
    
    if ( isdefined( self.riders ) )
    {
        foreach ( rider in self.riders )
        {
            if ( isdefined( damagedata ) && isplayer( damagedata.attacker ) )
            {
                rider.vehiclekiller = damagedata.attacker;
                damagedata.attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"kill", damagedata.objweapon, undefined, undefined, rider, undefined, undefined, 1, undefined, 1 );
            }
            
            if ( isdefined( rider ) && var_2f7d098653e1480d )
            {
                rider.shouldburnfromdamage = 1;
                rider dodamage( rider.health, rider.origin, damagedata.attacker ?? self.burndownattacker, damagedata.inflictor, "MOD_FIRE", damagedata.objweapon, "torso_upper" );
            }
        }
    }
    
    if ( !var_2f7d098653e1480d )
    {
        delete_riders();
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x71d1c157, Offset: 0x49d2
// Size: 0x1fe
function delete_riders()
{
    if ( self.riders.size )
    {
        foreach ( rider in self.riders )
        {
            if ( !rider )
            {
                continue;
            }
            
            if ( isdefined( rider.magic_bullet_shield ) )
            {
                rider ai::stop_magic_bullet_shield();
            }
            
            if ( !utility::issp() && isai( rider ) )
            {
                if ( !isalive( rider ) )
                {
                    if ( utility::issharedfuncdefined( #"ai", #"getcorpseentity" ) )
                    {
                        body = rider utility::callsharedfunc( #"ai", #"getcorpseentity" );
                        
                        if ( isdefined( body ) && !isint( body ) )
                        {
                            body delete();
                        }
                    }
                }
                else
                {
                    rider.var_70fbc1727d54c322 = 1;
                    rider.diequietly = 1;
                    rider.nocorpse = 1;
                    rider.skipdeathcount = 1;
                    rider kill();
                }
                
                continue;
            }
            
            rider thread function_f5062356354a31c3();
        }
    }
    
    if ( function_1792af6a0c1cbb3e() )
    {
        foreach ( lwrider in self.lwriders )
        {
            utility::callsharedfunc( #"ai_mp_controller", #"hash_6ecc3979ca9e3ce5", lwrider.dormancyid );
        }
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0xc
// Checksum 0xe5a37e13, Offset: 0x4bd8
// Size: 0x29
function private function_f5062356354a31c3()
{
    self notify( #"hash_d029cf57bbfd499f" );
    self endon( #"hash_d029cf57bbfd499f" );
    waitframe();
    
    if ( isent( self ) )
    {
        self delete();
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x3aa58838, Offset: 0x4c09
// Size: 0x1a3
function function_b8676d1cc4fc666e()
{
    if ( self.follow_slots )
    {
        return;
    }
    
    if ( !isdefined( self.followers ) )
    {
        self.followers = [];
    }
    
    if ( !isdefined( self.follow_slots ) )
    {
        self.follow_slots = [];
    }
    
    foreach ( index, item in self.follow_slots_info )
    {
        org = isdefined( item.tag ) ? self gettagorigin( item.tag ) : self.origin;
        ang = isdefined( item.tag ) ? self gettagangles( item.tag ) : self.angles;
        spawn_loc = org + anglestoforward( ang ) * item.forward_offset + anglestoright( ang ) * item.right_offset;
        
        if ( isdefined( item.up_offset ) )
        {
            spawn_loc += ( 0, 0, item.up_offset );
        }
        
        follow_ent = utility::spawn_script_origin( spawn_loc, ang );
        follow_ent linkto( self );
        self.follow_slots[ index ] = follow_ent;
    }
    
    thread function_f75c19ede6756cd();
    
    /#
        thread function_57ef74b2cdde50ff();
    #/
}

// Namespace vehicle_ai
// Params 5
// Checksum 0xbd54a777, Offset: 0x4db4
// Size: 0xc1
function register_follow_slot( slot_name, tag, forward_offset, right_offset, up_offset )
{
    if ( !isdefined( self.follow_slots_info ) )
    {
        self.follow_slots_info = [];
    }
    
    self.follow_slots_info[ slot_name ] = spawnstruct();
    self.follow_slots_info[ slot_name ].tag = tag;
    self.follow_slots_info[ slot_name ].forward_offset = forward_offset ?? 0;
    self.follow_slots_info[ slot_name ].right_offset = right_offset ?? 0;
    self.follow_slots_info[ slot_name ].up_offset = up_offset;
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xcca485b, Offset: 0x4e7d
// Size: 0x158
function function_f75c19ede6756cd()
{
    self notify( #"hash_85fa17915df82196" );
    self endon( #"hash_85fa17915df82196" );
    utility::waittill_any( "death", "stop_all_following" );
    
    if ( self.followers.size )
    {
        guys = function_5713d46873b29625( self.followers );
        
        foreach ( guy in guys )
        {
            guy stop_following_vehicle();
        }
    }
    
    if ( self.follow_slots )
    {
        self.follow_slots = function_5713d46873b29625( self.follow_slots );
        
        foreach ( ent in self.follow_slots )
        {
            ent delete();
        }
    }
}

// Namespace vehicle_ai
// Params 4
// Checksum 0xf05bac62, Offset: 0x4fdd
// Size: 0x17f
function ai_follow_vehicle( vehicle, position, var_8df680064a563eab = 130, var_668d9282d70b2701 = 200 )
{
    if ( !vehicle.follow_slots )
    {
        return;
    }
    
    if ( position )
    {
        assert( isdefined( vehicle.follow_slots[ position ] ), "<dev string:x5d8>" + position );
        assert( !isalive( vehicle.follow_slots[ position ].ai ), "<dev string:x5f8>" + position );
    }
    
    foreach ( slotindex, slot in vehicle.follow_slots )
    {
        if ( position && slotindex != position )
        {
            continue;
        }
        
        if ( !slot.ai || !isalive( slot.ai ) )
        {
            slot.ai = self;
            self.following_ent = slot;
            break;
        }
    }
    
    if ( !self.following_ent )
    {
        /#
            iprintln( "<dev string:x61a>" );
        #/
        
        return;
    }
    
    childthread ai_follow_vehicle_movement( var_8df680064a563eab, var_668d9282d70b2701 );
}

// Namespace vehicle_ai
// Params 2
// Checksum 0x89d035af, Offset: 0x5164
// Size: 0x176
function ai_follow_vehicle_movement( var_8df680064a563eab, var_668d9282d70b2701 )
{
    self notify( #"hash_925f222a43b972f8" );
    self endon( #"hash_925f222a43b972f8" );
    self endon( #"death", #"stop_following_vehicle" );
    vehicle = self.following_ent getlinkedparent();
    
    if ( isdefined( self getgoalvolume() ) )
    {
        self cleargoalvolume();
    }
    
    self.goalradius = 10;
    self.disablearrivals = 1;
    self.disableexits = 1;
    self setgoalentity( self.following_ent, 1 );
    maxspeedextra = 15;
    
    for ( ;; )
    {
        speed = utility::mph_to_ips( abs( vehicle vehicle_getspeed() ) );
        
        if ( speed > var_668d9282d70b2701 )
        {
        }
        else
        {
            aispeed = clamp( speed, 23, 250 );
            
            if ( aispeed < 250 )
            {
                dist = int( distance2d( self.origin, self.following_ent.origin ) );
                
                if ( dist > var_8df680064a563eab && speed < 5 )
                {
                    speed = 250;
                }
                
                maxspeedextra = 250 - aispeed;
                dist_normalized = math::normalize_value( 150, 300, dist );
                speedextra = math::factor_value( 6, maxspeedextra, dist_normalized );
            }
            
            utility::set_movement_speed( aispeed + int( speedextra ) );
        }
        
        wait 0.15;
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x64436b6f, Offset: 0x52e2
// Size: 0x56
function stop_following_vehicle()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self notify( #"stop_following_vehicle" );
    self.following_ent.ai = undefined;
    self.following_ent = undefined;
    self.disablearrivals = 0;
    self.disableexits = 0;
    self cleargoalentity();
    utility::clear_movement_speed();
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xa20e9180, Offset: 0x5340
// Size: 0x96
function stop_all_following_vehicle()
{
    guys = utility::array_removedead_or_dying( get_vehicle_ai_followers() );
    
    foreach ( guy in guys )
    {
        guy stop_following_vehicle();
    }
    
    self notify( #"stop_all_following" );
}

// Namespace vehicle_ai
// Params 0
// Checksum 0x722cc841, Offset: 0x53de
// Size: 0xb
function kill_followers()
{
    remove_followers( 1 );
}

// Namespace vehicle_ai
// Params 1
// Checksum 0xabeb7a80, Offset: 0x53f1
// Size: 0xcd
function remove_followers( bkill = 0 )
{
    guys = utility::array_removedead_or_dying( get_vehicle_ai_followers() );
    
    foreach ( guy in guys )
    {
        if ( guy.magic_bullet_shield )
        {
            guy ai::stop_magic_bullet_shield();
        }
        
        if ( bkill )
        {
            guy kill( ( 0, 0, 0 ) );
            continue;
        }
        
        guy delete();
    }
}

// Namespace vehicle_ai
// Params 0
// Checksum 0xcfc929ce, Offset: 0x54c6
// Size: 0xbf
function get_vehicle_ai_followers()
{
    if ( !self.follow_slots )
    {
        return;
    }
    
    guys = [];
    
    foreach ( slot in self.follow_slots )
    {
        if ( slot.ai && isalive( slot.ai ) )
        {
            guys[ guys.size ] = slot.ai;
        }
    }
    
    return guys;
}

/#

    // Namespace vehicle_ai
    // Params 0
    // Checksum 0x594a7367, Offset: 0x558e
    // Size: 0x165, Type: dev
    function function_57ef74b2cdde50ff()
    {
        self endon( #"death" );
        self endon( #"stop_all_following" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_2a67f2406b1d6460" ) == 1 )
            {
                foreach ( slot in self.follow_slots )
                {
                    item_color = isdefined( slot.ai ) ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                    line( self.origin, slot.origin, ( 1, 1, 0 ) );
                    orientedbox( slot.origin, ( 8, 8, 8 ), slot.angles, item_color );
                    
                    if ( isdefined( slot.ai ) )
                    {
                        line( slot.ai.origin, slot.origin, item_color );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
