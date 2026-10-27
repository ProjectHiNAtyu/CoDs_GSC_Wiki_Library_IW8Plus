// scripts\mp\ob\activities\ob_activity_prop_hunt.gsc  (hash_7f34db4804afa52b.gscc) (size: 15808 Bytes / 0x3dc0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5806b0c6 (1476833478)
// size ...... 15808 (0x3dc0)
// includes .. 16  (offset: 0x3a3c)
// strings ... 41  (offset: 0x3abc)
// dev strs .. 9   (offset: 0x3d48)
// exports ... 41  (offset: 0x2698)
// cseg ...... 0x4aa + 0x21ee (0x2698)
// imports ... 113 (offset: 0x2d00)
// animtree1 . 0   (offset: 0x3dc0)
// animtree2 . 0   (offset: 0x3dc0)
#using script_16ea1b94f0f381b3;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\ob_cradle_gas_circle;

#namespace ob_activity_prop_hunt;

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x5
// Checksum 0x76b53951, Offset: 0x4c8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_prop_hunt", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xe5d9185a, Offset: 0x4f1
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_PROP_HUNT", &prop_hunt_activity_type_init );
}

// Namespace ob_activity_prop_hunt
// Params 0
// Checksum 0x9b8c90bf, Offset: 0x50c
// Size: 0xfa
function prop_hunt_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_PROP_HUNT", 0, &prop_hunt_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_PROP_HUNT", 1, &prop_hunt_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_PROP_HUNT", 2, &prop_hunt_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_PROP_HUNT", 3, &prop_hunt_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_PROP_HUNT", 5, &function_3f8bff541fe4f43c );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_90ab6b048b1df98f, "REV_OB_PROP_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_35aefd3ece26dfbf, "REV_OB_PROP_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_c2eb887206f5775b, "REV_OB_PROP_HUNT" );
    
    if ( !level._effect[ "vfx_sat_ob_gameplay_chest_explosion" ] )
    {
        level._effect[ "vfx_sat_ob_gameplay_chest_explosion" ] = loadfxasset( "vfx_sat_ob_gameplay_chest_explosion" );
    }
    
    if ( !level._effect[ "vfx_sat_ob_gameplay_chest_spawn" ] )
    {
        level._effect[ "vfx_sat_ob_gameplay_chest_spawn" ] = loadfxasset( "vfx_sat_ob_gameplay_chest_spawn" );
    }
}

