// script_61b40095fd0502f0  (hash_61b40095fd0502f0.gscc) (size: 36021 Bytes / 0x8cb5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd10c18c (4245733772)
// size ...... 36021 (0x8cb5)
// includes .. 25  (offset: 0x83ed)
// strings ... 84  (offset: 0x84b5)
// dev strs .. 56  (offset: 0x8a0d)
// exports ... 114 (offset: 0x52b9)
// cseg ...... 0x51a + 0x4d9f (0x52b9)
// imports ... 248 (offset: 0x6489)
// animtree1 . 0   (offset: 0x8cb5)
// animtree2 . 0   (offset: 0x8cb5)
#using script_16555c1140262e45;
#using script_16ea1b94f0f381b3;
#using script_28903b44edf078c7;
#using script_3865eabfc59f0765;
#using scripts\anim\battlechatter;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\mp_agent;

#namespace dawg;

// Namespace dawg
// Params 1
// Checksum 0x5a1bbc5a, Offset: 0x538
// Size: 0x5d
function function_3816177cd7f1739( params )
{
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "dawg_melee", &function_c1ac996bc4b45607 );
    function_a0fcf66315432512();
    
    /#
        setup_dawg_devgui();
    #/
}

// Namespace dawg
// Params 1
// Checksum 0x63d3d45, Offset: 0x59d
// Size: 0x310
function dawginit( taskid )
{
    function_874ed259ed53e484( self );
    self.dawgaisettings = level.var_de0074d9320cc42f[ function_8e41f13f8b7fd338() ];
    callback::add( "on_first_ai_init", &function_3816177cd7f1739 );
    callback::add( #"on_ai_killed", &function_3da5bc18fd85ec6b );
    self.agent_damage_callback = &dawg_damage_override;
    self.var_e8f6b03121a2f56d = [ &function_23d398915e828362 ];
    self.var_c5ccf9dff3b5e393 = &function_9f089068acd13af1;
    self.var_485899a46494a80f = &function_115a1f5c5af2816d;
    self.allowstrafe = 0;
    self setcanusecover( 0 );
    self.lookfordoorsalongpath = 1;
    self.checkstop = 0;
    self allowvehiclepredictiveragdoll( 0 );
    self.spawnorigin = self.origin;
    self pushplayer( 1 );
    
    if ( !level.var_1094bbb6422bd39a )
    {
        self function_90b3ed62e6d125e9( 3 );
    }
    
    self.var_7bd2fc702f01b407 = 1;
    self.mode = "attack";
    self.script_team = self.team;
    self function_74b305f055e8341d( "metal_thick" );
    self.var_5b2c75a18725dcd9 = 1;
    createthreatbiasgroup( "dawg" );
    self setthreatbiasgroup( "dawg" );
    thread function_ce0ead9229477cd2();
    thread function_e737fc27e60d11d8();
    thread function_b75457573b23705b();
    thread function_da3f73cd3e6aca18();
    var_a6cc0e69a3ee461f = utility::callsharedfunc( #"dawg", #"hash_dcb19f7ac172bc76", self.team, self.dawgaisettings );
    
    if ( !isdefined( var_a6cc0e69a3ee461f ) )
    {
        var_a6cc0e69a3ee461f = self.team == "axis" ? self.dawgaisettings.var_6a7a70f3ad78ede2 : self.dawgaisettings.var_a6cc0e69a3ee461f;
    }
    
    var_1e5b09e7ee3aa1ca = self.team == "axis" ? self.dawgaisettings.var_8c93ab488fd24de5 : self.dawgaisettings.var_1e5b09e7ee3aa1ca;
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    
    foreach ( model_override in bundle.var_5aec7880d7929a2b )
    {
        if ( getdvarint( model_override.dvarstring, 0 ) )
        {
            var_1e5b09e7ee3aa1ca = ( self.team == "axis" ? model_override.var_8c93ab488fd24de5 : model_override.var_1e5b09e7ee3aa1ca ) ?? var_1e5b09e7ee3aa1ca;
            break;
        }
    }
    
    dawg_turret::function_32b910e01be89a47( var_a6cc0e69a3ee461f, var_1e5b09e7ee3aa1ca );
    thread function_7271a02f20893a23();
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x77bb6b29, Offset: 0x8b6
// Size: 0x9d
function function_874ed259ed53e484( dawg )
{
    aitype = dawg function_8e41f13f8b7fd338();
    
    if ( !level.var_de0074d9320cc42f[ aitype ] )
    {
        var_faafbd977112553b = "";
        
        if ( aitype == "sat_dawg_sm" )
        {
            var_faafbd977112553b = "dawgsettings_mp_dawg_sm";
        }
        else
        {
            bundle = level.streakglobals.streakbundles[ "dawg" ];
            var_faafbd977112553b = bundle.var_faafbd977112553b;
        }
        
        level.var_de0074d9320cc42f[ aitype ] = getscriptbundle( "dawgaisettings:" + var_faafbd977112553b );
    }
}

// Namespace dawg
// Params 0
// Checksum 0x877a0d8d, Offset: 0x95b
// Size: 0x11
function function_8e41f13f8b7fd338()
{
    return getsubstr( self.classname, 6 );
}

// Namespace dawg
// Params 2, eflags: 0x4
// Checksum 0x9682fea3, Offset: 0x975
// Size: 0x23
function private killstreak_cancel( params, dawg )
{
    if ( dawg )
    {
        dawg agent_utils::despawnagent();
    }
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xa734eb90, Offset: 0x9a0
// Size: 0xb8
function private dawg_cancel_watcher( owner )
{
    if ( !level.gametypebundle.var_711e33239e4c9925 || !isplayer( owner ) )
    {
        return;
    }
    
    owner endon( #"disconnect" );
    assert( !owner callback::exists( #"killstreak_cancel", &killstreak_cancel, self ) );
    owner callback::add( #"killstreak_cancel", &killstreak_cancel, self );
    self waittill( #"death" );
    assert( owner callback::exists( #"killstreak_cancel", &killstreak_cancel, self ) );
    owner callback::remove( #"killstreak_cancel", &killstreak_cancel, self );
}

// Namespace dawg
// Params 3
// Checksum 0x7f394e42, Offset: 0xa60
// Size: 0x1c6
function dawgpostinit( owner, setupstruct, streakinfo )
{
    self.owner = owner;
    self setsafeguardent( owner );
    self setsafeguardrange( self.dawgaisettings.safeguarddistance );
    thread dawg_turret::dawg_turret_set_owner( owner );
    thread dawg_cancel_watcher( owner );
    bundle = streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    
    if ( self.dawgaisettings.dawglifetime >= 0 )
    {
        thread dawg_timeout_watcher( self.dawgaisettings.dawglifetime );
    }
    
    if ( setupstruct.var_c4e26a8fd03fdeea )
    {
        self.var_c4e26a8fd03fdeea = 1;
    }
    
    if ( isplayer( owner ) )
    {
        self setotherent( owner );
        self setentityowner( owner );
        thread function_7ceec3b4fb6cc99f();
        
        if ( !level callback::exists( #"player_disconnect", &dawg_on_player_disconnect ) )
        {
            level callback::add( #"player_disconnect", &dawg_on_player_disconnect );
        }
        
        self.outlineid = outline::outlineenableforplayer( self, owner, bundle.var_da203ef1b69207e0, "killstreak" );
        
        if ( self.turret )
        {
            self.turret.outlineid = outline::outlineenableforplayer( self.turret, owner, bundle.var_da203ef1b69207e0, "killstreak" );
        }
    }
    
    battlechatter::broadcastnotify( self.origin, 1000, "deploy_equipment", "deploy_dawg", { #team:self.team, #otherent:self } );
}

// Namespace dawg
// Params 1
// Checksum 0xc54fb60, Offset: 0xc2e
// Size: 0x31
function function_89e245d0c32420b8( taskid )
{
    if ( self.mode == "sentry" )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace dawg
// Params 1
// Checksum 0x834ee4b, Offset: 0xc68
// Size: 0x31
function function_a4c3fd3c2c8ddb47( taskid )
{
    if ( self.mode == "attack" )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace dawg
// Params 1
// Checksum 0x76c9be87, Offset: 0xca2
// Size: 0x31
function function_83a7a6f5f9bd7a91( taskid )
{
    if ( self.mode == "emp" )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace dawg
// Params 1
// Checksum 0x4f2b03da, Offset: 0xcdc
// Size: 0x31
function function_6dd22daedc6f8c86( taskid )
{
    if ( self.mode == "inactive" )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace dawg
// Params 1
// Checksum 0x749be7ae, Offset: 0xd16
// Size: 0xf8
function dawgmove( taskid )
{
    /#
        debug_draw_dawg();
    #/
    
    if ( getdvarint( @"hash_1ae638cab9d29912", 0 ) == 1 )
    {
        return "DawgMoveIdle";
    }
    
    if ( getdvarint( @"hash_fd52b770bfc79d5d", 0 ) )
    {
        return "DawgMoveWander";
    }
    
    if ( function_8dc0a25371774c48() )
    {
        return "DawgMoveEscort";
    }
    
    if ( getdvarint( @"hash_2bca332367faa5f8", 0 ) == 1 )
    {
        if ( !isalive( self.var_24700fd10a27b994 ) )
        {
            self.var_24700fd10a27b994 = undefined;
        }
        
        if ( self.var_819553d091947617 && !self.var_24700fd10a27b994 )
        {
            return "DawgMoveWander";
        }
    }
    
    if ( function_3eee9b1d5aa6a905() )
    {
        return "DawgMoveMissile";
    }
    
    if ( function_88942fc3a30e11f8() )
    {
        if ( function_77d213cd96d58d54() )
        {
            return "DawgMoveRetreat";
        }
        else
        {
            return "DawgMoveStalk";
        }
    }
    
    if ( dawg_is_idling() )
    {
        return "DawgMoveIdle";
    }
    
    if ( function_b088d49b49e6a92() )
    {
        return "DawgMoveIdle";
    }
    
    return "DawgMoveWander";
}

// Namespace dawg
// Params 1
// Checksum 0x94f8b6d2, Offset: 0xe17
// Size: 0x73
function function_ed15b29d6610083f( taskid )
{
    var_3d10f557780e179d = randomfloatrange( self.dawgaisettings.minidletime, self.dawgaisettings.maxidletime );
    
    if ( !self.var_1a552427a41b538d )
    {
        self.var_1a552427a41b538d = gettime() + var_3d10f557780e179d * 1000;
    }
    
    function_58c0d015f8ec4204();
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x7279344, Offset: 0xe93
// Size: 0x1c
function function_e38a23435065a940( taskid )
{
    function_58c0d015f8ec4204();
    return anim.running;
}

// Namespace dawg
// Params 1
// Checksum 0xbc50781a, Offset: 0xeb8
// Size: 0x1f
function function_fd491a176ab68e07( taskid )
{
    self.var_1a552427a41b538d = undefined;
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x479e354d, Offset: 0xee0
// Size: 0x1f
function function_43cce5b0d25342f0( taskid )
{
    self.movement_goal = undefined;
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xf2e8a286, Offset: 0xf08
// Size: 0xc8
function function_5f273f2855011db3( taskid )
{
    if ( function_b088d49b49e6a92() )
    {
        function_58c0d015f8ec4204();
    }
    
    enemy = function_3f8db38ff773ac8d();
    
    if ( !self.movement_goal && function_423bf4b43e52bf93( enemy ) )
    {
        retreatpos = function_f7cda3ee2f21f308( enemy.origin, self.dawgaisettings.var_780d2bdaaffc4435, self.dawgaisettings.var_780d2bdaaffc4435 );
        
        if ( retreatpos && distancesquared( retreatpos, enemy.origin ) >= self.dawgaisettings.var_914fa1dc7b9b80d2 )
        {
            dawg_set_goal( retreatpos );
        }
    }
    
    return anim.running;
}

// Namespace dawg
// Params 1
// Checksum 0x9aa00dec, Offset: 0xfd9
// Size: 0x15
function function_da5b48862baf2bfc( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x34ac4e21, Offset: 0xff7
// Size: 0x15
function function_7e4187933ba31380( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x88a64015, Offset: 0x1015
// Size: 0x239
function function_4492470f7145643( taskid )
{
    if ( function_6ee09551739ee12f() )
    {
        return anim.running;
    }
    
    enemy = function_3f8db38ff773ac8d();
    canseeenemy = istrue( self.turret.visibletarget );
    reachedgoal = !self.movement_goal || distance2dsquared( self.origin, self.movement_goal ) < squared( self.dawgaisettings.var_a65bbf678ad9c625 );
    var_b6b293c3c741aeee = distance2dsquared( self.origin, enemy.origin ) < squared( self.dawgaisettings.var_c7524ba3d5f8be26 );
    
    if ( canseeenemy || reachedgoal || var_b6b293c3c741aeee )
    {
        self.movement_goal = self getclosestreachablepointonnavmesh( enemy.origin, 0 ) ?? enemy.origin;
    }
    
    var_70cc78291066166 = distance2dsquared( self.origin, self.movement_goal ) < squared( self.dawgaisettings.var_2cd276a98accde7e ) || function_b088d49b49e6a92();
    
    if ( canseeenemy && ( var_70cc78291066166 || !self.var_6b4d17f041d5c0b9 ) )
    {
        function_58c0d015f8ec4204();
        return anim.running;
    }
    
    if ( var_70cc78291066166 )
    {
        tagorigin = enemy gettagorigin( "j_spine4", 1 );
        
        if ( tagorigin )
        {
            lospoint = findclosestlospointwithinradius( self.origin, 512, tagorigin, self.origin );
            
            if ( lospoint && distance2dsquared( self.origin, lospoint ) <= squared( self.dawgaisettings.var_2cd276a98accde7e && distance2dsquared( self.origin, lospoint ) > 1225 ) )
            {
                self.movement_goal = self getclosestreachablepointonnavmesh( lospoint, 0 ) ?? enemy.origin;
            }
        }
    }
    
    dawg_set_goal( self.movement_goal );
    return anim.running;
}

// Namespace dawg
// Params 1
// Checksum 0xfb02baf4, Offset: 0x1257
// Size: 0x29
function function_721ce4e23d7be3ec( taskid )
{
    if ( !self.movement_goal )
    {
        function_ebaaba4cbf630941();
    }
    
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x95ba7ce5, Offset: 0x1289
// Size: 0x15
function function_43933e2f0e93eca2( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xb3c9e4f, Offset: 0x12a7
// Size: 0x147
function function_56948e7fdfe2dfa1( taskid )
{
    if ( getdvarint( @"hash_fd52b770bfc79d5d", 0 ) )
    {
        goal_pos = self getclosestreachablepointonnavmesh( self.owner.origin ?? self.enemy.origin ?? self.origin, 0 );
        dawg_set_goal( goal_pos );
        return anim.running;
    }
    
    if ( getdvarint( @"hash_2bca332367faa5f8", 0 ) == 1 && self.var_819553d091947617 )
    {
        goal_pos = self getclosestreachablepointonnavmesh( self.var_819553d091947617, 0 );
        dawg_set_goal( goal_pos );
        return anim.running;
    }
    
    if ( self.movement_goal )
    {
        dawg_set_goal( self.movement_goal );
        return anim.running;
    }
    
    goal_pos = function_f7cda3ee2f21f308( get_safeguard_pos(), self.dawgaisettings.var_e3c2d42dec6162c3, self.dawgaisettings.var_85cd7980aee2f4e9 );
    
    if ( goal_pos && distance2dsquared( goal_pos, self.origin ) < 1225 )
    {
        goal_pos = undefined;
    }
    
    dawg_set_goal( goal_pos );
    return anim.running;
}

// Namespace dawg
// Params 1
// Checksum 0x28f6b10, Offset: 0x13f7
// Size: 0x15
function function_4855e816285ef0a( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x6b492828, Offset: 0x1415
// Size: 0x72
function DawgMoveEscort( taskid )
{
    if ( isvector( self.var_5450284b654f895f ) && !self.var_a8b2e78bad2fcb6c )
    {
        goal_pos = self getclosestreachablepointonnavmesh( self.var_5450284b654f895f, 0 );
        
        if ( goal_pos )
        {
            self setbtgoalpos( 3, goal_pos );
            self setbtgoalradius( 3, 32 );
            self.var_a8b2e78bad2fcb6c = 1;
        }
    }
    
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x1caffbae, Offset: 0x1490
// Size: 0x15
function function_bfea547b942cf0fd( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xec5f3f41, Offset: 0x14ae
// Size: 0x67
function function_5f0325f80bab9542( taskid )
{
    if ( self.movement_goal )
    {
        function_58c0d015f8ec4204();
    }
    else
    {
        asmstate = self asmgetcurrentstate( self.asmname );
        
        if ( asmstate == "idle" )
        {
            asm::function_7256f5ba459c840b( "sentry_mode_in" );
            self.var_8666a991e34bea40 = 1;
        }
    }
    
    return anim.running;
}

// Namespace dawg
// Params 1
// Checksum 0x980caa66, Offset: 0x151e
// Size: 0x63
function function_7d3d5fdad07102f9( taskid )
{
    asmstate = self asmgetcurrentstate( self.asmname );
    
    if ( asmstate == "sentry_mode_in" || asmstate == "sentry_mode" )
    {
        asm::function_7256f5ba459c840b( "sentry_mode_out" );
        self.var_8666a991e34bea40 = 0;
    }
    
    function_ebaaba4cbf630941();
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xa258c4e, Offset: 0x158a
// Size: 0x15
function function_ac60ee8f3a8bf2d2( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xbb489ec4, Offset: 0x15a8
// Size: 0x15
function function_4116ecc74a0e4d1a( taskid )
{
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x937a896f, Offset: 0x15c6
// Size: 0x25
function function_a1401a704fc57ad1( taskid )
{
    dawg_set_goal( self.sentry_mode_position );
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x460dec40, Offset: 0x15f4
// Size: 0x1c
function function_9ff5acca9e2d3b08( taskid )
{
    dawg_set_goal();
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0x35115857, Offset: 0x1619
// Size: 0x9b
function function_73dc731fb977a258( taskid )
{
    asm::function_7256f5ba459c840b( "inactive_mode_in" );
    
    if ( isplayer( self.owner ) )
    {
        outline::outlinedisable( self.outlineid, self );
        outline::outlinedisable( self.turret.outlineid, self.turret );
    }
    
    if ( self.turret )
    {
        self.turret dawg_turret::dawg_turret_stop();
    }
    
    if ( !self.var_e88e025ae79c116e )
    {
        self function_e8726d980fa12944();
    }
    
    self setcandamage( 0 );
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xba284700, Offset: 0x16bd
// Size: 0x11e
function function_38f7f5338026d324( taskid )
{
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    asmstate = self asmgetcurrentstate( self.asmname );
    
    if ( asmstate == "inactive_mode_in" || asmstate == "inactive_mode" )
    {
        asm::function_7256f5ba459c840b( "inactive_mode_out" );
    }
    
    if ( isplayer( self.owner ) )
    {
        self.outlineid = outline::outlineenableforplayer( self, self.owner, bundle.var_da203ef1b69207e0, "killstreak" );
        self.turret.outlineid = outline::outlineenableforplayer( self.turret, self.owner, bundle.var_da203ef1b69207e0, "killstreak" );
    }
    
    if ( self.turret )
    {
        self.turret dawg_turret::function_609516267ed6c6b3();
    }
    
    self visiblesolid();
    self setcandamage( 1 );
    
    /#
        thread function_489a303adb3c17e3();
    #/
    
    return anim.success;
}

// Namespace dawg
// Params 1
// Checksum 0xd7c68641, Offset: 0x17e4
// Size: 0x15
function function_7163154ef40d2eab( taskid )
{
    return anim.running;
}

// Namespace dawg
// Params 1
// Checksum 0xea28fee2, Offset: 0x1802
// Size: 0x126
function on_emp_applied( data )
{
    self.mode = "emp";
    self notify( #"emp_dawg" );
    self notify( #"mode_changed" );
    
    if ( isalive( self ) )
    {
        asm::function_7256f5ba459c840b( "stun_in" );
    }
    
    if ( data.reason == "hacked" )
    {
        utility::function_32b24db3127bff40( #"hacked", #"hacked" );
    }
    else
    {
        utility::function_32b24db3127bff40( #"emp", #"on" );
    }
    
    if ( self.streakinfo.bundle.empedscoreevent && data.attacker )
    {
        data.attacker thread utility::callsharedfunc( #"player", #"doScoreEvent", self.streakinfo.bundle.empedscoreevent );
    }
    
    self.empdata = data;
    
    if ( self.turret )
    {
        self.turret dawg_turret::dawg_turret_stop();
    }
}

// Namespace dawg
// Params 1
// Checksum 0x502f6214, Offset: 0x1930
// Size: 0xc0
function on_emp_cleared( fromdeath )
{
    if ( self.empcount > 0 )
    {
        return;
    }
    
    self.mode = "attack";
    self notify( #"mode_changed" );
    
    if ( isalive( self ) )
    {
        asm::function_7256f5ba459c840b( "stun_end" );
        
        if ( self.turret )
        {
            self.turret dawg_turret::function_609516267ed6c6b3();
        }
    }
    
    if ( self.empdata.reason == "hacked" )
    {
        utility::function_32b24db3127bff40( #"hacked", #"off" );
    }
    else
    {
        utility::function_32b24db3127bff40( #"emp", #"off" );
    }
    
    self.empdata = undefined;
}

// Namespace dawg
// Params 1
// Checksum 0x5c67a1dc, Offset: 0x19f8
// Size: 0x1e
function function_9f089068acd13af1( data )
{
    thread function_f7ba99defdf16c62( data.attacker );
}

// Namespace dawg
// Params 1
// Checksum 0xbd799c18, Offset: 0x1a1e
// Size: 0x26
function function_115a1f5c5af2816d( portal )
{
    self.turret setturrettargetlocalangles( self.angles, 0, 1 );
}

// Namespace dawg
// Params 0
// Checksum 0x6152d1bd, Offset: 0x1a4c
// Size: 0x32
function function_3f8db38ff773ac8d()
{
    enemy = self.targetenemy;
    
    if ( enemy.team == self.team )
    {
        return;
    }
    
    return enemy;
}

// Namespace dawg
// Params 1
// Checksum 0x33e59953, Offset: 0x1a87
// Size: 0x74, Type: bool
function dawg_set_goal( dest )
{
    if ( !dest )
    {
        self.movement_goal = undefined;
        self setbtgoalstationary( 0 );
        return false;
    }
    
    self.movement_goal = dest;
    self setbtgoalpos( 0, dest );
    path = self getpath( 1 );
    
    if ( path[ 0 ] && function_3f99321e4f4437ac( path[ 0 ] ) )
    {
        self.movement_goal = undefined;
        self setbtgoalstationary( 0 );
        return false;
    }
    
    return true;
}

// Namespace dawg
// Params 0
// Checksum 0x3813b912, Offset: 0x1b04
// Size: 0x12
function function_ebaaba4cbf630941()
{
    dawg_set_goal( self.origin );
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xbac3180a, Offset: 0x1b1e
// Size: 0xae
function private play_death_fx( params )
{
    if ( utility::ent_flag( "burned" ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_32b24db3127bff40( "burned", "burned_on" );
            params.body thread function_fc12a24729ef4e67();
        }
    }
    else if ( utility::ent_flag( "napalm_burned" ) )
    {
        if ( isdefined( params.body ) )
        {
            params.body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            params.body thread function_a67c6606a684a2dd();
        }
    }
    
    thread death_explode( params );
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0xea14be49, Offset: 0x1bd4
// Size: 0x1e
function private function_fc12a24729ef4e67()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x960651cf, Offset: 0x1bfa
// Size: 0x1e
function private function_a67c6606a684a2dd()
{
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
    }
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0x55ae4f1a, Offset: 0x1c20
// Size: 0x2a1
function private death_explode( params )
{
    body = params.body;
    attacker = params.eattacker;
    means_of_death = params.smeansofdeath;
    level endon( #"game_ended" );
    body endon( #"corpse_deleted" );
    
    if ( !isdefined( body ) )
    {
        return;
    }
    
    dawgaisettings = self.dawgaisettings;
    
    if ( !isent( self.owner ) )
    {
        self.owner = undefined;
    }
    
    if ( self.owner )
    {
        body.owner = self.owner;
        body.team = self.owner.team;
        body setotherent( self.owner );
        
        if ( isplayer( self.owner ) )
        {
            self.owner callback::remove( #"player_disconnect", &dawg_on_player_disconnect );
        }
    }
    
    if ( self.killcament )
    {
        self.killcament delete();
    }
    
    dawg_pet_asm::function_c9779b57c42e7d09();
    
    if ( self.var_c4e26a8fd03fdeea || self.var_4e066f8aa40be1ae || means_of_death == "MOD_CRUSH" )
    {
        body utility::function_32b24db3127bff40( "death", "explode_instant" );
    }
    else if ( self.forceannihilate )
    {
        body utility::function_32b24db3127bff40( "death", "explode_annihilate" );
        body callback::callback( "on_annihilated" );
    }
    else
    {
        body enablelinkto();
        body dawg_turret::function_6fde3b7a86fceb16( self );
        body utility::function_32b24db3127bff40( "body_damage", "heavy" );
        wait 1;
        body utility::function_32b24db3127bff40( "burned", "burned_on" );
        wait 2.5;
        body utility::function_32b24db3127bff40( "burned", "burned_off" );
        waitframe();
        body utility::function_32b24db3127bff40( "death", "explode_on" );
    }
    
    var_b7b609abde6844aa = body gettagorigin( "tag_turret_null" );
    var_b7b609abde6844aa = utility::groundpos( var_b7b609abde6844aa );
    radius = dawgaisettings.deathexplosionradius;
    var_6a02108301e17dc = dawgaisettings.var_4f0e23fceeabb3a;
    var_578d71b7c00fc4ba = dawgaisettings.var_92796bc01b12c80;
    body apply_explosion_damage( var_b7b609abde6844aa, radius, var_6a02108301e17dc, var_578d71b7c00fc4ba, attacker );
    body function_30461691650a2a72( var_b7b609abde6844aa );
    wait 0.2;
    body hide();
    wait 0;
    body delete();
}

// Namespace dawg
// Params 5, eflags: 0x4
// Checksum 0x19232ea, Offset: 0x1ec9
// Size: 0x5b
function private apply_explosion_damage( origin, radius, var_6a02108301e17dc, var_578d71b7c00fc4ba, attacker )
{
    if ( !attacker )
    {
        attacker = self.owner;
    }
    
    if ( !isent( attacker ) )
    {
        attacker = undefined;
    }
    
    self radiusdamage( origin, radius, var_6a02108301e17dc, var_578d71b7c00fc4ba, attacker );
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xd80d8f9f, Offset: 0x1f2c
// Size: 0x2d
function private function_30461691650a2a72( origin )
{
    physicsexplosionsphere( origin, 250, 100, 1 );
    earthquake( 0.6, 1.5, origin, 300 );
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0x9b4ebacb, Offset: 0x1f61
// Size: 0x3a
function private function_c1ac996bc4b45607( params )
{
    if ( isplayer( params.var_2d2aab21299551f8 ) )
    {
        params.var_2d2aab21299551f8 utility::function_32b24db3127bff40( "hellhoundMeleeVFX", "hit_fx" );
    }
}

// Namespace dawg
// Params 13
// Checksum 0x89931c21, Offset: 0x1fa3
// Size: 0x3af
function dawg_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir = ( 0, 0, 0 ), shitloc, timeoffset, modelindex, partname, objweapon )
{
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    
    if ( self.var_c4e26a8fd03fdeea && isdefined( einflictor ) && einflictor vehicle::is_vehicle() && idamage >= 450 )
    {
        idamage = self.health;
        self.var_4e066f8aa40be1ae = 1;
    }
    
    if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
    {
        data = damage_utility::packdamagedata( eattacker, self, idamage, sweapon, smeansofdeath, einflictor, vpoint, vdir, modelindex, partname, undefined, idflags, undefined, shitloc );
        data.iskillstreak = 1;
        idamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( eattacker, sweapon, smeansofdeath, idamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, data );
    }
    
    if ( eattacker == self || eattacker == self.turret )
    {
        idamage = 0;
    }
    
    if ( isdefined( sweapon ) && sweapon.basename == "sat_remote_robot_arm_gun_mp" )
    {
        idamage *= 2;
    }
    
    if ( self.var_8666a991e34bea40 )
    {
        idamage *= self.dawgaisettings.sentrydamagemultiplier ?? 1;
        var_fae9911d4d463af8 = "hitextrahealth";
        self.var_bdc51be80cbeef82 = 1;
    }
    else
    {
        var_fae9911d4d463af8 = "hitequip";
        self.var_bdc51be80cbeef82 = undefined;
    }
    
    if ( !mp_agent::is_friendly_damage( self, eattacker, smeansofdeath, sweapon ) )
    {
        newhealth = self.health - idamage;
        iskillingblow = newhealth <= 0;
        function_c0f8880408c1c565( newhealth );
        attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
        
        if ( isplayer( attackerplayer ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                var_7731d58f6f82f082 = { #mod:smeansofdeath, #direction_vec:vdir, #point:vpoint, #objweapon:objweapon, #victim:self };
                attackerplayer [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( var_fae9911d4d463af8, iskillingblow, 0, undefined, undefined, 1, undefined, undefined, undefined, var_7731d58f6f82f082, undefined, 3 );
            }
        }
        
        if ( self.streakinfo )
        {
            data = { #objweapon:sweapon, #idflags:idflags, #meansofdeath:smeansofdeath, #point:vpoint, #direction_vec:vdir, #attacker:eattacker, #damage:idamage, #victim:self };
            
            if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
            {
                [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( eattacker, sweapon, undefined, smeansofdeath, idamage, data );
            }
        }
    }
    
    return idamage;
}

// Namespace dawg
// Params 1
// Checksum 0xbe82e22, Offset: 0x235b
// Size: 0xb8
function function_23d398915e828362( dmgstruct )
{
    dmgstruct.idamage = dawg_damage_override( dmgstruct.einflictor, dmgstruct.eattacker, dmgstruct.idamage, dmgstruct.idflags, dmgstruct.smeansofdeath, dmgstruct.sweapon, dmgstruct.vpoint, dmgstruct.vdir, dmgstruct.shitloc, dmgstruct.timeoffset, dmgstruct.modelindex, dmgstruct.partname, dmgstruct.objweapon );
    return dmgstruct.idamage;
}

// Namespace dawg
// Params 1
// Checksum 0x1014658f, Offset: 0x241c
// Size: 0x147
function function_c0f8880408c1c565( currhealth )
{
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    healthpercent = currhealth / self.maxhealth;
    
    if ( healthpercent <= self.dawgaisettings.heavydamagepercent )
    {
        utility::function_32b24db3127bff40( "body_damage", "heavy" );
        self.turret utility::function_32b24db3127bff40( "body_damage", "heavy" );
        return;
    }
    
    if ( healthpercent <= self.dawgaisettings.mediumdamagepercent )
    {
        utility::function_32b24db3127bff40( "body_damage", "medium" );
        self.turret utility::function_32b24db3127bff40( "body_damage", "medium" );
        return;
    }
    
    if ( healthpercent <= self.dawgaisettings.lightdamagepercent )
    {
        utility::function_32b24db3127bff40( "body_damage", "light" );
        self.turret utility::function_32b24db3127bff40( "body_damage", "light" );
        return;
    }
    
    utility::function_32b24db3127bff40( "body_damage", "off" );
    self.turret utility::function_32b24db3127bff40( "body_damage", "off" );
}

// Namespace dawg
// Params 1
// Checksum 0x5615a09c, Offset: 0x256b
// Size: 0x201
function function_3da5bc18fd85ec6b( params )
{
    attacker = params.eattacker;
    
    if ( !attacker )
    {
        return;
    }
    
    if ( attacker != self.owner )
    {
        bundle = level.streakglobals.streakbundles[ "dawg" ];
        
        if ( attacker && !isplayer( attacker ) && isplayer( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
        
        if ( self.streakinfo )
        {
            if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
            {
                self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( "dawg", attacker, params.sweapon, params.smeansofdeath, params.idamage, #"kill_ss_dawg", undefined );
            }
        }
        else
        {
            if ( bundle.var_ef569b1163fc8188 )
            {
                attacker thread points::doscoreevent( bundle.var_ef569b1163fc8188 );
            }
            
            if ( bundle.var_dbc89baed6f2798b )
            {
                foreach ( player in self.a_n_player_damage )
                {
                    if ( player != attacker )
                    {
                        player thread points::doscoreevent( bundle.var_dbc89baed6f2798b );
                    }
                }
            }
        }
    }
    
    if ( isplayer( self.owner ) )
    {
        outline::outlinedisable( self.outlineid, self );
        outline::outlinedisable( self.turret.outlineid, self.turret );
    }
}

// Namespace dawg
// Params 2, eflags: 0x4
// Checksum 0x57b79fdd, Offset: 0x2774
// Size: 0x73, Type: bool
function private function_c9660c6fd143f4bc( dawg, pos )
{
    owner = dawg.owner;
    
    if ( isdefined( owner ) && distancesquared( pos, owner.origin ) > self.dawgaisettings.safeguarddistance * self.dawgaisettings.safeguarddistance )
    {
        return true;
    }
    
    return false;
}

// Namespace dawg
// Params 3, eflags: 0x4
// Checksum 0xdf348ede, Offset: 0x27f0
// Size: 0xcf
function private function_3dcf57d29877d660( target, desired_distance, clockwise )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    target_origin = target.origin;
    to_dawg = self.origin - target_origin;
    var_f43464a4559d2419 = vectortoyaw( to_dawg );
    angle_offset = 60 * ( clockwise ? -1 : 1 );
    goal_angle = angleclamp180( var_f43464a4559d2419 + angle_offset );
    goal_vec = anglestoforward( ( 0, goal_angle, 0 ) );
    goal_pos = goal_vec * desired_distance + target.origin;
    goal_pos_navmesh = self getclosestreachablepointonnavmesh( goal_pos, 0 );
    return goal_pos_navmesh;
}

// Namespace dawg
// Params 3, eflags: 0x4
// Checksum 0xb3fe3446, Offset: 0x28c8
// Size: 0x10d
function private function_f7cda3ee2f21f308( target_origin, min_distance, max_distance )
{
    if ( !isdefined( target_origin ) )
    {
        return;
    }
    
    radius = sqrt( randomfloatrange( squared( min_distance / max_distance ), 1 ) ) * max_distance;
    theta = randomfloat( 360 );
    dir = ( cos( theta ), sin( theta ), 0 );
    pos = target_origin + dir * radius;
    projected_radius = radius + 40;
    projected_pos = target_origin + dir * ( radius + 40 );
    hit = navtrace( target_origin, projected_pos, undefined, 1 );
    
    if ( hit[ "fraction" ] && hit[ "fraction" ] < 1 )
    {
        hitdistance = hit[ "fraction" ] * projected_radius;
        adjusteddist = hitdistance - 40;
        
        if ( adjusteddist < min_distance )
        {
            return;
        }
        
        pos = target_origin + dir * adjusteddist;
    }
    
    pos = self getclosestreachablepointonnavmesh( pos, 0 );
    return pos;
}

// Namespace dawg
// Params 3, eflags: 0x4
// Checksum 0x83f3dbcf, Offset: 0x29de
// Size: 0x1d0
function private function_91ee35cf02fa5dc( target_origin, desired_distance, check_owner )
{
    if ( !isdefined( target_origin ) )
    {
        return;
    }
    
    var_ed720ccbffb6cf8e = [];
    to_dawg = self.origin - target_origin;
    var_f43464a4559d2419 = vectortoyaw( to_dawg );
    angle_offset = 0;
    
    while ( angle_offset < 360 )
    {
        goal_angle = angleclamp180( var_f43464a4559d2419 + angle_offset );
        goal_vec = anglestoforward( ( 0, goal_angle, 0 ) );
        angle_offset += 30;
        goal_pos = target_origin + goal_vec * desired_distance;
        goal_pos_navmesh = self getclosestreachablepointonnavmesh( goal_pos, 0 );
        
        if ( isdefined( goal_pos_navmesh ) )
        {
            if ( check_owner && function_c9660c6fd143f4bc( self, goal_pos_navmesh ) )
            {
                continue;
            }
            
            var_ed720ccbffb6cf8e[ var_ed720ccbffb6cf8e.size ] = goal_pos_navmesh;
        }
        
        waitframe();
    }
    
    best_pos_navmesh = undefined;
    var_e3eab751eefd3bd0 = -1;
    dawg_forward = anglestoforward( self.angles );
    
    foreach ( potential_pos in var_ed720ccbffb6cf8e )
    {
        var_f8812de38fec502f = vectornormalize( potential_pos - self.origin );
        dot = vectordot( var_f8812de38fec502f, dawg_forward );
        
        if ( dot > var_e3eab751eefd3bd0 )
        {
            best_pos_navmesh = potential_pos;
            var_e3eab751eefd3bd0 = dot;
        }
    }
    
    if ( !isdefined( best_pos_navmesh ) && var_ed720ccbffb6cf8e.size > 0 )
    {
        best_pos_navmesh = var_ed720ccbffb6cf8e[ randomint( var_ed720ccbffb6cf8e.size ) ];
    }
    
    return best_pos_navmesh;
}

// Namespace dawg
// Params 0
// Checksum 0xfdf0137f, Offset: 0x2bb7
// Size: 0x2c, Type: bool
function function_b088d49b49e6a92()
{
    if ( !isdefined( self.movement_goal ) )
    {
        return false;
    }
    
    return distance2dsquared( self.origin, self.movement_goal ) < 1225;
}

// Namespace dawg
// Params 0
// Checksum 0x5bdfe11, Offset: 0x2bec
// Size: 0x33
function function_58c0d015f8ec4204()
{
    stoppos = self.movemode == "stop" ? undefined : function_9e69e54edba11c79();
    dawg_set_goal( stoppos );
}

// Namespace dawg
// Params 0
// Checksum 0x8edb03f2, Offset: 0x2c27
// Size: 0xd6
function function_9e69e54edba11c79()
{
    path = self getpath( 1 );
    
    if ( !path[ 0 ] )
    {
        return;
    }
    
    stopdist = 0;
    
    if ( self.var_7ebcfe2aa6620601 == "walk" )
    {
        stopdist = self.dawgaisettings.var_9b3284ea6048afbf;
    }
    else if ( self.var_7ebcfe2aa6620601 == "run" )
    {
        stopdist = self.dawgaisettings.var_19f4686943d1e143;
    }
    
    nextnode = path[ 0 ];
    stopnode = self.origin + vectornormalize( nextnode - self.origin ) * stopdist;
    return distancesquared( stopnode, self.origin ) > distancesquared( nextnode, self.origin ) ? nextnode : stopnode;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x654ec4ab, Offset: 0x2d06
// Size: 0x1d, Type: bool
function private dawg_is_idling()
{
    return self.var_1a552427a41b538d && gettime() < self.var_1a552427a41b538d;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x6a2d7156, Offset: 0x2d2c
// Size: 0x8e, Type: bool
function private function_88942fc3a30e11f8()
{
    if ( !self.turret || !function_3f8db38ff773ac8d() )
    {
        return false;
    }
    
    if ( !self.var_6b4d17f041d5c0b9 && !self.turret.visibletarget )
    {
        return false;
    }
    
    return distance2dsquared( self.owner.origin ?? self.spawnorigin, function_3f8db38ff773ac8d().origin ) < squared( self.dawgaisettings.var_43320c63df966406 );
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0xd4f0b782, Offset: 0x2dc3
// Size: 0x9f, Type: bool
function private function_96bab656587a4cc7()
{
    if ( !function_3f8db38ff773ac8d() )
    {
        return false;
    }
    
    enemy = function_3f8db38ff773ac8d();
    enemypos = getclosestpointonnavmesh( enemy.origin, undefined, undefined, undefined, 0, 0, 1 );
    
    if ( !enemypos || distance2dsquared( enemypos, enemy.origin ) > 10000 )
    {
        return false;
    }
    
    reachablepos = self getclosestreachablepointonnavmesh( enemypos, 0 );
    
    if ( !reachablepos || distance2dsquared( reachablepos, enemypos ) > 20 || abs( enemypos[ 2 ] - reachablepos[ 2 ] ) > 50 )
    {
        return false;
    }
    
    return true;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x35bad6c, Offset: 0x2e6b
// Size: 0x2c, Type: bool
function private function_77d213cd96d58d54()
{
    return self.dawgaisettings.var_d8701b0053b5ba17 && function_3f8db38ff773ac8d() && self.is_retreating;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0xe1135ae0, Offset: 0x2ea0
// Size: 0xc, Type: bool
function private function_8dc0a25371774c48()
{
    return istrue( self.var_efc101ac6633e69b );
}

// Namespace dawg
// Params 1
// Checksum 0x5ce72edf, Offset: 0x2eb5
// Size: 0x2c
function function_8f769ad7e90f97e2( var_3e36776f52c72cf )
{
    self.var_efc101ac6633e69b = 1;
    self.var_5450284b654f895f = var_3e36776f52c72cf;
    self.var_a8b2e78bad2fcb6c = 0;
}

// Namespace dawg
// Params 0
// Checksum 0xf56cc064, Offset: 0x2ee9
// Size: 0x1e
function function_84351a39df49afaa()
{
    self clearbtgoal( 3 );
    self.var_a8b2e78bad2fcb6c = 0;
    self.var_efc101ac6633e69b = 0;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x6c1759d5, Offset: 0x2f0f
// Size: 0x1e, Type: bool
function private function_3eee9b1d5aa6a905()
{
    return self.turret && self.turret dawg_turret::function_f1026959cc5e668e();
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xa0cb767b, Offset: 0x2f36
// Size: 0x79
function private function_4ee841b285ea6ce( enemy )
{
    var_754f0ffedcfe57c0 = distance2dsquared( self.origin, enemy.origin );
    var_2cd76410b0a08569 = var_754f0ffedcfe57c0 < squared( self.dawgaisettings.var_5cd29d1a3002d4d1 ) && ( !self.is_story_mission || var_754f0ffedcfe57c0 < 10000 || self cansee( enemy ) );
    return var_2cd76410b0a08569;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x11ad32f3, Offset: 0x2fb8
// Size: 0x47
function private function_ce0ead9229477cd2()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self function_fa32376aaa88a7a2( self.origin, self.dawgaisettings.safeguarddistance );
        wait 5;
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0xce109d21, Offset: 0x3007
// Size: 0xda
function private function_78398226173c5e6()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    chaseenemy = undefined;
    hasspottedenemy = 0;
    self.var_f3bbba708665714d = undefined;
    
    while ( true )
    {
        if ( self.turret.visibletarget )
        {
            hasspottedenemy = 1;
        }
        else if ( hasspottedenemy && !self.turret.visibletarget )
        {
            hasspottedenemy = 0;
            
            if ( !chaseenemy )
            {
                chaseenemy = function_3f8db38ff773ac8d();
                self.var_f3bbba708665714d = gettime();
            }
        }
        
        if ( chaseenemy && ( !isalive( chaseenemy ) || chaseenemy != function_3f8db38ff773ac8d() || self.mode != "attack" ) )
        {
            chaseenemy = undefined;
            self.var_f3bbba708665714d = undefined;
        }
        
        waitframe();
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0xa7c6be81, Offset: 0x30e9
// Size: 0x14f
function private function_e737fc27e60d11d8()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.targetenemy = undefined;
    self.var_6b4d17f041d5c0b9 = 0;
    
    while ( true )
    {
        if ( self.turret.var_b508c7d8b689b9bf )
        {
            self.targetenemy = undefined;
            wait 0.25;
            continue;
        }
        
        if ( getdvarint( @"hash_2bca332367faa5f8", 0 ) == 1 && self.var_24700fd10a27b994 )
        {
            self.targetenemy = self.var_24700fd10a27b994;
        }
        else if ( self.turret.force_target )
        {
            self.targetenemy = self.turret.force_target;
        }
        else if ( isalive( self.turret.visibletarget ) && self.turret dawg_turret::function_3d898a6e6245584() )
        {
            self.targetenemy = self.turret getturrettargetent( 0 );
        }
        else
        {
            self.targetenemy = self.enemy;
        }
        
        self.var_6b4d17f041d5c0b9 = self.dawgaisettings.var_740595c527c98af9 || function_96bab656587a4cc7();
        wait 0.25;
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x1d3bce38, Offset: 0x3240
// Size: 0x1cc
function private function_b75457573b23705b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_7ebcfe2aa6620601 = "";
    
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"hash_6080ba62e2bc0f6b", 0 ) == 1 )
        {
            newmovespeed = "walk";
        }
        else if ( getdvarint( @"hash_6080ba62e2bc0f6b", 0 ) == 2 )
        {
            newmovespeed = "run";
        }
        else if ( getdvarint( @"hash_6080ba62e2bc0f6b", 0 ) == 3 )
        {
            newmovespeed = "sprint";
        }
        else if ( self.var_f3bbba708665714d && self.var_f3bbba708665714d + self.dawgaisettings.var_37b6a8d35d3d759c * 1000 < gettime() )
        {
            newmovespeed = "sprint";
        }
        else if ( self.var_f3bbba708665714d && self.var_f3bbba708665714d + self.dawgaisettings.var_4ee4e69b41e4cbed * 1000 < gettime() )
        {
            newmovespeed = "run";
        }
        else if ( self.turret.visibletarget || self.is_retreating )
        {
            newmovespeed = "walk";
        }
        else if ( function_3f8db38ff773ac8d() && distance2dsquared( function_3f8db38ff773ac8d().origin, self.origin ) < squared( self.dawgaisettings.var_9bd0d58bd640e038 ) )
        {
            newmovespeed = "walk";
        }
        else
        {
            newmovespeed = "run";
        }
        
        if ( self.var_7ebcfe2aa6620601 != newmovespeed )
        {
            namespace_aafbaa6bf95d91a9::function_a8ce00e0448cb6f0( newmovespeed );
            self.var_7ebcfe2aa6620601 = newmovespeed;
            wait self.dawgaisettings.var_2b1ee04f8778d95d;
        }
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x6d12e548, Offset: 0x3414
// Size: 0x168
function private function_da3f73cd3e6aca18()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !self.dawgaisettings.var_d8701b0053b5ba17 )
    {
        return;
    }
    
    var_402ce03852cc83a4 = undefined;
    var_6a91db3bd027047 = undefined;
    
    while ( true )
    {
        enemy = function_3f8db38ff773ac8d();
        
        if ( function_423bf4b43e52bf93( enemy ) )
        {
            if ( enemy != var_402ce03852cc83a4 )
            {
                var_6a91db3bd027047 = gettime();
                var_402ce03852cc83a4 = enemy;
            }
            
            if ( var_6a91db3bd027047 && gettime() - var_6a91db3bd027047 > self.dawgaisettings.retreatdelay * 1000 )
            {
                self.is_retreating = 1;
            }
        }
        else if ( function_77d213cd96d58d54() && self.movement_goal && distance2dsquared( self.origin, enemy.origin ) >= squared( self.dawgaisettings.var_780d2bdaaffc4435 ) )
        {
        }
        else if ( !function_77d213cd96d58d54() || !self.turret.visibletarget || distance2dsquared( self.origin, enemy.origin ) >= squared( self.dawgaisettings.var_30b8c7eebcf14266 ) )
        {
            var_402ce03852cc83a4 = undefined;
            var_6a91db3bd027047 = undefined;
            self.is_retreating = undefined;
        }
        
        waitframe();
    }
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0x5c1dae65, Offset: 0x3584
// Size: 0xee
function private function_3f99321e4f4437ac( target )
{
    radius = self.dawgaisettings.var_6810258f39627f4c;
    distance = self.dawgaisettings.var_8282943b13eb8c62;
    
    if ( radius <= 0 || distance <= 0 )
    {
        return 0;
    }
    
    centroid = self getcentroid();
    target += centroid - self.origin;
    dir = vectornormalize( target - centroid );
    startpos = centroid + dir * radius;
    endpos = centroid + dir * distance;
    contents = trace::create_vehicle_contents();
    ignorelist = [ self.turret ];
    hit = physics_spherecast( startpos, endpos, radius, contents, ignorelist, "physicsquery_any" );
    return hit;
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0x4d7ff1da, Offset: 0x367b
// Size: 0x59, Type: bool
function private function_423bf4b43e52bf93( enemy )
{
    if ( !enemy )
    {
        return false;
    }
    
    if ( isplayer( enemy ) && enemy isvehicleactive() )
    {
        return false;
    }
    
    return distance2dsquared( self.origin, enemy.origin ) < squared( self.dawgaisettings.var_914fa1dc7b9b80d2 );
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xb3626e21, Offset: 0x36dd
// Size: 0x1f
function private dawg_on_player_disconnect( params )
{
    if ( self.dawg )
    {
        dawg_self_destruct();
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x879f3f3b, Offset: 0x3704
// Size: 0x45
function private function_7ceec3b4fb6cc99f()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( self.team === self.owner.team )
    {
        waitframe();
    }
    
    dawg_self_destruct();
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xa65b1846, Offset: 0x3751
// Size: 0x75
function private dawg_timeout_watcher( duration )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    waitframe();
    self.lifetimeendtime = int( duration * 1000 + gettime() );
    
    while ( self.mode == "inactive" )
    {
        waitframe();
    }
    
    wait duration;
    
    while ( getdvarint( @"hash_cc97bf9badc35748", 0 ) == 1 )
    {
        waitframe();
    }
    
    dawg_self_destruct();
}

// Namespace dawg
// Params 0
// Checksum 0x9f7e1bae, Offset: 0x37ce
// Size: 0x9
function dawg_self_destruct()
{
    thread function_f7ba99defdf16c62();
}

// Namespace dawg
// Params 2, eflags: 0x4
// Checksum 0xcf461325, Offset: 0x37df
// Size: 0xd6
function private function_f7ba99defdf16c62( attacker, instantdeath )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.mode == "inactive" )
    {
        function_c0f8880408c1c565( 0 );
        instantdeath = 1;
    }
    
    while ( self.crate.physicsactivated )
    {
        waitframe();
    }
    
    if ( self.crate )
    {
        self.crate.dawg = undefined;
    }
    
    ai::function_f4bf821b19c5ec24();
    
    if ( isdefined( self.var_79a425f0360d5a18 ) )
    {
        self.var_79a425f0360d5a18 delete();
    }
    
    if ( instantdeath )
    {
        self kill( self.origin, attacker, undefined, "MOD_CRUSH" );
        return;
    }
    
    self kill( self.origin, attacker );
}

// Namespace dawg
// Params 0
// Checksum 0x935c1801, Offset: 0x38bd
// Size: 0x15d
function function_5a26b0e63b76ad76()
{
    self notify( #"hash_15518f2b141dd1b7" );
    self endon( #"hash_15518f2b141dd1b7" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"assault_pack_ended" );
    hintpos = self gettagorigin( "tag_ammunition_box" );
    hintstring = &"killstreaks_hints/dawg_resupply";
    usedist = self.dawgaisettings.var_15f6b248965d668;
    usefov = self.dawgaisettings.var_171512efeee817a2;
    
    if ( !self.var_79a425f0360d5a18 )
    {
        self.var_79a425f0360d5a18 = gameobjects::createhintobject( hintpos, undefined, undefined, hintstring, undefined, undefined, "hide", usedist, usefov, usedist, usefov );
        self.var_79a425f0360d5a18 linkto( self, "tag_ammunition_box", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        thread utility::delete_on_death( self.var_79a425f0360d5a18 );
    }
    
    if ( !self.var_3743c28ef9851ee1 )
    {
        self.var_3743c28ef9851ee1 = [];
    }
    
    thread function_bb7473d03011438c();
    
    while ( true )
    {
        self.var_79a425f0360d5a18 waittill( #"trigger", player );
        thread dawg_assault_pack_open( player );
        waitframe();
    }
}

// Namespace dawg
// Params 0, eflags: 0xc
// Checksum 0x5d50dbc, Offset: 0x3a22
// Size: 0x196
function private function_bb7473d03011438c()
{
    self notify( #"hash_99d505384f64e10f" );
    self endon( #"hash_99d505384f64e10f" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"assault_pack_ended" );
    
    foreach ( player in teams::getenemyplayers( self.team ) )
    {
        self.var_79a425f0360d5a18 disableplayeruse( player );
    }
    
    while ( true )
    {
        foreach ( useddata in self.var_3743c28ef9851ee1 )
        {
            if ( !isplayer( useddata[ "player" ] ) )
            {
                continue;
            }
            
            if ( useddata[ "player" ].deaths == useddata[ "deaths" ] )
            {
                self.var_79a425f0360d5a18 disableplayeruse( useddata[ "player" ] );
                continue;
            }
            
            self.var_79a425f0360d5a18 enableplayeruse( useddata[ "player" ] );
        }
        
        waitframe();
    }
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0x74ce0830, Offset: 0x3bc0
// Size: 0x116
function private dawg_assault_pack_open( opener )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"assault_pack_ended" );
    useddata = [];
    useddata[ "player" ] = opener;
    useddata[ "deaths" ] = opener.deaths;
    self.var_3743c28ef9851ee1[ opener getentitynumber() ] = useddata;
    
    if ( self.streakinfo )
    {
        self.streakinfo.RESTOCKS++;
    }
    
    opener support_box::refillplayer( opener, 0 );
    
    if ( isplayer( self.owner ) && opener != self.owner )
    {
        self.owner thread points::doscoreevent( #"hash_8d2fe8950c14566" );
    }
    
    if ( self.var_d2c86a9407021bc7 )
    {
        utility::function_32b24db3127bff40( "resupply", "interact" );
        return;
    }
    
    self.var_d2c86a9407021bc7 = 1;
    utility::function_32b24db3127bff40( "assault_pack", "open" );
    self function_68f2f6fd8a4ffcae( 0, 1 );
}

// Namespace dawg
// Params 0
// Checksum 0x15ddeee7, Offset: 0x3cde
// Size: 0x95
function function_ff47adf878fb519d()
{
    self notify( #"assault_pack_ended" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.var_79a425f0360d5a18 )
    {
        self.var_79a425f0360d5a18 delete();
        self.var_79a425f0360d5a18 = undefined;
    }
    
    if ( self.var_d2c86a9407021bc7 )
    {
        self.var_d2c86a9407021bc7 = 0;
        utility::function_32b24db3127bff40( "assault_pack", "close" );
        self function_68f2f6fd8a4ffcae( 0, 3 );
        wait 1;
        
        if ( !self.var_d2c86a9407021bc7 )
        {
            self function_68f2f6fd8a4ffcae( 0, 0 );
        }
    }
}

/#

    // Namespace dawg
    // Params 0, eflags: 0x4
    // Checksum 0x60c34e61, Offset: 0x3d7b
    // Size: 0x263, Type: dev
    function private setup_dawg_devgui()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x30>", "<dev string:x3e>", &dawg_target_player );
        devgui::function_cd4e263c1f3018ae( "<dev string:x51>", "<dev string:x69>", &function_41cb805117f8379f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x81>", "<dev string:x97>", &function_bd9419b35d49f31b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaa>", "<dev string:xc0>", &function_bd9419b35d49f31b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd3>", "<dev string:xe8>", &function_bd9419b35d49f31b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfb>", "<dev string:x113>", &function_bd9419b35d49f31b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x126>", "<dev string:x140>", &set_dawg_health );
        devgui::function_cd4e263c1f3018ae( "<dev string:x152>", "<dev string:x16f>", &set_dawg_health );
        devgui::function_cd4e263c1f3018ae( "<dev string:x181>", "<dev string:x19f>", &set_dawg_health );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1b1>", "<dev string:x1cd>", &set_dawg_health );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1df>", "<dev string:x1f5>", &function_208725a60b520fb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x210>", "<dev string:x225>", &function_208725a60b520fb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x240>", "<dev string:x254>", &function_208725a60b520fb );
        devgui::function_cd4e263c1f3018ae( "<dev string:x26f>", "<dev string:x28f>", &function_bb1e7c52c604a1fd );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a8>", "<dev string:x2cb>", &function_bb1e7c52c604a1fd );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e4>", "<dev string:x309>", &function_bb1e7c52c604a1fd );
        devgui::function_cd4e263c1f3018ae( "<dev string:x322>", "<dev string:x333>", &function_b4711e68bb98fb6a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x345>", "<dev string:x359>", &function_b4711e68bb98fb6a );
        devgui::function_eaac4ba4b3caf621( "<dev string:x36b>", @"hash_5db66820fb05e65" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x37f>", @"hash_84cdc81175d56f82" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x394>", "<dev string:x3af>", &function_3303cb8bf82cb9dc );
        devgui::function_eaac4ba4b3caf621( "<dev string:x3cf>", @"hash_cc97bf9badc35748" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x3e4>", @"hash_5322ee74d240eeb6" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x3f8>", @"hash_1ae638cab9d29912" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x408>", @"hash_fd52b770bfc79d5d" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x41a>", @"hash_354af68d1313857f" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x432>", @"hash_74ddabe695e8478" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0xf30ade86, Offset: 0x3fe6
    // Size: 0x115, Type: dev
    function private dawg_target_player( params )
    {
        player = level.players[ 0 ];
        ai_array = getaiarray( player.team );
        
        foreach ( ai in ai_array )
        {
            if ( !isalive( ai ) || isdefined( ai.subclass ) && !issubstr( ai.subclass, "<dev string:x447>" ) )
            {
                continue;
            }
            
            if ( player.team == "<dev string:x44c>" )
            {
                ai.team = "<dev string:x451>";
                continue;
            }
            
            ai.team = "<dev string:x44c>";
        }
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0x6d537015, Offset: 0x4103
    // Size: 0x20, Type: dev
    function private function_bd9419b35d49f31b( params )
    {
        setdvar( @"hash_6080ba62e2bc0f6b", params[ 0 ] );
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0xea57a98e, Offset: 0x412b
    // Size: 0x20, Type: dev
    function private function_208725a60b520fb( params )
    {
        setdvar( @"hash_d4ff542145583a4b", params[ 0 ] );
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0xea5ffc22, Offset: 0x4153
    // Size: 0x174, Type: dev
    function private set_dawg_health( params )
    {
        foreach ( dawg in level.dawgs )
        {
            if ( !isagent( dawg ) )
            {
                continue;
            }
            
            switch ( params[ 0 ] )
            {
                case #"hash_31100fbc01bd387c":
                    newhealth = dawg.maxhealth * dawg.dawgaisettings.lightdamagepercent;
                    break;
                case #"hash_311012bc01bd3d35":
                    newhealth = dawg.maxhealth * dawg.dawgaisettings.mediumdamagepercent;
                    break;
                case #"hash_311011bc01bd3ba2":
                    newhealth = dawg.maxhealth * dawg.dawgaisettings.heavydamagepercent;
                    break;
                default:
                    newhealth = dawg.maxhealth;
                    break;
            }
            
            dawg.health = int( newhealth );
            dawg function_c0f8880408c1c565( dawg.health );
        }
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0x1bb305e0, Offset: 0x42cf
    // Size: 0xc3, Type: dev
    function private function_41cb805117f8379f( params )
    {
        if ( getdvarint( @"hash_6c929b8ae922688f", 0 ) == 0 )
        {
            setdvar( @"hash_6c929b8ae922688f", 1 );
            
            foreach ( dawg in level.dawgs )
            {
                if ( !isagent( dawg ) )
                {
                    continue;
                }
                
                dawg.owner thread dawg_mp::function_3e86a2718218face( dawg );
            }
        }
    }

    // Namespace dawg
    // Params 0, eflags: 0x4
    // Checksum 0x47d9af19, Offset: 0x439a
    // Size: 0x3b, Type: dev
    function private debug_draw_dawg()
    {
        if ( getdvarint( @"hash_5db66820fb05e65", 0 ) == 1 )
        {
            function_958e911f638aad06();
        }
        
        if ( getdvarint( @"hash_84cdc81175d56f82", 0 ) == 1 )
        {
            function_91b6ba94bd9a58db();
        }
    }

    // Namespace dawg
    // Params 0, eflags: 0x4
    // Checksum 0xcc3e8933, Offset: 0x43dd
    // Size: 0xc2, Type: dev
    function private function_958e911f638aad06()
    {
        pathpoints = self getpath( 1 );
        pathcolor = ( 1, 0, 0 );
        
        if ( pathpoints.size > 0 )
        {
            line( self.origin, pathpoints[ 0 ], pathcolor, 1, 0, 1 );
            sphere( pathpoints[ 0 ], 5, pathcolor, 0, 1 );
        }
        else if ( self.movement_goal )
        {
            sphere( self.movement_goal, 5, pathcolor, 0, 1 );
        }
        
        for ( index = 1; index < pathpoints.size ; index++ )
        {
            line( pathpoints[ index - 1 ], pathpoints[ index ], pathcolor, 1, 0, 1 );
            sphere( pathpoints[ index ], 5, pathcolor, 0, 1 );
        }
    }

    // Namespace dawg
    // Params 0, eflags: 0x4
    // Checksum 0x1d8e42e5, Offset: 0x44a7
    // Size: 0x65, Type: dev
    function private function_91b6ba94bd9a58db()
    {
        enemy = function_3f8db38ff773ac8d();
        
        if ( enemy )
        {
            if ( self.var_6b4d17f041d5c0b9 )
            {
                sphere( enemy getcentroid(), 40, ( 0, 1, 0 ), 0, 1 );
                return;
            }
            
            sphere( enemy getcentroid(), 40, ( 1, 0.25, 0 ), 0, 1 );
        }
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0x89b7362a, Offset: 0x4514
    // Size: 0xbd, Type: dev
    function private function_3303cb8bf82cb9dc( params )
    {
        if ( getdvarint( @"hash_2bca332367faa5f8", 0 ) == 0 )
        {
            setdvar( @"hash_2bca332367faa5f8", 1 );
        }
        else
        {
            setdvar( @"hash_2bca332367faa5f8", 0 );
        }
        
        foreach ( dawg in level.dawgs )
        {
            dawg thread function_489a303adb3c17e3();
        }
    }

    // Namespace dawg
    // Params 0, eflags: 0x4
    // Checksum 0x7fbcdad2, Offset: 0x45d9
    // Size: 0x13c, Type: dev
    function private function_489a303adb3c17e3()
    {
        if ( !isplayer( self.owner ) )
        {
            return;
        }
        
        level endon( #"game_ended" );
        self endon( #"death" );
        self.owner endon( #"death_or_disconnect" );
        
        while ( getdvarint( @"hash_2bca332367faa5f8", 0 ) == 1 )
        {
            self.owner waittill( #"weapon_fired" );
            
            if ( getdvarint( @"hash_2bca332367faa5f8", 0 ) == 1 )
            {
                startpos = self.owner geteye();
                endpos = self.owner player_utility::getplayerlookatpos( self.owner );
                contents = trace::create_character_contents();
                ignorelist = [];
                hit = physics_raycast( startpos, endpos, contents, ignorelist, 0, "<dev string:x45e>" );
                ent = hit[ 0 ][ "<dev string:x473>" ];
                
                if ( isplayer( ent ) )
                {
                    self.var_24700fd10a27b994 = ent;
                    self.var_819553d091947617 = undefined;
                    continue;
                }
                
                self.var_24700fd10a27b994 = undefined;
                self.var_819553d091947617 = endpos;
            }
        }
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0x9677fe24, Offset: 0x471d
    // Size: 0xce, Type: dev
    function private function_b4711e68bb98fb6a( params )
    {
        foreach ( dawg in level.dawgs )
        {
            dawg ai::function_f4bf821b19c5ec24();
            
            if ( params[ 0 ] == "<dev string:x47a>" )
            {
                dawg kill( dawg.origin );
                continue;
            }
            
            if ( params[ 0 ] == "<dev string:x458>" )
            {
                dawg kill( dawg.origin, undefined, undefined, "<dev string:x47c>" );
            }
        }
    }

    // Namespace dawg
    // Params 1, eflags: 0x4
    // Checksum 0xe0abd425, Offset: 0x47f3
    // Size: 0x156, Type: dev
    function private function_bb1e7c52c604a1fd( params )
    {
        foreach ( dawg in level.dawgs )
        {
            dawg._blackboard.var_224d529c5512a171 = 0;
            dawg.var_df03542cdd7c5f0b = 0;
            dawg.var_2726e44ca10e0a06 = 0;
            dawg.var_341e9d7ba3a43621 = 0;
            dawg.var_89c52e4956afcca7 = 0;
            dawg.var_6d6b37b571f9093d = 0;
            
            if ( params[ 0 ] == "<dev string:x458>" )
            {
                dawg._blackboard.var_224d529c5512a171 = 1;
                continue;
            }
            
            if ( params[ 0 ] == "<dev string:x45a>" )
            {
                dawg.var_df03542cdd7c5f0b = 1;
                dawg.var_2726e44ca10e0a06 = 1;
                dawg.var_341e9d7ba3a43621 = 60;
                dawg.var_89c52e4956afcca7 = 0.2;
                dawg.var_6d6b37b571f9093d = 0;
            }
        }
    }

#/

// Namespace dawg
// Params 0
// Checksum 0xa160fe0a, Offset: 0x4951
// Size: 0xa0
function function_cf1744a0fe86c812()
{
    prefab_brushmodel = getent( "dawg_sentry_col", #targetname );
    
    if ( !isdefined( prefab_brushmodel ) )
    {
        return 0;
    }
    
    if ( isdefined( self.var_b566b2d61a12539d ) )
    {
        self.var_b566b2d61a12539d delete();
    }
    
    var_b566b2d61a12539d = spawn( "script_model", self.origin );
    var_b566b2d61a12539d dontinterpolate();
    var_b566b2d61a12539d.angles = self.angles;
    var_b566b2d61a12539d clonebrushmodeltoscriptmodel( prefab_brushmodel );
    var_b566b2d61a12539d linkto( self );
    self.var_b566b2d61a12539d = var_b566b2d61a12539d;
    thread utility::delete_on_death( var_b566b2d61a12539d );
}

// Namespace dawg
// Params 0
// Checksum 0xc694c741, Offset: 0x49f9
// Size: 0x152
function sentry_mode_trophy_system()
{
    if ( !isdefined( self.trophycharges ) )
    {
        self.trophycharges = 4;
    }
    
    if ( !self.var_a09a369201eaecdc )
    {
        self.var_a09a369201eaecdc = spawn( "script_model", self.origin );
        self.var_a09a369201eaecdc.killcament = self.killcament;
        self.var_a09a369201eaecdc.owner = self.owner;
        self.var_a09a369201eaecdc.team = self.team;
        self.var_a09a369201eaecdc setotherent( self.owner );
        self.var_a09a369201eaecdc setentityowner( self.owner );
        bundle = level.streakglobals.streakbundles[ "dawg" ];
        self.var_a09a369201eaecdc setmodel( bundle.var_2611279e66c6ff80 );
        thread utility::delete_on_death( self.var_a09a369201eaecdc );
    }
    
    thread function_d41f54e81cb88b3();
    thread trophy_system::trophy_watchprotection( self.dawgaisettings.trophyoffset, self.dawgaisettings.trophyradius, &function_8b8b09562056490f, &function_ce522c0b5fb78aad );
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x8afbdd9e, Offset: 0x4b53
// Size: 0x20, Type: bool
function private function_8b8b09562056490f()
{
    return self.mode == "sentry" && self.trophycharges > 0;
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0xf99122f1, Offset: 0x4b7c
// Size: 0x1f
function private function_ce522c0b5fb78aad( trophytarget )
{
    function_23cb4e7a4ef9a4f5( trophytarget );
    self.trophycharges--;
}

// Namespace dawg
// Params 1
// Checksum 0x13f34f9a, Offset: 0x4ba3
// Size: 0x8f
function function_23cb4e7a4ef9a4f5( trophytarget )
{
    trophytarget setcandamage( 0 );
    trophytarget stopsounds( 0 );
    self.owner damagefeedback::updatedamagefeedback( "hitdawgtrophysystem", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
    self.owner thread points::function_f8a0deb1a12da52e( #"dawg_trophy_defense", undefined, self.streakinfo.bundle.lootid );
    function_fab90126fd08d11a( trophytarget );
    
    if ( !trophytarget equipment_mp::ondestroyedbytrophy() )
    {
        trophytarget delete();
    }
}

// Namespace dawg
// Params 1
// Checksum 0xebf4f618, Offset: 0x4c3a
// Size: 0xaa
function function_fab90126fd08d11a( trophytarget )
{
    self.var_a09a369201eaecdc dontinterpolate();
    self.var_a09a369201eaecdc.origin = vectorlerp( trophytarget.origin, self.origin, 0.2 );
    self.var_a09a369201eaecdc.angles = combineangles( vectortoangles( self.origin - self.var_a09a369201eaecdc.origin ), ( -90, 0, 0 ) );
    self.var_a09a369201eaecdc setscriptablepartstate( "explode1", "activeDirectional", 0 );
}

// Namespace dawg
// Params 0, eflags: 0xc
// Checksum 0x5c96ce2c, Offset: 0x4cec
// Size: 0xb6
function private function_d41f54e81cb88b3()
{
    self notify( #"hash_23a1038b6f163df8" );
    self endon( #"hash_23a1038b6f163df8" );
    level endon( #"game_ended" );
    self endon( #"death" );
    turret = self.turret;
    turret setscriptablepartstate( "trophy", "open" );
    wait 1;
    
    if ( self.mode == "sentry" )
    {
        turret setscriptablepartstate( "trophy", "loop" );
        self waittill( #"mode_changed" );
    }
    
    turret setscriptablepartstate( "trophy", "close" );
    wait 1;
    turret setscriptablepartstate( "trophy", "off" );
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x3f7b25e6, Offset: 0x4daa
// Size: 0xdd, Type: bool
function private function_6ee09551739ee12f()
{
    goalvol = self getgoalvolume();
    enemy = function_3f8db38ff773ac8d();
    
    if ( isdefined( goalvol ) && isalive( enemy ) )
    {
        if ( self.var_70cc78291066166 && self.turret dawg_turret::dawg_turret_can_see( enemy ) )
        {
            dawg_set_goal();
            return true;
        }
        
        if ( !( gettime() < self.var_fa6c7215c74e59a0 ) )
        {
            self.var_fa6c7215c74e59a0 = gettime() + 350;
            lospos = enemy geteye();
            pos = findclosestlospointwithinvolume( goalvol, lospos, lospos );
            
            if ( !isdefined( pos ) )
            {
                pos = findclosestnonlospointwithinvolume( goalvol, lospos, lospos );
            }
            
            if ( !pos || !dawg_set_goal( pos ) )
            {
                self function_dd3b2de3b28ea995( 0, goalvol );
                self.movement_goal = pos;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace dawg
// Params 1
// Checksum 0xe4d16727, Offset: 0x4e90
// Size: 0x17
function function_be8f466b087210a0( origin )
{
    self.var_f9f0278fa61d5351 = origin;
}

// Namespace dawg
// Params 0
// Checksum 0x30eaf33c, Offset: 0x4eaf
// Size: 0xc
function function_5c0b70f358c5637f()
{
    self.var_f9f0278fa61d5351 = undefined;
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0xf2bc8654, Offset: 0x4ec3
// Size: 0xb
function private function_4b8430fe0e9439bc()
{
    return self.var_f9f0278fa61d5351;
}

// Namespace dawg
// Params 0
// Checksum 0xb09f79ff, Offset: 0x4ed7
// Size: 0x53
function get_safeguard_pos()
{
    safeguard_ent = self getsafeguardent();
    
    if ( safeguard_ent )
    {
        return safeguard_ent.origin;
    }
    
    if ( function_4b8430fe0e9439bc() )
    {
        return function_4b8430fe0e9439bc();
    }
    
    if ( self.spawnorigin )
    {
        return self.spawnorigin;
    }
    
    return self.origin;
}

// Namespace dawg
// Params 0
// Checksum 0x4525633c, Offset: 0x4f33
// Size: 0xd7
function function_a0fcf66315432512()
{
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    createthreatbiasgroup( "dawg" );
    
    if ( bundle.var_5fc6fd0988afc650 )
    {
        setthreatbias( "dawg", "dawg", -2147483648 );
    }
    
    if ( bundle.var_a763d8622544acfd )
    {
        createthreatbiasgroup( "remote_robot" );
        setthreatbias( "remote_robot", "dawg", -2147483648 );
    }
    
    if ( bundle.var_21cb6647111c8d0d )
    {
        createthreatbiasgroup( "Lethal_Static" );
        setthreatbias( "Lethal_Static", "dawg", -2147483648 );
    }
    
    if ( bundle.var_622c5037520df09e )
    {
        createthreatbiasgroup( "Tactical_Static" );
        setthreatbias( "Tactical_Static", "dawg", -2147483648 );
    }
}

// Namespace dawg
// Params 0, eflags: 0x4
// Checksum 0x4805c76, Offset: 0x5012
// Size: 0xf1
function private function_7271a02f20893a23()
{
    self endon( #"death" );
    waitframe();
    killcament = spawn( "script_model", self.origin );
    killcament setmodel( "tag_origin" );
    killcament namespace_9d8e359c3b1041e5::setscriptmoverkillcamsharedfunc( "turret" );
    self.turret.killcament = killcament;
    thread utility::delete_on_death( killcament );
    
    if ( self.dawgaisettings.var_dfe7fdfcf02dc1d6 )
    {
        thread function_270e3f2f032d8745( killcament );
        return;
    }
    
    offset = ( self.dawgaisettings.var_1a367fe0892d6a98, self.dawgaisettings.var_444207ac52627edb, self.dawgaisettings.killcamzoffset );
    killcament linkto( self, "tag_origin", offset, ( self.dawgaisettings.var_d547546c85764112, 0, 0 ) );
}

// Namespace dawg
// Params 1, eflags: 0x4
// Checksum 0x1fdb3043, Offset: 0x510b
// Size: 0x1ae
function private function_270e3f2f032d8745( killcament )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.turret ) )
        {
            break;
        }
        else if ( self.turret.visibletarget )
        {
            dirvector = self.turret.visibletarget getcentroid() - killcament.origin;
            targetangles = vectortoangles( dirvector );
            targetangles = angleclamp180( targetangles );
            targetangles = ( clamp( targetangles[ 0 ], -45, 45 ), targetangles[ 1 ], 0 );
            killcament rotateto( targetangles, self.dawgaisettings.var_b472360d59079b8f );
        }
        else
        {
            targetangles = ( self.dawgaisettings.var_d547546c85764112, self.turret getturretworldangles( 0 )[ 1 ], 0 );
            killcament rotateto( targetangles, self.dawgaisettings.var_3a4de92ddc2afda0 );
        }
        
        zoffset = self.var_8666a991e34bea40 ? self.dawgaisettings.var_939d25a776b6ec8e : self.dawgaisettings.killcamzoffset;
        killcamoffset = ( self.dawgaisettings.var_1a367fe0892d6a98, self.dawgaisettings.var_444207ac52627edb, zoffset );
        targetorigin = self.origin + rotatevector( killcamoffset, targetangles );
        killcament moveto( targetorigin, self.dawgaisettings.var_1277db0437d1b782 );
        waitframe();
    }
}

