// scripts\mp\scene.gsc  (hash_37c8c518abd07c24.gscc) (size: 46464 Bytes / 0xb580 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9a831f8 (2846372344)
// size ...... 46464 (0xb580)
// includes .. 17  (offset: 0xab7c)
// strings ... 107 (offset: 0xac04)
// dev strs .. 25  (offset: 0xb430)
// exports ... 97  (offset: 0x70b4)
// cseg ...... 0x7d5 + 0x68df (0x70b4)
// imports ... 344 (offset: 0x7fdc)
// animtree1 . 0   (offset: 0xb580)
// animtree2 . 0   (offset: 0xb580)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\common\visibility_mode;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\mp_agent;
#using scripts\mp\operator;
#using scripts\mp\playerlogic;

#namespace scene;

// Namespace scene
// Params 0, eflags: 0x5
// Checksum 0xc149b212, Offset: 0x7f3
// Size: 0x4d7
function private autoexec function_69e465bff11806e5()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
        {
            return;
        }
    #/
    
    function_9faf48fca9716acd();
    function_8eae84e23a4f5614( "modeStartMonitoringPlayers", &function_69d96401c55f0f46 );
    function_8eae84e23a4f5614( "modeStopMonitoringPlayers", &function_511918b804a5e6b1 );
    function_8eae84e23a4f5614( "modeXCamRespectsStartingTimeOnClients", &function_a979d7a483d6aa59 );
    function_8eae84e23a4f5614( "modePlayerMatchingObjectForFemale", &function_61e64bcdbcc13fe7 );
    function_3a06b41e384fbf58( "Types_XCam", "shotObjectSetup", &function_e03b6964f0af4e8 );
    function_3a06b41e384fbf58( "Types_XCam", "shotObjectCleanup", &function_3bbd59143097f5ef );
    function_3a06b41e384fbf58( "Types_Player", "objectSetup", &player_setup_mp );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectSetup", &function_faa1d1af08da7a66 );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectPlayAnim", &function_9b074cdfd41fdef6 );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectStopAnim", &function_634db9c4eae0d5c8 );
    function_3a06b41e384fbf58( "Types_Player", "objectSetAnimName", &function_386c0113104263b3 );
    function_3a06b41e384fbf58( "Types_Player", "objectDelete", &player_delete );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectPrepare", &function_c6e7b3d4684f0e84 );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectCleanup", &function_794451a91bb321c1 );
    function_3a06b41e384fbf58( "Types_Player", "objectMatchEntity", &function_a064fe0c9b1ef0ff );
    function_3a06b41e384fbf58( "Types_Player", "objectGetLinkEnts", &function_5010d254f036520f );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectLinkAnim", &function_6896e383ac7a6ece );
    function_3a06b41e384fbf58( "Types_Player", "objectCleanup", &function_f7f0b38fd2664a5c );
    function_3a06b41e384fbf58( "Types_Player", "objectSetAltAnim", &function_5cb14d5ee07581f2 );
    function_3a06b41e384fbf58( "Types_Player", "shotObjectSkipAnim", &function_8b225260b42e6b3b );
    function_3a06b41e384fbf58( "Types_Player", "objectSetAnimRate", &function_3502917abf195fe5 );
    function_3a06b41e384fbf58( "Types_Player", "objectStoreAnimRequest", &function_a5572341bf1138a2 );
    function_3a06b41e384fbf58( "Types_Player", "objectClearAnimRequest", &function_5fe8c2b624d5471e );
    function_3a06b41e384fbf58( "Types_Actor", "objectSpawn", &agent_spawn );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectPrepare", &function_6d6cd57edcc116fc );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectSetup", &function_31173da277504dbe );
    function_3a06b41e384fbf58( "Types_Actor", "objectMatchEntity", &function_14ca9eca4fbafb79 );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectPlayAnim", &function_8f918c6d698f43ce );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectStopAnim", &function_8b685bc7d83704d0 );
    function_3a06b41e384fbf58( "Types_Actor", "objectCleanup", &function_d1f7f820c132154 );
    function_3a06b41e384fbf58( "Types_Actor", "objectDelete", &agent_delete );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectCleanup", &function_a8e12fe2e00603b9 );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectFirstFrame", &function_4bb805cfe7a591f8 );
    function_3a06b41e384fbf58( "Types_Actor", "objectSceneDeath", &agent_scene_death );
    function_3a06b41e384fbf58( "Types_Actor", "objectKill", &agent_kill );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectLinkAnim", &function_2d3d749de2362f93 );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectSkipAnim", &function_4708fee44c31895d );
    function_3a06b41e384fbf58( "Types_Actor", "objectSetAnimRate", &function_ae1d59eb4593bcf7 );
    function_3a06b41e384fbf58( "Types_Actor", "shotObjectPauseAnim", &function_2d1ff8eafb06dc3e );
    function_3a06b41e384fbf58( "Types_Vehicle", "objectSpawn", &vehicle_spawn_mp );
    function_3a06b41e384fbf58( "Types_Vehicle", "shotObjectPlayAnim", &function_1bd42d28e8e1ad9 );
    function_3a06b41e384fbf58( "Types_Vehicle", "objectDelete", &vehicle_delete );
    function_3a06b41e384fbf58( "Types_Vehicle", "objectMatchEntity", &function_3cac183e277eeef6 );
    function_3a06b41e384fbf58( "Types_Vehicle", "objectSetAnimName", &function_26c73211ad2ac8f8 );
    function_3a06b41e384fbf58( "Types_Vehicle", "objectSetAnimRate", &function_d82b1e1acc9a94c6 );
    function_3a06b41e384fbf58( "Types_Vehicle", "shotObjectSkipAnim", &function_25d28095e3c9d6f0 );
    function_3a06b41e384fbf58( "Types_Object", "shotObjectPlayAnim", &object_play_anim_mp );
    function_3a06b41e384fbf58( "Types_Object", "shotObjectStopAnim", &function_3ab18e0dd5065892 );
    function_3a06b41e384fbf58( "Types_Object", "shotObjectPauseAnim", &object_pause_anim_mp );
    function_3a06b41e384fbf58( "Types_Object", "shotObjectFirstFrame", &object_first_frame_mp );
    function_3a06b41e384fbf58( "Types_Object", "objectTeleport", &object_teleport_mp );
    function_3a06b41e384fbf58( "Types_Object", "objectMatchEntity", &function_25906aa231d05919 );
    function_3a06b41e384fbf58( "Types_Object", "shotObjectSkipAnim", &function_631fb5f4f6f70a15 );
    function_3a06b41e384fbf58( "Types_Object", "objectSetAnimRate", &function_77ecba972efd637b );
    function_3a06b41e384fbf58( "Types_Prop", "objectSpawn", &function_edec20dd6b92908b );
    function_a8d91578e2556475();
    level thread function_dc6ad1d9a0057d1c( "onStartGameTypeFinished" );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x43e7a7e9, Offset: 0xcd2
