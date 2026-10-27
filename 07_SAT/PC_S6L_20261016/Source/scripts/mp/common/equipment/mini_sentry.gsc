// scripts\mp\common\equipment\mini_sentry.gsc  (hash_2c52716c770ac80c.gscc) (size: 17879 Bytes / 0x45d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x147e0607 (343803399)
// size ...... 17879 (0x45d7)
// includes .. 23  (offset: 0x434b)
// strings ... 27  (offset: 0x4403)
// dev strs .. 4   (offset: 0x45a7)
// exports ... 43  (offset: 0x2863)
// cseg ...... 0x254 + 0x260f (0x2863)
// imports ... 173 (offset: 0x2f1b)
// animtree1 . 0   (offset: 0x45d7)
// animtree2 . 0   (offset: 0x45d7)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\weapons;

#namespace mini_sentry;

// Namespace mini_sentry
// Params 0, eflags: 0x5
// Checksum 0x10e61bd6, Offset: 0x272
// Size: 0x6c
function private autoexec preinit_mini_sentry()
{
    level callback::add( "init_grenade", &init );
    level callback::add( #"player_damaged", &on_player_damaged );
    level callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    level callback::add( #"hash_2709fd1dd4cef88d", &function_38cf8364e4d8e652 );
    level callback::add( #"hash_eb54ccc016130a88", &on_player_elim );
}

// Namespace mini_sentry
// Params 1
// Checksum 0x8f3cbea6, Offset: 0x2e6
// Size: 0x13e
function init( params )
{
    weapons::registerusedcallback( #"mini_sentry", &used );
    utility::registersharedfunc( #"mini_sentry", #"hack", &mini_sentry_hack );
    utility::registersharedfunc( #"mini_sentry", #"spawn_directly", &function_89f707e20802847 );
    utility::registersharedfunc( #"mini_sentry", #"destroy", &on_destruction );
    utility::registersharedfunc( #"mini_sentry", #"watch_for_landing", &watch_for_landing );
    tableinfo = weapon::getequipmenttableinfo( "equip_mini_sentry" );
    bundle = tableinfo.bundle;
    level thread register_on_kill_medal( bundle.var_aaf67e9cf3144f71, bundle.var_755d79c556cea859, bundle.var_ae2654ce2b54cb04 );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customend:1, #customstart:1, #customhit:1, #equipref:"equip_mini_sentry" } );
    thread equipmentinteractinit();
}

// Namespace mini_sentry
// Params 0
// Checksum 0x8b821347, Offset: 0x42c
// Size: 0x9b
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_mini_sentry" ].bundle;
    
    if ( !bundle.equipmentinteractions )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_mini_sentry" ), #"interactdisable", &equipment_interact_disable );
    utility::registersharedfunc( getxhash( "equip_mini_sentry" ), #"interactenable", &equipment_interact_enable );
    utility::registersharedfunc( getxhash( "equip_mini_sentry" ), #"interactdestroy", &on_destruction );
}

// Namespace mini_sentry
// Params 1
// Checksum 0x9a15978b, Offset: 0x4cf
// Size: 0x1f
function equipment_interact_disable( data )
{
    self.isjammed = 1;
    updatedisable( self );
}

// Namespace mini_sentry
// Params 1
// Checksum 0x6397ce5a, Offset: 0x4f6
// Size: 0x1e
function equipment_interact_enable( data )
{
    self.isjammed = undefined;
    updatedisable( self );
}

// Namespace mini_sentry
// Params 6, eflags: 0x4
// Checksum 0x8b5f9018, Offset: 0x51c
// Size: 0xb3
function private function_89f707e20802847( player, turret_type, origin, angles, var_3ec7444e5bce7d0a, should_destroy_on_timeout )
{
    var_6f52b311a125f260 = player launchgrenade( turret_type, origin, ( 0, 0, 0 ), 0 );
    
    if ( var_6f52b311a125f260 )
    {
        var_6f52b311a125f260.team_override = var_3ec7444e5bce7d0a;
        var_6f52b311a125f260.destroy_on_timeout = should_destroy_on_timeout;
        var_6f52b311a125f260.origin_override = origin;
        var_6f52b311a125f260.angles_override = angles;
    }
    else
    {
        assertmsg( "<dev string:x24>" + turret_type + "<dev string:x46>" );
    }
    
    return var_6f52b311a125f260;
}

// Namespace mini_sentry
// Params 1
// Checksum 0x27d2d2b9, Offset: 0x5d8
// Size: 0x7a
function used( grenade )
{
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    grenade.owner = self;
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x48>" );
    }
    
    grenade thread watch_for_landing();
}

// Namespace mini_sentry
// Params 3
// Checksum 0x907e6cb7, Offset: 0x65a
// Size: 0xa1
function function_eccae5899c99c584( turret_position, grenade_throw_position, grenade_angles )
{
    grenade_up = anglestoup( grenade_angles );
    var_d5532d894994bcc1 = turret_position - grenade_throw_position;
    flattened_direction = vectornormalize( ( var_d5532d894994bcc1[ 0 ], var_d5532d894994bcc1[ 1 ], 0 ) );
    turret_up = grenade_up * -1;
    turret_right = vectorcross( turret_up, flattened_direction );
    turret_forward = vectorcross( turret_right, turret_up );
    turret_angles = axistoangles( turret_forward, turret_right, turret_up );
    return turret_angles;
}

// Namespace mini_sentry
// Params 4
// Checksum 0xf128d021, Offset: 0x704
// Size: 0x77
function function_86a041114a8f6953( grenade_angles, floor_turret_weapon, wall_turret_weapon, ceiling_turret_weapon )
{
    grenade_up = anglestoup( grenade_angles );
    var_7a3f5aa0d7b7cfc0 = vectordot( grenade_up, ( 0, 0, 1 ) );
    
    if ( var_7a3f5aa0d7b7cfc0 < -0.75 )
    {
        return ceiling_turret_weapon;
    }
    else if ( var_7a3f5aa0d7b7cfc0 < 0.75 )
    {
        return wall_turret_weapon;
    }
    
    return floor_turret_weapon;
}

// Namespace mini_sentry
// Params 0, eflags: 0xc
// Checksum 0x31bb8fe3, Offset: 0x784
// Size: 0x8a
function private function_c06822a28edd60b7()
{
    self notify( #"hash_b3f9713100b92473" );
    self endon( #"hash_b3f9713100b92473" );
    self endon( #"death" );
    self endon( #"missile_stuck" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    msg = utility::waittill_any_timeout( 5, "mini_sentry_kill_border_impact" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    self notify( #"mini_sentry_destroy_impact" );
    thread explode();
}

// Namespace mini_sentry
// Params 0
// Checksum 0x533fcb54, Offset: 0x816
// Size: 0x8ea
function watch_for_landing()
{
    self endon( #"mini_sentry_destroy_impact" );
    self endon( #"death" );
    thread function_c06822a28edd60b7();
    thread weapons::watchkillbordernotify( "mini_sentry_kill_border_impact", "mini_sentry_destroy_impact" );
    thread equipment_mp::watchwaterdepth( "mini_sentry_kill_border_impact", "mini_sentry_destroy_impact" );
    thread function_7cf3bc2f71ff62a();
    stuckto = undefined;
    
    if ( !self.origin_override )
    {
        self waittill( #"missile_stuck", stuckto );
    }
    
    bundle = self.tableinfo.bundle;
    floor_turret_weapon = bundle.var_aaf67e9cf3144f71;
    wall_turret_weapon = bundle.var_755d79c556cea859;
    ceiling_turret_weapon = bundle.var_ae2654ce2b54cb04;
    max_health = bundle.mini_sentry_max_health ?? 100;
    var_1d7db852c9f1d31c = self.team_override ?? self.owner.team;
    is_turret_team_overridden = isdefined( self.team_override );
    
    if ( isdefined( self.destroy_on_timeout ) )
    {
        destroy_on_timeout = self.destroy_on_timeout;
    }
    else
    {
        destroy_on_timeout = bundle.mini_sentry_destroy_on_timeout ?? 0;
    }
    
    var_1a57729622ae43be = 0;
    
    if ( !is_turret_team_overridden )
    {
        var_1a57729622ae43be = bundle.var_907e1c3c5838b58a ?? 0;
    }
    
    var_50f3e061f79a7687 = function_86a041114a8f6953( self.angles, floor_turret_weapon, wall_turret_weapon, ceiling_turret_weapon );
    angles = self.angles;
    
    if ( bundle.var_c7709714d768097c && self.weapon_object hasattachmenthash( bundle.var_c7709714d768097c ) )
    {
        var_8c66bacb5ac760be = "veh_sat_pro_mini_sentry_stats_1";
        var_73a1175e0884121d = "veh_sat_pro_mini_sentry_stats_1";
    }
    else
    {
        var_8c66bacb5ac760be = bundle.mini_sentry_vehicle_type ?? "veh_mini_sentry";
        var_73a1175e0884121d = "veh_sat_mini_sentry";
    }
    
    grenadeorigin = ( round( self.origin[ 0 ] ), round( self.origin[ 1 ] ), round( self.origin[ 2 ] ) );
    spawndata = { #angles:angles, #targetname:var_73a1175e0884121d, #vehicletype:var_8c66bacb5ac760be, #origin:grenadeorigin };
    
    if ( !is_turret_team_overridden )
    {
        spawndata.owner = self.owner;
    }
    
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !turret )
    {
        self delete();
        return;
    }
    
    blueprintindex = self.weapon_object.variantid;
    
    if ( blueprintindex > 0 )
    {
        modelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( self.bundle, blueprintindex ), #"xmodel", "projModel" );
        turret setmodel( modelname );
    }
    
    vehicle_tracking::register_instance( turret );
    turret.var_30656af96b2ac2a4 = [];
    turret.add_buff = &add_buff;
    turret.remove_buff = &remove_buff;
    turret.bundle = bundle;
    turret setnonstick( 1 );
    
    if ( !isdefined( stuckto ) )
    {
        stuckto = self getlinkedparent();
    }
    
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        turret linkto( stuckto );
        turret thread watch_stuck( stuckto );
    }
    
    turret setscriptablepartstate( #"plant", #"on" );
    turret.team = var_1d7db852c9f1d31c;
    turret.weapon_name = self.weapon_name;
    turret.owner = self.owner;
    
    if ( !is_turret_team_overridden )
    {
        turret setotherent( turret.owner );
    }
    
    turret setvehicleteam( var_1d7db852c9f1d31c );
    turret setnodeploy( 1 );
    turret setturretscriptcontrolled( 1, 0 );
    var_d257bee18510ef6b = ( turret.origin[ 0 ] - turret.owner.origin[ 0 ], turret.origin[ 1 ] - turret.owner.origin[ 1 ], 0 );
    forwardangles = combineanglesinverted( turret.angles, vectortoangles( var_d257bee18510ef6b ) );
    turret setturrettargetlocalangles( forwardangles, 0, 1 );
    imageoverride = turret.var_30656af96b2ac2a4.size > 0 ? turret.bundle.buffedheadicon : undefined;
    headiconid = entityheadicons::setheadicon_equipment( turret, imageoverride );
    
    if ( !turret )
    {
        self delete();
        return;
    }
    
    turret.headiconid = headiconid;
    turret.isequipment = self.isequipment;
    turret.equipmentref = self.equipmentref;
    turret.var_aa3dc1c1665433b7 = bundle.var_baa8294d54590bc0 ?? 1;
    turret.var_f468780bc04d014a = 1;
    turret.combat_link_buffs = [];
    turret.var_b1da4201d3c28d7 = bundle.var_881507b7d3b65e41 ?? 0.5;
    turret.engagement_delay = turret.var_b1da4201d3c28d7;
    turret.var_63279540775ac1c4 = ( bundle.var_12cffe8f56e3a6e4 ?? 1.5 ) * 1000;
    turret.var_a52c077503665e13 = bundle.var_cda282411f2240b7 ?? 0;
    turret.weapon_fire_time = weaponfiretime( var_50f3e061f79a7687 ) ?? 0.2;
    turret.teamfriendlyto = turret.owner.team;
    vehicle_occupancy::register_instance( turret );
    turret enableplayeruseforallplayers();
    turret setscriptablepartstate( #"lights", #"on" );
    turret setscriptablepartstate( #"visibility", #"show" );
    turret setcandamage( 1 );
    turret toggle_laser( 1 );
    turret thread damage::monitordamage( max_health, "none", &on_destruction, &on_damage, undefined, undefined, undefined, bundle.var_846fc53bddfb5b31 ?? 0 );
    turret sentientpoolmanager::registersentient( "Lethal_Static", turret.owner, 1 );
    utility::function_969f9f5596dba07a( turret, &on_destruction );
    
    if ( destroy_on_timeout )
    {
        lifetime = bundle.mini_sentry_lifetime ?? 45;
        turret thread function_f9898ebb6f7839d1( lifetime );
    }
    
    if ( var_1a57729622ae43be )
    {
        turret.var_1a57729622ae43be = 1;
        turret thread watch_disown();
        self.owner callback::add( "onPlayerSpawn_destroyEquipment", &destroy_on_respawn, { #turretent:self } );
    }
    
    turret namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( turret, &on_emp );
    
    if ( level.killstreak_emp_initialized )
    {
        turret.ksempapplycallback = &on_emp;
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        turret [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( turret, &updatedisable, &updatedisable );
    }
    
    turret.elevatordoorsclosecallback = &explode;
    turret thread function_8da11c3ee52e7f40();
    turret thread turret::function_9b1f535339c80a4();
    
    if ( var_50f3e061f79a7687 == wall_turret_weapon )
    {
        turret turret::function_e2d699d813d8eac1( ( 0, 0, 0 ) );
        turret turret::function_42ec7ba446a3e025( ( 180, 0, 0 ) );
        turret turret::function_3ca888c6dfade34b( &turret::function_3ce881663be017aa, &turret::function_8d530d727f476a04, &scanningupdate );
    }
    else
    {
        turret turret::function_3ca888c6dfade34b( undefined, &turret::function_4913664506477ce0, &scanningupdate );
    }
    
    turret.waypointicon = bundle.var_17bd43e4c0230183 ?? "sat_hud_equipment_mini_sentry_indicator";
    turret.var_9bf3b2daa73ef740 = bundle.var_ec1c25515c588a0 ?? 5;
    turret.owner weapons::onequipmentplanted( turret, "equip_mini_sentry", &on_destruction, bundle.var_fade67dbfd55b33f );
    
    if ( level.var_ee980b280f978ae )
    {
        turret thread function_6e09018aa2e60c03();
    }
    
    turret turret::function_fa954b6b6aadaec0();
    turret turret::function_2e0a246d12d5e047( &function_d327ab4c0ad1af1 );
    turret utility::ent_flag_set( "mini_sentry_deployed" );
    turret thread equipment_interact::remoteinteractsetup( &on_destruction, 1, 1 );
    turret thread function_f791bea8691562c1();
    self delete();
}

// Namespace mini_sentry
// Params 0
// Checksum 0xad01b7e3, Offset: 0x1108
// Size: 0x7b
function function_6e09018aa2e60c03()
{
    turret = self;
    eventdata = utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #equipref:"equip_mini_sentry", #attacker:turret.owner, #einflictor:turret } );
    
    if ( eventdata )
    {
        turret.eventid = eventdata.eventid;
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0x1bfdafa0, Offset: 0x118b
// Size: 0xb4
function scanningupdate( turretindex )
{
    if ( !self.isjammed )
    {
        bundle = self.bundle;
        floor_turret_weapon = bundle.var_aaf67e9cf3144f71;
        wall_turret_weapon = bundle.var_755d79c556cea859;
        ceiling_turret_weapon = bundle.var_ae2654ce2b54cb04;
        var_50f3e061f79a7687 = function_86a041114a8f6953( self.angles, floor_turret_weapon, wall_turret_weapon, ceiling_turret_weapon );
        
        if ( var_50f3e061f79a7687 == wall_turret_weapon )
        {
            turret::function_d5e5609d2823a59( turretindex );
        }
        else
        {
            turret::function_29d8d1f12d502d4d( turretindex );
        }
        
        return;
    }
    
    self.var_89ee8a2a5206fad6 = 1;
}

// Namespace mini_sentry
// Params 0
// Checksum 0x37967ac9, Offset: 0x1247
// Size: 0xb0
function function_7cf3bc2f71ff62a()
{
    bundle = self.tableinfo.bundle;
    
    if ( !bundle.var_61b6e61b18a676f5 )
    {
        return;
    }
    
    self endon( #"mini_sentry_destroy_impact" );
    self endon( #"death" );
    self endon( #"missile_stuck" );
    originalpitch = 0;
    var_31b178606939ef0e = 0;
    rotspeed = bundle.var_944f297d2a5616b7;
    
    while ( true )
    {
        self.angles = ( originalpitch, self.angles[ 1 ] + rotspeed * level.framedurationseconds, var_31b178606939ef0e );
        waitframe();
    }
}

// Namespace mini_sentry
// Params 2
// Checksum 0x5a4074ae, Offset: 0x12ff
// Size: 0x8e
function create_waypoint_for_player( turret, var_8046793bb76e3de8 )
{
    waypoint = newclienthudelem( var_8046793bb76e3de8 );
    waypoint setshader( turret.waypointicon, 8, 8 );
    waypoint setwaypoint( 0, 1, 0, 0 );
    waypoint linkwaypointtotargetwithoffset( turret, ( 0, 0, 35 ) );
    waypoint function_fb75b884d498153f();
    waypoint.alpha = 1;
    waypoint.color = ( 0.5, 0, 0 );
    return waypoint;
}

// Namespace mini_sentry
// Params 1
// Checksum 0xf317215f, Offset: 0x1396
// Size: 0xb6
function remove_waypoints( turret )
{
    if ( turret.waypointinfo )
    {
        foreach ( data in turret.waypointinfo )
        {
            if ( isdefined( data.waypoint ) )
            {
                data.waypoint destroy();
            }
        }
    }
    
    turret.waypointinfo = undefined;
}

// Namespace mini_sentry
// Params 1
// Checksum 0x47ac593a, Offset: 0x1454
// Size: 0x224
function on_player_damaged( params )
{
    if ( params.eattacker && params.victim && params.objweapon.basenamehash == %"sat_mini_sentry_turret" )
    {
        if ( !isbot( self ) )
        {
            thread function_a80d003b36239928( params.eattacker, self );
        }
        
        if ( params.eattacker.owner && isplayer( params.eattacker.owner ) )
        {
            attackerowner = params.eattacker.owner;
            hitmarkersoundalias = utility::callsharedfunc( #"hud", #"hash_785d65fc31ffd85", 0 );
            
            if ( hitmarkersoundalias )
            {
                attackerowner playlocalsound( hitmarkersoundalias );
            }
            
            info = { #hittime:gettime(), #objweapon:params.objweapon, #player:attackerowner };
            
            if ( !isdefined( params.victim.var_340d38bed23b43df ) )
            {
                params.victim.var_340d38bed23b43df = [];
            }
            
            attackerentnum = attackerowner.entnum ?? utility::get_entity_number( attackerowner );
            params.victim.var_340d38bed23b43df[ attackerentnum ] = info;
        }
        
        thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #armordamage:params.lightarmordamage, #healthdamage:params.healthdamage, #victim:params.victim, #attacker:params.eattacker.owner, #grenade:params.eattacker, #equipref:"equip_mini_sentry" } );
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0x6869eb06, Offset: 0x1680
// Size: 0x108
function onplayerdeath( data )
{
    foreach ( entry in data.victim.var_340d38bed23b43df )
    {
        attacker = entry.player;
        
        if ( !attacker )
        {
            continue;
        }
        
        if ( data.objweapon == entry.objweapon )
        {
            continue;
        }
        
        if ( isnumber( entry.hittime ) && gettime() - entry.hittime < 5000 )
        {
            attacker thread gamelogic_mp::threadedsetweaponstatbyname( entry.objweapon, 1, "kills" );
        }
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0xd61aa69b, Offset: 0x1790
// Size: 0x14a
function function_38cf8364e4d8e652( params )
{
    inflictor = params.inflictor;
    
    if ( inflictor.isequipment && inflictor.equipmentref == "equip_mini_sentry" )
    {
        if ( !isdefined( inflictor.mini_sentry_kills ) )
        {
            inflictor.mini_sentry_kills = 0;
        }
        
        inflictor.mini_sentry_kills++;
        
        if ( inflictor.mini_sentry_kills == 2 && inflictor.owner )
        {
            inflictor.owner.modifiers[ "3_sentry_kills" ] = 1;
        }
    }
    
    if ( equipment_mp::getequipmentreffromweapon( params.objweapon ) != "equip_mini_sentry" )
    {
        if ( params.victim.attackerdata[ self.guid ].damagesources[ "equip_mini_sentry" ] )
        {
            self.modifiers[ #"hash_2afd08ec31e0a82" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"hash_2afd08ec31e0a82" ) );
        }
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0x6b6263d1, Offset: 0x18e2
// Size: 0x70
function on_player_elim( params )
{
    if ( self.modifiers[ "3_sentry_kills" ] )
    {
        thread points::doscoreevent( #"mini_sentry_3_kills" );
    }
    
    if ( self.modifiers[ #"hash_2afd08ec31e0a82" ] )
    {
        thread points::doscoreevent( #"hash_991aa42e975c1dce", self.var_e6d8cfcc28a79324[ "primary" ], undefined, undefined, params.victim );
    }
}

// Namespace mini_sentry
// Params 2
// Checksum 0x514fc704, Offset: 0x195a
// Size: 0x12f
function function_a80d003b36239928( turret, victim )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( turret.var_9bf3b2daa73ef740 <= 0 )
    {
        return;
    }
    
    victimentnum = victim getentitynumber();
    
    if ( !isdefined( turret.waypointinfo[ victimentnum ] ) )
    {
        turret.waypointinfo[ victimentnum ] = spawnstruct();
        turret.waypointinfo[ victimentnum ].victim = victim;
    }
    
    waypointdata = turret.waypointinfo[ victimentnum ];
    damagestarttime = gettime();
    waypointdata.lastdamagetime = damagestarttime;
    
    if ( !isdefined( waypointdata.waypoint ) )
    {
        waypointdata.waypoint = create_waypoint_for_player( turret, victim );
    }
    
    wait turret.var_9bf3b2daa73ef740;
    
    if ( waypointdata.lastdamagetime == damagestarttime && isdefined( waypointdata.waypoint ) )
    {
        waypointdata.waypoint destroy();
        waypointdata.waypoint = undefined;
    }
}

// Namespace mini_sentry
// Params 0
// Checksum 0x61abb764, Offset: 0x1a91
// Size: 0x5b
function function_8da11c3ee52e7f40()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.isjammed )
        {
            self clearturrettarget();
            waitframe();
            continue;
        }
        
        current_target = self getturrettargetent();
        
        if ( isplayer( current_target ) )
        {
            function_cfeabec723da32ef( current_target );
        }
        
        self.active_target = current_target;
        waitframe();
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0x65f22ab2, Offset: 0x1af4
// Size: 0x7f
function function_cfeabec723da32ef( current_target )
{
    if ( !isdefined( current_target ) )
    {
        return;
    }
    
    if ( current_target == self.active_target )
    {
        return;
    }
    
    if ( !isdefined( current_target.var_946dca606c68fb9a ) )
    {
        current_target.var_946dca606c68fb9a = 0;
    }
    
    if ( gettime() > current_target.var_946dca606c68fb9a )
    {
        current_target playsoundtoplayer( #"hash_2ffc43c1dc0b35a0", current_target, self );
        current_target.var_946dca606c68fb9a = gettime() + self.var_63279540775ac1c4;
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0x37800943, Offset: 0x1b7b
// Size: 0x2c
function toggle_laser( engaging )
{
    if ( self.var_a52c077503665e13 )
    {
        if ( engaging )
        {
            self laseron();
            return;
        }
        
        self laseroff();
    }
}

// Namespace mini_sentry
// Params 2
// Checksum 0x288db5f2, Offset: 0x1baf
// Size: 0x77
function function_d38bc85a054031ee( owner, attacker )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    result = undefined;
    
    if ( isplayer( attacker ) )
    {
        result = attacker;
    }
    else if ( isplayer( attacker.owner ) )
    {
        result = attacker.owner;
    }
    
    if ( !( isdefined( result ) && isdefined( owner ) ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( owner, result ) )
    {
        return;
    }
    
    return result;
}

// Namespace mini_sentry
// Params 1
// Checksum 0x3e1a8f60, Offset: 0x1c2f
// Size: 0x9d
function on_damage( damage_data )
{
    if ( !self.isdamaged )
    {
        self.isdamaged = 1;
        self setscriptablepartstate( "damaged", "on", 0 );
    }
    
    if ( damage_data.attacker && isplayer( damage_data.attacker ) )
    {
        hitmarkersoundalias = utility::callsharedfunc( #"hud", #"hash_785d65fc31ffd85", 0 );
        
        if ( hitmarkersoundalias )
        {
            damage_data.attacker playlocalsound( hitmarkersoundalias );
        }
    }
    
    return damage_data.damage;
}

// Namespace mini_sentry
// Params 1
// Checksum 0xd05cb569, Offset: 0x1cd5
// Size: 0x29
function updatedisable( turret )
{
    if ( turret.isjammed )
    {
        self laseroff();
        return;
    }
    
    self laseron();
}

// Namespace mini_sentry
// Params 1
// Checksum 0x3be6a58c, Offset: 0x1d06
// Size: 0x22
function on_emp( damage_data )
{
    if ( self.isdying )
    {
        return;
    }
    
    thread on_destruction( damage_data );
}

// Namespace mini_sentry
// Params 2
// Checksum 0x369483f0, Offset: 0x1d30
// Size: 0x3b
function destroy_on_respawn( params, fields )
{
    fields.turretent on_destruction( undefined );
    callback::remove( "onPlayerSpawn_destroyEquipment", &destroy_on_respawn, fields );
}

// Namespace mini_sentry
// Params 0, eflags: 0xc
// Checksum 0x9525a559, Offset: 0x1d73
// Size: 0x67
function private watch_disown()
{
    self notify( #"hash_e5215d1f310230a" );
    self endon( #"hash_e5215d1f310230a" );
    level endon( #"game_ended" );
    self endon( #"turret_hacked" );
    self.owner utility::waittill_any( "disconnect", "joined_team" );
    
    if ( isdefined( self ) && !self.isdying )
    {
        thread on_destruction( undefined );
    }
}

// Namespace mini_sentry
// Params 1, eflags: 0xc
// Checksum 0x6841309e, Offset: 0x1de2
// Size: 0x5a
function private function_f9898ebb6f7839d1( duration )
{
    self notify( #"hash_70681cca93c952b4" );
    self endon( #"hash_70681cca93c952b4" );
    level endon( #"game_ended" );
    self endon( #"death" );
    wait duration;
    
    if ( isdefined( self ) && !self.isdying )
    {
        thread on_destruction( undefined );
    }
}

// Namespace mini_sentry
// Params 1, eflags: 0xc
// Checksum 0xf530be3, Offset: 0x1e44
// Size: 0x57
function private watch_stuck( var_59f28bc546c68ddc )
{
    self notify( #"hash_bc37d477c6ce74cf" );
    self endon( #"hash_bc37d477c6ce74cf" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( var_59f28bc546c68ddc )
    {
        var_59f28bc546c68ddc waittill( #"death" );
        thread on_destruction( undefined );
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0xbe0ee6a4, Offset: 0x1ea3
// Size: 0x1bd
function on_destruction( damage_data )
{
    self notify( #"hash_2445e77d0d90ff23" );
    self endon( #"hash_2445e77d0d90ff23" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"death" );
    self.isdying = 1;
    utility::ent_flag_clear( "mini_sentry_deployed" );
    
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    remove_waypoints( self );
    
    if ( self.killcament )
    {
        self.killcament delete();
    }
    
    if ( damage_data.attacker )
    {
        iskillingblow = 1;
        damage_data.attacker thread damagefeedback::updatedamagefeedback( "hitequip", iskillingblow );
    }
    
    var_6927b27a68eccd9e = function_d38bc85a054031ee( self.owner, damage_data.attacker );
    
    if ( isdefined( var_6927b27a68eccd9e ) )
    {
        var_6927b27a68eccd9e thread points::doscoreevent( #"hash_c26628e09fdf862c", damage_data.objweapon );
    }
    
    self setscriptablepartstate( "damaged", "off", 0 );
    self setcandamage( 0 );
    weapon::deregistermine();
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #equipref:"equip_mini_sentry", #owner:self.owner, #ent:self } );
    thread explode();
}

// Namespace mini_sentry
// Params 0
// Checksum 0x3ffad3cc, Offset: 0x2068
// Size: 0x58
function explode()
{
    self notify( #"hash_4c1d4441ee1f2584" );
    self endon( #"hash_4c1d4441ee1f2584" );
    self setscriptablepartstate( "destroyed", "on", 0 );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        if ( vehicle::get_ref() )
        {
            vehicle_tracking::deregister_instance( self );
            vehicle_tracking::delete_vehicle( self );
            return;
        }
        
        self delete();
    }
}

/#

    // Namespace mini_sentry
    // Params 0, eflags: 0x4
    // Checksum 0x5e0e7606, Offset: 0x20c8
    // Size: 0xde, Type: dev
    function private debug_watch_mini_sentry()
    {
        while ( true )
        {
            origin = self gettagorigin( #"tag_flash" );
            angles = self gettagangles( #"tag_flash" );
            debugaxis( origin, angles );
            
            if ( isdefined( self.active_target ) )
            {
                target_origin = self.active_target utility::function_f02ebab438642e16();
                line( origin, target_origin );
                sphere( target_origin, 3, ( 1, 0, 0 ) );
                distance = distance( origin, target_origin ) * 0.0254;
                print3d( self.origin + ( 0, 0, -20 ), distance + "<dev string:x69>", ( 1, 1, 0 ), 1, 0.5, undefined, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace mini_sentry
// Params 2
// Checksum 0xcdb905f3, Offset: 0x21ae
// Size: 0x15e
function mini_sentry_hack( hackeffect, attacker )
{
    self notify( #"turret_hacked" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    self setvehicleteam( attacker.team );
    self.teamfriendlyto = attacker.team;
    self clearturrettarget();
    self setscriptablepartstate( #"hacked", #"stolen" );
    self.owner callback::remove( "onPlayerSpawn_destroyEquipment", &destroy_on_respawn, { #turretent:self } );
    
    if ( self.var_1a57729622ae43be )
    {
        thread watch_disown();
        self.owner callback::add( "onPlayerSpawn_destroyEquipment", &destroy_on_respawn, { #turretent:self } );
    }
    
    if ( self.destroy_on_timeout || ( self.bundle.mini_sentry_destroy_on_timeout ?? 0 ) )
    {
        lifetime = self.bundle.mini_sentry_lifetime ?? 45;
        thread function_f9898ebb6f7839d1( lifetime );
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0x23149a3a, Offset: 0x2314
// Size: 0x20c
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_994bf43aa4598a26" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_994bf43aa4598a26", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_25e1629f3588e56f", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            var_97d4945882daf6b9 = params.bundle.var_38bca9290ba0e411 ?? 0.1;
            self.engagement_delay -= var_97d4945882daf6b9;
            
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
        }
    }
}

// Namespace mini_sentry
// Params 1
// Checksum 0xd1c53e0e, Offset: 0x2528
// Size: 0xc0
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                self.engagement_delay = self.var_b1da4201d3c28d7;
                
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_251a2102c50e4fb6 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_251a2102c50e4fb6, 1 );
                }
            }
        }
    }
}

// Namespace mini_sentry
// Params 2, eflags: 0x4
// Checksum 0x3fbbf521, Offset: 0x25f0
// Size: 0xec, Type: bool
function private function_d327ab4c0ad1af1( target, turretindex )
{
    if ( isplayer( target ) )
    {
        if ( isdefined( target.perks[ "specialty_blindeye" ] ) )
        {
            return false;
        }
        
        if ( self.bundle.var_4399e890e0cb1761 && target.isjuggernaut )
        {
            return false;
        }
    }
    
    if ( self.isjammed )
    {
        return false;
    }
    
    if ( self.bundle.var_f24e80f1d50b083a && isagent( target ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
    {
        if ( self.owner && isagent( target ) && !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self.owner, target ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mini_sentry
// Params 3, eflags: 0x4
// Checksum 0x6dfc2ca4, Offset: 0x26e5
// Size: 0xa7
function private register_on_kill_medal( floor, wall, ceiling )
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", floor, &function_9c37dab83025b0c2 );
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", wall, &function_9c37dab83025b0c2 );
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", ceiling, &function_9c37dab83025b0c2 );
    }
}

// Namespace mini_sentry
// Params 4, eflags: 0x4
// Checksum 0xfeca4aec, Offset: 0x2794
// Size: 0x77
function private function_9c37dab83025b0c2( victim, einflictor, smeansofdeath, sweapon )
{
    if ( !isdefined( einflictor ) )
    {
        return;
    }
    
    if ( !isdefined( einflictor.medal_kill_count ) )
    {
        einflictor.medal_kill_count = 0;
    }
    
    einflictor.medal_kill_count++;
    
    if ( einflictor.medal_kill_count == 10 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_usemoregun" );
    }
}

// Namespace mini_sentry
// Params 0
// Checksum 0x9a3c97bd, Offset: 0x2813
// Size: 0x50
function function_f791bea8691562c1()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hack_successful", hacker );
        mini_sentry_hack( { #var_30e7de3d76d5a085:1 }, hacker );
    }
}

