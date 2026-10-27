// scripts\mp\anim.gsc  (hash_73b60289c107fa07.gscc) (size: 6070 Bytes / 0x17b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e80dc4a (2659245130)
// size ...... 6070 (0x17b6)
// includes .. 9   (offset: 0x163e)
// strings ... 22  (offset: 0x1686)
// dev strs .. 2   (offset: 0x179e)
// exports ... 17  (offset: 0xdaa)
// cseg ...... 0x220 + 0xb8a (0xdaa)
// imports ... 53  (offset: 0x1052)
// animtree1 . 0   (offset: 0x17b6)
// animtree2 . 0   (offset: 0x17b6)
#using scripts\anim\notetracks;
#using scripts\anim\notetracks_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\sound;
#using scripts\mp\flags;

#namespace anim_mp;

// Namespace anim_mp
// Params 0
// Checksum 0x1e342769, Offset: 0x23e
// Size: 0x13f
function init()
{
    animation::initanim();
    
    if ( !isdefined( level.scr_viewmodelanim ) )
    {
        level.scr_viewmodelanim = [];
    }
    
    if ( !isdefined( level.scr_eventanim ) )
    {
        level.scr_eventanim = [];
    }
    
    anim.callbacks[ "PlaySoundAtViewHeight" ] = &play_sound_at_viewheight;
    anim.callbacks[ "TeleportEnt" ] = &teleport_entity;
    anim.callbacks[ "ShouldDoAnim" ] = &should_do_anim;
    anim.callbacks[ "DoAnimation" ] = &do_animation;
    anim.callbacks[ "DoFacialAnim" ] = &do_facial_anim;
    anim.callbacks[ "reach_with_standard_adjustments_begin" ] = &function_ba15a145ab8323f1;
    anim.callbacks[ "reach_with_standard_adjustments_end" ] = &function_8448152cc1bb5061;
    anim.callbacks[ "AnimHandleNotetrack" ] = &mp_anim_handle_notetrack;
    anim.callbacks[ "EntityHandleNotetrack" ] = &mp_entity_handle_notetrack;
    anim.callbacks[ "EntityHandleNotetrackAnimEnd" ] = &notetracks::function_98ec98c1d61cf08e;
    anim.callbacks[ "AIAnimFirstFrame" ] = &utility::ai_anim_first_frame;
    anim.callbacks[ "playXcam" ] = &play_xcam;
    level.fnplaysoundontag = &sound::play_sound_on_tag_fn;
}

// Namespace anim_mp
// Params 3
// Checksum 0xe7e4c63d, Offset: 0x385
// Size: 0x26
function play_sound_at_viewheight( aliasname, notification_string, var_868a4b7218755765 )
{
    self playsound( aliasname );
}

// Namespace anim_mp
// Params 0
// Checksum 0x4f9836dc, Offset: 0x3b3
// Size: 0x4, Type: bool
function should_do_anim()
{
    return true;
}