// Size: 0xb1
function private function_e03b6964f0af4e8( shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    function_e770a2937db5fd28( shotindex, cameraanimation, shotanimations );
    
    foreach ( player in sceneobjectdata.xcamplayers )
    {
        player damage_effects::onexitdeathsdoor( 1 );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xe2ddb3bb, Offset: 0xd8b
// Size: 0x15
function private function_3bbd59143097f5ef( shotindex )
{
    function_ce4a84e6cdf6ee71( shotindex );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xf68b3fa, Offset: 0xda8
// Size: 0x83
function private function_a064fe0c9b1ef0ff( entity )
{
    /#
        if ( scene_debug::function_c4e717374c36ac3( self.index, entity ) )
        {
            entity.animname = self.sceneobject.variant_object.name;
            return 1;
        }
    #/
    
    sceneobjectdata = self;
    isplayerentity = isplayer( entity );
    
    if ( isdefined( isplayerentity ) )
    {
        if ( !function_f43455d85847000( entity, sceneobjectdata ) )
        {
            return 0;
        }
    }
    
    return isplayerentity;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x38df9e30, Offset: 0xe34
// Size: 0x2f, Type: bool
function private function_e2810a3fa4680eaa()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.var_5507fbea11d459e5 );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x853719ec, Offset: 0xe6c
// Size: 0x2e
function private function_25c4ba79823d5145()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_cd6933616942f77c;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xf08a8ab0, Offset: 0xea3
// Size: 0x2e
function private function_2a73852ef07bf6ca()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_13d6fee5ab1db31d;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xc573d30d, Offset: 0xeda
// Size: 0x88
function private set_character_models( bodymodelname, headmodelname, viewmodelname )
{
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    if ( !isagent( self ) )
    {
        bodymodelname = self getcustomizationbody();
        headmodelname = self getcustomizationhead();
        viewmodelname = self getcustomizationviewmodel();
    }
    
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    
    if ( isdefined( headmodelname ) )
    {
        self attach( headmodelname, "", 1 );
        self.headmodel = headmodelname;
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x5f58af75, Offset: 0xf6a
// Size: 0x7a
function private function_a3ffb8d4271a172d( player, operator, skin )
{
    assert( isdefined( player ) );
    assert( isplayer( player ) );
    player operator::function_44f7d464da13e4f6( operator, skin );
    var_54ef55f4ab15667c = player getcustomizationviewmodel();
    models = operator::function_fb2ad6ca3c6b708d( skin );
    player set_character_models( models[ 0 ], models[ 1 ], models[ 2 ] );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xceb3f044, Offset: 0xfec
// Size: 0x310
function private function_c6e7b3d4684f0e84( sceneplay, shotindex, objectindex )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    assert( isplayer( player ) );
    player damage_effects::onexitdeathsdoor( 1 );
    
    if ( sceneobjectdata function_7a4516ac3b008d7( shotindex ) )
    {
        player val::set( "scene_shot", "take_weapons", 1 );
    }
    else if ( sceneobjectdata function_9ac3c230848eee95( shotindex ) )
    {
        thread function_d09ea3142365da8d( player );
    }
    
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    
    if ( scenescriptbundle function_f4f80fb91ec747f3() )
    {
        player function_f6d96a431ef86a5( 1 );
    }
    
    player val::set( "scene_scene", "cinematic_motion", scenescriptbundle function_f38a33a196064424() );
    var_858f6fb73743f2f4 = [ "melee", "sprint", "allow_jump", "mantle", "tacmap_scoreboard", "backpack_inventory" ];
    
    if ( !sceneobjectdata.sceneobject.variant_object.allowusability )
    {
        var_858f6fb73743f2f4[ var_858f6fb73743f2f4.size ] = "usability";
    }
    
    if ( sceneobjectdata.sceneobject function_3c6fe393ccd02d3c( shotindex ) != "Keep" )
    {
        var_858f6fb73743f2f4[ var_858f6fb73743f2f4.size ] = "weapon";
    }
    
    if ( !sceneobjectdata.sceneobject function_96ce751feb7dd9c9( shotindex ) )
    {
        var_858f6fb73743f2f4[ var_858f6fb73743f2f4.size ] = "weapon_switch";
    }
    
    if ( !sceneobjectdata.sceneobject function_b978488b0468bee7( shotindex ) )
    {
        var_858f6fb73743f2f4[ var_858f6fb73743f2f4.size ] = "offhand_weapons";
        var_858f6fb73743f2f4[ var_858f6fb73743f2f4.size ] = "offhand_primary_weapons";
        var_858f6fb73743f2f4[ var_858f6fb73743f2f4.size ] = "offhand_secondary_weapons";
    }
    
    var_2f48c14c4400c4e8 = sceneobjectdata.sceneobject function_5200dc4f3cd33282( shotindex );
    player val::set( "scene_shot", "freezecontrols", !var_2f48c14c4400c4e8 );
    player val::set( "scene_shot", "freezecontrols_allowlook", !var_2f48c14c4400c4e8 );
    player val::set( "scene_shot", "swimming_underwater", 0 );
    player val::set_array( "scene_shot", var_858f6fb73743f2f4, 0 );
    
    if ( shotindex == sceneobjectdata.sceneplay.var_eb6d7fbdd0bb47f8[ 0 ] )
    {
        if ( sceneobjectdata function_e2810a3fa4680eaa() )
        {
            newskin = player function_66df206dec9fe1ae();
            var_ce150f47ad23993c = operator::function_30f20ce375c4ee40( newskin );
            
            if ( !isdefined( sceneobjectdata.var_b3e6504bada7c4d8 ) )
            {
                sceneobjectdata.var_b3e6504bada7c4d8 = var_ce150f47ad23993c;
            }
            
            if ( !isdefined( sceneobjectdata.var_d99ef669048467c1 ) )
            {
                sceneobjectdata.var_d99ef669048467c1 = newskin;
            }
            
            requestedoperator = sceneobjectdata function_25c4ba79823d5145();
            
            if ( requestedoperator.size > 0 )
            {
                var_ce150f47ad23993c = requestedoperator;
            }
            
            requestedskin = sceneobjectdata function_2a73852ef07bf6ca();
            
            if ( requestedskin.size > 0 )
            {
                newskin = requestedskin;
            }
            
            function_a3ffb8d4271a172d( player, var_ce150f47ad23993c, newskin );
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x9f419b92, Offset: 0x1304
// Size: 0x15c
function private function_794451a91bb321c1( shotindex )
{
    sceneobjectdata = self;
    
    if ( !isplayer( sceneobjectdata.entity ) )
    {
        return;
    }
    
    assert( isplayer( sceneobjectdata.entity ) );
    player = sceneobjectdata.entity;
    
    if ( shotindex == sceneobjectdata.sceneplay.var_eb6d7fbdd0bb47f8[ sceneobjectdata.sceneplay.var_eb6d7fbdd0bb47f8.size - 1 ] )
    {
        if ( sceneobjectdata function_e2810a3fa4680eaa() )
        {
            if ( isdefined( sceneobjectdata.var_7b8b06cc5473c4c1 ) && isdefined( sceneobjectdata.var_cd2954a5fe940257 ) )
            {
                function_a3ffb8d4271a172d( player, sceneobjectdata.var_b3e6504bada7c4d8, sceneobjectdata.var_d99ef669048467c1 );
                sceneobjectdata.var_b3e6504bada7c4d8 = undefined;
                sceneobjectdata.var_d99ef669048467c1 = undefined;
            }
        }
        
        function_68e270d8699ecbab( player, shotindex );
    }
    
    player val::reset_all( "scene_shot" );
    
    if ( isdefined( player.var_b36f7e54832612a4 ) )
    {
        player.var_b36f7e54832612a4 delete();
    }
    
    if ( isdefined( player.var_1f1525330a585944 ) || isdefined( player.var_412fa257d65ddc76 ) )
    {
        sceneobjectdata utility::delaythreadendon( 0.1, "scene_player_give_weapon_override", &function_f7467cf0d72f53fd, player );
    }
}

// Namespace scene
// Params 1, eflags: 0xc
// Checksum 0x36552ec, Offset: 0x1468
// Size: 0x1a1
function private function_d09ea3142365da8d( player )
{
    self notify( #"hash_ce97d825fd7372fc" );
    self endon( #"hash_ce97d825fd7372fc" );
    sceneobjectdata = self;
    player endon( #"death" );
    player endon( #"stop_animmode" );
    sceneobjectdata endon( #"scene_stop" );
    player notify( #"scene_player_give_weapon_override" );
    sceneobjectdata notify( #"scene_player_give_weapon_override" );
    
    for ( w_current = player getcurrentweapon(); isnullweapon( w_current ) ; w_current = player getcurrentweapon() )
    {
        waitframe();
    }
    
    var_73b4d098c34b279c = 1;
    
    if ( isdefined( level.weaponmetadata[ w_current.var_1616e6fbba9a722d ] ) )
    {
        var_73b4d098c34b279c = level.weaponmetadata[ w_current.var_1616e6fbba9a722d ].var_73b4d098c34b279c;
    }
    
    if ( var_73b4d098c34b279c )
    {
        if ( isarray( level.weaponmetadata[ "scene_weapons" ].var_8d39fbd08006aa9e ) )
        {
            player.var_412fa257d65ddc76 = utility::array_random( level.weaponmetadata[ "scene_weapons" ].var_8d39fbd08006aa9e );
            
            if ( player hasweapon( player.var_412fa257d65ddc76 ) )
            {
                sceneobjectdata childthread function_9dbcd742e3f19ba8( player, player.var_412fa257d65ddc76 );
                player.var_412fa257d65ddc76 = undefined;
                return;
            }
            
            player.var_1f1525330a585944 = w_current;
            player takeweapon( w_current );
            player giveweapon( player.var_412fa257d65ddc76 );
            sceneobjectdata childthread function_9dbcd742e3f19ba8( player, player.var_412fa257d65ddc76 );
        }
    }
}

// Namespace scene
// Params 2, eflags: 0xc
// Checksum 0xda780a28, Offset: 0x1611
// Size: 0xec
function private function_9dbcd742e3f19ba8( player, weapon )
{
    self notify( #"hash_9c0511a958c6102b" );
    self endon( #"hash_9c0511a958c6102b" );
    player endon( #"disconnect" );
    player val::reset( "scene_shot", "freezecontrols" );
    player val::reset( "scene_shot", "freezecontrols_allowlook" );
    player switchtoweapon( weapon );
    n_timeout = 3;
    
    while ( player getcurrentweapon() != weapon && n_timeout > 0 )
    {
        waitframe();
        n_timeout -= level.framedurationseconds;
        player val::reset( "scene_shot", "freezecontrols" );
        player val::reset( "scene_shot", "freezecontrols_allowlook" );
    }
    
    player val::set( "scene_shot", "freezecontrols", 1 );
    player val::set( "scene_shot", "freezecontrols_allowlook", 1 );
}

// Namespace scene
// Params 1, eflags: 0xc
// Checksum 0xd3fe60ea, Offset: 0x1705
// Size: 0x120
function private function_f7467cf0d72f53fd( player )
{
    self notify( #"hash_288db0be119b3a0e" );
    self endon( #"hash_288db0be119b3a0e" );
    sceneobjectdata = self;
    player endon( #"death" );
    player endon( #"stop_animmode" );
    player endon( #"scene_player_give_weapon_override" );
    sceneobjectdata endon( #"scene_player_give_weapon_override" );
    sceneobjectdata endon( #"scene_stop" );
    
    for ( w_current = player getcurrentweapon(); isnullweapon( w_current ) ; w_current = player getcurrentweapon() )
    {
        waitframe();
    }
    
    if ( isdefined( player.var_1f1525330a585944 ) || isdefined( player.var_412fa257d65ddc76 ) )
    {
        if ( isdefined( player.var_412fa257d65ddc76 ) )
        {
            player takeweapon( player.var_412fa257d65ddc76 );
        }
        
        if ( isdefined( player.var_1f1525330a585944 ) )
        {
            player giveweapon( player.var_1f1525330a585944 );
            player switchtoweaponimmediate( player.var_1f1525330a585944 );
        }
        
        player.var_1f1525330a585944 = undefined;
        player.var_412fa257d65ddc76 = undefined;
    }
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0x87e52a3e, Offset: 0x182d
// Size: 0x694
function private function_9b074cdfd41fdef6( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    sceneobjectdata endon( #"scene_stop" );
    sceneobjectdata endon( #"scene_play_anim" );
    
    if ( !isplayer( player ) )
    {
        if ( player == sceneobjectdata.replacemententity )
        {
            if ( isagent( player ) )
            {
                var_f6d9e11e9b6ac243 = sceneobjectdata function_a23a5ede0e977d52();
                n_anim_time = player function_36f251e37c52a25a( sceneobjectdata, shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, var_f6d9e11e9b6ac243 );
                return n_anim_time;
            }
            else
            {
                n_anim_time = sceneobjectdata object_play_anim_mp( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime );
                return n_anim_time;
            }
        }
        else
        {
            sceneobjectdata object_play_anim_ended( animasset, sceneobjectdata.activeanimationtype, notifystring );
            sceneobjectdata function_b635d3c89c265ba4( sceneobjectdata.activeanimationtype, shotindex, animindex );
            return 0;
        }
    }
    
    if ( !isalive( player ) || player.sessionstate == "spectator" )
    {
        player.var_14955bc056bab547 = 1;
        player thread playerlogic::spawnclient();
        player utility::waittill_any_timeout( 3, "spawned_player" );
        player.var_14955bc056bab547 = undefined;
    }
    
    rig_disallows = sceneobjectdata function_a3f6bcdd044bde4a( shotindex );
    player val::set_array( "scene_shot", rig_disallows, 0 );
    
    if ( sceneobjectdata.activeanimationtype == "CameraAnimation" )
    {
        if ( sceneobjectdata function_3e768ed8916f0542( shotindex ) )
        {
            str_camera_endon = "disconnect";
        }
        else
        {
            str_camera_endon = "death_or_disconnect";
        }
        
        sceneobjectdata thread object_play_anim_waittill_end( animasset, [ player ], str_camera_endon, "CameraAnimation", notifystring );
        sceneobjectdata.xcamplaying = 1;
        return sceneobjectdata function_3368cba813eece14( "scene_shot", player, animasset, var_142c2c5d44216f2a, notifystring, alignmentinfo, shotindex );
    }
    
    player val::set( "scene_shot", "cinematics_participant", 1 );
    str_anim_name = getanimname( animasset );
    animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
    n_anim_length = sceneobjectdata function_58a93a40f02daed7( shotindex, animasset, animtype, animindex );
    var_49209d5721bed4e2 = sceneobjectdata function_e751e9405d8ce670( shotindex, animtype, animindex );
    
    if ( var_49209d5721bed4e2 > 0 )
    {
        wait var_49209d5721bed4e2;
    }
    
    starttimeinseconds = 0;
    
    if ( var_142c2c5d44216f2a > 0 )
    {
        starttimeinseconds = n_anim_length * var_142c2c5d44216f2a;
        b_skipping = 1;
    }
    
    var_1ae8ed0ceeb0170c = n_anim_length - starttimeinseconds;
    
    if ( isdefined( player.var_b36f7e54832612a4 ) )
    {
        player.var_b36f7e54832612a4 unlink();
        player unlink();
        startorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
        startangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
        player.var_b36f7e54832612a4.origin = startorigin;
        player.var_b36f7e54832612a4.angles = startangles;
        player setorigin( startorigin );
        player setplayerangles( startangles );
        player playerlinktodelta( player.var_b36f7e54832612a4, "tag_origin" );
        
        if ( isdefined( alignmentinfo.aligntag ) )
        {
            if ( function_2651233d9db8add4() || alignmentinfo.var_f35d0dd7130d5eea )
            {
                player.var_b36f7e54832612a4 linkto( alignmentinfo.alignent, alignmentinfo.aligntag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            else
            {
                player.var_b36f7e54832612a4 linkto( alignmentinfo.alignent, alignmentinfo.aligntag );
            }
        }
        else
        {
            player.var_b36f7e54832612a4 linkto( alignmentinfo.alignent );
        }
    }
    else
    {
        player setorigin( alignmentinfo.origin );
        player setplayerangles( alignmentinfo.angles );
    }
    
    var_9b630dc1d012b99a = sceneobjectdata.xcamplaying && sceneobjectdata.sceneobject.variant_object.shots[ shotindex ].deltaanimations.size == 1;
    var_7555c9d002f43bfb = sceneobjectdata function_28c647f8c3df91be( shotindex );
    var_b7b83880282bec3b = sceneobjectdata function_514b2f4dda4105ef( shotindex );
    b_is_linked = player islinked();
    var_15622a724b798b13 = var_b7b83880282bec3b && !b_is_linked && !var_7555c9d002f43bfb && !sceneobjectdata.sceneroot.var_20d9a302fd198f99;
    
    if ( var_7555c9d002f43bfb )
    {
        function_ed47ec0826466773( player, shotindex );
    }
    else
    {
        function_68e270d8699ecbab( player, shotindex );
    }
    
    sceneobjectdata childthread function_26364b7b16eb9611( notifystring, animasset );
    player playanimscriptsceneevent( "scripted_scene", str_anim_name, var_15622a724b798b13, alignmentinfo.origin, alignmentinfo.angles );
    
    if ( sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036() == "UseOffset" )
    {
        player function_dc6d1931148169ed();
    }
    
    sceneobjectdata function_4a9835edd174d8e3( animasset );
    player.var_bbd02606816314a8 = gettime();
    
    if ( var_7555c9d002f43bfb )
    {
        var_5cff4e5dc10d74c0 = animasset;
        var_c2aeccf7ae479848 = sceneobjectdata function_87d0356b39cc55c7( shotindex, animindex );
        
        if ( isdefined( var_c2aeccf7ae479848 ) )
        {
            var_5cff4e5dc10d74c0 = var_c2aeccf7ae479848;
        }
        
        var_1ae8ed0ceeb0170c = function_fad98ca209b0f6a1( player, shotindex, animindex, notifystring, alignmentinfo, var_5cff4e5dc10d74c0, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, n_anim_length );
    }
    else if ( var_9b630dc1d012b99a )
    {
        n_start_time = gettime();
        player utility::waittill_any_timeout( var_1ae8ed0ceeb0170c, "stop_animmode", "death_or_disconnect" );
        var_8148e9fceecb8f6 = utility::function_6f5d2e1f1ff70482( gettime() - n_start_time );
        println( "<dev string:x24>" + var_8148e9fceecb8f6 + "<dev string:x46>" + getxhashsourcename( str_anim_name ) + "<dev string:x5a>" + n_anim_length + "<dev string:x66>" + n_anim_length - var_8148e9fceecb8f6 + "<dev string:x78>" );
        var_1ae8ed0ceeb0170c = var_8148e9fceecb8f6;
    }
    else
    {
        wait var_1ae8ed0ceeb0170c;
    }
    
    if ( b_skipping )
    {
        sceneobjectdata function_634db9c4eae0d5c8();
    }
    
    player.var_bbd02606816314a8 = undefined;
    return var_49209d5721bed4e2 + var_1ae8ed0ceeb0170c;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x8196d323, Offset: 0x1eca
// Size: 0x149
function private function_ed47ec0826466773( player, shotindex )
{
    sceneobjectdata = self;
    var_7555c9d002f43bfb = sceneobjectdata function_28c647f8c3df91be( shotindex );
    
    if ( var_7555c9d002f43bfb && !isdefined( player.scene_player_rig ) )
    {
        player.scene_player_rig = spawn( "script_arms", player.origin, 0, 0, player );
        player.scene_player_rig.animname = sceneobjectdata.sceneobject.variant_object.name;
        player.scene_player_rig useanimtree( sceneobjectdata.sceneobject function_4641057744100c08() );
        player.scene_player_rig hide();
        player.scene_player_rig.entity = player;
        player.scene_player_rig showonlytoplayer( player );
        player.scene_player_rig.noragdoll = 1;
        player.scene_player_rig val::set( "scene_scene", "cinematics_participant", 1 );
        thread player_rig_watcher( player, player.scene_player_rig );
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xd8bbcd65, Offset: 0x201b
// Size: 0x33
function private player_rig_watcher( player, rig )
{
    rig endon( #"death_or_disconnect" );
    
    while ( isdefined( player ) )
    {
        waitframe();
    }
    
    rig delete();
}

// Namespace scene
// Params 11, eflags: 0x4
// Checksum 0x8c777ca8, Offset: 0x2056
// Size: 0x4fb
function private function_fad98ca209b0f6a1( player, shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, n_anim_length )
{
    sceneobjectdata = self;
    function_ed47ec0826466773( player, shotindex );
    player val::reset( "scene_shot", "freezecontrols_allowlook" );
    arcenabled = sceneobjectdata.sceneobject function_1ddc5aeafdb7a9d2( shotindex );
    arcright = sceneobjectdata.sceneobject function_ffaa41b71b8c5dc9( shotindex );
    arcleft = sceneobjectdata.sceneobject function_e138e9b97f54f49c( shotindex );
    arctop = sceneobjectdata.sceneobject function_dbfd130ece46c860( shotindex );
    arcbottom = sceneobjectdata.sceneobject function_cf806cfc65d6c9e( shotindex );
    usetagangles = sceneobjectdata.sceneobject function_82593eb0d840ae91( shotindex );
    viewfraction = sceneobjectdata.sceneobject function_640261b8d0d5cba4( shotindex );
    str_link_tag = function_68d2c57d9f9e8a7e();
    
    if ( arcenabled )
    {
        player playerlinktoblend( player.scene_player_rig, str_link_tag, lerptime );
        
        if ( lerptime > 0 )
        {
            wait lerptime;
            waitframe();
        }
        
        player playerlinktodelta( player.scene_player_rig, str_link_tag, viewfraction, arcright, arcleft, arctop, arcbottom, usetagangles, 1, 1 );
    }
    else
    {
        player playerlinktoblend( player.scene_player_rig, str_link_tag, lerptime );
        
        if ( lerptime > 0 )
        {
            wait lerptime;
            waitframe();
        }
        
        player playerlinktodelta( player.scene_player_rig, str_link_tag, 1, 0, 0, 0, 0, usetagangles, 1, 1, 0, 0, 0, 0, 0, 0 );
    }
    
    player.scene_player_rig showonlytoplayer( player );
    var_3d2460219c7907a = "none";
    
    if ( blendtime > 0 && blendtime < 1 )
    {
        var_3d2460219c7907a = "normal";
    }
    else if ( blendtime >= 1 )
    {
        var_3d2460219c7907a = "slow";
    }
    
    str_anim_name = getanimname( animasset );
    n_anim_length_full = getanimlength( animasset );
    n_anim_length_trimmed = sceneobjectdata function_58a93a40f02daed7( shotindex, animasset, "DeltaAnimation", animindex );
    
    if ( !isdefined( var_142c2c5d44216f2a ) )
    {
        var_142c2c5d44216f2a = 0;
    }
    
    animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animindex );
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
    
    var_621ac137db968583 = sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036();
    animationapi = sceneobjectdata.scenedata.scenescriptbundle function_e676aa1c58e71d88();
    
    if ( sceneobjectdata function_514b2f4dda4105ef( shotindex ) )
    {
        if ( var_621ac137db968583 == "UseOffset" || animationapi == "ScriptModelPlayAnimDeltaMotionFromPos" )
        {
            player.scene_player_rig stopuseanimtree();
            player.scene_player_rig scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, var_b9d155388159ec8, var_3d2460219c7907a );
            
            if ( var_621ac137db968583 == "UseOffset" )
            {
                player.scene_player_rig function_dc6d1931148169ed();
            }
            
            player.scene_player_rig utility::function_1c579064b3fda85d( notifystring, "end", "stop_animmode" );
        }
        else
        {
            player.scene_player_rig animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
            player.scene_player_rig scriptmodelplayanim( str_anim_name, undefined, var_b9d155388159ec8, undefined, var_3d2460219c7907a );
            player.scene_player_rig utility::function_1c579064b3fda85d( notifystring, "end", "stop_animmode" );
        }
    }
    else
    {
        player.scene_player_rig scriptmodelplayanim( str_anim_name, undefined, var_b9d155388159ec8, undefined, var_3d2460219c7907a );
        
        if ( var_621ac137db968583 == "UseOffset" )
        {
            player.scene_player_rig function_dc6d1931148169ed();
        }
        
        var_6fb4e78f8b45f508 = max( 0, n_anim_length_trimmed - var_54f04a5ef99aabb9 );
        player.scene_player_rig utility::waittill_any_timeout( var_6fb4e78f8b45f508, "stop_animmode" );
        player.scene_player_rig notify( notifystring, "end" );
    }
    
    return n_anim_length_trimmed - var_54f04a5ef99aabb9;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xbb888d0, Offset: 0x255a
// Size: 0x7e
function private function_68e270d8699ecbab( player, shotindex )
{
    sceneobjectdata = self;
    
    if ( isdefined( player.scene_player_rig ) )
    {
        if ( isdefined( shotindex ) )
        {
            tweenout = sceneobjectdata.sceneobject function_c602a792da7056a0( shotindex );
            player playerunlinkblend( tweenout );
        }
        else
        {
            player playerunlinkblend( 0 );
        }
        
        player stopanimscriptsceneevent();
        player.scene_player_rig delete();
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x1bd25e80, Offset: 0x25e0
// Size: 0x55
function private player_setup_mp( sceneplay )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    shotindex = sceneplay.var_eb6d7fbdd0bb47f8[ 0 ];
    
    if ( isdefined( player ) )
    {
        function_ed47ec0826466773( player, shotindex );
    }
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x1cec43f7, Offset: 0x263d
// Size: 0xc8
function private function_faa1d1af08da7a66( shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    
    if ( isplayer( sceneobjectdata.entity ) )
    {
        if ( !sceneobjectdata.sceneroot function_de0c3faf7f92b366() )
        {
            scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
            letterbox = scenescriptbundle function_f4f80fb91ec747f3();
            
            if ( !letterbox && !isdefined( cameraanimation ) && isdefined( shotanimations ) && shotanimations.size > 0 )
            {
                sceneobjectdata.entity val::set( "scene_scene", "lerp_fov_scale", [ 0, 0.25 ] );
            }
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xace4ccf8, Offset: 0x270d
// Size: 0x63
function private function_5010d254f036520f()
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    
    if ( !isdefined( player ) || sceneobjectdata.var_7b6f3f539c4ce1da )
    {
        return [];
    }
    
    if ( isdefined( player.scene_player_rig ) )
    {
        return [ player.scene_player_rig ];
    }
    
    return [ player ];
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0x89a80e2c, Offset: 0x2779
// Size: 0x107
function private function_6896e383ac7a6ece( sceneplay, alignmentinfo, inittype, lerptime, initializing )
{
    sceneobjectdata = self;
    
    if ( isplayer( sceneobjectdata.entity ) && isai( alignmentinfo.alignent ) && !isdefined( sceneobjectdata.entity.var_b36f7e54832612a4 ) )
    {
        v_origin = alignmentinfo.alignent gettagorigin( alignmentinfo.aligntag ?? "tag_origin" );
        v_angles = alignmentinfo.alignent gettagangles( alignmentinfo.aligntag ?? "tag_origin" );
        sceneobjectdata.entity.var_b36f7e54832612a4 = utility::spawn_model( "tag_origin", v_origin, v_angles );
    }
    
    sceneobjectdata object_alignment_link_internal( sceneplay, alignmentinfo, inittype, lerptime );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x51c8c591, Offset: 0x2888
// Size: 0x76
function private function_f7f0b38fd2664a5c( newsceneroot )
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    sceneobjectdata function_2e0ec39304a5a328();
    
    if ( isplayer( player ) )
    {
        scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
        
        if ( scenescriptbundle && scenescriptbundle function_f4f80fb91ec747f3() )
        {
            player function_f6d96a431ef86a5( 0 );
        }
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xd1220136, Offset: 0x2906
// Size: 0xb7
function private function_634db9c4eae0d5c8()
{
    sceneobjectdata = self;
    player = sceneobjectdata.entity;
    sceneobjectdata function_2e0ec39304a5a328();
    
    if ( isdefined( player ) )
    {
        player notify( #"stop_loop" );
        player notify( #"single anim", "end" );
        player notify( #"looping anim", "end" );
        player notify( #"stop_animmode" );
        
        if ( isplayer( player ) )
        {
            player stopanimscriptsceneevent();
        }
        
        if ( isdefined( player.var_b36f7e54832612a4 ) )
        {
            player.var_b36f7e54832612a4 delete();
        }
        
        function_68e270d8699ecbab( player );
        player val::reset_all( "scene_shot" );
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xc18536cc, Offset: 0x29c5
// Size: 0xb9
function private function_5cb14d5ee07581f2()
{
    sceneobjectdata = self;
    
    if ( !isplayer( sceneobjectdata.entity ) )
    {
        return;
    }
    
    weaponsuffix = sceneobjectdata function_2b6fe9f287188c01();
    
    if ( weaponsuffix != "" )
    {
        sceneobjectdata.animaltname = [];
        sceneobjectdata.animaltname[ 0 ] = "Male" + weaponsuffix;
    }
    
    if ( sceneobjectdata.entity operator::isfemale() )
    {
        sceneobjectdata.animaltname = [];
        sceneobjectdata.animaltname[ 0 ] = "Female" + weaponsuffix;
        
        if ( weaponsuffix != "" )
        {
            sceneobjectdata.animaltname[ 1 ] = "Female";
        }
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x26a778, Offset: 0x2a86
// Size: 0x22
function private function_386c0113104263b3( animname, animtree )
{
    sceneobjectdata = self;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x896d8533, Offset: 0x2ab0
// Size: 0x2
function private player_delete()
{
    
}

// Namespace scene
// Params 10, eflags: 0x4
// Checksum 0xe2711f23, Offset: 0x2aba
// Size: 0x1f4
function private function_a5572341bf1138a2( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, animationtype )
{
    if ( animationtype != "DeltaAnimation" )
    {
        return;
    }
    
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.var_8646e6e746d76127 ) )
    {
        sceneobjectdata.var_8646e6e746d76127 = spawnstruct();
    }
    
    sceneobjectdata.var_8646e6e746d76127.newrequest = 1;
    sceneobjectdata.var_8646e6e746d76127.shotindex = shotindex;
    sceneobjectdata.var_8646e6e746d76127.animindex = animindex;
    sceneobjectdata.var_8646e6e746d76127.notifystring = notifystring;
    sceneobjectdata.var_8646e6e746d76127.alignmentinfo = alignmentinfo;
    sceneobjectdata.var_8646e6e746d76127.alignmentinfo.origin = alignmentinfo.origin;
    sceneobjectdata.var_8646e6e746d76127.alignmentinfo.angles = alignmentinfo.angles;
    sceneobjectdata.var_8646e6e746d76127.animasset = animasset;
    sceneobjectdata.var_8646e6e746d76127.var_142c2c5d44216f2a = var_142c2c5d44216f2a;
    sceneobjectdata.var_8646e6e746d76127.blendtime = blendtime;
    sceneobjectdata.var_8646e6e746d76127.blendcurve = blendcurve;
    sceneobjectdata.var_8646e6e746d76127.lerptime = lerptime;
    sceneobjectdata.var_8646e6e746d76127.var_c91cbb6de72ec395 = gettime();
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x4fa713d7, Offset: 0x2cb6
// Size: 0x8a
function private function_5fe8c2b624d5471e( animationtype, shotindex, animindex )
{
    if ( animationtype != "DeltaAnimation" )
    {
        return;
    }
    
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.var_8646e6e746d76127 ) )
    {
        return;
    }
    
    if ( shotindex == sceneobjectdata.var_8646e6e746d76127.shotindex && animindex == sceneobjectdata.var_8646e6e746d76127.animindex )
    {
        sceneobjectdata.var_8646e6e746d76127 = undefined;
    }
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0xd9ead34, Offset: 0x2d48
// Size: 0x1f9
function private function_8b225260b42e6b3b( alignmentinfo, animasset, notifystring, var_142c2c5d44216f2a, var_ab6f54ef0991868f, animationtype )
{
    sceneobjectdata = self;
    player = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    str_anim_name = getanimname( animasset );
    animationapi = sceneobjectdata.scenedata.scenescriptbundle function_e676aa1c58e71d88();
    starttimeinseconds = var_142c2c5d44216f2a * getanimlength( animasset );
    endtimeinseconds = var_ab6f54ef0991868f * getanimlength( animasset );
    
    if ( isdefined( player.scene_player_rig ) )
    {
        if ( animationapi == "AnimScripted" )
        {
            player.scene_player_rig animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset );
            player.scene_player_rig setanimtime( animasset, var_142c2c5d44216f2a );
            player.scene_player_rig scriptmodelplayanim( str_anim_name, undefined, starttimeinseconds, 1 );
            
            if ( !( animislooping( animasset ) && var_ab6f54ef0991868f == 1 ) )
            {
                player.scene_player_rig setanimtime( animasset, var_ab6f54ef0991868f, undefined, 1 );
                player.scene_player_rig scriptmodelplayanim( str_anim_name, undefined, endtimeinseconds, 1 );
            }
            
            return;
        }
        
        if ( animationapi == "ScriptModelPlayAnimDeltaMotionFromPos" )
        {
            player.scene_player_rig stopuseanimtree();
            player.scene_player_rig scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, starttimeinseconds );
            
            if ( !( animislooping( animasset ) && var_ab6f54ef0991868f == 1 ) )
            {
                player.scene_player_rig scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, endtimeinseconds );
            }
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2bda0a27, Offset: 0x2f49
// Size: 0xc
function private function_3502917abf195fe5( animrate )
{
    
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x77e15e83, Offset: 0x2f5d
// Size: 0x100
function private function_edec20dd6b92908b( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    entity = undefined;
    sceneobjectassettype = sceneobjectdata.sceneobject function_fc09a0af0b50d3d4();
    
    if ( sceneobjectassettype == "operatorskin" )
    {
        sceneobjectassetname = sceneobjectdata.sceneobject function_ccb2b599f3b8ef77();
        
        if ( isdefined( sceneobjectassetname ) )
        {
            entity = spawn( "script_model", spawnorigin );
            
            if ( isdefined( entity ) )
            {
                entity val::set( "scene_scene", "cinematics_participant", 1 );
                entity.angles = spawnangles;
                entity setmodel( "tag_origin" );
                entity function_ce21f4102d5d17f6( sceneobjectassetname );
                animtree = sceneobjectdata.sceneobject function_4641057744100c08();
                
                if ( isdefined( animtree ) )
                {
                    entity useanimtree( animtree );
                }
                
                entity visibility_mode::function_db9ed9dc5c19305b();
            }
        }
    }
    else
    {
        entity = prop_spawn_ent( spawnorigin, spawnangles );
    }
    
    return entity;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x37e52731, Offset: 0x3066
// Size: 0x51e
function private agent_spawn( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    level utility::flag_set( "scene_system_spawning_ai" );
    
    if ( isdefined( sceneobjectdata.sceneobject.variant_object.aitypename ) )
    {
        sceneobjectassettype = "aitype";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.aitypename;
    }
    else if ( isdefined( sceneobjectdata.sceneobject.variant_object.charactername ) )
    {
        sceneobjectassettype = "character";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.charactername;
    }
    else
    {
        sceneobjectassettype = "xmodel";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.xmodelname;
    }
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        if ( isagent( sceneobjectdata.entity ) )
        {
            /#
                if ( isdefined( sceneobjectdata.sceneroot.script_scenescriptbundle ) && isdefined( sceneobjectdata.sceneroot.origin ) )
                {
                    println( "<dev string:x7a>" + sceneobjectdata.entity getentitynumber() + "<dev string:x93>" + sceneobjectdata.sceneroot.script_scenescriptbundle + "<dev string:xa7>" + sceneobjectdata.sceneroot.origin + "<dev string:xac>" );
                }
            #/
            
            sceneobjectdata.entity val::reset( "scene_shot", "non_deletable" );
            sceneobjectdata.entity agent_utils::despawnagent();
        }
        else
        {
            sceneobjectdata.entity delete();
        }
    }
    
    entity = undefined;
    var_8b1ad90ef6f897d3 = "team_eighty";
    
    if ( sceneobjectassettype == "aitype" )
    {
        if ( isdefined( sceneobjectdata.sceneobject.variant_object.aisubclass ) )
        {
            if ( utility::issharedfuncdefined( #"ai", #"hash_97eb718c4db95479" ) )
            {
                var_ae5b8b60fa27c076 = utility::callsharedfunc( #"ai", #"hash_97eb718c4db95479", sceneobjectdata.sceneobject.variant_object.aisubclass, spawnorigin );
            }
            
            if ( !isdefined( var_ae5b8b60fa27c076 ) )
            {
                var_ae5b8b60fa27c076 = function_b3988325430ce242( sceneobjectdata.sceneobject.variant_object.aisubclass );
            }
            
            sceneobjectassetname = var_ae5b8b60fa27c076 ?? sceneobjectassetname;
        }
        
        if ( sceneobjectdata.sceneobject.variant_object.var_b8606483ec8046de )
        {
            var_8b1ad90ef6f897d3 = undefined;
        }
        
        if ( utility::issharedfuncdefined( #"ai", #"get_aitype_default_spawn_team_SharedFunc" ) )
        {
            var_8b1ad90ef6f897d3 = namespace_9d8e359c3b1041e5::get_aitype_default_spawn_team_SharedFunc();
        }
        
        if ( utility::issharedfuncdefined( #"ai", #"spawnnewaitype_sharedfunc" ) )
        {
            entity = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( sceneobjectassetname, spawnorigin, spawnangles, var_8b1ad90ef6f897d3 );
        }
        else
        {
            entity = mp_agent::spawnnewagentaitype( sceneobjectassetname, spawnorigin, spawnangles, var_8b1ad90ef6f897d3 );
        }
        
        if ( isdefined( entity ) )
        {
            entity useanimtree( sceneobjectdata.sceneobject.variant_object.animtree.id );
            entity.animname = undefined;
            
            if ( !sceneobjectdata.sceneobject function_6ea442b0feacbc1() )
            {
                entity val::set( "scene_shot", "damage", 0 );
                entity val::set( "scene_shot", "trigger_hurt_damage", 0 );
            }
            
            if ( isagent( entity ) )
            {
                entity val::set( "scene_shot", "non_deletable", 1 );
                entity utility::callsharedfunc( #"ai", #"hash_1f5b8b945004c533" );
            }
            
            if ( entity.unittype == "zombie" )
            {
                entity.var_63940b45b3b12d4e = entity utility::callsharedfunc( #"zombie_attractor", #"addonself", { #angles:entity.angles, #origin:entity.origin }, 10 );
            }
        }
        else
        {
            /#
                scene_debug::object_event( sceneobjectdata, "<dev string:xcc>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:xf5>" + getxhashsourcename( sceneobjectdata.scenedata.scenescriptbundle.var_5d185975a2bb0b35 ), spawnorigin, spawnangles );
            #/
        }
    }
    
    if ( !isdefined( level.throttle_scene_spawn_ai ) )
    {
        level.throttle_scene_spawn_ai = throttle::throttle_initialize( "scene_spawn_ai", 3, level.framedurationseconds ?? 0.05 );
    }
    
    throttle::throttle_wait_in_queue( level.throttle_scene_spawn_ai, entity );
    level utility::flag_clear( "scene_system_spawning_ai" );
    return entity;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x25a8b872, Offset: 0x358d
// Size: 0x29, Type: bool
function private function_14ca9eca4fbafb79( entity )
{
    sceneobjectdata = self;
    return isagent( entity ) && isalive( entity );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xa3d6a8cb, Offset: 0x35bf
// Size: 0x19c
function private function_6d6cd57edcc116fc( sceneplay, shotindex, objectindex )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        takesdamage = sceneobjectdata.sceneobject function_6ea442b0feacbc1() || sceneobjectdata.sceneobject function_599407b70d85262c( shotindex );
        sceneobjectdata.entity val::set( "scene_shot", "damage", takesdamage );
        
        if ( takesdamage )
        {
            sceneobjectdata.entity val::reset( "scene_shot", "trigger_hurt_damage" );
        }
        else
        {
            sceneobjectdata.entity val::set( "scene_shot", "trigger_hurt_damage", 0 );
        }
        
        deathanim = sceneobjectdata.sceneobject function_e93b454561075f4a( shotindex );
        deathscenestop = sceneobjectdata.sceneobject function_6ff76756d536e49a();
        
        if ( !deathscenestop && !isdefined( deathanim ) && !sceneobjectdata.entity val::get( "death" ) )
        {
            sceneobjectdata.entity val::reset( "scene_shot", "death" );
        }
        
        if ( takesdamage && !sceneobjectdata.entity callback::exists( #"asm_death_anim", &function_a7a6e6dd4d9a7dd6 ) )
        {
            sceneobjectdata.entity callback::add( #"asm_death_anim", &function_a7a6e6dd4d9a7dd6 );
        }
    }
    
    function_aa5b435587ec4d41( sceneplay, shotindex, objectindex );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xd291d5cc, Offset: 0x3763
// Size: 0x49
function private function_31173da277504dbe( shotindex, cameraanimation, shotanimations )
{
    sceneobjectdata = self;
    
    if ( isagent( sceneobjectdata.entity ) )
    {
        sceneobjectdata object_lookat_target( shotindex, 1 );
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xb0cd71bd, Offset: 0x37b4
// Size: 0xd4
function private function_4bb805cfe7a591f8( alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    shotanimations = sceneobjectdata function_6bf501072826e845( shotindex );
    
    if ( shotanimations.size != 0 )
    {
        animasset = shotanimations[ 0 ];
        function_e6a0cfda285ff6af( entity, alignmentinfo, animasset, undefined, undefined, undefined, 0, shotindex );
        
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x102>" + getxhashsourcename( getanimname( animasset ) ), entity.origin, entity.angles );
        #/
        
        /#
            scene_debug::object_event( sceneobjectdata, "<dev string:x10f>" + getxhashsourcename( getanimname( animasset ) ), alignmentinfo.origin, alignmentinfo.angles );
        #/
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb4b98638, Offset: 0x3890
// Size: 0xe2
function private agent_scene_death( attacker )
{
    if ( isagent( self.entity ) && isalive( self.entity ) )
    {
        self.entity val::set( "scene_shot", "damage", 0 );
        self.entity.noragdoll = self.entity.var_77b4f3672c20d09f ? undefined : 1;
        self.entity.forceragdollimmediate = istrue( self.entity.var_77b4f3672c20d09f );
        self.entity.disabledeathorient = 1;
        self.entity.var_832de7fe104df743 = attacker;
        self.entity.var_fd5c989cd241b6c4 = 1;
    }
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0xcf38ea50, Offset: 0x397a
// Size: 0xf2
function private agent_kill( point, attacker, inflictor, meansofdeath, objweapon )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        agent = sceneobjectdata.entity;
        assert( isagent( agent ), "<dev string:x122>" );
        assert( isalive( agent ), "<dev string:x143>" );
        agent val::reset( "scene_shot", "damage" );
        agent val::reset( "scene_shot", "non_deletable" );
        
        if ( sceneobjectdata.sceneobject function_f0f1ea94325df082( self.sceneplay.currentshot ) )
        {
            sceneobjectdata function_eec9525757393421( attacker, inflictor, meansofdeath, objweapon );
            return;
        }
        
        agent kill( point, attacker, inflictor, meansofdeath, objweapon );
    }
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0x34871ba1, Offset: 0x3a74
// Size: 0x94
function private function_4708fee44c31895d( alignmentinfo, animasset, notifystring, var_142c2c5d44216f2a, var_ab6f54ef0991868f, animationtype )
{
    sceneobjectdata = self;
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    function_e6a0cfda285ff6af( entity, alignmentinfo, animasset, undefined, undefined, var_142c2c5d44216f2a, 1, undefined, 0 );
    
    if ( !( animislooping( animasset ) && var_ab6f54ef0991868f == 1 ) )
    {
        function_e6a0cfda285ff6af( entity, alignmentinfo, animasset, undefined, undefined, var_ab6f54ef0991868f, 1, undefined, 0 );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xcf83ed23, Offset: 0x3b10
// Size: 0xea
function private function_62625e0f5bda5a69( entity )
{
    if ( !isagent( entity ) )
    {
        return;
    }
    
    if ( isdefined( entity.scripted_mode ) )
    {
        entity.scripted_mode = 0;
    }
    
    if ( isalive( entity ) && entity asm_bb::bb_isanimscripted() )
    {
        entity asm_bb::bb_clearanimscripted();
    }
    
    if ( entity.disabledeathorient || entity.var_fd5c989cd241b6c4 )
    {
        entity animmode( "nogravity" );
    }
    else
    {
        entity animmode( "normal" );
        entity motionwarpcancel();
        entity orientmode( "face enemy or motion" );
    }
    
    entity stopanimscripted();
    entity.var_e073af6d35bd0942 = undefined;
    
    if ( isdefined( entity.basearchetype ) && entity findoverridearchetype( "animscript" ) == entity.str_scene_animset_override )
    {
        entity function_a7a6e6dd4d9a7dd6();
        thread agent_clear_animscripted_flag( entity );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2f4c8132, Offset: 0x3c02
// Size: 0x42
function private agent_clear_animscripted_flag( entity )
{
    entity endon( #"death" );
    entity notify( #"endon_agent_clear_animscripted_flag" );
    entity endon( #"endon_agent_clear_animscripted_flag" );
    waitframe();
    entity utility::ent_flag_clear( "scene_animset_override" );
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0x88d5b25c, Offset: 0x3c4c
// Size: 0x98
function private function_8f918c6d698f43ce( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    var_1ae8ed0ceeb0170c = entity function_36f251e37c52a25a( sceneobjectdata, shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, undefined );
    return var_1ae8ed0ceeb0170c;
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0x6625b30, Offset: 0x3ced
// Size: 0x3e4
function private function_e6a0cfda285ff6af( entity, alignmentinfo, animasset, var_f6d9e11e9b6ac243, lerptime, var_142c2c5d44216f2a = 0, animrate = 1, shotindex, shotanimindex = 0 )
{
    sceneobjectdata = self;
    
    if ( !isagent( entity ) || !isalive( entity ) )
    {
        return;
    }
    
    if ( !isdefined( shotindex ) )
    {
        shotindex = sceneobjectdata.sceneplay.currentshot;
    }
    
    function_62625e0f5bda5a69( entity );
    update_alignment_transform( alignmentinfo );
    str_anim_name = getanimname( animasset );
    var_a3016ccb852a40c2 = var_142c2c5d44216f2a;
    animationvalues = undefined;
    
    if ( isdefined( shotindex ) )
    {
        animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, shotanimindex );
    }
    
    if ( isdefined( animationvalues ) )
    {
        if ( var_142c2c5d44216f2a > 0 && var_142c2c5d44216f2a <= 1 )
        {
            var_a3016ccb852a40c2 = function_1222280fb003fd62( animasset, animationvalues, var_142c2c5d44216f2a );
            
            if ( var_142c2c5d44216f2a == 1 && animislooping( animasset ) )
            {
                var_a3016ccb852a40c2 = 0.999999;
            }
        }
        else if ( animationvalues.var_a9b8dffd45b33087 > 0 )
        {
            var_a3016ccb852a40c2 = function_1222280fb003fd62( animasset, animationvalues, 0 );
        }
    }
    
    if ( isdefined( sceneobjectdata.sceneobject.variant_object.var_f6d9e11e9b6ac243 ) )
    {
        entity.str_scene_animset_override = sceneobjectdata.sceneobject.variant_object.var_f6d9e11e9b6ac243;
    }
    
    if ( isdefined( var_f6d9e11e9b6ac243 ) )
    {
        entity.str_scene_animset_override = var_f6d9e11e9b6ac243;
    }
    
    if ( isdefined( entity.str_scene_animset_override ) )
    {
        entity setoverridearchetype( "animscript", entity.str_scene_animset_override, 0 );
        entity utility::ent_flag_set( "scene_animset_override" );
    }
    
    entity asmsetstate( entity.asmname, "animscripted" );
    animindex = entity asm::asm_lookupanimfromalias( "animscripted", str_anim_name );
    entity.var_e073af6d35bd0942 = animindex;
    str_orient_mode = "face current";
    
    /#
        if ( getdvar( @"hash_520dfc00534b7052", "<dev string:x174>" ) != "<dev string:x174>" )
        {
            str_orient_mode = getdvar( @"hash_520dfc00534b7052", "<dev string:x174>" );
        }
    #/
    
    entity orientmode( str_orient_mode );
    str_anim_mode = sceneobjectdata.sceneobject function_ed9417387de96397( shotindex );
    
    /#
        if ( getdvar( @"hash_e63adbacfd6155e6", "<dev string:x174>" ) != "<dev string:x174>" )
        {
            str_anim_mode = getdvar( @"hash_e63adbacfd6155e6", "<dev string:x174>" );
        }
    #/
    
    entity animmode( str_anim_mode );
    entity asm_bb::bb_setanimscripted();
    entity.scripted_mode = 1;
    agent_align_entity( entity, alignmentinfo, animasset );
    
    if ( animrate == 0 )
    {
        entity dontinterpolate();
        entity aisetanimtime( animasset, 0 );
    }
    
    if ( var_a3016ccb852a40c2 >= 1 && animislooping( animasset ) )
    {
        var_a3016ccb852a40c2 = 0.99;
        assertmsg( "<dev string:x175>" + getxhashsourcename( getanimname( animasset ) ) + "<dev string:x1b5>" );
    }
    
    if ( isdefined( animindex ) )
    {
        entity aisetanim( "animscripted", animindex, animrate, var_a3016ccb852a40c2 );
        entity aisetanimrate( "animscripted", animindex, animrate );
    }
    
    if ( isdefined( entity.var_63940b45b3b12d4e ) )
    {
        entity utility::callsharedfunc( #"zombie_attractor", #"removeonself", entity.var_63940b45b3b12d4e );
        entity.var_63940b45b3b12d4e = undefined;
    }
    
    entity callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    entity callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x4fe25a84, Offset: 0x40d9
// Size: 0x4e, Type: bool
function private function_ed9417387de96397( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return shotobject.sceneanimmode ?? "noclip";
}

// Namespace scene
// Params 11, eflags: 0x4
// Checksum 0x463a69d8, Offset: 0x4130
// Size: 0x344
function private function_36f251e37c52a25a( sceneobjectdata, shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime, var_f6d9e11e9b6ac243 )
{
    entity = self;
    entity endon( #"hash_6a8b9af15f1a2efe" );
    entity endon( #"hash_c01a9f43c01d8d25" );
    entity endon( #"agent_scene_stop" );
    entity endon( #"death_or_disconnect" );
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isagent( entity ) )
    {
        return;
    }
    
    if ( !isalive( entity ) )
    {
        return;
    }
    
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
    
    animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
    n_anim_length = sceneobjectdata function_58a93a40f02daed7( shotindex, animasset, animtype, animindex );
    animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animindex );
    var_49209d5721bed4e2 = animationvalues.displacementtime;
    var_bb8b7d242c829d4d = n_anim_length - var_142c2c5d44216f2a * n_anim_length;
    
    if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) || var_142c2c5d44216f2a > 0 )
    {
        var_49209d5721bed4e2 = 0;
    }
    
    if ( var_49209d5721bed4e2 > 0 )
    {
        wait var_49209d5721bed4e2;
    }
    
    if ( var_142c2c5d44216f2a < 1 )
    {
        sceneobjectdata childthread function_26364b7b16eb9611( notifystring, animasset );
    }
    
    sceneroot = sceneobjectdata.scenedata.sceneroot;
    animrate = 1;
    
    if ( isdefined( sceneroot.scenestatic ) && isdefined( sceneroot.scenestatic.animrate ) )
    {
        animrate = sceneroot.scenestatic.animrate;
    }
    
    sceneobjectdata function_e6a0cfda285ff6af( entity, alignmentinfo, animasset, var_f6d9e11e9b6ac243, lerptime, var_142c2c5d44216f2a, animrate, shotindex, animindex );
    entity utility::ent_flag_set( "scene_ent_playing_anim" );
    sceneobjectdata function_4a9835edd174d8e3( animasset );
    
    if ( var_142c2c5d44216f2a < 1 )
    {
        if ( animislooping( animasset ) )
        {
            v_start_origin = entity.origin;
            
            while ( true )
            {
                waittillframeend();
                str_end_note = entity asm::asm_donotetracks( entity.asmname, "animscripted", asm::asm_getnotehandler( entity.asmname, "animscripted" ) );
                
                if ( str_end_note == "end" )
                {
                    break;
                }
                
                if ( str_end_note == "loop_end" && distance( v_start_origin, entity.origin ) > 1 )
                {
                    agent_align_entity( entity, alignmentinfo, animasset );
                }
            }
        }
        else
        {
            sceneobjectdata thread function_e1a0b8a1c6c7c105( entity, var_bb8b7d242c829d4d, notifystring );
            entity utility::function_1c579064b3fda85d( notifystring, "end", "stop_animmode" );
        }
    }
    
    function_62625e0f5bda5a69( entity );
    entity utility::ent_flag_clear( "scene_ent_playing_anim" );
    return var_49209d5721bed4e2 + var_bb8b7d242c829d4d;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xf2cb430, Offset: 0x447d
// Size: 0x1cc
function private agent_align_entity( entity, alignmentinfo, animasset )
{
    sparams = spawnstruct();
    sparams.entity = entity;
    sceneroot = self.sceneroot ?? entity.sceneobjectdata.sceneroot;
    sceneroot callback::callback( "on_agent_align_entity", sparams );
    alignmentinfo = entity.var_13d60e5f54c6db7 ?? alignmentinfo;
    startorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
    startangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
    
    if ( isent( alignmentinfo.alignent ) && entity != alignmentinfo.alignent )
    {
        entity unlink();
        entity forceteleport( startorigin, startangles );
        
        if ( isdefined( alignmentinfo.aligntag ) )
        {
            if ( function_2651233d9db8add4() || alignmentinfo.var_f35d0dd7130d5eea )
            {
                entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            else
            {
                entity linktomoveoffset( alignmentinfo.alignent, alignmentinfo.aligntag );
            }
        }
        else
        {
            entity linktomoveoffset( alignmentinfo.alignent );
        }
        
        return;
    }
    
    if ( startangles[ 0 ] != 0 || startangles[ 2 ] != 0 )
    {
        entity.var_c550c76e4b35da96 = 1;
    }
    
    entity forceteleport( startorigin, startangles, 0, 0, 1 );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x6333f6e1, Offset: 0x4651
// Size: 0x66, Type: bool
function private function_2651233d9db8add4()
{
    sceneobjectdata = self;
    shotindex = sceneobjectdata.sceneplay.currentshot;
    shotobject = sceneobjectdata.sceneobject.variant_object.shots[ shotindex ];
    return istrue( shotobject.var_f35d0dd7130d5eea );
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0x95edd155, Offset: 0x46c0
// Size: 0x52
function private function_e1a0b8a1c6c7c105( entity, var_bb8b7d242c829d4d, notifystring )
{
    entity notify( #"hash_574a07abd4c50ac9" );
    entity endon( #"hash_574a07abd4c50ac9" );
    entity endon( #"death" );
    wait var_bb8b7d242c829d4d;
    entity notify( notifystring, "end" );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2b9d6643, Offset: 0x471a
// Size: 0xfa
function private function_8c5e06ee1e60aeb7( params )
{
    if ( isdefined( self ) )
    {
        function_a7a6e6dd4d9a7dd6();
        
        if ( isdefined( self.sceneobjectdata ) )
        {
            /#
                if ( isdefined( self.sceneobjectdata.sceneroot.script_scenescriptbundle ) && isdefined( self.sceneobjectdata.sceneroot.origin ) )
                {
                    println( "<dev string:x7a>" + self getentitynumber() + "<dev string:x1cf>" + self.sceneobjectdata.sceneroot.script_scenescriptbundle + "<dev string:xa7>" + self.sceneobjectdata.sceneroot.origin + "<dev string:x1e5>" );
                }
            #/
            
            self.sceneobjectdata.entity = undefined;
            self.sceneobjectdata = undefined;
        }
        
        callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x17e746d2, Offset: 0x481c
// Size: 0xbf
function private function_8b685bc7d83704d0()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity notify( #"stop_loop" );
        sceneobjectdata.entity notify( #"single anim", "end" );
        sceneobjectdata.entity notify( #"looping anim", "end" );
        sceneobjectdata.entity notify( #"stop_animmode" );
        sceneobjectdata.entity notify( #"agent_scene_stop" );
        sceneobjectdata.entity utility::ent_flag_clear( "scene_ent_playing_anim" );
        function_62625e0f5bda5a69( sceneobjectdata.entity );
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x54ca81d6, Offset: 0x48e3
// Size: 0x74
function private function_d1f7f820c132154( sceneroot )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) && sceneobjectdata.entity callback::exists( #"asm_death_anim", &function_a7a6e6dd4d9a7dd6 ) )
    {
        sceneobjectdata.entity callback::remove( #"asm_death_anim", &function_a7a6e6dd4d9a7dd6 );
    }
    
    sceneobjectdata function_8b685bc7d83704d0();
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x73c8f76a, Offset: 0x495f
// Size: 0x39
function private function_a7a6e6dd4d9a7dd6( params )
{
    if ( isdefined( self.str_scene_animset_override ) )
    {
        self clearoverridearchetype( "animscript", 0, !self.var_fd5c989cd241b6c4 );
        self.str_scene_animset_override = undefined;
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x724fa7ea, Offset: 0x49a0
// Size: 0xa1
function private agent_delete()
{
    sceneobjectdata = self;
    
    if ( isagent( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity val::reset( "scene_shot", "non_deletable" );
        sceneobjectdata.entity.var_a13bed1ac47e1b2c = 1;
        sceneobjectdata.entity.nocorpse = 1;
        sceneobjectdata.entity thread agent_delete_internal();
        return;
    }
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity delete();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1d6b90b2, Offset: 0x4a49
// Size: 0x27
function private agent_delete_internal()
{
    self endon( #"death" );
    
    if ( self.birthtime >= gettime() )
    {
        waitframe();
    }
    
    agent_utils::despawnagent();
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x5f4e0fb4, Offset: 0x4a78
// Size: 0xd3
function private function_a8e12fe2e00603b9( shotindex )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.entity ) )
    {
        return;
    }
    
    agent = sceneobjectdata.entity;
    
    if ( isdefined( agent.scripted_mode ) )
    {
        agent.scripted_mode = 0;
    }
    
    if ( isalive( agent ) && agent asm_bb::bb_isanimscripted() )
    {
        agent asm_bb::bb_clearanimscripted();
    }
    
    agent stopanimscripted();
    agent.var_e073af6d35bd0942 = undefined;
    agent function_a7a6e6dd4d9a7dd6();
    sceneobjectdata object_lookat_target( shotindex, 0 );
    
    if ( sceneobjectdata.sceneobject function_f0f1ea94325df082( self.sceneplay.currentshot ) )
    {
        sceneobjectdata function_eec9525757393421( undefined, undefined, undefined, undefined );
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x1dec5cd8, Offset: 0x4b53
// Size: 0x2f, Type: bool
function private function_967d516c51dafad6()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.delaymovementatend );
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x45186a3b, Offset: 0x4b8b
// Size: 0x2f, Type: bool
function private function_b8e072913667997c()
{
    sceneobjectdata = self;
    return istrue( sceneobjectdata.sceneobject.variant_object.var_64f7091ad83a01d8 );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x15c3186d, Offset: 0x4bc3
// Size: 0xd2, Type: bool
function private function_8494b21a484b23d1( shotindex )
{
    sceneobjectdata = self;
    sceneobject = sceneobjectdata.sceneobject;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    actor_weapon = sceneobjectdata.entity.weapon;
    var_b96fb5189959d317 = isdefined( actor_weapon ) && !isnullweapon( actor_weapon );
    var_321b4a288e57064f = istrue( shotobject.removeweapon );
    var_54a7695fe9771ba8 = istrue( sceneobject.variant_object.removeweapon );
    
    if ( ( var_321b4a288e57064f || var_54a7695fe9771ba8 ) && var_b96fb5189959d317 )
    {
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x7e86af26, Offset: 0x4c9e
// Size: 0x64, Type: bool
function private function_2d1ff8eafb06dc3e( pausestate )
{
    sceneobjectdata = self;
    animrate = sceneobjectdata.sceneroot.scenestatic.animrate ?? 1;
    sceneobjectdata function_909c00577c56aa35( pausestate ? 0 : animrate );
    return true;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xff7f5bf0, Offset: 0x4d0b
// Size: 0x46
function private function_ae1d59eb4593bcf7( animrate )
{
    sceneobjectdata = self;
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entity asm::function_d82cb83c9c260d49( animrate );
    entity asm::function_24133a663bba593c();
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0x756802df, Offset: 0x4d59
// Size: 0x5f0
function private object_play_anim_mp( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity.model == "" )
    {
        println( "<dev string:x20b>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:x23b>" );
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
    
    animtype = sceneobjectdata.sceneobject function_e497f52b15295ba5();
    n_anim_length = sceneobjectdata function_58a93a40f02daed7( shotindex, animasset, animtype, animindex );
    animationvalues = sceneobjectdata.sceneobject function_38883b88ad46a4f4( shotindex, animindex );
    var_49209d5721bed4e2 = animationvalues.displacementtime;
    
    if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) || var_142c2c5d44216f2a > 0 )
    {
        var_49209d5721bed4e2 = 0;
    }
    
    if ( var_49209d5721bed4e2 > 0 )
    {
        wait var_49209d5721bed4e2;
    }
    
    b_looping = animislooping( animasset );
    var_b9d155388159ec8 = 0;
    var_54f04a5ef99aabb9 = 0;
    
    if ( var_142c2c5d44216f2a > 0 )
    {
        var_a3016ccb852a40c2 = function_1222280fb003fd62( animasset, animationvalues, var_142c2c5d44216f2a );
        
        if ( var_142c2c5d44216f2a == 1 && b_looping )
        {
            var_a3016ccb852a40c2 = 0.999999;
        }
        
        var_b9d155388159ec8 = getanimlength( animasset ) * var_a3016ccb852a40c2;
        var_54f04a5ef99aabb9 = n_anim_length * var_142c2c5d44216f2a;
    }
    else if ( animationvalues.var_a9b8dffd45b33087 > 0 )
    {
        var_b9d155388159ec8 = animationvalues.var_a9b8dffd45b33087;
        var_54f04a5ef99aabb9 = 0;
    }
    
    if ( var_142c2c5d44216f2a < 1 )
    {
        sceneobjectdata childthread function_26364b7b16eb9611( notifystring, animasset );
    }
    
    if ( sceneobjectdata function_514b2f4dda4105ef( shotindex ) )
    {
        animationapi = sceneobjectdata.scenedata.scenescriptbundle function_e676aa1c58e71d88();
        
        if ( sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036() == "UseOffset" )
        {
            animationapi = "ScriptModelPlayAnimDeltaMotionFromPos";
        }
        
        if ( animationapi == "AnimScripted" )
        {
            if ( sceneobjectdata.sceneobject function_c430cd420ee0185( shotindex ) )
            {
                entity scriptmodelclearanim();
            }
            
            var_2d749d02fccaab1 = sceneobjectdata.var_2d749d02fccaab1 ?? entity.var_2d749d02fccaab1;
            
            if ( isanimation( var_2d749d02fccaab1 ) && animislooping( var_2d749d02fccaab1 ) )
            {
                b_skip_animscripted = 1;
                waittillframeend();
            }
            
            if ( !entity isusinganimtree() || getanimtreeid( entity ) != sceneobjectdata.sceneobject function_4641057744100c08() )
            {
                entity useanimtree( sceneobjectdata.sceneobject function_4641057744100c08() );
            }
            
            entity.var_bbd02606816314a8 = gettime();
            
            if ( b_skip_animscripted )
            {
                entity stopuseanimtree();
                entity scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, var_b9d155388159ec8, var_3d2460219c7907a );
            }
            else
            {
                entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
                entity scriptmodelplayanim( str_anim_name, undefined, var_b9d155388159ec8, 1, var_3d2460219c7907a );
            }
            
            sceneobjectdata function_4a9835edd174d8e3( animasset );
            entity.var_2d749d02fccaab1 = animasset;
            sceneobjectdata.var_2d749d02fccaab1 = animasset;
            
            if ( var_142c2c5d44216f2a < 1 )
            {
                if ( b_skip_animscripted )
                {
                    entity function_638fda852a000584( notifystring, n_anim_length, var_54f04a5ef99aabb9, b_looping, 1 );
                }
                else
                {
                    entity function_638fda852a000584( notifystring, n_anim_length, var_54f04a5ef99aabb9, b_looping );
                }
            }
            
            entity.var_bbd02606816314a8 = undefined;
        }
        else if ( animationapi == "ScriptModelPlayAnimDeltaMotionFromPos" )
        {
            entity.var_bbd02606816314a8 = gettime();
            entity stopuseanimtree();
            entity scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, var_b9d155388159ec8, var_3d2460219c7907a );
            
            if ( sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036() == "UseOffset" )
            {
                entity function_dc6d1931148169ed();
            }
            
            sceneobjectdata function_4a9835edd174d8e3( animasset );
            entity.var_2d749d02fccaab1 = animasset;
            sceneobjectdata.var_2d749d02fccaab1 = animasset;
            
            if ( var_142c2c5d44216f2a < 1 )
            {
                entity function_638fda852a000584( notifystring, n_anim_length, var_54f04a5ef99aabb9, b_looping );
            }
            
            entity.var_bbd02606816314a8 = undefined;
        }
    }
    else
    {
        entity.var_bbd02606816314a8 = gettime();
        entity stopuseanimtree();
        entity scriptmodelplayanim( str_anim_name, notifystring, var_b9d155388159ec8, 1, var_3d2460219c7907a );
        
        if ( sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036() == "UseOffset" )
        {
            entity function_dc6d1931148169ed();
        }
        
        sceneobjectdata function_4a9835edd174d8e3( animasset );
        entity function_638fda852a000584( notifystring, n_anim_length, var_54f04a5ef99aabb9, b_looping );
        entity scriptmodelclearanim();
        entity useanimtree( sceneobjectdata.sceneobject function_4641057744100c08() );
        entity.var_bbd02606816314a8 = undefined;
    }
    
    return var_49209d5721bed4e2 + n_anim_length - var_142c2c5d44216f2a * n_anim_length;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xbbe58b0e, Offset: 0x5352
// Size: 0x47, Type: bool
function private function_c430cd420ee0185( shotindex )
{
    sceneobject = self;
    shotobject = sceneobject.variant_object.shots[ shotindex ];
    return !shotobject.var_eddf72690285f0b4;
}

// Namespace scene
// Params 5, eflags: 0x4
// Checksum 0x5c8cb712, Offset: 0x53a2
// Size: 0xa9
function private function_638fda852a000584( notifystring, n_anim_length, starttimeinseconds, b_looping, b_forced_timeout )
{
    self endon( #"stop_animmode" );
    
    if ( b_forced_timeout )
    {
        n_timeout = n_anim_length - starttimeinseconds;
        utility::waittill_any_timeout( n_timeout, "end", "stop_animmode" );
        return;
    }
    
    if ( b_looping || starttimeinseconds == 0 )
    {
        utility::function_1c579064b3fda85d( notifystring, "end", "stop_animmode" );
        return;
    }
    
    n_timeout = n_anim_length - starttimeinseconds;
    msg = utility::waittill_match_or_timeout( notifystring, "end", n_timeout );
}

// Namespace scene
// Params 9, eflags: 0x4
// Checksum 0xd8eb587c, Offset: 0x5453
// Size: 0x35b
function private function_1bd42d28e8e1ad9( shotindex, animindex, notifystring, alignmentinfo, animasset, var_142c2c5d44216f2a, blendtime, blendcurve, lerptime )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    animlengthtime = 0;
    done = 0;
    
    if ( entity.model == "" )
    {
        println( "<dev string:x20b>" + sceneobjectdata.sceneobject.variant_object.name + "<dev string:x23b>" );
        return 0;
    }
    
    entity endon( #"death_or_disconnect" );
    entity endon( #"vehicle_scene_stop" );
    
    if ( !isdefined( blendtime ) )
    {
        blendtime = 0;
    }
    
    if ( !isdefined( lerptime ) )
    {
        lerptime = 0;
    }
    
    if ( isdefined( sceneobjectdata.scenedata.var_a173fd36d9f698cb ) )
    {
        blendtime = 0;
        lerptime = 0;
    }
    
    str_anim_name = getanimname( animasset );
    update_alignment_transform( alignmentinfo );
    
    if ( entity vehicle_isphysveh() )
    {
        entity function_d2b8ee2e1275daaf( 1 );
        entity vehphys_forcekeyframedmotion();
    }
    else
    {
        entity notsolid();
    }
    
    entity function_3a1419fc14471ab( 1 );
    var_7aa8c0693684425c = lerptime != 0;
    
    if ( !var_7aa8c0693684425c )
    {
        entity dontinterpolate();
    }
    
    startorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
    startangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
    entity vehicle_teleport( startorigin, startangles, var_7aa8c0693684425c );
    
    if ( var_142c2c5d44216f2a < 1 )
    {
        sceneobjectdata childthread function_26364b7b16eb9611( notifystring, animasset );
    }
    
    var_621ac137db968583 = sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036();
    
    if ( var_621ac137db968583 == "UseOffset" )
    {
        entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
        entity vehicleplayanim( animasset, 1, 1, alignmentinfo.origin, alignmentinfo.angles );
        entity function_dc6d1931148169ed();
    }
    else
    {
        entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, undefined, blendtime );
        entity vehicleplayanim( animasset );
    }
    
    sceneobjectdata function_4a9835edd174d8e3( animasset );
    
    if ( var_142c2c5d44216f2a > 0 && var_142c2c5d44216f2a <= 1 )
    {
        if ( var_142c2c5d44216f2a == 1 && animislooping( animasset ) )
        {
            var_142c2c5d44216f2a = 0.999999;
        }
        
        sceneobjectdata function_4c574c265ff9cd1e( animasset, var_142c2c5d44216f2a );
    }
    
    animlengthtime += getanimlength( animasset );
    n_wait_time = animlengthtime - var_142c2c5d44216f2a * animlengthtime;
    
    if ( var_142c2c5d44216f2a < 1 )
    {
        wait n_wait_time;
    }
    
    if ( entity vehicle_isphysveh() )
    {
        entity function_d2b8ee2e1275daaf( 0 );
        entity vehphys_setdefaultmotion();
    }
    else
    {
        entity solid();
    }
    
    if ( isdefined( entity.var_ef1f396045fd1479 ) )
    {
        entity thread [[ entity.var_ef1f396045fd1479 ]]();
    }
    
    return n_wait_time;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xa23a588e, Offset: 0x57b7
// Size: 0x228
function private vehicle_spawn_mp( spawnorigin, spawnangles )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.sceneobject.variant_object.vehiclename ) )
    {
        sceneobjectassettype = "vehicle";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.vehiclename;
    }
    else
    {
        sceneobjectassettype = "xmodel";
        sceneobjectassetname = sceneobjectdata.sceneobject.variant_object.xmodelname;
    }
    
    if ( !isdefined( sceneobjectdata.entity ) )
    {
        if ( sceneobjectassettype == "vehicle" )
        {
            spawndata = spawnstruct();
            spawndata.origin = spawnorigin;
            spawndata.angles = spawnangles;
            spawndata.vehicletype = sceneobjectassetname;
            spawndata.targetname = "scene_vehicle";
            
            if ( isdefined( level.var_13a27bc8430578c3[ sceneobjectdata.sceneobject.variant_object.name ] ) )
            {
                spawndata.modelname = level.var_13a27bc8430578c3[ sceneobjectdata.sceneobject.variant_object.name ];
            }
            else
            {
                skinoverride = undefined;
                hybridscriptbundle = function_568f797e7642c672( "vehicle", sceneobjectassetname );
                
                if ( isdefined( hybridscriptbundle ) )
                {
                    skinoverride = hybridscriptbundle.bundle.skinoverride;
                }
                
                if ( isdefined( skinoverride ) && skinoverride != "" )
                {
                    spawndata.modelname = skinoverride + "::" + vehicle_modelname( sceneobjectassetname );
                }
                else
                {
                    spawndata.modelname = vehicle_modelname( sceneobjectassetname );
                }
            }
            
            sceneobjectdata.entity = vehicle_tracking::spawn_vehicle( spawndata );
        }
        else
        {
            sceneobjectdata.entity = utility::spawn_model( sceneobjectassetname, spawnorigin, spawnangles );
        }
    }
    
    return sceneobjectdata.entity;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xb49ce625, Offset: 0x59e8
// Size: 0x2e
function private vehicle_delete()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        sceneobjectdata.entity delete();
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xf8ae8c7f, Offset: 0x5a1e
// Size: 0x14
function private function_3cac183e277eeef6( entity )
{
    return entity vehicle::is_vehicle();
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xf7e86672, Offset: 0x5a3b
// Size: 0x64
function private function_26c73211ad2ac8f8( animname, animtree )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) && !isdefined( sceneobjectdata.entity.animname ) )
    {
        sceneobjectdata.entity.animname = animname;
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xa8f45a26, Offset: 0x5aa7
// Size: 0xc
function private function_d82b1e1acc9a94c6( animrate )
{
    
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x2daa123, Offset: 0x5abb
// Size: 0xb6, Type: bool
function private object_pause_anim_mp( pausestate )
{
    sceneobjectdata = self;
    entity = sceneobjectdata function_15e572f4ed82dd1c();
    
    if ( isent( entity ) && entity function_7c0d254f28465543( pausestate ) )
    {
        entity scriptmodelpauseanim( pausestate );
        
        if ( entity isusinganimtree() && isdefined( sceneobjectdata.activeanimation ) )
        {
            animrate = sceneobjectdata.sceneroot.scenestatic.animrate ?? 1;
            entity setanimrate( sceneobjectdata.activeanimation, pausestate ? 0 : animrate );
        }
        
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xfc686b04, Offset: 0x5b7a
// Size: 0xcf
function private function_3ab18e0dd5065892()
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        if ( sceneobjectdata.sceneobject function_fc09a0af0b50d3d4() != "bulletweapon" )
        {
            sceneobjectdata.entity stopanimscripted();
            
            if ( !sceneobjectdata.sceneobject function_641be9c20b5bac24() )
            {
                sceneobjectdata.entity scriptmodelclearanim();
            }
        }
        
        sceneobjectdata.entity notify( #"stop_loop" );
        sceneobjectdata.entity notify( #"single anim", "end" );
        sceneobjectdata.entity notify( #"looping anim", "end" );
        sceneobjectdata.entity notify( #"stop_animmode" );
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xaca59266, Offset: 0x5c51
// Size: 0xed
function private object_first_frame_mp( alignmentinfo, shotindex )
{
    sceneobjectdata = self;
    
    if ( isdefined( sceneobjectdata.entity ) )
    {
        shotanimation = sceneobjectdata.sceneobject.variant_object.shots[ shotindex ].deltaanimations[ 0 ];
        animasset = sceneobjectdata function_465d05ff89283a66( shotindex, shotanimation );
        str_anim_name = getanimname( animasset );
        
        if ( !isdefined( animasset ) )
        {
            return;
        }
        
        sceneobjectdata.entity stopuseanimtree();
        sceneobjectdata.entity scriptmodelclearanim();
        sceneobjectdata.entity stopanimscripted();
        sceneobjectdata.entity scriptmodelplayanim( str_anim_name, undefined, 0, 0, "none" );
        sceneobjectdata.var_2d749d02fccaab1 = animasset;
    }
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0xb32b653a, Offset: 0x5d46
// Size: 0x87
function private object_teleport_mp( origin, angles )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( isdefined( entity ) )
    {
        if ( entity.classname == "script_model" )
        {
            entity scriptmodelclearanim();
        }
        
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

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0xb96331b9, Offset: 0x5dd5
// Size: 0x4e, Type: bool
function private function_25906aa231d05919( entity )
{
    if ( entity.classname == "script_model" || entity.classname == "script_vehicle" || entity.code_classname == "scriptable" )
    {
        return true;
    }
    
    return false;
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0x224cd442, Offset: 0x5e2c
// Size: 0x1a4
function private function_631fb5f4f6f70a15( alignmentinfo, animasset, notifystring, var_142c2c5d44216f2a, var_ab6f54ef0991868f, animationtype )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    animationapi = sceneobjectdata.scenedata.scenescriptbundle function_e676aa1c58e71d88();
    str_anim_name = getanimname( animasset );
    starttimeinseconds = var_142c2c5d44216f2a * getanimlength( animasset );
    endtimeinseconds = var_ab6f54ef0991868f * getanimlength( animasset );
    
    if ( animationapi == "AnimScripted" )
    {
        entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset );
        
        if ( entity isusinganimtree() )
        {
            entity setanimtime( animasset, var_142c2c5d44216f2a );
            entity scriptmodelplayanim( str_anim_name, undefined, starttimeinseconds, 1 );
            
            if ( !( animislooping( animasset ) && var_ab6f54ef0991868f == 1 ) )
            {
                entity setanimtime( animasset, var_ab6f54ef0991868f, undefined, 1 );
                entity scriptmodelplayanim( str_anim_name, undefined, endtimeinseconds, 1 );
            }
        }
        
        return;
    }
    
    if ( animationapi == "ScriptModelPlayAnimDeltaMotionFromPos" )
    {
        entity stopuseanimtree();
        entity scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, starttimeinseconds );
        
        if ( !( animislooping( animasset ) && var_ab6f54ef0991868f == 1 ) )
        {
            entity scriptmodelplayanimdeltamotionfrompos( str_anim_name, alignmentinfo.origin, alignmentinfo.angles, notifystring, endtimeinseconds );
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x69a681ae, Offset: 0x5fd8
// Size: 0xc
function private function_77ecba972efd637b( animrate )
{
    
}

// Namespace scene
// Params 6, eflags: 0x4
// Checksum 0x9c88a4fd, Offset: 0x5fec
// Size: 0x1e6
function private function_25d28095e3c9d6f0( alignmentinfo, animasset, notifystring, var_142c2c5d44216f2a, var_ab6f54ef0991868f, animationtype )
{
    sceneobjectdata = self;
    entity = sceneobjectdata.entity;
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity vehicle_isphysveh() )
    {
        entity function_d2b8ee2e1275daaf( 1 );
        entity vehphys_forcekeyframedmotion();
    }
    else
    {
        entity notsolid();
    }
    
    update_alignment_transform( alignmentinfo );
    startorigin = getstartorigin( alignmentinfo.origin, alignmentinfo.angles, animasset );
    startangles = getstartangles( alignmentinfo.origin, alignmentinfo.angles, animasset );
    entity vehicle_teleport( startorigin, startangles, 0 );
    entity function_3a1419fc14471ab( 1 );
    sceneobjectdata childthread function_26364b7b16eb9611( notifystring, animasset );
    var_621ac137db968583 = sceneobjectdata.scenedata.scenescriptbundle function_cf01ff8a72173036();
    
    if ( var_621ac137db968583 == "UseOffset" )
    {
        entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset );
        entity vehicleplayanim( animasset, 1, 1, alignmentinfo.origin, alignmentinfo.angles );
        entity function_dc6d1931148169ed();
    }
    else
    {
        entity animscripted( notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset );
        entity vehicleplayanim( animasset );
    }
    
    if ( animislooping( animasset ) && var_ab6f54ef0991868f == 1 )
    {
        var_ab6f54ef0991868f = 0.999999;
    }
    
    sceneobjectdata function_4c574c265ff9cd1e( animasset, var_ab6f54ef0991868f );
    
    if ( entity vehicle_isphysveh() )
    {
        entity function_d2b8ee2e1275daaf( 0 );
        entity vehphys_setdefaultmotion();
        return;
    }
    
    entity solid();
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x3a78c901, Offset: 0x61da
// Size: 0xaa, Type: bool
function private function_28c647f8c3df91be( shotindex )
{
    sceneobjectdata = self;
    
    if ( !isdefined( sceneobjectdata.sceneobject.variant_object.shots ) )
    {
        return false;
    }
    
    if ( shotindex < 0 || shotindex >= sceneobjectdata.sceneobject.variant_object.shots.size )
    {
        return false;
    }
    
    shotobject = sceneobjectdata.sceneobject.variant_object.shots[ shotindex ];
    return shotobject.var_ff1ed4febc62f24e ?? 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xdb5f1b43, Offset: 0x628d
// Size: 0x26, Type: bool
function private function_f1457dcda24ec463()
{
    sceneobjectdata = self;
    agenttype = sceneobjectdata function_c985f88f42ca3153();
    return agenttype.size > 0;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x79503664, Offset: 0x62bc
// Size: 0x2e
function private function_595110e9ec0805f8()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_cf299fb076c67845;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x5468a478, Offset: 0x62f3
// Size: 0x2e
function private function_c985f88f42ca3153()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_e6b77d58ee8176a4;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x822cd357, Offset: 0x632a
// Size: 0x2e
function private function_3eae5086957d2536()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_1cf79ffa7b97aa79;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x86796a5b, Offset: 0x6361
// Size: 0x2e
function private function_a23a5ede0e977d52()
{
    sceneobjectdata = self;
    return sceneobjectdata.sceneobject.variant_object.var_6ebd60b357989051;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x7a62baf2, Offset: 0x6398
// Size: 0x5f7
function private function_69d96401c55f0f46()
{
    sceneplay = self;
    sceneplay endon( #"stopped" );
    scenedata = sceneplay.sceneroot.scenedata;
    
    if ( !isdefined( sceneplay.var_6ee3367aabd58bae ) )
    {
        sceneplay.var_6ee3367aabd58bae = [];
    }
    
    var_2fe0ea6d17b4fc16 = 0;
    
    if ( isdefined( scenedata ) )
    {
        for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( sceneobjectdata object_get_type() == "Types_Player" )
            {
                sceneplay.var_6ee3367aabd58bae[ var_2fe0ea6d17b4fc16 ] = spawnstruct();
                sceneplay.var_6ee3367aabd58bae[ var_2fe0ea6d17b4fc16 ].replacementallowed = 1;
                
                if ( sceneobjectdata function_58b62b656cb29e76() )
                {
                    if ( isdefined( sceneobjectdata.var_bb90b6cef43f6c8f ) )
                    {
                        if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_bb90b6cef43f6c8f ].entity ) )
                        {
                            sceneplay.var_6ee3367aabd58bae[ var_2fe0ea6d17b4fc16 ].replacementallowed = 0;
                        }
                    }
                }
                else if ( isdefined( sceneobjectdata.var_fc43e503169048b4 ) )
                {
                    if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_fc43e503169048b4 ].entity ) )
                    {
                        sceneplay.var_6ee3367aabd58bae[ var_2fe0ea6d17b4fc16 ].replacementallowed = 0;
                    }
                }
                
                var_2fe0ea6d17b4fc16++;
            }
        }
    }
    
    if ( var_2fe0ea6d17b4fc16 == 0 )
    {
        return;
    }
    
    sceneplay function_b123166953f6d9a6();
    
    while ( true )
    {
        waittillframeend();
        playerindex = 0;
        
        for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( sceneobjectdata object_get_type() == "Types_Player" )
            {
                replacementallowed = istrue( sceneplay.var_6ee3367aabd58bae[ playerindex ].replacementallowed );
                replacementisenabled = sceneobjectdata function_f1457dcda24ec463() || isdefined( sceneobjectdata function_595110e9ec0805f8() );
                
                if ( replacementallowed && replacementisenabled && !isdefined( sceneobjectdata.entity ) && !sceneobjectdata function_9cc7c6462e29a12f( scenedata ) )
                {
                    entitydesc = sceneplay.var_6ee3367aabd58bae[ playerindex ];
                    var_4f9ad288d6733280 = !isdefined( sceneobjectdata function_595110e9ec0805f8() );
                    
                    if ( var_4f9ad288d6733280 )
                    {
                        if ( isdefined( sceneobjectdata.var_8646e6e746d76127 ) && !isdefined( entitydesc.agententity ) )
                        {
                            sceneobjectdata function_54b3f2215c420c0c( sceneobjectdata.var_8646e6e746d76127, entitydesc );
                        }
                        
                        if ( isdefined( sceneobjectdata.var_8646e6e746d76127 ) && sceneobjectdata.var_8646e6e746d76127.newrequest )
                        {
                            agententity = entitydesc.agententity;
                            
                            if ( isdefined( agententity ) )
                            {
                                agententity notify( #"hash_c01a9f43c01d8d25" );
                                playeraniminfo = sceneobjectdata.var_8646e6e746d76127;
                                n_anim_length = getanimlength( playeraniminfo.animasset );
                                var_38ab1a8ecfb1cfbd = gettime();
                                var_65b277d936b5d000 = ( var_38ab1a8ecfb1cfbd - playeraniminfo.var_c91cbb6de72ec395 ) / 1000;
                                var_68ec342e9fa44cab = playeraniminfo.var_142c2c5d44216f2a;
                                
                                if ( n_anim_length > 0 )
                                {
                                    var_68ec342e9fa44cab += var_65b277d936b5d000 / n_anim_length;
                                }
                                
                                var_f6d9e11e9b6ac243 = sceneobjectdata function_a23a5ede0e977d52();
                                agententity thread function_36f251e37c52a25a( sceneobjectdata, playeraniminfo.shotindex, playeraniminfo.animindex, playeraniminfo.notifystring, playeraniminfo.alignmentinfo, playeraniminfo.animasset, var_68ec342e9fa44cab, playeraniminfo.blendtime, playeraniminfo.blendcurve, playeraniminfo.lerptime, var_f6d9e11e9b6ac243 );
                                sceneobjectdata.var_8646e6e746d76127.newrequest = 0;
                            }
                        }
                    }
                    else
                    {
                        if ( isdefined( sceneobjectdata.var_8646e6e746d76127 ) && !isdefined( entitydesc.scriptmodelentity ) )
                        {
                            modelname = sceneobjectdata function_595110e9ec0805f8();
                            entitydesc.scriptmodelentity = function_d1369cd2dbf74382( sceneobjectdata.var_8646e6e746d76127.alignmentinfo.origin, sceneobjectdata.var_8646e6e746d76127.alignmentinfo.angles, modelname );
                            sceneobjectdata.replacemententity = entitydesc.scriptmodelentity;
                            sceneobjectdata.entity = sceneobjectdata.replacemententity;
                            sceneobjectdata function_b51fccb24b16290a( sceneplay, 1, 0, sceneobjectdata.alignmentinfo );
                        }
                        
                        if ( isdefined( sceneobjectdata.var_8646e6e746d76127 ) && sceneobjectdata.var_8646e6e746d76127.newrequest )
                        {
                            scriptmodelentity = entitydesc.scriptmodelentity;
                            
                            if ( isdefined( scriptmodelentity ) )
                            {
                                playeraniminfo = sceneobjectdata.var_8646e6e746d76127;
                                n_anim_length = getanimlength( playeraniminfo.animasset );
                                var_38ab1a8ecfb1cfbd = gettime();
                                var_65b277d936b5d000 = float( var_38ab1a8ecfb1cfbd - playeraniminfo.var_c91cbb6de72ec395 ) / 1000;
                                str_anim_name = getanimname( playeraniminfo.animasset );
                                var_3d2460219c7907a = "none";
                                scriptmodelentity stopuseanimtree();
                                scriptmodelentity scriptmodelplayanimdeltamotionfrompos( str_anim_name, playeraniminfo.alignmentinfo.origin, playeraniminfo.alignmentinfo.angles, playeraniminfo.notifystring, var_65b277d936b5d000, var_3d2460219c7907a );
                                sceneobjectdata.var_8646e6e746d76127.newrequest = 0;
                            }
                        }
                    }
                }
                
                playerindex++;
            }
        }
        
        waitframe();
    }
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0x4e1b8f48, Offset: 0x6997
// Size: 0xad
function private function_511918b804a5e6b1()
{
    sceneplay = self;
    
    if ( !isdefined( sceneplay.var_6ee3367aabd58bae ) )
    {
        return;
    }
    
    foreach ( entitydesc in sceneplay.var_6ee3367aabd58bae )
    {
        function_d9004430bff2b135( entitydesc );
        function_f1c5f0ed9fed6795( entitydesc );
    }
    
    sceneplay.var_6ee3367aabd58bae = undefined;
}

// Namespace scene
// Params 2, eflags: 0x4
// Checksum 0x7bc0bba6, Offset: 0x6a4c
// Size: 0xd0
function private function_54b3f2215c420c0c( playeraniminfo, entitydesc )
{
    sceneobjectdata = self;
    agent_type = sceneobjectdata function_c985f88f42ca3153();
    agent_team = sceneobjectdata function_3eae5086957d2536();
    newagent = mp_agent::spawnnewagentaitype( agent_type, playeraniminfo.alignmentinfo.origin, playeraniminfo.alignmentinfo.angles, agent_team );
    entitydesc.agententity = newagent;
    sceneobjectdata.replacemententity = newagent;
    sceneobjectdata.entity = newagent;
    sceneobjectdata function_b51fccb24b16290a( sceneobjectdata.sceneplay, 1, 0, sceneobjectdata.alignmentinfo );
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x84362fa9, Offset: 0x6b24
// Size: 0x71
function private function_d9004430bff2b135( entitydesc )
{
    if ( !isdefined( entitydesc.agententity ) )
    {
        return;
    }
    
    agententity = entitydesc.agententity;
    agententity notify( #"hash_6a8b9af15f1a2efe" );
    assert( isagent( agententity ) );
    agententity.nocorpse = 1;
    agententity agent_utils::despawnagent();
    entitydesc.agententity = undefined;
}

// Namespace scene
// Params 3, eflags: 0x4
// Checksum 0xd9a7211f, Offset: 0x6b9d
// Size: 0x54
function private function_d1369cd2dbf74382( spawnorigin, spawnangles, modelname )
{
    newentity = utility::spawn_model( modelname, spawnorigin, spawnangles );
    newentity forcenetfieldhighlod( 1 );
    newentity val::set( "scene_shot", "cinematics_participant", 1 );
    return newentity;
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x7c0a2b14, Offset: 0x6bfa
// Size: 0x46
function private function_f1c5f0ed9fed6795( entitydesc )
{
    if ( !isdefined( entitydesc.scriptmodelentity ) )
    {
        return;
    }
    
    scriptmodelentity = entitydesc.scriptmodelentity;
    scriptmodelentity delete();
    entitydesc.scriptmodelentity = undefined;
}

// Namespace scene
// Params 0, eflags: 0x4
// Checksum 0xafa11b56, Offset: 0x6c48
// Size: 0x1cf
function private function_b123166953f6d9a6()
{
    sceneplay = self;
    scenedata = sceneplay.sceneroot.scenedata;
    playerindex = 0;
    
    for ( sceneobjectindex = 0; sceneobjectindex < scenedata.sceneobjectdata.size ; sceneobjectindex++ )
    {
        sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
        
        if ( sceneobjectdata object_get_type() == "Types_Player" )
        {
            replacementallowed = istrue( sceneplay.var_6ee3367aabd58bae[ playerindex ].replacementallowed );
            replacementisenabled = isdefined( sceneobjectdata function_595110e9ec0805f8() );
            
            if ( replacementallowed && replacementisenabled && !isdefined( sceneobjectdata.entity ) )
            {
                entitydesc = sceneplay.var_6ee3367aabd58bae[ playerindex ];
                
                if ( !isdefined( entitydesc.scriptmodelentity ) )
                {
                    spawnorigin = sceneplay.sceneroot.origin;
                    spawnorigin += ( 0, 0, -200 );
                    spawnangles = sceneplay.sceneroot.angles;
                    modelname = sceneobjectdata function_595110e9ec0805f8();
                    entitydesc.scriptmodelentity = function_d1369cd2dbf74382( spawnorigin, spawnangles, modelname );
                    sceneobjectdata.replacemententity = entitydesc.scriptmodelentity;
                    sceneobjectdata.entity = sceneobjectdata.replacemententity;
                    
                    if ( isdefined( sceneobjectdata.alignmentinfo ) )
                    {
                        sceneobjectdata function_b51fccb24b16290a( sceneplay, 1, 0, sceneobjectdata.alignmentinfo );
                    }
                }
            }
            
            playerindex++;
        }
    }
}

// Namespace scene
// Params 1, eflags: 0x4
// Checksum 0x975c2798, Offset: 0x6e1f
// Size: 0x9e, Type: bool
function private function_9cc7c6462e29a12f( scenedata )
{
    sceneobjectdata = self;
    
    if ( sceneobjectdata object_get_type() != "Types_Player" )
    {
        return false;
    }
    
    if ( sceneobjectdata function_58b62b656cb29e76() )
    {
        if ( isdefined( sceneobjectdata.var_bb90b6cef43f6c8f ) )
        {
            return isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_bb90b6cef43f6c8f ].replacemententity );
        }
        
        return false;
    }
    
    if ( isdefined( sceneobjectdata.var_fc43e503169048b4 ) )
    {
        return isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_fc43e503169048b4 ].replacemententity );
    }
    
    return false;
}

// Namespace scene
// Params 0
// Checksum 0xce5be709, Offset: 0x6ec6
// Size: 0x4, Type: bool
function function_a979d7a483d6aa59()
{
    return true;
}

// Namespace scene
// Params 2
// Checksum 0x2e9c1244, Offset: 0x6ed3
// Size: 0xdd, Type: bool
function function_61e64bcdbcc13fe7( entity, sceneobjectdata )
{
    assert( isplayer( entity ) );
    scenedata = sceneobjectdata.scenedata;
    var_500c93b1c57c4849 = sceneobjectdata function_58b62b656cb29e76();
    
    if ( var_500c93b1c57c4849 )
    {
        if ( isdefined( sceneobjectdata.var_bb90b6cef43f6c8f ) )
        {
            if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_bb90b6cef43f6c8f ].entity ) )
            {
                return false;
            }
        }
    }
    else if ( isdefined( sceneobjectdata.var_fc43e503169048b4 ) )
    {
        if ( isdefined( scenedata.sceneobjectdata[ sceneobjectdata.var_fc43e503169048b4 ].entity ) )
        {
            return false;
        }
    }
    
    var_37dbbf704caaa20b = entity operator::isfemale();
    
    if ( var_500c93b1c57c4849 != var_37dbbf704caaa20b )
    {
        return false;
    }
    
    return true;
}

// Namespace scene
// Params 2
// Checksum 0xc3640338, Offset: 0x6fb9
// Size: 0xfb
function function_e96a757b2bdad619( client, mvparray )
{
    var_647d77bf568d0fbd = [];
    
    if ( mvparray.size > 0 )
    {
        foreach ( entry in mvparray )
        {
            if ( !isdefined( entry.characterindex ) )
            {
                assertmsg( "<dev string:x23d>" );
                continue;
            }
            
            if ( entry.characterindex >= 20 )
            {
                assertmsg( "<dev string:x272>" + entry.characterindex + "<dev string:x2a0>" );
                continue;
            }
            
            var_647d77bf568d0fbd[ var_647d77bf568d0fbd.size ] = entry;
        }
    }
    
    if ( var_647d77bf568d0fbd.size > 0 )
    {
        function_d16a219fb1a7b88d( client, var_647d77bf568d0fbd );
    }
}

