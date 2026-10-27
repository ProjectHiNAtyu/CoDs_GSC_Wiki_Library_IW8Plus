// scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween_vista_zombies.gsc  (hash_7dfc17b47c17946f.gscc) (size: 2236 Bytes / 0x8bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd504ae95 (3573853845)
// size ...... 2236 (0x8bc)
// includes .. 7   (offset: 0x818)
// strings ... 9   (offset: 0x850)
// dev strs .. 0   (offset: 0x8bc)
// exports ... 6   (offset: 0x480)
// cseg ...... 0xe0 + 0x3a0 (0x480)
// imports ... 24  (offset: 0x570)
// animtree1 . 0   (offset: 0x8bc)
// animtree2 . 0   (offset: 0x8bc)
#using script_16ea1b94f0f381b3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\flags;
#using scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween;

#namespace mp_sat_homestead_halloween_vista_zombies;

// Namespace mp_sat_homestead_halloween_vista_zombies
// Params 0
// Checksum 0xd747357, Offset: 0xfe
// Size: 0xfe
function function_52d0d624138e1a34()
{
    level endon( #"game_ended" );
    var_8f5035af07cc7df3 = utility::getstructarray( "vista_spawn_origin", "targetname" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    function_5a591aa4b7a6a263();
    var_a5bc77146d0d4dba = [ "zombie_base" ];
    
    foreach ( struct_spawn_origin in var_8f5035af07cc7df3 )
    {
        n_random_quantity = randomintrange( 1, 4 );
        var_d4799bd378e4e842 = getrandomnavpoints( struct_spawn_origin.origin, 200, n_random_quantity );
        
        if ( var_d4799bd378e4e842.size == n_random_quantity )
        {
            level thread function_f028c5bdcb7c20be( var_a5bc77146d0d4dba, n_random_quantity, var_d4799bd378e4e842, struct_spawn_origin );
        }
    }
}

// Namespace mp_sat_homestead_halloween_vista_zombies
// Params 4, eflags: 0x4
// Checksum 0x83b8a109, Offset: 0x204
// Size: 0xfb
function private function_f028c5bdcb7c20be( var_a5bc77146d0d4dba, var_eb3b1804a4e82b81, var_8a8f4e2572ec4470, struct_spawn_origin )
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < var_eb3b1804a4e82b81 ; i++ )
    {
        zombie_type = function_b3988325430ce242( var_a5bc77146d0d4dba[ randomint( var_a5bc77146d0d4dba.size ) ] );
        v_spawn_origin = var_8a8f4e2572ec4470[ i ];
        var_8b5a2af93eaae75f = ( 0, randomint( 360 ), 0 );
        var_ea616919227739f = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_type, v_spawn_origin, var_8b5a2af93eaae75f, "neutral" );
        
        if ( isagent( var_ea616919227739f ) )
        {
            mp_sat_homestead_halloween::function_2780aabc3a33768( var_ea616919227739f );
            var_ea616919227739f thread utility::animscriptedagent( "spawn", "spawn_end", undefined, ( 0, 0, 0 ), "spawn_animating" );
            var_ea616919227739f.var_f8c5dd66e2ca06ba = 1;
            var_ea616919227739f thread randomMovement( struct_spawn_origin );
        }
        
        wait randomfloatrange( 0.5, 3 );
    }
}

// Namespace mp_sat_homestead_halloween_vista_zombies
// Params 0, eflags: 0x4
// Checksum 0x9aed3d3d, Offset: 0x307
// Size: 0x1f
function private function_5a591aa4b7a6a263()
{
    level endon( #"game_ended" );
    
    while ( !level.var_f334a2aa4deb0aeb )
    {
        waitframe();
    }
}

// Namespace mp_sat_homestead_halloween_vista_zombies
// Params 1, eflags: 0x4
// Checksum 0x2e238f94, Offset: 0x32e
// Size: 0x126
function private randomMovement( struct_spawn_origin )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.e_attractor_target = spawn( "script_model", self.origin );
    
    while ( true )
    {
        v_random_point = getrandomnavpoint( struct_spawn_origin.origin, 400 );
        self.e_attractor_target.origin = v_random_point;
        self.target_attractor = zombie_attractor_manager::add_attractor( self.e_attractor_target, 1, undefined, 0, undefined, &should_move_to, 0, undefined, 0 );
        var_6b8dd77b704151ec = distance2d( self.origin, self.e_attractor_target.origin ) < 100 ? 2 : randomfloatrange( 6, 12 );
        
        /#
            if ( level.var_82cd6c3319d72df0 )
            {
                var_fdde80e31621618f = trace::sphere_trace( v_random_point, v_random_point, 30 );
                trace::draw_trace( var_fdde80e31621618f, undefined, 1, int( 20 ) );
            }
        #/
        
        wait var_6b8dd77b704151ec;
        zombie_attractor_manager::remove_attractor( self.target_attractor );
    }
}

// Namespace mp_sat_homestead_halloween_vista_zombies
// Params 2, eflags: 0x4
// Checksum 0xcc97e0a2, Offset: 0x45c
// Size: 0x23, Type: bool
function private should_move_to( attractor, zombie )
{
    return attractor == zombie.target_attractor;
}

