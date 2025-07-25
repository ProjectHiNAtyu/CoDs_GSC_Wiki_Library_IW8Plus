// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

hoopty_truck_init()
{
    var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "hoopty_truck", 1 );
    var_0.destroycallback = ::hoopty_truck_explode;
    hoopty_truck_initoccupancy();
    hoopty_truck_initinteract();
    playerzombiesupersprint();
    playerzombiestreamwaittillcomplete();
    hoopty_truck_initfx();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hoopty_truck", "init" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hoopty_truck", "init" ) ]]();

    hoopty_truck_initspawning();
    hoopty_truck_initlate();
}

hoopty_truck_initlate()
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hoopty_truck", "initLate" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hoopty_truck", "initLate" ) ]]();
}

hoopty_truck_initoccupancy()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( "hoopty_truck", 1 );
    var_0.enterendcallback = ::hoopty_truck_enterend;
    var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
    var_0.exitendcallback = ::hoopty_truck_exitend;
    var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
    var_0.exitextents["front"] = 75;
    var_0.exitextents["back"] = 105;
    var_0.exitextents["left"] = 35;
    var_0.exitextents["right"] = 35;
    var_0.exitextents["top"] = 87;
    var_0.exitextents["bottom"] = 0;
    var_1 = "front";
    var_0.exitoffsets[var_1] = ( 58, 0, 55 );
    var_0.exitdirections[var_1] = "front";
    var_1 = "front_right";
    var_0.exitoffsets[var_1] = ( 17, 16, 73 );
    var_0.exitdirections[var_1] = "right";
    var_1 = "back_left";
    var_0.exitoffsets[var_1] = ( -78, 16, 73 );
    var_0.exitdirections[var_1] = "back";
    var_1 = "back_right";
    var_0.exitoffsets[var_1] = ( -78, -16, 73 );
    var_0.exitdirections[var_1] = "back";
    var_2 = [];
    var_2[var_2.size] = "driver";
    var_2[var_2.size] = "front_right_rear";
    var_2[var_2.size] = "back_right_rear";
    var_2[var_2.size] = "back_left_rear";
    var_2[var_2.size] = "front_left_rear";
    var_3 = "driver";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "hoopty_truck", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "back_left_rear", "back_left", "front_right", "front" ];
    var_0.exitoffsets[var_3] = ( 17, 16, 73 );
    var_0.exitdirections[var_3] = "left";
    var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
    var_4.damagemodifier = 0.5;
    var_4.animtag = "tag_seat_0";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.spawnpriority = 10;
    var_4.underbridge_reinforce_enemy_monitor = "ping_vehicle_driver";
    var_3 = "front_left_rear";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "hoopty_truck", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "back_left_rear", "back_left", "front_right_rear", "front" ];
    var_0.exitoffsets[var_3] = ( -23, 16, 73 );
    var_0.exitdirections[var_3] = "left";
    var_4.animtag = "tag_seat_2";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.underbridge_reinforce_enemy_monitor = "ping_vehicle_rider";
    var_3 = "front_right_rear";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "hoopty_truck", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "back_right_rear", "back_right", "front_left_rear", "front" ];
    var_0.exitoffsets[var_3] = ( -23, -16, 73 );
    var_0.exitdirections[var_3] = "right";
    var_4.animtag = "tag_seat_4";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.underbridge_reinforce_enemy_monitor = "ping_vehicle_rider";
    var_3 = "back_left_rear";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "hoopty_truck", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "driver", "back_left", "back_right_rear", "front" ];
    var_0.exitoffsets[var_3] = ( -78, 16, 73 );
    var_0.exitdirections[var_3] = "left";
    var_4.animtag = "tag_seat_3";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.underbridge_reinforce_enemy_monitor = "ping_vehicle_rider";
    var_3 = "back_right_rear";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "hoopty_truck", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "front_right", "back_right", "back_left_rear", "front" ];
    var_0.exitoffsets[var_3] = ( -78, -16, 73 );
    var_0.exitdirections[var_3] = "right";
    var_4.animtag = "tag_seat_5";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.underbridge_reinforce_enemy_monitor = "ping_vehicle_rider";
}

hoopty_truck_initinteract()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( "hoopty_truck", 1 );
    var_0.seatenterarrays["driver"] = [ "driver" ];
    var_0.seatenterarrays["front_left_rear"] = [ "front_left_rear" ];
    var_0.seatenterarrays["front_right_rear"] = [ "front_right_rear" ];
    var_0.seatenterarrays["back_left_rear"] = [ "back_left_rear" ];
    var_0.seatenterarrays["back_right_rear"] = [ "back_right_rear" ];
}

playerzombiesupersprint()
{
    var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_132E1( "hoopty_truck", 1 );
    var_0.id = 12;
    var_0.seatids["driver"] = 0;
    var_0.seatids["front_right"] = 1;
    var_0.seatids["front_left_rear"] = 2;
    var_0.seatids["front_right_rear"] = 3;
    var_0.seatids["back_left_rear"] = 4;
    var_0.seatids["back_right_rear"] = 5;
}

