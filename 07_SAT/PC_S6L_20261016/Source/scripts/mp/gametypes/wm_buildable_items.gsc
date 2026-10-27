// scripts\mp\gametypes\wm_buildable_items.gsc  (hash_62384cde1a08c286.gscc) (size: 32588 Bytes / 0x7f4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d0ed457 (2098123863)
// size ...... 32588 (0x7f4c)
// includes .. 12  (offset: 0x7574)
// strings ... 112 (offset: 0x75d4)
// dev strs .. 3   (offset: 0x7e6c)
// exports ... 63  (offset: 0x5608)
// cseg ...... 0xa43 + 0x4bc5 (0x5608)
// imports ... 166 (offset: 0x5fe0)
// animtree1 . 1   (offset: 0x7e98)
// animtree2 . 9   (offset: 0x7eb0)
#using script_a34e6e05805c9de;
#using scripts\common\utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_buildable;
#using scripts\mp\hostmigration;

#namespace wm_buildable_items;

// Namespace wm_buildable_items
// Params 0
// Checksum 0x15665d99, Offset: 0xa61
// Size: 0x9d
function function_ae496d0a0ddfe443()
{
    isinit = level wm_buildable::function_7a76ffb01722e5e1();
    
    if ( isinit )
    {
        function_4ac1bf8123bc92bb();
        function_7d5c7c55d721668b();
        function_381b9e4b59d89075();
        function_9032322f2988910b();
        function_c3228127f9429e14();
        function_97cc334e09df0157();
        function_223c8458a6f3cf68();
        level function_146a43e498bd1e0f();
        level function_79fe00425be9bd2d();
        level function_c4539289054e6613();
        level function_65f48a9a17bc806e();
        level._effect[ "sandbag_built" ] = loadfxasset( "vfx_jup_level_mp_launchfacility_lf_sandbags_debris_02" );
        level._effect[ "turret_fixed" ] = loadfxasset( "vfx_jup_level_mp_launchfacility_lf_machinegun_repaired_glow" );
    }
}

#using_animtree( "animated_props" );

