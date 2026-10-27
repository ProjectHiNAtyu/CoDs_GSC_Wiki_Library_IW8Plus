// scripts\mp\anim_scene.gsc  (hash_68b97d9e79132ec0.gscc) (size: 9204 Bytes / 0x23f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58d58039 (1490387001)
// size ...... 9204 (0x23f4)
// includes .. 2   (offset: 0x22ac)
// strings ... 10  (offset: 0x22bc)
// dev strs .. 9   (offset: 0x2358)
// exports ... 19  (offset: 0x19b4)
// cseg ...... 0xed + 0x18c7 (0x19b4)
// imports ... 49  (offset: 0x1cac)
// animtree1 . 1   (offset: 0x23e0)
// animtree2 . 0   (offset: 0x23f4)
#using scripts\common\anim;
#using scripts\common\values;

#namespace anim_scene;

#using_animtree( "script_model" );

// Namespace anim_scene
// Params 6
// Checksum 0x2f240765, Offset: 0x10b
// Size: 0x15f
function anim_scene_create_actor( entity, animname, is_player, player_rig_visible, disable_weapons, maintain_swimming )
{
    actor = spawnstruct();
    actor.entity = entity;
    actor.animname = animname;
    actor.interruptable = 0;
    actor.interrupted = 0;
    actor.endscene = 0;
    actor.forceendscene = 0;
    
    if ( is_player )
    {
        actor.is_player = is_player;
        
        if ( isdefined( player_rig_visible ) )
        {
            actor.player_rig_visible = player_rig_visible;
        }
        else
        {
            actor.player_rig_visible = 1;
        }
        
        if ( isdefined( disable_weapons ) )
        {
            actor.disable_weapons = disable_weapons;
        }
        else
        {
            actor.disable_weapons = 1;
        }
        
        if ( isdefined( maintain_swimming ) )
        {
            actor.maintain_swimming = maintain_swimming;
        }
        else
        {
            actor.maintain_swimming = 0;
        }
    }
    else
    {
        actor.is_player = 0;
        actor.entity.animname = actor.animname;
        actor.entity useanimtree( #animtree );
    }
    
    return actor;
}

// Namespace anim_scene
// Params 3
// Checksum 0xfa888a12, Offset: 0x273
// Size: 0x58
function anim_scene_set_actor_interruptable( var_594e5a5aff720a2, interrupt_anime, first_frame )
{
    self.interruptable = var_594e5a5aff720a2;
    
    if ( isdefined( interrupt_anime ) )
    {
        self.interrupt_anime = interrupt_anime;
        
        if ( isdefined( first_frame ) )
        {
            self.interrupt_first_frame = first_frame;
            return;
        }
        
        self.interrupt_first_frame = 0;
    }
}

// Namespace anim_scene
// Params 8
// Checksum 0xc92900e2, Offset: 0x2d3
// Size: 0xf7
function anim_scene( actors, anime, start_scene, end_scene, tag, blend_in_time, var_7fe2cc866c70cb5, var_f1621873095a52a8 )
{
    foreach ( actor in actors )
    {
        actor.interrupted = 0;
        actor.endscene = 0;
    }
    
    result = _anim_scene_internal( actors, anime, 0, tag, start_scene, end_scene, blend_in_time, var_7fe2cc866c70cb5, var_f1621873095a52a8 );
    
    if ( result )
    {
        return 1;
    }
    
    return 0;
}

// Namespace anim_scene
// Params 8
// Checksum 0x1e6126fb, Offset: 0x3d2
// Size: 0x164
function anim_scene_loop( actors, anime, start_scene, end_scene, tag, blend_in_time, var_7fe2cc866c70cb5, var_f1621873095a52a8 )
{
    foreach ( actor in actors )
    {
        actor.interrupted = 0;
        actor.endscene = 0;
    }
    
    _anim_scene_internal( actors, anime, 1, tag, start_scene, end_scene, blend_in_time, var_7fe2cc866c70cb5, var_f1621873095a52a8 );
    var_5dfe84eb0216d802 = 1;
    
    foreach ( actor in actors )
    {
        if ( !actor.endscene )
        {
            var_5dfe84eb0216d802 = 0;
            break;
        }
    }
    
    return var_5dfe84eb0216d802;
}

// Namespace anim_scene
// Params 1
// Checksum 0xce81dd2, Offset: 0x53f
// Size: 0x2c
function anim_scene_stop( force_end_scene )
{
    if ( force_end_scene )
    {
        self notify( #"anim_scene_force_end" );
        return;
    }
    
    self notify( #"stop_scene" );
}

// Namespace anim_scene
// Params 1
// Checksum 0x4db0319b, Offset: 0x573
// Size: 0x1a
function anim_scene_stop_actor( actor )
{
    actor.endscene = 1;
}

// Namespace anim_scene
// Params 9
// Checksum 0xb745942e, Offset: 0x595
// Size: 0x32b, Type: bool
function _anim_scene_internal( actors, anime, looping, tag, start_scene, end_scene, blend_in_time, var_7fe2cc866c70cb5, var_f1621873095a52a8 )
{
    self endon( #"anim_scene_interrupted" );
    
    if ( !isdefined( start_scene ) )
    {
        start_scene = 1;
    }
    
    if ( !isdefined( end_scene ) )
    {
        end_scene = 1;
    }
    
    /#
        assert( isarray( actors ) );
        
        foreach ( actor in actors )
        {
            assert( isstruct( actor ), "<dev string:x24>" );
            assert( isdefined( actor.entity ), "<dev string:x86>" );
            assert( !actor.is_player || isalive( actor.entity ) && !isdefined( actor.entity.fauxdead ), "<dev string:xb5>" );
        }
        
        if ( !end_scene && !looping )
        {
            function_4910321691ca305e( actors, anime );
        }
    #/
    
    thread _anim_scene_ender_think( actors );
    thread _anim_scene_force_end_think( actors );
    scene_duration = 0;
    thread _anim_scene_interrupt_think( actors, tag, end_scene );
    
    if ( start_scene )
    {
        if ( !isdefined( blend_in_time ) )
        {
            blend_in_time = 0.4;
        }
        
        if ( !isdefined( var_7fe2cc866c70cb5 ) )
        {
            var_7fe2cc866c70cb5 = 0.8;
        }
        
        _anim_scene_internal_blend_in( actors, anime, tag, blend_in_time, var_f1621873095a52a8 );
        _anim_scene_internal_finish_blend( actors, blend_in_time, var_7fe2cc866c70cb5 );
    }
    
    _anim_scene_internal_start_anims( actors, anime, looping, tag );
    
    if ( !looping )
    {
        foreach ( actor in actors )
        {
            actor.animduration = _anim_scene_internal_get_anim_duration( actor, anime );
            
            if ( actor.animduration > scene_duration )
            {
                scene_duration = actor.animduration;
            }
        }
        
        foreach ( actor in actors )
        {
            if ( actor.animduration < scene_duration )
            {
                thread _anim_scene_actor_end_interrupt_think( actor );
            }
        }
    }
    
    if ( looping )
    {
        self waittill( #"never" );
    }
    else
    {
        wait scene_duration;
    }
    
    waittillframeend();
    self notify( #"anim_scene_success" );
    
    if ( end_scene )
    {
        _anim_scene_internal_end( actors );
    }
    
    return true;
}

// Namespace anim_scene
// Params 5
// Checksum 0x17b6b6b8, Offset: 0x8c9
// Size: 0x280
function _anim_scene_internal_blend_in( actors, anime, tag, blend_in_time, var_f1621873095a52a8 )
{
    foreach ( actor in actors )
    {
        if ( actor.is_player )
        {
            if ( var_f1621873095a52a8 )
            {
                rig_model = "viewhands_base_iw8";
                actor.player_rig = spawn( "script_model", actor.entity.origin );
                actor.player_rig setmodel( rig_model );
                actor.player_rig.animname = actor.animname;
                actor.player_rig useanimtree( #animtree );
                actor.player_rig hide();
            }
            else
            {
                actor.player_rig = spawn( "script_arms", actor.entity.origin, 0, 0, actor.entity );
                actor.player_rig.animname = actor.animname;
                actor.player_rig useanimtree( #animtree );
                actor.player_rig hide();
                actor.player_rig.entity = actor.entity;
            }
            
            animation::anim_first_frame_solo( actor.player_rig, anime, tag );
            actor.entity setstance( get_actor_stance( actor ) );
            actor.entity playerlinktoblend( actor.player_rig, "tag_player", blend_in_time, 0, 0, 1, 1, actor.maintain_swimming );
            
            if ( actor.disable_weapons )
            {
                actor.entity val::set( "anim_scene", "weapon", 0 );
                actor.entity val::set( "anim_scene", "weapon_switch", 0 );
            }
        }
    }
}

// Namespace anim_scene
// Params 1
// Checksum 0xde0995d7, Offset: 0xb51
// Size: 0x3b
function get_actor_stance( actor )
{
    var_7237854e3be197ca = actor.entity.anim_scene_stance_override;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return "stand";
}

// Namespace anim_scene
// Params 3
// Checksum 0xa49d0b8, Offset: 0xb95
// Size: 0x23b
function _anim_scene_internal_finish_blend( actors, blend_in_time, var_7fe2cc866c70cb5 )
{
    waitdiff = var_7fe2cc866c70cb5 - blend_in_time;
    
    if ( waitdiff > 0 )
    {
        wait blend_in_time;
        
        foreach ( actor in actors )
        {
            if ( actor.interrupted )
            {
                continue;
            }
            
            if ( actor.is_player )
            {
                actor.entity playerlinktodelta( actor.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, actor.maintain_swimming );
            }
        }
        
        wait waitdiff;
        
        foreach ( actor in actors )
        {
            if ( actor.interrupted )
            {
                continue;
            }
            
            if ( actor.is_player )
            {
            }
        }
        
        return;
    }
    
    wait blend_in_time;
    
    foreach ( actor in actors )
    {
        if ( actor.interrupted )
        {
            continue;
        }
        
        if ( actor.is_player )
        {
            actor.entity playerlinktodelta( actor.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, actor.maintain_swimming );
        }
    }
}

// Namespace anim_scene
// Params 2
// Checksum 0xa9aadcec, Offset: 0xdd8
// Size: 0x9d
function _anim_scene_internal_get_anim_duration( actor, anime )
{
    scene_duration = 0;
    
    if ( actor.is_player )
    {
        thisduration = getanimlength( level.scr_anim[ actor.player_rig.animname ][ anime ] );
        
        if ( thisduration > scene_duration )
        {
            scene_duration = thisduration;
        }
    }
    else
    {
        thisduration = getanimlength( level.scr_anim[ actor.animname ][ anime ] );
        
        if ( thisduration > scene_duration )
        {
            scene_duration = thisduration;
        }
    }
    
    return scene_duration;
}

// Namespace anim_scene
// Params 4
// Checksum 0x611ecfcd, Offset: 0xe7e
// Size: 0x3b5
function _anim_scene_internal_start_anims( actors, anime, looping, tag )
{
    foreach ( actor in actors )
    {
        if ( actor.interrupted )
        {
            continue;
        }
        
        if ( actor.is_player )
        {
            if ( looping )
            {
                assert( isarray( level.scr_eventanim[ actor.animname ][ anime ] ) && level.scr_eventanim[ actor.animname ][ anime ].size == 1, "<dev string:xdf>" + actor.animname + "<dev string:x11b>" + anime + "<dev string:x120>" );
                actor.entity playanimscriptsceneevent( "scripted_scene", level.scr_eventanim[ actor.animname ][ anime ][ 0 ] );
            }
            else
            {
                assert( !isarray( level.scr_eventanim[ actor.animname ][ anime ] ), "<dev string:xdf>" + actor.animname + "<dev string:x11b>" + anime + "<dev string:x186>" );
                actor.entity playanimscriptsceneevent( "scripted_scene", level.scr_eventanim[ actor.animname ][ anime ] );
            }
            
            if ( isdefined( level.scr_viewmodelanim[ actor.animname ][ anime ] ) && !actor.entity.blockviewmodelanim )
            {
                if ( looping )
                {
                    assert( isarray( level.scr_viewmodelanim[ actor.animname ][ anime ] ) && level.scr_viewmodelanim[ actor.animname ][ anime ].size == 1, "<dev string:x1b3>" + actor.animname + "<dev string:x11b>" + anime + "<dev string:x120>" );
                    actor.entity playviewmodelanim( level.scr_viewmodelanim[ actor.animname ][ anime ][ 0 ] );
                }
                else
                {
                    assert( !isarray( level.scr_viewmodelanim[ actor.animname ][ anime ] ), "<dev string:x1b3>" + actor.animname + "<dev string:x11b>" + anime + "<dev string:x186>" );
                    actor.entity playviewmodelanim( level.scr_viewmodelanim[ actor.animname ][ anime ] );
                }
            }
            
            if ( actor.player_rig_visible && isdefined( actor.player_rig ) && !actor.entity getcamerathirdperson() )
            {
                actor.player_rig showonlytoplayer( actor.entity );
            }
            
            if ( looping )
            {
                thread animation::anim_loop_solo( actor.player_rig, anime, "stop_scene", tag );
            }
            else
            {
                thread animation::anim_single_solo( actor.player_rig, anime, tag );
            }
            
            continue;
        }
        
        if ( looping )
        {
            thread animation::anim_loop_solo( actor.entity, anime, "stop_scene", tag );
            continue;
        }
        
        thread animation::anim_single_solo( actor.entity, anime, tag );
    }
}

// Namespace anim_scene
// Params 1
// Checksum 0xbc4525c3, Offset: 0x123b
// Size: 0xd6
function _anim_scene_internal_end( actors )
{
    foreach ( actor in actors )
    {
        if ( actor.interrupted )
        {
            continue;
        }
        
        if ( actor.is_player )
        {
            actor.entity val::reset_all( "anim_scene" );
            actor.entity unlink();
            actor.player_rig delete();
            actor.player_rig = undefined;
        }
    }
}

// Namespace anim_scene
// Params 1
// Checksum 0xb28224bd, Offset: 0x1319
// Size: 0xa8
function _anim_scene_ender_think( actors )
{
    self endon( #"anim_scene_success" );
    self endon( #"anim_scene_interrupted" );
    self waittill( #"stop_scene" );
    
    foreach ( actor in actors )
    {
        actor.endscene = 1;
    }
}

// Namespace anim_scene
// Params 1
// Checksum 0x8c424ee2, Offset: 0x13c9
// Size: 0xa8
function _anim_scene_force_end_think( actors )
{
    self endon( #"anim_scene_success" );
    self endon( #"anim_scene_interrupted" );
    self waittill( #"anim_scene_force_end" );
    
    foreach ( actor in actors )
    {
        actor.forceendscene = 1;
    }
}

// Namespace anim_scene
// Params 1
// Checksum 0x7c45094b, Offset: 0x1479
// Size: 0x4d
function _anim_scene_actor_end_interrupt_think( actor )
{
    self endon( #"anim_scene_success" );
    self endon( #"anim_scene_interrupted" );
    wait actor.animduration;
    
    if ( !actor.interrupted )
    {
        actor.endscene = 1;
    }
}

// Namespace anim_scene
// Params 3
// Checksum 0x48fe3f66, Offset: 0x14ce
// Size: 0x44d
function _anim_scene_interrupt_think( actors, tag, end_scene )
{
    self endon( #"anim_scene_success" );
    self endon( #"anim_scene_interrupted" );
    
    while ( true )
    {
        interrupted = 0;
        
        while ( true )
        {
            wait 0.05;
            
            foreach ( actor in actors )
            {
                if ( actor.endscene || actor.forceendscene || !isdefined( actor.entity ) || actor.is_player && !isalive( actor.entity ) || actor.is_player && isdefined( actor.entity.fauxdead ) )
                {
                    if ( !actor.interrupted )
                    {
                        interrupted = 1;
                        break;
                    }
                }
            }
            
            if ( interrupted )
            {
                break;
            }
        }
        
        var_c884404062a0c5b3 = 1;
        
        foreach ( actor in actors )
        {
            actordead = 0;
            
            if ( !isdefined( actor.entity ) || actor.is_player && !isalive( actor.entity ) || actor.is_player && isdefined( actor.entity.fauxdead ) )
            {
                actordead = 1;
            }
            
            if ( !actordead && !actor.endscene && !actor.forceendscene && !actor.interruptable )
            {
                var_c884404062a0c5b3 = 0;
                continue;
            }
            
            actor.interrupted = 1;
            
            if ( actordead && !actor.is_player )
            {
                continue;
            }
            
            if ( actor.is_player )
            {
                if ( ( end_scene || actor.forceendscene ) && !actordead )
                {
                    actor.entity val::reset_all( "anim_scene" );
                    actor.entity stopanimscriptsceneevent();
                    actor.entity unlink();
                    actor.entity setorigin( actor.entity.origin + ( 0, 0, 1 ) );
                }
                
                if ( end_scene || actor.forceendscene || actordead )
                {
                    if ( isent( actor.player_rig ) )
                    {
                        actor.player_rig delete();
                        actor.player_rig = undefined;
                    }
                }
                
                continue;
            }
            
            if ( isdefined( actor.interrupt_anime ) )
            {
                if ( actor.interrupt_first_frame )
                {
                    thread animation::anim_first_frame_solo( actor.entity, actor.interrupt_anime, tag );
                }
                else
                {
                    actor.entity stopanimscripted();
                    thread animation::anim_single_solo( actor.entity, actor.interrupt_anime, tag );
                }
                
                continue;
            }
            
            actor.entity stopanimscripted();
            
            if ( actor.entity.classname == "script_model" || actor.entity.code_classname == "script_model" )
            {
                actor.entity scriptmodelclearanim();
            }
        }
        
        if ( var_c884404062a0c5b3 )
        {
            self notify( #"anim_scene_interrupted" );
            return;
        }
    }
}

/#

    // Namespace anim_scene
    // Params 2
    // Checksum 0x1ae08b23, Offset: 0x1923
    // Size: 0x91, Type: dev
    function function_4910321691ca305e( actors, anime )
    {
        scenelength = 0;
        
        for ( i = 0; i < actors.size ; i++ )
        {
            actor = actors[ i ];
            thisduration = getanimlength( level.scr_anim[ actor.animname ][ anime ] );
            
            if ( i == 0 )
            {
                scenelength = thisduration;
                continue;
            }
            
            if ( thisduration != scenelength )
            {
                iprintlnbold( "<dev string:x1f3>" );
            }
        }
    }

#/
