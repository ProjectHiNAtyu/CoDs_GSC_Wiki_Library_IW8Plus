// script_1f1a175b236da2b9  (hash_1f1a175b236da2b9.gscc) (size: 4041 Bytes / 0xfc9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63710fc4 (1668353988)
// size ...... 4041 (0xfc9)
// includes .. 7   (offset: 0xee5)
// strings ... 10  (offset: 0xf1d)
// dev strs .. 3   (offset: 0xfa5)
// exports ... 18  (offset: 0x781)
// cseg ...... 0xe3 + 0x69e (0x781)
// imports ... 41  (offset: 0xa51)
// animtree1 . 0   (offset: 0xfc9)
// animtree2 . 0   (offset: 0xfc9)
#using script_16ea1b94f0f381b3;
#using script_ac28d65e8605696;
#using script_e92a9717969a5cd;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;

#namespace europa_ground_smash;

// Namespace europa_ground_smash
// Params 0, eflags: 0x5
// Checksum 0x89cbf94e, Offset: 0x101
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa_ground_smash", undefined, undefined, &post_main );
}

// Namespace europa_ground_smash
// Params 0
// Checksum 0x16865d24, Offset: 0x122
// Size: 0x36
function post_main()
{
    callback::add( #"hash_7e3a7d30f11f29e6", &init_cool_down );
    callback::add( #"europa_init", &on_init );
    
    /#
        devgui_init();
    #/
}

// Namespace europa_ground_smash
// Params 1, eflags: 0x4
// Checksum 0x1cf68e5a, Offset: 0x160
// Size: 0x6b
function private init_cool_down( params )
{
    var_61e74f222e6e4cd6 = self.aisettings.specificaisettings.var_61e74f222e6e4cd6;
    
    /#
        if ( isdvardefined( @"hash_d42e67b841086d1f" ) )
        {
            var_61e74f222e6e4cd6 = getdvarfloat( @"hash_d42e67b841086d1f" );
        }
    #/
    
    if ( isdefined( var_61e74f222e6e4cd6 ) )
    {
        europa::register_cool_down( "ground_smash", var_61e74f222e6e4cd6 );
    }
}

// Namespace europa_ground_smash
// Params 1, eflags: 0x4
// Checksum 0xfd59eb25, Offset: 0x1d3
// Size: 0x2a
function private on_init( params )
{
    utility::registersharedfunc( #"europa", #"hash_daff0d3946426012", &function_2e1bc83142d83fa6 );
}

// Namespace europa_ground_smash
// Params 1
// Checksum 0x97780f9c, Offset: 0x205
// Size: 0x13
function function_2e1bc83142d83fa6( params )
{
    ground_smash();
}

// Namespace europa_ground_smash
// Params 0
// Checksum 0x36a88b97, Offset: 0x220
// Size: 0xa5, Type: bool
function can_ground_smash()
{
    /#
        if ( getdvarint( @"hash_1f88b3eda6c37267" ) )
        {
            return false;
        }
    #/
    
    if ( !europa::is_activated() )
    {
        return false;
    }
    
    if ( europa::has_cool_down( "ground_smash" ) || europa::has_cool_down( "skill_common" ) )
    {
        return false;
    }
    
    if ( europa::is_script_animation() )
    {
        return false;
    }
    
    enemies = utility::callsharedfunc( "zombie", #"get_round_enemies" );
    
    if ( enemies )
    {
        settings = self.aisettings.specificaisettings;
        
        if ( enemies.size <= settings.var_cd20e88cf1ce2a08 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace europa_ground_smash
// Params 2
// Checksum 0x5d316486, Offset: 0x2ce
// Size: 0x137, Type: bool
function function_a2bb6f57a48599e3( pos, var_879b577a5277fd1a )
{
    var_1e73da4ea0fee70c = 0;
    var_ed36d408e2dc6f91 = self.aisettings.specificaisettings.var_ed36d408e2dc6f91;
    
    if ( var_ed36d408e2dc6f91 > 0 )
    {
        var_ed36d408e2dc6f91 *= var_879b577a5277fd1a ?? 1;
        targets = getaiarrayinradius( pos, var_ed36d408e2dc6f91 );
        
        foreach ( target in targets )
        {
            if ( target.team != self.team && isalive( target ) )
            {
                var_1e73da4ea0fee70c++;
            }
        }
        
        var_9c73035e23398ecc = self.aisettings.specificaisettings.var_9c73035e23398ecc ?? -1;
        
        if ( var_9c73035e23398ecc >= 0 && var_1e73da4ea0fee70c >= var_9c73035e23398ecc )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace europa_ground_smash
// Params 0
// Checksum 0xd425b062, Offset: 0x40e
// Size: 0x21
function ground_smash()
{
    europa::start_cool_down( "ground_smash" );
    europa::start_cool_down( "skill_common" );
    thread ground_smash_thread();
}

// Namespace europa_ground_smash
// Params 0, eflags: 0x4
// Checksum 0x806e9b8a, Offset: 0x437
// Size: 0x87
function private ground_smash_thread()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    europa::function_47761cd429bc0244();
    self.europa.ground_smashing = 1;
    thread europa::play_vo( "ground_pound" );
    childthread function_204158493747f78();
    europa_asm::play_scripted_anim( "foot_stomp" );
    self setscriptablepartstate( "groundSmash", "default" );
    self notify( #"ground_smash_end" );
    self.europa.ground_smashing = 0;
}

// Namespace europa_ground_smash
// Params 0, eflags: 0x4
// Checksum 0x87eebf0c, Offset: 0x4c6
// Size: 0xdf
function private function_204158493747f78()
{
    self waittill( #"smash" );
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( !isdefined( damage ) )
    {
        damage = 500;
    }
    
    self setscriptablepartstate( "groundSmash", "smash" );
    radius = self.aisettings.specificaisettings.var_ed36d408e2dc6f91 ?? 256;
    params = { #radius:radius, #damage:damage, #attacker:self };
    callback::callback( #"hash_a22cade132a5709e", params );
    self radiusdamage( self.origin, radius, damage, damage, self, "MOD_EXPLOSIVE", undefined );
}

// Namespace europa_ground_smash
// Params 1
// Checksum 0xce7eae35, Offset: 0x5ad
// Size: 0x7a
function function_f16fd87651673217( taskid )
{
    if ( !can_ground_smash() )
    {
        return anim.failure;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return anim.failure;
    }
    
    if ( europa::has_command() )
    {
        return anim.failure;
    }
    
    if ( function_a2bb6f57a48599e3( self.enemy.origin ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa_ground_smash
// Params 1
// Checksum 0xd5539600, Offset: 0x630
// Size: 0x4a
function function_c663a575ae9ac4cf( taskid )
{
    if ( !can_ground_smash() )
    {
        return anim.failure;
    }
    
    if ( function_a2bb6f57a48599e3( self.origin, 0.5 ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa_ground_smash
// Params 1
// Checksum 0x4f59893d, Offset: 0x683
// Size: 0x1c
function function_74007e7f97a3d273( taskid )
{
    ground_smash();
    return anim.success;
}

// Namespace europa_ground_smash
// Params 1
// Checksum 0x1154f680, Offset: 0x6a8
// Size: 0x35
function function_35c91b0c8bfbe517( taskid )
{
    if ( self.europa.ground_smashing )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace europa_ground_smash
// Params 1
// Checksum 0x79210663, Offset: 0x6e6
// Size: 0x15
function function_8c644b49179eb48b( taskid )
{
    return anim.success;
}

/#

    // Namespace europa_ground_smash
    // Params 0
    // Checksum 0x77b1f920, Offset: 0x704
    // Size: 0x2e, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x4a>", &devgui_ground_smash );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace europa_ground_smash
    // Params 0
    // Checksum 0xe9326eda, Offset: 0x73a
    // Size: 0x47, Type: dev
    function devgui_ground_smash()
    {
        europa = level.europa;
        
        if ( isdefined( europa ) && europa europa::is_activated() )
        {
            europa utility::callsharedfunc( #"europa", #"hash_daff0d3946426012" );
        }
    }

#/
