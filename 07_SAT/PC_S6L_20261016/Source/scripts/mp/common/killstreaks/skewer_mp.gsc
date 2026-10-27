// scripts\mp\common\killstreaks\skewer_mp.gsc  (hash_700a9772cdbd4cf7.gscc) (size: 9795 Bytes / 0x2643 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20f56c0b (552954891)
// size ...... 9795 (0x2643)
// includes .. 12  (offset: 0x24df)
// strings ... 15  (offset: 0x253f)
// dev strs .. 2   (offset: 0x262b)
// exports ... 24  (offset: 0x16a7)
// cseg ...... 0x160 + 0x1547 (0x16a7)
// imports ... 92  (offset: 0x1a67)
// animtree1 . 0   (offset: 0x2643)
// animtree2 . 0   (offset: 0x2643)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\objidpoolmanager;

#namespace skewer_mp;

// Namespace skewer_mp
// Params 0, eflags: 0x1
// Checksum 0xe95154b7, Offset: 0x17e
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "skewer" ), &init );
}

// Namespace skewer_mp
// Params 0
// Checksum 0x71a5ff03, Offset: 0x19d
// Size: 0x1bf
function init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "skewer", &tryuseskewer );
    }
    
    bundle = level.streakglobals.streakbundles[ "skewer" ];
    
    if ( bundle.var_570e727ef768ff08 )
    {
        level._effect[ "skewer_impact_ground" ] = loadfxasset( bundle.var_570e727ef768ff08 );
    }
    
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "skewer", bundle.projectileweapon, #"oneshot" );
    
    while ( !level.var_efe904b9522300b6 )
    {
        waitframe();
    }
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        foreach ( proasset in bundle.var_8f21800662496353 )
        {
            proassetname = proasset.proasset;
            probundle = level.streakglobals.var_91bdb7de5b47da10[ proassetname ];
            
            if ( probundle.projectileweapon && probundle.projectileweapon != bundle.projectileweapon )
            {
                namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "skewer", probundle.projectileweapon, #"oneshot" );
            }
        }
    }
}

// Namespace skewer_mp
// Params 1
// Checksum 0x7ccc0d80, Offset: 0x364
// Size: 0xe, Type: bool
function weapongivenskewer( streakinfo )
{
    return true;
}

// Namespace skewer_mp
// Params 1
// Checksum 0xf224d511, Offset: 0x37b
// Size: 0x1a8, Type: bool
function tryuseskewer( streakinfo )
{
    self endon( #"death" );
    streakinfo.var_5c576910469d4fde = &function_5c576910469d4fde;
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    streakinfo.streakduration = streakinfo.bundle.var_cdaed197fb91720e;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = streakinfo.bundle;
    gestureweaponobj = makeweapon( bundle.deployweaponname );
    animationresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, gestureweaponobj );
    
    if ( !animationresult )
    {
        return false;
    }
    
    used_splash_ref = bundle.usedsplashref;
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( used_splash_ref, self );
    }
    
    var_65934120c2efeb81 = undefined;
    
    if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
    {
        self [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        var_65934120c2efeb81 = 2;
    }
    
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "skewer" + "_use", #"use", 1, var_65934120c2efeb81 );
    level thread skewer_deploy( streakinfo, self );
    return true;
}

// Namespace skewer_mp
// Params 1
// Checksum 0x3b699fde, Offset: 0x52c
// Size: 0x22b
function function_4a5e33db8e197e8a( streakinfo )
{
    bundle = streakinfo.bundle;
    var_29a6e8264a251d9d = bundle.var_cdaed197fb91720e ?? 10;
    seektime = 0;
    var_7a9573bab3f7049b = undefined;
    var_fc7e954a739b4a10 = arrayrandomize( teams::getenemyplayers( self.team, 1 ) );
    
    if ( bundle.var_a236d4bd9c620d78 )
    {
        while ( seektime < var_29a6e8264a251d9d )
        {
            foreach ( aliveenemyplayer in var_fc7e954a739b4a10 )
            {
                if ( !skewer_cantarget( self, aliveenemyplayer, bundle ) )
                {
                    continue;
                }
                
                var_7a9573bab3f7049b = aliveenemyplayer;
                
                if ( aliveenemyplayer.isonobjective || aliveenemyplayer == level.flagcarrier || aliveenemyplayer.ishvt || aliveenemyplayer.isbombcarrier || aliveenemyplayer.var_b87cafbca06df20f )
                {
                    streakinfo.var_f0b7b31392e82fa8 = aliveenemyplayer;
                    return aliveenemyplayer;
                }
                
                if ( aliveenemyplayer == self.lastkilledby )
                {
                    streakinfo.var_efd6634019b55dfd = aliveenemyplayer;
                    var_ea7309514763eeab = aliveenemyplayer;
                }
            }
            
            if ( var_ea7309514763eeab )
            {
                return var_ea7309514763eeab;
            }
            
            if ( var_7a9573bab3f7049b )
            {
                return var_7a9573bab3f7049b;
            }
            
            seektime += 1;
            wait 1;
        }
        
        return;
    }
    
    while ( seektime < var_29a6e8264a251d9d )
    {
        foreach ( aliveenemyplayer in var_fc7e954a739b4a10 )
        {
            if ( skewer_cantarget( self, aliveenemyplayer, bundle ) )
            {
                return aliveenemyplayer;
            }
        }
        
        seektime += 1;
        wait 1;
    }
}

