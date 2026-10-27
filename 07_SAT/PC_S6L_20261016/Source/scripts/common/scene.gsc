// scripts\common\scene.gsc  (hash_72a196b6c7df2f38.gscc) (size: 29289 Bytes / 0x7269 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64fa1b97 (1694112663)
// size ...... 29289 (0x7269)
// includes .. 6   (offset: 0x6f05)
// strings ... 39  (offset: 0x6f35)
// dev strs .. 14  (offset: 0x71b1)
// exports ... 59  (offset: 0x5099)
// cseg ...... 0x2f1 + 0x4da8 (0x5099)
// imports ... 163 (offset: 0x59d1)
// animtree1 . 0   (offset: 0x7269)
// animtree2 . 0   (offset: 0x7269)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\utility;
#using scripts\common\values;

#namespace scene;

// Namespace scene/bootstrap
// Params 1, eflags: 0x24
// Checksum 0xc9347ef4, Offset: 0x30f
// Size: 0x20
function private event_handler[bootstrap] boot_strap( struct )
{
    level.var_18c87c2c4c3b0a2d = [];
    level.a_scene_structs = [];
}

// Namespace scene/spawnstruct
// Params 1, eflags: 0x24
// Checksum 0x4b173495, Offset: 0x337
// Size: 0x52
function private event_handler[spawnstruct] spawn_struct( struct )
{
    if ( isdefined( struct.script_scenescriptbundle ) )
    {
        level.var_18c87c2c4c3b0a2d[ level.var_18c87c2c4c3b0a2d.size ] = struct.script_scenescriptbundle;
        level.a_scene_structs[ level.a_scene_structs.size ] = struct;
    }
}

// Namespace scene
// Params 4
// Checksum 0xf66c1723, Offset: 0x391
// Size: 0x42
function play( existingentities, shotnames, scriptbundlename, fromtimefrac )
{
    sceneroot = self;
    sceneroot scene_play_internal( existingentities, shotnames, scriptbundlename, fromtimefrac );
}

// Namespace scene
// Params 5
// Checksum 0x86313610, Offset: 0x3db
// Size: 0x77
function pre_stream_play( prestreamtime = 1, existingentities, shotnames, scriptbundlename, fromtimefrac )
{
    sceneroot = self;
    
    if ( !getdvarint( @"hash_51251a5223126524", 0 ) )
    {
        sceneroot pre_stream( existingentities, shotnames, prestreamtime, scriptbundlename );
    }
    
    wait prestreamtime;
    sceneroot play( existingentities, shotnames, scriptbundlename, fromtimefrac );
}

// Namespace scene
// Params 3
// Checksum 0xd8c0cf1d, Offset: 0x45a
// Size: 0x3c
function init( existingentities, shotnames, scriptbundlename )
{
    sceneroot = self;
    return sceneroot scene_init_internal( existingentities, shotnames, scriptbundlename, "scene_init_user" );
}

// Namespace scene
// Params 3
// Checksum 0x58fc854, Offset: 0x49f
// Size: 0x77
function skip( shotnames, timefromend = 0.5, fadeinouttime = 0.5 )
{
    sceneroot = self;
    sceneplay = sceneroot function_42248a6e028ecfa2( shotnames, 0 );
    
    if ( !isdefined( sceneplay ) )
    {
        /#
            iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    sceneplay scene_play_skip( timefromend, fadeinouttime );
}

// Namespace scene
// Params 0
// Checksum 0xf3599d78, Offset: 0x51e
// Size: 0xd2
function stop()
{
    sceneroot = self;
    sceneroot function_b4cfd3b6e6f6987d();
    
    if ( sceneroot get_state() == "Playing" )
    {
        foreach ( sceneplay in sceneroot.scenedata.sceneplay )
        {
            sceneplay thread scene_play_stop( 1 );
        }
        
        waittillframeend();
        
        while ( sceneroot get_state() == "Playing" )
        {
            waitframe();
        }
        
        sceneroot function_c17d9607a8faffc3( "callback_stop" );
    }
}

// Namespace scene
// Params 1
// Checksum 0xe7d15826, Offset: 0x5f8
// Size: 0xa9
function stop_object( var_e8498804c99bde6b )
{
    sceneroot = self;
    sceneobjectdata = undefined;
    
    if ( isent( var_e8498804c99bde6b ) )
    {
        sceneobjectdata = var_e8498804c99bde6b.sceneobjectdata;
    }
    else if ( isdefined( sceneroot ) )
    {
        sceneobjectdata = sceneroot get_object( var_e8498804c99bde6b );
    }
    
    if ( isdefined( sceneobjectdata.sceneroot ) )
    {
        if ( isdefined( sceneobjectdata.index ) )
        {
            sceneobjectdata.sceneroot function_2302629af55b51bd( sceneobjectdata.index );
        }
        
        sceneobjectdata object_set_entity( sceneobjectdata.sceneroot, sceneobjectdata.sceneplay, undefined );
    }
}

// Namespace scene
// Params 1
// Checksum 0xebd45b0e, Offset: 0x6a9
// Size: 0xc0
function pause( pausestate = 1 )
{
    sceneroot = self;
    sceneroot function_b4cfd3b6e6f6987d();
    
    if ( sceneroot get_state() == "Playing" )
    {
        foreach ( sceneplay in sceneroot.scenedata.sceneplay )
        {
            sceneplay thread scene_play_pause( pausestate );
        }
    }
}

// Namespace scene
// Params 1
// Checksum 0xfaadec, Offset: 0x771
// Size: 0x346
function cleanup( forcedeleteall )
{
    sceneroot = self;
    
    if ( forcedeleteall )
    {
        sceneroot.scenestatic = undefined;
    }
    
    if ( forcedeleteall && isdefined( sceneroot.var_c46929fa56699327 ) )
    {
        foreach ( entity in sceneroot.var_c46929fa56699327 )
        {
            if ( !isdefined( entity ) )
            {
                continue;
            }
            
            if ( isagent( entity ) )
            {
                entity.nocorpse = 1;
                entity val::reset_all( "scene_shot" );
                entity kill();
                continue;
            }
            
            entity delete();
        }
        
        sceneroot.var_c46929fa56699327 = undefined;
    }
    
    if ( forcedeleteall )
    {
        if ( sceneroot get_state() == "Playing" )
        {
            sceneroot stop();
        }
    }
    
    if ( isdefined( sceneroot ) && !isdefined( sceneroot.var_c46929fa56699327 ) )
    {
        sceneroot.var_c46929fa56699327 = [];
    }
    
    for ( sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = sceneroot.scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( sceneobjectdata.entity ) && !sceneobjectdata.existingentity )
        {
            if ( forcedeleteall )
            {
                sceneobjectdata object_delete();
                continue;
            }
            
            if ( !isplayer( sceneobjectdata.entity ) )
            {
                sceneroot.var_c46929fa56699327[ sceneobjectdata.entity getentitynumber() ] = sceneobjectdata.entity;
            }
        }
    }
    
    if ( sceneroot.var_c46929fa56699327.size == 0 )
    {
        sceneroot.var_c46929fa56699327 = undefined;
    }
    
    if ( sceneroot get_state() != "NotSetup" )
    {
        sceneroot scene_reset();
    }
    
    if ( sceneroot get_state() == "NotInit" )
    {
        return;
    }
    
    if ( ( sceneroot.scenestatic.var_bc227a74d38bdd36 ?? 1 ) == 1 )
    {
        var_a11daf0a3d76391c = sceneroot.scenestatic.exclusiveplayers ?? level.players;
        
        foreach ( player in var_a11daf0a3d76391c )
        {
            if ( isdefined( player ) && player isconnected() )
            {
                player setclientomnvar( "ui_scene_shot_index", -1 );
                
                for ( index = 1; index < 5 ; index++ )
                {
                    player setclientomnvar( "ui_scene_shot_index_" + index, -1 );
                }
            }
        }
    }
    
    sceneroot scene_set_state( "NotInit" );
}

