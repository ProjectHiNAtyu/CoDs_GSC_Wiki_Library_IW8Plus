// script_ac28d65e8605696  (hash_0ac28d65e8605696.gscc) (size: 47662 Bytes / 0xba2e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5174a5d7 (1366599127)
// size ...... 47662 (0xba2e)
// includes .. 15  (offset: 0xb0d2)
// strings ... 94  (offset: 0xb14a)
// dev strs .. 74  (offset: 0xb69a)
// exports ... 162 (offset: 0x6c1a)
// cseg ...... 0x6ae + 0x656c (0x6c1a)
// imports ... 342 (offset: 0x856a)
// animtree1 . 0   (offset: 0xba2e)
// animtree2 . 0   (offset: 0xba2e)
#using script_16ea1b94f0f381b3;
#using script_2734ab7e314a0bd3;
#using script_2a4a5417336c1c58;
#using script_2f93113e468a4db7;
#using script_e92a9717969a5cd;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\debug_utility;

#namespace europa;

// Namespace europa
// Params 0, eflags: 0x5
// Checksum 0x3e4d0829, Offset: 0x6cc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa", undefined, undefined, &post_main );
}

// Namespace europa
// Params 2
// Checksum 0x4fd81db3, Offset: 0x6ed
// Size: 0x88
function precache( classname, aitypescriptbundle )
{
    europasettings = get_europa_settings( aitypescriptbundle );
    
    if ( europasettings )
    {
        utility::add_fx( "vfx_europa_spark", europasettings.sparkvfx );
        utility::add_fx( "vfx_europa_teleport_out", europasettings.teleportoutvfx );
        utility::add_fx( "vfx_europa_teleport_in", europasettings.var_bdf6e23943406d2 );
    }
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"europa_recharge", &function_e958301156bf64be );
}

// Namespace europa
// Params 1
// Checksum 0xc205a9df, Offset: 0x77d
// Size: 0x85
function get_europa_settings( aitypescriptbundle )
{
    if ( level.europa_settings )
    {
        return level.europa_settings;
    }
    
    if ( !aitypescriptbundle )
    {
        return;
    }
    
    settingsbundle = getscriptbundle( "aisettingsbundle:" + aitypescriptbundle.aisettingsbundle );
    
    if ( settingsbundle.var_c6121f079c3fa62 )
    {
        europasettings = getscriptbundle( settingsbundle.var_c6121f079c3fa62 );
        level.europa_settings = europasettings;
    }
    
    return level.europa_settings;
}

// Namespace europa
// Params 0, eflags: 0x4
// Checksum 0x70d0bac9, Offset: 0x80b
// Size: 0xc
function private post_main()
{
    /#
        devgui_init();
    #/
}