// Namespace skewer_mp
// Params 2
// Checksum 0xd7b4c36, Offset: 0x75f
// Size: 0x178
function skewer_deploy( streakinfo, owner )
{
    /#
        if ( getdvarint( @"scr_sat_skewer_debug", 0 ) )
        {
            owner function_7f1e887694bf2e0b( streakinfo, owner );
            return;
        }
    #/
    
    bundle = streakinfo.bundle;
    targetplayer = owner function_4a5e33db8e197e8a( streakinfo );
    
    if ( !targetplayer )
    {
        if ( owner && utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_6c2f8a1485a50005" );
        }
        
        return 1;
    }
    
    owner thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, #"arrive", 1 );
    
    if ( bundle.skewermarktarget )
    {
        owner.var_f06eba471e409bda = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", owner, [], owner );
    }
    
    if ( isdefined( owner.var_f06eba471e409bda ) )
    {
        targetmarkergroups::targetmarkergroup_markentity( targetplayer, owner.var_f06eba471e409bda );
    }
    
    spawnlocation = targetplayer.origin + ( 0, 0, bundle.var_6392536ea0a03275 ?? 10000 );
    thread function_1023fed46168a152( targetplayer, streakinfo, owner );
    thread function_a327a7847d525042( targetplayer, streakinfo );
    wait bundle.skeweractivationdelay ?? 2;
    function_505ddadd5b410a25( streakinfo, owner, spawnlocation, targetplayer );
    return 1;
}

// Namespace skewer_mp
// Params 3
// Checksum 0x3d29bb85, Offset: 0x8e0
// Size: 0xa3
function function_1023fed46168a152( targetplayer, streakinfo, owner )
{
    bundle = streakinfo.bundle;
    delay = bundle.var_dc649673655853b ?? 2;
    
    if ( delay )
    {
        wait delay;
    }
    
    if ( targetplayer && owner )
    {
        var_b6b22c299ee97b5b = bundle.var_b6b22c299ee97b5b ?? "ui_icon_waypoint_finish";
        function_39602c2fe2efb342( targetplayer, var_b6b22c299ee97b5b, owner );
        function_a09d93d7a1405c85( targetplayer, var_b6b22c299ee97b5b, targetplayer );
        targetplayer killstreak_utility::function_3e94cbbe710e9a77( "skewer" );
    }
}

// Namespace skewer_mp
// Params 3
// Checksum 0x510a47d1, Offset: 0x98b
// Size: 0x115, Type: bool
function skewer_cantarget( owner, aliveenemyplayer, bundle )
{
    if ( isdefined( aliveenemyplayer.perks[ "specialty_blindeye" ] ) )
    {
        return false;
    }
    
    if ( bundle.var_7a7ef411cfb9c931 && aliveenemyplayer.isjuggernaut )
    {
        return false;
    }
    
    if ( bundle.var_1a151397be6fc89b && aliveenemyplayer ismeatshieldvictim() )
    {
        return false;
    }
    
    collisioncontents = physics_createcontents( [ "physicscontents_missileclip" ] );
    hitents = physics_raycast( aliveenemyplayer utility::function_f02ebab438642e16(), aliveenemyplayer.origin + anglestoup( aliveenemyplayer.angles ) * 1000, collisioncontents, aliveenemyplayer, 0, "physicsquery_all" );
    
    if ( hitents.size > 0 )
    {
        return false;
    }
    
    var_db8abe2f381f4aa3 = bundle.var_d99c9496d8505e9c ?? 3000;
    
    if ( isdefined( aliveenemyplayer.lastspawntime ) && gettime() - aliveenemyplayer.lastspawntime <= var_db8abe2f381f4aa3 )
    {
        return false;
    }
    
    return true;
}

