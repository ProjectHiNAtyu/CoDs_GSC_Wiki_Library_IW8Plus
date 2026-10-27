// scripts\mp\gametypes\obj_bombzone.gsc  (hash_0780ca0ff5944fce.gscc) (size: 44280 Bytes / 0xacf8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a59be18 (2589572632)
// size ...... 44280 (0xacf8)
// includes .. 34  (offset: 0x9f90)
// strings ... 156 (offset: 0xa0a0)
// dev strs .. 6   (offset: 0xaca0)
// exports ... 55  (offset: 0x73a0)
// cseg ...... 0xbff + 0x67a1 (0x73a0)
// imports ... 260 (offset: 0x7c38)
// animtree1 . 0   (offset: 0xacf8)
// animtree2 . 0   (offset: 0xacf8)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\bots\bots_util;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\dd;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\weapons;

#namespace obj_bombzone;

// Namespace obj_bombzone
// Params 4
// Checksum 0x59252fa8, Offset: 0xc1d
// Size: 0x87c
function setupobjective( trigger, skipobjid, var_ee9ac91f30ff8e1, dropweapontriggerheight )
{
    bombzone = undefined;
    label = undefined;
    
    if ( isdefined( level.curobj ) )
    {
        level.curobj gameobjects::deleteuseobject();
    }
    
    if ( isdefined( trigger.originalpos ) )
    {
        trigger.origin = trigger.originalpos;
    }
    else
    {
        trigger.originalpos = trigger.origin;
    }
    
    visuals = undefined;
    
    if ( isdefined( trigger.target ) )
    {
        visuals = getentarray( trigger.target, #targetname );
    }
    
    if ( isdefined( trigger.objectivekey ) )
    {
        objectivekey = trigger.objectivekey;
    }
    else
    {
        objectivekey = trigger.script_label;
    }
    
    if ( var_ee9ac91f30ff8e1 )
    {
        reservedobjid = getreservedobjid( objectivekey );
    }
    else
    {
        reservedobjid = undefined;
    }
    
    gametypexhash = getxhash( game_utility::getgametype() );
    var_441b8d5f798c04a7 = ( 0, 0, 64 );
    
    if ( isdefined( trigger.target ) )
    {
        var_b6a962ec973ce64d = utility::getstruct( trigger.target, "targetname" );
        
        if ( isdefined( var_b6a962ec973ce64d ) )
        {
            var_441b8d5f798c04a7 = var_b6a962ec973ce64d.origin - trigger.origin;
        }
    }
    
    if ( gametypexhash == #"dd" )
    {
        label = trigger.script_label;
        collision = getent( "dd_bombzone_clip" + label, #targetname );
        
        if ( game_utility_mp::inovertime() )
        {
            if ( label == "_a" || label == "_b" )
            {
                trigger delete();
                
                if ( isdefined( visuals[ 0 ] ) )
                {
                    visuals[ 0 ] delete();
                }
                
                if ( isdefined( collision ) )
                {
                    collision delete();
                }
                
                return;
            }
            
            bombzone = gameobjects::createuseobject( "neutral", trigger, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid );
            bombzone gameobjects::allowuse( "any" );
            bombzone.trigger.script_label = "_a";
        }
        else if ( label == "_c" )
        {
            trigger delete();
            visuals[ 0 ] delete();
            collision delete();
            return;
        }
    }
    else if ( gametypexhash == #"sd" || gametypexhash == #"hc_sd" )
    {
        setomnvar( "ui_bomb_owner_team", 0 );
    }
    
    if ( !isdefined( bombzone ) )
    {
        scriptedbombzone = 0;
        
        if ( !isdefined( visuals ) )
        {
            scriptedbombzone = 1;
            defusetrigger = spawn( "script_model", trigger.origin );
            defusetrigger makeusable();
            defusetrigger.usetype = 1;
            defusetrigger.isuseobject = 1;
            defusetrigger.skiptouching = 1;
            visuals[ 0 ] = trigger;
            visuals[ 0 ].bombdefusetrig = defusetrigger;
        }
        
        if ( gametypexhash == #"robj" || level.var_6ee986c6c0f5d22c )
        {
            bombzone = gameobjects::createuseobject( "neutral", trigger, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid );
            bombzone gameobjects::allowuse( "any" );
        }
        else if ( level.var_68d6dd209dfdc9 && isdefined( trigger.var_c6fb9b3be85f787b ) )
        {
            bombzone = gameobjects::createuseobject( game[ "defenders" ], trigger.var_c6fb9b3be85f787b, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid );
            bombzone gameobjects::allowuse( "enemy" );
            bombzone.trigger.script_label = trigger.script_label;
        }
        else
        {
            bombzone = gameobjects::createuseobject( game[ "defenders" ], trigger, visuals, var_441b8d5f798c04a7, reservedobjid, skipobjid );
            bombzone gameobjects::allowuse( "enemy" );
        }
        
        if ( scriptedbombzone == 1 )
        {
            bombzone.trigger makeusable();
            bombzone.skiptouching = 1;
        }
    }
    
    if ( isdefined( trigger.objectivekey ) )
    {
        bombzone.objectivekey = trigger.objectivekey;
    }
    else
    {
        bombzone.objectivekey = bombzone gameobjects::getlabel();
    }
    
    if ( isdefined( trigger.iconname ) )
    {
        bombzone.iconname = trigger.iconname;
    }
    else
    {
        bombzone.iconname = bombzone gameobjects::getlabel();
    }
    
    bombzone.id = "bomb_zone";
    bombzone.trigger setusepriority( -4 );
    bombzone gameobjects::setusetime( level.planttime );
    bombzone gameobjects::setwaitweaponchangeonuse( 0 );
    bombzone gameobjects::setusehinttext( &"mp/hold_to_plant_explosives" );
    bombzone.trigger setuseholdduration( "duration_none" );
    
    if ( !level.multibomb )
    {
        bombzone gameobjects::setkeyobject( level.sdbomb );
    }
    
    if ( bombzone.objectivekey == "_c" && gametypexhash != #"gwbomb" && game_utility::getgametype() != "sd" )
    {
        bombzone.objectivekey = "_a";
        bombzone.iconname = "_a";
    }
    
    if ( gametypexhash == #"cmd" && game_utility_mp::inovertime() )
    {
        bombzone gameobjects::setobjectivestatusicons( "waypoint_target" );
        bombzone gameobjects::setvisibleteam( "any" );
    }
    
    bombzone.usecondition = &bombzone_usecondition;
    bombzone.onbeginuse = &bombzone_onbeginuse;
    bombzone.onenduse = &bombzone_onenduse;
    bombzone.onuse = &bombzone_onuseplantobject;
    var_b25e82880942a851 = level.gametypebundle.bombweapon ?? "briefcase_bomb_mp";
    bombzone.useweapon = makeweapon( var_b25e82880942a851 );
    bombzone.bombplanted = 0;
    bombzone.bombexploded = undefined;
    bombzone.resetprogress = level.resetprogress;
    
    for ( i = 0; i < visuals.size ; i++ )
    {
        if ( isdefined( visuals[ i ].script_exploder ) )
        {
            bombzone.exploderindex = visuals[ i ].script_exploder;
            visuals[ i ] thread function_d1efa73146066748( bombzone );
            visuals[ i ] thread setupkillcament( bombzone );
            break;
        }
    }
    
    if ( gametypexhash != #"dd" || gametypexhash == #"gwbomb" )
    {
        if ( isdefined( visuals[ 0 ].target ) )
        {
            bombzone.bombdefusetrig = getent( visuals[ 0 ].target, #targetname );
        }
        else if ( !isdefined( bombzone.bombdefusetrig ) && isdefined( visuals[ 0 ].bombdefusetrig ) )
        {
            bombzone.bombdefusetrig = visuals[ 0 ].bombdefusetrig;
        }
        
        assert( isdefined( bombzone.bombdefusetrig ) );
        bombzone.bombdefusetrig.origin += ( 0, 0, -10000 );
        bombzone.bombdefusetrig.label = label;
    }
    else
    {
        if ( isdefined( visuals[ 0 ].target ) )
        {
            trig = getent( visuals[ 0 ].target, #targetname );
            
            if ( isdefined( trig ) )
            {
                trig delete();
            }
        }
        
        bombzone.bombdefusetrig = bombzone.trigger;
    }
    
    if ( !isdefined( dropweapontriggerheight ) )
    {
        dropweapontriggerheight = 60;
    }
    
    bombzone.noweapondropallowedtrigger = spawn( "trigger_radius", bombzone.trigger.origin, 0, 150, dropweapontriggerheight );
    
    if ( isdefined( bombzone.trigger.target ) && level.assignbombzonechevrons )
    {
        bombzone thread assignbombzonechevrons();
    }
    
    function_494a3aee22fd0a34( bombzone );
    return bombzone;
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x7856b81a, Offset: 0x14a2
// Size: 0x69
function function_494a3aee22fd0a34( bombzone )
{
    halfbounds = bombzone.trigger function_10a84122a845e3bb();
    maxbound = halfbounds[ 0 ];
    
    if ( maxbound < halfbounds[ 1 ] )
    {
        maxbound = halfbounds[ 1 ];
    }
    
    if ( maxbound < halfbounds[ 2 ] )
    {
        maxbound = halfbounds[ 2 ];
    }
    
    bombzone.trigger setuserange( maxbound * 2 );
}

// Namespace obj_bombzone
// Params 0
// Checksum 0xba5072cb, Offset: 0x1513
// Size: 0x231
function assignbombzonechevrons()
{
    bombzone = self;
    wait 1;
    othervisuals = getentitylessscriptablearray( bombzone.trigger.target, #targetname );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
        
        if ( isdefined( visual.script_noteworthy ) )
        {
            if ( visual.script_noteworthy == "2" )
            {
                chevrons[ index ].numchevrons = 2;
                continue;
            }
            
            if ( visual.script_noteworthy == "3" )
            {
                chevrons[ index ].numchevrons = 3;
                continue;
            }
            
            if ( visual.script_noteworthy == "4" )
            {
                chevrons[ index ].numchevrons = 4;
            }
        }
    }
    
    bombzone.chevrons = chevrons;
    
    foreach ( chevron in bombzone.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), bombzone.ownerteam );
        }
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x92e90f5b, Offset: 0x174c
// Size: 0x71
function getreservedobjid( objectivekey )
{
    reservedid = 0;
    
    if ( level.var_68d6dd209dfdc9 )
    {
        if ( objectivekey == "_a" )
        {
            reservedid = 0;
        }
        else if ( objectivekey == "_b" )
        {
            reservedid = 1;
        }
        else if ( objectivekey == "_c" )
        {
            reservedid = 2;
        }
    }
    else if ( objectivekey == "_a" )
    {
        reservedid = 0;
    }
    else
    {
        reservedid = 1;
    }
    
    return reservedid;
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x5d863103, Offset: 0x17c6
// Size: 0x1f5
function setupkillcament( bombzone )
{
    temporg = spawn( "script_origin", self.origin );
    temporg.angles = self.angles;
    temporg rotateyaw( -45, 0.05 );
    waitframe();
    campos = undefined;
    bulletstart = self.origin + anglestoforward( temporg.angles ) * 18 + ( 0, 0, 60 );
    bulletend = self.origin + anglestoforward( temporg.angles ) * 100 + ( 0, 0, 128 );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle" ];
    contentoverride = physics_createcontents( content );
    result = trace::sphere_trace( bulletstart, bulletend, 16, [ self ], contentoverride );
    campos = result[ "shape_position" ];
    self.killcament = spawn( "script_model", campos );
    self.killcament setscriptmoverkillcam( "explosive" );
    bombzone.killcamentnum = self.killcament getentitynumber();
    temporg delete();
    
    /#
        if ( getdvarint( @"hash_3f3a15fb7e7c9b0" ) > 0 )
        {
            thread debug_utility::drawline( bulletstart, bulletend, 999, ( 1, 1, 0 ) );
            thread debug_utility::drawsphere( bulletstart, 2, 999, ( 0, 1, 0 ) );
            thread debug_utility::drawsphere( bulletend, 2, 999, ( 1, 0, 0 ) );
            thread debug_utility::drawsphere( campos, 2, 999, ( 1, 0, 1 ) );
        }
        
        self.killcament thread debugkillcament( self );
    #/
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xbd6443b0, Offset: 0x19c3
// Size: 0x18d
function allowedwhileplanting( isallowed )
{
    if ( !isallowed )
    {
        val::set( "bombzone", "allow_jump", 0 );
        val::set( "bombzone", "gesture", 0 );
        val::set( "bombzone", "melee", 0 );
        val::set( "bombzone", "mantle", 0 );
        val::set( "bombzone", "offhand_weapons", 0 );
        val::set( "bombzone", "equipment_primary", 0 );
        val::set( "bombzone", "equipment_secondary", 0 );
        val::set( "bombzone", "supers", 0 );
        val::set( "bombzone", "sprint", 0 );
        val::set( "bombzone", "slide", 0 );
        return;
    }
    
    val::set( "bombzone", "allow_jump", 1 );
    val::set( "bombzone", "gesture", 1 );
    currweap = self getcurrentweapon();
    var_a19766e6fe59d7cf = level.gametypebundle.bombweapon ?? "briefcase_bomb_mp";
    var_565c2a95b34f6d25 = level.gametypebundle.bombdefuseweapon ?? "briefcase_bomb_defuse_mp";
    
    if ( isdefined( currweap ) && ( currweap.basename == var_a19766e6fe59d7cf || currweap.basename == var_565c2a95b34f6d25 ) )
    {
        self waittill( #"hash_caf664dbe9872771" );
    }
    
    val::reset_all( "bombzone" );
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x1fe9dda7, Offset: 0x1b58
// Size: 0x8d
function setbombplantingomnvar( bombsite )
{
    self endon( #"hash_2bd3c16fbd14b0bd" );
    wait 0.35;
    omnvarval = 0;
    
    switch ( bombsite )
    {
        case #"hash_fac2c5f6bddd49bd":
            omnvarval = 1;
            break;
        case #"hash_fac2c2f6bddd4504":
            omnvarval = 2;
            break;
        case #"hash_fac2c3f6bddd4697":
            omnvarval = 2;
            break;
        default:
            omnvarval = 2;
            break;
    }
    
    setomnvar( "ui_bomb_interacting", omnvarval );
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xf8ad2f1b, Offset: 0x1bed
// Size: 0x75
function setbombdefusingomnvar( bombsite )
{
    self endon( #"hash_2bd3c16fbd14b0bd" );
    wait 0.35;
    
    if ( bombsite == "_a" )
    {
        omnvarval = 3;
    }
    else
    {
        omnvarval = 4;
    }
    
    setomnvar( "ui_bomb_interacting", omnvarval );
    
    if ( level.codcasterenabled )
    {
        self setgametypevip( 1 );
    }
    
    codcaster_utils::function_3038b6eafc46c037( 2, self.team, self getentitynumber() );
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xd2dcbf4b, Offset: 0x1c6a
// Size: 0x416
function bombzone_onbeginuse( player )
{
    if ( player issprintsliding() )
    {
        player function_64f1800c957cf63c();
        player setstance( "crouch", 0, 1, 1 );
    }
    
    player thread allowedwhileplanting( 0 );
    player gameplay_sound_fx::playlocalsoundfx( #"hash_bf0670a36bff72dd" );
    objid = self.objidnum;
    objidpoolmanager::objective_show_team_progress( objid, player.team );
    
    if ( isdefined( self.callbacks[ #"hash_90e8659b0b441f02" ] ) || isdefined( level.callbacks[ #"hash_90e8659b0b441f02" ] ) )
    {
        callback::callback( #"hash_90e8659b0b441f02", { #bombplanted:self.bombplanted, #player:player } );
    }
    
    if ( self.bombplanted )
    {
        player bots_util_mp::notify_enemy_bots_bomb_used( "defuse" );
        player notify( #"hash_b104d266cdc3b33b" );
        player.isdefusing = 1;
        player gameplay_sound_fx::function_6dac8db778849e61( #"shared_obj_bomb_defuse_start", player.team );
        dialog_utility::function_7162cf91018ef73e( #"bomb_defuse", player.team );
        player thread setbombdefusingomnvar( self.objectivekey );
        setomnvar( "ui_bomb_defuser", player getentitynumber() );
        player objidpoolmanager::function_101225acbc89c1c1( 2, "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS" );
        
        if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
        {
        }
        else
        {
            if ( game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "counter" )
            {
                gameobjects::setobjectivestatusicons( "waypoint_bomb_defusing", "waypoint_bomb_defend" );
            }
            else
            {
                gameobjects::setobjectivestatusicons( "waypoint_bomb_defend_nt", "waypoint_bomb_defusing" );
            }
            
            objidpoolmanager::objective_teammask_removefrommask( self.radialtimeobjid, player.team );
        }
        
        if ( isdefined( level.sdbombmodel ) )
        {
            level.sdbombmodel hide();
        }
        else if ( isdefined( level.ddbombmodel[ self.objectivekey ] ) )
        {
            level.ddbombmodel[ self.objectivekey ] hide();
        }
        
        var_565c2a95b34f6d25 = level.gametypebundle.bombdefuseweapon ?? "briefcase_bomb_defuse_mp";
        player thread startnpcbombusesound( var_565c2a95b34f6d25, #"hash_980967e7ba00a768" );
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_e14c1978f1b4a97d", 0 ) )
        {
            player utility::callsharedfunc( #"gametype", #"hash_e14c1978f1b4a97d", 0 );
        }
        else
        {
            player thread function_9e7f06255372863e( 0 );
        }
        
        return;
    }
    
    player bots_util_mp::notify_enemy_bots_bomb_used( "plant" );
    player notify( #"hash_b104d266cdc3b33b" );
    player.isplanting = 1;
    player.bombplantweapon = self.useweapon;
    player thread setbombplantingomnvar( self.objectivekey );
    friendlyalias = utility::callsharedfunc( #"gametype", #"hash_90afc729ab540006", player.team );
    
    if ( isdefined( friendlyalias ) )
    {
        dialog::statusdialog( friendlyalias, player.team, "status" );
    }
    else
    {
        dialog::statusdialog( "bomb_planting" + self.objectivekey, player.team, "status" );
    }
    
    player objidpoolmanager::function_101225acbc89c1c1( 2, "MP_INGAME_ONLY/OBJ_PLANTING_CAPS" );
    gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_bomb_planting" );
    var_a19766e6fe59d7cf = level.gametypebundle.bombweapon ?? "briefcase_bomb_mp";
    player thread startnpcbombusesound( var_a19766e6fe59d7cf, #"hash_9814bd988efcfc34" );
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_e14c1978f1b4a97d", 0 ) )
    {
        player utility::callsharedfunc( #"gametype", #"hash_e14c1978f1b4a97d", 1 );
        return;
    }
    
    player thread function_9e7f06255372863e( 1 );
}

// Namespace obj_bombzone
// Params 3
// Checksum 0x69efdee1, Offset: 0x2088
// Size: 0x29b
function bombzone_onenduse( team, player, result )
{
    player notify( #"hash_2bd3c16fbd14b0bd" );
    
    if ( player.isdefusing || player.isplanting )
    {
        setomnvar( "ui_bomb_interacting", 0 );
    }
    
    if ( player.isdefusing && level.codcasterenabled )
    {
        player setgametypevip( 0 );
    }
    
    player gameplay_sound_fx::stoplocalsoundfx( #"hash_bf0670a36bff72dd" );
    setomnvar( "ui_bomb_defuser", -1 );
    objid = self.objidnum;
    
    if ( level.resetprogress )
    {
        objidpoolmanager::objective_set_progress( objid, 0 );
        objidpoolmanager::objective_show_progress( objid, 0 );
    }
    
    if ( isdefined( self.callbacks[ #"hash_f1f1c4c5d121b7df" ] ) || isdefined( level.callbacks[ #"hash_f1f1c4c5d121b7df" ] ) )
    {
        callback::callback( #"hash_f1f1c4c5d121b7df", { #success:result, #player:player } );
    }
    
    if ( !result )
    {
        if ( game_utility_mp::inovertime() && self.bombplanted == 0 )
        {
            self.showprogressforteam = undefined;
        }
        
        if ( self.bombplanted )
        {
            if ( game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "counter" )
            {
                gameobjects::setobjectivestatusicons( "waypoint_defuse", "waypoint_defend" );
            }
            else
            {
                gameobjects::setobjectivestatusicons( "waypoint_bomb_defend_nt", "waypoint_defuse" );
            }
        }
        else
        {
            gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        }
        
        if ( isdefined( self.radialtimeobjid ) )
        {
            objidpoolmanager::objective_teammask_addtomask( self.radialtimeobjid, player.team );
        }
        
        if ( self.bombplanted )
        {
            if ( isdefined( level.sdbombmodel ) )
            {
                level.sdbombmodel show();
            }
            else if ( isdefined( level.ddbombmodel[ self.objectivekey ] ) )
            {
                level.ddbombmodel[ self.objectivekey ] show();
            }
        }
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player thread allowedwhileplanting( 1 );
    player.bombplantweapon = undefined;
    
    if ( isalive( player ) )
    {
        player.isdefusing = 0;
        player.isplanting = 0;
    }
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        player.ui_bomb_planting_defusing = undefined;
    }
    
    player notify( #"hash_da42a131ecd3bc91" );
}

// Namespace obj_bombzone
// Params 2
// Checksum 0x683cb723, Offset: 0x232b
// Size: 0x109
function startnpcbombusesound( weaponname, soundref )
{
    self endon( #"death" );
    self endon( #"hash_eb6e0059397c7fef" );
    
    if ( game_utility_mp::isanymlgmatch() || level.silentplant || isdefined( self.perks[ "specialty_engineer" ] ) && level.perkbundles[ "specialty_engineer" ].silent_plant_defuse )
    {
        self setentitysoundcontext( "silent_plant", "on" );
        return;
    }
    
    while ( true )
    {
        self waittill( #"weapon_change", newweaponobj );
        
        if ( newweaponobj.basename == weaponname )
        {
            break;
        }
    }
    
    gameplay_sound_fx::function_6dac8db778849e61( soundref, self.team, self );
    enemyteam = team_utility::getotherteam( self.team );
    gameplay_sound_fx::function_6dac8db778849e61( soundref, enemyteam );
    self waittill( #"weapon_change" );
    self notify( #"hash_eb6e0059397c7fef" );
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x7dc8d866, Offset: 0x243c
// Size: 0x26
function function_db5303b5242dbfec()
{
    if ( isdefined( self.bombtimer ) )
    {
        return self.bombtimer;
    }
    
    return level.bombtimer;
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x6e4e3cb5, Offset: 0x246a
// Size: 0xd7, Type: bool
function bombzone_usecondition( player )
{
    if ( !( isdefined( self ) && isdefined( self.visuals[ 0 ] ) ) )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player issprintsliding() )
    {
        return false;
    }
    
    if ( player isdiving() )
    {
        return false;
    }
    
    if ( player istouching( self.trigger ) )
    {
        if ( level.var_68d6dd209dfdc9 )
        {
            return true;
        }
        
        bombzone = self.visuals[ 0 ];
        bombzoneup = vectornormalize( anglestoup( bombzone.angles ) );
        bombzonetoplayer = vectornormalize( player.origin - bombzone.origin );
        dotproduct = vectordot( bombzoneup, bombzonetoplayer );
        return ( dotproduct <= 0.5 );
    }
    
    return false;
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xd0743959, Offset: 0x254a
// Size: 0x4ae
function bombzone_onuseplantobject( player )
{
    if ( game_utility_mp::inovertime() && self.bombplanted == 0 || !gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
    {
        self.showprogressforteam = undefined;
        
        if ( !isdefined( self.onbombplanted ) )
        {
            level thread bombzone_onbombplanted( self, player );
        }
        else
        {
            level thread [[ self.onbombplanted ]]( self, player );
        }
        
        player notify( #"bomb_planted" );
        announcementextradata = 2;
        
        if ( self.objectivekey == "_a" )
        {
            announcementextradata = 1;
        }
        
        codcaster_utils::function_3038b6eafc46c037( 0, player.team, player getentitynumber(), announcementextradata );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "plants" ] ) )
            {
                player.leaderboarddata[ "plants" ] = player.leaderboarddata[ "plants" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "plants" ] ) )
            {
                [[ level.leaderboardfunc[ "plants" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "plants" ] ) )
            {
                player.pers[ "plants" ] = player.pers[ "plants" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "plants", player.pers[ "plants" ] );
        player codcasterclientmatchdata::function_8ecc753b54a5740f( 3, 1 );
        
        if ( !level.var_6ee986c6c0f5d22c )
        {
            player stats::setextrascore0( player.pers[ "plants" ], "plants" );
        }
        
        if ( isdefined( level.sd_loadout[ player.team ] ) )
        {
            player thread removebombcarrierclass();
        }
        
        if ( game_utility::getgametype() != "cmd" )
        {
            enemyalias = utility::callsharedfunc( #"gametype", #"hash_f3fb547b6fd75a8a", player.team );
            
            if ( isdefined( enemyalias ) )
            {
                dialog::statusdialog( enemyalias, team_utility::getotherteam( player.team ), 1 );
            }
            else if ( game_utility_mp::inovertime() )
            {
                dialog::statusdialog( "enemy_bomb_planted", team_utility::getotherteam( player.team ), 1 );
            }
            else
            {
                dialog::statusdialog( "enemy_bomb" + self.objectivekey, team_utility::getotherteam( player.team ), 1 );
            }
            
            friendlyalias = utility::callsharedfunc( #"gametype", #"hash_cc7a184cf6227491", player.team );
            
            if ( isdefined( friendlyalias ) )
            {
                dialog::statusdialog( friendlyalias, player.team, 1 );
            }
            else if ( game_utility::getgametype() == "gwbomb" )
            {
                dialog::statusdialog( "bomb_planted" + self.objectivekey, player.team, 1 );
            }
            else
            {
                dialog::statusdialog( "bomb_planted", player.team, 1 );
            }
        }
        
        if ( !self.hidesplash )
        {
            level thread hud_util::teamplayercardsplash( "callout_bombplanted", player );
        }
        
        level.bombowner = player;
        scoreevent = #"plant";
        
        if ( self.scoreeventoverride )
        {
            scoreevent = self.scoreeventoverride;
        }
        
        player thread points::doscoreevent( scoreevent, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:self.objectivekey } );
        player.bombplantedtime = gettime();
        player challenges::function_981ae5464b9301da( player.disguised );
        
        if ( isplayer( player ) )
        {
            challenges::function_a3678ff124a05f01( player );
            telemetry_data = {};
            telemetry_data.player = player;
            telemetry_data.eventname = "plant";
            telemetry_data.position = player.origin;
            telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        }
        
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", "bomb", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 0 ] );
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x19c4192a, Offset: 0x2a00
// Size: 0x2a2
function bombzone_onusedefuseobject( player )
{
    setomnvar( "ui_bomb_interacting", 0 );
    setomnvar( "ui_victory_condition_completed", 1 );
    
    foreach ( bombsite in level.objectives )
    {
        isbombsite = 0;
        
        if ( game_utility::getgametype() == "counter" )
        {
            isbombsite = isdefined( bombsite.objidnum ) && bombsite.objidnum == self.objidnum;
        }
        else
        {
            isbombsite = isdefined( bombsite.objectivekey ) && bombsite.objectivekey == self.objectivekey;
        }
        
        if ( isbombsite )
        {
            player gameplay_sound_fx::playlocalsoundfx( "shared_obj_bomb_defuse" );
            player notify( "bomb_defused" + bombsite.objectivekey );
            level thread bombdefused( bombsite );
            self.bombdefused = 1;
            dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", bombsite.objectivekey, "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
            break;
        }
    }
    
    if ( game_utility::getgametype() != "dd" && game_utility::getgametype() != "gwbomb" && game_utility::getgametype() != "counter" )
    {
        gameobjects::disableobject();
        iprintln( &"mp/explosives_defused_by", player );
    }
    
    if ( game_utility::getgametype() == "gwbomb" )
    {
        dialog::statusdialog( "enemy_bomb_defused" + self.objectivekey, team_utility::getotherteam( player.team ), 1 );
        dialog::statusdialog( "bomb_defused" + self.objectivekey, player.team, 1 );
    }
    else if ( game_utility::getgametype() != "counter" )
    {
        dialog::statusdialog( "enemy_bomb_defused", team_utility::getotherteam( player.team ), 1 );
        dialog::statusdialog( "bomb_defused", player.team, 1 );
    }
    
    level thread hud_util::teamplayercardsplash( "callout_bombdefused", player );
    player challenges::function_5f09e82f1ba9ce65( player.disguised );
    events::bombdefused( player, self );
}

// Namespace obj_bombzone
// Params 2
// Checksum 0xf41cd83c, Offset: 0x2caa
// Size: 0x1696
function bombzone_onbombplanted( destroyedobj, player )
{
    level endon( #"bombs_canceled" );
    level notify( #"bomb_planted", destroyedobj, player );
    plantteam = player.team;
    level.bombdefused = 0;
    destroyedobj.bombdefused = 0;
    
    if ( game_utility::getgametype() == "dd" && level.bombsplanted <= 0 )
    {
        gamelogic_mp::pausetimer();
        level.timepausestart = gettime();
    }
    
    level.bombplanted = 1;
    level.bombsplanted += 1;
    
    if ( !isdefined( level.var_5897b98addb7dbdd ) )
    {
        level.var_5897b98addb7dbdd = [];
        
        foreach ( team in level.teamnamelist )
        {
            level.var_5897b98addb7dbdd[ team ] = 0;
        }
    }
    
    level.var_5897b98addb7dbdd[ plantteam ]++;
    player dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 0, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", destroyedobj.objectivekey, "team", plantteam, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    
    if ( game_utility::getgametype() != "btm" )
    {
        if ( game_utility::getgametype() == "gwbomb" )
        {
            var_c158c6c9c6882fd6 = getteamscore( plantteam ) + level.var_5897b98addb7dbdd[ plantteam ];
            otherteam = team_utility::getotherteam( plantteam );
            var_35bb93a6b749cf2d = getteamscore( otherteam ) + level.var_5897b98addb7dbdd[ otherteam ];
            
            if ( var_c158c6c9c6882fd6 >= var_35bb93a6b749cf2d )
            {
                level.timelimitoverride = 1;
            }
        }
        else
        {
            level.timelimitoverride = 1;
        }
    }
    
    level.defuseendtime = int( gettime() + destroyedobj function_db5303b5242dbfec() * 1000 );
    
    if ( destroyedobj.objectivekey == "_a" )
    {
        level.aplanted = 1;
        
        if ( hasomnvar( o"ui_bomb_planted_index" ) )
        {
            setomnvar( o"ui_bomb_planted_index", 1 );
        }
    }
    else if ( destroyedobj.objectivekey == "_b" )
    {
        level.bplanted = 1;
        
        if ( hasomnvar( o"ui_bomb_planted_index" ) )
        {
            setomnvar( o"ui_bomb_planted_index", 2 );
        }
    }
    else if ( destroyedobj.objectivekey == "_c" )
    {
        level.cplanted = 1;
    }
    
    setbombtimeromnvars( player.team, destroyedobj.objectivekey );
    level.destroyedobject = destroyedobj;
    level.destroyedobject.bombplanted = 1;
    
    if ( !level.multibomb )
    {
        player setclientomnvar( "ui_hud_carried_item_count", 0 );
        player setclientomnvar( "ui_carrying_bomb", 0 );
        setomnvar( "ui_bomb_carrier", -1 );
        setgameendtime( level.defuseendtime );
    }
    
    if ( isdefined( destroyedobj.visuals[ 0 ] ) )
    {
        destroyedobj.visuals[ 0 ] thread gamelogic_mp::playtickingsound( destroyedobj function_db5303b5242dbfec() );
        level.tickingobject = destroyedobj.visuals[ 0 ];
    }
    else
    {
        destroyedobj.bombdefusetrig thread gamelogic_mp::playtickingsound( destroyedobj function_db5303b5242dbfec() );
        level.tickingobject = destroyedobj.visuals[ 0 ];
    }
    
    if ( !level.multibomb )
    {
        level.sdbomb gameobjects::allowcarry( "none" );
        var_bd1c8e648dd1074a = function_df4449c14e7e2c42();
        level.sdbomb gameobjects::setdropped( undefined, var_bd1c8e648dd1074a > 0 ? var_bd1c8e648dd1074a : undefined, getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 );
        
        if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
        {
            level.sdbombmodel.scriptable.origin = level.sdbomb.trigger.origin;
            level.sdbombmodel unlink( 1 );
            
            if ( plantteam == "allies" )
            {
                level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "plantedAllies" );
            }
            else
            {
                level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "plantedAxis" );
            }
        }
        else
        {
            level.sdbomb gameobjects::setvisibleteam( "none" );
            
            if ( isdefined( level.gametypebundle.var_829f4f028cd0d42c ) )
            {
                level.sdbomb.visuals[ 0 ] setmodel( level.gametypebundle.var_829f4f028cd0d42c );
            }
            
            level.sdbombmodel setasgametypeobjective();
            level.sdbomb gameobjects::releaseid( 1, 1 );
        }
        
        level.sdbombmodel setentityhudoutlinedata( 1, plantteam );
    }
    else if ( game_utility::getgametype() == "cmd" || game_utility::getgametype() == "gwbomb" )
    {
    }
    else if ( game_utility::getgametype() == "dd" || game_utility::getgametype() == "btm" || game_utility::getgametype() == "counter" )
    {
        level.ddbombmodel[ destroyedobj.objectivekey ] = spawn( "script_model", player.origin );
        level.ddbombmodel[ destroyedobj.objectivekey ].angles = player.angles;
        
        if ( isdefined( level.gametypebundle.var_829f4f028cd0d42c ) )
        {
            level.ddbombmodel[ destroyedobj.objectivekey ] setmodel( level.gametypebundle.var_829f4f028cd0d42c );
        }
        
        level.ddbombmodel[ destroyedobj.objectivekey ] setasgametypeobjective();
        level.ddbombmodel[ destroyedobj.objectivekey ] setnonstick( 1 );
    }
    else if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
    {
        level.sdbombmodel unlink( 1 );
        
        if ( plantteam == "allies" )
        {
            level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "plantedAllies" );
        }
        else
        {
            level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "plantedAxis" );
        }
    }
    else
    {
        level.sdbombmodel = spawn( "script_model", player.origin );
        level.sdbombmodel.angles = player.angles;
        level.sdbombmodel setmodel( "offhand_2h_wm_briefcase_bomb_v0" );
        level.sdbombmodel setasgametypeobjective();
        level.sdbombmodel setnonstick( 1 );
    }
    
    if ( game_utility::getgametype() != "dd" && game_utility::getgametype() != "cmd" || game_utility::getgametype() != "btm" && game_utility::getgametype() != "gwbomb" && game_utility::getgametype() != "counter" )
    {
        if ( level.defenderscanseeplantedbomb )
        {
            destroyedobj gameobjects::allowuse( "none" );
            destroyedobj gameobjects::setvisibleteam( "none" );
        }
    }
    
    visuals = [];
    
    if ( game_utility::getgametype() == "dd" || game_utility::getgametype() == "cmd" || game_utility::getgametype() == "btm" )
    {
        defuseobject = destroyedobj;
        defuseobject gameobjects::setownerteam( player.team );
    }
    else if ( game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "counter" )
    {
        defuseobject = destroyedobj;
    }
    else
    {
        trigger = destroyedobj.bombdefusetrig;
        trigger.origin = level.sdbombmodel.origin;
        defuseownerteam = plantteam;
        
        if ( level.defenderscanseeplantedbomb )
        {
            destroyedobj gameobjects::releaseid( 1, 1 );
        }
        
        defuseobject = gameobjects::createuseobject( defuseownerteam, trigger, visuals, ( 0, 0, 32 ) );
        objidpoolmanager::objective_set_play_intro( defuseobject.objidnum, 0 );
        objidpoolmanager::objective_set_play_outro( defuseobject.objidnum, 0 );
    }
    
    if ( getprojectname() == "ZUL" )
    {
        defuseobject.sfxloop = spawn( "script_origin", defuseobject.trigger.origin + ( 0, 0, 15 ) );
        defuseobject.sfxloop thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_4255f302dc94713a", game[ "attackers" ] );
        defuseobject.sfxloop thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_336dad02d4d23dce", game[ "defenders" ] );
        defuseobject.sfxloop gameplay_sound_fx::function_8219c402fc8c37a3( #"hash_bd096083d4ea773c" );
    }
    
    defuseobject.objectivekey = destroyedobj.objectivekey;
    defuseobject.iconname = destroyedobj.iconname;
    defuseobject.id = "defuse_object";
    defuseobject.trigger setusepriority( -4 );
    defuseobject.usecondition = &function_365d59ee57141af7;
    defuseobject.checkuseconditioninthink = 1;
    defuseobject.skiptouching = 1;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_1aac086c17fe5ccb":
            defuseobject gameobjects::allowuse( "none" );
            break;
        case #"hash_681e57e53a02403":
        case #"hash_9a6f07d0214a87db":
            defuseobject gameobjects::allowuse( "friendly" );
            break;
        default:
            defuseobject gameobjects::allowuse( "enemy" );
            break;
    }
    
    if ( level.scriptedtriggers )
    {
        foreach ( player in teams::getteamdata( plantteam, "players" ) )
        {
            defuseobject.trigger disableplayeruse( player );
        }
    }
    
    defuseobject gameobjects::setusetime( level.defusetime );
    defuseobject gameobjects::setwaitweaponchangeonuse( 0 );
    defuseobject gameobjects::setusehinttext( &"mp/hold_to_defuse_explosives" );
    defuseobject.trigger setuseholdduration( "duration_none" );
    
    if ( level.defenderscanseeplantedbomb )
    {
        defuseobject gameobjects::setvisibleteam( "any" );
    }
    
    if ( game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "counter" )
    {
        defuseobject gameobjects::setobjectivestatusicons( "waypoint_defuse", "waypoint_bomb_defend" );
        defuseobject thread bombradialfill( plantteam, "waypoint_defuse", "waypoint_bomb_defend" );
    }
    else
    {
        defuseobject gameobjects::setobjectivestatusicons( "waypoint_bomb_defend_nt", "waypoint_defuse_nt" );
        
        if ( game_utility::getgametype() != "cmd" )
        {
            defuseobject thread bombradialfill( plantteam, "waypoint_bomb_defend", "waypoint_defuse" );
        }
    }
    
    if ( game_utility::getgametype() == "cmd" && level.cmdrules == 2 )
    {
    }
    else
    {
        if ( game_utility::getgametype() != "counter" )
        {
            defuseobject.onbeginuse = &bombzone_onbeginuse;
            defuseobject.onenduse = &bombzone_onenduse;
        }
        
        defuseobject.onuse = &bombzone_onusedefuseobject;
        defuseobject.resetprogress = level.resetprogress;
        level.defuseobject = defuseobject;
        var_565c2a95b34f6d25 = level.gametypebundle.bombdefuseweapon ?? "briefcase_bomb_defuse_mp";
        defuseobject.useweapon = makeweapon( var_565c2a95b34f6d25 );
    }
    
    destroyedobj bombtimerwait( destroyedobj.objectivekey );
    
    if ( isdefined( defuseobject.sfxloop ) )
    {
        defuseobject.sfxloop stoploopsound();
    }
    
    if ( isdefined( destroyedobj.visuals[ 0 ] ) )
    {
        destroyedobj.visuals[ 0 ] gamelogic_mp::stoptickingsound();
    }
    else
    {
        destroyedobj.bombdefusetrig gamelogic_mp::stoptickingsound();
    }
    
    defuseobject.bombplanted = 0;
    
    if ( level.gameended )
    {
        return;
    }
    else if ( game_utility_mp::getbasegametype() == "sd" && level.bombdefused && level.bombdefused )
    {
        defuseobject gameobjects::deleteuseobject();
        return;
    }
    
    if ( game_utility::getgametype() == "dd" || game_utility::getgametype() == "cmd" || game_utility::getgametype() == "btm" )
    {
        defuseobject.showprogressforteam = undefined;
        var_eb7099609db6a558 = &dd::bombhandler;
        
        if ( destroyedobj.bombdefused )
        {
            destroyedobj thread [[ var_eb7099609db6a558 ]]( player, "defused" );
            destroyedobj.onuse = &bombzone_onuseplantobject;
            
            if ( isdefined( level.ddbombmodel[ destroyedobj.objectivekey ] ) )
            {
                level.ddbombmodel[ destroyedobj.objectivekey ] delete();
            }
            
            return;
        }
        else
        {
            level.bombexploded += 1;
            destroyedobj thread [[ var_eb7099609db6a558 ]]( player, "explode", plantteam );
        }
    }
    else if ( game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "counter" )
    {
        shouldreturn = 0;
        
        if ( destroyedobj.bombdefused )
        {
            player notify( "bomb_defused" + destroyedobj.objectivekey );
            destroyedobj notify( #"defused" );
            destroyedobj gameobjects::allowuse( "enemy" );
            destroyedobj gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
            destroyedobj gameobjects::setusehinttext( &"mp/hold_to_plant_explosives" );
            destroyedobj.id = "bomb_zone";
            destroyedobj gameobjects::setusetime( level.planttime );
            destroyedobj gameobjects::setvisibleteam( "any" );
            var_a19766e6fe59d7cf = level.gametypebundle.bombweapon ?? "briefcase_bomb_mp";
            destroyedobj.useweapon = makeweapon( var_a19766e6fe59d7cf );
            destroyedobj.bombexploded = undefined;
            
            if ( game_utility::getgametype() != "counter" )
            {
                destroyedobj.onuse = &bombzone_onuseplantobject;
            }
            
            shouldreturn = 1;
        }
        else
        {
            if ( isdefined( level.var_13d81b4887ce5b8b ) )
            {
                destroyedobj [[ level.var_13d81b4887ce5b8b ]]( plantteam );
            }
            
            defuseobject.showprogressforteam = undefined;
            level.bombexploded += 1;
        }
        
        level.bombsplanted--;
        level.var_5897b98addb7dbdd[ plantteam ]--;
        var_c158c6c9c6882fd6 = getteamscore( plantteam ) + level.var_5897b98addb7dbdd[ plantteam ];
        otherteam = team_utility::getotherteam( plantteam );
        otherteamscore = getteamscore( otherteam );
        scorediff = var_c158c6c9c6882fd6 - otherteamscore;
        
        if ( level.bombsplanted == 0 || scorediff < 0 )
        {
            level.timelimitoverride = 0;
        }
        
        if ( shouldreturn )
        {
            return;
        }
    }
    else
    {
        level.bombexploded += 1;
    }
    
    if ( game_utility::getgametype() == "cmd" )
    {
        level waittill( #"allow_bomb_explosion" );
    }
    
    setomnvar( "ui_victory_condition_completed", 1 );
    level notify( "bomb_exploded" + destroyedobj.objectivekey );
    player thread rank::function_d2aa8986c506e985( #"detonate" );
    player thread points::doscoreevent( #"mode_sd_detonate" );
    
    if ( isdefined( level.sd_onbombtimerend ) )
    {
        level thread [[ level.sd_onbombtimerend ]]();
    }
    
    if ( game_utility::getgametype() == "cmd" || game_utility::getgametype() == "gwbomb" )
    {
        explosionorigin = destroyedobj.curorigin;
    }
    else if ( game_utility::getgametype() == "dd" || game_utility::getgametype() == "btm" || game_utility::getgametype() == "counter" )
    {
        explosionorigin = level.ddbombmodel[ destroyedobj.objectivekey ].origin;
        level.ddbombmodel[ destroyedobj.objectivekey ] delete();
    }
    else
    {
        explosionorigin = level.sdbombmodel.origin;
        level.sdbombmodel delete();
    }
    
    if ( !isdefined( destroyedobj.visuals[ 0 ] ) )
    {
        originent = destroyedobj.trigger;
    }
    else
    {
        originent = destroyedobj.visuals[ 0 ];
    }
    
    damageoriginbase = originent.origin + ( 0, 0, 60 );
    attackerent = player ?? undefined;
    
    if ( isdefined( originent ) && game_utility::getgametype() == "counter" )
    {
        originent radiusdamage( damageoriginbase, 512, 200, 20, attackerent, "MOD_EXPLOSIVE", "bomb_site_mp" );
    }
    else
    {
        damageoriginoffset = anglestoright( originent.angles ) * 24;
        damageorigin1 = damageoriginbase + damageoriginoffset;
        damageorigin2 = damageoriginbase - damageoriginoffset;
        radiusdamage( damageorigin1, 512, 200, 20, attackerent, "MOD_EXPLOSIVE", "bomb_site_mp" );
        radiusdamage( damageorigin2, 512, 200, 20, attackerent, "MOD_EXPLOSIVE", "bomb_site_mp" );
    }
    
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", destroyedobj.objectivekey, "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    
    if ( isdefined( player ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "destructions" ] ) )
            {
                player.leaderboarddata[ "destructions" ] = player.leaderboarddata[ "destructions" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "destructions" ] ) )
            {
                [[ level.leaderboardfunc[ "destructions" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "destructions" ] ) )
            {
                player.pers[ "destructions" ] = player.pers[ "destructions" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "destructions", player.pers[ "destructions" ] );
    }
    
    if ( isdefined( destroyedobj.trigger.effect ) )
    {
        effect = destroyedobj.trigger.effect;
    }
    else if ( level.mapname == "mp_faridah" )
    {
        effect = "faridah_bomb_explosion";
    }
    else
    {
        effect = "bomb_explosion";
    }
    
    if ( game_utility::getgametype() == "counter" )
    {
    }
    else if ( isdefined( destroyedobj.scriptable ) )
    {
        destroyedobj.scriptable setscriptablepartstate( "vfx", "detonate" );
    }
    else
    {
        explosioneffect = spawnfx( utility::getfx( effect ), explosionorigin );
        triggerfx( explosioneffect );
    }
    
    physicsexplosionsphere( explosionorigin, 200, 100, 3 );
    playrumbleonposition( "grenade_rumble", explosionorigin );
    earthquake( 0.5, 2, explosionorigin, 2000 );
    gameplay_sound_fx::function_28103d3430792dce( explosionorigin, #"hash_4eea242232ed196b" );
    
    if ( game_utility_mp::getbasegametype() == "sd" )
    {
        if ( teams::getteamdata( game[ "attackers" ], "aliveCount" ) > 0 )
        {
            dialog::statusdialog( "attacking_bombgoesoff", game[ "attackers" ], "status" );
            dialog::statusdialog( "defending_bombgoesoff", game[ "defenders" ], "status" );
        }
        else
        {
            dialog::statusdialog( "attacking_bombgoesoff_alldead", game[ "attackers" ], "status" );
            dialog::statusdialog( "defending_bombgoesoff", game[ "defenders" ], "status" );
        }
    }
    
    if ( isdefined( level.gametypebundle.var_76ff93e70747f1f6 ) )
    {
        if ( isdefined( destroyedobj.visuals[ 0 ] ) )
        {
            destroyedobj.visuals[ 0 ] setmodel( level.gametypebundle.var_76ff93e70747f1f6 );
        }
    }
    else if ( isdefined( destroyedobj.exploderindex ) && game_utility::getgametype() != "counter" )
    {
        utility::exploder( destroyedobj.exploderindex );
    }
    else if ( level.scriptedtriggers )
    {
        destroyedobj.trigger setmodel( "sd_equipment_bombsite_crate_d" );
    }
    
    defuseobject gameobjects::disableobject();
    
    if ( isdefined( level.onobjectivecomplete ) )
    {
        defuseobject [[ level.onobjectivecomplete ]]( "bombzone", defuseobject.objectivekey, player, plantteam, undefined );
    }
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x5e51ab87, Offset: 0x4348
// Size: 0x30
function function_df4449c14e7e2c42()
{
    switch ( level.mapname )
    {
        case #"hash_f379b47cec633c60":
            return 10;
        default:
            return 0;
    }
}

// Namespace obj_bombzone
// Params 3
// Checksum 0x882a0af, Offset: 0x4380
// Size: 0x1ee
function bombradialfill( plantteam, friendlyicon, enemyicon )
{
    level endon( #"game_ended" );
    self.var_76c0308f4e309c6 = 0;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    bombstarttime = function_db5303b5242dbfec() * 1000;
    addtime = updateratems / bombstarttime;
    self.radialtimeobjid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( self.radialtimeobjid != -1 )
    {
        objectivestate = "current";
        objidpoolmanager::objective_add_objective( self.radialtimeobjid, objectivestate, self.curorigin + self.offset3d );
        objidpoolmanager::function_e4d6a71507372662( self.radialtimeobjid, 0 );
        objidpoolmanager::objective_set_play_intro( self.radialtimeobjid, 0 );
        objidpoolmanager::objective_set_play_outro( self.radialtimeobjid, 0 );
        objidpoolmanager::objective_playermask_showtoall( self.radialtimeobjid );
        self.showworldicon = 1;
    }
    
    gameobjects::setobjectivestatusicons( friendlyicon, enemyicon, self.radialtimeobjid );
    self.bombplanted = 1;
    
    while ( self.bombplanted )
    {
        var_76c0308f4e309c6 = addtime;
        var_76c0308f4e309c6 = level.gametypebundle.var_e2ac0cf937c54ae6 ? 1 - var_76c0308f4e309c6 : var_76c0308f4e309c6;
        self.var_76c0308f4e309c6 = var_76c0308f4e309c6;
        objidpoolmanager::objective_set_progress_team( self.radialtimeobjid, plantteam );
        objidpoolmanager::objective_show_progress( self.radialtimeobjid, 1 );
        objidpoolmanager::objective_set_progress( self.radialtimeobjid, var_76c0308f4e309c6 );
        addtime = min( addtime + updateratems / bombstarttime, 1 );
        waitframe();
    }
    
    objidpoolmanager::returnobjectiveid( self.radialtimeobjid );
    
    if ( isdefined( self ) )
    {
        self.radialtimeobjid = -1;
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x5a46378, Offset: 0x4576
// Size: 0x1bf
function initobjectivecam( objective )
{
    camstart = undefined;
    startnodes = getentarray( "sd_bombcam_start", #targetname );
    
    foreach ( startnode in startnodes )
    {
        if ( startnode.script_label == objective.objectivekey )
        {
            camstart = startnode;
            break;
        }
    }
    
    campath = [];
    
    if ( isdefined( camstart ) && isdefined( camstart.target ) )
    {
        nextnode = getent( camstart.target, #targetname );
        
        while ( isdefined( nextnode ) )
        {
            campath[ campath.size ] = nextnode;
            
            if ( isdefined( nextnode.target ) )
            {
                nextnode = getent( nextnode.target, #targetname );
                continue;
            }
            
            break;
        }
    }
    
    if ( isdefined( camstart ) && campath.size )
    {
        cam = spawn( "script_model", camstart.origin );
        cam.origin = camstart.origin;
        cam.angles = camstart.angles;
        cam.path = campath;
        cam setmodel( "tag_origin" );
        cam hide();
        return cam;
    }
    
    return;
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x1699765d, Offset: 0x473d
// Size: 0x25c
function runobjectivecam()
{
    level notify( #"objective_cam" );
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            player player::_freezecontrols( 1 );
            player visionsetnakedforplayer( "black_bw", 0.5 );
        }
    }
    
    wait 0.5;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            player player::setusingremote( "objective_cam" );
            player val::set( "objective_cam", "weapon", 0 );
            player playerlinkweaponviewtodelta( self, "tag_player", 1, 180, 180, 180, 180, 1 );
            player player::_freezecontrols( 1 );
            player setplayerangles( self.angles );
            player visionsetnakedforplayer( "", 0.5 );
        }
    }
    
    for ( i = 0; i < self.path.size ; i++ )
    {
        acceltime = 0;
        
        if ( i == 0 )
        {
            acceltime = 5 / self.path.size / 2;
        }
        
        deceltime = 0;
        
        if ( i == self.path.size - 1 )
        {
            deceltime = 5 / self.path.size / 2;
        }
        
        self moveto( self.path[ i ].origin, 5 / self.path.size, acceltime, deceltime );
        self rotateto( self.path[ i ].angles, 5 / self.path.size, acceltime, deceltime );
        wait 5 / self.path.size;
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xa8a451e1, Offset: 0x49a1
// Size: 0x94
function bombtimerwait( objectivekey )
{
    level endon( #"game_ended" );
    level endon( #"bombs_canceled" );
    level endon( "bomb_defused" + objectivekey );
    bombtimerms = int( function_db5303b5242dbfec() * 1000 );
    var_fc65cde94aa01b65 = gettime() + bombtimerms;
    setomnvar( "ui_bomb_timer_endtime" + objectivekey, var_fc65cde94aa01b65 );
    thread updatetimerconstant( "ui_bomb_timer_endtime" + objectivekey, var_fc65cde94aa01b65, bombtimerms, objectivekey );
    level thread handlehostmigration( var_fc65cde94aa01b65, objectivekey );
    hostmigration::waitlongdurationwithgameendtimeupdate( function_db5303b5242dbfec() );
}

// Namespace obj_bombzone
// Params 4
// Checksum 0x51a18218, Offset: 0x4a3d
// Size: 0x88
function updatetimerconstant( omnvar, var_fc65cde94aa01b65, bombtimer, objectivekey )
{
    level endon( #"bombs_canceled" );
    level endon( "bomb_defused" + objectivekey );
    self.startbombtime = gettime();
    
    while ( gettime() < var_fc65cde94aa01b65 )
    {
        timepassed = gettime() - self.startbombtime;
        setomnvar( omnvar, int( gettime() + bombtimer - timepassed ) );
        waitframe();
    }
}

// Namespace obj_bombzone
// Params 2
// Checksum 0xb5a1f273, Offset: 0x4acd
// Size: 0x7d
function handlehostmigration( var_fc65cde94aa01b65, objectivekey )
{
    level endon( #"game_ended" );
    level endon( "bomb_defused" + objectivekey );
    level endon( #"disconnect" );
    level waittill( #"host_migration_begin" );
    setomnvar( "ui_bomb_timer_endtime" + objectivekey, 0 );
    timepassed = hostmigration::waittillhostmigrationdone();
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_bomb_timer_endtime" + objectivekey, var_fc65cde94aa01b65 + timepassed );
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x5a31030, Offset: 0x4b52
// Size: 0x14d
function bombdefused( sitedefused )
{
    if ( game_utility::getgametype() != "dd" && game_utility::getgametype() != "cmd" && game_utility::getgametype() != "btm" && game_utility::getgametype() != "gwbomb" && game_utility::getgametype() != "counter" )
    {
        level.bombdefused = 1;
    }
    
    sitedefused.bombdefused = 1;
    thread gameplay_sound_fx::function_28103d3430792dce( sitedefused.bombdefusetrig.origin, #"hash_8769b1710367a66e" );
    sitedefused.bombdefusetrig thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_7da5b9d6e8b60c6f", game[ "defenders" ] );
    sitedefused.bombdefusetrig thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_79f8d7d655ae8c3f", game[ "attackers" ] );
    setbombtimeromnvars();
    setomnvar( "ui_bomb_timer_endtime" + sitedefused.objectivekey, 0 );
    level notify( "bomb_defused" + sitedefused.objectivekey );
    
    if ( isdefined( level.onobjectivecomplete ) )
    {
        sitedefused [[ level.onobjectivecomplete ]]( "bombzone", sitedefused.objectivekey, undefined, game[ "defenders" ], sitedefused.ownerteam );
    }
}

// Namespace obj_bombzone
// Params 2
// Checksum 0xeb9bccc4, Offset: 0x4ca7
// Size: 0x120
function updatebombplantedomnvar( plantteam, objectivekey )
{
    if ( game_utility::getgametype() == "cmd" || game_utility::getgametype() == "counter" )
    {
        return;
    }
    
    if ( isdefined( plantteam ) )
    {
        teamvalue = plantteam == "allies" ? 2 : 1;
        setomnvar( "ui_bomb_owner_team", teamvalue );
        
        if ( isdefined( objectivekey ) )
        {
            setomnvar( "ui_bomb_owner_team" + objectivekey, teamvalue );
        }
    }
    
    if ( !level.var_72d9ef171a0bf089 )
    {
        if ( isdefined( level.aplanted ) )
        {
            if ( level.aplanted )
            {
                setomnvar( "ui_bomb_planted_a", 1 );
            }
            else
            {
                setomnvar( "ui_bomb_planted_a", 0 );
            }
        }
        
        if ( isdefined( level.bplanted ) )
        {
            if ( level.bplanted )
            {
                setomnvar( "ui_bomb_planted_b", 1 );
            }
            else
            {
                setomnvar( "ui_bomb_planted_b", 0 );
            }
        }
        
        if ( isdefined( level.cplanted ) )
        {
            if ( level.cplanted )
            {
                setomnvar( "ui_bomb_planted_c", 1 );
                return;
            }
            
            setomnvar( "ui_bomb_planted_c", 0 );
        }
    }
}

// Namespace obj_bombzone
// Params 2
// Checksum 0x7a6eeb80, Offset: 0x4dcf
// Size: 0x36
function setbombtimeromnvars( plantteam, objectivekey )
{
    updatebombplantedomnvar( plantteam, objectivekey );
    println( "<dev string:x4a>" + level.bombsplanted );
}

// Namespace obj_bombzone
// Params 2
// Checksum 0xc83a8433, Offset: 0x4e0d
// Size: 0x4d4
function bombzone_setupbombcase( bombname, overrideorigin )
{
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombexploded = 0;
    trigger = undefined;
    trigger = getent( bombname + "_pickup_trig", #targetname );
    
    if ( !isdefined( trigger ) )
    {
        var_7ed17c62e2a23908 = utility::getstruct( "sd_bomb_spawn", "script_noteworthy" );
        
        if ( isdefined( var_7ed17c62e2a23908 ) )
        {
            trigger = spawn( "trigger_radius", utility::drop_to_ground( var_7ed17c62e2a23908.origin, 10, -100 ), 0, 32, 32 );
            trigger.angles = var_7ed17c62e2a23908.angles;
        }
        else
        {
            utility::error( "No " + bombname + "_pickup_trig trigger found in map." );
            return;
        }
    }
    
    if ( isdefined( overrideorigin ) )
    {
        trigger.origin = overrideorigin;
    }
    
    visuals[ 0 ] = getent( bombname, #targetname );
    
    if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 || !isdefined( visuals[ 0 ] ) )
    {
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        bombcase = getent( bombname, #targetname );
        
        if ( isdefined( bombcase ) )
        {
            bombcase delete();
        }
        
        if ( !isdefined( visuals[ 0 ] ) )
        {
            utility::error( "No " + bombname + " script_model found in map." );
            return;
        }
    }
    
    if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
    {
        bombscriptable = level.gametypebundle.var_d1162ca2bd70222a ?? "offhand_2h_wm_briefcase_bomb_v0";
        visuals[ 0 ].scriptable = spawnscriptable( bombscriptable, trigger.origin + ( 0, 0, 2 ), ( 0, 0, 0 ) );
        
        if ( game[ "attackers" ] == "allies" )
        {
            visuals[ 0 ].scriptable setscriptablepartstate( "bomb", "neutralAllies" );
        }
        else
        {
            visuals[ 0 ].scriptable setscriptablepartstate( "bomb", "neutralAxis" );
        }
    }
    else
    {
        var_799e7f2bcc0d8584 = level.gametypebundle.var_799e7f2bcc0d8584 ?? "offhand_2h_wm_briefcase_bomb_v0";
        visuals[ 0 ] setmodel( var_799e7f2bcc0d8584 );
    }
    
    visuals[ 0 ] setnonstick( 1 );
    visuals[ 0 ] = getadjustedfirstroundbombcaseposition( visuals[ 0 ] );
    trigger = getadjustedfirstroundbombcaseposition( trigger, 1 );
    
    if ( !level.multibomb )
    {
        level.sdbomb = gameobjects::createcarryobject( game[ "attackers" ], trigger, visuals, ( 0, 0, 32 ), undefined, 1 );
        level.sdbomb gameobjects::allowcarry( "friendly" );
        level.sdbomb.allowweapons = 1;
        level.sdbomb.requireslos = 1;
        level.sdbomb.onpickup = &onpickup;
        level.sdbomb.ondrop = &ondrop;
        level.sdbomb.firstpickup = 1;
        level.sdbomb gameobjects::registercarryobjectpickupcheck( &bombpickupchecks );
        level thread bombsitewatcher();
        level.bombrespawnpoint = level.sdbomb.visuals[ 0 ].origin;
        level.bombrespawnangles = level.sdbomb.visuals[ 0 ].angles;
        level.sdbomb.visualgroundoffset = ( 0, 0, 0 );
        level.sdbomb.visuals[ 0 ] setentityhudoutlinedata( 1, game[ "attackers" ] );
        dlog_recordevent( "dlog_event_mp_objective_status", [ "key", "bomb", "match_time_ms", gettime(), "is_active", 1 ] );
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", level.sdbomb.trigger.origin[ 0 ], "pos_y", level.sdbomb.trigger.origin[ 1 ], "key", "bomb", "match_time_ms", gettime() ] );
        return;
    }
    
    trigger delete();
    visuals[ 0 ] delete();
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xef4829f3, Offset: 0x52e9
// Size: 0x33, Type: bool
function bombpickupchecks( player )
{
    if ( player.isjuggernaut )
    {
        return istrue( player.juggcontext.var_80684ddb68796647 );
    }
    
    return true;
}

// Namespace obj_bombzone
// Params 2
// Checksum 0xba12c6f5, Offset: 0x5325
// Size: 0x213
function getadjustedfirstroundbombcaseposition( ent, istrigger )
{
    origin = ( 0, 0, 0 );
    angles = ( 0, 90, 0 );
    
    switch ( level.mapname )
    {
        case #"hash_f09747c9feb47eb1":
            if ( flags::gameflag( "infil_will_run" ) && game[ "roundsPlayed" ] == 0 )
            {
                origin = ( -518, -959, 267 );
            }
            
            break;
        case #"hash_1ab428ea9c0ee9e5":
            origin = ( 263, -2500, 146 );
            break;
        case #"hash_3e552e81b4a21fff":
        case #"hash_3e6dceebd27fedec":
        case #"hash_5586b38644ed9b26":
        case #"hash_6210b3e419ba7028":
        case #"hash_62644ed2dea5cf54":
        case #"hash_7709127773d7af61":
        case #"hash_7e7b98f5c7f2b9a0":
        case #"hash_a11e6e81ea219453":
        case #"hash_a9b94844236a7fd8":
        case #"hash_c8b70146f0c8a9cd":
        case #"hash_d707e2cfc340c376":
        case #"hash_decd2e8ff1f996d7":
        case #"hash_ec2ebc1298ef7373":
            if ( isdefined( level.var_3b3162c1b490db9e ) )
            {
                bombcase = utility::getstruct( level.var_3b3162c1b490db9e.str_sd_bomb_spawn, "script_noteworthy" );
            }
            else
            {
                bombcase = utility::getstruct( "sd_bomb_spawn", "script_noteworthy" );
            }
            
            if ( isdefined( bombcase ) )
            {
                origin = utility::drop_to_ground( bombcase.origin, 10, -10 );
                angles = bombcase.angles;
            }
            else
            {
                assertmsg( "<dev string:x5a>" );
            }
            
            break;
        default:
            return ent;
    }
    
    if ( istrigger )
    {
        ent.origin = origin;
    }
    else
    {
        ent.origin = origin;
        ent.angles = angles;
    }
    
    return ent;
}

// Namespace obj_bombzone
// Params 2
// Checksum 0x4ef6db58, Offset: 0x5541
// Size: 0x1b4
function movebombcase( newpos, newangles )
{
    if ( isdefined( level.sdbomb ) )
    {
        level.sdbomb.trigger.origin = newpos;
        level.sdbomb.visuals[ 0 ].origin = newpos;
        level.sdbomb.visuals[ 0 ].angles = newangles;
        level.sdbomb.visuals[ 0 ] show();
        level.sdbomb gameobjects::allowcarry( "friendly" );
        level.sdbomb gameobjects::setobjectivestatusicons( "waypoint_bomb" );
        level.sdbomb gameobjects::setvisibleteam( "friendly" );
        level.sdbomb.allowweapons = 1;
        level.sdbomb.onpickup = &onpickup;
        level.sdbomb.ondrop = &ondrop;
        dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", level.sdbomb.trigger.origin[ 0 ], "pos_y", level.sdbomb.trigger.origin[ 1 ], "key", "bomb", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    }
}

// Namespace obj_bombzone
// Params 0
// Checksum 0xd1249ae6, Offset: 0x56fd
// Size: 0x5c
function bombsitewatcher()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"bomb_carrier_changed", player, iscarrying );
        assert( isdefined( iscarrying ) );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( iscarrying )
        {
            thread function_6b6f85bdc00eef54( player );
        }
    }
}

// Namespace obj_bombzone
// Params 1, eflags: 0xc
// Checksum 0x9f633c72, Offset: 0x5761
// Size: 0x175
function private function_6b6f85bdc00eef54( player )
{
    self notify( #"hash_7ee3bde2b949e3fa" );
    self endon( #"hash_7ee3bde2b949e3fa" );
    assert( isdefined( player ) );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( player.isbombcarrier )
    {
        foreach ( bombzone in level.objectives )
        {
            if ( bombzone bombzone_usecondition( player ) )
            {
                bombzone.trigger enableplayeruse( player );
                continue;
            }
            
            bombzone.trigger disableplayeruse( player );
        }
        
        waitframe();
    }
    
    foreach ( bombzone in level.objectives )
    {
        bombzone.trigger disableplayeruse( player );
    }
}

// Namespace obj_bombzone
// Params 3
// Checksum 0x5cf07083, Offset: 0x58de
// Size: 0x2ef
function onpickup( player, playervo, defused )
{
    silentpickup = player.var_5d485b75f2e7d627 < gettime() + 1000;
    player.isbombcarrier = 1;
    
    if ( isplayer( player ) )
    {
        telemetry_data = spawnstruct();
        telemetry_data.player = player;
        telemetry_data.eventname = "pickup";
        telemetry_data.position = player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        codcaster_utils::function_3038b6eafc46c037( 1, player.team, player getentitynumber() );
        player dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 1, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    }
    
    player setclientomnvar( "ui_hud_carried_item_count", 1 );
    player setclientomnvar( "ui_carry_object_can_drop", 0 );
    player setclientomnvar( "ui_carrying_bomb", 1 );
    setomnvar( "ui_bomb_carrier", player getentitynumber() );
    self.offset3d = ( 0, 0, 75 );
    
    if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
    {
        level.sdbombmodel linkto( player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        level.sdbombmodel.scriptable utility::scriptable_setparententity( player );
        
        if ( game[ "attackers" ] == "allies" )
        {
            level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "carriedAllies" );
        }
        else
        {
            level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "carriedAxis" );
        }
    }
    
    gameobjects::setobjectivestatusicons( "icon_waypoint_escort_bomb", "codcaster_enemy_escort_bomb" );
    
    if ( isdefined( level.sd_loadout[ player.team ] ) )
    {
        player thread applybombcarrierclass();
    }
    
    if ( !silentpickup )
    {
        thread function_56124c4d4b643386( player );
    }
    
    if ( !level.bombdefused )
    {
        if ( !silentpickup )
        {
            thread hud_util::function_ddf9cb7f151d8d96( player, "callout_bombpickup", "callout_bombpickup_team", "" );
        }
        
        if ( self.firstpickup )
        {
            self.firstpickup = 0;
        }
    }
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
    
    level notify( #"bomb_carrier_changed", player, 1 );
    dialog_utility::function_7162cf91018ef73e( #"bomb_taken", player.team );
    dialog_utility::function_7162cf91018ef73e( #"bomb_enemy", team_utility::getotherteam( player.team ) );
}

// Namespace obj_bombzone
// Params 1, eflags: 0x4
// Checksum 0xa781cfbf, Offset: 0x5bd5
// Size: 0x129
function private function_56124c4d4b643386( player )
{
    self notify( #"hash_58f17837eecadefa" );
    self endon( #"hash_58f17837eecadefa" );
    self endon( #"dropped" );
    level endon( #"game_ended" );
    
    if ( isdefined( player ) )
    {
        team = player.pers[ "team" ];
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_45ed9d2dc808c021", teams::getteamdata( game[ "attackers" ], "players" ) );
        player gameplay_sound_fx::playlocalsoundfx( #"hash_445c2e12e8415bb8" );
        
        if ( !level.bombdefused )
        {
            waittime = getdvarfloat( @"hash_e5a5bd503d175ec4", 0.5 );
            
            if ( waittime > 0 )
            {
                wait waittime;
            }
            
            if ( !level.gameended )
            {
                var_83c21091abe057b2 = "bomb_pickup";
                
                if ( self.firstpickup )
                {
                    var_83c21091abe057b2 = "bomb_pickup_first";
                }
                
                excludelist = [];
                
                if ( isdefined( player ) )
                {
                    excludelist[ excludelist.size ] = player;
                    level thread playerdelayedvo( player, var_83c21091abe057b2 );
                }
                
                if ( isdefined( team ) )
                {
                    level thread teamdelayedvo( team, excludelist );
                }
            }
        }
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xeced4b41, Offset: 0x5d06
// Size: 0x255
function ondrop( player )
{
    level notify( #"bomb_carrier_changed", player, 0 );
    setomnvar( "ui_bomb_carrier", -1 );
    self.offset3d = ( 0, 0, 32 );
    
    if ( level.codcasterenabled )
    {
        if ( isdefined( player ) )
        {
            player setgametypevip( 0 );
        }
    }
    
    if ( getdvarint( @"scr_sd_scriptable_bomb", 0 ) == 1 )
    {
        level.sdbombmodel unlink();
        level.sdbombmodel.scriptable utility::scriptable_clearparententity();
        
        if ( game[ "attackers" ] == "allies" )
        {
            level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "neutralAllies" );
        }
        else
        {
            level.sdbombmodel.scriptable setscriptablepartstate( "bomb", "neutralAxis" );
        }
    }
    
    gameobjects::setobjectivestatusicons( "waypoint_bomb" );
    
    if ( isdefined( player ) )
    {
        player.isbombcarrier = 0;
    }
    
    function_a92e905350282a3a( player );
    
    if ( !level.bombplanted )
    {
        silentdrop = self.var_5d485b75f2e7d627 < gettime() + 1000;
        
        if ( !silentdrop )
        {
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_4f0ce2b06571f8b2", teams::getteamdata( game[ "attackers" ], "players" ) );
        }
        
        if ( level.bombresettimer > 0 )
        {
            thread waitforbombreset( level.bombresettimer );
        }
        
        if ( isdefined( player ) )
        {
            matchtimems = matchdata::function_47550968a937b67e( gettime() );
            player dlog_recordplayerevent( "dlog_event_mp_objective_link_player", [ "key", "bomb", "is_linked", 0, "match_time_ms", matchtimems ] );
            dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", player.origin[ 0 ], "pos_y", player.origin[ 1 ], "key", "bomb", "match_time_ms", matchtimems ] );
        }
        
        dialog_utility::function_7162cf91018ef73e( #"bomb_drop", player.team );
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x6459dc12, Offset: 0x5f63
// Size: 0x1d4
function function_a92e905350282a3a( player )
{
    if ( level.gametypebundle.var_a8a836b1c7b75c16 )
    {
        var_707a164c7102402f = arraycombine( level.outofboundstriggers, level.hurttriggers );
        
        foreach ( trigger in var_707a164c7102402f )
        {
            if ( ispointinvolume( self.curorigin, trigger ) )
            {
                gameobjects::returnhome();
            }
        }
        
        return;
    }
    
    if ( !isdefined( player ) )
    {
        gameobjects::returnhome();
        return;
    }
    
    foreach ( hurttrigger in level.hurttriggers )
    {
        if ( player istouching( hurttrigger ) )
        {
            gameobjects::returnhome();
            return;
        }
    }
    
    foreach ( oobtrigger in level.outofboundstriggers )
    {
        if ( player istouching( oobtrigger ) )
        {
            gameobjects::returnhome();
            return;
        }
    }
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xfdc728e0, Offset: 0x613f
// Size: 0x71
function waitforbombreset( timelimit )
{
    level endon( #"game_ended" );
    level endon( #"bomb_carrier_changed" );
    wait timelimit;
    weapons::equipmentdeletevfx( self.visuals[ 0 ].origin, self.visuals[ 0 ].angles );
    movebombcase( level.bombrespawnpoint, level.bombrespawnangles );
}

// Namespace obj_bombzone
// Params 0
// Checksum 0xecd95124, Offset: 0x61b8
// Size: 0xc6
function enablemultibombui()
{
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            player setclientomnvar( "ui_hud_carried_item_count", player.pers[ "team" ] == game[ "attackers" ] );
            player setclientomnvar( "ui_carrying_bomb", player.pers[ "team" ] == game[ "attackers" ] );
        }
    }
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x10eb4a71, Offset: 0x6286
// Size: 0x40
function respawnbombcase()
{
    level endon( #"game_ended" );
    wait 5;
    
    if ( level.multibomb )
    {
        enablemultibombui();
        return;
    }
    
    movebombcase( level.bombrespawnpoint, level.bombrespawnangles );
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x8d427c5c, Offset: 0x62ce
// Size: 0xa3
function advancebombcase()
{
    level.bombplanted = 0;
    level.bombdefused = 0;
    level.bombrespawnpoint = level.curobj.visuals[ 0 ].origin + ( 0, 0, 48 );
    level.bombrespawnangles = level.curobj.visuals[ 0 ].angles;
    
    if ( level.multibomb )
    {
        enablemultibombui();
        return;
    }
    
    movebombcase( level.bombrespawnpoint, level.bombrespawnangles );
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x30da6d2d, Offset: 0x6379
// Size: 0xd2
function applybombcarrierclass()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self.iscarrying == 1 )
    {
        self notify( #"force_cancel_placement" );
        waitframe();
    }
    
    while ( self ismantling() )
    {
        waitframe();
    }
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.pers[ "gamemodeLoadout" ] = level.sd_loadout[ self.team ];
    playerlogic::spawnpoint_setspawnpoint( self.origin, self.angles );
    self.gamemode_chosenclass = self.class;
    class::function_e84a99f0f4904c66();
    self notify( #"faux_spawn" );
    self.gameobject_fauxspawn = 1;
    self.faux_spawn_stance = self getstance();
    thread playerlogic::spawnplayer( 1 );
}

// Namespace obj_bombzone
// Params 0
// Checksum 0x724f40a9, Offset: 0x6453
// Size: 0x9a
function removebombcarrierclass()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self.iscarrying == 1 )
    {
        self notify( #"force_cancel_placement" );
        waitframe();
    }
    
    while ( self ismantling() )
    {
        waitframe();
    }
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.pers[ "gamemodeLoadout" ] = undefined;
    playerlogic::spawnpoint_setspawnpoint( self.origin, self.angles );
    self notify( #"faux_spawn" );
    self.faux_spawn_stance = self getstance();
    thread playerlogic::spawnplayer( 1 );
}

// Namespace obj_bombzone
// Params 2
// Checksum 0x4083dce6, Offset: 0x64f5
// Size: 0x239
function bombzone_awardgenericbombzonemedals( attacker, victim )
{
    foreach ( bombzone in level.objectives )
    {
        if ( !isdefined( bombzone.bombdefusetrig.origin ) )
        {
            continue;
        }
        
        planted = istrue( bombzone.bombplanted );
        passed = distsquaredcheck( attacker.origin, victim.origin, planted ? bombzone.bombdefusetrig.origin : bombzone.trigger.origin );
        
        if ( passed )
        {
            if ( game_utility::getgametype() == "dd" && game_utility_mp::inovertime() )
            {
                if ( attacker.team == bombzone.ownerteam )
                {
                    attacker thread rank::function_d2aa8986c506e985( planted ? #"defend" : #"assault" );
                    
                    if ( planted )
                    {
                        attacker events::function_20a5f572df6afd43();
                    }
                    else
                    {
                        attacker events::function_58da673c1c3fc9f2();
                    }
                }
                else
                {
                    attacker thread rank::function_d2aa8986c506e985( #"assault" );
                    attacker events::function_58da673c1c3fc9f2();
                }
                
                continue;
            }
            
            if ( victim.team == game[ "defenders" ] )
            {
                attacker thread rank::function_d2aa8986c506e985( planted ? #"defend" : #"assault" );
                
                if ( planted )
                {
                    attacker events::function_20a5f572df6afd43();
                }
                else
                {
                    attacker events::function_58da673c1c3fc9f2();
                }
                
                continue;
            }
            
            attacker thread rank::function_d2aa8986c506e985( planted ? #"assault" : #"defend" );
            
            if ( planted )
            {
                attacker events::function_20a5f572df6afd43();
                continue;
            }
            
            attacker events::function_58da673c1c3fc9f2();
        }
    }
}

// Namespace obj_bombzone
// Params 3
// Checksum 0xe8f898ce, Offset: 0x6736
// Size: 0x61
function distsquaredcheck( attackerpos, victimpos, checkpos )
{
    attackerdistsq = distancesquared( checkpos, attackerpos );
    victimdistsq = distancesquared( checkpos, victimpos );
    
    if ( attackerdistsq < 90000 || victimdistsq < 90000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x160f9d72, Offset: 0x679f
// Size: 0x26, Type: bool
function function_365d59ee57141af7( player )
{
    if ( player::isinlaststand( player ) )
    {
        return false;
    }
    
    if ( player isswimming() )
    {
        return false;
    }
    
    return true;
}

// Namespace obj_bombzone
// Params 2
// Checksum 0x7fa30540, Offset: 0x67ce
// Size: 0x72
function playerdelayedvo( player, var_83c21091abe057b2 )
{
    normalizedtimepassed = game_utility::gettimepassed() / 1000;
    
    if ( level.infilvotiming )
    {
        delaytime = 8;
    }
    else
    {
        delaytime = 5;
    }
    
    waittime = delaytime - normalizedtimepassed;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( isdefined( player ) )
    {
        player dialog::leaderdialogonplayer( var_83c21091abe057b2 );
    }
}

// Namespace obj_bombzone
// Params 2
// Checksum 0x33a3ef40, Offset: 0x6848
// Size: 0x77
function teamdelayedvo( team, excludelist )
{
    normalizedtimepassed = game_utility::gettimepassed() / 1000;
    
    if ( level.infilvotiming )
    {
        delaytime = 8;
    }
    else
    {
        delaytime = 5;
    }
    
    waittime = delaytime - normalizedtimepassed;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    dialog::leaderdialog( "bomb_achieve", team, "bomb", excludelist );
}

/#

    // Namespace obj_bombzone
    // Params 0
    // Checksum 0x130e5d33, Offset: 0x68c7
    // Size: 0x3c2, Type: dev
    function function_b82862df868dcf76()
    {
        level endon( #"game_ended" );
        self notify( #"hash_188db3eeb1319724" );
        self endon( #"hash_188db3eeb1319724" );
        self endon( #"disconnect" );
        wait 5;
        
        while ( !level.bombplanted )
        {
            if ( getdvarint( @"scr_plant_allies", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:xe6>" )
                    {
                        if ( !level.multibomb )
                        {
                            level.sdbomb.safeorigin = level.sdbomb.trigger.origin;
                            level.sdbomb.carrier = p;
                            level.multibomb = 1;
                            waitframe();
                            level.sdbomb.stalemate = 0;
                        }
                        
                        foreach ( bombsite in level.objectives )
                        {
                            if ( bombsite.objectivekey == "<dev string:xed>" )
                            {
                                bombsite [[ bombsite.onuse ]]( p );
                                setdevdvar( @"scr_plant_allies", 0 );
                                break;
                            }
                        }
                        
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"scr_plant_axis", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:xf0>" )
                    {
                        level.sdbomb.safeorigin = level.sdbomb.trigger.origin;
                        level.sdbomb.carrier = p;
                        level.multibomb = 1;
                        waitframe();
                        level.sdbomb.stalemate = 0;
                        
                        foreach ( bombsite in level.objectives )
                        {
                            if ( bombsite.objectivekey == "<dev string:xed>" )
                            {
                                bombsite [[ bombsite.onuse ]]( p );
                                setdevdvar( @"scr_plant_axis", 0 );
                                break;
                            }
                        }
                        
                        break;
                    }
                }
            }
            
            wait 1;
        }
        
        level waittill( #"bomb_defused" );
        thread function_b82862df868dcf76();
    }

    // Namespace obj_bombzone
    // Params 0
    // Checksum 0x40fdb601, Offset: 0x6c91
    // Size: 0x202, Type: dev
    function function_cbff563b60d3e7cf()
    {
        level endon( #"game_ended" );
        self notify( #"hash_2ea2c62a82add2d9" );
        self endon( #"hash_2ea2c62a82add2d9" );
        self endon( #"disconnect" );
        wait 5;
        
        while ( level.bombplanted )
        {
            if ( getdvarint( @"scr_defuse_allies", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:xe6>" )
                    {
                        level.defuseobject [[ level.defuseobject.onuse ]]( p );
                        setdevdvar( @"scr_defuse_allies", 0 );
                        break;
                    }
                }
            }
            
            if ( getdvarint( @"scr_defuse_axis", 0 ) == 1 )
            {
                foreach ( p in level.players )
                {
                    if ( player::isreallyalive( p ) && p.team == "<dev string:xf0>" )
                    {
                        level.defuseobject [[ level.defuseobject.onuse ]]( p );
                        setdevdvar( @"scr_defuse_axis", 0 );
                        break;
                    }
                }
            }
            
            wait 1;
        }
        
        level waittill( #"bomb_planted" );
        thread function_cbff563b60d3e7cf();
    }

#/

// Namespace obj_bombzone
// Params 0
// Checksum 0x1330b344, Offset: 0x6e9b
// Size: 0x26
function resetuiomnvargamemode()
{
    self setclientomnvar( "ui_hud_carried_item_index", 0 );
    self setclientomnvar( "ui_hud_carried_item_count", 0 );
    self setclientomnvar( "ui_carrying_bomb", 0 );
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x8db26495, Offset: 0x6ec9
// Size: 0x3f
function setteaminhuddatafromteamname( teamname )
{
    if ( teamname == "axis" )
    {
        self setteaminhuddata( 1 );
        return;
    }
    
    if ( teamname == "allies" )
    {
        self setteaminhuddata( 2 );
        return;
    }
    
    self setteaminhuddata( 0 );
}

// Namespace obj_bombzone
// Params 1
// Checksum 0xc7cc9cbe, Offset: 0x6f10
// Size: 0x74
function function_d1efa73146066748( bombzone )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    bombzone endon( #"death" );
    self setentityhudoutlinedata( 1, game[ "defenders" ] );
    level waittill( #"bomb_planted" );
    
    if ( bombzone.bombplanted )
    {
        self setentityhudoutlinedata( 1, game[ "attackers" ] );
        return;
    }
    
    self setentityhudoutlinedata( 0 );
}

// Namespace obj_bombzone
// Params 1
// Checksum 0x41ff6e44, Offset: 0x6f8c
// Size: 0x239
function function_9e7f06255372863e( isplanting )
{
    self endon( #"death_or_disconnect", #"hash_2bd3c16fbd14b0bd" );
    var_63bf6286dc19fec4 = #"sd_bomb_screen_planting";
    var_af1a35bcbccb089e = #"sd_bomb_screen_defusing";
    partname = isplanting ? var_63bf6286dc19fec4 : var_af1a35bcbccb089e;
    
    if ( !self getscriptablehaspart( partname ) )
    {
        return;
    }
    
    wait 0.7;
    
    if ( isplanting )
    {
        self setscriptablepartstate( partname, #"start" );
        wait 1.18;
        self setscriptablepartstate( partname, #"press_1" );
        wait 0.2;
        self setscriptablepartstate( partname, #"press_2" );
        wait 0.5;
        self setscriptablepartstate( partname, #"press_3" );
        wait 0.35;
        self setscriptablepartstate( partname, #"press_4" );
        wait 0.4;
        self setscriptablepartstate( partname, #"press_5" );
        wait 0.4;
        self setscriptablepartstate( partname, #"press_6" );
        wait 0.35;
        self setscriptablepartstate( partname, #"press_7" );
        wait 0.3;
        self setscriptablepartstate( partname, #"press_8" );
        wait 0.35;
        self setscriptablepartstate( partname, #"press_9" );
        return;
    }
    
    self setscriptablepartstate( partname, #"start" );
    wait 0.4;
    self setscriptablepartstate( partname, #"press_1" );
    wait 0.2;
    self setscriptablepartstate( partname, #"press_2" );
    wait 0.5;
    self setscriptablepartstate( partname, #"press_3" );
    wait 0.35;
    self setscriptablepartstate( partname, #"press_4" );
    wait 0.4;
    self setscriptablepartstate( partname, #"press_5" );
    wait 0.4;
    self setscriptablepartstate( partname, #"press_6" );
    wait 0.35;
    self setscriptablepartstate( partname, #"press_7" );
    wait 0.3;
    self setscriptablepartstate( partname, #"press_8" );
    wait 0.35;
    self setscriptablepartstate( partname, #"press_9" );
}

/#

    // Namespace obj_bombzone
    // Params 1
    // Checksum 0xfb966afd, Offset: 0x71cd
    // Size: 0x1d3, Type: dev
    function debugkillcament( visual )
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        visual endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_3f3a15fb7e7c9b0" ) > 0 )
            {
                line( self.origin, self.origin + anglestoforward( self.angles ) * 10, ( 1, 0, 0 ) );
                line( self.origin, self.origin + anglestoright( self.angles ) * 10, ( 0, 1, 0 ) );
                line( self.origin, self.origin + anglestoup( self.angles ) * 10, ( 0, 0, 1 ) );
                line( visual.origin + ( 0, 0, 5 ), self.origin, ( 0, 0, 1 ) );
                line( visual.origin, visual.origin + anglestoforward( visual.angles ) * 10, ( 1, 0, 0 ) );
                line( visual.origin, visual.origin + anglestoright( visual.angles ) * 10, ( 0, 1, 0 ) );
                line( visual.origin, visual.origin + anglestoup( visual.angles ) * 10, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

#/