// Namespace scene
// Params 5
// Checksum 0xfd7c6be8, Offset: 0xabf
// Size: 0x93b
function pre_stream( existingentities, shotnames, duration = 5, scriptbundlename = undefined, mode = "prestream_single" )
{
    sceneroot = self;
    predicttime = 0;
    
    if ( mode == "prestream_predict" )
    {
        predicttime = level.scene.prestreamtime;
    }
    
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    
    if ( isdefined( existingentities ) && !isarray( existingentities ) )
    {
        existingentities = [ existingentities ];
    }
    
    state = sceneroot get_state();
    sceneplay = undefined;
    scenescriptbundle = sceneroot scene_scriptbundle();
    shotindexes = [];
    
    if ( !isdefined( shotnames ) )
    {
        shotnames = sceneroot get_shot_names();
    }
    
    if ( !isarray( shotnames ) )
    {
        shotnames = [ shotnames ];
    }
    
    foreach ( shotname in shotnames )
    {
        shotindex = scenescriptbundle function_965b893bb918d34d( shotname );
        shotindexes[ shotindex ] = shotindex;
    }
    
    foreach ( sceneplayiter in scenedata.sceneplay )
    {
        if ( sceneplayiter.state == "Playing" )
        {
            var_ec547618d18454e5 = arrayintersection( sceneplayiter.var_eb6d7fbdd0bb47f8, shotindexes );
            
            if ( var_ec547618d18454e5.size == shotindexes.size )
            {
                sceneplay = sceneplayiter;
                break;
            }
        }
    }
    
    if ( !isdefined( sceneplay ) )
    {
        sceneplay = sceneroot scene_init_internal( existingentities, shotnames, undefined, "scene_init_prestream" );
    }
    
    if ( isdefined( sceneplay ) && sceneplay.var_eb6d7fbdd0bb47f8.size > 0 )
    {
        sceneplay.prestream = spawnstruct();
        sceneplay.prestream.players = [];
        sceneplay.prestream.objects = [];
        sceneplay.prestream.models = undefined;
        
        /#
            debugdisplayindexes = [];
        #/
        
        foreach ( shotindex in shotindexes )
        {
            sceneplay function_69e565b8af8a06a2( shotindex );
            
            foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder )
            {
                if ( isdefined( var_1d42c5b8ad0adc80[ shotindex ] ) )
                {
                    sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
                    sceneobjectdata thread function_3c2e9847ed1dd391( sceneplay, shotindex );
                }
            }
            
            /#
                debugdisplayindexes[ debugdisplayindexes.size ] = shotindex;
            #/
            
            predicttime -= sceneplay.sceneroot function_b3c7b792a7a154fa( shotindex );
            
            if ( mode == "prestream_simultaneous" )
            {
                continue;
            }
            
            if ( predicttime <= 0 )
            {
                break;
            }
        }
        
        /#
            if ( sceneplay.prestream.players.size == 0 )
            {
                iprintlnbold( "<dev string:x4c>" );
            }
        #/
        
        foreach ( playerinfo in sceneplay.prestream.players )
        {
            entitylist = [];
            entitydist = [];
            modellist = [];
            modeldist = [];
            player = playerinfo.player;
            var_96898119d6bab4bb = 32;
            
            if ( !sceneplay.prestream.models )
            {
                var_96898119d6bab4bb -= player function_72b767355af09ad8( "model" );
            }
            
            foreach ( cameraorigin in playerinfo.cameraorigins )
            {
                closestobjects = sortbydistance( sceneplay.prestream.objects, cameraorigin );
                
                foreach ( objectinfo in closestobjects )
                {
                    dist = distance( cameraorigin, objectinfo.origin );
                    
                    if ( isent( objectinfo.entity ) )
                    {
                        key = objectinfo.entity getentitynumber();
                        
                        if ( !isdefined( entitylist[ key ] ) )
                        {
                            if ( entitylist.size + modellist.size >= var_96898119d6bab4bb )
                            {
                                /#
                                    iprintlnbold( "<dev string:x71>" + 32 );
                                #/
                                
                                break;
                            }
                            
                            entitylist[ key ] = objectinfo.entity;
                            entitydist[ key ] = dist;
                        }
                        else
                        {
                            entitydist[ key ] = min( entitydist[ key ], dist );
                        }
                        
                        continue;
                    }
                    
                    if ( isdefined( objectinfo.model ) )
                    {
                        key = objectinfo.model;
                        
                        if ( !isdefined( modellist[ key ] ) )
                        {
                            if ( entitylist.size + modellist.size >= var_96898119d6bab4bb )
                            {
                                /#
                                    iprintlnbold( "<dev string:x71>" + 32 );
                                #/
                                
                                break;
                            }
                            
                            modellist[ key ] = objectinfo.model;
                            modeldist[ key ] = dist;
                            continue;
                        }
                        
                        modeldist[ key ] = min( modeldist[ key ], dist );
                    }
                }
            }
            
            /#
                if ( playerinfo.cameraorigins.size > 2 )
                {
                    iprintlnbold( "<dev string:x93>" );
                }
            #/
            
            if ( isdefined( player ) )
            {
                /#
                    sceneplay scene_debug::function_bbb480647f4f57ab( debugdisplayindexes, duration, playerinfo.cameraorigins );
                #/
                
                player utility::player_prestream_camera( playerinfo.cameraorigins[ 0 ], duration, playerinfo.cameraorigins[ 1 ] );
                streaments = [];
                streamentsdist = [];
                
                foreach ( key, value in entitylist )
                {
                    streaments[ streaments.size ] = value;
                    streamentsdist[ streamentsdist.size ] = entitydist[ key ];
                }
                
                player utility::player_prestream_assets( "scene", "entity", streaments, streamentsdist, duration );
                
                if ( sceneplay.prestream.models )
                {
                    streammodels = [];
                    streammodelsdist = [];
                    
                    foreach ( key, value in modellist )
                    {
                        streammodels[ streammodels.size ] = value;
                        streammodelsdist[ streammodelsdist.size ] = modeldist[ value ];
                    }
                    
                    player utility::player_prestream_assets( "scene", "model", streammodels, streammodelsdist, duration );
                }
            }
        }
        
        sceneplay.prestreamuntil = undefined;
        
        if ( duration > 0 )
        {
            sceneplay.prestreamuntil = gettime() + duration * 1000;
        }
        else if ( duration < 0 )
        {
            sceneplay.prestreamuntil = -1;
        }
        
        sceneplay.prestream = undefined;
    }
}

// Namespace scene
// Params 1
// Checksum 0xda3975c9, Offset: 0x1402
// Size: 0xab
function get_shot_names( var_2d59f0720490d99b = 1 )
{
    sceneroot = self;
    scenescriptbundle = sceneroot scene_scriptbundle();
    shotnames = [];
    shotcount = scenescriptbundle function_30fd977cf5a4a95e();
    var_bd6ccb3355b22094 = 0;
    
    for ( shotindex = 0; shotindex < shotcount ; shotindex++ )
    {
        shot = scenescriptbundle bundle_get_shot( shotindex );
        
        if ( var_2d59f0720490d99b || !shot function_22dbcb174ae164e7() )
        {
            shotnames[ var_bd6ccb3355b22094 ] = shot shot_get_name();
            var_bd6ccb3355b22094++;
        }
    }
    
    return shotnames;
}

// Namespace scene
// Params 2
// Checksum 0x96152705, Offset: 0x14b6
// Size: 0x112
function get_entities( var_efe6d0277f731e05, filter = "all" )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    entities = [];
    
    if ( !isdefined( scenedata ) )
    {
        return entities;
    }
    
    shotindexes = sceneroot function_4b5fdbefe3851660( var_efe6d0277f731e05 );
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( shotindexes ) && !sceneobjectdata function_11c95ca4a274fbdb( shotindexes ) )
        {
            continue;
        }
        
        switch ( filter )
        {
            case #"hash_d71fd9ff6b033b7a":
                if ( sceneobjectdata.existingentity || sceneobjectdata.sceneobject function_772de5acb2e194c7() != "None" )
                {
                    continue;
                }
                
                break;
        }
        
        entities[ entities.size ] = sceneobjectdata.entity;
    }
    
    return entities;
}

// Namespace scene
// Params 1
// Checksum 0xb5ef4c0d, Offset: 0x15d1
// Size: 0x3e
function get_entity( var_a41f0a1e4948cb19 )
{
    sceneroot = self;
    sceneobjectdata = sceneroot get_object( var_a41f0a1e4948cb19 );
    
    if ( isdefined( sceneobjectdata ) )
    {
        return sceneobjectdata.entity;
    }
}

// Namespace scene
// Params 1
// Checksum 0x3aae2ffa, Offset: 0x1618
// Size: 0xd5
function get_object( var_e8498804c99bde6b )
{
    sceneroot = self;
    
    if ( !( isdefined( sceneroot.scenedata ) && isdefined( var_e8498804c99bde6b ) ) )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    
    if ( isent( var_e8498804c99bde6b ) )
    {
        if ( isdefined( var_e8498804c99bde6b.sceneobjectdata ) )
        {
            assert( var_e8498804c99bde6b.sceneobjectdata.sceneroot === sceneroot );
            return var_e8498804c99bde6b.sceneobjectdata;
        }
        
        return;
    }
    
    if ( isint( var_e8498804c99bde6b ) )
    {
        return scenedata.sceneobjectdata[ var_e8498804c99bde6b ];
    }
    
    if ( isstring( var_e8498804c99bde6b ) )
    {
        var_e8498804c99bde6b = scenedata.var_f6e1a451af0a2b43[ var_e8498804c99bde6b ];
        
        if ( isdefined( var_e8498804c99bde6b ) )
        {
            return scenedata.sceneobjectdata[ var_e8498804c99bde6b ];
        }
    }
}

