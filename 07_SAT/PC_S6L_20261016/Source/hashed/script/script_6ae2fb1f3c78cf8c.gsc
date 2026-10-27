// script_6ae2fb1f3c78cf8c  (hash_6ae2fb1f3c78cf8c.gscc) (size: 3996 Bytes / 0xf9c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2dfa7ece (771391182)
// size ...... 3996 (0xf9c)
// includes .. 7   (offset: 0xecc)
// strings ... 11  (offset: 0xf04)
// dev strs .. 0   (offset: 0xf9c)
// exports ... 10  (offset: 0x9cc)
// cseg ...... 0x1b4 + 0x818 (0x9cc)
// imports ... 29  (offset: 0xb5c)
// animtree1 . 0   (offset: 0xf9c)
// animtree2 . 0   (offset: 0xf9c)
#using script_359c9cda9983c8fc;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_slayer_arena_prototype;

// Namespace ztron_slayer_arena_prototype
// Params 0, eflags: 0x5
// Checksum 0xa559f504, Offset: 0x1d2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"prototype", undefined, &arena_init, undefined );
}

// Namespace ztron_slayer_arena_prototype
// Params 0
// Checksum 0xb8a43f35, Offset: 0x1f3
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_slayer_arena_prototype
// Params 0
// Checksum 0xdb119d32, Offset: 0x204
// Size: 0x2a
function arena_init_internal()
{
    waittillframeend();
    ztron_slayer::function_2295e22fea1bdcc3( "prototype", &prototype_init, &prototype_shutdown );
    ztron_sound::function_4ac735395b173fe( "lava_pool_ready_to_explode", "exp_ai_triton_fireball_main" );
}

// Namespace ztron_slayer_arena_prototype
// Params 1
// Checksum 0xdf7e3d90, Offset: 0x236
// Size: 0xed
function prototype_init( arena )
{
    arena.level_structs = utility::getstructarray( "ztron_slayer_arena_struct_" + arena.name, "targetname" );
    
    foreach ( struct in arena.level_structs )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_e1a0560e0454f732":
                level thread function_875f164d627212cf( struct, arena );
                break;
            case #"hash_a274579b42bb942b":
                level thread lava_fountain_pool( struct, arena );
                break;
        }
    }
}

