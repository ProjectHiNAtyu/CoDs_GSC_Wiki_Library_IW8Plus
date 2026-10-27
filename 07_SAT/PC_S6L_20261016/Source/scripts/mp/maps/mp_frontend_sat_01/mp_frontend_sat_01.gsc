// scripts\mp\maps\mp_frontend_sat_01\mp_frontend_sat_01.gsc  (hash_687cbcf773b9b3fd.gscc) (size: 23696 Bytes / 0x5c90 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaff8f447 (2952328263)
// size ...... 23696 (0x5c90)
// includes .. 13  (offset: 0x587c)
// strings ... 65  (offset: 0x58e4)
// dev strs .. 5   (offset: 0x5c54)
// exports ... 47  (offset: 0x3e34)
// cseg ...... 0x5af + 0x3885 (0x3e34)
// imports ... 152 (offset: 0x458c)
// animtree1 . 0   (offset: 0x5c90)
// animtree2 . 0   (offset: 0x5c90)
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\stackablehitmarker;
#using scripts\common\utility;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\frontendutils;
#using scripts\mp\maps\mp_frontend_sat_01\gen\mp_frontend_sat_01_art;
#using scripts\mp\maps\mp_frontend_sat_01\mp_frontend_sat_01_fx;
#using scripts\mp\maps\mp_frontend_sat_01\mp_frontend_sat_01_lighting;
#using scripts\mp\maps\mp_frontend_sat_01\mp_frontend_sat_01_precache;
#using scripts\mp\mtx_weapon;
#using scripts\mp\weapons_dev;

