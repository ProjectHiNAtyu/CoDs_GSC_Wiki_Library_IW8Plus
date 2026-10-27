// scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_evolve.gsc  (hash_09feae597f1fdab2.gscc) (size: 12044 Bytes / 0x2f0c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd485653 (3175634515)
// size ...... 12044 (0x2f0c)
// includes .. 12  (offset: 0x2c60)
// strings ... 27  (offset: 0x2cc0)
// dev strs .. 8   (offset: 0x2ea8)
// exports ... 28  (offset: 0x1d70)
// cseg ...... 0x24e + 0x1b22 (0x1d70)
// imports ... 86  (offset: 0x21d0)
// animtree1 . 0   (offset: 0x2f0c)
// animtree2 . 0   (offset: 0x2f0c)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_parasite_evolve;

// Namespace zombie_parasite_evolve
// Params 1
// Checksum 0x6be31b0d, Offset: 0x26c
// Size: 0x1cd
function function_59a9a94e2620a6e8( aitypescriptbundle )
{
    var_5aa57caf5f1a1879 = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isarray( var_5aa57caf5f1a1879.var_5a9c61a1fefca8c9 ) )
    {
        foreach ( evolution_host in var_5aa57caf5f1a1879.var_5a9c61a1fefca8c9 )
        {
            host_animset_name = evolution_host.aianimsetname;
            
            if ( isdefined( host_animset_name ) )
            {
                level.scr_anim[ host_animset_name ][ "parasite_evolve" ] = "parasite_evolve";
                level.scr_anim[ host_animset_name ][ "parasite_evolve_low" ] = "parasite_evolve_low";
            }
        }
    }
    
    evolved_animset_name = var_5aa57caf5f1a1879.var_fa4148999d185df6.aianimsetname;
    
    if ( isdefined( evolved_animset_name ) )
    {
        level.scr_anim[ evolved_animset_name ][ "parasite_evolve" ] = "parasite_evolve";
        level.scr_anim[ evolved_animset_name ][ "parasite_evolve_low" ] = "parasite_evolve_low";
    }
    
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_ac1e78b85ea96df4", &function_2d5a4771c61fa5b2 );
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_41aeb3f5f201459", &function_509659f755672e37 );
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_88bce97e9df03b00", &set_evolution_payload );
    utility::registersharedfunc( aitypescriptbundle.subclass, #"hash_6ace5c7a2f86f75", &function_8814e2a79953d036 );
    
    /#
        level function_79c7be22987f5505();
    #/
}

// Namespace zombie_parasite_evolve
// Params 0
// Checksum 0xf2e81ede, Offset: 0x441
// Size: 0x22
function function_22ef62a6d61cae96()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_7914468a909df6cb );
}

