// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes.gsc  (hash_2e7868af1d8923cf.gscc) (size: 26210 Bytes / 0x6662 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b5bb86f (2606479471)
// size ...... 26210 (0x6662)
// includes .. 19  (offset: 0x5bee)
// strings ... 87  (offset: 0x5c86)
// dev strs .. 67  (offset: 0x632e)
// exports ... 59  (offset: 0x3e56)
// cseg ...... 0x55e + 0x38f8 (0x3e56)
// imports ... 156 (offset: 0x478e)
// animtree1 . 0   (offset: 0x6662)
// animtree2 . 0   (offset: 0x6662)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ammomods\lightray;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes_create_script;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\trap_core;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_murder_holes;

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x5
// Checksum 0x7b577e83, Offset: 0x57c
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"murder_holes", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0x86ae5c9e, Offset: 0x5a1
// Size: 0x1b
function private function_7cf8dacb278a2665()
{
    level._effect[ "vfx_sat_hornet_murder_holes_ghostly_rifle_muzzle_flash" ] = loadfxasset( "vfx_sat_hornet_murder_holes_ghostly_rifle_muzzle_flash" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0x9fa2d666, Offset: 0x5c4
// Size: 0xdf
function private postmain_init()
{
    create_script_utility::register_cs_offsets( "zm_sat_hornet_murder_holes_create_script", ( 0, -24576, 0 ), ( 0, 0, 0 ) );
    zm_sat_hornet_murder_holes_create_script::main();
    level.murder_holes_throttle = throttle::throttle_initialize( "murder_holes", 1 );
    level.murder_holes_root = spawnstruct();
    level.murder_holes_root.var_e725bf9b59413d89 = 0;
    level utility::flag_wait( "scriptables_ready" );
    callback::add( "on_zombie_ai_killed", &function_b0f916cb11863d33 );
    trap_core::function_63a557f0f22161af( "murder_holes_trap", &function_340882f745709b57, &deactivate_trap, &can_use_murder_holes, &function_18548d1612658dc1, &cool_down_handler );
    function_e8fc43c657f4b9d9();
    function_7ddc3bde71aa45ff();
    level thread function_df27d98c3e976541();
    
    /#
        function_d31b66456569393a();
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_a1e5f0e244a46b3f", &function_24c840e3dfa09439 );
}

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0x4cb50c95, Offset: 0x6ab
// Size: 0x2a7
function private function_e8fc43c657f4b9d9()
{
    level.murder_holes_root.var_2747e0528b1f176 = [];
    num_traps = utility::getstructarray( "murder_holes_trap", "targetname" ).size;
    var_4b5633bb09f45692 = 1;
    
    for ( i = var_4b5633bb09f45692; i < var_4b5633bb09f45692 + num_traps ; i++ )
    {
        var_2fe9ace9588585d1 = utility::getstruct( "mh_root_" + i, "script_noteworthy" );
        var_2fe9ace9588585d1.var_fc824b622a52db8d = utility::getstructarray( "mh_komainu_" + i, "targetname" );
        var_2fe9ace9588585d1.a_komainu = [];
        
        foreach ( struct in var_2fe9ace9588585d1.var_fc824b622a52db8d )
        {
            var_2fe9ace9588585d1.a_komainu[ var_2fe9ace9588585d1.a_komainu.size ] = struct.switch_scriptable;
            
            if ( struct.script_label == "alt" )
            {
                struct.switch_scriptable.var_33cd52a70a6e7b2b = 1;
            }
            
            struct.var_4d40b73592a8fc86 = &function_f90f0b102267b3a7;
        }
        
        var_2fe9ace9588585d1.a_ghosts = getentitylessscriptablearray( "mh_ghosts_" + i, "targetname" );
        var_2fe9ace9588585d1.demon_ts = 0;
        var_2fe9ace9588585d1.woman_ts = 0;
        var_2fe9ace9588585d1.monkey_ts = 0;
        var_2fe9ace9588585d1.fox_ts = 0;
        
        foreach ( ghost in var_2fe9ace9588585d1.a_ghosts )
        {
            ghost.trap_root = var_2fe9ace9588585d1;
        }
        
        level.murder_holes_root.var_2747e0528b1f176[ level.murder_holes_root.var_2747e0528b1f176.size ] = var_2fe9ace9588585d1;
        s_upgrade = utility::getstruct( "mh_upg_" + i, "script_noteworthy" );
        var_2fe9ace9588585d1.s_upgrade = s_upgrade;
    }
    
    level utility::flag_set( "mh_ready" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x5e8b1e4c, Offset: 0x95a
// Size: 0x28
function private function_f90f0b102267b3a7( str_part, str_state )
{
    function_73d62b7ad489e020( self.var_32f1e7774266024b, str_part, str_state );
}

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0xa2d2f81a, Offset: 0x98a
// Size: 0x10c
function private function_7ddc3bde71aa45ff()
{
    foreach ( trap in level.murder_holes_root.var_2747e0528b1f176 )
    {
        foreach ( komainu in trap.a_komainu )
        {
            if ( !komainu.var_33cd52a70a6e7b2b )
            {
                komainu setscriptablepartstate( "model", "alt" );
            }
        }
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1
// Checksum 0x54364394, Offset: 0xa9e
// Size: 0x73
function function_9ceca8d29317aa92( s_trap_root )
{
    if ( s_trap_root.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    s_trap_root.var_df00f5fbf4a6d195 = 1;
    s_trap_root.var_4dcbf485031cd3e6 = &function_ebbc83ae5ae506d2;
    function_73d62b7ad489e020( s_trap_root, "glyph", "lock" );
    function_73d62b7ad489e020( s_trap_root, "base", "no_power" );
    function_d800e5849992e281( s_trap_root, "fx", "none" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1
// Checksum 0xf9c2d224, Offset: 0xb19
// Size: 0x2e
function function_3564479f464a54bd( s_trap_root )
{
    if ( s_trap_root.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    function_73d62b7ad489e020( s_trap_root, "damage", "pristine" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1
// Checksum 0x8cee95e8, Offset: 0xb4f
// Size: 0x2e
function function_1802c8377563dddf( s_trap_root )
{
    if ( s_trap_root.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    function_73d62b7ad489e020( s_trap_root, "damage", "none" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1
// Checksum 0x903ac558, Offset: 0xb85
// Size: 0x6b
function function_a5a77f6d33ed909( s_trap_root )
{
    if ( !s_trap_root.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    s_trap_root.var_df00f5fbf4a6d195 = undefined;
    s_trap_root.var_4dcbf485031cd3e6 = undefined;
    function_73d62b7ad489e020( s_trap_root, "glyph", "none" );
    function_73d62b7ad489e020( s_trap_root, "base", "ready" );
    function_d800e5849992e281( s_trap_root, "fx", "ready" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x5d6f9664, Offset: 0xbf8
// Size: 0xb0
function private function_340882f745709b57( activator )
{
    self.var_32f1e7774266024b notify( #"trap_activated" );
    self.var_32f1e7774266024b.var_711e3c9a288e87ff = 1;
    self.var_32f1e7774266024b.activator = activator;
    self.var_32f1e7774266024b.trap_scriptable = self;
    
    if ( isdefined( activator ) && !activator utility::ent_flag( "laser_trap_first_kill_vo" ) )
    {
        if ( !level callback::exists( "on_zombie_ai_killed", &function_f00c0f833e8147fc ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
        }
    }
    
    function_acdf38ad5093d64d( self.var_32f1e7774266024b );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xebcf52e4, Offset: 0xcb0
// Size: 0x6d
function private deactivate_trap( activator )
{
    self.var_32f1e7774266024b notify( #"trap_duration_ended" );
    self.var_32f1e7774266024b.var_711e3c9a288e87ff = undefined;
    self.var_32f1e7774266024b.activator = undefined;
    self.var_32f1e7774266024b.var_9339b1b1ae6d30bd = undefined;
    function_d800e5849992e281( self, "fx", "none", 1 );
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x1c28500c, Offset: 0xd25
// Size: 0x60, Type: bool
function private can_use_murder_holes( activator, interact )
{
    if ( self.var_df00f5fbf4a6d195 )
    {
        return false;
    }
    
    if ( !level utility::flag( "power_on" ) && !level utility::flag( "force_traps_on" ) )
    {
        return false;
    }
    
    if ( !activator currency::attempt_purchase( #"essence", 0 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xf7b4072e, Offset: 0xd8e
// Size: 0x41
function private function_18548d1612658dc1( activator )
{
    self.var_4dcbf485031cd3e6 = undefined;
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x80aac840, Offset: 0xdd8
// Size: 0x2d
function private function_ebbc83ae5ae506d2( activator )
{
    return { #string:&"hash_2fef21365355cf6b", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x24528a79, Offset: 0xe0e
// Size: 0x107
function private cool_down_handler( activator )
{
    level endon( #"game_ended" );
    function_d800e5849992e281( self, "fx", "none" );
    
    if ( self.var_df00f5fbf4a6d195 )
    {
        function_73d62b7ad489e020( self, "base", "no_power" );
    }
    else
    {
        function_73d62b7ad489e020( self, "base", "cooldown" );
    }
    
    /#
        if ( getdvarint( @"hash_cfcdb945d0507870", 0 ) == 1 )
        {
            wait_dur = level.var_d6ac96657b3d40e7;
        }
    #/
    
    if ( !isdefined( wait_dur ) )
    {
        if ( isdefined( level.var_228d4dde2f35bfcb ) )
        {
            wait_dur = 2;
        }
        else
        {
            wait_dur = 60;
        }
    }
    
    utility::waittill_notify_or_timeout( "trap_finish_cooldown_early", wait_dur );
    self notify( #"cooldown_finished" );
    function_d800e5849992e281( self, "fx", "ready" );
    
    if ( self.var_df00f5fbf4a6d195 )
    {
        function_73d62b7ad489e020( self, "base", "no_power" );
        return;
    }
    
    function_73d62b7ad489e020( self, "base", "ready" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0x9db84476, Offset: 0xf1d
// Size: 0x6d
function private function_df27d98c3e976541()
{
    level utility::flag_wait_any( "power_on", "force_traps_on" );
    wait 0.25;
    
    if ( !level utility::flag( "all_traps_disabled" ) )
    {
        function_53e8f28ae292bd06( "fx", "ready" );
    }
    else
    {
        level utility::flag_waitopen( "all_traps_disabled" );
        function_53e8f28ae292bd06( "fx", "ready" );
    }
    
    function_156db6bb06d3e3e6( "base", "ready" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x8e61984c, Offset: 0xf92
// Size: 0x16
function private function_acdf38ad5093d64d( s_trap_root )
{
    level thread function_42443638073c50f2( s_trap_root );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xadde5c09, Offset: 0xfb0
// Size: 0x228
function private function_42443638073c50f2( s_trap_root )
{
    s_trap_root endon( #"trap_duration_ended" );
    group_1 = [];
    group_2 = [];
    var_e4b227e2fcccf4fb = s_trap_root.activator.team;
    
    foreach ( ghost in s_trap_root.a_ghosts )
    {
        if ( ghost.script_noteworthy == "1" )
        {
            group_1[ group_1.size ] = ghost;
            continue;
        }
        
        group_2[ group_2.size ] = ghost;
    }
    
    while ( true )
    {
        foreach ( ghost in group_1 )
        {
            target = ghost find_valid_target( var_e4b227e2fcccf4fb );
            
            if ( isalive( target ) )
            {
                ghost thread function_6d459758e3503c2e( target );
            }
        }
        
        var_4a51e5c73c92f230 = randomfloatrange( 0.4, 0.6 );
        wait var_4a51e5c73c92f230;
        
        foreach ( ghost in group_2 )
        {
            target = ghost find_valid_target( var_e4b227e2fcccf4fb );
            
            if ( isalive( target ) )
            {
                ghost thread function_6d459758e3503c2e( target );
            }
        }
        
        total_wait = randomfloatrange( 1.4, 1.8 ) - var_4a51e5c73c92f230;
        wait total_wait;
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xe91988e3, Offset: 0x11e0
// Size: 0x106
function private find_valid_target( var_e4b227e2fcccf4fb )
{
    potential_targets = [];
    ai_in_range = getaiarrayinradius( self.origin, 500 );
    
    foreach ( ai in ai_in_range )
    {
        b_in_fov = utility::within_fov( self.origin, self.angles, ai.origin, cos( 45 ) );
        
        if ( b_in_fov && isalive( ai ) && ai.team != var_e4b227e2fcccf4fb )
        {
            potential_targets[ potential_targets.size ] = ai;
        }
    }
    
    if ( potential_targets.size > 0 )
    {
        return utility::array_random( potential_targets );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x472eb02b, Offset: 0x12ef
// Size: 0x1cf
function private function_6d459758e3503c2e( target )
{
    level endon( #"game_ended" );
    
    if ( !self.trap_root.var_9339b1b1ae6d30bd )
    {
        self.trap_root.var_9339b1b1ae6d30bd = 1;
        self.trap_root.speaker = utility::spawn_tag_origin( level.players[ 0 ].origin );
        self.trap_root.speaker dialogue::say( "dx_zm_htrp_trft_ghrm_htfmdrhlcmm" );
    }
    
    selected_attack = roll_attack_type( self.trap_root ) ?? "rifle";
    
    switch ( selected_attack )
    {
        case #"hash_95de77bd9ef1f27f":
            thread shoot_hand_cannon( target, "red_ug_mh" );
            self.trap_root.demon_ts = gettime();
            break;
        case #"hash_c83704da3472455f":
            thread shoot_rifle( target, "green_ug_mh" );
            self.trap_root.woman_ts = gettime();
            break;
        case #"hash_577cc846df74818e":
            thread shoot_hand_cannon( target, "yellow_ug_mh" );
            self.trap_root.monkey_ts = gettime();
            break;
        case #"hash_89ad2801d88826a5":
            function_435e50542cd532e2();
            self.trap_root.fox_ts = gettime();
            break;
        case #"hash_badf8f8f263b2b7c":
            thread shoot_hand_cannon( target );
            break;
        case #"hash_8cdaf2e4ecfe5b51":
        default:
            thread shoot_rifle( target );
            break;
    }
    
    wait 0.8;
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xbba2a976, Offset: 0x14c6
// Size: 0x1c8
function private roll_attack_type( s_trap_root )
{
    var_9b9e0e03acdd21b1 = 100;
    var_31bec983e44c8b05 = [];
    var_5dc7013c7fc5a551 = [];
    all_chances = [ 25, 15, 20, 10 ];
    
    if ( s_trap_root utility::ent_flag( "red_ug_mh" ) || level utility::flag( "red_ug_mh" ) )
    {
        if ( utility::time_has_passed( s_trap_root.demon_ts, 4 ) )
        {
            var_31bec983e44c8b05[ var_31bec983e44c8b05.size ] = "red_ug_mh";
            var_5dc7013c7fc5a551[ var_5dc7013c7fc5a551.size ] = 25;
            var_9b9e0e03acdd21b1 -= 25;
        }
    }
    
    if ( s_trap_root utility::ent_flag( "green_ug_mh" ) || level utility::flag( "green_ug_mh" ) )
    {
        if ( utility::time_has_passed( s_trap_root.woman_ts, 6 ) )
        {
            var_31bec983e44c8b05[ var_31bec983e44c8b05.size ] = "green_ug_mh";
            var_5dc7013c7fc5a551[ var_5dc7013c7fc5a551.size ] = 15;
            var_9b9e0e03acdd21b1 -= 15;
        }
    }
    
    if ( s_trap_root utility::ent_flag( "yellow_ug_mh" ) || level utility::flag( "yellow_ug_mh" ) )
    {
        if ( utility::time_has_passed( s_trap_root.monkey_ts, 9 ) )
        {
            var_31bec983e44c8b05[ var_31bec983e44c8b05.size ] = "yellow_ug_mh";
            var_5dc7013c7fc5a551[ var_5dc7013c7fc5a551.size ] = 20;
            var_9b9e0e03acdd21b1 -= 20;
        }
    }
    
    if ( s_trap_root utility::ent_flag( "white_ug_mh" ) || level utility::flag( "white_ug_mh" ) )
    {
        if ( utility::time_has_passed( s_trap_root.fox_ts, 15 ) )
        {
            var_31bec983e44c8b05[ var_31bec983e44c8b05.size ] = "white_ug_mh";
            var_5dc7013c7fc5a551[ var_5dc7013c7fc5a551.size ] = 10;
            var_9b9e0e03acdd21b1 -= 10;
        }
    }
    
    var_31bec983e44c8b05[ var_31bec983e44c8b05.size ] = "cannon";
    var_5dc7013c7fc5a551[ var_5dc7013c7fc5a551.size ] = 8;
    var_9b9e0e03acdd21b1 -= 8;
    var_31bec983e44c8b05[ var_31bec983e44c8b05.size ] = "rifle";
    var_5dc7013c7fc5a551[ var_5dc7013c7fc5a551.size ] = var_9b9e0e03acdd21b1;
    return utility::random_weighted( var_31bec983e44c8b05, var_5dc7013c7fc5a551 );
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x973f60, Offset: 0x1697
// Size: 0x64
function private shoot_rifle( target, upgrade_type )
{
    level endon( #"game_ended" );
    show_samurai_ghost( "shoot_rifle", upgrade_type );
    self.var_8bd50ab544e66903 = 1;
    waitframe();
    function_5a48a73ee2c4ab48( target, "rifle", upgrade_type );
    wait 1.2;
    hide_samurai_ghost( upgrade_type );
    self.var_8bd50ab544e66903 = undefined;
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x15826181, Offset: 0x1703
// Size: 0x69
function private shoot_hand_cannon( target, upgrade_type )
{
    level endon( #"game_ended" );
    show_samurai_ghost( "shoot_cannon", upgrade_type, "samurai_cannon" );
    self.var_8bd50ab544e66903 = 1;
    waitframe();
    function_5a48a73ee2c4ab48( target, "cannon", upgrade_type );
    wait 1.2;
    hide_samurai_ghost( upgrade_type );
    self.var_8bd50ab544e66903 = undefined;
}

// Namespace zm_sat_hornet_murder_holes
// Params 3, eflags: 0x4
// Checksum 0x258e4db6, Offset: 0x1774
// Size: 0x308
function private function_5a48a73ee2c4ab48( target, projectile_type = "rifle", upgrade_type )
{
    destination = target.origin;
    
    if ( projectile_type == "rifle" && !target._blackboard.var_6391b373c0f57a6d )
    {
        random_height_offset = ( 0, 0, 50 ) * randomfloatrange( 0.75, 1.25 );
        destination += random_height_offset;
    }
    
    proj_weapon = makeweapon( utility::get_scripted_weapon_name( hashcat( #"hash_a08196c5f0fc90b5", projectile_type ) ) );
    proj_origin = utility::getstruct( self.targetname + "_" + self.script_parameters ).origin;
    projectile = weapon_utility::_magicbullet( proj_weapon, proj_origin, destination );
    forward = destination - proj_origin;
    right = vectornormalize( vectorcross( ( 0, 0, 1 ), forward ) );
    playfx( utility::getfx( "vfx_sat_hornet_murder_holes_ghostly_rifle_muzzle_flash" ), proj_origin, right );
    projectile.targetname = "trap_attacker";
    projectile.activator = self.trap_root.activator;
    projectile.attack_entity = self.trap_root.trap_scriptable.attack_entity;
    projectile.attack_entity.var_a51015bf03dd4089 = 1;
    projectile.attack_entity.trap_root = self.trap_root;
    wait 0.15;
    var_f1986aa4f7ed9c7f = projectile.origin;
    round_difficulty = zm_utility::get_round_number();
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    damage_target_zombie( target, projectile, zombie_base_health );
    
    if ( projectile_type == "cannon" )
    {
        if ( upgrade_type == "red_ug_mh" )
        {
            blast_fx = utility::spawn_model( %"hash_32f3a56db0eb308c", var_f1986aa4f7ed9c7f, ( 0, 0, 0 ) );
            blast_fx setscriptablepartstate( "impact_floor", "red" );
            blast_fx utility::delaycall( 3, &delete );
            thread function_ee010dc95b3a3127( var_f1986aa4f7ed9c7f, zombie_base_health, 250, 1, 0.5 );
        }
        else if ( upgrade_type == "yellow_ug_mh" )
        {
            blast_fx = utility::spawn_model( %"hash_32f3a56db0eb308c", var_f1986aa4f7ed9c7f, ( 0, 0, 0 ) );
            blast_fx setscriptablepartstate( "impact_floor", "yellow" );
            blast_fx utility::delaycall( 5.5, &delete );
            function_d1db4121c9d73fe5( projectile );
        }
        else
        {
            thread function_ee010dc95b3a3127( var_f1986aa4f7ed9c7f, zombie_base_health );
        }
        
        return;
    }
    
    if ( upgrade_type == "green_ug_mh" )
    {
        function_4569c5dd9ac763e0( target );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 3, eflags: 0x4
// Checksum 0x6f00fae0, Offset: 0x1a84
// Size: 0x1b0
function private damage_target_zombie( zombie, projectile, zombie_base_health )
{
    if ( !isalive( zombie ) )
    {
        return;
    }
    
    if ( zombie.aicategory == "hvt" )
    {
        damage_scalar = 0.1;
        zombie dodamage( int( zombie_base_health * damage_scalar ), zombie.origin, projectile.attack_entity, projectile.attack_entity, "MOD_PROJECTILE", "<explicitweaponnone>", "none", undefined, 1073741824 );
    }
    
    if ( zombie.aicategory == "elite" )
    {
        damage_scalar = 0.1;
        zombie dodamage( int( zombie_base_health * damage_scalar ), zombie.origin, projectile.attack_entity, projectile.attack_entity, "MOD_PROJECTILE", "<explicitweaponnone>", "none", undefined, 1073741824 );
        return;
    }
    
    if ( zombie.aicategory == "special" )
    {
        damage_scalar = 0.25;
        zombie dodamage( int( zombie_base_health * damage_scalar ), zombie.origin, projectile.attack_entity, projectile.attack_entity, "MOD_PROJECTILE", "<explicitweaponnone>", "none", undefined, 1073741824 );
        return;
    }
    
    if ( zombie.aicategory == "normal" )
    {
        zombie dodamage( int( zombie_base_health ), zombie.origin, projectile.attack_entity, projectile.attack_entity, "MOD_PROJECTILE", "<explicitweaponnone>", "none", undefined, 1073741824 );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 5, eflags: 0x4
// Checksum 0x5a4a9b59, Offset: 0x1c3c
// Size: 0xb3
function private function_ee010dc95b3a3127( var_f1986aa4f7ed9c7f, zombie_base_health, cannon_blast_radius = 150, var_58ef58c46b24f5c6 = 0.5, var_bfd52c62496efc50 = 0.25 )
{
    level endon( #"game_ended" );
    player = self.trap_root.activator ?? level.players[ 0 ];
    
    if ( isdefined( player ) )
    {
        player radiusdamage( var_f1986aa4f7ed9c7f, cannon_blast_radius, var_58ef58c46b24f5c6 * zombie_base_health, var_bfd52c62496efc50 * zombie_base_health );
        wait 0.3;
        zm_utility::function_1d82e63812f9640a( var_f1986aa4f7ed9c7f, 300 );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1
// Checksum 0xe46cfa89, Offset: 0x1cf7
// Size: 0x8b
function function_b0f916cb11863d33( sparams )
{
    if ( sparams.eattacker.var_a51015bf03dd4089 )
    {
        if ( isdefined( sparams.eattacker.trap_root ) )
        {
            sparams.eattacker.trap_root notify( #"hash_9dcf89f0e929dea6" );
        }
        
        self.var_a13bed1ac47e1b2c = 1;
        self.no_powerups = 1;
        utility::ent_flag_set( "murder_trap_kill" );
        utility::ent_flag_set( "dissolve_blue_burn" );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 3, eflags: 0x4
// Checksum 0x674c2615, Offset: 0x1d8a
// Size: 0x1bd
function private show_samurai_ghost( var_80bc4c5327a02249 = "shoot_rifle", upgrade_type = "none", model_state = "samurai" )
{
    self setscriptablepartstate( "model", model_state );
    self setscriptablepartstate( "fx", "none" );
    self setscriptablepartstate( "anims", var_80bc4c5327a02249 );
    
    switch ( upgrade_type )
    {
        case #"hash_95de77bd9ef1f27f":
            self setscriptablepartstate( "upgrade", "red" );
            self setscriptablepartstate( "spawn", "red" );
            utility::delaythread( 0.266667, &utility::function_32b24db3127bff40, "upgrade", "none" );
            break;
        case #"hash_c83704da3472455f":
            self setscriptablepartstate( "upgrade", "green" );
            self setscriptablepartstate( "spawn", "green" );
            utility::delaythread( 0.266667, &utility::function_32b24db3127bff40, "upgrade", "none" );
            break;
        case #"hash_577cc846df74818e":
            self setscriptablepartstate( "upgrade", "yellow" );
            self setscriptablepartstate( "spawn", "yellow" );
            utility::delaythread( 0.266667, &utility::function_32b24db3127bff40, "upgrade", "none" );
            break;
        case #"hash_89ad2801d88826a5":
            self setscriptablepartstate( "upgrade", "white" );
            self setscriptablepartstate( "spawn", "white" );
            utility::delaythread( 0.266667, &utility::function_32b24db3127bff40, "upgrade", "none" );
            break;
        default:
            self setscriptablepartstate( "spawn", "default" );
            break;
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x273f4e91, Offset: 0x1f4f
// Size: 0x127
function private hide_samurai_ghost( upgrade_type = "none" )
{
    self setscriptablepartstate( "anims", "none" );
    self setscriptablepartstate( "model", "invisible" );
    utility::function_32b24db3127bff40( "upgrade", "none" );
    
    switch ( upgrade_type )
    {
        case #"hash_95de77bd9ef1f27f":
            self setscriptablepartstate( "despawn", "red" );
            break;
        case #"hash_c83704da3472455f":
            self setscriptablepartstate( "despawn", "green" );
            break;
        case #"hash_577cc846df74818e":
            self setscriptablepartstate( "despawn", "yellow" );
            break;
        case #"hash_89ad2801d88826a5":
            self setscriptablepartstate( "despawn", "white" );
            break;
        default:
            self setscriptablepartstate( "despawn", "default" );
            break;
    }
    
    if ( self.trap_root.var_711e3c9a288e87ff )
    {
        self setscriptablepartstate( "fx", "ready" );
        return;
    }
    
    self setscriptablepartstate( "fx", "none" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x156bf35f, Offset: 0x207e
// Size: 0x6c
function private set_projectile_appearance( projectile_type = "rifle" )
{
    switch ( projectile_type )
    {
        case #"hash_badf8f8f263b2b7c":
            self setscriptablepartstate( "visual", "blue_large" );
            break;
        case #"hash_8cdaf2e4ecfe5b51":
        default:
            self setscriptablepartstate( "visual", "blue_small" );
            break;
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x8af726a6, Offset: 0x20f2
// Size: 0x105
function private set_projectile_impact( projectile_type = "rifle", upgrade_type )
{
    type_to_use = upgrade_type ?? projectile_type;
    
    switch ( type_to_use )
    {
        case #"hash_95de77bd9ef1f27f":
            self setscriptablepartstate( "impact_floor", "red" );
            break;
        case #"hash_577cc846df74818e":
            self setscriptablepartstate( "impact_floor", "yellow" );
            break;
        case #"hash_e32d2a49d1ac024c":
            self setscriptablepartstate( "impact_body", "blue_large" );
            break;
        case #"hash_badf8f8f263b2b7c":
            self setscriptablepartstate( "visual", "invisible" );
            self setscriptablepartstate( "impact_floor", "200_unit_field_blue" );
            break;
        case #"hash_8cdaf2e4ecfe5b51":
        default:
            self setscriptablepartstate( "visual", "invisible" );
            self setscriptablepartstate( "impact_body", "blue_large" );
            break;
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 4, eflags: 0x4
// Checksum 0xa38f6255, Offset: 0x21ff
// Size: 0xca
function private function_d800e5849992e281( trap, part, state, var_8760471bc0ebe87b = 0 )
{
    foreach ( ghost in trap.a_ghosts )
    {
        if ( var_8760471bc0ebe87b )
        {
            if ( !ghost.var_8bd50ab544e66903 )
            {
                ghost setscriptablepartstate( part, state );
            }
            
            continue;
        }
        
        ghost setscriptablepartstate( part, state );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 3, eflags: 0x4
// Checksum 0xe941cf06, Offset: 0x22d1
// Size: 0xe2
function private function_73d62b7ad489e020( trap, part, state )
{
    foreach ( komainu in trap.a_komainu )
    {
        if ( !komainu.var_33cd52a70a6e7b2b || !arraycontains( [ "ready", "cooldown", "activate" ], state ) )
        {
            komainu setscriptablepartstate( part, state );
            continue;
        }
        
        komainu setscriptablepartstate( part, state + "_alt" );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x9b4fc163, Offset: 0x23bb
// Size: 0x141
function private function_53e8f28ae292bd06( part_override, var_f6739410fed19ecc )
{
    part = part_override ?? "model";
    state = var_f6739410fed19ecc ?? "samurai";
    
    foreach ( trap_root in level.murder_holes_root.var_2747e0528b1f176 )
    {
        foreach ( ghost in trap_root.a_ghosts )
        {
            if ( ghost.var_df00f5fbf4a6d195 )
            {
                continue;
            }
            
            ghost setscriptablepartstate( part, state );
        }
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x80cc8078, Offset: 0x2504
// Size: 0xc2
function private function_156db6bb06d3e3e6( part_override, var_f6739410fed19ecc )
{
    part = part_override ?? "fx";
    state = var_f6739410fed19ecc ?? "red";
    
    foreach ( trap_root in level.murder_holes_root.var_2747e0528b1f176 )
    {
        function_73d62b7ad489e020( trap_root, part, state );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xe50b638f, Offset: 0x25ce
// Size: 0xae
function private function_f00c0f833e8147fc( params )
{
    if ( !isdefined( params.eattacker.activator ) )
    {
        return;
    }
    
    activator = params.eattacker.activator;
    
    if ( activator utility::ent_flag( "hornet_murder_hole_first_kill" ) )
    {
        return;
    }
    
    level callback::remove( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
    activator utility::ent_flag_set( "hornet_murder_hole_first_kill" );
    var_db75d3de862ce072 = activator namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hornet_murder_hole_first_kill" );
    
    if ( !var_db75d3de862ce072 && activator )
    {
        activator utility::ent_flag_clear( "hornet_murder_hole_first_kill" );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1
// Checksum 0xb4b147d5, Offset: 0x2684
// Size: 0x21e
function function_58f46e59c7861579( s_trap_root )
{
    level endon( #"hash_a95f820df4cd73d1" );
    level utility::flag_set( "upg_rou_ac" );
    var_8ad52ccf3dd98ecb = get_available_upgrades( s_trap_root );
    a_slots = function_849ed3a54a5232dc( s_trap_root, var_8ad52ccf3dd98ecb );
    a_roulette = [];
    circle_center = s_trap_root.s_upgrade.origin + ( 0, 0, 48 );
    slot = { #angles:s_trap_root.s_upgrade.angles, #origin:circle_center + ( 0, 0, 24 ) };
    s_trap_root.a_roulette = a_roulette;
    s_trap_root.circle_center = circle_center;
    
    foreach ( upgrade in var_8ad52ccf3dd98ecb )
    {
        sbl = spawnscriptable( %"hash_38d4c60a959f6166", slot.origin, slot.angles );
        sbl setscriptablepartstate( "wisp", upgrade.part );
        sbl.mover = utility::spawn_model( %"tag_origin", slot.origin, slot.angles );
        sbl scriptablesetparententity( sbl.mover );
        a_roulette[ a_roulette.size ] = sbl;
        level thread loop_circle( sbl.mover, circle_center, slot );
        wait 3.6 / a_slots.size;
    }
    
    interact = interaction::register_interact( circle_center, 64, &function_c82f84ada372cb5e );
    interact.s_trap_root = s_trap_root;
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xf0ad2586, Offset: 0x28aa
// Size: 0x30
function private function_41a74dff46155b5c( s_trap_root )
{
    level endon( #"hash_a95f820df4cd73d1" );
    level endon( #"hash_728df321137ade0f" );
    wait 60;
    function_c65445b5e2a217fa( s_trap_root );
}

// Namespace zm_sat_hornet_murder_holes
// Params 3, eflags: 0x4
// Checksum 0x1459cd95, Offset: 0x28e2
// Size: 0x99
function private loop_circle( mover, circle_center, slot )
{
    level endon( #"hash_a95f820df4cd73d1" );
    mover endon( #"interrupt_circle_move" );
    axis = anglestoaxis( slot.angles );
    angles = axistoangles( axis[ "up" ] * -1, axis[ "right" ], axis[ "forward" ] );
    
    while ( true )
    {
        mover utility::follow_circle( 24, 3.6, circle_center, 1, angles, undefined, undefined, 0 );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x6d10aac6, Offset: 0x2983
// Size: 0xa1
function private function_c65445b5e2a217fa( s_trap_root )
{
    foreach ( sbl in s_trap_root.a_roulette )
    {
        sbl.mover delete();
        sbl freescriptable();
    }
    
    level notify( #"hash_a95f820df4cd73d1" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x89856cfd, Offset: 0x2a2c
// Size: 0x143
function private get_available_upgrades( s_trap_root )
{
    available_upgrades = [];
    
    if ( !s_trap_root utility::ent_flag( "red_ug_mh" ) && !level utility::flag( "red_ug_mh" ) )
    {
        s_upgrade = { #part:"on_wrath", #flag:"red_ug_mh" };
        available_upgrades[ available_upgrades.size ] = s_upgrade;
    }
    
    if ( !s_trap_root utility::ent_flag( "green_ug_mh" ) && !level utility::flag( "green_ug_mh" ) )
    {
        s_upgrade = { #part:"on_benevolence", #flag:"green_ug_mh" };
        available_upgrades[ available_upgrades.size ] = s_upgrade;
    }
    
    if ( !s_trap_root utility::ent_flag( "yellow_ug_mh" ) && !level utility::flag( "yellow_ug_mh" ) )
    {
        s_upgrade = { #part:"on_distraction", #flag:"yellow_ug_mh" };
        available_upgrades[ available_upgrades.size ] = s_upgrade;
    }
    
    if ( !s_trap_root utility::ent_flag( "white_ug_mh" ) && !level utility::flag( "white_ug_mh" ) )
    {
        s_upgrade = { #part:"on_salvation", #flag:"white_ug_mh" };
        available_upgrades[ available_upgrades.size ] = s_upgrade;
    }
    
    return available_upgrades;
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x573efe2d, Offset: 0x2b78
// Size: 0x344
function private function_849ed3a54a5232dc( s_trap_root, var_8ad52ccf3dd98ecb )
{
    a_slots = [];
    s_upgrade_anchor = s_trap_root.s_upgrade;
    
    if ( var_8ad52ccf3dd98ecb.size == 4 )
    {
        right = anglestoright( s_upgrade_anchor.angles );
        var_8319370398647ba = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 72 ) };
        var_831927039864587 = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 24 ) };
        slot_3 = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 48 ) + right * 24 };
        slot_4 = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 48 ) - right * 24 };
        a_slots = [ var_8319370398647ba, var_831927039864587, slot_3, slot_4 ];
    }
    else if ( var_8ad52ccf3dd98ecb.size == 3 )
    {
        right = anglestoright( s_upgrade_anchor.angles );
        var_8319370398647ba = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 72 ) };
        var_831927039864587 = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 24 ) };
        slot_3 = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 48 ) + right * 24 };
        a_slots = [ var_8319370398647ba, var_831927039864587, slot_3 ];
    }
    else if ( var_8ad52ccf3dd98ecb.size == 2 )
    {
        var_8319370398647ba = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 72 ) };
        var_831927039864587 = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 24 ) };
        a_slots = [ var_8319370398647ba, var_831927039864587 ];
    }
    else if ( var_8ad52ccf3dd98ecb.size == 1 )
    {
        var_8319370398647ba = { #angles:s_upgrade_anchor.angles, #origin:s_upgrade_anchor.origin + ( 0, 0, 72 ) };
        a_slots = [ var_8319370398647ba ];
    }
    
    return a_slots;
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x17a51155, Offset: 0x2ec5
// Size: 0x88
function private function_c82f84ada372cb5e( player )
{
    if ( player currency::attempt_purchase( #"essence", 500, 1, 0, #"mh_upgrade" ) )
    {
        level notify( #"hash_728df321137ade0f" );
        self makeunusable();
        function_7b17a73a04475dfa( self.s_trap_root );
        level utility::flag_clear( "upg_rou_ac" );
        player thread utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_87e01be9659e3568", #"hash_cfd61d3a394ba4eb" );
        self delete();
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xb5e442, Offset: 0x2f55
// Size: 0x67
function private function_84d44cc985ea1bb6( player )
{
    if ( player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x54f318da, Offset: 0x2fc5
// Size: 0x48b
function private function_7b17a73a04475dfa( s_trap_root )
{
    if ( s_trap_root.a_roulette.size <= 0 )
    {
        return;
    }
    
    a_upgrades = get_available_upgrades( s_trap_root );
    
    if ( !level.murder_holes_root.var_e725bf9b59413d89 )
    {
        level.murder_holes_root.var_e725bf9b59413d89 = 1;
        
        foreach ( upg in a_upgrades )
        {
            if ( upg.flag == "yellow_ug_mh" )
            {
                upgrade = upg;
                break;
            }
        }
    }
    
    if ( !isdefined( upgrade ) )
    {
        upgrade = utility::array_random( a_upgrades );
    }
    
    wait_to_center = 1;
    var_bafcb39fafba70ad = 2;
    var_96e555ed5cbd3e59 = 1;
    var_bbd9050af7fb557a = 0.5;
    
    foreach ( sbl in s_trap_root.a_roulette )
    {
        sbl.mover notify( #"interrupt_circle_move" );
        sbl.mover moveto( s_trap_root.circle_center, wait_to_center, wait_to_center / 2, 0 );
    }
    
    first_sbl = s_trap_root.a_roulette[ 0 ];
    wait wait_to_center;
    
    for ( i = 1; i < s_trap_root.a_roulette.size ; i++ )
    {
        s_trap_root.a_roulette[ i ].mover delete();
        s_trap_root.a_roulette[ i ] freescriptable();
    }
    
    first_sbl setscriptablepartstate( "wisp", upgrade.part );
    s_trap_root utility::ent_flag_set( upgrade.flag );
    level utility::flag_set( upgrade.flag );
    wait var_bafcb39fafba70ad;
    var_895f080430649abe = averagepoint( [ s_trap_root.a_komainu[ 0 ].origin, s_trap_root.a_komainu[ 1 ].origin ] );
    height_offset = ( 0, 0, 160 );
    control_pos = averagepoint( [ var_895f080430649abe, first_sbl.mover.origin ] ) + height_offset;
    first_sbl.mover utility::function_8001268940441423( first_sbl.mover.origin, var_895f080430649abe + height_offset, control_pos, var_96e555ed5cbd3e59, 1, 1 );
    function_2af5710ce1d94e67( upgrade.flag, first_sbl.mover.origin );
    dupe_sbl = spawnscriptable( %"hash_38d4c60a959f6166", first_sbl.mover.origin, first_sbl.mover.angles );
    dupe_sbl setscriptablepartstate( "wisp", upgrade.part );
    dupe_sbl.mover = utility::spawn_model( %"tag_origin", first_sbl.mover.origin, first_sbl.mover.angles );
    dupe_sbl scriptablesetparententity( dupe_sbl.mover );
    level thread function_8e852ae64798bc96( first_sbl, s_trap_root.a_komainu[ 0 ].origin + ( 0, 0, 42 ), var_bbd9050af7fb557a );
    level thread function_8e852ae64798bc96( dupe_sbl, s_trap_root.a_komainu[ 1 ].origin + ( 0, 0, 42 ), var_bbd9050af7fb557a );
    level notify( #"hash_a95f820df4cd73d1" );
}

// Namespace zm_sat_hornet_murder_holes
// Params 3, eflags: 0x4
// Checksum 0xeac96165, Offset: 0x3458
// Size: 0xa0
function private function_8e852ae64798bc96( sbl, end_pos, var_bbd9050af7fb557a )
{
    control_pos = averagepoint( [ sbl.mover.origin, end_pos ] ) + ( 0, 0, 60 );
    sbl.mover utility::function_8001268940441423( sbl.mover.origin, end_pos, control_pos, var_bbd9050af7fb557a, 1 );
    sbl.mover delete();
    sbl freescriptable();
}

// Namespace zm_sat_hornet_murder_holes
// Params 2, eflags: 0x4
// Checksum 0x8c7a05b1, Offset: 0x3500
// Size: 0xe3
function private function_2af5710ce1d94e67( upgrade_flag, pos )
{
    switch ( upgrade_flag )
    {
        case #"hash_577cc846df74818e":
            bundle_name = %"hash_4117299d22d8fe59";
            n_count = 4;
            break;
        case #"hash_89ad2801d88826a5":
            bundle_name = %"hash_428e5b0816d1da5f";
            n_count = 1;
            break;
        case #"hash_c83704da3472455f":
            bundle_name = %"hash_b7cc87910d43670";
            n_count = 4;
            break;
        case #"hash_95de77bd9ef1f27f":
            bundle_name = %"hash_7190196ea689f540";
            n_count = 4;
            break;
        default:
            return;
    }
    
    itembundle = getscriptbundle( bundle_name );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( pos );
    common_item::function_61c2c0251e742ffd( itembundle, n_count, spawnoptions );
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0xcad3c76, Offset: 0x35eb
// Size: 0x1b6
function private function_4569c5dd9ac763e0( target )
{
    player = self.trap_root.activator ?? level.players[ 0 ];
    
    for ( i = 0; i < 3 ; i++ )
    {
        target lightray::function_1ffa747c8a87b592( undefined, player, "MOD_ELEMENTAL_LIGHT", "<explicitweaponnone>", undefined, undefined, undefined, undefined, 1 );
    }
    
    if ( level.ar_root.current_target && isarray( level.ar_root.current_target ) && getxhashasset( level.ar_root.current_target[ 0 ].type ) == %"zm_sat_hornet_komainu" )
    {
        var_7306b73201c61041 = int( level.ar_root.current_max_health * 0.17 );
        level.ar_root.current_target_health += var_7306b73201c61041;
        
        if ( level.ar_root.current_target_health > level.ar_root.current_max_health )
        {
            level.ar_root.current_target_health = level.ar_root.current_max_health;
        }
        
        s_trap_root = level.ar_root.var_2747e0528b1f176[ level.ar_root.current_sector ];
        function_73d62b7ad489e020( s_trap_root, "upgrade", "heal" );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x877b07dd, Offset: 0x37a9
// Size: 0x31
function private function_d1db4121c9d73fe5( projectile )
{
    attractor = zombie_attractor_manager::add_attractor( projectile, 2, 175, 0 );
    wait 5;
    zombie_attractor_manager::remove_attractor( attractor );
}

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0x8a9a49a9, Offset: 0x37e2
// Size: 0xa3
function private function_435e50542cd532e2()
{
    s_trap_root = self.trap_root;
    function_73d62b7ad489e020( s_trap_root, "upgrade", "slow" );
    
    foreach ( komainu in s_trap_root.a_komainu )
    {
        thread function_d127a553e16a02c7( komainu );
    }
}

// Namespace zm_sat_hornet_murder_holes
// Params 1, eflags: 0x4
// Checksum 0x9d79dc4f, Offset: 0x388d
// Size: 0xfb
function private function_d127a553e16a02c7( komainu )
{
    end_time = gettime() + 10000;
    
    while ( gettime() < end_time )
    {
        var_255232a5c5895cf6 = getaiarrayinradius( komainu.origin, 150, zm_utility::get_zombie_team() );
        
        foreach ( zombie in var_255232a5c5895cf6 )
        {
            if ( zombie.aicategory == "normal" && !zombie effect_slow::function_c1be3c9f2d0b92d2( "mh_fox" ) )
            {
                zombie effect_slow::slow( "mh_fox", 0.5, 0.55, komainu );
            }
        }
        
        wait 0.5;
    }
}

/#

    // Namespace zm_sat_hornet_murder_holes
    // Params 0, eflags: 0x4
    // Checksum 0xecfdf9d3, Offset: 0x3990
    // Size: 0x288, Type: dev
    function private function_d31b66456569393a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x44>", "<dev string:x61>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x82>", "<dev string:xa3>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc2>", "<dev string:xe4>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10a>", "<dev string:x122>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x144>", "<dev string:x159>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x172>", "<dev string:x187>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a1>", "<dev string:x1b6>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1cf>", "<dev string:x1e8>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x205>", "<dev string:x21c>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x239>", "<dev string:x24e>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x26d>", "<dev string:x284>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a3>", "<dev string:x2bb>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2db>", "<dev string:x2f3>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x316>", "<dev string:x32f>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x353>", "<dev string:x36e>", &function_c18571250aff5725, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x394>", "<dev string:x3a1>", &function_1e5457aa36e496c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3bc>", "<dev string:x3cb>", &function_1e5457aa36e496c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3e3>", "<dev string:x3f3>", &function_1e5457aa36e496c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x40e>", "<dev string:x420>", &function_1e5457aa36e496c5, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x439>", "<dev string:x447>", &function_b345d101e5778f21, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x451>", "<dev string:x461>", &function_b345d101e5778f21, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x46d>", "<dev string:x47e>", &function_b345d101e5778f21, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x48b>", "<dev string:x49b>", &function_b345d101e5778f21, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a7>", "<dev string:x4b9>", &function_b345d101e5778f21, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4c3>", "<dev string:x4d8>", &function_b345d101e5778f21, 1 );
        devgui::add_devgui_func( "<dev string:x4e5>", "<dev string:x4f3>", &debug_show_roulette, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_murder_holes
    // Params 1, eflags: 0x4
    // Checksum 0x59073ee4, Offset: 0x3c20
    // Size: 0x4b, Type: dev
    function private function_c18571250aff5725( params )
    {
        if ( !( isdefined( params[ 0 ] ) && isdefined( params[ 1 ] ) ) )
        {
            return;
        }
        
        function_53e8f28ae292bd06( params[ 0 ], params[ 1 ] );
        
        if ( params[ 0 ] == "<dev string:x4ff>" )
        {
            function_53e8f28ae292bd06( "<dev string:x505>", "<dev string:x50b>" );
        }
    }

    // Namespace zm_sat_hornet_murder_holes
    // Params 1, eflags: 0x4
    // Checksum 0xf31f8769, Offset: 0x3c73
    // Size: 0x2e, Type: dev
    function private function_1e5457aa36e496c5( params )
    {
        if ( !( isdefined( params[ 0 ] ) && isdefined( params[ 1 ] ) ) )
        {
            return;
        }
        
        function_156db6bb06d3e3e6( params[ 0 ], params[ 1 ] );
    }

    // Namespace zm_sat_hornet_murder_holes
    // Params 1, eflags: 0x4
    // Checksum 0xa374b57, Offset: 0x3ca9
    // Size: 0xd1, Type: dev
    function private function_b345d101e5778f21( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        if ( params[ 0 ] == "<dev string:x510>" )
        {
            level utility::flag_set( "<dev string:x514>" );
            level utility::flag_set( "<dev string:x51e>" );
            level utility::flag_set( "<dev string:x52a>" );
            level utility::flag_set( "<dev string:x537>" );
            iprintlnbold( "<dev string:x543>" );
            return;
        }
        
        if ( params[ 0 ] == "<dev string:x54f>" )
        {
            level utility::flag_clear( "<dev string:x514>" );
            level utility::flag_clear( "<dev string:x51e>" );
            level utility::flag_clear( "<dev string:x52a>" );
            level utility::flag_clear( "<dev string:x537>" );
            iprintlnbold( "<dev string:x556>" );
            return;
        }
        
        level utility::flag_set( params[ 0 ] + "<dev string:x566>" );
        iprintlnbold( "<dev string:x56d>" + params[ 0 ] );
    }

    // Namespace zm_sat_hornet_murder_holes
    // Params 0, eflags: 0x4
    // Checksum 0xe0d22ae1, Offset: 0x3d82
    // Size: 0x89, Type: dev
    function private debug_show_roulette()
    {
        foreach ( s_trap_root in level.murder_holes_root.var_2747e0528b1f176 )
        {
            level thread function_58f46e59c7861579( s_trap_root );
        }
    }

#/

// Namespace zm_sat_hornet_murder_holes
// Params 0, eflags: 0x4
// Checksum 0x88e6833, Offset: 0x3e13
// Size: 0x43
function private function_24c840e3dfa09439()
{
    level utility::flag_set( "red_ug_mh" );
    level utility::flag_set( "green_ug_mh" );
    level utility::flag_set( "yellow_ug_mh" );
    level utility::flag_set( "white_ug_mh" );
    
    /#
        iprintlnbold( "<dev string:x577>" );
    #/
}

