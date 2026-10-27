// script_50ee493a72a5e95b  (hash_50ee493a72a5e95b.gscc) (size: 13657 Bytes / 0x3559 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x899292f9 (2308084473)
// size ...... 13657 (0x3559)
// includes .. 11  (offset: 0x3105)
// strings ... 69  (offset: 0x315d)
// dev strs .. 0   (offset: 0x3559)
// exports ... 20  (offset: 0x1f31)
// cseg ...... 0x5cb + 0x1966 (0x1f31)
// imports ... 126 (offset: 0x2251)
// animtree1 . 0   (offset: 0x3559)
// animtree2 . 0   (offset: 0x3559)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\scripted_widgets;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_item;

#namespace ob_story_mission_machete_attack;

// Namespace ob_story_mission_machete_attack
// Params 0, eflags: 0x1
// Checksum 0x7eafd82a, Offset: 0x5e9
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "machete_attack" ), &init );
}

// Namespace ob_story_mission_machete_attack
// Params 0
// Checksum 0xf78f0a29, Offset: 0x608
// Size: 0xc7
function init()
{
    level callback::add( #"combat_cleanup", &function_9b479dd2a24486e1 );
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "machete_attack", &function_72c4355e8915e1cc );
    val::group_register( "machete_attack_val_group", [ "damage", "usability", "killstreaks", "supers", "gesture", "fire", "ads", "weapon_switch", "allow_movement", "offhand_weapons", "allow_jump", "crouch", "prone", "mantle" ] );
    utility::flag_set( "machete_attack_initialized" );
    initparams();
}

// Namespace ob_story_mission_machete_attack
// Params 0
// Checksum 0x6e801151, Offset: 0x6d7
// Size: 0xd
function is_running_machete_attack()
{
    return utility::ent_flag( "machete_attack_active" );
}

// Namespace ob_story_mission_machete_attack
// Params 0, eflags: 0x4
// Checksum 0xe2bdc57b, Offset: 0x6ed
// Size: 0xb3
function private initparams()
{
    level.machetesettings = {};
    level.machetesettings.bundle = level.streakglobals.streakbundles[ "machete_attack" ];
    level.machetesettings.streakname = "machete_attack";
    level.machetesettings.projectileweapon = level.machetesettings.bundle.projectileweapon ?? "sat_ks_machete_attack_proj";
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "machete_attack", level.machetesettings.projectileweapon, #"large" );
}