#namespace mp_frontend_sat_01;

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xf0ac7943, Offset: 0x5cd
// Size: 0xa9
function onplayerconnectrunonce()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level.playerviewowner = self;
    level.var_2012113081d2a67f = "iw9_";
    level.var_3ff084b89b959f13 = "";
    level.var_ccc8d1ad327315cd = 0;
    level.var_c4bbacdf528aed25 = [];
    level.var_d729b514dcdf4af9 = [];
    
    if ( isdefined( level.playerconnectedevents ) )
    {
        return;
    }
    
    level.playerconnectedevents = 1;
    thread function_3079b57592326a74();
    frontendutils::function_206e476c61647ec1();
    self enablephysicaldepthoffieldscripting();
    level init_scene_event();
    level thread function_b773e3ccf6bea5af();
    level thread function_bb88b50afbc84aee();
    wait 0.5;
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x75c9af9c, Offset: 0x67e
// Size: 0x9
function callback_frontendplayerconnect()
{
    thread onplayerconnectrunonce();
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0xc33abdab, Offset: 0x68f
// Size: 0x1f
function callback_frontendplayerdisconnect( reason )
{
    setdvar( @"bg_cinematicfullscreen", "1" );
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x4aaedb32, Offset: 0x6b6
// Size: 0x12c
function main()
{
    println( "<dev string:x24>" );
    mp_frontend_sat_01_precache::main();
    mp_frontend_sat_01_art::main();
    mp_frontend_sat_01_fx::main();
    mp_frontend_sat_01_lighting::main();
    stackablehitmarker::init();
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
        {
            return;
        }
    #/
    
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    level.projectbundle = getprojectscriptbundle();
    level.gamemodebundle = getgamemodescriptbundle();
    level.var_3d353e3274a23c81 = 0;
    frontendutils::init_frontend_utils();
    level.transition_interrupted = 0;
    level.showseasonalcontent = getdvarint( @"hash_ca079d844e54e73a" );
    level.ttlos_suppressasserts = 1;
    
    if ( getbuildversion() != "SHIP" )
    {
        weapons_dev::weapdev_init();
    }
    
    level.callbackplayerconnect = &callback_frontendplayerconnect;
    level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
    level thread initfiringrange();
    setdvar( @"r_mbradialoverridefocusdir", 1 );
    setdvar( @"bg_cinematicfullscreen", "0" );
    level mtx_weapon::function_f877fea1e7d31f31();
    
    /#
        level thread animation::function_2cff1618834b2ab7();
        level thread watch_scene();
    #/
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x8040d4e8, Offset: 0x7ea
// Size: 0x1c4
function function_b773e3ccf6bea5af()
{
    if ( getdvarint( @"hash_5227f95c5053fcc", 0 ) )
    {
        return;
    }
    
    var_68ed1cb392fe463a = getentarray( "frontend_bink_light", #script_noteworthy );
    var_8d506f8afdbe1dac = [];
    
    foreach ( entry in level.gamemodebundle.var_c54f7935e2687041 )
    {
        var_8d506f8afdbe1dac = arraycombine( var_8d506f8afdbe1dac, getentarray( entry.targetname, #targetname ) );
    }
    
    eventdata = get_active_scene_event();
    var_7bc60d749c88d9b5 = function_7141bfed6e6f14d( eventdata.var_34896dd25038eb56 );
    var_6224d27d4f1e6b3f = function_be0dd53539a68b65( var_8d506f8afdbe1dac, var_7bc60d749c88d9b5 );
    
    foreach ( light in var_68ed1cb392fe463a )
    {
        var_42ad5d2c3e4f309c = !isdefined( var_6224d27d4f1e6b3f[ light getentitynumber() ] );
        
        /#
            if ( getdvarint( @"hash_2d6e2d55eeb17ac3", 0 ) )
            {
                var_42ad5d2c3e4f309c = 0;
            }
            else if ( getdvarint( @"hash_7d68b074bdaea920", 0 ) )
            {
                var_42ad5d2c3e4f309c = 1;
            }
        #/
        
        light function_fcf6b815538e1f54( var_42ad5d2c3e4f309c );
        waitframe();
    }
}

/#

    // Namespace mp_frontend_sat_01
    // Params 0
    // Checksum 0x9dcca542, Offset: 0x9b6
    // Size: 0x6c, Type: dev
    function watch_scene()
    {
        while ( true )
        {
            shouldplay = getdvarint( @"hash_ca167f2be850ac25", 0 );
            
            if ( shouldplay == 1 )
            {
                setdvar( @"hash_ca167f2be850ac25", 0 );
                scenename = getdvar( @"hash_4d1bdabe05cf586d", "<dev string:x36>" );
                
                if ( isdefined( scenename ) )
                {
                    scene::play( undefined, undefined, scenename );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xd383371d, Offset: 0xa2a
// Size: 0x400
function function_3079b57592326a74()
{
    level.lanetriggers = frontendutils::function_55f1609e123f6a51( "shooting_range_lane_triggers" );
    level.roomtrigger = frontendutils::frontend_camera_get_entity( "shooting_range_room_trigger" );
    level.firingrangetargets = frontendutils::function_55f1609e123f6a51( "enemyTarget" );
    level.var_480357a8ac4a1212 = frontendutils::function_55f1609e123f6a51( "firingrange_target_1" );
    level.var_480356a8ac4a0fdf = frontendutils::function_55f1609e123f6a51( "firingrange_target_2" );
    level.var_480355a8ac4a0dac = frontendutils::function_55f1609e123f6a51( "firingrange_target_3" );
    level.var_88efb3520383bb2 = arraycombine( level.var_480357a8ac4a1212, level.var_480356a8ac4a0fdf, level.var_480355a8ac4a0dac );
    level.var_8d05a2b01cb7422 = 0;
    
    foreach ( frtarget in level.firingrangetargets )
    {
        targetpositions = utility::getstructarray( frtarget.target, "targetname" );
        
        foreach ( position in targetpositions )
        {
            switch ( position.script_noteworthy )
            {
                case #"hash_683099596bfc9c1a":
                    frtarget.position1 = position.origin;
                    break;
                case #"hash_683098596bfc9a87":
                    frtarget.position2 = position.origin;
                    break;
                case #"hash_683097596bfc98f4":
                    frtarget.position3 = position.origin;
                    break;
                default:
                    break;
            }
        }
        
        damagetriggers = getentarray( frtarget.target, #targetname );
        
        foreach ( trigg in damagetriggers )
        {
            trigg enablelinkto();
            
            if ( !isplayer( trigg ) )
            {
                trigg linkto( frtarget );
            }
        }
    }
    
    foreach ( light in level.var_88efb3520383bb2 )
    {
        light.var_a04f31996e6b5246 = light getlightintensity();
    }
    
    thread function_ec2bac4d6225817c( "lane1" );
    
    foreach ( trig in level.lanetriggers )
    {
        trig.var_33f76c2d569e4abf = 0;
        trig thread function_ca87a1115b909f2c();
    }
    
    setomnvar( "ui_firing_range_lane", -1 );
    setomnvar( "ui_firing_range_target_kill_count", 0 );
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x4ddad92f, Offset: 0xe32
// Size: 0x148
function function_ca87a1115b909f2c()
{
    while ( true )
    {
        if ( !self.var_33f76c2d569e4abf )
        {
            self waittill( #"trigger" );
            thread function_820594477a5e5d93( self.script_noteworthy );
            thread function_ec2bac4d6225817c( self.script_noteworthy );
            level notify( #"firing_range_weapon_stats_reset" );
            
            foreach ( trig in level.lanetriggers )
            {
                trig.var_33f76c2d569e4abf = 0;
            }
            
            self.var_33f76c2d569e4abf = 1;
            setomnvar( "ui_firing_range_target_kill_count", 0 );
            setomnvar( "ui_firing_range_accuracy", 0 );
            level.var_6d20f1bfea78492e = 0;
            level.var_65d3ec21afb8c1b1 = 0;
            level.bulletshitsecondary = 0;
            level.var_ec67017c22f64929 = 0;
            level.var_38e10219d88bb19c = 0;
            level.var_edd9d75d4e242354 = 0;
            level.primarydamagedealt = 0;
            level.secondarydamagedealt = 0;
            continue;
        }
        
        wait 1;
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0xaa061bc, Offset: 0xf82
// Size: 0x25b
function function_ec2bac4d6225817c( lane )
{
    foreach ( light in level.var_88efb3520383bb2 )
    {
        light setlightintensity( 0 );
    }
    
    level.var_8d05a2b01cb7422++;
    wait 1.5;
    
    if ( level.var_8d05a2b01cb7422 < 2 )
    {
        switch ( lane )
        {
            case #"hash_683099596bfc9c1a":
                foreach ( light in level.var_480357a8ac4a1212 )
                {
                    light setlightintensity( light.var_a04f31996e6b5246 );
                }
                
                break;
            case #"hash_683098596bfc9a87":
                foreach ( light in level.var_480356a8ac4a0fdf )
                {
                    light setlightintensity( light.var_a04f31996e6b5246 );
                }
                
                break;
            case #"hash_683097596bfc98f4":
                foreach ( light in level.var_480355a8ac4a0dac )
                {
                    light setlightintensity( light.var_a04f31996e6b5246 );
                }
                
                break;
            default:
                break;
        }
    }
    
    level.var_8d05a2b01cb7422--;
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x98ebd461, Offset: 0x11e5
// Size: 0x1b7
function function_820594477a5e5d93( newposition )
{
    foreach ( frtarget in level.firingrangetargets )
    {
        switch ( newposition )
        {
            case #"hash_683099596bfc9c1a":
                setomnvar( "ui_firing_range_lane", 1 );
                
                if ( frtarget.var_f9a396aeb09d7be2 )
                {
                    frtarget thread function_aaea15f4823e8b6d( frtarget.position1 );
                }
                else
                {
                    frtarget thread watchdeathonmove( frtarget.position1 );
                }
                
                break;
            case #"hash_683098596bfc9a87":
                setomnvar( "ui_firing_range_lane", 2 );
                
                if ( frtarget.var_f9a396aeb09d7be2 )
                {
                    frtarget thread function_aaea15f4823e8b6d( frtarget.position2 );
                }
                else
                {
                    frtarget thread watchdeathonmove( frtarget.position2 );
                }
                
                break;
            case #"hash_683097596bfc98f4":
                setomnvar( "ui_firing_range_lane", 3 );
                
                if ( frtarget.var_f9a396aeb09d7be2 )
                {
                    frtarget thread function_aaea15f4823e8b6d( frtarget.position3 );
                }
                else
                {
                    frtarget thread watchdeathonmove( frtarget.position3 );
                }
                
                break;
            default:
                setomnvar( "ui_firing_range_lane", -1 );
                setomnvar( "ui_firing_range_target_kill_count", 0 );
                setomnvar( "ui_firing_range_accuracy", 0 );
                break;
        }
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0xbf1653da, Offset: 0x13a4
// Size: 0x78
function watchdeathonmove( position )
{
    self moveto( position, 1.5, 0.25, 0.5 );
    thread audio_move_dummy();
    currenttime = gettime();
    endtime = currenttime + 1500;
    
    while ( currenttime < endtime )
    {
        currenttime = gettime();
        
        if ( self.var_f9a396aeb09d7be2 )
        {
            thread function_aaea15f4823e8b6d( position );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x27ea2900, Offset: 0x1424
// Size: 0x5e
function function_aaea15f4823e8b6d( position )
{
    self notify( #"move_dummy" );
    self endon( #"delete" );
    self endon( #"move_dummy" );
    
    while ( self.var_f9a396aeb09d7be2 )
    {
        waitframe();
    }
    
    self moveto( position, 1.5, 0.25, 0.5 );
    thread audio_move_dummy();
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x68a7d974, Offset: 0x148a
// Size: 0x2
function audio_move_dummy()
{
    
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x73a8e9b0, Offset: 0x1494
// Size: 0x2c6
function endlesslobbyfloor()
{
    wait 0.1;
    floor1 = getent( "mp_lobby_floor_01", #targetname );
    var_c7a6006099c69be4 = getentarray( "floor_01_clutter", #targetname );
    floor2 = getent( "mp_lobby_floor_02", #targetname );
    floor2clutter = getentarray( "floor_02_clutter", #targetname );
    
    foreach ( clutter in var_c7a6006099c69be4 )
    {
        clutter linkto( floor1 );
    }
    
    foreach ( clutter in floor2clutter )
    {
        clutter linkto( floor2 );
    }
    
    middleposition = floor1.origin;
    initialposition = floor2.origin;
    dist = distance( middleposition, initialposition );
    speed = 36.96;
    time = dist / speed;
    finalposition = middleposition + vectornormalize( middleposition - initialposition ) * dist;
    initial = 1;
    
    while ( true )
    {
        if ( initial )
        {
            floor2 hide();
            floor2.origin += ( 0, 0, -200 );
            waitframe();
            floor2.origin = initialposition + ( 0, 0, -200 );
            waitframe();
            floor2.origin = initialposition;
            floor2 show();
            floor2 moveto( middleposition, time );
            floor1 moveto( finalposition, time );
        }
        else
        {
            floor1 hide();
            floor1.origin += ( 0, 0, -500 );
            waitframe();
            floor1.origin = initialposition + ( 0, 0, -500 );
            waitframe();
            floor1.origin = initialposition;
            floor1 show();
            floor1 moveto( middleposition, time );
            floor2 moveto( finalposition, time );
        }
        
        initial = !initial;
        wait time;
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xf3ae7f4c, Offset: 0x1762
// Size: 0x16e
function initfiringrange()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    damagefeedback::damagefeedback_init();
    level.course_triggers = getentarray( "progression", #targetname );
    function_4e9a7827b711fa9();
    level.course_targets = gettargetarray();
    level.civilian_targets = [];
    level.enemy_targets = [];
    
    foreach ( targ in level.course_triggers )
    {
        targ thread trial_trigger_think();
    }
    
    foreach ( targ in level.course_targets )
    {
        targ thread function_2453e65d6120ef71();
    }
    
    level.var_77114a6fc636145f = level.civilian_targets.size;
    level.var_10b39d46e55794fc = level.enemy_targets.size;
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xa48ce3b8, Offset: 0x18d8
// Size: 0x370
function function_2453e65d6120ef71()
{
    self.initial_forward = anglestoforward( self.angles );
    self.initial_up = anglestoup( self.angles );
    self.initial_right = anglestoright( self.angles );
    
    if ( !isdefined( level.targets_thinking ) )
    {
        level.targets_thinking = 0;
    }
    
    level.targets_thinking++;
    self.down_angles = self.angles;
    self.parts = getentarray( self.script_linkname, #script_linkto );
    self.parts = arrayremove( self.parts, self );
    
    foreach ( part in self.parts )
    {
        switch ( part.script_noteworthy )
        {
            case #"hash_8dfa7fb0771c3cf3":
                self.plate = part;
                break;
            case #"hash_901f1f5695d0ce90":
                self.plate = part;
                self.plate_dest = part;
                break;
            case #"hash_1004c5b17e830005":
                self.arm = part;
                break;
            case #"hash_a56b5d7ebc91b688":
                self.base = part;
                break;
            case #"hash_477619b8824acced":
                self.wheels = part;
                break;
            case #"hash_8dfcbc268496a780":
                self.aim_assist = part;
                break;
            case #"hash_539c8dfe6bc5ff1f":
                self.collision = part;
                break;
            case #"hash_544160f92836c76c":
                self.collision_down = part;
                break;
            case #"hash_926f72c617dfc74d":
                self.collision_up = part;
                break;
            default:
                break;
        }
        
        part.target = "null";
        part.targetname = "null";
    }
    
    self.plate linkto( self );
    self.arm linkto( self );
    
    if ( isdefined( self.wheels ) )
    {
        self.wheels linkto( self.base );
    }
    
    if ( isdefined( self.base ) )
    {
        if ( isdefined( self.collision ) )
        {
            self.collision linkto( self.base );
        }
        
        if ( isdefined( self.collision_down ) )
        {
            self.collision_down linkto( self.base );
        }
        
        if ( isdefined( self.collision_up ) )
        {
            self.collision_up linkto( self.base );
        }
    }
    
    if ( issubstr( self.script_noteworthy, "civilian" ) )
    {
        self.is_civilian = 1;
        level.civilian_targets[ level.civilian_targets.size ] = self;
    }
    else
    {
        self.is_civilian = 0;
        level.enemy_targets[ level.enemy_targets.size ] = self;
    }
    
    thread trial_target_think();
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xa8026ab2, Offset: 0x1c50
// Size: 0xb4
function trial_target_think()
{
    self notify( #"trial_target_think" );
    self endon( #"trial_target_think" );
    self.state_up = 0;
    self.flipping = 0;
    thread trial_target_damage();
    
    if ( isdefined( self.plate_dest ) )
    {
        thread trial_target_arm_damage();
    }
    
    self.activated = 0;
    thread trial_target_requisites();
    
    if ( issubstr( self.script_noteworthy, "moving" ) )
    {
        thread trial_moving_target_think();
    }
    
    if ( isdefined( level.trial_target_think_func ) )
    {
        self [[ level.trial_target_think_func ]]();
    }
    
    if ( isdefined( level.trial_target_thread_func ) )
    {
        self thread [[ level.trial_target_thread_func ]]();
    }
    
    level.targets_thinking--;
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x347c2fcb, Offset: 0x1d0c
// Size: 0x1ce
function gettargetarray()
{
    target_types = [ "standard_target", "standard_target_180", "standard_target_civilian", "lean_target", "lean_target_civilian", "moving_target", "moving_target_civilian" ];
    target_arrays = [];
    
    for ( i = 0; i < target_types.size ; i++ )
    {
        target_arrays_structs[ i ] = utility::getstructarray( target_types[ i ], "script_noteworthy" );
        
        foreach ( struct in target_arrays_structs[ i ] )
        {
            ent = spawn( "script_origin", struct.origin );
            ent.angles = struct.angles;
            ent.script_gameobjectname = struct.script_gameobjectname;
            ent.script_linkname = struct.script_linkname;
            ent.script_noteworthy = struct.script_noteworthy;
            ent.target = struct.target;
            ent.targetname = struct.targetname;
        }
    }
    
    for ( i = 0; i < target_types.size ; i++ )
    {
        target_arrays[ i ] = getentarray( target_types[ i ], #script_noteworthy );
    }
    
    return utility::array_combine_multiple( target_arrays );
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x5cdbf4d8, Offset: 0x1ee3
// Size: 0x350
function trial_target_damage()
{
    self notify( #"trial_target_damage" );
    self endon( #"trial_target_damage" );
    fxid = undefined;
    
    if ( isdefined( self.plate_dest ) )
    {
        hit_sound = "trial_sfx_target_report_clay_smash";
        fxid = level.impact_vfx;
    }
    else
    {
        hit_sound = "trial_sfx_target_report_metal_light";
    }
    
    while ( true )
    {
        self.activated = 0;
        
        while ( self.state_up == 0 )
        {
            waitframe();
        }
        
        self.plate waittill( #"damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon );
        
        if ( self.is_civilian == 1 )
        {
            level.playerviewowner thread trial_hitmarker( self, 0, 1, 0 );
        }
        else
        {
            level.playerviewowner thread trial_hitmarker( self, 1, 0, 0 );
        }
        
        self.activated = 1;
        
        if ( type == "MOD_MELEE" )
        {
            level.playerviewowner notify( #"fake_weapon_fired" );
        }
        
        if ( self.is_civilian )
        {
            level.var_77114a6fc636145f--;
        }
        else
        {
            level.var_10b39d46e55794fc--;
            
            if ( level.var_10b39d46e55794fc == 0 )
            {
                foreach ( door in level.var_f73078b8ad14f6b4 )
                {
                    door scriptabledoorfreeze( 0 );
                    door scriptabledooropen( "away", level.var_fe88e599446821bf.origin );
                }
            }
        }
        
        if ( self.is_civilian && isdefined( level.trial_target_civilian_killed_func ) )
        {
            self [[ level.trial_target_civilian_killed_func ]]();
        }
        else if ( isdefined( level.trial_target_enemy_killed_func ) )
        {
            self [[ level.trial_target_enemy_killed_func ]]();
        }
        
        if ( isdefined( level.trial_target_headshot_func ) && self.plate tagexists( "tag_head" ) && distance( self.plate gettagorigin( "tag_head" ), point ) <= 5 )
        {
            self [[ level.trial_target_headshot_func ]]();
        }
        
        if ( isdefined( fxid ) )
        {
            playfx( fxid, point );
        }
        
        if ( isdefined( self.plate_dest ) )
        {
            self.plate_dest hide();
            wait randomfloatrange( 0.7, 1 );
        }
        
        thread trial_target_flip( "down" );
        level waittill( #"course_ended" );
        
        if ( isdefined( self.plate_dest ) )
        {
            while ( true )
            {
                level.playerviewowner waittill( #"luinotifyserver", msg );
                
                if ( msg == "trial_retry" )
                {
                    return;
                }
            }
            
            self.plate_dest show();
        }
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x5f0d8847, Offset: 0x223b
// Size: 0x28a
function trial_target_flip( up_or_down )
{
    if ( up_or_down == "up" )
    {
        if ( isdefined( self.script_delay ) )
        {
            wait self.script_delay;
        }
        
        self.plate setcandamage( 1 );
        
        if ( isdefined( self.aim_assist ) )
        {
            self.aim_assist enableaimassist();
        }
        
        if ( isdefined( self.collision_up ) )
        {
            self.collision_up solid();
        }
        
        if ( isdefined( self.collision_down ) )
        {
            self.collision_up notsolid();
        }
        
        if ( self.state_up == 1 )
        {
            return;
        }
        
        self.state_up = 1;
        sign = 1;
    }
    else
    {
        self.plate setcandamage( 0 );
        
        if ( isdefined( self.aim_assist ) )
        {
            self.aim_assist disableaimassist();
        }
        
        if ( isdefined( self.collision_up ) )
        {
            self.collision_up notsolid();
        }
        
        if ( isdefined( self.collision_down ) )
        {
            self.collision_up solid();
        }
        
        if ( self.state_up == 0 )
        {
            return;
        }
        
        self.state_up = 0;
        sign = -1;
    }
    
    time = undefined;
    ang = undefined;
    
    switch ( self.script_noteworthy )
    {
        case #"hash_4fa135c280bf8bb8":
        case #"hash_61bfeecb3a35db71":
        case #"hash_90cb0f2603954833":
        case #"hash_9fa4d55df09d03e8":
            ang = 90;
            time = 0.2;
            break;
        case #"hash_2b3b8b1ea205bfb5":
        case #"hash_f3fe62d2a49b4707":
            ang = 30;
            time = 0.15;
            break;
        case #"hash_fce9709bf4fdbff4":
            ang = 180;
            time = 0.4;
            break;
        default:
            ang = 90;
            time = 0.2;
            break;
    }
    
    self.flipping = 1;
    
    if ( issubstr( self.script_noteworthy, "moving" ) )
    {
        waitframe();
    }
    
    if ( up_or_down == "up" )
    {
    }
    
    if ( self.initial_right[ 2 ] != 0 )
    {
        self rotateyaw( -1 * self.initial_right[ 2 ] * ang * sign, time );
    }
    else
    {
        self rotatepitch( ang * sign, time );
    }
    
    wait time;
    
    if ( up_or_down == "down" )
    {
        waitframe();
        self.angles = self.down_angles;
    }
    
    self.flipping = 0;
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xb2a35555, Offset: 0x24cd
// Size: 0x2c9
function trial_moving_target_think()
{
    self notify( #"trial_moving_target_think" );
    self endon( #"trial_moving_target_think" );
    
    if ( !isdefined( self.mover ) )
    {
        self.mover = function_47c86977a18df38b( level.course_movers, self.origin, 32 );
    }
    
    if ( !isdefined( self.mover ) )
    {
        assertmsg( "<dev string:x4e>" + self.targetname + "<dev string:x5d>" + self.origin + "<dev string:x62>" );
        return;
    }
    
    if ( !isdefined( self.mover_ends ) )
    {
        self.mover_ends = utility::getstructarray( self.mover.targetname, "target" );
        self.mover_ends = sortbydistance( self.mover_ends, self.mover.origin );
        mover_delta = self.mover.origin - self.origin;
        self.mover.origin += mover_delta;
        self.mover_ends[ 0 ].origin += mover_delta;
        self.mover_ends[ 1 ].origin += mover_delta;
    }
    
    self.moveforward = 1;
    self.moving = 0;
    
    if ( isdefined( self.script_speed ) )
    {
        self.move_speed = self.script_speed;
    }
    else
    {
        self.move_speed = 32;
    }
    
    level waittill( #"player_spawned" );
    thread trial_moving_target_reset();
    
    while ( true )
    {
        if ( self.moving && ( 90 > distance( level.playerviewowner.origin, self.origin ) || !self.state_up ) )
        {
            self notify( #"stop_moving" );
            self.moving = 0;
            self.dummy delete();
            self.dummy thread utility::stop_loop_sound_on_entity( "trial_sfx_target_move_loop" );
        }
        else if ( self.flipping == 0 && self.moving == 0 && 90 < distance( level.playerviewowner.origin, self.origin ) && self.state_up == 1 )
        {
            thread trial_moving_target_mover();
        }
        
        waitframe();
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x9e8f36fd, Offset: 0x279e
// Size: 0x109
function trial_moving_target_mover()
{
    self endon( #"stop_moving" );
    self.moving = 1;
    self.dummy = spawn( "script_origin", self.origin );
    childthread trial_target_follow_dummy();
    self.dummy thread utility::play_loop_sound_on_entity( "trial_sfx_target_move_loop" );
    
    while ( true )
    {
        next_end = self.mover_ends[ self.moveforward ];
        dist = distance( self.dummy.origin, next_end.origin );
        time = dist / self.move_speed;
        accel = 0.5;
        accel = clamp( accel, 0, time / 2 );
        self.dummy moveto( next_end.origin, time, accel, accel );
        wait time;
        self.moveforward = !self.moveforward;
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xfed36075, Offset: 0x28af
// Size: 0x66
function trial_moving_target_reset()
{
    while ( true )
    {
        level waittill( #"trial_results_screen_opened" );
        waitframe();
        self.origin = self.mover.origin;
        self.base.origin = self.mover.origin;
        self.moveforward = 1;
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x4058ef35, Offset: 0x291d
// Size: 0x4e
function trial_target_follow_dummy()
{
    while ( true )
    {
        self.origin = self.dummy.origin;
        self.base.origin = self.dummy.origin;
        waitframe();
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x2cdeceaf, Offset: 0x2973
// Size: 0x100
function trial_target_arm_damage()
{
    self notify( #"trial_target_arm_damage" );
    self endon( #"trial_target_arm_damage" );
    self.arm setcandamage( 1 );
    
    while ( true )
    {
        self.arm waittill( #"damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon );
        
        if ( type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" && self.state_up )
        {
            self.plate dodamage( 1, self.plate.origin );
        }
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xedf1abc0, Offset: 0x2a7b
// Size: 0x100
function trial_target_requisites()
{
    self notify( #"trial_target_requisites" );
    self endon( #"trial_target_requisites" );
    waitframe();
    
    if ( isdefined( self.targetname ) )
    {
        requisites = getentarray( self.targetname, #target );
    }
    else
    {
        requisites = [];
    }
    
    while ( true )
    {
        all_requisites = 1;
        
        foreach ( requisite in requisites )
        {
            if ( requisite.activated == 0 )
            {
                all_requisites = 0;
            }
        }
        
        if ( all_requisites == 1 )
        {
            trial_target_flip( "up" );
            level waittill( #"course_ended" );
        }
        
        waitframe();
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xfd23d75, Offset: 0x2b83
// Size: 0x130
function trial_trigger_think()
{
    self notify( #"trial_trigger_think" );
    self endon( #"trial_trigger_think" );
    checkpoints = getentarray( "end_checkpoint", #script_noteworthy );
    
    while ( true )
    {
        self.activated = 0;
        
        while ( !isdefined( level.playerviewowner ) )
        {
            waitframe();
        }
        
        if ( isdefined( self.script_noteworthy ) )
        {
            if ( self.script_noteworthy != "start" )
            {
                level waittill( #"course_started" );
            }
        }
        else
        {
            level waittill( #"course_started" );
        }
        
        while ( level.playerviewowner istouching( self ) )
        {
            waitframe();
        }
        
        if ( self.script_noteworthy == "end" )
        {
            while ( true )
            {
                self waittill( #"trigger" );
                
                if ( all_end_checkpoints_activated( checkpoints ) )
                {
                    break;
                }
            }
        }
        else
        {
            self waittill( #"trigger" );
        }
        
        self.activated = 1;
        level notify( #"trigger_activated" );
        
        if ( isdefined( level.trial_trigger_activated_func ) )
        {
            self [[ level.trial_trigger_activated_func ]]();
        }
        
        level waittill( #"course_ended" );
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0xbc97a4da, Offset: 0x2cbb
// Size: 0x88, Type: bool
function all_end_checkpoints_activated( checkpoints )
{
    foreach ( checkpoint in checkpoints )
    {
        if ( !checkpoint.activated )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mp_frontend_sat_01
// Params 4
// Checksum 0xd1972dee, Offset: 0x2d4c
// Size: 0x69
function trial_hitmarker( var_d09ca95a87894237, isdeath = 0, iscivilian = 0, isbody = 0 )
{
    alias = getdvar( @"snd_hitmarker_alias" );
    trial_updatehitmarker( "standard", isdeath, 0, iscivilian );
}

// Namespace mp_frontend_sat_01
// Params 5
// Checksum 0x50cfc3db, Offset: 0x2dbd
// Size: 0x14d
function trial_updatehitmarker( markertype, killingblow, headshot, nonplayer, icontype )
{
    if ( !isdefined( markertype ) )
    {
        return;
    }
    
    if ( !isdefined( killingblow ) )
    {
        killingblow = 0;
    }
    
    if ( !isdefined( headshot ) )
    {
        headshot = 0;
    }
    
    if ( !isdefined( nonplayer ) )
    {
        nonplayer = 0;
    }
    
    priority = trial_gethitmarkerpriority( markertype );
    
    if ( self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow )
    {
        return;
    }
    
    self.lasthitmarkertime = gettime();
    self.lasthitmarkerpriority = priority;
    
    if ( isdefined( icontype ) && !killingblow )
    {
        self setclientomnvar( "damage_feedback_icon", icontype );
        self setclientomnvar( "damage_feedback_icon_notify", gettime() );
    }
    
    self setclientomnvar( "damage_feedback", markertype );
    self setclientomnvar( "damage_feedback_notify", gettime() );
    
    if ( killingblow )
    {
        self setclientomnvar( "damage_feedback_kill", 1 );
    }
    else
    {
        self setclientomnvar( "damage_feedback_kill", 0 );
    }
    
    if ( headshot )
    {
        self setclientomnvar( "damage_feedback_headshot", 1 );
    }
    else
    {
        self setclientomnvar( "damage_feedback_headshot", 0 );
    }
    
    if ( nonplayer )
    {
        self setclientomnvar( "damage_feedback_nonplayer", 1 );
        return;
    }
    
    self setclientomnvar( "damage_feedback_nonplayer", 0 );
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x3d911d12, Offset: 0x2f12
// Size: 0x2b
function trial_gethitmarkerpriority( hitmarkertype )
{
    if ( !isdefined( level.hitmarkerpriorities[ hitmarkertype ] ) )
    {
        return 0;
    }
    
    return level.hitmarkerpriorities[ hitmarkertype ];
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x557c703d, Offset: 0x2f46
// Size: 0x1e0
function resettargets()
{
    while ( true )
    {
        waitframe();
        
        if ( getdvarint( @"reset_firing_range_targets", 0 ) != 0 )
        {
            /#
                setdevdvar( @"reset_firing_range_targets", 0 );
            #/
            
            foreach ( targ in level.course_triggers )
            {
                targ thread trial_trigger_think();
            }
            
            foreach ( targ in level.course_targets )
            {
                targ trial_target_flip( "down" );
                targ thread trial_target_think();
            }
            
            level thread function_932a7ff49d584d2c();
        }
        
        if ( getdvarint( @"door_test", 0 ) != 0 )
        {
            /#
                setdevdvar( @"door_test", 0 );
            #/
            
            foreach ( door in level.var_965747965992ff2d )
            {
                door scriptabledooropen( "away", level.var_b4491010f040dc0a.origin );
            }
        }
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xeee5c7d3, Offset: 0x312e
// Size: 0x12a
function function_4e9a7827b711fa9()
{
    level.var_b4491010f040dc0a = undefined;
    level.var_fe88e599446821bf = undefined;
    level.var_965747965992ff2d = [];
    level.var_f73078b8ad14f6b4 = [];
    
    foreach ( trigger in level.course_triggers )
    {
        if ( isdefined( trigger.script_noteworthy ) )
        {
            if ( trigger.script_noteworthy == "start" )
            {
                level.var_b4491010f040dc0a = trigger;
                level.var_965747965992ff2d = scriptable_door_utility::scriptable_door_get_in_radius( trigger.origin, 512, 1000 );
                continue;
            }
            
            if ( trigger.script_noteworthy == "end" )
            {
                level.var_fe88e599446821bf = trigger;
                level.var_f73078b8ad14f6b4 = scriptable_door_utility::scriptable_door_get_in_radius( trigger.origin, 512, 1000 );
            }
        }
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xca637421, Offset: 0x3260
// Size: 0x23d
function function_932a7ff49d584d2c()
{
    while ( !( isdefined( level.var_b4491010f040dc0a ) && isdefined( level.var_fe88e599446821bf ) ) )
    {
        waitframe();
    }
    
    level.var_b4491010f040dc0a notify( #"hash_40dc7e4e224c8a45" );
    level.var_b4491010f040dc0a endon( #"hash_40dc7e4e224c8a45" );
    
    foreach ( door in level.var_965747965992ff2d )
    {
        door scriptabledoorclose();
    }
    
    foreach ( door in level.var_f73078b8ad14f6b4 )
    {
        door scriptabledoorclose();
        door scriptabledoorfreeze( 1 );
    }
    
    level.var_b4491010f040dc0a waittill( #"trigger" );
    
    foreach ( door in level.var_965747965992ff2d )
    {
        door scriptabledooropen( "away", level.var_b4491010f040dc0a.origin );
    }
    
    level.var_2e4782d99dcefb0e = 1;
    level notify( #"course_started" );
    starttime = gettime();
    level.var_fe88e599446821bf waittill( #"trigger" );
    elapsedtime = ( gettime() - starttime ) / 1000;
    level.playerviewowner iprintlnbold( "MOUT Course Time: " + elapsedtime );
    level thread function_932a7ff49d584d2c();
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x1e4a5d5d, Offset: 0x34a5
// Size: 0x71
function get_active_scene_event()
{
    eventindex = getdvarint( @"hash_48c8a8c5fff5399e", 0 );
    
    if ( eventindex < 0 || eventindex >= level.gamemodebundle.var_82fb7b309317c3df.size )
    {
        eventindex = 0;
    }
    
    eventref = level.gamemodebundle.var_82fb7b309317c3df[ eventindex ].sceneevent;
    return getscriptbundle( eventref );
}

// Namespace mp_frontend_sat_01
// Params 3, eflags: 0x4
// Checksum 0xfa0216d5, Offset: 0x351f
// Size: 0x71
function private function_68a78f11141fd72d( value, key, hashkey )
{
    var_470df391b181b379 = utility::getent_or_struct_array( value, key );
    scriptables = getscriptablearray( value, hashkey );
    entitylessscriptables = getentitylessscriptablearray( value, hashkey );
    ents = arraycombine( var_470df391b181b379, scriptables );
    ents = arraycombine( ents, entitylessscriptables );
    return ents;
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x7e9c898e, Offset: 0x3599
// Size: 0x13a
function function_7141bfed6e6f14d( var_74c07f3917910d5f )
{
    var_6a62c7e17667d741 = [];
    
    foreach ( entdata in var_74c07f3917910d5f )
    {
        matchedents = [];
        
        if ( isdefined( entdata.script_noteworthy ) )
        {
            var_b0d0fcc2c2db9c81 = function_68a78f11141fd72d( entdata.script_noteworthy, "script_noteworthy", #script_noteworthy );
            matchedents = var_b0d0fcc2c2db9c81;
        }
        
        if ( isdefined( entdata.targetname ) )
        {
            var_137e82619514f6cf = function_68a78f11141fd72d( entdata.targetname, "targetname", #targetname );
            matchedents = var_137e82619514f6cf;
        }
        
        if ( isdefined( entdata.script_noteworthy ) && isdefined( entdata.targetname ) )
        {
            matchedents = arrayintersection( var_b0d0fcc2c2db9c81, var_137e82619514f6cf );
        }
        
        var_6a62c7e17667d741 = arraycombine( var_6a62c7e17667d741, matchedents );
    }
    
    return arrayremoveduplicates( var_6a62c7e17667d741 );
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x924de938, Offset: 0x36dc
// Size: 0x4a
function init_scene_event()
{
    eventdata = get_active_scene_event();
    thread function_6dd55fc749951e9f( eventdata );
    thread function_2ec1316bb3f8cf28( eventdata );
    thread function_29550329f57d0865( eventdata );
    thread function_3888b93733bca4c4( eventdata );
    thread function_ec367e99b2aa671f( eventdata );
    thread function_1a3b2b438d1e2172( eventdata );
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0xfc6769a7, Offset: 0x372e
// Size: 0x5c
function function_6dd55fc749951e9f( eventdata )
{
    entshide = function_7141bfed6e6f14d( eventdata.entshide );
    utility::array_call( entshide, &hide );
    entsshow = function_7141bfed6e6f14d( eventdata.entsshow );
    utility::array_call( entsshow, &show );
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x6f057dc8, Offset: 0x3792
// Size: 0x24a
function function_2ec1316bb3f8cf28( eventdata )
{
    lightsdisable = function_7141bfed6e6f14d( eventdata.lightsdisable );
    
    foreach ( light in lightsdisable )
    {
        light setlightintensity( 0 );
    }
    
    foreach ( worldeventdata in eventdata.var_6861818090fc1332 )
    {
        activateworldevent( worldeventdata.worldevent );
    }
    
    foreach ( tintentry in eventdata.lightstinted )
    {
        var_4e38229c2800ca7f = function_7141bfed6e6f14d( tintentry.lights );
        colorarr = strtok( tintentry.color, " " );
        color = ( float( colorarr[ 0 ] ), float( colorarr[ 1 ] ), float( colorarr[ 2 ] ) );
        
        foreach ( light in var_4e38229c2800ca7f )
        {
            light setlightcolor( color );
        }
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0xfd617367, Offset: 0x39e4
// Size: 0xdb
function function_29550329f57d0865( eventdata )
{
    wait 1;
    var_e807c08d2bdf5775 = eventdata.var_e807c08d2bdf5775;
    
    foreach ( soundcontext in var_e807c08d2bdf5775 )
    {
        if ( !isdefined( soundcontext.type ) || !isdefined( soundcontext.value ) )
        {
            continue;
        }
        
        setglobalsoundcontext( soundcontext.type, soundcontext.value, soundcontext.fadetime ?? 0 );
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x98045f1b, Offset: 0x3ac7
// Size: 0x3a
function function_3888b93733bca4c4( eventdata )
{
    if ( eventdata.cinematicvarianttag )
    {
        level.var_c4bbacdf528aed25[ level.var_c4bbacdf528aed25.size ] = eventdata.cinematicvarianttag;
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x2fcaae1e, Offset: 0x3b09
// Size: 0x113
function function_ec367e99b2aa671f( eventdata )
{
    foreach ( scenestruct in level.var_d729b514dcdf4af9 )
    {
        scenestruct scene::stop();
    }
    
    var_ac0f21d86156f106 = function_7141bfed6e6f14d( eventdata.extrascenes );
    
    foreach ( scenestruct in var_ac0f21d86156f106 )
    {
        scenestruct thread scene::play();
    }
    
    level.var_d729b514dcdf4af9 = var_ac0f21d86156f106;
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0xd90c0b87, Offset: 0x3c24
// Size: 0xb0
function function_bb88b50afbc84aee()
{
    wait 1;
    function_d93bd776c1a3338c();
    
    if ( getdvarint( @"hash_2dbdfbbd226d1f0e", 0 ) == 1 )
    {
        level.var_c4bbacdf528aed25[ level.var_c4bbacdf528aed25.size ] = "leagueplay";
    }
    
    foreach ( tag in level.var_c4bbacdf528aed25 )
    {
        waitframe();
        function_1e14e3fe82ea2c1( tag );
    }
}

// Namespace mp_frontend_sat_01
// Params 0
// Checksum 0x3bf6a118, Offset: 0x3cdc
// Size: 0xf7
function function_6b01b7194835927c()
{
    var_674f588b92adc311 = [];
    var_147c7f3abfebccba = getscriptbundlenames( #"hash_132e40fafb109419" );
    
    foreach ( var_50d2db80d7d9ce81 in var_147c7f3abfebccba )
    {
        var_c76a1c6ac35a94ca = getscriptbundle( var_50d2db80d7d9ce81 );
        
        if ( !isdefined( var_c76a1c6ac35a94ca ) || !isdefined( var_c76a1c6ac35a94ca.hwconfig ) || arraycontains( var_674f588b92adc311, var_c76a1c6ac35a94ca.hwconfig ) )
        {
            continue;
        }
        
        level.playerviewowner function_72cf2eee8e035013( var_c76a1c6ac35a94ca.hwconfig );
        var_674f588b92adc311[ var_674f588b92adc311.size ] = var_c76a1c6ac35a94ca.hwconfig;
    }
}

// Namespace mp_frontend_sat_01
// Params 1
// Checksum 0x5543066c, Offset: 0x3ddb
// Size: 0x59
function function_1a3b2b438d1e2172( eventdata )
{
    function_6b01b7194835927c();
    level.var_ac3aac16c62db911 = undefined;
    
    if ( isdefined( eventdata.hwconfig ) )
    {
        level.playerviewowner function_a565dafac620d68e( eventdata.hwconfig );
        level.var_ac3aac16c62db911 = eventdata.hwconfig;
    }
}