// Namespace scene
// Params 3
// Checksum 0x520e7282, Offset: 0x16f6
// Size: 0x125
function get_object_alignment( var_a41f0a1e4948cb19, var_f051b54b0cb641b4, scriptbundlename )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return sceneroot;
    }
    
    if ( !isdefined( var_a41f0a1e4948cb19 ) )
    {
        return sceneroot;
    }
    
    scenedata = sceneroot.scenedata;
    sceneobjectdata = sceneroot get_object( var_a41f0a1e4948cb19 );
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return sceneroot;
    }
    
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return sceneroot;
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return sceneroot;
    }
    
    alignmentinfo = scenedata.scenescriptbundle function_83bfd4c94b262c65( sceneroot, shotindex, sceneobjectdata.index, sceneobjectdata.alignmentinfo );
    update_alignment_transform( alignmentinfo );
    return alignmentinfo;
}

// Namespace scene
// Params 3
// Checksum 0x9d1cad15, Offset: 0x1824
// Size: 0xea
function function_d0df7c35d793d179( var_a41f0a1e4948cb19, var_f051b54b0cb641b4, scriptbundlename )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return [];
    }
    
    if ( !isdefined( var_a41f0a1e4948cb19 ) )
    {
        return [];
    }
    
    scenedata = sceneroot.scenedata;
    sceneobjectdata = sceneroot get_object( var_a41f0a1e4948cb19 );
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return [];
    }
    
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return [];
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return [];
    }
    
    return sceneobjectdata function_6bf501072826e845( shotindex );
}

// Namespace scene
// Params 3
// Checksum 0x4e2397e9, Offset: 0x1917
// Size: 0xf9
function get_objects_by_type( objecttype, var_efe6d0277f731e05, scriptbundlename )
{
    sceneroot = self;
    assert( isstring( objecttype ) );
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return [];
    }
    
    scenedata = sceneroot.scenedata;
    objects = [];
    shotindexes = sceneroot function_4b5fdbefe3851660( var_efe6d0277f731e05 );
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata.sceneobject obj_get_type() != objecttype )
        {
            continue;
        }
        
        if ( isdefined( shotindexes ) && !sceneobjectdata function_11c95ca4a274fbdb( shotindexes ) )
        {
            continue;
        }
        
        objects[ objects.size ] = sceneobjectdata;
    }
    
    return objects;
}

// Namespace scene
// Params 2
// Checksum 0x8f17063c, Offset: 0x1a19
// Size: 0xe4, Type: bool
function function_91d4fb6d5b238f7c( scenescriptbundlename, sceneobjectname )
{
    scriptbundle = getscriptbundle( isxhashasset( scenescriptbundlename ) ? scenescriptbundlename : hashcat( %"scenescriptbundle:", scenescriptbundlename ) );
    
    if ( !isdefined( scriptbundle ) )
    {
        return false;
    }
    
    aobjects = scriptbundle.objects;
    
    foreach ( sceneobject in aobjects )
    {
        objectname = sceneobject obj_get_name();
        
        if ( objectname === sceneobjectname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace scene
// Params 1
// Checksum 0x319cd44e, Offset: 0x1b06
// Size: 0x41
function set_anim_rate( rate )
{
    sceneroot = self;
    sceneroot scene_init_static();
    sceneroot.scenestatic.animrate = rate;
    function_5d3c9762c4e7799();
}

// Namespace scene
// Params 1
// Checksum 0xd369aa83, Offset: 0x1b4f
// Size: 0x8c
function function_c3c55ba95cf75724( ishighlod )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( sceneobjectdata.entity ) )
        {
            sceneobjectdata.entity namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( ishighlod );
        }
    }
}

// Namespace scene
// Params 5
// Checksum 0xc27aa5dc, Offset: 0x1be3
// Size: 0xfb
function function_3c9981eea870b966( var_a41f0a1e4948cb19, var_f051b54b0cb641b4, overridetype, overridevalue, scriptbundlename )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return;
    }
    
    if ( !isdefined( var_a41f0a1e4948cb19 ) )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    sceneobjectdata = sceneroot get_object( var_a41f0a1e4948cb19 );
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return;
    }
    
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return;
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return;
    }
    
    sceneobjectdata function_bb5b08e9ff4407ee( shotindex, overridetype, overridevalue );
}

// Namespace scene
// Params 2
// Checksum 0xda0a9288, Offset: 0x1ce6
// Size: 0x6a
function set_scriptbundle( scriptbundlename, var_59c12d021d001e47 = 1 )
{
    sceneroot = self;
    
    if ( isdefined( scriptbundlename ) )
    {
        if ( isdefined( sceneroot.script_scenescriptbundle ) && sceneroot.script_scenescriptbundle != scriptbundlename )
        {
            sceneroot cleanup( var_59c12d021d001e47 );
        }
        
        sceneroot.script_scenescriptbundle = scriptbundlename;
    }
}

// Namespace scene
// Params 2
// Checksum 0x2eec9836, Offset: 0x1d58
// Size: 0xa8
function add_spawn_function( spawnfunc, var_226a1c0234e7ab8b = "_object_all_" )
{
    sceneroot = self;
    sceneroot scene_init_static();
    scenestatic = sceneroot.scenestatic;
    
    if ( !isdefined( scenestatic.spawnfunctions ) )
    {
        scenestatic.spawnfunctions = [];
    }
    
    if ( !isdefined( scenestatic.spawnfunctions[ var_226a1c0234e7ab8b ] ) )
    {
        scenestatic.spawnfunctions[ var_226a1c0234e7ab8b ] = [];
    }
    
    scenestatic.spawnfunctions[ var_226a1c0234e7ab8b ][ scenestatic.spawnfunctions[ var_226a1c0234e7ab8b ].size ] = spawnfunc;
}

// Namespace scene
// Params 0
// Checksum 0x6f383bb4, Offset: 0x1e08
// Size: 0xff
function get_state()
{
    sceneroot = self;
    
    if ( !isdefined( sceneroot.scenedata ) )
    {
        return "NotInit";
    }
    
    sceneroot function_b4cfd3b6e6f6987d();
    
    if ( sceneroot.scenedata.state == "Setup" )
    {
        foreach ( sceneplay in sceneroot.scenedata.sceneplay )
        {
            if ( sceneplay.state === "Playing" )
            {
                return "Playing";
            }
        }
        
        return "Stopped";
    }
    
    return sceneroot.scenedata.state;
}

// Namespace scene
// Params 0
// Checksum 0x855c77c, Offset: 0x1f0f
// Size: 0xef
function function_5fe163f439457bd0()
{
    players = [];
    sceneroot = self;
    
    foreach ( sceneobjectdata in sceneroot.scenedata.sceneobjectdata )
    {
        if ( sceneobjectdata object_get_type() == "Types_XCam" )
        {
            xcam_players = sceneobjectdata function_931d12df9abebc7f();
            players = arraycombineunique( players, xcam_players );
            continue;
        }
        
        if ( isplayer( sceneobjectdata.entity ) )
        {
            players = arraycombineunique( players, [ sceneobjectdata.entity ] );
        }
    }
    
    return players;
}

// Namespace scene
// Params 1
// Checksum 0xbb995762, Offset: 0x2007
// Size: 0x58
function set_exclude_players( exclude_players )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( !exclude_players )
    {
        sceneroot.scenestatic.excludeplayers = undefined;
        return;
    }
    
    sceneroot.scenestatic.excludeplayers = 1;
}

// Namespace scene
// Params 1
// Checksum 0x50cb092a, Offset: 0x2067
// Size: 0x58
function function_f922341b264d32c8( var_22cf99a980b5b2e3 )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( !var_22cf99a980b5b2e3 )
    {
        sceneroot.scenestatic.var_9e562de25765fd05 = undefined;
        return;
    }
    
    sceneroot.scenestatic.var_9e562de25765fd05 = 1;
}

// Namespace scene
// Params 1
// Checksum 0x72933f02, Offset: 0x20c7
// Size: 0x42
function function_a2a5e7f267b0ca05( var_9cd9c9ecfbed632d )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( var_9cd9c9ecfbed632d.size > 0 )
    {
        sceneroot.scenestatic.var_854da17aefaac034 = var_9cd9c9ecfbed632d;
    }
}