// Namespace skewer_mp
// Params 4
// Checksum 0x3d86b99d, Offset: 0xaa9
// Size: 0x2f0
function function_505ddadd5b410a25( streakinfo, owner, spawnlocation, targetplayer )
{
    if ( isdefined( streakinfo.var_3c18721e40f0f0ad ) )
    {
        targetposition = streakinfo.var_3c18721e40f0f0ad;
    }
    else if ( targetplayer.origin )
    {
        targetentity = targetplayer;
        targetposition = targetplayer.origin;
        streakinfo.var_abef7d9ea14f9845 = 1;
    }
    else
    {
        assertmsg( "<dev string:x24>" );
        targetposition = getgroundposition( spawnlocation, 20 );
    }
    
    bundle = streakinfo.bundle;
    missile = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( makeweapon( bundle.projectileweapon ), spawnlocation, targetposition, owner );
    missile setentityowner( owner );
    missile setotherent( owner );
    missile.weapon_name = bundle.projectileweapon;
    missile.team = owner.team;
    missile.streakinfo = streakinfo;
    missile.streakref = bundle.killstreakref;
    
    if ( isdefined( targetentity ) )
    {
        missile missile_settargetent( targetentity );
    }
    else
    {
        missile missile_settargetpos( targetposition );
    }
    
    missile.targetplayer = targetplayer;
    missile.killcament = spawn( "script_model", spawnlocation + anglestoforward( missile.angles ) * bundle.var_d7fabe1b86eb19ab * -1 - anglestoright( missile.angles ) * bundle.var_a7ccfd88ec244f09 - anglestoup( missile.angles ) * bundle.var_a7ccfd88ec244f09 );
    missile.killcament setmodel( "tag_origin" );
    missile.killcament linkto( missile, "tag_origin" );
    thread function_fbbc7f80abcb4794( streakinfo, owner, targetplayer, missile, missile.killcament );
    thread function_1b12bea1b9820ce5( streakinfo, owner, targetplayer, missile, missile.killcament );
    thread function_9df638db9c61c380( missile, targetposition, bundle );
    
    if ( bundle.var_44c284ddb0368e40 > 0 && isdefined( bundle.var_283f9e49006a0ec ) )
    {
        thread function_8647a98ab97173fd( missile, targetposition, bundle );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        missile [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Air", owner );
    }
    
    if ( streakinfo.var_abef7d9ea14f9845 )
    {
        targetplayer waittill( #"death_or_disconnect" );
        waitframe();
        
        if ( !isdefined( missile ) )
        {
            return;
        }
        
        if ( streakinfo.var_3c18721e40f0f0ad )
        {
            missile missile_settargetpos( streakinfo.var_3c18721e40f0f0ad );
        }
    }
}

// Namespace skewer_mp
// Params 2
// Checksum 0x3cf6aace, Offset: 0xda1
// Size: 0x71
function function_a327a7847d525042( targetplayer, streakinfo )
{
    if ( !targetplayer )
    {
        return;
    }
    
    lastknownposition = targetplayer.origin;
    targetplayer waittill( #"death_or_disconnect" );
    streakinfo.var_3c18721e40f0f0ad = targetplayer.origin ?? lastknownposition;
    
    if ( isdefined( targetplayer ) )
    {
        targetplayer killstreak_utility::function_b3c5f355ab785704( "skewer" );
    }
}

// Namespace skewer_mp
// Params 0
// Checksum 0x6d2ec187, Offset: 0xe1a
// Size: 0xa3
function skewer_on_player_death()
{
    bundle = level.streakglobals.streakbundles[ "skewer" ];
    fxent = spawn( "script_model", self.origin );
    
    if ( level._effect[ "skewer_impact_ground" ] )
    {
        playfx( utility::getfx( "skewer_impact_ground" ), self.origin, ( 0, 0, 1 ) );
    }
    
    var_c4216b8b8991251a = bundle.var_fcee5f888003d447 ?? "ui_icon_death_spawn";
    function_a09d93d7a1405c85( self, var_c4216b8b8991251a, fxent );
}

// Namespace skewer_mp
// Params 2
// Checksum 0x5280f6cd, Offset: 0xec5
// Size: 0xad, Type: bool
function function_ed7d27467dbd1660( missile, pos )
{
    missileorigin = missile ? missile.origin : pos;
    
    if ( abs( self.origin[ 2 ] - missileorigin[ 2 ] ) > 60 || distance2dsquared( self.origin, missileorigin ) > squared( 24 ) )
    {
        return false;
    }
    
    ignorelist = missile ? [ self, missile ] : [ self ];
    
    if ( !trace::ray_trace_passed( self getcentroid(), missileorigin, ignorelist, trace::create_shotclip_contents() ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skewer_mp
// Params 4
// Checksum 0xdf32ad9a, Offset: 0xf7b
// Size: 0xb6
function skewer_cleanup( streakinfo, owner, targetplayer, killcament )
{
    if ( killcament )
    {
        killcament delete();
    }
    
    if ( isdefined( owner.var_f06eba471e409bda ) )
    {
        targetmarkergroups::targetmarkergroup_unmarkentity( targetplayer, owner.var_f06eba471e409bda );
        targetmarkergroups::targetmarkergroup_off( owner.var_f06eba471e409bda );
        owner.var_f06eba471e409bda = undefined;
    }
    
    if ( targetplayer )
    {
        targetplayer killstreak_utility::function_b3c5f355ab785704( "skewer" );
    }
    
    owner killstreak_utility::recordkillstreakendstats( streakinfo );
    owner function_4d70988417449205();
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
}

// Namespace skewer_mp
// Params 5
// Checksum 0xd5e05c48, Offset: 0x1039
// Size: 0x7b
function function_fbbc7f80abcb4794( streakinfo, owner, targetplayer, missile, killcament )
{
    missile endon( #"missile_impact" );
    missile waittill( #"missile_water_impact", vel, pos, normal );
    missile notify( #"missile_impact", undefined, pos );
}

// Namespace skewer_mp
// Params 5
// Checksum 0x1dc2f77b, Offset: 0x10bc
// Size: 0x161
function function_1b12bea1b9820ce5( streakinfo, owner, targetplayer, missile, killcament )
{
    missile.var_bc286fce9fff9062 = 1;
    missile waittill( #"missile_impact", hitent, pos );
    
    if ( targetplayer && hitent == targetplayer )
    {
        targetplayer skewer_on_player_death();
        
        if ( owner )
        {
            owner thread points::doscoreevent( #"any_skewer_kill" );
        }
    }
    else if ( targetplayer && targetplayer function_ed7d27467dbd1660( missile, pos ) )
    {
        targetplayer dodamage( 1000, missile ? missile.origin : pos, owner, missile, "MOD_IMPACT", missile.weapon_object );
        targetplayer skewer_on_player_death();
        
        if ( owner )
        {
            owner thread points::doscoreevent( #"any_skewer_kill" );
        }
    }
    else if ( owner )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hud" ][ #"showerrormessage" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            owner [[ var_32dbca3143d9c4a5 ]]( %"hash_490ec7150908ab77" );
        }
    }
    
    missile thread function_526d5c57e71b1a26( streakinfo, targetplayer.origin ?? pos );
    skewer_cleanup( streakinfo, owner, targetplayer, killcament );
}

// Namespace skewer_mp
// Params 2
// Checksum 0xfc167ec, Offset: 0x1225
// Size: 0xcc
function function_526d5c57e71b1a26( streakinfo, pos )
{
    if ( !getdvarint( @"hash_affc5497f3873b34", 0 ) )
    {
        destroyedmissile = spawn( "script_model", pos + ( 0, 0, 1 ) * 25 );
        destroyedmissile setmodel( streakinfo.bundle.var_cd691e6ee9786ee7 );
        destroyedmissile.angles = ( 90, 0, 0 );
        destroyedmissile notsolid();
        destroyedmissile setscriptablepartstate( #"hash_e152ca55a91b2e8b", #"hit" );
        destroyedmissile setscriptablepartstate( #"destroy", #"on" );
        wait 3;
        
        if ( destroyedmissile )
        {
            destroyedmissile delete();
        }
    }
}

// Namespace skewer_mp
// Params 3
// Checksum 0xe330d38f, Offset: 0x12f9
// Size: 0x69
function function_9df638db9c61c380( missile, targetposition, bundle )
{
    while ( missile && missile.origin[ 2 ] - targetposition[ 2 ] > bundle.var_5a658d3d1ddf9e5f )
    {
        waitframe();
    }
    
    if ( missile )
    {
        missile setscriptablepartstate( #"hash_66eda7d123d0b506", #"open", 0 );
    }
}

// Namespace skewer_mp
// Params 3
// Checksum 0xc0fd7024, Offset: 0x136a
// Size: 0x93
function function_8647a98ab97173fd( missile, targetposition, bundle )
{
    while ( missile && missile.targetplayer && missile.origin[ 2 ] - targetposition[ 2 ] > bundle.var_44c284ddb0368e40 )
    {
        waitframe();
    }
    
    if ( missile && missile.targetplayer )
    {
        missile.targetplayer playsoundtoplayer( bundle.var_283f9e49006a0ec, missile.targetplayer );
    }
}

// Namespace skewer_mp
// Params 1, eflags: 0x4
// Checksum 0x8369473d, Offset: 0x1405
// Size: 0x86
function private function_5c576910469d4fde( params )
{
    streakinfo = params.streakinfo;
    victim = params.victim;
    
    if ( streakinfo.var_f0b7b31392e82fa8 == victim )
    {
        return streakinfo.bundle.var_16c951219879493f;
    }
    
    if ( streakinfo.var_efd6634019b55dfd == victim )
    {
        return streakinfo.bundle.var_99eeb0d87d52d7ba;
    }
}

// Namespace skewer_mp
// Params 3
// Checksum 0x967916c4, Offset: 0x1493
// Size: 0xd0
function function_39602c2fe2efb342( targetplayer, targeticon, owner )
{
    objectid = objidpoolmanager::requestobjectiveid( 1 );
    objidpoolmanager::objective_add_objective( objectid, "invisible", targetplayer.origin, targeticon, "icon_small" );
    objidpoolmanager::function_e4d6a71507372662( objectid, 0 );
    objidpoolmanager::objective_playermask_addshowplayer( objectid, owner );
    objective_setbackground( objectid, 0 );
    objective_setplayintro( objectid, 0 );
    objective_state( objectid, "active" );
    objective_disableping( objectid, 1 );
    objective_setownerteam( objectid, targetplayer.team );
    
    if ( isdefined( owner.var_4fd8e1c83e3ff4a6 ) )
    {
        assertmsg( "<dev string:x73>" );
        owner function_4d70988417449205();
    }
    
    owner.var_4fd8e1c83e3ff4a6 = objectid;
}

// Namespace skewer_mp
// Params 0
// Checksum 0x6447f1e4, Offset: 0x156b
// Size: 0x2d
function function_4d70988417449205()
{
    if ( isdefined( self.var_4fd8e1c83e3ff4a6 ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_4fd8e1c83e3ff4a6 );
        
        if ( self )
        {
            self.var_4fd8e1c83e3ff4a6 = undefined;
        }
    }
}

// Namespace skewer_mp
// Params 3
// Checksum 0x8482e464, Offset: 0x15a0
// Size: 0x51
function function_a09d93d7a1405c85( targetplayer, targeticon, targetent )
{
    if ( isdefined( targetplayer.var_4fd8e1c83e3ff4a6 ) )
    {
        objective_icon( targetplayer.var_4fd8e1c83e3ff4a6, targeticon );
        objective_onentity( targetplayer.var_4fd8e1c83e3ff4a6, targetent );
    }
}

/#

    // Namespace skewer_mp
    // Params 2
    // Checksum 0xf7880d45, Offset: 0x15f9
    // Size: 0xae, Type: dev
    function function_7f1e887694bf2e0b( streakinfo, owner )
    {
        bundle = streakinfo.bundle;
        owner waittill( #"weapon_fired" );
        lookatpos = player_utility::getplayerlookatpos( owner );
        destination = getclosestpointonnavmesh( lookatpos );
        spawnlocation = destination + ( 0, 0, bundle.var_6392536ea0a03275 ?? 10000 );
        streakinfo.var_3c18721e40f0f0ad = destination;
        wait bundle.skeweractivationdelay ?? 2;
        function_505ddadd5b410a25( streakinfo, owner, spawnlocation, undefined );
    }

#/
