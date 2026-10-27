// script_2476be160a49d65  (hash_02476be160a49d65.gscc) (size: 5837 Bytes / 0x16cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc47b1a02 (3296401922)
// size ...... 5837 (0x16cd)
// includes .. 11  (offset: 0x1539)
// strings ... 22  (offset: 0x1591)
// dev strs .. 1   (offset: 0x16c1)
// exports ... 15  (offset: 0xc41)
// cseg ...... 0x1d1 + 0xa70 (0xc41)
// imports ... 57  (offset: 0xe99)
// animtree1 . 0   (offset: 0x16cd)
// animtree2 . 0   (offset: 0x16cd)
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\hud_message;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_bgb_helping_hound;

// Namespace zm_bgb_helping_hound
// Params 0, eflags: 0x5
// Checksum 0xe1a1e63d, Offset: 0x1ef
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "helping_hound", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_helping_hound
// Params 0
// Checksum 0xf01d4424, Offset: 0x214
// Size: 0x7a
function __init__()
{
    namespace_6616340f3419ea2d::register( "helping_hound", "time", 300, &enable, &disable, &validation );
    callback::add( "on_hellhound_petted", &on_hellhound_petted );
    callback::add( "player_on_teleport", &on_player_teleport );
    callback::add( #"player_disconnect", &on_player_disconnect );
    utility::registersharedfunc( #"bgb", #"teleport_helping_hound", &teleport_hound );
}

// Namespace zm_bgb_helping_hound
// Params 0
// Checksum 0xec9ffb03, Offset: 0x296
// Size: 0x15c
function enable()
{
    self endon( #"game_ended", #"hash_4f25592308c0bbaa" );
    self.bgb_hellping_hound = spawn_hound( "zombie_hellping_hound" );
    
    if ( !isdefined( self.bgb_hellping_hound ) )
    {
        assertmsg( "<dev string:x24>" + self getentitynumber() );
        return;
    }
    
    self.bgb_hellping_hound set_vars();
    self.bgb_hellping_hound zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", #"hash_ecc264e099746480", 6 );
    self.bgb_hellping_hound zombie_utils::function_c2cee1190760989c( self );
    utility::callsharedfunc( #"zombie", #"hash_c9776044d2711c07", self.bgb_hellping_hound );
    self.bgb_hellping_hound.var_bd22ba6c600a23a3 = self;
    self.bgb_hellping_hound setthreatbiasgroup( "team_players" );
    self.bgb_hellping_hound function_fa32376aaa88a7a2( self.origin, 2000 );
    self playsoundonmovingent( #"hash_145cee5c3defd6c9" );
    self.bgb_hellping_hound thread helping_hound_stuck_monitor();
    self.bgb_hellping_hound thread function_87e379897efe6ca7( self );
    wait 0.1;
    self.bgb_hellping_hound utility::function_32b24db3127bff40( "icon", "active_hellping_hound" );
    self.bgb_hellping_hound utility::function_32b24db3127bff40( "base", "base_off" );
}

// Namespace zm_bgb_helping_hound
// Params 0
// Checksum 0x6d19faac, Offset: 0x3fa
// Size: 0xe8
function disable()
{
    self notify( #"hash_4f25592308c0bbaa" );
    
    if ( !isdefined( self.bgb_hellping_hound ) )
    {
        return;
    }
    
    if ( self.bgb_hellping_hound.helping_hound_stuck_badplace_id )
    {
        self.bgb_hellping_hound notify( #"helping_hound_destroy_stuck_nav" );
    }
    
    self.bgb_hellping_hound val::set( #"bgb_helping_hound", "damageshield", 0 );
    self.bgb_hellping_hound val::set( #"bgb_helping_hound", "damage", 1 );
    self.bgb_hellping_hound val::set( #"bgb_helping_hound", "death", 1 );
    self.bgb_hellping_hound dodamage( self.bgb_hellping_hound.health + 1000, self.bgb_hellping_hound.origin );
    self.bgb_hellping_hound = undefined;
}

// Namespace zm_bgb_helping_hound
// Params 0
// Checksum 0x90c98410, Offset: 0x4ea
// Size: 0x47, Type: bool
function validation()
{
    location = getclosestpointonnavmesh( self.origin + anglestoforward( ( 0, self getplayerangles()[ 1 ], 0 ) ) * 200, self );
    
    if ( !isdefined( location ) || !zone_manager::function_65305a611c6226d9( location ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_bgb_helping_hound
// Params 1, eflags: 0x4
// Checksum 0xe95bb6e7, Offset: 0x53a
// Size: 0xc5
function private spawn_hound( subclass )
{
    location = getclosestpointonnavmesh( self.origin + anglestoforward( ( 0, self getplayerangles()[ 1 ], 0 ) ) * 200, self );
    zombie = agent_manager::spawn_agent( subclass, location, undefined, "team_two_hundred" );
    spawn_angles = ( 0, self getplayerangles()[ 1 ] + 180, 0 );
    spawn_location = { #angles:spawn_angles, #origin:location };
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawn_location );
    round_number = zm_round_logic::get_rb_round_number();
    round_difficulty = round_number;
    zombie zombie_utils::set_zombie_round_difficulty( round_difficulty );
    return zombie;
}

// Namespace zm_bgb_helping_hound
// Params 0
// Checksum 0x3262992e, Offset: 0x608
// Size: 0xe5
function set_vars()
{
    val::set( #"bgb_helping_hound", "damage", 0 );
    val::set( #"bgb_helping_hound", "damageshield", 1 );
    val::set( #"bgb_helping_hound", "death", 0 );
    val::set( #"bgb_helping_hound", "allow_secondary_attack_damage", 0 );
    val::set( #"bgb_helping_hound", "ignoreme", 1 );
    self.var_190f8e8daa83f8c = 1;
    self.var_15598d8e493afe88 = 1;
    self.var_6298584c895e2be0 = 1;
    self.var_8784eb75b9be9390 = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    val::set( #"bgb_helping_hound", "ignore_cleanup", 1 );
    self.helping_hound_stuck_badplace_id = undefined;
    self.helping_hound_stuck_repulsor_name = undefined;
    self function_54d3d4ceb3d0bc90();
}

// Namespace zm_bgb_helping_hound
// Params 1
// Checksum 0x24630133, Offset: 0x6f5
// Size: 0x34
function on_hellhound_petted( doggo )
{
    if ( namespace_6616340f3419ea2d::is_active( "helping_hound" ) )
    {
        doggo.dog setscriptablepartstate( "heal_audio", "on" );
    }
}

// Namespace zm_bgb_helping_hound
// Params 1, eflags: 0x4
// Checksum 0x9b873f65, Offset: 0x731
// Size: 0xab
function private function_87e379897efe6ca7( player )
{
    self endon( #"death" );
    player endon( #"hash_4f25592308c0bbaa", #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 0.5;
        zombies_left = utility::callsharedfunc( #"zombie", #"get_round_enemies" );
        
        if ( zombies_left.size == 1 && !self.var_aa1ab061871da96f )
        {
            self.var_aa1ab061871da96f = 1;
            player hud_message::showerrormessage( %"hash_3355dd7b7212b488" );
        }
        
        thread teleport_hound( player, 1 );
    }
}

// Namespace zm_bgb_helping_hound
// Params 2, eflags: 0x4
// Checksum 0x82be70ac, Offset: 0x7e4
// Size: 0x121, Type: bool
function private teleport_hound( player, b_check_distance = 0 )
{
    if ( zone_manager::function_90e5c3e2272b0130( self.origin ) == player zone_manager::function_90e5c3e2272b0130( player.origin ) )
    {
        return false;
    }
    
    if ( b_check_distance && distancesquared( self.origin, player.origin ) <= 5760000 )
    {
        return false;
    }
    
    teleport_dir = anglestoforward( ( 0, player getplayerangles()[ 1 ], 0 ) );
    var_73b0ea3734d457ab = getclosestpointonnavmesh( player.origin + teleport_dir * 200, player );
    
    if ( !b_check_distance || !isdefined( var_73b0ea3734d457ab ) || !zone_manager::function_65305a611c6226d9( var_73b0ea3734d457ab ) )
    {
        var_73b0ea3734d457ab = getclosestpointonnavmesh( player.origin, player );
    }
    
    path_pts = self findpath( var_73b0ea3734d457ab, player getorigin() );
    
    if ( isdefined( var_73b0ea3734d457ab ) && zone_manager::function_65305a611c6226d9( var_73b0ea3734d457ab ) && isdefined( path_pts ) )
    {
        self setorigin( var_73b0ea3734d457ab );
        self notify( #"hash_21563b0f0f5e277d" );
        return true;
    }
    
    return false;
}

// Namespace zm_bgb_helping_hound
// Params 0, eflags: 0x4
// Checksum 0x66873ab6, Offset: 0x90e
// Size: 0x14f
function private helping_hound_stuck_monitor()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    last_pos = self.origin;
    stuck_time = 0;
    
    while ( true )
    {
        wait 0.5;
        
        if ( !isdefined( self.enemy ) || !isalive( self.enemy ) )
        {
            stuck_time = 0;
            last_pos = self.origin;
            
            if ( self.helping_hound_stuck_badplace_id )
            {
                self notify( #"helping_hound_destroy_stuck_nav" );
            }
            
            continue;
        }
        
        moved_dist_sqr = distancesquared( last_pos, self.origin );
        
        if ( moved_dist_sqr <= 576 )
        {
            stuck_time += 0.5;
            
            if ( stuck_time >= 2 && !isdefined( self.helping_hound_stuck_badplace_id ) )
            {
                self.helping_hound_stuck_badplace_id = createnavbadplacebyent( self );
                self.helping_hound_stuck_repulsor_name = "helping_hound_stuck_" + self getentitynumber();
                createnavrepulsor( self.helping_hound_stuck_repulsor_name, -1, self, 32, 0 );
                thread function_e87f76e3f2c1ce64( self.helping_hound_stuck_badplace_id, self.helping_hound_stuck_repulsor_name );
            }
            
            continue;
        }
        
        stuck_time = 0;
        last_pos = self.origin;
        
        if ( self.helping_hound_stuck_badplace_id )
        {
            self notify( #"helping_hound_destroy_stuck_nav" );
        }
    }
}

// Namespace zm_bgb_helping_hound
// Params 2, eflags: 0x4
// Checksum 0xcac51322, Offset: 0xa65
// Size: 0x99
function private function_e87f76e3f2c1ce64( var_8de6f80b3674ce04, repulsor_name )
{
    level endon( #"game_ended" );
    msg = utility::waittill_any_in_array_or_timeout( [ "death", "helping_hound_destroy_stuck_nav" ], 8 );
    
    if ( isdefined( var_8de6f80b3674ce04 ) )
    {
        destroynavobstacle( var_8de6f80b3674ce04 );
    }
    
    destroynavrepulsor( repulsor_name );
    
    if ( msg != "death" )
    {
        if ( self.helping_hound_stuck_badplace_id == var_8de6f80b3674ce04 )
        {
            self.helping_hound_stuck_badplace_id = undefined;
        }
        
        if ( self.helping_hound_stuck_repulsor_name == repulsor_name )
        {
            self.helping_hound_stuck_repulsor_name = undefined;
        }
    }
}

// Namespace zm_bgb_helping_hound
// Params 1, eflags: 0x4
// Checksum 0x3fdeef8b, Offset: 0xb06
// Size: 0x88
function private on_player_teleport( params )
{
    if ( !isdefined( self.bgb_hellping_hound ) )
    {
        return;
    }
    
    self.bgb_hellping_hound endon( #"death", #"hash_21563b0f0f5e277d" );
    self endon( #"hash_4f25592308c0bbaa", #"disconnect" );
    level endon( #"game_ended" );
    wait 3;
    
    if ( isdefined( self.bgb_hellping_hound ) )
    {
        while ( true )
        {
            self.bgb_hellping_hound teleport_hound( self );
            wait 0.5;
        }
    }
}

// Namespace zm_bgb_helping_hound
// Params 1, eflags: 0x4
// Checksum 0x6c4f822b, Offset: 0xb96
// Size: 0xab
function private on_player_disconnect( params )
{
    if ( isdefined( self.bgb_hellping_hound ) )
    {
        self notify( #"hash_4f25592308c0bbaa" );
        var_62f538f25aff1d94 = self.bgb_hellping_hound;
        
        if ( isdefined( var_62f538f25aff1d94 ) )
        {
            var_62f538f25aff1d94 val::set( #"bgb_helping_hound", "damage", 1 );
            var_62f538f25aff1d94 val::set( #"bgb_helping_hound", "death", 1 );
            var_62f538f25aff1d94 val::set( #"bgb_helping_hound", "damageshield", 0 );
            var_62f538f25aff1d94 dodamage( var_62f538f25aff1d94.health + 1000, var_62f538f25aff1d94.origin );
        }
    }
}

