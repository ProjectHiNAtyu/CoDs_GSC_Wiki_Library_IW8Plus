// scripts\mp\scene_frontend.gsc  (hash_74a1a664f57d46bf.gscc) (size: 5028 Bytes / 0x13a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9c47b4e (3385097038)
// size ...... 5028 (0x13a4)
// includes .. 4   (offset: 0x126c)
// strings ... 18  (offset: 0x128c)
// dev strs .. 3   (offset: 0x1380)
// exports ... 8   (offset: 0xb70)
// cseg ...... 0x16d + 0xa03 (0xb70)
// imports ... 51  (offset: 0xcb0)
// animtree1 . 0   (offset: 0x13a4)
// animtree2 . 0   (offset: 0x13a4)
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;

#namespace scene;

// Namespace scene
// Params 0
// Checksum 0xf0c115d8, Offset: 0x18b
// Size: 0x80
function function_6c37456303b2e980()
{
    if ( !isinfrontend() )
    {
        return;
    }
    
    level.players = [ self ];
    function_9faf48fca9716acd();
    function_3a06b41e384fbf58( "Types_ClientChar", "objectDelete", &client_character_delete );
    function_3a06b41e384fbf58( "Types_ClientChar", "shotObjectPrepare", &function_88b717bec001f592 );
    function_3a06b41e384fbf58( "Types_Prop", "shotObjectPlayAnim", &function_8384f562f0cb4abe );
    function_3a06b41e384fbf58( "Types_XCam", "shotObjectPlayAnim", &function_e5fa611bc31131e8 );
    function_a8d91578e2556475();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xefdd5b86, Offset: 0x213
// Size: 0x80
function private client_character_delete()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity hide();
        
        if ( sceneobjectdata.sceneroot.var_c46929fa56699327 )
        {
            sceneobjectdata.sceneroot.var_c46929fa56699327 = arrayremove( sceneobjectdata.sceneroot.var_c46929fa56699327, sceneobjectdata.entity );
        }
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xd8f7e52b, Offset: 0x29b
// Size: 0xa2
function private function_88b717bec001f592( sceneplay, shotindex, sceneobjectindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    var_dac9072a6d0b14bd = sceneobject.variant_object.shots[ shotindex ];
    characterindex = sceneobject function_8d6340a41bdf10ed() - 1;
    character = level.client_characters[ characterindex ];
    character function_de4866729f37f5d2( var_dac9072a6d0b14bd.deltaanimations.size > 0 );
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0x6d203ef9, Offset: 0x345
// Size: 0x36e
function private function_8384f562f0cb4abe( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity.model == "" )
    {
        println( "<dev string:x24>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:x54>" );
        return 0;
    }
    
    entity val::set( "scene_shot", "cinematics_participant", 1 );
    
    if ( !isdefined( blendtime ) )
    {
        blendtime = 0;
    }
    
    if ( !isdefined( lerptime ) )
    {
        lerptime = 0;
    }
    
    if ( !isdefined( var_142c2c5d44216f2a ) )
    {
        var_142c2c5d44216f2a = 0;
    }
    
    if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) )
    {
        blendtime = 0;
        lerptime = 0;
    }
    
    str_anim_name = getanimname( animasset );
    update_alignment_transform( alignmentinfo );
    var_3d2460219c7907a = "none";
    
    if ( blendtime > 0 && blendtime < 1 )
    {
        var_3d2460219c7907a = "normal";
    }
    else if ( blendtime >= 1 )
    {
        var_3d2460219c7907a = "slow";
    }
    
    animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animindex );
    animdisplacement = animationvalues.displacementtime;
    
    if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) || var_142c2c5d44216f2a > 0 )
    {
        animdisplacement = 0;
    }
    
    if ( animdisplacement > 0 )
    {
        wait animdisplacement;
    }
    
    n_anim_length_full = getanimlength( animasset );
    n_anim_length_trimmed = sceneobjectdata function_58a93a40f02daed7( shotindex, animasset, "DeltaAnimation", animindex );
    var_b9d155388159ec8 = 0;
    var_54f04a5ef99aabb9 = 0;
    
    if ( var_142c2c5d44216f2a > 0 )
    {
        var_a3016ccb852a40c2 = function_1222280fb003fd62( animasset, animationvalues, var_142c2c5d44216f2a );
        
        if ( var_142c2c5d44216f2a == 1 && animislooping( animasset ) )
        {
            var_a3016ccb852a40c2 = 0.999999;
        }
        
        var_b9d155388159ec8 = n_anim_length_full * var_a3016ccb852a40c2;
        var_54f04a5ef99aabb9 = n_anim_length_trimmed * var_142c2c5d44216f2a;
    }
    else if ( animationvalues.var_a9b8dffd45b33087 > 0 )
    {
        var_b9d155388159ec8 = animationvalues.var_a9b8dffd45b33087;
        var_54f04a5ef99aabb9 = 0;
    }
    
    b_looping = animislooping( animasset );
    
    if ( var_142c2c5d44216f2a < 1 || animationvalues.var_a9b8dffd45b33087 > 0 )
    {
        sceneobjectdata childthread function_26364b7b16eb9611( notifystring, animasset );
    }
    
    entity scriptmodelclearanim();
    entity useanimtree( sceneobjectdata.sceneobject function_4641057744100c08() );
    entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
    entity scriptmodelplayanim( str_anim_name, undefined, var_b9d155388159ec8, 1, var_3d2460219c7907a );
    sceneobjectdata function_4a9835edd174d8e3( animasset );
    
    if ( b_looping )
    {
        sceneobjectdata waittillmatch( notifystring, #"end" );
    }
    else if ( n_anim_length_trimmed > 0 )
    {
        var_ac8c7c287ab82eda = max( n_anim_length_trimmed - var_54f04a5ef99aabb9, 0 );
        sceneobjectdata utility::waittill_match_or_timeout( notifystring, "end", var_ac8c7c287ab82eda );
    }
    
    return animdisplacement + n_anim_length_trimmed - var_54f04a5ef99aabb9;
}

