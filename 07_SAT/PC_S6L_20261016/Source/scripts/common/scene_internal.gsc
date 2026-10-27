// scripts\common\scene_internal.gsc  (hash_784c8c4f3e5f8686.gscc) (size: 114846 Bytes / 0x1c09e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x669134a4 (1720792228)
// size ...... 114846 (0x1c09e)
// includes .. 12  (offset: 0x1ad7e)
// strings ... 239 (offset: 0x1adde)
// dev strs .. 37  (offset: 0x1bebe)
// exports ... 322 (offset: 0x135ba)
// cseg ...... 0x113a + 0x12480 (0x135ba)
// imports ... 520 (offset: 0x1680a)
// animtree1 . 0   (offset: 0x1c08e)
// animtree2 . 1   (offset: 0x1c08e)
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\notetrack;
#using scripts\common\scene;
#using scripts\common\scene_debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\visibility_mode;
#using scripts\common\weapon;

#namespace scene;

// Namespace scene
// Params 0, eflags: 0x5
// Checksum 0x80216482, Offset: 0x1158
// Size: 0xe0
function private autoexec function_852d3e27a342a948()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
        {
            return;
        }
        
        if ( isinfrontend() )
        {
            return;
        }
        
        thread scene_debug::function_194590af69906dd3();
    #/
    
    setdvarifuninitialized( @"scene_skip_distribute", 1 );
    function_2b49130055538a60();
    
    if ( isinfrontend() )
    {
        return;
    }
    
    scenebundles = getscriptbundlenames( "scenescriptbundle" );
    
    foreach ( scenescriptbundle in scenebundles )
    {
        scenescriptbundle = getscriptbundle( scenescriptbundle );
        scenescriptbundle function_8666fb2470ee0b61();
        
        if ( isdefined( scenescriptbundle ) )
        {
            scenescriptbundle function_8ac744fc3e7dee();
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xd94b39fd, Offset: 0x1240
// Size: 0x30f
function private function_2b49130055538a60()
{
    if ( isdefined( level.var_d567d20efe43f69d ) )
    {
        return;
    }
    
    level.var_d567d20efe43f69d = [];
    
    if ( !level.gamemodebundle.operatorlist )
    {
        return;
    }
    
    operatormap = [];
    var_2f7bdb2fba848e2f = [];
    var_37eeeb1a113b3a4d = [];
    var_faafa2b6bb45e131 = [];
    var_92c90c42ff95167f = [];
    operatorlistbundle = getoperatorlistscriptbundle( level.gamemodebundle.operatorlist );
    
    foreach ( operatorentry in operatorlistbundle.operatorlist )
    {
        if ( utility::function_1e6de0f4874e10be( operatorentry.operator ) )
        {
            continue;
        }
        
        operator = getoperatorscriptbundle( operatorentry.operator );
        
        foreach ( operatorskin in operator.skins )
        {
            if ( utility::function_1e6de0f4874e10be( operatorskin.skin ) )
            {
                continue;
            }
            
            skin = getoperatorskinscriptbundle( operatorskin.skin );
            
            if ( !skin )
            {
                continue;
            }
            
            operatorinfo = { #operatorname:operatorentry.operator };
            operatormap[ operatorskin.skin ] = operatorinfo;
            hasbody = !utility::function_1e6de0f4874e10be( skin.bodymodel );
            hashead = !utility::function_1e6de0f4874e10be( skin.headmodel );
            
            if ( hasbody )
            {
                var_2f7bdb2fba848e2f[ skin.bodymodel ][ operatorskin.skin ] = operatorinfo;
            }
            
            if ( hashead )
            {
                var_37eeeb1a113b3a4d[ skin.headmodel ][ operatorskin.skin ] = operatorinfo;
            }
            
            if ( hasbody && !hashead )
            {
                var_faafa2b6bb45e131[ skin.bodymodel ][ operatorskin.skin ] = operatorinfo;
            }
            
            if ( hashead && !hasbody )
            {
                var_92c90c42ff95167f[ skin.headmodel ][ operatorskin.skin ] = operatorinfo;
            }
        }
    }
    
    level.var_d567d20efe43f69d = operatormap;
    level.var_7eaf6d281e97998c = var_2f7bdb2fba848e2f;
    level.var_418a8ab1e4750a02 = var_37eeeb1a113b3a4d;
    level.var_ec0b002078342c6 = var_faafa2b6bb45e131;
    level.var_5a282f20b419a1c4 = var_92c90c42ff95167f;
    level.var_dc8e4fea13054d2a = [];
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xb79f49c5, Offset: 0x1557
// Size: 0x337
function private function_32922fd7d38aaa18( operatorref = undefined, bodymodel = undefined, headmodel = undefined )
{
    if ( !isdefined( level.var_d567d20efe43f69d ) )
    {
        return;
    }
    
    var_612dcfc0060e1e4f = !utility::function_1e6de0f4874e10be( bodymodel );
    var_80ab2f7f937ed4e5 = !utility::function_1e6de0f4874e10be( headmodel );
    
    if ( !var_612dcfc0060e1e4f && !var_80ab2f7f937ed4e5 )
    {
        return;
    }
    
    var_e75f55021090103f = isdefined( operatorref );
    bodykey = var_612dcfc0060e1e4f ? bodymodel : #"hash_681cf14ff8c15ca9";
    headkey = var_80ab2f7f937ed4e5 ? headmodel : #"hash_681cf14ff8c15ca9";
    operatorkey = var_e75f55021090103f ? operatorref : #"hash_681cf14ff8c15ca9";
    cachedentry = level.var_dc8e4fea13054d2a[ bodykey ][ headkey ][ operatorkey ];
    
    if ( isdefined( cachedentry ) )
    {
        return cachedentry.result;
    }
    
    matches = [];
    
    if ( var_612dcfc0060e1e4f && var_80ab2f7f937ed4e5 )
    {
        bodycandidates = level.var_7eaf6d281e97998c[ bodymodel ];
        headcandidates = level.var_418a8ab1e4750a02[ headmodel ];
        bodycount = isdefined( bodycandidates ) ? bodycandidates.size : 0;
        headcount = isdefined( headcandidates ) ? headcandidates.size : 0;
        
        if ( bodycount > 0 && headcount > 0 )
        {
            if ( bodycount <= headcount )
            {
                matches = function_d00ae0e31bb93d2d( bodycandidates, headcandidates, matches, operatorref, var_e75f55021090103f );
            }
            else
            {
                matches = function_d00ae0e31bb93d2d( headcandidates, bodycandidates, matches, operatorref, var_e75f55021090103f );
            }
        }
        
        matches = function_d00ae0e31bb93d2d( level.var_ec0b002078342c6[ bodymodel ], undefined, matches, operatorref, var_e75f55021090103f );
        matches = function_d00ae0e31bb93d2d( level.var_5a282f20b419a1c4[ headmodel ], undefined, matches, operatorref, var_e75f55021090103f );
    }
    else if ( var_612dcfc0060e1e4f )
    {
        matches = function_d00ae0e31bb93d2d( level.var_7eaf6d281e97998c[ bodymodel ], undefined, matches, operatorref, var_e75f55021090103f );
    }
    else
    {
        matches = function_d00ae0e31bb93d2d( level.var_418a8ab1e4750a02[ headmodel ], undefined, matches, operatorref, var_e75f55021090103f );
    }
    
    matchresult = undefined;
    var_9a9823c82be667e = undefined;
    var_6844b22e8aa6a0bb = undefined;
    matchcount = 0;
    ambiguous = 0;
    
    foreach ( operatorskinname, operatorinfo in matches )
    {
        if ( matchcount == 0 )
        {
            var_9a9823c82be667e = operatorinfo.operatorname;
            var_6844b22e8aa6a0bb = operatorskinname;
        }
        else if ( operatorinfo.operatorname != var_9a9823c82be667e )
        {
            ambiguous = 1;
            break;
        }
        
        matchcount++;
    }
    
    if ( !ambiguous && matchcount > 0 )
    {
        matchresult = { #operatorskinname:matchcount == 1 ? var_6844b22e8aa6a0bb : undefined, #operatorname:var_9a9823c82be667e };
    }
    
    function_f8f7874bcc6f7826( bodykey, headkey, operatorkey, matchresult );
    return matchresult;
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xaef60533, Offset: 0x1897
// Size: 0xe3
function private function_d00ae0e31bb93d2d( bucket, var_e27046375bad692d, matches, operatorref, var_e75f55021090103f )
{
    if ( !isdefined( bucket ) )
    {
        return matches;
    }
    
    foreach ( operatorskinname, operatorinfo in bucket )
    {
        if ( isdefined( matches[ operatorskinname ] ) )
        {
            continue;
        }
        
        if ( isdefined( var_e27046375bad692d ) && !isdefined( var_e27046375bad692d[ operatorskinname ] ) )
        {
            continue;
        }
        
        if ( var_e75f55021090103f && operatorinfo.operatorname != operatorref )
        {
            continue;
        }
        
        matches[ operatorskinname ] = operatorinfo;
    }
    
    return matches;
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0xcbf5d1ce, Offset: 0x1983
// Size: 0x9c
function private function_f8f7874bcc6f7826( bodykey, headkey, operatorkey, matchresult )
{
    if ( !isdefined( level.var_dc8e4fea13054d2a ) )
    {
        level.var_dc8e4fea13054d2a = [];
    }
    
    if ( !isdefined( level.var_dc8e4fea13054d2a[ bodykey ] ) )
    {
        level.var_dc8e4fea13054d2a[ bodykey ] = [];
    }
    
    if ( !isdefined( level.var_dc8e4fea13054d2a[ bodykey ][ headkey ] ) )
    {
        level.var_dc8e4fea13054d2a[ bodykey ][ headkey ] = [];
    }
    
    level.var_dc8e4fea13054d2a[ bodykey ][ headkey ][ operatorkey ] = { #result:matchresult };
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x567dd5b8, Offset: 0x1a27
// Size: 0x52e
function private function_9faf48fca9716acd()
{
    if ( !isdefined( level.scene ) )
    {
        level.scene = spawnstruct();
    }
    
    level.scene.prestreamtime = 2;
    
    if ( !isdefined( level.scene.fnsceneplay ) )
    {
        level.scene.fnsceneplay = &play;
    }
    
    if ( !isdefined( level.scene.modehandlers ) )
    {
        level.scene.modehandlers = [];
        
        if ( level.gametypebundle.var_a6d8281234bcca0c )
        {
            function_8eae84e23a4f5614( "modePlayerSkip", &function_1dcd5307e18e1464 );
        }
        else
        {
            function_8eae84e23a4f5614( "modePlayerSkip", &player_scene_play_wait_skip );
        }
    }
    
    if ( !isdefined( level.scene.objecthandlers ) )
    {
        level.scene.objecthandlers = [];
        function_3a06b41e384fbf58( "Types_Object", "objectSpawn", &object_spawn );
        function_3a06b41e384fbf58( "Types_Object", "objectSetup", &object_setup );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectPrepare", &function_90aaff2103125c26 );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectSetup", &function_8207af582343cc24 );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectLinkSetup", &function_240bf4f132c66497 );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectFirstFrame", &object_first_frame );
        function_3a06b41e384fbf58( "Types_Object", "objectMatchEntity", &function_9fb3f4e85f34d87b );
        function_3a06b41e384fbf58( "Types_Object", "objectGetAnimEntity", &function_15e572f4ed82dd1c );
        function_3a06b41e384fbf58( "Types_Object", "objectGetLinkEnts", &function_f2fb9eed776f75ff );
        function_3a06b41e384fbf58( "Types_Object", "objectGetAnimRoot", &function_de784fc1d0ea14bf );
        function_3a06b41e384fbf58( "Types_Object", "objectTeleport", &object_teleport );
        function_3a06b41e384fbf58( "Types_Object", "objectVelocity", &object_velocity );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectPlayAnim", &object_play_anim );
        function_3a06b41e384fbf58( "Types_Object", "objectWaitNotes", &function_26364b7b16eb9611 );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectStopAnim", &function_2d0d8b2ed2c4709a );
        function_3a06b41e384fbf58( "Types_Object", "shotObjectCleanup", &function_5a563c79ceb8a795 );
        function_3a06b41e384fbf58( "Types_Object", "objectCleanup", &object_cleanup );
        function_3a06b41e384fbf58( "Types_Object", "objectDelete", &object_delete );
        function_3a06b41e384fbf58( "Types_Object", "objectKill", &object_kill );
        function_3a06b41e384fbf58( "Types_Vehicle", "objectSpawn", &vehicle_spawn_ent );
        function_3a06b41e384fbf58( "Types_Vehicle", "shotObjectSetup", &function_247fd4fdf1e19551 );
        function_3a06b41e384fbf58( "Types_Vehicle", "objectMatchEntity", &function_20b1309c9e58e1e6 );
        function_3a06b41e384fbf58( "Types_Vehicle", "shotObjectStopAnim", &vehicle_stop_anim );
        function_3a06b41e384fbf58( "Types_ClientChar", "objectSpawn", &client_character_spawn );
        function_3a06b41e384fbf58( "Types_ClientChar", "objectSetAnimName", &function_2535ce3d8e09fa05 );
        function_3a06b41e384fbf58( "Types_ClientChar", "objectMatchEntity", &function_dd0009340cb25d87 );
        function_3a06b41e384fbf58( "Types_ClientChar", "shotObjectPlayAnim", &function_27be1a15599d865c );
        function_3a06b41e384fbf58( "Types_ClientChar", "shotObjectStopAnim", &function_4450d8e5e58a15fe );
        function_3a06b41e384fbf58( "Types_ClientChar", "objectTeleport", &client_character_teleport );
        function_3a06b41e384fbf58( "Types_ClientChar", "shotObjectLinkAnim", &client_character_link );
        function_3a06b41e384fbf58( "Types_Mayhem", "objectSpawn", &mayhem_spawn );
        function_3a06b41e384fbf58( "Types_Mayhem", "shotObjectSetup", &function_fc408f57f842ae );
        function_3a06b41e384fbf58( "Types_Mayhem", "shotObjectFirstFrame", &mayhem_first_frame );
        function_3a06b41e384fbf58( "Types_Mayhem", "shotObjectPlayAnim", &mayhem_play_anim );
        function_3a06b41e384fbf58( "Types_Mayhem", "shotObjectStopAnim", &function_4f1730d1da8c5710 );
        function_3a06b41e384fbf58( "Types_Mayhem", "objectDelete", &mayhem_delete );
        function_3a06b41e384fbf58( "Types_XCam", "objectSpawn", &xcam_spawn );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectSetup", &function_e770a2937db5fd28 );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectCleanup", &function_ce4a84e6cdf6ee71 );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectFirstFrame", &xcam_first_frame );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectPreStream", &function_524845ca311375cd );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectPlayAnim", &xcam_play_anim );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectSkipAnim", &function_a2ff48defd65ed33 );
        function_3a06b41e384fbf58( "Types_XCam", "shotObjectStopAnim", &function_ff81a969d869304e );
        function_3a06b41e384fbf58( "Types_XCam", "objectDelete", &xcam_delete );
        function_3a06b41e384fbf58( "Types_XCam", "objectMatchEntity", &function_78150143df380fd7 );
        function_3a06b41e384fbf58( "Types_XCam", "objectCleanup", &xcam_cleanup );
        function_3a06b41e384fbf58( "Types_XCam", "objectParticipatingCinematics", &function_5f31e9fc1b086d5f );
        function_3a06b41e384fbf58( "Types_Prop", "objectSpawn", &prop_spawn_ent );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xdea223, Offset: 0x1f5d
// Size: 0xd1
function private function_dc6ad1d9a0057d1c( str_flag )
{
    utility::flag_wait( str_flag );
    
    foreach ( s_scene in level.a_scene_structs )
    {
        if ( isdefined( s_scene.spawnflags ) )
        {
            if ( ( s_scene.spawnflags & 2 ) == 2 )
            {
                s_scene thread play();
                continue;
            }
            
            if ( ( s_scene.spawnflags & 1 ) == 1 )
            {
                s_scene thread init();
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xa3f4efd5, Offset: 0x2036
// Size: 0x36
function private scene_init_static()
{
    sceneroot = self;
    function_9faf48fca9716acd();
    
    if ( isdefined( sceneroot.scenestatic ) )
    {
        return;
    }
    
    sceneroot.scenestatic = spawnstruct();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x8c4778f8, Offset: 0x2074
// Size: 0x35d
function private function_b4cfd3b6e6f6987d()
{
    sceneroot = self;
    
    if ( !isdefined( sceneroot ) )
    {
        return;
    }
    
    function_9faf48fca9716acd();
    
    if ( isdefined( sceneroot.scenedata ) && sceneroot.scenedata.state != "NotInit" )
    {
        return isdefined( sceneroot.scenedata.scenescriptbundle );
    }
    
    scenedata = spawnstruct();
    sceneroot.scenedata = scenedata;
    scenedata.sceneroot = sceneroot;
    
    /#
        sceneroot scene_debug::register();
    #/
    
    scenedata.state = "NotSetup";
    scenedata.sceneplay = [];
    scenedata.scenescriptbundle = sceneroot scene_scriptbundle();
    scenedata.sceneobjectdata = [];
    scenedata.var_f6e1a451af0a2b43 = [];
    
    if ( !isdefined( scenedata.scenescriptbundle ) )
    {
        /#
            scriptbundlename = sceneroot scene_scriptbundle_name();
            
            if ( isdefined( scriptbundlename ) )
            {
                println( "<dev string:x24>" + getxhashsourcename( scriptbundlename ) + "<dev string:x50>" );
            }
        #/
        
        return 0;
    }
    
    scenedata.scenescriptbundle function_8666fb2470ee0b61();
    objectcount = scenedata.scenescriptbundle function_bd663a9606d90ac1();
    
    for ( objectindex = 0; objectindex < objectcount ; objectindex++ )
    {
        sceneobjectdata = spawnstruct();
        scenedata.sceneobjectdata[ objectindex ] = sceneobjectdata;
        sceneobjectdata.index = objectindex;
        sceneobjectdata.sceneroot = sceneroot;
        sceneobjectdata.sceneplay = undefined;
        sceneobjectdata.scenedata = scenedata;
        sceneobjectdata.sceneobject = scenedata.scenescriptbundle function_45cf04bf56228582( objectindex );
        sceneobjectdata.functable = level.scene.var_503e815140d769a6[ sceneobjectdata.sceneobject obj_get_type() ];
        sceneobjectdata.entity = undefined;
        sceneobjectdata.existingentity = undefined;
        sceneobjectdata.active = undefined;
        sceneobjectdata.var_caa911de855ae014 = undefined;
        sceneobjectdata.animtreeprevious = undefined;
        sceneobjectdata.activeanimationtype = undefined;
        sceneobjectdata.activeanimation = undefined;
        sceneobjectdata.activeanimationplaying = undefined;
        sceneobjectdata.var_2d749d02fccaab1 = undefined;
        sceneobjectdata.playbacksuccessful = undefined;
        sceneobjectdata.alignmentinfo = undefined;
        sceneobjectdata.issetup = undefined;
        sceneobjectdata.linkedtag = undefined;
        sceneobjectdata.xcamplaying = undefined;
        sceneobjectdata.alignmentinfo = undefined;
        sceneobjectdata.mayhemname = undefined;
        sceneobjectdata.pausestate = undefined;
        hasanimations = sceneobjectdata.sceneobject function_b1e1b14a9d31f8a6();
        sceneobjectdata.nonvisible = sceneobjectdata function_9a1b14ef2ca6596f() ? 1 : undefined;
        sceneobjectdata.notanimated = hasanimations.size == 0 ? 1 : undefined;
        sceneobjectdata.var_7b6f3f539c4ce1da = !hasanimations[ "DeltaAnimation" ] ? 1 : undefined;
        scenedata.var_f6e1a451af0a2b43[ sceneobjectdata.sceneobject obj_get_name() ] = objectindex;
    }
    
    return 1;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xb63f4191, Offset: 0x23da
// Size: 0x32
function private scene_reset_thread()
{
    sceneroot = self;
    waittillframeend();
    
    if ( function_9ff5a5ba55728756() )
    {
        return;
    }
    
    if ( sceneroot get_state() == "Stopped" )
    {
        sceneroot scene_reset();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xddd7de77, Offset: 0x2414
// Size: 0x10e
function private scene_reset()
{
    sceneroot = self;
    state = sceneroot get_state();
    
    if ( state == "NotInit" || state == "NotSetup" )
    {
        return;
    }
    
    if ( state == "Playing" )
    {
        sceneroot stop();
    }
    
    if ( isdefined( sceneroot.scenedata ) )
    {
        for ( sceneobjectindex = 0; sceneobjectindex < sceneroot.scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobjectdata = sceneroot.scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isdefined( sceneobjectdata ) && isdefined( sceneobjectdata.entity ) )
            {
                sceneobjectdata object_cleanup();
            }
        }
    }
    
    sceneroot scene_set_state( "NotSetup" );
    
    if ( isdefined( sceneroot.scenedata ) && sceneroot.scenedata.scenescriptbundle function_cf08117a77afbc1e() )
    {
        sceneroot cleanup();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x8b4de25, Offset: 0x252a
// Size: 0x35
function private function_534c5ebe7d240503()
{
    sceneroot = self;
    scenescriptbundle = sceneroot scene_scriptbundle();
    
    if ( isdefined( scenescriptbundle ) )
    {
        return scenescriptbundle function_cf6d109b139cfdbf();
    }
    
    return 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x2737937, Offset: 0x2567
// Size: 0x29
function private function_de0c3faf7f92b366()
{
    sceneroot = self;
    scenescriptbundle = sceneroot scene_scriptbundle();
    return scenescriptbundle function_2ae71d4375525d5a();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xac784a7a, Offset: 0x2599
// Size: 0x29
function private function_e110ac962c92a40d()
{
    sceneroot = self;
    scenescriptbundle = sceneroot scene_scriptbundle();
    return scenescriptbundle function_789e0fbad5b7e8e1();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xad823810, Offset: 0x25cb
// Size: 0x29
function private function_78308b2c7baaf7ee()
{
    sceneroot = self;
    scenescriptbundle = sceneroot scene_scriptbundle();
    return scenescriptbundle function_c7c350c8df3d0e0a();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x78e74fbb, Offset: 0x25fd
// Size: 0x17f
function private function_d1bb58bd28875f50()
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    var_79b71dd6eb150719 = [];
    
    if ( !isdefined( scenedata ) )
    {
        return var_79b71dd6eb150719;
    }
    
    foreach ( sceneobjectdata in scenedata.sceneobjectdata )
    {
        if ( isplayer( sceneobjectdata.entity ) )
        {
            var_79b71dd6eb150719[ sceneobjectdata.entity getentitynumber() ] = sceneobjectdata.entity;
            continue;
        }
        
        if ( sceneobjectdata.sceneobject.variant_type === "Types_XCam" )
        {
            a_xcam_players = sceneobjectdata function_931d12df9abebc7f();
            
            foreach ( player in a_xcam_players )
            {
                var_79b71dd6eb150719[ player getentitynumber() ] = player;
            }
        }
    }
    
    return var_79b71dd6eb150719;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xc230a85c, Offset: 0x2785
// Size: 0xa2
function private function_5d3c9762c4e7799()
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    animrate = undefined;
    
    if ( isdefined( sceneroot.scenestatic ) )
    {
        animrate = sceneroot.scenestatic.animrate;
    }
    
    if ( !isdefined( scenedata ) )
    {
        return;
    }
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        sceneobjectdata function_909c00577c56aa35( animrate );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x553a928b, Offset: 0x282f
// Size: 0x29a
function private function_c17d9607a8faffc3( var_737cff255011346c )
{
    sceneroot = self;
    scenestatic = sceneroot.scenestatic;
    
    if ( !isdefined( var_737cff255011346c ) )
    {
        return;
    }
    
    scriptbundlename = sceneroot scene_scriptbundle_name();
    
    if ( !isdefined( scriptbundlename ) )
    {
        return;
    }
    
    if ( isdefined( level.scene.funcs[ scriptbundlename ][ var_737cff255011346c ] ) )
    {
        foreach ( func in level.scene.funcs[ scriptbundlename ][ var_737cff255011346c ] )
        {
            sceneroot thread [[ func ]]();
        }
    }
    
    if ( isdefined( scenestatic ) && isdefined( scenestatic.funcs[ scriptbundlename ][ var_737cff255011346c ] ) )
    {
        foreach ( func in scenestatic.funcs[ scriptbundlename ][ var_737cff255011346c ] )
        {
            sceneroot thread [[ func ]]();
        }
    }
    
    if ( isdefined( level.scene.callbacks[ scriptbundlename ] ) )
    {
        foreach ( func in level.scene.callbacks[ scriptbundlename ] )
        {
            sceneroot thread [[ func ]]( var_737cff255011346c );
        }
    }
    
    if ( isdefined( scenestatic ) && isdefined( scenestatic.callbacks[ scriptbundlename ] ) )
    {
        foreach ( func in scenestatic.callbacks[ scriptbundlename ] )
        {
            sceneroot thread [[ func ]]( var_737cff255011346c );
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe13f5e3, Offset: 0x2ad1
// Size: 0x12a
function private function_4b5fdbefe3851660( var_efe6d0277f731e05 )
{
    sceneroot = self;
    shotindexes = var_efe6d0277f731e05;
    
    if ( isdefined( shotindexes ) )
    {
        scenescriptbundle = sceneroot scene_scriptbundle();
        shotcount = scenescriptbundle function_30fd977cf5a4a95e();
        
        if ( !isarray( shotindexes ) )
        {
            shotindexes = [ shotindexes ];
        }
        
        for ( i = 0; i < shotindexes.size ; i++ )
        {
            shotindex = shotindexes[ i ];
            
            if ( isdefined( shotindex ) && !isint( shotindex ) )
            {
                shotindexes[ i ] = -1;
                
                for ( checkshotindex = 0; checkshotindex < shotcount ; checkshotindex++ )
                {
                    shot = scenescriptbundle bundle_get_shot( checkshotindex );
                    shotname = shot shot_get_name();
                    
                    if ( shotname == shotindex )
                    {
                        shotindexes[ i ] = checkshotindex;
                        break;
                    }
                }
            }
        }
    }
    else
    {
        shotindexes = [];
        shotcount = sceneroot.scenedata.scenescriptbundle function_30fd977cf5a4a95e();
        
        for ( shotindex = 0; shotindex < shotcount ; shotindex++ )
        {
            shotindexes[ shotindexes.size ] = shotindex;
        }
    }
    
    return shotindexes;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x132d1d00, Offset: 0x2c04
// Size: 0xbf
function private function_a446556e2efa8a4e( shotindices )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    scenescriptbundle = sceneroot scene_scriptbundle();
    shotcount = scenescriptbundle function_30fd977cf5a4a95e();
    
    if ( !isarray( shotindices ) )
    {
        shotindices = [ shotindices ];
    }
    
    result = getxhash( "SSK" );
    
    for ( i = 0; i < shotindices.size ; i++ )
    {
        shotindex = shotindices[ i ];
        assert( isint( shotindex ) );
        result = hashcat( result, "_" + shotindex );
    }
    
    return result;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x197684b4, Offset: 0x2ccc
// Size: 0x193
function private function_42248a6e028ecfa2( shotnames, var_d2c07a25a9a590c )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    shotindices = sceneroot function_4b5fdbefe3851660( shotnames );
    sequencekey = sceneroot function_a446556e2efa8a4e( shotindices );
    
    if ( isdefined( scenedata.sceneplay[ sequencekey ] ) )
    {
        return scenedata.sceneplay[ sequencekey ];
    }
    
    if ( !var_d2c07a25a9a590c )
    {
        return;
    }
    
    sceneplay = spawnstruct();
    sceneplay.sceneroot = sceneroot;
    sceneplay.var_eb6d7fbdd0bb47f8 = [];
    sceneplay.shotindices = shotindices;
    sceneplay.shotindicesindex = undefined;
    sceneplay.var_ec8b7af923c063a9 = shotnames;
    
    for ( shotindex = 0; shotindex < shotindices.size ; shotindex++ )
    {
        var_fb9b282f30ab6dfd = shotindices[ shotindex ];
        shot = scenedata.scenescriptbundle bundle_get_shot( var_fb9b282f30ab6dfd );
        
        if ( isdefined( shot ) && !shot function_22dbcb174ae164e7() )
        {
            sceneplay.var_eb6d7fbdd0bb47f8[ sceneplay.var_eb6d7fbdd0bb47f8.size ] = var_fb9b282f30ab6dfd;
        }
    }
    
    if ( isdefined( sceneplay.var_eb6d7fbdd0bb47f8[ 0 ] ) )
    {
        sceneplay.shotinit = sceneplay.var_eb6d7fbdd0bb47f8[ 0 ];
    }
    else
    {
        sceneplay.shotinit = 0;
    }
    
    scenedata.sceneplay[ sequencekey ] = sceneplay;
    return sceneplay;
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0xb6c5a9cb, Offset: 0x2e68
// Size: 0x194
function private scene_coordinated_reach( sceneplay, shotindex, speed_baseline, guy_anim )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    sceneplay notify( #"scene_coordinated_reach" );
    sceneplay endon( #"scene_coordinated_reach" );
    
    if ( isdefined( sceneplay.currentshotreachspeed ) )
    {
        sceneplay.currentshotreachspeed = min( sceneplay.currentshotreachspeed, speed_baseline );
    }
    else
    {
        sceneplay.currentshotreachspeed = speed_baseline;
    }
    
    if ( !isdefined( sceneplay.var_3a7c353d808dda66 ) )
    {
        sceneplay.var_3a7c353d808dda66 = [];
    }
    
    sceneplay.var_3a7c353d808dda66[ sceneplay.var_3a7c353d808dda66.size ] = guy_anim;
    waittillframeend();
    sceneroot animation::function_91a1da37e0f88ea8( sceneplay.var_3a7c353d808dda66, sceneplay.currentshotreachspeed );
    
    foreach ( guy_anim in sceneplay.var_3a7c353d808dda66 )
    {
        guy = guy_anim[ 0 ];
        
        if ( isdefined( guy ) )
        {
            guy notify( #"scene_coordinated_reach" );
        }
    }
    
    sceneplay.var_3a7c353d808dda66 = undefined;
    sceneplay.currentshotreachspeed = undefined;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x48ba4046, Offset: 0x3004
// Size: 0x153
function private function_a792a1f58632796b( arrivaltypegdt )
{
    if ( !isdefined( level.var_7dc9218ae5d2578a ) )
    {
        level.var_7dc9218ae5d2578a = [];
        level.var_7dc9218ae5d2578a[ "Exposed" ] = "Exposed";
        level.var_7dc9218ae5d2578a[ "ExposedMoving" ] = "Exposed Moving";
        level.var_7dc9218ae5d2578a[ "ExposedCrouch" ] = "Exposed Crouch";
        level.var_7dc9218ae5d2578a[ "CoverCrouch" ] = "Cover Crouch";
        level.var_7dc9218ae5d2578a[ "CoverStand" ] = "Cover Stand";
        level.var_7dc9218ae5d2578a[ "CoverProne" ] = "Cover Prone";
        level.var_7dc9218ae5d2578a[ "CoverLeft" ] = "Cover Left";
        level.var_7dc9218ae5d2578a[ "CoverLeftCrouch" ] = "Cover Left Crouch";
        level.var_7dc9218ae5d2578a[ "CoverRight" ] = "Cover Right";
        level.var_7dc9218ae5d2578a[ "CoverRightCrouch" ] = "Cover Right Crouch";
        level.var_7dc9218ae5d2578a[ "CoverCrouchLMG" ] = "Cover Crouch LMG";
        level.var_7dc9218ae5d2578a[ "CoverStandLMG" ] = "Cover Stand LMG";
    }
    
    if ( !isdefined( level.var_7dc9218ae5d2578a[ arrivaltypegdt ] ) )
    {
        println( "<dev string:x52>" + arrivaltypegdt );
        return "Exposed";
    }
    
    return level.var_7dc9218ae5d2578a[ arrivaltypegdt ];
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xe3c91ba8, Offset: 0x3160
// Size: 0x12a
function private reach_speed( demeanor, locomotion )
{
    speed_baseline = 225;
    
    switch ( demeanor )
    {
        case #"hash_186d745a92c317d9":
            speed_baseline = 53;
            break;
        case #"hash_9128327eb51e0b7b":
            speed_baseline = 48;
            break;
        case #"hash_46fdaf04e9be63e4":
            speed_baseline = 75;
            break;
        case #"hash_d320ccf96c495f71":
            speed_baseline = 47;
            break;
        case #"hash_1a53266c17b7d481":
        case #"hash_9a93c307fd4015ae":
        case #"hash_9e02cd4a0f3ca981":
        case #"hash_a7db48ba68421306":
            if ( locomotion == "sprint" )
            {
                speed_baseline = 225;
            }
            else
            {
                speed_baseline = 140;
            }
            
            break;
        case #"hash_eb06fed69a41dab5":
            speed_baseline = 225;
            break;
    }
    
    if ( demeanor != "patrol" && demeanor != "alert" )
    {
        switch ( locomotion )
        {
            case #"hash_bdea5e7441323370":
                speed_baseline *= 0.5;
                break;
            case #"hash_5c7fca6c3a403003":
                speed_baseline *= 0.75;
                break;
        }
    }
    
    return speed_baseline;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x7ea4b2d8, Offset: 0x3293
// Size: 0x30
function private function_4b100730bcea788()
{
    sceneplay = self;
    typefunc = mode_get_func( "modeStartMonitoringPlayers" );
    
    if ( isdefined( typefunc ) )
    {
        sceneplay thread [[ typefunc ]]();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xd7a12cdd, Offset: 0x32cb
// Size: 0x30
function private function_ca4b8bd505800128()
{
    sceneplay = self;
    typefunc = mode_get_func( "modeStopMonitoringPlayers" );
    
    if ( isdefined( typefunc ) )
    {
        sceneplay [[ typefunc ]]();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe69f9c11, Offset: 0x3303
// Size: 0x25
function private function_e4f8202c937ebe9()
{
    typefunc = mode_get_func( "modeXCamRespectsStartingTimeOnClients" );
    
    if ( isdefined( typefunc ) )
    {
        return [[ typefunc ]]();
    }
    
    return 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x955413ee, Offset: 0x3331
// Size: 0x36, Type: bool
function private function_68d2c57d9f9e8a7e()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.playerlinktag ?? "tag_player";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x5f0eb8ed, Offset: 0x3370
// Size: 0x2f, Type: bool
function private function_70903a2d7e1583c7()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.allowusability );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xdbeed122, Offset: 0x33a8
// Size: 0x2f, Type: bool
function private function_58b62b656cb29e76()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.isfemale );
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x6a1b1fd2, Offset: 0x33e0
// Size: 0x5c
function private function_f43455d85847000( entity, sceneobjectdata )
{
    if ( !isdefined( entity ) )
    {
        return 0;
    }
    
    if ( sceneobjectdata.scenedata.var_3bb93b020e59c4de )
    {
        typefunc = mode_get_func( "modePlayerMatchingObjectForFemale" );
        
        if ( isdefined( typefunc ) )
        {
            return [[ typefunc ]]( entity, sceneobjectdata );
        }
    }
    
    return 1;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xec42ee50, Offset: 0x3445
// Size: 0x17c
function private function_2b6fe9f287188c01()
{
    sceneobjectdata = self;
    
    if ( isplayer( sceneobjectdata.entity ) || isagent( sceneobjectdata.entity ) )
    {
        curweapon = sceneobjectdata.entity getcurrentprimaryweapon();
        
        if ( !isdefined( curweapon ) )
        {
            curweapon = sceneobjectdata.entity.primaryweaponobj;
        }
        else if ( isnullweapon( curweapon ) )
        {
            curweapon = sceneobjectdata.entity.primaryweaponobj;
        }
        
        if ( isdefined( curweapon ) && !isnullweapon( curweapon ) )
        {
            weaponclass = weaponclass( curweapon.basename );
            weapontype = weapontype( curweapon.basename );
            
            if ( weapontype == "riotshield" )
            {
                return "";
            }
            
            ismeleeonly = istrue( curweapon.ismelee );
            
            if ( ismeleeonly )
            {
                return "Knife";
            }
            
            islauncher = weaponclass == "rocketlauncher";
            
            if ( islauncher )
            {
                return "Launcher";
            }
            
            ispistol = weaponclass == "pistol";
            
            if ( ispistol )
            {
                return "Pistol";
            }
            
            isshotgun = weaponclass == "spread";
            
            if ( isshotgun )
            {
                return "Shotgun";
            }
            
            issniper = weaponclass == "sniper";
            
            if ( issniper )
            {
                return "Sniper";
            }
        }
    }
    
    return "";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x3ab3a58f, Offset: 0x35ca
// Size: 0x2f, Type: bool
function private function_f0e8d8f1099045cc()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.var_3ae2d0f5046fd077 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x90515c77, Offset: 0x3602
// Size: 0xe2
function private function_a3f6bcdd044bde4a( shotindex )
{
    sceneobjectdata = self;
    rig_disallows = [ "melee", "sprint", "allow_jump", "mantle" ];
    
    if ( !sceneobjectdata function_70903a2d7e1583c7() )
    {
        rig_disallows[ rig_disallows.size ] = "usability";
    }
    
    if ( sceneobjectdata.sceneobject function_3c6fe393ccd02d3c( shotindex ) != "Keep" )
    {
        rig_disallows[ rig_disallows.size ] = "weapon";
    }
    
    if ( !sceneobjectdata.sceneobject function_96ce751feb7dd9c9( shotindex ) )
    {
        rig_disallows[ rig_disallows.size ] = "weapon_switch";
    }
    
    if ( !sceneobjectdata.sceneobject function_b978488b0468bee7( shotindex ) )
    {
        rig_disallows[ rig_disallows.size ] = "offhand_weapons";
        rig_disallows[ rig_disallows.size ] = "offhand_primary_weapons";
        rig_disallows[ rig_disallows.size ] = "offhand_secondary_weapons";
    }
    
    return rig_disallows;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x7797eac, Offset: 0x36ed
// Size: 0x54, Type: bool
function private function_627f3dc4b23c76c3( shotindex )
{
    sceneobjectdata = self;
    shotobject = sceneobjectdata.sceneobject.variant_object.shots[ shotindex ];
    return shotobject.playernoteleport ?? 0;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x2e2a7367, Offset: 0x374a
// Size: 0x42
function private function_f6d96a431ef86a5( enabled, lerptime = 0 )
{
    assert( isplayer( self ) );
    player = self;
    player utility::letterbox_enable( enabled, lerptime );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0xd35601ed, Offset: 0x3794
// Size: 0x9c
function private player_entity_tween( tweenout, duration, hidemodel, stopxcam )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( hidemodel ) || hidemodel )
    {
        player val::set( "scene_scene_xcam", "fire", 0 );
        player thread utility::delaythreadendon( duration + level.framedurationseconds, "disconnect", &val::reset, "scene_scene_xcam", "fire" );
    }
    
    player startcameratween( duration, hidemodel, "ease_inout_sine", 0, stopxcam );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x5866ea9b, Offset: 0x3838
// Size: 0xb6
function private function_335a5029491c4471()
{
    sceneplay = self;
    scenescriptbundle = sceneplay.sceneroot scene_scriptbundle();
    result = [];
    
    foreach ( shotindex in sceneplay.var_eb6d7fbdd0bb47f8 )
    {
        result[ result.size ] = scenescriptbundle function_d74f9d413aca8704( shotindex );
    }
    
    return result;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x1fd73e98, Offset: 0x38f7
// Size: 0x28a
function private function_69e565b8af8a06a2( shotindex )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
    {
        if ( isdefined( scenedata ) && isdefined( var_1d42c5b8ad0adc80[ shotindex ] ) )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            sceneobjectdata.alignmentinfo = scenedata.scenescriptbundle function_83bfd4c94b262c65( sceneroot, shotindex, sceneobjectindex, sceneobjectdata.alignmentinfo );
        }
    }
    
    sceneplay.objectorder = [];
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
    {
        addorder = [];
        
        for ( var_6660094668730fde = sceneobjectindex; isdefined( var_6660094668730fde ) && isdefined( scenedata.sceneobjectdata[ var_6660094668730fde ] ) && !isdefined( sceneplay.objectorder[ var_6660094668730fde ] ) ; var_6660094668730fde = undefined )
        {
            addorder[ addorder.size ] = var_6660094668730fde;
            
            if ( !isdefined( scenedata.sceneobjectdata[ var_6660094668730fde ].alignmentinfo ) )
            {
                scenedata.sceneobjectdata[ var_6660094668730fde ].alignmentinfo = scenedata.scenescriptbundle function_83bfd4c94b262c65( sceneroot, shotindex, sceneobjectindex );
            }
            
            nextindex = scenedata.sceneobjectdata[ var_6660094668730fde ].alignmentinfo.alignobjectindex;
            
            if ( isdefined( nextindex ) && nextindex != var_6660094668730fde )
            {
                var_6660094668730fde = nextindex;
                continue;
            }
        }
        
        for ( i = addorder.size - 1; i >= 0 ; i-- )
        {
            sceneplay.objectorder[ addorder[ i ] ] = sceneplay.var_caf7bc39e6b19dd5[ addorder[ i ] ];
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xcc1249d1, Offset: 0x3b89
// Size: 0x119
function private function_1d07da6ed2bd0f6b( isskipping )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    sceneplay.state = "Playing";
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( sceneobjectdata ) )
        {
            sceneobjectdata.sceneplay = sceneplay;
            sceneobjectdata notify( #"scene_play" );
        }
    }
    
    sceneplay notify( #"scene_play" );
    
    if ( !isskipping )
    {
        sceneplay thread scene_play_wait_skip();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xae9c390f, Offset: 0x3caa
// Size: 0x1e3
function private scene_play_wait_skip()
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    
    if ( !sceneroot function_534c5ebe7d240503() )
    {
        return;
    }
    
    var_b68db5ad6fed6199 = utility::callsharedfunc( #"scene", #"can_skip", sceneroot, sceneplay );
    
    if ( isdefined( var_b68db5ad6fed6199 ) && !var_b68db5ad6fed6199 )
    {
        return;
    }
    
    modefunc = mode_get_func( "modePlayerSkip" );
    
    if ( !isdefined( modefunc ) )
    {
        return;
    }
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isplayer( sceneobjectdata.entity ) )
        {
            sceneobjectdata.entity thread [[ modefunc ]]( sceneplay );
            continue;
        }
        
        if ( sceneobjectdata.sceneobject.variant_type === "Types_XCam" )
        {
            players = sceneobjectdata function_931d12df9abebc7f();
            
            foreach ( player in players )
            {
                player thread [[ modefunc ]]( sceneplay );
            }
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x9b13a2c3, Offset: 0x3e95
// Size: 0x11b
function private function_495a812f7545da04( player, pos )
{
    sceneplay = self;
    assert( isplayer( player ) );
    assert( isvector( pos ) );
    clientnum = player getentitynumber();
    
    if ( !isdefined( sceneplay.prestream.players ) )
    {
        sceneplay.prestream.players = [];
    }
    
    if ( !isdefined( sceneplay.prestream.players[ clientnum ] ) )
    {
        sceneplay.prestream.players[ clientnum ] = spawnstruct();
    }
    
    playerinfo = sceneplay.prestream.players[ clientnum ];
    playerinfo.player = player;
    
    if ( !isdefined( playerinfo.cameraorigins ) )
    {
        playerinfo.cameraorigins = [];
    }
    
    playerinfo.cameraorigins[ playerinfo.cameraorigins.size ] = pos;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x5760540, Offset: 0x3fb8
// Size: 0xe9
function private function_97739bae625d1f27( boolval )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    
    if ( isdefined( sceneroot ) )
    {
        scenedata = sceneroot.scenedata;
    }
    
    if ( !isdefined( scenedata ) )
    {
        return;
    }
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( isdefined( sceneobjectdata ) )
        {
            sceneobjectdata function_5f1315ff984eb193( boolval );
        }
    }
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x6d1dcca6, Offset: 0x40a9
// Size: 0x2e5
function private scene_play_skip( timefromend = 0.5, fadeinouttime = 0.5, fadeholdtime = 0, skipdistribute = 0 )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    sceneroot.isskipping = 1;
    state = sceneroot get_state();
    
    if ( state != "Playing" )
    {
        return;
    }
    
    var_79b71dd6eb150719 = sceneroot function_d1bb58bd28875f50();
    var_79b71dd6eb150719 = function_f943bef551ff028c( var_79b71dd6eb150719 );
    
    if ( fadeinouttime > 0 )
    {
        level notify( #"scene_skip_fade_start" );
        
        foreach ( player in var_79b71dd6eb150719 )
        {
            player notify( #"scene_skip_fade_start" );
            player thread utility::fadetoblackforplayerkeepui( player, 1, fadeinouttime, undefined, "scene_skipping_fade" );
            player val::set( "scene_skipping", "show_hud", 0 );
            player val::set( "scene_skipping", "freezecontrols", 1 );
        }
        
        wait fadeinouttime;
        waitframe();
    }
    
    totalseconds = 0;
    
    foreach ( shotindex in sceneplay.var_eb6d7fbdd0bb47f8 )
    {
        totalseconds += sceneroot function_b38b94c97d1d44c6( sceneplay, shotindex );
    }
    
    if ( totalseconds <= 0 || timefromend >= totalseconds )
    {
        sceneplay thread scene_play_skip_fade_in( 0, var_79b71dd6eb150719, fadeinouttime, fadeholdtime );
        return;
    }
    
    timefrac = ( totalseconds - timefromend ) / totalseconds;
    sceneplay function_4fbd928ce143468f( sceneplay.var_eb6d7fbdd0bb47f8, timefrac, skipdistribute );
    logstring( "====Scene System: " + sceneroot.script_scenescriptbundle + " skip shot anims start" );
    sceneroot scene_play_internal( undefined, sceneplay.var_ec8b7af923c063a9, undefined, timefrac, sceneplay.currentshot, skipdistribute );
    logstring( "====Scene System: " + sceneroot.script_scenescriptbundle + " skip shot anims end" );
    sceneplay thread scene_play_skip_fade_in( 1, var_79b71dd6eb150719, fadeinouttime, fadeholdtime );
    sceneroot function_c17d9607a8faffc3( "callback_skipped" );
    sceneroot function_263a428cb3b06bb6();
    sceneroot.isskipping = undefined;
}

// Namespace scene
// Params 4, eflags: 0xc
// Checksum 0x95bd0db8, Offset: 0x4396
// Size: 0x2cb
function private scene_play_skip_fade_in( skipped, var_79b71dd6eb150719, fadeinouttime, fadeholdtime )
{
    self notify( #"hash_b7480372d1cdd4bf" );
    self endon( #"hash_b7480372d1cdd4bf" );
    assert( isthreaded() );
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    
    if ( !skipped && fadeinouttime > 0 )
    {
        foreach ( player in var_79b71dd6eb150719 )
        {
            player thread utility::fadetoblackforplayerkeepui( player, 0, fadeinouttime, undefined, "scene_skipping_fade" );
        }
    }
    else if ( fadeinouttime > 0 )
    {
        logstring( "====Scene System: " + sceneroot.script_scenescriptbundle + " skipped, waiting for utility::players_stream_wait before fade in" );
        utility::players_stream_wait( var_79b71dd6eb150719 );
        logstring( "====Scene System: " + sceneroot.script_scenescriptbundle + " skipped, utility::players_stream_wait complete, starting fade in" );
        
        if ( isdefined( sceneroot.var_685ee97bdd7a6dda ) )
        {
            fadeholdtime = sceneroot.var_685ee97bdd7a6dda;
        }
        
        if ( fadeholdtime > 0 )
        {
            foreach ( player in var_79b71dd6eb150719 )
            {
                player utility::delaythread( fadeholdtime, &utility::fadetoblackforplayerkeepui, player, 0, fadeinouttime, undefined, "scene_skipping_fade" );
            }
        }
        else
        {
            foreach ( player in var_79b71dd6eb150719 )
            {
                player thread utility::fadetoblackforplayerkeepui( player, 0, fadeinouttime, undefined, "scene_skipping_fade" );
            }
        }
    }
    
    foreach ( player in var_79b71dd6eb150719 )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player val::reset_all( "scene_skipping" );
    }
}

// Namespace scene
// Params 1, eflags: 0xc
// Checksum 0x2be2c79b, Offset: 0x4669
// Size: 0x137
function private player_scene_play_wait_skip( sceneplay )
{
    self notify( #"hash_8b47cfd057e4bef2" );
    self endon( #"hash_8b47cfd057e4bef2" );
    assert( isplayer( self ) );
    player = self;
    player endon( #"death_or_disconnect" );
    sceneplay endon( #"scene_stop" );
    sceneplay endon( #"stopped" );
    player setclientomnvar( "ui_is_bink_skippable", 1 );
    player.var_447f739b52f0598d = 1;
    
    while ( true )
    {
        player waittillmatch( #"luinotifyserver", #"skip_bink_input" );
        
        if ( sceneplay.state != "Playing" || sceneplay.sceneroot.isskipping )
        {
            break;
        }
        
        player.var_447f739b52f0598d = undefined;
        player setclientomnvar( "ui_is_bink_skippable", 0 );
        sceneplay thread scene_play_skip( 0.5, 0.5, 0, !utility::issp() && getdvarint( @"scene_skip_distribute", 1 ) != 0 );
        return;
    }
    
    player.var_447f739b52f0598d = undefined;
    player setclientomnvar( "ui_is_bink_skippable", 0 );
}

// Namespace scene
// Params 1, eflags: 0xc
// Checksum 0xae8eab10, Offset: 0x47a8
// Size: 0x3b
function private function_1dcd5307e18e1464( sceneplay )
{
    self notify( #"hash_710ce1118295eba3" );
    self endon( #"hash_710ce1118295eba3" );
    assert( isplayer( self ) );
    sceneplay thread scene_play_wait_skip_coordinated( self );
}

// Namespace scene
// Params 1, eflags: 0xc
// Checksum 0x2d33c999, Offset: 0x47eb
// Size: 0x24e
function private scene_play_wait_skip_coordinated( player )
{
    self notify( #"hash_1aebb5fd44f990c7" );
    self endon( #"hash_1aebb5fd44f990c7" );
    assert( isplayer( player ) );
    sceneplay = self;
    sceneplay endon( #"scene_skip_abort" );
    sceneplay thread function_f0da178eb06ccf2d( 0 );
    playerentnum = player getentitynumber();
    sceneplay.var_5a749a778d69d623[ playerentnum ] = player;
    waittillframeend();
    
    foreach ( player in sceneplay.var_5a749a778d69d623 )
    {
        player utility::ent_flag_clear( "skip_bink_input" );
        player setclientomnvar( "ui_is_bink_skippable", 1 );
        player setclientomnvar( "ui_player_movie_state", 0 );
        player setclientomnvar( "ui_coop_bink_overlay_state", 4 );
        player.var_447f739b52f0598d = 1;
    }
    
    allskipped = 0;
    var_8eb50b495cebd4b6 = 0;
    
    while ( !allskipped && sceneplay.state == "Playing" )
    {
        allskipped = 1;
        
        foreach ( playerentnum, player in sceneplay.var_5a749a778d69d623 )
        {
            playerskipping = player utility::ent_flag( "skip_bink_input" );
            
            if ( playerskipping )
            {
                var_8eb50b495cebd4b6 |= 1 << playerentnum;
            }
            
            player setclientomnvar( "ui_player_movie_state", var_8eb50b495cebd4b6 );
            allskipped = allskipped && playerskipping;
        }
        
        waitframe();
    }
    
    sceneplay thread function_f0da178eb06ccf2d( 1 );
    
    if ( sceneplay.state == "Playing" )
    {
        sceneplay thread scene_play_skip( 0.5, 0.5, 0.5, !utility::issp() && getdvarint( @"scene_skip_distribute", 1 ) != 0 );
    }
}

// Namespace scene
// Params 1, eflags: 0xc
// Checksum 0x10d85432, Offset: 0x4a41
// Size: 0xfc
function private function_f0da178eb06ccf2d( skippingnow )
{
    self notify( #"hash_e6e04b16ce23ba8e" );
    self endon( #"hash_e6e04b16ce23ba8e" );
    sceneplay = self;
    
    if ( !skippingnow )
    {
        sceneplay utility::waittill_any( "scene_stop", "Stopped" );
        sceneplay notify( #"scene_skip_abort" );
    }
    
    foreach ( player in sceneplay.var_5a749a778d69d623 )
    {
        player utility::ent_flag_clear( "skip_bink_input", 1 );
        player setclientomnvar( "ui_is_bink_skippable", 0 );
        player setclientomnvar( "ui_coop_bink_overlay_state", 0 );
        player.var_447f739b52f0598d = undefined;
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x3594f48a, Offset: 0x4b45
// Size: 0x84
function private function_4fbd928ce143468f( var_eb6d7fbdd0bb47f8, fromtimefrac = 0, skipdistribute = 0 )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    sceneplay.var_a173fd36d9f698cb = undefined;
    
    if ( !isdefined( fromtimefrac ) || fromtimefrac == 0 )
    {
        return;
    }
    
    sceneplay.var_a173fd36d9f698cb = sceneplay function_5dd68723df85d7bb( var_eb6d7fbdd0bb47f8, fromtimefrac, undefined, skipdistribute );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x21ec4d05, Offset: 0x4bd1
// Size: 0x262
function private function_5dd68723df85d7bb( var_eb6d7fbdd0bb47f8, fromtimefrac = 0, includeshotanimations = 0, skipdistribute = 0 )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    var_a173fd36d9f698cb = spawnstruct();
    var_a173fd36d9f698cb.fromtimefrac = clamp( fromtimefrac, 0, 1 );
    var_a173fd36d9f698cb.totaltimesec = 0;
    var_a173fd36d9f698cb.shottimeinfo = [];
    var_a173fd36d9f698cb.skipdistribute = skipdistribute;
    
    foreach ( shotindex in var_eb6d7fbdd0bb47f8 )
    {
        shottimeinfo = spawnstruct();
        shottimeinfo.startsec = var_a173fd36d9f698cb.totaltimesec;
        shottimeinfo.durationsec = sceneroot function_b38b94c97d1d44c6( sceneplay, shotindex );
        var_a173fd36d9f698cb.shottimeinfo[ shotindex ] = shottimeinfo;
        var_a173fd36d9f698cb.totaltimesec += shottimeinfo.durationsec;
        
        if ( includeshotanimations && isdefined( sceneplay.var_caf7bc39e6b19dd5[ shotindex ] ) )
        {
            shottimeinfo.objectanimtimes = [];
            
            for ( i = 0; i < sceneplay.var_caf7bc39e6b19dd5[ shotindex ].size ; i++ )
            {
                sceneobjectindex = sceneplay.var_caf7bc39e6b19dd5[ shotindex ][ i ];
                
                if ( !isdefined( sceneobjectindex ) )
                {
                    continue;
                }
                
                shottimeinfo.objectanimtimes[ sceneobjectindex ] = spawnstruct();
                sceneroot function_6ec994d609cfec6d( sceneplay, shotindex, sceneobjectindex, shottimeinfo.objectanimtimes[ sceneobjectindex ] );
            }
        }
    }
    
    var_a173fd36d9f698cb.fromtimesec = var_a173fd36d9f698cb.totaltimesec * var_a173fd36d9f698cb.fromtimefrac;
    return var_a173fd36d9f698cb;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x76c24605, Offset: 0x4e3c
// Size: 0xdf
function private scene_play_pause( pausestate )
{
    sceneplay = self;
    
    if ( sceneplay.state != "Playing" )
    {
        return;
    }
    
    scenedata = sceneplay.sceneroot.scenedata;
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        sceneobjectdata object_pause( pausestate );
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xa09a9fcd, Offset: 0x4f23
// Size: 0x117
function private function_96bcff884dac620()
{
    if ( getdvarint( @"hash_2f178709e26aa0f4", 0 ) == 1 )
    {
        return "ui_scene_shot_index";
    }
    
    if ( !isdefined( level.available_omnvars ) )
    {
        level.available_omnvars = [];
        level.available_omnvars[ "ui_scene_shot_index" ] = 1;
        level.available_omnvars[ "ui_scene_shot_index_1" ] = 1;
        level.available_omnvars[ "ui_scene_shot_index_2" ] = 1;
        level.available_omnvars[ "ui_scene_shot_index_3" ] = 1;
        level.available_omnvars[ "ui_scene_shot_index_4" ] = 1;
    }
    
    foreach ( omnvar, value in level.available_omnvars )
    {
        if ( value == 1 )
        {
            level.available_omnvars[ omnvar ] = 0;
            return omnvar;
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x993da00b, Offset: 0x5042
// Size: 0x28
function private reset_omnvar( omnvar_name )
{
    if ( isdefined( level.available_omnvars ) )
    {
        level.available_omnvars[ omnvar_name ] = 1;
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xa3b7a1e, Offset: 0x5072
// Size: 0x187
function private scene_shot_omnvars( shotindex )
{
    scenedata = self;
    var_a11daf0a3d76391c = scenedata.sceneroot.scenestatic.exclusiveplayers ?? level.players;
    
    if ( scenedata.sceneroot.scenestatic.var_bc227a74d38bdd36 == 0 )
    {
        return;
    }
    
    omnvar = function_96bcff884dac620();
    assert( omnvar );
    
    foreach ( player in var_a11daf0a3d76391c )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( omnvar, shotindex );
        }
    }
    
    wait 0.5;
    
    foreach ( player in var_a11daf0a3d76391c )
    {
        if ( isdefined( player ) )
        {
            if ( isdefined( omnvar ) )
            {
                player setclientomnvar( omnvar, -1 );
                reset_omnvar( omnvar );
            }
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xc3b644b5, Offset: 0x5201
// Size: 0x3e9
function private scene_shot_play( sceneplay, shotindex )
{
    sceneroot = self;
    success = 1;
    scenedata = sceneroot.scenedata;
    sceneplay.currentshot = shotindex;
    sceneplay function_69e565b8af8a06a2( shotindex );
    sceneroot function_c17d9607a8faffc3( scenedata.scenescriptbundle function_d74f9d413aca8704( shotindex ) );
    
    if ( scenedata.isclientscene )
    {
        sequencekey = sceneroot function_a446556e2efa8a4e( shotindex );
        scenedata thread scene_shot_omnvars( shotindex );
    }
    
    sceneplay function_26af26a461d13032( "prepare", shotindex );
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder )
    {
        if ( isdefined( var_1d42c5b8ad0adc80[ shotindex ] ) )
        {
            sceneroot thread function_d36b9282057340df( sceneplay, "prepare", shotindex, sceneobjectindex );
        }
    }
    
    sceneplay function_5ef9dbff368a95ac( "prepare" );
    
    /#
        var_86d2948ebb49a2f9 = getdvarint( @"hash_36ab188f318b1392", 0 );
        
        if ( var_86d2948ebb49a2f9 )
        {
            scene_shot_play_time_start = gettime();
            
            if ( isdefined( sceneroot.scene_shot_play_time_end ) )
            {
                assert( sceneroot.scene_shot_play_time_end == scene_shot_play_time_start );
                
                if ( sceneroot.scene_shot_play_time_end != scene_shot_play_time_start )
                {
                    here = 0;
                }
            }
            
            sceneroot.scene_shot_play_time_start = scene_shot_play_time_start;
        }
    #/
    
    if ( !sceneplay function_177d435a8fba3dc0() )
    {
        /#
            sceneplay scene_debug::function_ba32edc20462b709( shotindex );
        #/
        
        sceneroot function_11225a57ae9c96b2( sceneplay, shotindex, 1 );
        sceneplay function_26af26a461d13032( "anim", shotindex );
        
        foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder )
        {
            if ( isdefined( var_1d42c5b8ad0adc80[ shotindex ] ) )
            {
                sceneroot thread function_dd772943c28ca228( sceneplay, "anim", shotindex, sceneobjectindex );
            }
        }
        
        shot = sceneroot.scenedata.scenescriptbundle bundle_get_shot( shotindex );
        
        if ( shot function_9f4fd3f147cf9375() )
        {
            currentshotlength = sceneroot function_b3c7b792a7a154fa( shotindex, 1 );
            alignedshotlength = function_ae674e0cc66e65e( currentshotlength );
            
            if ( alignedshotlength > 0 )
            {
                sceneplay utility::delaythread( alignedshotlength, &function_cd7f523143988bf, "anim" );
            }
        }
        
        sceneplay function_5ef9dbff368a95ac( "anim" );
        
        /#
            if ( var_86d2948ebb49a2f9 )
            {
                sceneroot.scene_shot_play_time_end = gettime();
            }
        #/
        
        /#
            sceneplay scene_debug::function_566e3d31befe1331();
        #/
    }
    
    foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.objectorder )
    {
        if ( isdefined( var_1d42c5b8ad0adc80[ shotindex ] ) )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isdefined( sceneobjectdata.playbacksuccessful ) && !sceneobjectdata.playbacksuccessful )
            {
                success = 0;
            }
        }
    }
    
    if ( isdefined( sceneroot.scenedata ) )
    {
        sceneroot function_11225a57ae9c96b2( sceneplay, shotindex, 0 );
    }
    
    sceneplay notify( #"scene_shot_cleanup" );
    return success;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8cb780e9, Offset: 0x55f3
// Size: 0x69
function private function_ae674e0cc66e65e( shot_length )
{
    var_f515c6c2311e98a6 = 50;
    
    if ( level.frameduration > 0 )
    {
        var_f515c6c2311e98a6 = level.frameduration;
    }
    
    lengthms = round( shot_length * 1000 );
    modms = lengthms % var_f515c6c2311e98a6;
    adjustedlength = ( lengthms - modms ) / 1000;
    return adjustedlength;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x28fc71e8, Offset: 0x5665
// Size: 0x94
function private function_b38b94c97d1d44c6( sceneplay, shotindex )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    maxtimesec = 0;
    
    if ( !isdefined( scenedata ) )
    {
        return maxtimesec;
    }
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        objectshottimesec = sceneroot function_6ec994d609cfec6d( sceneplay, shotindex, sceneobjectindex );
        maxtimesec = max( maxtimesec, objectshottimesec );
    }
    
    return maxtimesec;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x50e7caf, Offset: 0x5702
// Size: 0xbf
function private function_11225a57ae9c96b2( sceneplay, shotindex, isprepare )
{
    sceneroot = self;
    shot = sceneroot.scenedata.scriptbundle.shots[ shotindex ];
    
    if ( !isdefined( shot ) )
    {
        return;
    }
    
    if ( isprepare )
    {
        sceneroot function_f4ffc6c74497327f( sceneplay, shotindex, shot function_c9e351e000109356(), &hide );
        sceneroot function_f4ffc6c74497327f( sceneplay, shotindex, shot function_87e703acab37289f(), &show );
        return;
    }
    
    sceneroot function_f4ffc6c74497327f( sceneplay, shotindex, shot function_a694d6b567b8f510(), &hide );
    sceneroot function_f4ffc6c74497327f( sceneplay, shotindex, shot function_6f4f7d54201dbbb(), &show );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x56f7fb0d, Offset: 0x57c9
// Size: 0x145
function private function_f4ffc6c74497327f( sceneplay, shotindex, targetsstring, func )
{
    if ( !isstring( targetsstring ) )
    {
        return;
    }
    
    targets = strtok( targetsstring, " ,;" );
    
    foreach ( targetname in targets )
    {
        foundentities = getentarray( targetname, "targetname" );
        foundentities = arraycombine( foundentities, getentarray( targetname, "script_noteworthy" ) );
        
        foreach ( foundent in foundentities )
        {
            foundent builtin [[ func ]]();
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xd0b4c31d, Offset: 0x5916
// Size: 0xa5
function private function_26af26a461d13032( objecttask, shotindex )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    sceneplay.waitobjects[ objecttask ] = [];
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        if ( isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ][ shotindex ] ) )
        {
            sceneplay.waitobjects[ objecttask ][ sceneobjectindex ] = sceneobjectindex;
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xcfac2920, Offset: 0x59c3
// Size: 0x49
function private function_1b11770bc73d1ce8( objecttask, objectindex )
{
    sceneplay = self;
    
    if ( isdefined( sceneplay.waitobjects[ objecttask ] ) )
    {
        sceneplay.waitobjects[ objecttask ][ objectindex ] = undefined;
    }
    
    sceneplay notify( objecttask );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x76a30fc9, Offset: 0x5a14
// Size: 0x57
function private function_5ef9dbff368a95ac( objecttask )
{
    sceneplay = self;
    
    while ( isdefined( sceneplay.waitobjects[ objecttask ] ) && sceneplay.waitobjects[ objecttask ].size > 0 )
    {
        sceneplay waittill( objecttask );
    }
    
    sceneplay.waitobjects[ objecttask ] = undefined;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8e052184, Offset: 0x5a73
// Size: 0xd8
function private function_cd7f523143988bf( objecttask )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    
    if ( !isdefined( sceneplay ) )
    {
        return;
    }
    
    if ( !isdefined( sceneplay.waitobjects[ objecttask ] ) )
    {
        return;
    }
    
    for ( i = 0; isdefined( sceneplay.waitobjects[ objecttask ] ) && i < sceneplay.waitobjects[ objecttask ].size ; i++ )
    {
        sceneobjectindex = sceneplay.waitobjects[ objecttask ][ i ];
        
        if ( isdefined( sceneobjectindex ) )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            sceneobjectdata object_anim_end();
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe4e3e4a1, Offset: 0x5b53
// Size: 0x169
function private scene_play_stop( is_scripted_stop )
{
    sceneplay = self;
    sceneroot = sceneplay.sceneroot;
    scenedata = sceneroot.scenedata;
    sceneplay.stoprequested = 1;
    sceneplay notify( #"scene_stop" );
    sceneroot notify( #"scene_stop" );
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        if ( isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            sceneroot function_2302629af55b51bd( sceneobjectindex );
        }
    }
    
    waittillframeend();
    
    while ( sceneplay.state == "Playing" )
    {
        anyactive = 0;
        
        for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            if ( isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
            {
                sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
                
                if ( isdefined( sceneobjectdata.active ) )
                {
                    anyactive = 1;
                    break;
                }
            }
        }
        
        if ( !anyactive )
        {
            sceneplay.state = "Stopped";
        }
        
        waitframe();
    }
    
    if ( is_scripted_stop )
    {
        sceneplay scene_play_stop_internal();
    }
    
    sceneplay.stoprequested = undefined;
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x7aba7ae3, Offset: 0x5cc4
// Size: 0x12b
function private function_d36b9282057340df( sceneplay, objecttask, shotindex, objectindex )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    sceneobjectdata = scenedata.sceneobjectdata[ objectindex ];
    
    if ( sceneobjectdata utility::ent_flag( "scene_object_active" ) )
    {
        keepanim = sceneobjectdata.sceneobject function_ac528c4b94dc121f( shotindex );
        sceneroot function_2302629af55b51bd( objectindex, keepanim );
    }
    
    sceneobjectdata utility::ent_flag_waitopen_any( "scene_object_active" );
    sceneobjectdata utility::ent_flag_set( "scene_object_active" );
    animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
    sceneobjectdata.var_caa911de855ae014 = [];
    sceneobjectdata.var_caa911de855ae014[ animtype ] = "prepare" + shotindex + objectindex;
    sceneobjectdata.active = "prepare";
    sceneobjectdata function_4395eb62ee2212b9( 1 );
    sceneobjectdata function_90aaff2103125c26( sceneplay, shotindex, objectindex );
    sceneplay function_1b11770bc73d1ce8( objecttask, objectindex );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x17bc6e, Offset: 0x5df7
// Size: 0x59a
function private function_dd772943c28ca228( sceneplay, objecttask, shotindex, objectindex )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    sceneobjectdata = scenedata.sceneobjectdata[ objectindex ];
    sceneobjectdata.var_caa911de855ae014 = undefined;
    
    if ( !isdefined( sceneobjectdata.active ) )
    {
        sceneplay function_1b11770bc73d1ce8( objecttask, objectindex );
        return;
    }
    
    if ( sceneobjectdata.sceneobject function_8c27db859ca12a4f( shotindex ) )
    {
        sceneplay function_1b11770bc73d1ce8( objecttask, objectindex );
    }
    
    animated = sceneobjectdata function_fd41f2c45f2ff86a();
    cameraanimation = sceneobjectdata function_64466e4b9ed25e4c( shotindex );
    shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
    var_ce31daa306d9074 = isarray( shotanimations ) && shotanimations.size > 0;
    sceneobjectdata function_8207af582343cc24( sceneplay, shotindex, cameraanimation, shotanimations );
    sceneobjectdata.active = "anim";
    sceneobjectdata.playbacksuccessful = 1;
    var_861c4187e5de611f = 0;
    animstartsec = 0;
    lerptime = sceneobjectdata.sceneobject function_27059363c715d947( shotindex );
    blendtime = sceneobjectdata.sceneobject function_1c54677f7be74c59( shotindex );
    blendcurve = sceneobjectdata.sceneobject function_e4fd4fd04ed73e1b( shotindex );
    overridelerp = sceneobjectdata function_aa1705ea1d6cddfa( shotindex, "lerp" );
    overrideblend = sceneobjectdata function_aa1705ea1d6cddfa( shotindex, "blend" );
    
    if ( isdefined( overridelerp ) )
    {
        lerptime = float( overridelerp );
    }
    
    if ( isdefined( overrideblend ) )
    {
        blendtime = float( overrideblend );
    }
    
    sceneobjectdata object_alignment_link( sceneplay, sceneobjectdata.alignmentinfo, "scene_init_play", lerptime, 0 );
    
    if ( animated )
    {
        animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
        
        if ( isdefined( sceneplay.var_a173fd36d9f698cb ) )
        {
            shotdurationsec = sceneroot function_6ec994d609cfec6d( sceneplay, shotindex, objectindex );
            shotstartsec = sceneplay.var_a173fd36d9f698cb.shottimeinfo[ shotindex ].startsec;
            var_861c4187e5de611f = shotstartsec;
            var_b7300a99e9514444 = shotstartsec + shotdurationsec;
            animstartsec = 0;
            
            if ( var_b7300a99e9514444 < sceneplay.var_a173fd36d9f698cb.fromtimesec )
            {
                sceneobjectdata.active = undefined;
                
                if ( var_ce31daa306d9074 )
                {
                    for ( animationindex = 0; animationindex < shotanimations.size ; animationindex++ )
                    {
                        var_2128c2949707fedd = animtype + shotindex + objectindex + animationindex;
                        sceneobjectdata function_1e43ac4c885e2751( sceneobjectdata.alignmentinfo, shotanimations[ animationindex ], var_2128c2949707fedd, 0, 1, animtype, shotindex, animationindex );
                    }
                }
                
                if ( isdefined( cameraanimation ) )
                {
                    var_2128c2949707fedd = animtype + shotindex + objectindex + ( animationindex ?? "" ) + 0;
                    sceneobjectdata function_1e43ac4c885e2751( sceneobjectdata.alignmentinfo, cameraanimation, var_2128c2949707fedd, 0, 1, "CameraAnimation", shotindex, -1 );
                }
                
                sceneobjectdata function_898611fe961dc90d( 0, sceneplay, objecttask, shotindex, objectindex );
                return;
            }
            else
            {
                var_861c4187e5de611f = sceneplay.var_a173fd36d9f698cb.fromtimesec - shotstartsec;
            }
        }
        
        if ( sceneobjectdata.active == "anim" )
        {
            if ( isdefined( cameraanimation ) )
            {
                var_2128c2949707fedd = animtype + shotindex + objectindex + 0;
                var_142c2c5d44216f2a = 0;
                
                if ( isdefined( sceneplay.var_a173fd36d9f698cb ) )
                {
                    var_142c2c5d44216f2a = clamp( var_861c4187e5de611f / sceneobjectdata function_58a93a40f02daed7( shotindex, cameraanimation, "CameraAnimation" ), 0, 1 );
                    sceneobjectdata function_1e43ac4c885e2751( sceneobjectdata.alignmentinfo, cameraanimation, var_2128c2949707fedd, 0, var_142c2c5d44216f2a, "CameraAnimation", shotindex, -1 );
                }
                
                var_35dfbfd4015881b0 = "CameraAnimation" + shotindex + objectindex;
                sceneobjectdata childthread object_play_anim( shotindex, 0, var_35dfbfd4015881b0, sceneobjectdata.alignmentinfo, cameraanimation, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, "CameraAnimation" );
            }
            
            if ( var_ce31daa306d9074 )
            {
                animationindex = 0;
                
                while ( animationindex < shotanimations.size )
                {
                    var_2128c2949707fedd = animtype + shotindex + objectindex + animationindex;
                    var_142c2c5d44216f2a = 0;
                    
                    if ( var_861c4187e5de611f > animstartsec )
                    {
                        animdurationsec = sceneobjectdata function_58a93a40f02daed7( shotindex, shotanimations[ animationindex ], animtype, animationindex );
                        
                        if ( animdurationsec > 0 )
                        {
                            var_142c2c5d44216f2a = clamp( ( var_861c4187e5de611f - animstartsec ) / animdurationsec, 0, 1 );
                            sceneobjectdata function_1e43ac4c885e2751( sceneobjectdata.alignmentinfo, shotanimations[ animationindex ], var_2128c2949707fedd, 0, var_142c2c5d44216f2a, animtype, shotindex, animationindex );
                            
                            if ( var_142c2c5d44216f2a > 1 )
                            {
                                animstartsec += animdurationsec;
                                animationindex++;
                                continue;
                            }
                        }
                        else
                        {
                            animationindex++;
                            continue;
                        }
                    }
                    
                    animdurationsec = sceneobjectdata object_play_anim( shotindex, animationindex, var_2128c2949707fedd, sceneobjectdata.alignmentinfo, shotanimations[ animationindex ], var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animtype );
                    
                    if ( isdefined( animdurationsec ) )
                    {
                        var_861c4187e5de611f += animdurationsec;
                        animstartsec += animdurationsec;
                    }
                    
                    animationindex++;
                    
                    if ( sceneobjectdata.active != "anim" || sceneobjectdata.sceneplay != sceneplay || !isdefined( sceneobjectdata.scenedata ) )
                    {
                        break;
                    }
                }
            }
        }
    }
    
    while ( isdefined( sceneobjectdata.var_caa911de855ae014 ) && sceneobjectdata.var_caa911de855ae014.size > 0 )
    {
        sceneobjectdata waittill( #"scene_anim_ended" );
    }
    
    sceneobjectdata function_898611fe961dc90d( animated, sceneplay, objecttask, shotindex, objectindex );
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xaf7635ec, Offset: 0x6399
// Size: 0xd3
function private function_898611fe961dc90d( animated, sceneplay, objecttask, shotindex, objectindex )
{
    sceneobjectdata = self;
    
    if ( !sceneobjectdata.sceneobject function_af186866fc828d5d() )
    {
        if ( animated && !isdefined( sceneobjectdata.activeanimation ) )
        {
            sceneobjectdata thread object_alignment_unlink_thread( sceneobjectdata.alignmentinfo );
        }
    }
    
    sceneobjectdata function_5a563c79ceb8a795( shotindex );
    
    if ( sceneobjectdata function_fac82f7b6f86f286( sceneplay, shotindex ) )
    {
        sceneobjectdata thread function_745fc41786a6109a( level.framedurationseconds );
    }
    
    if ( sceneobjectdata )
    {
        sceneobjectdata.active = undefined;
        sceneobjectdata utility::ent_flag_clear( "scene_object_active" );
    }
    
    if ( sceneplay )
    {
        sceneplay function_1b11770bc73d1ce8( objecttask, objectindex );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x5b1ade4f, Offset: 0x6474
// Size: 0x6e
function private function_745fc41786a6109a( timer )
{
    sceneobjectdata = self;
    sceneobjectdata endon( #"scene_play" );
    sceneobjectdata endon( #"death_or_disconnect" );
    sceneobjectdata endon( #"stop_delay_thread" );
    
    if ( sceneobjectdata.entity )
    {
        sceneobjectdata.entity endon( #"death_or_disconnect" );
    }
    
    wait timer;
    thread object_cleanup();
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xaef8047, Offset: 0x64ea
// Size: 0xdc, Type: bool
function private function_4b60fcb5255695e6( sceneplay )
{
    sceneobjectdata = self;
    assert( isdefined( sceneplay ) );
    assert( isarray( sceneplay.var_eb6d7fbdd0bb47f8 ) );
    assert( isint( sceneplay.shotindicesindex ) );
    objectindex = sceneobjectdata.index;
    
    if ( !isdefined( sceneplay.var_caf7bc39e6b19dd5[ objectindex ] ) )
    {
        return false;
    }
    
    for ( sceneplayshotindex = sceneplay.shotindicesindex + 1; sceneplayshotindex < sceneplay.var_eb6d7fbdd0bb47f8.size ; sceneplayshotindex++ )
    {
        var_62e26c87a288f764 = sceneplay.var_eb6d7fbdd0bb47f8[ sceneplayshotindex ];
        
        if ( isdefined( sceneplay.var_caf7bc39e6b19dd5[ objectindex ][ var_62e26c87a288f764 ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xdcef4f81, Offset: 0x65cf
// Size: 0x189, Type: bool
function private function_fac82f7b6f86f286( sceneplay, shotindex )
{
    sceneobjectdata = self;
    sceneroot = sceneobjectdata.sceneroot;
    scenedata = sceneroot.scenedata;
    
    if ( !isdefined( scenedata ) )
    {
        return true;
    }
    
    if ( sceneplay != sceneobjectdata.sceneplay )
    {
        return false;
    }
    
    if ( isdefined( sceneobjectdata.activeanimation ) )
    {
        return false;
    }
    
    if ( sceneroot.scenedata.scenescriptbundle && sceneroot.scenedata.scenescriptbundle function_18b6837bdb9e4208() )
    {
        return false;
    }
    
    if ( sceneobjectdata && !sceneobjectdata function_fd41f2c45f2ff86a() )
    {
        return false;
    }
    
    if ( !sceneplay.var_eb6d7fbdd0bb47f8 || sceneplay.var_eb6d7fbdd0bb47f8.size == 0 || shotindex == sceneplay.var_eb6d7fbdd0bb47f8[ sceneplay.var_eb6d7fbdd0bb47f8.size - 1 ] )
    {
        return true;
    }
    
    if ( sceneobjectdata.sceneobject )
    {
        deletetype = sceneobjectdata.sceneobject function_772de5acb2e194c7();
        
        if ( sceneobjectdata.sceneobject obj_get_type() == "Types_XCam" || deletetype == "DeleteAlwaysNotInvolved" || deletetype == "DeleteSpawnedNotInvolved" && !sceneobjectdata.existingentity )
        {
            if ( !sceneobjectdata function_4b60fcb5255695e6( sceneplay ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0xc633bfee, Offset: 0x6761
// Size: 0x19d
function private function_6ec994d609cfec6d( sceneplay, shotindex, objectindex, resultobjectanimtimes )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    sceneobjectdata = scenedata.sceneobjectdata[ objectindex ];
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return;
    }
    
    if ( isdefined( sceneplay.var_a173fd36d9f698cb ) && isdefined( sceneplay.var_a173fd36d9f698cb.shottimeinfo[ shotindex ] ) )
    {
        return sceneplay.var_a173fd36d9f698cb.shottimeinfo[ shotindex ].durationsec;
    }
    
    deltatimesec = 0;
    cameratimesec = 0;
    cameraanimation = sceneobjectdata function_64466e4b9ed25e4c( shotindex );
    
    if ( isdefined( cameraanimation ) )
    {
        cameratimesec = sceneobjectdata function_58a93a40f02daed7( shotindex, cameraanimation, "CameraAnimation" );
    }
    
    animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
    shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
    
    for ( animationindex = 0; animationindex < shotanimations.size ; animationindex++ )
    {
        animtime = sceneobjectdata function_58a93a40f02daed7( shotindex, shotanimations[ animationindex ], animtype, animationindex );
        
        if ( isdefined( resultobjectanimtimes ) )
        {
            if ( !isdefined( resultobjectanimtimes.times ) )
            {
                resultobjectanimtimes.times = [];
            }
            
            resultobjectanimtimes.times[ animationindex ] = animtime;
        }
        
        deltatimesec += animtime;
    }
    
    return max( cameratimesec, deltatimesec );
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x5411d399, Offset: 0x6907
// Size: 0xa2
function private function_2302629af55b51bd( sceneobjectindex, keepanim = 0 )
{
    sceneroot = self;
    scenedata = sceneroot.scenedata;
    sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
    sceneobjectdata.active = undefined;
    sceneobjectdata.playbacksuccessful = 0;
    sceneobjectdata notify( #"scene_stop" );
    sceneobjectdata object_anim_end();
    
    if ( !keepanim )
    {
        sceneobjectdata function_2d0d8b2ed2c4709a();
    }
    
    sceneobjectdata utility::ent_flag_clear( "scene_object_active" );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xadfe9a70, Offset: 0x69b1
// Size: 0x1c6
function private scene_set_state( newstate )
{
    sceneroot = self;
    assert( newstate != "<dev string:x86>" );
    assert( newstate != "<dev string:x8e>" );
    
    if ( isdefined( sceneroot.scenedata ) && sceneroot.scenedata.state != newstate )
    {
        if ( newstate != "NotInit" )
        {
            sceneroot.scenedata.state = newstate;
            sceneroot function_7ae4ca45fe9ff944( sceneroot.scenedata.state );
            return;
        }
        
        assert( sceneroot.scenedata.state == "<dev string:x96>" );
        
        if ( isdefined( sceneroot.scenedata.sceneobjectdata ) && isdefined( sceneroot.scenedata.scenescriptbundle ) )
        {
            objectcount = sceneroot.scenedata.scenescriptbundle function_bd663a9606d90ac1();
            
            if ( isdefined( objectcount ) )
            {
                for ( objectindex = 0; objectindex < objectcount ; objectindex++ )
                {
                    if ( objectindex < sceneroot.scenedata.sceneobjectdata.size )
                    {
                        sceneroot.scenedata.sceneobjectdata[ objectindex ].scenedata = undefined;
                    }
                }
            }
        }
        
        utility::function_cacdd05a312a4bf0( sceneroot.scenedata.scriptbundle );
        
        /#
            sceneroot scene_debug::unregister();
        #/
        
        sceneroot.scenedata.sceneroot = undefined;
        sceneroot.scenedata = undefined;
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x759a21f1, Offset: 0x6b7f
// Size: 0xbc
function private function_7ae4ca45fe9ff944( state )
{
    sceneroot = self;
    
    if ( isdefined( sceneroot.scenestatic ) && isdefined( sceneroot.scenestatic.notifyobject ) && isdefined( sceneroot.scenestatic.notifyevent ) )
    {
        if ( !isdefined( sceneroot.scenestatic.notifymatch ) || sceneroot.scenestatic.notifymatch == state )
        {
            sceneroot.scenestatic.notifyobject notify( sceneroot.scenestatic.notifyevent );
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xb210dbf3, Offset: 0x6c43
// Size: 0x1a
function private scene_scriptbundle_name()
{
    sceneroot = self;
    return sceneroot.script_scenescriptbundle;
}

// Namespace scene
// Params 0
// Checksum 0x6a0c3be7, Offset: 0x6c66
// Size: 0x98
function scene_scriptbundle()
{
    sceneroot = self;
    sceneroot function_b4cfd3b6e6f6987d();
    
    if ( !isdefined( sceneroot.scenedata.scriptbundle ) )
    {
        scenescriptbundlename = sceneroot scene_scriptbundle_name();
        
        if ( isdefined( scenescriptbundlename ) )
        {
            sceneroot.scenedata.scriptbundle = utility::function_dc226e1c2f06ea0b( isxhashasset( scenescriptbundlename ) ? scenescriptbundlename : hashcat( %"scenescriptbundle:", scenescriptbundlename ) );
        }
    }
    
    return sceneroot.scenedata.scriptbundle;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x645c57f, Offset: 0x6d07
// Size: 0x70
function private function_3a06b41e384fbf58( typename, funcname, func )
{
    function_9faf48fca9716acd();
    
    if ( !isdefined( level.scene.objecthandlers[ typename ] ) )
    {
        level.scene.objecthandlers[ typename ] = [];
    }
    
    level.scene.objecthandlers[ typename ][ funcname ] = func;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1c964862, Offset: 0x6d7f
// Size: 0x2fb
function private function_a8d91578e2556475()
{
    assert( isdefined( level.scene.objecthandlers ) );
    assert( isdefined( level.scene.objecthandlers[ "<dev string:x9f>" ] ) );
    assert( !isdefined( level.scene.var_503e815140d769a6 ) );
    level.scene.var_503e815140d769a6 = [];
    var_7348ab4794f6ea97 = [ "Types_Object", "Types_Prop", "Types_Actor", "Types_Player", "Types_EnemyPlayer", "Types_FakePlayer", "Types_FakeActor", "Types_Vehicle", "Types_Mayhem", "Types_XCam", "Types_ClientChar" ];
    
    foreach ( sceneobjecttype in var_7348ab4794f6ea97 )
    {
        level.scene.var_503e815140d769a6[ sceneobjecttype ] = [];
        
        foreach ( functype, func in level.scene.objecthandlers[ "Types_Object" ] )
        {
            level.scene.var_503e815140d769a6[ sceneobjecttype ][ functype ] = func;
        }
    }
    
    foreach ( sceneobjecttype, functable in level.scene.objecthandlers )
    {
        if ( sceneobjecttype == "Types_Object" )
        {
            continue;
        }
        
        foreach ( functype, func in functable )
        {
            level.scene.var_503e815140d769a6[ sceneobjecttype ][ functype ] = func;
        }
    }
    
    level.scene.objecthandlers = undefined;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x26335098, Offset: 0x7082
// Size: 0x5f
function private function_8eae84e23a4f5614( funcname, func )
{
    function_9faf48fca9716acd();
    
    if ( !isdefined( level.scene.modehandlers ) )
    {
        level.scene.modehandlers = [];
    }
    
    level.scene.modehandlers[ funcname ] = func;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xad6096d6, Offset: 0x70e9
// Size: 0x4a
function private mode_get_func( functype )
{
    typefunc = undefined;
    
    if ( isdefined( level.scene.modehandlers ) )
    {
        typefunc = level.scene.modehandlers[ functype ];
    }
    
    return typefunc;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9d4bb5dc, Offset: 0x713c
// Size: 0x18
function private object_get_func( functype )
{
    return self.functable[ functype ];
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x8dd8864b, Offset: 0x715d
// Size: 0x39e
function private object_spawn( alignmentinfo, shotinit )
{
    sceneobjectdata = self;
    scenestatic = sceneobjectdata.sceneroot.scenestatic;
    entity = undefined;
    sceneobjecttype = sceneobjectdata.sceneobject obj_get_type();
    sceneobjectassettype = sceneobjectdata.sceneobject function_fc09a0af0b50d3d4();
    sceneobjectassetname = sceneobjectdata.sceneobject function_ccb2b599f3b8ef77();
    sceneobjectname = sceneobjectdata.sceneobject obj_get_name();
    spawnorigin = alignmentinfo.origin;
    spawnangles = alignmentinfo.angles;
    
    if ( isdefined( shotinit ) )
    {
        shotanimations = sceneobjectdata function_6bf501072826e845( shotinit );
        
        if ( isdefined( shotanimations ) && shotanimations.size > 0 && isanimation( shotanimations[ 0 ] ) )
        {
            spawnorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, shotanimations[ 0 ] );
            spawnangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, shotanimations[ 0 ] );
        }
    }
    
    /#
        scene_debug::object_event( sceneobjectdata, "<dev string:xac>", spawnorigin, spawnangles );
    #/
    
    typefunc = sceneobjectdata object_get_func( "objectSpawn" );
    
    if ( isdefined( typefunc ) && typefunc != &object_spawn )
    {
        entity = sceneobjectdata [[ typefunc ]]( spawnorigin, spawnangles );
    }
    
    if ( !isdefined( entity ) )
    {
        entity = sceneobjectdata object_spawn_generic( spawnorigin, spawnangles );
    }
    
    /#
        if ( !isdefined( entity ) )
        {
            if ( sceneobjecttype != "<dev string:xb2>" && sceneobjecttype != "<dev string:xbf>" )
            {
                println( "<dev string:xca>" + sceneobjectname + "<dev string:xf0>" + sceneobjectassettype + "<dev string:xfa>" + sceneobjectassetname + "<dev string:x50>" );
            }
        }
    #/
    
    if ( isdefined( entity ) && isdefined( scenestatic ) && isdefined( scenestatic.spawnfunctions ) && !isplayer( entity ) )
    {
        entity.sceneobjectdata = sceneobjectdata;
        checktables = [ sceneobjectname, sceneobjecttype, "_object_all_" ];
        
        foreach ( tablename in checktables )
        {
            if ( isdefined( scenestatic.spawnfunctions[ tablename ] ) )
            {
                foreach ( spawnfunc in scenestatic.spawnfunctions[ tablename ] )
                {
                    entity thread [[ spawnfunc ]]();
                }
            }
        }
    }
    
    if ( isdefined( entity ) )
    {
        switch ( sceneobjectdata.sceneobject function_37b12fc2df71936b() )
        {
            case #"hash_5a532485943b3d4b":
                entity.targetname = "_scene_global_" + sceneobjectname;
                break;
            case #"hash_6d8a4db48060bf8":
                entity.script_noteworthy = "_scene_global_" + sceneobjectname;
                break;
        }
    }
    
    return entity;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x7a2b1555, Offset: 0x7504
// Size: 0x250
function private object_spawn_generic( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    entity = undefined;
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    sceneobjectassettype = sceneobjectdata.sceneobject function_fc09a0af0b50d3d4();
    sceneobjectassetname = sceneobjectdata.sceneobject function_ccb2b599f3b8ef77();
    spawnflags = 0;
    
    if ( sceneobjectdata.sceneobject function_16e90b61b72fb539() || scenescriptbundle function_26e347b43304e05e() )
    {
        spawnflags |= 2147483648;
    }
    
    if ( sceneobjectassettype == "xmodel" || sceneobjectassettype == "xcompositemodel" )
    {
        entity = spawn( "script_model", spawnorigin, spawnflags );
        
        if ( isdefined( entity ) )
        {
            entity val::set( "scene_scene", "cinematics_participant", 1 );
            entity.angles = spawnangles;
            entity setmodel( sceneobjectassetname );
            animtree = sceneobjectdata.sceneobject function_4641057744100c08();
            
            if ( isdefined( animtree ) )
            {
                entity useanimtree( animtree );
            }
            
            entity visibility_mode::function_db9ed9dc5c19305b();
        }
    }
    else if ( sceneobjectassettype == "character" )
    {
        character = getxhashasset( sceneobjectassetname );
        
        if ( function_df63e3c9842e8497( character ) )
        {
            entity = spawn( "script_model", spawnorigin, spawnflags );
            
            if ( isdefined( entity ) )
            {
                entity val::set( "scene_scene", "cinematics_participant", 1 );
                entity setcharacter( character );
                entity.angles = spawnangles;
                animtree = sceneobjectdata.sceneobject function_4641057744100c08();
                
                if ( isdefined( animtree ) )
                {
                    entity useanimtree( animtree );
                }
                
                entity visibility_mode::function_db9ed9dc5c19305b();
            }
        }
    }
    
    if ( sceneobjectassettype == "bulletweapon" )
    {
        weaponVariantID = sceneobjectdata.sceneobject function_6280c600ae0d180d();
        weapon = weapon::giveweaponblueprint( sceneobjectassetname, weaponVariantID );
        name = getcompleteweaponname( weapon );
        entity = spawn( "weapon_" + name, spawnorigin, spawnflags );
        
        if ( isdefined( entity ) )
        {
            entity val::set( "scene_scene", "cinematics_participant", 1 );
            entity.angles = spawnangles;
        }
    }
    
    return entity;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xed3ba2db, Offset: 0x775d
// Size: 0x18c
function private function_4395eb62ee2212b9( visible = 1 )
{
    sceneobjectdata = self;
    
    if ( !visible )
    {
        entities = sceneobjectdata function_f2fb9eed776f75ff();
        
        if ( isarray( entities ) )
        {
            foreach ( entity in entities )
            {
                if ( !isdefined( entity ) || isplayer( entity ) )
                {
                    continue;
                }
                
                entity val::set( "scene_scene", "hide", 2 );
            }
        }
        
        sceneobjectdata.prestreamhidden = 1;
        return;
    }
    
    if ( sceneobjectdata.prestreamhidden )
    {
        entities = sceneobjectdata function_f2fb9eed776f75ff();
        
        if ( isarray( entities ) )
        {
            foreach ( entity in entities )
            {
                if ( !isdefined( entity ) )
                {
                    continue;
                }
                
                entity val::reset( "scene_scene", "hide" );
            }
        }
        
        sceneobjectdata.prestreamhidden = undefined;
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x50e1590, Offset: 0x78f1
// Size: 0x8a
function private function_71ee00d5cd22094( newsceneroot )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata ) )
    {
        return;
    }
    
    if ( isdefined( sceneobjectdata.sceneplay ) && isdefined( sceneobjectdata.active ) )
    {
        sceneobjectdata.sceneplay function_1b11770bc73d1ce8( sceneobjectdata.active, sceneobjectdata.index );
    }
    
    sceneobjectdata object_anim_end();
    sceneobjectdata object_cleanup( newsceneroot, 1 );
    sceneobjectdata utility::ent_flag_clear( "scene_object_active" );
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0x31814659, Offset: 0x7983
// Size: 0x133
function private object_set_entity( sceneroot, sceneplay, entity, existing, inittype )
{
    sceneobjectdata = self;
    
    if ( isdefined( entity ) && isdefined( entity.sceneobjectdata ) && sceneplay != entity.sceneobjectdata.sceneplay )
    {
        if ( inittype != "scene_init_prestream" && entity.sceneobjectdata != sceneobjectdata )
        {
            entity.sceneobjectdata function_71ee00d5cd22094( sceneroot );
        }
    }
    
    if ( isent( sceneobjectdata.entity ) )
    {
        if ( sceneobjectdata.entity === entity )
        {
            if ( !isdefined( sceneobjectdata.var_878130757a0f3a61 ) || !isdefined( sceneobjectdata.var_c4d701311a34bc3c ) )
            {
                sceneobjectdata function_8a371c59effcd21c();
            }
            
            return;
        }
        
        if ( !sceneobjectdata.existingentity )
        {
            sceneobjectdata object_cleanup();
            sceneobjectdata object_delete();
        }
    }
    
    sceneobjectdata.entity = entity;
    sceneobjectdata.existingentity = existing;
    sceneobjectdata function_8a371c59effcd21c();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf874e873, Offset: 0x7abe
// Size: 0x52
function private function_8a371c59effcd21c()
{
    sceneobjectdata = self;
    sceneobjectdata.animaltname = undefined;
    sceneobjectdata function_f4987f63f155f33c();
    typefunc = sceneobjectdata object_get_func( "objectSetAltAnim" );
    
    if ( isdefined( typefunc ) && typefunc != &function_8a371c59effcd21c )
    {
        sceneobjectdata [[ typefunc ]]();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x5ce29637, Offset: 0x7b18
// Size: 0x275
function private function_f4987f63f155f33c()
{
    sceneobjectdata = self;
    
    if ( !isdefined( level.var_d567d20efe43f69d ) )
    {
        return;
    }
    
    if ( !sceneobjectdata function_50783d2cc546cd35() )
    {
        sceneobjectdata.var_878130757a0f3a61 = undefined;
        sceneobjectdata.var_c4d701311a34bc3c = undefined;
        return;
    }
    
    operatormap = level.var_d567d20efe43f69d;
    var_713f3d50dd72d64d = undefined;
    var_4661295767965664 = undefined;
    operatorref = undefined;
    sceneobjectdata.var_878130757a0f3a61 = undefined;
    sceneobjectdata.var_c4d701311a34bc3c = undefined;
    
    if ( !utility::function_1e6de0f4874e10be( sceneobjectdata.sceneobject.variant_object.operatorskinname ) )
    {
        var_be654af98d11ae80 = getxhashasset( sceneobjectdata.sceneobject.variant_object.operatorskinname );
        var_713f3d50dd72d64d = operatormap[ var_be654af98d11ae80 ];
        
        if ( isdefined( var_713f3d50dd72d64d ) )
        {
            var_4661295767965664 = var_be654af98d11ae80;
        }
    }
    
    if ( isdefined( sceneobjectdata.entity ) && isdefined( sceneobjectdata.entity.operatorcustomization ) )
    {
        operatorcustomization = sceneobjectdata.entity.operatorcustomization;
        var_53e49a4ca5af0681 = operatorcustomization.operatorref;
        var_537b36d651d8b39a = operatorcustomization.skinref;
        
        if ( isstring( var_53e49a4ca5af0681 ) )
        {
            var_53e49a4ca5af0681 = getxhashasset( var_53e49a4ca5af0681 );
        }
        
        if ( isstring( var_537b36d651d8b39a ) )
        {
            var_537b36d651d8b39a = getxhashasset( var_537b36d651d8b39a );
        }
        
        if ( !utility::function_1e6de0f4874e10be( var_53e49a4ca5af0681 ) )
        {
            operatorref = var_53e49a4ca5af0681;
        }
        
        if ( !utility::function_1e6de0f4874e10be( var_537b36d651d8b39a ) && !isdefined( var_713f3d50dd72d64d ) )
        {
            var_713f3d50dd72d64d = operatormap[ var_537b36d651d8b39a ];
            
            if ( isdefined( var_713f3d50dd72d64d ) )
            {
                var_4661295767965664 = var_537b36d651d8b39a;
            }
        }
    }
    
    if ( !isdefined( var_713f3d50dd72d64d ) && isdefined( sceneobjectdata.entity ) )
    {
        bodymodel = sceneobjectdata.entity.bodymodelname;
        headmodel = sceneobjectdata.entity.headmodel;
        var_713f3d50dd72d64d = function_32922fd7d38aaa18( operatorref, bodymodel, headmodel );
        
        if ( isdefined( var_713f3d50dd72d64d ) )
        {
            var_4661295767965664 = var_713f3d50dd72d64d.operatorskinname;
        }
    }
    
    if ( isdefined( var_713f3d50dd72d64d ) )
    {
        sceneobjectdata.var_878130757a0f3a61 = var_713f3d50dd72d64d.operatorname;
        
        if ( isdefined( var_4661295767965664 ) )
        {
            sceneobjectdata.var_c4d701311a34bc3c = var_4661295767965664;
        }
        
        return;
    }
    
    if ( isdefined( operatorref ) )
    {
        sceneobjectdata.var_878130757a0f3a61 = operatorref;
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xd683da81, Offset: 0x7d95
// Size: 0x19d
function private function_50783d2cc546cd35()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.var_2addba4672ca0b36 ) )
    {
        return sceneobjectdata.var_2addba4672ca0b36;
    }
    
    hascustom = 0;
    variantobject = sceneobjectdata.sceneobject.variant_object;
    
    if ( isdefined( variantobject ) && isdefined( variantobject.shots ) )
    {
        foreach ( shot in variantobject.shots )
        {
            if ( !isdefined( shot.deltaanimations ) )
            {
                continue;
            }
            
            foreach ( deltaanim in shot.deltaanimations )
            {
                if ( isdefined( deltaanim.var_a629058043fe3322 ) && deltaanim.var_a629058043fe3322.size > 0 )
                {
                    hascustom = 1;
                    break;
                }
            }
            
            if ( hascustom )
            {
                break;
            }
        }
    }
    
    sceneobjectdata.var_2addba4672ca0b36 = hascustom;
    return hascustom;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xcb941a84, Offset: 0x7f3b
// Size: 0x31e
function private object_setup( sceneplay )
{
    sceneobjectdata = self;
    sceneobjectdata.sceneplay = sceneplay;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
        sceneobjectname = sceneobjectdata.sceneobject obj_get_name();
        sceneobjecttree = sceneobjectdata.sceneobject function_4641057744100c08();
        sceneobjectdata function_6eed58b13f778351( sceneobjectname, sceneobjecttree );
        sceneobjectdata function_f4987f63f155f33c();
        
        if ( !isdefined( sceneobjectdata.restoredontmelee ) )
        {
            sceneobjectdata.restoredontmelee = sceneobjectdata.entity.dontmelee;
        }
        
        sceneobjectdata.entity.dontmelee = 1;
        sceneobjectdata.entity utility::ent_flag_set( "scene_active" );
        
        if ( isplayer( sceneobjectdata.entity ) )
        {
            if ( sceneobjectdata.scenedata.scenescriptbundle function_7f138cc8a9e70cf4() )
            {
                sceneobjectdata.entity val::set( "scene_scene", "show_hud", 0 );
            }
        }
        
        if ( scenescriptbundle function_4ce73dcda6de9f22() == "AllObjects" )
        {
            sceneobjectdata.entity val::set( "scene_scene", "high_net_lod", 1 );
        }
        
        if ( scenescriptbundle function_a9260c3d77b784c3() == "UseCurrentTime" )
        {
            sceneobjectdata.entity val::set( "scene_scene", "anim_current_time", 1 );
        }
        
        objtype = sceneobjectdata.sceneobject obj_get_type();
        gameplay = sceneobjectdata.sceneroot function_de0c3faf7f92b366();
        values = level.scene.values[ objtype ][ gameplay ];
        
        if ( isdefined( values ) )
        {
            foreach ( valname, value in values )
            {
                sceneobjectdata.entity val::set( "scene_scene", valname, value );
            }
        }
        
        if ( !gameplay && isplayer( sceneobjectdata.entity ) )
        {
            sceneobjectdata.entity val::set( "scene_scene", "allow_ping", 0 );
        }
    }
    
    typefunc = sceneobjectdata object_get_func( "objectSetup" );
    
    if ( isdefined( typefunc ) && typefunc != &object_setup )
    {
        sceneobjectdata [[ typefunc ]]( sceneplay );
    }
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity.sceneobjectdata = sceneobjectdata;
    }
    
    sceneobjectdata.issetup = 1;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x9b73ccae, Offset: 0x8261
// Size: 0x1a0
function private function_6eed58b13f778351( animname, animtree )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.entity ) )
    {
        return;
    }
    
    typefunc = sceneobjectdata object_get_func( "objectSetAnimName" );
    
    if ( isdefined( typefunc ) && typefunc != &function_6eed58b13f778351 )
    {
        sceneobjectdata [[ typefunc ]]( animname, animtree );
        return;
    }
    
    if ( isdefined( animname ) )
    {
        if ( !isplayer( sceneobjectdata.entity ) && isdefined( animtree ) && ( !isdefined( sceneobjectdata.entity.animtree ) || sceneobjectdata.entity.animtree == "" ) )
        {
            if ( !isdefined( sceneobjectdata.animtreeprevious ) )
            {
                sceneobjectdata.animtreeprevious = sceneobjectdata.entity.animtree;
            }
            
            currentanimtree = undefined;
            
            if ( sceneobjectdata.entity isusinganimtree() )
            {
                currentanimtree = getanimtreeid( sceneobjectdata.entity );
            }
            
            if ( animtree != currentanimtree )
            {
                sceneobjectdata.entity useanimtree( animtree );
            }
        }
        
        if ( !isdefined( sceneobjectdata.entity.animname ) )
        {
            sceneobjectdata.entity.animname = animname;
        }
        
        return;
    }
    
    if ( isdefined( sceneobjectdata.animtreeprevious ) )
    {
        sceneobjectdata.entity useanimtree( sceneobjectdata.animtreeprevious );
    }
    
    sceneobjectdata.animtreeprevious = undefined;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x98c0df33, Offset: 0x8409
// Size: 0x74
function private function_4a9835edd174d8e3( animasset )
{
    sceneobjectdata = self;
    sceneobjectdata.activeanimationplaying = undefined;
    typefunc = sceneobjectdata object_get_func( "objectSetAnimPlaying" );
    
    if ( isdefined( typefunc ) && typefunc != &function_4a9835edd174d8e3 )
    {
        sceneobjectdata [[ typefunc ]]( animasset );
        return;
    }
    
    sceneobjectdata.activeanimationplaying = animasset;
    sceneobjectdata notify( #"scene_anim_playing", animasset );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x3b606308, Offset: 0x8485
// Size: 0x1a3
function private function_5f1315ff984eb193( boolval )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectParticipatingCinematics" );
    
    if ( isdefined( typefunc ) && typefunc != &function_5f1315ff984eb193 )
    {
        sceneobjectdata [[ typefunc ]]( boolval );
        return;
    }
    
    entities = sceneobjectdata function_f2fb9eed776f75ff();
    
    if ( isplayer( sceneobjectdata.entity ) && !arraycontains( entities, sceneobjectdata.entity ) && sceneobjectdata function_fd41f2c45f2ff86a() )
    {
        if ( boolval )
        {
            sceneobjectdata.entity val::set( "scene_scene", "allow_toggle_third_person", 0 );
        }
        else
        {
            sceneobjectdata.entity val::reset( "scene_scene", "allow_toggle_third_person" );
        }
    }
    
    if ( isarray( entities ) )
    {
        foreach ( entity in entities )
        {
            if ( isent( entity ) )
            {
                if ( boolval )
                {
                    entity val::set( "scene_scene", "cinematics_participant", 1 );
                    entity val::set( "scene_scene", "allow_toggle_third_person", 0 );
                    continue;
                }
                
                entity val::reset( "scene_scene", "cinematics_participant" );
                entity val::reset( "scene_scene", "allow_toggle_third_person" );
            }
        }
    }
}

// Namespace scene
// Params 4, eflags: 0x44 variadic
// Checksum 0xdf1cce96, Offset: 0x8630
// Size: 0x43
function private function_2b192928688bd1d( endonevent, func, ... )
{
    sceneobjectdata = self;
    sceneobjectdata thread function_f1d6d9665bdaca0a( endonevent, func, flat_args( vararg, varargcount ) );
}

// Namespace scene
// Params 4, eflags: 0x44 variadic
// Checksum 0xd9b7dde0, Offset: 0x867b
// Size: 0x108
function private function_f1d6d9665bdaca0a( endonevent, func, ... )
{
    sceneobjectdata = self;
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( sceneobjectdata.activeanimationplaying ) )
    {
        entity endon( #"death_or_disconnect" );
        
        if ( isdefined( endonevent ) )
        {
            if ( !isarray( endonevent ) )
            {
                endonevent = [ endonevent ];
            }
            
            foreach ( endonname in endonevent )
            {
                entity endon( endonname );
            }
        }
        
        sceneobjectdata waittill( #"scene_anim_playing" );
    }
    
    entity builtin [[ func ]]( flat_args( vararg, varargcount ) );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe12660d1, Offset: 0x878b
// Size: 0xa8
function private function_909c00577c56aa35( animrate )
{
    sceneobjectdata = self;
    
    if ( !isdefined( animrate ) )
    {
        animrate = 1;
    }
    
    typefunc = sceneobjectdata object_get_func( "objectSetAnimRate" );
    
    if ( isdefined( typefunc ) && typefunc != &function_909c00577c56aa35 )
    {
        sceneobjectdata [[ typefunc ]]( animrate );
        return;
    }
    
    if ( isdefined( sceneobjectdata.activeanimation ) && sceneobjectdata.activeanimationtype == "DeltaAnimation" )
    {
        entity = sceneobjectdata function_15e572f4ed82dd1c();
        
        if ( isdefined( entity ) )
        {
            entity setanimrate( sceneobjectdata.activeanimation, animrate );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x4cdb0277, Offset: 0x883b
// Size: 0x8b
function private function_4c574c265ff9cd1e( animasset, timefrac )
{
    sceneobjectdata = self;
    
    if ( !isdefined( timefrac ) )
    {
        timefrac = 0;
    }
    
    typefunc = sceneobjectdata object_get_func( "objectSetAnimTime" );
    
    if ( isdefined( typefunc ) && typefunc != &function_4c574c265ff9cd1e )
    {
        sceneobjectdata [[ typefunc ]]( animasset, timefrac );
        return;
    }
    
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( isdefined( entity ) )
    {
        entity setanimtime( animasset, timefrac );
        entity dontinterpolate();
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x26d9c1ef, Offset: 0x88ce
// Size: 0x106
function private function_51d450f220b5b126( lerptime, velocity )
{
    sceneobjectdata = self;
    
    if ( !isdefined( lerptime ) )
    {
        lerptime = 0;
    }
    
    if ( !isdefined( velocity ) )
    {
        velocity = ( 0, 0, 0 );
    }
    
    waittillframeend();
    typefunc = sceneobjectdata object_get_func( "objectSetAnimLerp" );
    
    if ( isdefined( typefunc ) && typefunc != &function_51d450f220b5b126 )
    {
        sceneobjectdata [[ typefunc ]]( lerptime, velocity );
        return;
    }
    
    entities = sceneobjectdata function_f2fb9eed776f75ff();
    
    foreach ( entity in entities )
    {
        if ( isanimscripted( entity ) )
        {
            entity animscripted_blendin( lerptime, velocity, undefined, 1 );
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xf9ec3267, Offset: 0x89dc
// Size: 0x119
function private function_836a2a9d9ba59594( enabled )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectSetProcBones" );
    
    if ( isdefined( typefunc ) && typefunc != &function_836a2a9d9ba59594 )
    {
        sceneobjectdata [[ typefunc ]]( enabled );
        return;
    }
    
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    proc_node = undefined;
    
    if ( isdefined( entity.animtree ) )
    {
        proc_node = function_b9b2c118602e27a6( "proc_node", entity );
    }
    
    if ( !isdefined( proc_node ) && sceneobjectdata.sceneobject.variant_object.animtree.name === "script_model" )
    {
        proc_node = function_2636cab8e33b8618();
    }
    
    if ( isdefined( proc_node ) )
    {
        weight = 1;
        
        if ( !enabled )
        {
            weight = 0;
        }
        
        if ( !isdefined( sceneobjectdata.activeanimationplaying ) )
        {
            sceneobjectdata waittill( #"scene_anim_playing" );
        }
        
        entity setanim( proc_node, weight, 0 );
    }
}

#using_animtree( "script_model" );

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x3d674a1b, Offset: 0x8afd
// Size: 0xb
function private function_2636cab8e33b8618()
{
    return %script_model_proc_node;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xdb4f5b6e, Offset: 0x8b11
// Size: 0x71
function private function_9fb3f4e85f34d87b( entity )
{
    sceneobjectdata = self;
    
    if ( !isent( entity ) )
    {
        return 0;
    }
    
    if ( isspawner( entity ) )
    {
        return 0;
    }
    
    typefunc = sceneobjectdata object_get_func( "objectMatchEntity" );
    
    if ( isdefined( typefunc ) && typefunc != &function_9fb3f4e85f34d87b )
    {
        return sceneobjectdata [[ typefunc ]]( entity );
    }
    
    return entity.classname == "script_model";
}

// Namespace scene
// Params 7, eflags: 0x4
// Checksum 0xc4295018, Offset: 0x8b8b
// Size: 0x1da
function private function_8c745f4ef7a9726f( sceneroot, sceneplay, sceneobjectname, matchset, matchanimname, existing, inittype )
{
    sceneobjectdata = self;
    
    if ( isarray( matchset ) )
    {
        matchset = arraycopy( matchset );
        
        if ( isdefined( sceneobjectdata.entity ) )
        {
            foreach ( matchsetindex, existingent in matchset )
            {
                if ( isent( existingent ) && sceneobjectdata function_9fb3f4e85f34d87b( existingent ) )
                {
                    if ( existingent == sceneobjectdata.entity || existingent.animname == sceneobjectdata.entity.animname )
                    {
                        sceneobjectdata object_set_entity( sceneroot, sceneplay, existingent, existing, inittype );
                        matchset[ matchsetindex ] = undefined;
                        break;
                    }
                }
            }
            
            return matchset;
        }
        
        foreach ( matchsetindex, existingent in matchset )
        {
            if ( isent( existingent ) && sceneobjectdata function_9fb3f4e85f34d87b( existingent ) )
            {
                if ( !matchanimname || existingent.animname == sceneobjectname )
                {
                    sceneobjectdata object_set_entity( sceneroot, sceneplay, existingent, existing, inittype );
                    matchset[ matchsetindex ] = undefined;
                    break;
                }
            }
        }
    }
    
    return matchset;
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0x63231da8, Offset: 0x8d6e
// Size: 0x154
function private function_46476cf72237e890( sceneroot, sceneplay, sceneobjectname, usedset, keyname, inittype )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata object_set_entity( sceneroot, sceneplay, sceneobjectdata.entity, 1, inittype );
        entnum = sceneobjectdata.entity getentitynumber();
        usedset[ entnum ] = sceneobjectdata.entity;
        return usedset;
    }
    
    foundentities = getentarray( sceneobjectname, keyname );
    
    foreach ( foundent in foundentities )
    {
        entnum = foundent getentitynumber();
        
        if ( isdefined( usedset ) && isdefined( usedset[ entnum ] ) )
        {
            continue;
        }
        
        if ( sceneobjectdata function_9fb3f4e85f34d87b( foundent ) )
        {
            sceneobjectdata object_set_entity( sceneroot, sceneplay, foundent, 1, inittype );
            usedset[ entnum ] = foundent;
            break;
        }
    }
    
    return usedset;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xc9d6d38b, Offset: 0x8ecb
// Size: 0x5a
function private function_15e572f4ed82dd1c()
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.entity ) )
    {
        return;
    }
    
    typefunc = sceneobjectdata object_get_func( "objectGetAnimEntity" );
    
    if ( isdefined( typefunc ) && typefunc != &function_15e572f4ed82dd1c )
    {
        return sceneobjectdata [[ typefunc ]]();
    }
    
    return sceneobjectdata.entity;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x68791810, Offset: 0x8f2e
// Size: 0x57
function private function_f2fb9eed776f75ff()
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectGetLinkEnts" );
    
    if ( isdefined( typefunc ) && typefunc != &function_f2fb9eed776f75ff )
    {
        return sceneobjectdata [[ typefunc ]]();
    }
    
    animentity = sceneobjectdata function_15e572f4ed82dd1c();
    return [ animentity ];
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xb784ca3d, Offset: 0x8f8e
// Size: 0x71
function private function_de784fc1d0ea14bf()
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectGetAnimRoot" );
    
    if ( isdefined( typefunc ) && typefunc != &function_de784fc1d0ea14bf )
    {
        return sceneobjectdata [[ typefunc ]]();
    }
    
    entity = function_15e572f4ed82dd1c();
    
    if ( isdefined( entity ) && isdefined( entity.anim_getrootfunc ) )
    {
        return [[ entity.anim_getrootfunc ]]();
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xb6af57e4, Offset: 0x9008
// Size: 0x117
function private object_teleport( origin, angles )
{
    sceneobjectdata = self;
    
    /#
        scene_debug::object_event( sceneobjectdata, "<dev string:x105>", origin, angles );
    #/
    
    typefunc = sceneobjectdata object_get_func( "objectTeleport" );
    
    if ( isdefined( typefunc ) && typefunc != &object_teleport )
    {
        sceneobjectdata [[ typefunc ]]( origin, angles );
        return;
    }
    
    entities = sceneobjectdata function_f2fb9eed776f75ff();
    
    foreach ( entity in entities )
    {
        if ( isdefined( entity ) )
        {
            entity dontinterpolate();
            
            if ( isdefined( origin ) )
            {
                entity.origin = origin;
            }
            
            if ( isdefined( angles ) )
            {
                entity.angles = angles;
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe8546bc, Offset: 0x9127
// Size: 0x4b
function private object_velocity()
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectVelocity" );
    
    if ( isdefined( typefunc ) && typefunc != &object_velocity )
    {
        return sceneobjectdata [[ typefunc ]]();
    }
    
    return ( 0, 0, 0 );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0xf0ed48c0, Offset: 0x917b
// Size: 0x5f, Type: bool
function private function_2b6987b67b25886a( previousentity, previoustag, newentity, newtag )
{
    if ( !isdefined( previousentity ) )
    {
        return false;
    }
    
    if ( !isdefined( newentity ) )
    {
        return false;
    }
    
    if ( previousentity != newentity )
    {
        return false;
    }
    
    if ( !isdefined( previoustag ) )
    {
        return false;
    }
    
    if ( !isdefined( newtag ) )
    {
        return false;
    }
    
    if ( previoustag != newtag )
    {
        return false;
    }
    
    return true;
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0x9b84729d, Offset: 0x91e3
// Size: 0x82
function private object_alignment_link( sceneplay, alignmentinfo, inittype, lerptime, initializing )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "shotObjectLinkAnim" );
    
    if ( isdefined( typefunc ) && typefunc != &object_alignment_link )
    {
        sceneobjectdata [[ typefunc ]]( sceneplay, alignmentinfo, inittype, lerptime, initializing );
        return;
    }
    
    sceneobjectdata object_alignment_link_internal( sceneplay, alignmentinfo, inittype, lerptime );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0xc5a092ac, Offset: 0x926d
// Size: 0x4b1
function private object_alignment_link_internal( sceneplay, alignmentinfo, inittype, lerptime )
{
    sceneobjectdata = self;
    
    if ( inittype === "scene_init_prestream" )
    {
        return;
    }
    
    sceneobjectdata notify( #"object_alignment_link" );
    update_alignment_transform( alignmentinfo );
    linkents = sceneobjectdata function_f2fb9eed776f75ff();
    
    if ( !( inittype === "scene_init_play" ) && isdefined( sceneplay ) && !sceneobjectdata function_240bf4f132c66497( sceneplay.shotinit ) )
    {
        return;
    }
    
    foreach ( entity in linkents )
    {
        if ( !isent( entity ) )
        {
            continue;
        }
        
        entity notify( #"object_alignment_link" );
        linkedparent = entity getlinkedparent();
        
        if ( !isdefined( alignmentinfo ) || !isent( alignmentinfo.alignent ) )
        {
            if ( isdefined( linkedparent ) && isdefined( sceneobjectdata.linkedent ) )
            {
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x10e>", entity.origin, entity.angles );
                #/
                
                entity notify( #"object_alignment_unlink" );
                entity unlink();
                sceneobjectdata.linkedtag = undefined;
                sceneobjectdata.linkedent = undefined;
            }
            
            continue;
        }
        
        prevorigin = entity.origin;
        prevangles = entity.angles;
        var_fadcdafa4ba90e44 = function_2b6987b67b25886a( sceneobjectdata.linkedent, sceneobjectdata.linkedtag, alignmentinfo.alignent, alignmentinfo.aligntag );
        
        if ( !var_fadcdafa4ba90e44 && alignmentinfo.alignent != entity && !entity isragdoll() && ( linkedparent != alignmentinfo.alignent || ( sceneobjectdata.linkedtag ?? "" ) != ( alignmentinfo.aligntag ?? "" ) ) )
        {
            if ( !isdefined( lerptime ) || lerptime <= 0 )
            {
                sceneobjectdata object_teleport( alignmentinfo.origin, alignmentinfo.angles );
            }
            
            if ( isstring( alignmentinfo.aligntag ) )
            {
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x115>" + alignmentinfo.aligntag, alignmentinfo.alignent gettagorigin( alignmentinfo.aligntag ), alignmentinfo.alignent gettagangles( alignmentinfo.aligntag ) );
                #/
                
                if ( isplayer( entity ) )
                {
                    if ( !isdefined( entity.var_b36f7e54832612a4 ) )
                    {
                        entity playerlinkto( alignmentinfo.alignent, alignmentinfo.aligntag );
                    }
                }
                else if ( isagent( entity ) )
                {
                    entity motionwarpcancel();
                    entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag );
                    entity playerlinkedoffsetenable();
                    entity fixlinktointerpolationbug( 1 );
                }
                else
                {
                    entity linkto( alignmentinfo.alignent, alignmentinfo.aligntag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                }
                
                sceneobjectdata.linkedtag = alignmentinfo.aligntag;
                sceneobjectdata.linkedent = alignmentinfo.alignent;
                
                if ( lerptime > 0 )
                {
                    sceneobjectdata object_teleport( prevorigin, prevangles );
                }
                
                continue;
            }
            
            /#
                scene_debug::object_event( sceneobjectdata, "<dev string:x11b>", entity.origin, entity.angles );
            #/
            
            sceneobjectdata.linkedtag = undefined;
            sceneobjectdata.linkedent = alignmentinfo.alignent;
            
            if ( isplayer( entity ) )
            {
                if ( !isdefined( entity.var_b36f7e54832612a4 ) )
                {
                    entity playerlinkto( alignmentinfo.alignent );
                }
                
                continue;
            }
            
            if ( isagent( entity ) )
            {
                entity motionwarpcancel();
                entity linktomoveoffset( alignmentinfo.alignent );
                entity playerlinkedoffsetenable();
                entity fixlinktointerpolationbug( 1 );
                continue;
            }
            
            entity linkto( alignmentinfo.alignent );
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2a772b4f, Offset: 0x9726
// Size: 0x1cf
function private object_alignment_unlink_thread( alignmentinfo )
{
    sceneobjectdata = self;
    sceneobjectdata notify( #"object_alignment_unlink" );
    sceneobjectdata endon( #"object_alignment_unlink" );
    sceneobjectdata endon( #"object_alignment_link" );
    linkents = sceneobjectdata function_f2fb9eed776f75ff();
    
    foreach ( entity in linkents )
    {
        if ( !isent( entity ) )
        {
            continue;
        }
        
        entity notify( #"object_alignment_unlink" );
        entity endon( #"object_alignment_unlink" );
        entity endon( #"object_alignment_link" );
    }
    
    waittillframeend();
    
    foreach ( entity in linkents )
    {
        if ( !isent( entity ) )
        {
            continue;
        }
        
        linkedparent = entity getlinkedparent();
        
        if ( linkedparent == alignmentinfo.alignent )
        {
            /#
                scene_debug::object_event( sceneobjectdata, "<dev string:x10e>", entity.origin, entity.angles );
            #/
            
            if ( isagent( entity ) )
            {
                entity motionwarpcancel();
            }
            
            entity unlink();
            sceneobjectdata.linkedtag = undefined;
            sceneobjectdata.linkedent = undefined;
        }
    }
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0x4d224c77, Offset: 0x98fd
// Size: 0x3d7
function private function_b51fccb24b16290a( sceneplay, blink, bsetup, alignmentinfo, lerptime )
{
    sceneobjectdata = self;
    
    if ( blink )
    {
        update_alignment_transform( alignmentinfo );
    }
    
    linkents = sceneobjectdata function_f2fb9eed776f75ff();
    
    if ( bsetup && isdefined( sceneplay ) && !sceneobjectdata function_240bf4f132c66497( sceneplay.shotinit ) )
    {
        return;
    }
    
    foreach ( entity in linkents )
    {
        if ( !isent( entity ) )
        {
            continue;
        }
        
        linkedparent = entity getlinkedparent();
        
        if ( !isdefined( alignmentinfo ) || !isent( alignmentinfo.alignent ) )
        {
            if ( isdefined( linkedparent ) )
            {
                entity unlink();
            }
            
            return;
        }
        
        if ( blink )
        {
            prevorigin = entity.origin;
            prevangles = entity.angles;
            var_fadcdafa4ba90e44 = function_2b6987b67b25886a( sceneobjectdata.linkedent, sceneobjectdata.linkedtag, alignmentinfo.alignent, alignmentinfo.aligntag );
            
            if ( !var_fadcdafa4ba90e44 && alignmentinfo.alignent != entity && !entity isragdoll() && ( linkedparent != alignmentinfo.alignent || ( sceneobjectdata.linkedtag ?? "" ) != ( alignmentinfo.aligntag ?? "" ) ) )
            {
                if ( !isdefined( lerptime ) || lerptime <= 0 )
                {
                    sceneobjectdata object_teleport( alignmentinfo.origin, alignmentinfo.angles );
                }
                
                if ( isstring( alignmentinfo.aligntag ) )
                {
                    if ( isplayer( entity ) )
                    {
                        if ( !isdefined( entity.var_b36f7e54832612a4 ) )
                        {
                            entity playerlinkto( alignmentinfo.alignent, alignmentinfo.aligntag );
                        }
                    }
                    else if ( isagent( entity ) )
                    {
                        entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag );
                        entity playerlinkedoffsetenable();
                        entity fixlinktointerpolationbug( 1 );
                    }
                    else
                    {
                        entity linkto( alignmentinfo.alignent, alignmentinfo.aligntag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                    }
                    
                    sceneobjectdata.linkedtag = alignmentinfo.aligntag;
                    sceneobjectdata.linkedent = alignmentinfo.alignent;
                    
                    if ( lerptime > 0 )
                    {
                        sceneobjectdata object_teleport( prevorigin, prevangles );
                    }
                }
                else
                {
                    sceneobjectdata.linkedtag = undefined;
                    sceneobjectdata.linkedent = alignmentinfo.alignent;
                    
                    if ( isplayer( entity ) )
                    {
                        entity playerlinkto( alignmentinfo.alignent );
                    }
                    else if ( isagent( entity ) )
                    {
                        entity linktomoveoffset( alignmentinfo.alignent );
                        entity playerlinkedoffsetenable();
                        entity fixlinktointerpolationbug( 1 );
                    }
                    else
                    {
                        entity linkto( alignmentinfo.alignent );
                    }
                }
            }
            
            continue;
        }
        
        if ( linkedparent == alignmentinfo.alignent )
        {
            entity unlink();
            sceneobjectdata.linkedtag = undefined;
            sceneobjectdata.linkedent = undefined;
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x67e2f7be, Offset: 0x9cdc
// Size: 0x1d4
function private object_first_frame( alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    
    if ( !isdefined( shotindex ) )
    {
        shotindex = sceneobjectdata.sceneplay.shotinit;
    }
    
    typefunc = sceneobjectdata object_get_func( "shotObjectFirstFrame" );
    
    if ( isdefined( typefunc ) && typefunc != &object_first_frame )
    {
        sceneobjectdata [[ typefunc ]]( alignmentinfo, shotindex );
    }
    else
    {
        if ( !isdefined( sceneobjectdata.entity ) )
        {
            return;
        }
        
        shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
        
        if ( shotanimations.size != 0 )
        {
            entity = sceneobjectdata function_15e572f4ed82dd1c();
            animasset = shotanimations[ 0 ];
            
            if ( isent( entity ) && entity.model != "" )
            {
                entity stopanimscripted();
                entity.origin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
                entity.angles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
                entity setanimknob( animasset, 1, 0, 0 );
                entity setanimtime( animasset, 0 );
                entity dontinterpolate();
                
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x120>" + getxhashsourcename( getanimname( animasset ) ), entity.origin, entity.angles );
                #/
                
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x12d>" + getxhashsourcename( getanimname( animasset ) ), alignmentinfo.origin, alignmentinfo.angles );
                #/
            }
        }
    }
    
    sceneobjectdata childthread object_shot_death_wait( sceneobjectdata.sceneplay, shotindex, sceneobjectdata.index );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x99025cdc, Offset: 0x9eb8
// Size: 0x40
function private function_f63807284220f334()
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectCanAnimate" );
    
    if ( isdefined( typefunc ) && typefunc != &function_f63807284220f334 )
    {
        return sceneobjectdata [[ typefunc ]]();
    }
    
    return 1;
}

// Namespace scene
// Params 10, eflags: 0x4
// Checksum 0x990f05cb, Offset: 0x9f01
// Size: 0x508
function private object_play_anim( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype )
{
    sceneobjectdata = self;
    sceneobjectdata.activeanimationtype = animationtype;
    sceneobjectdata.activeanimation = animasset;
    sceneobjectdata function_cef36d8c3e65c8c4( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype );
    
    if ( isdefined( animationtype ) )
    {
        sceneobjectdata.var_caa911de855ae014[ animationtype ] = notifystring;
    }
    
    if ( !isdefined( animationtype ) )
    {
        animationtype = "DeltaAnimation";
    }
    
    animplaybacktime = 0;
    
    if ( isent( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity notify( #"scene_play_anim" );
    }
    
    sceneobjectdata notify( #"scene_play_anim" );
    
    if ( animationtype == "DeltaAnimation" )
    {
        objecttype = sceneobjectdata object_get_type();
        
        if ( !isent( sceneobjectdata.entity ) )
        {
            n_anim_length = sceneobjectdata function_58a93a40f02daed7( shotindex, animasset, animationtype, animindex );
            var_49209d5721bed4e2 = sceneobjectdata function_e751e9405d8ce670( shotindex, animationtype, animindex );
            
            if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) || var_142c2c5d44216f2a > 0 )
            {
                var_49209d5721bed4e2 = 0;
            }
            
            starttimeinseconds = 0;
            
            if ( var_142c2c5d44216f2a > 0 )
            {
                starttimeinseconds = n_anim_length * var_142c2c5d44216f2a;
            }
            
            var_1ae8ed0ceeb0170c = n_anim_length + var_49209d5721bed4e2 - starttimeinseconds;
            sceneobjectdata utility::waittill_any_timeout( var_1ae8ed0ceeb0170c, "scene_anim_ended" );
            sceneobjectdata object_play_anim_ended( animasset, animationtype, notifystring );
            sceneobjectdata function_b635d3c89c265ba4( animationtype, shotindex, animindex );
            return;
        }
        
        anim_entity = sceneobjectdata function_15e572f4ed82dd1c();
        
        if ( !isdefined( anim_entity ) || anim_entity.model == "" && objecttype != "Types_ClientChar" )
        {
            sceneobjectdata object_play_anim_ended( animasset, animationtype, notifystring );
            sceneobjectdata function_b635d3c89c265ba4( animationtype, shotindex, animindex );
            return;
        }
        
        if ( sceneobjectdata.sceneobject function_669f3ba695235683( shotindex ) )
        {
            update_alignment_transform( alignmentinfo );
            sceneobjectdata object_first_frame( sceneobjectdata.alignmentinfo, shotindex );
            sceneobjectdata object_play_anim_ended( animasset, animationtype, notifystring );
            sceneobjectdata function_b635d3c89c265ba4( animationtype, shotindex, animindex );
            return;
        }
        
        sceneobjectdata.entity endon( #"death_or_disconnect" );
        anim_entity endon( #"death_or_disconnect" );
        sceneobjectdata thread object_play_anim_waittill_end( animasset, [ sceneobjectdata.entity, anim_entity ], "death_or_disconnect", animationtype, notifystring );
        
        /#
            debugname = getxhashsourcename( getanimname( animasset ) );
            scene_debug::object_event( sceneobjectdata, "<dev string:x140>" + debugname, alignmentinfo.origin, alignmentinfo.angles );
        #/
        
        typefunc = sceneobjectdata object_get_func( "shotObjectPlayAnim" );
        
        if ( isdefined( typefunc ) && typefunc != &object_play_anim )
        {
            animplaybacktime = sceneobjectdata [[ typefunc ]]( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime );
        }
        
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x14b>" + debugname, alignmentinfo.origin, alignmentinfo.angles );
        #/
    }
    else if ( animationtype == "CameraAnimation" )
    {
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x156>" + animasset, alignmentinfo.origin, alignmentinfo.angles );
        #/
        
        typefunc = sceneobjectdata object_get_func( "shotObjectPlayAnim" );
        
        if ( isdefined( typefunc ) && typefunc != &object_play_anim )
        {
            animplaybacktime = sceneobjectdata [[ typefunc ]]( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime );
        }
        
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x161>" + animasset, alignmentinfo.origin, alignmentinfo.angles );
        #/
    }
    else if ( animationtype == "MayhemAnimation" )
    {
        if ( sceneobjectdata.sceneobject function_669f3ba695235683( shotindex ) )
        {
            update_alignment_transform( alignmentinfo );
            sceneobjectdata object_first_frame( sceneobjectdata.alignmentinfo );
            sceneobjectdata object_play_anim_ended( animasset, animationtype, notifystring );
            sceneobjectdata function_b635d3c89c265ba4( animationtype, shotindex, animindex );
            return;
        }
        
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x16c>" + animasset, alignmentinfo.origin, alignmentinfo.angles );
        #/
        
        typefunc = sceneobjectdata object_get_func( "shotObjectPlayAnim" );
        
        if ( isdefined( typefunc ) && typefunc != &object_play_anim )
        {
            animplaybacktime = sceneobjectdata [[ typefunc ]]( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime );
        }
        
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x179>" + animasset, alignmentinfo.origin, alignmentinfo.angles );
        #/
    }
    
    sceneobjectdata object_play_anim_ended( animasset, animationtype, notifystring );
    sceneobjectdata function_b635d3c89c265ba4( animationtype, shotindex, animindex );
    return animplaybacktime;
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xa691c2c9, Offset: 0xa412
// Size: 0xa2
function private object_play_anim_waittill_end( animasset, var_d3370a7b4787be17, waitfor, animationtype, notifystring )
{
    sceneobjectdata = self;
    
    if ( isdefined( animasset ) && animationtype == "DeltaAnimation" )
    {
        suffix = getxhashhexname( getanimname( animasset ) );
    }
    else
    {
        suffix = "";
    }
    
    sceneobjectdata notify( "object_play_anim_waittill_end" + suffix );
    sceneobjectdata endon( "object_play_anim_waittill_end" + suffix );
    utility::waittill_any_ents_array( var_d3370a7b4787be17, waitfor );
    
    if ( isdefined( sceneobjectdata ) )
    {
        sceneobjectdata thread object_play_anim_ended( animasset, animationtype, notifystring );
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xff24361d, Offset: 0xa4bc
// Size: 0x1b8
function private object_play_anim_ended( animasset, animationtype, notifystring )
{
    sceneobjectdata = self;
    
    if ( isdefined( animasset ) && animationtype == "DeltaAnimation" )
    {
        suffix = getxhashhexname( getanimname( animasset ) );
    }
    else
    {
        suffix = "";
    }
    
    sceneobjectdata notify( "object_play_anim_waittill_end" + suffix );
    ended = 0;
    
    if ( isdefined( sceneobjectdata.var_caa911de855ae014 ) )
    {
        foreach ( activeanimationtype, activenotifystring in sceneobjectdata.var_caa911de855ae014 )
        {
            if ( !isdefined( animationtype ) || animationtype == activeanimationtype )
            {
                if ( !isdefined( notifystring ) || notifystring == activenotifystring )
                {
                    sceneobjectdata notify( activenotifystring, "end" );
                    ended = 1;
                }
            }
        }
    }
    
    if ( ended )
    {
        if ( isdefined( animationtype ) )
        {
            sceneobjectdata.var_caa911de855ae014[ animationtype ] = undefined;
        }
        else
        {
            sceneobjectdata.var_caa911de855ae014 = undefined;
        }
    }
    
    if ( !isdefined( animasset ) || isdefined( sceneobjectdata.activeanimationtype ) && sceneobjectdata.activeanimationtype == animationtype && sceneobjectdata.activeanimation == animasset )
    {
        sceneobjectdata.activeanimation = undefined;
        sceneobjectdata.activeanimationtype = undefined;
        sceneobjectdata.activeanimationplaying = undefined;
        sceneobjectdata.pausestate = undefined;
    }
    
    sceneobjectdata notify( #"scene_anim_ended" );
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x849aa0f6, Offset: 0xa67c
// Size: 0x88
function private function_26364b7b16eb9611( notifystring, animasset )
{
    sceneobjectdata = self;
    sceneobjectdata childthread function_f41f57a25d231b2( notifystring );
    typefunc = sceneobjectdata object_get_func( "objectWaitNotes" );
    
    if ( isdefined( typefunc ) && typefunc != &function_26364b7b16eb9611 )
    {
        sceneobjectdata [[ typefunc ]]( notifystring, animasset );
        return;
    }
    
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( isdefined( entity ) )
    {
        sceneobjectdata childthread notetrack::start_notetrack_wait( entity, notifystring, undefined, undefined, animasset );
    }
}

// Namespace scene
// Params 8, eflags: 0x4
// Checksum 0x9486cc34, Offset: 0xa70c
// Size: 0x274
function private function_1e43ac4c885e2751( alignmentinfo, animasset, notifystring, var_142c2c5d44216f2a, var_ab6f54ef0991868f, animationtype, shotindex, animindex )
{
    sceneobjectdata = self;
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( animationtype == "DeltaAnimation" )
    {
        assert( var_142c2c5d44216f2a >= 0 );
        assert( var_142c2c5d44216f2a <= 1 );
        assert( var_ab6f54ef0991868f >= 0 );
        assert( var_ab6f54ef0991868f <= 1 );
        var_b1d1c91155cba = var_142c2c5d44216f2a;
        var_4f33d5eebca32ad7 = var_ab6f54ef0991868f;
        
        if ( shotindex >= 0 && animindex >= 0 )
        {
            animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animindex );
            var_b1d1c91155cba = function_1222280fb003fd62( animasset, animationvalues, var_142c2c5d44216f2a );
            var_4f33d5eebca32ad7 = function_1222280fb003fd62( animasset, animationvalues, var_ab6f54ef0991868f );
        }
        
        typefunc = sceneobjectdata object_get_func( "shotObjectSkipAnim" );
        
        if ( isdefined( typefunc ) && typefunc != &function_1e43ac4c885e2751 )
        {
            sceneobjectdata [[ typefunc ]]( alignmentinfo, animasset, notifystring, var_b1d1c91155cba, var_4f33d5eebca32ad7, animationtype );
            return;
        }
        
        if ( entity.model )
        {
            if ( animislooping( animasset ) && var_4f33d5eebca32ad7 == 1 )
            {
                var_4f33d5eebca32ad7 = 0.999999;
            }
            
            notes = getnotetracks( animasset );
            
            foreach ( note in notes )
            {
                notetime = note[ "time" ];
                
                if ( notetime < var_b1d1c91155cba )
                {
                    continue;
                }
                
                if ( notetime > var_4f33d5eebca32ad7 )
                {
                    break;
                }
                
                notename = note[ "name" ];
                pfx = getsubstr( notename, 0, 3 );
                
                if ( pfx == "fs_" || pfx == "fc_" )
                {
                    thread notetrack::notetrack_handler( entity, undefined, notename, entity.animname, [], entity, undefined );
                }
            }
            
            entity setanimtime( animasset, var_4f33d5eebca32ad7, undefined, 1 );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xb8415b7c, Offset: 0xa988
// Size: 0x21c
function private function_f41f57a25d231b2( notifystring, specificnotifyitem )
{
    sceneobjectdata = self;
    scenestatic = sceneobjectdata.sceneroot.scenestatic;
    
    if ( !( isdefined( scenestatic ) && isdefined( scenestatic.notifies ) ) )
    {
        return;
    }
    
    sceneobjecttype = sceneobjectdata.sceneobject obj_get_type();
    sceneobjectname = sceneobjectdata.sceneobject obj_get_name();
    notifies = [];
    checktables = [ sceneobjectname, sceneobjecttype ];
    
    foreach ( tablename in checktables )
    {
        if ( isdefined( scenestatic.notifies[ tablename ] ) )
        {
            foreach ( notifyitem in scenestatic.notifies[ tablename ] )
            {
                notifies[ notifies.size ] = notifyitem;
            }
        }
    }
    
    foreach ( notifyitem in notifies )
    {
        if ( !isdefined( specificnotifyitem ) || specificnotifyitem == notifyitem )
        {
            sceneobjectdata thread function_5e29e5e1066417e1( notifystring, notifyitem );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x21ed3c97, Offset: 0xabac
// Size: 0x47
function private function_5e29e5e1066417e1( notifystring, notifyitem )
{
    sceneobjectdata = self;
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( isdefined( entity ) )
    {
        entity function_84ed189dc2017575( notifystring, notifyitem, sceneobjectdata );
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xcb1d6a34, Offset: 0xabfb
// Size: 0x608
function private object_shot_death_wait( sceneplay, shotindex, sceneobjectindex )
{
    sceneobjectdata = self;
    sceneroot = sceneobjectdata.sceneroot;
    scenedata = sceneroot.scenedata;
    sceneobjectdata notify( #"object_shot_death_wait" );
    sceneobjectdata endon( #"object_shot_death_wait" );
    deathanim = sceneobjectdata.sceneobject function_e93b454561075f4a( shotindex );
    deathscenestop = sceneobjectdata.sceneobject function_6ff76756d536e49a();
    
    if ( !deathscenestop && !isdefined( deathanim ) )
    {
        return;
    }
    
    sceneplay endon( #"scene_shot_cleanup" );
    entity = sceneobjectdata.entity;
    
    if ( isalive( entity ) )
    {
        entity val::set( "scene_shot", "death", 0 );
        attacker = undefined;
        point = undefined;
        meansofdeath = undefined;
        objweapon = undefined;
        inflictor = undefined;
        
        while ( entity.health > 1 )
        {
            entity waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        }
        
        if ( isagent( entity ) || !isdefined( direction_vec ) || direction_vec[ 0 ] == 0 && direction_vec[ 1 ] == 0 && direction_vec[ 2 ] == 0 && point[ 0 ] == 0 && point[ 1 ] == 0 && point[ 2 ] == 0 )
        {
            point = undefined;
        }
        
        if ( isdefined( entity ) && isdefined( deathanim ) )
        {
            animentity = sceneobjectdata function_15e572f4ed82dd1c();
            
            if ( isdefined( animentity ) )
            {
                animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
                
                if ( !isdefined( sceneobjectdata.var_caa911de855ae014 ) )
                {
                    sceneobjectdata.var_caa911de855ae014 = [];
                }
                
                if ( !isdefined( sceneobjectdata.var_caa911de855ae014[ animtype ] ) )
                {
                    sceneobjectdata.var_caa911de855ae014[ animtype ] = "prepare" + shotindex + sceneobjectindex;
                }
                
                notifystring = sceneobjectdata.var_caa911de855ae014[ animtype ];
                sceneobjectdata.var_caa911de855ae014[ animtype ] = undefined;
                sceneobjectdata object_scene_death( attacker );
                var_e48b02e5abc87d9c = sceneobjectdata.sceneobject function_fc193fefe28dad3e( shotindex );
                
                if ( isdefined( var_e48b02e5abc87d9c ) )
                {
                    var_e48b02e5abc87d9c = strtok( var_e48b02e5abc87d9c, "," );
                    var_1874a1a2711b696d = [];
                    
                    foreach ( objectname in var_e48b02e5abc87d9c )
                    {
                        var_969ce076455a514d = sceneroot get_object( objectname );
                        
                        if ( isdefined( var_969ce076455a514d ) )
                        {
                            otheranimtype = var_969ce076455a514d.sceneobject function_e497f52b15295ba5();
                            
                            if ( !isdefined( var_969ce076455a514d.var_caa911de855ae014 ) )
                            {
                                var_969ce076455a514d.var_caa911de855ae014 = [];
                            }
                            
                            if ( !isdefined( var_969ce076455a514d.var_caa911de855ae014[ otheranimtype ] ) )
                            {
                                var_969ce076455a514d.var_caa911de855ae014[ otheranimtype ] = "prepare" + shotindex + var_969ce076455a514d.index;
                            }
                            
                            othernotifystring = var_969ce076455a514d.var_caa911de855ae014[ otheranimtype ];
                            otherdeathanim = var_969ce076455a514d.sceneobject function_e93b454561075f4a( shotindex );
                            
                            if ( isdefined( otherdeathanim ) )
                            {
                                var_969ce076455a514d.var_bf1c906895c88a1b = 1;
                                var_969ce076455a514d.var_2d749d02fccaab1 = var_969ce076455a514d.activeanimationplaying;
                                var_969ce076455a514d thread object_play_anim( shotindex, -1, othernotifystring, var_969ce076455a514d.alignmentinfo, otherdeathanim );
                                var_1874a1a2711b696d[ var_1874a1a2711b696d.size ] = var_969ce076455a514d;
                            }
                        }
                    }
                }
                
                sceneobjectdata.var_bf1c906895c88a1b = 1;
                params = { #currentshotname:sceneobjectdata.scenedata.scenescriptbundle function_d74f9d413aca8704( shotindex ), #var_1874a1a2711b696d:var_1874a1a2711b696d, #entity:entity, #sweapon:objweapon, #vpoint:point, #smeansofdeath:meansofdeath, #einflictor:inflictor, #eattacker:attacker };
                sceneobjectdata.sceneroot callback::callback( "callback_death_anim", params );
                sceneobjectdata object_play_anim( shotindex, -1, notifystring, sceneobjectdata.alignmentinfo, deathanim );
            }
        }
        
        if ( isdefined( var_1874a1a2711b696d ) )
        {
            foreach ( var_969ce076455a514d in var_1874a1a2711b696d )
            {
                if ( isalive( var_969ce076455a514d.entity ) )
                {
                    var_969ce076455a514d.entity val::set( "scene_shot", "death", 1 );
                    var_969ce076455a514d thread object_kill( attacker, point, meansofdeath, objweapon, inflictor );
                    var_969ce076455a514d.var_bf1c906895c88a1b = undefined;
                }
            }
        }
        
        entity val::set( "scene_shot", "death", 1 );
        sceneobjectdata object_kill( attacker, point, meansofdeath, objweapon, inflictor );
        sceneobjectdata.var_bf1c906895c88a1b = undefined;
    }
    
    if ( deathscenestop )
    {
        sceneroot thread stop();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x7b56f520, Offset: 0xb20b
// Size: 0x1b, Type: bool
function private function_fd41f2c45f2ff86a()
{
    sceneobjectdata = self;
    return !sceneobjectdata.notanimated;
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x6edc6dbb, Offset: 0xb22f
// Size: 0xea
function private function_58a93a40f02daed7( shotindex, animasset, animationtype, animationindex )
{
    sceneobjectdata = self;
    
    switch ( animationtype )
    {
        case #"hash_db2a102a7b3b4349":
            animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animationindex );
            return max( getanimlength( animasset ) - animationvalues.var_a9b8dffd45b33087 - animationvalues.var_9f35e59f5c1e4176, 0 );
        case #"hash_3c9daf4fd5203d1c":
            return sceneobjectdata function_516be5ef89c77c57( shotindex, animasset );
        case #"hash_eb9c9817350b0b1e":
            var_2e0bf5d2305b2f54 = sceneobjectdata.sceneobject function_7e8812fa38dae41a( shotindex, animationindex );
            return ( var_2e0bf5d2305b2f54.lengthtime ?? 0 );
    }
    
    return 0;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x826327b, Offset: 0xb322
// Size: 0xb5
function private function_e751e9405d8ce670( shotindex, animationtype, animationindex )
{
    sceneobjectdata = self;
    
    switch ( animationtype )
    {
        case #"hash_db2a102a7b3b4349":
            animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animationindex );
            return animationvalues.displacementtime;
        case #"hash_3c9daf4fd5203d1c":
            break;
        case #"hash_eb9c9817350b0b1e":
            mayhem_time_values = sceneobjectdata.sceneobject function_7e8812fa38dae41a( shotindex, animationindex );
            return mayhem_time_values.displacementtime;
    }
    
    return 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe1dd802b, Offset: 0xb3e0
// Size: 0xee
function private object_anim_end()
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "shotObjectAnimEnd" );
    
    if ( isdefined( typefunc ) && typefunc != &object_anim_end )
    {
        sceneobjectdata [[ typefunc ]]();
    }
    else if ( isdefined( sceneobjectdata.entity ) && isdefined( sceneobjectdata.var_caa911de855ae014 ) )
    {
        foreach ( message in sceneobjectdata.var_caa911de855ae014 )
        {
            sceneobjectdata.entity notify( message, "end" );
        }
    }
    
    sceneobjectdata.var_caa911de855ae014 = undefined;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xca8e4d21, Offset: 0xb4d6
// Size: 0x88
function private object_pause( pausestate )
{
    sceneobjectdata = self;
    
    if ( ( sceneobjectdata.pausestate ?? 0 ) == pausestate )
    {
        return;
    }
    
    result = 1;
    typefunc = sceneobjectdata object_get_func( "shotObjectPauseAnim" );
    
    if ( isdefined( typefunc ) && typefunc != &object_pause )
    {
        result = sceneobjectdata [[ typefunc ]]( pausestate );
    }
    
    if ( result )
    {
        sceneobjectdata.pausestate = pausestate ? 1 : undefined;
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x231c0e7, Offset: 0xb566
// Size: 0x10b
function private function_2d0d8b2ed2c4709a()
{
    sceneobjectdata = self;
    
    /#
        if ( isdefined( sceneobjectdata.entity ) )
        {
            scene_debug::object_event( sceneobjectdata, "<dev string:x186>", sceneobjectdata.entity.origin, sceneobjectdata.entity.angles );
        }
    #/
    
    typefunc = sceneobjectdata object_get_func( "shotObjectStopAnim" );
    
    if ( isdefined( typefunc ) && typefunc != &function_2d0d8b2ed2c4709a )
    {
        sceneobjectdata [[ typefunc ]]();
    }
    else if ( isdefined( sceneobjectdata.entity ) && sceneobjectdata.activeanimationtype == "DeltaAnimation" )
    {
        sceneobjectdata.entity stopanimscripted();
    }
    
    sceneobjectdata.activeanimationtype = undefined;
    sceneobjectdata.activeanimation = undefined;
    sceneobjectdata.var_2d749d02fccaab1 = sceneobjectdata.activeanimationplaying;
    sceneobjectdata.activeanimationplaying = undefined;
    sceneobjectdata.pausestate = undefined;
    sceneobjectdata object_play_anim_ended();
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x1a9afa3c, Offset: 0xb679
// Size: 0x1c1
function private object_cleanup( newsceneroot, var_d3db51aca025c1b1 )
{
    sceneobjectdata = self;
    
    if ( sceneobjectdata.issetup )
    {
        sceneobjectdata thread object_alignment_unlink_thread( sceneobjectdata.alignmentinfo );
        typefunc = sceneobjectdata object_get_func( "objectCleanup" );
        
        if ( isdefined( typefunc ) && typefunc != &object_cleanup )
        {
            sceneobjectdata [[ typefunc ]]( newsceneroot );
        }
        
        if ( isdefined( sceneobjectdata.entity ) )
        {
            /#
                if ( isplayer( sceneobjectdata.entity ) )
                {
                    sceneobjectdata.entity scene_debug::function_24a6aeb21d33a19b();
                }
            #/
            
            sceneobjectdata.entity val::reset_all( "scene_shot" );
            sceneobjectdata.entity val::reset_all( "scene_scene" );
            sceneobjectdata.entity utility::ent_flag_clear( "scene_active" );
            sceneobjectdata.entity.sceneobjectdata = undefined;
            sceneobjectdata function_6eed58b13f778351( undefined, undefined );
            
            if ( isdefined( sceneobjectdata.restoredontmelee ) )
            {
                sceneobjectdata.entity.dontmelee = sceneobjectdata.restoredontmelee;
            }
        }
        
        sceneobjectdata.var_878130757a0f3a61 = undefined;
        sceneobjectdata.var_c4d701311a34bc3c = undefined;
        sceneobjectdata.var_2addba4672ca0b36 = undefined;
        sceneobjectdata notify( #"scene_ai_stealth" );
        
        if ( !isdefined( newsceneroot ) && sceneobjectdata function_664551610cc4c09f() )
        {
            sceneobjectdata object_delete();
        }
        
        if ( var_d3db51aca025c1b1 || sceneobjectdata object_get_type() == "Types_Actor" )
        {
            sceneobjectdata.entity = undefined;
            sceneobjectdata.existingentity = undefined;
        }
        
        sceneobjectdata.issetup = undefined;
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x82e2bf51, Offset: 0xb842
// Size: 0x85, Type: bool
function private function_664551610cc4c09f()
{
    sceneobjectdata = self;
    deletetype = sceneobjectdata.sceneobject function_772de5acb2e194c7();
    deletealways = deletetype == "DeleteAlways" || deletetype == "DeleteAlwaysNotInvolved";
    deletespawned = ( deletetype == "DeleteSpawned" || deletetype == "DeleteSpawnedNotInvolved" ) && !sceneobjectdata.existingentity;
    
    if ( deletealways || deletespawned )
    {
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xffa1f1be, Offset: 0xb8d0
// Size: 0x9f
function private object_kill( attacker, point, meansofdeath, objweapon, inflictor )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectKill" );
    
    if ( isdefined( typefunc ) && typefunc != &object_kill )
    {
        sceneobjectdata [[ typefunc ]]( point, attacker, inflictor, meansofdeath, objweapon );
        return;
    }
    
    if ( isalive( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity kill( point, attacker, inflictor, meansofdeath, objweapon );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x1c56ef99, Offset: 0xb977
// Size: 0x49
function private object_scene_death( attacker )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectSceneDeath" );
    
    if ( isdefined( typefunc ) && typefunc != &object_scene_death )
    {
        sceneobjectdata [[ typefunc ]]( attacker );
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xffba0213, Offset: 0xb9c8
// Size: 0xd2
function private object_delete()
{
    sceneobjectdata = self;
    
    /#
        if ( isdefined( sceneobjectdata.entity ) )
        {
            scene_debug::object_event( sceneobjectdata, "<dev string:x18b>", sceneobjectdata.entity.origin, sceneobjectdata.entity.angles );
        }
    #/
    
    visibility_mode::function_4e6c654251b854e0( sceneobjectdata.entity );
    typefunc = sceneobjectdata object_get_func( "objectDelete" );
    
    if ( isdefined( typefunc ) && typefunc != &object_delete )
    {
        sceneobjectdata [[ typefunc ]]();
    }
    else if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity delete();
    }
    
    sceneobjectdata.entity = undefined;
    sceneobjectdata.existingentity = undefined;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x4d51bf0f, Offset: 0xbaa2
// Size: 0x4a
function private function_2e0ec39304a5a328()
{
    sceneobjectdata = self;
    
    if ( sceneobjectdata.xcamplaying )
    {
        if ( isplayer( sceneobjectdata.entity ) )
        {
            sceneobjectdata.entity stopxcam();
        }
        
        sceneobjectdata.xcamplaying = undefined;
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xbafb18e4, Offset: 0xbaf4
// Size: 0x4e7
function private function_3c2e9847ed1dd391( sceneplay, shotindex )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "shotObjectPreStream" );
    
    if ( isdefined( typefunc ) && typefunc != &function_3c2e9847ed1dd391 )
    {
        sceneobjectdata [[ typefunc ]]( sceneplay, shotindex );
    }
    
    sceneobjectdata update_alignment_transform( sceneobjectdata.alignmentinfo );
    prestreamassets = sceneobjectdata.sceneroot.scenestatic.prestreamassets[ shotindex ];
    
    if ( isdefined( prestreamassets ) )
    {
        foreach ( assettype, var_f6e2e741f3d592bb in prestreamassets )
        {
            foreach ( assetindex, asset in var_f6e2e741f3d592bb.assets )
            {
                if ( assettype == "entity" )
                {
                    sceneplay.prestream.objects[ sceneplay.prestream.objects.size ] = { #origin:var_f6e2e741f3d592bb.origins[ assetindex ], #entity:asset };
                    continue;
                }
                
                assert( assettype == "<dev string:x192>" );
                sceneplay.prestream.models = 1;
                sceneplay.prestream.objects[ sceneplay.prestream.objects.size ] = { #origin:var_f6e2e741f3d592bb.origins[ assetindex ], #model:asset };
            }
        }
    }
    
    if ( isdefined( sceneobjectdata.alignmentinfo ) )
    {
        cameraanimation = sceneobjectdata function_64466e4b9ed25e4c( shotindex );
        shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
        
        if ( isplayer( sceneobjectdata.entity ) )
        {
            player = sceneobjectdata.entity;
            streamcameraorigin = undefined;
            
            if ( isdefined( cameraanimation ) )
            {
                streamcameraorigin = player getxcamposition( cameraanimation, 0, 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles );
            }
            else if ( isdefined( shotanimations ) && shotanimations.size > 0 )
            {
                linktag = sceneobjectdata function_68d2c57d9f9e8a7e();
                animentity = sceneobjectdata function_15e572f4ed82dd1c();
                offset = ( 0, 0, player getplayerviewheight() );
                
                if ( animentity.model )
                {
                    startposang = animentity animation::function_bcb776397b6f4ce( shotanimations[ 0 ], linktag, 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles );
                    
                    if ( isdefined( startposang ) )
                    {
                        streamcameraorigin = startposang[ "origin" ];
                        offset = rotatevector( offset, startposang[ "angles" ] );
                    }
                }
                
                if ( !isdefined( streamcameraorigin ) )
                {
                    streamcameraorigin = getstartorigin( sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles, shotanimations[ 0 ] );
                }
                
                if ( linktag != "tag_camera" )
                {
                    streamcameraorigin += offset;
                }
            }
            
            if ( isdefined( streamcameraorigin ) )
            {
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x198>", streamcameraorigin, ( 0, 0, 0 ) );
                #/
                
                playerinfo = sceneplay function_495a812f7545da04( player, streamcameraorigin );
            }
        }
        
        entity = sceneobjectdata function_15e572f4ed82dd1c();
        
        if ( isdefined( entity ) )
        {
            if ( shotanimations[ 0 ] && sceneobjectdata function_514b2f4dda4105ef( shotindex ) )
            {
                objectorigin = getstartorigin( sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles, shotanimations[ 0 ] );
            }
            else
            {
                objectorigin = sceneobjectdata.alignmentinfo.origin;
            }
            
            sceneplay.prestream.objects[ sceneplay.prestream.objects.size ] = { #origin:objectorigin, #entity:entity };
        }
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xc6910389, Offset: 0xbfe3
// Size: 0xfa
function private function_90aaff2103125c26( sceneplay, shotindex, sceneobjectindex )
{
    sceneobjectdata = self;
    sceneplay endon( #"scene_stop" );
    sceneobjectdata endon( #"scene_stop" );
    
    foreach ( message in sceneobjectdata.var_caa911de855ae014 )
    {
        sceneobjectdata endon( message );
    }
    
    sceneobjectdata childthread object_shot_death_wait( sceneplay, shotindex, sceneobjectindex );
    typefunc = sceneobjectdata object_get_func( "shotObjectPrepare" );
    
    if ( isdefined( typefunc ) && typefunc != &function_90aaff2103125c26 )
    {
        sceneobjectdata [[ typefunc ]]( sceneplay, shotindex, sceneobjectindex );
    }
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x94683173, Offset: 0xc0e5
// Size: 0x361
function private function_8207af582343cc24( sceneplay, shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        if ( sceneobjectdata.sceneobject function_aea14e0e13bbd667( shotindex ) )
        {
            sceneobjectdata.entity flagteleport();
        }
        
        if ( sceneobjectdata.sceneobject function_32571802b2e452ec( shotindex ) )
        {
            sceneobjectdata.entity val::set( "scene_scene", "hide", 2 );
            sceneobjectdata.entity val::set( "scene_scene", "ignoreall", 1 );
            sceneobjectdata.entity val::set( "scene_scene", "ignoreme", 1 );
            
            if ( isplayer( sceneobjectdata.entity ) )
            {
                sceneobjectdata.entity val::set( "scene_scene", "fire", 0 );
            }
        }
        
        if ( sceneobjectdata.sceneobject function_dd5572420d3225( shotindex ) )
        {
            sceneobjectdata.entity val::reset( "scene_scene", "hide" );
            sceneobjectdata.entity show();
            
            if ( isagent( sceneobjectdata.entity ) )
            {
                sceneobjectdata.entity visiblesolid();
            }
            
            sceneobjectdata.entity val::reset( "scene_scene", "ignoreall" );
            sceneobjectdata.entity val::reset( "scene_scene", "ignoreme" );
            
            if ( isplayer( sceneobjectdata.entity ) )
            {
                sceneobjectdata.entity val::reset( "scene_scene", "fire" );
            }
        }
        
        sceneobjectdata.entity val::set( "scene_scene", "cast_shadow", sceneobjectdata.sceneobject function_a7e0b6b74f965439( shotindex ) );
        
        if ( !sceneobjectdata.sceneobject function_6ea442b0feacbc1() && !sceneobjectdata.sceneobject function_599407b70d85262c( shotindex ) )
        {
            sceneobjectdata.entity val::set( "scene_shot", "damage", 0 );
        }
        
        if ( isplayer( sceneobjectdata.entity ) )
        {
            tweenin = sceneobjectdata.sceneobject function_abc779ad811bdf13( shotindex );
            
            if ( tweenin > 0 )
            {
                viewmodelvisible = sceneobjectdata.sceneobject function_3f64f25a6a59bb06( shotindex );
                stopxcam = sceneobjectdata.sceneobject function_7136c10c7e8929fa( shotindex );
                
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x1a3>" + sceneobjectdata.entity getentitynumber(), sceneobjectdata.entity.origin, sceneobjectdata.entity.angles );
                #/
                
                sceneobjectdata.entity player_entity_tween( 0, tweenin, !viewmodelvisible, stopxcam );
            }
        }
    }
    
    typefunc = sceneobjectdata object_get_func( "shotObjectSetup" );
    
    if ( isdefined( typefunc ) && typefunc != &function_8207af582343cc24 )
    {
        sceneobjectdata [[ typefunc ]]( shotindex, cameraanimation, shotanimations );
    }
    
    sceneobjectdata function_4e92f5a18dba45e9( sceneplay, shotindex );
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x9c171bd9, Offset: 0xc44e
// Size: 0x202
function private function_4e92f5a18dba45e9( sceneplay, shotindex )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "shotObjectPlayerVisUpdate" );
    
    if ( isdefined( typefunc ) && typefunc != &function_4e92f5a18dba45e9 )
    {
        sceneobjectdata [[ typefunc ]]( sceneplay, shotindex );
        return;
    }
    
    playervis = sceneobjectdata.sceneobject function_efc13d404c1080ac( shotindex );
    
    switch ( playervis )
    {
        case #"hash_3ad6948f3f563d6":
            var_dab149a7be99cf48 = sceneplay.var_e721f1409fd57ca9;
            var_301dbca30c15232a = 1;
            break;
        case #"hash_e5385d60528b88a5":
            var_dab149a7be99cf48 = arrayremove( level.players, sceneplay.var_e721f1409fd57ca9 );
            var_301dbca30c15232a = 1;
            break;
        case #"hash_53001182cd15d423":
            var_301dbca30c15232a = 0;
            break;
        default:
            var_dab149a7be99cf48 = sceneobjectdata.sceneroot.scenestatic.exclusiveplayers;
            var_301dbca30c15232a = isarray( sceneobjectdata.var_dab149a7be99cf48 ) || isarray( var_dab149a7be99cf48 );
            break;
    }
    
    if ( var_301dbca30c15232a )
    {
        animentities = sceneobjectdata function_f2fb9eed776f75ff();
        
        foreach ( animentity in animentities )
        {
            if ( !isent( animentity ) )
            {
                continue;
            }
            
            if ( isdefined( var_dab149a7be99cf48 ) )
            {
                animentity val::set( "scene_exclusive", "hide", var_dab149a7be99cf48 );
            }
            else
            {
                animentity val::reset( "scene_exclusive", "hide" );
            }
            
            sceneobjectdata.var_dab149a7be99cf48 = var_dab149a7be99cf48;
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x5f580c17, Offset: 0xc658
// Size: 0x4b
function private function_240bf4f132c66497( shotindex )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "shotObjectLinkSetup" );
    
    if ( isdefined( typefunc ) && typefunc != &function_240bf4f132c66497 )
    {
        return sceneobjectdata [[ typefunc ]]( shotindex );
    }
    
    return 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x6ec66e88, Offset: 0xc6ac
// Size: 0x17d
function private function_5a563c79ceb8a795( shotindex )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity val::reset_all( "scene_shot" );
        
        if ( isplayer( sceneobjectdata.entity ) )
        {
            tweenout = sceneobjectdata.sceneobject function_c602a792da7056a0( shotindex );
            
            if ( tweenout > 0 )
            {
                viewmodelvisible = sceneobjectdata.sceneobject function_1201bc2837054709( shotindex );
                stopxcam = sceneobjectdata.sceneobject function_e844c8047276c3f9( shotindex );
                
                /#
                    scene_debug::object_event( sceneobjectdata, "<dev string:x1b4>" + sceneobjectdata.entity getentitynumber(), sceneobjectdata.entity.origin, sceneobjectdata.entity.angles );
                #/
                
                sceneobjectdata.entity player_entity_tween( 1, tweenout, !viewmodelvisible, stopxcam );
            }
        }
    }
    
    if ( isent( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity notify( #"scene_shot_cleanup" );
    }
    
    sceneobjectdata notify( #"scene_shot_cleanup" );
    typefunc = sceneobjectdata object_get_func( "shotObjectCleanup" );
    
    if ( isdefined( typefunc ) && typefunc != &function_5a563c79ceb8a795 )
    {
        sceneobjectdata [[ typefunc ]]( shotindex );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x1741d65e, Offset: 0xc831
// Size: 0x136
function private function_6bf501072826e845( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    animations = [];
    objtype = sceneobject obj_get_type();
    
    switch ( objtype )
    {
        case #"hash_873689dd62a87ffa":
            shotanimations = sceneobject.variant_object.shots[ shotindex ].mayhemanimations;
            
            if ( isdefined( shotanimations ) )
            {
                for ( animationindex = 0; animationindex < shotanimations.size ; animationindex++ )
                {
                    animations[ animationindex ] = shotanimations[ animationindex ].mayhemanimation;
                }
            }
            
            break;
        default:
            shotanimations = sceneobject.variant_object.shots[ shotindex ].deltaanimations;
            
            if ( isdefined( shotanimations ) )
            {
                for ( animationindex = 0; animationindex < shotanimations.size ; animationindex++ )
                {
                    shotanimation = shotanimations[ animationindex ];
                    animasset = sceneobjectdata function_465d05ff89283a66( shotindex, shotanimation );
                    animations[ animationindex ] = animasset;
                }
            }
            
            break;
    }
    
    return animations;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x78758f12, Offset: 0xc970
// Size: 0x244
function private function_aa3437081a7dd2a0( shotanimation )
{
    sceneobjectdata = self;
    var_43311d6688d9decc = -1;
    var_d2942b08b86b0b86 = 0;
    var_beb4a9acfc094381 = 0;
    
    for ( var_a2e161411b434f94 = 0; var_a2e161411b434f94 < shotanimation.var_a629058043fe3322.size ; var_a2e161411b434f94++ )
    {
        var_b0a12cf0a7795191 = shotanimation.var_a629058043fe3322[ var_a2e161411b434f94 ];
        currentvalue = 0;
        var_e07576c4bdc084b8 = 0;
        
        if ( !isdefined( var_b0a12cf0a7795191.animation.id ) )
        {
            continue;
        }
        
        if ( var_b0a12cf0a7795191.gender )
        {
            var_a5aa079f6e0bb9d3 = sceneobjectdata function_58b62b656cb29e76() || sceneobjectdata.entity.operatorcustomization.gender == "female";
            var_8b2b350d60415d53 = var_b0a12cf0a7795191.gender == getxhash( "Female" );
            
            if ( var_8b2b350d60415d53 == var_a5aa079f6e0bb9d3 )
            {
                currentvalue++;
            }
            else
            {
                continue;
            }
        }
        
        if ( var_b0a12cf0a7795191.operatorskin )
        {
            if ( var_b0a12cf0a7795191.operatorskin == sceneobjectdata.var_c4d701311a34bc3c )
            {
                currentvalue += 2;
                var_e07576c4bdc084b8 = 1;
            }
            else
            {
                continue;
            }
        }
        
        if ( var_b0a12cf0a7795191.operator )
        {
            if ( var_b0a12cf0a7795191.operator == sceneobjectdata.var_878130757a0f3a61 )
            {
                currentvalue++;
                var_e07576c4bdc084b8 = 1;
            }
            else
            {
                continue;
            }
        }
        
        if ( var_b0a12cf0a7795191.weapon )
        {
            currentweapon = sceneobjectdata function_2b6fe9f287188c01();
            var_3da55e99e62ac433 = getxhash( currentweapon );
            
            if ( var_3da55e99e62ac433 == var_b0a12cf0a7795191.weapon )
            {
                currentvalue++;
            }
            else
            {
                continue;
            }
        }
        
        var_865b45c247cac920 = currentvalue > var_d2942b08b86b0b86;
        var_f5558a3c89bf2743 = currentvalue == var_d2942b08b86b0b86 && var_e07576c4bdc084b8 && !var_beb4a9acfc094381;
        
        if ( var_865b45c247cac920 || var_f5558a3c89bf2743 )
        {
            var_d2942b08b86b0b86 = currentvalue;
            var_43311d6688d9decc = var_a2e161411b434f94;
            var_beb4a9acfc094381 = var_e07576c4bdc084b8;
        }
    }
    
    if ( var_43311d6688d9decc > -1 )
    {
        return shotanimation.var_a629058043fe3322[ var_43311d6688d9decc ].animation.id;
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xa7ab9e72, Offset: 0xcbbd
// Size: 0x118
function private function_465d05ff89283a66( shotindex, shotanimation )
{
    sceneobjectdata = self;
    
    if ( isdefined( shotanimation.alternateanimations ) && isdefined( sceneobjectdata.animaltname ) )
    {
        for ( altnameidx = 0; altnameidx < sceneobjectdata.animaltname.size ; altnameidx++ )
        {
            hashindex = getxhash( sceneobjectdata.animaltname[ altnameidx ] );
            altanim = shotanimation.alternateanimations[ hashindex ];
            
            if ( isdefined( altanim.animation.id ) )
            {
                return altanim.animation.id;
            }
        }
    }
    
    if ( isdefined( shotanimation.var_a629058043fe3322 ) && shotanimation.var_a629058043fe3322.size > 0 )
    {
        animid = sceneobjectdata function_aa3437081a7dd2a0( shotanimation );
        
        if ( isdefined( animid ) )
        {
            return animid;
        }
    }
    
    return shotanimation.deltaanimation.id;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x4cd7f726, Offset: 0xccde
// Size: 0x152
function private function_87d0356b39cc55c7( shotindex, animationindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    shotanimations = sceneobject.variant_object.shots[ shotindex ].deltaanimations;
    
    if ( isdefined( shotanimations ) )
    {
        shotanimation = shotanimations[ animationindex ];
        
        if ( isdefined( shotanimation.alternateanimations ) )
        {
            altanim = shotanimation.alternateanimations[ #"serverarmsrig" ];
            
            if ( isdefined( altanim.animation.id ) )
            {
                return altanim.animation.id;
            }
        }
        
        if ( isdefined( shotanimation.var_a629058043fe3322 ) )
        {
            for ( var_a2e161411b434f94 = 0; var_a2e161411b434f94 < shotanimation.var_a629058043fe3322.size ; var_a2e161411b434f94++ )
            {
                var_b0a12cf0a7795191 = shotanimation.var_a629058043fe3322[ var_a2e161411b434f94 ];
                
                if ( isdefined( var_b0a12cf0a7795191.var_dd5d909761db8fd0 ) && var_b0a12cf0a7795191.var_dd5d909761db8fd0 )
                {
                    return var_b0a12cf0a7795191.animation.id;
                }
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xc06b0841, Offset: 0xce39
// Size: 0xb4
function private function_64466e4b9ed25e4c( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    
    if ( isplayer( sceneobjectdata.entity ) )
    {
        if ( sceneobject.variant_object.shots[ shotindex ].var_6d1caa948c9f0eb3 )
        {
            if ( sceneobjectdata.entity getcamerathirdperson() )
            {
                return;
            }
        }
    }
    
    cameraanimation = sceneobject.variant_object.shots[ shotindex ].cameraanimation;
    
    if ( cameraanimation == "" )
    {
        cameraanimation = undefined;
    }
    
    return cameraanimation;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe027f140, Offset: 0xcef6
// Size: 0x69, Type: bool
function private function_514b2f4dda4105ef( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    var_9a610c3ddeb968a6 = sceneobject function_18f1564ba0e28c5( shotindex );
    var_f3215d4735cea02f = !sceneobject.variant_object.var_ca0583007f3fc927;
    return var_9a610c3ddeb968a6 && var_f3215d4735cea02f;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x6b8f5bdf, Offset: 0xcf68
// Size: 0xff, Type: bool
function private function_7a4516ac3b008d7( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    var_321b4a288e57064f = istrue( shotobject.removeweapon );
    var_54a7695fe9771ba8 = istrue( sceneobject.variant_object.removeweapon );
    b_has_weapon_to_remove = undefined;
    
    if ( isplayer( sceneobjectdata.entity ) || !isdefined( sceneobjectdata.entity ) )
    {
        b_has_weapon_to_remove = 1;
    }
    else
    {
        entity_weapon = sceneobjectdata.entity.weapon;
        b_has_weapon_to_remove = isdefined( entity_weapon ) && !isnullweapon( entity_weapon );
    }
    
    if ( ( var_321b4a288e57064f || var_54a7695fe9771ba8 ) && b_has_weapon_to_remove )
    {
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8f83b2be, Offset: 0xd070
// Size: 0x5c, Type: bool
function private function_9ac3c230848eee95( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.var_4e81bbeb05c06014 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xca408baa, Offset: 0xd0d5
// Size: 0x5c, Type: bool
function private function_3e768ed8916f0542( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.var_b296b7b37154feec );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x713c199b, Offset: 0xd13a
// Size: 0x79
function private function_bb5b08e9ff4407ee( shotindex, overridetype, overridevalue )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.shotoverrides ) )
    {
        sceneobjectdata.shotoverrides = [];
    }
    
    if ( !isdefined( sceneobjectdata.shotoverrides[ overridetype ] ) )
    {
        sceneobjectdata.shotoverrides[ overridetype ] = [];
    }
    
    sceneobjectdata.shotoverrides[ overridetype ][ shotindex ] = overridevalue;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x1fa032b9, Offset: 0xd1bb
// Size: 0x65
function private function_aa1705ea1d6cddfa( shotindex, overridetype )
{
    sceneobjectdata = self;
    assert( isint( shotindex ) );
    
    if ( !isdefined( sceneobjectdata.shotoverrides ) )
    {
        return;
    }
    
    if ( !isdefined( sceneobjectdata.shotoverrides[ overridetype ] ) )
    {
        return;
    }
    
    return sceneobjectdata.shotoverrides[ overridetype ][ shotindex ];
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x85b819e1, Offset: 0xd229
// Size: 0x35, Type: bool
function private function_9a1b14ef2ca6596f()
{
    sceneobjectdata = self;
    objtype = sceneobjectdata object_get_type();
    return objtype == "Types_XCam" || objtype == "Types_Mayhem";
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xcffd317, Offset: 0xd267
// Size: 0x3cf
function private function_11c95ca4a274fbdb( shotindexes, sceneplay, sceneobjectindex )
{
    sceneobjectdata = self;
    scenedata = sceneobjectdata.scenedata;
    scenestatic = sceneobjectdata.sceneroot.scenestatic;
    
    if ( sceneobjectdata.sceneobject function_5c6f9c08917e11e6() || sceneobjectdata.var_bf1c906895c88a1b )
    {
        return 0;
    }
    
    if ( scenestatic.excludeplayers && sceneobjectdata object_get_type() == "Types_Player" )
    {
        return 0;
    }
    
    /#
        if ( getdvarint( @"scr_debug_scene_exclude_players", 0 ) && sceneobjectdata object_get_type() == "<dev string:x1c6>" || getdvarint( @"scr_debug_scene_exclude_ai", 0 ) && sceneobjectdata object_get_type() == "<dev string:x1d3>" )
        {
            return 0;
        }
        
        if ( getdvarint( @"scr_debug_scene_exclude_props", 0 ) && sceneobjectdata object_get_type() == "<dev string:x1df>" )
        {
            return 0;
        }
    #/
    
    if ( scenestatic.var_9e562de25765fd05 && sceneobjectdata object_get_type() != "Types_Player" )
    {
        return 0;
    }
    
    if ( !isarray( shotindexes ) )
    {
        shotindexes = [ shotindexes ];
    }
    
    if ( sceneobjectdata.sceneobject function_1fcfdc7f5267fb97() )
    {
        return 0;
    }
    
    if ( scenestatic.var_854da17aefaac034 && sceneobjectdata object_get_type() == "Types_XCam" && scenestatic.var_854da17aefaac034 != sceneobjectdata.sceneobject obj_get_name() )
    {
        return 0;
    }
    
    result = 0;
    animated = sceneobjectdata function_fd41f2c45f2ff86a();
    
    foreach ( shotindex in shotindexes )
    {
        var_839923cce2b81937 = sceneobjectdata function_ba7dd0b6fdbc2793( shotindex );
        
        if ( var_839923cce2b81937 == "ForceNotInvolved" )
        {
            continue;
        }
        else if ( var_839923cce2b81937 == "ForceInvolved" )
        {
            if ( isdefined( sceneplay ) && isdefined( sceneobjectindex ) )
            {
                if ( !isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
                {
                    sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] = [];
                }
                
                sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ][ shotindex ] = 1;
                result = 1;
            }
            else
            {
                return 1;
            }
            
            continue;
        }
        
        doeshide = sceneobjectdata.sceneobject function_32571802b2e452ec( shotindex );
        doesshow = sceneobjectdata.sceneobject function_dd5572420d3225( shotindex );
        
        if ( !sceneobjectdata.nonvisible && ( !animated || doeshide || doesshow ) )
        {
            if ( isdefined( sceneplay ) && isdefined( sceneobjectindex ) )
            {
                if ( !isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
                {
                    sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] = [];
                }
                
                sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ][ shotindex ] = 1;
                result = 1;
            }
            else
            {
                return 1;
            }
            
            continue;
        }
        
        shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
        cameraanimation = sceneobjectdata function_64466e4b9ed25e4c( shotindex );
        
        if ( shotanimations.size != 0 || isdefined( cameraanimation ) )
        {
            if ( isdefined( sceneplay ) && isdefined( sceneobjectindex ) )
            {
                if ( !isdefined( sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] ) )
                {
                    sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ] = [];
                }
                
                sceneplay.var_caf7bc39e6b19dd5[ sceneobjectindex ][ shotindex ] = 1;
                result = 1;
                continue;
            }
            
            return 1;
        }
    }
    
    return result;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x554639a5, Offset: 0xd63f
// Size: 0x45
function private function_ba7dd0b6fdbc2793( shotindex )
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.shots[ shotindex ].forceinvolved;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x21949745, Offset: 0xd68d
// Size: 0x20
function private object_get_type()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject obj_get_type();
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xc0881004, Offset: 0xd6b6
// Size: 0x216
function private object_lookat_target( shotindex, enable )
{
    sceneobjectdata = self;
    
    if ( !( isdefined( anim.var_7a467f51952fc7be ) && isdefined( anim.var_89690e2f5b3c4893 ) ) || !isent( sceneobjectdata.entity ) )
    {
        return;
    }
    
    if ( enable )
    {
        lookbehavior = sceneobjectdata.sceneobject function_42b2d28bdc6a24c2( shotindex );
        
        if ( isdefined( lookbehavior ) )
        {
            sceneobjectdata.entity val::set( "scene_shot", "look_behavior", lookbehavior );
        }
    }
    
    if ( isdefined( sceneobjectdata.var_259086f4136ca3af ) )
    {
        sceneobjectdata.entity notify( #"object_lookat_target" );
        sceneobjectdata.entity [[ anim.var_89690e2f5b3c4893 ]]( sceneobjectdata.var_259086f4136ca3af );
        sceneobjectdata.var_259086f4136ca3af = undefined;
    }
    
    if ( enable )
    {
        targetname = sceneobjectdata.sceneobject function_2f5f32051e506c1a( shotindex );
        
        if ( isdefined( targetname ) )
        {
            if ( tolower( targetname ) == "player" )
            {
                [ sceneobjectdata.var_259086f4136ca3af ] = utility::get_array_of_closest( sceneobjectdata.entity.origin, level.players );
            }
            else
            {
                sceneroot = sceneobjectdata.sceneroot;
                var_969ce076455a514d = sceneroot get_object( targetname );
                
                if ( isdefined( var_969ce076455a514d ) )
                {
                    sceneobjectdata.var_259086f4136ca3af = var_969ce076455a514d function_15e572f4ed82dd1c();
                }
                
                if ( !isdefined( sceneobjectdata.var_259086f4136ca3af ) )
                {
                    sceneobjectdata.var_259086f4136ca3af = get_global_ent_or_struct( targetname );
                }
            }
            
            if ( isdefined( sceneobjectdata.var_259086f4136ca3af ) )
            {
                sceneobjectdata.entity utility::delaythreadendon( level.framedurationseconds, [ "scene_shot_cleanup", "object_lookat_target" ], anim.var_7a467f51952fc7be, sceneobjectdata.var_259086f4136ca3af );
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x55d78055, Offset: 0xd8d4
// Size: 0x19b
function private function_ede93dead318f379( entity )
{
    sceneobjectdata = self;
    
    if ( isdefined( entity ) )
    {
        body = undefined;
        head = undefined;
        hat = undefined;
        
        if ( isdefined( sceneobjectdata.sceneobject.variant_object.overridebody ) )
        {
            body = sceneobjectdata.sceneobject.variant_object.overridebody;
        }
        
        if ( isdefined( sceneobjectdata.sceneobject.variant_object.overridehead ) )
        {
            head = sceneobjectdata.sceneobject.variant_object.overridehead;
        }
        
        if ( isdefined( sceneobjectdata.sceneobject.variant_object.overridehat ) )
        {
            hat = sceneobjectdata.sceneobject.variant_object.overridehat;
        }
        
        if ( isdefined( head ) || isdefined( body ) || isdefined( hat ) )
        {
            if ( !isdefined( body ) )
            {
                body = entity.model;
            }
            
            if ( !isdefined( head ) )
            {
                head = entity.headmodel;
            }
            
            if ( !isdefined( hat ) )
            {
                hat = entity.hatmodel;
            }
            
            if ( isdefined( body ) )
            {
                entity detachall();
                entity setmodel( body );
            }
            
            if ( isdefined( head ) || isdefined( hat ) )
            {
                entity detachall();
                
                if ( isdefined( head ) )
                {
                    entity attach( head );
                }
                
                if ( isdefined( hat ) )
                {
                    entity attach( hat );
                }
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x8916fb48, Offset: 0xda77
// Size: 0xb
function private obj_get_type()
{
    return self.variant_type;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1e43950c, Offset: 0xda8b
// Size: 0x53
function private function_e497f52b15295ba5()
{
    sceneobject = self;
    animtype = "DeltaAnimation";
    
    if ( sceneobject obj_get_type() == "Types_Mayhem" )
    {
        animtype = "MayhemAnimation";
    }
    else if ( sceneobject obj_get_type() == "Types_XCam" )
    {
        animtype = "CameraAnimation";
    }
    
    return animtype;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x4149aaf6, Offset: 0xdae7
// Size: 0x113
function private function_fc09a0af0b50d3d4()
{
    sceneobject = self;
    
    if ( sceneobject obj_get_type() == "Types_ClientChar" )
    {
        return;
    }
    
    if ( isdefined( sceneobject.variant_object.aitypename ) )
    {
        return "aitype";
    }
    
    if ( isdefined( sceneobject.variant_object.charactername ) )
    {
        return "character";
    }
    
    if ( sceneobject.variant_object vehicle::get_ref() || sceneobject.variant_object.vehiclename )
    {
        return "vehicle";
    }
    
    if ( isdefined( sceneobject.variant_object.xcompositemodelname ) )
    {
        return "xcompositemodel";
    }
    
    if ( isdefined( sceneobject.variant_object.xmodelname ) )
    {
        return "xmodel";
    }
    
    if ( isdefined( sceneobject.variant_object.operatorskinname ) )
    {
        return "operatorskin";
    }
    
    if ( isdefined( sceneobject.variant_object.bulletweaponname ) )
    {
        return "bulletweapon";
    }
    
    return "mayhem";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x88f18e9c, Offset: 0xdc03
// Size: 0x150
function private function_ccb2b599f3b8ef77()
{
    sceneobject = self;
    
    if ( sceneobject obj_get_type() == "Types_ClientChar" )
    {
        return;
    }
    
    if ( isdefined( sceneobject.variant_object.aitypename ) )
    {
        return sceneobject.variant_object.aitypename;
    }
    
    if ( isdefined( sceneobject.variant_object.charactername ) )
    {
        return sceneobject.variant_object.charactername;
    }
    
    if ( isdefined( sceneobject.variant_object.vehiclename ) )
    {
        return sceneobject.variant_object.vehiclename;
    }
    
    if ( isdefined( sceneobject.variant_object.xcompositemodelname ) )
    {
        return sceneobject.variant_object.xcompositemodelname;
    }
    
    if ( isdefined( sceneobject.variant_object.operatorskinname ) )
    {
        return sceneobject.variant_object.operatorskinname;
    }
    
    if ( isdefined( sceneobject.variant_object.bulletweaponname ) )
    {
        return sceneobject.variant_object.bulletweaponname;
    }
    
    return sceneobject.variant_object.xmodelname;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x94a6d11a, Offset: 0xdd5c
// Size: 0x25, Type: bool
function private function_16e90b61b72fb539()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.noscriptables );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe6fa406c, Offset: 0xdd8a
// Size: 0x3f
function private function_6280c600ae0d180d()
{
    sceneobject = self;
    
    if ( isdefined( sceneobject.variant_object.var_f8a7bf5180afeefa ) )
    {
        return sceneobject.variant_object.var_f8a7bf5180afeefa;
    }
    
    return 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xdb1961e2, Offset: 0xddd2
// Size: 0x24
function private obj_get_name()
{
    sceneobject = self;
    return sceneobject.variant_object.name;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x2bb6035b, Offset: 0xddff
// Size: 0x25, Type: bool
function private function_e3e0913c7903daa4()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.firstframe );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xfcf640e1, Offset: 0xde2d
// Size: 0x4d, Type: bool
function private function_669f3ba695235683( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return isdefined( shotobject ) && shotobject.firstframeonly;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x9d3b9d75, Offset: 0xde83
// Size: 0x25, Type: bool
function private function_5c6f9c08917e11e6()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.disabled );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1ac58b2, Offset: 0xdeb1
// Size: 0x2c, Type: bool
function private function_772de5acb2e194c7()
{
    sceneobject = self;
    return sceneobject.variant_object.deletetype ?? "None";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x174d0768, Offset: 0xdee6
// Size: 0x2c, Type: bool
function private function_37b12fc2df71936b()
{
    sceneobject = self;
    return sceneobject.variant_object.globaltype ?? "None";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xbe85b699, Offset: 0xdf1b
// Size: 0x25, Type: bool
function private function_6ea442b0feacbc1()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.takedamage );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xc0af75c, Offset: 0xdf49
// Size: 0x25, Type: bool
function private function_6ff76756d536e49a()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.var_b1188d6a6c31ca63 );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf9ce85a9, Offset: 0xdf77
// Size: 0x28, Type: bool
function private function_8d6340a41bdf10ed()
{
    sceneobject = self;
    return sceneobject.variant_object.clientcharacterindex ?? 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe4c1334c, Offset: 0xdfa8
// Size: 0x25, Type: bool
function private function_1fcfdc7f5267fb97()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.var_f5a633a119babf80 );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x2ef6ef02, Offset: 0xdfd6
// Size: 0x25, Type: bool
function private function_93b14828f5b45de6()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.var_4710a4012f0c88cd );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x405a25a5, Offset: 0xe004
// Size: 0x48
function private function_4641057744100c08()
{
    sceneobject = self;
    
    if ( isdefined( sceneobject.variant_object.animtree ) )
    {
        return sceneobject.variant_object.animtree.id;
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xdff53f6c, Offset: 0xe055
// Size: 0x25, Type: bool
function private function_6b060c2167962186()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.strictmatching );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x4df3d1bc, Offset: 0xe083
// Size: 0x25, Type: bool
function private function_af186866fc828d5d()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.var_c25c6de963c32422 );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x2df9309, Offset: 0xe0b1
// Size: 0x25, Type: bool
function private function_641be9c20b5bac24()
{
    sceneobject = self;
    return istrue( sceneobject.variant_object.var_137797a1eb1eeb5c );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xee39dc1a, Offset: 0xe0df
// Size: 0x11a
function private function_b1e1b14a9d31f8a6()
{
    sceneobject = self;
    objtype = sceneobject obj_get_type();
    result = [];
    
    for ( shotindex = 0; shotindex < sceneobject.variant_object.shots.size ; shotindex++ )
    {
        switch ( objtype )
        {
            case #"hash_873689dd62a87ffa":
                if ( sceneobject.variant_object.shots[ shotindex ].mayhemanimations.size > 0 )
                {
                    result[ "MayhemAnimation" ] = 1;
                    return result;
                }
                
                break;
            default:
                if ( sceneobject.variant_object.shots[ shotindex ].deltaanimations.size > 0 )
                {
                    result[ "DeltaAnimation" ] = 1;
                }
                
                if ( isdefined( sceneobject.variant_object.shots[ shotindex ].cameraanimation ) )
                {
                    result[ "CameraAnimation" ] = 1;
                }
                
                break;
        }
    }
    
    return result;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x6c0c0c4e, Offset: 0xe202
// Size: 0x1a4
function private function_38883b88ad46a4f4( shotindex, animindex )
{
    sceneobject = self;
    var_a9b8dffd45b33087 = 0;
    var_9f35e59f5c1e4176 = 0;
    displacementtime = 0;
    
    if ( shotindex < 0 || shotindex > sceneobject.variant_object.shots.size - 1 )
    {
        return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087 };
    }
    
    shotanimations = sceneobject.variant_object.shots[ shotindex ].deltaanimations;
    
    if ( isdefined( shotanimations ) )
    {
        animationcount = shotanimations.size;
        
        if ( animindex < 0 || animindex >= animationcount )
        {
            return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087 };
        }
        
        if ( isdefined( shotanimations[ animindex ].var_f6f8a8ec50691b27 ) )
        {
            var_a9b8dffd45b33087 = shotanimations[ animindex ].var_f6f8a8ec50691b27 * 0.0333333;
        }
        
        if ( isdefined( shotanimations[ animindex ].var_a11f28bba26a8a90 ) )
        {
            var_9f35e59f5c1e4176 = shotanimations[ animindex ].var_a11f28bba26a8a90 * 0.0333333;
        }
        
        if ( isdefined( shotanimations[ animindex ].var_e464b7d134f1c21e ) )
        {
            displacementtime = shotanimations[ animindex ].var_e464b7d134f1c21e * 0.0333333;
        }
    }
    
    return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087 };
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xdc9a6599, Offset: 0xe3af
// Size: 0xbf
function private function_1222280fb003fd62( animasset, animationvalues, var_f9dcb446e1a74465 )
{
    fulllen = getanimlength( animasset );
    
    if ( fulllen <= 0 )
    {
        return 0;
    }
    
    starttrim = animationvalues.var_a9b8dffd45b33087 ?? 0;
    endtrim = animationvalues.var_9f35e59f5c1e4176 ?? 0;
    trimmedlen = fulllen - starttrim - endtrim;
    
    if ( trimmedlen <= 0 )
    {
        return ( starttrim / fulllen );
    }
    
    var_f9dcb446e1a74465 = clamp( var_f9dcb446e1a74465 ?? 0, 0, 1 );
    return ( starttrim + var_f9dcb446e1a74465 * trimmedlen ) / fulllen;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x2669648c, Offset: 0xe477
// Size: 0x272
function private function_7e8812fa38dae41a( shotindex, animindex )
{
    sceneobject = self;
    lengthtime = 0;
    var_a9b8dffd45b33087 = 0;
    var_9f35e59f5c1e4176 = 0;
    displacementtime = 0;
    
    if ( "Types_Mayhem" != sceneobject obj_get_type() )
    {
        return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087, #lengthtime:lengthtime };
    }
    
    if ( shotindex < 0 || shotindex > sceneobject.variant_object.shots.size - 1 )
    {
        return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087, #lengthtime:lengthtime };
    }
    
    shotanimations = sceneobject.variant_object.shots[ shotindex ].mayhemanimations;
    
    if ( isdefined( shotanimations ) )
    {
        animationcount = shotanimations.size;
        
        if ( animindex < 0 || animindex >= animationcount )
        {
            return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087, #lengthtime:lengthtime };
        }
        
        if ( isdefined( shotanimations[ animindex ].var_df8fcdc36a2877f2 ) )
        {
            var_a9b8dffd45b33087 = shotanimations[ animindex ].var_df8fcdc36a2877f2 * 0.0333333;
        }
        
        if ( isdefined( shotanimations[ animindex ].var_4cedae18481cbf1d ) )
        {
            var_9f35e59f5c1e4176 = shotanimations[ animindex ].var_4cedae18481cbf1d * 0.0333333;
        }
        
        if ( isdefined( shotanimations[ animindex ].var_9a02bb5bb1acf129 ) )
        {
            displacementtime = shotanimations[ animindex ].var_9a02bb5bb1acf129 * 0.0333333;
        }
        
        if ( isdefined( shotanimations[ animindex ].framecount ) && isdefined( shotanimations[ animindex ].framerate ) )
        {
            lengthtime = shotanimations[ animindex ].framecount * 1 / float( shotanimations[ animindex ].framerate );
            lengthtime = max( lengthtime - var_a9b8dffd45b33087 - var_9f35e59f5c1e4176, 0 );
        }
    }
    
    return { #displacementtime:displacementtime, #var_9f35e59f5c1e4176:var_9f35e59f5c1e4176, #var_a9b8dffd45b33087:var_a9b8dffd45b33087, #lengthtime:lengthtime };
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x95785de9, Offset: 0xe6f2
// Size: 0x142
function private function_1f6c27c082e5d59c( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    starttrim = 0;
    endtrim = 0;
    
    if ( shotindex < 0 || shotindex > sceneobject.variant_object.shots.size - 1 )
    {
        return { #endtrim:endtrim, #starttrim:starttrim };
    }
    
    if ( isdefined( sceneobject.variant_object.shots[ shotindex ].var_9a6034be137070d4 ) )
    {
        starttrim = sceneobject.variant_object.shots[ shotindex ].var_9a6034be137070d4 * 0.0333333;
    }
    
    if ( isdefined( sceneobject.variant_object.shots[ shotindex ].var_3cdf8c49268bbc13 ) )
    {
        endtrim = sceneobject.variant_object.shots[ shotindex ].var_3cdf8c49268bbc13 * 0.0333333;
    }
    
    return { #endtrim:endtrim, #starttrim:starttrim };
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb0076b63, Offset: 0xe83d
// Size: 0x60
function private function_e93b454561075f4a( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    
    if ( isdefined( shotobject.deathanim ) )
    {
        return shotobject.deathanim.id;
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9b667bcf, Offset: 0xe8a6
// Size: 0x46
function private function_fc193fefe28dad3e( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_e48b02e5abc87d9c;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x11e86aa, Offset: 0xe8f5
// Size: 0x47, Type: bool
function private function_18f1564ba0e28c5( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return !shotobject.var_ca0583007f3fc927;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x364855fa, Offset: 0xe945
// Size: 0x47, Type: bool
function private function_32571802b2e452ec( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.preparehide );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x364855fa, Offset: 0xe995
// Size: 0x47, Type: bool
function private function_dd5572420d3225( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.prepareshow );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xa9924427, Offset: 0xe9e5
// Size: 0x4e, Type: bool
function private function_efc13d404c1080ac( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.playervis ?? "All";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe268b341, Offset: 0xea3c
// Size: 0x4b, Type: bool
function private function_a7e0b6b74f965439( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.castshadows ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x1feb900b, Offset: 0xea90
// Size: 0x47, Type: bool
function private function_9ba0e21c7f6dad44( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.castshadowsrig );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x10f18778, Offset: 0xeae0
// Size: 0x47, Type: bool
function private function_599407b70d85262c( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.takedamage );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xd5757864, Offset: 0xeb30
// Size: 0x47, Type: bool
function private function_aea14e0e13bbd667( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.teleport );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x78735987, Offset: 0xeb80
// Size: 0x47, Type: bool
function private function_ac528c4b94dc121f( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.preparekeepanim );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9a4ffcb2, Offset: 0xebd0
// Size: 0x4e, Type: bool
function private function_27059363c715d947( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.float_lerptime ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x3196df39, Offset: 0xec27
// Size: 0x4e, Type: bool
function private function_1c54677f7be74c59( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.float_blendtime ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe61442a5, Offset: 0xec7e
// Size: 0x4e, Type: bool
function private function_e4fd4fd04ed73e1b( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.blendcurve ?? "linear";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xa1699a6c, Offset: 0xecd5
// Size: 0x46
function private function_2f5f32051e506c1a( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.lookattarget;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x6120dd1c, Offset: 0xed24
// Size: 0x4e, Type: bool
function private function_42b2d28bdc6a24c2( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.lookbehavior ?? "ai_default";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x5c3d7b4e, Offset: 0xed7b
// Size: 0x4e, Type: bool
function private function_d59e2a5bf7ebcf90( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.reachtype ?? "Teleport";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x33e1937, Offset: 0xedd2
// Size: 0x4e, Type: bool
function private function_5e398dcb8782e632( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.arrivaltype ?? "Exposed";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x79f074af, Offset: 0xee29
// Size: 0x4e, Type: bool
function private function_274782f8d123ede4( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.demeanorstart ?? "DEFAULT";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xeb56ebbd, Offset: 0xee80
// Size: 0x4e, Type: bool
function private function_22704d940236cf5d( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.demeanorend ?? "DEFAULT";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xba5c8b26, Offset: 0xeed7
// Size: 0x4e, Type: bool
function private function_60303d122294b28e( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.locomotionstart ?? "DEFAULT";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xcdb5b932, Offset: 0xef2e
// Size: 0x4a, Type: bool
function private function_f0f1ea94325df082( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_a9c545f88b5b304f ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe0f32e9, Offset: 0xef81
// Size: 0x4e, Type: bool
function private function_3c6fe393ccd02d3c( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.weaponuse ?? "DropQuick";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xc94ce0f3, Offset: 0xefd8
// Size: 0x4b, Type: bool
function private function_96ce751feb7dd9c9( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.weaponswitch ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x493ef730, Offset: 0xf02c
// Size: 0x4a, Type: bool
function private function_b978488b0468bee7( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.weaponoffhand ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x369adc33, Offset: 0xf07f
// Size: 0x52
function private function_80e82120471ba03a( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return tolower( shotobject.stancebegin ?? "stand" );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x331771ed, Offset: 0xf0da
// Size: 0x52
function private function_528210ecf3ecc9b6( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return tolower( shotobject.stanceend ?? "stand" );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x7741649a, Offset: 0xf135
// Size: 0x4e, Type: bool
function private function_89fc99d65ff5fa32( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_99c38e67f1583381 ?? 0.25;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9db1fb22, Offset: 0xf18c
// Size: 0x4e, Type: bool
function private function_3edf045e2a509a2e( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_cd17c16afc14ac4b ?? 0.25;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x6071c009, Offset: 0xf1e3
// Size: 0x4e, Type: bool
function private function_63f6c994d6f29a13( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_9e469a3d0954c900 ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x7790039a, Offset: 0xf23a
// Size: 0x4a, Type: bool
function private function_5200dc4f3cd33282( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_2f48c14c4400c4e8 ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x3f0b31a0, Offset: 0xf28d
// Size: 0x47, Type: bool
function private function_e90795a54254dbaa( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.stancematch );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x6de49a22, Offset: 0xf2dd
// Size: 0x4b, Type: bool
function private function_e138e9b97f54f49c( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_97e58f008f0d6fc1 ?? 45;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe9a402db, Offset: 0xf331
// Size: 0x4b, Type: bool
function private function_1ddc5aeafdb7a9d2( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.playerviewarcenabled ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8a96d1c6, Offset: 0xf385
// Size: 0x4b, Type: bool
function private function_ffaa41b71b8c5dc9( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_f72b1222ac044722 ?? 45;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xa782790e, Offset: 0xf3d9
// Size: 0x4b, Type: bool
function private function_dbfd130ece46c860( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_24988a14c97c8bb ?? 15;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2d1685ce, Offset: 0xf42d
// Size: 0x4b, Type: bool
function private function_cf806cfc65d6c9e( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_a815fbabb5f0ea63 ?? 15;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x1815f2ad, Offset: 0xf481
// Size: 0x4b, Type: bool
function private function_82593eb0d840ae91( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.usetagangles ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe7691348, Offset: 0xf4d5
// Size: 0x47, Type: bool
function private function_b97cb81433e705a5( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.autocenter );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xee3c89b4, Offset: 0xf525
// Size: 0x4e, Type: bool
function private function_640261b8d0d5cba4( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.float_viewfraction ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9fa84551, Offset: 0xf57c
// Size: 0x4a, Type: bool
function private function_8c27db859ca12a4f( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.noanimwait ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x4a57c6fc, Offset: 0xf5cf
// Size: 0x4a, Type: bool
function private function_c68f88c2b5f207d3( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.nospawn ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x743306d7, Offset: 0xf622
// Size: 0x4e, Type: bool
function private function_abc779ad811bdf13( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.cameratweenin ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xd932ba89, Offset: 0xf679
// Size: 0x4b, Type: bool
function private function_3f64f25a6a59bb06( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.cameratweeninvisible ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x760375be, Offset: 0xf6cd
// Size: 0x4a, Type: bool
function private function_7136c10c7e8929fa( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.cameratweeninstopxcam ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb3110b6, Offset: 0xf720
// Size: 0x4e, Type: bool
function private function_c602a792da7056a0( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.cameratweenout ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x49366f80, Offset: 0xf777
// Size: 0x4b, Type: bool
function private function_1201bc2837054709( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.cameratweenoutvisible ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb413c7af, Offset: 0xf7cb
// Size: 0x4a, Type: bool
function private function_e844c8047276c3f9( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.cameratweenoutstopxcam ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9a4f6cf5, Offset: 0xf81e
// Size: 0x4b, Type: bool
function private function_618b92dbb2955a1a( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.xcamfirstperson ?? 1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x93d5c9e8, Offset: 0xf872
// Size: 0x4a, Type: bool
function private function_8d495684dbf8f02b( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.xcamthirdperson ?? 0;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xdc81a7ea, Offset: 0xf8c5
// Size: 0x4a, Type: bool
function private function_89d3a2e8f36b1cf4( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_423dc3e955f2bb2e ?? 0;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xf6911e5, Offset: 0xf918
// Size: 0x115
function private vehicle_spawn_ent( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    entity = undefined;
    sceneobjectassettype = sceneobjectdata.sceneobject function_fc09a0af0b50d3d4();
    sceneobjectassetname = sceneobjectdata.sceneobject function_ccb2b599f3b8ef77();
    
    if ( sceneobjectassettype == "vehicle" )
    {
        skinoverride = undefined;
        hybridscriptbundle = function_568f797e7642c672( "vehicle", sceneobjectassetname );
        
        if ( isdefined( hybridscriptbundle ) )
        {
            skinoverride = hybridscriptbundle.bundle.skinoverride;
        }
        
        modelname = undefined;
        
        if ( isdefined( skinoverride ) && skinoverride != "" )
        {
            modelname = skinoverride + "::" + vehicle_modelname( sceneobjectassetname );
        }
        else
        {
            modelname = vehicle_modelname( sceneobjectassetname );
        }
        
        entity = spawnvehicle( modelname, "scene_system_vehicle", sceneobjectassetname, spawnorigin, spawnangles );
        
        if ( isdefined( entity ) )
        {
            entity useanimtree( sceneobjectdata.sceneobject function_4641057744100c08() );
        }
    }
    
    return entity;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xc923079a, Offset: 0xfa36
// Size: 0x3b, Type: bool
function private function_20b1309c9e58e1e6( entity )
{
    if ( entity.classname == "script_vehicle" )
    {
        return true;
    }
    
    if ( entity.classname == "script_model" )
    {
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x63c46d8b, Offset: 0xfa7a
// Size: 0x57
function private function_247fd4fdf1e19551( shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    vehicle = sceneobjectdata.entity;
    
    if ( isdefined( vehicle ) && vehicle vehicle_isphysveh() )
    {
        vehicle vehphys_forcekeyframedmotion();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x16661d3c, Offset: 0xfad9
// Size: 0xec
function private vehicle_stop_anim()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity notify( #"stop_loop" );
        sceneobjectdata.entity notify( #"single anim", "end" );
        sceneobjectdata.entity notify( #"looping anim", "end" );
        sceneobjectdata.entity notify( #"stop_animmode" );
        sceneobjectdata.entity notify( #"vehicle_scene_stop" );
        sceneobjectdata.entity stopanimscripted();
        
        if ( sceneobjectdata.entity vehicle_isphysveh() )
        {
            sceneobjectdata.entity function_d2b8ee2e1275daaf( 0 );
            sceneobjectdata.entity vehphys_setdefaultmotion();
            return;
        }
        
        sceneobjectdata.entity solid();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1661b232, Offset: 0xfbcd
// Size: 0x1a9
function private function_8ac744fc3e7dee()
{
    scenescriptbundle = self;
    sceneobjectcount = scenescriptbundle function_bd663a9606d90ac1();
    
    for ( sceneobjectindex = 0; sceneobjectindex < sceneobjectcount ; sceneobjectindex++ )
    {
        sceneobject = scenescriptbundle function_45cf04bf56228582( sceneobjectindex );
        sceneobjectassettype = sceneobject function_fc09a0af0b50d3d4();
        sceneobjectassetname = sceneobject function_ccb2b599f3b8ef77();
        
        if ( !isdefined( sceneobjectassetname ) )
        {
            continue;
        }
        
        if ( !isdefined( sceneobjectassettype ) )
        {
            continue;
        }
        
        if ( sceneobjectassettype == "aitype" )
        {
        }
        else if ( sceneobjectassettype == "character" )
        {
            character = getxhashasset( sceneobjectassetname );
        }
        else if ( sceneobjectassettype == "vehicle" )
        {
            modelname = vehicle_modelname( sceneobjectassetname );
            
            if ( modelname != "" )
            {
                precachemodel( modelname );
            }
        }
        else if ( sceneobjectassettype == "operatorskin" )
        {
            models = get_operatorskin_models( sceneobjectassetname );
            
            if ( models.isvalid )
            {
                precachemodel( models.body );
                precachemodel( models.head );
            }
        }
        else if ( sceneobjectassettype == "bulletweapon" )
        {
        }
        else
        {
            precachemodel( sceneobjectassetname );
        }
        
        if ( isdefined( sceneobject.variant_object.overridebody ) )
        {
            precachemodel( sceneobject.variant_object.overridebody );
        }
        
        if ( isdefined( sceneobject.variant_object.overridehead ) )
        {
            precachemodel( sceneobject.variant_object.overridehead );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x3075fc9a, Offset: 0xfd7e
// Size: 0x182
function private client_character_spawn( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    luaindex = sceneobjectdata.sceneobject function_8d6340a41bdf10ed();
    characterindex = luaindex - 1;
    
    if ( !isdefined( level.client_characters ) )
    {
        level.client_characters = [];
    }
    
    spawnorigin = sceneobjectdata.alignmentinfo.origin;
    spawnangles = sceneobjectdata.alignmentinfo.angles;
    entity = level.client_characters[ characterindex ];
    
    if ( !isdefined( entity ) )
    {
        entity = spawn( "script_character", spawnorigin, 0, 0, characterindex, "MPClientCharacter" );
        level.client_characters[ characterindex ] = entity;
    }
    
    if ( isdefined( entity ) )
    {
        entity val::set( "scene_scene", "cinematics_participant", 1 );
        entity.angles = spawnangles;
        entity.origin = spawnorigin;
        
        if ( getdvarint( @"hash_204f67bbaa6705ea", 0 ) && getdvarint( @"hash_bf4836935350bfc0", 1 ) )
        {
            entity function_76025bf1685180e2( 1 );
        }
    }
    
    entity show();
    var_a475b2d5a1199e43 = function_bf960a70adcedd68();
    
    if ( isdefined( var_a475b2d5a1199e43 ) )
    {
        entity setmodel( var_a475b2d5a1199e43 );
        entity useanimtree( sceneobjectdata.sceneobject function_4641057744100c08() );
    }
    
    sceneobjectdata.entity = entity;
    return entity;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x366205bb, Offset: 0xff09
// Size: 0x7e, Type: bool
function private function_dd0009340cb25d87( entity )
{
    sceneobjectdata = self;
    
    if ( getdvarint( @"hash_c609cebf6abef30", 0 ) )
    {
        if ( isdefined( entity ) && entity.classname == "script_character" )
        {
            entitycharacterindex = entity.characterindex;
            objectcharacterindex = sceneobjectdata.sceneobject function_8d6340a41bdf10ed() - 1;
            return ( entitycharacterindex == objectcharacterindex );
        }
    }
    
    return false;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x147f8c08, Offset: 0xff90
// Size: 0x171
function private function_bf960a70adcedd68()
{
    if ( !isdefined( level.var_33e8b386492841c7 ) )
    {
        level.var_33e8b386492841c7 = level.projectbundle.var_35f2bfd0ee424080;
        
        if ( !isdefined( level.var_33e8b386492841c7 ) )
        {
            gamemodebundle = level.gamemodebundle;
            operatorlistbundle = getoperatorlistscriptbundle( gamemodebundle.operatorlist );
            validoperatorref = undefined;
            
            foreach ( operatorentry in operatorlistbundle.operatorlist )
            {
                if ( isdefined( operatorentry.operator ) )
                {
                    validoperatorref = operatorentry.operator;
                    break;
                }
            }
            
            assert( isdefined( validoperatorref ), "<dev string:x1ea>" );
            defaultoperator = getoperatorscriptbundle( validoperatorref );
            defaultskin = getoperatorskinscriptbundle( defaultoperator.defaultskin );
            var_c2f7e4641e292c16 = getscriptbundle( defaultskin.body );
            level.var_33e8b386492841c7 = var_c2f7e4641e292c16.defaultbody;
        }
    }
    
    return level.var_33e8b386492841c7;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x85698cbc, Offset: 0x1010a
// Size: 0x38
function private function_2535ce3d8e09fa05( animname, animtree )
{
    if ( isdefined( self.entity ) )
    {
        self.entity.animname = animname;
    }
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0x9c681abf, Offset: 0x1014b
// Size: 0x9c
function private function_27be1a15599d865c( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime )
{
    n_length = function_58a93a40f02daed7( shotindex, animasset, "DeltaAnimation", animindex );
    n_displacement = function_e751e9405d8ce670( shotindex, "DeltaAnimation", animindex );
    n_total_time = n_length + n_displacement;
    wait n_total_time;
    return n_total_time;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x3bbfe179, Offset: 0x101f0
// Size: 0x2
function private function_4450d8e5e58a15fe()
{
    
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x74689fd7, Offset: 0x101fb
// Size: 0x61
function private client_character_teleport( origin, angles )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity.origin = origin;
        sceneobjectdata.entity.angles = angles;
    }
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xb8dbf40f, Offset: 0x10264
// Size: 0x30
function private client_character_link( sceneplay, alignmentinfo, inittype, lerptime, initializing )
{
    
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x275a978e, Offset: 0x1029d
// Size: 0x64b
function private function_83bfd4c94b262c65( sceneroot, shotindex, objectindex, prevalignmentinfo )
{
    scenescriptbundle = self;
    
    if ( isdefined( prevalignmentinfo ) && prevalignmentinfo.shotindex === shotindex )
    {
        if ( prevalignmentinfo.var_8f099063c7618054 && !isent( prevalignmentinfo.alignent ) )
        {
            var_969ce076455a514d = sceneroot get_object( prevalignmentinfo.aligntarget );
            
            if ( isdefined( var_969ce076455a514d ) )
            {
                aligntarget = var_969ce076455a514d function_15e572f4ed82dd1c();
                
                if ( isent( aligntarget ) )
                {
                    prevalignmentinfo.alignobjectindex = var_969ce076455a514d.index;
                    prevalignmentinfo.alignent = aligntarget;
                    prevalignmentinfo.origin = aligntarget.origin ?? ( 0, 0, 0 );
                    prevalignmentinfo.angles = aligntarget.angles ?? ( 0, 0, 0 );
                }
            }
        }
        
        return prevalignmentinfo;
    }
    
    alignmentinfo = spawnstruct();
    alignmentinfo.aligntarget = undefined;
    alignmentinfo.aligntag = undefined;
    alignmentinfo.alignent = undefined;
    alignmentinfo.alignobjectindex = undefined;
    alignmentinfo.var_8f099063c7618054 = undefined;
    alignmentinfo.originoffset = ( 0, 0, 0 );
    alignmentinfo.anglesoffset = ( 0, 0, 0 );
    alignmentinfo.shotindex = shotindex;
    shot = scenescriptbundle bundle_get_shot( shotindex );
    sceneobject = scenescriptbundle function_45cf04bf56228582( objectindex );
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    aligncheck = [ shotobject, sceneobject.variant_object, shot.variant_object, scenescriptbundle ];
    
    for ( aligncheckindex = 0; aligncheckindex < aligncheck.size ; aligncheckindex++ )
    {
        alignobj = aligncheck[ aligncheckindex ];
        
        if ( isdefined( alignobj.aligntarget ) )
        {
            alignmentinfo.aligntarget = alignobj.aligntarget;
            
            if ( isdefined( alignobj.aligntargettag ) )
            {
                alignmentinfo.aligntag = tolower( alignobj.aligntargettag );
            }
            
            break;
        }
    }
    
    alignmentinfo.originoffset += get_offset_vector( shotobject.var_53f05c59f875d40a, shotobject.var_53f05d59f875d63d, shotobject.var_53f05a59f875cfa4 );
    alignmentinfo.anglesoffset += get_offset_vector( shotobject.var_d8037ffae060ee24, shotobject.var_d80380fae060f057, shotobject.var_d80381fae060f28a );
    alignmentinfo.originoffset += get_offset_vector( sceneobject.variant_object.var_53f05c59f875d40a, sceneobject.variant_object.var_53f05d59f875d63d, sceneobject.variant_object.var_53f05a59f875cfa4 );
    alignmentinfo.anglesoffset += get_offset_vector( sceneobject.variant_object.var_d8037ffae060ee24, sceneobject.variant_object.var_d80380fae060f057, sceneobject.variant_object.var_d80381fae060f28a );
    alignmentinfo.originoffset += get_offset_vector( shot.variant_object.var_53f05c59f875d40a, shot.variant_object.var_53f05d59f875d63d, shot.variant_object.var_53f05a59f875cfa4 );
    alignmentinfo.anglesoffset += get_offset_vector( shot.variant_object.var_d8037ffae060ee24, shot.variant_object.var_d80380fae060f057, shot.variant_object.var_d80381fae060f28a );
    alignmentinfo.originoffset += get_offset_vector( scenescriptbundle.var_53f05c59f875d40a, scenescriptbundle.var_53f05d59f875d63d, scenescriptbundle.var_53f05a59f875cfa4 );
    alignmentinfo.anglesoffset += get_offset_vector( scenescriptbundle.var_d8037ffae060ee24, scenescriptbundle.var_d80380fae060f057, scenescriptbundle.var_d80381fae060f28a );
    aligntarget = undefined;
    
    if ( !sceneroot.var_ddb502ad28f6362d && isdefined( alignmentinfo.aligntarget ) )
    {
        var_969ce076455a514d = sceneroot get_object( alignmentinfo.aligntarget );
        
        if ( isdefined( var_969ce076455a514d ) )
        {
            alignmentinfo.var_8f099063c7618054 = 1;
            aligntarget = var_969ce076455a514d function_15e572f4ed82dd1c();
            
            if ( isdefined( aligntarget ) )
            {
                alignmentinfo.alignobjectindex = var_969ce076455a514d.index;
            }
        }
        
        if ( !isdefined( aligntarget ) )
        {
            aligntarget = get_global_ent_or_struct( alignmentinfo.aligntarget );
            
            if ( isdefined( aligntarget ) && isdefined( aligntarget.sceneobjectdata ) )
            {
                alignmentinfo.alignobjectindex = aligntarget.sceneobjectdata.index;
            }
        }
    }
    
    if ( !isdefined( aligntarget ) )
    {
        aligntarget = sceneroot;
    }
    
    alignmentinfo.alignent = aligntarget;
    alignmentinfo.origin = alignmentinfo.alignent.origin ?? ( 0, 0, 0 );
    alignmentinfo.angles = alignmentinfo.alignent.angles ?? ( 0, 0, 0 );
    return alignmentinfo;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf863021e, Offset: 0x108f1
// Size: 0x1b, Type: bool
function private function_cf6d109b139cfdbf()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.bool_skippable );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x8b228878, Offset: 0x10915
// Size: 0x1b, Type: bool
function private function_2ae71d4375525d5a()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.bool_gameplay );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xa550f0cf, Offset: 0x10939
// Size: 0x1b, Type: bool
function private function_c7c350c8df3d0e0a()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.var_75f0f6409c3cfa98 );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe3a2b4fe, Offset: 0x1095d
// Size: 0x1b, Type: bool
function private function_18b6837bdb9e4208()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.bool_looping );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xbd7cc69, Offset: 0x10981
// Size: 0x1b, Type: bool
function private function_f38a33a196064424()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.bool_cinematicmotion );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x79a7c2b1, Offset: 0x109a5
// Size: 0x1b, Type: bool
function private function_26e347b43304e05e()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.noscriptables );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf39f7732, Offset: 0x109c9
// Size: 0x22, Type: bool
function private function_a9260c3d77b784c3()
{
    scenescriptbundle = self;
    return scenescriptbundle.var_2d5be34ad37dc02b ?? "None";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x30c6377, Offset: 0x109f4
// Size: 0x22, Type: bool
function private function_4ce73dcda6de9f22()
{
    scenescriptbundle = self;
    return scenescriptbundle.var_2f4981e3dd60abe4 ?? "None";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf863021e, Offset: 0x10a1f
// Size: 0x1b, Type: bool
function private function_f4f80fb91ec747f3()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.bool_letterbox );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xd71659aa, Offset: 0x10a43
// Size: 0x1e, Type: bool
function private function_fe0a6ac8d702190f()
{
    scenescriptbundle = self;
    return scenescriptbundle.letterboxlerptime ?? 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x2bda8045, Offset: 0x10a6a
// Size: 0x1f, Type: bool
function private function_cf08117a77afbc1e()
{
    scenescriptbundle = self;
    return scenescriptbundle.autocleanup ?? 1;
}

// Namespace scene
// Params 0
// Checksum 0x612a5854, Offset: 0x10a92
// Size: 0x1b
function function_bd663a9606d90ac1()
{
    scenescriptbundle = self;
    return scenescriptbundle.objects.size;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9b6ee5d9, Offset: 0x10ab6
// Size: 0x27
function private function_45cf04bf56228582( index )
{
    scenescriptbundle = self;
    return scenescriptbundle.objects[ index ];
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1ae71336, Offset: 0x10ae6
// Size: 0xa9
function private function_8666fb2470ee0b61()
{
    scenescriptbundle = self;
    
    foreach ( sceneobject in scenescriptbundle.objects )
    {
        charindex = sceneobject function_8d6340a41bdf10ed();
        
        if ( charindex > 0 )
        {
            sceneobject.variant_type = "Types_ClientChar";
        }
    }
}

// Namespace scene
// Params 0
// Checksum 0x4662bc5f, Offset: 0x10b97
// Size: 0x1b
function function_30fd977cf5a4a95e()
{
    scenescriptbundle = self;
    return scenescriptbundle.shots.size;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8477a955, Offset: 0x10bbb
// Size: 0x27
function private bundle_get_shot( index )
{
    scenescriptbundle = self;
    return scenescriptbundle.shots[ index ];
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x66efc0f3, Offset: 0x10beb
// Size: 0x7e
function private function_33df3c1b6a1cdf25( shotindex, timeoutms )
{
    shot = bundle_get_shot( shotindex );
    
    if ( !isdefined( shot ) || !isdefined( shot.variant_object ) )
    {
        return -1;
    }
    
    collection = shot.variant_object.var_f4c776d49172271e;
    
    if ( !collection )
    {
        return -1;
    }
    
    timeoutms = max( timeoutms, 1000 );
    return function_57b963e4635ebcf9( collection, timeoutms );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1d6e1945, Offset: 0x10c72
// Size: 0x1b, Type: bool
function private function_789e0fbad5b7e8e1()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.var_24c9eef4d3db8bc3 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x91c49432, Offset: 0x10c96
// Size: 0xef
function private function_965b893bb918d34d( var_3556b15f71d46b40 )
{
    scenescriptbundle = self;
    var_4c519aad39052750 = isstring( var_3556b15f71d46b40 );
    b_isint = isint( var_3556b15f71d46b40 );
    
    foreach ( index, shot in scenescriptbundle.shots )
    {
        if ( !isdefined( var_3556b15f71d46b40 ) )
        {
            return index;
        }
        
        if ( b_isint && var_3556b15f71d46b40 == index )
        {
            return index;
        }
        
        if ( var_4c519aad39052750 && shot.variant_object.name == var_3556b15f71d46b40 )
        {
            return index;
        }
    }
    
    return -1;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb89f6f08, Offset: 0x10d8e
// Size: 0x2d
function private function_d74f9d413aca8704( index )
{
    scenescriptbundle = self;
    return scenescriptbundle.shots[ index ] shot_get_name();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe454361f, Offset: 0x10dc4
// Size: 0x1b, Type: bool
function private function_4f6556149db5309e()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.autostream );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xa7dca15, Offset: 0x10de8
// Size: 0x22, Type: bool
function private function_e676aa1c58e71d88()
{
    scenescriptbundle = self;
    return scenescriptbundle.var_66e170b4aea88741 ?? "AnimScripted";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xd739481c, Offset: 0x10e13
// Size: 0x22, Type: bool
function private function_cf01ff8a72173036()
{
    scenescriptbundle = self;
    return scenescriptbundle.var_621ac137db968583 ?? "Default";
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x86134638, Offset: 0x10e3e
// Size: 0x78
function private function_d12c299f7ca4bf79( shotname )
{
    scenescriptbundle = self;
    foundshotindex = undefined;
    shotcount = scenescriptbundle function_30fd977cf5a4a95e();
    
    for ( shotindex = 0; shotindex < shotcount ; shotindex++ )
    {
        shot = scenescriptbundle bundle_get_shot( shotindex );
        
        if ( shot shot_get_name() == shotname )
        {
            foundshotindex = shotindex;
            break;
        }
    }
    
    return foundshotindex;
}

// Namespace scene
// Params 0
// Checksum 0x4e6553f7, Offset: 0x10ebf
// Size: 0x1b, Type: bool
function function_7f138cc8a9e70cf4()
{
    scenescriptbundle = self;
    return istrue( scenescriptbundle.disablehud );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x85ea6c6d, Offset: 0x10ee3
// Size: 0x2c
function private shot_get_name()
{
    shot = self;
    
    if ( !isdefined( shot ) )
    {
        return;
    }
    
    return shot.variant_object.name;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x880a8b63, Offset: 0x10f18
// Size: 0x25, Type: bool
function private function_22dbcb174ae164e7()
{
    shot = self;
    return istrue( shot.variant_object.disableshot );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xfb1fa7a8, Offset: 0x10f46
// Size: 0x29, Type: bool
function private function_207777fd99d7a922()
{
    shot = self;
    return shot.variant_object.autostream ?? 1;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x6cea4254, Offset: 0x10f78
// Size: 0x3c, Type: bool
function private function_9f4fd3f147cf9375()
{
    shot = self;
    
    /#
        if ( getdvarint( @"hash_b279d32f047f16db", 0 ) )
        {
            return true;
        }
    #/
    
    return istrue( shot.variant_object.syncend );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe3f57424, Offset: 0x10fbd
// Size: 0x24
function private function_c9e351e000109356()
{
    shot = self;
    return shot.variant_object.preparehide;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xb3b0613c, Offset: 0x10fea
// Size: 0x24
function private function_87e703acab37289f()
{
    shot = self;
    return shot.variant_object.prepareshow;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x75072dce, Offset: 0x11017
// Size: 0x24
function private function_a694d6b567b8f510()
{
    shot = self;
    return shot.variant_object.completehide;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x2b81bc63, Offset: 0x11044
// Size: 0x24
function private function_6f4f7d54201dbbb()
{
    shot = self;
    return shot.variant_object.completeshow;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x925b13b3, Offset: 0x11071
// Size: 0x15
function private mayhem_spawn( alignmentinfo, shotinit )
{
    
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x183c78d6, Offset: 0x1108e
// Size: 0xdd
function private function_fc408f57f842ae( shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    
    if ( sceneobjectdata.sceneobject function_32571802b2e452ec( shotindex ) )
    {
        if ( !isdefined( sceneobjectdata.mayhemname ) )
        {
            sceneobjectdata mayhem_first_frame( sceneobjectdata.alignmentinfo );
        }
        
        if ( isdefined( sceneobjectdata.mayhemname ) )
        {
            hidemayhem( sceneobjectdata.mayhemname );
        }
    }
    
    if ( sceneobjectdata.sceneobject function_dd5572420d3225( shotindex ) )
    {
        if ( !isdefined( sceneobjectdata.mayhemname ) )
        {
            sceneobjectdata mayhem_first_frame( sceneobjectdata.alignmentinfo );
        }
        
        if ( isdefined( sceneobjectdata.mayhemname ) )
        {
            showmayhem( sceneobjectdata.mayhemname );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x2212d429, Offset: 0x11173
// Size: 0x9c
function private mayhem_first_frame( alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    
    if ( !isdefined( shotindex ) )
    {
        shotindex = sceneobjectdata.sceneplay.shotinit;
    }
    
    shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
    
    if ( shotanimations.size != 0 )
    {
        sceneobjectdata thread mayhem_play_anim( sceneobjectdata.sceneplay.shotinit, shotindex, "mayhem", alignmentinfo, shotanimations[ 0 ], 0, 0, 0, 0, "MayhemAnimation" );
        pausemayhem( sceneobjectdata.mayhemname );
    }
}

// Namespace scene
// Params 10, eflags: 0x4
// Checksum 0x974a72a8, Offset: 0x11217
// Size: 0x22b
function private mayhem_play_anim( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype )
{
    sceneobjectdata = self;
    sceneobjectdata mayhem_delete();
    
    if ( !isdefined( level.scene.mayhemindex ) )
    {
        level.scene.mayhemindex = 0;
    }
    
    level.scene.mayhemindex++;
    sceneobjectdata.mayhemname = sceneobjectdata.sceneroot.script_scenescriptbundle + "_mayhem" + level.scene.mayhemindex;
    update_alignment_transform( alignmentinfo );
    mayhem_time_values = sceneobjectdata.sceneobject function_7e8812fa38dae41a( shotindex, animindex );
    animlengthtrimmed = mayhem_time_values.lengthtime;
    var_a9b8dffd45b33087 = mayhem_time_values.var_a9b8dffd45b33087;
    displacementtime = mayhem_time_values.displacementtime;
    
    if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) || var_142c2c5d44216f2a > 0 )
    {
        displacementtime = 0;
    }
    
    if ( animlengthtrimmed <= 0 )
    {
        return 0;
    }
    
    var_142c2c5d44216f2a = clamp( var_142c2c5d44216f2a ?? 0, 0, 1 );
    starttime = var_a9b8dffd45b33087 + animlengthtrimmed * var_142c2c5d44216f2a;
    waitlen = max( 0, animlengthtrimmed - animlengthtrimmed * var_142c2c5d44216f2a );
    
    if ( displacementtime > 0 )
    {
        wait displacementtime;
    }
    
    spawnmayhem( sceneobjectdata.mayhemname, animasset, alignmentinfo.origin, alignmentinfo.angles );
    function_a6b3bbd0c6c366dc( sceneobjectdata.mayhemname, starttime );
    utility::waittill_match_or_timeout( notifystring, "end", waitlen );
    return displacementtime + waitlen;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x7b04b1d7, Offset: 0x1144b
// Size: 0x18
function private function_4f1730d1da8c5710()
{
    sceneobjectdata = self;
    sceneobjectdata mayhem_delete();
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1f3eb1c0, Offset: 0x1146b
// Size: 0x39
function private mayhem_delete()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.mayhemname ) )
    {
        killmayhem( sceneobjectdata.mayhemname );
        sceneobjectdata.mayhemname = undefined;
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xc47e62ad, Offset: 0x114ac
// Size: 0x15
function private xcam_spawn( alignmentinfo, shotinit )
{
    
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xd96b0844, Offset: 0x114c9
// Size: 0x4f2
function private function_e770a2937db5fd28( shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    
    if ( !isdefined( cameraanimation ) )
    {
        return;
    }
    
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    letterbox = scenescriptbundle function_f4f80fb91ec747f3();
    letterboxlerptime = scenescriptbundle function_fe0a6ac8d702190f();
    xcamplayers = sceneobjectdata function_931d12df9abebc7f( shotindex );
    disable_hud = scenescriptbundle function_7f138cc8a9e70cf4();
    sceneobjectdata.xcamplayers = xcamplayers;
    sceneobjectdata.xcamplayers = function_5713d46873b29625( sceneobjectdata.xcamplayers );
    
    if ( letterbox )
    {
        foreach ( player in xcamplayers )
        {
            player function_f6d96a431ef86a5( 1, letterboxlerptime );
        }
    }
    
    foreach ( player in xcamplayers )
    {
        player val::set( "scene_scene_xcam", "cinematic_motion", scenescriptbundle function_f38a33a196064424() );
        player val::set( "scene_scene_xcam", "anim_adjust_transfer", scenescriptbundle function_a9260c3d77b784c3() == "AdjustStartFrame" );
    }
    
    if ( disable_hud )
    {
        foreach ( player in xcamplayers )
        {
            player val::set( "scene_scene_xcam", "show_hud", 0 );
        }
    }
    
    if ( sceneobjectdata.sceneobject function_32571802b2e452ec( shotindex ) )
    {
        foreach ( player in xcamplayers )
        {
            player val::set( "scene_shot_xcam", "hide", 2 );
            player val::set( "scene_shot_xcam", "ignoreall", 1 );
            player val::set( "scene_shot_xcam", "ignoreme", 1 );
            player val::set( "scene_shot_xcam", "fire", 0 );
        }
    }
    
    if ( sceneobjectdata.sceneobject function_dd5572420d3225( shotindex ) )
    {
        foreach ( player in xcamplayers )
        {
            player val::reset( "scene_shot_xcam", "hide" );
            player show();
            player val::reset( "scene_shot_xcam", "ignoreall" );
            player val::reset( "scene_shot_xcam", "ignoreme" );
            player val::reset( "scene_shot_xcam", "fire" );
        }
    }
    
    tweenin = sceneobjectdata.sceneobject function_abc779ad811bdf13( shotindex );
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    
    if ( tweenin > 0 )
    {
        foreach ( player in xcamplayers )
        {
            if ( sceneobjectdata function_7a4516ac3b008d7( shotindex ) )
            {
                player val::set( "scene_shot_xcam", "take_weapons", 1 );
            }
            
            stopxcam = sceneobjectdata.sceneobject function_7136c10c7e8929fa( shotindex );
            
            /#
                scene_debug::object_event( sceneobjectdata, "<dev string:x1a3>" + player getentitynumber(), player.origin, player.angles );
            #/
            
            player player_entity_tween( 0, tweenin, 1, stopxcam );
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x34694442, Offset: 0x119c3
// Size: 0x12a
function private function_ce4a84e6cdf6ee71( shotindex )
{
    sceneobjectdata = self;
    tweenout = sceneobjectdata.sceneobject function_c602a792da7056a0( shotindex );
    players = sceneobjectdata function_931d12df9abebc7f( shotindex );
    utility::array_thread( players, &val::reset_all, "scene_shot_xcam" );
    
    if ( tweenout > 0 )
    {
        foreach ( player in players )
        {
            stopxcam = sceneobjectdata.sceneobject function_e844c8047276c3f9( shotindex );
            
            /#
                scene_debug::object_event( sceneobjectdata, "<dev string:x1b4>" + player getentitynumber(), player.origin, player.angles );
            #/
            
            player player_entity_tween( 1, tweenout, 1, stopxcam );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xba11783, Offset: 0x11af5
// Size: 0x15
function private xcam_first_frame( alignmentinfo, shotindex )
{
    
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x3cf407e, Offset: 0x11b12
// Size: 0x146
function private function_524845ca311375cd( sceneplay, shotindex )
{
    sceneobjectdata = self;
    sceneobjectdata update_alignment_transform( sceneobjectdata.alignmentinfo );
    
    if ( isdefined( sceneobjectdata.alignmentinfo ) )
    {
        cameraanimation = sceneobjectdata function_64466e4b9ed25e4c( shotindex );
        
        if ( isdefined( cameraanimation ) )
        {
            players = sceneobjectdata function_931d12df9abebc7f( shotindex );
            
            foreach ( player in players )
            {
                streamcameraorigin = player getxcamposition( cameraanimation, 0, 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles );
                
                if ( isdefined( streamcameraorigin ) )
                {
                    /#
                        scene_debug::object_event( sceneobjectdata, "<dev string:x198>", streamcameraorigin, ( 0, 0, 0 ) );
                    #/
                    
                    sceneplay function_495a812f7545da04( player, streamcameraorigin );
                }
            }
        }
    }
}

// Namespace scene
// Params 10, eflags: 0x4
// Checksum 0xd1d43224, Offset: 0x11c60
// Size: 0x209
function private xcam_play_anim( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype )
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
    players = sceneobjectdata function_931d12df9abebc7f( shotindex );
    
    foreach ( player in players )
    {
        sceneobjectdata childthread function_3368cba813eece14( "scene_shot_xcam", player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex );
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
// Checksum 0xfa0b990d, Offset: 0x11e72
// Size: 0x459
function private function_3368cba813eece14( valgroup, player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex )
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
        scene_debug::object_event( sceneobjectdata, "<dev string:x212>" + shotindex, alignmentinfo.origin, alignmentinfo.angles );
    #/
    
    waittime = 0;
    player val::set( valgroup, "cg_drawcrosshair", 0 );
    player val::set( valgroup, "freezecontrols", 1 );
    player val::set( valgroup, "freezecontrols_allowlook", 1 );
    player val::set( valgroup, "show_legs_and_shadow", 0 );
    gameplay = sceneobjectdata.sceneroot function_de0c3faf7f92b366();
    
    if ( !gameplay )
    {
        player val::set( valgroup, "show_hud_names", 0 );
        player val::set( valgroup, "allow_equipment_wheel", 0 );
        player val::set( valgroup, "allow_ping", 0 );
    }
    
    values = level.scene.values[ "Types_Player" ][ gameplay ];
    
    if ( isdefined( values ) )
    {
        foreach ( valname, value in values )
        {
            player val::set( valgroup, valname, value );
        }
    }
    
    if ( animasset != "" )
    {
        timevalues = function_1f6c27c082e5d59c( shotindex );
        starttrim = timevalues.starttrim;
        endtrim = timevalues.endtrim;
        starttime = starttrim;
        
        if ( var_142c2c5d44216f2a > 0 )
        {
            starttime = starttrim + ( getxcamlength( animasset ) - starttrim - endtrim ) * var_142c2c5d44216f2a;
        }
        
        var_3ca631df22ba91e8 = !sceneobjectdata.sceneobject function_89d3a2e8f36b1cf4( shotindex );
        var_c4e84a1d620c3008 = function_e4f8202c937ebe9();
        thirdpersonplayer = sceneobjectdata.sceneobject function_8d495684dbf8f02b( shotindex );
        firstpersonplayer = sceneobjectdata.sceneobject function_618b92dbb2955a1a( shotindex );
        player notify( #"scene_play_xcam" );
        
        if ( isent( alignmentinfo.alignent ) )
        {
            alignent = alignmentinfo.alignent;
            
            if ( isdefined( alignmentinfo.alignent.var_3544485fbc851ac2 ) )
            {
                aligntag = alignmentinfo.alignent.var_3544485fbc851ac2;
            }
            else if ( isdefined( alignmentinfo.aligntag ) && alignmentinfo.aligntag != "" )
            {
                aligntag = alignmentinfo.aligntag;
            }
        }
        
        if ( isdefined( alignent ) && isdefined( aligntag ) )
        {
            player playxcamontag( animasset, 0, alignent, aligntag, starttime, 1, var_3ca631df22ba91e8, var_c4e84a1d620c3008, thirdpersonplayer, firstpersonplayer );
        }
        else
        {
            player playxcam( animasset, 0, alignmentinfo.origin, alignmentinfo.angles, starttime, 1, var_3ca631df22ba91e8, var_c4e84a1d620c3008, thirdpersonplayer, firstpersonplayer );
        }
        
        if ( var_c4e84a1d620c3008 )
        {
            if ( sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036() == "UseOffset" )
            {
                player function_dc6d1931148169ed( 1 );
            }
        }
        
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
// Params 3, eflags: 0x4
// Checksum 0x55a0d858, Offset: 0x122d4
// Size: 0x77
function private function_516be5ef89c77c57( shotindex, animasset, var_142c2c5d44216f2a )
{
    timevalues = function_1f6c27c082e5d59c( shotindex );
    cameraanimationtime = getxcamlength( animasset ) - timevalues.starttrim - timevalues.endtrim;
    
    if ( var_142c2c5d44216f2a > 0 )
    {
        starttime = cameraanimationtime * var_142c2c5d44216f2a;
        cameraanimationtime -= starttime;
    }
    
    return cameraanimationtime;
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0xe85e97fd, Offset: 0x12354
// Size: 0x39
function private function_a2ff48defd65ed33( alignmentinfo, animasset, notifystring, var_142c2c5d44216f2a, var_ab6f54ef0991868f, animationtype )
{
    
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xe53af06, Offset: 0x12395
// Size: 0x1a
function private function_ff81a969d869304e()
{
    sceneobjectdata = self;
    sceneobjectdata xcam_delete( 1 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb50fd6e7, Offset: 0x123b7
// Size: 0x157
function private xcam_delete( var_48d758a6e255795d )
{
    sceneobjectdata = self;
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    letterbox = scenescriptbundle function_f4f80fb91ec747f3();
    letterboxlerptime = scenescriptbundle function_fe0a6ac8d702190f();
    players = sceneobjectdata function_931d12df9abebc7f( -1 );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.scenexcam.time ) && gettime() - player.scenexcam.time <= level.frameduration )
        {
            continue;
        }
        
        player stopxcam();
        
        if ( var_48d758a6e255795d )
        {
            player val::reset_all( "scene_scene_xcam" );
            
            if ( letterbox )
            {
                player function_f6d96a431ef86a5( 0, letterboxlerptime );
            }
        }
    }
    
    sceneobjectdata.xcamplaying = undefined;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x431f9a13, Offset: 0x12516
// Size: 0xd, Type: bool
function private function_78150143df380fd7( entity )
{
    return false;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xd1bee025, Offset: 0x1252c
// Size: 0x24
function private xcam_cleanup( newsceneroot )
{
    sceneobjectdata = self;
    sceneobjectdata xcam_delete( 1 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x8537dd35, Offset: 0x12558
// Size: 0x119
function private function_5f31e9fc1b086d5f( boolval )
{
    sceneobjectdata = self;
    players = sceneobjectdata.sceneroot.scenestatic.exclusiveplayers ?? level.players;
    
    foreach ( player in players )
    {
        if ( !isent( player ) )
        {
            continue;
        }
        
        if ( boolval )
        {
            player val::set( "scene_scene", "cinematics_participant", 1 );
            player val::set( "scene_scene", "allow_toggle_third_person", 0 );
            continue;
        }
        
        player val::reset( "scene_scene", "cinematics_participant" );
        player val::reset( "scene_scene", "allow_toggle_third_person" );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2a693d23, Offset: 0x12679
// Size: 0x144
function private function_931d12df9abebc7f( shotindex )
{
    sceneobjectdata = self;
    playervis = "All";
    
    if ( isdefined( shotindex ) )
    {
        if ( shotindex == -1 )
        {
            return sceneobjectdata.xcamplayers;
        }
        
        playervis = sceneobjectdata.sceneobject function_efc13d404c1080ac( shotindex );
    }
    
    switch ( playervis )
    {
        case #"hash_3ad6948f3f563d6":
            var_dab149a7be99cf48 = sceneobjectdata.sceneplay.var_e721f1409fd57ca9 ?? [];
            break;
        case #"hash_e5385d60528b88a5":
            var_dab149a7be99cf48 = arrayremove( level.players, sceneobjectdata.sceneplay.var_e721f1409fd57ca9 ?? [] );
            break;
        default:
            if ( isdefined( sceneobjectdata.xcamplayers ) )
            {
                sceneobjectdata.xcamplayers = function_5713d46873b29625( sceneobjectdata.xcamplayers );
            }
            
            var_dab149a7be99cf48 = sceneobjectdata.xcamplayers ?? sceneobjectdata.sceneroot.scenestatic.exclusiveplayers ?? level.players;
            break;
    }
    
    return function_5713d46873b29625( var_dab149a7be99cf48 );
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xf00dacb3, Offset: 0x127c6
// Size: 0x4b
function private prop_spawn_ent( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    entity = sceneobjectdata object_spawn_generic( spawnorigin, spawnangles );
    
    if ( isent( entity ) )
    {
        sceneobjectdata function_ede93dead318f379( entity );
    }
    
    return entity;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x26caa8f, Offset: 0x1281a
// Size: 0x3b
function private get_offset_vector( paramx = 0, paramy = 0, paramz = 0 )
{
    return ( paramx, paramy, paramz );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x7c5b2c39, Offset: 0x1285e
// Size: 0x1d1
function private update_alignment_transform( alignmentinfo )
{
    alignmentinfo.origin = ( 0, 0, 0 );
    alignmentinfo.angles = ( 0, 0, 0 );
    
    if ( isent( alignmentinfo.alignent ) && isdefined( alignmentinfo.aligntag ) )
    {
        alignmentinfo.origin = alignmentinfo.alignent gettagorigin( alignmentinfo.aligntag, 1, 0, 0 );
        
        if ( !isdefined( alignmentinfo.origin ) )
        {
            alignmentinfo.origin = ( 0, 0, 0 );
        }
        
        alignmentinfo.angles = alignmentinfo.alignent gettagangles( alignmentinfo.aligntag, 1, 0, 0 );
        
        if ( !isdefined( alignmentinfo.angles ) )
        {
            alignmentinfo.angles = ( 0, 0, 0 );
        }
    }
    else
    {
        if ( isdefined( alignmentinfo.alignent.origin ) )
        {
            alignmentinfo.origin = alignmentinfo.alignent.origin;
        }
        
        if ( isdefined( alignmentinfo.alignent.angles ) )
        {
            alignmentinfo.angles = alignmentinfo.alignent.angles;
        }
    }
    
    alignmentinfo.origin += rotatevector( alignmentinfo.originoffset, alignmentinfo.angles );
    alignmentinfo.angles = combineangles( alignmentinfo.angles, alignmentinfo.anglesoffset );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x7ec35489, Offset: 0x12a37
// Size: 0x1aa
function private function_84ed189dc2017575( notifystring, notifyitem, sceneobjectdata )
{
    entity = self;
    
    if ( !isent( self ) )
    {
        return;
    }
    
    if ( !( isdefined( notifystring ) && isdefined( notifyitem.notifyobject ) ) )
    {
        return;
    }
    
    if ( !notifyitem.notifyrepeat && notifyitem.notifytriggered )
    {
        return;
    }
    
    note = tolower( notifyitem.notifynote );
    singletonnotify = "ewnr_" + self getentitynumber() + "_" + notifystring + "_" + note + "_" + ( notifyitem.notifyrepeat ? "_r" : "" );
    notifyitem.notifyobject notify( singletonnotify );
    notifyitem.notifyobject endon( singletonnotify );
    waittillframeend();
    
    if ( notifyitem.notifynote != "end" )
    {
        entity thread function_572b0278363e08b7( notifystring, "end", "entity_wait_note_abort" );
        entity endon( #"entity_wait_note_abort" );
    }
    
    while ( true )
    {
        entity waittillmatch( notifystring, note );
        
        if ( isdefined( notifyitem.notifyobject ) )
        {
            if ( notifyitem.notifyrepeat || !notifyitem.notifytriggered )
            {
                notifyitem.notifyobject notify( notifyitem.notifynote );
                notifyitem.notifytriggered = 1;
            }
            
            if ( !notifyitem.notifyrepeat || notifyitem.notifynote == "end" )
            {
                return;
            }
        }
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xbf050007, Offset: 0x12be9
// Size: 0x3f
function private function_572b0278363e08b7( notifystring, match, notifyresult )
{
    entity = self;
    entity waittillmatch( notifystring, match );
    
    if ( isdefined( entity ) )
    {
        entity notify( notifyresult );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xcac65424, Offset: 0x12c30
// Size: 0x57
function private function_323ad75fb6c8b93( animasset )
{
    maxdist = 0;
    animtime = 0.25;
    
    while ( animtime <= 1 )
    {
        maxdist = max( maxdist, length( getmovedelta( animasset, 0, animtime ) ) );
        animtime += 0.25;
    }
    
    return maxdist;
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xf3c110b6, Offset: 0x12c90
// Size: 0x8b
function private function_2d3d749de2362f93( sceneplay, alignmentinfo, inittype, lerptime, initializing )
{
    sceneobjectdata = self;
    
    if ( initializing )
    {
        reachtype = sceneobjectdata.sceneobject function_d59e2a5bf7ebcf90( sceneplay.shotinit );
        
        if ( reachtype != "Teleport" )
        {
            update_alignment_transform( alignmentinfo );
            return;
        }
    }
    
    sceneobjectdata object_alignment_link_internal( sceneplay, alignmentinfo, inittype, lerptime );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x31d0cced, Offset: 0x12d23
// Size: 0x313
function private function_aa5b435587ec4d41( sceneplay, shotindex, objectindex )
{
    sceneobjectdata = self;
    sceneroot = sceneplay.sceneroot;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        aientity = sceneobjectdata.entity;
        demeanorstart = sceneobjectdata.sceneobject function_274782f8d123ede4( shotindex );
        locomotionstart = sceneobjectdata.sceneobject function_60303d122294b28e( shotindex );
        
        if ( demeanorstart != "DEFAULT" )
        {
            aientity val::set( "scene_shot", "demeanor", demeanorstart );
        }
        
        if ( sceneobjectdata function_7a4516ac3b008d7( shotindex ) )
        {
            aientity val::set( "scene_shot", "take_weapons", 1 );
        }
        
        if ( !sceneobjectdata.sceneroot function_de0c3faf7f92b366() )
        {
            aientity val::set( "scene_shot", "ignore_triggers", 1 );
            stealthreactlevel = sceneobjectdata function_e3a980d7b7e4538();
            
            if ( stealthreactlevel == "None" )
            {
                aientity val::set( "scene_shot", "ai_lightweight", 1 );
            }
        }
        
        if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) )
        {
            return;
        }
        
        reachtype = sceneobjectdata.sceneobject function_d59e2a5bf7ebcf90( shotindex );
        
        if ( reachtype != "Teleport" && sceneobjectdata.existingentity )
        {
            scenedata = sceneroot.scenedata;
            animasset = sceneobjectdata function_6bf501072826e845( shotindex )[ 0 ];
            
            if ( isdefined( animasset ) )
            {
                update_alignment_transform( sceneobjectdata.alignmentinfo );
                animstartorigin = getstartorigin( sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles, animasset );
                
                if ( distancesquared( aientity.origin, animstartorigin ) > squared( 16 ) )
                {
                    typefunc = sceneobjectdata object_get_func( "shotObjectStopAnim" );
                    
                    if ( isdefined( typefunc ) && typefunc != &function_2d0d8b2ed2c4709a )
                    {
                        sceneobjectdata [[ typefunc ]]();
                    }
                    
                    speed_baseline = reach_speed( demeanorstart, locomotionstart );
                    arrivaltype = undefined;
                    
                    if ( reachtype == "ReachArrive" )
                    {
                        arrivaltype = function_a792a1f58632796b( sceneobjectdata.sceneobject function_5e398dcb8782e632( shotindex ) );
                    }
                    
                    /#
                        scene_debug::object_event( sceneobjectdata, "<dev string:x218>", sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles );
                    #/
                    
                    sceneroot childthread scene_coordinated_reach( sceneplay, shotindex, speed_baseline, [ aientity, animasset, sceneobjectdata.alignmentinfo, arrivaltype ] );
                    aientity utility::waittill_any( "scene_coordinated_reach", "death_or_disconnect" );
                }
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x3f8d7610, Offset: 0x1303e
// Size: 0xfa
function private function_1ca92947a807ba17()
{
    sceneobjectdata = self;
    assert( isai( sceneobjectdata.entity ) );
    sceneobjectdata.entity endon( #"death_or_disconnect" );
    sceneobjectdata endon( #"scene_ai_stealth" );
    
    while ( isai( sceneobjectdata.entity ) )
    {
        lookatplayer = sceneobjectdata.entity function_e0fdabbc38d26482( 0.25 );
        
        if ( isdefined( lookatplayer ) && sceneobjectdata.var_d98952c22f4386d != lookatplayer )
        {
            sceneobjectdata.var_d98952c22f4386d = lookatplayer;
            sceneobjectdata.entity ai_lookat::enablelookatentity( sceneobjectdata.var_d98952c22f4386d );
        }
        else if ( isdefined( sceneobjectdata.var_d98952c22f4386d ) )
        {
            sceneobjectdata.entity ai_lookat::disablelookatentity( sceneobjectdata.var_d98952c22f4386d );
            sceneobjectdata.var_d98952c22f4386d = undefined;
        }
        
        waitframe();
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x52fe77cb, Offset: 0x13140
// Size: 0xc1
function private function_681a51f2cc596bd3( reactlevel )
{
    if ( reactlevel == "None" )
    {
        return;
    }
    
    sceneobjectdata = self;
    assert( isai( sceneobjectdata.entity ) );
    sceneobjectdata.entity endon( #"death_or_disconnect" );
    sceneobjectdata endon( #"scene_ai_stealth" );
    
    if ( reactlevel == "Investigate" )
    {
        sceneobjectdata.entity utility::waittillmatch_any_return( "stealth_state_change", 1, 3 );
    }
    else
    {
        sceneobjectdata.entity waittillmatch( #"stealth_state_change", 3 );
    }
    
    sceneobjectdata object_anim_end();
    sceneobjectdata function_2d0d8b2ed2c4709a();
    sceneobjectdata thread object_cleanup( undefined, 1 );
}

// Namespace scene
// Params 4, eflags: 0x4
// Checksum 0x578966b, Offset: 0x13209
// Size: 0xeb
function private function_eec9525757393421( attacker, inflictor, meansofdeath, objweapon )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        assert( isai( sceneobjectdata.entity ) );
        aientity = sceneobjectdata.entity;
        aientity.allowdeath = 1;
        aientity.deathanimmode = "nophysics";
        aientity.disabledeathorient = 1;
        aientity.noragdoll = 1;
        aientity.skipdeathanim = 1;
        aientity.diequietly = 1;
        
        if ( aientity.magic_bullet_shield )
        {
            aientity ai::stop_magic_bullet_shield();
        }
        
        aientity kill( undefined, attacker, inflictor, meansofdeath, objweapon );
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x9d38ccc9, Offset: 0x132fc
// Size: 0x36, Type: bool
function private function_e3a980d7b7e4538()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.stealthreact ?? "None";
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x45144e0f, Offset: 0x1333b
// Size: 0x2f, Type: bool
function private function_ad9c3b38f67b93f()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.navrepulsor );
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xab9593a6, Offset: 0x13373
// Size: 0xbc
function private get_global_ent_or_struct( searchname, ignorespawners = 1 )
{
    aligntargets = utility::getent_or_struct_array( searchname, "targetname", ignorespawners );
    
    if ( !isdefined( aligntargets ) || aligntargets.size == 0 )
    {
        aligntarget = utility::getent_or_struct_array( searchname, "script_noteworthy", ignorespawners );
    }
    
    if ( !isdefined( aligntargets ) || aligntargets.size == 0 )
    {
        aligntarget = utility::getent_or_struct_array( "_scene_global_" + searchname, "targetname", ignorespawners );
    }
    
    if ( !isdefined( aligntargets ) || aligntargets.size == 0 )
    {
        aligntarget = utility::getent_or_struct_array( "_scene_global_" + searchname, "script_noteworthy", ignorespawners );
    }
    
    if ( aligntargets.size > 1 )
    {
    }
    
    return aligntargets[ 0 ];
}

// Namespace scene
// Params 10, eflags: 0x4
// Checksum 0x9cd0e6d3, Offset: 0x13438
// Size: 0x9a
function private function_cef36d8c3e65c8c4( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectStoreAnimRequest" );
    
    if ( isdefined( typefunc ) )
    {
        sceneobjectdata [[ typefunc ]]( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype );
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x94852b8c, Offset: 0x134da
// Size: 0x52
function private function_b635d3c89c265ba4( animationtype, shotindex, animindex )
{
    sceneobjectdata = self;
    typefunc = sceneobjectdata object_get_func( "objectClearAnimRequest" );
    
    if ( isdefined( typefunc ) )
    {
        sceneobjectdata [[ typefunc ]]( animationtype, shotindex, animindex );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x329d29fa, Offset: 0x13534
// Size: 0x85
function private get_operatorskin_models( operatorskinassetname )
{
    valid = 0;
    bodymodel = undefined;
    headmodel = undefined;
    operatorskinbundle = getoperatorskinscriptbundle( operatorskinassetname );
    
    if ( isdefined( operatorskinbundle ) )
    {
        bodymodel = operatorskinbundle.bodymodel;
        headmodel = operatorskinbundle.headmodel;
        valid = 1;
    }
    
    return { #head:headmodel, #body:bodymodel, #isvalid:valid };
}

