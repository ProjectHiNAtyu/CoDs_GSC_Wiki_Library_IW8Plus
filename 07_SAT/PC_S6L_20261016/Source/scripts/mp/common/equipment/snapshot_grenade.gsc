// scripts\mp\common\equipment\snapshot_grenade.gsc  (hash_4303b9176b116c16.gscc) (size: 19802 Bytes / 0x4d5a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6ec52d7 (3337376471)
// size ...... 19802 (0x4d5a)
// includes .. 31  (offset: 0x48d6)
// strings ... 52  (offset: 0x49ce)
// dev strs .. 1   (offset: 0x4d4e)
// exports ... 45  (offset: 0x2f0a)
// cseg ...... 0x3ea + 0x2b20 (0x2f0a)
// imports ... 156 (offset: 0x3612)
// animtree1 . 0   (offset: 0x4d5a)
// animtree2 . 0   (offset: 0x4d5a)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\snapshot;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\chaff_debuff;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\equipment;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\movers;
#using scripts\mp\weapons;

#namespace snapshot_grenade;

// Namespace snapshot_grenade
// Params 0, eflags: 0x1
// Checksum 0x6415ee65, Offset: 0x408
// Size: 0x9
function autoexec main()
{
    snapshot_init();
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0xc9d2f72f, Offset: 0x419
// Size: 0xc6
function snapshot_init()
{
    utility::flag_wait( "equipment_initialized" );
    perkfunctions::function_deeb2f40153920c7( "snapshot_grenade", &function_31d8a948580b1d4e );
    weapons::registerusedcallback( "snapshot_grenade", &snapshot_grenade_used );
    equipment_mp::registercallback( "equip_snapshot_grenade", "onDestroyedByTrophy", &snapshot_grenade_delete );
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_snap", &snapshot_grenade_used );
    utility::registersharedfunc( #"weapons", #"snapshot_bolt_detect", &snapshot_grenade_detect );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #customend:1, #equipref:"equip_snapshot_grenade" } );
    level thread function_2540b16d96d228ff();
    
    /#
        level thread function_e562ab0647c70e43();
    #/
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0xee8a0ec0, Offset: 0x4e7
// Size: 0x7c
function function_2540b16d96d228ff()
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_snapshot_grenade" );
    level.equipment_snapshot_grenade = spawnstruct();
    level.equipment_snapshot_grenade.bundle = bundle;
    level.equipment_snapshot_grenade.equipref = "equip_snapshot_grenade";
    level.equipment_snapshot_grenade.weaponname = bundle.useweapon ?? "snapshot_grenade_mp";
}

// Namespace snapshot_grenade
// Params 1, eflags: 0x4
// Checksum 0xf2ed736, Offset: 0x56b
// Size: 0x22
function private snapshot_onspawnplayer( spawndata )
{
    if ( self.var_4c3cd1cf9d1bb58b )
    {
        self.var_4c3cd1cf9d1bb58b = undefined;
    }
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0x4b9a1408, Offset: 0x595
// Size: 0x31
function function_31d8a948580b1d4e()
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return 0;
    }
    
    owner thread snapshot_grenade_used( self, 0 );
    self detonate();
}

// Namespace snapshot_grenade
// Params 3
// Checksum 0x2e66fb99, Offset: 0x5ce
// Size: 0x294
function snapshot_grenade_used( grenade, isgl, objweapon )
{
    grenade thread script::notifyafterframeend( "death", "end_explode" );
    grenade endon( #"end_explode" );
    grenade thread function_ba3c785f81a99db8();
    challenges::function_3d7a169dbae062fb( "equip_snapshot_grenade", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    var_34417a550a2b843e = istrue( grenade.bundle.var_f3c07d25f505a184 );
    
    if ( isgl )
    {
        grenade waittill( #"missile_stuck", ent, hitloc, surfacetype, velocity, position );
    }
    else
    {
        grenade setotherent( self );
        grenade thread damage::monitordamage( 19, "hitequip", &snapshot_grenade_handle_fatal_damage, &snapshot_grenade_handle_damage );
        emp_debuff::add_emp_ent( grenade );
        grenade emp_debuff::set_apply_emp_callback( &snapshot_grenade_empapplied );
        
        if ( level.killstreak_emp_initialized )
        {
            grenade.ksempapplycallback = &snapshot_grenade_empapplied;
        }
        
        grenade thread snapshot_grenade_watch_cleanup();
        
        if ( var_34417a550a2b843e )
        {
            anglestruct = spawnstruct();
            grenade thread function_e47060b164df8094( anglestruct );
        }
        
        if ( grenade.bundle.var_e61d70ffcc482e6 )
        {
            grenade thread function_e1d9f5ad7100ac6b();
        }
        
        grenade waittill( #"explode", position );
    }
    
    detectionradius = grenade.bundle.detectionradius;
    duration = grenade.bundle.outlineduration;
    
    if ( isdefined( grenade.weapon_object.weaponcustomsettings ) )
    {
        if ( isdefined( grenade.weapon_object.weaponcustomsettings.duration ) )
        {
            duration = grenade.weapon_object.weaponcustomsettings.duration;
        }
        
        if ( isdefined( grenade.weapon_object.weaponcustomsettings.radius ) )
        {
            detectionradius = grenade.weapon_object.weaponcustomsettings.radius;
        }
    }
    
    thread snapshot_grenade_watch_flight( position, grenade.var_517739915deb876c, detectionradius, duration, grenade.bundle, grenade, anglestruct.angles, var_34417a550a2b843e );
}

// Namespace snapshot_grenade
// Params 0, eflags: 0x4
// Checksum 0xf7f352d3, Offset: 0x86a
// Size: 0x55
function private function_e1d9f5ad7100ac6b()
{
    self endon( #"death" );
    childthread function_6dcafcce74288e34();
    childthread function_5a230da6b830456c();
    wait self.bundle.var_74b5c3e640775576 ?? 1;
    
    if ( !self.snapshot_grenade_hit_ground )
    {
        self waittill( #"snapshot_grenade_hit_ground" );
    }
    
    self detonate();
}

// Namespace snapshot_grenade
// Params 0, eflags: 0x4
// Checksum 0xcada20f6, Offset: 0x8c7
// Size: 0x49
function private function_6dcafcce74288e34()
{
    self.snapshot_grenade_velocity = undefined;
    
    while ( true )
    {
        oldpos = self.origin;
        waitframe();
        self.snapshot_grenade_velocity = ( self.origin - oldpos ) / level.framedurationseconds;
    }
}

// Namespace snapshot_grenade
// Params 0, eflags: 0x4
// Checksum 0xcc8104d, Offset: 0x918
// Size: 0x56
function private function_5a230da6b830456c()
{
    while ( true )
    {
        velocity = self.snapshot_grenade_velocity;
        
        if ( isdefined( velocity ) && abs( velocity[ 2 ] ) <= 10 )
        {
            if ( snapshot_grenade_on_ground() )
            {
                self notify( #"snapshot_grenade_hit_ground" );
                self.snapshot_grenade_hit_ground = 1;
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace snapshot_grenade
// Params 0, eflags: 0x4
// Checksum 0xd6bd0ddd, Offset: 0x976
// Size: 0x52, Type: bool
function private snapshot_grenade_on_ground()
{
    caststart = self.origin + ( 0, 0, 1 );
    castend = caststart + ( 0, 0, -1 ) * 5;
    return !trace::ray_trace_passed( caststart, castend, [ self ] );
}

// Namespace snapshot_grenade
// Params 0, eflags: 0x4
// Checksum 0xcf7cea6a, Offset: 0x9d1
// Size: 0x66
function private function_ba3c785f81a99db8()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self endon( #"missile_stuck" );
    self waittill( #"missile_water_impact", var_a923b78f4b77f26b, var_68710ac0de0ae982, var_be7ff3c11cc26733 );
    self.var_517739915deb876c = 1;
}

// Namespace snapshot_grenade
// Params 3
// Checksum 0xafada9c5, Offset: 0xa3f
// Size: 0x104
function snapshot_get_flight_dest( position, direction, ignorelist )
{
    direction = ( 0, 0, 1 );
    caststart = position + direction;
    castend = caststart + direction * 137;
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip" ] );
    castresult = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
    
    if ( castresult.size > 0 )
    {
        castend = castresult[ 0 ][ "position" ];
        
        if ( true )
        {
            castdist = vectordot( castend - caststart, direction );
            
            if ( castdist > 0 )
            {
                if ( castdist >= 50 )
                {
                    castdist = min( castdist - 25, 112 );
                }
                else
                {
                    castdist /= 2;
                }
                
                castend = caststart + direction * castdist;
            }
        }
    }
    else
    {
        castend = caststart + direction * 112;
    }
    
    return castend;
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0xbd5b9b9b, Offset: 0xb4c
// Size: 0x62
function entity_movingplatform_update()
{
    self endon( #"death" );
    self.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        old_origin = self.origin;
        wait 0.05;
        self.velocity = 20 * ( self.origin - old_origin );
    }
}

// Namespace snapshot_grenade
// Params 8
// Checksum 0xf181bc03, Offset: 0xbb6
// Size: 0x615
function snapshot_grenade_watch_flight( position, var_81bf0d29a147ca16, radius, duration, bundle, throwngrenade, angles, var_34417a550a2b843e )
{
    grenade = weapon::_launchgrenade( bundle.useweapon, position, ( 0, 0, 0 ), 100, 1 );
    
    if ( angles && var_34417a550a2b843e )
    {
        grenade.angles = angles;
    }
    
    weapons::grenadeinitialize( grenade, makeweapon( bundle.useweapon ), 0, self );
    grenade ent_manager::registerspawn( 3, &snapshot_grenade_delete );
    grenade setotherent( self );
    grenade setscriptablepartstate( "beacon", "active", 0 );
    grenade setscriptablepartstate( "anims", "deploy", 0 );
    grenade missilehidetrail();
    grenade.equipmentref = "equip_snapshot_grenade";
    grenade.owner = self;
    grenade thread damage::monitordamage( 19, "hitequip", &snapshot_grenade_handle_fatal_damage, &snapshot_grenade_handle_damage );
    emp_debuff::add_emp_ent( grenade );
    grenade emp_debuff::set_apply_emp_callback( &snapshot_grenade_empapplied );
    grenade chaff_debuff::function_3860212a5ec36b56( &function_ef50a180a14ee863 );
    grenade chaff_debuff::function_324dd42a2703bc25( &function_cf5da3d3b3233ff2 );
    grenade thread snapshot_grenade_watch_cleanup();
    grenade endon( #"death" );
    grenade endon( #"explode" );
    thread utility::callsharedfunc( #"analytics", #"hash_8a1c3c9f6fc3016", { #newent:grenade, #eventid:throwngrenade.eventid, #player:self } );
    var_8b4f75f92d97cef3 = bundle.var_9dc3c9b5ba36adbf ?? "snapshot_grenade_danger_mp";
    dangericon = weapon::_launchgrenade( var_8b4f75f92d97cef3, grenade.origin, ( 0, 0, 0 ), 100, 1 );
    dangericon.weapon_name = var_8b4f75f92d97cef3;
    dangericon linkto( grenade );
    
    if ( isplayer( self ) )
    {
        dangericon hidefromplayer( self );
    }
    
    grenade thread snapshot_grenade_cleanup_danger_icon( dangericon );
    data = spawnstruct();
    data.skipdeath = 1;
    grenade thread movers::handle_moving_platforms( data );
    mover = spawn( "script_model", grenade.origin );
    mover.angles = grenade.angles;
    mover setmodel( "tag_origin" );
    grenade linkto( mover, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    grenade thread snapshot_grenade_cleanup_mover( mover );
    waitframe();
    
    if ( grenade.touchedmovingplatform )
    {
        grenade thread entity_movingplatform_update();
    }
    
    destdir = ( 0, 0, 1 );
    destpos = snapshot_get_flight_dest( position, destdir, [ grenade, dangericon ] );
    destdist = vectordot( destpos - position, destdir );
    destangles = ( 0, 0, 0 );
    
    if ( destdist > 0 )
    {
        destratio = destdist / 112;
        desttime = 0.65 * destratio;
        var_f21519752ab42661 = desttime * 0.19;
        var_80c2ce7ffa21100c = desttime * 0.6;
        var_e9c7942b65a4642c = 0.3 * destratio;
        var_a083f24f9e75f7bc = desttime * 0;
        var_4b5052d3b9149865 = desttime * 0.35;
        
        if ( var_34417a550a2b843e )
        {
            desttime *= 1.4;
            var_2dc9c20f8e8ede23 = desttime * 0.7;
            mover rotateto( destangles, var_2dc9c20f8e8ede23, var_2dc9c20f8e8ede23 * 0.25, var_2dc9c20f8e8ede23 * 0.75 );
        }
        else
        {
            mover rotateto( destangles, var_e9c7942b65a4642c, var_a083f24f9e75f7bc, var_4b5052d3b9149865 );
        }
        
        if ( isdefined( grenade.lastmovingplatform ) )
        {
            ismovingplatforment = utility::is_moving_platform_ent( grenade.lastmovingplatform );
            
            if ( ismovingplatforment )
            {
                mover linkto( grenade.lastmovingplatform );
            }
        }
        
        if ( !var_34417a550a2b843e )
        {
            wait 0.3;
        }
        
        if ( ismovingplatforment )
        {
            mover unlink();
            destpos += grenade.velocity * desttime;
        }
        
        if ( var_81bf0d29a147ca16 )
        {
            grenade setscriptablepartstate( "water", "active", 0 );
        }
        else
        {
            grenade setscriptablepartstate( "dust", "active", 0 );
        }
        
        grenade setscriptablepartstate( "anims", "idle", 0 );
        
        if ( var_34417a550a2b843e )
        {
            mover thread function_8de5188050bb093b( destpos, desttime, grenade );
        }
        else
        {
            mover moveto( destpos, desttime, var_f21519752ab42661, var_80c2ce7ffa21100c );
        }
        
        grenade childthread equipment::watch_flight_collision();
        grenade utility::waittill_any_timeout( desttime, "collision_with_platform" );
    }
    else
    {
        mover.angles = destangles;
        wait 0.3;
    }
    
    if ( ismovingplatforment )
    {
        mover linkto( grenade.lastmovingplatform );
    }
    
    detectiondelay = 0;
    wait detectiondelay;
    grenade setscriptablepartstate( "detect", "active", 0 );
    grenade setscriptablepartstate( "anims", "idle", 0 );
    grenade setscriptablepartstate( "beacon", "neutral", 0 );
    
    if ( var_34417a550a2b843e )
    {
        mover function_fb72bdcc52b1569d( 0.25, grenade );
    }
    else
    {
        wait 0.5;
    }
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        grenade [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( grenade );
    }
    
    grenade snapshot_grenade_detect( radius, duration, bundle );
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:position, #attacker:self, #grenade:grenade } );
    grenade thread snapshot_grenade_destroy();
}

// Namespace snapshot_grenade
// Params 3, eflags: 0x4
// Checksum 0xc5f843f7, Offset: 0x11d3
// Size: 0x167
function private function_8de5188050bb093b( destpos, desttime, grenade )
{
    grenade endon( #"death" );
    grenade endon( #"explode" );
    originalpos = self.origin;
    firstdest = vectorlerp( originalpos, destpos, 0.1 );
    var_ff435f1e2486547d = desttime * 0.4;
    self moveto( firstdest, var_ff435f1e2486547d, var_ff435f1e2486547d * 0.7, var_ff435f1e2486547d * 0.3 );
    
    /#
        var_d4c2c07c21f08e04 = getdvarint( @"hash_629a554e8dbdf4b", 0 );
        
        if ( var_d4c2c07c21f08e04 )
        {
            level thread utility::draw_line_for_time( self.origin + ( 10, 0, 0 ), firstdest + ( 10, 0, 0 ), 1, 0, 0, var_ff435f1e2486547d );
        }
    #/
    
    wait var_ff435f1e2486547d * 0.75;
    seconddest = destpos;
    var_6709ba7f7e952d6b = desttime * 0.6;
    self moveto( seconddest, var_6709ba7f7e952d6b, var_6709ba7f7e952d6b * 0.6, var_6709ba7f7e952d6b * 0.4 );
    
    /#
        if ( var_d4c2c07c21f08e04 )
        {
            level thread utility::draw_line_for_time( self.origin + ( 10, 0, 0 ), seconddest + ( 10, 0, 0 ), 1, 0.5, 0, var_6709ba7f7e952d6b );
        }
    #/
    
    wait var_6709ba7f7e952d6b;
}

// Namespace snapshot_grenade
// Params 2, eflags: 0x4
// Checksum 0xa7d58b5, Offset: 0x1342
// Size: 0x12c
function private function_fb72bdcc52b1569d( time, grenade )
{
    grenade endon( #"explode" );
    grenade endon( #"death" );
    var_4755e3ccf2267e99 = 1;
    var_4de2d98e683afa60 = time * 2 / var_4755e3ccf2267e99;
    peakpos = self.origin;
    lowestpos = self.origin - ( 0, 0, 6 );
    
    for ( i = 0; i < var_4755e3ccf2267e99 ; i++ )
    {
        goalpos = i % 2 ? peakpos : lowestpos;
        self moveto( goalpos, var_4de2d98e683afa60 * 1.25, var_4de2d98e683afa60 * 0.5, var_4de2d98e683afa60 * 0.5 );
        
        /#
            var_d4c2c07c21f08e04 = getdvarint( @"hash_629a554e8dbdf4b", 0 );
            
            if ( var_d4c2c07c21f08e04 )
            {
                sphere( goalpos + ( 10, 0, 0 ), 5, ( 1, 1, 1 ), 0, int( var_4de2d98e683afa60 / level.framedurationseconds ) );
            }
        #/
        
        wait var_4de2d98e683afa60;
    }
}

// Namespace snapshot_grenade
// Params 3
// Checksum 0x5ee5c18a, Offset: 0x1476
// Size: 0x292
function snapshot_grenade_detect( radius, duration, bundle )
{
    owner = self.owner;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( self.chaffstunned )
    {
        return;
    }
    
    position = self.origin;
    angles = self.angles;
    outlinedata = snapshot_grenade_createoutlinedata( owner, position, bundle );
    stealtheventbroadcastbytacsight( "decoy_grenade", self.owner, self.origin, 512 );
    raycontents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle" ] );
    detectionradius = radius ?? bundle.detectionradius;
    playertargets = utility::function_1b1340a94b43b874( position, detectionradius );
    
    foreach ( player in playertargets )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !player_utility::function_2b55094fe59356fe( owner, player ) )
        {
            continue;
        }
        
        if ( bundle.requirelos )
        {
            caststart = position;
            castend = player geteye();
            castresult = physics_raycast( caststart, castend, raycontents, undefined, 0, "physicsquery_closest", 1 );
            
            if ( castresult.size > 0 )
            {
                continue;
            }
        }
        
        challenges::function_3d7a169dbae062fb( "equip_snapshot_grenade", owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
        snapshot_grenade_applysnapshot( player, owner, outlinedata, duration, undefined, undefined, bundle );
        
        if ( bundle.var_24747a6fc0869730 && !isdefined( player.perks[ "specialty_snapshot_immunity" ] ) )
        {
            function_d85047fac2ce845b( player, owner, bundle.var_6af80484eb814113 ?? 5, bundle );
        }
    }
    
    if ( bundle.pingenabled && isplayer( owner ) && !owner.ksempd )
    {
        triggerportableradarping( position, owner, detectionradius, 500, "specialty_snapshot_immunity" );
    }
}

// Namespace snapshot_grenade
// Params 3
// Checksum 0xd0493397, Offset: 0x1710
// Size: 0x99
function snapshot_grenade_createoutlinedata( owner, position, bundle )
{
    outlinedata = undefined;
    
    if ( isdefined( bundle ) && bundle.outlineenabled )
    {
        outlinedata = spawnstruct();
        outlinedata.owner = owner;
        outlinedata.position = position;
        outlinedata.isalive = 1;
        outlinedata.targets = [];
        outlinedata.endtimes = [];
        outlinedata.outlineids = [];
    }
    
    return outlinedata;
}

// Namespace snapshot_grenade
// Params 11
// Checksum 0xa83f1bf1, Offset: 0x17b2
// Size: 0x7d3
function snapshot_grenade_applysnapshot( victim, attacker, outlinedata, duration = bundle.outlineduration, var_5ff55f82491e0b69 = 0, skipscoreevents, bundle, isfalseflag, skipdamagefeedback = 0, var_85273e21aef2d871 = 0, skipanalytics = 0 )
{
    if ( isdefined( victim.perks[ "specialty_snapshot_immunity" ] ) )
    {
        if ( !skipdamagefeedback )
        {
            attacker damagefeedback::updatedamagefeedback( "hitsnapshotimmunity" );
        }
        
        if ( isdefined( victim.perks[ "specialty_veteran" ] ) )
        {
            victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
        }
        else if ( isdefined( victim.var_773b81cf576594e5[ "specialty_snapshot_immunity" ] ) )
        {
            victim namespace_9d8e359c3b1041e5::activateperksharedfunc( victim.var_773b81cf576594e5[ "specialty_snapshot_immunity" ] );
        }
        else
        {
            victim namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_tac_resist" );
        }
        
        if ( !isdefined( self.challengedata ) )
        {
            self.challengedata = {};
        }
        
        if ( !isdefined( self.challengedata.bitmodifiers ) )
        {
            self.challengedata.bitmodifiers = [];
        }
        
        self.challengedata.bitmodifiers = arraycombineunique( self.challengedata.bitmodifiers, [ #"hash_8d307fbbcb09dbc7" ] );
        challengeparams = { #effectref:"snapped", #duration:bundle.duration, #equipmentref:"equip_snapshot_grenade", #equipmentent:self, #victim:attacker, #attacker:victim };
        callback::callback( #"hash_10e686549630fd9f", challengeparams );
        return;
    }
    
    if ( victim utility::ent_flag( "snapshot_immunity" ) )
    {
        return;
    }
    
    if ( !skipdamagefeedback )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    if ( bundle.outlineenabled )
    {
        entnum = victim getentitynumber();
        outlinedata.targets[ entnum ] = victim;
        outlinedata.endtimes[ entnum ] = gettime() + duration;
        outlineasset = bundle.outlineasset;
        var_1a193288d5a73281 = bundle.var_62221af6bbe14b08 ?? bundle.outlineasset;
        var_928b959fea793dee = function_e5c9a1f4f1c6a2ea( victim );
        
        if ( !isagent( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"snapshot", #"override_show_to", 0 ) )
            {
                outlinedata.outlineids[ entnum ] = self [[ utility::getsharedfunc( #"snapshot", #"override_show_to" ) ]]( victim, attacker.team, outlineasset, "equipment" );
            }
            else if ( !level.teambased || var_5ff55f82491e0b69 )
            {
            }
            else if ( squad_utility::shouldmodesetsquads() )
            {
                if ( var_928b959fea793dee )
                {
                    victim setscriptablepartstate( "snapshotVFX", "snapshot" );
                }
                else
                {
                    outlinedata.outlineids[ entnum ] = outline::outlineenableforsquad( victim, attacker.team, attacker.sessionsquadid, outlineasset, "equipment" );
                }
            }
            else if ( var_928b959fea793dee )
            {
                victim setscriptablepartstate( "snapshotVFX", "snapshot" );
            }
            else
            {
                outlinedata.outlineids[ entnum ] = snapshot_grenade_outlineenableforteam( victim, attacker.team, outlineasset, "equipment" );
            }
        }
        else if ( var_928b959fea793dee )
        {
            victim setscriptablepartstate( "snapshotVFX", "snapshot" );
        }
        else
        {
            outlinedata.outlineids[ entnum ] = snapshot_grenade_outlineenableforteam( victim, attacker.team, outlineasset, "equipment" );
        }
        
        if ( !var_85273e21aef2d871 && ( isplayer( victim ) || isbot( victim ) ) )
        {
            if ( var_928b959fea793dee )
            {
                victim setscriptablepartstate( "snapshotVFX", "snapshot" );
            }
            
            victim outline::_hudoutlineviewmodelenable( var_1a193288d5a73281, 0 );
            victim snapshot::function_c802f1ac50040a2c();
        }
        
        outlinedata thread snapshot_grenade_update_outlines( attacker, bundle );
        
        if ( !skipscoreevents )
        {
            if ( isfalseflag )
            {
                if ( utility::issharedfuncdefined( #"false_flag", #"hash_c0ae39627bbe3330" ) )
                {
                    self thread [[ utility::getsharedfunc( #"false_flag", #"hash_c0ae39627bbe3330" ) ]]( victim );
                }
            }
            else
            {
                attacker namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "snapshotTag" );
            }
        }
    }
    
    if ( bundle.markerenabled )
    {
        attacker thread snapshot_grenade_create_marker( victim gettagorigin( bundle.markertag ), victim.angles, victim, bundle );
    }
    
    if ( isfalseflag )
    {
        victim.var_9ae31e49bba9af9a = gettime();
    }
    
    victim.var_4c3cd1cf9d1bb58b = 1;
    challengeparams = { #effectref:"snapped", #duration:bundle.duration, #equipmentref:"equip_snapshot_grenade", #equipmentent:self, #victim:victim, #attacker:attacker };
    callback::callback( #"hash_10e686549630fd9f", challengeparams );
    
    if ( isagent( attacker ) )
    {
        foreach ( agent in utility::function_1b1340a94b43b874( victim.origin, 800, 0 ) )
        {
            if ( !( isdefined( attacker ) && isdefined( attacker.team ) ) )
            {
                continue;
            }
            
            if ( !( isdefined( agent ) && isdefined( agent.team ) ) )
            {
                continue;
            }
            
            if ( agent.team != attacker.team )
            {
                continue;
            }
            
            if ( isdefined( agent.fnisinstealthcombat ) && agent [[ agent.fnisinstealthcombat ]]() )
            {
                agent getenemyinfo( victim );
                continue;
            }
            
            agent aieventlistenerevent( "player_snapshotted", victim, victim.origin );
        }
    }
    else if ( !skipscoreevents )
    {
        attacker damage::combatrecordtacticalstat( "equip_snapshot_grenade" );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "snapshotHits" ] ) )
            {
                attacker.leaderboarddata[ "snapshotHits" ] = attacker.leaderboarddata[ "snapshotHits" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "snapshotHits" ] ) )
            {
                [[ level.leaderboardfunc[ "snapshotHits" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "snapshotHits" ] ) )
            {
                attacker.pers[ "snapshotHits" ] = attacker.pers[ "snapshotHits" ] + 1;
            }
        }
    }
    
    if ( !skipanalytics )
    {
        thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #victim:victim, #attacker:attacker, #grenade:self } );
    }
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0x71cda7e5, Offset: 0x1f8d
// Size: 0x7a
function snapshot_grenade_destroy()
{
    self setscriptablepartstate( "destroy", "active", 0 );
    self setscriptablepartstate( "beacon", "neutral", 0 );
    self setscriptablepartstate( "dust", "neutral", 0 );
    self setscriptablepartstate( "water", "neutral", 0 );
    self setscriptablepartstate( "detect", "neutral", 0 );
    self setscriptablepartstate( "anims", "neutral", 0 );
    self missilehidetrail();
    thread snapshot_grenade_delete( 0.35 );
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0xb305476f, Offset: 0x200f
// Size: 0x4c
function snapshot_grenade_delete( delay )
{
    self notify( #"death" );
    ent_manager::deregisterspawn();
    self endon( #"death" );
    self.exploding = 1;
    self setcandamage( 0 );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    self delete();
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0xdec3d8dd, Offset: 0x2063
// Size: 0xc2
function snapshot_grenade_handle_damage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    damage = data.damage;
    
    if ( utility::isbulletdamage( meansofdeath ) )
    {
        if ( isdefined( objweapon ) )
        {
            hits = 1;
            
            if ( damage >= weapons::minegettwohitthreshold() )
            {
                hits += 1;
            }
            
            if ( damage::isfmjdamage( objweapon, meansofdeath ) )
            {
                hits *= 2;
            }
            
            damage = hits * 19;
        }
    }
    
    weapons::equipmenthit( self.owner, attacker, objweapon, meansofdeath );
    return damage;
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0xfc214c06, Offset: 0x212e
// Size: 0x5a
function snapshot_grenade_handle_fatal_damage( data )
{
    attacker = data.attacker;
    
    if ( isdefined( attacker ) && player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self, data.objweapon );
    }
    
    thread snapshot_grenade_destroy();
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x1d693068, Offset: 0x2190
// Size: 0x71
function snapshot_grenade_empapplied( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker killstreaks::givescoreforequipment( self, undefined, 1 );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    thread snapshot_grenade_destroy();
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x9f72443e, Offset: 0x2209
// Size: 0x54
function function_ef50a180a14ee863( data )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    attacker = data.attacker;
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    self.chaffstunned = 1;
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x7b1c0325, Offset: 0x2265
// Size: 0x16
function function_cf5da3d3b3233ff2( data )
{
    self.chaffstunned = 0;
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x4cc7a3fb, Offset: 0x2283
// Size: 0x3e
function function_e47060b164df8094( anglestruct )
{
    self endon( #"death" );
    
    while ( isdefined( self.angles ) )
    {
        anglestruct.angles = self.angles;
        waitframe();
    }
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0xdac5800e, Offset: 0x22c9
// Size: 0x21
function snapshot_grenade_watch_cleanup()
{
    self endon( #"death" );
    snapshot_grenade_watch_cleanup_end_early();
    
    if ( isdefined( self ) )
    {
        thread snapshot_grenade_destroy();
    }
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0x80383f3, Offset: 0x22f2
// Size: 0x53
function snapshot_grenade_watch_cleanup_end_early()
{
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
    }
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x50b0d9b5, Offset: 0x234d
// Size: 0x30
function snapshot_grenade_cleanup_mover( mover )
{
    mover endon( #"death" );
    self waittill( #"death" );
    wait 1;
    mover delete();
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x7f64e265, Offset: 0x2385
// Size: 0x35
function snapshot_grenade_cleanup_danger_icon( dangericon )
{
    dangericon endon( #"death" );
    self waittill( #"death" );
    
    if ( !isdefined( dangericon ) )
    {
        return;
    }
    
    dangericon delete();
}

// Namespace snapshot_grenade
// Params 2
// Checksum 0x7b060703, Offset: 0x23c2
// Size: 0x28a
function snapshot_grenade_update_outlines( attacker, bundle )
{
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    if ( !self.isalive )
    {
        return;
    }
    
    self notify( #"update" );
    self endon( #"update" );
    thread snapshot_grenade_watch_cleanup_outlines();
    
    while ( self.targets.size > 0 )
    {
        foreach ( id, target in self.targets )
        {
            if ( !target.var_e665110f6dc5ad39[ attacker.team ] )
            {
                target.var_21a64ae5aec2ddda = attacker;
                target.var_e665110f6dc5ad39[ attacker.team ] = gettime() + self.endtimes[ id ];
            }
            
            target = self.targets[ id ];
            endtime = self.endtimes[ id ];
            outlineid = self.outlineids[ id ];
            
            if ( !isdefined( target ) || !player::isreallyalive( target ) || gettime() >= endtime || isdefined( attacker ) && attacker.ksempd )
            {
                if ( function_e5c9a1f4f1c6a2ea( target ) )
                {
                    target setscriptablepartstate( "snapshotVFX", "off" );
                    target outline::_hudoutlineviewmodeldisable();
                    target.var_e665110f6dc5ad39[ attacker.team ] = undefined;
                    target.var_21a64ae5aec2ddda = undefined;
                }
                else
                {
                    outline::outlinedisable( outlineid, target );
                    
                    if ( isdefined( target ) )
                    {
                        target outline::_hudoutlineviewmodeldisable();
                        target.var_e665110f6dc5ad39[ attacker.team ] = undefined;
                        target.var_21a64ae5aec2ddda = undefined;
                    }
                }
                
                self.targets[ id ] = undefined;
                self.endtimes[ id ] = undefined;
                self.outlineids[ id ] = undefined;
            }
        }
        
        waitframe();
    }
    
    thread snapshot_grenade_clear_outlines();
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0x85d7eeb8, Offset: 0x2654
// Size: 0x28
function snapshot_grenade_watch_cleanup_outlines()
{
    self endon( #"death" );
    self endon( #"update" );
    snapshot_grenade_watch_cleanup_outlines_end_early();
    thread snapshot_grenade_clear_outlines();
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0x321b6587, Offset: 0x2684
// Size: 0x53
function snapshot_grenade_watch_cleanup_outlines_end_early()
{
    self.owner endon( #"death_or_disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitframe();
    }
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0x1555aca3, Offset: 0x26df
// Size: 0x183
function snapshot_grenade_clear_outlines()
{
    self notify( #"death" );
    self.isalive = 0;
    
    foreach ( id, target in self.targets )
    {
        target = self.targets[ id ];
        outlineid = self.outlineids[ id ];
        
        if ( function_e5c9a1f4f1c6a2ea( target ) )
        {
            target setscriptablepartstate( "snapshotVFX", "off" );
            target outline::_hudoutlineviewmodeldisable();
            attacker = target.var_21a64ae5aec2ddda;
            
            if ( attacker.team )
            {
                target.var_e665110f6dc5ad39[ attacker.team ] = undefined;
                target.var_21a64ae5aec2ddda = undefined;
            }
            
            continue;
        }
        
        outline::outlinedisable( outlineid, target );
        
        if ( isdefined( target ) && ( isplayer( target ) || isbot( target ) ) )
        {
            target outline::_hudoutlineviewmodeldisable();
            attacker = target.var_21a64ae5aec2ddda;
            
            if ( attacker.team )
            {
                target.var_e665110f6dc5ad39[ attacker.team ] = undefined;
                target.var_21a64ae5aec2ddda = undefined;
            }
        }
    }
}

// Namespace snapshot_grenade
// Params 4
// Checksum 0xdd15a8ce, Offset: 0x286a
// Size: 0x114
function snapshot_grenade_outlineenableforteam( var_72bacf1a84917ff4, var_471181657d3e58e6, hudoutlineassetname, prioritygroup )
{
    ignorelist = [];
    bypassspectators = getdvarint( @"hash_10ea538e1c6ce567", 1 );
    
    if ( bypassspectators )
    {
        if ( team_utility::isgameplayteam( var_471181657d3e58e6 ) )
        {
            playersvisibleto = teams::getteamdata( var_471181657d3e58e6, "players" );
            
            foreach ( player in playersvisibleto )
            {
                if ( isdefined( player ) && player.sessionstate == "spectator" )
                {
                    ignorelist[ ignorelist.size ] = player;
                    player thread function_f202e00a995f2fca( var_72bacf1a84917ff4 );
                }
            }
        }
    }
    
    return outline::outlineenableforteam( var_72bacf1a84917ff4, var_471181657d3e58e6, hudoutlineassetname, prioritygroup, ignorelist );
}

// Namespace snapshot_grenade
// Params 1
// Checksum 0x9ae6a497, Offset: 0x2987
// Size: 0x8a
function function_f202e00a995f2fca( var_72bacf1a84917ff4 )
{
    self endon( #"disconnect" );
    var_72bacf1a84917ff4 endon( #"disconnect" );
    level endon( #"game_ended" );
    outlinedisableid = var_72bacf1a84917ff4 getentitynumber();
    
    if ( isplayer( var_72bacf1a84917ff4 ) && !isbot( var_72bacf1a84917ff4 ) )
    {
        outlinedisableid = var_72bacf1a84917ff4 getxuid();
    }
    
    self notify( "force_disable_outline_" + outlinedisableid );
    self endon( "force_disable_outline_" + outlinedisableid );
    self waittill( #"spawned_player" );
    var_72bacf1a84917ff4 hudoutlinedisableforclient( self );
}

// Namespace snapshot_grenade
// Params 4
// Checksum 0x928185e6, Offset: 0x2a19
// Size: 0xe7
function snapshot_grenade_create_marker( position, angles, target, bundle )
{
    marker = spawn( "script_model", position );
    marker.angles = angles;
    
    if ( isdefined( target ) && bundle.liveupdateduration > 0 )
    {
        marker linkto( target );
    }
    
    marker setmodel( bundle.markermodel );
    marker setotherent( self );
    marker setscriptablepartstate( "effects", "active", 0 );
    marker snapshot_grenade_watch_marker_end_early( self, bundle.markerduration, target, bundle.liveupdateduration, bundle );
    level.var_5e33afad7cda3ebd = bundle.markerduration;
    
    if ( isdefined( marker ) )
    {
        marker delete();
    }
    
    target.var_4c3cd1cf9d1bb58b = undefined;
}

// Namespace snapshot_grenade
// Params 5
// Checksum 0x57f335ed, Offset: 0x2b08
// Size: 0x104
function snapshot_grenade_watch_marker_end_early( owner, durationms, target, liveupdatedurationms, bundle )
{
    self endon( #"death" );
    owner endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    endtime = gettime() + durationms;
    liveupdateendtime = bundle.liveupdateduration > 0 ? gettime() + bundle.liveupdateduration : undefined;
    
    while ( endtime > gettime() )
    {
        if ( isdefined( liveupdateendtime ) )
        {
            if ( liveupdateendtime < gettime() )
            {
                self unlink();
                liveupdateendtime = undefined;
                
                if ( isdefined( target ) )
                {
                    target.var_4c3cd1cf9d1bb58b = undefined;
                }
            }
            else if ( !isdefined( target ) )
            {
                self unlink();
                liveupdateendtime = undefined;
            }
            else if ( !player::isreallyalive( target ) )
            {
                self unlink();
                liveupdateendtime = undefined;
                target.var_4c3cd1cf9d1bb58b = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace snapshot_grenade
// Params 0
// Checksum 0xc85644b4, Offset: 0x2c14
// Size: 0xf, Type: bool
function function_9258113638c21420()
{
    return level.var_5e33afad7cda3ebd ?? 0;
}

// Namespace snapshot_grenade
// Params 4, eflags: 0x4
// Checksum 0xc3a42d4b, Offset: 0x2c2c
// Size: 0xa2
function private function_d85047fac2ce845b( victim, attacker, duration, bundle )
{
    icon = victim entityheadicons::setheadicon_singleimage( attacker.team, bundle.var_6f10f8164a16bc07 ?? "hud_icon_new_marked", 8, 1, 5000, 500, undefined, 1, 1 );
    victim.var_f3b3baa8a49ac1e[ attacker.team ] = gettime() + bundle.var_6af80484eb814113 * 1000;
    victim thread function_3b042cee2067f437( attacker, icon, duration, bundle );
}

// Namespace snapshot_grenade
// Params 4, eflags: 0x4
// Checksum 0x7db9c947, Offset: 0x2cd6
// Size: 0xac
function private function_3b042cee2067f437( attacker, icon, duration, bundle )
{
    victim = self;
    level endon( #"game_ended" );
    victim endon( #"disconnect" );
    attacker.combatscoutvictim = victim;
    utility::waittill_any_ents_or_timeout_return( duration, victim, "death" );
    
    while ( bundle.var_20638996ec6d22e5 && isdefined( victim.perks[ "specialty_snapshot_counter_smoke" ] ) )
    {
        utility::waittill_any_ents_or_timeout_return( duration, victim, "death" );
        continue;
    }
    
    entityheadicons::setheadicon_deleteicon( icon );
}

// Namespace snapshot_grenade
// Params 1, eflags: 0x4
// Checksum 0x45b0d012, Offset: 0x2d8a
// Size: 0x45, Type: bool
function private function_e5c9a1f4f1c6a2ea( victim )
{
    bundle = level.equipment_snapshot_grenade.bundle;
    return bundle.snapshot_grenade_use_scriptable && victim getscriptablehaspart( "snapshotVFX" );
}

/#

    // Namespace snapshot_grenade
    // Params 0, eflags: 0x4
    // Checksum 0x19100e71, Offset: 0x2dd8
    // Size: 0x132, Type: dev
    function private function_e562ab0647c70e43()
    {
        var_cc525dfcf0144734 = undefined;
        bundle = level.equipment_snapshot_grenade.bundle;
        
        while ( true )
        {
            if ( getdvarint( @"hash_8e368ea3e2b10ed2", 0 ) )
            {
                if ( var_cc525dfcf0144734 )
                {
                    var_cc525dfcf0144734 snapshot_grenade_clear_outlines();
                }
                
                host = gamelogic_mp::gethostplayer();
                outlinedata = snapshot_grenade_createoutlinedata( host, host.origin, bundle );
                
                foreach ( player in level.players )
                {
                    if ( !player::isreallyalive( player ) )
                    {
                        continue;
                    }
                    
                    player snapshot_grenade_applysnapshot( player, host, outlinedata, bundle.duration, undefined, undefined, bundle );
                }
                
                var_cc525dfcf0144734 = outlinedata;
                setdvar( @"hash_8e368ea3e2b10ed2", 0 );
            }
            
            waitframe();
        }
    }

#/
