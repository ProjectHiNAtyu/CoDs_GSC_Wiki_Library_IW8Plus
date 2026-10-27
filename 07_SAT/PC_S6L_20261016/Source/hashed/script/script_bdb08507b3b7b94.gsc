// script_bdb08507b3b7b94  (hash_0bdb08507b3b7b94.gscc) (size: 9052 Bytes / 0x235c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb74ef3b4 (3075404724)
// size ...... 9052 (0x235c)
// includes .. 9   (offset: 0x220c)
// strings ... 15  (offset: 0x2254)
// dev strs .. 5   (offset: 0x2320)
// exports ... 46  (offset: 0x10fc)
// cseg ...... 0x142 + 0xfba (0x10fc)
// imports ... 86  (offset: 0x182c)
// animtree1 . 0   (offset: 0x235c)
// animtree2 . 0   (offset: 0x235c)
#using script_255dce8c98970600;
#using script_437ee0f94301721b;
#using script_4ca4034d0b68a7d4;
#using script_590ec01abe3be472;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace namespace_bdf7104c266ba81d;

// Namespace namespace_bdf7104c266ba81d
// Params 2
// Checksum 0x3e022024, Offset: 0x160
// Size: 0x159
function precache( classname, aitypescriptbundle )
{
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_6a335156d7ce17de", &get_ai_settings );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_5e9d38d65da2a1ec", &set_angles );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_cf5e8e8e6e14ef36", &function_30c419a777fc68f5 );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_2daf129ccc22b321", &look_at_position );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_fddaede65cd5e4f5", &get_look_at_position );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_886d275d9bbb29e3", &set_phase );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_bb468dfe138a9a08", &start_combat );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_2bd94f81341013ca", &stop_combat );
    utility::registersharedfunc( #"hash_1f3f4d6111d1e480", #"hash_d5432c97d3e46ec7", &set_changing_phase );
    level.var_9cb55ba04e53a943 = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    zombie_uranus_beam::function_2b091127547f62bc( aitypescriptbundle );
    zombie_uranus_fireball::function_2b091127547f62bc( aitypescriptbundle );
    zombie_uranus_toxic_mouth::function_2b091127547f62bc( aitypescriptbundle );
    
    /#
        devgui_init();
    #/
}