// Namespace ob_activity_prop_hunt
// Params 0
// Checksum 0xcdfdc471, Offset: 0x60e
// Size: 0x37e
function prop_hunt_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    prop_hunt_content = utility::getstructarray( self.varianttag, "target" );
    activity_instance.handler_list = [ "karm", "mars" ];
    self.activity_structs = spawnstruct();
    self.activity_structs.prop_structs = [];
    self.activity_structs.prop_scriptables = [];
    self.activity_structs.chest_structs = [];
    self.activity_structs.enemy_structs = [];
    
    foreach ( struct in prop_hunt_content )
    {
        if ( isdefined( struct.targetname ) )
        {
            switch ( struct.targetname )
            {
                case #"hash_ecf5eae4ab481925":
                    self.activity_structs.var_10ceb6b70c29c3b9[ 0 ] = struct;
                    self.activity_structs.prop_scriptables[ 0 ] = function_8ba266ae37fd13f3( "_mysteryprop_1" );
                    break;
                case #"hash_775799a91f31c58c":
                    self.activity_structs.var_10ceb6b70c29c3b9[ 1 ] = struct;
                    self.activity_structs.prop_scriptables[ 1 ] = function_8ba266ae37fd13f3( "_mysteryprop_2" );
                    break;
                case #"hash_5242e771aab6a09f":
                    self.activity_structs.var_10ceb6b70c29c3b9[ 2 ] = struct;
                    self.activity_structs.prop_scriptables[ 2 ] = function_8ba266ae37fd13f3( "_mysteryprop_3" );
                    break;
                case #"hash_51aab0bdfd55e987":
                    self.activity_structs.chest_structs[ 0 ] = struct;
                    break;
                case #"hash_c94932946a158fd0":
                    self.activity_structs.chest_structs[ 1 ] = struct;
                    break;
                case #"hash_7b3cbdb1ca7d61e5":
                    self.activity_structs.chest_structs[ 2 ] = struct;
                    break;
                case #"hash_5003db154ce4ad8":
                    self.activity_structs.enemy_structs[ 0 ] = struct;
                    break;
                case #"hash_fd798cab232d377":
                    self.activity_structs.enemy_structs[ 1 ] = struct;
                    break;
                case #"hash_484252b8ccc29e32":
                    self.activity_structs.enemy_structs[ 2 ] = struct;
                    break;
                case #"hash_dbd5b76bf287c738":
                    self.activity_structs.var_12fa6a6b35688929 = struct;
                    break;
                default:
                    break;
            }
        }
    }
    
    function_c51116665050a573();
    function_1bd577639d29516a();
    activity_instance_common::function_46135a69bddfec2c( self );
    
    /#
        thread prop_hunt_debug();
    #/
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0x58cacf90, Offset: 0x994
// Size: 0x23e
function private function_c51116665050a573()
{
    random_array = [ 0, 1, 2 ];
    random_array = arrayrandomize( random_array );
    prop_index = random_array[ 0 ];
    self.mystery_prop[ "prop" ] = prop_hunt_spawn_prop( self.activity_structs.var_10ceb6b70c29c3b9[ prop_index ], self.var_91c91f4a631c481d.var_51d1a08cf3b3b6b, self.activity_structs.prop_scriptables[ prop_index ] );
    enemy_index = random_array[ 1 ];
    self.mystery_prop[ "enemy" ] = prop_hunt_spawn_prop( self.activity_structs.var_10ceb6b70c29c3b9[ enemy_index ], 1, self.activity_structs.prop_scriptables[ enemy_index ] );
    self.mystery_prop[ "enemy" ].enemy_angles = isdefined( self.activity_structs.enemy_structs[ enemy_index ] ) ? self.activity_structs.enemy_structs[ enemy_index ].angles : self.activity_structs.var_10ceb6b70c29c3b9[ enemy_index ].angles;
    var_9793a360230a2a1c = random_array[ 2 ];
    self.mystery_prop[ "chest" ] = prop_hunt_spawn_prop( self.activity_structs.var_10ceb6b70c29c3b9[ var_9793a360230a2a1c ], 1, self.activity_structs.prop_scriptables[ var_9793a360230a2a1c ] );
    self.mystery_prop[ "chest" ].chest_angles = isdefined( self.activity_structs.chest_structs[ var_9793a360230a2a1c ] ) ? self.activity_structs.chest_structs[ var_9793a360230a2a1c ].angles : self.activity_structs.var_10ceb6b70c29c3b9[ var_9793a360230a2a1c ].angles;
    self.var_6ae777127f0a8f9a = 0;
    thread function_cd1bca94a9b93bc7();
    scriptable::scriptable_addnotifycallback( "mystery_prop_shot", &function_d6fd0dbefe75e7b1 );
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0x8f793ec, Offset: 0xbda
// Size: 0x3e
function private function_8ba266ae37fd13f3( nameappend )
{
    prop_scriptables = getentitylessscriptablearray( self.varianttag + nameappend, #targetname );
    
    if ( prop_scriptables.size == 1 )
    {
        return prop_scriptables[ 0 ];
    }
}

// Namespace ob_activity_prop_hunt
// Params 3, eflags: 0x4
// Checksum 0xc5c17782, Offset: 0xc21
// Size: 0x196
function private prop_hunt_spawn_prop( spawn_loc, visible, existing )
{
    if ( isdefined( spawn_loc ) )
    {
        pos_offset = ( self.var_91c91f4a631c481d.var_fc824d2b84e0b12d, self.var_91c91f4a631c481d.var_fc824c2b84e0aefa, self.var_91c91f4a631c481d.var_fc824b2b84e0acc7 );
        spawn_offset = ( 0, 0, 0 );
        
        if ( lengthsquared( pos_offset ) > 0 )
        {
            axis = anglestoaxis( spawn_loc.angles );
            spawn_offset += pos_offset[ 0 ] * axis[ "forward" ];
            spawn_offset += pos_offset[ 1 ] * axis[ "right" ];
            spawn_offset += pos_offset[ 2 ] * axis[ "up" ];
        }
        
        if ( existing )
        {
            newprop = existing;
        }
        else
        {
            newprop = spawnscriptable( self.var_91c91f4a631c481d.propscriptable, spawn_loc.origin + spawn_offset, spawn_loc.angles );
            newprop.was_spawned = 1;
        }
        
        newprop.activity_instance = self;
        newprop.was_destroyed = 0;
        
        if ( visible )
        {
            newprop setscriptablepartstate( "base", "visible" );
        }
        else
        {
            newprop setscriptablepartstate( "base", "invisible" );
        }
        
        newprop.true_origin = spawn_loc.origin;
        newprop.ignore_damage = 0;
        return newprop;
    }
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xfa650543, Offset: 0xdc0
// Size: 0x1de
function private function_cd1bca94a9b93bc7()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"prop_hunt_cleanup" );
    
    while ( !function_601679cd6f3679e6( self.mystery_prop[ "enemy" ] ) )
    {
        closestplayer = undefined;
        closestplayerdist = 0;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                dist = distancesquared( player.origin, self.mystery_prop[ "enemy" ].true_origin );
                
                if ( dist < self.var_91c91f4a631c481d.var_edd72939b6595bae * self.var_91c91f4a631c481d.var_edd72939b6595bae )
                {
                    function_c50d624984bfa452( self.mystery_prop[ "enemy" ], 0 );
                    continue;
                }
                
                if ( dist < self.var_91c91f4a631c481d.var_e517381a9053c909 * self.var_91c91f4a631c481d.var_e517381a9053c909 )
                {
                    time_since = gettime() - self.var_6ae777127f0a8f9a;
                    
                    if ( time_since >= self.var_91c91f4a631c481d.var_a652160cf8bf0768 * 1000 )
                    {
                        thread function_4bf732b987bcf98a();
                    }
                    
                    if ( !activity_participation::function_e7fc1202ac164928( self, player ) )
                    {
                        activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedInteract" );
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace ob_activity_prop_hunt
// Params 4, eflags: 0x4
// Checksum 0xa38625b6, Offset: 0xfa6
// Size: 0x11a
function private function_d6fd0dbefe75e7b1( instance, note, param, var_64ffacba090c91be )
{
    if ( var_64ffacba090c91be && isplayer( var_64ffacba090c91be ) && instance && instance.activity_instance )
    {
        activity_instance = instance.activity_instance;
        
        if ( function_601679cd6f3679e6( instance ) || function_ba2e35e4f860f8c3( instance ) )
        {
            return;
        }
        
        if ( instance == activity_instance.mystery_prop[ "enemy" ] )
        {
            function_67570254bc7a62d( instance );
            activity_instance function_c50d624984bfa452( instance, 1 );
            return;
        }
        
        if ( instance == activity_instance.mystery_prop[ "chest" ] )
        {
            activity_instance function_b14033639a7d25fd( instance );
            activity_instance function_584e7c0e026a0858( instance, 1 );
            
            if ( !function_601679cd6f3679e6( activity_instance.mystery_prop[ "enemy" ] ) )
            {
                activity_instance function_c50d624984bfa452( activity_instance.mystery_prop[ "enemy" ], 0 );
                activity_instance function_b55021e9366b3b48( 1.75 );
            }
        }
    }
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xc82d11e7, Offset: 0x10c8
// Size: 0x9f
function private function_4bf732b987bcf98a()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !self.mystery_prop[ "enemy" ].is_shaking )
    {
        self.var_6ae777127f0a8f9a = gettime();
        function_e0739809d57a295e( self.mystery_prop[ "enemy" ], self.var_91c91f4a631c481d.var_e37474ecb6d9ceb3, self.var_91c91f4a631c481d.var_db9d28a95f26307f, self.var_91c91f4a631c481d.var_6c691a27054cebce );
    }
}

// Namespace ob_activity_prop_hunt
// Params 4
// Checksum 0x4d1b097a, Offset: 0x116f
// Size: 0x63
function function_e0739809d57a295e( var_b1f3dccf5a1b9bb7, total_time, var_4ee6baf1063a4e93, angle )
{
    if ( var_b1f3dccf5a1b9bb7 )
    {
        var_b1f3dccf5a1b9bb7.is_shaking = 1;
        var_b1f3dccf5a1b9bb7 setscriptablepartstate( "base", "shake" );
        wait 1;
    }
    
    if ( var_b1f3dccf5a1b9bb7 )
    {
        var_b1f3dccf5a1b9bb7.is_shaking = 0;
    }
}

// Namespace ob_activity_prop_hunt
// Params 4
// Checksum 0x9c411876, Offset: 0x11da
// Size: 0x40
function function_4e9d65219db97e31( group_id, activity_instance, spawned_ai, agent_index )
{
    if ( activity_instance && spawned_ai )
    {
        activity_instance.enemy_ai = spawned_ai;
    }
}

// Namespace ob_activity_prop_hunt
// Params 2, eflags: 0x4
// Checksum 0xb4bb9a5, Offset: 0x1222
// Size: 0x242
function private function_c50d624984bfa452( prop, var_9310326275f2d90b )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_125301da917ada8a = namespace_9d8e359c3b1041e5::getfreeaicount_sharedfunc() > 0;
    ai_type = function_b3988325430ce242( self.var_91c91f4a631c481d.enemyaitype );
    
    if ( var_125301da917ada8a && isdefined( ai_type ) )
    {
        groupid = ai_spawn_director::function_e19f6a00c4bb7490( ai_type, 0, 1, 1, 0, 3 );
        ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", groupid, &function_4e9d65219db97e31, self );
        ai_spawn_director::function_9893a28f1d682a28( groupid, ai_type, prop.true_origin, prop.enemy_angles, undefined, undefined, undefined, "team_hundred_ninety" );
        
        while ( !self.enemy_ai )
        {
            waitframe();
        }
        
        if ( self.enemy_ai )
        {
            if ( var_9310326275f2d90b )
            {
                var_295cea9484b9a76e = self.enemy_ai.health * self.var_91c91f4a631c481d.var_f4fe6152629c95be;
                
                /#
                    var_8f6d340ee3e19bb4 = getdvarfloat( @"hash_f05c6981830e06fc", 0 );
                    
                    if ( var_8f6d340ee3e19bb4 > 0 )
                    {
                        var_295cea9484b9a76e = self.enemy_ai.health * var_8f6d340ee3e19bb4;
                    }
                #/
                
                self.enemy_ai dodamage( var_295cea9484b9a76e, self.enemy_ai.origin );
            }
            
            self.enemy_ai.activity_instance = self;
            self.enemy_ai callback::add( "on_zombie_ai_killed", &function_889b32aa01b00a54 );
            self.enemy_ai hide();
            waitframe();
            function_b011cdb3bb6cd9e2( self.enemy_ai, prop );
            self.enemy_ai callback::callback( "on_entity_revealed" );
            thread function_2a34b0ff2bbbaa8d();
        }
    }
    else
    {
        println( "<dev string:x24>" );
    }
    
    if ( !isdefined( prop ) )
    {
        return;
    }
    
    playfx( utility::getfx( "mimic_prop_rattle_fx" ), prop.true_origin + ( 0, 0, 16 ) );
    prop.var_71c219f2ccf139c0 = undefined;
    function_584e7c0e026a0858( prop, 0 );
}

// Namespace ob_activity_prop_hunt
// Params 2, eflags: 0x4
// Checksum 0xa256f8fd, Offset: 0x146c
// Size: 0x107
function private function_b011cdb3bb6cd9e2( entity, prop )
{
    if ( entity.hidden_in_prop && entity.var_b1f3dccf5a1b9bb7 == prop )
    {
        return;
    }
    
    entity.hidden_in_prop = 1;
    entity.var_b1f3dccf5a1b9bb7 = prop;
    entity.b_skip_spawn_anim = 1;
    entity.var_82209d06b3fad29d = prop.var_82209d06b3fad29d;
    entity setsolid( 0 );
    entity dontinterpolate();
    entity forceteleport( prop.true_origin, prop.enemy_angles );
    params = spawnstruct();
    params.prop = prop;
    entity callback::callback( "on_entity_hidden_in_prop", params );
    
    if ( !isdefined( prop.var_71c219f2ccf139c0 ) )
    {
        prop.var_71c219f2ccf139c0 = [];
    }
    
    prop.var_71c219f2ccf139c0[ prop.var_71c219f2ccf139c0.size ] = entity;
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xeddee306, Offset: 0x157b
// Size: 0xda
function private function_2a34b0ff2bbbaa8d()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 1.5;
    
    if ( randomfloat( 1 ) > 0.5 )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( self, "prop_hunt_chase", self.playerparticipants );
        return;
    }
    
    foreach ( player in self.playerparticipants )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( "prop_hunt_chase_tacb", [ player ] );
    }
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0xb2494b99, Offset: 0x165d
// Size: 0x6f
function private function_b55021e9366b3b48( delay = 0 )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( self.enemy_ai )
    {
        playsoundatpos( self.enemy_ai.origin, "evt_mimic_prop_laugh" );
    }
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0x2c9f1656, Offset: 0x16d4
// Size: 0x1f, Type: bool
function private function_601679cd6f3679e6( prop )
{
    return !isdefined( prop ) || prop.was_destroyed;
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0x8936bbb9, Offset: 0x16fc
// Size: 0x1a
function private function_67570254bc7a62d( prop )
{
    prop.ignore_damage = 1;
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0x1023d73d, Offset: 0x171e
// Size: 0x17
function private function_ba2e35e4f860f8c3( prop )
{
    return prop.ignore_damage;
}

// Namespace ob_activity_prop_hunt
// Params 2, eflags: 0x4
// Checksum 0xb252279e, Offset: 0x173e
// Size: 0x168
function private function_584e7c0e026a0858( prop, var_44fcb185a56b5356 )
{
    if ( !isdefined( prop ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    prop endon( #"death" );
    function_67570254bc7a62d( prop );
    
    if ( isdefined( prop.var_71c219f2ccf139c0 ) )
    {
        foreach ( var_2ffcdb46889d1294 in prop.var_71c219f2ccf139c0 )
        {
            if ( isdefined( var_2ffcdb46889d1294 ) )
            {
                var_2ffcdb46889d1294 kill();
            }
        }
    }
    
    if ( isdefined( prop.true_origin ) && ( var_44fcb185a56b5356 ?? 1 ) )
    {
        playfx( utility::getfx( "mimic_prop_spawn_out_fx" ), prop.true_origin );
        playsoundatpos( prop.true_origin + ( 0, 0, 16 ), "evt_mimic_prop_hide" );
        wait 0.5;
    }
    
    if ( isdefined( prop ) )
    {
        if ( prop.was_spawned )
        {
            prop freescriptable();
            return;
        }
        
        prop setscriptablepartstate( "base", "invisible" );
        prop.was_destroyed = 1;
    }
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0xfc4b6927, Offset: 0x18ae
// Size: 0x95
function private function_889b32aa01b00a54( params )
{
    activity_instance = self.activity_instance;
    
    if ( !function_601679cd6f3679e6( self.activity_instance.mystery_prop[ "chest" ] ) )
    {
        activity_instance function_10cb58a3cc92871f( activity_instance.mystery_prop[ "chest" ] );
        activity_instance function_584e7c0e026a0858( activity_instance.mystery_prop[ "chest" ] );
    }
    
    activity_instance function_8492e82467098012();
    activity_instance prop_hunt_activity_success( params.eattacker );
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0xa6b7a159, Offset: 0x194b
// Size: 0x7f
function private function_10cb58a3cc92871f( prop )
{
    if ( prop )
    {
        playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_spawn" ), prop.true_origin );
        spawn_options = common_item::function_bc5ff2958b71a708( prop.true_origin, prop.chest_angles );
        item_name = function_c11af7a197679429( "itemspawnlist:ob_activity_itemspawnlist_prop_hunt", 1 );
        item = common_item::function_61c2c0251e742ffd( item_name[ 0 ], undefined, spawn_options );
    }
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xf80843e7, Offset: 0x19d2
// Size: 0x26
function private function_402a098e7a3616d6()
{
    if ( self.chest )
    {
        self.chest freescriptable();
        self.chest = undefined;
    }
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0x2a89dc37, Offset: 0x1a00
// Size: 0xc0
function private function_b14033639a7d25fd( prop )
{
    if ( prop )
    {
        playsoundatpos( prop.true_origin, "evt_mimic_prop_explo" );
        playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_explosion" ), prop.true_origin );
        self.broken_chest = undefined;
        
        if ( self.var_91c91f4a631c481d.var_90d1306d7e12305d != "" )
        {
            self.broken_chest = utility::spawn_model( self.var_91c91f4a631c481d.var_90d1306d7e12305d, prop.true_origin, prop.chest_angles );
            self.broken_chest.navobstacle = createnavobstaclebyent( self.broken_chest );
        }
    }
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xe5059939, Offset: 0x1ac8
// Size: 0x67
function private function_668f67fadaac885e()
{
    if ( self.broken_chest )
    {
        if ( self.broken_chest.navobstacle )
        {
            destroynavobstacle( self.broken_chest.navobstacle );
            self.broken_chest.navobstacle = undefined;
        }
        
        self.broken_chest delete();
        self.broken_chest = undefined;
    }
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xe3d79a3d, Offset: 0x1b37
// Size: 0x2fd
function private function_1bd577639d29516a()
{
    if ( !self.var_91c91f4a631c481d.var_1992e9f2d8d63b4f )
    {
        return;
    }
    
    if ( self.cradle_gas )
    {
        return;
    }
    
    if ( self.mystery_prop.size <= 0 )
    {
        return;
    }
    
    nbprops = 0;
    locationsum = ( 0, 0, 0 );
    
    foreach ( prop in self.mystery_prop )
    {
        if ( prop )
        {
            locationsum += prop.origin;
            nbprops++;
        }
    }
    
    if ( nbprops <= 0 )
    {
        return;
    }
    
    cloudspawnposition = locationsum / nbprops;
    self.cradle_gas = spawnstruct();
    self.cradle_gas.origin = cloudspawnposition;
    self.cradle_gas.angles = ( 0, 0, 0 );
    self.cradle_gas.cloudsize = 0;
    
    switch ( self.var_91c91f4a631c481d.var_c3b38142d86559e3 )
    {
        case #"hash_6b6cac811631304c":
            self.cradle_gas.cloudsize = 0;
            break;
        case #"hash_3c9ad0c2a3118e56":
            self.cradle_gas.cloudsize = 1;
            break;
        case #"hash_3b50d37c95260bf4":
            self.cradle_gas.cloudsize = 2;
            break;
        case #"hash_55055ae08bb56e76":
            var_a1883aab929d7ad4 = -1;
            
            foreach ( prop in self.mystery_prop )
            {
                dist = distance( prop.origin, cloudspawnposition );
                
                if ( dist > var_a1883aab929d7ad4 )
                {
                    var_a1883aab929d7ad4 = dist;
                }
            }
            
            if ( var_a1883aab929d7ad4 < 350 )
            {
                self.cradle_gas.cloudsize = 4;
            }
            else if ( var_a1883aab929d7ad4 < 750 )
            {
                self.cradle_gas.cloudsize = 5;
            }
            else
            {
                self.cradle_gas.cloudsize = 6;
            }
            
            break;
    }
    
    ob_cradle_gas_circle::function_715467b4b7feb05a( self.cradle_gas, self.cradle_gas.cloudsize );
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0x6e2c79dd, Offset: 0x1e3c
// Size: 0x28
function private function_8492e82467098012()
{
    if ( self.cradle_gas )
    {
        ob_cradle_gas_circle::function_ad1c37731b23fb82( self.cradle_gas );
        self.cradle_gas = undefined;
    }
}

// Namespace ob_activity_prop_hunt
// Params 0, eflags: 0x4
// Checksum 0xe993d735, Offset: 0x1e6c
// Size: 0xba
function private prop_hunt_cleanup()
{
    function_584e7c0e026a0858( self.mystery_prop[ "prop" ], 0 );
    self.mystery_prop[ "prop" ] = undefined;
    function_584e7c0e026a0858( self.mystery_prop[ "chest" ], 0 );
    self.mystery_prop[ "chest" ] = undefined;
    function_584e7c0e026a0858( self.mystery_prop[ "enemy" ], 0 );
    self.mystery_prop[ "enemy" ] = undefined;
    function_402a098e7a3616d6();
    function_668f67fadaac885e();
    function_8492e82467098012();
    
    if ( isdefined( self.enemy_ai ) )
    {
        self.enemy_ai kill();
        self.enemy_ai = undefined;
    }
    
    self notify( #"prop_hunt_cleanup" );
}

/#

    // Namespace ob_activity_prop_hunt
    // Params 0, eflags: 0x4
    // Checksum 0xe44988f9, Offset: 0x1f2e
    // Size: 0x23f, Type: dev
    function private prop_hunt_debug()
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_d5067fa6581f1c54", 0 ) )
            {
                if ( self.mystery_prop[ "<dev string:x4d>" ] )
                {
                    sphere( self.mystery_prop[ "<dev string:x4d>" ].true_origin, 10, ( 0, 1, 0 ) );
                }
                
                if ( self.mystery_prop[ "<dev string:x52>" ] )
                {
                    sphere( self.mystery_prop[ "<dev string:x52>" ].true_origin, 10, ( 1, 0, 0 ) );
                }
                
                if ( self.mystery_prop[ "<dev string:x58>" ] )
                {
                    sphere( self.mystery_prop[ "<dev string:x58>" ].true_origin, 10, ( 0, 0, 1 ) );
                }
                
                if ( self.cradle_gas )
                {
                    sphereradius = 0;
                    spheretext = "<dev string:x5e>";
                    
                    switch ( self.cradle_gas.cloudsize )
                    {
                        case 4:
                            sphereradius = 350;
                            spheretext = "<dev string:x5f>";
                            break;
                        case 5:
                            sphereradius = 750;
                            spheretext = "<dev string:x63>";
                            break;
                        case 6:
                            sphereradius = 1500;
                            spheretext = "<dev string:x67>";
                            break;
                        default:
                            sphereradius = 10;
                            break;
                    }
                    
                    sphere( self.cradle_gas.origin, sphereradius, ( 1, 0, 1 ) );
                    print3d( self.cradle_gas.origin, "<dev string:x6b>" + spheretext, ( 1, 0, 1 ) );
                }
            }
            
            if ( getdvarint( @"scr_ob_activity_prop_hunt_reset", 0 ) == 1 )
            {
                prop_hunt_cleanup();
                setdvar( @"scr_ob_activity_prop_hunt_reset", 0 );
                wait 3;
                function_c51116665050a573();
                function_1bd577639d29516a();
            }
            
            waitframe();
        }
    }

#/

// Namespace ob_activity_prop_hunt
// Params 0
// Checksum 0x64a1f478, Offset: 0x2175
// Size: 0x29
function prop_hunt_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0x548d526f, Offset: 0x21a6
// Size: 0xbb
function prop_hunt_activity_success( enemykiller )
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    
    if ( enemykiller )
    {
        player = undefined;
        
        if ( isplayer( enemykiller ) )
        {
            player = enemykiller;
        }
        else if ( enemykiller.owner && isplayer( enemykiller.owner ) )
        {
            player = enemykiller.owner;
        }
        
        if ( player )
        {
            if ( !activity_participation::function_e7fc1202ac164928( self, enemykiller ) )
            {
                activity_participation::function_bc67362dace4370c( self, enemykiller, "PlayerJoinedInteract" );
            }
        }
    }
    
    wait 2;
    ob_activity_vo_utility::function_639b0047db8aec67( self, "prop_hunt_success", self.playerparticipants );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0x7c9a9d72, Offset: 0x2269
// Size: 0x21
function prop_hunt_activity_failure( player )
{
    level endon( #"game_ended" );
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0x83161ff8, Offset: 0x2292
// Size: 0x26
function prop_hunt_activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace ob_activity_prop_hunt
// Params 0
// Checksum 0x957f5e8f, Offset: 0x22c0
// Size: 0x1c
function prop_hunt_activity_destroy()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0xc8a04892, Offset: 0x22e4
// Size: 0x4e
function function_3f8bff541fe4f43c( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0x9afb6593, Offset: 0x233a
// Size: 0xdb
function function_90ab6b048b1df98f( relevant_info_struct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
    
    foreach ( player in player_list )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( "prop_hunt_brief" + "_hero", [ player ] );
    }
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0xdf3a694f, Offset: 0x241d
// Size: 0x11e
function function_c2eb887206f5775b( relevant_info_struct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !isdefined( self.var_e497c4a1bad75046 ) )
    {
        self.var_e497c4a1bad75046 = [];
    }
    
    player_list = [];
    
    if ( !self.enemy_ai )
    {
        foreach ( player in relevant_info_struct.playerlist )
        {
            if ( !arraycontains( self.var_e497c4a1bad75046, player ) )
            {
                player_list[ player_list.size ] = player;
                self.var_e497c4a1bad75046[ self.var_e497c4a1bad75046.size ] = player;
            }
        }
        
        if ( player_list.size > 0 )
        {
            ob_activity_vo_utility::function_639b0047db8aec67( self, "prop_hunt_brief", player_list );
        }
    }
    
    function_76be2b682fbdb3a6( relevant_info_struct.playerlist );
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0x152da9dd, Offset: 0x2543
// Size: 0x23
function function_35aefd3ece26dfbf( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_prop_hunt
// Params 1
// Checksum 0xe2db957c, Offset: 0x256e
// Size: 0x92
function function_292e55702b780de7( player )
{
    if ( !isarray( self.flight_school_players ) )
    {
        self.flight_school_players = [];
    }
    
    self.flight_school_players[ self.flight_school_players.size ] = player;
    
    if ( self.var_7ede550baeb15767 )
    {
        ob_story_mission_utils::function_ea26b2af32d9cfda( self.var_7ede550baeb15767, [ player ] );
        return;
    }
    
    prop_hunt_center = activity_instance_common::function_776ee11e7acc64a5( self );
    self.var_7ede550baeb15767 = ob_story_mission_utils::function_ab06e28322870f4( prop_hunt_center, 1500, [ player ] );
}

// Namespace ob_activity_prop_hunt
// Params 1, eflags: 0x4
// Checksum 0x3a9a9358, Offset: 0x2608
// Size: 0x90
function private function_76be2b682fbdb3a6( player_list )
{
    if ( self.var_7ede550baeb15767 && isarray( self.flight_school_players ) )
    {
        ob_story_mission_utils::function_2006c93a321c0277( self.var_7ede550baeb15767, player_list );
        self.flight_school_players = arrayremove( self.flight_school_players, player_list );
        self.flight_school_players = function_5713d46873b29625( self.flight_school_players );
        
        if ( self.flight_school_player.size == 0 )
        {
            self.var_7ede550baeb15767 delete();
            self.var_7ede550baeb15767 = undefined;
        }
    }
}