// Namespace ob_story_mission_machete_attack
// Params 4
// Checksum 0xda3d6c5, Offset: 0x7a8
// Size: 0x157
function function_bfee43bcb0dcc192( targetscriptable, playburrow, var_77141bae8b4a69f8, streakinfo )
{
    if ( !isdefined( targetscriptable ) )
    {
        machetetargets = getentitylessscriptablearray( "machete_target", #targetname );
        
        if ( !isdefined( level.var_532224678cfbea65 ) )
        {
            level.var_532224678cfbea65 = utility::create_deck( level.players, 1, 1 );
        }
        
        player = level.var_532224678cfbea65 utility::deck_draw();
        mindist = 3000;
        
        foreach ( machetetarget in machetetargets )
        {
            disttoplayer = distance( machetetarget.origin, player.origin );
            
            if ( disttoplayer <= mindist && !machetetarget.isused )
            {
                targetscriptable = machetetarget;
                mindist = disttoplayer;
            }
        }
    }
    
    if ( isdefined( targetscriptable ) )
    {
        thread function_d06f8289eebe70ae( targetscriptable, playburrow, var_77141bae8b4a69f8, streakinfo );
    }
}

// Namespace ob_story_mission_machete_attack
// Params 4, eflags: 0x4
// Checksum 0xa8afe7df, Offset: 0x907
// Size: 0x1d1
function private function_d06f8289eebe70ae( targetscriptable, playburrow, var_77141bae8b4a69f8, streakinfo )
{
    level endon( #"game_ended", #"machete_combat_cleanup" );
    
    if ( streakinfo )
    {
        streakinfo.owner endon( #"death_or_disconnect", #"killstreak_cancel" );
    }
    
    targetscriptable.isused = 1;
    marker = spawn( "script_model", targetscriptable.origin );
    marker setmodel( "sat_ob_machete_attack_marker" );
    marker thread machete_attack_handlemarkerscriptable( streakinfo );
    
    if ( !streakinfo )
    {
        wait 1;
    }
    
    machete = spawn( "script_model", targetscriptable.origin );
    machete setmodel( "sat_leo_vista_edge_machete_large_36_anim" );
    machete.angles = targetscriptable.angles;
    machete.targetscriptable = targetscriptable;
    machete.weapon_name = level.machetesettings.projectileweapon;
    
    if ( ob::nightmare() )
    {
        machete notsolid();
    }
    
    if ( streakinfo )
    {
        streakinfo.machete = machete;
        streakinfo.owner cameraunlink();
        machete.targetscriptable thread scene::play( [ streakinfo.owner, machete ], "impact_vertical", "scene_sat_cin_leo_machete_vertical" );
        machete childthread function_162074a9f320b0f8( streakinfo );
    }
    else
    {
        machete.targetscriptable thread scene::play( [ machete ], "impact", "scene_sat_cin_leo_machete" );
    }
    
    machete thread function_ced45d6d73ca168b();
    machete childthread function_91932f2b64ff0e28( targetscriptable, streakinfo );
    machete childthread function_e60472ab1713dc8d( playburrow, var_77141bae8b4a69f8, streakinfo );
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0x5fe5b16b, Offset: 0xae0
// Size: 0x63
function private machete_attack_handlemarkerscriptable( streakinfo )
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "target", "on", 0 );
    
    if ( streakinfo )
    {
        streakinfo.owner namespace_9d8e359c3b1041e5::waittill_notify_or_timeout_hostmigration_pause( "killstreak_cancel", 4 );
    }
    else
    {
        level namespace_9d8e359c3b1041e5::waittill_notify_or_timeout_hostmigration_pause( "machete_combat_cleanup", 4 );
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace ob_story_mission_machete_attack
// Params 2, eflags: 0x4
// Checksum 0x2f99e2d6, Offset: 0xb4b
// Size: 0x380
function private function_91932f2b64ff0e28( targetscriptable, streakinfo )
{
    owner = streakinfo.owner ?? self;
    self waittill( #"machete_impact" );
    
    if ( streakinfo && streakinfo.owner && streakinfo.owner getactivexcam() )
    {
        streakinfo.owner playrumbleonpositionforclient( "machete_impact_rumble", streakinfo.owner getxcamposition() );
    }
    
    self radiusdamage( targetscriptable.origin, 350, 100, 10, owner, "MOD_EXPLOSIVE", level.machetesettings.projectileweapon, undefined, 0 );
    targetscriptable setscriptablepartstate( "impact", "show" );
    
    /#
        if ( getdvarint( @"hash_2b596d9a5a12e905", 0 ) )
        {
            sphere( targetscriptable.origin, 350, ( 1, 1, 0 ), 1, 200 );
        }
    #/
    
    waitframe();
    
    foreach ( enemy in getaiarrayinradius( targetscriptable.origin, 350, "team_hundred_ninety" ) )
    {
        if ( enemy && isalive( enemy ) && !enemy.var_2db3f872d9884a53 )
        {
            enemy dodamage( 15000, targetscriptable.origin, owner, self, "MOD_EXPLOSIVE", level.machetesettings.projectileweapon );
        }
    }
    
    foreach ( vehicle in vehicle_getarrayinradius( targetscriptable.origin, 350 ) )
    {
        if ( isalive( vehicle ) )
        {
            vehicle dodamage( vehicle.maxhealth, targetscriptable.origin, owner, self, "MOD_EXPLOSIVE", level.machetesettings.projectileweapon );
        }
    }
    
    foreach ( player in function_d63fe6a4c08ba6f5( targetscriptable.origin, 100, 400 ) )
    {
        player dodamage( 500, targetscriptable.origin, self, self, "MOD_UNKNOWN", level.machetesettings.projectileweapon );
    }
    
    /#
        if ( getdvarint( @"hash_2b596d9a5a12e905", 0 ) )
        {
            cylinder( targetscriptable.origin, targetscriptable.origin + ( 0, 0, 400 ), 100, ( 1, 0, 0 ), 0, 200 );
        }
    #/
}

// Namespace ob_story_mission_machete_attack
// Params 3, eflags: 0x4
// Checksum 0x93416ab4, Offset: 0xed3
// Size: 0x422
function private function_e60472ab1713dc8d( playburrow, var_77141bae8b4a69f8, streakinfo )
{
    self waittill( #"machete_impact_end" );
    
    if ( streakinfo )
    {
        streakinfo.owner notify( #"machete_impact_end" );
        self.targetscriptable setscriptablepartstate( "burrow", "show", 0 );
        self.targetscriptable childthread scene::play( [ self ], "burrow_vertical", "scene_sat_cin_leo_machete_vertical" );
        wait 2.5;
        self.targetscriptable freescriptable();
        self delete();
        return;
    }
    else if ( playburrow )
    {
        self.targetscriptable setscriptablepartstate( "burrow", "show", 0 );
        self.targetscriptable childthread scene::play( [ self ], "burrow", "scene_sat_cin_leo_machete" );
        wait 2.5;
        
        if ( var_77141bae8b4a69f8 )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
            var_261d5c07fcbeedd7 = common_item::function_325e28c0fb65c36a( "machete_attack", 1, spawnoptions );
        }
        
        self.targetscriptable setscriptablepartstate( "impact", "hide" );
        self delete();
        return;
    }
    
    macheteangles = self gettagangles( "j_machete_blade_1" );
    forwardvec = anglestoforward( macheteangles );
    leftvec = anglestoleft( macheteangles );
    rightvec = anglestoright( macheteangles );
    upvec = anglestoup( macheteangles );
    machetecenter = self gettagorigin( "j_machete_blade_1" ) + forwardvec * 10;
    obstacle = createnavobstaclebybounds( machetecenter, ( 55, 5, 200 ), macheteangles );
    self.colmodel = spawn( "script_model", self.origin );
    self.colmodel setmodel( "sat_leo_vista_edge_machete_large_36" );
    self.colmodel.angles = macheteangles;
    self.colmodel dontinterpolate();
    self hide();
    frontcenter = machetecenter + forwardvec * 10 + upvec * 50;
    backcenter = machetecenter - forwardvec * 50 + upvec * 50;
    frontleft = getgroundposition( frontcenter + leftvec * 35, 5 ) + upvec * 50;
    frontright = getgroundposition( frontcenter + rightvec * 35, 5 ) + upvec * 50;
    backleft = getgroundposition( backcenter + leftvec * 35, 5 ) + upvec * 50;
    backright = getgroundposition( backcenter + rightvec * 35, 5 ) + upvec * 50;
    flatangles = ( 0, macheteangles[ 1 ], 0 );
    self.var_af16e11eb85a2512 = [];
    self.var_af16e11eb85a2512[ "front_left" ] = spawncovernode( frontleft, flatangles + ( 0, -90, 0 ), "Cover Left" );
    self.var_af16e11eb85a2512[ "front_right" ] = spawncovernode( frontright, flatangles + ( 0, 90, 0 ), "Cover Right" );
    self.var_af16e11eb85a2512[ "back_left" ] = spawncovernode( backleft, flatangles + ( 0, -90, 0 ), "Cover Right" );
    self.var_af16e11eb85a2512[ "back_right" ] = spawncovernode( backright, flatangles + ( 0, 90, 0 ), "Cover Left" );
    utility::flag_wait( "machete_covernode_cleanup" );
    destroynavobstacle( obstacle );
    
    foreach ( node in self.var_af16e11eb85a2512 )
    {
        despawncovernode( node );
    }
    
    self.var_af16e11eb85a2512 = undefined;
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0x90282688, Offset: 0x12fd
// Size: 0x18
function private function_9b479dd2a24486e1( params )
{
    level notify( #"machete_combat_cleanup" );
}

// Namespace ob_story_mission_machete_attack
// Params 0, eflags: 0x4
// Checksum 0x26f119c1, Offset: 0x131d
// Size: 0xa9
function private function_ced45d6d73ca168b()
{
    level endon( #"game_ended" );
    self endon( #"machete_impact_end" );
    utility::waittill_any_ents( level, "machete_combat_cleanup", self, "machete_combat_cleanup" );
    
    if ( !self )
    {
        return;
    }
    
    if ( self.targetscriptable scene::get_state() == "Playing" )
    {
        self.targetscriptable scene::stop();
    }
    
    if ( self.targetscriptable )
    {
        self.targetscriptable setscriptablepartstate( "impact", "hide" );
        
        if ( self.targetscriptable.isdynamic )
        {
            self.targetscriptable freescriptable();
        }
    }
    
    self delete();
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0xd4a87d69, Offset: 0x13ce
// Size: 0x256
function private function_72c4355e8915e1cc( streakinfo )
{
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    
    if ( level.killstreaktriggeredfunc && !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
    {
        streakinfo notify( #"killstreak_failed_use" );
        return;
    }
    
    weaponnone = makeweapon( "none" );
    
    if ( !killstreakdeploy::candeploykillstreak( streakinfo, weaponnone ) )
    {
        streakinfo notify( #"killstreak_failed_use" );
        return;
    }
    
    player = streakinfo.owner;
    player endon( #"death_or_disconnect" );
    startpoints = sortbydistance( utility::function_b7f3d374aa10aa51( "machete_killstreak", "targetname", player.origin, 2000 ), player.origin );
    
    if ( startpoints.size == 0 )
    {
        streakinfo notify( #"killstreak_failed_use" );
        return;
    }
    
    startpoint = startpoints[ 0 ];
    streakinfo.forwarddir = vectornormalize2( anglestoforward( startpoint.angles ) );
    streakinfo.rightdir = vectornormalize2( anglestoright( startpoint.angles ) );
    streakinfo.centerpos = utility::getstruct( startpoint.target, "targetname" ).origin;
    streakinfo.cament = utility::function_1808878d1c511ce8( startpoint.origin, startpoint.angles );
    streakinfo.playermarker = utility::spawn_tag_origin( streakinfo.centerpos, ( 0, 0, 0 ) );
    streakinfo.playermarker dontinterpolate();
    streakinfo.playermarker showtoplayer( player );
    player disablephysicaldepthoffieldscripting();
    
    if ( level.killstreakbeginusefunc && !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return;
    }
    
    player childthread player_watchgameend( streakinfo );
    player childthread function_efb0137780f19874( streakinfo );
    player childthread function_a4cec6e15d081e95( streakinfo );
    player childthread function_17e633a38810fe2e( streakinfo );
    result = streakinfo utility::waittill_any_return( "machete_attack_succeeded", "machete_attack_cancelled" );
    
    if ( result == "machete_attack_succeeded" )
    {
        return 1;
    }
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0x337b8d5e, Offset: 0x162c
// Size: 0x44
function private player_watchgameend( streakinfo )
{
    self endon( #"killstreak_cancel" );
    streakinfo endon( #"machete_attack_cancelled" );
    level waittill( #"game_ended" );
    self.owner namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0x4a669358, Offset: 0x1678
// Size: 0x3e
function private function_efb0137780f19874( streakinfo )
{
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    self waittill( #"killstreak_cancel" );
    streakinfo notify( #"machete_attack_cancelled" );
    thread function_e0a806397a61ac7( streakinfo, 1 );
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0xa750613f, Offset: 0x16be
// Size: 0xf7
function private function_a4cec6e15d081e95( streakinfo )
{
    self endon( #"killstreak_cancel" );
    self notify( #"player_enter_machete_attack" );
    utility::ent_flag_set( "machete_attack_active" );
    self startcameratween( 0.35 );
    self cameralinkto( streakinfo.cament, "tag_origin", 0, 1 );
    val::group_set( "machete_attack_val_group", 0 );
    val::set( "machete_attack", "ignoreme", 1 );
    val::set( "machete_attack_val_delay", "hide_danger_indicator", 1 );
    widgets_visibility::hide( "MacheteAttack", [ #"macheteattack" ] );
    self playerhide();
    wait 0.35;
    widgetname = self usinggamepad() ? "scripted_widget_input_prompts_machete_attack" : "scripted_widget_input_prompts_machete_attack_kbm";
    input_prompt_widget = scripted_widgets::function_652736891a41e948( widgetname );
    scripted_widgets::create( "machete_attack_prompts", input_prompt_widget );
    function_49d4f91bffe1794a( streakinfo );
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0x9b09b4e0, Offset: 0x17bd
// Size: 0x36e
function private function_49d4f91bffe1794a( streakinfo )
{
    streakinfo endon( #"machete_attack_succeeded", #"machete_attack_cancelled" );
    var_71429b3e1232d73c = streakinfo.cament.origin - streakinfo.playermarker.origin;
    var_32691eddea31a590 = streakinfo.centerpos + streakinfo.rightdir * 550 + streakinfo.forwarddir * 550;
    var_326921ddea31ac29 = streakinfo.centerpos - streakinfo.rightdir * 550 - streakinfo.forwarddir * 550;
    var_bb8894793eac764a = min( var_32691eddea31a590[ 0 ], var_326921ddea31ac29[ 0 ] );
    var_2e8bd8799298c014 = max( var_32691eddea31a590[ 0 ], var_326921ddea31ac29[ 0 ] );
    var_bb8895793eac787d = min( var_32691eddea31a590[ 1 ], var_326921ddea31ac29[ 1 ] );
    var_2e8bd9799298c247 = max( var_32691eddea31a590[ 1 ], var_326921ddea31ac29[ 1 ] );
    playfxontag( utility::getfx( "player_machete_marker" ), streakinfo.playermarker, "tag_origin" );
    
    while ( true )
    {
        input = ( 0, 0, 0 );
        
        if ( self usinggamepad() )
        {
            input = self getnormalizedmovement();
            input = vectornormalize2( input );
        }
        else
        {
            right_input = self function_c54fea69e24b693e() * -1;
            forward_input = self function_1f7761513b1a2d9f() * -1;
            input = ( forward_input, right_input, 0 );
        }
        
        if ( length2d( input ) > 0 )
        {
            offset = level.frameduration * 0.5;
            forwardoffset = input[ 0 ] * offset * streakinfo.forwarddir;
            rightoffset = input[ 1 ] * offset * streakinfo.rightdir;
            newpos = streakinfo.playermarker.origin + forwardoffset + rightoffset;
            clampedx = clamp( newpos[ 0 ], var_bb8894793eac764a, var_2e8bd8799298c014 );
            clampedy = clamp( newpos[ 1 ], var_bb8895793eac787d, var_2e8bd9799298c247 );
            streakinfo.playermarker.origin = ( clampedx, clampedy, newpos[ 2 ] );
            streakinfo.cament.origin = streakinfo.playermarker.origin + var_71429b3e1232d73c;
        }
        
        /#
            if ( getdvarint( @"hash_2b596d9a5a12e905", 0 ) )
            {
                debug_z = streakinfo.playermarker.origin[ 2 ];
                topleft = ( var_bb8894793eac764a, var_bb8895793eac787d, debug_z );
                topright = ( var_2e8bd8799298c014, var_bb8895793eac787d, debug_z );
                bottomleft = ( var_bb8894793eac764a, var_2e8bd9799298c247, debug_z );
                bottomright = ( var_2e8bd8799298c014, var_2e8bd9799298c247, debug_z );
                debug_color = ( 1, 1, 0 );
                line( topleft, topright, debug_color, 1, 1, 1 );
                line( topleft, bottomleft, debug_color, 1, 1, 1 );
                line( topright, bottomright, debug_color, 1, 1, 1 );
                line( bottomleft, bottomright, debug_color, 1, 1, 1 );
            }
        #/
        
        waitframe();
    }
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0xfc51e62b, Offset: 0x1b33
// Size: 0x24f
function private function_17e633a38810fe2e( streakinfo )
{
    self endon( #"killstreak_cancel" );
    
    while ( true )
    {
        var_9204619c81224641 = utility::waittill_any_return( "machete_attack_target_confirm", "machete_attack_target_cancel", "killstreak_cancel" );
        
        if ( var_9204619c81224641 == "killstreak_cancel" )
        {
            killfxontag( utility::getfx( "player_machete_marker" ), streakinfo.playermarker, "tag_origin" );
            return;
        }
        
        if ( var_9204619c81224641 == "machete_attack_target_confirm" )
        {
            killfxontag( utility::getfx( "player_machete_marker" ), streakinfo.playermarker, "tag_origin" );
            scripted_widgets::destroy( "machete_attack_prompts" );
            targetpos = getgroundposition( streakinfo.playermarker.origin, 5, 100 );
            var_f0aeeb3ef674e5ea = streakinfo.playermarker.origin[ 2 ] - 10;
            targetheight = min( targetpos[ 2 ], var_f0aeeb3ef674e5ea );
            targetpos = ( targetpos[ 0 ], targetpos[ 1 ], targetheight );
            targetangles = ( 0, randomint( 359 ), 0 );
            streakinfo.targetscriptable = spawnscriptable( %"sat_ob_machete_attack_target_bossfight", targetpos, targetangles );
            streakinfo.targetscriptable.isdynamic = 1;
            
            if ( streakinfo.targetscriptable )
            {
                streakinfo notify( #"machete_attack_succeeded" );
                streakinfo.playermarker hide();
                namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( self, 1, 0.1 );
                utility::delaythread( 0.15, &namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc, self, 0, 0.35 );
                function_bfee43bcb0dcc192( streakinfo.targetscriptable, undefined, undefined, streakinfo );
                utility::waittill_notify_or_timeout_return( "machete_impact_end", 5 );
                thread function_e0a806397a61ac7( streakinfo );
                namespace_9d8e359c3b1041e5::recordkillstreakendstatssharedfunc( streakinfo );
                streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
                return;
            }
            
            continue;
        }
        
        if ( var_9204619c81224641 == "machete_attack_target_cancel" )
        {
            killfxontag( utility::getfx( "player_machete_marker" ), streakinfo.playermarker, "tag_origin" );
            streakinfo notify( #"machete_attack_cancelled" );
            level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
            thread function_e0a806397a61ac7( streakinfo );
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return;
        }
    }
}

// Namespace ob_story_mission_machete_attack
// Params 2, eflags: 0x4
// Checksum 0xbc60d537, Offset: 0x1d8a
// Size: 0x139
function private function_e0a806397a61ac7( streakinfo, iscancel )
{
    self endon( #"death_or_disconnect" );
    
    if ( self.exiting_machete_attack )
    {
        return;
    }
    
    self.exiting_machete_attack = 1;
    
    if ( iscancel )
    {
        streakinfo.owner stoprumble( "machete_attack_warning" );
        
        if ( streakinfo.machete )
        {
            streakinfo.machete notify( #"machete_combat_cleanup" );
        }
    }
    
    if ( !iscancel )
    {
        self startcameratween( 0.35 );
    }
    
    self cameraunlink();
    scripted_widgets::destroy( "machete_attack_prompts" );
    
    if ( !iscancel )
    {
        wait 0.35;
    }
    
    self playershow();
    widgets_visibility::reset( "MacheteAttack" );
    val::group_reset( "machete_attack_val_group" );
    val::reset_all( "machete_attack" );
    utility::delaythreadendon( !iscancel ? 0.5 : 0, [ "death_or_disconnect", "player_enter_machete_attack" ], &val::reset_all, "machete_attack_val_delay" );
    streakinfo.cament delete();
    streakinfo.playermarker delete();
    utility::ent_flag_clear( "machete_attack_active" );
    self.exiting_machete_attack = undefined;
}

// Namespace ob_story_mission_machete_attack
// Params 1, eflags: 0x4
// Checksum 0x60f0e4c8, Offset: 0x1ecb
// Size: 0x66
function private function_162074a9f320b0f8( streakinfo )
{
    self endon( #"machete_impact" );
    
    while ( self && streakinfo.owner && streakinfo.owner getactivexcam() )
    {
        streakinfo.owner playrumbleonpositionforclient( "machete_attack_warning", streakinfo.owner getxcamposition() );
        waitframe();
    }
}