// Namespace namespace_bdf7104c266ba81d
// Params 2
// Checksum 0x186f5d95, Offset: 0x2c1
// Size: 0x39
function register_can_use_skill( skillname, can_use_func )
{
    if ( !isdefined( self.var_412218cca73a933 ) )
    {
        self.var_412218cca73a933 = [];
    }
    
    self.var_412218cca73a933[ skillname ] = can_use_func;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xe1bcbb61, Offset: 0x302
// Size: 0x6d, Type: bool
function function_420be0b5922e064b()
{
    if ( !is_in_combat() )
    {
        return false;
    }
    
    if ( is_pain() )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "uranus_bb_interrupted" ) )
    {
        return false;
    }
    
    if ( !self.enemy )
    {
        return false;
    }
    
    if ( has_cool_down( #"hash_61ccd92bbf0ca313" ) )
    {
        return false;
    }
    
    if ( !is_target_in_range( self.enemy ) )
    {
        return false;
    }
    
    if ( has_action() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xe202dd7a, Offset: 0x378
// Size: 0xa3
function select_skill()
{
    skills = [];
    
    foreach ( skillname, canusefunc in self.var_412218cca73a933 )
    {
        if ( canusefunc && [[ canusefunc ]]() )
        {
            skills[ skills.size ] = skillname;
        }
    }
    
    if ( skills.size > 0 )
    {
        return skills[ randomint( skills.size ) ];
    }
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xebb56a5d, Offset: 0x423
// Size: 0x31
function do_action( var_469072f93ecbd83b )
{
    if ( !isdefined( self.uranusactions ) )
    {
        self.uranusactions = [];
    }
    
    self.uranusactions[ var_469072f93ecbd83b ] = 1;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xa159cce5, Offset: 0x45c
// Size: 0x39
function end_action( var_469072f93ecbd83b )
{
    if ( !self.uranusactions )
    {
        return;
    }
    
    if ( !var_469072f93ecbd83b )
    {
        self.uranusactions = [];
        return;
    }
    
    self.uranusactions[ var_469072f93ecbd83b ] = undefined;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xfd60b0bf, Offset: 0x49d
// Size: 0x39
function has_action( var_469072f93ecbd83b )
{
    if ( !self.uranusactions )
    {
        return 0;
    }
    
    if ( var_469072f93ecbd83b )
    {
        return self.uranusactions[ var_469072f93ecbd83b ];
    }
    
    return self.uranusactions.size > 0;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xc05ce1c9, Offset: 0x4df
// Size: 0xc
function is_pain()
{
    return self getaiblackboarddynamic( "in_pain" );
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xeef810e, Offset: 0x4f4
// Size: 0x9
function start_pain()
{
    zombie_uranus_asm::start_pain();
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xeef810e, Offset: 0x505
// Size: 0x9
function end_pain()
{
    zombie_uranus_asm::end_pain();
}

// Namespace namespace_bdf7104c266ba81d
// Params 1, eflags: 0x4
// Checksum 0xa5502ddb, Offset: 0x516
// Size: 0x4d
function private function_36ce05ba4258918d( params )
{
    aitemplate = callback::get_template( self.animsetname );
    aitemplate callback::add( "killed_body_cloned", &play_death_fx );
    aitemplate callback::add( "pre_killed_body_cloned", &function_73eff2eee7117423 );
}

// Namespace namespace_bdf7104c266ba81d
// Params 1, eflags: 0x4
// Checksum 0x89ad45bf, Offset: 0x56b
// Size: 0x40
function private function_c119b6e4529ffac3( params )
{
    self notify( #"hash_884a073605b83475" );
    thread interrupted();
    start_cool_down( #"hash_61ccd92bbf0ca313" );
    utility::function_32b24db3127bff40( "base", "damaged" );
}

// Namespace namespace_bdf7104c266ba81d
// Params 0, eflags: 0xc
// Checksum 0xe6c2649c, Offset: 0x5b3
// Size: 0x78
function private interrupted()
{
    self notify( #"hash_ca811731205ad8e2" );
    self endon( #"hash_ca811731205ad8e2" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"uranus_interrupted" );
    self.interrupted = 1;
    self function_786bb6aa1b76c7ee( "uranus_bb_interrupted", 1 );
    wait 1;
    self function_f2df0257c63f229( "uranus_bb_interrupted" );
    self.interrupted = 0;
    self.uranusactions = [];
}

// Namespace namespace_bdf7104c266ba81d
// Params 1, eflags: 0x4
// Checksum 0xdfe9ef15, Offset: 0x633
// Size: 0xc
function private function_b50cedbec72a36e5( params )
{
    
}

// Namespace namespace_bdf7104c266ba81d
// Params 1, eflags: 0x4
// Checksum 0x2363edbe, Offset: 0x647
// Size: 0x47
function private function_73eff2eee7117423( params )
{
    self.noragdoll = 1;
    self.iscorpsefalling = 0;
    
    if ( self islinked() )
    {
        self unlink();
        self.mover delete();
        self.mover = undefined;
    }
}

// Namespace namespace_bdf7104c266ba81d
// Params 1, eflags: 0x4
// Checksum 0x4099f2e6, Offset: 0x696
// Size: 0x9b
function private play_death_fx( params )
{
    level endon( #"game_ended" );
    
    if ( params.body )
    {
        settings = utility::callsharedfunc( #"hash_1f3f4d6111d1e480", #"hash_6a335156d7ce17de" );
        var_4ed05eb192965f68 = settings.var_705ec00deae0983d;
        
        /#
            var_4ed05eb192965f68 = getdvarfloat( @"hash_1afa4a05c4f43daa", var_4ed05eb192965f68 );
        #/
        
        if ( var_4ed05eb192965f68 > 0 )
        {
            wait var_4ed05eb192965f68;
        }
        
        if ( params.body )
        {
            params.body delete();
        }
    }
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x822e9db0, Offset: 0x739
// Size: 0x3d
function function_30c419a777fc68f5( origin )
{
    if ( isdefined( self.mover ) )
    {
        self.mover.origin = origin;
        return;
    }
    
    self.origin = origin;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xceb94ab1, Offset: 0x77e
// Size: 0x30
function function_63e25df7cfbb206f()
{
    if ( isdefined( self.mover ) )
    {
        return self.mover.angles;
    }
    
    return self.angles;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x822e9db0, Offset: 0x7b6
// Size: 0x3d
function set_angles( angles )
{
    if ( isdefined( self.mover ) )
    {
        self.mover.angles = angles;
        return;
    }
    
    self.angles = angles;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0x43b64771, Offset: 0x7fb
// Size: 0xb
function get_phase()
{
    return self.phase;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x60514bed, Offset: 0x80f
// Size: 0x8d
function set_phase( phase )
{
    if ( self.phase == phase )
    {
        return;
    }
    
    self.phase = phase;
    self function_786bb6aa1b76c7ee( "uranus_bb_phase", phase );
    zombie_uranus_asm::set_phase( phase );
    stop_combat();
    params = { #callback:&function_50f3083d42167c5a, #phase:phase, #ent:self };
    callback::callback( #"hash_7d96b0fd9c6eff63", params );
    end_action();
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xe528346c, Offset: 0x8a4
// Size: 0x17
function set_changing_phase( var_f2b82329d3844800 )
{
    self.changing_phase = var_f2b82329d3844800;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x91d2861a, Offset: 0x8c3
// Size: 0xc
function function_50f3083d42167c5a( params )
{
    
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xd8500395, Offset: 0x8d7
// Size: 0xb
function get_hit_target()
{
    return self.hittarget;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0x1b385fc8, Offset: 0x8eb
// Size: 0xb
function get_ai_settings()
{
    return level.var_9cb55ba04e53a943;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0x7d19de2f, Offset: 0x8ff
// Size: 0x53
function get_look_at_position()
{
    if ( !self.lookatpos )
    {
        angles = function_63e25df7cfbb206f();
        forward = anglestoforward( angles );
        self.lookatpos = self.origin + forward * 8500;
    }
    
    return self.lookatpos;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xde1c4441, Offset: 0x95b
// Size: 0x21
function look_at_position( position )
{
    thread look_at_target_thread( { #origin:position }, 1 );
}

// Namespace namespace_bdf7104c266ba81d
// Params 3
// Checksum 0x91d1848c, Offset: 0x984
// Size: 0x107
function look_at_target_thread( target, rotatespeed, var_2a5fa9b2868542da )
{
    self notify( #"hash_92a0dc5fe63b8389" );
    self endon( #"hash_92a0dc5fe63b8389" );
    level endon( #"game_ended" );
    
    if ( isdefined( var_2a5fa9b2868542da ) )
    {
        self endon( var_2a5fa9b2868542da );
    }
    
    dt = 0;
    lasttime = gettime();
    
    while ( target )
    {
        forward = target.origin - self.origin;
        curangles = function_63e25df7cfbb206f();
        tgtangles = vectortoangles( forward );
        anglediff = angleclamp180( tgtangles - curangles );
        delta = anglediff * rotatespeed * dt;
        set_angles( curangles + delta );
        dt = utility::function_6f5d2e1f1ff70482( gettime() - lasttime );
        lasttime = gettime();
        self.lookatpos = target.origin;
        waitframe();
    }
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0x78ec9de3, Offset: 0xa93
// Size: 0xc
function is_in_combat()
{
    return self getaiblackboarddynamic( "in_combat" );
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xf77a1750, Offset: 0xaa8
// Size: 0xf
function start_combat()
{
    self function_786bb6aa1b76c7ee( "in_combat", 1 );
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0x8585c725, Offset: 0xabf
// Size: 0xe
function stop_combat()
{
    self function_786bb6aa1b76c7ee( "in_combat", 0 );
}

// Namespace namespace_bdf7104c266ba81d
// Params 3
// Checksum 0xcbdfa91, Offset: 0xad5
// Size: 0x1ab
function get_random_targets( radius, targetcount, allow_potential_target = 0 )
{
    if ( !isdefined( radius ) || radius <= 0 )
    {
        radius = 3000;
    }
    
    enemies = self function_f017e352a29a57a1( get_look_at_position(), radius, 1 );
    targets = [];
    potential_targets = [];
    
    foreach ( enemy in enemies )
    {
        if ( can_attack_target( enemy ) )
        {
            targets[ targets.size ] = enemy;
            continue;
        }
        
        if ( allow_potential_target && isalive( enemy ) )
        {
            potential_targets[ potential_targets.size ] = enemy;
        }
    }
    
    if ( !isdefined( targetcount ) )
    {
        targetcount = 1;
    }
    
    var_1e73da4ea0fee70c = min( targetcount, targets.size );
    ret = [];
    
    if ( targets.size > 1 )
    {
        targets = arrayrandomize( targets );
    }
    
    for ( i = 0; i < var_1e73da4ea0fee70c ; i++ )
    {
        ret[ ret.size ] = targets[ i ];
    }
    
    if ( var_1e73da4ea0fee70c < targetcount && potential_targets.size > 0 )
    {
        potentialcount = targetcount - var_1e73da4ea0fee70c;
        
        if ( potential_targets.size > 1 )
        {
            potential_targets = arrayrandomize( potential_targets );
        }
        
        for ( i = 0; i < potentialcount && i < potential_targets.size ; i++ )
        {
            ret[ ret.size ] = potential_targets[ i ];
        }
    }
    
    return ret;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xdd1636e8, Offset: 0xc89
// Size: 0x32, Type: bool
function can_attack_target( target )
{
    return isalive( target ) && !target.inlaststand && !target.ignoreme;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0xa5e9bb3, Offset: 0xcc4
// Size: 0x78
function init_cooldowns()
{
    if ( !isdefined( self.cooldowns ) )
    {
        self.cooldowns = [];
    }
    
    if ( !isdefined( self.cooldown_data ) )
    {
        self.cooldown_data = [];
    }
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    register_cool_down( #"hash_61ccd92bbf0ca313", settings.commoncooldown );
    callback::callback( #"hash_c4941eb17fd35f58" );
}

// Namespace namespace_bdf7104c266ba81d
// Params 2
// Checksum 0x6a78512a, Offset: 0xd44
// Size: 0x28
function register_cool_down( key, seconds )
{
    self.cooldown_data[ key ] = seconds ?? 0;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xe65ceec, Offset: 0xd74
// Size: 0x18
function function_b85fde7cbf122619( key )
{
    return self.cooldown_data[ key ];
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x22e78168, Offset: 0xd95
// Size: 0x75, Type: bool
function has_cool_down( key )
{
    if ( !isdefined( self.cooldown_data[ key ] ) )
    {
        return false;
    }
    
    if ( self.cooldown_data[ key ] <= 0 )
    {
        return false;
    }
    
    if ( isdefined( self.cooldowns[ key ] ) )
    {
        seconds = function_b85fde7cbf122619( key );
        
        if ( gettime() - self.cooldowns[ key ] < seconds * 1000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x3655995f, Offset: 0xe13
// Size: 0x4d
function start_cool_down( key )
{
    if ( !isdefined( self.cooldown_data[ key ] ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( self.cooldown_data[ key ] > 0 )
    {
        self.cooldowns[ key ] = gettime();
    }
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xfe4a2ea8, Offset: 0xe68
// Size: 0x2e, Type: bool
function is_target_in_range( target )
{
    if ( distancesquared( target.origin, get_look_at_position() ) > 9000000 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0x2606a43e, Offset: 0xe9f
// Size: 0x10b
function function_554d03240b1eff2a( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    namespace_7e98bc5e3517bf83::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_36ce05ba4258918d );
    callback::add( #"on_ai_killed", &function_b50cedbec72a36e5 );
    callback::add( #"on_ai_damaged", &function_c119b6e4529ffac3 );
    mover = spawn( "script_model", self.origin );
    self linktoblendtotag( mover );
    self.mover = mover;
    self.hittarget = utility::spawn_model( "tag_origin", self.origin );
    self.hittarget linkto( mover );
    zombie_uranus_beam::init_uranus_beam_attack();
    zombie_uranus_fireball::init_uranus_fireball();
    zombie_uranus_toxic_mouth::init_uranus_toxic_mouth();
    init_cooldowns();
    stop_combat();
    callback::callback( #"uranus_callback_init", {} );
    thread function_680df6e0a4e644c();
    return anim.success;
}

// Namespace namespace_bdf7104c266ba81d
// Params 0
// Checksum 0x2b31ead3, Offset: 0xfb3
// Size: 0x2c
function function_680df6e0a4e644c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    utility::function_32b24db3127bff40( "ambient", "on" );
}

// Namespace namespace_bdf7104c266ba81d
// Params 1
// Checksum 0xb2714342, Offset: 0xfe7
// Size: 0x54
function function_8bdeaa2726d70cd0( taskid )
{
    self function_786bb6aa1b76c7ee( "uranus_bb_selected_skill", "" );
    skill = select_skill();
    
    if ( !skill )
    {
        return anim.failure;
    }
    
    self function_786bb6aa1b76c7ee( "uranus_bb_selected_skill", skill );
    return anim.success;
}

// Namespace namespace_bdf7104c266ba81d
// Params 2
// Checksum 0x5903ec7, Offset: 0x1044
// Size: 0x45
function function_ba6a80d5555fe925( taskid, param )
{
    skill = self getaiblackboarddynamic( "uranus_bb_selected_skill" );
    
    if ( skill == param )
    {
        return anim.success;
    }
    
    return anim.failure;
}

/#

    // Namespace namespace_bdf7104c266ba81d
    // Params 0
    // Checksum 0x410d0216, Offset: 0x1092
    // Size: 0x34, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x48>" + "<dev string:x6c>" );
        devgui::add_devgui_func( "<dev string:x74>", "<dev string:x7c>", &function_a93db3aa2257cdfa );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_bdf7104c266ba81d
    // Params 0
    // Checksum 0x24ce2c80, Offset: 0x10ce
    // Size: 0x2e, Type: dev
    function function_a93db3aa2257cdfa()
    {
        var_733163115b05935e = utility::callsharedfunc( #"hash_1f3f4d6111d1e480", #"hash_8aa4e7e3e44dbeb1" );
        
        if ( var_733163115b05935e )
        {
        }
    }

#/
