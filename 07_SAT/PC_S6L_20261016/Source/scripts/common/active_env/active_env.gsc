// scripts\common\active_env\active_env.gsc  (hash_1bb3f21d31b94999.gscc) (size: 4413 Bytes / 0x113d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x14181292 (337121938)
// size ...... 4413 (0x113d)
// includes .. 7   (offset: 0xff1)
// strings ... 21  (offset: 0x1029)
// dev strs .. 0   (offset: 0x113d)
// exports ... 10  (offset: 0x9e1)
// cseg ...... 0x20d + 0x7d4 (0x9e1)
// imports ... 40  (offset: 0xb71)
// animtree1 . 0   (offset: 0x113d)
// animtree2 . 0   (offset: 0x113d)
#using script_30b9616be05303bb;
#using scripts\common\active_env\diving_board;
#using scripts\common\active_env\ferris_wheel;
#using scripts\common\active_env\launcher;
#using scripts\common\active_env\lever_platform;
#using scripts\common\active_env\roll_up_door;
#using scripts\common\utility;

#namespace active_env;

// Namespace active_env
// Params 0
// Checksum 0x4dd9ae7b, Offset: 0x22b
// Size: 0x258
function init_active_env()
{
    utility::flag_wait( "scriptables_ready" );
    function_f2f042d9b73b378();
    var_d37a801556f8f138 = getentarray( "active_env", #script_noteworthy );
    var_938b56d219a9137b = getentitylessscriptablearray( "active_env", #script_noteworthy );
    var_f866e7e2f40b4b27 = getnoentvolumearray( "active_env", #script_noteworthy );
    var_24234d8e1d562d44 = getentitylessscriptablearray( "arcwire_receiver", #script_noteworthy );
    var_fc986b77e2eb711a = utility::getstructarray( "active_env", "script_noteworthy" );
    var_dc9ef32c949a352c = arraycombine( var_d37a801556f8f138, var_938b56d219a9137b, var_f866e7e2f40b4b27, var_24234d8e1d562d44, var_fc986b77e2eb711a );
    
    if ( var_dc9ef32c949a352c.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_c1431a6b58631d15 ) )
    {
        level.var_c1431a6b58631d15 = [];
    }
    
    level.var_c1431a6b58631d15[ "diving_board_trig" ] = &diving_board::diving_board;
    level.var_c1431a6b58631d15[ "firing_range_target" ] = &namespace_a53b139e84e26e3a::firing_range_target_init;
    level.var_c1431a6b58631d15[ "ferris_wheel_spokes" ] = &ferris_wheel::function_608ecf2462b35d42;
    level.var_c1431a6b58631d15[ "launcher" ] = &launcher::launcher_init;
    level.var_c1431a6b58631d15[ "lever_platform" ] = &lever_platform::lever_platform_init;
    level.var_c1431a6b58631d15[ "roll_up_door" ] = &roll_up_door::roll_up_door_init;
    level.var_c1431a6b58631d15[ "vent_cover" ] = &vent_cover_watcher;
    var_b23933f9dac2ac2 = [ "scriptable_t10_door_rollup_garage_lrg_02", "scriptable_t10_door_rollup_garage_med_02", "scriptable_t10_door_rollup_garage_sml_02" ];
    
    foreach ( active_env_element in var_dc9ef32c949a352c )
    {
        if ( isdefined( level.var_c1431a6b58631d15[ active_env_element.targetname ] ) )
        {
            str_name = active_env_element.targetname;
        }
        else if ( isdefined( function_f02c63b99c9614c9( var_b23933f9dac2ac2, active_env_element.classname ) ) )
        {
            str_name = "roll_up_door";
        }
        else
        {
            continue;
        }
        
        active_env_element thread [[ level.var_c1431a6b58631d15[ str_name ] ]]();
    }
}

// Namespace active_env
// Params 2
// Checksum 0xc3f10c19, Offset: 0x48b
// Size: 0x39
function function_d9f741be3d50fcaa( key, var_38a31a16013818cc )
{
    if ( !isdefined( level.var_c1431a6b58631d15 ) )
    {
        level.var_c1431a6b58631d15 = [];
    }
    
    level.var_c1431a6b58631d15[ key ] = var_38a31a16013818cc;
}

// Namespace active_env
// Params 2
// Checksum 0x1a38fb4f, Offset: 0x4cc
// Size: 0x42
function register_active_env_element( key, var_c1c765e2f7157b71 )
{
    if ( !isdefined( level.var_fc986b77e2eb711a ) )
    {
        level.var_fc986b77e2eb711a = [];
    }
    
    level.var_fc986b77e2eb711a[ level.var_fc986b77e2eb711a.size ] = var_c1c765e2f7157b71;
}

// Namespace active_env
// Params 0
// Checksum 0x4d681858, Offset: 0x516
// Size: 0xc9
function function_f2f042d9b73b378()
{
    var_46b7cbb539db7e62 = getentitylessscriptablearray( "glass_door_handle", #script_noteworthy );
    
    foreach ( scr_glass_door_handle in var_46b7cbb539db7e62 )
    {
        if ( isdefined( scr_glass_door_handle.target ) )
        {
            scr_glass_door_handle.n_glass_id = getglass( scr_glass_door_handle.target );
        }
        
        if ( isdefined( scr_glass_door_handle.n_glass_id ) )
        {
            scr_glass_door_handle thread glass_door_handle_watcher();
        }
    }
}

// Namespace active_env
// Params 0, eflags: 0x4
// Checksum 0xd15e9d57, Offset: 0x5e7
// Size: 0x4f
function private glass_door_handle_watcher()
{
    level endon( #"hash_ae78a05a1f3ffddb" );
    
    while ( true )
    {
        level waittill( #"glass_destroyed", var_c329557c922b1e69 );
        
        if ( var_c329557c922b1e69 == self.n_glass_id )
        {
            self setscriptablepartstate( "base", "dead" );
            return;
        }
    }
}

// Namespace active_env
// Params 0
// Checksum 0x2ead271f, Offset: 0x63e
// Size: 0x8b
function vent_cover_watcher()
{
    level endon( #"game_ended" );
    self.trigger = spawn( "noent_volume_trigger_box", self.origin + ( 0, 0, 30 ), 0, ( 70, 50, 30 ), ( 70, 50, 30 ) );
    self.trigger.angles = self.angles;
    thread function_1804bf80f6f6c09d();
    vent_damage_watcher();
    self.trigger delete();
}

// Namespace active_env
// Params 0, eflags: 0x4
// Checksum 0x2896c3f7, Offset: 0x6d1
// Size: 0xac
function private vent_damage_watcher()
{
    self endon( #"vent_cover_detached" );
    self waittill( #"scriptable_engine_damaged", einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
    var_52e91dc92914217 = anglestoforward( self.angles );
    thread detach_vent( vpoint, var_52e91dc92914217 );
}

// Namespace active_env
// Params 0, eflags: 0x4
// Checksum 0x9c648d10, Offset: 0x785
// Size: 0x149
function private function_1804bf80f6f6c09d()
{
    level endon( #"game_ended" );
    self endon( #"vent_cover_detached" );
    var_75b50d0b1edfe2e4 = anglestoforward( self.angles );
    
    for ( var_e7000cbd4ccc3377 = 0; !var_e7000cbd4ccc3377 ; var_e7000cbd4ccc3377 = 1 )
    {
        self.trigger waittill( #"trigger", e_ent );
        
        if ( isplayer( e_ent ) )
        {
            e_player = e_ent;
            
            if ( distancesquared( e_player.origin, self.origin ) > 2500 )
            {
                continue;
            }
            
            var_82e2c3938077edb6 = e_player getvelocity();
            var_d0dfddb67a759416 = vectordot2( var_82e2c3938077edb6, var_75b50d0b1edfe2e4, 1 );
            var_4aa4b731f489a681 = abs( var_d0dfddb67a759416 ) >= 1 - clamp( 0.3, 0, 1 );
            var_d656739b290e9fd6 = e_player issprintsliding();
            var_672ac7ddf638d1f5 = e_player isdiving();
            var_c0fb7bc022c7f1f0 = ( var_672ac7ddf638d1f5 || var_d656739b290e9fd6 ) && var_4aa4b731f489a681;
            
            if ( !var_c0fb7bc022c7f1f0 )
            {
                continue;
            }
            
            thread detach_vent( self.origin - ( 0, 0, 15 ), vectornormalize( var_82e2c3938077edb6 ) );
        }
    }
}

// Namespace active_env
// Params 2
// Checksum 0x99868246, Offset: 0x8d6
// Size: 0x10b
function detach_vent( contactpoint, impulseangles )
{
    self setscriptablepartstate( #"model", #"hidden" );
    self notify( #"vent_cover_detached" );
    
    if ( issubstr( self.type, "clean::" ) )
    {
        model_name = getsubstr( self.type, 7 ) + "_destr";
    }
    else
    {
        model_name = self.type + "_destr";
    }
    
    dynamic_vent = spawn( "script_model", self.origin );
    dynamic_vent setmodel( model_name );
    dynamic_vent.angles = self.angles;
    dynamic_vent setscriptablepartstate( "base", #"dead" );
    dynamic_vent physicslaunchserver( contactpoint, impulseangles * 1000 );
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    dynamic_vent endon( #"death" );
    wait 10;
    dynamic_vent delete();
}

