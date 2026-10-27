// script_12a881b6c7ad6f5e  (hash_12a881b6c7ad6f5e.gscc) (size: 4436 Bytes / 0x1154 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x94c7545c (2496091228)
// size ...... 4436 (0x1154)
// includes .. 1   (offset: 0x1088)
// strings ... 16  (offset: 0x1090)
// dev strs .. 0   (offset: 0x1154)
// exports ... 10  (offset: 0xb04)
// cseg ...... 0x158 + 0x9ac (0xb04)
// imports ... 34  (offset: 0xc94)
// animtree1 . 0   (offset: 0x1154)
// animtree2 . 0   (offset: 0x1154)
#using scripts\common\utility;

#namespace namespace_1c7d0bfcc1711f4;

// Namespace namespace_1c7d0bfcc1711f4
// Params 0
// Checksum 0xcaea75e7, Offset: 0x176
// Size: 0x5f
function function_431ffae9d97d6e98()
{
    level thread population_counter_controller();
    function_50d61136a4abb139();
    var_94807f9a507b74eb = getentarray( "easter_egg_prop", #script_noteworthy );
    function_331d6a2528cb944a( var_94807f9a507b74eb );
    
    if ( level.b_is_private_match )
    {
        level.var_94807f9a507b74eb = var_94807f9a507b74eb;
    }
    
    level thread function_32109607524cbf12();
    level thread function_f6f64f643b05d435();
}

// Namespace namespace_1c7d0bfcc1711f4
// Params 0, eflags: 0x4
// Checksum 0xe82e0ce8, Offset: 0x1dd
// Size: 0xe9
function private function_50d61136a4abb139()
{
    var_7fb912ac660a330f = getentarray( "spawning_cover", #script_noteworthy );
    var_b26a94206b5ec8dd = arraycontains( [ "dom", "sd", "control", "landgrab", "hc_dom", "hc_sd" ], level.gametype );
    
    if ( !var_b26a94206b5ec8dd )
    {
        foreach ( e_cover_geo in var_7fb912ac660a330f )
        {
            e_cover_geo disconnectpaths();
            e_cover_geo delete();
        }
    }
}

// Namespace namespace_1c7d0bfcc1711f4
// Params 1, eflags: 0x4
// Checksum 0xf1b8a415, Offset: 0x2ce
// Size: 0x83
function private function_331d6a2528cb944a( var_94807f9a507b74eb )
{
    foreach ( e_prop in var_94807f9a507b74eb )
    {
        e_prop connectpaths();
        e_prop hide();
    }
}

// Namespace namespace_1c7d0bfcc1711f4
// Params 0, eflags: 0x4
// Checksum 0x261e9d33, Offset: 0x359
// Size: 0x20a
function private function_32109607524cbf12()
{
    utility::flag_wait( "scriptables_ready" );
    var_dc54880b147638d5 = getentitylessscriptablearray( "mannequin_head", #script_noteworthy );
    var_dc54880b147638d5 = arrayrandomize( var_dc54880b147638d5 );
    var_fc3be38749c43a7a = [];
    var_5bda60efce8b1fde = var_dc54880b147638d5.size;
    var_24b02a6b79a691a3 = utility::array_slice( var_dc54880b147638d5, 0, 28 );
    var_fc3be38749c43a7a = utility::array_slice( var_dc54880b147638d5, 28, var_5bda60efce8b1fde );
    
    foreach ( var_97d4865c3b188e31 in var_fc3be38749c43a7a )
    {
        var_c8622885e0be6beb = var_97d4865c3b188e31 utility::get_linked_ents();
        var_789e22608dc194a8 = var_97d4865c3b188e31 utility::function_e1bb0bf82dab729e();
        var_c8622885e0be6beb = arraycombine( var_c8622885e0be6beb, var_789e22608dc194a8 );
        
        foreach ( var_16c705b9493ecc82 in var_c8622885e0be6beb )
        {
            if ( var_16c705b9493ecc82.classname == "script_brushmodel" )
            {
                var_16c705b9493ecc82 connectpaths();
                var_16c705b9493ecc82 delete();
                continue;
            }
            
            if ( var_16c705b9493ecc82.classname == "script_model" )
            {
                var_16c705b9493ecc82 delete();
                continue;
            }
            
            var_16c705b9493ecc82 setscriptablepartstate( #"base", #"hide" );
        }
        
        var_97d4865c3b188e31 setscriptablepartstate( #"base", #"hide" );
    }
    
    level notify( #"mannequins_initialized" );
    
    /#
        if ( getdvarint( @"hash_6afc53200b4ed0b5", 0 ) )
        {
            level thread debug_draw_mannequins( var_24b02a6b79a691a3, var_fc3be38749c43a7a );
        }
    #/
}

// Namespace namespace_1c7d0bfcc1711f4
// Params 0, eflags: 0x4
// Checksum 0x8e05f79c, Offset: 0x56b
// Size: 0x84
function private function_f6f64f643b05d435()
{
    level endon( #"start_game_ended" );
    level waittill( #"prematch_done" );
    var_c0c54922278fa9b3 = "mp_t10_nuketown_tv_archie_atom";
    setdvar( @"bg_cinematicfullscreen", "0" );
    playcinematicforalllooping( var_c0c54922278fa9b3 );
    level thread function_2d4e70e784a7e09();
    
    if ( level.b_is_private_match )
    {
        level waittill( #"hash_183fc0706792f99e" );
        wait 1;
        setdvar( @"bg_cinematicfullscreen", "0" );
        playcinematicforalllooping( var_c0c54922278fa9b3 );
    }
}

// Namespace namespace_1c7d0bfcc1711f4
// Params 0, eflags: 0x4
// Checksum 0x7c7abdd3, Offset: 0x5f7
// Size: 0x20
function private function_2d4e70e784a7e09()
{
    level endon( #"game_ended" );
    level waittill( #"start_game_ended" );
    stopcinematicforall();
}

// Namespace namespace_1c7d0bfcc1711f4
// Params 0, eflags: 0x4
// Checksum 0xb7df20f4, Offset: 0x61f
// Size: 0x33a
function private population_counter_controller()
{
    level endon( #"game_ended" );
    var_362d15e9e208b8e5 = -36;
    var_76131a22bef69ee3 = getentarray( "pop_counter", #script_noteworthy );
    
    if ( var_76131a22bef69ee3.size == 0 )
    {
        return;
    }
    
    if ( var_76131a22bef69ee3[ 1 ].script_parameters == "up_to_increase" )
    {
        var_362d15e9e208b8e5 *= -1;
    }
    
    level.population_counter = spawnstruct();
    
    foreach ( var_6eacf1bb03a7e16a in var_76131a22bef69ee3 )
    {
        switch ( var_6eacf1bb03a7e16a.targetname )
        {
            case #"hash_33a18a6e261f6ac5":
                level.population_counter.tens = var_6eacf1bb03a7e16a;
                level.population_counter.tens.zero_angle_x = var_6eacf1bb03a7e16a.angles[ 0 ];
                break;
            case #"hash_e55cc73ff8e616f4":
                level.population_counter.ones = var_6eacf1bb03a7e16a;
                level.population_counter.ones.zero_angle_x = var_6eacf1bb03a7e16a.angles[ 0 ];
                break;
            default:
                break;
        }
    }
    
    while ( true )
    {
        wait 1;
        n_population = level.players.size + ( level.a_ai_zombies_alive.size ?? 0 );
        n_ones_angle_y = level.population_counter.ones.angles[ 1 ];
        n_ones_angle_z = level.population_counter.ones.angles[ 2 ];
        n_tens_angle_y = level.population_counter.tens.angles[ 1 ];
        n_tens_angle_z = level.population_counter.tens.angles[ 2 ];
        n_ones = n_population % 10;
        n_tens = int( n_population / 10 );
        n_ones_angle_x = level.population_counter.ones.zero_angle_x + n_ones * var_362d15e9e208b8e5;
        n_tens_angle_x = level.population_counter.tens.zero_angle_x + n_tens * var_362d15e9e208b8e5;
        level.population_counter.ones rotateto( ( n_ones_angle_x, n_ones_angle_y, n_ones_angle_z ), 1, 0.5, 0.5 );
        level.population_counter.tens rotateto( ( n_tens_angle_x, n_tens_angle_y, n_tens_angle_z ), 1, 0.5, 0.5 );
    }
}

/#

    // Namespace namespace_1c7d0bfcc1711f4
    // Params 2, eflags: 0x4
    // Checksum 0x82d9f354, Offset: 0x961
    // Size: 0x67, Type: dev
    function private debug_draw_mannequins( var_24b02a6b79a691a3, var_fc3be38749c43a7a )
    {
        level endon( #"game_ended" );
        v_color_keep = ( 0, 1, 0 );
        v_color_remove = ( 1, 0, 0 );
        
        while ( true )
        {
            function_372c3d15228552d5( var_24b02a6b79a691a3, v_color_keep );
            waitframe();
        }
    }

    // Namespace namespace_1c7d0bfcc1711f4
    // Params 2, eflags: 0x4
    // Checksum 0xc94524e9, Offset: 0x9d0
    // Size: 0x134, Type: dev
    function private function_372c3d15228552d5( var_dc54880b147638d5, var_c9e35826ee79c05c )
    {
        foreach ( scr_mannequin_head in var_dc54880b147638d5 )
        {
            debugaxis( scr_mannequin_head.origin, scr_mannequin_head.angles, 16, var_c9e35826ee79c05c[ 0 ] == 0 ? 1 : 0 );
            var_c8622885e0be6beb = scr_mannequin_head utility::get_linked_ents();
            
            foreach ( var_16c705b9493ecc82 in var_c8622885e0be6beb )
            {
                drawentitybounds( var_16c705b9493ecc82, var_c9e35826ee79c05c );
            }
        }
    }

#/
