// scripts\mp\ob\supers\shadow_break.gsc  (hash_6d3c1ad56e1b625d.gscc) (size: 15533 Bytes / 0x3cad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64e8480e (1692944398)
// size ...... 15533 (0x3cad)
// includes .. 18  (offset: 0x3a75)
// strings ... 22  (offset: 0x3b05)
// dev strs .. 6   (offset: 0x3c65)
// exports ... 44  (offset: 0x2365)
// cseg ...... 0x207 + 0x215e (0x2365)
// imports ... 140 (offset: 0x2a45)
// animtree1 . 0   (offset: 0x3cad)
// animtree2 . 0   (offset: 0x3cad)
#using script_16ea1b94f0f381b3;
#using script_64704521879e3d88;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;

#namespace shadow_break;

// Namespace shadow_break
// Params 0, eflags: 0x5
// Checksum 0x6719cbd, Offset: 0x225
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x660eda33, Offset: 0x245
// Size: 0xe3
function private register( params )
{
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_shadow_break" );
    
    if ( !super_bundle )
    {
        return;
    }
    
    level callback::add( #"on_ai_killed", &function_169d1ccb4f276163 );
    level callback::add( #"player_death", &function_169d1ccb4f276163 );
    vfx_used = [ "shadow_break_dot_damage_hit":super_bundle.var_760fb430bcfde58e, "shadow_break_special_impact_fx":super_bundle.var_c71aca4d7c07cae3, "shadow_break_teleport_trail":super_bundle.var_3f79173a34ea6faa, "shadow_break_warp_air_fx":super_bundle.var_13a8d5204da27653, "shadow_break_warp_ground_fx":super_bundle.var_3f026a0850bf565c ];
    shadow_rift_common::load_fx( vfx_used );
    supers_mp::function_48aaa60b2ce7b8a1( "super_shadow_break", undefined, undefined, &begin_use, &end_use );
    disconnect_event_aggregator::function_f460203966e88ab0( &function_afb772a4db682a6c );
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x43597fdc, Offset: 0x330
// Size: 0xc
function private function_afb772a4db682a6c( player )
{
    
}

// Namespace shadow_break
// Params 0, eflags: 0x4
// Checksum 0xa7c1bbd0, Offset: 0x344
// Size: 0x1ff, Type: bool
function private begin_use()
{
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_shadow_break" );
    assert( isdefined( super_bundle ), "<dev string:x24>" );
    
    if ( !can_use_super() )
    {
        return false;
    }
    
    super_weapon = namespace_9d8e359c3b1041e5::getsuperweaponsharedfunc( "super_shadow_break" );
    effect_origin = get_vortex_spawn_position( super_bundle, self.origin );
    
    if ( !effect_origin )
    {
        return false;
    }
    
    shadow_rift_data = function_7d4cbec6461c98d();
    vortex_pull_data = utility::callsharedfunc( "super_shadow_break", #"hash_fdc83a83ca08d8d0" );
    spawn_shadowbreak( shadow_rift_data, super_bundle, effect_origin, super_weapon, vortex_pull_data );
    effect_duration_ms = super_bundle.usetime * 1000;
    
    /#
        if ( getdvarint( @"scr_shadow_break_draw_debug", 0 ) )
        {
            sphere( effect_origin, get_effect_radius( super_bundle ), ( 1, 0, 0 ), 1, int( effect_duration_ms * 0.001 / level.framedurationseconds ) );
        }
    #/
    
    function_6af07300f43fb5da( super_bundle, effect_duration_ms, effect_origin, super_weapon, shadow_rift_data );
    thread function_43b6168dd9e55c19( effect_origin, get_effect_radius( super_bundle ) );
    
    if ( super_bundle.var_9113ee8655ab2e8f.var_dc024082f1dcc55 )
    {
        var_2ab9ed5f59c446f4 = hud_util::function_cd054751d2d5b5c5( super_bundle.var_9113ee8655ab2e8f.var_dc024082f1dcc55 );
        var_2ab9ed5f59c446f4 thread hud_util::function_d69ae82e9a4716aa( self, super_bundle.var_9113ee8655ab2e8f.var_6d4142ef4a0d61ff ?? 0, super_bundle.var_9113ee8655ab2e8f.showduration ?? 0, super_bundle.var_9113ee8655ab2e8f.fadeoutduration ?? 0, 1 );
    }
    
    if ( super_bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    return true;
}

// Namespace shadow_break
// Params 0, eflags: 0x4
// Checksum 0x2c94f0af, Offset: 0x54c
// Size: 0xf, Type: bool
function private can_use_super()
{
    if ( !self isonground() )
    {
        return false;
    }
    
    return true;
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0xd6cca9ae, Offset: 0x564
// Size: 0x3e
function private cancel( params )
{
    assert( self.var_835d0ded06aa3f49, "<dev string:x80>" );
    self.var_835d0ded06aa3f49 shadow_rift_common::function_69287c66c1bbed9b();
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x12b8d05d, Offset: 0x5aa
// Size: 0x44
function private function_f51f8817f81e3689( super_bundle )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_f69199bb7f53cef8 = super_bundle.var_8ae79b73be63644c;
    
    if ( var_f69199bb7f53cef8 )
    {
        self setscriptablepartstate( var_f69199bb7f53cef8, #"off", 0 );
    }
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x682f38e7, Offset: 0x5f6
// Size: 0x4c
function private function_666e9effcbd58be0( super_bundle )
{
    var_f69199bb7f53cef8 = super_bundle.var_8ae79b73be63644c;
    player_state_activation = super_bundle.var_788285949dd3c600;
    
    if ( var_f69199bb7f53cef8 && player_state_activation )
    {
        self setscriptablepartstate( var_f69199bb7f53cef8, player_state_activation );
    }
}

// Namespace shadow_break
// Params 5, eflags: 0x4
// Checksum 0x66ff90ef, Offset: 0x64a
// Size: 0xe1
function private spawn_shadowbreak( shadow_rift_data, super_bundle, origin, super_weapon, vortex_pull_data )
{
    assert( !self.var_835d0ded06aa3f49, "<dev string:xd8>" );
    self.var_835d0ded06aa3f49 = shadow_rift_common::function_259eadb8cbb1422f( origin, ( 0, 0, 0 ), self, 0, 0, 0, 0, super_weapon, undefined, shadow_rift_data );
    function_666e9effcbd58be0( super_bundle );
    interaction_data = utility::callsharedfunc( "super_shadow_break", #"hash_a180efbdefec2fb5" );
    
    if ( interaction_data )
    {
        if ( function_ffc3fd87196b69b3() )
        {
            thread function_cab5585ec0a4cfe1( interaction_data, self.var_835d0ded06aa3f49, super_bundle );
        }
        else
        {
            register_interact_vortex( interaction_data, self.var_835d0ded06aa3f49 );
        }
    }
    
    if ( vortex_pull_data )
    {
        function_457571f05301cfe8( vortex_pull_data, origin, super_weapon, super_bundle );
    }
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0xfde3dc48, Offset: 0x733
// Size: 0x11d
function private register_interact_vortex( interaction_data, vortex_data )
{
    vortex_scriptable = vortex_data.vortex;
    assert( vortex_scriptable );
    vortex_scriptable.owner = self;
    vortex_scriptable.interact_teleport = function_7af9daf4e3e7f7f2( interaction_data );
    vortex_scriptable setscriptablepartstate( #"interact", #"usable" );
    vortex_scriptable function_7653c765b6c7b815();
    squadmates = squad_utility::getsquadmembers( self.team, 1 );
    
    foreach ( player in squadmates )
    {
        vortex_scriptable enablescriptableplayeruse( player );
    }
    
    interaction::register_scriptable_interact( vortex_scriptable, &interact_vortex );
    vortex_data.interaction = 1;
}

// Namespace shadow_break
// Params 0, eflags: 0x4
// Checksum 0x67e21dc2, Offset: 0x858
// Size: 0x22, Type: bool
function private function_ffc3fd87196b69b3()
{
    dvar_value = getdvarint( @"hash_20156213e16e62cf", 1 );
    return dvar_value == 1;
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0x7d724f0, Offset: 0x883
// Size: 0x1b7
function private function_cab5585ec0a4cfe1( interaction_data, vortex_data, super_bundle )
{
    vortex_scriptable = vortex_data.vortex;
    assert( vortex_scriptable );
    vortex_scriptable.owner = self;
    vortex_scriptable.interact_teleport = function_7af9daf4e3e7f7f2( interaction_data );
    distance = interaction_data.var_abe7fba23e36da55;
    height = interaction_data.var_b253ab2de9e9a305;
    assert( distance > 0, "<dev string:x13e>" );
    assert( height > 0, "<dev string:x188>" );
    vortex_scriptable.trigger = spawn( "trigger_radius", vortex_data.origin, 0, distance, height );
    vortex_data.interaction = 1;
    
    /#
        duration = super_bundle.usetime;
        cylinder( vortex_data.origin, vortex_data.origin + ( 0, 0, height ), distance, ( 1, 0, 0 ), 1, int( duration / level.framedurationseconds ) );
    #/
    
    payload = { #vortex_scriptable:vortex_scriptable, #owner:self };
    trigger::makeenterexittrigger( vortex_scriptable.trigger, &on_trigger_enter, undefined, undefined, undefined, &trigger_filter, payload );
    var_af5c76996dfbf298 = interaction_data.var_97657c3f9690ba18;
    overridepartname = interaction_data.var_42308b4598c33164;
    
    if ( var_af5c76996dfbf298 && overridepartname )
    {
        vortex_scriptable setscriptablepartstate( overridepartname, var_af5c76996dfbf298 );
    }
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0xa05b42b7, Offset: 0xa42
// Size: 0x64, Type: bool
function private trigger_filter( ent, trigger, payload )
{
    if ( !isplayer( ent ) )
    {
        return true;
    }
    
    owner = payload.owner;
    
    if ( !squad_utility::function_6a77a8d0f8eb25b5( owner, ent ) )
    {
        return true;
    }
    
    if ( ent.is_shadow_break_teleporting )
    {
        return true;
    }
    
    return false;
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0x9fa015e8, Offset: 0xaaf
// Size: 0x3f
function private on_trigger_enter( ent, trigger, payload )
{
    vortex_scriptable = payload.vortex_scriptable;
    vortex_scriptable thread interact_vortex( ent );
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0xc80d5dbb, Offset: 0xaf6
// Size: 0xd5
function private function_7af9daf4e3e7f7f2( interaction_data )
{
    return { #fx:{ #var_ef70ce6b97d70fdb:interaction_data.var_e563b07b0abdc68e, #var_e50e4b0f3f98ae80:interaction_data.var_98bbc540a20bdef3, #partname:interaction_data.scriptablepartname }, #fov:{ #var_df98c2109d367f6c:interaction_data.var_19abb9f9fe11422d, #var_ade6b2dc8efaaef:interaction_data.var_4e6445fce7deec45, #var_982f049e655990c9:interaction_data.var_f05410d0a0682850, #var_f2f22d9149e9fd5c:interaction_data.var_711385a67f4f5a30 }, #delay:interaction_data.teleportdelay, #height:interaction_data.teleportheight };
}

// Namespace shadow_break
// Params 0, eflags: 0x4
// Checksum 0xd46e61a0, Offset: 0xbd4
// Size: 0x69
function private function_2be557503ba4a710()
{
    vortex_scriptable = self.var_835d0ded06aa3f49.vortex;
    assert( vortex_scriptable );
    vortex_scriptable setscriptablepartstate( #"interact", #"unusable" );
    vortex_scriptable function_7653c765b6c7b815();
    
    if ( vortex_scriptable.trigger )
    {
        vortex_scriptable.trigger delete();
    }
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x40104d4b, Offset: 0xc45
// Size: 0x1cf
function private interact_vortex( player )
{
    vortex = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( vortex.owner ) )
    {
        return;
    }
    
    if ( player.is_shadow_break_teleporting )
    {
        return;
    }
    
    teleport_height = vortex.interact_teleport.height;
    teleport_position = self.origin + ( 0, 0, teleport_height );
    contents = physics_createcontents( [ "physicscontents_playerclip" ] );
    hitresult = physics_raycast( self.origin, teleport_position, contents, undefined, 0, "physicsquery_all" );
    
    if ( hitresult.size > 0 )
    {
        function_9b0065d6803f0742( player, &"hash_d4b2cd6a21eea6a" );
        return;
    }
    
    vfx_config = vortex.interact_teleport.fx;
    
    if ( vfx_config.partname && vfx_config.var_e50e4b0f3f98ae80 )
    {
        player setscriptablepartstate( vfx_config.partname, vfx_config.var_e50e4b0f3f98ae80 );
    }
    
    player thread function_9acbc1d2dc914b5c( vortex.interact_teleport );
    player.is_shadow_break_teleporting = 1;
    teleport_delay = vortex.interact_teleport.delay;
    
    if ( teleport_delay )
    {
        wait teleport_delay;
    }
    
    player setorigin( teleport_position );
    player skydive_setdeploymentstatus( 1 );
    player skydive_deployparachute();
    
    if ( vfx_config.partname && vfx_config.var_ef70ce6b97d70fdb )
    {
        player setscriptablepartstate( vfx_config.partname, vfx_config.var_ef70ce6b97d70fdb );
    }
    
    player.is_shadow_break_teleporting = 0;
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x9c28baf5, Offset: 0xe1c
// Size: 0xdd
function private function_9acbc1d2dc914b5c( teleport_config )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    fov = teleport_config.fov;
    delay = teleport_config.delay;
    
    if ( !fov || !delay )
    {
        return;
    }
    
    fov_before = getdvarfloat( @"cg_targetbasefov", 65 );
    self lerpfov( fov.var_ade6b2dc8efaaef, fov.var_df98c2109d367f6c );
    wait fov.var_df98c2109d367f6c;
    self lerpfov( fov.var_f2f22d9149e9fd5c, fov.var_982f049e655990c9 );
    wait delay - fov.var_df98c2109d367f6c;
    self lerpfov( fov_before, fov.var_982f049e655990c9 );
}

// Namespace shadow_break
// Params 4, eflags: 0x4
// Checksum 0x157da6d7, Offset: 0xf01
// Size: 0x103
function private function_457571f05301cfe8( vortex_pull_data, effect_origin, super_weapon, super_bundle )
{
    vortex_data = { #vortexdamagetype:super_bundle.shadowbreakdamagetype ?? "MOD_UNKNOWN", #var_80d8746f96740494:vortex_pull_data.var_e71d288804f74563, #var_9fda953f6a78a6e9:vortex_pull_data.var_afa1292b0d50210a, #vortexid:"super_shadow_break", #var_2a910b69b3bb40ff:&ai_utility::get_power_tier, #var_1e10035c05af2275:vortex_pull_data.var_d96a6d2b1d7ef957, #var_8c067c10e669edaa:vortex_pull_data.max_targets_pulled, #black_hole_pull_radius:vortex_pull_data.radius, #vortexduration:super_bundle.usetime };
    level thread shadow_rift_common::function_3eadf2eaa292354( self, effect_origin, ( 0, 0, 0 ), undefined, undefined, vortex_data, super_weapon, undefined, undefined );
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x3b07ae14, Offset: 0x100c
// Size: 0x34, Type: bool
function private function_e97aed70b407e912( evaluated_player )
{
    return utility::callsharedfunc( #"player", #"playersareenemies", self, evaluated_player ) && !evaluated_player vehicle::is_in_vehicle();
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x54c85a9, Offset: 0x1049
// Size: 0x52, Type: bool
function private function_c5d95ddef4b880e1( evaluated_ai )
{
    return utility::callsharedfunc( #"player", #"playersareenemies", self, evaluated_ai ) && !evaluated_ai.ridingvehicle && !evaluated_ai.immune && !zombie_utils::function_bf1464d09f4e4b40();
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0x51432bfa, Offset: 0x10a4
// Size: 0x1c
function private get_close_ai( origin, radius )
{
    return getaiarrayinradius( origin, radius );
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0xe0aa65c3, Offset: 0x10c9
// Size: 0x1c
function private get_close_players( origin, radius )
{
    return getplayersinradius( origin, radius );
}

// Namespace shadow_break
// Params 5, eflags: 0x4
// Checksum 0x1b8440c3, Offset: 0x10ee
// Size: 0xf3
function private function_6af07300f43fb5da( super_bundle, duration_ms, origin, weapon, shadow_rift_data )
{
    if ( !isdefined( self.var_4b2c92a85825c7a7 ) )
    {
        self.var_4b2c92a85825c7a7 = [];
    }
    
    var_dbf68f32b2274fb5 = utility::callsharedfunc( "super_shadow_break", #"hash_ad810e4e9a8ee69b" ) ?? 1;
    thread function_2ab1a1919426d5ce( super_bundle, duration_ms, origin, super_bundle.var_4141b4bb7f3a7ad3, super_bundle.var_81901bf3795ecbbb, weapon, shadow_rift_data, &get_close_ai, &function_c5d95ddef4b880e1 );
    thread function_2ab1a1919426d5ce( super_bundle, duration_ms, origin, super_bundle.var_4f28b247b3de0824, super_bundle.var_1c4ed87072a030dc, weapon, shadow_rift_data, &get_close_players, &function_e97aed70b407e912 );
    thread function_2ab1a1919426d5ce( super_bundle, duration_ms, origin, super_bundle.var_64be34588b64d4cf, super_bundle.var_df8fec74558f1e27 * var_dbf68f32b2274fb5, weapon, shadow_rift_data, &function_58ec2d2f2ecbcddb );
}

// Namespace shadow_break
// Params 2, eflags: 0xc
// Checksum 0xd151e761, Offset: 0x11e9
// Size: 0x88
function private function_43b6168dd9e55c19( effect_origin, search_radius )
{
    self notify( #"hash_8df0bc2b6cac618e" );
    self endon( #"hash_8df0bc2b6cac618e" );
    level endon( #"game_ended" );
    self endon( #"shadow_break_expired" );
    
    while ( true )
    {
        resume_reason = utility::waittill_notify_or_timeout_return( "disconnect", 0.1 );
        
        if ( resume_reason != "timeout" )
        {
            end_use();
            break;
        }
        
        function_146063a68731c4a4( effect_origin, search_radius );
    }
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0x40c58995, Offset: 0x1279
// Size: 0xb8
function private end_use( fromdeath, attacker )
{
    function_d56b425f52a4f462();
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_shadow_break" );
    function_f51f8817f81e3689( super_bundle );
    self notify( #"shadow_break_expired" );
    
    if ( self.var_835d0ded06aa3f49.interaction )
    {
        function_2be557503ba4a710();
    }
    
    self.var_4b2c92a85825c7a7 = undefined;
    self.var_835d0ded06aa3f49 = undefined;
    
    if ( super_bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace shadow_break
// Params 0, eflags: 0x4
// Checksum 0x3c6a9074, Offset: 0x1339
// Size: 0x2b7
function private function_7d4cbec6461c98d()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_shadow_break" );
    var_31389415574c377f = { #var_f032212aab7d207b:1, #var_2a910b69b3bb40ff:&ai_utility::get_power_tier, #var_4ffaa10c855d8342:1, #var_31dfe1fbbd9a619d:bundle.var_faeb5f659292390, #vortexdamagetype:bundle.shadowbreakdamagetype ?? "MOD_UNKNOWN", #var_8aa959f473df5188:bundle.var_46d0015821b8153d ?? 0, #var_cffd95997102c756:bundle.var_9a7cf26c2ddf649b ?? 0, #var_33a64f87796575e0:bundle.var_eb30e848142cf55f ?? 0, #var_ce0fea5da8881e40:bundle.var_73ce837f654b45f7 ?? 0, #var_e3fd399dcc0598da:bundle.var_a9bde03870c14535 ? &can_see_vortex : undefined, #var_f85a69b9c91db75c:bundle.var_dd9fbb77ee570fa, #var_6e746602bc0b018:bundle.var_8cee35bb13a90e07, #var_7e920a3a1c9817ff:1, #var_9ea8fb6ead11365d:&function_f1b7525beb8d5a71, #var_1727c27c7fb52001:bundle.var_ce354d9e022f2b90 ?? 0, #assistscoreevent:bundle.var_6be9720356a07814, #teleportscoreevent:bundle.var_bc745b07e4a39764, #vortexduration:bundle.usetime, #var_e085937a3498110c:"shadow_break_teleport_trail", #var_224f265fd5efc9ff:"shadow_break_special_impact_fx", #var_75653cbca1a6c623:"shadow_break_warp_air_fx", #var_ea11f196c7e0e9a4:"shadow_break_warp_ground_fx", #var_6b095645e9b1c002:0, #var_689497f14fbdff16:bundle.var_77f1d9eb1bf83f43 ?? 0, #var_349d07d5a721454c:1, #var_9aac268dc1b55d9b:bundle.var_c0fd46ececa7fafb ?? 0, #teleportdistance:0, #teleportradius:0, #var_16689710f73bec72:0, #var_20baf5221f9d6a68:bundle.var_5e8f85402f9bbf89 ?? 0, #var_20de0b221fc3e282:bundle.var_5e6c97402f759f67 ?? 0, #var_e20efab7b51bd48c:bundle.var_34b9d3824b6d5c4c ?? 0, #lethalradius:get_effect_radius( bundle ), #var_b2dd3f86af2d2115:bundle.var_75c72db548aa9239 ?? 0, #scriptable:bundle.shadowbreakscriptable ?? "ammomod_proc_shadow_vortex" };
    return var_31389415574c377f;
}

// Namespace shadow_break
// Params 9, eflags: 0x4
// Checksum 0x83110ca3, Offset: 0x15f9
// Size: 0x155
function private function_2ab1a1919426d5ce( super_bundle, duration_ms, origin, tick_interval, tick_damage, weapon, shadow_rift_data, get_targets_func, var_5a3af0317bc8c03 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"shadow_break_expired" );
    search_radius = get_effect_radius( super_bundle );
    end_time_ms = gettime() + duration_ms;
    
    while ( end_time_ms >= gettime() )
    {
        wait tick_interval;
        
        if ( end_time_ms < gettime() )
        {
            break;
        }
        
        nearby_targets = self [[ get_targets_func ]]( origin, search_radius );
        
        foreach ( entity in nearby_targets )
        {
            if ( var_5a3af0317bc8c03 && !self [[ var_5a3af0317bc8c03 ]]( entity ) )
            {
                continue;
            }
            
            function_1cd558f5ee1691d4( entity, tick_damage, weapon, super_bundle, shadow_rift_data );
        }
    }
}

// Namespace shadow_break
// Params 4, eflags: 0x4
// Checksum 0x5fb1e2d5, Offset: 0x1756
// Size: 0x108, Type: bool
function private can_see_vortex( target_entity, target_scriptable, vortex, shadow_rift_data )
{
    target = target_entity ?? target_scriptable;
    var_86e0013705e6bfc5 = isai( target ) || isplayer( target ) ? target geteye() : target.origin;
    vortex_offset = ( 0, 0, shadow_rift_data.var_ce0fea5da8881e40 );
    contents = trace::create_default_contents( 1 ) - trace::function_bbd81e56529ef225();
    var_617f2876f4b4344e = [ target_entity ];
    var_f2716b310a97eb1d = function_ed493f19c9f2846c( target_entity );
    
    if ( var_f2716b310a97eb1d )
    {
        var_617f2876f4b4344e = arraycombine( var_617f2876f4b4344e, var_f2716b310a97eb1d );
    }
    
    sight_hit = trace::ray_trace( var_86e0013705e6bfc5, vortex.origin + vortex_offset, var_617f2876f4b4344e, contents, undefined, undefined, undefined, target_scriptable, self.team );
    return sight_hit[ "fraction" ] == 1;
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0xbfdbb3e9, Offset: 0x1867
// Size: 0x27, Type: bool
function private is_dawg( entity )
{
    return entity && entity.subclass == #"dawg";
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x5b343694, Offset: 0x1897
// Size: 0x4f
function private function_ed493f19c9f2846c( target_entity )
{
    var_f2716b310a97eb1d = [];
    
    if ( is_dawg( target_entity ) )
    {
        turret = target_entity.turret;
        
        if ( turret )
        {
            var_f2716b310a97eb1d = arraycombineunique( var_f2716b310a97eb1d, [ turret ] );
        }
    }
    
    return var_f2716b310a97eb1d;
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0x604df91, Offset: 0x18ef
// Size: 0x94, Type: bool
function private function_404e6f4bc62584b4( target_entity, target_scriptable, shadow_rift_data )
{
    assert( self.var_835d0ded06aa3f49 );
    target = target_entity ?? target_scriptable;
    return ( !target.var_d82747ac6d877424 || target.var_d82747ac6d877424 == self ) && can_see_vortex( target_entity, target_scriptable, self.var_835d0ded06aa3f49, shadow_rift_data ) && !target.var_fad926dc8ac76bc5 && !target ai::get_ignoreme();
}

// Namespace shadow_break
// Params 4, eflags: 0x4
// Checksum 0xe9a861db, Offset: 0x198c
// Size: 0xa3
function private function_c30c17c613e92c31( ent, super_bundle, hit_vfx, hit_sound_alias )
{
    if ( hit_vfx )
    {
        var_3e98315ce519724d = isplayer( ent ) || isagent( ent ) ? super_bundle.var_901b9de6207fc619 : super_bundle.var_bb2a3ca324a3d796;
        
        if ( var_3e98315ce519724d && ent tagexists( var_3e98315ce519724d ) )
        {
            spawn_tag = var_3e98315ce519724d;
        }
        
        playfxontag( hit_vfx, ent, spawn_tag ?? #"tag_origin" );
    }
    
    if ( hit_sound_alias )
    {
        ent playsound( hit_sound_alias );
    }
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0x852f3370, Offset: 0x1a37
// Size: 0x4c
function private function_1edf16145b9c8aa9( ent, hit_vfx, hit_sound_alias )
{
    if ( hit_vfx )
    {
        playfx( hit_vfx, ent.origin );
    }
    
    if ( hit_sound_alias )
    {
        playsoundatpos( ent.origin, hit_sound_alias );
    }
}

// Namespace shadow_break
// Params 5, eflags: 0x4
// Checksum 0xa547a7b5, Offset: 0x1a8b
// Size: 0x17c
function private function_1cd558f5ee1691d4( ent, damage, weapon, super_bundle, shadow_rift_data )
{
    if ( isent( ent ) )
    {
        target_entity = ent;
    }
    else if ( ent.classname == "scriptable" )
    {
        target_scriptable = ent;
    }
    else
    {
        assertmsg( "<dev string:x1d0>" );
        return;
    }
    
    if ( !function_404e6f4bc62584b4( target_entity, target_scriptable, shadow_rift_data ) )
    {
        return;
    }
    
    self.var_4b2c92a85825c7a7 = arraycombineunique( self.var_4b2c92a85825c7a7, [ ent ] );
    ent.var_d82747ac6d877424 = self;
    hit_vfx = utility::getfx( "shadow_break_dot_damage_hit" );
    damage_type = super_bundle.shadowbreakdamagetype ?? "MOD_UNKNOWN";
    hit_sound_alias = super_bundle.var_5cd8e7bbc561ede7;
    
    if ( target_entity )
    {
        function_c30c17c613e92c31( ent, super_bundle, hit_vfx, hit_sound_alias );
        ent dodamage( damage, ent.origin, self, self, damage_type, weapon, "none", undefined, 1 );
    }
    else if ( target_scriptable )
    {
        function_1edf16145b9c8aa9( ent, hit_vfx, hit_sound_alias );
        ent scriptabledodamage( damage, self, self, undefined, undefined, damage_type, weapon );
    }
    
    if ( super_bundle.var_6be9720356a07814 )
    {
        function_f1b7525beb8d5a71( ent, super_bundle.var_6be9720356a07814, super_bundle.var_ce354d9e022f2b90 );
    }
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0x385e33a0, Offset: 0x1c0f
// Size: 0xd2
function private function_146063a68731c4a4( origin, radius )
{
    foreach ( ent in self.var_4b2c92a85825c7a7 )
    {
        if ( isdefined( ent ) && distancesquared( ent.origin, origin ) > squared( radius ) )
        {
            if ( isalive( self ) )
            {
                self.var_4b2c92a85825c7a7 = arrayremove( self.var_4b2c92a85825c7a7, ent );
            }
            
            ent.var_d82747ac6d877424 = undefined;
        }
    }
}

// Namespace shadow_break
// Params 0, eflags: 0x4
// Checksum 0x32558a54, Offset: 0x1ce9
// Size: 0x18
function private function_d56b425f52a4f462()
{
    function_146063a68731c4a4( ( 0, 0, 0 ), -1 );
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x7ef05530, Offset: 0x1d09
// Size: 0x136
function private function_169d1ccb4f276163( params )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( !isdefined( attacker ) || !isdefined( self.var_dd955bdd08bad92 ) )
    {
        return;
    }
    
    foreach ( shadow_break_data in self.var_dd955bdd08bad92 )
    {
        if ( attacker != shadow_break_data.attacker && shadow_break_data.var_4276f1a61c2bfd70 >= gettime() && isalive( shadow_break_data.attacker ) )
        {
            assert( shadow_break_data.var_db8955efdb797c70 );
            
            if ( shadow_break_data.var_db8955efdb797c70 )
            {
                shadow_break_data.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( shadow_break_data.var_db8955efdb797c70 );
            }
        }
    }
    
    self.var_dd955bdd08bad92 = undefined;
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0x28ce4672, Offset: 0x1e47
// Size: 0x68
function private function_f1b7525beb8d5a71( ent, score_event_ref, var_68b7de129e07b5bf )
{
    shadow_break_data = { #attacker:self, #var_4276f1a61c2bfd70:gettime() + var_68b7de129e07b5bf * 1000, #var_db8955efdb797c70:score_event_ref };
    ent.var_dd955bdd08bad92[ self getentitynumber() ] = shadow_break_data;
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0x71c450dd, Offset: 0x1eb7
// Size: 0xb7
function private function_58ec2d2f2ecbcddb( origin, radius )
{
    killstreakarray = level.activekillstreaks;
    equipmentarray = [[ level.getactiveequipmentarray ]]();
    turrets = getentarray( "misc_turret", #classname );
    mines = weapon::function_3aafcaf7ff6dea9e();
    sentryturrets = level.aisentryturrets.spawnedturrets;
    kfes = [];
    kfes = arraycombineunique( kfes, killstreakarray, equipmentarray, turrets, mines, sentryturrets );
    var_8b55843332ef58bd = function_98d066e899de07f3( origin, radius, kfes );
    return var_8b55843332ef58bd;
}

// Namespace shadow_break
// Params 3, eflags: 0x4
// Checksum 0x6ce31ddf, Offset: 0x1f77
// Size: 0xed
function private function_98d066e899de07f3( origin, radius, var_ee97a6b3551cbaf8 )
{
    radius_sq = radius * radius;
    var_3bb76653241dfeb9 = [];
    
    foreach ( kfe in var_ee97a6b3551cbaf8 )
    {
        if ( !utility::callsharedfunc( #"player", #"playersareenemies", self, kfe ) )
        {
            continue;
        }
        
        dist = distancesquared( origin, kfe.origin );
        
        if ( dist <= radius_sq )
        {
            var_3bb76653241dfeb9[ var_3bb76653241dfeb9.size ] = kfe;
        }
    }
    
    return var_3bb76653241dfeb9;
}

// Namespace shadow_break
// Params 1, eflags: 0x4
// Checksum 0x9dc51bf7, Offset: 0x206d
// Size: 0x1b, Type: bool
function private get_effect_radius( super_bundle )
{
    return super_bundle.var_fa9138a88fa31eaa ?? 0;
}

// Namespace shadow_break
// Params 2, eflags: 0x4
// Checksum 0xbbf83055, Offset: 0x2091
// Size: 0x2d3
function private get_vortex_spawn_position( super_bundle, fallback_position )
{
    if ( !super_bundle.var_dfaa9a2f86b6031f )
    {
        return fallback_position;
    }
    
    player_forward = anglestoforward( self getplayerangles( 1 ) );
    var_a90be86df0d73c17 = self geteye();
    candidate_position = var_a90be86df0d73c17 + player_forward * super_bundle.var_dfaa9a2f86b6031f;
    physics_contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1 );
    sight_hit = trace::ray_trace( var_a90be86df0d73c17, candidate_position, self, physics_contents, 0, 1, 1 );
    vortex_radius = super_bundle.var_f9baa99aa9267e67 ?? 0;
    
    if ( sight_hit[ "fraction" ] < 1 )
    {
        var_5a32dd5646356dcd = sight_hit[ "normal" ] * ( vortex_radius + 15 );
        candidate_position = sight_hit[ "position" ] + var_5a32dd5646356dcd;
    }
    else if ( vortex_radius )
    {
        inplace_hit = trace::sphere_trace( candidate_position, candidate_position, vortex_radius, self, physics_contents, 0, 1 );
        
        if ( inplace_hit[ "hittype" ] != "hittype_none" )
        {
            if ( inplace_hit[ "normal" ] == ( 0, 0, -1 ) )
            {
                to_player_direction = vectornormalize( self.origin - inplace_hit[ "position" ] );
            }
            
            var_5a32dd5646356dcd = to_player_direction * ( vortex_radius + 15 );
            candidate_position = inplace_hit[ "shape_position" ] + var_5a32dd5646356dcd;
        }
    }
    
    if ( vortex_radius )
    {
        inplace_hit = trace::sphere_trace( candidate_position, candidate_position, vortex_radius, self, physics_contents, 0, 1 );
        
        if ( inplace_hit[ "hittype" ] != "hittype_none" )
        {
            return fallback_position;
        }
    }
    
    var_6eaf3577186eb6d7 = super_bundle.var_2aecde8cdf3a963a;
    
    if ( var_6eaf3577186eb6d7 )
    {
        drop_end = candidate_position + ( 0, 0, var_6eaf3577186eb6d7 );
        grounded_position = utility::drop_to_ground( candidate_position, 5, var_6eaf3577186eb6d7 );
        
        if ( grounded_position == drop_end )
        {
            return fallback_position;
        }
        
        candidate_position = grounded_position;
    }
    
    if ( super_bundle.var_9323e0853a239c5a )
    {
        is_in_fov = math::point_in_fov( candidate_position );
        
        if ( !is_in_fov )
        {
            return fallback_position;
        }
    }
    
    if ( super_bundle.var_5d37147ea7cc0a16 )
    {
        ceiling_hit = trace::ray_trace( candidate_position, candidate_position + ( 0, 0, super_bundle.var_d80ca202a85a3298 ), self, physics_contents, 0, 1, 1 );
        
        if ( ceiling_hit[ "fraction" ] < 1 )
        {
            return fallback_position;
        }
    }
    
    is_oob = outofbounds::ispointinoutofbounds( candidate_position );
    var_bc5a5db3663e6268 = utility::ispointinwater( candidate_position );
    water_surface_height = getwaterheightatlocation( candidate_position );
    var_7f1335b8e9f5739c = super_bundle.var_ba3582a05518b624 ?? 0;
    var_25e2ee65a85cdeac = var_bc5a5db3663e6268 && water_surface_height && water_surface_height - candidate_position[ 2 ] > var_7f1335b8e9f5739c;
    
    if ( is_oob || var_25e2ee65a85cdeac )
    {
        return fallback_position;
    }
    
    return candidate_position;
}

