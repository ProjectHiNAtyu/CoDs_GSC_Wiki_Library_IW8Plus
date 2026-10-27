// script_211a6d7f479ded99  (hash_211a6d7f479ded99.gscc) (size: 4861 Bytes / 0x12fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5dcbd1ee (1573638638)
// size ...... 4861 (0x12fd)
// includes .. 6   (offset: 0x11a1)
// strings ... 18  (offset: 0x11d1)
// dev strs .. 0   (offset: 0x12fd)
// exports ... 20  (offset: 0x99d)
// cseg ...... 0x1df + 0x7be (0x99d)
// imports ... 42  (offset: 0xcbd)
// animtree1 . 0   (offset: 0x12fd)
// animtree2 . 0   (offset: 0x12fd)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\zm_player;

#namespace zm_bgb_near_death_experience;

// Namespace zm_bgb_near_death_experience
// Params 0, eflags: 0x5
// Checksum 0x495d4b76, Offset: 0x1fd
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "near_death_experience", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x187c1fcf, Offset: 0x222
// Size: 0x43
function __init__()
{
    bgb::register( "near_death_experience", "time", 180, &enable, &disable, &validation );
    bgb::function_c9046bccce2a4ac8( "near_death_experience", &function_e4c9e826f4da942, 1 );
    bgb::function_ecc4426f6a3d4e88( "near_death_experience" );
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x65ea1389, Offset: 0x26d
// Size: 0xaa
function enable()
{
    var_e97a4f4962bc3f25 = bgb::get_bgb_slot( "near_death_experience" );
    
    if ( !isdefined( var_e97a4f4962bc3f25 ) )
    {
        return;
    }
    
    self endon( #"disconnect", #"death", "bgb_update" + var_e97a4f4962bc3f25 );
    
    if ( !isdefined( level.var_4f2e4a8fe6c6ff0f ) )
    {
        level.var_4f2e4a8fe6c6ff0f = 0;
    }
    
    self.var_78cf2184f0cd0301 = 0;
    val::set( "bgb_nde_revive", "toggle_remote_revive", 1 );
    val::set( "bgb_nde_revive", "toggle_remote_self_revive", 1 );
    thread bgb::player_proximity_watcher( "near_death_experience", 240, &proximity_start, &proximity_end );
    thread function_678886a525535e22();
    thread function_bdbab48c4a5f2df8();
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0xe4e6f6b5, Offset: 0x31f
// Size: 0x2c
function disable()
{
    val::reset_all( "bgb_nde_revive" );
    self.var_78cf2184f0cd0301 = undefined;
    self notify( "kill_" + "near_death_experience" + "_player_proximity_watcher" );
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x6a454c6c, Offset: 0x353
// Size: 0x16, Type: bool
function validation()
{
    if ( level.players.size > 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x3baa744e, Offset: 0x372
// Size: 0x45
function function_678886a525535e22()
{
    self endon( #"disconnect" );
    var_e97a4f4962bc3f25 = bgb::get_bgb_slot( "near_death_experience" );
    utility::waittill_any( "death", "bgb_update" + var_e97a4f4962bc3f25 );
    self notify( #"zm_bgb_near_death_experience_complete" );
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x5cf9a94d, Offset: 0x3bf
// Size: 0x27
function function_bdbab48c4a5f2df8()
{
    level.var_4f2e4a8fe6c6ff0f++;
    utility::waittill_any( "disconnect", "death" );
    level.var_4f2e4a8fe6c6ff0f--;
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x8399324f, Offset: 0x3ee
// Size: 0x9
function function_1c077eb1ecd1777e()
{
    add_revive_override();
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x5594bbb4, Offset: 0x3ff
// Size: 0x18
function add_revive_override()
{
    if ( !isdefined( self.var_dd2184ec0baf968e ) )
    {
        self.var_dd2184ec0baf968e = [];
    }
}

// Namespace zm_bgb_near_death_experience
// Params 1
// Checksum 0xb452a7d2, Offset: 0x41f
// Size: 0x140, Type: bool
function is_reviving_override( var_8d52cd2dc48eabda )
{
    if ( !var_8d52cd2dc48eabda.inlaststand )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return false;
    }
    
    if ( self.team != var_8d52cd2dc48eabda.team )
    {
        return false;
    }
    
    if ( self.var_af1feabe896eff01 )
    {
        return false;
    }
    
    if ( isdefined( level.var_9d4c98c8e1cd476c ) && ![[ level.var_9d4c98c8e1cd476c ]]( var_8d52cd2dc48eabda ) )
    {
        return false;
    }
    
    if ( isdefined( level.can_revive_game_module ) && ![[ level.can_revive_game_module ]]( var_8d52cd2dc48eabda ) )
    {
        return false;
    }
    
    if ( var_8d52cd2dc48eabda namespace_af5a2e4a7277c1d::function_cb6f435613626945() || !var_8d52cd2dc48eabda namespace_af5a2e4a7277c1d::function_eebc26d3ebcc3852() )
    {
        return false;
    }
    
    if ( bgb::is_enabled( "near_death_experience" ) && isdefined( self.var_d2d61a0b77c6612 ) && arraycontains( self.var_d2d61a0b77c6612, var_8d52cd2dc48eabda ) )
    {
        return true;
    }
    
    if ( bgb::is_enabled( "near_death_experience" ) && self.revivingteammate )
    {
        return true;
    }
    
    if ( var_8d52cd2dc48eabda bgb::is_enabled( "near_death_experience" ) && isdefined( var_8d52cd2dc48eabda.var_d2d61a0b77c6612 ) && arraycontains( var_8d52cd2dc48eabda.var_d2d61a0b77c6612, self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_bgb_near_death_experience
// Params 1
// Checksum 0x2cfc5d6f, Offset: 0x568
// Size: 0x16c
function proximity_start( e_player )
{
    var_5828f88668a107b3 = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
    e_player endon( var_5828f88668a107b3, #"disconnect" );
    self endon( #"disconnect", #"zm_bgb_near_death_experience_complete" );
    
    while ( true )
    {
        if ( !player::isinlaststand( e_player ) && !player::isinlaststand( self ) )
        {
            utility::waittill_any_ents( e_player, "last_stand_enter", self, "last_stand_enter" );
            wait 1;
        }
        
        thread function_d19c7a6ba64a5e30( e_player, var_5828f88668a107b3 );
        var_44e3857e40b17f10 = "zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber();
        
        if ( player::isinlaststand( e_player ) && isdefined( e_player.laststandreviveent ) && isalive( self ) )
        {
            e_player playsound( #"hash_c11511f54f4ff2c8" );
            reviveent = e_player.laststandreviveent;
            reviveent.var_fc2c12f6a236b9db = "last_stand_bgb";
            reviveent notify( #"trigger", self );
        }
        else if ( player::isinlaststand( self ) && isdefined( self.laststandreviveent ) && isalive( e_player ) )
        {
            self playsound( #"hash_c11511f54f4ff2c8" );
            reviveent = self.laststandreviveent;
            reviveent.var_fc2c12f6a236b9db = "last_stand_bgb";
            reviveent notify( #"trigger", e_player );
        }
        
        e_player waittill( var_44e3857e40b17f10 );
        wait 1;
    }
}

// Namespace zm_bgb_near_death_experience
// Params 2
// Checksum 0xf70068ca, Offset: 0x6dc
// Size: 0xa6
function function_d19c7a6ba64a5e30( e_player, str_notify )
{
    level endon( #"game_ended" );
    var_a072d641e95274b6 = function_f8f931dbe5bc846f( e_player, str_notify );
    
    if ( !var_a072d641e95274b6 )
    {
        return;
    }
    
    n_entity_number = self getentitynumber();
    increment_fx_count();
    e_player increment_fx_count();
    function_e2df444ac335f258( e_player, str_notify );
    
    if ( isdefined( self ) )
    {
        decrement_fx_count();
    }
    
    if ( isdefined( e_player ) )
    {
        e_player decrement_fx_count();
        e_player notify( "zm_bgb_near_death_experience_1p_fx_stop_" + n_entity_number );
        
        if ( !player::isinlaststand( e_player ) && isdefined( self ) )
        {
            thread increment_revive_use();
        }
    }
}

// Namespace zm_bgb_near_death_experience
// Params 2
// Checksum 0x741eaea5, Offset: 0x78a
// Size: 0x5d, Type: bool
function function_f8f931dbe5bc846f( e_player, str_notify )
{
    e_player endon( str_notify, #"disconnect" );
    self endon( #"disconnect", #"zm_bgb_near_death_experience_complete" );
    
    while ( !is_reviving_override( e_player ) && !e_player is_reviving_override( self ) )
    {
        wait 0.1;
    }
    
    return true;
}

// Namespace zm_bgb_near_death_experience
// Params 2
// Checksum 0xd28a59fe, Offset: 0x7f0
// Size: 0x58
function function_e2df444ac335f258( e_player, str_notify )
{
    e_player endon( #"disconnect" );
    self endon( #"disconnect", #"zm_bgb_near_death_experience_complete" );
    
    while ( is_reviving_override( e_player ) || e_player is_reviving_override( self ) )
    {
        wait 0.1;
    }
}

// Namespace zm_bgb_near_death_experience
// Params 1
// Checksum 0x77a2280a, Offset: 0x850
// Size: 0x28
function proximity_end( e_player )
{
    str_notify = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
    e_player notify( str_notify );
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x2d7a5963, Offset: 0x880
// Size: 0x48
function increment_fx_count()
{
    if ( !isdefined( self.var_75ca480fa1357586 ) || self.var_75ca480fa1357586 == 0 )
    {
        self.var_75ca480fa1357586 = 1;
        self setscriptablepartstate( "bgb_near_death_experience", "bgb_fx_on", 0 );
        return;
    }
    
    self.var_75ca480fa1357586++;
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0x4a3b9b5e, Offset: 0x8d0
// Size: 0x2b
function decrement_fx_count()
{
    self.var_75ca480fa1357586--;
    
    if ( self.var_75ca480fa1357586 == 0 )
    {
        self setscriptablepartstate( "bgb_near_death_experience", "bgb_fx_off", 0 );
    }
}

// Namespace zm_bgb_near_death_experience
// Params 0
// Checksum 0xdb67b477, Offset: 0x903
// Size: 0x6d
function increment_revive_use()
{
    self.var_78cf2184f0cd0301 = self.var_78cf2184f0cd0301 ?? 0;
    self.var_78cf2184f0cd0301++;
    var_e97a4f4962bc3f25 = bgb::get_bgb_slot( "near_death_experience" );
    
    if ( !isdefined( var_e97a4f4962bc3f25 ) )
    {
        return;
    }
    
    var_d1e1920ac64d4d1a = bgb::function_bc8c83873f4039ba( var_e97a4f4962bc3f25 );
    
    if ( self.var_78cf2184f0cd0301 >= 5 )
    {
        self notify( "bgb_end_type_time_limit" + var_d1e1920ac64d4d1a );
    }
}

// Namespace zm_bgb_near_death_experience
// Params 1
// Checksum 0xbe848bc4, Offset: 0x978
// Size: 0x24, Type: bool
function function_e4c9e826f4da942( params )
{
    if ( params.reason === "last_stand_bgb" )
    {
        return true;
    }
    
    return false;
}