// Namespace scene
// Params 1
// Checksum 0x57c5c1cc, Offset: 0x2111
// Size: 0x59
function function_e214b532712cd63a( var_6b00c9eb585feea5 )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( var_6b00c9eb585feea5 >= 0 )
    {
        sceneroot.scenestatic.var_a51f583c93c991ca = var_6b00c9eb585feea5;
        return;
    }
    
    sceneroot.scenestatic.var_a51f583c93c991ca = undefined;
}

// Namespace scene
// Params 1
// Checksum 0xff141249, Offset: 0x2172
// Size: 0x63
function function_b95eab90f9ebc981( exclusiveplayers )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( isdefined( exclusiveplayers ) && !isarray( exclusiveplayers ) )
    {
        exclusiveplayers = [ exclusiveplayers ];
    }
    
    if ( isdefined( sceneroot.scenestatic ) )
    {
        sceneroot.scenestatic.exclusiveplayers = exclusiveplayers;
    }
}

// Namespace scene
// Params 1
// Checksum 0xbe83b377, Offset: 0x21dd
// Size: 0x51
function function_f40e088831060345( enablenotify )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( isdefined( sceneroot.scenestatic ) )
    {
        sceneroot.scenestatic.var_bc227a74d38bdd36 = enablenotify ? undefined : 0;
    }
}

// Namespace scene
// Params 2
// Checksum 0x9b716737, Offset: 0x2236
// Size: 0xcb
function function_84e9d861f1358910( shotnames, var_818b09b2457de0cf )
{
    sceneroot = self;
    
    if ( var_818b09b2457de0cf > 0 )
    {
        shotindices = sceneroot function_4b5fdbefe3851660( shotnames );
        
        foreach ( shot in shotindices )
        {
            sequencekey = sceneroot function_a446556e2efa8a4e( shot );
            sceneroot.var_ca54349bdd9eab77[ sequencekey ] = var_818b09b2457de0cf ?? 0;
        }
    }
}

// Namespace scene
// Params 0
// Checksum 0xb72bf950, Offset: 0x2309
// Size: 0xb3
function function_48ea223b2dfda0()
{
    sceneroot = self;
    sceneroot function_b4cfd3b6e6f6987d();
    characterobjects = get_objects_by_type( "Types_ClientChar" );
    
    foreach ( characterobj in characterobjects )
    {
        characterobj.characterindex = characterobj.sceneobject function_8d6340a41bdf10ed();
    }
    
    return characterobjects;
}

// Namespace scene
// Params 1
// Checksum 0x520f6e70, Offset: 0x23c5
// Size: 0x8e
function function_85b13b837056bc8b( func )
{
    if ( !isdefined( level.scene ) )
    {
        return;
    }
    
    if ( !isdefined( level.scene.igc_handlers ) )
    {
        level.scene.igc_handlers = [];
    }
    
    if ( !arraycontains( level.scene.igc_handlers, func ) )
    {
        level.scene.igc_handlers[ level.scene.igc_handlers.size ] = func;
    }
}

// Namespace scene
// Params 1
// Checksum 0xa6fa9e73, Offset: 0x245b
// Size: 0x8e
function function_53de0775d8452750( func )
{
    if ( !isdefined( level.scene ) )
    {
        return;
    }
    
    if ( !isdefined( level.scene.igc_handlers_done ) )
    {
        level.scene.igc_handlers_done = [];
    }
    
    if ( !arraycontains( level.scene.igc_handlers_done, func ) )
    {
        level.scene.igc_handlers_done[ level.scene.igc_handlers_done.size ] = func;
    }
}

// Namespace scene
// Params 3
// Checksum 0x9e5550d3, Offset: 0x24f1
// Size: 0x125
function add_scene_func( scene_ref, func, var_737cff255011346c )
{
    structdest = undefined;
    
    if ( isstring( scene_ref ) || isxhashasset( scene_ref ) )
    {
        function_9faf48fca9716acd();
        structdest = level.scene;
    }
    else if ( isstruct( scene_ref ) )
    {
        sceneroot = scene_ref;
        sceneroot scene_init_static();
        structdest = sceneroot.scenestatic;
        scene_ref = sceneroot scene_scriptbundle_name();
    }
    else
    {
        assertmsg( "<dev string:xb6>" );
    }
    
    if ( !isdefined( structdest.funcs ) )
    {
        structdest.funcs = [];
    }
    
    if ( !isdefined( structdest.funcs[ scene_ref ] ) )
    {
        structdest.funcs[ scene_ref ] = [];
    }
    
    if ( !isdefined( structdest.funcs[ scene_ref ][ var_737cff255011346c ] ) )
    {
        structdest.funcs[ scene_ref ][ var_737cff255011346c ] = [];
    }
    
    structdest.funcs[ scene_ref ][ var_737cff255011346c ] = arraycombineunique( structdest.funcs[ scene_ref ][ var_737cff255011346c ], [ func ] );
}

