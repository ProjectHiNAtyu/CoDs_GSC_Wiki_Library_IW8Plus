// scripts\common\snd\snd.gsc  (hash_2ac9beb1e2a3768f.gscc) (size: 48391 Bytes / 0xbd07 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77c7b552 (2009576786)
// size ...... 48391 (0xbd07)
// includes .. 4   (offset: 0xb44f)
// strings ... 105 (offset: 0xb46f)
// dev strs .. 51  (offset: 0xba57)
// exports ... 118 (offset: 0x8013)
// cseg ...... 0xb72 + 0x74a1 (0x8013)
// imports ... 235 (offset: 0x9283)
// animtree1 . 0   (offset: 0xbd07)
// animtree2 . 0   (offset: 0xbd07)
#using scripts\common\snd\snd_debug;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;

#namespace snd;

// Namespace snd
// Params 0
// Checksum 0xb3450314, Offset: 0xb90
// Size: 0x16d
function init()
{
    if ( !isdefined( level.snd ) )
    {
        level.snd = spawnstruct();
        level.snd.is_server_script = 1;
        level.snd.callbacks = [];
        level.snd.objects = [];
        level.snd.unlinkedobjects = [];
        level.snd.var_2a51f6c197f5d64a = "gentity";
        level.snd.var_ac89ad1d83ec974c = 0;
        level.snd.callbacks[ "player_view" ] = &function_555d6a6de865e01d;
        level.snd.callbacks[ "player_angles" ] = &function_8420ced60f0e4e73;
        level.snd.callbacks[ "player_fov" ] = &function_2a93e54382fe5242;
    }
    
    curve_init();
    
    /#
        level thread snd_debug::snd_debug_init();
    #/
    
    utility::registersharedfunc( #"snd", #"play", &play );
    utility::registersharedfunc( #"snd", #"transient_load", &transient_load );
    utility::registersharedfunc( #"snd", #"transient_unload", &transient_unload );
}

// Namespace snd
// Params 1
// Checksum 0x8b2a4fb6, Offset: 0xd05
// Size: 0x6b
function init_obj( obj )
{
    assert( obj == level || isstruct( obj ) || isent( obj ) );
    
    if ( !isstruct( obj.snd ) )
    {
        obj.snd = spawnstruct();
    }
    
    assert( isstruct( obj.snd ), "<dev string:x24>" );
}

// Namespace snd
// Params 0
// Checksum 0xaa8f7324, Offset: 0xd78
// Size: 0x30
function is_first_frame()
{
    now = gettime();
    is_first_frame = did_init() == 0 || now <= 300;
    return is_first_frame;
}

// Namespace snd
// Params 0
// Checksum 0x5ac2cf8a, Offset: 0xdb1
// Size: 0x16, Type: bool
function did_init()
{
    if ( isstruct( level.snd ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 0
// Checksum 0x83a7c4a2, Offset: 0xdd0
// Size: 0x11
function wait_init()
{
    while ( did_init() == 0 )
    {
        waitframe();
    }
}

// Namespace snd
// Params 2
// Checksum 0xf0e4eb9d, Offset: 0xde9
// Size: 0x4a
function play( soundalias, targets )
{
    soundtype = level.snd.var_2a51f6c197f5d64a;
    soundobject = _type_play( soundtype, soundalias, targets );
    return soundobject;
}

// Namespace snd
// Params 2
// Checksum 0x8e480abc, Offset: 0xe3c
// Size: 0x8f
function stop( soundobject, fadeoutseconds )
{
    foreach ( soundobj in makearray( soundobject ) )
    {
        level thread _type_stop( soundobj, fadeoutseconds );
    }
}

// Namespace snd
// Params 3
// Checksum 0x8d16efc5, Offset: 0xed3
// Size: 0x102
function stop_alias( soundalias, targets, fadeoutseconds )
{
    if ( condition_alert( !isdefined( soundalias ), "snd::stop_alias with undefined soundalias" ) )
    {
        return 0;
    }
    
    soundalias = tolower( soundalias );
    soundobjects = get_sound_objects( targets );
    var_bb8a1432c4c7b751 = 0;
    
    foreach ( soundobj in soundobjects )
    {
        if ( !isdefined( soundobj.soundalias ) )
        {
            continue;
        }
        
        if ( issubstr( tolower( soundobj.soundalias ), soundalias ) )
        {
            stop( soundobj, fadeoutseconds );
            var_bb8a1432c4c7b751 = int( var_bb8a1432c4c7b751 + 1 );
        }
    }
    
    return var_bb8a1432c4c7b751;
}

// Namespace snd
// Params 4
// Checksum 0x42970e55, Offset: 0xfde
// Size: 0xe8
function stop_on_ent_notify( soundobject, notifyentity, notifystring, fadeoutseconds )
{
    if ( condition_alert( !is_sound_object( soundobject ), "snd::stop_on_ent_notify soundObject is not a snd object" ) )
    {
        return;
    }
    
    if ( condition_alert( !isent( notifyentity ), "snd::stop_on_ent_notify notifyEntity is not an entity" ) )
    {
        return;
    }
    
    if ( condition_alert( !isstring( notifystring ), "snd::stop_on_ent_notify notifyString is not a string" ) )
    {
        return;
    }
    
    foreach ( soundobj in makearray( soundobject ) )
    {
        notifyentity thread _type_stop_on_ent_notify( soundobj, notifyentity, notifystring, fadeoutseconds );
    }
}

// Namespace snd
// Params 3
// Checksum 0x106d2d7d, Offset: 0x10ce
// Size: 0xcd
function stop_on_ent_death( soundobject, deathentity, fadeoutseconds )
{
    if ( condition_alert( !is_sound_object( soundobject ), "stop_on_ent_death soundObject is not a snd object" ) )
    {
        return;
    }
    
    if ( condition_alert( !isent( deathentity ), "stop_on_ent_death deathEntity is not an entity" ) )
    {
        return;
    }
    
    foreach ( soundobj in makearray( soundobject ) )
    {
        deathentity thread _type_stop_on_ent_notify( soundobj, deathentity, "death", fadeoutseconds );
    }
}

// Namespace snd
// Params 3
// Checksum 0x76f2c6c2, Offset: 0x11a3
// Size: 0xc7
function stop_on_level_notify( soundobject, levelnotifystring, fadeoutseconds )
{
    if ( condition_alert( !is_sound_object( soundobject ), "stop_on_level_notify soundObject is not a snd object" ) )
    {
        return;
    }
    
    if ( condition_alert( !isstring( levelnotifystring ), "snd::stop_on_level_notify: levelNotifyString is not a string" ) )
    {
        return;
    }
    
    foreach ( soundobj in makearray( soundobject ) )
    {
        level thread _type_stop_on_level_notify( soundobj, levelnotifystring, fadeoutseconds );
    }
}

// Namespace snd
// Params 1
// Checksum 0x70f8e78, Offset: 0x1272
// Size: 0x10c
function await( soundobject )
{
    if ( condition_alert( !isdefined( soundobject ), "snd::await with undefined soundObject" ) )
    {
        return 0;
    }
    
    starttime = gettime();
    waittime = 0;
    
    while ( true )
    {
        var_8f75e74ffdcfb08c = 0;
        soundobjects = makearray( soundobject );
        soundobjects = function_5713d46873b29625( soundobjects );
        
        foreach ( soundobj in soundobjects )
        {
            if ( is_sound_object( soundobj ) )
            {
                var_8f75e74ffdcfb08c = 1;
                break;
            }
        }
        
        if ( var_8f75e74ffdcfb08c == 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    endtime = gettime();
    waittime = endtime - starttime;
    waittime /= 1000;
    return waittime;
}

// Namespace snd
// Params 1
// Checksum 0x49806427, Offset: 0x1387
// Size: 0x25, Type: bool
function is_sound_object( soundobject )
{
    if ( isdefined( soundobject ) && isdefined( soundobject.soundtype ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x3458625a, Offset: 0x13b5
// Size: 0x12f
function get_sound_objects( targets )
{
    sndobjs = [];
    
    foreach ( target in makearray( targets ) )
    {
        if ( !isdefined( target ) )
        {
            sndobjs = arraycombine( sndobjs, level.snd.objects );
            continue;
        }
        
        if ( condition_alert( isnumber( target ), "snd: get_sound_objects invalid target was a number" ) )
        {
            /#
                if ( function_97c5f949bfb92869() )
                {
                    InvalidOpCode( 0x2 );
                    // Unknown operator ( 0x2, t11, Black Ops 7 )
                }
            #/
            
            continue;
        }
        
        if ( target == level )
        {
            sndobjs = arraycombine( sndobjs, level.snd.unlinkedobjects );
            continue;
        }
        
        if ( isdefined( target.snd.objects ) )
        {
            sndobjs = arraycombine( sndobjs, target.snd.objects );
        }
    }
    
    return sndobjs;
}

// Namespace snd
// Params 2
// Checksum 0x247172e3, Offset: 0x14ed
// Size: 0x1f5
function get_alias_objects( soundalias, targets )
{
    if ( condition_alert( !isdefined( soundalias ), "snd::get_alias_objects with undefined soundalias" ) )
    {
        return 0;
    }
    
    soundaliases = [];
    
    if ( isarray( soundalias ) )
    {
        foreach ( alias in soundalias )
        {
            soundaliases[ soundaliases.size ] = tolower( alias );
        }
    }
    else if ( isstring( soundalias ) )
    {
        soundaliases = [ tolower( soundalias ) ];
    }
    
    assert( isarray( soundaliases ), "<dev string:x4a>" );
    soundobjects = get_sound_objects( targets );
    aliasobjects = [];
    
    foreach ( soundobj in soundobjects )
    {
        if ( !isdefined( soundobj.soundalias ) )
        {
            continue;
        }
        
        foreach ( alias in soundaliases )
        {
            if ( issubstr( tolower( soundobj.soundalias ), alias ) )
            {
                aliasobjects[ aliasobjects.size ] = soundobj;
            }
        }
    }
    
    return aliasobjects;
}

// Namespace snd
// Params 1
// Checksum 0xf6b4e820, Offset: 0x16eb
// Size: 0x1ac
function function_fa55cd8129e6b077( var_9c07cf4bd51380e9 = 1 )
{
    if ( !isdefined( level.snd.fnplaysoundonentity ) )
    {
        level.snd.fnplaysoundonentity = level.fnplaysoundonentity;
        level.snd.fnplaysoundontag = level.fnplaysoundontag;
        level.snd.var_310b0f85bce0b677 = anim.callbacks[ "PlaySoundAtViewHeight" ];
        level.snd.var_7119768b7aad30db = level.var_2689c6dcf643e172;
        level.snd.var_dc79a25e37790ce3 = level.var_e81bbb23302080e0;
    }
    
    if ( var_9c07cf4bd51380e9 )
    {
        level.fnplaysoundonentity = &function_4993f4090511cc67;
        level.fnplaysoundontag = &_play_on_tag;
        anim.callbacks[ "PlaySoundAtViewHeight" ] = &function_376b69c9159bdf11;
        level.var_2689c6dcf643e172 = &function_218a734708b7b909;
        level.var_e81bbb23302080e0 = &function_ff0ca0157e0ee15;
        return;
    }
    
    level.fnplaysoundonentity = level.snd.fnplaysoundonentity;
    level.fnplaysoundontag = level.snd.fnplaysoundontag;
    anim.callbacks[ "PlaySoundAtViewHeight" ] = level.snd.var_310b0f85bce0b677;
    level.var_2689c6dcf643e172 = level.snd.var_7119768b7aad30db;
    level.var_e81bbb23302080e0 = level.snd.var_dc79a25e37790ce3;
}

// Namespace snd
// Params 1
// Checksum 0xcb3598b2, Offset: 0x189f
// Size: 0x4c
function get_volume( soundobject )
{
    if ( isdefined( level.snd.callbacks[ "volume_get" ] ) )
    {
        return [[ level.snd.callbacks[ "volume_get" ] ]]( soundobject );
    }
    
    return 1;
}

// Namespace snd
// Params 5
// Checksum 0xdaf0b961, Offset: 0x18f4
// Size: 0x70
function set_volume( soundobject, volume, timeinseconds, curve, callbackfunc )
{
    if ( isdefined( level.snd.callbacks[ "volume_set" ] ) )
    {
        [[ level.snd.callbacks[ "volume_set" ] ]]( soundobject, volume, timeinseconds, curve, callbackfunc );
    }
}

// Namespace snd
// Params 1
// Checksum 0xbaed10ad, Offset: 0x196c
// Size: 0x4c
function get_pitch( soundobject )
{
    if ( isdefined( level.snd.callbacks[ "pitch_get" ] ) )
    {
        return [[ level.snd.callbacks[ "pitch_get" ] ]]( soundobject );
    }
    
    return 1;
}

// Namespace snd
// Params 5
// Checksum 0x74410391, Offset: 0x19c1
// Size: 0x70
function set_pitch( soundobject, pitch, timeinseconds, curve, callbackfunc )
{
    if ( isdefined( level.snd.callbacks[ "pitch_set" ] ) )
    {
        [[ level.snd.callbacks[ "pitch_set" ] ]]( soundobject, pitch, timeinseconds, curve, callbackfunc );
    }
}

// Namespace snd
// Params 0
// Checksum 0xa3b82ebb, Offset: 0x1a39
// Size: 0x23
function function_c007500a0f79e1d0()
{
    if ( level.snd.is_client_script )
    {
        return "centity";
    }
    
    return "gentity";
}

// Namespace snd
// Params 0
// Checksum 0x43e4e52c, Offset: 0x1a65
// Size: 0x15
function type_get_default()
{
    return level.snd.var_2a51f6c197f5d64a;
}

// Namespace snd
// Params 1
// Checksum 0xcc9ff6c8, Offset: 0x1a83
// Size: 0x35
function type_set_default( type = function_c007500a0f79e1d0() )
{
    level.snd.var_2a51f6c197f5d64a = type_string( type );
}

// Namespace snd
// Params 1
// Checksum 0x1403420a, Offset: 0x1ac0
// Size: 0x2c
function get_type( soundobject )
{
    if ( isdefined( soundobject.soundtype ) )
    {
        return soundobject.soundtype;
    }
    
    return "";
}

// Namespace snd
// Params 1
// Checksum 0xa05c4936, Offset: 0x1af5
// Size: 0x8c
function type_string( soundtype )
{
    snd_type = undefined;
    
    switch ( soundtype )
    {
        case #"hash_59f13b3cf23ba655":
            snd_type = "gentity";
            break;
        case #"hash_9ffcd1094df9c111":
            snd_type = "centity";
            break;
        case #"hash_cb36e64f12ba9ad":
            snd_type = "emitter";
            break;
        default:
            snd_type = undefined;
            break;
    }
    
    assert( isdefined( snd_type ), "<dev string:x7f>" + soundtype );
    return snd_type;
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x71eaf1e2, Offset: 0x1b8a
// Size: 0xb3
function private function_f60fb6d5000649ff( snd_type, snd_key, item )
{
    assert( isstruct( level.snd ), "<dev string:x9d>" );
    assert( isdefined( level.snd.objects ), "<dev string:x9d>" );
    
    switch ( snd_type )
    {
        default:
            assert( 0, "<dev string:xb5>" );
            break;
        case #"hash_59f13b3cf23ba655":
        case #"hash_9ffcd1094df9c111":
            level.snd.objects[ snd_key ] = item;
            break;
    }
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x5687dce2, Offset: 0x1c45
// Size: 0xd7
function private function_bd6e0351c5d4abde( snd_type, snd_key, item )
{
    assert( isstruct( level.snd ), "<dev string:x9d>" );
    assert( isdefined( level.snd.objects ), "<dev string:x9d>" );
    
    switch ( snd_type )
    {
        default:
            assert( 0, "<dev string:xb5>" );
            break;
        case #"hash_59f13b3cf23ba655":
        case #"hash_9ffcd1094df9c111":
            assert( arraycontains( level.snd.objects, item ), "<dev string:xc6>" );
            level.snd.objects[ snd_key ] = undefined;
            break;
    }
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x187a2611, Offset: 0x1d24
// Size: 0x42
function private function_3d26f909e7bfe42f()
{
    snd_type = self.soundtype;
    snd_key = self.soundkey;
    self waittill( #"death" );
    function_bd6e0351c5d4abde( snd_type, snd_key, self );
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x84c4fe93, Offset: 0x1d6e
// Size: 0x17c
function private function_efb651632a22aae8( ent, var_4c4b477220e237e3, linkedentity, linkedbonetag )
{
    assert( isdefined( ent ), "<dev string:xe9>" );
    assert( isdefined( ent.soundkey ), "<dev string:x100>" );
    
    if ( isdefined( linkedentity ) )
    {
        linkedbonetag = linkedentity gettagsafe( linkedbonetag );
        linkedoffset = ( 0, 0, 0 );
        linkedangles = ( 0, 0, 0 );
        
        if ( isdefined( var_4c4b477220e237e3 ) )
        {
            linkedoffset = var_4c4b477220e237e3;
        }
        
        assert( isdefined( linkedbonetag ), "<dev string:x118>" );
        willlinkto = 1;
        
        if ( !utility::issp() && linkedentity utility::is_dead_sentient() )
        {
            willlinkto = 0;
        }
        else if ( linkedentity utility::function_de1f80d93273abf5() )
        {
            ent enablelinkto();
        }
        
        if ( willlinkto )
        {
            ent linkto( linkedentity, linkedbonetag, linkedoffset, linkedangles );
        }
        
        init_obj( linkedentity );
        
        if ( !isarray( linkedentity.snd.objects ) )
        {
            linkedentity.snd.objects = [];
        }
        
        linkedentity.snd.objects[ ent.soundkey ] = ent;
        return;
    }
    
    level.snd.unlinkedobjects[ ent.soundkey ] = ent;
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x23224be5, Offset: 0x1ef2
// Size: 0x1e1
function private function_97405498b030baed( soundalias, var_4c4b477220e237e3, linkedentity, linkedbonetag )
{
    ent = undefined;
    spawnorigin = undefined;
    
    if ( isdefined( linkedentity ) && isdefined( linkedbonetag ) && isdefined( var_4c4b477220e237e3 ) )
    {
        assert( linkedentity tagexists( linkedbonetag ), "<dev string:x135>" + linkedbonetag );
        tag_origin = linkedentity gettagorigin( linkedbonetag );
        tag_angles = linkedentity gettagangles( linkedbonetag );
        tag_forward = var_4c4b477220e237e3[ 0 ] * anglestoforward( tag_angles );
        tag_right = var_4c4b477220e237e3[ 1 ] * anglestoright( tag_angles ) * -1;
        tag_up = var_4c4b477220e237e3[ 2 ] * anglestoup( tag_angles );
        spawnorigin = tag_origin + tag_right + tag_forward + tag_up;
    }
    else if ( isdefined( linkedentity ) && isdefined( linkedbonetag ) )
    {
        spawnorigin = linkedentity gettagorigin( linkedbonetag );
    }
    else if ( isdefined( linkedentity ) )
    {
        spawnorigin = linkedentity.origin;
    }
    else if ( !isdefined( linkedentity ) && !isdefined( var_4c4b477220e237e3 ) )
    {
        var_6bad63598b514a01 = ( 0, 0, -32768 );
        spawnorigin = var_6bad63598b514a01;
    }
    else
    {
        spawnorigin = var_4c4b477220e237e3;
    }
    
    assert( isdefined( spawnorigin ) );
    ent = undefined;
    
    if ( isdefined( linkedentity ) )
    {
        ent = spawn( "script_model", spawnorigin );
        
        if ( isent( ent ) )
        {
            ent setmodel( "tag_origin" );
        }
    }
    else
    {
        ent = spawn( "script_origin", spawnorigin );
    }
    
    assert( isdefined( ent ), "<dev string:x165>" );
    
    if ( isent( ent ) )
    {
        ent.soundlinkedentity = linkedentity;
        ent.soundtype = "gentity";
        ent.soundkey = ent getentitynumber();
        ent.targetname = "snd " + soundalias;
    }
    
    return ent;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xe5184804, Offset: 0x20dc
// Size: 0x116
function private function_c8eec94ca318e806( ent )
{
    if ( condition_alert( !isdefined( ent ) || is_object_invalid( ent ), "snd: free on deleted entity!" ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
        
        return;
    }
    
    if ( isdefined( ent.soundlinkedentity ) && isarray( ent.soundlinkedentity.snd.objects ) )
    {
        linkedentity = ent.soundlinkedentity;
        var_126da81f3bcb3708 = isdefined( linkedentity.snd.objects[ ent.soundkey ] );
        
        if ( var_126da81f3bcb3708 == 1 )
        {
            linkedentity.snd.objects[ ent.soundkey ] = undefined;
        }
        else
        {
            /#
                if ( function_97c5f949bfb92869() )
                {
                    InvalidOpCode( 0x2 );
                    // Unknown operator ( 0x2, t11, Black Ops 7 )
                }
            #/
        }
    }
    else
    {
        level.snd.unlinkedobjects[ ent.soundkey ] = undefined;
    }
    
    waittillframeend();
    ent delete();
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0xceda96e1, Offset: 0x21fa
// Size: 0x1b1
function private function_ecb27d47ed83f41a( soundobject, soundalias, initialvolume, delaytime )
{
    ent = soundobject;
    currentvolume = undefined;
    ent endon( #"death" );
    assert( isdefined( ent ) );
    assert( isstring( soundalias ) );
    currentvolume = get_volume( ent );
    
    if ( !isdefined( initialvolume ) && isdefined( currentvolume ) )
    {
        initialvolume = currentvolume;
    }
    
    if ( is_first_frame() )
    {
        var_11e24b40622d11f0 = !isdefined( delaytime ) || isnumber( delaytime ) && delaytime == 0;
        
        if ( condition_alert( var_11e24b40622d11f0, "snd: delayed due to first frame!" ) )
        {
            delaytime = 0.05;
        }
    }
    
    if ( isnumber( delaytime ) && delaytime > 0 )
    {
        wait delaytime;
    }
    
    waittillframeend();
    assert( soundexists( soundalias ), "<dev string:x18a>" + soundalias );
    
    if ( soundislooping( soundalias ) )
    {
        ent playloopsound( soundalias );
    }
    else
    {
        donenotifystr = "sounddone";
        
        if ( utility::issp() )
        {
            ent playsound( soundalias, donenotifystr );
            var_de7c4c1e3b9f57a2 = 0;
            
            if ( var_de7c4c1e3b9f57a2 )
            {
                ent thread function_2728886341de4a91( soundalias, donenotifystr );
            }
            else
            {
                ent thread function_ad317b00736f1bfa( donenotifystr );
            }
        }
        else
        {
            if ( isdefined( ent.soundlinkedentity ) && isdefined( level.snd.fnplaysoundonmovingent ) )
            {
                waitframe();
                ent builtin [[ level.snd.fnplaysoundonmovingent ]]( soundalias );
            }
            else
            {
                ent playsound( soundalias );
            }
            
            ent thread function_2728886341de4a91( soundalias, donenotifystr );
        }
    }
    
    ent.soundalias = soundalias;
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0xb6572c6c, Offset: 0x23b3
// Size: 0xc2
function private function_7a71e28b1b7b7d20( soundobject, fadeoutseconds )
{
    soundobject endon( #"death" );
    ent = soundobject;
    
    if ( condition_alert( !isdefined( ent ) || is_object_invalid( ent ), "snd: stop on deleted entity!" ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
        
        return;
    }
    
    soundalias = ent.soundalias;
    
    if ( !isdefined( fadeoutseconds ) )
    {
        fadeoutseconds = 0;
    }
    
    if ( isstring( soundalias ) )
    {
        if ( soundislooping( soundalias ) )
        {
            ent stoploopsound();
        }
        else
        {
            ent stopsounds();
        }
        
        waitframe();
        ent.soundalias = undefined;
    }
    
    ent.soundtype = undefined;
    function_c8eec94ca318e806( ent );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x41e79ebc, Offset: 0x247d
// Size: 0x91
function private function_2728886341de4a91( soundalias, done )
{
    ent = self;
    ent endon( #"death" );
    waittime = lookupsoundlength( soundalias, 1 );
    waittime /= 1000;
    pitchmin = function_4f80a4872306be7c( soundalias, "pitch_min" );
    
    if ( isdefined( pitchmin ) )
    {
        waittime *= 1 / pitchmin;
    }
    
    wait waittime;
    ent notify( done, ent.soundalias );
    function_c8eec94ca318e806( ent );
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x8a54b139, Offset: 0x2516
// Size: 0x45
function private function_ad317b00736f1bfa( done )
{
    ent = self;
    ent endon( #"death" );
    ent waittill( done );
    ent notify( done, ent.soundalias );
    function_c8eec94ca318e806( ent );
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x4e0b3cae, Offset: 0x2563
// Size: 0x35
function private function_900a06ee2994c7c( ent, var_4c4b477220e237e3, linkedentity, linkedbonetag )
{
    assert( 0, "<dev string:x1a5>" );
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x6e762210, Offset: 0x25a0
// Size: 0x35
function private function_28a47238abb77ad1( soundalias, var_4c4b477220e237e3, linkedentity, linkedbonetag )
{
    assert( 0, "<dev string:x1a5>" );
}

/#

    // Namespace snd
    // Params 1, eflags: 0x4
    // Checksum 0x63fb1224, Offset: 0x25de
    // Size: 0x1a, Type: dev
    function private function_16d5e04fb5a10822( ent )
    {
        assert( 0, "<dev string:x1a5>" );
    }

#/

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x7fd54087, Offset: 0x2600
// Size: 0x35
function private function_ee627fda9dcf6f6( soundobject, soundalias, initialvolume, delaytime )
{
    assert( 0, "<dev string:x1a5>" );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x448216de, Offset: 0x263d
// Size: 0x23
function private function_883d3d4185cc42a4( soundobject, fadeoutseconds )
{
    assert( 0, "<dev string:x1a5>" );
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x34110f82, Offset: 0x2668
// Size: 0x21
function private function_555d6a6de865e01d()
{
    player = self;
    vieworigin = player geteye();
    return vieworigin;
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x4425b975, Offset: 0x2692
// Size: 0x21
function private function_8420ced60f0e4e73()
{
    player = self;
    viewangles = player getplayerangles();
    return viewangles;
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x43212620, Offset: 0x26bc
// Size: 0x2a
function private function_2a93e54382fe5242()
{
    player = self;
    fov = getdvarfloat( @"cg_fov", 65 );
    return fov;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xb6ed24c4, Offset: 0x26ef
// Size: 0x12c
function private function_daad5318a1b819f4( soundarg )
{
    delaytime = 0;
    soundalias = undefined;
    fadeinseconds = undefined;
    
    if ( isarray( soundarg ) )
    {
        keys = soundarg;
        soundalias = undefined;
        aliasindex = keys.size + 1;
        
        foreach ( i, key in keys )
        {
            if ( isstring( key ) )
            {
                soundalias = key;
                aliasindex = i;
            }
            
            if ( isnumber( key ) && i < aliasindex )
            {
                delaytime = key;
            }
            
            if ( isnumber( key ) && i > aliasindex )
            {
                fadeinseconds = key;
            }
        }
    }
    else if ( isstring( soundarg ) )
    {
        soundalias = soundarg;
    }
    
    sndparam = [ delaytime, soundalias, fadeinseconds ];
    return sndparam;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x69f6a4fb, Offset: 0x2824
// Size: 0x318
function private _type_get_targets( targ )
{
    targets = [];
    
    if ( !isdefined( targ ) )
    {
        foreach ( player in getplayerssafe() )
        {
            tagname = player gettagsafe( "j_head" );
            
            if ( player.model != "" && tagname != "" )
            {
                targets[ targets.size ] = [ player, tagname ];
                continue;
            }
            
            targets[ targets.size ] = player;
        }
    }
    else if ( isarray( targ ) )
    {
        if ( condition_alert( targ.size == 0, "snd: zero-sized array used for targ" ) )
        {
            return;
        }
        else if ( targ.size == 2 )
        {
            if ( isent( targ[ 0 ] ) && isstring( targ[ 1 ] ) )
            {
                targets = [ targ ];
            }
            else if ( isent( targ[ 0 ] ) && isvector( targ[ 1 ] ) )
            {
                targets = [ targ ];
            }
            else if ( isent( targ[ 0 ] ) && !isdefined( targ[ 1 ] ) )
            {
                targets = [ targ[ 0 ] ];
            }
            else if ( isstring( targ[ 0 ] ) && isstring( targ[ 1 ] ) )
            {
                firsttargets = gettargetnames( targ[ 0 ] );
                secondtargets = gettargetnames( targ[ 1 ] );
                targets = arraycombine( firsttargets, secondtargets );
            }
            else
            {
                targets = targ;
            }
        }
        else
        {
            targets = [];
            
            foreach ( key in targ )
            {
                if ( isent( key ) || isstruct( key ) && isdefined( key.origin ) || isvector( key ) || isarray( key ) )
                {
                    targets[ targets.size ] = key;
                    continue;
                }
                
                if ( isstring( key ) )
                {
                    tnames = gettargetnames( key );
                    
                    foreach ( t in tnames )
                    {
                        targets[ targets.size ] = t;
                    }
                }
            }
        }
    }
    else if ( isstring( targ ) )
    {
        targets = gettargetnames( targ );
    }
    else
    {
        targets = [ targ ];
    }
    
    return targets;
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x8e08ec7a, Offset: 0x2b45
// Size: 0x5ab
function private _type_play( soundtype, soundalias, var_78adb4929ccfe48b, var_6c5594fc32fc28c8 )
{
    if ( condition_alert( !did_init(), "snd was not initialized!" ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
        
        return;
    }
    
    if ( condition_alert( !isdefined( soundalias ), "snd::play: sound alias undefined" ) )
    {
        return;
    }
    
    assert( isdefined( level.snd.var_2a51f6c197f5d64a ), "<dev string:x9d>" );
    
    if ( !isdefined( soundtype ) )
    {
        soundtype = level.snd.var_2a51f6c197f5d64a;
    }
    
    soundobjects = [];
    targets = [];
    soundparam = function_daad5318a1b819f4( soundalias );
    assert( isarray( soundparam ) && soundparam.size >= 2, "<dev string:x1c5>" );
    delaytime = soundparam[ 0 ];
    soundalias = soundparam[ 1 ];
    fadeinseconds = soundparam[ 2 ];
    initialvolume = undefined;
    
    if ( condition_alert( isstring( soundalias ) && soundalias == "", "snd::play: empty sound alias \"\"" ) )
    {
        return;
    }
    
    assert( isstring( soundalias ), "<dev string:x1df>" );
    islooping = soundislooping( soundalias );
    sndexists = soundexists( soundalias );
    
    if ( condition_alert( !sndexists, "snd: sound alias '" + soundalias + "' does not exist!" ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
        
        return;
    }
    
    if ( !isdefined( fadeinseconds ) )
    {
        if ( islooping )
        {
            fadeinseconds = level.snd.var_ac89ad1d83ec974c;
        }
        else
        {
            fadeinseconds = 0;
        }
    }
    
    if ( fadeinseconds > 0 )
    {
        initialvolume = 0;
    }
    
    assert( isdefined( fadeinseconds ) );
    targets = _type_get_targets( var_78adb4929ccfe48b );
    
    if ( condition_alert( !isdefined( targets ), "snd: undefined targets" ) )
    {
        return;
    }
    
    foreach ( t in targets )
    {
        linkedentity = undefined;
        linkedbonetag = undefined;
        var_4c4b477220e237e3 = undefined;
        soundobject = undefined;
        ise = isent( t );
        isr = is_object_invalid( t );
        iss = isstruct( t );
        isv = isvector( t );
        isn = isstring( t );
        isa = isarray( t );
        
        if ( ise )
        {
            linkedentity = t;
            var_4c4b477220e237e3 = ( 0, 0, 0 );
        }
        else if ( condition_alert( isr, "snd: could not play on removed entity" ) )
        {
            continue;
        }
        else if ( iss )
        {
            if ( condition_alert( !isdefined( t.origin ), "snd: sound alias '" + soundalias + "' played on struct with no origin!" ) )
            {
                continue;
            }
            else
            {
                var_4c4b477220e237e3 = t.origin;
            }
        }
        else if ( isv )
        {
            var_4c4b477220e237e3 = t;
        }
        else if ( isn )
        {
        }
        else if ( isarray( t ) )
        {
            if ( !isdefined( t[ 0 ] ) || is_object_invalid( t[ 0 ] ) )
            {
                continue;
            }
            else if ( isent( t[ 0 ] ) && isstring( t[ 1 ] ) )
            {
                linkedentity = t[ 0 ];
                linkedbonetag = t[ 1 ];
                var_4c4b477220e237e3 = ( 0, 0, 0 );
                
                if ( condition_alert( !linkedentity tagexists( linkedbonetag ), "snd: entity tag does not exist: " + linkedbonetag ) )
                {
                    linkedbonetag = "tag_origin";
                }
                
                if ( isvector( t[ 2 ] ) )
                {
                    var_4c4b477220e237e3 = t[ 2 ];
                }
            }
            else if ( isent( t[ 0 ] ) && isvector( t[ 1 ] ) )
            {
                linkedentity = t[ 0 ];
                var_4c4b477220e237e3 = t[ 1 ];
            }
            else if ( condition_alert( 1, "snd: unexpected target array combination" ) )
            {
            }
        }
        
        switch ( soundtype )
        {
            default:
                assert( 0, "<dev string:x1f9>" );
                break;
            case #"hash_59f13b3cf23ba655":
                soundobject = function_97405498b030baed( soundalias, var_4c4b477220e237e3, linkedentity, linkedbonetag );
                
                if ( isent( soundobject ) )
                {
                    function_efb651632a22aae8( soundobject, var_4c4b477220e237e3, linkedentity, linkedbonetag );
                    function_f60fb6d5000649ff( "gentity", soundobject.soundkey, soundobject );
                    soundobject thread function_3d26f909e7bfe42f();
                }
                
                break;
            case #"hash_9ffcd1094df9c111":
                soundobject = function_28a47238abb77ad1( soundalias, var_4c4b477220e237e3, linkedentity, linkedbonetag );
                
                if ( isent( soundobject ) )
                {
                    function_900a06ee2994c7c( soundobject, var_4c4b477220e237e3, linkedentity, linkedbonetag );
                    function_f60fb6d5000649ff( "centity", soundobject.soundkey, soundobject );
                    soundobject thread function_3d26f909e7bfe42f();
                }
                
                break;
        }
        
        if ( isdefined( soundobject ) && is_sound_object( soundobject ) )
        {
            switch ( soundtype )
            {
                case #"hash_59f13b3cf23ba655":
                default:
                    soundobject thread function_ecb27d47ed83f41a( soundobject, soundalias, initialvolume, delaytime );
                    break;
                case #"hash_9ffcd1094df9c111":
                    soundobject thread function_ee627fda9dcf6f6( soundobject, soundalias, initialvolume, delaytime );
                    break;
            }
            
            if ( fadeinseconds > 0 )
            {
                if ( soundtype == "gentity" && isdefined( linkedentity ) )
                {
                    delaytime += 0.05;
                }
                
                soundobject thread function_3d15e154be0e8708( soundobject, fadeinseconds, delaytime );
            }
            
            soundobjects[ soundobjects.size ] = soundobject;
        }
    }
    
    if ( condition_alert( soundobjects.size == 0, "snd: zero sound objects played" ) )
    {
        return;
    }
    
    return function_96110023c8018546( soundobjects );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x8929c14f, Offset: 0x30f9
// Size: 0x230
function private _type_stop( soundobject, fadeoutseconds )
{
    if ( condition_alert( !isstruct( level.snd ) || !isdefined( level.snd.var_2a51f6c197f5d64a ), "snd was not initialized" ) )
    {
        return;
    }
    
    if ( condition_alert( !isdefined( soundobject ) || is_object_invalid( soundobject ), "snd::stop with undefined soundObject" ) )
    {
        return;
    }
    
    if ( condition_alert( !isdefined( soundobject.soundtype ), "snd::stop with unknown type" ) )
    {
        return;
    }
    
    assert( isdefined( level.snd.var_2a51f6c197f5d64a ), "<dev string:x9d>" );
    assert( isdefined( soundobject ), "<dev string:x210>" );
    assert( isdefined( soundobject.soundtype ), "<dev string:x237>" );
    
    if ( soundobject.soundtype == "emitter" )
    {
        soundobject notify( #"snd_emitter_stop" );
        soundobject.soundtype = undefined;
        soundobject.soundalias = undefined;
        soundobject.soundlinkedentity = undefined;
        soundobject.origin = undefined;
        soundobject.angles = undefined;
        return;
    }
    
    soundobject endon( #"death" );
    soundtype = soundobject.soundtype;
    soundalias = soundobject.soundalias;
    islooping = undefined;
    
    if ( isstring( soundalias ) )
    {
        islooping = soundislooping( soundalias );
    }
    
    if ( islooping && !isdefined( fadeoutseconds ) )
    {
        fadeoutseconds = float( level.snd.var_ac89ad1d83ec974c );
    }
    else if ( isnumber( fadeoutseconds ) )
    {
        fadeoutseconds = float( fadeoutseconds );
    }
    
    if ( isdefined( soundalias ) && isfloat( fadeoutseconds ) )
    {
        set_volume( soundobject, 0, fadeoutseconds );
        wait fadeoutseconds;
        waitframe();
        
        if ( is_object_invalid( soundobject ) )
        {
            return;
        }
    }
    
    switch ( soundtype )
    {
        case #"hash_59f13b3cf23ba655":
        default:
            function_7a71e28b1b7b7d20( soundobject, fadeoutseconds );
            break;
        case #"hash_9ffcd1094df9c111":
            function_883d3d4185cc42a4( soundobject, fadeoutseconds );
            break;
    }
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x9856b639, Offset: 0x3331
// Size: 0x4e
function private _type_stop_on_ent_notify( soundobject, notifyentity, notifystring, fadeoutseconds )
{
    soundobject endon( #"death" );
    notifyentity utility::waittill_any( "death", notifystring );
    _type_stop( soundobject, fadeoutseconds );
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0xb5f0999, Offset: 0x3387
// Size: 0x3b
function private _type_stop_on_level_notify( soundobject, levelnotifystring, fadeoutseconds )
{
    soundobject endon( #"death" );
    level waittill( levelnotifystring );
    _type_stop( soundobject, fadeoutseconds );
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x7ab6c5fc, Offset: 0x33ca
// Size: 0x9f
function private function_3d15e154be0e8708( soundobject, fadeinseconds, delaytime )
{
    if ( condition_alert( !isdefined( soundobject ) || is_object_invalid( soundobject ), "snd: fade in on deleted gentity!" ) )
    {
        return;
    }
    
    assert( isdefined( soundobject ) );
    soundobject endon( #"death" );
    soundobject endon( #"stopfade" );
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0;
    }
    
    set_volume( soundobject, 0, 0 );
    
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    set_volume( soundobject, 1, fadeinseconds );
}

// Namespace snd
// Params 1
// Checksum 0x77848f07, Offset: 0x3471
// Size: 0x6c
function get_target_pos( target )
{
    position = undefined;
    
    if ( isvector( target ) )
    {
        position = target;
    }
    else if ( isplayersafe( target ) )
    {
        position = target getplayervieworigin();
    }
    else if ( !is_object_invalid( target ) && isdefined( target.origin ) )
    {
        position = target.origin;
    }
    
    return position;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x1f1d654b, Offset: 0x34e6
// Size: 0x140
function private function_f2c5f37c78e0ae97( rotationrange )
{
    var_4d9b73147ea83832 = randomfloatrange( -180, 180 );
    rotation = 0;
    
    if ( isarray( rotationrange ) )
    {
        if ( rotationrange.size == 1 )
        {
            rotationrange = rotationrange[ 0 ];
        }
        else if ( rotationrange.size == 2 )
        {
            rotation = rangehelper( rotationrange );
        }
        else if ( rotationrange.size == 3 )
        {
            var_4d9b73147ea83832 = rotationrange[ 0 ];
            rotation = rangehelper( rotationrange );
            adjustedrotationrange = [ rotationrange[ 1 ], rotationrange[ 2 ] ];
            rotation = rangehelper( adjustedrotationrange );
        }
        else if ( rotationrange.size >= 4 )
        {
            var_e7f970fb92083e9f = [ rotationrange[ 0 ], rotationrange[ 1 ] ];
            var_4d9b73147ea83832 = rangehelper( var_e7f970fb92083e9f );
            adjustedrotationrange = [ rotationrange[ 2 ], rotationrange[ 3 ] ];
            rotation = rangehelper( adjustedrotationrange );
        }
    }
    
    if ( isnumber( rotationrange ) && rotationrange != 0 )
    {
        absrotation = abs( rotationrange );
        min = -1 * absrotation;
        max = absrotation;
        rotation = randomfloatrange( min, max );
    }
    
    return [ var_4d9b73147ea83832, rotation ];
}

// Namespace snd
// Params 5, eflags: 0x4
// Checksum 0x654c20, Offset: 0x362f
// Size: 0x1cc
function private _emitter_rotate( target, dist, var_4d9b73147ea83832, elevation, rotation )
{
    self endon( #"death" );
    self endon( #"sounddone" );
    
    if ( isdefined( rotation ) == 0 || rotation == 0 )
    {
        return;
    }
    
    assert( isent( target ) || isstruct( target ) && isdefined( target.origin ) || isvector( target ), "<dev string:x24d>" );
    assert( isnumber( dist ), "<dev string:x24d>" );
    assert( isnumber( var_4d9b73147ea83832 ), "<dev string:x24d>" );
    assert( isnumber( rotation ), "<dev string:x24d>" );
    
    /#
        if ( function_542b9fda0c23d8f4() > 2 )
        {
            randred = randomfloat( 1 );
            randgreen = randomfloat( 1 );
            randblue = randomfloat( 1 );
            randomcolor = ( randred, randgreen, randblue );
            randomcolor = vectornormalize( randomcolor );
            drawpath( self, randomcolor );
        }
    #/
    
    movetime = function_76f9a4325afecc73() * 2;
    rotationstep = rotation * movetime;
    
    while ( true )
    {
        centerorigin = get_target_pos( target );
        
        if ( !isvector( centerorigin ) )
        {
            break;
        }
        
        position = orbitalposition( centerorigin, dist, var_4d9b73147ea83832, elevation );
        self moveto( position, movetime, 0, 0 );
        var_4d9b73147ea83832 += rotationstep;
        wait movetime;
        
        /#
            if ( function_542b9fda0c23d8f4() <= 2 )
            {
                self notify( #"hash_2605f8ddd93ed8f9" );
            }
        #/
    }
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x867d48ef, Offset: 0x3803
// Size: 0x13b
function private _emitter_stop( emitter )
{
    iss = isstruct( emitter );
    hast = isdefined( emitter.soundtype );
    ist = emitter.soundtype == "emitter";
    is_emitter = iss && hast && ist;
    
    if ( condition_alert( is_emitter == 0, "snd emitter stop not an emitter" ) )
    {
        return;
    }
    
    assert( isdefined( emitter.soundkey ), "<dev string:x24e>" );
    assert( isdefined( level.snd.emitterkey ), "<dev string:x26c>" );
    assert( isdefined( level.snd.emitters ), "<dev string:x289>" );
    level.snd.emitters[ emitter.soundkey ] = undefined;
    emitter notify( #"snd_emitter_stop" );
    emitter.soundtype = undefined;
    emitter.soundalias = undefined;
    emitter.soundlinkedentity = undefined;
    emitter.origin = undefined;
    emitter.angles = undefined;
    emitter = undefined;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xda2bfbda, Offset: 0x3946
// Size: 0x71
function private _emitter( target )
{
    self endon( #"snd_emitter_stop" );
    level endon( #"snd_emitter_stop" );
    assert( isarray( target ) == 0, "<dev string:x2b5>" );
    
    if ( isvector( target ) )
    {
        target = self;
    }
    
    while ( true )
    {
        wait rangehelper( self.spawntime, 0.05 );
        
        if ( !_emitter_play( target ) )
        {
            break;
        }
    }
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xf92c92dc, Offset: 0x39bf
// Size: 0x171, Type: bool
function private _emitter_play( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    dist = rangehelper( self.distancerange ?? 0 );
    var_37c381548ea0d20 = function_f2c5f37c78e0ae97( self.rotationrange );
    assert( isarray( var_37c381548ea0d20 ) && var_37c381548ea0d20.size != 0 );
    var_4d9b73147ea83832 = var_37c381548ea0d20[ 0 ];
    rotation = var_37c381548ea0d20[ 1 ];
    elevation = rangehelper( self.elevationrange ?? 0 );
    targetposition = get_target_pos( target );
    position = orbitalposition( targetposition, dist, var_4d9b73147ea83832, elevation );
    sndobj = play( self.soundalias, position );
    
    if ( isdefined( sndobj ) && isdefined( rotation ) && dist > 0 && rotation != 0 )
    {
        sndobj thread _emitter_rotate( target, dist, var_4d9b73147ea83832, elevation, rotation );
    }
    
    if ( isarray( self.spawntime ) && self.spawntime.size >= 4 )
    {
        assert( self.spawntime.size == 4, "<dev string:x2e2>" );
        self.spawntime = [ self.spawntime[ 2 ], self.spawntime[ 3 ] ];
    }
    
    return true;
}

// Namespace snd
// Params 6
// Checksum 0xa769f597, Offset: 0x3b39
// Size: 0x33e
function emitter( soundalias, target, spawntime, distancerange, rotation, elevation )
{
    emitters = [];
    targets = target;
    islooping = soundislooping( soundalias );
    isexists = isdefined( islooping );
    
    if ( condition_alert( !isexists, "snd::emitter soundalias does not exist: " + soundalias ) )
    {
        return;
    }
    
    if ( condition_alert( islooping, "snd::emitter cannot emit looping alias: " + soundalias ) )
    {
        return;
    }
    
    if ( !isdefined( level.snd.emitterkey ) )
    {
        level.snd.emitterkey = 2432;
        level.snd.emitters = [];
    }
    
    assert( isdefined( level.snd.emitterkey ), "<dev string:x26c>" );
    assert( soundexists( soundalias ), "<dev string:x324>" + soundalias );
    assert( isdefined( target ), "<dev string:x34d>" );
    assert( isdefined( spawntime ), "<dev string:x36e>" );
    
    if ( isarray( targets ) == 0 )
    {
        targets = [ target ];
    }
    
    foreach ( t in targets )
    {
        ise = isent( t );
        isv = isvector( t );
        
        if ( ise || isv )
        {
            emitter = spawnstruct();
            emitter.soundtype = "emitter";
            emitter.soundalias = soundalias;
            emitter.spawntime = spawntime;
            emitter.distancerange = distancerange;
            emitter.rotationrange = rotation;
            emitter.elevationrange = elevation;
            level.snd.emitterkey = int( level.snd.emitterkey + 1 );
            emitter.soundkey = string( level.snd.emitterkey );
            level.snd.emitters[ emitter.soundkey ] = emitter;
            
            if ( ise )
            {
                emitter.soundlinkedentity = t;
            }
            
            if ( isv )
            {
                emitter.origin = t;
                emitter.angles = ( 0, 0, 0 );
            }
            
            emitter thread _emitter( t );
            emitters[ emitters.size ] = emitter;
            continue;
        }
        
        condition_alert( ise == 0 && isv == 0, "snd::emitter target '" + t + "' was not an entity or vector." );
    }
    
    condition_alert( emitters.size == 0, "snd::emitter resulted in zero emitter targets" );
    return function_96110023c8018546( emitters );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x6f88a6dd, Offset: 0x3e80
// Size: 0x3e
function private function_29dc2536738aac95( ai_actor, snd )
{
    if ( isent( ai_actor ) && ai_actor utility::ent_flag( "_dialog_anim_playing" ) )
    {
        stop_on_ent_notify( snd, ai_actor, "dialog_tree_cancel_response" );
    }
}

// Namespace snd
// Params 5
// Checksum 0xf99a2c81, Offset: 0x3ec6
// Size: 0xd3
function _play_on_tag( alias, tag, ends_on_death, op_notify_string, radio_dialog )
{
    if ( utility::is_dead_sentient() )
    {
        return;
    }
    
    target = [ self, tag ];
    snd = _type_play( level.snd.var_2a51f6c197f5d64a, alias, target );
    
    /#
        if ( self == level.player_radio_emitter )
        {
            println( "<dev string:x392>" + alias );
        }
    #/
    
    if ( isdefined( ends_on_death ) )
    {
        assert( ends_on_death, "<dev string:x3b1>" );
        stop_on_ent_death( snd, self );
    }
    
    function_29dc2536738aac95( self, snd );
    await( snd );
    
    if ( isdefined( op_notify_string ) )
    {
        self notify( op_notify_string );
    }
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x86a1ec6e, Offset: 0x3fa1
// Size: 0x35
function private function_4993f4090511cc67( alias, op_notify_string )
{
    assert( !isspawner( self ), "<dev string:x3d9>" );
    _play_on_tag( alias, undefined, undefined, op_notify_string );
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x77ce71be, Offset: 0x3fde
// Size: 0xc7
function private function_376b69c9159bdf11( soundalias, notifystring, var_e687e17a26877b06 = 0 )
{
    if ( !soundexists( soundalias ) )
    {
        /#
            iprintln( "<dev string:x3f7>" + soundalias );
        #/
        
        if ( isstring( notifystring ) )
        {
            waitframe();
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            self notify( notifystring );
            self notify( #"single dialogue" );
        }
        
        return;
    }
    
    target = [ self, "j_head" ];
    snd = _type_play( level.snd.var_2a51f6c197f5d64a, soundalias, target );
    
    if ( var_e687e17a26877b06 )
    {
        stop_on_ent_death( snd, self );
    }
    
    function_29dc2536738aac95( self, snd );
    thread function_d4210c236e193377( snd, notifystring );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x7db4b61c, Offset: 0x40ad
// Size: 0x6a
function private function_d4210c236e193377( snd, notifystring )
{
    if ( isdefined( notifystring ) )
    {
        self.scripteddialoguenotify = gettime();
    }
    else
    {
        self.scripteddialoguenonotify = gettime();
    }
    
    await( snd );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isstring( notifystring ) )
    {
        self notify( notifystring );
    }
    
    self.scripteddialoguenotify = undefined;
    self.scripteddialoguenonotify = undefined;
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0xa9eba1f9, Offset: 0x411f
// Size: 0xf6
function private function_218a734708b7b909( player, sound_emitter, alias )
{
    assert( isplayer( player ) );
    assert( isstruct( sound_emitter ) || isent( sound_emitter ) );
    assert( isstring( alias ) || isxhash( alias ) );
    context = "";
    
    if ( self.isradioemitter )
    {
        context = "dx_radio_3d";
    }
    else
    {
        if ( isdefined( level.var_1ccd80f236e572c7[ alias ] ) )
        {
            radio_dist = level.var_1ccd80f236e572c7[ alias ];
        }
        else
        {
            radio_dist = soundgetdistmax( alias ) * 0.25;
        }
        
        player_distsq = distancesquared( player geteye(), sound_emitter.origin );
        context = player_distsq < squared( radio_dist ) ? "dx_open_air" : "dx_radio_2d";
    }
    
    return context;
}

// Namespace snd
// Params 6, eflags: 0x4
// Checksum 0x55937606, Offset: 0x421e
// Size: 0x75
function private function_ff0ca0157e0ee15( sound_emitter, alias, contexttype, contextvalue, notification_string, var_868a4b7218755765 )
{
    sndobj = play( alias, sound_emitter );
    
    if ( isent( sndobj ) )
    {
        sndobj setentitysoundcontext( contexttype, contextvalue, 0 );
        stop_on_ent_notify( sndobj, self, "stop_dialogue", 0.05 );
    }
}

// Namespace snd
// Params 2
// Checksum 0xe2d42a13, Offset: 0x429b
// Size: 0x2c4
function function_ca90fc71e13e7136( curve, size )
{
    lut = [];
    step = 1 / ( size - 1 );
    
    for ( i = 0; i < size ; i++ )
    {
        x = i * step;
        y = 0;
        
        switch ( curve )
        {
            default:
                assert( 0 );
                break;
            case #"hash_28724bf44fcad5a":
            case #"hash_a07b7ad0ae57b120":
                lut[ 0 ] = 0;
                lut[ 1 ] = 1;
                return lut;
            case #"hash_d14c288a042b2358":
                y = 0.5 + cos( x * 180 ) * -0.5;
                break;
            case #"hash_e5b5c9bbaf55cda4":
                y = 1 - cos( x * 90 );
                break;
            case #"hash_c61d0274ec76f271":
                y = sin( x * 90 );
                break;
            case #"hash_6975a515a3376748":
                y = 3 * pow( x, 2 ) - 2 * pow( x, 3 );
                break;
            case #"hash_2e3e9521be134e7f":
                y = 1 - sqrt( 1 - x * x );
                break;
            case #"hash_9e33f1e4dcc4f04":
                y = sqrt( 1 - ( 1 - x ) * ( 1 - x ) );
                break;
            case #"hash_e004d61d10ac743f":
                lut[ 0 ] = 0;
                lut[ 1 ] = 0.0158489;
                lut[ 2 ] = 0.0251189;
                lut[ 3 ] = 0.0398107;
                lut[ 4 ] = 0.0630957;
                lut[ 5 ] = 0.1;
                lut[ 6 ] = 0.158489;
                lut[ 7 ] = 0.251189;
                lut[ 8 ] = 0.398107;
                lut[ 9 ] = 0.630957;
                lut[ 10 ] = 1;
                return lut;
            case #"hash_3906f2285eb98bad":
                lut[ 0 ] = 0;
                lut[ 1 ] = 1.97531e-05;
                lut[ 2 ] = 0.000316049;
                lut[ 3 ] = 0.0016;
                lut[ 4 ] = 0.00505679;
                lut[ 5 ] = 0.0123457;
                lut[ 6 ] = 0.0256;
                lut[ 7 ] = 0.0474272;
                lut[ 8 ] = 0.0809086;
                lut[ 9 ] = 0.1296;
                lut[ 10 ] = 0.197531;
                lut[ 11 ] = 0.289205;
                lut[ 12 ] = 0.4096;
                lut[ 13 ] = 0.564168;
                lut[ 14 ] = 0.758835;
                lut[ 15 ] = 1;
                return lut;
        }
        
        lut[ lut.size ] = y;
    }
    
    return lut;
}

// Namespace snd
// Params 1
// Checksum 0x432379c9, Offset: 0x4568
// Size: 0x1ca
function curve_init( size = 11 )
{
    assert( isstruct( level.snd ), "<dev string:x414>" );
    level.snd.curves = [];
    level.snd.curves[ "linear" ] = function_ca90fc71e13e7136( "linear", size );
    level.snd.curves[ "sine" ] = function_ca90fc71e13e7136( "sine", size );
    level.snd.curves[ "easein" ] = function_ca90fc71e13e7136( "easein", size );
    level.snd.curves[ "easeout" ] = function_ca90fc71e13e7136( "easeout", size );
    level.snd.curves[ "easeinout" ] = function_ca90fc71e13e7136( "easeinout", size );
    level.snd.curves[ "circularin" ] = function_ca90fc71e13e7136( "circularin", size );
    level.snd.curves[ "circularout" ] = function_ca90fc71e13e7136( "circularout", size );
    level.snd.curves[ "exponential_40db" ] = function_ca90fc71e13e7136( "exponential_40db", size );
    level.snd.curves[ "exponential_60db" ] = function_ca90fc71e13e7136( "exponential_60db", size );
    level.snd.curves[ "default_vfcurve" ] = function_ca90fc71e13e7136( "default_vfcurve", size );
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x8de7a400, Offset: 0x473a
// Size: 0x37
function private function_e2caf039a46aa773( alias )
{
    if ( !isdefined( alias ) )
    {
        return "easeout";
    }
    
    switch ( alias )
    {
        case #"hash_e72a3996c47e1ac9":
            return "easeout";
    }
    
    return alias;
}

// Namespace snd
// Params 1
// Checksum 0x2adb76d6, Offset: 0x477a
// Size: 0x3f
function curve_size( curve )
{
    lut = level.snd.curves[ function_e2caf039a46aa773( curve ) ];
    
    if ( isdefined( lut ) )
    {
        return lut.size;
    }
    
    return 0;
}

// Namespace snd
// Params 1
// Checksum 0x586440b, Offset: 0x47c2
// Size: 0x38, Type: bool
function curve_exists( curve )
{
    lut = level.snd.curves[ curve ];
    
    if ( isdefined( lut ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 2
// Checksum 0xae140022, Offset: 0x4803
// Size: 0x159
function curve_value( inval, curve )
{
    curve = function_e2caf039a46aa773( curve );
    lut = level.snd.curves[ curve ];
    assert( isdefined( lut ), "<dev string:x42d>" + curve );
    inval = clamp( inval, 0, 1 );
    outval = 0;
    step = 1 / ( lut.size - 1 );
    
    if ( inval == 0 )
    {
        return 0;
    }
    
    if ( inval == 1 )
    {
        return 1;
    }
    
    for ( i = 0; i < lut.size ; i++ )
    {
        stepx = i * step;
        stepn = ( i + 1 ) * step;
        
        if ( inval >= stepx && inval <= stepn )
        {
            diffx = inval - stepx;
            diffn = stepn - stepx;
            diff = diffx / diffn;
            valx = lut[ i ];
            valn = lut[ i + 1 ];
            valdiff = valn - valx;
            outval = valx + valdiff * diff;
            break;
        }
    }
    
    return outval;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xe3e54cd6, Offset: 0x4965
// Size: 0x239
function private _param_delete( name )
{
    if ( isdefined( self.snd.params ) == 0 )
    {
        return;
    }
    
    if ( isdefined( name ) )
    {
        if ( isdefined( self.snd.params[ name ] ) )
        {
            if ( isdefined( self.snd.params[ name ].stopcallback ) )
            {
                self [[ self.snd.params[ name ].stopcallback ]]( self.snd.params[ name ].userdata );
            }
            
            self.snd.params[ name ] = undefined;
        }
    }
    else
    {
        foreach ( p in self.snd.params )
        {
            if ( isdefined( p.stopcallback ) )
            {
                self [[ p.stopcallback ]]( p.userdata );
            }
            
            self.snd.params = undefined;
        }
    }
    
    if ( isdefined( self.snd.params ) == 0 || self.snd.params.size == 0 )
    {
        level.snd.param_ents = arrayremove( level.snd.param_ents, self );
        level.snd.param_ents = function_5713d46873b29625( level.snd.param_ents );
        self.snd.params = undefined;
        self.snd.paramthread = undefined;
        self notify( #"param_stop" );
    }
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0xdee43e1, Offset: 0x4ba6
// Size: 0x26
function private _param_monitor_death()
{
    self endon( #"param_stop" );
    utility::waittill_any( "death", "disconnect" );
    _param_delete();
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x8d40f31f, Offset: 0x4bd4
// Size: 0x7c
function private _param_main()
{
    if ( isdefined( self.snd.paramthread ) )
    {
        return;
    }
    
    InvalidOpCode( 0x7 );
    // Unknown operator ( 0x7, t11, Black Ops 7 )
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x85991cd4, Offset: 0x4e75
// Size: 0x136
function private _param_init( name )
{
    if ( isdefined( level.snd.param_ents ) == 0 )
    {
        level.snd.param_ents = [];
    }
    
    assert( isarray( level.snd.param_ents ), "<dev string:x506>" );
    init_obj( self );
    
    if ( isdefined( self.snd.params ) == 0 )
    {
        self.snd.params = [];
    }
    
    assert( isarray( self.snd.params ), "<dev string:x52a>" );
    
    if ( isdefined( self.snd.params[ name ] ) == 0 )
    {
        self.snd.params[ name ] = spawnstruct();
    }
    
    if ( arraycontains( level.snd.param_ents, self ) == 0 )
    {
        level.snd.param_ents[ level.snd.param_ents.size ] = self;
    }
}

// Namespace snd
// Params 2
// Checksum 0xc5cc623b, Offset: 0x4fb3
// Size: 0x67
function param_input( name, inputcallback )
{
    _param_init( name );
    self.snd.params[ name ].inputcallback = inputcallback;
    self.snd.params[ name ].inputvalue = undefined;
    thread _param_main();
}

// Namespace snd
// Params 3
// Checksum 0x3fc1c667, Offset: 0x5022
// Size: 0x224
function param_output( name, outputcallback, userdata )
{
    _param_init( name );
    
    if ( isdefined( self.snd.params[ name ].outputcallbacks ) == 0 )
    {
        self.snd.params[ name ].outputcallbacks = [];
    }
    
    assert( isdefined( self.snd.params[ name ] ), "<dev string:x54f>" + name + "<dev string:x562>" );
    assert( isdefined( self.snd.params[ name ].outputcallbacks ), "<dev string:x52a>" );
    assert( isarray( self.snd.params[ name ].outputcallbacks ), "<dev string:x52a>" );
    outputcallbackindex = self.snd.params[ name ].outputcallbacks.size;
    self.snd.params[ name ].outputcallbacks[ outputcallbackindex ] = outputcallback;
    
    if ( isdefined( self.snd.params[ name ].userdata ) == 0 )
    {
        self.snd.params[ name ].userdata = [];
    }
    
    if ( arraycontains( self.snd.params[ name ].userdata, userdata ) == 0 )
    {
        userdataindex = self.snd.params[ name ].userdata.size;
        self.snd.params[ name ].userdata[ userdataindex ] = userdata;
    }
    else
    {
        /#
            if ( function_5584988e43b61242() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
    }
    
    thread _param_main();
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0xe694818e, Offset: 0x524e
// Size: 0xb3
function private _param_start( name, startcallback, stopcallback )
{
    _param_init( name );
    self.snd.params[ name ].startcallback = startcallback;
    self.snd.params[ name ].stopcallback = stopcallback;
    
    if ( isdefined( self.snd.params[ name ].startcallback ) )
    {
        self [[ self.snd.params[ name ].startcallback ]]();
    }
}

// Namespace snd
// Params 1
// Checksum 0xecb5d46e, Offset: 0x5309
// Size: 0x15
function param_stop( name )
{
    _param_delete( name );
}

// Namespace snd
// Params 6
// Checksum 0xf660532d, Offset: 0x5326
// Size: 0x59
function param( name, startcallback, inputcallback, outputcallback, stopcallback, userdata )
{
    _param_start( name, startcallback, stopcallback );
    param_input( name, inputcallback );
    param_output( name, outputcallback, userdata );
}

// Namespace snd
// Params 1
// Checksum 0xf27319f4, Offset: 0x5387
// Size: 0xa4
function function_5496372e3cbf2c01( name )
{
    if ( isdefined( self.snd.params[ name ] ) && isdefined( self.snd.params[ name ].inputcallback ) )
    {
        p = self.snd.params[ name ];
        
        if ( isdefined( p.inputvalue ) )
        {
            return p.inputvalue;
        }
        
        return self [[ p.inputcallback ]]( p.userdata );
    }
}

// Namespace snd
// Params 1
// Checksum 0x5ced38f6, Offset: 0x5434
// Size: 0x45, Type: bool
function param_exists( name )
{
    if ( isarray( self.snd.params ) && isdefined( self.snd.params[ name ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x94402207, Offset: 0x5482
// Size: 0xb5, Type: bool
function function_d3b50fcb5bba7a17( inputcallback )
{
    if ( isarray( self.snd.params ) )
    {
        foreach ( p in self.snd.params )
        {
            if ( p.inputcallback == inputcallback )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x6eac3ab9, Offset: 0x5540
// Size: 0xc8
function private function_25a3081183fe996d( userdata )
{
    assert( isdefined( self.origin ) );
    now = gettime();
    
    if ( self.origin_velocity_time == now )
    {
        assert( isdefined( self.origin_velocity ) );
        return self.origin_velocity;
    }
    
    if ( isdefined( self.origin_last ) == 0 )
    {
        self.origin_last = self.origin;
    }
    
    delta = self.origin - self.origin_last;
    self.origin_velocity = delta;
    self.origin_velocity_time = now;
    self.origin_last = self.origin;
    return self.origin_velocity;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x8044125c, Offset: 0x5611
// Size: 0x23a
function private function_bf2277d46ce708bd( userdata )
{
    assert( isdefined( self.origin ) );
    assert( isdefined( self.snd ) );
    assert( isdefined( self.snd.origin_speed ) );
    velocity = function_25a3081183fe996d();
    speed = length( velocity );
    self.snd.origin_speed = smoothvalue( speed, self.snd.origin_speed, 0.05 );
    
    /#
        if ( function_542b9fda0c23d8f4() >= 2 )
        {
            debugspeed = self.snd.origin_speed;
            
            if ( debugspeed < 0.001 )
            {
                debugspeed = 0;
            }
            
            debugspeedtext = printdecimalcount( debugspeed * function_5a6197a8525d2d60() * 0.0568182, 1 ) + "<dev string:x57e>" + printdecimalcount( debugspeed, 1 ) + "<dev string:x586>";
            debugcolor = level.snd.debug.color_3d;
            debugalpha = 0.9;
            debugalphasq = debugalpha * debugalpha;
            debugscale = level.snd.debug.scale_3d;
            colorscale = level.snd.debug.color_scale;
            debugcolor = function_69dc1ffd54edd65c( debugcolor, colorscale * 10 );
            debugframes = 1;
            debugoffset = ( 0, 0, 4 * debugscale * 16 );
            print3dplus( debugspeedtext, self.origin + debugoffset, -1 * debugscale, "<dev string:x58b>", debugcolor, debugalpha, ( 0, 0, 0 ), debugalphasq, ( 1, 1, 1 ), debugalphasq, debugframes );
        }
    #/
    
    return self.snd.origin_speed;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x445aeed3, Offset: 0x5854
// Size: 0x1d3
function private function_20da768c35d48112( userdata )
{
    assert( isdefined( self.angles ) );
    now = gettime();
    
    if ( self.angle_time == now )
    {
        assert( isdefined( self.snd.angles ) );
        return self.snd.angles;
    }
    
    angles = self.angles;
    
    if ( isplayersafe( self ) )
    {
        angles = getplayerviewangles();
    }
    else if ( isdefined( self.model ) )
    {
        hastag = modelhastag( self.model, userdata[ 0 ] );
        
        if ( isarray( userdata ) && isstring( userdata[ 0 ] ) )
        {
            tag = userdata[ 0 ];
            tagindex = self gettagindex( tag );
            
            if ( tagindex >= 0 )
            {
                angles = self gettagangles( tag );
                
                if ( isdefined( angles ) )
                {
                    hastag = 1;
                }
            }
        }
        
        if ( hastag == 0 )
        {
            angles = self gettagangles( "tag_origin" );
        }
    }
    
    angles = function_bfe0872937d87e72( angles );
    
    if ( isdefined( self.snd.angles ) == 0 )
    {
        self.snd.angles = angles;
    }
    
    if ( isdefined( self.snd.angles_last ) == 0 )
    {
        self.snd.angles_last = angles;
    }
    
    self.snd.angles_last = self.snd.angles;
    self.snd.angles = angles;
    return self.snd.angles;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xf7945563, Offset: 0x5a30
// Size: 0x5d
function private function_e6c14d2fb7f09621( userdata )
{
    angles = function_20da768c35d48112( userdata );
    self.snd.angle_velocity = angles - self.snd.angles_last;
    return self.snd.angle_velocity;
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x2c14ee96, Offset: 0x5a96
// Size: 0x78
function private _speed_start_ent( speedlayer, initialvolume, initialpitch )
{
    speedlayer.snd = play( speedlayer.soundalias, speedlayer.target );
    set_volume( speedlayer.snd, initialvolume, 0 );
    set_pitch( speedlayer.snd, initialpitch, 0 );
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x5d2be6f3, Offset: 0x5b16
// Size: 0x90
function private _speed_stop_ent( speedlayer, fadetime, fadecurve )
{
    if ( isdefined( speedlayer ) && isdefined( speedlayer.snd ) )
    {
        if ( !isdefined( fadetime ) )
        {
            fadetime = 0;
        }
        
        if ( !isdefined( fadecurve ) )
        {
            fadecurve = "easeinout";
        }
        
        if ( fadetime > 0 )
        {
            set_volume( speedlayer.snd, 0, fadetime, fadecurve );
            wait fadetime;
        }
        
        stop( speedlayer.snd );
        speedlayer.snd = undefined;
    }
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x5436e45e, Offset: 0x5bae
// Size: 0x2d7
function private _param_output_speed( inputvalue, userdata )
{
    speed = inputvalue;
    v = userdata;
    
    if ( speed < 0.01 )
    {
        speed = 0;
    }
    
    volumespeedmin = v.volumedict[ "speed" ][ 0 ];
    volumespeedmax = v.volumedict[ "speed" ][ 1 ];
    volumescalemin = v.volumedict[ "scale" ][ 0 ];
    volumescalemax = v.volumedict[ "scale" ][ 1 ];
    volumecurve = v.volumedict[ "curve" ][ 0 ];
    pitchspeedmin = v.pitchdict[ "speed" ][ 0 ];
    pitchspeedmax = v.pitchdict[ "speed" ][ 1 ];
    pitchscalemin = v.pitchdict[ "scale" ][ 0 ];
    pitchscalemax = v.pitchdict[ "scale" ][ 1 ];
    pitchcurve = v.pitchdict[ "curve" ][ 0 ];
    volume = scalerp( speed, volumespeedmin, volumespeedmax, volumescalemin, volumescalemax );
    pitch = scalerp( speed, pitchspeedmin, pitchspeedmax, pitchscalemin, pitchscalemax );
    
    if ( isdefined( self.snd.doppler ) && isdefined( self.snd.doppler.value ) )
    {
        pitch *= self.snd.doppler.value;
    }
    
    if ( isdefined( v.snd ) && volume <= 0.001 )
    {
        thread _speed_stop_ent( v );
        return;
    }
    else if ( isdefined( v.snd ) == 0 && volume > 0.001 )
    {
        _speed_start_ent( v, volume, pitch );
        v.speed_last = speed;
        return;
    }
    
    if ( isdefined( v.snd ) && isdefined( v.speed_last ) )
    {
        speed_delta = abs( speed - v.speed_last );
        
        if ( speed_delta > 0.01 )
        {
            set_volume( v.snd, volume, 0.05, volumecurve );
            set_pitch( v.snd, pitch, 0.05, pitchcurve );
            v.speed_last = speed;
        }
    }
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xccd76b15, Offset: 0x5e8d
// Size: 0x10c
function private _param_stop_speed( userdata )
{
    fadeout = self.snd.speedsfadeout;
    fadeoutcurve = self.snd.speedsfadeoutcurve;
    
    if ( isdefined( userdata ) )
    {
        foreach ( v in userdata )
        {
            thread _speed_stop_ent( v, fadeout, fadeoutcurve );
        }
    }
    
    self.snd.var_ffdbcb3ea3147f4a = undefined;
    self.snd.speedsfadeout = undefined;
    self.snd.speedsfadeoutcurve = undefined;
    self.snd.speeds = undefined;
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x13413d36, Offset: 0x5fa1
// Size: 0x23f
function private _speed_main( target, soundalias, pitchdict, volumedict )
{
    ent = undefined;
    islooping = soundislooping( soundalias );
    
    if ( !isarray( target ) )
    {
        ent = target;
    }
    else if ( target.size > 0 )
    {
        ent = target[ 0 ];
    }
    
    if ( condition_alert( !isent( ent ), "snd::speed: target entity not found!" ) )
    {
        return;
    }
    
    if ( condition_alert( !isdefined( islooping ), "snd::speed: alias '" + soundalias + "' does not exist!" ) )
    {
        return;
    }
    
    if ( condition_alert( !islooping, "snd::speed: alias '" + soundalias + "' is not looping!" ) )
    {
        return;
    }
    
    if ( condition_alert( !isarray( pitchdict ), "snd::speed: pitchDict is not an array!" ) )
    {
        return;
    }
    
    if ( condition_alert( !isarray( volumedict ), "snd::speed: volumeDict is not an array!" ) )
    {
        return;
    }
    
    init_obj( ent );
    assert( isstruct( ent.snd ), "<dev string:x592>" );
    speedlayer = spawnstruct();
    speedlayer.soundalias = soundalias;
    speedlayer.target = target;
    speedlayer.pitchdict = pitchdict;
    speedlayer.volumedict = volumedict;
    
    if ( !isdefined( speedlayer.pitchdict[ "curve" ] ) )
    {
        speedlayer.pitchdict[ "curve" ] = [ "linear" ];
    }
    
    if ( !isdefined( speedlayer.volumedict[ "curve" ] ) )
    {
        speedlayer.volumedict[ "curve" ] = [ "xfade" ];
    }
    
    if ( !isdefined( ent.snd.speeds ) )
    {
        ent.snd.speeds = [];
    }
    
    ent.snd.speeds[ ent.snd.speeds.size ] = speedlayer;
    ent.snd.origin_speed = 0;
    ent param( "speed", undefined, &function_bf2277d46ce708bd, &_param_output_speed, &_param_stop_speed, speedlayer );
}

// Namespace snd
// Params 3
// Checksum 0x938770df, Offset: 0x61e8
// Size: 0xcd
function speed_stop( target, fadeout = 0.05, fadeoutcurve = "easeinout" )
{
    ent = undefined;
    
    if ( !isarray( target ) )
    {
        ent = target;
    }
    else if ( target.size > 0 )
    {
        ent = target[ 0 ];
    }
    
    if ( condition_alert( !isent( ent ), "snd::speed: target entity not found!" ) )
    {
        return;
    }
    
    ent.snd.var_ffdbcb3ea3147f4a = 1;
    ent.snd.speedsfadeout = fadeout;
    ent.snd.speedsfadeoutcurve = fadeoutcurve;
    ent param_stop( "speed" );
}

// Namespace snd
// Params 4
// Checksum 0x4b8dfc12, Offset: 0x62bd
// Size: 0x35
function speed( target, alias, pitchdict, volumedict )
{
    level thread _speed_main( target, alias, pitchdict, volumedict );
}

// Namespace snd
// Params 7
// Checksum 0xa1a7a2a, Offset: 0x62fa
// Size: 0x1d8
function doppler_scale( src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale, var_72fc5fa75644aeb3 )
{
    assert( isvector( src_origin ) );
    assert( isvector( src_velocity ) );
    assert( isvector( dst_origin ) );
    assert( isvector( dst_velocity ) );
    
    if ( !isdefined( src_scale ) )
    {
        src_scale = 1;
    }
    
    if ( !isdefined( dst_scale ) )
    {
        dst_scale = 1;
    }
    
    if ( !isdefined( var_72fc5fa75644aeb3 ) )
    {
        var_72fc5fa75644aeb3 = 343.3;
    }
    
    if ( src_scale == 0 && dst_scale == 0 || var_72fc5fa75644aeb3 == 0 )
    {
        return [ 0, 0, 0 ];
    }
    
    var_c7e492eca7843533 = 39.3701 * var_72fc5fa75644aeb3;
    assert( isnumber( src_scale ) );
    assert( isnumber( dst_scale ) );
    assert( isnumber( var_c7e492eca7843533 ) );
    delta_origin = src_origin - dst_origin;
    len = length( delta_origin );
    src_velocity_scalar = 0;
    dst_velocity_scalar = 0;
    
    if ( src_scale > 0 && src_velocity != ( 0, 0, 0 ) )
    {
        src_velocity_scalar = vectordot( src_velocity, delta_origin ) / len;
        src_velocity_scalar *= src_scale;
    }
    
    if ( dst_scale > 0 && dst_velocity != ( 0, 0, 0 ) )
    {
        dst_velocity_scalar = vectordot( dst_velocity, delta_origin ) / len;
        dst_velocity_scalar *= dst_scale;
    }
    
    dopplerscale = ( var_c7e492eca7843533 - src_velocity_scalar ) / ( var_c7e492eca7843533 - dst_velocity_scalar );
    return [ dopplerscale, src_velocity_scalar, dst_velocity_scalar ];
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0xa2e0d1d2, Offset: 0x64db
// Size: 0x2
function private function_d83adb7bdec96b1c()
{
    
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xb1bcb487, Offset: 0x64e5
// Size: 0x15b
function private _param_stop_doppler( userdata )
{
    var_58105ef154268f1b = arraycopy( level.snd.param_ents );
    dopplercount = 0;
    dopplerplayers = [];
    var_58105ef154268f1b = arrayremove( var_58105ef154268f1b, self );
    
    foreach ( var_eb61270efab1670a in var_58105ef154268f1b )
    {
        if ( var_eb61270efab1670a param_exists( "doppler" ) )
        {
            dopplercount += 1;
            
            if ( isplayersafe( var_eb61270efab1670a ) )
            {
                dopplerplayers[ dopplerplayers.size ] = var_eb61270efab1670a;
            }
        }
    }
    
    if ( dopplercount == dopplerplayers.size )
    {
        foreach ( player in dopplerplayers )
        {
            player param_stop( "doppler" );
        }
    }
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x82ad7668, Offset: 0x6648
// Size: 0x44c
function private _param_output_doppler( inputvalue, userdata )
{
    player = userdata;
    
    if ( !isplayersafe( player ) )
    {
        return;
    }
    
    assert( isdefined( player ) );
    assert( isdefined( self ) );
    assert( isdefined( self.snd ) );
    assert( isdefined( self.snd.doppler ) );
    assert( isdefined( self.snd.doppler.scale ) );
    assert( isdefined( self.snd.doppler.playerscale ) );
    src_origin = self.origin;
    src_velocity = inputvalue;
    src_scale = self.snd.doppler.scale;
    dst_origin = player getplayervieworigin();
    dst_velocity = player function_5496372e3cbf2c01( "doppler" );
    dst_scale = self.snd.doppler.playerscale;
    
    if ( isdefined( dst_velocity ) == 0 || self.snd.doppler.playerscale == 0 )
    {
        dst_velocity = ( 0, 0, 0 );
    }
    
    assert( isvector( src_origin ) );
    assert( isvector( src_velocity ) );
    assert( isnumber( src_scale ) );
    assert( isvector( dst_origin ) );
    assert( isvector( dst_velocity ) );
    assert( isnumber( dst_scale ) );
    dopplervalues = doppler_scale( src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale );
    dopplerscale = dopplervalues[ 0 ];
    
    if ( isdefined( self.snd.doppler.pitchscale ) )
    {
        dopplerscale *= self.snd.doppler.pitchscale;
    }
    
    dopplerscale = clamp( dopplerscale, 0.01, 2 );
    self.snd.doppler.value = dopplerscale;
    
    if ( is_sound_object( self ) )
    {
        set_pitch( self, dopplerscale, function_76f9a4325afecc73() );
    }
    
    /#
        if ( function_542b9fda0c23d8f4() > 1 )
        {
            debugscale = level.snd.debug.scale_3d;
            audiocolor = level.snd.debug.color_3d;
            colorscale = level.snd.debug.color_scale;
            selectioncolor = function_69dc1ffd54edd65c( audiocolor, colorscale * 10 );
            var_5641f9275cb9e387 = dopplervalues[ 1 ];
            dist = distance( src_origin, dst_origin );
            fixeddistscalar = dist * 0.002;
            scale = debugscale * 0.666 * fixeddistscalar;
            alpha = 1;
            alphasq = alpha * alpha;
            var_fb9f3d8a1bc4572 = "<dev string:x5b3>";
            var_67ac153c3123bc6f = dopplerscale + "<dev string:x5bd>" + var_5641f9275cb9e387;
            print3dplus( var_fb9f3d8a1bc4572, src_origin + ( 0, 0, -1 * scale * 16 ), scale, "<dev string:x5c1>", selectioncolor, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
            print3dplus( var_67ac153c3123bc6f, src_origin + ( 0, 0, -1 * scale * 16 ), scale, "<dev string:x5c7>", selectioncolor, alpha, ( 0, 0, 0 ), alphasq, ( 1, 1, 1 ), alphasq, 1 );
        }
    #/
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x470fadda, Offset: 0x6a9c
// Size: 0x12e
function private _doppler_main( player, dopplerscale, pitchscale, playervelocityscale )
{
    assert( isplayersafe( player ) );
    
    if ( !isdefined( dopplerscale ) )
    {
        dopplerscale = 1;
    }
    
    if ( !isdefined( pitchscale ) )
    {
        pitchscale = 1;
    }
    
    if ( !isdefined( playervelocityscale ) )
    {
        playervelocityscale = 1;
    }
    
    assert( isdefined( player ) );
    
    if ( playervelocityscale > 0 )
    {
        player param( "doppler", undefined, &function_25a3081183fe996d );
    }
    
    if ( is_object_invalid( self ) )
    {
        return;
    }
    
    init_obj( self );
    self.snd.doppler = spawnstruct();
    self.snd.doppler.scale = dopplerscale;
    self.snd.doppler.pitchscale = pitchscale;
    self.snd.doppler.playerscale = playervelocityscale;
    param( "doppler", undefined, &function_25a3081183fe996d, &_param_output_doppler, &_param_stop_doppler, player );
}

// Namespace snd
// Params 5
// Checksum 0x578e677, Offset: 0x6bd2
// Size: 0xc1
function doppler( soundobject, player, dopplerscale, pitchscale, playervelocityscale )
{
    if ( condition_alert( isdefined( soundobject ) == 0, "snd::doppler with undefined soundObject" ) )
    {
        return;
    }
    
    foreach ( soundobj in makearray( soundobject ) )
    {
        soundobj thread _doppler_main( player, dopplerscale, pitchscale, playervelocityscale );
    }
}

// Namespace snd
// Params 1
// Checksum 0x174462e2, Offset: 0x6c9b
// Size: 0x98
function doppler_stop( soundobject )
{
    if ( condition_alert( isdefined( soundobject ) == 0, "snd::doppler_stop with undefined soundObject" ) )
    {
        return;
    }
    
    foreach ( soundobj in makearray( soundobject ) )
    {
        soundobj _param_stop_doppler();
    }
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x722f221c, Offset: 0x6d3b
// Size: 0x100
function private _start_main( callback, allowretrigger )
{
    level notify( #"hash_577b8a1319d04f26" );
    level endon( #"hash_577b8a1319d04f26" );
    
    if ( !isdefined( allowretrigger ) )
    {
        allowretrigger = 1;
    }
    
    assert( isstruct( level.snd ), "<dev string:x414>" );
    assert( isscriptfunction( callback ) );
    assert( isdefined( allowretrigger ) );
    utility::flag_wait( "start_is_set" );
    start_points = [];
    start_point = function_7fde87582259c071();
    
    while ( true )
    {
        level waittill( #"start_logic", start_point );
        level.snd.start_point = start_point;
        waittillframeend();
        
        if ( !isstring( start_point ) || start_point == "" )
        {
            continue;
        }
        
        if ( allowretrigger || !allowretrigger && !isdefined( start_points[ start_point ] ) )
        {
            level thread [[ callback ]]( start_point );
            start_points[ start_point ] = 1;
        }
    }
}

// Namespace snd
// Params 2
// Checksum 0xc56f747f, Offset: 0x6e43
// Size: 0x20
function start_init( callback, allowretrigger )
{
    level thread _start_main( callback, allowretrigger );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0xcdb14d03, Offset: 0x6e6b
// Size: 0x86
function private function_ebd6d7d2e41469de( trigger, player )
{
    if ( !isplayersafe( player ) )
    {
        return;
    }
    
    is_touching = 0;
    
    if ( isent( trigger ) )
    {
        is_touching = player istouching( trigger );
    }
    else if ( trigger == level )
    {
        if ( !isdefined( player.snd.trigger ) || player.snd.trigger == level )
        {
            is_touching = 1;
        }
    }
    
    return is_touching;
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0xed59322d, Offset: 0x6efa
// Size: 0x86
function private function_204f07c99fa8429f()
{
    waitforplayers();
    waitframe();
    waittillframeend();
    
    foreach ( player in getplayerssafe() )
    {
        level notify( #"trigger", player );
    }
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x50078012, Offset: 0x6f88
// Size: 0x414
function private _trigger_main( callback )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    triggers_default = [ level ];
    trigger = self;
    assert( isdefined( trigger ) );
    
    while ( true )
    {
        player = undefined;
        trigger waittill( #"trigger", player );
        is_touching = function_ebd6d7d2e41469de( trigger, player );
        init_obj( player );
        assert( isstruct( player.snd ), "<dev string:x5cd>" );
        
        if ( is_touching )
        {
            if ( !isdefined( player.snd.triggers ) )
            {
                player.snd.triggers = triggers_default;
            }
            
            assert( isarray( player.snd.triggers ) && isdefined( player.snd.triggers[ 0 ] ) && player.snd.triggers[ 0 ] == level );
            
            if ( trigger != level )
            {
                player.snd.triggers[ player.snd.triggers.size ] = trigger;
            }
            
            haspriority = isdefined( player.snd.trigger.script_ambientpriority ) && isdefined( trigger.script_ambientpriority );
            hashigherpriority = haspriority && int( player.snd.trigger.script_ambientpriority ) <= int( trigger.script_ambientpriority );
            
            if ( !isdefined( player.snd.trigger ) || haspriority && hashigherpriority || !haspriority )
            {
                player.snd.trigger = trigger;
                trigger thread [[ callback ]]( player, trigger, 1 );
            }
            
            while ( is_touching )
            {
                is_touching = function_ebd6d7d2e41469de( trigger, player );
                waitframe();
            }
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( trigger != level )
            {
                player.snd.triggers = arrayremove( player.snd.triggers, trigger );
            }
            
            if ( player.snd.trigger == trigger )
            {
                next_trigger = undefined;
                
                if ( haspriority )
                {
                    next_trigger = level;
                    next_trigger_priority = -1;
                    
                    for ( i = player.snd.triggers.size - 1; i > 0 ; i-- )
                    {
                        other_trigger = player.snd.triggers[ i ];
                        
                        if ( isdefined( other_trigger.script_ambientpriority ) )
                        {
                            other_trigger_priority = int( other_trigger.script_ambientpriority );
                            
                            if ( other_trigger_priority > next_trigger_priority )
                            {
                                next_trigger = other_trigger;
                                next_trigger_priority = other_trigger_priority;
                            }
                        }
                    }
                }
                else
                {
                    assert( player.snd.triggers.size > 0 );
                    index = player.snd.triggers.size - 1;
                    assert( index >= 0 );
                    next_trigger = player.snd.triggers[ index ];
                }
                
                if ( isdefined( next_trigger ) )
                {
                    player.snd.trigger = next_trigger;
                    next_trigger thread [[ callback ]]( player, next_trigger, 0 );
                    continue;
                }
                
                player.snd.trigger = undefined;
                level notify( #"trigger", player );
            }
        }
    }
}

// Namespace snd
// Params 3
// Checksum 0xed569fe, Offset: 0x73a4
// Size: 0x126
function trigger_init( callback, name = "ambient_package", key = "targetname" )
{
    triggers = [ level ];
    found_triggers = undefined;
    
    if ( level.snd.is_server_script )
    {
        found_triggers = getentarray( name, key );
    }
    else if ( level.snd.is_client_script )
    {
        found_triggers = getentarray( 0, name, key );
    }
    
    if ( isarray( found_triggers ) )
    {
        triggers = arraycombine( triggers, found_triggers );
    }
    
    foreach ( trigger in makearray( triggers ) )
    {
        trigger thread _trigger_main( callback );
    }
    
    level thread function_204f07c99fa8429f();
}

// Namespace snd
// Params 2
// Checksum 0x33487aff, Offset: 0x74d2
// Size: 0x11e
function element_init( name, elements )
{
    assert( did_init() );
    isnamestring = isstring( name );
    var_3908a1eac713b61c = isarray( elements ) && elements.size > 0 && isarray( elements[ 0 ] );
    issingleelement = isarray( elements ) && elements.size >= 3 && isstring( elements[ 0 ] );
    iselementstring = isstring( elements );
    var_d0621741bf238dd8 = isnamestring && ( var_3908a1eac713b61c || issingleelement || iselementstring );
    
    if ( condition_alert( !var_d0621741bf238dd8, "snd: element_init invalid" ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
    }
    
    if ( iselementstring && !isdefined( level.snd.elements[ elements ] ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
    }
    
    if ( issingleelement )
    {
        elements = [ elements ];
    }
    
    level.snd.elements[ name ] = elements;
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0x981cef34, Offset: 0x75f8
// Size: 0xbd
function private _remap_element( element )
{
    assert( isstruct( level.snd ), "<dev string:x414>" );
    
    if ( isarray( level.snd.elements ) && isstring( element ) )
    {
        levelelements = level.snd.elements[ element ];
        var_b376659e3bd72596 = isarray( levelelements );
        var_6792287d24a74e28 = isstring( levelelements );
        
        if ( var_b376659e3bd72596 )
        {
            return element;
        }
        
        if ( var_6792287d24a74e28 && isarray( level.snd.elements[ levelelements ] ) )
        {
            return levelelements;
        }
    }
}

// Namespace snd
// Params 1, eflags: 0x4
// Checksum 0xf2dd8f2e, Offset: 0x76be
// Size: 0x9d
function private _get_elements( element )
{
    assert( isstruct( level.snd ), "<dev string:x414>" );
    
    if ( isarray( element ) )
    {
        return element;
    }
    
    if ( isarray( level.snd.elements ) && isstring( element ) )
    {
        element = _remap_element( element );
        levelelements = level.snd.elements[ element ];
        var_43fe43193bf44eff = isarray( levelelements );
        
        if ( var_43fe43193bf44eff )
        {
            return levelelements;
        }
    }
}

// Namespace snd
// Params 2
// Checksum 0x37d8b6d9, Offset: 0x7764
// Size: 0x33d
function set_element( player, element )
{
    isplayervalid = isplayersafe( player );
    
    if ( condition_alert( !isplayervalid, "snd: set_element invalid player" ) )
    {
        return;
    }
    
    init_obj( player );
    var_43fe43193bf44eff = isarray( element );
    iselementstring = isstring( element );
    var_2a311bbdce5dc407 = !isdefined( element );
    var_d0621741bf238dd8 = var_43fe43193bf44eff || iselementstring || var_2a311bbdce5dc407;
    
    if ( condition_alert( !var_d0621741bf238dd8, "snd: set_element invalid element" ) )
    {
        return;
    }
    
    if ( var_43fe43193bf44eff )
    {
        player.snd.element = "**** custom ****";
    }
    else if ( iselementstring )
    {
        current = _remap_element( player.snd.element );
        remapped = _remap_element( element );
        isequal = isstring( current ) && isstring( remapped ) && current == remapped;
        player.snd.element = element;
        
        if ( isequal )
        {
            return;
        }
    }
    
    if ( isplayervalid && isarray( player.snd.emitters ) )
    {
        stop( player.snd.emitters );
        player.snd.emitters = undefined;
    }
    
    if ( var_2a311bbdce5dc407 )
    {
        player.snd.element = undefined;
        return;
    }
    
    elements = _get_elements( element );
    var_3908a1eac713b61c = isarray( elements );
    
    if ( condition_alert( !var_3908a1eac713b61c, "snd: set_element '" + player.snd.element + "' undefined" ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
        
        return;
    }
    
    assert( isplayervalid );
    assert( var_3908a1eac713b61c );
    player.snd.emitters = [];
    
    foreach ( e in elements )
    {
        alias = e[ 0 ];
        target = e[ 1 ] ?? player;
        spawntime = e[ 2 ];
        distancerange = e[ 3 ];
        rotation = e[ 4 ];
        elevation = e[ 5 ];
        emt = emitter( alias, target, spawntime, distancerange, rotation, elevation );
        
        if ( isdefined( emt ) )
        {
            player.snd.emitters[ player.snd.emitters.size ] = emt;
        }
    }
}

// Namespace snd
// Params 4, eflags: 0x4
// Checksum 0x61b105d4, Offset: 0x7aa9
// Size: 0x1fb
function private _line_attach_for_player( soundobject, player, org_start, org_end )
{
    assert( is_sound_object( soundobject ) );
    assert( isplayersafe( player ) );
    assert( isvector( org_start ) );
    assert( isvector( org_end ) );
    soundobject endon( #"death" );
    soundobject notify( #"snd_line_detach" );
    soundobject endon( #"snd_line_detach" );
    
    while ( isplayersafe( player ) && is_sound_object( soundobject ) )
    {
        org_player = player getplayervieworigin();
        org = pointonsegmentnearesttopoint( org_start, org_end, org_player );
        soundobject.origin = org;
        
        /#
            if ( function_542b9fda0c23d8f4() > 1 )
            {
                line_size = 24;
                depth_test = 0;
                color_line = ( 0.97254, 0.72974, 0.72974 );
                color_rt = ( 0.72974, 0.97254, 0.72974 );
                color_up = ( 0.72974, 0.72974, 0.97254 );
                line( org_start, org_end, color_line, 1, depth_test, 1 );
                line_angles = vectortoangles( org_end - org_start );
                line_rt = anglestoright( line_angles );
                line_up = anglestoup( line_angles );
                line( org_start - line_rt * line_size, org_start + line_rt * line_size, color_rt, 1, depth_test, 1 );
                line( org_start - line_up * line_size, org_start + line_up * line_size, color_up, 1, depth_test, 1 );
                line( org_end - line_rt * line_size, org_end + line_rt * line_size, color_rt, 1, depth_test, 1 );
                line( org_end - line_up * line_size, org_end + line_up * line_size, color_up, 1, depth_test, 1 );
            }
        #/
        
        waitframe();
    }
}

// Namespace snd
// Params 4
// Checksum 0xbcd268d5, Offset: 0x7cac
// Size: 0x91
function line_attach( soundobject, player, org_start, org_end )
{
    if ( condition_alert( !is_sound_object( soundobject ), "snd::line_attach with invalid soundObject" ) )
    {
        return;
    }
    
    if ( condition_alert( !isplayersafe( player ), "snd::line_attach with invalid player" ) )
    {
        return;
    }
    
    if ( condition_alert( !isvector( org_start ), "snd::line_attach with invalid start position" ) )
    {
        return;
    }
    
    if ( condition_alert( !isvector( org_end ), "snd::line_attach with invalid end position" ) )
    {
        return;
    }
    
    soundobject thread _line_attach_for_player( soundobject, player, org_start, org_end );
}

// Namespace snd
// Params 1
// Checksum 0x8edf4723, Offset: 0x7d45
// Size: 0x2c
function line_detach( soundobject )
{
    if ( condition_alert( !isdefined( soundobject ), "snd::line_detach with undefined soundObject" ) )
    {
        return;
    }
    
    soundobject notify( #"snd_line_detach" );
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0xbb8db7c4, Offset: 0x7d79
// Size: 0x7e
function private _transient_init()
{
    wait_init();
    
    if ( !isarray( level.snd.transient_banks ) )
    {
        level.snd.transient_banks = [];
    }
    
    if ( !isent( level.snd.var_ac6fbf0d4160ba9d ) )
    {
        level.snd.var_ac6fbf0d4160ba9d = spawn( "sound_transient_soundbanks", ( 0, 0, 0 ) );
    }
}

// Namespace snd
// Params 1
// Checksum 0x8602a834, Offset: 0x7dff
// Size: 0x3b, Type: bool
function transient_is_loaded( name )
{
    if ( isdefined( level.snd.transient_banks[ name ] ) && isstruct( level.snd ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x835685eb, Offset: 0x7e43
// Size: 0xf0
function transient_load( name )
{
    _transient_init();
    assert( did_init() );
    assert( isent( level.snd.var_ac6fbf0d4160ba9d ) );
    assert( isarray( level.snd.transient_banks ) );
    assert( isstring( name ), "<dev string:x5f3>" );
    isloaded = transient_is_loaded( name );
    
    if ( condition_alert( isloaded, "snd::transient_load loaded '" + name + "'" ) )
    {
        return;
    }
    
    level.snd.var_ac6fbf0d4160ba9d settransientsoundbank( name + ".all", 1 );
    level.snd.transient_banks[ name ] = level.snd.transient_banks.size;
}

// Namespace snd
// Params 1
// Checksum 0xd8f20c2e, Offset: 0x7f3b
// Size: 0xd8
function transient_unload( name )
{
    _transient_init();
    assert( did_init() );
    assert( isent( level.snd.var_ac6fbf0d4160ba9d ) );
    assert( isarray( level.snd.transient_banks ) );
    assert( isstring( name ), "<dev string:x620>" );
    isloaded = transient_is_loaded( name );
    
    if ( condition_alert( !isloaded, "snd::transient_unload '" + name + "' not loaded" ) )
    {
        return;
    }
    
    level.snd.var_ac6fbf0d4160ba9d settransientsoundbank( name + ".all", 0 );
    level.snd.transient_banks[ name ] = undefined;
}

