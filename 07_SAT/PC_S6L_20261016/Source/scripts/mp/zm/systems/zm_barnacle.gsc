// scripts\mp\zm\systems\zm_barnacle.gsc  (hash_65c947ab368be35d.gscc) (size: 26497 Bytes / 0x6781 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce81c7c1 (3464611777)
// size ...... 26497 (0x6781)
// includes .. 20  (offset: 0x61c9)
// strings ... 49  (offset: 0x6269)
// dev strs .. 34  (offset: 0x65b9)
// exports ... 45  (offset: 0x45d9)
// cseg ...... 0x50c + 0x40cd (0x45d9)
// imports ... 158 (offset: 0x4ce1)
// animtree1 . 0   (offset: 0x6781)
// animtree2 . 0   (offset: 0x6781)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\debug;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\loot_drops;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_barnacle;

// Namespace zm_barnacle
// Params 0, eflags: 0x5
// Checksum 0xba82381a, Offset: 0x52a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_barnacle", undefined, undefined, &post_init );
}

// Namespace zm_barnacle
// Params 0
// Checksum 0x2efd096c, Offset: 0x54b
// Size: 0xd1
function post_init()
{
    if ( !getdvarint( @"enable_barnacle", 1 ) )
    {
        return;
    }
    
    level._effect[ "vfx_barnacle_reward_essence" ] = utility::load_fx( "vfx_sat_zm_weak_barnacle_cache_screen_fx_essence_gain" );
    level._effect[ "vfx_barnacle_bashed_essence" ] = utility::load_fx( "vfx_sat_zm_weak_barnacle_cache_bash_through_essence" );
    level._effect[ "vfx_barnacle_reward_salvage" ] = utility::load_fx( "vfx_sat_zm_weak_barnacle_cache_screen_fx_salvage_gain" );
    level._effect[ "vfx_barnacle_bashed_salvage" ] = utility::load_fx( "vfx_sat_zm_weak_barnacle_cache_bash_through_salvage" );
    level._effect[ "vfx_barnacle_bashed_heal" ] = utility::load_fx( "vfx_sat_zm_weak_barnacle_cache_ol_tessie_heal" );
    level utility::flag_wait( "create_script_initialized" );
    level utility::flag_wait( "scriptables_ready" );
    level thread init_barnacle_data();
    
    /#
        setup_barnacle_devgui();
        level thread debug_draw_barnacle();
    #/
}

