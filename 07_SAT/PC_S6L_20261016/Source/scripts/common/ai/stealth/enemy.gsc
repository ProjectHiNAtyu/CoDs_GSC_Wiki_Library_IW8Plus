// scripts\common\ai\stealth\enemy.gsc  (hash_0d63697598f8e713.gscc) (size: 16404 Bytes / 0x4014 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65f81935 (1710758197)
// size ...... 16404 (0x4014)
// includes .. 12  (offset: 0x3b5c)
// strings ... 59  (offset: 0x3bbc)
// dev strs .. 17  (offset: 0x3f30)
// exports ... 42  (offset: 0x26f8)
// cseg ...... 0x496 + 0x2262 (0x26f8)
// imports ... 115 (offset: 0x2d88)
// animtree1 . 0   (offset: 0x4014)
// animtree2 . 0   (offset: 0x4014)
#using scripts\common\ai\stealth\callbacks;
#using scripts\common\ai\stealth\corpse;
#using scripts\common\ai\stealth\debug;
#using scripts\common\ai\stealth\door;
#using scripts\common\ai\stealth\event;
#using scripts\common\ai\stealth\group;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\ai\stealth\utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\utility;

#namespace enemy;

// Namespace enemy
// Params 0
// Checksum 0xd7d5be9a, Offset: 0x4b4
// Size: 0x292
function main()
{
    init_settings();
    init_flags();
    group::addtogroup( self.script_stealthgroup, self );
    
    if ( !self.var_31ab1ef29534375a )
    {
        self setpatrolstylebase();
    }
    
    event::event_init_entity();
    thread monitor_damage_thread();
    self function_2534a85eba6b0e0b( "noncombat" );
    bt_set_stealth_state( "idle" );
    stealth_init_goal_radius();
    
    /#
        thread debug::debug_enemy();
    #/
    
    if ( isdefined( self.fnstealthflashlighton ) )
    {
        self.stealth.funcs[ "flashlight_on" ] = self.fnstealthflashlighton;
    }
    
    if ( isdefined( self.fnstealthflashlightoff ) )
    {
        self.stealth.funcs[ "flashlight_off" ] = self.fnstealthflashlightoff;
    }
    
    if ( isdefined( self.var_dbed7de5e9371f9e ) )
    {
        self.stealth.funcs[ "flashlight_attach" ] = self.var_dbed7de5e9371f9e;
    }
    
    if ( isdefined( self.fnstealthflashlightdetach ) )
    {
        self.stealth.funcs[ "flashlight_detach" ] = self.fnstealthflashlightdetach;
    }
    
    self.stealth.funcs[ "on_state_change" ] = &onstatechange;
    
    if ( getdvarint( @"ai_disablestealthgroups", 0 ) == 0 )
    {
        self.stealth_groupname = self.script_stealthgroup;
    }
    
    if ( isdefined( level.interactive_doors ) && level.interactive_doors.var_361f561678f13dfb )
    {
        thread door::suspicious_door_thread();
    }
    
    if ( isdefined( self.aisettings ) && isdefined( self.aisettings.sightconfigtemplateoverride ) && self.aisettings.sightconfigtemplateoverride != "zombie_default" )
    {
        temp = 0;
    }
    
    if ( isdefined( level.stealth ) && isdefined( level.stealth.sightconfigtemplate ) && !( isdefined( self.aisettings ) && isdefined( self.aisettings.sightconfigtemplateoverride ) ) )
    {
        self setsightconfigtemplateoverride( level.stealth.sightconfigtemplate );
    }
    
    if ( isdefined( level.var_d2acb1f87b1cb3ad ) )
    {
        self [[ level.var_d2acb1f87b1cb3ad ]]();
    }
    
    if ( isdefined( level.stealth.fninitenemygame ) )
    {
        self thread [[ level.stealth.fninitenemygame ]]();
    }
}

// Namespace enemy
// Params 0
// Checksum 0x9f03192a, Offset: 0x74e
// Size: 0x26
function init_flags()
{
    utility::ent_flag_init( "stealth_enabled" );
    utility::ent_flag_set( "stealth_enabled" );
    utility::group_flag_init( "stealth_spotted" );
}