// Namespace scene
// Params 3
// Checksum 0x642a3462, Offset: 0x261e
// Size: 0x107, Type: bool
function remove_scene_func( scene_ref, func, var_737cff255011346c )
{
    structdest = undefined;
    
    if ( isstring( scene_ref ) )
    {
        structdest = level.scene;
    }
    else if ( isstruct( scene_ref ) )
    {
        sceneroot = scene_ref;
        sceneroot scene_init_static();
        structdest = sceneroot.scenestatic;
        scene_ref = sceneroot scene_scriptbundle_name();
    }
    else
    {
        assertmsg( "<dev string:xb6>" );
    }
    
    if ( !isdefined( structdest.funcs ) )
    {
        return false;
    }
    
    if ( !isdefined( structdest.funcs[ scene_ref ] ) )
    {
        return false;
    }
    
    if ( !isdefined( structdest.funcs[ scene_ref ][ var_737cff255011346c ] ) )
    {
        return false;
    }
    
    if ( arraycontains( structdest.funcs[ scene_ref ][ var_737cff255011346c ], func ) )
    {
        structdest.funcs[ scene_ref ][ var_737cff255011346c ] = arrayremove( structdest.funcs[ scene_ref ][ var_737cff255011346c ], func );
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 2
// Checksum 0x41aed81c, Offset: 0x272e
// Size: 0xec
function function_8643ca8da60b5458( scene_ref, func )
{
    structdest = undefined;
    
    if ( isstring( scene_ref ) || isxhashasset( scene_ref ) )
    {
        structdest = level.scene;
    }
    else if ( isstruct( scene_ref ) )
    {
        sceneroot = scene_ref;
        sceneroot scene_init_static();
        structdest = sceneroot.scenestatic;
        scene_ref = sceneroot scene_scriptbundle_name();
    }
    else
    {
        assertmsg( "<dev string:xb6>" );
    }
    
    if ( !isdefined( structdest.callbacks ) )
    {
        structdest.callbacks = [];
    }
    
    if ( !isdefined( structdest.callbacks[ scene_ref ] ) )
    {
        structdest.callbacks[ scene_ref ] = [];
    }
    
    structdest.callbacks[ scene_ref ] = arraycombineunique( structdest.callbacks[ scene_ref ], [ func ] );
}

// Namespace scene
// Params 2
// Checksum 0xcd9751ca, Offset: 0x2822
// Size: 0xeb, Type: bool
function function_b6eff0be40251ccd( scene_ref, func )
{
    structdest = undefined;
    
    if ( isstring( scene_ref ) || isxhashasset( scene_ref ) )
    {
        structdest = level.scene;
    }
    else if ( isstruct( scene_ref ) )
    {
        sceneroot = scene_ref;
        sceneroot scene_init_static();
        structdest = sceneroot.scenestatic;
        scene_ref = sceneroot scene_scriptbundle_name();
    }
    else
    {
        assertmsg( "<dev string:xb6>" );
    }
    
    if ( !isdefined( structdest.callbacks ) )
    {
        return false;
    }
    
    if ( !isdefined( structdest.callbacks[ scene_ref ] ) )
    {
        return false;
    }
    
    if ( arraycontains( structdest.callbacks[ scene_ref ], func ) )
    {
        structdest.callbacks[ scene_ref ] = arrayremove( structdest.callbacks[ scene_ref ], func );
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 4
// Checksum 0x358d7335, Offset: 0x2916
// Size: 0xe4
function function_50fa3ec5022ba8e6( objecttype, valuename, value, gameplay )
{
    function_9faf48fca9716acd();
    
    if ( !isdefined( gameplay ) )
    {
        gameplay = 0;
    }
    
    if ( !isdefined( level.scene.values ) )
    {
        level.scene.values = [];
    }
    
    if ( !isdefined( level.scene.values[ objecttype ] ) )
    {
        level.scene.values[ objecttype ] = [];
    }
    
    if ( !isdefined( level.scene.values[ objecttype ][ gameplay ] ) )
    {
        level.scene.values[ objecttype ][ gameplay ] = [];
    }
    
    level.scene.values[ objecttype ][ gameplay ][ valuename ] = value;
}

// Namespace scene
// Params 3
// Checksum 0x59125391, Offset: 0x2a02
// Size: 0x65
function function_f6c388039120f839( objecttype, valuename, gameplay )
{
    function_9faf48fca9716acd();
    
    if ( !isdefined( gameplay ) )
    {
        gameplay = 0;
    }
    
    if ( isdefined( level.scene.values[ objecttype ][ gameplay ][ valuename ] ) )
    {
        level.scene.values[ objecttype ][ gameplay ][ valuename ] = undefined;
    }
}

// Namespace scene
// Params 3
// Checksum 0xcce3db57, Offset: 0x2a6f
// Size: 0xaf
function set_notify_state( notifytarget, eventmessage, statematch )
{
    sceneroot = self;
    sceneroot scene_init_static();
    
    if ( !isdefined( statematch ) )
    {
        statematch = "Stopped";
    }
    
    /#
        if ( statematch != "<dev string:x117>" && statematch != "<dev string:x11f>" )
        {
            assertmsg( "<dev string:x127>" );
        }
    #/
    
    sceneroot.scenestatic.notifyobject = notifytarget;
    sceneroot.scenestatic.notifyevent = eventmessage;
    sceneroot.scenestatic.notifymatch = statematch;
}

// Namespace scene
// Params 4
// Checksum 0x11148f34, Offset: 0x2b26
// Size: 0x19e
function set_notify_note( notifytarget, note, var_226a1c0234e7ab8b, repeat )
{
    sceneroot = self;
    assert( isdefined( var_226a1c0234e7ab8b ), "<dev string:x168>" );
    sceneroot scene_init_static();
    scenestatic = sceneroot.scenestatic;
    notifyinfo = spawnstruct();
    notifyinfo.notifyobject = notifytarget;
    notifyinfo.notifynote = note;
    notifyinfo.notifyrepeat = repeat;
    
    if ( !isdefined( scenestatic.notifies ) )
    {
        scenestatic.notifies = [];
    }
    
    if ( !isdefined( scenestatic.notifies[ var_226a1c0234e7ab8b ] ) )
    {
        scenestatic.notifies[ var_226a1c0234e7ab8b ] = [];
    }
    
    if ( function_c89f1bf37f1ca708( scenestatic.notifies[ var_226a1c0234e7ab8b ], notifyinfo ) )
    {
        return;
    }
    
    scenestatic.notifies[ var_226a1c0234e7ab8b ][ scenestatic.notifies[ var_226a1c0234e7ab8b ].size ] = notifyinfo;
    
    if ( sceneroot get_state() == "Playing" )
    {
        for ( sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobjectdata = sceneroot.scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isdefined( sceneobjectdata.var_caa911de855ae014[ "DeltaAnimation" ] ) )
            {
                sceneobjectdata thread function_f41f57a25d231b2( sceneobjectdata.var_caa911de855ae014[ "DeltaAnimation" ] );
            }
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x8ba31117, Offset: 0x2ccc
// Size: 0xee, Type: bool
function private function_c89f1bf37f1ca708( notifies, newnotify )
{
    if ( !isdefined( notifies ) )
    {
        return false;
    }
    
    foreach ( registerednotify in notifies )
    {
        if ( registerednotify.notifyobject == newnotify.notifyobject && registerednotify.notifynote == newnotify.notifynote && ( registerednotify.notifyrepeat ?? 0 ) == ( newnotify.notifyrepeat ?? 0 ) )
        {
            registerednotify.notifytriggered = undefined;
            return true;
        }
    }
    
    return false;
}

// Namespace scene
// Params 2
// Checksum 0xad3e63aa, Offset: 0x2dc3
// Size: 0x1f4
function function_b3c7b792a7a154fa( var_f051b54b0cb641b4, var_258c0c982c66ce8c )
{
    sceneroot = self;
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return 0;
    }
    
    scenedata = sceneroot.scenedata;
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return 0;
    }
    
    if ( shotindex < 0 )
    {
        return 0;
    }
    
    if ( !isdefined( var_258c0c982c66ce8c ) )
    {
        var_258c0c982c66ce8c = 1;
    }
    
    var_2e3aa55cfe61dec9 = 0;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( shotindex < sceneobjectdata.sceneobject.variant_object.shots.size )
        {
            cameraanimation = sceneobjectdata function_64466e4b9ed25e4c( shotindex );
            
            if ( isdefined( cameraanimation ) )
            {
                var_df6172b83ae83a53 = sceneobjectdata function_58a93a40f02daed7( shotindex, cameraanimation, "CameraAnimation" );
                
                if ( var_df6172b83ae83a53 > var_2e3aa55cfe61dec9 )
                {
                    var_2e3aa55cfe61dec9 = var_df6172b83ae83a53;
                }
            }
            
            var_33d8b2fadff83a5 = 0;
            animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
            shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
            
            for ( animationindex = 0; animationindex < shotanimations.size ; animationindex++ )
            {
                var_33d8b2fadff83a5 += sceneobjectdata function_58a93a40f02daed7( shotindex, shotanimations[ animationindex ], animtype, animationindex );
            }
            
            if ( var_33d8b2fadff83a5 > var_2e3aa55cfe61dec9 )
            {
                var_2e3aa55cfe61dec9 = var_33d8b2fadff83a5;
            }
        }
    }
    
    if ( isdefined( sceneroot.scenestatic.animrate ) && var_258c0c982c66ce8c )
    {
        var_2e3aa55cfe61dec9 *= sceneroot.scenestatic.animrate;
    }
    
    return var_2e3aa55cfe61dec9;
}

// Namespace scene
// Params 2
// Checksum 0xb193dca5, Offset: 0x2fc0
// Size: 0xbc
function function_c411ae921fa2bd3c( var_f051b54b0cb641b4, timeoutms )
{
    sceneroot = self;
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return -1;
    }
    
    scenedata = sceneroot.scenedata;
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( var_f051b54b0cb641b4 );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return -1;
    }
    
    if ( shotindex < 0 )
    {
        return -1;
    }
    
    if ( !isdefined( timeoutms ) )
    {
        timeoutms = int( sceneroot function_b3c7b792a7a154fa( shotindex ) * 1000 );
    }
    
    timeoutms = max( timeoutms, 1000 );
    return scenedata.scenescriptbundle function_33df3c1b6a1cdf25( shotindex, timeoutms );
}

// Namespace scene
// Params 1
// Checksum 0xd66ad61f, Offset: 0x3085
// Size: 0x35d
function shot_get_time( var_f051b54b0cb641b4 )
{
    sceneroot = self;
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    
    if ( !isarray( scenedata.sceneplay ) )
    {
        return;
    }
    
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return;
    }
    
    if ( shotindex < 0 )
    {
        return;
    }
    
    foreach ( itsceneplay in scenedata.sceneplay )
    {
        if ( ( itsceneplay.currentshot ?? -1 ) != shotindex )
        {
            continue;
        }
        
        if ( !isdefined( itsceneplay.var_b443c7b52a68e739 ) )
        {
            itsceneplay.var_b443c7b52a68e739 = itsceneplay function_5dd68723df85d7bb( itsceneplay.var_eb6d7fbdd0bb47f8, 0, 1 );
        }
        
        for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            if ( !isdefined( itsceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
            {
                continue;
            }
            
            refsceneobject = sceneroot.scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isdefined( refsceneobject.activeanimationplaying ) )
            {
                linkents = refsceneobject function_f2fb9eed776f75ff();
                
                if ( isarray( linkents ) && linkents.size > 0 && linkents[ 0 ] isusinganimtree() )
                {
                    shotanimations = refsceneobject function_6bf501072826e845( shotindex );
                    shottime = 0;
                    
                    foreach ( index, animasset in shotanimations )
                    {
                        timefrac = 1;
                        
                        if ( animasset == refsceneobject.activeanimationplaying )
                        {
                            if ( isagent( linkents[ 0 ] ) )
                            {
                                animname = getanimname( animasset );
                                animindex = linkents[ 0 ] asm::asm_lookupanimfromalias( "animscripted", animname );
                                
                                if ( isdefined( animindex ) )
                                {
                                    timefrac = linkents[ 0 ] aigetanimtime( "animscripted", animindex );
                                }
                            }
                            else
                            {
                                timefrac = linkents[ 0 ] getanimtime( refsceneobject.activeanimationplaying ) ?? 1;
                            }
                        }
                        
                        shottime += timefrac * refsceneobject function_58a93a40f02daed7( shotindex, refsceneobject.activeanimationplaying, "DeltaAnimation", index );
                        
                        if ( animasset == refsceneobject.activeanimationplaying )
                        {
                            shotduration = itsceneplay.var_b443c7b52a68e739.shottimeinfo[ shotindex ].durationsec;
                            
                            if ( ( shotduration ?? 0 ) > 0 )
                            {
                                return ( shottime / shotduration );
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace scene
// Params 4
// Checksum 0xc92bb120, Offset: 0x33eb
// Size: 0xd7
function function_110f292f4976d4fd( var_f051b54b0cb641b4, assettype, assets, origins )
{
    sceneroot = self;
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    shotindex = var_f051b54b0cb641b4;
    
    if ( !isint( shotindex ) )
    {
        shotindex = scenedata.scenescriptbundle function_d12c299f7ca4bf79( shotindex );
    }
    
    if ( !isdefined( shotindex ) )
    {
        return;
    }
    
    if ( shotindex < 0 )
    {
        return;
    }
    
    sceneroot scene_init_static();
    structdest = sceneroot.scenestatic;
    structdest.prestreamassets[ shotindex ][ assettype ] = { #origins:origins, #assets:assets };
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x39f038d1, Offset: 0x34ca
// Size: 0x999
function private scene_init_internal( existingentities, shotnames, scriptbundlename, inittype )
{
    sceneroot = self;
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return;
    }
    
    sceneplay = sceneroot function_42248a6e028ecfa2( shotnames, 1 );
    scenedata = sceneroot.scenedata;
    var_e721f1409fd57ca9 = [];
    
    if ( isdefined( existingentities ) )
    {
        if ( !isarray( existingentities ) )
        {
            existingentities = [ existingentities ];
        }
        
        existingentities = function_5713d46873b29625( existingentities );
        
        foreach ( existingentity in existingentities )
        {
            if ( isplayer( existingentity ) )
            {
                var_e721f1409fd57ca9[ var_e721f1409fd57ca9.size ] = existingentity;
            }
            
            if ( isdefined( existingentity.script_animname ) && !isdefined( existingentity.animname ) )
            {
                existingentity.animname = existingentity.script_animname;
            }
        }
    }
    
    if ( var_e721f1409fd57ca9.size > 0 )
    {
        sceneplay.var_e721f1409fd57ca9 = var_e721f1409fd57ca9;
    }
    else
    {
        sceneplay.var_e721f1409fd57ca9 = undefined;
    }
    
    scenedata.isclientscene = 0;
    scenedata.var_3bb93b020e59c4de = undefined;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata object_get_type() == "Types_Player" )
        {
            if ( isdefined( sceneobjectdata.entity ) && isarray( sceneplay.var_e721f1409fd57ca9 ) && !arraycontains( sceneplay.var_e721f1409fd57ca9, sceneobjectdata.entity ) )
            {
                sceneobjectdata object_set_entity( sceneobjectdata.sceneroot, sceneobjectdata.sceneplay, undefined, inittype );
            }
            
            if ( sceneobjectdata function_58b62b656cb29e76() )
            {
                scenedata.var_3bb93b020e59c4de = 1;
            }
        }
        
        if ( sceneobjectdata.sceneobject function_8d6340a41bdf10ed() > 0 )
        {
            scenedata.isclientscene = 1;
        }
    }
    
    if ( scenedata.var_3bb93b020e59c4de )
    {
        sceneroot function_a39787a799ce2d9e();
    }
    
    sceneplay.var_caf7bc39e6b19dd5 = [];
    foundentitiesused = [];
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( !sceneobjectdata function_11c95ca4a274fbdb( sceneplay.var_eb6d7fbdd0bb47f8, sceneplay, sceneobjectindex ) )
        {
            continue;
        }
        
        sceneobjectname = sceneobjectdata.sceneobject obj_get_name();
        existingentities = sceneobjectdata function_8c745f4ef7a9726f( sceneroot, sceneplay, sceneobjectname, existingentities, 1, 1, inittype );
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            sceneroot.var_c46929fa56699327 = sceneobjectdata function_8c745f4ef7a9726f( sceneroot, sceneplay, sceneobjectname, sceneroot.var_c46929fa56699327, 1, 0, inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_46476cf72237e890( sceneroot, sceneplay, sceneobjectname, foundentitiesused, "targetname", inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_46476cf72237e890( sceneroot, sceneplay, sceneobjectname, foundentitiesused, "script_noteworthy", inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_46476cf72237e890( sceneroot, sceneplay, "_scene_global_" + sceneobjectname, foundentitiesused, "targetname", inittype );
        }
        
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            foundentitiesused = sceneobjectdata function_46476cf72237e890( sceneroot, sceneplay, "_scene_global_" + sceneobjectname, foundentitiesused, "script_noteworthy", inittype );
        }
    }
    
    playerindex = 0;
    playermaleindex = 0;
    playerfemaleindex = 0;
    xcamcount = 0;
    maxplayers = -1;
    
    if ( isdefined( sceneroot.scenestatic.var_a51f583c93c991ca ) )
    {
        maxplayers = sceneroot.scenestatic.var_a51f583c93c991ca;
    }
    
    if ( isarray( existingentities ) && foundentitiesused.size > 0 )
    {
        existingentities = arrayremove( existingentities, foundentitiesused );
    }
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( !isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
        {
            continue;
        }
        
        if ( sceneobjectdata object_get_type() == "Types_Player" && inittype == "scene_init_user" )
        {
            continue;
        }
        
        sceneobjectname = sceneobjectdata.sceneobject obj_get_name();
        
        if ( !isdefined( sceneobjectdata.entity ) && !sceneobjectdata.sceneobject function_6b060c2167962186() )
        {
            existingentities = sceneobjectdata function_8c745f4ef7a9726f( sceneroot, sceneplay, sceneobjectname, existingentities, 0, 1, inittype );
            
            if ( !isdefined( sceneobjectdata.entity ) )
            {
                sceneroot.var_c46929fa56699327 = sceneobjectdata function_8c745f4ef7a9726f( sceneroot, sceneplay, sceneobjectname, sceneroot.var_c46929fa56699327, 0, 0, inittype );
            }
        }
        
        entity = sceneobjectdata.entity;
        isplayerobject = sceneobjectdata object_get_type() == "Types_Player";
        xcamcount += sceneobjectdata object_get_type() == "Types_XCam";
        var_c809a3d453c003d6 = 0;
        
        /#
            var_c809a3d453c003d6 = getdvarint( @"hash_3bc9bc279e3f772", 0 );
        #/
        
        if ( !isdefined( entity ) )
        {
            var_bcefe4edd076bc9f = 1;
            
            if ( isplayerobject && maxplayers >= 0 )
            {
                playernumber = playermaleindex;
                
                if ( sceneobjectdata function_58b62b656cb29e76() )
                {
                    playernumber = playerfemaleindex;
                }
                
                if ( playernumber >= maxplayers )
                {
                    var_bcefe4edd076bc9f = 0;
                }
            }
            
            if ( var_bcefe4edd076bc9f && ( !sceneobjectdata.sceneobject function_c68f88c2b5f207d3( sceneplay.shotinit ) || var_c809a3d453c003d6 && isplayerobject ) )
            {
                sceneobjectdata.alignmentinfo = scenedata.scenescriptbundle function_83bfd4c94b262c65( sceneroot, sceneplay.shotinit, sceneobjectindex, sceneobjectdata.alignmentinfo );
                update_alignment_transform( sceneobjectdata.alignmentinfo );
                
                if ( isplayerobject )
                {
                    if ( !sceneobjectdata function_f0e8d8f1099045cc() )
                    {
                        if ( playerindex < level.players.size )
                        {
                            playerentity = level.players[ playerindex ];
                            
                            if ( !function_f43455d85847000( playerentity, sceneobjectdata ) )
                            {
                                playerentity = undefined;
                            }
                            
                            entity = playerentity;
                        }
                    }
                    
                    /#
                        if ( var_c809a3d453c003d6 )
                        {
                            if ( scene_debug::function_c4e717374c36ac3( sceneobjectindex ) )
                            {
                                entity = level.players[ 0 ];
                            }
                            else if ( entity == level.players[ 0 ] )
                            {
                                entity = undefined;
                            }
                        }
                    #/
                }
                else
                {
                    sceneobjectdata.spawner = get_global_ent_or_struct( sceneobjectname, 0 );
                    entity = sceneobjectdata object_spawn( sceneobjectdata.alignmentinfo, sceneplay.shotinit );
                }
            }
            else
            {
                sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] = undefined;
            }
        }
        
        if ( isdefined( entity ) )
        {
            sceneobjectdata object_set_entity( sceneroot, sceneplay, entity, undefined, inittype );
        }
        
        issetup = sceneobjectdata.issetup || isdefined( entity ) && isdefined( entity.sceneobjectdata ) && entity.sceneobjectdata.issetup;
        
        if ( isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) && !( issetup && inittype == "scene_init_prestream" ) )
        {
            sceneobjectdata object_setup( sceneplay );
        }
        
        if ( isdefined( entity ) && inittype == "scene_init_prestream" && !sceneobjectdata.existingentity && !isdefined( sceneobjectdata.activeanimation ) )
        {
            sceneobjectdata function_4395eb62ee2212b9( 0 );
        }
        
        if ( isplayerobject )
        {
            playerindex++;
            
            if ( sceneobjectdata function_58b62b656cb29e76() )
            {
                playerfemaleindex++;
                continue;
            }
            
            playermaleindex++;
        }
    }
    
    if ( inittype != "scene_init_prestream" )
    {
        sceneobjectdata function_4395eb62ee2212b9( 1 );
    }
    
    sceneplay function_69e565b8af8a06a2( sceneplay.shotinit );
    sceneplay.hasplayers = max( playerindex, xcamcount ) > 0;
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( !isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
        {
            continue;
        }
        
        if ( sceneobjectdata object_get_type() == "Types_Player" && inittype == "scene_init_user" )
        {
            continue;
        }
        
        sceneobjectdata object_alignment_link( sceneplay, sceneobjectdata.alignmentinfo, inittype, undefined, 1 );
        
        if ( sceneobjectdata.sceneobject function_e3e0913c7903daa4() && inittype == "scene_init_user" )
        {
            sceneobjectdata object_first_frame( sceneobjectdata.alignmentinfo );
        }
    }
    
    sceneroot scene_set_state( "Setup" );
    sceneplay.state = "Stopped";
    sceneroot function_c17d9607a8faffc3( "callback_init" );
    return sceneplay;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x5ee5f927, Offset: 0x3e6c
// Size: 0x15e
function private scene_play_omnvars( var_e1fc920feb677005 )
{
    scenedata = self;
    scenestatic = scenedata.sceneroot.scenestatic;
    
    if ( scenestatic.var_bc227a74d38bdd36 == 0 )
    {
        return;
    }
    
    var_a11daf0a3d76391c = scenestatic.exclusiveplayers ?? level.players;
    
    foreach ( player in var_a11daf0a3d76391c )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_scene_play", var_e1fc920feb677005 );
        }
    }
    
    wait 0.5;
    
    foreach ( player in var_a11daf0a3d76391c )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_scene_play", -1 );
        }
    }
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0x370bea41, Offset: 0x3fd2
// Size: 0x8cb
function private scene_play_internal( existingentities, shotnames, scriptbundlename, fromtimefrac, startshotindex, skipdistribute )
{
    sceneroot = self;
    
    /#
        if ( getdvarint( @"scr_debug_scene_disabled" ) )
        {
            level waittill( #"hash_1e9bc5e84aa89155" );
            return;
        }
        
        if ( !arraycontains( level.a_scene_structs, sceneroot ) )
        {
            sceneroot.var_737c289bc27765a9 = 1;
            level.a_scene_structs = arraycombineunique( level.a_scene_structs, [ sceneroot ] );
        }
    #/
    
    sceneroot set_scriptbundle( scriptbundlename );
    
    if ( !sceneroot function_b4cfd3b6e6f6987d() )
    {
        return;
    }
    
    scenedata = sceneroot.scenedata;
    
    if ( isdefined( existingentities ) && !isarray( existingentities ) )
    {
        existingentities = [ existingentities ];
    }
    
    state = sceneroot get_state();
    sceneplay = undefined;
    
    if ( state != "NotSetup" )
    {
        sceneplay = sceneroot function_42248a6e028ecfa2( shotnames, 0 );
        
        if ( isdefined( sceneplay ) && sceneplay.state == "Playing" )
        {
            sceneplay scene_play_stop( 0 );
        }
        
        shotindices = undefined;
        
        foreach ( sceneplayiter in scenedata.sceneplay )
        {
            if ( isdefined( sceneplayiter.prestreamuntil ) )
            {
                stopstreaming = sceneplayiter === sceneplay;
                
                if ( !stopstreaming )
                {
                    if ( !isdefined( shotindices ) )
                    {
                        shotindices = sceneroot function_4b5fdbefe3851660( shotnames );
                    }
                    
                    var_ec547618d18454e5 = arrayintersection( sceneplayiter.var_eb6d7fbdd0bb47f8, shotindices );
                    
                    if ( var_ec547618d18454e5.size > 0 )
                    {
                        stopstreaming = 1;
                    }
                }
                
                if ( stopstreaming )
                {
                    if ( sceneplayiter.prestreamuntil < 0 || gettime() > sceneplayiter.prestreamuntil )
                    {
                        sceneroot pre_stream( existingentities, sceneplayiter.var_eb6d7fbdd0bb47f8, level.framedurationseconds * 2 );
                    }
                    
                    sceneplayiter.prestreamuntil = undefined;
                }
            }
        }
    }
    
    sceneplay = sceneroot scene_init_internal( existingentities, shotnames, undefined, "scene_init_play" );
    
    if ( sceneplay.var_eb6d7fbdd0bb47f8.size == 0 )
    {
        /#
            shotsstr = "<dev string:x1ac>";
            
            if ( isdefined( shotnames ) )
            {
                shotsstr = "<dev string:x1ad>";
                
                if ( !isarray( shotnames ) )
                {
                    shotnames = [ shotnames ];
                }
                
                foreach ( shot in shotnames )
                {
                    shotsstr = shotsstr + "<dev string:x1af>" + shot;
                }
            }
            
            iprintlnbold( "<dev string:x1b1>" + getxhashsourcename( sceneroot.script_scenescriptbundle ) + "<dev string:x1ba>" + shotsstr );
        #/
        
        return;
    }
    
    if ( isdefined( sceneroot ) && scenedata.scenescriptbundle function_789e0fbad5b7e8e1() )
    {
        scenedata.noninteractivesequence = 1;
        startnoninteractivesequence();
    }
    
    sceneplay function_97739bae625d1f27( 1 );
    sceneplay function_1d07da6ed2bd0f6b( isdefined( startshotindex ) );
    sceneplay function_4fbd928ce143468f( sceneplay.var_eb6d7fbdd0bb47f8, fromtimefrac, skipdistribute );
    sceneplay function_4b100730bcea788();
    sceneroot function_d267e3929640a45f();
    sceneroot function_c17d9607a8faffc3( "callback_play" );
    sceneroot.scene_shot_play_time_end = undefined;
    var_60595ccb55543612 = getdvarint( @"hash_be485550bea2743", 0 );
    
    if ( var_60595ccb55543612 == 1 )
    {
        sceneref = sceneroot scene_scriptbundle_name();
        sceneref = isxhashasset( sceneref ) ? sceneref : hashcat( %"scenescriptbundle:", sceneref );
        var_e1fc920feb677005 = function_43b5ed5a14a56573( #"scriptbundle_scenescriptbundle", sceneref );
        
        if ( isdefined( var_e1fc920feb677005 ) && scenedata.isclientscene )
        {
            scenedata thread scene_play_omnvars( var_e1fc920feb677005 );
        }
    }
    
    while ( isdefined( sceneroot.scenedata ) && !sceneplay function_177d435a8fba3dc0() )
    {
        scenestarttime = gettime();
        sceneplay.shotindicesindex = 0;
        
        if ( isdefined( startshotindex ) )
        {
            foreach ( index, shotindex in sceneplay.var_eb6d7fbdd0bb47f8 )
            {
                if ( shotindex == startshotindex )
                {
                    sceneplay.shotindicesindex = index;
                    break;
                }
            }
        }
        
        while ( sceneplay.shotindicesindex < sceneplay.var_eb6d7fbdd0bb47f8.size )
        {
            sceneplay.currentshot = sceneplay.var_eb6d7fbdd0bb47f8[ sceneplay.shotindicesindex ];
            sceneplay.nextshot = undefined;
            
            if ( sceneplay.shotindicesindex + 1 < sceneplay.var_eb6d7fbdd0bb47f8.size )
            {
                sceneplay.nextshot = sceneplay.var_eb6d7fbdd0bb47f8[ sceneplay.shotindicesindex + 1 ];
            }
            
            if ( sceneplay.var_eb6d7fbdd0bb47f8.size > sceneplay.shotindicesindex + 1 )
            {
                doprestream = scenedata.scenescriptbundle function_4f6556149db5309e();
                streamtime = level.scene.prestreamtime;
                predicttime = streamtime;
                nextshotnames = [];
                
                for ( var_c2fdbd707967c56d = sceneplay.shotindicesindex + 1; var_c2fdbd707967c56d < sceneplay.var_eb6d7fbdd0bb47f8.size ; var_c2fdbd707967c56d++ )
                {
                    nextshotindex = sceneplay.var_eb6d7fbdd0bb47f8[ var_c2fdbd707967c56d ];
                    nextshot = scenedata.scenescriptbundle bundle_get_shot( nextshotindex );
                    nextshotnames[ nextshotnames.size ] = nextshot shot_get_name();
                    doprestream = doprestream || nextshot function_207777fd99d7a922();
                    predicttime -= sceneroot function_b3c7b792a7a154fa( nextshotindex );
                    
                    if ( predicttime <= 0 )
                    {
                        break;
                    }
                }
                
                if ( sceneplay.var_a173fd36d9f698cb.shottimeinfo[ nextshotindex ].startsec < sceneplay.var_a173fd36d9f698cb.fromtimesec )
                {
                    doprestream = 0;
                }
                
                if ( doprestream && sceneplay.hasplayers )
                {
                    currentshotlength = sceneroot function_b3c7b792a7a154fa( sceneplay.currentshot, 1 );
                    streamstarttime = max( currentshotlength - streamtime, level.framedurationseconds );
                    sceneroot utility::delaythreadendon( streamstarttime, "scene_stop", &pre_stream, existingentities, nextshotnames, streamtime + 0.1, undefined, "prestream_predict" );
                }
            }
            
            if ( isdefined( sceneplay.nextshot ) )
            {
                var_c1ef0e508d82410b = int( sceneroot function_b38b94c97d1d44c6( sceneplay, sceneplay.currentshot ) * 1000 );
                var_a125166e9cdccea3 = int( sceneroot function_b38b94c97d1d44c6( sceneplay, sceneplay.nextshot ) * 1000 );
                var_ff4dcc5e86265567 = var_c1ef0e508d82410b + var_a125166e9cdccea3;
                scenedata.scenescriptbundle function_33df3c1b6a1cdf25( sceneplay.nextshot, max( var_ff4dcc5e86265567, 1000 ) );
            }
            
            success = sceneroot scene_shot_play( sceneplay, sceneplay.currentshot );
            
            if ( !success )
            {
                break;
            }
            
            sceneplay.shotindicesindex++;
            
            if ( sceneplay.var_a173fd36d9f698cb.skipdistribute )
            {
                waitframe();
            }
        }
        
        if ( !isdefined( sceneroot.scenedata.scenescriptbundle ) || !sceneroot.scenedata.scenescriptbundle function_18b6837bdb9e4208() )
        {
            break;
        }
        
        if ( gettime() == scenestarttime )
        {
            break;
        }
    }
    
    sceneroot utility::callsharedfunc( #"scene", #"played", sceneroot, sceneplay );
    sceneplay scene_play_stop_internal();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x5f57dcdb, Offset: 0x48a5
// Size: 0x193
function private function_d267e3929640a45f()
{
    sceneplay = self;
    scenedata = sceneplay.scenedata;
    
    if ( scenedata.scenescriptbundle function_7f138cc8a9e70cf4() )
    {
        if ( !scenedata.sceneroot function_de0c3faf7f92b366() )
        {
            if ( isdefined( level.scene ) && isarray( level.scene.igc_handlers ) )
            {
                foreach ( var_bddce983b620ac2f in level.scene.igc_handlers )
                {
                    self thread [[ var_bddce983b620ac2f ]]();
                }
            }
            
            var_a11daf0a3d76391c = scenedata.scenestatic.exclusiveplayers ?? level.players;
            
            foreach ( player in var_a11daf0a3d76391c )
            {
                player setclientomnvar( "ui_scene_igc_playing", 1 );
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1e56a0cd, Offset: 0x4a40
// Size: 0x1a1
function private function_684eaabee2eab081()
{
    sceneplay = self;
    scenedata = sceneplay.scenedata;
    
    if ( scenedata.scenescriptbundle && scenedata.scenescriptbundle function_7f138cc8a9e70cf4() )
    {
        if ( !scenedata.sceneroot function_de0c3faf7f92b366() )
        {
            if ( isdefined( level.scene ) && isarray( level.scene.igc_handlers_done ) )
            {
                foreach ( var_bddce983b620ac2f in level.scene.igc_handlers_done )
                {
                    self thread [[ var_bddce983b620ac2f ]]();
                }
            }
            
            var_a11daf0a3d76391c = scenedata.scenestatic.exclusiveplayers ?? level.players;
            
            foreach ( player in var_a11daf0a3d76391c )
            {
                player setclientomnvar( "ui_scene_igc_playing", 0 );
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf3a66ea, Offset: 0x4be9
// Size: 0x2b5
function private scene_play_stop_internal()
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    
    /#
        if ( sceneroot.var_737c289bc27765a9 )
        {
            level.a_scene_structs = arrayremove( level.a_scene_structs, sceneroot );
        }
    #/
    
    sceneplay function_97739bae625d1f27( 0 );
    
    if ( isdefined( sceneroot ) && scenedata.noninteractivesequence == 1 )
    {
        function_4d2cf7ef166227();
    }
    
    sceneplay.state = "Stopped";
    sceneplay notify( #"stopped" );
    
    if ( isdefined( sceneroot ) && sceneroot function_534c5ebe7d240503() )
    {
        foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isplayer( sceneobjectdata.entity ) && sceneobjectdata.entity.var_447f739b52f0598d )
            {
                sceneobjectdata.entity.var_447f739b52f0598d = undefined;
                sceneobjectdata.entity setclientomnvar( "ui_is_bink_skippable", 0 );
                continue;
            }
            
            if ( sceneobjectdata.sceneobject.variant_type === "Types_XCam" )
            {
                players = sceneobjectdata function_931d12df9abebc7f();
                
                foreach ( player in players )
                {
                    if ( player.var_447f739b52f0598d )
                    {
                        player.var_447f739b52f0598d = undefined;
                        player setclientomnvar( "ui_is_bink_skippable", 0 );
                    }
                }
            }
        }
    }
    
    sceneplay function_ca4b8bd505800128();
    
    if ( sceneroot get_state() == "Stopped" )
    {
        sceneroot function_7ae4ca45fe9ff944( "Stopped" );
    }
    
    if ( isdefined( sceneroot ) && !sceneplay.stoprequested )
    {
        sceneroot function_c17d9607a8faffc3( "callback_done" );
        sceneroot function_684eaabee2eab081();
    }
    
    sceneroot thread scene_reset_thread();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1c17759b, Offset: 0x4ea6
// Size: 0x31, Type: bool
function private function_177d435a8fba3dc0()
{
    sceneplay = self;
    
    if ( sceneplay.stoprequested )
    {
        return true;
    }
    
    return sceneplay.state === "Stopped";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1b48593f, Offset: 0x4ee0
// Size: 0x11e
function private function_a39787a799ce2d9e()
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    maleindices = [];
    femaleindices = [];
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata object_get_type() == "Types_Player" )
        {
            if ( sceneobjectdata function_58b62b656cb29e76() )
            {
                femaleindices[ femaleindices.size ] = sceneobjectindex;
                continue;
            }
            
            maleindices[ maleindices.size ] = sceneobjectindex;
        }
    }
    
    maxcount = min( maleindices.size, femaleindices.size );
    
    for ( i = 0; i < maxcount ; i++ )
    {
        maleplayerindex = maleindices[ i ];
        femaleplayerindex = femaleindices[ i ];
        scenedata.sceneobjectdata[ maleplayerindex ].var_fc43e503169048b4 = femaleplayerindex;
        scenedata.sceneobjectdata[ femaleplayerindex ].var_bb90b6cef43f6c8f = maleplayerindex;
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf6e07f16, Offset: 0x5006
// Size: 0x93
function private function_263a428cb3b06bb6()
{
    var_79b71dd6eb150719 = function_d1bb58bd28875f50();
    
    foreach ( player in var_79b71dd6eb150719 )
    {
        player stopsoundchannel( "scn_igc_unres_2d" );
        player stopsoundchannel( "scn_lfe_unres_2d" );
    }
}