// Namespace anim_mp
// Params 2
// Checksum 0x68702ff5, Offset: 0x3c0
// Size: 0x99
function teleport_entity( origin, angles )
{
    if ( self.code_classname == "script_vehicle" )
    {
        if ( !can_teleport_vehicle() )
        {
            self.origin = origin;
            self.angles = angles;
            self dontinterpolate();
        }
        else
        {
            self vehicle_teleport( origin, angles );
            self dontinterpolate();
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        self setorigin( origin );
        self setplayerangles( angles );
        return;
    }
    
    self.origin = origin;
    self.angles = angles;
    self dontinterpolate();
}

// Namespace anim_mp
// Params 0
// Checksum 0xe875f952, Offset: 0x461
// Size: 0x51
function can_teleport_vehicle()
{
    canteleport = 1;
    
    if ( isdefined( vehicle::get_ref() ) )
    {
        switch ( vehicle::get_ref() )
        {
            case #"hash_2289ec11d77bce8f":
            case %"hash_3ea77eeadab2855c":
            case #"hash_56979e0566996b2e":
                canteleport = 0;
                break;
        }
    }
    
    return canteleport;
}

// Namespace anim_mp
// Params 6
// Checksum 0x231c702, Offset: 0x4bb
// Size: 0x3a, Type: bool
function do_facial_anim( dofacialanim, dodialogue, doanimation, anime, animname, dialogue )
{
    return false;
}

// Namespace anim_mp
// Params 7
// Checksum 0x65632d73, Offset: 0x4fe
// Size: 0x201
function do_animation( org, angles, animname, anime, anim_string, idleanim, scripted_node_ent )
{
    var_17eaf0218e9cb200 = 0;
    animation = undefined;
    
    if ( isdefined( idleanim ) && !isagent( self ) )
    {
        animation = level.scr_anim[ animname ][ anime ][ idleanim ];
    }
    else
    {
        animation = level.scr_anim[ animname ][ anime ];
    }
    
    goaltime = animation::anim_get_goal_time( animname, anime );
    animation::last_anim_time_check();
    
    if ( !isdefined( idleanim ) )
    {
        self._lastanime = anime;
    }
    
    if ( self.code_classname == "misc_turret" && !isdefined( idleanim ) )
    {
        self setflaggedanim( anim_string, animation, 1, goaltime );
    }
    else
    {
        if ( self.code_classname == "script_vehicle" )
        {
            self vehicleplayanim( animation );
        }
        
        root = undefined;
        
        if ( isdefined( self.anim_getrootfunc ) )
        {
            root = [[ self.anim_getrootfunc ]]();
        }
        
        if ( isagent( self ) )
        {
            var_17eaf0218e9cb200 = 1;
            level_archetype = "agent_scripted_" + getdvar( @"g_mapname" );
            
            if ( archetypeassetloaded( level_archetype ) )
            {
                scripted_node = spawnstruct();
                
                if ( isdefined( org ) )
                {
                    scripted_node.origin = org;
                    scripted_node.angles = angles;
                }
                
                var_a0b4ea9f3514fff5 = getanimname( animation );
                thread utility::animscriptmp( level_archetype, "animscripted", var_a0b4ea9f3514fff5, undefined, undefined, undefined, scripted_node );
            }
            else
            {
                thread utility::animscriptedagent( anime, anim_string, org, angles );
            }
        }
        else
        {
            animmode = undefined;
            
            if ( self.backwards )
            {
                animmode = "backwards";
            }
            
            self animscripted( anim_string, org, angles, animation, animmode, root, goaltime );
        }
    }
    
    thread notetrack::start_notetrack_wait( self, anim_string, anime, animname, animation, var_17eaf0218e9cb200 );
    return getanimlength( animation );
}

// Namespace anim_mp
// Params 4
// Checksum 0x5add447b, Offset: 0x708
// Size: 0xf4
function mp_anim_handle_notetrack( scr_notetrack, guy, dialogue_array, tag_owner )
{
    notetrack::anim_handle_notetrack( scr_notetrack, guy, dialogue_array, tag_owner );
    
    if ( isdefined( scr_notetrack[ "flag" ] ) )
    {
        flags::gameflagset( scr_notetrack[ "flag" ] );
    }
    
    if ( isdefined( scr_notetrack[ "flag_clear" ] ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"hash_fd5418c08e9b35ce" ) )
        {
            [[ utility::getsharedfunc( #"game", #"hash_fd5418c08e9b35ce" ) ]]( scr_notetrack[ "flag_clear" ] );
        }
    }
    
    if ( isdefined( scr_notetrack[ "sound" ] ) )
    {
        if ( utility::issharedfuncdefined( #"sound", #"hash_880419d2290c0329" ) )
        {
            tag = scr_notetrack[ "sound_on_tag" ];
            guy thread [[ utility::getsharedfunc( #"sound", #"hash_880419d2290c0329" ) ]]( scr_notetrack[ "sound" ], tag );
        }
    }
}

// Namespace anim_mp
// Params 2
// Checksum 0x133a6af5, Offset: 0x804
// Size: 0x36
function mp_entity_handle_notetrack( guy, notetrack )
{
    if ( notetracks::hascustomnotetrackhandler( notetrack ) )
    {
        return notetracks::handlecustomnotetrackhandler( notetrack );
    }
    
    if ( guy notetracks_mp::notetrack_prefix_handler_cp_mp( notetrack ) )
    {
        return;
    }
}

// Namespace anim_mp
// Params 6
// Checksum 0xe47edc1a, Offset: 0x842
// Size: 0x7a
function anim_player_solo( player, player_rig, anime, tag, anim_end_time, animname_override )
{
    self endon( #"death" );
    players[ 0 ] = player;
    player_rigs[ 0 ] = player_rig;
    
    if ( !isdefined( anim_end_time ) )
    {
        anim_end_time = 0;
    }
    
    anim_player( players, player_rigs, anime, tag, anim_end_time, animname_override );
}

// Namespace anim_mp
// Params 6
// Checksum 0x3c26635f, Offset: 0x8c4
// Size: 0x50
function anim_player( players, player_rigs, anime, tag, anim_end_time = 0, animname_override )
{
    anim_player_internal( players, player_rigs, anime, tag, anim_end_time, animname_override );
}

// Namespace anim_mp
// Params 6
// Checksum 0x7138673b, Offset: 0x91c
// Size: 0x1ab
function anim_player_internal( players, player_rigs, anime, tag, anim_end_time, animname_override )
{
    duration = 0;
    
    foreach ( player in players )
    {
        animname = undefined;
        
        if ( isdefined( animname_override ) )
        {
            animname = animname_override;
        }
        else
        {
            animname = player.animname;
        }
        
        if ( isdefined( level.scr_eventanim[ animname ] ) && isdefined( level.scr_eventanim[ animname ][ anime ] ) )
        {
            eventname = "scripted_scene";
            
            if ( isdefined( level.scr_eventname[ animname ] ) && isdefined( level.scr_eventname[ animname ][ anime ] ) )
            {
                eventname = level.scr_eventname[ animname ][ anime ];
            }
            
            duration = player playanimscriptsceneevent( eventname, level.scr_eventanim[ animname ][ anime ] );
        }
        
        if ( isdefined( level.scr_viewmodelanim[ animname ][ anime ] ) && !player.blockviewmodelanim )
        {
            duration = player playviewmodelanim( level.scr_viewmodelanim[ animname ][ anime ] );
            
            /#
                player notify( #"hash_9d8d4f12300d38a9", anime, duration );
            #/
        }
    }
    
    if ( isdefined( player_rigs ) )
    {
        animation::anim_single( player_rigs, anime, tag, anim_end_time, animname_override );
    }
}

// Namespace anim_mp
// Params 3
// Checksum 0x5beff42e, Offset: 0xacf
// Size: 0xb4
function play_xcam( xcamasset, origin, angles )
{
    camnum = undefined;
    
    if ( !isdefined( camnum ) )
    {
        camnum = 0;
    }
    
    foreach ( player in level.players )
    {
        player playxcam( xcamasset, camnum, origin, angles );
    }
    
    wait getxcamlength( xcamasset );
}

// Namespace anim_mp
// Params 1
// Checksum 0xa4649aab, Offset: 0xb8b
// Size: 0x45
function function_1dbeeb436fcf81c0( framecount )
{
    frametime = 0.0333333 * framecount;
    
    if ( frametime <= 0 )
    {
        println( "<dev string:x24>" + frametime + "<dev string:x3b>" );
        return;
    }
    
    wait frametime;
}

// Namespace anim_mp
// Params 2
// Checksum 0x54a55fda, Offset: 0xbd8
// Size: 0x126
function function_ba15a145ab8323f1( startorg, startangles )
{
    self.oldgoalradius = self.goalradius;
    self.oldpathenemyfightdist = self.pathenemyfightdist;
    self.oldpathenemylookahead = self.pathenemylookahead;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 128;
    self pushplayer( 1 );
    self.nododgemove = 1;
    self.doavoidanceblocking = 0;
    self.fixednodewason = self.fixednode;
    self.fixednode = 0;
    self.var_27b63d6a442591df = self.cornercheckenabled;
    self.cornercheckenabled = 0;
    self.ignoreall = 1;
    
    if ( !isdefined( self.scriptedarrivalent ) )
    {
        self.old_disablearrivals = self.disablearrivals;
        self.disablearrivals = 1;
    }
    else
    {
        self.scriptedarrivalent.angles = startangles;
        self.scriptedarrivalent.origin = startorg;
    }
    
    self.reach_goal_pos = undefined;
    return startorg;
}

// Namespace anim_mp
// Params 0
// Checksum 0x3e1dc71, Offset: 0xd07
// Size: 0xa3
function function_8448152cc1bb5061()
{
    self pushplayer( 0 );
    self.nododgemove = 0;
    self.doavoidanceblocking = 1;
    self.fixednode = self.fixednodewason;
    self.fixednodewason = undefined;
    self.cornercheckenabled = self.var_27b63d6a442591df;
    self.var_27b63d6a442591df = undefined;
    self.pathenemyfightdist = self.oldpathenemyfightdist;
    self.pathenemylookahead = self.oldpathenemylookahead;
    self.ignoreall = 0;
    
    if ( isdefined( self.old_disablearrivals ) )
    {
        self.disablearrivals = self.old_disablearrivals;
    }
}

