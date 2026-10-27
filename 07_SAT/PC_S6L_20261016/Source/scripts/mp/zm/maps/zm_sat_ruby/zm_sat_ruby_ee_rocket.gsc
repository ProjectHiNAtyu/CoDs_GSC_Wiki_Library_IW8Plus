// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_rocket.gsc  (hash_775914951e078881.gscc) (size: 5091 Bytes / 0x13e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa62b8 (680632)
// size ...... 5091 (0x13e3)
// includes .. 10  (offset: 0x129f)
// strings ... 17  (offset: 0x12ef)
// dev strs .. 1   (offset: 0x13d7)
// exports ... 11  (offset: 0xa3f)
// cseg ...... 0x1d1 + 0x86e (0xa3f)
// imports ... 59  (offset: 0xbf7)
// animtree1 . 0   (offset: 0x13e3)
// animtree2 . 0   (offset: 0x13e3)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_ee_rocket;

// Namespace zm_sat_ruby_ee_rocket
// Params 0, eflags: 0x5
// Checksum 0x27936d16, Offset: 0x1ef
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_ee_rocket", #"zm_quest", &function_38142600daee17a2, &function_9a8922152d8b4033 );
}

// Namespace zm_sat_ruby_ee_rocket
// Params 0, eflags: 0x4
// Checksum 0xe92f5e1d, Offset: 0x21c
// Size: 0x96
function private function_38142600daee17a2()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level._effect[ "ruby_bst_hit" ] = loadfxasset( "vfx_t10_levels_zm_quartz_sl_takedown_explo" );
    level._effect[ "ruby_bst_trail" ] = loadfxasset( "vfx_t10_levels_zm_quartz_sl_fire_burn_trail" );
    level._effect[ "ruby_bst_impact" ] = loadfxasset( "vfx_sat_wc_libra_mech_mortar_impact" );
    zm_quest::register_quest_step( #"ruby_ee_rocket", #"hit_rocket", &function_b586bc739fdd739c, &function_9a3d6926f327282c );
}

// Namespace zm_sat_ruby_ee_rocket
// Params 0, eflags: 0x4
// Checksum 0xb7154733, Offset: 0x2ba
// Size: 0x4e
function private function_9a8922152d8b4033()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_init_done" );
    zm_save::function_1f44a48caae2acbf();
    level callback::add( "on_round_start", &function_7671f522b2be4300 );
}