// Namespace scene
// Params 10, eflags: 0x4
// Checksum 0x1263bdb5, Offset: 0x6bc
// Size: 0x208
function private function_e5fa611bc31131e8( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype )
{
    sceneobjectdata = self;
    sceneobjectdata xcam_delete();
    
    if ( level.players.size == 0 )
    {
        return 0;
    }
    
    update_alignment_transform( alignmentinfo );
    sceneobjectdata endon( #"scene_stop" );
    sceneobjectdata endon( #"scene_play_anim" );
    sceneobjectdata.xcamplaying = 1;
    players = sceneobjectdata function_931d12df9abebc7f();
    
    foreach ( player in players )
    {
        sceneobjectdata childthread function_d3e02207e3f1f850( "scene_shot_xcam", player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex );
    }
    
    waittime = sceneobjectdata function_516be5ef89c77c57( shotindex, animasset, var_142c2c5d44216f2a );
    
    if ( getxcamlooping( animasset ) )
    {
        sceneobjectdata waittillmatch( notifystring, #"end" );
    }
    else if ( waittime > 0 )
    {
        sceneobjectdata utility::waittill_match_or_timeout( notifystring, "end", waittime );
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player val::reset_all( "scene_shot_xcam" );
    }
    
    return waittime;
}

// Namespace scene
// Params 7, eflags: 0x4
// Checksum 0xef3590ed, Offset: 0x8cd
// Size: 0x244
function private function_d3e02207e3f1f850( valgroup, player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    assert( isplayer( player ) );
    
    if ( function_3e768ed8916f0542( shotindex ) )
    {
        player endon( #"disconnect" );
    }
    else
    {
        player endon( #"death_or_disconnect" );
    }
    
    /#
        scene_debug::object_event( sceneobjectdata, "<dev string:x56>" + shotindex, alignmentinfo.origin, alignmentinfo.angles );
    #/
    
    waittime = 0;
    
    if ( animasset != "" )
    {
        starttime = 0;
        
        if ( var_142c2c5d44216f2a > 0 )
        {
            starttime = getxcamlength( animasset ) * var_142c2c5d44216f2a;
        }
        
        player notify( #"scene_play_xcam" );
        player endon( #"scene_play_xcam" );
        
        if ( !isdefined( level.var_26b9bd60c95fd049 ) )
        {
            level.var_26b9bd60c95fd049 = spawn( "script_model", alignmentinfo.origin );
            level.var_26b9bd60c95fd049 setmodel( "tag_origin" );
        }
        
        level.var_26b9bd60c95fd049.origin = alignmentinfo.origin;
        level.var_26b9bd60c95fd049.angles = alignmentinfo.angles;
        blendtime = sceneobjectdata.sceneobject function_1c54677f7be74c59( shotindex );
        
        if ( blendtime == 0 )
        {
            sceneobjectdata thread function_85ae4b01cd8305f2();
        }
        
        function_41797a7aad14e175( animasset, 0, blendtime, level.var_26b9bd60c95fd049 );
        player cameralinkto( level.var_26b9bd60c95fd049, "tag_origin" );
        player.scenexcam = { #time:gettime(), #animasset:animasset };
        
        if ( getxcamlooping( animasset ) )
        {
            sceneobjectdata waittillmatch( notifystring, #"end" );
        }
        else
        {
            waittime = sceneobjectdata function_516be5ef89c77c57( shotindex, animasset, var_142c2c5d44216f2a );
            
            if ( waittime > 0 )
            {
                sceneobjectdata utility::waittill_match_or_timeout( notifystring, "end", waittime );
            }
        }
        
        player notify( #"scene_play_xcam_done" );
    }
    
    return waittime;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1b686cb4, Offset: 0xb1a
// Size: 0x56
function private function_85ae4b01cd8305f2()
{
    sceneobjectdata = self;
    var_a5534827805425ee = "client_scene_teleport:" + sceneobjectdata.activeanimation;
    setdvar( @"lui_fe_transitioning_scene", var_a5534827805425ee );
    level.active_section.name = var_a5534827805425ee;
    waitframe();
    completescenetransition();
}