// Namespace enemy
// Params 0
// Checksum 0x3463637, Offset: 0x77c
// Size: 0x6c
function stealth_init_goal_radius()
{
    if ( isdefined( self.goalradius ) )
    {
        return;
    }
    
    if ( isdefined( self.script_radius ) )
    {
        self.goalradius = self.script_radius;
        return;
    }
    
    if ( isdefined( self.script_goalradius ) )
    {
        self.goalradius = self.script_goalradius;
        return;
    }
    
    if ( !isdefined( self getgoalvolume() ) )
    {
        self.goalradius = level.default_goalradius;
    }
}

// Namespace enemy
// Params 0
// Checksum 0xeb2a41eb, Offset: 0x7f0
// Size: 0xcb
function init_settings()
{
    self.stealth = spawnstruct();
    self.stealth_enabled = 1;
    self.stealth_bsmstate = 4;
    self.stealth.funcs = [];
    self.stealth.max_warnings = 2;
    
    /#
        self.stealth.ai_event = "<dev string:x24>";
        self.stealth.ai_event_prev = "<dev string:x24>";
    #/
    
    self.newenemyreactiondistsq = squared( geteventdefaultdistance( "footstep_sprint" ) ) ?? 640;
    corpse::corpse_init_entity();
    self.event_escalation_scalar = 0;
    self.disablegrenaderesponse = 1;
    self.canacquirenearbytacvisenemies = 0;
}

// Namespace enemy
// Params 0
// Checksum 0xcf913289, Offset: 0x8c3
// Size: 0x2f
function death_cleanup()
{
    if ( isdefined( self ) )
    {
        self setthreatsightstate( "death" );
    }
    
    if ( isdefined( self.stealth_vo_ent ) )
    {
        self.stealth_vo_ent thread death_vo_cleanup();
    }
}

// Namespace enemy
// Params 0
// Checksum 0xcb743dfd, Offset: 0x8fa
// Size: 0xf
function death_vo_cleanup()
{
    self stopsounds();
    waitframe();
    self delete();
}

// Namespace enemy
// Params 1
// Checksum 0x20af2648, Offset: 0x911
// Size: 0x8f
function add_active_sense_function( function )
{
    assert( isdefined( self.stealth ), "<dev string:x25>" + self getentitynumber() + "<dev string:x45>" + self.origin );
    
    if ( !isdefined( self.stealth.active_sense_funcs ) )
    {
        self.stealth.active_sense_funcs = [];
    }
    
    self.stealth.active_sense_funcs[ self.stealth.active_sense_funcs.size ] = function;
}

// Namespace enemy
// Params 2
// Checksum 0x4327c06, Offset: 0x9a8
// Size: 0xe8
function set_blind( blind, force )
{
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    if ( !blind && !self.stealthblind )
    {
        return;
    }
    
    var_3fdb7f26e60d8449 = isdefined( self.fnisinstealthcombat ) && self [[ self.fnisinstealthcombat ]]();
    var_67747a058e6e82ac = isdefined( self.fnisinstealthhunt ) && self [[ self.fnisinstealthhunt ]]();
    iscombat = var_3fdb7f26e60d8449 || var_67747a058e6e82ac;
    
    if ( blind && ( !iscombat || force ) )
    {
        self.stealthblind = 1;
        self setsightstate( "blind" );
        return;
    }
    
    self.stealthblind = 0;
    
    if ( iscombat )
    {
        self setsightstate( "spotted" );
        return;
    }
    
    self setsightstate( "hidden" );
}

// Namespace enemy
// Params 1
// Checksum 0xd70d808a, Offset: 0xa98
// Size: 0x40
function alertlevel_normal( param )
{
    thread utility::addeventplaybcs( "stealth", "announce5", "alertreset" );
    self function_2534a85eba6b0e0b( "noncombat" );
    bt_set_stealth_state( "idle" );
    utility::resume_previous_goal();
}

// Namespace enemy
// Params 0
// Checksum 0xc563732f, Offset: 0xae0
// Size: 0x92
function set_default_stealth_funcs()
{
    level utility::set_stealth_func( "go_to_node_wait", &go_to_node_wait );
    level utility::set_stealth_func( "go_to_node_arrive", &go_to_node_arrived );
    level utility::set_stealth_func( "go_to_node_post_wait", &go_to_node_post_wait );
    level utility::set_stealth_func( "reset", &alertlevel_normal );
    level utility::set_stealth_func( "set_patrol_style", &utility::set_patrol_style );
    level utility::set_stealth_func( "trigger_cover_blown", &trigger_cover_blown );
    level utility::set_stealth_func( "finish", &bt_event_handler_severity_finish );
    level utility::set_stealth_func( "override_should_ignore", &function_463fae6351fcecdb );
}