playerzombiestreamwaittillcomplete()
{
    scripts\cp_mp\vehicles\vehicle_damage::_id_131DF( "hoopty_truck", 1000 );
    var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle( "hoopty_truck" );
    var_0.class = "medium_light";
    scripts\cp_mp\vehicles\vehicle_damage::_id_131B3( "hoopty_truck" );
    scripts\cp_mp\vehicles\vehicle_damage::_id_131EB( "hoopty_truck", 6 );
    scripts\cp_mp\vehicles\vehicle_damage::_id_131E4( "hoopty_truck", ::hoopty_truck_deathcallback );
    scripts\cp_mp\vehicles\vehicle_damage::_id_131EE( "hoopty_truck_mp", 3 );
}

hoopty_truck_initfx()
{
    level._effect["hoopty_truck_explode"] = loadfx( "vfx/iw8/veh/scriptables/vfx_veh_explosion_sedan.vfx" );
}

hoopty_truck_create( var_0, var_1 )
{
    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    var_0.modelname = "veh8_civ_lnd_zuniform_physics";
    var_0.targetname = "hoopty_truck";
    var_0.vehicletype = "zuniform_physics_mp";
    var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( var_0, var_1 );

    if ( !isdefined( var_2 ) )
        return undefined;

    scripts\cp_mp\vehicles\vehicle::_id_131AE( var_2, "hoopty_truck", var_0 );
    var_2.objweapon = getcompleteweaponname( "hoopty_truck_mp" );
    _applysalesdiscount::_id_131A1( var_2 );
    scripts\cp_mp\vehicles\vehicle::_id_131AF( var_2, var_0 );
    thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped( var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hoopty_truck", "create" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hoopty_truck", "create" ) ]]( var_2 );

    return var_2;
}

hoopty_truck_explode( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_0 = spawnstruct();
        var_0.inflictor = self;
        var_0.objweapon = "hoopty_truck_mp";
        var_0.meansofdeath = "MOD_EXPLOSIVE";
    }

    scripts\cp_mp\vehicles\vehicle_damage::_id_131D7( var_0 );
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants( self, var_0 );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals( undefined, undefined, 1 );
    thread hoopty_truck_deletenextframe();

    if ( !istrue( level.suppressvehicleexplosion ) )
    {
        var_2 = self gettagorigin( "tag_origin" );
        var_3 = scripts\engine\utility::ter_op( isdefined( var_0.attacker ) && isent( var_0.attacker ), var_0.attacker, self );
        self radiusdamage( var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "hoopty_truck_mp" );
        playfx( scripts\engine\utility::getfx( "hoopty_truck_explode" ), var_2, anglestoforward( self.angles ), anglestoup( self.angles ) );
        playsoundatpos( var_2, "car_explode" );
        earthquake( 0.4, 800, var_2, 0.7 );
        playrumbleonposition( "grenade_rumble", var_2 );
        physicsexplosionsphere( var_2, 500, 200, 1 );
    }
}

hoopty_truck_deletenextframe()
{
    scripts\cp_mp\vehicles\vehicle::_id_131F7( self );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hoopty_truck", "delete" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hoopty_truck", "delete" ) ]]( self );

    waitframe();
    scripts\cp_mp\vehicles\vehicle::_id_131F8( self );
}

hoopty_truck_deathcallback( var_0 )
{
    thread hoopty_truck_explode( var_0 );
    return 1;
}

hoopty_truck_enterend( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_4.success ) )
        hoopty_truck_enterendinternal( var_0, var_1, var_2, var_3, var_4 );
}

hoopty_truck_enterendinternal( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "driver" )
    {
        var_0 setotherent( var_3 );
        var_0 setentityowner( var_3 );
        var_3 controlslinkto( var_0 );
    }

    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer( var_0, var_1, var_2 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter( var_0, var_2, var_1, var_3 );
}

hoopty_truck_exitend( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_4.success ) )
        hoopty_truck_exitendinternal( var_0, var_1, var_2, var_3, var_4 );
}

hoopty_truck_exitendinternal( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "driver" )
    {
        var_0 setotherent( undefined );
        var_0 setentityowner( undefined );

        if ( !istrue( var_4.playerdisconnect ) )
            var_3 controlsunlink();
    }

    if ( !istrue( var_4.playerdisconnect ) )
    {
        var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit( var_3, var_2, var_4 );

        if ( !var_5 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( var_3 );
            else
                var_3 suicide();
        }
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit( var_0, var_1, var_2, var_3 );
}

hoopty_truck_initspawning()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "hoopty_truck", 1 );
    var_0.maxinstancecount = 2;
    var_0.priority = 75;
    var_0.getspawnstructscallback = ::hoopty_truck_getspawnstructscallback;
    var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc( "hoopty_truck", "spawnCallback" );
    var_0.clearancecheckradius = 110;
    var_0.clearancecheckheight = 90;
    var_0.clearancecheckminradius = 110;
}

hoopty_truck_getspawnstructscallback()
{
    var_0 = scripts\engine\utility::getstructarray( "hooptytruck_spawn", "targetname" );

    if ( var_0.size > 0 )
    {
        var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag( var_0, 1 );

        if ( var_0.size > 1 )
            var_0 = scripts\engine\utility::array_randomize( var_0 );
    }

    return var_0;
}