// Namespace zm_sat_ruby_ee_rocket
// Params 1, eflags: 0x4
// Checksum 0x8407b3db, Offset: 0x310
// Size: 0x52
function private function_7671f522b2be4300( params )
{
    if ( params.roundnumber == 15 || getdvarint( @"hash_ce1eef9ce8fc9e6b", 0 ) )
    {
        level thread zm_quest::start_quest( #"ruby_ee_rocket" );
        level callback::remove( "on_round_start", &function_7671f522b2be4300 );
    }
}

// Namespace zm_sat_ruby_ee_rocket
// Params 2, eflags: 0x4
// Checksum 0x59fe9498, Offset: 0x36a
// Size: 0x87
function private function_b586bc739fdd739c( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    level.var_6877527cd881ec30 = getent( "ruby_ee_rocket", #targetname );
    mdl_rocket = level.var_6877527cd881ec30;
    mdl_rocket show();
    mdl_rocket setcandamage( 1 );
    level thread function_8bded534943f8a61( mdl_rocket );
    mdl_rocket waittill( #"hash_7563563629108fc4", player );
    mdl_rocket function_66fb4034ff3a293e( player );
}

// Namespace zm_sat_ruby_ee_rocket
// Params 2, eflags: 0x4
// Checksum 0x11c720aa, Offset: 0x3f9
// Size: 0x3d
function private function_9a3d6926f327282c( b_skipped, b_save_restored )
{
    /#
        if ( b_skipped && !b_save_restored )
        {
            getent( "<dev string:x24>", #targetname ) function_66fb4034ff3a293e();
        }
    #/
}

// Namespace zm_sat_ruby_ee_rocket
// Params 3, eflags: 0x4
// Checksum 0x754ea7, Offset: 0x43e
// Size: 0x19a
function private function_66fb4034ff3a293e( eattacker = level.players[ 0 ], vdir = vectornormalize( vpoint - eattacker.origin ), vpoint = self.origin )
{
    v_landing = eattacker.origin;
    playfxanydistance( level._effect[ "ruby_bst_hit" ], vpoint );
    eattacker playsoundtoplayer( "evt_ee_complete_success_stinger", eattacker );
    self notify( #"ruby_bst_hit" );
    self rotatevelocity( vdir * 100, 10, 0.1 );
    self moveto( self.origin + vdir * 200000, 30 );
    e_mover = utility::spawn_model( "tag_origin", vpoint );
    e_mover forcenetfieldhighlod( 1 );
    waitframe();
    playfxontag( level._effect[ "ruby_bst_trail" ], e_mover, "tag_origin" );
    e_mover moveto( v_landing, 10, 9, 0.1 );
    e_mover waittill( #"movedone" );
    e_mover delete();
    playfx( level._effect[ "ruby_bst_impact" ], v_landing );
    level thread function_3d65a83fbe6bd54d( v_landing );
    spawnoptions = common_item::function_bc5ff2958b71a708( v_landing + ( 0, 0, 3 ), ( 0, 0, 90 ) );
    common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_sat_item_weapon_pi_raygun", undefined, spawnoptions );
    thread utility::delete_on_notify( "movedone" );
}

// Namespace zm_sat_ruby_ee_rocket
// Params 1, eflags: 0x4
// Checksum 0x57b403c6, Offset: 0x5e0
// Size: 0x175
function private function_3d65a83fbe6bd54d( v_landing )
{
    a_ai = getaiarrayinradius( v_landing, 256, level.var_ece703e3d116381c );
    a_ai = utility::get_array_of_closest( v_landing, a_ai );
    n_ragdolls = 0;
    
    foreach ( ai in a_ai )
    {
        if ( !issubstr( ai.subclass, "zombie_base" ) && !issubstr( ai.subclass, "galileo_drone" ) )
        {
            continue;
        }
        
        if ( n_ragdolls < 6 )
        {
            n_force = 5000 + randomintrange( -1000, 1000 );
            ai zm_cleanup_manager::function_dd62e2042418b7e5();
            ai kill();
            corpse = ai getcorpseentity();
            
            if ( corpse )
            {
                vec = vectornormalize( ai.origin - v_landing );
                vec = ( vec[ 0 ], vec[ 1 ], randomfloatrange( 0.75, 1 ) );
                corpse startragdollfromimpact( "torso_lower", vec * n_force );
                n_ragdolls++;
            }
            
            waitframe();
            continue;
        }
        
        ai thread zombie_knockdown::function_6fc167d4a3590991( v_landing, n_force, 35 );
    }
}

// Namespace zm_sat_ruby_ee_rocket
// Params 1, eflags: 0x4
// Checksum 0x566a8a09, Offset: 0x75d
// Size: 0x16c
function private function_8bded534943f8a61( mdl_rocket )
{
    mdl_rocket endon( #"ruby_bst_hit" );
    level thread rocket_music( mdl_rocket );
    var_f78511be97bccc3f = utility::getstruct( mdl_rocket.target );
    a_v_path = [ var_f78511be97bccc3f.origin ];
    
    /#
        if ( getdvarint( @"hash_ce1eef9ce8fc9e6b", 0 ) )
        {
            a_v_path = [];
            mdl_rocket.origin = var_f78511be97bccc3f.origin;
        }
    #/
    
    while ( var_f78511be97bccc3f.target )
    {
        var_7b97f011bb3a6659 = utility::getstruct( var_f78511be97bccc3f.target );
        var_f78511be97bccc3f = var_7b97f011bb3a6659;
        a_v_path[ a_v_path.size ] = var_7b97f011bb3a6659.origin;
    }
    
    a_v_path[ a_v_path.size ] = mdl_rocket.origin;
    
    while ( mdl_rocket )
    {
        foreach ( v_move in a_v_path )
        {
            mdl_rocket moveto( v_move, 150 );
            mdl_rocket rotateby( ( 10800, 0, 0 ), 150 );
            wait 150;
        }
    }
}

// Namespace zm_sat_ruby_ee_rocket
// Params 1, eflags: 0x4
// Checksum 0x875d55c1, Offset: 0x8d1
// Size: 0x16e
function private rocket_music( mdl_rocket )
{
    mdl_rocket endon( #"ruby_bst_hit" );
    
    if ( !getdvarint( @"hash_ce1eef9ce8fc9e6b", 0 ) )
    {
        wait 120;
    }
    
    while ( mdl_rocket )
    {
        played_count = 0;
        
        foreach ( player in level.players )
        {
            if ( player.rocket_music_played )
            {
                continue;
            }
            
            if ( player && player playerads() == 1 && player zm_utility::is_player_facing( mdl_rocket.origin, 50000, 5 ) )
            {
                v_start = player utility::get_player_camera_origin();
                v_end = v_start + anglestoforward( player getplayerangles() ) * 9999;
                b_sighted = trace::ray_trace_passed( v_start, v_end, player );
                
                if ( b_sighted )
                {
                    player playsoundtoplayer( #"hash_6bd71c68a2030cb2", player, mdl_rocket );
                    player.rocket_music_played = 1;
                    played_count++;
                    
                    if ( played_count >= level.players.size )
                    {
                        return;
                    }
                }
            }
        }
        
        wait 2;
    }
}

