// script_51003dec974513a9  (hash_51003dec974513a9.gscc) (size: 8454 Bytes / 0x2106 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd4b2431 (4249560113)
// size ...... 8454 (0x2106)
// includes .. 10  (offset: 0x1e8a)
// strings ... 30  (offset: 0x1eda)
// dev strs .. 12  (offset: 0x2076)
// exports ... 17  (offset: 0x1272)
// cseg ...... 0x298 + 0xfda (0x1272)
// imports ... 82  (offset: 0x151a)
// animtree1 . 0   (offset: 0x2106)
// animtree2 . 0   (offset: 0x2106)
#using script_16ea1b94f0f381b3;
#using script_193e3e231841082f;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_deathworm;

// Namespace zombie_deathworm
// Params 1
// Checksum 0x92011d9a, Offset: 0x2b6
// Size: 0x6b
function init_mobile_spawner_precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "mobile_spawner_death_normal_vfx", settings.var_c6874a522bc99c69 );
        utility::add_fx( "mobile_spawner_death_special_vfx", settings.var_8eda22e2b70e9311 );
        utility::add_fx( "mobile_spawner_death_elite_vfx", settings.var_f34800e4d9a2c971 );
    }
}

// Namespace zombie_deathworm
// Params 0
// Checksum 0x4fbcb59a, Offset: 0x329
// Size: 0xda
function init_mobile_spawner()
{
    self.var_b1792e4db6897eca = [];
    
    for ( var_d7fe15226201800e = 0; var_d7fe15226201800e < 6 ; var_d7fe15226201800e++ )
    {
        self.var_b1792e4db6897eca[ var_d7fe15226201800e ] = spawn( "script_model", self.origin );
        self.var_b1792e4db6897eca[ var_d7fe15226201800e ] setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_654a00a5b3e35605 );
        thread utility::delete_on_death( self.var_b1792e4db6897eca[ var_d7fe15226201800e ] );
    }
    
    self.var_4d8f8bd689f67dde = [ "zombie_mangler", "zombie_mimic", "zombie_disciple" ];
    self.var_46e12309bc6bfd1e = [ "zombie_abom_mega" ];
    self.var_87f2acda8758bab9 = 0;
    thread function_fad94698825c4258();
    
    /#
        init_deathworm_mobile_spawner_devgui();
    #/
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0xe0c0cbfa, Offset: 0x40b
// Size: 0x2a
function private function_fad94698825c4258()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"mobile_spawner_start" );
        function_cc1cb04ab4c8bc0e();
    }
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0xe5b37d2c, Offset: 0x43d
// Size: 0xb8
function private function_cc1cb04ab4c8bc0e()
{
    thread utility::thread_on_notify( "spawn_mobile_spawner", &function_3df221d275404e5, self, self, "mobile_spawner_end" );
    thread utility::thread_on_notify( "open_mouth", &on_open_mouth, self );
    yaw_to_enemy = 0;
    
    if ( isdefined( self.enemy ) )
    {
        yaw_to_enemy = utility::getyawtospot( self.enemy.origin );
        
        if ( abs( yaw_to_enemy ) < getdvarfloat( @"hash_c178ebcd849021e1", 90 ) )
        {
            self.turnrate = getdvarfloat( @"hash_d726648e2004014e", 0.1 );
        }
        else
        {
            self.turnrate = 0.01;
        }
    }
    
    /#
        mobile_spawner_print( "<dev string:x24>" + yaw_to_enemy );
    #/
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0x5bb6ff3e, Offset: 0x4fd
// Size: 0x261
function private function_3df221d275404e5()
{
    function_f4a77d5d66639ff4();
    var_f06c3d8143b76949 = self gettagorigin( "j_head" );
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    var_121423597bb042b0 = self.health < self.maxhealth * 0.5;
    can_spawn_elite = 1 && ( var_121423597bb042b0 && var_4912869f02b165bf >= 4 || var_4912869f02b165bf >= 7 );
    var_27d541da3012d121 = 2;
    
    if ( var_4912869f02b165bf <= 9 )
    {
        var_27d541da3012d121 = 1;
    }
    
    if ( can_spawn_elite && isdefined( self.var_306139fe49d856d0 ) )
    {
        var_7b241d3bc3b6c497 = 0;
        
        foreach ( ai in self.var_306139fe49d856d0 )
        {
            if ( isalive( ai ) && ai.aicategory == "elite" )
            {
                var_7b241d3bc3b6c497++;
            }
        }
        
        if ( var_7b241d3bc3b6c497 >= 2 )
        {
            can_spawn_elite = 0;
        }
    }
    
    min_spawn_count = var_121423597bb042b0 || var_4912869f02b165bf >= 4 ? 3 : 4;
    max_spawn_count = var_121423597bb042b0 || var_4912869f02b165bf >= 4 ? 6 : min_spawn_count + 1;
    ai_count_to_spawn = randomintrange( min_spawn_count, max_spawn_count + 1 );
    
    for ( var_d7fe15226201800e = 0; var_d7fe15226201800e < ai_count_to_spawn ; var_d7fe15226201800e++ )
    {
        self.var_b1792e4db6897eca[ var_d7fe15226201800e ] dontinterpolate();
        self.var_b1792e4db6897eca[ var_d7fe15226201800e ].origin = var_f06c3d8143b76949;
        self.var_b1792e4db6897eca[ var_d7fe15226201800e ] utility::function_32b24db3127bff40( "mobile_spawner", "mobile_spawner_on" );
        is_elite = 0;
        
        if ( can_spawn_elite )
        {
            is_elite = var_d7fe15226201800e == 0;
            
            if ( !is_elite && var_4912869f02b165bf >= 14 )
            {
                is_elite = var_d7fe15226201800e == 1;
            }
        }
        
        thread function_fa1bd05370fb34b4( self.var_b1792e4db6897eca[ var_d7fe15226201800e ], is_elite );
    }
    
    utility::function_32b24db3127bff40( "mouth_fire", "mouth_fire_on" );
    
    /#
        mobile_spawner_print( "<dev string:x45>", var_f06c3d8143b76949 );
    #/
}

// Namespace zombie_deathworm
// Params 2, eflags: 0x4
// Checksum 0xe068d7e5, Offset: 0x766
// Size: 0x60c
function private function_fa1bd05370fb34b4( mobile_spawner, is_elite )
{
    self endon( #"death" );
    mobile_spawner endon( #"death" );
    forward_vec = anglestoforward( self.angles );
    initial_forward_speed = getdvarfloat( @"hash_1db1f153f575c73a", 90 );
    var_ae2a3a25b259d063 = getdvarfloat( @"hash_7f2b507d55b34c01", 60 );
    var_6742ddc637543391 = getdvarfloat( @"hash_df2d63ee68c8172b", 3 );
    gravity = getdvarfloat( @"bg_lowgravity", 400 );
    var_4afaff7eba049a9b = forward_vec * initial_forward_speed + ( 0, 0, -1 ) * var_ae2a3a25b259d063;
    var_4afaff7eba049a9b += randomint( 20 ) * utility::array_random( [ -1, 1 ] ) * ( 0, 0, 1 );
    var_4afaff7eba049a9b += randomint( 40 ) * utility::array_random( [ -1, 1 ] ) * anglestoright( self.angles );
    prev_origin = mobile_spawner.origin;
    b_hit_something = 0;
    
    while ( !b_hit_something )
    {
        var_4afaff7eba049a9b += ( ( 0, 0, -1 ) * gravity / 8 - forward_vec * var_6742ddc637543391 ) * level.framedurationseconds;
        mobile_spawner.origin += var_4afaff7eba049a9b;
        end_pos = physicstrace( prev_origin, mobile_spawner.origin );
        b_hit_something = end_pos != mobile_spawner.origin;
        
        /#
            if ( debug_mobile_spawner() )
            {
                line( prev_origin, mobile_spawner.origin, ( 1, 0, 0 ), 1 );
            }
        #/
        
        prev_origin = mobile_spawner.origin;
        waitframe();
    }
    
    mobile_spawner utility::function_32b24db3127bff40( "mobile_spawner", "mobile_spawner_impact" );
    ai_subclass = utility::array_random( is_elite ? self.var_46e12309bc6bfd1e : self.var_4d8f8bd689f67dde );
    aitypes = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( ai_subclass );
    var_86378c265bd6b3c6 = undefined;
    
    foreach ( aitype in aitypes )
    {
        strlen = aitype.size;
        
        if ( !isdefined( var_86378c265bd6b3c6 ) || var_86378c265bd6b3c6.size > strlen )
        {
            var_86378c265bd6b3c6 = aitype;
        }
    }
    
    aitype_to_spawn = var_86378c265bd6b3c6;
    spawn_point_on_navmesh = utility::function_5918594658d3ffba( mobile_spawner.origin, 200, -200 );
    
    if ( isdefined( spawn_point_on_navmesh ) )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( self.enemy ) )
        {
            angles = ( 0, vectortoyaw( self.enemy.origin - spawn_point_on_navmesh ), 0 );
        }
        
        mobile_spawner_ai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype_to_spawn, spawn_point_on_navmesh, angles, self.team );
        
        if ( isdefined( mobile_spawner_ai ) )
        {
            mobile_spawner_ai.var_f39d8960915f9a15 = self;
            self.var_87f2acda8758bab9++;
            
            if ( !isdefined( self.var_306139fe49d856d0 ) )
            {
                self.var_306139fe49d856d0 = [];
            }
            
            self.var_306139fe49d856d0[ self.var_306139fe49d856d0.size ] = mobile_spawner_ai;
            mobile_spawner_ai utility::function_32b24db3127bff40( "deathworm_mobile_spawner", "on" );
            mobile_spawner_ai val::set( "mobile_spawner", "ammomod_immune", 1 );
            mobile_spawner_ai.var_f39d8960915f9a15 = self;
            mobile_spawner_ai thread function_80d8adf28796a777();
            params = spawnstruct();
            params.ai = mobile_spawner_ai;
            callback::callback( "spawned_from_deathworm", params );
            
            if ( level.var_aee978b8c8705c84 )
            {
                mobile_spawner_ai.var_978a34c74824fdb8 = ai_spawn_director::spawn_request( "ai_encounter:" + self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4979adf75892bfb2, mobile_spawner.origin, 10000, 1, 1 );
            }
            
            if ( isdefined( mobile_spawner_ai.var_978a34c74824fdb8 ) )
            {
                function_c505198907e0d306( mobile_spawner_ai.var_978a34c74824fdb8, mobile_spawner_ai );
                ai_spawn_director::function_53289c032f506bb1( mobile_spawner_ai.var_978a34c74824fdb8, &function_a08fe501e4386cb7, mobile_spawner_ai );
                ai_spawn_director::add_spawned_callback( mobile_spawner_ai.var_978a34c74824fdb8, &function_451d29fe04cd4bf5, mobile_spawner_ai );
                mobile_spawner_ai thread function_528b709e4d34a0ba( mobile_spawner_ai.var_978a34c74824fdb8 );
            }
        }
    }
    
    targets = getplayersandaiarrayinradius( mobile_spawner.origin, 128 );
    
    foreach ( target in targets )
    {
        if ( target.team != self.team )
        {
            var_cb5e9e6ad0ec3bf5 = distance2d( mobile_spawner.origin, target.origin );
            var_8bd444d2097f426c = max( ( 128 - var_cb5e9e6ad0ec3bf5 ) / 128, 0 );
            mobile_spawner_damage = math::remap( var_8bd444d2097f426c, 0, 1, 100, 300 );
            target dodamage( mobile_spawner_damage, mobile_spawner.origin, self, self, "MOD_UNKNOWN" );
            
            /#
                mobile_spawner_print( "<dev string:x65>" + mobile_spawner_damage, target.origin + ( 0, 0, 70 ) );
            #/
        }
    }
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0x8a8209e3, Offset: 0xd7a
// Size: 0x6a
function private function_80d8adf28796a777()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isalive( self.var_f39d8960915f9a15 ) || distance2dsquared( self.var_f39d8960915f9a15.origin, self.origin ) > squared( 2000 ) )
        {
            if ( !isdefined( self.enemy ) )
            {
                self kill();
            }
        }
        
        wait 10;
    }
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0x55ae7d70, Offset: 0xdec
// Size: 0x18b
function private function_528b709e4d34a0ba( floodfill_id )
{
    var_f39d8960915f9a15 = self.var_f39d8960915f9a15;
    aicategory = self.aicategory;
    self waittill( #"death" );
    function_b43716082f77e5e5( floodfill_id );
    ai_spawn_director::cancel_spawn_request( floodfill_id );
    
    if ( isdefined( var_f39d8960915f9a15 ) && isdefined( var_f39d8960915f9a15.var_87f2acda8758bab9 ) )
    {
        var_f39d8960915f9a15.var_87f2acda8758bab9--;
    }
    
    if ( aicategory == "special" )
    {
        playfx( utility::getfx( "mobile_spawner_death_special_vfx" ), self getcentroid() + ( 0, 0, 30 ) );
    }
    else if ( aicategory == "elite" )
    {
        playfx( utility::getfx( "mobile_spawner_death_elite_vfx" ), self getcentroid() + ( 0, 0, 30 ) );
    }
    
    explosion_radius = 500;
    nearby_ai = getaiarrayinradius( self.origin, explosion_radius );
    
    foreach ( ai in nearby_ai )
    {
        if ( ai utility::ent_flag( "spawned_by_mobile_spawner" ) )
        {
            ai kill( ai.origin );
            wait randomfloatrange( 0, 0.2 );
        }
    }
}

// Namespace zombie_deathworm
// Params 2, eflags: 0x4
// Checksum 0xec37a565, Offset: 0xf7f
// Size: 0x2e, Type: bool
function private function_a08fe501e4386cb7( requestid, userdata )
{
    mobile_spawner_ai = userdata;
    
    if ( !isalive( mobile_spawner_ai ) )
    {
    }
    
    return false;
}

// Namespace zombie_deathworm
// Params 4, eflags: 0x4
// Checksum 0x9005db14, Offset: 0xfb6
// Size: 0xce
function private function_451d29fe04cd4bf5( requestid, userdata, agent, ai_data )
{
    agent utility::function_32b24db3127bff40( "mobile_spawner", "mobile_spawner_on" );
    agent utility::ent_flag_set( "spawned_by_mobile_spawner" );
    agent.nocorpse = 1;
    
    if ( isdefined( userdata.var_f39d8960915f9a15 ) )
    {
        params = spawnstruct();
        params.ai = agent;
        userdata.var_f39d8960915f9a15 callback::callback( "spawned_from_deathworm", params );
    }
    
    agent waittill( #"death" );
    playfx( utility::getfx( "mobile_spawner_death_normal_vfx" ), agent getcentroid() + ( 0, 0, 30 ) );
}

// Namespace zombie_deathworm
// Params 0, eflags: 0x4
// Checksum 0xc11e70ee, Offset: 0x108c
// Size: 0xa7
function private on_open_mouth()
{
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "mouth", "mobile_spawner" );
    utility::waittill_multiple( "close_mouth", "mobile_spawner_end" );
    utility::function_7c10ea82c1e305b8( "mouth", "off" );
    cooldown = getdvarint( @"worm_mobile_spawner_cooldown", 90000 );
    var_4912869f02b165bf = [[ self.var_24610c747736231e ]]();
    
    if ( var_4912869f02b165bf >= 4 )
    {
        cooldown = int( 60000 );
    }
    else if ( var_4912869f02b165bf >= 7 )
    {
        cooldown = int( 30000 );
    }
    
    ai::set_blackboard_cooldown( "mobile_spawner_cooldown", cooldown );
}

/#

    // Namespace zombie_deathworm
    // Params 0
    // Checksum 0xa71bc819, Offset: 0x113b
    // Size: 0x44, Type: dev
    function init_deathworm_mobile_spawner_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6f>" );
        devgui::add_devgui_func( "<dev string:x8b>", "<dev string:xa0>", &force_mobile_spawner );
        devgui::add_devgui_func( "<dev string:xb5>", "<dev string:xca>", &function_680c7f026a53aaf2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0x78f4f414, Offset: 0x1187
    // Size: 0x48, Type: dev
    function private force_mobile_spawner()
    {
        var_79481b4b9f445f8f = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xdf>" );
        
        if ( !isdefined( var_79481b4b9f445f8f ) )
        {
            return;
        }
        
        var_79481b4b9f445f8f function_786bb6aa1b76c7ee( "<dev string:xf0>", 1 );
    }

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0x4ee49c3d, Offset: 0x11d7
    // Size: 0x16, Type: dev
    function private debug_mobile_spawner()
    {
        return getdvarint( @"hash_4407d608d4a28905", 0 ) > 0;
    }

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0x8774a46c, Offset: 0x11f5
    // Size: 0x1a, Type: dev
    function private function_680c7f026a53aaf2()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x102>", @"hash_4407d608d4a28905" );
    }

    // Namespace zombie_deathworm
    // Params 2, eflags: 0x4
    // Checksum 0xf2043888, Offset: 0x1217
    // Size: 0x5b, Type: dev
    function private mobile_spawner_print( text, pos )
    {
        if ( debug_mobile_spawner() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x121>" + text, ( 1, 0, 0 ) );
        }
    }

#/
