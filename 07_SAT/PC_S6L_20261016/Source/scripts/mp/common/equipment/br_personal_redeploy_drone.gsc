// scripts\mp\common\equipment\br_personal_redeploy_drone.gsc  (hash_751924bfea7069da.gscc) (size: 17289 Bytes / 0x4389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9ae1420 (3920499744)
// size ...... 17289 (0x4389)
// includes .. 16  (offset: 0x3edd)
// strings ... 56  (offset: 0x3f5d)
// dev strs .. 5   (offset: 0x4349)
// exports ... 40  (offset: 0x264d)
// cseg ...... 0x4ee + 0x215f (0x264d)
// imports ... 153 (offset: 0x2c8d)
// animtree1 . 0   (offset: 0x4389)
// animtree2 . 0   (offset: 0x4389)
#using scripts\common\ae_utility;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\analyticslog;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;

#namespace br_personal_redeploy_drone;

// Namespace br_personal_redeploy_drone
// Params 0, eflags: 0x1
// Checksum 0x7725e4f9, Offset: 0x50c
// Size: 0xa
function autoexec main()
{
    level thread init_when_ready();
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0xea3ed1af, Offset: 0x51e
// Size: 0x22
function init_when_ready()
{
    level endon( #"game_ended" );
    level waittill( #"init_supers" );
    init();
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0xdbba2318, Offset: 0x548
// Size: 0x7a
function init()
{
    supers_mp::function_48aaa60b2ce7b8a1( "super_personal_redeploy_drone", undefined, undefined, &function_c8e28bdeddcac8a3, undefined, undefined );
    audio_utility::snd_transient_load( "eqp_personal_redeploy_drone" );
    init_variables();
    init_dev_gui();
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #customend:1, #customstart:1, #equipref:"equip_personal_redeploy_drone" } );
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0x154a05f3, Offset: 0x5ca
// Size: 0x4d
function init_dev_gui()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3b>", "<dev string:x57>" );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x90>" );
        devgui::add_devgui_command( "<dev string:x3b>", "<dev string:xb5>" );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0x46426be9, Offset: 0x61f
// Size: 0x2fd
function init_variables()
{
    level.var_ee434e3af62e4a87 = spawnstruct();
    level.var_ee434e3af62e4a87.maxhealth = getdvarint( @"hash_1a3f3e5d7d85d66", 200 );
    level.var_ee434e3af62e4a87.heightcheck = getdvarint( @"hash_6e8ed4dba5669324", 1000 );
    level.var_ee434e3af62e4a87.heightfly = getdvarint( @"hash_5a4caf1fb986ed3d", 1200 );
    level.var_ee434e3af62e4a87.frontcheck = getdvarint( @"hash_4c317295490ab630", 144 );
    level.var_ee434e3af62e4a87.flighttime = getdvarfloat( @"hash_1100bb3b49784382", 2.5 );
    level.var_ee434e3af62e4a87.maxaltitude = getdvarint( @"hash_87956834ba2c9da5", 6400 );
    level.var_ee434e3af62e4a87.autoparachute = getdvarint( @"hash_54d723a99cbba03", 0 );
    level.var_ee434e3af62e4a87.verticalsteer = getdvarint( @"hash_3844467d573b1434", 34 );
    level.var_ee434e3af62e4a87.horizontalsteer = getdvarint( @"hash_a79bd8d12a31c3ee", 34 );
    level.var_ee434e3af62e4a87.var_cdda8b762253e936 = getdvarint( @"hash_863526b21ddab568", -100 );
    level.var_ee434e3af62e4a87.var_e2f10475a3fe060c = getdvarint( @"hash_a98c9ba7e95c38fe", 18 );
    level.var_ee434e3af62e4a87.momentummultiplier = getdvarfloat( @"hash_905fb821eddd2d0c", 1.2 );
    level.var_ee434e3af62e4a87.accelerationtime = getdvarfloat( @"hash_9451fc5f136786c8", 1 );
    level.var_ee434e3af62e4a87.var_a86666816d7a6aa0 = getdvarfloat( @"hash_527a6411c9ece18a", 0.4 );
    level.var_ee434e3af62e4a87.var_643675eea42e862f = getdvarfloat( @"hash_60ae35c4bb9c1a1d", 1 );
    level.var_ee434e3af62e4a87.var_c2b0392a6773cd9 = getdvarfloat( @"hash_ebf0b0e995b5030c", 40 );
    level.var_ee434e3af62e4a87.var_f39e7fae3149b50e = getdvarvalue( @"hash_ff4dcd2194fb02b3", 0 );
    level.var_ee434e3af62e4a87.var_60fd9350c8a1dd9f = getdvarfloat( @"hash_8e3ad38014dcf2c2", 0.5 );
    level.var_ee434e3af62e4a87.var_7550d7a1cb56a8e5 = getdvarfloat( @"hash_b7706dea509685dc", 0.5 );
    game[ "strings" ][ "personal_redeploy_drone_insufficient_space" ] = &"super_mp/personal_redeploy_drone_insufficent_space";
    game[ "strings" ][ "personal_redeploy_drone_underwater" ] = &"super_mp/personal_redeploy_drone_underwater";
    game[ "strings" ][ "prd_prone" ] = &"super_mp/prd_prone";
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0x4eb7e582, Offset: 0x924
// Size: 0x3a, Type: bool
function function_c8e28bdeddcac8a3()
{
    if ( function_4991cef74dee68b0() )
    {
        return false;
    }
    
    val::set( "prd", "super_pickup", 0 );
    val::set( "prd", "supers", 0 );
    thread personalredeploydrone_use();
    return true;
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0x8b1c9981, Offset: 0x967
// Size: 0x387
function personalredeploydrone_use()
{
    self endon( #"disconnect" );
    
    if ( self isswimming() )
    {
        self.prdswim = 1;
        val::set( "prd", "allow_movement", 0 );
    }
    
    val::set( "prd", "melee", 0 );
    val::set( "prd", "base_jumping", 0 );
    val::set( "prd", "killstreaks", 0 );
    val::set( "prd", "vehicle_use", 0 );
    val::set( "prd", "allow_jump", 0 );
    val::set( "prd", "offhand_primary_weapons", 0 );
    val::set( "prd", "vehicle_use", 0 );
    
    if ( !level.var_ee434e3af62e4a87.var_f39e7fae3149b50e )
    {
        val::set( "prd", "fire", 0 );
    }
    
    self.original_suit = self.operatorcustomization.suit;
    prdweapon = makeweapon( "personal_redeploy_drone_mp_br" );
    prd_icon( 1, "hud_icon_minimap_fieldupgrade_personal_redeploy_ally" );
    prd_icon( 0, "hud_icon_minimap_fieldupgrade_personal_redeploy_enemy" );
    
    if ( self getcamerathirdperson() )
    {
        player::_setsuit( "t10_defaultsuit_prd3p_wz" );
    }
    else
    {
        player::_setsuit( "t10_defaultsuit_prd_wz" );
    }
    
    waitframe();
    self setstance( "stand", 1 );
    waitframe();
    allowstances( self, 0 );
    thread function_974704a2b172f18e();
    firetime = weaponfiretime( "personal_redeploy_drone_mp_br" );
    grenadefiretime = weaponfiretime( "prd_grenade_mp" );
    usetime = firetime + level.var_ee434e3af62e4a87.flighttime + grenadefiretime + 0.1;
    setusetime( usetime );
    self cancelreload();
    self function_6af2d51e2f2b6967( 1 );
    quickdroptime = self prdquickdrop();
    quickdroptime *= 0.001;
    
    if ( !level.var_ee434e3af62e4a87.var_f39e7fae3149b50e || self isdualwielding() )
    {
        wait quickdroptime;
    }
    
    weapon_utility::giveandfireoffhandreliable( prdweapon );
    
    if ( !level.var_ee434e3af62e4a87.var_f39e7fae3149b50e )
    {
        val::reset( "prd", "fire" );
    }
    
    val::reset( "prd", "offhand_primary_weapons" );
    challenges::function_a0936b0e5b4550f3( "super_personal_redeploy_drone", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    val::set( "prd", "weapon_switch", 0 );
    function_6b68941d1aef9320();
    drone = function_dc330462004a183b();
    drone thread function_9f519d4c07d09f31( self );
    waitframe();
    
    if ( !isdefined( drone ) || drone.stopuse )
    {
        return;
    }
    
    if ( !isalive( self ) || self.inlaststand || function_d3f1e52bc9b50683( self ) || self ismeatshieldvictim() || self isinexecutionvictim() )
    {
        function_700fa9a786db9bf7( drone );
        
        if ( self.inlaststand )
        {
            val::group_set( "laststand", 0 );
        }
        
        function_63a40fce734c7f07( self );
        function_e5ea93ed6028e1dc( 1 );
        return;
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #owner:self, #itemref:"super_personal_redeploy_drone", #equipref:"equip_personal_redeploy_drone", #ent:drone } );
    val::reset( "prd", "allow_jump" );
    thread function_608e1c8ac6dd8f64( drone );
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0x4e66a3ac, Offset: 0xcf6
// Size: 0x21a, Type: bool
function function_4991cef74dee68b0()
{
    if ( self isswimunderwater() )
    {
        thread function_6eabf70c94073e85( "personal_redeploy_drone_underwater", 1 );
        return true;
    }
    
    if ( isdefined( self.triggeringstreak ) )
    {
        return true;
    }
    
    if ( self isvehicleactive() || isdefined( self.vehiclereserved ) )
    {
        return true;
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return true;
    }
    
    if ( self ismeatshieldvictim() || self isinexecutionvictim() )
    {
        return true;
    }
    
    if ( self ismeleeing() )
    {
        return true;
    }
    
    contents = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 1 );
    ignorelist = [ self ];
    var_acd7d6afb61eb1fe = self.origin + ( 0, 0, 63.42 );
    castendheight = var_acd7d6afb61eb1fe + ( 0, 0, level.var_ee434e3af62e4a87.heightcheck );
    capsulecastradius = 24;
    capsulecastangles = ( 0, 0, 0 );
    halfheight = level.var_ee434e3af62e4a87.heightcheck * 0.5 - capsulecastradius;
    caststartheight = self.origin + ( 0, 0, 31.71 ) + ( 0, 0, halfheight );
    castendfront = var_acd7d6afb61eb1fe + anglestoforward( self getplayerangles( 1 ) ) * level.var_ee434e3af62e4a87.frontcheck;
    caststartfront = var_acd7d6afb61eb1fe;
    var_1265cbf60640307 = physics_capsulecast( caststartheight, castendheight, capsulecastradius, halfheight, capsulecastangles, contents, ignorelist, "physicsquery_closest" );
    var_ec6dd6fcb927abb3 = physics_raycast( caststartfront, castendfront, contents, ignorelist, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( var_1265cbf60640307 ) && var_1265cbf60640307.size > 0 || isdefined( var_ec6dd6fcb927abb3 ) && var_ec6dd6fcb927abb3.size > 0 )
    {
        thread function_6eabf70c94073e85( "personal_redeploy_drone_insufficient_space", 1 );
        return true;
    }
    
    if ( self getstance() == "prone" )
    {
        thread function_6eabf70c94073e85( "prd_prone", 1 );
        return true;
    }
    
    return false;
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0xd901d4ed, Offset: 0xf19
// Size: 0x3d
function function_6eabf70c94073e85( string, iserror )
{
    if ( iserror )
    {
        self playlocalsound( "eqp_personal_redeploy_drone_error" );
    }
    
    lower_message::setlowermessageomnvar( string );
    wait 3;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x6b053f38, Offset: 0xf5e
// Size: 0x40
function function_6b68941d1aef9320( drone )
{
    self endon( #"death_or_disconnect" );
    
    if ( self getcamerathirdperson() )
    {
        function_b8df72f77cd54d17( self, 0 );
    }
    
    self attach( "misc_vm_pers_redeploy_drone", "tag_accessory_left", 0 );
    self function_caac29d8e42951fb();
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0xac3fa427, Offset: 0xfa6
// Size: 0xd4
function function_dc330462004a183b()
{
    spawnorigin = self gettagorigin( "tag_accessory" );
    drone = spawn( "script_model", spawnorigin );
    drone hide();
    drone setmodel( "misc_vm_pers_redeploy_drone" );
    drone.angles = self.angles;
    drone.maxhealth = level.var_ee434e3af62e4a87.maxhealth;
    drone.health = drone.maxhealth;
    drone setcandamage( 1 );
    drone.player = self;
    drone.skiptoexplosion = 0;
    drone.watchdamage = 1;
    drone thread function_ac7028bbb53e5338();
    drone linktoblendtotag( self, "tag_accessory" );
    return drone;
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0x1d96d6ce, Offset: 0x1083
// Size: 0xcf
function function_ac7028bbb53e5338()
{
    self endon( #"entitydeleted" );
    
    while ( isdefined( self ) && self.watchdamage == 1 )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        function_5c099a3a40c0b9a8( inflictor, damage, meansofdeath, objweapon );
        waitframe();
    }
}

// Namespace br_personal_redeploy_drone
// Params 4
// Checksum 0x58662190, Offset: 0x115a
// Size: 0x116
function function_5c099a3a40c0b9a8( einflictor, damage, smeansofdeath, objweapon )
{
    self.health += damage;
    
    if ( objweapon.basename == "prd_grenade_mp" )
    {
        return;
    }
    
    if ( damage < 2 )
    {
        return;
    }
    
    if ( isplayer( einflictor ) && einflictor.team != self.player.team )
    {
        einflictor damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1, "hitequip" );
    }
    
    if ( !isdefined( einflictor ) || einflictor.team != self.player.team )
    {
        self.health -= damage;
    }
    
    if ( self.health <= 0 )
    {
        self.skiptoexplosion = 1;
        self.watchdamage = 0;
        waitframe();
        self notify( #"hash_686817783c90da60" );
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x9cafa5f6, Offset: 0x1278
// Size: 0xf0
function function_608e1c8ac6dd8f64( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"hash_686817783c90da60" );
    self endon( #"disconnect" );
    player = self;
    heightoffset = 1;
    movenode = spawn( "script_model", player.origin + ( 0, 0, heightoffset ) );
    movenode.angles = player.angles;
    movenode setmodel( "tag_origin" );
    self.movenode = movenode;
    self.ejectthrust = 1;
    
    if ( self.prdswim )
    {
        self.prdswim = undefined;
        val::reset( "prd", "allow_movement" );
    }
    
    waitframe();
    drone thread function_8cc2a87f842d2ab4( self );
    function_fbba298ea5be6b7a( drone, movenode );
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0xca0bca57, Offset: 0x1370
// Size: 0x452
function function_fbba298ea5be6b7a( drone, movenode )
{
    player = self;
    timeinterval = 0.1;
    totaltimeremaining = level.var_ee434e3af62e4a87.flighttime;
    drone.var_4b31fdc8cc2f7ecf = 0;
    drone thread function_2b3a521f372663a4( level.var_ee434e3af62e4a87.var_643675eea42e862f );
    momentumdistance = ( player getvelocity()[ 0 ], player getvelocity()[ 1 ], 0 ) * level.var_ee434e3af62e4a87.momentummultiplier * level.var_ee434e3af62e4a87.flighttime;
    flyheight1 = function_aaa75d92cc0cea8b( player );
    var_26a5d8eefe19e064 = movenode.origin + ( 0, 0, flyheight1 - level.var_ee434e3af62e4a87.var_cdda8b762253e936 ) + momentumdistance;
    var_3f28c35ade38f211 = var_26a5d8eefe19e064[ 2 ];
    initialz = movenode.origin[ 2 ];
    deltaz = abs( var_3f28c35ade38f211 - initialz );
    player setorigin( movenode.origin, 0 );
    player playerlinkto( movenode, "tag_origin", 0, 180, 180, 180, 180, 1 );
    waitframe();
    accelerationtime = 0;
    thread function_1b4aceff75cc6913( drone );
    previousplayerorigin = player getorigin();
    player.prdstuck = 0;
    
    while ( totaltimeremaining >= 0.1 )
    {
        currentgoalz = level.var_ee434e3af62e4a87.accelerationtime > 0 ? math::lerp( deltaz * level.var_ee434e3af62e4a87.var_a86666816d7a6aa0, deltaz, accelerationtime / level.var_ee434e3af62e4a87.accelerationtime ) : deltaz;
        currentgoalz += initialz;
        currentplayerorigin = player getorigin();
        averagevelocity = ( currentgoalz - currentplayerorigin[ 2 ] ) / totaltimeremaining;
        var_b3f820952dfd6e57 = averagevelocity * timeinterval;
        
        if ( currentplayerorigin[ 2 ] - previousplayerorigin[ 2 ] < var_b3f820952dfd6e57 * 0.5 )
        {
            player.prdstuck += 1;
            
            if ( player.prdstuck > 10 )
            {
                self.ejectthrust = 0;
                drone notify( #"hash_686817783c90da60" );
                return;
            }
        }
        else
        {
            previousplayerorigin = currentplayerorigin;
            player.prdstuck = max( player.prdstuck - 1, 0 );
        }
        
        if ( accelerationtime <= level.var_ee434e3af62e4a87.accelerationtime )
        {
            var_26a5d8eefe19e064 = ( var_26a5d8eefe19e064[ 0 ], var_26a5d8eefe19e064[ 1 ], currentgoalz );
            accelerationtime += timeinterval;
        }
        else
        {
            var_26a5d8eefe19e064 = ( var_26a5d8eefe19e064[ 0 ], var_26a5d8eefe19e064[ 1 ], var_3f28c35ade38f211 );
        }
        
        var_26a5d8eefe19e064 = movenode function_fa8e5a393f7f144( var_26a5d8eefe19e064, totaltimeremaining, player );
        
        if ( movenode.origin != var_26a5d8eefe19e064 && totaltimeremaining > 0.1 )
        {
            self.ejectvelocity = ( var_26a5d8eefe19e064 - movenode.origin ) / totaltimeremaining;
            self.ejectvelocity = ( self.ejectvelocity[ 0 ] * level.var_ee434e3af62e4a87.var_60fd9350c8a1dd9f, self.ejectvelocity[ 1 ] * level.var_ee434e3af62e4a87.var_60fd9350c8a1dd9f, self.ejectvelocity[ 2 ] * level.var_ee434e3af62e4a87.var_7550d7a1cb56a8e5 );
        }
        
        if ( function_d3f1e52bc9b50683( player ) || player jumpbuttonpressed() && drone.var_4b31fdc8cc2f7ecf || player ismeatshieldvictim() || player isinexecutionvictim() )
        {
            drone notify( #"hash_686817783c90da60" );
            self.ejectthrust = 0;
            return;
        }
        
        wait timeinterval;
        totaltimeremaining -= timeinterval;
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:drone.origin, #owner:self, #equipref:"equip_personal_redeploy_drone", #ent:drone } );
    drone notify( #"hash_686817783c90da60" );
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0xa368209f, Offset: 0x17ca
// Size: 0x55
function function_2b3a521f372663a4( time )
{
    wait time;
    
    if ( isdefined( self ) )
    {
        self.var_4b31fdc8cc2f7ecf = 1;
        self makeusable();
        self sethintstring( &"equipment_hints/personal_redeploy_drone_cancel" );
        self setcursorhint( "HINT_NOICON" );
        self setuseholdduration( "duration_none" );
        self setusecommand( "+gostand" );
    }
}

// Namespace br_personal_redeploy_drone
// Params 3
// Checksum 0x43e938dd, Offset: 0x1827
// Size: 0x166
function function_fa8e5a393f7f144( var_26a5d8eefe19e064, totaltimeremaining, player )
{
    horizontalaxis = player getleftstickx();
    verticalaxis = player getleftsticky();
    deadzone = 0.01;
    
    if ( squared( horizontalaxis ) >= deadzone )
    {
        horizontalsteer = anglestoright( player getplayerangles( 1 ) ) * level.var_ee434e3af62e4a87.horizontalsteer * horizontalaxis;
        var_26a5d8eefe19e064 += horizontalsteer;
    }
    
    if ( squared( verticalaxis ) >= deadzone )
    {
        verticalsteer = anglestoforward( player getplayerangles( 1 ) ) * level.var_ee434e3af62e4a87.verticalsteer * verticalaxis;
        var_26a5d8eefe19e064 += verticalsteer;
    }
    
    if ( isdefined( player.bounce ) )
    {
        player.bounce *= level.var_ee434e3af62e4a87.var_c2b0392a6773cd9;
        var_26a5d8eefe19e064 = ( self.origin[ 0 ], self.origin[ 1 ], 0 ) + ( player.bounce[ 0 ], player.bounce[ 1 ], var_26a5d8eefe19e064[ 2 ] );
        player.bounce = undefined;
    }
    
    totaltimeremaining = max( totaltimeremaining, 0.01 );
    self moveto( var_26a5d8eefe19e064, totaltimeremaining );
    return var_26a5d8eefe19e064;
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0xf7ece445, Offset: 0x1996
// Size: 0x1e6
function function_700fa9a786db9bf7( drone )
{
    level endon( #"game_ended" );
    player = self;
    skiptoexplosion = 0;
    
    if ( isdefined( drone ) )
    {
        skiptoexplosion = drone.skiptoexplosion;
        drone unlink();
        drone delete();
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    function_b8df72f77cd54d17( player, 1 );
    allowstances( player, 1 );
    player stopgestureviewmodel( "iw9_ges_pers_redeploy_drone" );
    player unlink( 0 );
    
    if ( !player isonground() )
    {
        player thread function_393248c76f4b14a( skiptoexplosion );
    }
    
    animtime = player function_d311bf8364d81e4();
    animtime *= 0.001;
    thread prdreset( player, animtime );
    player prd_detach();
    
    if ( self.ejectthrust && !player.inlaststand && player.health > 0 )
    {
        player setvelocity( self.ejectvelocity );
    }
    
    if ( isdefined( self.movenode ) )
    {
        self.movenode delete();
    }
    
    waitframe();
    
    if ( level.var_ee434e3af62e4a87.autoparachute == 1 )
    {
        player skydive_deployparachute();
    }
    
    player val::reset( "prd", "weapon_switch" );
    player val::reset( "prd", "base_jumping" );
    player val::reset( "prd", "vehicle_use" );
    player val::reset( "prd", "killstreaks" );
    player val::reset( "prd", "vehicle_use" );
    player val::reset( "prd", "supers" );
    player val::reset( "prd", "melee" );
    
    if ( !player val::get( "super_pickup" ) )
    {
        player val::reset( "prd", "super_pickup" );
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x668e7607, Offset: 0x1b84
// Size: 0x14f
function function_1b4aceff75cc6913( drone )
{
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    self endon( #"death_or_disconnect" );
    player = self;
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight" ] );
    ignorelist = [ drone, player ];
    
    while ( player islinked() && isdefined( drone ) )
    {
        if ( isdefined( player.bounce ) )
        {
            waitframe();
            continue;
        }
        
        tag = "tag_accessory";
        radius = 22;
        tagorigin = player gettagorigin( tag );
        start = tagorigin;
        end = tagorigin + ( 0, 0, radius );
        angles = player gettagangles( tag );
        glassradiusdamage( tagorigin, 100, 10000, 9000 );
        results = physics_shapecast( start, end, drone, angles, contents, ignorelist, "physicsquery_closest" );
        
        if ( isdefined( results ) && results.size > 0 )
        {
            player.bounce = results[ 0 ][ "contact_normal" ];
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0x85d2c91b, Offset: 0x1cdb
// Size: 0x9b
function function_b8df72f77cd54d17( player, lockout )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !lockout )
    {
        player val::set( "prd", "allow_jump", 0 );
        player val::set( "prd", "ads", 0 );
        player val::set( "prd", "sprint", 0 );
        return;
    }
    
    player val::reset( "prd", "allow_jump" );
    player val::reset( "prd", "ads" );
    player val::reset( "prd", "sprint" );
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0x26b5798d, Offset: 0x1d7e
// Size: 0x74
function allowstances( player, lockout )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !lockout )
    {
        player val::set( "prd", "crouch", 0 );
        player val::set( "prd", "prone", 0 );
        return;
    }
    
    player val::reset( "prd", "crouch" );
    player val::reset( "prd", "prone" );
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x9f52c28b, Offset: 0x1dfa
// Size: 0x148
function function_8cc2a87f842d2ab4( player )
{
    self endon( #"entitydeleted" );
    self endon( #"hash_686817783c90da60" );
    player endon( #"disconnect" );
    launchvector = ( 0, 0, 0 );
    
    for ( flag = 0; !flag && isdefined( player ) ; flag = 1 )
    {
        prevorigin = player.origin;
        wait 0.05;
        launchvector = ( player.origin - prevorigin ) * 20;
        
        if ( !isalive( player ) || player.inlaststand || player.health <= 0 )
        {
        }
    }
    
    wait 0.05;
    
    if ( isdefined( player ) )
    {
        if ( player.prdswim )
        {
            player.prdswim = undefined;
            player val::reset( "prd", "allow_movement" );
        }
        
        if ( !player::isreallyalive( player ) )
        {
            function_63a40fce734c7f07( player );
        }
        
        player val::reset( "prd", "allow_jump" );
        player setvelocity( launchvector );
        prdreset( player, 0 );
        player prd_detach();
    }
    
    self notify( #"hash_686817783c90da60" );
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x2ade7004, Offset: 0x1f4a
// Size: 0xf2
function function_aaa75d92cc0cea8b( player )
{
    var_7a191f31aef90fb2 = level.var_ee434e3af62e4a87.maxaltitude - level.var_ee434e3af62e4a87.heightfly;
    
    if ( player.origin[ 2 ] > var_7a191f31aef90fb2 )
    {
        var_e3e46055a856708b = player.origin[ 2 ] + level.var_ee434e3af62e4a87.heightfly - level.var_ee434e3af62e4a87.maxaltitude;
        var_e3e46055a856708b *= 0.5;
        flyheight = level.var_ee434e3af62e4a87.heightfly - var_e3e46055a856708b;
        flyheight = min( flyheight, level.var_ee434e3af62e4a87.heightfly );
    }
    else
    {
        flyheight = level.var_ee434e3af62e4a87.heightfly;
    }
    
    return flyheight;
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x22dc915d, Offset: 0x2045
// Size: 0x15
function function_9f519d4c07d09f31( player )
{
    thread personalredeploydrone_stopuse( player );
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x7930fb7, Offset: 0x2062
// Size: 0x2e
function personalredeploydrone_stopuse( player )
{
    self waittill( #"hash_686817783c90da60" );
    self.stopuse = 1;
    player thread function_700fa9a786db9bf7( self );
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0x2e11896a, Offset: 0x2098
// Size: 0x73
function prdreset( player, waittime )
{
    wait waittime;
    
    if ( isplayer( player ) )
    {
        player player::_setsuit( player.original_suit );
        player function_6af2d51e2f2b6967( 0 );
        
        if ( utility::issharedfuncdefined( #"gametype", #"hash_1cd33abf9cdb1c39" ) )
        {
            player utility::callsharedfunc( #"gametype", #"hash_1cd33abf9cdb1c39" );
        }
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0xd8c79f88, Offset: 0x2113
// Size: 0x50
function setusetime( usetime )
{
    if ( isdefined( self.super ) && isdefined( self.super.staticdata ) )
    {
        self.super.staticdata.usetime = usetime;
    }
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0xa91b5dc4, Offset: 0x216b
// Size: 0x47
function function_5c24caac18447933()
{
    soundentpos = self gettagorigin( "j_wrist_le" );
    soundentity = spawn( "script_model", soundentpos );
    soundentity linkto( self, "j_wrist_le" );
    self.soundentity = soundentity;
    return soundentity;
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0xd61edf3b, Offset: 0x21bb
// Size: 0x21
function function_974704a2b172f18e()
{
    soundent = function_5c24caac18447933();
    waitframe();
    soundent playsoundonmovingent( "eqp_personal_redeploy_drone_activate" );
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x6a658aee, Offset: 0x21e4
// Size: 0x71
function function_4b99283c4169fa15( grenade )
{
    if ( isdefined( self.soundentity ) && isdefined( grenade ) )
    {
        self.soundentity linkto( grenade );
        soundentity = self.soundentity;
        self.soundentity = undefined;
        soundentity playsoundonmovingent( "eqp_personal_redeploy_drone_crashing" );
        grenade waittill( #"explode" );
        prd_stopsound( soundentity );
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x7cf25678, Offset: 0x225d
// Size: 0x89
function function_393248c76f4b14a( instantexplode )
{
    grenadeweap = makeweapon( "prd_grenade_mp" );
    self function_a38d48da4f37779b( grenadeweap );
    self waittill( #"grenade_thrown", grenade );
    function_e5ea93ed6028e1dc( instantexplode );
    grenade thread function_88296649d4599026( self );
    thread function_4b99283c4169fa15( grenade );
    
    if ( instantexplode )
    {
        wait 0.2;
        
        if ( isdefined( grenade ) )
        {
            grenade detonate();
        }
    }
    
    thread function_afcefd1dd1b4951e( 1, grenade );
    thread function_afcefd1dd1b4951e( 0, grenade );
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0xf9e81a7, Offset: 0x22ee
// Size: 0x10f
function function_afcefd1dd1b4951e( ally, grenade )
{
    prdobjid = undefined;
    
    if ( ally && isdefined( self.var_89e34cec212fdf36 ) )
    {
        prdobjid = self.var_89e34cec212fdf36;
    }
    else if ( isdefined( self.var_89a7c24e7869b99c ) )
    {
        prdobjid = self.var_89a7c24e7869b99c;
    }
    
    if ( isdefined( prdobjid ) )
    {
        if ( isdefined( grenade ) )
        {
            objective_onentity( prdobjid, grenade );
            grenade waittill( #"explode" );
        }
        
        if ( !isdefined( self ) )
        {
            objidpoolmanager::returnobjectiveid( prdobjid );
            return;
        }
        
        if ( !ally && self.var_ff9bc12cd6216b1c || ally && self.var_b60073d033fb2e98 )
        {
            return;
        }
        
        if ( ally )
        {
            self.var_b60073d033fb2e98 = 1;
        }
        else
        {
            self.var_ff9bc12cd6216b1c = 1;
        }
        
        objidpoolmanager::returnobjectiveid( prdobjid );
        waitframe();
        
        if ( isdefined( self ) && self.var_b60073d033fb2e98 && self.var_ff9bc12cd6216b1c )
        {
            self.var_b60073d033fb2e98 = undefined;
            self.var_ff9bc12cd6216b1c = undefined;
        }
    }
}

// Namespace br_personal_redeploy_drone
// Params 2
// Checksum 0x1c93d9da, Offset: 0x2405
// Size: 0xa6
function prd_icon( ally, icon )
{
    objid = objidpoolmanager::requestobjectiveid( 1 );
    objective_state( objid, "active" );
    objective_onentity( objid, self );
    function_44a344c68a68f28d( objid, 1 );
    objidpoolmanager::update_objective_icon( objid, icon );
    
    if ( ally )
    {
        self.var_89e34cec212fdf36 = objid;
        objidpoolmanager::objective_mask_showtoplayerteam( objid, self );
    }
    else
    {
        self.var_89a7c24e7869b99c = objid;
        objidpoolmanager::objective_mask_showtoenemyteam( objid, self );
    }
    
    objective_sethideelevation( objid, 1 );
    objective_setshowdistance( objid, 0 );
    objective_setshowoncompass( objid, 0 );
    objidpoolmanager::update_objective_setbackground( objid, 1 );
}

// Namespace br_personal_redeploy_drone
// Params 0
// Checksum 0xd14bc57d, Offset: 0x24b3
// Size: 0x1f
function prd_detach()
{
    if ( self tagexists( "tag_accessory" ) )
    {
        self detach( "misc_vm_pers_redeploy_drone", "tag_accessory_left" );
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0xcf83a91b, Offset: 0x24da
// Size: 0x21
function prd_stopsound( soundentity )
{
    if ( isdefined( soundentity ) )
    {
        soundentity stopsounds();
        waitframe();
        soundentity delete();
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x2c2259d2, Offset: 0x2503
// Size: 0x63
function function_88296649d4599026( player )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    
    if ( isplayer( player ) && player getcamerathirdperson() && isdefined( self ) )
    {
        self setscriptablepartstate( "collision", "none" );
        wait 0.1;
        self setscriptablepartstate( "collision", "neutral" );
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x9d795aff, Offset: 0x256e
// Size: 0x54
function function_e5ea93ed6028e1dc( skiptoexplosion )
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( isdefined( superinfo ) && isdefined( superinfo.staticdata ) )
    {
        analyticslog::logevent_fieldupgradeexpired( self, superinfo.staticdata.id, undefined, istrue( skiptoexplosion ) );
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x5a3e2531, Offset: 0x25ca
// Size: 0x57
function function_63a40fce734c7f07( player )
{
    if ( isplayer( player ) )
    {
        if ( isdefined( player.var_89e34cec212fdf36 ) )
        {
            objidpoolmanager::returnobjectiveid( player.var_89e34cec212fdf36 );
        }
        
        if ( isdefined( player.var_89a7c24e7869b99c ) )
        {
            objidpoolmanager::returnobjectiveid( player.var_89a7c24e7869b99c );
        }
    }
}

// Namespace br_personal_redeploy_drone
// Params 1
// Checksum 0x565c3561, Offset: 0x2629
// Size: 0x23, Type: bool
function function_d3f1e52bc9b50683( player )
{
    return player emp_debuff::is_empd() || player.ishaywire;
}

