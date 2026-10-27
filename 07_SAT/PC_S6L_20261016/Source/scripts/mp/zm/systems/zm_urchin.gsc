// scripts\mp\zm\systems\zm_urchin.gsc  (hash_54eb46bab2fdca74.gscc) (size: 19440 Bytes / 0x4bf0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c2384c4 (2351137988)
// size ...... 19440 (0x4bf0)
// includes .. 15  (offset: 0x4848)
// strings ... 37  (offset: 0x48c0)
// dev strs .. 14  (offset: 0x4b34)
// exports ... 49  (offset: 0x2f44)
// cseg ...... 0x32e + 0x2c16 (0x2f44)
// imports ... 141 (offset: 0x36ec)
// animtree1 . 0   (offset: 0x4bf0)
// animtree2 . 0   (offset: 0x4bf0)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\damagefeedback;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_urchin;

// Namespace zm_urchin
// Params 0, eflags: 0x5
// Checksum 0x289e9ca0, Offset: 0x34c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_urchin", undefined, undefined, &post_init );
}

// Namespace zm_urchin
// Params 0
// Checksum 0x142052f5, Offset: 0x36d
// Size: 0x67
function post_init()
{
    if ( !getdvarint( @"enable_urchins", 1 ) )
    {
        return;
    }
    
    switch ( level.mapname )
    {
        case #"hash_d1e9cb99e049e058":
            level utility::flag_wait( "zm_sat_firefly_script_urchin_cs_completed" );
            break;
        case #"hash_416455efd904f83e":
            level utility::flag_wait( "zm_sat_feature_test_script_urchin_cs_completed" );
            break;
    }
    
    level init_urchin_data();
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x3f29b811, Offset: 0x3dc
// Size: 0x3a5
function private init_urchin_data()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zone_setup_finished" );
    level utility::flag_wait( "scriptables_ready" );
    level.zm_urchin = spawnstruct();
    level.zm_urchin.var_59940160f954ba22 = [];
    level.zm_urchin.a_all_zones = [];
    var_5d6db0bc7cd2b6d8 = getentitylessscriptablearray( "urchin_spawn", #targetname );
    var_27fcbf25c61c5e4 = [];
    
    foreach ( urchin_fx in var_5d6db0bc7cd2b6d8 )
    {
        struct = spawnstruct();
        struct.origin = urchin_fx.origin;
        struct.angles = urchin_fx.angles;
        struct.fx_sbl = urchin_fx;
        var_27fcbf25c61c5e4[ var_27fcbf25c61c5e4.size ] = struct;
    }
    
    utility::registersharedfunc( #"dark_flare", #"hash_d3bbf1093b70aec7", &function_c855b4c34a54c5c2 );
    level scriptable::scriptable_adddamagedcallback( &urchin_damaged );
    level thread function_1f946950fb613e80();
    
    if ( !isdefined( var_27fcbf25c61c5e4 ) )
    {
        return;
    }
    
    foreach ( s_urchin in var_27fcbf25c61c5e4 )
    {
        zone = zone_manager::function_90e5c3e2272b0130( s_urchin.origin );
        assert( isdefined( zone ), "<dev string:x24>" + s_urchin.origin + "<dev string:x42>" );
        
        if ( !isdefined( zone ) )
        {
            continue;
        }
        
        if ( !isdefined( level.zm_urchin.var_59940160f954ba22[ zone.script_zone_name ] ) )
        {
            var_ecac355e4beddb63 = spawnstruct();
            var_ecac355e4beddb63.zone_struct = zone;
            var_ecac355e4beddb63.var_27fcbf25c61c5e4 = [];
            var_ecac355e4beddb63.var_ab7b4c13d12ce7fa = [];
            var_ecac355e4beddb63.zone_group_name = s_urchin.target;
            level.zm_urchin.var_59940160f954ba22[ zone.script_zone_name ] = var_ecac355e4beddb63;
        }
        
        level.zm_urchin.var_59940160f954ba22[ zone.script_zone_name ].var_27fcbf25c61c5e4[ level.zm_urchin.var_59940160f954ba22[ zone.script_zone_name ].var_27fcbf25c61c5e4.size ] = s_urchin;
        level.zm_urchin.a_all_zones = arraycombineunique( level.zm_urchin.a_all_zones, [ zone ] );
    }
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x86>" );
        devgui::add_devgui_func( "<dev string:xa4>", "<dev string:xb6>", &function_d1841b9692f6066a );
        devgui::add_devgui_func( "<dev string:xce>", "<dev string:xe2>", &function_e2ed43b22237e72f );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x10e>", &debug_draw_urchins );
        devgui::function_77df7fe7dd273e10();
    #/
    
    level function_2063c790ff75ccbe();
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x11e81564, Offset: 0x789
// Size: 0x85
function private function_2063c790ff75ccbe()
{
    foreach ( group in level.zm_urchin.var_59940160f954ba22 )
    {
        group function_56074a06b2bfb793();
    }
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x884d7151, Offset: 0x816
// Size: 0x116
function private function_56074a06b2bfb793( b_spawn_all = 0 )
{
    level endon( #"game_ended" );
    
    if ( !b_spawn_all )
    {
        self.var_27fcbf25c61c5e4 = arrayrandomize( self.var_27fcbf25c61c5e4 );
        var_7693d3e8a3cd095d = function_1206601bc0dc7f32();
    }
    
    foreach ( index, struct in self.var_27fcbf25c61c5e4 )
    {
        if ( isdefined( var_7693d3e8a3cd095d ) )
        {
            if ( index >= var_7693d3e8a3cd095d )
            {
                break;
            }
        }
        
        if ( struct.urchin )
        {
            continue;
        }
        
        urchin = spawn_urchin( struct );
        self.var_ab7b4c13d12ce7fa[ self.var_ab7b4c13d12ce7fa.size ] = urchin;
        urchin thread urchin_manager();
    }
    
    thread function_8856185cd6c8a3d2();
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0xf3102a13, Offset: 0x934
// Size: 0x141
function private function_8856185cd6c8a3d2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"on_round_start" );
        self.var_ab7b4c13d12ce7fa = function_5713d46873b29625( self.var_ab7b4c13d12ce7fa );
        var_7693d3e8a3cd095d = function_1206601bc0dc7f32();
        
        if ( self.var_ab7b4c13d12ce7fa.size >= var_7693d3e8a3cd095d )
        {
            continue;
        }
        
        var_7693d3e8a3cd095d -= self.var_ab7b4c13d12ce7fa.size;
        self.var_27fcbf25c61c5e4 = arrayrandomize( self.var_27fcbf25c61c5e4 );
        
        foreach ( struct in self.var_27fcbf25c61c5e4 )
        {
            if ( var_7693d3e8a3cd095d <= 0 )
            {
                break;
            }
            
            if ( struct.urchin )
            {
                continue;
            }
            
            urchin = spawn_urchin( struct );
            self.var_ab7b4c13d12ce7fa[ self.var_ab7b4c13d12ce7fa.size ] = urchin;
            urchin thread urchin_manager();
            var_7693d3e8a3cd095d--;
        }
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0xb45daaa, Offset: 0xa7d
// Size: 0x5b
function private function_1206601bc0dc7f32()
{
    n_round = zm_utility::get_round_number();
    
    if ( n_round < 10 )
    {
        var_7693d3e8a3cd095d = randomintrange( 2, 4 );
    }
    else if ( n_round >= 10 && n_round < 25 )
    {
        var_7693d3e8a3cd095d = randomintrange( 3, 5 );
    }
    else
    {
        var_7693d3e8a3cd095d = randomintrange( 4, 6 );
    }
    
    return var_7693d3e8a3cd095d;
}

// Namespace zm_urchin
// Params 1
// Checksum 0x9e5bed95, Offset: 0xae1
// Size: 0x2f, Type: bool
function function_f87b050676de139f( player )
{
    if ( distancesquared( self.origin, player.origin ) < 18225 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_urchin
// Params 0
// Checksum 0xb8bfc485, Offset: 0xb19
// Size: 0x9
function function_2c2731ea2471aa6e()
{
    thread urchin_explode();
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x10525e2b, Offset: 0xb2a
// Size: 0x5f
function private spawn_urchin( struct )
{
    urchin = function_1ecf4d67f85c6909( struct );
    
    if ( level.players.size > 2 )
    {
        b_cluster = utility::percent_chance( 80 );
    }
    else
    {
        b_cluster = utility::percent_chance( 50 );
    }
    
    if ( b_cluster )
    {
        urchin function_2cc8ee0f9291103a();
    }
    
    return urchin;
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0xc999aebd, Offset: 0xb92
// Size: 0x11a
function private function_1ecf4d67f85c6909( struct )
{
    urchin_origin_offset = ( randomintrange( -2, 2 ), randomintrange( -2, 2 ), 0 );
    urchin = spawnscriptable( %"zm_sat_urchin_large", struct.origin + urchin_origin_offset, struct.angles );
    urchin.fn_damage_callback = &urchin_damaged;
    urchin scriptable::scriptable_addnotifycallback( "explo_complete", &function_7e2eb5a483c5552 );
    urchin.fx_sbl = struct.fx_sbl;
    urchin.health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_shade", zm_utility::get_round_number() );
    struct.urchin = urchin;
    utility::callsharedfunc( #"mutant_injection", #"hash_e7b746f6b1c554e2", urchin, &function_f87b050676de139f, &function_2c2731ea2471aa6e );
    urchin.var_12aadf5d8bbfdafd = createnavobstaclebybounds( urchin.origin, ( 20, 20, 75 ), urchin.angles );
    return urchin;
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x1bd82baa, Offset: 0xcb5
// Size: 0x71
function private function_2361717fcec55925()
{
    urchin = self;
    urchin.script_origin = urchin utility::spawn_script_origin();
    urchin.script_origin.team = "team_hundred_ninety";
    urchin.script_origin.parent = urchin;
    urchin.script_origin.targetname = "zm_urchin";
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0xd063dd97, Offset: 0xd2e
// Size: 0x1b9
function private function_2cc8ee0f9291103a()
{
    urchin = self;
    urchin.a_cluster = [];
    var_f75df51cb6f43691 = randomintrange( 1, 4 );
    a_s_clusters = utility::function_950fed9c7e18b522( urchin.origin + ( 0, 0, 0 ), 30, var_f75df51cb6f43691, 0, 10 );
    var_88dbcbcd973faf06 = ( 0, 0, 0 ) * -1;
    
    foreach ( s_cluster in a_s_clusters )
    {
        start_point = ( s_cluster[ 0 ], s_cluster[ 1 ], 0 );
        end_point = ( urchin.origin[ 0 ], urchin.origin[ 1 ], 0 );
        angles = vectortoangles( vectornormalize( end_point - start_point ) );
        var_25e5121dcacdffa4 = utility::drop_to_ground( s_cluster );
        
        if ( abs( urchin.origin[ 2 ] - var_25e5121dcacdffa4[ 2 ] ) >= 3 )
        {
            continue;
        }
        
        cluster_urchin = spawnscriptable( %"zm_sat_urchin_small", var_25e5121dcacdffa4 + var_88dbcbcd973faf06, angles );
        cluster_urchin scriptable::scriptable_addnotifycallback( "explo_complete", &function_7e2eb5a483c5552 );
        cluster_urchin.parent = urchin;
        urchin.a_cluster[ urchin.a_cluster.size ] = cluster_urchin;
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0xc
// Checksum 0xbd9cc34, Offset: 0xeef
// Size: 0xd3
function private cleanup_urchin_group()
{
    self notify( #"hash_bebae3aca9b3ee21" );
    self endon( #"hash_bebae3aca9b3ee21" );
    
    if ( getdvarint( @"hash_4b544e41f332b943", 0 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    
    foreach ( group in level.zm_urchin.var_59940160f954ba22 )
    {
        if ( group.zone_group_name == self.zone_group_name )
        {
            group thread function_aace67177413681b();
        }
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x67517bb3, Offset: 0xfca
// Size: 0x9d
function private function_aace67177413681b()
{
    level endon( #"game_ended" );
    self.var_ab7b4c13d12ce7fa = function_5713d46873b29625( self.var_ab7b4c13d12ce7fa );
    
    foreach ( urchin in self.var_ab7b4c13d12ce7fa )
    {
        urchin thread cleanup_urchin();
    }
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0xa7c1ad4c, Offset: 0x106f
// Size: 0x1c6
function private urchin_manager( var_216c9257adee2d2b = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"explo_triggered" );
    self endon( #"cleanup_urchin" );
    
    if ( var_216c9257adee2d2b )
    {
        thread move_urchin();
        
        foreach ( cluster_urchin in self.a_cluster )
        {
            cluster_urchin thread move_urchin();
        }
    }
    else
    {
        function_a7707d8792d9d945();
        self.origin += ( 0, 0, 0 );
        
        foreach ( cluster_urchin in self.a_cluster )
        {
            cluster_urchin.origin += ( 0, 0, 0 );
        }
    }
    
    if ( var_216c9257adee2d2b )
    {
        var_26e64b364924a968 = [ self ];
        var_26e64b364924a968 = arraycombine( var_26e64b364924a968, self.a_cluster );
        level utility::array_wait( var_26e64b364924a968, "urchin_move_done" );
    }
    
    utility::ent_flag_set( "active" );
    thread function_3b4d1b5cac7341f();
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x7dacb9ef, Offset: 0x123d
// Size: 0xf2
function private function_a7707d8792d9d945()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        var_745f79f43e093fb2 = 0;
        
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, self.origin ) <= 2000 && utility::within_fov( player geteye(), player.angles, self.origin, cos( 60 ) ) )
            {
                var_745f79f43e093fb2 = 1;
            }
        }
        
        if ( !var_745f79f43e093fb2 )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x4efb6069, Offset: 0x1337
// Size: 0x1e1
function private function_3b4d1b5cac7341f()
{
    self endon( #"death" );
    self endon( #"explo_triggered" );
    self endon( #"cleanup_urchin" );
    
    while ( true )
    {
        /#
            if ( level utility::flag( "<dev string:x10e>" ) )
            {
                utility::draw_circle( self.origin, 135 );
                utility::draw_circle( self.origin, 100 );
            }
        #/
        
        a_players = getplayersinradius( self.origin, 135 );
        
        if ( a_players.size > 0 )
        {
            thread urchin_explode( 1 );
            return;
        }
        
        var_add18175a5765096 = vehicle_getarrayinradius( self.origin, 300 );
        
        foreach ( veh in var_add18175a5765096 )
        {
            x1 = veh.origin[ 0 ];
            y1 = veh.origin[ 1 ];
            r1 = 150;
            x2 = self.origin[ 0 ];
            y2 = self.origin[ 1 ];
            r2 = 100;
            dx = x2 - x1;
            dy = y2 - y1;
            distsquared = dx * dx + dy * dy;
            var_23b9598a71332b79 = r1 + r2;
            var_dea5ebd9b6ed5eaa = var_23b9598a71332b79 * var_23b9598a71332b79;
            
            if ( distsquared <= var_dea5ebd9b6ed5eaa )
            {
                thread urchin_explode( 1 );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_urchin
// Params 2, eflags: 0xc
// Checksum 0x6962dbe, Offset: 0x1520
// Size: 0x200
function private move_urchin( b_down = 0, var_bce1ec06f19a819a = 0 )
{
    self notify( #"hash_d61d49e66e722be7" );
    self endon( #"hash_d61d49e66e722be7" );
    level endon( #"game_ended" );
    self endon( #"explo_triggered" );
    
    if ( isdefined( self.ent ) )
    {
        self.ent waittill( #"movedone" );
        utility::scriptable_clearparententity();
    }
    
    move_up_offset = 0;
    fx_sbl = self.fx_sbl;
    
    if ( self.type == %"zm_sat_urchin_small" )
    {
        move_up_offset = 0;
        
        if ( isdefined( self.parent ) )
        {
            self.parent endon( #"explo_triggered" );
            fx_sbl = self.parent.fx_sbl;
        }
    }
    
    self.ent = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self.ent thread utility::delete_on_notify( "movedone" );
    utility::scriptable_setparententity( self.ent );
    time = randomfloatrange( 1, 1 );
    
    if ( b_down )
    {
        self.ent moveto( self.origin + ( 0, 0, move_up_offset * -1 ), time );
    }
    else
    {
        fx_sbl setscriptablepartstate( "fx", "spawn_in" );
        self.ent moveto( self.origin + ( 0, 0, move_up_offset ), time );
    }
    
    self.ent waittill( #"movedone" );
    
    if ( !b_down )
    {
        fx_sbl utility::function_32b24db3127bff40( "fx", "idle" );
        self setscriptablepartstate( "fx", "idle" );
    }
    
    utility::scriptable_clearparententity();
    
    if ( var_bce1ec06f19a819a )
    {
        self freescriptable();
    }
    
    self notify( #"urchin_move_done" );
}

// Namespace zm_urchin
// Params 11, eflags: 0x4
// Checksum 0x61441c99, Offset: 0x1728
// Size: 0x23f
function private urchin_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_sat_urchin_large" && instance.type != %"zm_sat_urchin_small" )
    {
        return;
    }
    
    if ( isdefined( instance.parent ) )
    {
        urchin = instance.parent;
        var_1449e31cb856ccd2 = instance;
    }
    else
    {
        urchin = instance;
    }
    
    if ( !urchin utility::ent_flag( "active" ) && !urchin utility::ent_flag( "doing_warning_state" ) || urchin utility::ent_flag( "doing_force_explo" ) )
    {
        return;
    }
    
    damage = idamage;
    
    if ( einflictor vehicle::is_vehicle() )
    {
        e_driver = einflictor.owner;
        
        if ( e_driver )
        {
            eattacker = e_driver;
        }
        
        if ( !isplayer( eattacker ) )
        {
            eattacker = undefined;
        }
        
        urchin thread urchin_explode( undefined, eattacker, var_1449e31cb856ccd2 );
        return;
    }
    else if ( eattacker vehicle::is_vehicle() )
    {
        if ( isplayer( eattacker.occupants[ "gunner" ] ) )
        {
            eattacker = eattacker.occupants[ "gunner" ];
        }
        
        if ( !isplayer( eattacker ) && isplayer( eattacker.owner ) )
        {
            eattacker = eattacker.owner;
        }
        
        damage = urchin.health;
    }
    
    if ( isplayer( eattacker ) )
    {
        if ( isdefined( urchin.health ) )
        {
            eattacker damagefeedback::updatehitmarker( "standard", urchin.health <= 0, 0, 0, undefined );
            urchin.health -= damage;
            
            if ( urchin.health <= 0 || smeansofdeath == "MOD_EXPLOSIVE" )
            {
                urchin thread urchin_explode( undefined, eattacker, var_1449e31cb856ccd2 );
            }
        }
    }
}

// Namespace zm_urchin
// Params 4
// Checksum 0x1865f24f, Offset: 0x196f
// Size: 0x1d1
function urchin_explode( var_1d523d95b2bbdd93 = 0, player, var_1449e31cb856ccd2, b_skip_damage = 0 )
{
    if ( utility::ent_flag( "doing_force_explo" ) )
    {
        return;
    }
    
    function_2361717fcec55925();
    
    if ( isplayer( player ) )
    {
        self.script_origin.var_456d7e952c40ccba = player;
    }
    
    self notify( #"explo_triggered" );
    self notify( #"cleanup_urchin" );
    utility::ent_flag_clear( "active" );
    level endon( #"game_ended" );
    
    if ( var_1d523d95b2bbdd93 )
    {
        self endon( #"force_explo" );
        utility::ent_flag_set( "doing_warning_state" );
        self setscriptablepartstate( "fx", "explo_warning" );
        thread function_2b7a9b0ff4845242();
        self.fx_sbl setscriptablepartstate( "fx", "explo_warning" );
    }
    else
    {
        self notify( #"force_explo" );
        utility::ent_flag_set( "doing_force_explo" );
        self setscriptablepartstate( "fx", "explode" );
        self.fx_sbl setscriptablepartstate( "fx", "off" );
    }
    
    level function_aa969bfb2206e6a6( self, var_1d523d95b2bbdd93, var_1449e31cb856ccd2 );
    self waittill( #"explo_complete" );
    
    if ( var_1d523d95b2bbdd93 )
    {
        utility::ent_flag_clear( "doing_warning_state" );
        self.fx_sbl setscriptablepartstate( "fx", "off" );
    }
    
    if ( !b_skip_damage )
    {
        function_77cc51fc61d37d2b();
        function_99d9c94e18bcf00();
        function_d3766b618a755e77( player );
    }
    
    if ( self.script_origin )
    {
        self.script_origin delete();
    }
    
    if ( isdefined( self.var_12aadf5d8bbfdafd ) )
    {
        destroynavobstacle( self.var_12aadf5d8bbfdafd );
    }
    
    self notify( #"urchin_cleaned_up" );
    self freescriptable();
}

// Namespace zm_urchin
// Params 3, eflags: 0x4
// Checksum 0x69770ea3, Offset: 0x1b48
// Size: 0xc1
function private function_aa969bfb2206e6a6( urchin, var_1d523d95b2bbdd93, var_1449e31cb856ccd2 )
{
    a_cluster = urchin.a_cluster;
    
    if ( isdefined( var_1449e31cb856ccd2 ) )
    {
        var_1449e31cb856ccd2 thread function_ac9581bb21944071( 0, 1 );
        a_cluster = arrayremove( a_cluster, var_1449e31cb856ccd2 );
    }
    
    foreach ( cluster_urchin in a_cluster )
    {
        cluster_urchin thread function_ac9581bb21944071( var_1d523d95b2bbdd93 );
    }
}

// Namespace zm_urchin
// Params 2, eflags: 0x4
// Checksum 0x5b56a0c0, Offset: 0x1c11
// Size: 0x9f
function private function_ac9581bb21944071( var_1d523d95b2bbdd93, b_skip_wait = 0 )
{
    if ( var_1d523d95b2bbdd93 )
    {
        self.parent endon( #"force_explo" );
        
        if ( !b_skip_wait )
        {
            wait randomfloatrange( 0.05, 0.2 );
        }
        
        self setscriptablepartstate( "fx", "explo_warning" );
        thread function_2b7a9b0ff4845242( 1 );
    }
    else
    {
        if ( !b_skip_wait )
        {
            wait randomfloatrange( 0.05, 0.2 );
        }
        
        self setscriptablepartstate( "fx", "explode" );
    }
    
    self waittill( #"explo_complete" );
    self freescriptable();
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x19c43207, Offset: 0x1cb8
// Size: 0xbb
function private function_2b7a9b0ff4845242( b_cluster = 0 )
{
    self.ent = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self.ent thread utility::delete_on_notify( "movedone" );
    utility::scriptable_setparententity( self.ent );
    
    if ( b_cluster )
    {
        self.ent moveto( self.origin + ( 0, 0, 0 ), 0.7 );
        return;
    }
    
    self.ent moveto( self.origin + ( 0, 0, 0 ), 0.7 );
}

// Namespace zm_urchin
// Params 4, eflags: 0x4
// Checksum 0x996a555a, Offset: 0x1d7b
// Size: 0x35
function private function_7e2eb5a483c5552( instance, notif, param, var_64ffacba090c91be )
{
    waitframe();
    instance notify( #"explo_complete" );
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0xac4466d1, Offset: 0x1db8
// Size: 0xf0
function private function_77cc51fc61d37d2b()
{
    a_players = getplayersinradius( self.origin, 125 );
    level thread function_295ede2d3c98ccf0( a_players );
    
    foreach ( player in a_players )
    {
        if ( player vehicle::is_in_vehicle() )
        {
            continue;
        }
        
        n_damage = int( player.maxhealth * 0.5 );
        player dodamage( n_damage, self.origin, self, self.script_origin, "MOD_EXPLOSIVE" );
        player playrumbleonentity( "damage_heavy" );
        player thread function_3c76b1c9c8e0e4c1();
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0xc
// Checksum 0xe633b47, Offset: 0x1eb0
// Size: 0x5c
function private function_3c76b1c9c8e0e4c1()
{
    self notify( #"hash_33d954db6c4c9d5e" );
    self endon( #"hash_33d954db6c4c9d5e" );
    level endon( #"game_ended" );
    self endon( #"death" );
    val::set( "zm_urchin", "move_speed_scale", 0.6 );
    wait 2;
    val::reset( "zm_urchin", "move_speed_scale" );
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x74adf101, Offset: 0x1f14
// Size: 0x101
function private function_99d9c94e18bcf00()
{
    var_22f2ba557caf1adf = vehicle_getarrayinradius( self.origin, 260 );
    
    foreach ( veh in var_22f2ba557caf1adf )
    {
        if ( veh.var_b6a3f46ec4332fd8 )
        {
            n_damage = function_a5613c64156f81a2( veh );
            n_damage += 1;
            veh dodamage( n_damage, self.origin, self, self.script_origin, "MOD_EXPLOSIVE" );
            level thread function_faa18b586a796ced();
            continue;
        }
        
        veh dodamage( veh.maxhealth, self.origin, self, self.script_origin, "MOD_EXPLOSIVE" );
    }
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x6cdf0367, Offset: 0x201d
// Size: 0xab
function private function_a5613c64156f81a2( veh )
{
    if ( zm_utility::get_round_number() < 10 )
    {
        if ( veh.var_7493baa2cd62443 >= 3 )
        {
            n_damage = int( veh.maxhealth * 0.143 );
        }
        else
        {
            n_damage = int( veh.maxhealth * 0.2 );
        }
    }
    else if ( veh.var_7493baa2cd62443 >= 3 )
    {
        n_damage = int( veh.maxhealth * 0.167 );
    }
    else
    {
        n_damage = int( veh.maxhealth * 0.25 );
    }
    
    return n_damage;
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0xc3e87460, Offset: 0x20d1
// Size: 0xfa
function private function_d3766b618a755e77( player )
{
    a_ai = getaiarrayinradius( self.origin, 160 );
    
    foreach ( ai in a_ai )
    {
        if ( isdefined( ai.aicategory ) )
        {
            switch ( ai.aicategory )
            {
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                case #"hash_8c089e813083e510":
                    function_a6f89c8fbb6ff056( ai, player );
                    break;
                default:
                    function_c4b03902b80e5e4c( ai, player );
                    break;
            }
        }
    }
}

// Namespace zm_urchin
// Params 2, eflags: 0x4
// Checksum 0x75bcd393, Offset: 0x21d3
// Size: 0x8e
function private function_c4b03902b80e5e4c( zmb, player )
{
    if ( zmb.subclass == "zombie_shade" )
    {
        n_damage = zmb.maxhealth * 1 + 1;
    }
    else
    {
        n_damage = zmb.maxhealth * 0.5 + 1;
    }
    
    zmb dodamage( n_damage, self.origin, self, self.script_origin, "MOD_EXPLOSIVE" );
    level function_678e31043258fb0f( zmb, player, n_damage );
}

// Namespace zm_urchin
// Params 2, eflags: 0x4
// Checksum 0x9daccbcb, Offset: 0x2269
// Size: 0xad
function private function_a6f89c8fbb6ff056( zmb, player )
{
    zmb endon( #"death" );
    
    if ( zmb.aicategory == "hvt" )
    {
        n_damage = zmb.maxhealth * 0.08 + 1;
    }
    else
    {
        n_damage = zmb.maxhealth * 0.2 + 1;
    }
    
    zmb dodamage( n_damage, self.origin, self, self.script_origin, "MOD_EXPLOSIVE" );
    level function_678e31043258fb0f( zmb, player, n_damage );
    
    if ( isalive( zmb ) )
    {
        zmb thread function_82753cb11b9bee4();
    }
}

// Namespace zm_urchin
// Params 3, eflags: 0x4
// Checksum 0xe91dc9ce, Offset: 0x231e
// Size: 0x6b
function private function_678e31043258fb0f( zmb, player, n_damage )
{
    if ( isdefined( player ) )
    {
        if ( isalive( zmb ) )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( player, zmb, "none", "MOD_EXPLOSIVE", undefined, int( n_damage ), zmb gettagorigin( "j_head" ) );
            return;
        }
        
        level set_urchin_score_event( player, zmb.aicategory );
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0xc
// Checksum 0xafc8af9a, Offset: 0x2391
// Size: 0x45
function private function_82753cb11b9bee4()
{
    self notify( #"hash_7d3ec773c8babf2f" );
    self endon( #"hash_7d3ec773c8babf2f" );
    level endon( #"game_ended" );
    self endon( #"death" );
    effect_slow::slow( "zm_urchin", 0.5, 3 );
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x15c2f68d, Offset: 0x23de
// Size: 0x145
function private cleanup_urchin( b_force_explo = 0 )
{
    level endon( #"game_ended" );
    self notify( #"cleanup_urchin" );
    
    if ( utility::ent_flag( "doing_warning_state" ) || utility::ent_flag( "doing_force_explo" ) )
    {
        return;
    }
    
    utility::ent_flag_clear( "active" );
    
    if ( b_force_explo )
    {
        urchin_explode( 0, undefined, undefined, 1 );
    }
    else
    {
        self endon( #"force_explo" );
        self endon( #"explo_triggered" );
        function_a7707d8792d9d945();
        
        foreach ( cluster_urchin in self.a_cluster )
        {
            cluster_urchin freescriptable();
        }
        
        if ( isdefined( self.var_12aadf5d8bbfdafd ) )
        {
            destroynavobstacle( self.var_12aadf5d8bbfdafd );
        }
        
        self.fx_sbl setscriptablepartstate( "fx", "off" );
        self freescriptable();
    }
    
    self notify( #"urchin_cleaned_up" );
}

// Namespace zm_urchin
// Params 2, eflags: 0x4
// Checksum 0xef3adf41, Offset: 0x252b
// Size: 0xd5
function private set_urchin_score_event( player, str_ai_category )
{
    params = spawnstruct();
    
    if ( isdefined( str_ai_category ) )
    {
        switch ( str_ai_category )
        {
            case #"hash_8c089e813083e510":
                params.scoreevent = #"zombie_kia_urchin_special";
                break;
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
                params.scoreevent = #"zombie_kia_urchin_elite";
                break;
            default:
                params.scoreevent = #"zombie_kia_urchin";
                break;
        }
    }
    else
    {
        params.scoreevent = #"zombie_kia_urchin";
    }
    
    player callback::callback( "zombie_score_event", params );
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x74a984c9, Offset: 0x2608
// Size: 0xca
function private function_c855b4c34a54c5c2( potential_enemies )
{
    foreach ( enemy in potential_enemies )
    {
        if ( isdefined( enemy[ "scriptable" ] ) )
        {
            if ( enemy[ "scriptable" ].type == "zm_sat_urchin_large" || enemy[ "scriptable" ].type == "zm_sat_urchin_small" )
            {
                level urchin_damaged( self, self, enemy[ "scriptable" ], 50, undefined, undefined );
            }
        }
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x2133d90, Offset: 0x26da
// Size: 0x133
function private function_1f946950fb613e80()
{
    level.zm_urchin.var_1b0e224e8153b6da = utility::getstructarray( "urchin_spawn_boss", "targetname" );
    
    foreach ( s_urchin in level.zm_urchin.var_1b0e224e8153b6da )
    {
        s_urchin.fx_sbl = spawnscriptable( %"zm_sat_urchin_fx", s_urchin.origin, s_urchin.angles );
    }
    
    level.zm_urchin.var_19d825cfd72fc833 = [];
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x86>" );
        devgui::add_devgui_func( "<dev string:x121>", "<dev string:x138>", &function_9d7ec453676bb034 );
        devgui::add_devgui_func( "<dev string:x14f>", "<dev string:x168>", &function_f903fabf23d1463f );
        devgui::function_77df7fe7dd273e10();
    #/
    
    level utility::flag_set( "zm_urchin_boss_init_complete" );
}

// Namespace zm_urchin
// Params 1
// Checksum 0xfaad8ceb, Offset: 0x2815
// Size: 0x176
function function_9dcc3820f6db0b( num_to_spawn )
{
    assert( level.zm_urchin.var_1b0e224e8153b6da.size >= num_to_spawn, "<dev string:x181>" );
    level.zm_urchin.var_19d825cfd72fc833 = function_5713d46873b29625( level.zm_urchin.var_19d825cfd72fc833 );
    level.zm_urchin.var_1b0e224e8153b6da = arrayrandomize( level.zm_urchin.var_1b0e224e8153b6da );
    
    foreach ( struct in level.zm_urchin.var_1b0e224e8153b6da )
    {
        if ( level.zm_urchin.var_19d825cfd72fc833.size >= num_to_spawn )
        {
            break;
        }
        
        if ( struct.urchin )
        {
            continue;
        }
        
        urchin = spawn_urchin( struct );
        urchin thread urchin_manager( 1 );
        level.zm_urchin.var_19d825cfd72fc833[ level.zm_urchin.var_19d825cfd72fc833.size ] = urchin;
    }
}

// Namespace zm_urchin
// Params 0
// Checksum 0x76aac904, Offset: 0x2993
// Size: 0xb2
function function_f5d3679bd21a64b()
{
    level.zm_urchin.var_19d825cfd72fc833 = function_5713d46873b29625( level.zm_urchin.var_19d825cfd72fc833 );
    
    foreach ( urchin in level.zm_urchin.var_19d825cfd72fc833 )
    {
        urchin thread cleanup_urchin( 1 );
    }
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x31e3fb93, Offset: 0x2a4d
// Size: 0x1d
function private function_9d7ec453676bb034()
{
    function_9dcc3820f6db0b( level.zm_urchin.var_1b0e224e8153b6da.size );
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0x89e6079b, Offset: 0x2a72
// Size: 0x9
function private function_f903fabf23d1463f()
{
    function_f5d3679bd21a64b();
}

// Namespace zm_urchin
// Params 0, eflags: 0x4
// Checksum 0xc403532d, Offset: 0x2a83
// Size: 0xde
function private function_faa18b586a796ced()
{
    level endon( #"game_ended" );
    
    if ( !level.wonder_veh.tedd )
    {
        return;
    }
    
    if ( !level.wonder_veh.tedd.var_5467acb7ccb7bedb )
    {
        level.wonder_veh.tedd.var_5467acb7ccb7bedb = 0;
    }
    
    if ( level.wonder_veh.tedd.var_5467acb7ccb7bedb >= 4 )
    {
        return;
    }
    
    if ( utility::percent_chance( 25 ) )
    {
        level.wonder_veh utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_8d7e2e1f33fead57" );
        level.wonder_veh.tedd.var_5467acb7ccb7bedb++;
    }
}

// Namespace zm_urchin
// Params 1, eflags: 0x4
// Checksum 0x47584115, Offset: 0x2b69
// Size: 0x1c1
function private function_295ede2d3c98ccf0( a_players )
{
    level endon( #"game_ended" );
    
    if ( !player_banter::function_59ab3c2fe1424d34( #"hash_b8976a24968b7aa4" ) )
    {
        return;
    }
    
    var_db75d3de862ce072 = 0;
    
    foreach ( player in a_players )
    {
        if ( !isalive( player ) || player utility::ent_flag( "urchin_damage_first_time_vo" ) || !player namespace_c0b4f2882c9d100f::is_hero_operator() || player vehicle::is_in_vehicle() )
        {
            continue;
        }
        
        player utility::ent_flag_set( "urchin_damage_first_time_vo" );
        var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_b8976a24968b7aa4" );
        
        if ( var_db75d3de862ce072 )
        {
            return;
        }
    }
    
    if ( !var_db75d3de862ce072 )
    {
        a_players = arrayrandomize( a_players );
        
        foreach ( player in a_players )
        {
            if ( !isalive( player ) || player utility::ent_flag( "urchin_damage_first_time_vo" ) || player vehicle::is_in_vehicle() )
            {
                continue;
            }
            
            player utility::ent_flag_set( "urchin_damage_first_time_vo" );
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_b8976a24968b7aa4", #"bc_flavor_player_negative" );
            break;
        }
    }
}

/#

    // Namespace zm_urchin
    // Params 0, eflags: 0x4
    // Checksum 0x5372494a, Offset: 0x2d32
    // Size: 0x88, Type: dev
    function private function_d1841b9692f6066a()
    {
        foreach ( group in level.zm_urchin.var_59940160f954ba22 )
        {
            group function_bd5110a59752f2bc();
        }
    }

    // Namespace zm_urchin
    // Params 0, eflags: 0x4
    // Checksum 0x5fa9e442, Offset: 0x2dc2
    // Size: 0xb8, Type: dev
    function private function_bd5110a59752f2bc()
    {
        foreach ( struct in self.var_27fcbf25c61c5e4 )
        {
            if ( struct.urchin )
            {
                continue;
            }
            
            urchin = spawn_urchin( struct );
            self.var_ab7b4c13d12ce7fa[ self.var_ab7b4c13d12ce7fa.size ] = urchin;
            urchin thread urchin_manager();
        }
    }

    // Namespace zm_urchin
    // Params 0, eflags: 0x4
    // Checksum 0x23c669b0, Offset: 0x2e82
    // Size: 0x88, Type: dev
    function private function_e2ed43b22237e72f()
    {
        foreach ( group in level.zm_urchin.var_59940160f954ba22 )
        {
            group cleanup_urchin_group();
        }
    }

    // Namespace zm_urchin
    // Params 0, eflags: 0x4
    // Checksum 0x37e15c6e, Offset: 0x2f12
    // Size: 0x32, Type: dev
    function private debug_draw_urchins()
    {
        if ( !level utility::flag( "<dev string:x10e>" ) )
        {
            level utility::flag_set( "<dev string:x10e>" );
            return;
        }
        
        level utility::flag_clear( "<dev string:x10e>" );
    }

#/