// Namespace europa
// Params 0
// Checksum 0x16f93a62, Offset: 0x81f
// Size: 0x21e
function init()
{
    level.europa = self;
    europa = spawnstruct();
    europa.goalposes = [];
    europa.targets = [];
    europa.commands = [];
    europa.pingtargets = [];
    europa.command_id = 0;
    self.europa = europa;
    self.ignoreme = 1;
    self.var_6298584c895e2be0 = 1;
    self.dontsyncmelee = 1;
    self.disablearrivals = 1;
    self.cornercheckenabled = 0;
    self.cannotmelee = 1;
    self.disable_brain_rot = 1;
    self.b_ignore_monkey_bomb = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.gundiscipline = 0;
    self.checkstop = 0;
    self.newenemyreaction = 0;
    self.forcenewenemyreaction = 0;
    self.var_eb92c31552620100 = 1;
    self.bsoldier = 1;
    self.skipdeathanim = 1;
    val::set( #"europa", "pain", 0 );
    val::set( #"europa", "damage", 0 );
    val::set( #"europa", "ammomod_immune", 1 );
    val::set( #"europa", "disallow_stun", 1 );
    val::set( #"europa", "disallow_slow", 1 );
    val::set( #"europa", "disallow_knockdown", 1 );
    self pushplayer( 1 );
    self setcanusecover( 0 );
    self function_66dc8b6ae969f66d( 1 );
    self allowedstances( "stand" );
    self function_630eac6fd6900a61( "europa_default", 1 );
    self function_786bb6aa1b76c7ee( "europa_activated", 0 );
    callback::callback( #"europa_init" );
    init_cool_downs();
    register_callbacks();
    function_1b28561314ee2623();
    deactivate();
    thread function_865462da85f3349();
    
    /#
        debug_on_ai_spawned();
    #/
}

// Namespace europa
// Params 0
// Checksum 0x42830c, Offset: 0xa45
// Size: 0x208
function function_1b28561314ee2623()
{
    self.europa.vos = [ { #chance:0.5, #cd:10, #type:"arrival" }, { #chance:0.5, #cd:10, #type:"departure" }, { #chance:0.5, #cd:60, #type:"combat_chat" }, { #chance:1, #cd:60, #type:"direction" }, { #chance:0.5, #cd:30, #type:"kazimir" }, { #chance:0.5, #cd:30, #type:"ground_pound" }, { #chance:0.5, #cd:30, #type:"follow_vehicle" }, { #chance:1, #cd:10, #type:"revive_teammate" } ];
    
    foreach ( vo in self.europa.vos )
    {
        register_cool_down( vo.type, vo.cd );
    }
}

// Namespace europa
// Params 1
// Checksum 0xb4aae79d, Offset: 0xc55
// Size: 0x9a
function get_vo_data( type )
{
    foreach ( vo in self.europa.vos )
    {
        if ( vo.type == type )
        {
            return vo;
        }
    }
}

// Namespace europa
// Params 0, eflags: 0xc
// Checksum 0xf746ea78, Offset: 0xcf8
// Size: 0x81
function private function_865462da85f3349()
{
    self notify( #"hash_58925b1540b13ee" );
    self endon( #"hash_58925b1540b13ee" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( is_activated() && self.bulletsinclip == 0 )
        {
            objweapon = self getcurrentweapon();
            clipsize = weaponclipsize( objweapon );
            self.bulletsinclip = clipsize;
        }
        
        wait 1;
    }
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x32b34b28, Offset: 0xd81
// Size: 0x52
function private function_3953751a50269d5a( target )
{
    self.europa.pingtargets[ self.europa.pingtargets.size ] = target;
    self.favoriteenemy = target;
    zombie_utils::set_ai_target_priority( target, "europa_threat_group_ping", 100 );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x233b55c1, Offset: 0xddb
// Size: 0x61
function private function_275c1fdf83748df1( target )
{
    zombie_utils::set_ai_target_priority( target, "europa_threat_group_ping", 0 );
    
    if ( self.favoriteenemy == target )
    {
        self.favoriteenemy = undefined;
    }
    
    self.europa.pingtargets = arrayremove( self.europa.pingtargets, target );
}

// Namespace europa
// Params 0
// Checksum 0x662ae696, Offset: 0xe44
// Size: 0x1ed
function register_callbacks()
{
    utility::registersharedfunc( #"europa", #"hash_cc6a196accc3d6bf", &on_activate );
    utility::registersharedfunc( #"europa", #"hash_128edca9c946949c", &on_deactivate );
    utility::registersharedfunc( #"europa", #"hash_5c619c99b9d2e4bb", &function_ffa82f4c776a8a25 );
    utility::registersharedfunc( #"europa", #"hash_5b8a88a5b8ddb5a8", &function_523a117bbae53962 );
    utility::registersharedfunc( #"europa", #"hash_a81108c3938eece5", &function_14c31762168cbf23 );
    utility::registersharedfunc( #"europa", #"hash_c3e2334e7794ce1a", &enable_think );
    utility::registersharedfunc( #"europa", #"hash_f611d6f3acf4e752", &function_172075788b6d77b2 );
    utility::registersharedfunc( #"europa", #"hash_f5532cc95bd8a217", &function_84919f8f8db67077 );
    utility::registersharedfunc( #"europa", #"hash_52318df3b22daaa2", &set_rest_location );
    utility::registersharedfunc( #"europa", #"hash_aee90f7f15948896", &is_pos_reachable );
    utility::registersharedfunc( #"europa", #"hash_5a10c74557470ade", &return_to_chair );
    utility::registersharedfunc( #"europa", #"hash_100c40785c43cd05", &is_goal_in_range );
    utility::registersharedfunc( #"europa", #"hash_65ff4ac50413534", &can_think );
    callback::add( function_a4859357bdc15f92( "follow" ), &function_e1a9cc50addd5eb5 );
    callback::add( function_a4859357bdc15f92( "shoot" ), &function_dc7e174d7036978d );
    callback::add( "callback_on_saw_blade_trap_hit", &on_saw_blade_trap_hit );
    callback::add( "on_first_ai_init", &on_first_init );
    callback::add( #"hash_8e420a8ff3313166", &function_bf6341a86c399f62 );
}

// Namespace europa
// Params 1
// Checksum 0x8caad96, Offset: 0x1039
// Size: 0x14
function function_a4859357bdc15f92( var_469072f93ecbd83b )
{
    return "europa_bt_action_start_" + var_469072f93ecbd83b;
}

// Namespace europa
// Params 1
// Checksum 0x8746c0d0, Offset: 0x1056
// Size: 0x14
function function_8d0b7818fc98dbab( var_469072f93ecbd83b )
{
    return "europa_bt_action_end_" + var_469072f93ecbd83b;
}

// Namespace europa
// Params 1
// Checksum 0x42a25737, Offset: 0x1073
// Size: 0x222
function activate( owner )
{
    function_cdec0e301075f132();
    clear_all_targets();
    set_target( "owner", owner );
    self.europa.owner = owner;
    self.team = owner.team;
    owner.allyeuropa = self;
    self.europa.activated = 1;
    self.pushable = 0;
    self.health = self.maxhealth;
    self.europa.deactivating = 0;
    self.europa.followvehicle = 0;
    val::set( #"europa", "show_healthbar", 1 );
    self function_786bb6aa1b76c7ee( "europa_activated", 1 );
    self function_786bb6aa1b76c7ee( "return_to_chair", 0 );
    thread function_1799fcdfd63d83a9( owner );
    utility::function_7c10ea82c1e305b8( "activate", "activated" );
    set_on_chair( 0 );
    
    if ( !level callback::exists( #"on_ping", &function_9440c2ef9b648e3f ) )
    {
        level callback::add( #"on_ping", &function_9440c2ef9b648e3f );
    }
    
    if ( !level callback::exists( #"on_ping_removed", &function_469402018352ab3a ) )
    {
        level callback::add( #"on_ping_removed", &function_469402018352ab3a );
    }
    
    activeduration = function_e1f08bead161eea6();
    
    if ( europa_asm::is_playing() )
    {
        thread function_4e8ed159aee215b9();
    }
    else
    {
        enable_think( 1 );
        callback::callback( #"hash_8e420a8ff3313166", { #europa:self, #owner:owner } );
    }
    
    if ( activeduration > 0 && !self.europa.var_d0a4379fa7cfb169 )
    {
        thread activate_thread( activeduration );
    }
    
    callback::callback( #"europa_activated", { #europa:self, #owner:owner } );
    thread function_4b9ad574a7417def();
    thread function_ddcaccca5db56f1b();
    thread function_2228a59d109097fa();
}

// Namespace europa
// Params 0
// Checksum 0xc1d0a9a5, Offset: 0x129d
// Size: 0x31
function function_e1f08bead161eea6()
{
    return getdvarfloat( @"hash_4b4228e7ac4014b3", self.aisettings.specificaisettings.activeduration ?? 180 );
}

// Namespace europa
// Params 2
// Checksum 0xaeaff166, Offset: 0x12d7
// Size: 0x40
function set_rest_location( origin, angles )
{
    self.europa.var_c7d8e93b2ec585f = { #angles:angles, #origin:origin };
}

// Namespace europa
// Params 0, eflags: 0xc
// Checksum 0xc5aa3fa7, Offset: 0x131f
// Size: 0x1e5
function private function_4b9ad574a7417def()
{
    self notify( #"hash_76343332bf773e97" );
    self endon( #"hash_76343332bf773e97" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    owner = get_owner();
    owner endon( #"disconnect" );
    var_ae32e7f69262149 = self.aisettings.specificaisettings.var_ae32e7f69262149;
    var_ac0207f68ffbac7 = self.aisettings.specificaisettings.var_ac0207f68ffbac7;
    var_9f29d16b7af1aeab = self.aisettings.specificaisettings.var_9f29d16b7af1aeab;
    var_2ce78c887ccb18c2 = squared( self.aisettings.specificaisettings.teleportdistance );
    
    while ( owner && is_activated() )
    {
        if ( is_script_animation() || !can_think() || namespace_daf15362c2bc6ee0::is_operating() || owner.fasttravel_jumppad )
        {
            wait 0.5;
            continue;
        }
        
        if ( !owner )
        {
            return;
        }
        
        if ( distancesquared( self.origin, owner.origin ) > var_2ce78c887ccb18c2 || !is_pos_reachable( self.origin ) )
        {
            forward = anglestoforward( owner.angles );
            radius = randomfloatrange( var_ae32e7f69262149, var_ac0207f68ffbac7 );
            targetpos = getrandomnavpoint( owner.origin - forward * var_9f29d16b7af1aeab, radius );
            
            if ( targetpos && is_pos_reachable( targetpos ) )
            {
                function_84919f8f8db67077( targetpos );
            }
        }
        
        wait 1;
    }
}

// Namespace europa
// Params 2
// Checksum 0x1189f14c, Offset: 0x150c
// Size: 0xcb
function function_84919f8f8db67077( targetpos, var_b3073e8594ec0521 )
{
    self notify( #"hash_7cb2193d62fa0274" );
    self endon( #"hash_7cb2193d62fa0274" );
    level endon( #"game_ended" );
    self endon( #"death" );
    clear_goal_pos();
    function_cdec0e301075f132();
    playfx( utility::getfx( "vfx_europa_teleport_out" ), self.origin );
    self hide();
    self.isteleporting = 1;
    wait 1;
    self forceteleport( targetpos );
    self.isteleporting = 0;
    
    if ( var_b3073e8594ec0521 )
    {
        wait var_b3073e8594ec0521;
    }
    
    playfx( utility::getfx( "vfx_europa_teleport_in" ), targetpos );
    self show();
    
    if ( is_activated() )
    {
        europa_hover::function_71a68ebe6054d93f();
        set_goal_pos( targetpos );
    }
}

// Namespace europa
// Params 0, eflags: 0x4
// Checksum 0xe217ecb1, Offset: 0x15df
// Size: 0x86
function private function_4e8ed159aee215b9()
{
    self notify( #"hash_77fc01eb4a61522c" );
    self endon( #"hash_77fc01eb4a61522c" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    self waittill( #"cap_exit_completed" );
    enable_think( 1 );
    owner = get_owner();
    
    if ( isdefined( owner ) )
    {
        callback::callback( #"hash_8e420a8ff3313166", { #europa:self, #owner:owner } );
    }
}

// Namespace europa
// Params 1
// Checksum 0x2818da92, Offset: 0x166d
// Size: 0x117
function function_1799fcdfd63d83a9( target )
{
    var_ae32e7f69262149 = self.aisettings.specificaisettings.var_ae32e7f69262149 ?? 0;
    var_ac0207f68ffbac7 = self.aisettings.specificaisettings.var_ac0207f68ffbac7 ?? 500;
    set_target( "landing_pos", undefined );
    randpos = function_2e6b9adc1abf7589( target.origin, var_ae32e7f69262149, var_ac0207f68ffbac7 );
    
    /#
        if ( getdvarint( @"hash_10a462803db22ea9" ) )
        {
            player = dev_get_player();
            randpos = player.origin + anglestoforward( player.angles ) * 100;
        }
    #/
    
    flytarget = spawnstruct();
    flytarget.origin = randpos;
    flytarget.angles = target.angles;
    set_target( "landing_pos", flytarget );
    return flytarget;
}

// Namespace europa
// Params 3, eflags: 0x4
// Checksum 0x124a4f6d, Offset: 0x178d
// Size: 0xbe
function private function_2e6b9adc1abf7589( location, radiusmin, radiusmax )
{
    var_c0b0f0726bf31817 = 60;
    var_d3eab54ea897b9b9 = 50;
    var_ed3cd82c477b6026 = 30;
    randpos = undefined;
    trycount = 0;
    angle = randomfloat( 360 );
    
    while ( trycount < var_c0b0f0726bf31817 )
    {
        randpos = function_81bb9d06d0c4a338( location, radiusmin, radiusmax, angle );
        
        if ( is_pos_reachable( randpos ) && !function_6f53dbd8c6a86e93( randpos ) )
        {
            break;
        }
        
        angle += var_ed3cd82c477b6026;
        angle = angleclamp( angle );
        radiusmin += var_d3eab54ea897b9b9;
        radiusmax += var_d3eab54ea897b9b9;
        trycount++;
        waitframe();
    }
    
    return randpos;
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xf287705e, Offset: 0x1854
// Size: 0x83, Type: bool
function private function_6f53dbd8c6a86e93( location )
{
    overridecontents = trace::create_contents( 0, 1, 1, 1 );
    startpos = location + ( 0, 0, 100 );
    endpos = location + ( 0, 0, 2000 );
    var_919ac9ffb4147a4e = trace::ray_trace( startpos, endpos, self, overridecontents );
    
    if ( var_919ac9ffb4147a4e[ "fraction" ] > 0.95 )
    {
        return false;
    }
    
    return true;
}

// Namespace europa
// Params 1, eflags: 0xc
// Checksum 0x98c9ab8c, Offset: 0x18e0
// Size: 0xcd
function private activate_thread( activeduration )
{
    self notify( #"hash_5888061cb0bdbe8" );
    self endon( #"hash_5888061cb0bdbe8" );
    self notify( #"europa_activate_thread" );
    self endon( #"europa_activate_thread" );
    self endon( #"europa_return_to_chair" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_5e70a2128e6f74bc" );
    function_47761cd429bc0244();
    self.europa.activatedtime = gettime();
    self.europa.var_57afd0dd5aae0336 = activeduration;
    
    if ( activeduration > 0 )
    {
        thread function_36bf1c0f6db55031( activeduration );
        wait activeduration;
    }
    
    while ( function_336bcea234c7f77e() )
    {
        wait 0.5;
    }
    
    function_6195dc641a32aef();
}

// Namespace europa
// Params 1, eflags: 0xc
// Checksum 0x98ae66df, Offset: 0x19b5
// Size: 0xf5
function private function_36bf1c0f6db55031( activeduration )
{
    self notify( #"hash_2fa143ed3395c6a8" );
    self endon( #"hash_2fa143ed3395c6a8" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    self endon( #"hash_5e70a2128e6f74bc" );
    self notify( #"hash_7a713dc847c3d4dc" );
    self.health = self.maxhealth;
    activatedurationms = utility::function_4b74c15943231980( activeduration );
    var_fd8412dd09764fd = gettime() + activatedurationms;
    origindurationms = utility::function_4b74c15943231980( function_e1f08bead161eea6() );
    
    while ( true )
    {
        ratio = ( var_fd8412dd09764fd - gettime() ) / origindurationms;
        
        if ( ratio > 0 )
        {
            self.health = int( max( 1, self.maxhealth * ratio ) );
        }
        
        wait 0.2;
    }
}

// Namespace europa
// Params 0
// Checksum 0x1c90b493, Offset: 0x1ab2
// Size: 0x44, Type: bool
function function_336bcea234c7f77e()
{
    if ( !can_think() )
    {
        return true;
    }
    
    if ( is_script_animation() )
    {
        return true;
    }
    
    if ( namespace_daf15362c2bc6ee0::is_operating() )
    {
        return true;
    }
    
    if ( europa_revive_teammate::can_revive_teammate() && is_target_in_last_stand( get_owner() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace europa
// Params 0
// Checksum 0x9173fd79, Offset: 0x1aff
// Size: 0x87, Type: bool
function is_script_animation()
{
    return ai::is_doing_traversal( self ) || self.var_15c6e27c1acff47e != "not_set" || europa_asm::is_playing() || europa_asm::is_script_animation() || asm_bb::bb_isanimscripted() || self isinscriptedstate() || self.europa.isthrowgrenade || self.isteleporting || self.europa.mover || self islinked();
}

// Namespace europa
// Params 0
// Checksum 0xcdeb2be1, Offset: 0x1b8f
// Size: 0x14
function function_47761cd429bc0244()
{
    while ( is_script_animation() )
    {
        wait 0.1;
    }
}

// Namespace europa
// Params 0
// Checksum 0x1a2964e9, Offset: 0x1bab
// Size: 0xe5
function deactivate()
{
    logstring( "[EUROPA] deactivate" );
    owner = get_owner();
    
    if ( isdefined( owner ) )
    {
        if ( owner callback::exists( #"on_ping", &function_9440c2ef9b648e3f ) )
        {
            owner callback::remove( #"on_ping", &function_9440c2ef9b648e3f );
        }
        
        callback::callback( #"europa_deactivated", { #europa:self, #owner:owner } );
        owner.allyeuropa = undefined;
    }
    
    val::set( #"europa", "show_healthbar", 0 );
    self.europa.activated = 0;
    self.europa.var_fa2f23c9ef92d618 = 0;
    self function_786bb6aa1b76c7ee( "europa_activated", 0 );
    enable_think( 0 );
    self notify( #"europa_deactivated" );
}

// Namespace europa
// Params 1
// Checksum 0x899becfd, Offset: 0x1c98
// Size: 0x22
function set_on_chair( onchair )
{
    self.europa.onchair = onchair;
}

// Namespace europa
// Params 0
// Checksum 0x285e3706, Offset: 0x1cc2
// Size: 0x15
function is_activated()
{
    return self.europa.activated;
}

// Namespace europa
// Params 1
// Checksum 0x8d253607, Offset: 0x1ce0
// Size: 0x2e, Type: bool
function is_europa( entity )
{
    if ( isai( entity ) && entity.subclass == "soldier_europa" )
    {
        return true;
    }
    
    return false;
}

// Namespace europa
// Params 0
// Checksum 0x27f2251, Offset: 0x1d17
// Size: 0xd
function is_recharging()
{
    return has_cool_down( "recharge" );
}

// Namespace europa
// Params 0
// Checksum 0x22db41d1, Offset: 0x1d2d
// Size: 0x15
function is_on_chair()
{
    return self.europa.onchair;
}

// Namespace europa
// Params 3
// Checksum 0x18661705, Offset: 0x1d4b
// Size: 0x37, Type: bool
function is_pos_in_range( pos1, pos2, range )
{
    distancesq = distancesquared( pos1, pos2 );
    return distancesq < range * range;
}

// Namespace europa
// Params 1
// Checksum 0xe2b71435, Offset: 0x1d8b
// Size: 0x21, Type: bool
function is_target_in_last_stand( target )
{
    return isalive( target ) && target.inlaststand;
}

// Namespace europa
// Params 2
// Checksum 0xdd6d423d, Offset: 0x1db5
// Size: 0x4b, Type: bool
function is_facing_point( point, facingangle )
{
    todirection = vectornormalize2( point - self.origin );
    return vectordot( anglestoforward( self.angles ), todirection ) >= cos( facingangle );
}

// Namespace europa
// Params 1
// Checksum 0x4316a48e, Offset: 0x1e09
// Size: 0x45, Type: bool
function is_pos_reachable( pos )
{
    if ( !pos )
    {
        return false;
    }
    
    if ( callback::response( 1, #"hash_706274acea59a6d6", { #origin:pos } ) )
    {
        return false;
    }
    
    if ( !getclosestpointonnavmesh( pos, self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace europa
// Params 3
// Checksum 0x8329981, Offset: 0x1e57
// Size: 0x143
function get_reachable_pos( origin, radius_min, radius_max )
{
    validpos = getclosestpointonnavmesh( origin, self );
    
    if ( validpos && !is_pos_reachable( validpos ) )
    {
        var_c0b0f0726bf31817 = 10;
        var_d3eab54ea897b9b9 = 50;
        var_ed3cd82c477b6026 = 36;
        
        if ( !isdefined( radius_min ) )
        {
            radius_min = 0;
        }
        
        if ( !isdefined( radius_max ) )
        {
            radius_max = 0;
        }
        
        trycount = 0;
        angle = randomfloat( 360 );
        rmin = radius_min;
        rmax = radius_max;
        contents = trace::create_contents( 0, 1, 1, 1, 0, 1 );
        
        while ( trycount < var_c0b0f0726bf31817 )
        {
            randpos = function_81bb9d06d0c4a338( origin, rmin, rmax, angle );
            
            if ( is_pos_reachable( randpos ) )
            {
                result = trace::ray_trace( origin, randpos, self, contents, undefined, undefined, 1 );
                
                if ( result[ "fraction" ] > 0.95 )
                {
                    validpos = randpos;
                    break;
                }
            }
            
            angle += var_ed3cd82c477b6026;
            angle = angleclamp( angle );
            rmin += var_d3eab54ea897b9b9;
            rmin = min( rmin, radius_max );
            trycount++;
        }
    }
    
    return validpos;
}

// Namespace europa
// Params 0
// Checksum 0x4a7bb572, Offset: 0x1fa3
// Size: 0x15
function get_owner()
{
    return self.europa.owner;
}

// Namespace europa
// Params 0
// Checksum 0xcad192ee, Offset: 0x1fc1
// Size: 0x1b, Type: bool
function get_defend_target()
{
    return function_b8c0ff578e3412( "defend_pos" ) ?? function_b8c0ff578e3412( "defend_ent" );
}

// Namespace europa
// Params 2
// Checksum 0x2d5fce02, Offset: 0x1fe5
// Size: 0xc1
function add_command( commandtype, param )
{
    var_ebed75987be3606d = get_command( commandtype );
    
    if ( var_ebed75987be3606d )
    {
        remove_command( var_ebed75987be3606d );
    }
    
    self.europa.command_id++;
    command = spawnstruct();
    command.type = commandtype;
    command.id = self.europa.command_id;
    command.param = param;
    self.europa.commands[ self.europa.commands.size ] = command;
    return command;
}

// Namespace europa
// Params 0
// Checksum 0xf0840e35, Offset: 0x20af
// Size: 0xc2
function function_cdec0e301075f132()
{
    foreach ( cmd in self.europa.commands )
    {
        cmd.iscancelled = 1;
        command_end( cmd );
    }
    
    self.europa.commands = [];
    self.europa.currenttarget = undefined;
    clear_defend_targets();
}

// Namespace europa
// Params 1
// Checksum 0xbcdd4dcc, Offset: 0x2179
// Size: 0xba
function command_end( command )
{
    switch ( command.type )
    {
        case #"hash_5b8a88a5b8ddb5a8":
        case #"hash_e6ac86ecd140e0f2":
            self.europa.moving = 0;
            get_owner() notify( "europa_remove_defend_mark_" + command.id );
            on_move_command_end( command );
            break;
        case #"hash_a81108c3938eece5":
            self.europa.moving = 0;
            on_move_command_end( command );
            break;
        default:
            break;
    }
    
    command notify( #"europa_command_end" );
}

// Namespace europa
// Params 1
// Checksum 0xe9393ed7, Offset: 0x223b
// Size: 0x89
function on_move_command_end( command )
{
    pos = command.param.pos;
    result = distancesquared( pos, self.origin ) < 10000;
    callback::callback( #"hash_79d24ca84454391d", { #result:result, #targetpos:pos, #europa:self } );
    self notify( #"europa_on_move_command_end", command );
}

// Namespace europa
// Params 1
// Checksum 0x96ac9017, Offset: 0x22cc
// Size: 0xd6
function remove_command( commandid )
{
    if ( isstruct( commandid ) )
    {
        commandid = commandid.id;
    }
    
    for ( i = 0; i < self.europa.commands.size ; i++ )
    {
        if ( self.europa.commands[ i ].id == commandid )
        {
            command_end( self.europa.commands[ i ] );
            self.europa.commands[ i ] = undefined;
            break;
        }
    }
    
    self.europa.commands = function_5713d46873b29625( self.europa.commands );
}

// Namespace europa
// Params 1
// Checksum 0x88cabba6, Offset: 0x23aa
// Size: 0x33, Type: bool
function has_command( type )
{
    if ( !isdefined( type ) )
    {
        return ( self.europa.commands.size > 0 );
    }
    
    return isdefined( get_command( type ) );
}

// Namespace europa
// Params 1
// Checksum 0xc863930b, Offset: 0x23e6
// Size: 0x76
function get_command( type )
{
    for ( i = 0; i < self.europa.commands.size ; i++ )
    {
        if ( self.europa.commands[ i ].type == type )
        {
            return self.europa.commands[ i ];
        }
    }
}

// Namespace europa
// Params 1
// Checksum 0x347d9fa2, Offset: 0x2465
// Size: 0x9a
function function_d7c804c78806fbc0( commandid )
{
    foreach ( cmd in self.europa.commands )
    {
        if ( cmd.id == commandid )
        {
            return cmd;
        }
    }
}

// Namespace europa
// Params 0
// Checksum 0x8c2cce9b, Offset: 0x2507
// Size: 0x126
function clear_defend_targets()
{
    set_target( "defend_pos", undefined );
    set_target( "defend_ent", undefined );
    
    for ( i = 0; i < self.europa.commands.size ; i++ )
    {
        cmd = self.europa.commands[ i ];
        
        switch ( cmd.type )
        {
            case #"hash_5b8a88a5b8ddb5a8":
            case #"hash_a81108c3938eece5":
            case #"hash_e6ac86ecd140e0f2":
                command_end( cmd );
                self.europa.commands[ i ] = undefined;
                break;
            default:
                break;
        }
    }
    
    self.europa.commands = function_5713d46873b29625( self.europa.commands );
    self.europa.var_961e51ff2f0ae2c9 = 0;
    self.europa.var_4842eb3b481374f9 = 0;
}

// Namespace europa
// Params 0
// Checksum 0x2fda428b, Offset: 0x2635
// Size: 0x15
function get_goal_pos()
{
    return self.europa.goalpos;
}

// Namespace europa
// Params 0
// Checksum 0x17564f53, Offset: 0x2653
// Size: 0x38
function clear_goal_pos()
{
    self setbtgoalpos( 3, self.origin );
    self clearpath();
    self.europa.goalpos = undefined;
    self notify( #"hash_9cb9a15e7fbbae44" );
}

// Namespace europa
// Params 2
// Checksum 0xfaf0688a, Offset: 0x2693
// Size: 0xe8
function set_goal_pos( pos, goalradius = 0 )
{
    if ( goalradius > 0 )
    {
        radiusmin = min( goalradius, 100 );
        goalpos = function_81bb9d06d0c4a338( pos, radiusmin, goalradius );
    }
    else
    {
        goalpos = pos;
    }
    
    if ( isdefined( goalpos ) )
    {
        self setbtgoalpos( 3, goalpos );
        now = gettime();
        self.europa.goalpos = goalpos;
        self.europa.setgoaltime = now;
        self.europa.stucktime = now;
        self.europa.lastpos = self.origin;
    }
    else
    {
        self.europa.setgoaltime = undefined;
    }
    
    return goalpos;
}

// Namespace europa
// Params 1
// Checksum 0x7799ae93, Offset: 0x2784
// Size: 0x52, Type: bool
function function_965adb362e3ddb52( timeout )
{
    self endon( #"death" );
    time_passed = 0;
    
    while ( !self getpath() )
    {
        wait 0.1;
        
        if ( isdefined( timeout ) )
        {
            time_passed += 0.1;
            
            if ( time_passed > timeout )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace europa
// Params 3
// Checksum 0x76ddbce6, Offset: 0x27df
// Size: 0x29
function move_to( goalpos, radius, params )
{
    thread movement_thread( goalpos, radius, params );
}

// Namespace europa
// Params 3, eflags: 0xc
// Checksum 0x3755650c, Offset: 0x2810
// Size: 0x229
function private movement_thread( goalpos, radius, params )
{
    self notify( #"hash_1d19b3c73b36d32f" );
    self endon( #"hash_1d19b3c73b36d32f" );
    self endon( #"death" );
    self endon( #"europa_on_move_command_end" );
    self.europa.moving = 1;
    self.var_1814c21e4ca79288 = undefined;
    forcewalk = params.forcewalk ?? 0;
    
    if ( !isdefined( radius ) )
    {
        radius = 0;
    }
    
    function_47761cd429bc0244();
    
    if ( params.forcehover || !forcewalk && function_6619dc1ddecded7d( goalpos, params.command ) )
    {
        var_8dfc18921e8677ec = 1;
    }
    else
    {
        var_8dfc18921e8677ec = 0;
        set_goal_pos( goalpos, radius );
        
        if ( !function_965adb362e3ddb52( 1 ) )
        {
            goalpos = getclosestpointonnavmesh( goalpos, self );
            set_goal_pos( goalpos, radius );
            
            if ( !function_965adb362e3ddb52( 1 ) )
            {
                r = max( 50, radius );
                result = distancesquared( self.origin, goalpos ) < r * r;
                self.europa.moving = 0;
                self.var_1814c21e4ca79288 = result;
                self notify( #"europa_move_to_end", result );
                return;
            }
        }
    }
    
    if ( var_8dfc18921e8677ec )
    {
        if ( radius > 0 )
        {
            radiusmin = min( radius, 100 );
            goalpos = function_81bb9d06d0c4a338( goalpos, radiusmin, radius );
        }
        
        europa_hover::function_a29bc8195eac2631( goalpos, params.command );
        self waittill( #"hash_163ed70cfa27146b" );
    }
    else
    {
        wait_pathfinding( 30 );
    }
    
    if ( params.var_8ef7781f0cbd54b9 )
    {
        function_47761cd429bc0244();
        warpduration = 0.5;
        self motionwarp( params.pos, params.angles, warpduration );
        wait warpduration;
    }
    
    self.europa.moving = 0;
    self notify( #"europa_move_to_end", 1 );
}

// Namespace europa
// Params 1
// Checksum 0x8fab858, Offset: 0x2a41
// Size: 0x105, Type: bool
function wait_pathfinding( timeout )
{
    self endon( #"death" );
    self endon( #"hash_9cb9a15e7fbbae44" );
    dist_check_sq = 10000;
    starttime = gettime();
    
    if ( !function_51e8ad4cc6e30f80( timeout ) )
    {
        return false;
    }
    
    while ( true )
    {
        if ( !self.europa.goalpos )
        {
            return false;
        }
        
        if ( distancesquared( self.origin, self.europa.goalpos ) < dist_check_sq )
        {
            break;
        }
        
        timepassed = utility::function_6f5d2e1f1ff70482( gettime() - starttime );
        
        if ( timepassed >= timeout )
        {
            return false;
        }
        
        wait 0.5;
        
        if ( !self.europa.goalpos )
        {
            return false;
        }
        
        self setbtgoalpos( 3, self.europa.goalpos );
        
        if ( !function_51e8ad4cc6e30f80( timeout - timepassed ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xcc1b3673, Offset: 0x2b4f
// Size: 0x107, Type: bool
function private function_51e8ad4cc6e30f80( timeout )
{
    now = gettime();
    var_176ffefb0e85a92b = min( timeout, 5 );
    
    if ( !function_965adb362e3ddb52( var_176ffefb0e85a92b ) )
    {
        return false;
    }
    
    used = gettime() - now;
    timeout -= utility::function_6f5d2e1f1ff70482( used );
    timepassed = 0;
    stucktime = 0;
    lastpos = self.origin;
    
    while ( self pathdisttogoal() > 0 )
    {
        wait 0.1;
        
        if ( distance2dsquared( lastpos, self.origin ) < 100 )
        {
            stucktime += 0.1;
        }
        else
        {
            stucktime = 0;
            lastpos = self.origin;
        }
        
        if ( stucktime > 5 )
        {
            return false;
        }
        
        if ( timeout > 0 )
        {
            timepassed += 0.1;
            
            if ( timepassed > timeout )
            {
                return false;
            }
        }
    }
    
    while ( self.arriving )
    {
        wait 0.1;
    }
    
    wait 0.1;
    return true;
}

// Namespace europa
// Params 0, eflags: 0xc
// Checksum 0x60873ffa, Offset: 0x2c5f
// Size: 0x15f
function private function_ddcaccca5db56f1b()
{
    self notify( #"hash_fda5c7a16cfb874c" );
    self endon( #"hash_fda5c7a16cfb874c" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    dissq = 1024;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || player.inlaststand || player islinked() )
            {
                if ( player.var_7a1bd4597f8d3ce9 )
                {
                    player stop_push_player();
                }
                
                continue;
            }
            
            if ( self.europa.moving && distancesquared( self.origin, player.origin ) < dissq )
            {
                force = player.origin - self.origin;
                player thread push_player_thread( force );
            }
        }
        
        waitframe();
    }
}

// Namespace europa
// Params 0, eflags: 0xc
// Checksum 0xba521783, Offset: 0x2dc6
// Size: 0x202
function private function_2228a59d109097fa()
{
    self notify( #"hash_9bee05d368c26e32" );
    self endon( #"hash_9bee05d368c26e32" );
    level endon( #"game_ended" );
    self endon( #"death" );
    overridecontents = trace::create_contents( 0, 1, 1, 1 );
    var_6a9dc2c1f6ebf873 = 0.6;
    
    while ( true )
    {
        self waittill( #"touch", hitent );
        
        if ( isdefined( hitent.vehicletype ) )
        {
            /#
                if ( isdvardefined( @"hash_10af1efd4d0b0db3" ) )
                {
                    var_6a9dc2c1f6ebf873 = getdvarfloat( @"hash_10af1efd4d0b0db3" );
                }
                
                sphere( hitent.origin, 5, ( 1, 0, 0 ), 0, 1 );
            #/
            
            dir = vectornormalize2( self.origin - hitent.origin );
            force = max( hitent.veh_speed, 1 ) * var_6a9dc2c1f6ebf873;
            targetpos = self.origin + dir * force;
            
            if ( self.europa.hovermover )
            {
                self.europa.hovermover.origin = targetpos;
            }
            else
            {
                start = self.origin + ( 0, 0, self.height * 0.5 );
                result = trace::ray_trace( start, start + dir * force, [ self, hitent ], overridecontents );
                
                if ( result[ "fraction" ] < 1 )
                {
                    pos = self.origin - dir * 500;
                    targetpos = getclosestpointonnavmesh( pos, self );
                    thread function_84919f8f8db67077( targetpos );
                    wait 1;
                    continue;
                }
                
                self forceteleport( targetpos );
                self setbtgoalpos( 3, targetpos );
                self clearpath();
            }
        }
        
        waitframe();
    }
}

// Namespace europa
// Params 1
// Checksum 0x841e3ecb, Offset: 0x2fd0
// Size: 0x62
function push_player_thread( force )
{
    self notify( #"hash_b53ee12453aba6a4" );
    self endon( #"hash_b53ee12453aba6a4" );
    level endon( #"game_ended" );
    self endon( #"hash_4ee0714808237ac5" );
    self.var_7a1bd4597f8d3ce9 = 1;
    self pushplayervector( force, 1 );
    wait 0.1;
    
    if ( self )
    {
        stop_push_player();
    }
}

// Namespace europa
// Params 0, eflags: 0x4
// Checksum 0xccf8f516, Offset: 0x303a
// Size: 0x2d
function private stop_push_player()
{
    self pushplayervector( ( 0, 0, 0 ), 1 );
    self.var_7a1bd4597f8d3ce9 = 0;
    self notify( #"hash_4ee0714808237ac5" );
}

// Namespace europa
// Params 0
// Checksum 0x5dc58152, Offset: 0x306f
// Size: 0x17
function clear_all_targets()
{
    self.europa.targets = [];
}

// Namespace europa
// Params 2
// Checksum 0x62cf5e23, Offset: 0x308e
// Size: 0x2d
function set_target( type, target )
{
    self.europa.targets[ type ] = target;
}

// Namespace europa
// Params 1
// Checksum 0x2e3ea285, Offset: 0x30c3
// Size: 0x22
function function_957083fb057ca11( target )
{
    self.europa.currenttarget = target;
}

// Namespace europa
// Params 1
// Checksum 0x4c8a7fa4, Offset: 0x30ed
// Size: 0x22
function function_b8c0ff578e3412( type )
{
    return self.europa.targets[ type ];
}

// Namespace europa
// Params 0
// Checksum 0x7723b4c7, Offset: 0x3118
// Size: 0x15
function function_bde59859a3c2c9e5()
{
    return self.europa.currenttarget;
}

// Namespace europa
// Params 1
// Checksum 0x5dcfe12b, Offset: 0x3136
// Size: 0x60, Type: bool
function should_teleport_to_location( position )
{
    distance = self.aisettings.specificaisettings.teleportdistance;
    
    if ( distance > 0 )
    {
        distancesq = distancesquared( position, self.origin );
        return ( distancesq > squared( distance ) );
    }
    
    return false;
}

// Namespace europa
// Params 3
// Checksum 0x64086522, Offset: 0x319f
// Size: 0x186, Type: bool
function function_6619dc1ddecded7d( position, command, disabledebug )
{
    /#
        if ( !disabledebug && getdvarint( @"hash_fdbafab53253ce46", 0 ) )
        {
            return true;
        }
    #/
    
    isurgent = isdefined( command ) || self.europa.var_6481e81eb38197de == "revive_teammate";
    var_e4d40487210b0160 = isurgent ? self.aisettings.specificaisettings.var_d94956c2102db249 : self.aisettings.specificaisettings.var_c02c5701d1bde86c;
    var_c02c5701d1bde86c = getdvarfloat( @"hash_2221ab1986435793", var_e4d40487210b0160 );
    
    if ( var_c02c5701d1bde86c > 0 )
    {
        distancesq = distancesquared( position, self.origin );
        
        if ( distancesq > squared( var_c02c5701d1bde86c ) )
        {
            return true;
        }
    }
    
    path = self findpath( self.origin, position );
    
    if ( path )
    {
        var_4d732d34a583a357 = self.aisettings.specificaisettings.var_4e36c02336ffc2d8;
        length = 0;
        
        for ( i = 1; i < path.size ; i++ )
        {
            length += distance( path[ i - 1 ], path[ i ] );
        }
        
        if ( length > var_4d732d34a583a357 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace europa
// Params 1
// Checksum 0x3b487d22, Offset: 0x332e
// Size: 0x49
function return_to_chair( returntype )
{
    if ( europa_asm::is_playing() && europa_asm::function_972cfe27021b9096() == "europa_activate" && self getaiblackboarddynamic( "return_to_chair" ) )
    {
        return;
    }
    
    if ( !isdefined( returntype ) )
    {
        returntype = "fly";
    }
    
    thread return_to_chair_thread( returntype );
}

// Namespace europa
// Params 1
// Checksum 0xbd03dc38, Offset: 0x337f
// Size: 0x1d6
function return_to_chair_thread( returntype )
{
    self notify( #"europa_return_to_chair" );
    self endon( #"europa_return_to_chair" );
    self endon( #"death" );
    function_47761cd429bc0244();
    target = self.europa.var_c7d8e93b2ec585f;
    callback::callback( #"europa_return_to_chair", { #europa:self } );
    set_target( "target", target );
    self function_786bb6aa1b76c7ee( "return_to_chair", 1 );
    
    if ( returntype == "walk" )
    {
        self function_786bb6aa1b76c7ee( "move_to_type", "walk" );
        set_goal_pos( target.origin, 0 );
        
        if ( !wait_pathfinding( 30 ) )
        {
            assertmsg( "<dev string:x24>" );
        }
    }
    else
    {
        set_target( "landing_pos", target );
        self function_786bb6aa1b76c7ee( "move_to_type", returntype );
    }
    
    europa_asm::play_cap( "europa_activate", "cap_europa_activate" );
    self waittill( #"hash_46be2957b8bf5782" );
    
    if ( self.europa.var_c7d8e93b2ec585f )
    {
        animationoffset = ( -1.52051, 1.43945, 0.740479 );
        targetpos = self.europa.var_c7d8e93b2ec585f.origin + animationoffset;
        self forceteleport( targetpos, self.europa.var_c7d8e93b2ec585f.angles, 100000 );
    }
    
    start_cool_down( "recharge" );
    thread utility::delay_notify( self.europa.cooldown_data[ "recharge" ], "europa_recharge_finished" );
    self.europa.deactivating = 0;
}

// Namespace europa
// Params 5
// Checksum 0x91ea79eb, Offset: 0x355d
// Size: 0xa0
function fly_to_target( owner, pos, angles, radiusmin, radiusmax )
{
    tgt = spawnstruct();
    tgt.origin = pos;
    tgt.angles = angles;
    thread function_1799fcdfd63d83a9( tgt );
    self function_786bb6aa1b76c7ee( "return_to_chair", 0 );
    function_11308ac9cf87dd0c( pos );
    
    if ( is_activated() )
    {
        europa_asm::play_cap( "europa_activate", "cap_europa_activate" );
        return;
    }
    
    activate( owner );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xd594cf0b, Offset: 0x3605
// Size: 0x53
function private function_11308ac9cf87dd0c( pos )
{
    var_b62d290bca467227 = pos ? self.origin[ 2 ] - pos[ 2 ] > 1000 : 0;
    self function_786bb6aa1b76c7ee( "move_to_type", var_b62d290bca467227 ? "land" : "fly" );
}

// Namespace europa
// Params 4
// Checksum 0x98b36cd9, Offset: 0x3660
// Size: 0xdc
function function_81bb9d06d0c4a338( center, minradius, maxradius, fixedangle )
{
    min = min( minradius, maxradius );
    
    if ( min < 0 )
    {
        min = 0;
    }
    
    max = max( minradius, maxradius );
    
    if ( max <= 0 )
    {
        return getclosestpointonnavmesh( center );
    }
    
    distance = max * sqrt( randomfloatrange( min / max, 1 ) );
    angle = fixedangle ?? randomfloat( 360 );
    xoffset = distance * cos( angle );
    yoffset = distance * sin( angle );
    randpos = ( center[ 0 ] + xoffset, center[ 1 ] + yoffset, center[ 2 ] );
    return getclosestpointonnavmesh( randpos );
}

// Namespace europa
// Params 1
// Checksum 0x8efbdfea, Offset: 0x3745
// Size: 0x3a
function enable_think( enable )
{
    self.europa.can_think = enable;
    val::set( #"europa", "ignoreall", !enable );
}

// Namespace europa
// Params 0
// Checksum 0x2fa65a69, Offset: 0x3787
// Size: 0x15
function can_think()
{
    return self.europa.can_think;
}

// Namespace europa
// Params 1
// Checksum 0x9af0a4cd, Offset: 0x37a5
// Size: 0x176
function function_172075788b6d77b2( disable )
{
    self.europa.var_32654821162ebb16 = disable ?? 1;
    
    if ( self.europa.var_32654821162ebb16 )
    {
        now = gettime();
        
        if ( isdefined( self.europa.activatedtime ) )
        {
            if ( !isdefined( self.europa.var_57afd0dd5aae0336 ) )
            {
                self.europa.var_57afd0dd5aae0336 = function_e1f08bead161eea6();
            }
            
            self.europa.var_57afd0dd5aae0336 -= utility::function_6f5d2e1f1ff70482( now - self.europa.activatedtime );
            
            if ( self.europa.var_57afd0dd5aae0336 < 0 )
            {
                self.europa.var_57afd0dd5aae0336 = 0;
            }
            
            self.europa.activatedtime = now;
        }
        
        self notify( #"hash_5e70a2128e6f74bc" );
        self.health = self.maxhealth;
        return;
    }
    
    if ( self.europa.var_57afd0dd5aae0336 )
    {
        thread activate_thread( self.europa.var_57afd0dd5aae0336 );
        return;
    }
    
    thread function_6195dc641a32aef();
}

// Namespace europa
// Params 0
// Checksum 0xdc27662b, Offset: 0x3923
// Size: 0xbe
function init_cool_downs()
{
    europa = self.europa;
    
    if ( !isdefined( europa.cooldowns ) )
    {
        europa.cooldowns = [];
    }
    
    if ( !isdefined( europa.cooldown_data ) )
    {
        europa.cooldown_data = [];
    }
    
    register_cool_down( "wander", 10 );
    register_cool_down( "recharge", self.aisettings.specificaisettings.rechargeduration );
    register_cool_down( "skill_common", 10 );
    register_cool_down( "strategically_move", 2 );
    register_cool_down( "play_vo", 10 );
    callback::callback( #"hash_7e3a7d30f11f29e6" );
}

// Namespace europa
// Params 2
// Checksum 0x63b5a329, Offset: 0x39e9
// Size: 0x32
function register_cool_down( key, seconds )
{
    self.europa.cooldown_data[ key ] = seconds ?? 0;
}

// Namespace europa
// Params 1
// Checksum 0x7a83cef, Offset: 0x3a23
// Size: 0x22
function function_b85fde7cbf122619( key )
{
    return self.europa.cooldown_data[ key ];
}

// Namespace europa
// Params 1
// Checksum 0xd1d932d4, Offset: 0x3a4e
// Size: 0xaa, Type: bool
function has_cool_down( key )
{
    if ( !isdefined( self.europa.cooldown_data[ key ] ) )
    {
        assertmsg( "<dev string:x58>" );
        return false;
    }
    
    if ( self.europa.cooldown_data[ key ] <= 0 )
    {
        return false;
    }
    
    if ( isdefined( self.europa.cooldowns[ key ] ) )
    {
        seconds = function_b85fde7cbf122619( key );
        
        if ( gettime() - self.europa.cooldowns[ key ] < seconds * 1000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace europa
// Params 1
// Checksum 0x3f986b5c, Offset: 0x3b01
// Size: 0x6b
function start_cool_down( key )
{
    if ( !isdefined( self.europa.cooldown_data[ key ] ) )
    {
        assertmsg( "<dev string:x58>" );
        return;
    }
    
    if ( self.europa.cooldown_data[ key ] > 0 )
    {
        self.europa.cooldowns[ key ] = gettime();
    }
}

// Namespace europa
// Params 1
// Checksum 0x4eae3aad, Offset: 0x3b74
// Size: 0x5a
function clear_cool_down( key )
{
    if ( isdefined( key ) )
    {
        if ( isdefined( self.europa.cooldowns[ key ] ) )
        {
            self.europa.cooldowns[ key ] = undefined;
        }
        
        return;
    }
    
    self.europa.cooldowns = [];
}

// Namespace europa
// Params 1, eflags: 0xc
// Checksum 0x20057b69, Offset: 0x3bd6
// Size: 0xd0
function private function_d1bcfe9f51dccd4e( command )
{
    self notify( #"hash_9ea9460d680548c6" );
    self endon( #"hash_9ea9460d680548c6" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( command )
    {
        command endon( #"europa_command_end" );
    }
    
    thread watch_stuck_thread( command );
    forcewalk = command.param.forcewalk ?? 0;
    move_to( command.param.pos, 0, { #command:command, #forcewalk:forcewalk } );
    self waittill( #"europa_move_to_end", result );
    move_to_end( command );
}

// Namespace europa
// Params 1, eflags: 0xc
// Checksum 0xce727ba3, Offset: 0x3cae
// Size: 0x188
function private watch_stuck_thread( command )
{
    self notify( #"hash_e28d3d1dd765fbdf" );
    self endon( #"hash_e28d3d1dd765fbdf" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"europa_deactivated" );
    var_660fd9d12a02b694 = 2500;
    var_fda14830399a1e84 = 4096;
    const_stuck_timeout = 10;
    targetpos = command.param.pos;
    
    while ( true )
    {
        starttime = gettime();
        startpos = self.origin;
        msg = utility::waittill_any_timeout( const_stuck_timeout, "europa_move_to_end", "europa_on_move_command_end", "europa_fake_stuck" );
        
        if ( msg == "europa_fake_stuck" || !command.iscancelled && !europa_hover::is_hovering() && gettime() - starttime > 1000 && distancesquared( self.origin, targetpos ) > var_fda14830399a1e84 && distancesquared( startpos, self.origin ) < var_660fd9d12a02b694 )
        {
            message = function_6ab0868abe41859b( "command " + command.type + ":" + msg );
            logstring( message );
            europa_hover::function_71a68ebe6054d93f();
            thread function_84919f8f8db67077( targetpos );
            return;
        }
        
        if ( msg != "timeout" )
        {
            return;
        }
    }
}

// Namespace europa
// Params 1
// Checksum 0x2bc29dc2, Offset: 0x3e3e
// Size: 0x291
function function_6ab0868abe41859b( srctype )
{
    owner = get_owner();
    message = "[EUROPA] AI got stucked : " + srctype + ", origin: " + self.origin + ", origin reachable: " + is_pos_reachable( self.origin ) + ", ownerOrigin: " + ( owner.origin ?? "undefined" ) + ", linked: " + self islinked() + ", in_hover_thread: " + self.europa.var_fa2f23c9ef92d618 + ", hovering_to_target: " + ( self.europa.hovering_to_target ?? 0 ) + ", hoverMover: " + isdefined( self.europa.hovermover ) + ", landPos: " + self.europa.var_295bd1f82638b81f + ", asm state: " + europa_asm::function_972cfe27021b9096() + ":" + europa_asm::get_current_asm_state() + ", current action: " + self.europa.var_6481e81eb38197de + ", is_operating: " + self.europa.operating;
    
    if ( self.europa.var_865efc00faa1dd36 )
    {
        message += ", hoverType: " + self.europa.var_865efc00faa1dd36.type + ", sourceOrigin: " + self.europa.var_865efc00faa1dd36.sourceorigin + ", source reachable: " + is_pos_reachable( self.europa.var_865efc00faa1dd36.sourceorigin ) + ", targetOrigin: " + self.europa.var_865efc00faa1dd36.target.origin + ", target reachable: " + is_pos_reachable( self.europa.var_865efc00faa1dd36.target.origin ) + ", startTime: " + self.europa.var_865efc00faa1dd36.starttime + ", now: " + gettime() + ", command: " + self.europa.var_865efc00faa1dd36.command.type;
    }
    else
    {
        message += ", hoverParams: undefined";
    }
    
    return message;
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xe0e850a4, Offset: 0x40d8
// Size: 0x5d
function private move_to_end( command )
{
    target = spawnstruct();
    target.origin = command.param.pos;
    set_target( "defend_pos", target );
    thread remove_command( command.id );
}

// Namespace europa
// Params 5, eflags: 0x4
// Checksum 0xae3fe1b, Offset: 0x413d
// Size: 0x76
function private get_proximity_score( currentpos, targetpos, minscore, maxscore, maxdist )
{
    if ( !isdefined( currentpos ) || !isdefined( targetpos ) )
    {
        return 0;
    }
    
    distance = distance( currentpos, targetpos );
    
    if ( distance > maxdist )
    {
        distance = maxdist;
    }
    
    ratio = distance / maxdist;
    return maxscore - ratio * ( maxscore - minscore );
}

// Namespace europa
// Params 1
// Checksum 0xd714dc14, Offset: 0x41bc
// Size: 0xb1
function play_vo( var_9cf8c1e6c568eb81 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( has_cool_down( var_9cf8c1e6c568eb81 ) || has_cool_down( "play_vo" ) )
    {
        return;
    }
    
    vo = get_vo_data( var_9cf8c1e6c568eb81 );
    
    if ( vo.chance < 1 && randomfloatrange( 0, 1 ) > vo.chance )
    {
        return;
    }
    
    start_cool_down( "play_vo" );
    start_cool_down( var_9cf8c1e6c568eb81 );
    self setscriptablepartstate( "sound_vo", var_9cf8c1e6c568eb81 );
    wait 10;
    self setscriptablepartstate( "sound_vo", "off" );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x338acf52, Offset: 0x4275
// Size: 0xe8
function private on_activate( param )
{
    if ( !param.owner )
    {
        logstring( "[EUROPA] Owner not exist. Failed to activate" );
        return;
    }
    
    logstring( "[EUROPA] on_activate" );
    
    if ( europa_asm::is_playing() )
    {
        self function_786bb6aa1b76c7ee( "move_to_type", "none" );
        
        if ( param.standup )
        {
            europa_asm::exit_cap();
            europa_asm::function_8f949c842782e6ff( 3 );
            callback::callback( #"hash_8e420a8ff3313166", { #europa:self, #owner:param.owner } );
        }
    }
    else
    {
        if ( asm_bb::bb_isanimscripted() )
        {
            europa_asm::function_4d732b0c87bec23e();
        }
        
        function_11308ac9cf87dd0c( param.owner.origin );
        europa_asm::play_cap( "europa_activate", "cap_europa_activate" );
    }
    
    activate( param.owner );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x4dc97886, Offset: 0x4365
// Size: 0x1e
function private on_deactivate( param )
{
    if ( is_activated() )
    {
        thread function_6195dc641a32aef( param );
    }
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xce1527bf, Offset: 0x438b
// Size: 0x18
function private function_bf6341a86c399f62( params )
{
    thread play_vo( "arrival" );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x97b5e5b8, Offset: 0x43ab
// Size: 0x173
function private function_6195dc641a32aef( param )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.europa.deactivating = 1;
    function_47761cd429bc0244();
    deactivate();
    thread play_vo( "departure" );
    
    if ( !param.var_1e16f21a93bcbe7f )
    {
        timeouttime = gettime() + utility::function_4b74c15943231980( 15 );
        
        while ( gettime() < timeouttime )
        {
            if ( !function_6f53dbd8c6a86e93( self.origin ) )
            {
                break;
            }
            
            if ( !self.europa.moving )
            {
                pos = function_2e6b9adc1abf7589( self.origin, 0, 100 );
                move_to( pos, 0, { #forcewalk:1 } );
            }
            
            wait 0.5;
        }
    }
    
    returntype = "fly";
    
    if ( function_6f53dbd8c6a86e93( self.origin ) )
    {
        thread function_84919f8f8db67077( self.europa.var_c7d8e93b2ec585f.origin + ( 0, 0, 3000 ), 0.5 );
        returntype = "land";
    }
    
    var_c7d8e93b2ec585f = self.europa.var_c7d8e93b2ec585f;
    return_to_chair( returntype );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x4e4588c7, Offset: 0x4526
// Size: 0xaf
function private function_ffa82f4c776a8a25( param )
{
    owner = param.owner;
    
    if ( !owner )
    {
        assertmsg( "<dev string:x7c>" );
        return;
    }
    
    var_ae32e7f69262149 = self.aisettings.specificaisettings.var_ae32e7f69262149 ?? 0;
    var_ac0207f68ffbac7 = self.aisettings.specificaisettings.var_ac0207f68ffbac7 ?? 0;
    fly_to_target( owner, owner.origin, owner.angles, var_ae32e7f69262149, var_ac0207f68ffbac7 );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x518b7e51, Offset: 0x45dd
// Size: 0x9d
function private function_523a117bbae53962( param )
{
    if ( !can_think() )
    {
        return;
    }
    
    clear_defend_targets();
    command = add_command( #"hash_5b8a88a5b8ddb5a8", param );
    thread play_vo( "direction" );
    
    if ( namespace_daf15362c2bc6ee0::is_operating() && !namespace_daf15362c2bc6ee0::is_operate_begin() )
    {
        namespace_daf15362c2bc6ee0::stop_operate();
    }
    
    if ( namespace_daf15362c2bc6ee0::function_170c09b0fa122f9a( param.pos ) )
    {
        thread function_94aaf145ca4ddfbf( command );
        namespace_daf15362c2bc6ee0::function_74492292e039960b( param.pos );
        return;
    }
    
    thread function_d1bcfe9f51dccd4e( command );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x5be032d8, Offset: 0x4682
// Size: 0x39
function private function_14c31762168cbf23( params )
{
    clear_defend_targets();
    command = add_command( #"hash_a81108c3938eece5", params );
    thread function_d1bcfe9f51dccd4e( command );
}

// Namespace europa
// Params 1, eflags: 0xc
// Checksum 0xa9080cf2, Offset: 0x46c3
// Size: 0x79
function private function_94aaf145ca4ddfbf( command )
{
    self notify( #"hash_b77d243f847d198f" );
    self endon( #"hash_b77d243f847d198f" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( command )
    {
        command endon( #"europa_command_end" );
    }
    
    thread watch_stuck_thread( command );
    self waittill( #"hash_6581f960ad6a757", var_386c01eb444cabb9 );
    move_to_end( command );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x9cff56c, Offset: 0x4744
// Size: 0x13
function private function_e1a9cc50addd5eb5( param )
{
    clear_defend_targets();
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xabce7181, Offset: 0x475f
// Size: 0x18
function private function_dc7e174d7036978d( param )
{
    thread play_vo( "combat_chat" );
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x55f94356, Offset: 0x477f
// Size: 0x3b
function private on_first_init( param )
{
    if ( !level callback::exists( #"player_disconnect", &on_player_disconnect ) )
    {
        level callback::add( #"player_disconnect", &on_player_disconnect );
    }
}

// Namespace europa
// Params 1
// Checksum 0x547c409, Offset: 0x47c2
// Size: 0xf6
function on_saw_blade_trap_hit( params )
{
    if ( is_script_animation() )
    {
        return;
    }
    
    var_359a765be5422f83 = params.trap;
    v_knock_dir = ( self.origin[ 0 ], self.origin[ 1 ], 0 ) - ( var_359a765be5422f83.origin[ 0 ], var_359a765be5422f83.origin[ 1 ], 0 );
    bladeheight = 50;
    fx = utility::getfx( "vfx_europa_spark" );
    v_knock_dir = vectornormalize2( v_knock_dir );
    hitpos = ( self.origin[ 0 ], self.origin[ 1 ], var_359a765be5422f83.origin[ 2 ] + bladeheight );
    playfx( fx, hitpos, vectortoangles( v_knock_dir * -1 ) );
    self playsound( "vehicle_body_hit" );
    thread function_76e348ec03558858( v_knock_dir, 60, 0.1 );
}

// Namespace europa
// Params 3
// Checksum 0xfa85b385, Offset: 0x48c0
// Size: 0x126
function function_76e348ec03558858( dir, distance, time )
{
    level endon( #"game_ended" );
    clear_goal_pos();
    dir = vectornormalize2( dir );
    overridecontents = trace::create_contents( 0, 1, 1, 1 );
    start = self.origin + ( 0, 0, self.height );
    result = trace::ray_trace( start, start + dir * distance, [ self ], overridecontents );
    
    if ( result[ "fraction" ] < 1 )
    {
        dir += result[ "normal" ];
        dir = vectornormalize2( dir );
    }
    
    targetpos = self.origin + dir * distance;
    mover = utility::spawn_model( "tag_origin", self.origin );
    self motionwarpcancel();
    self linkto( mover );
    mover moveto( targetpos, time );
    wait time;
    self setbtgoalpos( 3, targetpos );
    self clearpath();
    self motionwarpcancel();
    self unlink();
    mover delete();
}

// Namespace europa
// Params 1
// Checksum 0x4e42fba5, Offset: 0x49ee
// Size: 0x67
function on_player_disconnect( params )
{
    europa = self.allyeuropa;
    
    if ( europa && europa is_activated() && !europa.europa.var_32654821162ebb16 )
    {
        europa utility::callsharedfunc( #"europa", #"hash_128edca9c946949c" );
    }
}

// Namespace europa
// Params 1
// Checksum 0xb7145872, Offset: 0x4a5d
// Size: 0x1c
function europa_init( taskid )
{
    init();
    return anim.success;
}

// Namespace europa
// Params 1
// Checksum 0xa7a98f0c, Offset: 0x4a82
// Size: 0x1b
function function_a8c5ce376e8c60b6( taskid )
{
    if ( function_91a12ec19e0f813f( taskid ) )
    {
        return 20;
    }
    
    return 0;
}

// Namespace europa
// Params 1
// Checksum 0x73751747, Offset: 0x4aa6
// Size: 0x75
function function_a5d232a2cfe53b06( taskid )
{
    if ( is_script_animation() )
    {
        return 0;
    }
    
    target = function_b8c0ff578e3412( "defend_ent" ) ?? function_b8c0ff578e3412( "defend_pos" );
    
    if ( isdefined( target ) )
    {
        if ( !is_pos_in_range( self.origin, target.origin, 500 ) )
        {
            set_target( "defend", target );
            return 30;
        }
    }
    
    return 0;
}

// Namespace europa
// Params 1
// Checksum 0x82d2bc3, Offset: 0x4b24
// Size: 0x1c8
function function_51c549c69d7d441( taskid )
{
    /#
        if ( getdvarint( @"hash_f5ee99eaad1fc8fa" ) )
        {
            return 0;
        }
    #/
    
    target = get_owner();
    
    if ( !target )
    {
        return 0;
    }
    
    if ( is_script_animation() )
    {
        return 0;
    }
    
    if ( target.vehicle && europa_hover::is_follow_vehicle() )
    {
        return 0;
    }
    
    var_5388b4087f2bda05 = 16384;
    var_7bc342855f050b97 = 65536;
    var_ce6093cfe0d10b5d = 100;
    var_ce3d9dcfe0aad9a3 = 300;
    followdistance = self.aisettings.specificaisettings.followplayerdistance;
    
    if ( !is_pos_in_range( self.origin, target.origin, followdistance ) )
    {
        followtarget = function_b8c0ff578e3412( "follow" );
        
        if ( !followtarget || !self.europa.var_3db40bc5e846ed31 || distancesquared( self.europa.var_3db40bc5e846ed31, target.origin ) > var_5388b4087f2bda05 || distancesquared( followtarget.origin, target.origin ) > var_7bc342855f050b97 )
        {
            pos = function_c698a4f9f4b345c5( target.origin, var_ce6093cfe0d10b5d, var_ce3d9dcfe0aad9a3 );
            
            if ( pos )
            {
                set_target( "follow", { #origin:pos } );
                self.europa.var_3db40bc5e846ed31 = target.origin;
            }
        }
        
        if ( !function_b8c0ff578e3412( "follow" ) )
        {
            return 0;
        }
        
        return 40;
    }
    
    return 0;
}

// Namespace europa
// Params 2
// Checksum 0x43337e74, Offset: 0x4cf5
// Size: 0x34
function europa_hastarget( taskid, param )
{
    if ( isdefined( function_b8c0ff578e3412( param ) ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 1
// Checksum 0xf76108e4, Offset: 0x4d32
// Size: 0x29
function function_1d647a483e1ffe24( taskid )
{
    if ( isdefined( get_goal_pos() ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 2
// Checksum 0x692b4d1f, Offset: 0x4d64
// Size: 0x54
function function_2fa52ac02446d99e( taskid, param )
{
    if ( !isstring( param ) )
    {
        assertmsg( "<dev string:xaa>" );
        return anim.failure;
    }
    
    if ( has_cool_down( param ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 2
// Checksum 0x8c1f37c8, Offset: 0x4dc1
// Size: 0x48
function function_22d946275ca731c2( taskid, param )
{
    if ( !isstring( param ) )
    {
        assertmsg( "<dev string:xcc>" );
        return anim.failure;
    }
    
    start_cool_down( param );
    return anim.success;
}

// Namespace europa
// Params 1
// Checksum 0xca8417af, Offset: 0x4e12
// Size: 0x28
function function_4729eb65e8433954( taskid )
{
    if ( is_activated() )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 2
// Checksum 0x7032b90a, Offset: 0x4e43
// Size: 0x60
function function_e05b335a40df6b8a( taskid, angle )
{
    target = function_bde59859a3c2c9e5();
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( is_facing_point( target.origin, angle ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 1
// Checksum 0x1b37c199, Offset: 0x4eac
// Size: 0x4c
function function_f782ba9c0f1fb0e9( taskid )
{
    target = function_bde59859a3c2c9e5();
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( is_target_in_last_stand( target ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 2
// Checksum 0x77448143, Offset: 0x4f01
// Size: 0x69
function europa_istargetinrange( taskid, range )
{
    target = function_bde59859a3c2c9e5();
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( is_pos_in_range( self.origin, target.origin, range ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace europa
// Params 2
// Checksum 0xc83fd82c, Offset: 0x4f73
// Size: 0xaf
function function_41ca44a5bd6dc448( taskid, radius )
{
    if ( is_script_animation() || has_command() || self.europa.var_fa2f23c9ef92d618 )
    {
        return anim.failure;
    }
    
    target = function_bde59859a3c2c9e5();
    
    if ( target.origin )
    {
        if ( !is_pos_reachable( target.origin ) )
        {
            return anim.failure;
        }
        
        move_to( target.origin, radius );
    }
    
    set_target( taskid, target );
    return anim.success;
}

// Namespace europa
// Params 2
// Checksum 0x5da0abb1, Offset: 0x502b
// Size: 0x28
function function_e352a66ec33ed22d( taskid, param )
{
    set_target( taskid, undefined );
    return anim.success;
}

// Namespace europa
// Params 2
// Checksum 0xfc5ccb57, Offset: 0x505c
// Size: 0x153
function function_6b421383e65d9c49( taskid, param )
{
    target = function_b8c0ff578e3412( taskid );
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( self.var_1814c21e4ca79288 )
    {
        return anim.failure;
    }
    
    goalpos = get_goal_pos();
    
    if ( !isdefined( goalpos ) )
    {
        if ( !is_script_animation() )
        {
            return anim.failure;
        }
    }
    else
    {
        if ( self.europa.moving )
        {
            if ( self.europa.var_fa2f23c9ef92d618 )
            {
                return anim.running;
            }
            
            if ( !isdefined( param ) )
            {
                param = 0;
            }
            
            if ( distancesquared( goalpos, target.origin ) > squared( param + 100 ) )
            {
                move_to( target.origin, param );
                goalpos = get_goal_pos();
            }
            
            if ( function_6619dc1ddecded7d( goalpos ) )
            {
                return anim.failure;
            }
            
            return anim.running;
        }
        
        var_fe1dbf500eba53c1 = squared( 50 );
        
        if ( isdefined( goalpos ) && distancesquared( goalpos, self.origin ) < var_fe1dbf500eba53c1 )
        {
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace europa
// Params 1
// Checksum 0x76272dc8, Offset: 0x51b8
// Size: 0xb7
function function_c5b758cbba6b0e34( taskid )
{
    if ( is_script_animation() || has_command() )
    {
        return anim.failure;
    }
    
    target = function_bde59859a3c2c9e5();
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( !is_pos_reachable( target.origin ) )
    {
        return anim.failure;
    }
    
    if ( !get_goal_pos() || !is_pos_in_range( get_goal_pos(), target.origin, 64 ) )
    {
        set_goal_pos( target.origin );
        set_target( taskid, target );
    }
    
    return anim.success;
}

// Namespace europa
// Params 1
// Checksum 0xe609bd2f, Offset: 0x5278
// Size: 0x3e
function function_27be26fa9f9b58f0( taskid )
{
    if ( self.europa.commands.size > 0 || namespace_daf15362c2bc6ee0::is_operating() || !can_think() )
    {
        return 100;
    }
    
    return 0;
}

// Namespace europa
// Params 1
// Checksum 0xfad3a594, Offset: 0x52bf
// Size: 0x15
function function_dcd3023545b550c0( taskid )
{
    return anim.success;
}

// Namespace europa
// Params 1
// Checksum 0xe1272dbb, Offset: 0x52dd
// Size: 0x123
function function_91a12ec19e0f813f( taskid )
{
    /#
        if ( getdvarint( @"hash_7500985348badbdf" ) )
        {
            return anim.failure;
        }
    #/
    
    if ( !self.enemy )
    {
        return anim.failure;
    }
    
    if ( namespace_daf15362c2bc6ee0::is_operating() )
    {
        return anim.failure;
    }
    
    enemies = utility::callsharedfunc( #"zombie", #"get_round_enemies" );
    
    if ( enemies )
    {
        if ( enemies.size <= 1 )
        {
            foreach ( enemy in enemies )
            {
                if ( enemy == self.enemy )
                {
                    return anim.failure;
                }
            }
        }
    }
    
    set_target( "combat", self.enemy );
    return anim.success;
}

// Namespace europa
// Params 1
// Checksum 0x3d3bd2ee, Offset: 0x5409
// Size: 0x28a
function function_71a84d01402b3b47( taskid )
{
    if ( self.europa.moving || is_script_animation() || has_command() )
    {
        return anim.success;
    }
    
    if ( self.enemy )
    {
        if ( !self cansee( self.enemy ) || !self.baimedataimtarget )
        {
            if ( self.enemy != self.europa.var_1c3497d519561530 )
            {
                self.europa.var_1c3497d519561530 = self.enemy;
                self.europa.var_bb547cf0e9818979 = gettime();
            }
            
            if ( !has_cool_down( "strategically_move" ) && gettime() - self.europa.var_bb547cf0e9818979 > 2000 )
            {
                var_efc221dde4d01dec = 10000;
                move_away_dis = 100;
                posoffset = ( 0, 0, 0 );
                owner = get_owner();
                
                if ( !owner )
                {
                    return anim.failure;
                }
                
                if ( distancesquared( self.origin, owner.origin ) < var_efc221dde4d01dec )
                {
                    dir = vectornormalize2( self.origin - owner.origin );
                    posoffset = dir * move_away_dis;
                }
                
                dirtoenemy = vectornormalize2( self.enemy.origin - self.origin );
                sign = randomintrange( 0, 2 ) ? 1 : -1;
                newdir = rotatepointaroundvector( ( 0, 0, 1 ), dirtoenemy, sign * randomfloatrange( 60, 120 ) );
                pos = self.origin + newdir * randomfloatrange( 100, 150 ) + posoffset;
                newlocation = getclosestpointonnavmesh( pos );
                
                if ( !is_pos_reachable( newlocation ) )
                {
                    return anim.success;
                }
                
                move_to( newlocation, 50 );
                start_cool_down( "strategically_move" );
            }
        }
        else
        {
            self.europa.var_1c3497d519561530 = undefined;
            self.europa.var_bb547cf0e9818979 = 0;
        }
    }
    
    return anim.success;
}

// Namespace europa
// Params 2
// Checksum 0x9bc49588, Offset: 0x569c
// Size: 0x66
function function_2da32337abdd390a( taskid, var_469072f93ecbd83b )
{
    self.europa.var_6481e81eb38197de = var_469072f93ecbd83b;
    target = function_b8c0ff578e3412( var_469072f93ecbd83b );
    
    if ( isdefined( target ) )
    {
        function_957083fb057ca11( target );
    }
    
    callback::callback( function_a4859357bdc15f92( var_469072f93ecbd83b ) );
    return anim.success;
}

// Namespace europa
// Params 2
// Checksum 0x88bf8bb9, Offset: 0x570b
// Size: 0x4a
function function_94156d244d7b36bf( taskid, var_469072f93ecbd83b )
{
    set_target( var_469072f93ecbd83b, undefined );
    callback::callback( function_8d0b7818fc98dbab( var_469072f93ecbd83b ) );
    self.europa.var_6481e81eb38197de = undefined;
    return anim.success;
}

// Namespace europa
// Params 2
// Checksum 0xce65327e, Offset: 0x575e
// Size: 0x28
function function_2c7dbdc420ea6927( taskid, angle )
{
    set_target( taskid, undefined );
    return anim.success;
}

// Namespace europa
// Params 2
// Checksum 0x24b0b635, Offset: 0x578f
// Size: 0x5b
function function_4408c9b716fe3482( taskid, angle )
{
    target = function_bde59859a3c2c9e5();
    
    if ( !target )
    {
        return anim.failure;
    }
    
    set_target( taskid, target );
    self setlookat( target.origin );
    return anim.running;
}

// Namespace europa
// Params 2
// Checksum 0x28234ae0, Offset: 0x57f3
// Size: 0x78
function function_bbddcba89a86e4d3( taskid, angle )
{
    target = function_b8c0ff578e3412( taskid );
    
    if ( !target )
    {
        return anim.failure;
    }
    
    self orientmode( "face point", target.origin );
    
    if ( is_facing_point( target.origin, angle ) )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace europa
// Params 1
// Checksum 0x7b90ed79, Offset: 0x5874
// Size: 0xe7
function function_f26c2eddc175800d( taskid )
{
    /#
        if ( getdvarint( @"hash_d0a8d239e248dab2", 0 ) )
        {
            return 0;
        }
    #/
    
    if ( isdefined( self.enemy ) )
    {
        return 0;
    }
    
    if ( has_cool_down( "wander" ) )
    {
        return 0;
    }
    
    if ( is_script_animation() )
    {
        return 0;
    }
    
    wandertarget = get_defend_target();
    
    if ( !wandertarget )
    {
        wandertarget = get_owner();
        
        if ( !wandertarget )
        {
            return 0;
        }
    }
    
    origin = wandertarget.origin;
    var_d2ab79f3e2c1fb10 = 100;
    var_d2886ff3e29b9d5a = 300;
    
    if ( !function_b8c0ff578e3412( "wander" ) )
    {
        targetpos = function_c698a4f9f4b345c5( origin, var_d2ab79f3e2c1fb10, var_d2886ff3e29b9d5a );
        
        if ( !targetpos )
        {
            return 0;
        }
        
        set_target( "wander", { #origin:targetpos } );
    }
    
    return 10;
}

// Namespace europa
// Params 3
// Checksum 0xdf1f41f0, Offset: 0x5964
// Size: 0x11b
function function_c698a4f9f4b345c5( origin, radiusmin, radiusmax )
{
    const_search_count = 3;
    var_707a3445d2aa65d9 = 128;
    overridecontents = trace::create_contents( 0, 1, 1, 1 );
    var_ec6b09ce744f2c23 = function_6f53dbd8c6a86e93( origin );
    traceoffset = ( 0, 0, 30 );
    
    for ( i = 0; i < const_search_count ; i++ )
    {
        randpos = function_81bb9d06d0c4a338( origin, radiusmin, radiusmax );
        
        if ( !is_pos_reachable( randpos ) )
        {
            continue;
        }
        
        if ( abs( randpos[ 2 ] - origin[ 2 ] ) > var_707a3445d2aa65d9 )
        {
            continue;
        }
        
        result = trace::ray_trace( origin + traceoffset, randpos + traceoffset, [ self ], overridecontents );
        
        if ( result[ "fraction" ] < 0.95 )
        {
            continue;
        }
        
        var_fc1a3cd1d0106944 = function_6f53dbd8c6a86e93( randpos );
        
        if ( var_fc1a3cd1d0106944 != var_ec6b09ce744f2c23 )
        {
            continue;
        }
        
        return randpos;
    }
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x406af1a3, Offset: 0x5a88
// Size: 0x370
function private function_9440c2ef9b648e3f( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    player = params.player;
    europa = player.allyeuropa;
    
    if ( !isdefined( europa ) || !europa can_think() )
    {
        return;
    }
    
    if ( europa namespace_daf15362c2bc6ee0::is_operating() && !europa namespace_daf15362c2bc6ee0::is_operate_begin() )
    {
        europa namespace_daf15362c2bc6ee0::stop_operate();
    }
    
    calloutent = player calloutmarkerping_getent( params.pingindex );
    
    if ( isdefined( calloutent ) )
    {
        if ( calloutent.origin && !europa is_pos_reachable( calloutent.origin ) )
        {
            return;
        }
        
        if ( isai( calloutent ) && calloutent.team != europa.team && isalive( calloutent ) )
        {
            europa function_3953751a50269d5a( calloutent );
        }
        else if ( player is_goal_in_range( calloutent.origin ) && europa namespace_daf15362c2bc6ee0::function_170c09b0fa122f9a( calloutent ) )
        {
            europa thread play_vo( "direction" );
            command = { #param:{ #pos:calloutent.origin }, #type:#"hash_a81108c3938eece5" };
            europa thread watch_stuck_thread( command );
            europa namespace_daf15362c2bc6ee0::function_74492292e039960b( calloutent );
        }
        
        return;
    }
    
    calloutorigin = player calloutmarkerping_getorigin( params.pingindex );
    
    if ( isdefined( calloutorigin ) && calloutorigin != ( 0, 0, 0 ) )
    {
        pingoffset = ( 0, 0, -64 );
        pingpos = calloutorigin + pingoffset;
        pos = getclosestpointonnavmesh( pingpos, europa );
        
        if ( !europa is_pos_reachable( pos ) )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"scr_europa_remote_debug_draw" ) )
            {
                var_d5771d526bfbbcb6 = 100;
                sphere( calloutorigin, 5, ( 1, 0, 0 ), 0, var_d5771d526bfbbcb6 );
                sphere( pingpos, 5, ( 1, 1, 0 ), 0, var_d5771d526bfbbcb6 );
                sphere( pos, 5, ( 0, 1, 0 ), 0, var_d5771d526bfbbcb6 );
            }
        #/
        
        if ( !pos || !player is_goal_in_range( pos ) || !europa isposreachable( pos ) )
        {
            return;
        }
        
        europa thread play_vo( "direction" );
        
        if ( europa namespace_daf15362c2bc6ee0::function_170c09b0fa122f9a( pos ) )
        {
            command = { #param:{ #pos:pos }, #type:#"hash_a81108c3938eece5" };
            europa thread watch_stuck_thread( command );
            europa namespace_daf15362c2bc6ee0::function_74492292e039960b( pos );
        }
        else
        {
            europa utility::callsharedfunc( #"europa", #"hash_a81108c3938eece5", { #pos:pos, #owner:player } );
        }
        
        /#
            if ( getdvarint( @"hash_e89da6e7b7cf282e", 0 ) )
            {
                inbuilding = function_6f53dbd8c6a86e93( pos );
                debug_utility::drawsphere( pos, 5, 1, inbuilding ? ( 0, 0, 1 ) : ( 0, 1, 0 ) );
            }
        #/
        
        return;
    }
    
    europa clear_goal_pos();
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0xc693d7e1, Offset: 0x5e00
// Size: 0x56
function private function_469402018352ab3a( params )
{
    europa = self.allyeuropa;
    
    if ( !isdefined( europa ) )
    {
        return;
    }
    
    calloutent = self calloutmarkerping_getent( params.pingindex );
    
    if ( isai( calloutent ) )
    {
        europa function_275c1fdf83748df1( calloutent );
    }
}

// Namespace europa
// Params 1
// Checksum 0xb27e3208, Offset: 0x5e5e
// Size: 0x91, Type: bool
function is_goal_in_range( goalpos )
{
    if ( isdefined( goalpos ) && isdefined( self.allyeuropa ) )
    {
        range = self.allyeuropa.aisettings.specificaisettings.var_7d9c12dff7064129 ?? 1000;
        
        /#
            rangeoverride = getdvarint( @"scr_europa_remote_control_range" );
            
            if ( rangeoverride )
            {
                range = rangeoverride;
            }
        #/
        
        return ( distancesquared( goalpos, self.origin ) < range * range );
    }
    
    return false;
}

// Namespace europa
// Params 1, eflags: 0x4
// Checksum 0x89133ae9, Offset: 0x5ef8
// Size: 0x59
function private function_e958301156bf64be( params )
{
    if ( level.europa && level.europa has_cool_down( "recharge" ) )
    {
        level.europa clear_cool_down( "recharge" );
        level.europa notify( #"europa_recharge_finished" );
    }
}

/#

    // Namespace europa
    // Params 0
    // Checksum 0xcc2ca8b8, Offset: 0x5f59
    // Size: 0x9c, Type: dev
    function dev_get_player()
    {
        if ( isdefined( level.player ) )
        {
            return level.player;
        }
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace europa
    // Params 0
    // Checksum 0xe301f062, Offset: 0x5ffd
    // Size: 0x261, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xf0>" );
        devgui::add_devgui_func( "<dev string:x101>", "<dev string:x107>", &devgui_spawn, 0, 0 );
        devgui::add_devgui_func( "<dev string:x10d>", "<dev string:x11e>", &devgui_activate, 0, 10 );
        devgui::add_devgui_func( "<dev string:x127>", "<dev string:x137>", &function_e6ca81dac610caf6, 0, 11 );
        devgui::add_devgui_func( "<dev string:x148>", "<dev string:x15b>", &devgui_deactivate, 0, 12 );
        devgui::add_devgui_func( "<dev string:x166>", "<dev string:x17c>", &function_2219762698f9ccae, 0, 13 );
        devgui::add_devgui_func( "<dev string:x18a>", "<dev string:x1a2>", &function_b4f411b5498e9941, 0, 14 );
        devgui::add_devgui_func( "<dev string:x1b2>", "<dev string:x1cd>", &function_bca35d59953078aa, 0, 15 );
        devgui::add_devgui_func( "<dev string:x1e0>", "<dev string:x1f8>", &devgui_return_to_chair, 0, 16 );
        devgui::add_devgui_func( "<dev string:x208>", "<dev string:x22b>", &function_dfd3d9b92f8edcea, 1, 100 );
        devgui::add_devgui_func( "<dev string:x248>", "<dev string:x25d>", &function_da2d1ba098d18302, 0, 101 );
        devgui::add_devgui_func( "<dev string:x26c>", "<dev string:x282>", &function_419e139bf1745f4d, 0, 102 );
        devgui::add_devgui_func( "<dev string:x292>", "<dev string:x2a5>", &devgui_toggle_think, 1, 103 );
        devgui::add_devgui_func( "<dev string:x2b2>", "<dev string:x2d1>", &function_e958301156bf64be, 0, 104 );
        devgui::add_devgui_func( "<dev string:x2ea>", "<dev string:x301>", &function_3c385d6b8bfbb563, 1, 105 );
        devgui::add_devgui_func( "<dev string:x312>", "<dev string:x323>", &function_19133d58623d1be7, 0, 106 );
        devgui::add_devgui_func( "<dev string:x32e>", "<dev string:x33f>", &function_6304013994cd9fde, 1 );
        devgui::add_devgui_func( "<dev string:x34d>", "<dev string:x358>", &function_4aba939baa1aa300, 0 );
        devgui::add_devgui_func( "<dev string:x368>", "<dev string:x375>", &function_449bf0a73b9aae81, 0 );
        devgui::add_devgui_func( "<dev string:x387>", "<dev string:x396>", &function_a9067b2baed7329a, 0 );
        devgui::add_devgui_func( "<dev string:x3aa>", "<dev string:x3b7>", &function_277b34a7e01725a4, 0 );
        devgui::add_devgui_func( "<dev string:x3c9>", "<dev string:x3d4>", &function_39517f0de03af76e, 0 );
        devgui::add_devgui_func( "<dev string:x3e4>", "<dev string:x3f4>", &function_4881f3a55e7718f9, 0 );
        devgui::add_devgui_func( "<dev string:x409>", "<dev string:x41b>", &function_6e6ed07d7b7ef1a1, 0 );
        devgui::add_devgui_func( "<dev string:x432>", "<dev string:x445>", &function_a4721788b8eaf89b, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace europa
    // Params 0
    // Checksum 0xa7e09b23, Offset: 0x6266
    // Size: 0xbb, Type: dev
    function devgui_spawn()
    {
        owner = dev_get_player();
        origin = devgui::function_97024c0a6d1256a6();
        type = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( "<dev string:x45d>" )[ 0 ];
        europa = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( type, origin, ( 0, 0, 0 ), owner.team );
        europa activate( owner );
        europa callback::callback( #"hash_8e420a8ff3313166", { #europa:europa, #owner:owner } );
        europa set_rest_location( europa.origin, europa.angles );
    }

    // Namespace europa
    // Params 0
    // Checksum 0x32c6d4ad, Offset: 0x6329
    // Size: 0x6b, Type: dev
    function devgui_activate()
    {
        if ( level.europa && !level.europa is_activated() )
        {
            params = spawnstruct();
            params.owner = dev_get_player();
            level.europa utility::callsharedfunc( #"europa", #"hash_cc6a196accc3d6bf", params );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x8a16d134, Offset: 0x639c
    // Size: 0x89, Type: dev
    function function_e6ca81dac610caf6()
    {
        if ( level.europa && !level.europa is_activated() )
        {
            params = spawnstruct();
            params.owner = dev_get_player();
            params.standup = 1;
            level.europa utility::callsharedfunc( #"europa", #"hash_cc6a196accc3d6bf", params );
            level.europa clear_goal_pos();
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x1869b8de, Offset: 0x642d
    // Size: 0x46, Type: dev
    function devgui_deactivate()
    {
        if ( level.europa && level.europa is_activated() )
        {
            level.europa utility::callsharedfunc( #"europa", #"hash_128edca9c946949c" );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0xa4763876, Offset: 0x647b
    // Size: 0x57, Type: dev
    function function_2219762698f9ccae()
    {
        if ( level.europa )
        {
            params = spawnstruct();
            params.owner = dev_get_player();
            level.europa utility::callsharedfunc( #"europa", #"hash_5c619c99b9d2e4bb", params );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x2ad79c66, Offset: 0x64da
    // Size: 0x79, Type: dev
    function function_bca35d59953078aa()
    {
        if ( level.europa )
        {
            owner = level.europa get_owner();
            fwd = anglestoforward( owner.angles );
            level.europa thread utility::callsharedfunc( #"europa", #"hash_f5532cc95bd8a217", owner.origin + fwd * 500 );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x360efa87, Offset: 0x655b
    // Size: 0x33, Type: dev
    function devgui_return_to_chair()
    {
        if ( level.europa )
        {
            level.europa utility::callsharedfunc( #"europa", #"hash_5a10c74557470ade" );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0xd743c498, Offset: 0x6596
    // Size: 0xe8, Type: dev
    function function_b4f411b5498e9941()
    {
        player = dev_get_player();
        player_forward = anglestoforward( player getplayerangles() );
        result = trace::ray_trace( player geteye(), player geteye() + player_forward * 10000 );
        
        if ( isdefined( result[ "<dev string:x46c>" ] ) && result[ "<dev string:x475>" ] < 1 )
        {
            new_pos = utility::drop_to_ground( result[ "<dev string:x46c>" ] + -1 * player_forward * 32, 24, -300 ) + ( 0, 0, 16 );
            params = spawnstruct();
            params.owner = player;
            params.pos = new_pos;
            level.europa utility::callsharedfunc( #"europa", #"hash_a81108c3938eece5", params );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x30233238, Offset: 0x6686
    // Size: 0x33, Type: dev
    function function_da2d1ba098d18302()
    {
        if ( level.europa )
        {
            if ( level.europa europa_asm::is_playing() )
            {
                level.europa europa_asm::exit_cap();
            }
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0xa2ca4348, Offset: 0x66c1
    // Size: 0x43, Type: dev
    function devgui_toggle_think()
    {
        if ( level.europa )
        {
            level.europa utility::callsharedfunc( #"europa", #"hash_c3e2334e7794ce1a", !level.europa can_think() );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x8f2a7a4, Offset: 0x670c
    // Size: 0x51, Type: dev
    function function_dfd3d9b92f8edcea()
    {
        if ( level.europa )
        {
            level.europa utility::callsharedfunc( #"europa", #"hash_f611d6f3acf4e752", !level.europa.europa.var_32654821162ebb16 );
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x7badd3cd, Offset: 0x6765
    // Size: 0x51, Type: dev
    function function_419e139bf1745f4d()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x47e>", @"hash_ab97e6d8337d3740" );
        
        if ( getdvarint( @"hash_ab97e6d8337d3740" ) )
        {
            level.europa thread function_4f6e100a3c7c05e4();
            return;
        }
        
        level.europa notify( #"hash_6db8eb7e73fd84b" );
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0xd936f335, Offset: 0x67be
    // Size: 0xbb, Type: dev
    function private function_4f6e100a3c7c05e4()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"hash_6db8eb7e73fd84b" );
        
        while ( true )
        {
            enemy = self.enemy;
            
            if ( enemy )
            {
                sphere( enemy getapproxeyepos(), 2.5, ( 1, 0, 0 ) );
                
                if ( enemy tagexists( "<dev string:x49f>" ) )
                {
                    sphere( enemy gettagorigin( "<dev string:x49f>" ), 2.5, ( 0, 1, 0 ) );
                }
                
                sphere( enemy.origin, 2.5, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0xa0767562, Offset: 0x6881
    // Size: 0x1c, Type: dev
    function private debug_on_ai_spawned()
    {
        if ( getdvarint( @"hash_ab97e6d8337d3740" ) )
        {
            function_4f6e100a3c7c05e4();
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x38274275, Offset: 0x68a5
    // Size: 0x64, Type: dev
    function private function_6304013994cd9fde()
    {
        if ( level.europa )
        {
            if ( level.europa utility::function_9f2c41c1dcc8c94( "<dev string:x11e>", "<dev string:x4a7>" ) )
            {
                level.europa utility::function_7c10ea82c1e305b8( "<dev string:x11e>", "<dev string:x4b3>" );
                return;
            }
            
            level.europa utility::function_7c10ea82c1e305b8( "<dev string:x11e>", "<dev string:x4a7>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x50fb0866, Offset: 0x6911
    // Size: 0x26, Type: dev
    function private function_4aba939baa1aa300()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4bd>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x84c1a4d3, Offset: 0x693f
    // Size: 0x26, Type: dev
    function private function_449bf0a73b9aae81()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4c5>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0xdffae6cc, Offset: 0x696d
    // Size: 0x26, Type: dev
    function private function_a9067b2baed7329a()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4cf>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0xff62b311, Offset: 0x699b
    // Size: 0x26, Type: dev
    function private function_277b34a7e01725a4()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4db>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x631c9726, Offset: 0x69c9
    // Size: 0x26, Type: dev
    function private function_39517f0de03af76e()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4e5>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x2ca5b61, Offset: 0x69f7
    // Size: 0x26, Type: dev
    function private function_4881f3a55e7718f9()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4ed>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x5f1b59aa, Offset: 0x6a25
    // Size: 0x26, Type: dev
    function private function_6e6ed07d7b7ef1a1()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x4fa>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x381a228, Offset: 0x6a53
    // Size: 0x26, Type: dev
    function private function_a4721788b8eaf89b()
    {
        if ( level.europa )
        {
            level.europa thread play_vo( "<dev string:x509>" );
        }
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x53445757, Offset: 0x6a81
    // Size: 0x5f, Type: dev
    function private function_3c385d6b8bfbb563()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x519>", @"hash_5450f470be697544" );
        
        if ( !level.europa )
        {
            return;
        }
        
        if ( getdvarint( @"hash_5450f470be697544" ) )
        {
            level.europa thread debug_draw_move_target();
            return;
        }
        
        level.europa notify( #"hash_c42a4c6310e191d1" );
    }

    // Namespace europa
    // Params 0, eflags: 0x4
    // Checksum 0x4074a8f5, Offset: 0x6ae8
    // Size: 0x105, Type: dev
    function private debug_draw_move_target()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"hash_c42a4c6310e191d1" );
        
        while ( true )
        {
            followtgt = function_b8c0ff578e3412( "<dev string:x53b>" );
            wandertgt = function_b8c0ff578e3412( "<dev string:x542>" );
            
            if ( followtgt )
            {
                sphere( followtgt.origin, 5, ( 0, 1, 0 ) );
                print3d( followtgt.origin, "<dev string:x549>", ( 0, 1, 0 ), 1, 1, utility::function_329f35afae907694( 1 ) );
            }
            else if ( wandertgt )
            {
                sphere( wandertgt.origin, 5, ( 0, 1, 0 ) );
                print3d( wandertgt.origin, "<dev string:x557>", ( 0, 1, 0 ), 1, 1, utility::function_329f35afae907694( 1 ) );
            }
            
            waitframe();
        }
    }

    // Namespace europa
    // Params 0
    // Checksum 0x752116f2, Offset: 0x6bf5
    // Size: 0x25, Type: dev
    function function_19133d58623d1be7()
    {
        if ( level.europa )
        {
            level.europa notify( #"europa_fake_stuck" );
        }
    }

#/