// Namespace enemy
// Params 0
// Checksum 0x5e06a0e, Offset: 0xb7a
// Size: 0x1a1
function monitor_damage_thread()
{
    team = self.team;
    
    while ( isalive( self ) )
    {
        other = undefined;
        
        while ( true )
        {
            if ( !isalive( self ) )
            {
                return;
            }
            
            self waittill( #"damage", dmg, attacker, null, point, type );
            check_kill_damage( dmg, attacker, point );
            event_spot = self.origin;
            
            if ( isalive( self ) && !utility::ent_flag( "stealth_enabled" ) )
            {
                continue;
            }
            
            if ( isalive( attacker ) )
            {
                other = attacker;
            }
            
            if ( !isdefined( other ) )
            {
                continue;
            }
            
            if ( callbacks::stealth_call( "damage", dmg, attacker, type ) )
            {
                continue;
            }
            
            if ( isalive( self ) )
            {
                self aieventlistenerevent( "damage", other, other.origin );
            }
            
            if ( isplayer( other ) || isdefined( other.team ) && other.team != team )
            {
                break;
            }
            
            if ( other.classname == "script_model" )
            {
                if ( other.isbarrel )
                {
                    break;
                }
            }
        }
        
        if ( isalive( self ) )
        {
            utility::function_29f489d90abd76e4( "ally_hurt_peripheral", other, type, 1 );
            utility::function_29f489d90abd76e4( "ally_damaged", other, type );
            continue;
        }
        
        utility::function_29f489d90abd76e4( "ally_hurt_peripheral", other, type, 1 );
        utility::function_29f489d90abd76e4( "ally_killed", other, type );
    }
}

// Namespace enemy
// Params 3
// Checksum 0xb3b5c780, Offset: 0xd23
// Size: 0xfb
function check_kill_damage( damage, attacker, origin )
{
    if ( isdefined( self.disableeasystealthheadshot ) || !level.gamemodebundle.var_c95917081eda4b61 )
    {
        return;
    }
    
    if ( isalive( self ) && damage > 0 && self.damagemod != "MOD_MELEE" && self.damagemod != "MOD_IMPACT" && self.alertlevel != "combat" )
    {
        eyepos = self geteye();
        
        if ( distancesquared( origin, eyepos ) < squared( level.stealth.head_shot_dist ) )
        {
            self dodamage( self.health, origin, attacker, attacker, "MOD_HEAD_SHOT" );
            
            if ( isdefined( self.stealth ) )
            {
                self.stealth.override_damage_auto_range = 128;
            }
        }
    }
}

// Namespace enemy
// Params 1
// Checksum 0xdd2238bd, Offset: 0xe26
// Size: 0x1be, Type: bool
function shotisreasonablysafe( target )
{
    guys = getaiunittypearray( "bad_guys", "all" );
    potentialguys = [];
    autorangesq = squared( level.stealth.damage_auto_range );
    sightrangesq = squared( level.stealth.damage_sight_range );
    
    foreach ( guy in guys )
    {
        if ( guy == target )
        {
            continue;
        }
        
        var_254b78e5870406b9 = distancesquared( target.origin, guy.origin );
        
        if ( var_254b78e5870406b9 < autorangesq )
        {
            return false;
        }
        
        if ( var_254b78e5870406b9 < sightrangesq )
        {
            if ( guy getthreatsight( self ) > 0 )
            {
                return false;
            }
            
            if ( guy math::point_in_fov( target.origin, 0 ) && guy hastacvis( target ) )
            {
                return false;
            }
            
            potentialguys[ potentialguys.size ] = guy;
        }
    }
    
    foreach ( guy in potentialguys )
    {
        if ( guy cansee( target ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace enemy
// Params 1
// Checksum 0x3c1188e0, Offset: 0xfed
// Size: 0x1c0, Type: bool
function shotisbadidea( target )
{
    guys = getaiunittypearray( "bad_guys", "all" );
    potentialguys = [];
    autorangesq = squared( level.stealth.damage_auto_range );
    sightrangesq = squared( level.stealth.damage_sight_range );
    
    foreach ( guy in guys )
    {
        if ( guy == target )
        {
            continue;
        }
        
        var_254b78e5870406b9 = distancesquared( target.origin, guy.origin );
        
        if ( var_254b78e5870406b9 < autorangesq )
        {
            return true;
        }
        
        if ( var_254b78e5870406b9 < sightrangesq )
        {
            if ( guy getthreatsight( self ) > 0 )
            {
                return true;
            }
            
            if ( guy math::point_in_fov( target.origin, 0 ) )
            {
                if ( guy hastacvis( target ) )
                {
                    return true;
                }
                
                potentialguys[ potentialguys.size ] = guy;
            }
        }
    }
    
    foreach ( guy in potentialguys )
    {
        if ( guy cansee( target ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace enemy
// Params 1
// Checksum 0xdc2b29fc, Offset: 0x11b6
// Size: 0xd1
function headtrack_player_toggle( bool )
{
    if ( bool )
    {
        if ( !isdefined( self.stealth.allowplayerheadtracking ) )
        {
            self.stealth.allowplayerheadtracking = 1;
        }
        else if ( !self.stealth.allowplayerheadtracking )
        {
            return;
        }
        
        if ( !isdefined( self.stealth.looking_at_entity ) )
        {
            self.stealth.looking_at_entity = level.player;
        }
        
        utility::lookatentity( level.player );
        return;
    }
    
    if ( isdefined( self.stealth.looking_at_entity ) )
    {
        self.stealth.looking_at_entity = undefined;
        utility::lookatentity();
    }
}

// Namespace enemy
// Params 1
// Checksum 0x1192272d, Offset: 0x128f
// Size: 0x41
function lock_player_headtracking_off( duration )
{
    self endon( #"death" );
    self notify( #"lock_headtracking_off" );
    self endon( #"lock_headtracking_off" );
    disable_player_headtracking();
    wait duration;
    enable_player_headtracking();
}

// Namespace enemy
// Params 0
// Checksum 0x244ae1c3, Offset: 0x12d8
// Size: 0x1f
function disable_player_headtracking()
{
    self.stealth.allowplayerheadtracking = 0;
    headtrack_player_toggle( 0 );
}

// Namespace enemy
// Params 0
// Checksum 0x40b0c75f, Offset: 0x12ff
// Size: 0x18
function enable_player_headtracking()
{
    self.stealth.allowplayerheadtracking = 1;
}

// Namespace enemy
// Params 1
// Checksum 0x56329199, Offset: 0x131f
// Size: 0x11b
function function_463fae6351fcecdb( event )
{
    originaleventtype = event.type;
    originaleventname = event.typeorig;
    bignore = callbacks::stealth_call( "should_ignore_" + event.typeorig, event );
    
    if ( !isdefined( bignore ) )
    {
        bignore = callbacks::stealth_call( "should_ignore_" + event.type, event );
        
        if ( !isdefined( bignore ) )
        {
            assertmsg( "<dev string:x4e>" + event.type + "<dev string:xed>" + event.typeorig );
            return 0;
        }
    }
    
    if ( isdefined( event.typeorig ) )
    {
        function_e7f164cd46a07420( event.typeorig, event.entity, self, event.type, event.origin, event.investigate_pos );
    }
    else
    {
        assertmsg( "<dev string:xfb>" + originaleventtype + "<dev string:xed>" + originaleventname );
    }
    
    return bignore;
}

// Namespace enemy
// Params 1
// Checksum 0x319b1f55, Offset: 0x1443
// Size: 0x3e, Type: bool
function should_ignore_footstep( event )
{
    if ( !isplayer( event.entity ) )
    {
        return true;
    }
    
    if ( event.entity getstance() != "stand" )
    {
        return true;
    }
    
    return false;
}

// Namespace enemy
// Params 1
// Checksum 0x2ec4325e, Offset: 0x148a
// Size: 0x11a, Type: bool
function should_ignore_sprint_footstep( event )
{
    if ( isplayer( event.entity ) )
    {
        dist_sq = distancesquared( self.origin, event.origin );
        traceoffset = ( 0, 0, 18 );
        ignoreents = arraycombine( getstealthcantracetoaiignoreents(), self function_284c569723782234() );
        var_4e66fa081bd2a2ca = self function_15a0fb69a0c74776( event.entity, "footstep" );
        
        if ( dist_sq < var_4e66fa081bd2a2ca * var_4e66fa081bd2a2ca )
        {
            return false;
        }
        else if ( utility::can_trace_to_ai( event.origin + traceoffset, self, ignoreents ) )
        {
            if ( isdefined( self.sprintfootstepradius ) )
            {
                sprintfootstepradius = self.sprintfootstepradius;
                
                if ( dist_sq < sprintfootstepradius * sprintfootstepradius )
                {
                    return false;
                }
            }
            
            playervisible = self cansee( event.entity );
            
            if ( !playervisible && self function_7d1a50702c523b66( event.entity ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace enemy
// Params 1
// Checksum 0x3c9d7163, Offset: 0x15ad
// Size: 0x7c, Type: bool
function event_override_disguise( event )
{
    if ( issentient( event.entity ) )
    {
        switch ( event.typeorig )
        {
            case #"hash_161d2d6c65d1cc82":
            case #"hash_37d1562da9bab005":
            case #"hash_52ad2c78c47fbfc8":
            case #"hash_9715afcc5dd0e063":
                thread threat_sight::threat_sight_force_visible( event.entity, 1 );
                return true;
        }
    }
    
    return false;
}

// Namespace enemy
// Params 1
// Checksum 0xf02c8dfb, Offset: 0x1632
// Size: 0xcb, Type: bool
function event_override_controlling_robot( event )
{
    if ( issentient( event.entity ) )
    {
        switch ( event.typeorig )
        {
            case #"hash_161d2d6c65d1cc82":
                return true;
            case #"hash_1d0022d9b49074c0":
            case #"hash_1de3ab20a61203e4":
            case #"hash_412938e72fd9ab35":
            case #"hash_46bae15508b25675":
            case #"hash_937c75a05af24ea4":
            case #"hash_c910677ee9c31085":
            case #"hash_de811d1d5fa7e6b4":
            case #"hash_ea10345acf995244":
                event.type = "combat";
                return false;
        }
    }
    
    if ( event.type != "combat" )
    {
        return true;
    }
    
    return false;
}

// Namespace enemy
// Params 2
// Checksum 0x4163c465, Offset: 0x1706
// Size: 0xbf, Type: bool
function event_anyone_within_radius( eventorigin, dist )
{
    distsq = dist * dist;
    ais = getaiunittypearray( "bad_guys", "all" );
    
    foreach ( ai in ais )
    {
        if ( distancesquared( eventorigin, ai.origin ) <= distsq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace enemy
// Params 1
// Checksum 0xc15f8e24, Offset: 0x17ce
// Size: 0x2ed
function event_handler_translate_severity( event )
{
    if ( !( isdefined( event ) && isdefined( event.typeorig ) ) )
    {
        return;
    }
    
    if ( self [[ self.fnisinstealthhunt ]]() )
    {
        if ( event.type == "investigate" )
        {
            event.type = "cover_blown";
        }
    }
    
    switch ( event.typeorig )
    {
        case #"hash_641050446d8ad59e":
            if ( self.unittype == "dog" )
            {
                event.type = "investigate";
            }
            else
            {
                evententid = undefined;
                
                if ( isdefined( event.entity ) && issentient( event.entity ) )
                {
                    evententid = event.entity getentitynumber();
                }
                
                if ( isdefined( evententid ) && self getthreatsightflag( event.entity, 2 ) )
                {
                    var_9c34fd71a31eea4b = event.entity;
                    
                    if ( isplayer( event.entity ) )
                    {
                        drone = event.entity utility::get_player_drone();
                        
                        if ( isdefined( drone ) && !self cansee( event.entity ) )
                        {
                            var_9c34fd71a31eea4b = drone;
                        }
                    }
                    
                    self getenemyinfo( var_9c34fd71a31eea4b );
                    event.type = "combat";
                }
            }
            
            break;
        case #"hash_ea10345acf995244":
            if ( isdefined( event.entity ) && event.entity.model == "offhand_1h_wm_bottle_v0" )
            {
                event.type = "cover_blown";
            }
            else if ( event_anyone_within_radius( event.origin, 128 ) )
            {
                event.type = "combat";
            }
            
            break;
        case #"hash_1d0022d9b49074c0":
            if ( event_anyone_within_radius( event.origin, 192 ) )
            {
                event.type = "combat";
            }
            else if ( distancesquared( event.origin, self.origin ) <= 1048576 )
            {
                event.type = "combat";
            }
            
            break;
        case #"hash_412938e72fd9ab35":
            if ( distancesquared( event.origin, self.origin ) < 640000 )
            {
                event.type = "combat";
            }
            
            break;
        case #"hash_eaa4394d31c175bf":
            if ( self hastacvis( event.origin, 0 ) && distance2dsquared( event.origin, self.origin ) < 36864 )
            {
                event.type = "combat";
            }
            
            break;
    }
}

// Namespace enemy
// Params 1
// Checksum 0xf5da9688, Offset: 0x1ac3
// Size: 0x26
function trigger_cover_blown( event )
{
    if ( !isdefined( self.stealth ) )
    {
        return;
    }
    
    self.var_7a84781005a5b751 = 1;
}

// Namespace enemy
// Params 1
// Checksum 0xf9e4b7dd, Offset: 0x1af1
// Size: 0x170, Type: bool
function react_announce( event )
{
    self endon( #"death" );
    delaytime = randomfloatrange( 0.5, 1.1 );
    
    switch ( event.type )
    {
        case #"hash_e21b072df2b47f94":
            thread utility::addeventplaybcs( "stealth", "announce5", "investigate", delaytime, event );
            println( "<dev string:x16d>" + self getentitynumber() + "<dev string:x185>" + event.typeorig + "<dev string:x1b6>" );
            
            /#
                debug::function_99160db0ba80d27b( self, "<dev string:x1d6>" );
            #/
            
            return true;
        case #"hash_f796130a9b9cec5":
            thread utility::addeventplaybcs( "stealth", "announce5", "coverblown", delaytime, event );
            println( "<dev string:x16d>" + self getentitynumber() + "<dev string:x1db>" + event.typeorig + "<dev string:x1b6>" );
            
            /#
                debug::function_99160db0ba80d27b( self, "<dev string:x20c>" );
            #/
            
            return true;
        case #"hash_9e02cd4a0f3ca981":
            thread utility::addeventplaybcs( "stealth", "announce2", "combat", 1, event );
            println( "<dev string:x16d>" + self getentitynumber() + "<dev string:x21a>" + event.typeorig + "<dev string:x1b6>" );
            
            /#
                debug::function_99160db0ba80d27b( self, "<dev string:x246>" );
            #/
            
            return true;
    }
    
    return false;
}

// Namespace enemy
// Params 1
// Checksum 0x7ab65b49, Offset: 0x1c6a
// Size: 0x64, Type: bool
function react_announce_specific( event )
{
    self endon( #"death" );
    
    if ( isdefined( event.typeorig ) )
    {
        delaytime = randomfloatrange( 0.5, 1 );
        thread utility::addeventplaybcs( "stealth", "announce4", event.typeorig, delaytime, event );
        return true;
    }
    
    return false;
}

// Namespace enemy
// Params 3
// Checksum 0x73c5da37, Offset: 0x1cd7
// Size: 0x64
function go_to_node_wait_investigate( goto_func, node, var_ac865e624ff3475d )
{
    self endon( #"death" );
    
    if ( !isdefined( var_ac865e624ff3475d ) )
    {
        var_ac865e624ff3475d = 1;
    }
    
    alreadysetgoal = !var_ac865e624ff3475d;
    
    while ( !alreadysetgoal )
    {
        self [[ goto_func ]]( node );
        alreadysetgoal = 1;
        self waittill( #"goal" );
    }
}

// Namespace enemy
// Params 2
// Checksum 0xfc1269f9, Offset: 0x1d43
// Size: 0x58
function go_to_node_wait( goto_func, node )
{
    self endon( #"death" );
    self function_49d3154c50a04d58();
    
    if ( isdefined( node.script_scenescriptbundle ) )
    {
        go_to_scene( goto_func, node );
        return;
    }
    
    self [[ goto_func ]]( node );
    self waittill( #"goal" );
}

// Namespace enemy
// Params 2
// Checksum 0x5b411b2b, Offset: 0x1da3
// Size: 0x50
function go_to_scene( goto_func, node )
{
    self endon( #"death" );
    self [[ goto_func ]]( node );
    self waittill( #"goal" );
    
    if ( isdefined( node.script_scenescriptbundle ) )
    {
        node scene::play( self, 0 );
    }
}

// Namespace enemy
// Params 2
// Checksum 0xe688a5bd, Offset: 0x1dfb
// Size: 0x85
function go_to_node_post_wait( goto_func, node )
{
    self endon( #"death" );
    self notify( #"hash_dff9a4211be3cfe7" );
    
    if ( isdefined( self.stealth.idle ) && isdefined( node.target ) )
    {
    }
    
    id = self getinteractionid();
    
    if ( isdefined( id ) )
    {
        self leaveinteraction();
    }
    
    if ( isdefined( node.target ) )
    {
        self function_49d3154c50a04d58();
    }
}

// Namespace enemy
// Params 2
// Checksum 0xaba25e4c, Offset: 0x1e88
// Size: 0x232
function go_to_node_arrived( goto_func, node )
{
    go_to_node_wait_investigate( goto_func, node, 0 );
    
    if ( isdefined( node.script_moveplaybackrate ) )
    {
        self.moveplaybackrate = node.script_moveplaybackrate;
    }
    
    if ( ( node.script_delay || node.script_delay_min || node.script_wait || isdefined( node.script_idle ) || node.patrol_stop || !isdefined( node.target ) ) && isdefined( node.angles ) )
    {
        packagename = undefined;
        
        if ( isdefined( node.script_idle ) )
        {
            packagename = node.script_idle;
        }
        
        self function_28cd6f7304ae5fc7( node.origin, node.angles, packagename );
        self._blackboard.idlenode = node;
        self.repeatinteraction = istrue( node.repeat_interaction );
        
        if ( !node.script_delay && !node.script_wait )
        {
            waitframe();
        }
    }
    
    if ( isdefined( node.script_animation ) )
    {
        anime = node.script_animation;
        utility::animgenericcustomanimmode( self, "gravity", anime );
    }
    else if ( isdefined( node.script_scenescriptbundle ) )
    {
        node scene::play( self, 0 );
    }
    else if ( isdefined( node.script_idle ) )
    {
        packagename = undefined;
        
        if ( isdefined( node.script_idle ) )
        {
            packagename = node.script_idle;
        }
        
        self function_28cd6f7304ae5fc7( node.origin, node.angles, packagename );
        self._blackboard.idlenode = node;
        self.repeatinteraction = istrue( node.repeat_interaction );
    }
    
    if ( isdefined( node.script_animation_exit ) )
    {
        utility::animgenericcustomanimmode( self, "gravity", node.script_animation_exit );
    }
}

// Namespace enemy
// Params 2
// Checksum 0xe0f33d2, Offset: 0x20c2
// Size: 0x4b
function bt_set_stealth_state( statename, event )
{
    assert( isdefined( self.fnsetstealthstate ), "<dev string:x24f>" + isdefined( self ) + "<dev string:x288>" + isalive( self ) );
    self [[ self.fnsetstealthstate ]]( statename, event );
}

// Namespace enemy
// Params 1
// Checksum 0xbed93e57, Offset: 0x2115
// Size: 0x10a, Type: bool
function bt_event_handler_severity_finish( event )
{
    if ( !utility::bcisincombat() )
    {
        if ( !react_announce_specific( event ) )
        {
            react_announce( event );
        }
    }
    
    switch ( event.type )
    {
        case #"hash_e21b072df2b47f94":
            thread bt_event_investigate( event );
            break;
        case #"hash_f796130a9b9cec5":
            thread bt_event_cover_blown( event );
            break;
        case #"hash_9e02cd4a0f3ca981":
            thread bt_event_combat( event );
            break;
    }
    
    level notify( #"stealth_event", event, self );
    func = callbacks::stealth_get_func( "finish_" + event.typeorig );
    
    if ( isdefined( func ) && func != &bt_event_handler_severity_finish )
    {
        self thread [[ func ]]( event );
    }
    else
    {
        func = callbacks::stealth_get_func( "finish_" + event.type );
        
        if ( isdefined( func ) && func != &bt_event_handler_severity_finish )
        {
            self thread [[ func ]]( event );
        }
    }
    
    return true;
}

// Namespace enemy
// Params 1
// Checksum 0xb0240ea0, Offset: 0x2228
// Size: 0x35
function bt_event_investigate( event )
{
    if ( self [[ self.fnisinstealthcombat ]]() )
    {
        return;
    }
    
    self function_2534a85eba6b0e0b( "alert" );
    bt_set_stealth_state( "investigate", event );
}

// Namespace enemy
// Params 1
// Checksum 0x74e40a12, Offset: 0x2265
// Size: 0xfe
function bt_event_cover_blown( event )
{
    if ( !isdefined( self.fnisinstealthcombat ) || self [[ self.fnisinstealthcombat ]]() )
    {
        return;
    }
    
    if ( isdefined( event.entity ) && event.entity.classname == "script_vehicle_blackhornet" )
    {
        return;
    }
    
    if ( event.typeorig == "light_killed" )
    {
        event.look_pos = event.investigate_pos;
        event.investigate_pos = utility::drop_to_ground( event.investigate_pos, 24, -256 );
    }
    
    if ( event.typeorig == "grenade danger" )
    {
        self.grenadereturnthrowchance = 0;
        
        if ( self.stealth_bsmstate == 2 )
        {
            return;
        }
    }
    
    self function_2534a85eba6b0e0b( "alert" );
    
    if ( !self [[ self.fnisinstealthhunt ]]() )
    {
        bt_set_stealth_state( "investigate", event );
    }
}

// Namespace enemy
// Params 1
// Checksum 0xa0445f2f, Offset: 0x236b
// Size: 0x53
function bt_event_combat( event )
{
    self notify( #"stop_going_to_node" );
    bt_set_stealth_state( "combat", event );
    
    if ( isdefined( event ) && issentient( event.entity ) )
    {
        if ( !isdefined( self.enemy ) )
        {
            self resetthreatupdate();
        }
    }
}

// Namespace enemy
// Params 0
// Checksum 0xadf37ea9, Offset: 0x23c6
// Size: 0x4a
function set_provide_cover_fire()
{
    self.providecoveringfire = 1;
    self endon( #"death" );
    self endon( #"stealth_investigate" );
    self endon( #"stealth_hunt" );
    self endon( #"stealth_combat" );
    wait 5;
    self.providecoveringfire = 0;
}

// Namespace enemy
// Params 3
// Checksum 0xf2d18b29, Offset: 0x2418
// Size: 0x2be
function onstatechange( fromstate, tostate, bnewpod )
{
    self notify( #"stealth_state_change", tostate, fromstate );
    combattype = undefined;
    
    switch ( tostate )
    {
        case 0:
            thread utility::addeventplaybcs( "stealth", "state_change", "idle", undefined, undefined );
            break;
        case 1:
            if ( fromstate == 1 )
            {
                thread utility::addeventplaybcs( "stealth", "state_change", "update_investigate", undefined, undefined );
            }
            else
            {
                self.script_forcegoal = 0;
                
                if ( bnewpod )
                {
                }
            }
            
            break;
        case 2:
            self.last_set_goalnode = undefined;
            self.last_set_goalent = undefined;
            level thread group::pod_hunt_vo();
            
            if ( bnewpod )
            {
                squadid = function_8398629a6c526ce3( self );
                thread group::pod_hunt_update( squadid );
            }
            
            thread utility::addeventplaybcs( "stealth", "state_change", "hunt", undefined, undefined );
            break;
        case 3:
            event::event_escalation_clear();
            
            if ( isdefined( self.script_stealthgroup ) )
            {
                goalvolume = level.stealth.combat_volumes[ self.script_stealthgroup ];
                
                if ( isdefined( goalvolume ) )
                {
                    self setgoalvolumeauto( goalvolume );
                    self forceupdategoalpos();
                }
                else if ( isdefined( level.stealth.combat_goalradius ) && isdefined( level.stealth.combat_goalradius[ self.script_stealthgroup ] ) )
                {
                    self setgoalpos( self.scriptgoalpos, level.stealth.combat_goalradius[ self.script_stealthgroup ] );
                    self forceupdategoalpos();
                }
            }
            
            self.disablegrenaderesponse = 0;
            
            if ( bnewpod )
            {
                combattype = fromstate < 2 ? "first_combat" : "combat";
            }
            else
            {
                combattype = "join_combat";
            }
            
            if ( isdefined( level.battlechatter ) && combattype == "first_combat" )
            {
                addbattlechatternotify( self, undefined, "initial_combat", undefined, 2 );
            }
            
            if ( combattype == "first_combat" && getdvarint( @"ai_shoulddohesherecallout" ) == 1 )
            {
                break;
            }
            else if ( isdefined( level.battlechatter ) )
            {
                addbattlechatternotify( self, undefined, combattype, undefined, 2 );
            }
            
            break;
        default:
            assertmsg( "<dev string:x29c>" + tostate );
            break;
    }
    
    callback::callback( #"hash_10831fc4ff641282", { #combattype:combattype, #fromstate:fromstate, #tostate:tostate } );
}

// Namespace enemy
// Params 0, eflags: 0x4
// Checksum 0xca327557, Offset: 0x26de
// Size: 0x1a
function private function_956e9e759d3ca0ec()
{
    assert( isdefined( level ) );
    var_e5bb9791b7128205 = 1;
}