// Namespace ztron_slayer_arena_prototype
// Params 1
// Checksum 0x4f7d970c, Offset: 0x32b
// Size: 0x18
function prototype_shutdown( arena )
{
    level notify( #"prototype_slayer_deactivate" );
}

// Namespace ztron_slayer_arena_prototype
// Params 2
// Checksum 0x96a06334, Offset: 0x34b
// Size: 0x2a
function function_875f164d627212cf( struct, arena )
{
    level endon( #"prototype_slayer_deactivate", #"ztron_game_is_over" );
}

// Namespace ztron_slayer_arena_prototype
// Params 2
// Checksum 0x9f7b392d, Offset: 0x37d
// Size: 0x463
function lava_fountain_pool( struct, arena )
{
    level endon( #"prototype_slayer_deactivate", #"ztron_game_is_over", #"slayer_round_finished" );
    var_f05752c6a92e4f93 = -65;
    var_99c9051094a95088 = 65;
    rangemin = 128;
    rangemax = 512;
    var_6abe9d57fb052329 = 16;
    var_e5833edd8a5b29e7 = 700;
    var_e5a62cdd8a814a09 = 1700;
    var_23d28086ebad5b8f = 3;
    var_abb880bf1a045a7c = 3;
    level thread ztron_debug::drawsphere( struct.origin, 8, 999, ( 0, 0, 1 ) );
    firepool = utility::spawn_model( "tag_origin", struct.origin, ( 0, 0, 0 ) );
    firepool thread ztron_util::function_36239518d8da65f0( level, "prototype_slayer_deactivate" );
    
    while ( true )
    {
        numfires = var_23d28086ebad5b8f;
        poolfires = [];
        
        while ( numfires )
        {
            fire = utility::spawn_model( "tag_origin", struct.origin, ( 0, 0, 0 ) );
            fire thread ztron_util::function_36239518d8da65f0( level, "prototype_slayer_deactivate" );
            poolfires[ poolfires.size ] = fire;
            fire thread firewander();
            numfires--;
        }
        
        wait randomintrange( 15, 25 );
        
        foreach ( fire in poolfires )
        {
            fire.submerge = 1;
        }
        
        do
        {
            keepwaiting = 0;
            
            foreach ( fire in poolfires )
            {
                if ( !fire.submerged )
                {
                    keepwaiting = 1;
                }
            }
            
            wait 0.25;
        }
        while ( keepwaiting );
        
        ztron_sound::ztron_playsound( "lava_pool_ready_to_explode", struct.origin );
        firepool thread zombie_triton_lava_bomb::lava_bomb_aoe( struct.origin + ( -24, 0, -64 ), struct.angles, 64, 5, 8 );
        wait 1.5;
        
        foreach ( fire in poolfires )
        {
            var_dcd7d0b52191ba5e = var_abb880bf1a045a7c;
            
            foreach ( point in fire.launchpoints )
            {
                launchvector = struct.angles;
                randomyaw = ( 0, randomfloatrange( launchvector[ 1 ] + var_f05752c6a92e4f93, launchvector[ 1 ] + var_99c9051094a95088 ), 0 );
                launchvector = rotatevector( ( 1, 0, 0 ), randomyaw );
                launchvector = launchvector * randomintrange( rangemin, rangemax ) + ( 0, 0, randomintrange( var_e5833edd8a5b29e7, var_e5a62cdd8a814a09 ) );
                startpoint = point + ( 0, 0, var_6abe9d57fb052329 );
                
                /#
                #/
                
                grenade = fire launchgrenade( "sat_ztron_lava_grenade", startpoint, launchvector );
                
                if ( isdefined( grenade ) )
                {
                    grenade thread function_223f2797910bb198();
                }
                
                var_dcd7d0b52191ba5e--;
                
                if ( var_dcd7d0b52191ba5e <= 0 )
                {
                    wait 0.1;
                    var_dcd7d0b52191ba5e = var_abb880bf1a045a7c;
                }
            }
            
            fire delete();
        }
        
        wait randomintrange( 15, 25 );
    }
}

// Namespace ztron_slayer_arena_prototype
// Params 0
// Checksum 0x90f83acf, Offset: 0x7e8
// Size: 0x58
function function_223f2797910bb198()
{
    playfxontag( utility::getfx( "ztron_lava_ball" ), self, "tag_origin" );
    self waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    thread zombie_triton_lava_bomb::lava_bomb_aoe( origin, self.angles, 128, 5, 8, "scriptable_zombie_triton_lava_bomb_aoe_ztron_slayer_prototype" );
}

// Namespace ztron_slayer_arena_prototype
// Params 0
// Checksum 0x882cd04f, Offset: 0x848
// Size: 0x184
function firewander()
{
    level endon( #"prototype_slayer_deactivate", #"ztron_game_is_over", #"slayer_round_finished" );
    self endon( #"death" );
    center = self.origin;
    self.origin += ( 0, 0, -128 );
    self.launchpoints = [];
    playfxontag( utility::getfx( "ztron_fire_ethereal_purple" ), self, "tag_origin" );
    self moveto( center, 2 );
    self waittill( #"movedone" );
    unitvec = vectornormalize( ( 1, 1, 0 ) );
    
    while ( !self.submerge )
    {
        randomyaw = ( 0, randomint( 360 ), 0 );
        localvec = rotatevector( unitvec, randomyaw );
        desiredpoint = center + localvec * randomintrange( 20, 50 );
        self moveto( desiredpoint, 3 );
        self waittill( #"movedone" );
        self.launchpoints[ self.launchpoints.size ] = self.origin;
        wait randomintrange( 2, 5 );
    }
    
    self moveto( center, 2 );
    self waittill( #"movedone" );
    self moveto( center + ( 0, 0, -128 ), 1 );
    self waittill( #"movedone" );
    self.submerged = 1;
}