// Namespace wm_buildable_items
// Params 0
// Checksum 0x66dee2b2, Offset: 0xb06
// Size: 0xf5
function function_381b9e4b59d89075()
{
    level.scr_animtree[ "Hesco" ] = #animtree;
    level.scr_anim[ "Hesco" ][ "building" ] = %jup_fxanim_war_military_buildable_set_cosecho_barrier_open_01;
    level.scr_animname[ "Hesco" ][ "building" ] = "jup_fxanim_war_military_buildable_set_cosecho_barrier_open_01";
    level.scr_anim[ "Hesco" ][ "idle" ] = %jup_fxanim_war_military_buildable_set_cosecho_barrier_idle;
    level.scr_animname[ "Hesco" ][ "idle" ] = "jup_fxanim_war_military_buildable_set_cosecho_barrier_idle";
    level.var_a56a0f9bbb5684f3[ "Hesco" ] = [];
    level.var_a56a0f9bbb5684f3[ "Hesco" ][ "models" ] = [ "jup_military_buildable_cosecho_barrier_02_fxanim" ];
    level.var_a56a0f9bbb5684f3[ "Hesco" ][ "animations" ] = [ "Hesco", [ "building" ], [ "idle" ] ];
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x752c27ac, Offset: 0xc03
// Size: 0xbc
function function_97cc334e09df0157()
{
    buildinfo = spawnstruct();
    buildinfo.models = level.var_a56a0f9bbb5684f3[ "Hesco" ][ "models" ];
    buildinfo.animations = level.var_a56a0f9bbb5684f3[ "Hesco" ][ "animations" ];
    buildinfo.buildusetime = 4;
    buildinfo.hintstring = &"mp_jup_wm/build";
    buildinfo.var_33237f45f5760876 = &function_d2b1f4e1bb81565d;
    buildinfo.var_6a7941b3aef1c16 = &function_e6dd0aefa6c9b56b;
    buildinfo.var_ebd73781da1158ea = &function_38aa6ebff0d9288b;
    level.buildablepool[ "bdb_hesco" ] = buildinfo;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xfc0000eb, Offset: 0xcc7
// Size: 0x379
function function_c4539289054e6613()
{
    ents = getentarray( "tri_build_hesco", #targetname );
    
    foreach ( ent in ents )
    {
        hescostruct = utility::getstruct( ent.target, "targetname" );
        hescoclips = getentarray( hescostruct.target, #targetname );
        
        if ( !( isdefined( hescostruct ) && isdefined( hescoclips ) ) )
        {
            continue;
        }
        
        buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_hesco", ent, ent.script_noteworthy, 0, hescostruct.origin, hescostruct.angles );
        ent.buildable = buildable;
        ent.buildable.clips = hescoclips;
        
        foreach ( clip in hescoclips )
        {
            clip notsolid();
            
            if ( !isdefined( clip.script_parameters ) )
            {
                ent.buildable.clip = clip;
                ent.buildable.clip connectpaths();
                ent.buildable.clip.origin -= ( 0, 0, 50 );
            }
            else if ( clip.script_parameters == "surrounding" )
            {
                clip.origin -= ( 0, 0, 50 );
                
                if ( !isdefined( ent.buildable.surroundingclips ) )
                {
                    ent.buildable.surroundingclips = [];
                }
                
                ent.buildable.surroundingclips[ ent.buildable.surroundingclips.size ] = clip;
            }
            else if ( clip.script_parameters == "pop_up" )
            {
                ent.buildable.pushingclip = clip;
            }
            
            clip.moverdoesnotkill = 1;
        }
        
        if ( isdefined( ent.buildable.models[ 0 ] ) )
        {
            ent.buildable.models[ 0 ].outlineid = outline::outlineenableforall( ent.buildable.models[ 0 ], "shimmer_crafting_wm_buildable", "level_script" );
        }
        
        ent usetriggerrequirelookat( 1 );
    }
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x9ef689ef, Offset: 0x1048
// Size: 0x1c0
function function_d2b1f4e1bb81565d( player, buildable )
{
    pushingdir = 50 * anglestoright( buildable.models[ 0 ].angles );
    buildable.pushingclip solid();
    buildable.pushingclip.originpos = buildable.pushingclip.origin;
    buildable.pushingclip moveto( buildable.pushingclip.origin + pushingdir, 0.2 );
    
    /#
        sphere( buildable.pushingclip.origin, 10, undefined, undefined, 10000 );
    #/
    
    foreach ( clip in buildable.surroundingclips )
    {
        clip solid();
        clip.originpos = clip.origin;
        clip utility::delaycall( 0.2, &movez, 50, 0.2 );
    }
    
    buildable.clip solid();
    buildable.clip.originpos = buildable.clip.origin;
    buildable.clip movez( 50, 4 );
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x9beec5a5, Offset: 0x1210
// Size: 0xb4
function function_e6dd0aefa6c9b56b( player, buildable )
{
    foreach ( clip in buildable.clips )
    {
        clip notsolid();
        
        if ( isdefined( clip.originpos ) )
        {
            clip.origin = clip.originpos;
        }
    }
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x5b552b38, Offset: 0x12cc
// Size: 0x115
function function_38aa6ebff0d9288b( player, buildable )
{
    foreach ( clip in buildable.clips )
    {
        if ( isdefined( clip.script_parameters ) )
        {
            clip notsolid();
            clip delete();
            continue;
        }
        
        clip disconnectpaths();
    }
    
    if ( isdefined( buildable.models[ 0 ] ) )
    {
        playfx( level._effect[ "sandbag_built" ], buildable.models[ 0 ].origin );
    }
    
    outline::outlinedisable( buildable.models[ 0 ].outlineid, buildable.models[ 0 ] );
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xd5ea032b, Offset: 0x13e9
// Size: 0x13d
function function_7d5c7c55d721668b()
{
    level.scr_animtree[ "TankTrap" ] = #animtree;
    level.scr_anim[ "TankTrap" ][ "idle" ] = %jup_fxanim_war_military_buildable_hedgehog_idle;
    level.scr_animname[ "TankTrap" ][ "idle" ] = "jup_fxanim_war_military_buildable_hedgehog_idle";
    level.scr_anim[ "TankTrap" ][ "building" ] = %jup_fxanim_war_military_buildable_hedgehog_repair;
    level.scr_animname[ "TankTrap" ][ "building" ] = "jup_fxanim_war_military_buildable_hedgehog_repair";
    level.scr_anim[ "TankTrap" ][ "destroy" ] = %jup_fxanim_war_military_buildable_hedgehog_destroy;
    level.scr_animname[ "TankTrap" ][ "destroy" ] = "jup_fxanim_war_military_buildable_hedgehog_destroy";
    level.var_a56a0f9bbb5684f3[ "TankTrap" ] = [];
    level.var_a56a0f9bbb5684f3[ "TankTrap" ][ "models" ] = [ "jup_military_buildable_hedgehog_02_fxanim" ];
    level.var_a56a0f9bbb5684f3[ "TankTrap" ][ "animations" ] = [ "TankTrap", [ "building" ], [ "idle" ], [ "destroy" ] ];
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x3bf5d21f, Offset: 0x152e
// Size: 0xcd
function function_223c8458a6f3cf68()
{
    buildinfo = spawnstruct();
    buildinfo.models = level.var_a56a0f9bbb5684f3[ "TankTrap" ][ "models" ];
    buildinfo.animations = level.var_a56a0f9bbb5684f3[ "TankTrap" ][ "animations" ];
    buildinfo.buildusetime = 4;
    buildinfo.hintstring = &"mp_jup_wm/build";
    buildinfo.gestureweapon = "jup_war_ges_wrench_hedgehog";
    buildinfo.var_33237f45f5760876 = &function_af0225fde23f981a;
    buildinfo.var_6a7941b3aef1c16 = &function_e817cb7ddec4491a;
    buildinfo.var_ebd73781da1158ea = &function_ec57fdab500fc1f2;
    level.buildablepool[ "bdb_tankTrap" ] = buildinfo;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x3ad520ab, Offset: 0x1603
// Size: 0x300
function function_65f48a9a17bc806e()
{
    ents = getentarray( "tri_build_tank_trap", #targetname );
    
    foreach ( index, ent in ents )
    {
        tanktrapstruct = utility::getstruct( ent.target, "targetname" );
        buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_tankTrap", ent, ent.script_noteworthy, 0, tanktrapstruct.origin, tanktrapstruct.angles );
        ent.buildable = buildable;
        ent.id = index;
        
        if ( isdefined( ent.buildable.models[ 0 ] ) )
        {
            ent.buildable.models[ 0 ].outlineid = outline::outlineenableforall( ent.buildable.models[ 0 ], "shimmer_crafting_wm_buildable", "level_script" );
        }
        
        tanktrapclip = getent( tanktrapstruct.target, #targetname );
        tanktrapclip notsolid();
        tanktrapclip.origin -= ( 0, 0, 50 );
        tanktrapclip.originalpos = tanktrapclip.origin;
        tanktrapclip.movingdir = anglestoforward( tanktrapstruct.angles );
        buildable.clip = tanktrapclip;
        entparts = getentarray( ent.target, #targetname );
        
        foreach ( part in entparts )
        {
            if ( !isdefined( part.script_noteworthy ) )
            {
                continue;
            }
            
            if ( part.script_noteworthy == "destroy_trigger" )
            {
                ent.destroytrigger = part;
            }
        }
        
        [ buildable.c4 ] = getscriptablearray( ent.target, #targetname );
        ent usetriggerrequirelookat( 1 );
        ent thread function_c0ef0c866d826855();
        buildable thread function_cd622d493f5b1bbd( "zone_2" );
    }
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x152be1ca, Offset: 0x190b
// Size: 0x1e
function function_af0225fde23f981a( player, buildable )
{
    buildable thread pushingplayer();
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x2b0c84ca, Offset: 0x1931
// Size: 0xb7
function pushingplayer()
{
    level endon( #"game_ended" );
    self endon( #"stop_building" );
    self notify( #"start_push" );
    self endon( #"start_push" );
    tanktrapclip = self.clip;
    tanktrapclip solid();
    tanktrapclip movez( 50, 0.2 );
    wait 0.2;
    goalpos = tanktrapclip.origin + tanktrapclip.movingdir * 60;
    tanktrapclip moveto( goalpos, 0.2 );
    wait 0.2;
    tanktrapclip notsolid();
    tanktrapclip.origin = tanktrapclip.originalpos;
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x5f654f54, Offset: 0x19f0
// Size: 0x57
function function_e817cb7ddec4491a( player, buildable )
{
    buildable notify( #"stop_building" );
    tanktrapclip = buildable.clip;
    tanktrapclip notsolid();
    tanktrapclip.origin = tanktrapclip.originalpos;
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0xcadb76bf, Offset: 0x1a4f
// Size: 0x155
function function_ec57fdab500fc1f2( player, buildable )
{
    ent = buildable.triggerent;
    playfx( level._effect[ "sandbag_built" ], buildable.models[ 0 ].origin );
    buildable thread function_d6c80d4cea37db7b( "zone_2" );
    buildable.clip notsolid();
    buildable.clip.origin = buildable.clip.originalpos;
    buildable.c4 setscriptablepartstate( "body", "built" );
    buildable.c4.outlineid = outline::outlineenableforall( buildable.c4, "shimmer_crafting_wm_buildable", "level_script" );
    destroyobj = wm_buildable::function_ce601a864bcc009( buildable, ent.destroytrigger, &"mp_jup_launchfacility/removetanktrap", 3, undefined, &function_610f91711f038f4 );
    setomnvar( "ui_wm_escort_trap_" + ent.id, ent.progress );
    buildable thread wm_buildable::function_8df0f56e40ca484b( buildable.models[ 0 ], "hogs_destroyed" );
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0x40543aa6, Offset: 0x1bac
// Size: 0x1b7
function function_610f91711f038f4( player )
{
    self.buildable notify( #"trap_destroyed" );
    ent = self.buildable.triggerent;
    setomnvar( "ui_wm_escort_trap_" + ent.id, 0 );
    oldmodel = self.buildable.models[ 0 ];
    
    if ( isdefined( oldmodel ) )
    {
        outline::outlinedisable( oldmodel.outlineid, oldmodel );
    }
    
    var_e0d4519ca0e6007e = oldmodel.origin;
    var_c6d788951f6b9014 = oldmodel.angles;
    newbuildable = wm_buildable::function_b1b8c1bd62c625bf( self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, var_e0d4519ca0e6007e, var_c6d788951f6b9014 );
    ent.buildable = newbuildable;
    newbuildable.clip = self.buildable.clip;
    newmodel = newbuildable.models[ 0 ];
    
    if ( isdefined( newmodel ) )
    {
        newmodel.outlineid = outline::outlineenableforall( newmodel, "shimmer_crafting_wm_buildable", "level_script" );
    }
    
    ent.buildable.c4 = self.buildable.c4;
    ent usetriggerrequirelookat( 1 );
    ent thread function_c0ef0c866d826855();
    newbuildable thread function_cd622d493f5b1bbd( "zone_2" );
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x5928a5d1, Offset: 0x1d6b
// Size: 0xf2
function function_c0ef0c866d826855()
{
    self notify( #"hash_6c308c799a736780" );
    self endon( #"hash_6c308c799a736780" );
    level endon( #"game_ended" );
    pathnodes = getvehiclenodearray( "tank_trap_pos", #script_noteworthy );
    pathnode = sortbydistance( pathnodes, self.origin )[ 0 ];
    flags::gameflagwait( "zone_2" + "_objective_start" );
    distsquared = distance2dsquared( self.origin, pathnode.origin );
    
    if ( distsquared > 3000 )
    {
        assertmsg( distsquared + "<dev string:x24>" + self.origin + "<dev string:x43>" );
        self.buildable.useobj.trigger makeunusable();
    }
    
    self.progress = pathnode.progress;
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0x8d50a448, Offset: 0x1e65
// Size: 0x27a
function function_cd622d493f5b1bbd( zoneinfo )
{
    level endon( #"game_ended" );
    flags::gameflagwait( zoneinfo + "_objective_start" );
    tank = level.escortvehicles[ 0 ];
    
    while ( !( isdefined( self.triggerent.progress ) && isdefined( tank.progress ) && isdefined( tank.var_4f6ccc87c3912e74 ) ) )
    {
        waitframe();
    }
    
    var_a1b8191b1715d31d = spawn( "script_model", self.triggerent.origin );
    var_a1b8191b1715d31d.angles = self.triggerent.angles;
    var_a1b8191b1715d31d makeusable();
    var_a1b8191b1715d31d sethintdisplayrange( 256 );
    var_a1b8191b1715d31d sethintdisplayfov( 360 );
    var_a1b8191b1715d31d setuserange( 256 );
    var_a1b8191b1715d31d setusefov( 360 );
    var_a1b8191b1715d31d sethintonobstruction( "show" );
    var_a1b8191b1715d31d setcursorhint( "HINT_NOBUTTON" );
    var_a1b8191b1715d31d sethintstring( &"mp/unable_to_build_trap" );
    
    while ( self.buildphase == 0 )
    {
        if ( abs( self.triggerent.progress - tank.progress ) > tank.var_4f6ccc87c3912e74 * 400 )
        {
            self.useobj.trigger makeusable();
            
            foreach ( player in level.players )
            {
                var_a1b8191b1715d31d disableplayeruse( player );
            }
        }
        else
        {
            self.useobj.trigger makeunusable();
            
            foreach ( player in level.players )
            {
                var_a1b8191b1715d31d enableplayeruse( player );
            }
        }
        
        waitframe();
    }
    
    var_a1b8191b1715d31d delete();
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0x7ca834d5, Offset: 0x20e7
// Size: 0x1d8
function function_d6c80d4cea37db7b( zoneinfo )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    flags::gameflagwait( zoneinfo + "_objective_start" );
    ref = self.models[ 0 ] getentitynumber();
    tank = level.escortvehicles[ 0 ];
    
    while ( !( isdefined( self.triggerent.progress ) && isdefined( tank.progress ) && isdefined( tank.var_4f6ccc87c3912e74 ) ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( !tank.var_1d982a0a9bb102b3[ ref ] && function_e54c107a2419ba13( tank.var_4f6ccc87c3912e74, self.triggerent.progress, tank.progress ) )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 1;
            
            if ( self.triggerent.progress > tank.progress )
            {
                tank.directionblocked[ ref ] = "forward";
            }
            else
            {
                tank.directionblocked[ ref ] = "backward";
            }
        }
        
        msg = utility::waittill_notify_or_timeout_return( "trap_destroyed", 0.2 );
        
        if ( msg == "trap_destroyed" )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 0;
            break;
        }
        
        if ( tank.var_1d982a0a9bb102b3[ ref ] && !function_e54c107a2419ba13( tank.var_4f6ccc87c3912e74, self.triggerent.progress, tank.progress ) )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 0;
        }
    }
}

// Namespace wm_buildable_items
// Params 3
// Checksum 0x9fd6e3c8, Offset: 0x22c7
// Size: 0x39, Type: bool
function function_e54c107a2419ba13( var_4f6ccc87c3912e74, trapprogress, tankprogress )
{
    return tankprogress - trapprogress > var_4f6ccc87c3912e74 * 170 * -1 && tankprogress - trapprogress < var_4f6ccc87c3912e74 * 210;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xc0211f3, Offset: 0x2309
// Size: 0x184
function function_4ac1bf8123bc92bb()
{
    level.scr_animtree[ "EarthenWall" ] = #animtree;
    level.scr_anim[ "EarthenWall" ][ "building_1" ] = %jup_fxanim_war_military_buildable_wall_repair_half;
    level.scr_animname[ "EarthenWall" ][ "building_1" ] = "jup_fxanim_war_military_buildable_wall_repair_half";
    level.scr_anim[ "EarthenWall" ][ "building_2" ] = %jup_fxanim_war_military_buildable_wall_repair_full;
    level.scr_animname[ "EarthenWall" ][ "building_2" ] = "jup_fxanim_war_military_buildable_wall_repair_full";
    level.scr_anim[ "EarthenWall" ][ "idle_1" ] = %jup_fxanim_war_military_buildable_wall_idle_half;
    level.scr_animname[ "EarthenWall" ][ "idle_1" ] = "jup_fxanim_war_military_buildable_wall_idle_half";
    level.scr_anim[ "EarthenWall" ][ "idle_2" ] = %jup_fxanim_war_military_buildable_wall_idle_full;
    level.scr_animname[ "EarthenWall" ][ "idle_2" ] = "jup_fxanim_war_military_buildable_wall_idle_full";
    level.var_a56a0f9bbb5684f3[ "EarthenWall" ] = [];
    level.var_a56a0f9bbb5684f3[ "EarthenWall" ][ "models" ] = [ "jup_military_buildable_wall_05_fxanim", "jup_military_buildable_wall_06_fxanim" ];
    level.var_a56a0f9bbb5684f3[ "EarthenWall" ][ "animations" ] = [ "EarthenWall", [ "building_1", "building_2" ], [ "idle_1", "idle_2" ] ];
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xda1c89a, Offset: 0x2495
// Size: 0xcc
function function_c3228127f9429e14()
{
    buildinfo = spawnstruct();
    buildinfo.phases = [ 0, 0.5, 1 ];
    buildinfo.models = level.var_a56a0f9bbb5684f3[ "EarthenWall" ][ "models" ];
    buildinfo.animations = level.var_a56a0f9bbb5684f3[ "EarthenWall" ][ "animations" ];
    buildinfo.buildusetime = 3;
    buildinfo.hintstring = &"mp_jup_wm/build";
    buildinfo.var_3b45d6c373f01b69 = &function_217c224ae43cf310;
    buildinfo.var_ebd73781da1158ea = &function_3eb53f42e226c0e0;
    level.buildablepool[ "bdb_earthen_wall" ] = buildinfo;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x1dca8861, Offset: 0x2569
// Size: 0x4c4
function function_79fe00425be9bd2d()
{
    ents = getentarray( "wm_build_wall", #targetname );
    
    foreach ( ent in ents )
    {
        scriptorigin = utility::getstruct( ent.target, "targetname" );
        buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_earthen_wall", ent, ent.script_noteworthy, 0, scriptorigin.origin, scriptorigin.angles );
        fullclip = getent( scriptorigin.target, #targetname );
        buildable.fullclip = fullclip;
        halfclip = getent( fullclip.target, #targetname );
        buildable.halfclip = halfclip;
        buildable.fullclip.moverdoesnotkill = 1;
        buildable.halfclip.moverdoesnotkill = 1;
        buildable.fullclip connectpaths();
        buildable.halfclip connectpaths();
        buildable.fullclip notsolid();
        buildable.halfclip notsolid();
        buildable.halfclip.origin -= ( 0, 0, 400 );
        buildable.fullclip.origin -= ( 0, 0, 400 );
        buildable.var_6758a79d6170f4d9 = buildable.halfclip.origin;
        buildable.var_991fa325f6805e49 = buildable.fullclip.origin;
        navlinkstartnodes = utility::getstructarray( scriptorigin.target, "targetname" );
        
        foreach ( node in navlinkstartnodes )
        {
            if ( node.script_noteworthy == "full_warp_over" )
            {
                buildable.var_3ea65fedc924eb34 = node;
                continue;
            }
            
            buildable.var_b1786464c136d6e4 = node;
        }
        
        foreach ( model in buildable.models )
        {
            model.outlineid = outline::outlineenableforall( model, "shimmer_crafting_wm_buildable", "level_script" );
        }
        
        c4set = getscriptablearray( ent.target, #targetname );
        
        foreach ( c4 in c4set )
        {
            c4 setscriptablepartstate( "body", "init" );
            positionvec = c4.origin - buildable.models[ 0 ].origin;
            var_87fb556eb21b4f3e = vectordot( positionvec, anglestoforward( buildable.models[ 0 ].angles ) );
            
            if ( var_87fb556eb21b4f3e > 0 )
            {
                buildable.c4forward = c4;
                continue;
            }
            
            buildable.c4back = c4;
        }
    }
}

// Namespace wm_buildable_items
// Params 3
// Checksum 0x2e58122b, Offset: 0x2a35
// Size: 0xfb
function function_217c224ae43cf310( player, buildable, buildphase )
{
    if ( buildphase == 1 )
    {
        buildable.halfclip solid();
        buildable.halfclip movez( 400, 0.2 );
        buildable.halfclip disconnectpaths();
        endnode = utility::getstruct( buildable.var_b1786464c136d6e4.target, "targetname" );
        createnavlink( "half_wall_warp_over", buildable.var_b1786464c136d6e4.origin, endnode.origin, "traverse_warp_over" );
        buildable thread function_2b4f8fe2017b8777();
        
        if ( buildable.zonename == level.zone.name )
        {
            buildable.useobj gameobjects::setobjectivestatusicons( "waypoint_Buildable_Built" );
        }
    }
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xe550d624, Offset: 0x2b38
// Size: 0xc0
function function_2b4f8fe2017b8777()
{
    level endon( #"game_ended" );
    self endon( #"hash_ec4a4625df3246bf" );
    self.models[ 0 ] childthread wm_buildable::watchdamageattacker();
    self.models[ 0 ] waittillmatch( #"scriptablenotification", #"half_wall_destroyed" );
    self.halfclip.origin = self.var_6758a79d6170f4d9;
    self.halfclip connectpaths();
    self.models[ 0 ] notsolid();
    self.models[ 0 ] connectpaths();
    wm_buildable::function_91c49e3d59044210();
    self.buildphase = 0;
    self.models[ 0 ] notify( #"destroyed" );
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x89bc93b2, Offset: 0x2c00
// Size: 0x2b0
function function_3eb53f42e226c0e0( player, buildable )
{
    buildable notify( #"hash_ec4a4625df3246bf" );
    buildable.fullclip solid();
    buildable.fullclip movez( 400, 0.2 );
    buildable.fullclip disconnectpaths();
    buildable.halfclip utility::delaycall( 0.2, &moveto, buildable.var_6758a79d6170f4d9, 0.1 );
    buildable.halfclip utility::delaycall( 0.2, &notsolid );
    destroynavlink( "half_wall_warp_over" );
    endnode = utility::getstruct( buildable.var_3ea65fedc924eb34.target, "targetname" );
    createnavlink( "full_wall_warp_over", buildable.var_3ea65fedc924eb34.origin, endnode.origin, "traverse_warp_over" );
    destroytriggerent = getentarrayinradius( "huge_deploy_cover_close", #targetname, buildable.triggerent.origin, 100 );
    destroytriggerent = destroytriggerent[ 0 ];
    buildable.c4forward setscriptablepartstate( "body", "built" );
    buildable.c4forward.outlineid = outline::outlineenableforall( buildable.c4forward, "shimmer_crafting_wm_buildable", "level_script" );
    buildable.c4back setscriptablepartstate( "body", "built" );
    buildable.c4back.outlineid = outline::outlineenableforall( buildable.c4back, "shimmer_crafting_wm_buildable", "level_script" );
    
    foreach ( model in buildable.models )
    {
        outline::outlinedisable( model.outlineid, model );
    }
    
    if ( isdefined( player.var_da6fef6dec42c01b ) )
    {
        wait player.var_da6fef6dec42c01b;
    }
    
    destroyobj = wm_buildable::function_ce601a864bcc009( buildable, destroytriggerent, &"mp_jup_launchfacility/removewall", 3, undefined, &function_41450b8e366e64c8 );
    buildable thread wm_buildable::function_8df0f56e40ca484b( buildable.models[ 1 ], "full_wall_destroyed" );
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xdca64cc9, Offset: 0x2eb8
// Size: 0x2c4
function function_41450b8e366e64c8( player )
{
    scriptorigin = utility::getstruct( self.buildable.triggerent.target, "targetname" );
    buildable = wm_buildable::function_b1b8c1bd62c625bf( self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, scriptorigin.origin, scriptorigin.angles );
    fullclip = getent( scriptorigin.target, #targetname );
    buildable.fullclip = fullclip;
    halfclip = getent( fullclip.target, #targetname );
    buildable.halfclip = halfclip;
    buildable.fullclip connectpaths();
    buildable.fullclip notsolid();
    buildable.halfclip notsolid();
    buildable.var_6758a79d6170f4d9 = self.buildable.var_6758a79d6170f4d9;
    buildable.var_991fa325f6805e49 = self.buildable.var_991fa325f6805e49;
    buildable.halfclip.origin = buildable.var_6758a79d6170f4d9;
    buildable.fullclip.origin = buildable.var_991fa325f6805e49;
    destroynavlink( "full_wall_warp_over" );
    buildable.var_b1786464c136d6e4 = self.buildable.var_b1786464c136d6e4;
    buildable.var_3ea65fedc924eb34 = self.buildable.var_3ea65fedc924eb34;
    buildable.c4back = self.buildable.c4back;
    buildable.c4forward = self.buildable.c4forward;
    
    foreach ( model in buildable.models )
    {
        model.outlineid = outline::outlineenableforall( model, "shimmer_crafting_wm_buildable", "level_script" );
    }
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xb36070d7, Offset: 0x3184
// Size: 0x8b
function function_9032322f2988910b()
{
    buildinfo = spawnstruct();
    buildinfo.buildusetime = 4;
    buildinfo.hintstring = &"mp_jup_wm/repair";
    buildinfo.gestureweapon = "jup_war_ges_wrench_turret";
    buildinfo.var_33237f45f5760876 = &function_a6dc2f5c3b6ab417;
    buildinfo.var_6a7941b3aef1c16 = &function_f30b810c54ffbc69;
    buildinfo.var_ebd73781da1158ea = &function_7a0217910b16ae71;
    level.buildablepool[ "bdb_turret" ] = buildinfo;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x777e9eb4, Offset: 0x3217
// Size: 0x1e2
function function_146a43e498bd1e0f()
{
    ents = getentarray( "tri_build_turret", #targetname );
    
    foreach ( ent in ents )
    {
        turretstruct = utility::getstruct( ent.target, "targetname" );
        ent.buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_turret", ent, ent.script_noteworthy, 0, turretstruct.origin, turretstruct.angles );
        var_402db5cae2bfc67 = function_9094056478654291( turretstruct.origin, turretstruct.angles );
        ent.buildable.turret = var_402db5cae2bfc67;
        ent.buildable thread function_37336c2c54615f39();
        ent.buildable.turret.maxhealth = 500;
        ent.buildable.turret setdefaultdroppitch( 15 );
        ent.buildable.turret thread function_d04517180e4b2b1();
        ent.buildable.turret.scriptable = spawnscriptable( "jup_launchfacility_buildable_turret", turretstruct.origin );
        var_402db5cae2bfc67.outlineid = outline::outlineenableforall( var_402db5cae2bfc67, "shimmer_crafting_wm_buildable", "level_script" );
    }
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0xa82e86b1, Offset: 0x3401
// Size: 0x51
function function_a6dc2f5c3b6ab417( player, buildable )
{
    outline::outlinedisable( buildable.turret.outlineid, buildable.turret );
    buildable.turret.outlineid = undefined;
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x481db4eb, Offset: 0x345a
// Size: 0x46
function function_f30b810c54ffbc69( player, buildable )
{
    buildable.turret.outlineid = outline::outlineenableforall( buildable.turret, "shimmer_crafting_wm_buildable", "level_script" );
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x8b16126d, Offset: 0x34a8
// Size: 0x185
function function_7a0217910b16ae71( player, buildable )
{
    buildable.turret.outlineid = outline::outlineenableforall( buildable.turret, "shimmer_crafting_wm_buildable", "level_script" );
    buildable.turret notify( #"turret_fixed" );
    buildable.turret setdefaultdroppitch( 0 );
    buildable.turret setscriptablepartstate( "shutdown", "off" );
    buildable.turret.scriptable setscriptablepartstate( "sfx", "completed" );
    playfx( utility::getfx( "turret_fixed" ), buildable.turret.origin );
    hinttag = "j_trigger";
    hintpos = buildable.turret gettagorigin( hinttag );
    buildable.turret.useobj = gameobjects::createhintobject( hintpos, "HINT_BUTTON", "hud_icon_turret", &"mp/use_turret", undefined, "duration_none" );
    buildable.turret.useobj linkto( buildable.turret, hinttag );
    buildable.turret thread function_7b6009c1b1b34de6();
    buildable.turret.maxhealth = 1650;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xbdac6f15, Offset: 0x3635
// Size: 0x5f
function function_d04517180e4b2b1()
{
    level endon( #"game_ended" );
    self endon( #"turret_fixed" );
    self endon( #"kill_turret" );
    
    while ( true )
    {
        self setscriptablepartstate( "shutdown", "on" );
        self playsound( "jup_machine_gun_smoke" );
        wait 2;
        self setscriptablepartstate( "shutdown", "off" );
        wait 1;
    }
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xf805d971, Offset: 0x369c
// Size: 0x43
function function_37336c2c54615f39()
{
    level endon( #"game_ended" );
    self.turret waittill( #"kill_turret" );
    self.useobj.trigger makeunusable();
    wm_buildable::removebuildable( self );
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0xd7b3b4ac, Offset: 0x36e7
// Size: 0x1c5
function function_9094056478654291( origin, angles )
{
    turret = spawnturret( "misc_turret", origin, "manual_turret_jup_mp", 0 );
    turret.ammocount = 120;
    turret.health = 9999;
    turret.maxhealth = 1650;
    turret.team = "neutral";
    turret.angles = angles;
    turret setmodel( "weapon_wm_mg_mobile_turret" );
    turret makeunusable();
    turret setmode( "sentry_offline" );
    turret setsentryowner( undefined );
    turret setdefaultdroppitch( 0 );
    turret setturretmodechangewait( 1 );
    turret setnodeploy( 1 );
    turret thread function_876fd7a1be0c5193();
    turret thread damage::monitordamage( turret.maxhealth, "hitequip", &function_e2db63fb01895e51, &function_ce8586fe874aa127, 0 );
    turret emp_debuff::allow_emp( 0 );
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel setmodel( "weapon_vm_mg_sentry_turret_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel.moverdoesnotkill = 1;
    turret.colmodel.turretparent = turret;
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret, "tag_aim_pivot" );
    return turret;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xf410ec74, Offset: 0x38b5
// Size: 0x194
function function_7b6009c1b1b34de6()
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    
    while ( true )
    {
        self.useobj waittill( #"trigger", player );
        
        if ( !isalive( player ) || self.inuse )
        {
            continue;
        }
        
        self.inuse = 1;
        outline::outlinedisable( self.outlineid, self );
        player weapon_utility::saveweaponstates();
        player inventory_utility::_giveweapon( "manual_turret_jup_mp", undefined, undefined, 1 );
        result = player inventory_utility::domonitoredweaponswitch( "manual_turret_jup_mp", 1 );
        
        if ( !result )
        {
            self.inuse = undefined;
            
            if ( isdefined( player ) )
            {
                if ( isalive( player ) )
                {
                    lastweaponobj = player weapon_utility::restoreweaponstates( player.lastdroppableweaponobj, 1 );
                    player switchtoweaponimmediate( lastweaponobj );
                }
                
                player inventory_utility::_takeweapon( "manual_turret_jup_mp" );
            }
            
            continue;
        }
        
        self setmode( "manual" );
        player controlturreton( self );
        self.owner = player;
        self.team = player.team;
        self.colmodel.owner = self.owner;
        self.colmodel.team = self.team;
        function_b32906ba5995c920( player );
        thread function_329462216a02959b( player );
        thread function_aea143f38617d9a3( player );
        thread function_72437fe43d243365( player );
    }
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0x64e3e317, Offset: 0x3a51
// Size: 0x4f
function function_b32906ba5995c920( player )
{
    player killstreak_utility::function_d546aaa588f088c3( "manual_turret", "on" );
    player setclientomnvar( "ui_killstreak_countdown", 0 );
    player setclientomnvar( "ui_mobile_turret_controls", 1 );
    player setclientomnvar( "ui_killstreak_weapon_1_ammo", self.ammocount );
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xa6f86a57, Offset: 0x3aa8
// Size: 0x2c
function function_60ef7055765af9d4( player )
{
    player killstreak_utility::function_d546aaa588f088c3( "manual_turret", "off" );
    player setclientomnvar( "ui_mobile_turret_controls", 0 );
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0x65a01bd8, Offset: 0x3adc
// Size: 0x108
function function_329462216a02959b( player )
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    player endon( #"hash_ebfdc855350d305" );
    player endon( #"disconnect" );
    player endon( #"death" );
    self.hideammoindex = 1;
    var_13463d1a4d35279b = weaponfiretime( "manual_turret_jup_mp" );
    assert( var_13463d1a4d35279b > 0, "<dev string:xae>" );
    
    while ( player isusingturret() )
    {
        while ( player attackbuttonpressed() )
        {
            self.ammocount--;
            player setclientomnvar( "ui_killstreak_weapon_1_ammo", self.ammocount );
            
            if ( self.ammocount <= 12 )
            {
                self setscriptablepartstate( "hide_ammo_" + self.hideammoindex, "on", 0 );
                self.hideammoindex++;
            }
            
            if ( self.ammocount <= 0 )
            {
                self notify( #"kill_turret" );
                break;
            }
            
            wait var_13463d1a4d35279b;
        }
        
        waitframe();
    }
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xa51cd233, Offset: 0x3bec
// Size: 0x113
function function_4321373f5dff99bd( player )
{
    self.inuse = undefined;
    self.owner = undefined;
    self.team = "neutral";
    self.colmodel.owner = self.owner;
    self.colmodel.team = self.team;
    self setmode( "sentry_offline" );
    self.outlineid = outline::outlineenableforall( self, "shimmer_crafting_wm_buildable", "level_script" );
    
    if ( isdefined( player ) )
    {
        player controlturretoff( self );
        function_60ef7055765af9d4( player );
        
        if ( isalive( player ) )
        {
            lastweaponobj = player weapon_utility::restoreweaponstates( player.lastdroppableweaponobj, 1 );
            player switchtoweaponimmediate( lastweaponobj );
            player setorigin( self.lastuserpos, 1 );
            player setplayerangles( self.lastuserangles );
        }
        
        player inventory_utility::_takeweapon( "manual_turret_jup_mp" );
        player notify( #"hash_ebfdc855350d305" );
    }
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xb9827c2, Offset: 0x3d07
// Size: 0x96
function function_aea143f38617d9a3( player )
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    player endon( #"disconnect" );
    player endon( #"hash_ebfdc855350d305" );
    
    while ( player usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( player usebuttonpressed() || player isinexecutionvictim() )
        {
            function_4321373f5dff99bd( player );
            break;
        }
        
        self.lastuserpos = player.origin;
        self.lastuserangles = player getplayerangles();
        waitframe();
    }
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xf75a1591, Offset: 0x3da5
// Size: 0x52
function function_72437fe43d243365( player )
{
    level endon( #"game_ended" );
    self endon( #"kill_turret" );
    player endon( #"hash_ebfdc855350d305" );
    player utility::waittill_any( "death_or_disconnect", "last_stand_enter", "death" );
    function_4321373f5dff99bd( player );
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xad35e8bc, Offset: 0x3dff
// Size: 0x25
function function_ce8586fe874aa127( data )
{
    modifieddamage = data.damage;
    return modifieddamage;
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xa8de0944, Offset: 0x3e2d
// Size: 0x85
function function_e2db63fb01895e51( data )
{
    attacker = data.attacker;
    type = data.meansofdeath;
    explosivedamage = 0;
    
    if ( type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH" )
    {
        explosivedamage = 1;
    }
    
    self notify( #"kill_turret", explosivedamage, attacker );
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x43b66582, Offset: 0x3eba
// Size: 0xf0
function function_876fd7a1be0c5193()
{
    level endon( #"game_ended" );
    self waittill( #"kill_turret", skipshutdown, killer );
    function_4321373f5dff99bd( self.owner );
    self.useobj delete();
    
    if ( !skipshutdown )
    {
        self playsound( "jup_machine_gun_smoke" );
        self setscriptablepartstate( "shutdown", "on" );
        hostmigration::waitlongdurationwithpause( 2 );
        self setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        self setscriptablepartstate( "explode", "violent" );
    }
    
    self playsound( "jup_machine_gun_explode" );
    
    if ( isdefined( killer ) )
    {
        if ( isplayer( killer.owner ) )
        {
            killer = killer.owner;
        }
        
        killer wm_buildable::function_289bb264454c32d9( 0 );
    }
    
    self.colmodel delete();
    wait 0.2;
    self delete();
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xe93a450c, Offset: 0x3fb2
// Size: 0x13d
function function_a08c8a50ac4a7490()
{
    level.scr_animtree[ "Baffle" ] = #animtree;
    level.scr_anim[ "Baffle" ][ "idle" ] = %jup_fxanim_war_military_buildable_hedgehog_idle;
    level.scr_animname[ "Baffle" ][ "idle" ] = "jup_fxanim_war_military_buildable_hedgehog_idle";
    level.scr_anim[ "Baffle" ][ "building" ] = %jup_fxanim_war_military_buildable_hedgehog_repair;
    level.scr_animname[ "Baffle" ][ "building" ] = "jup_fxanim_war_military_buildable_hedgehog_repair";
    level.scr_anim[ "Baffle" ][ "destroy" ] = %jup_fxanim_war_military_buildable_hedgehog_destroy;
    level.scr_animname[ "Baffle" ][ "destroy" ] = "jup_fxanim_war_military_buildable_hedgehog_destroy";
    level.var_a56a0f9bbb5684f3[ "Baffle" ] = [];
    level.var_a56a0f9bbb5684f3[ "Baffle" ][ "models" ] = [ "jup_military_security_bollards" ];
    level.var_a56a0f9bbb5684f3[ "Baffle" ][ "animations" ] = [ "Baffle", [ "building" ], [ "idle" ], [ "destroy" ] ];
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xff9a1c17, Offset: 0x40f7
// Size: 0xcd
function function_e9dc421e8d3c3bd7()
{
    buildinfo = spawnstruct();
    buildinfo.models = level.var_a56a0f9bbb5684f3[ "Baffle" ][ "models" ];
    buildinfo.animations = level.var_a56a0f9bbb5684f3[ "Baffle" ][ "animations" ];
    buildinfo.buildusetime = 4;
    buildinfo.hintstring = &"mp_jup_wm/build";
    buildinfo.gestureweapon = "jup_war_ges_wrench_hedgehog";
    buildinfo.var_33237f45f5760876 = &function_4044cf6b9df62383;
    buildinfo.var_6a7941b3aef1c16 = &function_fa3690b4964ab93d;
    buildinfo.var_ebd73781da1158ea = &function_2021fd6bbd11aab5;
    level.buildablepool[ "bdb_Baffle" ] = buildinfo;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xd3ac6c4c, Offset: 0x41cc
// Size: 0x300
function function_44322742f9194817()
{
    ents = getentarray( "tri_build_tank_trap", #targetname );
    
    foreach ( index, ent in ents )
    {
        tanktrapstruct = utility::getstruct( ent.target, "targetname" );
        buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_Baffle", ent, ent.script_noteworthy, 0, tanktrapstruct.origin, tanktrapstruct.angles );
        ent.buildable = buildable;
        ent.id = index;
        
        if ( isdefined( ent.buildable.models[ 0 ] ) )
        {
            ent.buildable.models[ 0 ].outlineid = outline::outlineenableforall( ent.buildable.models[ 0 ], "shimmer_crafting_wm_buildable", "level_script" );
        }
        
        tanktrapclip = getent( tanktrapstruct.target, #targetname );
        tanktrapclip notsolid();
        tanktrapclip.origin -= ( 0, 0, 50 );
        tanktrapclip.originalpos = tanktrapclip.origin;
        tanktrapclip.movingdir = anglestoforward( tanktrapstruct.angles );
        buildable.clip = tanktrapclip;
        entparts = getentarray( ent.target, #targetname );
        
        foreach ( part in entparts )
        {
            if ( !isdefined( part.script_noteworthy ) )
            {
                continue;
            }
            
            if ( part.script_noteworthy == "destroy_trigger" )
            {
                ent.destroytrigger = part;
            }
        }
        
        [ buildable.c4 ] = getscriptablearray( ent.target, #targetname );
        ent usetriggerrequirelookat( 1 );
        ent thread function_357eeaf501eb2dc0();
        buildable thread function_53da345820aef4ef( "zone_2" );
    }
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x6b47558a, Offset: 0x44d4
// Size: 0x1e
function function_4044cf6b9df62383( player, buildable )
{
    buildable thread function_69996ddbec6a8491();
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xeb1bab88, Offset: 0x44fa
// Size: 0xb7
function function_69996ddbec6a8491()
{
    level endon( #"game_ended" );
    self endon( #"stop_building" );
    self notify( #"start_push" );
    self endon( #"start_push" );
    tanktrapclip = self.clip;
    tanktrapclip solid();
    tanktrapclip movez( 50, 0.2 );
    wait 0.2;
    goalpos = tanktrapclip.origin + tanktrapclip.movingdir * 60;
    tanktrapclip moveto( goalpos, 0.2 );
    wait 0.2;
    tanktrapclip notsolid();
    tanktrapclip.origin = tanktrapclip.originalpos;
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x37df86de, Offset: 0x45b9
// Size: 0x57
function function_fa3690b4964ab93d( player, buildable )
{
    buildable notify( #"stop_building" );
    tanktrapclip = buildable.clip;
    tanktrapclip notsolid();
    tanktrapclip.origin = tanktrapclip.originalpos;
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x53006bb7, Offset: 0x4618
// Size: 0x155
function function_2021fd6bbd11aab5( player, buildable )
{
    ent = buildable.triggerent;
    playfx( level._effect[ "sandbag_built" ], buildable.models[ 0 ].origin );
    buildable thread function_2c8ee8cbeb62b130( "zone_2" );
    buildable.clip notsolid();
    buildable.clip.origin = buildable.clip.originalpos;
    buildable.c4 setscriptablepartstate( "body", "built" );
    buildable.c4.outlineid = outline::outlineenableforall( buildable.c4, "shimmer_crafting_wm_buildable", "level_script" );
    destroyobj = wm_buildable::function_ce601a864bcc009( buildable, ent.destroytrigger, &"mp_jup_launchfacility/removetanktrap", 3, undefined, &function_d5dee08c63e8fe1f );
    setomnvar( "ui_wm_escort_trap_" + ent.id, ent.progress );
    buildable thread wm_buildable::function_8df0f56e40ca484b( buildable.models[ 0 ], "hogs_destroyed" );
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xb53817e8, Offset: 0x4775
// Size: 0x1b7
function function_d5dee08c63e8fe1f( player )
{
    self.buildable notify( #"trap_destroyed" );
    ent = self.buildable.triggerent;
    setomnvar( "ui_wm_escort_trap_" + ent.id, 0 );
    oldmodel = self.buildable.models[ 0 ];
    
    if ( isdefined( oldmodel ) )
    {
        outline::outlinedisable( oldmodel.outlineid, oldmodel );
    }
    
    var_e0d4519ca0e6007e = oldmodel.origin;
    var_c6d788951f6b9014 = oldmodel.angles;
    newbuildable = wm_buildable::function_b1b8c1bd62c625bf( self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, var_e0d4519ca0e6007e, var_c6d788951f6b9014 );
    ent.buildable = newbuildable;
    newbuildable.clip = self.buildable.clip;
    newmodel = newbuildable.models[ 0 ];
    
    if ( isdefined( newmodel ) )
    {
        newmodel.outlineid = outline::outlineenableforall( newmodel, "shimmer_crafting_wm_buildable", "level_script" );
    }
    
    ent.buildable.c4 = self.buildable.c4;
    ent usetriggerrequirelookat( 1 );
    ent thread function_357eeaf501eb2dc0();
    newbuildable thread function_53da345820aef4ef( "zone_2" );
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x9960f43f, Offset: 0x4934
// Size: 0xf2
function function_357eeaf501eb2dc0()
{
    self notify( #"hash_6c308c799a736780" );
    self endon( #"hash_6c308c799a736780" );
    level endon( #"game_ended" );
    pathnodes = getvehiclenodearray( "tank_trap_pos", #script_noteworthy );
    pathnode = sortbydistance( pathnodes, self.origin )[ 0 ];
    flags::gameflagwait( "zone_2" + "_objective_start" );
    distsquared = distance2dsquared( self.origin, pathnode.origin );
    
    if ( distsquared > 3000 )
    {
        assertmsg( distsquared + "<dev string:x24>" + self.origin + "<dev string:x43>" );
        self.buildable.useobj.trigger makeunusable();
    }
    
    self.progress = pathnode.progress;
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0xc753d3f, Offset: 0x4a2e
// Size: 0x27a
function function_53da345820aef4ef( zoneinfo )
{
    level endon( #"game_ended" );
    flags::gameflagwait( zoneinfo + "_objective_start" );
    tank = level.escortvehicles[ 0 ];
    
    while ( !( isdefined( self.triggerent.progress ) && isdefined( tank.progress ) && isdefined( tank.var_4f6ccc87c3912e74 ) ) )
    {
        waitframe();
    }
    
    var_a1b8191b1715d31d = spawn( "script_model", self.triggerent.origin );
    var_a1b8191b1715d31d.angles = self.triggerent.angles;
    var_a1b8191b1715d31d makeusable();
    var_a1b8191b1715d31d sethintdisplayrange( 256 );
    var_a1b8191b1715d31d sethintdisplayfov( 360 );
    var_a1b8191b1715d31d setuserange( 256 );
    var_a1b8191b1715d31d setusefov( 360 );
    var_a1b8191b1715d31d sethintonobstruction( "show" );
    var_a1b8191b1715d31d setcursorhint( "HINT_NOBUTTON" );
    var_a1b8191b1715d31d sethintstring( &"mp/unable_to_build_trap" );
    
    while ( self.buildphase == 0 )
    {
        if ( abs( self.triggerent.progress - tank.progress ) > tank.var_4f6ccc87c3912e74 * 400 )
        {
            self.useobj.trigger makeusable();
            
            foreach ( player in level.players )
            {
                var_a1b8191b1715d31d disableplayeruse( player );
            }
        }
        else
        {
            self.useobj.trigger makeunusable();
            
            foreach ( player in level.players )
            {
                var_a1b8191b1715d31d enableplayeruse( player );
            }
        }
        
        waitframe();
    }
    
    var_a1b8191b1715d31d delete();
}

// Namespace wm_buildable_items
// Params 1
// Checksum 0x178883b8, Offset: 0x4cb0
// Size: 0x1d8
function function_2c8ee8cbeb62b130( zoneinfo )
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    flags::gameflagwait( zoneinfo + "_objective_start" );
    ref = self.models[ 0 ] getentitynumber();
    tank = level.escortvehicles[ 0 ];
    
    while ( !( isdefined( self.triggerent.progress ) && isdefined( tank.progress ) && isdefined( tank.var_4f6ccc87c3912e74 ) ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( !tank.var_1d982a0a9bb102b3[ ref ] && function_8bd891cdc7157b60( tank.var_4f6ccc87c3912e74, self.triggerent.progress, tank.progress ) )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 1;
            
            if ( self.triggerent.progress > tank.progress )
            {
                tank.directionblocked[ ref ] = "forward";
            }
            else
            {
                tank.directionblocked[ ref ] = "backward";
            }
        }
        
        msg = utility::waittill_notify_or_timeout_return( "trap_destroyed", 0.2 );
        
        if ( msg == "trap_destroyed" )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 0;
            break;
        }
        
        if ( tank.var_1d982a0a9bb102b3[ ref ] && !function_8bd891cdc7157b60( tank.var_4f6ccc87c3912e74, self.triggerent.progress, tank.progress ) )
        {
            tank.var_1d982a0a9bb102b3[ ref ] = 0;
        }
    }
}

// Namespace wm_buildable_items
// Params 3
// Checksum 0x9ae75ae2, Offset: 0x4e90
// Size: 0x39, Type: bool
function function_8bd891cdc7157b60( var_4f6ccc87c3912e74, trapprogress, tankprogress )
{
    return tankprogress - trapprogress > var_4f6ccc87c3912e74 * 170 * -1 && tankprogress - trapprogress < var_4f6ccc87c3912e74 * 210;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xb344cc3c, Offset: 0x4ed2
// Size: 0x8b
function function_38d0d2a20d2ef181()
{
    buildinfo = spawnstruct();
    buildinfo.buildusetime = 4;
    buildinfo.hintstring = &"mp_jup_wm/build";
    buildinfo.gestureweapon = "jup_war_ges_wrench_turret";
    buildinfo.var_33237f45f5760876 = &function_a8dc7a6baecf06f7;
    buildinfo.var_6a7941b3aef1c16 = &function_8e84bef3220709c9;
    buildinfo.var_ebd73781da1158ea = &function_466d869c30dd32d1;
    level.buildablepool[ "bdb_laser_trap" ] = buildinfo;
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0x7b7a247a, Offset: 0x4f65
// Size: 0x2dc
function function_38533fbec37656d9()
{
    ents = getentarray( "tri_build_laser", #targetname );
    
    foreach ( ent in ents )
    {
        c4struct = utility::getstruct( ent.target, "targetname" );
        emitterstruct = utility::getstruct( c4struct.target, "targetname" );
        
        if ( isdefined( c4struct.script_index ) )
        {
            c4struct.script_index = string( c4struct.script_index );
        }
        
        var_9ba93db3c709f0c7 = utility::spawn_model( "electronics_ir_laser_device_assembly_nogeo", emitterstruct.origin, emitterstruct.angles );
        ent.emitter = var_9ba93db3c709f0c7;
        ent.emitterstruct = emitterstruct;
        initc4 = utility::spawn_model( "offhand_2h_wm_c4_v0", c4struct.origin, c4struct.angles );
        ent.c4 = initc4;
        ent.c4struct = c4struct;
        var_bec8b9edc8b7ec85 = getent( c4struct.target, #script_noteworthy );
        var_bec8b9edc8b7ec85 hide();
        ent.var_bec8b9edc8b7ec85 = var_bec8b9edc8b7ec85;
        controlpanel = getent( c4struct.target + "_panel", #script_noteworthy );
        ent.controlpanel = controlpanel;
        
        if ( ent.script_noteworthy == "built" )
        {
            ent.buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_laser_trap", ent, ent.script_noteworthy, 1, emitterstruct.origin, emitterstruct.angles );
            continue;
        }
        
        ent.buildable = wm_buildable::function_b1b8c1bd62c625bf( "bdb_laser_trap", ent, ent.script_noteworthy, 0, emitterstruct.origin, emitterstruct.angles );
        ent.emitter.outlineid = outline::outlineenableforall( ent.emitter, "shimmer_crafting_wm_buildable", "level_script" );
        ent.controlpanel.outlineid = outline::outlineenableforall( ent.controlpanel, "shimmer_crafting_wm_buildable", "level_script" );
    }
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0xc564170f, Offset: 0x5249
// Size: 0xc9
function function_a8dc7a6baecf06f7( player, buildable )
{
    outline::outlinedisable( buildable.triggerent.emitter.outlineid, buildable.triggerent.emitter );
    outline::outlinedisable( buildable.triggerent.controlpanel.outlineid, buildable.triggerent.controlpanel );
    buildable.triggerent.emitter.outlineid = undefined;
    buildable.triggerent.controlpanel.outlineid = undefined;
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0x287c3b42, Offset: 0x531a
// Size: 0x9f
function function_8e84bef3220709c9( player, buildable )
{
    buildable.triggerent.emitter.outlineid = outline::outlineenableforall( buildable.triggerent.emitter, "shimmer_crafting_wm_buildable", "level_script" );
    buildable.triggerent.controlpanel.outlineid = outline::outlineenableforall( buildable.triggerent.controlpanel, "shimmer_crafting_wm_buildable", "level_script" );
}

// Namespace wm_buildable_items
// Params 2
// Checksum 0xff02fc, Offset: 0x53c1
// Size: 0x190
function function_466d869c30dd32d1( player, buildable )
{
    buildable.triggerent.c4.outlineid = outline::outlineenableforall( buildable.triggerent.c4, "shimmer_crafting_wm_buildable", "level_script" );
    buildable.triggerent.emitter notify( #"emitter_fixed" );
    
    if ( !getdvarint( @"hash_6e6a3e0dfe7c7953", 0 ) )
    {
        buildable.triggerent.var_bec8b9edc8b7ec85 show();
        buildable.triggerent.var_bec8b9edc8b7ec85 notsolid();
        buildable.triggerent.var_bec8b9edc8b7ec85 thread function_e39c21d6cc6b4bce();
    }
    
    buildable.triggerent.c4struct.turrets[ 0 ] = namespace_2bdecc05800910ee::setup_sentry( buildable.triggerent.emitterstruct, "team_hundred_ninety_five", undefined, undefined, buildable.triggerent.c4struct, "laser_trap_bunker" );
    buildable.triggerent.c4 delete();
    level thread namespace_2bdecc05800910ee::function_f08fb1dede4695bf( buildable.triggerent.c4struct, buildable.triggerent.c4struct.turrets );
}

// Namespace wm_buildable_items
// Params 0
// Checksum 0xdc1673c5, Offset: 0x5559
// Size: 0xaf
function function_e39c21d6cc6b4bce()
{
    level endon( #"game_ended" );
    self endon( #"touch_player" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                self hide();
                self notify( #"touch_player" );
            }
        }
        
        waitframe();
    }
}