// Namespace zm_barnacle
// Params 0, eflags: 0x4
// Checksum 0xc8624bc5, Offset: 0x624
// Size: 0xa39
function private init_barnacle_data()
{
    level endon( #"game_ended" );
    var_4ae95a2ddd411fb = utility::getstructarray( "barnacle_set", "script_noteworthy" );
    var_b7fad173ac288f7a = utility::getstructarray( "barnacle_overgrown_set", "script_noteworthy" );
    level.zm_barnacles = [];
    level.var_4f33051d6c2cdc3b = [];
    level.var_27f7b165ac055579 = [];
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_818fba7b4cde9cfc" ) )
    {
        level.barnacles_restore = utility::callsharedfunc( #"zombie", #"hash_818fba7b4cde9cfc" );
    }
    
    foreach ( root in var_4ae95a2ddd411fb )
    {
        zone = zone_manager::function_90e5c3e2272b0130( root.origin );
        level.var_27f7b165ac055579[ zone.script_zone_name ] = utility::getstructarray( root.target, "targetname" );
        var_ee5a571dfc639021 = arrayrandomize( level.var_27f7b165ac055579[ zone.script_zone_name ] );
        spawned_num = 0;
        
        foreach ( barnacle_struct in var_ee5a571dfc639021 )
        {
            barnacle_struct.sbl = spawnscriptable( %"zm_loot_veh_barnacle", barnacle_struct.origin, barnacle_struct.angles );
            barnacle_struct.sbl.save_index = int( barnacle_struct.script_noteworthy );
            barnacle_struct.sbl.zone = zone.script_zone_name;
            barnacle_struct.sbl.fn_damage_callback = &function_b5a6e7fa243d677e;
            level.zm_barnacles[ level.zm_barnacles.size ] = barnacle_struct.sbl;
            
            if ( isdefined( level.barnacles_restore ) )
            {
                if ( level.barnacles_restore[ barnacle_struct.sbl.save_index ].var_6406b411db6be5c4 )
                {
                    level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = barnacle_struct.sbl;
                    
                    /#
                        level thread debug::drawsphere( barnacle_struct.sbl.origin, 50, 10, ( 0, 1, 0 ) );
                    #/
                    
                    continue;
                }
            }
            else if ( spawned_num < 3 )
            {
                spawned_num++;
                level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = barnacle_struct.sbl;
                
                /#
                    level thread debug::drawsphere( barnacle_struct.sbl.origin, 50, 10, ( 0, 1, 0 ) );
                #/
                
                continue;
            }
            
            barnacle_struct.sbl setscriptablepartstate( "body", "dead" );
            
            /#
                level thread debug::drawsphere( barnacle_struct.sbl.origin, 50, 10, ( 0, 0, 1 ) );
            #/
        }
    }
    
    level.var_58811afe83422174 = [];
    level.var_bb5b506ca2aa7e9c = 4;
    
    foreach ( root in var_b7fad173ac288f7a )
    {
        zone = zone_manager::function_90e5c3e2272b0130( root.origin );
        level.var_58811afe83422174[ zone.script_zone_name ] = spawnstruct();
        level.var_58811afe83422174[ zone.script_zone_name ].spawned_num = 0;
        level.var_58811afe83422174[ zone.script_zone_name ].var_395649a1ecde9e39 = utility::getstructarray( root.target, "targetname" );
    }
    
    var_5f49a3a13cf33901 = 0;
    var_dc7547b1e945782f = arrayrandomize( getarraykeys( level.var_58811afe83422174 ) );
    
    foreach ( zonename in var_dc7547b1e945782f )
    {
        og_struct = level.var_58811afe83422174[ zonename ];
        
        if ( var_5f49a3a13cf33901 < 4 )
        {
            var_e7abc2951b98f090 = arrayrandomize( og_struct.var_395649a1ecde9e39 );
            
            foreach ( var_e66db791ea75a85d in var_e7abc2951b98f090 )
            {
                var_e66db791ea75a85d.sbl = function_e8571680daf60ca2( var_e66db791ea75a85d, zonename );
                
                if ( isdefined( level.barnacles_restore ) )
                {
                    if ( level.barnacles_restore[ var_e66db791ea75a85d.sbl.save_index ].var_6406b411db6be5c4 )
                    {
                        og_struct.spawned_num++;
                        level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = var_e66db791ea75a85d.sbl;
                        
                        /#
                            level thread debug::drawsphere( var_e66db791ea75a85d.sbl.origin, 50, 10, ( 1, 0, 0 ) );
                        #/
                        
                        continue;
                    }
                }
                else if ( og_struct.spawned_num < 1 )
                {
                    og_struct.spawned_num++;
                    level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = var_e66db791ea75a85d.sbl;
                    
                    /#
                        level thread debug::drawsphere( var_e66db791ea75a85d.sbl.origin, 50, 10, ( 1, 0, 0 ) );
                    #/
                    
                    continue;
                }
                
                var_e66db791ea75a85d.sbl setscriptablepartstate( "body", "dead" );
                
                /#
                    level thread debug::drawsphere( var_e66db791ea75a85d.sbl.origin, 50, 10, ( 1, 1, 0 ) );
                #/
            }
            
            var_5f49a3a13cf33901++;
            continue;
        }
        
        foreach ( var_e66db791ea75a85d in og_struct.var_395649a1ecde9e39 )
        {
            var_e66db791ea75a85d.sbl = function_e8571680daf60ca2( var_e66db791ea75a85d, zonename );
            
            if ( isdefined( level.barnacles_restore ) )
            {
                if ( level.barnacles_restore[ var_e66db791ea75a85d.sbl.save_index ].var_6406b411db6be5c4 )
                {
                    og_struct.spawned_num++;
                    level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = var_e66db791ea75a85d.sbl;
                    
                    /#
                        level thread debug::drawsphere( var_e66db791ea75a85d.sbl.origin, 50, 10, ( 1, 0, 0 ) );
                    #/
                    
                    continue;
                }
            }
            
            var_e66db791ea75a85d.sbl setscriptablepartstate( "body", "dead" );
            
            /#
                level thread debug::drawsphere( var_e66db791ea75a85d.sbl.origin, 50, 10, ( 1, 1, 0 ) );
            #/
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_b6da8d713483a2e" ) )
    {
        var_25c437f400d4409e = utility::callsharedfunc( #"zombie", #"hash_b6da8d713483a2e" );
        
        if ( var_25c437f400d4409e )
        {
            level.var_bb5b506ca2aa7e9c = var_25c437f400d4409e;
        }
    }
    
    level.zm_barnacles_bashed = [];
    
    if ( isdefined( level.barnacles_restore ) )
    {
        foreach ( Barnacle in level.zm_barnacles )
        {
            if ( level.barnacles_restore[ Barnacle.save_index ].respawn_round != 0 )
            {
                Barnacle.respawn_round = level.barnacles_restore[ Barnacle.save_index ].respawn_round;
                level.zm_barnacles_bashed[ level.zm_barnacles_bashed.size ] = Barnacle;
            }
        }
    }
    
    level callback::add( "on_round_start", &function_a3661dcc5612d745 );
    level thread function_9e12daed54bc6f53();
    scriptable::scriptable_adddamagedcallback( &function_a2527717095ff816 );
    scriptable::scriptable_adddamagedcallback( &function_b5a6e7fa243d677e );
    level utility::flag_set( "zm_barnacle_init_complete" );
}

// Namespace zm_barnacle
// Params 0
// Checksum 0xaf28c2c8, Offset: 0x1065
// Size: 0x8f
function function_9e12daed54bc6f53()
{
    level utility::flag_wait( "begin_round_logic" );
    vehicles = vehicle_getarray();
    
    foreach ( veh in vehicles )
    {
        veh thread function_649ec225d6a718b6();
    }
}

// Namespace zm_barnacle
// Params 0
// Checksum 0xe69688ed, Offset: 0x10fc
// Size: 0x2fa
function function_649ec225d6a718b6()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        corner_a = self.origin + vectornormalize( anglestoforward( self.angles ) ) * 160 + vectornormalize( anglestoright( self.angles ) ) * 64;
        corner_b = self.origin + vectornormalize( anglestoforward( self.angles ) ) * 160 - vectornormalize( anglestoright( self.angles ) ) * 64;
        corner_c = self.origin - vectornormalize( anglestoforward( self.angles ) ) * 128 - vectornormalize( anglestoright( self.angles ) ) * 64;
        corner_d = self.origin - vectornormalize( anglestoforward( self.angles ) ) * 128 + vectornormalize( anglestoright( self.angles ) ) * 64;
        
        /#
            if ( getdvarint( @"hash_5177480d02001f3d", 0 ) )
            {
                level thread debug::drawsphere( self.origin, 8, level.framedurationseconds, ( 1, 1, 1 ) );
                level thread debug::drawsphere( corner_a, 8, level.framedurationseconds, ( 1, 0, 0 ) );
                level thread debug::drawsphere( corner_b, 8, level.framedurationseconds, ( 0, 1, 0 ) );
                level thread debug::drawsphere( corner_c, 8, level.framedurationseconds, ( 1, 1, 0 ) );
                level thread debug::drawsphere( corner_d, 8, level.framedurationseconds, ( 0, 0, 1 ) );
            }
        #/
        
        foreach ( Barnacle in level.var_4f33051d6c2cdc3b )
        {
            if ( utility::function_3fa3de7c5aef7907( Barnacle.origin, corner_a, corner_b, corner_c, corner_d ) )
            {
                thread do_speed_check( self, Barnacle );
            }
        }
        
        foreach ( Barnacle in level.var_257994e11b71973e )
        {
            if ( utility::function_3fa3de7c5aef7907( Barnacle.origin, corner_a, corner_b, corner_c, corner_d ) )
            {
                thread do_speed_check( self, Barnacle );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_barnacle
// Params 0
// Checksum 0xc687405c, Offset: 0x13fe
// Size: 0x159
function init_boss_fight_barnacles()
{
    if ( !isdefined( level.var_ef3b5df7e1d9edfb ) )
    {
        level.var_ef3b5df7e1d9edfb = utility::getstructarray( "barnacle_boss_spawn", "targetname" );
    }
    
    level.zm_barnacle_boss_spawned = [];
    level.var_257994e11b71973e = [];
    
    foreach ( barnacle_struct in level.var_ef3b5df7e1d9edfb )
    {
        barnacle_struct.sbl = spawnscriptable( %"zm_loot_veh_barnacle_boss", barnacle_struct.origin, barnacle_struct.angles );
        barnacle_struct.sbl setscriptablepartstate( "body", "dead" );
        barnacle_struct.b_boss_barnacle = 1;
        barnacle_struct.sbl.barnacle_struct = barnacle_struct;
        barnacle_struct.sbl.fn_damage_callback = &function_b5a6e7fa243d677e;
        level.zm_barnacle_boss_spawned[ level.zm_barnacle_boss_spawned.size ] = barnacle_struct;
    }
    
    level utility::flag_set( "zm_barnacle_boss_init_complete" );
}

// Namespace zm_barnacle
// Params 1
// Checksum 0x488b68e, Offset: 0x155f
// Size: 0x17d
function function_b2c54b98dc238f9( num_to_spawn )
{
    var_f6735c373cf4ee10 = arrayrandomize( getarraykeys( level.zm_barnacle_boss_spawned ) );
    
    foreach ( key in var_f6735c373cf4ee10 )
    {
        barnacle_struct = level.zm_barnacle_boss_spawned[ key ];
        
        if ( level.var_257994e11b71973e.size >= num_to_spawn )
        {
            return;
        }
        
        if ( barnacle_struct.sbl getscriptablepartstate( "body" ) == "dead" || barnacle_struct.sbl getscriptablepartstate( "body" ) == "hide" )
        {
            barnacle_struct.sbl setscriptablepartstate( "body", "healthy" );
            level.var_257994e11b71973e[ level.var_257994e11b71973e.size ] = barnacle_struct.sbl;
            level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = barnacle_struct.sbl;
            
            /#
                level thread debug::drawsphere( barnacle_struct.sbl.origin, 50, 10, ( 0, 1, 0 ) );
            #/
        }
    }
}

// Namespace zm_barnacle
// Params 0
// Checksum 0x679c1f50, Offset: 0x16e4
// Size: 0xd1
function despawn_boss_barnacles()
{
    foreach ( barnacle_struct in level.zm_barnacle_boss_spawned )
    {
        level.var_4f33051d6c2cdc3b = arrayremove( level.var_4f33051d6c2cdc3b, barnacle_struct.sbl );
        level.zm_barnacle_boss_spawned = arrayremove( level.zm_barnacle_boss_spawned, barnacle_struct );
        barnacle_struct.sbl freescriptable();
    }
    
    level.var_257994e11b71973e = function_5713d46873b29625( level.var_257994e11b71973e );
}

// Namespace zm_barnacle
// Params 2, eflags: 0x4
// Checksum 0x462e089b, Offset: 0x17bd
// Size: 0xe3
function private function_e8571680daf60ca2( var_e66db791ea75a85d, zonename )
{
    sbl = spawnscriptable( %"zm_loot_veh_barnacle_grown", var_e66db791ea75a85d.origin, var_e66db791ea75a85d.angles );
    sbl.zone = zonename;
    sbl.health = 1;
    sbl.fn_damage_callback = &function_a2527717095ff816;
    sbl.spawn_struct = var_e66db791ea75a85d;
    sbl.save_index = int( var_e66db791ea75a85d.script_noteworthy );
    sbl.isovergrown = 1;
    
    if ( var_e66db791ea75a85d.script_label == "turret" )
    {
        sbl.var_628c20d6dce0f = 1;
    }
    
    level.zm_barnacles[ level.zm_barnacles.size ] = sbl;
    return sbl;
}

// Namespace zm_barnacle
// Params 5
// Checksum 0x45fe85fd, Offset: 0x18a9
// Size: 0xaf
function do_speed_check( var_7159fc685e2c5c34, instance, note, param, var_64ffacba090c91be )
{
    if ( instance.barnacle_struct.b_boss_barnacle )
    {
        if ( instance.type == "zm_loot_veh_barnacle_boss" && instance getscriptablepartstate( "body" ) != "dead" )
        {
            function_2ea20038561dc763( var_7159fc685e2c5c34, instance );
        }
        
        return;
    }
    
    if ( instance.type == "zm_loot_veh_barnacle" && instance getscriptablepartstate( "body" ) != "dead" )
    {
        function_e5397e6e9004315e( var_7159fc685e2c5c34, instance );
    }
}

// Namespace zm_barnacle
// Params 3, eflags: 0x4
// Checksum 0xe6cffb41, Offset: 0x1960
// Size: 0x130
function private function_2ea20038561dc763( var_7159fc685e2c5c34, instance, var_c63013acd02dce4b )
{
    function_b88e933c97427c5d( var_7159fc685e2c5c34 );
    instance setscriptablepartstate( "body", "dead" );
    level.var_257994e11b71973e = arrayremove( level.var_257994e11b71973e, instance );
    level.var_4f33051d6c2cdc3b = arrayremove( level.var_4f33051d6c2cdc3b, instance );
    
    foreach ( pingplayer in level.players )
    {
        if ( pingplayer function_333d9cb29c9abb4f( instance.index ) )
        {
            instance calloutmarkerping::function_608710c894185549( pingplayer );
        }
    }
    
    function_b9b01504a6da80a3( var_7159fc685e2c5c34, 50 * randomintrange( 3, 7 ), instance, var_c63013acd02dce4b );
    function_562acd29839753a0( var_7159fc685e2c5c34 );
    thread function_2764b9c5c2d64d50( !level.var_81dc9de2fda86a3f );
    thread function_b3c7d76f562ef5a3( instance );
}

// Namespace zm_barnacle
// Params 1, eflags: 0x4
// Checksum 0xec74fcef, Offset: 0x1a98
// Size: 0xcc
function private function_b3c7d76f562ef5a3( instance )
{
    if ( level.var_81dc9de2fda86a3f )
    {
        return;
    }
    
    var_a712fa995ed763f3 = getdvarint( @"hash_2628a45f8bffd4f7", 60 );
    wait var_a712fa995ed763f3;
    
    if ( instance && ( instance getscriptablepartstate( "body" ) == "dead" || instance getscriptablepartstate( "body" ) == "hide" ) )
    {
        instance setscriptablepartstate( "body", "healthy" );
        level.var_257994e11b71973e[ level.var_257994e11b71973e.size ] = instance;
        level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = instance;
        
        /#
            level thread debug::drawsphere( instance.origin, 50, 10, ( 0, 1, 0 ) );
        #/
    }
}

// Namespace zm_barnacle
// Params 3, eflags: 0x4
// Checksum 0x3924576, Offset: 0x1b6c
// Size: 0x10f
function private function_e5397e6e9004315e( var_7159fc685e2c5c34, instance, var_c63013acd02dce4b )
{
    function_b88e933c97427c5d( var_7159fc685e2c5c34 );
    instance setscriptablepartstate( "body", "dead" );
    level.var_4f33051d6c2cdc3b = arrayremove( level.var_4f33051d6c2cdc3b, instance );
    
    foreach ( pingplayer in level.players )
    {
        if ( pingplayer function_333d9cb29c9abb4f( instance.index ) )
        {
            instance calloutmarkerping::function_608710c894185549( pingplayer );
        }
    }
    
    instance function_5d6f878c0c9e16f4( 2 );
    function_8f1be50175bfa5b1( var_7159fc685e2c5c34, 100 * randomintrange( 1, 4 ), instance, var_c63013acd02dce4b );
    thread function_2764b9c5c2d64d50();
    level thread function_2f61319394992bb8();
}

// Namespace zm_barnacle
// Params 1
// Checksum 0x946a8a3d, Offset: 0x1c83
// Size: 0x120
function function_b88e933c97427c5d( var_7159fc685e2c5c34 )
{
    occupants = vehicle_occupancy::get_all_occupants( var_7159fc685e2c5c34, 0 );
    
    if ( !isdefined( occupants ) )
    {
        occupants = [];
    }
    
    foreach ( player in level.players )
    {
        if ( player getmovingplatformparent() == var_7159fc685e2c5c34 && !arraycontains( occupants, player ) )
        {
            occupants[ occupants.size ] = player;
        }
    }
    
    foreach ( player in occupants )
    {
        player thread player_rumble( 1 );
    }
}

// Namespace zm_barnacle
// Params 2
// Checksum 0x4ae06056, Offset: 0x1dab
// Size: 0x80
function player_rumble( time, override_rumble )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( override_rumble ) )
    {
        override_rumble = "damage_light";
    }
    
    start_time = gettime();
    
    while ( true )
    {
        lasttime = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        self playrumbleonentity( override_rumble );
        
        if ( lasttime > time )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_barnacle
// Params 1
// Checksum 0xbc80fb35, Offset: 0x1e33
// Size: 0xfd
function function_2764b9c5c2d64d50( is_boss_barnacle )
{
    if ( isdefined( self.health ) && isdefined( self.maxhealth ) )
    {
        if ( self.vehiclename == "veh_sat_firefly_pluto" )
        {
            health_increment = randomintrange( 10, 16 ) * self.maxhealth / 100;
            
            if ( is_boss_barnacle )
            {
                health_increment = randomintrange( 12, 20 ) * self.maxhealth / 100;
            }
            
            var_be778dcbb8ee1dc6 = self.health + health_increment;
            var_8075cf7ba03c56d3 = var_be778dcbb8ee1dc6 < self.maxhealth ? var_be778dcbb8ee1dc6 : self.maxhealth;
            vehicle_damage::set_health( var_8075cf7ba03c56d3 );
            playfxontag( utility::getfx( "vfx_barnacle_bashed_heal" ), self, "tag_origin" );
            self setscriptablepartstate( "upgrades", "partialhealthrestore" );
            
            if ( isdefined( self.var_b59ff7c648465b45 ) )
            {
                [[ self.var_b59ff7c648465b45 ]]( self, 1 );
            }
        }
    }
}

// Namespace zm_barnacle
// Params 11, eflags: 0x4
// Checksum 0xce9f3b17, Offset: 0x1f38
// Size: 0x15b
function private function_a2527717095ff816( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_loot_veh_barnacle_grown" )
    {
        return;
    }
    
    if ( objweapon.basename == "sat_pluto_dg2" )
    {
        if ( isplayer( eattacker.occupants[ "gunner" ] ) )
        {
            eattacker.occupants[ "gunner" ] damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
        }
        
        function_2f3c6dcc58460653( instance );
        return;
    }
    
    if ( einflictor == level.wonder_veh && smeansofdeath == "MOD_ELEMENTAL_ELEC" )
    {
        if ( instance.already_hit )
        {
            return;
        }
        
        instance.already_hit = 1;
        wait 0.5;
        
        if ( isplayer( eattacker ) )
        {
            eattacker damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
        }
        
        function_2f3c6dcc58460653( instance );
        instance.already_hit = undefined;
        return;
    }
    
    instance setscriptablepartstate( "audio_repel", "on" );
}

// Namespace zm_barnacle
// Params 11, eflags: 0x4
// Checksum 0x5af4dcbd, Offset: 0x209b
// Size: 0x1b8
function private function_b5a6e7fa243d677e( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"zm_loot_veh_barnacle" && instance.type != %"zm_loot_veh_barnacle_boss" )
    {
        return;
    }
    
    if ( objweapon.basename == "sat_pluto_dg2" )
    {
        if ( isplayer( eattacker.occupants[ "gunner" ] ) )
        {
            eattacker.occupants[ "gunner" ] damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
        }
        
        if ( instance.type == %"zm_loot_veh_barnacle_boss" )
        {
            eattacker function_2ea20038561dc763( eattacker, instance, 1 );
        }
        else
        {
            eattacker function_e5397e6e9004315e( eattacker, instance, 1 );
        }
        
        return;
    }
    
    if ( einflictor == level.wonder_veh && smeansofdeath == "MOD_ELEMENTAL_ELEC" )
    {
        if ( instance.already_hit )
        {
            return;
        }
        
        instance.already_hit = 1;
        wait 0.5;
        
        if ( isplayer( eattacker ) )
        {
            eattacker damagefeedback::updatehitmarker( "standard", 1, 0, 0, undefined );
        }
        
        if ( instance.type == %"zm_loot_veh_barnacle_boss" )
        {
            einflictor function_2ea20038561dc763( einflictor, instance, 1 );
        }
        else
        {
            einflictor function_e5397e6e9004315e( einflictor, instance, 1 );
        }
        
        instance.already_hit = undefined;
    }
}

// Namespace zm_barnacle
// Params 1
// Checksum 0xb90184ab, Offset: 0x225b
// Size: 0x11a
function function_2f3c6dcc58460653( instance )
{
    instance setscriptablepartstate( "body", "dead" );
    level.var_4f33051d6c2cdc3b = arrayremove( level.var_4f33051d6c2cdc3b, instance );
    
    foreach ( pingplayer in level.players )
    {
        if ( pingplayer function_333d9cb29c9abb4f( instance.index ) )
        {
            instance calloutmarkerping::function_608710c894185549( pingplayer );
        }
    }
    
    level.var_58811afe83422174[ instance.zone ].spawned_num--;
    
    if ( level.var_bb5b506ca2aa7e9c < getdvarint( @"hash_4ba5de7746f1f6ae", 12 ) )
    {
        instance function_5d6f878c0c9e16f4( randomintrange( 2, 4 ) );
    }
    
    level thread spawn_barnacle_grown_loot( instance );
}

// Namespace zm_barnacle
// Params 1, eflags: 0x4
// Checksum 0x381e0f3c, Offset: 0x237d
// Size: 0x316
function private spawn_barnacle_grown_loot( instance )
{
    loot_spawn_struct = utility::getstruct( instance.spawn_struct.target, "targetname" );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( loot_spawn_struct.origin, instance.origin );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_2321e933cbdf46d8 = 25;
    spawnoptions.var_34444f0dda11f0d5 = 30;
    spawnoptions.var_18608bd8660b3a19 = 2;
    spawnoptions.var_aec43e9d95b191f9 = 2;
    spawnoptions.var_12d76a8b35ac875d = 6;
    spawnoptions.var_8934e0ace9b7d996 = -5;
    spawnoptions.var_8958d2ace9e03584 = 5;
    spawnoptions.var_d72f168a0f299753 = -1;
    spawnoptions.var_d7522c8a0f500f6d = 1;
    spawnoptions.var_8f2dd74e9b3d807d = 1;
    spawnoptions.var_789c456dda9c8572 = instance.origin + ( 0, 0, 50 );
    var_2dafb15abbd6a4e8 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_loot_barnacle_rewards", "Default" );
    var_9513d02deaaa43da = randomintrange( 1, 3 );
    var_8b5270de14dff72e = [];
    
    for ( i = 0; i < var_9513d02deaaa43da ; i++ )
    {
        var_9db546dd475c8eea = utility::array_random( var_2dafb15abbd6a4e8 );
        var_2dafb15abbd6a4e8 = arrayremove( var_2dafb15abbd6a4e8, var_9db546dd475c8eea );
        var_8b5270de14dff72e[ var_8b5270de14dff72e.size ] = var_9db546dd475c8eea;
    }
    
    currency_amount = 100 * randomintrange( 3, 6 );
    
    if ( level utility::percent_chance( 50 ) )
    {
        for ( i = 0; i < currency_amount / 100 ; i++ )
        {
            var_8b5270de14dff72e[ var_8b5270de14dff72e.size ] = %"itemspawnentry:zm_t10_item_essence_small";
        }
    }
    else
    {
        for ( i = 0; i < currency_amount / 50 ; i++ )
        {
            var_8b5270de14dff72e[ var_8b5270de14dff72e.size ] = %"itemspawnentry:zm_t10_item_salvage_green";
            loot_drops::init_per_player_spawn_options( spawnoptions, level.players, instance.origin );
        }
    }
    
    if ( utility::issharedfuncdefined( #"zm_barnacle", #"hash_78226dc4738cf984" ) )
    {
        var_cfb3ac195b0d1594 = utility::callsharedfunc( #"zm_barnacle", #"hash_78226dc4738cf984" );
        var_8b5270de14dff72e = arraycombine( var_8b5270de14dff72e, var_cfb3ac195b0d1594 );
    }
    
    spawnoptions.var_44d5025c8cfbd48e = var_8b5270de14dff72e.size;
    a_spawneditems = [];
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        
        if ( !itemspawnentryname )
        {
            continue;
        }
        
        itembundle = getscriptbundle( itemspawnentryname );
        assert( itembundle, "<dev string:x24>" + getxhashsourcename( itemspawnentryname ) + "<dev string:x57>" );
        
        if ( !itembundle )
        {
            continue;
        }
        
        spawneditem = common_item::function_61c2c0251e742ffd( itemspawnentryname, undefined, spawnoptions );
        a_spawneditems[ a_spawneditems.size ] = spawneditem;
        wait 0.25;
    }
    
    level callback::callback( "spawn_barnacle_grown_loot", { #itemsspawned:a_spawneditems } );
}

// Namespace zm_barnacle
// Params 3
// Checksum 0xb35c2f29, Offset: 0x269b
// Size: 0xee
function spawn_drop_item( item, instance, var_7159fc685e2c5c34 )
{
    from_origin = instance.origin + ( 0, 0, 100 );
    var_e02bf8684385ee2e = vectornormalize( instance.origin - var_7159fc685e2c5c34.origin );
    var_21c3b67f1a74cd8e = getrandomnavpoint( instance.origin + var_e02bf8684385ee2e * 256, 64 );
    
    if ( !isdefined( var_21c3b67f1a74cd8e ) )
    {
        var_21c3b67f1a74cd8e = instance.origin;
    }
    
    drop_origin_ground = utility::drop_to_ground( var_21c3b67f1a74cd8e, 100 );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( drop_origin_ground, from_origin );
    spawnoptions = loot_drops::init_per_player_spawn_options( spawnoptions, level.players, instance.origin );
    item = common_item::function_61c2c0251e742ffd( item, undefined, spawnoptions );
}

// Namespace zm_barnacle
// Params 1
// Checksum 0xbe568504, Offset: 0x2791
// Size: 0x11e
function function_562acd29839753a0( var_7159fc685e2c5c34 )
{
    occupants = vehicle_occupancy::get_all_occupants( var_7159fc685e2c5c34, 0 );
    
    if ( !isdefined( occupants ) )
    {
        occupants = [];
    }
    
    foreach ( player in level.players )
    {
        if ( player getmovingplatformparent() == var_7159fc685e2c5c34 && !arraycontains( occupants, player ) )
        {
            occupants[ occupants.size ] = player;
        }
    }
    
    foreach ( player in occupants )
    {
        function_fc0ba377b4b5b73e( player );
    }
}

// Namespace zm_barnacle
// Params 1, eflags: 0x4
// Checksum 0xbc96db42, Offset: 0x28b7
// Size: 0x1b5
function private function_fc0ba377b4b5b73e( player )
{
    primary_weapons = player getweaponslistprimaries();
    
    foreach ( primary_weapon in primary_weapons )
    {
        ammogain = 0.1;
        
        if ( primary_weapon.inventorytype == "primary" && !weapon::iskillstreakweapon( primary_weapon ) )
        {
            var_7ee2cd26e86a1ceb = weapon::iswonderweapon( primary_weapon );
            
            if ( var_7ee2cd26e86a1ceb )
            {
                ammogain = 0.02;
                
                if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_parting_gift" ) )
                {
                    ammogain = level.zombie_augments[ #"vulture_aid_parting_gift" ].var_6406bc09d53992e7 ?? 0.02;
                }
            }
            
            if ( primary_weapon.reloaddisabled )
            {
                maxclipammo = weaponclipsize( primary_weapon );
                new_amount = int( min( player getweaponammoclip( primary_weapon ) + maxclipammo * ammogain, maxclipammo ) );
                player setweaponammoclip( primary_weapon, new_amount );
                continue;
            }
            
            var_5d0c831b13e279b6 = player getweaponammostock( primary_weapon );
            new_amount = var_5d0c831b13e279b6 + max( 1, primary_weapon.maxammo * ammogain );
            new_amount = min( new_amount, primary_weapon.maxammo );
            player setweaponammostock( primary_weapon, int( new_amount ) );
        }
    }
}

// Namespace zm_barnacle
// Params 4
// Checksum 0x5dfc562, Offset: 0x2a74
// Size: 0x279
function function_b9b01504a6da80a3( var_7159fc685e2c5c34, currency_amount, instance, var_c63013acd02dce4b = 0 )
{
    if ( var_c63013acd02dce4b )
    {
        for ( i = 0; i < currency_amount / 50 ; i++ )
        {
            spawn_drop_item( %"itemspawnentry:zm_t10_item_salvage_green", instance, var_7159fc685e2c5c34 );
            playfx( utility::getfx( "vfx_barnacle_bashed_salvage" ), instance.origin );
            playsoundatpos( instance.origin, #"hash_779709ab48c1749f" );
        }
        
        return;
    }
    
    occupants = vehicle_occupancy::get_all_occupants( var_7159fc685e2c5c34, 0 );
    
    if ( !isdefined( occupants ) )
    {
        occupants = [];
    }
    
    foreach ( player in level.players )
    {
        if ( player getmovingplatformparent() == var_7159fc685e2c5c34 && !arraycontains( occupants, player ) )
        {
            occupants[ occupants.size ] = player;
        }
    }
    
    if ( occupants.size == 0 )
    {
        for ( i = 0; i < currency_amount / 50 ; i++ )
        {
            spawn_drop_item( %"itemspawnentry:zm_t10_item_salvage_green", instance, var_7159fc685e2c5c34 );
            playfx( utility::getfx( "vfx_barnacle_bashed_salvage" ), instance.origin );
            playsoundatpos( instance.origin, #"hash_779709ab48c1749f" );
        }
    }
    
    foreach ( player in occupants )
    {
        player currency::add_currency_amount( #"salvage", currency_amount );
        player thread function_7a5a1a9984bc67bb( currency_amount, 85221 );
        playfx( utility::getfx( "vfx_barnacle_bashed_salvage" ), instance.origin );
        playfxontagforclients( utility::getfx( "vfx_barnacle_reward_salvage" ), player, "tag_origin", player );
        player playlocalsound( #"hash_25c3ba80d43d7840" );
        player playsoundonmovingent( getxhash( "evt_zm_core_pickup_salvage_pickup" ) );
    }
}

// Namespace zm_barnacle
// Params 4
// Checksum 0x7ad2b622, Offset: 0x2cf5
// Size: 0x3c1
function function_8f1be50175bfa5b1( var_7159fc685e2c5c34, currency_amount, instance, var_c63013acd02dce4b = 0 )
{
    if ( var_c63013acd02dce4b )
    {
        if ( level utility::percent_chance( 50 ) )
        {
            for ( i = 0; i < currency_amount / 100 ; i++ )
            {
                spawn_drop_item( %"itemspawnentry:zm_t10_item_essence_small", instance, var_7159fc685e2c5c34 );
                playfx( utility::getfx( "vfx_barnacle_bashed_essence" ), instance.origin );
                playsoundatpos( instance.origin, #"hash_ff9803ec1908fbae" );
            }
            
            return;
        }
        
        for ( i = 0; i < currency_amount / 50 ; i++ )
        {
            spawn_drop_item( %"itemspawnentry:zm_t10_item_salvage_green", instance, var_7159fc685e2c5c34 );
            playfx( utility::getfx( "vfx_barnacle_bashed_salvage" ), instance.origin );
            playsoundatpos( instance.origin, #"hash_779709ab48c1749f" );
        }
        
        return;
    }
    
    occupants = vehicle_occupancy::get_all_occupants( var_7159fc685e2c5c34, 0 );
    
    if ( !isdefined( occupants ) )
    {
        occupants = [];
    }
    
    foreach ( player in level.players )
    {
        if ( player getmovingplatformparent() == var_7159fc685e2c5c34 && !arraycontains( occupants, player ) )
        {
            occupants[ occupants.size ] = player;
        }
    }
    
    if ( occupants.size == 0 )
    {
        if ( level utility::percent_chance( 50 ) )
        {
            for ( i = 0; i < currency_amount / 100 ; i++ )
            {
                spawn_drop_item( %"itemspawnentry:zm_t10_item_essence_small", instance, var_7159fc685e2c5c34 );
                playfx( utility::getfx( "vfx_barnacle_bashed_essence" ), instance.origin );
                playsoundatpos( instance.origin, #"hash_ff9803ec1908fbae" );
            }
        }
        else
        {
            for ( i = 0; i < currency_amount / 50 ; i++ )
            {
                spawn_drop_item( %"itemspawnentry:zm_t10_item_salvage_green", instance, var_7159fc685e2c5c34 );
                playfx( utility::getfx( "vfx_barnacle_bashed_salvage" ), instance.origin );
                playsoundatpos( instance.origin, #"hash_779709ab48c1749f" );
            }
        }
    }
    
    foreach ( player in occupants )
    {
        if ( randomint( 100 ) < 50 )
        {
            player currency::add_currency_amount( #"essence", currency_amount );
            player thread function_7a5a1a9984bc67bb( currency_amount, 121443 );
            playfx( utility::getfx( "vfx_barnacle_bashed_essence" ), instance.origin );
            playfxontagforclients( utility::getfx( "vfx_barnacle_reward_essence" ), player, "tag_origin", player );
            player playlocalsound( #"hash_9d38aa8a408f0b3b" );
        }
        else
        {
            player currency::add_currency_amount( #"salvage", currency_amount );
            player thread function_7a5a1a9984bc67bb( currency_amount, 85221 );
            playfx( utility::getfx( "vfx_barnacle_bashed_salvage" ), instance.origin );
            playfxontagforclients( utility::getfx( "vfx_barnacle_reward_salvage" ), player, "tag_origin", player );
            player playlocalsound( #"hash_25c3ba80d43d7840" );
        }
        
        player playsoundonmovingent( getxhash( "evt_zm_core_pickup_salvage_pickup" ) );
    }
}

// Namespace zm_barnacle
// Params 2
// Checksum 0xd4c5ee1, Offset: 0x30be
// Size: 0x5b
function function_7a5a1a9984bc67bb( currency_amount, lootid )
{
    self notify( #"hash_92ee10be2566118d" );
    self endon( #"disconnect" );
    self setclientomnvar( "ui_loot_splash_item_quantity", currency_amount );
    self setclientomnvar( "ui_loot_splash_item_id", lootid );
    self endon( #"hash_92ee10be2566118d" );
    waitframe();
    common_item::function_dba5cd48d3cd08cb();
}

// Namespace zm_barnacle
// Params 1
// Checksum 0xa0f6b93d, Offset: 0x3121
// Size: 0x37
function function_5d6f878c0c9e16f4( gap_rounds )
{
    self.respawn_round = zm_utility::get_round_number() + gap_rounds + 1;
    level.zm_barnacles_bashed[ level.zm_barnacles_bashed.size ] = self;
}

// Namespace zm_barnacle
// Params 2
// Checksum 0x8cbe2a12, Offset: 0x3160
// Size: 0x4e4
function function_a3661dcc5612d745( params, var_260fe40153fbe0fd )
{
    current_round = zm_utility::get_round_number();
    zm_barnacles_bashed = arraycopy( level.zm_barnacles_bashed );
    
    foreach ( Barnacle in zm_barnacles_bashed )
    {
        if ( Barnacle.respawn_round <= current_round || var_260fe40153fbe0fd )
        {
            if ( Barnacle.type == "zm_loot_veh_barnacle" )
            {
                rand_set = arrayrandomize( level.var_27f7b165ac055579[ Barnacle.zone ] );
                
                foreach ( barnacle_struct in rand_set )
                {
                    if ( barnacle_struct.sbl getscriptablepartstate( "body" ) == "dead" )
                    {
                        barnacle_struct.sbl setscriptablepartstate( "body", "healthy" );
                        level.zm_barnacles_bashed = arrayremove( level.zm_barnacles_bashed, Barnacle );
                        Barnacle.respawn_round = undefined;
                        level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = barnacle_struct.sbl;
                        
                        /#
                            level thread debug::drawsphere( barnacle_struct.sbl.origin, 50, 10, ( 0, 1, 0 ) );
                        #/
                        
                        break;
                    }
                }
                
                continue;
            }
            
            var_dc7547b1e945782f = arrayrandomize( getarraykeys( level.var_58811afe83422174 ) );
            
            foreach ( key in var_dc7547b1e945782f )
            {
                og_struct = level.var_58811afe83422174[ key ];
                
                if ( og_struct.spawned_num >= 1 )
                {
                    continue;
                }
                
                spawned_this_round = 0;
                rand_set = arrayrandomize( og_struct.var_395649a1ecde9e39 );
                
                foreach ( var_9b5e8e6c7b451c06 in rand_set )
                {
                    if ( var_9b5e8e6c7b451c06.sbl getscriptablepartstate( "body" ) != "dead" )
                    {
                        continue;
                    }
                    
                    var_e7476cf4916b5a8 = zone_manager::function_90e5c3e2272b0130( var_9b5e8e6c7b451c06.origin );
                    var_3c0a068fd7c14637 = 0;
                    
                    foreach ( player in level.players )
                    {
                        if ( zone_manager::is_touching_zone( var_e7476cf4916b5a8, player ) )
                        {
                            break;
                        }
                        
                        trace = player trace::player_viewangles();
                        
                        if ( trace[ "scriptable" ] == var_9b5e8e6c7b451c06.sbl )
                        {
                            break;
                        }
                        
                        var_3c0a068fd7c14637 = 1;
                    }
                    
                    if ( var_3c0a068fd7c14637 )
                    {
                        var_9b5e8e6c7b451c06.sbl setscriptablepartstate( "body", "healthy" );
                        spawned_this_round = 1;
                        level.var_bb5b506ca2aa7e9c++;
                        og_struct.spawned_num++;
                        level.zm_barnacles_bashed = arrayremove( level.zm_barnacles_bashed, Barnacle );
                        Barnacle.respawn_round = undefined;
                        level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = var_9b5e8e6c7b451c06.sbl;
                        
                        /#
                            level thread debug::drawsphere( var_9b5e8e6c7b451c06.sbl.origin, 50, 10, ( 1, 0, 0 ) );
                        #/
                        
                        break;
                    }
                }
                
                if ( spawned_this_round )
                {
                    break;
                }
            }
        }
    }
}

// Namespace zm_barnacle
// Params 0, eflags: 0x4
// Checksum 0xd031c88a, Offset: 0x364c
// Size: 0x6e
function private function_2f61319394992bb8()
{
    level endon( #"game_ended" );
    player = level.wonder_veh.occupants[ "driver" ];
    
    if ( isplayer( player ) && !player utility::ent_flag( "played_barnacle_bash_vo_first_time" ) )
    {
        player utility::ent_flag_set( "played_barnacle_bash_vo_first_time" );
        player zm_vo::function_8c1a12974bd11f01( #"hash_2a784f31ff3b8b88" );
    }
}

/#

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0x755d638a, Offset: 0x36c2
    // Size: 0xeb, Type: dev
    function private setup_barnacle_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x59>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x77>", "<dev string:x89>", &function_a538df86f6e32f0f, 0 );
        devgui::add_devgui_func( "<dev string:xa9>", "<dev string:xcc>", &function_3d437184de08e541 );
        devgui::add_devgui_func( "<dev string:xe6>", "<dev string:x109>", &function_1ee77e872c62a468 );
        devgui::add_devgui_func( "<dev string:x12c>", "<dev string:x146>", &function_b29e0c7ce27bbcfd );
        devgui::add_devgui_func( "<dev string:x160>", "<dev string:x17f>", &function_fd60267f804e4163 );
        devgui::add_devgui_func( "<dev string:x19e>", "<dev string:x1b9>", &function_72850f44694944c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1d4>", "<dev string:x1e4>" + 121443, &function_52a3048492249d3e );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1fc>", "<dev string:x1e4>" + 85221, &function_52a3048492249d3e );
        devgui::add_devgui_func( "<dev string:x20c>", "<dev string:x21c>", &function_d8e4957d5dcebd42 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_barnacle
    // Params 1
    // Checksum 0xd019d412, Offset: 0x37b5
    // Size: 0x1b, Type: dev
    function function_a538df86f6e32f0f( params )
    {
        level function_a3661dcc5612d745( params, 1 );
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0x21cf00bc, Offset: 0x37d8
    // Size: 0x9d, Type: dev
    function private function_3d437184de08e541()
    {
        foreach ( Barnacle in level.zm_barnacles )
        {
            Barnacle setscriptablepartstate( "<dev string:x235>", "<dev string:x23a>" );
            level.var_4f33051d6c2cdc3b[ level.var_4f33051d6c2cdc3b.size ] = Barnacle;
        }
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0xe5859a84, Offset: 0x387d
    // Size: 0xaa, Type: dev
    function private function_1ee77e872c62a468()
    {
        foreach ( Barnacle in level.zm_barnacles )
        {
            if ( Barnacle.type == %"zm_loot_veh_barnacle_grown" )
            {
                if ( Barnacle getscriptablepartstate( "<dev string:x235>" ) == "<dev string:x23a>" )
                {
                    function_2f3c6dcc58460653( Barnacle );
                }
            }
        }
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0xf9878c9e, Offset: 0x392f
    // Size: 0x31, Type: dev
    function private function_b29e0c7ce27bbcfd()
    {
        if ( level utility::flag( "<dev string:x242>" ) )
        {
            level utility::flag_clear( "<dev string:x242>" );
            return;
        }
        
        level utility::flag_set( "<dev string:x242>" );
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0xc
    // Checksum 0x2b69da8d, Offset: 0x3968
    // Size: 0x141, Type: dev
    function private debug_draw_barnacle()
    {
        self notify( #"hash_719a00fbd89841eb" );
        self endon( #"hash_719a00fbd89841eb" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            utility::flag_wait( "<dev string:x242>" );
            me = level.players[ 0 ];
            
            foreach ( Barnacle in level.var_4f33051d6c2cdc3b )
            {
                if ( Barnacle.isovergrown )
                {
                    me thread function_4641de835d2d7cb( Barnacle, "<dev string:x257>" + Barnacle.zone, ( 1, 0, 0 ), 20 );
                    continue;
                }
                
                me thread function_4641de835d2d7cb( Barnacle, "<dev string:x26b>" + Barnacle.zone, ( 0, 0, 1 ), 20 );
            }
            
            utility::flag_wait( "<dev string:x242>" );
            me notify( #"hash_3d3990b273e1f2e9" );
            waitframe();
        }
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0x1802a920, Offset: 0x3ab1
    // Size: 0x16, Type: dev
    function private function_fd60267f804e4163()
    {
        function_b2c54b98dc238f9( level.var_ef3b5df7e1d9edfb.size );
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0xa7457a95, Offset: 0x3acf
    // Size: 0xc, Type: dev
    function private function_72850f44694944c()
    {
        despawn_boss_barnacles();
    }

    // Namespace zm_barnacle
    // Params 1, eflags: 0x4
    // Checksum 0x1f5520b4, Offset: 0x3ae3
    // Size: 0x4e, Type: dev
    function private function_52a3048492249d3e( params )
    {
        player = level.players[ 0 ];
        loot_id = int( params[ 0 ] );
        currency_amount = 100;
        player thread function_7a5a1a9984bc67bb( currency_amount, loot_id );
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0xc
    // Checksum 0xb344f51d, Offset: 0x3b39
    // Size: 0x29f, Type: dev
    function private function_d8e4957d5dcebd42()
    {
        self notify( #"hash_e030126421b002d4" );
        self endon( #"hash_e030126421b002d4" );
        
        if ( level utility::flag( "<dev string:x275>" ) )
        {
            level utility::flag_clear( "<dev string:x275>" );
            level notify( #"hash_b8b0d06d58abe782" );
            level notify( #"hash_37a7c03c9e345893" );
            return;
        }
        
        level utility::flag_set( "<dev string:x275>" );
        function_2142218dc4047a24();
        function_3c4659e0caad7a46();
        line_height = 22;
        x = 460;
        line_scale = 2;
        green = ( 0.2, 1, 0 );
        red = ( 0.8, 0.2, 0 );
        var_c6c02a6801e8f348 = ( 1, 1, 0.3 );
        
        while ( true )
        {
            var_5b35537680a30058 = 100;
            printtoscreen2d( x, var_5b35537680a30058, "<dev string:x292>", var_c6c02a6801e8f348, line_scale, 1 );
            var_5b35537680a30058 += line_height;
            
            foreach ( Barnacle in level.zm_barnacles )
            {
                if ( Barnacle.isovergrown )
                {
                    state = Barnacle getscriptablepartstate( "<dev string:x235>" );
                    is_healthy = state == "<dev string:x23a>";
                    printtoscreen2d( x, var_5b35537680a30058, Barnacle.zone + "<dev string:x297>" + state, is_healthy ? green : red, line_scale, 1 );
                    var_5b35537680a30058 += line_height;
                }
            }
            
            var_5b35537680a30058 += 2 * line_height;
            printtoscreen2d( x, var_5b35537680a30058, "<dev string:x299>", var_c6c02a6801e8f348, line_scale, 1 );
            var_5b35537680a30058 += line_height;
            
            foreach ( Barnacle in level.var_4f33051d6c2cdc3b )
            {
                if ( Barnacle.isovergrown )
                {
                    string = "<dev string:x29f>" + Barnacle.zone;
                    printtoscreen2d( x, var_5b35537680a30058, string, green, line_scale, 1 );
                    var_5b35537680a30058 += line_height;
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0x86f4a6ca, Offset: 0x3de0
    // Size: 0x197, Type: dev
    function private function_2142218dc4047a24()
    {
        zone_colors = [];
        r = 0.5;
        
        while ( r <= 0.9 )
        {
            g = 0.5;
            
            while ( g <= 0.9 )
            {
                zone_colors[ zone_colors.size ] = ( r, g, 0.4 );
                g += 0.2;
            }
            
            r += 0.2;
        }
        
        zone_index = 0;
        zones = [];
        
        foreach ( Barnacle in level.zm_barnacles )
        {
            if ( Barnacle.isovergrown )
            {
                if ( !isdefined( zones[ Barnacle.zone ] ) )
                {
                    zones[ Barnacle.zone ] = {};
                    zones[ Barnacle.zone ].barnacles = [];
                    zones[ Barnacle.zone ].color = zone_colors[ zone_index ];
                    zone_index++;
                }
                
                zones[ Barnacle.zone ].barnacles[ zones[ Barnacle.zone ].barnacles.size ] = Barnacle;
            }
        }
        
        level thread function_61e760cbb6002b62( zones );
    }

    // Namespace zm_barnacle
    // Params 1, eflags: 0xc
    // Checksum 0x1893cb47, Offset: 0x3f7f
    // Size: 0x276, Type: dev
    function private function_61e760cbb6002b62( zones )
    {
        self notify( #"hash_a780cfbc8d0dab14" );
        self endon( #"hash_a780cfbc8d0dab14" );
        level endon( #"game_ended", #"hash_b8b0d06d58abe782" );
        
        while ( true )
        {
            foreach ( zone_name, zone_data in zones )
            {
                mid = undefined;
                line_map = [];
                
                for ( i = 0; i < zone_data.barnacles.size ; i++ )
                {
                    Barnacle = zone_data.barnacles[ i ];
                    sphere( Barnacle.origin, 10, zone_data.color );
                    print3d( Barnacle.origin, zone_name, zone_data.color );
                    
                    if ( i == 0 && zone_data.barnacles.size > 1 )
                    {
                        last = zone_data.barnacles[ zone_data.barnacles.size - 1 ];
                        line( last.origin, Barnacle.origin, zone_data.color );
                        line_map[ zone_data.barnacles.size - 1 ] = 0;
                    }
                    else if ( i > 0 && line_map[ i ] != i - 1 )
                    {
                        previous = zone_data.barnacles[ i - 1 ];
                        line( previous.origin, Barnacle.origin, zone_data.color );
                        line_map[ i - 1 ] = i;
                    }
                    
                    if ( !mid )
                    {
                        mid = Barnacle.origin;
                        continue;
                    }
                    
                    mid += Barnacle.origin;
                }
                
                if ( zone_data.barnacles.size > 0 )
                {
                    mid /= zone_data.barnacles.size;
                    print3d( mid, zone_name, zone_data.color, 1, 10, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace zm_barnacle
    // Params 0, eflags: 0x4
    // Checksum 0x2cd94e25, Offset: 0x41fd
    // Size: 0xc7, Type: dev
    function private function_3c4659e0caad7a46()
    {
        me = level.players[ 0 ];
        
        foreach ( Barnacle in level.var_4f33051d6c2cdc3b )
        {
            if ( Barnacle.isovergrown )
            {
                me thread function_4641de835d2d7cb( Barnacle, "<dev string:x2a0>" + Barnacle.zone, ( 0, 1, 0 ), 20, "<dev string:x2ab>" );
            }
        }
    }

    // Namespace zm_barnacle
    // Params 5, eflags: 0x4
    // Checksum 0x428790b6, Offset: 0x42cc
    // Size: 0x169, Type: dev
    function private function_4641de835d2d7cb( target, print_text, color, sphere_radius, var_70c924e39383a6dd )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x29f>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 10;
        }
        
        level endon( #"game_ended", #"hash_46463259080ca314" );
        
        if ( var_70c924e39383a6dd )
        {
            if ( isarray( var_70c924e39383a6dd ) )
            {
                foreach ( level_stop_flag in var_70c924e39383a6dd )
                {
                    level endon( level_stop_flag );
                }
            }
            else
            {
                level endon( var_70c924e39383a6dd );
            }
        }
        
        if ( !target || !target.origin || !self || !self.origin )
        {
            return;
        }
        
        target endon( #"death_or_disconnect", #"hash_d7042e280707a8fa" );
        self endon( #"death_or_disconnect", #"hash_3d3990b273e1f2e9" );
        var_68e1ed47045d49b4 = {};
        var_68e1ed47045d49b4 childthread function_2123b431d9648500( self, target, color, sphere_radius, print_text );
        return var_68e1ed47045d49b4;
    }

    // Namespace zm_barnacle
    // Params 5, eflags: 0xc
    // Checksum 0x8cafc682, Offset: 0x443d
    // Size: 0x19c, Type: dev
    function private function_2123b431d9648500( from, to, color, sphere_radius, print_text )
    {
        self notify( #"hash_d0c8f43aa178b42d" );
        self endon( #"hash_d0c8f43aa178b42d" );
        var_68e1ed47045d49b4 = self;
        var_68e1ed47045d49b4 endon( #"kill_debug_line" );
        
        if ( !to || !to.origin || !from )
        {
            return;
        }
        
        to endon( #"death_or_disconnect" );
        from endon( #"death_or_disconnect" );
        
        while ( true )
        {
            if ( !to || !to.origin || !from || !from.origin )
            {
                return;
            }
            
            line( from.origin, to.origin, color );
            sphere( to.origin, sphere_radius, color );
            scale_frac = min( distance( to.origin, from.origin ) / 6000, 1 );
            scale = math::lerp( 0.3, 10, scale_frac );
            print3d( 0.5 * ( to.origin + from.origin ), print_text + "<dev string:x2c5>" + length( to.origin - from.origin ) + "<dev string:x2c8>", color, 1, scale );
            waitframe();
        }
    }

#/