// Namespace zombie_parasite_evolve
// Params 1, eflags: 0x4
// Checksum 0xae9c0963, Offset: 0x46b
// Size: 0x162
function private function_2d5a4771c61fa5b2( params )
{
    self endon( #"death" );
    utility::ent_flag_wait( "register_parasite_evolve_data_completed" );
    
    if ( isdefined( params.var_b418cb52dbca2613 ) )
    {
        self.var_2d00ed01947563cf.attempt_chance = params.var_b418cb52dbca2613;
    }
    
    if ( isdefined( params.var_aaab9ed74aa76dc2 ) )
    {
        self.var_2d00ed01947563cf.max_simultaneous = params.var_aaab9ed74aa76dc2;
    }
    
    if ( isdefined( params.var_8d449b07071097c0 ) )
    {
        self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f = params.var_8d449b07071097c0;
    }
    
    if ( isdefined( params.var_d8e646f5fdfb1e70 ) )
    {
        self.var_2d00ed01947563cf.var_d2dea1eb5c269d79 = utility::function_4b74c15943231980( params.var_d8e646f5fdfb1e70 );
    }
    
    if ( isarray( params.var_ae78eaeea8430741 ) )
    {
        self.var_2d00ed01947563cf.attempt_interval = [ int( utility::function_4b74c15943231980( params.var_ae78eaeea8430741[ 0 ] ) ), int( utility::function_4b74c15943231980( params.var_ae78eaeea8430741[ 1 ] ) ) ];
    }
    
    if ( params.b_force_evolve )
    {
        self.force_evolve = params.b_force_evolve;
    }
}

// Namespace zombie_parasite_evolve
// Params 1, eflags: 0x4
// Checksum 0xf2f0c878, Offset: 0x5d5
// Size: 0x188
function private setup_evolution_data( evolution_settings )
{
    self.var_2d00ed01947563cf.var_d2dea1eb5c269d79 = int( utility::function_4b74c15943231980( evolution_settings.var_b606f68f3fe694e9 ) );
    self.var_2d00ed01947563cf.near_player_range_sqr = squared( evolution_settings.var_21dbe2b7ee915775 );
    self.var_2d00ed01947563cf.var_3ef51b48339ded2b = evolution_settings.var_37b928f05576b53;
    self.var_2d00ed01947563cf.attempt_chance = evolution_settings.var_f4b470f5ac3a3abc;
    attempt_interval_min = min( evolution_settings.var_abce0fc296836e23, evolution_settings.var_abf105c296a99fdd );
    attempt_interval_max = max( evolution_settings.var_abce0fc296836e23, evolution_settings.var_abf105c296a99fdd );
    self.var_2d00ed01947563cf.attempt_interval = [ int( utility::function_4b74c15943231980( attempt_interval_min ) ), int( utility::function_4b74c15943231980( attempt_interval_max ) ) ];
    self.var_2d00ed01947563cf.retry_delay = int( utility::function_4b74c15943231980( evolution_settings.var_556337ac4dbe29a5 ) );
    self.var_2d00ed01947563cf.max_simultaneous = evolution_settings.var_e0a6f03bb93b3648;
    self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f = evolution_settings.var_ca7e1b8f766a66ce;
    utility::ent_flag_set( "register_parasite_evolve_data_completed" );
}

// Namespace zombie_parasite_evolve
// Params 2, eflags: 0x4
// Checksum 0xc0d76e6e, Offset: 0x765
// Size: 0x103
function private function_3608177d0551ddb1( evolution_scaling, round_number )
{
    if ( !isdefined( level.var_bece46856e380d17[ evolution_scaling ] ) )
    {
        level.var_bece46856e380d17[ evolution_scaling ] = getscriptbundle( "zombieparasiteevolutionscalinground:" + evolution_scaling );
    }
    
    var_c46fdbf3f5bccdfe = level.var_bece46856e380d17[ evolution_scaling ];
    
    if ( !isdefined( var_c46fdbf3f5bccdfe ) )
    {
        return;
    }
    
    var_c7b3d5941764bc92 = var_c46fdbf3f5bccdfe.var_52b0af10beac9a2a;
    
    if ( var_c7b3d5941764bc92.size > 0 )
    {
        prev_round_number = undefined;
        
        for ( i = var_c7b3d5941764bc92.size - 1; i >= 0 ; i-- )
        {
            if ( var_c7b3d5941764bc92[ i ].startround >= prev_round_number )
            {
                assert( "<dev string:x24>" + ( evolution_scaling ?? "<dev string:x7f>" ) );
                break;
            }
            
            if ( round_number >= var_c7b3d5941764bc92[ i ].startround )
            {
                return var_c7b3d5941764bc92[ i ].evolutionsettings;
            }
            
            prev_round_number = var_c7b3d5941764bc92[ i ].startround;
        }
    }
}

// Namespace zombie_parasite_evolve
// Params 0
// Checksum 0x99d94e05, Offset: 0x871
// Size: 0x25c
function init_parasite_evolution()
{
    var_5aa57caf5f1a1879 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_2d00ed01947563cf = {};
    
    if ( var_5aa57caf5f1a1879.enableevolution )
    {
        self function_786bb6aa1b76c7ee( "can_evolve", 1 );
    }
    
    if ( isdefined( var_5aa57caf5f1a1879.var_f1d8f7a4cba3024b ) )
    {
        evolution_settings = function_3608177d0551ddb1( var_5aa57caf5f1a1879.var_f1d8f7a4cba3024b, zombie_utils::get_zombie_round_difficulty() );
    }
    
    if ( !isdefined( evolution_settings ) )
    {
        evolution_settings = var_5aa57caf5f1a1879.evolutionsettings;
    }
    
    thread setup_evolution_data( evolution_settings );
    self.var_2d00ed01947563cf.var_bd00a49229fd5174 = squared( var_5aa57caf5f1a1879.var_3fc22a57e311a348 );
    self.var_2d00ed01947563cf.var_3644b16e2cbdb607 = [];
    
    if ( isarray( var_5aa57caf5f1a1879.var_5a9c61a1fefca8c9 ) )
    {
        foreach ( evolution_host in var_5aa57caf5f1a1879.var_5a9c61a1fefca8c9 )
        {
            if ( evolution_host.aisubclass != %"" )
            {
                host_subclass = getscriptbundle( evolution_host.aisubclass );
                
                if ( isdefined( host_subclass ) )
                {
                    self.var_2d00ed01947563cf.var_3644b16e2cbdb607[ self.var_2d00ed01947563cf.var_3644b16e2cbdb607.size ] = host_subclass.name;
                }
            }
        }
    }
    
    if ( var_5aa57caf5f1a1879.var_fa4148999d185df6.aisubclass != %"" )
    {
        evolved_subclass = getscriptbundle( var_5aa57caf5f1a1879.var_fa4148999d185df6.aisubclass );
        
        if ( isdefined( evolved_subclass ) )
        {
            self.var_2d00ed01947563cf.result_subclass = evolved_subclass.name;
            evolved_type = function_b3988325430ce242( evolved_subclass.name );
            
            if ( isdefined( evolved_type ) )
            {
                self.var_2d00ed01947563cf.result_type = evolved_type;
            }
        }
    }
    
    thread function_f5030cc37a141c13();
}

// Namespace zombie_parasite_evolve
// Params 1
// Checksum 0x8cb6927a, Offset: 0xad5
// Size: 0x1c
function function_82a7d7045838a32c( value )
{
    self.var_476561893aef2c3b = !value ?? 0;
}

// Namespace zombie_parasite_evolve
// Params 2
// Checksum 0x9e14647, Offset: 0xaf9
// Size: 0x3c
function set_evolution_payload( id, data )
{
    if ( !isdefined( self.var_2d00ed01947563cf ) )
    {
        return;
    }
    
    self.var_2d00ed01947563cf.payload[ id ] = data;
}

// Namespace zombie_parasite_evolve
// Params 1
// Checksum 0x3d4d5dbf, Offset: 0xb3d
// Size: 0x4d
function function_f682288906366dc0( id )
{
    if ( !isdefined( self.var_2d00ed01947563cf ) )
    {
        return;
    }
    
    if ( isdefined( id ) )
    {
        self.var_2d00ed01947563cf.payload[ id ] = undefined;
        return;
    }
    
    self.var_2d00ed01947563cf.payload = undefined;
}

// Namespace zombie_parasite_evolve
// Params 1, eflags: 0x4
// Checksum 0xf4be2db1, Offset: 0xb92
// Size: 0x13
function private function_7914468a909df6cb( params )
{
    annihilate_host();
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0x5883b511, Offset: 0xbad
// Size: 0x50
function private monitor_interruption()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_5e34861984792ce5" );
        
        if ( utility::ent_flag( "in_evolution_state" ) )
        {
            if ( self getaiblackboarddynamic( "is_evolving" ) )
            {
                annihilate_host();
            }
            else
            {
                function_37a63c2399b69fa4();
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0x5971b9d6, Offset: 0xc05
// Size: 0x87
function private function_f5030cc37a141c13()
{
    self endon( #"death" );
    thread monitor_interruption();
    
    while ( true )
    {
        is_host_alive = isalive( self.var_2d00ed01947563cf.host );
        in_evolution_state = utility::ent_flag( "in_evolution_state" );
        
        if ( in_evolution_state && !is_host_alive )
        {
            function_37a63c2399b69fa4();
        }
        
        utility::function_32b24db3127bff40( "evolve", in_evolution_state ? "evolve_tell" : "off" );
        waitframe();
    }
}

// Namespace zombie_parasite_evolve
// Params 0
// Checksum 0xdaac5478, Offset: 0xc94
// Size: 0x6c, Type: bool
function function_509659f755672e37()
{
    if ( !isdefined( level.var_3f7c286049c0018c ) )
    {
        level.var_3f7c286049c0018c = 0;
    }
    
    if ( !isdefined( level.var_2cec6ea0a6e9ffeb ) )
    {
        level.var_2cec6ea0a6e9ffeb = 0;
    }
    
    return level.var_3f7c286049c0018c < self.var_2d00ed01947563cf.var_bbcf8ce3fc9ca06f && level.var_2cec6ea0a6e9ffeb < self.var_2d00ed01947563cf.max_simultaneous;
}

// Namespace zombie_parasite_evolve
// Params 2
// Checksum 0x756536ab, Offset: 0xd09
// Size: 0x20c
function function_27bf438cb21da198( taskid, params )
{
    if ( !utility::ent_flag( "register_parasite_evolve_data_completed" ) )
    {
        return anim.failure;
    }
    
    if ( self.force_evolve )
    {
        return ( set_evolution_host() ? anim.success : anim.failure );
    }
    
    if ( level.var_7035193e00b67ef0 || val::get( "dont_evolve" ) )
    {
        function_37a63c2399b69fa4();
        return anim.failure;
    }
    
    if ( self.var_a983686954b241f5 )
    {
        return anim.failure;
    }
    
    if ( isalive( self.var_2d00ed01947563cf.host ) )
    {
        return anim.success;
    }
    
    current_time = gettime();
    
    if ( current_time - self.var_2d00ed01947563cf.var_d2dea1eb5c269d79 < self.spawn_time )
    {
        return anim.failure;
    }
    
    if ( current_time < self.var_2d00ed01947563cf.var_813abb7710d169e3 )
    {
        return anim.failure;
    }
    
    if ( isplayer( self.enemy ) && distancesquared( self.var_5e0be30a5816a64d, self.enemy.origin ) <= self.var_2d00ed01947563cf.near_player_range_sqr && self cansee( self.enemy ) )
    {
        if ( function_509659f755672e37() )
        {
            if ( utility::percent_chance( self.var_2d00ed01947563cf.attempt_chance ) )
            {
                if ( set_evolution_host() )
                {
                    return anim.success;
                }
            }
            else
            {
                var_a983bea9063113d5 = randomintrange( self.var_2d00ed01947563cf.attempt_interval[ 0 ], self.var_2d00ed01947563cf.attempt_interval[ 1 ] );
                function_37a63c2399b69fa4( var_a983bea9063113d5 );
            }
        }
        else
        {
            function_37a63c2399b69fa4( 10000 );
        }
    }
    
    return anim.failure;
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0x2f8ab5cd, Offset: 0xf1e
// Size: 0xaa, Type: bool
function private is_valid_host()
{
    if ( self.var_476561893aef2c3b )
    {
        return false;
    }
    
    is_spawning = self.spawn_time == gettime() || utility::ent_flag( "spawn_animating" ) || self.b_in_spawn_closet;
    is_animscripted = asm_bb::bb_isanimscripted();
    is_traversing = ai::is_doing_traversal( self ) || self.is_traversing;
    is_crawling = istrue( self._blackboard.var_6391b373c0f57a6d );
    return !is_spawning && !is_animscripted && !is_traversing && !is_crawling;
}

// Namespace zombie_parasite_evolve
// Params 0
// Checksum 0xa627f844, Offset: 0xfd1
// Size: 0x1ca
function function_8814e2a79953d036()
{
    evolution_host = undefined;
    
    if ( isplayer( self.enemy ) || self.var_2d00ed01947563cf.brainrot_evolve )
    {
        origin = self.var_2d00ed01947563cf.brainrot_evolve ? self.origin : self.enemy.origin;
        team = self.var_2d00ed01947563cf.brainrot_evolve ? undefined : self.team;
        var_1291dd85e7e42bec = getaiarrayinradius( origin, self.var_2d00ed01947563cf.var_3ef51b48339ded2b, team );
        min_dist_sqr = undefined;
        
        foreach ( ai in var_1291dd85e7e42bec )
        {
            if ( !isalive( ai ) || ai == self )
            {
                continue;
            }
            
            if ( isdefined( ai.subclass ) && arraycontains( self.var_2d00ed01947563cf.var_3644b16e2cbdb607, ai.subclass ) && ai is_valid_host() )
            {
                dist_sqr = distancesquared( ai.origin, self.origin );
                
                if ( !isdefined( evolution_host ) || dist_sqr < min_dist_sqr )
                {
                    evolution_host = ai;
                    min_dist_sqr = dist_sqr;
                }
            }
        }
    }
    
    return evolution_host;
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0x53d77253, Offset: 0x11a4
// Size: 0xc5
function private set_evolution_host()
{
    if ( !isdefined( self.var_2d00ed01947563cf ) )
    {
        return;
    }
    
    self.var_2d00ed01947563cf.host = function_8814e2a79953d036();
    
    if ( isdefined( self.var_2d00ed01947563cf.host ) )
    {
        if ( !utility::ent_flag( "in_evolution_state" ) )
        {
            utility::ent_flag_set( "in_evolution_state" );
            
            if ( !isdefined( level.var_2cec6ea0a6e9ffeb ) )
            {
                level.var_2cec6ea0a6e9ffeb = 0;
            }
            
            level.var_2cec6ea0a6e9ffeb++;
        }
        
        return 1;
    }
    
    utility::ent_flag_clear( "in_evolution_state" );
    
    if ( !isdefined( level.var_2cec6ea0a6e9ffeb ) )
    {
        level.var_2cec6ea0a6e9ffeb = 0;
    }
    
    level.var_2cec6ea0a6e9ffeb = int( max( level.var_2cec6ea0a6e9ffeb - 1, 0 ) );
    return 0;
}

// Namespace zombie_parasite_evolve
// Params 1, eflags: 0x4
// Checksum 0x4de332fe, Offset: 0x1271
// Size: 0x94
function private function_37a63c2399b69fa4( attempt_delay )
{
    if ( !isdefined( self.var_2d00ed01947563cf ) )
    {
        return;
    }
    
    self.var_2d00ed01947563cf.host = undefined;
    
    if ( attempt_delay > 0 )
    {
        self.var_2d00ed01947563cf.var_813abb7710d169e3 = gettime() + attempt_delay;
    }
    
    utility::ent_flag_clear( "in_evolution_state" );
    
    if ( !isdefined( level.var_2cec6ea0a6e9ffeb ) )
    {
        level.var_2cec6ea0a6e9ffeb = 0;
    }
    
    level.var_2cec6ea0a6e9ffeb = int( max( ( level.var_2cec6ea0a6e9ffeb ?? 0 ) - 1, 0 ) );
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0x2a009b70, Offset: 0x130d
// Size: 0xc8
function private annihilate_host()
{
    if ( isalive( self.var_2d00ed01947563cf.host ) )
    {
        if ( !self.var_2d00ed01947563cf.host.ignore_enemy_count )
        {
            self.var_2d00ed01947563cf.host utility::callsharedfunc( #"zombie", #"hash_6c2d9080e508d382" );
        }
        
        self.var_2d00ed01947563cf.host.var_a13bed1ac47e1b2c = 1;
        self.var_2d00ed01947563cf.host.forceannihilate = 1;
        self.var_2d00ed01947563cf.host kill();
    }
    
    function_37a63c2399b69fa4();
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0xcf5f70d4, Offset: 0x13dd
// Size: 0x48
function private function_5740e31b0bc8593c()
{
    disciple_parent_data = self.evolution_payload[ "disciple_parent" ];
    
    if ( isdefined( disciple_parent_data ) )
    {
        self [[ disciple_parent_data.var_b3e176999aae46d7 ]]( disciple_parent_data.disciple_parent, disciple_parent_data.var_9ad7cc5d07653ebc );
    }
}

// Namespace zombie_parasite_evolve
// Params 1, eflags: 0xc
// Checksum 0xfaa3e2b0, Offset: 0x142d
// Size: 0x36a
function private start_evolution_process( evolve_anim )
{
    self notify( #"hash_435004556a898b6a" );
    self endon( #"hash_435004556a898b6a" );
    self endon( #"death" );
    
    if ( effect_slow::function_6fab6266b5f636c3() || self.var_2d00ed01947563cf.host effect_slow::function_6fab6266b5f636c3() )
    {
        effect_slow::stop_all_slows();
        self.var_2d00ed01947563cf.host effect_slow::stop_all_slows();
        waitframe();
    }
    else
    {
        waittillframeend();
    }
    
    if ( !isalive( self.var_2d00ed01947563cf.host ) || !self.var_2d00ed01947563cf.host is_valid_host() )
    {
        self function_f2df0257c63f229( "is_evolving" );
        return;
    }
    
    if ( self.var_2d00ed01947563cf.host utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", evolve_anim ) )
    {
        self.var_2d00ed01947563cf.host thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( evolve_anim, "parasite_evolve_end", self.var_2d00ed01947563cf.host.origin, self.var_2d00ed01947563cf.host.angles, undefined, 1 );
    }
    
    asm::function_7256f5ba459c840b( "evolve_in" );
    result = utility::waittill_any_return( "evolved", "evolution_end" );
    
    if ( result == "evolved" && isalive( self.var_2d00ed01947563cf.host ) )
    {
        spawn_origin = self.var_2d00ed01947563cf.host.origin;
        spawn_angles = self.var_2d00ed01947563cf.host.angles;
        self function_786bb6aa1b76c7ee( "is_evolved", 1 );
        self.var_2d00ed01947563cf.host.var_a13bed1ac47e1b2c = 1;
        self.var_2d00ed01947563cf.host.nocorpse = 1;
        self.var_2d00ed01947563cf.host kill();
        
        if ( isdefined( self.var_2d00ed01947563cf.result_type ) )
        {
            evolved_ai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( self.var_2d00ed01947563cf.result_type, spawn_origin, spawn_angles, self.team );
            
            if ( isdefined( evolved_ai ) )
            {
                if ( isdefined( self.var_2d00ed01947563cf.payload ) )
                {
                    evolved_ai.evolution_payload = self.var_2d00ed01947563cf.payload;
                }
                
                evolved_ai function_5740e31b0bc8593c();
                evolved_ai.b_evolved = 1;
                evolved_ai.var_50b2eb7be2a4c8b0 = 1;
                evolved_ai callback::callback( "spawned_from_emergence" );
                
                if ( evolved_ai utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", evolve_anim ) )
                {
                    evolved_ai thread function_4538045e1a635f01();
                    evolved_ai thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( evolve_anim, "parasite_evolve_end", spawn_origin, spawn_angles, "spawn_animating" );
                }
            }
        }
        
        self.var_a13bed1ac47e1b2c = 1;
        self.nocorpse = 1;
        self kill();
        return;
    }
    
    annihilate_host();
}

// Namespace zombie_parasite_evolve
// Params 0, eflags: 0x4
// Checksum 0xb53b473e, Offset: 0x179f
// Size: 0x51
function private function_4538045e1a635f01()
{
    self endon( #"death" );
    val::set( "parasite_evolve", "disallow_stun", 1 );
    val::set( "parasite_evolve", "disallow_slow", 1 );
    utility::waittill_notify_or_timeout( "parasite_evolve_end", 5 );
    val::reset_all( "parasite_evolve" );
}

// Namespace zombie_parasite_evolve
// Params 2
// Checksum 0xfaaa9bb5, Offset: 0x17f8
// Size: 0x3a7
function function_50e387bb3bec9c8a( taskid, params )
{
    if ( !isalive( self.var_2d00ed01947563cf.host ) )
    {
        function_37a63c2399b69fa4( self.var_2d00ed01947563cf.retry_delay );
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "is_evolving" ) )
    {
        return anim.running;
    }
    
    if ( !self.var_2d00ed01947563cf.host is_valid_host() )
    {
        set_evolution_host();
    }
    
    if ( isdefined( self.var_2d00ed01947563cf.host ) )
    {
        self function_f2fdf8ef124744e8( 0, self.var_2d00ed01947563cf.host );
    }
    else
    {
        function_37a63c2399b69fa4( self.var_2d00ed01947563cf.retry_delay );
        return anim.failure;
    }
    
    if ( distancesquared( self.var_5e0be30a5816a64d, self.var_2d00ed01947563cf.host.origin ) <= self.var_2d00ed01947563cf.var_bd00a49229fd5174 )
    {
        if ( navisstraightlinereachable( self.var_5e0be30a5816a64d, self.var_2d00ed01947563cf.host.origin, self ) )
        {
            val::set( "evolve", "ignore_ai_collision", 1 );
            val::set( "evolve", "disallow_knockdown", 1 );
            val::set( "evolve", "disallow_slow", 1 );
            self.var_2d00ed01947563cf.attractor_nullifier = { #origin:self.origin };
            utility::callsharedfunc( #"zombie_attractor", #"addonself", self.var_2d00ed01947563cf.attractor_nullifier, 1, undefined, undefined, undefined, undefined, 1 );
            utility::callsharedfunc( #"vortex", #"hash_fd3f2ff8b376e106", "evolve", 1 );
            self.var_2d00ed01947563cf.host val::set( "parasite_evolve", "ignoreall", 1 );
            self.var_2d00ed01947563cf.host val::set( "parasite_evolve", "disallow_knockdown", 1 );
            self.var_2d00ed01947563cf.host val::set( "parasite_evolve", "disallow_stun", 1 );
            self.var_2d00ed01947563cf.host val::set( "parasite_evolve", "disallow_slow", 1 );
            up_vector = ( 0, 0, 1 );
            trace_params = namespace_457bdd1aa1930f50::get_capsule_trace_params();
            trace_start = self.var_2d00ed01947563cf.host.origin + 64 * up_vector;
            trace_end = trace_start + 100 * up_vector;
            trace_passed = trace::capsule_trace_passed( trace_start, trace_end, trace_params.capsule_radius, trace_params.capsule_height, undefined, [ self, self.var_2d00ed01947563cf.host ], trace_params.contents );
            evolve_anim = "parasite_evolve";
            
            if ( !trace_passed )
            {
                self function_786bb6aa1b76c7ee( "evolve_low", 1 );
                evolve_anim += "_low";
            }
            
            self function_786bb6aa1b76c7ee( "is_evolving", 1 );
            thread start_evolution_process( evolve_anim );
        }
    }
    
    return anim.running;
}

// Namespace zombie_parasite_evolve
// Params 2
// Checksum 0x31979f29, Offset: 0x1ba8
// Size: 0xe0
function function_cca8cab00ce14dce( taskid, params )
{
    self function_f2df0257c63f229( "is_evolving" );
    self function_f2df0257c63f229( "evolve_low" );
    val::reset_all( "evolve" );
    
    if ( isdefined( self.var_2d00ed01947563cf ) )
    {
        if ( isdefined( self.var_2d00ed01947563cf.host ) )
        {
            self.var_2d00ed01947563cf.host val::reset_all( "parasite_evolve" );
        }
        
        utility::callsharedfunc( #"vortex", #"hash_36a1e7016033f741", "evolve" );
        utility::callsharedfunc( #"zombie_attractor", #"removeonself", self.var_2d00ed01947563cf.attractor_nullifier );
        self.var_2d00ed01947563cf.attractor_nullifier = undefined;
    }
    
    return anim.success;
}

/#

    // Namespace zombie_parasite_evolve
    // Params 0
    // Checksum 0xc9ca2ae9, Offset: 0x1c91
    // Size: 0x44, Type: dev
    function function_79c7be22987f5505()
    {
        devgui::function_9082edeb5db93280( "<dev string:x80>" );
        devgui::add_devgui_func( "<dev string:x9a>", "<dev string:xaa>", &function_1f23c6d02aa90eb5 );
        devgui::add_devgui_func( "<dev string:xc0>", "<dev string:xd4>", &function_3f8c6e09aae9d9c5 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_parasite_evolve
    // Params 0, eflags: 0x4
    // Checksum 0xb3afc87e, Offset: 0x1cdd
    // Size: 0x46, Type: dev
    function private function_1f23c6d02aa90eb5()
    {
        var_b0acb6c7968532a3 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xe9>" );
        
        if ( isdefined( var_b0acb6c7968532a3 ) )
        {
            var_b0acb6c7968532a3.force_evolve = 1;
        }
    }

    // Namespace zombie_parasite_evolve
    // Params 0, eflags: 0x4
    // Checksum 0x99eef5e4, Offset: 0x1d2b
    // Size: 0x45, Type: dev
    function private function_3f8c6e09aae9d9c5()
    {
        var_b0acb6c7968532a3 = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xe9>" );
        
        if ( isdefined( var_b0acb6c7968532a3 ) )
        {
            var_b0acb6c7968532a3 notify( #"hash_5e34861984792ce5" );
        }
    }

#/
